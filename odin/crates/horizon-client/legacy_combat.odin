//! Transpiled from Horizon Rust crate
package horizon_client_legacy_combat

import "core:fmt"
import "core:mem"
import "core:math"

// 1.8.9's melee rules, for the worlds Horizon serves with legacy combat on (the PvP page's
// "1.8 combat in worlds you host", off by default). 26.3 stays the rule everywhere else:
// a client never uses these, so a vanilla server sees the same game.
//
// What 1.8.9 did, read from its client jar (MCP names):
// - `EntityPlayer.attackTargetEntityWithCurrentItem`: the attack damage attribute, a
//   critical hit (×1.5) when falling, off the ground, not on a ladder, not in water, not
//   blind and not riding (sprinting allowed), then the enchantment bonus. No attack
//   cooldown and no sweep (both came with 1.9).
// - `EntityPlayer.applyEntityAttributes`: the attack damage base is 1.
// - `ItemSword`: `4.0F + material.getDamageVsEntity()`; `ItemTool`: the tool's own value
//   plus the material's, with `ItemAxe` 3, `ItemPickaxe` 2 and `ItemSpade` 1.
// - `Item.ToolMaterial.getDamageVsEntity`: WOOD 0, STONE 1, IRON 2, EMERALD (diamond) 3, GOLD 0.
// - `PotionAttackDamage.getAttributeModifierAmount`: Strength 1.3 × (amplifier + 1) with
//   operation 2 (the total times 1 + amount), Weakness −0.5 × (amplifier + 1) with operation 0.
// - `ModifiableAttributeInstance.computeValue`: base plus the operation 0 amounts, then the
//   operation 2 products, clamped to the attribute's minimum 0.
// - `EnchantmentDamage.calcDamageByCreature`: Sharpness 1.25 per level, Smite 2.5 per level
//   against `UNDEAD`, Bane of Arthropods 2.5 per level against `ARTHROPOD`.
// - `EntityLivingBase.knockBack`: resisted only by chance (`rand.nextDouble() < knockbackResistance`); otherwise
//   the motion halves, the push of 0.4 goes away from the attacker, and up by 0.4 (at most 0.4 in all), in the air
//   too (26.3 lifts only from the ground and scales the push by the resistance).
// - The sprint and Knockback push in `attackTargetEntityWithCurrentItem`: `addVelocity(-sin(yaw) * i * 0.5, 0.1,
//   cos(yaw) * i * 0.5)`, added to the motion as it is (26.3 halves it first, through `knockback`).
// use std::sync::Arc;

// `ToolMaterial.getDamageVsEntity` by the item id's material. Netherite and copper didn't
// exist: netherite is one step above diamond and copper sits with stone, as 26.3 ranks them.
material :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match name {
    // rust: "wooden" | "golden" => 0.0,
    // rust: "stone" | "copper" => 1.0,
    // rust: "iron" => 2.0,
    // rust: "diamond" => 3.0,
    // rust: "netherite" => 4.0,
    // rust: _ => return None,
    // rust: })
}

// What a weapon adds to the attack damage attribute in 1.8.9 (its "Weapon modifier"),
// or None for an item 1.8.9 didn't have or ranks differently (a trident, a mace, a
// spear), which keeps 26.3's value. Hoes and other items add nothing, as in 1.8.9.
weapon_damage :: proc(item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = item.strip_prefix("minecraft:").unwrap_or(item);
    // rust: let (name, kind) = id.rsplit_once('_')?;
    // rust: let tool = match kind {
    // rust: "sword" => 4.0,
    // rust: "axe" => 3.0,
    // rust: "pickaxe" => 2.0,
    // rust: "shovel" => 1.0,
    // rust: "hoe" => return material(name).map(|_| 0.0),
    // rust: _ => return None,
}
    // rust: Some(tool + material(name)?)
}

// The attack damage attribute in 1.8.9: base 1 plus the weapon and Weakness, times
// Strength, never below 0. `strength` and `weakness` are the effects' amplifiers.
attack_damage :: proc(weapon: f64, strength: Maybe(i32), weakness: Maybe(i32)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let level = |amplifier: i32| f64::from(amplifier + 1);
    // rust: let mut value = 1.0 + weapon + weakness.map_or(0.0, |a| -0.5 * level(a));
    // rust: if let Some(a) = strength {
    // rust: value *= 1.0 + 1.3 * level(a);
}
    // rust: value.max(0.0) as f32
}

// `EnumCreatureAttribute.UNDEAD`: 1.8.9's undead, and the ones added since that 26.3
// counts as such (`#sensitive_to_smite`).
undead :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: id,
    // rust: "zombie"
    // rust: | "zombie_villager"
    // rust: | "husk"
    // rust: | "drowned"
    // rust: | "zombified_piglin"
    // rust: | "skeleton"
    // rust: | "stray"
    // rust: | "bogged"
    // rust: | "parched"
    // rust: | "wither_skeleton"
    // rust: | "wither"
    // rust: | "phantom"
    // rust: | "zoglin"
    // rust: | "skeleton_horse"
    // rust: | "zombie_horse"
    // rust: | "camel_husk"
    // rust: | "zombie_nautilus"
    // rust: )
}
// `EnumCreatureAttribute.ARTHROPOD`, and the bee 26.3 adds.
arthropod :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: id,
    // rust: "spider" | "cave_spider" | "silverfish" | "endermite" | "bee"
    // rust: )
}

// The enchantment bonus of a weapon's `levels` against an entity of type `target`.
enchant_bonus :: proc(levels: ^[(^str) {
}
    // rust: let target = target.strip_prefix("minecraft:").unwrap_or(target);
    // rust: levels
    // rust: .iter()
    // rust: .map(|(id, level)| {
    // rust: let level = *level as f32;
    // rust: match &**id {
    // rust: "minecraft:sharpness" => 1.25 * level,
    // rust: "minecraft:smite" if undead(target) => 2.5 * level,
    // rust: "minecraft:bane_of_arthropods" if arthropod(target) => 2.5 * level,
    // rust: _ => 0.0,
}
    // rust: })
    // rust: .sum()
}

// Where the attacker stands, as the critical hit reads it.
Attacker :: struct {
    fall_distance: f64,
    on_ground: bool,
    in_water: bool,
    blind: bool,
    riding: bool,
}
// 1.8.9's critical hit on a living target: unlike 26.3, a sprinting hit can be one and no
// charge is needed. (The ladder test is left out: climbing keeps the fall distance at 0.)
critical :: proc(a: Attacker) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a.fall_distance > 0.0 && !a.on_ground && !a.in_water && !a.blind && !a.riding
}

// A critical hit's multiplier.
CRIT :: 1.5
// The damage of a hit: the attribute, times the critical multiplier when the hit is one and
// the attribute is above 0, then the enchantments.
damage :: proc(attribute: f32, crit: Maybe(f32), enchant: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let base = match crit {
    // rust: Some(multiplier) if attribute > 0.0 => attribute * multiplier,
    // rust: _ => attribute,
}
    // rust: base + enchant
}

// `EntityLivingBase.knockBack` on `velocity`: `power` away from the direction (`xd`, `zd`), which points at the
// attacker, and up, in the air as on the ground. The caller has already rolled the resistance.
knockback :: proc(velocity: [f64; 3], power: f64) {
}
    // rust: let len = (xd * xd + zd * zd).sqrt();
    // rust: [
    // rust: velocity[0] / 2.0 - xd / len * power,
    // rust: (velocity[1] / 2.0 + power).min(0.4),
    // rust: velocity[2] / 2.0 - zd / len * power,
    // rust: ]
}
// Whether a knockback resistance of `resistance` stops the push, from a roll of `roll` in [0, 1).
resists :: proc(resistance: f64, roll: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: roll < resistance
}
// The extra push of a sprinting or Knockback hit, `strength` along (`xd`, `zd`) (the attacker's look, as
// `extra_knockback_direction` gives it: 26.3's `knockback` pushes away from it), and 0.1 up.
extra_knockback :: proc(velocity: [f64; 3], strength: f64) {
}
    // rust: [
    // rust: velocity[0] - xd * strength,
    // rust: velocity[1] + 0.1,
    // rust: velocity[2] - zd * strength,
    // rust: ]
}

    // rust: mod tests {
//     use super::*;

sword :: proc(id: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: attack_damage(weapon_damage(id).unwrap(), None, None)
}

weapons_hit_as_hard_as_in_1_8_9 :: proc() {
}
        // The hit's damage with the base 1: a 1.8.9 diamond sword hit for 8 (4 hearts).
    // rust: for (id, damage) in [
    // rust: ("minecraft:wooden_sword", 5.0),
    // rust: ("minecraft:golden_sword", 5.0),
    // rust: ("minecraft:stone_sword", 6.0),
    // rust: ("minecraft:iron_sword", 7.0),
    // rust: ("minecraft:diamond_sword", 8.0),
    // rust: ("minecraft:diamond_axe", 7.0),
    // rust: ("minecraft:iron_axe", 6.0),
    // rust: ("minecraft:stone_pickaxe", 4.0),
    // rust: ("minecraft:diamond_shovel", 5.0),
    // rust: ("minecraft:iron_hoe", 1.0),
    // rust: ("minecraft:netherite_sword", 9.0),
    // rust: ] {
    // rust: assert_eq!(sword(id), damage, "{id}");
}
    // rust: for id in ["minecraft:trident", "minecraft:mace", "minecraft:stick"] {
    // rust: assert_eq!(weapon_damage(id), None, "{id}");
}
}

strength_multiplies_and_weakness_subtracts :: proc() {
}
    // rust: let diamond = weapon_damage("diamond_sword").unwrap();
        // Strength II: 8 × (1 + 1.3 × 2) = 28.8; Strength I with an iron sword: 7 × 2.3.
    // rust: assert!((attack_damage(diamond, Some(1), None) - 28.8).abs() < 1e-4);
    // rust: assert!((attack_damage(2.0 + 4.0, Some(0), None) - 16.1).abs() < 1e-4);
        // Weakness I on a fist: 1 − 0.5; Weakness II can't go below 0.
    // rust: assert_eq!(attack_damage(0.0, None, Some(0)), 0.5);
    // rust: assert_eq!(attack_damage(0.0, None, Some(4)), 0.0);
        // Weakness is added before Strength multiplies: (1 − 0.5) × 2.3.
    // rust: assert!((attack_damage(0.0, Some(0), Some(0)) - 1.15).abs() < 1e-6);
}

enchantments_add_1_8_9_bonuses :: proc() {
}
    // rust: let levels = |l: &[(&str, u32)]| -> Vec<(Arc<str>, u32)> {
    // rust: l.iter().map(|(e, n)| (Arc::from(*e), *n)).collect()
}
    // rust: let sharp = levels(&[("minecraft:sharpness", 5)]);
    // rust: assert_eq!(enchant_bonus(&sharp, "minecraft:player"), 6.25);
    // rust: let smite = levels(&[("minecraft:smite", 2), ("minecraft:bane_of_arthropods", 3)]);
    // rust: assert_eq!(enchant_bonus(&smite, "minecraft:zombie"), 5.0);
    // rust: assert_eq!(enchant_bonus(&smite, "minecraft:spider"), 7.5);
    // rust: assert_eq!(enchant_bonus(&smite, "minecraft:player"), 0.0);
}

a_sprinting_fall_crits_without_a_charge :: proc() {
}
    // rust: let falling = Attacker {
    // rust: fall_distance: 0.4,
    // rust: ..Attacker::default()
}
    // rust: assert!(critical(falling));
    // rust: for grounded in [
    // rust: Attacker {
    // rust: on_ground: true,
    // rust: ..falling
    // rust: },
    // rust: Attacker {
    // rust: in_water: true,
    // rust: ..falling
    // rust: },
    // rust: Attacker {
    // rust: blind: true,
    // rust: ..falling
    // rust: },
    // rust: Attacker {
    // rust: riding: true,
    // rust: ..falling
    // rust: },
    // rust: Attacker::default(),
    // rust: ] {
    // rust: assert!(!critical(grounded), "{grounded:?}");
}
        // A diamond sword with Sharpness V, critical: 8 × 1.5 + 6.25 (26.3: 7 × 1.5 + 3).
    // rust: assert_eq!(damage(8.0, Some(CRIT), 6.25), 18.25);
    // rust: assert_eq!(damage(0.0, Some(CRIT), 1.25), 1.25);
    // rust: assert_eq!(damage(8.0, None, 0.0), 8.0);
}

a_hit_lifts_a_player_in_the_air_too :: proc() {
}
        // Hit from z = +1 while falling at 0.5 a tick: 1.8.9 halves the fall and adds 0.4 (0.15 up);
        // 26.3 would leave the fall as it was.
    // rust: let v = knockback([0.0, -0.5, 0.0], 0.4, (0.0, 1.0));
    // rust: assert_eq!(v, [0.0, 0.15000000000000002, -0.4]);
        // Already rising fast: capped at 0.4.
    // rust: assert_eq!(knockback([0.2, 0.6, 0.0], 0.4, (3.0, 4.0))[1], 0.4);
    // rust: assert!((knockback([0.2, 0.6, 0.0], 0.4, (3.0, 4.0))[0] - (0.1 - 0.24)).abs() < 1e-12);
        // Resistance is a chance, not a cut: 0.6 stops 60% of the rolls.
    // rust: assert!(resists(0.6, 0.59) && !resists(0.6, 0.6) && !resists(0.0, 0.0));
}

a_sprint_hit_adds_its_push_without_halving :: proc() {
}
        // A sprint hit (i = 1) looking along +x: (sin, -cos) of yaw -90 is (-1, 0); the target flies to +x.
    // rust: let v = extra_knockback([0.1, 0.0, 0.0], 0.5, (-1.0, 0.0));
    // rust: assert_eq!(v, [0.6, 0.1, 0.0]);
}
}
