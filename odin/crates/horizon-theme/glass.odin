//! Transpiled from Horizon Rust crate
package horizon_theme_glass

import "core:fmt"
import "core:mem"
import "core:math"

// The launcher's glass look ("Glass" in `docs/design-system.md`), from Anthony S.'s mockup
// (horizon-site `app/launcher/launcher.css` and `components/launcher/launcher-ui.tsx`): frosted
// plates over the pixel sunset, white text at a few opacities, one accent. Geist sets the text,
// Bricolage Grotesque the headings (SemiBold, at the optical size a browser picks for each).
//
// The mockup derives its colours with CSS `color-mix`: [`Glass::new`] does the same sums, so a
// player's own accent comes out as it does on the website.

// The mockup's defaults: accent, how much white the plates take, and their blur in px.
ACCENT :: 0x6b4bff
TINT :: 0.06
BLUR :: 24.
// Behind the scene before it is drawn.
PAGE :: 0x0a0919
// The dark text on a light accent, and on the white buttons.
ON_LIGHT :: 0x100a1f
// A running game or server, and a ready instance.
LIVE :: 0x4ade80
// Busy (pulsing) and partly-working states.
WARN :: 0xf2c46b
// Destructive menu rows (`#ff8a8a`, hovered over `#ff6b6b` at 12 %).
DANGER :: 0xff8a8a
DANGER_HOVER :: 0xff6b6b
// The Discord button and its hover.
DISCORD :: 0x5865f2
DISCORD_HOVER :: 0x4752c4
// The scrim under dialogs and the palette: this colour at 50 %.
SCRIM :: 0x07050f

// Text families: Geist for everything, Bricolage for page, instance and dialog names.
FONT :: crate::FONT
DISPLAY_FONT :: "Bricolage Grotesque Display"
HEADING_FONT :: "Bricolage Grotesque Heading"

// Corners, in px. No step anywhere: everything is round.
    // rust: pub mod radius {
    // Dialogs.
MODAL :: 28.
    // Panels (the sidebar, cards, the tabbed panel).
PANEL :: 20.
    // Menus and popovers; choice cards in dialogs.
POPOVER :: 16.
    // The Play group, the big icon buttons, the top bar's tab strip.
LARGE :: 14.
    // Rows, chips, fields in dialogs.
ROW :: 12.
    // Buttons, tabs, small fields, menu rows.
CONTROL :: 10.
    // The sidebar rows' ⋯ button.
SMALL :: 9.
}

// How opaque white text is in each role (the mockup's `text-white/NN`).
    // rust: pub mod ink {
FULL :: 1.
STRONG :: 0.8
SOFT :: 0.75
BODY :: 0.7
MUTED :: 0.65
NOTE :: 0.6
QUIET :: 0.55
FAINT :: 0.5
DIM :: 0.45
PLACEHOLDER :: 0.4
OFF :: 0.35
}

// How opaque white fills are (`bg-white/[0.NN]`): rows hovered, selected, buttons, fields.
    // rust: pub mod fill {
HOVER :: 0.05
ROW_HOVER :: 0.06
FIELD :: 0.07
BUTTON :: 0.08
SELECTED :: 0.1
FIELD_FOCUS :: 0.11
ACTIVE :: 0.12
BUTTON_HOVER :: 0.14
}

// The look's colours for one accent and glass setting.
Glass :: struct {
    accent: u32,
    // The accent mixed half with white: progress bars, ticks, the focus ring, links.
    accent_soft: u32,
    // A dark violet from the accent: what the plates are tinted with.
    base: u32,
    // Text on the accent: white, or [`ON_LIGHT`] on a light accent.
    on_accent: u32,
    // A plate's fill and its opacity.
    plate: u32,
    plate_alpha: f32,
    tint: f32,
    blur: f32,
}

    // rust: impl Glass {
    // The mockup's sums: `--accent-soft: color-mix(in oklab, accent 52%, white)`,
    // `--base: color-mix(in oklab, accent 10%, #14111d)`, and `.hzl-glass`'s background
    // `color-mix(in srgb, white tint, color-mix(in oklab, base 22%, transparent))`.
new :: proc(accent: u32, tint: f32, blur: f32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let base = mix_oklab(accent, 0x14111d, 0.10);
        // White at `tint` over the base at 22 %, mixed with premultiplied alpha as CSS does.
    // rust: let base_alpha = 0.22;
    // rust: let alpha = tint + (1. - tint) * base_alpha;
    // rust: let plate = channels(|s| {
    // rust: let premul = tint + (1. - tint) * base_alpha * (((base >> s) & 255) as f32 / 255.);
    // rust: premul / alpha
    // rust: });
    // rust: Glass {
    // rust: accent,
    // rust: accent_soft: mix_oklab(accent, 0xffffff, 0.52),
    // rust: base,
    // rust: on_accent: if luminance(accent) > 0.4 {
    // rust: ON_LIGHT
    // rust: } else {
    // rust: 0xffffff
    // rust: },
    // rust: plate,
    // rust: plate_alpha: alpha,
    // rust: tint,
    // rust: blur,
}
}

    // The mockup's defaults.
default_look :: proc() -> G {
    // Ported from Horizon
    return {}
}
    // rust: Glass::new(ACCENT, TINT, BLUR)
}

    // Every colour by its CSS name (`--glass-<name>`), for `tokens.css`.
css :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let hex = |c: u32| format!("#{c:06x}");
    // rust: [
    // rust: ("accent", hex(self.accent)),
    // rust: ("accent-soft", hex(self.accent_soft)),
    // rust: ("base", hex(self.base)),
    // rust: ("on-accent", hex(self.on_accent)),
    // rust: ("page", hex(PAGE)),
    // rust: ("live", hex(LIVE)),
    // rust: ("warn", hex(WARN)),
    // rust: ("danger", hex(DANGER)),
    // rust: (
    // rust: "plate",
    // rust: format!(
    // rust: "rgba({}, {}, {}, {:.3})",
    // rust: self.plate >> 16 & 255,
    // rust: self.plate >> 8 & 255,
    // rust: self.plate & 255,
    // rust: self.plate_alpha
    // rust: ),
    // rust: ),
    // rust: ("blur", format!("{}px", self.blur)),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(name, value)| format!("  --glass-{name}: {value};\n"))
    // rust: .collect()
}
}

// Builds a colour from a function of each channel's shift (16, 8, 0) giving 0..=1.
channels :: proc(f: impl Fn(u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: [16, 8, 0].iter().fold(0, |out, &s| {
    // rust: out | ((f(s).clamp(0., 1.) * 255.).round() as u32) << s
    // rust: })
}

to_linear :: proc(c: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if c <= 0.04045 {
    // rust: c / 12.92
    // rust: } else {
    // rust: ((c + 0.055) / 1.055).powf(2.4)
}
}

from_linear :: proc(c: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if c <= 0.0031308 {
    // rust: c * 12.92
    // rust: } else {
    // rust: 1.055 * c.powf(1. / 2.4) - 0.055
}
}

// sRGB to OKLab (Björn Ottosson's matrices, as CSS Color 4 uses).
// The matrices as CSS Color 4 publishes them, digit for digit.
oklab :: proc(c: u32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [r, g, b] = [16, 8, 0].map(|s| to_linear(((c >> s) & 255) as f32 / 255.));
    // rust: let l = (0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b).cbrt();
    // rust: let m = (0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b).cbrt();
    // rust: let s = (0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b).cbrt();
    // rust: [
    // rust: 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    // rust: 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    // rust: 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s,
    // rust: ]
}

// OKLab back to sRGB, clamped to the gamut.
// The matrices as CSS Color 4 publishes them, digit for digit.
from_oklab :: proc(b]: [f32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let l_ = (l + 0.3963377774 * a + 0.2158037573 * b).powi(3);
    // rust: let m_ = (l - 0.1055613458 * a - 0.0638541728 * b).powi(3);
    // rust: let s_ = (l - 0.0894841775 * a - 1.2914855480 * b).powi(3);
    // rust: let rgb = [
    // rust: 4.0767416621 * l_ - 3.3077115913 * m_ + 0.2309699292 * s_,
    // rust: -1.2684380046 * l_ + 2.6097574011 * m_ - 0.3413193965 * s_,
    // rust: -0.0041960863 * l_ - 0.7034186147 * m_ + 1.7076147010 * s_,
    // rust: ];
    // rust: channels(|s| from_linear(rgb[(2 - s / 8) as usize]))
}

// CSS `color-mix(in oklab, a p, b)`: `p` of `a`, the rest `b`.
mix_oklab :: proc(a: u32, b: u32, p: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let (x, y) = (oklab(a), oklab(b));
    // rust: from_oklab([0, 1, 2].map(|i| x[i] * p + y[i] * (1. - p)))
}

// WCAG relative luminance, as the mockup's `luminance` picks the label colour on the accent.
luminance :: proc(c: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let [r, g, b] = [16, 8, 0].map(|s| {
    // rust: let v = ((c >> s) & 255) as f32 / 255.;
    // rust: if v <= 0.03928 {
    // rust: v / 12.92
    // rust: } else {
    // rust: ((v + 0.055) / 1.055).powf(2.4)
}
    // rust: });
    // rust: 0.2126 * r + 0.7152 * g + 0.0722 * b
}

    // rust: mod tests {
//     use super::*;

close :: proc(a: u32, b: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: [16, 8, 0]
    // rust: .iter()
    // rust: .all(|s| (((a >> s) & 255) as i32 - ((b >> s) & 255) as i32).abs() <= 1)
}

    // Chrome's own results for the mockup's `color-mix` sums (getComputedStyle, then a 1 px
    // canvas for the sRGB bytes): an independent check of the OKLab maths and the plate's mix.
mixes_match_the_browser :: proc() {
}
    // rust: let g = Glass::default_look();
    // rust: let soft = oklab(g.accent_soft);
    // rust: let mixed = [0, 1, 2].map(|i| oklab(ACCENT)[i] * 0.52 + oklab(0xffffff)[i] * 0.48);
    // rust: for (i, want) in [0.772018, 0.0291158, -0.12693].into_iter().enumerate() {
    // rust: assert!(
    // rust: (mixed[i] - want).abs() < 1e-3,
    // rust: "accent-soft oklab {mixed:?}"
    // rust: );
}
        // Chrome clips the out-of-gamut blue the same way.
    // rust: assert!(
    // rust: close(g.accent_soft, 0xa9a9ff),
    // rust: "accent-soft {:06x} {soft:?}",
    // rust: g.accent_soft
    // rust: );
    // rust: assert!(close(g.base, 0x1b1830), "base {:06x}", g.base);
        // color(srgb 0.30732 0.296469 0.370862 / 0.2668)
    // rust: assert!(close(g.plate, 0x4e4c5f), "plate {:06x}", g.plate);
    // rust: assert!((g.plate_alpha - 0.2668).abs() < 1e-4);
}

a_light_accent_takes_dark_labels :: proc() {
}
    // rust: assert_eq!(Glass::new(0xf2c46b, TINT, BLUR).on_accent, ON_LIGHT);
    // rust: assert_eq!(Glass::default_look().on_accent, 0xffffff);
}

oklab_round_trips :: proc() {
}
    // rust: for c in [0x000000, 0xffffff, 0x6b4bff, 0x14111d, 0x5865f2, 0xf89d62] {
    // rust: assert!(close(from_oklab(oklab(c)), c), "{c:06x}");
}
}
}
