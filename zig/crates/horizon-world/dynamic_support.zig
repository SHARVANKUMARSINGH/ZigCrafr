//! Transpiled from Horizon Rust crate
//! Module: horizon-world_dynamic_support
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Uncached support-shape selection. Block entities are queried through snapshots;
//! their lifecycle and active moving-piston collision generation are separate.
// use crate::{block_support::SupportType, chunk::BlockState, compression::invalid};
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, ShapeError, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::position_seed,
}
// use std::{io, sync::OnceLock};

    // rust: pub trait DynamicSupportWorld {
    // rust: type Error;
    /// None represents a missing block entity or a different block-entity type.
pub fn shulker_is_closed(self: *Self, position: [i32; 3]) R;
    /// Invoke the active moving-piston entity's collision calculation when it
    /// exists. None represents a missing entity or a different entity type.
    // rust: fn moving_piston_shape(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<VoxelShape>, Self::Error>;
}
pub const DynamicSupportError = enum {
    World(E),
    Shape(ShapeError),
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for DynamicSupportError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Shape(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for DynamicSupportError<E> {}
pub const DynamicSupport = struct {
    kind: Kind,
};
pub const Kind = enum {
    Bamboo,
    Speleothem(usize),
    Scaffolding,
    PowderSnow,
    Shulker(Direction),
    MovingPiston,
};
    // rust: impl DynamicSupport {
    /// Select behavior from a validated registry descriptor. None requests a
    /// different implementation (usually the immutable cached-support branch).
pub fn from_state(state: *BlockState) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let property = |name: &str| {
    // rust: state
    // rust: .properties
    // rust: .get(name)
    // rust: .map(String::as_str)
    // rust: .ok_or_else(|| invalid("missing dynamic support property"))
}
    // rust: let kind = match state.name.as_str() {
    // rust: "minecraft:bamboo" => Kind::Bamboo,
    // rust: "minecraft:pointed_dripstone" | "minecraft:sulfur_spike" => {
    // rust: let down = match property("vertical_direction")? {
    // rust: "down" => true,
    // rust: "up" => false,
    // rust: _ => return Err(invalid("invalid speleothem direction")),
}
    // rust: let shape = match property("thickness")? {
    // rust: "tip_merge" => 0,
    // rust: "tip" => {
    // rust: if down {
    // rust: 2
    // rust: } else {
    // rust: 1
}
}
    // rust: "frustum" => 3,
    // rust: "middle" => 4,
    // rust: "base" => 5,
    // rust: _ => return Err(invalid("invalid speleothem thickness")),
}
    // rust: Kind::Speleothem(shape)
}
    // rust: "minecraft:scaffolding" => Kind::Scaffolding,
    // rust: "minecraft:powder_snow" => Kind::PowderSnow,
    // rust: "minecraft:moving_piston" => Kind::MovingPiston,
    // rust: name if shulker(name) => Kind::Shulker(match property("facing")? {
    // rust: "down" => Direction::Down,
    // rust: "up" => Direction::Up,
    // rust: "north" => Direction::North,
    // rust: "south" => Direction::South,
    // rust: "west" => Direction::West,
    // rust: "east" => Direction::East,
    // rust: _ => return Err(invalid("invalid shulker facing")),
    // rust: }),
    // rust: _ => return Ok(None),
}
    // rust: Ok(Some(Self { kind }))
}
pub fn offset(self: *Self, position: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let maximum = match self.kind {
    // rust: Kind::Bamboo => 0.25f32,
    // rust: Kind::Speleothem(_) => 0.125f32,
    // rust: _ => return Vec3::ZERO,
}
    // rust: let seed = position_seed(BlockPos::new(position[0], 0, position[2]));
    // rust: let component = |shift: u32| {
    // rust: let fraction = ((seed >> shift) & 15i64) as f32 / 15.0f32;
    // rust: ((f64::from(fraction) - 0.5) * 0.5).clamp(-f64::from(maximum), f64::from(maximum))
}
    // rust: Vec3::new(component(0), 0.0, component(8))
}
    // rust: pub fn shape<W: DynamicSupportWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<VoxelShape, DynamicSupportError<W::Error>> {
    // rust: Ok(match self.kind {
    // rust: Kind::Bamboo => {
pub const SHAPE: OnceLock<VoxelShape> = OnceLock::new();
    // rust: SHAPE
    // rust: .get_or_init(|| column(3.0, 0.0, 16.0))
    // rust: .moved(self.offset(position))
}
    // rust: Kind::Speleothem(index) => {
pub const SHAPES: OnceLock<[VoxelShape; 6]> = OnceLock::new();
    // rust: SHAPES.get_or_init(|| {
    // rust: [
    // rust: column(6.0, 0.0, 16.0),
    // rust: column(6.0, 0.0, 11.0),
    // rust: column(6.0, 5.0, 16.0),
    // rust: column(8.0, 0.0, 16.0),
    // rust: column(10.0, 0.0, 16.0),
    // rust: column(12.0, 0.0, 16.0),
    // rust: ]
    // rust: })[index]
    // rust: .moved(self.offset(position))
}
    // rust: Kind::Scaffolding => scaffolding_stable_shape(),
    // rust: Kind::PowderSnow => VoxelShape::empty(),
    // rust: Kind::Shulker(facing) => {
    // rust: if world
    // rust: .shulker_is_closed(position)
    // rust: .map_err(DynamicSupportError::World)?
    // rust: == Some(false)
    // rust: {
pub const SHAPES: OnceLock<[VoxelShape; 6]> = OnceLock::new();
    // rust: SHAPES.get_or_init(|| {
    // rust: Direction::ALL.map(|direction| {
    // rust: let mut min = [0.0; 3];
    // rust: let mut max = [1.0; 3];
    // rust: for (i, n) in direction.normal().into_iter().enumerate() {
    // rust: if n < 0 {
    // rust: max[i] = 0.0625;
    // rust: } else if n > 0 {
    // rust: min[i] = 0.9375;
}
}
    // rust: box_shape(min, max)
    // rust: })
    // rust: })[facing.opposite() as usize]
    // rust: .clone()
    // rust: } else {
    // rust: VoxelShape::block()
}
}
    // rust: Kind::MovingPiston => world
    // rust: .moving_piston_shape(position)
    // rust: .map_err(DynamicSupportError::World)?
    // rust: .unwrap_or_else(VoxelShape::empty),
    // rust: })
}
    // rust: pub fn collision_shape<W: crate::block_collision::DynamicCollisionWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<VoxelShape, DynamicSupportError<W::Error>> {
    // rust: if let Kind::Shulker(direction) = self.kind {
    // rust: return match world
    // rust: .shulker_collision_state(position)
    // rust: .map_err(DynamicSupportError::World)?
    // rust: {
    // rust: Some(snapshot) => VoxelShape::from_box(snapshot.bounding_box(direction))
    // rust: .map_err(DynamicSupportError::Shape),
    // rust: None => Ok(VoxelShape::block()),
}
}
        // Empty collision context uses the stable scaffolding shape, empty
        // powder snow, and the same bamboo/speleothem/piston geometry as support.
    // rust: self.shape(world, position)
}
    // rust: pub fn is_face_sturdy<W: DynamicSupportWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: support: SupportType,
    // rust: ) -> Result<bool, DynamicSupportError<W::Error>> {
    // rust: support
    // rust: .is_supporting(&self.shape(world, position)?, direction)
    // rust: .map_err(DynamicSupportError::Shape)
}
}
/// Shared no-context support and context-selected stable scaffold geometry.
    // rust: pub(crate) fn scaffolding_stable_shape() -> VoxelShape {
pub const SHAPE: OnceLock<VoxelShape> = OnceLock::new();
    // rust: SHAPE
    // rust: .get_or_init(|| {
    // rust: let mut legs = VoxelShape::empty();
    // rust: for [x, z] in [[0.0, 0.0], [0.875, 0.0], [0.875, 0.875], [0.0, 0.875]] {
    // rust: let leg = box_shape([x, 0.0, z], [x + 0.125, 1.0, z + 0.125]);
    // rust: legs = legs.join(&leg, ShapeOp::OR).expect("bounded scaffold legs");
}
    // rust: column(16.0, 14.0, 16.0)
    // rust: .join(&legs, ShapeOp::OR)
    // rust: .expect("bounded scaffold support")
    // rust: })
    // rust: .clone()
}

pub fn box_shape(min: [f64; 3], max: [f64; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(min[0], min[1], min[2]),
    // rust: Vec3::new(max[0], max[1], max[2]),
    // rust: ))
    // rust: .expect("bounded support shape")
}
pub fn column(width: f64, min_y: f64, max_y: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min = (8.0 - width / 2.0) / 16.0;
    // rust: let max = (8.0 + width / 2.0) / 16.0;
    // rust: box_shape([min, min_y / 16.0, min], [max, max_y / 16.0, max])
}
pub fn shulker(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:shulker_box"
    // rust: | "minecraft:white_shulker_box"
    // rust: | "minecraft:orange_shulker_box"
    // rust: | "minecraft:magenta_shulker_box"
    // rust: | "minecraft:light_blue_shulker_box"
    // rust: | "minecraft:yellow_shulker_box"
    // rust: | "minecraft:lime_shulker_box"
    // rust: | "minecraft:pink_shulker_box"
    // rust: | "minecraft:gray_shulker_box"
    // rust: | "minecraft:light_gray_shulker_box"
    // rust: | "minecraft:cyan_shulker_box"
    // rust: | "minecraft:purple_shulker_box"
    // rust: | "minecraft:blue_shulker_box"
    // rust: | "minecraft:brown_shulker_box"
    // rust: | "minecraft:green_shulker_box"
    // rust: | "minecraft:red_shulker_box"
    // rust: | "minecraft:black_shulker_box"
    // rust: )
}
