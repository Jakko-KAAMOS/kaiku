#pragma once
#include "KaikuVoice.h"
#include <array>

// ─────────────────────────────────────────────────────────────────────────────
// VoiceManager — polyphonic voice allocator
//
// 16 voices. Steal policy: steal the oldest releasing voice first,
// then the oldest active voice. The Silence doesn't care about priorities.
// ─────────────────────────────────────────────────────────────────────────────

class VoiceManager
{
public:
    static constexpr int MAX_VOICES = 16;

    void prepare   (double sampleRate);
    void applyPatch (const FMPatch& patch);

    void noteOn    (int midiNote, float velocity);
    void noteOff   (int midiNote);
    void allNotesOff();

    // Fills buffer with interleaved stereo samples
    void processBlock (float* left, float* right, int numSamples);

private:
    std::array<KaikuVoice, MAX_VOICES> voices;
    int  voiceAge[MAX_VOICES] = {};   // Higher = older
    int  ageCounter = 0;

    int  findFreeVoice();
    int  stealVoice();
    int  findVoiceForNote (int midiNote);
};
