# Doru Malaia — Sample Dependency Notice

Some features of this project depend on percussion samples from the
**Doru Malaia 230 Ethnic Drums & Percussions** library. These samples
are not included in the repository and cannot be redistributed.

---

## About the library

Doru Malaia was a Romanian musician and sample library creator.
He died on February 10, 2006. His 230 Ethnic Drums & Percussions library —
14,400 one-shot samples at 96kHz/24-bit/stereo, sold for $29 — is now
irreplaceable. It cannot be recreated. No comparable substitute exists.

If you do not have this library, you do not have it.
The project does not provide it. It cannot.

Credit in all derivative work: *Percussion samples by Doru Malaia.*

---

## What requires the library

The following features require the Doru Malaia corpus:

- Drum machine kit exports (`sounds/kits/` targets: EZdrummer 2, Addictive Drums, FL Studio)
- Bitcrushed percussion derivatives (`sounds/crush/`)
- Web audio delivery files (`sounds/web/`)
- The percussion pipeline scripts (`collect_doru.sh`, `bitcrush.py`)

The following features do **not** require the library:

- The Kaiku VST3 synthesizer (`vsti/`)
- The FM synthesis patches and timbres
- The LilyPond scores and MIDI eval files
- The impulse response reverb files (`ir/`)
- The web games (`birch`, `kuule`) in their current form

---

## If you have the library

The extraction and processing pipeline is documented in `doru_pipeline.md`.
You will need the source archive, `collect_doru.sh`, and `bitcrush.py`.
The library should be treated as read-only at all times.
The originals do not leave without a verified backup in place first.

---

## Attribution

Any released work that incorporates processed Doru Malaia samples
must carry the following credit:

> Percussion samples by Doru Malaia.
