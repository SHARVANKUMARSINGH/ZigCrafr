//! Transpiled from Horizon Rust crate
//! Module: horizon-client_stand_up
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Where an entity stands up beside a block: `AbstractBedBlock.findStandUpPosition`
//! and `DismountHelper.findSafeDismountLocation` for any entity type, shared by
//! players (waking up, respawning at a bed or anchor) and villagers waking up.
// use std::collections::{HashMap, HashSet};

// use crate::{
    // rust: blocks::BlockFacts,
    // rust: collisions::{SceneCollisions, no_collision_empty},
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3, VoxelShape, block_floor_height, border::BorderGeometry, trig},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: collision_context::CollisionContext,
    // rust: registry::{BlockRegistry, BlockStateId},
}

/// What `findSafeDismountLocation` reads of an `EntityType`: its
/// dimensions, whether it is the player, and `fireImmune`. No type that
/// stands up from a bed has an `immuneTo` block.
pub const StandUpType = struct {
    width: f32,
    height: f32,
    player: bool,
    fire_immune: bool,
};

    // rust: impl StandUpType {
    /// `EntityTypes.PLAYER`: 0.6 by 1.8.
    // rust: pub const PLAYER: Self = Self {
    // rust: width: 0.6,
    // rust: height: 1.8,
    // rust: player: true,
    // rust: fire_immune: false,
}
    /// `EntityTypes.VILLAGER`: 0.6 by 1.95.
    // rust: pub const VILLAGER: Self = Self {
    // rust: width: 0.6,
    // rust: height: 1.95,
    // rust: player: false,
    // rust: fire_immune: false,
}
}

/// The level as the stand-up search reads it (a `CollisionGetter`).
pub const StandUpLevel = struct {
    world: *'a World,
    registry: *'a BlockRegistry,
    facts: *'a BlockFacts,
    collision: *'a BlockCollisionRegistry<'r>,
    block_tags: *'a HashMap<[]const u8,
    /// The world border; None: none (every box is inside).
    border: ?*'a BorderGeometry,
};

    // rust: impl StandUpLevel<'_, '_> {
pub fn name(self: *Self, p: [i32; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.facts.get(self.world.block(p[0], p[1], p[2])).name
}
pub fn tagged(self: *Self, tag: []const u8, block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_tags.get(tag).is_some_and(|s| s.contains(block))
}
pub fn prop(self: *Self, state: BlockStateId, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get(key))
    // rust: .map(String::as_str)
}
    /// `BlockState.getCollisionShape(level, pos)` under the empty context.
pub fn collision_shape(self: *Self, p: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: self.collision
    // rust: .collision_shape_with_context(
    // rust: &mut scene,
    // rust: self.world.block(p[0], p[1], p[2]),
    // rust: BlockPos::new(p[0], p[1], p[2]),
    // rust: &CollisionContext::empty(false),
    // rust: )
    // rust: .unwrap_or_else(|_| VoxelShape::empty())
}
    /// `DismountHelper.nonClimbableShape`: no shape for climbable blocks
    /// and open trapdoors.
pub fn non_climbable_shape(self: *Self, p: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let name = self.name(p);
    // rust: let open_trapdoor = name.ends_with("_trapdoor") && self.prop(state, "open") == Some("true");
    // rust: if self.tagged("minecraft:climbable", name) || open_trapdoor {
    // rust: return VoxelShape::empty();
}
    // rust: self.collision_shape(p)
}
    /// `EntityType.isBlockDangerous`: `NodeEvaluator.isBurningBlock` unless
    /// fire immune, then the hurting plants and powder snow.
pub fn dangerous(self: *Self, ty: StandUpType, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let name = self.name(p);
    // rust: let burning = self.tagged("minecraft:fire", name)
    // rust: || matches!(
    // rust: name,
    // rust: "minecraft:lava" | "minecraft:magma_block" | "minecraft:lava_cauldron"
    // rust: )
    // rust: || (matches!(name, "minecraft:campfire" | "minecraft:soul_campfire")
    // rust: && self.prop(state, "lit") == Some("true"));
    // rust: (!ty.fire_immune && burning)
    // rust: || matches!(
    // rust: name,
    // rust: "minecraft:wither_rose"
    // rust: | "minecraft:sweet_berry_bush"
    // rust: | "minecraft:cactus"
    // rust: | "minecraft:powder_snow"
    // rust: )
}
    /// `WorldBorder.isWithinBounds(AABB)`: the max corner less `1.0E-5F`.
pub fn within_border(self: *Self, bounds: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(border) = self.border else {
    // rust: return true;
}
    // rust: let inset = f64::from(1.0e-5f32);
    // rust: let (lo_x, lo_z) = (bounds.min(Axis::X), bounds.min(Axis::Z));
    // rust: let (hi_x, hi_z) = (bounds.max(Axis::X) - inset, bounds.max(Axis::Z) - inset);
    // rust: border.is_within_bounds(lo_x, lo_z, 0.0) && border.is_within_bounds(hi_x, hi_z, 0.0)
}
    /// `DismountHelper.findSafeDismountLocation`: standing in `p` on its
    /// floor (or the block below's), with room for the type's box.
    // rust: pub fn safe_dismount_location(
    // rust: &self,
    // rust: ty: StandUpType,
    // rust: p: [i32; 3],
    // rust: check_dangerous: bool,
    // rust: ) -> Option<Vec3> {
    // rust: if check_dangerous && self.dangerous(ty, p) {
    // rust: return None;
}
    // rust: let below = [p[0], p[1] - 1, p[2]];
    // rust: let shape = self.non_climbable_shape(p);
    // rust: let below_shape = self.non_climbable_shape(below);
    // rust: let floor = block_floor_height(&shape, || &below_shape);
        // DismountHelper.isBlockFloorValid.
    // rust: if floor.is_infinite() || floor >= 1.0 {
    // rust: return None;
}
    // rust: if check_dangerous && floor <= 0.0 && self.dangerous(ty, below) {
    // rust: return None;
}
    // rust: let position = Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + floor,
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
        // EntityDimensions.makeBoundingBox: the half width is a float.
    // rust: let half = f64::from(ty.width / 2.0);
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(position.x - half, position.y, position.z - half),
    // rust: Vec3::new(
    // rust: position.x + half,
    // rust: position.y + f64::from(ty.height),
    // rust: position.z + half,
    // rust: ),
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if !no_collision_empty(&mut scene, bounds) {
    // rust: return None;
}
    // rust: let invalid = |q: [i32; 3]| self.tagged("minecraft:invalid_spawn_inside", self.name(q));
    // rust: if ty.player && (invalid(p) || invalid([p[0], p[1] + 1, p[2]])) {
    // rust: return None;
}
    // rust: self.within_border(bounds).then_some(position)
}
    /// `AbstractBedBlock.findStandUpPosition` for a bed whose block is at
    /// `pos`, facing `forward` (a horizontal step), from `yaw`: beside the
    /// bed on the side the sleeper faced away from, around it, then on it;
    /// a safe spot first, else any spot (a bunk bed: around it, a block
    /// lower, then on it).
    // rust: pub fn bed_stand_up(
    // rust: &self,
    // rust: ty: StandUpType,
    // rust: pos: [i32; 3],
    // rust: forward: [i32; 3],
    // rust: yaw: f32,
    // rust: ) -> Option<Vec3> {
        // Direction.getClockWise.
    // rust: let right = [-forward[2], 0, forward[0]];
        // Direction.isFacingAngle.
    // rust: let radians = yaw * 0.017_453_292;
    // rust: let (dx, dz) = (
    // rust: -trig::sin(f64::from(radians)),
    // rust: trig::cos(f64::from(radians)),
    // rust: );
    // rust: let facing = right[0] as f32 * dx + right[2] as f32 * dz > 0.0;
    // rust: let side = if facing {
    // rust: [-right[0], 0, -right[2]]
    // rust: } else {
    // rust: right
}
    // rust: let (f, s) = ([forward[0], forward[2]], [side[0], side[2]]);
        // bedSurroundStandUpOffsets and bedAboveStandUpOffsets.
    // rust: let surround = [
    // rust: [s[0], s[1]],
    // rust: [s[0] - f[0], s[1] - f[1]],
    // rust: [s[0] - f[0] * 2, s[1] - f[1] * 2],
    // rust: [-f[0] * 2, -f[1] * 2],
    // rust: [-s[0] - f[0] * 2, -s[1] - f[1] * 2],
    // rust: [-s[0] - f[0], -s[1] - f[1]],
    // rust: [-s[0], -s[1]],
    // rust: [-s[0] + f[0], -s[1] + f[1]],
    // rust: [f[0], f[1]],
    // rust: [s[0] + f[0], s[1] + f[1]],
    // rust: ];
    // rust: let above = [[0, 0], [-f[0], -f[1]]];
        // findStandUpPositionAtOffset.
    // rust: let at = |base: [i32; 3], offsets: &[[i32; 2]], check: bool| {
    // rust: offsets.iter().find_map(|o| {
    // rust: self.safe_dismount_location(ty, [base[0] + o[0], base[1], base[2] + o[1]], check)
    // rust: })
}
    // rust: let below = [pos[0], pos[1] - 1, pos[2]];
        // isBunkBed: a bed below.
    // rust: if self.name(below).ends_with("_bed") {
    // rust: return at(pos, &surround, true)
    // rust: .or_else(|| at(below, &surround, true))
    // rust: .or_else(|| at(pos, &above, true))
    // rust: .or_else(|| at(pos, &surround, false))
    // rust: .or_else(|| at(below, &surround, false))
    // rust: .or_else(|| at(pos, &above, false));
}
    // rust: let all: Vec<[i32; 2]> = surround.into_iter().chain(above).collect();
    // rust: at(pos, &all, true).or_else(|| at(pos, &all, false))
}
}

/// `LivingEntity.stopSleeping`'s stand-up spot when `findStandUpPosition`
/// finds none: 0.1 above the block over the bed.
pub fn stand_up_fallback(bed: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(
    // rust: f64::from(bed[0]) + 0.5,
    // rust: f64::from(bed[1] + 1) + 0.1,
    // rust: f64::from(bed[2]) + 0.5,
    // rust: )
}

/// A bed's `facing` property as a step (north when unset).
pub fn bed_forward(facing: ?[]const u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: Some("south") => [0, 0, 1],
    // rust: Some("west") => [-1, 0, 0],
    // rust: Some("east") => [1, 0, 0],
    // rust: _ => [0, 0, -1],
}
}
