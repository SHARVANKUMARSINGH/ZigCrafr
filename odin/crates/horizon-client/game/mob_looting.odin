//! Transpiled from Horizon Rust crate
package horizon_client_mob_looting

import "core:fmt"
import "core:mem"
import "core:math"

// `Mob.aiStep`'s looting loop: a mob with `canPickUpLoot` takes what lies
// within its box grown by `getPickupReach` (1, 0, 1) and wears or holds it
// when it beats what it has (`equipItemIfPossible`), dropping the replaced
// stack by its drop chance. The species whose `pickUpItem` does something
// else keep their own loops (`pandas.rs`, `piglins.rs`, `villagers.rs`,
// `allays.rs`, `sulfur_cubes.rs`).
// use super::{
    // rust: Game,
    // rust: pickups::{Collector, Taken},
}
// use horizon_client::{
    // rust: entities::ItemEntity,
    // rust: items::ItemStack,
    // rust: mobs::{
    // rust: Mob, Species,
    // rust: equip::{self, Facts, ItemTags, Slot},
    // rust: finalize::{self, set_drop_chance, set_item_stack, stored_drop_chance},
    // rust: },
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

    // rust: impl Game<'_> {
    // `Mob.aiStep`'s looting block, once per mob per tick.
    // rust: pub(super) fn tick_mob_looting(&mut self) {
    // rust: if self.dropped.is_empty() || !self.ui.rules.bool("mob_griefing") {
    // rust: return;
}
    // rust: let mut near = super::item_areas::ItemAreas::default();
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if !m.can_pick_up_loot()
    // rust: || !m.alive()
    // rust: || m.removed
    // rust: || !self.creatures.ticked.contains(&m.id)
    // rust: {
    // rust: continue;
}
            // `Mob.ITEM_PICKUP_REACH`.
    // rust: let reach = m.bounds().inflate(Vec3::new(1.0, 0.0, 1.0));
    // rust: let mut scan = near.scan(&self.dropped, self.next_entity, reach);
    // rust: if scan.is_empty() {
    // rust: continue;
}
    // rust: let (species, baby, passenger) = (m.species(), m.is_baby(), m.extra.passenger);
    // rust: let mut j = 0;
    // rust: loop {
    // rust: j = scan.next_from(j, self.dropped.len());
    // rust: let Some(e) = self.dropped.get(j) else {
    // rust: break;
}
    // rust: if e.pickup_delay > 0 || !reach.intersects(e.bounds()) {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let stack = e.stack.clone();
    // rust: let item = &stack.item;
    // rust: let tags = ItemTags {
    // rust: spear: self.items().item_in_tag("minecraft:spears", item),
    // rust: egg: self.items().item_in_tag("minecraft:eggs", item),
    // rust: disliked_weapon: self
    // rust: .items()
    // rust: .item_in_tag("minecraft:wither_skeleton_disliked_weapons", item),
}
    // rust: if !equip::wants_to_pick_up(species, baby, passenger, item, tags) {
    // rust: j += 1;
    // rust: continue;
}
                // `Mob.pickUpItem`: nothing leaves the ground what it cannot use.
    // rust: let Some(taken) = self.equip_item_if_possible(i, &stack) else {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let before = self.dropped[j].clone();
    // rust: let id = self.mobs[i].id;
    // rust: self.add_pickup(Taken::Item(Box::new(before.clone())), Collector::Mob(id));
    // rust: self.mob_item_pickup_trigger(i, &before);
    // rust: let e = &mut self.dropped[j];
    // rust: e.stack.count -= taken;
    // rust: if e.stack.count == 0 {
    // rust: self.remove_dropped(j);
    // rust: scan.removed(j);
    // rust: } else {
    // rust: j += 1;
}
}
}
}

    // `Mob.equipItemIfPossible`: what `slot` would take of `stack`, and how
    // many items that takes. `None` when the mob has no use for it.
equip_item_if_possible :: proc(self: ^Self, index: uint, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let item = &*stack.item;
    // rust: let equip_slot = self.items().get(item).and_then(|i| i.equip_slot.clone());
    // rust: let mut slot = equip::slot_for(equip_slot.as_deref())?;
    // rust: let mut replace = self.can_replace(index, stack, slot);
        // An armour piece that beats nothing it is worn with falls back to an
        // empty main hand.
    // rust: if slot.is_armor() && !replace {
    // rust: slot = Slot::MainHand;
    // rust: replace = self.mobs[index].extra.main_hand.is_none();
}
    // rust: if !replace {
    // rust: return None;
}
        // `EquipmentSlot.limit`: an armour slot takes one item, a hand the
        // whole stack.
    // rust: let taken = if slot.is_armor() {
    // rust: 1
    // rust: } else {
    // rust: stack.count.max(1)
}
    // rust: let m = &mut self.mobs[index];
    // rust: let old = finalize::item_stack(m, slot.index());
    // rust: let chance = stored_drop_chance(m, slot.index());
        // `DropChances.byEquipment` against the roll the equip makes.
    // rust: let drop_old = old.is_some() && (m.random.next_float() - 0.1).max(0.0) < chance;
        // The whole stack comes with it: its enchantments (a Sharpness V sword
        // stays sharp), damage, name and components.
    // rust: let mut equipped = stack.clone();
    // rust: equipped.count = taken;
    // rust: set_item_stack(m, slot.index(), equipped);
        // `setItemSlotAndDropWhenKilled`, then `persistenceRequired`.
    // rust: set_drop_chance(m, slot.index(), 2.0);
    // rust: m.persistent = true;
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: if drop_old && let Some(old) = old {
    // rust: self.spawn_item(old, at, super::dispenser::new_item_motion(), 10);
}
    // rust: Some(taken)
}

    // `Mob.canReplaceCurrentItem` for what `m` wears or holds in `slot`.
can_replace :: proc(self: ^Self, index: uint, stack: ^ItemStack, slot: Slot) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let m = &self.mobs[index];
    // rust: let Some(worn_stack) = finalize::item_stack(m, slot.index()) else {
    // rust: return true;
}
    // rust: let current = worn_stack.item.clone();
    // rust: let species = m.species();
        // `Drowned.canReplaceCurrentItem` never parts with a nautilus shell.
    // rust: if species == Species::Drowned && &*current == "minecraft:nautilus_shell" {
    // rust: return false;
}
    // rust: let new = self.stack_facts(m, stack, slot);
    // rust: let worn = self.stack_facts(m, &worn_stack, slot);
    // rust: let preferred = equip::preferred_weapon_tag(species).map(|tag| {
    // rust: (
    // rust: self.items().item_in_tag(tag, &stack.item),
    // rust: self.items().item_in_tag(tag, &current),
    // rust: )
    // rust: });
    // rust: equip::can_replace_current_item(&new, Some(&worn), slot, preferred)
}

    // The numbers `Mob.compareArmor` and `compareWeapons` read off `stack`
    // in `slot` for the mob `m`.
    // rust: pub(super) fn stack_facts(&self, m: &Mob, stack: &ItemStack, slot: Slot) -> Facts {
    // rust: let (armor, toughness, attack) = self.attributes(m, &stack.item, slot);
    // rust: Facts {
    // rust: armor,
    // rust: armor_toughness: toughness,
    // rust: attack_damage: attack,
    // rust: enchantments: stack.enchantments().len(),
    // rust: damage: stack.damage as i32,
    // rust: custom_name: stack.custom_name().is_some(),
            // `EnchantmentEffectComponents.PREVENT_ARMOR_CHANGE` is the Curse of
            // Binding's, the only enchantment that carries one.
    // rust: prevents_armor_change: stack.enchantment_level("minecraft:binding_curse") > 0,
}
}

    // `Mob.getApproximateAttributeWith` for the item `id` in `slot`: each
    // attribute starts from the mob's own value. (armour, toughness, damage)
attributes :: proc(self: ^Self, m: ^Mob, id: string, slot: Slot) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let empty: &[(String, String, f64, String, String)] = &[];
    // rust: let modifiers = self
    // rust: .items()
    // rust: .get(id)
    // rust: .map_or(empty, |i| i.modifiers.as_slice());
    // rust: (
    // rust: equip::attribute_with(modifiers, "minecraft:armor", f64::from(m.kind.armor), slot),
    // rust: equip::attribute_with(
    // rust: modifiers,
    // rust: "minecraft:armor_toughness",
    // rust: f64::from(m.kind.armor_toughness),
    // rust: slot,
    // rust: ),
    // rust: equip::attribute_with(
    // rust: modifiers,
    // rust: "minecraft:attack_damage",
    // rust: f64::from(m.attrs.attack_damage),
    // rust: slot,
    // rust: ),
    // rust: )
}

    // `LivingEntity.onItemPickup`: the advancement of whoever threw the item,
    // whichever mob took it.
    // rust: pub(super) fn mob_item_pickup_trigger(&mut self, index: usize, e: &ItemEntity) {
    // rust: let Some(owner) = e.thrower else {
    // rust: return;
}
    // rust: let stack = e.stack.clone();
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.for_each_player(|g| {
    // rust: if g.acting_uuid() == owner {
    // rust: g.trigger_item_entity("minecraft:thrown_item_picked_up_by_entity", &stack, &target);
}
    // rust: });
}
}
