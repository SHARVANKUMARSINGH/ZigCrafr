//! Transpiled from Horizon Rust crate
package horizon_client_spill

import "core:fmt"
import "core:mem"
import "core:math"

// Block entities removed by the block behaviour (`LevelChunk.setBlockState`
// running `BlockEntity.preRemoveSideEffects`) and the resources a destroyed
// block drops (`Block.dropResources`), drawn from the level random at the
// moment vanilla draws them. The item entities they make are added to the
// world as soon as the behaviour returns, within the same tick.
// use super::{Game, GameLevel, Screen, dispenser::new_item_motion, storage::is_shulker_box};
// use horizon_client::{
    // rust: block_entity_item, block_entity_nbt,
    // rust: containers::{Banner, BlockEntity},
    // rust: furnace::FurnaceCooking,
    // rust: item_data,
    // rust: items::ItemStack,
    // rust: save,
}
// use horizon_core::position::BlockPos;
// use horizon_core::random::RandomSource;
// use horizon_world::{
    // rust: level::{
    // rust: LevelEvent,
    // rust: removal::{self, PreRemove},
    // rust: },
    // rust: nbt::{Compound, JavaString, Tag},
    // rust: registry::BlockStateId,
}
// use std::collections::HashMap;

// What a broken block's entity gives its own dropped item (`copy_components`
// in the block loot tables): a shulker box's contents, a banner's layers, a
// container's custom name.
    // rust: pub(super) struct Pending {
    // rust: pub(super) shulker: HashMap<[i32; 3], Vec<(u8, ItemStack)>>,
    // rust: pub(super) banner: HashMap<[i32; 3], Banner>,
    // The block's item and the custom name.
    // rust: pub(super) names: HashMap<[i32; 3], (String, String)>,
    // A decorated pot's sherds (back, left, right, front).
    // rust: pub(super) pot: HashMap<[i32; 3], [Option<ItemStack>; 4]>,
    // A head's profile, note block sound and name, or a hive's bees: the
    // dropped item and the component patch it takes.
    // rust: pub(super) copied: HashMap<[i32; 3], (String, Compound)>,
}
    // rust: impl Pending {
    // Remember what the block entity at `pos` copies into the drops of `block`.
    // rust: pub(super) fn record(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: entity: &BlockEntity,
    // rust: block: &str,
    // rust: name: Option<String>,
    // rust: ) {
    // rust: if let BlockEntity::Banner(banner) = entity {
    // rust: self.banner.insert(pos, banner.clone());
    // rust: return;
}
    // rust: if let Some(name) = name {
    // rust: self.names.insert(pos, (block.to_owned(), name));
}
        // `copy_components` from the block entity: the head tables copy the
        // profile (player heads), note block sound and name, the hive tables
        // the bees.
    // rust: let include: &[&str] = match entity {
    // rust: BlockEntity::Skull(_) if block.starts_with("minecraft:player_") => &[
    // rust: "minecraft:profile",
    // rust: "minecraft:note_block_sound",
    // rust: "minecraft:custom_name",
    // rust: ],
    // rust: BlockEntity::Skull(_) => &["minecraft:custom_name"],
    // rust: BlockEntity::Beehive(_) => &["minecraft:bees"],
    // rust: _ => &[],
}
    // rust: if !include.is_empty() {
    // rust: let saved = save::encode_block_entity((pos[0], pos[1], pos[2]), entity, block);
    // rust: let mut patch = block_entity_nbt::canonical(&saved)
    // rust: .map(|saved| block_entity_item::pick(&saved))
    // rust: .unwrap_or_default();
    // rust: patch.retain(|k, _| include.contains(&k.to_string_lossy().as_str()));
    // rust: if !patch.is_empty() {
                // `Blocks.wallVariant`: a wall head drops the standing item.
    // rust: let item = block.replacen("_wall_", "_", 1);
    // rust: self.copied.insert(pos, (item, patch));
}
}
    // rust: if is_shulker_box(block)
    // rust: && let BlockEntity::Chest(items) = entity
    // rust: {
    // rust: let kept = items
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, s)| Some((i as u8, s.clone()?)))
    // rust: .collect();
    // rust: self.shulker.insert(pos, kept);
}
}
    // Copy what was remembered for `pos` into a drop of the block.
    // rust: pub(super) fn attach(&mut self, pos: [i32; 3], stack: &mut ItemStack) {
    // rust: if is_shulker_box(&stack.item)
    // rust: && let Some(contents) = self.shulker.remove(&pos)
    // rust: && !contents.is_empty()
    // rust: {
    // rust: stack.data_mut().container = contents;
}
    // rust: if self
    // rust: .names
    // rust: .get(&pos)
    // rust: .is_some_and(|(item, _)| **item == *stack.item)
    // rust: && let Some((_, name)) = self.names.remove(&pos)
    // rust: {
    // rust: stack.data_mut().custom_name =
    // rust: Some(horizon_world::nbt::Tag::String(name.as_str().into()));
}
    // rust: if self
    // rust: .copied
    // rust: .get(&pos)
    // rust: .is_some_and(|(item, _)| **item == *stack.item)
    // rust: && let Some((_, copied)) = self.copied.remove(&pos)
    // rust: {
    // rust: let mut patch = match item_data::encode_components(stack) {
    // rust: Some(Tag::Compound(c)) => c,
    // rust: _ => Default::default(),
}
    // rust: patch.extend(copied);
    // rust: (stack.damage, stack.extra) = item_data::decode_components(Some(&Tag::Compound(patch)));
}
    // rust: if &*stack.item == "minecraft:decorated_pot" {
            // The pot's block entity always copies its decorations, empty or not.
    // rust: let sides = self.pot.remove(&pos).unwrap_or_default();
    // rust: stack.data_mut().pot_decorations = Some(Box::new(sides));
}
    // rust: if stack.item.ends_with("_banner")
    // rust: && let Some(Banner {
    // rust: layers,
    // rust: name,
    // rust: components,
    // rust: }) = self.banner.remove(&pos)
    // rust: {
    // rust: let mut patch = match item_data::encode_components(stack) {
    // rust: Some(Tag::Compound(c)) => c,
    // rust: _ => Default::default(),
}
            // The remaining components in the banner loot table's copy_components.
    // rust: for key in [
    // rust: "minecraft:item_name",
    // rust: "minecraft:rarity",
    // rust: "minecraft:tooltip_display",
    // rust: ] {
    // rust: if let Some(value) = components.get(&JavaString::from(key)) {
    // rust: patch.insert(key.into(), value.clone());
}
}
    // rust: patch.insert(
    // rust: "minecraft:banner_patterns".into(),
    // rust: horizon_client::banner::layers_to_nbt(&layers),
    // rust: );
    // rust: if let Some(name) = name {
    // rust: patch.insert(
    // rust: "minecraft:custom_name".into(),
    // rust: Tag::String(name.as_str().into()),
    // rust: );
}
    // rust: (stack.damage, stack.extra) = item_data::decode_components(Some(&Tag::Compound(patch)));
}
}
    // Remember a decorated pot's sherds from its saved block entity.
    // rust: pub(super) fn record_saved(&mut self, pos: [i32; 3], tag: &horizon_world::nbt::Tag) {
//         use horizon_world::nbt::Tag;
    // rust: if tag.get("id") != Some(&Tag::String("minecraft:decorated_pot".into())) {
    // rust: return;
}
    // rust: let sherds = tag.get("sherds");
    // rust: let side = |name: &str| match sherds.and_then(|s| s.get(name)) {
    // rust: Some(Tag::String(id)) => Some(ItemStack {
    // rust: item: std::sync::Arc::from(id.to_string_lossy().as_str()),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: }),
    // rust: Some(t) => horizon_client::save::item_from_nbt(t),
    // rust: None => None,
}
    // rust: self.pot.insert(
    // rust: pos,
    // rust: [side("back"), side("left"), side("right"), side("front")],
    // rust: );
}
    // The block entity's dynamic drops: a decorated pot's sherds, left,
    // back, front then right (`DecoratedPotBlock.getDrops`).
    // rust: pub(super) fn dynamic(&self, pos: [i32; 3]) -> Vec<ItemStack> {
    // rust: self.pot
    // rust: .get(&pos)
    // rust: .map_or_else(Vec::new, |[back, left, right, front]| {
    // rust: [left, back, front, right]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .cloned()
    // rust: .collect()
    // rust: })
}
    // rust: pub(super) fn clear(&mut self, pos: [i32; 3]) {
    // rust: self.pot.remove(&pos);
    // rust: self.shulker.remove(&pos);
    // rust: self.banner.remove(&pos);
    // rust: self.names.remove(&pos);
    // rust: self.copied.remove(&pos);
}
}

// An item entity to add: where, its motion (None: `new ItemEntity`'s own
// random motion) and its pickup delay.
    // rust: pub(super) struct Spawn {
    // rust: pub(super) stack: ItemStack,
    // rust: pub(super) pos: [f64; 3],
    // rust: pub(super) motion: Option<[f64; 3]>,
    // rust: pub(super) delay: u32,
}

    // rust: pub(super) struct Spill {
    // rust: pub(super) spawns: Vec<Spawn>,
    // Experience orbs (`ExperienceOrb.award`): where and how much, each
    // and the merge id it drew from the level random.
    // rust: pub(super) orbs: Vec<([f64; 3], u32, i32)>,
    // Block entities the behaviour removed, for the game's own follow-ups
    // (open screens, playing songs).
    // rust: pub(super) removed: Vec<([i32; 3], BlockEntity)>,
    // Runs of `spawns` a player's use popped (a picked berry bush), for the
    // mods' `native_loot_drops`.
    // rust: pub(super) used: Vec<UsedDrops>,
}

// `spawns[start..end]` came from `table` at the block `pos` in `state`.
    // rust: pub(super) struct UsedDrops {
    // rust: start: usize,
    // rust: end: usize,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: table: &'static str,
}

    // rust: impl Spill {
    // rust: pub(super) fn is_empty(&self) -> bool {
    // rust: self.spawns.is_empty()
    // rust: && self.orbs.is_empty()
    // rust: && self.removed.is_empty()
    // rust: && self.used.is_empty()
}
}

// Lets `say` change each use's run of `spawns`, newest first so the earlier
// ranges hold. A run's stacks keep their spots, and a stack `say` adds takes
// the run's last spot, else the block's top.
    // rust: fn retell_runs(
    // rust: spawns: &mut Vec<Spawn>,
    // rust: used: &[UsedDrops],
    // rust: mut say: impl FnMut(&UsedDrops, [f64; 3], &mut Vec<ItemStack>),
    // rust: ) {
    // rust: for used in used.iter().rev() {
    // rust: let run: Vec<Spawn> = spawns.drain(used.start..used.end).collect();
    // rust: let mut drops: Vec<ItemStack> = run.iter().map(|s| s.stack.clone()).collect();
    // rust: let origin = used.pos.map(|c| f64::from(c) + 0.5);
    // rust: say(used, origin, &mut drops);
    // rust: let top = [origin[0], origin[1] + 0.5, origin[2]];
    // rust: let kept: Vec<Spawn> = drops
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, stack)| Spawn {
    // rust: stack,
    // rust: pos: run.get(i).or(run.last()).map_or(top, |s| s.pos),
    // rust: motion: run.get(i).and_then(|s| s.motion),
    // rust: delay: run.get(i).map_or(10, |s| s.delay),
    // rust: })
    // rust: .collect();
    // rust: spawns.splice(used.start..used.start, kept);
}
}

// `Block.popResource`: a spot around the block's centre from the level random.
    // rust: pub(super) fn pop_position(
    // rust: random: &mut impl horizon_core::random::RandomSource,
    // rust: pos: [i32; 3],
    // rust: ) -> [f64; 3] {
    // rust: let mut offset = || -0.25 + random.next_double() * 0.5;
    // EntityTypes.ITEM is 0.25 high.
    // rust: let half_height = f64::from(0.25f32) / 2.0;
    // rust: [
    // rust: f64::from(pos[0]) + 0.5 + offset(),
    // rust: f64::from(pos[1]) + 0.5 + offset() - half_height,
    // rust: f64::from(pos[2]) + 0.5 + offset(),
    // rust: ]
}

// The block entity at `pos` Horizon keeps as it was loaded, if any
// (campfires, decorated pots, chiseled bookshelves, shelves).
    // rust: pub(super) fn saved_entity(
    // rust: world: &horizon_client::world::World,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<horizon_world::nbt::Tag> {
//     use horizon_world::nbt::Tag;
    // rust: let saved = world
    // rust: .chunks
    // rust: .get(&(pos[0] >> 4, pos[2] >> 4))?
    // rust: .saved
    // rust: .as_ref()?;
    // rust: saved
    // rust: .block_entities
    // rust: .iter()
    // rust: .find(|t| {
    // rust: t.get("x") == Some(&Tag::Int(pos[0]))
    // rust: && t.get("y") == Some(&Tag::Int(pos[1]))
    // rust: && t.get("z") == Some(&Tag::Int(pos[2]))
    // rust: })
    // rust: .cloned()
}

// Keep `tag` as the block entity at its position Horizon does not model,
// replacing the one there.
    // rust: pub(super) fn put_saved_entity(
    // rust: world: &mut horizon_client::world::World,
    // rust: pos: [i32; 3],
    // rust: tag: horizon_world::nbt::Tag,
    // rust: ) {
//     use horizon_world::nbt::Tag;
    // rust: let Some(chunk) = world.chunks.get_mut(&(pos[0] >> 4, pos[2] >> 4)) else {
    // rust: return;
}
    // rust: let chunk = std::sync::Arc::make_mut(chunk);
    // rust: let saved = std::sync::Arc::make_mut(chunk.saved.get_or_insert_default());
    // rust: let at = |t: &Tag| {
    // rust: t.get("x") == Some(&Tag::Int(pos[0]))
    // rust: && t.get("y") == Some(&Tag::Int(pos[1]))
    // rust: && t.get("z") == Some(&Tag::Int(pos[2]))
}
    // rust: match saved.block_entities.iter_mut().find(|t| at(t)) {
    // rust: Some(old) => *old = tag,
    // rust: None => saved.block_entities.push(tag),
}
}

    // rust: impl GameLevel<'_> {
    // `Block.popResource(level, pos, stack)` with the broken block's copied components.
pop_resource :: proc(self: ^Self, pos: [i32; 3], mut stack: ItemStack) {
}
    // rust: self.pending.attach(pos, &mut stack);
    // rust: let at = pop_position(&mut self.world.random, pos);
    // rust: self.spill.spawns.push(Spawn {
    // rust: stack,
    // rust: pos: at,
    // rust: motion: None,
    // rust: delay: 10,
    // rust: });
}
    // `Block.popResource(level, pos, new ItemStack(block))`.
    // rust: pub(super) fn pop_block_item(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let item = self.facts.get(state).item.clone();
    // rust: if &*item != "minecraft:air" {
    // rust: self.pop_resource([pos.x, pos.y, pos.z], ItemStack::new(&item, 1));
}
}
    // An item `atLowerCornerWithOffset(pos, 0.5, 1.01, 0.5).offsetRandomXZ(random,
    // 0.7)` with the default pickup delay (`ComposterBlock.extractProduce`).
    // rust: pub(super) fn pop_above(&mut self, pos: BlockPos, item: std::sync::Arc<str>) {
    // rust: let at = removal::jukebox_pop_position(&mut self.world.random, pos);
    // rust: self.spill.spawns.push(Spawn {
    // rust: stack: ItemStack::new(&item, 1),
    // rust: pos: at,
    // rust: motion: None,
    // rust: delay: 10,
    // rust: });
}
    // `Block.dropFromBlockInteractLootTable` with `Block.popResource` of
    // every stack.
    // rust: pub(super) fn drop_interact_loot(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: table: &'static str,
    // rust: ) {
    // rust: let drops = self.items.interact_loot(
    // rust: table,
    // rust: self.registry,
    // rust: state,
    // rust: &mut self.world.random,
    // rust: self.rand_sequences,
    // rust: self.seed,
    // rust: );
    // rust: let start = self.spill.spawns.len();
    // rust: for stack in drops {
    // rust: if &*stack.item != "minecraft:air" && stack.count > 0 {
    // rust: self.pop_resource([pos.x, pos.y, pos.z], stack);
}
}
    // rust: self.spill.used.push(UsedDrops {
    // rust: start,
    // rust: end: self.spill.spawns.len(),
    // rust: pos: [pos.x, pos.y, pos.z],
    // rust: state,
    // rust: table,
    // rust: });
}
    // `Block.dropResources(state, level, pos, blockEntity)`: the block's loot
    // (from its random sequence, else the level random), with what its block
    // entity copies into it, popped at once. While a mod's machine breaks
    // the block (`native_machine_destroy_block`), the loot is rolled with its
    // `drop_tool` (`dropResources(.., entity, tool)`) and, given `drop_into`,
    // kept there instead of popped.
    // rust: pub(super) fn drop_resources_now(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let key = (pos.x, pos.y, pos.z);
    // rust: let at = [pos.x, pos.y, pos.z];
    // rust: if let Some(entity) = self.world.block_entities.get(&key) {
    // rust: let entity = entity.clone();
    // rust: let name = self.world.block_names.get(&key).cloned();
    // rust: let block = self.facts.get(state).name.clone();
    // rust: self.pending.record(at, &entity, &block, name);
    // rust: } else if let Some(tag) = saved_entity(self.world, [pos.x, pos.y, pos.z]) {
    // rust: self.pending.record_saved(at, &tag);
}
    // rust: let dynamic = self.pending.dynamic(at);
        // Only the block a machine breaks: a neighbour that pops off with it
        // drops as with no tool, and pops (`Level.destroyBlock` for it).
    // rust: let machine = self
    // rust: .drop_tool
    // rust: .as_ref()
    // rust: .is_some_and(|(target, _)| *target == key);
    // rust: let tool = self
    // rust: .drop_tool
    // rust: .as_ref()
    // rust: .filter(|_| machine)
    // rust: .and_then(|(_, tool)| tool.as_ref());
    // rust: let silk = tool.is_some_and(|t| t.enchantment_level("minecraft:silk_touch") > 0);
    // rust: let drops = match self.items.block_loot_sequence(self.registry, state) {
    // rust: Some(sequence) => {
    // rust: let random = self.rand_sequences.get(&sequence, self.seed);
    // rust: self.items
    // rust: .block_drops_with(self.registry, state, tool, &dynamic, random)
}
    // rust: None => self.items.block_drops_with(
    // rust: self.registry,
    // rust: state,
    // rust: tool,
    // rust: &dynamic,
    // rust: &mut self.world.random,
    // rust: ),
}
    // rust: for mut stack in drops {
    // rust: if &*stack.item == "minecraft:air" || stack.count == 0 {
    // rust: continue;
}
    // rust: match self.drop_into.as_mut().filter(|_| machine) {
    // rust: Some(kept) => {
    // rust: self.pending.attach(at, &mut stack);
    // rust: kept.push(stack);
}
    // rust: None => self.pop_resource(at, stack),
}
}
    // rust: self.pending.clear(at);
        // BlockBehaviour.spawnAfterBreak: ores, sculk and spawners award
        // experience at the block's centre, except to a machine's silk touch
        // tool (`processBlockExperience`; a spawner keeps its own), as the
        // player's break does.
    // rust: let name = self.facts.get(state).name.clone();
        // `xpRange.sample` draws before silk touch zeroes it.
    // rust: let xp = removal::break_experience(&mut self.world.random, &name)
    // rust: .filter(|_| !silk || &*name == "minecraft:spawner");
    // rust: if let Some(mut xp) = xp
    // rust: && self.rules.block_drops
    // rust: {
    // rust: if self.native_authoritative {
    // rust: self.native_block_exp(self.dimension, pos, &name, &mut xp);
}
    // rust: let centre = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: self.award_orbs(centre, xp);
}
}
    // `ExperienceOrb.award`: orbs of the largest sizes, each drawing the id
    // `tryMergeToExisting` compares from the level random.
    // rust: pub(super) fn award_orbs(&mut self, at: [f64; 3], mut amount: u32) {
    // rust: while amount > 0 {
    // rust: let value = removal::orb_value(amount);
    // rust: amount -= value;
    // rust: let merge_id = self.world.random.next_int_bound(40).unwrap_or(0);
    // rust: self.spill.orbs.push((at, value, merge_id));
}
}
    // `BlockEntity.preRemoveSideEffects` and `removeBlockEntity` for the block
    // entity of `old` at `pos`. A block entity Horizon never created reads as
    // vanilla's fresh one: an empty container still draws a spot per slot.
    // rust: pub(super) fn remove_entity(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: old: BlockStateId,
    // rust: side_effects: bool,
    // rust: ) -> u8 {
    // rust: let key = (pos.x, pos.y, pos.z);
    // rust: if self.remove_saved_entity(pos, old, side_effects) {
    // rust: return 0;
}
        // Sculk blocks and creaking hearts notice their removal on their own tick.
    // rust: if matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Sculk(_) | BlockEntity::CreakingHeart(_))
    // rust: ) {
    // rust: return 0;
}
    // rust: let entity = self.world.block_entities.remove(&key);
    // rust: self.world.block_names.remove(&key);
    // rust: self.world.forget_block_entity_source(key);
    // rust: let name = self.facts.get(old).name.clone();
    // rust: let kind = match &entity {
            // BaseContainerBlockEntity.preRemoveSideEffects: Containers.dropContents.
    // rust: Some(BlockEntity::Mod(m))
    // rust: if !m.items.is_empty()
    // rust: && self.world.block_entities.mod_container(old.0).is_some() =>
    // rust: {
    // rust: PreRemove::Contents {
    // rust: slots: m.items.len(),
    // rust: furnace: false,
}
}
    // rust: _ => removal::pre_remove(&name),
}
    // rust: let mut neighbour_updates = 0;
    // rust: if side_effects {
    // rust: match kind {
    // rust: PreRemove::Contents { slots, furnace } => {
    // rust: let items = entity.as_ref().map_or(&[][..], BlockEntity::slots);
    // rust: for slot in 0..slots {
    // rust: let stack = items.get(slot).cloned().flatten();
    // rust: self.drop_item_stack(pos, stack);
}
                    // AbstractFurnaceBlockEntity.preRemoveSideEffects: then the
                    // experience of what it made, at the block's centre.
    // rust: if furnace && let Some(BlockEntity::Furnace(f)) = &entity {
    // rust: let at = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: for (count, experience) in f.recipe_experience(self.recipes) {
    // rust: let xp = horizon_client::containers::create_experience(
    // rust: count,
    // rust: experience,
    // rust: &mut self.world.random,
    // rust: );
    // rust: self.award_orbs(at, xp);
}
}
}
    // rust: PreRemove::Campfire => {
    // rust: let items = match &entity {
    // rust: Some(BlockEntity::Campfire(c)) => c.items.clone(),
    // rust: _ => Default::default(),
}
    // rust: for stack in items {
    // rust: self.drop_item_stack(pos, stack);
}
}
    // rust: PreRemove::Jukebox => {
                    // popOutTheItem: removeTheItem stops a playing song (its
                    // events and a neighbour update), the record pops, and
                    // onSongChanged updates the neighbours again.
    // rust: if let Some(BlockEntity::Jukebox(j)) = &entity
    // rust: && let Some(record) = j.record().cloned()
    // rust: {
    // rust: if j.playing {
    // rust: self.jukebox_stopped(pos, old);
    // rust: neighbour_updates += 1;
}
    // rust: let at = removal::jukebox_pop_position(&mut self.world.random, pos);
    // rust: self.spill.spawns.push(Spawn {
    // rust: stack: record,
    // rust: pos: at,
    // rust: motion: None,
    // rust: delay: 10,
    // rust: });
    // rust: neighbour_updates += 1;
}
}
    // rust: PreRemove::Lectern => {
    // rust: let props = self.registry.state(old).map(|s| &s.properties);
    // rust: let has_book = props
    // rust: .and_then(|p| p.get("has_book"))
    // rust: .is_some_and(|v| v == "true");
    // rust: let step = match props.and_then(|p| p.get("facing")).map(String::as_str) {
    // rust: Some("north") => [0, -1],
    // rust: Some("south") => [0, 1],
    // rust: Some("west") => [-1, 0],
    // rust: _ => [1, 0],
}
    // rust: if has_book
    // rust: && let Some(BlockEntity::Lectern(l)) = &entity
    // rust: && let Some(book) = l.book.clone()
    // rust: {
    // rust: self.spill.spawns.push(Spawn {
    // rust: stack: book,
    // rust: pos: removal::lectern_book_position(pos, step),
    // rust: motion: None,
    // rust: delay: 10,
    // rust: });
}
}
    // rust: PreRemove::ShulkerBox
    // rust: | PreRemove::SculkShrieker
    // rust: | PreRemove::CreakingHeart
    // rust: | PreRemove::Beacon
    // rust: | PreRemove::Nothing => {}
}
}
        // BlockEntity.setRemoved: a jukebox always reports its song stopping,
        // a beacon plays its deactivation.
    // rust: match kind {
    // rust: PreRemove::Jukebox => self.jukebox_stopped(pos, old),
    // rust: PreRemove::Beacon => self.events.push(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.beacon.deactivate".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: }),
    // rust: _ => {}
}
    // rust: if let Some(entity) = entity {
    // rust: self.spill.removed.push(([pos.x, pos.y, pos.z], entity));
}
    // rust: neighbour_updates
}
    // The jukebox's `JUKEBOX_STOP_PLAY` game event and level event 1011.
jukebox_stopped :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: self.events.push(LevelEvent::GameEvent {
    // rust: pos,
    // rust: event: "minecraft:jukebox_stop_play",
    // rust: state: Some(state),
    // rust: });
    // rust: self.events.push(LevelEvent::LevelEvent {
    // rust: id: 1011,
    // rust: pos,
    // rust: data: 0,
    // rust: });
}
    // A block entity Horizon keeps as it was loaded (campfires, decorated
    // pots, chiseled bookshelves, shelves): its items spill as vanilla's do.
    // rust: fn remove_saved_entity(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: old: BlockStateId,
    // rust: side_effects: bool,
    // rust: ) -> bool {
//         use horizon_world::nbt::Tag;
    // rust: let chunk_key = (pos.x >> 4, pos.z >> 4);
    // rust: let at = |t: &Tag| {
    // rust: let int = |k: &str| match t.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: int("x") == Some(pos.x) && int("y") == Some(pos.y) && int("z") == Some(pos.z)
}
    // rust: let Some(chunk) = self.world.chunks.get_mut(&chunk_key) else {
    // rust: return false;
}
    // rust: let Some(saved) = chunk.saved.as_ref() else {
    // rust: return false;
}
    // rust: let Some(index) = saved.block_entities.iter().position(at) else {
    // rust: return false;
}
    // rust: let chunk = std::sync::Arc::make_mut(chunk);
    // rust: let Some(saved) = chunk.saved.as_mut() else {
    // rust: return false;
}
    // rust: let tag = std::sync::Arc::make_mut(saved).block_entities.remove(index);
    // rust: if !side_effects {
    // rust: return true;
}
    // rust: let name = self.facts.get(old).name.clone();
    // rust: let items = match removal::pre_remove(&name) {
    // rust: PreRemove::Contents { slots, .. } if &*name == "minecraft:decorated_pot" => {
                // Containers.dropContents reads getTheItem, which unpacks the loot table.
    // rust: let mut tag = tag;
    // rust: super::decorated_pot::unpack_loot(
    // rust: &mut tag,
    // rust: self.loot.as_deref(),
    // rust: &mut self.world.random,
    // rust: self.rand_sequences,
    // rust: self.seed,
    // rust: );
    // rust: let mut items = vec![None; slots];
    // rust: items[0] = tag
    // rust: .get("item")
    // rust: .and_then(horizon_client::save::item_from_nbt);
    // rust: items
}
    // rust: PreRemove::Contents { slots, .. } => {
    // rust: horizon_client::save::decode_items(tag.get("Items"), slots)
}
    // rust: PreRemove::Campfire => horizon_client::save::decode_items(tag.get("Items"), 4),
    // rust: _ => return true,
}
    // rust: for stack in items {
    // rust: self.drop_item_stack(pos, stack);
}
    // rust: true
}
    // `Containers.dropContents` for a mod block entity that left the world
    // during its own tick (the block broke itself): what it held spills as
    // vanilla's `preRemoveSideEffects` would, instead of vanishing with it.
    // rust: pub(super) fn drop_lost_contents(&mut self, pos: BlockPos, items: Vec<Option<ItemStack>>) {
    // rust: for stack in items {
    // rust: self.drop_item_stack(pos, stack);
}
}
    // `Containers.dropItemStack` of one slot (an empty one still draws its spot).
drop_item_stack :: proc(self: ^Self, pos: BlockPos, stack: Maybe(ItemStack)) {
}
    // rust: let count = stack.as_ref().map_or(0, |s| s.count);
    // rust: for piece in removal::drop_item_stack(&mut self.world.random, pos, count) {
    // rust: let Some(stack) = &stack else { break };
    // rust: self.spill.spawns.push(Spawn {
    // rust: stack: ItemStack {
    // rust: count: piece.count,
    // rust: ..stack.clone()
    // rust: },
    // rust: pos: piece.pos,
    // rust: motion: Some(piece.motion),
    // rust: delay: 0,
    // rust: });
}
}
}

    // rust: impl Game<'_> {
    // Add the item entities the block behaviour spawned and follow up on the
    // block entities it removed.
    // rust: pub(super) fn flush_spill(&mut self) {
    // rust: if self.spill.is_empty() {
    // rust: return;
}
    // rust: let mut spill = std::mem::take(&mut self.spill);
    // rust: let used = std::mem::take(&mut spill.used);
    // rust: let tool = self.held().cloned();
    // rust: retell_runs(&mut spill.spawns, &used, |used, origin, drops| {
    // rust: let block = Some((used.pos, used.state));
    // rust: self.native_use_drops(used.table, origin, block, None, tool.as_ref(), drops);
    // rust: });
    // rust: for s in spill.spawns {
    // rust: let motion = s.motion.unwrap_or_else(new_item_motion);
    // rust: self.spawn_item(s.stack, s.pos, motion, s.delay);
}
    // rust: for (at, value, merge_id) in spill.orbs {
    // rust: self.award_orb(at, value, merge_id);
}
    // rust: for (pos, entity) in spill.removed {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if matches!(entity, BlockEntity::Jukebox(_)) {
    // rust: self.jukebox_removed(pos);
}
    // rust: if self.container == Some(key) {
    // rust: self.container_opener_event(key, false);
    // rust: self.container = None;
    // rust: self.screen = Screen::Playing;
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::{block_entity_item, item_data, mobs::raider, save};
//     use horizon_world::nbt::Tag;

a_used_run_is_retold_in_place :: proc() {
}
    // rust: let spawn = |item: &str, x: f64| Spawn {
    // rust: stack: ItemStack::new(item, 1),
    // rust: pos: [x, 0.0, 0.0],
    // rust: motion: None,
    // rust: delay: 10,
}
    // rust: let mut spawns = vec![
    // rust: spawn("minecraft:stone", 0.0),
    // rust: spawn("minecraft:sweet_berries", 1.0),
    // rust: spawn("minecraft:sweet_berries", 2.0),
    // rust: spawn("minecraft:dirt", 3.0),
    // rust: ];
    // rust: let used = [UsedDrops {
    // rust: start: 1,
    // rust: end: 3,
    // rust: pos: [4, 64, 4],
    // rust: state: BlockStateId(0),
    // rust: table: "minecraft:harvest/sweet_berry_bush",
    // rust: }];
    // rust: retell_runs(&mut spawns, &used, |used, origin, drops| {
    // rust: assert_eq!(used.table, "minecraft:harvest/sweet_berry_bush");
    // rust: assert_eq!(origin, [4.5, 64.5, 4.5]);
    // rust: assert_eq!(drops.len(), 2);
    // rust: drops.remove(0);
    // rust: drops.push(ItemStack::new("minecraft:diamond", 1));
    // rust: });
    // rust: let items: Vec<(&str, f64)> = spawns.iter().map(|s| (&*s.stack.item, s.pos[0])).collect();
    // rust: assert_eq!(
    // rust: items,
    // rust: [
    // rust: ("minecraft:stone", 0.0),
    // rust: ("minecraft:sweet_berries", 1.0),
    // rust: ("minecraft:diamond", 2.0),
    // rust: ("minecraft:dirt", 3.0),
    // rust: ]
    // rust: );
}

ominous_banner_survives_placement_save_and_drop :: proc() {
}
    // rust: let original = raider::ominous_banner();
    // rust: let Tag::Compound(components) = item_data::encode_components(&original).unwrap() else {
    // rust: panic!("banner components");
}
    // rust: for block in ["minecraft:white_banner", "minecraft:white_wall_banner"] {
    // rust: let pos = (1, 64, 2);
    // rust: let fresh = BlockEntity::for_block(block).unwrap();
    // rust: let fresh = save::encode_block_entity(pos, &fresh, block);
    // rust: let placed = block_entity_item::place(&fresh, &components, false);
    // rust: let (_, placed) = save::decode_block_entity(&placed).unwrap();
    // rust: let saved = save::encode_block_entity(pos, &placed, block);
    // rust: let (_, loaded) = save::decode_block_entity(&saved).unwrap();
    // rust: let BlockEntity::Banner(banner) = &loaded else {
    // rust: panic!("placed banner");
}
    // rust: assert_eq!(banner.layers.len(), item_data::OMINOUS_LAYERS.len());
    // rust: let mut pending = Pending::default();
    // rust: pending.record([pos.0, pos.1, pos.2], &loaded, block, None);
    // rust: let mut dropped = ItemStack::new("minecraft:white_banner", 1);
    // rust: pending.attach([pos.0, pos.1, pos.2], &mut dropped);
    // rust: assert!(dropped.data().unwrap().ominous_banner);
    // rust: assert!(horizon_client::banner::tooltip_layers(&dropped).is_empty());
    // rust: assert_eq!(
    // rust: horizon_client::item_tooltip::name_line(&dropped, &|_| None),
    // rust: "Ominous Banner"
    // rust: );
    // rust: assert_eq!(
    // rust: horizon_client::item_tooltip::rarity(&dropped, "common"),
    // rust: "uncommon"
    // rust: );
    // rust: assert_eq!(
    // rust: item_data::encode_components(&dropped),
    // rust: Some(Tag::Compound(components.clone()))
    // rust: );
}
}
}
