//! Transpiled from Horizon Rust crate
package horizon_world_fixes_a

import "core:fmt"
import "core:mem"
import "core:math"

// Fixes of 1.20.2 to 1.20.6 (keys 3564 to 3833).
// use super::dynamic::{
    // rust: as_double, as_float, as_int, as_number, as_str, as_string, empty_map, int_list, is_list,
    // rust: namespaced, remove, rename, rename_and_fix, set, stream, string,
}
// use super::json;
// use super::schema::{Key, Ty, key};
// use super::{Cx, FixFn, id_is, items, renamer, reread};
// use crate::nbt::Tag;

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(3564, 0), |cx| {
    // rust: drop_invalid_sign_data(cx, "minecraft:sign")
    // rust: }));
    // rust: out.push((key(3564, 1), |cx| {
    // rust: drop_invalid_sign_data(cx, "minecraft:hanging_sign")
    // rust: }));
    // rust: out.push((key(3565, 0), random_sequence_settings));
    // rust: out.push((key(3566, 0), scoreboard_display_slots));
    // rust: out.push((key(3568, 0), mob_effect_ids));
    // rust: out.push((key(3683, 0), primed_tnt_block_state));
    // rust: out.push((key(3685, 0), projectile_stored_item));
    // rust: out.push((key(3692, 0), |cx| {
    // rust: block_rename(cx, &[("minecraft:grass", "minecraft:short_grass")])
    // rust: }));
    // rust: out.push((key(3692, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[("minecraft:grass", "minecraft:short_grass")]),
    // rust: )
    // rust: }));
    // rust: out.push((key(3800, 0), |cx| {
    // rust: cx.rename(
    // rust: Ty::ItemName,
    // rust: renamer(&[("minecraft:scute", "minecraft:turtle_scute")]),
    // rust: )
    // rust: }));
    // rust: out.push((key(3803, 0), rename_sweeping));
    // rust: out.push((key(3807, 1), map_banner_block_pos));
    // rust: out.push((key(3808, 0), |cx| {
    // rust: horse_body_armor(cx, "minecraft:horse", "ArmorItem", true)
    // rust: }));
    // rust: out.push((key(3808, 1), |cx| {
    // rust: horse_body_armor(cx, "minecraft:llama", "DecorItem", false)
    // rust: }));
    // rust: out.push((key(3808, 2), |cx| {
    // rust: horse_body_armor(cx, "minecraft:trader_llama", "DecorItem", false)
    // rust: }));
    // rust: out.push((key(3809, 0), chested_horse_slots));
    // rust: out.push((key(3812, 0), wolf_health));
    // rust: out.push((key(3813, 0), block_pos_format));
    // rust: out.push((key(3814, 0), |cx| {
    // rust: attributes_rename_legacy(cx, &|id| {
    // rust: (namespaced(id) == "minecraft:horse.jump_strength")
    // rust: .then_some("minecraft:generic.jump_strength")
    // rust: })
    // rust: }));
    // rust: out.push((key(3818, 0), beehive_fields));
    // rust: out.push((key(3818, 0), empty_item_in_hotbar));
    // rust: out.push((key(3818, 1), banner_patterns));
    // rust: out.push((key(3818, 2), tipped_arrow_potion));
    // rust: out.push((key(3818, 4), particle_unflattening));
    // rust: out.push((key(3818, 5), |cx| {
    // rust: cx.each(Ty::ItemStack, items::componentize)
    // rust: }));
    // rust: out.push((key(3818, 6), area_effect_cloud_potion));
    // rust: out.push((key(3820, 0), player_head_profile));
    // rust: out.push((key(3820, 0), lodestone_compass_component));
    // rust: out.push((key(3825, 0), item_custom_name_to_item_name));
    // rust: out.push((key(3825, 0), banner_custom_name_to_item_name));
    // rust: out.push((key(3825, 0), trial_spawner_config));
    // rust: out.push((key(3828, 0), empty_item_in_villager_trade));
    // rust: out.push((key(3833, 0), remove_empty_brushable_item));
}

// ------------------------------------------------------------------ 3564

// `BlockEntitySignDoubleSidedEditableTextFix.FIELDS_TO_DROP`.
    // rust: pub(super) const SIGN_FIELDS_TO_DROP: [&str; 10] = [
    // rust: "Text1",
    // rust: "Text2",
    // rust: "Text3",
    // rust: "Text4",
    // rust: "FilteredText1",
    // rust: "FilteredText2",
    // rust: "FilteredText3",
    // rust: "FilteredText4",
    // rust: "Color",
    // rust: "GlowingText",
    // rust: ];

drop_invalid_sign_data :: proc(cx: ^Cx, id: string) {
}
    // rust: cx.block_entity(id, |be| {
    // rust: if super::dynamic::as_bool(be.get("_filtered_correct"), false) {
    // rust: remove(be, "_filtered_correct");
    // rust: return;
}
    // rust: for side in ["front_text", "back_text"] {
    // rust: if let Some(t) = be.get_mut(side) {
    // rust: fix_sign_text(t);
}
}
    // rust: for f in SIGN_FIELDS_TO_DROP {
    // rust: remove(be, f);
}
    // rust: });
}

fix_sign_text :: proc(t: ^Tag) {
}
    // rust: if !is_list(t.get("filtered_messages")) {
    // rust: return;
}
    // rust: let filtered = stream(t.get("filtered_messages"));
    // rust: let lines = stream(t.get("messages"));
    // rust: let empty = Tag::String(crate::nbt::JavaString(json::text_component_json(&[])));
    // rust: let new: Vec<Tag> = filtered
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, line)| {
    // rust: let fallback = lines.get(i).cloned().unwrap_or_else(|| empty.clone());
    // rust: if line == empty { fallback } else { line }
    // rust: })
    // rust: .collect();
    // rust: if new == lines {
    // rust: remove(t, "filtered_messages");
    // rust: } else {
    // rust: set(t, "filtered_messages", Tag::List(new));
}
}

// ------------------------------------------------------------------ 3565, 3566

random_sequence_settings :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedRandomSequences, |v| {
    // rust: if let Some(data) = remove(v, "data") {
    // rust: set(v, "data", Tag::compound([("sequences", data)]));
}
    // rust: });
}

    // rust: const SLOT_RENAMES: [(&str, &str); 19] = [
    // rust: ("slot_0", "list"),
    // rust: ("slot_1", "sidebar"),
    // rust: ("slot_2", "below_name"),
    // rust: ("slot_3", "sidebar.team.black"),
    // rust: ("slot_4", "sidebar.team.dark_blue"),
    // rust: ("slot_5", "sidebar.team.dark_green"),
    // rust: ("slot_6", "sidebar.team.dark_aqua"),
    // rust: ("slot_7", "sidebar.team.dark_red"),
    // rust: ("slot_8", "sidebar.team.dark_purple"),
    // rust: ("slot_9", "sidebar.team.gold"),
    // rust: ("slot_10", "sidebar.team.gray"),
    // rust: ("slot_11", "sidebar.team.dark_gray"),
    // rust: ("slot_12", "sidebar.team.blue"),
    // rust: ("slot_13", "sidebar.team.green"),
    // rust: ("slot_14", "sidebar.team.aqua"),
    // rust: ("slot_15", "sidebar.team.red"),
    // rust: ("slot_16", "sidebar.team.light_purple"),
    // rust: ("slot_17", "sidebar.team.yellow"),
    // rust: ("slot_18", "sidebar.team.white"),
    // rust: ];

scoreboard_display_slots :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedScoreboard, |v| {
    // rust: if let Some(data) = v.get_mut("data")
    // rust: && let Some(Tag::Compound(slots)) = data.get_mut("DisplaySlots")
    // rust: {
    // rust: let old = std::mem::take(slots);
    // rust: for (k, value) in old {
    // rust: let name = k.to_string_lossy();
    // rust: let k = SLOT_RENAMES
    // rust: .iter()
    // rust: .find(|(o, _)| *o == name)
    // rust: .map_or(k, |(_, n)| (*n).into());
    // rust: slots.insert(k, value);
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3568

    // rust: const EFFECT_IDS: [&str; 33] = [
    // rust: "minecraft:speed",
    // rust: "minecraft:slowness",
    // rust: "minecraft:haste",
    // rust: "minecraft:mining_fatigue",
    // rust: "minecraft:strength",
    // rust: "minecraft:instant_health",
    // rust: "minecraft:instant_damage",
    // rust: "minecraft:jump_boost",
    // rust: "minecraft:nausea",
    // rust: "minecraft:regeneration",
    // rust: "minecraft:resistance",
    // rust: "minecraft:fire_resistance",
    // rust: "minecraft:water_breathing",
    // rust: "minecraft:invisibility",
    // rust: "minecraft:blindness",
    // rust: "minecraft:night_vision",
    // rust: "minecraft:hunger",
    // rust: "minecraft:weakness",
    // rust: "minecraft:poison",
    // rust: "minecraft:wither",
    // rust: "minecraft:health_boost",
    // rust: "minecraft:absorption",
    // rust: "minecraft:saturation",
    // rust: "minecraft:glowing",
    // rust: "minecraft:levitation",
    // rust: "minecraft:luck",
    // rust: "minecraft:unluck",
    // rust: "minecraft:slow_falling",
    // rust: "minecraft:conduit_power",
    // rust: "minecraft:dolphins_grace",
    // rust: "minecraft:bad_omen",
    // rust: "minecraft:hero_of_the_village",
    // rust: "minecraft:darkness",
    // rust: ];

// `getAndConvertMobEffectId`.
effect_id :: proc(v: ^Tag, field: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = as_number(v.get(field)?)?.int_value();
    // rust: (1..=33)
    // rust: .contains(&n)
    // rust: .then(|| string(EFFECT_IDS[(n - 1) as usize]))
}
// `replaceField(old, new, value)`.
replace_field :: proc(v: ^Tag, old: string, new: string, value: Maybe(Tag)) {
}
    // rust: remove(v, old);
    // rust: if let Some(value) = value {
    // rust: set(v, new, value);
}
}
update_effect_id_field :: proc(input: ^Tag, old: string, output: ^Tag, new: string) {
}
    // rust: let mapped = effect_id(input, old);
    // rust: replace_field(output, old, new, mapped);
}
update_effect_instance :: proc(mut v: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let input = v.clone();
    // rust: update_effect_id_field(&input, "Id", &mut v, "id");
    // rust: rename(&mut v, "Ambient", "ambient");
    // rust: rename(&mut v, "Amplifier", "amplifier");
    // rust: rename(&mut v, "Duration", "duration");
    // rust: rename(&mut v, "ShowParticles", "show_particles");
    // rust: rename(&mut v, "ShowIcon", "show_icon");
    // rust: let hidden = v.get("HiddenEffect").cloned().map(update_effect_instance);
    // rust: replace_field(&mut v, "HiddenEffect", "hidden_effect", hidden);
    // rust: v
}
update_effect_list :: proc(v: ^Tag, old: string, new: string) {
}
    // rust: let value = is_list(v.get(old)).then(|| {
    // rust: Tag::List(
    // rust: stream(v.get(old))
    // rust: .into_iter()
    // rust: .map(update_effect_instance)
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: replace_field(v, old, new, value);
}
update_stew_entry :: proc(input: ^Tag, mut output: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: update_effect_id_field(input, "EffectId", &mut output, "id");
    // rust: let duration = input.get("EffectDuration").cloned();
    // rust: replace_field(&mut output, "EffectDuration", "duration", duration);
    // rust: output
}

mob_effect_ids :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:beacon", |be| {
    // rust: let input = be.clone();
    // rust: update_effect_id_field(&input, "Primary", be, "primary_effect");
    // rust: let input = be.clone();
    // rust: update_effect_id_field(&input, "Secondary", be, "secondary_effect");
    // rust: });
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if id_is(e, "minecraft:mooshroom") {
    // rust: let initial = empty_map();
    // rust: let entry = update_stew_entry(e, initial.clone());
    // rust: if entry != initial {
    // rust: set(e, "stew_effects", Tag::List(vec![entry]));
}
    // rust: remove(e, "EffectId");
    // rust: remove(e, "EffectDuration");
}
    // rust: if id_is(e, "minecraft:arrow") {
    // rust: update_effect_list(e, "CustomPotionEffects", "custom_potion_effects");
}
    // rust: if id_is(e, "minecraft:area_effect_cloud") {
    // rust: update_effect_list(e, "Effects", "effects");
}
    // rust: update_effect_list(e, "ActiveEffects", "active_effects");
    // rust: });
    // rust: cx.each(Ty::Player, |p| {
    // rust: update_effect_list(p, "ActiveEffects", "active_effects")
    // rust: });
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let Some(id) = as_str(s.get("id")).map(|i| namespaced(&i)) else {
    // rust: return;
}
    // rust: let Some(tag) = s.get_mut("tag") else {
    // rust: return;
}
    // rust: if id == "minecraft:suspicious_stew" {
    // rust: let value = is_list(tag.get("Effects")).then(|| {
    // rust: Tag::List(
    // rust: stream(tag.get("Effects"))
    // rust: .into_iter()
    // rust: .map(|e| update_stew_entry(&e.clone(), e))
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: replace_field(tag, "Effects", "effects", value);
    // rust: } else if matches!(
    // rust: id.as_str(),
    // rust: "minecraft:potion"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:tipped_arrow"
    // rust: ) {
    // rust: update_effect_list(tag, "CustomPotionEffects", "custom_potion_effects");
}
    // rust: });
}

// ------------------------------------------------------------------ 3683, 3685

primed_tnt_block_state :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.entity("minecraft:tnt", |e| {
    // rust: set(
    // rust: e,
    // rust: "block_state",
    // rust: Tag::compound([("Name", string("minecraft:tnt"))]),
    // rust: );
    // rust: if let Some(fuse) = e.get("Fuse").cloned() {
    // rust: set(e, "fuse", fuse);
}
    // rust: reread(k, e);
    // rust: });
}

projectile_stored_item :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.each(Ty::Entity, |e| {
    // rust: let item = if id_is(e, "minecraft:arrow") {
    // rust: let potion = as_string(e.get("Potion"), "minecraft:empty");
    // rust: if potion == "minecraft:empty" {
    // rust: "minecraft:arrow"
    // rust: } else {
    // rust: "minecraft:tipped_arrow"
}
    // rust: } else if id_is(e, "minecraft:spectral_arrow") {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
            // The trident's value is cast to the new type: its typed Trident field
            // is written as `item`, and the raw Trident comes back from the remainder.
    // rust: if id_is(e, "minecraft:trident") {
    // rust: rename(e, "Trident", "item");
    // rust: super::drop_typed(e, "Trident");
}
    // rust: return;
}
    // rust: let stack = Tag::compound([("id", string(item)), ("Count", Tag::Int(1))]);
    // rust: set(e, "item", stack);
        // The new stack is read with the output schema (V3685): its hook.
    // rust: if let Some(s) = e.get_mut("item") {
    // rust: items::add_names(s);
}
    // rust: reread(k, e);
    // rust: });
}

// ------------------------------------------------------------------ 3692 renames

// `LegacyBlockRenameFix`: block names, block states and flat block states.
    // rust: pub(super) fn block_rename(cx: &mut Cx, table: &[(&str, &'static str)]) {
    // rust: let r = renamer(table);
    // rust: cx.rename(Ty::BlockName, &r);
    // rust: cx.each(Ty::BlockState, |v| {
    // rust: if let Some(name) = as_str(v.get("Name"))
    // rust: && let Some(new) = r(&name)
    // rust: {
    // rust: set(v, "Name", string(new));
}
    // rust: });
    // rust: cx.each(Ty::FlatBlockState, |v| {
    // rust: if let Some(s) = as_str(Some(v)) {
    // rust: let props = s.find('[').filter(|&i| i > 0);
    // rust: let nbt = s.find('{').filter(|&i| i > 0);
    // rust: let end = match (props, nbt) {
    // rust: (Some(a), Some(b)) => a.min(b),
    // rust: (Some(a), None) => a,
    // rust: (None, Some(b)) => b,
    // rust: (None, None) => s.len(),
}
    // rust: let name = &s[..end];
    // rust: let new = r(name).map_or_else(|| name.to_owned(), str::to_owned);
    // rust: *v = string(&format!("{new}{}", &s[end..]));
}
    // rust: });
}

// ------------------------------------------------------------------ 3803

rename_sweeping :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let Some(tag) = s.get_mut("tag") else {
    // rust: return;
}
    // rust: for field in ["Enchantments", "StoredEnchantments"] {
    // rust: if let Some(list) = tag.get(field)
    // rust: && is_list(Some(list))
    // rust: {
    // rust: let fixed = stream(Some(list))
    // rust: .into_iter()
    // rust: .map(|mut e| {
    // rust: if let Some(id) = as_str(e.get("id")) {
    // rust: let new = if namespaced(&id) == "minecraft:sweeping" {
    // rust: "minecraft:sweeping_edge".into()
    // rust: } else {
    // rust: id
}
    // rust: set(&mut e, "id", string(&new));
}
    // rust: e
    // rust: })
    // rust: .collect();
    // rust: set(tag, field, Tag::List(fixed));
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3807.1

// `ExtraDataFixUtils.fixBlockPos`.
    // rust: pub(super) fn fix_block_pos(v: Tag) -> Tag {
    // rust: let (x, y, z) = (
    // rust: v.get("X").and_then(as_number),
    // rust: v.get("Y").and_then(as_number),
    // rust: v.get("Z").and_then(as_number),
    // rust: );
    // rust: match (x, y, z) {
    // rust: (Some(x), Some(y), Some(z)) => int_list(&[x.int_value(), y.int_value(), z.int_value()]),
    // rust: _ => v,
}
}
// `ExtraDataFixUtils.fixInlineBlockPos`.
    // rust: pub(super) fn fix_inline_block_pos(v: &mut Tag, fx: &str, fy: &str, fz: &str, new: &str) {
    // rust: let (x, y, z) = (
    // rust: v.get(fx).and_then(as_number),
    // rust: v.get(fy).and_then(as_number),
    // rust: v.get(fz).and_then(as_number),
    // rust: );
    // rust: if let (Some(x), Some(y), Some(z)) = (x, y, z) {
    // rust: remove(v, fx);
    // rust: remove(v, fy);
    // rust: remove(v, fz);
    // rust: set(
    // rust: v,
    // rust: new,
    // rust: int_list(&[x.int_value(), y.int_value(), z.int_value()]),
    // rust: );
}
}

map_banner_block_pos :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::SavedMapData, |v| {
    // rust: if let Some(d) = v.get_mut("data")
    // rust: && let Some(Tag::List(banners)) = d.get_mut("banners")
    // rust: {
    // rust: for b in banners {
    // rust: super::dynamic::update(b, "Pos", fix_block_pos);
}
}
    // rust: });
}

// ------------------------------------------------------------------ 3808, 3809, 3812

horse_body_armor :: proc(cx: ^Cx, id: string, field: string, clear_armor_items: bool) {
}
    // rust: let k = cx.k;
    // rust: cx.entity(id, |e| {
    // rust: horse_body_armor_entity(e, field, clear_armor_items);
    // rust: reread(k, e);
    // rust: });
}

horse_body_armor_entity :: proc(e: ^Tag, field: string, clear_armor_items: bool) {
}
    // rust: {
    // rust: let Some(armor) = e.get(field).cloned() else {
    // rust: return;
}
    // rust: remove(e, field);
    // rust: if clear_armor_items {
    // rust: super::dynamic::update(e, "ArmorItems", |list| {
    // rust: Tag::List(
    // rust: stream(Some(&list))
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, x)| if i == 2 { empty_map() } else { x })
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: super::dynamic::update(e, "ArmorDropChances", |list| {
    // rust: Tag::List(
    // rust: stream(Some(&list))
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, x)| {
    // rust: if i == 2 {
    // rust: Tag::Float(0.085f32.to_bits())
    // rust: } else {
    // rust: x
}
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
}
    // rust: set(e, "body_armor_item", armor);
    // rust: set(e, "body_armor_drop_chance", Tag::Float(2.0f32.to_bits()));
}
}

chested_horse_slots :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if ![
    // rust: "minecraft:llama",
    // rust: "minecraft:trader_llama",
    // rust: "minecraft:mule",
    // rust: "minecraft:donkey",
    // rust: ]
    // rust: .iter()
    // rust: .any(|id| id_is(e, id))
    // rust: {
    // rust: return;
}
    // rust: if let Some(Tag::List(items)) = e.get_mut("Items") {
    // rust: for item in items {
    // rust: if let Some(slot) = item.get("Slot") {
    // rust: let n = as_number(slot).map_or(2, |n| n.int_value());
    // rust: set(item, "Slot", Tag::Byte((n - 2) as i8));
}
}
}
    // rust: });
}

wolf_health :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:wolf", |e| {
    // rust: let mut adjusted = false;
    // rust: super::dynamic::update(e, "Attributes", |list| {
    // rust: Tag::List(
    // rust: stream(Some(&list))
    // rust: .into_iter()
    // rust: .map(|mut a| {
    // rust: if namespaced(&as_string(a.get("Name"), ""))
    // rust: == "minecraft:generic.max_health"
    // rust: {
    // rust: super::dynamic::update(&mut a, "Base", |base| {
    // rust: if as_double(Some(&base), 0.0) == 20.0 {
    // rust: adjusted = true;
    // rust: Tag::Double(40.0f64.to_bits())
    // rust: } else {
    // rust: base
}
    // rust: });
}
    // rust: a
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: if adjusted {
    // rust: super::dynamic::update(e, "Health", |h| {
    // rust: Tag::Float((as_float(Some(&h), 0.0) * 2.0).to_bits())
    // rust: });
}
    // rust: });
}

// ------------------------------------------------------------------ 3813

    // rust: const PATROLLING_MOBS: [&str; 6] = [
    // rust: "minecraft:witch",
    // rust: "minecraft:ravager",
    // rust: "minecraft:pillager",
    // rust: "minecraft:illusioner",
    // rust: "minecraft:evoker",
    // rust: "minecraft:vindicator",
    // rust: ];

rename_block_pos :: proc(v: ^Tag, fields: ^[(string) {
}
    // rust: for (old, new) in fields {
    // rust: rename_and_fix(v, old, new, |p| Some(fix_block_pos(p)));
}
}

block_pos_format :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Entity, |e| {
    // rust: if id_is(e, "minecraft:bee") {
    // rust: rename_block_pos(e, &[("HivePos", "hive_pos"), ("FlowerPos", "flower_pos")]);
}
    // rust: if id_is(e, "minecraft:end_crystal") {
    // rust: rename_block_pos(e, &[("BeamTarget", "beam_target")]);
}
    // rust: if id_is(e, "minecraft:wandering_trader") {
    // rust: rename_block_pos(e, &[("WanderTarget", "wander_target")]);
}
    // rust: if PATROLLING_MOBS.iter().any(|id| id_is(e, id)) {
    // rust: rename_block_pos(e, &[("PatrolTarget", "patrol_target")]);
}
    // rust: rename_block_pos(e, &[("Leash", "leash")]);
    // rust: });
    // rust: cx.block_entity("minecraft:beehive", |be| {
    // rust: rename_block_pos(be, &[("FlowerPos", "flower_pos")])
    // rust: });
    // rust: cx.block_entity("minecraft:end_gateway", |be| {
    // rust: rename_block_pos(be, &[("ExitPortal", "exit_portal")])
    // rust: });
    // rust: cx.each(Ty::SavedMapData, |v| {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: super::dynamic::update(d, "frames", |frames| {
    // rust: Tag::List(
    // rust: stream(Some(&frames))
    // rust: .into_iter()
    // rust: .map(|mut f| {
    // rust: rename_and_fix(&mut f, "Pos", "pos", |p| Some(fix_block_pos(p)));
    // rust: rename(&mut f, "Rotation", "rotation");
    // rust: rename(&mut f, "EntityId", "entity_id");
    // rust: f
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: super::dynamic::update(d, "banners", |banners| {
    // rust: Tag::List(
    // rust: stream(Some(&banners))
    // rust: .into_iter()
    // rust: .map(|mut b| {
    // rust: rename(&mut b, "Pos", "pos");
    // rust: rename(&mut b, "Color", "color");
    // rust: rename(&mut b, "Name", "name");
    // rust: b
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: });
}
    // rust: });
    // rust: cx.item(
    // rust: |id| id == "minecraft:compass",
    // rust: |s| {
    // rust: if let Some(tag) = s.get_mut("tag") {
    // rust: super::dynamic::update(tag, "LodestonePos", fix_block_pos);
}
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 3814

    // rust: pub(super) fn attributes_rename_legacy(
    // rust: cx: &mut Cx,
    // rust: rename_fn: &dyn Fn(&str) -> Option<&'static str>,
    // rust: ) {
    // rust: let fix_name = |v: &mut Tag, field: &str| {
    // rust: if let Some(name) = as_str(v.get(field))
    // rust: && let Some(new) = rename_fn(&name)
    // rust: {
    // rust: set(v, field, string(new));
}
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: if let Some(tag) = s.get_mut("tag")
    // rust: && let Some(Tag::List(mods)) = tag.get_mut("AttributeModifiers")
    // rust: {
    // rust: for m in mods {
    // rust: fix_name(m, "AttributeName");
}
}
    // rust: });
    // rust: let fix_entity = |e: &mut Tag| {
    // rust: if let Some(Tag::List(attrs)) = e.get_mut("Attributes") {
    // rust: for a in attrs {
    // rust: fix_name(a, "Name");
}
}
}
    // rust: cx.each(Ty::Entity, fix_entity);
    // rust: cx.each(Ty::Player, fix_entity);
}

// ------------------------------------------------------------------ 3818

beehive_fields :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:beehive", |be| {
        // The typed Bees list moves to `bees` (the schema renames it); the
        // remainder loses Bees, each bee loses EntityData's old name.
    // rust: if let Some(Tag::List(bees)) = remove(be, "Bees") {
    // rust: let bees = bees
    // rust: .into_iter()
    // rust: .map(|mut bee| {
    // rust: let data = remove(&mut bee, "EntityData");
    // rust: rename(&mut bee, "TicksInHive", "ticks_in_hive");
    // rust: rename(&mut bee, "MinOccupationTicks", "min_ticks_in_hive");
    // rust: if let Some(data) = data {
    // rust: set(&mut bee, "entity_data", data);
}
    // rust: bee
    // rust: })
    // rust: .collect();
    // rust: set(be, "bees", Tag::List(bees));
}
    // rust: });
}

// `EmptyItemInHotbarFix`: a saved toolbar's air or zero-count stacks become
// the empty compound.
empty_item_in_hotbar :: proc(cx: ^Cx) {
}
    // rust: if !matches!(cx.root, Ty::Hotbar) {
    // rust: return;
}
    // rust: cx.each(Ty::ItemStack, |stack| {
    // rust: let air = as_str(stack.get("id")).is_none_or(|id| id == "minecraft:air");
    // rust: let empty = as_int(stack.get("Count"), 0) <= 0;
    // rust: if air || empty {
    // rust: *stack = empty_map();
}
    // rust: });
}

    // rust: const PATTERN_IDS: [(&str, &str); 41] = [
    // rust: ("b", "minecraft:base"),
    // rust: ("bl", "minecraft:square_bottom_left"),
    // rust: ("br", "minecraft:square_bottom_right"),
    // rust: ("tl", "minecraft:square_top_left"),
    // rust: ("tr", "minecraft:square_top_right"),
    // rust: ("bs", "minecraft:stripe_bottom"),
    // rust: ("ts", "minecraft:stripe_top"),
    // rust: ("ls", "minecraft:stripe_left"),
    // rust: ("rs", "minecraft:stripe_right"),
    // rust: ("cs", "minecraft:stripe_center"),
    // rust: ("ms", "minecraft:stripe_middle"),
    // rust: ("drs", "minecraft:stripe_downright"),
    // rust: ("dls", "minecraft:stripe_downleft"),
    // rust: ("ss", "minecraft:small_stripes"),
    // rust: ("cr", "minecraft:cross"),
    // rust: ("sc", "minecraft:straight_cross"),
    // rust: ("bt", "minecraft:triangle_bottom"),
    // rust: ("tt", "minecraft:triangle_top"),
    // rust: ("bts", "minecraft:triangles_bottom"),
    // rust: ("tts", "minecraft:triangles_top"),
    // rust: ("ld", "minecraft:diagonal_left"),
    // rust: ("rd", "minecraft:diagonal_up_right"),
    // rust: ("lud", "minecraft:diagonal_up_left"),
    // rust: ("rud", "minecraft:diagonal_right"),
    // rust: ("mc", "minecraft:circle"),
    // rust: ("mr", "minecraft:rhombus"),
    // rust: ("vh", "minecraft:half_vertical"),
    // rust: ("hh", "minecraft:half_horizontal"),
    // rust: ("vhr", "minecraft:half_vertical_right"),
    // rust: ("hhb", "minecraft:half_horizontal_bottom"),
    // rust: ("bo", "minecraft:border"),
    // rust: ("cbo", "minecraft:curly_border"),
    // rust: ("gra", "minecraft:gradient"),
    // rust: ("gru", "minecraft:gradient_up"),
    // rust: ("bri", "minecraft:bricks"),
    // rust: ("glb", "minecraft:globe"),
    // rust: ("cre", "minecraft:creeper"),
    // rust: ("sku", "minecraft:skull"),
    // rust: ("flo", "minecraft:flower"),
    // rust: ("moj", "minecraft:mojang"),
    // rust: ("pig", "minecraft:piglin"),
    // rust: ];

// `ExtraDataFixUtils.dyeColorIdToName`.
    // rust: pub(super) fn dye_color(id: i32) -> &'static str {
    // rust: match id {
    // rust: 1 => "orange",
    // rust: 2 => "magenta",
    // rust: 3 => "light_blue",
    // rust: 4 => "yellow",
    // rust: 5 => "lime",
    // rust: 6 => "pink",
    // rust: 7 => "gray",
    // rust: 8 => "light_gray",
    // rust: 9 => "cyan",
    // rust: 10 => "purple",
    // rust: 11 => "blue",
    // rust: 12 => "brown",
    // rust: 13 => "green",
    // rust: 14 => "red",
    // rust: 15 => "black",
    // rust: _ => "white",
}
}

    // rust: pub(super) fn banner_layer(mut v: Tag) -> Tag {
    // rust: rename_and_fix(&mut v, "Pattern", "pattern", |p| {
    // rust: Some(match as_str(Some(&p)) {
    // rust: Some(id) => string(
    // rust: PATTERN_IDS
    // rust: .iter()
    // rust: .find(|(k, _)| *k == id)
    // rust: .map_or(id.as_str(), |(_, n)| n),
    // rust: ),
    // rust: None => p,
    // rust: })
    // rust: });
    // rust: let color = dye_color(as_int(v.get("Color"), 0));
    // rust: set(&mut v, "color", string(color));
    // rust: remove(&mut v, "Color");
    // rust: v
}

banner_patterns :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:banner", |be| {
    // rust: rename_and_fix(be, "Patterns", "patterns", |p| {
    // rust: Some(Tag::List(
    // rust: stream(Some(&p)).into_iter().map(banner_layer).collect(),
    // rust: ))
    // rust: });
    // rust: });
}

tipped_arrow_potion :: proc(cx: ^Cx) {
}
    // rust: let k = cx.k;
    // rust: cx.entity("minecraft:arrow", |e| {
    // rust: tipped_arrow_potion_entity(e);
    // rust: reread(k, e);
    // rust: });
}

tipped_arrow_potion_entity :: proc(e: ^Tag) {
}
    // rust: {
    // rust: let potion = e.get("Potion").cloned();
    // rust: let effects = e.get("custom_potion_effects").cloned();
    // rust: let color = e.get("Color").cloned();
    // rust: if potion.is_none() && effects.is_none() && color.is_none() {
    // rust: return;
}
    // rust: remove(e, "Potion");
    // rust: remove(e, "custom_potion_effects");
    // rust: remove(e, "Color");
    // rust: super::dynamic::update(e, "item", |mut stack| {
    // rust: let mut tag = super::dynamic::or_empty_map(stack.get("tag"));
    // rust: if let Some(p) = potion {
    // rust: set(&mut tag, "Potion", p);
}
    // rust: if let Some(c) = effects {
    // rust: set(&mut tag, "custom_potion_effects", c);
}
    // rust: if let Some(c) = color {
    // rust: set(&mut tag, "CustomPotionColor", c);
}
    // rust: set(&mut stack, "tag", tag);
    // rust: stack
    // rust: });
}
}

particle_unflattening :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::Particle, |p| {
    // rust: if let Some(s) = as_str(Some(p)) {
    // rust: *p = items::unflatten_particle(&s);
}
    // rust: });
}

area_effect_cloud_potion :: proc(cx: ^Cx) {
}
    // rust: cx.entity("minecraft:area_effect_cloud", |e| {
    // rust: let color = remove(e, "Color");
    // rust: let effects = remove(e, "effects");
    // rust: let potion = remove(e, "Potion");
    // rust: if color.is_none() && effects.is_none() && potion.is_none() {
    // rust: return;
}
    // rust: let mut contents = empty_map();
    // rust: if let Some(c) = color {
    // rust: set(&mut contents, "custom_color", c);
}
    // rust: if let Some(c) = effects {
    // rust: set(&mut contents, "custom_effects", c);
}
    // rust: if let Some(p) = potion {
    // rust: set(&mut contents, "potion", p);
}
    // rust: set(e, "potion_contents", contents);
    // rust: });
}

// ------------------------------------------------------------------ 3820

player_head_profile :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:skull", |be| {
    // rust: let profile = be
    // rust: .get("SkullOwner")
    // rust: .or_else(|| be.get("ExtraType"))
    // rust: .cloned();
    // rust: let Some(profile) = profile else {
    // rust: return;
}
    // rust: remove(be, "SkullOwner");
    // rust: remove(be, "ExtraType");
    // rust: set(be, "profile", items::fix_profile(&profile));
    // rust: });
}

// `DataComponentRemainderFix`: one component of every component map.
    // rust: pub(super) fn component_fix(cx: &mut Cx, id: &str, new_id: &str, f: impl Fn(Tag) -> Option<Tag>) {
    // rust: cx.each(Ty::DataComponents, |c| {
    // rust: if let Some(component) = remove(c, id)
    // rust: && let Some(new) = f(component)
    // rust: {
    // rust: set(c, new_id, new);
}
    // rust: });
}

lodestone_compass_component :: proc(cx: ^Cx) {
}
    // rust: component_fix(
    // rust: cx,
    // rust: "minecraft:lodestone_target",
    // rust: "minecraft:lodestone_tracker",
    // rust: |mut v| {
    // rust: let pos = remove(&mut v, "pos");
    // rust: let dimension = remove(&mut v, "dimension");
    // rust: if let (Some(pos), Some(dimension)) = (pos, dimension) {
    // rust: set(
    // rust: &mut v,
    // rust: "target",
    // rust: Tag::compound([("pos", pos), ("dimension", dimension)]),
    // rust: );
}
    // rust: Some(v)
    // rust: },
    // rust: );
}

// ------------------------------------------------------------------ 3825

    // rust: const MAP_NAMES: [&str; 11] = [
    // rust: "filled_map.buried_treasure",
    // rust: "filled_map.explorer_jungle",
    // rust: "filled_map.explorer_swamp",
    // rust: "filled_map.mansion",
    // rust: "filled_map.monument",
    // rust: "filled_map.trial_chambers",
    // rust: "filled_map.village_desert",
    // rust: "filled_map.village_plains",
    // rust: "filled_map.village_savanna",
    // rust: "filled_map.village_snowy",
    // rust: "filled_map.village_taiga",
    // rust: ];

// `LegacyComponentDataFixUtils.extractTranslationString`.
    // rust: pub(super) fn translation_key(component: &Tag) -> Option<String> {
    // rust: let Tag::String(s) = component else {
    // rust: return None;
}
    // rust: match json::parse_lenient(&s.0)? {
    // rust: j @ json::Json::Obj(_) => match j.get("translate")? {
    // rust: json::Json::Str(k) => Some(String::from_utf16_lossy(k)),
    // rust: json::Json::Num(n) => Some(n.clone()),
    // rust: json::Json::Bool(b) => Some(b.to_string()),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
}

item_custom_name_to_item_name :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::ItemStack, |s| {
    // rust: let id = namespaced(&as_str(s.get("id")).unwrap_or_default());
    // rust: let expected: &dyn Fn(&str) -> bool = match id.as_str() {
    // rust: "minecraft:white_banner" => &|k: &str| k == "block.minecraft.ominous_banner",
    // rust: "minecraft:filled_map" => &|k: &str| MAP_NAMES.contains(&k),
    // rust: _ => return,
}
    // rust: if let Some(c) = s.get_mut("components")
    // rust: && c.get("minecraft:custom_name")
    // rust: .and_then(translation_key)
    // rust: .is_some_and(|k| expected(&k))
    // rust: {
    // rust: rename(c, "minecraft:custom_name", "minecraft:item_name");
}
    // rust: });
}

banner_custom_name_to_item_name :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:banner", |be| {
    // rust: let Some(name) = be.get("CustomName").cloned() else {
    // rust: return;
}
    // rust: if translation_key(&name).as_deref() != Some("block.minecraft.ominous_banner") {
    // rust: return;
}
    // rust: set(
    // rust: be,
    // rust: "components",
    // rust: Tag::compound([
    // rust: ("minecraft:item_name", name),
    // rust: ("minecraft:hide_additional_tooltip", empty_map()),
    // rust: ]),
    // rust: );
    // rust: remove(be, "CustomName");
    // rust: });
}

trial_spawner_config :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:trial_spawner", |be| {
    // rust: let mut config = empty_map();
    // rust: let mut moved = false;
    // rust: for k in [
    // rust: "spawn_range",
    // rust: "total_mobs",
    // rust: "simultaneous_mobs",
    // rust: "total_mobs_added_per_player",
    // rust: "simultaneous_mobs_added_per_player",
    // rust: "ticks_between_spawn",
    // rust: "spawn_potentials",
    // rust: "loot_tables_to_eject",
    // rust: "items_to_drop_when_ominous",
    // rust: ] {
    // rust: if let Some(v) = remove(be, k) {
    // rust: set(&mut config, k, v);
    // rust: moved = true;
}
}
    // rust: if moved {
    // rust: set(be, "normal_config", config);
}
    // rust: });
}

// ------------------------------------------------------------------ 3828, 3833

empty_item_in_villager_trade :: proc(cx: ^Cx) {
}
    // rust: cx.each(Ty::VillagerTrade, |t| {
    // rust: let buy_b = super::dynamic::or_empty_map(t.get("buyB"));
    // rust: let id = namespaced(&as_string(buy_b.get("id"), "minecraft:air"));
    // rust: let count = as_int(buy_b.get("count"), 0);
    // rust: if id == "minecraft:air" || count == 0 {
    // rust: remove(t, "buyB");
}
    // rust: });
}

remove_empty_brushable_item :: proc(cx: ^Cx) {
}
    // rust: cx.block_entity("minecraft:brushable_block", |be| {
    // rust: if let Some(item) = be.get("item") {
    // rust: let id = namespaced(&as_string(item.get("id"), "minecraft:air"));
    // rust: if id == "minecraft:air" || as_int(item.get("count"), 0) == 0 {
    // rust: remove(be, "item");
}
}
    // rust: });
}

// ------------------------------------------------------------------ scoreboard objective hooks

// `V1451_6.UNPACK_OBJECTIVE_ID`.
    // rust: pub(super) fn unpack_objective(v: &mut Tag) {
    // rust: let Some(name) = as_str(v.get("CriteriaName")) else {
    // rust: return;
}
    // rust: let (ty, id) = match name.find(':') {
    // rust: None => ("_special".to_owned(), name.clone()),
    // rust: Some(colon) => match (
    // rust: by_separator(&name[..colon]),
    // rust: by_separator(&name[colon + 1..]),
    // rust: ) {
    // rust: (Some(t), Some(i)) => (t, i),
    // rust: _ => ("_special".to_owned(), name.clone()),
    // rust: },
}
    // rust: set(
    // rust: v,
    // rust: "CriteriaType",
    // rust: Tag::compound([("type", string(&ty)), ("id", string(&id))]),
    // rust: );
}

// `Identifier.bySeparator(s, '.')`: namespace before the first dot.
by_separator :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = match s.find('.') {
    // rust: Some(i) => (&s[..i], &s[i + 1..]),
    // rust: None => ("minecraft", s),
}
    // rust: let ns = if ns.is_empty() { "minecraft" } else { ns };
    // rust: super::identifier(&format!("{ns}:{path}")).map(|(n, p)| format!("{n}:{p}"))
}

// `V1451_6.REPACK_OBJECTIVE_ID`.
    // rust: pub(super) fn repack_objective(v: &mut Tag) {
    // rust: let Some(ct) = v.get("CriteriaType") else {
    // rust: return;
}
    // rust: let (Some(ty), Some(id)) = (as_str(ct.get("type")), as_str(ct.get("id"))) else {
    // rust: return;
}
    // rust: let name = if ty == "_special" {
    // rust: id
    // rust: } else {
    // rust: format!("{}:{}", pack_with_dot(&ty), pack_with_dot(&id))
}
    // rust: set(v, "CriteriaName", string(&name));
    // rust: remove(v, "CriteriaType");
}
pack_with_dot :: proc(location: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match super::identifier(location) {
    // rust: Some((ns, path)) => format!("{ns}.{path}"),
    // rust: None => location.to_owned(),
}
}
