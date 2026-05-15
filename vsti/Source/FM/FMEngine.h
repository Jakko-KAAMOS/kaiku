#pragma once
#include "FMOperator.h"
#include <string>

// ─────────────────────────────────────────────────────────────────────────────
// FMEngine — 6-operator FM engine for Tyhjyydenkaiku
//
// Fixed algorithm: 3 parallel modulator→carrier stacks
//
//   ops[1] ──► ops[0] ──► OUT    F1 stack: vowel body / mouth formant
//   ops[3] ──► ops[2] ──► OUT    F2 stack: nasal / upper partial
//   ops[5] ──► ops[4] ──► OUT    Breath/wheel stack: hurdy texture
//
// ops[0], ops[2], ops[4] are carriers (isCarrier = true)
// ops[1], ops[3], ops[5] are modulators
// ops[1] has configurable self-feedback (vocal roughness, ~0.15-0.25)
//
// Patch presets (see PresetManager):
//   Tyhjyydenkaiku   — primary: F1/F2 formants balanced, wheel texture present
//   Kuilunsikiö      — visceral: high modulation indices, trompette forward
//   Pohjankaiku      — warm: Mellotron-body texture, FM recessed
//   Kuilukaiku       — stripped: minimal, dry, stark
// ─────────────────────────────────────────────────────────────────────────────

struct FMPatch
{
    // One entry per operator [0..5]
    struct OpParams
    {
        float ratio        = 1.0f;
        float index        = 1.0f;
        float indexPeak    = 1.0f;
        float indexDecayMs = 60.0f;
        float level        = 1.0f;
        float feedback     = 0.0f;
        float detuneHz     = 0.0f;
        float attackMs     = 5.0f;
        float decayMs      = 80.0f;
        float sustainLevel = 0.8f;
        float releaseMs    = 200.0f;
    };

    OpParams ops[6];
    float    masterLevel      = 0.8f;
    float    detuneAmount     = 8.0f;   // Hz of detune on ops[2] (second hurdy string)
    float    trompetteLevel  = 0.15f; // Level of trompette layer relative to primary
    float    trompetteThresh = 0.70f; // Velocity threshold [0,1] for trompette trigger
    std::string name;

    static FMPatch makeTyhjyydenkaiku();
    static FMPatch makeKuilunsikio();
    static FMPatch makePohjankaiku();
    static FMPatch makeKuilukaiku();
};

class FMEngine
{
public:
    static constexpr int NUM_OPS = 6;

    void prepare   (double sampleRate);
    void noteOn    (float frequencyHz, float velocity);
    void noteOff   ();
    void reset     ();
    bool isActive  () const;

    void applyPatch (const FMPatch& patch);

    // Returns one sample of audio output
    float processSample();

    FMOperator ops[NUM_OPS];

private:
    double sampleRate = 44100.0;
    float  velocity   = 1.0f;
    float  fundamental = 440.0f;
};
