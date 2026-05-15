#include "KaikuVoice.h"
#include <cmath>

static float midiNoteToHz (int note)
{
    return 440.0f * std::pow (2.0f, (note - 69) / 12.0f);
}

void KaikuVoice::prepare (double sr)
{
    sampleRate = sr;
    primary.prepare (sr);
    trompette.prepare (sr);
    configureTrompette();
}

void KaikuVoice::applyPatch (const FMPatch& patch)
{
    primary.applyPatch (patch);
    trompetteLevel  = patch.trompetteLevel;
    trompetteThresh = patch.trompetteThresh;
    // Trompette patch is fixed — it's not a user preset, it's instrument physics
    configureTrompette();
}

void KaikuVoice::configureTrompette()
{
    // Trompette: single stack, high index, pure transient — no sustain
    // From timbre_brief.md Layer C:
    //   ratio 1:1, index 6.5, A:0ms D:80ms S:0% R:40ms
    //   Fixed pitch (root) — the trompette doesn't track pitch, it buzzes at resonance
    FMPatch tp;
    tp.ops[0] = { .ratio=1.0f, .level=1.0f,
                  .attackMs=0.5f, .decayMs=trompetteDecayMs,
                  .sustainLevel=0.0f, .releaseMs=40.0f };
    tp.ops[1] = { .ratio=1.0f, .index=6.5f, .indexPeak=6.5f,
                  .attackMs=0.5f, .decayMs=trompetteDecayMs,
                  .sustainLevel=0.0f, .releaseMs=40.0f };
    // Silence all other stacks
    tp.ops[2].level = 0.0f;
    tp.ops[3].level = 0.0f;
    tp.ops[4].level = 0.0f;
    tp.ops[5].level = 0.0f;

    trompette.applyPatch (tp);
}

void KaikuVoice::noteOn (int midiNote, float velocity)
{
    currentNote    = midiNote;
    noteVelocity   = velocity;
    float hz       = midiNoteToHz (midiNote);

    primary.noteOn (hz, velocity);

    // Trompette fires on accented notes only
    trompetteActive = (velocity >= trompetteThresh);
    if (trompetteActive)
        trompette.noteOn (hz, velocity);
}

void KaikuVoice::noteOff()
{
    primary.noteOff();
    trompette.noteOff();
}

void KaikuVoice::reset()
{
    currentNote = -1;
    primary.reset();
    trompette.reset();
    trompetteActive = false;
}

bool KaikuVoice::isActive() const
{
    return primary.isActive();
}

bool KaikuVoice::isReleasing() const
{
    // True if all carriers are in release stage — voice can be stolen
    for (int i = 0; i < FMEngine::NUM_OPS; i += 2)
        if (primary.ops[i].envelope.getStage() == Envelope::Stage::Sustain)
            return false;
    return primary.isActive();
}

void KaikuVoice::processSample (float& left, float& right)
{
    float s = primary.processSample();

    if (trompetteActive && trompette.isActive())
        s += trompette.processSample() * trompetteLevel;

    left  = s;
    right = s;
}
