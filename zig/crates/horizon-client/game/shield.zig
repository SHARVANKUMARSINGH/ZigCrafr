//! Transpiled from Horizon Rust crate
//! Module: horizon-client_shield
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shields and other `blocks_attacks` items: raising them (`ShieldItem.use`,
//! from either hand), `LivingEntity.getItemBlockingWith` and
//! `applyItemBlocking` inputs, and what follows a block: item damage,
//! the block sound, attacker knockback (`blockedByItem`) and axes disabling
//! the shield (`Player.blockUsingItem`, `BlocksAttacks.disable`).
// use super::Game;
// use horizon_client::{
    // rust: health::{BlockOutcome, Blocking, HurtSource},
    // rust: items::ItemStack,
}
// use horizon_core::random::RandomSource;
// use horizon_world::blocking_rules::{BlockingRules, DamageReduction, ItemDamageFunction};

/// `Inventory.SLOT_OFFHAND`: the `using` slot of an off-hand item.
    // rust: pub(super) const OFFHAND_SLOT: usize = 40;

    // rust: impl Game<'_> {
    /// The stack in an inventory slot, the off hand at `OFFHAND_SLOT`.
    // rust: pub(super) fn stack_in(&self, slot: usize) -> Option<&ItemStack> {
    // rust: if slot == OFFHAND_SLOT {
    // rust: self.offhand.as_ref()
    // rust: } else {
    // rust: self.inventory.get(slot)?.as_ref()
}
}
    // rust: pub(super) fn stack_in_mut(&mut self, slot: usize) -> &mut Option<ItemStack> {
    // rust: if slot == OFFHAND_SLOT {
    // rust: &mut self.offhand
    // rust: } else {
    // rust: &mut self.inventory[slot]
}
}
    /// The stack's `blocks_attacks`: its own component, else its item's.
    // rust: pub(super) fn blocks_attacks(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: ) -> Option<std::borrow::Cow<'_, horizon_client::items::BlocksAttacks>> {
    // rust: horizon_client::items::BlocksAttacks::of_stack(stack, self.items().get(&stack.item))
}
    /// `ShieldItem.use` (ItemUtils.startUsingInstantly) for the hand at `slot`;
    /// false when that hand holds no blocking item or it is on cooldown.
    // rust: pub(super) fn raise_shield(&mut self, slot: usize) -> bool {
    // rust: let Some(stack) = self.stack_in(slot) else {
    // rust: return false;
}
    // rust: if self.blocks_attacks(stack).is_none() {
    // rust: return false;
}
    // rust: if self.shield_cooldown == 0 {
    // rust: self.start_using_item();
}
    // rust: true
}
    /// `LivingEntity.getItemBlockingWith` and the inputs of `applyItemBlocking`
    /// for an attack from `from` (`DamageSource.getSourcePosition`).
    // rust: pub(super) fn player_blocking(
    // rust: &self,
    // rust: from: Option<[f64; 3]>,
    // rust: damage_type: &str,
    // rust: pierce: bool,
    // rust: ) -> Option<Blocking> {
    // rust: let (slot, ticks) = self.using?;
    // rust: let component = self.blocks_attacks(self.stack_in(slot)?)?;
        // BlocksAttacks.blockDelayTicks: Math.round(seconds * 20).
    // rust: if (ticks as i32) < (component.delay_seconds * 20.0).round() as i32 {
    // rust: return None;
}
    // rust: let tags = &self.stations().enchantments.damage_tags;
    // rust: let matches = |spec: &str| match spec.strip_prefix('#') {
    // rust: Some(tag) => tags.get(tag).is_some_and(|t| t.contains(damage_type)),
    // rust: None => spec == damage_type,
}
    // rust: let p = self.player.as_ref()?;
    // rust: let angle = match from {
    // rust: Some(src) => {
                // calculateViewVector(0, yHeadRot) against the flattened direction.
    // rust: let yaw = (-self.yaw).to_radians();
    // rust: let view = [yaw.sin() as f64, yaw.cos() as f64];
    // rust: let (dx, dz) = (src[0] - p.position.x, src[2] - p.position.z);
    // rust: let len = (dx * dx + dz * dz).sqrt();
    // rust: let to = if len < 1.0e-4 {
    // rust: [0.0, 0.0]
    // rust: } else {
    // rust: [dx / len, dz / len]
}
    // rust: (to[0] * view[0] + to[1] * view[1]).acos()
}
    // rust: None => f64::from(std::f32::consts::PI),
}
    // rust: let (threshold, base, factor) = component.item_damage;
    // rust: Some(Blocking {
    // rust: rules: BlockingRules {
    // rust: delay_seconds: component.delay_seconds,
    // rust: disable_scale: component.disable_scale,
    // rust: reductions: component
    // rust: .reductions
    // rust: .iter()
    // rust: .map(|r| DamageReduction {
    // rust: horizontal_angle: r.horizontal_angle,
    // rust: types: r.types.as_ref().map(|t| t.iter().any(|s| matches(s))),
    // rust: base: r.base,
    // rust: factor: r.factor,
    // rust: })
    // rust: .collect(),
    // rust: item_damage: ItemDamageFunction {
    // rust: threshold,
    // rust: base,
    // rust: factor,
    // rust: },
    // rust: },
    // rust: bypassed: component.bypassed_by.as_deref().is_some_and(matches),
    // rust: pierce,
    // rust: angle,
    // rust: })
}
    /// After a hurt with the shield raised: `hurtBlockingItem`, `onBlocked`
    /// and, for melee from a mob, `blockUsingItem`. `source` is the hit's.
    // rust: pub(super) fn after_block(
    // rust: &mut self,
    // rust: outcome: BlockOutcome,
    // rust: (attacker, projectile): (Option<u32>, bool),
    // rust: source: HurtSource<'_>,
    // rust: ) {
    // rust: let Some((slot, _)) = self.using else { return };
    // rust: let Some(stack) = self.stack_in(slot).cloned() else {
    // rust: return;
}
    // rust: let Some(component) = self
    // rust: .blocks_attacks(&stack)
    // rust: .map(std::borrow::Cow::into_owned)
    // rust: else {
    // rust: return;
}
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: if outcome.sound
    // rust: && let Some(sound) = &component.block_sound
    // rust: {
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.4;
    // rust: self.audio.play(sound, at, 1.0, pitch);
}
    // rust: if outcome.blocked <= 0.0 {
    // rust: return;
}
        // ItemDamageFunction.apply, then hurtAndBreak.
    // rust: let (threshold, base, factor) = component.item_damage;
    // rust: let item_damage = if outcome.blocked < threshold {
    // rust: 0
    // rust: } else {
    // rust: (base + factor * outcome.blocked).floor() as i32
}
    // rust: if item_damage > 0 && !self.creative {
    // rust: let loss = self.wear(&stack, item_damage as u32);
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage);
    // rust: let cell = self.stack_in_mut(slot);
    // rust: if let Some(s) = cell.as_mut()
    // rust: && max > 0
    // rust: {
    // rust: s.damage += loss;
    // rust: if s.damage >= max {
    // rust: let broken = s.clone();
    // rust: *cell = None;
    // rust: self.using = None;
                    // ItemStack.hurtAndBreak: onEquippedItemBroken for the hand it was used from.
    // rust: let hand = if slot == OFFHAND_SLOT {
    // rust: horizon_world::player_inventory::EquipmentSlot::OffHand
    // rust: } else {
    // rust: horizon_world::player_inventory::EquipmentSlot::MainHand
}
    // rust: self.player_equipment_broke(hand, &broken);
    // rust: return;
}
}
}
    // rust: if projectile {
    // rust: return;
}
    // rust: let Some(id) = attacker else {
            // Another player's melee hit has no mob behind it.
    // rust: if let Some((from, disable)) = self.combat.player_attacker {
    // rust: let fully = outcome.fully_blocked;
    // rust: let attacker = ([from[0], from[2]], disable);
    // rust: self.blocked_by_attacker(&component, attacker, fully, at, source);
}
    // rust: return;
}
    // rust: let fully = outcome.fully_blocked;
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let (mx, mz) = (m.position.x, m.position.z);
        // LivingEntity.getSecondsToDisableBlocking: the held weapon's value;
        // Warden overrides it with a flat 5 seconds.
    // rust: let disable = if m.species() == horizon_client::mobs::Species::Warden {
    // rust: 5.0
    // rust: } else {
    // rust: m.extra
    // rust: .main_hand
    // rust: .as_deref()
    // rust: .and_then(|item| self.items().get(item))
    // rust: .map_or(0.0, |i| i.disable_blocking_seconds)
}
        // Ravager.blockedByItem: stunned half the time (the defender pushed
        // apart), else the defender flung away; no roar in progress.
    // rust: if m.species() == horizon_client::mobs::Species::Ravager {
    // rust: let mut events = Vec::new();
    // rust: let roaring = m.extra.anim_ticks != 0;
    // rust: let stunned = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id)
    // rust: .is_some_and(|m| horizon_client::mobs::ravager::blocked(m, &mut events));
    // rust: if !roaring && let Some(p) = self.player.as_mut() {
    // rust: let (xd, zd) = (p.position.x - mx, p.position.z - mz);
    // rust: let push = if stunned {
                    // Entity.push(entity): apart by 0.05 per block of overlap.
    // rust: let d = (xd * xd + zd * zd).sqrt().max(0.01);
    // rust: let k = (1.0 / d).min(1.0) * 0.05;
    // rust: horizon_core::geometry::Vec3::new(xd / d * k, 0.0, zd / d * k)
    // rust: } else {
    // rust: let dd = (xd * xd + zd * zd).max(0.001);
    // rust: horizon_core::geometry::Vec3::new(xd / dd * 4.0, 0.2, zd / dd * 4.0)
}
    // rust: p.velocity = p.velocity.add_vector(push);
}
    // rust: let _ = self.handle_mob_events(events);
    // rust: return;
}
    // rust: self.blocked_by_attacker(&component, ([mx, mz], disable), fully, at, source);
}

    /// What a blocked melee hit does to the defender once the shield took
    /// it: `LivingEntity.blockedByItem` knocks them back unless fully
    /// blocked, then `Player.blockUsingItem` disables the shield. `attacker`
    /// is where the attacker stands (x, z) and its seconds of disabling.
    // rust: fn blocked_by_attacker(
    // rust: &mut self,
    // rust: component: &horizon_client::items::BlocksAttacks,
    // rust: ([mx, mz], disable): ([f64; 2], f32),
    // rust: fully: bool,
    // rust: at: Option<[f64; 3]>,
    // rust: source: HurtSource<'_>,
    // rust: ) {
        // LivingEntity.blockedByItem: defender.knockback(0.5, defender - attacker,
        // source), which moves the defender along -(xd, zd).
    // rust: if !fully && let Some(p) = self.player.as_ref() {
    // rust: let (xd, zd) = (p.position.x - mx, p.position.z - mz);
    // rust: self.knock_back_player(0.5, xd, zd, source);
}
        // BlocksAttacks.disable: item cooldown and stopUsingItem.
    // rust: let ticks = disable * component.disable_scale;
    // rust: let ticks = if ticks > 0.0 {
    // rust: (ticks * 20.0).round() as u32
    // rust: } else {
    // rust: 0
}
    // rust: if ticks > 0 {
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_shield_disable(player, &name, ticks);
}
    // rust: let item = self
    // rust: .using
    // rust: .and_then(|(slot, _)| self.stack_in(slot))
    // rust: .map(|stack| stack.item.clone());
    // rust: let mut cancel = false;
    // rust: if let (Some(player), Some(name), Some(item)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone(), item)
    // rust: {
    // rust: self.native_player_item_cooldown(player, &name, &item, ticks as i32, &mut cancel);
}
    // rust: if !cancel {
    // rust: self.shield_cooldown = ticks;
}
    // rust: self.using = None;
    // rust: if let Some(sound) = &component.disabled_sound {
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.4;
    // rust: self.audio.play(sound, at, 0.8, pitch);
}
}
}
}
