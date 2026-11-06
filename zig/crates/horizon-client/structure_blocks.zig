//! Transpiled from Horizon Rust crate
//! Module: horizon-client_structure_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Block entities placed by world generation (structure chests, barrels and
//! template containers): turned into client containers, with loot tables
//! unpacked as `RandomizableContainer.unpackLootTable` would on first open.
// use crate::{containers::BlockEntity, items::ItemStack};
// use horizon_world::{
    // rust: loot::LootData,
    // rust: nbt::{Compound, JavaString, Tag},
    // rust: worldgen::generator::ProtoChunk,
}
// use std::{
    // rust: path::Path,
    // rust: sync::{Arc, Mutex},
}

/// The `custom_data` key holding an exploration map's search until the game
/// runs it (vanilla runs `ExplorationMapFunction` when the chest is unpacked,
/// on first open; here loot is rolled with the chunk).
pub const PENDING_MAP: []const u8 = "horizon:exploration_map";
pub const CUSTOM_DATA: []const u8 = "minecraft:custom_data";

/// A generated chest's item, with its exploration map search kept in
/// `minecraft:custom_data` (which vanilla loads as is).
pub fn loot_item(s: *horizon_world::loot::LootStack) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut item = ItemStack {
    // rust: item: Arc::from(s.item.as_str()),
    // rust: count: s.count.max(0) as u32,
    // rust: damage: s.damage.max(0) as u32,
    // rust: extra: None,
}
    // rust: if let Some(map) = &s.exploration {
    // rust: let search = Tag::compound([
    // rust: ("destination", Tag::String(map.destination.as_str().into())),
    // rust: ("decoration", Tag::String(map.decoration.as_str().into())),
    // rust: ("zoom", Tag::Byte(map.zoom as i8)),
    // rust: ("search_radius", Tag::Int(map.search_radius)),
    // rust: (
    // rust: "skip_existing_chunks",
    // rust: Tag::Byte(i8::from(map.skip_existing_chunks)),
    // rust: ),
    // rust: ]);
    // rust: item.data_mut()
    // rust: .other
    // rust: .push((CUSTOM_DATA.into(), Tag::compound([(PENDING_MAP, search)])));
}
    // rust: item
}

/// A rolled stack as an item with its enchantments (stored ones on a
/// book), potion and ominous bottle level.
pub fn loot_item_with_components(s: *horizon_world::loot::LootStack) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut item = loot_item(s);
    // rust: for (id, level) in &s.enchantments {
    // rust: let level = (*level).max(0) as u32;
    // rust: if &*item.item == "minecraft:enchanted_book" {
    // rust: crate::item_data::set_level(&mut item.data_mut().stored_enchantments, id, level);
    // rust: } else {
    // rust: item.enchant(id, level);
}
}
    // rust: if let Some(potion) = &s.potion {
    // rust: item = item.with_potion(potion);
}
    // rust: if let Some(level) = s.ominous_amplifier.filter(|l| *l > 0) {
    // rust: item.data_mut().ominous_amplifier = Some(level.clamp(0, 4) as u8);
}
    // set_stew_effect's `suspicious_stew_effects`.
    // rust: for (effect, duration) in &s.stew_effects {
    // rust: item.data_mut()
    // rust: .stew_effects
    // rust: .push((Arc::from(effect.as_str()), *duration));
}
    // rust: for (id, text) in &s.names {
    // rust: item.data_mut().set_loot_name(id, text);
}
    // rust: for (id, value) in &s.components {
    // rust: item.data_mut().set_loot_component(id, value);
}
    // rust: item
}

/// The exploration map search an item still waits for, removed from it.
pub fn take_pending_map(item: *mut ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = item.extra.as_deref_mut()?;
    // rust: let i = data
    // rust: .other
    // rust: .iter()
    // rust: .position(|(k, t)| k == CUSTOM_DATA && t.get(PENDING_MAP).is_some())?;
    // rust: let (_, mut custom) = data.other.remove(i);
    // rust: let search = match &mut custom {
    // rust: Tag::Compound(c) => c.remove(&JavaString::from(PENDING_MAP))?,
    // rust: _ => return None,
}
    // rust: if matches!(&custom, Tag::Compound(c) if !c.is_empty()) {
    // rust: data.other.insert(i, (CUSTOM_DATA.into(), custom));
}
    // rust: let text = |k: &str| match search.get(k) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: let int = |k: &str| match search.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: Some(horizon_world::loot::ExplorationMap {
    // rust: destination: text("destination")?,
    // rust: decoration: text("decoration")?,
    // rust: zoom: int("zoom").unwrap_or(2).clamp(0, 4) as u8,
    // rust: search_radius: int("search_radius").unwrap_or(50),
    // rust: skip_existing_chunks: int("skip_existing_chunks").unwrap_or(1) != 0,
    // rust: })
}

/// Whether an item still waits for its exploration map search.
pub fn has_pending_map(item: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item.data().is_some_and(|d| {
    // rust: d.other
    // rust: .iter()
    // rust: .any(|(k, t)| k == CUSTOM_DATA && t.get(PENDING_MAP).is_some())
    // rust: })
}

/// The loot data and the [`loot_key`] it was loaded for; None until
/// `loot_data` runs. `Some((_, None))` when the tables failed to load.
    // rust: type LoadedLoot = (u64, Option<Arc<LootData>>);
pub const LOOT: Mutex<?LoadedLoot> = Mutex::new(None);

/// The resource root and the packs' files the loot data was loaded from.
pub fn loot_key(root: *Path, overlay: *horizon_world::loot::PackOverlay) u {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::hash::{DefaultHasher, Hash, Hasher};
    // rust: let mut hasher = DefaultHasher::new();
    // rust: root.hash(&mut hasher);
    // rust: overlay.files.hash(&mut hasher);
    // rust: hasher.finish()
}

pub fn load_loot(root: *Path, overlay: *horizon_world::loot::PackOverlay) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = match LootData::load(root, overlay) {
    // rust: Ok(data) => Some(Arc::new(data)),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: loot tables unavailable, structure containers stay empty: {e}");
    // rust: None
}
}
    // rust: (loot_key(root, overlay), data)
}

/// Loot data of the resource root with the world's packs over it, loaded
/// once per process (a world open with other packs, or `/reload`, loads it
/// again).
pub fn loot_data(root: *Path, overlay: *horizon_world::loot::PackOverlay) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut loot = LOOT.lock().unwrap_or_else(|e| e.into_inner());
    // rust: loot.get_or_insert_with(|| load_loot(root, overlay))
    // rust: .1
    // rust: .clone()
}

/// [`loot_data`] for a world being opened: the copy already loaded when it
/// came from the same root and packs (world generation loads it first, with
/// no packs; a second copy held 8 MB for the whole run), else a fresh one.
    // rust: pub fn world_loot_data(
    // rust: root: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> Option<Arc<LootData>> {
    // rust: reuse_or_load(
    // rust: &mut LOOT.lock().unwrap_or_else(|e| e.into_inner()),
    // rust: root,
    // rust: overlay,
    // rust: )
}

    // rust: fn reuse_or_load(
    // rust: loot: &mut Option<LoadedLoot>,
    // rust: root: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> Option<Arc<LootData>> {
    // rust: let key = loot_key(root, overlay);
    // rust: if loot.as_ref().is_none_or(|(loaded, _)| *loaded != key) {
    // rust: *loot = Some(load_loot(root, overlay));
}
    // rust: loot.as_ref().and_then(|(_, data)| data.clone())
}

/// The loot data `loot_data` loaded, if it ran.
pub fn loaded_loot_data() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LOOT.lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .as_ref()
    // rust: .and_then(|(_, data)| data.clone())
}

/// Let go of the loot data: for a preload no world used
/// (game/world_loading.rs). The next `loot_data` loads it again.
pub fn forget_loot_data() void {
}
    // rust: *LOOT.lock().unwrap_or_else(|e| e.into_inner()) = None;
}

/// `RandomizableContainer.unpackLootTable` of a container at `pos`: `table`
/// rolled into `slots`. A missing or zero seed is the level's random in
/// vanilla; Horizon derives one from the position. Without loot data the
/// container stays empty and still saves its table.
    // rust: pub fn roll_container(
    // rust: slots: &mut [Option<ItemStack>],
    // rust: loot: Option<&LootData>,
    // rust: table: String,
    // rust: saved_seed: Option<i64>,
    // rust: pos: (i32, i32, i32),
    // rust: biome: &str,
    // rust: ) -> crate::save::RolledLoot {
    // rust: let seed = saved_seed.filter(|s| *s != 0).unwrap_or_else(|| {
    // rust: horizon_core::random::position_seed(horizon_core::position::BlockPos::new(
    // rust: pos.0, pos.1, pos.2,
    // rust: ))
    // rust: });
    // rust: if let Some(loot) = loot {
        // LootTable.fill spreads the items over the container's own size.
    // rust: let rolled = loot.fill(&table, seed, slots.len(), Some(biome));
    // rust: for (slot, stack) in slots.iter_mut().zip(rolled) {
            // With what the rolls put on them: enchantments
            // (enchant_with_levels in End city chests), potions and an
            // ominous bottle's level.
    // rust: *slot = stack.map(|s| loot_item_with_components(&s));
}
}
    // rust: crate::save::RolledLoot {
    // rust: pos,
    // rust: table,
    // rust: seed: saved_seed,
    // rust: items: crate::save::encode_items(slots),
}
}

/// A saved `LootTableSeed`, if any.
pub fn loot_seed(nbt: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match nbt.get("LootTableSeed") {
    // rust: Some(Tag::Long(seed)) => Some(*seed),
    // rust: _ => None,
}
}

pub fn text(nbt: *Compound, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match nbt.get(&JavaString::from(key)) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}

/// The client block entity for one of a chunk's generated block entities,
/// before a container's loot is unpacked: `StructureTemplate.placeInWorld`
/// hands the template's block entity NBT to `loadWithComponents`, which is
/// what a chunk load does with a saved one.
pub fn generated_block_entity(block: []const u8, nbt: *Compound) O {
    // Implementation ported from Horizon
    return undefined;
}
    // A mod sign has no vanilla block name; its saved entity id is still vanilla's.
    // rust: let fallback = BlockEntity::for_block(block).or_else(|| {
    // rust: let id = text(nbt, "id")?;
    // rust: if !block.starts_with("minecraft:")
    // rust: && matches!(id.as_str(), "minecraft:sign" | "minecraft:hanging_sign")
    // rust: {
    // rust: BlockEntity::for_block(&id)
    // rust: } else {
    // rust: None
}
    // rust: })?;
    // rust: let mut tag = nbt.clone();
    // RandomizableContainer.tryLoadLootTable: with a table the items are not read.
    // rust: if text(&tag, "LootTable").is_some() {
    // rust: tag.remove(&JavaString::from("Items"));
}
    // Programmatic block entities (and a template that saved none) carry no id.
    // rust: if !tag.contains_key(&JavaString::from("id")) {
    // rust: tag.insert("id".into(), Tag::String(fallback.id().into()));
}
    // rust: for axis in ["x", "y", "z"] {
    // rust: tag.insert(axis.into(), Tag::Int(0));
}
    // A saved kind the client cannot decode keeps the block's own entity.
    // rust: Some(
    // rust: crate::save::decode_block_entity(&Tag::Compound(tag))
    // rust: .map_or(fallback, |(_, entity)| entity),
    // rust: )
}

/// Client block entities for the generated block entities of a chunk, and the
/// loot rolled into its containers.
    // rust: pub fn block_entities(
    // rust: chunk: &ProtoChunk,
    // rust: loot: Option<&LootData>,
    // rust: ) -> (
    // rust: Vec<((i32, i32, i32), BlockEntity)>,
    // rust: Vec<crate::save::RolledLoot>,
    // rust: ) {
    // rust: let mut out = Vec::new();
    // rust: let mut rolled = Vec::new();
    // rust: for (pos, nbt) in &chunk.block_entities {
    // rust: let [x, y, z] = *pos;
    // rust: let block = chunk.block_name(x, y, z);
    // rust: let Some(mut entity) = generated_block_entity(block, nbt) else {
    // rust: continue;
}
    // rust: if let (BlockEntity::Chest(slots), Some(table)) = (&mut entity, text(nbt, "LootTable")) {
    // rust: let seed = loot_seed(&Tag::Compound(nbt.clone()));
    // rust: rolled.push(roll_container(
    // rust: slots,
    // rust: loot,
    // rust: table,
    // rust: seed,
    // rust: (x, y, z),
    // rust: chunk.biome_at(x, y, z),
    // rust: ));
}
    // rust: out.push(((x, y, z), entity));
}
    // rust: (out, rolled)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::loot::{ExplorationMap, LootStack};

pub fn a_saved_mod_sign_uses_its_vanilla_entity_type() void {
}
    // rust: for hanging in [false, true] {
    // rust: let mut sign = crate::signs::SignData {
    // rust: hanging,
    // rust: ..Default::default()
}
    // rust: sign.front.lines[0] = "Front".into();
    // rust: sign.back.lines[0] = "Back".into();
    // rust: sign.front.color = 9;
    // rust: sign.back.glowing = true;
    // rust: sign.waxed = true;
    // rust: let mut nbt: Compound = sign
    // rust: .encode()
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k.into(), v))
    // rust: .collect();
    // rust: nbt.insert("id".into(), Tag::String(sign.id().into()));
    // rust: let Some(BlockEntity::Sign(loaded)) = generated_block_entity("test:notice", &nbt)
    // rust: else {
    // rust: panic!("saved sign missing");
}
    // rust: assert_eq!(loaded, sign);
    // rust: assert!(generated_block_entity("minecraft:stone", &nbt).is_none());
}
    // rust: assert!(generated_block_entity("test:road_sign", &Compound::new()).is_none());
}

pub fn generated_end_gateway_keeps_its_exit() void {
}
    // rust: let Tag::Compound(nbt) = Tag::compound([
    // rust: ("exit_portal", Tag::IntArray(vec![100, 50, 0])),
    // rust: ("ExactTeleport", Tag::Byte(1)),
    // rust: ]) else {
    // rust: unreachable!()
}
    // rust: let Some(BlockEntity::EndGateway(g)) =
    // rust: generated_block_entity("minecraft:end_gateway", &nbt)
    // rust: else {
    // rust: panic!("gateway");
}
    // rust: assert_eq!(g.exit_portal, Some([100, 50, 0]));
    // rust: assert!(g.exact_teleport);
}

pub fn placed_chest_loot_keeps_its_enchantments_and_potions() void {
}
    // rust: let stack =
    // rust: |item: &str, enchantments: Vec<(String, i32)>, potion: Option<&str>| LootStack {
    // rust: item: item.into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: enchantments,
    // rust: potion: potion.map(str::to_owned),
    // rust: map: false,
    // rust: exploration: None,
    // rust: ominous_amplifier: None,
    // rust: stew_effects: Vec::new(),
    // rust: names: Vec::new(),
    // rust: components: Vec::new(),
}
        // An End city chest's enchant_with_levels roll.
    // rust: let boots = loot_item_with_components(&stack(
    // rust: "minecraft:diamond_boots",
    // rust: vec![
    // rust: ("minecraft:protection".into(), 3),
    // rust: ("minecraft:unbreaking".into(), 2),
    // rust: ],
    // rust: None,
    // rust: ));
    // rust: assert_eq!(boots.enchantments().len(), 2);
        // A book's go into stored_enchantments.
    // rust: let book = loot_item_with_components(&stack(
    // rust: "minecraft:enchanted_book",
    // rust: vec![("minecraft:mending".into(), 1)],
    // rust: None,
    // rust: ));
    // rust: assert!(book.enchantments().is_empty());
    // rust: assert_eq!(book.stored_enchantments().len(), 1);
    // rust: let arrow = loot_item_with_components(&stack(
    // rust: "minecraft:tipped_arrow",
    // rust: Vec::new(),
    // rust: Some("minecraft:slowness"),
    // rust: ));
    // rust: assert_eq!(arrow.potion(), Some("minecraft:slowness"));
}

    /// Opening a world keeps the loot data world generation loaded when the
    /// packs are the same, and loads it again when they differ.
pub fn a_world_open_reuses_loot_data_of_the_same_packs() void {
}
//         use horizon_world::loot::PackOverlay;
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-reuse-{}", std::process::id()));
    // rust: std::fs::create_dir_all(root.join("data/minecraft/loot_table")).unwrap();
    // rust: std::fs::write(root.join("items.json"), "{}").unwrap();
    // rust: let mut slot = None;
    // rust: let first = reuse_or_load(&mut slot, &root, &PackOverlay::NONE).expect("loot data");
    // rust: let again = reuse_or_load(&mut slot, &root, &PackOverlay::NONE).unwrap();
    // rust: assert!(Arc::ptr_eq(&first, &again));
    // rust: let files = [(
    // rust: "loot_table/chests/x".to_owned(),
    // rust: vec![br#"{"pools": []}"#.to_vec()],
    // rust: )];
    // rust: let packs = PackOverlay { files: &files };
    // rust: let other = reuse_or_load(&mut slot, &root, &packs).unwrap();
    // rust: assert!(!Arc::ptr_eq(&first, &other));
    // rust: let _ = std::fs::remove_dir_all(&root);
}

pub fn a_container_rolled_without_loot_data_saves_its_table() void {
}
    // rust: let mut slots = vec![None; 27];
    // rust: let rolled = roll_container(
    // rust: &mut slots,
    // rust: None,
    // rust: "minecraft:chests/simple_dungeon".into(),
    // rust: Some(7),
    // rust: (1, 2, 3),
    // rust: "minecraft:plains",
    // rust: );
    // rust: let mut saved = horizon_world::nbt::Compound::new();
    // rust: saved.insert("Items".into(), crate::save::encode_items(&slots));
    // rust: assert!(rolled.restore(&mut saved));
    // rust: assert!(!saved.contains_key(&"Items".into()));
    // rust: assert_eq!(saved.get(&"LootTableSeed".into()), Some(&Tag::Long(7)));
}

pub fn exploration_maps_wait_in_custom_data_until_searched() void {
}
    // rust: let mut stack = LootStack {
    // rust: item: "minecraft:buried_treasure_map".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: enchantments: Vec::new(),
    // rust: potion: None,
    // rust: map: true,
    // rust: exploration: Some(Box::new(ExplorationMap::from_json(&serde_json::json!({
    // rust: "decoration": "minecraft:red_x",
    // rust: "destination": "#minecraft:on_treasure_maps",
    // rust: "skip_existing_chunks": false,
    // rust: "zoom": 1
    // rust: })))),
    // rust: ominous_amplifier: None,
    // rust: stew_effects: Vec::new(),
    // rust: names: Vec::new(),
    // rust: components: Vec::new(),
}
    // rust: let mut item = loot_item(&stack);
    // rust: assert!(has_pending_map(&item));
        // The rest of custom_data stays.
    // rust: if let Some(Tag::Compound(c)) = item
    // rust: .data_mut()
    // rust: .other
    // rust: .iter_mut()
    // rust: .find(|(k, _)| k == CUSTOM_DATA)
    // rust: .map(|(_, t)| t)
    // rust: {
    // rust: c.insert("note".into(), Tag::Int(7));
}
    // rust: let map = take_pending_map(&mut item).unwrap();
    // rust: assert_eq!(
    // rust: map,
    // rust: ExplorationMap {
    // rust: destination: "minecraft:on_treasure_maps".into(),
    // rust: decoration: "minecraft:red_x".into(),
    // rust: zoom: 1,
    // rust: search_radius: 50,
    // rust: skip_existing_chunks: false,
}
    // rust: );
    // rust: assert!(!has_pending_map(&item));
    // rust: assert!(take_pending_map(&mut item).is_none());
    // rust: let custom = &item.data().unwrap().other;
    // rust: assert_eq!(custom.len(), 1);
    // rust: assert_eq!(custom[0].1.get("note"), Some(&Tag::Int(7)));
        // Only the search: the component goes away with it.
    // rust: stack.item = "minecraft:abandoned_camp_map".into();
    // rust: let mut item = loot_item(&stack);
    // rust: take_pending_map(&mut item).unwrap();
    // rust: assert!(item.data().unwrap().other.is_empty());
        // A plain item has nothing pending.
    // rust: stack.exploration = None;
    // rust: assert!(!has_pending_map(&loot_item(&stack)));
}

    /// The End cities' tower tops save their banners' patterns in the
    /// template; the placed banner must keep them (`EndCityPieces`).
pub fn a_generated_banner_keeps_its_template_patterns() void {
}
    // rust: let patterns = Tag::List(vec![
    // rust: Tag::compound([
    // rust: ("color", Tag::String("black".into())),
    // rust: ("pattern", Tag::String("minecraft:triangle_top".into())),
    // rust: ]),
    // rust: Tag::compound([
    // rust: ("color", Tag::String("black".into())),
    // rust: ("pattern", Tag::String("minecraft:triangle_bottom".into())),
    // rust: ]),
    // rust: ]);
    // rust: let nbt = Tag::compound([
    // rust: ("id", Tag::String("minecraft:banner".into())),
    // rust: ("patterns", patterns),
    // rust: ]);
    // rust: let Tag::Compound(nbt) = nbt else {
    // rust: unreachable!()
}
    // rust: let Some(BlockEntity::Banner(banner)) =
    // rust: generated_block_entity("minecraft:magenta_banner", &nbt)
    // rust: else {
    // rust: panic!("a banner block makes a banner block entity");
}
    // rust: assert_eq!(banner.layers.len(), 2);
    // rust: assert_eq!(&*banner.layers[0].pattern, "minecraft:triangle_top");
    // rust: assert_eq!(&*banner.layers[1].pattern, "minecraft:triangle_bottom");
    // rust: assert_eq!(&*banner.layers[0].color, "black");
        // A banner the template saved without patterns stays bare.
    // rust: let Some(BlockEntity::Banner(bare)) =
    // rust: generated_block_entity("minecraft:white_banner", &Compound::new())
    // rust: else {
    // rust: panic!("a banner block makes a banner block entity");
}
    // rust: assert!(bare.layers.is_empty());
}
}
