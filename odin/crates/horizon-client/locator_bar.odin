//! Transpiled from Horizon Rust crate
package horizon_client_locator_bar

import "core:fmt"
import "core:mem"
import "core:math"

// The locator bar: `ClientWaypointManager` (the waypoints the server
// tracks for this player, from `ClientboundTrackedWaypointPacket`),
// `WaypointStyleManager` (`waypoint_style/*.json`: near and far distances
// and the dot sprites between them) and `LocatorBar`, the contextual bar
// that draws a dot per waypoint within 60 degrees of the view, with an
// arrow when it is above or below the screen.
// use crate::hud_layout::{Blend, GuiDraw};
// use horizon_assets::animation::{AnimationClip, AnimationMetadata};
// use horizon_core::geometry::trig;
// use horizon_protocol::packets::play::{
    // rust: TrackedWaypoint, WaypointId, WaypointTarget, waypoint_operation,
}
// use std::{borrow::Cow, collections::HashMap, fs, path::Path};

// `WaypointStyle`: the sprites (under `hud/locator_bar_dot/`) from near to far.
WaypointStyle :: struct {
    near_distance: i32,
    far_distance: i32,
    sprites: [dynamic]string,
}
    // rust: impl WaypointStyle {
    // `WaypointStyleManager.MISSING`.
missing :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: near_distance: 0,
    // rust: far_distance: 1,
    // rust: sprites: vec!["hud/locator_bar_dot/missingno".into()],
}
}
    // `WaypointStyle.CODEC` and `validate`: None when the file is invalid.
parse :: proc(json: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let v: serde_json::Value = serde_json::from_str(json).ok()?;
    // rust: let distance = |key: &str, default: i32| match v.get(key) {
    // rust: None => Some(default),
    // rust: Some(d) => d
    // rust: .as_i64()
    // rust: .filter(|d| (0..=60_000_000).contains(d))
    // rust: .map(|d| d as i32),
}
    // rust: let near_distance = distance("near_distance", 128)?;
    // rust: let far_distance = distance("far_distance", 332)?;
    // rust: let sprites = v
    // rust: .get("sprites")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|s| {
    // rust: let id = s.as_str()?;
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
                // Sprites of the gui atlas are named by path (minecraft only).
    // rust: (namespace == "minecraft").then(|| format!("hud/locator_bar_dot/{path}"))
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: (!sprites.is_empty() && near_distance > 0 && near_distance < far_distance).then_some(Self {
    // rust: near_distance,
    // rust: far_distance,
    // rust: sprites,
    // rust: })
}
    // `WaypointStyle.sprite`.
sprite :: proc(self: ^Self, distance: f32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let (first, last) = (&self.sprites[0], &self.sprites[self.sprites.len() - 1]);
    // rust: if distance < self.near_distance as f32 {
    // rust: return first;
}
    // rust: if distance >= self.far_distance as f32 {
    // rust: return last;
}
    // rust: match self.sprites.len() {
    // rust: 1 => first,
    // rust: 3 => &self.sprites[1],
    // rust: n => {
    // rust: let t = (distance - self.near_distance as f32)
    // rust: / (self.far_distance - self.near_distance) as f32;
                // Mth.lerpInt(t, 1, n - 1).
    // rust: &self.sprites[(1 + (t * (n as f32 - 2.0)).floor() as i32) as usize]
}
}
}
}

// An animated GUI sprite (`.png.mcmeta` animation, ticked with the GUI
// atlas): its image and frame sizes and the frame sequence.
SpriteFrames :: struct {
    image: [i32,
    frame: [i32,
    clip: AnimationClip,
}
    // rust: impl SpriteFrames {
    // None for a still sprite or invalid metadata.
load :: proc(png: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = fs::read_to_string(png.with_extension("png.mcmeta")).ok()?;
    // rust: let meta: HashMap<String, Box<serde_json::value::RawValue>> =
    // rust: serde_json::from_str(&text).ok()?;
    // rust: let animation = AnimationMetadata::from_json(meta.get("animation")?.get()).ok()?;
        // The PNG header: width and height at bytes 16..24 of IHDR.
    // rust: let mut header = [0u8; 24];
    // rust: std::io::Read::read_exact(&mut fs::File::open(png).ok()?, &mut header).ok()?;
    // rust: let dim = |at: usize| i32::from_be_bytes(header[at..at + 4].try_into().unwrap_or_default());
    // rust: let image = [dim(16), dim(20)];
    // rust: let frame = animation.frame_size(image[0], image[1]);
    // rust: if frame[0] <= 0 || frame[1] <= 0 || image[0] % frame[0] != 0 || image[1] % frame[1] != 0 {
    // rust: return None;
}
    // rust: let count = (image[0] / frame[0]) * (image[1] / frame[1]);
    // rust: let clip = animation.clip(count as u32).ok()??;
    // rust: Some(Self { image, frame, clip })
}
    // The `region` (image width, height, u, v) of the frame shown at `tick`.
region :: proc(self: ^Self, tick: u64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let index = self.clip.sample(tick).frame as i32;
    // rust: let columns = self.image[0] / self.frame[0];
    // rust: [
    // rust: self.image[0],
    // rust: self.image[1],
    // rust: index % columns * self.frame[0],
    // rust: index / columns * self.frame[1],
    // rust: ]
}
}

// `WaypointStyleManager`: every `assets/<namespace>/waypoint_style/*.json`,
// plus the animations of the bar's own sprites (the arrows blink).
WaypointStyles :: struct {
    // rust: HashMap<String, WaypointStyle>,
    // rust: HashMap<String, SpriteFrames>,
    // rust: );
    // rust: impl WaypointStyles {
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut frames = HashMap::new();
    // rust: let hud = root.join("assets/minecraft/textures/gui/sprites/hud");
    // rust: let dots = fs::read_dir(hud.join("locator_bar_dot"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path());
    // rust: let arrows = ["locator_bar_arrow_up", "locator_bar_arrow_down"]
    // rust: .map(|a| hud.join(format!("{a}.png")));
    // rust: for png in arrows.into_iter().chain(dots) {
    // rust: if png.extension().is_none_or(|e| e != "png") {
    // rust: continue;
}
    // rust: let Some(f) = SpriteFrames::load(&png) else {
    // rust: continue;
}
    // rust: let name = png
    // rust: .strip_prefix(hud.parent().unwrap_or(&hud))
    // rust: .map(|r| r.with_extension("").to_string_lossy().replace('\\', "/"))
    // rust: .unwrap_or_default();
    // rust: frames.insert(name, f);
}
    // rust: let mut out = HashMap::new();
    // rust: for ns in fs::read_dir(root.join("assets"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: {
    // rust: let namespace = ns.file_name().to_string_lossy().into_owned();
    // rust: for f in fs::read_dir(ns.path().join("waypoint_style"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: {
    // rust: let path = f.path();
    // rust: if path.extension().is_none_or(|e| e != "json") {
    // rust: continue;
}
    // rust: let name = path.file_stem().unwrap_or_default().to_string_lossy();
    // rust: if let Some(style) = fs::read_to_string(&path)
    // rust: .ok()
    // rust: .and_then(|t| WaypointStyle::parse(&t))
    // rust: {
    // rust: out.insert(format!("{namespace}:{name}"), style);
    // rust: } else {
    // rust: log::warn!("Horizon: invalid waypoint style {}", path.display());
}
}
}
    // rust: Self(out, frames)
}
    // The sprite at `tick`, with its animation frame when it has one.
sprite :: proc(self: ^Self, name: string, x: i32, y: i32, w: i32, h: i32, color: u32, tick: u64) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let mut d = sprite(name, x, y, w, h, color);
    // rust: if let (Some(f), GuiDraw::Sprite { region, .. }) = (self.1.get(name), &mut d) {
    // rust: *region = Some(f.region(tick));
}
    // rust: d
}
    // `get`: the style, or the missing one.
get :: proc(self: ^Self, id: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let id = if id.contains(':') {
    // rust: Cow::Borrowed(id)
    // rust: } else {
    // rust: Cow::Owned(format!("minecraft:{id}"))
}
    // rust: self.0
    // rust: .get(&*id)
    // rust: .map_or_else(|| Cow::Owned(WaypointStyle::missing()), Cow::Borrowed)
}
}

// `ClientWaypointManager`: the tracked waypoints by identifier.
ClientWaypoints :: struct {
    waypoints: [dynamic]TrackedWaypoint,
}
    // rust: impl ClientWaypoints {
    // `ClientboundTrackedWaypointPacket.apply`.
apply :: proc(self: ^Self, packet: ^TrackedWaypoint) {
}
    // rust: let at = self.waypoints.iter().position(|w| w.id == packet.id);
    // rust: match packet.operation {
    // rust: waypoint_operation::TRACK => match at {
    // rust: Some(i) => self.waypoints[i] = packet.clone(),
    // rust: None => self.waypoints.push(packet.clone()),
    // rust: },
    // rust: waypoint_operation::UNTRACK => {
    // rust: if let Some(i) = at {
    // rust: self.waypoints.remove(i);
}
}
            // `TrackedWaypoint.update`: only the same kind of waypoint moves.
    // rust: _ => {
    // rust: if let Some(w) = at.map(|i| &mut self.waypoints[i]) {
//                     use WaypointTarget as T;
    // rust: if matches!(
    // rust: (w.target, packet.target),
    // rust: (T::Block(_), T::Block(_))
    // rust: | (T::Chunk(_), T::Chunk(_))
    // rust: | (T::Azimuth(_), T::Azimuth(_))
    // rust: ) {
    // rust: w.target = packet.target;
}
}
}
}
}
has_waypoints :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.waypoints.is_empty()
}
clear :: proc(self: ^Self) {
}
    // rust: self.waypoints.clear();
}
}

// What the locator bar needs of the camera and the world this frame.
View :: struct {
    gui_width: i32,
    gui_height: i32,
    // The camera entity's UUID, its block position and its position.
    camera_uuid: u128,
    camera_entity_pos: [f64,
    // `Camera.position()` and `yRot()`, `xRot()`, `getFov()` in degrees.
    camera_pos: [f64,
    yaw: f32,
    pitch: f32,
    fov: f32,
    // `Camera.getViewRotationProjectionMatrix`, applied to a point
    // relative to the camera: normalised device coordinates.
    project: ^'a dyn Fn([f64,
    // An entity with this UUID in the level: (block position, eye position).
    entity: ^'a dyn Fn(u128) -> Option<([i32,
    styles: ^'a WaypointStyles,
    // Client ticks, for animated sprites.
    tick: u64,
}

// `TrackedWaypoint.PitchDirection`.
Pitch :: enum {
    None,
    Up,
    Down,
}

// `UUID.hashCode`.
uuid_hash :: proc(uuid: u128) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let hilo = (uuid >> 64) as u64 ^ uuid as u64;
    // rust: ((hilo >> 32) as i32) ^ (hilo as i32)
}
// `String.hashCode`.
string_hash :: proc(s: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: s.encode_utf16()
    // rust: .fold(0i32, |h, c| h.wrapping_mul(31).wrapping_add(i32::from(c)))
}

// `ARGB.setBrightness`.
set_brightness :: proc(color: u32, brightness: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let [alpha, r, g, b] = color.to_be_bytes().map(i32::from);
    // rust: let max = r.max(g).max(b);
    // rust: let min = r.min(g).min(b);
    // rust: let range = (max - min) as f32;
    // rust: let saturation = if max != 0 { range / max as f32 } else { 0.0 };
    // rust: let argb =
    // rust: |r: i32, g: i32, b: i32| u32::from_be_bytes([alpha as u8, r as u8, g as u8, b as u8]);
    // rust: let round = |v: f32| (v * 255.0).round() as i32;
    // rust: if saturation == 0.0 {
    // rust: let v = round(brightness);
    // rust: return argb(v, v, v);
}
    // rust: let (cr, cg, cb) = (
    // rust: (max - r) as f32 / range,
    // rust: (max - g) as f32 / range,
    // rust: (max - b) as f32 / range,
    // rust: );
    // rust: let mut hue = if r == max {
    // rust: cb - cg
    // rust: } else if g == max {
    // rust: 2.0 + cr - cb
    // rust: } else {
    // rust: 4.0 + cg - cr
    // rust: } / 6.0;
    // rust: if hue < 0.0 {
    // rust: hue += 1.0;
}
    // rust: let segment = (hue - hue.floor()) * 6.0;
    // rust: let offset = segment - segment.floor();
    // rust: let primary = brightness * (1.0 - saturation);
    // rust: let secondary = brightness * (1.0 - saturation * offset);
    // rust: let tertiary = brightness * (1.0 - saturation * (1.0 - offset));
    // rust: let full = round(brightness);
    // rust: match segment as i32 {
    // rust: 0 => argb(full, round(tertiary), round(primary)),
    // rust: 1 => argb(round(secondary), full, round(primary)),
    // rust: 2 => argb(round(primary), full, round(tertiary)),
    // rust: 3 => argb(round(primary), round(secondary), full),
    // rust: 4 => argb(round(tertiary), round(primary), full),
    // rust: 5 => argb(full, round(primary), round(secondary)),
    // rust: _ => argb(r, g, b),
}
}

// `Mth.wrapDegrees`.
wrap_degrees :: proc(angle: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = angle % 360.0;
    // rust: if a >= 180.0 {
    // rust: a -= 360.0;
}
    // rust: if a < -180.0 {
    // rust: a += 360.0;
}
    // rust: a
}

centre :: proc(v: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: v.map(|c| f64::from(c) + 0.5)
}

    // rust: impl View<'_> {
    // `Vec3iWaypoint.position`: the tracked entity's eyes when it is within
    // 3 blocks (Manhattan) of the waypoint, else the block's centre.
block_position :: proc(self: ^Self, w: ^TrackedWaypoint, v: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if let WaypointId::Uuid(uuid) = w.id
    // rust: && let Some((block, eyes)) = (self.entity)(uuid)
    // rust: {
    // rust: let manhattan: i32 = (0..3).map(|i| (block[i] - v[i]).abs()).sum();
    // rust: if manhattan <= 3 {
    // rust: return eyes;
}
}
    // rust: centre(v)
}
    // `yawAngleToCamera` of a point: `degreesDifference(camera yaw, the
    // angle of camera - point turned clockwise by 90 degrees)`.
yaw_to :: proc(self: ^Self, p: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let c = self.camera_pos;
        // Vec3.rotateClockwise90: (-z, y, x).
    // rust: let (x, z) = (-(c[2] - p[2]), c[0] - p[0]);
    // rust: let angle = trig::atan2(z, x) as f32 * (180.0 / std::f32::consts::PI);
    // rust: f64::from(wrap_degrees(angle - self.yaw))
}
    // `ChunkPos.getMiddleBlockPosition(y)`'s centre.
chunk_middle :: proc(chunk: [i32; 2], y: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: centre([chunk[0] * 16 + 8, y, chunk[1] * 16 + 8])
}
yaw_angle :: proc(self: ^Self, w: ^TrackedWaypoint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match w.target {
    // rust: WaypointTarget::Empty => f64::NAN,
    // rust: WaypointTarget::Block(v) => self.yaw_to(self.block_position(w, v)),
    // rust: WaypointTarget::Chunk(c) => {
    // rust: self.yaw_to(Self::chunk_middle(c, self.camera_pos[1] as i32))
}
    // rust: WaypointTarget::Azimuth(a) => {
    // rust: f64::from(wrap_degrees(a * (180.0 / std::f32::consts::PI) - self.yaw))
}
}
}
    // `GameRenderer.projectHorizonToScreen`.
horizon :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.pitch <= -90.0 {
    // rust: return f64::NEG_INFINITY;
}
    // rust: if self.pitch >= 90.0 {
    // rust: return f64::INFINITY;
}
        // Math.tan of the float products, in double.
    // rust: let rad = std::f32::consts::PI / 180.0;
    // rust: f64::from(self.pitch * rad).tan() / f64::from(self.fov / 2.0 * rad).tan()
}
pitch_direction :: proc(self: ^Self, w: ^TrackedWaypoint) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let by = |y: f64| {
    // rust: if y < -1.0 {
    // rust: Pitch::Down
    // rust: } else if y > 1.0 {
    // rust: Pitch::Up
    // rust: } else {
    // rust: Pitch::None
}
}
    // rust: match w.target {
    // rust: WaypointTarget::Empty => Pitch::None,
    // rust: WaypointTarget::Chunk(_) | WaypointTarget::Azimuth(_) => by(self.horizon()),
    // rust: WaypointTarget::Block(v) => {
    // rust: let p = self.block_position(w, v);
    // rust: let c = self.camera_pos;
    // rust: let s = (self.project)([p[0] - c[0], p[1] - c[1], p[2] - c[2]]);
    // rust: let behind = s[2] > 1.0;
    // rust: match by(if behind { -s[1] } else { s[1] }) {
    // rust: Pitch::None if behind && s[1] > 0.0 => Pitch::Up,
    // rust: Pitch::None if behind && s[1] < 0.0 => Pitch::Down,
    // rust: p => p,
}
}
}
}
    // `distanceSquared` from the camera entity.
distance_sq :: proc(self: ^Self, w: ^TrackedWaypoint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let e = self.camera_entity_pos;
    // rust: let d = |p: [f64; 3]| (0..3).map(|i| (p[i] - e[i]).powi(2)).sum::<f64>();
    // rust: match w.target {
    // rust: WaypointTarget::Block(v) => d(centre(v)),
    // rust: WaypointTarget::Chunk(c) => d(Self::chunk_middle(c, e[1].floor() as i32)),
    // rust: WaypointTarget::Empty | WaypointTarget::Azimuth(_) => f64::INFINITY,
}
}
}

// `LocatorBar.extractBackground`: the nine-sliced sprite and its rectangle.
background :: proc(gui_width: i32, gui_height: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: "gui/sprites/hud/locator_bar_background",
    // rust: [gui_width / 2 - 91, gui_height - 32 + 3, 182, 5],
    // rust: )
}

sprite :: proc(name: string, x: i32, y: i32, w: i32, h: i32, color: u32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GuiDraw::Sprite {
    // rust: sprite: Cow::Owned(name.to_owned()),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: region: None,
    // rust: color,
    // rust: blend: Blend::Textured,
}
}

    // rust: impl ClientWaypoints {
    // `LocatorBar.extractRenderState`: the farthest waypoint first.
draw :: proc(self: ^Self, view: ^View) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let top = view.gui_height - 32 + 3;
    // rust: let mut sorted: Vec<(f64, &TrackedWaypoint)> = self
    // rust: .waypoints
    // rust: .iter()
    // rust: .map(|w| (view.distance_sq(w), w))
    // rust: .collect();
    // rust: sorted.sort_by(|a, b| b.0.total_cmp(&a.0));
    // rust: let mut out = Vec::new();
    // rust: for (distance_sq, w) in sorted {
    // rust: if w.id == WaypointId::Uuid(view.camera_uuid) {
    // rust: continue;
}
    // rust: let angle = view.yaw_angle(w);
            // `!(angle <= -60) && !(angle > 60)`: NaN draws, at the centre.
    // rust: if angle <= -60.0 || angle > 60.0 {
    // rust: continue;
}
    // rust: let middle = ((view.gui_width - 9) as f32 / 2.0).ceil() as i32;
    // rust: let style = view.styles.get(&w.style);
    // rust: let distance = (distance_sq as f32).sqrt();
    // rust: let color = w.color.map_or_else(
    // rust: || {
    // rust: let hash = match &w.id {
    // rust: WaypointId::Uuid(u) => uuid_hash(*u),
    // rust: WaypointId::Name(n) => string_hash(n),
}
    // rust: set_brightness(0xFF00_0000 | hash as u32, 0.9)
    // rust: },
    // rust: |c| c as u32,
    // rust: );
    // rust: let dot = (angle * 173.0 / 2.0 / 60.0).floor() as i32;
    // rust: out.push(view.styles.sprite(
    // rust: style.sprite(distance),
    // rust: middle + dot,
    // rust: top - 2,
    // rust: 9,
    // rust: 9,
    // rust: color,
    // rust: view.tick,
    // rust: ));
    // rust: let arrow = match view.pitch_direction(w) {
    // rust: Pitch::None => continue,
    // rust: Pitch::Down => (6, "hud/locator_bar_arrow_down"),
    // rust: Pitch::Up => (-6, "hud/locator_bar_arrow_up"),
}
    // rust: out.push(view.styles.sprite(
    // rust: arrow.1,
    // rust: middle + dot + 1,
    // rust: top + arrow.0,
    // rust: 7,
    // rust: 5,
    // rust: u32::MAX,
    // rust: view.tick,
    // rust: ));
}
    // rust: out
}
}

// `Hud.ContextualInfo`: which bar sits above the hotbar.
ContextualBar :: enum {
    Empty,
    Experience,
    Locator,
    JumpableVehicle,
}
    // rust: impl ContextualBar {
    // `Hud.nextContextualInfoState`: `recent_experience` is
    // `willPrioritizeExperienceInfo` (experience changed in the last 100
    // ticks), `jumping` is `willPrioritizeJumpInfo`.
    // rust: pub fn next(
    // rust: waypoints: bool,
    // rust: jumpable_vehicle: bool,
    // rust: jumping: bool,
    // rust: has_experience: bool,
    // rust: recent_experience: bool,
    // rust: ) -> Self {
    // rust: if waypoints {
    // rust: if jumpable_vehicle && jumping {
    // rust: Self::JumpableVehicle
    // rust: } else if has_experience && recent_experience {
    // rust: Self::Experience
    // rust: } else {
    // rust: Self::Locator
}
    // rust: } else if jumpable_vehicle {
    // rust: Self::JumpableVehicle
    // rust: } else if has_experience {
    // rust: Self::Experience
    // rust: } else {
    // rust: Self::Empty
}
}
}

    // rust: mod tests {
//     use super::*;

tracked :: proc(operation: i32, id: u128, target: WaypointTarget) -> T {
    // Ported from Horizon
    return {}
}
    // rust: TrackedWaypoint {
    // rust: operation,
    // rust: id: WaypointId::Uuid(id),
    // rust: style: "minecraft:default".into(),
    // rust: color: None,
    // rust: target,
}
}

styles_pick_sprites_by_distance :: proc() {
}
    // rust: let default = WaypointStyle::parse(
    // rust: r#"{"sprites":["minecraft:default_0","minecraft:default_1","minecraft:default_2","minecraft:default_3"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!((default.near_distance, default.far_distance), (128, 332));
    // rust: assert_eq!(default.sprite(10.0), "hud/locator_bar_dot/default_0");
    // rust: assert_eq!(default.sprite(128.0), "hud/locator_bar_dot/default_1");
        // lerpInt((d - 128) / 204, 1, 3): halfway is the third sprite.
    // rust: assert_eq!(default.sprite(229.0), "hud/locator_bar_dot/default_1");
    // rust: assert_eq!(default.sprite(230.0), "hud/locator_bar_dot/default_2");
    // rust: assert_eq!(default.sprite(332.0), "hud/locator_bar_dot/default_3");
    // rust: let bowtie = WaypointStyle::parse(
    // rust: r#"{"near_distance":64,"sprites":["minecraft:bowtie","minecraft:default_0","minecraft:default_1","minecraft:default_2","minecraft:default_3"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(bowtie.sprite(63.0), "hud/locator_bar_dot/bowtie");
        // lerpInt((d - 64) / 268, 1, 4).
    // rust: assert_eq!(bowtie.sprite(64.0), "hud/locator_bar_dot/default_0");
    // rust: assert_eq!(bowtie.sprite(200.0), "hud/locator_bar_dot/default_1");
    // rust: assert_eq!(bowtie.sprite(300.0), "hud/locator_bar_dot/default_2");
        // Three sprites: the middle one between near and far.
    // rust: let three = WaypointStyle::parse(r#"{"sprites":["a","b","c"]}"#).unwrap();
    // rust: assert_eq!(three.sprite(200.0), "hud/locator_bar_dot/b");
        // validate: sprites, near > 0, far > near.
    // rust: assert!(WaypointStyle::parse(r#"{"sprites":[]}"#).is_none());
    // rust: assert!(WaypointStyle::parse(r#"{"near_distance":0,"sprites":["a"]}"#).is_none());
    // rust: assert!(WaypointStyle::parse(r#"{"near_distance":400,"sprites":["a"]}"#).is_none());
    // rust: assert_eq!(
    // rust: WaypointStyles::default().get("minecraft:none").sprite(5.0),
    // rust: "hud/locator_bar_dot/missingno"
    // rust: );
}

packets_track_update_and_untrack :: proc() {
}
    // rust: let mut w = ClientWaypoints::default();
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::TRACK,
    // rust: 1,
    // rust: WaypointTarget::Block([1, 2, 3]),
    // rust: ));
    // rust: assert!(w.has_waypoints());
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::UPDATE,
    // rust: 1,
    // rust: WaypointTarget::Block([4, 5, 6]),
    // rust: ));
    // rust: assert_eq!(w.waypoints[0].target, WaypointTarget::Block([4, 5, 6]));
        // Another kind of waypoint doesn't update it.
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::UPDATE,
    // rust: 1,
    // rust: WaypointTarget::Azimuth(1.0),
    // rust: ));
    // rust: assert_eq!(w.waypoints[0].target, WaypointTarget::Block([4, 5, 6]));
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::UNTRACK,
    // rust: 1,
    // rust: WaypointTarget::Empty,
    // rust: ));
    // rust: assert!(!w.has_waypoints());
}

brightness_like_argb :: proc() {
}
        // Pure red at 0.9: Math.round(0.9 * 255) = 230.
    // rust: assert_eq!(set_brightness(0xFFFF_0000, 0.9), 0xFFE6_0000);
    // rust: assert_eq!(set_brightness(0xFF80_8080, 0.9), 0xFFE6_E6E6);
    // rust: assert_eq!(uuid_hash(0x0000_0001_0000_0000_0000_0000_0000_0002), 3);
    // rust: assert_eq!(string_hash("ab"), 97 * 31 + 98);
}

arrows_blink_through_their_frames :: proc() {
}
        // locator_bar_arrow_up.png.mcmeta: 7x10, two 5-pixel frames.
    // rust: let meta = r#"{"frames":[{"index":0,"time":10},{"index":1,"time":4}],"height":5}"#;
    // rust: let animation = AnimationMetadata::from_json(meta).unwrap();
    // rust: let frames = SpriteFrames {
    // rust: image: [7, 10],
    // rust: frame: animation.frame_size(7, 10),
    // rust: clip: animation.clip(2).unwrap().unwrap(),
}
    // rust: assert_eq!(frames.region(0), [7, 10, 0, 0]);
    // rust: assert_eq!(frames.region(9), [7, 10, 0, 0]);
    // rust: assert_eq!(frames.region(10), [7, 10, 0, 5]);
    // rust: assert_eq!(frames.region(14), [7, 10, 0, 0]);
}

dots_sit_on_the_bar_by_angle :: proc() {
}
    // rust: let styles = WaypointStyles(
    // rust: [(
    // rust: "minecraft:default".to_owned(),
    // rust: WaypointStyle {
    // rust: near_distance: 128,
    // rust: far_distance: 332,
    // rust: sprites: vec!["hud/locator_bar_dot/default_0".into()],
    // rust: },
    // rust: )]
    // rust: .into(),
    // rust: HashMap::new(),
    // rust: );
    // rust: let project = |p: [f64; 3]| [p[0], p[1], 0.5];
    // rust: let entity = |_: u128| None;
    // rust: let view = View {
    // rust: gui_width: 427,
    // rust: gui_height: 240,
    // rust: camera_uuid: 9,
    // rust: camera_entity_pos: [0.5, 64.0, 0.5],
    // rust: camera_pos: [0.5, 65.62, 0.5],
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: fov: 70.0,
    // rust: project: &project,
    // rust: entity: &entity,
    // rust: styles: &styles,
    // rust: tick: 0,
}
    // rust: let mut w = ClientWaypoints::default();
        // Yaw 0 looks towards +z: a waypoint straight ahead sits in the middle.
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::TRACK,
    // rust: 1,
    // rust: WaypointTarget::Block([0, 65, 40]),
    // rust: ));
        // One behind the camera and the camera's own waypoint are not drawn.
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::TRACK,
    // rust: 2,
    // rust: WaypointTarget::Block([0, 65, -40]),
    // rust: ));
    // rust: w.apply(&tracked(
    // rust: waypoint_operation::TRACK,
    // rust: 9,
    // rust: WaypointTarget::Block([0, 65, 40]),
    // rust: ));
    // rust: let draws = w.draw(&view);
    // rust: assert_eq!(draws.len(), 1);
    // rust: let GuiDraw::Sprite { x, y, .. } = draws[0] else {
    // rust: panic!("{draws:?}");
}
    // rust: assert_eq!((x, y), (209, 209));
        // 30 degrees to the right: floor(30 * 173 / 120) = 43 pixels.
    // rust: let east = ClientWaypoints {
    // rust: waypoints: vec![tracked(
    // rust: waypoint_operation::TRACK,
    // rust: 3,
    // rust: WaypointTarget::Azimuth(30f32.to_radians()),
    // rust: )],
}
    // rust: let GuiDraw::Sprite { x, .. } = east.draw(&view)[0] else {
    // rust: panic!();
}
    // rust: assert_eq!(x, 209 + 43);
}

contextual_bar_priorities :: proc() {
}
//         use ContextualBar as B;
    // rust: assert_eq!(B::next(true, false, false, true, false), B::Locator);
    // rust: assert_eq!(B::next(true, false, false, true, true), B::Experience);
    // rust: assert_eq!(B::next(true, true, true, true, true), B::JumpableVehicle);
    // rust: assert_eq!(B::next(false, false, false, true, true), B::Experience);
    // rust: assert_eq!(B::next(false, false, false, false, false), B::Empty);
        // Creative players see the bar too.
    // rust: assert_eq!(B::next(true, false, false, false, false), B::Locator);
}
}
