//! Transpiled from Horizon Rust crate
package horizon_client_fluids

import "core:fmt"
import "core:mem"
import "core:math"

// The player's fluid immersion over the resident scene: `Entity.updateFluidInteraction`
// (water, waterlogged blocks, bubble columns and lava, with their currents), the
// water-entry splash and the fall resets that hinge on touching water.
// use super::*;
// use horizon_world::{
    // rust: entity_fluid::{
    // rust: CurrentTarget, EntityFluidInteraction, FluidInteractionWorld, FluidMembership,
    // rust: FluidSections, FluidTagId,
    // rust: },
    // rust: entity_fluid_tick::{self, EntityFluidTickWorld},
    // rust: fluid::{FluidHeightWorld, FluidKind, FluidState, FluidStateTable},
    // rust: fluid_flow::{FluidFlowWorld, flow_at},
    // rust: fluid_shape::FluidShapeCache,
    // rust: water_splash::{self, SplashParticle, WaterSplashWorld},
}
// use std::sync::Mutex;

// `FluidTags.WATER` and `FluidTags.LAVA`, the fluids with a current.
WATER :: FluidTagId(0)
LAVA :: FluidTagId(1)

// Per-state fluid facts the player's immersion and fall-reset rays read.
FluidResources :: struct {
    states: FluidStateTable,
    // `isFaceSturdy(FULL)` per `Direction` (bit = ordinal).
    sturdy: [dynamic]u8,
    // `#minecraft:blocks_fluid_flow` membership.
    blocks_flow: [dynamic]bool,
    // `IceBlock` and its subclasses.
    ice: [dynamic]bool,
    // `FlowingFluid.shapes`: the shape of the first query of each fluid
    // state, kept for the whole process like the registered fluid's map.
    shapes: Mutex<FluidShapeCache>,
}
    // rust: impl FluidResources {
new :: proc(assets: ^Assets, facts: ^crate::blocks::BlockFacts) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_registry(assets.registry, facts, &assets.blocks_fluid_flow)
}
    // Build fluid queries from the same registry, block facts and flow tag as the scene.
    // rust: pub fn from_registry(
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: blocks_fluid_flow: &BTreeSet<String>,
    // rust: ) -> Result<Self> {
    // rust: Ok(Self {
    // rust: states: FluidStateTable::new(registry)?,
    // rust: sturdy: facts.states.iter().map(|s| s.sturdy_full).collect(),
    // rust: blocks_flow: facts
    // rust: .states
    // rust: .iter()
    // rust: .map(|s| blocks_fluid_flow.contains(&*s.name))
    // rust: .collect(),
    // rust: ice: facts
    // rust: .states
    // rust: .iter()
    // rust: .map(|s| s.has_class("IceBlock"))
    // rust: .collect(),
    // rust: shapes: Mutex::new(FluidShapeCache::default()),
    // rust: })
}
fluid :: proc(self: ^Self, state: BlockStateId) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.states.get(state).unwrap_or(FluidState::EMPTY)
}
    // `BlockState.isFaceSturdy(FULL)` on that face.
sturdy :: proc(self: ^Self, state: BlockStateId, d: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sturdy
    // rust: .get(state.0 as usize)
    // rust: .is_some_and(|s| s & 1 << d as u8 != 0)
}
    // `#minecraft:blocks_fluid_flow` membership.
blocks_flow :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks_flow
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // `IceBlock` or one of its subclasses.
ice :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.ice.get(state.0 as usize).copied().unwrap_or(false)
}
}
// The player's `EntityFluidInteraction` and the water flags around it.
PlayerFluids :: struct {
    interaction: EntityFluidInteraction,
    // `Entity.wasTouchingWater` (`isInWater`).
    was_touching_water: bool,
    // `Entity.wasEyeInWater`.
    was_eye_in_water: bool,
    // `Entity.firstTick`: no splash, and no lava, until the first base tick ends.
    first_tick: bool,
    // The dimension's `FAST_LAVA` (the Nether), set by the game.
    fast_lava: bool,
    // The boat the player sits in (`Entity.getVehicle`), set by the game.
    boat: Maybe(RiddenBoat),
}
// What `AbstractBoat.modifyPassengerFluidInteractionBox` reads of a boat.
RiddenBoat :: struct {
    // `AbstractBoat.isUnderWater`.
    under_water: bool,
    // The top of the boat's box (`getBoundingBox().maxY`).
    max_y: f64,
}
    // rust: impl Default for PlayerFluids {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: interaction: EntityFluidInteraction::new([WATER, LAVA]),
    // rust: was_touching_water: false,
    // rust: was_eye_in_water: false,
    // rust: first_tick: true,
    // rust: fast_lava: false,
    // rust: boat: None,
}
}
}
is_tagged :: proc(kind: FluidKind, tag: FluidTagId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if tag == WATER {
    // rust: matches!(kind, FluidKind::Water | FluidKind::FlowingWater)
    // rust: } else {
    // rust: matches!(kind, FluidKind::Lava | FluidKind::FlowingLava)
}
}
    // rust: impl PlayerMotion {
fluid_height :: proc(self: ^Self, tag: FluidTagId) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.fluids.interaction.fluid_height(&FluidTags, tag)
}
is_eye_in_fluid :: proc(self: ^Self, tag: FluidTagId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.fluids.interaction.is_eye_in_fluid(&FluidTags, tag)
}
    // `LocalPlayer.isUnderWater`: `wasUnderwater`, the eye sample `Player.tick`
    // takes before the base tick (`Entity.isUnderWater` also needs the body
    // still in water).
is_under_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.fluids.was_eye_in_water
}
    // `Entity.isInLava`.
is_in_lava :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.fluids.first_tick && self.fluids.interaction.is_in_fluid(&FluidTags, LAVA)
}
}
// `BubbleColumnBlock.entityInside` for an entity that is not the player (a mob,
// a dropped item, an ender pearl): the bubble columns its box touches push it
// up or drag it down, harder at the surface (`Entity.handleOnAboveBubbleColumn`
// and `handleOnInsideBubbleColumn`). Returns whether it was inside a column
// below the surface, which resets its fall distance.
    // rust: pub fn bubble_column_push(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: bounds: Aabb,
    // rust: velocity: &mut Vec3,
    // rust: ) -> bool {
    // rust: bubble_column_push_over(world, registry, facts, collision, bounds, velocity, |_| {})
}
// [`bubble_column_push`], telling `surface` the position of each column block
// the entity is at the top of: `handleOnAboveBubbleColumn` sends the splash and
// bubble particles over it (`Entity.sendBubbleColumnParticles`).
    // rust: pub fn bubble_column_push_over(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: bounds: Aabb,
    // rust: velocity: &mut Vec3,
    // rust: mut surface: impl FnMut(BlockPos),
    // rust: ) -> bool {
    // rust: let mut reset_fall = false;
    // rust: bubble_columns_touching(world, registry, facts, collision, bounds, |pos, column| {
    // rust: reset_fall |= column.push(velocity);
    // rust: if column.surface {
    // rust: surface(pos);
}
    // rust: });
    // rust: reset_fall
}
// The column blocks `bounds` touches that it is at the top of: where the
// particles of `Entity.sendBubbleColumnParticles` start.
    // rust: pub fn bubble_column_surfaces(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: bounds: Aabb,
    // rust: ) -> Vec<BlockPos> {
    // rust: let mut surfaces = Vec::new();
    // rust: bubble_columns_touching(world, registry, facts, collision, bounds, |pos, column| {
    // rust: if column.surface {
    // rust: surfaces.push(pos);
}
    // rust: });
    // rust: surfaces
}
// Every bubble column block the box touches (`Entity.getInsideBlockPoints`).
    // rust: fn bubble_columns_touching(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: bounds: Aabb,
    // rust: mut each: impl FnMut(BlockPos, BubbleColumn),
    // rust: ) {
    // rust: let b = bounds.deflate(Vec3::new(
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: ));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in lo.x.floor() as i32..=(hi.x.ceil() as i32 - 1) {
    // rust: for y in lo.y.floor() as i32..=(hi.y.ceil() as i32 - 1) {
    // rust: for z in lo.z.floor() as i32..=(hi.z.ceil() as i32 - 1) {
    // rust: let pos = BlockPos::new(x, y, z);
    // rust: if let Some(column) = bubble_column_at(world, registry, facts, collision, pos) {
    // rust: each(pos, column);
}
}
}
}
}
// A bubble column block as `BubbleColumnBlock.entityInside` sees it: whether
// it drags down (`DRAG_DOWN`), and whether it is the surface (nothing above it
// to collide with and no fluid there).
BubbleColumn :: struct {
    drag: bool,
    surface: bool,
}
    // rust: impl BubbleColumn {
    // `Entity.handleOnAboveBubbleColumn` at the surface (it throws harder),
    // else `handleOnInsideBubbleColumn`. Returns whether it was inside below
    // the surface, which resets the fall distance.
push :: proc(self: ^Self, velocity: ^Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: velocity.y = match (self.surface, self.drag) {
    // rust: (true, true) => (-0.9_f64).max(velocity.y - 0.03),
    // rust: (true, false) => 1.8_f64.min(velocity.y + 0.1),
    // rust: (false, true) => (-0.3_f64).max(velocity.y - 0.03),
    // rust: (false, false) => 0.7_f64.min(velocity.y + 0.06),
}
    // rust: !self.surface
}
}
// The bubble column at `pos`, if there is one.
    // rust: pub fn bubble_column_at(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: collision: &horizon_world::block_collision::BlockCollisionRegistry<'_>,
    // rust: pos: BlockPos,
    // rust: ) -> Option<BubbleColumn> {
    // rust: let state = world.block(pos.x, pos.y, pos.z);
    // rust: if &*facts.get(state).name != "minecraft:bubble_column" {
    // rust: return None;
}
    // rust: let drag = registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("drag"))
    // rust: .is_some_and(|d| d == "true");
    // rust: let above = world.block(pos.x, pos.y + 1, pos.z);
    // stateAbove.getCollisionShape(level, pos): the shape is asked
    // at the column's own position.
    // rust: let mut scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let context = horizon_world::collision_context::CollisionContext::empty(false);
    // rust: let surface = collision
    // rust: .collision_shape_with_context(&mut scene, above, pos, &context)
    // rust: .is_ok_and(|shape| shape.is_empty())
    // rust: && facts.get(above).fluid == crate::blocks::Fluid::None;
    // rust: Some(BubbleColumn { drag, surface })
}
// Which fluids `FluidTags.WATER` and `FluidTags.LAVA` hold.
FluidTags :: struct {
    // rust: impl FluidMembership for FluidTags {
fluid_in_tag :: proc(self: ^Self, kind: FluidKind, tag: FluidTagId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_tagged(kind, tag)
}
}
    // rust: impl MotionWorld<'_, '_, '_> {
    // rust: pub(super) fn fluid_at(&self, p: BlockPos) -> FluidState {
    // rust: self.resources.fluids.fluid(self.block(p))
}
    // `Entity.baseTick`'s fluid phase: `wasEyeInWater`, `updateFluidInteraction`,
    // swimming and remaining fire, lava's fall halving, then the first-tick clear.
fluid_base_tick :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.player.fluids.was_eye_in_water = self.player.is_eye_in_fluid(WATER);
    // rust: self.update_fluids()?;
        // `Player.updateSwimming`'s flying guard over `Entity.updateSwimming`,
        // whose both branches need `!isPassenger()`: a rider keeps no swim, so
        // the server's copy of a guest who boards a boat while swimming is not
        // left in the swimming box (eye 0.4) in the seat, at the waterline,
        // where the boat drowned and suffocated them (#4427).
    // rust: self.player.swimming = !self.player.flying
    // rust: && !self.player.is_passenger
    // rust: && self.player.sprinting
    // rust: && if self.player.swimming {
    // rust: self.player.fluids.was_touching_water
    // rust: } else {
    // rust: self.player.is_under_water()
    // rust: && is_tagged(
    // rust: self.fluid_at(BlockPos::containing(self.player.position))
    // rust: .kind(),
    // rust: WATER,
    // rust: )
}
    // rust: self.tick_remaining_fire()?;
    // rust: if self.player.is_in_lava() {
    // rust: self.player.fall_distance *= 0.5;
}
    // rust: self.player.fluids.first_tick = false;
    // rust: Ok(())
}
    // `Entity.updateFluidInteraction`: immersion heights, then touching water
    // resets the fall and splashes on entry, then the currents push.
update_fluids :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut interaction = std::mem::take(&mut self.player.fluids.interaction);
    // rust: let result = entity_fluid_tick::update(&mut interaction, self, WATER, LAVA, 1_000_000);
    // rust: self.player.fluids.interaction = interaction;
    // rust: result.map_err(|e| e.to_string().into())
}
    // `ClipContext.Fluid.WATER` in a fall-reset ray: the water's shape.
    // rust: pub(super) fn water_clip(&mut self, from: Vec3, to: Vec3, p: BlockPos) -> Result<bool> {
    // rust: let fluid = self.fluid_at(p);
    // rust: if !is_tagged(fluid.kind(), WATER) {
    // rust: return Ok(false);
}
    // rust: let resources = self.resources;
    // rust: let shape = resources
    // rust: .fluids
    // rust: .shapes
    // rust: .lock()
    // rust: .map_err(|_| "fluid shape cache poisoned")?
    // rust: .shape(self, fluid, p)?;
    // rust: Ok(shape.clip(from, to, p).is_some())
}
}
    // rust: impl FluidMembership for MotionWorld<'_, '_, '_> {
fluid_in_tag :: proc(self: ^Self, kind: FluidKind, tag: FluidTagId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_tagged(kind, tag)
}
}
    // rust: impl CurrentTarget for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
is_player_class :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
velocity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.player.velocity)
}
add_delta_movement :: proc(self: ^Self, delta: Vec3) -> R {
    // Ported from Horizon
    return {}
}
        // Entity.addDeltaMovement and setDeltaMovement keep only finite values.
    // rust: let v = self.player.velocity;
    // rust: let sum = Vec3::new(v.x + delta.x, v.y + delta.y, v.z + delta.z);
    // rust: if delta.is_finite() && sum.is_finite() {
    // rust: self.player.velocity = sum;
}
    // rust: Ok(())
}
}
    // rust: impl FluidInteractionWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type Chunk = ();
interaction_box :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
        // Entity.getFluidInteractionBox: the box less 0.001, then the vehicle's
        // say (`AbstractBoat.modifyPassengerFluidInteractionBox`).
    // rust: let b = self.player.bounds().deflate(Vec3::new(0.001, 0.001, 0.001));
    // rust: let Some(boat) = self.player.fluids.boat.filter(|boat| !boat.under_water) else {
    // rust: return Ok(Some(b));
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
        // A boat that reaches the passenger's head shelters all of it; else
        // only what lies above the boat's top counts.
    // rust: if boat.max_y >= hi.y {
    // rust: return Ok(None);
}
    // rust: Ok(Some(Aabb::new(
    // rust: Vec3::new(lo.x, lo.y.max(boat.max_y), lo.z),
    // rust: hi,
    // rust: )))
}
loaded_chunk :: proc(self: ^Self, x: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.scene.chunks.contains_key(&(x, z)).then_some(()))
}
chunk_sections :: proc(self: ^Self, _: () {
}
        // Resident sections keep no fluid count: scanning the box finds no
        // fluid where a section without fluid would have skipped it.
    // rust: let layout = self.scene.layout();
    // rust: Ok(FluidSections {
    // rust: minimum_section_y: layout.min_y() >> 4,
    // rust: has_fluid: crate::chunk::every_section(layout),
    // rust: })
}
bounding_box_min_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.player.bounds().min_position().y
}
block_x :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.player.position.x.floor() as i32
}
eye_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.player.position.y + f64::from(self.player.dimensions.eye_height))
}
block_z :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.player.position.z.floor() as i32
}
fluid_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.fluid_at(p))
}
fluid_height :: proc(self: ^Self, f: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: f.height_at(self, [p.x, p.y, p.z])
}
camera_height :: proc(self: ^Self, f: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: f.camera_height_at(self, [p.x, p.y, p.z])
}
flow :: proc(self: ^Self, f: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: flow_at(self, f, p)
}
}
    // rust: impl EntityFluidTickWorld for MotionWorld<'_, '_, '_> {
    // `Player.isPushedByFluid`: not while flying.
is_pushed_by_fluid :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(!self.player.flying)
}
reset_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.player.fall_distance = 0.0;
    // rust: Ok(())
}
was_touching_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.player.fluids.was_touching_water
}
first_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.player.fluids.first_tick
}
water_splash :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
        // `Player.doWaterSplashEffect`: spectators skip the effect (and its random draws).
    // rust: if self.player.spectator {
    // rust: return Ok(());
}
    // rust: water_splash::water_splash(self, 1_000_000).map_err(|e| e.to_string())?;
    // rust: Ok(())
}
set_was_touching_water :: proc(self: ^Self, value: bool) {
}
    // rust: self.player.fluids.was_touching_water = value;
}
fast_lava :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.player.fluids.fast_lava)
}
}
    // rust: impl FluidHeightWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
fluid :: proc(self: ^Self, p: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.fluid_at(BlockPos::new(p[0], p[1], p[2])))
}
sturdy_down :: proc(self: ^Self, p: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = MotionWorld::block(self, BlockPos::new(p[0], p[1], p[2]));
    // rust: Ok(self.resources.fluids.sturdy(state, Direction::Down))
}
}
    // rust: impl FluidFlowWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type Block = BlockStateId;
fluid :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.fluid_at(p))
}
block :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(MotionWorld::block(self, p))
}
blocks_fluid_flow :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.resources.fluids.blocks_flow(s)
}
is_ice_class :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.resources.fluids.ice(s)
}
is_face_sturdy :: proc(self: ^Self, s: BlockStateId, _: BlockPos, d: Direction) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.resources.fluids.sturdy(s, d))
}
}
// `Entity.doWaterSplashEffect` for the player: the world random draws the
// pitch and particle offsets.
    // rust: impl WaterSplashWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type Entity = ();
    // `Player.getSwimHighSpeedSplashSound` when true, else `getSwimSplashSound`.
    // rust: type Sound = bool;
this_entity :: proc(self: ^Self) {
}
controlling_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
velocity :: proc(self: ^Self, _: () {
}
    // rust: Ok(self.player.velocity)
}
splash_sound :: proc(self: ^Self, high_speed: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(high_speed)
}
random_float :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.scene.random.next_float())
}
random_double :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.scene.random.next_double())
}
play_sound :: proc(self: ^Self, high_speed: bool, volume: f32, pitch: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.player.events.push(MotionEvent::Splash {
    // rust: high_speed,
    // rust: volume,
    // rust: pitch,
    // rust: });
    // rust: Ok(())
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.player.position
}
width :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.player.dimensions.width
}
particle :: proc(self: ^Self, kind: SplashParticle, position: Vec3, velocity: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.player.events.push(MotionEvent::SplashParticle {
    // rust: bubble: matches!(kind, SplashParticle::Bubble),
    // rust: position,
    // rust: velocity,
    // rust: });
    // rust: Ok(())
}
splash_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
        // The SPLASH game event: sculk listens to the player's moves itself.
    // rust: self.player.events.push(MotionEvent::SplashEvent);
    // rust: Ok(())
}
}
