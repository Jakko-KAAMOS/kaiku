#include "PluginProcessor.h"
#include "PluginEditor.h"

// ─────────────────────────────────────────────────────────────────────────────
// Parameter IDs — all automatable parameters
// Named after the instrument's vocabulary, not generic synth terms.
// ─────────────────────────────────────────────────────────────────────────────

namespace ParamID
{
    // Per-operator parameters — suffix _0 through _5
    // e.g. "ratio_0", "index_1", "level_2"
    static juce::String ratio        (int op) { return "ratio_"     + juce::String(op); }
    static juce::String index        (int op) { return "index_"     + juce::String(op); }
    static juce::String indexPeak    (int op) { return "idxPeak_"   + juce::String(op); }
    static juce::String indexDecay   (int op) { return "idxDecay_"  + juce::String(op); }
    static juce::String level        (int op) { return "level_"     + juce::String(op); }
    static juce::String feedback     (int op) { return "feedback_"  + juce::String(op); }
    static juce::String attack       (int op) { return "attack_"    + juce::String(op); }
    static juce::String decay        (int op) { return "decay_"     + juce::String(op); }
    static juce::String sustain      (int op) { return "sustain_"   + juce::String(op); }
    static juce::String release      (int op) { return "release_"   + juce::String(op); }

    // Voice / global
    static const char* MASTER_LEVEL     = "masterLevel";
    static const char* TROMPETTE_LEVEL  = "trompetteLevel";
    static const char* TROMPETTE_THRESH = "trompetteThresh";
}

// ─────────────────────────────────────────────────────────────────────────────

juce::AudioProcessorValueTreeState::ParameterLayout KaikuProcessor::createParameterLayout()
{
    juce::AudioProcessorValueTreeState::ParameterLayout layout;

    auto pct  = juce::NormalisableRange<float> (0.0f, 1.0f, 0.001f);
    auto ratR = juce::NormalisableRange<float> (0.25f, 8.0f, 0.001f, 0.5f);
    auto idxR = juce::NormalisableRange<float> (0.0f, 10.0f, 0.01f, 0.5f);
    auto msR  = juce::NormalisableRange<float> (0.5f, 5000.0f, 0.5f, 0.3f);

    for (int op = 0; op < 6; ++op)
    {
        bool isMod = (op % 2 == 1);
        juce::String opLabel = "Op" + juce::String(op) + " ";

        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::ratio(op),     opLabel + "Ratio",   ratR,  1.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::index(op),     opLabel + "Index",   idxR,  isMod ? 1.5f : 0.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::indexPeak(op), opLabel + "IdxPeak", idxR,  isMod ? 2.5f : 0.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::indexDecay(op),opLabel + "IdxDcy",  msR,   60.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::level(op),     opLabel + "Level",   pct,   isMod ? 0.0f : 0.8f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::feedback(op),  opLabel + "Fdbk",    pct,   0.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::attack(op),    opLabel + "A",       msR,   5.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::decay(op),     opLabel + "D",       msR,   80.0f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::sustain(op),   opLabel + "S",       pct,   0.8f));
        layout.add (std::make_unique<juce::AudioParameterFloat>
            (ParamID::release(op),   opLabel + "R",       msR,   200.0f));
    }

    layout.add (std::make_unique<juce::AudioParameterFloat>
        (ParamID::MASTER_LEVEL,    "Master Level",      pct,    0.25f));
    layout.add (std::make_unique<juce::AudioParameterFloat>
        (ParamID::TROMPETTE_LEVEL, "Trompette Level",   pct,    0.15f));
    layout.add (std::make_unique<juce::AudioParameterFloat>
        (ParamID::TROMPETTE_THRESH,"Trompette Thresh",  pct,    0.70f));

    return layout;
}

// ─────────────────────────────────────────────────────────────────────────────

KaikuProcessor::KaikuProcessor()
    : AudioProcessor (BusesProperties()
          .withOutput ("Output", juce::AudioChannelSet::stereo(), true)),
      apvts (*this, nullptr, "KaikuState", createParameterLayout())
{
    buildPatchList();
}

void KaikuProcessor::buildPatchList()
{
    patches.clear();
    patches.push_back (FMPatch::makeTyhjyydenkaiku());
    patches.push_back (FMPatch::makeKuilunsikio());
    patches.push_back (FMPatch::makePohjankaiku());
    patches.push_back (FMPatch::makeKuilukaiku());
}

void KaikuProcessor::prepareToPlay (double sr, int /*blockSize*/)
{
    voiceManager.prepare (sr);
    setCurrentProgram (currentPatch);
}

void KaikuProcessor::setCurrentProgram (int index)
{
    if (index >= 0 && index < (int)patches.size())
    {
        currentPatch = index;
        const FMPatch& p = patches[(size_t)index];

        // Push preset values into the APVTS so patchFromAPVTS() picks them up
        // next block and the knobs reflect the loaded preset.
        for (int op = 0; op < 6; ++op)
        {
            const auto& o = p.ops[op];
            auto set = [&](const juce::String& id, float v) {
                if (auto* param = apvts.getParameter (id))
                    param->setValueNotifyingHost (param->convertTo0to1 (v));
            };
            set (ParamID::ratio     (op), o.ratio);
            set (ParamID::index     (op), o.index);
            set (ParamID::indexPeak (op), o.indexPeak);
            set (ParamID::indexDecay(op), o.indexDecayMs);
            set (ParamID::level     (op), o.level);
            set (ParamID::feedback  (op), o.feedback);
            set (ParamID::attack    (op), o.attackMs);
            set (ParamID::decay     (op), o.decayMs);
            set (ParamID::sustain   (op), o.sustainLevel);
            set (ParamID::release   (op), o.releaseMs);
        }
    }
}

const juce::String KaikuProcessor::getProgramName (int index)
{
    if (index >= 0 && index < (int)patches.size())
        return patches[(size_t)index].name;
    return {};
}

void KaikuProcessor::handleMidi (const juce::MidiMessage& msg)
{
    if (msg.isNoteOn())
        voiceManager.noteOn (msg.getNoteNumber(), msg.getVelocity() / 127.0f);
    else if (msg.isNoteOff())
        voiceManager.noteOff (msg.getNoteNumber());
    else if (msg.isAllNotesOff() || msg.isAllSoundOff())
        voiceManager.allNotesOff();
}

FMPatch KaikuProcessor::patchFromAPVTS() const
{
    FMPatch p;
    for (int op = 0; op < 6; ++op)
    {
        auto& o = p.ops[op];
        o.ratio        = apvts.getRawParameterValue (ParamID::ratio     (op))->load();
        o.index        = apvts.getRawParameterValue (ParamID::index     (op))->load();
        o.indexPeak    = apvts.getRawParameterValue (ParamID::indexPeak (op))->load();
        o.indexDecayMs = apvts.getRawParameterValue (ParamID::indexDecay(op))->load();
        o.level        = apvts.getRawParameterValue (ParamID::level     (op))->load();
        o.feedback     = apvts.getRawParameterValue (ParamID::feedback  (op))->load();
        o.attackMs     = apvts.getRawParameterValue (ParamID::attack    (op))->load();
        o.decayMs      = apvts.getRawParameterValue (ParamID::decay     (op))->load();
        o.sustainLevel = apvts.getRawParameterValue (ParamID::sustain   (op))->load();
        o.releaseMs    = apvts.getRawParameterValue (ParamID::release   (op))->load();
    }
    return p;
}

void KaikuProcessor::processBlock (juce::AudioBuffer<float>& buffer,
                                    juce::MidiBuffer& midiMessages)
{
    juce::ScopedNoDenormals noDenormals;
    buffer.clear();

    voiceManager.applyPatch (patchFromAPVTS());

    // Process MIDI events in order
    int samplePos = 0;
    for (const auto metadata : midiMessages)
    {
        int eventPos = metadata.samplePosition;
        if (eventPos > samplePos)
        {
            voiceManager.processBlock (
                buffer.getWritePointer (0) + samplePos,
                buffer.getWritePointer (1) + samplePos,
                eventPos - samplePos);
            samplePos = eventPos;
        }
        handleMidi (metadata.getMessage());
    }

    // Remaining samples after last MIDI event
    int remaining = buffer.getNumSamples() - samplePos;
    if (remaining > 0)
    {
        voiceManager.processBlock (
            buffer.getWritePointer (0) + samplePos,
            buffer.getWritePointer (1) + samplePos,
            remaining);
    }

    // Apply master level
    float masterLevel = apvts.getRawParameterValue (ParamID::MASTER_LEVEL)->load();
    buffer.applyGain (masterLevel);
}

void KaikuProcessor::getStateInformation (juce::MemoryBlock& destData)
{
    auto state = apvts.copyState();
    state.setProperty ("currentPatch", currentPatch, nullptr);
    std::unique_ptr<juce::XmlElement> xml (state.createXml());
    copyXmlToBinary (*xml, destData);
}

void KaikuProcessor::setStateInformation (const void* data, int sizeInBytes)
{
    std::unique_ptr<juce::XmlElement> xml (getXmlFromBinary (data, sizeInBytes));
    if (xml && xml->hasTagName (apvts.state.getType()))
    {
        apvts.replaceState (juce::ValueTree::fromXml (*xml));
        currentPatch = (int)apvts.state.getProperty ("currentPatch", 0);
        setCurrentProgram (currentPatch);
    }
}

juce::AudioProcessor* JUCE_CALLTYPE createPluginFilter()
{
    return new KaikuProcessor();
}
