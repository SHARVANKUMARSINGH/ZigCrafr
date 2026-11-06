//! Transpiled from Horizon Rust crate
package horizon_client_native_client_services

import "core:fmt"
import "core:mem"
import "core:math"

// Client services for trait mods, without exposing `Game` or the atlas.
// use super::Game;
// use horizon_client::{
    // rust: collisions::SceneCollisions,
    // rust: hud::{HudBatch, rgba},
    // rust: hud_layout::GuiDraw,
    // rust: mod_api::Text,
}
// use horizon_core::geometry::Vec3;

// This window's state; unavailable on a server or before a window is attached.
NativeClientState :: struct {
    window_id: u64,
    focused: bool,
    gui_hidden: bool,
    gui_size: [f32,
    server_address: Maybe(string),
    logged_in: bool,
    world_partial_tick: f64,
    eye_position: Option<[f64,
    yaw: f32,
    pitch: f32,
    menu_blur: f32,
}

// A living entity known to the client, before interpolation. No authoritative writes.
NativeClientEntity :: struct {
    id: u32,
    player_uuid: Maybe(u128),
    player_name: Maybe(string),
    position: [f64,
    previous_position: [f64,
    bounds: [[f64,
    height: f32,
    head_yaw: f32,
    head_pitch: f32,
    alive: bool,
    invisible: bool,
}

// A posed model head, relative to its interpolated origin, in block units.
NativeClientHead :: struct {
    id: u32,
    origin: [f64,
    transform: Option<[f32,
    outer_layer_padding: f32,
    height: f32,
    name_anchor: [f64,
    name_half_width: f32,
}

// A player-list profile and the skin the client has ready for GUI faces.
NativeClientProfile :: struct {
    uuid: u128,
    name: string,
    skin: string,
}

    // rust: impl Game<'_> {
    // Client/window/connection state, including when menus cover the world.
    // rust: pub(super) fn native_client_state(&self) -> Option<NativeClientState> {
    // rust: if !self.native_window() {
    // rust: return None;
}
    // rust: let (w, h) = self.gui_size();
    // rust: Some(NativeClientState {
    // rust: window_id: self.window.as_ref()?.id().into(),
    // rust: focused: self.focused,
    // rust: gui_hidden: self.ui.hide_gui,
    // rust: gui_size: [w, h],
    // rust: server_address: self.remote.as_ref().map(|r| r.session.address.clone()),
    // rust: logged_in: self.remote.as_ref().is_some_and(|r| r.logged_in),
    // rust: world_partial_tick: self.clock.fraction(),
    // rust: eye_position: self.eye_position(),
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: menu_blur: self.settings.menu_blur as f32,
    // rust: })
}
    // Bulk client render data. Unlike EntityRef, this snapshot expires independently of handles.
    // rust: pub(super) fn native_client_entities(&self) -> Vec<NativeClientEntity> {
    // rust: if !self.native_window() || self.remote.is_none() {
    // rust: return Vec::new();
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| !m.removed)
    // rust: .map(|m| {
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: NativeClientEntity {
    // rust: id: m.id,
    // rust: player_uuid: self.remote_player_uuid(m.id),
    // rust: player_name: self.remote_player_name(m.id).map(str::to_owned),
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: previous_position: [m.previous.x, m.previous.y, m.previous.z],
    // rust: bounds: [[lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]],
    // rust: height: m.height(),
    // rust: head_yaw: m.head_yaw,
    // rust: head_pitch: m.head_pitch,
    // rust: alive: m.alive(),
    // rust: invisible: m.invisible || m.has_effect("minecraft:invisibility"),
}
    // rust: })
    // rust: .collect()
}
    // Requested model heads at a finite partial tick in 0..=1; at most 4096 IDs.
    // Name bounds are vanilla's, without dispatching name hooks recursively.
    // rust: pub(super) fn native_client_heads(&self, ids: &[u32], partial: f64) -> Vec<NativeClientHead> {
    // rust: if !self.native_window()
    // rust: || !partial.is_finite()
    // rust: || !(0.0..=1.0).contains(&partial)
    // rust: || ids.len() > 4096
    // rust: {
    // rust: return Vec::new();
}
    // rust: let ids: std::collections::HashSet<_> = ids.iter().copied().collect();
    // rust: let key = |p: glam::DVec3| p.to_array().map(f64::to_bits);
    // rust: let widths = if self.ui.hide_gui {
    // rust: Default::default()
    // rust: } else {
    // rust: self.client_name_tag_widths(glam::DVec3::from_array(self.view.position), partial)
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| !m.removed && ids.contains(&m.id))
    // rust: .map(|m| {
    // rust: let p = m.previous.lerp(m.position, partial);
    // rust: let at = glam::DVec3::new(p.x, p.y, p.z);
    // rust: let name_at = super::names::name_tag_at(m, partial);
    // rust: NativeClientHead {
    // rust: id: m.id,
    // rust: origin: at.to_array(),
    // rust: transform: horizon_client::mobs::render::part_transform(
    // rust: m,
    // rust: partial as f32,
    // rust: at,
    // rust: self.res.mob_data(),
    // rust: "head",
    // rust: )
    // rust: .map(|m| m.to_cols_array()),
    // rust: outer_layer_padding: if m.extra.head.is_some() {
    // rust: 1.5 / 16.0
    // rust: } else if m.skin_3d.is_some() {
    // rust: 1.25 / 16.0
    // rust: } else {
    // rust: 0.5 / 16.0
    // rust: },
    // rust: height: m.height(),
    // rust: name_anchor: name_at.to_array(),
    // rust: name_half_width: widths.get(&key(name_at)).copied().unwrap_or(0.0),
}
    // rust: })
    // rust: .collect()
}
    // Player-list profiles with skin/cosmetic resolution through the client's normal cache.
    // rust: pub(super) fn native_client_profiles(&mut self) -> Vec<NativeClientProfile> {
    // rust: if !self.native_window() {
    // rust: return Vec::new();
}
    // rust: let Some((players, _, _)) = self.remote_tab_players() else {
    // rust: return Vec::new();
}
    // rust: players
    // rust: .into_iter()
    // rust: .map(|p| NativeClientProfile {
    // rust: uuid: p.uuid,
    // rust: name: p.name,
    // rust: skin: self.face_skin(p.uuid, &p.skin),
    // rust: })
    // rust: .collect()
}
    // Whether a finite segment of at most 1024 blocks meets no visual block shape.
    // Glass is transparent; partial blocks use their visual shapes. Unloaded paths refuse.
    // rust: pub(super) fn native_client_visual_clear(&self, from: [f64; 3], to: [f64; 3]) -> bool {
    // rust: if !self.native_window()
    // rust: || !from.iter().chain(&to).all(|v| v.is_finite())
    // rust: || from
    // rust: .iter()
    // rust: .zip(to)
    // rust: .map(|(a, b)| (a - b).powi(2))
    // rust: .sum::<f64>()
    // rust: > 1024.0f64.powi(2)
    // rust: {
    // rust: return false;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: horizon_client::mobs::visual_clip(
    // rust: self.res.facts(),
    // rust: self.collision,
    // rust: &mut scene,
    // rust: &|x, y, z| self.world.block(x, y, z),
    // rust: Vec3::new(from[0], from[1], from[2]),
    // rust: Vec3::new(to[0], to[1], to[2]),
    // rust: ) == Some(None)
}
    // Loaded block's full-collision and render-occlusion facts, in that order.
    // rust: pub(super) fn native_client_block_obstruction(&self, pos: [i32; 3]) -> Option<(bool, bool)> {
    // rust: if !self.native_window() || !self.world.loaded(pos[0], pos[2]) {
    // rust: return None;
}
    // rust: let f = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]));
    // rust: Some((f.full_collision, f.can_occlude))
}
    // Paint GUI extraction calls through this window's atlas, including player faces.
    // rust: pub(super) fn native_gui_paint(&self, batch: &mut HudBatch, draws: &[GuiDraw]) {
    // rust: horizon_client::hud_layout::paint(batch, &self.gui.atlas, draws);
}
    // Vanilla's nine-slice widget rendering. `color` is ARGB, as `fill` uses.
    // rust: pub(super) fn native_gui_nine_slice(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: sprite: &str,
    // rust: rect: [f32; 4],
    // rust: color: u32,
    // rust: ) {
    // rust: let [a, r, g, b] = color.to_be_bytes();
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: &self.gui.atlas,
    // rust: sprite,
    // rust: rect[0],
    // rust: rect[1],
    // rust: rect[2],
    // rust: rect[3],
    // rust: rgba(r, g, b, a),
    // rust: );
}
    // A vanilla tooltip at the cursor, in GUI pixels.
    // rust: pub(super) fn native_gui_tooltip(&self, batch: &mut HudBatch, lines: &[Text], at: [f32; 2]) {
    // rust: horizon_client::ui::tooltip(batch, &self.gui.atlas, lines, (at[0], at[1]));
}
    // Save a mod binding, or restore its default with None. No write when unchanged.
    // rust: pub(super) fn native_set_mod_key(
    // rust: &mut self,
    // rust: mod_id: &str,
    // rust: name: &str,
    // rust: key: Option<&str>,
    // rust: ) -> bool {
    // rust: if !self.native_window()
    // rust: || mod_id.is_empty()
    // rust: || name.is_empty()
    // rust: || mod_id.len() > 256
    // rust: || name.len() > 256
    // rust: || key.is_some_and(|k| k.len() > 512)
    // rust: {
    // rust: return false;
}
    // rust: let old = self
    // rust: .settings
    // rust: .mods
    // rust: .keys
    // rust: .get(mod_id)
    // rust: .and_then(|keys| keys.get(name))
    // rust: .map(String::as_str);
    // rust: if old == key {
    // rust: return false;
}
    // rust: if let Some(key) = key {
    // rust: self.settings
    // rust: .mods
    // rust: .keys
    // rust: .entry(mod_id.into())
    // rust: .or_default()
    // rust: .insert(name.into(), key.into());
    // rust: } else if let Some(keys) = self.settings.mods.keys.get_mut(mod_id) {
    // rust: keys.remove(name);
}
    // rust: self.settings.save(&Game::options_path());
    // rust: true
}
    // Set this client's action bar, with the normal timer; no server command or packet.
    // rust: pub(super) fn native_client_action_bar(&mut self, text: Text, animate: bool) {
    // rust: if self.native_window() {
    // rust: self.titles.set_overlay(text, animate);
}
}
}
