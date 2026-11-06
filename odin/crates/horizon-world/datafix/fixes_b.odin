//! Transpiled from Horizon Rust crate
package horizon_world_fixes_b

import "core:fmt"
import "core:mem"
import "core:math"

// Fixes of 1.21 to 1.21.5 (keys 3938 to 4314), text components apart.
// use super::dynamic::{
    // rust: as_bool, as_double, as_float, as_int, as_long, as_number, as_str, as_string, empty_map,
    // rust: is_empty_map, is_list, namespaced, or_empty_map, remove, rename, rename_and_fix, set, stream,
    // rust: string, update,
}
// use super::fixes_a::{component_fix, dye_color, fix_inline_block_pos, translation_key};
// use super::items::java_hash_order;
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, id_is, reread};
// use crate::nbt::{Compound, Tag};

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // ProjectileStoredWeaponFix only writes and reads arrows with the new schema.
    // rust: out.push((key(3938, 0), |cx| {
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if id_is(e, "minecraft:arrow") || id_is(e, "minecraft:spectral_arrow") {
    // rust: reread(k, e);
}
    // rust: });
    // rust: }));
    // rust: out.push((key(3939, 0), |cx| {
    // rust: feature_flag_remove(cx, &["minecraft:update_1_21"])
    // rust: }));
    // rust: out.push((key(3945, 0), attribute_modifier_ids));
    // rust: out.push((key(3945, 0), jukebox_ticks));
    // rust: out.push((key(4054, 0), ominous_banner_rarity));
    // rust: out.push((key(4055, 0), |cx| {
    // rust: attributes_rename(cx, true, &attribute_id_prefix)
    // rust: }));
    // rust: out.push((key(4059, 0), food_to_consumable));
    // rust: out.push((key(4061, 0), trial_spawner_config_in_registry));
    // rust: out.push((key(4064, 0), |cx| {
    // rust: component_fix(
    // rust: cx,
    // rust: "minecraft:fire_resistant",
    // rust: "minecraft:damage_resistant",
    // rust: |_| Some(Tag::compound([("types", string("#minecraft:is_fire"))])),
    // rust: );
    // rust: }));
    // rust: out.push((key(4067, 0), boat_split));
    // rust: out.push((key(4067, 0), |cx| {
    // rust: feature_flag_remove(cx, &["minecraft:bundle"])
    // rust: }));
    // rust: out.push((key(4068, 0), |cx| {
    // rust: component_fix(cx, "minecraft:lock", "minecraft:lock", fix_lock)
    // rust: }));
    // rust: out.push((key(4068, 0), |cx| {
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: rename_and_fix(be, "Lock", "lock", fix_lock)
    // rust: });
    // rust: }));
    // rust: out.push((key(4081, 0), |cx| {
    // rust: cx.entity("minecraft:salmon", |e| {
    // rust: if as_string(e.get("type"), "medium") != "large" {
    // rust: set(e, "type", string("medium"));
}
    // rust: });
    // rust: }));
    // rust: out.push((key(4173, 0), |cx| {
    // rust: cx.entity("minecraft:tnt_minecart", |e| rename(e, "TNTFuse", "fuse"))
    // rust: }));
    // rust: out.push((key(4175, 0), |cx| {
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: if let Some(eq) = c.get_mut("minecraft:equippable") {
    // rust: rename(eq, "model", "asset_id");
}
    // rust: });
    // rust: }));
    // rust: out.push((key(4175, 0), |cx| {
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: update(c, "minecraft:custom_model_data", |cmd| {
    // rust: let value = as_number(&cmd).map_or(0.0, |n| n.float_value());
    // rust: Tag::compound([("floats", Tag::List(vec![Tag::Float(value.to_bits())]))])
    // rust: });
    // rust: });
    // rust: }));
    // rust: out.push((key(4176, 0), |cx| {
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if let Some(lock) = remove(be, "lock")
    // rust: && !broken_lock(&lock)
    // rust: {
    // rust: set(be, "lock", lock);
}
    // rust: });
    // rust: }));
    // rust: out.push((key(4176, 0), |cx| {
    // rust: component_fix(cx, "minecraft:lock", "minecraft:lock", |l| {
    // rust: (!broken_lock(&l)).then_some(l)
    // rust: });
    // rust: }));
    // rust: out.push((key(4180, 0), |cx| {
    // rust: feature_flag_remove(cx, &["minecraft:winter_drop"])
    // rust: }));
    // rust: for id in [
    // rust: "minecraft:furnace",
    // rust: "minecraft:smoker",
    // rust: "minecraft:blast_furnace",
    // rust: ] {
    // rust: let _ = id;
}
    // rust: out.push((key(4181, 0), |cx| {
    // rust: furnace_burn_time(cx, "minecraft:furnace")
    // rust: }));
    // rust: out.push((key(4181, 0), |cx| furnace_burn_time(cx, "minecraft:smoker")));
    // rust: out.push((key(4181, 0), |cx| {
    // rust: furnace_burn_time(cx, "minecraft:blast_furnace")
    // rust: }));
    // rust: out.push((key(4187, 0), |cx| {
    // rust: base_value(
    // rust: cx,
    // rust: "minecraft:villager",
    // rust: "minecraft:follow_range",
    // rust: 48.0,
    // rust: 16.0,
    // rust: )
    // rust: }));
    // rust: out.push((key(4187, 0), |cx| {
    // rust: base_value(cx, "minecraft:bee", "minecraft:follow_range", 48.0, 16.0)
    // rust: }));
    // rust: out.push((key(4187, 0), |cx| {
    // rust: base_value(cx, "minecraft:allay", "minecraft:follow_range", 48.0, 16.0)
    // rust: }));
    // rust: out.push((key(4187, 0), |cx| {
    // rust: base_value(cx, "minecraft:llama", "minecraft:follow_range", 40.0, 16.0)
    // rust: }));
    // rust: out.push((key(4187, 0), |cx| {
    // rust: base_value(
    // rust: cx,
    // rust: "minecraft:piglin_brute",
    // rust: "minecraft:follow_range",
    // rust: 16.0,
    // rust: 12.0,
    // rust: )
    // rust: }));
    // rust: out.push((key(4187, 0), |cx| {
    // rust: base_value(cx, "minecraft:warden", "minecraft:follow_range", 16.0, 24.0)
    // rust: }));
    // rust: super::text::register(out);
    // rust: out.push((key(4293, 0), drop_chances_format));
    // rust: out.push((key(4294, 0), |cx| {
    // rust: block_property_rename(
    // rust: cx,
    // rust: "minecraft:creaking_heart",
    // rust: "active",
    // rust: "creaking_heart_state",
    // rust: &|v| {
    // rust: if v == "true" {
    // rust: "awake".into()
    // rust: } else {
    // rust: "uprooted".into()
}
    // rust: },
    // rust: );
    // rust: }));
    // rust: out.push((key(4296, 0), |cx| {
    // rust: cx.entity("minecraft:area_effect_cloud", |e| {
    // rust: set(e, "potion_duration_scale", Tag::Float(0.25f32.to_bits()))
    // rust: });
    // rust: }));
    // rust: out.push((key(4297, 0), forced_chunk_to_ticket));
    // rust: out.push((key(4299, 0), entity_spawner_item_variants));
    // rust: out.push((key(4300, 0), saddle_equipment_slot));
    // rust: out.push((key(4301, 0), equipment_format));
    // rust: out.push((key(4303, 0), |cx| {
    // rust: cx.each_out(Ty::Entity, fall_distance_to_double)
    // rust: }));
    // rust: out.push((key(4303, 0), |cx| {
    // rust: cx.each_out(Ty::Player, fall_distance_to_double)
    // rust: }));
    // rust: out.push((key(4305, 0), |cx| {
    // rust: block_property_rename(
    // rust: cx,
    // rust: "minecraft:test_block",
    // rust: "test_block_mode",
    // rust: "mode",
    // rust: &|v| v.to_owned(),
    // rust: );
    // rust: }));
    // rust: out.push((key(4306, 0), thrown_potion_split));
    // rust: out.push((key(4307, 0), tooltip_display));
    // rust: out.push((key(4309, 0), raid_renames));
    // rust: out.push((key(4309, 0), chunk_ticket_unpack_pos));
    // rust: out.push((key(4311, 0), |cx| {
    // rust: advancements_rename(cx, &|id| {
    // rust: (namespaced(id) == "minecraft:nether/use_lodestone")
    // rust: .then(|| "minecraft:adventure/use_lodestone".into())
    // rust: });
    // rust: }));
    // rust: out.push((key(4312, 0), player_equipment));
    // rust: out.push((key(4314, 0), inline_block_pos_format));
}

// ------------------------------------------------------------------ 3939, 4067, 4180, 4424

    // rust: pub(super) fn feature_flag_remove(cx: &mut Cx, flags: &[&str]) {
    // rust: cx.each(Ty::LightweightLevel, |level| {
    // rust: let mut inactive: Vec<Tag> = stream(level.get("removed_features"));
    // rust: if let Some(features) = level.get("enabled_features")
    // rust: && is_list(Some(features))
    // rust: {
    // rust: let kept: Vec<Tag> = stream(Some(features))
    // rust: .into_iter()
    // rust: .filter(|f| match as_str(Some(f)) {
    // rust: Some(s) if flags.contains(&s.as_str()) => {
    // rust: inactive.push(string(&s));
    // rust: false
}
    // rust: _ => true,
    // rust: })
    // rust: .collect();
    // rust: set(level, "enabled_features", Tag::List(kept));
}
    // rust: if !inactive.is_empty() {
    // rust: set(level, "removed_features", Tag::List(inactive));
}
    // rust: });
}

// ------------------------------------------------------------------ 3945

uuid_text :: proc(u: [i32; 4]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let most = (i64::from(u[0]) << 32) | (i64::from(u[1]) & 0xFFFF_FFFF);
    // rust: let least = (i64::from(u[2]) << 32) | (i64::from(u[3]) & 0xFFFF_FFFF);
    // rust: let (m, l) = (most as u64, least as u64);
    // rust: format!(
    // rust: "{:08x}-{:04x}-{:04x}-{:04x}-{:012x}",
    // rust: m >> 32,
    // rust: (m >> 16) & 0xFFFF,
    // rust: m & 0xFFFF,
    // rust: l >> 48,
    // rust: l & 0xFFFF_FFFF_FFFF
    // rust: )
}

    // rust: const MODIFIER_IDS: &[(&str, &str)] = &[
    // rust: (
    // rust: "736565d2-e1a7-403d-a3f8-1aeb3e302542",
    // rust: "minecraft:creative_mode_block_range",
    // rust: ),
    // rust: (
    // rust: "98491ef6-97b1-4584-ae82-71a8cc85cf73",
    // rust: "minecraft:creative_mode_entity_range",
    // rust: ),
    // rust: (
    // rust: "91aeaa56-376b-4498-935b-2f7f68070635",
    // rust: "minecraft:effect.speed",
    // rust: ),
    // rust: (
    // rust: "7107de5e-7ce8-4030-940e-514c1f160890",
    // rust: "minecraft:effect.slowness",
    // rust: ),
    // rust: (
    // rust: "af8b6e3f-3328-4c0a-aa36-5ba2bb9dbef3",
    // rust: "minecraft:effect.haste",
    // rust: ),
    // rust: (
    // rust: "55fced67-e92a-486e-9800-b47f202c4386",
    // rust: "minecraft:effect.mining_fatigue",
    // rust: ),
    // rust: (
    // rust: "648d7064-6a60-4f59-8abe-c2c23a6dd7a9",
    // rust: "minecraft:effect.strength",
    // rust: ),
    // rust: (
    // rust: "c0105bf3-aef8-46b0-9ebc-92943757ccbe",
    // rust: "minecraft:effect.jump_boost",
    // rust: ),
    // rust: (
    // rust: "22653b89-116e-49dc-9b6b-9971489b5be5",
    // rust: "minecraft:effect.weakness",
    // rust: ),
    // rust: (
    // rust: "5d6f0ba2-1186-46ac-b896-c61c5cee99cc",
    // rust: "minecraft:effect.health_boost",
    // rust: ),
    // rust: (
    // rust: "eae29cf0-701e-4ed6-883a-96f798f3dab5",
    // rust: "minecraft:effect.absorption",
    // rust: ),
    // rust: (
    // rust: "03c3c89d-7037-4b42-869f-b146bcb64d2e",
    // rust: "minecraft:effect.luck",
    // rust: ),
    // rust: (
    // rust: "cc5af142-2bd2-4215-b636-2605aed11727",
    // rust: "minecraft:effect.unluck",
    // rust: ),
    // rust: ("6555be74-63b3-41f1-a245-77833b3c2562", "minecraft:evil"),
    // rust: (
    // rust: "1eaf83ff-7207-4596-b37a-d7a07b3ec4ce",
    // rust: "minecraft:powder_snow",
    // rust: ),
    // rust: (
    // rust: "662a6b8d-da3e-4c1c-8813-96ea6097278d",
    // rust: "minecraft:sprinting",
    // rust: ),
    // rust: (
    // rust: "020e0dfb-87ae-4653-9556-831010e291a0",
    // rust: "minecraft:attacking",
    // rust: ),
    // rust: ("766bfa64-11f3-11ea-8d71-362b9e155667", "minecraft:baby"),
    // rust: ("7e0292f2-9434-48d5-a29f-9583af7df27f", "minecraft:covered"),
    // rust: (
    // rust: "9e362924-01de-4ddd-a2b2-d0f7a405a174",
    // rust: "minecraft:suffocating",
    // rust: ),
    // rust: ("5cd17e52-a79a-43d3-a529-90fde04b181e", "minecraft:drinking"),
    // rust: ("b9766b59-9566-4402-bc1f-2ee2a276d836", "minecraft:baby"),
    // rust: (
    // rust: "49455a49-7ec5-45ba-b886-3b90b23a1718",
    // rust: "minecraft:attacking",
    // rust: ),
    // rust: (
    // rust: "845db27c-c624-495f-8c9f-6020a9a58b6b",
    // rust: "minecraft:armor.boots",
    // rust: ),
    // rust: (
    // rust: "d8499b04-0e66-4726-ab29-64469d734e0d",
    // rust: "minecraft:armor.leggings",
    // rust: ),
    // rust: (
    // rust: "9f3d476d-c118-4544-8365-64846904b48e",
    // rust: "minecraft:armor.chestplate",
    // rust: ),
    // rust: (
    // rust: "2ad3f246-fee1-4e67-b886-69fd380bb150",
    // rust: "minecraft:armor.helmet",
    // rust: ),
    // rust: (
    // rust: "c1c72771-8b8e-ba4a-ace0-81a93c8928b2",
    // rust: "minecraft:armor.body",
    // rust: ),
    // rust: (
    // rust: "b572ecd2-ac0c-4071-abde-9594af072a37",
    // rust: "minecraft:enchantment.fire_protection",
    // rust: ),
    // rust: (
    // rust: "40a9968f-5c66-4e2f-b7f4-2ec2f4b3e450",
    // rust: "minecraft:enchantment.blast_protection",
    // rust: ),
    // rust: (
    // rust: "07a65791-f64d-4e79-86c7-f83932f007ec",
    // rust: "minecraft:enchantment.respiration",
    // rust: ),
    // rust: (
    // rust: "60b1b7db-fffd-4ad0-817c-d6c6a93d8a45",
    // rust: "minecraft:enchantment.aqua_affinity",
    // rust: ),
    // rust: (
    // rust: "11dc269a-4476-46c0-aff3-9e17d7eb6801",
    // rust: "minecraft:enchantment.depth_strider",
    // rust: ),
    // rust: (
    // rust: "87f46a96-686f-4796-b035-22e16ee9e038",
    // rust: "minecraft:enchantment.soul_speed",
    // rust: ),
    // rust: (
    // rust: "b9716dbd-50df-4080-850e-70347d24e687",
    // rust: "minecraft:enchantment.soul_speed",
    // rust: ),
    // rust: (
    // rust: "92437d00-c3a7-4f2e-8f6c-1f21585d5dd0",
    // rust: "minecraft:enchantment.swift_sneak",
    // rust: ),
    // rust: (
    // rust: "5d3d087b-debe-4037-b53e-d84f3ff51f17",
    // rust: "minecraft:enchantment.sweeping_edge",
    // rust: ),
    // rust: (
    // rust: "3ceb37c0-db62-46b5-bd02-785457b01d96",
    // rust: "minecraft:enchantment.efficiency",
    // rust: ),
    // rust: (
    // rust: "cb3f55d3-645c-4f38-a497-9c13a33db5cf",
    // rust: "minecraft:base_attack_damage",
    // rust: ),
    // rust: (
    // rust: "fa233e1c-4180-4865-b01b-bcce9785aca3",
    // rust: "minecraft:base_attack_speed",
    // rust: ),
    // rust: ];
    // rust: const MODIFIER_NAMES: &[(&str, &str)] = &[
    // rust: ("Random spawn bonus", "minecraft:random_spawn_bonus"),
    // rust: (
    // rust: "Random zombie-spawn bonus",
    // rust: "minecraft:zombie_random_spawn_bonus",
    // rust: ),
    // rust: ("Leader zombie bonus", "minecraft:leader_zombie_bonus"),
    // rust: (
    // rust: "Zombie reinforcement callee charge",
    // rust: "minecraft:reinforcement_callee_charge",
    // rust: ),
    // rust: (
    // rust: "Zombie reinforcement caller charge",
    // rust: "minecraft:reinforcement_caller_charge",
    // rust: ),
    // rust: ];

// `asIntStream` of a UUID field, as `uuidFromIntArray` wants it.
uuid_of :: proc(v: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let ints: Vec<i32> = match v {
    // rust: Some(Tag::IntArray(a)) => a.clone(),
    // rust: other => stream(other)
    // rust: .iter()
    // rust: .map(|t| as_number(t).map_or(0, |n| n.int_value()))
    // rust: .collect(),
}
    // rust: (ints.len() == 4).then(|| [ints[0], ints[1], ints[2], ints[3]])
}

// `AttributeModifierIdFix.fixModifiers`: an insertion-ordered map by id.
fix_modifiers :: proc(modifiers: [dynamic]Tag) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut converted: Vec<(String, Tag)> = Vec::new();
    // rust: let put = |c: &mut Vec<(String, Tag)>, id: String, v: Tag| {
    // rust: if let Some(e) = c.iter_mut().find(|(k, _)| *k == id) {
    // rust: e.1 = v;
    // rust: } else {
    // rust: c.push((id, v));
}
}
    // rust: for mut m in modifiers {
    // rust: let uuid = uuid_of(m.get("uuid")).map(uuid_text);
    // rust: let name = as_string(m.get("name"), "");
    // rust: let from_uuid = uuid
    // rust: .as_deref()
    // rust: .and_then(|u| MODIFIER_IDS.iter().find(|(k, _)| *k == u).map(|(_, v)| *v));
    // rust: let from_name = MODIFIER_NAMES
    // rust: .iter()
    // rust: .find(|(k, _)| *k == name)
    // rust: .map(|(_, v)| *v);
    // rust: if let Some(id) = from_uuid {
    // rust: set(&mut m, "id", string(id));
    // rust: remove(&mut m, "uuid");
    // rust: remove(&mut m, "name");
    // rust: put(&mut converted, id.to_owned(), m);
    // rust: } else if let Some(id) = from_name {
    // rust: if let Some((_, pre)) = converted.iter_mut().find(|(k, _)| k == id) {
    // rust: let amount = as_double(pre.get("amount"), 0.0) + as_double(m.get("amount"), 0.0);
    // rust: set(pre, "amount", Tag::Double(amount.to_bits()));
    // rust: } else {
    // rust: set(&mut m, "id", string(id));
    // rust: remove(&mut m, "uuid");
    // rust: remove(&mut m, "name");
    // rust: put(&mut converted, id.to_owned(), m);
}
    // rust: } else {
    // rust: let id = format!("minecraft:{}", uuid.as_deref().unwrap_or("unknown"));
    // rust: set(&mut m, "id", string(&id));
    // rust: remove(&mut m, "uuid");
    // rust: remove(&mut m, "name");
    // rust: put(&mut converted, id, m);
}
}
    // rust: converted.into_iter().map(|(_, v)| v).collect()
}

attribute_modifier_ids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: if let Some(c) = s.get_mut("components")
    // rust: && let Some(a) = c.get_mut("minecraft:attribute_modifiers")
    // rust: && let Some(m) = a.get("modifiers")
    // rust: && is_list(Some(m))
    // rust: {
    // rust: let fixed = fix_modifiers(stream(Some(m)));
    // rust: set(a, "modifiers", Tag::List(fixed));
}
    // rust: });
    // rust: let fix_entity = |e: &mut Tag| {
    // rust: rename_and_fix(e, "Attributes", "attributes", |list| {
    // rust: if !is_list(Some(&list)) {
    // rust: return Some(list);
}
    // rust: Some(Tag::List(
    // rust: stream(Some(&list))
    // rust: .into_iter()
    // rust: .map(|mut a| {
    // rust: rename(&mut a, "Name", "id");
    // rust: rename(&mut a, "Base", "base");
    // rust: rename_and_fix(&mut a, "Modifiers", "modifiers", |mods| {
    // rust: if !is_list(Some(&mods)) {
    // rust: return Some(mods);
}
    // rust: let converted = stream(Some(&mods))
    // rust: .into_iter()
    // rust: .map(|mut m| {
    // rust: rename(&mut m, "UUID", "uuid");
    // rust: rename(&mut m, "Name", "name");
    // rust: rename(&mut m, "Amount", "amount");
    // rust: rename_and_fix(&mut m, "Operation", "operation", |op| {
    // rust: Some(string(match as_int(Some(&op), 0) {
    // rust: 0 => "add_value",
    // rust: 1 => "add_multiplied_base",
    // rust: 2 => "add_multiplied_total",
    // rust: _ => "invalid",
    // rust: }))
    // rust: });
    // rust: m
    // rust: })
    // rust: .collect();
    // rust: Some(Tag::List(fix_modifiers(converted)))
    // rust: });
    // rust: a
    // rust: })
    // rust: .collect(),
    // rust: ))
    // rust: });
}
    // rust: cx.each(Ty::Entity, fix_entity);
    // rust: cx.each(Ty::Player, fix_entity);
}

jukebox_ticks :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:jukebox", |be| {
    // rust: let ticks =
    // rust: as_long(be.get("TickCount"), 0).wrapping_sub(as_long(be.get("RecordStartTick"), 0));
    // rust: remove(be, "IsPlaying");
    // rust: remove(be, "TickCount");
    // rust: remove(be, "RecordStartTick");
    // rust: if ticks > 0 {
    // rust: set(be, "ticks_since_song_started", Tag::Long(ticks));
}
    // rust: });
}

// ------------------------------------------------------------------ 4054, 4055

ominous_banner_rarity :: proc(cx: ^Cx) {
}
    // rust: let fix = |c: &mut Tag| {
    // rust: if c.get("minecraft:item_name")
    // rust: .and_then(translation_key)
    // rust: .as_deref()
    // rust: == Some("block.minecraft.ominous_banner")
    // rust: {
    // rust: set(
    // rust: c,
    // rust: "minecraft:item_name",
    // rust: Tag::String(crate::nbt::JavaString(
    // rust: super::json::translatable_component_json("block.minecraft.ominous_banner"),
    // rust: )),
    // rust: );
    // rust: set(c, "minecraft:rarity", string("uncommon"));
}
}
    // rust: cx.block_entity("minecraft:banner", |be| {
    // rust: if let Some(c) = be.get_mut("components") {
    // rust: fix(c);
}
    // rust: });
    // rust: cx.item(
    // rust: |id| id == "minecraft:white_banner",
    // rust: |s| {
    // rust: if let Some(c) = s.get_mut("components") {
    // rust: fix(c);
}
    // rust: },
    // rust: );
}

attribute_id_prefix :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let namespaced_id = namespaced(id);
    // rust: for prefix in ["generic.", "horse.", "player.", "zombie."] {
    // rust: let p = namespaced(prefix);
    // rust: if let Some(rest) = namespaced_id.strip_prefix(&p) {
    // rust: return Some(format!("minecraft:{rest}"));
}
}
    // rust: None
}

// `AttributesRenameFix`.
    // rust: pub(super) fn attributes_rename(
    // rust: cx: &mut Cx,
    // rust: old_component_format: bool,
    // rust: rename_fn: &dyn Fn(&str) -> Option<String>,
    // rust: ) {
    // rust: let fix_field = |v: &mut Tag, field: &str| {
    // rust: if let Some(s) = as_str(v.get(field))
    // rust: && let Some(new) = rename_fn(&s)
    // rust: {
    // rust: set(v, field, string(&new));
}
}
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: let Some(a) = c.get_mut("minecraft:attribute_modifiers") else {
    // rust: return;
}
    // rust: let list = if old_component_format {
    // rust: a.get_mut("modifiers")
    // rust: } else {
    // rust: Some(a)
}
    // rust: if let Some(Tag::List(mods)) = list {
    // rust: for m in mods {
    // rust: fix_field(m, "type");
}
}
    // rust: });
    // rust: let fix_entity = |e: &mut Tag| {
    // rust: if let Some(Tag::List(attrs)) = e.get_mut("attributes") {
    // rust: for a in attrs {
    // rust: fix_field(a, "id");
}
}
}
    // rust: cx.each(Ty::Entity, fix_entity);
    // rust: cx.each(Ty::Player, fix_entity);
}

// ------------------------------------------------------------------ 4059, 4061

food_to_consumable :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: let Some(food) = c.get("minecraft:food").cloned() else {
    // rust: return;
}
    // rust: let eat_seconds = as_float(food.get("eat_seconds"), 1.6);
    // rust: let effects: Vec<Tag> = stream(food.get("effects"))
    // rust: .into_iter()
    // rust: .map(|e| {
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:apply_effects")),
    // rust: (
    // rust: "effects",
    // rust: Tag::List(e.get("effect").cloned().into_iter().collect()),
    // rust: ),
    // rust: (
    // rust: "probability",
    // rust: Tag::Float(as_float(e.get("probability"), 1.0).to_bits()),
    // rust: ),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: super::dynamic::copy_field(&food, "using_converts_to", c, "minecraft:use_remainder");
    // rust: let mut food = food;
    // rust: remove(&mut food, "eat_seconds");
    // rust: remove(&mut food, "effects");
    // rust: remove(&mut food, "using_converts_to");
    // rust: set(c, "minecraft:food", food);
    // rust: set(
    // rust: c,
    // rust: "minecraft:consumable",
    // rust: Tag::compound([
    // rust: ("consume_seconds", Tag::Float(eat_seconds.to_bits())),
    // rust: ("on_consume_effects", Tag::List(effects)),
    // rust: ]),
    // rust: );
    // rust: });
}

    // rust: const TRIAL_CONFIGS: &[(&str, &str, &str)] = &[
    // rust: (
    // rust: "trial_chamber/breeze",
    // rust: "{simultaneous_mobs: 1.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:breeze\"}}, weight: 1}], ticks_between_spawn: 20, total_mobs: 2.0f, total_mobs_added_per_player: 1.0f}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], simultaneous_mobs: 2.0f, total_mobs: 4.0f}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/melee/husk",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:husk\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], spawn_potentials: [{data: {entity: {id: \"minecraft:husk\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_melee\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/melee/spider",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:spider\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}],simultaneous_mobs: 4.0f, total_mobs: 12.0f}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/melee/zombie",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:zombie\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}],spawn_potentials: [{data: {entity: {id: \"minecraft:zombie\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_melee\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/ranged/poison_skeleton",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:bogged\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}],spawn_potentials: [{data: {entity: {id: \"minecraft:bogged\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_ranged\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/ranged/skeleton",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:skeleton\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], spawn_potentials: [{data: {entity: {id: \"minecraft:skeleton\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_ranged\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/ranged/stray",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:stray\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], spawn_potentials: [{data: {entity: {id: \"minecraft:stray\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_ranged\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/slow_ranged/poison_skeleton",
    // rust: "{simultaneous_mobs: 4.0f, simultaneous_mobs_added_per_player: 2.0f, spawn_potentials: [{data: {entity: {id: \"minecraft:bogged\"}}, weight: 1}], ticks_between_spawn: 160}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], spawn_potentials: [{data: {entity: {id: \"minecraft:bogged\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_ranged\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/slow_ranged/skeleton",
    // rust: "{simultaneous_mobs: 4.0f, simultaneous_mobs_added_per_player: 2.0f, spawn_potentials: [{data: {entity: {id: \"minecraft:skeleton\"}}, weight: 1}], ticks_between_spawn: 160}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], spawn_potentials: [{data: {entity: {id: \"minecraft:skeleton\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_ranged\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/slow_ranged/stray",
    // rust: "{simultaneous_mobs: 4.0f, simultaneous_mobs_added_per_player: 2.0f, spawn_potentials: [{data: {entity: {id: \"minecraft:stray\"}}, weight: 1}], ticks_between_spawn: 160}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}],spawn_potentials: [{data: {entity: {id: \"minecraft:stray\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_ranged\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/small_melee/baby_zombie",
    // rust: "{simultaneous_mobs: 2.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {IsBaby: 1b, id: \"minecraft:zombie\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], spawn_potentials: [{data: {entity: {IsBaby: 1b, id: \"minecraft:zombie\"}, equipment: {loot_table: \"minecraft:equipment/trial_chamber_melee\", slot_drop_chances: 0.0f}}, weight: 1}]}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/small_melee/cave_spider",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:cave_spider\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], simultaneous_mobs: 4.0f, total_mobs: 12.0f}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/small_melee/silverfish",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {id: \"minecraft:silverfish\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], simultaneous_mobs: 4.0f, total_mobs: 12.0f}",
    // rust: ),
    // rust: (
    // rust: "trial_chamber/small_melee/slime",
    // rust: "{simultaneous_mobs: 3.0f, simultaneous_mobs_added_per_player: 0.5f, spawn_potentials: [{data: {entity: {Size: 1, id: \"minecraft:slime\"}}, weight: 3}, {data: {entity: {Size: 2, id: \"minecraft:slime\"}}, weight: 1}], ticks_between_spawn: 20}",
    // rust: "{loot_tables_to_eject: [{data: \"minecraft:spawners/ominous/trial_chamber/key\", weight: 3}, {data: \"minecraft:spawners/ominous/trial_chamber/consumables\", weight: 7}], simultaneous_mobs: 4.0f, total_mobs: 12.0f}",
    // rust: ),
    // rust: ];

snbt :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: crate::nbt::parse_snbt(s)
    // rust: .map(|(t, _)| t)
    // rust: .unwrap_or_else(|_| empty_map())
}
// `CompoundTag.merge`.
merge :: proc(into: ^Tag, other: ^Tag) {
}
    // rust: let (Tag::Compound(a), Tag::Compound(b)) = (into, other) else {
    // rust: return;
}
    // rust: for (k, v) in b {
    // rust: match (a.get_mut(k), v) {
    // rust: (Some(existing @ Tag::Compound(_)), Tag::Compound(_)) => merge(existing, v),
    // rust: _ => {
    // rust: a.insert(k.clone(), v.clone());
}
}
}
}
remove_trial_defaults :: proc(tag: ^Tag) {
}
    // rust: let int = |t: &Tag, k: &str| as_int(t.get(k), 0);
    // rust: let float = |t: &Tag, k: &str| as_float(t.get(k), 0.0);
    // rust: if int(tag, "spawn_range") == 4 {
    // rust: remove(tag, "spawn_range");
}
    // rust: if float(tag, "total_mobs") == 6.0 {
    // rust: remove(tag, "total_mobs");
}
    // rust: if float(tag, "simultaneous_mobs") == 2.0 {
    // rust: remove(tag, "simultaneous_mobs");
}
    // rust: if float(tag, "total_mobs_added_per_player") == 2.0 {
    // rust: remove(tag, "total_mobs_added_per_player");
}
    // rust: if float(tag, "simultaneous_mobs_added_per_player") == 1.0 {
    // rust: remove(tag, "simultaneous_mobs_added_per_player");
}
    // rust: if int(tag, "ticks_between_spawn") == 40 {
    // rust: remove(tag, "ticks_between_spawn");
}
}

trial_config_key :: proc(normal: ^Tag, ominous: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: TRIAL_CONFIGS.iter().find_map(|(name, n, o)| {
    // rust: let n = snbt(n);
    // rust: if *normal != n {
    // rust: return None;
}
    // rust: let o = snbt(o);
    // rust: let mut merged = n.clone();
    // rust: merge(&mut merged, &o);
    // rust: let mut trimmed = merged.clone();
    // rust: remove_trial_defaults(&mut trimmed);
    // rust: (*ominous == o || *ominous == merged || *ominous == trimmed).then_some(*name)
    // rust: })
}

trial_spawner_config_in_registry :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:trial_spawner", |be| {
    // rust: let (Some(normal), Some(ominous)) = (be.get("normal_config"), be.get("ominous_config"))
    // rust: else {
    // rust: return;
}
    // rust: if let Some(name) = trial_config_key(normal, ominous) {
    // rust: set(
    // rust: be,
    // rust: "normal_config",
    // rust: string(&format!("minecraft:{name}/normal")),
    // rust: );
    // rust: set(
    // rust: be,
    // rust: "ominous_config",
    // rust: string(&format!("minecraft:{name}/ominous")),
    // rust: );
}
    // rust: });
}

// ------------------------------------------------------------------ 4067, 4068

boat_split :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let id = namespaced(&as_str(e.get("id")).unwrap_or_default());
    // rust: let chest = id == "minecraft:chest_boat";
    // rust: if !chest && id != "minecraft:boat" {
    // rust: return;
}
    // rust: let wood = as_str(e.get("Type"));
    // rust: let new = match wood.as_deref() {
    // rust: Some("spruce") => "spruce",
    // rust: Some("birch") => "birch",
    // rust: Some("jungle") => "jungle",
    // rust: Some("acacia") => "acacia",
    // rust: Some("cherry") => "cherry",
    // rust: Some("dark_oak") => "dark_oak",
    // rust: Some("mangrove") => "mangrove",
    // rust: Some("bamboo") => "bamboo",
    // rust: _ => "oak",
}
    // rust: let new_id = match (new, chest) {
    // rust: ("bamboo", false) => "minecraft:bamboo_raft".into(),
    // rust: ("bamboo", true) => "minecraft:bamboo_chest_raft".into(),
    // rust: (w, false) => format!("minecraft:{w}_boat"),
    // rust: (w, true) => format!("minecraft:{w}_chest_boat"),
}
        // The remainder update runs on the value cast to the new type, whose choice
        // no longer has the old boat id: it finds nothing, so Type stays.
    // rust: set(e, "id", string(&new_id));
    // rust: });
}

// `LockComponentPredicateFix.fixLock`.
fix_lock :: proc(v: Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = as_str(Some(&v))?;
    // rust: if name.is_empty() {
    // rust: return None;
}
    // rust: let escaped = name.replace('\\', "\\\\").replace('"', "\\\"");
    // rust: Some(Tag::compound([(
    // rust: "components",
    // rust: Tag::compound([("minecraft:custom_name", string(&format!("\"{escaped}\"")))]),
    // rust: )]))
}

// `InvalidLockComponentFix.isBrokenLock`: `{components: {custom_name: '""'}}`.
broken_lock :: proc(v: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let one = |t: &Tag, field: &str| {
    // rust: matches!(t, Tag::Compound(c) if c.len() == 1) && t.get(field).is_some()
}
    // rust: one(v, "components")
    // rust: && v.get("components").is_some_and(|c| {
    // rust: one(c, "minecraft:custom_name")
    // rust: && as_str(c.get("minecraft:custom_name")).as_deref() == Some("\"\"")
    // rust: })
}

// ------------------------------------------------------------------ 4181, 4187

furnace_burn_time :: proc(cx: ^Cx, id: string) {
}
    // rust: cx.block_entity(id, |be| {
    // rust: rename(be, "CookTime", "cooking_time_spent");
    // rust: rename(be, "CookTimeTotal", "cooking_total_time");
    // rust: rename(be, "BurnTime", "lit_time_remaining");
    // rust: if let Some(v) = be.get("lit_time_remaining").cloned() {
    // rust: set(be, "lit_total_time", v);
}
    // rust: });
}

base_value :: proc(cx: ^Cx, entity: string, attribute: string, from: f64, to: f64) {
}
    // rust: cx.entity(entity, |e| {
    // rust: update(e, "attributes", |list| {
    // rust: Tag::List(
    // rust: stream(Some(&list))
    // rust: .into_iter()
    // rust: .map(|mut a| {
    // rust: if namespaced(&as_string(a.get("id"), "")) == attribute {
    // rust: let base = as_double(a.get("base"), 0.0);
    // rust: let new = if base == from { to } else { base };
    // rust: set(&mut a, "base", Tag::Double(new.to_bits()));
}
    // rust: a
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: });
}

// ------------------------------------------------------------------ 4293, 4294, 4297

drop_chances_format :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let parse = |v: Option<&Tag>| -> Vec<f32> {
    // rust: stream(v).iter().map(|t| as_float(Some(t), 0.085)).collect()
}
    // rust: let armor = parse(e.get("ArmorDropChances"));
    // rust: let hands = parse(e.get("HandDropChances"));
    // rust: let body = e
    // rust: .get("body_armor_drop_chance")
    // rust: .and_then(as_number)
    // rust: .map_or(0.085, |n| n.float_value());
    // rust: remove(e, "ArmorDropChances");
    // rust: remove(e, "HandDropChances");
    // rust: remove(e, "body_armor_drop_chance");
    // rust: let mut chances = empty_map();
    // rust: for (slots, values) in [
    // rust: (&["feet", "legs", "chest", "head"][..], &armor),
    // rust: (&["mainhand", "offhand"][..], &hands),
    // rust: ] {
    // rust: for (slot, chance) in slots.iter().zip(values.iter()) {
    // rust: if *chance != 0.085 {
    // rust: set(&mut chances, slot, Tag::Float(chance.to_bits()));
}
}
}
    // rust: if body != 0.085 {
    // rust: set(&mut chances, "body", Tag::Float(body.to_bits()));
}
    // rust: if !is_empty_map(&chances) {
    // rust: set(e, "drop_chances", chances);
}
    // rust: });
}

// `LegacyBlockPropertyRenameAndFix`.
    // rust: fn block_property_rename(
    // rust: cx: &mut Cx,
    // rust: block: &str,
    // rust: old: &str,
    // rust: new: &str,
    // rust: f: &dyn Fn(&str) -> String,
    // rust: ) {
    // rust: cx.each(Ty::BlockState, |s| {
    // rust: if as_str(s.get("Name")).map(|n| namespaced(&n)).as_deref() != Some(block) {
    // rust: return;
}
    // rust: if let Some(props) = s.get_mut("Properties") {
    // rust: rename_and_fix(props, old, new, |v| {
    // rust: Some(string(&f(&as_string(Some(&v), ""))))
    // rust: });
}
    // rust: });
}

forced_chunk_to_ticket :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedTickets, |v| {
    // rust: if let Some(data) = v.get_mut("data") {
    // rust: rename_and_fix(data, "Forced", "tickets", |forced| {
    // rust: let longs: Vec<i64> = match &forced {
    // rust: Tag::LongArray(a) => a.clone(),
    // rust: other => stream(Some(other))
    // rust: .iter()
    // rust: .map(|t| as_long(Some(t), 0))
    // rust: .collect(),
}
    // rust: Some(Tag::List(
    // rust: longs
    // rust: .into_iter()
    // rust: .map(|l| {
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:forced")),
    // rust: ("level", Tag::Int(31)),
    // rust: ("ticks_left", Tag::Long(0)),
    // rust: ("chunk_pos", Tag::Long(l)),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: ))
    // rust: });
}
    // rust: });
}

// ------------------------------------------------------------------ 4299

entity_spawner_item_variants :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let id = namespaced(&as_str(s.get("id")).unwrap_or_default());
    // rust: let Some(c) = s.get_mut("components") else {
    // rust: return;
}
    // rust: if id == "minecraft:painting" {
    // rust: fix_painting(c);
    // rust: return;
}
    // rust: let Some(bucket) = c.get("minecraft:bucket_entity_data").cloned() else {
    // rust: return;
}
    // rust: match id.as_str() {
    // rust: "minecraft:salmon_bucket" => {
    // rust: if let Some(ty) = bucket.get("type").cloned() {
    // rust: update(c, "minecraft:bucket_entity_data", |mut b| {
    // rust: remove(&mut b, "type");
    // rust: b
    // rust: });
    // rust: set(c, "minecraft:salmon/size", ty);
}
}
    // rust: "minecraft:axolotl_bucket" => {
    // rust: if let Some(v) = bucket.get("Variant").and_then(as_number) {
    // rust: let variant = match v.int_value() {
    // rust: 1 => "wild",
    // rust: 2 => "gold",
    // rust: 3 => "cyan",
    // rust: 4 => "blue",
    // rust: _ => "lucy",
}
    // rust: update(c, "minecraft:bucket_entity_data", |mut b| {
    // rust: remove(&mut b, "Variant");
    // rust: b
    // rust: });
    // rust: set(c, "minecraft:axolotl/variant", string(variant));
}
}
    // rust: "minecraft:tropical_fish_bucket" => {
    // rust: if let Some(v) = bucket.get("BucketVariantTag").and_then(as_number) {
    // rust: let packed = v.int_value();
    // rust: let pattern = match packed & 0xFFFF {
    // rust: 1 => "flopper",
    // rust: 256 => "sunstreak",
    // rust: 257 => "stripey",
    // rust: 512 => "snooper",
    // rust: 513 => "glitter",
    // rust: 768 => "dasher",
    // rust: 769 => "blockfish",
    // rust: 1024 => "brinely",
    // rust: 1025 => "betty",
    // rust: 1280 => "spotty",
    // rust: 1281 => "clayfish",
    // rust: _ => "kob",
}
    // rust: update(c, "minecraft:bucket_entity_data", |mut b| {
    // rust: remove(&mut b, "BucketVariantTag");
    // rust: b
    // rust: });
    // rust: set(c, "minecraft:tropical_fish/pattern", string(pattern));
    // rust: set(
    // rust: c,
    // rust: "minecraft:tropical_fish/base_color",
    // rust: string(dye_color(packed >> 16 & 0xFF)),
    // rust: );
    // rust: set(
    // rust: c,
    // rust: "minecraft:tropical_fish/pattern_color",
    // rust: string(dye_color(packed >> 24 & 0xFF)),
    // rust: );
}
}
    // rust: _ => {}
}
    // rust: });
}

fix_painting :: proc(c: ^Tag) {
}
    // rust: let Some(data) = c.get("minecraft:entity_data").cloned() else {
    // rust: return;
}
    // rust: if as_str(data.get("id")).as_deref() != Some("minecraft:painting") {
    // rust: return;
}
    // rust: let variant = data.get("variant").cloned();
    // rust: let mut rest = data;
    // rust: remove(&mut rest, "variant");
    // rust: let mut without_id = rest.clone();
    // rust: remove(&mut without_id, "id");
    // rust: if is_empty_map(&without_id) {
    // rust: remove(c, "minecraft:entity_data");
    // rust: } else {
    // rust: set(c, "minecraft:entity_data", rest);
}
    // rust: if let Some(v) = variant {
    // rust: set(c, "minecraft:painting/variant", v);
}
}

// ------------------------------------------------------------------ 4300, 4301, 4303

saddle_drop_chance :: proc(e: ^Tag) {
}
    // rust: let mut chances = or_empty_map(e.get("drop_chances"));
    // rust: set(&mut chances, "saddle", Tag::Float(2.0f32.to_bits()));
    // rust: set(e, "drop_chances", chances);
}

saddle_equipment_slot :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let id = namespaced(&as_str(e.get("id")).unwrap_or_default());
    // rust: match id.as_str() {
    // rust: "minecraft:horse"
    // rust: | "minecraft:skeleton_horse"
    // rust: | "minecraft:zombie_horse"
    // rust: | "minecraft:donkey"
    // rust: | "minecraft:mule"
    // rust: | "minecraft:camel"
    // rust: | "minecraft:llama"
    // rust: | "minecraft:trader_llama" => {
    // rust: if e.get("SaddleItem").is_some() {
    // rust: rename(e, "SaddleItem", "saddle");
    // rust: saddle_drop_chance(e);
}
    // rust: reread(k, e);
}
    // rust: "minecraft:pig" | "minecraft:strider" => {
    // rust: let saddled = as_bool(e.get("Saddle"), false);
    // rust: remove(e, "Saddle");
    // rust: if saddled {
    // rust: set(
    // rust: e,
    // rust: "saddle",
    // rust: Tag::compound([("id", string("minecraft:saddle")), ("count", Tag::Int(1))]),
    // rust: );
    // rust: saddle_drop_chance(e);
}
    // rust: reread(k, e);
}
    // rust: _ => {}
}
    // rust: });
}

// `EquipmentFormatFix` over an entity's (or player's) equipment fields.
    // rust: pub(super) fn equipment_to_slots(e: &mut Tag) {
    // rust: let armor = match remove(e, "ArmorItems") {
    // rust: Some(Tag::List(l)) => l,
    // rust: _ => Vec::new(),
}
    // rust: let hands = match remove(e, "HandItems") {
    // rust: Some(Tag::List(l)) => l,
    // rust: _ => Vec::new(),
}
    // rust: let body = remove(e, "body_armor_item");
    // rust: let saddle = remove(e, "saddle");
    // A stack without an id (an id that does not read as an item name is none) is a
    // placeholder for an empty slot.
    // rust: let pick = |list: &Vec<Tag>, i: usize| {
    // rust: list.get(i)
    // rust: .filter(|s| matches!(s.get("id"), Some(Tag::String(_))))
    // rust: .cloned()
}
    // rust: let slots = [
    // rust: ("mainhand", pick(&hands, 0)),
    // rust: ("offhand", pick(&hands, 1)),
    // rust: ("feet", pick(&armor, 0)),
    // rust: ("legs", pick(&armor, 1)),
    // rust: ("chest", pick(&armor, 2)),
    // rust: ("head", pick(&armor, 3)),
    // rust: ("body", body),
    // rust: ("saddle", saddle),
    // rust: ];
    // The old fields are typed: they come back from the entity's remainder.
    // rust: for field in ["ArmorItems", "HandItems", "body_armor_item", "saddle"] {
    // rust: super::drop_typed(e, field);
}
    // rust: if slots.iter().all(|(_, s)| s.is_none()) {
    // rust: return;
}
    // rust: let mut eq = Compound::new();
    // rust: for (name, stack) in slots {
    // rust: if let Some(s) = stack {
    // rust: eq.insert(name.into(), s);
}
}
    // rust: set(e, "equipment", Tag::Compound(eq));
}

equipment_format :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, equipment_to_slots);
}

fall_distance_to_double :: proc(e: ^Tag) {
}
    // rust: rename_and_fix(e, "FallDistance", "fall_distance", |f| {
    // rust: Some(Tag::Double(f64::from(as_float(Some(&f), 0.0)).to_bits()))
    // rust: });
}

// ------------------------------------------------------------------ 4306, 4307

thrown_potion_split :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if !id_is(e, "minecraft:potion") {
    // rust: return;
}
    // rust: let item = e
    // rust: .get("Item")
    // rust: .and_then(|i| as_str(i.get("id")))
    // rust: .map(|i| namespaced(&i))
    // rust: .unwrap_or_default();
    // rust: let new = if item == "minecraft:lingering_potion" {
    // rust: "minecraft:lingering_potion"
    // rust: } else {
    // rust: "minecraft:splash_potion"
}
    // rust: set(e, "id", string(new));
    // rust: });
}

    // rust: const ADDITIONAL_TOOLTIP_TYPES: [&str; 17] = [
    // rust: "minecraft:banner_patterns",
    // rust: "minecraft:bees",
    // rust: "minecraft:block_entity_data",
    // rust: "minecraft:block_state",
    // rust: "minecraft:bundle_contents",
    // rust: "minecraft:charged_projectiles",
    // rust: "minecraft:container",
    // rust: "minecraft:container_loot",
    // rust: "minecraft:firework_explosion",
    // rust: "minecraft:fireworks",
    // rust: "minecraft:instrument",
    // rust: "minecraft:map_id",
    // rust: "minecraft:painting/variant",
    // rust: "minecraft:pot_decorations",
    // rust: "minecraft:potion_contents",
    // rust: "minecraft:tropical_fish/pattern",
    // rust: "minecraft:written_book_content",
    // rust: ];

tooltip_display :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: let mut hidden: Vec<String> = Vec::new();
    // rust: let add = |h: &mut Vec<String>, id: &str| {
    // rust: if !h.iter().any(|x| x == id) {
    // rust: h.push(id.to_owned());
}
}
    // rust: for id in ["minecraft:can_place_on", "minecraft:can_break"] {
    // rust: if let Some(p) = c.get_mut(id)
    // rust: && let Some(predicates) = p.get("predicates").cloned()
    // rust: {
    // rust: if !as_bool(p.get("show_in_tooltip"), true) {
    // rust: add(&mut hidden, id);
}
    // rust: *p = predicates;
}
}
    // rust: let fix_component = |c: &mut Tag, h: &mut Vec<String>, id: &str, unwrap: Option<&str>| {
    // rust: update(c, id, |mut component| {
    // rust: if !as_bool(component.get("show_in_tooltip"), true) {
    // rust: add(h, id);
}
    // rust: remove(&mut component, "show_in_tooltip");
    // rust: match unwrap.and_then(|f| component.get(f).cloned()) {
    // rust: Some(inner) => inner,
    // rust: None => component,
}
    // rust: });
}
    // rust: fix_component(c, &mut hidden, "minecraft:trim", None);
    // rust: fix_component(c, &mut hidden, "minecraft:unbreakable", None);
    // rust: fix_component(c, &mut hidden, "minecraft:dyed_color", Some("rgb"));
    // rust: fix_component(
    // rust: c,
    // rust: &mut hidden,
    // rust: "minecraft:attribute_modifiers",
    // rust: Some("modifiers"),
    // rust: );
    // rust: fix_component(c, &mut hidden, "minecraft:enchantments", Some("levels"));
    // rust: fix_component(
    // rust: c,
    // rust: &mut hidden,
    // rust: "minecraft:stored_enchantments",
    // rust: Some("levels"),
    // rust: );
    // rust: fix_component(c, &mut hidden, "minecraft:jukebox_playable", Some("song"));
    // rust: let hide_tooltip = remove(c, "minecraft:hide_tooltip").is_some();
    // rust: let hide_additional = remove(c, "minecraft:hide_additional_tooltip").is_some();
    // rust: if hide_additional {
    // rust: for id in ADDITIONAL_TOOLTIP_TYPES {
    // rust: if c.get(id).is_some() && !hidden.iter().any(|x| x == id) {
    // rust: hidden.push(id.to_owned());
}
}
}
    // rust: if !hidden.is_empty() || hide_tooltip {
            // A HashSet: its iteration order.
    // rust: let hidden = java_hash_order(hidden, String::clone);
    // rust: set(
    // rust: c,
    // rust: "minecraft:tooltip_display",
    // rust: Tag::compound([
    // rust: ("hide_tooltip", Tag::Byte(i8::from(hide_tooltip))),
    // rust: (
    // rust: "hidden_components",
    // rust: Tag::List(hidden.iter().map(|s| string(s)).collect()),
    // rust: ),
    // rust: ]),
    // rust: );
}
    // rust: });
}

// ------------------------------------------------------------------ 4309, 4311, 4312, 4314

raid_renames :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedRaids, |v| {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: rename_and_fix(d, "Raids", "raids", |raids| {
    // rust: Some(Tag::List(
    // rust: stream(Some(&raids))
    // rust: .into_iter()
    // rust: .map(|mut r| {
    // rust: fix_inline_block_pos(&mut r, "CX", "CY", "CZ", "center");
    // rust: for (a, b) in [
    // rust: ("Id", "id"),
    // rust: ("Started", "started"),
    // rust: ("Active", "active"),
    // rust: ("TicksActive", "ticks_active"),
    // rust: ("BadOmenLevel", "raid_omen_level"),
    // rust: ("GroupsSpawned", "groups_spawned"),
    // rust: ("PreRaidTicks", "cooldown_ticks"),
    // rust: ("PostRaidTicks", "post_raid_ticks"),
    // rust: ("TotalHealth", "total_health"),
    // rust: ("NumGroups", "group_count"),
    // rust: ("Status", "status"),
    // rust: ("HeroesOfTheVillage", "heroes_of_the_village"),
    // rust: ] {
    // rust: rename(&mut r, a, b);
}
    // rust: r
    // rust: })
    // rust: .collect(),
    // rust: ))
    // rust: });
    // rust: rename(d, "Tick", "tick");
    // rust: rename(d, "NextAvailableID", "next_id");
}
    // rust: });
}

chunk_ticket_unpack_pos :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedTickets, |v| {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: update(d, "tickets", |tickets| {
    // rust: Tag::List(
    // rust: stream(Some(&tickets))
    // rust: .into_iter()
    // rust: .map(|mut t| {
    // rust: update(&mut t, "chunk_pos", |p| {
    // rust: let key = as_long(Some(&p), 0);
    // rust: Tag::IntArray(vec![key as i32, (key as u64 >> 32) as i32])
    // rust: });
    // rust: t
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
}
    // rust: });
}

// `AdvancementsRenameFix`: the advancement ids of an advancements file.
    // rust: pub(super) fn advancements_rename(cx: &mut Cx, rename_fn: &dyn Fn(&str) -> Option<String>) {
    // rust: cx.each(Ty::Advancements, |v| {
    // rust: if let Tag::Compound(c) = v {
    // rust: let old = std::mem::take(c);
    // rust: for (k, value) in old {
    // rust: let id = k.to_string_lossy();
    // rust: let k = rename_fn(&id).map_or(k, |n| n.as_str().into());
    // rust: c.insert(k, value);
}
}
    // rust: });
}

player_equipment :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Player, |p| {
    // rust: let mut equipment = Compound::new();
    // rust: update(p, "Inventory", |inv| {
    // rust: Tag::List(
    // rust: stream(Some(&inv))
    // rust: .into_iter()
    // rust: .filter_map(|mut item| {
    // rust: let slot = match as_int(item.get("Slot"), -1) {
    // rust: 100 => Some("feet"),
    // rust: 101 => Some("legs"),
    // rust: 102 => Some("chest"),
    // rust: 103 => Some("head"),
    // rust: -106 => Some("offhand"),
    // rust: _ => None,
}
    // rust: match slot {
    // rust: Some(s) => {
    // rust: remove(&mut item, "Slot");
    // rust: equipment.insert(s.into(), item);
    // rust: None
}
    // rust: None => Some(item),
}
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: set(p, "equipment", Tag::Compound(equipment));
    // rust: });
}

inline_block_pos_format :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Player, |p| {
    // rust: fix_inline_block_pos(p, "SleepingX", "SleepingY", "SleepingZ", "sleeping_pos");
    // rust: let spawn = (
    // rust: p.get("SpawnX").and_then(as_number),
    // rust: p.get("SpawnY").and_then(as_number),
    // rust: p.get("SpawnZ").and_then(as_number),
    // rust: );
    // rust: if let (Some(x), Some(y), Some(z)) = spawn {
    // rust: let mut respawn = Tag::compound([(
    // rust: "pos",
    // rust: Tag::IntArray(vec![x.int_value(), y.int_value(), z.int_value()]),
    // rust: )]);
    // rust: let source = p.clone();
    // rust: super::dynamic::copy_field(&source, "SpawnAngle", &mut respawn, "angle");
    // rust: super::dynamic::copy_field(&source, "SpawnDimension", &mut respawn, "dimension");
    // rust: super::dynamic::copy_field(&source, "SpawnForced", &mut respawn, "forced");
    // rust: for k in [
    // rust: "SpawnX",
    // rust: "SpawnY",
    // rust: "SpawnZ",
    // rust: "SpawnAngle",
    // rust: "SpawnDimension",
    // rust: "SpawnForced",
    // rust: ] {
    // rust: remove(p, k);
}
    // rust: set(p, "respawn", respawn);
}
    // rust: if let Some(pos) = remove(p, "enteredNetherPosition") {
    // rust: set(
    // rust: p,
    // rust: "entered_nether_pos",
    // rust: Tag::List(
    // rust: ["x", "y", "z"]
    // rust: .iter()
    // rust: .map(|k| Tag::Double(as_double(pos.get(k), 0.0).to_bits()))
    // rust: .collect(),
    // rust: ),
    // rust: );
}
    // rust: });
    // rust: cx.each(Ty::Entity, |e| {
    // rust: fix_inline_block_pos(e, "SleepingX", "SleepingY", "SleepingZ", "sleeping_pos");
    // rust: if id_is(e, "minecraft:vex") {
    // rust: rename(e, "LifeTicks", "life_ticks");
    // rust: fix_inline_block_pos(e, "BoundX", "BoundY", "BoundZ", "bound_pos");
}
    // rust: if id_is(e, "minecraft:phantom") {
    // rust: rename(e, "Size", "size");
    // rust: fix_inline_block_pos(e, "AX", "AY", "AZ", "anchor_pos");
}
    // rust: if id_is(e, "minecraft:turtle") {
    // rust: for k in ["TravelPosX", "TravelPosY", "TravelPosZ"] {
    // rust: remove(e, k);
}
    // rust: fix_inline_block_pos(e, "HomePosX", "HomePosY", "HomePosZ", "home_pos");
    // rust: rename(e, "HasEgg", "has_egg");
}
    // rust: for id in [
    // rust: "minecraft:item_frame",
    // rust: "minecraft:glow_item_frame",
    // rust: "minecraft:painting",
    // rust: "minecraft:leash_knot",
    // rust: ] {
    // rust: if id_is(e, id) {
    // rust: fix_inline_block_pos(e, "TileX", "TileY", "TileZ", "block_pos");
}
}
    // rust: });
}
