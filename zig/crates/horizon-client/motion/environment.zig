//! Transpiled from Horizon Rust crate
//! Module: horizon-client_environment
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player liquid travel and environmental damage over the shared fluid state.
// use super::*;
// use crate::breathing::{Breath, breathe, drown};
// use horizon_core::random::RandomSource;
// use horizon_world::{
    // rust: fluid::FluidKind,
    // rust: living_fluid::{LivingFluidWorld, TravelFluidTag},
}
    // rust: impl MotionWorld<'_, '_, '_> {
    // rust: pub(super) fn environment_hurt(&mut self, source: &str, damage: f32) -> Result<()> {
    // rust: if self.player.invulnerable || self.player.spectator {
    // rust: return Ok(());
}
        // Frost walker's `damage_immunity`: #burn_from_stepping (magma, campfire).
    // rust: if self.player.burn_from_stepping_immune
    // rust: && matches!(source, "minecraft:hot_floor" | "minecraft:campfire")
    // rust: {
    // rust: return Ok(());
}
    // rust: let id = self
    // rust: .health
    // rust: .damage
    // rust: .id(source)
    // rust: .ok_or("missing environment damage type")?;
    // rust: self.player
    // rust: .hurt(self.health, self.scene.health_rules, id, damage)?;
    // rust: Ok(())
}
    // rust: pub(super) fn tick_remaining_fire(&mut self) -> Result<()> {
    // rust: if self.player.spectator {
    // rust: self.player.fire_ticks = 0;
}
    // rust: if self.player.invulnerable && self.player.fire_ticks > 1 {
    // rust: self.player.fire_ticks = 1;
}
    // rust: if self.player.fire_ticks > 0 {
    // rust: if self.player.fire_ticks % 20 == 0 && !self.player.is_in_lava() {
    // rust: self.environment_hurt("minecraft:on_fire", 1.0)?;
}
    // rust: self.player.fire_ticks -= 1;
}
    // rust: if self.player.fluids.was_touching_water {
    // rust: self.player.fire_ticks = self.player.fire_ticks.min(0);
}
    // rust: Ok(())
}
    /// `LivingEntity.baseTick`'s air supply and drowning, then lava.
pub fn tick_environment_damage(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let eye = BlockPos::containing(self.player.position.add_vector(Vec3::new(
    // rust: 0.0,
    // rust: f64::from(self.player.dimensions.eye_height),
    // rust: 0.0,
    // rust: )));
    // rust: let bubble_column = self
    // rust: .assets
    // rust: .registry
    // rust: .state(self.block(eye))
    // rust: .is_some_and(|state| state.name == "minecraft:bubble_column");
    // rust: let submerged = self.player.is_eye_in_fluid(WATER) && !bubble_column;
    // rust: let drowns = submerged
    // rust: && !self.player.status.water_breathing
    // rust: && !self.player.status.breath_of_the_nautilus
    // rust: && !self.player.invulnerable
    // rust: && !self.player.spectator;
    // rust: let vanilla = if drowns {
            // decreaseAirSupply's getAttribute: the instance exists from now
            // on, even unmodified.
    // rust: let key = self.player.attributes.key("minecraft:oxygen_bonus");
    // rust: self.player
    // rust: .attributes
    // rust: .get_instance(key)
    // rust: .map_err(|e| format!("oxygen bonus: {e:?}"))?;
    // rust: let oxygen = self
    // rust: .player
    // rust: .attribute("minecraft:oxygen_bonus")?
    // rust: .max(f64::from(self.player.respiration));
    // rust: let sparing = oxygen > 0.0 && self.scene.random.next_double() >= 1.0 / (oxygen + 1.0);
    // rust: Breath {
    // rust: can_breathe: false,
    // rust: consume: i32::from(!sparing),
    // rust: refill: 0,
}
    // rust: } else {
            // The nautilus' breath keeps a submerged player's air as it is.
    // rust: let held = submerged
    // rust: && self.player.status.breath_of_the_nautilus
    // rust: && !self.player.status.water_breathing;
    // rust: Breath {
    // rust: can_breathe: true,
    // rust: consume: 1,
    // rust: refill: if held { 0 } else { 4 },
}
}
        // LivingBreatheEvent, on the server's copy of the player only.
    // rust: let breath = if self.player.client_side {
    // rust: vanilla
    // rust: } else {
    // rust: breathe(self.player.entity_id as u32, "minecraft:player", vanilla)
}
        // LivingDrownEvent, likewise.
    // rust: if let Some(drowning) = drown(
    // rust: self.player.entity_id as u32,
    // rust: "minecraft:player",
    // rust: &mut self.player.air,
    // rust: breath,
    // rust: !self.player.client_side,
    // rust: ) {
    // rust: self.player.events.push(MotionEvent::Drown);
    // rust: if let Some(damage) = drowning.damage {
    // rust: self.player.events.push(MotionEvent::Health(
    // rust: crate::health::HealthEvent::DrownDamage(damage),
    // rust: ));
    // rust: self.environment_hurt("minecraft:drown", damage)?;
}
}
    // rust: if self.player.is_in_lava() {
    // rust: self.player.ignite_for_ticks(300)?;
    // rust: self.environment_hurt("minecraft:lava", 4.0)?;
}
    // rust: Ok(())
}
    /// What a server's `LivingEntity.baseTick` adds for a player it hosts:
    /// the void (`Entity.checkBelowWorld`, 4 a tick, which creative players
    /// take too) and suffocation (`isInWall`, which the caller decides from
    /// the blocks at the eyes).
pub fn server_hazards_tick(self: *Self, in_wall: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.player.position.y < f64::from(self.scene.bottom_y() - 64) {
    // rust: let id = self
    // rust: .health
    // rust: .damage
    // rust: .id("minecraft:out_of_world")
    // rust: .ok_or("missing environment damage type")?;
    // rust: self.player
    // rust: .hurt(self.health, self.scene.health_rules, id, 4.0)?;
}
    // rust: if in_wall {
    // rust: self.environment_hurt("minecraft:in_wall", 1.0)?;
}
    // rust: Ok(())
}
pub fn apply_fire_contact(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.player.spectator {
    // rust: self.player.fire_ticks = 0;
    // rust: return Ok(());
}
    // rust: let damage = fire_contact(self.scene, self.assets.registry, self.player.bounds());
    // rust: if damage > 0.0 {
    // rust: self.player.ticks_frozen = 0;
    // rust: if !self.player.fluids.was_touching_water {
    // rust: let multiplier = self.player.attribute("minecraft:burning_time")?;
    // rust: let ticks = ignite_contact(
    // rust: self.player.fire_ticks,
    // rust: true,
    // rust: &mut self.scene.random,
    // rust: multiplier,
    // rust: );
    // rust: self.player.set_remaining_fire_ticks(ticks);
}
    // rust: self.environment_hurt("minecraft:in_fire", damage)?;
    // rust: } else if self.player.fire_ticks <= 0 {
    // rust: self.player.fire_ticks = -20;
}
    // rust: Ok(())
}
}
    // rust: pub(crate) fn fire_contact(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: bounds: Aabb,
    // rust: ) -> f32 {
    // rust: let b = bounds.deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let mut damage = 0.0f32;
    // rust: for x in b.min_position().x.floor() as i32..=b.max_position().x.floor() as i32 {
    // rust: for y in b.min_position().y.floor() as i32..=b.max_position().y.floor() as i32 {
    // rust: for z in b.min_position().z.floor() as i32..=b.max_position().z.floor() as i32 {
    // rust: damage = damage.max(
    // rust: match registry
    // rust: .state(world.block(x, y, z))
    // rust: .map(|s| s.name.as_str())
    // rust: {
    // rust: Some("minecraft:fire") => 1.0,
    // rust: Some("minecraft:soul_fire") => 2.0,
    // rust: _ => 0.0,
    // rust: },
    // rust: );
}
}
}
    // rust: damage
}
/// `CactusBlock.entityInside`: the box (deflated by `1.0E-5`, as in
/// `Entity.checkInsideBlocks`) touches a cactus; its inside shape is the
/// whole block.
    // rust: pub(crate) fn cactus_contact(
    // rust: world: &World,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: bounds: Aabb,
    // rust: ) -> bool {
    // rust: let b = bounds.deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: for x in b.min_position().x.floor() as i32..=b.max_position().x.floor() as i32 {
    // rust: for y in b.min_position().y.floor() as i32..=b.max_position().y.floor() as i32 {
    // rust: for z in b.min_position().z.floor() as i32..=b.max_position().z.floor() as i32 {
    // rust: if registry
    // rust: .state(world.block(x, y, z))
    // rust: .is_some_and(|s| s.name == "minecraft:cactus")
    // rust: {
    // rust: return true;
}
}
}
}
    // rust: false
}
    // rust: impl LivingFluidWorld for MotionWorld<'_, '_, '_> {
pub fn in_water(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fluids.was_touching_water)
}
pub fn sprinting(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.sprinting)
}
pub fn water_slow_down(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0.8)
}
pub fn water_movement_efficiency(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:water_movement_efficiency")
}
pub fn dolphins_grace(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.status.dolphins_grace)
}
pub fn fluid_height(self: *Self, tag: TravelFluidTag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fluid_height(if tag == TravelFluidTag::Lava {
    // rust: LAVA
    // rust: } else {
    // rust: WATER
    // rust: }))
}
pub fn fluid_jump_threshold(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fluid_jump_threshold())
}
pub fn is_free(self: *Self, v: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.player.bounds().move_by(v);
    // rust: Ok(self.no_player_collision(b)? && !self.has_liquid(b)?)
}
pub fn is_vehicle(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn can_float_while_ridden(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
}
    // rust: impl PlayerMotion {
    /// `Entity.getFluidJumpThreshold`: 0.4, or 0 under eyes lower than that.
pub fn fluid_jump_threshold(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::swimming::fluid_jump_threshold(self.dimensions.eye_height)
}
}
    // rust: impl MotionWorld<'_, '_, '_> {
    /// `LivingEntity.aiStep`'s jump phase: rise in water or lava, else jump
    /// from the ground (or from shallow fluid); nothing while flying.
    // rust: pub(super) fn jump_phase(&mut self) -> Result<()> {
    // rust: if !self.player.jumping || self.player.flying {
    // rust: self.player.no_jump_delay = 0;
    // rust: return Ok(());
}
    // rust: let in_lava = self.player.is_in_lava();
    // rust: let height = self.player.fluid_height(if in_lava { LAVA } else { WATER });
    // rust: let in_water = self.player.fluids.was_touching_water && height > 0.0;
    // rust: let threshold = self.player.fluid_jump_threshold();
    // rust: let on_ground = self.player.ground.on_ground;
    // rust: if in_water && !(on_ground && height <= threshold) {
            // jumpInLiquid(WATER)
    // rust: self.player.velocity.y += f64::from(0.04f32);
    // rust: } else if in_lava && !(on_ground && self.player.fluid_height(LAVA) <= threshold) {
            // jumpInLiquid(LAVA)
    // rust: self.player.velocity.y += f64::from(0.04f32);
    // rust: } else if (on_ground || in_water && height <= threshold) && self.player.no_jump_delay == 0 {
    // rust: self.jump_from_ground()?;
    // rust: self.player.no_jump_delay = 10;
}
    // rust: Ok(())
}
    /// `BubbleColumnBlock.entityInside` with `Player.onAboveBubbleColumn` /
    /// `onInsideBubbleColumn`: pushed up (or dragged down), faster at the
    /// surface, never while flying.
    // rust: pub(super) fn bubble_column_inside(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: p: BlockPos,
    // rust: precise: bool,
    // rust: ) -> Result<()> {
    // rust: if !precise {
    // rust: return Ok(());
}
    // rust: let drag = self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("drag"))
    // rust: .is_some_and(|d| d == "true");
    // rust: let above = self.block(p.offset(0, 1, 0));
        // stateAbove.getCollisionShape(level, pos): the shape is asked at the
        // column's own position.
    // rust: let binding = self.collision_binding;
    // rust: let context = CollisionContext::empty(false);
    // rust: let empty = binding
    // rust: .collision_shape_with_context(&mut self.collisions(), above, p, &context)?
    // rust: .is_empty()
    // rust: && self.resources.fluids.fluid(above).kind() == FluidKind::Empty;
    // rust: if self.player.flying {
    // rust: return Ok(());
}
    // rust: let v = self.player.velocity;
    // rust: let y = match (empty, drag) {
    // rust: (true, true) => (-0.9_f64).max(v.y - 0.03),
    // rust: (true, false) => 1.8_f64.min(v.y + 0.1),
    // rust: (false, true) => (-0.3_f64).max(v.y - 0.03),
    // rust: (false, false) => 0.7_f64.min(v.y + 0.06),
}
    // rust: self.player.velocity = Vec3::new(v.x, y, v.z);
    // rust: if empty {
            // Entity.sendBubbleColumnParticles: two splashes and two bubbles
            // over the column's top, from the level random.
    // rust: let random = &mut self.scene.random;
    // rust: for bubble in [false, true, false, true] {
    // rust: let x = f64::from(p.x) + random.next_double();
    // rust: let z = f64::from(p.z) + random.next_double();
    // rust: self.player.events.push(MotionEvent::BubbleColumnParticle {
    // rust: bubble,
    // rust: position: Vec3::new(x, f64::from(p.y + 1), z),
    // rust: });
}
    // rust: } else {
    // rust: self.player.fall_distance = 0.0;
}
    // rust: Ok(())
}
pub fn has_liquid(self: *Self, b: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for x in b.min_position().x.floor() as i32..=b.max_position().x.floor() as i32 {
    // rust: for y in b.min_position().y.floor() as i32..=b.max_position().y.floor() as i32 {
    // rust: for z in b.min_position().z.floor() as i32..=b.max_position().z.floor() as i32 {
    // rust: if self.fluid_at(BlockPos::new(x, y, z)).kind() != FluidKind::Empty {
    // rust: return Ok(true);
}
}
}
}
    // rust: Ok(false)
}
}

    // rust: pub(crate) fn ignite_contact(
    // rust: ticks: i32,
    // rust: player: bool,
    // rust: random: &mut impl RandomSource,
    // rust: multiplier: f64,
    // rust: ) -> i32 {
    // rust: let ticks = if ticks < 0 {
    // rust: ticks + 1
    // rust: } else if player {
    // rust: ticks + 1 + random.next_int_bound(2).unwrap_or(0)
    // rust: } else {
    // rust: ticks
}
    // rust: if ticks >= 0 {
    // rust: ticks.max((160.0 * multiplier).ceil() as i32)
    // rust: } else {
    // rust: ticks
}
}

    // rust: mod fire_ignition_tests {
//     use super::*;
pub fn fire_hurts_before_twenty_tick_ignition_and_scales_duration() void {
}
    // rust: let mut r = horizon_core::random::LegacyRandom::new(3);
    // rust: let mut ticks = -20;
    // rust: for _ in 0..19 {
    // rust: ticks = ignite_contact(ticks, true, &mut r, 0.4);
    // rust: assert!(ticks < 0);
}
    // rust: assert_eq!(ignite_contact(ticks, true, &mut r, 0.4), 64);
}
}
