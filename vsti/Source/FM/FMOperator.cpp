#include "FMOperator.h"
#include <cmath>
#include <algorithm>

// ─────────────────────────────────────────────────────────────────────────────
// Envelope
// ─────────────────────────────────────────────────────────────────────────────

void Envelope::prepare (double sr)
{
    sampleRate = sr;
    reset();
}

float Envelope::calcCoeff (float ms, float targetRatio) const
{
    if (ms < 0.001f) return 0.0f;
    float samples = (float)(sampleRate * ms * 0.001);
    return (float)std::exp (-std::log ((1.0f + targetRatio) / targetRatio) / samples);
}

void Envelope::setAttack  (float ms) { attackCoeff  = calcCoeff (ms, 0.0001f); }
void Envelope::setDecay   (float ms) { decayCoeff   = calcCoeff (ms, 0.0001f); }
void Envelope::setSustain (float lv) { sustainLevel = std::clamp (lv, 0.0f, 1.0f); }
void Envelope::setRelease (float ms) { releaseCoeff = calcCoeff (ms, 0.0001f); }

void Envelope::noteOn()
{
    stage = Stage::Attack;
}

void Envelope::noteOff()
{
    if (stage != Stage::Idle)
        stage = Stage::Release;
}

void Envelope::reset()
{
    stage  = Stage::Idle;
    output = 0.0f;
}

float Envelope::process()
{
    switch (stage)
    {
        case Stage::Attack:
            output = 1.0f - attackCoeff + attackCoeff * output;
            if (output >= 1.0f) { output = 1.0f; stage = Stage::Decay; }
            break;

        case Stage::Decay:
            output = sustainLevel + decayCoeff * (output - sustainLevel);
            if (output <= sustainLevel + 0.0001f) { output = sustainLevel; stage = Stage::Sustain; }
            break;

        case Stage::Sustain:
            output = sustainLevel;
            break;

        case Stage::Release:
            output = releaseCoeff * output;
            if (output < 0.00001f) { output = 0.0f; stage = Stage::Idle; }
            break;

        case Stage::Idle:
        default:
            output = 0.0f;
            break;
    }
    return output;
}

// ─────────────────────────────────────────────────────────────────────────────
// FMOperator
// ─────────────────────────────────────────────────────────────────────────────

void FMOperator::prepare (double sr)
{
    sampleRate = sr;
    envelope.prepare (sr);
    reset();

    // Precompute index decay coefficient
    if (indexDecayMs > 0.001f)
        indexDecayCoeff = (float)std::exp (-1.0 / (sr * indexDecayMs * 0.001));
    else
        indexDecayCoeff = 0.0f;
}

void FMOperator::noteOn (float frequencyHz)
{
    // Frequency: use fixed if set, otherwise ratio * fundamental
    double freq = (fixedFreq > 0.0f)
                    ? (double)fixedFreq
                    : (double)frequencyHz * (double)ratio + (double)detuneHz;

    phaseIncrement = TWO_PI * freq / sampleRate;
    currentIndex   = indexPeak;  // Start at peak (consonant onset)

    envelope.noteOn();
    lastOutput = 0.0f;
}

void FMOperator::noteOff()
{
    envelope.noteOff();
}

void FMOperator::reset()
{
    phase        = 0.0;
    lastOutput   = 0.0f;
    currentIndex = index;
    envelope.reset();
}

bool FMOperator::isActive() const
{
    return envelope.isActive();
}

float FMOperator::process (float modInput)
{
    // Smooth index from peak toward sustain value
    currentIndex = index + indexDecayCoeff * (currentIndex - index);

    // Self-feedback (Op[1] only — adds vocal tract roughness)
    float fbInput = feedback * lastOutput;

    // Phase modulation: carrier phase displaced by modulator output
    double modulatedPhase = phase + (double)(modInput + fbInput) * (double)currentIndex;

    // Synthesize
    float output = (float)std::sin (modulatedPhase) * envelope.process() * level;

    // Advance phase
    phase += phaseIncrement;
    if (phase > TWO_PI * 1000.0) phase -= TWO_PI * 1000.0;  // prevent denormals

    lastOutput = output;
    return output;
}
