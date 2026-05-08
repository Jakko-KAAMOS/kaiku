cmake_minimum_required(VERSION 3.22)
project(Kaiku VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ── JUCE via FetchContent ─────────────────────────────────────────────────────
include(FetchContent)
FetchContent_Declare(
    JUCE
    GIT_REPOSITORY https://github.com/juce-framework/JUCE.git
    GIT_TAG        7.0.9
    GIT_SHALLOW    TRUE
)
FetchContent_MakeAvailable(JUCE)

# ── Plugin target ─────────────────────────────────────────────────────────────
juce_add_plugin(Kaiku
    COMPANY_NAME                "Kaamos"
    COMPANY_WEBSITE             ""
    PLUGIN_MANUFACTURER_CODE    Kmos
    PLUGIN_CODE                 Kaik
    FORMATS                     VST3 AU Standalone
    PRODUCT_NAME                "Kaiku"
    BUNDLE_ID                   "com.kaamos.kaiku"
    DESCRIPTION                 "Tyhjyydenkaiku — Echo of the void"

    IS_SYNTH                    TRUE
    NEEDS_MIDI_INPUT            TRUE
    NEEDS_MIDI_OUTPUT           FALSE
    IS_MIDI_EFFECT              FALSE
    EDITOR_WANTS_KEYBOARD_FOCUS FALSE

    VST3_CATEGORIES             "Instrument|Synth"
    AU_MAIN_TYPE                kAudioUnitType_MusicDevice

    COPY_PLUGIN_AFTER_BUILD     FALSE
)

# ── Sources ───────────────────────────────────────────────────────────────────
target_sources(Kaiku PRIVATE
    Source/PluginProcessor.cpp
    Source/PluginEditor.cpp
    Source/FM/FMOperator.cpp
    Source/FM/FMEngine.cpp
    Source/Synth/KaikuVoice.cpp
    Source/Synth/VoiceManager.cpp
    Source/GUI/KaamOSLookAndFeel.cpp
)

target_include_directories(Kaiku PRIVATE Source)

# ── Compile definitions ───────────────────────────────────────────────────────
target_compile_definitions(Kaiku PUBLIC
    JUCE_WEB_BROWSER=0
    JUCE_USE_CURL=0
    JUCE_VST3_CAN_REPLACE_VST2=0
    JUCE_DISPLAY_SPLASH_SCREEN=0
)

# ── Link libraries ────────────────────────────────────────────────────────────
target_link_libraries(Kaiku
    PRIVATE
        juce::juce_audio_utils
        juce::juce_audio_plugin_client
        juce::juce_dsp
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags
)
