//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fixes_old
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fixes of 1.19 to 1.20 (keys 3076 to 3459): what worlds saved by 1.18.2 to
//! 1.19.4 need before the fixes of [`super::fixes_a`]. The options fixes of
//! this range (3201, 3214, 3319) are client settings, not world data.
// use super::dynamic::{
    // rust: as_number, as_str, is_list, namespaced, remove, rename, set, stream, string, update,
}
// use super::fixes_a::fix_block_pos;
// use super::fixes_b::feature_flag_remove;
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, id_is, renamer, reread_as};
// use crate::nbt::{Compound, Tag};

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(3077, 0), chunk_delete_ignored_light));
    // rust: out.push((key(3084, 0), |cx| {
    // rust: cx.rename(Ty::GameEventName, renamer(GAME_EVENTS))
    // rust: }));
    // rust: out.push((key(3086, 0), |cx| {
    // rust: entity_variant(cx, "minecraft:cat", "CatType", cat_type)
    // rust: }));
    // rust: out.push((key(3086, 0), |cx| {
    // rust: criteria_rename(cx, "minecraft:husbandry/complete_catalogue", &|s| {
    // rust: CAT_TEXTURES
    // rust: .iter()
    // rust: .find(|(from, _)| *from == s)
    // rust: .map(|(_, to)| (*to).to_owned())
    // rust: });
    // rust: }));
    // rust: out.push((key(3087, 0), |cx| {
    // rust: entity_variant(cx, "minecraft:frog", "Variant", |n| match n {
    // rust: 0 => Some("minecraft:temperate"),
    // rust: 1 => Some("minecraft:warm"),
    // rust: 2 => Some("minecraft:cold"),
    // rust: _ => None,
    // rust: })
    // rust: }));
    // rust: out.push((key(3090, 0), |cx| {
    // rust: cx.entity("minecraft:painting", |e| {
    // rust: rename(e, "Motive", "variant");
    // rust: rename(e, "Facing", "facing");
    // rust: })
    // rust: }));
    // rust: out.push((key(3093, 0), |cx| {
    // rust: cx.entity("minecraft:goat", |e| {
    // rust: set(e, "HasLeftHorn", Tag::Byte(1));
    // rust: set(e, "HasRightHorn", Tag::Byte(1));
    // rust: })
    // rust: }));
    // rust: out.push((key(3094, 0), goat_horn_id));
    // rust: out.push((key(3097, 0), filtered_books));
    // rust: out.push((key(3097, 0), filtered_signs));
    // rust: out.push((key(3097, 0), |cx| {
    // rust: cx.entity("minecraft:cat", |e| {
    // rust: if as_str(e.get("variant")).as_deref() == Some("minecraft:british") {
    // rust: set(e, "variant", string("minecraft:british_shorthair"));
}
    // rust: })
    // rust: }));
    // rust: out.push((key(3097, 0), |cx| {
    // rust: criteria_rename(cx, "minecraft:husbandry/complete_catalogue", &|s| {
    // rust: (s == "minecraft:british").then(|| "minecraft:british_shorthair".to_owned())
    // rust: });
    // rust: }));
    // rust: out.push((key(3097, 0), |cx| {
    // rust: poi_records(cx, |r| {
    // rust: !matches!(
    // rust: as_str(r.get("type")).as_deref(),
    // rust: Some("minecraft:unemployed" | "minecraft:nitwit") | None
    // rust: )
    // rust: })
    // rust: }));
    // rust: out.push((key(3108, 0), |cx| {
    // rust: cx.each_out(Ty::Chunk, |c| {
    // rust: let dimension = c.get("__context").and_then(|x| as_str(x.get("dimension")));
    // rust: if dimension.as_deref() != Some("minecraft:overworld") {
    // rust: remove(c, "blending_data");
}
    // rust: })
    // rust: }));
    // rust: out.push((key(3209, 0), pig_spawn_egg));
    // rust: out.push((key(3322, 0), effect_duration));
    // rust: out.push((key(3438, 0), |cx| {
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if id_is(be, "minecraft:suspicious_sand") {
    // rust: set(be, "id", string("minecraft:brushable_block"));
}
    // rust: })
    // rust: }));
    // rust: out.push((key(3438, 0), |cx| {
    // rust: cx.each_out(Ty::BlockEntity, |be| {
    // rust: if id_is(be, "minecraft:brushable_block") {
    // rust: rename(be, "loot_table", "LootTable");
    // rust: rename(be, "loot_table_seed", "LootTableSeed");
}
    // rust: })
    // rust: }));
    // rust: out.push((key(3438, 0), |cx| {
    // rust: cx.rename(Ty::ItemName, renamer(POTTERY_SHARDS))
    // rust: }));
    // rust: out.push((key(3439, 0), |cx| sign_double_sided(cx, "minecraft:sign")));
    // rust: out.push((key(3439, 1), |cx| {
    // rust: sign_double_sided(cx, "minecraft:hanging_sign")
    // rust: }));
    // rust: out.push((key(3440, 0), multi_noise_preset));
    // rust: out.push((key(3440, 0), |cx| {
    // rust: feature_flag_remove(cx, &["minecraft:update_1_20"])
    // rust: }));
    // rust: out.push((key(3447, 0), |cx| {
    // rust: cx.rename(Ty::ItemName, |id| {
    // rust: let id = namespaced(id);
    // rust: POTTERY_SHERDS
    // rust: .iter()
    // rust: .find(|(from, _)| *from == id)
    // rust: .map(|(_, to)| *to)
    // rust: })
    // rust: }));
    // DecoratedPotFieldRenameFix converts unchecked: the typed shards are written
    // as sherds, and the raw shards come back from the block entity's remainder.
    // rust: out.push((key(3448, 0), |cx| {
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if id_is(be, "minecraft:decorated_pot")
    // rust: && let Some(shards) = be.get("shards").cloned()
    // rust: {
    // rust: set(be, "sherds", shards);
    // rust: super::drop_typed(be, "shards");
}
    // rust: })
    // rust: }));
    // rust: out.push((key(3450, 0), remap_chunk_status));
    // rust: out.push((key(3451, 0), chunk_delete_light));
    // rust: out.push((key(3459, 0), legacy_dragon_fight));
}

// ------------------------------------------------------------------ 3077, 3451

/// `ChunkDeleteIgnoredLightDataFix`.
pub fn chunk_delete_ignored_light(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: let light_on = c
    // rust: .get("isLightOn")
    // rust: .and_then(as_number)
    // rust: .is_some_and(|n| n.double_value() != 0.0);
    // rust: if !light_on && let Some(Tag::List(sections)) = c.get_mut("sections") {
    // rust: for s in sections {
    // rust: remove(s, "BlockLight");
    // rust: remove(s, "SkyLight");
}
}
    // rust: });
}

/// `ChunkDeleteLightFix`.
pub fn chunk_delete_light(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: remove(c, "isLightOn");
    // rust: if let Some(Tag::List(sections)) = c.get_mut("sections") {
    // rust: for s in sections {
    // rust: remove(s, "BlockLight");
    // rust: remove(s, "SkyLight");
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3084

    // rust: const GAME_EVENTS: &[(&str, &str)] = &[
    // rust: ("minecraft:block_press", "minecraft:block_activate"),
    // rust: ("minecraft:block_switch", "minecraft:block_activate"),
    // rust: ("minecraft:block_unpress", "minecraft:block_deactivate"),
    // rust: ("minecraft:block_unswitch", "minecraft:block_deactivate"),
    // rust: ("minecraft:drinking_finish", "minecraft:drink"),
    // rust: ("minecraft:elytra_free_fall", "minecraft:elytra_glide"),
    // rust: ("minecraft:entity_damaged", "minecraft:entity_damage"),
    // rust: ("minecraft:entity_dying", "minecraft:entity_die"),
    // rust: ("minecraft:entity_killed", "minecraft:entity_die"),
    // rust: ("minecraft:mob_interact", "minecraft:entity_interact"),
    // rust: ("minecraft:ravager_roar", "minecraft:entity_roar"),
    // rust: ("minecraft:ring_bell", "minecraft:block_change"),
    // rust: ("minecraft:shulker_close", "minecraft:container_close"),
    // rust: ("minecraft:shulker_open", "minecraft:container_open"),
    // rust: ("minecraft:wolf_shaking", "minecraft:entity_shake"),
    // rust: ];

// ------------------------------------------------------------------ 3086, 3087, 3097

pub fn cat_type(n: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match n {
    // rust: 1 => "minecraft:black",
    // rust: 2 => "minecraft:red",
    // rust: 3 => "minecraft:siamese",
    // rust: 4 => "minecraft:british",
    // rust: 5 => "minecraft:calico",
    // rust: 6 => "minecraft:persian",
    // rust: 7 => "minecraft:ragdoll",
    // rust: 8 => "minecraft:white",
    // rust: 9 => "minecraft:jellie",
    // rust: 10 => "minecraft:all_black",
        // The map's default return value.
    // rust: _ => "minecraft:tabby",
    // rust: })
}

/// `EntityVariantFix`: the numeric variant written to `variant`; the old field
/// stays (`updateAndRename` only sets the new key). An id the map has no entry
/// for gives Java's `null`, which `createString` cannot take: such a variant is
/// left as the number.
pub fn entity_variant(cx: *mut Cx, id: []const u8, field: []const u8, ids: fn(i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.entity(id, |e| {
    // rust: let Some(value) = e.get(field).cloned() else {
    // rust: return;
}
    // rust: let new = match as_number(&value).map(|n| ids(n.int_value())) {
    // rust: Some(Some(name)) => string(name),
    // rust: _ => value,
}
    // rust: set(e, "variant", new);
    // rust: });
}

    // rust: const CAT_TEXTURES: &[(&str, &str)] = &[
    // rust: ("textures/entity/cat/tabby.png", "minecraft:tabby"),
    // rust: ("textures/entity/cat/black.png", "minecraft:black"),
    // rust: ("textures/entity/cat/red.png", "minecraft:red"),
    // rust: ("textures/entity/cat/siamese.png", "minecraft:siamese"),
    // rust: (
    // rust: "textures/entity/cat/british_shorthair.png",
    // rust: "minecraft:british",
    // rust: ),
    // rust: ("textures/entity/cat/calico.png", "minecraft:calico"),
    // rust: ("textures/entity/cat/persian.png", "minecraft:persian"),
    // rust: ("textures/entity/cat/ragdoll.png", "minecraft:ragdoll"),
    // rust: ("textures/entity/cat/white.png", "minecraft:white"),
    // rust: ("textures/entity/cat/jellie.png", "minecraft:jellie"),
    // rust: ("textures/entity/cat/all_black.png", "minecraft:all_black"),
    // rust: ];

/// `CriteriaRenameFix`: the criteria keys of one advancement.
pub fn criteria_rename(cx: *mut Cx, advancement: []const u8, conversions: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.each(Ty::Advancements, |v| {
    // rust: let Some(criteria) = v.get_mut(advancement).and_then(|a| a.get_mut("criteria")) else {
    // rust: return;
}
    // rust: if let Tag::Compound(c) = criteria {
    // rust: let old = std::mem::take(c);
    // rust: for (k, value) in old {
    // rust: let name = k.to_string_lossy();
    // rust: let k = conversions(&name).map_or(k, |n| n.as_str().into());
    // rust: c.insert(k, value);
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3094, 3097

/// The `tag` of every stack whose id passes `filter` (`ItemStackTagFix`).
pub fn item_tag(cx: *mut Cx, filter: impl Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.item(filter, |s| {
    // rust: if let Some(tag) = s.get_mut("tag") {
    // rust: f(tag);
}
    // rust: });
}

    // rust: const INSTRUMENTS: [&str; 8] = [
    // rust: "minecraft:ponder_goat_horn",
    // rust: "minecraft:sing_goat_horn",
    // rust: "minecraft:seek_goat_horn",
    // rust: "minecraft:feel_goat_horn",
    // rust: "minecraft:admire_goat_horn",
    // rust: "minecraft:call_goat_horn",
    // rust: "minecraft:yearn_goat_horn",
    // rust: "minecraft:dream_goat_horn",
    // rust: ];

/// `GoatHornIdFix`.
pub fn goat_horn_id(cx: *mut Cx) void {
}
    // rust: item_tag(
    // rust: cx,
    // rust: |id| id == "minecraft:goat_horn",
    // rust: |tag| {
    // rust: let variant = super::dynamic::as_int(tag.get("SoundVariant"), 0);
    // rust: let sound = INSTRUMENTS[if (0..8).contains(&variant) {
    // rust: variant as usize
    // rust: } else {
    // rust: 0
    // rust: }];
    // rust: remove(tag, "SoundVariant");
    // rust: set(tag, "instrument", string(sound));
    // rust: },
    // rust: );
}

/// `FilteredBooksFix`.
pub fn filtered_books(cx: *mut Cx) void {
}
    // rust: item_tag(
    // rust: cx,
    // rust: |id| id == "minecraft:writable_book" || id == "minecraft:written_book",
    // rust: |tag| {
    // rust: remove(tag, "filtered_title");
    // rust: remove(tag, "filtered_pages");
    // rust: },
    // rust: );
}

/// `FilteredSignsFix` (a `NamedEntityWriteReadFix` over signs only).
pub fn filtered_signs(cx: *mut Cx) void {
}
    // rust: let k = cx.k;
    // rust: cx.block_entity("minecraft:sign", |be| {
    // rust: for i in 1..=4 {
    // rust: remove(be, &format!("FilteredText{i}"));
}
    // rust: reread_as(Ty::BlockEntity, k, be);
    // rust: });
}

/// `AbstractPoiSectionFix`: the records of every POI section kept by `keep`.
pub fn poi_records(cx: *mut Cx, keep: impl Fn(*Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.each(Ty::PoiChunk, |poi| {
    // rust: let Some(Tag::Compound(sections)) = poi.get_mut("Sections") else {
    // rust: return;
}
    // rust: for section in sections.values_mut() {
    // rust: if let Some(records) = section.get("Records")
    // rust: && is_list(Some(records))
    // rust: {
    // rust: let kept: Vec<Tag> = stream(Some(records))
    // rust: .into_iter()
    // rust: .filter(|r| keep(r))
    // rust: .collect();
    // rust: set(section, "Records", Tag::List(kept));
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3209

/// `ItemStackSpawnEggFix` for `minecraft:pig_spawn_egg`: an egg whose entity has
/// an id becomes that entity's egg.
pub fn pig_spawn_egg(cx: *mut Cx) void {
}
    // rust: cx.item(
    // rust: |id| id == "minecraft:pig_spawn_egg",
    // rust: |s| {
    // rust: let entity = s
    // rust: .get("tag")
    // rust: .and_then(|t| t.get("EntityTag"))
    // rust: .and_then(|e| as_str(e.get("id")));
    // rust: if let Some(entity) = entity {
    // rust: let egg = SPAWN_EGGS
    // rust: .iter()
    // rust: .find(|(e, _)| *e == namespaced(&entity))
    // rust: .map_or("minecraft:pig_spawn_egg", |(_, egg)| egg);
    // rust: set(s, "id", string(egg));
}
    // rust: },
    // rust: );
}

    // rust: const SPAWN_EGGS: &[(&str, &str)] = &[
    // rust: ("minecraft:bat", "minecraft:bat_spawn_egg"),
    // rust: ("minecraft:blaze", "minecraft:blaze_spawn_egg"),
    // rust: ("minecraft:cave_spider", "minecraft:cave_spider_spawn_egg"),
    // rust: ("minecraft:chicken", "minecraft:chicken_spawn_egg"),
    // rust: ("minecraft:cow", "minecraft:cow_spawn_egg"),
    // rust: ("minecraft:creeper", "minecraft:creeper_spawn_egg"),
    // rust: ("minecraft:donkey", "minecraft:donkey_spawn_egg"),
    // rust: (
    // rust: "minecraft:elder_guardian",
    // rust: "minecraft:elder_guardian_spawn_egg",
    // rust: ),
    // rust: ("minecraft:ender_dragon", "minecraft:ender_dragon_spawn_egg"),
    // rust: ("minecraft:enderman", "minecraft:enderman_spawn_egg"),
    // rust: ("minecraft:endermite", "minecraft:endermite_spawn_egg"),
    // rust: (
    // rust: "minecraft:evocation_illager",
    // rust: "minecraft:evocation_illager_spawn_egg",
    // rust: ),
    // rust: ("minecraft:ghast", "minecraft:ghast_spawn_egg"),
    // rust: ("minecraft:guardian", "minecraft:guardian_spawn_egg"),
    // rust: ("minecraft:horse", "minecraft:horse_spawn_egg"),
    // rust: ("minecraft:husk", "minecraft:husk_spawn_egg"),
    // rust: ("minecraft:iron_golem", "minecraft:iron_golem_spawn_egg"),
    // rust: ("minecraft:llama", "minecraft:llama_spawn_egg"),
    // rust: ("minecraft:magma_cube", "minecraft:magma_cube_spawn_egg"),
    // rust: ("minecraft:mooshroom", "minecraft:mooshroom_spawn_egg"),
    // rust: ("minecraft:mule", "minecraft:mule_spawn_egg"),
    // rust: ("minecraft:ocelot", "minecraft:ocelot_spawn_egg"),
    // rust: ("minecraft:pufferfish", "minecraft:pufferfish_spawn_egg"),
    // rust: ("minecraft:parrot", "minecraft:parrot_spawn_egg"),
    // rust: ("minecraft:pig", "minecraft:pig_spawn_egg"),
    // rust: ("minecraft:polar_bear", "minecraft:polar_bear_spawn_egg"),
    // rust: ("minecraft:rabbit", "minecraft:rabbit_spawn_egg"),
    // rust: ("minecraft:sheep", "minecraft:sheep_spawn_egg"),
    // rust: ("minecraft:shulker", "minecraft:shulker_spawn_egg"),
    // rust: ("minecraft:silverfish", "minecraft:silverfish_spawn_egg"),
    // rust: ("minecraft:skeleton", "minecraft:skeleton_spawn_egg"),
    // rust: (
    // rust: "minecraft:skeleton_horse",
    // rust: "minecraft:skeleton_horse_spawn_egg",
    // rust: ),
    // rust: ("minecraft:slime", "minecraft:slime_spawn_egg"),
    // rust: ("minecraft:snow_golem", "minecraft:snow_golem_spawn_egg"),
    // rust: ("minecraft:spider", "minecraft:spider_spawn_egg"),
    // rust: ("minecraft:squid", "minecraft:squid_spawn_egg"),
    // rust: ("minecraft:stray", "minecraft:stray_spawn_egg"),
    // rust: ("minecraft:turtle", "minecraft:turtle_spawn_egg"),
    // rust: ("minecraft:vex", "minecraft:vex_spawn_egg"),
    // rust: ("minecraft:villager", "minecraft:villager_spawn_egg"),
    // rust: (
    // rust: "minecraft:vindication_illager",
    // rust: "minecraft:vindication_illager_spawn_egg",
    // rust: ),
    // rust: ("minecraft:witch", "minecraft:witch_spawn_egg"),
    // rust: ("minecraft:wither", "minecraft:wither_spawn_egg"),
    // rust: (
    // rust: "minecraft:wither_skeleton",
    // rust: "minecraft:wither_skeleton_spawn_egg",
    // rust: ),
    // rust: ("minecraft:wolf", "minecraft:wolf_spawn_egg"),
    // rust: ("minecraft:zombie", "minecraft:zombie_spawn_egg"),
    // rust: ("minecraft:zombie_horse", "minecraft:zombie_horse_spawn_egg"),
    // rust: (
    // rust: "minecraft:zombie_pigman",
    // rust: "minecraft:zombie_pigman_spawn_egg",
    // rust: ),
    // rust: (
    // rust: "minecraft:zombie_villager",
    // rust: "minecraft:zombie_villager_spawn_egg",
    // rust: ),
    // rust: ];

// ------------------------------------------------------------------ 3322

    // rust: const POTION_ITEMS: [&str; 4] = [
    // rust: "minecraft:potion",
    // rust: "minecraft:splash_potion",
    // rust: "minecraft:lingering_potion",
    // rust: "minecraft:tipped_arrow",
    // rust: ];

/// `EffectDurationFix.fix`: every effect's factor data counts ticks active.
pub fn effect_list(list: Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !is_list(Some(&list)) {
    // rust: return list;
}
    // rust: Tag::List(
    // rust: stream(Some(&list))
    // rust: .into_iter()
    // rust: .map(|mut effect| {
    // rust: let duration = super::dynamic::as_int(effect.get("Duration"), -1);
    // rust: update(&mut effect, "FactorCalculationData", |mut data| {
    // rust: let timestamp =
    // rust: super::dynamic::as_int(data.get("effect_changed_timestamp"), -1);
    // rust: remove(&mut data, "effect_changed_timestamp");
    // rust: set(
    // rust: &mut data,
    // rust: "ticks_active",
    // rust: Tag::Int(timestamp.wrapping_sub(duration)),
    // rust: );
    // rust: data
    // rust: });
    // rust: effect
    // rust: })
    // rust: .collect(),
    // rust: )
}

pub fn effect_duration(cx: *mut Cx) void {
}
    // rust: let living = |e: &mut Tag| {
    // rust: for field in ["Effects", "ActiveEffects", "CustomPotionEffects"] {
    // rust: update(e, field, effect_list);
}
}
    // rust: cx.each(Ty::Entity, living);
    // rust: cx.each(Ty::Player, living);
    // rust: item_tag(
    // rust: cx,
    // rust: |id| POTION_ITEMS.contains(&id),
    // rust: |tag| update(tag, "CustomPotionEffects", effect_list),
    // rust: );
}

// ------------------------------------------------------------------ 3438, 3447

    // rust: const POTTERY_SHARDS: &[(&str, &str)] = &[
    // rust: (
    // rust: "minecraft:pottery_shard_archer",
    // rust: "minecraft:archer_pottery_shard",
    // rust: ),
    // rust: (
    // rust: "minecraft:pottery_shard_prize",
    // rust: "minecraft:prize_pottery_shard",
    // rust: ),
    // rust: (
    // rust: "minecraft:pottery_shard_arms_up",
    // rust: "minecraft:arms_up_pottery_shard",
    // rust: ),
    // rust: (
    // rust: "minecraft:pottery_shard_skull",
    // rust: "minecraft:skull_pottery_shard",
    // rust: ),
    // rust: ];

    // rust: const POTTERY_SHERDS: &[(&str, &str)] = &[
    // rust: (
    // rust: "minecraft:angler_pottery_shard",
    // rust: "minecraft:angler_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:archer_pottery_shard",
    // rust: "minecraft:archer_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:arms_up_pottery_shard",
    // rust: "minecraft:arms_up_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:blade_pottery_shard",
    // rust: "minecraft:blade_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:brewer_pottery_shard",
    // rust: "minecraft:brewer_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:burn_pottery_shard",
    // rust: "minecraft:burn_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:danger_pottery_shard",
    // rust: "minecraft:danger_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:explorer_pottery_shard",
    // rust: "minecraft:explorer_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:friend_pottery_shard",
    // rust: "minecraft:friend_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:heart_pottery_shard",
    // rust: "minecraft:heart_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:heartbreak_pottery_shard",
    // rust: "minecraft:heartbreak_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:howl_pottery_shard",
    // rust: "minecraft:howl_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:miner_pottery_shard",
    // rust: "minecraft:miner_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:mourner_pottery_shard",
    // rust: "minecraft:mourner_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:plenty_pottery_shard",
    // rust: "minecraft:plenty_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:prize_pottery_shard",
    // rust: "minecraft:prize_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:sheaf_pottery_shard",
    // rust: "minecraft:sheaf_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:shelter_pottery_shard",
    // rust: "minecraft:shelter_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:skull_pottery_shard",
    // rust: "minecraft:skull_pottery_sherd",
    // rust: ),
    // rust: (
    // rust: "minecraft:snort_pottery_shard",
    // rust: "minecraft:snort_pottery_sherd",
    // rust: ),
    // rust: ];

// ------------------------------------------------------------------ 3439

/// `LegacyComponentDataFixUtils.createEmptyComponent`.
pub fn empty_component() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: string("{\"text\":\"\"}")
}

/// `BlockEntitySignDoubleSidedEditableTextFix` (a `NamedEntityWriteReadFix`).
pub fn sign_double_sided(cx: *mut Cx, id: []const u8) void {
}
    // rust: let k = cx.k;
    // rust: cx.block_entity(id, |be| {
    // rust: let lines: Vec<Tag> = (1..=4)
    // rust: .map(|i| {
    // rust: be.get(&format!("Text{i}"))
    // rust: .cloned()
    // rust: .unwrap_or_else(empty_component)
    // rust: })
    // rust: .collect();
    // rust: let filtered: Vec<Option<Tag>> = (1..=4)
    // rust: .map(|i| be.get(&format!("FilteredText{i}")).cloned())
    // rust: .collect();
    // rust: let mut front = Compound::new();
    // rust: front.insert("messages".into(), Tag::List(lines.clone()));
    // rust: front.insert(
    // rust: "color".into(),
    // rust: be.get("Color").cloned().unwrap_or_else(|| string("black")),
    // rust: );
    // rust: front.insert(
    // rust: "has_glowing_text".into(),
    // rust: be.get("GlowingText").cloned().unwrap_or(Tag::Byte(0)),
    // rust: );
    // rust: if filtered.iter().any(Option::is_some) {
    // rust: let messages = filtered
    // rust: .into_iter()
    // rust: .zip(&lines)
    // rust: .map(|(f, line)| f.unwrap_or_else(|| line.clone()))
    // rust: .collect();
    // rust: front.insert("filtered_messages".into(), Tag::List(messages));
}
    // rust: set(be, "front_text", Tag::Compound(front));
    // rust: let back = Tag::compound([
    // rust: ("messages", Tag::List(vec![empty_component(); 4])),
    // rust: ("color", string("black")),
    // rust: ("has_glowing_text", Tag::Byte(0)),
    // rust: ]);
    // rust: set(be, "back_text", back);
    // rust: set(be, "is_waxed", Tag::Byte(0));
    // rust: set(be, "_filtered_correct", Tag::Byte(1));
    // rust: for field in super::fixes_a::SIGN_FIELDS_TO_DROP {
    // rust: remove(be, field);
}
    // rust: reread_as(Ty::BlockEntity, k, be);
    // rust: });
}

// ------------------------------------------------------------------ 3440

/// `NamespacedTypeRenameFix` over `MULTI_NOISE_BIOME_SOURCE_PARAMETER_LIST`: the
/// preset of a multi-noise biome source in the world generation settings.
pub fn multi_noise_preset(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::WorldGenSettings, |v| {
    // rust: let Some(Tag::Compound(dims)) = v.get_mut("dimensions") else {
    // rust: return;
}
    // rust: for dim in dims.values_mut() {
    // rust: let Some(g) = dim.get_mut("generator") else {
    // rust: continue;
}
    // rust: if as_str(g.get("type")).as_deref() != Some("minecraft:noise") {
    // rust: continue;
}
    // rust: let Some(source) = g.get_mut("biome_source") else {
    // rust: continue;
}
    // rust: if as_str(source.get("type")).as_deref() != Some("minecraft:multi_noise") {
    // rust: continue;
}
    // rust: if let Some(preset) = as_str(source.get("preset"))
    // rust: && namespaced(&preset) == "minecraft:overworld_update_1_20"
    // rust: {
    // rust: set(source, "preset", string("minecraft:overworld"));
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3450, 3459

/// `RemapChunkStatusFix`: statuses namespaced, then mapped.
pub fn remap_chunk_status(cx: *mut Cx) void {
}
    // rust: let fix = |v: Tag| match as_str(Some(&v)) {
    // rust: Some(s) => {
    // rust: let s = namespaced(&s);
    // rust: string(match s.as_str() {
    // rust: "minecraft:liquid_carvers" => "minecraft:carvers",
    // rust: "minecraft:heightmaps" => "minecraft:spawn",
    // rust: other => other,
    // rust: })
}
    // rust: None => v,
}
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: update(c, "Status", fix);
    // rust: if let Some(retrogen) = c.get_mut("below_zero_retrogen") {
    // rust: update(retrogen, "target_status", fix);
}
    // rust: });
}

/// `LegacyDragonFightFix`.
pub fn legacy_dragon_fight(cx: *mut Cx) void {
}
    // rust: cx.each(Ty::Level, |level| {
    // rust: if level.get("DragonFight").is_some() {
    // rust: return;
}
    // rust: let legacy = level
    // rust: .get("DimensionData")
    // rust: .and_then(|d| d.get("1"))
    // rust: .and_then(|d| d.get("DragonFight"))
    // rust: .cloned()
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: let mut fight = legacy;
    // rust: update(&mut fight, "ExitPortalLocation", fix_block_pos);
    // rust: set(level, "DragonFight", fight);
    // rust: });
}
