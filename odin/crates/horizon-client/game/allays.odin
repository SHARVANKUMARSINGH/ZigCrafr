//! Transpiled from Horizon Rust crate
package horizon_client_allays

import "core:fmt"
import "core:mem"
import "core:math"

// Allays on the game side: spotting and picking up matching drops,
// throwing their load to the player or note block, dancing to jukeboxes,
// and the hand-over interaction (`Allay.mobInteract`).
// use super::Game;
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: first_person::Hand,
    // rust: items::ItemStack,
    // rust: mobs::{Species, allay},
}
// use horizon_core::random::RandomSource;

    // rust: impl Game<'_> {
    // The client's `Allay.mobInteract` runs before the server's response.
    // rust: pub(super) fn predict_allay_interaction(
    // rust: &mut self,
    // rust: index: usize,
    // rust: hand: Hand,
    // rust: offered: Option<ItemStack>,
    // rust: ) -> bool {
//         use allay::interaction::{Interaction, predict};
    // rust: let duplicates = offered.as_ref().is_some_and(|s| {
    // rust: self.items()
    // rust: .item_tags
    // rust: .get("minecraft:duplicates_allays")
    // rust: .is_some_and(|tag| tag.contains(&*s.item))
    // rust: });
    // rust: let actor = self.acting_uuid();
    // rust: let Some(result) = predict(
    // rust: &mut self.mobs[index],
    // rust: offered.as_ref(),
    // rust: hand == Hand::Main,
    // rust: duplicates,
    // rust: actor,
    // rust: ) else {
    // rust: return false;
}
    // rust: self.play_mob_bound_sound(index, result.sound(), 6, 2.0, 1.0, false);
    // rust: match result {
    // rust: Interaction::Duplicate | Interaction::Give => {
    // rust: self.with_hand(hand, Self::consume_held);
}
    // rust: Interaction::Take(stack) => {
                // Player.addItem returns leftovers on the client without
                // spawning an item entity; the server owns any dropped stack.
    // rust: let _ = self.give(stack);
}
}
    // rust: true
}

    // rust: pub(super) fn tick_allays(&mut self) {
    // rust: let griefing = self.ui.rules.bool("mob_griefing");
        // The playing jukeboxes, found at the first allay: no allay starts
        // or stops one, and the block entities run into the thousands.
    // rust: let mut jukeboxes: Option<Vec<(i32, i32, i32)>> = None;
    // rust: for i in 0..self.mobs.len() {
    // rust: if self.mobs[i].species() != Species::Allay
    // rust: || !self.mobs[i].alive()
    // rust: || !self.creatures.ticked.contains(&self.mobs[i].id)
    // rust: {
    // rust: continue;
}
    // rust: let pos = self.mobs[i].position;
            // Dancing: a playing jukebox within 10 blocks.
    // rust: let jukeboxes = jukeboxes.get_or_insert_with(|| {
    // rust: self.world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter(|(_, e)| matches!(e, BlockEntity::Jukebox(j) if j.playing))
    // rust: .map(|(k, _)| *k)
    // rust: .collect()
    // rust: });
    // rust: let nearest = jukeboxes
    // rust: .iter()
    // rust: .map(|k| {
    // rust: (f64::from(k.0) + 0.5 - pos.x).powi(2)
    // rust: + (f64::from(k.1) + 0.5 - pos.y).powi(2)
    // rust: + (f64::from(k.2) + 0.5 - pos.z).powi(2)
    // rust: })
    // rust: .fold(f64::INFINITY, f64::min);
            // `Allay.setDancing` wants effective AI: a `NoAI` allay never dances.
    // rust: let panicking = horizon_client::mobs::goals::should_panic(&self.mobs[i]);
    // rust: self.mobs[i].extra.flag = allay::dances(self.mobs[i].no_ai, panicking, nearest);
    // rust: let Some(held) = self.mobs[i].extra.main_hand_stack().cloned() else {
    // rust: self.mobs[i].extra.point = None;
    // rust: continue;
}
            // The held filter chooses item types; the pocket independently
            // decides whether the candidate's full components can fit.
    // rust: let wants = self.mobs[i].can_pick_up_loot() && griefing;
    // rust: let room = |stack: &ItemStack| {
    // rust: self.mobs[i].extra.allay.as_ref().map_or(0, |st| {
    // rust: st.room(stack, self.mobs[i].kind.inventory_stack_limit(stack))
    // rust: })
}
    // rust: let reach = allay::pickup_reach(self.mobs[i].bounds());
            // GoToWantedItem: a stack it considers equal within 32 that the
            // allay sees (NearestItemSensor's hasLineOfSight, eye to eye). The
            // sensor is the brain's, so without AI only `Mob.aiStep`'s looting
            // loop runs: it takes an equal drop already in `getPickupReach`.
    // rust: let wanted = if !wants {
    // rust: None
    // rust: } else if self.mobs[i].no_ai {
    // rust: self.dropped.iter().position(|e| {
    // rust: e.pickup_delay == 0
    // rust: && allay::considers_item_equal(&held, &e.stack)
    // rust: && room(&e.stack) > 0
    // rust: && reach.contains(e.position)
    // rust: })
    // rust: } else {
    // rust: let w = self.mob_world_base(&[]);
    // rust: let eye = horizon_core::geometry::Vec3::new(pos.x, self.mobs[i].eye_y(), pos.z);
                // The sensor looks in the allay's box grown by (32, 16, 32).
    // rust: let b = self.mobs[i].bounds();
    // rust: let (low, high) = (b.min_position().y - 16.0, b.max_position().y + 16.0);
    // rust: self.dropped
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, e)| {
    // rust: e.pickup_delay == 0
    // rust: && allay::considers_item_equal(&held, &e.stack)
    // rust: && room(&e.stack) > 0
    // rust: })
    // rust: .map(|(j, e)| (j, e.position.distance_squared(pos)))
    // rust: .filter(|(_, d)| *d < 32.0 * 32.0)
    // rust: .filter(|(j, _)| {
    // rust: let y = self.dropped[*j].position.y;
    // rust: y <= high && y + 0.25 >= low
    // rust: })
    // rust: .filter(|(j, _)| {
                        // ItemEntity's eye height is 0.2125.
    // rust: let e = &self.dropped[*j];
    // rust: let at = horizon_core::geometry::Vec3::new(
    // rust: e.position.x,
    // rust: e.position.y + 0.2125,
    // rust: e.position.z,
    // rust: );
    // rust: w.line_of_sight(eye, at)
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(j, _)| j)
}
    // rust: let Some(j) = wanted else {
    // rust: self.mobs[i].extra.point = None;
                // `GiveInventoryToLookTargetPlayer` is the brain's too.
    // rust: if !self.mobs[i].no_ai {
    // rust: self.allay_deliver(i);
}
    // rust: continue;
}
    // rust: let e = &self.dropped[j];
    // rust: if reach.contains(e.position) {
    // rust: let (item, id) = (e.clone(), self.mobs[i].id);
    // rust: let max = self.mobs[i].kind.inventory_stack_limit(&e.stack);
    // rust: let take = self.mobs[i]
    // rust: .extra
    // rust: .allay
    // rust: .as_mut()
    // rust: .unwrap()
    // rust: .add(e.stack.clone(), max);
    // rust: self.add_pickup(
    // rust: super::pickups::Taken::Item(Box::new(item)),
    // rust: super::pickups::Collector::Mob(id),
    // rust: );
    // rust: let e = &mut self.dropped[j];
    // rust: e.stack.count -= take;
    // rust: if e.stack.count == 0 {
    // rust: self.remove_dropped(j);
}
    // rust: let at = [pos.x, pos.y, pos.z];
    // rust: let pitch =
    // rust: (self.world.random.next_float() - self.world.random.next_float()) * 1.4 + 2.0;
    // rust: self.audio
    // rust: .play("minecraft:entity.item.pickup", Some(at), 0.2, pitch);
    // rust: self.mobs[i].extra.point = None;
    // rust: } else {
    // rust: self.mobs[i].extra.point = Some([e.position.x, e.position.y, e.position.z]);
}
}
}
    // The UUID of the player an allay likes (`LIKED_PLAYER`).
allay_liked_uuid :: proc(self: ^Self, i: uint) -> [ {
    // Ported from Horizon
    return {}
}
        // An allay saved before its player was kept belongs to the host.
    // rust: self.mobs[i]
    // rust: .extra
    // rust: .owner
    // rust: .filter(|u| *u != [0, 0, 0, 1])
    // rust: .or(self.level.player_uuid)
    // rust: .unwrap_or([0, 0, 0, 1])
}
    // `AllayAi.getLikedPlayer`: the player the allay was given an item by,
    // found by UUID among the host and the guests of the level (the window
    // is a guest on the server thread), when they are not a spectator and
    // within 64 blocks.
allay_liked_player :: proc(self: ^Self, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let m = &self.mobs[i];
    // rust: if !m.extra.tame {
    // rust: return None;
}
    // rust: let uuid = self.allay_liked_uuid(i);
    // rust: let host = self
    // rust: .player_view()
    // rust: .filter(|p| !p.spectator && self.level.player_uuid.unwrap_or([0, 0, 0, 1]) == uuid)
    // rust: .map(|p| p.position);
    // rust: let found = host.or_else(|| {
    // rust: self.lan_present()
    // rust: .into_iter()
    // rust: .find(|p| p.uuid == uuid && !p.spectator)
    // rust: .map(|p| {
    // rust: horizon_core::geometry::Vec3::new(p.position[0], p.position[1], p.position[2])
    // rust: })
    // rust: });
    // rust: found.filter(|p| p.distance_squared(m.position) < 64.0 * 64.0)
}
    // `GoAndGiveItemsToTarget` / `AllayAi.throwItem`: within 3 blocks of
    // the deposit, one item a tick, each restarting the three-second pause
    // before it picks anything up again.
allay_deliver :: proc(self: ^Self, i: uint) {
}
    // rust: let m = &self.mobs[i];
    // rust: if allay::inventory(m).is_none() {
    // rust: return;
}
        // AllayAi.getItemDepositPosition: the liked note block, else the player.
    // rust: let dimension = self.dim.id();
    // rust: let noteblock = allay::noteblock_deposit(&mut self.mobs[i], dimension, |p| {
    // rust: &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name
    // rust: == "minecraft:note_block"
    // rust: });
    // rust: let player = self.allay_liked_player(i);
    // rust: let m = &self.mobs[i];
    // rust: let target = match noteblock {
    // rust: Some(p) => horizon_core::geometry::Vec3::new(p[0], p[1], p[2]),
    // rust: None => match player.filter(|_| m.extra.tame) {
    // rust: Some(p) => p,
    // rust: None => return,
    // rust: },
}
    // rust: let eye = horizon_core::geometry::Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: if target.distance_squared(eye) >= 9.0 {
    // rust: return;
}
    // rust: let Some(item) = allay::inventory(m).cloned() else {
    // rust: return;
}
    // rust: let from = [
    // rust: m.position.x,
    // rust: m.position.y + m.eye_height() - 0.3,
    // rust: m.position.z,
    // rust: ];
    // rust: let d = [
    // rust: target.x - from[0],
    // rust: target.y + 1.0 - from[1],
    // rust: target.z - from[2],
    // rust: ];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt().max(1e-6);
    // rust: let v = [d[0] / len * 0.2, d[1] / len * 0.3, d[2] / len * 0.2];
        // AllayAi.throwItem: the liked player hears of the block below the deposit.
    // rust: let below = [
    // rust: target.x.floor() as i32,
    // rust: (target.y - 1.0).floor() as i32,
    // rust: target.z.floor() as i32,
    // rust: ];
    // rust: let uuid = self.allay_liked_uuid(i);
        // AllayAi.throwItem: one item of the pocket stack, its components and all.
    // rust: let stack = ItemStack { count: 1, ..item };
    // rust: self.for_each_player(|g| {
    // rust: if g.acting_uuid() == uuid && !g.spectator() {
    // rust: g.trigger_block("minecraft:allay_drop_item_on_block", below, &stack);
}
    // rust: });
    // rust: let m = &mut self.mobs[i];
    // rust: m.extra.allay.as_mut().unwrap().take(1);
    // rust: m.extra.ints[3] = 60;
        // ItemEntity.setDefaultPickUpDelay.
    // rust: self.spawn_item(stack, from, v, 10);
        // BehaviorUtils.throwItem: ItemEntity.setThrower(the allay).
    // rust: let allay = self.mob_uuid(self.mobs[i].id);
    // rust: if let Some(thrown) = self.just_spawned_item() {
    // rust: thrown.thrower = Some(allay);
}
    // rust: if self.world.game_time % 7 == 0 && self.world.random.next_double() < 0.9 {
    // rust: const PITCHES: [f32; 16] = [
    // rust: 0.5625, 0.625, 0.75, 0.9375, 1.0, 1.0, 1.125, 1.25, 1.5, 1.875, 2.0, 2.25, 2.5,
    // rust: 3.0, 3.75, 4.0,
    // rust: ];
    // rust: let pitch = PITCHES[self.world.random.next_int_bound(16).unwrap_or(4) as usize];
    // rust: self.play_mob_bound_sound(
    // rust: i,
    // rust: "minecraft:entity.allay.item_thrown",
    // rust: 6,
    // rust: 1.0,
    // rust: pitch,
    // rust: false,
    // rust: );
}
}
    // `Allay.mobInteract`: duplicate when dancing with an amethyst shard,
    // take the held item, or hand back what it holds.
    // rust: pub(super) fn interact_allay(&mut self, index: usize, item: Option<&ItemStack>) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if m.species() != Species::Allay || !m.alive() {
    // rust: return false;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let shard = item.is_some_and(|s| {
    // rust: self.items()
    // rust: .item_tags
    // rust: .get("minecraft:duplicates_allays")
    // rust: .is_some_and(|tag| tag.contains(&*s.item))
    // rust: });
    // rust: if m.extra.flag && shard && m.extra.egg_time == 0 {
    // rust: let pos = at;
    // rust: self.mobs[index].extra.egg_time = 6000;
    // rust: if let Some(id) = self.spawn_mob("minecraft:allay", pos, true)
    // rust: && let Some(c) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: c.extra.egg_time = 6000;
}
            // Allay.duplicateAllay: entity event 18, three spawnHeartParticle.
    // rust: let id = self.mobs[index].id;
    // rust: self.mob_event_particles(id, 18);
    // rust: self.play_mob_bound_sound(
    // rust: index,
    // rust: "minecraft:block.amethyst_block.chime",
    // rust: 6,
    // rust: 2.0,
    // rust: 1.0,
    // rust: true,
    // rust: );
    // rust: self.consume_held();
    // rust: return true;
}
    // rust: let acting = self.acting_uuid();
    // rust: let holds = m.extra.main_hand.is_some();
    // rust: if !holds && let Some(mut given) = item.cloned() {
    // rust: let m = &mut self.mobs[index];
            // `Allay.mobInteract` hands over one item, its components and all.
    // rust: given.count = 1;
    // rust: m.extra.set_main_hand_stack(Some(given));
    // rust: m.extra.tame = true;
            // `Allay.mobInteract` remembers LIKED_PLAYER by UUID.
    // rust: m.extra.owner = Some(acting);
    // rust: self.play_mob_bound_sound(
    // rust: index,
    // rust: "minecraft:entity.allay.item_given",
    // rust: 6,
    // rust: 2.0,
    // rust: 1.0,
    // rust: true,
    // rust: );
    // rust: self.consume_held();
    // rust: return true;
}
        // Allay.mobInteract takes the item back only through an empty main hand.
    // rust: if holds && item.is_none() && self.hand == Hand::Main {
    // rust: let m = &mut self.mobs[index];
            // The hand's stack keeps the components (a potion) the items came with.
    // rust: let held = m
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .cloned()
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:air", 1));
    // rust: m.extra.set_main_hand(None);
    // rust: let carried = m.extra.allay.as_mut().and_then(|st| st.inventory.take());
    // rust: m.extra.tame = false;
    // rust: m.extra.owner = None;
    // rust: self.play_mob_bound_sound(
    // rust: index,
    // rust: "minecraft:entity.allay.item_taken",
    // rust: 6,
    // rust: 2.0,
    // rust: 1.0,
    // rust: true,
    // rust: );
            // Allay.mobInteract ends with swing(MAIN_HAND, ...).
    // rust: self.mobs[index].swing();
    // rust: if let Some(stack) = carried {
    // rust: self.spawn_item(stack, at, [0.0, 0.2, 0.0], 40);
}
    // rust: if let Some(rest) = self.give(ItemStack { count: 1, ..held })
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
    // rust: self.spawn_item(rest, eye, [0.0; 3], 0);
}
    // rust: return true;
}
    // rust: false
}
}
