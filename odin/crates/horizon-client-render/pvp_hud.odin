//! Transpiled from Horizon Rust crate
package horizon_client_render_pvp_hud

import "core:fmt"
import "core:mem"
import "core:math"

// The PvP & HUD page's HUD widgets (`docs/pvp.md`): boxes of lines in the screen corners,
// placed by `extras_hud::Corners` beside mods' boxes. Each widget keeps its lines, their
// text and widths, and rebuilds them only when what it shows changes, so a frame that
// changes nothing allocates nothing.
// use crate::text::Text;

// The icon at a line's left: an item the game draws, or an atlas sprite.
Icon :: enum {
    None,
    // The armour slot (`Game::armor`: 0 head to 3 feet).
    Armour(u8),
    // An inventory slot's item (`OFFHAND_SLOT` for the off hand), drawn without its count.
    Slot(usize),
    // A sprite by its atlas name (`mob_effect/speed`), 18 pixels square.
    Sprite(String),
}
    // rust: impl Icon {
size :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Icon::None => 0.0,
    // rust: Icon::Armour(_) | Icon::Slot(_) => 16.0,
    // rust: Icon::Sprite(_) => 18.0,
}
}
}

Line :: struct {
    icon: Icon,
    text: Text,
    // A second, grey text under the first (an effect's time left).
    detail: Maybe(Text),
    // The widest of its texts, in GUI pixels.
    text_width: f32,
    colour: u32,
}
// Padding inside a widget's box.
PAD :: 2.0
TEXT_HEIGHT :: 8.0
// Space between an icon and its text.
ICON_GAP :: 2.0
    // rust: impl Line {
new :: proc(icon: Icon, text: string, width: ^dyn Fn(string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: icon,
    // rust: text_width: width(&text),
    // rust: text: Text::literal(text),
    // rust: detail: None,
    // rust: colour: 0xFFFF_FFFF,
}
}
with_detail :: proc(detail: string, width: ^dyn Fn(string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.text_width = self.text_width.max(width(&detail));
    // rust: self.detail = Some(Text::literal(detail));
    // rust: self
}
height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let text = if self.detail.is_some() {
    // rust: 2.0 * TEXT_HEIGHT + 2.0
    // rust: } else {
    // rust: TEXT_HEIGHT
}
    // rust: text.max(self.icon.size()) + 2.0
}
    // Where the text starts, from the line's left.
text_x :: proc(self: ^Self, icon_column: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if icon_column > 0.0 {
    // rust: icon_column + ICON_GAP
    // rust: } else {
    // rust: 0.0
}
}
}

// One widget's lines, rebuilt from `K` (what they show) only when it changes. The caller
// fills [`Widget::next`] each frame (reusing its storage), then calls [`Widget::refresh`].
Widget :: struct {
    shown: Maybe(K),
    // What the widget shows this frame, filled by the caller.
    next: K,
    lines: [dynamic]Line,
    // The box's size, padding included.
    size: (f32,
}
    // rust: impl<K: PartialEq + Default> Widget<K> {
    // Rebuilds the lines with `build` when `next` differs from what they show; true if so.
refresh :: proc(self: ^Self, build: impl FnOnce(^K) {
}
    // rust: if self.shown.as_ref() == Some(&self.next) {
    // rust: return false;
}
    // rust: self.lines.clear();
    // rust: build(&self.next, &mut self.lines);
    // rust: self.size = size(&self.lines);
    // rust: let next = std::mem::take(&mut self.next);
        // The old key's storage comes back as `next` for the following frames.
    // rust: self.next = self.shown.replace(next).unwrap_or_default();
    // rust: true
}
    // Forget the lines (the widget was turned off).
clear :: proc(self: ^Self) {
}
    // rust: self.shown = None;
    // rust: self.lines.clear();
    // rust: self.size = (0.0, 0.0);
}
}
// The width of the icons' column: the widest icon of the lines.
icon_column :: proc(lines: ^[Line]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: lines.iter().map(|l| l.icon.size()).fold(0.0, f32::max)
}
// A box around `lines`, one under the other.
size :: proc(lines: ^[Line]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if lines.is_empty() {
    // rust: return (0.0, 0.0);
}
    // rust: let icons = icon_column(lines);
    // rust: let width = lines
    // rust: .iter()
    // rust: .map(|l| l.text_x(icons) + l.text_width)
    // rust: .fold(0.0, f32::max);
    // rust: let height = lines.iter().map(Line::height).sum::<f32>();
    // rust: (width + 2.0 * PAD, height + 2.0 * PAD - 2.0)
}

// How armour durability shows.
Durability :: enum {
    // Uses left.
    Number,
    // Uses left in percent of the item's maximum, rounded.
    Percent,
}
// An item's durability text: none for an item without durability.
durability :: proc(damage: u32, max: u32, mode: Durability) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if max == 0 {
    // rust: return None;
}
    // rust: let left = max.saturating_sub(damage);
    // rust: Some(match mode {
    // rust: Durability::Number => left.to_string(),
    // rust: Durability::Percent => format!("{}%", (left * 100 + max / 2) / max),
    // rust: })
}
// The colour of a durability text: `ItemStack.getBarColor`'s hue, green full to red empty.
durability_colour :: proc(damage: u32, max: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if max == 0 {
    // rust: return 0xFFFF_FFFF;
}
    // rust: let left = max.saturating_sub(damage) as f32 / max as f32;
    // Mth.hsvToRgb(f / 3, 1, 1): from red (0) through yellow to green (1/3).
    // rust: let (r, g) = if left >= 0.5 {
    // rust: ((2.0 - 2.0 * left) * 255.0, 255.0)
    // rust: } else {
    // rust: (255.0, 2.0 * left * 255.0)
}
    // rust: 0xFF00_0000 | (r as u32) << 16 | (g as u32) << 8
}

// `Direction.fromYRot`: the horizontal direction a yaw faces, as F3's "Facing" names it.
facing :: proc(yaw: f32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (f64::from(yaw) / 90.0 + 0.5).floor() as i64 & 3 {
    // rust: 0 => "south",
    // rust: 1 => "west",
    // rust: 2 => "north",
    // rust: _ => "east",
}
}

// The combo counter: hits in a row on what this player attacked, each counted when the
// server reports that entity hurt (`ClientboundDamageEventPacket`) soon after the attack;
// back to 0 when this player is hurt or no hit lands for [`Combo::EXPIRE`] seconds.
Combo :: struct {
    count: u32,
    // The entity attacked last and when.
    target: Option<(i32,
    last_hit: f64,
}
    // rust: impl Combo {
    // How long after an attack the server's hurt report still counts it.
CONFIRM :: 1.0
EXPIRE :: 3.0
attacked :: proc(self: ^Self, id: i32, now: f64) {
}
    // rust: self.target = Some((id, now));
}
    // The server reports entity `id` hurt. `by_me`: whether this player is
    // the damage's direct entity, when the report names one (melee and
    // spear hits do; Horizon's LAN hub names none for player victims). A
    // report that names nobody counts only as the answer to the last swing.
hurt :: proc(self: ^Self, id: i32, by_me: Maybe(bool), now: f64) {
}
    // rust: let confirmed = match by_me {
    // rust: Some(mine) => mine,
    // rust: None => self
    // rust: .target
    // rust: .is_some_and(|(t, at)| t == id && now - at <= Self::CONFIRM),
}
    // rust: if confirmed {
    // rust: self.target = None;
    // rust: self.count += 1;
    // rust: self.last_hit = now;
}
}
    // This player was hurt.
broken :: proc(self: ^Self) {
}
    // rust: self.count = 0;
    // rust: self.target = None;
}
count :: proc(self: ^Self, now: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if now - self.last_hit > Self::EXPIRE {
    // rust: self.count = 0;
}
    // rust: self.count
}
}

// Clicks per second: the presses of the last second, kept for the widgets that are on.
Clicks :: struct {
    // Press times in seconds, oldest first; at most [`Clicks::KEEP`].
    times: std::collections::VecDeque<f64>,
}
    // rust: impl Clicks {
    // More than any hand clicks in a second: the ring never grows past it.
KEEP :: 64
press :: proc(self: ^Self, now: f64) {
}
    // rust: if self.times.len() == Self::KEEP {
    // rust: self.times.pop_front();
}
    // rust: self.times.push_back(now);
}
    // The presses in the second up to `now`.
per_second :: proc(self: ^Self, now: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: while self.times.front().is_some_and(|&t| now - t >= 1.0) {
    // rust: self.times.pop_front();
}
    // rust: self.times.len() as u32
}
}

// Horizontal speed in blocks per second, from the player's own position sampled at most
// every [`Speed::SAMPLE`] seconds (nothing is asked of the server).
Speed :: struct {
    last: Option<([f64,
    // Tenths of a block per second.
    tenths: u32,
}
    // rust: impl Speed {
SAMPLE :: 0.25
sample :: proc(self: ^Self, x: f64, z: f64, now: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self.last {
    // rust: Some((_, at)) if now - at < Self::SAMPLE => {}
    // rust: Some(([lx, lz], at)) => {
    // rust: let d = ((x - lx).powi(2) + (z - lz).powi(2)).sqrt();
                // A teleport or respawn isn't speed.
    // rust: let v = d / (now - at);
    // rust: self.tenths = if v > 200.0 {
    // rust: 0
    // rust: } else {
    // rust: (v * 10.0).round() as u32
}
    // rust: self.last = Some(([x, z], now));
}
    // rust: None => self.last = Some(([x, z], now)),
}
    // rust: self.tenths
}
}

// The reach display: how far the last hit this player made was, measured from the eyes to
// the point the crosshair's ray met the target's box. It measures what the client already
// computed for the attack and changes nothing about it.
Reach :: struct {
    last: Option<(f64,
}
    // rust: impl Reach {
    // How long the last hit's distance stays shown.
SHOWN :: 3.0
hit :: proc(self: ^Self, distance: f64, now: f64) {
}
    // rust: self.last = Some((distance, now));
}
    // Hundredths of a block, while the last hit is recent.
hundredths :: proc(self: ^Self, now: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (d, at) = self.last?;
    // rust: (now - at <= Self::SHOWN).then(|| (d * 100.0).round() as u32)
}
}
// `n` hundredths as "3.05".
hundredths :: proc(n: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{}.{:02}", n / 100, n % 100)
}
// `n` tenths as "4.3".
tenths :: proc(n: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{}.{}", n / 10, n % 10)
}
// The local time as "14:05".
clock :: proc(hour: u8, minute: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{hour:02}:{minute:02}")
}

// The keystrokes widget's keys, in drawing order.
Key :: enum {
    Forward,
    Left,
    Back,
    Right,
    Attack,
    Use,
    Jump,
}
    // rust: impl Key {
    // rust: pub const ALL: [Key; 7] = [
    // rust: Key::Forward,
    // rust: Key::Left,
    // rust: Key::Back,
    // rust: Key::Right,
    // rust: Key::Attack,
    // rust: Key::Use,
    // rust: Key::Jump,
    // rust: ];
    // The key mapping it shows.
mapping :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Key::Forward => "key.forward",
    // rust: Key::Left => "key.left",
    // rust: Key::Back => "key.back",
    // rust: Key::Right => "key.right",
    // rust: Key::Attack => "key.attack",
    // rust: Key::Use => "key.use",
    // rust: Key::Jump => "key.jump",
}
}
}
// The keystrokes' key size and the gap between keys, in GUI pixels.
KEY :: 22.0
KEY_GAP :: 2.0
// The space bar's height.
SPACE :: 12.0
// Where each key of the keystrokes widget sits in its box: W above A S D, the two mouse
// buttons under them, the space bar at the bottom, as `(x, y, w, h)`.
key_rect :: proc(key: Key) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let step = KEY + KEY_GAP;
    // rust: let full = 3.0 * KEY + 2.0 * KEY_GAP;
    // rust: let half = (full - KEY_GAP) / 2.0;
    // rust: match key {
    // rust: Key::Forward => (step, 0.0, KEY, KEY),
    // rust: Key::Left => (0.0, step, KEY, KEY),
    // rust: Key::Back => (step, step, KEY, KEY),
    // rust: Key::Right => (2.0 * step, step, KEY, KEY),
    // rust: Key::Attack => (0.0, 2.0 * step, half, KEY),
    // rust: Key::Use => (half + KEY_GAP, 2.0 * step, half, KEY),
    // rust: Key::Jump => (0.0, 3.0 * step, full, SPACE),
}
}
// The keystrokes widget's size.
keys_size :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (_, y, w, h) = key_rect(Key::Jump);
    // rust: (w, y + h)
}

// The HUD widgets, for their places on screen ([`Layout`]).
WidgetId :: enum {
    Armour,
    Effects,
    Held,
    Ping,
    Coords,
    Server,
    Combo,
    Fps,
    Cps,
    Keys,
    Clock,
    Reach,
    Speed,
}
    // rust: impl WidgetId {
    // rust: pub const ALL: [WidgetId; 13] = [
    // rust: WidgetId::Armour,
    // rust: WidgetId::Effects,
    // rust: WidgetId::Held,
    // rust: WidgetId::Ping,
    // rust: WidgetId::Coords,
    // rust: WidgetId::Server,
    // rust: WidgetId::Combo,
    // rust: WidgetId::Fps,
    // rust: WidgetId::Cps,
    // rust: WidgetId::Keys,
    // rust: WidgetId::Clock,
    // rust: WidgetId::Reach,
    // rust: WidgetId::Speed,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: WidgetId::Armour => "armour",
    // rust: WidgetId::Effects => "effects",
    // rust: WidgetId::Held => "held",
    // rust: WidgetId::Ping => "ping",
    // rust: WidgetId::Coords => "coords",
    // rust: WidgetId::Server => "server",
    // rust: WidgetId::Combo => "combo",
    // rust: WidgetId::Fps => "fps",
    // rust: WidgetId::Cps => "cps",
    // rust: WidgetId::Keys => "keys",
    // rust: WidgetId::Clock => "clock",
    // rust: WidgetId::Reach => "reach",
    // rust: WidgetId::Speed => "speed",
}
}
index :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self as usize
}
}

// Where a widget sits: in its corner, stacked with the others there (`at` is `None`), or at a
// place the player dragged it to, as fractions of the room the screen leaves around the box
// (0 at the left or top edge, 1 at the right or bottom), so it stays on screen at any size.
Place :: struct {
    at: Option<(f32,
    // Its size in percent.
    scale: u8,
}
    // rust: impl Default for Place {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: at: None,
    // rust: scale: 100,
}
}
}
SCALES :: (50, 200)
// Every widget's place.
Layout :: struct {
    // rust: impl Layout {
get :: proc(self: ^Self, id: WidgetId) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.0[id.index()]
}
get_mut :: proc(self: ^Self, id: WidgetId) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.0[id.index()]
}
    // One `hudPlace` value: `armour,0.25,0.5,150`, or `armour,corner,,150`.
parse :: proc(self: ^Self, value: string) {
}
    // rust: let mut parts = value.split(',');
    // rust: let Some(id) = parts
    // rust: .next()
    // rust: .and_then(|n| WidgetId::ALL.into_iter().find(|w| w.name() == n))
    // rust: else {
    // rust: return;
}
    // rust: let (x, y, scale) = (parts.next(), parts.next(), parts.next());
    // rust: let frac = |v: Option<&str>| {
    // rust: v.and_then(|v| v.parse::<f32>().ok())
    // rust: .filter(|v| v.is_finite())
    // rust: .map(|v| v.clamp(0.0, 1.0))
}
    // rust: let place = self.get_mut(id);
    // rust: place.at = frac(x).zip(frac(y));
    // rust: if let Some(s) = scale.and_then(|s| s.parse::<u8>().ok()) {
    // rust: place.scale = s.clamp(SCALES.0, SCALES.1);
}
}
    // The `hudPlace` lines of the widgets that left their corner or their size.
serialize :: proc(self: ^Self, out: ^string) {
}
//         use std::fmt::Write;
    // rust: for id in WidgetId::ALL {
    // rust: let p = self.get(id);
    // rust: if p == Place::default() {
    // rust: continue;
}
    // rust: let _ = match p.at {
    // rust: Some((x, y)) => writeln!(out, "hudPlace:{},{x:.4},{y:.4},{}", id.name(), p.scale),
    // rust: None => writeln!(out, "hudPlace:{},corner,,{}", id.name(), p.scale),
}
}
}
}
// A box `w` x `h` placed at fractions `(fx, fy)` of the room left on a `screen`.
from_fractions :: proc() {
}
    // rust: (
    // rust: (fx * (screen.0 - w).max(0.0)).round(),
    // rust: (fy * (screen.1 - h).max(0.0)).round(),
    // rust: )
}
// The fractions that put a `w` x `h` box at `(x, y)` on a `screen`, kept on screen.
to_fractions :: proc() {
}
    // rust: let frac = |v: f32, room: f32| {
    // rust: if room > 0.0 {
    // rust: (v / room).clamp(0.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
}
    // rust: (frac(x, screen.0 - w), frac(y, screen.1 - h))
}
// How near, in GUI pixels, an edge must come to another to snap to it.
SNAP :: 4.0
// Snaps a box's start `x` of length `w` along one axis of length `screen`: to the screen's
// edges and middle, and to the edges of the `others` boxes (`(start, length)`), where one
// is within [`SNAP`]. Returns the new start and the line it snapped to, if any.
snap :: proc(x: f32, w: f32, screen: f32, others: ^[(f32) {
}
    // rust: let mut best: Option<(f32, f32, f32)> = None;
    // rust: let mut consider = |start: f32, line: f32| {
    // rust: let d = (start - x).abs();
    // rust: if d <= SNAP && best.is_none_or(|(b, _, _)| d < b) {
    // rust: best = Some((d, start, line));
}
}
    // The screen's edges, with the corners' margin, and its middle.
    // rust: consider(2.0, 0.0);
    // rust: consider(screen - 2.0 - w, screen);
    // rust: consider((screen - w) / 2.0, screen / 2.0);
    // rust: for &(o, ow) in others {
        // Side by side, or lined up on the same edge.
    // rust: consider(o + ow, o + ow);
    // rust: consider(o - w, o);
    // rust: consider(o, o);
    // rust: consider(o + ow - w, o + ow);
}
    // rust: match best {
    // rust: Some((_, start, line)) => (start.clamp(0.0, (screen - w).max(0.0)), Some(line)),
    // rust: None => (x.clamp(0.0, (screen - w).max(0.0)), None),
}
}

    // rust: mod tests {
//     use super::*;

width :: proc(s: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 6.0 * s.chars().count() as f32
}

durability_shows_uses_left_as_a_number_or_a_percent :: proc() {
}
        // A diamond chestplate (528 uses) after 100 hits.
    // rust: assert_eq!(
    // rust: durability(100, 528, Durability::Number).as_deref(),
    // rust: Some("428")
    // rust: );
    // rust: assert_eq!(
    // rust: durability(100, 528, Durability::Percent).as_deref(),
    // rust: Some("81%")
    // rust: );
    // rust: assert_eq!(
    // rust: durability(0, 528, Durability::Percent).as_deref(),
    // rust: Some("100%")
    // rust: );
    // rust: assert_eq!(
    // rust: durability(528, 528, Durability::Number).as_deref(),
    // rust: Some("0")
    // rust: );
    // rust: assert_eq!(
    // rust: durability(0, 0, Durability::Number),
    // rust: None,
    // rust: "a pumpkin on the head"
    // rust: );
    // rust: assert_eq!(durability_colour(0, 100), 0xFF00_FF00);
    // rust: assert_eq!(durability_colour(100, 100), 0xFFFF_0000);
    // rust: assert_eq!(durability_colour(50, 100), 0xFFFF_FF00);
}

facing_follows_direction_from_y_rot :: proc() {
}
        // Yaw 0 looks toward +Z (south); turning right (yaw up) goes west, north, east.
    // rust: let names: Vec<_> = [0.0, 44.9, 45.0, 90.0, 180.0, -90.0, 270.0, -180.0, 720.0]
    // rust: .map(facing)
    // rust: .to_vec();
    // rust: assert_eq!(
    // rust: names,
    // rust: [
    // rust: "south", "south", "west", "west", "north", "east", "east", "north", "south"
    // rust: ]
    // rust: );
}

combos_count_confirmed_hits_until_this_player_is_hurt :: proc() {
}
    // rust: let mut c = Combo::default();
    // rust: c.attacked(7, 0.0);
    // rust: c.hurt(7, None, 0.1);
    // rust: c.attacked(7, 0.6);
    // rust: c.hurt(7, None, 0.7);
    // rust: assert_eq!(c.count(0.8), 2);
        // Another entity hurt, or a report too late after the swing, adds nothing.
    // rust: c.attacked(7, 1.0);
    // rust: c.hurt(9, None, 1.1);
    // rust: c.hurt(7, None, 2.5);
    // rust: assert_eq!(c.count(2.5), 2);
        // One report per swing: a second one (thorns, fire) for the same attack doesn't count.
    // rust: c.attacked(7, 3.0);
    // rust: c.hurt(7, None, 3.1);
    // rust: c.hurt(7, None, 3.2);
    // rust: assert_eq!(c.count(3.2), 3);
    // rust: c.broken();
    // rust: assert_eq!(c.count(3.3), 0);
    // rust: c.attacked(7, 4.0);
    // rust: c.hurt(7, None, 4.1);
    // rust: assert_eq!(c.count(7.0), 1);
    // rust: assert_eq!(c.count(7.2), 0, "more than 3 s since the last hit");
        // A report that names who hit decides alone: a spear jab (no swing
        // remembered) counts, a teammate's hit right after a swing doesn't.
    // rust: c.hurt(7, Some(true), 8.0);
    // rust: c.attacked(7, 8.5);
    // rust: c.hurt(7, Some(false), 8.6);
    // rust: assert_eq!(c.count(8.7), 1);
}

a_widget_rebuilds_only_when_what_it_shows_changes :: proc() {
}
    // rust: let mut w: Widget<Vec<u32>> = Widget::default();
    // rust: let mut builds = 0;
    // rust: for frame in 0..10 {
    // rust: w.next.clear();
    // rust: w.next.push(if frame < 5 { 7 } else { 8 });
    // rust: w.refresh(|k, lines| {
    // rust: builds += 1;
    // rust: lines.push(Line::new(Icon::None, k[0].to_string(), &width));
    // rust: });
}
    // rust: assert_eq!(builds, 2);
    // rust: assert_eq!(w.lines[0].text.plain(), "8");
    // rust: w.clear();
    // rust: w.next.clear();
    // rust: w.next.push(8);
    // rust: assert!(w.refresh(|_, lines| lines.push(Line::new(Icon::None, "x".into(), &width))));
}

the_box_fits_its_widest_line_and_icons_line_up :: proc() {
}
    // rust: let lines = [
    // rust: Line::new(Icon::Armour(3), "428".into(), &width),
    // rust: Line::new(Icon::None, "12345".into(), &width),
    // rust: Line::new(
    // rust: Icon::Sprite("mob_effect/speed".into()),
    // rust: "Speed II".into(),
    // rust: &width,
    // rust: )
    // rust: .with_detail("01:30".into(), &width),
    // rust: ];
    // rust: assert_eq!(icon_column(&lines), 18.0);
        // Texts start after the 18-pixel column and a 2-pixel gap: the widest is "Speed II"
        // (48 pixels).
    // rust: let (w, h) = size(&lines);
    // rust: assert_eq!(w, 2.0 + 18.0 + 2.0 + 48.0 + 2.0);
        // 18 + 2 for the icon lines (the effect's two texts take 18), 8 + 2 for the text one.
    // rust: assert_eq!(h, 18.0 + 10.0 + 20.0 + 2.0 * PAD - 2.0);
    // rust: assert!(size(&[]) == (0.0, 0.0));
}

clicks_count_the_presses_of_the_last_second :: proc() {
}
    // rust: let mut c = Clicks::default();
    // rust: for t in [0.0, 0.1, 0.5, 0.9] {
    // rust: c.press(t);
}
    // rust: assert_eq!(c.per_second(0.95), 4);
        // 1.0 s after the first press it has left the window.
    // rust: assert_eq!(c.per_second(1.0), 3);
    // rust: assert_eq!(c.per_second(1.6), 1);
    // rust: assert_eq!(c.per_second(5.0), 0);
        // The ring never keeps more than 64 presses.
    // rust: for i in 0..200 {
    // rust: c.press(10.0 + f64::from(i) * 0.001);
}
    // rust: assert_eq!(c.per_second(10.2), 64);
}

speed_is_horizontal_blocks_per_second_between_samples :: proc() {
}
    // rust: let mut s = Speed::default();
    // rust: assert_eq!(s.sample(0.0, 0.0, 0.0), 0);
        // Sprinting: 5.612 blocks per second along x, with a jump (y is ignored).
    // rust: assert_eq!(s.sample(0.5, 0.0, 0.1), 0, "too soon for a new sample");
    // rust: assert_eq!(s.sample(1.403, 0.0, 0.25), 56);
        // 3 east and 4 south in a second: 5 blocks per second.
    // rust: assert_eq!(s.sample(1.403 + 3.0, 4.0, 1.25), 50);
        // A teleport reads as standing still.
    // rust: assert_eq!(s.sample(1000.0, 4.0, 1.5), 0);
    // rust: assert_eq!(tenths(56), "5.6");
}

reach_shows_the_last_hit_for_three_seconds :: proc() {
}
    // rust: let mut r = Reach::default();
    // rust: assert_eq!(r.hundredths(0.0), None);
    // rust: r.hit(2.954, 1.0);
    // rust: assert_eq!(r.hundredths(1.5), Some(295));
    // rust: assert_eq!(hundredths(295), "2.95");
    // rust: assert_eq!(hundredths(300), "3.00");
    // rust: assert_eq!(r.hundredths(4.1), None);
}

the_clock_reads_hours_and_minutes :: proc() {
}
    // rust: assert_eq!(clock(14, 5), "14:05");
    // rust: assert_eq!(clock(0, 0), "00:00");
}

keystrokes_keys_tile_their_box_without_overlap :: proc() {
}
    // rust: let (w, h) = keys_size();
    // rust: assert_eq!((w, h), (70.0, 3.0 * 24.0 + 12.0));
    // rust: for (i, a) in Key::ALL.iter().enumerate() {
    // rust: let (x, y, kw, kh) = key_rect(*a);
    // rust: assert!(
    // rust: x >= 0.0 && y >= 0.0 && x + kw <= w && y + kh <= h,
    // rust: "{a:?} inside"
    // rust: );
    // rust: for b in &Key::ALL[i + 1..] {
    // rust: let (bx, by, bw, bh) = key_rect(*b);
    // rust: let apart = x + kw <= bx || bx + bw <= x || y + kh <= by || by + bh <= y;
    // rust: assert!(apart, "{a:?} and {b:?} overlap");
}
}
}

places_round_trip_and_only_moved_widgets_are_written :: proc() {
}
    // rust: let mut l = Layout::default();
    // rust: let mut text = String::new();
    // rust: l.serialize(&mut text);
    // rust: assert_eq!(text, "", "a vanilla layout writes nothing");
    // rust: *l.get_mut(WidgetId::Keys) = Place {
    // rust: at: Some((0.25, 1.0)),
    // rust: scale: 150,
}
    // rust: l.get_mut(WidgetId::Fps).scale = 75;
    // rust: l.serialize(&mut text);
    // rust: assert_eq!(
    // rust: text,
    // rust: "hudPlace:fps,corner,,75\nhudPlace:keys,0.2500,1.0000,150\n"
    // rust: );
    // rust: let mut back = Layout::default();
    // rust: for line in text.lines() {
    // rust: back.parse(line.split_once(':').unwrap().1);
}
    // rust: assert_eq!(back, l);
        // Out of range values are clamped, unknown widgets and bad numbers ignored.
    // rust: back.parse("speed,-3,7,250");
    // rust: assert_eq!(back.get(WidgetId::Speed).at, Some((0.0, 1.0)));
    // rust: assert_eq!(back.get(WidgetId::Speed).scale, 200);
    // rust: back.parse("radar,0.5,0.5,100");
    // rust: back.parse("clock,NaN,0.5,100");
    // rust: assert_eq!(back.get(WidgetId::Clock).at, None);
}

fractions_keep_a_box_on_screen_at_any_size :: proc() {
}
    // rust: let screen = (480.0, 270.0);
    // rust: let at = to_fractions((100.0, 50.0), (80.0, 20.0), screen);
    // rust: assert_eq!(from_fractions(at, (80.0, 20.0), screen), (100.0, 50.0));
        // A box at the right edge stays at the right edge on a wider screen.
    // rust: let right = to_fractions((400.0, 0.0), (80.0, 20.0), screen);
    // rust: assert_eq!(right, (1.0, 0.0));
    // rust: assert_eq!(
    // rust: from_fractions(right, (80.0, 20.0), (960.0, 540.0)),
    // rust: (880.0, 0.0)
    // rust: );
        // Dragged past the edge: kept inside.
    // rust: assert_eq!(
    // rust: to_fractions((-30.0, 900.0), (80.0, 20.0), screen),
    // rust: (0.0, 1.0)
    // rust: );
}

boxes_snap_to_screen_edges_middle_and_each_other :: proc() {
}
        // Near the left margin.
    // rust: assert_eq!(snap(4.5, 50.0, 480.0, &[]), (2.0, Some(0.0)));
        // Centred: the middle of 480 for a 50-wide box starts at 215.
    // rust: assert_eq!(snap(213.0, 50.0, 480.0, &[]), (215.0, Some(240.0)));
        // Beside another box (100..160): its start goes to 160.
    // rust: assert_eq!(
    // rust: snap(163.0, 50.0, 480.0, &[(100.0, 60.0)]),
    // rust: (160.0, Some(160.0))
    // rust: );
        // Lined up with its left edge.
    // rust: assert_eq!(
    // rust: snap(98.0, 50.0, 480.0, &[(100.0, 60.0)]),
    // rust: (100.0, Some(100.0))
    // rust: );
        // Too far from anything: stays, but never off screen.
    // rust: assert_eq!(snap(300.0, 50.0, 480.0, &[(100.0, 60.0)]), (300.0, None));
    // rust: assert_eq!(snap(470.0, 50.0, 480.0, &[]), (430.0, None));
}
}
