//! Transpiled from Horizon Rust crate
//! Module: horizon-client_legacy_rules
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Legacy combat rules on the worlds this game serves (`horizon_client::legacy_combat`): the
//! server side of `Player.attack` with 1.8.9's damage, critical hits, no attack cooldown and
//! no sweep. Off by default; a window that plays on a server (`remote`) never uses them.
// use super::Game;
// use horizon_client::legacy_combat;

    // rust: impl Game<'_> {
    /// Whether the hits this game resolves follow 1.8.9: legacy rules are on and this game
    /// is the server (its own server thread, a LAN host, a dedicated server).
    // rust: pub(super) fn legacy_rules(&self) -> bool {
    // rust: self.remote.is_none() && self.settings.extras.pvp.combat.rules
}

    /// `melee_damage` under legacy rules: (damage, attack strength, critical, enchanted).
    /// The strength is always full: 1.8.9 had no cooldown.
    // rust: pub(super) fn legacy_melee_damage(
    // rust: &mut self,
    // rust: target_kind: &str,
    // rust: living: bool,
    // rust: ) -> (f32, f32, bool, bool) {
    // rust: let held = self.held().cloned();
    // rust: let weapon = held
    // rust: .as_ref()
    // rust: .and_then(|s| legacy_combat::weapon_damage(&s.item))
    // rust: .unwrap_or_else(|| self.modern_weapon_damage());
    // rust: let amplifier = |id| self.potions.effects.get(id).map(|e| e.amplifier);
    // rust: let attribute =
    // rust: legacy_combat::attack_damage(weapon, amplifier("strength"), amplifier("weakness"));
        // Riptide's spin replaces the attack damage, as in 26.3.
    // rust: let spin = self.player.as_ref().map_or(0.0, |p| p.auto_spin_attack_dmg);
    // rust: let mut base = if spin > 0.0 { spin } else { attribute };
        // A mace's smash: not in 1.8.9, kept as 26.3 adds it.
    // rust: base += self.smash_damage_bonus(target_kind);
    // rust: let enchant = match (&held, living) {
    // rust: (Some(s), true) => legacy_combat::enchant_bonus(s.enchantments(), target_kind),
    // rust: _ => 0.0,
}
    // rust: let vanilla_crit = living && legacy_combat::critical(self.legacy_attacker());
    // rust: let (mut crit, mut multiplier) = (vanilla_crit, legacy_combat::CRIT);
    // rust: if living && (base > 0.0 || enchant > 0.0) {
    // rust: self.native_critical_hit(target_kind, vanilla_crit, &mut crit, &mut multiplier);
}
    // rust: let amount = legacy_combat::damage(base, crit.then_some(multiplier), enchant);
    // rust: (amount, 1.0, crit, enchant > 0.0)
}

    /// What the held item adds to the attack damage in 26.3, for weapons 1.8.9 didn't have.
pub fn modern_weapon_damage(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::mobs::equip::{Slot, attribute_with};
    // rust: self.attack_item_info().map_or(0.0, |info| {
    // rust: attribute_with(
    // rust: &info.modifiers,
    // rust: "minecraft:attack_damage",
    // rust: 1.0,
    // rust: Slot::MainHand,
    // rust: ) - 1.0
    // rust: })
}

    /// The sprint and Knockback push on this game's player (a guest swapped in), added as 1.8.9 did.
    // rust: pub(super) fn legacy_extra_knockback(&mut self, strength: f64, dir: (f64, f64)) {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: let v = p.velocity;
    // rust: let [x, y, z] = legacy_combat::extra_knockback([v.x, v.y, v.z], strength, dir);
    // rust: p.velocity.x = x;
    // rust: p.velocity.y = y;
    // rust: p.velocity.z = z;
}
}

pub fn legacy_attacker(self: *Self) l {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.player.as_ref();
    // rust: legacy_combat::Attacker {
    // rust: fall_distance: p.map_or(0.0, |p| p.fall_distance),
    // rust: on_ground: p.is_none_or(|p| p.ground.on_ground),
    // rust: in_water: p.is_some_and(|p| p.fluids.was_touching_water),
    // rust: blind: self.potions.effects.get("blindness").is_some(),
    // rust: riding: self.riding.is_some(),
}
}
}
