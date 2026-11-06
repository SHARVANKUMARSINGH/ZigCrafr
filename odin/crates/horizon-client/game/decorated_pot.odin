//! Transpiled from Horizon Rust crate
package horizon_client_decorated_pot

import "core:fmt"
import "core:mem"
import "core:math"

// Decorated pots, which Horizon keeps as loaded (the chunk's saved block
// entities): the loot table a trial chamber pot holds, rolled into its item
// the first time the item is read (`RandomizableContainer.unpackLootTable`),
// and `DecoratedPotBlock.useItemOn` / `useWithoutItem`.
// use super::{Game, spill};
// use horizon_client::{
    // rust: first_person::Hand,
    // rust: items::ItemStack,
    // rust: mobs::Who,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: random_sequences::RandomSequences,
    // rust: save,
}
// use horizon_core::random::LegacyRandom;
// use horizon_world::{loot::LootData, nbt::Tag};

// `DecoratedPotBlockEntity.WobbleStyle` ordinals.
WOBBLE_POSITIVE :: 0
WOBBLE_NEGATIVE :: 1

// `RandomizableContainer.unpackLootTable(null)` on a pot's saved tag: the
// loot table, if any, is removed and `LootTable.fill` puts its roll in
// `item`. The roll draws from `LootTableSeed`, else the table's random
// sequence, else the level random (`LootContext.Builder.create`).
    // rust: pub(super) fn unpack_loot(
    // rust: tag: &mut Tag,
    // rust: loot: Option<&LootData>,
    // rust: random: &mut LegacyRandom,
    // rust: sequences: &mut RandomSequences,
    // rust: world_seed: i64,
    // rust: ) {
    // rust: let Tag::Compound(map) = tag else {
    // rust: return;
}
    // rust: let Some(Tag::String(table)) = map.remove(&"LootTable".into()) else {
    // rust: return;
}
    // rust: let seed = match map.remove(&"LootTableSeed".into()) {
    // rust: Some(Tag::Long(seed)) => seed,
    // rust: _ => 0,
}
    // rust: map.remove(&"item".into());
    // rust: let Some(loot) = loot else {
    // rust: return;
}
    // rust: let table = table.to_string_lossy();
    // No origin biome: the pot tables have no location checks.
    // rust: let slots = if seed != 0 {
    // rust: loot.fill(&table, seed, 1, None)
    // rust: } else if let Some(sequence) = loot.random_sequence(&table) {
    // rust: loot.fill_with(&table, sequences.get(sequence, world_seed), 1, None)
    // rust: } else {
    // rust: loot.fill_with(&table, random, 1, None)
}
    // rust: if let Some(stack) = slots.into_iter().next().flatten() {
    // rust: let item = horizon_client::structure_blocks::loot_item_with_components(&stack);
    // rust: map.insert("item".into(), save::item_to_nbt(&item));
}
}

    // rust: impl Game<'_> {
    // `DecoratedPotBlockEntity.saveAdditional` for commands: a pure view of
    // the existing saved state. Unlike pot_tag, this never unpacks loot.
    // rust: pub(super) fn pot_data(&self, pos: [i32; 3]) -> Option<Tag> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if &*self.res.facts().get(state).name != "minecraft:decorated_pot" {
    // rust: return None;
}
    // rust: let mut tag = spill::saved_entity(&self.world, pos).unwrap_or_else(|| {
    // rust: Tag::compound([
    // rust: ("id", Tag::String("minecraft:decorated_pot".into())),
    // rust: ("x", Tag::Int(pos[0])),
    // rust: ("y", Tag::Int(pos[1])),
    // rust: ("z", Tag::Int(pos[2])),
    // rust: ])
    // rust: });
    // rust: tag = horizon_client::block_entity_nbt::canonical(&tag)?;
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"keepPacked".into());
}
    // rust: Some(tag)
}
    // `DecoratedPotBlockEntity.loadAdditional`: command edits and BlockInput
    // loading write back to the same saved tag that live pot interactions use.
    // rust: pub(super) fn set_pot_data(&mut self, pos: [i32; 3], input: &Tag) -> Option<bool> {
    // rust: let before = self.pot_data(pos)?;
    // rust: let mut input = input.clone();
    // rust: if let Tag::Compound(map) = &mut input {
    // rust: for key in ["id", "x", "y", "z"] {
    // rust: map.insert(key.into(), before.get(key)?.clone());
}
}
    // rust: let mut tag = horizon_client::block_entity_nbt::canonical(&input)?;
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"keepPacked".into());
}
    // rust: let changed = tag != before;
    // rust: spill::put_saved_entity(&mut self.world, pos, tag);
    // rust: self.mark_block_entity_updated((pos[0], pos[1], pos[2]));
    // rust: Some(changed)
}
    // The pot's saved tag at `pos` with its loot unpacked (a new one for a
    // pot without), or None when no pot is there.
pot_tag :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if &*self.res.facts().get(state).name != "minecraft:decorated_pot" {
    // rust: return None;
}
    // rust: let mut tag = spill::saved_entity(&self.world, pos).unwrap_or_else(|| {
    // rust: Tag::compound([
    // rust: ("id", Tag::String("minecraft:decorated_pot".into())),
    // rust: ("x", Tag::Int(pos[0])),
    // rust: ("y", Tag::Int(pos[1])),
    // rust: ("z", Tag::Int(pos[2])),
    // rust: ])
    // rust: });
    // rust: let loot = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: );
    // rust: unpack_loot(
    // rust: &mut tag,
    // rust: loot.as_deref(),
    // rust: &mut self.world.random,
    // rust: &mut self.rand_sequences,
    // rust: self.level.seed,
    // rust: );
    // rust: Some(tag)
}
    // `DecoratedPotBlock.useItemOn` with `held`, then `useWithoutItem` on the
    // main hand's turn: true when the pot took the click.
    // rust: pub(super) fn use_decorated_pot(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: let Some(mut tag) = self.pot_tag(pos) else {
    // rust: return false;
}
    // rust: let mut pot_item = tag.get("item").and_then(save::item_from_nbt);
    // rust: let insertable = held.filter(|stack| match &pot_item {
    // rust: None => true,
    // rust: Some(p) => p.same_item_same_components(stack) && p.count < self.max_stack(p),
    // rust: });
    // rust: let center = pos.map(|v| f64::from(v) + 0.5);
    // rust: let Some(stack) = insertable else {
    // rust: spill::put_saved_entity(&mut self.world, pos, tag);
            // TRY_WITH_EMPTY_HAND: only the main hand goes on to useWithoutItem.
    // rust: if self.hand != Hand::Main {
    // rust: return false;
}
    // rust: self.audio.play(
    // rust: "minecraft:block.decorated_pot.insert_fail",
    // rust: Some(center),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
            // DecoratedPotBlockEntity.wobble: Level.blockEvent, which the
            // clients answer with triggerEvent (the window's pot wobbles).
    // rust: self.block_entity_event(pos, 1, WOBBLE_NEGATIVE);
    // rust: self.lan_block_event(pos, 1, WOBBLE_NEGATIVE);
    // rust: self.post_block_game_event("minecraft:block_change", pos, Some(Who::Player), None);
            // ServerPlayerGameMode.useItemOn: useWithoutItem consumed the click.
    // rust: self.trigger_default_block_use(pos);
    // rust: return true;
}
    // rust: let stack = stack.clone();
    // rust: self.block_entity_event(pos, 1, WOBBLE_POSITIVE);
    // rust: self.lan_block_event(pos, 1, WOBBLE_POSITIVE);
    // rust: self.award_stat("used", &stack.item, 1);
        // consumeAndReturn(1): one item goes in (a creative player keeps theirs).
    // rust: let inserted = match &mut pot_item {
    // rust: Some(p) => {
    // rust: p.count += 1;
    // rust: p
}
    // rust: None => pot_item.insert(ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
    // rust: }),
}
    // rust: let pitch_bend = inserted.count as f32 / self.max_stack(inserted) as f32;
    // rust: if let (Tag::Compound(map), Some(item)) = (&mut tag, &pot_item) {
    // rust: map.insert("item".into(), save::item_to_nbt(item));
}
    // rust: spill::put_saved_entity(&mut self.world, pos, tag);
        // The sherds and item go to the guests (BlockEntityData).
    // rust: self.mark_block_entity_updated((pos[0], pos[1], pos[2]));
    // rust: self.consume_held();
    // rust: self.audio.play(
    // rust: "minecraft:block.decorated_pot.insert",
    // rust: Some(center),
    // rust: 1.0,
    // rust: 0.7 + 0.5 * pitch_bend,
    // rust: );
        // ServerLevel.sendParticles(DUST_PLUME, x + 0.5, y + 1.2, z + 0.5, 7, 0, 0, 0, 0):
        // the server draws none of it; the players within 32 blocks do, the window included.
    // rust: let plume = ParticleOptions::simple(ParticleType::DustPlume);
    // rust: let plume_at = [center[0], f64::from(pos[1]) + 1.2, center[2]];
    // rust: self.particles
    // rust: .send_particles(&plume, plume_at, [0.0; 3], 0.0, 7);
    // rust: self.lan_send_particles(super::lan_particles::QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options: plume,
    // rust: state: None,
    // rust: at: plume_at,
    // rust: spread: [0.0; 3],
    // rust: speed: [0.0; 3],
    // rust: count: 7,
    // rust: randomization: 0,
    // rust: });
    // rust: self.post_block_game_event("minecraft:block_change", pos, Some(Who::Player), None);
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, &stack);
    // rust: true
}
}
