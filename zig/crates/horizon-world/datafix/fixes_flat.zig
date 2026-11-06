//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fixes_flat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fixes of 1.12.2 to 1.13.2 (keys 1450 to 1624, DataVersion 1343 to 1631): the
//! flattening and what came with it. The options fixes of this range (1344, 1446)
//! are client settings, not world data.
// use std::collections::HashMap;
// use std::sync::OnceLock;

// use super::block_state_data as bsd;
// use super::chunk_leaves;
// use super::dynamic::{
    // rust: as_int, as_number, as_str, empty_map, is_list, namespaced, remove, set, stream, string,
}
// use super::flat_tables as t;
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, items, mark_read, reread, reread_as};
// use crate::nbt::{Compound, JavaString, Tag};

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(1450, 0), |cx| {
    // rust: cx.each(Ty::BlockState, |s| *s = bsd::upgrade_block_state_tag(s))
    // rust: }));
    // rust: out.push((key(1451, 1), chunk_palettes));
    // rust: out.push((key(1451, 2), piston_block_state));
    // rust: out.push((key(1451, 3), entity_block_state));
    // rust: out.push((key(1451, 3), map_id));
    // rust: out.push((key(1451, 4), block_name_flattening));
    // rust: out.push((key(1451, 4), item_flattening));
    // rust: out.push((key(1451, 5), remove_block_entity_tags));
    // rust: out.push((key(1451, 5), spawn_eggs));
    // rust: out.push((key(1451, 5), |cx| {
    // rust: cx.entity("minecraft:wolf", |e| {
    // rust: if let Some(c) = e.get("CollarColor") {
    // rust: let color = 15 - as_int(Some(c), 0);
    // rust: set(e, "CollarColor", Tag::Byte(color as i8));
}
    // rust: })
    // rust: }));
    // rust: out.push((key(1451, 5), banner_color));
    // rust: out.push((key(1451, 5), flat_generator_info));
    // rust: out.push((key(1451, 6), stats_counters));
    // rust: out.push((key(1451, 6), jukebox_record));
    // rust: out.push((key(1451, 7), villager_trades));
    // rust: out.push((key(1456, 0), |cx| {
    // rust: cx.entity("minecraft:item_frame", |e| {
    // rust: let facing = match as_int(e.get("Facing"), 0) as i8 {
    // rust: 0 => 3,
    // rust: 1 => 4,
    // rust: 3 => 5,
    // rust: _ => 2,
}
    // rust: set(e, "Facing", Tag::Byte(facing));
    // rust: })
    // rust: }));
    // rust: out.push((key(1458, 0), entity_custom_name));
    // rust: out.push((key(1458, 0), item_custom_name));
    // rust: out.push((key(1458, 0), block_entity_custom_name));
    // rust: out.push((key(1460, 0), painting_motive));
    // rust: out.push((key(1466, 0), chunk_to_protochunk));
    // rust: out.push((key(1474, 0), |cx| {
    // rust: cx.entity("minecraft:shulker", |e| {
    // rust: if as_int(e.get("Color"), 0) == 10 {
    // rust: set(e, "Color", Tag::Byte(16));
}
    // rust: })
    // rust: }));
    // rust: out.push((key(1474, 0), |cx| {
    // rust: legacy_block_rename(
    // rust: cx,
    // rust: &only("minecraft:purple_shulker_box", "minecraft:shulker_box"),
    // rust: )
    // rust: }));
    // rust: out.push((key(1474, 0), |cx| {
    // rust: item_rename(
    // rust: cx,
    // rust: &only("minecraft:purple_shulker_box", "minecraft:shulker_box"),
    // rust: )
    // rust: }));
    // rust: out.push((key(1475, 0), |cx| {
    // rust: legacy_block_rename(
    // rust: cx,
    // rust: &table(&[
    // rust: ("minecraft:flowing_water", "minecraft:water"),
    // rust: ("minecraft:flowing_lava", "minecraft:lava"),
    // rust: ]),
    // rust: )
    // rust: }));
    // rust: out.push((key(1480, 0), |cx| legacy_block_rename(cx, &table(t::CORAL))));
    // rust: out.push((key(1480, 0), |cx| item_rename(cx, &table(t::CORAL))));
    // rust: out.push((key(1483, 0), |cx| {
    // rust: entity_rename(cx, &only("minecraft:puffer_fish", "minecraft:pufferfish"))
    // rust: }));
    // rust: out.push((key(1483, 0), |cx| {
    // rust: item_rename(
    // rust: cx,
    // rust: &only(
    // rust: "minecraft:puffer_fish_spawn_egg",
    // rust: "minecraft:pufferfish_spawn_egg",
    // rust: ),
    // rust: )
    // rust: }));
    // rust: const SEAGRASS: &[(&str, &str)] = &[
    // rust: ("minecraft:sea_grass", "minecraft:seagrass"),
    // rust: ("minecraft:tall_sea_grass", "minecraft:tall_seagrass"),
    // rust: ];
    // rust: out.push((key(1484, 0), |cx| item_rename(cx, &table(SEAGRASS))));
    // rust: out.push((key(1484, 0), |cx| legacy_block_rename(cx, &table(SEAGRASS))));
    // rust: out.push((key(1484, 0), heightmap_renaming));
    // rust: out.push((key(1486, 0), |cx| entity_rename(cx, &table(t::COD_SALMON))));
    // rust: out.push((key(1486, 0), |cx| {
    // rust: item_rename(cx, &table(t::COD_SALMON_EGGS))
    // rust: }));
    // rust: const PRISMARINE: &[(&str, &str)] = &[
    // rust: (
    // rust: "minecraft:prismarine_bricks_slab",
    // rust: "minecraft:prismarine_brick_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:prismarine_bricks_stairs",
    // rust: "minecraft:prismarine_brick_stairs",
    // rust: ),
    // rust: ];
    // rust: out.push((key(1487, 0), |cx| item_rename(cx, &table(PRISMARINE))));
    // rust: out.push((key(1487, 0), |cx| {
    // rust: legacy_block_rename(cx, &table(PRISMARINE))
    // rust: }));
    // rust: out.push((key(1488, 0), |cx| {
    // rust: legacy_block_rename(
    // rust: cx,
    // rust: &table(&[
    // rust: ("minecraft:kelp_top", "minecraft:kelp"),
    // rust: ("minecraft:kelp", "minecraft:kelp_plant"),
    // rust: ]),
    // rust: )
    // rust: }));
    // rust: out.push((key(1488, 0), |cx| {
    // rust: item_rename(cx, &only("minecraft:kelp_top", "minecraft:kelp"))
    // rust: }));
    // rust: out.push((key(1488, 0), command_block_custom_name));
    // rust: out.push((key(1488, 0), command_block_minecart_custom_name));
    // rust: out.push((key(1488, 0), igloo_metadata_removal));
    // rust: out.push((key(1490, 0), |cx| {
    // rust: legacy_block_rename(cx, &only("minecraft:melon_block", "minecraft:melon"))
    // rust: }));
    // rust: out.push((key(1490, 0), |cx| {
    // rust: item_rename(
    // rust: cx,
    // rust: &table(&[
    // rust: ("minecraft:melon_block", "minecraft:melon"),
    // rust: ("minecraft:melon", "minecraft:melon_slice"),
    // rust: (
    // rust: "minecraft:speckled_melon",
    // rust: "minecraft:glistering_melon_slice",
    // rust: ),
    // rust: ]),
    // rust: )
    // rust: }));
    // rust: out.push((key(1492, 0), structure_template_rename));
    // rust: out.push((key(1494, 0), enchantment_names));
    // rust: out.push((key(1496, 0), |cx| {
    // rust: cx.each(Ty::Chunk, chunk_leaves::leaves_fix)
    // rust: }));
    // rust: out.push((key(1500, 0), |cx| {
    // rust: cx.block_entity("DUMMY", |be| set(be, "keepPacked", Tag::Byte(1)))
    // rust: }));
    // rust: out.push((key(1501, 0), advancements_rename));
    // rust: out.push((key(1502, 0), |cx| {
    // rust: rename_names(cx, Ty::Recipe, &table(t::RECIPES))
    // rust: }));
    // rust: out.push((key(1506, 0), level_generator_options));
    // rust: out.push((key(1510, 0), |cx| {
    // rust: legacy_block_rename(cx, &table(t::THE_RENAMENING_BLOCKS))
    // rust: }));
    // rust: out.push((key(1510, 0), |cx| item_rename(cx, &the_renamening_items)));
    // rust: out.push((key(1510, 0), |cx| {
    // rust: rename_names(cx, Ty::Recipe, &table(t::RECIPES_RENAMENING))
    // rust: }));
    // rust: out.push((key(1510, 0), |cx| {
    // rust: entity_rename(cx, &the_renamening_entities)
    // rust: }));
    // rust: out.push((key(1510, 0), swim_stats_rename));
    // rust: out.push((key(1514, 0), |cx| {
    // rust: display_name_to_component(cx, Ty::Objective)
    // rust: }));
    // rust: out.push((key(1514, 0), |cx| display_name_to_component(cx, Ty::Team)));
    // rust: out.push((key(1514, 0), objective_render_type));
    // rust: out.push((key(1515, 0), |cx| {
    // rust: legacy_block_rename(cx, &table(t::CORAL_FANS))
    // rust: }));
    // rust: out.push((key(1624, 0), |cx| {
    // rust: cx.each(Ty::Chunk, chunk_leaves::trapped_chest_fix)
    // rust: }));
}

// ------------------------------------------------------------------ helpers

pub fn lookup(table: *'static [(*'static str) void {
}
    // rust: table.iter().find(|(from, _)| *from == k).map(|(_, to)| *to)
}

/// `createRenamer(map)`: the id namespaced, looked up in a table.
pub fn table(entries: *'static [(*'static str) void {
}
    // rust: move |id| lookup(entries, &namespaced(id)).map(str::to_owned)
}

/// `createRenamer(from, to)`.
pub fn only(from: *'static str, to: *'static str) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |id| (namespaced(id) == from).then(|| to.to_owned())
}

pub fn rename_names(cx: *mut Cx, ty: Ty, f: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.each(ty, |v| {
    // rust: if let Some(name) = as_str(Some(v))
    // rust: && let Some(new) = f(&name)
    // rust: {
    // rust: *v = string(&new);
}
    // rust: });
}

/// `ItemRenameFix`.
pub fn item_rename(cx: *mut Cx, f: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rename_names(cx, Ty::ItemName, f);
}

/// `LegacyBlockRenameFix`: block names, block states and flat block states.
pub fn legacy_block_rename(cx: *mut Cx, f: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rename_names(cx, Ty::BlockName, f);
    // rust: cx.each(Ty::BlockState, |s| {
    // rust: if let Some(name) = as_str(s.get("Name"))
    // rust: && let Some(new) = f(&name)
    // rust: {
    // rust: set(s, "Name", string(&new));
}
    // rust: });
    // rust: cx.each(Ty::FlatBlockState, |s| {
    // rust: let Some(text) = as_str(Some(s)) else {
    // rust: return;
}
    // rust: let mut end = text.len();
    // rust: if let Some(p) = text.find('[').filter(|p| *p > 0) {
    // rust: end = p;
}
    // rust: if let Some(n) = text.find('{').filter(|n| *n > 0) {
    // rust: end = end.min(n);
}
    // rust: if let Some(new) = f(&text[..end]) {
    // rust: *s = string(&format!("{new}{}", &text[end..]));
}
    // rust: });
}

/// `SimplestEntityRenameFix`: entity ids and entity names.
pub fn entity_rename(cx: *mut Cx, f: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if let Some(id) = as_str(e.get("id"))
    // rust: && let Some(new) = f(&namespaced(&id))
    // rust: {
    // rust: set(e, "id", string(&new));
}
    // rust: });
    // rust: rename_names(cx, Ty::EntityName, f);
}

pub fn the_renamening_entities(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = namespaced(name);
    // rust: let name = match name.strip_prefix("minecraft:bred_") {
    // rust: Some(rest) => format!("minecraft:{rest}"),
    // rust: None => name,
}
    // rust: Some(lookup(t::THE_RENAMENING_ENTITIES, &name).map_or(name.clone(), str::to_owned))
}

pub fn the_renamening_items(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = namespaced(name);
    // rust: if let Some(new) = lookup(t::THE_RENAMENING_BLOCKS, &name) {
    // rust: return Some(new.to_owned());
}
    // rust: Some(
    // rust: match name.as_str() {
    // rust: "minecraft:clownfish" => "minecraft:tropical_fish",
    // rust: "minecraft:chorus_fruit_popped" => "minecraft:popped_chorus_fruit",
    // rust: "minecraft:evocation_illager_spawn_egg" => "minecraft:evoker_spawn_egg",
    // rust: "minecraft:vindication_illager_spawn_egg" => "minecraft:vindicator_spawn_egg",
    // rust: _ => return None,
}
    // rust: .to_owned(),
    // rust: )
}

/// `LegacyComponentDataFixUtils.createTextComponentJson` of a string tag's text.
pub fn text_json_units(text: *JavaString) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::String(JavaString(super::json::text_component_json(&text.0)))
}

// ------------------------------------------------------------------ 1451.1

pub fn chunk_palettes(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // The chunk is written with the old type and read with the new one: the numeric
    // block names (`DSL.intType()`) come out as ints, whatever tag they were.
    // rust: cx.each(Ty::BlockName, |v| {
    // rust: if let Some(n) = as_number(v) {
    // rust: *v = Tag::Int(n.int_value());
}
    // rust: });
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: super::chunk_flatten::fix(c);
    // rust: reread_as(Ty::Chunk, k, c);
    // rust: });
}

// ------------------------------------------------------------------ 1451.2

pub fn piston_block_state(cx: *mut Cx) void {
}
    // rust: cx.block_entity("minecraft:piston", |be| {
    // rust: let block = as_int(be.get("blockId"), 0);
    // rust: remove(be, "blockId");
    // rust: let data = as_int(be.get("blockData"), 0) & 15;
    // rust: remove(be, "blockData");
        // The new value is built from this remainder: it remembers it.
    // rust: mark_read(be);
    // rust: set(be, "blockState", bsd::get_tag(block << 4 | data));
    // rust: });
}

// ------------------------------------------------------------------ 1451.3

pub fn block_id(name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: t::BLOCK_IDS
    // rust: .iter()
    // rust: .find(|(n, _)| *n == name)
    // rust: .map_or(0, |(_, id)| *id)
}

/// The block id of a `BLOCK_NAME` value (`Either<Integer, String>`).
pub fn block_name_id(tile: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tile {
    // rust: Tag::String(s) => Some(block_id(&namespaced(&s.to_string_lossy()))),
    // rust: other => as_number(other).map(|n| n.int_value()),
}
}

/// `EntityBlockStateFix.updateBlockToBlockState`. The typed old field stays in
/// the remainder it was read from.
pub fn block_to_state(e: *mut Tag, old: []const u8, data_name: []const u8, new: []const u8) void {
}
    // rust: let block = e.get(old).and_then(block_name_id);
    // rust: let data = as_int(e.get(data_name), 0) & 15;
    // rust: if let Some(block) = block {
    // rust: set(e, new, bsd::get_tag(block << 4 | data));
}
    // rust: remove(e, data_name);
}

pub fn entity_block_state(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let Some(id) = as_str(e.get("id")) else {
    // rust: return;
}
    // rust: match namespaced(&id).as_str() {
    // rust: "minecraft:falling_block" => {
    // rust: let block = match e.get("Block") {
    // rust: Some(tile) => block_name_id(tile).unwrap_or(0),
    // rust: None => match e.get("TileID").and_then(as_number) {
    // rust: Some(n) => n.int_value(),
    // rust: None => as_int(e.get("Tile"), 0) as i8 as u8 as i32,
    // rust: },
}
    // rust: let data = as_int(e.get("Data"), 0) & 15;
    // rust: set(e, "BlockState", bsd::get_tag(block << 4 | data));
    // rust: for f in ["Data", "TileID", "Tile"] {
    // rust: remove(e, f);
}
}
    // rust: "minecraft:enderman" => {
    // rust: block_to_state(e, "carried", "carriedData", "carriedBlockState")
}
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" => {
    // rust: block_to_state(e, "inTile", "inData", "inBlockState")
}
    // rust: "minecraft:commandblock_minecart"
    // rust: | "minecraft:minecart"
    // rust: | "minecraft:chest_minecart"
    // rust: | "minecraft:furnace_minecart"
    // rust: | "minecraft:tnt_minecart"
    // rust: | "minecraft:hopper_minecart"
    // rust: | "minecraft:spawner_minecart" => {
    // rust: block_to_state(e, "DisplayTile", "DisplayData", "DisplayState")
}
    // rust: _ => {}
}
    // rust: });
}

pub fn map_id(cx: *mut Cx) void {
}
    // rust: cx.item(
    // rust: |id| id == "minecraft:filled_map",
    // rust: |s| {
    // rust: let damage = as_int(s.get("Damage"), 0);
    // rust: if !matches!(s.get("tag"), Some(Tag::Compound(_))) {
    // rust: set(s, "tag", empty_map());
}
    // rust: if let Some(tag) = s.get_mut("tag") {
    // rust: set(tag, "map", Tag::Int(damage));
}
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 1451.4

pub fn block_name_flattening(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::BlockName, |v| {
    // rust: let name = match &*v {
    // rust: Tag::String(s) => bsd::upgrade_block_name(&namespaced(&s.to_string_lossy())),
    // rust: other => match as_number(other) {
    // rust: Some(n) => bsd::upgrade_block_id(n.int_value()),
    // rust: None => return,
    // rust: },
}
    // rust: *v = string(&name);
    // rust: });
}

/// `ItemStackTheFlatteningFix.updateItem`.
pub fn update_item(name: []const u8, data: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: static MAP: OnceLock<(HashMap<&'static str, &'static str>, Vec<&'static str>)> =
    // rust: OnceLock::new();
    // rust: let (map, ids) = MAP.get_or_init(|| {
    // rust: let map: HashMap<_, _> = t::ITEM_FLATTENING.iter().copied().collect();
    // rust: let mut ids: Vec<&str> = t::ITEM_FLATTENING
    // rust: .iter()
    // rust: .map(|(k, _)| &k[..k.find('.').expect("dot")])
    // rust: .collect();
    // rust: ids.sort_unstable();
    // rust: ids.dedup();
    // rust: (map, ids)
    // rust: });
    // rust: if ids.binary_search(&name).is_err() {
    // rust: return None;
}
    // rust: map.get(format!("{name}.{data}").as_str())
    // rust: .or_else(|| map.get(format!("{name}.0").as_str()))
    // rust: .copied()
}

pub fn item_flattening(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let Some(id) = as_str(s.get("id")) else {
    // rust: return;
}
    // rust: let id = namespaced(&id);
    // rust: let data = as_int(s.get("Damage"), 0);
    // rust: if let Some(new) = update_item(&id, data) {
    // rust: set(s, "id", string(new));
}
    // rust: if t::ITEM_DAMAGE_IDS.contains(&id.as_str()) {
    // rust: if !matches!(s.get("tag"), Some(Tag::Compound(_))) {
    // rust: set(s, "tag", empty_map());
}
    // rust: if let Some(tag) = s.get_mut("tag") {
    // rust: set(tag, "Damage", Tag::Int(data));
}
}
    // rust: remove(s, "Damage");
    // rust: });
}

// ------------------------------------------------------------------ 1451.5

pub const DROPPED_BLOCK_ENTITIES: [[]const u8; 2] = ["minecraft:noteblock", "minecraft:flower_pot"];

pub fn dropped_block_entity(tag: ?*Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.and_then(|be| as_str(be.get("id")))
    // rust: .is_some_and(|id| DROPPED_BLOCK_ENTITIES.contains(&namespaced(&id).as_str()))
}

/// `RemoveBlockEntityTagFix` (legacy data structure).
pub fn remove_block_entity_tags(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: if let Some(tag) = s.get_mut("tag")
    // rust: && dropped_block_entity(tag.get("BlockEntityTag"))
    // rust: {
    // rust: remove(tag, "BlockEntityTag");
}
    // rust: });
    // rust: cx.entity("minecraft:falling_block", |e| {
    // rust: if dropped_block_entity(e.get("TileEntityData")) {
    // rust: remove(e, "TileEntityData");
}
    // rust: });
}

pub fn spawn_eggs(cx: *mut Cx) void {
}
    // rust: let input = cx.k - 1;
    // rust: cx.item(
    // rust: |id| id == "minecraft:spawn_egg",
    // rust: |s| {
            // `getOrCreateTyped`: an EntityTag that is missing, or does not read as an entity
            // of the schema, is a default entity of it (the first of its table: a wither).
    // rust: let entity_id = s
    // rust: .get("tag")
    // rust: .and_then(|t| t.get("EntityTag"))
    // rust: .filter(|e| super::schema::flat::entity_tree_known(e, input))
    // rust: .and_then(|e| as_str(e.get("id")))
    // rust: .map(|id| namespaced(&id))
    // rust: .unwrap_or_else(|| "minecraft:wither".to_owned());
    // rust: let egg = lookup(t::SPAWN_EGGS, &entity_id).unwrap_or("minecraft:pig_spawn_egg");
    // rust: set(s, "id", string(egg));
    // rust: },
    // rust: );
}

pub fn banner_color(cx: *mut Cx) void {
}
    // rust: cx.block_entity("minecraft:banner", |be| {
    // rust: if let Some(base) = be.get("Base") {
    // rust: let color = 15 - as_int(Some(base), 0);
    // rust: set(be, "Base", Tag::Int(color));
}
    // rust: if is_list(be.get("Patterns")) {
    // rust: let patterns: Vec<Tag> = stream(be.get("Patterns"))
    // rust: .into_iter()
    // rust: .map(|mut p| {
    // rust: if let Some(c) = p.get("Color") {
    // rust: let color = 15 - as_int(Some(c), 0);
    // rust: set(&mut p, "Color", Tag::Int(color));
}
    // rust: p
    // rust: })
    // rust: .collect();
    // rust: set(be, "Patterns", Tag::List(patterns));
}
    // rust: });
}

/// Guava `Splitter.on(sep).limit(n)` over a string (empty parts kept).
pub fn split_limit(s: []const u8, sep: char, limit: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.splitn(limit, sep).collect()
}

/// `NumberUtils.toInt(s, default)`.
pub fn to_int(s: []const u8, default: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.parse::<i32>().unwrap_or(default)
}

pub const DEFAULT_FLAT: []const u8 = "minecraft:bedrock,2*minecraft:dirt,minecraft:grass_block;1;village";

/// `LevelFlatGeneratorInfoFix.fixString`.
pub fn flat_generator_string(options: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if options.is_empty() {
    // rust: return DEFAULT_FLAT.to_owned();
}
    // rust: let mut parts = split_limit(options, ';', 5).into_iter();
    // rust: let first = parts.next().unwrap_or("");
    // rust: let rest: Vec<&str> = parts.collect();
    // rust: let (version, layer_info, rest) = match rest.split_first() {
    // rust: Some((layers, rest)) => (to_int(first, 0), *layers, rest.to_vec()),
    // rust: None => (0, first, Vec::new()),
}
    // rust: if !(0..=3).contains(&version) {
    // rust: return DEFAULT_FLAT.to_owned();
}
    // rust: let layers: Vec<String> = layer_info
    // rust: .split(',')
    // rust: .map(|layer| {
    // rust: let amount: Vec<&str> = if version < 3 {
    // rust: split_limit(layer, 'x', 2)
    // rust: } else {
    // rust: split_limit(layer, '*', 2)
}
    // rust: let (height, layer_type) = if amount.len() == 2 {
    // rust: (to_int(amount[0], 0), amount[1])
    // rust: } else {
    // rust: (1, amount[0])
}
    // rust: let block_parts = split_limit(layer_type, ':', 3);
    // rust: let name_index = usize::from(block_parts[0] == "minecraft");
    // rust: let block_string = block_parts.get(name_index).copied().unwrap_or("");
    // rust: let block = if version == 3 {
    // rust: block_id(&format!("minecraft:{block_string}"))
    // rust: } else {
    // rust: to_int(block_string, 0)
}
    // rust: let data_index = name_index + 1;
    // rust: let data = block_parts.get(data_index).map_or(0, |d| to_int(d, 0));
    // rust: let tag = bsd::get_tag(block << 4 | data);
    // rust: let name = as_str(tag.get("Name")).unwrap_or_default();
    // rust: format!(
    // rust: "{}{name}",
    // rust: if height == 1 {
    // rust: String::new()
    // rust: } else {
    // rust: format!("{height}*")
}
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut result = layers.join(",");
    // rust: for part in rest {
    // rust: result.push(';');
    // rust: result.push_str(part);
}
    // rust: result
}

pub fn flat_generator_info(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Level, |l| {
    // rust: if !as_str(l.get("generatorName")).is_some_and(|n| n.eq_ignore_ascii_case("flat")) {
    // rust: return;
}
    // rust: if let Some(options) = as_str(l.get("generatorOptions")) {
    // rust: set(
    // rust: l,
    // rust: "generatorOptions",
    // rust: string(&flat_generator_string(&options)),
    // rust: );
}
    // rust: });
}

// ------------------------------------------------------------------ 1451.6

/// `V1451_6.packNamespacedWithDot`.
pub fn pack_namespaced_with_dot(location: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match super::identifier(location) {
    // rust: Some((ns, path)) => format!("{ns}.{path}"),
    // rust: None => location.to_owned(),
}
}

/// `StatsCounterFix.unpackLegacyKey`: the stat type and its key.
pub fn unpack_legacy_key(k: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if t::STATS_SKIP.contains(&k) {
    // rust: return None;
}
    // rust: if let Some(custom) = lookup(t::STATS_CUSTOM, k) {
    // rust: return Some(("minecraft:custom".to_owned(), custom.to_owned()));
}
    // StringUtils.ordinalIndexOf(key, ".", 2)
    // rust: let mut dots = k.match_indices('.');
    // rust: let split = dots.nth(1)?.0;
    // rust: let prefix = &k[..split];
    // rust: let rest = k[split + 1..].replace('.', ":");
    // rust: if prefix == "stat.mineBlock" {
    // rust: return Some(("minecraft:mined".to_owned(), bsd::upgrade_block_name(&rest)));
}
    // rust: if let Some(item_key) = lookup(t::STATS_ITEM_KEYS, prefix) {
    // rust: let new = update_item(&rest, 0).map_or(rest.clone(), str::to_owned);
    // rust: return Some((item_key.to_owned(), new));
}
    // rust: if let Some(entity_key) = lookup(t::STATS_ENTITY_KEYS, prefix) {
    // rust: let new = lookup(t::STATS_ENTITIES, &rest).map_or(rest.clone(), str::to_owned);
    // rust: return Some((entity_key.to_owned(), new));
}
    // rust: None
}

pub fn stats_counters(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Stats, |stats| {
    // rust: let mut new: Vec<(String, Compound)> = Vec::new();
    // rust: if let Tag::Compound(c) = &*stats {
    // rust: for (k, v) in c {
    // rust: if as_number(v).is_none() {
    // rust: continue;
}
    // rust: let Some((ty, ty_key)) = unpack_legacy_key(&k.to_string_lossy()) else {
    // rust: continue;
}
    // rust: let slot = match new.iter().position(|(t, _)| *t == ty) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: new.push((ty, Compound::new()));
    // rust: new.len() - 1
}
}
    // rust: new[slot].1.insert(super::dynamic::key(&ty_key), v.clone());
}
}
    // rust: let map: Compound = new
    // rust: .into_iter()
    // rust: .map(|(ty, entries)| (super::dynamic::key(&ty), Tag::Compound(entries)))
    // rust: .collect();
    // rust: *stats = Tag::compound([("stats", Tag::Compound(map))]);
    // rust: });
    // rust: cx.each(Ty::Objective, |o| {
        // The output schema reads the objective again: its read hook unpacks the name.
    // rust: remove(o, "CriteriaType");
    // rust: if let Some(name) = as_str(o.get("CriteriaName")) {
    // rust: let new = if t::SPECIAL_OBJECTIVE_CRITERIA.contains(&name.as_str()) {
    // rust: name
    // rust: } else {
    // rust: match unpack_legacy_key(&name) {
    // rust: None => "dummy".to_owned(),
    // rust: Some((ty, ty_key)) => format!(
    // rust: "{}:{}",
    // rust: pack_namespaced_with_dot(&ty),
    // rust: pack_namespaced_with_dot(&ty_key)
    // rust: ),
}
}
    // rust: set(o, "CriteriaName", string(&new));
}
    // rust: super::fixes_a::unpack_objective(o);
    // rust: });
}

pub fn jukebox_record(cx: *mut Cx) void {
}
    // rust: cx.block_entity("minecraft:jukebox", |be| {
    // rust: let record = as_int(be.get("Record"), 0);
    // rust: if record <= 0 {
    // rust: return;
}
    // rust: let name = t::ITEM_IDS
    // rust: .iter()
    // rust: .find(|(id, _)| *id == record)
    // rust: .map_or("minecraft:air", |(_, n)| *n);
    // rust: if let Some(id) = update_item(name, 0) {
            // `tag.remove("Record")` is not kept: Dynamics are immutable.
    // rust: let mut stack = Tag::compound([("id", string(id)), ("Count", Tag::Byte(1))]);
    // rust: items::add_names(&mut stack);
    // rust: set(be, "RecordItem", stack);
}
    // rust: });
}

// ------------------------------------------------------------------ 1451.7

pub fn villager_trades(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::VillagerTrade, |trade| {
    // rust: for f in ["buy", "buyB", "sell"] {
    // rust: if let Some(stack) = trade.get_mut(f)
    // rust: && as_str(stack.get("id")).is_some_and(|id| id == "minecraft:carved_pumpkin")
    // rust: {
    // rust: set(stack, "id", string("minecraft:pumpkin"));
}
}
    // rust: });
}

// ------------------------------------------------------------------ 1458

pub fn entity_custom_name(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let Some(Tag::String(name)) = e.get("CustomName").cloned() else {
    // rust: return;
}
    // rust: if name.0.is_empty() {
    // rust: remove(e, "CustomName");
    // rust: reread(k, e);
    // rust: return;
}
    // rust: let id = as_str(e.get("id")).unwrap_or_default();
    // rust: let component = if id == "minecraft:commandblock_minecart" {
    // rust: Tag::String(name)
    // rust: } else {
    // rust: text_json_units(&name)
}
    // rust: set(e, "CustomName", component);
    // rust: });
}

pub fn item_custom_name(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: if let Some(display) = s.get_mut("tag").and_then(|t| t.get_mut("display"))
    // rust: && let Some(Tag::String(name)) = display.get("Name").cloned()
    // rust: {
    // rust: set(display, "Name", text_json_units(&name));
}
    // rust: });
}

    // rust: const NAMEABLE_BLOCK_ENTITIES: [&str; 11] = [
    // rust: "minecraft:beacon",
    // rust: "minecraft:banner",
    // rust: "minecraft:brewing_stand",
    // rust: "minecraft:chest",
    // rust: "minecraft:trapped_chest",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:dropper",
    // rust: "minecraft:enchanting_table",
    // rust: "minecraft:furnace",
    // rust: "minecraft:hopper",
    // rust: "minecraft:shulker_box",
    // rust: ];

/// `BlockEntityCustomNameToComponentFix.fixTagCustomName`.
pub fn fix_tag_custom_name(tag: *mut Tag) void {
}
    // rust: let name = match tag.get("CustomName") {
    // rust: Some(Tag::String(s)) => s.clone(),
    // rust: _ => JavaString(Vec::new()),
}
    // rust: if name.0.is_empty() {
    // rust: remove(tag, "CustomName");
    // rust: } else {
    // rust: set(tag, "CustomName", text_json_units(&name));
}
}

pub fn block_entity_custom_name(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if let Some(id) = as_str(be.get("id"))
    // rust: && !NAMEABLE_BLOCK_ENTITIES.contains(&namespaced(&id).as_str())
    // rust: {
    // rust: return;
}
    // rust: fix_tag_custom_name(be);
    // rust: reread_as(Ty::BlockEntity, k, be);
    // rust: });
}

// ------------------------------------------------------------------ 1460

pub fn painting_motive(cx: *mut Cx) void {
}
    // rust: cx.entity("minecraft:painting", |e| {
    // rust: if let Some(motive) = as_str(e.get("Motive")) {
    // rust: let lower = motive.to_lowercase();
    // rust: let mapped = match lower.as_str() {
    // rust: "donkeykong" => "donkey_kong",
    // rust: "burningskull" => "burning_skull",
    // rust: "skullandroses" => "skull_and_roses",
    // rust: other => other,
}
    // rust: set(e, "Motive", string(&namespaced(mapped)));
}
    // rust: });
}

// ------------------------------------------------------------------ 1466

pub fn chunk_to_protochunk(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: if let Some(level) = chunk.get_mut("Level") {
    // rust: fix_protochunk_level(level);
}
    // rust: reread_as(Ty::Chunk, k, chunk);
    // rust: });
}

pub fn fix_protochunk_level(tag: *mut Tag) void {
}
    // rust: let terrain_populated = super::dynamic::as_bool(tag.get("TerrainPopulated"), false);
    // rust: let light_populated = match tag.get("LightPopulated").and_then(as_number) {
    // rust: None => true,
    // rust: Some(_) => super::dynamic::as_bool(tag.get("LightPopulated"), false),
}
    // rust: let status = if terrain_populated {
    // rust: if light_populated {
    // rust: "mobs_spawned"
    // rust: } else {
    // rust: "decorated"
}
    // rust: } else {
    // rust: "carved"
}
    // repackBiomes
    // rust: if let Some(buffer) = super::dynamic::as_byte_buffer(tag.get("Biomes")) {
    // rust: let biomes: Vec<i32> = (0..256)
    // rust: .map(|i| buffer.get(i).map_or(0, |b| i32::from(*b)))
    // rust: .collect();
    // rust: set(tag, "Biomes", Tag::IntArray(biomes));
}
    // repackTicks
    // rust: if is_list(tag.get("TileTicks")) {
    // rust: let mut to_be_ticked: Vec<Vec<Tag>> = vec![Vec::new(); 16];
    // rust: for tick in stream(tag.get("TileTicks")) {
    // rust: let x = as_int(tick.get("x"), 0);
    // rust: let y = as_int(tick.get("y"), 0);
    // rust: let z = as_int(tick.get("z"), 0);
    // rust: let packed = (x & 15 | (y & 15) << 4 | (z & 15) << 8) as i16;
    // rust: if let Some(list) = usize::try_from(y >> 4)
    // rust: .ok()
    // rust: .and_then(|i| to_be_ticked.get_mut(i))
    // rust: {
    // rust: list.push(Tag::Short(packed));
}
}
    // rust: remove(tag, "TileTicks");
    // rust: set(
    // rust: tag,
    // rust: "ToBeTicked",
    // rust: Tag::List(to_be_ticked.into_iter().map(Tag::List).collect()),
    // rust: );
}
    // rust: set(tag, "Status", string(status));
    // rust: set(tag, "hasLegacyStructureData", Tag::Byte(1));
}

// ------------------------------------------------------------------ 1484

pub fn heightmap_renaming(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: let Some(heightmaps) = level.get_mut("Heightmaps") else {
    // rust: return;
}
    // rust: let mut moves: Vec<(&str, &[&str])> = vec![
    // rust: ("LIQUID", &["WORLD_SURFACE_WG"]),
    // rust: ("SOLID", &["OCEAN_FLOOR_WG", "OCEAN_FLOOR"]),
    // rust: ("LIGHT", &["LIGHT_BLOCKING"]),
    // rust: ("RAIN", &["MOTION_BLOCKING", "MOTION_BLOCKING_NO_LEAVES"]),
    // rust: ];
    // rust: for (from, to) in moves.drain(..) {
    // rust: if let Some(value) = remove(heightmaps, from) {
    // rust: for name in to {
    // rust: set(heightmaps, name, value.clone());
}
}
}
    // rust: });
}

// ------------------------------------------------------------------ 1488

pub fn command_block_custom_name(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // rust: cx.block_entity("minecraft:command_block", |be| {
    // rust: fix_tag_custom_name(be);
    // rust: reread_as(Ty::BlockEntity, k, be);
    // rust: });
}

pub fn command_block_minecart_custom_name(cx: *mut Cx) void {
}
    // rust: cx.entity("minecraft:commandblock_minecart", |e| {
    // rust: if let Some(Tag::String(name)) = e.get("CustomName").cloned() {
    // rust: set(e, "CustomName", text_json_units(&name));
}
    // rust: });
}

pub fn is_igloo_piece(tag: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: as_str(tag.get("id")).unwrap_or_default() == "Iglu"
}

pub fn igloo_metadata_removal(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::StructureFeature, |feature| {
    // rust: let only_igloo = is_list(feature.get("Children"))
    // rust: && stream(feature.get("Children")).iter().all(is_igloo_piece);
    // rust: if only_igloo {
    // rust: set(feature, "id", string("Igloo"));
    // rust: remove(feature, "Children");
    // rust: } else if is_list(feature.get("Children")) {
    // rust: let kept: Vec<Tag> = stream(feature.get("Children"))
    // rust: .into_iter()
    // rust: .filter(|c| !is_igloo_piece(c))
    // rust: .collect();
    // rust: set(feature, "Children", Tag::List(kept));
}
    // rust: });
}

// ------------------------------------------------------------------ 1492

pub fn structure_template_rename(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::StructureFeature, |structure| {
    // rust: if structure.get("Children").is_none() {
    // rust: return;
}
    // rust: let id = as_str(structure.get("id")).unwrap_or_default();
    // rust: let rename = t::STRUCTURE_TEMPLATE_RENAMES
    // rust: .iter()
    // rust: .find(|(s, _, _)| *s == id);
    // rust: let children: Vec<Tag> = stream(structure.get("Children"))
    // rust: .into_iter()
    // rust: .map(|mut child| {
    // rust: if let Some((_, child_id, templates)) = rename
    // rust: && as_str(child.get("id")).unwrap_or_default() == *child_id
    // rust: {
    // rust: let template = as_str(child.get("Template")).unwrap_or_default();
    // rust: let new = templates
    // rust: .iter()
    // rust: .find(|(from, _)| *from == template)
    // rust: .map_or(template.as_str(), |(_, to)| *to);
    // rust: set(&mut child, "Template", string(new));
}
    // rust: child
    // rust: })
    // rust: .collect();
    // rust: set(structure, "Children", Tag::List(children));
    // rust: });
}

// ------------------------------------------------------------------ 1494

pub fn enchantment_names(cx: *mut Cx) void {
}
    // rust: let name = |e: &Tag| {
    // rust: let id = as_int(e.get("id"), 0);
    // rust: t::ENCHANTMENTS
    // rust: .iter()
    // rust: .find(|(i, _)| *i == id)
    // rust: .map_or("null", |(_, n)| *n)
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let Some(tag) = s.get_mut("tag") else {
    // rust: return;
}
    // rust: if is_list(tag.get("ench")) {
    // rust: let list: Vec<Tag> = stream(tag.get("ench"))
    // rust: .into_iter()
    // rust: .map(|mut e| {
    // rust: let n = name(&e);
    // rust: set(&mut e, "id", string(n));
    // rust: e
    // rust: })
    // rust: .collect();
    // rust: remove(tag, "ench");
    // rust: set(tag, "Enchantments", Tag::List(list));
}
    // rust: if is_list(tag.get("StoredEnchantments")) {
    // rust: let list: Vec<Tag> = stream(tag.get("StoredEnchantments"))
    // rust: .into_iter()
    // rust: .map(|mut e| {
    // rust: let n = name(&e);
    // rust: set(&mut e, "id", string(n));
    // rust: e
    // rust: })
    // rust: .collect();
    // rust: set(tag, "StoredEnchantments", Tag::List(list));
}
    // rust: });
}

// ------------------------------------------------------------------ 1501

pub fn advancements_rename(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Advancements, |adv| {
    // rust: let Tag::Compound(c) = adv else {
    // rust: return;
}
    // rust: let entries: Vec<_> = std::mem::take(c).into_iter().collect();
    // rust: for (k, v) in entries {
    // rust: let name = k.to_string_lossy();
    // rust: let renamed = lookup(t::ADVANCEMENTS, &name).map_or(k, super::dynamic::key);
    // rust: c.insert(renamed, v);
}
    // rust: });
}

// ------------------------------------------------------------------ 1506

/// Java `String.split(regex)` with a literal separator and a limit of 0 (trailing
/// empty strings removed) or a positive limit.
    // rust: fn java_split<'a>(s: &'a str, sep: &str, limit: usize) -> Vec<&'a str> {
    // rust: let mut parts: Vec<&str> = if limit > 0 {
    // rust: s.splitn(limit, sep).collect()
    // rust: } else {
    // rust: s.split(sep).collect()
}
    // rust: if limit == 0 {
    // rust: while parts.len() > 1 && parts.last().is_some_and(|p| p.is_empty()) {
    // rust: parts.pop();
}
    // rust: if parts.len() == 1 && parts[0].is_empty() && !s.is_empty() {
    // rust: parts.clear();
}
}
    // rust: parts
}

pub fn layers_info(input: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut result = Vec::new();
    // rust: for depth in java_split(input, ",", 0) {
    // rust: let parts = java_split(depth, "*", 2);
    // rust: let height = if parts.len() == 2 {
    // rust: match parts[0].parse::<i32>() {
    // rust: Ok(h) => h,
    // rust: Err(_) => return Vec::new(),
}
    // rust: } else {
    // rust: 1
}
    // rust: result.push((height, parts[parts.len() - 1].to_owned()));
}
    // rust: result
}

/// `LevelDataGeneratorOptionsFix.convert`.
pub fn flat_options(flat: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut parts = flat.split(';');
    // rust: let mut biome = "minecraft:plains".to_owned();
    // rust: let mut structures: Vec<(String, Vec<(String, String)>)> = Vec::new();
    // rust: let layers: Vec<(i32, String)>;
    // rust: let first = parts.next();
    // rust: if !flat.is_empty() && first.is_some() {
    // rust: layers = layers_info(first.unwrap_or(""));
    // rust: if !layers.is_empty() {
    // rust: if let Some(b) = parts.next() {
    // rust: biome = lookup(t::GENERATOR_BIOMES, b)
    // rust: .unwrap_or("minecraft:plains")
    // rust: .to_owned();
}
    // rust: if let Some(list) = parts.next() {
    // rust: for structure in java_split(&list.to_lowercase(), ",", 0) {
    // rust: let separated = java_split(structure, "(", 2);
    // rust: if separated.is_empty() || separated[0].is_empty() {
    // rust: continue;
}
    // rust: let mut options = Vec::new();
    // rust: if separated.len() > 1 && separated[1].ends_with(')') && separated[1].len() > 1
    // rust: {
    // rust: let inner = &separated[1][..separated[1].len() - 1];
    // rust: for part in java_split(inner, " ", 0) {
    // rust: let split = java_split(part, "=", 2);
    // rust: if split.len() == 2 {
    // rust: options.push((split[0].to_owned(), split[1].to_owned()));
}
}
}
    // rust: structures.retain(|(n, _)| n != separated[0]);
    // rust: structures.push((separated[0].to_owned(), options));
}
    // rust: } else {
    // rust: structures.push(("village".to_owned(), Vec::new()));
}
}
    // rust: } else {
    // rust: layers = vec![
    // rust: (1, "minecraft:bedrock".to_owned()),
    // rust: (2, "minecraft:dirt".to_owned()),
    // rust: (1, "minecraft:grass_block".to_owned()),
    // rust: ];
    // rust: structures.push(("village".to_owned(), Vec::new()));
}
    // rust: let layers = Tag::List(
    // rust: layers
    // rust: .into_iter()
    // rust: .map(|(h, b)| Tag::compound([("height", Tag::Int(h)), ("block", string(&b))]))
    // rust: .collect(),
    // rust: );
    // rust: let structures: Compound = structures
    // rust: .into_iter()
    // rust: .map(|(name, options)| {
    // rust: let options: Compound = options
    // rust: .into_iter()
    // rust: .map(|(k, v)| (super::dynamic::key(&k), string(&v)))
    // rust: .collect();
    // rust: (
    // rust: super::dynamic::key(&name.to_lowercase()),
    // rust: Tag::Compound(options),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: Tag::compound([
    // rust: ("layers", layers),
    // rust: ("biome", string(&biome)),
    // rust: ("structures", Tag::Compound(structures)),
    // rust: ])
}

pub fn level_generator_options(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Level, |level| {
    // rust: let options = as_str(level.get("generatorOptions"));
    // rust: let name = as_str(level.get("generatorName")).unwrap_or_default();
    // rust: if name.eq_ignore_ascii_case("flat") {
    // rust: let converted = flat_options(options.as_deref().unwrap_or(""));
    // rust: set(level, "generatorOptions", converted);
    // rust: } else if name.eq_ignore_ascii_case("buffet")
    // rust: && let Some(options) = options
    // rust: {
    // rust: let units: Vec<u16> = options.encode_utf16().collect();
    // rust: if let Some(json) = super::json::parse_lenient(&units)
    // rust: && let Some(tag) = super::json::to_nbt(&json)
    // rust: {
    // rust: set(level, "generatorOptions", tag);
}
}
    // rust: let _ = k;
    // rust: });
}

// ------------------------------------------------------------------ 1510, 1514

pub fn swim_stats_rename(cx: *mut Cx) void {
}
    // rust: const RENAMES: &[(&str, &str)] = &[
    // rust: ("minecraft:swim_one_cm", "minecraft:walk_on_water_one_cm"),
    // rust: ("minecraft:dive_one_cm", "minecraft:walk_under_water_one_cm"),
    // rust: ];
    // rust: cx.each(Ty::Stats, |stats| {
    // rust: if let Some(custom) = stats
    // rust: .get_mut("stats")
    // rust: .and_then(|s| s.get_mut("minecraft:custom"))
    // rust: && let Tag::Compound(c) = custom
    // rust: {
    // rust: let entries: Vec<_> = std::mem::take(c).into_iter().collect();
    // rust: for (k, v) in entries {
    // rust: let renamed = lookup(RENAMES, &k.to_string_lossy()).map_or(k, super::dynamic::key);
    // rust: c.insert(renamed, v);
}
}
    // rust: });
    // rust: cx.each(Ty::Objective, |o| {
    // rust: if let Some(ct) = o.get_mut("CriteriaType")
    // rust: && as_str(ct.get("type")).as_deref() == Some("minecraft:custom")
    // rust: && let Some(id) = as_str(ct.get("id"))
    // rust: && let Some(new) = lookup(RENAMES, &id)
    // rust: {
    // rust: set(ct, "id", string(new));
}
    // rust: });
}

pub fn display_name_to_component(cx: *mut Cx, ty: Ty) void {
}
    // rust: cx.each(ty, |v| {
    // rust: if let Some(Tag::String(name)) = v.get("DisplayName").cloned() {
    // rust: set(v, "DisplayName", text_json_units(&name));
}
    // rust: });
}

pub fn objective_render_type(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Objective, |o| {
    // rust: if as_str(o.get("RenderType")).is_none() {
    // rust: let criteria = as_str(o.get("CriteriaName")).unwrap_or_default();
    // rust: let render = if criteria == "health" {
    // rust: "hearts"
    // rust: } else {
    // rust: "integer"
}
    // rust: set(o, "RenderType", string(render));
}
    // rust: });
}
