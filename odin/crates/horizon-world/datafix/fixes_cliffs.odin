//! Transpiled from Horizon Rust crate
package horizon_world_fixes_cliffs

import "core:fmt"
import "core:mem"
import "core:math"

// Fixes of 1.17 and 1.18, Caves & Cliffs (keys 2679 to 2970): what worlds
// saved by 1.16.5 to 1.18.1 need before the fixes of [`super::fixes_old`].
// use super::dynamic::{
    // rust: as_bool, as_byte_buffer, as_int, as_int_stream, as_long_stream, as_number, as_str, ceillog2,
    // rust: empty_map, remove, rename, set, stream, string,
}
// use super::fixes_a::block_rename;
// use super::fixes_b::advancements_rename;
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, renamer};
// use crate::nbt::{Compound, JavaString, Tag};

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(2679, 0), cauldron_rename));
    // rust: out.push((key(2680, 0), |cx| {
    // rust: let t = &[("minecraft:grass_path", "minecraft:dirt_path")];
    // rust: cx.rename(Ty::ItemName, renamer(t));
    // rust: }));
    // rust: out.push((key(2680, 0), |cx| {
    // rust: block_rename(cx, &[("minecraft:grass_path", "minecraft:dirt_path")])
    // rust: }));
    // rust: out.push((key(2690, 0), |cx| cx.rename(Ty::ItemName, renamer(COPPER))));
    // rust: out.push((key(2690, 0), |cx| block_rename(cx, COPPER)));
    // rust: out.push((key(2691, 0), |cx| {
    // rust: cx.rename(Ty::ItemName, renamer(WAXED_COPPER))
    // rust: }));
    // rust: out.push((key(2691, 0), |cx| block_rename(cx, WAXED_COPPER)));
    // rust: out.push((key(2693, 0), |cx| {
    // rust: add_flag(cx, "has_increased_height_already", false)
    // rust: }));
    // rust: out.push((key(2696, 0), |cx| {
    // rust: cx.rename(Ty::ItemName, renamer(GRIMSTONE))
    // rust: }));
    // rust: out.push((key(2696, 0), |cx| block_rename(cx, GRIMSTONE)));
    // rust: out.push((key(2700, 0), |cx| {
    // rust: block_rename(
    // rust: cx,
    // rust: &[
    // rust: ("minecraft:cave_vines_head", "minecraft:cave_vines"),
    // rust: ("minecraft:cave_vines_body", "minecraft:cave_vines_plant"),
    // rust: ],
    // rust: )
    // rust: }));
    // rust: out.push((key(2701, 0), feature_pool_elements));
    // rust: out.push((key(2702, 0), arrow_pickup));
    // rust: out.push((key(2707, 0), |cx| {
    // rust: add_flag(cx, "has_increased_height_already", true)
    // rust: }));
    // rust: out.push((key(2710, 0), |cx| {
    // rust: stats_rename(cx, &[("minecraft:play_one_minute", "minecraft:play_time")])
    // rust: }));
    // rust: out.push((key(2717, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[(
    // rust: "minecraft:azalea_leaves_flowers",
    // rust: "minecraft:flowering_azalea_leaves",
    // rust: )]),
    // rust: )
    // rust: }));
    // rust: out.push((key(2717, 0), |cx| {
    // rust: block_rename(
    // rust: cx,
    // rust: &[(
    // rust: "minecraft:azalea_leaves_flowers",
    // rust: "minecraft:flowering_azalea_leaves",
    // rust: )],
    // rust: )
    // rust: }));
    // rust: out.push((key(2825, 0), |cx| {
    // rust: add_flag(cx, "has_increased_height_already", false)
    // rust: }));
    // rust: out.push((key(2831, 0), spawner_data));
    // rust: out.push((key(2832, 0), world_gen_height_and_biome));
    // rust: out.push((key(2832, 0), chunk_height_and_biome));
    // 2833 and 2852: `WorldGenSettingsDisallowOldCustomWorldsFix` refuses a
    // world whose dimension has no type; it changes nothing.
    // rust: out.push((key(2838, 0), |cx| {
    // rust: cx.rename(Ty::Biome, renamer(CAVES_AND_CLIFFS))
    // rust: }));
    // rust: out.push((key(2841, 0), chunk_proto_tick_list));
    // rust: out.push((key(2842, 0), chunk_renames));
    // rust: out.push((key(2843, 0), overreaching_ticks));
    // rust: out.push((key(2843, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::Biome,
    // rust: renamer(&[("minecraft:deep_warm_ocean", "minecraft:warm_ocean")]),
    // rust: )
    // rust: }));
    // rust: out.push((key(2846, 0), |cx| {
    // rust: advancements_rename(cx, &|id| {
    // rust: renamer(&[
    // rust: (
    // rust: "minecraft:husbandry/play_jukebox_in_meadows",
    // rust: "minecraft:adventure/play_jukebox_in_meadows",
    // rust: ),
    // rust: (
    // rust: "minecraft:adventure/caves_and_cliff",
    // rust: "minecraft:adventure/fall_from_world_height",
    // rust: ),
    // rust: (
    // rust: "minecraft:adventure/ride_strider_in_overworld_lava",
    // rust: "minecraft:nether/ride_strider_in_overworld_lava",
    // rust: ),
    // rust: ])(id)
    // rust: .map(str::to_owned)
    // rust: })
    // rust: }));
    // rust: out.push((key(2967, 0), structure_settings_flatten));
    // rust: out.push((key(2970, 0), structures_become_configured));
}

// ------------------------------------------------------------------ 2967

// `StructureSettingsFlattenFix`.
structure_settings_flatten :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::WorldGenSettings, |v| {
    // rust: let Some(Tag::Compound(dims)) = v.get_mut("dimensions") else {
    // rust: return;
}
    // rust: for dim in dims.values_mut() {
    // rust: let Some(settings) = dim.get_mut("generator").and_then(|g| g.get_mut("settings"))
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(structures) = settings.get_mut("structures") {
    // rust: *structures = flatten_structures(structures);
}
}
    // rust: });
}

flatten_structures :: proc(input: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut structures = match input.get("structures") {
    // rust: Some(Tag::Compound(c)) => {
    // rust: let mut out = Compound::new();
    // rust: for (k, s) in c {
    // rust: let mut s = s.clone();
    // rust: set(&mut s, "type", string("minecraft:random_spread"));
    // rust: out.insert(k.clone(), s);
}
    // rust: Tag::Compound(out)
}
    // rust: _ => empty_map(),
}
    // rust: if let Some(stronghold) = input.get("stronghold") {
    // rust: let mut stronghold = stronghold.clone();
    // rust: set(
    // rust: &mut stronghold,
    // rust: "type",
    // rust: string("minecraft:concentric_rings"),
    // rust: );
    // rust: set(&mut structures, "minecraft:stronghold", stronghold);
}
    // rust: structures
}

// ------------------------------------------------------------------ 2970

Conversion :: struct {
    biomes: ^'static [(^'static [^'static str],
    fallback: ^'static str,
}

    // rust: const fn trivial(fallback: &'static str) -> Conversion {
    // rust: Conversion {
    // rust: biomes: &[],
    // rust: fallback,
}
}

conversion :: proc(key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match key {
    // rust: "mineshaft" => Conversion {
    // rust: biomes: &[(
    // rust: &[
    // rust: "minecraft:badlands",
    // rust: "minecraft:eroded_badlands",
    // rust: "minecraft:wooded_badlands",
    // rust: ],
    // rust: "minecraft:mineshaft_mesa",
    // rust: )],
    // rust: fallback: "minecraft:mineshaft",
    // rust: },
    // rust: "shipwreck" => Conversion {
    // rust: biomes: &[(
    // rust: &["minecraft:beach", "minecraft:snowy_beach"],
    // rust: "minecraft:shipwreck_beached",
    // rust: )],
    // rust: fallback: "minecraft:shipwreck",
    // rust: },
    // rust: "ocean_ruin" => Conversion {
    // rust: biomes: &[(
    // rust: &[
    // rust: "minecraft:warm_ocean",
    // rust: "minecraft:lukewarm_ocean",
    // rust: "minecraft:deep_lukewarm_ocean",
    // rust: ],
    // rust: "minecraft:ocean_ruin_warm",
    // rust: )],
    // rust: fallback: "minecraft:ocean_ruin_cold",
    // rust: },
    // rust: "village" => Conversion {
    // rust: biomes: &[
    // rust: (&["minecraft:desert"], "minecraft:village_desert"),
    // rust: (&["minecraft:savanna"], "minecraft:village_savanna"),
    // rust: (&["minecraft:snowy_plains"], "minecraft:village_snowy"),
    // rust: (&["minecraft:taiga"], "minecraft:village_taiga"),
    // rust: ],
    // rust: fallback: "minecraft:village_plains",
    // rust: },
    // rust: "ruined_portal" => Conversion {
    // rust: biomes: &[
    // rust: (&["minecraft:desert"], "minecraft:ruined_portal_desert"),
    // rust: (
    // rust: &[
    // rust: "minecraft:badlands",
    // rust: "minecraft:eroded_badlands",
    // rust: "minecraft:wooded_badlands",
    // rust: "minecraft:windswept_hills",
    // rust: "minecraft:windswept_forest",
    // rust: "minecraft:windswept_gravelly_hills",
    // rust: "minecraft:savanna_plateau",
    // rust: "minecraft:windswept_savanna",
    // rust: "minecraft:stony_shore",
    // rust: "minecraft:meadow",
    // rust: "minecraft:frozen_peaks",
    // rust: "minecraft:jagged_peaks",
    // rust: "minecraft:stony_peaks",
    // rust: "minecraft:snowy_slopes",
    // rust: ],
    // rust: "minecraft:ruined_portal_mountain",
    // rust: ),
    // rust: (
    // rust: &[
    // rust: "minecraft:bamboo_jungle",
    // rust: "minecraft:jungle",
    // rust: "minecraft:sparse_jungle",
    // rust: ],
    // rust: "minecraft:ruined_portal_jungle",
    // rust: ),
    // rust: (
    // rust: &[
    // rust: "minecraft:deep_frozen_ocean",
    // rust: "minecraft:deep_cold_ocean",
    // rust: "minecraft:deep_ocean",
    // rust: "minecraft:deep_lukewarm_ocean",
    // rust: "minecraft:frozen_ocean",
    // rust: "minecraft:ocean",
    // rust: "minecraft:cold_ocean",
    // rust: "minecraft:lukewarm_ocean",
    // rust: "minecraft:warm_ocean",
    // rust: ],
    // rust: "minecraft:ruined_portal_ocean",
    // rust: ),
    // rust: ],
    // rust: fallback: "minecraft:ruined_portal",
    // rust: },
    // rust: "pillager_outpost" => trivial("minecraft:pillager_outpost"),
    // rust: "mansion" => trivial("minecraft:mansion"),
    // rust: "jungle_pyramid" => trivial("minecraft:jungle_pyramid"),
    // rust: "desert_pyramid" => trivial("minecraft:desert_pyramid"),
    // rust: "igloo" => trivial("minecraft:igloo"),
    // rust: "swamp_hut" => trivial("minecraft:swamp_hut"),
    // rust: "stronghold" => trivial("minecraft:stronghold"),
    // rust: "monument" => trivial("minecraft:monument"),
    // rust: "fortress" => trivial("minecraft:fortress"),
    // rust: "endcity" => trivial("minecraft:end_city"),
    // rust: "buried_treasure" => trivial("minecraft:buried_treasure"),
    // rust: "nether_fossil" => trivial("minecraft:nether_fossil"),
    // rust: "bastion_remnant" => trivial("minecraft:bastion_remnant"),
    // rust: _ => return None,
    // rust: })
}

// `StructuresBecomeConfiguredFix.findUpdatedStructureType`.
updated_structure :: proc(key: ^JavaString, chunk: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let conv = conversion(&key.to_string_lossy().to_lowercase())?;
    // rust: if conv.biomes.is_empty() {
    // rust: return Some(conv.fallback.to_owned());
}
    // `guessConfiguration`: palette biome counts per mapping, in first-seen
    // order; the most frequent wins, the first on ties.
    // rust: let mapping = |biome: &str| {
    // rust: conv.biomes
    // rust: .iter()
    // rust: .find(|(list, _)| list.contains(&biome))
    // rust: .map(|(_, to)| *to)
}
    // rust: let mut matches: Vec<(&str, i32)> = Vec::new();
    // rust: for s in stream(chunk.get("sections")) {
    // rust: let palette = s.get("biomes").and_then(|b| b.get("palette")).cloned();
    // rust: for biome in stream(palette.as_ref()) {
    // rust: if let Some(m) = mapping(&as_str(Some(&biome)).unwrap_or_default()) {
    // rust: match matches.iter_mut().find(|(k, _)| *k == m) {
    // rust: Some((_, n)) => *n += 1,
    // rust: None => matches.push((m, 1)),
}
}
}
}
    // rust: let best = matches
    // rust: .iter()
    // rust: .fold(None::<(&str, i32)>, |best, &(k, n)| match best {
    // rust: Some((_, b)) if b >= n => best,
    // rust: _ => Some((k, n)),
    // rust: });
    // rust: Some(best.map_or(conv.fallback, |(k, _)| k).to_owned())
}

// `StructuresBecomeConfiguredFix`.
structures_become_configured :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let Some(structures) = chunk.get("structures").cloned() else {
    // rust: return;
}
    // rust: let mut structures = structures;
    // rust: if let Some(Tag::Compound(starts)) = structures.get("starts") {
    // rust: let mut out: Vec<(String, Tag)> = Vec::new();
    // rust: for (k, start) in starts {
    // rust: if as_str(start.get("id")).as_deref().unwrap_or("INVALID") == "INVALID" {
    // rust: continue;
}
    // rust: if let Some(new) = updated_structure(k, chunk)
    // rust: && !out.iter().any(|(n, _)| *n == new)
    // rust: {
    // rust: let mut start = start.clone();
    // rust: set(&mut start, "id", string(&new));
    // rust: out.push((new, start));
}
}
    // rust: let map = out
    // rust: .into_iter()
    // rust: .map(|(k, v)| (JavaString::from(k.as_str()), v));
    // rust: set(&mut structures, "starts", Tag::Compound(map.collect()));
    // rust: } else if structures.get("starts").is_some() {
    // rust: set(&mut structures, "starts", empty_map());
}
    // rust: if let Some(refs) = structures.get("References") {
    // rust: let mut out: Vec<(String, Vec<Tag>)> = Vec::new();
    // rust: if let Tag::Compound(refs) = refs {
    // rust: for (k, list) in refs {
    // rust: let list = stream(Some(list));
    // rust: if list.is_empty() {
    // rust: continue;
}
    // rust: if let Some(new) = updated_structure(k, chunk) {
    // rust: match out.iter_mut().find(|(n, _)| *n == new) {
    // rust: Some((_, old)) => old.extend(list),
    // rust: None => out.push((new, list)),
}
}
}
}
    // rust: let map = out.into_iter().map(|(k, v)| {
    // rust: let longs = v
    // rust: .iter()
    // rust: .map(|t| super::dynamic::as_long(Some(t), 0))
    // rust: .collect();
    // rust: (JavaString::from(k.as_str()), Tag::LongArray(longs))
    // rust: });
    // rust: set(&mut structures, "References", Tag::Compound(map.collect()));
}
    // rust: set(chunk, "structures", structures);
    // rust: });
}

// ------------------------------------------------------------------ 2679 to 2717

// `CauldronRenameFix`.
cauldron_rename :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::BlockState, |v| {
    // rust: if as_str(v.get("Name")).as_deref() != Some("minecraft:cauldron") {
    // rust: return;
}
    // rust: let level = v
    // rust: .get("Properties")
    // rust: .and_then(|p| as_str(p.get("level")))
    // rust: .unwrap_or_else(|| "0".into());
    // rust: if level == "0" {
    // rust: remove(v, "Properties");
    // rust: } else {
    // rust: set(v, "Name", string("minecraft:water_cauldron"));
}
    // rust: });
}

    // rust: const COPPER: &[(&str, &str)] = &[
    // rust: (
    // rust: "minecraft:weathered_copper_block",
    // rust: "minecraft:oxidized_copper_block",
    // rust: ),
    // rust: (
    // rust: "minecraft:semi_weathered_copper_block",
    // rust: "minecraft:weathered_copper_block",
    // rust: ),
    // rust: (
    // rust: "minecraft:lightly_weathered_copper_block",
    // rust: "minecraft:exposed_copper_block",
    // rust: ),
    // rust: (
    // rust: "minecraft:weathered_cut_copper",
    // rust: "minecraft:oxidized_cut_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:semi_weathered_cut_copper",
    // rust: "minecraft:weathered_cut_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:lightly_weathered_cut_copper",
    // rust: "minecraft:exposed_cut_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:weathered_cut_copper_stairs",
    // rust: "minecraft:oxidized_cut_copper_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:semi_weathered_cut_copper_stairs",
    // rust: "minecraft:weathered_cut_copper_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:lightly_weathered_cut_copper_stairs",
    // rust: "minecraft:exposed_cut_copper_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:weathered_cut_copper_slab",
    // rust: "minecraft:oxidized_cut_copper_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:semi_weathered_cut_copper_slab",
    // rust: "minecraft:weathered_cut_copper_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:lightly_weathered_cut_copper_slab",
    // rust: "minecraft:exposed_cut_copper_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_semi_weathered_copper",
    // rust: "minecraft:waxed_weathered_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_lightly_weathered_copper",
    // rust: "minecraft:waxed_exposed_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_semi_weathered_cut_copper",
    // rust: "minecraft:waxed_weathered_cut_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_lightly_weathered_cut_copper",
    // rust: "minecraft:waxed_exposed_cut_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_semi_weathered_cut_copper_stairs",
    // rust: "minecraft:waxed_weathered_cut_copper_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_lightly_weathered_cut_copper_stairs",
    // rust: "minecraft:waxed_exposed_cut_copper_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_semi_weathered_cut_copper_slab",
    // rust: "minecraft:waxed_weathered_cut_copper_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_lightly_weathered_cut_copper_slab",
    // rust: "minecraft:waxed_exposed_cut_copper_slab",
    // rust: ),
    // rust: ];

    // rust: const WAXED_COPPER: &[(&str, &str)] = &[
    // rust: ("minecraft:waxed_copper", "minecraft:waxed_copper_block"),
    // rust: (
    // rust: "minecraft:oxidized_copper_block",
    // rust: "minecraft:oxidized_copper",
    // rust: ),
    // rust: (
    // rust: "minecraft:weathered_copper_block",
    // rust: "minecraft:weathered_copper",
    // rust: ),
    // rust: ("minecraft:exposed_copper_block", "minecraft:exposed_copper"),
    // rust: ];

    // rust: const GRIMSTONE: &[(&str, &str)] = &[
    // rust: ("minecraft:grimstone", "minecraft:deepslate"),
    // rust: (
    // rust: "minecraft:grimstone_slab",
    // rust: "minecraft:cobbled_deepslate_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:grimstone_stairs",
    // rust: "minecraft:cobbled_deepslate_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:grimstone_wall",
    // rust: "minecraft:cobbled_deepslate_wall",
    // rust: ),
    // rust: (
    // rust: "minecraft:polished_grimstone",
    // rust: "minecraft:polished_deepslate",
    // rust: ),
    // rust: (
    // rust: "minecraft:polished_grimstone_slab",
    // rust: "minecraft:polished_deepslate_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:polished_grimstone_stairs",
    // rust: "minecraft:polished_deepslate_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:polished_grimstone_wall",
    // rust: "minecraft:polished_deepslate_wall",
    // rust: ),
    // rust: ("minecraft:grimstone_tiles", "minecraft:deepslate_tiles"),
    // rust: (
    // rust: "minecraft:grimstone_tile_slab",
    // rust: "minecraft:deepslate_tile_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:grimstone_tile_stairs",
    // rust: "minecraft:deepslate_tile_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:grimstone_tile_wall",
    // rust: "minecraft:deepslate_tile_wall",
    // rust: ),
    // rust: ("minecraft:grimstone_bricks", "minecraft:deepslate_bricks"),
    // rust: (
    // rust: "minecraft:grimstone_brick_slab",
    // rust: "minecraft:deepslate_brick_slab",
    // rust: ),
    // rust: (
    // rust: "minecraft:grimstone_brick_stairs",
    // rust: "minecraft:deepslate_brick_stairs",
    // rust: ),
    // rust: (
    // rust: "minecraft:grimstone_brick_wall",
    // rust: "minecraft:deepslate_brick_wall",
    // rust: ),
    // rust: (
    // rust: "minecraft:chiseled_grimstone",
    // rust: "minecraft:chiseled_deepslate",
    // rust: ),
    // rust: ];

// `SavedDataFeaturePoolElementFix`: the feature of jigsaw pieces' feature pool
// elements, from an inline configuration to a configured feature id.
feature_pool_elements :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::StructureFeature, |v| {
    // rust: let Some(children) = v.get("Children") else {
    // rust: return;
}
    // rust: if !super::dynamic::is_list(Some(children)) {
    // rust: return;
}
    // rust: let fixed = stream(Some(children))
    // rust: .into_iter()
    // rust: .map(|mut child| {
    // rust: let id = as_str(child.get("id")).unwrap_or_default();
    // rust: if !matches!(
    // rust: id.as_str(),
    // rust: "minecraft:jigsaw"
    // rust: | "minecraft:nvi"
    // rust: | "minecraft:pcp"
    // rust: | "minecraft:bastionremnant"
    // rust: | "minecraft:runtime"
    // rust: ) {
    // rust: return child;
}
    // rust: let element = child.get("pool_element");
    // rust: let is_feature = element
    // rust: .and_then(|e| as_str(e.get("element_type")))
    // rust: .as_deref()
    // rust: == Some("minecraft:feature_pool_element");
    // rust: if is_feature
    // rust: && let Some(f) = child
    // rust: .get_mut("pool_element")
    // rust: .and_then(|p| p.get_mut("feature"))
    // rust: && let Some(new) = feature_replacement(f)
    // rust: {
    // rust: *f = string(new);
}
    // rust: child
    // rust: })
    // rust: .collect();
    // rust: set(v, "Children", Tag::List(fixed));
    // rust: });
}

path_str :: proc(v: ^Tag, path: ^[string]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut cur = Some(v.clone());
    // rust: for p in path {
    // rust: cur = match (cur, p.strip_prefix('[').and_then(|s| s.strip_suffix(']'))) {
    // rust: (Some(c), Some(index)) => {
    // rust: let i: usize = index.parse().unwrap_or(usize::MAX);
    // rust: stream(Some(&c)).into_iter().nth(i)
}
    // rust: (Some(c), None) => c.get(p).cloned(),
    // rust: (None, _) => None,
}
}
    // rust: as_str(cur.as_ref()).unwrap_or_default()
}

// `SavedDataFeaturePoolElementFix.getReplacement`.
feature_replacement :: proc(value: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let ty = path_str(value, &["type"]);
    // rust: let name = path_str(value, &["name"]);
    // rust: let provider = path_str(value, &["config", "state_provider", "type"]);
    // rust: let state = path_str(value, &["config", "state_provider", "state", "Name"]);
    // rust: let first = path_str(
    // rust: value,
    // rust: &["config", "state_provider", "entries", "[0]", "data", "Name"],
    // rust: );
    // rust: let foliage = path_str(value, &["config", "foliage_placer", "type"]);
    // rust: let leaves = path_str(value, &["config", "leaves_provider", "state", "Name"]);
    // rust: let feature = if !ty.is_empty() {
    // rust: ty
    // rust: } else if name.is_empty() {
    // rust: return None;
    // rust: } else if name == "minecraft:normal_tree" {
    // rust: "minecraft:tree".to_owned()
    // rust: } else {
    // rust: name
}
    // rust: match feature.as_str() {
    // rust: "minecraft:random_patch" => {
    // rust: if provider == "minecraft:simple_state_provider" {
    // rust: match state.as_str() {
    // rust: "minecraft:sweet_berry_bush" => return Some("minecraft:patch_berry_bush"),
    // rust: "minecraft:cactus" => return Some("minecraft:patch_cactus"),
    // rust: _ => {}
}
    // rust: } else if provider == "minecraft:weighted_state_provider"
    // rust: && (first == "minecraft:grass" || first == "minecraft:fern")
    // rust: {
    // rust: return Some("minecraft:patch_taiga_grass");
}
}
    // rust: "minecraft:block_pile" => {
    // rust: if provider != "minecraft:simple_state_provider"
    // rust: && provider != "minecraft:rotated_block_provider"
    // rust: {
    // rust: if provider == "minecraft:weighted_state_provider" {
    // rust: match first.as_str() {
    // rust: "minecraft:packed_ice" | "minecraft:blue_ice" => {
    // rust: return Some("minecraft:pile_ice");
}
    // rust: "minecraft:jack_o_lantern" | "minecraft:pumpkin" => {
    // rust: return Some("minecraft:pile_pumpkin");
}
    // rust: _ => {}
}
}
    // rust: } else {
    // rust: match state.as_str() {
    // rust: "minecraft:hay_block" => return Some("minecraft:pile_hay"),
    // rust: "minecraft:melon" => return Some("minecraft:pile_melon"),
    // rust: "minecraft:snow" => return Some("minecraft:pile_snow"),
    // rust: _ => {}
}
}
}
    // rust: "minecraft:flower" => return Some("minecraft:flower_plain"),
    // rust: "minecraft:tree" => match foliage.as_str() {
    // rust: "minecraft:acacia_foliage_placer" => return Some("minecraft:acacia"),
    // rust: "minecraft:blob_foliage_placer" if leaves == "minecraft:oak_leaves" => {
    // rust: return Some("minecraft:oak");
}
    // rust: "minecraft:pine_foliage_placer" => return Some("minecraft:pine"),
    // rust: "minecraft:spruce_foliage_placer" => return Some("minecraft:spruce"),
    // rust: _ => {}
    // rust: },
    // rust: _ => {}
}
    // rust: None
}

// `AbstractArrowPickupFix`.
arrow_pickup :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let id = as_str(e.get("id")).map(|s| super::dynamic::namespaced(&s));
    // rust: if !matches!(
    // rust: id.as_deref(),
    // rust: Some("minecraft:arrow" | "minecraft:spectral_arrow" | "minecraft:trident")
    // rust: ) || e.get("pickup").is_some()
    // rust: {
    // rust: return;
}
    // rust: let from_player = as_bool(e.get("player"), true);
    // rust: set(e, "pickup", Tag::Byte(i8::from(from_player)));
    // rust: remove(e, "player");
    // rust: });
}

// `StatsRenameFix`: custom statistics and the objectives that count them.
    // rust: pub(super) fn stats_rename(cx: &mut Cx, table: &[(&str, &'static str)]) {
    // rust: let r = renamer(table);
    // rust: cx.each(Ty::Stats, |v| {
    // rust: if let Some(Tag::Compound(custom)) = v
    // rust: .get_mut("stats")
    // rust: .and_then(|s| s.get_mut("minecraft:custom"))
    // rust: {
    // rust: let old = std::mem::take(custom);
    // rust: for (k, value) in old {
    // rust: let name = super::dynamic::namespaced(&k.to_string_lossy());
    // rust: let name = r(&name).map_or(name, str::to_owned);
    // rust: custom.insert(JavaString::from(name.as_str()), value);
}
}
    // rust: });
    // rust: cx.each(Ty::Objective, |v| {
    // rust: if let Some(ct) = v.get_mut("CriteriaType")
    // rust: && as_str(ct.get("type")).as_deref() == Some("minecraft:custom")
    // rust: && let Some(id) = as_str(ct.get("id"))
    // rust: {
    // rust: let id = super::dynamic::namespaced(&id);
    // rust: let new = r(&id).map_or(id, str::to_owned);
    // rust: set(ct, "id", string(&new));
}
    // rust: });
}

// ------------------------------------------------------------------ 2825 to 2843

// `AddFlagIfNotPresentFix` over the world generation settings.
    // rust: pub(super) fn add_flag(cx: &mut Cx, flag: &str, value: bool) {
    // rust: cx.each(Ty::WorldGenSettings, |v| {
    // rust: if let Tag::Compound(_) = v
    // rust: && v.get(flag).is_none()
    // rust: {
    // rust: set(v, flag, Tag::Byte(i8::from(value)));
}
    // rust: });
}

// `SpawnerDataFix`: spawn data and potentials wrapped as weighted entries.
spawner_data :: proc(cx: ^Cx) {
}
//     use super::schema::flat::UNTYPED;
    // rust: cx.each(Ty::UntaggedSpawner, |v| {
        // Only what read as typed is wrapped.
    // rust: if v.get("SpawnData").is_some_and(|d| d.get(UNTYPED).is_none())
    // rust: && let Some(data) = remove(v, "SpawnData")
    // rust: {
    // rust: set(v, "SpawnData", Tag::compound([("entity", data)]));
}
    // rust: let untyped = |entries: &Tag| {
    // rust: stream(Some(entries))
    // rust: .iter()
    // rust: .any(|e| e.get("Entity").is_some_and(|t| t.get(UNTYPED).is_some()))
}
    // rust: if let Some(potentials) = v.get("SpawnPotentials").filter(|p| !untyped(p)).cloned() {
    // rust: let entries = stream(Some(&potentials))
    // rust: .into_iter()
    // rust: .map(|mut entry| {
    // rust: let weight = entry
    // rust: .get("Weight")
    // rust: .and_then(as_number)
    // rust: .map_or(1, |n| n.int_value());
    // rust: let entity = remove(&mut entry, "Entity");
    // rust: remove(&mut entry, "Weight");
    // rust: if let Some(e) = entity {
    // rust: set(&mut entry, "entity", e);
}
    // rust: Tag::compound([("weight", Tag::Int(weight)), ("data", entry)])
    // rust: })
    // rust: .collect();
    // rust: set(v, "SpawnPotentials", Tag::List(entries));
}
    // rust: });
}

// `WorldGenSettingsHeightAndBiomeFix`.
world_gen_height_and_biome :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::WorldGenSettings, |v| {
    // rust: let flag = v.get("has_increased_height_already").cloned();
    // rust: let was_exp_snap = flag.is_none();
    // rust: let was_previously_increased = flag.as_ref().is_none_or(|f| as_bool(Some(f), true));
    // rust: remove(v, "has_increased_height_already");
    // rust: let Some(generator) = v
    // rust: .get_mut("dimensions")
    // rust: .and_then(|d| d.get_mut("minecraft:overworld"))
    // rust: .and_then(|o| o.get_mut("generator"))
    // rust: else {
    // rust: return;
}
    // rust: match as_str(generator.get("type")).as_deref() {
    // rust: Some("minecraft:noise") => {
    // rust: let mut large = false;
    // rust: if let Some(source) = generator.get_mut("biome_source") {
    // rust: let ty = as_str(source.get("type")).unwrap_or_default();
    // rust: if ty == "minecraft:vanilla_layered"
    // rust: || (was_exp_snap && ty == "minecraft:multi_noise")
    // rust: {
    // rust: large = as_bool(source.get("large_biomes"), false);
    // rust: *source = Tag::compound([
    // rust: ("preset", string("minecraft:overworld")),
    // rust: ("type", string("minecraft:multi_noise")),
    // rust: ]);
}
}
    // rust: if large
    // rust: && let Some(settings) = generator.get_mut("settings")
    // rust: && as_str(Some(settings)).as_deref() == Some("minecraft:overworld")
    // rust: {
    // rust: *settings = string("minecraft:large_biomes");
}
}
    // rust: Some("minecraft:flat") if !was_previously_increased => {
    // rust: if let Some(layers) = generator
    // rust: .get_mut("settings")
    // rust: .and_then(|s| s.get_mut("layers"))
    // rust: {
    // rust: let air = Tag::compound([
    // rust: ("height", Tag::Int(64)),
    // rust: ("block", string("minecraft:air")),
    // rust: ]);
    // rust: let mut list = vec![air];
    // rust: list.extend(stream(Some(layers)));
    // rust: *layers = Tag::List(list);
}
}
    // rust: _ => {}
}
    // rust: });
}

    // rust: const STATUS_IS_OR_AFTER_SURFACE: &[&str] = &[
    // rust: "surface",
    // rust: "carvers",
    // rust: "liquid_carvers",
    // rust: "features",
    // rust: "light",
    // rust: "spawn",
    // rust: "heightmaps",
    // rust: "full",
    // rust: ];
    // rust: const STATUS_IS_OR_AFTER_NOISE: &[&str] = &[
    // rust: "noise",
    // rust: "surface",
    // rust: "carvers",
    // rust: "liquid_carvers",
    // rust: "features",
    // rust: "light",
    // rust: "spawn",
    // rust: "heightmaps",
    // rust: "full",
    // rust: ];
    // rust: const BLOCKS_BEFORE_FEATURE_STATUS: &[&str] = &[
    // rust: "minecraft:air",
    // rust: "minecraft:basalt",
    // rust: "minecraft:bedrock",
    // rust: "minecraft:blackstone",
    // rust: "minecraft:calcite",
    // rust: "minecraft:cave_air",
    // rust: "minecraft:coarse_dirt",
    // rust: "minecraft:crimson_nylium",
    // rust: "minecraft:dirt",
    // rust: "minecraft:end_stone",
    // rust: "minecraft:grass_block",
    // rust: "minecraft:gravel",
    // rust: "minecraft:ice",
    // rust: "minecraft:lava",
    // rust: "minecraft:mycelium",
    // rust: "minecraft:nether_wart_block",
    // rust: "minecraft:netherrack",
    // rust: "minecraft:orange_terracotta",
    // rust: "minecraft:packed_ice",
    // rust: "minecraft:podzol",
    // rust: "minecraft:powder_snow",
    // rust: "minecraft:red_sand",
    // rust: "minecraft:red_sandstone",
    // rust: "minecraft:sand",
    // rust: "minecraft:sandstone",
    // rust: "minecraft:snow_block",
    // rust: "minecraft:soul_sand",
    // rust: "minecraft:soul_soil",
    // rust: "minecraft:stone",
    // rust: "minecraft:terracotta",
    // rust: "minecraft:warped_nylium",
    // rust: "minecraft:warped_wart_block",
    // rust: "minecraft:water",
    // rust: "minecraft:white_terracotta",
    // rust: ];
    // rust: const HEIGHTMAP_TYPES: &[&str] = &[
    // rust: "WORLD_SURFACE_WG",
    // rust: "WORLD_SURFACE",
    // rust: "WORLD_SURFACE_IGNORE_SNOW",
    // rust: "OCEAN_FLOOR_WG",
    // rust: "OCEAN_FLOOR",
    // rust: "MOTION_BLOCKING",
    // rust: "MOTION_BLOCKING_NO_LEAVES",
    // rust: ];

// `ChunkHeightAndBiomeFix.BIOMES_BY_ID`.
biome_by_id :: proc(id: i32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: 0 => "minecraft:ocean",
    // rust: 1 => "minecraft:plains",
    // rust: 2 => "minecraft:desert",
    // rust: 3 => "minecraft:mountains",
    // rust: 4 => "minecraft:forest",
    // rust: 5 => "minecraft:taiga",
    // rust: 6 => "minecraft:swamp",
    // rust: 7 => "minecraft:river",
    // rust: 8 => "minecraft:nether_wastes",
    // rust: 9 => "minecraft:the_end",
    // rust: 10 => "minecraft:frozen_ocean",
    // rust: 11 => "minecraft:frozen_river",
    // rust: 12 => "minecraft:snowy_tundra",
    // rust: 13 => "minecraft:snowy_mountains",
    // rust: 14 => "minecraft:mushroom_fields",
    // rust: 15 => "minecraft:mushroom_field_shore",
    // rust: 16 => "minecraft:beach",
    // rust: 17 => "minecraft:desert_hills",
    // rust: 18 => "minecraft:wooded_hills",
    // rust: 19 => "minecraft:taiga_hills",
    // rust: 20 => "minecraft:mountain_edge",
    // rust: 21 => "minecraft:jungle",
    // rust: 22 => "minecraft:jungle_hills",
    // rust: 23 => "minecraft:jungle_edge",
    // rust: 24 => "minecraft:deep_ocean",
    // rust: 25 => "minecraft:stone_shore",
    // rust: 26 => "minecraft:snowy_beach",
    // rust: 27 => "minecraft:birch_forest",
    // rust: 28 => "minecraft:birch_forest_hills",
    // rust: 29 => "minecraft:dark_forest",
    // rust: 30 => "minecraft:snowy_taiga",
    // rust: 31 => "minecraft:snowy_taiga_hills",
    // rust: 32 => "minecraft:giant_tree_taiga",
    // rust: 33 => "minecraft:giant_tree_taiga_hills",
    // rust: 34 => "minecraft:wooded_mountains",
    // rust: 35 => "minecraft:savanna",
    // rust: 36 => "minecraft:savanna_plateau",
    // rust: 37 => "minecraft:badlands",
    // rust: 38 => "minecraft:wooded_badlands_plateau",
    // rust: 39 => "minecraft:badlands_plateau",
    // rust: 40 => "minecraft:small_end_islands",
    // rust: 41 => "minecraft:end_midlands",
    // rust: 42 => "minecraft:end_highlands",
    // rust: 43 => "minecraft:end_barrens",
    // rust: 44 => "minecraft:warm_ocean",
    // rust: 45 => "minecraft:lukewarm_ocean",
    // rust: 46 => "minecraft:cold_ocean",
    // rust: 47 => "minecraft:deep_warm_ocean",
    // rust: 48 => "minecraft:deep_lukewarm_ocean",
    // rust: 49 => "minecraft:deep_cold_ocean",
    // rust: 50 => "minecraft:deep_frozen_ocean",
    // rust: 127 => "minecraft:the_void",
    // rust: 129 => "minecraft:sunflower_plains",
    // rust: 130 => "minecraft:desert_lakes",
    // rust: 131 => "minecraft:gravelly_mountains",
    // rust: 132 => "minecraft:flower_forest",
    // rust: 133 => "minecraft:taiga_mountains",
    // rust: 134 => "minecraft:swamp_hills",
    // rust: 140 => "minecraft:ice_spikes",
    // rust: 149 => "minecraft:modified_jungle",
    // rust: 151 => "minecraft:modified_jungle_edge",
    // rust: 155 => "minecraft:tall_birch_forest",
    // rust: 156 => "minecraft:tall_birch_hills",
    // rust: 157 => "minecraft:dark_forest_hills",
    // rust: 158 => "minecraft:snowy_taiga_mountains",
    // rust: 160 => "minecraft:giant_spruce_taiga",
    // rust: 161 => "minecraft:giant_spruce_taiga_hills",
    // rust: 162 => "minecraft:modified_gravelly_mountains",
    // rust: 163 => "minecraft:shattered_savanna",
    // rust: 164 => "minecraft:shattered_savanna_plateau",
    // rust: 165 => "minecraft:eroded_badlands",
    // rust: 166 => "minecraft:modified_wooded_badlands_plateau",
    // rust: 167 => "minecraft:modified_badlands_plateau",
    // rust: 168 => "minecraft:bamboo_jungle",
    // rust: 169 => "minecraft:bamboo_jungle_hills",
    // rust: 170 => "minecraft:soul_sand_valley",
    // rust: 171 => "minecraft:crimson_forest",
    // rust: 172 => "minecraft:warped_forest",
    // rust: 173 => "minecraft:basalt_deltas",
    // rust: 174 => "minecraft:dripstone_caves",
    // rust: 175 => "minecraft:lush_caves",
    // rust: 177 => "minecraft:meadow",
    // rust: 178 => "minecraft:grove",
    // rust: 179 => "minecraft:snowy_slopes",
    // rust: 180 => "minecraft:snowcapped_peaks",
    // rust: 181 => "minecraft:lofty_peaks",
    // rust: 182 => "minecraft:stony_peaks",
    // rust: _ => "minecraft:plains",
}
}

paletted :: proc(palette: Tag, data: Maybe(Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Tag::compound([("palette", palette)]);
    // rust: if let Some(d) = data {
    // rust: set(&mut out, "data", d);
}
    // rust: out
}

// `ChunkHeightAndBiomeFix.makeBiomeContainer`.
biome_container :: proc(source: impl Fn(uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut ids: Vec<i32> = Vec::new();
    // rust: for i in 0..64 {
    // rust: let id = source(i);
    // rust: if !ids.contains(&id) {
    // rust: ids.push(id);
}
}
    // rust: let palette = Tag::List(ids.iter().map(|&id| string(biome_by_id(id))).collect());
    // rust: let bits = ceillog2(ids.len()) as usize;
    // rust: if bits == 0 {
    // rust: return paletted(palette, None);
}
    // rust: let per_long = 64 / bits;
    // rust: let mut storage = vec![0i64; 64_usize.div_ceil(per_long)];
    // rust: let (mut cell, mut bit) = (0, 0);
    // rust: for i in 0..64 {
    // rust: let index = ids.iter().position(|&x| x == source(i)).unwrap_or(0) as i64;
    // rust: storage[cell] |= index << bit;
    // rust: bit += bits;
    // rust: if bit + bits > 64 {
    // rust: cell += 1;
    // rust: bit = 0;
}
}
    // rust: paletted(palette, Some(Tag::LongArray(storage)))
}

// `ChunkHeightAndBiomeFix.getBiomeContainers`: the containers and whether the
// chunk was already saved with the increased height.
biome_containers :: proc(level: ^Tag, overworld: bool, min_section: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let count = if overworld { 24 } else { 16 };
    // rust: let old = as_int_stream(level.get("Biomes"));
    // rust: let get = |old: &[i32], i: usize| old[i] & 0xFF;
    // rust: match old {
    // rust: Some(old) if old.len() == 1536 => {
    // rust: let containers = (0..24)
    // rust: .map(|y| biome_container(|i| get(&old, y * 64 + i)))
    // rust: .collect();
    // rust: (containers, true)
}
    // rust: Some(old) if old.len() == 1024 => {
    // rust: let mut containers = vec![Tag::End; count];
    // rust: for y in 0..16 {
    // rust: containers[(y - min_section) as usize] =
    // rust: biome_container(|i| get(&old, y as usize * 64 + i));
}
    // rust: if overworld {
    // rust: let below = biome_container(|i| get(&old, i % 16));
    // rust: let above = biome_container(|i| get(&old, i % 16 + 1008));
    // rust: for c in containers.iter_mut().take(4) {
    // rust: *c = below.clone();
}
    // rust: for c in containers.iter_mut().skip(20) {
    // rust: *c = above.clone();
}
}
    // rust: (containers, false)
}
    // rust: _ => {
    // rust: let plains = paletted(Tag::List(vec![string("minecraft:plains")]), None);
    // rust: (vec![plains; count], false)
}
}
}

// `ChunkProtoTickListFix.PoorMansPalettedContainer`.
PoorMansContainer :: struct {
    palette: [dynamic]Tag,
    data: [dynamic]i64,
}

    // rust: impl PoorMansContainer {
get :: proc(self: ^Self, x: uint, y: uint, z: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.palette.len() {
    // rust: 0 => None,
    // rust: 1 => self.palette.first(),
    // rust: n => {
    // rust: let bits = ceillog2(n).max(4) as usize;
    // rust: let per_long = 64 / bits;
    // rust: let index = (((y << 4) | z) << 4) | x;
    // rust: let cell = index / per_long;
    // rust: let value = *self.data.get(cell)?;
    // rust: let bit = (index - cell * per_long) * bits;
    // rust: let i = ((value >> bit) & ((1i64 << bits) - 1)) as usize;
    // rust: self.palette.get(i)
}
}
}
of :: proc(container: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: palette: stream(container.get("palette")),
    // rust: data: as_long_stream(container.get("data")).unwrap_or_default(),
}
}
}

block_name :: proc(state: Maybe(^Tag), default: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: state.map_or_else(
    // rust: || default.to_owned(),
    // rust: |s| as_str(s.get("Name")).unwrap_or_else(|| default.to_owned()),
    // rust: )
}

// `ChunkHeightAndBiomeFix.makeOptimizedPalettedContainer`.
optimized_container :: proc(palette: ^Tag, data: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut list = stream(Some(palette));
    // rust: if list.len() == 1 {
    // rust: return paletted(palette.clone(), None);
}
    // rust: let bits = as_long_stream(Some(data)).map_or(0, |d| d.len() as i64) * 64 / 4096;
    // rust: let expected = i64::from(ceillog2(list.len()));
    // rust: if bits <= expected {
    // rust: return paletted(palette.clone(), Some(data.clone()));
}
    // rust: let air = Tag::compound([("Name", string("minecraft:air"))]);
    // rust: let minimum = (1i64 << (bits - 1)) + 1;
    // rust: for _ in 0..(minimum - list.len() as i64) {
    // rust: list.push(air.clone());
}
    // rust: paletted(Tag::List(list), Some(data.clone()))
}

// `ChunkHeightAndBiomeFix`.
chunk_height_and_biome :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let context = chunk.get("__context");
    // rust: let dimension = context
    // rust: .and_then(|c| as_str(c.get("dimension")))
    // rust: .unwrap_or_default();
    // rust: let generator = context
    // rust: .and_then(|c| as_str(c.get("generator")))
    // rust: .unwrap_or_default();
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: let overworld = dimension == "minecraft:overworld";
    // rust: let min_section = if overworld { -4 } else { 0 };
    // rust: let (biomes, was_increased) = biome_containers(level, overworld, min_section);
    // rust: let air = paletted(
    // rust: Tag::List(vec![Tag::compound([("Name", string("minecraft:air"))])]),
    // rust: None,
    // rust: );
    // rust: let mut blocks_in_chunk: Vec<String> = Vec::new();
    // rust: let mut bedrock: Option<PoorMansContainer> = None;
    // rust: if let Some(sections) = level.get("Sections").cloned() {
    // rust: let mut done: Vec<i32> = Vec::new();
    // rust: let mut out = Vec::new();
    // rust: for mut section in stream(Some(&sections)) {
    // rust: let y = as_int(section.get("Y"), 0);
    // rust: let container = match section.get("Palette") {
    // rust: Some(palette) => {
    // rust: for state in stream(Some(palette)) {
    // rust: let name = block_name(Some(&state), "minecraft:air");
    // rust: if !blocks_in_chunk.contains(&name) {
    // rust: blocks_in_chunk.push(name);
}
}
    // rust: match section.get("BlockStates") {
    // rust: Some(data) => optimized_container(palette, data),
    // rust: None => air.clone(),
}
}
    // rust: None => air.clone(),
}
    // rust: let index = y - min_section;
    // rust: if index >= 0 && (index as usize) < biomes.len() {
    // rust: set(&mut section, "biomes", biomes[index as usize].clone());
}
    // rust: if !done.contains(&y) {
    // rust: done.push(y);
}
    // rust: if section.get("Y").and_then(as_number).map(|n| n.int_value()) == Some(0) {
    // rust: bedrock = Some(PoorMansContainer::of(&container));
}
    // rust: set(&mut section, "block_states", container);
    // rust: remove(&mut section, "Palette");
    // rust: remove(&mut section, "BlockStates");
    // rust: out.push(section);
}
    // rust: for (i, b) in biomes.iter().enumerate() {
    // rust: let y = i as i32 + min_section;
    // rust: if !done.contains(&y) {
    // rust: done.push(y);
    // rust: out.push(Tag::compound([
    // rust: ("Y", Tag::Int(y)),
    // rust: ("block_states", air.clone()),
    // rust: ("biomes", b.clone()),
    // rust: ]));
}
}
    // rust: set(level, "Sections", Tag::List(out));
}
    // rust: if overworld {
    // rust: predict_status_before_surface(level, &mut blocks_in_chunk);
}
    // rust: update_chunk_tag(
    // rust: level,
    // rust: overworld,
    // rust: was_increased,
    // rust: generator == "minecraft:noise",
    // rust: bedrock.as_ref(),
    // rust: );
    // rust: });
}

predict_status_before_surface :: proc(level: ^Tag, blocks: ^[dynamic]string) {
}
    // rust: let Some(status) = level.get("Status") else {
    // rust: return;
}
    // rust: let current = as_str(Some(status)).unwrap_or_else(|| "empty".into());
    // rust: if STATUS_IS_OR_AFTER_SURFACE.contains(&current.as_str()) {
    // rust: return;
}
    // rust: blocks.retain(|b| b != "minecraft:air");
    // rust: let has_non_air = !blocks.is_empty();
    // rust: blocks.retain(|b| !BLOCKS_BEFORE_FEATURE_STATUS.contains(&b.as_str()));
    // rust: let has_feature_blocks = !blocks.is_empty();
    // rust: let new = if has_feature_blocks {
    // rust: Some("liquid_carvers")
    // rust: } else if current == "noise" || has_non_air {
    // rust: Some("noise")
    // rust: } else if current == "biomes" {
    // rust: Some("structure_references")
    // rust: } else {
    // rust: None
}
    // rust: if let Some(new) = new {
    // rust: set(level, "Status", string(new));
}
}

    // rust: fn update_chunk_tag(
    // rust: level: &mut Tag,
    // rust: overworld: bool,
    // rust: was_increased: bool,
    // rust: blending: bool,
    // rust: bedrock: Option<&PoorMansContainer>,
    // rust: ) {
    // rust: remove(level, "Biomes");
    // rust: if !overworld {
    // rust: return update_carving_masks(level, 16, 0);
}
    // rust: if was_increased {
    // rust: return update_carving_masks(level, 24, 0);
}
    // rust: if let Some(Tag::Compound(maps)) = level.get_mut("Heightmaps") {
    // rust: for ty in HEIGHTMAP_TYPES {
    // rust: if let Some(h) = maps.get_mut(&super::dynamic::key(ty)) {
    // rust: let values = as_long_stream(Some(h)).unwrap_or_default();
    // rust: *h = Tag::LongArray(values.into_iter().map(fixed_heightmap_long).collect());
}
}
}
    // rust: for key in ["LiquidsToBeTicked", "PostProcessing", "ToBeTicked"] {
    // rust: let mut list = stream(level.get(key));
    // rust: if list.len() != 24 {
    // rust: for _ in 0..4 {
    // rust: list.insert(0, Tag::List(Vec::new()));
    // rust: list.push(Tag::List(Vec::new()));
}
    // rust: set(level, key, Tag::List(list));
}
}
    // rust: update_carving_masks(level, 24, 4);
    // rust: if let Some(upgrade) = level.get_mut("UpgradeData")
    // rust: && let Some(indices) = upgrade.get("Indices")
    // rust: {
    // rust: let mut shifted = Compound::new();
    // rust: if let Tag::Compound(c) = indices {
    // rust: for (k, v) in c {
    // rust: if let Ok(i) = k.to_string_lossy().parse::<i32>() {
    // rust: shifted.insert(JavaString::from((i + 4).to_string().as_str()), v.clone());
}
}
}
    // rust: set(upgrade, "Indices", Tag::Compound(shifted));
}
    // rust: if !blending {
    // rust: return;
}
    // rust: let Some(status) = level.get("Status").cloned() else {
    // rust: return;
}
    // rust: let last = as_str(Some(&status)).unwrap_or_default();
    // rust: if last == "empty" {
    // rust: return;
}
    // rust: set(
    // rust: level,
    // rust: "blending_data",
    // rust: Tag::compound([(
    // rust: "old_noise",
    // rust: Tag::Byte(i8::from(STATUS_IS_OR_AFTER_NOISE.contains(&last.as_str()))),
    // rust: )]),
    // rust: );
    // rust: let Some(container) = bedrock else {
    // rust: return;
}
    // rust: let mut missing = [0u64; 4];
    // rust: let mut any_bedrock = last == "noise";
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let state = container.get(x, 0, z);
    // rust: let name = state.map(|s| as_str(s.get("Name")).unwrap_or_default());
    // rust: if name.as_deref() == Some("minecraft:air") {
    // rust: let bit = z * 16 + x;
    // rust: missing[bit / 64] |= 1 << (bit % 64);
}
    // rust: any_bedrock |= name.as_deref() == Some("minecraft:bedrock");
}
}
    // rust: let cardinality: u32 = missing.iter().map(|w| w.count_ones()).sum();
    // rust: if any_bedrock && cardinality != 256 {
    // rust: let target = if last == "full" {
    // rust: string("heightmaps")
    // rust: } else {
    // rust: status.clone()
}
        // `BitSet.toLongArray`: trailing zero words dropped.
    // rust: let used = missing.iter().rposition(|&w| w != 0).map_or(0, |i| i + 1);
    // rust: let words = missing[..used].iter().map(|&w| w as i64).collect();
    // rust: set(
    // rust: level,
    // rust: "below_zero_retrogen",
    // rust: Tag::compound([
    // rust: ("target_status", target),
    // rust: ("missing_bedrock", Tag::LongArray(words)),
    // rust: ]),
    // rust: );
    // rust: set(level, "Status", string("empty"));
}
    // rust: set(level, "isLightOn", Tag::Byte(0));
}

fixed_heightmap_long :: proc(value: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = 0i64;
    // rust: let mut bit = 0;
    // rust: while bit + 9 <= 64 {
    // rust: let old = (value >> bit) & 511;
    // rust: let new = if old == 0 { 0 } else { (old + 64).min(511) };
    // rust: out |= new << bit;
    // rust: bit += 9;
}
    // rust: out
}

update_carving_masks :: proc(level: ^Tag, sections: uint, below: uint) {
}
    // rust: let mut masks = match level.get("CarvingMasks") {
    // rust: Some(m) => m.clone(),
    // rust: None => empty_map(),
}
    // rust: if let Tag::Compound(c) = &mut masks {
    // rust: for v in c.values_mut() {
    // rust: let bytes = as_byte_buffer(Some(v)).unwrap_or_default();
            // `BitSet.valueOf(bytes).toLongArray()`: little-endian words,
            // trailing zero words dropped.
    // rust: let mut words: Vec<i64> = bytes
    // rust: .chunks(8)
    // rust: .map(|c| {
    // rust: let mut b = [0u8; 8];
    // rust: b[..c.len()].copy_from_slice(c);
    // rust: i64::from_le_bytes(b)
    // rust: })
    // rust: .collect();
    // rust: while words.last() == Some(&0) {
    // rust: words.pop();
}
    // rust: let mut out = vec![0i64; 64 * sections];
    // rust: out[64 * below..64 * below + words.len()].copy_from_slice(&words);
    // rust: *v = Tag::LongArray(out);
}
}
    // `updateMapValues` of something that is not a map leaves it unchanged.
    // rust: set(level, "CarvingMasks", masks);
}

liquid :: proc(state: Maybe(^Tag)) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let Some(state) = state else {
    // rust: return "minecraft:empty";
}
    // rust: let block = as_str(state.get("Name")).unwrap_or_default();
    // rust: let props = state.get("Properties");
    // rust: let level = || as_int(props.and_then(|p| p.get("level")), 0);
    // rust: match block.as_str() {
    // rust: "minecraft:water" => {
    // rust: if level() == 0 {
    // rust: "minecraft:water"
    // rust: } else {
    // rust: "minecraft:flowing_water"
}
}
    // rust: "minecraft:lava" => {
    // rust: if level() == 0 {
    // rust: "minecraft:lava"
    // rust: } else {
    // rust: "minecraft:flowing_lava"
}
}
    // rust: _ => {
    // rust: let always = matches!(
    // rust: block.as_str(),
    // rust: "minecraft:bubble_column"
    // rust: | "minecraft:kelp"
    // rust: | "minecraft:kelp_plant"
    // rust: | "minecraft:seagrass"
    // rust: | "minecraft:tall_seagrass"
    // rust: );
    // rust: if always || as_bool(props.and_then(|p| p.get("waterlogged")), false) {
    // rust: "minecraft:water"
    // rust: } else {
    // rust: "minecraft:empty"
}
}
}
}

// `ChunkProtoTickListFix`.
chunk_proto_tick_list :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: if let Some(t) = remove(level, "LiquidTicks") {
    // rust: set(level, "fluid_ticks", t);
}
    // rust: let mut lowest = 0i32;
    // rust: let mut containers: Vec<(i32, PoorMansContainer)> = Vec::new();
    // rust: for section in stream(level.get("Sections")) {
    // rust: let y = as_int(section.get("Y"), i32::MAX);
    // rust: if y == i32::MAX {
    // rust: continue;
}
    // rust: if section.get("biomes").is_some() {
    // rust: lowest = lowest.min(y);
}
    // rust: if let Some(container) = section.get("block_states") {
    // rust: match containers.iter_mut().find(|(sy, _)| *sy == y) {
    // rust: Some((_, c)) => *c = PoorMansContainer::of(container),
    // rust: None => containers.push((y, PoorMansContainer::of(container))),
}
}
}
    // rust: let min_y = lowest as i8;
    // rust: if level.get("yPos").is_some() {
    // rust: set(level, "yPos", Tag::Byte(min_y));
}
    // rust: if level.get("TileTicks").is_some() || level.get("fluid_ticks").is_some() {
    // rust: return;
}
    // rust: let x = as_int(level.get("xPos"), 0);
    // rust: let z = as_int(level.get("zPos"), 0);
    // rust: let make = |level: &Tag, key: &str, liquid_list: bool| {
    // rust: let mut out = Vec::new();
    // rust: for (index, positions) in stream(level.get(key)).iter().enumerate() {
    // rust: let section_y = index as i32 + i32::from(min_y);
    // rust: let container = containers
    // rust: .iter()
    // rust: .find(|(y, _)| *y == section_y)
    // rust: .map(|(_, c)| c);
    // rust: for pos in stream(Some(positions)) {
    // rust: let pos = as_number(&pos).map_or(-1, |n| i32::from(n.int_value() as i16));
    // rust: if pos <= 0 {
    // rust: continue;
}
    // rust: let (rx, ry, rz) = (pos & 15, (pos >> 4) & 15, (pos >> 8) & 15);
    // rust: let state =
    // rust: container.and_then(|c| c.get(rx as usize, ry as usize, rz as usize));
    // rust: let ty = if liquid_list {
    // rust: liquid(state).to_owned()
    // rust: } else {
    // rust: block_name(state, "minecraft:air")
}
    // rust: out.push(Tag::compound([
    // rust: ("i", string(&ty)),
    // rust: ("x", Tag::Int(x * 16 + rx)),
    // rust: ("y", Tag::Int(section_y * 16 + ry)),
    // rust: ("z", Tag::Int(z * 16 + rz)),
    // rust: ("t", Tag::Int(0)),
    // rust: ("p", Tag::Int(0)),
    // rust: ]));
}
}
    // rust: Tag::List(out)
}
    // rust: let fluid_ticks = make(level, "LiquidsToBeTicked", true);
    // rust: let block_ticks = make(level, "ToBeTicked", false);
    // rust: set(level, "TileTicks", block_ticks);
    // rust: remove(level, "ToBeTicked");
    // rust: remove(level, "LiquidsToBeTicked");
    // rust: set(level, "fluid_ticks", fluid_ticks);
    // rust: });
}

// `ChunkRenamesFix`: the Level tag merged into the chunk, fields renamed.
chunk_renames :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let Some(Tag::Compound(level)) = remove(chunk, "Level") else {
    // rust: return;
}
    // rust: for (k, v) in level {
    // rust: if let Tag::Compound(c) = chunk {
    // rust: c.insert(k, v);
}
}
    // rust: for (from, to) in [
    // rust: ("TileEntities", "block_entities"),
    // rust: ("TileTicks", "block_ticks"),
    // rust: ("Entities", "entities"),
    // rust: ("Sections", "sections"),
    // rust: ] {
    // rust: rename(chunk, from, to);
}
    // rust: if let Some(s) = chunk.get_mut("Structures") {
    // rust: rename(s, "Starts", "starts");
}
    // rust: rename(chunk, "Structures", "structures");
    // rust: });
}

// `OverreachingTickFix`.
overreaching_ticks :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let x = as_int(chunk.get("xPos"), 0);
    // rust: let z = as_int(chunk.get("zPos"), 0);
    // rust: for (list, name) in [
    // rust: ("block_ticks", "neighbor_block_ticks"),
    // rust: ("fluid_ticks", "neighbor_fluid_ticks"),
    // rust: ] {
    // rust: let Some(ticks) = chunk.get(list) else {
    // rust: continue;
}
    // rust: let over: Vec<Tag> = stream(Some(ticks))
    // rust: .into_iter()
    // rust: .filter(|t| {
    // rust: let dx = (x - (as_int(t.get("x"), 0) >> 4)).abs();
    // rust: let dz = (z - (as_int(t.get("z"), 0) >> 4)).abs();
    // rust: (dx != 0 || dz != 0) && dx <= 1 && dz <= 1
    // rust: })
    // rust: .collect();
    // rust: if !over.is_empty() {
    // rust: let mut upgrade = chunk.get("UpgradeData").cloned().unwrap_or_else(empty_map);
    // rust: set(&mut upgrade, name, Tag::List(over));
    // rust: set(chunk, "UpgradeData", upgrade);
}
}
    // rust: });
}

// `CavesAndCliffsRenames`.
    // rust: const CAVES_AND_CLIFFS: &[(&str, &str)] = &[
    // rust: ("minecraft:badlands_plateau", "minecraft:badlands"),
    // rust: ("minecraft:bamboo_jungle_hills", "minecraft:bamboo_jungle"),
    // rust: ("minecraft:birch_forest_hills", "minecraft:birch_forest"),
    // rust: ("minecraft:dark_forest_hills", "minecraft:dark_forest"),
    // rust: ("minecraft:desert_hills", "minecraft:desert"),
    // rust: ("minecraft:desert_lakes", "minecraft:desert"),
    // rust: (
    // rust: "minecraft:giant_spruce_taiga_hills",
    // rust: "minecraft:old_growth_spruce_taiga",
    // rust: ),
    // rust: (
    // rust: "minecraft:giant_spruce_taiga",
    // rust: "minecraft:old_growth_spruce_taiga",
    // rust: ),
    // rust: (
    // rust: "minecraft:giant_tree_taiga_hills",
    // rust: "minecraft:old_growth_pine_taiga",
    // rust: ),
    // rust: (
    // rust: "minecraft:giant_tree_taiga",
    // rust: "minecraft:old_growth_pine_taiga",
    // rust: ),
    // rust: (
    // rust: "minecraft:gravelly_mountains",
    // rust: "minecraft:windswept_gravelly_hills",
    // rust: ),
    // rust: ("minecraft:jungle_edge", "minecraft:sparse_jungle"),
    // rust: ("minecraft:jungle_hills", "minecraft:jungle"),
    // rust: ("minecraft:modified_badlands_plateau", "minecraft:badlands"),
    // rust: (
    // rust: "minecraft:modified_gravelly_mountains",
    // rust: "minecraft:windswept_gravelly_hills",
    // rust: ),
    // rust: ("minecraft:modified_jungle_edge", "minecraft:sparse_jungle"),
    // rust: ("minecraft:modified_jungle", "minecraft:jungle"),
    // rust: (
    // rust: "minecraft:modified_wooded_badlands_plateau",
    // rust: "minecraft:wooded_badlands",
    // rust: ),
    // rust: ("minecraft:mountain_edge", "minecraft:windswept_hills"),
    // rust: ("minecraft:mountains", "minecraft:windswept_hills"),
    // rust: (
    // rust: "minecraft:mushroom_field_shore",
    // rust: "minecraft:mushroom_fields",
    // rust: ),
    // rust: ("minecraft:shattered_savanna", "minecraft:windswept_savanna"),
    // rust: (
    // rust: "minecraft:shattered_savanna_plateau",
    // rust: "minecraft:windswept_savanna",
    // rust: ),
    // rust: ("minecraft:snowy_mountains", "minecraft:snowy_plains"),
    // rust: ("minecraft:snowy_taiga_hills", "minecraft:snowy_taiga"),
    // rust: ("minecraft:snowy_taiga_mountains", "minecraft:snowy_taiga"),
    // rust: ("minecraft:snowy_tundra", "minecraft:snowy_plains"),
    // rust: ("minecraft:stone_shore", "minecraft:stony_shore"),
    // rust: ("minecraft:swamp_hills", "minecraft:swamp"),
    // rust: ("minecraft:taiga_hills", "minecraft:taiga"),
    // rust: ("minecraft:taiga_mountains", "minecraft:taiga"),
    // rust: (
    // rust: "minecraft:tall_birch_forest",
    // rust: "minecraft:old_growth_birch_forest",
    // rust: ),
    // rust: (
    // rust: "minecraft:tall_birch_hills",
    // rust: "minecraft:old_growth_birch_forest",
    // rust: ),
    // rust: (
    // rust: "minecraft:wooded_badlands_plateau",
    // rust: "minecraft:wooded_badlands",
    // rust: ),
    // rust: ("minecraft:wooded_hills", "minecraft:forest"),
    // rust: ("minecraft:wooded_mountains", "minecraft:windswept_forest"),
    // rust: ("minecraft:lofty_peaks", "minecraft:jagged_peaks"),
    // rust: ("minecraft:snowcapped_peaks", "minecraft:frozen_peaks"),
    // rust: ];
