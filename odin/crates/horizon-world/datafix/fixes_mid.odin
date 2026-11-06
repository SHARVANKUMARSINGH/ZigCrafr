//! Transpiled from Horizon Rust crate
package horizon_world_fixes_mid

import "core:fmt"
import "core:mem"
import "core:math"

// Fixes of 1.15 and 1.16 (keys 2100 to 2571): what worlds saved by 1.14.4 to
// 1.16.5 need before the fixes of [`super::fixes_cliffs`].
// use super::dynamic::{
    // rust: as_bool, as_double, as_int, as_long, as_long_stream, as_number, as_str, ceillog2, namespaced,
    // rust: remove, set, stream, string,
}
// use super::fixes_a::attributes_rename_legacy;
// use super::fixes_b::advancements_rename;
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, id_is, renamer};
// use crate::nbt::{Compound, JavaString, Tag};

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(1800, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[
    // rust: ("minecraft:cactus_green", "minecraft:green_dye"),
    // rust: ("minecraft:rose_red", "minecraft:red_dye"),
    // rust: ("minecraft:dandelion_yellow", "minecraft:yellow_dye"),
    // rust: ]),
    // rust: )
    // rust: }));
    // rust: out.push((key(1802, 0), |cx| {
    // rust: super::fixes_a::block_rename(
    // rust: cx,
    // rust: &[
    // rust: ("minecraft:stone_slab", "minecraft:smooth_stone_slab"),
    // rust: ("minecraft:sign", "minecraft:oak_sign"),
    // rust: ("minecraft:wall_sign", "minecraft:oak_wall_sign"),
    // rust: ],
    // rust: )
    // rust: }));
    // rust: out.push((key(1802, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[
    // rust: ("minecraft:stone_slab", "minecraft:smooth_stone_slab"),
    // rust: ("minecraft:sign", "minecraft:oak_sign"),
    // rust: ]),
    // rust: )
    // rust: }));
    // rust: out.push((key(1803, 0), item_lore));
    // rust: out.push((key(1904, 0), cat_split));
    // rust: out.push((key(1905, 0), |cx| {
    // rust: level_status(cx, |status| {
    // rust: (status == "postprocessed").then_some("fullchunk")
    // rust: })
    // rust: }));
    // rust: out.push((key(1911, 0), |cx| {
    // rust: level_status(cx, |status| {
    // rust: Some(match status {
    // rust: "structure_references" | "biomes" => "empty",
    // rust: "base" => "surface",
    // rust: "carved" => "carvers",
    // rust: "liquid_carved" => "liquid_carvers",
    // rust: "decorated" => "features",
    // rust: "lighted" => "light",
    // rust: "mobs_spawned" => "spawn",
    // rust: "finalized" => "heightmaps",
    // rust: "fullchunk" => "full",
    // rust: _ => "empty",
    // rust: })
    // rust: })
    // rust: }));
    // rust: out.push((key(1914, 0), |cx| {
    // rust: cx.block_entity("minecraft:chest", |be| {
    // rust: if as_str(be.get("LootTable")).as_deref() == Some("minecraft:chests/village_blacksmith")
    // rust: {
    // rust: set(
    // rust: be,
    // rust: "LootTable",
    // rust: string("minecraft:chests/village/village_weaponsmith"),
    // rust: );
}
    // rust: })
    // rust: }));
    // rust: out.push((key(1917, 0), |cx| {
    // rust: cx.entity("minecraft:cat", |e| {
    // rust: if as_int(e.get("CatType"), 0) == 9 {
    // rust: set(e, "CatType", Tag::Int(10));
}
    // rust: })
    // rust: }));
    // rust: out.push((key(1918, 0), |cx| villager_data(cx, "minecraft:villager")));
    // rust: out.push((key(1918, 0), |cx| {
    // rust: villager_data(cx, "minecraft:zombie_villager")
    // rust: }));
    // rust: out.push((key(1920, 0), new_village));
    // rust: out.push((key(1925, 0), |cx| {
    // rust: cx.each(Ty::SavedMapIndex, |root| {
    // rust: let old = std::mem::replace(root, Tag::End);
    // rust: *root = Tag::compound([("data", old)]);
    // rust: })
    // rust: }));
    // rust: out.push((key(1928, 0), |cx| {
    // rust: entity_rename(cx, "minecraft:illager_beast", "minecraft:ravager")
    // rust: }));
    // rust: out.push((key(1928, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[(
    // rust: "minecraft:illager_beast_spawn_egg",
    // rust: "minecraft:ravager_spawn_egg",
    // rust: )]),
    // rust: )
    // rust: }));
    // rust: out.push((key(1946, 0), reorganize_poi));
    // rust: out.push((key(1948, 0), ominous_banner_item));
    // rust: out.push((key(1953, 0), ominous_banner_block_entity));
    // rust: out.push((key(1955, 0), villager_level_and_xp));
    // rust: out.push((key(1955, 0), zombie_villager_xp));
    // rust: out.push((key(1961, 0), |cx| {
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: if let Some(level) = c.get_mut("Level") {
    // rust: remove(level, "isLightOn");
}
    // rust: })
    // rust: }));
    // rust: out.push((key(1963, 0), |cx| {
    // rust: cx.entity("minecraft:villager", |e| {
    // rust: map_elements_filter(e, "Gossips", |g| {
    // rust: as_str(g.get("Type")).as_deref() != Some("golem")
    // rust: });
    // rust: })
    // rust: }));
    // rust: out.push((key(2100, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::Recipe,
    // rust: renamer(&[("minecraft:sugar", "minecraft:sugar_from_sugar_cane")]),
    // rust: )
    // rust: }));
    // rust: out.push((key(2100, 0), |cx| {
    // rust: advancements_rename_table(
    // rust: cx,
    // rust: &[(
    // rust: "minecraft:recipes/misc/sugar",
    // rust: "minecraft:recipes/misc/sugar_from_sugar_cane",
    // rust: )],
    // rust: )
    // rust: }));
    // rust: out.push((key(2202, 0), chunk_biomes));
    // rust: out.push((key(2209, 0), |cx| {
    // rust: let t: &[(&str, &'static str)] = &[("minecraft:bee_hive", "minecraft:beehive")];
    // rust: cx.rename(Ty::ItemName, renamer(t));
    // rust: poi_type_rename(cx, t);
    // rust: }));
    // rust: out.push((key(2209, 0), |cx| {
    // rust: super::fixes_a::block_rename(cx, &[("minecraft:bee_hive", "minecraft:beehive")])
    // rust: }));
    // rust: out.push((key(2211, 0), structure_reference_count));
    // rust: out.push((key(2218, 0), force_poi_rebuild));
    // rust: out.push((key(2501, 0), furnace_recipes));
    // rust: out.push((key(2503, 0), wall_property));
    // rust: out.push((key(2503, 0), |cx| {
    // rust: advancements_rename_table(
    // rust: cx,
    // rust: &[(
    // rust: "minecraft:recipes/misc/composter",
    // rust: "minecraft:recipes/decorations/composter",
    // rust: )],
    // rust: )
    // rust: }));
    // rust: out.push((key(2505, 0), |cx| memory_expiry(cx, "minecraft:villager")));
    // rust: out.push((key(2508, 0), |cx| cx.rename(Ty::ItemName, renamer(FUNGUS))));
    // rust: out.push((key(2508, 0), |cx| super::fixes_a::block_rename(cx, FUNGUS)));
    // rust: out.push((key(2509, 0), |cx| {
    // rust: entity_rename(cx, "minecraft:zombie_pigman", "minecraft:zombified_piglin")
    // rust: }));
    // rust: out.push((key(2509, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[(
    // rust: "minecraft:zombie_pigman_spawn_egg",
    // rust: "minecraft:zombified_piglin_spawn_egg",
    // rust: )]),
    // rust: )
    // rust: }));
    // rust: out.push((key(2511, 0), projectile_owner));
    // `SplashPotionItemFieldRenameFix` casts the thrown potion to the type whose
    // item stack field is `Item`: the typed `Potion` value takes its place, and
    // writing the entity gives `Potion` back from the map it was read from.
    // rust: out.push((key(2511, 1), |cx| {
    // rust: cx.entity("minecraft:potion", |e| {
    // rust: if let Some(item) = e.get("Potion").cloned() {
    // rust: set(e, "Item", item);
}
    // rust: super::drop_typed(e, "Potion");
    // rust: })
    // rust: }));
    // rust: out.push((key(2514, 0), entity_uuids));
    // rust: out.push((key(2514, 0), block_entity_uuids));
    // rust: out.push((key(2514, 0), player_uuids));
    // rust: out.push((key(2514, 0), level_uuids));
    // rust: out.push((key(2514, 0), raids_uuids));
    // rust: out.push((key(2514, 0), item_stack_uuids));
    // rust: out.push((key(2516, 0), |cx| gossip_uuids(cx, "minecraft:villager")));
    // rust: out.push((key(2516, 0), |cx| {
    // rust: gossip_uuids(cx, "minecraft:zombie_villager")
    // rust: }));
    // rust: out.push((key(2518, 0), jigsaw_properties));
    // rust: out.push((key(2518, 0), jigsaw_rotation));
    // rust: out.push((key(2523, 0), |cx| {
    // rust: attributes_rename_legacy(cx, &|name| {
    // rust: ATTRIBUTES
    // rust: .iter()
    // rust: .find(|(from, _)| *from == name)
    // rust: .map(|(_, to)| *to)
    // rust: })
    // rust: }));
    // rust: out.push((key(2527, 0), bit_storage_align));
    // rust: out.push((key(2528, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[
    // rust: ("minecraft:soul_fire_torch", "minecraft:soul_torch"),
    // rust: ("minecraft:soul_fire_lantern", "minecraft:soul_lantern"),
    // rust: ]),
    // rust: )
    // rust: }));
    // rust: out.push((key(2528, 0), |cx| {
    // rust: super::fixes_a::block_rename(
    // rust: cx,
    // rust: &[
    // rust: ("minecraft:soul_fire_torch", "minecraft:soul_torch"),
    // rust: (
    // rust: "minecraft:soul_fire_wall_torch",
    // rust: "minecraft:soul_wall_torch",
    // rust: ),
    // rust: ("minecraft:soul_fire_lantern", "minecraft:soul_lantern"),
    // rust: ],
    // rust: )
    // rust: }));
    // rust: out.push((key(2529, 0), strider_gravity));
    // rust: out.push((key(2531, 0), redstone_wire));
    // rust: out.push((key(2533, 0), villager_follow_range));
    // rust: out.push((key(2535, 0), shulker_rotation));
    // rust: out.push((key(2537, 0), legacy_dimension_id));
    // rust: out.push((key(2538, 0), level_legacy_world_gen_settings));
    // rust: out.push((key(2550, 0), world_gen_settings));
    // rust: out.push((key(2552, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::Biome,
    // rust: renamer(&[("minecraft:nether", "minecraft:nether_wastes")]),
    // rust: )
    // rust: }));
    // rust: out.push((key(2553, 0), |cx| cx.rename(Ty::Biome, renamer(BIOMES))));
}

    // rust: const FUNGUS: &[(&str, &str)] = &[
    // rust: ("minecraft:warped_fungi", "minecraft:warped_fungus"),
    // rust: ("minecraft:crimson_fungi", "minecraft:crimson_fungus"),
    // rust: ];

// `AdvancementsRenameFix` with a `createRenamer` table.
advancements_rename_table :: proc(cx: ^Cx, table: ^'static [(string) {
}
    // rust: advancements_rename(cx, &|id| {
    // rust: let id = namespaced(id);
    // rust: table
    // rust: .iter()
    // rust: .find(|(from, _)| *from == id)
    // rust: .map(|(_, to)| (*to).to_owned())
    // rust: });
}

// `SimplestEntityRenameFix`: the id of the entities and the entity names.
entity_rename :: proc(cx: ^Cx, from: string, to: ^'static str) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if id_is(e, from) {
    // rust: set(e, "id", string(to));
}
    // rust: });
    // rust: cx.rename(Ty::EntityName, |name| {
    // rust: (namespaced(name) == from).then_some(to)
    // rust: });
}

// `PoiTypeRenameFix`.
poi_type_rename :: proc(cx: ^Cx, table: ^[(string) {
}
    // rust: let r = renamer(table);
    // rust: cx.each(Ty::PoiChunk, |poi| {
    // rust: let Some(Tag::Compound(sections)) = poi.get_mut("Sections") else {
    // rust: return;
}
    // rust: for section in sections.values_mut() {
    // rust: let Some(Tag::List(records)) = section.get_mut("Records") else {
    // rust: continue;
}
    // rust: for record in records {
    // rust: if let Some(t) = as_str(record.get("type"))
    // rust: && let Some(new) = r(&t)
    // rust: {
    // rust: set(record, "type", string(new));
}
}
}
    // rust: });
}

// `ChunkBiomeFix`: the 256 biomes of a column become 1024 (a 4x4x64 grid).
chunk_biomes :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: let Some(level) = c.get_mut("Level") else {
    // rust: return;
}
    // rust: let Some(old) = super::dynamic::as_int_stream(level.get("Biomes")) else {
    // rust: return;
}
    // rust: if old.len() != 256 {
    // rust: return;
}
    // rust: let mut new = vec![0i32; 1024];
    // rust: for z in 0..4 {
    // rust: for x in 0..4 {
    // rust: let (ox, oz) = ((x << 2) + 2, (z << 2) + 2);
    // rust: new[z << 2 | x] = old[oz << 4 | ox];
}
}
    // rust: for y in 1..64 {
    // rust: new.copy_within(0..16, y * 16);
}
    // rust: set(level, "Biomes", Tag::IntArray(new));
    // rust: });
}

// `StructureReferenceCountFix`.
structure_reference_count :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::StructureFeature, |s| {
    // rust: if let Some(r) = s.get("references") {
    // rust: let n = as_number(r)
    // rust: .map(|n| n.int_value())
    // rust: .filter(|n| *n > 0)
    // rust: .unwrap_or(1);
    // rust: set(s, "references", Tag::Int(n));
}
    // rust: });
}

// `ForcePoiRebuild`: every POI section loses its `Valid` flag.
force_poi_rebuild :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::PoiChunk, |poi| {
    // rust: if let Some(Tag::Compound(sections)) = poi.get_mut("Sections") {
    // rust: for section in sections.values_mut() {
    // rust: remove(section, "Valid");
}
}
    // rust: });
}

// `FurnaceRecipeFix`: `RecipeLocation<i>`/`RecipeAmount<i>` pairs become the
// `RecipesUsed` map.
furnace_recipes :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if ![
    // rust: "minecraft:furnace",
    // rust: "minecraft:blast_furnace",
    // rust: "minecraft:smoker",
    // rust: ]
    // rust: .iter()
    // rust: .any(|id| id_is(be, id))
    // rust: {
    // rust: return;
}
    // rust: let size = as_int(be.get("RecipesUsedSize"), 0);
    // rust: remove(be, "RecipesUsedSize");
    // rust: let mut used = Compound::new();
    // rust: for i in 0..size {
    // rust: let location = remove(be, &format!("RecipeLocation{i}"));
    // rust: let amount = remove(be, &format!("RecipeAmount{i}"));
    // rust: let amount = as_int(amount.as_ref(), 0);
    // rust: if amount > 0
    // rust: && let Some(location) = location.as_ref().and_then(|l| as_str(Some(l)))
    // rust: {
    // rust: used.insert(
    // rust: JavaString::from(namespaced(&location).as_str()),
    // rust: Tag::Int(amount),
    // rust: );
}
}
    // rust: set(be, "RecipesUsed", Tag::Compound(used));
    // rust: });
}

    // rust: const WALLS: [&str; 14] = [
    // rust: "minecraft:andesite_wall",
    // rust: "minecraft:brick_wall",
    // rust: "minecraft:cobblestone_wall",
    // rust: "minecraft:diorite_wall",
    // rust: "minecraft:end_stone_brick_wall",
    // rust: "minecraft:granite_wall",
    // rust: "minecraft:mossy_cobblestone_wall",
    // rust: "minecraft:mossy_stone_brick_wall",
    // rust: "minecraft:nether_brick_wall",
    // rust: "minecraft:prismarine_wall",
    // rust: "minecraft:red_nether_brick_wall",
    // rust: "minecraft:red_sandstone_wall",
    // rust: "minecraft:sandstone_wall",
    // rust: "minecraft:stone_brick_wall",
    // rust: ];

// `WallPropertyFix`: `true`/`false` sides become `low`/`none`.
wall_property :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::BlockState, |state| {
    // rust: let Some(name) = as_str(state.get("Name")) else {
    // rust: return;
}
    // rust: if !WALLS.contains(&name.as_str()) {
    // rust: return;
}
    // rust: if let Some(props) = state.get_mut("Properties") {
    // rust: for side in ["east", "west", "north", "south"] {
    // rust: if let Some(v) = props.get(side)
    // rust: && let Some(s) = as_str(Some(v))
    // rust: {
    // rust: let new = if s == "true" { "low" } else { "none" };
    // rust: set(props, side, string(new));
}
}
}
    // rust: });
}

// `MemoryExpiryDataFix`: every memory of a brain is wrapped as `{value: ...}`.
memory_expiry :: proc(cx: ^Cx, entity: string) {
}
    // rust: cx.entity(entity, |e| {
    // rust: let Some(brain) = e.get_mut("Brain") else {
    // rust: return;
}
    // rust: if let Some(Tag::Compound(memories)) = brain.get_mut("memories") {
    // rust: for value in memories.values_mut() {
    // rust: let inner = std::mem::replace(value, Tag::End);
    // rust: *value = Tag::compound([("value", inner)]);
}
}
    // rust: });
}

// `EntityProjectileOwnerFix`: the owner of a projectile as a UUID int array.
projectile_owner :: proc(cx: ^Cx) {
}
    // rust: let uuid = |most: i64, least: i64| -> Option<Tag> {
    // rust: (most != 0 && least != 0).then(|| {
    // rust: Tag::IntArray(vec![
    // rust: (most >> 32) as i32,
    // rust: most as i32,
    // rust: (least >> 32) as i32,
    // rust: least as i32,
    // rust: ])
    // rust: })
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let Some(id) = as_str(e.get("id")).map(|i| namespaced(&i)) else {
    // rust: return;
}
    // rust: match id.as_str() {
    // rust: "minecraft:egg"
    // rust: | "minecraft:ender_pearl"
    // rust: | "minecraft:experience_bottle"
    // rust: | "minecraft:snowball"
    // rust: | "minecraft:potion" => {
    // rust: let (m, l) = e
    // rust: .get("owner")
    // rust: .map_or((0, 0), |o| (as_long(o.get("M"), 0), as_long(o.get("L"), 0)));
    // rust: if let Some(u) = uuid(m, l) {
    // rust: set(e, "OwnerUUID", u);
}
    // rust: remove(e, "owner");
}
    // rust: "minecraft:llama_spit" => {
    // rust: let (m, l) = e.get("Owner").map_or((0, 0), |o| {
    // rust: (
    // rust: as_long(o.get("OwnerUUIDMost"), 0),
    // rust: as_long(o.get("OwnerUUIDLeast"), 0),
    // rust: )
    // rust: });
    // rust: if let Some(u) = uuid(m, l) {
    // rust: set(e, "OwnerUUID", u);
}
    // rust: remove(e, "Owner");
}
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" | "minecraft:trident" => {
    // rust: let m = as_long(e.get("OwnerUUIDMost"), 0);
    // rust: let l = as_long(e.get("OwnerUUIDLeast"), 0);
    // rust: if let Some(u) = uuid(m, l) {
    // rust: set(e, "OwnerUUID", u);
}
    // rust: remove(e, "OwnerUUIDMost");
    // rust: remove(e, "OwnerUUIDLeast");
}
    // rust: _ => {}
}
    // rust: });
}

// ------------------------------------------------------------------ 2514, 2516

uuid_tag :: proc(most: i64, least: i64) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::IntArray(vec![
    // rust: (most >> 32) as i32,
    // rust: most as i32,
    // rust: (least >> 32) as i32,
    // rust: least as i32,
    // rust: ])
}

// `AbstractUUIDFix.createUUIDFromLongs`.
uuid_from_longs :: proc(tag: ^Tag, most: string, least: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let m = as_long(tag.get(most), 0);
    // rust: let l = as_long(tag.get(least), 0);
    // rust: (m != 0 && l != 0).then(|| uuid_tag(m, l))
}

// `AbstractUUIDFix.replaceUUIDLeastMost`.
replace_least_most :: proc(tag: ^Tag, old: string, new: string) {
}
    // rust: let (most, least) = (format!("{old}Most"), format!("{old}Least"));
    // rust: if let Some(uuid) = uuid_from_longs(tag, &most, &least) {
    // rust: remove(tag, &most);
    // rust: remove(tag, &least);
    // rust: set(tag, new, uuid);
}
}

// `AbstractUUIDFix.replaceUUIDMLTag`.
replace_ml :: proc(tag: ^Tag, old: string, new: string) {
}
    // rust: if let Some(uuid) = tag.get(old).and_then(|t| uuid_from_longs(t, "M", "L")) {
    // rust: remove(tag, old);
    // rust: set(tag, new, uuid);
}
}

// `UUID.fromString`, which takes five hexadecimal groups of any length.
parse_uuid :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if s.len() > 36 {
    // rust: return None;
}
    // rust: let mut parts = [0i64; 5];
    // rust: let mut count = 0;
    // rust: for part in s.split('-') {
    // rust: if count == 5 || part.is_empty() || !part.bytes().all(|b| b.is_ascii_hexdigit()) {
    // rust: return None;
}
    // rust: parts[count] = i64::from_str_radix(part, 16).ok()?;
    // rust: count += 1;
}
    // rust: (count == 5).then(|| {
    // rust: let most = (parts[0] & 0xffff_ffff) << 32 | (parts[1] & 0xffff) << 16 | (parts[2] & 0xffff);
    // rust: let least = (parts[3] & 0xffff) << 48 | (parts[4] & 0xffff_ffff_ffff);
    // rust: (most, least)
    // rust: })
}

// `AbstractUUIDFix.replaceUUIDString`.
replace_uuid_string :: proc(tag: ^Tag, old: string, new: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((m, l)) = as_str(tag.get(old)).as_deref().and_then(parse_uuid) else {
    // rust: return false;
}
    // rust: remove(tag, old);
    // rust: set(tag, new, uuid_tag(m, l));
    // rust: true
}

// A field that is present becomes the list of its elements mapped by `f`.
map_elements :: proc(tag: ^Tag, field: string, mut f: impl FnMut(Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(v) = tag.get_mut(field) {
    // rust: *v = Tag::List(stream(Some(v)).into_iter().map(&mut f).collect());
}
}

// `EntityUUIDFix.updateLivingEntity`.
living_entity_uuids :: proc(tag: ^Tag) {
}
    // rust: map_elements(tag, "Attributes", |mut attribute| {
    // rust: map_elements(&mut attribute, "Modifiers", |mut modifier| {
    // rust: replace_least_most(&mut modifier, "UUID", "UUID");
    // rust: modifier
    // rust: });
    // rust: attribute
    // rust: });
}

mob_uuids :: proc(tag: ^Tag) {
}
    // rust: living_entity_uuids(tag);
    // rust: if let Some(leash) = tag.get_mut("Leash") {
    // rust: replace_least_most(leash, "UUID", "UUID");
}
}

animal_uuids :: proc(tag: ^Tag) {
}
    // rust: mob_uuids(tag);
    // rust: replace_least_most(tag, "LoveCause", "LoveCause");
}

    // rust: const ABSTRACT_HORSES: &[&str] = &[
    // rust: "minecraft:donkey",
    // rust: "minecraft:horse",
    // rust: "minecraft:llama",
    // rust: "minecraft:mule",
    // rust: "minecraft:skeleton_horse",
    // rust: "minecraft:trader_llama",
    // rust: "minecraft:zombie_horse",
    // rust: ];
TAMEABLE_ANIMALS :: &["minecraft:cat", "minecraft:parrot", "minecraft:wolf"]
    // rust: const ANIMALS: &[&str] = &[
    // rust: "minecraft:bee",
    // rust: "minecraft:chicken",
    // rust: "minecraft:cow",
    // rust: "minecraft:fox",
    // rust: "minecraft:mooshroom",
    // rust: "minecraft:ocelot",
    // rust: "minecraft:panda",
    // rust: "minecraft:pig",
    // rust: "minecraft:polar_bear",
    // rust: "minecraft:rabbit",
    // rust: "minecraft:sheep",
    // rust: "minecraft:turtle",
    // rust: "minecraft:hoglin",
    // rust: ];
    // rust: const MOBS: &[&str] = &[
    // rust: "minecraft:bat",
    // rust: "minecraft:blaze",
    // rust: "minecraft:cave_spider",
    // rust: "minecraft:cod",
    // rust: "minecraft:creeper",
    // rust: "minecraft:dolphin",
    // rust: "minecraft:drowned",
    // rust: "minecraft:elder_guardian",
    // rust: "minecraft:ender_dragon",
    // rust: "minecraft:enderman",
    // rust: "minecraft:endermite",
    // rust: "minecraft:evoker",
    // rust: "minecraft:ghast",
    // rust: "minecraft:giant",
    // rust: "minecraft:guardian",
    // rust: "minecraft:husk",
    // rust: "minecraft:illusioner",
    // rust: "minecraft:magma_cube",
    // rust: "minecraft:pufferfish",
    // rust: "minecraft:zombified_piglin",
    // rust: "minecraft:salmon",
    // rust: "minecraft:shulker",
    // rust: "minecraft:silverfish",
    // rust: "minecraft:skeleton",
    // rust: "minecraft:slime",
    // rust: "minecraft:snow_golem",
    // rust: "minecraft:spider",
    // rust: "minecraft:squid",
    // rust: "minecraft:stray",
    // rust: "minecraft:tropical_fish",
    // rust: "minecraft:vex",
    // rust: "minecraft:villager",
    // rust: "minecraft:iron_golem",
    // rust: "minecraft:vindicator",
    // rust: "minecraft:pillager",
    // rust: "minecraft:wandering_trader",
    // rust: "minecraft:witch",
    // rust: "minecraft:wither",
    // rust: "minecraft:wither_skeleton",
    // rust: "minecraft:zombie",
    // rust: "minecraft:zombie_villager",
    // rust: "minecraft:phantom",
    // rust: "minecraft:ravager",
    // rust: "minecraft:piglin",
    // rust: ];
    // rust: const PROJECTILES: &[&str] = &[
    // rust: "minecraft:arrow",
    // rust: "minecraft:dragon_fireball",
    // rust: "minecraft:firework_rocket",
    // rust: "minecraft:fireball",
    // rust: "minecraft:llama_spit",
    // rust: "minecraft:small_fireball",
    // rust: "minecraft:snowball",
    // rust: "minecraft:spectral_arrow",
    // rust: "minecraft:egg",
    // rust: "minecraft:ender_pearl",
    // rust: "minecraft:experience_bottle",
    // rust: "minecraft:potion",
    // rust: "minecraft:trident",
    // rust: "minecraft:wither_skull",
    // rust: ];

// `EntityUUIDFix`.
entity_uuids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let Some(id) = as_str(e.get("id")).map(|i| namespaced(&i)) else {
            // Without an id no choice matches; the UUID is still fixed.
    // rust: replace_least_most(e, "UUID", "UUID");
    // rust: return;
}
    // rust: let id = id.as_str();
    // rust: replace_least_most(e, "UUID", "UUID");
    // rust: if ABSTRACT_HORSES.contains(&id) || TAMEABLE_ANIMALS.contains(&id) {
    // rust: animal_uuids(e);
    // rust: replace_uuid_string(e, "OwnerUUID", "Owner");
}
    // rust: if ANIMALS.contains(&id) {
    // rust: animal_uuids(e);
}
    // rust: if MOBS.contains(&id) {
    // rust: mob_uuids(e);
}
    // rust: if id == "minecraft:armor_stand" {
    // rust: living_entity_uuids(e);
}
    // rust: if PROJECTILES.contains(&id)
    // rust: && let Some(owner) = remove(e, "OwnerUUID")
    // rust: {
    // rust: set(e, "Owner", owner);
}
    // rust: match id {
    // rust: "minecraft:bee" | "minecraft:zombified_piglin" => {
    // rust: replace_uuid_string(e, "HurtBy", "HurtBy");
}
    // rust: "minecraft:fox" => {
    // rust: if e.get("TrustedUUIDs").is_some() {
    // rust: let trusted: Vec<Tag> = stream(e.get("TrustedUUIDs"))
    // rust: .into_iter()
    // rust: .map(|t| uuid_from_longs(&t, "M", "L").unwrap_or(t))
    // rust: .collect();
    // rust: remove(e, "TrustedUUIDs");
    // rust: set(e, "Trusted", Tag::List(trusted));
}
}
    // rust: "minecraft:item" => {
    // rust: replace_ml(e, "Owner", "Owner");
    // rust: replace_ml(e, "Thrower", "Thrower");
}
    // rust: "minecraft:shulker_bullet" => {
    // rust: replace_ml(e, "Owner", "Owner");
    // rust: replace_ml(e, "Target", "Target");
}
    // rust: "minecraft:area_effect_cloud" | "minecraft:evoker_fangs" => {
    // rust: replace_least_most(e, "OwnerUUID", "Owner");
}
    // rust: "minecraft:zombie_villager" => {
    // rust: replace_least_most(e, "ConversionPlayer", "ConversionPlayer")
}
    // rust: "minecraft:piglin" => {
    // rust: if let Some(angry) = e
    // rust: .get_mut("Brain")
    // rust: .and_then(|b| b.get_mut("memories"))
    // rust: .and_then(|m| m.get_mut("minecraft:angry_at"))
    // rust: {
    // rust: replace_uuid_string(angry, "value", "value");
}
}
    // rust: _ => {}
}
    // rust: });
}

// `BlockEntityUUIDFix`.
block_entity_uuids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if id_is(be, "minecraft:conduit") {
    // rust: replace_ml(be, "target_uuid", "Target");
}
    // rust: if id_is(be, "minecraft:skull")
    // rust: && let Some(mut owner) = remove(be, "Owner")
    // rust: {
    // rust: replace_uuid_string(&mut owner, "Id", "Id");
    // rust: set(be, "SkullOwner", owner);
}
    // rust: });
}

// `PlayerUUIDFix`.
player_uuids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Player, |p| {
    // rust: if let Some(vehicle) = p.get_mut("RootVehicle") {
    // rust: replace_least_most(vehicle, "Attach", "Attach");
}
    // rust: living_entity_uuids(p);
    // rust: replace_least_most(p, "UUID", "UUID");
    // rust: });
}

// `LevelUUIDFix`.
level_uuids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |level| {
    // rust: if let Some(Tag::Compound(dimensions)) = level.get_mut("DimensionData") {
    // rust: for dimension in dimensions.values_mut() {
    // rust: if let Some(fight) = dimension.get_mut("DragonFight") {
    // rust: replace_least_most(fight, "DragonUUID", "Dragon");
}
}
}
    // rust: replace_uuid_string(level, "WanderingTraderId", "WanderingTraderId");
    // rust: if let Some(Tag::Compound(events)) = level.get_mut("CustomBossEvents") {
    // rust: for event in events.values_mut() {
    // rust: map_elements(event, "Players", |player| {
    // rust: uuid_from_longs(&player, "M", "L").unwrap_or(player)
    // rust: });
}
}
    // rust: });
}

// `SavedDataUUIDFix` (raids).
raids_uuids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedRaids, |saved| {
    // rust: let Some(data) = saved.get_mut("data") else {
    // rust: return;
}
    // rust: map_elements(data, "Raids", |mut raid| {
    // rust: map_elements(&mut raid, "HeroesOfTheVillage", |hero| {
    // rust: uuid_from_longs(&hero, "UUIDMost", "UUIDLeast").unwrap_or(hero)
    // rust: });
    // rust: raid
    // rust: });
    // rust: });
}

// `ItemStackUUIDFix`.
item_stack_uuids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |stack| {
    // rust: let head =
    // rust: as_str(stack.get("id")).is_some_and(|id| namespaced(&id) == "minecraft:player_head");
    // rust: let Some(tag) = stack.get_mut("tag") else {
    // rust: return;
}
    // rust: map_elements(tag, "AttributeModifiers", |mut modifier| {
    // rust: replace_least_most(&mut modifier, "UUID", "UUID");
    // rust: modifier
    // rust: });
    // rust: if head && let Some(owner) = tag.get_mut("SkullOwner") {
    // rust: replace_uuid_string(owner, "Id", "Id");
}
    // rust: });
}

// `GossipUUIDFix`.
gossip_uuids :: proc(cx: ^Cx, entity: string) {
}
    // rust: cx.entity(entity, |e| {
    // rust: if let Some(gossips) = e.get_mut("Gossips")
    // rust: && crate::datafix::dynamic::is_list(Some(gossips))
    // rust: {
    // rust: *gossips = Tag::List(
    // rust: stream(Some(gossips))
    // rust: .into_iter()
    // rust: .map(|mut g| {
    // rust: replace_least_most(&mut g, "Target", "Target");
    // rust: g
    // rust: })
    // rust: .collect(),
    // rust: );
}
    // rust: });
}

// ------------------------------------------------------------------ 2518 to 2535

// `JigsawPropertiesFix`.
jigsaw_properties :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:jigsaw", |be| {
    // rust: let name = super::dynamic::as_string(be.get("attachement_type"), "minecraft:empty");
    // rust: let pool = super::dynamic::as_string(be.get("target_pool"), "minecraft:empty");
    // rust: set(be, "name", string(&name));
    // rust: set(be, "target", string(&name));
    // rust: remove(be, "attachement_type");
    // rust: set(be, "pool", string(&pool));
    // rust: remove(be, "target_pool");
    // rust: });
}

// `LegacyJigsawRotationFix`.
jigsaw_rotation :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::BlockState, |state| {
    // rust: if as_str(state.get("Name")).is_none_or(|n| namespaced(&n) != "minecraft:jigsaw") {
    // rust: return;
}
    // rust: if let Some(props) = state.get_mut("Properties") {
    // rust: let facing = super::dynamic::as_string(props.get("facing"), "north");
    // rust: let orientation = match facing.as_str() {
    // rust: "down" => "down_south",
    // rust: "up" => "up_north",
    // rust: "north" => "north_up",
    // rust: "south" => "south_up",
    // rust: "west" => "west_up",
    // rust: "east" => "east_up",
    // rust: other => other,
}
    // rust: remove(props, "facing");
    // rust: set(props, "orientation", string(orientation));
}
    // rust: });
}

    // rust: const ATTRIBUTES: &[(&str, &str)] = &[
    // rust: ("generic.maxHealth", "minecraft:generic.max_health"),
    // rust: ("Max Health", "minecraft:generic.max_health"),
    // rust: (
    // rust: "zombie.spawnReinforcements",
    // rust: "minecraft:zombie.spawn_reinforcements",
    // rust: ),
    // rust: (
    // rust: "Spawn Reinforcements Chance",
    // rust: "minecraft:zombie.spawn_reinforcements",
    // rust: ),
    // rust: ("horse.jumpStrength", "minecraft:horse.jump_strength"),
    // rust: ("Jump Strength", "minecraft:horse.jump_strength"),
    // rust: ("generic.followRange", "minecraft:generic.follow_range"),
    // rust: ("Follow Range", "minecraft:generic.follow_range"),
    // rust: (
    // rust: "generic.knockbackResistance",
    // rust: "minecraft:generic.knockback_resistance",
    // rust: ),
    // rust: (
    // rust: "Knockback Resistance",
    // rust: "minecraft:generic.knockback_resistance",
    // rust: ),
    // rust: ("generic.movementSpeed", "minecraft:generic.movement_speed"),
    // rust: ("Movement Speed", "minecraft:generic.movement_speed"),
    // rust: ("generic.flyingSpeed", "minecraft:generic.flying_speed"),
    // rust: ("Flying Speed", "minecraft:generic.flying_speed"),
    // rust: ("generic.attackDamage", "minecraft:generic.attack_damage"),
    // rust: (
    // rust: "generic.attackKnockback",
    // rust: "minecraft:generic.attack_knockback",
    // rust: ),
    // rust: ("generic.attackSpeed", "minecraft:generic.attack_speed"),
    // rust: (
    // rust: "generic.armorToughness",
    // rust: "minecraft:generic.armor_toughness",
    // rust: ),
    // rust: ];

// `BitStorageAlignFix.addPadding`: values stored without crossing longs.
    // rust: pub(super) fn add_padding(size: usize, bits: usize, data: &[i64]) -> Vec<i64> {
    // rust: let length = data.len();
    // rust: if length == 0 {
    // rust: return Vec::new();
}
    // rust: let mask = (1i64 << bits) - 1;
    // rust: let per_long = 64 / bits;
    // rust: let required = size.div_ceil(per_long);
    // rust: let mut result = vec![0i64; required];
    // rust: let mut out_index = 0;
    // rust: let mut out_start = 0;
    // rust: let mut out_data = 0i64;
    // rust: let mut current_index = 0;
    // rust: let mut current = data[0];
    // rust: let mut next = if length > 1 { data[1] } else { 0 };
    // rust: for index in 0..size {
    // rust: let position = index * bits;
    // rust: let start_data = position >> 6;
    // rust: let end_data = ((index + 1) * bits - 1) >> 6;
    // rust: let start_bit = position ^ (start_data << 6);
    // rust: if start_data != current_index {
    // rust: current = next;
    // rust: next = if start_data + 1 < length {
    // rust: data[start_data + 1]
    // rust: } else {
    // rust: 0
}
    // rust: current_index = start_data;
}
    // rust: let value = if start_data == end_data {
    // rust: ((current as u64) >> start_bit) as i64 & mask
    // rust: } else {
    // rust: let shift = 64 - start_bit;
    // rust: ((((current as u64) >> start_bit) as i64) | next.wrapping_shl(shift as u32)) & mask
}
    // rust: let out_end = out_start + bits;
    // rust: if out_end >= 64 {
    // rust: result[out_index] = out_data;
    // rust: out_index += 1;
    // rust: out_data = value;
    // rust: out_start = bits;
    // rust: } else {
    // rust: out_data |= value << out_start;
    // rust: out_start = out_end;
}
}
    // rust: if out_data != 0 {
    // rust: result[out_index] = out_data;
}
    // rust: result
}

align_storage :: proc(tag: ^Tag, field: string, size: uint, bits: uint) {
}
    // rust: if let Some(v) = tag.get_mut(field) {
    // rust: let input = as_long_stream(Some(v)).unwrap_or_default();
    // rust: *v = Tag::LongArray(add_padding(size, bits, &input));
}
}

// `BitStorageAlignFix`: block states and heightmaps no longer cross longs.
bit_storage_align :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: let Some(level) = c.get_mut("Level") else {
    // rust: return;
}
    // rust: if let Some(Tag::List(sections)) = level.get_mut("Sections") {
    // rust: for section in sections {
    // rust: let Some(Tag::List(palette)) = section.get("Palette") else {
    // rust: continue;
}
    // rust: let bits = 4.max(ceillog2(palette.len())) as usize;
    // rust: if bits & (bits - 1) != 0 {
    // rust: align_storage(section, "BlockStates", 4096, bits);
}
}
}
    // rust: if let Some(Tag::Compound(heightmaps)) = level.get_mut("Heightmaps") {
    // rust: for heightmap in heightmaps.values_mut() {
    // rust: let input = as_long_stream(Some(heightmap)).unwrap_or_default();
    // rust: *heightmap = Tag::LongArray(add_padding(256, 9, &input));
}
}
    // rust: });
}

// `StriderGravityFix`.
strider_gravity :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:strider", |e| {
    // rust: if as_bool(e.get("NoGravity"), false) {
    // rust: set(e, "NoGravity", Tag::Byte(0));
}
    // rust: });
}

// `RedstoneWireConnectionsFix`.
redstone_wire :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::BlockState, |state| {
    // rust: if as_str(state.get("Name")).as_deref() != Some("minecraft:redstone_wire") {
    // rust: return;
}
    // rust: let Some(props) = state.get_mut("Properties") else {
    // rust: return;
}
    // rust: let side = |props: &Tag, name: &str| super::dynamic::as_string(props.get(name), "none");
    // rust: let (east, west, north, south) = (
    // rust: side(props, "east"),
    // rust: side(props, "west"),
    // rust: side(props, "north"),
    // rust: side(props, "south"),
    // rust: );
    // rust: let connected = |s: &str| s != "none";
    // rust: let east_west = connected(&east) || connected(&west);
    // rust: let north_south = connected(&north) || connected(&south);
    // rust: let fixed = [
    // rust: (
    // rust: "east",
    // rust: if !connected(&east) && !north_south {
    // rust: "side"
    // rust: } else {
    // rust: &east
    // rust: },
    // rust: ),
    // rust: (
    // rust: "west",
    // rust: if !connected(&west) && !north_south {
    // rust: "side"
    // rust: } else {
    // rust: &west
    // rust: },
    // rust: ),
    // rust: (
    // rust: "north",
    // rust: if !connected(&north) && !east_west {
    // rust: "side"
    // rust: } else {
    // rust: &north
    // rust: },
    // rust: ),
    // rust: (
    // rust: "south",
    // rust: if !connected(&south) && !east_west {
    // rust: "side"
    // rust: } else {
    // rust: &south
    // rust: },
    // rust: ),
    // rust: ];
    // rust: for (name, value) in fixed {
    // rust: if props.get(name).is_some() {
    // rust: set(props, name, string(value));
}
}
    // rust: });
}

// `VillagerFollowRangeFix`.
villager_follow_range :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:villager", |e| {
    // rust: map_elements(e, "Attributes", |mut attribute| {
    // rust: if super::dynamic::as_string(attribute.get("Name"), "") == "generic.follow_range"
    // rust: && as_double(attribute.get("Base"), 0.0) == 16.0
    // rust: {
    // rust: set(&mut attribute, "Base", Tag::Double(48.0f64.to_bits()));
}
    // rust: attribute
    // rust: });
    // rust: });
}

// `EntityShulkerRotationFix`.
shulker_rotation :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:shulker", |e| {
    // rust: let mut rotation: Vec<f64> = stream(e.get("Rotation"))
    // rust: .iter()
    // rust: .map(|d| as_double(Some(d), 180.0))
    // rust: .collect();
    // rust: if !rotation.is_empty() {
    // rust: rotation[0] -= 180.0;
    // rust: set(
    // rust: e,
    // rust: "Rotation",
    // rust: Tag::List(
    // rust: rotation
    // rust: .into_iter()
    // rust: .map(|d| Tag::Double(d.to_bits()))
    // rust: .collect(),
    // rust: ),
    // rust: );
}
    // rust: });
}

// ------------------------------------------------------------------ 2537 to 2553

// `LegacyDimensionIdFix`: numeric dimensions of players and maps become names.
legacy_dimension_id :: proc(cx: ^Cx) {
}
    // rust: let fix = |v: &mut Tag, field: &str| {
    // rust: if let Some(id) = v.get(field)
    // rust: && let Some(n) = as_number(id)
    // rust: {
    // rust: let name = match n.int_value() {
    // rust: -1 => "minecraft:the_nether",
    // rust: 1 => "minecraft:the_end",
    // rust: _ => "minecraft:overworld",
}
    // rust: set(v, field, string(name));
}
}
    // rust: cx.each(Ty::Player, |p| fix(p, "Dimension"));
    // rust: cx.each(Ty::SavedMapData, |m| {
    // rust: if let Some(data) = m.get_mut("data") {
    // rust: fix(data, "dimension");
}
    // rust: });
}

// `LevelLegacyWorldGenSettingsFix`: the generator settings move into `WorldGenSettings`.
level_legacy_world_gen_settings :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |data| {
    // rust: let mut settings = data
    // rust: .get("WorldGenSettings")
    // rust: .cloned()
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: for key in [
    // rust: "RandomSeed",
    // rust: "generatorName",
    // rust: "generatorOptions",
    // rust: "generatorVersion",
    // rust: "legacy_custom_options",
    // rust: "MapFeatures",
    // rust: "BonusChest",
    // rust: ] {
    // rust: if let Some(old) = remove(data, key) {
    // rust: set(&mut settings, key, old);
}
}
    // rust: set(data, "WorldGenSettings", settings);
    // rust: });
}

map_of :: proc(entries: impl IntoIterator<Item = (^'static str) {
}
    // rust: Tag::compound(entries)
}

noise_generator :: proc(seed: i64, settings: Tag, biome_source: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: map_of([
    // rust: ("type", string("minecraft:noise")),
    // rust: ("biome_source", biome_source),
    // rust: ("seed", Tag::Long(seed)),
    // rust: ("settings", settings),
    // rust: ])
}

vanilla_biome_source :: proc(seed: i64, legacy_biome_init_layer: bool, large_biomes: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut source = map_of([
    // rust: ("type", string("minecraft:vanilla_layered")),
    // rust: ("seed", Tag::Long(seed)),
    // rust: ("large_biomes", Tag::Byte(i8::from(large_biomes))),
    // rust: ]);
    // rust: if legacy_biome_init_layer {
    // rust: set(&mut source, "legacy_biome_init_layer", Tag::Byte(1));
}
    // rust: source
}

default_overworld :: proc(seed: i64) -> T {
    // Ported from Horizon
    return {}
}
    // rust: noise_generator(
    // rust: seed,
    // rust: string("minecraft:overworld"),
    // rust: vanilla_biome_source(seed, false, false),
    // rust: )
}

// `WorldGenSettingsFix.vanillaLevels`.
    // rust: pub(super) fn vanilla_levels(seed: i64, overworld: Tag, caves: bool) -> Tag {
    // rust: let overworld_type = if caves {
    // rust: "minecraft:overworld_caves"
    // rust: } else {
    // rust: "minecraft:overworld"
}
    // rust: map_of([
    // rust: (
    // rust: "minecraft:overworld",
    // rust: map_of([("type", string(overworld_type)), ("generator", overworld)]),
    // rust: ),
    // rust: (
    // rust: "minecraft:the_nether",
    // rust: map_of([
    // rust: ("type", string("minecraft:the_nether")),
    // rust: (
    // rust: "generator",
    // rust: noise_generator(
    // rust: seed,
    // rust: string("minecraft:nether"),
    // rust: map_of([
    // rust: ("type", string("minecraft:multi_noise")),
    // rust: ("seed", Tag::Long(seed)),
    // rust: ("preset", string("minecraft:nether")),
    // rust: ]),
    // rust: ),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "minecraft:the_end",
    // rust: map_of([
    // rust: ("type", string("minecraft:the_end")),
    // rust: (
    // rust: "generator",
    // rust: noise_generator(
    // rust: seed,
    // rust: string("minecraft:end"),
    // rust: map_of([
    // rust: ("type", string("minecraft:the_end")),
    // rust: ("seed", Tag::Long(seed)),
    // rust: ]),
    // rust: ),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ])
}

// The default `StructureFeatureConfiguration` of a structure: spacing, separation, salt.
structure_default :: proc(name: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "minecraft:village" => (32, 8, 10387312),
    // rust: "minecraft:desert_pyramid" => (32, 8, 14357617),
    // rust: "minecraft:igloo" => (32, 8, 14357618),
    // rust: "minecraft:jungle_pyramid" => (32, 8, 14357619),
    // rust: "minecraft:swamp_hut" => (32, 8, 14357620),
    // rust: "minecraft:pillager_outpost" => (32, 8, 165745296),
    // rust: "minecraft:monument" => (32, 5, 10387313),
    // rust: "minecraft:endcity" => (20, 11, 10387313),
    // rust: _ => (80, 20, 10387319), // minecraft:mansion
}
}

// `NumberUtils.toInt(s, default)` with a minimum.
option_int :: proc(value: string, default: i32, min: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: value.parse::<i32>().unwrap_or(default).max(min)
}

    // rust: fn set_spacing(
    // rust: config: &mut Vec<(&'static str, (i32, i32, i32))>,
    // rust: structure: &'static str,
    // rust: value: &str,
    // rust: min: i32,
    // rust: ) {
    // rust: let current = config
    // rust: .iter()
    // rust: .find(|(n, _)| *n == structure)
    // rust: .map_or_else(|| structure_default(structure), |(_, c)| *c);
    // rust: let spacing = option_int(value, current.0, min);
    // rust: let updated = (spacing, current.1, current.2);
    // rust: match config.iter_mut().find(|(n, _)| *n == structure) {
    // rust: Some(entry) => entry.1 = updated,
    // rust: None => config.push((structure, updated)),
}
}

// `WorldGenSettingsFix.fixFlatStructures`.
fix_flat_structures :: proc(settings: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let (mut distance, mut spread, mut count) = (32, 3, 128);
    // rust: let mut has_stronghold = false;
    // rust: let mut config: Vec<(&'static str, (i32, i32, i32))> = Vec::new();
    // rust: if settings.is_none() {
    // rust: has_stronghold = true;
    // rust: config.push(("minecraft:village", structure_default("minecraft:village")));
}
    // rust: if let Some(Tag::Compound(structures)) = settings.and_then(|s| s.get("structures")) {
    // rust: for (structure_key, options) in structures {
    // rust: let Tag::Compound(options) = options else {
    // rust: continue;
}
    // rust: let structure = structure_key.to_string_lossy();
    // rust: for (option_key, option_value) in options {
    // rust: let option = option_key.to_string_lossy();
    // rust: let value = as_str(Some(option_value)).unwrap_or_default();
    // rust: if structure == "stronghold" {
    // rust: has_stronghold = true;
    // rust: match option.as_str() {
    // rust: "distance" => distance = option_int(&value, distance, 1),
    // rust: "spread" => spread = option_int(&value, spread, 1),
    // rust: "count" => count = option_int(&value, count, 1),
    // rust: _ => {}
}
    // rust: } else {
    // rust: match (option.as_str(), structure.as_str()) {
    // rust: ("distance", "village") => {
    // rust: set_spacing(&mut config, "minecraft:village", &value, 9)
}
    // rust: ("distance", "biome_1") => {
    // rust: for s in [
    // rust: "minecraft:desert_pyramid",
    // rust: "minecraft:igloo",
    // rust: "minecraft:jungle_pyramid",
    // rust: "minecraft:swamp_hut",
    // rust: "minecraft:pillager_outpost",
    // rust: ] {
    // rust: set_spacing(&mut config, s, &value, 9);
}
}
    // rust: ("distance", "endcity") => {
    // rust: set_spacing(&mut config, "minecraft:endcity", &value, 1)
}
    // rust: ("distance", "mansion") => {
    // rust: set_spacing(&mut config, "minecraft:mansion", &value, 1)
}
    // rust: ("separation", "oceanmonument") => {
    // rust: let current = config
    // rust: .iter()
    // rust: .find(|(n, _)| *n == "minecraft:monument")
    // rust: .map_or_else(
    // rust: || structure_default("minecraft:monument"),
    // rust: |(_, c)| *c,
    // rust: );
    // rust: let spacing = option_int(&value, current.1, 1);
    // rust: let updated = (spacing, current.1, current.2);
    // rust: match config.iter_mut().find(|(n, _)| *n == "minecraft:monument") {
    // rust: Some(entry) => entry.1 = updated,
    // rust: None => config.push(("minecraft:monument", updated)),
}
}
    // rust: ("spacing", "oceanmonument") => {
    // rust: set_spacing(&mut config, "minecraft:monument", &value, 1)
}
    // rust: _ => {}
}
}
}
}
}
    // rust: let mut structures = Compound::new();
    // rust: for (name, (spacing, separation, salt)) in config {
    // rust: structures.insert(
    // rust: JavaString::from(name),
    // rust: map_of([
    // rust: ("spacing", Tag::Int(spacing)),
    // rust: ("separation", Tag::Int(separation)),
    // rust: ("salt", Tag::Int(salt)),
    // rust: ]),
    // rust: );
}
    // rust: let mut out = map_of([("structures", Tag::Compound(structures))]);
    // rust: if has_stronghold {
    // rust: set(
    // rust: &mut out,
    // rust: "stronghold",
    // rust: map_of([
    // rust: ("distance", Tag::Int(distance)),
    // rust: ("spread", Tag::Int(spread)),
    // rust: ("count", Tag::Int(count)),
    // rust: ]),
    // rust: );
}
    // rust: out
}

// `WorldGenSettingsFix`: the legacy generator settings become dimensions.
world_gen_settings :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::WorldGenSettings, |input| {
    // rust: let seed = as_long(input.get("RandomSeed"), 0);
    // rust: let name = as_str(input.get("generatorName")).map(|n| n.to_lowercase());
    // rust: let legacy_custom_options = as_str(input.get("legacy_custom_options")).or_else(|| {
    // rust: (name.as_deref() == Some("customized"))
    // rust: .then(|| as_str(input.get("generatorOptions")))
    // rust: .flatten()
    // rust: });
    // rust: let mut caves = false;
    // rust: let generator = match name.as_deref() {
    // rust: None | Some("customized") => default_overworld(seed),
    // rust: Some("flat") => {
    // rust: let settings = input.get("generatorOptions");
    // rust: let layers = settings
    // rust: .and_then(|s| s.get("layers"))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| {
    // rust: Tag::List(
    // rust: [
    // rust: (1, "minecraft:bedrock"),
    // rust: (2, "minecraft:dirt"),
    // rust: (1, "minecraft:grass_block"),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(h, b)| map_of([("height", Tag::Int(h)), ("block", string(b))]))
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: map_of([
    // rust: ("type", string("minecraft:flat")),
    // rust: (
    // rust: "settings",
    // rust: map_of([
    // rust: ("structures", fix_flat_structures(settings)),
    // rust: ("layers", layers),
    // rust: (
    // rust: "biome",
    // rust: string(&super::dynamic::as_string(
    // rust: settings.and_then(|s| s.get("biome")),
    // rust: "minecraft:plains",
    // rust: )),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ])
}
    // rust: Some("debug_all_block_states") => map_of([("type", string("minecraft:debug"))]),
    // rust: Some("buffet") => {
    // rust: let settings = input.get("generatorOptions");
    // rust: let kind = settings
    // rust: .and_then(|s| s.get("chunk_generator"))
    // rust: .and_then(|g| as_str(g.get("type")));
    // rust: let noise_settings = match kind.as_deref() {
    // rust: Some("minecraft:caves") => {
    // rust: caves = true;
    // rust: "minecraft:caves"
}
    // rust: Some("minecraft:floating_islands") => "minecraft:floating_islands",
    // rust: _ => "minecraft:overworld",
}
    // rust: let source = settings
    // rust: .and_then(|s| s.get("biome_source"))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| map_of([("type", string("minecraft:fixed"))]));
    // rust: let fixed = if as_str(source.get("type")).as_deref() == Some("minecraft:fixed") {
    // rust: let biome = stream(source.get("options").and_then(|o| o.get("biomes")))
    // rust: .first()
    // rust: .and_then(|b| as_str(Some(b)))
    // rust: .unwrap_or_else(|| "minecraft:ocean".to_owned());
    // rust: let mut fixed = source;
    // rust: remove(&mut fixed, "options");
    // rust: set(&mut fixed, "biome", string(&biome));
    // rust: fixed
    // rust: } else {
    // rust: source
}
    // rust: noise_generator(seed, string(noise_settings), fixed)
}
    // rust: Some(other) => {
    // rust: let normal = other == "default";
    // rust: let legacy = other == "default_1_1"
    // rust: || normal && as_int(input.get("generatorVersion"), 0) == 0;
    // rust: noise_generator(
    // rust: seed,
    // rust: string(if other == "amplified" {
    // rust: "minecraft:amplified"
    // rust: } else {
    // rust: "minecraft:overworld"
    // rust: }),
    // rust: vanilla_biome_source(seed, legacy, other == "largebiomes"),
    // rust: )
}
}
    // rust: let mut out = map_of([
    // rust: ("seed", Tag::Long(seed)),
    // rust: (
    // rust: "generate_features",
    // rust: Tag::Byte(i8::from(as_bool(input.get("MapFeatures"), true))),
    // rust: ),
    // rust: (
    // rust: "bonus_chest",
    // rust: Tag::Byte(i8::from(as_bool(input.get("BonusChest"), false))),
    // rust: ),
    // rust: ("dimensions", vanilla_levels(seed, generator, caves)),
    // rust: ]);
    // rust: if let Some(options) = legacy_custom_options {
    // rust: set(&mut out, "legacy_custom_options", string(&options));
}
    // rust: *input = out;
    // rust: });
}

// `BiomeFix.BIOMES`.
    // rust: const BIOMES: &[(&str, &str)] = &[
    // rust: ("minecraft:extreme_hills", "minecraft:mountains"),
    // rust: ("minecraft:swampland", "minecraft:swamp"),
    // rust: ("minecraft:hell", "minecraft:nether_wastes"),
    // rust: ("minecraft:sky", "minecraft:the_end"),
    // rust: ("minecraft:ice_flats", "minecraft:snowy_tundra"),
    // rust: ("minecraft:ice_mountains", "minecraft:snowy_mountains"),
    // rust: ("minecraft:mushroom_island", "minecraft:mushroom_fields"),
    // rust: (
    // rust: "minecraft:mushroom_island_shore",
    // rust: "minecraft:mushroom_field_shore",
    // rust: ),
    // rust: ("minecraft:beaches", "minecraft:beach"),
    // rust: ("minecraft:forest_hills", "minecraft:wooded_hills"),
    // rust: ("minecraft:smaller_extreme_hills", "minecraft:mountain_edge"),
    // rust: ("minecraft:stone_beach", "minecraft:stone_shore"),
    // rust: ("minecraft:cold_beach", "minecraft:snowy_beach"),
    // rust: ("minecraft:roofed_forest", "minecraft:dark_forest"),
    // rust: ("minecraft:taiga_cold", "minecraft:snowy_taiga"),
    // rust: ("minecraft:taiga_cold_hills", "minecraft:snowy_taiga_hills"),
    // rust: ("minecraft:redwood_taiga", "minecraft:giant_tree_taiga"),
    // rust: (
    // rust: "minecraft:redwood_taiga_hills",
    // rust: "minecraft:giant_tree_taiga_hills",
    // rust: ),
    // rust: (
    // rust: "minecraft:extreme_hills_with_trees",
    // rust: "minecraft:wooded_mountains",
    // rust: ),
    // rust: ("minecraft:savanna_rock", "minecraft:savanna_plateau"),
    // rust: ("minecraft:mesa", "minecraft:badlands"),
    // rust: ("minecraft:mesa_rock", "minecraft:wooded_badlands_plateau"),
    // rust: ("minecraft:mesa_clear_rock", "minecraft:badlands_plateau"),
    // rust: ("minecraft:sky_island_low", "minecraft:small_end_islands"),
    // rust: ("minecraft:sky_island_medium", "minecraft:end_midlands"),
    // rust: ("minecraft:sky_island_high", "minecraft:end_highlands"),
    // rust: ("minecraft:sky_island_barren", "minecraft:end_barrens"),
    // rust: ("minecraft:void", "minecraft:the_void"),
    // rust: ("minecraft:mutated_plains", "minecraft:sunflower_plains"),
    // rust: ("minecraft:mutated_desert", "minecraft:desert_lakes"),
    // rust: (
    // rust: "minecraft:mutated_extreme_hills",
    // rust: "minecraft:gravelly_mountains",
    // rust: ),
    // rust: ("minecraft:mutated_forest", "minecraft:flower_forest"),
    // rust: ("minecraft:mutated_taiga", "minecraft:taiga_mountains"),
    // rust: ("minecraft:mutated_swampland", "minecraft:swamp_hills"),
    // rust: ("minecraft:mutated_ice_flats", "minecraft:ice_spikes"),
    // rust: ("minecraft:mutated_jungle", "minecraft:modified_jungle"),
    // rust: (
    // rust: "minecraft:mutated_jungle_edge",
    // rust: "minecraft:modified_jungle_edge",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_birch_forest",
    // rust: "minecraft:tall_birch_forest",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_birch_forest_hills",
    // rust: "minecraft:tall_birch_hills",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_roofed_forest",
    // rust: "minecraft:dark_forest_hills",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_taiga_cold",
    // rust: "minecraft:snowy_taiga_mountains",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_redwood_taiga",
    // rust: "minecraft:giant_spruce_taiga",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_redwood_taiga_hills",
    // rust: "minecraft:giant_spruce_taiga_hills",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_extreme_hills_with_trees",
    // rust: "minecraft:modified_gravelly_mountains",
    // rust: ),
    // rust: ("minecraft:mutated_savanna", "minecraft:shattered_savanna"),
    // rust: (
    // rust: "minecraft:mutated_savanna_rock",
    // rust: "minecraft:shattered_savanna_plateau",
    // rust: ),
    // rust: ("minecraft:mutated_mesa", "minecraft:eroded_badlands"),
    // rust: (
    // rust: "minecraft:mutated_mesa_rock",
    // rust: "minecraft:modified_wooded_badlands_plateau",
    // rust: ),
    // rust: (
    // rust: "minecraft:mutated_mesa_clear_rock",
    // rust: "minecraft:modified_badlands_plateau",
    // rust: ),
    // rust: ("minecraft:warm_deep_ocean", "minecraft:deep_warm_ocean"),
    // rust: (
    // rust: "minecraft:lukewarm_deep_ocean",
    // rust: "minecraft:deep_lukewarm_ocean",
    // rust: ),
    // rust: ("minecraft:cold_deep_ocean", "minecraft:deep_cold_ocean"),
    // rust: ("minecraft:frozen_deep_ocean", "minecraft:deep_frozen_ocean"),
    // rust: ];

// ------------------------------------------------------------------ 1800 to 1963

// `ItemLoreFix`: the lore lines become JSON text components.
item_lore :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |stack| {
    // rust: let Some(lore) = stack
    // rust: .get_mut("tag")
    // rust: .and_then(|t| t.get_mut("display"))
    // rust: .and_then(|d| d.get_mut("Lore"))
    // rust: else {
    // rust: return;
}
    // rust: if let Tag::List(lines) = lore {
    // rust: for line in lines {
    // rust: if let Tag::String(text) = line {
    // rust: *line = Tag::String(JavaString(super::json::text_component_json(&text.0)));
}
}
}
    // rust: });
}

// `EntityCatSplitFix`: tame ocelots become cats. (The vanilla fix sets
// `Trusting` on a copy it then drops.)
cat_split :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if !id_is(e, "minecraft:ocelot") {
    // rust: return;
}
    // rust: let kind = as_int(e.get("CatType"), 0);
    // rust: if kind > 0 && kind < 4 {
    // rust: set(e, "CatType", Tag::Int(kind));
    // rust: let owner = super::dynamic::as_string(e.get("OwnerUUID"), "");
    // rust: set(e, "OwnerUUID", string(&owner));
    // rust: set(e, "id", string("minecraft:cat"));
}
    // rust: });
}

// The `Status` of a chunk, mapped (`ChunkStatusFix`, `ChunkStatusFix2`).
level_status :: proc(cx: ^Cx, f: impl Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: let Some(level) = c.get_mut("Level") else {
    // rust: return;
}
    // rust: let status = super::dynamic::as_string(level.get("Status"), "empty");
    // rust: if let Some(new) = f(&status)
    // rust: && new != status
    // rust: {
    // rust: set(level, "Status", string(new));
}
    // rust: });
}

// A list field filtered by `keep`; a present field that is no list becomes empty.
map_elements_filter :: proc(tag: ^Tag, field: string, keep: impl Fn(^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(v) = tag.get_mut(field) {
    // rust: *v = Tag::List(stream(Some(v)).into_iter().filter(|e| keep(e)).collect());
}
}

// `VillagerDataFix`: profession and career become `VillagerData`.
villager_data :: proc(cx: ^Cx, entity: string) {
}
    // rust: cx.entity(entity, |e| {
    // rust: let profession = as_int(e.get("Profession"), 0);
    // rust: let career = as_int(e.get("Career"), 0);
    // rust: let profession = match (profession, career) {
    // rust: (0, 2) => "minecraft:fisherman",
    // rust: (0, 3) => "minecraft:shepherd",
    // rust: (0, 4) => "minecraft:fletcher",
    // rust: (0, _) => "minecraft:farmer",
    // rust: (1, 2) => "minecraft:cartographer",
    // rust: (1, _) => "minecraft:librarian",
    // rust: (2, _) => "minecraft:cleric",
    // rust: (3, 2) => "minecraft:weaponsmith",
    // rust: (3, 3) => "minecraft:toolsmith",
    // rust: (3, _) => "minecraft:armorer",
    // rust: (4, 2) => "minecraft:leatherworker",
    // rust: (4, _) => "minecraft:butcher",
    // rust: (5, _) => "minecraft:nitwit",
    // rust: _ => "minecraft:none",
}
    // rust: let level = e.get("CareerLevel").cloned().unwrap_or(Tag::Int(1));
    // rust: remove(e, "Profession");
    // rust: remove(e, "Career");
    // rust: remove(e, "CareerLevel");
    // rust: set(
    // rust: e,
    // rust: "VillagerData",
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:plains")),
    // rust: ("profession", string(profession)),
    // rust: ("level", level),
    // rust: ]),
    // rust: );
    // rust: });
}

// `NewVillageFix`: the new village structure takes the old one's name.
new_village :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: let Some(structures) = c.get_mut("Level").and_then(|l| l.get_mut("Structures")) else {
    // rust: return;
}
    // rust: if let Some(Tag::Compound(starts)) = structures.get_mut("Starts") {
    // rust: starts.remove(&JavaString::from("Village"));
    // rust: if let Some(v) = starts.remove(&JavaString::from("New_Village")) {
    // rust: starts.insert(JavaString::from("Village"), v);
}
}
    // rust: if let Some(references) = structures.get_mut("References") {
    // rust: if let Some(v) = remove(references, "New_Village") {
    // rust: set(references, "Village", v);
}
    // rust: remove(references, "Village");
}
    // rust: });
    // rust: cx.each(Ty::StructureFeature, |s| {
    // rust: if let Some(id) = s.get("id") {
    // rust: let id = as_str(Some(id)).unwrap_or_default();
    // rust: if namespaced(&id) == "minecraft:new_village" {
    // rust: set(s, "id", string("minecraft:village"));
}
}
    // rust: });
}

// `ReorganizePoi`: the sections `0` to `15` move below `Sections`.
reorganize_poi :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::PoiChunk, |poi| {
    // rust: let mut sections = Compound::new();
    // rust: for i in 0..16 {
    // rust: let name = i.to_string();
    // rust: if let Some(records) = remove(poi, &name) {
    // rust: sections.insert(
    // rust: JavaString::from(name.as_str()),
    // rust: Tag::compound([("Records", records)]),
    // rust: );
}
}
    // rust: set(poi, "Sections", Tag::Compound(sections));
    // rust: });
}

ILLAGER_BANNER :: "\"translate\":\"block.minecraft.illager_banner\""
OMINOUS_BANNER :: "\"translate\":\"block.minecraft.ominous_banner\""

// `OminousBannerRenameFix`.
ominous_banner_item :: proc(cx: ^Cx) {
}
    // rust: cx.item(
    // rust: |id| id == "minecraft:white_banner",
    // rust: |stack| {
    // rust: if let Some(name) = stack
    // rust: .get_mut("tag")
    // rust: .and_then(|t| t.get_mut("display"))
    // rust: .and_then(|d| d.get_mut("Name"))
    // rust: && let Some(text) = as_str(Some(name))
    // rust: {
    // rust: *name = string(&text.replace(ILLAGER_BANNER, OMINOUS_BANNER));
}
    // rust: },
    // rust: );
}

// `OminousBannerBlockEntityRenameFix`.
ominous_banner_block_entity :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:banner", |be| {
    // rust: if let Some(name) = be.get_mut("CustomName")
    // rust: && let Some(text) = as_str(Some(name))
    // rust: {
    // rust: *name = string(&text.replace(ILLAGER_BANNER, OMINOUS_BANNER));
}
    // rust: });
}

LEVEL_XP_THRESHOLDS :: [0, 10, 50, 100, 150]

min_xp_per_level :: proc(level: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: LEVEL_XP_THRESHOLDS[(level - 1).clamp(0, 4) as usize]
}

// `VillagerRebuildLevelAndXpFix`.
villager_level_and_xp :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:villager", |e| {
    // rust: let mut level = as_int(e.get("VillagerData").and_then(|d| d.get("level")), 0);
    // rust: if level == 0 || level == 1 {
    // rust: let offers = e
    // rust: .get("Offers")
    // rust: .and_then(|o| o.get("Recipes"))
    // rust: .map_or(0, |r| stream(Some(r)).len() as i32);
    // rust: level = (offers / 2).clamp(1, 5);
    // rust: if level > 1
    // rust: && let Some(data) = e.get_mut("VillagerData")
    // rust: {
    // rust: set(data, "level", Tag::Int(level));
}
}
    // rust: if e.get("Xp").and_then(as_number).is_none() {
    // rust: set(e, "Xp", Tag::Int(min_xp_per_level(level)));
}
    // rust: });
}

// `ZombieVillagerRebuildXpFix`.
zombie_villager_xp :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:zombie_villager", |e| {
    // rust: if e.get("Xp").and_then(as_number).is_none() {
    // rust: let level = as_int(e.get("VillagerData").and_then(|d| d.get("level")), 1);
    // rust: set(e, "Xp", Tag::Int(min_xp_per_level(level)));
}
    // rust: });
}
