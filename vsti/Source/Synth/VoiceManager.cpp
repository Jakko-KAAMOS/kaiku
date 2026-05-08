#include "VoiceManager.h"
#include <algorithm>

void VoiceManager::prepare (double sr)
{
    for (auto& v : voices) v.prepare (sr);
}

void VoiceManager::applyPatch (const FMPatch& patch)
{
    for (auto& v : voices) v.applyPatch (patch);
}

void VoiceManager::noteOn (int midiNote, float velocity)
{
    // If note already playing, retrigger it
    int idx = findVoiceForNote (midiNote);
    if (idx < 0) idx = findFreeVoice();
    if (idx < 0) idx = stealVoice();
    if (idx < 0) return;

    voiceAge[idx] = ageCounter++;
    voices[idx].noteOn (midiNote, velocity);
}

void VoiceManager::noteOff (int midiNote)
{
    int idx = findVoiceForNote (midiNote);
    if (idx >= 0) voices[idx].noteOff();
}

void VoiceManager::allNotesOff()
{
    for (auto& v : voices) v.noteOff();
}

void VoiceManager::processBlock (float* left, float* right, int numSamples)
{
    // Zero buffers
    for (int i = 0; i < numSamples; ++i)
        left[i] = right[i] = 0.0f;

    for (auto& v : voices)
    {
        if (!v.isActive()) continue;
        for (int i = 0; i < numSamples; ++i)
        {
            float l = 0.0f, r = 0.0f;
            v.processSample (l, r);
            left[i]  += l;
            right[i] += r;
        }
    }
}

int VoiceManager::findFreeVoice()
{
    for (int i = 0; i < MAX_VOICES; ++i)
        if (!voices[i].isActive()) return i;
    return -1;
}

int VoiceManager::stealVoice()
{
    // Prefer releasing voices
    int oldest = -1, oldestAge = -1;
    for (int i = 0; i < MAX_VOICES; ++i)
        if (voices[i].isReleasing() && voiceAge[i] > oldestAge)
            { oldest = i; oldestAge = voiceAge[i]; }
    if (oldest >= 0) { voices[oldest].reset(); return oldest; }

    // Otherwise steal oldest active
    oldestAge = -1;
    for (int i = 0; i < MAX_VOICES; ++i)
        if (voiceAge[i] > oldestAge)
            { oldest = i; oldestAge = voiceAge[i]; }
    if (oldest >= 0) { voices[oldest].reset(); return oldest; }

    return 0;
}

int VoiceManager::findVoiceForNote (int midiNote)
{
    for (int i = 0; i < MAX_VOICES; ++i)
        if (voices[i].isActive() && voices[i].getMidiNote() == midiNote)
            return i;
    return -1;
}
