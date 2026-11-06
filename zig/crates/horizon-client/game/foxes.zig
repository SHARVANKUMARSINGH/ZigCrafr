//! Transpiled from Horizon Rust crate
//! Module: horizon-client_foxes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Foxes and dolphins on the game side: what they take from the ground (`Fox.pickUpItem`,
//! `Fox.canHoldItem`, `Dolphin.pickUpItem`) and where `FoxSearchForItemsGoal` and
//! `Dolphin.MoveToItemGoal` walk to.
// use super::{
    // rust: Game,
    // rust: pickups::{Collector, Taken},
}
// use horizon_client::mobs::{
    // rust: Species, dolphin,
    // rust: equip::Slot,
    // rust: finalize::{self, set_drop_chance, set_item_stack},
    // rust: fox,
}
// use horizon_core::geometry::Vec3;

    // rust: impl Game<'_> {
    /// `Fox.ALLOWED_ITEMS` and the looting block of `Mob.aiStep` for foxes, once a tick.
    // rust: pub(super) fn tick_foxes(&mut self) {
    // rust: let griefing = self.ui.rules.bool("mob_griefing");
    // rust: let mut near = super::item_areas::ItemAreas::default();
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Fox
    // rust: || !m.alive()
    // rust: || m.removed
    // rust: || !self.creatures.ticked.contains(&m.id)
    // rust: {
    // rust: continue;
}
            // `Mob.aiStep`: the items in the box grown by (1, 0, 1), in order.
    // rust: let reach = m.bounds().inflate(Vec3::new(1.0, 0.0, 1.0));
    // rust: if griefing
    // rust: && m.can_pick_up_loot()
    // rust: && near.may_meet(&self.dropped, self.next_entity, reach)
    // rust: {
    // rust: let mut j = 0;
    // rust: while j < self.dropped.len() {
    // rust: let e = &self.dropped[j];
    // rust: if e.pickup_delay > 0 || e.stack.count == 0 || !reach.intersects(e.bounds()) {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let item_food = self.fox_food(&e.stack.item);
    // rust: let held_food = self.mobs[i]
    // rust: .extra
    // rust: .main_hand
    // rust: .as_deref()
    // rust: .is_some_and(|held| self.fox_food(held));
    // rust: if !fox::can_hold_item(&self.mobs[i], item_food, held_food) {
    // rust: j += 1;
    // rust: continue;
}
                    // The entity is discarded: the next one is at `j` now.
    // rust: self.fox_pick_up(i, j);
}
}
            // `FoxSearchForItemsGoal`: the first allowed item within 8 blocks.
    // rust: let m = &self.mobs[i];
    // rust: let area = m.bounds().inflate(Vec3::new(8.0, 8.0, 8.0));
    // rust: let at = if near.may_meet(&self.dropped, self.next_entity, area) {
    // rust: self.dropped
    // rust: .iter()
    // rust: .find(|e| e.pickup_delay == 0 && e.health > 0 && area.intersects(e.bounds()))
    // rust: .map(|e| [e.position.x, e.position.y, e.position.z])
    // rust: } else {
    // rust: None
}
    // rust: fox::set_item_at(&mut self.mobs[i], at);
}
}
    /// `Dolphin.pickUpItem` in `Mob.aiStep`'s looting block, and the item
    /// `Dolphin.MoveToItemGoal` swims to (`Dolphin.ALLOWED_ITEMS`: no pickup delay, alive, in water).
    // rust: pub(super) fn tick_dolphins(&mut self) {
    // rust: let griefing = self.ui.rules.bool("mob_griefing");
    // rust: let in_water = |g: &Self, e: &horizon_client::entities::ItemEntity| {
    // rust: g.res
    // rust: .facts()
    // rust: .get(g.world.block(
    // rust: e.position.x.floor() as i32,
    // rust: e.position.y.floor() as i32,
    // rust: e.position.z.floor() as i32,
    // rust: ))
    // rust: .fluid
    // rust: == horizon_client::blocks::Fluid::Water
}
    // rust: let mut near = super::item_areas::ItemAreas::default();
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Dolphin
    // rust: || !m.alive()
    // rust: || m.removed
    // rust: || !self.creatures.ticked.contains(&m.id)
    // rust: {
    // rust: continue;
}
            // `Mob.aiStep`: the items in the box grown by (1, 0, 1); `Dolphin.pickUpItem`
            // takes the whole stack when the mouth is empty (`Mob.canHoldItem` is true).
    // rust: let reach = m.bounds().inflate(Vec3::new(1.0, 0.0, 1.0));
    // rust: if griefing
    // rust: && m.can_pick_up_loot()
    // rust: && near.may_meet(&self.dropped, self.next_entity, reach)
    // rust: {
    // rust: let mut j = 0;
    // rust: while j < self.dropped.len() {
    // rust: let e = &self.dropped[j];
    // rust: if e.pickup_delay > 0
    // rust: || e.stack.count == 0
    // rust: || !reach.intersects(e.bounds())
    // rust: || self.mobs[i].extra.main_hand.is_some()
    // rust: {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let before = self.dropped[j].clone();
    // rust: self.mob_item_pickup_trigger(i, &before);
    // rust: let m = &mut self.mobs[i];
    // rust: set_item_stack(m, Slot::MainHand.index(), before.stack.clone());
    // rust: set_drop_chance(m, Slot::MainHand.index(), 2.0);
    // rust: let id = m.id;
    // rust: self.add_pickup(Taken::Item(Box::new(before)), Collector::Mob(id));
    // rust: self.remove_dropped(j);
}
}
    // rust: let area = self.mobs[i].bounds().inflate(Vec3::new(8.0, 8.0, 8.0));
    // rust: let at = if near.may_meet(&self.dropped, self.next_entity, area) {
    // rust: self.dropped
    // rust: .iter()
    // rust: .find(|e| {
    // rust: e.pickup_delay == 0
    // rust: && e.health > 0
    // rust: && area.intersects(e.bounds())
    // rust: && in_water(self, e)
    // rust: })
    // rust: .map(|e| [e.position.x, e.position.y, e.position.z])
    // rust: } else {
    // rust: None
}
    // rust: dolphin::set_item_at(&mut self.mobs[i], at);
}
}
    /// `Fox.isConsumableFood`.
pub fn fox_food(self: *Self, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items()
    // rust: .get(item)
    // rust: .is_some_and(|i| i.food.is_some() && i.consumable.is_some())
}
    /// `Fox.pickUpItem`: the extra items drop where it stands, what it held is spat out
    /// ahead of it, and it holds one of the item.
pub fn fox_pick_up(self: *Self, fox_index: usize, item_index: usize) void {
}
    // rust: let before = self.dropped[item_index].clone();
    // rust: let mut stack = before.stack.clone();
    // rust: let count = stack.count;
    // rust: let at = {
    // rust: let m = &self.mobs[fox_index];
    // rust: [m.position.x, m.position.y, m.position.z]
}
        // `dropItemStack(itemStack.split(count - 1))`: a default ItemEntity at its feet.
    // rust: if count > 1 {
    // rust: let mut rest = stack.clone();
    // rust: rest.count = count - 1;
    // rust: stack.count = 1;
    // rust: self.spawn_item(rest, at, super::dispenser::new_item_motion(), 10);
}
        // `spitOutItem(getItemBySlot(MAINHAND))`.
    // rust: let held = finalize::item_stack(&self.mobs[fox_index], Slot::MainHand.index());
    // rust: if let Some(held) = held {
    // rust: let look = self.mobs[fox_index].view_vector();
    // rust: let from = [at[0] + look[0], at[1] + 1.0, at[2] + look[2]];
    // rust: self.spawn_item(held, from, super::dispenser::new_item_motion(), 40);
    // rust: let id = self.mob_uuid(self.mobs[fox_index].id);
    // rust: if let Some(thrown) = self.just_spawned_item() {
    // rust: thrown.thrower = Some(id);
}
    // rust: self.audio
    // rust: .play("minecraft:entity.fox.spit", Some(at), 1.0, 1.0);
}
        // `onItemPickup`, then `setItemSlot(MAINHAND, split(1))`, `setGuaranteedDrop`.
    // rust: self.mob_item_pickup_trigger(fox_index, &before);
    // rust: let m = &mut self.mobs[fox_index];
    // rust: set_item_stack(m, Slot::MainHand.index(), stack);
    // rust: set_drop_chance(m, Slot::MainHand.index(), 2.0);
    // rust: fox::took_item(m);
    // rust: let id = m.id;
        // `take(entity, count)` and `entity.discard()`.
    // rust: self.add_pickup(Taken::Item(Box::new(before)), Collector::Mob(id));
    // rust: self.remove_dropped(item_index);
}
}
