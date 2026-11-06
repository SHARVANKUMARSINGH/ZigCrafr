//! Transpiled from Horizon Rust crate
package horizon_world_block_collision

import "core:fmt"
import "core:mem"
import "core:math"

// Cached/dynamic no-context collision queries and explicit contextual block rules.
// Context-sensitive families override the no-context cache explicitly.
// use crate::{
    // rust: block_collision_scan::CollisionBlock,
    // rust: collision::CachedCollisionRegistry,
    // rust: collision_context::CollisionContext,
    // rust: dynamic_support::{DynamicSupport, DynamicSupportError, DynamicSupportWorld},
    // rust: liquid_collision::{LiquidCollision, LiquidCollisionWorld},
    // rust: piston_shape::PistonBlockBindings,
    // rust: powder_snow_collision::{PowderSnowWorld, powder_snow_collision_shape},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::{Aabb, Axis, Direction, Vec3, VoxelShape};
// use std::{collections::HashMap, io, sync::Arc};

ShulkerCollisionState :: struct {
    previous_progress: f32,
    progress: f32,
}
    // rust: impl ShulkerCollisionState {
bounding_box :: proc(self: ^Self, direction: Direction) -> A {
    // Ported from Horizon
    return {}
}
        // Native getProgress(1) retains this interpolation, including rounding.
    // rust: let progress = 0.5f32 * (self.previous_progress + (self.progress - self.previous_progress));
    // rust: let maximum = if progress.is_nan() {
    // rust: progress
    // rust: } else {
    // rust: (-1.0f32).max(progress)
    // rust: } as f64;
    // rust: let minimum = if progress.is_nan() {
    // rust: progress
    // rust: } else {
    // rust: (-1.0f32).min(progress)
    // rust: } as f64;
    // rust: let [x, y, z] = direction.normal();
    // rust: Aabb::new(Vec3::new(-0.5, 0.0, -0.5), Vec3::new(0.5, 1.0, 0.5))
    // rust: .expand_towards(Vec3::new(
    // rust: f64::from(x) * maximum,
    // rust: f64::from(y) * maximum,
    // rust: f64::from(z) * maximum,
    // rust: ))
    // rust: .contract(Vec3::new(
    // rust: f64::from(-x) * (1.0 + minimum),
    // rust: f64::from(-y) * (1.0 + minimum),
    // rust: f64::from(-z) * (1.0 + minimum),
    // rust: ))
    // rust: .move_by(Vec3::new(0.5, 0.0, 0.5))
}
}

    // rust: pub trait DynamicCollisionWorld: DynamicSupportWorld {
    // One block-entity lookup. None denotes absence or another entity type.
    // rust: fn shulker_collision_state(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<ShulkerCollisionState>, Self::Error>;
}

CollisionQueryError :: enum {
    Data(io::Error),
    Dynamic(DynamicSupportError<E>),
    Context(E),
    Unsupported(BlockStateId),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for CollisionQueryError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Data(error) => error.fmt(f),
    // rust: Self::Dynamic(error) => error.fmt(f),
    // rust: Self::Context(error) => error.fmt(f),
    // rust: Self::Unsupported(state) => write!(f, "unsupported block collision state {}", state.0),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for CollisionQueryError<E> {}

BlockCollisionRegistry :: struct {
    cached: ^CachedCollisionRegistry<'r>,
    dynamic: HashMap<BlockStateId,
    contextual: HashMap<BlockStateId,
    scan_flags: [dynamic]u8,
    // Piston and piston-head states for moving-piston collision; None in
    // registries without pistons.
    pistons: Maybe(PistonBlockBindings<'r)>,
}
ContextualRule :: enum {
    Scaffolding(ScaffoldingCollision),
    Liquid(LiquidCollision),
    PowderSnow,
}
    // rust: impl<'r> BlockCollisionRegistry<'r> {
new :: proc(cached: ^CachedCollisionRegistry<'r>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut dynamic = HashMap::new();
    // rust: let mut contextual = HashMap::new();
    // rust: let mut scan_flags = Vec::with_capacity(cached.registry().len());
    // rust: for index in 0..cached.registry().len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let state = cached.registry().state(id).unwrap();
    // rust: let large = cached.cached_shape(id)?.is_none_or(|shape| {
    // rust: Axis::ALL
    // rust: .into_iter()
    // rust: .any(|axis| shape.min(axis) < 0.0 || shape.max(axis) > 1.0)
    // rust: });
    // rust: if let Some(rule) = ScaffoldingCollision::from_state(state)? {
    // rust: contextual.insert(id, ContextualRule::Scaffolding(rule));
    // rust: } else if let Some(rule) = LiquidCollision::from_state(state)? {
    // rust: contextual.insert(id, ContextualRule::Liquid(rule));
    // rust: } else if state.name == "minecraft:powder_snow" {
    // rust: contextual.insert(id, ContextualRule::PowderSnow);
}
            // No contextual rule and an empty cached shape: empty everywhere.
    // rust: let empty = !contextual.contains_key(&id)
    // rust: && cached.cached_shape(id)?.is_some_and(VoxelShape::is_empty);
    // rust: scan_flags.push(
    // rust: u8::from(large)
    // rust: | (u8::from(state.name == "minecraft:moving_piston") << 1)
    // rust: | (u8::from(empty) << 2)
    // rust: | (u8::from(contextual.contains_key(&id)) << 3),
    // rust: );
    // rust: if cached.cached_shape(id)?.is_none() {
    // rust: if let Some(rule) =
    // rust: DynamicSupport::from_state(cached.registry().state(id).unwrap())?
    // rust: {
    // rust: dynamic.insert(id, rule);
}
}
}
    // rust: let pistons = PistonBlockBindings::new(cached.registry()).ok();
    // rust: Ok(Self {
    // rust: cached,
    // rust: dynamic,
    // rust: contextual,
    // rust: scan_flags,
    // rust: pistons,
    // rust: })
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.cached.registry()
}
    // The piston states behind `PistonMovingBlockEntity.getCollisionShape`.
pistons :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.pistons.as_ref()
}
cached_shapes :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.cached
}
    // Immutable cursor-filter metadata, prepared once for this registry.
collision_block :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let flags = *self
    // rust: .scan_flags
    // rust: .get(state.0 as usize)
    // rust: .ok_or_else(|| crate::compression::invalid("collision scan state outside registry"))?;
    // rust: Ok(CollisionBlock {
    // rust: state,
    // rust: large_collision_shape: flags & 1 != 0,
    // rust: moving_piston: flags & 2 != 0,
    // rust: empty_shape: flags & 4 != 0,
    // rust: })
}
    // Whether `state` can have a collision shape: false for states whose shape is always
    // empty, whatever the context. States outside the registry count.
may_collide :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.scan_flags
    // rust: .get(state.0 as usize)
    // rust: .is_none_or(|flags| flags & 4 == 0)
}
    // Whether a scan keeps `state` in the cells around its box: a large
    // collision shape or a moving piston. States outside the registry count.
reaches_out :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.scan_flags
    // rust: .get(state.0 as usize)
    // rust: .is_none_or(|flags| flags & 3 != 0)
}
    // rust: pub fn collision_shape<W: DynamicCollisionWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<VoxelShape, CollisionQueryError<W::Error>> {
    // rust: if let Some(shape) = self
    // rust: .cached
    // rust: .cached_shape(state)
    // rust: .map_err(CollisionQueryError::Data)?
    // rust: {
    // rust: return Ok(shape.clone());
}
    // rust: self.dynamic
    // rust: .get(&state)
    // rust: .ok_or(CollisionQueryError::Unsupported(state))?
    // rust: .collision_shape(world, position)
    // rust: .map_err(CollisionQueryError::Dynamic)
}

    // Ordinary entity/position/placement contexts. The remaining pinned block
    // families share their no-context geometry; the native registry audit checks
    // cached states with rejecting context/world providers before using that path.
    // Experimental minecart position exclusions are a separate context layer.
    // rust: pub fn collision_shape_with_context<W, E>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: horizon_core::position::BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> Result<VoxelShape, CollisionQueryError<E>>
    // rust: where
    // rust: W: DynamicCollisionWorld<Error = E>
    // rust: + LiquidCollisionWorld<Error = E>
    // rust: + PowderSnowWorld<Error = E>,
    // rust: {
        // Most states have no contextual rule: their flag spares the lookup.
    // rust: let contextual = self
    // rust: .scan_flags
    // rust: .get(state.0 as usize)
    // rust: .is_none_or(|flags| flags & 8 != 0);
    // rust: match contextual.then(|| self.contextual.get(&state)).flatten() {
    // rust: Some(ContextualRule::Scaffolding(rule)) => Ok(rule.shape(context, position)),
    // rust: Some(ContextualRule::Liquid(rule)) => rule
    // rust: .shape(world, position, context)
    // rust: .map_err(CollisionQueryError::Context),
    // rust: Some(ContextualRule::PowderSnow) => {
    // rust: powder_snow_collision_shape(world, position, context)
    // rust: .map_err(CollisionQueryError::Context)
}
    // rust: None => self.collision_shape(world, state, [position.x, position.y, position.z]),
}
}
}

// Entity-context scaffold selection, independent of world queries. Construction
// validates the descriptor so missing properties cannot silently change behavior.
ScaffoldingCollision :: struct {
    supported: bool,
    bottom: bool,
}
    // rust: impl ScaffoldingCollision {
from_state :: proc(state: ^crate::chunk::BlockState) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if state.name != "minecraft:scaffolding" {
    // rust: return Ok(None);
}
    // rust: let distance = state
    // rust: .properties
    // rust: .get("distance")
    // rust: .and_then(|v| crate::registry::java_integer(v))
    // rust: .filter(|v| (0..=7).contains(v))
    // rust: .ok_or_else(|| crate::compression::invalid("invalid scaffold distance"))?;
    // rust: let bottom = match state.properties.get("bottom").map(String::as_str) {
    // rust: Some("true") => true,
    // rust: Some("false") => false,
    // rust: _ => return Err(crate::compression::invalid("invalid scaffold bottom")),
}
    // rust: Ok(Some(Self {
    // rust: supported: distance == 0,
    // rust: bottom,
    // rust: }))
}

    // rust: pub fn shape(
    // rust: &self,
    // rust: context: &crate::collision_context::CollisionContext<'_>,
    // rust: position: horizon_core::position::BlockPos,
    // rust: ) -> VoxelShape {
//         use std::sync::OnceLock;
    // rust: if context.is_placement() {
    // rust: return VoxelShape::empty();
}
    // rust: if context.is_above(&VoxelShape::block(), position, true) && !context.is_descending() {
    // rust: return crate::dynamic_support::scaffolding_stable_shape();
}
    // rust: if !self.supported && self.bottom {
BELOW :: OnceLock::new()
    // rust: let below = BELOW.get_or_init(|| {
    // rust: VoxelShape::block()
    // rust: .moved(Vec3::new(0.0, -1.0, 0.0))
    // rust: .optimized()
    // rust: .expect("bounded scaffold below shape")
    // rust: });
    // rust: if context.is_above(below, position, true) {
BOTTOM :: OnceLock::new()
    // rust: return BOTTOM
    // rust: .get_or_init(|| {
    // rust: VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 0.125, 1.0)))
    // rust: .expect("bounded scaffold bottom")
    // rust: })
    // rust: .clone();
}
}
    // rust: VoxelShape::empty()
}
}
