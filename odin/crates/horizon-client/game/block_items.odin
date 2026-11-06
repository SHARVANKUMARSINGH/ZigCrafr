//! Transpiled from Horizon Rust crate
package horizon_client_block_items

import "core:fmt"
import "core:mem"
import "core:math"

// Block entities and the items that carry them
// (`horizon_client::block_entity_item`): the item Pick Block gives, with the
// block entity's data on Ctrl in creative, and the data and components a
// placed item gives its block entity.
// use super::Game;
// use horizon_client::{
    // rust: Result, block_entity_item, block_entity_nbt, containers::BlockEntity, item_data,
    // rust: items::ItemStack, save,
}
// use horizon_world::{
    // rust: level::{Behaviours, classes::Class},
    // rust: nbt::{Compound, JavaString, Tag},
    // rust: registry::BlockStateId,
}

// The component patch of `stack`.
components :: proc(stack: ^ItemStack) -> C {
    // Ported from Horizon
    return {}
}
    // rust: match item_data::encode_components(stack) {
    // rust: Some(Tag::Compound(c)) => c,
    // rust: _ => Compound::new(),
}
}

// `BlockState.getCloneItemStack`'s item: the block's own item, unless the
// block overrides it. A block with no item of its own still has one to pick:
// a stem's seeds, a crop's seed item, a vine's harvest.
    // rust: fn clone_item<'a>(name: &str, block_item: &'a str) -> &'a str {
    // rust: match name {
        // StemBlock and AttachedStemBlock: the seeds it grew from.
    // rust: "minecraft:pumpkin_stem" | "minecraft:attached_pumpkin_stem" => "minecraft:pumpkin_seeds",
    // rust: "minecraft:melon_stem" | "minecraft:attached_melon_stem" => "minecraft:melon_seeds",
        // CropBlock.getCloneItemStack: new ItemStack(getBaseSeedId()).
    // rust: "minecraft:wheat" => "minecraft:wheat_seeds",
    // rust: "minecraft:carrots" => "minecraft:carrot",
    // rust: "minecraft:potatoes" => "minecraft:potato",
    // rust: "minecraft:beetroots" => "minecraft:beetroot_seeds",
    // rust: "minecraft:torchflower_crop" => "minecraft:torchflower_seeds",
        // BambooSaplingBlock, SweetBerryBushBlock and the two cave vine
        // blocks: new ItemStack(their harvest item).
    // rust: "minecraft:bamboo_sapling" => "minecraft:bamboo",
    // rust: "minecraft:sweet_berry_bush" => "minecraft:sweet_berries",
    // rust: "minecraft:cave_vines" | "minecraft:cave_vines_plant" => "minecraft:glow_berries",
        // BigDripleafStemBlock: new ItemStack(Blocks.BIG_DRIPLEAF).
    // rust: "minecraft:big_dripleaf_stem" => "minecraft:big_dripleaf",
        // GrowingPlantBodyBlock: new ItemStack(getHeadBlock()), the block that
        // carries the item.
    // rust: "minecraft:kelp_plant" => "minecraft:kelp",
    // rust: "minecraft:twisting_vines_plant" => "minecraft:twisting_vines",
    // rust: "minecraft:weeping_vines_plant" => "minecraft:weeping_vines",
        // CandleCakeBlock: new ItemStack(Blocks.CAKE), for every colour.
    // rust: _ if name.ends_with("_candle_cake") => "minecraft:cake",
    // rust: _ => block_item,
}
}

    // rust: fn picked_item<'a>(
    // rust: behaviours: &'a Behaviours,
    // rust: state: BlockStateId,
    // rust: item: &'a str,
    // rust: ) -> Option<&'a str> {
    // rust: let plant = behaviours.data(state);
    // rust: let potted = plant
    // rust: .is(Class::FlowerPot)
    // rust: .then_some(plant.link)
    // rust: .flatten()
    // rust: .map(|block| &*behaviours.block_data(block).item)
    // rust: .filter(|item| *item != "minecraft:air");
    // rust: Some(potted.unwrap_or(item)).filter(|item| *item != "minecraft:air")
}

    // rust: impl Game<'_> {
    // The block entity at `key` as vanilla saves it, with its custom name.
saved_block_entity :: proc(self: ^Self, key: (i32) {
}
    // rust: let entity = self.world.block_entities.get(&key)?;
    // rust: let block = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(key.0, key.1, key.2))
    // rust: .name;
    // rust: let mut tag = save::encode_block_entity(key, entity, block);
    // rust: if let (Some(name), Tag::Compound(map)) = (self.world.block_names.get(&key), &mut tag) {
    // rust: map.insert("CustomName".into(), Tag::String(name.as_str().into()));
}
    // rust: block_entity_nbt::canonical(&tag)
}

    // The `CustomName` a block entity loads from `tag`
    // (`BaseContainerBlockEntity.loadAdditional`): kept beside the model in
    // `block_names`, and dropped when the tag has none. Banners and signs
    // keep their name themselves. True when the name changed.
    // rust: pub(super) fn load_block_name(
    // rust: &mut self,
    // rust: key: (i32, i32, i32),
    // rust: entity: &BlockEntity,
    // rust: tag: &Tag,
    // rust: ) -> bool {
    // rust: if matches!(entity, BlockEntity::Banner(_) | BlockEntity::Sign(_)) {
    // rust: return false;
}
    // rust: let name = save::text(tag.get("CustomName"));
    // rust: if self.world.block_names.get(&key) == name.as_ref() {
    // rust: return false;
}
    // rust: match name {
    // rust: Some(name) => self.world.block_names.insert(key, name),
    // rust: None => self.world.block_names.remove(&key),
}
    // rust: true
}

    // `BlockState.getCloneItemStack` of the block at `pos`, then, with
    // `include_data`, `ServerGamePacketListenerImpl.addBlockDataToItem`.
    // rust: pub(super) fn picked_stack(&self, pos: [i32; 3], include_data: bool) -> Option<ItemStack> {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let facts = self.res.facts().get(state);
        // PistonHeadBlock.getCloneItemStack: the piston the head belongs to.
    // rust: let head = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| s.name.as_str() == "minecraft:piston_head")
    // rust: .map(|s| match s.properties.get("type") {
    // rust: Some(t) if t == "sticky" => "minecraft:sticky_piston",
    // rust: _ => "minecraft:piston",
    // rust: });
    // rust: let item = clone_item(&facts.name, head.unwrap_or(&facts.item));
        // FlowerPotBlock.getCloneItemStack: a potted plant picks as that plant
        // (`new ItemStack(potted)`), an empty pot as the pot itself.
    // rust: let item = picked_item(self.res.behaviours(), state, item)?;
    // rust: let mut stack = ItemStack::new(item, 1);
    // rust: let mut patch = Compound::new();
        // BeehiveBlock.getCloneItemStack: the honey level as the item's block state.
    // rust: if include_data
    // rust: && let Some(level) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| matches!(s.name.as_str(), "minecraft:beehive" | "minecraft:bee_nest"))
    // rust: .and_then(|s| s.properties.get("honey_level"))
    // rust: {
    // rust: patch.insert(
    // rust: "minecraft:block_state".into(),
    // rust: Tag::compound([("honey_level", Tag::String(level.as_str().into()))]),
    // rust: );
}
        // CopperGolemStatueBlock.getCloneItemStack: the statue's pose as the item's
        // block_state (`CopperGolemStatueBlockEntity.getItem`), data or not.
    // rust: if let Some(pose) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| s.name.ends_with("copper_golem_statue"))
    // rust: .and_then(|s| s.properties.get("copper_golem_pose"))
    // rust: {
    // rust: patch.insert(
    // rust: "minecraft:block_state".into(),
    // rust: Tag::compound([("copper_golem_pose", Tag::String(pose.as_str().into()))]),
    // rust: );
}
        // LightBlock.getCloneItemStack, setLightOnStack: the light's level as
        // the item's block state, whether or not the block data is picked.
    // rust: if let Some(level) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| s.name.as_str() == "minecraft:light")
    // rust: .and_then(|s| s.properties.get("level"))
    // rust: {
    // rust: patch.insert(
    // rust: "minecraft:block_state".into(),
    // rust: Tag::compound([("level", Tag::String(level.as_str().into()))]),
    // rust: );
}
        // AbstractBannerBlock.getCloneItemStack: the banner's own item
        // (BannerBlockEntity.getItem), data or not.
    // rust: let banner = matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Banner(_))
    // rust: );
        // DecoratedPotBlock.getCloneItemStack: createDecoratedPotInstance, the
        // sherds only; the pot's item comes with include_data.
    // rust: let pot = &*facts.name == "minecraft:decorated_pot";
    // rust: if (include_data || banner || pot)
    // rust: && let Some(saved) = self.saved_block_entity(key)
    // rust: {
    // rust: let mut picked = block_entity_item::pick(&saved);
    // rust: if pot && !include_data {
    // rust: picked.retain(|k, _| *k == JavaString::from("minecraft:pot_decorations"));
}
    // rust: patch.extend(picked);
}
    // rust: if !patch.is_empty() {
    // rust: let mut all = components(&stack);
    // rust: all.extend(patch);
    // rust: (stack.damage, stack.extra) = item_data::decode_components(Some(&Tag::Compound(all)));
}
    // rust: Some(stack)
}

    // `ShulkerBoxBlock.playerWillDestroy`: a Creative player's filled box is
    // one item at the block center, with collectComponents and the default pickup delay.
    // This direct spawn intentionally does not use the block_drops gamerule.
    // rust: pub(super) fn drop_creative_shulker(&mut self, pos: [i32; 3]) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let filled = matches!(self.world.block_entities.get(&key), Some(BlockEntity::Chest(items))
    // rust: if items.iter().flatten().any(|s| s.count > 0));
    // rust: if !filled {
    // rust: return;
}
    // rust: let Some(saved) = self.saved_block_entity(key) else {
    // rust: return;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let mut stack = ItemStack::new(&self.res.facts().get(state).item, 1);
    // rust: let patch = block_entity_item::collected_components(&saved);
    // rust: (stack.damage, stack.extra) = item_data::decode_components(Some(&Tag::Compound(patch)));
    // rust: self.spawn_item(
    // rust: stack,
    // rust: pos.map(|v| f64::from(v) + 0.5),
    // rust: super::dispenser::new_item_motion(),
    // rust: 10,
    // rust: );
}

    // `BlockItem.updateBlockStateFromTag`: the properties of the item's
    // `block_state` component (a hive's honey level, a statue's pose) set on
    // the block just placed at `pos`. Returns the state it has now.
    // rust: pub(super) fn apply_item_block_state(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: stack: &ItemStack,
    // rust: ) -> Result<BlockStateId> {
    // rust: let Some(Tag::Compound(saved)) =
    // rust: stack.data().and_then(|d| d.other("minecraft:block_state"))
    // rust: else {
    // rust: return Ok(state);
}
    // rust: let Some(current) = self.pack.assets.registry.state(state) else {
    // rust: return Ok(state);
}
        // Only the properties the block has.
    // rust: let props: Vec<(String, String)> = saved
    // rust: .iter()
    // rust: .filter_map(|(k, v)| match v {
    // rust: Tag::String(v) => Some((k.to_string_lossy(), v.to_string_lossy())),
    // rust: _ => None,
    // rust: })
    // rust: .filter(|(k, v)| current.properties.get(k).is_some_and(|old| old != v))
    // rust: .collect();
    // rust: let props: Vec<(&str, &str)> = props.iter().map(|(k, v)| (&**k, &**v)).collect();
    // rust: match self.with_props(state, &props) {
    // rust: Some(new) if !props.is_empty() && new != state => {
    // rust: self.level_set(pos, new)?;
    // rust: Ok(new)
}
    // rust: _ => Ok(state),
}
}

    // `BlockItem.updateBlockEntityComponents` on a client's level, for the
    // block it predicts at `pos`: the block entity takes the stack's
    // components but not its `block_entity_data` (`updateCustomBlockEntityTag`
    // returns on a client), so a copied sign's editor opens with its text (#8102).
    // rust: pub(super) fn apply_predicted_item(&mut self, pos: [i32; 3], stack: &ItemStack) {
    // rust: let mut stack = stack.clone();
    // rust: if stack.data().is_some() {
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other(block_entity_item::BLOCK_ENTITY_DATA, None);
}
    // rust: self.apply_placed_item(pos, &stack, false);
}

    // `BlockItem.updateCustomBlockEntityTag` and `updateBlockEntityComponents`
    // for the block entity just placed at `pos` from `stack`; `game_master`:
    // the placer can use game master blocks (a dispenser can't).
    // rust: pub(super) fn apply_placed_item(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: stack: &ItemStack,
    // rust: game_master: bool,
    // rust: ) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: self.pending.banner.remove(&pos);
    // rust: let Some(saved) = self.saved_block_entity(key) else {
    // rust: return;
}
    // rust: let placed = block_entity_item::place(&saved, &components(stack), game_master);
    // rust: if placed == saved {
    // rust: return;
}
    // rust: let Some((_, mut entity)) = save::decode_block_entity(&placed) else {
    // rust: return;
}
        // The new crafter's state flag (CrafterBlock.newBlockEntity), which
        // its saved data has no part of.
    // rust: if let (BlockEntity::Crafter(new), Some(BlockEntity::Crafter(old))) =
    // rust: (&mut entity, self.world.block_entities.get(&key))
    // rust: {
    // rust: new.state_triggered = old.state_triggered;
}
    // rust: self.load_block_name(key, &entity, &placed);
    // rust: self.world.block_entities.insert(key, entity);
    // rust: self.update_spawner_display(key);
}
}

    // rust: mod tests {
//     use super::{clone_item, picked_item};

a_potted_plant_picks_its_plant_and_an_empty_pot_the_pot :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("block-behaviours.json").exists() {
    // rust: return;
}
    // rust: let registry = horizon_world::level::data::load_registry(&root).unwrap();
    // rust: let behaviours = horizon_world::level::Behaviours::load(&registry, &root).unwrap();
    // rust: let pick = |block: &str, own: &'static str| {
    // rust: let state = registry.default_state(block).unwrap();
    // rust: picked_item(&behaviours, state, own).map(str::to_owned)
}
    // rust: assert_eq!(
    // rust: pick("minecraft:potted_dandelion", "minecraft:air").as_deref(),
    // rust: Some("minecraft:dandelion")
    // rust: );
    // rust: assert_eq!(
    // rust: pick("minecraft:potted_oak_sapling", "minecraft:air").as_deref(),
    // rust: Some("minecraft:oak_sapling")
    // rust: );
    // rust: assert_eq!(
    // rust: pick("minecraft:flower_pot", "minecraft:flower_pot").as_deref(),
    // rust: Some("minecraft:flower_pot")
    // rust: );
    // rust: assert_eq!(
    // rust: pick("minecraft:stone", "minecraft:stone").as_deref(),
    // rust: Some("minecraft:stone")
    // rust: );
    // rust: assert_eq!(pick("minecraft:fire", "minecraft:air"), None);
}

    // `StemBlock.getCloneItemStack` and `AttachedStemBlock.getCloneItemStack`:
    // pumpkin and melon stems, attached or not, pick the seed they grew from;
    // a block without an override still picks its own item.
stems_pick_their_seeds_and_blocks_their_item :: proc() {
}
    // rust: for (stem, seed) in [
    // rust: ("minecraft:pumpkin_stem", "minecraft:pumpkin_seeds"),
    // rust: ("minecraft:attached_pumpkin_stem", "minecraft:pumpkin_seeds"),
    // rust: ("minecraft:melon_stem", "minecraft:melon_seeds"),
    // rust: ("minecraft:attached_melon_stem", "minecraft:melon_seeds"),
    // rust: ] {
    // rust: assert_eq!(clone_item(stem, "minecraft:air"), seed, "{stem}");
}
    // rust: assert_eq!(
    // rust: clone_item("minecraft:stone", "minecraft:stone"),
    // rust: "minecraft:stone"
    // rust: );
}
    // The blocks whose `getCloneItemStack` override returns something other
    // than their own item: a crop's seed item, a sapling's bamboo, a cave
    // vine's glow berries, a stem block's head. Each of them has no item of
    // its own, so pick block gave nothing before; a block with an item is
    // still untouched.
blocks_without_an_item_pick_as_their_harvest :: proc() {
}
    // rust: for (block, item) in [
    // rust: ("minecraft:wheat", "minecraft:wheat_seeds"),
    // rust: ("minecraft:carrots", "minecraft:carrot"),
    // rust: ("minecraft:potatoes", "minecraft:potato"),
    // rust: ("minecraft:beetroots", "minecraft:beetroot_seeds"),
    // rust: ("minecraft:torchflower_crop", "minecraft:torchflower_seeds"),
    // rust: ("minecraft:bamboo_sapling", "minecraft:bamboo"),
    // rust: ("minecraft:sweet_berry_bush", "minecraft:sweet_berries"),
    // rust: ("minecraft:cave_vines", "minecraft:glow_berries"),
    // rust: ("minecraft:cave_vines_plant", "minecraft:glow_berries"),
    // rust: ("minecraft:big_dripleaf_stem", "minecraft:big_dripleaf"),
    // rust: ("minecraft:kelp_plant", "minecraft:kelp"),
    // rust: ("minecraft:twisting_vines_plant", "minecraft:twisting_vines"),
    // rust: ("minecraft:weeping_vines_plant", "minecraft:weeping_vines"),
    // rust: ("minecraft:white_candle_cake", "minecraft:cake"),
    // rust: ("minecraft:light_blue_candle_cake", "minecraft:cake"),
    // rust: ] {
    // rust: assert_eq!(clone_item(block, "minecraft:air"), item, "{block}");
}
    // rust: assert_eq!(
    // rust: clone_item("minecraft:sweet_berries", "minecraft:sweet_berries"),
    // rust: "minecraft:sweet_berries"
    // rust: );
    // rust: assert_eq!(
    // rust: clone_item("minecraft:cake", "minecraft:cake"),
    // rust: "minecraft:cake"
    // rust: );
}
}
