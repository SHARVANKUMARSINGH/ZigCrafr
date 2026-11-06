//! Transpiled from Horizon Rust crate
package horizon_client_enchant_effects

import "core:fmt"
import "core:mem"
import "core:math"

// Enchantment effects on gameplay, read from the data-driven effect
// components: efficiency and aqua affinity (`Player.getDestroySpeed`),
// unbreaking (`minecraft:item_damage`), sharpness/smite/bane and power
// (`minecraft:damage`), knockback, fire aspect, infinity (`minecraft:ammo_use`),
// thorns (`minecraft:post_attack`), mending (`minecraft:repair_with_xp`) and
// the armor attribute effects (respiration, depth strider, ...), Soul
// Speed's `location_changed` and `tick` effects and the
// `minecraft:location_changed` disk effect (frost walker).
// use super::Game;
// use horizon_client::{
    // rust: enchant::{EffectContext, Enchantments, level_value},
    // rust: items::ItemStack,
    // rust: mobs::Who,
    // rust: projectiles::Projectile,
}
// use horizon_core::{position::BlockPos, random::RandomSource};
// use horizon_world::{fluid::FluidKind, level::LevelAccess, registry::BlockStateId};
// use serde_json::Value;

// Where Mending found a damaged item (`EnchantedItemInUse.inSlot`).
MendSlot :: enum {
    Main,
    Off,
    // An `armor` index (head first).
    Armor(usize),
}

// `Player.getDestroySpeed` multiplies by `BLOCK_BREAK_SPEED`; a player
// without the attribute keeps the vanilla default of 1.0.
block_break_speed_factor :: proc(value: Maybe(f64)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: value.map_or(1.0, |value| value as f32)
}

    // rust: impl Game<'_> {
    // `Player.getDestroySpeed` after the tool speed: mining efficiency, haste
    // and mining fatigue.
    // rust: pub(super) fn modify_destroy_speed(&mut self, mut speed: f32) -> f32 {
    // rust: if speed > 1.0 {
    // rust: speed += self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|player| player.attribute("minecraft:mining_efficiency").ok())
    // rust: .unwrap_or(0.0) as f32;
}
    // rust: speed * self.potions.effects.mining_speed_factor()
}
    // `Player.getDestroySpeed`'s final `Attributes.BLOCK_BREAK_SPEED` factor:
    // 1.0 by default, so a missing player or attribute changes nothing.
    // rust: pub(super) fn block_break_speed(&mut self) -> f32 {
    // rust: block_break_speed_factor(
    // rust: self.player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:block_break_speed").ok()),
    // rust: )
}
    // `Attributes.SUBMERGED_MINING_SPEED` (0.2, raised by aqua affinity).
    // rust: pub(super) fn submerged_mining_speed(&self) -> f32 {
    // rust: let mut total = 0.0;
    // rust: for stack in self.armor.iter().flatten() {
    // rust: for (attr, _, amount, op) in self.stations().enchantments.attributes(stack) {
    // rust: if attr == "minecraft:submerged_mining_speed" && op == "add_multiplied_total" {
    // rust: total += amount;
}
}
}
    // rust: (0.2 * (1.0 + total)) as f32
}
    // `EnchantmentHelper.processDurabilityChange` (unbreaking) for `amount` points.
    // rust: pub(super) fn durability_loss(&mut self, stack: &ItemStack, amount: u32) -> u32 {
    // rust: let e = &world_stations!(self).enchantments;
    // rust: if !e.has_component(stack, "minecraft:item_damage") {
    // rust: return amount;
}
    // rust: let ctx = EffectContext {
    // rust: tool: Some(&stack.item),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: e.modify_value(
    // rust: Some(stack),
    // rust: "minecraft:item_damage",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: amount as f32,
    // rust: )
    // rust: .max(0.0) as u32
}
    // `ItemStack.hurtAndBreak` for the player's `stack`: the wear Unbreaking
    // leaves, and `ItemDurabilityTrigger` when some is left (`applyDamage`).
    // rust: pub(super) fn wear(&mut self, stack: &ItemStack, amount: u32) -> u32 {
    // rust: let mut loss = self.durability_loss(stack, amount);
        // The mods hear a server player's wear once Unbreaking has had its say,
        // and may change it or stop it.
    // rust: if loss > 0
    // rust: && let (Some(uuid), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: let mut points = loss as i32;
    // rust: let mut cancel = false;
    // rust: self.native_item_damaged(uuid, &name, &stack.item, &mut points, &mut cancel);
    // rust: loss = if cancel { 0 } else { points.max(0) as u32 };
}
    // rust: if loss > 0 {
    // rust: self.trigger_item_durability(stack, stack.damage + loss);
}
    // rust: loss
}
    // `getEnchantedDamage - base`: damage bonus of the held weapon against a mob type.
    // rust: pub(super) fn enchant_damage_bonus(&mut self, target: &str) -> f32 {
    // rust: self.enchanted_damage(target, 0.0)
}
    // `Player.getEnchantedDamage`: `base` run through the held weapon's
    // damage effects against a mob type.
    // rust: pub(super) fn enchanted_damage(&mut self, target: &str, base: f32) -> f32 {
    // rust: let Some(held) = self.held().cloned() else {
    // rust: return base;
}
    // rust: let ctx = EffectContext {
    // rust: this: Some(target),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: damage_type: Some("minecraft:player_attack"),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: world_stations!(self).enchantments.modify_value(
    // rust: Some(&held),
    // rust: "minecraft:damage",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: base,
    // rust: )
}
    // `Player.attack`'s extra knockback: `getKnockback` (the weapon's knockback
    // enchantment, halved) plus 0.5 for a sprinting full-strength hit, and
    // whether the hit is that knockback attack.
    // rust: pub(super) fn extra_knockback(&mut self, target_kind: &str, scale: f32) -> (f32, bool) {
    // rust: let sprinting = self.player.as_ref().is_some_and(|p| p.sprinting);
    // rust: let enchanted = match self.held().cloned() {
    // rust: Some(held) => {
    // rust: let ctx = EffectContext {
    // rust: this: Some(target_kind),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: world_stations!(self).enchantments.modify_value(
    // rust: Some(&held),
    // rust: "minecraft:knockback",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: 0.0,
    // rust: )
}
    // rust: None => 0.0,
}
    // rust: horizon_client::attack_strength::extra_knockback(enchanted, scale, sprinting)
}
    // `causeExtraKnockback`'s direction, `(sin yRot, -cos yRot)` from Mth's
    // sine table: the target flies where the attacker looks, not away from
    // it (straight along an axis when the attacker faces one).
    // rust: pub(super) fn extra_knockback_direction(&self) -> (f64, f64) {
//         use horizon_core::geometry::trig;
    // rust: let yaw = f64::from(self.yaw * trig::DEG_TO_RAD);
    // rust: (f64::from(trig::sin(yaw)), -f64::from(trig::cos(yaw)))
}
    // The attacker's side of `causeExtraKnockback` as the attacking client
    // sees it after a hit on a mob: the server's player stops sprinting, and
    // its flag reaches the client. (The server's 0.6 speed cut never does:
    // the client's own `Player.attack` simulates no hurt on a mob, so it
    // skips the knockback. A hit on another player does simulate one:
    // `remote_player_attack`.)
    // rust: pub(super) fn stop_sprint_after_extra_knockback(&mut self) {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: let _ = p.set_sprinting(false);
}
}
    // After a successful melee hit: fire aspect and wind burst.
    // rust: pub(super) fn post_attack(&mut self, mob: usize) {
    // rust: let Some(held) = self.held().cloned() else {
    // rust: return;
}
    // rust: let Some(m) = self.mobs.get(mob) else { return };
    // rust: let kind = m.kind.id.clone();
    // rust: let victim = m.id;
    // rust: let ctx = EffectContext {
    // rust: this: Some(&kind),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
        // minecraft:post_attack effects of the attacker's weapon on the victim:
        // ignite (fire aspect) and apply_mob_effect (bane of arthropods).
    // rust: let mut ignite = 0.0f32;
    // rust: let mut mob_effects = Vec::new();
    // rust: let mut hook_calls: Vec<(String, String, Value, u32)> = Vec::new();
    // rust: for (id, level) in held.enchantments() {
    // rust: let Some(def) = world_stations!(self).enchantments.get(id) else {
    // rust: continue;
}
    // rust: for effect in def.effects["minecraft:post_attack"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: let e = &effect["effect"];
    // rust: if effect["enchanted"] != "attacker" || effect["affected"] != "victim" {
    // rust: continue;
}
                // A bare type name is minecraft's own, as a bare item id is.
    // rust: let kind_of = match e["type"].as_str() {
    // rust: Some(k) if k.contains(':') => k.to_owned(),
    // rust: Some(k) => format!("minecraft:{k}"),
    // rust: None => continue,
}
    // rust: let own = !kind_of.starts_with("minecraft:");
    // rust: if !own && !matches!(&*kind_of, "minecraft:ignite" | "minecraft:apply_mob_effect") {
    // rust: continue;
}
    // rust: let mut random = self.world.random.clone();
    // rust: let ok = effect.get("requirements").is_none_or(|r| {
    // rust: self.res
    // rust: .stations()
    // rust: .enchantments
    // rust: .condition(r, *level, &ctx, &mut random)
    // rust: });
    // rust: self.world.random = random;
    // rust: if !ok {
    // rust: continue;
}
                // A mod's own kind: its hook answers, after this loop (the
                // stations borrow is held here).
    // rust: if own {
    // rust: hook_calls.push((id.to_string(), kind_of, e.clone(), *level));
    // rust: } else if kind_of == "minecraft:ignite" {
    // rust: ignite =
    // rust: ignite.max(horizon_client::enchant::level_value(&e["duration"], *level));
    // rust: } else {
    // rust: mob_effects.push((e.clone(), *level));
}
}
}
    // rust: if ignite > 0.0
    // rust: && let Some(m) = self.mobs.get_mut(mob)
    // rust: && !m.kind.flags.fire_immune
    // rust: {
    // rust: m.ignite_for_ticks((ignite * 20.0) as i32);
}
    // rust: for (effect, level) in mob_effects {
    // rust: self.apply_mob_effect(mob, &effect, level);
}
    // rust: for (id, kind_of, data, level) in hook_calls {
    // rust: self.native_enchant_effect(&id, &kind_of, &data, level, victim);
}
    // rust: self.post_attack_bursts(&held, &kind);
}
    // `EnchantmentHelper.doPostPiercingAttackEffects`: the
    // `minecraft:post_piercing_attack` effects of the weapon in hand after a
    // jab (Lunge's dash).
    // rust: pub(super) fn post_piercing_attack(&mut self) {
    // rust: let Some(held) = self.held().cloned() else {
    // rust: return;
}
    // rust: let mut effects = Vec::new();
    // rust: for (id, level) in held.enchantments() {
    // rust: let Some(def) = self.stations().enchantments.get(id) else {
    // rust: continue;
}
    // rust: for entry in def.effects["minecraft:post_piercing_attack"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: effects.push((*level, entry["effect"].clone()));
}
}
        // Lunge's requirements: not riding, gliding or in water, and a
        // player outside creative with at least 7 food.
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if effects.is_empty()
    // rust: || self.riding.is_some()
    // rust: || p.fall_flying
    // rust: || p.fluids.was_touching_water
    // rust: || !(self.creative || p.health.food.food >= 7)
    // rust: {
    // rust: return;
}
    // rust: for (level, effect) in effects {
    // rust: self.apply_piercing_effect(&effect, level);
}
}
    // One `post_piercing_attack` effect on the player: `AllOf`,
    // `ChangeItemDamage`, `ApplyExhaustion`, `ApplyEntityImpulse` and
    // `PlaySoundEffect`.
apply_piercing_effect :: proc(self: ^Self, effect: ^serde_json::Value, level: u32) {
}
    // rust: let amount = || level_value(&effect["amount"], level);
    // rust: match effect["type"].as_str() {
    // rust: Some("minecraft:all_of") => {
    // rust: for e in effect["effects"].as_array().into_iter().flatten() {
    // rust: self.apply_piercing_effect(e, level);
}
}
    // rust: Some("minecraft:change_item_damage") => self.damage_held(amount() as u32),
    // rust: Some("minecraft:apply_exhaustion") => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.cause_food_exhaustion(amount());
}
}
            // The direction turned by the look (`Entity.getLookQuaternion`:
            // pitch about x, then yaw about y), scaled by coordinate_scale
            // and the magnitude, added to the velocity (the guest's client
            // is told of it by `guest_hit_by`).
    // rust: Some("minecraft:apply_impulse") => {
    // rust: let vec3 = |key: &str| [0, 1, 2].map(|i| effect[key][i].as_f64().unwrap_or(0.0));
    // rust: let (d, scale) = (vec3("direction"), vec3("coordinate_scale"));
    // rust: let magnitude = f64::from(level_value(&effect["magnitude"], level));
    // rust: let (yaw, pitch) = (
    // rust: f64::from(self.yaw).to_radians(),
    // rust: f64::from(self.pitch).to_radians(),
    // rust: );
    // rust: let (y1, z1) = (
    // rust: d[1] * pitch.cos() - d[2] * pitch.sin(),
    // rust: d[1] * pitch.sin() + d[2] * pitch.cos(),
    // rust: );
    // rust: let impulse = horizon_core::geometry::Vec3::new(
    // rust: (d[0] * yaw.cos() - z1 * yaw.sin()) * scale[0] * magnitude,
    // rust: y1 * scale[1] * magnitude,
    // rust: (d[0] * yaw.sin() + z1 * yaw.cos()) * scale[2] * magnitude,
    // rust: );
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = p.velocity.add_vector(impulse);
}
}
            // The sound for the level (a list picks by level), heard by all.
    // rust: Some("minecraft:play_sound") => {
    // rust: let sounds: Vec<&str> = match &effect["sound"] {
    // rust: serde_json::Value::Array(list) => {
    // rust: list.iter().filter_map(|s| s.as_str()).collect()
}
    // rust: one => one.as_str().into_iter().collect(),
}
    // rust: let index = (level as usize).saturating_sub(1);
    // rust: if let Some(sound) = sounds.get(index.min(sounds.len().saturating_sub(1))) {
    // rust: let float = |key: &str| effect[key].as_f64().unwrap_or(1.0) as f32;
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: self.audio.play(sound, at, float("volume"), float("pitch"));
}
}
    // rust: _ => {}
}
}
    // `ApplyMobEffect.apply`: one of `to_apply` (a single id or a list) for a
    // random duration and amplifier between the level-based bounds.
apply_mob_effect :: proc(self: ^Self, mob: uint, effect: ^serde_json::Value, level: u32) {
}
//         use horizon_client::enchant::level_value;
    // rust: let Some(m) = self.mobs.get_mut(mob) else {
    // rust: return;
}
    // rust: let ids: Vec<&str> = match &effect["to_apply"] {
    // rust: serde_json::Value::String(id) => vec![id.as_str()],
    // rust: serde_json::Value::Array(list) => list.iter().filter_map(|v| v.as_str()).collect(),
    // rust: _ => Vec::new(),
}
    // rust: if ids.is_empty() {
    // rust: return;
}
        // HolderSet.getRandomElement, then Mth.randomBetween for both values.
    // rust: let pick = m.random.next_int_bound(ids.len() as i32).unwrap_or(0) as usize;
    // rust: let mut between = |min: &str, max: &str| {
    // rust: let (lo, hi) = (
    // rust: level_value(&effect[min], level),
    // rust: level_value(&effect[max], level),
    // rust: );
    // rust: m.random.next_float() * (hi - lo) + lo
}
    // rust: let ticks = (between("min_duration", "max_duration") * 20.0).round() as i32;
    // rust: let amplifier = (between("min_amplifier", "max_amplifier").round() as i32).max(0);
    // rust: if let Some(id) = super::potions::mob_effect_id(ids[pick]) {
    // rust: let (new, entity) = (!m.has_effect(id), m.id as i32);
    // rust: m.add_effect(id, ticks, amplifier);
    // rust: self.mod_effect_added(id, Some(entity), amplifier, new);
}
}
    // `minecraft:post_attack` explode effects on the attacker (wind burst):
    // a burst at the player's feet that only knocks back and triggers
    // blocks (`ExplodeEffect` with `block_interaction: trigger`).
    // rust: pub(super) fn post_attack_bursts(&mut self, held: &ItemStack, victim: &str) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
        // EntityFlagsPredicate.isFlying: gliding or flying.
    // rust: let motion = (p.fall_distance, p.fall_flying || p.flying);
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: let ctx = EffectContext {
    // rust: this: Some(victim),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: items: Some(world_items!(self)),
    // rust: direct_motion: Some(motion),
    // rust: ..Default::default()
}
    // rust: let mut bursts = Vec::new();
    // rust: for (id, level) in held.enchantments() {
    // rust: let Some(def) = world_stations!(self).enchantments.get(id) else {
    // rust: continue;
}
    // rust: for effect in def.effects["minecraft:post_attack"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: let e = &effect["effect"];
    // rust: if effect["enchanted"] != "attacker"
    // rust: || effect["affected"] != "attacker"
    // rust: || e["type"] != "minecraft:explode"
    // rust: || e["block_interaction"] != "trigger"
    // rust: {
    // rust: continue;
}
    // rust: let ok = effect.get("requirements").is_none_or(|r| {
    // rust: world_stations!(self).enchantments.condition(
    // rust: r,
    // rust: *level,
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: )
    // rust: });
    // rust: if !ok {
    // rust: continue;
}
    // rust: let radius = horizon_client::enchant::level_value(&e["radius"], *level).max(0.0);
                // ExplosionDamageCalculator.getKnockbackMultiplier: 1 unless given.
    // rust: let knockback = if e["knockback_multiplier"].is_null() {
    // rust: 1.0
    // rust: } else {
    // rust: horizon_client::enchant::level_value(&e["knockback_multiplier"], *level)
}
    // rust: bursts.push((radius, knockback));
}
}
    // rust: for (radius, knockback) in bursts {
    // rust: let _ = self.wind_burst(feet, radius, knockback, false, false);
}
}
    // Thorns on worn armor when the mob `attacker` hits the player: the
    // `affected: attacker` effect of `Enchantment.doPostAttack` hurts the
    // entity that caused the hit.
    // rust: pub(super) fn thorns(&mut self, attacker: u32) {
    // rust: let Some(index) = self.mobs.iter().position(|m| m.id == attacker && m.alive()) else {
    // rust: return;
}
    // rust: for damage in self.thorns_damage() {
    // rust: let m = &mut self.mobs[index];
    // rust: m.hurt(damage, None, &mut self.world.random);
    // rust: let center = [m.position.x, m.position.y, m.position.z];
    // rust: self.audio
    // rust: .play("minecraft:enchant.thorns.hit", Some(center), 1.0, 1.0);
}
}
    // The victim's side of thorns: for each worn piece whose chance comes up,
    // the damage to deal the attacker (`DamageEntity` min 1, max 5) and the
    // piece's wear (`ChangeItemDamage` 2).
    // rust: pub(super) fn thorns_damage(&mut self) -> Vec<f32> {
    // rust: let mut hits = Vec::new();
    // rust: for slot in 0..4 {
    // rust: let Some(stack) = self.armor[slot].clone() else {
    // rust: continue;
}
    // rust: let level = stack.enchantment_level("minecraft:thorns");
    // rust: if level == 0 {
    // rust: continue;
}
    // rust: let Some(def) = self.stations().enchantments.get("minecraft:thorns") else {
    // rust: continue;
}
    // rust: let effect = def.effects["minecraft:post_attack"][0].clone();
    // rust: let ctx = EffectContext {
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let mut random = self.world.random.clone();
    // rust: let ok = self.stations().enchantments.condition(
    // rust: &effect["requirements"],
    // rust: level,
    // rust: &ctx,
    // rust: &mut random,
    // rust: );
    // rust: self.world.random = random;
    // rust: if !ok {
    // rust: continue;
}
    // rust: hits.push(1.0 + self.world.random.next_float() * 4.0);
            // ChangeItemDamage -> ItemStack.hurtAndBreak: unbreaking applies.
    // rust: let loss = self.wear(&stack, 2);
    // rust: if let Some(s) = self.armor[slot].as_mut() {
    // rust: s.damage += loss;
    // rust: if self
    // rust: .res
    // rust: .items()
    // rust: .get(&s.item)
    // rust: .is_some_and(|i| s.damage >= i.max_damage)
    // rust: {
    // rust: self.armor[slot] = None;
    // rust: self.player_equipment_broke(super::armor_slot(slot), &stack);
    // rust: self.apply_equipment();
}
}
}
    // rust: hits
}
    // `ExperienceOrb.repairPlayerItems`: returns the experience left over.
    // rust: pub(super) fn mending(&mut self, amount: u32) -> u32 {
    // rust: let mut amount = amount;
    // rust: loop {
            // EnchantmentHelper.getRandomItemWith(REPAIR_WITH_XP, damaged), in
            // EquipmentSlot order: the main hand, the off hand, then feet, legs,
            // chest and head (`armor` holds head first).
    // rust: let mending = |s: &Option<ItemStack>| {
    // rust: s.as_ref()
    // rust: .is_some_and(|s| s.damage > 0 && s.enchantment_level("minecraft:mending") > 0)
}
    // rust: let candidates: Vec<MendSlot> = [MendSlot::Main, MendSlot::Off]
    // rust: .into_iter()
    // rust: .chain((0..self.armor.len()).rev().map(MendSlot::Armor))
    // rust: .filter(|&slot| mending(self.mend_slot(slot)))
    // rust: .collect();
    // rust: if candidates.is_empty() {
    // rust: return amount;
}
    // rust: let slot = candidates[self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(candidates.len() as i32)
    // rust: .unwrap_or(0) as usize];
    // rust: let Some(stack) = self.mend_slot(slot).clone() else {
    // rust: return amount;
}
    // rust: let ctx = EffectContext {
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let mut to_repair_xp = world_stations!(self).enchantments.modify_value(
    // rust: Some(&stack),
    // rust: "minecraft:repair_with_xp",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: amount as f32,
    // rust: ) as u32;
    // rust: let vanilla_repair = to_repair_xp;
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: let player = self.native_acting_id();
    // rust: self.native_mending_repair(player, &stack, amount, &mut to_repair_xp);
}
            // A hook can re-enter experience granting or replace the slot. Only
            // repair the same eligible stack, using its current damage.
    // rust: let Some(current) = self.mend_slot_mut(slot).as_mut() else {
    // rust: return amount;
}
    // rust: let mut original = stack.clone();
    // rust: original.damage = current.damage;
    // rust: if *current != original
    // rust: || current.damage == 0
    // rust: || current.enchantment_level("minecraft:mending") == 0
    // rust: {
    // rust: return amount;
}
    // rust: if to_repair_xp == 0 {
                // Vanilla consumes the XP when its own repair effect returns zero.
    // rust: return if vanilla_repair == 0 { 0 } else { amount };
}
    // rust: let repaired = to_repair_xp.min(current.damage);
    // rust: if repaired == 0 {
    // rust: return amount;
}
    // rust: current.damage -= repaired;
    // rust: let item = current.item.to_string();
    // rust: let player = (self.serving.is_some() || self.options.dedicated.is_some())
    // rust: .then(|| self.native_acting_id());
    // rust: let remaining = amount.saturating_sub(
    // rust: (u64::from(repaired) * u64::from(amount) / u64::from(to_repair_xp)) as u32,
    // rust: );
    // rust: if let Some(player) = player
    // rust: && let Some(name) = self
    // rust: .native_server_players()
    // rust: .into_iter()
    // rust: .find(|p| p.uuid == player)
    // rust: .map(|p| p.name)
    // rust: {
    // rust: self.native_player_item_mend(player, &name, &item, repaired, amount);
}
    // rust: if remaining == 0 {
    // rust: return 0;
}
    // rust: amount = remaining;
}
}
mend_slot :: proc(self: ^Self, slot: MendSlot) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: MendSlot::Main => &self.inventory[self.selected],
    // rust: MendSlot::Off => &self.offhand,
    // rust: MendSlot::Armor(i) => &self.armor[i],
}
}
mend_slot_mut :: proc(self: ^Self, slot: MendSlot) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: MendSlot::Main => &mut self.inventory[self.selected],
    // rust: MendSlot::Off => &mut self.offhand,
    // rust: MendSlot::Armor(i) => &mut self.armor[i],
}
}
    // Bow enchantments at release: (extra base damage, infinity keeps the arrow).
    // `ammo` is the item being fired: `Enchantment.itemContext` hands it to the
    // `ammo_use` conditions as the tool, so Infinity only frees plain arrows.
    // rust: pub(super) fn bow_enchantments(&mut self, ammo: &str) -> (f64, bool) {
    // rust: let Some(bow) = self.held().cloned() else {
    // rust: return (0.0, false);
}
    // rust: let e = &world_stations!(self).enchantments;
    // rust: let ctx = EffectContext {
    // rust: direct_attacker: Some("minecraft:arrow"),
    // rust: attacker: Some("minecraft:player"),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let power = e.modify_value(
    // rust: Some(&bow),
    // rust: "minecraft:damage",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: 0.0,
    // rust: );
    // rust: let ammo_ctx = EffectContext {
    // rust: tool: Some(ammo),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let infinity = e.has_component(&bow, "minecraft:ammo_use")
    // rust: && e.modify_value(
    // rust: Some(&bow),
    // rust: "minecraft:ammo_use",
    // rust: &ammo_ctx,
    // rust: &mut self.world.random,
    // rust: 1.0,
    // rust: ) == 0.0;
    // rust: (f64::from(power), infinity)
}
    // `EnchantmentHelper.onProjectileSpawned`, which `AbstractArrow`'s
    // constructor runs for every arrow fired from a weapon, bow or crossbow:
    // the weapon's `projectile_spawned` ignite effects (Flame) spawn the arrow
    // burning.
    // rust: pub(super) fn ignite_spawned_arrow(&mut self, weapon: &ItemStack, arrow: &mut Projectile) {
    // rust: if let Some(seconds) = self.projectile_spawned_ignite(weapon)
    // rust: && let Some(a) = arrow.arrow.as_mut()
    // rust: {
    // rust: a.ignite_for_seconds(seconds);
}
}
    // The `projectile_spawned` ignite effects of `weapon` (Flame): the seconds
    // the new arrow burns for, the longest when several apply.
projectile_spawned_ignite :: proc(self: ^Self, weapon: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let ctx = EffectContext {
    // rust: this: Some("minecraft:arrow"),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let mut ignite: Option<f32> = None;
    // rust: for (id, level) in weapon.enchantments() {
    // rust: let Some(def) = world_stations!(self).enchantments.get(id) else {
    // rust: continue;
}
    // rust: for effect in def.effects["minecraft:projectile_spawned"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if effect["effect"]["type"] != "minecraft:ignite" {
    // rust: continue;
}
    // rust: let ok = effect.get("requirements").is_none_or(|r| {
    // rust: world_stations!(self).enchantments.condition(
    // rust: r,
    // rust: *level,
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: )
    // rust: });
    // rust: if ok {
    // rust: let seconds =
    // rust: horizon_client::enchant::level_value(&effect["effect"]["duration"], *level);
    // rust: ignite = Some(ignite.map_or(seconds, |s: f32| s.max(seconds)));
}
}
}
    // rust: ignite
}
    // Soul Speed (`data/minecraft/enchantment/soul_speed.json`), the parts of
    // `Enchantment.runLocationChangedEffects` and `tick` that file uses. The
    // `location_changed` effects run when the player enters a new block, lands,
    // or its boots change:
    // - the speed and movement efficiency modifiers turn on over a soul speed
    //   block (not flying, not riding) and stay on while airborne, then off
    //   (`enchantment_active_check`);
    // - the boots lose 1 durability with a 4% chance when on such a block.
    //
    // Every fifth tick the player walking on one also gets a soul particle
    // (returned as its position and velocity, for the caller to show or send
    // to the players around) and sometimes a sound. Runs for the window's own
    // player and for each guest on the server (`guest_server_tick`); a remote
    // client leaves it to its server.
    // rust: pub(super) fn tick_soul_speed(&mut self) -> Option<([f64; 3], [f64; 3])> {
ID :: "minecraft:soul_speed"
    // rust: let player = self.player.as_mut()?;
    // rust: if player.client_side {
    // rust: return None;
}
    // rust: let level = self.armor[3]
    // rust: .as_ref()
    // rust: .map_or(0, |s| s.enchantment_level(ID));
    // rust: let position = player.position;
    // rust: let (on_ground, flying) = (player.ground.on_ground, player.flying);
    // rust: let moved = position.subtract(player.old_position);
    // rust: let (tick, width) = (player.health.tick_count, player.dimensions.width);
    // rust: let fx = &mut player.location_effects;
    // rust: let on_soul = fx.on_soul_speed_block;
    // rust: let block = BlockPos::containing(position);
    // rust: let changed_block = fx.block.replace(block) != Some(block);
    // rust: let landed = std::mem::take(&mut fx.landed);
        // Changed boots: `stopLocationBasedEffects`, then the effects run again.
    // rust: let equipped = std::mem::replace(&mut fx.boots_level, level) != level;
    // rust: let was_active = fx.applied_level;
    // rust: let mut active = was_active > 0 && !equipped;
    // rust: let mut wear = false;
    // rust: if level > 0 && (changed_block || landed || equipped) {
    // rust: let riding = self.riding.is_some();
    // rust: let wanted = !riding && !flying && (on_soul || (active && !on_ground));
    // rust: active = wanted;
            // `random_chance` is the first term of the wear's `all_of`: it
            // draws from the level random before the block is looked at.
    // rust: let roll = self.world.random.next_float() < 0.04;
    // rust: wear = roll && on_ground && on_soul;
}
    // rust: fx.applied_level = if active { level } else { 0 };
        // `Entity.getKnownMovement` horizontal speed of at least 1.0E-5.
    // rust: let walking = moved.x * moved.x + moved.z * moved.z >= 1.0e-10;
    // rust: let tick_effects = level > 0 && !flying && on_ground && walking && on_soul && tick % 5 == 0;
        // The attribute effects were applied to the player before: swap them.
    // rust: if was_active > 0 && (!active || equipped) {
    // rust: for (attribute, id, _, op) in
    // rust: soul_speed_modifiers(&world_stations!(self).enchantments, was_active)
    // rust: {
    // rust: let _ = player.set_modifier(&attribute, &id, 0.0, &op, false);
}
}
    // rust: if active && (was_active == 0 || equipped) {
    // rust: for (attribute, id, amount, op) in
    // rust: soul_speed_modifiers(&world_stations!(self).enchantments, level)
    // rust: {
    // rust: let _ = player.set_modifier(&attribute, &id, amount, &op, true);
}
}
    // rust: if wear && !self.creative {
    // rust: self.wear_boots(1);
}
    // rust: if level == 0 {
    // rust: return None;
}
    // rust: let r = &mut self.world.random;
        // `spawn_particles`: in the bounding box, 0.1 above the feet, thrown
        // back against the movement (-0.2) and up (0.1).
    // rust: let particle = tick_effects.then(|| {
    // rust: let x = position.x + (r.next_double() - 0.5) * f64::from(width);
    // rust: let z = position.z + (r.next_double() - 0.5) * f64::from(width);
    // rust: (
    // rust: [x, position.y + 0.1, z],
    // rust: [moved.x * -0.2, 0.1, moved.z * -0.2],
    // rust: )
    // rust: });
        // `play_sound`: its `random_chance` (35%) comes first in its `all_of`,
        // so the level random is drawn every tick the boots are worn; volume
        // 0.6, pitch 0.6 to 1.0.
    // rust: if r.next_float() < 0.35 && tick_effects {
    // rust: let pitch = r.next_float() * 0.4 + 0.6;
    // rust: self.audio.play(
    // rust: "minecraft:particle.soul_escape",
    // rust: Some([position.x, position.y, position.z]),
    // rust: 0.6,
    // rust: pitch,
    // rust: );
}
    // rust: particle
}
    // `ItemStack.hurtAndBreak` on the worn boots (`change_item_damage`):
    // Unbreaking applies, and they break when worn out.
wear_boots :: proc(self: ^Self, amount: u32) {
}
    // rust: let Some(stack) = self.armor[3].clone() else {
    // rust: return;
}
    // rust: let loss = self.wear(&stack, amount);
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |info| info.max_damage);
    // rust: if max == 0 {
    // rust: return;
}
    // rust: let Some(boots) = self.armor[3].as_mut() else {
    // rust: return;
}
    // rust: boots.damage += loss;
    // rust: if boots.damage >= max {
    // rust: self.armor[3] = None;
            // LivingEntity.onEquippedItemBroken: the broken boots.
    // rust: self.player_equipment_broke(
    // rust: horizon_world::player_inventory::EquipmentSlot::Feet,
    // rust: &stack,
    // rust: );
    // rust: self.apply_equipment();
}
}
    // `EnchantmentHelper.runLocationChangedEffects` for the worn armor of the
    // player, run on the server once the player has moved: `LivingEntity.baseTick`
    // runs it when the block position changed, `checkFallDamage` when it lands.
    // `from` and `was_on_ground` are where and how the tick began.
    // rust: pub(super) fn location_changed_effects(&mut self, from: [f64; 3], was_on_ground: bool) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: let on_ground = p.ground.on_ground;
    // rust: let cell = |v: [f64; 3]| v.map(|c| c.floor() as i32);
    // rust: if cell(from) == cell(at) && !(on_ground && !was_on_ground) {
    // rust: return;
}
    // rust: let riding = self.riding.is_some();
    // rust: let disks = location_disks(
    // rust: &self.stations().enchantments,
    // rust: self.armor.iter().zip(["head", "chest", "legs", "feet"]),
    // rust: on_ground,
    // rust: riding,
    // rust: );
    // rust: for (effect, level) in disks {
    // rust: self.replace_disk(&effect, level, at, Who::Player);
}
}
    // `LivingEntity.onChangedBlock`, landing and `collectEquipmentChanges`
    // for an armor stand: run location effects before travel (including a
    // piston push), on landing, and for newly equipped items.
    // rust: pub(super) fn armor_stand_location_effects(&mut self, index: usize, landed: bool) {
    // rust: let stand = &mut self.armor_stands[index];
    // rust: let block = BlockPos::containing(stand.position);
    // rust: let moved = !landed && stand.enchantment_block.replace(block) != Some(block);
    // rust: let changed: [bool; 6] =
    // rust: std::array::from_fn(|i| stand.equipment[i] != stand.enchantment_equipment[i]);
    // rust: if !moved && !landed && !changed.iter().any(|c| *c) {
    // rust: return;
}
    // rust: let id = stand.id;
    // rust: let told: Vec<_> = (0..6)
    // rust: .filter(|&i| changed[i])
    // rust: .map(|i| {
    // rust: let slot = horizon_client::entities::ArmorStand::SLOTS[i];
    // rust: (
    // rust: slot,
    // rust: stand.enchantment_equipment[i].clone(),
    // rust: stand.equipment[i].clone(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: stand.enchantment_equipment.clone_from(&stand.equipment);
    // rust: if self.remote.is_none() && !self.options.execution_role.is_client() {
    // rust: for (slot, from, to) in told {
    // rust: self.native_living_equipment_change(
    // rust: id,
    // rust: "minecraft:armor_stand",
    // rust: slot,
    // rust: from.as_ref(),
    // rust: to.as_ref(),
    // rust: );
}
}
    // rust: let stand = &self.armor_stands[index];
    // rust: let at = [stand.position.x, stand.position.y, stand.position.z];
    // rust: let who = Who::Mob(stand.id);
    // rust: let equipment = stand
    // rust: .equipment
    // rust: .iter()
    // rust: .zip(horizon_client::entities::ArmorStand::SLOTS)
    // rust: .enumerate()
    // rust: .filter(|(i, _)| moved || landed || changed[*i])
    // rust: .filter(|(_, (stack, _))| {
    // rust: moved
    // rust: || landed
    // rust: || !stack.as_ref().is_some_and(|stack| {
    // rust: let data = stack.data();
    // rust: let component = |id| data.and_then(|data| data.other(id));
    // rust: let max_damage = match component("minecraft:max_damage") {
    // rust: Some(horizon_world::nbt::Tag::Int(value)) => *value as u32,
    // rust: _ => self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage),
}
    // rust: max_damage > 0
    // rust: && component("minecraft:unbreakable").is_none()
    // rust: && component("!minecraft:max_damage").is_none()
    // rust: && component("!minecraft:damage").is_none()
    // rust: && stack.damage >= max_damage
    // rust: })
    // rust: })
    // rust: .map(|(_, item)| item);
    // rust: let disks = location_disks(
    // rust: &self.stations().enchantments,
    // rust: equipment,
    // rust: stand.on_ground,
    // rust: stand.vehicle.is_some(),
    // rust: );
    // rust: for (effect, level) in disks {
    // rust: self.replace_disk(&effect, level, at, who);
}
}
    // `ReplaceDisk.apply`: the blocks of the disk around `at` that pass the
    // predicate become the effect's state, and each placement is a game event.
replace_disk :: proc(self: ^Self, effect: ^Value, level: u32, at: [f64; 3], who: Who) {
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let spec = &effect["block_state"];
    // rust: let Some(default) = spec["id"].as_str().and_then(|n| registry.default_state(n)) else {
    // rust: return;
}
    // rust: let Some(mut state) = registry.state(default).cloned() else {
    // rust: return;
}
    // rust: for (k, v) in spec["properties"].as_object().into_iter().flatten() {
    // rust: state
    // rust: .properties
    // rust: .insert(k.clone(), v.as_str().unwrap_or("").to_owned());
}
    // rust: let new = registry.resolve(&state).unwrap_or(default);
    // rust: let radius = level_value(&effect["radius"], level) as i32;
    // rust: let height = level_value(&effect["height"], level) as i32;
    // rust: let offset = cell_offset(effect);
    // rust: let center = [0, 1, 2].map(|i| at[i].floor() as i32 + offset[i]);
    // rust: let event = effect["trigger_game_event"].as_str() == Some("minecraft:block_place");
    // rust: for dy in (height - 1).min(0)..=0 {
    // rust: for dz in -radius..=radius {
    // rust: for dx in -radius..=radius {
    // rust: let pos = [center[0] + dx, center[1] + dy, center[2] + dz];
    // rust: let (x, z) = (
    // rust: f64::from(pos[0]) + 0.5 - at[0],
    // rust: f64::from(pos[2]) + 0.5 - at[2],
    // rust: );
    // rust: if x * x + z * z >= f64::from(radius * radius)
    // rust: || !self.disk_predicate(&effect["predicate"], pos, new)
    // rust: || self.level_set(pos, new).is_err()
    // rust: {
    // rust: continue;
}
    // rust: if event {
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_place",
    // rust: pos,
    // rust: Some(who),
    // rust: Some(new),
    // rust: );
}
}
}
}
}
    // The `BlockPredicate` subset the disk effect uses, tested at `pos`; no
    // predicate matches everything.
disk_predicate :: proc(self: ^Self, p: ^Value, pos: [i32; 3], placed: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if p.is_null() {
    // rust: return true;
}
    // rust: let offset = cell_offset(p);
    // rust: let at = [0, 1, 2].map(|i| pos[i] + offset[i]);
    // rust: let state = self.world.block(at[0], at[1], at[2]);
    // rust: let b = self.res.behaviours();
    // rust: let names = |v: &Value| -> Vec<String> {
    // rust: match v {
    // rust: Value::String(s) => vec![s.clone()],
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|n| n.as_str().map(String::from))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
    // rust: match p["type"].as_str().unwrap_or("") {
    // rust: "minecraft:all_of" => p["predicates"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|q| self.disk_predicate(q, pos, placed)),
            // `MatchingBlockTagPredicate`
    // rust: "minecraft:matching_block_tag" => b
    // rust: .tag(p["tag"].as_str().unwrap_or("").trim_start_matches('#'))
    // rust: .is_some_and(|t| t.contains(b.block(state))),
            // `MatchingBlocksPredicate`
    // rust: "minecraft:matching_blocks" => {
    // rust: names(&p["blocks"]).iter().any(|n| n == b.table.name(state))
}
            // `MatchingFluidsPredicate`: Fluids.WATER is the source.
    // rust: "minecraft:matching_fluids" => {
    // rust: let fluid = b.fluid(state);
    // rust: names(&p["fluids"]).iter().any(|n| match n.as_str() {
    // rust: "minecraft:water" => fluid.kind() == FluidKind::Water && fluid.is_source(),
    // rust: "minecraft:flowing_water" => {
    // rust: fluid.kind() == FluidKind::Water && !fluid.is_source()
}
    // rust: _ => false,
    // rust: })
}
            // `UnobstructedPredicate`: no building-blocking entity in the block.
    // rust: "minecraft:unobstructed" => self.with_level(|_, level, _| {
    // rust: level.is_unobstructed(BlockPos::new(pos[0], pos[1], pos[2]), placed)
    // rust: }),
    // rust: _ => false,
}
}
    // Whether a worn enchantment gives immunity to `#burn_from_stepping`
    // damage (frost walker's `minecraft:damage_immunity`).
    // rust: pub(crate) fn wears_burn_from_stepping_immunity(&self) -> bool {
    // rust: self.armor
    // rust: .iter()
    // rust: .zip(["head", "chest", "legs", "feet"])
    // rust: .any(|(stack, slot)| {
    // rust: stack
    // rust: .iter()
    // rust: .flat_map(ItemStack::enchantments)
    // rust: .any(|(id, _)| {
    // rust: self.stations().enchantments.get(id).is_some_and(|def| {
    // rust: def.effects.get("minecraft:damage_immunity").is_some()
    // rust: && def
    // rust: .slots
    // rust: .iter()
    // rust: .any(|s| s == slot || s == "armor" || s == "any")
    // rust: })
    // rust: })
    // rust: })
}
    // Enchantment attribute modifiers of active equipment, including held Efficiency.
    // Each piece's modifier id ends with its slot (`EnchantmentAttributeEffect.idForSlot`),
    // so the same enchantment on two pieces stacks instead of replacing itself.
    // rust: pub(super) fn apply_enchantment_attributes(&mut self) {
    // rust: let mut wanted: Vec<(String, String, f64, String)> = Vec::new();
    // rust: for (stack, slot) in self
    // rust: .armor
    // rust: .iter()
    // rust: .zip(["head", "chest", "legs", "feet"])
    // rust: .chain([
    // rust: (&self.inventory[self.selected], "mainhand"),
    // rust: (&self.offhand, "offhand"),
    // rust: ])
    // rust: {
    // rust: let Some(stack) = stack else { continue };
    // rust: for (attr, id, amount, op, group) in self.stations().enchantments.modifier_rows(stack) {
    // rust: if super::equipment_modifier_applies(&group, slot) {
    // rust: wanted.push((attr, format!("{id}/{slot}"), amount, op));
}
}
}
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: return;
}
    // rust: for (attr, id, _, op) in std::mem::take(&mut self.potions.enchant_modifiers) {
    // rust: let _ = p.set_modifier_unclamped(&attr, &id, 0.0, &op, false);
}
    // rust: for (attr, id, amount, op) in &wanted {
    // rust: let _ = p.set_modifier_unclamped(attr, id, *amount, op, true);
}
    // rust: let _ = p.clamp_health_to_max();
    // rust: self.potions.enchant_modifiers = wanted;
}
}

// `EnchantmentHelper.runLocationChangedEffects`: the replace-disk effects of
// active equipment slots, with the wearer's ground/passenger requirements.
    // rust: fn location_disks<'a>(
    // rust: enchantments: &Enchantments,
    // rust: equipment: impl IntoIterator<Item = (&'a Option<ItemStack>, &'static str)>,
    // rust: on_ground: bool,
    // rust: riding: bool,
    // rust: ) -> Vec<(Value, u32)> {
    // rust: let mut disks = Vec::new();
    // rust: for (stack, slot) in equipment {
    // rust: let Some(stack) = stack else { continue };
    // rust: for (id, level) in stack.enchantments() {
    // rust: let Some(def) = enchantments.get(id) else {
    // rust: continue;
}
    // rust: let armor = matches!(slot, "head" | "chest" | "legs" | "feet");
    // rust: let hand = matches!(slot, "mainhand" | "offhand");
    // rust: if !def.slots.iter().any(|s| {
    // rust: s == slot || s == "any" || (s == "armor" && armor) || (s == "hand" && hand)
    // rust: }) {
    // rust: continue;
}
    // rust: for effect in def.effects["minecraft:location_changed"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if effect["effect"]["type"] == "minecraft:replace_disk"
    // rust: && location_requirements(&effect["requirements"], on_ground, riding)
    // rust: {
    // rust: disks.push((effect["effect"].clone(), *level));
}
}
}
}
    // rust: disks
}

// Soul Speed's `attribute` effects at `level` (attribute, id, amount, operation),
// the id taking the boots slot like `EnchantmentAttributeEffect.idForSlot`.
    // rust: fn soul_speed_modifiers(
    // rust: enchantments: &Enchantments,
    // rust: level: u32,
    // rust: ) -> Vec<(String, String, f64, String)> {
    // rust: let Some(e) = enchantments.get("minecraft:soul_speed") else {
    // rust: return Vec::new();
}
    // rust: e.effects["minecraft:location_changed"][0]["effect"]["effects"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|a| a["type"] == "minecraft:attribute")
    // rust: .map(|a| {
    // rust: (
    // rust: a["attribute"].as_str().unwrap_or("").to_owned(),
    // rust: format!("{}/feet", a["id"].as_str().unwrap_or("")),
    // rust: f64::from(level_value(&a["amount"], level)),
    // rust: a["operation"].as_str().unwrap_or("add_value").to_owned(),
    // rust: )
    // rust: })
    // rust: .collect()
}

// An effect's or predicate's `offset` vector (zero when absent).
cell_offset :: proc(v: ^Value) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let at = |i: usize| {
    // rust: v["offset"]
    // rust: .get(i)
    // rust: .and_then(Value::as_i64)
    // rust: .map_or(0, |n| n as i32)
}
    // rust: [at(0), at(1), at(2)]
}
// The loot-condition subset a `location_changed` effect requires of the
// wearer: standing on the ground and not riding (frost walker).
location_requirements :: proc(req: ^Value, on_ground: bool, riding: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match req["type"].as_str().unwrap_or("") {
    // rust: "" if req.is_null() => true,
    // rust: "minecraft:all_of" => req["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|t| location_requirements(t, on_ground, riding)),
    // rust: "minecraft:inverted" => !location_requirements(&req["term"], on_ground, riding),
    // rust: "minecraft:entity_properties" => {
    // rust: let p = &req["predicate"];
    // rust: p["minecraft:flags"]["is_on_ground"]
    // rust: .as_bool()
    // rust: .is_none_or(|v| v == on_ground)
    // rust: && (p["minecraft:vehicle"].is_null() || riding)
}
    // rust: _ => false,
}
}

    // rust: mod tests {
//     use super::block_break_speed_factor;

    // #4094: `BLOCK_BREAK_SPEED` is a multiplier on the destroy speed.
block_break_speed_is_a_destroy_speed_multiplier :: proc() {
}
    // rust: assert_eq!(block_break_speed_factor(None), 1.0);
    // rust: assert_eq!(block_break_speed_factor(Some(1.0)), 1.0);
    // rust: assert_eq!(block_break_speed_factor(Some(0.5)), 0.5);
    // rust: assert_eq!(block_break_speed_factor(Some(2.0)), 2.0);
    // rust: assert_eq!(8.0 * block_break_speed_factor(Some(0.5)), 4.0);
    // rust: assert_eq!(8.0 * block_break_speed_factor(Some(2.0)), 16.0);
}
}
