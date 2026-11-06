//! Transpiled from Horizon Rust crate
//! Module: horizon-client_test_entities
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What the game tests do to the entities and chunks of a test's area:
//! `StructureUtils.clearSpaceForStructure`'s and `GameTestInfo.succeed`'s
//! entity removal, and the force-loaded chunks of
//! `TestInstanceBlockEntity.forceLoadChunks` and `GameTestRunner`'s release.
// use super::Game;
// use horizon_world::worldgen::structure::BoundingBox;

    // rust: type Aabb = ([f64; 3], [f64; 3]);

/// `AABB.of(BoundingBox)`.
    // rust: pub(super) fn aabb_of(b: &BoundingBox) -> Aabb {
    // rust: (b.min.map(f64::from), b.max.map(|v| f64::from(v) + 1.0))
}

/// `AABB.inflate(amount)`.
    // rust: pub(super) fn inflate(b: Aabb, amount: f64) -> Aabb {
    // rust: (b.0.map(|v| v - amount), b.1.map(|v| v + amount))
}

/// The box of an entity of `width` by `height` standing at `p`
/// (`EntityDimensions.makeBoundingBox`).
pub fn standing(p: [f64; 3], width: f64, height: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = width / 2.0;
    // rust: (
    // rust: [p[0] - half, p[1], p[2] - half],
    // rust: [p[0] + half, p[1] + height, p[2] + half],
    // rust: )
}

/// `AABB.intersects(AABB)`: the open boxes overlap.
pub fn intersects(a: Aabb, b: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..3).all(|i| a.0[i] < b.1[i] && a.1[i] > b.0[i])
}

    // rust: impl Game<'_> {
    /// `level.getEntitiesOfClass(Entity.class, bounds, mob -> !(mob instanceof
    /// Player)).forEach(Entity::discard)`: every entity but a player whose box
    /// meets `bounds` is removed without dying or dropping anything.
    // rust: pub(super) fn discard_entities_in(&mut self, bounds: Aabb) {
    // rust: let at = |v: horizon_core::geometry::Vec3| [v.x, v.y, v.z];
    // rust: for m in &mut self.mobs {
    // rust: if !m.removed
    // rust: && intersects(
    // rust: standing(at(m.position), f64::from(m.width()), f64::from(m.height())),
    // rust: bounds,
    // rust: )
    // rust: {
    // rust: m.removed = true;
}
}
        // EntityType.ITEM and EXPERIENCE_ORB.
    // rust: self.dropped
    // rust: .retain(|i| !intersects(standing(at(i.position), 0.25, 0.25), bounds));
    // rust: self.orbs
    // rust: .retain(|o| !intersects(standing(at(o.position), 0.5, 0.5), bounds));
    // rust: self.creatures
    // rust: .projectiles
    // rust: .retain(|p| !intersects(standing(at(p.position), 0.5, 0.5), bounds));
    // rust: self.armor_stands.retain(|a| {
            // ArmorStand.getDimensions: a marker has none, a small one is
            // half scale.
    // rust: let (w, h) = match (a.marker, a.small) {
    // rust: (true, _) => (0.0, 0.0),
    // rust: (_, true) => (0.25, 0.9875),
    // rust: _ => (0.5, 1.975),
}
    // rust: !intersects(standing(at(a.position), w, h), bounds)
    // rust: });
    // rust: self.item_frames.retain(|f| !intersects(f.bounds(), bounds));
    // rust: self.paintings.retain(|p| !intersects(p.bounds(), bounds));
    // rust: let (boat_w, boat_h) = (super::boats::WIDTH, super::boats::HEIGHT);
    // rust: let gone: Vec<u32> = self
    // rust: .boats
    // rust: .iter()
    // rust: .filter(|b| intersects(standing(at(b.position), boat_w, boat_h), bounds))
    // rust: .map(|b| b.id)
    // rust: .collect();
    // rust: for id in gone {
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: let b = self.boats.remove(i);
    // rust: self.boat_removed(&b);
}
}
    // rust: let (cart_w, cart_h) = (super::minecarts::WIDTH, super::minecarts::HEIGHT);
    // rust: self.carts
    // rust: .retain(|c| !intersects(standing(at(c.position), cart_w, cart_h), bounds));
        // EntityType.END_CRYSTAL is 2 by 2.
    // rust: self.crystals
    // rust: .retain(|c| !intersects(standing(at(c.position), 2.0, 2.0), bounds));
        // Entities Horizon does not simulate have no box of their own: the
        // position decides.
    // rust: self.others.retain(|o| {
    // rust: let p = at(o.position);
    // rust: !(0..3).all(|i| p[i] >= bounds.0[i] && p[i] < bounds.1[i])
    // rust: });
}

    /// `ServerLevel.setChunkForced(x, z, true)` for the chunks of `area`
    /// (`TestInstanceBlockEntity.forceLoadChunks`).
    // rust: pub(super) fn force_load_test_chunks(&mut self, area: &BoundingBox) {
    // rust: let (x0, x1) = (area.min[0] >> 4, area.max[0] >> 4);
    // rust: let (z0, z1) = (area.min[2] >> 4, area.max[2] >> 4);
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: self.streaming.forced.insert((x, z));
}
}
    // rust: self.streaming.rank_forced(x0, z0, x1, z1);
}

    /// `GameTestRunner`: every forced chunk of the level is released when a
    /// batch is done or a failure halts the run.
    // rust: pub(super) fn release_forced_chunks(&mut self) {
    // rust: self.streaming.forced.clear();
    // rust: self.levels.release_parked_forced_chunks();
}
}

    // rust: mod tests {
//     use super::*;

pub fn a_boundary_box_covers_its_last_block_and_inflates_both_ways() void {
}
    // rust: let b = BoundingBox::new([0, 1, 2], [3, 4, 5]);
    // rust: assert_eq!(aabb_of(&b), ([0.0, 1.0, 2.0], [4.0, 5.0, 6.0]));
    // rust: assert_eq!(
    // rust: inflate(aabb_of(&b), 1.0),
    // rust: ([-1.0, 0.0, 1.0], [5.0, 6.0, 7.0])
    // rust: );
}

pub fn boxes_that_only_touch_do_not_intersect() void {
}
    // rust: let area = ([0.0; 3], [4.0; 3]);
        // An entity standing on the area's floor, inside it.
    // rust: assert!(intersects(standing([2.0, 0.0, 2.0], 0.6, 1.8), area));
        // Its box ends exactly where the area starts (AABB.intersects is open).
    // rust: assert!(!intersects(standing([-0.3, 0.0, 2.0], 0.6, 1.8), area));
    // rust: assert!(intersects(standing([-0.2, 0.0, 2.0], 0.6, 1.8), area));
        // Above the area.
    // rust: assert!(!intersects(standing([2.0, 4.0, 2.0], 0.6, 1.8), area));
}
}
