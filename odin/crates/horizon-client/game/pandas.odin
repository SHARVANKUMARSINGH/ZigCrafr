//! Transpiled from Horizon Rust crate
package horizon_client_pandas

import "core:fmt"
import "core:mem"
import "core:math"

// Pandas on the game side: the food they find on the ground and pick up
// (`Mob.aiStep`, `Panda.pickUpItem`), the bamboo a player gives them
// (`Panda.mobInteract`), the start a sneeze gives the grown pandas about,
// and the crumbs and the sneeze a window draws.
// use super::{
    // rust: Game,
    // rust: pickups::{Collector, Taken},
}
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{Species, panda},
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::geometry::Vec3;

    // rust: impl Game<'_> {
    // `Panda.canPickUpAndEat`'s tag.
panda_eats_from_ground :: proc(self: ^Self, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:panda_eats_from_ground")
    // rust: .is_some_and(|tag| tag.contains(item))
}
    // A panda takes what lies at its feet when its mouth is free, and
    // looks for food within 6 and 8 blocks for `PandaSitGoal`.
    // rust: pub(super) fn tick_pandas(&mut self) {
    // rust: let griefing = self.ui.rules.bool("mob_griefing");
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Panda || !m.alive() || !self.creatures.ticked.contains(&m.id)
    // rust: {
    // rust: continue;
}
    // rust: let id = m.id;
    // rust: let wants = |g: &Self, e: &horizon_client::entities::ItemEntity| {
    // rust: e.pickup_delay == 0 && g.panda_eats_from_ground(&e.stack.item)
}
            // Mob.aiStep: the items within the box grown by (1, 0, 1).
    // rust: if griefing && m.can_pick_up_loot() && m.extra.main_hand.is_none() {
    // rust: let reach = m.bounds().inflate(Vec3::new(1.0, 0.0, 1.0));
    // rust: let taken = self
    // rust: .dropped
    // rust: .iter()
    // rust: .position(|e| wants(self, e) && reach.intersects(e.bounds()));
    // rust: if let Some(j) = taken {
    // rust: let e = self.remove_dropped(j);
    // rust: self.add_pickup(Taken::Item(Box::new(e.clone())), Collector::Mob(id));
    // rust: panda::hold(&mut self.mobs[i], &e.stack.item, e.stack.count, true);
}
}
    // rust: let m = &self.mobs[i];
    // rust: let area = |r: f64| m.bounds().inflate(Vec3::new(r, r, r));
    // rust: let (near, wide) = (area(6.0), area(8.0));
    // rust: let food_near = self
    // rust: .dropped
    // rust: .iter()
    // rust: .any(|e| wants(self, e) && near.intersects(e.bounds()));
    // rust: let food_at = self
    // rust: .dropped
    // rust: .iter()
    // rust: .find(|e| wants(self, e) && wide.intersects(e.bounds()))
    // rust: .map(|e| [e.position.x, e.position.y, e.position.z]);
    // rust: panda::set_food(&mut self.mobs[i], food_near, food_at);
}
}
    // `Panda.mobInteract` for a click with `item`; whether the click is taken.
    // rust: pub(super) fn interact_panda(&mut self, index: usize, item: &str) -> bool {
    // rust: let creative = self.creative;
    // rust: let m = &mut self.mobs[index];
    // rust: if panda::scared(m) {
    // rust: return false;
}
    // rust: if panda::get_up(m) {
    // rust: return true;
}
        // A baby holding a golden_dandelion goes on to `AgeableMob.mobInteract`,
        // which `interact_mob` answered before this; anything else that is not
        // bamboo passes.
    // rust: if !m.kind.food.iter().any(|f| f == item) {
    // rust: return false;
}
    // rust: if m.ai.target.is_some() {
    // rust: panda::got_bamboo(m);
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let id = m.id;
    // rust: let mut dropped = None;
    // rust: let mut loved = false;
    // rust: if m.is_baby() {
            // Panda.mobInteract: a baby an age lock holds back passes.
    // rust: if !horizon_client::mobs::ai::can_age_up(m) {
    // rust: return false;
}
            // ageUp((int) (-getAge() / 20 * 0.1F), true).
    // rust: let seconds = ((-m.extra.age / 20) as f32 * 0.1) as i32;
    // rust: horizon_client::mobs::ai::age_up(m, seconds, true);
    // rust: } else if m.extra.age == 0 && m.extra.in_love <= 0 {
    // rust: m.extra.in_love = 600;
    // rust: m.extra.love_player = true;
    // rust: loved = true;
    // rust: } else {
    // rust: if panda::is_sitting(m) || m.fluids.in_water {
    // rust: return false;
}
    // rust: panda::try_to_sit(m);
    // rust: panda::start_eating(m);
            // What it held falls, unless the player has infinite materials.
    // rust: if let Some(held) = m.extra.main_hand.clone()
    // rust: && !creative
    // rust: {
    // rust: dropped = Some(ItemStack::new(&held, panda::held_count(m)));
}
    // rust: panda::hold(m, item, 1, false);
}
    // rust: if loved {
    // rust: self.love_cause.insert(id, self.lan_acting);
    // rust: let kind = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(super::native_hooks::mob_kind)
    // rust: .unwrap_or_default();
    // rust: self.native_entity_enter_love_mode(id, &kind, self.lan_acting_uuid);
}
    // rust: self.consume_held();
    // rust: if let Some(stack) = dropped {
    // rust: self.spawn_item(stack, at, [0.0, 0.2, 0.0], 10);
}
    // rust: true
}
    // `Panda.afterSneeze`: the grown pandas within 10 blocks of a cub jump.
    // rust: pub(super) fn panda_sneezed(&mut self, id: u32) {
    // rust: let Some(area) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.bounds().inflate(Vec3::new(10.0, 10.0, 10.0)))
    // rust: else {
    // rust: return;
}
    // rust: let mut mobs = std::mem::take(&mut self.mobs);
    // rust: let w = self.mob_world_base(&[]);
    // rust: for m in &mut mobs {
    // rust: if m.species() == Species::Panda
    // rust: && !m.is_baby()
    // rust: && m.on_ground
    // rust: && !m.fluids.in_water
    // rust: && panda::can_perform_action(m, panda::scared(m))
    // rust: && area.intersects(m.bounds())
    // rust: {
                // LivingEntity.jumpFromGround.
    // rust: m.needs_sync = true;
    // rust: let power = f64::from(m.jump_power(&w));
    // rust: if power > 1.0e-5 {
    // rust: m.velocity.y = power.max(m.velocity.y);
}
}
}
    // rust: self.mobs = mobs;
}
    // What a window draws of its pandas: the crumbs of a bite
    // (`addEatingParticles`) and the sneeze's particle.
    // rust: pub(super) fn panda_effects(&mut self) {
    // rust: let mut bites = Vec::new();
    // rust: let mut sneezes = Vec::new();
    // rust: for m in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.species() == Species::Panda)
    // rust: {
    // rust: let (crumbs, sneeze) = panda::effects(m);
    // rust: if let (Some(crumbs), Some(item)) = (crumbs, m.extra.main_hand.clone()) {
    // rust: bites.push((item, crumbs));
}
    // rust: sneezes.extend(sneeze);
}
    // rust: for (item, crumbs) in bites {
    // rust: let options = self.item_particle(&ItemStack::new(&item, 1));
    // rust: for (at, velocity) in crumbs {
    // rust: self.particles.add(&options, at, velocity);
}
}
    // rust: let options = ParticleOptions::simple(ParticleType::Sneeze);
    // rust: for (at, velocity) in sneezes {
    // rust: self.particles.add(&options, at, velocity);
}
}
}
