//! Transpiled from Horizon Rust crate
package horizon_client_item_particles

import "core:fmt"
import "core:mem"
import "core:math"

// The sprites of item particles: `BreakingItemParticle.ItemParticleProvider.getSprite`
// resolves the stack's model for the ground and picks a layer's particle sprite.
// use super::Game;
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: item_render::stack_view,
    // rust: items::ItemStack,
    // rust: particles::{self, ParticleOptions, ParticleType},
}
// use horizon_core::random::RandomSource;
// use horizon_world::player_inventory::EquipmentSlot;
// use serde_json::Value;

    // rust: impl Game<'_> {
    // `ItemParticleOption(ITEM, stack)`: the layer particle sprites of the
    // stack's model resolved for the ground, with seed 0.
    // rust: pub(super) fn item_particle(&self, stack: &ItemStack) -> ParticleOptions {
    // rust: let state = self.resolve_item(stack, DisplayContext::Ground, None, 0);
    // rust: ParticleOptions::item(state.layers.iter().map(|l| l.particle.clone()).collect())
}
    // `LivingEntity.spawnItemParticles(stack, count)` for the local player,
    // drawing from the world random as its eating sounds do.
    // rust: pub(super) fn eat_particles(&mut self, stack: &ItemStack, count: u32) {
    // rust: let Some(p) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: let eye_y = self.eye_position().map_or(p.y, |e| e[1]);
    // rust: let options = self.item_particle(stack);
    // rust: let mut spawned = Vec::new();
    // rust: particles::item_use_particles(
    // rust: &mut self.world.random,
    // rust: self.pitch,
    // rust: self.yaw,
    // rust: [p.x, p.y, p.z],
    // rust: eye_y,
    // rust: count,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    // `LivingEntity.handleEntityEvent` 47 to 52, 65 and 68 from a server:
    // the entity's item in `slot` broke, so `breakItem` the stack this
    // client still has there (the slot is emptied by a later update).
    // rust: pub(super) fn remote_equipment_break(&mut self, id: i32, slot: EquipmentSlot) {
    // rust: if self.remote.as_ref().is_some_and(|r| r.entity_id == id) {
    // rust: let stack = match slot {
    // rust: EquipmentSlot::MainHand => self.held().cloned(),
    // rust: EquipmentSlot::OffHand => self.offhand.clone(),
    // rust: EquipmentSlot::Head => self.armor[0].clone(),
    // rust: EquipmentSlot::Chest => self.armor[1].clone(),
    // rust: EquipmentSlot::Legs => self.armor[2].clone(),
    // rust: EquipmentSlot::Feet => self.armor[3].clone(),
    // rust: EquipmentSlot::Body | EquipmentSlot::Saddle => None,
}
    // rust: let Some(stack) = stack else {
    // rust: return;
}
    // rust: if let Some(p) = self.player.as_ref().map(|p| p.position) {
    // rust: self.break_sound_at(&stack, [p.x, p.y, p.z]);
}
    // rust: self.eat_particles(&stack, 5);
    // rust: return;
}
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id as u32) else {
    // rust: return;
}
    // rust: let Some(stack) = m.item_by_slot(slot) else {
    // rust: return;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let (eye, pitch, yaw, silent) = (m.eye_height(), m.head_pitch, m.yaw, m.silent);
    // rust: if !silent {
    // rust: self.break_sound_at(&stack, at);
}
    // rust: let options = self.item_particle(&stack);
    // rust: let mut spawned = Vec::new();
    // rust: particles::item_use_particles(
    // rust: &mut self.world.random,
    // rust: pitch,
    // rust: yaw,
    // rust: at,
    // rust: at[1] + eye,
    // rust: 5,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    // `LivingEntity.breakItem`'s sound: the stack's `break_sound` (none when
    // the component is removed), heard by this client only
    // (`playLocalSound`) at the entity's feet, at 0.8 volume and a pitch of
    // 0.8 to 1.2.
    // rust: pub(super) fn break_sound_at(&mut self, stack: &ItemStack, at: [f64; 3]) {
    // rust: let models = &self.pack.item_renderer.models;
    // rust: let sound = match models
    // rust: .components(&stack_view(stack))
    // rust: .get("minecraft:break_sound")
    // rust: {
    // rust: Some(Value::String(id)) => id.clone(),
    // rust: Some(Value::Object(inline)) => match inline.get("sound_id") {
    // rust: Some(Value::String(id)) => id.clone(),
    // rust: _ => return,
    // rust: },
    // rust: _ => return,
}
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.4;
    // rust: self.audio.play_unshared(&sound, Some(at), 0.8, pitch);
}
    // The slime ball, snowball and cobweb models behind `item_slime`,
    // `item_snowball` and `item_cobweb`, resolved on first use.
    // rust: pub(super) fn ensure_item_particle_sprites(&mut self) {
    // rust: if !self.particles.item_sprites.is_empty() {
    // rust: return;
}
    // rust: for (ty, item) in [
    // rust: (ParticleType::ItemSlime, "minecraft:slime_ball"),
    // rust: (ParticleType::ItemSnowball, "minecraft:snowball"),
    // rust: (ParticleType::ItemCobweb, "minecraft:cobweb"),
    // rust: ] {
    // rust: let sprites = self
    // rust: .item_particle(&ItemStack::new(item, 1))
    // rust: .item
    // rust: .unwrap_or_default();
    // rust: self.particles.item_sprites.insert(ty, sprites);
}
}
}
