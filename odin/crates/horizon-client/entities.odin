//! Transpiled from Horizon Rust crate
package horizon_client_entities

import "core:fmt"
import "core:mem"
import "core:math"

// Non-player entities simulated on the client world. Dropped items follow
// `ItemEntity.tick`: gravity 0.04, 0.98 drag (block friction on the ground),
// a ground bounce of -0.5, slime landing restitution (0.8, including a moving
// piston that is carrying slime), water buoyancy, pickup delay, 6000-tick despawn,
// `HoneyBlock.entityInside` when falling against a honey block's side, and
// `BubbleColumnBlock.entityInside` (lift / drag, including the surface jump).
// use crate::entity_rules::EntityRules;
// use crate::{
    // rust: blocks::{BlockFacts, Fluid},
    // rust: collisions::SceneCollisions,
    // rust: items::ItemStack,
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3, VoxelShape, border::BorderGeometry},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: level::portal_travel::{BorderBounds, find_free_position},
}

// Gravity applied each tick when the item is not in a fluid (`ItemEntity.tick`).
ITEM_GRAVITY :: 0.04
// Non-living slime `bounceRestitution` factor (`0.8f`) from
// `Entity.restituteMovementAfterCollisions`.
ITEM_SLIME_BOUNCE :: 0.8

// `Entity.restituteMovementAfterCollisions` for the vertical axis of a
// non-living entity: `current_y` is its velocity before the move, `moved_y`
// how far the move got. Landing on slime (`below`) bounces by the block's
// restitution `1.0f * 0.8f`, with the gravity and air drag the part of the tick
// after the hit would have added back; any other collision zeroes Y.
    // rust: pub fn vertical_collision_velocity(
    // rust: current_y: f64,
    // rust: moved_y: f64,
    // rust: gravity: f64,
    // rust: below: bool,
    // rust: slime: bool,
    // rust: ) -> f64 {
    // rust: if !(below && slime && -current_y > gravity) {
    // rust: return 0.0;
}
    // rust: let restitution = f64::from(1.0_f32 * ITEM_SLIME_BOUNCE);
    // rust: let portion = moved_y / current_y;
    // rust: let drag = 1.0 + portion * (f64::from(0.98_f32) - 1.0);
    // rust: (portion * gravity - current_y) * drag * restitution
}

// `Entity.move`: the position only changes when the collided step is longer
// than `sqrt(1e-7)` or nothing was cut off; a tiny step against a wall or floor
// is dropped (its collision effects still run).
move_applies :: proc(wanted: Vec3, moved: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let moved_sq = moved.length_squared();
    // rust: moved_sq > 1.0e-7 || wanted.length_squared() - moved_sq < 1.0e-7
}

// `SlimeBlock.stepOn`: a slow walk or slide on slime drags the horizontal
// speed (`0.4 + |dy| * 0.2`); a fast vertical speed leaves it alone.
slime_step_on_scale :: proc(velocity_y: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let abs_delta_y = velocity_y.abs();
    // rust: (abs_delta_y < 0.1).then_some(0.4 + abs_delta_y * 0.2)
}

slime_support_name :: proc(block: string, moving_moved: Maybe(string)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: block == "minecraft:slime_block" || moving_moved == Some("minecraft:slime_block")
}

// The block under an item, including `Entity.getOnPos` (~1e-5) as well as the
// friction sample (`y - 0.999999`). A piston-moved slime is `moving_piston`
// with `movedState = slime`, which has the bounce, not the moving piston.
item_support_is_slime :: proc(world: ^World, facts: ^BlockFacts, position: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let x = position.x.floor() as i32;
    // rust: let z = position.z.floor() as i32;
    // rust: let friction_y = (position.y - 0.999_999).floor() as i32;
    // rust: let on_y = (position.y - f64::from(1.0e-5_f32)).floor() as i32;
    // rust: slime_at(world, facts, x, friction_y, z)
    // rust: || (on_y != friction_y && slime_at(world, facts, x, on_y, z))
}

slime_at :: proc(world: ^World, facts: ^BlockFacts, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let block = &*facts.get(world.block(x, y, z)).name;
    // rust: let moving_moved = world
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .find(|(pos, _)| *pos == [x, y, z])
    // rust: .map(|(_, piston)| &*facts.get(piston.moved_state).name);
    // rust: slime_support_name(block, moving_moved)
}

    // rust: mod fluids;
    // rust: pub use fluids::{fluid_flow, update_entity_fluids};

    // rust: mod drop_motion_tests {
//     use super::drop_motion;
//     use horizon_core::random::{LegacyRandom, RandomSource};

    // Vanilla's own `Mth` and `LegacyRandomSource(7)` running
    // `createItemStackToDrop`'s arithmetic: three throws along the view,
    // then two scattered drops, bit for bit, then the random's next int.
drops_match_vanillas_motion_bit_for_bit :: proc() {
}
    // rust: let mut r = LegacyRandom::new(7);
    // rust: let bits = |v: [f64; 3]| v.map(|c| c.to_bits() as i64);
    // rust: let thrown = [
    // rust: (
    // rust: 0.0,
    // rust: 0.0,
    // rust: [
    // rust: -4658604453255681268,
    // rust: 4595435376155295744,
    // rust: 4598847571894135436,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: 37.5,
    // rust: -21.25,
    // rust: [
    // rust: -4627867408251048793,
    // rust: 4597245257657090048,
    // rust: 4597448471913462163,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: -123.4,
    // rust: 60.0,
    // rust: [
    // rust: 4593476083220988603,
    // rust: -4626282285467959296,
    // rust: -4631965182103987462,
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: for (yaw, pitch, want) in thrown {
    // rust: assert_eq!(
    // rust: bits(drop_motion(&mut r, yaw, pitch, false)),
    // rust: want,
    // rust: "{yaw} {pitch}"
    // rust: );
}
    // rust: let scattered = [
    // rust: [
    // rust: -4634512480041697280,
    // rust: 4596373779801702400,
    // rust: -4661085178024689664,
    // rust: ],
    // rust: [
    // rust: 4600899508711194624,
    // rust: 4596373779801702400,
    // rust: -4629159495333838848,
    // rust: ],
    // rust: ];
    // rust: for want in scattered {
    // rust: assert_eq!(bits(drop_motion(&mut r, 0.0, 0.0, true)), want);
}
    // rust: assert_eq!(r.next_int(), 357425922);
}
}

// `LivingEntity.createItemStackToDrop`'s motion for a stack thrown by an
// entity facing `yaw` and `pitch` (degrees), from that entity's random:
// `randomly` scatters it in any direction (a death's drops), else it goes
// along the view (the drop key).
    // rust: pub fn drop_motion(
    // rust: r: &mut impl horizon_core::random::RandomSource,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: randomly: bool,
    // rust: ) -> [f64; 3] {
//     use horizon_core::{
    // rust: geometry::trig::{DEG_TO_RAD, cos, sin},
    // rust: jmath,
}
    // rust: let tau = std::f32::consts::TAU;
    // rust: if randomly {
    // rust: let pow = r.next_float() * 0.5;
    // rust: let dir = f64::from(r.next_float() * tau);
    // rust: return [
    // rust: f64::from(-sin(dir) * pow),
    // rust: f64::from(0.2f32),
    // rust: f64::from(cos(dir) * pow),
    // rust: ];
}
    // rust: let (x, y) = (f64::from(pitch * DEG_TO_RAD), f64::from(yaw * DEG_TO_RAD));
    // rust: let (sin_x, cos_x, sin_y, cos_y) = (sin(x), cos(x), sin(y), cos(y));
    // rust: let dir = f64::from(r.next_float() * tau);
    // rust: let pow = f64::from(0.02 * r.next_float());
    // rust: [
    // rust: f64::from(-sin_y * cos_x * 0.3) + jmath::cos(dir) * pow,
    // rust: f64::from(-sin_x * 0.3 + 0.1 + (r.next_float() - r.next_float()) * 0.1),
    // rust: f64::from(cos_y * cos_x * 0.3) + jmath::sin(dir) * pow,
    // rust: ]
}

ItemEntity :: struct {
    // `Entity.yRot` and `xRot` (`/tp`, `/data get ... Rotation`).
    rotation: [f32,
    // When it joined its list ([`crate::join_seq`]); set by the list, not by the spawn site.
    join: crate::join_seq::JoinSeq,
    health: i32,
    fire_ticks: i32,
    id: u32,
    stack: ItemStack,
    thrower: Option<[i32,
    // `ItemEntity.target`: the only player who may pick the item up.
    target: Option<[i32,
    position: Vec3,
    previous: Vec3,
    velocity: Vec3,
    on_ground: bool,
    age: i32,
    // Signed NBT counter; widened to retain the legacy internal u32::MAX sentinel.
    pickup_delay: i64,
    bob_offset: f32,
    // `Entity.tickCount`: ticks since the item entered the level, which
    // paces `ItemEntity.mergeWithNeighbours`.
    ticks: u32,
    // `Entity.needsSync` / `syncPosition`: immediate `ServerEntity.sendChanges`
    // after a bounce or velocity jump (`> 0.1` in `ItemEntity.tick`).
    needs_sync: bool,
    // `Entity.stuckSpeedMultiplier`: set after a move by the cobweb or powder snow
    // the item is in, scales (and stops) the next one.
    stuck: Vec3,
    // `Entity.wasTouchingWater`: the last fluid push. Entering water after
    // the first tick is what splashes.
    was_touching_water: bool,
    // `Entity.noGravity` (`NoGravity` in its save): `applyGravity` does nothing.
    no_gravity: bool,
    // `Entity.verticalCollision`: the last move was stopped vertically.
    // `ServerEntity.isFullPrecisionEncodingRequired` reads it for items, whose
    // resting position is exact while a 1/4096 delta is not.
    vertical_collision: bool,
    // `Entity.horizontalCollision`: the last move was stopped on x or z.
    horizontal_collision: bool,
}
// What `Entity.doWaterSplashEffect` asks the level to do for a dropped item.
// Particles are drawn on the client (`Level.addParticle` is empty on the
// server). The sound is `Entity.playSound`, which the server broadcasts;
// `ClientLevel.playSeededSound` ignores it when the except entity is null.
ItemSplash :: enum {
    Sound {,
    at: [f64; 3],
    volume: f32,
    pitch: f32,
    // rust: },
    Particle {,
    bubble: bool,
    at: [f64; 3],
    velocity: [f64; 3],
    // rust: },
}
// `Entity.doWaterSplashEffect` for a dropped item.
ItemWater :: struct {
    item: ^'a mut ItemEntity,
    random: ^'a mut horizon_core::random::LegacyRandom,
    splash: ^'a mut F,
}
    // rust: impl<F: FnMut(ItemSplash)> horizon_world::water_splash::WaterSplashWorld for ItemWater<'_, F> {
    // rust: type Error = std::convert::Infallible;
    // rust: type Entity = ();
    // rust: type Sound = ();
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
    // rust: Ok(self.item.velocity)
}
splash_sound :: proc(self: ^Self, _: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
random_float :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.random.next_float())
}
random_double :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.random.next_double())
}
play_sound :: proc(self: ^Self, _: () {
}
    // rust: let at = [
    // rust: self.item.position.x,
    // rust: self.item.position.y,
    // rust: self.item.position.z,
    // rust: ];
    // rust: (self.splash)(ItemSplash::Sound { at, volume, pitch });
    // rust: Ok(())
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.item.position
}
width :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ItemEntity::WIDTH as f32
}
    // rust: fn particle(
    // rust: &mut self,
    // rust: kind: horizon_world::water_splash::SplashParticle,
    // rust: position: Vec3,
    // rust: velocity: Vec3,
    // rust: ) -> Result<(), Self::Error> {
    // rust: (self.splash)(ItemSplash::Particle {
    // rust: bubble: matches!(kind, horizon_world::water_splash::SplashParticle::Bubble),
    // rust: at: [position.x, position.y, position.z],
    // rust: velocity: [velocity.x, velocity.y, velocity.z],
    // rust: });
    // rust: Ok(())
}
splash_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
}
// Environment results needed by the entity owner, including lethal lava damage.
ItemEnvironmentTick :: struct {
    alive: bool,
    lava_hurt: bool,
    // `ItemStack.onDestroyed` of the damage that emptied the health: the
    // stacks the destroyed item left, which `ItemUtils.onContainerDestroyed`
    // adds to the level where it lay.
    spilled: [dynamic]ItemStack,
}
    // rust: impl ItemEnvironmentTick {
should_play_lava_hurt_sound :: proc(self: ^Self, tick: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.lava_hurt && (!self.alive || tick.is_multiple_of(10))
}
}
    // rust: impl crate::entity_rules::EntityRules for ItemEntity {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `ItemEntity.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.04
}
}
    // rust: impl crate::entity_rules::EntityRules for ExperienceOrb {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `ExperienceOrb.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.03
}
}
    // rust: impl crate::entity_rules::EntityRules for ArmorStand {
is_no_gravity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.no_gravity
}
    // `LivingEntity.getDefaultGravity`.
get_default_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.08
}
    // The code's reading of `Entity.isPushedByFluid` for a marker stand: it
    // takes no fluid push and is never in water.
is_pushed_by_fluid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.marker
}
}
// What an item's tick carries from [`ItemEntity::tick_move`] to
// [`ItemEntity::tick_settle`], across the game's bubble-column push.
ItemStep :: struct {
    old_velocity: Vec3,
    moved: bool,
}
    // rust: impl ItemEntity {
    // A whole `ItemEntity.tick` for the unit tests, in the order the game
    // runs it: fluid push, move, bubble column, settle, fluid push.
    // rust: pub(crate) fn tick(
    // rust: &mut self,
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: no_physics: bool,
    // rust: fluids: &crate::motion::FluidResources,
    // rust: entity_boxes: &[Aabb],
    // rust: border: Option<&BorderGeometry>,
    // rust: blocks: Option<&horizon_world::movement_properties::BoundMovementProperties>,
    // rust: ) -> bool {
    // rust: let (water, lava) = self.update_fluids(world, fluids);
    // rust: self.water_entry(water > 0.0, self.ticks == 0, &mut |_| {});
    // rust: let step = self.tick_move(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: no_physics,
    // rust: (water, lava),
    // rust: entity_boxes,
    // rust: border,
    // rust: blocks,
    // rust: );
    // rust: crate::motion::bubble_column_push(
    // rust: world,
    // rust: registry,
    // rust: facts,
    // rust: collision,
    // rust: self.bounds(),
    // rust: &mut self.velocity,
    // rust: );
    // rust: let alive = self.tick_settle(world, facts, no_physics, step);
    // rust: let (water, _) = self.update_fluids(world, fluids);
    // rust: self.water_entry(water > 0.0, false, &mut |_| {});
    // rust: alive
}
}
    // rust: impl ItemEntity {
WIDTH :: 0.25
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let h = Self::WIDTH / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(self.position.x - h, self.position.y, self.position.z - h),
    // rust: Vec3::new(
    // rust: self.position.x + h,
    // rust: self.position.y + Self::WIDTH,
    // rust: self.position.z + h,
    // rust: ),
    // rust: )
}
    // rust: pub fn environment_tick(
    // rust: &mut self,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: items: &crate::items::Items,
    // rust: ) -> ItemEnvironmentTick {
    // rust: let at = world.block(
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y + 0.1).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let fluid = facts.get(at).fluid;
    // rust: let fire_immune = items.resists_fire(&self.stack, "minecraft:in_fire");
    // rust: let mut spilled = Vec::new();
    // rust: if fluid == Fluid::Water || fire_immune {
    // rust: self.fire_ticks = 0;
}
    // rust: if self.fire_ticks > 0 {
    // rust: if self.fire_ticks % 20 == 0
    // rust: && fluid != Fluid::Lava
    // rust: && !items.resists_fire(&self.stack, "minecraft:on_fire")
    // rust: {
    // rust: spilled.extend(self.hurt(1).unwrap_or_default());
}
    // rust: self.fire_ticks -= 1;
}
    // rust: let mut lava_hurt = false;
    // rust: if fluid == Fluid::Lava && !fire_immune {
    // rust: self.fire_ticks = self.fire_ticks.max(300);
    // rust: if !items.resists_fire(&self.stack, "minecraft:lava") {
    // rust: spilled.extend(self.hurt(4).unwrap_or_default());
    // rust: lava_hurt = true;
}
}
    // rust: let fire_damage = crate::motion::environment::fire_contact(world, registry, self.bounds());
    // rust: if fire_damage > 0.0 && !fire_immune {
    // rust: self.fire_ticks = self.fire_ticks.max(160);
    // rust: if !items.resists_fire(&self.stack, "minecraft:in_fire") {
    // rust: spilled.extend(self.hurt(fire_damage as i32).unwrap_or_default());
}
}
        // CactusBlock.entityInside: `entity.hurt(cactus, 1.0)`. An item has no
        // hurt cooldown, so it loses 1 health every tick it touches a cactus
        // (5 health: gone in 5 ticks). Fire resistance does not help;
        // `ItemStack.canBeHurtBy` only skips it for a damage_resistant stack.
    // rust: if crate::motion::environment::cactus_contact(world, registry, self.bounds())
    // rust: && !items.resists_cactus(&self.stack)
    // rust: {
    // rust: spilled.extend(self.hurt(1).unwrap_or_default());
}
    // rust: ItemEnvironmentTick {
    // rust: alive: self.health > 0,
    // rust: lava_hurt,
    // rust: spilled,
}
}
    // `ItemEntity.hurtServer`'s health: `amount` off the health, and an item
    // whose health reaches 0 is destroyed at once (`ItemStack.onDestroyed`,
    // then `discard`), so what it held leaves it here. None while the item
    // survives; the emptied stacks otherwise.
hurt :: proc(self: ^Self, amount: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.health -= amount;
    // rust: if self.health > 0 {
    // rust: return None;
}
        // `ItemStack.onDestroyed` runs the item's own arm, and the component
        // the stack holds is the dispatch: a bundle's (`BundleItem.onDestroyed`)
        // `bundle_contents` and a container item's (`BlockItem.onDestroyed`)
        // `container`, which a mod's own item carries in the same way.
    // rust: let mut spilled = crate::bundle::destroyed(&mut self.stack);
    // rust: spilled.extend(crate::item_data::destroyed_container(&mut self.stack));
    // rust: Some(spilled)
}
    // `ItemEntity.tick` on a server: an item whose box is inside a block
    // (one placed where it lay) has no physics this tick
    // (`level.noCollision(box.deflate(1.0E-7))`).
inside_block :: proc(self: ^Self, world: ^World, collision: ^BlockCollisionRegistry<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let inner = self.bounds().deflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7));
    // rust: !crate::collisions::no_collision_empty(&mut scene, inner)
}
    // `Entity.updateFluidInteraction`: entering water after the first tick
    // runs `doWaterSplashEffect`.
    // rust: pub fn water_entry<F: FnMut(ItemSplash)>(
    // rust: &mut self,
    // rust: in_water: bool,
    // rust: first_tick: bool,
    // rust: splash: &mut F,
    // rust: ) {
    // rust: if in_water && !self.was_touching_water && !first_tick {
    // rust: let mut random = horizon_core::random::LegacyRandom::new(
    // rust: (self.id as i64)
    // rust: .wrapping_mul(0x5DEECE66D)
    // rust: .wrapping_add(self.ticks as i64),
    // rust: );
    // rust: let _ = horizon_world::water_splash::water_splash(
    // rust: &mut ItemWater {
    // rust: item: self,
    // rust: random: &mut random,
    // rust: splash,
    // rust: },
    // rust: 1_000_000,
    // rust: );
}
    // rust: self.was_touching_water = in_water;
}
    // `Entity.moveTowardsClosestSpace` from the middle of the item's box:
    // towards the nearest side of its block (north, south, west, east or
    // up) without a full collision cube, at `speed` (`nextFloat() * 0.2 +
    // 0.1`).
move_towards_closest_space :: proc(self: ^Self, world: ^World, facts: ^BlockFacts, speed: f32) {
}
    // rust: self.velocity = towards_closest_space(
    // rust: self.position,
    // rust: self.bounds(),
    // rust: self.velocity,
    // rust: world,
    // rust: facts,
    // rust: speed,
    // rust: );
}
    // `ItemEntity.tick` up to the blocks' push. The game has just run the
    // fluid push (`Entity::push_by_fluid`) and passes the heights it found;
    // it pushes by a bubble column next (`Entity::push_by_bubble_column`) and
    // then calls [`ItemEntity::tick_settle`]. `no_physics`: the item moves
    // through blocks this tick ([`ItemEntity::inside_block`]).
    // rust: pub fn tick_move(
    // rust: &mut self,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: no_physics: bool,
    // rust: (water_height, lava_height): (f64, f64),
    // rust: entity_boxes: &[Aabb],
    // rust: border: Option<&BorderGeometry>,
    // rust: blocks: Option<&horizon_world::movement_properties::BoundMovementProperties>,
    // rust: ) -> ItemStep {
    // rust: self.ticks += 1;
    // rust: self.previous = self.position;
    // rust: if self.pickup_delay > 0 && !self.has_infinite_pickup_delay() {
    // rust: self.pickup_delay -= 1;
}
    // rust: let old_velocity = self.velocity;
    // rust: let in_water = water_height > f64::from(0.1f32);
    // rust: if in_water {
            // ItemEntity.setUnderwaterMovement
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.99,
    // rust: self.velocity.y + if self.velocity.y < 0.06 { 5.0e-4 } else { 0.0 },
    // rust: self.velocity.z * 0.99,
    // rust: );
    // rust: } else if lava_height > f64::from(0.1f32) {
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.95,
    // rust: self.velocity.y + if self.velocity.y < 0.06 { 5.0e-4 } else { 0.0 },
    // rust: self.velocity.z * 0.95,
    // rust: );
    // rust: } else {
    // rust: self.velocity.y -= self.get_gravity();
}
    // rust: let horizontal = self.velocity.x * self.velocity.x + self.velocity.z * self.velocity.z;
        // ItemEntity.tick: skip move 3 of 4 ticks while grounded with no
        // horizontal speed. The idle branch still runs bubble-column push
        // (`applyEffectsFromBlocksForLastMovements`), so lift builds up and
        // the item moves on the next wake-up (#4558).
    // rust: if !self.on_ground
    // rust: || horizontal > 1.0e-5
    // rust: || self.ticks.wrapping_add(self.id).is_multiple_of(4)
    // rust: {
    // rust: let scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let mut wanted = self.velocity;
            // Entity.move: a block the item sits in (cobweb, powder snow)
            // scales this move once and stops it.
    // rust: if self.stuck.length_squared() > 1.0e-7 {
    // rust: wanted = wanted.multiply(self.stuck);
    // rust: self.stuck = Vec3::ZERO;
    // rust: self.velocity = Vec3::ZERO;
}
            // Entity.move with noPhysics: straight through, the ground as it was.
    // rust: let moved = if no_physics {
    // rust: wanted
    // rust: } else {
                // `Entity.collide`: the entities that `canBeCollidedWith` the item stop it
                // too (a boat, a minecart, a shulker, a happy ghast held still), and
                // so does the world border (`Entity.collectColliders`).
    // rust: crate::collisions::EntityCollisions {
    // rust: blocks: scene,
    // rust: entities: entity_boxes,
    // rust: border: border.map(|b| (b, [self.position.x, self.position.z])),
}
    // rust: .resolve(self.bounds(), wanted, 0.0, self.on_ground)
    // rust: .unwrap_or(Vec3::ZERO)
}
    // rust: if move_applies(wanted, moved) {
    // rust: self.position = Vec3::new(
    // rust: self.position.x + moved.x,
    // rust: self.position.y + moved.y,
    // rust: self.position.z + moved.z,
    // rust: );
}
    // rust: if !no_physics {
    // rust: self.on_ground = wanted.y < 0.0 && moved.y != wanted.y;
}
            // Entity.move: what the move was stopped on. They outlive the
            // tick, as vanilla's fields do, for the tracker that sends the
            // position at the type's update interval.
    // rust: self.vertical_collision = moved.y != wanted.y;
            // `Mth.equal` on x and z (1e-5 as a float), exact on y.
    // rust: let differs = |a: f64, b: f64| (b - a).abs() >= 9.999_999_747_378_752e-6;
    // rust: self.horizontal_collision = differs(moved.x, wanted.x) || differs(moved.z, wanted.z);
    // rust: if moved.x != wanted.x {
    // rust: self.velocity.x = 0.0;
}
    // rust: if moved.z != wanted.z {
    // rust: self.velocity.z = 0.0;
}
    // rust: if moved.y != wanted.y {
                // Entity.move restitutes instead of zeroing Y. A slime block
                // (or a moving piston carrying one) bounces a dropped item;
                // MovingPistonBlock itself has no bounceRestitution.
    // rust: let slime = item_support_is_slime(world, facts, self.position);
    // rust: self.velocity.y = vertical_collision_velocity(
    // rust: wanted.y,
    // rust: moved.y,
    // rust: ITEM_GRAVITY,
    // rust: wanted.y < 0.0,
    // rust: slime,
    // rust: );
}
            // Entity.move's last step: soul sand and honey slow the item's
            // horizontal speed. A move through blocks (noPhysics) returns
            // before it. `blocks` is None only for the isolated unit tests.
    // rust: if !no_physics && let Some(blocks) = blocks {
    // rust: let factor =
    // rust: crate::motion::block_speed_factor_at(world, blocks, self.position, None);
    // rust: self.velocity =
    // rust: horizon_world::entity_move::scale_by_block_speed(self.velocity, factor);
}
            // Entity.move -> applyEffectsFromBlocks: honey then bubble columns
            // (before air drag), matching ItemEntity.tick.
    // rust: self.apply_honey_slide(world, facts);
    // rust: self.stuck = self.stuck_multiplier(world, facts).unwrap_or(Vec3::ZERO);
    // rust: return ItemStep {
    // rust: old_velocity,
    // rust: moved: true,
}
}
        // applyEffectsFromBlocksForLastMovements: still lift/drag while idle.
    // rust: if !no_physics {
    // rust: self.slime_step_on(world, facts);
}
    // rust: ItemStep {
    // rust: old_velocity,
    // rust: moved: false,
}
}
    // The rest of `ItemEntity.tick`, after the bubble column's push: slime,
    // drag, block contact, age. Returns false when the item should be
    // removed. The game then runs the fluid push again (`ItemEntity.tick`
    // refreshes immersion after moving).
    // rust: pub fn tick_settle(
    // rust: &mut self,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: no_physics: bool,
    // rust: step: ItemStep,
    // rust: ) -> bool {
    // rust: if step.moved {
            // Entity.applyEffectsFromBlocks -> SlimeBlock.stepOn, with the
            // vertical speed the bounce just left (before the air drag).
    // rust: if !no_physics {
    // rust: self.slime_step_on(world, facts);
}
    // rust: let mut friction = 0.98;
    // rust: if self.on_ground {
    // rust: let below = world.block(
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - 0.999_999).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: friction = f64::from(facts.get(below).friction) * 0.98;
}
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * friction,
    // rust: self.velocity.y * 0.98,
    // rust: self.velocity.z * friction,
    // rust: );
    // rust: if self.on_ground && self.velocity.y < 0.0 {
    // rust: self.velocity.y *= -0.5;
}
}
    // rust: if !no_physics {
            // Entity.applyEffectsFromBlocks: stepOn, then checkInsideBlocks.
    // rust: if self.on_ground {
    // rust: let p = BlockPos::containing(self.position.add_vector(Vec3::new(
    // rust: 0.0,
    // rust: -f64::from(0.2_f32),
    // rust: 0.0,
    // rust: )));
    // rust: let state = world.block(p.x, p.y, p.z);
    // rust: crate::block_contact::emit(crate::block_contact::Event::StepOn(
    // rust: crate::block_contact::Contact {
    // rust: entity: self.id as i32,
    // rust: kind: "minecraft:item",
    // rust: block: &facts.get(state).name,
    // rust: state,
    // rust: position: p,
    // rust: },
    // rust: ));
}
    // rust: crate::block_contact::swept_inside(
    // rust: self.id as i32,
    // rust: "minecraft:item",
    // rust: self.previous,
    // rust: self.position,
    // rust: self.bounds(),
    // rust: |p| {
    // rust: let state = world.block(p.x, p.y, p.z);
    // rust: (state, &facts.get(state).name)
    // rust: },
    // rust: );
}
    // rust: if self.velocity.subtract(step.old_velocity).length_squared() > 0.01 {
    // rust: self.needs_sync = true;
}
    // rust: if self.age != i16::MIN as i32 {
    // rust: self.age += 1;
}
    // rust: self.age < 6000 && self.position.y > -128.0
}
    // `Entity.makeStuckInBlock` as `WebBlock.entityInside` and
    // `PowderSnowBlock.entityInside` call it for an item (which, unlike a
    // living entity, is stuck whatever block its feet are in): the speed
    // factor of the last such block the item's box (deflated by `1.0E-5`) is
    // in.
stuck_multiplier :: proc(self: ^Self, world: ^World, facts: ^BlockFacts) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.bounds().deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mut stuck = None;
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: match &*facts.get(world.block(x, y, z)).name {
    // rust: "minecraft:cobweb" => {
    // rust: stuck = Some(Vec3::new(0.25, f64::from(0.05_f32), 0.25));
}
    // rust: "minecraft:powder_snow" => {
    // rust: stuck = Some(Vec3::new(f64::from(0.9_f32), 1.5, f64::from(0.9_f32)));
}
    // rust: _ => {}
}
}
}
}
    // rust: stuck
}
    // `SlimeBlock.stepOn` for an item on the ground: slow vertical speed
    // drags the horizontal speed, on idle ticks too.
slime_step_on :: proc(self: ^Self, world: ^World, facts: ^BlockFacts) {
}
    // rust: if !self.on_ground {
    // rust: return;
}
    // rust: let p = BlockPos::containing(self.position.add_vector(Vec3::new(
    // rust: 0.0,
    // rust: -f64::from(0.2_f32),
    // rust: 0.0,
    // rust: )));
    // rust: if &*facts.get(world.block(p.x, p.y, p.z)).name != "minecraft:slime_block" {
    // rust: return;
}
    // rust: if let Some(scale) = slime_step_on_scale(self.velocity.y) {
    // rust: self.velocity.x *= scale;
    // rust: self.velocity.z *= scale;
}
}

    // `PistonMovingBlockEntity.causeBounce` for a dropped item. Vanilla then
    // runs `Entity.move(MoverType.PISTON)`, which leaves the ground on an
    // upward push; without that, `ItemEntity.tick` skips movement 3 of 4 ticks
    // while `onGround` with no horizontal speed and gravity eats the bounce.
piston_slime_bounce :: proc(self: ^Self, movement: Direction) {
}
    // rust: self.velocity = horizon_world::piston_push::bounce_velocity(movement, self.velocity);
    // rust: self.on_ground = false;
    // rust: self.needs_sync = true;
}
    // `HoneyBlock.entityInside` for the honey blocks this item's box is in
    // (`Entity.checkInsideBlocks`, deflated by `1.0E-5`). Slide sounds and
    // entity event 53 are skipped (`doesEntityDoHoneyBlockSlideEffects` is
    // false for an item).
apply_honey_slide :: proc(self: ^Self, world: ^World, facts: ^BlockFacts) {
}
    // rust: let b = self.bounds().deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: if &*facts.get(world.block(x, y, z)).name == "minecraft:honey_block" {
    // rust: self.honey_block_inside([x, y, z]);
}
}
}
}
}
    // `HoneyBlock.isSlidingDown` then `doSlideMovement`. `getOldDeltaY` /
    // `getNewDeltaY` wrap the stored velocity the same way they do for every
    // entity (`vy / 0.98F + 0.08`).
    // rust: pub(crate) fn honey_block_inside(&mut self, pos: [i32; 3]) {
    // rust: let old_delta_y = |dy: f64| dy / f64::from(0.98_f32) + 0.08;
    // rust: let new_delta_y = |dy: f64| (dy - 0.08) * f64::from(0.98_f32);
    // rust: let [x, y, z] = pos.map(f64::from);
    // rust: if self.on_ground
    // rust: || self.position.y > y + 0.9375 - 1.0e-7
    // rust: || old_delta_y(self.velocity.y) >= -0.08
    // rust: {
    // rust: return;
}
    // rust: let dx = (x + 0.5 - self.position.x).abs();
    // rust: let dz = (z + 0.5 - self.position.z).abs();
    // rust: let overlap = 0.4375 + Self::WIDTH / 2.0;
    // rust: if dx + 1.0e-7 <= overlap && dz + 1.0e-7 <= overlap {
    // rust: return;
}
    // rust: let v = self.velocity;
    // rust: let old = old_delta_y(v.y);
    // rust: self.velocity = if old < -0.13 {
    // rust: let factor = -0.05 / old;
    // rust: Vec3::new(v.x * factor, new_delta_y(-0.05), v.z * factor)
    // rust: } else {
    // rust: Vec3::new(v.x, new_delta_y(-0.05), v.z)
}
}
has_infinite_pickup_delay :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.pickup_delay == i64::from(i16::MAX) || self.pickup_delay == i64::from(u32::MAX)
}
    // `ItemEntity.isMergable` at `age`: a stack below its size whose pickup
    // delay isn't infinite, before its lifetime ends.
mergeable :: proc(self: ^Self, age: i32, max_stack: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.has_infinite_pickup_delay()
    // rust: && age != i16::MIN as i32
    // rust: && age < 6000
    // rust: && self.stack.count < max_stack
}
}
// The boxes that stop a dropped item (boats, minecarts, shulkers, a held-still happy ghast),
// binned by 8-block cell, so an item looks only at the ones near it: a farm with many drops and
// many vehicles checks a handful of boxes per item, not every box in the level.
ObstacleGrid :: struct {
    cells: crate::fast_hash::FxHashMap<(i32,
    boxes: [dynamic]Aabb,
}
    // rust: impl ObstacleGrid {
CELL :: 8.0
new :: proc(boxes: [dynamic]Aabb) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut cells: crate::fast_hash::FxHashMap<(i32, i32, i32), Vec<u32>> = Default::default();
    // rust: for (i, b) in boxes.iter().enumerate() {
    // rust: let (lo, hi) = Self::span(*b);
    // rust: for x in lo.0..=hi.0 {
    // rust: for y in lo.1..=hi.1 {
    // rust: for z in lo.2..=hi.2 {
    // rust: cells.entry((x, y, z)).or_default().push(i as u32);
}
}
}
}
    // rust: Self { cells, boxes }
}
span :: proc(b: Aabb) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let cell = |v: Vec3| {
    // rust: (
    // rust: (v.x / Self::CELL).floor() as i32,
    // rust: (v.y / Self::CELL).floor() as i32,
    // rust: (v.z / Self::CELL).floor() as i32,
    // rust: )
}
    // rust: (cell(b.min_position()), cell(b.max_position()))
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.boxes.is_empty()
}
    // The boxes meeting `area` (`getEntityCollisions`'s query box), in the order they were given.
near :: proc(self: ^Self, area: Aabb, out: ^[dynamic]Aabb) {
}
    // rust: out.clear();
    // rust: if self.boxes.is_empty() {
    // rust: return;
}
    // rust: let (lo, hi) = Self::span(area);
    // rust: let mut found: Vec<u32> = Vec::new();
    // rust: for x in lo.0..=hi.0 {
    // rust: for y in lo.1..=hi.1 {
    // rust: for z in lo.2..=hi.2 {
    // rust: if let Some(list) = self.cells.get(&(x, y, z)) {
    // rust: found.extend(list);
}
}
}
}
    // rust: found.sort_unstable();
    // rust: found.dedup();
    // rust: out.extend(
    // rust: found
    // rust: .into_iter()
    // rust: .map(|i| self.boxes[i as usize])
    // rust: .filter(|b| b.intersects(area)),
    // rust: );
}
}

// Dropped items by block cell, for `ItemEntity.mergeWithNeighbours`'s
// search around an item. Holds indexes into the tick's item list.
ItemCells :: struct {
    cells: crate::fast_hash::FxHashMap<(i32,
}
    // rust: impl ItemCells {
new :: proc(items: ^[ItemEntity]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut cells = Self::default();
    // rust: for (i, item) in items.iter().enumerate() {
    // rust: cells.add(i, item.position);
}
    // rust: cells
}
cell :: proc(p: Vec3) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32)
}
add :: proc(self: ^Self, i: uint, at: Vec3) {
}
    // rust: self.cells.entry(Self::cell(at)).or_default().push(i as u32);
}
remove :: proc(self: ^Self, i: uint, at: Vec3) {
}
    // rust: if let Some(list) = self.cells.get_mut(&Self::cell(at)) {
    // rust: list.retain(|&j| j as usize != i);
}
}
moved :: proc(self: ^Self, i: uint, from: Vec3, to: Vec3) {
}
    // rust: if Self::cell(from) != Self::cell(to) {
    // rust: self.remove(i, from);
    // rust: self.add(i, to);
}
}
    // The items whose cells could hold a box meeting `area`, in the order
    // they were added (vanilla lists a section's entities in the order they
    // entered it).
near :: proc(self: ^Self, area: Aabb, out: ^[dynamic]u32) {
}
    // rust: out.clear();
        // An item's box reaches 0.125 sideways and 0.25 up from its position.
    // rust: let (min, max) = (area.min_position(), area.max_position());
    // rust: let (lo, hi) = (
    // rust: Self::cell(Vec3::new(min.x - 0.125, min.y - 0.25, min.z - 0.125)),
    // rust: Self::cell(Vec3::new(max.x + 0.125, max.y, max.z + 0.125)),
    // rust: );
    // rust: for x in lo.0..=hi.0 {
    // rust: for y in lo.1..=hi.1 {
    // rust: for z in lo.2..=hi.2 {
    // rust: if let Some(list) = self.cells.get(&(x, y, z)) {
    // rust: out.extend_from_slice(list);
}
}
}
}
    // rust: out.sort_unstable();
}
}
// `ItemEntity.mergeWithNeighbours` for `items[i]`, which has just moved in
// its tick (its `age` already counts this tick; vanilla's doesn't yet): each
// mergeable item whose box meets this one's grown by 0.5 sideways takes this
// stack or gives it its own, the smaller into the larger
// (`ItemEntity.tryToMerge`), until this item is used up. An emptied item is
// marked in `removed`.
    // rust: pub fn merge_with_neighbours(
    // rust: items: &mut [ItemEntity],
    // rust: removed: &mut [bool],
    // rust: cells: &mut ItemCells,
    // rust: i: usize,
    // rust: max_stack: &dyn Fn(&ItemStack) -> u32,
    // rust: ) {
    // rust: let age = |items: &[ItemEntity], j: usize| {
    // rust: if j == i && items[j].age != i16::MIN as i32 {
    // rust: items[j].age - 1
    // rust: } else {
    // rust: items[j].age
}
}
    // rust: if removed[i] || !items[i].mergeable(age(items, i), max_stack(&items[i].stack)) {
    // rust: return;
}
    // rust: let area = items[i].bounds().inflate(Vec3::new(0.5, 0.0, 0.5));
    // rust: let mut near = Vec::new();
    // rust: cells.near(area, &mut near);
    // rust: for j in near {
    // rust: let j = j as usize;
    // rust: if j == i
    // rust: || removed[j]
    // rust: || !items[j].bounds().intersects(area)
    // rust: || !items[j].mergeable(age(items, j), max_stack(&items[j].stack))
    // rust: {
    // rust: continue;
}
        // ItemEntity.areMergable: both fit one stack of the same item and components.
    // rust: let (this, other) = (&items[i].stack, &items[j].stack);
    // rust: if items[i].target != items[j].target
    // rust: || this.count + other.count > max_stack(other)
    // rust: || !this.same_item_same_components(other)
    // rust: {
    // rust: continue;
}
    // rust: let (to, from) = if other.count < this.count {
    // rust: (i, j)
    // rust: } else {
    // rust: (j, i)
}
        // ItemEntity.merge(toStack, fromStack, 64).
        // A component limit above 64 permits an overstacked target. Vanilla's
        // signed room then moves the excess back into the source stack.
    // rust: let room =
    // rust: i64::from(max_stack(&items[to].stack).min(64)) - i64::from(items[to].stack.count);
    // rust: let moved = room.min(i64::from(items[from].stack.count));
    // rust: items[to].stack.count = (i64::from(items[to].stack.count) + moved) as u32;
    // rust: items[from].stack.count = (i64::from(items[from].stack.count) - moved) as u32;
    // rust: let (delay, from_age, to_age) =
    // rust: (items[from].pickup_delay, age(items, from), age(items, to));
    // rust: let to_item = &mut items[to];
    // rust: to_item.pickup_delay = to_item.pickup_delay.max(delay);
        // This item's age goes up once its tick ends.
    // rust: to_item.age = to_age.min(from_age) + i32::from(to == i);
    // rust: if items[from].stack.count == 0 {
    // rust: removed[from] = true;
    // rust: cells.remove(from, items[from].position);
}
    // rust: if removed[i] {
    // rust: return;
}
}
}
// `ExperienceOrbRenderer.submit`'s billboard before its 0.3 scale, in the
// order of its four `vertex` calls (bottom left, bottom right, top right, top
// left). The quad is a whole block tall about the orb's centre and hangs a
// quarter of it below.
ORB_QUAD :: [[-0.5, -0.25], [0.5, -0.25], [0.5, 0.75], [-0.5, 0.75]]
// `poseStack.scale(0.3F, 0.3F, 0.3F)`.
ORB_QUAD_SCALE :: 0.3
// ExperienceOrb: gravity 0.03, homing towards the player within 8 blocks.
ExperienceOrb :: struct {
    // `Entity.yRot` and `xRot` (`/tp`, `/data get ... Rotation`).
    rotation: [f32,
    // When it joined its list ([`crate::join_seq`]); set by the list, not by the spawn site.
    join: crate::join_seq::JoinSeq,
    // The entity id servers track it by.
    id: u32,
    position: Vec3,
    previous: Vec3,
    velocity: Vec3,
    value: u32,
    age: u32,
    on_ground: bool,
    // `ExperienceOrb.count`: orbs merged into this one; each pickup gives
    // `value` once and takes one off.
    count: u32,
    // `Entity.tickCount`, which paces `ExperienceOrb.scanForMerges`.
    ticks: u32,
    // `ExperienceOrb.health`: damage wears it down from 5 (`hurtServer`).
    health: i32,
    // `Entity.noGravity`: `ExperienceOrb.tick`'s `applyGravity` does nothing.
    no_gravity: bool,
}
    // rust: impl ExperienceOrb {
    // `ExperienceOrb.hurtServer`: the damage comes off the health as an
    // `int`; an orb at 0 or below is discarded. True when it is gone.
hurt :: proc(self: ^Self, damage: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.health = (self.health as f32 - damage) as i32;
    // rust: self.health <= 0
}
    // The box of an orb whose `position` (the bottom of the box) is `at`.
box_at :: proc(at: Vec3) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let h = 0.25;
    // rust: Aabb::new(
    // rust: Vec3::new(at.x - h, at.y, at.z - h),
    // rust: Vec3::new(at.x + h, at.y + 0.5, at.z + h),
    // rust: )
}
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Self::box_at(self.position)
}
    // `Entity.unstuckIfPossible`, which `ExperienceOrb`'s constructor runs as
    // `if (!level.noCollision(box)) unstuckIfPossible(box.getSize())`: the free
    // spot nearest the box's centre, searched in a cube of the box's size
    // around it. `None` when the box is already free (the orb then keeps its
    // exact position) or when nothing free is that close. `shape(p)` is the
    // block's collision shape at `p`, in world coordinates.
    // rust: pub fn unstuck(
    // rust: at: Vec3,
    // rust: border: &BorderBounds,
    // rust: mut shape: impl FnMut(BlockPos) -> Option<VoxelShape>,
    // rust: ) -> Option<Vec3> {
    // rust: let bounds = Self::box_at(at);
    // rust: let size = bounds.average_size();
    // rust: let lo = bounds.min_position();
    // rust: let cells = |v: f64| (v - 1.0e-7).floor() as i32 - 1..=(v + 1.0e-7).floor() as i32 + 1;
        // noCollision(box): a block shape reaching into it leaves the orb stuck.
    // rust: let mut stuck = false;
    // rust: 'cells: for x in cells(lo.x) {
    // rust: for y in cells(lo.y) {
    // rust: for z in cells(lo.z) {
    // rust: if shape(BlockPos::new(x, y, z))
    // rust: .is_some_and(|s| s.boxes().iter().any(|b| b.intersects(bounds)))
    // rust: {
    // rust: stuck = true;
    // rust: break 'cells;
}
}
}
}
    // rust: if !stuck {
    // rust: return None;
}
        // `AABB.ofSize(center, size, size, size)`: where the box's centre may
        // go, a cube of the box's mean size around its centre.
    // rust: let allowed = Aabb::of_size(bounds.center(), Vec3::new(size, size, size));
    // rust: find_free_position(allowed, bounds.center(), bounds.size(), border, shape)
    // rust: .map(|p| p.subtract(Vec3::new(0.0, bounds.size().y / 2.0, 0.0)))
}
    // `ExperienceOrb.canMerge(orb, id, value)` for an orb that is not removed:
    // the same value and ids a multiple of 40 apart.
can_merge :: proc(self: ^Self, id: u32, value: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.value == value && (self.id as i32).wrapping_sub(id as i32) % 40 == 0
}
    // ExperienceOrb.getExperienceValue: the largest orb size not above `value`.
split :: proc(value: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: [2477, 1237, 617, 307, 149, 73, 37, 17, 7, 3, 1]
    // rust: .into_iter()
    // rust: .find(|&v| value >= v)
    // rust: .unwrap_or(1)
}
    // ExperienceOrb.getIcon
icon :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self.value {
    // rust: 2477.. => 10,
    // rust: 1237.. => 9,
    // rust: 617.. => 8,
    // rust: 307.. => 7,
    // rust: 149.. => 6,
    // rust: 73.. => 5,
    // rust: 37.. => 4,
    // rust: 17.. => 3,
    // rust: 7.. => 2,
    // rust: 3.. => 1,
    // rust: _ => 0,
}
}
    // `Entity.getLightProbePosition`: the block an entity is lit from is the
    // one its eye is in. An orb's box is half a block, so its eye is
    // `0.5 * 0.85` above its feet (`EntityDimensions.defaultEyeHeight`).
light_probe_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.position.y + 0.5 * 0.85
}
    // `ExperienceOrbRenderer.getBlockLightLevel` over `EntityRenderer`'s
    // packing: the level's block light raised by 7 and clamped, the sky
    // light unchanged. `light` is the level's packed light.
render_light :: proc(self: ^Self, light: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let block = ((light & 15) + 7).clamp(0, 15);
    // rust: let sky = light >> 4;
    // rust: (u32::try_from(sky).unwrap_or(0) * 16) | ((u32::try_from(block).unwrap_or(15) * 16) << 8)
}
    // `ExperienceOrb.setUnderwaterMovement`: buoyancy and drag before moving.
set_underwater_movement :: proc(self: ^Self) {
}
        // Vanilla widens float constants before applying double arithmetic.
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * f64::from(0.99_f32),
    // rust: (self.velocity.y + f64::from(5.0e-4_f32)).min(f64::from(0.06_f32)),
    // rust: self.velocity.z * f64::from(0.99_f32),
    // rust: );
}
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: player: Option<[f64; 3]>,
    // rust: server: bool,
    // rust: next_float: &mut dyn FnMut() -> f32,
    // rust: border: Option<&BorderGeometry>,
    // rust: fluids: &crate::motion::FluidResources,
    // rust: on_sound: &mut dyn FnMut([f64; 3], f32),
    // rust: ) -> bool {
    // rust: self.ticks += 1;
    // rust: self.previous = self.position;
    // rust: self.update_fluids(world, fluids);
    // rust: let block = world.block(
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let bounds = self.bounds();
    // rust: let mut scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
        // `boolean colliding = !level.noCollision(getBoundingBox())`: an orb
        // inside blocks takes no gravity until it is pushed out below.
    // rust: let colliding = !crate::collisions::no_collision_empty(&mut scene, bounds);
    // rust: if facts.get(block).fluid == Fluid::Water {
    // rust: self.set_underwater_movement();
    // rust: } else if !colliding {
    // rust: self.velocity.y -= self.get_gravity();
}
    // rust: if facts.get(block).fluid == Fluid::Lava {
            // ExperienceOrb.tick: lava throws the orb back out.
    // rust: self.velocity = Vec3::new(
    // rust: f64::from((next_float() - next_float()) * 0.2),
    // rust: f64::from(0.2f32),
    // rust: f64::from((next_float() - next_float()) * 0.2),
    // rust: );
}
    // rust: if let Some(p) = player {
    // rust: let d = [
    // rust: (p[0] - self.position.x) / 8.0,
    // rust: (p[1] - self.position.y) / 8.0,
    // rust: (p[2] - self.position.z) / 8.0,
    // rust: ];
    // rust: let length = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: let power = 1.0 - length;
    // rust: if power > 0.0 && length > 1e-6 {
    // rust: let power = power * power;
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x + d[0] / length * power * 0.1,
    // rust: self.velocity.y + d[1] / length * power * 0.1,
    // rust: self.velocity.z + d[2] / length * power * 0.1,
    // rust: );
}
}
    // rust: if player.is_none() && server && colliding {
            // `followingPlayer == null && !level().isClientSide() && colliding`: an orb that would still
            // be stuck at its next position gets
            // `Entity.moveTowardsClosestSpace`, a nudge towards the nearest
            // free side of its block.
    // rust: if !crate::collisions::no_collision_empty(&mut scene, bounds.move_by(self.velocity)) {
    // rust: let speed = next_float() * 0.2 + 0.1;
    // rust: self.move_towards_closest_space(world, facts, speed);
}
}
        // `double fallSpeed = getDeltaMovement().y`, taken after the stuck
        // push and before the move.
    // rust: let wanted = self.velocity;
        // Entity.collide: the world border's walls stop the orb too.
    // rust: let border = border.map(|b| (b, [self.position.x, self.position.z]));
    // rust: let moved = scene
    // rust: .resolve_in_border(bounds, wanted, 0.0, self.on_ground, border)
    // rust: .unwrap_or(Vec3::ZERO);
    // rust: self.position = Vec3::new(
    // rust: self.position.x + moved.x,
    // rust: self.position.y + moved.y,
    // rust: self.position.z + moved.z,
    // rust: );
    // rust: self.on_ground = wanted.y < 0.0 && moved.y != wanted.y;
        // Entity.move's restituteMovementAfterCollisions, an orb's bounciness
        // 0: each collided axis's velocity is zeroed — x and z by Mth.equal's
        // 1.0E-5, y exactly.
    // rust: if (wanted.x - moved.x).abs() >= 1.0e-5 {
    // rust: self.velocity.x = 0.0;
}
    // rust: if (wanted.z - moved.z).abs() >= 1.0e-5 {
    // rust: self.velocity.z = 0.0;
}
    // rust: if moved.y != wanted.y {
    // rust: self.velocity.y = 0.0;
}
        // ExperienceOrb.tick applies block effects after moving, before drag.
    // rust: let discarded =
    // rust: server && self.apply_lava_contact_damage(world, fluids, wanted, next_float, on_sound);
        // `float friction = getAirDrag()` (0.98F), the ground's block
        // friction multiplied in as a float, widened once for the scale.
    // rust: let mut friction = 0.98_f32;
    // rust: if self.on_ground {
    // rust: let below = world.block(
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - 0.999_999).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: friction *= facts.get(below).friction;
}
    // rust: let friction = f64::from(friction);
        // The drag scales every axis by the same friction, the ground's
        // block friction included.
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * friction,
    // rust: self.velocity.y * friction,
    // rust: self.velocity.z * friction,
    // rust: );
        // `if (verticalCollisionBelow && fallSpeed < -getGravity())`: the
        // landing bounce is 0.4 of the pre-move speed, not a fixed
        // restitution.
    // rust: if self.on_ground && wanted.y < -0.03 {
    // rust: self.velocity.y = -wanted.y * 0.4;
}
    // rust: self.age += 1;
    // rust: !discarded && self.age < 6000
}
    // `LavaFluid.entityInside` -> `Entity.lavaHurt`: four damage on the
    // server, through the orb's existing hurt/discard policy, playing the generic
    // burn sound (`minecraft:entity.generic.burn`, volume 0.4, pitch 2.0 + random * 0.4)
    // on each hurt contact. This is separate from the lava impulse at the start of the tick.
    // rust: pub fn apply_lava_contact_damage(
    // rust: &mut self,
    // rust: world: &World,
    // rust: fluids: &crate::motion::FluidResources,
    // rust: wanted: Vec3,
    // rust: next_float: &mut dyn FnMut() -> f32,
    // rust: on_sound: &mut dyn FnMut([f64; 3], f32),
    // rust: ) -> bool {
    // rust: if self.health <= 0 {
    // rust: return true;
}
    // rust: let contacts = orb_lava_contacts(self.previous, self.position, wanted, |p| {
    // rust: let fluid = fluids.fluid(world.block(p.x, p.y, p.z));
    // rust: if !fluid
    // rust: .kind()
    // rust: .same_family(horizon_world::fluid::FluidKind::Lava)
    // rust: {
    // rust: return None;
}
    // rust: let above = fluids.fluid(world.block(p.x, p.y + 1, p.z));
    // rust: Some(if fluid.kind().same_family(above.kind()) {
    // rust: 1.0
    // rust: } else {
    // rust: f64::from(fluid.own_height())
    // rust: })
    // rust: });
    // rust: for _ in 0..contacts {
    // rust: let dead = self.hurt(4.0);
    // rust: let pitch = 2.0 + next_float() * 0.4;
    // rust: on_sound([self.position.x, self.position.y, self.position.z], pitch);
    // rust: if dead {
    // rust: return true;
}
}
    // rust: false
}
    // `Entity.moveTowardsClosestSpace` from the middle of the orb's box:
    // towards the nearest side of its block (north, south, west, east or
    // up) without a full collision cube, at `speed` (the orb's own
    // random, `nextFloat() * 0.2 + 0.1`).
move_towards_closest_space :: proc(self: ^Self, world: ^World, facts: ^BlockFacts, speed: f32) {
}
    // rust: self.velocity = towards_closest_space(
    // rust: self.position,
    // rust: self.bounds(),
    // rust: self.velocity,
    // rust: world,
    // rust: facts,
    // rust: speed,
    // rust: );
}
}

// `Entity.moveTowardsClosestSpace` from the middle of an entity's box
// (`bounds`, its feet at `position`): the velocity pushed towards the
// nearest side of its block (north, south, west, east or up) without a full
// collision cube, at `speed` (`nextFloat() * 0.2 + 0.1`). Items and
// experience orbs share it.
    // rust: fn towards_closest_space(
    // rust: position: Vec3,
    // rust: bounds: Aabb,
    // rust: velocity: Vec3,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: speed: f32,
    // rust: ) -> Vec3 {
    // rust: let at = Vec3::new(
    // rust: position.x,
    // rust: (bounds.min_position().y + bounds.max_position().y) / 2.0,
    // rust: position.z,
    // rust: );
    // rust: let pos = [
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ];
    // rust: let delta = [
    // rust: at.x - f64::from(pos[0]),
    // rust: at.y - f64::from(pos[1]),
    // rust: at.z - f64::from(pos[2]),
    // rust: ];
    // (axis, step): NORTH, SOUTH, WEST, EAST, UP.
    // rust: let mut closest = (1, 1);
    // rust: let mut nearest = f64::MAX;
    // rust: for (axis, step) in [(2, -1), (2, 1), (0, -1), (0, 1), (1, 1)] {
    // rust: let mut n = pos;
    // rust: n[axis] += step;
    // rust: if !facts.get(world.block(n[0], n[1], n[2])).full_collision {
    // rust: let d = if step > 0 {
    // rust: 1.0 - delta[axis]
    // rust: } else {
    // rust: delta[axis]
}
    // rust: if d < nearest {
    // rust: nearest = d;
    // rust: closest = (axis, step);
}
}
}
    // rust: let push = f64::from(closest.1 as f32 * speed);
    // rust: let v = velocity.scale(0.75);
    // rust: match closest.0 {
    // rust: 0 => Vec3::new(push, v.y, v.z),
    // rust: 1 => Vec3::new(v.x, push, v.z),
    // rust: _ => Vec3::new(v.x, v.y, push),
}
}
// Player experience (Player.giveExperiencePoints / getXpNeededForNextLevel).
Experience :: struct {
    level: i32,
    progress: f32,
    total: i32,
}
    // rust: impl Experience {
    // `Player.getBaseExperienceReward`: keep-inventory and spectators drop none.
death_reward :: proc(self: ^Self, keep: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if keep {
    // rust: 0
    // rust: } else {
    // rust: self.level.wrapping_mul(7).clamp(0, 100) as u32
}
}
    // `ServerPlayer.restoreFrom`: only keep-inventory and spectators retain XP.
respawn :: proc(self: ^Self, keep: bool) {
}
    // rust: if !keep {
    // rust: *self = Self::default();
}
}
needed :: proc(level: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if level >= 30 {
    // rust: 112 + (level - 30) * 9
    // rust: } else if level >= 15 {
    // rust: 37 + (level - 15) * 5
    // rust: } else {
    // rust: 7 + level * 2
}
}
    // Returns the first multiple of 5 the player reached, where each level
    // gained would play the level-up sound (`Player.giveExperienceLevels`).
give :: proc(self: ^Self, points: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut sound_level = None;
    // rust: self.progress += points as f32 / Self::needed(self.level) as f32;
    // rust: self.total = self.total.saturating_add(points).max(0);
    // rust: while self.progress >= 1.0 {
    // rust: self.progress = (self.progress - 1.0) * Self::needed(self.level) as f32;
    // rust: self.level += 1;
    // rust: if self.level % 5 == 0 {
    // rust: sound_level.get_or_insert(self.level);
}
    // rust: self.progress /= Self::needed(self.level) as f32;
}
    // rust: sound_level
}
}

// A player's `Entity.tickCount` and `Player.lastLevelUpTime`. This state belongs
// to the player entity, not the level or the server's clock.
LevelUpSound :: struct {
    ticks: i32,
    last: i32,
}

    // rust: impl LevelUpSound {
    // `Entity.commonTick`: called once for this player, including spectators.
tick :: proc(self: ^Self) {
}
    // rust: self.ticks = self.ticks.wrapping_add(1);
}

    // `Player.giveExperienceLevels`: return the sound's volume and start its
    // cooldown when a positive change lands on a fifth level.
give_levels :: proc(self: ^Self, amount: i32, level: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if amount > 0 && level % 5 == 0 && (self.last as f32) < self.ticks as f32 - 100.0 {
    // rust: self.last = self.ticks;
    // rust: Some((if level > 30 { 1.0 } else { level as f32 / 30.0 }) * 0.75)
    // rust: } else {
    // rust: None
}
}
}

    // rust: mod level_up_sound {
//     use super::LevelUpSound;

players_have_independent_ages_and_cooldowns :: proc() {
}
    // rust: let mut a = LevelUpSound::default();
    // rust: let mut b = LevelUpSound::default();
    // rust: for _ in 0..100 {
    // rust: a.tick();
    // rust: b.tick();
}
    // rust: assert_eq!(a.give_levels(1, 5), None);
    // rust: a.tick();
    // rust: b.tick();
    // rust: assert_eq!(a.give_levels(1, 5), Some(0.125));
    // rust: assert_eq!(b.give_levels(1, 10), Some(0.25));
    // rust: assert_eq!(a.give_levels(1, 10), None);
    // rust: for _ in 0..100 {
    // rust: a.tick();
}
    // rust: assert_eq!(a.give_levels(1, 30), None);
    // rust: a.tick();
    // rust: assert_eq!(a.give_levels(1, 30), Some(0.75));
    // rust: let mut respawned = LevelUpSound::default();
    // rust: assert_eq!(respawned.give_levels(1, 35), None);
    // rust: for _ in 0..101 {
    // rust: respawned.tick();
}
    // rust: assert_eq!(respawned.give_levels(-1, 35), None);
    // rust: assert_eq!(respawned.give_levels(1, 34), None);
    // rust: assert_eq!(respawned.give_levels(1, 35), Some(0.75));
}
}

// A painting (`Painting`, a `HangingEntity`): the block it hangs in, the
// 2D data value of the direction it faces, and its variant.
Painting :: struct {
    id: u32,
    pos: [i32,
    // Direction.get2DDataValue: south 0, west 1, north 2, east 3.
    facing: u8,
    variant: std::sync::^str,
    width: i32,
    height: i32,
    // BlockAttachedEntity.checkInterval.
    check_interval: u32,
}
    // rust: impl Painting {
step :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [[0, 0, 1], [-1, 0, 0], [0, 0, -1], [1, 0, 0]][usize::from(self.facing & 3)]
}
    // Direction.getCounterClockWise (the painting's left as it faces out).
left :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [[1, 0, 0], [0, 0, 1], [-1, 0, 0], [0, 0, -1]][usize::from(self.facing & 3)]
}
    // Painting.calculateBoundingBox: (min, max).
bounds :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let s = self.step().map(f64::from);
    // rust: let l = self.left().map(f64::from);
    // rust: let off = |n: i32| if n % 2 == 0 { 0.5 } else { 0.0 };
    // rust: let (h, v) = (off(self.width), off(self.height));
    // rust: let c = [
    // rust: f64::from(self.pos[0]) + 0.5 - s[0] * 0.46875 + l[0] * h,
    // rust: f64::from(self.pos[1]) + 0.5 + v,
    // rust: f64::from(self.pos[2]) + 0.5 - s[2] * 0.46875 + l[2] * h,
    // rust: ];
    // rust: let along_x = s[0] != 0.0;
    // rust: let size = [
    // rust: if along_x {
    // rust: 0.0625
    // rust: } else {
    // rust: f64::from(self.width)
    // rust: },
    // rust: f64::from(self.height),
    // rust: if along_x {
    // rust: f64::from(self.width)
    // rust: } else {
    // rust: 0.0625
    // rust: },
    // rust: ];
    // rust: (
    // rust: std::array::from_fn(|i| c[i] - size[i] / 2.0),
    // rust: std::array::from_fn(|i| c[i] + size[i] / 2.0),
    // rust: )
}
}
// The `DyeColor` ordinal of a colour name (`DyeColor.byName`), white when
// the name is unknown.
dye_index :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: crate::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|n| *n == name)
    // rust: .unwrap_or(0) as u8
}
// A cushion (`Cushion`, a `BlockAttachedEntity`): a 1 x 0.25 block pillow
// that seats a player. It sits on the top face of a block, at the clicked
// height, and is coloured by its `DyeColor`.
Cushion :: struct {
    id: u32,
    // `Entity.position`: the bottom centre of the cushion.
    position: Vec3,
    // `BlockAttachedEntity.pos` (the saved `block_pos`).
    pos: [i32,
    yaw: f32,
    // `DyeColor` ordinal: white 0, orange 1, ..., black 15.
    color: u8,
    // BlockAttachedEntity.ticksSinceLastCheck.
    check_interval: u32,
    // `Entity.getCustomName` (`CustomName`), copied onto the dropped cushion.
    custom_name: Maybe(horizon_world::nbt::Tag),
}
    // rust: impl Cushion {
    // `Entity.makeBoundingBox`: x and z half a block out, y to y + 0.25.
bounds :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.position;
    // rust: (
    // rust: [p.x - 0.5, p.y, p.z - 0.5],
    // rust: [p.x + 0.5, p.y + 0.25, p.z + 0.5],
    // rust: )
}
    // The `DyeColor` name of the cushion.
color_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: crate::mobs::render::DYE_NAMES[usize::from(self.color.min(15))]
}
    // `Cushion.getCushionItemStackWithData`: the matching coloured item.
item :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("minecraft:{}_cushion", self.color_name())
}
    // `Cushion.getCushionItemStackWithData`: the coloured item with
    // `DataComponents.CUSTOM_NAME` from `getCustomName`, as the item frame
    // beside it does.
item_stack_with_data :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut stack = ItemStack::new(&self.item(), 1);
    // rust: if let Some(name) = &self.custom_name {
    // rust: stack.data_mut().custom_name = Some(name.clone());
}
    // rust: stack
}
    // `Cushion.interact`'s seat: the vehicle's PASSENGER attachment
    // `(0, 0.25, 0)` less the player's `(0, 0.6, 0)`.
seat :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(self.position.x, self.position.y - 0.35, self.position.z)
}
    // `Entity.getDismountLocationForPassenger`: on top of the cushion.
dismount :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(self.position.x, self.position.y + 0.25, self.position.z)
}
}
// An item frame or glow item frame (`ItemFrame`).
ItemFrame :: struct {
    id: u32,
    pos: [i32,
    // Direction.get3DDataValue: down 0, up 1, north 2, south 3, west 4, east 5.
    facing: u8,
    glow: bool,
    item: Maybe(crate::items::ItemStack),
    // 0..8, in 45 degree steps.
    rotation: u8,
    drop_chance: f32,
    fixed: bool,
    invisible: bool,
    check_interval: u32,
    // `Entity.getCustomName` (`CustomName`), copied onto the dropped frame.
    custom_name: Maybe(horizon_world::nbt::Tag),
}
    // rust: impl ItemFrame {
step :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ][usize::from(self.facing.min(5))]
}
kind :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.glow {
    // rust: "minecraft:glow_item_frame"
    // rust: } else {
    // rust: "minecraft:item_frame"
}
}
    // ItemFrame.createBoundingBox (without a framed map): (min, max).
bounds :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let s = self.step().map(f64::from);
    // rust: let c: [f64; 3] = std::array::from_fn(|i| f64::from(self.pos[i]) + 0.5 - s[i] * 0.46875);
    // rust: let size: [f64; 3] = std::array::from_fn(|i| if s[i] != 0.0 { 0.0625 } else { 0.75 });
    // rust: (
    // rust: std::array::from_fn(|i| c[i] - size[i] / 2.0),
    // rust: std::array::from_fn(|i| c[i] + size[i] / 2.0),
    // rust: )
}
    // `ItemFrame.getFrameItemStackWithData`: `getFrameItemStack` (a glow
    // frame's own item), then `DataComponents.CUSTOM_NAME` from
    // `getCustomName`.
item_stack_with_data :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut item_stack = ItemStack::new(self.kind(), 1);
    // rust: if let Some(name) = &self.custom_name {
    // rust: item_stack.data_mut().custom_name = Some(name.clone());
}
    // rust: item_stack
}
}
// An armor stand (`ArmorStand`).
ArmorStand :: struct {
    // `Entity.firstTick`: command equipment events wait for an actual entity tick.
    first_tick: bool,
    // `Entity.xRot`: kept for `/tp` and `Rotation`; the kind turns only in yaw.
    pitch: f32,
    // When it joined its list ([`crate::join_seq`]); set by the list, not by the spawn site.
    join: crate::join_seq::JoinSeq,
    fire_ticks: i32,
    health: f32,
    id: u32,
    position: Vec3,
    // `Entity.xo`, `yo`, `zo`: the position at the start of the tick, which
    // the renderer blends toward `position` by the partial tick.
    previous: Vec3,
    velocity: Vec3,
    on_ground: bool,
    // `yRot`, which the body follows (`ArmorStand.tickHeadTurn`: `yBodyRot`).
    yaw: f32,
    // `yBodyRotO`: the body's yaw at the start of the tick.
    previous_yaw: f32,
    // mainhand, offhand, feet, legs, chest, head (EquipmentSlot order).
    equipment: [Maybe(crate::items::ItemStack),
    small: bool,
    show_arms: bool,
    no_base_plate: bool,
    invisible: bool,
    marker: bool,
    // `Entity.isNoGravity` (`NoGravity` in the save). `ArmorStand.hasPhysics`
    // is false with it, as with `Marker`: `travel` does nothing, so the stand
    // never moves, and the blocks it stands in do not touch it.
    no_gravity: bool,
    // `CustomName`: the text of a hologram.
    custom_name: Maybe(crate::text::Text),
    // `CustomNameVisible`.
    name_visible: bool,
    // Game time of the last hit (the wobble and the second-hit window).
    last_hit: i64,
    // `DATA_HEAD_POSE` to `DATA_RIGHT_LEG_POSE`: head, body, left arm, right
    // arm, left leg, right leg, in degrees (`POSE_KEYS` order).
    pose: [[f32,
    // `Entity.vehicle` on a server's client (`SetPassengers`): the mob it
    // rides, which seats it every tick (`positionRider`), as NPC plugins hang
    // a second name over a player's head.
    vehicle: Maybe(u32),
    // `ArmorStand.disabledSlots`: bit `filterFlag` locks a slot, bit
    // `filterFlag + 8` takes from it and bit `filterFlag + 16` puts into it.
    disabled_slots: i32,
    // Server-only `LivingEntity.lastPos` for location-based enchantments.
    enchantment_block: Maybe(BlockPos),
    // `Entity.fallDistance`, also used by `LivingEntity.checkFallDamage`'s landing callback.
    // Each downward movement is narrowed to float before adding to this double.
    enchantment_fall_distance: f64,
    // Last equipment seen by `collectEquipmentChanges`; not saved to NBT.
    enchantment_equipment: [Maybe(ItemStack),
    // `Entity.mainSupportingBlockPos` after the last move.
    support: horizon_world::ground_support::GroundState,
    // Its `AttributeMap` holds a `movement_speed` instance, which
    // `AttributeMap.pack` saves. `LivingEntity.aiStep`'s `removeFrost` makes it
    // (`getAttribute`) on the stand's first server tick, and a save that lists
    // it loads it back, so a stand summoned this tick has none yet.
    speed_instance: bool,
}
// The fluid a stand travels in (`LivingEntity.travelInFluid`: water first,
// then lava), from the heights `Entity::push_by_fluid` measured.
StandMedium :: enum {
    Air,
    Water,
    // `shallow`: `isInShallowFluid(LAVA)`, the lava is no deeper than
    // `getFluidJumpThreshold` (0.4 for a stand, whose eyes are above 0.4).
    Lava {,
    shallow: bool,
    // rust: },
}
    // rust: impl StandMedium {
from_heights :: proc(water_height: f64, lava_height: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if water_height > 0.0 {
    // rust: Self::Water
    // rust: } else if lava_height > 0.0 {
    // rust: Self::Lava {
    // rust: shallow: lava_height <= 0.4,
}
    // rust: } else {
    // rust: Self::Air
}
}
}
// Armor stands share LivingEntity's block/tag and trapdoor climb predicate.
StandClimbing :: struct {
    world: ^'a World,
    position: BlockPos,
}
    // rust: impl horizon_world::climbing::ClimbingWorld for StandClimbing<'_> {
    // rust: type Error = std::convert::Infallible;
is_spectator :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
is_fall_flying :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.position)
}
in_block_state :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.block_state(self.position)
}
    // rust: fn block_state(
    // rust: &mut self,
    // rust: p: BlockPos,
    // rust: ) -> Result<horizon_world::registry::BlockStateId, Self::Error> {
    // rust: Ok(self.world.block(p.x, p.y, p.z))
}
set_last_climbable_position :: proc(self: ^Self, _: BlockPos) {
}
}
// What a stand's travel carries from [`ArmorStand::tick_move`] to
// [`ArmorStand::tick_settle`].
StandStep :: struct {
    falling: bool,
    friction: f32,
}
    // rust: impl ArmorStand {
    // A whole travel for the unit tests, with no bubble column.
    // rust: pub(crate) fn tick(
    // rust: &mut self,
    // rust: scene: &mut crate::collisions::SceneCollisions,
    // rust: facts: &BlockFacts,
    // rust: climbing: &horizon_world::climbing::ClimbingRegistry<'_>,
    // rust: in_water: bool,
    // rust: border: Option<&BorderGeometry>,
    // rust: ) {
    // rust: if let Some(step) = self.tick_move(scene, facts, climbing, in_water, border) {
    // rust: let medium = if in_water {
    // rust: StandMedium::Water
    // rust: } else {
    // rust: StandMedium::Air
}
    // rust: self.tick_settle(medium, step);
}
    // rust: self.apply_honey_slide(scene.world, facts);
}
}
    // rust: impl ArmorStand {
    // `NameTagItem.interactLivingEntity`: a custom name handles the use;
    // only a living target changes. Stack consumption belongs to the caller.
name_with_tag :: proc(self: ^Self, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if &*stack.item != "minecraft:name_tag" {
    // rust: return false;
}
    // rust: let Some(name) = stack.data().and_then(|data| data.custom_name.as_ref()) else {
    // rust: return false;
}
    // rust: if self.health > 0.0 {
    // rust: self.custom_name = Some(crate::component::name_text(name));
}
    // rust: true
}
SLOTS :: ["mainhand", "offhand", "feet", "legs", "chest", "head"]
    // The `Pose` compound's keys.
    // rust: pub const POSE_KEYS: [&'static str; 6] =
    // rust: ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
    // `ArmorStand.DEFAULT_*_POSE`.
    // rust: pub const DEFAULT_POSE: [[f32; 3]; 6] = [
    // rust: [0.0, 0.0, 0.0],
    // rust: [0.0, 0.0, 0.0],
    // rust: [-10.0, 0.0, -10.0],
    // rust: [-15.0, 0.0, 10.0],
    // rust: [-1.0, 0.0, -1.0],
    // rust: [1.0, 0.0, 1.0],
    // rust: ];
    // Where the renderer draws the stand `alpha` of the way through the tick
    // (`EntityRenderer`'s `Mth.lerp(partialTick, xo, x)` and so on).
render_position :: proc(self: ^Self, alpha: f64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.previous.lerp(self.position, alpha)
}
    // The body's yaw `alpha` of the way through the tick
    // (`LivingEntityRenderer.solveBodyRot`: `Mth.rotLerp(partialTick,
    // yBodyRotO, yBodyRot)`).
render_yaw :: proc(self: ^Self, alpha: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.previous_yaw + alpha * crate::camera::wrap_degrees(self.yaw - self.previous_yaw)
}
    // A server's stand on its client, each tick:
    // `setOldPosAndRot` (`ClientLevel.tickNonPassenger`), then the step of
    // its `SteppedInterpolationHandler` (`step`: the position and yaw it is
    // put at, when one is due). The yaw
    // turns the short way and stays continuous, so a frame between ticks
    // never spins it.
interpolate :: proc(self: ^Self, step: Option<(Vec3) {
}
    // rust: self.previous = self.position;
    // rust: self.previous_yaw = self.yaw;
    // rust: if let Some((at, yaw)) = step {
    // rust: self.position = at;
    // rust: self.yaw += crate::camera::wrap_degrees(yaw - self.yaw);
}
}
    // Put there at once, with nothing to blend from
    // (`Entity.snapTo`).
snap :: proc(self: ^Self, at: Vec3, yaw: f32) {
}
    // rust: self.position = at;
    // rust: self.previous = at;
    // rust: self.yaw = yaw;
    // rust: self.previous_yaw = yaw;
}
new :: proc(id: u32, position: Vec3, yaw: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: first_tick: true,
    // rust: pitch: 0.0,
    // rust: join: Default::default(),
    // rust: fire_ticks: 0,
    // rust: health: 20.0,
    // rust: id,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: true,
    // rust: yaw,
    // rust: previous_yaw: yaw,
    // rust: equipment: Default::default(),
    // rust: small: false,
    // rust: show_arms: false,
    // rust: no_base_plate: false,
    // rust: invisible: false,
    // rust: marker: false,
    // rust: no_gravity: false,
    // rust: custom_name: None,
    // rust: name_visible: false,
    // rust: last_hit: i64::MIN / 2,
    // rust: pose: Self::DEFAULT_POSE,
    // rust: vehicle: None,
    // rust: disabled_slots: 0,
    // rust: enchantment_block: None,
    // rust: enchantment_fall_distance: 0.0,
    // rust: enchantment_equipment: Default::default(),
    // rust: support: Default::default(),
    // rust: speed_instance: false,
}
}
    // `Entity.getOnPos(0.2)` (`getOnPosLegacy`): the supporting block's
    // column 0.2 below the feet, the supporting block itself when `tall`
    // says it is a fence, wall or fence gate, else the cell 0.2 below.
on_pos_legacy :: proc(self: ^Self, tall: impl Fn(BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let y = (self.position.y - f64::from(0.2_f32)).floor() as i32;
    // rust: match self.support.supporting_block {
    // rust: Some(p) if tall(p) => p,
    // rust: Some(p) => BlockPos::new(p.x, y, p.z),
    // rust: None => BlockPos::new(
    // rust: self.position.x.floor() as i32,
    // rust: y,
    // rust: self.position.z.floor() as i32,
    // rust: ),
}
}
    // `EquipmentSlot.getFilterFlag` of an `equipment` index (main hand, off
    // hand, feet, legs, chest, head).
filter_flag :: proc(slot: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: [0, 5, 1, 2, 3, 4][slot]
}
    // `ArmorStand.isDisabled`: the slot is locked, or it is a hand and the
    // stand has no arms.
is_disabled :: proc(self: ^Self, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.disabled_slots & (1 << Self::filter_flag(slot)) != 0 || (slot < 2 && !self.show_arms)
}
    // The `swapItem` locks: taking from a filled slot or putting into an
    // empty one can each be disabled.
swap_locked :: proc(self: ^Self, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let offset = if self.equipment[slot].is_some() {
    // rust: 8
    // rust: } else {
    // rust: 16
}
    // rust: self.disabled_slots & (1 << (Self::filter_flag(slot) + offset)) != 0
}
    // rust: pub fn environment_tick(
    // rust: &mut self,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: ) -> bool {
    // rust: let (lo, hi) = (self.bounds().min_position(), self.bounds().max_position());
    // rust: let mut water = false;
    // rust: let mut lava = false;
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..hi.y.ceil() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: match facts.get(world.block(x, y, z)).fluid {
    // rust: Fluid::Water => water = true,
    // rust: Fluid::Lava => lava = true,
    // rust: _ => {}
}
}
}
}
    // rust: if water {
    // rust: self.fire_ticks = 0;
}
    // rust: if self.fire_ticks > 0 {
    // rust: if self.fire_ticks % 20 == 0
    // rust: && !lava
    // rust: && !self.invisible
    // rust: && !self.marker
    // rust: && self.health > 0.5
    // rust: {
    // rust: self.health -= 4.0;
}
    // rust: self.fire_ticks -= 1;
}
    // rust: if lava {
    // rust: self.fire_ticks = self.fire_ticks.max(300);
}
    // rust: let fire = crate::motion::environment::fire_contact(world, registry, self.bounds()) > 0.0;
        // The fire block reaches a stand through `applyEffectsFromBlocks`,
        // which a NoGravity stand does not feel (measured beside the server).
    // rust: if fire && !self.invisible && !self.marker && !self.no_gravity {
    // rust: if self.fire_ticks > 0 {
    // rust: self.health -= 0.15;
    // rust: } else {
    // rust: self.fire_ticks = 100;
}
}
    // rust: self.health > 0.5
}
    // EntityType.ARMOR_STAND dimensions (0.5 x 1.975, half for small).
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let s = if self.small { 0.5 } else { 1.0 };
    // rust: let (w, h) = (0.25 * s, 1.975 * s);
    // rust: let p = self.position;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - w, p.y, p.z - w),
    // rust: Vec3::new(p.x + w, p.y + h, p.z + w),
    // rust: )
}
    // Leather boots on its feet: it walks on powder snow (`PowderSnowBlock.canEntityWalkOnPowderSnow`).
feet_are_leather_boots :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.equipment[2]
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:leather_boots")
}
    // LivingEntity.travel (armor stands have no other movement): clamp tiny
    // velocity components (`LivingEntity.aiStep`), move by the velocity (a
    // landing stops the fall, `Block.updateEntityMovementAfterFallOn`, and a
    // wall collision zeros that horizontal axis), let the blocks it is inside
    // push it (`push`: a bubble column), then in water the 0.8 slowdown and
    // `getFluidFallingAdjustedMovement`, in air gravity 0.08, ground/air
    // horizontal drag (`friction * 0.91`), and the 0.98 vertical drag, so a
    // stand at rest on the ground keeps -0.0784 as vanilla's.
    //
    // The game runs the fluid push first (`Entity::push_by_fluid`), then
    // this up to the blocks' push, then the bubble column
    // (`Entity::push_by_bubble_column`), then [`ArmorStand::tick_settle`].
    // None: a marker or a stand with `NoGravity` does not travel.
    // rust: pub fn tick_move(
    // rust: &mut self,
    // rust: scene: &mut crate::collisions::SceneCollisions,
    // rust: facts: &BlockFacts,
    // rust: climbing: &horizon_world::climbing::ClimbingRegistry<'_>,
    // rust: in_water: bool,
    // rust: border: Option<&BorderGeometry>,
    // rust: ) -> Option<StandStep> {
//         use crate::entity_rules::EntityRules;
    // rust: self.previous = self.position;
    // rust: if self.marker {
    // rust: return None;
}
    // rust: scene.subject =
    // rust: self.feet_are_leather_boots()
    // rust: .then_some(crate::collisions::PowderSnowSubject {
    // rust: leather_boots: true,
    // rust: ..Default::default()
    // rust: });
    // rust: let v = self.velocity;
    // rust: let mut wanted = Vec3::new(
    // rust: if v.x.abs() < 0.003 { 0.0 } else { v.x },
    // rust: if v.y.abs() < 0.003 { 0.0 } else { v.y },
    // rust: if v.z.abs() < 0.003 { 0.0 } else { v.z },
    // rust: );
    // rust: self.velocity = wanted;
        // ArmorStand.travel: no physics with NoGravity, the velocity stays.
    // rust: if self.is_no_gravity() {
    // rust: return None;
}
        // `travelInFluid` reads `isFalling` before the move and any push;
        // `travelInAir` reads ground friction before the move.
    // rust: let falling = wanted.y <= 0.0;
    // rust: let friction = if !in_water && self.on_ground {
    // rust: let below = scene.world.block(
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - 0.500_001).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: facts.get(below).friction
    // rust: } else {
    // rust: 1.0
}
    // rust: let on_climbable = |position| {
    // rust: horizon_world::climbing::on_climbable(
    // rust: &mut StandClimbing {
    // rust: world: scene.world,
    // rust: position: BlockPos::containing(position),
    // rust: },
    // rust: climbing,
    // rust: )
    // rust: .unwrap_or(false)
}
    // rust: if !in_water && on_climbable(self.position) {
    // rust: self.enchantment_fall_distance = 0.0;
            // LivingEntity.handleOnClimbable; suppressing slide is Player-only.
    // rust: let limit = f64::from(0.15f32);
    // rust: wanted.x = wanted.x.clamp(-limit, limit);
    // rust: wanted.z = wanted.z.clamp(-limit, limit);
    // rust: if !wanted.y.is_nan() {
    // rust: wanted.y = wanted.y.max(-limit);
}
}
    // rust: let mut velocity = wanted;
    // rust: let mut horizontal_collision = false;
        // Entity.collide: the world border's walls stop the stand too.
    // rust: let moved = SceneCollisions {
    // rust: world: scene.world,
    // rust: binding: scene.binding,
    // rust: subject: scene.subject,
}
    // rust: .resolve_in_border(
    // rust: self.bounds(),
    // rust: wanted,
    // rust: 0.0,
    // rust: self.on_ground,
    // rust: border.map(|b| (b, [self.position.x, self.position.z])),
    // rust: );
    // rust: if let Ok(moved) = moved {
    // rust: self.position = Vec3::new(
    // rust: self.position.x + moved.x,
    // rust: self.position.y + moved.y,
    // rust: self.position.z + moved.z,
    // rust: );
    // rust: self.on_ground = wanted.y < 0.0 && moved.y > wanted.y;
            // Entity.setOnGroundWithMovement: the block under the feet.
    // rust: let context = horizon_world::collision_context::CollisionContext::for_entity(
    // rust: horizon_world::collision_context::CollisionEntity {
    // rust: identity: horizon_world::entity_obstruction::EntityIdentity(u64::from(self.id)),
    // rust: y: self.position.y,
    // rust: descending: false,
    // rust: main_hand: Some(horizon_world::collision_context::CollisionItem::EMPTY),
    // rust: },
    // rust: false,
    // rust: );
    // rust: let position = self.position;
    // rust: let _ =
    // rust: self.support
    // rust: .check_support(self.on_ground, self.bounds(), Some(wanted), |area| {
    // rust: horizon_world::ground_support::find_supporting_block(
    // rust: scene, context, position, area, 1_000_000,
    // rust: )
    // rust: });
    // rust: if (wanted.x - moved.x).abs() >= f64::from(1.0e-5_f32) {
    // rust: horizontal_collision = true;
    // rust: velocity.x = 0.0;
}
    // rust: if moved.y != wanted.y {
    // rust: velocity.y = 0.0;
}
    // rust: if (wanted.z - moved.z).abs() >= f64::from(1.0e-5_f32) {
    // rust: horizontal_collision = true;
    // rust: velocity.z = 0.0;
}
}
    // rust: if !in_water && horizontal_collision && on_climbable(self.position) {
    // rust: velocity.y = 0.2;
}
    // rust: self.velocity = velocity;
    // rust: Some(StandStep { falling, friction })
}
    // `HoneyBlock.entityInside`: side-slide movement after the stand's travel.
    // `ArmorStand.hasPhysics` / `Entity.isAffectedByBlocks` exclude markers
    // and NoGravity stands. Slide effects are separate from this movement.
apply_honey_slide :: proc(self: ^Self, world: ^World, facts: ^BlockFacts) {
}
    // rust: let old_delta_y = |dy: f64| dy / f64::from(0.98_f32) + 0.08;
    // rust: if self.marker || self.no_gravity || self.on_ground || old_delta_y(self.velocity.y) >= -0.08
    // rust: {
    // rust: return;
}
        // Entity.checkInsideBlocks: test the deflated body against block cells,
        // not their inset collision shape (the stand slides beside that shape).
    // rust: let bounds = self.bounds().deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let overlap = 0.4375 + if self.small { 0.125 } else { 0.25 };
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: if &*facts.get(world.block(x, y, z)).name != "minecraft:honey_block"
    // rust: || self.position.y > f64::from(y) + 0.9375 - 1.0e-7
    // rust: {
    // rust: continue;
}
    // rust: let dx = (f64::from(x) + 0.5 - self.position.x).abs();
    // rust: let dz = (f64::from(z) + 0.5 - self.position.z).abs();
    // rust: if dx + 1.0e-7 <= overlap && dz + 1.0e-7 <= overlap {
    // rust: continue;
}
                    // HoneyBlock.doSlideMovement, including its float-widened
                    // getOldDeltaY/getNewDeltaY conversion around air travel.
    // rust: let old = old_delta_y(self.velocity.y);
    // rust: if old < -0.13 {
    // rust: let factor = -0.05 / old;
    // rust: self.velocity.x *= factor;
    // rust: self.velocity.z *= factor;
}
    // rust: self.velocity.y = (-0.05 - 0.08) * f64::from(0.98_f32);
    // rust: self.enchantment_fall_distance = 0.0;
                    // The new oldDeltaY is -0.05, so another honey cell cannot slide again.
    // rust: return;
}
}
}
}
    // The rest of the stand's travel: the water slowdown, the lava slowdown
    // and sink, or the air drag and gravity. The blocks' push (a bubble
    // column) comes after this, as `LivingEntity.aiStep` applies the block
    // effects after `travel`.
tick_settle :: proc(self: ^Self, medium: StandMedium, step: StandStep) {
}
//         use crate::entity_rules::EntityRules;
    // rust: let StandStep { falling, friction } = step;
    // rust: let velocity = self.velocity;
    // rust: let gravity = self.get_gravity();
    // rust: self.velocity = if let StandMedium::Lava { shallow } = medium {
            // travelInLava: halve it (a shallow lava also slows the fall by
            // 0.8 with `getFluidFallingAdjustedMovement`), then sink by
            // gravity / 4.
    // rust: let (x, y, z) = if shallow {
    // rust: let y = velocity.y * f64::from(0.8f32);
    // rust: let sink = gravity / 16.0;
    // rust: let adjusted = if falling && (y - 0.005).abs() >= 0.003 && (y - sink).abs() < 0.003
    // rust: {
    // rust: -0.003
    // rust: } else {
    // rust: y - sink
}
    // rust: (velocity.x * 0.5, adjusted, velocity.z * 0.5)
    // rust: } else {
    // rust: (velocity.x * 0.5, velocity.y * 0.5, velocity.z * 0.5)
}
    // rust: Vec3::new(x, y - gravity / 4.0, z)
    // rust: } else if medium == StandMedium::Water {
            // travelInWater: slowDown 0.8, then `getFluidFallingAdjustedMovement`
            // with gravity / 16 (the stand is falling while its fall is not
            // already nearly stopped).
    // rust: let slow = f64::from(0.8f32);
    // rust: let y = velocity.y * slow;
    // rust: let sink = self.get_gravity() / 16.0;
    // rust: let adjusted = if falling && (y - 0.005).abs() >= 0.003 && (y - sink).abs() < 0.003 {
    // rust: -0.003
    // rust: } else {
    // rust: y - sink
}
    // rust: Vec3::new(velocity.x * slow, adjusted, velocity.z * slow)
    // rust: } else {
    // rust: let drag = f64::from(friction * 0.91f32);
    // rust: Vec3::new(
    // rust: velocity.x * drag,
    // rust: (velocity.y - self.get_gravity()) * f64::from(0.98f32),
    // rust: velocity.z * drag,
    // rust: )
}
}
}

    // rust: mod experience_tests {
//     use super::*;

death_reward_uses_levels_and_caps_the_recoverable_points :: proc() {
}
    // rust: for (level, reward) in [(0, 0), (1, 7), (14, 98), (15, 100), (30, 100)] {
    // rust: let xp = Experience {
    // rust: level,
    // rust: progress: 0.75,
    // rust: total: 10_000,
}
    // rust: assert_eq!(xp.death_reward(false), reward);
    // rust: assert_eq!(xp.death_reward(true), 0);
}
}

respawn_clears_all_xp_unless_it_is_kept :: proc() {
}
    // rust: let mut xp = Experience::default();
    // rust: xp.give(155);
    // rust: let before = (xp.level, xp.progress, xp.total);
    // rust: xp.respawn(true);
    // rust: assert_eq!((xp.level, xp.progress, xp.total), before);
    // rust: xp.respawn(false);
    // rust: assert_eq!((xp.level, xp.progress, xp.total), (0, 0.0, 0));
    // rust: xp.give(7);
    // rust: assert_eq!((xp.level, xp.progress, xp.total), (1, 0.0, 7));
}
}

    // rust: mod fire_environment_tests {
//     use super::*;
//     use horizon_world::loot::PackOverlay;
ordinary_items_burn_but_native_netherite_resists_lava :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let items =
    // rust: crate::items::Items::load(&root, assets.registry, &facts, &PackOverlay::NONE).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: world
    // rust: .set(
    // rust: 20,
    // rust: 4,
    // rust: 20,
    // rust: assets.registry.default_state("minecraft:lava").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let make = |id: &str| ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: thrower: None,
    // rust: target: None,
    // rust: stack: ItemStack {
    // rust: item: std::sync::Arc::from(id),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
    // rust: let mut wood = make("minecraft:oak_planks");
    // rust: let mut metal = make("minecraft:netherite_ingot");
    // rust: let first = wood.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert!(first.alive && first.lava_hurt);
    // rust: assert!(
    // rust: !first.should_play_lava_hurt_sound(1),
    // rust: "ordinary entry damage must not repeat the burn sound"
    // rust: );
    // rust: assert!(first.should_play_lava_hurt_sound(10));
    // rust: assert!(
    // rust: wood.fire_ticks > 0,
    // rust: "lava contact must ignite dropped items"
    // rust: );
    // rust: let last = wood.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert!(
    // rust: !last.alive && last.lava_hurt,
    // rust: "lethal lava damage still emits burn sound"
    // rust: );
    // rust: assert!(
    // rust: last.should_play_lava_hurt_sound(2),
    // rust: "the lethal hit must always play the sound"
    // rust: );
    // rust: for _ in 0..40 {
    // rust: let result = metal.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert!(result.alive && !result.lava_hurt);
    // rust: assert!(!result.should_play_lava_hurt_sound(10));
}
    // rust: assert_eq!(metal.health, 5);
    // rust: assert_eq!(metal.fire_ticks, 0, "fire-resistant items must not ignite");
    // rust: world
    // rust: .set(
    // rust: 20,
    // rust: 4,
    // rust: 20,
    // rust: assets.registry.default_state("minecraft:fire").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut burning = make("minecraft:oak_planks");
    // rust: let result = burning.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert!(result.alive && !result.lava_hurt);
    // rust: assert!(burning.fire_ticks > 0);
    // rust: world
    // rust: .set(
    // rust: 20,
    // rust: 4,
    // rust: 20,
    // rust: assets
    // rust: .registry
    // rust: .default_state("minecraft:soul_fire")
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut soul = make("minecraft:oak_planks");
    // rust: soul.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert_eq!(soul.health, 3);
    // rust: let mut stand = ArmorStand::new(2, at, 0.0);
    // rust: world
    // rust: .set(
    // rust: 20,
    // rust: 4,
    // rust: 20,
    // rust: assets.registry.default_state("minecraft:lava").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: for _ in 0..150 {
    // rust: assert!(stand.environment_tick(&world, &facts, assets.registry));
}
    // rust: assert_eq!(stand.health, 20.0, "lava does not hurt armor stands");
}
}
    // rust: mod destroyed_bundle_environment_tests {
//     use super::*;
//     use horizon_world::loot::PackOverlay;

    // `BundleItem.onDestroyed`: the lava that destroys a dropped bundle
    // hands its stacks to the item tick (`ItemUtils.onContainerDestroyed`),
    // and the bundle keeps none of them.
lava_that_destroys_a_bundle_spills_its_contents :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let items =
    // rust: crate::items::Items::load(&root, assets.registry, &facts, &PackOverlay::NONE).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: world
    // rust: .set(
    // rust: 20,
    // rust: 4,
    // rust: 20,
    // rust: assets.registry.default_state("minecraft:lava").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut stack = ItemStack::new("minecraft:bundle", 1);
    // rust: stack.data_mut().bundle_contents = vec![
    // rust: ItemStack::new("minecraft:stone", 3),
    // rust: ItemStack::new("minecraft:diamond", 1),
    // rust: ];
    // rust: let mut bundle = ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: thrower: None,
    // rust: target: None,
    // rust: stack,
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
        // 5 health against 4 a tick: the first tick leaves 1 and nothing out.
    // rust: let first = bundle.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert!(first.alive && first.spilled.is_empty());
    // rust: let second = bundle.environment_tick(&world, &facts, assets.registry, &items);
    // rust: assert!(!second.alive);
    // rust: assert_eq!(
    // rust: second
    // rust: .spilled
    // rust: .iter()
    // rust: .map(|s| (&*s.item, s.count))
    // rust: .collect::<Vec<_>>(),
    // rust: [("minecraft:stone", 3), ("minecraft:diamond", 1)]
    // rust: );
    // rust: assert!(
    // rust: bundle
    // rust: .stack
    // rust: .data()
    // rust: .is_none_or(|d| d.bundle_contents.is_empty()),
    // rust: "the destroyed bundle keeps nothing inside"
    // rust: );
}
}
    // rust: mod armor_stand_render_tests {
//     use super::*;

    // A falling stand is drawn between last tick's position and this one's,
    // so it slides down every frame instead of jumping once a tick (#4416).
a_falling_stand_is_drawn_between_its_ticks :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(0.5, 70.0, 0.5), 0.0);
        // A new stand has no move behind it.
    // rust: assert_eq!(stand.render_position(0.5), stand.position);
    // rust: let fall = |s: &ArmorStand| Some((Vec3::new(0.5, s.position.y - 1.0, 0.5), 0.0));
    // rust: stand.interpolate(fall(&stand));
    // rust: assert_eq!(stand.render_position(0.0).y, 70.0);
    // rust: assert_eq!(stand.render_position(0.25).y, 69.75);
    // rust: assert_eq!(stand.render_position(1.0).y, 69.0);
    // rust: stand.interpolate(fall(&stand));
    // rust: assert_eq!(stand.render_position(0.5).y, 68.5);
        // Landed: no step is due, so it stays put, and so does every frame.
    // rust: stand.interpolate(None);
    // rust: assert_eq!(stand.render_position(0.5).y, 68.0);
}

    // A turning stand's body turns between ticks too, the short way round.
a_turning_stand_is_drawn_between_its_ticks :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::ZERO, 170.0);
    // rust: assert_eq!(stand.render_yaw(0.5), 170.0);
        // To -170 is 20 degrees on through 180, not 340 back through 0.
    // rust: stand.interpolate(Some((Vec3::ZERO, -170.0)));
    // rust: assert_eq!(stand.render_yaw(0.0), 170.0);
    // rust: assert_eq!(stand.render_yaw(0.5), 180.0);
    // rust: assert_eq!(stand.render_yaw(1.0), 190.0);
    // rust: stand.interpolate(None);
    // rust: assert_eq!(stand.render_yaw(0.5), 190.0);
}

    // A snap (a move too far to interpolate) leaves nothing to blend from.
a_snapped_stand_is_drawn_where_it_landed :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(0.5, 70.0, 0.5), 0.0);
    // rust: stand.interpolate(Some((Vec3::new(0.5, 69.0, 0.5), 0.0)));
    // rust: stand.snap(Vec3::new(200.5, 64.0, 0.5), 90.0);
    // rust: assert_eq!(stand.render_position(0.5), Vec3::new(200.5, 64.0, 0.5));
    // rust: assert_eq!(stand.render_yaw(0.5), 90.0);
}
}
    // rust: mod merge_tests {
//     use super::*;

item :: proc(id: string, count: u32, x: f64, age: i32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let at = Vec3::new(x, 64.0, 0.5);
    // rust: ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: thrower: None,
    // rust: target: None,
    // rust: stack: ItemStack {
    // rust: item: std::sync::Arc::from(id),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: true,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: age.max(0) as u32,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
}
max_stack :: proc(stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if &*stack.item == "minecraft:ender_pearl" {
    // rust: 16
    // rust: } else {
    // rust: 64
}
}
    // Merges around `items[i]` as its tick would; returns the counts left.
merge :: proc(items: ^[ItemEntity], i: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut removed = vec![false; items.len()];
    // rust: let mut cells = ItemCells::new(items);
    // rust: merge_with_neighbours(items, &mut removed, &mut cells, i, &max_stack);
    // rust: items
    // rust: .iter()
    // rust: .zip(removed)
    // rust: .map(|(item, gone)| (!gone).then_some(item.stack.count))
    // rust: .collect()
}

the_smaller_stack_goes_into_the_larger :: proc() {
}
    // rust: let mut items = [
    // rust: item("minecraft:sand", 3, 0.5, 41),
    // rust: item("minecraft:sand", 5, 1.2, 7),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [None, Some(8)]);
        // ItemEntity.merge keeps the younger age; the ticking item's is
        // still the one before its tick.
    // rust: assert_eq!(items[1].age, 7);
    // rust: let mut items = [
    // rust: item("minecraft:sand", 5, 0.5, 41),
    // rust: item("minecraft:sand", 3, 1.2, 7),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [Some(8), None]);
    // rust: assert_eq!(items[0].age, 8, "age 7, plus the rest of this tick");
}

    // ItemEntity.merge uses signed room, including zero and negative transfers.
overstacked_items_transfer_back_without_losing_merge_metadata :: proc() {
}
    // rust: for (counts, expected) in [([80, 10], [64, 26]), ([64, 26], [64, 26])] {
    // rust: let mut items = [
    // rust: item("minecraft:stone", counts[0], 0.5, 41),
    // rust: item("minecraft:stone", counts[1], 0.6, 7),
    // rust: ];
    // rust: for item in &mut items {
    // rust: item.stack.data_mut().set_other(
    // rust: "minecraft:max_stack_size",
    // rust: Some(horizon_world::nbt::Tag::Int(99)),
    // rust: );
}
    // rust: let before = [items[0].stack.clone(), items[1].stack.clone()];
    // rust: items[1].pickup_delay = 30;
    // rust: let mut removed = [false; 2];
    // rust: let mut cells = ItemCells::new(&items);
    // rust: merge_with_neighbours(&mut items, &mut removed, &mut cells, 0, &|_| 99);
    // rust: assert_eq!([items[0].stack.count, items[1].stack.count], expected);
    // rust: assert_eq!(removed, [false, false]);
    // rust: assert_eq!(items[0].pickup_delay, 30);
    // rust: assert_eq!(items[0].age, 8, "younger age 7, then this tick ends");
    // rust: for (item, stack) in items.iter().zip(&before) {
    // rust: assert!(item.stack.same_item_same_components(stack));
}
}
}

items_merge_only_within_half_a_block_sideways :: proc() {
}
        // Boxes 0.25 wide grown by 0.5: centres closer than 0.75 meet.
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:sand", 1, 1.24, 1),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [None, Some(2)]);
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:sand", 1, 1.26, 1),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [Some(1), Some(1)]);
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: ];
    // rust: items[1].position.y += 0.3;
    // rust: assert_eq!(
    // rust: merge(&mut items, 0),
    // rust: [Some(1), Some(1)],
    // rust: "no vertical growth"
    // rust: );
}

different_or_full_stacks_stay_apart :: proc() {
}
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:gravel", 1, 0.5, 1),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [Some(1), Some(1)]);
    // rust: let mut items = [
    // rust: item("minecraft:sand", 60, 0.5, 1),
    // rust: item("minecraft:sand", 10, 0.5, 1),
    // rust: ];
    // rust: assert_eq!(
    // rust: merge(&mut items, 0),
    // rust: [Some(60), Some(10)],
    // rust: "70 is over a stack"
    // rust: );
    // rust: let mut items = [
    // rust: item("minecraft:ender_pearl", 10, 0.5, 1),
    // rust: item("minecraft:ender_pearl", 6, 0.5, 1),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [Some(16), None]);
    // rust: let mut items = [
    // rust: item("minecraft:ender_pearl", 16, 0.5, 1),
    // rust: item("minecraft:ender_pearl", 1, 0.5, 1),
    // rust: ];
    // rust: assert_eq!(
    // rust: merge(&mut items, 0),
    // rust: [Some(16), Some(1)],
    // rust: "a full stack doesn't merge"
    // rust: );
}

unmergeable_items_are_skipped :: proc() {
}
    // rust: for delay in [i64::from(i16::MAX), i64::from(u32::MAX)] {
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: ];
    // rust: items[1].pickup_delay = delay;
    // rust: assert_eq!(merge(&mut items, 0), [Some(1), Some(1)]);
}
        // At age 6000 the other item's lifetime is over; this one's tick
        // started at 5999, so it may still merge into a live item.
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 6000),
    // rust: item("minecraft:sand", 1, 0.5, 6000),
    // rust: ];
    // rust: assert_eq!(merge(&mut items, 0), [Some(1), Some(1)]);
    // rust: items[1].age = 10;
    // rust: assert_eq!(merge(&mut items, 0), [None, Some(2)]);
    // rust: assert_eq!(items[1].age, 10);
}

a_stack_takes_its_neighbours_in_spawn_order_until_full :: proc() {
}
    // rust: let mut items = [
    // rust: item("minecraft:sand", 40, 0.5, 1),
    // rust: item("minecraft:sand", 20, 0.7, 1),
    // rust: item("minecraft:sand", 10, 0.3, 1),
    // rust: item("minecraft:sand", 3, 0.4, 1),
    // rust: ];
        // 40 + 20 = 60; 60 + 10 is over 64; then 3 more.
    // rust: assert_eq!(merge(&mut items, 0), [Some(63), None, Some(10), None]);
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: ];
    // rust: items[1].pickup_delay = 30;
    // rust: assert_eq!(merge(&mut items, 0), [None, Some(2)]);
    // rust: assert_eq!(items[1].pickup_delay, 30, "the longer pickup delay stays");
}

the_cells_follow_moves :: proc() {
}
    // rust: let mut items = [
    // rust: item("minecraft:sand", 1, 0.5, 1),
    // rust: item("minecraft:sand", 1, 5.5, 1),
    // rust: ];
    // rust: let mut removed = [false; 2];
    // rust: let mut cells = ItemCells::new(&items);
    // rust: let from = items[1].position;
    // rust: items[1].position.x = 0.9;
    // rust: cells.moved(1, from, items[1].position);
    // rust: merge_with_neighbours(&mut items, &mut removed, &mut cells, 0, &max_stack);
    // rust: assert_eq!(removed, [true, false]);
    // rust: assert_eq!(items[1].stack.count, 2);
}
}

    // rust: mod world_border_tests {
//     use super::*;

    // `Entity.move`'s last step, `getBlockSpeedFactor`: a dropped item sliding
    // over soul sand or honey keeps 40% of the horizontal speed it keeps over
    // stone, in the same tick. Skips quietly without the vanilla data (CI has none).
a_dropped_item_on_soul_sand_or_honey_is_slowed_by_the_move :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut after = Vec::new();
        // The tops of the blocks: stone 1, soul sand 7/8, honey 15/16.
    // rust: for (block, top) in [
    // rust: ("minecraft:stone", 4.0),
    // rust: ("minecraft:soul_sand", 3.875),
    // rust: ("minecraft:honey_block", 3.9375),
    // rust: ] {
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let id = assets.registry.default_state(block).unwrap();
    // rust: for x in 18..=23 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, id).unwrap();
}
}
    // rust: let mut item = super::honey_slide_tests::falling_item(19.5, top, 20.5, 0.2, 0.0, 0.0);
    // rust: item.on_ground = true;
    // rust: item.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: Some(&motion.blocks),
    // rust: );
    // rust: after.push(item.velocity.x);
}
    // rust: let (stone, soul, honey) = (after[0], after[1], after[2]);
    // rust: assert!(stone > 0.0);
    // rust: assert!(
    // rust: (soul - stone * f64::from(0.4_f32)).abs() < 1.0e-9,
    // rust: "soul sand {soul} vs stone {stone}"
    // rust: );
    // rust: assert!(
    // rust: (honey - stone * f64::from(0.4_f32)).abs() < 1.0e-9,
    // rust: "honey {honey} vs stone {stone}"
    // rust: );
}

    // `Entity.collectColliders` (#7080): the world border's wall stops an
    // item and an experience orb as it stops the player. A border of size
    // 10 around (20, 20) has its east wall at x = 25; each body starts at
    // x = 24 on the flat ground of the test scene, moving 1.5 east.
the_world_border_stops_items_and_experience_orbs :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let border = BorderGeometry::new([20.0, 20.0], 10.0, 29_999_984).unwrap();
    // rust: for bordered in [false, true] {
    // rust: let border = bordered.then_some(&border);
    // rust: let mut item = super::honey_slide_tests::falling_item(24.0, 4.0, 20.5, 1.5, 0.0, 0.0);
    // rust: item.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: border,
    // rust: None,
    // rust: );
    // rust: let mut orb = ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 2,
    // rust: position: Vec3::new(24.0, 4.0, 20.5),
    // rust: previous: Vec3::new(24.0, 4.0, 20.5),
    // rust: velocity: Vec3::new(1.5, 0.0, 0.0),
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: true,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
}
    // rust: orb.tick(
    // rust: &world,
    // rust: &facts,
    // rust: &collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.0,
    // rust: border,
    // rust: &fluids,
    // rust: &mut |_, _| {},
    // rust: );
    // rust: for (what, east) in [
    // rust: ("item", item.bounds().max_position().x),
    // rust: ("orb", orb.bounds().max_position().x),
    // rust: ] {
    // rust: if bordered {
    // rust: assert!(
    // rust: (east - 25.0).abs() < 1.0e-7,
    // rust: "the {what} stops on the wall at x = 25, got {east}"
    // rust: );
    // rust: } else {
    // rust: assert!(east > 25.0, "no border: the {what} goes on, got {east}");
}
}
}
}
}

    // rust: mod honey_slide_tests {
//     use super::*;

    // Gravity still stacks on idle ticks; waking every 4th tick zeroes Y on
    // the ground (`ItemEntity.tick` with `onGround`).
a_resting_item_skips_move_three_of_four_ticks :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, stone).unwrap();
}
}
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let mut item = falling_item(at.x, at.y, at.z, 0.0, 0.0, 0.0);
    // rust: item.on_ground = true;
    // rust: item.age = 0;
    // rust: item.ticks = 0;
    // rust: item.id = 0;
    // rust: let mut ys = Vec::new();
    // rust: for _ in 0..8 {
    // rust: item.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: ys.push(item.velocity.y);
}
        // Idle ticks keep gravity; the 4th tick's move hits the floor and
        // clears Y (vanilla's sequence for a resting item).
    // rust: assert_eq!(ys, vec![-0.04, -0.08, -0.12, 0.0, -0.04, -0.08, -0.12, 0.0]);
    // rust: assert_eq!(item.position.y, at.y);
}

    // #4558: idle ticks still run `BubbleColumnBlock.entityInside`, so lift
    // builds and the next wake-up rises off the soul sand.
a_grounded_item_in_a_soul_sand_column_rises :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let soul = assets
    // rust: .registry
    // rust: .default_state("minecraft:soul_sand")
    // rust: .unwrap();
    // rust: let mut column = assets
    // rust: .registry
    // rust: .state(
    // rust: assets
    // rust: .registry
    // rust: .default_state("minecraft:bubble_column")
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap()
    // rust: .clone();
    // rust: column.properties.insert("drag".into(), "false".into());
    // rust: let column = assets.registry.resolve(&column).unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, soul).unwrap();
    // rust: for y in 4..=8 {
    // rust: world.set(x, y, z, column).unwrap();
}
}
}
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let mut item = falling_item(at.x, at.y, at.z, 0.0, 0.0, 0.0);
    // rust: item.on_ground = true;
    // rust: item.age = 0;
    // rust: item.id = 1;
    // rust: let before = item.position.y;
    // rust: for _ in 0..16 {
    // rust: item.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: );
}
    // rust: assert!(
    // rust: item.position.y > before + 0.5,
    // rust: "expected rise from soul-sand column, y={} (was {})",
    // rust: item.position.y,
    // rust: before
    // rust: );
}

    // `Entity.sendBubbleColumnParticles` is for the top of a column only: an item
    // inside the column shows nothing, one in its surface block shows the block.
an_item_at_the_top_of_a_bubble_column_is_at_its_surface :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let mut column = assets
    // rust: .registry
    // rust: .state(
    // rust: assets
    // rust: .registry
    // rust: .default_state("minecraft:bubble_column")
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap()
    // rust: .clone();
    // rust: column.properties.insert("drag".into(), "false".into());
    // rust: let column = assets.registry.resolve(&column).unwrap();
    // rust: for y in 4..=8 {
    // rust: world.set(20, y, 20, column).unwrap();
}
    // rust: let surfaces = |y: f64| {
    // rust: let item = falling_item(20.5, y, 20.5, 0.0, 0.0, 0.0);
    // rust: crate::motion::bubble_column_surfaces(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: item.bounds(),
    // rust: )
}
    // rust: assert_eq!(surfaces(8.2), vec![BlockPos::new(20, 8, 20)]);
    // rust: assert_eq!(surfaces(5.0), Vec::new());
        // Straddling the two top blocks, it is still at the top of one column.
    // rust: assert_eq!(surfaces(7.9), vec![BlockPos::new(20, 8, 20)]);
    // rust: assert_eq!(surfaces(9.0), Vec::new());
}

    // rust: pub(super) fn falling_item(x: f64, y: f64, z: f64, vx: f64, vy: f64, vz: f64) -> ItemEntity {
    // rust: let at = Vec3::new(x, y, z);
    // rust: ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: thrower: None,
    // rust: target: None,
    // rust: stack: ItemStack {
    // rust: item: std::sync::Arc::from("minecraft:stone"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::new(vx, vy, vz),
    // rust: on_ground: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 10,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 10,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
}

old_delta_y :: proc(dy: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: dy / f64::from(0.98_f32) + 0.08
}
new_delta_y :: proc(dy: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (dy - 0.08) * f64::from(0.98_f32)
}

a_falling_item_beside_honey_slides_down :: proc() {
}
        // Item width 0.25: overlap 0.5625. Honey at (0, 10, 0); centre 0.5.
        // x = -0.0625 is against the west face (inset 1/16).
    // rust: let mut item = falling_item(-0.0625, 10.4, 0.5, 0.12, -0.20, 0.04);
    // rust: assert!(old_delta_y(-0.20) < -0.08);
    // rust: assert!(old_delta_y(-0.20) >= -0.13);
    // rust: item.honey_block_inside([0, 10, 0]);
    // rust: assert_eq!(item.velocity.x, 0.12);
    // rust: assert_eq!(item.velocity.z, 0.04);
    // rust: assert_eq!(item.velocity.y, new_delta_y(-0.05));
}

a_fast_fall_scales_the_horizontal_speed :: proc() {
}
    // rust: let mut item = falling_item(-0.0625, 10.4, 0.5, 0.2, -0.30, -0.1);
    // rust: let old = old_delta_y(-0.30);
    // rust: assert!(old < -0.13);
    // rust: item.honey_block_inside([0, 10, 0]);
    // rust: let factor = -0.05 / old;
    // rust: assert_eq!(item.velocity.x, 0.2 * factor);
    // rust: assert_eq!(item.velocity.z, -0.1 * factor);
    // rust: assert_eq!(item.velocity.y, new_delta_y(-0.05));
}

an_item_on_the_ground_or_on_top_does_not_slide :: proc() {
}
    // rust: let mut grounded = falling_item(-0.0625, 10.4, 0.5, 0.0, -0.20, 0.0);
    // rust: grounded.on_ground = true;
    // rust: grounded.honey_block_inside([0, 10, 0]);
    // rust: assert_eq!(grounded.velocity.y, -0.20);

    // rust: let mut on_top = falling_item(0.5, 10.9375, 0.5, 0.0, -0.20, 0.0);
    // rust: on_top.honey_block_inside([0, 10, 0]);
    // rust: assert_eq!(on_top.velocity.y, -0.20, "standing on the honey");
}

a_centred_or_slow_item_does_not_slide :: proc() {
}
    // rust: let mut centred = falling_item(0.5, 10.4, 0.5, 0.0, -0.20, 0.0);
    // rust: centred.honey_block_inside([0, 10, 0]);
    // rust: assert_eq!(centred.velocity.y, -0.20, "inside, not on a side");

    // rust: let mut slow = falling_item(-0.0625, 10.4, 0.5, 0.0, -0.04, 0.0);
    // rust: assert!(old_delta_y(-0.04) >= -0.08);
    // rust: slow.honey_block_inside([0, 10, 0]);
    // rust: assert_eq!(slow.velocity.y, -0.04);
}
}

    // rust: mod slime_bounce_tests {
//     use super::*;

landing_on_slime_bounces_a_dropped_item_like_vanilla :: proc() {
}
        // Measured on a vanilla 26.3 server: an item falling at -0.6097 that
        // is stopped 0.4865 down leaves with 0.4950 / 0.98 after the bounce.
    // rust: let y = vertical_collision_velocity(-0.6097, -0.4865, ITEM_GRAVITY, true, true);
    // rust: assert!((y - 0.4950 / 0.98).abs() < 1e-3, "{y}");
        // A tiny landing: -0.0792 stopped after 0.06 gives 0.0862 (vanilla).
    // rust: let y = vertical_collision_velocity(-0.0792, -0.06, ITEM_GRAVITY, true, true);
    // rust: assert!((y - 0.0862).abs() < 1e-3, "{y}");
    // rust: assert_eq!(
    // rust: vertical_collision_velocity(-0.04, -0.01, ITEM_GRAVITY, true, true),
    // rust: 0.0,
    // rust: "gravity alone is not a bounce"
    // rust: );
}

landing_on_stone_or_hitting_a_ceiling_zeros_y :: proc() {
}
    // rust: assert_eq!(
    // rust: vertical_collision_velocity(-1.0, -0.5, ITEM_GRAVITY, true, false),
    // rust: 0.0
    // rust: );
    // rust: assert_eq!(
    // rust: vertical_collision_velocity(1.0, 0.5, ITEM_GRAVITY, false, true),
    // rust: 0.0
    // rust: );
}

slime_step_on_drags_slow_vertical_speed_only :: proc() {
}
    // rust: let scale = slime_step_on_scale(0.0862).unwrap();
    // rust: assert!((scale - 0.41724).abs() < 1e-5);
    // rust: assert_eq!(slime_step_on_scale(0.1), None);
}

a_moving_piston_carrying_slime_still_counts_as_slime :: proc() {
}
    // rust: assert!(slime_support_name("minecraft:slime_block", None));
    // rust: assert!(slime_support_name(
    // rust: "minecraft:moving_piston",
    // rust: Some("minecraft:slime_block")
    // rust: ));
    // rust: assert!(slime_support_name(
    // rust: "minecraft:air",
    // rust: Some("minecraft:slime_block")
    // rust: ));
    // rust: assert!(!slime_support_name(
    // rust: "minecraft:moving_piston",
    // rust: Some("minecraft:stone")
    // rust: ));
    // rust: assert!(!slime_support_name("minecraft:stone", None));
    // rust: assert!(!slime_support_name(
    // rust: "minecraft:honey_block",
    // rust: Some("minecraft:honey_block")
    // rust: ));
}

grounded_item :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: let at = Vec3::new(0.5, 2.0, 0.5);
    // rust: ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: thrower: None,
    // rust: target: None,
    // rust: stack: ItemStack {
    // rust: item: std::sync::Arc::from("minecraft:stone"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: true,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 10,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 10,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
}

a_piston_slime_bounce_launches_the_item_off_the_ground :: proc() {
}
    // rust: let mut item = grounded_item();
    // rust: item.piston_slime_bounce(Direction::Up);
    // rust: assert_eq!(item.velocity, Vec3::new(0.0, 1.0, 0.0));
    // rust: assert!(!item.on_ground);
    // rust: assert!(item.needs_sync);
    // rust: item.needs_sync = false;
    // rust: item.piston_slime_bounce(Direction::East);
    // rust: assert_eq!(item.velocity, Vec3::new(1.0, 1.0, 0.0));
    // rust: assert!(!item.on_ground);
    // rust: assert!(item.needs_sync);
}

a_slime_landing_stays_upward_after_item_friction :: proc() {
}
        // ItemEntity then multiplies Y by 0.98 and applies -0.5 only if still
        // negative on the ground. A slime bounce must remain positive.
    // rust: let bounced = vertical_collision_velocity(-1.0, -0.5, ITEM_GRAVITY, true, true) * 0.98;
    // rust: assert!(bounced > 0.0);
}

a_slime_bounce_marks_the_item_for_immediate_sync :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let slime = assets
    // rust: .registry
    // rust: .default_state("minecraft:slime_block")
    // rust: .unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 3, z, slime).unwrap();
}
}
        // ItemEntity.tick sets needsSync when getDeltaMovement().subtract(oldMovement).lengthSqr() > 0.01.
    // rust: let mut falling = grounded_item();
    // rust: falling.position = Vec3::new(20.5, 4.2, 20.5);
    // rust: falling.previous = falling.position;
    // rust: falling.velocity = Vec3::new(0.0, -0.5, 0.0);
    // rust: falling.on_ground = false;
    // rust: falling.age = 0;
    // rust: falling.id = 1;
    // rust: falling.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: assert_eq!(falling.position.y, 4.0);
    // rust: assert!(falling.velocity.y > 0.0);
    // rust: assert!(falling.on_ground);
    // rust: assert!(falling.needs_sync);

        // An idle tick where velocity only steps by -0.04 (0.04^2 = 0.0016 <= 0.01)
        // does not set needs_sync.
    // rust: falling.velocity = Vec3::ZERO;
    // rust: falling.needs_sync = false;
    // rust: falling.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: );
    // rust: assert!(!falling.needs_sync);
}
}

    // rust: mod unstuck_tests {
//     use super::*;

    // rust: const BORDER: BorderBounds = BorderBounds {
    // rust: min_x: -1.0e6,
    // rust: min_z: -1.0e6,
    // rust: max_x: 1.0e6,
    // rust: max_z: 1.0e6,
}

    // A level of full blocks at `solid`; every other cell is air.
shapes :: proc(solid: ^[(i32) {
}
    // rust: move |p| {
    // rust: if solid.contains(&(p.x, p.y, p.z)) {
    // rust: VoxelShape::from_box(Aabb::block(p)).ok()
    // rust: } else {
    // rust: None
}
}
}

    // `level.noCollision(box)` over the same cells the search reads.
free :: proc(solid: ^[(i32) {
}
    // rust: !solid
    // rust: .iter()
    // rust: .any(|&(x, y, z)| Aabb::block(BlockPos::new(x, y, z)).intersects(b))
}

an_orb_spawned_in_a_block_moves_to_a_free_box :: proc() {
}
        // One block at y 0..1 and an orb standing in its upper half, as a mob
        // killed inside one leaves it: its box overlaps the block by 0.1.
    // rust: let solid = [(0, 0, 0)];
    // rust: let at = Vec3::new(0.5, 0.9, 0.5);
    // rust: let moved = ExperienceOrb::unstuck(at, &BORDER, shapes(&solid)).expect("the orb moves");
        // The nearest free box sits on the block's top face.
    // rust: assert_eq!(moved, Vec3::new(0.5, 1.0, 0.5));
    // rust: assert!(!ExperienceOrb::box_at(moved).intersects(Aabb::block(BlockPos::new(0, 0, 0))));
}

an_orb_in_open_air_keeps_its_position :: proc() {
}
    // rust: let solid = [(0, 0, 0)];
    // rust: let at = Vec3::new(0.5, 2.0, 0.5);
    // rust: assert!(free(&solid, ExperienceOrb::box_at(at)));
        // Nothing to move for: the spawn sites keep the position as given.
    // rust: assert_eq!(ExperienceOrb::unstuck(at, &BORDER, shapes(&solid)), None);
}
}

    // rust: mod entity_collision_tests {
//     use super::honey_slide_tests::falling_item;
//     use super::*;

    // `Entity.collide` stops an item at the entities that `canBeCollidedWith` it: dropped
    // above a boat's box (or a still happy ghast's) it lands on the box's top and rests,
    // where with no box it falls to the floor of the scene.
an_item_lands_on_an_entity_box_under_it :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: world.set(20, 3, 20, stone).unwrap();
    // rust: let rest = |boxes: &[Aabb]| {
    // rust: let mut item = falling_item(20.5, 12.0, 20.5, 0.0, 0.0, 0.0);
    // rust: item.id = 1;
    // rust: for _ in 0..80 {
    // rust: item.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: boxes,
    // rust: None,
    // rust: None,
    // rust: );
}
    // rust: item.position.y
}
        // The stone's top is at 4.0; a box from 5.0 to 9.0 is in the way.
    // rust: let platform = Aabb::new(Vec3::new(19.0, 5.0, 19.0), Vec3::new(22.0, 9.0, 22.0));
    // rust: assert!((rest(&[]) - 4.0).abs() < 1.0e-6, "on the stone with no box");
    // rust: assert!(
    // rust: (rest(&[platform]) - 9.0).abs() < 1.0e-6,
    // rust: "on top of the box, at its top"
    // rust: );
}

    // `WebBlock.entityInside` / `PowderSnowBlock.entityInside` make an item stuck: a
    // fast item sliding into a cobweb is stopped inside it, in powder snow it is slowed.
a_cobweb_and_powder_snow_slow_an_item :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let state = |n: &str| assets.registry.default_state(n).unwrap();
    // rust: for x in 16..32 {
    // rust: world.set(x, 3, 20, state("minecraft:stone")).unwrap();
}
    // rust: let mut slide = |block: Option<&str>| {
    // rust: world
    // rust: .set(21, 4, 20, state(block.unwrap_or("minecraft:air")))
    // rust: .unwrap();
    // rust: let mut item = falling_item(20.5, 4.0, 20.5, 0.4, 0.0, 0.0);
    // rust: item.id = 1;
    // rust: for _ in 0..12 {
    // rust: item.tick(
    // rust: &world,
    // rust: assets.registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: );
}
    // rust: item.position.x
}
    // rust: let free = slide(None);
    // rust: let web = slide(Some("minecraft:cobweb"));
    // rust: let snow = slide(Some("minecraft:powder_snow"));
    // rust: assert!(free > 21.4, "an unobstructed item slides on to {free}");
    // rust: assert!(
    // rust: web > 20.8 && web < free - 0.3,
    // rust: "the web holds it: {web} vs {free}"
    // rust: );
    // rust: assert!(snow < free, "powder snow slows it: {snow} vs {free}");
}

obstacle_grid_returns_only_the_boxes_near_an_item :: proc() {
}
        // A boat every 100 blocks along a line, 1000 of them.
    // rust: let boat = |x: f64| {
    // rust: Aabb::new(
    // rust: Vec3::new(x, 64.0, 0.0),
    // rust: Vec3::new(x + 1.375, 64.5625, 1.375),
    // rust: )
}
    // rust: let grid = ObstacleGrid::new((0..1000).map(|i| boat(f64::from(i) * 100.0)).collect());
    // rust: let mut out = Vec::new();
        // Around the 7th boat: only it.
    // rust: let area = Aabb::new(Vec3::new(699.0, 63.0, -1.0), Vec3::new(701.0, 66.0, 1.0));
    // rust: grid.near(area, &mut out);
    // rust: assert_eq!(out, vec![boat(700.0)]);
        // Between two boats: none.
    // rust: let area = Aabb::new(Vec3::new(750.0, 63.0, 0.0), Vec3::new(751.0, 66.0, 1.0));
    // rust: grid.near(area, &mut out);
    // rust: assert!(out.is_empty());
        // A box spanning cells is found from any of them, once.
    // rust: let wide = Aabb::new(Vec3::new(0.0, 0.0, 0.0), Vec3::new(20.0, 1.0, 1.0));
    // rust: let grid = ObstacleGrid::new(vec![wide]);
    // rust: let area = Aabb::new(Vec3::new(17.0, 0.0, 0.0), Vec3::new(18.0, 1.0, 1.0));
    // rust: grid.near(area, &mut out);
    // rust: assert_eq!(out, vec![wide]);
}

    // A farm: 5000 drops and 1000 separated vehicles. Run with `-- --ignored --nocapture`.
obstacle_grid_beats_scanning_every_box_for_a_big_farm :: proc() {
}
    // rust: let boat = |i: u32| {
    // rust: let (x, z) = (f64::from(i % 40) * 6.0, f64::from(i / 40) * 6.0);
    // rust: Aabb::new(
    // rust: Vec3::new(x, 64.0, z),
    // rust: Vec3::new(x + 1.375, 64.5625, z + 1.375),
    // rust: )
}
    // rust: let boxes: Vec<Aabb> = (0..1000).map(boat).collect();
    // rust: let items: Vec<Aabb> = (0..5000)
    // rust: .map(|i| {
    // rust: let (x, z) = (f64::from(i % 70) * 3.4, f64::from(i / 70) * 3.4);
    // rust: Aabb::new(Vec3::new(x, 64.0, z), Vec3::new(x + 0.25, 64.25, z + 0.25))
    // rust: })
    // rust: .collect();
    // rust: let start = std::time::Instant::now();
    // rust: let mut hits = 0;
    // rust: for item in &items {
    // rust: let area = item.inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: hits += boxes.iter().filter(|b| b.intersects(area)).count();
}
    // rust: let scan = start.elapsed();
    // rust: let grid = ObstacleGrid::new(boxes);
    // rust: let start = std::time::Instant::now();
    // rust: let (mut out, mut found) = (Vec::new(), 0);
    // rust: for item in &items {
    // rust: grid.near(item.inflate(Vec3::new(1.0, 1.0, 1.0)), &mut out);
    // rust: found += out.len();
}
    // rust: let binned = start.elapsed();
    // rust: assert_eq!(hits, found);
    // rust: println!("scan {scan:?}, grid {binned:?}");
}
}

    // rust: mod armor_stand_motion_tests {
//     use super::*;

honey_slide_runs_after_stand_travel_and_preserves_no_physics_controls :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut world = World::new(assets.registry.default_state("minecraft:air").unwrap(), 3);
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: for (z, name) in [(4, "minecraft:honey_block"), (10, "minecraft:stone")] {
    // rust: for y in 100..=120 {
    // rust: world
    // rust: .set(6, y, z, assets.registry.default_state(name).unwrap())
    // rust: .unwrap();
}
}
        // Independently captured Java values after five actual ticks.
    // rust: for (z, no_gravity, marker, y, vy, grounded) in [
    // rust: (
    // rust: 4.5,
    // rust: false,
    // rust: false,
    // rust: 117.51156798899842,
    // rust: -0.12740000247955321,
    // rust: false,
    // rust: ),
    // rust: (10.5, false, false, 118.0, -0.0784000015258789, true),
    // rust: (4.5, true, false, 118.0, 0.0, false),
    // rust: (4.5, false, true, 118.0, 0.0, false),
    // rust: ] {
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(5.78, 118.0, z), 0.0);
            // Match the freshly summoned entity rather than the placement constructor.
    // rust: stand.on_ground = false;
    // rust: stand.no_gravity = no_gravity;
    // rust: stand.marker = marker;
    // rust: let mut scene = SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: for _ in 0..5 {
    // rust: stand.tick(&mut scene, &facts, &motion.climbing, false, None);
}
    // rust: assert_eq!(
    // rust: stand.position,
    // rust: Vec3::new(5.78, y, z),
    // rust: "NoGravity={no_gravity}, Marker={marker}"
    // rust: );
    // rust: assert_eq!(stand.velocity, Vec3::new(0.0, vy, 0.0));
    // rust: assert_eq!(stand.on_ground, grounded);
}
}

a_name_tag_names_a_live_stand_and_unnamed_tags_pass :: proc() {
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::ZERO, 0.0);
    // rust: let mut tag = ItemStack::new("minecraft:name_tag", 4);
    // rust: assert!(!stand.name_with_tag(&tag));
    // rust: assert!(stand.custom_name.is_none());
    // rust: let name = horizon_world::nbt::Tag::compound([
    // rust: ("text", horizon_world::nbt::Tag::String("Bob".into())),
    // rust: ("color", horizon_world::nbt::Tag::String("gold".into())),
    // rust: ]);
    // rust: tag.data_mut().custom_name = Some(name.clone());
    // rust: assert!(stand.name_with_tag(&tag));
    // rust: assert_eq!(stand.custom_name, Some(crate::component::name_text(&name)));
    // rust: assert_eq!(stand.health, 20.0);
    // rust: assert!(!stand.name_with_tag(&ItemStack::new("minecraft:name_tag", 3)));
    // rust: stand.health = 0.0;
    // rust: tag.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("Other".into()));
    // rust: assert!(
    // rust: stand.name_with_tag(&tag),
    // rust: "a dead target still handles the named tag"
    // rust: );
    // rust: assert_eq!(stand.custom_name, Some(crate::component::name_text(&name)));
}

a_new_stand_starts_with_matching_previous :: proc() {
}
    // rust: let at = Vec3::new(1.0, 2.0, 3.0);
    // rust: let stand = ArmorStand::new(1, at, 90.0);
    // rust: assert_eq!(stand.previous, at);
    // rust: assert_eq!(stand.position, at);
}

    // rust: fn tick_stand(
    // rust: stand: &mut ArmorStand,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: ) {
    // rust: let mut scene = SceneCollisions {
    // rust: world,
    // rust: binding: collision,
    // rust: subject: None,
}
    // rust: let empty = Default::default();
    // rust: let climbing = horizon_world::climbing::ClimbingRegistry::new(
    // rust: collision.registry(),
    // rust: &empty,
    // rust: &empty,
    // rust: &empty,
    // rust: )
    // rust: .unwrap();
    // rust: stand.tick(&mut scene, facts, &climbing, false, None);
}

climbing_uses_actual_blocks_and_post_collision_position :: proc() {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let registry = assets.registry;
    // rust: let state = |name, properties: &[(&str, &str)]| {
    // rust: let mut state = registry
    // rust: .state(registry.default_state(name).unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: for (key, value) in properties {
    // rust: state.properties.insert((*key).into(), (*value).into());
}
    // rust: registry.id(&state).unwrap()
}
    // rust: let new_world = || {
    // rust: let mut world = World::new(registry.default_state("minecraft:air").unwrap(), 3);
    // rust: world.chunks.insert(
    // rust: (1, 1),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(1, 1)),
    // rust: );
    // rust: world
}
    // rust: for (name, properties, ladder_below, climbable) in [
    // rust: ("minecraft:air", vec![], false, false),
    // rust: ("minecraft:ladder", vec![("facing", "west")], false, true),
    // rust: ("minecraft:vine", vec![("east", "true")], false, true),
    // rust: ("minecraft:twisting_vines_plant", vec![], false, true),
    // rust: ("minecraft:weeping_vines_plant", vec![], false, true),
    // rust: (
    // rust: "minecraft:oak_trapdoor",
    // rust: vec![("open", "true"), ("facing", "west")],
    // rust: true,
    // rust: true,
    // rust: ),
    // rust: (
    // rust: "minecraft:oak_trapdoor",
    // rust: vec![("open", "true"), ("facing", "east")],
    // rust: true,
    // rust: false,
    // rust: ),
    // rust: ] {
    // rust: let mut world = new_world();
    // rust: world.set(20, 10, 20, state(name, &properties)).unwrap();
    // rust: if ladder_below {
    // rust: world
    // rust: .set(20, 9, 20, state("minecraft:ladder", &[("facing", "west")]))
    // rust: .unwrap();
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(20.5, 10.0, 20.5), 0.0);
    // rust: stand.velocity.y = -0.5;
    // rust: let mut scene = SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: stand.tick(&mut scene, &facts, &motion.climbing, false, None);
    // rust: let fall = if climbable { f64::from(0.15f32) } else { 0.5 };
    // rust: assert!(
    // rust: (stand.position.y - (10.0 - fall)).abs() < 1e-9,
    // rust: "{name} {properties:?}"
    // rust: );
}
        // A wall collision inside a ladder lifts before gravity and drag.
    // rust: let mut world = new_world();
    // rust: world
    // rust: .set(20, 10, 20, state("minecraft:ladder", &[("facing", "west")]))
    // rust: .unwrap();
    // rust: for y in 10..13 {
    // rust: world.set(21, y, 20, state("minecraft:stone", &[])).unwrap();
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(20.74, 10.0, 20.5), 0.0);
    // rust: stand.velocity = Vec3::new(1.0, 0.0, 0.0);
    // rust: let mut scene = SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: stand.tick(&mut scene, &facts, &motion.climbing, false, None);
    // rust: assert!((stand.velocity.y - (0.2 - 0.08) * f64::from(0.98f32)).abs() < 1e-9);
}

    // `Entity.collectColliders` (#7080): the world border's wall stops an
    // armor stand as it stops the player. A border of size 10 around
    // (20, 20) has its east wall at x = 25; the stand starts at x = 24 on the
    // test scene's flat ground, moving 1.5 east.
the_world_border_stops_an_armor_stand :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let border = BorderGeometry::new([20.0, 20.0], 10.0, 29_999_984).unwrap();
    // rust: for bordered in [false, true] {
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(24.0, 4.0, 20.5), 0.0);
    // rust: stand.on_ground = true;
    // rust: stand.velocity = Vec3::new(1.5, 0.0, 0.0);
    // rust: let mut scene = SceneCollisions {
    // rust: world: &world,
    // rust: binding: &collision,
    // rust: subject: None,
}
    // rust: let empty = Default::default();
    // rust: let climbing = horizon_world::climbing::ClimbingRegistry::new(
    // rust: collision.registry(),
    // rust: &empty,
    // rust: &empty,
    // rust: &empty,
    // rust: )
    // rust: .unwrap();
    // rust: stand.tick(
    // rust: &mut scene,
    // rust: &facts,
    // rust: &climbing,
    // rust: false,
    // rust: bordered.then_some(&border),
    // rust: );
    // rust: let east = stand.bounds().max_position().x;
    // rust: if bordered {
    // rust: assert!(
    // rust: (east - 25.0).abs() < 1.0e-7,
    // rust: "stops on the wall, got {east}"
    // rust: );
    // rust: } else {
    // rust: assert!(east > 25.0, "no border: goes on, got {east}");
}
}
}

a_stand_in_lava_halves_its_motion_and_sinks_by_a_quarter_of_gravity :: proc() {
}
        // LivingEntity.travelInLava, measured on the real server: a stand at
        // rest in deep lava has Motion.y -0.02, then -0.03, then -0.035.
    // rust: let step = StandStep {
    // rust: falling: true,
    // rust: friction: 1.0,
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::new(0.5, 100.0, 0.5), 0.0);
    // rust: let mut seen = Vec::new();
    // rust: for _ in 0..3 {
    // rust: stand.tick_settle(StandMedium::Lava { shallow: false }, step);
    // rust: seen.push(stand.velocity.y);
}
    // rust: for (got, want) in seen.iter().zip([-0.02, -0.03, -0.035]) {
    // rust: assert!((got - want).abs() < 1e-12, "got {got}, want {want}");
}
        // Shallow lava also applies the 0.8 and the gravity / 16 sink.
    // rust: let mut shallow = ArmorStand::new(1, Vec3::new(0.5, 100.0, 0.5), 0.0);
    // rust: shallow.velocity = Vec3::new(0.2, -0.1, 0.0);
    // rust: shallow.tick_settle(StandMedium::Lava { shallow: true }, step);
    // rust: assert!((shallow.velocity.x - 0.1).abs() < 1e-12);
    // rust: let want = -0.1 * f64::from(0.8f32) - 0.08 / 16.0 - 0.08 / 4.0;
    // rust: assert!((shallow.velocity.y - want).abs() < 1e-12);
        // Air is unchanged: gravity, then the 0.98 drag.
    // rust: let mut air = ArmorStand::new(1, Vec3::new(0.5, 100.0, 0.5), 0.0);
    // rust: air.tick_settle(StandMedium::Air, step);
    // rust: assert!((air.velocity.y + 0.0784).abs() < 1e-6);
}

lava_depth_picks_the_shallow_or_deep_travel :: proc() {
}
    // rust: assert_eq!(StandMedium::from_heights(0.0, 0.0), StandMedium::Air);
    // rust: assert_eq!(StandMedium::from_heights(0.3, 1.0), StandMedium::Water);
    // rust: assert_eq!(
    // rust: StandMedium::from_heights(0.0, 0.4),
    // rust: StandMedium::Lava { shallow: true }
    // rust: );
    // rust: assert_eq!(
    // rust: StandMedium::from_heights(0.0, 1.975),
    // rust: StandMedium::Lava { shallow: false }
    // rust: );
}

a_tick_keeps_the_previous_position_for_interpolation :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let start = Vec3::new(20.5, 20.0, 20.5);
    // rust: let mut stand = ArmorStand::new(1, start, 0.0);
    // rust: stand.on_ground = false;
        // A summoned stand has no motion yet: the first tick only builds it
        // (vanilla moves by the velocity, then applies gravity), so it falls
        // from the second tick on (measured on the real server: drop 0, 0, 0.0784 blocks).
    // rust: tick_stand(&mut stand, &world, &facts, &collision);
    // rust: assert_eq!(stand.position, start);
    // rust: assert!((stand.velocity.y + 0.0784).abs() < 1e-6);
    // rust: tick_stand(&mut stand, &world, &facts, &collision);
    // rust: assert_eq!(stand.previous, start);
    // rust: assert!(
    // rust: stand.position.y < start.y,
    // rust: "an airborne stand must fall, y={}",
    // rust: stand.position.y
    // rust: );
    // rust: let mid = stand.previous.y + (stand.position.y - stand.previous.y) * 0.5;
    // rust: assert!(
    // rust: mid < start.y && mid > stand.position.y,
    // rust: "alpha 0.5 must sit between previous and current"
    // rust: );
}

a_no_gravity_stand_stays_put :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let start = Vec3::new(20.5, 20.0, 20.5);
    // rust: let mut stand = ArmorStand::new(1, start, 0.0);
    // rust: stand.on_ground = false;
    // rust: stand.no_gravity = true;
        // ArmorStand.travel does nothing without physics: measured on the real
        // server, Pos and Motion stay exactly as summoned for every tick.
    // rust: for _ in 0..5 {
    // rust: tick_stand(&mut stand, &world, &facts, &collision);
    // rust: assert_eq!(stand.position, start);
    // rust: assert_eq!(stand.velocity, Vec3::ZERO);
}
    // rust: stand.no_gravity = false;
    // rust: tick_stand(&mut stand, &world, &facts, &collision);
    // rust: tick_stand(&mut stand, &world, &facts, &collision);
    // rust: assert!(stand.position.y < start.y, "gravity again once cleared");
}

leather_boots_walk_on_powder_snow :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let snow = assets
    // rust: .registry
    // rust: .default_state("minecraft:powder_snow")
    // rust: .unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: world.set(x, 10, z, snow).unwrap();
}
}
    // rust: let start = Vec3::new(20.5, 11.0, 20.5);
    // rust: let mut bare = ArmorStand::new(1, start, 0.0);
    // rust: bare.on_ground = true;
    // rust: for _ in 0..8 {
    // rust: tick_stand(&mut bare, &world, &facts, &collision);
}
    // rust: assert!(
    // rust: bare.position.y < start.y - 0.2,
    // rust: "bare feet must sink into powder snow, y={}",
    // rust: bare.position.y
    // rust: );

    // rust: let mut booted = ArmorStand::new(2, start, 0.0);
    // rust: booted.on_ground = true;
    // rust: booted.equipment[2] = Some(ItemStack::new("minecraft:leather_boots", 1));
    // rust: for _ in 0..8 {
    // rust: tick_stand(&mut booted, &world, &facts, &collision);
}
    // rust: assert!(
    // rust: (booted.position.y - start.y).abs() < 1.0e-6,
    // rust: "leather boots must walk on powder snow, y={}",
    // rust: booted.position.y
    // rust: );
}
}

    // rust: mod item_destroyed_tests {
//     use super::*;

item :: proc(id: string, contents: ^[(string) {
}
    // rust: let mut stack = ItemStack::new(id, 1);
    // rust: stack.data_mut().bundle_contents = contents
    // rust: .iter()
    // rust: .map(|(id, count)| ItemStack::new(id, *count))
    // rust: .collect();
    // rust: ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: thrower: None,
    // rust: target: None,
    // rust: stack,
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: position: Vec3::new(8.5, 64.0, 8.5),
    // rust: previous: Vec3::new(8.5, 64.0, 8.5),
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
}

    // `BundleItem.onDestroyed` (`ItemStack.onDestroyed` → `dropContents`):
    // the damage that empties an item's health (`ItemEntity.hurtServer`,
    // which `environment_tick` calls for fire, lava and cactus) hands back
    // the bundle's stacks, and the bundle keeps none of them.
a_destroyed_bundle_spills_its_contents :: proc() {
}
    // rust: let mut bundle = item(
    // rust: "minecraft:bundle",
    // rust: &[("minecraft:stone", 3), ("minecraft:diamond", 1)],
    // rust: );
        // Above zero after the hit: nothing leaves the bundle.
    // rust: assert_eq!(bundle.hurt(1), None);
    // rust: assert_eq!(bundle.health, 4);
    // rust: let spent = bundle.hurt(4).expect("the hit that destroys it");
    // rust: assert_eq!(
    // rust: spent
    // rust: .iter()
    // rust: .map(|s| (&*s.item, s.count))
    // rust: .collect::<Vec<_>>(),
    // rust: [("minecraft:stone", 3), ("minecraft:diamond", 1)]
    // rust: );
    // rust: assert!(
    // rust: bundle
    // rust: .stack
    // rust: .data()
    // rust: .is_none_or(|d| d.bundle_contents.is_empty()),
    // rust: "the destroyed bundle keeps nothing inside"
    // rust: );
        // A second hit has nothing left to spill, and an item that holds
        // nothing never reports any.
    // rust: assert_eq!(bundle.hurt(1), Some(Vec::new()));
    // rust: assert_eq!(item("minecraft:stone", &[]).hurt(5), Some(Vec::new()));
}

    // `BlockItem.onDestroyed`: the same death path spills a container item's
    // `container` — a shulker box's stacks — in slot order, and the box keeps
    // no slot filled.
a_destroyed_shulker_box_spills_its_container :: proc() {
}
    // rust: let mut box_item = item("minecraft:shulker_box", &[]);
    // rust: box_item.stack.data_mut().container = vec![
    // rust: (20, ItemStack::new("minecraft:diamond", 4)),
    // rust: (0, ItemStack::new("minecraft:oak_log", 8)),
    // rust: (3, ItemStack::new("minecraft:cobblestone", 64)),
    // rust: ];
    // rust: let spent = box_item.hurt(5).expect("the hit that destroys it");
    // rust: assert_eq!(
    // rust: spent
    // rust: .iter()
    // rust: .map(|s| (&*s.item, s.count))
    // rust: .collect::<Vec<_>>(),
    // rust: [
    // rust: ("minecraft:oak_log", 8),
    // rust: ("minecraft:cobblestone", 64),
    // rust: ("minecraft:diamond", 4),
    // rust: ]
    // rust: );
    // rust: assert!(
    // rust: box_item.stack.data().is_none_or(|d| d.container.is_empty()),
    // rust: "the destroyed box keeps no slot filled"
    // rust: );
}
}
    // rust: mod orb_underwater_tests {
//     use super::*;

matches_the_executed_java_private_method :: proc() {
}
        // Actual 26.3 setUnderwaterMovement calls on server-level orbs,
        // captured by test_orb_water_parity.py (orb-water-reference.json).
        // Cover both horizontal signs, falling/rising, and the vertical cap.
    // rust: let cases: [([f64; 3], [u64; 3]); 6] = [
    // rust: (
    // rust: [0.0, 0.0, 0.0],
    // rust: [0x0000000000000000, 0x3f40624de0000000, 0x0000000000000000],
    // rust: ),
    // rust: (
    // rust: [0.1, 0.01, -0.2],
    // rust: [0x3fb9581066666667, 0x3f85810625ae147b, 0xbfc9581066666667],
    // rust: ),
    // rust: (
    // rust: [-0.25, -0.03, 0.125],
    // rust: [0xbfcfae1480000000, 0xbf9e353f7c851eb8, 0x3fbfae1480000000],
    // rust: ),
    // rust: (
    // rust: [0.0, 0.059, 0.0],
    // rust: [0x0000000000000000, 0x3fae76c8b46d9168, 0x0000000000000000],
    // rust: ),
    // rust: (
    // rust: [0.5, 0.0595, -0.5],
    // rust: [0x3fdfae1480000000, 0x3faeb851e0000000, 0xbfdfae1480000000],
    // rust: ),
    // rust: (
    // rust: [-1.0, 0.2, 1.0],
    // rust: [0xbfefae1480000000, 0x3faeb851e0000000, 0x3fefae1480000000],
    // rust: ),
    // rust: ];
    // rust: let actual: Vec<_> = cases
    // rust: .iter()
    // rust: .map(|(v, _)| {
    // rust: let mut orb = ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: position: Vec3::ZERO,
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::new(v[0], v[1], v[2]),
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
}
    // rust: orb.set_underwater_movement();
    // rust: [
    // rust: orb.velocity.x.to_bits(),
    // rust: orb.velocity.y.to_bits(),
    // rust: orb.velocity.z.to_bits(),
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: let expected: Vec<_> = cases.into_iter().map(|(_, bits)| bits).collect();
    // rust: assert_eq!(actual, expected);
}
}

    // rust: mod render_light_tests {
//     use super::*;

orb :: proc(y: f64) -> E {
    // Ported from Horizon
    return {}
}
    // rust: ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: position: Vec3::new(0.5, y, 0.5),
    // rust: previous: Vec3::new(0.5, y, 0.5),
    // rust: velocity: Vec3::new(0.0, 0.0, 0.0),
    // rust: value: 3,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
}
}

    // `ExperienceOrbRenderer.getBlockLightLevel`: the level's block light
    // plus 7, clamped to 15; the sky light is the level's own. The orb used
    // to be drawn at 10 in both nibbles, so an orb in a dark cave was washed
    // out and one in daylight at block light 5 was too dim.
an_orb_is_seven_brighter_than_the_block_it_sits_in :: proc() {
}
    // rust: let light = |sky: i32, block: i32| (sky << 4) | block;
        // Sky 15, block 0 (daylight): sky stays 15, block goes to 7.
    // rust: assert_eq!(
    // rust: orb(64.0).render_light(light(15, 0)),
    // rust: (15 * 16) | ((7 * 16) << 8)
    // rust: );
        // A dark cave: sky 0, block 0 -> block 7, and no invented sky light.
    // rust: assert_eq!(orb(20.0).render_light(light(0, 0)), (7 * 16) << 8);
        // Torchlight 9 -> 15, the clamp, not 16.
    // rust: assert_eq!(orb(20.0).render_light(light(0, 9)), (15 * 16) << 8);
    // rust: assert_eq!(
    // rust: orb(20.0).render_light(light(15, 15)),
    // rust: (15 * 16) | ((15 * 16) << 8)
    // rust: );
}

    // `Entity.getLightProbePosition` is the eye position: an orb's box is
    // half a block, so it reads the light of the cell 0.425 above its feet.
an_orb_is_lit_from_the_block_its_eye_is_in :: proc() {
}
    // rust: assert_eq!(orb(64.6).light_probe_y().floor(), 65.0);
    // rust: assert_eq!(orb(64.6).position.y.floor(), 64.0);
    // rust: assert!((orb(64.0).light_probe_y() - 64.425).abs() < 1e-9);
}

    // `ExperienceOrbRenderer.submit`'s quad: a block tall about the orb's
    // centre, scaled by 0.3, so it spans -0.075 to +0.225 above the 0.1 the
    // pose is translated by. Horizon drew a symmetric 0.3 square, a quarter
    // of the sprite too low.
the_orb_sprite_hangs_a_quarter_below_its_centre :: proc() {
}
    // rust: let off = ORB_QUAD.map(|[x, y]| [x * ORB_QUAD_SCALE, 0.1 + y * ORB_QUAD_SCALE]);
    // rust: let want = [
    // rust: [-0.15, 0.1 - 0.075],
    // rust: [0.15, 0.1 - 0.075],
    // rust: [0.15, 0.1 + 0.225],
    // rust: [-0.15, 0.1 + 0.225],
    // rust: ];
    // rust: for (got, want) in off.into_iter().zip(want) {
    // rust: assert!((got[0] - want[0]).abs() < 1e-6, "{got:?} vs {want:?}");
    // rust: assert!((got[1] - want[1]).abs() < 1e-6, "{got:?} vs {want:?}");
}
}
}
    // rust: crate::impl_joined!(ItemEntity, ExperienceOrb, ArmorStand);
    // rust: mod orb_lava_tests {
//     use super::*;

    // rust: fn with_fixture(
    // rust: mut f: impl FnMut(
    // rust: &mut World,
    // rust: &BlockFacts,
    // rust: &BlockCollisionRegistry<'_>,
    // rust: &crate::motion::FluidResources,
    // rust: &crate::assets::Assets,
    // rust: ),
    // rust: ) {
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("orb lava fixture unavailable: prepared resources missing");
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let collision = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let mut world = World::test_scene(&assets, &render, 3).unwrap();
    // rust: f(&mut world, &facts, &collision, &fluids, &assets);
}

sample_orb :: proc(at: Vec3, health: i32) -> E {
    // Ported from Horizon
    return {}
}
    // rust: ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 1,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health,
}
}

a_server_orb_takes_lava_damage_after_moving_and_discards_at_zero :: proc() {
}
    // rust: with_fixture(|world, facts, collision, fluids, assets| {
    // rust: let lava = assets.registry.default_state("minecraft:lava").unwrap();
    // rust: world.set(20, 4, 20, lava).unwrap();
    // rust: let at = Vec3::new(20.5, 4.1, 20.5);
    // rust: let mut orb = sample_orb(at, 5);
    // rust: let mut client = orb.clone();
    // rust: for expected_age in 1..=2 {
    // rust: assert!(client.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: false,
    // rust: &mut || 0.0,
    // rust: None,
    // rust: fluids,
    // rust: &mut |_, _| {}
    // rust: ));
    // rust: assert_eq!((client.health, client.age), (5, expected_age));
}
    // rust: let mut sounds = Vec::new();
    // rust: assert!(orb.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.0,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert_eq!((orb.health, orb.age), (1, 1));
    // rust: assert_eq!(sounds.len(), 1);
    // rust: sounds.clear();
    // rust: assert!(!orb.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.0,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert_eq!((orb.health, orb.age), (-3, 2));
    // rust: assert_eq!(sounds.len(), 1);
    // rust: });
}

legacy_orb_in_air_or_water_or_non_lava_does_not_play_sound_or_consume_random :: proc() {
}
    // rust: with_fixture(|world, facts, collision, fluids, assets| {
            // Air scenario
    // rust: {
    // rust: let mut orb_air = sample_orb(Vec3::new(20.5, 6.0, 20.5), 5);
    // rust: let mut draws = 0;
    // rust: let mut next_float = || {
    // rust: draws += 1;
    // rust: 0.5
}
    // rust: let mut sounds = Vec::new();
    // rust: assert!(orb_air.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut next_float,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert!(sounds.is_empty(), "orb in air must not play burn sound");
    // rust: assert_eq!(
    // rust: draws, 0,
    // rust: "orb in air must not consume random float for lava"
    // rust: );
    // rust: assert_eq!(orb_air.health, 5);
}

            // Water scenario
    // rust: {
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: world.set(20, 4, 20, water).unwrap();
    // rust: let mut orb_water = sample_orb(Vec3::new(20.5, 4.1, 20.5), 5);
    // rust: let mut draws = 0;
    // rust: let mut next_float = || {
    // rust: draws += 1;
    // rust: 0.5
}
    // rust: let mut sounds = Vec::new();
    // rust: assert!(orb_water.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut next_float,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert!(sounds.is_empty(), "orb in water must not play burn sound");
    // rust: assert_eq!(
    // rust: draws, 0,
    // rust: "orb in water must not consume random float for lava"
    // rust: );
    // rust: assert_eq!(orb_water.health, 5);
}
    // rust: });
}

negative_case_non_contact_or_client_orb_does_not_play_burn_sound :: proc() {
}
    // rust: with_fixture(|world, facts, collision, fluids, assets| {
    // rust: let lava = assets.registry.default_state("minecraft:lava").unwrap();
    // rust: world.set(20, 4, 20, lava).unwrap();

            // Distant orb (no contact)
    // rust: let mut orb_away = sample_orb(Vec3::new(22.5, 4.1, 22.5), 5);
    // rust: let mut draws = 0;
    // rust: let mut next_float = || {
    // rust: draws += 1;
    // rust: 0.5
}
    // rust: let mut sounds = Vec::new();
    // rust: assert!(orb_away.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut next_float,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert!(
    // rust: sounds.is_empty(),
    // rust: "non-contact orb must not play burn sound"
    // rust: );
    // rust: assert_eq!(draws, 0, "non-contact orb must not consume random float");
    // rust: assert_eq!(orb_away.health, 5);

            // Client orb in lava (server = false)
    // rust: let mut client_orb = sample_orb(Vec3::new(20.5, 4.1, 20.5), 5);
    // rust: sounds.clear();
    // rust: assert!(client_orb.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: false,
    // rust: &mut || 0.5,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert!(
    // rust: sounds.is_empty(),
    // rust: "client orb in lava must not play burn sound"
    // rust: );
    // rust: assert_eq!(client_orb.health, 5);

            // Dead orb (health <= 0) takes no contact damage and emits no sound
    // rust: let mut dead_orb = sample_orb(Vec3::new(20.5, 4.1, 20.5), 0);
    // rust: sounds.clear();
    // rust: let mut dead_draws = 0;
    // rust: let discarded = dead_orb.apply_lava_contact_damage(
    // rust: world,
    // rust: fluids,
    // rust: Vec3::ZERO,
    // rust: &mut || {
    // rust: dead_draws += 1;
    // rust: 0.5
    // rust: },
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: );
    // rust: assert!(discarded, "dead orb remains discarded");
    // rust: assert!(sounds.is_empty(), "dead orb must not play burn sound");
    // rust: assert_eq!(dead_draws, 0, "dead orb must not consume random float");
    // rust: });
}

positive_case_server_orb_in_lava_plays_generic_burn_sound :: proc() {
}
    // rust: with_fixture(|world, facts, collision, fluids, assets| {
    // rust: let lava = assets.registry.default_state("minecraft:lava").unwrap();
    // rust: world.set(20, 4, 20, lava).unwrap();

    // rust: let at = Vec3::new(20.5, 4.1, 20.5);
    // rust: let mut orb = sample_orb(at, 5);
    // rust: let mut sounds = Vec::new();
    // rust: let float_val = 0.35_f32;
    // rust: let stays = orb.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut || float_val,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: );
    // rust: assert!(stays, "orb survives first contact with 1 HP");
    // rust: assert_eq!(orb.health, 1);
    // rust: assert_eq!(sounds.len(), 1, "exactly one burn sound played");
    // rust: let expected_pitch = 2.0_f32 + float_val * 0.4_f32;
    // rust: assert!((sounds[0].1 - expected_pitch).abs() < 1e-6);
    // rust: assert_eq!(
    // rust: sounds[0].0,
    // rust: [orb.position.x, orb.position.y, orb.position.z]
    // rust: );
    // rust: });
}

boundary_case_surviving_and_discarding_and_multi_contact_in_one_tick :: proc() {
}
    // rust: with_fixture(|world, facts, collision, fluids, assets| {
    // rust: let lava = assets.registry.default_state("minecraft:lava").unwrap();
    // rust: world.set(20, 4, 20, lava).unwrap();

            // 1. Surviving at 1 HP vs discarding at <= 0 HP
    // rust: let mut orb = sample_orb(Vec3::new(20.5, 4.1, 20.5), 5);
    // rust: let mut sounds = Vec::new();

            // Tick 1: 5 HP -> 1 HP (survives)
    // rust: assert!(orb.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.1,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert_eq!(orb.health, 1);
    // rust: assert_eq!(sounds.len(), 1);
    // rust: assert!((sounds[0].1 - (2.0 + 0.1 * 0.4)).abs() < 1e-6);

            // Tick 2: 1 HP -> -3 HP (discarded)
    // rust: sounds.clear();
    // rust: assert!(!orb.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: None,
    // rust: true,
    // rust: &mut || 0.9,
    // rust: None,
    // rust: fluids,
    // rust: &mut |pos, pitch| sounds.push((pos, pitch)),
    // rust: ));
    // rust: assert_eq!(orb.health, -3);
    // rust: assert_eq!(sounds.len(), 1);
    // rust: assert!((sounds[0].1 - (2.0 + 0.9 * 0.4)).abs() < 1e-6);

            // 2. Multiple lava contacts in a single tick
    // rust: world.set(21, 4, 20, lava).unwrap();
    // rust: let mut multi_orb = sample_orb(Vec3::new(21.5, 4.1, 20.5), 5);
    // rust: multi_orb.previous = Vec3::new(19.8, 4.1, 20.5);
    // rust: let wanted = Vec3::new(1.7, 0.0, 0.0);
    // rust: let mut float_draws = vec![0.2_f32, 0.8_f32];
    // rust: let mut multi_sounds = Vec::new();
    // rust: let discarded = multi_orb.apply_lava_contact_damage(
    // rust: world,
    // rust: fluids,
    // rust: wanted,
    // rust: &mut || float_draws.remove(0),
    // rust: &mut |pos, pitch| multi_sounds.push((pos, pitch)),
    // rust: );
    // rust: assert!(discarded, "orb is discarded after two contacts");
    // rust: assert_eq!(multi_orb.health, -3);
    // rust: assert_eq!(multi_sounds.len(), 2, "both contacts triggered burn sound");
    // rust: assert!((multi_sounds[0].1 - (2.0 + 0.2 * 0.4)).abs() < 1e-6);
    // rust: assert!((multi_sounds[1].1 - (2.0 + 0.8 * 0.4)).abs() < 1e-6);
    // rust: });
}
}

// `Entity.checkInsideBlocks` and `collidedWithFluid`: fluid AABB contacts
// along Entity.move's axis-ordered path, each block visited once.
    // rust: fn orb_lava_contacts(
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: wanted: Vec3,
    // rust: mut lava_height: impl FnMut(BlockPos) -> Option<f64>,
    // rust: ) -> usize {
    // rust: let delta = to.subtract(from);
    // rust: let mut visited = std::collections::HashSet::new();
    // rust: let mut contacts = 0;
    // rust: let mut remaining = 16;
    // rust: let mut segment = |start: Vec3, end: Vec3, budget: i32| {
    // rust: let mut iterations = 0;
    // rust: let epsilon = f64::from(1.0e-5_f32);
    // rust: let target = ExperienceOrb::box_at(end).deflate(Vec3::new(epsilon, epsilon, epsilon));
    // rust: let _ = horizon_core::geometry::sweep_intersected_blocks(
    // rust: start,
    // rust: end,
    // rust: target,
    // rust: 1_000_000,
    // rust: |p, step| {
    // rust: if step >= budget {
    // rust: return false;
}
    // rust: iterations = step;
    // rust: if visited.contains(&p) {
    // rust: return true;
}
    // rust: if let Some(height) = lava_height(p) {
    // rust: let min = Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z));
    // rust: let fluid = Aabb::new(min, min.add_vector(Vec3::new(1.0, height, 1.0)));
    // rust: if ExperienceOrb::box_at(start)
    // rust: .collided_along_vector(end.subtract(start), &[fluid])
    // rust: {
    // rust: visited.insert(p);
    // rust: contacts += 1;
}
}
    // rust: true
    // rust: },
    // rust: );
    // rust: iterations + 1
}
    // rust: if delta.length_squared() > 0.0 {
        // Direction.axisStepOrder uses the original, uncollided movement.
    // rust: let order = if wanted.x.abs() < wanted.z.abs() {
    // rust: [1, 2, 0]
    // rust: } else {
    // rust: [1, 0, 2]
}
    // rust: let components = delta.components();
    // rust: let mut start = from;
    // rust: for axis in order {
    // rust: if components[axis] != 0.0 {
    // rust: let mut end = start.components();
    // rust: end[axis] += components[axis];
    // rust: let end = Vec3::new(end[0], end[1], end[2]);
    // rust: remaining -= segment(start, end, remaining);
    // rust: start = end;
}
}
    // rust: } else {
    // rust: remaining -= segment(from, to, remaining);
}
    // rust: if remaining <= 0 {
    // rust: segment(to, to, 1);
}
    // rust: contacts
}

    // rust: mod orb_lava_shape_tests {
//     use super::*;

contacts :: proc(from: Vec3, to: Vec3) -> u {
    // Ported from Horizon
    return {}
}
    // rust: orb_lava_contacts(from, to, to.subtract(from), |p| {
    // rust: (p == BlockPos::new(0, 0, 0)).then_some(f64::from(8.0_f32 / 9.0))
    // rust: })
}

lava_uses_the_swept_box_and_fluid_height_not_the_feet_block :: proc() {
}
    // rust: let side = Vec3::new(-0.2, 0.1, 0.5);
    // rust: assert_eq!(contacts(side, side), 1);
    // rust: let above = Vec3::new(0.5, 0.95, 0.5);
    // rust: assert_eq!(contacts(above, above), 0);
    // rust: let through = Vec3::new(-1.0, 0.1, 0.5);
    // rust: let end = Vec3::new(2.0, 0.1, 0.5);
    // rust: assert_eq!(contacts(through, end), 1);
    // rust: let away = Vec3::new(-1.0, 0.1, -1.0);
    // rust: assert_eq!(contacts(away, away), 0);
}

axis_segments_do_not_damage_twice_for_the_same_lava_cell :: proc() {
}
    // rust: let from = Vec3::new(0.1, 0.1, 0.1);
    // rust: let to = Vec3::new(0.7, 0.2, 0.7);
    // rust: assert_eq!(contacts(from, to), 1);
    // rust: assert_eq!(
    // rust: orb_lava_contacts(from, to, Vec3::new(0.1, 0.1, 0.9), |p| {
    // rust: (p == BlockPos::new(0, 0, 0)).then_some(1.0)
    // rust: }),
    // rust: 1
    // rust: );
}
}
