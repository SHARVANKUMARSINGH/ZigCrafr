//! Transpiled from Horizon Rust crate
package horizon_client_render_collisions

import "core:fmt"
import "core:mem"
import "core:math"

// Collision queries against the same resident chunks used by the renderer.
// The development scene has no entities, block entities or world border.
// Entity-dependent rules use the defaults for players and the supported mobs.
// use crate::{Result, world::World};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape, border::BorderGeometry},
    // rust: position::{BlockPos, ChunkPos},
}
// use horizon_world::{
    // rust: block_collision::{BlockCollisionRegistry, DynamicCollisionWorld, ShulkerCollisionState},
    // rust: block_collision_scan::{BlockCollisionWorld, CollisionBlock},
    // rust: collision::CachedCollisionRegistry,
    // rust: collision_context::{CollisionContext, CollisionEntity, CollisionItem},
    // rust: dynamic_support::DynamicSupportWorld,
    // rust: entity_obstruction::EntityIdentity,
    // rust: fluid::{FluidKind, FluidState},
    // rust: liquid_collision::LiquidCollisionWorld,
    // rust: piston_shape::PistonCollisionWorld,
    // rust: powder_snow_collision::{PowderSnowEntity, PowderSnowWorld},
    // rust: registry::{BlockRegistry, BlockStateId, BlockTableFile},
    // rust: world_movement::{
    // rust: CollisionCheckRequest, EntityMovementWorld, MovementRequest, no_world_collision,
    // rust: resolve_world_movement,
    // rust: },
}
// use std::{io, path::Path, sync::Arc};

    // rust: pub fn load<'r>(root: &Path, registry: &'r BlockRegistry) -> Result<BlockCollisionRegistry<'r>> {
    // rust: let file = BlockTableFile::open(&root.join("cached-collision.nbt"), registry)?;
    // rust: let cached = CachedCollisionRegistry::from_table(file.table("collision")?)?;
    // rust: if !cached.has_canonical_identities() {
    // rust: return Err("scene collisions require canonical shape identities".into());
}
    // rust: Ok(BlockCollisionRegistry::new(Arc::new(cached))?)
}

// What powder snow's and liquids' contextual collisions ask of the colliding
// entity (`PowderSnowBlock` and `LiquidBlock.getCollisionShape`).
PowderSnowSubject :: struct {
    fall_distance: f64,
    // `FallingBlockEntity`.
    falling_block: bool,
    // A living entity with leather boots on its feet.
    leather_boots: bool,
    // `EntityTypeTags.POWDER_SNOW_WALKABLE_MOBS`.
    walkable_type: bool,
    // A strider: lava sources hold it up (`canStandOnFluid`), on its
    // `getLiquidCollisionShape`.
    lava_walker: bool,
}
// `Strider.getLiquidCollisionShape`: `Block.column(16.0, 0.0, 8.0)`.
strider_liquid_shape :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: VoxelShape::from_cube([1, 2, 1], &[true, false]).expect("a valid half-block column")
}

// Vanilla scopes this direction to Entity.move while a piston pushes it.
    // rust: thread_local! {
PISTON_NOCLIP :: const { std::cell::Cell::new(None) }
}

// Suppress the moving part of pistons moving in this direction during a push.
    // rust: pub fn with_piston_noclip<T>(
    // rust: direction: horizon_core::geometry::Direction,
    // rust: f: impl FnOnce() -> T,
    // rust: ) -> T {
Reset :: struct {
    // rust: impl Drop for Reset {
drop :: proc(self: ^Self) {
}
    // rust: PISTON_NOCLIP.with(|value| value.set(self.0));
}
}
    // rust: let previous = PISTON_NOCLIP.with(|value| value.replace(Some(direction)));
    // rust: let _reset = Reset(previous);
    // rust: f()
}

SceneCollisions :: struct {
    world: ^'w World,
    binding: ^'w BlockCollisionRegistry<'r>,
    // The entity colliding, for powder snow; None: no fall, no boots.
    subject: Maybe(PowderSnowSubject),
}
// Already selected entity boxes alongside the resident block collision world.
EntityCollisions :: struct {
    blocks: W,
    entities: ^'a [Aabb],
    // The world border and the moving entity's x and z
    // (`CollisionGetter.borderCollision`); None: the blocks' answer.
    border: Option<(^'a BorderGeometry,
}
    // rust: impl<W: BlockCollisionWorld> BlockCollisionWorld for EntityCollisions<'_, W> {
    // rust: type Error = W::Error;
    // rust: type Chunk = W::Chunk;
    // rust: fn collision_chunk(
    // rust: &mut self,
    // rust: p: ChunkPos,
    // rust: ) -> std::result::Result<Option<Self::Chunk>, Self::Error> {
    // rust: self.blocks.collision_chunk(p)
}
    // rust: fn collision_block(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: p: BlockPos,
    // rust: ) -> std::result::Result<CollisionBlock, Self::Error> {
    // rust: self.blocks.collision_block(chunk, p)
}
    // rust: fn is_suffocating(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: block: CollisionBlock,
    // rust: p: BlockPos,
    // rust: ) -> std::result::Result<bool, Self::Error> {
    // rust: self.blocks.is_suffocating(chunk, block, p)
}
    // rust: fn may_reach_out(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: section_y: i32,
    // rust: ) -> std::result::Result<bool, Self::Error> {
    // rust: self.blocks.may_reach_out(chunk, section_y)
}
    // rust: fn section_is_empty(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: section_y: i32,
    // rust: ) -> std::result::Result<bool, Self::Error> {
    // rust: self.blocks.section_is_empty(chunk, section_y)
}
missing_chunks_stay_missing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.missing_chunks_stay_missing()
}
    // rust: fn context_shape(
    // rust: &mut self,
    // rust: block: CollisionBlock,
    // rust: p: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> std::result::Result<VoxelShape, Self::Error> {
    // rust: self.blocks.context_shape(block, p, context)
}
}
    // rust: impl<W: EntityMovementWorld<Error = io::Error>> EntityMovementWorld for EntityCollisions<'_, W> {
    // rust: type Error = io::Error;
    // rust: fn entity_collisions(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: bounds: Aabb,
    // rust: ) -> io::Result<Vec<VoxelShape>> {
    // rust: let mut shapes = self.blocks.entity_collisions(entity, bounds)?;
    // rust: for &aabb in self.entities {
            // EntityGetter.getEntityCollisions expands its entity query by 1e-7.
    // rust: if aabb.intersects(bounds.inflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7))) {
    // rust: shapes.push(VoxelShape::from_box(aabb).map_err(io::Error::other)?);
}
}
    // rust: Ok(shapes)
}
    // `WorldBorder.isInsideCloseToBorder`: an entity inside the border and
    // near it collides with its walls.
    // rust: fn movement_border(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: bounds: Aabb,
    // rust: ) -> io::Result<Option<VoxelShape>> {
    // rust: let Some((border, [x, z])) = self.border else {
    // rust: return self.blocks.movement_border(entity, bounds);
}
    // rust: if !border.is_inside_close_to_border(x, z, bounds) {
    // rust: return Ok(None);
}
    // rust: border.collision_shape().map(Some).map_err(io::Error::other)
}
}
    // rust: impl<'a, W> EntityCollisions<'a, W>
    // rust: where
    // rust: W: BlockCollisionWorld<Error = io::Error> + EntityMovementWorld<Error = io::Error>,
    // rust: {
    // `EntityCollisions` for a body the world border also stops: the border
    // and the body's own x and z (`WorldBorder.isInsideCloseToBorder`).
with_border :: proc(blocks: W, border: ^'a BorderGeometry, at: [f64; 2]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: blocks,
    // rust: entities: &[],
    // rust: border: Some((border, at)),
}
}
    // `SceneCollisions::resolve` that also stops at the entity boxes and,
    // with a border, at the world border's walls.
    // rust: pub fn resolve(
    // rust: &mut self,
    // rust: bounds: Aabb,
    // rust: movement: Vec3,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: ) -> Result<Vec3> {
    // rust: let context = CollisionContext::position(bounds.min_position().y);
    // rust: self.resolve_with_context(bounds, movement, max_step, on_ground, context)
}
    // [`Self::resolve`] with the entity's captured collision context.
    // rust: pub fn resolve_with_context(
    // rust: &mut self,
    // rust: bounds: Aabb,
    // rust: movement: Vec3,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: context: CollisionContext<'_>,
    // rust: ) -> Result<Vec3> {
    // rust: Ok(resolve_world_movement(
    // rust: self,
    // rust: MovementRequest {
    // rust: entity: EntityIdentity(0),
    // rust: context,
    // rust: bounds,
    // rust: movement,
    // rust: max_step,
    // rust: on_ground,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )?)
}
}
    // rust: impl SceneCollisions<'_, '_> {
    // Position contexts permit geometric movement probes without inventing a
    // player, inventory, effects or fluid-standing behavior; a lava walker or
    // a living entity in leather boots collides as the living entity it is,
    // empty-handed.
    // rust: pub fn resolve(
    // rust: &mut self,
    // rust: bounds: Aabb,
    // rust: movement: Vec3,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: ) -> Result<Vec3> {
    // rust: self.resolve_with_context(bounds, movement, max_step, on_ground, self.context(bounds))
}
    // [`Self::resolve`], also stopped by the world border's walls when one is
    // given with the moving entity's x and z: `Entity.collectColliders` adds
    // `WorldBorder.getCollisionShape` for any entity inside and close to it.
    // rust: pub fn resolve_in_border(
    // rust: self,
    // rust: bounds: Aabb,
    // rust: movement: Vec3,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: border: Option<(&BorderGeometry, [f64; 2])>,
    // rust: ) -> Result<Vec3> {
    // rust: let context = self.context(bounds);
    // rust: EntityCollisions {
    // rust: blocks: self,
    // rust: entities: &[],
    // rust: border,
}
    // rust: .resolve_with_context(bounds, movement, max_step, on_ground, context)
}
    // Resolve movement with the entity's captured collision context. Most
    // callers only need the position context; entities such as falling blocks
    // also affect contextual block shapes (for example powder snow).
    // rust: pub fn resolve_with_context(
    // rust: &mut self,
    // rust: bounds: Aabb,
    // rust: movement: Vec3,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: context: CollisionContext<'_>,
    // rust: ) -> Result<Vec3> {
    // rust: Ok(resolve_world_movement(
    // rust: self,
    // rust: MovementRequest {
    // rust: entity: EntityIdentity(0),
    // rust: context,
    // rust: bounds,
    // rust: movement,
    // rust: max_step,
    // rust: on_ground,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )?)
}
context :: proc(self: ^Self, bounds: Aabb) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let y = bounds.min_position().y;
    // rust: if !self
    // rust: .subject
    // rust: .is_some_and(|s| s.lava_walker || s.leather_boots)
    // rust: {
    // rust: return CollisionContext::position(y);
}
    // rust: CollisionContext::for_entity(
    // rust: CollisionEntity {
    // rust: identity: EntityIdentity(0),
    // rust: y,
    // rust: descending: false,
    // rust: main_hand: Some(CollisionItem::EMPTY),
    // rust: },
    // rust: false,
    // rust: )
}
unobstructed :: proc(self: ^Self, bounds: Aabb) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(no_world_collision(
    // rust: self,
    // rust: CollisionCheckRequest {
    // rust: entity: EntityIdentity(0),
    // rust: context: CollisionContext::position(bounds.min_position().y),
    // rust: bounds,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )?)
}
}
// `noCollision(null, box)`: block collisions under the empty collision
// context, as entity-less queries such as spawn checks use.
    // rust: pub fn no_collision_empty<W, E>(world: &mut W, bounds: Aabb) -> bool
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E> + EntityMovementWorld<Error = E>,
    // rust: {
    // rust: no_collision_in(world, bounds, false)
}
// `noCollision(null, box, true)`: the same with liquids colliding as
// blocks (`CollisionContext.emptyWithFluidCollisions`).
    // rust: pub fn no_collision_or_liquid<W, E>(world: &mut W, bounds: Aabb) -> bool
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E> + EntityMovementWorld<Error = E>,
    // rust: {
    // rust: no_collision_in(world, bounds, true)
}
    // rust: fn no_collision_in<W, E>(world: &mut W, bounds: Aabb, fluids: bool) -> bool
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E> + EntityMovementWorld<Error = E>,
    // rust: {
    // rust: no_world_collision(
    // rust: world,
    // rust: CollisionCheckRequest {
    // rust: entity: EntityIdentity(0),
    // rust: context: CollisionContext::empty(fluids),
    // rust: bounds,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )
    // rust: .unwrap_or(false)
}
    // rust: impl SceneCollisions<'_, '_> {
    // Whether a `BlockCollisionScan` of `bounds` would find no shape, told without
    // building one: no block that can collide in its inner cells, and no block that
    // reaches out of its cell in the sections of its outer ones (where unsure, false:
    // the scan decides). The same cells, blocks and section flags the scan reads.
cells_without_collision :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (min, max) = (bounds.min_position(), bounds.max_position());
    // rust: if !min.is_finite() || !max.is_finite() {
    // rust: return false;
}
        // The scan's cells: one past the box on every side (`block_collision_scan::cells`).
    // rust: let lo = BlockPos::containing(Vec3::new(min.x - 1.0e-7, min.y - 1.0e-7, min.z - 1.0e-7))
    // rust: .offset(-1, -1, -1);
    // rust: let hi = BlockPos::containing(Vec3::new(max.x + 1.0e-7, max.y + 1.0e-7, max.z + 1.0e-7))
    // rust: .offset(1, 1, 1);
    // rust: let size = |a: i32, b: i32| i64::from(b) - i64::from(a) + 1;
    // rust: let cells = size(lo.x, hi.x) * size(lo.y, hi.y) * size(lo.z, hi.z);
    // rust: if lo.x > hi.x || lo.y > hi.y || lo.z > hi.z || cells > 4096 {
    // rust: return false;
}
    // rust: let mut column: Option<((i32, i32), Option<&crate::chunk::Chunk>)> = None;
    // rust: let mut section: Option<((i32, i32), i32, bool)> = None;
    // rust: for z in lo.z..=hi.z {
    // rust: for y in lo.y..=hi.y {
    // rust: for x in lo.x..=hi.x {
    // rust: let outer = [
    // rust: x == lo.x || x == hi.x,
    // rust: y == lo.y || y == hi.y,
    // rust: z == lo.z || z == hi.z,
    // rust: ];
    // rust: let kind = outer.into_iter().filter(|&o| o).count();
    // rust: if kind == 3 {
    // rust: continue;
}
    // rust: let at = (x >> 4, z >> 4);
    // rust: let chunk = match column {
    // rust: Some((c, chunk)) if c == at => chunk,
    // rust: _ => {
    // rust: let chunk = self.world.chunks.get(&at).map(|c| &**c);
    // rust: column = Some((at, chunk));
    // rust: chunk
}
}
                    // The scan passes the cells of a column that is not resident.
    // rust: let Some(chunk) = chunk else {
    // rust: continue;
}
    // rust: if kind != 0 {
    // rust: let reaches = match section {
    // rust: Some((c, sy, reaches)) if c == at && sy == y >> 4 => reaches,
    // rust: _ => {
    // rust: let reaches = self.section_reaches_out(chunk, y >> 4);
    // rust: section = Some((at, y >> 4, reaches));
    // rust: reaches
}
}
    // rust: if reaches {
    // rust: return false;
}
    // rust: continue;
}
    // rust: if self.binding.may_collide(chunk.block(x, y, z)) {
    // rust: return false;
}
}
}
}
    // rust: true
}

    // `may_reach_out`: whether a section's palette holds a block that reaches out of
    // its cell; a global palette, or a section outside the column, may.
section_reaches_out :: proc(self: ^Self, chunk: ^crate::chunk::Chunk, section_y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let blocks = usize::try_from(section_y - (chunk.min_y() >> 4))
    // rust: .ok()
    // rust: .and_then(|s| chunk.sections.get(s))
    // rust: .map(|section| &section.blocks);
    // rust: blocks.is_none_or(|blocks| {
    // rust: blocks.is_global() || blocks.maybe_has(|v| self.binding.reaches_out(BlockStateId(v)))
    // rust: })
}
}
    // rust: impl<'w> BlockCollisionWorld for SceneCollisions<'w, '_> {
    // rust: type Error = io::Error;
    // The resident column, looked up once per chunk the scan enters.
    // rust: type Chunk = &'w crate::chunk::Chunk;
collision_chunk :: proc(self: ^Self, p: ChunkPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.world.chunks.get(&(p.x, p.z)).map(|chunk| &**chunk))
}
collision_block :: proc(self: ^Self, chunk: Self::Chunk, p: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.binding.collision_block(chunk.block(p.x, p.y, p.z))
}
    // From the section's palette, without reading its blocks; a palette
    // of the whole registry reads every cell.
may_reach_out :: proc(self: ^Self, chunk: Self::Chunk, section_y: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.section_reaches_out(chunk, section_y))
}
    // From the section's palette: every block it can hold has an empty shape (air, plants).
    // A palette of the whole registry, or a section outside the column, is read cell by cell.
section_is_empty :: proc(self: ^Self, chunk: Self::Chunk, section_y: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let blocks = usize::try_from(section_y - (chunk.min_y() >> 4))
    // rust: .ok()
    // rust: .and_then(|s| chunk.sections.get(s))
    // rust: .map(|section| &section.blocks);
    // rust: Ok(blocks.is_some_and(|blocks| {
    // rust: !blocks.is_global()
    // rust: && !blocks.maybe_has(|v| {
    // rust: self.binding
    // rust: .collision_block(BlockStateId(v))
    // rust: .map_or(true, |block| !block.empty_shape)
    // rust: })
    // rust: }))
}
    // The resident columns do not change while a scan runs, and looking one up changes nothing.
missing_chunks_stay_missing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // rust: fn is_suffocating(
    // rust: &mut self,
    // rust: _: Self::Chunk,
    // rust: _: CollisionBlock,
    // rust: _: BlockPos,
    // rust: ) -> io::Result<bool> {
    // rust: Ok(false)
}
    // rust: fn context_shape(
    // rust: &mut self,
    // rust: block: CollisionBlock,
    // rust: p: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> io::Result<VoxelShape> {
    // rust: self.binding
    // rust: .collision_shape_with_context(self, block.state, p, context)
    // rust: .map_err(io::Error::other)
}
}
    // rust: impl EntityMovementWorld for SceneCollisions<'_, '_> {
    // rust: type Error = io::Error;
entity_collisions :: proc(self: ^Self, _: EntityIdentity, _: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Vec::new())
}
movement_border :: proc(self: ^Self, _: EntityIdentity, _: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
}
    // rust: impl DynamicSupportWorld for SceneCollisions<'_, '_> {
    // rust: type Error = io::Error;
    // `ShulkerBoxBlockEntity.isClosed`: whether the lid is still shut. A
    // closed box collides as its plain block (`ShulkerBoxBlock.getShape`
    // asks the block entity, which has grown once the lid starts to open).
shulker_is_closed :: proc(self: ^Self, p: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self
    // rust: .world
    // rust: .shulkers
    // rust: .get(&p)
    // rust: .map(|s| s.status == crate::block_entity_anim::ShulkerStatus::Closed))
}
    // `MovingPistonBlock.getCollisionShape`: the block entity's moving shape
    // (`PistonMovingBlockEntity.getCollisionShape`), outside any push.
moving_piston_shape :: proc(self: ^Self, p: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Some(&(_, piston)) = self.world.moving_pistons.iter().find(|(q, _)| *q == p) else {
    // rust: return Ok(None);
}
    // rust: let binding = self.binding;
    // rust: let Some(pistons) = binding.pistons() else {
    // rust: return Ok(None);
}
    // rust: pistons
    // rust: .collision_shape(self, p, piston, PISTON_NOCLIP.with(|value| value.get()))
    // rust: .map(Some)
    // rust: .map_err(io::Error::other)
}
}
    // rust: impl PistonCollisionWorld for SceneCollisions<'_, '_> {
    // rust: type Error = io::Error;
    // `BlockState.getCollisionShape(level, pos)` of the moved state.
collision_shape :: proc(self: ^Self, state: BlockStateId, p: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let binding = self.binding;
    // rust: binding
    // rust: .collision_shape(self, state, p)
    // rust: .map_err(io::Error::other)
}
}
    // rust: impl DynamicCollisionWorld for SceneCollisions<'_, '_> {
    // `ShulkerBoxBlockEntity.getBoundingBox`: the box's collision shape
    // (`getShape`) is the free shape grown by the lid's progress, which is
    // what lets an entity sink into an opening box. None: no such box here.
    // rust: fn shulker_collision_state(
    // rust: &mut self,
    // rust: p: [i32; 3],
    // rust: ) -> io::Result<Option<ShulkerCollisionState>> {
    // rust: Ok(self.world.shulkers.get(&p).map(|s| ShulkerCollisionState {
    // rust: previous_progress: s.progress_old,
    // rust: progress: s.progress,
    // rust: }))
}
}
    // rust: impl LiquidCollisionWorld for SceneCollisions<'_, '_> {
    // rust: type Error = io::Error;
    // Only striders stand on fluids.
entity_liquid_shape :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(if self.subject.is_some_and(|s| s.lava_walker) {
    // rust: strider_liquid_shape()
    // rust: } else {
    // rust: VoxelShape::empty()
    // rust: })
}
fluid :: proc(self: ^Self, p: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: FluidState::from_block(
    // rust: self.binding
    // rust: .registry()
    // rust: .state(self.world.block(p.x, p.y, p.z))
    // rust: .ok_or_else(|| io::Error::other("scene fluid state outside registry"))?,
    // rust: )
}
    // `Strider.canStandOnFluid`: lava.
entity_can_stand :: proc(self: ^Self, _: EntityIdentity, fluid: FluidState) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.subject.is_some_and(|s| s.lava_walker)
    // rust: && matches!(fluid.kind(), FluidKind::Lava | FluidKind::FlowingLava))
}
}
    // rust: impl PowderSnowWorld for SceneCollisions<'_, '_> {
    // rust: type Error = io::Error;
powder_snow_entity :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let subject = self.subject.unwrap_or_default();
    // rust: Ok(PowderSnowEntity {
    // rust: fall_distance: subject.fall_distance,
    // rust: falling_block: subject.falling_block,
    // rust: })
}
powder_snow_walkable_tag :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.subject.is_some_and(|s| s.walkable_type))
}
feet_are_leather_boots :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.subject.is_some_and(|s| s.leather_boots))
}
}

// A collision world without blocks: no chunk is resident, so only the
// world border stops a body.
EmptyCollisions :: struct {

    // rust: impl BlockCollisionWorld for EmptyCollisions {
    // rust: type Error = io::Error;
    // rust: type Chunk = ChunkPos;
collision_chunk :: proc(self: ^Self, _: ChunkPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
missing_chunks_stay_missing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
collision_block :: proc(self: ^Self, _: ChunkPos, _: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Err(io::Error::other("no chunk is resident"))
}
is_suffocating :: proc(self: ^Self, _: ChunkPos, _: CollisionBlock, _: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
    // rust: fn context_shape(
    // rust: &mut self,
    // rust: _: CollisionBlock,
    // rust: _: BlockPos,
    // rust: _: &CollisionContext<'_>,
    // rust: ) -> io::Result<VoxelShape> {
    // rust: Ok(VoxelShape::empty())
}
}

    // rust: impl EntityMovementWorld for EmptyCollisions {
    // rust: type Error = io::Error;
entity_collisions :: proc(self: ^Self, _: EntityIdentity, _: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Vec::new())
}
movement_border :: proc(self: ^Self, _: EntityIdentity, _: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
}

// Collision queries over any block lookup (test worlds without chunks):
// every chunk is present, nothing is suffocating, no entities collide.
LookupCollisions :: struct {
    block: ^'w dyn Fn(i32,
    binding: ^'w BlockCollisionRegistry<'r>,
}
    // rust: impl BlockCollisionWorld for LookupCollisions<'_, '_> {
    // rust: type Error = io::Error;
    // rust: type Chunk = ChunkPos;
collision_chunk :: proc(self: ^Self, p: ChunkPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Some(p))
}
collision_block :: proc(self: ^Self, _: ChunkPos, p: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.binding.collision_block((self.block)(p.x, p.y, p.z))
}
is_suffocating :: proc(self: ^Self, _: ChunkPos, _: CollisionBlock, _: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
    // rust: fn context_shape(
    // rust: &mut self,
    // rust: block: CollisionBlock,
    // rust: p: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> io::Result<VoxelShape> {
    // rust: self.binding
    // rust: .collision_shape_with_context(self, block.state, p, context)
    // rust: .map_err(io::Error::other)
}
}
    // rust: impl EntityMovementWorld for LookupCollisions<'_, '_> {
    // rust: type Error = io::Error;
entity_collisions :: proc(self: ^Self, _: EntityIdentity, _: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Vec::new())
}
movement_border :: proc(self: ^Self, _: EntityIdentity, _: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
}
    // rust: impl DynamicSupportWorld for LookupCollisions<'_, '_> {
    // rust: type Error = io::Error;
    // No block-entity data: a lookup world has no shulker box to ask, so the
    // box collides as a shut one (`VoxelShape::block()`).
shulker_is_closed :: proc(self: ^Self, _: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
moving_piston_shape :: proc(self: ^Self, _: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
}
    // rust: impl DynamicCollisionWorld for LookupCollisions<'_, '_> {
    // No block-entity data: the block table's own shape stands in for the lid
    // (`ShulkerBoxBlockEntity.getBoundingBox` needs a block entity).
    // rust: fn shulker_collision_state(
    // rust: &mut self,
    // rust: _: [i32; 3],
    // rust: ) -> io::Result<Option<ShulkerCollisionState>> {
    // rust: Ok(None)
}
}
    // rust: impl LiquidCollisionWorld for LookupCollisions<'_, '_> {
    // rust: type Error = io::Error;
entity_liquid_shape :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(VoxelShape::empty())
}
fluid :: proc(self: ^Self, p: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: FluidState::from_block(
    // rust: self.binding
    // rust: .registry()
    // rust: .state((self.block)(p.x, p.y, p.z))
    // rust: .ok_or_else(|| io::Error::other("fluid state outside registry"))?,
    // rust: )
}
entity_can_stand :: proc(self: ^Self, _: EntityIdentity, _: FluidState) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
}
    // rust: impl PowderSnowWorld for LookupCollisions<'_, '_> {
    // rust: type Error = io::Error;
powder_snow_entity :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(PowderSnowEntity {
    // rust: fall_distance: 0.0,
    // rust: falling_block: false,
    // rust: })
}
powder_snow_walkable_tag :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
feet_are_leather_boots :: proc(self: ^Self, _: EntityIdentity) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
}

    // rust: mod piston_noclip_tests {
//     use super::*;
//     use horizon_core::geometry::Direction;

piston_noclip_is_scoped_and_restored_after_unwind :: proc() {
}
    // rust: assert_eq!(PISTON_NOCLIP.with(|value| value.get()), None);
    // rust: with_piston_noclip(Direction::East, || {
    // rust: assert_eq!(
    // rust: PISTON_NOCLIP.with(|value| value.get()),
    // rust: Some(Direction::East)
    // rust: );
    // rust: let _ =
    // rust: std::panic::catch_unwind(|| with_piston_noclip(Direction::West, || panic!("test")));
    // rust: assert_eq!(
    // rust: PISTON_NOCLIP.with(|value| value.get()),
    // rust: Some(Direction::East)
    // rust: );
    // rust: });
    // rust: assert_eq!(PISTON_NOCLIP.with(|value| value.get()), None);
}
}

    // rust: mod border_movement_tests {
//     use super::*;

    // A border 10 wide around the origin: its wall's inner face is at x = 5.
border :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: BorderGeometry::new([0.0, 0.0], 10.0, 29_999_984).expect("a border")
}

    // `WorldBorder.isInsideCloseToBorder` and `WorldBorder.getCollisionShape`:
    // a body inside close to the border collides with the border's walls.
a_body_next_to_the_border_stops_at_its_wall :: proc() {
}
        // A body 0.6 wide, 0.4 blocks short of the wall, moved east into it.
    // rust: let bounds = Aabb::new(Vec3::new(4.0, 0.0, 0.0), Vec3::new(4.6, 1.8, 0.6));
    // rust: let border = border();
    // rust: let mut collisions = EntityCollisions::with_border(EmptyCollisions, &border, [4.3, 0.3]);
    // rust: let moved = collisions
    // rust: .resolve(bounds, Vec3::new(0.51, 0.0, 0.0), 0.0, false)
    // rust: .expect("the movement resolves");
        // The wall stops the body 0.4 blocks short of the whole move.
    // rust: assert!(
    // rust: (moved.x - 0.4).abs() < 1.0e-9,
    // rust: "the body was not stopped by the border: {moved:?}"
    // rust: );
}

    // A minecart (0.98 wide, 0.7 tall) rolling east at its top speed of 0.4 a tick, 0.11
    // blocks short of the wall: the wall takes all but the 0.11 (`move_cart` hands the
    // cart's x and z to `with_border`, as every entity does in `Entity.move`).
a_minecart_sized_body_stops_at_the_border_wall :: proc() {
}
        // Centre x = 4.4, half width 0.49: the cart's east face is at 4.89, the wall at 5.0.
    // rust: let bounds = Aabb::new(Vec3::new(3.91, 0.0, -0.49), Vec3::new(4.89, 0.7, 0.49));
    // rust: let border = border();
    // rust: let mut collisions = EntityCollisions::with_border(EmptyCollisions, &border, [4.4, 0.0]);
    // rust: let moved = collisions
    // rust: .resolve(bounds, Vec3::new(0.4, 0.0, 0.0), 0.0, false)
    // rust: .expect("the movement resolves");
    // rust: assert!(
    // rust: (moved.x - 0.11).abs() < 1.0e-9,
    // rust: "the cart was not stopped by the border: {moved:?}"
    // rust: );
    // rust: assert_eq!(moved.z, 0.0);
}

    // Away from the border, the same body moves the whole way.
a_body_away_from_the_border_moves_whole :: proc() {
}
    // rust: let bounds = Aabb::new(Vec3::new(0.0, 0.0, 0.0), Vec3::new(0.6, 1.8, 0.6));
    // rust: let border = border();
    // rust: let mut collisions = EntityCollisions::with_border(EmptyCollisions, &border, [0.3, 0.3]);
    // rust: let moved = collisions
    // rust: .resolve(bounds, Vec3::new(0.51, 0.0, 0.0), 0.0, false)
    // rust: .expect("the movement resolves");
    // rust: assert!(
    // rust: (moved.x - 0.51).abs() < 1.0e-9,
    // rust: "the body did not move the whole way: {moved:?}"
    // rust: );
}
}

    // rust: mod shulker_collision_tests {
//     use super::*;
//     use crate::block_entity_anim::{Shulker, ShulkerStatus, progress_delta_aabb};
//     use horizon_core::geometry::{Aabb, Axis, Direction, Vec3, VoxelShape};

    // A shulker box facing up at progress 0.0 (closed): collision is a 1x1x1 block.
shulker_closed_collision_is_full_block :: proc() {
}
    // rust: let shulker = Shulker {
    // rust: status: ShulkerStatus::Closed,
    // rust: progress: 0.0,
    // rust: progress_old: 0.0,
    // rust: ..Shulker::default()
}

    // rust: let state = ShulkerCollisionState {
    // rust: previous_progress: shulker.progress_old,
    // rust: progress: shulker.progress,
}
    // rust: let aabb = state.bounding_box(Direction::Up);

        // Closed box: height 1.0
    // rust: assert!((aabb.min(Axis::Y) - 0.0).abs() < 1.0e-9);
    // rust: assert!((aabb.max(Axis::Y) - 1.0).abs() < 1.0e-9);
        // Full horizontal extent
    // rust: assert!((aabb.min(Axis::X) - 0.0).abs() < 1.0e-9);
    // rust: assert!((aabb.max(Axis::X) - 1.0).abs() < 1.0e-9);
}

    // A shulker box facing up at progress 1.0 (fully open): collision is 1.5 tall.
shulker_open_collision_grows_upward :: proc() {
}
    // rust: let shulker = Shulker {
    // rust: status: ShulkerStatus::Opened,
    // rust: progress: 1.0,
    // rust: progress_old: 1.0,
    // rust: ..Shulker::default()
}

    // rust: let state = ShulkerCollisionState {
    // rust: previous_progress: shulker.progress_old,
    // rust: progress: shulker.progress,
}
    // rust: let aabb = state.bounding_box(Direction::Up);

        // Fully open: height 1.5 (lid extends 0.5 above the block)
    // rust: assert!((aabb.min(Axis::Y) - 0.0).abs() < 1.0e-9);
    // rust: assert!((aabb.max(Axis::Y) - 1.5).abs() < 1.0e-9);
}

    // A shulker box halfway open: collision height is 1.25.
shulker_half_open_collision_height :: proc() {
}
    // rust: let shulker = Shulker {
    // rust: status: ShulkerStatus::Opening,
    // rust: progress: 0.5,
    // rust: progress_old: 0.5,
    // rust: ..Shulker::default()
}

    // rust: let state = ShulkerCollisionState {
    // rust: previous_progress: shulker.progress_old,
    // rust: progress: shulker.progress,
}
    // rust: let aabb = state.bounding_box(Direction::Up);

        // Half open: height 1.25
    // rust: assert!((aabb.min(Axis::Y) - 0.0).abs() < 1.0e-9);
    // rust: assert!((aabb.max(Axis::Y) - 1.25).abs() < 1.0e-9);
}

    // Vanilla clip quirk: an entity whose feet are *inside* the grown lid box
    // moving DOWN is not stopped by the box (collision only triggers when
    // approaching from outside). An entity ABOVE the box moving DOWN is stopped.
shulker_grown_box_allows_clip_when_inside :: proc() {
}
        // Box at progress 1.0: spans y=0..1.5
    // rust: let shulker = Shulker {
    // rust: status: ShulkerStatus::Opened,
    // rust: progress: 1.0,
    // rust: progress_old: 1.0,
    // rust: ..Shulker::default()
}
    // rust: let state = ShulkerCollisionState {
    // rust: previous_progress: shulker.progress_old,
    // rust: progress: shulker.progress,
}
    // rust: let aabb = state.bounding_box(Direction::Up);
    // rust: let box_shape = VoxelShape::from_box(aabb).expect("shulker box is a valid shape");

        // Entity box whose feet are at y=0.5 (inside the grown box), height 1.8
    // rust: let entity = Aabb::new(Vec3::new(0.2, 0.5, 0.2), Vec3::new(0.8, 2.3, 0.8));

        // Moving DOWN from inside the box: collide() should NOT stop it
        // (the entity is already intersecting the box, so the downward movement
        // sees no face to hit from above).
    // rust: let down = -0.1;
    // rust: let moved_down = box_shape.collide(Axis::Y, entity, down);
    // rust: assert!(
    // rust: (moved_down - down).abs() < 1.0e-9,
    // rust: "entity inside grown box should fall through (clip): moved_down={moved_down}, expected={down}"
    // rust: );

        // Entity box whose feet are at y=1.6 (just ABOVE the grown box)
    // rust: let entity_above = Aabb::new(Vec3::new(0.2, 1.6, 0.2), Vec3::new(0.8, 3.4, 0.8));

        // Moving DOWN from above: collide() SHOULD stop it at y=1.5
    // rust: let moved_down_above = box_shape.collide(Axis::Y, entity_above, -0.2);
        // The box's top is at y=1.5, entity bottom at 1.6, so max down is -0.1
    // rust: assert!(
    // rust: (moved_down_above - (-0.1)).abs() < 1.0e-9,
    // rust: "entity above grown box should be stopped: moved_down_above={moved_down_above}, expected=-0.1"
    // rust: );
}

    // An entity standing on the lid (y=1.0 when closed, y=1.5 when open)
    // and pushed up by the lid: the lid's swept AABB pushes it along the facing.
    // This is tested at the integration level via `push_shulker_entities`;
    // here we only verify the swept box geometry matches vanilla's
    // `Shulker.getProgressDeltaAabb`.
shulker_swept_box_matches_vanilla_delta :: proc() {
}
        // From closed (0.0) to progress 0.5: the lid sweeps from y=0..1 (closed box)
        // to y=0..1.5 (half open), so the swept volume in world coords at position
        // [0.5, 0.0, 0.5] (bottom center of block at y=0) is y=1.0..1.5.
    // rust: let delta = progress_delta_aabb(1.0, Direction::Up as u8, 0.0, 0.5, [0.5, 0.0, 0.5]);
    // rust: assert!((delta[1] - 1.0).abs() < 1.0e-9); // minY
    // rust: assert!((delta[4] - 1.5).abs() < 1.0e-9); // maxY

        // From progress 0.5 to 1.0: swept y=1.5..2.0 in world coords
    // rust: let delta2 = progress_delta_aabb(1.0, Direction::Up as u8, 0.5, 1.0, [0.5, 0.0, 0.5]);
    // rust: assert!((delta2[1] - 1.5).abs() < 1.0e-9);
    // rust: assert!((delta2[4] - 2.0).abs() < 1.0e-9);
}
}

    // rust: mod section_tests {
//     use super::*;

    // Boxes swept through air, past torches (no collision shape), a fence (a shape
    // reaching into the cell above) and the scene's stone: wherever the cells say no
    // block can collide, the full resolution returns the movement, to the bit; the rest
    // is left to it. Needs the prepared resources.
cells_without_collision_leave_the_movement_as_resolving_does :: proc() {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("cached-collision.nbt").exists() {
    // rust: eprintln!("no prepared resources: skipped");
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let state = |name: &str| assets.registry.default_state(name).unwrap();
        // Torches, and a fence at the bottom of a section above air.
    // rust: for x in 17..30 {
    // rust: world.set(x, 20, 20, state("minecraft:torch")).unwrap();
}
    // rust: world.set(5, 32, 5, state("minecraft:oak_fence")).unwrap();
    // rust: let scene = SceneCollisions {
    // rust: world: &world,
    // rust: binding: &binding,
    // rust: subject: None,
}
        // Under the fence: its section's outer cells may hold a shape reaching in.
    // rust: let under = Aabb::new(Vec3::new(5.4, 31.6, 5.4), Vec3::new(5.6, 31.8, 5.6));
    // rust: assert!(!scene.cells_without_collision(under.expand_towards(Vec3::new(0.0, 0.1, 0.0))));
        // A torch's cell, and the air just over the scene's stone floor (y 0..4).
    // rust: let torches = Aabb::new(Vec3::new(20.4, 20.1, 20.4), Vec3::new(20.6, 20.3, 20.6));
    // rust: assert!(scene.cells_without_collision(torches));
    // rust: let over_floor = Aabb::new(Vec3::new(30.4, 5.2, 30.4), Vec3::new(30.6, 5.4, 30.6));
    // rust: assert!(scene.cells_without_collision(over_floor));
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed >> 11) as f64 / (1u64 << 53) as f64
}
    // rust: let (mut skipped, mut resolved) = (0, 0);
    // rust: for i in 0..4000 {
    // rust: let size = if i % 2 == 0 { 0.2 } else { 0.6 };
            // Near the floor (y 0..4) and the stepped pyramid (y 4..11) for most, higher for the rest.
    // rust: let height = if i % 4 == 0 { 40.0 } else { 14.0 };
    // rust: let at = Vec3::new(next() * 80.0 - 40.0, next() * height, next() * 80.0 - 40.0);
    // rust: let bb = Aabb::new(at, Vec3::new(at.x + size, at.y + size, at.z + size));
    // rust: let reach = if i % 3 == 0 { 3.0 } else { 0.3 };
    // rust: let d = Vec3::new(
    // rust: (next() - 0.5) * reach,
    // rust: (next() - 0.5) * reach,
    // rust: (next() - 0.5) * reach,
    // rust: );
    // rust: let fast = scene.cells_without_collision(bb.expand_towards(d));
    // rust: let mut full = SceneCollisions {
    // rust: world: &world,
    // rust: binding: &binding,
    // rust: subject: None,
}
    // rust: let moved = full.resolve(bb, d, 0.0, false).unwrap();
    // rust: if fast {
    // rust: skipped += 1;
    // rust: assert_eq!(
    // rust: moved.components().map(f64::to_bits),
    // rust: d.components().map(f64::to_bits),
    // rust: "{bb:?} by {d:?}"
    // rust: );
    // rust: } else {
    // rust: resolved += 1;
}
}
    // rust: assert!(
    // rust: skipped > 500 && resolved > 500,
    // rust: "{skipped} skipped, {resolved} resolved"
    // rust: );
}
}
