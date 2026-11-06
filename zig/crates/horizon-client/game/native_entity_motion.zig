//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_entity_motion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! An entity's motion and shape for native server mods, through an
//! `EntityRef` (docs/native-mods.md, "Entity and level handles", #7387):
//! velocity, ground, box, eyes and view. They read the entity a handle names
//! as `native_entity_refs.rs` finds it, and return `None` (or `false`) for a
//! stale handle. On a client (API @API:client_entity_refs@) they read the
//! entities the server shows the window, and nothing moves one.
// use super::entity::{Entity as _, EntityHandle, with_entity, with_entity_mut};
// use super::{Game, commands::Target};
// use horizon_client::mod_api::EntityRef;
// use horizon_core::geometry::{Aabb, Axis, Vec3};

pub fn corners(b: Aabb) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let axes = [Axis::X, Axis::Y, Axis::Z];
    // rust: [axes.map(|a| b.min(a)), axes.map(|a| b.max(a))]
}

    // rust: impl Game<'_> {
    /// The simulated entity (one of the shared entity walk's lists) with `id`.
pub fn native_walk_entity(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity_handles()
    // rust: .find(|h| with_entity!(self, *h, e => e.id() == id))
}
    /// This window's own player, when a client's target names it.
pub fn native_client_player(self: *Self, t: Target) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote.as_ref()?;
    // rust: (t == Target::Player).then_some(())?;
    // rust: self.player.as_ref()
}
    /// The server's copy of the player a target names.
pub fn native_target_guest(self: *Self, t: Target) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t {
    // rust: Target::Player => self.command_guest(self.lan_acting?),
    // rust: Target::Guest(conn) => self.command_guest(conn),
    // rust: _ => None,
}
}
    /// The entity's velocity in blocks a tick (`Entity.getDeltaMovement`). A
    /// player's is the move its client last reported (`getKnownMovement`); an
    /// entity Horizon doesn't simulate (a display, a painting) has none, so
    /// zero. On a client, another entity's is the motion the server last
    /// sent it (`Entity.lerpMotion`). API 379.
    // rust: pub(super) fn native_entity_velocity(&self, entity: EntityRef) -> Option<[f64; 3]> {
    // rust: let t = self.native_entity_target(entity)?;
    // rust: if let Some(p) = self.native_client_player(t) {
    // rust: return Some([p.velocity.x, p.velocity.y, p.velocity.z]);
}
    // rust: if let Some(g) = self.native_target_guest(t) {
    // rust: return Some(std::array::from_fn(|i| {
    // rust: g.position[i] - g.previous_position[i]
    // rust: }));
}
    // rust: let v = match self.native_walk_entity(entity.id()) {
    // rust: Some(h) => with_entity!(self, h, e => e.velocity()),
    // rust: None => Vec3::ZERO,
}
    // rust: Some([v.x, v.y, v.z])
}
    /// Sets the entity's velocity (`Entity.setDeltaMovement`); clients see it
    /// as they see the entity move. False for a player (its client moves
    /// it), an entity Horizon doesn't simulate, a value that isn't finite,
    /// or on a client. API 379.
    // rust: pub(super) fn native_entity_set_velocity(
    // rust: &mut self,
    // rust: entity: EntityRef,
    // rust: velocity: [f64; 3],
    // rust: ) -> bool {
    // rust: if self.remote.is_some()
    // rust: || !velocity.iter().all(|v| v.is_finite())
    // rust: || self.native_entity_target(entity).is_none()
    // rust: {
    // rust: return false;
}
    // rust: let Some(h) = self.native_walk_entity(entity.id()) else {
    // rust: return false;
}
    // rust: let [x, y, z] = velocity;
    // rust: with_entity_mut!(self, h, e => *e.velocity_mut() = Vec3::new(x, y, z));
    // rust: if let EntityHandle::Mob(i) = h {
    // rust: self.mobs[i].needs_sync = true;
}
    // rust: true
}
    /// Whether the entity stands on a block (`Entity.onGround`). API
    /// 379.
    // rust: pub(super) fn native_entity_on_ground(&self, entity: EntityRef) -> Option<bool> {
    // rust: let t = self.native_entity_target(entity)?;
    // rust: if let Some(p) = self.native_client_player(t) {
    // rust: return Some(p.ground.on_ground);
}
    // rust: if let Some(g) = self.native_target_guest(t) {
    // rust: return Some(g.on_ground);
}
    // rust: Some(
    // rust: self.native_walk_entity(entity.id())
    // rust: .is_some_and(|h| with_entity!(self, h, e => e.on_ground())),
    // rust: )
}
    /// The entity's box (`Entity.getBoundingBox`): its lowest and highest
    /// corner. None for the kinds whose box Horizon doesn't keep (displays,
    /// markers, End crystals, the dragon). API 379.
    // rust: pub(super) fn native_entity_bounding_box(&self, entity: EntityRef) -> Option<[[f64; 3]; 2]> {
    // rust: let t = self.native_entity_target(entity)?;
    // rust: if let Some(p) = self.native_client_player(t) {
    // rust: return Some(corners(p.bounds()));
}
    // rust: if let Some(g) = self.native_target_guest(t) {
    // rust: return Some(corners(g.bounds()));
}
    // rust: if let Some(h) = self.native_walk_entity(entity.id()) {
    // rust: return Some(corners(with_entity!(self, h, e => e.bounds())));
}
    // rust: let (lo, hi) = match t {
    // rust: Target::Frame(id) => self.item_frames.iter().find(|f| f.id == id)?.bounds(),
    // rust: Target::Painting(id) => self.paintings.iter().find(|p| p.id == id)?.bounds(),
    // rust: _ => return None,
}
    // rust: Some([lo, hi])
}
    /// The height of the entity's eyes above its feet (`Entity.getEyeHeight`).
    /// API 379.
    // rust: pub(super) fn native_entity_eye_height(&self, entity: EntityRef) -> Option<f64> {
    // rust: Some(self.target_eye_height(self.native_entity_target(entity)?))
}
    /// Where the entity's eyes are (`Entity.getEyePosition`). API
    /// 379.
    // rust: pub(super) fn native_entity_eye_position(&self, entity: EntityRef) -> Option<[f64; 3]> {
    // rust: let [x, y, z] = self.native_entity_position(entity)?;
    // rust: Some([x, y + self.native_entity_eye_height(entity)?, z])
}
    /// The unit vector the entity looks along (`Entity.getViewVector`, from
    /// its pitch and yaw). API 379.
    // rust: pub(super) fn native_entity_view_vector(&self, entity: EntityRef) -> Option<[f64; 3]> {
    // rust: let [yaw, pitch] = self.native_entity_rotation(entity)?;
    // rust: let v = horizon_world::view_direction::view_vector(pitch, yaw);
    // rust: Some([v.x, v.y, v.z])
}
    /// The square of the distance from the entity's feet to `pos`
    /// (`Entity.distanceToSqr`). API 379.
    // rust: pub(super) fn native_entity_distance_to_sqr(
    // rust: &self,
    // rust: entity: EntityRef,
    // rust: pos: [f64; 3],
    // rust: ) -> Option<f64> {
    // rust: let p = self.native_entity_position(entity)?;
    // rust: let [dx, dy, dz] = std::array::from_fn(|i| p[i] - pos[i]);
    // rust: Some(dx * dx + dy * dy + dz * dz)
}
}

    // rust: mod tests {
//     use horizon_core::geometry::{Aabb, Vec3};

pub fn corners_are_lowest_then_highest() void {
}
    // rust: let b = Aabb::new(Vec3::new(1.0, 2.0, 3.0), Vec3::new(4.0, 5.0, 6.0));
    // rust: assert_eq!(super::corners(b), [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]);
}
}
