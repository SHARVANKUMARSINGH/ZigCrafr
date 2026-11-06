//! Transpiled from Horizon Rust crate
//! Module: horizon-client_selector_bounds
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The physical bounds already kept for selector targets. This is not a
//! rendered box or a new source of entity dimensions.
// use super::{Game, Target};
// use crate::game::entity::Entity;
// use horizon_core::geometry::{Aabb, Vec3};

pub fn extents() void {
}
    // rust: Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: )
}

/// `EntitySelectorParser.createAabb`, moved by the selector origin.
    // rust: pub(super) fn selector_box(origin: [f64; 3], delta: [f64; 3]) -> Aabb {
    // rust: let lo = std::array::from_fn(|i| origin[i] + delta[i].min(0.0));
    // rust: let hi = std::array::from_fn(|i| origin[i] + (delta[i].max(0.0) + 1.0));
    // rust: extents((lo, hi))
}

    // rust: impl Game<'_> {
    /// `Entity.getBoundingBox`: use each simulated kind's existing physical
    /// box. None means no authoritative box is modeled here yet; the selector
    /// retains its existing point fallback for those kinds.
    // rust: pub(super) fn selector_target_bounds(&self, target: Target) -> Option<Aabb> {
    // rust: match target {
    // rust: Target::Player => self.player.as_ref().map(|p| p.bounds()),
    // rust: Target::Guest(conn) => self.command_guest(conn).map(|p| p.bounds()),
    // rust: Target::Mob(id) => self.mobs.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Item(id) => self.dropped.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Orb(id) => self.orbs.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Projectile(id) => self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|e| e.id == id)
    // rust: .map(Entity::bounds),
    // rust: Target::Stand(id) => self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .find(|e| e.id == id)
    // rust: .map(Entity::bounds),
    // rust: Target::Boat(id) => self.boats.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Cart(id) => self.carts.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Tnt(id) => self.tnts.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Falling(id) => self.falling.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Rocket(id) => self.rockets.iter().find(|e| e.id == id).map(Entity::bounds),
    // rust: Target::Trident(id) => self
    // rust: .tridents
    // rust: .iter()
    // rust: .find(|e| e.id == id)
    // rust: .map(Entity::bounds),
    // rust: Target::Frame(id) => self
    // rust: .item_frames
    // rust: .iter()
    // rust: .find(|e| e.id == id)
    // rust: .map(|e| extents(e.bounds())),
    // rust: Target::Painting(id) => self
    // rust: .paintings
    // rust: .iter()
    // rust: .find(|e| e.id == id)
    // rust: .map(|e| extents(e.bounds())),
    // rust: Target::Crystal(id) => self
    // rust: .crystals
    // rust: .iter()
    // rust: .find(|e| e.id == id)
    // rust: .map(|e| e.bounds()),
    // rust: Target::Other(_)
    // rust: | Target::Fangs(_)
    // rust: | Target::Dragon(_)
    // rust: | Target::Spawner(_)
    // rust: | Target::Cloud(_) => None,
}
}
}
