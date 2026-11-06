//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mob_gear
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Enchanting what mobs spawn with (`Mob.populateDefaultEquipmentEnchantments`
//! through the `mob_spawn_equipment` provider) and the raid buffs
//! (`Raider.applyRaidBuffs`).
// use super::Game;
// use horizon_client::{
    // rust: mobs::{
    // rust: Species,
    // rust: drops::{self, SLOTS},
    // rust: finalize::equip_stack,
    // rust: gear::{self, ARMOR, MAIN},
    // rust: spawner::equipment_table,
    // rust: },
    // rust: raid::{self, RaiderType},
}
// use horizon_core::random::RandomSource;
// use horizon_world::{loot::EntityLootParams, nbt::Tag};

/// `EnchantmentsByCostWithDifficulty` of `mob_spawn_equipment`.
pub const MIN_COST: i32 = 5;
pub const MAX_COST_SPAN: f32 = 17.0;

/// The mobs that call `populateDefaultEquipmentEnchantments` when they spawn.
pub fn enchants_spawn_gear(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: | Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::Pillager
    // rust: | Species::Vindicator
    // rust: | Species::Piglin
    // rust: | Species::Vex
    // rust: )
}
/// The item a mob holds or wears in an equipment slot.
pub fn slot_item(m: *horizon_client::mobs::Mob, slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match slot {
    // rust: gear::MAIN => m.extra.main_hand.clone(),
    // rust: gear::OFF => m.extra.off_hand.clone(),
    // rust: gear::HEAD => m.extra.head.clone(),
    // rust: gear::CHEST => m.extra.chest.clone(),
    // rust: gear::LEGS => m.extra.legs.clone(),
    // rust: _ => m.extra.feet.clone(),
}
}

    // rust: impl Game<'_> {
    /// `Mob.equip(EquipmentTable)` for a spawner's `equipment`: the loot table
    /// (the mob as `this`, its random sequence) is rolled and each stack goes
    /// in the slot `EquipmentUser.resolveSlot` picks, with the table's drop
    /// chance for that slot.
    // rust: pub(super) fn equip_from_table(&mut self, id: u32, table: &Tag) {
    // rust: let Some((name, chances)) = equipment_table(table) else {
    // rust: return;
}
    // rust: let Some(loot) = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: ) else {
    // rust: return;
}
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: if !loot.has_table(&name) {
    // rust: return;
}
    // rust: let params = EntityLootParams {
    // rust: this: drops::loot_entity(m, None),
    // rust: ..EntityLootParams::default()
}
    // rust: let seed = self.level.seed;
    // rust: let stacks = match loot.random_sequence(&name) {
    // rust: Some(sequence) => {
    // rust: let random = self.rand_sequences.get(sequence, seed);
    // rust: loot.roll_entity(&name, random, &params)
}
    // rust: None => loot.roll_entity(&name, &mut self.world.random, &params),
}
    // rust: let mut inserted: Vec<usize> = Vec::new();
    // rust: for stack in stacks.iter().filter(|s| !s.is_empty()) {
            // `resolveSlot`: an `equippable` item goes in its own slot, any
            // other in the main hand, each slot once.
    // rust: let slot = match self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_slot.as_deref())
    // rust: {
    // rust: Some(name) => SLOTS.iter().position(|s| *s == name),
    // rust: None => Some(0),
}
    // rust: let Some(slot) = slot.filter(|s| !inserted.contains(s)) else {
    // rust: continue;
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: equip_stack(m, slot, stack, chances[slot]);
}
    // rust: inserted.push(slot);
}
}
    /// `Mob.populateDefaultEquipmentEnchantments`: the weapon one time in
    /// four and each piece of armour one time in two, scaled by the local
    /// difficulty, enchanted as if at an enchanting table of cost 5 to 22.
    // rust: pub(super) fn enchant_spawn_equipment(&mut self, id: u32) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let species = m.species();
    // rust: if !enchants_spawn_gear(species) {
    // rust: return;
}
    // rust: let special = self
    // rust: .local_difficulty([m.position.x, m.position.y, m.position.z])
    // rust: .special();
    // rust: self.enchant_slot(id, MAIN, 0.25, special);
    // rust: for slot in ARMOR {
    // rust: self.enchant_slot(id, slot, 0.5, special);
}
        // Pillager.enchantSpawnedWeapon: one crossbow in 300 pierces.
    // rust: if species == Species::Pillager && self.world.random.next_int_bound(300).unwrap_or(1) == 0 {
    // rust: self.enchant_single(id, MAIN, "minecraft:piercing", 1, "minecraft:crossbow");
}
}
    /// `Zombie` / `AbstractSkeleton` halloween pumpkin after spawn gear.
    // rust: pub(super) fn halloween_spawn_head(&mut self, id: u32) {
    // rust: let halloween = horizon_client::mobs::finalize::is_halloween();
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: return;
}
    // rust: let mut random = self.mobs[i].random.clone();
    // rust: horizon_client::mobs::finalize::halloween_head(&mut self.mobs[i], &mut random, halloween);
    // rust: self.mobs[i].random = random;
}
pub fn enchant_slot(self: *Self, id: u32, slot: usize, chance: f32, special: f32) void {
}
    // rust: let Some(item) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .and_then(|m| slot_item(m, slot))
    // rust: else {
    // rust: return;
}
    // rust: if self.world.random.next_float() >= chance * special {
    // rust: return;
}
    // rust: self.enchant_item(id, slot, &item, special);
}
    /// `EnchantmentsByCostWithDifficulty.enchant` on the item in a slot.
    // rust: pub(super) fn enchant_item(&mut self, id: u32, slot: usize, item: &str, special: f32) {
    // rust: let random = &mut self.world.random;
    // rust: let top = MIN_COST + (special * MAX_COST_SPAN) as i32;
    // rust: let cost = random
    // rust: .next_int_between_inclusive(MIN_COST, top)
    // rust: .unwrap_or(MIN_COST);
    // rust: let e = &world_stations!(self).enchantments;
    // rust: let pool = e.tag("minecraft:on_mob_spawn_equipment");
    // rust: let picked = e.select(world_items!(self), random, item, cost, pool);
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: for (enchantment, level) in picked {
    // rust: gear::upgrade(m, slot, &enchantment, level);
}
}
}
    /// A `SingleEnchantment` provider on the item in `slot`, when it is `item`.
pub fn enchant_single(self: *Self, id: u32, slot: usize, enchantment: []const u8, level: u32, item: []const u8) void {
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: && slot_item(m, slot).as_deref() == Some(item)
    // rust: {
    // rust: gear::upgrade(m, slot, enchantment, level);
}
}

    /// `Pillager` / `Vindicator.applyRaidBuffs`: Quick Charge on a fresh
    /// crossbow after waves 3 and 5, Sharpness on a fresh axe.
    // rust: pub(super) fn apply_raid_buffs(&mut self, id: u32, kind: RaiderType, wave: i32, odds: f32) {
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let enchant = m.random.next_float() <= odds;
    // rust: match kind {
    // rust: RaiderType::Pillager if enchant => {
    // rust: let level = if wave > raid::num_groups(2) {
    // rust: 2
    // rust: } else if wave > raid::num_groups(1) {
    // rust: 1
    // rust: } else {
    // rust: 0
}
    // rust: if level > 0 {
    // rust: m.extra.set_main_hand(Some("minecraft:crossbow".into()));
    // rust: gear::set(m, MAIN, Vec::new());
    // rust: gear::upgrade(m, MAIN, "minecraft:quick_charge", level);
}
}
    // rust: RaiderType::Vindicator => {
    // rust: m.extra.set_main_hand(Some("minecraft:iron_axe".into()));
    // rust: gear::set(m, MAIN, Vec::new());
    // rust: if enchant {
    // rust: let level = if wave > raid::num_groups(2) { 2 } else { 1 };
    // rust: gear::upgrade(m, MAIN, "minecraft:sharpness", level);
}
}
    // rust: _ => {}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn only_the_vanilla_mobs_enchant_their_spawn_gear() void {
}
    // rust: assert!(enchants_spawn_gear(Species::Skeleton));
    // rust: assert!(enchants_spawn_gear(Species::Pillager));
    // rust: assert!(!enchants_spawn_gear(Species::WitherSkeleton));
    // rust: assert!(!enchants_spawn_gear(Species::PiglinBrute));
    // rust: assert!(!enchants_spawn_gear(Species::Villager));
}
}
