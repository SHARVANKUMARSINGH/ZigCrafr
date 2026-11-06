//! Transpiled from Horizon Rust crate
package horizon_client_piglins

import "core:fmt"
import "core:mem"
import "core:math"

// The game side of piglins (`PiglinAi`): spotting and picking up gold,
// bartering when the admiring is over, and anger at players who open
// their chests or mine their gold.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{
    // rust: Mob, Species,
    // rust: equip::{self, Slot},
    // rust: finalize::{
    // rust: SLOT_NAMES, item_stack, set_drop_chance, set_item, set_item_stack,
    // rust: set_slot_enchantments, slot_enchantments, stored_drop_chance,
    // rust: },
    // rust: piglin::{ADMIRE, ATE_RECENTLY},
    // rust: },
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

    // rust: impl Game<'_> {
item_in_tag :: proc(self: ^Self, tag: string, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.res
    // rust: .items()
    // rust: .item_tags
    // rust: .get(tag)
    // rust: .is_some_and(|t| t.contains(item))
}
piglin_loved :: proc(self: ^Self, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.item_in_tag("minecraft:piglin_loved", item)
}
    // `PiglinAi.isLovedItem` or a preferred weapon (`Piglin.canReplaceCurrentItem`).
piglin_wanted :: proc(self: ^Self, m: ^Mob, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.piglin_loved(item)
    // rust: || !m.is_baby() && self.item_in_tag("minecraft:piglin_preferred_weapons", item)
}
    // The `SLOT_NAMES` index `getEquipmentSlotForItem` picks: armour goes
    // to its slot, anything else to the main hand.
piglin_slot :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let slot = self
    // rust: .res
    // rust: .items()
    // rust: .get(item)
    // rust: .and_then(|i| i.equip_slot.as_deref())
    // rust: .filter(|s| matches!(*s, "head" | "chest" | "legs" | "feet"))
    // rust: .unwrap_or("mainhand");
    // rust: SLOT_NAMES.iter().position(|n| *n == slot).unwrap_or(0)
}
    // `Piglin.canReplaceCurrentItem`: an empty slot takes anything, a
    // `PREVENT_ARMOR_CHANGE` piece stays, a wanted item replaces an unwanted
    // one and never the other way round; when both or neither are wanted,
    // `Mob.canReplaceCurrentItem` compares armour or weapons.
piglin_can_replace :: proc(self: ^Self, m: ^Mob, stack: ^ItemStack, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(current) = item_stack(m, slot) else {
    // rust: return true;
}
    // rust: let new_wanted = self.piglin_wanted(m, &stack.item);
    // rust: let current_wanted = self.piglin_wanted(m, &current.item);
    // rust: let slot = [
    // rust: Slot::MainHand,
    // rust: Slot::OffHand,
    // rust: Slot::Feet,
    // rust: Slot::Legs,
    // rust: Slot::Chest,
    // rust: Slot::Head,
    // rust: ]
    // rust: .get(slot)
    // rust: .copied()
    // rust: .unwrap_or(Slot::MainHand);
    // rust: let new = self.stack_facts(m, stack, slot);
    // rust: let worn = self.stack_facts(m, &current, slot);
        // `getPreferredWeaponType` is the preferred-weapons tag for adults.
    // rust: let preferred = (!m.is_baby()).then(|| {
    // rust: (
    // rust: self.item_in_tag("minecraft:piglin_preferred_weapons", &stack.item),
    // rust: self.item_in_tag("minecraft:piglin_preferred_weapons", &current.item),
    // rust: )
    // rust: });
    // rust: piglin_replace(new_wanted, current_wanted, &new, &worn, slot, preferred)
}
    // `SimpleContainer.canAddItem` on the piglin's eight slots.
piglin_can_add :: proc(self: ^Self, m: ^Mob, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.inventory.len() < 8
    // rust: || m.extra.inventory.iter().any(|s| {
    // rust: s.same_item_same_components(stack) && s.count < self.piglin_max_stack(&s.item)
    // rust: })
}
piglin_max_stack :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.items().get(item).map_or(64, |i| i.max_stack)
}
    // `PiglinAi.wantsToPickup`: babies ignore their own item tag, but can
    // pick up currency and other loved items just like adults.
piglin_wants :: proc(self: ^Self, m: ^Mob, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let item = &*stack.item;
    // rust: if m.is_baby() && self.item_in_tag("minecraft:ignored_by_piglin_babies", item)
    // rust: || self.item_in_tag("minecraft:piglin_repellents", item)
    // rust: {
    // rust: return false;
}
    // rust: let holds_loved = m
    // rust: .extra
    // rust: .off_hand
    // rust: .as_deref()
    // rust: .is_some_and(|o| self.piglin_loved(o));
    // rust: if item == "minecraft:gold_ingot" {
    // rust: return !holds_loved;
}
    // rust: let space = self.piglin_can_add(m, stack);
    // rust: if item == "minecraft:gold_nugget" {
    // rust: space
    // rust: } else if self.item_in_tag("minecraft:piglin_food", item) {
    // rust: m.extra.ints[0] <= 0 && space
    // rust: } else if !self.piglin_loved(item) {
    // rust: self.piglin_can_replace(m, stack, self.piglin_slot(item))
    // rust: } else {
    // rust: !holds_loved && space
}
}
    // `Mob.equipItemIfPossible` for a piglin: put it in its slot when that
    // slot takes it (an armour piece that cannot replace what is worn goes
    // to an empty main hand), dropping what it replaces by drop chance.
piglin_equip :: proc(self: ^Self, index: uint, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let item = &*stack.item;
    // rust: let mut slot = self.piglin_slot(item);
    // rust: let m = &self.mobs[index];
    // rust: let mut replace = self.piglin_can_replace(m, stack, slot);
    // rust: if slot > 1 && !replace {
    // rust: slot = 0;
    // rust: replace = m.extra.main_hand.is_none();
}
    // rust: if !replace {
    // rust: return false;
}
    // rust: let m = &mut self.mobs[index];
    // rust: let old = horizon_client::mobs::finalize::item(m, slot);
    // rust: let chance = stored_drop_chance(m, slot);
    // rust: let drop_old = old.is_some() && (m.random.next_float() - 0.1).max(0.0) < chance;
    // rust: let old_enchantments = slot_enchantments(m, slot);
    // rust: set_item(m, slot, item);
        // The piglin keeps what the stack carried (Protection IV stays on).
    // rust: set_slot_enchantments(m, slot, stack.enchantments().to_vec());
        // setItemSlotAndDropWhenKilled, then persistenceRequired.
    // rust: set_drop_chance(m, slot, 2.0);
    // rust: m.persistent = true;
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: if let (true, Some(old)) = (drop_old, old) {
    // rust: let mut dropped = ItemStack::new(&old, 1);
    // rust: dropped.set_crafting_enchantments(old_enchantments);
    // rust: self.spawn_item(dropped, at, super::dispenser::new_item_motion(), 10);
}
    // rust: true
}
    // `PiglinAi.putInInventory`: what does not fit is thrown at a random
    // spot nearby.
piglin_stash :: proc(self: ^Self, index: uint, mut stack: ItemStack) {
}
    // rust: let max = self.piglin_max_stack(&stack.item);
    // rust: let m = &mut self.mobs[index];
    // rust: for s in &mut m.extra.inventory {
    // rust: if stack.count > 0 && s.same_item_same_components(&stack) && s.count < max {
    // rust: let n = (max - s.count).min(stack.count);
    // rust: s.count += n;
    // rust: stack.count -= n;
}
}
    // rust: while stack.count > 0 && m.extra.inventory.len() < 8 {
    // rust: let n = stack.count.min(max);
    // rust: m.extra.inventory.push(ItemStack {
    // rust: count: n,
    // rust: ..stack.clone()
    // rust: });
    // rust: stack.count -= n;
}
    // rust: if stack.count == 0 {
    // rust: return;
}
    // rust: let from = [m.position.x, m.position.y + 1.3, m.position.z];
    // rust: let r = &mut self.world.random;
    // rust: let to = [
    // rust: from[0] + f64::from(r.next_float() * 8.0 - 4.0),
    // rust: from[1],
    // rust: from[2] + f64::from(r.next_float() * 8.0 - 4.0),
    // rust: ];
    // rust: self.piglin_throw(from, to, stack);
}
    // `PiglinAi.stopHoldingOffHandItem` for something that is not
    // bartering currency: wear it if it can, else keep it in the inventory.
piglin_keep :: proc(self: ^Self, index: uint, stack: ItemStack) {
}
        // Nuggets keep their whole stack in the inventory (a hand slot here
        // holds one item id only).
    // rust: if &*stack.item == "minecraft:gold_nugget" || !self.piglin_equip(index, &stack) {
    // rust: self.piglin_stash(index, stack);
}
}
    // `BehaviorUtils.throwItem`: toss a stack from a point toward another.
piglin_throw :: proc(self: ^Self, from: [f64; 3], to: [f64; 3], stack: ItemStack) {
}
    // rust: let d = [to[0] - from[0], to[1] - from[1], to[2] - from[2]];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt().max(1e-6);
    // rust: let v = [d[0] / len * 0.3, d[1] / len * 0.3 + 0.1, d[2] / len * 0.3];
    // rust: self.spawn_item(stack, from, v, 40);
}
    // `PiglinAi.isWearingSafeArmor`.
    // rust: pub(super) fn wearing_gold(&self) -> bool {
    // rust: let tag = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:piglin_safe_armor");
    // rust: self.armor
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|s| tag.is_some_and(|t| t.contains(&*s.item)))
}
    // Piglins notice wanted items on the ground within 9 blocks (`PiglinAi.wantsToPickup`:
    // gold and other loved items, nuggets, food, gear), walk to them and
    // take them (`GoToWantedItem`, `Piglin.pickUpItem`).
    // rust: pub(super) fn piglin_pickups(&mut self) {
    // rust: if !self.ui.rules.bool("mob_griefing") {
    // rust: return;
}
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Piglin
    // rust: || !m.alive()
    // rust: || m.extra.using_item > 0
    // rust: || !self.creatures.ticked.contains(&m.id)
    // rust: {
    // rust: continue;
}
    // rust: let pos = m.position;
            // NearestItemSensor: the nearest wanted item within 32 that the piglin
            // sees (eye to eye); GoToWantedItem then walks to it within 9 blocks.
    // rust: let w = self.mob_world_base(&[]);
    // rust: let eye = Vec3::new(pos.x, m.eye_y(), pos.z);
    // rust: let nearest = self
    // rust: .dropped
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(j, e)| (j, e.position.distance_squared(pos)))
    // rust: .filter(|(_, d)| *d < 32.0 * 32.0)
    // rust: .filter(|&(j, _)| self.piglin_wants(m, &self.dropped[j].stack))
    // rust: .filter(|&(j, _)| {
                    // ItemEntity's eye height is 0.2125.
    // rust: let e = &self.dropped[j];
    // rust: let at = Vec3::new(e.position.x, e.position.y + 0.2125, e.position.z);
    // rust: w.line_of_sight(eye, at)
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1));
    // rust: let loved =
    // rust: nearest.is_some_and(|(j, _)| self.piglin_loved(&self.dropped[j].stack.item));
    // rust: self.admire_seen_item(i, nearest.map(|(_, d)| d), loved);
    // rust: let best = nearest.filter(|(_, d)| *d <= 81.0);
    // rust: let Some((j, _)) = best else {
    // rust: self.mobs[i].extra.point = None;
    // rust: continue;
}
    // rust: let e = &self.dropped[j];
    // rust: let close = (e.position.x - pos.x).abs() <= 1.3
    // rust: && (e.position.z - pos.z).abs() <= 1.3
    // rust: && (e.position.y - pos.y).abs() <= 1.0;
    // rust: if !close || e.pickup_delay > 0 {
    // rust: self.mobs[i].extra.point = Some([e.position.x, e.position.y, e.position.z]);
    // rust: continue;
}
            // Nuggets come whole, anything else one at a time.
    // rust: let (taken_item, id) = (e.clone(), self.mobs[i].id);
    // rust: let item = e.stack.item.clone();
    // rust: self.add_pickup(
    // rust: super::pickups::Taken::Item(Box::new(taken_item.clone())),
    // rust: super::pickups::Collector::Mob(id),
    // rust: );
            // LivingEntity.onItemPickup, before PiglinAi.pickUpItem splits the stack.
    // rust: self.mob_item_pickup_trigger(i, &taken_item);
    // rust: let stack = if &*item == "minecraft:gold_nugget" {
    // rust: self.remove_dropped(j).stack
    // rust: } else {
    // rust: let e = &mut self.dropped[j];
    // rust: e.stack.count -= 1;
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..e.stack.clone()
}
    // rust: if e.stack.count == 0 {
    // rust: self.remove_dropped(j);
}
    // rust: one
}
    // rust: if self.piglin_loved(&item) {
    // rust: self.start_admiring(i, item);
    // rust: } else if self.item_in_tag("minecraft:piglin_food", &item)
    // rust: && self.mobs[i].extra.ints[0] <= 0
    // rust: {
                // PiglinAi.eat: the food is gone and it will not eat for a while.
    // rust: self.mobs[i].extra.ints[0] = ATE_RECENTLY;
    // rust: self.mobs[i].nav_stop();
    // rust: } else {
    // rust: self.mobs[i].nav_stop();
    // rust: self.piglin_keep(i, stack);
}
}
}
    // `StartAdmiringItemIfSeen` and the admire activity's stop behaviours, from the
    // distance squared to `NEAREST_VISIBLE_WANTED_ITEM` and whether that item is loved.
admire_seen_item :: proc(self: ^Self, index: uint, nearest: Maybe(f64), loved: bool) {
}
    // rust: let m = &mut self.mobs[index];
    // rust: let holding = m.extra.off_hand.is_some();
    // rust: m.extra.piglin.admire_seen(holding, nearest, loved);
}
start_admiring :: proc(self: ^Self, index: uint, item: std::sync::^str) {
}
    // rust: let m = &mut self.mobs[index];
        // The memory is set again, for the item it holds now.
    // rust: m.extra.piglin.seen_admire = 0;
    // rust: m.extra.off_hand = Some(item);
    // rust: m.extra.using_item = ADMIRE;
    // rust: m.extra.point = None;
    // rust: m.nav_stop();
        // The admiring grunt is `PiglinAi.updateActivity`'s: `piglin::brain_step`
        // plays it when the activity changes.
}
    // `PiglinAi.mobInteract`: hand a piglin a gold ingot (only piglin
    // currency is accepted from the hand; other loved items are passed over).
    // rust: pub(super) fn give_piglin(&mut self, index: usize, item: &str) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if m.species() != Species::Piglin
    // rust: || m.is_baby()
    // rust: || m.extra.using_item > 0
    // rust: || m.extra.piglin.seen_admire > 0
    // rust: || m.extra.piglin.admire_disabled > 0
    // rust: || item != "minecraft:gold_ingot"
    // rust: {
    // rust: return false;
}
    // rust: self.start_admiring(index, item.into());
    // rust: true
}
    // `PiglinAi.stopHoldingOffHandItem` after admiring: gold ingots buy a
    // roll of the bartering table for adults. Babies equip the admired item,
    // or hold it in the main hand after stashing or throwing the old item.
    // rust: pub(super) fn finish_admiring(&mut self, mob: u32) {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == mob) else {
    // rust: return;
}
    // rust: let Some(item) = self.mobs[i].extra.off_hand.take() else {
    // rust: return;
}
    // rust: if self.mobs[i].is_baby() {
    // rust: let stack = ItemStack::new(&item, 1);
    // rust: if !self.piglin_equip(i, &stack) {
    // rust: if let Some(old) = item_stack(&self.mobs[i], 0) {
    // rust: if self.piglin_loved(&old.item) {
    // rust: self.piglin_stash(i, old);
    // rust: } else {
    // rust: self.piglin_throw_items(i, vec![old]);
}
}
    // rust: let m = &mut self.mobs[i];
    // rust: set_item_stack(m, 0, stack);
    // rust: set_drop_chance(m, 0, 2.0);
    // rust: m.persistent = true;
}
    // rust: return;
}
    // rust: if &*item != "minecraft:gold_ingot" {
    // rust: self.piglin_keep(i, ItemStack::new(&item, 1));
    // rust: return;
}
    // rust: let items = world_items!(self).loot_table(
    // rust: "minecraft:gameplay/piglin_bartering",
    // rust: false,
    // rust: None,
    // rust: &mut self.world.random,
    // rust: );
    // rust: self.piglin_throw_items(i, items);
}
    // `PiglinAi.throwItems`: barters and a baby's unwanted main-hand item
    // use the same player-directed throw.
piglin_throw_items :: proc(self: ^Self, i: uint, items: [dynamic]ItemStack) {
}
    // rust: let m = &self.mobs[i];
    // rust: let from = [m.position.x, m.position.y + 1.3, m.position.z];
        // BehaviorUtils.throwItem toward the nearest visible player
        // (NEAREST_VISIBLE_PLAYER: within 16, alive, no spectators; the
        // guests count as much as the host), else nearby.
    // rust: let at = m.position;
    // rust: let host = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| !p.health.dead_or_dying() && !self.spectator())
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: let guests = self.lan.iter().flat_map(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| h.hub.here(g) && g.loaded && !g.dead && !g.spectator())
    // rust: .map(|g| g.position)
    // rust: });
    // rust: let d = |p: &[f64; 3]| at.distance_squared(Vec3::new(p[0], p[1], p[2]));
    // rust: let target = host
    // rust: .into_iter()
    // rust: .chain(guests)
    // rust: .filter(|p| d(p) < 256.0)
    // rust: .min_by(|a, b| d(a).total_cmp(&d(b)))
    // rust: .map(|p| [p[0], p[1] + 1.0, p[2]]);
    // rust: for stack in items {
    // rust: let to = target.unwrap_or_else(|| {
    // rust: let r = &mut self.world.random;
    // rust: [
    // rust: from[0] + f64::from(r.next_float() * 8.0 - 4.0),
    // rust: from[1],
    // rust: from[2] + f64::from(r.next_float() * 8.0 - 4.0),
    // rust: ]
    // rust: });
    // rust: self.piglin_throw(from, to, stack);
}
}
    // `PiglinAi.angerNearbyPiglins`.
    // rust: pub(super) fn anger_piglins(&mut self, only_if_seen: bool) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if self.creative || self.spectator() {
    // rust: return;
}
    // rust: let at = p.position;
    // rust: let eye = [at.x, at.y + 1.62, at.z];
    // rust: let player_uuid = self
    // rust: .lan_acting_uuid
    // rust: .map(horizon_client::lan::playerdata::uuid_ints)
    // rust: .or(self.level.player_uuid);
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Piglin
    // rust: || m.is_baby()
    // rust: || !m.alive()
    // rust: || m.ai.target.is_some()
    // rust: || (m.position.x - at.x).abs() > 16.0
    // rust: || (m.position.y - at.y).abs() > 16.0
    // rust: || (m.position.z - at.z).abs() > 16.0
    // rust: {
    // rust: continue;
}
    // rust: if only_if_seen && !self.can_see(m.center(), eye) {
    // rust: continue;
}
    // rust: let m = &mut self.mobs[i];
    // rust: horizon_client::mobs::piglin::set_guarded_anger_target(m, player_uuid);
}
}
    // A clear line of sight between two points (blocks with collision stop it).
can_see :: proc(self: ^Self, from: [f64; 3], to: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let steps = 32;
    // rust: (1..steps).all(|i| {
    // rust: let f = f64::from(i) / f64::from(steps);
    // rust: let p = [
    // rust: from[0] + (to[0] - from[0]) * f,
    // rust: from[1] + (to[1] - from[1]) * f,
    // rust: from[2] + (to[2] - from[2]) * f,
    // rust: ];
    // rust: !self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ))
    // rust: .full_collision
    // rust: })
}
    // Whether breaking or opening this block angers piglins.
    // rust: pub(super) fn guarded_by_piglins(&self, name: &str) -> bool {
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:guarded_by_piglins")
    // rust: .is_some_and(|t| t.contains(name))
}
}

// The decision of `Piglin.canReplaceCurrentItem` once both stacks are known.
    // rust: fn piglin_replace(
    // rust: new_wanted: bool,
    // rust: current_wanted: bool,
    // rust: new: &equip::Facts,
    // rust: worn: &equip::Facts,
    // rust: slot: Slot,
    // rust: preferred: Option<(bool, bool)>,
    // rust: ) -> bool {
    // rust: if worn.prevents_armor_change {
    // rust: return false;
}
    // rust: if new_wanted != current_wanted {
    // rust: return new_wanted;
}
    // rust: equip::can_replace_current_item(new, Some(worn), slot, preferred)
}

    // rust: mod tests {
//     use super::*;

armor :: proc(points: f64, binding: bool) -> e {
    // Ported from Horizon
    return {}
}
    // rust: equip::Facts {
    // rust: armor: points,
    // rust: armor_toughness: 0.0,
    // rust: attack_damage: 0.0,
    // rust: enchantments: 0,
    // rust: damage: 0,
    // rust: custom_name: false,
    // rust: prevents_armor_change: binding,
}
}

better_helmet_replaces_worse_one :: proc() {
}
        // Diamond (3) over iron (2), neither loved.
    // rust: let (diamond, iron) = (armor(3.0, false), armor(2.0, false));
    // rust: assert!(piglin_replace(
    // rust: false,
    // rust: false,
    // rust: &diamond,
    // rust: &iron,
    // rust: Slot::Head,
    // rust: None
    // rust: ));
    // rust: assert!(!piglin_replace(
    // rust: false,
    // rust: false,
    // rust: &iron,
    // rust: &diamond,
    // rust: Slot::Head,
    // rust: None
    // rust: ));
}

binding_curse_keeps_the_worn_piece :: proc() {
}
    // rust: let (diamond, cursed) = (armor(3.0, false), armor(1.0, true));
    // rust: assert!(!piglin_replace(
    // rust: false,
    // rust: false,
    // rust: &diamond,
    // rust: &cursed,
    // rust: Slot::Head,
    // rust: None
    // rust: ));
    // rust: assert!(!piglin_replace(
    // rust: true,
    // rust: false,
    // rust: &diamond,
    // rust: &cursed,
    // rust: Slot::Head,
    // rust: None
    // rust: ));
}

wanted_beats_comparison :: proc() {
}
    // rust: let (gold, diamond) = (armor(2.0, false), armor(3.0, false));
    // rust: assert!(piglin_replace(
    // rust: true,
    // rust: false,
    // rust: &gold,
    // rust: &diamond,
    // rust: Slot::Head,
    // rust: None
    // rust: ));
    // rust: assert!(!piglin_replace(
    // rust: false,
    // rust: true,
    // rust: &diamond,
    // rust: &gold,
    // rust: Slot::Head,
    // rust: None
    // rust: ));
}

preferred_weapon_comparison_by_damage :: proc() {
}
    // rust: let mut strong = armor(0.0, false);
    // rust: strong.attack_damage = 7.0;
    // rust: let mut weak = armor(0.0, false);
    // rust: weak.attack_damage = 4.0;
    // rust: assert!(piglin_replace(
    // rust: false,
    // rust: false,
    // rust: &strong,
    // rust: &weak,
    // rust: Slot::MainHand,
    // rust: None
    // rust: ));
    // rust: assert!(!piglin_replace(
    // rust: false,
    // rust: false,
    // rust: &weak,
    // rust: &strong,
    // rust: Slot::MainHand,
    // rust: None
    // rust: ));
}
}
