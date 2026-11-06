//! Transpiled from Horizon Rust crate
//! Module: horizon-client_interactions
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Server `minecraft:interaction` entities (`Interaction`): invisible boxes a
//! server (Denizen, Nexo) uses for clickable areas. They are pickable, render
//! nothing, and an interact ends at them: `SUCCESS` when they respond (the arm
//! swings), `CONSUME` otherwise (the click still goes to the server, nothing
//! behind them is used).
// use super::{Game, ray_box};
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_protocol::entity_data::Value;

/// `Interaction`'s synced data and box: `DATA_WIDTH` (8), `DATA_HEIGHT` (9)
/// and `DATA_RESPONSE` (10), from its `defineSynchedData`.
    // rust: pub(super) struct RemoteInteraction {
    // rust: pub position: Vec3,
    // rust: pub width: f32,
    // rust: pub height: f32,
    // rust: pub response: bool,
    /// `Entity.getVehicle`: ModelEngine's hitboxes ride the pivot that
    /// carries them.
    // rust: pub vehicle: Option<u32>,
}

    // rust: impl RemoteInteraction {
pub fn new(position: [f64; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: position: Vec3::new(position[0], position[1], position[2]),
    // rust: width: 1.0,
    // rust: height: 1.0,
    // rust: response: false,
    // rust: vehicle: None,
}
}
    /// `Entity.positionRider`'s move: a passenger is placed on its vehicle's
    /// seat, not moved on its own.
pub fn ride_to(self: *Self, at: glam::DVec3) void {
}
    // rust: self.position = Vec3::new(at.x, at.y, at.z);
}
    /// `Interaction.refreshDimensions`: `width` square about the entity's
    /// x and z, from its feet up `height` (its position is the box's bottom
    /// centre, not the model's).
pub fn bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from(self.width) / 2.0;
    // rust: let p = self.position;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(
    // rust: p.x + half,
    // rust: p.y + f64::from(self.height.max(0.0)),
    // rust: p.z + half,
    // rust: ),
    // rust: )
}
pub fn metadata(self: *Self, values: *[(u8) void {
}
    // rust: for (index, _, value) in values {
    // rust: match (index, value) {
    // rust: (8, Value::Float(width)) => self.width = *width,
    // rust: (9, Value::Float(height)) => self.height = *height,
    // rust: (10, Value::Bool(response)) => self.response = *response,
    // rust: _ => {}
}
}
}
}

    // rust: impl Game<'_> {
    /// `Interaction` under the crosshair within the entity reach, as its id
    /// and the hit distance along the view.
    // rust: pub(super) fn interaction_hit(&self) -> Option<(i32, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach = self.entity_reach;
    // rust: self.interactions
    // rust: .iter()
    // rust: .filter_map(|(&id, i)| ray_box(eye, dir, reach, i.bounds()).map(|d| (id, d)))
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
}
    /// An `Interaction` keeps `Entity`'s no-op interpolation handler: the
    /// server's position replaces its own at once.
    // rust: pub(super) fn move_remote_interaction(&mut self, id: i32, position: [f64; 3]) {
    // rust: if let Some(i) = self.interactions.get_mut(&id) {
    // rust: i.position = Vec3::new(position[0], position[1], position[2]);
}
}
    // rust: pub(super) fn remote_interaction_data(&mut self, id: i32, values: &[(u8, i32, Value)]) -> bool {
    // rust: let Some(i) = self.interactions.get_mut(&id) else {
    // rust: return false;
}
    // rust: i.metadata(values);
    // rust: true
}
}

    // rust: mod tests {
//     use super::*;

pub fn the_box_is_centred_on_the_feet_and_grows_with_the_data() void {
}
    // rust: let mut i = RemoteInteraction::new([10.0, 64.0, -3.0]);
    // rust: let b = i.bounds();
    // rust: assert_eq!(
    // rust: (b.min_position().components(), b.max_position().components()),
    // rust: ([9.5, 64.0, -3.5], [10.5, 65.0, -2.5])
    // rust: );
    // rust: i.metadata(&[
    // rust: (8, 0, Value::Float(2.2)),
    // rust: (9, 0, Value::Float(2.2)),
    // rust: (10, 0, Value::Bool(true)),
    // rust: ]);
    // rust: let b = i.bounds();
    // rust: let half = f64::from(2.2f32) / 2.0;
    // rust: let height = f64::from(2.2f32);
    // rust: let (lo, hi) = (b.min_position().components(), b.max_position().components());
    // rust: for (got, want) in lo.iter().zip([10.0 - half, 64.0, -3.0 - half]) {
    // rust: assert!((got - want).abs() < 1e-6, "{lo:?}");
}
    // rust: for (got, want) in hi.iter().zip([10.0 + half, 64.0 + height, -3.0 + half]) {
    // rust: assert!((got - want).abs() < 1e-6, "{hi:?}");
}
    // rust: assert!(i.response);
}
pub fn a_riding_hitbox_moves_with_its_pivot() void {
}
    // rust: let mut i = RemoteInteraction::new([10.0, 64.0, -3.0]);
    // rust: i.vehicle = Some(9);
    // rust: i.ride_to(glam::DVec3::new(12.0, 65.5, -3.0));
    // rust: assert_eq!(i.position, Vec3::new(12.0, 65.5, -3.0));
    // rust: let b = i.bounds();
    // rust: assert_eq!(
    // rust: (b.min_position().components(), b.max_position().components()),
    // rust: ([11.5, 65.5, -3.5], [12.5, 66.5, -2.5])
    // rust: );
}
}
