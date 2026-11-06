//! Transpiled from Horizon Rust crate
//! Module: horizon-client_locator_bar
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The locator bar on this client (horizon_client::locator_bar): the
//! waypoints a server tracks for the player (`handleWaypoint`; on a served
//! world the host's own connection in lan/waypoints.rs), the experience
//! bar's priority after a change, and the dots drawn from the last frame's
//! camera.
// use super::Game;
// use horizon_client::{
    // rust: hud_layout::GuiDraw,
    // rust: locator_bar::{ClientWaypoints, View},
}
// use horizon_protocol::packets::play::TrackedWaypoint;

/// `Player.getEyeHeight` while standing.
pub const PLAYER_EYES: f64 = 1.62;

pub fn uuid(ints: [i32; 4]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ints.iter()
    // rust: .fold(0u128, |acc, &i| acc << 32 | u128::from(i as u32))
}

    // rust: impl Game<'_> {
    /// `ClientPacketListener.handleWaypoint`.
    // rust: pub(super) fn handle_waypoint(&mut self, packet: &TrackedWaypoint) {
    // rust: self.waypoints.apply(packet);
}
    /// A new connection or world starts with no waypoints.
    // rust: pub(super) fn clear_waypoints(&mut self) {
    // rust: self.waypoints = ClientWaypoints::default();
}
    /// `LocalPlayer.setExperienceValues`: a change of progress shows the
    /// experience bar for 100 ticks, except the first one
    /// (`experienceDisplayStartTick` starts at `Integer.MIN_VALUE`).
    // rust: pub(super) fn track_experience_display(&mut self) {
    // rust: let progress = self.experience.progress;
    // rust: let (last, seen, _) = &mut self.experience_display;
    // rust: if progress != *last {
    // rust: *last = progress;
    // rust: if *seen {
    // rust: self.experience_display.2 = self.visual_ticks().max(1);
    // rust: } else {
    // rust: *seen = true;
}
}
        // EnchantmentScreen and AnvilScreen.containerTick keep it up.
    // rust: if self.station.as_ref().is_some_and(|s| {
    // rust: matches!(
    // rust: s.kind,
    // rust: super::stations::Kind::Enchanting | super::stations::Kind::Anvil
    // rust: )
    // rust: }) {
    // rust: self.experience_display.2 = self.visual_ticks().max(1);
}
}
    /// `Hud.willPrioritizeExperienceInfo`. A start of 0 is none: the stamps above are at least 1
    /// (a new world under `HORIZON_STILL` is still at tick 0).
    // rust: pub(super) fn experience_recent(&self) -> bool {
    // rust: let (_, _, start) = self.experience_display;
    // rust: start != 0 && start + 100 > self.visual_ticks()
}
    /// The local player's UUID, as servers know it.
pub fn own_uuid(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.remote {
    // rust: Some(r) => r.profile(),
    // rust: None => self.level.player_uuid.map_or(0, uuid),
}
}
    /// An entity's block position and (interpolated) eyes, by UUID.
pub fn waypoint_entity(self: *Self, id: u128, alpha: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = |p: [f64; 3], q: [f64; 3], eyes: f64| {
    // rust: let pos: [f64; 3] = std::array::from_fn(|i| q[i] + (p[i] - q[i]) * alpha);
    // rust: (p.map(|c| c.floor() as i32), [pos[0], pos[1] + eyes, pos[2]])
}
    // rust: if let Some(r) = &self.remote {
    // rust: let entity = r.player_entity(id)?;
    // rust: let m = self.mobs.iter().find(|m| m.id == entity)?;
    // rust: let v = |v: horizon_core::geometry::Vec3| [v.x, v.y, v.z];
    // rust: return Some(at(v(m.position), v(m.previous), m.eye_height()));
}
    // rust: let host = self.lan.as_ref()?;
    // rust: let g = host.hub.guests.iter().find(|g| g.uuid == id && g.placed)?;
    // rust: Some(at(g.position, g.previous_position, PLAYER_EYES))
}
    /// `LocatorBar.extractRenderState` from the last frame's camera.
    // rust: pub(super) fn locator_bar_draws(&self, gui_width: i32, gui_height: i32) -> Vec<GuiDraw> {
    // rust: let (Some((camera_pos, yaw, pitch, fov)), Some(p)) = (self.locator_camera, &self.player)
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let alpha = self.clock.camera_fraction();
        // Camera.getViewRotationProjectionMatrix, through view space: the
        // depth along the look direction and the height on screen.
    // rust: let (sy, cy) = (
    // rust: f64::from(yaw.to_radians()).sin(),
    // rust: f64::from(yaw.to_radians()).cos(),
    // rust: );
    // rust: let (sp, cp) = (
    // rust: f64::from(pitch.to_radians()).sin(),
    // rust: f64::from(pitch.to_radians()).cos(),
    // rust: );
    // rust: let forward = [-sy * cp, -sp, cy * cp];
    // rust: let up = [-sy * sp, cp, cy * sp];
    // rust: let focal = 1.0 / f64::from((fov / 2.0).to_radians()).tan();
    // rust: let project = |o: [f64; 3]| {
    // rust: let dot = |a: [f64; 3]| a[0] * o[0] + a[1] * o[1] + a[2] * o[2];
    // rust: let depth = dot(forward);
    // rust: let y = dot(up) * focal / depth;
            // Points behind the camera land past the far plane (z > 1).
    // rust: [0.0, y, if depth < 0.0 { 2.0 } else { 0.5 }]
}
    // rust: let entity = |id: u128| self.waypoint_entity(id, alpha);
    // rust: let view = View {
    // rust: gui_width,
    // rust: gui_height,
    // rust: camera_uuid: self.own_uuid(),
    // rust: camera_entity_pos: [p.position.x, p.position.y, p.position.z],
    // rust: camera_pos,
    // rust: yaw,
    // rust: pitch,
    // rust: fov,
    // rust: project: &project,
    // rust: entity: &entity,
    // rust: styles: &self.waypoint_styles,
    // rust: tick: self.visual_ticks(),
}
    // rust: self.waypoints.draw(&view)
}
}
