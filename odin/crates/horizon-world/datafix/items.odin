//! Transpiled from Horizon Rust crate
package horizon_world_items

import "core:fmt"
import "core:mem"
import "core:math"

// Item stacks: the V705 read hook (`ADD_NAMES`), `ItemStackComponentizationFix`
// (1.20.5) and `ParticleUnflatteningFix`.
// use super::dynamic::{
    // rust: as_bool, as_bool_opt, as_double, as_int, as_long, as_number, as_str, as_string, empty_map,
    // rust: int_list, is_empty_map, namespaced, remove, rename, set, stream, string,
}
// use super::json;
// use crate::nbt::{JavaString, Tag};

// `V704.ITEM_TO_BLOCKENTITY`.
    // rust: const ITEM_TO_BLOCK_ENTITY: &[(&str, &str)] = &[
    // rust: ("minecraft:furnace", "minecraft:furnace"),
    // rust: ("minecraft:lit_furnace", "minecraft:furnace"),
    // rust: ("minecraft:chest", "minecraft:chest"),
    // rust: ("minecraft:trapped_chest", "minecraft:chest"),
    // rust: ("minecraft:ender_chest", "minecraft:ender_chest"),
    // rust: ("minecraft:jukebox", "minecraft:jukebox"),
    // rust: ("minecraft:dispenser", "minecraft:dispenser"),
    // rust: ("minecraft:dropper", "minecraft:dropper"),
    // rust: ("minecraft:sign", "minecraft:sign"),
    // rust: ("minecraft:mob_spawner", "minecraft:mob_spawner"),
    // rust: ("minecraft:spawner", "minecraft:mob_spawner"),
    // rust: ("minecraft:noteblock", "minecraft:noteblock"),
    // rust: ("minecraft:brewing_stand", "minecraft:brewing_stand"),
    // rust: ("minecraft:enhanting_table", "minecraft:enchanting_table"),
    // rust: ("minecraft:command_block", "minecraft:command_block"),
    // rust: ("minecraft:beacon", "minecraft:beacon"),
    // rust: ("minecraft:skull", "minecraft:skull"),
    // rust: ("minecraft:daylight_detector", "minecraft:daylight_detector"),
    // rust: ("minecraft:hopper", "minecraft:hopper"),
    // rust: ("minecraft:banner", "minecraft:banner"),
    // rust: ("minecraft:flower_pot", "minecraft:flower_pot"),
    // rust: (
    // rust: "minecraft:repeating_command_block",
    // rust: "minecraft:command_block",
    // rust: ),
    // rust: ("minecraft:chain_command_block", "minecraft:command_block"),
    // rust: ("minecraft:shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:white_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:orange_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:magenta_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:light_blue_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:yellow_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:lime_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:pink_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:gray_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:silver_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:cyan_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:purple_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:blue_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:brown_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:green_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:red_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:black_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:bed", "minecraft:bed"),
    // rust: ("minecraft:light_gray_shulker_box", "minecraft:shulker_box"),
    // rust: ("minecraft:white_banner", "minecraft:banner"),
    // rust: ("minecraft:orange_banner", "minecraft:banner"),
    // rust: ("minecraft:magenta_banner", "minecraft:banner"),
    // rust: ("minecraft:light_blue_banner", "minecraft:banner"),
    // rust: ("minecraft:yellow_banner", "minecraft:banner"),
    // rust: ("minecraft:lime_banner", "minecraft:banner"),
    // rust: ("minecraft:pink_banner", "minecraft:banner"),
    // rust: ("minecraft:gray_banner", "minecraft:banner"),
    // rust: ("minecraft:silver_banner", "minecraft:banner"),
    // rust: ("minecraft:light_gray_banner", "minecraft:banner"),
    // rust: ("minecraft:cyan_banner", "minecraft:banner"),
    // rust: ("minecraft:purple_banner", "minecraft:banner"),
    // rust: ("minecraft:blue_banner", "minecraft:banner"),
    // rust: ("minecraft:brown_banner", "minecraft:banner"),
    // rust: ("minecraft:green_banner", "minecraft:banner"),
    // rust: ("minecraft:red_banner", "minecraft:banner"),
    // rust: ("minecraft:black_banner", "minecraft:banner"),
    // rust: ("minecraft:standing_sign", "minecraft:sign"),
    // rust: ("minecraft:wall_sign", "minecraft:sign"),
    // rust: ("minecraft:piston_head", "minecraft:piston"),
    // rust: (
    // rust: "minecraft:daylight_detector_inverted",
    // rust: "minecraft:daylight_detector",
    // rust: ),
    // rust: ("minecraft:unpowered_comparator", "minecraft:comparator"),
    // rust: ("minecraft:powered_comparator", "minecraft:comparator"),
    // rust: ("minecraft:wall_banner", "minecraft:banner"),
    // rust: ("minecraft:standing_banner", "minecraft:banner"),
    // rust: ("minecraft:structure_block", "minecraft:structure_block"),
    // rust: ("minecraft:end_portal", "minecraft:end_portal"),
    // rust: ("minecraft:end_gateway", "minecraft:end_gateway"),
    // rust: ("minecraft:shield", "minecraft:banner"),
    // rust: ("minecraft:white_bed", "minecraft:bed"),
    // rust: ("minecraft:orange_bed", "minecraft:bed"),
    // rust: ("minecraft:magenta_bed", "minecraft:bed"),
    // rust: ("minecraft:light_blue_bed", "minecraft:bed"),
    // rust: ("minecraft:yellow_bed", "minecraft:bed"),
    // rust: ("minecraft:lime_bed", "minecraft:bed"),
    // rust: ("minecraft:pink_bed", "minecraft:bed"),
    // rust: ("minecraft:gray_bed", "minecraft:bed"),
    // rust: ("minecraft:silver_bed", "minecraft:bed"),
    // rust: ("minecraft:light_gray_bed", "minecraft:bed"),
    // rust: ("minecraft:cyan_bed", "minecraft:bed"),
    // rust: ("minecraft:purple_bed", "minecraft:bed"),
    // rust: ("minecraft:blue_bed", "minecraft:bed"),
    // rust: ("minecraft:brown_bed", "minecraft:bed"),
    // rust: ("minecraft:green_bed", "minecraft:bed"),
    // rust: ("minecraft:red_bed", "minecraft:bed"),
    // rust: ("minecraft:black_bed", "minecraft:bed"),
    // rust: ("minecraft:oak_sign", "minecraft:sign"),
    // rust: ("minecraft:spruce_sign", "minecraft:sign"),
    // rust: ("minecraft:birch_sign", "minecraft:sign"),
    // rust: ("minecraft:jungle_sign", "minecraft:sign"),
    // rust: ("minecraft:acacia_sign", "minecraft:sign"),
    // rust: ("minecraft:dark_oak_sign", "minecraft:sign"),
    // rust: ("minecraft:crimson_sign", "minecraft:sign"),
    // rust: ("minecraft:warped_sign", "minecraft:sign"),
    // rust: ("minecraft:skeleton_skull", "minecraft:skull"),
    // rust: ("minecraft:wither_skeleton_skull", "minecraft:skull"),
    // rust: ("minecraft:zombie_head", "minecraft:skull"),
    // rust: ("minecraft:player_head", "minecraft:skull"),
    // rust: ("minecraft:creeper_head", "minecraft:skull"),
    // rust: ("minecraft:dragon_head", "minecraft:skull"),
    // rust: ("minecraft:barrel", "minecraft:barrel"),
    // rust: ("minecraft:conduit", "minecraft:conduit"),
    // rust: ("minecraft:smoker", "minecraft:smoker"),
    // rust: ("minecraft:blast_furnace", "minecraft:blast_furnace"),
    // rust: ("minecraft:lectern", "minecraft:lectern"),
    // rust: ("minecraft:bell", "minecraft:bell"),
    // rust: ("minecraft:jigsaw", "minecraft:jigsaw"),
    // rust: ("minecraft:campfire", "minecraft:campfire"),
    // rust: ("minecraft:bee_nest", "minecraft:beehive"),
    // rust: ("minecraft:beehive", "minecraft:beehive"),
    // rust: ("minecraft:sculk_sensor", "minecraft:sculk_sensor"),
    // rust: ("minecraft:decorated_pot", "minecraft:decorated_pot"),
    // rust: ("minecraft:crafter", "minecraft:crafter"),
    // rust: ];

// `V705.ITEM_TO_ENTITY`: spawn eggs and the items that place an entity.
item_to_entity :: proc(item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(mob) = item
    // rust: .strip_suffix("_spawn_egg")
    // rust: .and_then(|m| m.strip_prefix("minecraft:"))
    // rust: && SPAWN_EGG_MOBS.contains(&mob)
    // rust: {
    // rust: return Some(format!("minecraft:{mob}"));
}
    // rust: match item {
    // rust: "minecraft:armor_stand"
    // rust: | "minecraft:painting"
    // rust: | "minecraft:item_frame"
    // rust: | "minecraft:minecart"
    // rust: | "minecraft:chest_minecart"
    // rust: | "minecraft:furnace_minecart"
    // rust: | "minecraft:tnt_minecart"
    // rust: | "minecraft:hopper_minecart"
    // rust: | "minecraft:bamboo_raft"
    // rust: | "minecraft:bamboo_chest_raft" => Some(item.to_owned()),
    // rust: "minecraft:boat" => Some("minecraft:oak_boat".into()),
    // rust: _ => {
    // rust: let wood = item.strip_prefix("minecraft:")?;
    // rust: let wood = wood
    // rust: .strip_suffix("_chest_boat")
    // rust: .or_else(|| wood.strip_suffix("_boat"))?;
    // rust: BOAT_WOODS.contains(&wood).then(|| item.to_owned())
}
}
}
    // rust: const BOAT_WOODS: [&str; 8] = [
    // rust: "oak", "spruce", "birch", "jungle", "acacia", "cherry", "dark_oak", "mangrove",
    // rust: ];
    // rust: const SPAWN_EGG_MOBS: &[&str] = &[
    // rust: "armadillo",
    // rust: "allay",
    // rust: "axolotl",
    // rust: "bat",
    // rust: "bee",
    // rust: "blaze",
    // rust: "bogged",
    // rust: "breeze",
    // rust: "cat",
    // rust: "camel",
    // rust: "cave_spider",
    // rust: "chicken",
    // rust: "cod",
    // rust: "cow",
    // rust: "creeper",
    // rust: "dolphin",
    // rust: "donkey",
    // rust: "drowned",
    // rust: "elder_guardian",
    // rust: "ender_dragon",
    // rust: "enderman",
    // rust: "endermite",
    // rust: "evoker",
    // rust: "fox",
    // rust: "frog",
    // rust: "ghast",
    // rust: "glow_squid",
    // rust: "goat",
    // rust: "guardian",
    // rust: "hoglin",
    // rust: "horse",
    // rust: "husk",
    // rust: "iron_golem",
    // rust: "llama",
    // rust: "magma_cube",
    // rust: "mooshroom",
    // rust: "mule",
    // rust: "ocelot",
    // rust: "panda",
    // rust: "parrot",
    // rust: "phantom",
    // rust: "pig",
    // rust: "piglin",
    // rust: "piglin_brute",
    // rust: "pillager",
    // rust: "polar_bear",
    // rust: "pufferfish",
    // rust: "rabbit",
    // rust: "ravager",
    // rust: "salmon",
    // rust: "sheep",
    // rust: "shulker",
    // rust: "silverfish",
    // rust: "skeleton",
    // rust: "skeleton_horse",
    // rust: "slime",
    // rust: "sniffer",
    // rust: "snow_golem",
    // rust: "spider",
    // rust: "squid",
    // rust: "stray",
    // rust: "strider",
    // rust: "tadpole",
    // rust: "trader_llama",
    // rust: "tropical_fish",
    // rust: "turtle",
    // rust: "vex",
    // rust: "villager",
    // rust: "vindicator",
    // rust: "wandering_trader",
    // rust: "warden",
    // rust: "witch",
    // rust: "wither",
    // rust: "wither_skeleton",
    // rust: "wolf",
    // rust: "zoglin",
    // rust: "zombie",
    // rust: "zombie_horse",
    // rust: "zombie_villager",
    // rust: "zombified_piglin",
    // rust: ];

// The read hook of item stacks in the schema at `k` (before 1.20.5): V99's tables below V704,
// V704's block entities with V99's entities up to V705, V705's from then on.
    // rust: pub(super) fn add_names_at(stack: &mut Tag, k: super::schema::Key) {
//     use super::schema::key;
    // rust: if k >= key(705, 0) {
    // rust: return add_names(stack);
}
    // rust: let item = namespaced(&as_str(stack.get("id")).unwrap_or_else(|| "minecraft:air".into()));
    // rust: let Some(tag) = stack.get_mut("tag") else {
    // rust: return;
}
    // rust: if let Some(be) = tag.get_mut("BlockEntityTag")
    // rust: && item != "minecraft:air"
    // rust: {
    // rust: let found = if k >= key(704, 0) {
    // rust: ITEM_TO_BLOCK_ENTITY.iter().find(|(i, _)| *i == item)
    // rust: } else {
    // rust: super::flat_tables::ITEM_TO_BLOCK_ENTITY_V99
    // rust: .iter()
    // rust: .find(|(i, _)| *i == item)
}
    // rust: if let Some((_, id)) = found {
    // rust: set(be, "id", string(id));
}
}
    // rust: if let Some(e) = tag.get_mut("EntityTag")
    // rust: && e.get("id").is_none()
    // rust: {
    // rust: let id = match item.as_str() {
    // rust: "minecraft:armor_stand" => Some("ArmorStand"),
    // rust: "minecraft:painting" => Some("Painting"),
    // rust: _ => None,
}
    // rust: if let Some(id) = id {
    // rust: set(e, "id", string(id));
}
}
}

// `V99.addNames` with V704/V705's tables: the read hook of item stacks before 1.20.5.
    // rust: pub(super) fn add_names(stack: &mut Tag) {
    // rust: let item = namespaced(&as_str(stack.get("id")).unwrap_or_else(|| "minecraft:air".into()));
    // rust: let Some(tag) = stack.get_mut("tag") else {
    // rust: return;
}
    // rust: if let Some(be) = tag.get_mut("BlockEntityTag")
    // rust: && item != "minecraft:air"
    // rust: && let Some((_, id)) = ITEM_TO_BLOCK_ENTITY.iter().find(|(i, _)| *i == item)
    // rust: {
    // rust: set(be, "id", string(id));
}
    // rust: if let Some(e) = tag.get_mut("EntityTag")
    // rust: && e.get("id").is_none()
    // rust: && let Some(id) = item_to_entity(&item)
    // rust: {
    // rust: set(e, "id", string(&id));
}
}

// `ItemStackComponentizationFix.ItemStackData`.
Stack :: struct {
    item: string,
    count: i32,
    components: Tag,
    remainder: Tag,
    tag: Tag,
}

    // rust: impl Stack {
read :: proc(v: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let item = as_str(v.get("id"))?;
    // rust: let count = as_number(v.get("Count")?)?.int_value();
    // rust: let mut remainder = v.clone();
    // rust: remove(&mut remainder, "id");
    // rust: remove(&mut remainder, "Count");
    // rust: let tag = super::dynamic::or_empty_map(remainder.get("tag"));
    // rust: remove(&mut remainder, "tag");
    // rust: Some(Self {
    // rust: item: namespaced(&item),
    // rust: count,
    // rust: components: empty_map(),
    // rust: remainder,
    // rust: tag,
    // rust: })
}
remove_tag :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: remove(&mut self.tag, key)
}
set_component :: proc(self: ^Self, ty: string, value: Tag) {
}
    // rust: set(&mut self.components, ty, value);
}
set_component_opt :: proc(self: ^Self, ty: string, value: Maybe(Tag)) {
}
    // rust: if let Some(v) = value {
    // rust: self.set_component(ty, v);
}
}
move_tag_into :: proc(self: ^Self, from: string, target: ^Tag, to: string) {
}
    // rust: if let Some(v) = self.remove_tag(from) {
    // rust: set(target, to, v);
}
}
move_to_component_default :: proc(self: ^Self, key: string, ty: string, default: ^Tag) {
}
    // rust: if let Some(v) = self.remove_tag(key)
    // rust: && v != *default
    // rust: {
    // rust: self.set_component(ty, v);
}
}
move_to_component :: proc(self: ^Self, key: string, ty: string) {
}
    // rust: if let Some(v) = self.remove_tag(key) {
    // rust: self.set_component(ty, v);
}
}
    // `fixSubTag`.
    // rust: fn fix_sub_tag(
    // rust: &mut self,
    // rust: key: &str,
    // rust: skip_missing: bool,
    // rust: f: impl FnOnce(&mut Self, Tag) -> Tag,
    // rust: ) {
    // rust: let value = self.tag.get(key).cloned();
    // rust: if skip_missing && value.is_none() {
    // rust: return;
}
    // rust: let map = value.unwrap_or_else(empty_map);
    // rust: let map = f(self, map);
    // rust: if is_empty_map(&map) {
    // rust: remove(&mut self.tag, key);
    // rust: } else {
    // rust: set(&mut self.tag, key, map);
}
}
is :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.item == id
}
write :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut result =
    // rust: Tag::compound([("id", string(&self.item)), ("count", Tag::Int(self.count))]);
    // rust: if !is_empty_map(&self.tag) {
    // rust: let tag = std::mem::replace(&mut self.tag, empty_map());
    // rust: self.set_component("minecraft:custom_data", tag);
}
    // rust: if !is_empty_map(&self.components) {
    // rust: set(&mut result, "components", self.components);
}
        // mergeRemainder: the remainder's fields under the stack's own.
    // rust: let mut out = self.remainder;
    // rust: if let (Tag::Compound(o), Tag::Compound(r)) = (&mut out, result) {
    // rust: o.extend(r);
    // rust: out
    // rust: } else {
    // rust: out
}
}
}

    // rust: const BUCKETED_MOBS: [&str; 6] = [
    // rust: "minecraft:pufferfish_bucket",
    // rust: "minecraft:salmon_bucket",
    // rust: "minecraft:cod_bucket",
    // rust: "minecraft:tropical_fish_bucket",
    // rust: "minecraft:axolotl_bucket",
    // rust: "minecraft:tadpole_bucket",
    // rust: ];
    // rust: const BUCKETED_MOB_TAGS: [&str; 10] = [
    // rust: "NoAI",
    // rust: "Silent",
    // rust: "NoGravity",
    // rust: "Glowing",
    // rust: "Invulnerable",
    // rust: "Health",
    // rust: "Age",
    // rust: "Variant",
    // rust: "HuntingCooldown",
    // rust: "BucketVariantTag",
    // rust: ];
    // rust: const BOOLEAN_BLOCK_STATE_PROPERTIES: &[&str] = &[
    // rust: "attached",
    // rust: "bottom",
    // rust: "conditional",
    // rust: "disarmed",
    // rust: "drag",
    // rust: "enabled",
    // rust: "extended",
    // rust: "eye",
    // rust: "falling",
    // rust: "hanging",
    // rust: "has_bottle_0",
    // rust: "has_bottle_1",
    // rust: "has_bottle_2",
    // rust: "has_record",
    // rust: "has_book",
    // rust: "inverted",
    // rust: "in_wall",
    // rust: "lit",
    // rust: "locked",
    // rust: "occupied",
    // rust: "open",
    // rust: "persistent",
    // rust: "powered",
    // rust: "short",
    // rust: "signal_fire",
    // rust: "snowy",
    // rust: "triggered",
    // rust: "unstable",
    // rust: "waterlogged",
    // rust: "berries",
    // rust: "bloom",
    // rust: "shrieking",
    // rust: "can_summon",
    // rust: "up",
    // rust: "down",
    // rust: "north",
    // rust: "east",
    // rust: "south",
    // rust: "west",
    // rust: "slot_0_occupied",
    // rust: "slot_1_occupied",
    // rust: "slot_2_occupied",
    // rust: "slot_3_occupied",
    // rust: "slot_4_occupied",
    // rust: "slot_5_occupied",
    // rust: "cracked",
    // rust: "crafting",
    // rust: ];

// The fix for one item stack (`writeFixAndRead` over ITEM_STACK).
    // rust: pub(super) fn componentize(v: &mut Tag) {
    // rust: if let Some(mut s) = Stack::read(v) {
    // rust: fix_stack(&mut s);
    // rust: *v = s.write();
}
}

fix_stack :: proc(s: ^Stack) {
}
    // rust: let hide_flags = as_int(s.remove_tag("HideFlags").as_ref(), 0);
    // rust: s.move_to_component_default("Damage", "minecraft:damage", &Tag::Int(0));
    // rust: s.move_to_component_default("RepairCost", "minecraft:repair_cost", &Tag::Int(0));
    // rust: s.move_to_component("CustomModelData", "minecraft:custom_model_data");
    // rust: if let Some(b) = s.remove_tag("BlockStateTag") {
    // rust: s.set_component("minecraft:block_state", fix_block_state_tag(b));
}
    // rust: s.move_to_component("EntityTag", "minecraft:entity_data");
    // rust: s.fix_sub_tag("BlockEntityTag", false, |s, be| {
    // rust: let id = namespaced(&as_string(be.get("id"), ""));
    // rust: let be = fix_block_entity_tag(s, be, &id);
    // rust: let mut without_id = be.clone();
    // rust: remove(&mut without_id, "id");
    // rust: if is_empty_map(&without_id) {
    // rust: without_id
    // rust: } else {
    // rust: be
}
    // rust: });
    // rust: s.move_to_component("BlockEntityTag", "minecraft:block_entity_data");
    // rust: if as_bool(s.remove_tag("Unbreakable").as_ref(), false) {
    // rust: let mut c = empty_map();
    // rust: if hide_flags & 4 != 0 {
    // rust: set(&mut c, "show_in_tooltip", Tag::Byte(0));
}
    // rust: s.set_component("minecraft:unbreakable", c);
}
    // rust: fix_enchantments(
    // rust: s,
    // rust: "Enchantments",
    // rust: "minecraft:enchantments",
    // rust: hide_flags & 1 != 0,
    // rust: );
    // rust: if s.is("minecraft:enchanted_book") {
    // rust: fix_enchantments(
    // rust: s,
    // rust: "StoredEnchantments",
    // rust: "minecraft:stored_enchantments",
    // rust: hide_flags & 32 != 0,
    // rust: );
}
    // rust: s.fix_sub_tag("display", false, |s, d| fix_display(s, d, hide_flags));
    // rust: fix_block_predicates(s, "CanDestroy", "minecraft:can_break", hide_flags & 8 != 0);
    // rust: fix_block_predicates(
    // rust: s,
    // rust: "CanPlaceOn",
    // rust: "minecraft:can_place_on",
    // rust: hide_flags & 16 != 0,
    // rust: );
    // rust: fix_attribute_modifiers(s, hide_flags);
    // rust: if let Some(mut trim) = s.remove_tag("Trim") {
    // rust: if hide_flags & 128 != 0 {
    // rust: set(&mut trim, "show_in_tooltip", Tag::Byte(0));
}
    // rust: s.set_component("minecraft:trim", trim);
}
    // rust: if hide_flags & 32 != 0 {
    // rust: s.set_component("minecraft:hide_additional_tooltip", empty_map());
}
    // rust: if s.is("minecraft:crossbow") {
    // rust: s.remove_tag("Charged");
    // rust: s.move_to_component_default(
    // rust: "ChargedProjectiles",
    // rust: "minecraft:charged_projectiles",
    // rust: &Tag::List(vec![]),
    // rust: );
}
    // rust: if s.is("minecraft:bundle") {
    // rust: s.move_to_component_default("Items", "minecraft:bundle_contents", &Tag::List(vec![]));
}
    // rust: if s.is("minecraft:filled_map") {
    // rust: s.move_to_component("map", "minecraft:map_id");
    // rust: let decorations = stream(s.remove_tag("Decorations").as_ref());
    // rust: let mut map = crate::nbt::Compound::new();
    // rust: for d in decorations {
    // rust: let (id, value) = fix_map_decoration(&d);
            // Collectors.toMap(..., (first, second) -> first): the first stays.
    // rust: map.entry(id).or_insert(value);
}
    // rust: if !map.is_empty() {
    // rust: s.set_component("minecraft:map_decorations", Tag::Compound(map));
}
}
    // rust: if matches!(
    // rust: s.item.as_str(),
    // rust: "minecraft:potion"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:tipped_arrow"
    // rust: ) {
    // rust: let mut c = empty_map();
    // rust: if let Some(p) = as_str(s.remove_tag("Potion").as_ref()).filter(|p| p != "minecraft:empty")
    // rust: {
    // rust: set(&mut c, "potion", string(&p));
}
    // rust: s.move_tag_into("CustomPotionColor", &mut c, "custom_color");
    // rust: s.move_tag_into("custom_potion_effects", &mut c, "custom_effects");
    // rust: if !is_empty_map(&c) {
    // rust: s.set_component("minecraft:potion_contents", c);
}
}
    // rust: if s.is("minecraft:writable_book")
    // rust: && let Some(pages) = fix_book_pages(s)
    // rust: {
    // rust: s.set_component(
    // rust: "minecraft:writable_book_content",
    // rust: Tag::compound([("pages", pages)]),
    // rust: );
}
    // rust: if s.is("minecraft:written_book") {
    // rust: let pages = fix_book_pages(s);
    // rust: let title = as_string(s.remove_tag("title").as_ref(), "");
    // rust: let filtered_title = as_str(s.remove_tag("filtered_title").as_ref());
    // rust: let mut c = empty_map();
    // rust: set(
    // rust: &mut c,
    // rust: "title",
    // rust: filtered_text(&title, filtered_title.as_deref()),
    // rust: );
    // rust: s.move_tag_into("author", &mut c, "author");
    // rust: s.move_tag_into("resolved", &mut c, "resolved");
    // rust: s.move_tag_into("generation", &mut c, "generation");
    // rust: if let Some(p) = pages {
    // rust: set(&mut c, "pages", p);
}
    // rust: s.set_component("minecraft:written_book_content", c);
}
    // rust: if s.is("minecraft:suspicious_stew") {
    // rust: s.move_to_component("effects", "minecraft:suspicious_stew_effects");
}
    // rust: if s.is("minecraft:debug_stick") {
    // rust: s.move_to_component("DebugProperty", "minecraft:debug_stick_state");
}
    // rust: if BUCKETED_MOBS.contains(&s.item.as_str()) {
    // rust: let mut data = empty_map();
    // rust: for k in BUCKETED_MOB_TAGS {
    // rust: s.move_tag_into(k, &mut data, k);
}
    // rust: if !is_empty_map(&data) {
    // rust: s.set_component("minecraft:bucket_entity_data", data);
}
}
    // rust: if s.is("minecraft:goat_horn") {
    // rust: s.move_to_component("instrument", "minecraft:instrument");
}
    // rust: if s.is("minecraft:knowledge_book") {
    // rust: s.move_to_component("Recipes", "minecraft:recipes");
}
    // rust: if s.is("minecraft:compass") {
    // rust: fix_lodestone_tracker(s);
}
    // rust: if s.is("minecraft:firework_rocket") {
    // rust: s.fix_sub_tag("Fireworks", true, |s, mut f| {
    // rust: let explosions: Vec<Tag> = stream(f.get("Explosions"))
    // rust: .into_iter()
    // rust: .map(fix_firework_explosion)
    // rust: .collect();
    // rust: let flight = as_int(f.get("Flight"), 0);
    // rust: s.set_component(
    // rust: "minecraft:fireworks",
    // rust: Tag::compound([
    // rust: ("explosions", Tag::List(explosions)),
    // rust: ("flight_duration", Tag::Byte(flight as i8)),
    // rust: ]),
    // rust: );
    // rust: remove(&mut f, "Explosions");
    // rust: remove(&mut f, "Flight");
    // rust: f
    // rust: });
}
    // rust: if s.is("minecraft:firework_star") {
    // rust: s.fix_sub_tag("Explosion", true, |s, mut e| {
    // rust: s.set_component(
    // rust: "minecraft:firework_explosion",
    // rust: fix_firework_explosion(e.clone()),
    // rust: );
    // rust: for k in ["Type", "Colors", "FadeColors", "Trail", "Flicker"] {
    // rust: remove(&mut e, k);
}
    // rust: e
    // rust: });
}
    // rust: if s.is("minecraft:player_head")
    // rust: && let Some(owner) = s.remove_tag("SkullOwner")
    // rust: {
    // rust: s.set_component("minecraft:profile", fix_profile(&owner));
}
}

fix_block_state_tag :: proc(v: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::Compound(map) = v else {
    // rust: return v;
}
    // rust: let mut out = crate::nbt::Compound::new();
    // rust: for (k, value) in map {
    // rust: let name = k.to_string_lossy();
    // rust: if BOOLEAN_BLOCK_STATE_PROPERTIES.contains(&name.as_str())
    // rust: && let Some(b) = as_bool_opt(Some(&value))
    // rust: {
    // rust: out.insert(k, string(if b { "true" } else { "false" }));
    // rust: continue;
}
    // rust: let value = match as_number(&value) {
    // rust: Some(n) => string(&n.java_string()),
    // rust: None => value,
}
    // rust: out.insert(k, value);
}
    // rust: Tag::Compound(out)
}

is_strictly_valid_json :: proc(v: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(v, Tag::String(s) if json::parse_strict(&s.0).is_some())
}

fix_display :: proc(s: ^Stack, mut d: Tag, hide_flags: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(name) = d.get("Name").filter(|n| is_strictly_valid_json(n)) {
    // rust: s.set_component("minecraft:custom_name", name.clone());
}
    // rust: if d.get("Lore").is_some() {
    // rust: let lore = stream(d.get("Lore"))
    // rust: .into_iter()
    // rust: .filter(is_strictly_valid_json)
    // rust: .collect();
    // rust: s.set_component("minecraft:lore", Tag::List(lore));
}
    // rust: let color = d.get("color").and_then(as_number).map(|n| n.int_value());
    // rust: let hide_dye = hide_flags & 64 != 0;
    // rust: if color.is_some() || hide_dye {
    // rust: let mut c = Tag::compound([("rgb", Tag::Int(color.unwrap_or(10_511_680)))]);
    // rust: if hide_dye {
    // rust: set(&mut c, "show_in_tooltip", Tag::Byte(0));
}
    // rust: s.set_component("minecraft:dyed_color", c);
}
    // rust: if let Some(loc) = as_str(d.get("LocName")) {
    // rust: s.set_component(
    // rust: "minecraft:item_name",
    // rust: Tag::String(JavaString(json::translatable_component_json(&loc))),
    // rust: );
}
    // rust: if s.is("minecraft:filled_map") {
    // rust: let color = d.get("MapColor").cloned();
    // rust: s.set_component_opt("minecraft:map_color", color);
    // rust: remove(&mut d, "MapColor");
}
    // rust: for k in ["Name", "Lore", "color", "LocName"] {
    // rust: remove(&mut d, k);
}
    // rust: d
}

fix_block_entity_tag :: proc(s: ^Stack, mut be: Tag, id: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let lock = be.get("Lock").cloned();
    // rust: s.set_component_opt("minecraft:lock", lock);
    // rust: remove(&mut be, "Lock");
    // rust: if let Some(loot) = be.get("LootTable").cloned() {
    // rust: let mut c = Tag::compound([("loot_table", loot)]);
    // rust: let seed = as_long(be.get("LootTableSeed"), 0);
    // rust: if seed != 0 {
    // rust: set(&mut c, "seed", Tag::Long(seed));
}
    // rust: s.set_component("minecraft:container_loot", c);
    // rust: remove(&mut be, "LootTable");
    // rust: remove(&mut be, "LootTableSeed");
}
    // rust: match id {
    // rust: "minecraft:skull" => {
    // rust: let v = be.get("note_block_sound").cloned();
    // rust: s.set_component_opt("minecraft:note_block_sound", v);
    // rust: remove(&mut be, "note_block_sound");
}
    // rust: "minecraft:decorated_pot" => {
    // rust: let sherds = be.get("sherds").cloned();
    // rust: s.set_component_opt("minecraft:pot_decorations", sherds);
    // rust: if let Some(item) = be.get("item").cloned() {
    // rust: s.set_component(
    // rust: "minecraft:container",
    // rust: Tag::List(vec![Tag::compound([("slot", Tag::Int(0)), ("item", item)])]),
    // rust: );
}
    // rust: remove(&mut be, "sherds");
    // rust: remove(&mut be, "item");
}
    // rust: "minecraft:banner" => {
    // rust: let patterns = be.get("patterns").cloned();
    // rust: s.set_component_opt("minecraft:banner_patterns", patterns);
    // rust: if let Some(base) = be.get("Base").and_then(as_number) {
    // rust: s.set_component(
    // rust: "minecraft:base_color",
    // rust: string(super::fixes_a::dye_color(base.int_value())),
    // rust: );
}
    // rust: remove(&mut be, "patterns");
    // rust: remove(&mut be, "Base");
}
    // rust: "minecraft:shulker_box"
    // rust: | "minecraft:chest"
    // rust: | "minecraft:trapped_chest"
    // rust: | "minecraft:furnace"
    // rust: | "minecraft:ender_chest"
    // rust: | "minecraft:dispenser"
    // rust: | "minecraft:dropper"
    // rust: | "minecraft:brewing_stand"
    // rust: | "minecraft:hopper"
    // rust: | "minecraft:barrel"
    // rust: | "minecraft:smoker"
    // rust: | "minecraft:blast_furnace"
    // rust: | "minecraft:campfire"
    // rust: | "minecraft:chiseled_bookshelf"
    // rust: | "minecraft:crafter" => {
    // rust: let items: Vec<Tag> = stream(be.get("Items"))
    // rust: .into_iter()
    // rust: .map(|mut item| {
    // rust: let slot = item
    // rust: .get("Slot")
    // rust: .and_then(as_number)
    // rust: .map_or(0, |n| n.byte_value()) as u8;
    // rust: remove(&mut item, "Slot");
    // rust: Tag::compound([("slot", Tag::Int(i32::from(slot))), ("item", item)])
    // rust: })
    // rust: .collect();
    // rust: if !items.is_empty() {
    // rust: s.set_component("minecraft:container", Tag::List(items));
}
    // rust: remove(&mut be, "Items");
}
    // rust: "minecraft:beehive" => {
    // rust: let bees = be.get("bees").cloned();
    // rust: s.set_component_opt("minecraft:bees", bees);
    // rust: remove(&mut be, "bees");
}
    // rust: _ => {}
}
    // rust: be
}

fix_enchantments :: proc(s: ^Stack, key: string, ty: string, hide: bool) {
}
    // rust: let raw = s.remove_tag(key);
    // rust: let mut enchantments: Vec<(String, i32)> = Vec::new();
    // rust: for e in stream(raw.as_ref()) {
    // rust: if let (Some(id), Some(level)) = (as_str(e.get("id")), e.get("lvl").and_then(as_number)) {
    // rust: let level = level.int_value().clamp(0, 255);
    // rust: if level > 0 {
    // rust: enchantments.push((id, level));
}
}
}
    // rust: if !enchantments.is_empty() || hide {
    // rust: let mut levels = empty_map();
    // rust: for (id, level) in &enchantments {
    // rust: set(&mut levels, id, Tag::Int(*level));
}
    // rust: let mut c = Tag::compound([("levels", levels)]);
    // rust: if hide {
    // rust: set(&mut c, "show_in_tooltip", Tag::Byte(0));
}
    // rust: s.set_component(ty, c);
}
    // rust: if raw.is_some() && enchantments.is_empty() {
    // rust: s.set_component("minecraft:enchantment_glint_override", Tag::Byte(1));
}
}

fix_block_predicates :: proc(s: ^Stack, tag: string, component: string, hide: bool) {
}
    // rust: let Some(old) = s.remove_tag(tag) else {
    // rust: return;
}
    // rust: let predicates = stream(Some(&old))
    // rust: .into_iter()
    // rust: .map(|v| match as_str(Some(&v)) {
    // rust: Some(text) => fix_block_predicate(&text),
    // rust: None => v,
    // rust: })
    // rust: .collect();
    // rust: let mut c = Tag::compound([("predicates", Tag::List(predicates))]);
    // rust: if hide {
    // rust: set(&mut c, "show_in_tooltip", Tag::Byte(0));
}
    // rust: s.set_component(component, c);
}

fix_block_predicate :: proc(text: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let start_props = text.find('[');
    // rust: let start_nbt = text.find('{');
    // rust: let mut end = text.len();
    // rust: if let Some(p) = start_props {
    // rust: end = p;
}
    // rust: if let Some(n) = start_nbt {
    // rust: end = end.min(n);
}
    // rust: let mut predicate = Tag::compound([("blocks", string(text[..end].trim()))]);
    // rust: let end_props = text.find(']');
    // rust: if let (Some(start), Some(stop)) = (start_props, end_props) {
    // rust: let mut props = empty_map();
        // Guava Splitter.on(','): String.substring throws when ] is before [.
    // rust: if start < stop {
    // rust: for property in text[start + 1..stop].split(',') {
    // rust: if let Some(eq) = property.find('=') {
    // rust: set(
    // rust: &mut props,
    // rust: property[..eq].trim(),
    // rust: string(property[eq + 1..].trim()),
    // rust: );
}
}
}
    // rust: set(&mut predicate, "state", props);
}
    // rust: let end_nbt = text.find('}');
    // rust: if let (Some(start), Some(stop)) = (start_nbt, end_nbt)
    // rust: && start <= stop
    // rust: {
    // rust: set(&mut predicate, "nbt", string(&text[start..=stop]));
}
    // rust: predicate
}

fix_attribute_modifiers :: proc(s: ^Stack, hide_flags: i32) {
}
    // rust: let Some(field) = s.remove_tag("AttributeModifiers") else {
    // rust: return;
}
    // rust: let modifiers = stream(Some(&field))
    // rust: .into_iter()
    // rust: .map(|m| fix_attribute_modifier(&m))
    // rust: .collect();
    // rust: let mut c = Tag::compound([("modifiers", Tag::List(modifiers))]);
    // rust: if hide_flags & 2 != 0 {
    // rust: set(&mut c, "show_in_tooltip", Tag::Byte(0));
}
    // rust: s.set_component("minecraft:attribute_modifiers", c);
}

fix_attribute_modifier :: proc(input: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Tag::compound([
    // rust: ("name", string("")),
    // rust: ("amount", Tag::Double(0f64.to_bits())),
    // rust: ("operation", string("add_value")),
    // rust: ]);
    // rust: super::dynamic::copy_field(input, "AttributeName", &mut r, "type");
    // rust: super::dynamic::copy_field(input, "Slot", &mut r, "slot");
    // rust: super::dynamic::copy_field(input, "UUID", &mut r, "uuid");
    // rust: super::dynamic::copy_field(input, "Name", &mut r, "name");
    // rust: super::dynamic::copy_field(input, "Amount", &mut r, "amount");
    // rust: if let Some(op) = input.get("Operation") {
    // rust: let name = match as_int(Some(op), 0) {
    // rust: 1 => "add_multiplied_base",
    // rust: 2 => "add_multiplied_total",
    // rust: _ => "add_value",
}
    // rust: set(&mut r, "operation", string(name));
}
    // rust: r
}

fix_map_decoration :: proc(d: ^Tag) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let id = match d.get("id") {
    // rust: Some(Tag::String(s)) => s.clone(),
        // A non-string key fails the map; vanilla throws on it.
        // createMap throws on a key that is not a string; such a stack is left as it was.
    // rust: Some(_) => JavaString::default(),
    // rust: None => JavaString::default(),
}
    // rust: let ty = match as_int(d.get("type"), 0) {
    // rust: 1 => "frame",
    // rust: 2 => "red_marker",
    // rust: 3 => "blue_marker",
    // rust: 4 => "target_x",
    // rust: 5 => "target_point",
    // rust: 6 => "player_off_map",
    // rust: 7 => "player_off_limits",
    // rust: 8 => "mansion",
    // rust: 9 => "monument",
    // rust: 10 => "banner_white",
    // rust: 11 => "banner_orange",
    // rust: 12 => "banner_magenta",
    // rust: 13 => "banner_light_blue",
    // rust: 14 => "banner_yellow",
    // rust: 15 => "banner_lime",
    // rust: 16 => "banner_pink",
    // rust: 17 => "banner_gray",
    // rust: 18 => "banner_light_gray",
    // rust: 19 => "banner_cyan",
    // rust: 20 => "banner_purple",
    // rust: 21 => "banner_blue",
    // rust: 22 => "banner_brown",
    // rust: 23 => "banner_green",
    // rust: 24 => "banner_red",
    // rust: 25 => "banner_black",
    // rust: 26 => "red_x",
    // rust: 27 => "village_desert",
    // rust: 28 => "village_plains",
    // rust: 29 => "village_savanna",
    // rust: 30 => "village_snowy",
    // rust: 31 => "village_taiga",
    // rust: 32 => "jungle_temple",
    // rust: 33 => "swamp_hut",
    // rust: _ => "player",
}
    // rust: let value = Tag::compound([
    // rust: ("type", string(ty)),
    // rust: ("x", Tag::Double(as_double(d.get("x"), 0.0).to_bits())),
    // rust: ("z", Tag::Double(as_double(d.get("z"), 0.0).to_bits())),
    // rust: (
    // rust: "rotation",
    // rust: Tag::Float((as_double(d.get("rot"), 0.0) as f32).to_bits()),
    // rust: ),
    // rust: ]);
    // rust: (id, value)
}

fix_book_pages :: proc(s: ^Stack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pages: Vec<String> = stream(s.remove_tag("pages").as_ref())
    // rust: .iter()
    // rust: .map(|p| as_string(Some(p), ""))
    // rust: .collect();
    // rust: let filtered: Vec<(String, String)> = match s.remove_tag("filtered_pages") {
    // rust: Some(Tag::Compound(c)) => c
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string_lossy(), as_string(Some(v), "")))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: if pages.is_empty() {
    // rust: return None;
}
    // rust: let fixed = pages
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, page)| {
    // rust: let f = filtered
    // rust: .iter()
    // rust: .find(|(k, _)| *k == i.to_string())
    // rust: .map(|(_, v)| v.as_str());
    // rust: filtered_text(page, f)
    // rust: })
    // rust: .collect();
    // rust: Some(Tag::List(fixed))
}

filtered_text :: proc(text: string, filtered: Maybe(string)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = Tag::compound([("raw", string(text))]);
    // rust: if let Some(f) = filtered {
    // rust: set(&mut t, "filtered", string(f));
}
    // rust: t
}

fix_lodestone_tracker :: proc(s: ^Stack) {
}
    // rust: let pos = s.remove_tag("LodestonePos");
    // rust: let dimension = s.remove_tag("LodestoneDimension");
    // rust: if pos.is_none() && dimension.is_none() {
    // rust: return;
}
    // rust: let tracked = as_bool(s.remove_tag("LodestoneTracked").as_ref(), true);
    // rust: let mut c = empty_map();
    // rust: if let (Some(p), Some(d)) = (pos, dimension) {
    // rust: set(
    // rust: &mut c,
    // rust: "target",
    // rust: Tag::compound([("pos", p), ("dimension", d)]),
    // rust: );
}
    // rust: if !tracked {
    // rust: set(&mut c, "tracked", Tag::Byte(0));
}
    // rust: s.set_component("minecraft:lodestone_tracker", c);
}

fix_firework_explosion :: proc(mut e: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let shape = match as_int(e.get("Type"), 0) {
    // rust: 1 => "large_ball",
    // rust: 2 => "star",
    // rust: 3 => "creeper",
    // rust: 4 => "burst",
    // rust: _ => "small_ball",
}
    // rust: set(&mut e, "shape", string(shape));
    // rust: remove(&mut e, "Type");
    // rust: rename(&mut e, "Colors", "colors");
    // rust: rename(&mut e, "FadeColors", "fade_colors");
    // rust: rename(&mut e, "Trail", "has_trail");
    // rust: rename(&mut e, "Flicker", "has_twinkle");
    // rust: e
}

// `ItemStackComponentizationFix.fixProfile`.
    // rust: pub(super) fn fix_profile(v: &Tag) -> Tag {
    // rust: if let Some(name) = as_str(Some(v)) {
    // rust: return if valid_player_name(&name) {
    // rust: Tag::compound([("name", string(&name))])
    // rust: } else {
    // rust: empty_map()
}
}
    // rust: let name = as_string(v.get("Name"), "");
    // rust: let id = v.get("Id").cloned();
    // rust: let properties = fix_profile_properties(v.get("Properties"));
    // rust: let mut p = empty_map();
    // rust: if valid_player_name(&name) {
    // rust: set(&mut p, "name", string(&name));
}
    // rust: if let Some(id) = id {
    // rust: set(&mut p, "id", id);
}
    // rust: if let Some(props) = properties {
    // rust: set(&mut p, "properties", props);
}
    // rust: p
}

valid_player_name :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let units: Vec<u16> = name.encode_utf16().collect();
    // rust: units.len() <= 16 && units.iter().all(|&c| c > 32 && c < 127)
}

fix_profile_properties :: proc(v: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Tag::Compound(map)) = v else {
    // rust: return None;
}
    // asMap collects into a HashMap: the property names in Java hash order.
    // rust: let mut entries: Vec<(String, Vec<(String, Option<String>)>)> = map
    // rust: .iter()
    // rust: .map(|(k, list)| {
    // rust: let props = stream(Some(list))
    // rust: .iter()
    // rust: .map(|p| (as_string(p.get("Value"), ""), as_str(p.get("Signature"))))
    // rust: .collect();
    // rust: (k.to_string_lossy(), props)
    // rust: })
    // rust: .collect();
    // rust: if entries.is_empty() {
    // rust: return None;
}
    // rust: entries = java_hash_order(entries, |(k, _)| k.clone());
    // rust: let out = entries
    // rust: .into_iter()
    // rust: .flat_map(|(name, props)| {
    // rust: props.into_iter().map(move |(value, signature)| {
    // rust: let mut p = Tag::compound([("name", string(&name)), ("value", string(&value))]);
    // rust: if let Some(sig) = signature {
    // rust: set(&mut p, "signature", string(&sig));
}
    // rust: p
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Some(Tag::List(out))
}

// Java `String.hashCode`.
    // rust: pub(super) fn java_string_hash(s: &str) -> i32 {
    // rust: s.encode_utf16()
    // rust: .fold(0i32, |h, c| h.wrapping_mul(31).wrapping_add(i32::from(c)))
}

// Iteration order of a `java.util.HashMap`/`HashSet` built by inserting the
// items in order (default capacity, string keys, no tree bins).
    // rust: pub(super) fn java_hash_order<T>(items: Vec<T>, key: impl Fn(&T) -> String) -> Vec<T> {
    // rust: let mut capacity = 16usize;
    // rust: while items.len() as f64 > capacity as f64 * 0.75 {
    // rust: capacity *= 2;
}
    // rust: let spread = |h: i32| (h ^ ((h as u32) >> 16) as i32) as u32 as usize;
    // rust: let mut buckets: Vec<Vec<T>> = (0..capacity).map(|_| Vec::new()).collect();
    // rust: for item in items {
    // rust: let index = spread(java_string_hash(&key(&item))) & (capacity - 1);
    // rust: buckets[index].push(item);
}
    // rust: buckets.into_iter().flatten().collect()
}

// ------------------------------------------------------------------ particles

// `ParticleUnflatteningFix.fix` of a particle description string.
    // rust: pub(super) fn unflatten_particle(description: &str) -> Tag {
    // rust: let (first, rest) = match description.split_once(' ') {
    // rust: Some((a, b)) => (a, Some(b)),
    // rust: None => (description, None),
}
    // rust: let id = namespaced(first);
    // rust: let mut result = Tag::compound([("type", string(&id))]);
    // rust: let Some(contents) = rest else {
    // rust: return result;
}
    // rust: match id.as_str() {
    // rust: "minecraft:item" => {
    // rust: let mut stack = Tag::compound([("Count", Tag::Int(1))]);
    // rust: match contents.find('{') {
    // rust: None => set(&mut stack, "id", string(contents)),
    // rust: Some(i) => {
    // rust: set(&mut stack, "id", string(&contents[..i]));
    // rust: if let Ok((tag, used)) = crate::nbt::parse_snbt(&contents[i..])
    // rust: && used == contents[i..].len()
    // rust: {
    // rust: set(&mut stack, "tag", tag);
}
}
}
    // rust: set(&mut result, "item", stack);
}
    // rust: "minecraft:block"
    // rust: | "minecraft:block_marker"
    // rust: | "minecraft:falling_dust"
    // rust: | "minecraft:dust_pillar" => {
    // rust: let mut state = empty_map();
    // rust: match contents.find('[') {
    // rust: None => set(&mut state, "Name", string(&namespaced(contents))),
    // rust: Some(i) => {
    // rust: set(&mut state, "Name", string(&namespaced(&contents[..i])));
    // rust: let props = parse_block_properties(&contents[i..]);
    // rust: if let Some(Tag::Compound(p)) = &props
    // rust: && !p.is_empty()
    // rust: {
    // rust: set(&mut state, "Properties", props.unwrap_or_else(empty_map));
}
}
}
    // rust: set(&mut result, "block_state", state);
}
    // rust: "minecraft:dust" => {
    // rust: let mut r = Reader::new(contents);
    // rust: if let Some(color) = r.vector()
    // rust: && r.expect(' ')
    // rust: && let Some(scale) = r.float()
    // rust: {
    // rust: set(&mut result, "color", color);
    // rust: set(&mut result, "scale", Tag::Float(scale.to_bits()));
}
}
    // rust: "minecraft:dust_color_transition" => {
    // rust: let mut r = Reader::new(contents);
    // rust: if let Some(from) = r.vector()
    // rust: && r.expect(' ')
    // rust: && let Some(scale) = r.float()
    // rust: && r.expect(' ')
    // rust: && let Some(to) = r.vector()
    // rust: {
    // rust: set(&mut result, "from_color", from);
    // rust: set(&mut result, "to_color", to);
    // rust: set(&mut result, "scale", Tag::Float(scale.to_bits()));
}
}
    // rust: "minecraft:sculk_charge" => {
    // rust: if let Some(roll) = Reader::new(contents).float() {
    // rust: set(&mut result, "roll", Tag::Float(roll.to_bits()));
}
}
    // rust: "minecraft:vibration" => {
    // rust: let mut r = Reader::new(contents);
    // rust: if let Some(x) = r.double()
    // rust: && r.expect(' ')
    // rust: && let Some(y) = r.double()
    // rust: && r.expect(' ')
    // rust: && let Some(z) = r.double()
    // rust: && r.expect(' ')
    // rust: && let Some(ticks) = r.int()
    // rust: {
    // rust: let pos = int_list(&[
    // rust: (x as f32).floor() as i32,
    // rust: (y as f32).floor() as i32,
    // rust: (z as f32).floor() as i32,
    // rust: ]);
    // rust: set(
    // rust: &mut result,
    // rust: "destination",
    // rust: Tag::compound([("type", string("minecraft:block")), ("pos", pos)]),
    // rust: );
    // rust: set(&mut result, "arrival_in_ticks", Tag::Int(ticks));
}
}
    // rust: "minecraft:shriek" => {
    // rust: if let Some(delay) = Reader::new(contents).int() {
    // rust: set(&mut result, "delay", Tag::Int(delay));
}
}
    // rust: _ => {}
}
    // rust: result
}

// `parseBlockProperties` with Brigadier's StringReader.
parse_block_properties :: proc(contents: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader::new(contents);
    // rust: let mut out = empty_map();
    // rust: if !r.expect('[') {
    // rust: return Some(empty_map());
}
    // rust: r.skip_ws();
    // rust: while r.peek().is_some_and(|c| c != ']') {
    // rust: r.skip_ws();
    // rust: let Some(key) = r.string() else {
    // rust: return Some(empty_map());
}
    // rust: r.skip_ws();
    // rust: if !r.expect('=') {
    // rust: return Some(empty_map());
}
    // rust: r.skip_ws();
    // rust: let Some(value) = r.string() else {
    // rust: return Some(empty_map());
}
    // rust: r.skip_ws();
    // rust: set(&mut out, &key, string(&value));
    // rust: if r.peek().is_some() {
    // rust: if r.peek() != Some(',') {
    // rust: break;
}
    // rust: r.pos += 1;
}
}
    // rust: if !r.expect(']') {
    // rust: return Some(empty_map());
}
    // rust: Some(out)
}

// The parts of Brigadier's `StringReader` the particle fix uses.
Reader :: struct {
    s: [dynamic]char,
    pos: uint,
}
    // rust: impl Reader {
new :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: s: s.chars().collect(),
    // rust: pos: 0,
}
}
peek :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.s.get(self.pos).copied()
}
expect :: proc(self: ^Self, c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.peek() == Some(c) {
    // rust: self.pos += 1;
    // rust: true
    // rust: } else {
    // rust: false
}
}
skip_ws :: proc(self: ^Self) {
}
    // rust: while self.peek().is_some_and(char::is_whitespace) {
    // rust: self.pos += 1;
}
}
number_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.pos;
    // rust: while self
    // rust: .peek()
    // rust: .is_some_and(|c| c.is_ascii_digit() || c == '.' || c == '-')
    // rust: {
    // rust: self.pos += 1;
}
    // rust: self.s[start..self.pos].iter().collect()
}
float :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.number_text().parse().ok()
}
double :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.number_text().parse().ok()
}
int :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.pos;
    // rust: while self.peek().is_some_and(|c| c.is_ascii_digit() || c == '-') {
    // rust: self.pos += 1;
}
    // rust: self.s[start..self.pos]
    // rust: .iter()
    // rust: .collect::<String>()
    // rust: .parse()
    // rust: .ok()
}
vector :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let x = self.float()?;
    // rust: if !self.expect(' ') {
    // rust: return None;
}
    // rust: let y = self.float()?;
    // rust: if !self.expect(' ') {
    // rust: return None;
}
    // rust: let z = self.float()?;
    // rust: Some(Tag::List(vec![
    // rust: Tag::Float(x.to_bits()),
    // rust: Tag::Float(y.to_bits()),
    // rust: Tag::Float(z.to_bits()),
    // rust: ]))
}
    // `StringReader.readString`: quoted or unquoted.
string :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.peek() {
    // rust: Some(q @ ('"' | '\'')) => {
    // rust: self.pos += 1;
    // rust: let mut out = String::new();
    // rust: let mut escaped = false;
    // rust: while let Some(c) = self.peek() {
    // rust: self.pos += 1;
    // rust: if escaped {
    // rust: if c != q && c != '\\' {
    // rust: return None;
}
    // rust: out.push(c);
    // rust: escaped = false;
    // rust: } else if c == '\\' {
    // rust: escaped = true;
    // rust: } else if c == q {
    // rust: return Some(out);
    // rust: } else {
    // rust: out.push(c);
}
}
    // rust: None
}
    // rust: _ => {
    // rust: let start = self.pos;
    // rust: while self.peek().is_some_and(|c| {
    // rust: c.is_ascii_alphanumeric() || matches!(c, '_' | '-' | '.' | '+')
    // rust: }) {
    // rust: self.pos += 1;
}
    // rust: Some(self.s[start..self.pos].iter().collect())
}
}
}
}
