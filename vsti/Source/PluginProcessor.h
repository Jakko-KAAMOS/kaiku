#pragma once
#include <juce_audio_processors/juce_audio_processors.h>
#include "Synth/VoiceManager.h"
#include "FM/FMEngine.h"

// ─────────────────────────────────────────────────────────────────────────────
// KaikuProcessor — VST3/AU audio plugin processor
//
// Target: REAPER on Linux (primary), REAPER on macOS/ARM64 (stretch)
// Format: VST3 (primary), AU (stretch), CLAP (future — see notes)
//
// Audio engine: VoiceManager → 16× KaikuVoice → FMEngine (6 operators)
// MIDI: standard note on/off, velocity, aftertouch (trompette trigger)
// Parameters: exposed via APVTS for DAW automation
// ─────────────────────────────────────────────────────────────────────────────

class KaikuProcessor : public juce::AudioProcessor
{
public:
    KaikuProcessor();
    ~KaikuProcessor() override = default;

    // ── AudioProcessor interface ──────────────────────────────────────────────
    void prepareToPlay (double sampleRate, int samplesPerBlock) override;
    void releaseResources() override {}
    void processBlock (juce::AudioBuffer<float>&, juce::MidiBuffer&) override;

    juce::AudioProcessorEditor* createEditor() override;
    bool hasEditor() const override { return true; }

    const juce::String getName() const override { return "Kaiku"; }
    bool   acceptsMidi()  const override { return true; }
    bool   producesMidi() const override { return false; }
    bool   isMidiEffect() const override { return false; }
    double getTailLengthSeconds() const override { return 2.0; }

    int  getNumPrograms()    override { return (int)patches.size(); }
    int  getCurrentProgram() override { return currentPatch; }
    void setCurrentProgram (int index) override;
    const juce::String getProgramName (int index) override;
    void changeProgramName (int, const juce::String&) override {}

    void getStateInformation (juce::MemoryBlock& destData) override;
    void setStateInformation (const void* data, int sizeInBytes) override;

    // ── Parameter layout ─────────────────────────────────────────────────────
    static juce::AudioProcessorValueTreeState::ParameterLayout createParameterLayout();
    juce::AudioProcessorValueTreeState apvts;

private:
    VoiceManager voiceManager;

    std::vector<FMPatch> patches;
    int currentPatch = 0;

    void buildPatchList();
    void handleMidi (const juce::MidiMessage& msg);

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (KaikuProcessor)
};
