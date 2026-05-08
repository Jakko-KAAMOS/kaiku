#pragma once
#include <juce_audio_processors/juce_audio_processors.h>
#include "PluginProcessor.h"
#include "GUI/KaamOSLookAndFeel.h"

// ─────────────────────────────────────────────────────────────────────────────
// KaikuEditor — GUI
//
// Layout: terminal-first. The GUI looks like the game's map.
// Amber on void black. Hex motifs. No gradients. No rounded corners.
//
// Panels:
//   [HEADER]     — "KAIKU" + patch selector + master level
//   [OP GRID]    — 6 operators, 3 columns (stacks), 2 rows (mod/car)
//                  Each operator: ratio, index, index peak, A/D/S/R, level
//   [TROMPETTE]  — trompette level + velocity threshold
//   [STATUS]     — voice count, Hiljaisuus pulse indicator
//   [FOOTER]     — patch name + version + lore line
//
// The Hiljaisuus pulse is in the status bar.
// It pulses at 0.15Hz in void-violet.
// The Silence is always there.
// ─────────────────────────────────────────────────────────────────────────────

class OperatorPanel;

class KaikuEditor : public juce::AudioProcessorEditor,
                    private juce::Timer
{
public:
    explicit KaikuEditor (KaikuProcessor&);
    ~KaikuEditor() override;

    void paint   (juce::Graphics&) override;
    void resized () override;

private:
    KaikuProcessor& processor;
    KaamOSLookAndFeel laf;

    // ── Header ────────────────────────────────────────────────────────────────
    juce::Label      titleLabel;
    juce::ComboBox   patchSelector;
    juce::Slider     masterSlider;
    juce::Label      masterLabel;

    // ── Operator panels (6) ───────────────────────────────────────────────────
    std::array<std::unique_ptr<OperatorPanel>, 6> opPanels;

    // ── Trompette section ─────────────────────────────────────────────────────
    juce::Slider trompetteLevel;
    juce::Slider trompetteThresh;
    juce::Label  trompetteLabel;

    // ── Status bar ────────────────────────────────────────────────────────────
    juce::Label  statusLabel;
    double       startTime = 0.0;

    // ── APVTS attachments ─────────────────────────────────────────────────────
    std::unique_ptr<juce::AudioProcessorValueTreeState::SliderAttachment> masterAtt;
    std::unique_ptr<juce::AudioProcessorValueTreeState::SliderAttachment> trompLvlAtt;
    std::unique_ptr<juce::AudioProcessorValueTreeState::SliderAttachment> trompThAtt;
    std::unique_ptr<juce::AudioProcessorValueTreeState::ComboBoxAttachment> patchAtt;

    void timerCallback() override;
    void buildPatchSelector();
    void layoutOpPanels (juce::Rectangle<int> area);

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (KaikuEditor)
};

// ─────────────────────────────────────────────────────────────────────────────
// OperatorPanel — one operator's controls
// ─────────────────────────────────────────────────────────────────────────────
class OperatorPanel : public juce::Component
{
public:
    OperatorPanel (int opIndex,
                   KaikuProcessor& proc,
                   juce::AudioProcessorValueTreeState& apvts,
                   KaamOSLookAndFeel& laf);

    void paint   (juce::Graphics&) override;
    void resized () override;

    bool isCarrier() const { return (opIndex % 2 == 0); }

private:
    int opIndex;

    juce::Slider ratio, index, indexPeak, feedback, level;
    juce::Slider attack, decay, sustain, release;
    juce::Label  nameLabel;

    std::vector<std::unique_ptr<juce::AudioProcessorValueTreeState::SliderAttachment>> atts;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (OperatorPanel)
};
