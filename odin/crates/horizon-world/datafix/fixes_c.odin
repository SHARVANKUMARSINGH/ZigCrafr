//! Transpiled from Horizon Rust crate
package horizon_world_fixes_c

import "core:fmt"
import "core:mem"
import "core:math"

// Fixes of 1.21.6 to 26.3 (keys 4424 to 5016).
// use super::dynamic::{
    // rust: as_bool, as_double, as_float, as_int, as_long, as_str, as_string, boolean, empty_map, int_list,
    // rust: namespaced, remove, rename, rename_and_fix, set, stream, string, update,
}
// use super::fixes_a::{block_rename, component_fix};
// use super::fixes_b::{advancements_rename, attributes_rename, feature_flag_remove};
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, id_is, renamer};
// use crate::nbt::Tag;

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // NamedEntityConvertUncheckedFix: the typed Particle is written as
    // custom_particle, the raw Particle comes back from the remainder.
    // rust: out.push((key(4420, 0), |cx| {
    // rust: cx.entity("minecraft:area_effect_cloud", |e| {
    // rust: if let Some(p) = e.get("Particle").cloned() {
    // rust: set(e, "custom_particle", p);
}
    // rust: super::drop_typed(e, "Particle");
    // rust: });
    // rust: }));
    // rust: out.push((key(4424, 0), |cx| {
    // rust: feature_flag_remove(cx, &["minecraft:locator_bar"])
    // rust: }));
    // rust: out.push((key(4424, 0), |cx| {
    // rust: cx.each(Ty::Player, add_locator_bar_style)
    // rust: }));
    // rust: out.push((key(4424, 0), |cx| {
    // rust: cx.each(Ty::Entity, add_locator_bar_style)
    // rust: }));
    // rust: out.push((key(4535, 0), |cx| {
    // rust: cx.entity("minecraft:copper_golem", |e| {
    // rust: update(e, "weather_state", |v| {
    // rust: string(match as_int(Some(&v), 0) {
    // rust: 1 => "exposed",
    // rust: 2 => "weathered",
    // rust: 3 => "oxidized",
    // rust: _ => "unaffected",
    // rust: })
    // rust: });
    // rust: });
    // rust: }));
    // rust: out.push((key(4537, 0), |cx| {
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: remove(c, "isLightOn");
    // rust: if let Some(Tag::List(sections)) = c.get_mut("sections") {
    // rust: for s in sections {
    // rust: remove(s, "BlockLight");
    // rust: remove(s, "SkyLight");
}
}
    // rust: });
    // rust: }));
    // rust: out.push((key(4541, 0), |cx| {
    // rust: block_rename(cx, &[("minecraft:chain", "minecraft:iron_chain")])
    // rust: }));
    // rust: out.push((key(4541, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[("minecraft:chain", "minecraft:iron_chain")]),
    // rust: )
    // rust: }));
    // rust: out.push((key(4544, 0), legacy_world_border));
    // rust: out.push((key(4548, 0), world_spawn_data));
    // rust: out.push((key(4548, 0), |cx| {
    // rust: cx.each(Ty::Player, |p| {
    // rust: update(p, "respawn", |mut r| {
    // rust: let dimension = as_string(r.get("dimension"), "minecraft:overworld");
    // rust: let yaw = as_float(r.get("angle"), 0.0);
    // rust: set(&mut r, "dimension", string(&dimension));
    // rust: set(&mut r, "yaw", Tag::Float(yaw.to_bits()));
    // rust: set(&mut r, "pitch", Tag::Float(0f32.to_bits()));
    // rust: remove(&mut r, "angle");
    // rust: r
    // rust: });
    // rust: });
    // rust: }));
    // rust: out.push((key(4649, 0), |cx| {
    // rust: component_fix(
    // rust: cx,
    // rust: "minecraft:consumable",
    // rust: "minecraft:consumable",
    // rust: |mut c| {
    // rust: if as_str(c.get("animation")).as_deref() == Some("spear") {
    // rust: set(&mut c, "animation", string("trident"));
}
    // rust: Some(c)
    // rust: },
    // rust: );
    // rust: }));
    // rust: out.push((key(4657, 0), |cx| {
    // rust: cx.each_out(Ty::SavedWorldBorder, |v| {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: update(d, "warning_time", |t| {
    // rust: Tag::Int(as_int(Some(&t), 15).wrapping_mul(20))
    // rust: });
}
    // rust: });
    // rust: }));
    // rust: out.push((key(4658, 0), game_rule_registry));
    // rust: out.push((key(4763, 0), |cx| {
    // rust: cx.entity("minecraft:villager", |e| {
    // rust: set(e, "VillagerDataFinalized", boolean(true))
    // rust: });
    // rust: }));
    // rust: out.push((key(4763, 0), |cx| {
    // rust: cx.entity("minecraft:zombie_villager", |e| {
    // rust: set(e, "VillagerDataFinalized", boolean(true))
    // rust: });
    // rust: }));
    // rust: out.push((key(4766, 0), day_time_to_clock));
    // rust: out.push((key(4769, 0), |cx| {
    // rust: cx.rename(Ty::Recipe, renamer(STONECUTTER_RECIPES))
    // rust: }));
    // rust: out.push((key(4769, 0), |cx| {
    // rust: advancements_rename(cx, &|id| {
    // rust: let id = namespaced(id);
    // rust: STONECUTTER_ADVANCEMENTS
    // rust: .iter()
    // rust: .find(|(from, _)| *from == id)
    // rust: .map(|(_, to)| (*to).to_owned())
    // rust: });
    // rust: }));
    // rust: out.push((key(4771, 0), level_dat_difficulty));
    // rust: out.push((key(4771, 0), level_dat_to_saved_data_preparation));
    // rust: out.push((key(4885, 0), remove_bed_block_entities));
    // rust: out.push((key(4888, 0), |cx| {
    // rust: attributes_rename(cx, false, &|id| {
    // rust: (id == "minecraft:nameplate_distance").then(|| "minecraft:name_tag_distance".into())
    // rust: });
    // rust: }));
    // rust: out.push((key(4996, 0), |cx| {
    // rust: cx.each_out(Ty::DataComponents, |c| {
    // rust: update(c, "minecraft:pot_decorations", unpack_pot_decorations)
    // rust: });
    // rust: }));
    // rust: out.push((key(4996, 1), |cx| {
    // rust: cx.block_entity("minecraft:decorated_pot", |be| {
    // rust: let sherds = be.get("sherds").cloned().unwrap_or(Tag::List(Vec::new()));
    // rust: set(be, "sherds", unpack_pot_decorations(sherds));
    // rust: });
    // rust: }));
    // rust: out.push((key(4997, 0), |cx| cx.each_out(Ty::Chunk, blending_data)));
    // rust: out.push((key(5002, 0), |cx| {
    // rust: cx.block_entity("minecraft:sign", |be| {
    // rust: set(be, "allow_op_features", boolean(true))
    // rust: });
    // rust: }));
    // rust: out.push((key(5002, 0), |cx| {
    // rust: cx.block_entity("minecraft:hanging_sign", |be| {
    // rust: set(be, "allow_op_features", boolean(true))
    // rust: });
    // rust: }));
    // rust: out.push((key(5006, 0), |cx| {
    // rust: cx.each(Ty::BlockState, |s| {
    // rust: rename(s, "Name", "id");
    // rust: rename(s, "Properties", "properties");
    // rust: });
    // rust: }));
    // rust: out.push((key(5007, 0), |cx| {
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: if let Some(swing) = remove(c, "minecraft:swing_animation") {
    // rust: set(c, "minecraft:attack_animation", swing.clone());
    // rust: set(c, "minecraft:interact_animation", swing);
}
    // rust: });
    // rust: }));
    // rust: out.push((key(5008, 0), explorer_map_item));
    // rust: out.push((key(5008, 0), |cx| {
    // rust: component_fix(cx, "minecraft:map_color", "minecraft:map_color", |_| None)
    // rust: }));
    // rust: out.push((key(5009, 0), |cx| {
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: if let Some(b) = c.get_mut("blending_data") {
    // rust: update(b, "heights", |h| {
    // rust: Tag::List(
    // rust: stream(Some(&h))
    // rust: .iter()
    // rust: .map(|v| {
    // rust: let d = as_double(Some(v), f64::MAX);
    // rust: let f = if d == f64::MAX { f32::MAX } else { d as f32 };
    // rust: Tag::Float(f.to_bits())
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
}
    // rust: });
    // rust: }));
    // rust: out.push((key(5012, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[
    // rust: (
    // rust: "minecraft:ocean_explorer_map",
    // rust: "minecraft:ocean_monument_map",
    // rust: ),
    // rust: ("minecraft:swamp_explorer_map", "minecraft:swamp_hut_map"),
    // rust: (
    // rust: "minecraft:trial_explorer_map",
    // rust: "minecraft:buried_trial_chambers_map",
    // rust: ),
    // rust: (
    // rust: "minecraft:woodland_explorer_map",
    // rust: "minecraft:woodland_mansion_map",
    // rust: ),
    // rust: (
    // rust: "minecraft:jungle_explorer_map",
    // rust: "minecraft:jungle_pyramid_map",
    // rust: ),
    // rust: ]),
    // rust: );
    // rust: }));
    // rust: out.push((key(5013, 0), merge_terrain_chunk_status));
    // rust: out.push((key(5014, 0), |cx| {
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: remove(c, "minecraft:block_transformer");
    // rust: });
    // rust: }));
    // rust: out.push((key(5016, 0), |cx| {
    // rust: cx.item(
    // rust: |id| id == "minecraft:map",
    // rust: |s| {
    // rust: if let Some(c) = s.get_mut("components")
    // rust: && let Some(name) = c.get_mut("minecraft:item_name")
    // rust: && plain_translation_key(name).as_deref() == Some("filled_map.buried_treasure")
    // rust: {
    // rust: set(
    // rust: name,
    // rust: "translate",
    // rust: string("item.minecraft.buried_treasure_map"),
    // rust: );
}
    // rust: },
    // rust: );
    // rust: }));
}

// ------------------------------------------------------------------ 4424

// `AddFieldFix` with the path `locator_bar_icon`: as vanilla does it, the
// value is replaced by its `locator_bar_icon` with a style added.
add_locator_bar_style :: proc(v: ^Tag) {
}
    // rust: if let Some(mut icon) = v.get("locator_bar_icon").cloned() {
    // rust: set(&mut icon, "style", string("minecraft:default"));
    // rust: *v = icon;
}
}

// ------------------------------------------------------------------ 4544, 4548, 4658, 4766

legacy_world_border :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |l| {
    // rust: let d = |l: &Tag, k: &str, def: f64| Tag::Double(as_double(l.get(k), def).to_bits());
    // rust: let border = Tag::compound([
    // rust: ("center_x", d(l, "BorderCenterX", 0.0)),
    // rust: ("center_z", d(l, "BorderCenterZ", 0.0)),
    // rust: ("size", d(l, "BorderSize", f64::from(5.999997E7f32))),
    // rust: (
    // rust: "lerp_time",
    // rust: Tag::Long(as_long(l.get("BorderSizeLerpTime"), 0)),
    // rust: ),
    // rust: ("lerp_target", d(l, "BorderSizeLerpTarget", 0.0)),
    // rust: ("safe_zone", d(l, "BorderSafeZone", 5.0)),
    // rust: ("damage_per_block", d(l, "BorderDamagePerBlock", 0.2)),
    // rust: (
    // rust: "warning_blocks",
    // rust: Tag::Int(as_int(l.get("BorderWarningBlocks"), 5)),
    // rust: ),
    // rust: (
    // rust: "warning_time",
    // rust: Tag::Int(as_int(l.get("BorderWarningTime"), 15)),
    // rust: ),
    // rust: ]);
    // rust: for k in [
    // rust: "BorderCenterX",
    // rust: "BorderCenterZ",
    // rust: "BorderSize",
    // rust: "BorderSizeLerpTime",
    // rust: "BorderSizeLerpTarget",
    // rust: "BorderSafeZone",
    // rust: "BorderDamagePerBlock",
    // rust: "BorderWarningBlocks",
    // rust: "BorderWarningTime",
    // rust: ] {
    // rust: remove(l, k);
}
    // rust: set(l, "world_border", border);
    // rust: });
}

world_spawn_data :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |l| {
    // rust: let pos = [
    // rust: as_int(l.get("SpawnX"), 0),
    // rust: as_int(l.get("SpawnY"), 0),
    // rust: as_int(l.get("SpawnZ"), 0),
    // rust: ];
    // rust: let angle = as_float(l.get("SpawnAngle"), 0.0);
    // rust: for k in ["SpawnX", "SpawnY", "SpawnZ", "SpawnAngle"] {
    // rust: remove(l, k);
}
    // rust: set(
    // rust: l,
    // rust: "spawn",
    // rust: Tag::compound([
    // rust: ("dimension", string("minecraft:overworld")),
    // rust: ("pos", int_list(&pos)),
    // rust: ("yaw", Tag::Float(angle.to_bits())),
    // rust: ("pitch", Tag::Float(0f32.to_bits())),
    // rust: ]),
    // rust: );
    // rust: });
}

    // rust: const GAME_RULES: &[(&str, &str, Conv)] = &[
    // rust: (
    // rust: "allowEnteringNetherUsingPortals",
    // rust: "minecraft:allow_entering_nether_using_portals",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "announceAdvancements",
    // rust: "minecraft:show_advancement_messages",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "blockExplosionDropDecay",
    // rust: "minecraft:block_explosion_drop_decay",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "commandBlockOutput",
    // rust: "minecraft:command_block_output",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "enableCommandBlocks",
    // rust: "minecraft:command_blocks_work",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "commandBlocksEnabled",
    // rust: "minecraft:command_blocks_work",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "commandModificationBlockLimit",
    // rust: "minecraft:max_block_modifications",
    // rust: Conv::Int(1, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "disableElytraMovementCheck",
    // rust: "minecraft:elytra_movement_check",
    // rust: Conv::NotBool,
    // rust: ),
    // rust: (
    // rust: "disablePlayerMovementCheck",
    // rust: "minecraft:player_movement_check",
    // rust: Conv::NotBool,
    // rust: ),
    // rust: ("disableRaids", "minecraft:raids", Conv::NotBool),
    // rust: ("doDaylightCycle", "minecraft:advance_time", Conv::Bool),
    // rust: ("doEntityDrops", "minecraft:entity_drops", Conv::Bool),
    // rust: (
    // rust: "doImmediateRespawn",
    // rust: "minecraft:immediate_respawn",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("doInsomnia", "minecraft:spawn_phantoms", Conv::Bool),
    // rust: (
    // rust: "doLimitedCrafting",
    // rust: "minecraft:limited_crafting",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("doMobLoot", "minecraft:mob_drops", Conv::Bool),
    // rust: ("doMobSpawning", "minecraft:spawn_mobs", Conv::Bool),
    // rust: ("doPatrolSpawning", "minecraft:spawn_patrols", Conv::Bool),
    // rust: ("doTileDrops", "minecraft:block_drops", Conv::Bool),
    // rust: (
    // rust: "doTraderSpawning",
    // rust: "minecraft:spawn_wandering_traders",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("doVinesSpread", "minecraft:spread_vines", Conv::Bool),
    // rust: ("doWardenSpawning", "minecraft:spawn_wardens", Conv::Bool),
    // rust: ("doWeatherCycle", "minecraft:advance_weather", Conv::Bool),
    // rust: ("drowningDamage", "minecraft:drowning_damage", Conv::Bool),
    // rust: (
    // rust: "enderPearlsVanishOnDeath",
    // rust: "minecraft:ender_pearls_vanish_on_death",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("fallDamage", "minecraft:fall_damage", Conv::Bool),
    // rust: ("fireDamage", "minecraft:fire_damage", Conv::Bool),
    // rust: (
    // rust: "forgiveDeadPlayers",
    // rust: "minecraft:forgive_dead_players",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("freezeDamage", "minecraft:freeze_damage", Conv::Bool),
    // rust: (
    // rust: "globalSoundEvents",
    // rust: "minecraft:global_sound_events",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("keepInventory", "minecraft:keep_inventory", Conv::Bool),
    // rust: (
    // rust: "lavaSourceConversion",
    // rust: "minecraft:lava_source_conversion",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("locatorBar", "minecraft:locator_bar", Conv::Bool),
    // rust: (
    // rust: "logAdminCommands",
    // rust: "minecraft:log_admin_commands",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "maxCommandChainLength",
    // rust: "minecraft:max_command_sequence_length",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "maxCommandForkCount",
    // rust: "minecraft:max_command_forks",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "maxEntityCramming",
    // rust: "minecraft:max_entity_cramming",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "minecartMaxSpeed",
    // rust: "minecraft:max_minecart_speed",
    // rust: Conv::Int(i32::MIN, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "mobExplosionDropDecay",
    // rust: "minecraft:mob_explosion_drop_decay",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("mobGriefing", "minecraft:mob_griefing", Conv::Bool),
    // rust: (
    // rust: "naturalRegeneration",
    // rust: "minecraft:natural_health_regeneration",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "playersNetherPortalCreativeDelay",
    // rust: "minecraft:players_nether_portal_creative_delay",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "playersNetherPortalDefaultDelay",
    // rust: "minecraft:players_nether_portal_default_delay",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "playersSleepingPercentage",
    // rust: "minecraft:players_sleeping_percentage",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "projectilesCanBreakBlocks",
    // rust: "minecraft:projectiles_can_break_blocks",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("pvp", "minecraft:pvp", Conv::Bool),
    // rust: (
    // rust: "randomTickSpeed",
    // rust: "minecraft:random_tick_speed",
    // rust: Conv::Int(0, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "reducedDebugInfo",
    // rust: "minecraft:reduced_debug_info",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "sendCommandFeedback",
    // rust: "minecraft:send_command_feedback",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "showDeathMessages",
    // rust: "minecraft:show_death_messages",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "snowAccumulationHeight",
    // rust: "minecraft:max_snow_accumulation_height",
    // rust: Conv::Int(0, 8),
    // rust: ),
    // rust: ("spawnMonsters", "minecraft:spawn_monsters", Conv::Bool),
    // rust: (
    // rust: "spawnRadius",
    // rust: "minecraft:respawn_radius",
    // rust: Conv::Int(i32::MIN, i32::MAX),
    // rust: ),
    // rust: (
    // rust: "spawnerBlocksEnabled",
    // rust: "minecraft:spawner_blocks_work",
    // rust: Conv::Bool,
    // rust: ),
    // rust: (
    // rust: "spectatorsGenerateChunks",
    // rust: "minecraft:spectators_generate_chunks",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("tntExplodes", "minecraft:tnt_explodes", Conv::Bool),
    // rust: (
    // rust: "tntExplosionDropDecay",
    // rust: "minecraft:tnt_explosion_drop_decay",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ("universalAnger", "minecraft:universal_anger", Conv::Bool),
    // rust: (
    // rust: "waterSourceConversion",
    // rust: "minecraft:water_source_conversion",
    // rust: Conv::Bool,
    // rust: ),
    // rust: ];

Conv :: enum {
    Bool,
    NotBool,
    Int(i32, i32),
}

// `Boolean.parseBoolean`.
parse_bool :: proc(s: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: s.eq_ignore_ascii_case("true")
}

convert :: proc(v: Tag, conv: Conv) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let s = as_string(Some(&v), "");
    // rust: match conv {
    // rust: Conv::Bool => boolean(parse_bool(&s)),
    // rust: Conv::NotBool => boolean(!parse_bool(&s)),
    // rust: Conv::Int(min, max) => match parse_int(&s) {
    // rust: Some(i) => Tag::Int(i.clamp(min, max)),
    // rust: None => v,
    // rust: },
}
}

// `Integer.parseInt`.
parse_int :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let digits = s.strip_prefix(['+', '-']).unwrap_or(s);
    // rust: if digits.is_empty() || !digits.bytes().all(|b| b.is_ascii_digit()) {
    // rust: return None;
}
    // rust: s.parse().ok()
}

game_rule_registry :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |l| {
    // rust: rename_and_fix(l, "GameRules", "game_rules", |mut rules| {
    // rust: let fire_tick = parse_bool(&as_string(rules.get("doFireTick"), "true"));
    // rust: let away = parse_bool(&as_string(
    // rust: rules.get("allowFireTicksAwayFromPlayer"),
    // rust: "false",
    // rust: ));
    // rust: let radius = if !fire_tick {
    // rust: 0
    // rust: } else if !away {
    // rust: 128
    // rust: } else {
    // rust: -1
}
    // rust: if radius != 128 {
    // rust: set(
    // rust: &mut rules,
    // rust: "minecraft:fire_spread_radius_around_player",
    // rust: Tag::Int(radius),
    // rust: );
}
    // rust: for k in [
    // rust: "spawnChunkRadius",
    // rust: "entitiesWithPassengersCanUsePortals",
    // rust: "gameLoopFunction",
    // rust: "doFireTick",
    // rust: "allowFireTicksAwayFromPlayer",
    // rust: ] {
    // rust: remove(&mut rules, k);
}
    // rust: for (old, new, conv) in GAME_RULES {
    // rust: rename_and_fix(&mut rules, old, new, |v| Some(convert(v, *conv)));
}
    // rust: Some(rules)
    // rust: });
    // rust: });
}

day_time_to_clock :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |l| {
    // rust: let game_time = as_long(l.get("Time"), 0);
    // rust: let day_time = as_long(l.get("DayTime"), game_time);
    // rust: remove(l, "DayTime");
    // rust: let clock = Tag::compound([
    // rust: ("total_ticks", Tag::Long(day_time)),
    // rust: ("paused", boolean(false)),
    // rust: ]);
    // rust: set(
    // rust: l,
    // rust: "world_clocks",
    // rust: Tag::compound([("minecraft:overworld", clock)]),
    // rust: );
    // rust: });
}

// ------------------------------------------------------------------ 4769, 4771

    // rust: const STONECUTTER_RECIPES: &[(&str, &str)] = &[
    // rust: (
    // rust: "minecraft:chiseled_stone_bricks_stone_from_stonecutting",
    // rust: "minecraft:chiseled_stone_bricks_from_stone_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:end_stone_brick_slab_from_end_stone_brick_stonecutting",
    // rust: "minecraft:end_stone_brick_slab_from_end_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:end_stone_brick_stairs_from_end_stone_brick_stonecutting",
    // rust: "minecraft:end_stone_brick_stairs_from_end_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:end_stone_brick_wall_from_end_stone_brick_stonecutting",
    // rust: "minecraft:end_stone_brick_wall_from_end_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:mossy_stone_brick_slab_from_mossy_stone_brick_stonecutting",
    // rust: "minecraft:mossy_stone_brick_slab_from_mossy_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:mossy_stone_brick_stairs_from_mossy_stone_brick_stonecutting",
    // rust: "minecraft:mossy_stone_brick_stairs_from_mossy_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:mossy_stone_brick_wall_from_mossy_stone_brick_stonecutting",
    // rust: "minecraft:mossy_stone_brick_wall_from_mossy_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:prismarine_brick_slab_from_prismarine_stonecutting",
    // rust: "minecraft:prismarine_brick_slab_from_prismarine_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:prismarine_brick_stairs_from_prismarine_stonecutting",
    // rust: "minecraft:prismarine_brick_stairs_from_prismarine_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:quartz_slab_from_stonecutting",
    // rust: "minecraft:quartz_slab_from_quartz_block_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:stone_brick_walls_from_stone_stonecutting",
    // rust: "minecraft:stone_brick_wall_from_stone_stonecutting",
    // rust: ),
    // rust: ];
    // rust: const STONECUTTER_ADVANCEMENTS: &[(&str, &str)] = &[
    // rust: (
    // rust: "minecraft:recipes/building_blocks/chiseled_stone_bricks_stone_from_stonecutting",
    // rust: "minecraft:recipes/building_blocks/chiseled_stone_bricks_from_stone_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/end_stone_brick_slab_from_end_stone_brick_stonecutting",
    // rust: "minecraft:recipes/building_blocks/end_stone_brick_slab_from_end_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/end_stone_brick_stairs_from_end_stone_brick_stonecutting",
    // rust: "minecraft:recipes/building_blocks/end_stone_brick_stairs_from_end_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/decorations/end_stone_brick_wall_from_end_stone_brick_stonecutting",
    // rust: "minecraft:recipes/decorations/end_stone_brick_wall_from_end_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/mossy_stone_brick_slab_from_mossy_stone_brick_stonecutting",
    // rust: "minecraft:recipes/building_blocks/mossy_stone_brick_slab_from_mossy_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/mossy_stone_brick_stairs_from_mossy_stone_brick_stonecutting",
    // rust: "minecraft:recipes/building_blocks/mossy_stone_brick_stairs_from_mossy_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/mossy_stone_brick_wall_from_mossy_stone_brick_stonecutting",
    // rust: "minecraft:recipes/decorations/mossy_stone_brick_wall_from_mossy_stone_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/prismarine_brick_slab_from_prismarine_stonecutting",
    // rust: "minecraft:recipes/building_blocks/prismarine_brick_slab_from_prismarine_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/prismarine_brick_stairs_from_prismarine_stonecutting",
    // rust: "minecraft:recipes/building_blocks/prismarine_brick_stairs_from_prismarine_bricks_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/building_blocks/quartz_slab_from_stonecutting",
    // rust: "minecraft:recipes/building_blocks/quartz_slab_from_quartz_block_stonecutting",
    // rust: ),
    // rust: (
    // rust: "minecraft:recipes/decorations/stone_brick_walls_from_stone_stonecutting",
    // rust: "minecraft:recipes/decorations/stone_brick_wall_from_stone_stonecutting",
    // rust: ),
    // rust: ];

level_dat_difficulty :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::LightweightLevel, |l| {
    // rust: let difficulty = match as_int(l.get("Difficulty"), 2) {
    // rust: 0 => "peaceful",
    // rust: 1 => "easy",
    // rust: 3 => "hard",
    // rust: _ => "normal",
}
    // rust: let settings = Tag::compound([
    // rust: ("difficulty", string(difficulty)),
    // rust: ("hardcore", boolean(as_bool(l.get("hardcore"), false))),
    // rust: ("locked", boolean(as_bool(l.get("DifficultyLocked"), false))),
    // rust: ]);
    // rust: set(l, "difficulty_settings", settings);
    // rust: remove(l, "Difficulty");
    // rust: remove(l, "hardcore");
    // rust: remove(l, "DifficultyLocked");
    // rust: });
}

level_dat_to_saved_data_preparation :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Level, |l| {
    // rust: let source = l.clone();
    // rust: rename_and_fix(l, "DragonFight", "dragon_fight", |mut fight| {
    // rust: let respawning = as_bool(fight.get("IsRespawning"), false);
    // rust: for (a, b) in [
    // rust: ("NeedsStateScanning", "needs_state_scanning"),
    // rust: ("DragonKilled", "dragon_killed"),
    // rust: ("PreviouslyKilled", "previously_killed"),
    // rust: ("Dragon", "dragon_uuid"),
    // rust: ("ExitPortalLocation", "exit_portal_location"),
    // rust: ("Gateways", "gateways"),
    // rust: ] {
    // rust: rename(&mut fight, a, b);
}
    // rust: if respawning {
    // rust: set(&mut fight, "respawn_stage", string("start"));
    // rust: set(&mut fight, "respawn_time", Tag::Int(0));
}
    // rust: remove(&mut fight, "IsRespawning");
    // rust: Some(fight)
    // rust: });
    // rust: let trader = Tag::compound([
    // rust: (
    // rust: "spawn_delay",
    // rust: Tag::Int(as_int(source.get("WanderingTraderSpawnDelay"), 24000)),
    // rust: ),
    // rust: (
    // rust: "spawn_chance",
    // rust: Tag::Int(as_int(source.get("WanderingTraderSpawnChance"), 25)),
    // rust: ),
    // rust: ]);
    // rust: set(l, "wandering_trader_migration_data", trader);
    // rust: for k in [
    // rust: "WanderingTraderSpawnDelay",
    // rust: "WanderingTraderSpawnChance",
    // rust: "WanderingTraderId",
    // rust: ] {
    // rust: remove(l, k);
}
    // rust: let weather = Tag::compound([
    // rust: (
    // rust: "clear_weather_time",
    // rust: Tag::Int(as_int(source.get("clearWeatherTime"), 0)),
    // rust: ),
    // rust: ("rain_time", Tag::Int(as_int(source.get("rainTime"), 0))),
    // rust: (
    // rust: "thunder_time",
    // rust: Tag::Int(as_int(source.get("thunderTime"), 0)),
    // rust: ),
    // rust: ("raining", boolean(as_bool(source.get("raining"), false))),
    // rust: (
    // rust: "thundering",
    // rust: boolean(as_bool(source.get("thundering"), false)),
    // rust: ),
    // rust: ]);
    // rust: for k in [
    // rust: "clearWeatherTime",
    // rust: "rainTime",
    // rust: "thunderTime",
    // rust: "raining",
    // rust: "thundering",
    // rust: ] {
    // rust: remove(l, k);
}
    // rust: set(l, "weather_data", weather);
        // `asList` of something that is not a list is empty.
    // rust: let events: Vec<Tag> = stream(source.get("ScheduledEvents"))
    // rust: .into_iter()
    // rust: .map(|mut e| {
    // rust: rename(&mut e, "Name", "id");
    // rust: rename(&mut e, "TriggerTime", "trigger_time");
    // rust: rename_and_fix(&mut e, "Callback", "callback", |mut c| {
    // rust: rename(&mut c, "Type", "type");
    // rust: rename(&mut c, "Name", "id");
    // rust: Some(c)
    // rust: });
    // rust: e
    // rust: })
    // rust: .collect();
    // rust: remove(l, "ScheduledEvents");
    // rust: set(
    // rust: l,
    // rust: "scheduled_events",
    // rust: Tag::compound([("events", Tag::List(events))]),
    // rust: );
    // rust: rename_and_fix(l, "WorldGenSettings", "world_gen_settings", |mut s| {
    // rust: rename(&mut s, "generate_features", "generate_structures");
    // rust: Some(s)
    // rust: });
    // rust: });
}

// ------------------------------------------------------------------ 4885, 4996, 4997

// `RemoveBlockEntityTagFix` for beds: item block entity data, falling block
// entity data and chunk block entities of beds go.
remove_bed_block_entities :: proc(cx: ^Cx) {
}
    // rust: let is_bed = |v: &Tag| id_is(v, "minecraft:bed");
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: if let Some(c) = s.get_mut("components")
    // rust: && c.get("minecraft:block_entity_data").is_some_and(is_bed)
    // rust: {
    // rust: remove(c, "minecraft:block_entity_data");
}
    // rust: });
    // rust: cx.entity("minecraft:falling_block", |e| {
    // rust: if e.get("TileEntityData").is_some_and(is_bed) {
    // rust: remove(e, "TileEntityData");
}
    // rust: });
    // rust: cx.each(Ty::Chunk, |c| {
    // rust: if let Some(Tag::List(bes)) = c.get_mut("block_entities") {
    // rust: bes.retain(|be| !is_bed(be));
}
    // rust: });
}

// `PotDecorationsComponentUnflatteningFix.unpackList`.
unpack_pot_decorations :: proc(original: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if !super::dynamic::is_list(Some(&original)) {
    // rust: return original;
}
    // rust: let ids: Vec<Option<String>> = stream(Some(&original))
    // rust: .iter()
    // rust: .map(|t| as_str(Some(t)))
    // rust: .collect();
    // rust: let mut result = empty_map();
    // rust: for (i, side) in ["back", "left", "right", "front"].iter().enumerate() {
    // rust: let id = ids
    // rust: .get(i)
    // rust: .cloned()
    // rust: .flatten()
    // rust: .unwrap_or_else(|| "minecraft:brick".into());
    // rust: if id.is_empty() {
    // rust: return original;
}
    // rust: set(&mut result, side, Tag::compound([("id", string(&id))]));
}
    // rust: result
}

blending_data :: proc(c: ^Tag) {
}
    // rust: remove(c, "blending_data");
    // rust: let overworld = c
    // rust: .get("__context")
    // rust: .and_then(|ctx| as_str(ctx.get("dimension")))
    // rust: .is_some_and(|d| d == "minecraft:overworld");
    // rust: let Some(status) = c.get("Status") else {
    // rust: return;
}
    // rust: if !overworld {
    // rust: return;
}
    // rust: const SKIP: [&str; 4] = [
    // rust: "minecraft:empty",
    // rust: "minecraft:structure_starts",
    // rust: "minecraft:structure_references",
    // rust: "minecraft:biomes",
    // rust: ];
    // rust: let status = namespaced(&as_string(Some(status), "empty"));
    // rust: let blending = |height: i32, min_y: i32| {
    // rust: Tag::compound([
    // rust: ("min_section", Tag::Int(min_y >> 4)),
    // rust: ("max_section", Tag::Int((min_y + height) >> 4)),
    // rust: ])
}
    // rust: if !SKIP.contains(&status.as_str()) {
    // rust: set(c, "blending_data", blending(384, -64));
    // rust: } else if let Some(retrogen) = c.get("below_zero_retrogen") {
    // rust: let target = namespaced(&as_string(retrogen.get("target_status"), "empty"));
    // rust: if !SKIP.contains(&target.as_str()) {
    // rust: set(c, "blending_data", blending(256, 0));
}
}
}

// ------------------------------------------------------------------ 5008, 5013

// `ExtraDataFixUtils.getPlainTranslationKey`: `{translate: key}` alone.
plain_translation_key :: proc(v: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Tag::Compound(c) if c.len() == 1 => as_str(v.get("translate")),
    // rust: _ => None,
}
}

    // rust: const EXPLORER_MAPS: &[(&str, &str, &str)] = &[
    // rust: (
    // rust: "minecraft:mansion",
    // rust: "minecraft:woodland_explorer_map",
    // rust: "filled_map.mansion",
    // rust: ),
    // rust: (
    // rust: "minecraft:monument",
    // rust: "minecraft:ocean_explorer_map",
    // rust: "filled_map.monument",
    // rust: ),
    // rust: (
    // rust: "minecraft:trial_chambers",
    // rust: "minecraft:trial_explorer_map",
    // rust: "filled_map.trial_chambers",
    // rust: ),
    // rust: (
    // rust: "minecraft:jungle_temple",
    // rust: "minecraft:jungle_explorer_map",
    // rust: "filled_map.explorer_jungle",
    // rust: ),
    // rust: (
    // rust: "minecraft:swamp_hut",
    // rust: "minecraft:swamp_explorer_map",
    // rust: "filled_map.explorer_swamp",
    // rust: ),
    // rust: (
    // rust: "minecraft:village_desert",
    // rust: "minecraft:desert_village_map",
    // rust: "filled_map.village_desert",
    // rust: ),
    // rust: (
    // rust: "minecraft:village_plains",
    // rust: "minecraft:plains_village_map",
    // rust: "filled_map.village_plains",
    // rust: ),
    // rust: (
    // rust: "minecraft:village_savanna",
    // rust: "minecraft:savanna_village_map",
    // rust: "filled_map.village_savanna",
    // rust: ),
    // rust: (
    // rust: "minecraft:village_snowy",
    // rust: "minecraft:snowy_village_map",
    // rust: "filled_map.village_snowy",
    // rust: ),
    // rust: (
    // rust: "minecraft:village_taiga",
    // rust: "minecraft:taiga_village_map",
    // rust: "filled_map.village_taiga",
    // rust: ),
    // rust: (
    // rust: "minecraft:red_x",
    // rust: "minecraft:buried_treasure_map",
    // rust: "filled_map.buried_treasure",
    // rust: ),
    // rust: ];

explorer_map_item :: proc(cx: ^Cx) {
}
    // rust: cx.item(
    // rust: |id| id == "minecraft:filled_map",
    // rust: |s| {
    // rust: let Some(decoration) = s
    // rust: .get("components")
    // rust: .and_then(|c| c.get("minecraft:map_decorations"))
    // rust: .and_then(|d| d.get("+"))
    // rust: else {
    // rust: return;
}
    // rust: let ty = namespaced(&as_string(decoration.get("type"), ""));
    // rust: let Some((_, item, legacy)) = EXPLORER_MAPS.iter().find(|(t, _, _)| *t == ty) else {
    // rust: return;
}
    // rust: set(s, "id", string(item));
    // rust: if let Some(c) = s.get_mut("components")
    // rust: && c.get("minecraft:item_name")
    // rust: .and_then(plain_translation_key)
    // rust: .as_deref()
    // rust: == Some(*legacy)
    // rust: {
    // rust: remove(c, "minecraft:item_name");
}
    // rust: },
    // rust: );
}

merge_terrain_chunk_status :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |c| {
INTERMEDIATE :: ["minecraft:noise", "minecraft:surface"]
    // rust: let fix = |s: &str| -> String {
    // rust: if s == "minecraft:carvers" {
    // rust: "minecraft:terrain".into()
    // rust: } else if INTERMEDIATE.contains(&s) {
    // rust: "minecraft:biomes".into()
    // rust: } else {
    // rust: s.to_owned()
}
}
    // rust: let old_status = namespaced(&as_string(c.get("Status"), "minecraft:empty"));
    // rust: set(c, "Status", string(&fix(&old_status)));
    // rust: let mut old_target = None;
    // rust: if let Some(r) = c.get_mut("below_zero_retrogen") {
    // rust: let target = namespaced(&as_string(r.get("target_status"), "minecraft:empty"));
    // rust: set(r, "target_status", string(&fix(&target)));
    // rust: old_target = Some(target);
}
    // rust: let status_intermediate = INTERMEDIATE.contains(&old_status.as_str());
    // rust: let target_intermediate = old_target
    // rust: .as_deref()
    // rust: .is_some_and(|t| INTERMEDIATE.contains(&t));
    // rust: if status_intermediate || target_intermediate {
    // rust: let only_below_zero = old_target.is_some() && !target_intermediate;
    // rust: remove(c, "Heightmaps");
    // rust: remove(c, "blending_data");
    // rust: if let Some(Tag::List(sections)) = c.get_mut("sections") {
    // rust: for s in sections {
    // rust: let y = super::dynamic::as_number(s.get("Y").unwrap_or(&Tag::End))
    // rust: .map_or(0, |n| n.byte_value());
    // rust: if !(y >= 0 && only_below_zero) {
    // rust: remove(s, "block_states");
}
}
}
}
    // rust: });
}
