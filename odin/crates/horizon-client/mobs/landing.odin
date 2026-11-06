//! Transpiled from Horizon Rust crate
package horizon_client_landing

import "core:fmt"
import "core:mem"
import "core:math"

// PURPOSE: a mob landing on a block runs that block's registered `Block.fallOn` rule (hay, honey, slime, powder snow, bed, stalagmite, farmland, turtle egg), as the player already does in landing.rs.
// WHY: mobs used to take the whole fall whatever block they landed on (a pig falling 8 blocks onto powder snow lost 6 health; vanilla loses none).
// REFS: Block.fallOn and its overrides (HayBlock, HoneyBlock, SlimeBlock, PowderSnowBlock, BedBlock, PointedDripstoneBlock, FarmlandBlock, TurtleEggBlock); crate::landing (the player's adapter); horizon_world::block_landing.
// LOGS: none; the block writes and sounds go out as MobEvents.
// READS-BY: mobs::living::Mob::fall_on_block.
// ENDS-WHEN: the landing registry covers a mob's whole fall and this adapter is merged into crate::landing.
// use super::{DamageKind, Mob, MobEvent, MobWorld};
// use crate::collisions::SceneCollisions;
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: block_entity_push::BlockPushWorld,
    // rust: block_landing::{
    // rust: BlockLandingWorld, DamageSourceOwner, LandingDamage, LandingEvent, LandingSound,
    // rust: },
    // rust: entity_obstruction::EntityIdentity,
    // rust: registry::BlockStateId,
}

// A mob mid-landing: the block under it is at `pos`, the fall was `distance`.
    // rust: pub(super) struct MobLanding<'a, 'w> {
    // rust: pub mob: &'a mut Mob,
    // rust: pub w: &'a MobWorld<'w>,
    // rust: pub events: &'a mut Vec<MobEvent>,
    // rust: pub pos: [i32; 3],
}
    // rust: impl MobLanding<'_, '_> {
at :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.mob.position;
    // rust: [p.x, p.y, p.z]
}
}
    // rust: impl BlockPushWorld for MobLanding<'_, '_> {
    // rust: type Error = String;
collision_shape :: proc(self: ^Self, state: BlockStateId, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.w.world,
    // rust: binding: self.w.collision,
    // rust: subject: None,
}
    // rust: self.w
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .map_err(|e| e.to_string())
}
    // Only the landing mob is lifted off a block that grows under it.
entities :: proc(self: ^Self, bounds: Aabb) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(if bounds.intersects(self.mob.bounds()) {
    // rust: vec![EntityIdentity(0)]
    // rust: } else {
    // rust: vec![]
    // rust: })
}
entity_bounds :: proc(self: ^Self, _: EntityIdentity) -> A {
    // Ported from Horizon
    return {}
}
    // rust: self.mob.bounds()
}
teleport_relative :: proc(self: ^Self, _: EntityIdentity, m: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.mob.position = Vec3::new(
    // rust: self.mob.position.x + m.x,
    // rust: self.mob.position.y + m.y,
    // rust: self.mob.position.z + m.z,
    // rust: );
    // rust: Ok(())
}
}
    // rust: impl BlockLandingWorld for MobLanding<'_, '_> {
    // rust: type DamageSource = DamageKind;
    // The sound event, or none for a sound a mob's landing never makes.
    // rust: type Sound = Option<&'static str>;
is_server_level :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
is_client_side :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
random_float :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.random.next_float())
}
random_int :: proc(self: ^Self, bound: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.mob
    // rust: .random
    // rust: .next_int_bound(bound)
    // rust: .map_err(|e| e.to_string())
}
under_spawn_protection :: proc(self: ^Self, _: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
mob_griefing :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.w.mob_griefing)
}
entity_dimensions :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (self.mob.width(), self.mob.height())
}
    // A mob never sneaks, so nothing suppresses a slime block's bounce.
suppressing_bounce :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
    // rust: fn damage_source(
    // rust: &mut self,
    // rust: _: DamageSourceOwner,
    // rust: kind: LandingDamage,
    // rust: ) -> Result<DamageKind, String> {
    // rust: Ok(match kind {
    // rust: LandingDamage::Fall => DamageKind::Fall,
    // rust: LandingDamage::Stalagmite => DamageKind::Stalagmite,
    // rust: })
}
    // rust: fn cause_fall_damage(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: source: DamageKind,
    // rust: ) -> Result<bool, String> {
    // rust: let contact = Some((self.w, self.pos));
    // rust: Ok(self
    // rust: .mob
    // rust: .cause_fall_damage_at(distance, multiplier, self.events, contact, source))
}
known_sound :: proc(self: ^Self, sound: LandingSound) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match sound {
    // rust: LandingSound::HoneySlide => Some("block.honey_block.slide"),
    // rust: LandingSound::HoneyFall => Some("block.honey_block.fall"),
    // rust: LandingSound::TurtleEggBreak => Some("entity.turtle.egg_break"),
    // rust: LandingSound::ShelfMushroomBounce => None,
}
}
    // LivingEntity.getFallDamageSound: Monster.getFallSounds is the hostile pair.
living_fall_sound :: proc(self: ^Self, big: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let monster = super::ai::is_monster(self.mob.species());
    // rust: Ok(Some(match (monster, big) {
    // rust: (true, true) => "entity.hostile.big_fall",
    // rust: (true, false) => "entity.hostile.small_fall",
    // rust: (false, true) => "entity.generic.big_fall",
    // rust: (false, false) => "entity.generic.small_fall",
    // rust: }))
}
    // rust: fn entity_sound(
    // rust: &mut self,
    // rust: sound: Option<&'static str>,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), String> {
    // rust: if let Some(name) = sound
    // rust: && !self.mob.silent
    // rust: {
    // rust: let at = self.at();
    // rust: self.events.push(MobEvent::Sound(name, at, volume, pitch));
}
    // rust: Ok(())
}
    // rust: fn block_sound(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: sound: Option<&'static str>,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), String> {
    // rust: if let Some(name) = sound {
    // rust: let at = [
    // rust: f64::from(position.x) + 0.5,
    // rust: f64::from(position.y) + 0.5,
    // rust: f64::from(position.z) + 0.5,
    // rust: ];
    // rust: self.events.push(MobEvent::Sound(name, at, volume, pitch));
}
    // rust: Ok(())
}
broadcast_entity_event :: proc(self: ^Self, event: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.at();
    // rust: self.events.push(MobEvent::EntityEvent {
    // rust: mob: self.mob.id,
    // rust: event: event as i8,
    // rust: at,
    // rust: });
    // rust: Ok(())
}
destroy_block :: proc(self: ^Self, position: BlockPos, _drops: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let air = self
    // rust: .w
    // rust: .registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or("missing air")?;
    // rust: self.set_block(position, air, 3)
}
    // rust: fn set_block(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: state: BlockStateId,
    // rust: _: u32,
    // rust: ) -> Result<bool, String> {
    // rust: self.events.push(MobEvent::SetBlock {
    // rust: pos: [position.x, position.y, position.z],
    // rust: state,
    // rust: });
    // rust: Ok(true)
}
    // Neighbour updates and the break particles ride on the host's SetBlock.
    // rust: fn block_event(
    // rust: &mut self,
    // rust: _: LandingEvent,
    // rust: _: BlockPos,
    // rust: _: BlockStateId,
    // rust: _: bool,
    // rust: ) -> Result<(), String> {
    // rust: Ok(())
}
level_event :: proc(self: ^Self, _: i32, _: BlockPos, _: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
}
