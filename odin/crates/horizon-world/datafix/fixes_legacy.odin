//! Transpiled from Horizon Rust crate
package horizon_world_fixes_legacy

import "core:fmt"
import "core:mem"
import "core:math"

// Fixes of 1.8 to 1.12 (keys 100 to 1125, DataVersion up to 1343): what worlds
// saved by those versions need before the flattening ([`super::fixes_flat`]).
// The options fixes of this range (505, 816, 1344) are client settings.
// use super::dynamic::{
    // rust: as_bool, as_float, as_int, as_int_stream, as_number, as_str, boolean, empty_map, is_list,
    // rust: namespaced, remove, set, stream, string,
}
// use super::flat_tables as t;
// use super::schema::flat::entity_tree_known;
// use super::schema::{Key, Ty, block_entity_known, key};
// use super::{Cx, FixFn, drop_typed, items, mark_read, reread, reread_as};
// use crate::nbt::{JavaString, Tag};

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(100, 0), equipment_to_armor_and_hands));
    // rust: out.push((key(101, 0), |cx| {
    // rust: cx.entity("Villager", |e| set(e, "CanPickUpLoot", boolean(true)))
    // rust: }));
    // rust: out.push((key(102, 0), item_ids));
    // rust: out.push((key(102, 0), item_potions));
    // rust: out.push((key(105, 0), spawn_egg_entities));
    // rust: out.push((key(106, 0), spawner_entity_identifiers));
    // rust: out.push((key(107, 0), minecart_identifiers));
    // rust: out.push((key(108, 0), entity_string_uuid));
    // rust: out.push((key(109, 0), entity_health));
    // rust: out.push((key(110, 0), horse_saddle));
    // rust: out.push((key(111, 0), painting_item_frame_direction));
    // rust: out.push((key(113, 0), redundant_chance_tags));
    // rust: out.push((key(135, 0), riding_to_passengers));
    // rust: out.push((key(143, 0), |cx| {
    // rust: cx.entity("TippedArrow", |e| set(e, "id", string("Arrow")))
    // rust: }));
    // rust: out.push((key(147, 0), armor_stand_silent));
    // rust: out.push((key(165, 0), sign_text_strict_json));
    // rust: out.push((key(165, 0), written_book_pages_strict_json));
    // rust: out.push((key(502, 0), |cx| {
    // rust: cx.rename(Ty::ItemName, |name| {
    // rust: (namespaced(name) == "minecraft:cooked_fished").then_some("minecraft:cooked_fish")
    // rust: })
    // rust: }));
    // rust: out.push((key(502, 0), zombie_villager_type));
    // rust: out.push((key(700, 0), elder_guardian_split));
    // rust: out.push((key(701, 0), skeleton_split));
    // rust: out.push((key(702, 0), zombie_split));
    // rust: out.push((key(703, 0), horse_split));
    // rust: out.push((key(704, 0), block_entity_ids));
    // rust: out.push((key(705, 0), entity_ids));
    // rust: out.push((key(804, 0), item_banner_color));
    // rust: out.push((key(806, 0), item_water_potion));
    // rust: out.push((key(808, 1), shulker_color));
    // rust: out.push((key(813, 0), item_shulker_box_color));
    // rust: out.push((key(813, 0), |cx| {
    // rust: cx.block_entity("minecraft:shulker_box", |be| {
    // rust: remove(be, "Color");
    // rust: })
    // rust: }));
    // rust: out.push((key(820, 0), |cx| {
    // rust: cx.rename(Ty::ItemName, |name| {
    // rust: (namespaced(name) == "minecraft:totem").then_some("minecraft:totem_of_undying")
    // rust: })
    // rust: }));
    // rust: out.push((key(1022, 0), |cx| {
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Player, |p| reread_as(Ty::Player, k, p))
    // rust: }));
    // rust: out.push((key(1125, 0), bed_block_entities));
    // rust: out.push((key(1125, 0), |cx| {
    // rust: cx.item(
    // rust: |id| id == "minecraft:bed",
    // rust: |s| {
    // rust: if as_int(s.get("Damage"), 0) == 0 {
    // rust: set(s, "Damage", Tag::Short(14));
}
    // rust: },
    // rust: )
    // rust: }));
}

// `Number.shortValue` of a numeric field, or the default (`Dynamic.asShort`).
as_short :: proc(tag: Maybe(^Tag), default: i16) -> i {
    // Ported from Horizon
    return {}
}
    // rust: tag.and_then(as_number)
    // rust: .map_or(default, |n| n.int_value() as i16)
}

lookup_int :: proc(table: ^'static [(i32) {
}
    // rust: table.iter().find(|(i, _)| *i == k).map(|(_, v)| *v)
}

lookup_str :: proc(table: ^'static [(^'static str) {
}
    // rust: table.iter().find(|(i, _)| *i == k).map(|(_, v)| *v)
}

float_list :: proc(values: ^[f32]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::List(values.iter().map(|v| Tag::Float(v.to_bits())).collect())
}

// ------------------------------------------------------------------ 100

// `EntityEquipmentToArmorAndHandFix`: the `Equipment` list becomes hand and armor items.
equipment_to_armor_and_hands :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
        // The drop chances come first.
    // rust: let chances: Option<Vec<f32>> =
    // rust: e.get("DropChances").filter(|c| is_list(Some(c))).map(|c| {
    // rust: stream(Some(c))
    // rust: .iter()
    // rust: .map(|v| as_float(Some(v), 0.0))
    // rust: .collect()
    // rust: });
    // rust: remove(e, "DropChances");
    // rust: if let Some(mut chances) = chances {
    // rust: chances.extend([0.0; 5]);
    // rust: if e.get("HandDropChances").is_none() {
    // rust: set(e, "HandDropChances", float_list(&[chances[0], 0.0]));
}
    // rust: if e.get("ArmorDropChances").is_none() {
    // rust: set(e, "ArmorDropChances", float_list(&chances[1..5]));
}
}
        // The equipment list reads only if every element is a compound.
    // rust: let items: Vec<Tag> = match e.get("Equipment") {
    // rust: Some(Tag::List(items)) if items.iter().all(|i| matches!(i, Tag::Compound(_))) => {
    // rust: items.clone()
}
    // rust: _ => Vec::new(),
}
    // rust: if !items.is_empty() {
    // rust: set(
    // rust: e,
    // rust: "HandItems",
    // rust: Tag::List(vec![items[0].clone(), empty_map()]),
    // rust: );
}
    // rust: if items.len() > 1 {
    // rust: let mut armor = vec![empty_map(); 4];
    // rust: let end = items.len().min(5);
    // rust: armor[..end - 1].clone_from_slice(&items[1..end]);
    // rust: set(e, "ArmorItems", Tag::List(armor));
}
        // `Equipment` is no field of the new type: the map it was read from gives it back.
    // rust: drop_typed(e, "Equipment");
    // rust: });
}

// ------------------------------------------------------------------ 102

// `ItemIdFix`: numeric item ids become names.
item_ids :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let new = match s.get("id") {
    // rust: Some(Tag::String(id)) => namespaced(&id.to_string_lossy()),
    // rust: Some(other) => match as_number(other) {
    // rust: Some(n) => lookup_int(t::ITEM_IDS, n.int_value())
    // rust: .unwrap_or("minecraft:air")
    // rust: .to_owned(),
    // rust: None => return,
    // rust: },
    // rust: None => return,
}
    // rust: set(s, "id", string(&new));
    // rust: });
}

// `ItemPotionFix`: potion damage values become potion names.
item_potions :: proc(cx: ^Cx) {
}
    // rust: cx.item(
    // rust: |id| id == "minecraft:potion",
    // rust: |s| {
    // rust: if !matches!(s.get("tag"), Some(Tag::Compound(_))) {
    // rust: return;
}
    // rust: let damage = i32::from(as_short(s.get("Damage"), 0));
    // rust: if let Some(tag) = s.get_mut("tag")
    // rust: && !matches!(tag.get("Potion"), Some(Tag::String(_)))
    // rust: {
    // rust: let potion = lookup_int(t::ITEM_POTIONS, damage & 127).unwrap_or("minecraft:water");
    // rust: set(tag, "Potion", string(potion));
    // rust: if damage & 16384 == 16384 {
    // rust: set(s, "id", string("minecraft:splash_potion"));
}
}
    // rust: if damage != 0 {
    // rust: set(s, "Damage", Tag::Short(0));
}
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 105

// `ItemSpawnEggFix`: the damage of a spawn egg becomes the entity it spawns.
spawn_egg_entities :: proc(cx: ^Cx) {
}
    // rust: let (k, input) = (cx.k, cx.k - 1);
    // rust: cx.item(
    // rust: |id| id == "minecraft:spawn_egg",
    // rust: |s| {
    // rust: let damage = i32::from(as_short(s.get("Damage"), 0));
    // rust: if let Some(entity) = lookup_int(t::SPAWN_EGG_ENTITIES, damage & 0xFF) {
                // The entity tree is typed only if its id is one of the schema's.
    // rust: let typed = s
    // rust: .get("tag")
    // rust: .and_then(|tag| tag.get("EntityTag"))
    // rust: .filter(|e| entity_tree_known(e, input))
    // rust: .cloned();
    // rust: let old_id = typed.as_ref().and_then(|e| as_str(e.get("id")));
    // rust: if old_id.as_deref() != Some(entity) {
    // rust: if !matches!(s.get("tag"), Some(Tag::Compound(_))) {
    // rust: set(s, "tag", empty_map());
}
    // rust: let mut entity_tag = typed.unwrap_or_else(empty_map);
    // rust: set(&mut entity_tag, "id", string(entity));
    // rust: reread_as(Ty::EntityTree, k, &mut entity_tag);
    // rust: if let Some(tag) = s.get_mut("tag") {
    // rust: set(tag, "EntityTag", entity_tag);
}
}
}
    // rust: if damage != 0 {
    // rust: set(s, "Damage", Tag::Short(0));
}
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 106

// `MobSpawnerEntityIdentifiersFix`: the spawned entity is a tree of its own.
spawner_entity_identifiers :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::UntaggedSpawner, |sp| {
    // rust: if !matches!(sp, Tag::Compound(_)) {
    // rust: return;
}
    // rust: if let Some(Tag::String(entity)) = sp.get("EntityId") {
    // rust: let id = if entity.0.is_empty() {
    // rust: string("Pig")
    // rust: } else {
    // rust: Tag::String(entity.clone())
}
    // rust: let mut data = sp.get("SpawnData").cloned().unwrap_or_else(empty_map);
    // rust: if matches!(data, Tag::Compound(_)) {
    // rust: set(&mut data, "id", id);
}
    // rust: set(sp, "SpawnData", data);
    // rust: remove(sp, "EntityId");
}
    // rust: if let Some(Tag::List(potentials)) = sp.get_mut("SpawnPotentials") {
    // rust: for potential in potentials {
    // rust: if let Some(Tag::String(entity)) = potential.get("Type") {
    // rust: let entity = entity.clone();
    // rust: let mut data = potential
    // rust: .get("Properties")
    // rust: .cloned()
    // rust: .unwrap_or_else(empty_map);
    // rust: if matches!(data, Tag::Compound(_)) {
    // rust: set(&mut data, "id", Tag::String(entity));
}
    // rust: set(potential, "Entity", data);
    // rust: remove(potential, "Type");
    // rust: remove(potential, "Properties");
}
}
}
    // rust: reread_as(Ty::UntaggedSpawner, k, sp);
    // rust: });
}

// ------------------------------------------------------------------ 107

// `EntityMinecartIdentifiersFix`: a minecart's type becomes its entity id.
minecart_identifiers :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.entity("Minecart", |e| {
    // rust: let name = match as_int(e.get("Type"), 0) {
    // rust: 1 => "MinecartChest",
    // rust: 2 => "MinecartFurnace",
    // rust: _ => "MinecartRideable",
}
    // rust: set(e, "id", string(name));
    // rust: remove(e, "Type");
    // rust: reread(k, e);
    // rust: });
}

// ------------------------------------------------------------------ 108

// `UUID.fromString`.
parse_uuid :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let parts: Vec<&str> = s.split('-').collect();
    // rust: if parts.len() != 5 {
    // rust: return None;
}
    // rust: let part = |i: usize| i64::from_str_radix(parts[i], 16).ok();
    // rust: let mut most = part(0)? & 0xFFFF_FFFF;
    // rust: most = (most << 16) | (part(1)? & 0xFFFF);
    // rust: most = (most << 16) | (part(2)? & 0xFFFF);
    // rust: let mut least = part(3)? & 0xFFFF;
    // rust: least = (least << 48) | (part(4)? & 0xFFFF_FFFF_FFFF);
    // rust: Some((most, least))
}

// `EntityStringUuidFix`: the string UUID becomes a most/least pair.
entity_string_uuid :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if let Some(uuid) = as_str(e.get("UUID"))
    // rust: && let Some((most, least)) = parse_uuid(&uuid)
    // rust: {
    // rust: remove(e, "UUID");
    // rust: set(e, "UUIDMost", Tag::Long(most));
    // rust: set(e, "UUIDLeast", Tag::Long(least));
}
    // rust: });
}

// ------------------------------------------------------------------ 109

// `EntityHealthFix`: the health is a float.
entity_health :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let heal_f = e.get("HealF").and_then(as_number);
    // rust: let health = e.get("Health").and_then(as_number);
    // rust: let value = if let Some(n) = heal_f {
    // rust: remove(e, "HealF");
    // rust: n.float_value()
    // rust: } else if let Some(n) = health {
    // rust: n.float_value()
    // rust: } else {
    // rust: return;
}
    // rust: set(e, "Health", Tag::Float(value.to_bits()));
    // rust: });
}

// ------------------------------------------------------------------ 110

// `EntityHorseSaddleFix`: a saddled horse has a saddle item.
horse_saddle :: proc(cx: ^Cx) {
}
    // rust: cx.entity("EntityHorse", |e| {
    // rust: if !matches!(e.get("SaddleItem"), Some(Tag::Compound(_))) && as_bool(e.get("Saddle"), false)
    // rust: {
            // `Saddle` stays: `Dynamic.remove` was not kept by the fix.
    // rust: set(
    // rust: e,
    // rust: "SaddleItem",
    // rust: Tag::compound([
    // rust: ("id", string("minecraft:saddle")),
    // rust: ("Count", Tag::Byte(1)),
    // rust: ("Damage", Tag::Short(0)),
    // rust: ]),
    // rust: );
}
    // rust: });
}

// ------------------------------------------------------------------ 111

// `EntityPaintingItemFrameDirectionFix`.
painting_item_frame_direction :: proc(cx: ^Cx) {
}
DIRECTIONS :: [[0, 0, 1], [-1, 0, 0], [0, 0, -1], [1, 0, 0]]
    // rust: for (id, item_frame) in [("Painting", false), ("ItemFrame", true)] {
    // rust: cx.entity(id, |e| {
    // rust: if e.get("Facing").and_then(as_number).is_some() {
    // rust: return;
}
    // rust: let byte = |tag: Option<&Tag>| tag.and_then(as_number).map_or(0, |n| n.byte_value());
    // rust: let direction;
    // rust: if e.get("Direction").and_then(as_number).is_some() {
    // rust: direction = i32::from(byte(e.get("Direction"))) % 4;
    // rust: let Some(steps) = usize::try_from(direction).ok().map(|d| DIRECTIONS[d]) else {
    // rust: return;
}
    // rust: for (field, step) in ["TileX", "TileY", "TileZ"].into_iter().zip(steps) {
    // rust: let value = as_int(e.get(field), 0).wrapping_add(step);
    // rust: set(e, field, Tag::Int(value));
}
    // rust: remove(e, "Direction");
    // rust: if item_frame && e.get("ItemRotation").and_then(as_number).is_some() {
    // rust: let rotation = i32::from(byte(e.get("ItemRotation"))) * 2;
    // rust: set(e, "ItemRotation", Tag::Byte(rotation as i8));
}
    // rust: } else {
    // rust: direction = i32::from(byte(e.get("Dir"))) % 4;
    // rust: remove(e, "Dir");
}
    // rust: set(e, "Facing", Tag::Byte(direction as i8));
    // rust: });
}
}

// ------------------------------------------------------------------ 113

// `EntityRedundantChanceTagsFix`: drop chances that are all zero are not saved.
redundant_chance_tags :: proc(cx: ^Cx) {
}
    // rust: let is_zero_list = |tag: Option<&Tag>, size: usize| {
    // rust: let Some(tag) = tag.filter(|t| is_list(Some(t))) else {
    // rust: return false;
}
    // rust: let values = stream(Some(tag));
    // rust: values.len() == size
    // rust: && values
    // rust: .iter()
    // rust: .all(|v| as_number(v).is_some_and(|n| n.float_value() == 0.0))
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if is_zero_list(e.get("HandDropChances"), 2) {
    // rust: remove(e, "HandDropChances");
}
    // rust: if is_zero_list(e.get("ArmorDropChances"), 4) {
    // rust: remove(e, "ArmorDropChances");
}
    // rust: });
}

// ------------------------------------------------------------------ 135

// `EntityRidingToPassengersFix`: the vehicle is the root and carries its riders.
riding_to_passengers :: proc(cx: ^Cx) {
}
    // rust: let (k, input) = (cx.k, cx.k - 1);
    // rust: cx.each(Ty::EntityTree, |tree| {
    // rust: if !entity_tree_known(tree, input) {
    // rust: return;
}
        // The vehicle was fixed first: it has its passengers already.
    // rust: let Some(vehicle) = tree.get("Riding").filter(|v| entity_tree_known(v, input)) else {
    // rust: return;
}
    // rust: let vehicle = vehicle.clone();
    // rust: let mut rider = tree.clone();
    // rust: remove(&mut rider, "Riding");
        // `Riding` is no field of the new type: the map the rider was read from gives it back.
    // rust: drop_typed(&mut rider, "Riding");
    // rust: *tree = add_passenger_to_top(vehicle, rider);
    // rust: });
    // rust: cx.each(Ty::Player, |p| reread_as(Ty::Player, k, p));
}

// `EntityRidingToPassengersFix.addPassengerToTop`: the rider goes to the end of the chain.
add_passenger_to_top :: proc(mut root: Tag, passenger: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let first = match root.get("Passengers") {
    // rust: Some(Tag::List(passengers)) => passengers.first().cloned(),
    // rust: _ => None,
}
    // rust: let passenger = match first {
    // rust: Some(first) => add_passenger_to_top(first, passenger),
    // rust: None => passenger,
}
    // rust: set(&mut root, "Passengers", Tag::List(vec![passenger]));
    // rust: root
}

// ------------------------------------------------------------------ 147

// `EntityArmorStandSilentFix`.
armor_stand_silent :: proc(cx: ^Cx) {
}
    // rust: cx.entity("ArmorStand", |e| {
    // rust: if as_bool(e.get("Silent"), false) && !as_bool(e.get("Marker"), false) {
    // rust: remove(e, "Silent");
}
    // rust: });
}

// ------------------------------------------------------------------ 165

// `LegacyComponentDataFixUtils.rewriteFromLenient`.
rewrite_from_lenient :: proc(text: ^[u16]) -> V {
    // Ported from Horizon
    return {}
}
//     use super::json::{self, Json};
    // rust: let empty = || json::text_component_json(&[]);
    // rust: if text.is_empty() || text == "null".encode_utf16().collect::<Vec<_>>().as_slice() {
    // rust: return empty();
}
    // rust: let (first, last) = (text[0], text[text.len() - 1]);
    // rust: let (quote, open_brace, close_brace, open_bracket, close_bracket) = (
    // rust: u16::from(b'"'),
    // rust: u16::from(b'{'),
    // rust: u16::from(b'}'),
    // rust: u16::from(b'['),
    // rust: u16::from(b']'),
    // rust: );
    // rust: let wrapped = (first == quote && last == quote)
    // rust: || (first == open_brace && last == close_brace)
    // rust: || (first == open_bracket && last == close_bracket);
    // rust: if wrapped && let Some(parsed) = json::parse_lenient(text) {
    // rust: return match parsed {
    // rust: Json::Str(s) => json::text_component_json(&s),
    // rust: Json::Num(n) => json::text_component_json(&n.encode_utf16().collect::<Vec<_>>()),
    // rust: Json::Bool(b) => json::text_component_json(
    // rust: &(if b { "true" } else { "false" })
    // rust: .encode_utf16()
    // rust: .collect::<Vec<_>>(),
    // rust: ),
    // rust: other => json::to_stable_string(&other),
}
}
    // rust: json::text_component_json(text)
}

// `SignTextStrictJsonFix`: the lines of a sign are strict JSON.
sign_text_strict_json :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("Sign", |be| {
    // rust: for line in ["Text1", "Text2", "Text3", "Text4"] {
    // rust: if let Some(Tag::String(text)) = be.get(line) {
    // rust: let fixed = rewrite_from_lenient(&text.0);
    // rust: set(be, line, Tag::String(JavaString(fixed)));
}
}
    // rust: });
}

// `WrittenBookPagesStrictJsonFix`: the pages of a written book are strict JSON.
written_book_pages_strict_json :: proc(cx: ^Cx) {
}
    // rust: cx.item(
    // rust: |id| id == "minecraft:written_book",
    // rust: |s| {
    // rust: let Some(Tag::List(pages)) = s.get_mut("tag").and_then(|t| t.get_mut("pages")) else {
    // rust: return;
}
    // rust: if pages.iter().all(|p| matches!(p, Tag::String(_))) {
    // rust: for page in pages {
    // rust: if let Tag::String(text) = page {
    // rust: *text = JavaString(rewrite_from_lenient(&text.0));
}
}
}
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 502

// `EntityZombieVillagerTypeFix`: `IsVillager` becomes a zombie type.
zombie_villager_type :: proc(cx: ^Cx) {
}
    // rust: cx.entity("Zombie", |e| {
    // rust: if !as_bool(e.get("IsVillager"), false) {
    // rust: return;
}
    // rust: if e.get("ZombieType").is_none() {
    // rust: let profession = as_int(e.get("VillagerProfession"), -1);
            // Vanilla picks a random profession for an invalid one: nothing to match there.
    // rust: let profession = if (0..6).contains(&profession) {
    // rust: profession
    // rust: } else {
    // rust: 0
}
    // rust: set(e, "ZombieType", Tag::Int(profession));
}
    // rust: remove(e, "IsVillager");
    // rust: });
}

// ------------------------------------------------------------------ 700 to 703

// `EntityElderGuardianSplitFix`.
elder_guardian_split :: proc(cx: ^Cx) {
}
    // rust: cx.entity("Guardian", |e| {
    // rust: if as_bool(e.get("Elder"), false) {
    // rust: set(e, "id", string("ElderGuardian"));
}
    // rust: });
}

// `EntitySkeletonSplitFix`.
skeleton_split :: proc(cx: ^Cx) {
}
    // rust: cx.entity("Skeleton", |e| match as_int(e.get("SkeletonType"), 0) {
    // rust: 1 => set(e, "id", string("WitherSkeleton")),
    // rust: 2 => set(e, "id", string("Stray")),
    // rust: _ => {}
    // rust: });
}

// `EntityZombieSplitFix`.
zombie_split :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.entity("Zombie", |e| {
    // rust: let zombie_type = as_int(e.get("ZombieType"), 0);
    // rust: match zombie_type {
    // rust: 1..=5 => {
    // rust: set(e, "id", string("ZombieVillager"));
    // rust: set(e, "Profession", Tag::Int(zombie_type - 1));
    // rust: reread(k, e);
}
    // rust: 6 => set(e, "id", string("Husk")),
    // rust: _ => {}
}
    // rust: remove(e, "ZombieType");
    // rust: });
}

// `EntityHorseSplitFix`.
horse_split :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.entity("EntityHorse", |e| {
    // rust: let name = match as_int(e.get("Type"), 0) {
    // rust: 1 => "Donkey",
    // rust: 2 => "Mule",
    // rust: 3 => "ZombieHorse",
    // rust: 4 => "SkeletonHorse",
    // rust: _ => "Horse",
}
    // rust: set(e, "id", string(name));
    // rust: remove(e, "Type");
    // rust: reread(k, e);
    // rust: });
}

// ------------------------------------------------------------------ 704, 705

// `BlockEntityIdFix`: block entity ids are namespaced. The item stacks are read
// again first, with the hook of the new schema.
block_entity_ids :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::ItemStack, |s| items::add_names_at(s, k));
    // rust: cx.each(Ty::BlockEntity, |be| {
    // rust: if let Some(id) = as_str(be.get("id"))
    // rust: && let Some(new) = lookup_str(t::BLOCK_ENTITY_IDS, &id)
    // rust: {
    // rust: set(be, "id", string(new));
}
    // rust: });
}

// `EntityIdFix`: entity ids are namespaced (the item stacks are read again first).
entity_ids :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::ItemStack, |s| items::add_names_at(s, k));
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if let Some(id) = as_str(e.get("id"))
    // rust: && let Some(new) = lookup_str(t::ENTITY_IDS, &id)
    // rust: {
    // rust: set(e, "id", string(new));
}
    // rust: });
}

// ------------------------------------------------------------------ 804 to 813

// `ItemBannerColorFix`: a banner item's damage is its base colour.
item_banner_color :: proc(cx: ^Cx) {
}
    // rust: let input = cx.k - 1;
    // rust: cx.item(
    // rust: |id| id == "minecraft:banner",
    // rust: |s| {
    // rust: let Some(base) = s
    // rust: .get("tag")
    // rust: .and_then(|tag| tag.get("BlockEntityTag"))
    // rust: .filter(|be| block_entity_known(be, input))
    // rust: .and_then(|be| be.get("Base"))
    // rust: .and_then(as_number)
    // rust: else {
    // rust: return;
}
    // rust: set(s, "Damage", Tag::Short((base.int_value() & 15) as i16));
    // rust: let pick_marker = Tag::compound([("Lore", Tag::List(vec![string("(+NBT")]))]);
    // rust: if s.get("tag")
    // rust: .and_then(|tag| tag.get("display"))
    // rust: .is_some_and(|display| *display == pick_marker)
    // rust: {
    // rust: return;
}
    // rust: if let Some(be) = s
    // rust: .get_mut("tag")
    // rust: .and_then(|tag| tag.get_mut("BlockEntityTag"))
    // rust: {
    // rust: remove(be, "Base");
}
    // rust: },
    // rust: );
}

// `ItemWaterPotionFix`: potions without a type are water.
item_water_potion :: proc(cx: ^Cx) {
}
    // rust: cx.item(
    // rust: |id| {
    // rust: matches!(
    // rust: id,
    // rust: "minecraft:potion"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:tipped_arrow"
    // rust: )
    // rust: },
    // rust: |s| {
    // rust: if !matches!(s.get("tag"), Some(Tag::Compound(_))) {
    // rust: set(s, "tag", empty_map());
}
    // rust: if let Some(tag) = s.get_mut("tag")
    // rust: && !matches!(tag.get("Potion"), Some(Tag::String(_)))
    // rust: {
    // rust: set(tag, "Potion", string("minecraft:water"));
}
    // rust: },
    // rust: );
}

// `EntityShulkerColorFix`: shulkers of before 1.11 are purple.
shulker_color :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:shulker", |e| {
    // rust: if e.get("Color").is_none() {
    // rust: set(e, "Color", Tag::Byte(10));
}
    // rust: });
}

    // rust: const SHULKER_BOX_COLORS: [&str; 16] = [
    // rust: "minecraft:white_shulker_box",
    // rust: "minecraft:orange_shulker_box",
    // rust: "minecraft:magenta_shulker_box",
    // rust: "minecraft:light_blue_shulker_box",
    // rust: "minecraft:yellow_shulker_box",
    // rust: "minecraft:lime_shulker_box",
    // rust: "minecraft:pink_shulker_box",
    // rust: "minecraft:gray_shulker_box",
    // rust: "minecraft:silver_shulker_box",
    // rust: "minecraft:cyan_shulker_box",
    // rust: "minecraft:purple_shulker_box",
    // rust: "minecraft:blue_shulker_box",
    // rust: "minecraft:brown_shulker_box",
    // rust: "minecraft:green_shulker_box",
    // rust: "minecraft:red_shulker_box",
    // rust: "minecraft:black_shulker_box",
    // rust: ];

// `ItemShulkerBoxColorFix`: the colour of a shulker box item is in its name.
item_shulker_box_color :: proc(cx: ^Cx) {
}
    // rust: let input = cx.k - 1;
    // rust: cx.item(
    // rust: |id| id == "minecraft:shulker_box",
    // rust: |s| {
    // rust: let Some(be) = s
    // rust: .get("tag")
    // rust: .and_then(|tag| tag.get("BlockEntityTag"))
    // rust: .filter(|be| block_entity_known(be, input))
    // rust: else {
    // rust: return;
}
            // `Color` stays in the block entity: the fix does not keep `Dynamic.remove`.
    // rust: let color = as_int(be.get("Color"), 0);
    // rust: let name = SHULKER_BOX_COLORS[color.rem_euclid(16) as usize];
    // rust: set(s, "id", string(name));
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 1125

// `ChunkBedBlockEntityInjecterFix`: a bed block gets the block entity 1.12 gave it.
bed_block_entities :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Chunk, |chunk| {
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: let chunk_x = as_int(level.get("xPos"), 0);
    // rust: let chunk_z = as_int(level.get("zPos"), 0);
    // rust: let mut beds = Vec::new();
    // rust: if let Some(Tag::List(sections)) = level.get("Sections") {
    // rust: for section in sections {
    // rust: let y = as_int(section.get("Y"), 0);
    // rust: for (p, block) in as_int_stream(section.get("Blocks"))
    // rust: .unwrap_or_default()
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if (block & 0xFF) << 4 == 416 {
    // rust: let (x, yy, z) = (p as i32 & 15, p as i32 >> 8 & 15, p as i32 >> 4 & 15);
    // rust: let mut bed = Tag::compound([
    // rust: ("id", string("minecraft:bed")),
    // rust: ("x", Tag::Int(x + (chunk_x << 4))),
    // rust: ("y", Tag::Int(yy + (y << 4))),
    // rust: ("z", Tag::Int(z + (chunk_z << 4))),
    // rust: ("color", Tag::Short(14)),
    // rust: ]);
    // rust: mark_read(&mut bed);
    // rust: beds.push(bed);
}
}
}
}
    // rust: if beds.is_empty() {
    // rust: return;
}
    // rust: if !matches!(level.get("TileEntities"), Some(Tag::List(_))) {
    // rust: set(level, "TileEntities", Tag::List(Vec::new()));
}
    // rust: if let Some(Tag::List(entities)) = level.get_mut("TileEntities") {
    // rust: entities.extend(beds);
}
    // rust: });
}
