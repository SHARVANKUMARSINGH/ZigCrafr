//! Transpiled from Horizon Rust crate
package horizon_client_nautili

import "core:fmt"
import "core:mem"
import "core:math"

// Nautili on the game side (`AbstractNautilus.mobInteract`): taming with
// pufferfish, feeding, the saddle and armour, riding, and the zombie
// nautilus a drowned with a trident sometimes rides.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{Species, nautilus},
}
// use horizon_core::random::RandomSource;

    // rust: impl Game<'_> {
item_tagged :: proc(self: ^Self, tag: string, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.res
    // rust: .items()
    // rust: .item_tags
    // rust: .get(tag)
    // rust: .is_some_and(|t| t.contains(item))
}
    // `AbstractNautilus.usePlayerItem`: bucketed fish leave a water bucket.
use_nautilus_food :: proc(self: ^Self, item: string) {
}
    // rust: let bucket = self.item_tagged("minecraft:nautilus_bucket_food", item);
    // rust: self.consume_held();
    // rust: if bucket && !self.creative {
    // rust: let water = ItemStack::new("minecraft:water_bucket", 1);
    // rust: if self.inventory[self.selected].is_none() {
    // rust: self.inventory[self.selected] = Some(water);
    // rust: } else if let Some(rest) = self.give(water) {
    // rust: let at = self.eye_position().unwrap_or([0.0; 3]);
    // rust: self.spawn_item(rest, at, [0.0; 3], 40);
}
}
}
nautilus_sound :: proc(self: ^Self, index: uint, sound: string) {
}
    // rust: let at = self.mobs[index].center();
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), 1.0, 1.0);
}
    // `AbstractNautilus.mobInteract`. Returns whether the click was used.
    // rust: pub(super) fn interact_nautilus(&mut self, index: usize, item: &str) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if !m.alive() || Some(m.id) == self.riding {
    // rust: return false;
}
    // rust: let taming: Vec<String> = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:nautilus_taming_items")
    // rust: .map(|t| t.iter().cloned().collect())
    // rust: .unwrap_or_default();
    // rust: let food = nautilus::is_food(m, item, &taming);
    // rust: let sneaking =
    // rust: self.keys.held(Action::Sneak) || self.keys.raw(&winit::keyboard::KeyCode::ShiftRight);
    // rust: let tame = m.extra.tame;
    // rust: if m.is_baby() {
            // Animal.mobInteract: food grows a baby up by a tenth.
    // rust: if !food {
    // rust: return false;
}
    // rust: let m = &mut self.mobs[index];
    // rust: if !m.extra.age_locked {
    // rust: let secs = ((-m.extra.age / 20) as f32 * 0.1) as i32;
    // rust: horizon_client::mobs::ai::age_up(m, secs, true);
}
    // rust: let sound = nautilus::eat_sound(m);
    // rust: self.use_nautilus_food(item);
    // rust: self.nautilus_sound(index, sound);
    // rust: return true;
}
        // AbstractNautilus.mobInteract: shift + use on a tame adult opens its
        // saddle and armour screen (openCustomInventoryScreen).
    // rust: if tame && sneaking {
    // rust: self.open_mount_menu(index);
    // rust: return true;
}
    // rust: if !item.is_empty() {
    // rust: if !tame && food {
                // tryToTame: one time in three.
    // rust: self.use_nautilus_food(item);
    // rust: let acting = self.acting_player_uuid();
    // rust: let m = &mut self.mobs[index];
    // rust: let tamed = m.random.next_int_bound(3).unwrap_or(1) == 0;
    // rust: if tamed {
    // rust: m.extra.tame = true;
    // rust: m.extra.owner = Some(acting);
    // rust: m.persistent = true;
    // rust: m.nav_stop();
    // rust: m.ai.target = None;
}
    // rust: let sound = nautilus::eat_sound(m);
                // TamableAnimal.spawnTamingParticles (entity event 7 or 6).
    // rust: self.mob_event_particles(self.mobs[index].id, if tamed { 7 } else { 6 });
    // rust: self.nautilus_sound(index, sound);
    // rust: if tamed {
    // rust: let view = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_entity("minecraft:tame_animal", "entity", &view);
}
    // rust: return true;
}
    // rust: let m = &self.mobs[index];
    // rust: if food && m.health < m.attrs.max_health {
                // feed(player, hand, stack, 2, 1).
    // rust: let sound = nautilus::eat_sound(m);
    // rust: let m = &mut self.mobs[index];
    // rust: m.heal(2.0);
    // rust: self.use_nautilus_food(item);
    // rust: self.nautilus_sound(index, sound);
    // rust: return true;
}
            // Equippable.equipOnInteract: a saddle or nautilus armour on a
            // tame adult.
    // rust: let m = &mut self.mobs[index];
    // rust: if item == "minecraft:saddle" && tame && !m.extra.saddled {
    // rust: let held = self.inventory[self.selected].clone();
    // rust: m.set_saddle(held);
    // rust: let sound = nautilus::saddle_sound(m);
    // rust: self.nautilus_sound(index, sound);
    // rust: self.consume_held();
    // rust: return true;
}
    // rust: if item.ends_with("_nautilus_armor") && tame && m.extra.body.is_none() {
    // rust: m.extra.body = Some(item.into());
    // rust: self.nautilus_sound(index, "item.armor.equip_nautilus");
    // rust: self.consume_held();
    // rust: return true;
}
}
    // rust: if tame && !food {
            // doPlayerRide.
    // rust: let id = self.mobs[index].id;
    // rust: if !self.may_board() || !self.native_may_board(id) {
    // rust: return true;
}
    // rust: self.break_leash(id, true, false);
    // rust: self.yaw = self.mobs[index].yaw;
    // rust: self.mount.reset_jump();
    // rust: self.start_riding(id);
    // rust: return true;
}
        // Animal.mobInteract: a tame adult fed falls in love (not a zombie).
    // rust: let m = &mut self.mobs[index];
    // rust: if food && m.species() == Species::Nautilus && m.extra.age == 0 && m.extra.in_love <= 0 {
    // rust: m.extra.in_love = 600;
    // rust: m.extra.love_player = true;
    // rust: let sound = nautilus::eat_sound(m);
    // rust: let id = m.id;
    // rust: self.love_cause.insert(id, self.lan_acting);
    // rust: let kind = self.mobs[index].kind.id.clone();
    // rust: self.native_entity_enter_love_mode(id, &kind, self.lan_acting_uuid);
    // rust: self.use_nautilus_food(item);
    // rust: self.nautilus_sound(index, sound);
            // Animal.setInLove: entity event 18.
    // rust: self.mob_event_particles(self.mobs[index].id, 18);
    // rust: return true;
}
    // rust: false
}
}
