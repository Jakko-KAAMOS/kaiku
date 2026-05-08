#pragma once
#include <cmath>
#include <algorithm>

// ─────────────────────────────────────────────────────────────────────────────
// Envelope — ADSR with sample-accurate coefficients
// ─────────────────────────────────────────────────────────────────────────────

class Envelope
{
public:
    enum class Stage { Idle, Attack, Decay, Sustain, Release };

    void prepare (double sampleRate);

    // Times in milliseconds, sustain in [0,1]
    void setAttack   (float ms);
    void setDecay    (float ms);
    void setSustain  (float level);
    void setRelease  (float ms);

    void noteOn();
    void noteOff();
    void reset();

    float process();
    bool  isActive() const { return stage != Stage::Idle; }
    Stage getStage() const { return stage; }

private:
    double sampleRate = 44100.0;
    Stage  stage      = Stage::Idle;
    float  output     = 0.0f;
    float  sustainLevel = 0.8f;

    // Coefficients — multiplicative (log domain) for smooth curves
    float attackCoeff  = 0.0f;
    float decayCoeff   = 0.0f;
    float releaseCoeff = 0.0f;

    float calcCoeff (float ms, float targetRatio) const;
};

// ─────────────────────────────────────────────────────────────────────────────
// FMOperator — one operator in the 6-op Tyhjyydenkaiku engine
//
// Architecture (3 parallel modulator→carrier stacks, summed to output):
//
//   Op[1] ──► Op[0] ──► OUT    F1 formant stack  (mouth / vowel body)
//   Op[3] ──► Op[2] ──► OUT    F2 formant stack  (nasal / upper partials)
//   Op[5] ──► Op[4] ──► OUT    Breath/wheel stack (hurdy texture)
//
// Modulators (odd indices) drive carriers (even indices).
// Carriers sum to audio output.
// Op[1] has self-feedback (configurable) — adds vocal roughness.
// ─────────────────────────────────────────────────────────────────────────────

class FMOperator
{
public:
    // ── Parameters (set by preset / automation) ───────────────────────────────

    float ratio         = 1.0f;   // Frequency ratio relative to note fundamental
    float fixedFreq     = 0.0f;   // If > 0, use this Hz instead of ratio (for drones)

    float index         = 1.0f;   // FM modulation index (sustain value)
    float indexPeak     = 1.0f;   // Index at note onset (consonant transient)
                                  // Decays toward `index` over indexDecayMs
    float indexDecayMs  = 60.0f;  // How fast the index settles from peak to sustain

    float level         = 1.0f;   // Output level [0,1] — carriers only
    float feedback      = 0.0f;   // Self-feedback [0,1] — Op[1] only (vocal roughness)
    float detuneHz      = 0.0f;   // Fine detune in Hz (hurdy string imperfection)

    bool  isCarrier     = false;  // If true, contributes to audio output sum

    Envelope envelope;

    // ── Lifecycle ─────────────────────────────────────────────────────────────
    void prepare   (double sampleRate);
    void noteOn    (float frequencyHz);
    void noteOff   ();
    void reset     ();
    bool isActive  () const;

    // ── Per-sample process ────────────────────────────────────────────────────
    // modInput: output of paired modulator operator (or 0 for modulators with no input)
    // Returns: this operator's output (phase-modulated sine)
    float process (float modInput);

    float getLastOutput() const { return lastOutput; }

private:
    double sampleRate      = 44100.0;
    double phase           = 0.0;
    double phaseIncrement  = 0.0;

    float  lastOutput      = 0.0f;   // For feedback calculation
    float  currentIndex    = 1.0f;   // Smoothed index (tracks from peak toward index)
    float  indexDecayCoeff = 0.0f;   // Per-sample multiplier for index decay

    static constexpr double TWO_PI = 6.283185307179586;
};
