//! Transpiled from Horizon Rust crate
package horizon_theme_night

import "core:fmt"
import "core:mem"
import "core:math"

// The launcher's night look ("Night" in `docs/design-system.md`): a pixel night sky that turns to
// a sunset at the bottom, plates over it only where text needs them, one violet for the main
// action, focus and progress, and Bricolage Grotesque (SIL OFL 1.1, `fonts/OFL-BricolageGrotesque.txt`).
// Light players get the same look at dawn ([`DAWN`]). The game's menus don't use it.
// use crate::{step, Blocks, Step, Web};

// The UI family (optical size 14: Regular, Medium, SemiBold, Bold) and the display family
// (Bold at optical size 72, for page and instance names). Mono stays [`crate::MONO`].
FONT :: "Bricolage Grotesque"
DISPLAY_FONT :: "Bricolage Grotesque Display"

// Instance names and page titles, in [`DISPLAY_FONT`].
    // rust: pub const DISPLAY: Step = step(
    // rust: "night-display",
    // rust: 56.,
    // rust: Web::Fluid(40., 72.),
    // rust: 1.,
    // rust: -0.035,
    // rust: 700,
    // rust: false,
    // rust: );
// Section and card heads.
TITLE :: step("night-title", 20., Web::Fixed, 1.25, -0.01, 700, false)
// Text, rows, buttons and navigation.
UI :: step("night-ui", 14., Web::Fixed, 1.45, -0.005, 500, false)
// One-line states and details under a name ("Ready · 26.3").
CAPTION :: step("night-caption", 12., Web::Fixed, 1.4, 0., 400, false)
// A screen uses two or three of these, plus [`crate::MICRO`] for paths and counts.
TYPE :: [DISPLAY, TITLE, UI, CAPTION]

// Corners. A plate cuts each corner in two [`PIXEL_CORNER`] steps, like the sky's art, and its
// 1 px stroke follows the steps. The main action (an accent fill: Play, Create, Install) cuts one
// step. Other controls (buttons, fields, focus rings) round at [`RADIUS_CONTROL`]: at 1x a step
// vanishes on a pale fill and reads as notches on a thin ring. Pills are [`crate::RADIUS_PILL`],
// for chips only.
PIXEL_CORNER :: 4.
RADIUS_CONTROL :: 8.
// The main action (Play) is taller than the other controls.
PLAY :: 56.

// How many of the sky's stops, from the top, can sit behind text without a plate: the night's
// lower stops (the sunset) are too bright for light text, so text there always has a plate.
UNCARDED_STOPS :: 3

Night :: struct {
    // The sky from the top of the window to the horizon, drawn in bands.
    sky: [u32,
    // Behind everything before the sky is drawn, and the sidebar.
    page: u32,
    side: u32,
    // Plates over the sky (rows, cards, dialogs), with their opacity, and a raised or selected
    // one.
    card: u32,
    card_alpha: f32,
    card_hi: u32,
    card_hi_alpha: f32,
    // The plates' 1 px inner stroke and the rules between rows: this colour at these opacities.
    stroke: u32,
    stroke_alpha: f32,
    rule_alpha: f32,
    ink: u32,
    ink_soft: u32,
    muted: u32,
    // The one main action's fill and progress; its label is `on_accent`.
    accent: u32,
    // The accent as text and as the focus ring, readable on every plate.
    accent_hi: u32,
    on_accent: u32,
    success: u32,
    warn: u32,
    danger: u32,
    dark: bool,
}

    // rust: pub const NIGHT: Night = Night {
    // rust: sky: [0x07061a, 0x140f38, 0x2a1656, 0x5b2a78, 0xb0477d, 0xf08a5d],
    // rust: page: 0x0e0b26,
    // rust: side: 0x0a0820,
    // rust: card: 0x15112e,
    // rust: card_alpha: 0.84,
    // rust: card_hi: 0x231c4a,
    // rust: card_hi_alpha: 0.90,
    // rust: stroke: 0xb9acff,
    // rust: stroke_alpha: 0.12,
    // rust: rule_alpha: 0.10,
    // rust: ink: 0xf4f2ff,
    // rust: ink_soft: 0xcfc9ea,
    // rust: muted: 0xa59fc6,
    // rust: accent: 0x7656fa,
    // rust: accent_hi: 0xa08cff,
    // rust: on_accent: 0xffffff,
    // rust: success: 0x5fd39a,
    // rust: warn: 0xf5b45a,
    // rust: danger: 0xff8a78,
    // rust: dark: true,
}

// The light appearance: the same sky at dawn, pale blue to peach, with the night's violet.
    // rust: pub const DAWN: Night = Night {
    // rust: sky: [0xc9d3f2, 0xdcd8f3, 0xead5ec, 0xf5d3d8, 0xf9d6bd, 0xfbe4c6],
    // rust: page: 0xe9e6f6,
    // rust: side: 0xe1ddf1,
    // rust: card: 0xfdfcff,
    // rust: card_alpha: 0.86,
    // rust: card_hi: 0xffffff,
    // rust: card_hi_alpha: 0.94,
    // rust: stroke: 0x3b2f78,
    // rust: stroke_alpha: 0.12,
    // rust: rule_alpha: 0.10,
    // rust: ink: 0x1b1530,
    // rust: ink_soft: 0x3b3354,
    // rust: muted: 0x585071,
    // rust: accent: 0x5b3fd6,
    // rust: accent_hi: 0x5333c9,
    // rust: on_accent: 0xffffff,
    // rust: success: 0x136336,
    // rust: warn: 0x7a4f00,
    // rust: danger: 0xa3301d,
    // rust: dark: false,
}

// `top` at `alpha` over `under`, as the GPU blends them.
over :: proc(top: u32, alpha: f32, under: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: [16, 8, 0].iter().fold(0, |out, s| {
    // rust: let (a, b) = (((top >> s) & 255) as f32, ((under >> s) & 255) as f32);
    // rust: out | ((a * alpha + b * (1. - alpha)).round() as u32) << s
    // rust: })
}

    // rust: impl Night {
    // These colours in the parts of the Blocks look the launcher still draws until each screen is
    // rebuilt: plates come out opaque over the page, with soft strokes instead of dark outlines.
blocks :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let shade = |a: f32, under: u32| over(if self.dark { 0 } else { self.stroke }, a, under);
    // rust: let panel = over(self.card, self.card_alpha, self.page);
    // rust: let raised = over(self.card_hi, self.card_hi_alpha, self.page);
    // rust: Blocks {
    // rust: page: self.page,
    // rust: side: self.side,
    // rust: panel,
    // rust: raised,
    // rust: button: over(self.stroke, 0.10, raised),
    // rust: button_bevel: over(self.stroke, 0.24, raised),
    // rust: well: if self.dark {
    // rust: shade(0.3, self.side)
    // rust: } else {
    // rust: over(self.card, 0.7, self.side)
    // rust: },
    // rust: bevel: over(self.stroke, self.stroke_alpha * 1.5, panel),
    // rust: lip: shade(if self.dark { 0.45 } else { 0.18 }, self.page),
    // rust: outline: shade(if self.dark { 0.6 } else { 0.28 }, self.page),
    // rust: rule: over(self.stroke, self.rule_alpha, panel),
    // rust: ink: self.ink,
    // rust: ink_soft: self.ink_soft,
    // rust: muted: self.muted,
    // rust: accent: self.accent_hi,
    // rust: face: self.accent,
    // rust: face_bevel: over(0xffffff, 0.22, self.accent),
    // rust: face_lip: over(0, 0.35, self.accent),
    // rust: on_face: self.on_accent,
    // rust: danger: self.danger,
    // rust: success: self.success,
    // rust: warn: self.warn,
    // rust: dark: self.dark,
}
}

    // Every colour by its CSS name (`--night-<name>`); plates carry their opacity.
css :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let rgba = |c: u32, a: f32| {
    // rust: format!(
    // rust: "rgba({}, {}, {}, {})",
    // rust: c >> 16 & 255,
    // rust: c >> 8 & 255,
    // rust: c & 255,
    // rust: (a * 100.).round() / 100.
    // rust: )
}
    // rust: let mut lines: Vec<(String, String)> = self
    // rust: .sky
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, c)| (format!("sky-{i}"), format!("#{c:06x}")))
    // rust: .collect();
    // rust: for (name, c) in [
    // rust: ("page", self.page),
    // rust: ("side", self.side),
    // rust: ("ink", self.ink),
    // rust: ("ink-soft", self.ink_soft),
    // rust: ("muted", self.muted),
    // rust: ("accent", self.accent),
    // rust: ("accent-hi", self.accent_hi),
    // rust: ("on-accent", self.on_accent),
    // rust: ("success", self.success),
    // rust: ("warn", self.warn),
    // rust: ("danger", self.danger),
    // rust: ] {
    // rust: lines.push((name.into(), format!("#{c:06x}")));
}
    // rust: lines.push(("card".into(), rgba(self.card, self.card_alpha)));
    // rust: lines.push(("card-hi".into(), rgba(self.card_hi, self.card_hi_alpha)));
    // rust: lines.push(("stroke".into(), rgba(self.stroke, self.stroke_alpha)));
    // rust: lines.push(("rule".into(), rgba(self.stroke, self.rule_alpha)));
    // rust: lines
    // rust: .into_iter()
    // rust: .map(|(name, value)| format!("  --night-{name}: {value};\n"))
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::contrast;

    // Every text colour reaches WCAG AA (4.5:1) on both plates over every stop of the sky, and
    // the sky's upper stops, the page and the sidebar hold the text drawn there without a plate.
    // The focus ring is `accent_hi`, so it is held to text contrast too.
night_text_meets_wcag_aa_over_the_sky :: proc() {
}
    // rust: for p in [NIGHT, DAWN] {
    // rust: let look = if p.dark { "night" } else { "dawn" };
    // rust: let texts = [
    // rust: ("ink", p.ink),
    // rust: ("ink_soft", p.ink_soft),
    // rust: ("muted", p.muted),
    // rust: ("accent_hi", p.accent_hi),
    // rust: ("success", p.success),
    // rust: ("warn", p.warn),
    // rust: ("danger", p.danger),
    // rust: ];
    // rust: for (i, &sky) in p.sky.iter().enumerate() {
    // rust: for (plate, top, alpha) in [
    // rust: ("card", p.card, p.card_alpha),
    // rust: ("card_hi", p.card_hi, p.card_hi_alpha),
    // rust: ] {
    // rust: let bg = over(top, alpha, sky);
    // rust: for (tn, fg) in texts {
    // rust: let ratio = contrast(fg, bg);
    // rust: assert!(
    // rust: ratio >= 4.5,
    // rust: "{look} {tn} on {plate} over sky {i}: {ratio:.2}"
    // rust: );
}
}
}
    // rust: let bare = p.sky[..UNCARDED_STOPS]
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, &c)| (format!("sky {i}"), c))
    // rust: .chain([("page".into(), p.page), ("side".into(), p.side)]);
    // rust: for (bn, bg) in bare {
    // rust: for (tn, fg) in &texts[..4] {
    // rust: let ratio = contrast(*fg, bg);
    // rust: assert!(ratio >= 4.5, "{look} {tn} on {bn}: {ratio:.2}");
}
}
    // rust: let label = contrast(p.on_accent, p.accent);
    // rust: assert!(label >= 4.5, "{look} the main action's label: {label:.2}");
}
}

over_blends_like_the_gpu :: proc() {
}
    // rust: assert_eq!(over(0xffffff, 1., 0x000000), 0xffffff);
    // rust: assert_eq!(over(0xffffff, 0.5, 0x000000), 0x808080);
    // rust: assert_eq!(over(0x123456, 0., 0xabcdef), 0xabcdef);
}
}
