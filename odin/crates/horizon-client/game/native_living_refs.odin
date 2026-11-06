//! Transpiled from Horizon Rust crate
package horizon_client_native_living_refs

import "core:fmt"
import "core:mem"
import "core:math"

// Living entities for native server mods, through a `LivingRef`
// (docs/native-mods.md, "Entity and level handles", #7387): the equipment
// of mobs, players and armor stands. Reads return `None`, writes false, for
// a stale handle. On a client (API @API:client_entity_refs@) reads give the
// equipment the server synced (`ClientboundSetEquipmentPacket`, and this
// window's own inventory), and writes are refused.
// use super::Game;
// use super::commands::{Target, items::Owner};
// use horizon_client::first_person::Hand;
// use horizon_client::items::ItemStack;
// use horizon_client::mod_api::{EntityRef, EquipmentSlot, LivingRef};

// A player's armour slots (`armor`, head first) by equipment slot.
armor_index :: proc(slot: EquipmentSlot) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: EquipmentSlot::Head => Some(0),
    // rust: EquipmentSlot::Chest => Some(1),
    // rust: EquipmentSlot::Legs => Some(2),
    // rust: EquipmentSlot::Feet => Some(3),
    // rust: _ => None,
}
}

// A player's stack in `slot`, from its inventory, armour and off hand.
    // rust: fn player_slot(
    // rust: inventory: &[Option<ItemStack>],
    // rust: selected: usize,
    // rust: armor: &[Option<ItemStack>; 4],
    // rust: offhand: &Option<ItemStack>,
    // rust: slot: EquipmentSlot,
    // rust: ) -> Option<ItemStack> {
    // rust: match slot {
    // rust: EquipmentSlot::MainHand => inventory.get(selected).cloned().flatten(),
    // rust: EquipmentSlot::OffHand => offhand.clone(),
    // rust: _ => armor[armor_index(slot)?].clone(),
}
}

// The `/item` slot name of an equipment slot.
slot_name :: proc(slot: EquipmentSlot) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: EquipmentSlot::MainHand => "weapon.mainhand",
    // rust: EquipmentSlot::OffHand => "weapon.offhand",
    // rust: EquipmentSlot::Head => "armor.head",
    // rust: EquipmentSlot::Chest => "armor.chest",
    // rust: EquipmentSlot::Legs => "armor.legs",
    // rust: EquipmentSlot::Feet => "armor.feet",
    // rust: EquipmentSlot::Body => "armor.body",
    // rust: EquipmentSlot::Saddle => "saddle",
}
}

    // rust: impl Game<'_> {
    // What a living handle names now: a player, a mob, an armor stand or the dragon.
native_living_target :: proc(self: ^Self, living: LivingRef) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.native_entity_target(living.entity())? {
    // rust: t @ (Target::Player
    // rust: | Target::Guest(_)
    // rust: | Target::Mob(_)
    // rust: | Target::Stand(_)
    // rust: | Target::Dragon(_)) => Some(t),
    // rust: _ => None,
}
}
    // The entity as a living entity (vanilla's `LivingEntity`: a mob, a
    // player, an armor stand or the dragon), or None for another kind or a
    // stale handle. API 382.
    // rust: pub(super) fn native_living(&self, entity: EntityRef) -> Option<LivingRef> {
    // rust: let living = LivingRef::new(entity);
    // rust: self.native_living_target(living).map(|_| living)
}
    // The stack in equipment slot `slot` (`LivingEntity.getItemBySlot`):
    // None when it is empty, the entity has no such slot (a player has no
    // body or saddle slot), or the handle is stale. API 382.
    // rust: pub(super) fn native_living_equipment(
    // rust: &self,
    // rust: living: LivingRef,
    // rust: slot: EquipmentSlot,
    // rust: ) -> Option<ItemStack> {
    // rust: match self.native_living_target(living)? {
    // rust: Target::Player => player_slot(
    // rust: &self.inventory,
    // rust: self.selected,
    // rust: &self.armor,
    // rust: &self.offhand,
    // rust: slot,
    // rust: ),
    // rust: Target::Guest(conn) => {
    // rust: let g = self.command_guest(conn)?;
    // rust: player_slot(&g.inventory, g.selected, &g.armor, &g.offhand, slot)
}
    // rust: Target::Mob(id) => {
    // rust: self.mobs.iter().find(|m| m.id == id)?.equipment_stacks()[slot as usize].clone()
}
    // rust: Target::Stand(id) => self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .find(|a| a.id == id)?
    // rust: .equipment
    // rust: .get(slot as usize)?
    // rust: .clone(),
    // rust: _ => None,
}
}
    // The stack in hand `hand` (`LivingEntity.getItemInHand`). API
    // 382.
    // rust: pub(super) fn native_living_hand_item(
    // rust: &self,
    // rust: living: LivingRef,
    // rust: hand: Hand,
    // rust: ) -> Option<ItemStack> {
    // rust: let slot = match hand {
    // rust: Hand::Main => EquipmentSlot::MainHand,
    // rust: Hand::Off => EquipmentSlot::OffHand,
}
    // rust: self.native_living_equipment(living, slot)
}
    // Puts `stack` (None: empties it) in equipment slot `slot`
    // (`LivingEntity.setItemSlot`), as `/item replace entity` does. False
    // when the entity has no such slot: a player has no body or saddle
    // slot, the dragon none. A mob has every slot, head and body apart
    // (`EntityEquipment`), as `/item` does; Horizon keeps no mob saddle here
    // yet. False on a client. API 382.
    // rust: pub(super) fn native_living_set_equipment(
    // rust: &mut self,
    // rust: living: LivingRef,
    // rust: slot: EquipmentSlot,
    // rust: stack: Option<ItemStack>,
    // rust: ) -> bool {
        // A client's copy changes only when the server says so.
    // rust: if self.remote.is_some() {
    // rust: return false;
}
    // rust: let Some(t) = self.native_living_target(living) else {
    // rust: return false;
}
        // ItemStack.isEmpty: air or a zero count empties the slot, as `/item` does.
    // rust: let stack = stack.filter(|s| &*s.item != "minecraft:air" && s.count > 0);
    // rust: match self
    // rust: .slots_named(&Owner::Entity(t), slot_name(slot))
    // rust: .as_slice()
    // rust: {
    // rust: [s] => self.slot_set(s, stack),
    // rust: _ => false,
}
}
}

    // rust: mod tests {
//     use super::*;

a_players_slots_come_from_its_inventory_armour_and_off_hand :: proc() {
}
    // rust: let stack = |id: &str| Some(ItemStack::new(id, 1));
    // rust: let inventory = vec![stack("minecraft:stone"), stack("minecraft:dirt")];
    // rust: let armor = [
    // rust: stack("minecraft:iron_helmet"),
    // rust: None,
    // rust: None,
    // rust: stack("minecraft:iron_boots"),
    // rust: ];
    // rust: let offhand = stack("minecraft:shield");
    // rust: let at = |slot| player_slot(&inventory, 1, &armor, &offhand, slot).map(|s| s.item);
    // rust: assert_eq!(
    // rust: at(EquipmentSlot::MainHand).as_deref(),
    // rust: Some("minecraft:dirt")
    // rust: );
    // rust: assert_eq!(
    // rust: at(EquipmentSlot::OffHand).as_deref(),
    // rust: Some("minecraft:shield")
    // rust: );
    // rust: assert_eq!(
    // rust: at(EquipmentSlot::Head).as_deref(),
    // rust: Some("minecraft:iron_helmet")
    // rust: );
    // rust: assert_eq!(
    // rust: at(EquipmentSlot::Feet).as_deref(),
    // rust: Some("minecraft:iron_boots")
    // rust: );
    // rust: assert_eq!(at(EquipmentSlot::Chest), None);
    // rust: assert_eq!(at(EquipmentSlot::Body), None);
}

every_equipment_slot_has_its_own_item_command_name :: proc() {
}
    // rust: let names = EquipmentSlot::ALL.map(slot_name);
    // rust: for (i, n) in names.iter().enumerate() {
    // rust: assert!(!names[..i].contains(n), "{n} named twice");
}
}
}
