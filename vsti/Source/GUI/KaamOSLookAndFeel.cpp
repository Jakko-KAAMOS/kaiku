#include "KaamOSLookAndFeel.h"
#include <cmath>

KaamOSLookAndFeel::KaamOSLookAndFeel()
{
    // Base colours
    setColour (juce::ResizableWindow::backgroundColourId,   voidBlack());
    setColour (juce::DocumentWindow::backgroundColourId,    voidBlack());
    setColour (juce::Slider::backgroundColourId,            inactive());
    setColour (juce::Slider::trackColourId,                 amber());
    setColour (juce::Slider::thumbColourId,                 amber());
    setColour (juce::Label::textColourId,                   amber());
    setColour (juce::ComboBox::backgroundColourId,          inactive());
    setColour (juce::ComboBox::textColourId,                amber());
    setColour (juce::ComboBox::outlineColourId,             dimAmber());
    setColour (juce::PopupMenu::backgroundColourId,         voidBlack());
    setColour (juce::PopupMenu::textColourId,               amber());
    setColour (juce::PopupMenu::highlightedBackgroundColourId, inactive());
    setColour (juce::TextButton::buttonColourId,            inactive());
    setColour (juce::TextButton::textColourOffId,           amber());
    setColour (juce::TextButton::textColourOnId,            stationGreen());

    terminalFont = juce::Font ("Iosevka", 12.0f, juce::Font::plain);
}

void KaamOSLookAndFeel::drawRotarySlider (juce::Graphics& g,
    int x, int y, int w, int h,
    float sliderPos, float startAngle, float endAngle,
    juce::Slider& slider)
{
    using Pi = juce::MathConstants<float>;

    auto bounds = juce::Rectangle<float> ((float)x, (float)y, (float)w, (float)h)
                      .reduced (4.0f);
    auto  centre = bounds.getCentre();
    float radius = juce::jmin (bounds.getWidth(), bounds.getHeight()) * 0.5f;
    float angle  = startAngle + sliderPos * (endAngle - startAngle);

    bool isDown = slider.isMouseButtonDown();
    bool isOver = slider.isMouseOver();

    // ── outer arc track (inactive) ─────────────────────────────────────────
    g.setColour (inactive());
    juce::Path bgArc;
    bgArc.addCentredArc (centre.x, centre.y, radius, radius,
                         0.0f, startAngle, endAngle, true);
    g.strokePath (bgArc, juce::PathStrokeType (2.0f));

    // ── value arc — amber, or station green when held ──────────────────────
    g.setColour (isDown ? stationGreen() : amber());
    juce::Path valArc;
    valArc.addCentredArc (centre.x, centre.y, radius, radius,
                          0.0f, startAngle, angle, true);
    g.strokePath (valArc, juce::PathStrokeType (2.0f));

    // ── hexagonal body (Kuule-pattern, pointy-top) ─────────────────────────
    // Inset from arc so the ring reads around the outside of the cap.
    float hexR = radius - 7.0f;
    juce::Path hex;
    for (int i = 0; i < 6; ++i)
    {
        // Pointy-top orientation: matches kuule hex grid (same -pi/6 offset)
        float a  = Pi::pi / 3.0f * (float)i - Pi::pi / 6.0f;
        float px = centre.x + hexR * std::cos (a);
        float py = centre.y + hexR * std::sin (a);
        if (i == 0) hex.startNewSubPath (px, py);
        else        hex.lineTo (px, py);
    }
    hex.closeSubPath();

    // Fill
    g.setColour (voidBlack());
    g.fillPath (hex);

    // Border: brightens on hover, turns green when held
    g.setColour (isDown ? stationGreen() :
                 isOver ? amber()        :
                          inactive());
    g.strokePath (hex, juce::PathStrokeType (1.0f));

    // ── indicator line: floats inside the cap, points to current value ─────
    // Starts near centre, ends at 76% of hex radius — clear but not to edge.
    float innerR = hexR * 0.28f;
    float outerR = hexR * 0.76f;
    juce::Point<float> inner (centre.x + innerR * std::sin (angle),
                               centre.y - innerR * std::cos (angle));
    juce::Point<float> outer (centre.x + outerR * std::sin (angle),
                               centre.y - outerR * std::cos (angle));
    g.setColour (isDown ? stationGreen() : amber());
    g.drawLine (inner.x, inner.y, outer.x, outer.y, 1.5f);

    // ── centre dot ─────────────────────────────────────────────────────────
    g.fillEllipse (centre.x - 1.5f, centre.y - 1.5f, 3.0f, 3.0f);
}

void KaamOSLookAndFeel::drawLinearSlider (juce::Graphics& g,
    int x, int y, int w, int h,
    float sliderPos, float /*minPos*/, float /*maxPos*/,
    const juce::Slider::SliderStyle style, juce::Slider&)
{
    auto bounds = juce::Rectangle<float> ((float)x, (float)y, (float)w, (float)h);

    if (style == juce::Slider::LinearVertical)
    {
        float trackX = bounds.getCentreX() - 1.0f;
        // Track
        g.setColour (inactive());
        g.fillRect (trackX, bounds.getY(), 2.0f, bounds.getHeight());
        // Value
        g.setColour (amber());
        g.fillRect (trackX, sliderPos, 2.0f, bounds.getBottom() - sliderPos);
        // Thumb — sharp notch, no circle
        g.fillRect (trackX - 5.0f, sliderPos - 1.0f, 12.0f, 2.0f);
    }
    else
    {
        float trackY = bounds.getCentreY() - 1.0f;
        g.setColour (inactive());
        g.fillRect (bounds.getX(), trackY, bounds.getWidth(), 2.0f);
        g.setColour (amber());
        g.fillRect (bounds.getX(), trackY, sliderPos - bounds.getX(), 2.0f);
        g.fillRect (sliderPos - 1.0f, trackY - 5.0f, 2.0f, 12.0f);
    }
}

void KaamOSLookAndFeel::drawButtonBackground (juce::Graphics& g,
    juce::Button& button, const juce::Colour&,
    bool highlighted, bool down)
{
    auto bounds = button.getLocalBounds().toFloat().reduced (0.5f);
    g.setColour (down        ? amber().withAlpha (0.3f) :
                 highlighted ? inactive().brighter (0.1f) :
                               inactive());
    g.fillRect (bounds);
    g.setColour (button.getToggleState() ? amber() : dimAmber());
    g.drawRect (bounds, 1.0f);
}

void KaamOSLookAndFeel::drawComboBox (juce::Graphics& g,
    int w, int h, bool, int, int, int, int, juce::ComboBox& box)
{
    g.setColour (inactive());
    g.fillRect (0, 0, w, h);
    g.setColour (dimAmber());
    g.drawRect (0, 0, w, h, 1);

    // Arrow — angular, not rounded
    int aw = 8, ah = 5;
    int ax = w - aw - 8, ay = (h - ah) / 2;
    juce::Path arrow;
    arrow.startNewSubPath ((float)ax, (float)ay);
    arrow.lineTo ((float)(ax + aw), (float)ay);
    arrow.lineTo ((float)(ax + aw/2), (float)(ay + ah));
    arrow.closeSubPath();
    g.setColour (amber());
    g.fillPath (arrow);
}

juce::Font KaamOSLookAndFeel::getLabelFont   (juce::Label&)    { return terminalFont; }
juce::Font KaamOSLookAndFeel::getComboBoxFont (juce::ComboBox&) { return terminalFont; }

void KaamOSLookAndFeel::drawHexGrid (juce::Graphics& g,
    juce::Rectangle<float> bounds, float cellSize, juce::Colour colour)
{
    g.setColour (colour);
    float h  = cellSize;
    float w  = h * 1.1547f;  // 2/sqrt(3)
    float x0 = bounds.getX();
    float y0 = bounds.getY();

    for (float row = -1; row * h * 0.75f < bounds.getHeight() + h; ++row)
    {
        for (float col = -1; col * w < bounds.getWidth() + w; ++col)
        {
            float cx = x0 + col * w + ((int)row % 2 == 0 ? 0 : w * 0.5f);
            float cy = y0 + row * h * 0.75f;

            juce::Path hex;
            for (int i = 0; i < 6; ++i)
            {
                float angle = juce::MathConstants<float>::pi / 3.0f * (float)i
                              - juce::MathConstants<float>::pi / 6.0f;
                float px = cx + (h * 0.5f) * std::cos (angle);
                float py = cy + (h * 0.5f) * std::sin (angle);
                if (i == 0) hex.startNewSubPath (px, py);
                else        hex.lineTo (px, py);
            }
            hex.closeSubPath();
            g.strokePath (hex, juce::PathStrokeType (0.5f));
        }
    }
}

float KaamOSLookAndFeel::hiljaisuusPulse (double t)
{
    // 0.15Hz slow pulse — the Silence breathes
    return 0.5f + 0.5f * (float)std::sin (2.0 * juce::MathConstants<double>::pi * 0.15 * t);
}
