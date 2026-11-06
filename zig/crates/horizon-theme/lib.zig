//! Transpiled from Horizon Rust crate
//! Module: horizon-theme_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon's design tokens, the one source of truth for the launcher (`launcher/src/theme.rs`),
//! the game's on-screen keyboard (`horizon-client`'s `ui_theme`) and the website (`tokens.css` in this crate,
//! generated from [`css`] by `cargo run -p xtask -- tokens`, which the site's build reads from main). Change a value here and all three
//! follow. The system is described in `docs/design-system.md`.
//!
//! Cool neutrals in two appearances and one violet accent; Geist and Geist Mono, bundled here
//! under the SIL Open Font License (`fonts/OFL-Geist.txt`). The launcher's night look and its
//! Bricolage Grotesque are in [`night`]. Colours are `0xRRGGBB`; sizes
//! are in logical pixels.
// use std::fmt::Write as _;
// use std::time::Duration;

pub const FONT: []const u8 = "Geist";
pub const MONO: []const u8 = "Geist Mono";
    // rust: pub mod glass;
    // rust: pub mod night;

/// The launcher's and the website's display face (headings, navigation, buttons, badges only):
/// Pixelify Sans, bundled under the SIL Open Font License (`fonts/OFL-PixelifySans.txt`).
pub const PIXEL: []const u8 = "Pixelify Sans";

/// The bundled font files.
    // rust: pub mod fonts {
pub const GEIST_REGULAR: []const u8 = include_bytes!("../fonts/Geist-Regular.ttf");
pub const GEIST_MEDIUM: []const u8 = include_bytes!("../fonts/Geist-Medium.ttf");
pub const GEIST_SEMIBOLD: []const u8 = include_bytes!("../fonts/Geist-SemiBold.ttf");
pub const GEIST_MONO: []const u8 = include_bytes!("../fonts/GeistMono-Regular.ttf");
pub const PIXEL_MEDIUM: []const u8 = include_bytes!("../fonts/PixelifySans-Medium.ttf");
pub const PIXEL_SEMIBOLD: []const u8 = include_bytes!("../fonts/PixelifySans-SemiBold.ttf");
pub const PIXEL_BOLD: []const u8 = include_bytes!("../fonts/PixelifySans-Bold.ttf");
    /// [`crate::night`]'s faces, cut from upstream's variable font by `tools/bake_bricolage.py`.
pub const BRICOLAGE_REGULAR: []const u8 = include_bytes!("../fonts/BricolageGrotesque-Regular.ttf");
pub const BRICOLAGE_MEDIUM: []const u8 = include_bytes!("../fonts/BricolageGrotesque-Medium.ttf");
    // rust: pub const BRICOLAGE_SEMIBOLD: &[u8] =
    // rust: include_bytes!("../fonts/BricolageGrotesque-SemiBold.ttf");
pub const BRICOLAGE_BOLD: []const u8 = include_bytes!("../fonts/BricolageGrotesque-Bold.ttf");
    // rust: pub const BRICOLAGE_DISPLAY_BOLD: &[u8] =
    // rust: include_bytes!("../fonts/BricolageGrotesqueDisplay-Bold.ttf");
    /// The glass look's headings ([`crate::glass`]): SemiBold at optical sizes 56 and 28.
    // rust: pub const BRICOLAGE_DISPLAY_SEMIBOLD: &[u8] =
    // rust: include_bytes!("../fonts/BricolageGrotesqueDisplay-SemiBold.ttf");
    // rust: pub const BRICOLAGE_HEADING_SEMIBOLD: &[u8] =
    // rust: include_bytes!("../fonts/BricolageGrotesqueHeading-SemiBold.ttf");
}

/// The glass look's icons: Hugeicons' free set (MIT, `icons/glass/LICENSE-hugeicons.txt`), the
/// ones the mockup uses, 24 unit outlines stroked 1.6 in `currentColor`, by Hugeicons' name
/// (`"folder-01"`, `"more-vertical"`…). `github` is GitHub's mark, drawn for Horizon (filled,
/// its cat cut out by a mask), beside the links to GitHub Sponsors.
    // rust: pub mod glass_icons {
    // rust: macro_rules! icons {
    // rust: ($($name:literal),* $(,)?) => {
            /// Every icon, `(name, svg)`.
    // rust: pub const ALL: &[(&str, &[u8])] = &[
    // rust: $(($name, include_bytes!(concat!("../icons/glass/", $name, ".svg")))),*
    // rust: ];
}
}
    // rust: icons!(
    // rust: "ai-chat-02",
    // rust: "arrow-down-01",
    // rust: "arrow-right-01",
    // rust: "cancel-01",
    // rust: "color-picker",
    // rust: "computer",
    // rust: "computer-terminal-01",
    // rust: "copy-01",
    // rust: "dashboard-square-01",
    // rust: "delete-02",
    // rust: "discord",
    // rust: "download-04",
    // rust: "earth",
    // rust: "favourite",
    // rust: "folder-01",
    // rust: "game-controller-01",
    // rust: "github",
    // rust: "globe-02",
    // rust: "image-01",
    // rust: "information-circle",
    // rust: "link-01",
    // rust: "minus-sign",
    // rust: "more-horizontal",
    // rust: "more-vertical",
    // rust: "package-01",
    // rust: "pencil-edit-02",
    // rust: "play",
    // rust: "plus-sign",
    // rust: "puzzle",
    // rust: "refresh",
    // rust: "search-01",
    // rust: "sliders-horizontal",
    // rust: "stop",
    // rust: "tick-02",
    // rust: "upload-04",
    // rust: "user",
    // rust: "user-add-01",
    // rust: "user-multiple-02",
    // rust: "view",
    // rust: "view-off-slash",
    // rust: );

    /// The icon called `name`, if there is one.
pub fn get(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ALL.iter().find(|(n, _)| *n == name).map(|(_, svg)| *svg)
}
}

/// The launcher's pixel icons: Pixelarticons (MIT, `icons/pixel/LICENSE-pixelarticons.txt`), 24
/// unit SVGs filled with `currentColor`, by name (`"home"`, `"play"`…).
    // rust: pub mod icons {
    // rust: macro_rules! icons {
    // rust: ($($name:literal),* $(,)?) => {
            /// Every icon, `(name, svg)`.
    // rust: pub const ALL: &[(&str, &[u8])] = &[
    // rust: $(($name, include_bytes!(concat!("../icons/pixel/", $name, ".svg")))),*
    // rust: ];
}
}
    // rust: icons!(
    // rust: "archive",
    // rust: "arrow-left",
    // rust: "book-open",
    // rust: "box",
    // rust: "bug",
    // rust: "check",
    // rust: "chevron-down",
    // rust: "chevron-right",
    // rust: "clock",
    // rust: "close",
    // rust: "download",
    // rust: "external-link",
    // rust: "folder",
    // rust: "gamepad",
    // rust: "globe",
    // rust: "heart",
    // rust: "home",
    // rust: "image",
    // rust: "info-box",
    // rust: "message",
    // rust: "monitor",
    // rust: "notes",
    // rust: "package",
    // rust: "play",
    // rust: "plus",
    // rust: "reload",
    // rust: "search",
    // rust: "server",
    // rust: "sliders",
        // Not Pixelarticons': drawn for Horizon's ratings, in the same 2-unit grid.
    // rust: "star",
    // rust: "terminal",
    // rust: "trash",
    // rust: "user",
    // rust: "zap",
    // rust: );

    /// An icon's SVG by name.
pub fn get(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ALL.iter().find(|(n, _)| *n == name).map(|(_, svg)| *svg)
}
}

/// Horizon's icon at 64 px (PNG), for window title bars and task bars at run time. Rendered from
/// `docs/media/brand/icon.svg` by `cargo run -p xtask -- icons`.
pub const ICON_PNG: []const u8 = include_bytes!("../icons/horizon-64.png");

/// How a type step sizes on the web.
pub const Web = enum {
    /// The app size, fixed.
    Fixed,
    /// From `min` px on a 375 px phone to `max` px at 1440 px and wider.
    Fluid(f32, f32),
    /// A share of the viewport width, in `vw`.
    Viewport(f32),
};

/// One step of the type scale.
pub const Step = struct {
    name: *'static str,
    /// The size in the apps (launcher and game menus).
    px: f32,
    web: Web,
    /// Line height as a multiple of the size.
    line: f32,
    /// Letter spacing in em.
    tracking: f32,
    weight: u16,
    mono: bool,
};

    // rust: impl Step {
    /// The line height in pixels at the app size.
pub fn line_px(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.px * self.line).round()
}
}

    // rust: const fn step(
    // rust: name: &'static str,
    // rust: px: f32,
    // rust: web: Web,
    // rust: line: f32,
    // rust: tracking: f32,
    // rust: weight: u16,
    // rust: mono: bool,
    // rust: ) -> Step {
    // rust: Step {
    // rust: name,
    // rust: px,
    // rust: web,
    // rust: line,
    // rust: tracking,
    // rust: weight,
    // rust: mono,
}
}

/// Indices (`01`), counts and timestamps, in mono.
pub const MICRO: Step = step("micro", 11., Web::Fixed, 1.5, 0.04, 400, true);
/// Footnotes and help under a control.
pub const CAPTION: Step = step("caption", 12., Web::Fixed, 1.5, 0., 400, false);
/// Row labels, navigation and buttons.
pub const LABEL: Step = step("label", 13., Web::Fixed, 1.5, 0., 400, false);
/// Body text in the apps.
pub const UI: Step = step("ui", 14., Web::Fixed, 1.5, 0., 400, false);
/// Paragraphs.
pub const BODY: Step = step("body", 15., Web::Fluid(15., 17.), 1.6, 0., 400, false);
/// Section heads.
pub const HEADING: Step = step("heading", 20., Web::Fluid(20., 24.), 1.3, -0.01, 500, false);
/// The names in an index list.
pub const TITLE: Step = step("title", 28., Web::Fluid(32., 48.), 1.05, -0.02, 500, false);
/// Page titles.
    // rust: pub const DISPLAY: Step = step(
    // rust: "display",
    // rust: 44.,
    // rust: Web::Fluid(34., 64.),
    // rust: 1.05,
    // rust: -0.025,
    // rust: 500,
    // rust: false,
    // rust: );
/// The giant faint signature.
pub const WORDMARK: Step = step("wordmark", 220., Web::Viewport(18.), 0.8, -0.04, 500, false);

    // rust: pub const TYPE: [Step; 9] = [
    // rust: MICRO, CAPTION, LABEL, UI, BODY, HEADING, TITLE, DISPLAY, WORDMARK,
    // rust: ];

/// The spacing scale.
pub const SPACE: [f32; 9] = [4., 8., 12., 16., 24., 32., 48., 64., 96.];
/// Page margins: wide windows and pages, and phones.
pub const GUTTER: f32 = 64.;
pub const GUTTER_NARROW: f32 = 16.;
/// The longest paragraph line, in characters.
pub const MEASURE: f32 = 56.;

/// Corner radii: fields and small controls; plates (hover rows, console, dialogs); pills
/// (buttons, segmented controls, switches).
pub const RADIUS: f32 = 8.;
pub const RADIUS_PLATE: f32 = 12.;
pub const RADIUS_PILL: f32 = 999.;
/// Rules between rows are one pixel; there are no other borders.
pub const RULE: f32 = 1.;

/// Heights: buttons, the one large action, a segment, a field, an index row in the apps and
/// on the web.
pub const CONTROL: f32 = 32.;
pub const CONTROL_LARGE: f32 = 40.;
pub const SEGMENT: f32 = 28.;
pub const FIELD: f32 = 36.;
pub const ROW: f32 = 64.;
pub const ROW_WEB: f32 = 86.;
/// The index column of a list (where `01` sits) and how far the hover plate reaches past a row.
pub const INDEX: f32 = 40.;
pub const PLATE_BLEED: f32 = 16.;
/// A pressed primary button's opacity, and disabled controls'.
pub const PRESSED: f32 = 0.85;
pub const DISABLED: f32 = 0.4;

/// A duration and its easing curve (CSS `cubic-bezier` control points).
pub const Motion = struct {
    name: *'static str,
    ms: u64,
    curve: [f32,
};

    // rust: impl Motion {
    // rust: pub const fn duration(&self) -> Duration {
    // rust: Duration::from_millis(self.ms)
}
pub fn secs(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ms as f32 / 1000.
}
    /// The eased progress for a linear `t` in 0..1.
pub fn ease(self: *Self, t: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bezier(self.curve, t)
}
}

/// Standard ease, for hovers, presses and colour.
    // rust: pub const QUICK: Motion = Motion {
    // rust: name: "quick",
    // rust: ms: 150,
    // rust: curve: [0.4, 0., 0.2, 1.],
}
/// Ease-out with a long tail, for selection, switches and page changes.
    // rust: pub const MOVE: Motion = Motion {
    // rust: name: "move",
    // rust: ms: 240,
    // rust: curve: [0.23, 1., 0.32, 1.],
}
/// Content arriving: a fade and a [`RISE`].
    // rust: pub const ENTER: Motion = Motion {
    // rust: name: "enter",
    // rust: ms: 600,
    // rust: curve: [0.23, 1., 0.32, 1.],
}
pub const MOTION: [Motion; 3] = [QUICK, MOVE, ENTER];
/// The delay between list rows arriving, and how far content rises as it arrives.
pub const STAGGER: Duration = Duration::from_millis(40);
pub const RISE: f32 = 8.;

/// The launcher's opening: the wordmark holds, then the interface arrives.
pub const OPENING_HOLD: Duration = Duration::from_millis(1400);
pub const OPENING_MAX: Duration = Duration::from_millis(2500);
pub const OPENING_REVEAL: Duration = Duration::from_millis(800);

/// A CSS `cubic-bezier(x1, y1, x2, y2)` at `t`: solves x for the curve parameter, returns y.
pub fn bezier(y2]: [f32; 4], t: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = t.clamp(0., 1.);
    // rust: if t == 0. || t == 1. {
    // rust: return t;
}
    // rust: let at = |a: f32, b: f32, s: f32| {
    // rust: let u = 1. - s;
    // rust: 3. * u * u * s * a + 3. * u * s * s * b + s * s * s
}
    // rust: let (mut lo, mut hi) = (0f32, 1f32);
    // rust: for _ in 0..24 {
    // rust: let mid = (lo + hi) / 2.;
    // rust: if at(x1, x2, mid) < t {
    // rust: lo = mid;
    // rust: } else {
    // rust: hi = mid;
}
}
    // rust: at(y1, y2, (lo + hi) / 2.)
}

pub fn ease_out_quint(t: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1. - (1. - t.clamp(0., 1.)).powi(5)
}
pub fn ease_out_cubic(t: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1. - (1. - t.clamp(0., 1.)).powi(3)
}

pub const Palette = struct {
    /// The background.
    page: u32,
    /// The hover plate, fields, the segmented track, the console.
    plate_soft: u32,
    /// Pressed plates, a switch that is off, the faint wordmark.
    plate: u32,
    /// Dialogs and menus above the page.
    surface: u32,
    /// One-pixel rules between rows, slider and progress tracks.
    rule: u32,
    /// Text, selection, the slider's fill.
    ink: u32,
    /// Secondary text and values.
    ink_soft: u32,
    /// Labels, descriptions, indices.
    muted: u32,
    /// The main action, links, focus, progress.
    accent: u32,
    on_accent: u32,
    danger: u32,
    success: u32,
    dark: bool,
};

    // rust: pub const LIGHT: Palette = Palette {
    // rust: page: 0xfafafc,
    // rust: plate_soft: 0xf3f3f8,
    // rust: plate: 0xebecf4,
    // rust: surface: 0xffffff,
    // rust: rule: 0xe2e3ea,
    // rust: ink: 0x16181f,
    // rust: ink_soft: 0x3b3e49,
    // rust: muted: 0x646875,
    // rust: accent: 0x5b3fd6,
    // rust: on_accent: 0xffffff,
    // rust: danger: 0xb4372a,
    // rust: success: 0x1d7a48,
    // rust: dark: false,
}

    // rust: pub const DARK: Palette = Palette {
    // rust: page: 0x0d0e13,
    // rust: plate_soft: 0x181a22,
    // rust: plate: 0x20222c,
    // rust: surface: 0x16181f,
    // rust: rule: 0x24262f,
    // rust: ink: 0xecedf3,
    // rust: ink_soft: 0xc5c7d1,
    // rust: muted: 0x8b8f9c,
    // rust: accent: 0x9a86ff,
    // rust: on_accent: 0x0d0e13,
    // rust: danger: 0xf07a68,
    // rust: success: 0x45c27a,
    // rust: dark: true,
}

/// The launcher's and the website's blocky look ("Blocks" in `docs/design-system.md`): stone-dark
/// (or lavender-light) neutrals with a violet cast, panels with a dark outline, a light bevel on top
/// and a darker lip below, and the violet `face` of the one big action. The game's menus keep
/// [`LIGHT`] and [`DARK`].
pub const Blocks = struct {
    /// The window behind everything, tiled with a faint stone texture.
    page: u32,
    /// The top bar and the sidebar.
    side: u32,
    /// Panels: rows, cards, dialogs.
    panel: u32,
    /// A selected or hovered panel or row, the open tab.
    raised: u32,
    /// Buttons and the chosen segment.
    button: u32,
    /// A button's top bevel.
    button_bevel: u32,
    /// Sunk wells: fields, tracks, switch and checkbox boxes, segmented tracks.
    well: u32,
    /// The light top (and left) edge of a panel.
    bevel: u32,
    /// The darker bottom edge of a panel or button.
    lip: u32,
    /// The 2 px outline around panels, buttons and wells.
    outline: u32,
    /// Rules between rows inside a panel.
    rule: u32,
    ink: u32,
    ink_soft: u32,
    muted: u32,
    /// Links, focus, progress, the selection marker; text-safe on every background.
    accent: u32,
    /// The main action's face (Play, Install, Download), its top bevel and bottom lip.
    face: u32,
    face_bevel: u32,
    face_lip: u32,
    on_face: u32,
    danger: u32,
    success: u32,
    /// "Partly": a mod or pack that runs in part.
    warn: u32,
    dark: bool,
};

    // rust: pub const BLOCKS_DARK: Blocks = Blocks {
    // rust: page: 0x0f0d17,
    // rust: side: 0x0b0a11,
    // rust: panel: 0x1a1727,
    // rust: raised: 0x221e34,
    // rust: button: 0x2b2641,
    // rust: button_bevel: 0x3d3560,
    // rust: well: 0x0c0b12,
    // rust: bevel: 0x342d52,
    // rust: lip: 0x07060b,
    // rust: outline: 0x05040a,
    // rust: rule: 0x120f1c,
    // rust: ink: 0xecedf3,
    // rust: ink_soft: 0xc5c7d1,
    // rust: muted: 0xa29cb8,
    // rust: accent: 0x9a86ff,
    // rust: face: 0x5b3fd6,
    // rust: face_bevel: 0x8a74ff,
    // rust: face_lip: 0x3a2694,
    // rust: on_face: 0xffffff,
    // rust: danger: 0xf07a68,
    // rust: success: 0x45c27a,
    // rust: warn: 0xf0b84f,
    // rust: dark: true,
}

    // rust: pub const BLOCKS_LIGHT: Blocks = Blocks {
    // rust: page: 0xece7f7,
    // rust: side: 0xe2dbf2,
    // rust: panel: 0xf8f6fd,
    // rust: raised: 0xe9e3f8,
    // rust: button: 0xddd4f3,
    // rust: button_bevel: 0xf4f0fe,
    // rust: well: 0xf3f0fb,
    // rust: bevel: 0xffffff,
    // rust: lip: 0xc3b8e2,
    // rust: outline: 0x2b2244,
    // rust: rule: 0xe4ddf4,
    // rust: ink: 0x1b1530,
    // rust: ink_soft: 0x3b3354,
    // rust: muted: 0x585071,
    // rust: accent: 0x5333c9,
    // rust: face: 0x5b3fd6,
    // rust: face_bevel: 0x8069ef,
    // rust: face_lip: 0x3a2694,
    // rust: on_face: 0xffffff,
    // rust: danger: 0xa3301d,
    // rust: success: 0x136336,
    // rust: warn: 0x7a4f00,
    // rust: dark: false,
}

/// Pixel sizes of the blocky look: outlines, bevels and lips, the cut corner, and the stone tile.
pub const BLOCK_OUTLINE: f32 = 2.;
pub const BLOCK_BEVEL: f32 = 2.;
pub const BLOCK_LIP: f32 = 4.;
/// The stone texture: a 16 by 16 tile, each texel this many logical pixels.
pub const TILE_TEXELS: usize = 16;
pub const TILE_TEXEL: f32 = 4.;
/// The texture's shades: the page colour moved this many levels (of 255) lighter or darker.
pub const TILE_SHADES: [i16; 5] = [0, 2, -2, 5, -4];

/// How strongly the game's menus veil the live backdrop (the title panorama, or the world behind
/// the pause and options screens) with the page colour. Every text colour the menus use keeps
/// WCAG AA over it, even on a selected row's plate, with a backdrop as bright as
/// [`BRIGHT_BACKDROP`] (a test checks it).
pub const VEIL: f32 = 0.90;
/// The title's home page shows more of the world; its text is `ink` and `ink_soft` only.
pub const HOME_VEIL: f32 = 0.80;
/// Muted text over the veiled backdrop: the dark palette's `muted`, lifted so it holds AA there.
pub const BACKDROP_MUTED: u32 = 0x9fa3ae;
/// The brightest backdrop the veils are measured against: a light grey of luminance 0.77,
/// brighter than the snowiest title panorama measured (0.49) and a sunlit world.
pub const BRIGHT_BACKDROP: u32 = 0xe3e3e3;

    // rust: impl Palette {
    /// Every colour with its token name, in the order the docs list them.
pub fn named(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: ("page", self.page),
    // rust: ("plate-soft", self.plate_soft),
    // rust: ("plate", self.plate),
    // rust: ("surface", self.surface),
    // rust: ("rule", self.rule),
    // rust: ("ink", self.ink),
    // rust: ("ink-soft", self.ink_soft),
    // rust: ("muted", self.muted),
    // rust: ("accent", self.accent),
    // rust: ("on-accent", self.on_accent),
    // rust: ("danger", self.danger),
    // rust: ("success", self.success),
    // rust: ]
}
}

    // rust: impl Blocks {
    /// Every colour by its CSS name. The website reads the Blocks palettes; the first twelve keep
    /// the names of [`Palette::named`] (`plate-soft` is `raised`, `plate` is `button`, `surface`
    /// is `panel`, `on-accent` is `on_face`), so styles written for those still apply.
pub fn named(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: ("page", self.page),
    // rust: ("plate-soft", self.raised),
    // rust: ("plate", self.button),
    // rust: ("surface", self.panel),
    // rust: ("rule", self.rule),
    // rust: ("ink", self.ink),
    // rust: ("ink-soft", self.ink_soft),
    // rust: ("muted", self.muted),
    // rust: ("accent", self.accent),
    // rust: ("on-accent", self.on_face),
    // rust: ("danger", self.danger),
    // rust: ("success", self.success),
    // rust: ("warn", self.warn),
    // rust: ("side", self.side),
    // rust: ("panel", self.panel),
    // rust: ("raised", self.raised),
    // rust: ("button", self.button),
    // rust: ("button-bevel", self.button_bevel),
    // rust: ("well", self.well),
    // rust: ("bevel", self.bevel),
    // rust: ("lip", self.lip),
    // rust: ("outline", self.outline),
    // rust: ("face", self.face),
    // rust: ("face-bevel", self.face_bevel),
    // rust: ("face-lip", self.face_lip),
    // rust: ]
}
}

/// The WCAG 2 contrast ratio of two colours.
pub fn contrast(a: u32, b: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
pub fn luminance(c: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ch = |s: u32| {
    // rust: let v = ((c >> s) & 255) as f32 / 255.;
    // rust: if v <= 0.03928 {
    // rust: v / 12.92
    // rust: } else {
    // rust: ((v + 0.055) / 1.055).powf(2.4)
}
}
    // rust: 0.2126 * ch(16) + 0.7152 * ch(8) + 0.0722 * ch(0)
}
    // rust: let (x, y) = (luminance(a), luminance(b));
    // rust: (x.max(y) + 0.05) / (x.min(y) + 0.05)
}

/// `tokens.css`: every token as a CSS custom property, the light palette by
/// default, the dark one when the system asks for it or the page sets `data-theme="dark"`.
pub fn css() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = String::new();
    // rust: let num = |v: f32| {
    // rust: let t = format!("{v:.3}");
    // rust: t.trim_end_matches('0').trim_end_matches('.').to_string()
}
    // The website wears the launcher's Blocks look; the game's menus keep LIGHT and DARK.
    // rust: let colors = |s: &mut String, p: &Blocks| {
    // rust: for (name, c) in p.named() {
    // rust: let _ = writeln!(s, "  --{name}: #{c:06x};");
}
    // rust: let _ = writeln!(s, "  --on-face: #{:06x};", p.on_face);
    // rust: let _ = writeln!(
    // rust: s,
    // rust: "  color-scheme: {};",
    // rust: if p.dark { "dark" } else { "light" }
    // rust: );
        // The launcher's night look, for pages that wear it.
    // rust: s.push_str(&if p.dark { night::NIGHT } else { night::DAWN }.css());
        // The launcher's glass look, the same in both appearances.
    // rust: s.push_str(&glass::Glass::default_look().css());
}
    // rust: s.push_str(
    // rust: "/* Generated from crates/horizon-theme by `cargo run -p xtask -- tokens`; do not edit.\n   \
    // rust: docs/design-system.md describes the tokens. */\n\n:root {\n",
    // rust: );
    // rust: colors(&mut s, &BLOCKS_LIGHT);
    // rust: let _ = writeln!(
    // rust: s,
    // rust: "  --font: \"{FONT}\", ui-sans-serif, system-ui, sans-serif;\n  --mono: \"{MONO}\", ui-monospace, monospace;\n  --pixel: \"{PIXEL}\", \"{FONT}\", ui-sans-serif, sans-serif;\n  --night-font: \"{}\", \"{FONT}\", ui-sans-serif, sans-serif;\n  --night-display-font: \"{}\", \"{}\", ui-sans-serif, sans-serif;",
    // rust: night::FONT,
    // rust: night::DISPLAY_FONT,
    // rust: night::FONT
    // rust: );
    // rust: for (name, v) in [
    // rust: ("block-outline", BLOCK_OUTLINE),
    // rust: ("block-bevel", BLOCK_BEVEL),
    // rust: ("block-lip", BLOCK_LIP),
    // rust: ] {
    // rust: let _ = writeln!(s, "  --{name}: {}px;", num(v));
}
    // rust: for step in TYPE.iter().chain(&night::TYPE) {
    // rust: let size = match step.web {
    // rust: Web::Fixed => format!("{}px", num(step.px)),
    // rust: Web::Fluid(min, max) => format!(
    // rust: "clamp({}px, calc({}px + {} * (100vw - 375px) / 1065), {}px)",
    // rust: num(min),
    // rust: num(min),
    // rust: num(max - min),
    // rust: num(max)
    // rust: ),
    // rust: Web::Viewport(vw) => format!("{}vw", num(vw)),
}
    // rust: let n = step.name;
    // rust: let _ = writeln!(s, "  --text-{n}: {size};");
    // rust: let _ = writeln!(s, "  --text-{n}-line: {};", num(step.line));
    // rust: let _ = writeln!(s, "  --text-{n}-tracking: {}em;", num(step.tracking));
    // rust: let _ = writeln!(s, "  --text-{n}-weight: {};", step.weight);
}
    // rust: for (i, v) in SPACE.iter().enumerate() {
    // rust: let _ = writeln!(s, "  --space-{}: {}px;", i + 1, num(*v));
}
    // rust: for (name, v) in [
    // rust: ("gutter", GUTTER),
    // rust: ("gutter-narrow", GUTTER_NARROW),
    // rust: ("radius", RADIUS),
    // rust: ("radius-plate", RADIUS_PLATE),
    // rust: ("radius-pill", RADIUS_PILL),
    // rust: ("rule-width", RULE),
    // rust: ("control", CONTROL),
    // rust: ("control-large", CONTROL_LARGE),
    // rust: ("segment", SEGMENT),
    // rust: ("field", FIELD),
    // rust: ("row", ROW_WEB),
    // rust: ("index", INDEX),
    // rust: ("plate-bleed", PLATE_BLEED),
    // rust: ("rise", RISE),
    // rust: ("night-pixel-corner", night::PIXEL_CORNER),
    // rust: ("night-radius-control", night::RADIUS_CONTROL),
    // rust: ("night-play", night::PLAY),
    // rust: ] {
    // rust: let _ = writeln!(s, "  --{name}: {}px;", num(v));
}
    // rust: let _ = writeln!(s, "  --measure: {}ch;", num(MEASURE));
    // rust: for m in MOTION {
    // rust: let [a, b, c, d] = m.curve;
    // rust: let _ = writeln!(s, "  --{}: {}ms;", m.name, m.ms);
    // rust: let _ = writeln!(
    // rust: s,
    // rust: "  --ease-{}: cubic-bezier({}, {}, {}, {});",
    // rust: m.name,
    // rust: num(a),
    // rust: num(b),
    // rust: num(c),
    // rust: num(d)
    // rust: );
}
    // rust: let _ = writeln!(s, "  --stagger: {}ms;", STAGGER.as_millis());
    // rust: s.push_str(
    // rust: "}\n\n@media (prefers-color-scheme: dark) {\n  :root:not([data-theme=\"light\"]) {\n",
    // rust: );
    // rust: let mut dark = String::new();
    // rust: colors(&mut dark, &BLOCKS_DARK);
    // rust: for line in dark.lines() {
    // rust: let _ = writeln!(s, "  {line}");
}
    // rust: s.push_str("  }\n}\n\n:root[data-theme=\"dark\"] {\n");
    // rust: s.push_str(&dark);
    // rust: s.push_str("}\n");
    // rust: s
}

    // rust: mod tests {
//     use super::*;

    /// Every text colour on every background it is drawn on reaches WCAG AA (4.5:1).
pub fn text_meets_wcag_aa_in_both_palettes() void {
}
    // rust: for p in [LIGHT, DARK] {
    // rust: let backgrounds = [
    // rust: ("page", p.page),
    // rust: ("plate_soft", p.plate_soft),
    // rust: ("plate", p.plate),
    // rust: ("surface", p.surface),
    // rust: ];
    // rust: let texts = [
    // rust: ("ink", p.ink),
    // rust: ("ink_soft", p.ink_soft),
    // rust: ("muted", p.muted),
    // rust: ("accent", p.accent),
    // rust: ("danger", p.danger),
    // rust: ("success", p.success),
    // rust: ];
    // rust: for (bn, bg) in backgrounds {
    // rust: for (tn, fg) in texts {
    // rust: let ratio = contrast(fg, bg);
    // rust: assert!(
    // rust: ratio >= 4.5,
    // rust: "{} {tn} on {bn}: {ratio:.2}",
    // rust: if p.dark { "dark" } else { "light" }
    // rust: );
}
}
            // Text on the accent, and page-coloured text on an ink segment.
    // rust: assert!(contrast(p.on_accent, p.accent) >= 4.5);
    // rust: assert!(contrast(p.page, p.ink) >= 4.5);
}
}

    /// The blocky look: every text colour on every background it is drawn on reaches AA, the
    /// main action's label too, and the focus ring (the accent) reaches 3:1 (WCAG 1.4.11).
pub fn blocks_text_meets_wcag_aa_in_both_appearances() void {
}
    // rust: for p in [
    // rust: BLOCKS_DARK,
    // rust: BLOCKS_LIGHT,
    // rust: night::NIGHT.blocks(),
    // rust: night::DAWN.blocks(),
    // rust: ] {
    // rust: let theme = if p.dark { "dark" } else { "light" };
    // rust: let backgrounds = [
    // rust: ("page", p.page),
    // rust: ("side", p.side),
    // rust: ("panel", p.panel),
    // rust: ("raised", p.raised),
    // rust: ("button", p.button),
    // rust: ("well", p.well),
    // rust: ];
    // rust: let texts = [
    // rust: ("ink", p.ink),
    // rust: ("ink_soft", p.ink_soft),
    // rust: ("muted", p.muted),
    // rust: ("accent", p.accent),
    // rust: ("danger", p.danger),
    // rust: ("success", p.success),
    // rust: ("warn", p.warn),
    // rust: ];
    // rust: for (bn, bg) in backgrounds {
    // rust: for (tn, fg) in texts {
    // rust: let ratio = contrast(fg, bg);
    // rust: assert!(ratio >= 4.5, "{theme} {tn} on {bn}: {ratio:.2}");
}
                // The texture's lightest shade under the page's text.
    // rust: let lifted = TILE_SHADES.iter().max().copied().unwrap_or(0) as i32;
    // rust: let shade = [16, 8, 0].iter().fold(0, |out, s| {
    // rust: let c = (((p.page >> s) & 255) as i32 + lifted).clamp(0, 255) as u32;
    // rust: out | c << s
    // rust: });
    // rust: for (tn, fg) in texts {
    // rust: let ratio = contrast(fg, shade);
    // rust: assert!(
    // rust: ratio >= 4.5,
    // rust: "{theme} {tn} on the stone texture: {ratio:.2}"
    // rust: );
}
}
    // rust: let label = contrast(p.on_face, p.face);
    // rust: assert!(label >= 4.5, "{theme} the main action's label: {label:.2}");
}
}

pub fn every_icon_is_a_pixel_svg() void {
}
    // rust: for (name, svg) in icons::ALL {
    // rust: let svg = std::str::from_utf8(svg).unwrap();
    // rust: assert!(svg.contains("viewBox=\"0 0 24 24\""), "{name}");
    // rust: assert!(svg.contains("currentColor"), "{name}");
}
    // rust: assert!(icons::get("play").is_some());
}

    /// The game's menus over the brightest backdrop: the page colour veiled over it, and a
    /// selected row's plate (ink at 8 %) on top.
pub fn menu_text_meets_wcag_aa_over_a_bright_backdrop() void {
}
    // rust: let mix = |a: u32, b: u32, t: f32| {
    // rust: [16, 8, 0].iter().fold(0, |out, s| {
    // rust: let (x, y) = (((a >> s) & 255) as f32, ((b >> s) & 255) as f32);
    // rust: out | ((x * (1. - t) + y * t).round() as u32) << s
    // rust: })
}
    // rust: let p = DARK;
    // rust: for (veil, texts) in [
    // rust: (
    // rust: VEIL,
    // rust: &[p.ink, p.ink_soft, BACKDROP_MUTED, p.danger, p.success][..],
    // rust: ),
    // rust: (HOME_VEIL, &[p.ink, p.ink_soft][..]),
    // rust: ] {
    // rust: let bg = mix(BRIGHT_BACKDROP, p.page, veil);
    // rust: let plate = mix(bg, p.ink, 0.08);
    // rust: for &text in texts {
    // rust: for under in [bg, plate] {
    // rust: let ratio = contrast(text, under);
    // rust: assert!(ratio >= 4.5, "#{text:06x} over veil {veil}: {ratio:.2}");
}
}
}
    // rust: assert!(contrast(BACKDROP_MUTED, p.page) >= 4.5);
}

pub fn contrast_matches_known_values() void {
}
    // rust: assert!((contrast(0x000000, 0xffffff) - 21.).abs() < 0.01);
    // rust: assert!((contrast(0x777777, 0xffffff) - 4.48).abs() < 0.01);
}

pub fn bezier_eases_out() void {
}
    // rust: assert_eq!(bezier(MOVE.curve, 0.), 0.);
    // rust: assert!((bezier(MOVE.curve, 1.) - 1.).abs() < 1e-4);
    // rust: assert!(MOVE.ease(0.25) > 0.6, "{}", MOVE.ease(0.25));
    // rust: assert!((bezier([0., 0., 1., 1.], 0.3) - 0.3).abs() < 1e-3);
}

    /// `tokens.css` (beside Cargo.toml, read by the website's build) is what [`css`] writes;
    /// regenerate it with `cargo run -p xtask -- tokens`.
pub fn tokens_css_is_up_to_date() void {
}
    // rust: let path = concat!(env!("CARGO_MANIFEST_DIR"), "/tokens.css");
    // rust: let written = std::fs::read_to_string(path).unwrap_or_default();
    // rust: assert!(
    // rust: written == css(),
    // rust: "crates/horizon-theme/tokens.css is out of date: run `cargo run -p xtask -- tokens`"
    // rust: );
}
}
