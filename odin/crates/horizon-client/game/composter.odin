//! Transpiled from Horizon Rust crate
package horizon_client_composter

import "core:fmt"
import "core:mem"
import "core:math"

// `ComposterBlock`: compostable items go in by hand (`useItemOn`) or
// through its input container (hoppers, droppers, crafters above), and the
// fill feedback of level event 1500 (`handleFill`). Emptying a full
// composter by hand is `useWithoutItem` in horizon-world.
// use super::{Game, commands::compute::ComputeContext};
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::villager,
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{position::BlockPos, random::RandomSource};

    // rust: impl Game<'_> {
    // The composter's `level` at `pos`, None when it isn't a composter.
    // rust: pub(super) fn composter_level(&self, pos: [i32; 3]) -> Option<i32> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let s = self.pack.assets.registry.state(state)?;
    // rust: if &*s.name != "minecraft:composter" {
    // rust: return None;
}
    // rust: s.properties.get("level")?.parse().ok()
}
    // The item's `compostable` layers provider.
compostable :: proc(self: ^Self, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.items().get(&stack.item)?.compostable.clone()
}
    // `ComposterBlock.addLayer` and level event 1500: the provider is
    // evaluated in the composter's block-interaction loot context (its
    // state; the level random), then the layer is added. True when it was.
composter_add :: proc(self: ^Self, pos: [i32; 3], layers: ^serde_json::Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let context = ComputeContext {
    // rust: block: Some(pos),
    // rust: target: None,
}
    // rust: let layers = self.provider_int(layers, &context, 0).unwrap_or(0);
    // rust: let before = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let after = self.with_level(|b, level, ticks| b.composter_insert(level, ticks, at, layers));
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
        // The game event and level event 1500 happen here, before the caller goes on.
    // rust: let _ = self.process_level_events();
    // rust: after != before
}
    // `ComposterBlock.useItemOn` with the main-hand stack: true when it
    // consumed the action (SUCCESS; a full composter falls through to
    // `useWithoutItem`, which empties it).
    // rust: pub(super) fn use_composter(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: let Some(level) = self.composter_level(pos) else {
    // rust: return false;
}
    // rust: let Some(stack) = held else {
    // rust: return false;
}
    // rust: let Some(layers) = self.compostable(stack) else {
    // rust: return false;
}
    // rust: if level >= 8 {
    // rust: return false;
}
    // rust: if level < 7 {
    // rust: self.composter_add(pos, &layers);
    // rust: self.native_compost_item(pos, &stack.item);
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.consume_held();
}
        // ServerPlayerGameMode.useItemOn: the action was consumed.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, stack);
    // rust: true
}
    // `ComposterBlock.useItemOn` on a client's level: whether `held` is
    // compostable and the composter at `pos` below level 8 (SUCCESS).
    // rust: pub(super) fn composter_takes(&self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: self.composter_level(pos).is_some_and(|level| level < 8)
    // rust: && held.is_some_and(|stack| {
    // rust: self.res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.compostable.is_some())
    // rust: })
}
    // `HopperBlockEntity.addItem` into the composter's `InputContainer`
    // (levels 0 to 6; one item, compostable, from above): the remainder.
    // rust: pub(super) fn composter_container_insert(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: mut stack: ItemStack,
    // rust: from_above: bool,
    // rust: ) -> Option<ItemStack> {
    // rust: let Some(level) = self.composter_level(pos) else {
    // rust: return Some(stack);
}
    // rust: if !from_above || level >= 7 {
    // rust: return Some(stack);
}
    // rust: let Some(layers) = self.compostable(&stack) else {
    // rust: return Some(stack);
}
        // InputContainer.getMaxStackSize is 1: one item goes in, and its
        // setChanged composts it at once.
    // rust: stack.count -= 1;
    // rust: self.composter_add(pos, &layers);
    // rust: (stack.count > 0).then_some(stack)
}
    // `WorkAtComposter.compostItems` for the villager at `mob`: a full
    // composter is emptied, then up to 20 wheat or beetroot seeds go in
    // (keeping 10 of each kind) until the composter reaches level 7. Level
    // event 1500 plays once, at the end.
    // rust: pub(super) fn villager_compost_items(&mut self, mob: usize, pos: [i32; 3]) {
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let Some(mut before) = self.composter_level(pos) else {
    // rust: return;
}
    // rust: if before == 8 {
    // rust: self.with_level(|b, level, ticks| b.composter_extract(level, ticks, at));
    // rust: let _ = self.process_level_events();
    // rust: before = 0;
}
    // rust: let mut remaining = 20;
    // rust: let mut amounts: Vec<(std::sync::Arc<str>, i32)> = Vec::new();
    // rust: let slots = villager::ext(&self.mobs[mob]).map_or(0, |e| e.inventory.len());
    // rust: 'slots: for slot in (0..slots).rev() {
    // rust: if remaining <= 0 {
    // rust: break;
}
    // rust: let stack = villager::ext_mut(&mut self.mobs[mob]).inventory[slot].clone();
    // rust: if !matches!(
    // rust: &*stack.item,
    // rust: "minecraft:wheat_seeds" | "minecraft:beetroot_seeds"
    // rust: ) {
    // rust: continue;
}
    // rust: let known = amounts.iter().position(|(item, _)| *item == stack.item);
    // rust: let total = known.map_or(0, |k| amounts[k].1) + stack.count as i32;
    // rust: match known {
    // rust: Some(k) => amounts[k].1 = total,
    // rust: None => amounts.push((stack.item.clone(), total)),
}
    // rust: let uses = (total - 10).min(remaining).min(stack.count as i32);
    // rust: if uses <= 0 {
    // rust: continue;
}
    // rust: remaining -= uses;
    // rust: for _ in 0..uses {
    // rust: self.villager_insert_item(mob, slot, &stack, pos);
    // rust: if self.composter_level(pos) == Some(7) {
    // rust: break 'slots;
}
}
}
    // rust: let after = self.composter_level(pos).unwrap_or(before);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.composter_fill_effects(level, ticks, at, after != before)
    // rust: });
    // rust: let _ = self.process_level_events();
}
    // `ComposterBlock.insertItem` with a villager's stack: below level 7 a
    // compostable item is used up and may add a layer.
villager_insert_item :: proc(self: ^Self, mob: uint, slot: uint, stack: ^ItemStack, pos: [i32; 3]) {
}
    // rust: if self.composter_level(pos).is_none_or(|level| level >= 7) {
    // rust: return;
}
    // rust: let Some(layers) = self.compostable(stack) else {
    // rust: return;
}
    // rust: let context = ComputeContext {
    // rust: block: Some(pos),
    // rust: target: None,
}
    // rust: let layers = self.provider_int(&layers, &context, 0).unwrap_or(0);
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.composter_layer(level, ticks, at, layers));
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: let _ = self.process_level_events();
    // rust: let inventory = &mut villager::ext_mut(&mut self.mobs[mob]).inventory;
    // rust: inventory[slot].count -= 1;
    // rust: if inventory[slot].count == 0 {
    // rust: inventory.remove(slot);
}
}
    // `ComposterBlock.handleFill` (level event 1500) on the client: the
    // fill sound and ten composter particles above the compost.
    // rust: pub(super) fn composter_fill_event(&mut self, pos: BlockPos, success: bool) {
    // rust: let center = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: let sound = if success {
    // rust: "minecraft:block.composter.fill_success"
    // rust: } else {
    // rust: "minecraft:block.composter.fill"
}
        // `handleFill` is `playLocalSound`: the client that receives event 1500
        // plays it. Capturing it here would also send a sound packet.
    // rust: self.audio.play_unshared(sound, Some(center), 1.0, 1.0);
        // getShape(..).max(Y, 0.5, 0.5): the compost surface (SHAPES[8] = SHAPES[7]).
    // rust: let level = self.composter_level([pos.x, pos.y, pos.z]).unwrap_or(0);
    // rust: let height = f64::from((1 + level.min(7) * 2).clamp(2, 16)) / 16.0 + 0.03125;
    // rust: let options = ParticleOptions::simple(ParticleType::Composter);
    // rust: for _ in 0..10 {
    // rust: let r = self.particles.random();
    // rust: let v = [
    // rust: r.next_gaussian() * 0.02,
    // rust: r.next_gaussian() * 0.02,
    // rust: r.next_gaussian() * 0.02,
    // rust: ];
    // rust: let p = [
    // rust: f64::from(pos.x) + 0.1875 + 0.625 * f64::from(r.next_float()),
    // rust: f64::from(pos.y) + height + f64::from(r.next_float()) * (1.0 - height),
    // rust: f64::from(pos.z) + 0.1875 + 0.625 * f64::from(r.next_float()),
    // rust: ];
    // rust: self.particles.add(&options, p, v);
}
}
}
