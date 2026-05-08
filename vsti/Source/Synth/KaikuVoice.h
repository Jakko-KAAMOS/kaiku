#pragma once
#include "FM/FMEngine.h"

// ─────────────────────────────────────────────────────────────────────────────
// KaikuVoice — one polyphonic voice
//
// Wraps FMEngine with MIDI note tracking and velocity scaling.
// VoiceManager allocates/steals voices.
//
// Voice architecture:
//   - Primary: FMEngine (Tyhjyydenkaiku FM synthesis)
//   - Trompette layer: secondary FMEngine, triggered by velocity > threshold
//     or aftertouch. High index, short decay. The bark on accented notes.
//     (see timbre_brief.md — Layer C)
// ─────────────────────────────────────────────────────────────────────────────

class KaikuVoice
{
public:
    static constexpr float TROMPETTE_VELOCITY_THRESHOLD = 0.70f;  // 0-1

    void prepare (double sampleRate);
    void applyPatch (const FMPatch& patch);

    void noteOn  (int midiNote, float velocity);
    void noteOff ();
    void reset   ();

    bool isActive () const;
    bool isReleasing () const;
    int  getMidiNote () const { return currentNote; }

    // Returns one stereo sample pair (left, right)
    // For now: mono (L == R). Stereo spread via VoiceManager.
    void processSample (float& left, float& right);

    // Trompette parameters (tweakable via preset)
    float trompetteLevel = 0.15f;  // -16dB relative to primary
    float trompetteDecayMs = 80.0f;

private:
    double sampleRate  = 44100.0;
    int    currentNote = -1;
    float  noteVelocity = 0.0f;
    bool   trompetteActive = false;

    FMEngine primary;
    FMEngine trompette;

    void configureTrompette();
};
