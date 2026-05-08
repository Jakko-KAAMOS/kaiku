#include "PluginEditor.h"

// ─────────────────────────────────────────────────────────────────────────────
// OperatorPanel
// ─────────────────────────────────────────────────────────────────────────────

static const char* opNames[6] = {
    "F1 CAR",   // ops[0] — vowel body carrier
    "F1 MOD",   // ops[1] — vowel shaper modulator (self-feedback)
    "F2 CAR",   // ops[2] — nasal/upper partial carrier
    "F2 MOD",   // ops[3] — F2 modulator
    "WHEEL CAR",// ops[4] — hurdy wheel texture carrier (detuned)
    "WHEEL MOD" // ops[5] — wheel modulator
};

OperatorPanel::OperatorPanel (int idx,
                               KaikuProcessor& /*proc*/,
                               juce::AudioProcessorValueTreeState& apvts,
                               KaamOSLookAndFeel& laf)
    : opIndex (idx)
{
    auto attach = [&](juce::Slider& s, const juce::String& id)
    {
        s.setLookAndFeel (&laf);
        s.setSliderStyle (juce::Slider::RotaryHorizontalVerticalDrag);
        s.setTextBoxStyle (juce::Slider::TextBoxBelow, false, 40, 14);
        addAndMakeVisible (s);
        atts.push_back (std::make_unique<juce::AudioProcessorValueTreeState::SliderAttachment>
                        (apvts, id, s));
    };

    auto makeId = [&](const char* prefix) {
        return juce::String(prefix) + juce::String(opIndex);
    };

    attach (ratio,     makeId ("ratio_"));
    attach (index,     makeId ("index_"));
    attach (indexPeak, makeId ("idxPeak_"));
    attach (feedback,  makeId ("feedback_"));
    attach (level,     makeId ("level_"));
    attach (attack,    makeId ("attack_"));
    attach (decay,     makeId ("decay_"));
    attach (sustain,   makeId ("sustain_"));
    attach (release,   makeId ("release_"));

    nameLabel.setText (opNames[opIndex], juce::dontSendNotification);
    nameLabel.setJustificationType (juce::Justification::centred);
    nameLabel.setLookAndFeel (&laf);
    addAndMakeVisible (nameLabel);
}

void OperatorPanel::paint (juce::Graphics& g)
{
    // Panel background — carriers slightly brighter than modulators
    g.fillAll (isCarrier()
        ? juce::Colour (0xFF0C0C1A)
        : juce::Colour (0xFF080812));

    // Border — amber for carriers, dim for modulators
    g.setColour (isCarrier()
        ? KaamOSLookAndFeel::amber().withAlpha (0.6f)
        : KaamOSLookAndFeel::dimAmber().withAlpha (0.4f));
    g.drawRect (getLocalBounds().toFloat(), 1.0f);
}

void OperatorPanel::resized()
{
    auto area = getLocalBounds().reduced (4);
    nameLabel.setBounds (area.removeFromTop (16));

    // Top row: ratio, index, indexPeak, feedback
    auto topRow = area.removeFromTop (70);
    int kw = topRow.getWidth() / 4;
    ratio    .setBounds (topRow.removeFromLeft (kw));
    index    .setBounds (topRow.removeFromLeft (kw));
    indexPeak.setBounds (topRow.removeFromLeft (kw));
    feedback .setBounds (topRow);

    // Middle: level (carriers only — wide)
    if (isCarrier())
        level.setBounds (area.removeFromTop (50).reduced (area.getWidth() / 3, 0));

    // Bottom row: ADSR
    auto adsr = area.removeFromTop (65);
    int aw = adsr.getWidth() / 4;
    attack .setBounds (adsr.removeFromLeft (aw));
    decay  .setBounds (adsr.removeFromLeft (aw));
    sustain.setBounds (adsr.removeFromLeft (aw));
    release.setBounds (adsr);
}

// ─────────────────────────────────────────────────────────────────────────────
// KaikuEditor
// ─────────────────────────────────────────────────────────────────────────────

KaikuEditor::KaikuEditor (KaikuProcessor& p)
    : AudioProcessorEditor (&p), processor (p)
{
    setLookAndFeel (&laf);

    // Title
    titleLabel.setText ("KAIKU", juce::dontSendNotification);
    titleLabel.setFont (juce::Font ("Iosevka", 22.0f, juce::Font::plain));
    titleLabel.setColour (juce::Label::textColourId, KaamOSLookAndFeel::amber());
    titleLabel.setJustificationType (juce::Justification::centredLeft);
    addAndMakeVisible (titleLabel);

    // Patch selector
    buildPatchSelector();
    addAndMakeVisible (patchSelector);

    // Master level
    masterLabel.setText ("LEVEL", juce::dontSendNotification);
    masterLabel.setJustificationType (juce::Justification::centred);
    addAndMakeVisible (masterLabel);
    masterSlider.setSliderStyle (juce::Slider::LinearHorizontal);
    masterSlider.setTextBoxStyle (juce::Slider::TextBoxRight, false, 40, 18);
    addAndMakeVisible (masterSlider);
    masterAtt = std::make_unique<juce::AudioProcessorValueTreeState::SliderAttachment>
        (processor.apvts, "masterLevel", masterSlider);

    // Operator panels
    for (int i = 0; i < 6; ++i)
    {
        opPanels[i] = std::make_unique<OperatorPanel> (i, processor, processor.apvts, laf);
        addAndMakeVisible (*opPanels[i]);
    }

    // Trompette
    trompetteLabel.setText ("TROMPETTE", juce::dontSendNotification);
    trompetteLabel.setJustificationType (juce::Justification::centred);
    addAndMakeVisible (trompetteLabel);
    trompetteLevel.setSliderStyle (juce::Slider::LinearHorizontal);
    trompetteLevel.setTextBoxStyle (juce::Slider::TextBoxRight, false, 40, 18);
    addAndMakeVisible (trompetteLevel);
    trompLvlAtt = std::make_unique<juce::AudioProcessorValueTreeState::SliderAttachment>
        (processor.apvts, "trompetteLevel", trompetteLevel);

    trompetteThresh.setSliderStyle (juce::Slider::LinearHorizontal);
    trompetteThresh.setTextBoxStyle (juce::Slider::TextBoxRight, false, 40, 18);
    addAndMakeVisible (trompetteThresh);
    trompThAtt = std::make_unique<juce::AudioProcessorValueTreeState::SliderAttachment>
        (processor.apvts, "trompetteThresh", trompetteThresh);

    // Status
    statusLabel.setJustificationType (juce::Justification::centredRight);
    addAndMakeVisible (statusLabel);

    startTime = juce::Time::getMillisecondCounterHiRes() * 0.001;
    startTimerHz (30);
    setSize (920, 620);   // must be last — triggers resized() immediately
}

KaikuEditor::~KaikuEditor()
{
    stopTimer();
    setLookAndFeel (nullptr);
}

void KaikuEditor::buildPatchSelector()
{
    patchSelector.clear();
    for (int i = 0; i < processor.getNumPrograms(); ++i)
        patchSelector.addItem (processor.getProgramName(i), i + 1);
    patchSelector.setSelectedId (processor.getCurrentProgram() + 1,
                                 juce::dontSendNotification);
    patchSelector.onChange = [this]()
    {
        processor.setCurrentProgram (patchSelector.getSelectedId() - 1);
    };
}

void KaikuEditor::timerCallback()
{
    double t = juce::Time::getMillisecondCounterHiRes() * 0.001 - startTime;
    float pulse = KaamOSLookAndFeel::hiljaisuusPulse (t);

    // Pulse the status indicator in void-violet
    statusLabel.setColour (juce::Label::textColourId,
        KaamOSLookAndFeel::hiljaisuus().withAlpha (0.4f + 0.6f * pulse));
    statusLabel.setText (juce::String::fromUTF8("● HILJAISUUS"),
                         juce::dontSendNotification);
    repaint (getLocalBounds().removeFromBottom (20));
}

void KaikuEditor::paint (juce::Graphics& g)
{
    g.fillAll (KaamOSLookAndFeel::voidBlack());

    // Hex grid background — dim
    KaamOSLookAndFeel::drawHexGrid (g, getLocalBounds().toFloat(),
                                    20.0f, juce::Colour (0xFF0D0D1F));

    // Operator stack labels
    auto f = laf.getLabelFont (titleLabel);
    g.setFont (f.withHeight (10.0f));
    g.setColour (KaamOSLookAndFeel::dimAmber());
    int opW = (getWidth() - 20) / 3;
    g.drawText ("STACK 0 — F1 FORMANT", 10,          52, opW, 14,
                juce::Justification::centred);
    g.drawText ("STACK 1 — F2 FORMANT", 10 + opW,    52, opW, 14,
                juce::Justification::centred);
    g.drawText ("STACK 2 — WHEEL",      10 + opW * 2, 52, opW, 14,
                juce::Justification::centred);

    // Footer lore line
    g.setColour (KaamOSLookAndFeel::inactive().brighter (0.3f));
    g.setFont (f.withHeight (9.5f));
    g.drawText (juce::String::fromUTF8(
        "Tyhjyydenkaiku  —  echo of the void  —  kaamos  —  v0.1"),
        0, getHeight() - 16, getWidth(), 14,
        juce::Justification::centred);
}

void KaikuEditor::resized()
{
    auto area = getLocalBounds().reduced (10);

    // Header: 40px
    auto header = area.removeFromTop (40);
    titleLabel    .setBounds (header.removeFromLeft (120));
    masterLabel   .setBounds (header.removeFromLeft (50));
    masterSlider  .setBounds (header.removeFromLeft (160));
    header.removeFromLeft (10);
    patchSelector .setBounds (header.removeFromLeft (180).reduced (0, 6));

    area.removeFromTop (28);  // stack labels

    // Operator grid: 3 stacks × 2 rows (modulator top, carrier bottom)
    int opW  = area.getWidth()  / 3;
    int opH  = (area.getHeight() - 80) / 2;  // 80px reserved for trompette/status

    // Stack layout:
    //   Row 0 (top):    ops[1] ops[3] ops[5]  — modulators
    //   Row 1 (bottom): ops[0] ops[2] ops[4]  — carriers
    // (modulator drives carrier below it — visual arrow implied)

    int modRow = area.getY();
    int carRow = area.getY() + opH + 4;

    int stackOrder[3][2] = {{1,0}, {3,2}, {5,4}};  // {mod, car} per stack
    for (int s = 0; s < 3; ++s)
    {
        int x = area.getX() + s * opW;
        opPanels[stackOrder[s][0]]->setBounds (x, modRow, opW - 4, opH);
        opPanels[stackOrder[s][1]]->setBounds (x, carRow, opW - 4, opH);
    }

    // Trompette strip
    auto tromp = area.removeFromBottom (50);
    trompetteLabel  .setBounds (tromp.removeFromLeft (100));
    trompetteLevel  .setBounds (tromp.removeFromLeft (200));
    tromp.removeFromLeft (20);
    trompetteThresh .setBounds (tromp.removeFromLeft (200));

    // Status
    statusLabel.setBounds (getLocalBounds().removeFromBottom (18)
                                            .removeFromRight (200));
}

juce::AudioProcessorEditor* KaikuProcessor::createEditor()
{
    return new KaikuEditor (*this);
}
