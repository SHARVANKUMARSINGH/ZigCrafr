//! Transpiled from Horizon Rust crate
package horizon_client_render_pvp

import "core:fmt"
import "core:mem"
import "core:math"

// PvP and HUD options (`docs/pvp.md`): a custom crosshair, block outline, hit colour and HUD
// widgets (`pvp_hud`). Kept in
// `horizon-extras.txt` with the other extras ([`crate::extras::Extras::pvp`]) and shown on
// Horizon Settings > PvP & HUD. Every option is off by default, so the game looks like
// vanilla until the player changes one, and none of them shows anything vanilla doesn't
// already tell the player.

// Colours the PvP options pick from. `Inverted` is vanilla's crosshair blend: the colour
// under it, inverted.
Colour :: enum {
    Inverted,
    White,
    Red,
    Orange,
    Yellow,
    Green,
    Cyan,
    Blue,
    Magenta,
    Black,
}
    // rust: impl Colour {
    // rust: pub const ALL: [Colour; 10] = [
    // rust: Colour::Inverted,
    // rust: Colour::White,
    // rust: Colour::Red,
    // rust: Colour::Orange,
    // rust: Colour::Yellow,
    // rust: Colour::Green,
    // rust: Colour::Cyan,
    // rust: Colour::Blue,
    // rust: Colour::Magenta,
    // rust: Colour::Black,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Colour::Inverted => "inverted",
    // rust: Colour::White => "white",
    // rust: Colour::Red => "red",
    // rust: Colour::Orange => "orange",
    // rust: Colour::Yellow => "yellow",
    // rust: Colour::Green => "green",
    // rust: Colour::Cyan => "cyan",
    // rust: Colour::Blue => "blue",
    // rust: Colour::Magenta => "magenta",
    // rust: Colour::Black => "black",
}
}
english :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Colour::Inverted => "Inverted",
    // rust: Colour::White => "White",
    // rust: Colour::Red => "Red",
    // rust: Colour::Orange => "Orange",
    // rust: Colour::Yellow => "Yellow",
    // rust: Colour::Green => "Green",
    // rust: Colour::Cyan => "Cyan",
    // rust: Colour::Blue => "Blue",
    // rust: Colour::Magenta => "Magenta",
    // rust: Colour::Black => "Black",
}
}
    // The name in the current language.
label :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::get_or(
    // rust: &format!("horizon.pvp.colour.{}", self.name()),
    // rust: self.english(),
    // rust: )
}
    // Opaque ARGB; white for `Inverted` (the blend makes it the inverse).
argb :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Colour::Inverted | Colour::White => 0xFFFF_FFFF,
    // rust: Colour::Red => 0xFFFF_0000,
    // rust: Colour::Orange => 0xFFFF_A020,
    // rust: Colour::Yellow => 0xFFFF_FF40,
    // rust: Colour::Green => 0xFF40_FF40,
    // rust: Colour::Cyan => 0xFF40_FFFF,
    // rust: Colour::Blue => 0xFF40_80FF,
    // rust: Colour::Magenta => 0xFFFF_40FF,
    // rust: Colour::Black => 0xFF00_0000,
}
}
parse :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|c| c.name() == s)
}
step :: proc(self: ^Self, back: bool) -> C {
    // Ported from Horizon
    return {}
}
    // rust: step(&Self::ALL, self, back)
}
    // The next solid colour (`Inverted` left out).
step_solid :: proc(self: ^Self, back: bool) -> C {
    // Ported from Horizon
    return {}
}
    // rust: step(&Self::ALL[1..], self, back)
}
    // The colour at `percent` opacity, as ARGB.
with_opacity :: proc(self: ^Self, percent: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.argb() & 0x00FF_FFFF | alpha(percent) << 24
}
}
// `percent` of 255, rounded.
alpha :: proc(percent: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (u32::from(percent.min(100)) * 255 + 50) / 100
}

// The next (or previous) value of `all` after `v`, wrapping.
    // rust: fn step<T: Copy + PartialEq>(all: &[T], v: T, back: bool) -> T {
    // rust: let i = all.iter().position(|&x| x == v).unwrap_or(0);
    // rust: let n = all.len();
    // rust: all[if back { (i + n - 1) % n } else { (i + 1) % n }]
}
// `v` one step up or down within `lo..=hi`, wrapping.
step_num :: proc(v: u8, lo: u8, hi: u8, back: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: step_by(v, (lo, hi), 1, back)
}
// `v` `by` up or down within `lo..=hi`, wrapping.
step_by :: proc(v: u8) {
}
    // rust: match (back, v) {
    // rust: (false, v) if v >= hi => lo,
    // rust: (false, v) => (v + by).min(hi),
    // rust: (true, v) if v <= lo => hi,
    // rust: (true, v) => v.saturating_sub(by).max(lo),
}
}

Shape :: enum {
    // Four arms, as vanilla's.
    Cross,
    // No arm above.
    T,
    // Four diagonal arms.
    X,
    Circle,
    Square,
    // Only the dot.
    Dot,
}
    // rust: impl Shape {
    // rust: pub const ALL: [Shape; 6] = [
    // rust: Shape::Cross,
    // rust: Shape::T,
    // rust: Shape::X,
    // rust: Shape::Circle,
    // rust: Shape::Square,
    // rust: Shape::Dot,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Shape::Cross => "cross",
    // rust: Shape::T => "t",
    // rust: Shape::X => "x",
    // rust: Shape::Circle => "circle",
    // rust: Shape::Square => "square",
    // rust: Shape::Dot => "dot",
}
}
english :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Shape::Cross => "Cross",
    // rust: Shape::T => "T",
    // rust: Shape::X => "X",
    // rust: Shape::Circle => "Circle",
    // rust: Shape::Square => "Square",
    // rust: Shape::Dot => "Dot",
}
}
label :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::get_or(
    // rust: &format!("horizon.pvp.shape.{}", self.name()),
    // rust: self.english(),
    // rust: )
}
parse :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|c| c.name() == s)
}
}

// A time of day this player's view can stay at (`ViewTime::day_time` in vanilla's ticks).
ViewTime :: enum {
    Morning,
    Noon,
    Sunset,
    Midnight,
}
    // rust: impl ViewTime {
    // rust: pub const ALL: [ViewTime; 4] = [
    // rust: ViewTime::Morning,
    // rust: ViewTime::Noon,
    // rust: ViewTime::Sunset,
    // rust: ViewTime::Midnight,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: ViewTime::Morning => "morning",
    // rust: ViewTime::Noon => "noon",
    // rust: ViewTime::Sunset => "sunset",
    // rust: ViewTime::Midnight => "midnight",
}
}
english :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: ViewTime::Morning => "Morning",
    // rust: ViewTime::Noon => "Noon",
    // rust: ViewTime::Sunset => "Sunset",
    // rust: ViewTime::Midnight => "Midnight",
}
}
    // The time of day it shows, as `/time set` takes it.
day_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: ViewTime::Morning => 1000,
    // rust: ViewTime::Noon => 6000,
    // rust: ViewTime::Sunset => 12500,
    // rust: ViewTime::Midnight => 18000,
}
}
label :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::get_or(&format!("horizon.pvp.time.{}", self.name()), self.english())
}
parse :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|c| c.name() == s)
}
}
// The weather this player's view can show.
ViewWeather :: enum {
    Clear,
    Rain,
    Thunder,
}
    // rust: impl ViewWeather {
ALL :: [ViewWeather::Clear, ViewWeather::Rain, ViewWeather::Thunder]
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: ViewWeather::Clear => "clear",
    // rust: ViewWeather::Rain => "rain",
    // rust: ViewWeather::Thunder => "thunder",
}
}
english :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: ViewWeather::Clear => "Clear",
    // rust: ViewWeather::Rain => "Rain",
    // rust: ViewWeather::Thunder => "Thunder",
}
}
    // `Level.getRainLevel` and `getThunderLevel` as `/weather` leaves them.
levels :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: ViewWeather::Clear => (0.0, 0.0),
    // rust: ViewWeather::Rain => (1.0, 0.0),
    // rust: ViewWeather::Thunder => (1.0, 1.0),
}
}
label :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::get_or(
    // rust: &format!("horizon.pvp.weather.{}", self.name()),
    // rust: self.english(),
    // rust: )
}
parse :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|c| c.name() == s)
}
}
// The day time this player sees with `fixed` set: the same day (the moon's phase follows the
// world's), at that time.
view_day_time :: proc(world: i64, fixed: Maybe(ViewTime)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match fixed {
    // rust: Some(t) => world.div_euclid(24000) * 24000 + t.day_time(),
    // rust: None => world,
}
}

// The crosshair's look. Its defaults draw vanilla's: a 15-pixel cross, one pixel thick,
// inverting what is under it.
Crosshair :: struct {
    // Off: vanilla's crosshair sprite (a resource pack's included).
    custom: bool,
    shape: Shape,
    // Arm length in GUI pixels (the circle's and square's radius past the gap).
    size: u8,
    gap: u8,
    thickness: u8,
    colour: Colour,
    // A one-pixel black rim around every part.
    outline: bool,
    // A dot in the middle.
    dot: bool,
    // The colour while the crosshair is over a living entity; `None` keeps `colour`.
    hover: Maybe(Colour),
}
SIZES :: (1, 12)
GAPS :: (0, 8)
THICKNESSES :: (1, 4)
    // rust: impl Default for Crosshair {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: custom: false,
    // rust: shape: Shape::Cross,
    // rust: size: 7,
    // rust: gap: 0,
    // rust: thickness: 1,
    // rust: colour: Colour::Inverted,
    // rust: outline: false,
    // rust: dot: false,
    // rust: hover: None,
}
}
}

// The crosshair's pixels on a 64x64 grid centred on bit 32 of row 32 (the middle pixel of
// vanilla's 15x15 sprite): bit `x` of row `y` is the pixel `x - 32`, `y - 32` from it.
Mask :: struct {
MASK_CENTRE :: 32
    // rust: impl Mask {
set :: proc(self: ^Self, x: i32, y: i32) {
}
    // rust: let (gx, gy) = (x + MASK_CENTRE, y + MASK_CENTRE);
    // rust: if (0..64).contains(&gx) && (0..64).contains(&gy) {
    // rust: self.0[gy as usize] |= 1 << gx;
}
}
rect :: proc(self: ^Self, x0: i32, y0: i32, x1: i32, y1: i32) {
}
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: self.set(x, y);
}
}
}
get :: proc(self: ^Self, x: i32, y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (gx, gy) = (x + MASK_CENTRE, y + MASK_CENTRE);
    // rust: (0..64).contains(&gx) && (0..64).contains(&gy) && self.0[gy as usize] >> gx & 1 == 1
}
    // The pixels around this mask's (eight neighbours) that are not in it.
rim :: proc(self: ^Self) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut grown = [0u64; 64];
    // rust: for (y, &row) in self.0.iter().enumerate() {
    // rust: let spread = row | row << 1 | row >> 1;
    // rust: for dy in [y.wrapping_sub(1), y, y + 1] {
    // rust: if let Some(g) = grown.get_mut(dy) {
    // rust: *g |= spread;
}
}
}
    // rust: for (g, &row) in grown.iter_mut().zip(&self.0) {
    // rust: *g &= !row;
}
    // rust: Mask(grown)
}
    // Each row's runs of set pixels as (x0, y, x1) offsets from the centre, `x1` exclusive.
runs :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter().enumerate().flat_map(|(y, &row)| {
    // rust: let mut bits = row;
    // rust: std::iter::from_fn(move || {
    // rust: if bits == 0 {
    // rust: return None;
}
    // rust: let start = bits.trailing_zeros();
    // rust: let len = (bits >> start).trailing_ones();
    // rust: bits &= !((((1u128 << len) - 1) as u64) << start);
    // rust: let y = y as i32 - MASK_CENTRE;
    // rust: let x0 = start as i32 - MASK_CENTRE;
    // rust: Some((x0, y, x0 + len as i32))
    // rust: })
    // rust: })
}
}
    // rust: impl Crosshair {
    // The pixels of the shape and its dot.
mask :: proc(self: ^Self) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = Mask([0; 64]);
    // rust: let t = i32::from(self.thickness.clamp(THICKNESSES.0, THICKNESSES.1));
        // A thickness band centred on the middle pixel (the extra pixel of an even one
        // below and right).
    // rust: let (lo, hi) = (-(t - 1) / 2, -(t - 1) / 2 + t - 1);
    // rust: let size = i32::from(self.size.clamp(SIZES.0, SIZES.1));
    // rust: let gap = i32::from(self.gap.min(GAPS.1));
    // rust: let (near, far) = (hi + 1 + gap, hi + gap + size);
    // rust: let (near_neg, far_neg) = (lo - 1 - gap, lo - gap - size);
    // rust: match self.shape {
    // rust: Shape::Cross | Shape::T => {
    // rust: m.rect(near, lo, far, hi);
    // rust: m.rect(far_neg, lo, near_neg, hi);
    // rust: m.rect(lo, near, hi, far);
    // rust: if self.shape == Shape::Cross {
    // rust: m.rect(lo, far_neg, hi, near_neg);
}
    // rust: if gap == 0 {
    // rust: m.rect(lo, lo, hi, hi);
}
}
    // rust: Shape::X => {
    // rust: for d in gap + 1..=gap + size {
    // rust: for (sx, sy) in [(1, 1), (1, -1), (-1, 1), (-1, -1)] {
    // rust: let (x, y) = (sx * d, sy * d);
    // rust: m.rect(x + lo, y + lo, x + hi, y + hi);
}
}
    // rust: if gap == 0 {
    // rust: m.rect(lo, lo, hi, hi);
}
}
    // rust: Shape::Circle | Shape::Square => {
    // rust: let outer = gap + size;
    // rust: let inner = outer - t;
    // rust: for y in -outer..=outer {
    // rust: for x in -outer..=outer {
    // rust: let inside = |r: i32| match self.shape {
    // rust: Shape::Circle => {
    // rust: let d = ((x * x + y * y) as f32).sqrt();
    // rust: d <= r as f32 + 0.5
}
    // rust: _ => x.abs().max(y.abs()) <= r,
}
    // rust: if inside(outer) && !inside(inner) {
    // rust: m.set(x, y);
}
}
}
}
    // rust: Shape::Dot => {}
}
    // rust: if self.dot || self.shape == Shape::Dot {
    // rust: m.rect(lo, lo, hi, hi);
}
    // rust: m
}
}

// The crosshair's draw list, cached: rebuilt only when its settings change.
CrosshairCache :: struct {
    key: Maybe(Crosshair),
    shape: Vec<(i32,
    rim: Vec<(i32,
}
    // rust: impl CrosshairCache {
    // The shape's runs and its outline's (empty without one), as [`Mask::runs`].
runs :: proc(self: ^Self, c: ^Crosshair) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.key != Some(*c) {
    // rust: let mask = c.mask();
    // rust: self.shape.clear();
    // rust: self.shape.extend(mask.runs());
    // rust: self.rim.clear();
    // rust: if c.outline {
    // rust: self.rim.extend(mask.rim().runs());
}
    // rust: self.key = Some(*c);
}
    // rust: (&self.shape, &self.rim)
}
}

// The block outline (`LevelRenderer.submitBlockOutline`). Off, vanilla's: black at 40%, or the
// accessibility option's high contrast one.
Outline :: struct {
    custom: bool,
    // A solid colour, at `opacity` percent.
    colour: Colour,
    opacity: u8,
    // Times vanilla's width (`Window.getAppropriateLineWidth`).
    thickness: u8,
    // The block's faces tinted with this colour, lightly.
    fill: Maybe(Colour),
}
OPACITIES :: (10, 100)
OUTLINE_THICKNESSES :: (1, 4)
// How much the fill covers the block's faces, in percent.
FILL_OPACITY :: 25
    // rust: impl Default for Outline {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: custom: false,
    // rust: colour: Colour::Black,
    // rust: opacity: 40,
    // rust: thickness: 1,
    // rust: fill: None,
}
}
}
    // rust: impl Outline {
    // The stroke's ARGB and its width as a multiple of vanilla's; none for vanilla's.
stroke :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.custom.then(|| {
    // rust: (
    // rust: self.colour.with_opacity(self.opacity),
    // rust: f32::from(self.thickness),
    // rust: )
    // rust: })
}
    // The fill's ARGB, when there is one.
fill :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.fill
    // rust: .filter(|_| self.custom)
    // rust: .map(|c| c.with_opacity(FILL_OPACITY))
}
}
// The tint a hurt entity flashes (`OverlayTexture`'s red rows). Off, vanilla's: red over 30%.
Hit :: struct {
    custom: bool,
    colour: Colour,
    // How much of the colour covers the entity, in percent.
    opacity: u8,
}
HIT_OPACITIES :: (0, 100)
    // rust: impl Default for Hit {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: custom: false,
    // rust: colour: Colour::Red,
    // rust: opacity: 30,
}
}
}
    // rust: impl Hit {
    // The overlay texel as RGBA bytes in a little-endian u32 (WGSL's `unpack4x8unorm`), its alpha
    // what of the entity's own colour stays (`entity.fsh` mixes by it); 0 for vanilla's texel.
texel :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if !self.custom {
    // rust: return 0;
}
    // rust: let [_, r, g, b] = self.colour.argb().to_be_bytes();
    // rust: u32::from_le_bytes([r, g, b, (255 - alpha(self.opacity)) as u8])
}
}

// What the renderer reads of these options each frame (`FrameInputs::pvp`); the default is
// vanilla's look.
Frame :: struct {
    // The block outline's stroke ([`Outline::stroke`]).
    outline: Option<(u32,
    // The hurt overlay texel ([`Hit::texel`]), 0 for vanilla's.
    hurt_texel: u32,
    // The glint's colour ([`Tweaks::glint_texel`]), 0 for vanilla's.
    glint: u32,
}
    // rust: impl Pvp {
frame :: proc(self: ^Self) -> F {
    // Ported from Horizon
    return {}
}
    // rust: Frame {
    // rust: outline: self.outline.stroke(),
    // rust: hurt_texel: self.hit.texel(),
    // rust: glint: self.tweaks.glint_texel(),
}
}
}

// The HUD widgets (`pvp_hud`), each in a corner of its own.
Hud :: struct {
    // The armour worn, head first, with each piece's durability.
    armour: bool,
    armour_corner: Corner,
    armour_percent: bool,
    // The active effects: icon, name and level, time left. They replace vanilla's icons.
    effects: bool,
    effects_corner: Corner,
    // How many of the held item the inventory holds (arrows with a bow or crossbow).
    held: bool,
    held_corner: Corner,
    // The latency the server reports for this player (the tab list's bars), in multiplayer.
    ping: bool,
    ping_corner: Corner,
    // The block position and the direction faced, as F3 shows them; hidden when F3 is
    // reduced (`reducedDebugInfo`).
    coords: bool,
    coords_corner: Corner,
    // The server's address, in multiplayer.
    server: bool,
    server_corner: Corner,
    // Hits in a row the server confirmed, until this player is hurt or 3 seconds pass.
    combo: bool,
    combo_corner: Corner,
    // Frames drawn in the last second.
    fps: bool,
    fps_corner: Corner,
    // Left and right clicks in the last second.
    cps: bool,
    cps_corner: Corner,
    // The movement keys, mouse buttons and jump, lit while held, with clicks per second.
    keys: bool,
    keys_corner: Corner,
    // The computer's local time.
    clock: bool,
    clock_corner: Corner,
    // How far the last hit landed from the eyes, for 3 seconds; it only measures.
    reach: bool,
    reach_corner: Corner,
    // Horizontal speed in blocks per second.
    speed: bool,
    speed_corner: Corner,
    // A dark box behind each widget.
    background: bool,
    // The boxes' opacity, in percent.
    opacity: u8,
    // The widgets' text colour (durability keeps its own).
    text: Colour,
    // A shadow under the widgets' text, as vanilla's HUD text has.
    shadow: bool,
}
    // rust: impl Hud {
    // Whether any widget is on: with none, the HUD draws nothing and reads nothing.
any :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: self.armour,
    // rust: self.effects,
    // rust: self.held,
    // rust: self.ping,
    // rust: self.coords,
    // rust: self.server,
    // rust: self.combo,
    // rust: self.fps,
    // rust: self.cps,
    // rust: self.keys,
    // rust: self.clock,
    // rust: self.reach,
    // rust: self.speed,
    // rust: ]
    // rust: .contains(&true)
}
}
    // rust: impl Default for Hud {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: armour: false,
    // rust: armour_corner: Corner::BottomRight,
    // rust: armour_percent: false,
    // rust: effects: false,
    // rust: effects_corner: Corner::TopRight,
    // rust: held: false,
    // rust: held_corner: Corner::BottomRight,
    // rust: ping: false,
    // rust: ping_corner: Corner::TopLeft,
    // rust: coords: false,
    // rust: coords_corner: Corner::TopLeft,
    // rust: server: false,
    // rust: server_corner: Corner::TopLeft,
    // rust: combo: false,
    // rust: combo_corner: Corner::TopLeft,
    // rust: fps: false,
    // rust: fps_corner: Corner::TopLeft,
    // rust: cps: false,
    // rust: cps_corner: Corner::TopLeft,
    // rust: keys: false,
    // rust: keys_corner: Corner::BottomLeft,
    // rust: clock: false,
    // rust: clock_corner: Corner::TopRight,
    // rust: reach: false,
    // rust: reach_corner: Corner::TopLeft,
    // rust: speed: false,
    // rust: speed_corner: Corner::TopLeft,
    // rust: background: true,
    // rust: opacity: HUD_OPACITY,
    // rust: text: Colour::White,
    // rust: shadow: true,
}
}
}
    // rust: pub use crate::extras::Corner;
// The widgets' boxes at first: the extras' 0x78 alpha, 47%.
HUD_OPACITY :: 47
HUD_OPACITIES :: (0, 100)
    // rust: impl Hud {
    // The boxes' colour, ARGB.
background_argb :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: alpha(self.opacity) << 24
}
}
// The value of the view options while they follow the world.
world_label :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::get_or("horizon.pvp.view.world", "World's")
}
corner_label :: proc(c: Corner) -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::get_or(&format!("horizon.pvp.corner.{}", c.name()), c.label())
}

// Smaller changes to what vanilla shows.
Tweaks :: struct {
    // Enchantment levels as numbers in tooltips ("Sharpness 5").
    numeric_enchants: bool,
    // How far down the first-person fire overlay moves, in percent of its height (0: vanilla).
    fire_lower: u8,
    // The first-person shield's size, in percent (100: vanilla).
    shield_size: u8,
    // The totem animation's size, in percent (100: vanilla).
    totem_size: u8,
    // The enchantment glint's colour; `None` is vanilla's purple.
    glint: Maybe(Colour),
    // Water fog as after 30 seconds under water (vanilla's clearest), from the first moment.
    clear_water: bool,
    // Lava fog as with Fire Resistance (vanilla's clearest), without the effect.
    clear_lava: bool,
    // The time of day this player sees, `None` for the world's. Never sent to the server.
    time: Maybe(ViewTime),
    // The weather this player sees, `None` for the world's. Never sent to the server.
    weather: Maybe(ViewWeather),
}
    // rust: impl Default for Tweaks {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: numeric_enchants: false,
    // rust: fire_lower: 0,
    // rust: shield_size: 100,
    // rust: totem_size: 100,
    // rust: glint: None,
    // rust: clear_water: false,
    // rust: clear_lava: false,
    // rust: time: None,
    // rust: weather: None,
}
}
}
FIRE_LOWER :: (0, 80)
SHIELD_SIZES :: (50, 100)
TOTEM_SIZES :: (25, 100)
    // rust: impl Tweaks {
    // `colour` as the glint shaders read it: `0` for vanilla's, else `0xFF` alpha over RGB in
    // little-endian bytes (`unpack4x8unorm`'s order).
glint_texel :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.glint.map_or(0, |c| {
    // rust: let [_, r, g, b] = c.argb().to_be_bytes();
    // rust: u32::from_le_bytes([r, g, b, 255])
    // rust: })
}
}

// Chat options.
ChatOptions :: struct {
    // The local time before each message.
    timestamps: bool,
    // A message repeated in a row shows once with its count.
    compact: bool,
    // A click on a message (where it has no click action) copies it.
    copy: bool,
    // Ctrl+F in the chat searches the chat's messages.
    search: bool,
}
    // rust: impl ChatOptions {
    // What `chat::Chat` lays its lines out with.
qol :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::chat::ChatQol {
    // rust: timestamps: self.timestamps,
    // rust: compact: self.compact,
}
}
}

// Combat feel (`docs/pvp.md`): how fights look. Legacy draws them as 1.8.9 did; what the
// game sends to a server never changes, so a vanilla server and its anticheat see 26.3.
Combat :: struct {
    // Legacy (1.8.9) instead of Modern.
    legacy: bool,
    // Keep the attack indicator under Legacy (1.8.9 had none).
    indicator: bool,
    // Under Legacy, silence the attack sounds 1.9 added (1.8.9 played none on a hit).
    sounds: bool,
    // The worlds this game hosts (single player and LAN) fight by 1.8.9's rules: no attack
    // cooldown, no sweep, 1.8 weapon damage, effects, enchantments and critical hits
    // (`horizon_client::legacy_combat`). Never used as a client of a server.
    rules: bool,
}
    // rust: impl Combat {
    // Whether this client leaves out sound `name` a server sent: under Legacy with its
    // sounds, the `entity.player.attack.*` family (strong, weak, crit, sweep, knockback,
    // nodamage), which 1.9 brought with the attack cooldown.
mutes_sound :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: self.legacy && self.sounds && name.starts_with("entity.player.attack.")
}
    // Whether this client leaves out particles of `ty` a server sent: under Legacy, the
    // sweep and the damage hearts, which 1.9 brought (1.8.9's hits show crits only).
hides_particle :: proc(self: ^Self, ty: crate::particles::ParticleType) -> b {
    // Ported from Horizon
    return {}
}
//         use crate::particles::ParticleType as T;
    // rust: self.legacy && matches!(ty, T::SweepAttack | T::DamageIndicator)
}
}

Pvp :: struct {
    crosshair: Crosshair,
    outline: Outline,
    hit: Hit,
    hud: Hud,
    tweaks: Tweaks,
    chat: ChatOptions,
    // Where each HUD widget sits and its size.
    layout: crate::pvp_hud::Layout,
    // The key that opens the HUD editor from the game (unbound at first).
    editor_key: string,
    combat: Combat,
}
// The HUD editor key's name for the controls (`Extras::set_key`).
HUD_EDITOR_KEY :: "horizon.hud_editor"
    // rust: impl Default for Pvp {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: crosshair: Crosshair::default(),
    // rust: outline: Outline::default(),
    // rust: hit: Hit::default(),
    // rust: hud: Hud::default(),
    // rust: tweaks: Tweaks::default(),
    // rust: chat: ChatOptions::default(),
    // rust: layout: crate::pvp_hud::Layout::default(),
    // rust: editor_key: "key.keyboard.unknown".into(),
    // rust: combat: Combat::default(),
}
}
}
flag :: proc(value: string, d: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match value {
    // rust: "true" => true,
    // rust: "false" => false,
    // rust: _ => d,
}
}
num :: proc(value: string) {
}
    // rust: value.parse::<u8>().map_or(d, |v| v.clamp(lo, hi))
}
    // rust: impl Pvp {
    // One `key:value` line of `horizon-extras.txt`; false when the key isn't a PvP one.
parse_line :: proc(self: ^Self, key: string, value: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let c = &mut self.crosshair;
    // rust: let (o, h, u) = (&mut self.outline, &mut self.hit, &mut self.hud);
    // rust: let t = &mut self.tweaks;
    // rust: match key {
    // rust: "crosshair" => c.custom = flag(value, c.custom),
    // rust: "crosshairShape" => c.shape = Shape::parse(value).unwrap_or(c.shape),
    // rust: "crosshairSize" => c.size = num(value, SIZES, c.size),
    // rust: "crosshairGap" => c.gap = num(value, GAPS, c.gap),
    // rust: "crosshairThickness" => c.thickness = num(value, THICKNESSES, c.thickness),
    // rust: "crosshairColour" => c.colour = Colour::parse(value).unwrap_or(c.colour),
    // rust: "crosshairOutline" => c.outline = flag(value, c.outline),
    // rust: "crosshairDot" => c.dot = flag(value, c.dot),
    // rust: "crosshairHover" => {
    // rust: c.hover = match value {
    // rust: "off" => None,
    // rust: v => Colour::parse(v).or(c.hover),
}
}
    // rust: "outline" => o.custom = flag(value, o.custom),
    // rust: "outlineColour" => o.colour = Colour::parse(value).unwrap_or(o.colour),
    // rust: "outlineOpacity" => o.opacity = num(value, OPACITIES, o.opacity),
    // rust: "outlineThickness" => o.thickness = num(value, OUTLINE_THICKNESSES, o.thickness),
    // rust: "outlineFill" => {
    // rust: o.fill = match value {
    // rust: "off" => None,
    // rust: v => Colour::parse(v).or(o.fill),
}
}
    // rust: "hit" => h.custom = flag(value, h.custom),
    // rust: "hitColour" => h.colour = Colour::parse(value).unwrap_or(h.colour),
    // rust: "hitOpacity" => h.opacity = num(value, HIT_OPACITIES, h.opacity),
    // rust: "hudArmour" => u.armour = flag(value, u.armour),
    // rust: "hudArmourCorner" => u.armour_corner = Corner::parse(value, u.armour_corner),
    // rust: "hudArmourPercent" => u.armour_percent = flag(value, u.armour_percent),
    // rust: "hudEffects" => u.effects = flag(value, u.effects),
    // rust: "hudEffectsCorner" => u.effects_corner = Corner::parse(value, u.effects_corner),
    // rust: "hudHeld" => u.held = flag(value, u.held),
    // rust: "hudHeldCorner" => u.held_corner = Corner::parse(value, u.held_corner),
    // rust: "hudBackground" => u.background = flag(value, u.background),
    // rust: "hudOpacity" => u.opacity = num(value, HUD_OPACITIES, u.opacity),
    // rust: "hudTextColour" => {
    // rust: u.text = Colour::parse(value)
    // rust: .filter(|c| *c != Colour::Inverted)
    // rust: .unwrap_or(u.text)
}
    // rust: "hudShadow" => u.shadow = flag(value, u.shadow),
    // rust: "hudPlace" => self.layout.parse(value),
    // rust: "hudEditorKey" if value.starts_with("key.") => self.editor_key = value.to_owned(),
    // rust: "hudPing" => u.ping = flag(value, u.ping),
    // rust: "hudPingCorner" => u.ping_corner = Corner::parse(value, u.ping_corner),
    // rust: "hudCoords" => u.coords = flag(value, u.coords),
    // rust: "hudCoordsCorner" => u.coords_corner = Corner::parse(value, u.coords_corner),
    // rust: "hudServer" => u.server = flag(value, u.server),
    // rust: "hudServerCorner" => u.server_corner = Corner::parse(value, u.server_corner),
    // rust: "hudCombo" => u.combo = flag(value, u.combo),
    // rust: "hudComboCorner" => u.combo_corner = Corner::parse(value, u.combo_corner),
    // rust: "hudFps" => u.fps = flag(value, u.fps),
    // rust: "hudFpsCorner" => u.fps_corner = Corner::parse(value, u.fps_corner),
    // rust: "hudCps" => u.cps = flag(value, u.cps),
    // rust: "hudCpsCorner" => u.cps_corner = Corner::parse(value, u.cps_corner),
    // rust: "hudKeys" => u.keys = flag(value, u.keys),
    // rust: "hudKeysCorner" => u.keys_corner = Corner::parse(value, u.keys_corner),
    // rust: "hudClock" => u.clock = flag(value, u.clock),
    // rust: "hudClockCorner" => u.clock_corner = Corner::parse(value, u.clock_corner),
    // rust: "hudReach" => u.reach = flag(value, u.reach),
    // rust: "hudReachCorner" => u.reach_corner = Corner::parse(value, u.reach_corner),
    // rust: "hudSpeed" => u.speed = flag(value, u.speed),
    // rust: "hudSpeedCorner" => u.speed_corner = Corner::parse(value, u.speed_corner),
    // rust: "numericEnchants" => t.numeric_enchants = flag(value, t.numeric_enchants),
    // rust: "lowFire" => t.fire_lower = num(value, FIRE_LOWER, t.fire_lower),
    // rust: "shieldSize" => t.shield_size = num(value, SHIELD_SIZES, t.shield_size),
    // rust: "totemSize" => t.totem_size = num(value, TOTEM_SIZES, t.totem_size),
    // rust: "glintColour" => {
    // rust: t.glint = match value {
    // rust: "off" => None,
    // rust: v => Colour::parse(v).or(t.glint),
}
}
    // rust: "clearWater" => t.clear_water = flag(value, t.clear_water),
    // rust: "clearLava" => t.clear_lava = flag(value, t.clear_lava),
    // rust: "chatTimestamps" => self.chat.timestamps = flag(value, self.chat.timestamps),
    // rust: "chatCompact" => self.chat.compact = flag(value, self.chat.compact),
    // rust: "chatCopy" => self.chat.copy = flag(value, self.chat.copy),
    // rust: "chatSearch" => self.chat.search = flag(value, self.chat.search),
    // rust: "combatFeel" => match value {
    // rust: "legacy" => self.combat.legacy = true,
    // rust: "modern" => self.combat.legacy = false,
    // rust: _ => {}
    // rust: },
    // rust: "combatIndicator" => self.combat.indicator = flag(value, self.combat.indicator),
    // rust: "combatSounds" => self.combat.sounds = flag(value, self.combat.sounds),
    // rust: "combatRules" => self.combat.rules = flag(value, self.combat.rules),
    // rust: "viewTime" => {
    // rust: t.time = match value {
    // rust: "off" => None,
    // rust: v => ViewTime::parse(v).or(t.time),
}
}
    // rust: "viewWeather" => {
    // rust: t.weather = match value {
    // rust: "off" => None,
    // rust: v => ViewWeather::parse(v).or(t.weather),
}
}
    // rust: _ => return false,
}
    // rust: true
}
    // The PvP lines of `horizon-extras.txt`.
serialize :: proc(self: ^Self, out: ^string) {
}
//         use std::fmt::Write;
    // rust: let c = &self.crosshair;
    // rust: let _ = write!(
    // rust: out,
    // rust: "crosshair:{}\ncrosshairShape:{}\ncrosshairSize:{}\ncrosshairGap:{}\ncrosshairThickness:{}\ncrosshairColour:{}\ncrosshairOutline:{}\ncrosshairDot:{}\ncrosshairHover:{}\n",
    // rust: c.custom,
    // rust: c.shape.name(),
    // rust: c.size,
    // rust: c.gap,
    // rust: c.thickness,
    // rust: c.colour.name(),
    // rust: c.outline,
    // rust: c.dot,
    // rust: c.hover.map_or("off", Colour::name),
    // rust: );
    // rust: let (o, h) = (&self.outline, &self.hit);
    // rust: let _ = write!(
    // rust: out,
    // rust: "outline:{}\noutlineColour:{}\noutlineOpacity:{}\noutlineThickness:{}\noutlineFill:{}\nhit:{}\nhitColour:{}\nhitOpacity:{}\n",
    // rust: o.custom,
    // rust: o.colour.name(),
    // rust: o.opacity,
    // rust: o.thickness,
    // rust: o.fill.map_or("off", Colour::name),
    // rust: h.custom,
    // rust: h.colour.name(),
    // rust: h.opacity,
    // rust: );
    // rust: let u = &self.hud;
    // rust: let _ = write!(
    // rust: out,
    // rust: "hudArmour:{}\nhudArmourCorner:{}\nhudArmourPercent:{}\nhudEffects:{}\nhudEffectsCorner:{}\nhudHeld:{}\nhudHeldCorner:{}\nhudBackground:{}\n",
    // rust: u.armour,
    // rust: u.armour_corner.name(),
    // rust: u.armour_percent,
    // rust: u.effects,
    // rust: u.effects_corner.name(),
    // rust: u.held,
    // rust: u.held_corner.name(),
    // rust: u.background,
    // rust: );
    // rust: let _ = write!(
    // rust: out,
    // rust: "hudPing:{}\nhudPingCorner:{}\nhudCoords:{}\nhudCoordsCorner:{}\nhudServer:{}\nhudServerCorner:{}\nhudCombo:{}\nhudComboCorner:{}\n",
    // rust: u.ping,
    // rust: u.ping_corner.name(),
    // rust: u.coords,
    // rust: u.coords_corner.name(),
    // rust: u.server,
    // rust: u.server_corner.name(),
    // rust: u.combo,
    // rust: u.combo_corner.name(),
    // rust: );
    // rust: let _ = write!(
    // rust: out,
    // rust: "hudFps:{}\nhudFpsCorner:{}\nhudCps:{}\nhudCpsCorner:{}\nhudKeys:{}\nhudKeysCorner:{}\n",
    // rust: u.fps,
    // rust: u.fps_corner.name(),
    // rust: u.cps,
    // rust: u.cps_corner.name(),
    // rust: u.keys,
    // rust: u.keys_corner.name(),
    // rust: );
    // rust: let _ = write!(
    // rust: out,
    // rust: "hudClock:{}\nhudClockCorner:{}\nhudReach:{}\nhudReachCorner:{}\nhudSpeed:{}\nhudSpeedCorner:{}\n",
    // rust: u.clock,
    // rust: u.clock_corner.name(),
    // rust: u.reach,
    // rust: u.reach_corner.name(),
    // rust: u.speed,
    // rust: u.speed_corner.name(),
    // rust: );
    // rust: let _ = write!(
    // rust: out,
    // rust: "hudOpacity:{}\nhudTextColour:{}\nhudShadow:{}\n",
    // rust: u.opacity,
    // rust: u.text.name(),
    // rust: u.shadow,
    // rust: );
    // rust: self.layout.serialize(out);
    // rust: let _ = writeln!(out, "hudEditorKey:{}", self.editor_key);
    // rust: let t = &self.tweaks;
    // rust: let _ = write!(
    // rust: out,
    // rust: "numericEnchants:{}\nlowFire:{}\nshieldSize:{}\ntotemSize:{}\nglintColour:{}\nclearWater:{}\nclearLava:{}\n",
    // rust: t.numeric_enchants,
    // rust: t.fire_lower,
    // rust: t.shield_size,
    // rust: t.totem_size,
    // rust: t.glint.map_or("off", Colour::name),
    // rust: t.clear_water,
    // rust: t.clear_lava,
    // rust: );
    // rust: let _ = write!(
    // rust: out,
    // rust: "viewTime:{}\nviewWeather:{}\n",
    // rust: t.time.map_or("off", ViewTime::name),
    // rust: t.weather.map_or("off", ViewWeather::name),
    // rust: );
    // rust: let c = &self.chat;
    // rust: let _ = write!(
    // rust: out,
    // rust: "chatTimestamps:{}\nchatCompact:{}\nchatCopy:{}\nchatSearch:{}\n",
    // rust: c.timestamps, c.compact, c.copy, c.search,
    // rust: );
    // rust: let c = &self.combat;
    // rust: let feel = if c.legacy { "legacy" } else { "modern" };
    // rust: let _ = write!(
    // rust: out,
    // rust: "combatFeel:{feel}\ncombatIndicator:{}\ncombatSounds:{}\ncombatRules:{}\n",
    // rust: c.indicator, c.sounds, c.rules
    // rust: );
}
}

// The official mods the PvP preset turns on when they are installed: the FPS counter and the
// keystrokes with clicks per second.
PRESET_MODS :: ["fps_overlay", "keystrokes"]
// Fire overlay's place under the PvP preset (percent of its height down).
PRESET_FIRE_LOWER :: 40
// The PvP preset: the custom crosshair, the armour and effects widgets, vanilla's toggle sprint
// and toggle sneak, lower fire, and the FPS and keystrokes mods when installed. It only turns
// things on; each keeps its own settings, so it can be undone option by option.
apply_preset :: proc(s: ^crate::settings::Settings) {
}
    // rust: let p = &mut s.extras.pvp;
    // rust: p.crosshair.custom = true;
    // rust: p.hud.armour = true;
    // rust: p.hud.effects = true;
    // rust: if p.tweaks.fire_lower == 0 {
    // rust: p.tweaks.fire_lower = PRESET_FIRE_LOWER;
}
    // rust: s.toggle_sprint = true;
    // rust: s.toggle_crouch = true;
    // rust: for id in PRESET_MODS {
    // rust: s.mods.turn_on(id);
}
}

// The options of the PvP & HUD page: each one's id (its language keys are `horizon.pvp.<id>`
// and `horizon.pvp.<id>.tooltip`), English caption and description (en_us.json has the same
// text; a test keeps them equal).
    // rust: macro_rules! opts {
    // rust: ($($name:ident, $id:literal, $caption:literal, $description:literal;)*) => {
Opt :: enum {
    impl Opt {,
ALL :: &[$(Opt::$name),*]
    pub fn caption_key(self) -> &'static str {,
    match self { $(Opt::$name => concat!("horizon.pvp", ".", $id)),* },
}
description_key :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self { $(Opt::$name => concat!("horizon.pvp", ".", $id, ".tooltip")),* }
}
caption :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self { $(Opt::$name => $caption),* }
}
description :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self { $(Opt::$name => $description),* }
}
}
}
}
    // rust: opts! {
    // rust: Crosshair, "crosshair", "Custom crosshair",
    // rust: "Draws your own crosshair instead of vanilla's. Its first settings look like vanilla's.";
    // rust: CrosshairShape, "crosshair_shape", "Shape", "A cross, a T, an X, a circle, a square or only a dot.";
    // rust: CrosshairSize, "crosshair_size", "Size", "The length of each arm, in GUI pixels.";
    // rust: CrosshairGap, "crosshair_gap", "Gap", "The empty space in the middle.";
    // rust: CrosshairThickness, "crosshair_thickness", "Thickness", "How wide each line is.";
    // rust: CrosshairColour, "crosshair_colour", "Colour",
    // rust: "Inverted shows the colour under it inverted, as vanilla's crosshair does.";
    // rust: CrosshairOutline, "crosshair_outline", "Outline", "A thin black edge, so it shows on any background.";
    // rust: CrosshairDot, "crosshair_dot", "Centre dot", "A dot in the middle of the crosshair.";
    // rust: CrosshairHover, "crosshair_hover", "Colour on entities",
    // rust: "Another colour while the crosshair is over a mob or a player you could hit, as vanilla's attack indicator knows it.";
    // rust: Outline, "outline", "Custom block outline", "Changes the outline around the block you look at.";
    // rust: OutlineColour, "outline_colour", "Colour", "The outline's colour. Black at 40% is vanilla's.";
    // rust: OutlineOpacity, "outline_opacity", "Opacity", "How solid the outline is.";
    // rust: OutlineThickness, "outline_thickness", "Thickness", "The outline's width, in times vanilla's.";
    // rust: OutlineFill, "outline_fill", "Fill", "Tints the faces of the block you look at, lightly.";
    // rust: Hit, "hit", "Custom hit colour",
    // rust: "Changes the colour mobs and players flash when they are hurt. Red at 30% is vanilla's.";
    // rust: HitColour, "hit_colour", "Colour", "The colour hurt mobs and players flash.";
    // rust: HitOpacity, "hit_opacity", "Opacity", "How much of the colour covers them.";
    // rust: HudArmour, "hud_armour", "Armour",
    // rust: "The armour you wear, head first, with how many uses each piece has left.";
    // rust: HudArmourCorner, "hud_armour_corner", "Armour corner", "Where the armour shows.";
    // rust: HudArmourPercent, "hud_armour_percent", "Durability in %",
    // rust: "Uses left as a percent of the piece's maximum instead of a number.";
    // rust: HudEffects, "hud_effects", "Effects",
    // rust: "Your effects with their names, levels and time left, in place of the icons at the top right.";
    // rust: HudEffectsCorner, "hud_effects_corner", "Effects corner", "Where the effects show.";
    // rust: HudHeld, "hud_held", "Held item count",
    // rust: "How many of the item in your hand your inventory holds; arrows with a bow or crossbow.";
    // rust: HudHeldCorner, "hud_held_corner", "Held count corner", "Where the count shows.";
    // rust: HudPing, "hud_ping", "Ping", "The latency the server reports for you, in milliseconds. Multiplayer only.";
    // rust: HudPingCorner, "hud_ping_corner", "Ping corner", "Where the ping shows.";
    // rust: HudCoords, "hud_coords", "Coordinates",
    // rust: "Your block position and the direction you face, as F3 shows them. Hidden when the world or server reduces F3.";
    // rust: HudCoordsCorner, "hud_coords_corner", "Coordinates corner", "Where the coordinates show.";
    // rust: HudServer, "hud_server", "Server address", "The address of the server you play on. Multiplayer only.";
    // rust: HudServerCorner, "hud_server_corner", "Server corner", "Where the address shows.";
    // rust: HudCombo, "hud_combo", "Combo counter",
    // rust: "Hits in a row the server confirmed, until you are hurt or 3 seconds pass without one.";
    // rust: HudComboCorner, "hud_combo_corner", "Combo corner", "Where the combo shows.";
    // rust: HudFps, "hud_fps", "FPS", "Frames drawn in the last second.";
    // rust: HudFpsCorner, "hud_fps_corner", "FPS corner", "Where the FPS shows.";
    // rust: HudCps, "hud_cps", "Clicks per second", "Your left and right clicks in the last second.";
    // rust: HudCpsCorner, "hud_cps_corner", "CPS corner", "Where the clicks per second show.";
    // rust: HudKeys, "hud_keys", "Keystrokes",
    // rust: "Your movement keys, mouse buttons and jump, lit while you hold them, with clicks per second.";
    // rust: HudKeysCorner, "hud_keys_corner", "Keystrokes corner", "Where the keystrokes show.";
    // rust: HudClock, "hud_clock", "Clock", "Your computer's time.";
    // rust: HudClockCorner, "hud_clock_corner", "Clock corner", "Where the clock shows.";
    // rust: HudReach, "hud_reach", "Reach",
    // rust: "How far from your eyes your last hit landed, for 3 seconds. It only measures: your reach stays vanilla's.";
    // rust: HudReachCorner, "hud_reach_corner", "Reach corner", "Where the reach shows.";
    // rust: HudSpeed, "hud_speed", "Speed", "How fast you move across the ground, in blocks per second.";
    // rust: HudSpeedCorner, "hud_speed_corner", "Speed corner", "Where the speed shows.";
    // rust: HudBackground, "hud_background", "Widget backgrounds", "A dark box behind each widget.";
    // rust: HudOpacity, "hud_opacity", "Background opacity", "How dark the boxes behind the widgets are.";
    // rust: HudTextColour, "hud_text_colour", "Text colour",
    // rust: "The widgets' text colour. Durability keeps its green to red.";
    // rust: HudShadow, "hud_shadow", "Text shadow", "A shadow under the widgets' text, as vanilla's HUD text has.";
    // rust: HudEditorKey, "hud_editor_key", "HUD editor key",
    // rust: "Opens the HUD editor from the game. Click, then press a key; Escape unbinds it.";
    // rust: NumericEnchants, "numeric_enchants", "Enchantment levels as numbers",
    // rust: "Tooltips and the enchanting table show Sharpness 5 instead of Sharpness V.";
    // rust: FireLower, "fire_lower", "Lower fire",
    // rust: "Moves the flames you see while burning down, so they cover less of the screen.";
    // rust: ShieldSize, "shield_size", "Shield size", "The size of the shield in your hand, in first person.";
    // rust: TotemSize, "totem_size", "Totem animation size",
    // rust: "The size of the totem that fills the screen when it saves you.";
    // rust: GlintColour, "glint_colour", "Enchantment glint colour",
    // rust: "The colour of the shimmer on enchanted items and armour. Off is vanilla's purple.";
    // rust: ClearWater, "clear_water", "Clear water",
    // rust: "Under water, see as far as vanilla lets you after 30 seconds there, from the start.";
    // rust: ClearLava, "clear_lava", "Clear lava",
    // rust: "In lava, see as far as vanilla's Fire Resistance lets you, without the effect.";
    // rust: ViewTime, "view_time", "Time of day",
    // rust: "The time of day you see: the sky and its light only. The world's time goes on and nothing is sent to the server.";
    // rust: ViewWeather, "view_weather", "Weather",
    // rust: "The weather you see: rain, its light and fog only. The world's weather goes on and nothing is sent to the server.";
    // rust: ChatTimestamps, "chat_timestamps", "Timestamps", "The time each message came in, before it.";
    // rust: ChatCompact, "chat_compact", "Compact chat",
    // rust: "A message repeated in a row shows once, with how many times it came: (x3).";
    // rust: ChatCopy, "chat_copy", "Copy on click",
    // rust: "Clicking a message in the open chat copies its text, unless the click does something else.";
    // rust: ChatSearch, "chat_search", "Chat search",
    // rust: "Ctrl+F in the open chat: what you type shows only the messages holding it. Enter or Ctrl+F again stops.";
    // rust: CombatFeel, "combat_feel", "Combat feel",
    // rust: "Legacy draws fights as 1.8.9 did: the item in your hand, its swing, eating, the bow and a sword held up while you hold use, without the dip after each hit or the attack indicator. Only the look: what you send a server stays the same.";
    // rust: CombatIndicator, "combat_indicator", "Attack indicator in Legacy",
    // rust: "Keeps the attack indicator under Legacy, which 1.8.9 didn't have.";
    // rust: CombatSounds, "combat_sounds", "1.8 hit sounds",
    // rust: "Under Legacy, leaves out the attack sounds 1.9 added (strong, weak, sweep, critical...). Hurt sounds stay.";
    // rust: CombatRules, "combat_rules", "1.8 combat in worlds you host",
    // rust: "Single player and the worlds you open to LAN fight by 1.8.9's rules: no attack cooldown or sweep, 1.8 weapon damage, Strength, Sharpness and critical hits. Servers you join keep their own rules.";
}
// The PvP & HUD page: headers (language keys) and options.
rows :: proc() -> V {
    // Ported from Horizon
    return {}
}
//     use Opt::*;
    // rust: let mut rows = vec![Err("horizon.pvp.header.crosshair")];
    // rust: rows.extend(
    // rust: [
    // rust: Crosshair,
    // rust: CrosshairShape,
    // rust: CrosshairSize,
    // rust: CrosshairGap,
    // rust: CrosshairThickness,
    // rust: CrosshairColour,
    // rust: CrosshairOutline,
    // rust: CrosshairDot,
    // rust: CrosshairHover,
    // rust: ]
    // rust: .map(Ok),
    // rust: );
    // rust: rows.push(Err("horizon.pvp.header.outline"));
    // rust: rows.extend(
    // rust: [
    // rust: Outline,
    // rust: OutlineColour,
    // rust: OutlineOpacity,
    // rust: OutlineThickness,
    // rust: OutlineFill,
    // rust: ]
    // rust: .map(Ok),
    // rust: );
    // rust: rows.push(Err("horizon.pvp.header.hit"));
    // rust: rows.extend([Hit, HitColour, HitOpacity].map(Ok));
    // rust: rows.push(Err("horizon.pvp.header.hud"));
    // rust: rows.extend(
    // rust: [
    // rust: HudArmour,
    // rust: HudArmourCorner,
    // rust: HudArmourPercent,
    // rust: HudEffects,
    // rust: HudEffectsCorner,
    // rust: HudHeld,
    // rust: HudHeldCorner,
    // rust: HudPing,
    // rust: HudPingCorner,
    // rust: HudCoords,
    // rust: HudCoordsCorner,
    // rust: HudServer,
    // rust: HudServerCorner,
    // rust: HudCombo,
    // rust: HudComboCorner,
    // rust: HudFps,
    // rust: HudFpsCorner,
    // rust: HudCps,
    // rust: HudCpsCorner,
    // rust: HudKeys,
    // rust: HudKeysCorner,
    // rust: HudClock,
    // rust: HudClockCorner,
    // rust: HudReach,
    // rust: HudReachCorner,
    // rust: HudSpeed,
    // rust: HudSpeedCorner,
    // rust: HudBackground,
    // rust: HudOpacity,
    // rust: HudTextColour,
    // rust: HudShadow,
    // rust: HudEditorKey,
    // rust: ]
    // rust: .map(Ok),
    // rust: );
    // rust: rows.push(Err("horizon.pvp.header.items"));
    // rust: rows.push(Ok(NumericEnchants));
    // rust: rows.push(Ok(GlintColour));
    // rust: rows.push(Err("horizon.pvp.header.visual"));
    // rust: rows.extend([FireLower, ShieldSize, TotemSize, ClearWater, ClearLava].map(Ok));
    // rust: rows.push(Err("horizon.pvp.header.view"));
    // rust: rows.extend([ViewTime, ViewWeather].map(Ok));
    // rust: rows.push(Err("horizon.pvp.header.chat"));
    // rust: rows.extend([ChatTimestamps, ChatCompact, ChatCopy, ChatSearch].map(Ok));
    // rust: rows.push(Err("horizon.pvp.header.combat"));
    // rust: rows.extend([CombatFeel, CombatIndicator, CombatSounds, CombatRules].map(Ok));
    // rust: rows
}
    // rust: impl Opt {
    // The switch this option belongs to.
parent :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use Opt::*;
    // rust: match self {
    // rust: Crosshair | Outline | Hit => None,
    // rust: OutlineColour | OutlineOpacity | OutlineThickness | OutlineFill => Some(Outline),
    // rust: HitColour | HitOpacity => Some(Hit),
    // rust: HudArmour | HudEffects | HudHeld | HudPing | HudCoords | HudServer | HudCombo
    // rust: | HudFps | HudCps | HudKeys | HudClock | HudReach | HudSpeed | HudBackground
    // rust: | HudTextColour | HudShadow | HudEditorKey | NumericEnchants => None,
    // rust: HudOpacity => Some(HudBackground),
    // rust: HudFpsCorner => Some(HudFps),
    // rust: HudCpsCorner => Some(HudCps),
    // rust: HudKeysCorner => Some(HudKeys),
    // rust: HudClockCorner => Some(HudClock),
    // rust: HudReachCorner => Some(HudReach),
    // rust: HudSpeedCorner => Some(HudSpeed),
    // rust: FireLower | ShieldSize | TotemSize | GlintColour | ClearWater | ClearLava => None,
    // rust: ViewTime | ViewWeather => None,
    // rust: ChatTimestamps | ChatCompact | ChatCopy | ChatSearch => None,
    // rust: CombatFeel | CombatIndicator | CombatSounds | CombatRules => None,
    // rust: HudPingCorner => Some(HudPing),
    // rust: HudCoordsCorner => Some(HudCoords),
    // rust: HudServerCorner => Some(HudServer),
    // rust: HudComboCorner => Some(HudCombo),
    // rust: HudArmourCorner | HudArmourPercent => Some(HudArmour),
    // rust: HudEffectsCorner => Some(HudEffects),
    // rust: HudHeldCorner => Some(HudHeld),
    // rust: _ => Some(Crosshair),
}
}
switch :: proc(self: ^Self, p: ^Pvp) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let c = &p.crosshair;
    // rust: Some(match self {
    // rust: Opt::Crosshair => c.custom,
    // rust: Opt::CrosshairOutline => c.outline,
    // rust: Opt::CrosshairDot => c.dot,
    // rust: Opt::Outline => p.outline.custom,
    // rust: Opt::Hit => p.hit.custom,
    // rust: Opt::HudArmour => p.hud.armour,
    // rust: Opt::HudArmourPercent => p.hud.armour_percent,
    // rust: Opt::HudEffects => p.hud.effects,
    // rust: Opt::HudHeld => p.hud.held,
    // rust: Opt::HudBackground => p.hud.background,
    // rust: Opt::HudShadow => p.hud.shadow,
    // rust: Opt::HudPing => p.hud.ping,
    // rust: Opt::HudCoords => p.hud.coords,
    // rust: Opt::HudServer => p.hud.server,
    // rust: Opt::HudCombo => p.hud.combo,
    // rust: Opt::HudFps => p.hud.fps,
    // rust: Opt::HudCps => p.hud.cps,
    // rust: Opt::HudKeys => p.hud.keys,
    // rust: Opt::HudClock => p.hud.clock,
    // rust: Opt::HudReach => p.hud.reach,
    // rust: Opt::HudSpeed => p.hud.speed,
    // rust: Opt::NumericEnchants => p.tweaks.numeric_enchants,
    // rust: Opt::ClearWater => p.tweaks.clear_water,
    // rust: Opt::ClearLava => p.tweaks.clear_lava,
    // rust: Opt::ChatTimestamps => p.chat.timestamps,
    // rust: Opt::ChatCompact => p.chat.compact,
    // rust: Opt::ChatCopy => p.chat.copy,
    // rust: Opt::ChatSearch => p.chat.search,
    // rust: Opt::CombatIndicator => p.combat.indicator,
    // rust: Opt::CombatSounds => p.combat.sounds,
    // rust: Opt::CombatRules => p.combat.rules,
    // rust: _ => return None,
    // rust: })
}
    // The value its button shows, for the options that aren't switches.
value :: proc(self: ^Self, p: ^Pvp) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let c = &p.crosshair;
    // rust: Some(match self {
    // rust: Opt::CrosshairShape => c.shape.label(),
    // rust: Opt::CrosshairSize => c.size.to_string(),
    // rust: Opt::CrosshairGap => c.gap.to_string(),
    // rust: Opt::CrosshairThickness => c.thickness.to_string(),
    // rust: Opt::CrosshairColour => c.colour.label(),
    // rust: Opt::CrosshairHover => match c.hover {
    // rust: Some(colour) => colour.label(),
    // rust: None => crate::lang::get_or("Off", "Off"),
    // rust: },
    // rust: Opt::OutlineColour => p.outline.colour.label(),
    // rust: Opt::OutlineOpacity => format!("{}%", p.outline.opacity),
    // rust: Opt::OutlineThickness => format!("{}x", p.outline.thickness),
    // rust: Opt::OutlineFill => match p.outline.fill {
    // rust: Some(colour) => colour.label(),
    // rust: None => crate::lang::get_or("Off", "Off"),
    // rust: },
    // rust: Opt::HitColour => p.hit.colour.label(),
    // rust: Opt::HitOpacity => format!("{}%", p.hit.opacity),
    // rust: Opt::HudArmourCorner => corner_label(p.hud.armour_corner),
    // rust: Opt::HudEffectsCorner => corner_label(p.hud.effects_corner),
    // rust: Opt::HudHeldCorner => corner_label(p.hud.held_corner),
    // rust: Opt::HudPingCorner => corner_label(p.hud.ping_corner),
    // rust: Opt::HudCoordsCorner => corner_label(p.hud.coords_corner),
    // rust: Opt::HudServerCorner => corner_label(p.hud.server_corner),
    // rust: Opt::HudComboCorner => corner_label(p.hud.combo_corner),
    // rust: Opt::HudFpsCorner => corner_label(p.hud.fps_corner),
    // rust: Opt::HudCpsCorner => corner_label(p.hud.cps_corner),
    // rust: Opt::HudKeysCorner => corner_label(p.hud.keys_corner),
    // rust: Opt::HudClockCorner => corner_label(p.hud.clock_corner),
    // rust: Opt::HudReachCorner => corner_label(p.hud.reach_corner),
    // rust: Opt::HudSpeedCorner => corner_label(p.hud.speed_corner),
    // rust: Opt::HudOpacity => format!("{}%", p.hud.opacity),
    // rust: Opt::HudTextColour => p.hud.text.label(),
    // rust: Opt::HudEditorKey => crate::keybinds::display_name(&p.editor_key).plain(),
    // rust: Opt::FireLower => match p.tweaks.fire_lower {
    // rust: 0 => crate::lang::get_or("Off", "Off"),
    // rust: v => format!("{v}%"),
    // rust: },
    // rust: Opt::ShieldSize => format!("{}%", p.tweaks.shield_size),
    // rust: Opt::TotemSize => format!("{}%", p.tweaks.totem_size),
    // rust: Opt::GlintColour => match p.tweaks.glint {
    // rust: Some(colour) => colour.label(),
    // rust: None => crate::lang::get_or("Off", "Off"),
    // rust: },
    // rust: Opt::CombatFeel => match p.combat.legacy {
    // rust: true => crate::lang::get_or("horizon.pvp.combat_feel.legacy", "Legacy (1.8.9)"),
    // rust: false => crate::lang::get_or("horizon.pvp.combat_feel.modern", "Modern"),
    // rust: },
    // rust: Opt::ViewTime => p.tweaks.time.map_or_else(world_label, ViewTime::label),
    // rust: Opt::ViewWeather => p
    // rust: .tweaks
    // rust: .weather
    // rust: .map_or_else(world_label, ViewWeather::label),
    // rust: _ => return None,
    // rust: })
}
    // A click; `back` (right button, wheel up) goes the other way.
cycle :: proc(self: ^Self, p: ^Pvp, back: bool) {
}
    // rust: let c = &mut p.crosshair;
    // rust: let (o, h, u) = (&mut p.outline, &mut p.hit, &mut p.hud);
    // rust: let t = &mut p.tweaks;
    // rust: let corner = |c: Corner| step(&Corner::ALL, c, back);
        // Off, then every solid colour.
    // rust: let solid_or_off = |v: Option<Colour>| {
    // rust: let all = [None]
    // rust: .into_iter()
    // rust: .chain(Colour::ALL[1..].iter().copied().map(Some));
    // rust: step(&all.collect::<Vec<_>>(), v, back)
}
    // rust: match self {
    // rust: Opt::Crosshair => c.custom = !c.custom,
    // rust: Opt::CrosshairShape => c.shape = step(&Shape::ALL, c.shape, back),
    // rust: Opt::CrosshairSize => c.size = step_num(c.size, SIZES.0, SIZES.1, back),
    // rust: Opt::CrosshairGap => c.gap = step_num(c.gap, GAPS.0, GAPS.1, back),
    // rust: Opt::CrosshairThickness => {
    // rust: c.thickness = step_num(c.thickness, THICKNESSES.0, THICKNESSES.1, back)
}
    // rust: Opt::CrosshairColour => c.colour = c.colour.step(back),
    // rust: Opt::CrosshairOutline => c.outline = !c.outline,
    // rust: Opt::CrosshairDot => c.dot = !c.dot,
    // rust: Opt::CrosshairHover => {
                // Off, then every colour.
    // rust: let all: Vec<Option<Colour>> = std::iter::once(None)
    // rust: .chain(Colour::ALL.into_iter().map(Some))
    // rust: .collect();
    // rust: c.hover = step(&all, c.hover, back);
}
    // rust: Opt::Outline => o.custom = !o.custom,
    // rust: Opt::OutlineColour => o.colour = o.colour.step_solid(back),
    // rust: Opt::OutlineOpacity => o.opacity = step_by(o.opacity, OPACITIES, 10, back),
    // rust: Opt::OutlineThickness => {
    // rust: o.thickness = step_by(o.thickness, OUTLINE_THICKNESSES, 1, back)
}
    // rust: Opt::OutlineFill => o.fill = solid_or_off(o.fill),
    // rust: Opt::Hit => h.custom = !h.custom,
    // rust: Opt::HitColour => h.colour = h.colour.step_solid(back),
    // rust: Opt::HitOpacity => h.opacity = step_by(h.opacity, HIT_OPACITIES, 10, back),
    // rust: Opt::HudArmour => u.armour = !u.armour,
    // rust: Opt::HudArmourCorner => u.armour_corner = corner(u.armour_corner),
    // rust: Opt::HudArmourPercent => u.armour_percent = !u.armour_percent,
    // rust: Opt::HudEffects => u.effects = !u.effects,
    // rust: Opt::HudEffectsCorner => u.effects_corner = corner(u.effects_corner),
    // rust: Opt::HudHeld => u.held = !u.held,
    // rust: Opt::HudHeldCorner => u.held_corner = corner(u.held_corner),
    // rust: Opt::HudBackground => u.background = !u.background,
    // rust: Opt::HudOpacity => u.opacity = step_by(u.opacity, HUD_OPACITIES, 10, back),
    // rust: Opt::HudTextColour => u.text = u.text.step_solid(back),
    // rust: Opt::HudShadow => u.shadow = !u.shadow,
            // Bound through the controls' key capture (`Item::key_name`).
    // rust: Opt::HudEditorKey => {}
    // rust: Opt::HudPing => u.ping = !u.ping,
    // rust: Opt::HudPingCorner => u.ping_corner = corner(u.ping_corner),
    // rust: Opt::HudCoords => u.coords = !u.coords,
    // rust: Opt::HudCoordsCorner => u.coords_corner = corner(u.coords_corner),
    // rust: Opt::HudServer => u.server = !u.server,
    // rust: Opt::HudServerCorner => u.server_corner = corner(u.server_corner),
    // rust: Opt::HudCombo => u.combo = !u.combo,
    // rust: Opt::HudComboCorner => u.combo_corner = corner(u.combo_corner),
    // rust: Opt::HudFps => u.fps = !u.fps,
    // rust: Opt::HudFpsCorner => u.fps_corner = corner(u.fps_corner),
    // rust: Opt::HudCps => u.cps = !u.cps,
    // rust: Opt::HudCpsCorner => u.cps_corner = corner(u.cps_corner),
    // rust: Opt::HudKeys => u.keys = !u.keys,
    // rust: Opt::HudKeysCorner => u.keys_corner = corner(u.keys_corner),
    // rust: Opt::HudClock => u.clock = !u.clock,
    // rust: Opt::HudClockCorner => u.clock_corner = corner(u.clock_corner),
    // rust: Opt::HudReach => u.reach = !u.reach,
    // rust: Opt::HudReachCorner => u.reach_corner = corner(u.reach_corner),
    // rust: Opt::HudSpeed => u.speed = !u.speed,
    // rust: Opt::HudSpeedCorner => u.speed_corner = corner(u.speed_corner),
    // rust: Opt::NumericEnchants => p.tweaks.numeric_enchants = !p.tweaks.numeric_enchants,
    // rust: Opt::FireLower => t.fire_lower = step_by(t.fire_lower, FIRE_LOWER, 10, back),
    // rust: Opt::ShieldSize => t.shield_size = step_by(t.shield_size, SHIELD_SIZES, 10, back),
    // rust: Opt::TotemSize => t.totem_size = step_by(t.totem_size, TOTEM_SIZES, 25, back),
    // rust: Opt::GlintColour => t.glint = solid_or_off(t.glint),
    // rust: Opt::ClearWater => t.clear_water = !t.clear_water,
    // rust: Opt::ClearLava => t.clear_lava = !t.clear_lava,
    // rust: Opt::ViewTime => {
    // rust: let all: Vec<_> = std::iter::once(None)
    // rust: .chain(ViewTime::ALL.map(Some))
    // rust: .collect();
    // rust: t.time = step(&all, t.time, back);
}
    // rust: Opt::ChatTimestamps => p.chat.timestamps = !p.chat.timestamps,
    // rust: Opt::ChatCompact => p.chat.compact = !p.chat.compact,
    // rust: Opt::ChatCopy => p.chat.copy = !p.chat.copy,
    // rust: Opt::ChatSearch => p.chat.search = !p.chat.search,
    // rust: Opt::CombatFeel => p.combat.legacy = !p.combat.legacy,
    // rust: Opt::CombatIndicator => p.combat.indicator = !p.combat.indicator,
    // rust: Opt::CombatSounds => p.combat.sounds = !p.combat.sounds,
    // rust: Opt::CombatRules => p.combat.rules = !p.combat.rules,
    // rust: Opt::ViewWeather => {
    // rust: let all: Vec<_> = std::iter::once(None)
    // rust: .chain(ViewWeather::ALL.map(Some))
    // rust: .collect();
    // rust: t.weather = step(&all, t.weather, back);
}
}
}
}

    // rust: mod tests {
//     use super::*;

    // The mask drawn as rows of `#` and `.` over `-r..=r`.
picture :: proc(m: ^Mask, r: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (-r..=r)
    // rust: .map(|y| {
    // rust: (-r..=r)
    // rust: .map(|x| if m.get(x, y) { '#' } else { '.' })
    // rust: .collect()
    // rust: })
    // rust: .collect()
}

the_default_crosshair_covers_vanillas_sprite :: proc() {
}
        // hud/crosshair.png: a 15x15 plus sign, one pixel wide, through the middle.
    // rust: let m = Crosshair::default().mask();
    // rust: for y in -7..=7 {
    // rust: for x in -7..=7 {
    // rust: assert_eq!(m.get(x, y), x == 0 || y == 0, "({x}, {y})");
}
}
    // rust: assert!(!m.get(8, 0) && !m.get(0, -8));
    // rust: assert_eq!(
    // rust: m.runs().count(),
    // rust: 15,
    // rust: "one run per row: 14 single pixels and the bar"
    // rust: );
}

gap_thickness_shape_and_dot_change_the_pixels :: proc() {
}
    // rust: let c = Crosshair {
    // rust: size: 2,
    // rust: gap: 1,
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: picture(&c.mask(), 3),
    // rust: [
    // rust: "...#...", "...#...", ".......", "##...##", ".......", "...#...", "...#...",
    // rust: ]
    // rust: );
    // rust: let dotted = Crosshair { dot: true, ..c };
    // rust: assert!(dotted.mask().get(0, 0));
    // rust: let t = Crosshair {
    // rust: shape: Shape::T,
    // rust: thickness: 3,
    // rust: size: 1,
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: picture(&t.mask(), 2),
    // rust: [".....", "#####", "#####", "#####", ".###."]
    // rust: );
    // rust: let x = Crosshair {
    // rust: shape: Shape::X,
    // rust: size: 2,
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: picture(&x.mask(), 2),
    // rust: ["#...#", ".#.#.", "..#..", ".#.#.", "#...#"]
    // rust: );
    // rust: let square = Crosshair {
    // rust: shape: Shape::Square,
    // rust: size: 2,
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: picture(&square.mask(), 2),
    // rust: ["#####", "#...#", "#...#", "#...#", "#####"]
    // rust: );
    // rust: let ring = Crosshair {
    // rust: shape: Shape::Circle,
    // rust: size: 3,
    // rust: ..Default::default()
}
    // rust: let p = picture(&ring.mask(), 3);
    // rust: assert_eq!(p[3], "#.....#", "{p:?}");
    // rust: assert_eq!(p[0], "..###..", "{p:?}");
    // rust: assert!(!ring.mask().get(0, 0));
    // rust: let dot = Crosshair {
    // rust: shape: Shape::Dot,
    // rust: thickness: 2,
    // rust: ..Default::default()
}
    // rust: assert_eq!(picture(&dot.mask(), 1), ["...", ".##", ".##"]);
}

the_outline_rings_the_shape_without_covering_it :: proc() {
}
    // rust: let dot = Crosshair {
    // rust: shape: Shape::Dot,
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: picture(&dot.mask().rim(), 2),
    // rust: [".....", ".###.", ".#.#.", ".###.", "....."]
    // rust: );
    // rust: let mut cache = CrosshairCache::default();
    // rust: let (shape, rim) = cache.runs(&Crosshair {
    // rust: outline: true,
    // rust: ..Crosshair::default()
    // rust: });
    // rust: assert_eq!(shape.len(), 15);
        // Rows -8 and 8 (one run each), and the rows beside the bar: three runs each
        // (left of it, between, right of it) except where the arms meet it.
    // rust: assert!(rim.iter().all(|&(x0, _, x1)| x1 > x0));
    // rust: assert!(rim.iter().any(|&(_, y, _)| y == -8) && rim.iter().any(|&(_, y, _)| y == 8));
}

options_round_trip_and_cycle_both_ways :: proc() {
}
    // rust: let d = Pvp::default();
    // rust: let mut text = String::new();
    // rust: d.serialize(&mut text);
    // rust: let mut back = Pvp::default();
    // rust: for line in text.lines() {
    // rust: let (k, v) = line.split_once(':').unwrap();
    // rust: assert!(back.parse_line(k, v), "{k}");
}
    // rust: assert_eq!(back, d);
    // rust: let mut p = Pvp::default();
    // rust: for opt in rows().into_iter().flatten() {
    // rust: opt.cycle(&mut p, false);
}
    // rust: assert!(p.crosshair.custom && p.crosshair.outline && p.crosshair.dot);
    // rust: assert_eq!(p.crosshair.shape, Shape::T);
    // rust: assert_eq!(p.crosshair.size, 8);
    // rust: assert_eq!(p.crosshair.hover, Some(Colour::Inverted));
        // From vanilla's values, one click: the overlays' sizes wrap to their smallest.
    // rust: let t = p.tweaks;
    // rust: assert_eq!((t.fire_lower, t.shield_size, t.totem_size), (10, 50, 25));
    // rust: assert_eq!(t.glint, Some(Colour::White));
    // rust: assert!(t.clear_water && t.clear_lava);
    // rust: assert_eq!(
    // rust: (t.time, t.weather),
    // rust: (Some(ViewTime::Morning), Some(ViewWeather::Clear))
    // rust: );
    // rust: let c = p.chat;
    // rust: assert!(c.timestamps && c.compact && c.copy && c.search);
    // rust: let mut text = String::new();
    // rust: p.serialize(&mut text);
    // rust: let mut read = Pvp::default();
    // rust: text.lines().for_each(|l| {
    // rust: let (k, v) = l.split_once(':').unwrap();
    // rust: read.parse_line(k, v);
    // rust: });
    // rust: assert_eq!(read, p);
        // Down from the lowest wraps to the highest; bad values keep what was there.
    // rust: Opt::CrosshairThickness.cycle(&mut p, true);
    // rust: Opt::CrosshairThickness.cycle(&mut p, true);
    // rust: assert_eq!(p.crosshair.thickness, THICKNESSES.1);
    // rust: Opt::CrosshairHover.cycle(&mut p, true);
    // rust: assert_eq!(p.crosshair.hover, None);
    // rust: assert!(p.parse_line("crosshairSize", "99") && p.crosshair.size == SIZES.1);
    // rust: assert!(p.parse_line("crosshairColour", "plaid") && p.crosshair.colour == Colour::White);
    // rust: assert!(!p.parse_line("fullbright", "true"));
    // rust: assert!(p.parse_line("totemSize", "5") && p.tweaks.totem_size == TOTEM_SIZES.0);
}

the_pvp_preset_turns_its_options_on_and_keeps_their_settings :: proc() {
}
//         use crate::mod_list::{Installed, NativePage};
    // rust: let mut s = crate::settings::Settings::default();
    // rust: s.extras.pvp.crosshair.colour = Colour::Green;
    // rust: s.extras.pvp.tweaks.fire_lower = 60;
    // rust: let installed = |id: &str| Installed {
    // rust: id: id.into(),
    // rust: title: id.into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev: false,
    // rust: native: Some(NativePage::default()),
}
    // rust: s.mods.installed = vec![installed("fps_overlay"), installed("zoom")];
    // rust: s.mods.disabled.insert("fps_overlay".into());
    // rust: apply_preset(&mut s);
    // rust: let p = &s.extras.pvp;
    // rust: assert!(p.crosshair.custom && p.hud.armour && p.hud.effects);
    // rust: assert!(s.toggle_sprint && s.toggle_crouch);
        // What the player had chosen stays: the crosshair's colour, a lower fire already set.
    // rust: assert_eq!(p.crosshair.colour, Colour::Green);
    // rust: assert_eq!(p.tweaks.fire_lower, 60);
        // The FPS counter the player had turned off is on; keystrokes isn't installed: nothing.
    // rust: assert!(!s.mods.disabled.contains("fps_overlay"));
    // rust: assert!(s.mods.enabled.contains("fps_overlay") && !s.mods.enabled.contains("keystrokes"));
    // rust: let mut fresh = crate::settings::Settings::default();
    // rust: apply_preset(&mut fresh);
    // rust: assert_eq!(fresh.extras.pvp.tweaks.fire_lower, PRESET_FIRE_LOWER);
}

a_fixed_time_keeps_the_worlds_day :: proc() {
}
        // Day 9 at 5000: the moon's phase (the day number) stays, the time of day is the chosen.
    // rust: let world = 9 * 24000 + 5000;
    // rust: assert_eq!(view_day_time(world, None), world);
    // rust: assert_eq!(
    // rust: view_day_time(world, Some(ViewTime::Midnight)),
    // rust: 9 * 24000 + 18000
    // rust: );
    // rust: assert_eq!(view_day_time(-100, Some(ViewTime::Noon)), -24000 + 6000);
}

the_glint_colour_reaches_the_shaders_as_rgb_bytes :: proc() {
}
    // rust: let mut t = Tweaks::default();
    // rust: assert_eq!(t.glint_texel(), 0, "vanilla's glint");
    // rust: t.glint = Some(Colour::Red);
        // unpack4x8unorm reads the low byte first: r = 1, g = 0, b = 0, a = 1.
    // rust: assert_eq!(t.glint_texel().to_le_bytes(), [255, 0, 0, 255]);
}

outline_and_hit_colours_default_to_vanillas :: proc() {
}
        // Turned on with their first settings, they give vanilla's colours: the outline's
        // 0x66000000 (LevelRenderer) and OverlayTexture's hurt texel 0xB2FF0000.
    // rust: let o = Outline {
    // rust: custom: true,
    // rust: ..Default::default()
}
    // rust: assert_eq!(o.stroke(), Some((0x6600_0000, 1.0)));
    // rust: assert_eq!(o.fill(), None);
    // rust: let [r, g, b, a] = crate::overlay::HURT_TEXEL;
    // rust: let hit = Hit {
    // rust: custom: true,
    // rust: ..Default::default()
}
    // rust: assert_eq!(hit.texel(), u32::from_le_bytes([r, g, b, a]));
    // rust: assert_eq!(
    // rust: (Outline::default().stroke(), Hit::default().texel()),
    // rust: (None, 0)
    // rust: );
        // Fully opaque cyan covers the entity entirely: none of its own colour stays.
    // rust: let cyan = Hit {
    // rust: custom: true,
    // rust: colour: Colour::Cyan,
    // rust: opacity: 100,
}
    // rust: assert_eq!(cyan.texel().to_le_bytes(), [0x40, 0xFF, 0xFF, 0]);
    // rust: let mut p = Pvp::default();
    // rust: Opt::Outline.cycle(&mut p, false);
    // rust: Opt::OutlineFill.cycle(&mut p, false);
    // rust: assert_eq!(p.outline.fill(), Some(0x40FF_FFFF), "white at 25%");
    // rust: Opt::OutlineOpacity.cycle(&mut p, true);
    // rust: Opt::OutlineOpacity.cycle(&mut p, true);
    // rust: Opt::OutlineOpacity.cycle(&mut p, true);
    // rust: Opt::OutlineOpacity.cycle(&mut p, true);
    // rust: assert_eq!(p.outline.opacity, 100, "down from 10% wraps to 100%");
    // rust: Opt::OutlineColour.cycle(&mut p, true);
    // rust: assert_eq!(p.outline.colour, Colour::Magenta, "never Inverted");
    // rust: let mut text = String::new();
    // rust: p.serialize(&mut text);
    // rust: let mut read = Pvp::default();
    // rust: for line in text.lines() {
    // rust: let (k, v) = line.split_once(':').unwrap();
    // rust: assert!(read.parse_line(k, v), "{k}");
}
    // rust: assert_eq!(read, p);
}

every_option_and_value_has_its_english_text :: proc() {
}
    // rust: let en = crate::lang::Language::load(&[], "en_us");
    // rust: for opt in Opt::ALL {
    // rust: assert_eq!(en.get(opt.caption_key()), Some(opt.caption()), "{opt:?}");
    // rust: assert_eq!(
    // rust: en.get(opt.description_key()),
    // rust: Some(opt.description()),
    // rust: "{opt:?}"
    // rust: );
}
    // rust: for header in rows().into_iter().filter_map(Result::err) {
    // rust: assert!(en.get(header).is_some(), "{header}");
}
    // rust: for c in Corner::ALL {
    // rust: let key = format!("horizon.pvp.corner.{}", c.name());
    // rust: assert_eq!(en.get(&key), Some(c.label()), "{key}");
}
    // rust: let names = Colour::ALL.map(|c| (format!("horizon.pvp.colour.{}", c.name()), c.english()));
    // rust: let shapes = Shape::ALL.map(|c| (format!("horizon.pvp.shape.{}", c.name()), c.english()));
    // rust: let times = ViewTime::ALL.map(|c| (format!("horizon.pvp.time.{}", c.name()), c.english()));
    // rust: let weathers =
    // rust: ViewWeather::ALL.map(|c| (format!("horizon.pvp.weather.{}", c.name()), c.english()));
    // rust: assert_eq!(en.get("horizon.pvp.view.world"), Some("World's"));
    // rust: for (key, english) in names.iter().chain(&shapes).chain(&times).chain(&weathers) {
    // rust: assert_eq!(en.get(key), Some(*english), "{key}");
}
}

legacy_leaves_out_what_1_9_added_to_a_hit :: proc() {
}
//         use crate::particles::ParticleType as T;
    // rust: let modern = Combat::default();
    // rust: let legacy = Combat {
    // rust: legacy: true,
    // rust: ..Combat::default()
}
    // rust: let sounds = Combat {
    // rust: sounds: true,
    // rust: ..legacy
}
    // rust: for name in [
    // rust: "minecraft:entity.player.attack.strong",
    // rust: "entity.player.attack.sweep",
    // rust: "minecraft:entity.player.attack.nodamage",
    // rust: ] {
    // rust: assert!(sounds.mutes_sound(name), "{name}");
    // rust: assert!(!legacy.mutes_sound(name), "only with the sounds option");
    // rust: assert!(!modern.mutes_sound(name));
}
        // 1.8.9 had the hurt sound: it stays.
    // rust: assert!(!sounds.mutes_sound("minecraft:entity.player.hurt"));
    // rust: assert!(legacy.hides_particle(T::SweepAttack) && legacy.hides_particle(T::DamageIndicator));
    // rust: assert!(!legacy.hides_particle(T::Crit) && !legacy.hides_particle(T::EnchantedHit));
    // rust: assert!(!modern.hides_particle(T::SweepAttack));
}
}
