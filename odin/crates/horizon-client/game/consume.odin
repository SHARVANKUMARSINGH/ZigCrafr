//! Transpiled from Horizon Rust crate
package horizon_client_consume

import "core:fmt"
import "core:mem"
import "core:math"

// Finishing a consumable (`Consumable.onConsume` and the use remainder),
// its particles and sounds, and `TeleportRandomlyConsumeEffect` (chorus
// fruit) for the local player. The level random stands in for the player's
// own, as for every other player draw.
// use super::{Dim, Game};
// use horizon_client::{
    // rust: items::{ConsumeEffect, ItemInfo, ItemStack},
    // rust: mobs::Who,
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{
    // rust: geometry::Vec3, position::BlockPos, random::LegacyRandom, random::RandomSource,
}
// use horizon_world::{
    // rust: consumable::{Consumable, EmissionWorld, UseAnimation},
    // rust: teleport_consume::{TeleportConsume, TeleportConsumeWorld},
}
// use std::convert::Infallible;

    // rust: type ItemConsumable = Consumable<String, ConsumeEffect>;

// `EntityEvent.USE_ITEM_COMPLETE`: the server finished the player's use.
    // rust: pub(super) const USE_ITEM_COMPLETE_EVENT: i8 = 9;

    // rust: impl Game<'_> {
    // `ServerPlayer.completeUsingItem`: the player's own client is told
    // first, and completes the use itself (eating the food there too).
    // rust: pub(super) fn send_use_item_complete(&mut self) {
    // rust: if self.lan_acting.is_some() {
    // rust: self.guest_entity_events.push(USE_ITEM_COMPLETE_EVENT);
}
}
    // `Consumable.emitParticlesAndSounds(user.getRandom(), user, stack, count)`.
    // rust: pub(super) fn emit_consume(
    // rust: &mut self,
    // rust: consumable: &ItemConsumable,
    // rust: stack: &ItemStack,
    // rust: count: i32,
    // rust: ) {
    // rust: let Ok(()) = consumable.emit(&mut Emitter(self), (), stack.clone(), count);
}
    // `LivingEntity.completeUsingItem` for a consumable: `Consumable.onConsume`,
    // then `ItemStack.applyAfterUseComponentSideEffects`' use remainder.
    // rust: pub(super) fn finish_consuming(
    // rust: &mut self,
    // rust: info: &ItemInfo,
    // rust: consumable: &ItemConsumable,
    // rust: stack: &ItemStack,
    // rust: ) {
    // rust: self.emit_consume(consumable, stack, 16);
        // ServerPlayer: the used statistic and the consume_item trigger.
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.trigger_item("minecraft:consume_item", stack);
        // FoodProperties.onConsume, the player's one ConsumableListener.
    // rust: if let Some((nutrition, saturation)) = info.food {
    // rust: let at = self.feet();
    // rust: let pitch = self.world.random.triangle_float(1.0, 0.4);
    // rust: self.audio.play(&consumable.sound, at, 1.0, pitch);
    // rust: if let Some(p) = self.player.as_mut() {
                // FoodData.eat(nutrition, saturation)
    // rust: let food = &mut p.health.food;
    // rust: food.food = (food.food + nutrition as i32).clamp(0, 20);
    // rust: food.saturation = (food.saturation + saturation).clamp(0.0, food.food as f32);
}
            // Mth.randomBetween(random, 0.9, 1.0)
    // rust: let pitch = self.world.random.next_float() * (1.0f32 - 0.9f32) + 0.9;
    // rust: self.audio
    // rust: .play("minecraft:entity.player.burp", self.feet(), 0.5, pitch);
}
        // SuspiciousStewEffects.onConsume, a ConsumableListener: each entry is
        // added as a `MobEffectInstance(effect, duration)` (amplifier 0).
    // rust: if let Some(data) = stack.extra.as_deref() {
    // rust: for (id, duration) in &data.stew_effects {
    // rust: if let Some(def) = horizon_client::brewing::effect(id) {
    // rust: self.add_player_effect(horizon_client::effects::EffectInstance::new(
    // rust: def.id, *duration, 0,
    // rust: ));
}
}
}
    // rust: for effect in &consumable.effects {
    // rust: self.apply_consume_effect(effect);
}
    // rust: let event = if consumable.animation == UseAnimation::Drink {
    // rust: "minecraft:drink"
    // rust: } else {
    // rust: "minecraft:eat"
}
    // rust: self.post_entity_event(event, Who::Player);
        // ItemStack.consume, then UseRemainder.convertIntoRemainder: nothing
        // with infinite materials, the hand when emptied, else the inventory
        // (ServerPlayer.handleExtraItemsCreatedOnUse) or a drop.
    // rust: self.consume_held();
    // rust: if let Some(remainder) = &info.use_remainder
    // rust: && !self.creative
    // rust: {
    // rust: let remainder = ItemStack::new(remainder, 1);
    // rust: if self.held().is_none() {
    // rust: *self.held_mut() = Some(remainder);
    // rust: } else if let Some(rest) = self.give(remainder) {
    // rust: self.player_drop(rest);
}
}
}
feet :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z])
}
    // `TeleportRandomlyConsumeEffect.apply` for the local player.
    // rust: pub(super) fn teleport_randomly(&mut self, teleport: &TeleportConsume) {
    // rust: if self.player.is_none() {
    // rust: return;
}
    // rust: let dim = self.dim;
    // rust: let Ok(_) = teleport.apply(&mut Teleporter(self), dim);
}
    // `LivingEntity.randomTeleport(x, y, z, true, avoid)`: down to the first
    // block entities can teleport onto, inside the border, in a loaded chunk.
random_teleport :: proc(self: ^Self, target: Vec3, avoid: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let [min_x, min_z, max_x, max_z] = self.border.bounds();
        // WorldBorder.clampVec3ToBound (Mth.clamp, 1.0E-5F inside the far edge).
    // rust: let clamp = |v: f64, low: f64, high: f64| if v < low { low } else { v.min(high) };
    // rust: let x = clamp(target.x, min_x, max_x - f64::from(1.0e-5_f32));
    // rust: let z = clamp(target.z, min_z, max_z - f64::from(1.0e-5_f32));
    // rust: let mut y = target.y;
    // rust: let mut pos = BlockPos::containing(Vec3::new(x, y, z));
    // rust: if !self.world.loaded(pos.x, pos.z) {
    // rust: return false;
}
    // rust: while pos.y > self.world.shape.min_y {
    // rust: pos.y -= 1;
    // rust: let state = self.world.block(pos.x, pos.y, pos.z);
    // rust: if self.state_in_tag("minecraft:entities_can_teleport_to", state) {
    // rust: return self.check_position_and_teleport(Vec3::new(x, y, z), state, avoid);
}
    // rust: y -= 1.0;
}
    // rust: false
}
    // `LivingEntity.checkPositionAndTeleport`, then `ServerPlayer.teleportTo`
    // (the motion and rotation kept) and entity event 46.
    // rust: fn check_position_and_teleport(
    // rust: &mut self,
    // rust: at: Vec3,
    // rust: ground: horizon_world::registry::BlockStateId,
    // rust: avoid: &str,
    // rust: ) -> bool {
    // rust: if self.state_in_tag(avoid, ground) {
    // rust: return false;
}
    // rust: let entities = self.player_entity_collisions();
    // rust: let Some(player) = self.player.as_mut() else {
    // rust: return false;
}
    // rust: let bounds = player.dimensions.bounds(at);
    // rust: let free = horizon_client::motion::MotionWorld {
    // rust: entities: &entities,
    // rust: player,
    // rust: scene: &mut self.world,
    // rust: assets: &self.pack.assets,
    // rust: collision_binding: self.collision,
    // rust: resources: self.motion,
    // rust: health: &self.health_resources,
}
    // rust: .no_player_collision(bounds)
    // rust: .unwrap_or(false);
        // LevelReader.containsAnyLiquid and findBlocksIn: the blocks from the
        // box's minimum corner to the one holding its maximum corner.
    // rust: let (lo, hi) = (
    // rust: BlockPos::containing(bounds.min_position()),
    // rust: BlockPos::containing(bounds.max_position()),
    // rust: );
    // rust: let blocks = (lo.x..=hi.x)
    // rust: .flat_map(|x| (lo.y..=hi.y).flat_map(move |y| (lo.z..=hi.z).map(move |z| (x, y, z))));
    // rust: let states: Vec<_> = blocks.map(|(x, y, z)| self.world.block(x, y, z)).collect();
    // rust: let liquid = states
    // rust: .iter()
    // rust: .any(|&s| self.res.facts().get(s).fluid != horizon_client::blocks::Fluid::None);
    // rust: if !free || liquid || states.iter().any(|&s| self.state_in_tag(avoid, s)) {
    // rust: return false;
}
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = at;
}
        // The position packet moves the old position along (absolute xyz).
    // rust: self.previous_position = at;
        // `broadcastEntityEvent(46)` after the teleport. A server-thread window
        // is a remote client, so the packet is what draws the particles there.
    // rust: if let Some(id) = self.lan_acting_entity {
    // rust: self.lan_entity_event(id as i32, 46, [at.x, at.y, at.z]);
    // rust: } else {
    // rust: self.portal_particles();
}
    // rust: true
}
state_in_tag :: proc(self: ^Self, tag: string, state: horizon_world::registry::BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let name = &self.res.facts().get(state).name;
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get(tag)
    // rust: .is_some_and(|s| s.contains(&**name))
}
    // `LivingEntity.handleEntityEvent(46)` for this client: 128 portal
    // particles from the old position to the new one. The local player's
    // random is the particle engine's.
portal_particles :: proc(self: ^Self) {
}
    // rust: let (from, to, width, height) = {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: (
    // rust: [
    // rust: self.previous_position.x,
    // rust: self.previous_position.y,
    // rust: self.previous_position.z,
    // rust: ],
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: f64::from(p.dimensions.width),
    // rust: f64::from(p.dimensions.height),
    // rust: )
}
    // rust: self.emit_living_teleport(from, to, width, height);
}
    // `LivingEntity.handleEntityEvent(46)` for the entity the packet names:
    // this player, or a mob the client is drawing.
    // rust: pub(super) fn entity_teleport_particles(&mut self, id: i32) {
    // rust: if self.remote.as_ref().is_some_and(|r| r.entity_id == id) {
    // rust: self.portal_particles();
    // rust: return;
}
    // rust: let spawned = {
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id as u32) else {
    // rust: return;
}
    // rust: let from = [m.previous.x, m.previous.y, m.previous.z];
    // rust: let to = [m.position.x, m.position.y, m.position.z];
    // rust: let (width, height) = (f64::from(m.width()), f64::from(m.height()));
    // rust: let mut spawned = Vec::with_capacity(128);
    // rust: horizon_client::particles::living_teleport_particles(
    // rust: &mut m.random,
    // rust: from,
    // rust: to,
    // rust: width,
    // rust: height,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: spawned
}
    // rust: let options = ParticleOptions::simple(ParticleType::Portal);
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
emit_living_teleport :: proc(self: ^Self, from: [f64; 3], to: [f64; 3], width: f64, height: f64) {
}
    // rust: let mut spawned = Vec::with_capacity(128);
    // rust: horizon_client::particles::living_teleport_particles(
    // rust: self.particles.random(),
    // rust: from,
    // rust: to,
    // rust: width,
    // rust: height,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: let options = ParticleOptions::simple(ParticleType::Portal);
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    // `LivingEntity.stopRiding`.
    // rust: pub(super) fn stop_riding(&mut self) {
    // rust: let Some(id) = self.riding else {
    // rust: return;
}
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: self.dismount(i);
    // rust: } else if let Some(i) = self.carts.iter().position(|c| c.id == id) {
    // rust: self.dismount_cart(i);
    // rust: } else if let Some(c) = self.cushions.iter().find(|c| c.id == id).cloned() {
    // rust: self.get_up_from_cushion(&c);
    // rust: } else {
    // rust: self.dismount_mount();
}
}
}

// `Consumable.emitParticlesAndSounds` against the local player.
Emitter :: struct {
    // rust: impl EmissionWorld for Emitter<'_, '_> {
    // rust: type Error = Infallible;
    // rust: type Stack = ItemStack;
    // rust: type Sound = String;
    // rust: type Random = ();
    // rust: type Source = LegacyRandom;
random_source :: proc(self: ^Self) {
}
    // rust: &mut self.0.world.random
}
    // `LivingEntity.spawnItemParticles`.
spawn_item_particles :: proc(self: ^Self, stack: ItemStack, count: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.eat_particles(&stack, count.max(0) as u32);
    // rust: Ok(())
}
overrides_consume_sound :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
consume_sound :: proc(self: ^Self, _: ItemStack) -> R {
    // Ported from Horizon
    return {}
}
    // rust: unreachable!("players play the consumable's own sound")
}
    // `Player.playSound`: at the player's position, for everyone but the
    // player, whose own client plays it (`level.playSound(player, ...)`):
    // a guest's server turn leaves the guest out.
play_sound :: proc(self: ^Self, sound: string, volume: f32, pitch: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.0.feet();
    // rust: if self.0.lan_acting.is_some() {
    // rust: self.0.audio.play_unshared(&sound, at, volume, pitch);
    // rust: if let Some(at) = at {
    // rust: self.0.guest_player_sounds.push((sound, at, volume, pitch));
}
    // rust: } else {
    // rust: self.0.audio.play(&sound, at, volume, pitch);
}
    // rust: Ok(())
}
}

// The local player as `TeleportRandomlyConsumeEffect`'s user.
Teleporter :: struct {
    // rust: impl Teleporter<'_, '_> {
at :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.0.player.as_ref().map_or(Vec3::ZERO, |p| p.position)
}
}
    // rust: impl TeleportConsumeWorld for Teleporter<'_, '_> {
    // rust: type Error = Infallible;
    // rust: type Level = Dim;
    // rust: type Random = ();
    // rust: type Source = LegacyRandom;
position_field :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.at()
}
get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
random_source :: proc(self: ^Self) {
}
    // rust: &mut self.0.world.random
}
min_y :: proc(self: ^Self, level: Dim) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.0.level_shapes.get(level.id()).min_y)
}
logical_height :: proc(self: ^Self, level: Dim) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.0.level_shapes.get(level.id()).logical_height)
}
is_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.0.riding.is_some())
}
stop_riding :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.stop_riding();
    // rust: Ok(())
}
position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.at())
}
teleport_allowed :: proc(self: ^Self, target: ^Vec3) -> R {
    // Ported from Horizon
    return {}
}
        // EntityTeleportEvent.ChorusFruit: only a server's player is heard.
    // rust: let (Some(uuid), Some(name)) = (self.0.lan_acting_uuid, self.0.lan_acting_name.clone())
    // rust: else {
    // rust: return Ok(true);
}
    // rust: let from = self.at();
    // rust: let mut to = [target.x, target.y, target.z];
    // rust: let mut cancel = false;
    // rust: self.0.native_chorus_fruit_teleport(
    // rust: uuid,
    // rust: &name,
    // rust: [from.x, from.y, from.z],
    // rust: &mut to,
    // rust: &mut cancel,
    // rust: );
        // Keep the mod's spot inside the level as vanilla's own draw is (a
        // huge y would walk down a long way); one that is not a number keeps
        // the draw.
    // rust: if to.iter().all(|v| v.is_finite()) {
    // rust: let shape = self.0.level_shapes.get(self.0.dim.id());
    // rust: let high = shape.min_y + shape.logical_height - 1;
    // rust: let y = to[1].clamp(f64::from(shape.min_y), f64::from(high));
    // rust: *target = Vec3::new(to[0], y, to[2]);
}
    // rust: Ok(!cancel)
}
random_teleport :: proc(self: ^Self, target: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self
    // rust: .0
    // rust: .random_teleport(target, "minecraft:consumable_does_not_teleport_to"))
}
teleport_event :: proc(self: ^Self, _: Dim, old: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let ctx = self.0.who_context(Some(Who::Player), None);
    // rust: self.0
    // rust: .post_game_event("minecraft:teleport", [old.x, old.y, old.z], ctx);
    // rust: Ok(())
}
is_fox :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
teleport_sound :: proc(self: ^Self, _: Dim, at: Vec3, _: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.audio.play(
    // rust: "minecraft:item.chorus_fruit.teleport",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: Ok(())
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(BlockPos::containing(self.at()))
}
    // rust: fn directional_particles(
    // rust: &mut self,
    // rust: _: Dim,
    // rust: origin: BlockPos,
    // rust: offset: i32,
    // rust: ) -> Result<(), Infallible> {
    // rust: self.0
    // rust: .level_event_at(2017, [origin.x, origin.y, origin.z], offset);
    // rust: Ok(())
}
reset_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(p) = self.0.player.as_mut() {
    // rust: p.fall_distance = 0.0;
}
    // rust: Ok(())
}
reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(p) = self.0.player.as_mut() {
    // rust: p.impulse.reset();
}
    // rust: Ok(())
}
}
