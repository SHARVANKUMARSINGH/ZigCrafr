//! Transpiled from Horizon Rust crate
package horizon_client_ghasts

import "core:fmt"
import "core:mem"
import "core:math"

// Happy ghasts on the game side: putting a harness on (and shearing it
// off), riding, getting off on top, and the ghastling a dried ghast block
// hatches.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{MobEvent, happy_ghast},
}
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_world::registry::BlockStateId;

    // rust: impl Game<'_> {
    // Client `EntityGetter.getEntityCollisions` for the player: the
    // entities that `canBeCollidedWith` it, solid happy ghasts, living
    // shulkers (`Shulker.canBeCollidedWith`) and boats
    // (`AbstractBoat.canBeCollidedWith`), except the player's own vehicle.
    // rust: pub(super) fn player_entity_collisions(&self) -> Vec<Aabb> {
    // rust: let Some(p) = &self.player else {
    // rust: return Vec::new();
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: (m.species() == horizon_client::mobs::Species::HappyGhast
    // rust: && Some(m.id) != self.riding
    // rust: && happy_ghast::collides_with_player(m, p.position.y))
    // rust: || (m.species() == horizon_client::mobs::Species::Shulker && m.alive())
    // rust: })
    // rust: .map(|m| m.bounds())
    // rust: .chain(
    // rust: self.boats
    // rust: .iter()
    // rust: .filter(|b| Some(b.id) != self.riding)
    // rust: .map(super::boats::Boat::bounds),
    // rust: )
    // rust: .collect()
}
    // `EntityGetter.getEntityCollisions` for a dropped item: the entities whose
    // `canBeCollidedWith(item)` is true. A boat and a minecart always, a living shulker,
    // and a happy ghast only while it is held still (`isOnStillTimeout`): a player on its
    // back keeps it still, so an item dropped there stays on top.
    // rust: pub(super) fn item_entity_collisions(&self) -> Vec<Aabb> {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: (m.species() == horizon_client::mobs::Species::HappyGhast
    // rust: && m.alive()
    // rust: && !m.is_baby()
    // rust: && happy_ghast::on_still_timeout(m))
    // rust: || (m.species() == horizon_client::mobs::Species::Shulker && m.alive())
    // rust: })
    // rust: .map(|m| m.bounds())
    // rust: .chain(self.boats.iter().map(super::boats::Boat::bounds))
    // rust: .chain(self.carts.iter().map(|c| c.bounds()))
    // rust: .collect()
}
    // `HappyGhast.mobInteract`. Returns whether the click was used.
    // rust: pub(super) fn interact_happy_ghast(&mut self, index: usize, item: &str) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if !m.alive() || Some(m.id) == self.riding {
    // rust: return false;
}
    // rust: if m.is_baby() {
            // Animal.mobInteract: food grows it up.
    // rust: return false;
}
    // rust: let at = m.center();
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let harnessed = m.extra.body.is_some();
        // Equippable.equipOnInteract: a harness goes on a bare adult.
    // rust: if item.ends_with("_harness") && item.starts_with("minecraft:") && !harnessed {
    // rust: self.mobs[index].extra.body = Some(item.into());
    // rust: self.audio
    // rust: .play("minecraft:entity.happy_ghast.equip", Some(at), 1.0, 1.0);
    // rust: self.consume_held();
    // rust: return true;
}
        // Equippable.canBeSheared: shears take the harness off again.
    // rust: if item == "minecraft:shears"
    // rust: && harnessed
    // rust: && !sneaking
    // rust: && let Some(harness) = self.mobs[index].extra.body.take()
    // rust: {
    // rust: self.audio
    // rust: .play("minecraft:entity.happy_ghast.unequip", Some(at), 1.0, 1.0);
    // rust: self.spawn_item(ItemStack::new(&harness, 1), at, [0.0, 0.2, 0.0], 10);
    // rust: self.damage_held_tool();
    // rust: return true;
}
    // rust: if harnessed && !sneaking {
            // doPlayerRide.
    // rust: let id = self.mobs[index].id;
    // rust: if !self.may_board() || !self.native_may_board(id) {
    // rust: return true;
}
    // rust: self.break_leash(id, true, false);
    // rust: let was_empty = self.mobs[index].rider.is_none();
            // addPassenger: the rider is not standing on top, so no still
            // timeout.
    // rust: self.mobs[index].extra.counter = 0;
    // rust: self.yaw = self.mobs[index].yaw;
    // rust: self.mount.reset_jump();
    // rust: if was_empty {
    // rust: let down = happy_ghast::goggles(true, &self.mobs[index]);
    // rust: let _ = self.handle_mob_events(vec![down]);
}
    // rust: self.start_riding(id);
    // rust: return true;
}
    // rust: false
}
    // Getting off lands on top of it.
    // rust: pub(super) fn dismount_happy_ghast(&mut self, id: u32) {
        // removePassenger: held still for half a second, and with no one
        // aboard the ghast forgets its home.
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.extra.counter = 10;
    // rust: m.ai.clear_home();
}
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let top = Vec3::new(
    // rust: m.position.x,
    // rust: m.position.y + f64::from(m.height()),
    // rust: m.position.z,
    // rust: );
    // rust: let up: MobEvent = happy_ghast::goggles(false, m);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = top;
    // rust: p.velocity = Vec3::ZERO;
}
    // rust: let _ = self.handle_mob_events(vec![up]);
}
    // `DriedGhastBlock.spawnGhastling`: a ghastling facing the way the block did.
    // rust: pub(super) fn spawn_ghastling(&mut self, pos: [i32; 3], state: BlockStateId) {
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let facing = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("facing").cloned());
    // rust: let yaw = match facing.as_deref() {
    // rust: Some("north") => 180.0,
    // rust: Some("east") => 270.0,
    // rust: Some("west") => 90.0,
    // rust: _ => 0.0,
}
    // rust: if let Some(id) = self.spawn_mob("minecraft:happy_ghast", at, true)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
            // DriedGhastBlock.spawnGhastling sets the baby age before
            // addFreshEntity, so ageBoundaryReached runs the ghastling setup
            // (`babyGhastSetup`) while the mob is still being hatched: its
            // goals, navigation and brain are a ghastling's before its first
            // tick, not an adult's until the next aiStep.
    // rust: horizon_client::mobs::finalize::set_age(m, -24000);
    // rust: m.yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: m.head_yaw = yaw;
    // rust: self.audio.play_bound(
    // rust: "minecraft:entity.ghastling.spawn",
    // rust: 4,
    // rust: 1.0,
    // rust: 1.0,
    // rust: horizon_client::sound_engine::SoundEntity::new(
    // rust: m.id,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.silent,
    // rust: ),
    // rust: None,
    // rust: );
}
}
}
