//! Transpiled from Horizon Rust crate
package horizon_client_gear

import "core:fmt"
import "core:mem"
import "core:math"

// Enchantments on the gear mobs wear and hold (`Mob.populateDefaultEquipmentEnchantments`,
// raid buffs): the side table kept beside the plain item ids in `Extra`,
// its saved form, and the combat numbers the enchantments give (Sharpness,
// Smite, Bane of Arthropods, Fire Aspect, Knockback, Power, Punch, Flame,
// Quick Charge and the protections).
// use super::{DamageKind, Mob, Species};
// use std::sync::Arc;

// Equipment slots in the order `Extra` keeps them.
MAIN :: 0
OFF :: 1
HEAD :: 2
CHEST :: 3
LEGS :: 4
FEET :: 5
ARMOR :: [HEAD, CHEST, LEGS, FEET]
// The `equipment` keys of each slot.
KEYS :: ["mainhand", "offhand", "head", "chest", "legs", "feet"]

    // rust: pub type Levels = Vec<(Arc<str>, u32)>;
// An armour trim: (`trim_material`, `trim_pattern`) ids.
    // rust: pub type Trim = (Arc<str>, Arc<str>);

// The enchantments and trims of each equipment slot, and the whole stack of
// the ones that have more than an id (a damage value, a name, a count).
Gear :: struct {
    slots: [Levels,
    // The `minecraft:trim` of each slot's item (a loot table's set_components).
    trims: [Maybe(Trim),
    // The stack in each slot beyond the main hand (that one is
    // `Extra::main_hand_stack`), when it is not just one plain item.
    stacks: [Maybe(crate::items::ItemStack),
}
    // rust: impl Gear {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.slots.iter().all(Vec::is_empty)
    // rust: && self.trims.iter().all(Option::is_none)
    // rust: && self.stacks.iter().all(Option::is_none)
}
level :: proc(self: ^Self, slot: uint, id: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.slots[slot]
    // rust: .iter()
    // rust: .find(|(e, _)| &**e == id)
    // rust: .map_or(0, |(_, l)| *l)
}
    // `ItemEnchantments.Mutable.upgrade`: keep the higher level.
upgrade :: proc(self: ^Self, slot: uint, id: string, level: u32) {
}
    // rust: match self.slots[slot].iter_mut().find(|(e, _)| &**e == id) {
    // rust: Some((_, l)) => *l = (*l).max(level),
    // rust: None => self.slots[slot].push((Arc::from(id), level)),
}
}
}

gear :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.gear.as_deref()
}
// The level of an enchantment on what `m` wears or holds in `slot`.
level :: proc(m: ^Mob, slot: uint, id: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: gear(m).map_or(0, |g| g.level(slot, id))
}
// Whether the item in `slot` is enchanted (the glint).
enchanted :: proc(m: ^Mob, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: gear(m).is_some_and(|g| !g.slots[slot].is_empty())
}
// Replace the enchantments of a slot; an empty list removes them. The slot's
// item is new, so its trim goes too (`set_trim` puts one back).
set :: proc(m: ^Mob, slot: uint, levels: Levels) {
}
    // rust: let g = m.extra.gear.get_or_insert_with(Box::default);
    // rust: g.slots[slot] = levels;
    // rust: g.trims[slot] = None;
    // rust: g.stacks[slot] = None;
    // rust: if g.is_empty() {
    // rust: m.extra.gear = None;
}
}
// Keep the whole `stack` of the item in `slot` (call it after `set`, which
// forgets the old one) when it is more than one plain item.
set_stack :: proc(m: ^Mob, slot: uint, stack: crate::items::ItemStack) {
}
    // rust: if stack.damage == 0 && stack.count <= 1 && stack.extra.is_none() {
    // rust: return;
}
    // rust: m.extra.gear.get_or_insert_with(Box::default).stacks[slot] = Some(stack);
}
// Set (None removes) the trim of a slot's item.
set_trim :: proc(m: ^Mob, slot: uint, trim: Maybe(Trim)) {
}
    // rust: let g = m.extra.gear.get_or_insert_with(Box::default);
    // rust: g.trims[slot] = trim;
    // rust: if g.is_empty() {
    // rust: m.extra.gear = None;
}
}
upgrade :: proc(m: ^Mob, slot: uint, id: string, level: u32) {
}
    // rust: m.extra
    // rust: .gear
    // rust: .get_or_insert_with(Box::default)
    // rust: .upgrade(slot, id, level);
}

// `#sensitive_to_smite` and `#sensitive_to_bane_of_arthropods`.
undead :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
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
    // rust: | Species::WitherSkeleton
    // rust: | Species::Wither
    // rust: | Species::Phantom
    // rust: | Species::Zoglin
    // rust: | Species::SkeletonHorse
    // rust: | Species::ZombieHorse
    // rust: | Species::CamelHusk
    // rust: | Species::ZombieNautilus
    // rust: )
}
arthropod :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Spider
    // rust: | Species::CaveSpider
    // rust: | Species::Silverfish
    // rust: | Species::Endermite
    // rust: | Species::Bee
    // rust: )
}
// The `minecraft:damage` bonus of a weapon's levels against `target`.
damage_bonus :: proc(levels: ^[(^str) {
}
    // rust: let mut bonus = 0.0;
    // rust: for (id, l) in levels {
    // rust: let l = *l as f32;
    // rust: match &**id {
    // rust: "minecraft:sharpness" => bonus += 1.0 + 0.5 * (l - 1.0),
    // rust: "minecraft:smite" if target.is_some_and(undead) => bonus += 2.5 * l,
    // rust: "minecraft:bane_of_arthropods" if target.is_some_and(arthropod) => bonus += 2.5 * l,
    // rust: _ => {}
}
}
    // rust: bonus
}
// `Mob.doHurtTarget`'s `getAttributeValue(ATTACK_DAMAGE)`: the mob's own
// value plus the `attack_damage` modifiers of the item in its main hand
// (an iron axe adds 8, a sword 4 to 7, a trident 8), which vanilla applies
// to the attribute map when the item is equipped.
attack_damage :: proc(m: ^Mob, items: Maybe(^crate::items::Items)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let base = f64::from(m.attrs.attack_damage);
    // rust: let modifiers = m
    // rust: .extra
    // rust: .main_hand
    // rust: .as_deref()
    // rust: .and_then(|id| items?.get(id))
    // rust: .map(|i| i.modifiers.as_slice());
    // rust: modifiers.map_or(base, |modifiers| {
    // rust: super::equip::attribute_with(
    // rust: modifiers,
    // rust: "minecraft:attack_damage",
    // rust: base,
    // rust: super::equip::Slot::MainHand,
    // rust: )
    // rust: }) as f32
}
// The extra damage of the mob's held weapon against a target species.
melee_bonus :: proc(m: ^Mob, target: Maybe(Species)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: gear(m).map_or(0.0, |g| damage_bonus(&g.slots[MAIN], target))
}
// Seconds of fire a melee hit sets (`Fire Aspect`: 4 per level).
fire_aspect :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 4 * level(m, MAIN, "minecraft:fire_aspect") as i32
}
// `minecraft:knockback` of the held weapon.
knockback :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: level(m, MAIN, "minecraft:knockback")
}
// What a bow adds to its arrows.
ArrowBonus :: struct {
    // Power: 1 + 0.5 per level above the first.
    damage: f32,
    // Punch: knockback levels.
    punch: u32,
    // Flame: sets the target on fire.
    flame: bool,
    // Piercing: entities an arrow passes through.
    pierce: u32,
}
arrow_bonus :: proc(m: ^Mob) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let power = level(m, MAIN, "minecraft:power");
    // rust: ArrowBonus {
    // rust: damage: if power > 0 {
    // rust: 1.0 + 0.5 * (power as f32 - 1.0)
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: punch: level(m, MAIN, "minecraft:punch"),
    // rust: flame: level(m, MAIN, "minecraft:flame") > 0,
    // rust: pierce: level(m, MAIN, "minecraft:piercing"),
}
}
// Enchantment protection points of the worn armour against a damage kind
// (`damage_protection`: 1 per level of Protection, 2 for the specialist
// ones, 3 for Feather Falling), capped at 20.
protection :: proc(m: ^Mob, kind: DamageKind) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let Some(g) = gear(m) else { return 0.0 };
    // rust: protection_points(g, kind).min(20.0)
}
protection_points :: proc(g: ^Gear, kind: DamageKind) -> f {
    // Ported from Horizon
    return {}
}
    // getDamageAfterMagicAbsorb returns before enchantments for #bypasses_effects;
    // Protection itself skips #bypasses_invulnerability. Plain generic is protected.
    // rust: if kind.bypasses_invulnerability() || kind.bypasses_effects() {
    // rust: return 0.0;
}
    // rust: let source = super::Damage::of(kind);
    // rust: let fire = source.is_fire();
    // rust: let projectile = source.is_projectile();
    // rust: let explosion = matches!(kind, DamageKind::Explosion | DamageKind::Fireworks)
    // rust: || matches!(kind, DamageKind::Named(n) if n.has(super::NamedDamage::IS_EXPLOSION));
    // rust: let fall = matches!(kind, DamageKind::Fall | DamageKind::Stalagmite)
    // rust: || matches!(kind, DamageKind::Named(n) if n.has(super::NamedDamage::IS_FALL));
    // rust: let mut total = 0.0;
    // rust: for slot in ARMOR {
    // rust: for (id, l) in &g.slots[slot] {
    // rust: let l = *l as f32;
    // rust: total += match &**id {
    // rust: "minecraft:protection" => l,
    // rust: "minecraft:fire_protection" if fire => 2.0 * l,
    // rust: "minecraft:blast_protection" if explosion => 2.0 * l,
    // rust: "minecraft:projectile_protection" if projectile => 2.0 * l,
    // rust: "minecraft:feather_falling" if fall => 3.0 * l,
    // rust: _ => 0.0,
}
}
}
    // rust: total
}

    // rust: mod tests {
//     use super::*;

levels :: proc(list: ^[(string) {
}
    // rust: list.iter().map(|(e, l)| (Arc::from(*e), *l)).collect()
}
sharpness_adds_half_a_heart_per_level_above_one :: proc() {
}
    // rust: let s = levels(&[("minecraft:sharpness", 3)]);
    // rust: assert_eq!(damage_bonus(&s, Some(Species::Cow)), 2.0);
}
smite_and_bane_need_the_right_target :: proc() {
}
    // rust: let l = levels(&[("minecraft:smite", 2), ("minecraft:bane_of_arthropods", 1)]);
    // rust: assert_eq!(damage_bonus(&l, Some(Species::Zombie)), 5.0);
    // rust: assert_eq!(damage_bonus(&l, Some(Species::Spider)), 2.5);
    // rust: assert_eq!(damage_bonus(&l, None), 0.0);
    // rust: for s in [Species::CamelHusk, Species::ZombieNautilus] {
    // rust: assert_eq!(damage_bonus(&l, Some(s)), 5.0);
}
}
protections_count_by_damage_kind :: proc() {
}
    // rust: let mut g = Gear::default();
    // rust: g.upgrade(HEAD, "minecraft:protection", 4);
    // rust: g.upgrade(FEET, "minecraft:feather_falling", 4);
    // rust: g.upgrade(CHEST, "minecraft:fire_protection", 2);
    // rust: assert_eq!(protection_points(&g, DamageKind::MobAttack), 4.0);
    // rust: assert_eq!(protection_points(&g, DamageKind::Fall), 16.0);
    // rust: assert_eq!(protection_points(&g, DamageKind::OnFire), 8.0);
    // rust: assert_eq!(protection_points(&g, DamageKind::Generic), 4.0);
    // rust: assert_eq!(protection_points(&g, DamageKind::GenericKill), 0.0);
    // rust: assert_eq!(protection_points(&g, DamageKind::OutOfWorld), 0.0);
}
upgrading_keeps_the_higher_level :: proc() {
}
    // rust: let mut g = Gear::default();
    // rust: g.upgrade(MAIN, "minecraft:power", 2);
    // rust: g.upgrade(MAIN, "minecraft:power", 1);
    // rust: assert_eq!(g.level(MAIN, "minecraft:power"), 2);
    // rust: assert!(!g.is_empty());
}
}
