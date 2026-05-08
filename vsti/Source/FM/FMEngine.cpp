#include "FMEngine.h"

// ─────────────────────────────────────────────────────────────────────────────
// FMPatch presets — derived from timbre_brief.md
//
// All parameter rationale is documented in:
//   eerikki-muistaa/timbre_brief.md
//   eerikki-muistaa/moonsorrow_notes.md
// ─────────────────────────────────────────────────────────────────────────────

FMPatch FMPatch::makeTyhjyydenkaiku()
{
    FMPatch p;
    p.name = "Tyhjyydenkaiku";

    // ops[0] — F1 carrier: vowel body
    p.ops[0] = { .ratio=1.00f, .index=0.0f, .level=0.85f,
                 .attackMs=5.0f, .decayMs=80.0f, .sustainLevel=0.85f, .releaseMs=200.0f };

    // ops[1] — F1 modulator: vowel shaper (index envelope = consonant→vowel)
    p.ops[1] = { .ratio=1.00f, .index=2.0f, .indexPeak=3.5f, .indexDecayMs=60.0f,
                 .feedback=0.25f,   // vocal roughness
                 .attackMs=1.0f, .decayMs=60.0f, .sustainLevel=0.40f, .releaseMs=150.0f };

    // ops[2] — F2 carrier: nasal/upper partial
    p.ops[2] = { .ratio=2.00f, .index=0.0f, .level=0.65f, .detuneHz=0.0f,
                 .attackMs=8.0f, .decayMs=100.0f, .sustainLevel=0.70f, .releaseMs=180.0f };

    // ops[3] — F2 modulator
    p.ops[3] = { .ratio=3.00f, .index=1.2f, .indexPeak=2.5f, .indexDecayMs=80.0f,
                 .attackMs=2.0f, .decayMs=80.0f, .sustainLevel=0.30f, .releaseMs=120.0f };

    // ops[4] — Wheel/breath carrier: hurdy texture
    p.ops[4] = { .ratio=1.004629f, .index=0.0f, .level=0.75f,
                 // 1.004629 = 2^(8/1200) — exactly 8 cents sharp, per world bible spec
                 // This beating against ops[0] is the instrument's defining roughness.
                 // Do not tune it out. The imperfection is the instrument.
                 // Revisit after first audio test: if 8¢ is too subtle, 1.008 (~13.8¢) is rougher.
                 .attackMs=5.0f, .decayMs=500.0f, .sustainLevel=1.0f, .releaseMs=80.0f };

    // ops[5] — Wheel modulator
    p.ops[5] = { .ratio=1.00f, .index=1.2f, .indexPeak=1.4f, .indexDecayMs=500.0f,
                 .feedback=0.15f,
                 .attackMs=5.0f, .decayMs=500.0f, .sustainLevel=0.55f, .releaseMs=100.0f };

    // Mark carriers
    p.ops[0].level = 0.85f;
    p.ops[2].level = 0.65f;
    p.ops[4].level = 0.75f;

    p.masterLevel = 0.80f;
    return p;
}

FMPatch FMPatch::makeKuilunsikio()
{
    // Spawn of the abyss — visceral, high indices, trompette forward
    FMPatch p = makeTyhjyydenkaiku();
    p.name = "Kuilunsikiö";

    p.ops[1].index     = 3.5f;
    p.ops[1].indexPeak = 6.0f;
    p.ops[3].index     = 2.5f;
    p.ops[3].indexPeak = 4.0f;
    p.ops[5].index     = 2.0f;
    p.ops[5].indexPeak = 2.5f;

    p.ops[4].ratio     = 1.012f;  // more detuning — rougher wheel
    p.ops[1].feedback  = 0.40f;   // more roughness

    p.masterLevel = 0.75f;
    return p;
}

FMPatch FMPatch::makePohjankaiku()
{
    // Echo from the deep north — Mellotron-body weight, FM recessed
    // Lower indices = cleaner, darker. Tape-body character.
    FMPatch p = makeTyhjyydenkaiku();
    p.name = "Pohjankaiku";

    p.ops[1].index     = 1.2f;
    p.ops[1].indexPeak = 1.8f;
    p.ops[1].feedback  = 0.10f;
    p.ops[3].index     = 0.8f;
    p.ops[3].indexPeak = 1.2f;
    p.ops[5].index     = 0.8f;
    p.ops[5].indexPeak = 1.0f;

    p.ops[4].ratio     = 1.004f;  // less detuning — smoother wheel

    // Longer attacks — tape breathes in slowly
    for (auto& op : p.ops) op.attackMs *= 2.0f;

    p.masterLevel = 0.85f;
    return p;
}

FMPatch FMPatch::makeKuilukaiku()
{
    // Abyss echo — stripped, minimal, what you'd carve on a tombstone
    FMPatch p;
    p.name = "Kuilukaiku";

    // Single active stack: ops[0] + ops[1] only
    p.ops[0] = { .ratio=1.00f, .level=1.0f,
                 .attackMs=3.0f, .decayMs=400.0f, .sustainLevel=0.70f, .releaseMs=300.0f };
    p.ops[1] = { .ratio=1.00f, .index=1.5f, .indexPeak=2.0f, .indexDecayMs=100.0f,
                 .feedback=0.20f,
                 .attackMs=1.0f, .decayMs=200.0f, .sustainLevel=0.20f, .releaseMs=200.0f };

    // F2 and wheel stacks muted
    p.ops[2].level = 0.0f;
    p.ops[3].level = 0.0f;
    p.ops[4].level = 0.0f;
    p.ops[5].level = 0.0f;

    p.ops[4].ratio = 1.002f;  // minimal detuning — nearly clean

    p.masterLevel = 0.90f;
    return p;
}

// ─────────────────────────────────────────────────────────────────────────────
// FMEngine
// ─────────────────────────────────────────────────────────────────────────────

void FMEngine::prepare (double sr)
{
    sampleRate = sr;
    for (auto& op : ops) op.prepare (sr);
    applyPatch (FMPatch::makeTyhjyydenkaiku());
}

void FMEngine::applyPatch (const FMPatch& patch)
{
    for (int i = 0; i < NUM_OPS; ++i)
    {
        auto& op  = ops[i];
        auto& src = patch.ops[i];

        op.ratio        = src.ratio;
        op.index        = src.index;
        op.indexPeak    = src.indexPeak;
        op.indexDecayMs = src.indexDecayMs;
        op.level        = src.level;
        op.feedback     = src.feedback;
        op.detuneHz     = src.detuneHz;
        op.isCarrier    = (i % 2 == 0);  // even = carrier, odd = modulator

        op.envelope.setAttack   (src.attackMs);
        op.envelope.setDecay    (src.decayMs);
        op.envelope.setSustain  (src.sustainLevel);
        op.envelope.setRelease  (src.releaseMs);
    }
}

void FMEngine::noteOn (float frequencyHz, float vel)
{
    fundamental = frequencyHz;
    velocity    = vel;
    for (auto& op : ops) op.noteOn (frequencyHz);
}

void FMEngine::noteOff()
{
    for (auto& op : ops) op.noteOff();
}

void FMEngine::reset()
{
    for (auto& op : ops) op.reset();
}

bool FMEngine::isActive() const
{
    for (auto& op : ops)
        if (op.isActive()) return true;
    return false;
}

float FMEngine::processSample()
{
    // ── Algorithm: 3 parallel stacks ─────────────────────────────────────────
    //
    //   Stack 0: ops[1] → ops[0]    F1 formant
    //   Stack 1: ops[3] → ops[2]    F2 formant
    //   Stack 2: ops[5] → ops[4]    Wheel/breath
    //
    // Process modulators first, feed output into carriers.

    // Stack 0: F1 (mouth formant body)
    float mod0 = ops[1].process (0.0f);         // modulator, no input
    float car0 = ops[0].process (mod0);          // carrier, driven by mod0

    // Stack 1: F2 (nasal / upper partial)
    float mod1 = ops[3].process (0.0f);
    float car1 = ops[2].process (mod1);

    // Stack 2: Wheel/breath (hurdy detuned string + texture)
    float mod2 = ops[5].process (0.0f);
    float car2 = ops[4].process (mod2);

    // Sum carriers — all three contribute to output
    return (car0 + car1 + car2) * velocity;
}
