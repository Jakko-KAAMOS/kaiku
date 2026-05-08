#pragma once
#include <juce_gui_basics/juce_gui_basics.h>

// ─────────────────────────────────────────────────────────────────────────────
// KaamOSLookAndFeel — the aesthetic
//
// Palette from KAAMOS_DE.md:
//   Primary:   amber    #C8A050  on void black  #070711
//   Accent:    void blue #3030A0
//   Hehku:     #C85020  (heat from within)
//   Active:    station green #40C080
//   Warning:   hiljaisuus violet #8030C0
//   Inactive:  #2A2A5A
//
// Rules:
//   No rounded corners. The grid has edges.
//   No gradients. Flat color, sharp edges, intentional.
//   No shadows unless load-bearing (Z-order).
//   If something moves, it is communicating information.
//   The one exception: the Hiljaisuus pulse.
// ─────────────────────────────────────────────────────────────────────────────

class KaamOSLookAndFeel : public juce::LookAndFeel_V4
{
public:
    // ── Palette ───────────────────────────────────────────────────────────────
    static constexpr uint32_t COL_VOID_BLACK     = 0xFF070711;
    static constexpr uint32_t COL_AMBER          = 0xFFC8A050;
    static constexpr uint32_t COL_VOID_BLUE      = 0xFF3030A0;
    static constexpr uint32_t COL_HEHKU          = 0xFFC85020;
    static constexpr uint32_t COL_STATION_GREEN  = 0xFF40C080;
    static constexpr uint32_t COL_HILJAISUUS     = 0xFF8030C0;
    static constexpr uint32_t COL_INACTIVE       = 0xFF2A2A5A;
    static constexpr uint32_t COL_DIM_AMBER      = 0xFF6A5428;

    static juce::Colour amber()         { return juce::Colour (COL_AMBER); }
    static juce::Colour voidBlack()     { return juce::Colour (COL_VOID_BLACK); }
    static juce::Colour voidBlue()      { return juce::Colour (COL_VOID_BLUE); }
    static juce::Colour hehku()         { return juce::Colour (COL_HEHKU); }
    static juce::Colour stationGreen()  { return juce::Colour (COL_STATION_GREEN); }
    static juce::Colour hiljaisuus()    { return juce::Colour (COL_HILJAISUUS); }
    static juce::Colour inactive()      { return juce::Colour (COL_INACTIVE); }
    static juce::Colour dimAmber()      { return juce::Colour (COL_DIM_AMBER); }

    KaamOSLookAndFeel();

    // ── Overrides ─────────────────────────────────────────────────────────────
    void drawRotarySlider (juce::Graphics&, int x, int y, int w, int h,
                           float sliderPos, float startAngle, float endAngle,
                           juce::Slider&) override;

    void drawLinearSlider  (juce::Graphics&, int x, int y, int w, int h,
                            float sliderPos, float minSliderPos, float maxSliderPos,
                            const juce::Slider::SliderStyle,
                            juce::Slider&) override;

    void drawButtonBackground (juce::Graphics&, juce::Button&,
                                const juce::Colour& backgroundColour,
                                bool shouldDrawButtonAsHighlighted,
                                bool shouldDrawButtonAsDown) override;

    void drawComboBox (juce::Graphics&, int w, int h, bool isButtonDown,
                       int buttonX, int buttonY, int buttonW, int buttonH,
                       juce::ComboBox&) override;

    juce::Font getLabelFont (juce::Label&) override;
    juce::Font getComboBoxFont (juce::ComboBox&) override;

    // ── Hex grid utility — decorative motif ──────────────────────────────────
    // Draws a dim hex grid pattern into a component bounds.
    // Used for backgrounds, panel separators.
    static void drawHexGrid (juce::Graphics& g,
                              juce::Rectangle<float> bounds,
                              float cellSize = 18.0f,
                              juce::Colour colour = juce::Colour (0xFF0E0E22));

    // ── Hiljaisuus pulse ─────────────────────────────────────────────────────
    // Returns a pulse value [0,1] for the current time.
    // Rate: ~0.15Hz — the Silence breathes slowly.
    // Use to modulate opacity of status indicators.
    static float hiljaisuusPulse (double timeInSeconds);

private:
    juce::Font terminalFont;  // Iosevka / Fira Code / system mono fallback
};
