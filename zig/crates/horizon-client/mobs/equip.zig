//! Transpiled from Horizon Rust crate
//! Module: horizon-client_equip
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Mob.equipItemIfPossible` and the comparisons behind it: `compareArmor`,
//! `compareWeapons`, `canReplaceEqualItem` and the per-species gates that
//! decide whether a mob takes an item off the ground at all (`wantsToPickUp`,
//! `canHoldItem`). `game/mob_looting.rs` reads the item data and calls these.
// use super::Species;

/// An `EquipmentSlot`, in the order `finalize::item` and `drops::SLOTS` keep
/// them.
pub const Slot = enum {
    MainHand,
    OffHand,
    Feet,
    Legs,
    Chest,
    Head,
};

    // rust: impl Slot {
    /// `EquipmentSlot.isArmor`: the four armour slots, not the hands.
pub fn is_armor(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Slot::Feet | Slot::Legs | Slot::Chest | Slot::Head)
}
    /// The `drops::SLOTS` index (`set_item`, `item`, `set_drop_chance`).
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as usize
}
}

/// `LivingEntity.getEquipmentSlotForItem`: the item's own `equippable` slot,
/// else the main hand. `None` for `body` and `saddle`: those name the wearer
/// they belong to (`Equippable.canBeEquippedBy`), which Horizon does not
/// model, so no mob of this pass puts them on.
pub fn slot_for(equip_slot: ?[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match equip_slot {
    // rust: None | Some("mainhand") => Some(Slot::MainHand),
    // rust: Some("offhand") => Some(Slot::OffHand),
    // rust: Some("head") => Some(Slot::Head),
    // rust: Some("chest") => Some(Slot::Chest),
    // rust: Some("legs") => Some(Slot::Legs),
    // rust: Some("feet") => Some(Slot::Feet),
    // rust: Some(_) => None,
}
}

/// `EquipmentSlotGroup.test`: whether a modifier the item records for `group`
/// counts in `slot`.
pub fn group_matches(group: []const u8, slot: Slot) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match group {
    // rust: "any" => true,
    // rust: "hand" => matches!(slot, Slot::MainHand | Slot::OffHand),
    // rust: "armor" => slot.is_armor(),
    // rust: "mainhand" => slot == Slot::MainHand,
    // rust: "offhand" => slot == Slot::OffHand,
    // rust: "head" => slot == Slot::Head,
    // rust: "chest" => slot == Slot::Chest,
    // rust: "legs" => slot == Slot::Legs,
    // rust: "feet" => slot == Slot::Feet,
        // `body` and `saddle` are slots this pass never equips into.
    // rust: _ => false,
}
}

/// `ItemAttributeModifiers.compute(attribute, base, slot)`: `base` (the mob's
/// own attribute value) plus the item's modifiers for `attribute` that apply
/// in `slot`, in the order the item lists them.
    // rust: pub fn attribute_with(
    // rust: modifiers: &[(String, String, f64, String, String)],
    // rust: attribute: &str,
    // rust: base: f64,
    // rust: slot: Slot,
    // rust: ) -> f64 {
    // rust: let mut value = base;
    // rust: for (kind, _, amount, operation, group) in modifiers {
    // rust: if kind != attribute || !group_matches(group, slot) {
    // rust: continue;
}
    // rust: value += match operation.as_str() {
    // rust: "add_multiplied_base" => amount * base,
    // rust: "add_multiplied_total" => amount * value,
    // rust: _ => *amount,
}
}
    // rust: value
}

/// What the comparisons read about one stack: `getApproximateAttributeWith`
/// over its `attribute_modifiers`, and the three facts `canReplaceEqualItem`
/// compares.
pub const Facts = struct {
    armor: f64,
    armor_toughness: f64,
    attack_damage: f64,
    /// How many enchantments the stack carries (`ENCHANTMENTS`).
    enchantments: usize,
    damage: i32,
    custom_name: bool,
    /// `EnchantmentEffectComponents.PREVENT_ARMOR_CHANGE` (Curse of Binding).
    prevents_armor_change: bool,
};

/// `Mob.canReplaceCurrentItem`: whether the stack the mob could take beats
/// what it has in `slot`. `preferred` is `getPreferredWeaponType`'s tag
/// answer for the two stacks, `(new, current)`; `None` when the mob has none.
    // rust: pub fn can_replace_current_item(
    // rust: new: &Facts,
    // rust: current: Option<&Facts>,
    // rust: slot: Slot,
    // rust: preferred: Option<(bool, bool)>,
    // rust: ) -> bool {
    // rust: let Some(current) = current else {
    // rust: return true;
}
    // rust: if slot.is_armor() {
    // rust: compare_armor(new, current)
    // rust: } else if slot == Slot::MainHand {
    // rust: compare_weapons(new, current, preferred)
    // rust: } else {
        // The off hand is never replaced.
    // rust: false
}
}

/// `Mob.compareArmor`: more armour wins, then more toughness, then
/// `canReplaceEqualItem`. A piece with `PREVENT_ARMOR_CHANGE` is never taken
/// off.
pub fn compare_armor(new: *Facts, current: *Facts) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if current.prevents_armor_change {
    // rust: return false;
}
    // rust: if new.armor != current.armor {
    // rust: return new.armor > current.armor;
}
    // rust: if new.armor_toughness != current.armor_toughness {
    // rust: return new.armor_toughness > current.armor_toughness;
}
    // rust: can_replace_equal_item(new, current)
}

/// `Mob.compareWeapons`: a weapon in the mob's preferred tag beats one
/// outside it, then more attack damage wins, then `canReplaceEqualItem`.
pub fn compare_weapons(new: *Facts, current: *Facts, preferred: Option<(bool) void {
}
    // rust: if let Some((new_is, current_is)) = preferred {
    // rust: if current_is && !new_is {
    // rust: return false;
}
    // rust: if new_is && !current_is {
    // rust: return true;
}
}
    // rust: if new.attack_damage != current.attack_damage {
    // rust: return new.attack_damage > current.attack_damage;
}
    // rust: can_replace_equal_item(new, current)
}

/// `Mob.canReplaceEqualItem`: more enchantments wins, then less damage, then a
/// custom name.
pub fn can_replace_equal_item(new: *Facts, current: *Facts) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if new.enchantments != current.enchantments {
    // rust: return new.enchantments > current.enchantments;
}
    // rust: if new.damage != current.damage {
    // rust: return new.damage < current.damage;
}
    // rust: new.custom_name && !current.custom_name
}

/// `Mob.getPreferredWeaponType` of the species that have one; the wither
/// skeleton overrides it back to null.
pub fn preferred_weapon_tag(species: Species) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match species {
    // rust: Species::Skeleton | Species::Stray | Species::Bogged | Species::Parched => {
    // rust: Some("minecraft:skeleton_preferred_weapons")
}
    // rust: Species::Drowned => Some("minecraft:drowned_preferred_weapons"),
    // rust: _ => None,
}
}

pub fn is_skeleton(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::WitherSkeleton
    // rust: )
}
pub fn is_zombie(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Zombie | Species::Husk | Species::Drowned | Species::ZombieVillager
    // rust: )
}

/// The tag facts `wants_to_pick_up` reads about one item.
pub const ItemTags = struct {
    /// `#minecraft:spears`.
    spear: bool,
    /// `#minecraft:eggs`.
    egg: bool,
    /// `#minecraft:wither_skeleton_disliked_weapons`.
    disliked_weapon: bool,
};

/// `Mob.aiStep`'s looting gate, `Mob.wantsToPickUp` with `canHoldItem`, for
/// the species whose pickup ends in the base `Mob.pickUpItem` (the equip of
/// `equipItemIfPossible`; a piglin brute takes only a golden axe). A villager, piglin, allay, panda, sulfur cube,
/// fox, dolphin or pillager overrides the pickup itself and has its own loop
/// elsewhere; an illager's `Raider.pickUpItem` puts the ominous banner on the
/// head, which Horizon does not model, so they answer `false` here too.
    // rust: pub fn wants_to_pick_up(
    // rust: species: Species,
    // rust: baby: bool,
    // rust: passenger: bool,
    // rust: item: &str,
    // rust: tags: ItemTags,
    // rust: ) -> bool {
    // rust: if !matches!(
    // rust: species,
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: | Species::PiglinBrute
    // rust: ) && !is_skeleton(species)
    // rust: {
    // rust: return false;
}
    // `PiglinBrute.wantsToPickUp`: only a golden axe, then `Mob.wantsToPickUp`.
    // rust: if species == Species::PiglinBrute && item != "minecraft:golden_axe" {
    // rust: return false;
}
    // `AbstractSkeleton.wantsToPickUp` and `Drowned.wantsToPickUp`.
    // rust: if (is_skeleton(species) || species == Species::Drowned) && tags.spear {
    // rust: return false;
}
    // `Zombie.wantsToPickUp` (the other zombies) refuses glow ink;
    // `ZombifiedPiglin.wantsToPickUp` is a bare `canHoldItem`.
    // rust: if is_zombie(species) && item == "minecraft:glow_ink_sac" {
    // rust: return false;
}
    // `Zombie.canHoldItem`: a baby riding something leaves eggs alone.
    // rust: if (is_zombie(species) || species == Species::ZombifiedPiglin) && baby && passenger && tags.egg
    // rust: {
    // rust: return false;
}
    // `WitherSkeleton.canHoldItem`.
    // rust: if species == Species::WitherSkeleton && tags.disliked_weapon {
    // rust: return false;
}
    // rust: true
}

    // rust: mod tests {
//     use super::*;

pub fn facts(armor: f64, toughness: f64, damage: f64) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Facts {
    // rust: armor,
    // rust: armor_toughness: toughness,
    // rust: attack_damage: damage,
    // rust: ..Facts::default()
}
}
pub fn sword(damage: f64) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: facts(0.0, 0.0, damage)
}
    /// `canReplaceCurrentItem` for an item that goes in the main hand, from a
    /// mob with no preferred weapon tag.
pub fn replaces_weapon(new: *Facts, current: *Facts) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: can_replace_current_item(new, Some(current), Slot::MainHand, None)
}
    /// The same for a chest piece.
pub fn replaces_armour(new: *Facts, current: *Facts) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: can_replace_current_item(new, Some(current), Slot::Chest, None)
}

pub fn a_better_weapon_replaces_a_worse_one_and_not_the_reverse() void {
}
    // rust: let (iron, wood) = (sword(7.0), sword(5.0));
    // rust: assert!(replaces_weapon(&iron, &wood));
    // rust: assert!(!replaces_weapon(&wood, &iron));
        // An empty hand takes anything.
    // rust: assert!(can_replace_current_item(&wood, None, Slot::MainHand, None));
        // A hand already holding it keeps it: equal damage, equal everything.
    // rust: assert!(!replaces_weapon(&iron, &iron));
}

pub fn armour_with_more_armour_or_toughness_wins() void {
}
    // rust: let (diamond, iron) = (facts(8.0, 2.0, 0.0), facts(6.0, 0.0, 0.0));
    // rust: assert!(replaces_armour(&diamond, &iron));
    // rust: assert!(!replaces_armour(&iron, &diamond));
        // Equal armour: the tougher piece wins.
    // rust: let tough = facts(8.0, 3.0, 0.0);
    // rust: assert!(replaces_armour(&tough, &diamond));
    // rust: assert!(!replaces_armour(&diamond, &tough));
}

pub fn an_equal_weapon_with_enchantments_wins() void {
}
    // rust: let plain = sword(7.0);
    // rust: let sharp = Facts {
    // rust: enchantments: 2,
    // rust: ..sword(7.0)
}
    // rust: assert!(replaces_weapon(&sharp, &plain));
    // rust: assert!(!replaces_weapon(&plain, &sharp));
        // Same enchantment count: the less damaged one wins, then a named one.
    // rust: let worn = Facts {
    // rust: damage: 40,
    // rust: ..sharp
}
    // rust: assert!(replaces_weapon(&sharp, &worn));
    // rust: let named = Facts {
    // rust: custom_name: true,
    // rust: ..sharp
}
    // rust: assert!(replaces_weapon(&named, &sharp));
    // rust: assert!(!replaces_weapon(&sharp, &named));
}

pub fn a_piece_that_prevents_armour_change_is_never_replaced() void {
}
    // rust: let plain = facts(2.0, 0.0, 0.0);
    // rust: let cursed = Facts {
    // rust: prevents_armor_change: true,
    // rust: ..plain
}
    // rust: let better = facts(8.0, 3.0, 0.0);
    // rust: assert!(!replaces_armour(&better, &cursed));
    // rust: assert!(replaces_armour(&better, &plain));
        // The weapon comparison does not look at it.
    // rust: let cursed_sword = Facts {
    // rust: prevents_armor_change: true,
    // rust: ..sword(1.0)
}
    // rust: assert!(replaces_weapon(&sword(7.0), &cursed_sword));
}

pub fn a_preferred_weapon_beats_a_stronger_one_outside_the_tag() void {
}
    // rust: let (axe, bow) = (sword(9.0), sword(1.0));
        // The skeleton's bow counts as a preferred weapon, both ways round.
    // rust: let main = Slot::MainHand;
    // rust: assert!(!can_replace_current_item(
    // rust: &axe,
    // rust: Some(&bow),
    // rust: main,
    // rust: Some((false, true))
    // rust: ));
    // rust: assert!(can_replace_current_item(
    // rust: &bow,
    // rust: Some(&axe),
    // rust: main,
    // rust: Some((true, false))
    // rust: ));
        // Both in the tag: the damage decides.
    // rust: assert!(can_replace_current_item(
    // rust: &axe,
    // rust: Some(&bow),
    // rust: main,
    // rust: Some((true, true))
    // rust: ));
    // rust: assert!(!can_replace_current_item(
    // rust: &bow,
    // rust: Some(&axe),
    // rust: main,
    // rust: Some((true, true))
    // rust: ));
}

pub fn attribute_modifiers_apply_by_slot_group_and_operation() void {
}
    // rust: let entry = |attribute: &str, amount: f64, operation: &str, group: &str| {
    // rust: (
    // rust: attribute.to_owned(),
    // rust: "minecraft:test".to_owned(),
    // rust: amount,
    // rust: operation.to_owned(),
    // rust: group.to_owned(),
    // rust: )
}
    // rust: let modifiers = [
    // rust: entry("minecraft:armor", 8.0, "add_value", "chest"),
    // rust: entry("minecraft:attack_damage", 7.0, "add_value", "mainhand"),
    // rust: entry("minecraft:attack_damage", 1.0, "add_multiplied_base", "any"),
    // rust: ];
        // A chestplate's armour does not count in the feet slot.
    // rust: assert_eq!(
    // rust: attribute_with(&modifiers, "minecraft:armor", 0.0, Slot::Chest),
    // rust: 8.0
    // rust: );
    // rust: assert_eq!(
    // rust: attribute_with(&modifiers, "minecraft:armor", 0.0, Slot::Feet),
    // rust: 0.0
    // rust: );
        // The mob's own base damage is the start, and `any` applies.
    // rust: let damage = |slot| attribute_with(&modifiers, "minecraft:attack_damage", 1.0, slot);
    // rust: assert_eq!(damage(Slot::MainHand), 1.0 + 7.0 + 1.0);
    // rust: assert_eq!(damage(Slot::OffHand), 2.0);
}

pub fn items_go_in_their_own_slot() void {
}
    // rust: assert_eq!(slot_for(None), Some(Slot::MainHand));
    // rust: assert_eq!(slot_for(Some("head")), Some(Slot::Head));
    // rust: assert_eq!(slot_for(Some("feet")), Some(Slot::Feet));
        // A body or saddle item names its wearer, which no mob of this pass is.
    // rust: assert_eq!(slot_for(Some("body")), None);
}

pub fn the_pickup_gate_follows_the_species_overrides() void {
}
    // rust: let tags = |spear, egg, disliked_weapon| ItemTags {
    // rust: spear,
    // rust: egg,
    // rust: disliked_weapon,
}
    // rust: let none = tags(false, false, false);
    // rust: let gate = |species, baby, item, t| wants_to_pick_up(species, baby, false, item, t);
        // A zombie takes a sword; a skeleton refuses a spear but takes a bow.
    // rust: assert!(gate(
    // rust: Species::Zombie,
    // rust: false,
    // rust: "minecraft:diamond_sword",
    // rust: none
    // rust: ));
    // rust: assert!(!gate(
    // rust: Species::Skeleton,
    // rust: false,
    // rust: "minecraft:iron_spear",
    // rust: tags(true, false, false)
    // rust: ));
    // rust: assert!(gate(Species::Skeleton, false, "minecraft:bow", none));
        // `Zombie.wantsToPickUp` refuses glow ink; a zombified piglin does not.
    // rust: assert!(!gate(Species::Husk, false, "minecraft:glow_ink_sac", none));
    // rust: assert!(gate(
    // rust: Species::ZombifiedPiglin,
    // rust: false,
    // rust: "minecraft:glow_ink_sac",
    // rust: none
    // rust: ));
        // A baby zombie riding a chicken leaves eggs alone; on foot it takes one.
    // rust: let eggs = tags(false, true, false);
    // rust: assert!(!wants_to_pick_up(
    // rust: Species::Zombie,
    // rust: true,
    // rust: true,
    // rust: "minecraft:egg",
    // rust: eggs
    // rust: ));
    // rust: assert!(gate(Species::Zombie, true, "minecraft:egg", eggs));
    // rust: assert!(gate(Species::Husk, false, "minecraft:egg", eggs));
        // The wither skeleton and its disliked weapons.
    // rust: assert!(!gate(
    // rust: Species::WitherSkeleton,
    // rust: false,
    // rust: "minecraft:iron_sword",
    // rust: tags(false, false, true)
    // rust: ));
        // `PiglinBrute.wantsToPickUp`: a golden axe and nothing else.
    // rust: assert!(gate(
    // rust: Species::PiglinBrute,
    // rust: false,
    // rust: "minecraft:golden_axe",
    // rust: none
    // rust: ));
    // rust: assert!(!gate(
    // rust: Species::PiglinBrute,
    // rust: false,
    // rust: "minecraft:iron_sword",
    // rust: none
    // rust: ));
    // rust: assert!(!gate(
    // rust: Species::PiglinBrute,
    // rust: false,
    // rust: "minecraft:gold_ingot",
    // rust: none
    // rust: ));
        // The species whose pickup is elsewhere never answer yes.
    // rust: for s in [
    // rust: Species::Villager,
    // rust: Species::Piglin,
    // rust: Species::Panda,
    // rust: Species::Allay,
    // rust: Species::Fox,
    // rust: Species::Vindicator,
    // rust: ] {
    // rust: assert!(!gate(s, false, "minecraft:diamond_sword", none));
}
}
}
