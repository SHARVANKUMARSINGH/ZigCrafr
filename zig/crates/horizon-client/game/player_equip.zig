//! Transpiled from Horizon Rust crate
//! Module: horizon-client_player_equip
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `LivingEntity.onEquipItem` for players: the equip sound and the equip
//! game event when an armour or off-hand slot takes a different item, from
//! every path that calls it (use, the inventory menu, the creative screen,
//! the swap-hands key, dispensers), for the host and for LAN guests.
// use super::Game;
// use horizon_client::items::ItemStack;

/// The equipment slots `onEquipItem` can act on, as `EquipmentSlot` names:
/// the armour (`Player.doesEmitEquipEvent`: these emit the game event) and
/// the off hand.
pub const ARMOR: [[]const u8; 4] = ["head", "chest", "legs", "feet"];
pub const OFFHAND: []const u8 = "offhand";

/// `ItemStack.isSameItemSameComponents` over optional stacks.
pub fn same(a: ?*ItemStack, b: ?*ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (a, b) {
    // rust: (None, None) => true,
    // rust: (Some(a), Some(b)) => a.same_item_same_components(b),
    // rust: _ => false,
}
}

    // rust: impl Game<'_> {
    /// The armour (head first) and the off hand, in `EquipmentSlot` order of
    /// the inventory menu's slots.
    // rust: pub(super) fn player_equipment(&self) -> [Option<ItemStack>; 5] {
    // rust: let [head, chest, legs, feet] = self.armor.clone();
    // rust: [head, chest, legs, feet, self.offhand.clone()]
}

    /// `onEquipItem` for every slot that changed since `before`: what the
    /// server does for the creative screen, which sends each changed slot
    /// (`handleSetCreativeModeSlot` sets it by player).
    // rust: pub(super) fn player_equipment_changed(&mut self, before: &[Option<ItemStack>; 5]) {
    // rust: let after = self.player_equipment();
    // rust: for (i, slot) in ARMOR.into_iter().chain([OFFHAND]).enumerate() {
    // rust: self.player_on_equip(slot, before[i].as_ref(), after[i].as_ref());
}
}

    /// `LivingEntity.onEquipItem(slot, old, new)` for the player in place
    /// (the host, or a guest inside `as_guest`).
    // rust: pub(super) fn player_on_equip(
    // rust: &mut self,
    // rust: slot: &str,
    // rust: old: Option<&ItemStack>,
    // rust: new: Option<&ItemStack>,
    // rust: ) {
    // rust: if !same(old, new) {
    // rust: self.player_equipped(slot, new);
}
}

    /// The body of `onEquipItem` once the item changed: the item's
    /// `Equippable.equipSound` when it is equipped in its own slot, and the
    /// `equip` / `unequip` game event for armour. Nothing on a client (the
    /// server plays it) or for a spectator. The player's `firstTick` never
    /// sees an equip here: loading a save sets the slots directly.
    // rust: pub(super) fn player_equipped(&mut self, slot: &str, new: Option<&ItemStack>) {
    // rust: if self.remote.is_some() || self.spectator() {
    // rust: return;
}
    // rust: self.native_on_equip(slot, new);
    // rust: let Some(at) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: let at = [at.x, at.y, at.z];
    // rust: let equippable = new
    // rust: .and_then(|s| self.items().get(&s.item))
    // rust: .and_then(|info| {
    // rust: let own = info.equip_slot.as_deref()?;
    // rust: Some((own == slot, info.equip_sound.clone()))
    // rust: });
    // rust: if let Some((true, sound)) = &equippable {
    // rust: let sound = sound
    // rust: .as_deref()
    // rust: .unwrap_or("minecraft:item.armor.equip_generic");
            // Player.getSoundSource: PLAYERS.
    // rust: let players = horizon_client::settings::SOUND_SOURCES
    // rust: .iter()
    // rust: .position(|s| *s == "player")
    // rust: .unwrap_or(0);
    // rust: self.audio.play_on(players, sound, Some(at), 1.0, 1.0);
}
    // rust: if ARMOR.contains(&slot) {
    // rust: let event = if equippable.is_some() {
    // rust: "minecraft:equip"
    // rust: } else {
    // rust: "minecraft:unequip"
}
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event(event, at, ctx);
}
}
}
