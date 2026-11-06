//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pvp
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The PvP & HUD page's options in the game (`horizon_client::pvp`, `docs/pvp.md`). Each
//! does nothing while it is off.
// use super::{Dim, Game};
// use horizon_client::{
    // rust: extras::Corner,
    // rust: extras_hud::Corners,
    // rust: hud::{HudBatch, rgba},
    // rust: mesher::Vertex,
    // rust: pvp::{Colour, CrosshairCache},
    // rust: pvp_hud::{self, Combo, Durability, Icon, Key, Line, Widget},
    // rust: text::Text,
}
// use std::sync::Arc;
// use winit::event::MouseButton;

    // rust: pub(super) struct PvpState {
    // rust: crosshair: CrosshairCache,
    /// Each armour slot's item, damage and maximum damage, and whether durability is in percent.
    // rust: armour: Widget<([Option<(Arc<str>, u32, u32)>; 4], bool)>,
    /// Each effect: id, amplifier, whole seconds left (-1 infinite).
    // rust: effects: Widget<Vec<(&'static str, i32, i32)>>,
    /// The counted item's slot and the total.
    // rust: held: Widget<Option<(usize, Arc<str>, u32)>>,
    // rust: ping: Widget<Option<i32>>,
    /// The block position and the direction faced.
    // rust: coords: Widget<Option<([i32; 3], &'static str)>>,
    // rust: server: Widget<Option<String>>,
    // rust: combo: Combo,
    // rust: combo_count: Widget<u32>,
    // rust: fps: Widget<u32>,
    /// Left and right presses, counted while the CPS or keystrokes widget is on.
    // rust: clicks: [pvp_hud::Clicks; 2],
    // rust: cps: Widget<(u32, u32)>,
    // rust: keys: Keystrokes,
    /// The local hour and minute, and when they were read.
    // rust: clock: Widget<(u8, u8)>,
    // rust: clock_read: f64,
    // rust: reach: pvp_hud::Reach,
    // rust: reach_shown: Widget<Option<u32>>,
    // rust: speed: pvp_hud::Speed,
    // rust: speed_shown: Widget<u32>,
    /// Each widget drawn last frame and its box on screen, for the HUD editor.
    // rust: pub(super) boxes: Vec<(pvp_hud::WidgetId, [f32; 4])>,
    /// The HUD editor, while it is open.
    // rust: pub(super) editor: Option<super::hud_editor::HudEditor>,
    /// The open chat's box holds a chat search's query (Ctrl+F).
    // rust: pub(super) chat_search: bool,
    /// What the chat box held when the search borrowed it.
    // rust: pub(super) chat_search_aside: String,
}
/// `GuiGraphicsExtractor`'s grey for a detail line (an effect's time left).
pub const DETAIL: u32 = 0xFF7F_7F7F;
/// How the widgets look: their boxes' colour (none without boxes), text colour and shadow.
pub const Style = struct {
    background: ?u32,
    text: u32,
    shadow: bool,
};
/// A held key's box in the keystrokes widget, and its text.
pub const KEY_HELD: u32 = 0xB4FF_FFFF;
pub const KEY_HELD_TEXT: u32 = 0xFF00_0000;

/// The keystrokes widget: each key's label, made again only when its binding changes, which
/// keys are held, and the clicks per second under the mouse buttons.
pub const Keystrokes = struct {
    bound: [[]const u8,
    labels: Vec<(Text,
    held: [bool,
    cps: Widget<(u32,
};
    // rust: const ARROWS: [&str; 3] = [
    // rust: "minecraft:arrow",
    // rust: "minecraft:spectral_arrow",
    // rust: "minecraft:tipped_arrow",
    // rust: ];

    // rust: impl Game<'_> {
    /// Whether the custom crosshair replaces vanilla's sprite.
    // rust: pub(super) fn custom_crosshair(&self) -> bool {
    // rust: self.settings.extras.pvp.crosshair.custom
}
    /// The custom crosshair, centred where vanilla's 15x15 sprite is (`Hud.extractCrosshair`):
    /// its outline in black, then the shape, inverting what is under it when its colour is
    /// `Inverted`. The runs are cached, so a frame only adds their quads.
    // rust: pub(super) fn draw_custom_crosshair(&mut self, batch: &mut HudBatch, w: i32, h: i32) {
    // rust: let mut c = self.settings.extras.pvp.crosshair;
    // rust: if let Some(hover) = c.hover
    // rust: && self.crosshair_living() == Some(true)
    // rust: {
    // rust: c.colour = hover;
}
    // rust: let (cx, cy) = ((w - 15) / 2 + 7, (h - 15) / 2 + 7);
    // rust: let atlas = &self.gui.atlas;
    // rust: let (shape, rim) = self.pvp.crosshair.runs(&c);
    // rust: let fill = |batch: &mut HudBatch, &(x0, y, x1): &(i32, i32, i32), colour: u32| {
    // rust: let (x, y) = ((cx + x0) as f32, (cy + y) as f32);
    // rust: batch.fill(atlas, x, y, (x1 - x0) as f32, 1.0, colour);
}
    // rust: for run in rim {
    // rust: fill(batch, run, rgba(0, 0, 0, 255));
}
    // rust: let start = batch.vertices.len();
    // rust: let [a, r, g, b] = c.colour.argb().to_be_bytes();
    // rust: for run in shape {
    // rust: fill(batch, run, rgba(r, g, b, a));
}
    // rust: if c.colour == Colour::Inverted {
    // rust: batch.invert_since(start);
}
}
    /// The block outline's fill: each box of the targeted block's shape (`getShape`, the boxes
    /// the outline's edges come from) as translucent faces drawn after translucent terrain,
    /// pushed out a little so they don't fight the block's own faces. Only while the outline
    /// shows (`outline` is its edges).
    // rust: pub(super) fn outline_fill(
    // rust: &self,
    // rust: outline: &[[f64; 6]],
    // rust: camera: glam::DVec3,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(argb) = self.settings.extras.pvp.outline.fill() else {
    // rust: return;
}
    // rust: let Some(hit) = self.pick().filter(|_| !outline.is_empty()) else {
    // rust: return;
}
    // rust: let [x, y, z] = hit.pos;
    // rust: let state = self.world.block(x, y, z);
    // rust: let facts = self.res.facts().get(state);
    // rust: let offset = match facts.outline_offset {
    // rust: true => self.pack.context.tables.offset(state, x, z),
    // rust: false => None,
}
    // rust: .unwrap_or([0.0; 3]);
    // rust: let base = [f64::from(x), f64::from(y), f64::from(z)];
    // rust: let context = self.context_outline(hit.pos, state);
    // rust: let boxes = context.as_slice().iter().chain(match context {
    // rust: Some(_) => &[][..],
    // rust: None => &facts.outline[..],
    // rust: });
    // rust: let uv = horizon_client::gfx::lightning::white_uv(&self.gui.atlas.font.white());
    // rust: let [a, r, g, b] = argb.to_be_bytes();
    // rust: let color = u32::from_le_bytes([r, g, b, a]);
pub const OUT: f64 = 0.002;
    // rust: for shape in boxes {
    // rust: let corner = |i: usize, high: bool| {
    // rust: let v = if high {
    // rust: shape[i + 3] + OUT
    // rust: } else {
    // rust: shape[i] - OUT
}
    // rust: (base[i] + offset[i] + v - camera[i]) as f32
}
            // Each face: the axis it faces along, its side, and its corners' other two axes.
    // rust: for axis in 0..3 {
    // rust: let (u, v) = ((axis + 1) % 3, (axis + 2) % 3);
    // rust: for high in [false, true] {
    // rust: for (hu, hv) in [(false, false), (true, false), (true, true), (false, true)] {
    // rust: let mut pos = [0.0; 3];
    // rust: pos[axis] = corner(axis, high);
    // rust: pos[u] = corner(u, hu);
    // rust: pos[v] = corner(v, hv);
    // rust: out.push(Vertex {
    // rust: pos,
    // rust: uv,
    // rust: layer: horizon_client::gfx::TRANSLUCENT_PARTICLE_OVERLAY,
    // rust: color,
    // rust: light: 240 | 240 << 8,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: });
}
}
}
}
}
    /// Once per frame: the options that live outside the game's state.
    // rust: pub(super) fn pvp_frame(&mut self) {
    // rust: let tweaks = self.settings.extras.pvp.tweaks;
    // rust: horizon_client::enchant::set_numeric_levels(tweaks.numeric_enchants);
}
    /// Whether this window may draw PvP & HUD's own time and weather: only a client of a server
    /// (single player's included) draws them, never the server that ticks the world.
pub fn own_view(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote.is_some() && self.dim == Dim::Overworld
}
    /// The day time the frame draws (sky, sun, moon, the sky's light): PvP & HUD's time of day,
    /// else the world's. The world's own `day_time` and everything that plays by it stay.
    // rust: pub(super) fn view_day_time(&self) -> i64 {
    // rust: let fixed = self.settings.extras.pvp.tweaks.time;
    // rust: horizon_client::pvp::view_day_time(self.world.day_time, fixed.filter(|_| self.own_view()))
}
    /// The rain and thunder levels the frame draws (rain, the sky's colour and light, fog): PvP &
    /// HUD's weather, else the world's. Gameplay (riptide, mobs, crops) keeps the world's.
    // rust: pub(super) fn view_weather(&self, partial: f32) -> (f32, f32) {
    // rust: match self.settings.extras.pvp.tweaks.weather {
    // rust: Some(w) if self.own_view() && self.can_have_weather() => w.levels(),
    // rust: _ => self.weather_levels(partial),
}
}
    /// This player attacked entity `id`, `distance` from the eyes to where the crosshair's
    /// ray met its box (the combo counter waits for the server's report; the reach widget
    /// shows the distance).
    // rust: pub(super) fn pvp_attacked(&mut self, id: i32, distance: f64) {
    // rust: let now = self.started.elapsed().as_secs_f64();
    // rust: self.pvp.combo.attacked(id, now);
    // rust: self.pvp.reach.hit(distance, now);
}
    /// A mouse press, counted for clicks per second while playing with a widget that shows them.
    // rust: pub(super) fn pvp_click(&mut self, button: MouseButton) {
    // rust: let hud = &self.settings.extras.pvp.hud;
    // rust: if !(hud.cps || hud.keys) || self.screen != super::Screen::Playing {
    // rust: return;
}
    // rust: let i = match button {
    // rust: MouseButton::Left => 0,
    // rust: MouseButton::Right => 1,
    // rust: _ => return,
}
    // rust: let now = self.started.elapsed().as_secs_f64();
    // rust: self.pvp.clicks[i].press(now);
}
    /// Whether the key `mapping` is bound to is held: a keyboard key or a mouse button.
pub fn binding_held(self: *Self, mapping: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bound = self.settings.keys.get(mapping);
    // rust: if let Some(button) = horizon_client::keybinds::mouse_button(bound) {
    // rust: return self.physical_buttons.contains(&button);
}
    // rust: self.mapped_key_down(mapping)
}
    /// The server reports entity `id` hurt; `own` when it is this player,
    /// `by_me` whether this player was the damage's direct entity (if named).
    // rust: pub(super) fn pvp_hurt(&mut self, id: i32, own: bool, by_me: Option<bool>) {
    // rust: if own {
    // rust: self.pvp.combo.broken();
    // rust: } else {
    // rust: let now = self.started.elapsed().as_secs_f64();
    // rust: self.pvp.combo.hurt(id, by_me, now);
}
}
    /// Whether the effects widget replaces vanilla's effect icons (`Hud.extractEffects`).
    // rust: pub(super) fn pvp_effects_shown(&self) -> bool {
    // rust: self.settings.extras.pvp.hud.effects
}
    /// The HUD widgets that are on, after the minimap and before mods' boxes. Each rebuilds its
    /// lines only when what it shows changed.
    // rust: pub(super) fn draw_pvp_hud(&mut self, batch: &mut HudBatch, corners: &mut Corners) {
    // rust: let hud = self.settings.extras.pvp.hud;
    // rust: if self.player.is_none() || !hud.any() {
            // The editor frames only what was drawn.
    // rust: self.pvp.boxes.clear();
    // rust: return;
}
        // What each widget shows, read before its cache is borrowed.
    // rust: let armour: [Option<(Arc<str>, u32, u32)>; 4] = std::array::from_fn(|i| {
    // rust: let s = self.armor[i].as_ref()?;
    // rust: let max = self.items().get(&s.item).map_or(0, |i| i.max_damage);
    // rust: Some((s.item.clone(), s.damage, max))
    // rust: });
    // rust: let held = if hud.held { self.held_count() } else { None };
    // rust: let multiplayer = self.remote.is_some() && !self.has_singleplayer_server();
    // rust: let ping = self.own_latency().filter(|_| multiplayer);
    // rust: let coords = self.player.as_ref().filter(|_| !self.reduced_debug_info());
    // rust: let coords = coords.map(|p| {
    // rust: let at = [p.position.x, p.position.y, p.position.z].map(|v| v.floor() as i32);
    // rust: (at, pvp_hud::facing(self.yaw))
    // rust: });
        // The address is copied only when it changed (`server_address` borrows the whole game).
    // rust: let server = self.server_address().filter(|_| multiplayer);
    // rust: let server = (hud.server && self.pvp.server.next.as_deref() != server)
    // rust: .then(|| server.map(str::to_owned));
    // rust: let now = self.started.elapsed().as_secs_f64();
    // rust: let fps = self.fps.round() as u32;
    // rust: let position = self.player.as_ref().map(|p| (p.position.x, p.position.z));
    // rust: if hud.keys {
    // rust: let held = Key::ALL.map(|k| self.binding_held(k.mapping()));
    // rust: self.pvp.keys.held = held;
    // rust: self.keystroke_labels();
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let width = |s: &str| HudBatch::text_width(atlas, s);
    // rust: let state = &mut self.pvp;
    // rust: if hud.armour {
    // rust: let w = &mut state.armour;
    // rust: w.next = (armour, hud.armour_percent);
    // rust: w.refresh(|(pieces, percent), lines| {
    // rust: let mode = if *percent {
    // rust: Durability::Percent
    // rust: } else {
    // rust: Durability::Number
}
                // `Game::armor` holds the head first: it is drawn at the top.
    // rust: for (i, piece) in pieces.iter().enumerate() {
    // rust: let Some((_, damage, max)) = piece else {
    // rust: continue;
}
    // rust: let text = pvp_hud::durability(*damage, *max, mode).unwrap_or_default();
    // rust: let mut line = Line::new(Icon::Armour(i as u8), text, &width);
    // rust: line.colour = pvp_hud::durability_colour(*damage, *max);
    // rust: lines.push(line);
}
    // rust: });
    // rust: } else {
    // rust: state.armour.clear();
}
    // rust: if hud.effects {
    // rust: let w = &mut state.effects;
    // rust: let rate = self.clock.rate();
    // rust: w.next.clear();
    // rust: w.next.extend(self.potions.effects.list.iter().map(|e| {
    // rust: let secs = if e.duration == -1 {
    // rust: -1
    // rust: } else {
    // rust: (e.duration as f32 / rate) as i32
}
    // rust: (e.id, e.amplifier, secs)
    // rust: }));
    // rust: let names = &self.pack.names;
    // rust: w.refresh(|effects, lines| {
    // rust: for &(id, amplifier, secs) in effects {
    // rust: let key = horizon_client_core::potions::description_id(id);
    // rust: let mut name = names.display_get(&key).unwrap_or_else(|| id.to_owned());
                    // EffectsInInventory.getEffectName: the level from II to X.
    // rust: if (1..=9).contains(&amplifier) {
    // rust: let level = amplifier + 1;
    // rust: let suffix = names
    // rust: .display_get(&format!("enchantment.level.{level}"))
    // rust: .unwrap_or_else(|| horizon_client::enchant::level_name(level as u32));
    // rust: name = format!("{name} {suffix}");
}
    // rust: let time = if secs == -1 {
    // rust: names
    // rust: .display_get("effect.duration.infinite")
    // rust: .unwrap_or_else(|| "∞".into())
    // rust: } else {
    // rust: horizon_client::brewing::format_tick_duration(secs, 1.0)
}
    // rust: let sprite = match id.split_once(':') {
    // rust: Some((ns, path)) => format!("{ns}:mob_effect/{path}"),
    // rust: None => format!("mob_effect/{id}"),
}
    // rust: let line = Line::new(Icon::Sprite(sprite), name, &width);
    // rust: lines.push(line.with_detail(time, &width));
}
    // rust: });
    // rust: } else {
    // rust: state.effects.clear();
}
    // rust: if hud.held {
    // rust: let w = &mut state.held;
    // rust: w.next = held;
    // rust: w.refresh(|held, lines| {
    // rust: if let Some((slot, _, total)) = held {
    // rust: lines.push(Line::new(Icon::Slot(*slot), total.to_string(), &width));
}
    // rust: });
    // rust: } else {
    // rust: state.held.clear();
}
    // rust: let text = |key: &str, args: &[&dyn std::fmt::Display]| {
    // rust: let line = horizon_client::lang::tr(key, args);
    // rust: Line::new(Icon::None, line, &width)
}
    // rust: if hud.ping {
    // rust: state.ping.next = ping;
    // rust: state.ping.refresh(|ping, lines| {
    // rust: lines.extend(ping.map(|ms| text("horizon.pvp.hud.ping", &[&ms])));
    // rust: });
    // rust: } else {
    // rust: state.ping.clear();
}
    // rust: if hud.coords {
    // rust: state.coords.next = coords;
    // rust: state.coords.refresh(|coords, lines| {
    // rust: if let Some(([x, y, z], facing)) = coords {
    // rust: lines.push(text("horizon.pvp.hud.coords", &[x, y, z]));
    // rust: let key = format!("horizon.pvp.hud.direction.{facing}");
    // rust: let name = horizon_client::lang::get_or(&key, facing);
    // rust: lines.push(text("horizon.pvp.hud.facing", &[&name]));
}
    // rust: });
    // rust: } else {
    // rust: state.coords.clear();
}
    // rust: if hud.server {
            // A new String only when the address changes.
    // rust: let w = &mut state.server;
    // rust: if let Some(address) = server {
    // rust: w.next = address;
}
    // rust: w.refresh(|address, lines| {
    // rust: if let Some(address) = address {
    // rust: let shown = horizon_client::net::shown_address(address);
    // rust: lines.push(Line::new(Icon::None, shown, &width));
}
    // rust: });
    // rust: } else {
    // rust: state.server.clear();
}
    // rust: if hud.combo {
    // rust: state.combo_count.next = state.combo.count(now);
    // rust: state.combo_count.refresh(|count, lines| {
    // rust: lines.push(text("horizon.pvp.hud.combo", &[count]));
    // rust: });
    // rust: } else {
    // rust: state.combo_count.clear();
}
    // rust: let cps = if hud.cps || hud.keys {
    // rust: [0, 1].map(|i| state.clicks[i].per_second(now))
    // rust: } else {
    // rust: [0; 2]
}
    // rust: if hud.fps {
    // rust: state.fps.next = fps;
    // rust: state
    // rust: .fps
    // rust: .refresh(|fps, lines| lines.push(text("horizon.pvp.hud.fps", &[fps])));
    // rust: } else {
    // rust: state.fps.clear();
}
    // rust: if hud.cps {
    // rust: state.cps.next = (cps[0], cps[1]);
    // rust: state.cps.refresh(|(l, r), lines| {
    // rust: lines.push(text("horizon.pvp.hud.cps", &[l, r]));
    // rust: });
    // rust: } else {
    // rust: state.cps.clear();
}
    // rust: if hud.keys {
    // rust: state.keys.cps.next = (cps[0], cps[1]);
    // rust: state.keys.cps.refresh(|(l, r), lines| {
    // rust: for n in [l, r] {
    // rust: lines.push(text("horizon.pvp.hud.keys.cps", &[n]));
}
    // rust: });
}
    // rust: if hud.clock {
            // The time is read once a second, not every frame.
    // rust: if now - state.clock_read >= 1.0 || state.clock.lines.is_empty() {
//                 use chrono::Timelike;
    // rust: let t = chrono::Local::now();
    // rust: state.clock.next = (t.hour() as u8, t.minute() as u8);
    // rust: state.clock_read = now;
}
    // rust: state.clock.refresh(|&(h, m), lines| {
    // rust: lines.push(Line::new(Icon::None, pvp_hud::clock(h, m), &width));
    // rust: });
    // rust: } else {
    // rust: state.clock.clear();
}
    // rust: if hud.reach {
    // rust: state.reach_shown.next = state.reach.hundredths(now);
    // rust: state.reach_shown.refresh(|reach, lines| {
    // rust: if let Some(n) = reach {
    // rust: lines.push(text("horizon.pvp.hud.reach", &[&pvp_hud::hundredths(*n)]));
}
    // rust: });
    // rust: } else {
    // rust: state.reach_shown.clear();
}
    // rust: if hud.speed
    // rust: && let Some((x, z)) = position
    // rust: {
    // rust: state.speed_shown.next = state.speed.sample(x, z, now);
    // rust: state.speed_shown.refresh(|n, lines| {
    // rust: lines.push(text("horizon.pvp.hud.speed", &[&pvp_hud::tenths(*n)]));
    // rust: });
    // rust: } else if !hud.speed {
    // rust: state.speed_shown.clear();
}
    // rust: let style = Style {
    // rust: background: hud.background.then(|| hud.background_argb()),
    // rust: text: hud.text.argb(),
    // rust: shadow: hud.shadow,
}
    // rust: let layout = self.settings.extras.pvp.layout;
    // rust: let screen = (batch.width, batch.height);
    // rust: let mut boxes = std::mem::take(&mut self.pvp.boxes);
    // rust: boxes.clear();
    // rust: let p = &self.pvp;
//         use pvp_hud::WidgetId as W;
    // rust: let widgets = [
    // rust: (
    // rust: W::Armour,
    // rust: hud.armour,
    // rust: hud.armour_corner,
    // rust: &p.armour.lines,
    // rust: p.armour.size,
    // rust: ),
    // rust: (
    // rust: W::Effects,
    // rust: hud.effects,
    // rust: hud.effects_corner,
    // rust: &p.effects.lines,
    // rust: p.effects.size,
    // rust: ),
    // rust: (
    // rust: W::Held,
    // rust: hud.held,
    // rust: hud.held_corner,
    // rust: &p.held.lines,
    // rust: p.held.size,
    // rust: ),
    // rust: (
    // rust: W::Ping,
    // rust: hud.ping,
    // rust: hud.ping_corner,
    // rust: &p.ping.lines,
    // rust: p.ping.size,
    // rust: ),
    // rust: (
    // rust: W::Coords,
    // rust: hud.coords,
    // rust: hud.coords_corner,
    // rust: &p.coords.lines,
    // rust: p.coords.size,
    // rust: ),
    // rust: (
    // rust: W::Server,
    // rust: hud.server,
    // rust: hud.server_corner,
    // rust: &p.server.lines,
    // rust: p.server.size,
    // rust: ),
    // rust: (
    // rust: W::Combo,
    // rust: hud.combo,
    // rust: hud.combo_corner,
    // rust: &p.combo_count.lines,
    // rust: p.combo_count.size,
    // rust: ),
    // rust: (W::Fps, hud.fps, hud.fps_corner, &p.fps.lines, p.fps.size),
    // rust: (W::Cps, hud.cps, hud.cps_corner, &p.cps.lines, p.cps.size),
    // rust: (
    // rust: W::Clock,
    // rust: hud.clock,
    // rust: hud.clock_corner,
    // rust: &p.clock.lines,
    // rust: p.clock.size,
    // rust: ),
    // rust: (
    // rust: W::Reach,
    // rust: hud.reach,
    // rust: hud.reach_corner,
    // rust: &p.reach_shown.lines,
    // rust: p.reach_shown.size,
    // rust: ),
    // rust: (
    // rust: W::Speed,
    // rust: hud.speed,
    // rust: hud.speed_corner,
    // rust: &p.speed_shown.lines,
    // rust: p.speed_shown.size,
    // rust: ),
    // rust: ];
        // The editor shows a widget with nothing to show yet by its name.
    // rust: let editing = self.hud_editing();
    // rust: for (id, on, corner, lines, size) in widgets {
    // rust: if !on {
    // rust: continue;
}
    // rust: let stand_in;
    // rust: let (lines, size) = match lines.is_empty() {
    // rust: false => (lines, size),
    // rust: true if editing => {
    // rust: let key = format!("horizon.pvp.hud_{}", id.name());
    // rust: let name = horizon_client::lang::get_or(&key, id.name());
    // rust: let width = |s: &str| HudBatch::text_width(&self.gui.atlas, s);
    // rust: stand_in = vec![Line::new(Icon::None, name, &width)];
    // rust: (&stand_in, pvp_hud::size(&stand_in))
}
    // rust: true => continue,
}
    // rust: let place = layout.get(id);
    // rust: if let Some(rect) = self.widget_rect(corners, place, corner, size, screen) {
    // rust: self.paint_widget(batch, rect, lines, size, &style);
    // rust: boxes.push((id, rect));
}
}
    // rust: if hud.keys {
    // rust: let place = layout.get(W::Keys);
    // rust: let size = pvp_hud::keys_size();
    // rust: if let Some(rect) = self.widget_rect(corners, place, hud.keys_corner, size, screen) {
    // rust: self.paint_keys(batch, rect, &style);
    // rust: boxes.push((W::Keys, rect));
}
}
    // rust: self.pvp.boxes = boxes;
}
    /// Where a widget of `size` goes at its `place`'s scale: where the player put it, else in
    /// its corner (unless a mod hides that corner). `[x, y, w, h]`, scaled.
    // rust: fn widget_rect(
    // rust: &self,
    // rust: corners: &mut Corners,
    // rust: place: pvp_hud::Place,
    // rust: corner: Corner,
    // rust: (w, h): (f32, f32),
    // rust: screen: (f32, f32),
    // rust: ) -> Option<[f32; 4]> {
    // rust: let scale = f32::from(place.scale) / 100.0;
    // rust: let size = (w * scale, h * scale);
    // rust: let (x, y) = match place.at {
    // rust: Some(at) => pvp_hud::from_fractions(at, size, screen),
    // rust: None if self.native_corner_shown(corner) => corners.place(corner, size.0, size.1),
    // rust: None => return None,
}
    // rust: Some([x, y, size.0, size.1])
}
    /// The keystrokes' labels: each key's name, made again only when a binding changed.
pub fn keystroke_labels(self: *Self) void {
}
    // rust: let keys = &self.settings.keys;
    // rust: let k = &mut self.pvp.keys;
    // rust: let same = Key::ALL
    // rust: .iter()
    // rust: .zip(&k.bound)
    // rust: .all(|(key, b)| keys.get(key.mapping()) == b);
    // rust: if same && k.labels.len() == Key::ALL.len() {
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: k.labels.clear();
    // rust: for (i, key) in Key::ALL.into_iter().enumerate() {
    // rust: let bound = keys.get(key.mapping());
    // rust: k.bound[i] = bound.to_owned();
    // rust: let label = match horizon_client::keybinds::mouse_button(bound) {
    // rust: Some(MouseButton::Left) => Text::tr("horizon.pvp.hud.keys.attack", &[]),
    // rust: Some(MouseButton::Right) => Text::tr("horizon.pvp.hud.keys.use", &[]),
    // rust: _ => horizon_client::keybinds::display_name(bound),
}
    // rust: let w = HudBatch::text_width(atlas, &label.plain());
    // rust: k.labels.push((label, w));
}
}
    /// The keystrokes widget at `(x, y)`: a box per key, light while held, its name centred,
    /// and under each mouse button its clicks per second.
pub fn paint_keys(self: *Self, batch: *mut HudBatch, _]: [f32; 4], style: *Style) void {
}
    // rust: let start = batch.vertices.len();
    // rust: let atlas = &self.gui.atlas;
    // rust: let k = &self.pvp.keys;
    // rust: let colour = |c: u32| {
    // rust: let [a, r, g, b] = c.to_be_bytes();
    // rust: rgba(r, g, b, a)
}
    // rust: for (i, key) in Key::ALL.into_iter().enumerate() {
    // rust: let (kx, ky, w, h) = pvp_hud::key_rect(key);
    // rust: let (kx, ky) = (x + kx, y + ky);
    // rust: let held = k.held[i];
    // rust: if held {
    // rust: batch.fill(atlas, kx, ky, w, h, colour(KEY_HELD));
    // rust: } else if let Some(background) = style.background {
    // rust: batch.fill(atlas, kx, ky, w, h, colour(background));
}
    // rust: let text_colour = colour(if held { KEY_HELD_TEXT } else { style.text });
    // rust: let Some((label, lw)) = k.labels.get(i) else {
    // rust: continue;
}
    // rust: let cps = match key {
    // rust: Key::Attack => k.cps.lines.first(),
    // rust: Key::Use => k.cps.lines.get(1),
    // rust: _ => None,
}
    // rust: let top = match cps {
    // rust: Some(_) => ky + 2.0,
    // rust: None => ky + (h - 8.0) / 2.0,
}
    // rust: let shadow = style.shadow && !held;
    // rust: batch.text_styled(atlas, label, kx + (w - lw) / 2.0, top, text_colour, shadow);
    // rust: if let Some(line) = cps {
                // The count at half size under the name.
    // rust: let start = batch.vertices.len();
    // rust: let (cx, cy) = (kx + w / 2.0, ky + h - 6.0);
    // rust: let tx = cx - line.text_width / 2.0;
    // rust: batch.text_styled(atlas, &line.text, tx, cy, text_colour, false);
    // rust: batch.scale_since(start, cx, cy, 0.5, 0.5);
}
}
    // rust: let scale = sw / pvp_hud::keys_size().0;
    // rust: if scale != 1.0 {
    // rust: batch.scale_since(start, x, y, scale, scale);
}
}
    /// The held item count: the first slot holding what is counted, its item, and the total in
    /// the inventory and off hand (arrows for a bow or crossbow). None for a single item.
pub fn held_count(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let held = self.held()?;
    // rust: let ranged = matches!(&*held.item, "minecraft:bow" | "minecraft:crossbow");
    // rust: let counts = |s: &horizon_client::items::ItemStack| match ranged {
    // rust: true => ARROWS.contains(&&*s.item),
    // rust: false => s.item == held.item,
}
    // rust: let slots = self.inventory.iter().map(Option::as_ref).enumerate();
    // rust: let offhand = std::iter::once((super::shield::OFFHAND_SLOT, self.offhand.as_ref()));
    // rust: let mut found = slots
    // rust: .chain(offhand)
    // rust: .filter_map(|(i, s)| Some((i, s?)))
    // rust: .filter(|(_, s)| counts(s));
    // rust: let (first, stack) = found.next()?;
    // rust: let total = stack.count + found.map(|(_, s)| s.count).sum::<u32>();
    // rust: (ranged || total > 1).then(|| (first, stack.item.clone(), total))
}
    /// One widget's box in `corner`: icons in a column, texts beside them.
    // rust: fn paint_widget(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: [x, y, sw, _]: [f32; 4],
    // rust: lines: &[Line],
    // rust: (w, h): (f32, f32),
    // rust: style: &Style,
    // rust: ) {
    // rust: let start = batch.vertices.len();
    // rust: let atlas = &self.gui.atlas;
    // rust: if let Some(background) = style.background {
    // rust: let [a, r, g, b] = background.to_be_bytes();
    // rust: batch.fill(atlas, x, y, w, h, rgba(r, g, b, a));
}
    // rust: let icons = pvp_hud::icon_column(lines);
    // rust: let mut top = y + pvp_hud::PAD;
    // rust: for line in lines {
    // rust: let inner = line.height() - 2.0;
    // rust: let size = line.icon.size();
    // rust: let (ix, iy) = (x + pvp_hud::PAD, top + (inner - size) / 2.0);
    // rust: match &line.icon {
    // rust: Icon::None => {}
    // rust: Icon::Armour(i) => {
    // rust: if let Some(stack) = &self.armor[usize::from(*i)] {
    // rust: self.draw_item(batch, stack, ix, iy);
}
}
    // rust: Icon::Slot(slot) => {
    // rust: if let Some(stack) = self.stack_in(*slot) {
    // rust: self.draw_item_model(batch, stack, ix, iy);
}
}
    // rust: Icon::Sprite(name) => {
    // rust: if let Some(r) = atlas.sprite_or_missing(name) {
    // rust: batch.rect_uv(ix, iy, size, size, r, u32::MAX);
}
}
}
    // rust: let text_h = if line.detail.is_some() { 18.0 } else { 8.0 };
    // rust: let tx = x + pvp_hud::PAD + line.text_x(icons);
    // rust: let ty = top + (inner - text_h) / 2.0;
    // rust: let argb = |c: u32| {
    // rust: let [a, r, g, b] = c.to_be_bytes();
    // rust: rgba(r, g, b, a)
}
            // White lines take the widgets' text colour; durability keeps its own.
    // rust: let colour = match line.colour {
    // rust: 0xFFFF_FFFF => style.text,
    // rust: c => c,
}
    // rust: batch.text_styled(atlas, &line.text, tx, ty, argb(colour), style.shadow);
    // rust: if let Some(detail) = &line.detail {
    // rust: batch.text_styled(atlas, detail, tx, ty + 10.0, argb(DETAIL), style.shadow);
}
    // rust: top += line.height();
}
    // rust: if sw != w {
    // rust: batch.scale_since(start, x, y, sw / w, sw / w);
}
}
}
