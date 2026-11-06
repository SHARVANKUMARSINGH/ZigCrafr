//! Transpiled from Horizon Rust crate
package horizon_world_schema

import "core:fmt"
import "core:mem"
import "core:math"

// Where DataFixerUpper finds each type inside the data, schema by schema
// (`net.minecraft.util.datafix.schemas`), from the 1.20 schemas on.
//
// `walk` visits every value of the target type under a root of a given type,
// children before parents (DataFixerUpper rewrites recursive types bottom-up).
// Keys are `version * 10 + sub-version` as in `DataFixUtils.makeKey`, and a
// fix with key K reads its input with the schema just below K.
// use super::dynamic::{as_str, namespaced};
// use crate::nbt::Tag;

    // rust: pub(super) mod flat;

Ty :: enum {
    Level,
    // `LIGHTWEIGHT_LEVEL`: the level data apart from its typed fields (the same value).
    LightweightLevel,
    Player,
    Chunk,
    EntityChunk,
    PoiChunk,
    BlockEntity,
    EntityTree,
    Entity,
    ItemStack,
    DataComponents,
    TextComponent,
    VillagerTrade,
    // `UNTAGGED_SPAWNER`: the spawner fields of a spawner block entity or minecart.
    UntaggedSpawner,
    Particle,
    BlockState,
    FlatBlockState,
    BlockName,
    ItemName,
    EntityName,
    Biome,
    Recipe,
    StructureFeature,
    GameEventName,
    Advancements,
    Stats,
    Hotbar,
    Objective,
    Team,
    WorldGenSettings,
    SavedCustomBossEvents,
    SavedMapData,
    SavedScoreboard,
    SavedWorldGenSettings,
    SavedStructureFeatureIndices,
    // Saved data that has no typed fields (`DSL.remainder`).
    SavedRemainder,
    // Each saved data kind still needs its own identity for fixes that target it.
    SavedEnderDragonFight,
    SavedGameRules,
    SavedTickets,
    SavedRaids,
    SavedRandomSequences,
    SavedWorldBorder,
    SavedWeather,
    SavedWorldClocks,
    SavedWanderingTrader,
    SavedScheduledEvents,
    SavedMapIndex,
    SavedCommandStorage,
    SavedStopwatches,
    Options,
    DebugProfile,
}

// A schema key: `version * 10 + sub`.
    // rust: pub type Key = u32;
    // rust: pub const fn key(version: u32, sub: u32) -> Key {
    // rust: version * 10 + sub
}

Walker :: struct {
    // The schema the data is read with.
    k: Key,
    target: Ty,
    f: ^'f mut dyn FnMut(^Tag),
}

    // rust: impl Walker<'_> {
walk :: proc(self: ^Self, ty: Ty, v: ^Tag) {
}
    // rust: self.children(ty, v);
    // rust: if ty == self.target {
    // rust: (self.f)(v);
}
}
field :: proc(self: ^Self, ty: Ty, v: ^Tag, name: string) {
}
    // rust: if let Some(child) = v.get_mut(name) {
    // rust: self.walk(ty, child);
}
}
list :: proc(self: ^Self, ty: Ty, v: ^Tag, name: string) {
}
        // A list of block names reads the numbers of an array tag and writes them as a list.
    // rust: if ty == Ty::BlockName
    // rust: && self.k < key(1451, 4)
    // rust: && let Some(array) = v.get_mut(name)
    // rust: {
    // rust: let numbers: Option<Vec<Tag>> = match array {
    // rust: Tag::IntArray(a) => Some(a.iter().map(|x| Tag::Int(*x)).collect()),
    // rust: Tag::ByteArray(a) => Some(a.iter().map(|x| Tag::Byte(*x as i8)).collect()),
    // rust: Tag::LongArray(a) => Some(a.iter().map(|x| Tag::Long(*x)).collect()),
    // rust: _ => None,
}
    // rust: if let Some(numbers) = numbers {
    // rust: *array = Tag::List(numbers);
}
}
    // rust: if let Some(Tag::List(items)) = v.get_mut(name) {
    // rust: for item in items {
    // rust: self.walk(ty, item);
}
}
}
list_in :: proc(self: ^Self, ty: Ty, items: ^Tag) {
}
    // rust: if let Tag::List(items) = items {
    // rust: for item in items {
    // rust: self.walk(ty, item);
}
}
}
    // `DSL.compoundList(type)`: every value of a map.
values :: proc(self: ^Self, ty: Ty, v: ^Tag, name: string) {
}
    // rust: if let Some(Tag::Compound(c)) = v.get_mut(name) {
    // rust: for value in c.values_mut() {
    // rust: self.walk(ty, value);
}
}
}
    // A list of compounds, each with a typed field.
list_of_field :: proc(self: ^Self, ty: Ty, v: ^Tag, list: string, field: string) {
}
    // rust: if let Some(Tag::List(items)) = v.get_mut(list) {
    // rust: for item in items {
    // rust: self.field(ty, item, field);
}
}
}
    // `DSL.compoundList(keyType, valueType)` with typed string keys: keys are
    // renamed in place by the callback (as a string tag).
keys :: proc(self: ^Self, ty: Ty, v: ^Tag, name: string) {
}
    // rust: if ty != self.target {
    // rust: return;
}
    // rust: if let Some(Tag::Compound(c)) = v.get_mut(name) {
    // rust: let entries: Vec<_> = std::mem::take(c).into_iter().collect();
    // rust: for (k, value) in entries {
    // rust: let mut key_tag = Tag::String(k.clone());
    // rust: (self.f)(&mut key_tag);
    // rust: let k = match key_tag {
    // rust: Tag::String(s) => s,
    // rust: _ => k,
}
    // rust: c.insert(k, value);
}
}
}

children :: proc(self: ^Self, ty: Ty, v: ^Tag) {
}
    // rust: let k = self.k;
    // rust: if k < flat::END && self.legacy_children(ty, v) {
    // rust: return;
}
    // rust: match ty {
    // rust: Ty::Level => {
    // rust: if k < key(4771, 0) {
    // rust: if let Some(Tag::Compound(c)) = v.get_mut("CustomBossEvents") {
    // rust: for e in c.values_mut() {
    // rust: self.field(Ty::TextComponent, e, "Name");
}
}
}
    // rust: self.walk(Ty::LightweightLevel, v);
}
    // rust: Ty::Player => {
    // rust: if k >= key(4312, 0) {
    // rust: self.equipment(v);
}
    // rust: if let Some(rv) = v.get_mut("RootVehicle") {
    // rust: self.field(Ty::EntityTree, rv, "Entity");
}
    // rust: self.list(Ty::EntityTree, v, "ender_pearls");
    // rust: self.list(Ty::ItemStack, v, "Inventory");
    // rust: self.list(Ty::ItemStack, v, "EnderItems");
    // rust: self.field(Ty::EntityTree, v, "ShoulderEntityLeft");
    // rust: self.field(Ty::EntityTree, v, "ShoulderEntityRight");
    // rust: if let Some(book) = v.get_mut("recipeBook") {
    // rust: self.list(Ty::Recipe, book, "recipes");
    // rust: self.list(Ty::Recipe, book, "toBeDisplayed");
}
}
    // rust: Ty::Chunk if k < key(2842, 0) => {
    // rust: if let Some(level) = v.get_mut("Level") {
    // rust: self.level_chunk(level);
}
}
    // rust: Ty::Chunk => {
    // rust: self.list(Ty::EntityTree, v, "entities");
    // rust: if let Some(Tag::List(items)) = v.get_mut("block_entities") {
    // rust: for be in items {
                        // DSL.or(BLOCK_ENTITY, remainder): unknown ids stay as they are.
    // rust: if block_entity_known(be, k) {
    // rust: self.walk(Ty::BlockEntity, be);
}
}
}
    // rust: self.list_of_field(Ty::BlockName, v, "block_ticks", "i");
    // rust: if let Some(Tag::List(sections)) = v.get_mut("sections") {
    // rust: for s in sections {
    // rust: if let Some(b) = s.get_mut("biomes") {
    // rust: self.list(Ty::Biome, b, "palette");
}
    // rust: if let Some(b) = s.get_mut("block_states") {
    // rust: self.list(Ty::BlockState, b, "palette");
}
}
}
    // rust: if let Some(s) = v.get_mut("structures") {
    // rust: self.values(Ty::StructureFeature, s, "starts");
}
}
    // rust: Ty::EntityChunk => self.list(Ty::EntityTree, v, "Entities"),
            // What the schema it was read with did not know stays untyped (see `flat::UNTYPED`).
    // rust: Ty::EntityTree if v.get(flat::UNTYPED).is_some() => {}
    // rust: Ty::EntityTree => {
    // rust: self.list(Ty::EntityTree, v, "Passengers");
    // rust: self.walk(Ty::Entity, v);
}
    // rust: Ty::Entity => self.entity(v),
    // rust: Ty::UntaggedSpawner => self.untagged_spawner(v),
    // rust: Ty::BlockEntity => self.block_entity(v),
    // rust: Ty::ItemStack => self.item_stack(v),
    // rust: Ty::DataComponents => self.components(v),
    // rust: Ty::TextComponent => self.text(v),
    // rust: Ty::VillagerTrade => {
    // rust: self.field(Ty::ItemStack, v, "buy");
    // rust: self.field(Ty::ItemStack, v, "buyB");
    // rust: self.field(Ty::ItemStack, v, "sell");
}
    // rust: Ty::Particle => {
    // rust: if k >= key(3818, 4) {
    // rust: self.field(Ty::ItemStack, v, "item");
    // rust: self.field(Ty::BlockState, v, "block_state");
}
}
    // rust: Ty::Hotbar => {
    // rust: if let Tag::Compound(c) = v {
    // rust: for row in c.values_mut() {
    // rust: self.list_in(Ty::ItemStack, row);
}
}
}
    // rust: Ty::Stats => {
    // rust: if let Some(stats) = v.get_mut("stats") {
    // rust: self.keys(Ty::BlockName, stats, "minecraft:mined");
    // rust: for s in ["crafted", "used", "broken", "picked_up", "dropped"] {
    // rust: self.keys(Ty::ItemName, stats, &format!("minecraft:{s}"));
}
    // rust: self.keys(Ty::EntityName, stats, "minecraft:killed");
    // rust: self.keys(Ty::EntityName, stats, "minecraft:killed_by");
}
}
    // rust: Ty::Advancements => {
    // rust: for (adv, kind) in [
    // rust: ("minecraft:adventure/adventuring_time", Ty::Biome),
    // rust: ("minecraft:adventure/kill_a_mob", Ty::EntityName),
    // rust: ("minecraft:adventure/kill_all_mobs", Ty::EntityName),
    // rust: ("minecraft:husbandry/bred_all_animals", Ty::EntityName),
    // rust: ] {
    // rust: if let Some(a) = v.get_mut(adv) {
    // rust: self.keys(kind, a, "criteria");
}
}
}
    // rust: Ty::Objective => {
                // The hook unpacked CriteriaName into CriteriaType {type, id}.
    // rust: if let Some(ct) = v.get_mut("CriteriaType") {
    // rust: let kind = match as_str(ct.get("type")).as_deref() {
    // rust: Some("minecraft:mined") => Some(Ty::BlockName),
    // rust: Some(
    // rust: "minecraft:crafted"
    // rust: | "minecraft:used"
    // rust: | "minecraft:broken"
    // rust: | "minecraft:picked_up"
    // rust: | "minecraft:dropped",
    // rust: ) => Some(Ty::ItemName),
    // rust: Some("minecraft:killed" | "minecraft:killed_by") => Some(Ty::EntityName),
    // rust: _ => None,
}
    // rust: if let Some(kind) = kind {
    // rust: self.field(kind, ct, "id");
}
}
    // rust: self.field(Ty::TextComponent, v, "DisplayName");
}
    // rust: Ty::Team => {
    // rust: for f in ["MemberNamePrefix", "MemberNameSuffix", "DisplayName"] {
    // rust: self.field(Ty::TextComponent, v, f);
}
}
    // rust: Ty::SavedCustomBossEvents => {
    // rust: if let Some(Tag::Compound(c)) = v.get_mut("data") {
    // rust: for e in c.values_mut() {
    // rust: self.field(Ty::TextComponent, e, "Name");
}
}
}
    // rust: Ty::SavedMapData => {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: let name = if k >= key(3813, 0) { "name" } else { "Name" };
    // rust: self.list_of_field(Ty::TextComponent, d, "banners", name);
}
}
    // rust: Ty::SavedScoreboard => {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: self.list(Ty::Objective, d, "Objectives");
    // rust: self.list(Ty::Team, d, "Teams");
    // rust: self.list_of_field(Ty::TextComponent, d, "PlayerScores", "display");
}
}
    // rust: Ty::SavedWorldGenSettings => self.field(Ty::WorldGenSettings, v, "data"),
    // rust: Ty::SavedStructureFeatureIndices => {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: self.values(Ty::StructureFeature, d, "Features");
}
}
    // rust: Ty::WorldGenSettings => self.world_gen(v),
    // rust: _ => {}
}
}

equipment :: proc(self: ^Self, v: ^Tag) {
}
    // rust: if self.k >= key(4301, 0) {
    // rust: if let Some(eq) = v.get_mut("equipment") {
    // rust: for slot in [
    // rust: "mainhand", "offhand", "feet", "legs", "chest", "head", "body", "saddle",
    // rust: ] {
    // rust: self.field(Ty::ItemStack, eq, slot);
}
}
    // rust: } else {
    // rust: self.list(Ty::ItemStack, v, "ArmorItems");
    // rust: self.list(Ty::ItemStack, v, "HandItems");
    // rust: self.field(Ty::ItemStack, v, "body_armor_item");
    // rust: self.field(Ty::ItemStack, v, "saddle");
}
}

entity :: proc(self: ^Self, v: ^Tag) {
}
    // rust: let k = self.k;
    // rust: self.equipment(v);
    // rust: self.field(Ty::TextComponent, v, "CustomName");
    // rust: let id = namespaced(&as_str(v.get("id")).unwrap_or_default());
    // rust: let id = id.as_str();
    // rust: let listener = |w: &mut Self, v: &mut Tag| {
    // rust: if let Some(l) = v.get_mut("listener")
    // rust: && let Some(e) = l.get_mut("event")
    // rust: {
    // rust: w.field(Ty::GameEventName, e, "game_event");
}
}
    // rust: match id {
    // rust: "minecraft:area_effect_cloud" => {
    // rust: let f = if k >= key(4420, 0) {
    // rust: "custom_particle"
    // rust: } else {
    // rust: "Particle"
}
    // rust: self.field(Ty::Particle, v, f);
}
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" => {
    // rust: self.field(Ty::BlockState, v, "inBlockState");
    // rust: if k >= key(3685, 0) {
    // rust: self.field(Ty::ItemStack, v, "item");
}
    // rust: if k >= key(3938, 0) {
    // rust: self.field(Ty::ItemStack, v, "weapon");
}
}
    // rust: "minecraft:trident" => {
    // rust: self.field(Ty::BlockState, v, "inBlockState");
    // rust: let f = if k >= key(3685, 0) { "item" } else { "Trident" };
    // rust: self.field(Ty::ItemStack, v, f);
}
    // rust: "minecraft:chest_minecart" | "minecraft:hopper_minecart" => {
    // rust: self.field(Ty::BlockState, v, "DisplayState");
    // rust: self.list(Ty::ItemStack, v, "Items");
}
    // rust: "minecraft:minecart" | "minecraft:furnace_minecart" | "minecraft:tnt_minecart" => {
    // rust: self.field(Ty::BlockState, v, "DisplayState");
}
    // rust: "minecraft:command_block_minecart" => {
    // rust: self.field(Ty::BlockState, v, "DisplayState");
    // rust: self.field(Ty::TextComponent, v, "LastOutput");
}
    // rust: "minecraft:spawner_minecart" => {
    // rust: self.field(Ty::BlockState, v, "DisplayState");
    // rust: self.spawner(v);
}
    // rust: "minecraft:donkey" | "minecraft:mule" => {
    // rust: self.list(Ty::ItemStack, v, "Items");
    // rust: if k < key(4300, 0) {
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
}
    // rust: "minecraft:llama" | "minecraft:trader_llama" => {
    // rust: self.list(Ty::ItemStack, v, "Items");
    // rust: if k < key(4300, 0) {
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: let split = if id == "minecraft:llama" {
    // rust: key(3808, 1)
    // rust: } else {
    // rust: key(3808, 2)
}
    // rust: if k < split {
    // rust: self.field(Ty::ItemStack, v, "DecorItem");
}
}
    // rust: "minecraft:horse" => {
    // rust: if k < key(4300, 0) {
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: if k < key(3808, 0) {
    // rust: self.field(Ty::ItemStack, v, "ArmorItem");
}
}
    // rust: "minecraft:skeleton_horse" | "minecraft:zombie_horse" => {
    // rust: if k < key(4300, 0) {
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
}
    // rust: "minecraft:enderman" => self.field(Ty::BlockState, v, "carriedBlockState"),
    // rust: "minecraft:falling_block" => {
    // rust: self.field(Ty::BlockState, v, "BlockState");
    // rust: self.field(Ty::BlockEntity, v, "TileEntityData");
}
    // rust: "minecraft:firework_rocket" => self.field(Ty::ItemStack, v, "FireworksItem"),
    // rust: "minecraft:item" | "minecraft:item_frame" | "minecraft:glow_item_frame" => {
    // rust: self.field(Ty::ItemStack, v, "Item");
}
    // rust: "minecraft:potion" if k < key(4306, 0) => {
                // V2511_1 renamed the typed field.
    // rust: let field = if k < key(2511, 1) { "Potion" } else { "Item" };
    // rust: self.field(Ty::ItemStack, v, field);
}
    // rust: "minecraft:splash_potion" | "minecraft:lingering_potion" if k >= key(4306, 0) => {
    // rust: self.field(Ty::ItemStack, v, "Item");
}
    // rust: "minecraft:villager" | "minecraft:wandering_trader" => {
    // rust: self.list(Ty::ItemStack, v, "Inventory");
    // rust: if let Some(o) = v.get_mut("Offers") {
    // rust: self.list(Ty::VillagerTrade, o, "Recipes");
}
}
    // rust: "minecraft:zombie_villager" => {
    // rust: if let Some(o) = v.get_mut("Offers") {
    // rust: self.list(Ty::VillagerTrade, o, "Recipes");
}
}
    // rust: "minecraft:pillager" | "minecraft:piglin" => self.list(Ty::ItemStack, v, "Inventory"),
    // rust: "minecraft:allay" => {
    // rust: self.list(Ty::ItemStack, v, "Inventory");
    // rust: listener(self, v);
}
    // rust: "minecraft:warden" => listener(self, v),
    // rust: "minecraft:tnt" if k >= key(3683, 0) => self.field(Ty::BlockState, v, "block_state"),
    // rust: "minecraft:chest_boat" if k < key(4067, 0) => self.list(Ty::ItemStack, v, "Items"),
    // rust: "minecraft:item_display" => self.field(Ty::ItemStack, v, "item"),
    // rust: "minecraft:block_display" => self.field(Ty::BlockState, v, "block_state"),
    // rust: "minecraft:text_display" => self.field(Ty::TextComponent, v, "text"),
    // rust: "minecraft:ominous_item_spawner" if k >= key(3825, 0) => {
    // rust: self.field(Ty::ItemStack, v, "item")
}
    // rust: _ if k >= key(4067, 0)
    // rust: && (id.ends_with("_chest_boat") || id == "minecraft:bamboo_chest_raft") =>
    // rust: {
    // rust: self.list(Ty::ItemStack, v, "Items");
}
    // rust: _ => {}
}
}

    // The `Level` of a chunk before 1.18 (V99, V1451_1, V1466, V2832).
level_chunk :: proc(self: ^Self, v: ^Tag) {
}
    // rust: let k = self.k;
    // rust: self.list(Ty::EntityTree, v, "Entities");
    // rust: if let Some(Tag::List(items)) = v.get_mut("TileEntities") {
    // rust: for be in items {
    // rust: if block_entity_known(be, k) {
    // rust: self.walk(Ty::BlockEntity, be);
}
}
}
    // rust: self.list_of_field(Ty::BlockName, v, "TileTicks", "i");
    // rust: if let Some(Tag::List(sections)) = v.get_mut("Sections") {
    // rust: for s in sections {
    // rust: if k >= key(2832, 0) {
    // rust: if let Some(b) = s.get_mut("biomes") {
    // rust: self.list(Ty::Biome, b, "palette");
}
    // rust: if let Some(b) = s.get_mut("block_states") {
    // rust: self.list(Ty::BlockState, b, "palette");
}
    // rust: } else if k >= key(1451, 1) {
    // rust: self.list(Ty::BlockState, s, "Palette");
}
}
}
    // rust: if k >= key(1466, 0)
    // rust: && let Some(s) = v.get_mut("Structures")
    // rust: {
    // rust: self.values(Ty::StructureFeature, s, "Starts");
}
}

spawner :: proc(self: ^Self, v: ^Tag) {
}
    // rust: self.walk(Ty::UntaggedSpawner, v);
}

    // `UNTAGGED_SPAWNER` (V106, V2831).
untagged_spawner :: proc(self: ^Self, v: ^Tag) {
}
    // rust: if self.k < key(106, 0) {
    // rust: return;
}
    // rust: if self.k < key(2831, 0) {
    // rust: self.list_of_field(Ty::EntityTree, v, "SpawnPotentials", "Entity");
    // rust: self.field(Ty::EntityTree, v, "SpawnData");
    // rust: return;
}
    // rust: if let Some(Tag::List(items)) = v.get_mut("SpawnPotentials") {
    // rust: for p in items {
    // rust: if let Some(d) = p.get_mut("data") {
    // rust: self.field(Ty::EntityTree, d, "entity");
}
}
}
    // rust: if let Some(d) = v.get_mut("SpawnData") {
    // rust: self.field(Ty::EntityTree, d, "entity");
}
}

block_entity :: proc(self: ^Self, v: ^Tag) {
}
    // rust: let k = self.k;
    // rust: self.field(Ty::DataComponents, v, "components");
    // rust: let id = namespaced(&as_str(v.get("id")).unwrap_or_default());
    // rust: let named_inventory = |w: &mut Self, v: &mut Tag| {
    // rust: w.list(Ty::ItemStack, v, "Items");
    // rust: w.field(Ty::TextComponent, v, "CustomName");
}
    // rust: match id.as_str() {
    // rust: "minecraft:furnace" | "minecraft:smoker" | "minecraft:blast_furnace" => {
    // rust: named_inventory(self, v);
    // rust: self.keys(Ty::Recipe, v, "RecipesUsed");
}
    // rust: "minecraft:chest"
    // rust: | "minecraft:trapped_chest"
    // rust: | "minecraft:dispenser"
    // rust: | "minecraft:dropper"
    // rust: | "minecraft:hopper"
    // rust: | "minecraft:shulker_box"
    // rust: | "minecraft:brewing_stand"
    // rust: | "minecraft:barrel" => {
    // rust: named_inventory(self, v);
}
    // rust: "minecraft:crafter" if k >= key(3682, 0) => named_inventory(self, v),
    // rust: "minecraft:jukebox" => self.field(Ty::ItemStack, v, "RecordItem"),
    // rust: "minecraft:flower_pot" if k < key(1451, 5) => self.field(Ty::ItemName, v, "Item"),
    // rust: "minecraft:sign" | "minecraft:hanging_sign" => {
    // rust: for side in ["front_text", "back_text"] {
    // rust: if let Some(s) = v.get_mut(side) {
    // rust: self.list(Ty::TextComponent, s, "messages");
    // rust: self.list(Ty::TextComponent, s, "filtered_messages");
}
}
}
    // rust: "minecraft:mob_spawner" => self.spawner(v),
    // rust: "minecraft:piston" => self.field(Ty::BlockState, v, "blockState"),
    // rust: "minecraft:enchanting_table" | "minecraft:beacon" | "minecraft:banner" => {
    // rust: self.field(Ty::TextComponent, v, "CustomName");
}
    // rust: "minecraft:skull" => self.field(Ty::TextComponent, v, "custom_name"),
    // rust: "minecraft:command_block" => {
    // rust: self.field(Ty::TextComponent, v, "CustomName");
    // rust: self.field(Ty::TextComponent, v, "LastOutput");
}
    // rust: "minecraft:jigsaw" => self.field(Ty::FlatBlockState, v, "final_state"),
    // rust: "minecraft:campfire" | "minecraft:chiseled_bookshelf" => {
    // rust: self.list(Ty::ItemStack, v, "Items")
}
    // rust: "minecraft:shelf" if k >= key(4533, 0) => self.list(Ty::ItemStack, v, "Items"),
    // rust: "minecraft:lectern" => self.field(Ty::ItemStack, v, "Book"),
    // rust: "minecraft:beehive" => {
    // rust: if k >= key(3818, 0) {
    // rust: self.list_of_field(Ty::EntityTree, v, "bees", "entity_data");
    // rust: } else {
    // rust: self.list_of_field(Ty::EntityTree, v, "Bees", "EntityData");
}
}
    // rust: "minecraft:sculk_sensor" | "minecraft:sculk_shrieker" => {
    // rust: if let Some(l) = v.get_mut("listener")
    // rust: && let Some(e) = l.get_mut("event")
    // rust: {
    // rust: self.field(Ty::GameEventName, e, "game_event");
}
}
    // rust: "minecraft:decorated_pot" => {
    // rust: if k >= key(4996, 1) {
    // rust: if let Some(s) = v.get_mut("sherds") {
    // rust: for side in ["back", "left", "right", "front"] {
    // rust: self.field(Ty::ItemStack, s, side);
}
}
    // rust: } else if k >= key(3448, 0) {
    // rust: self.list(Ty::ItemName, v, "sherds");
    // rust: } else {
    // rust: self.list(Ty::ItemName, v, "shards");
}
    // rust: self.field(Ty::ItemStack, v, "item");
}
    // rust: "minecraft:brushable_block" | "minecraft:suspicious_sand" => {
    // rust: self.field(Ty::ItemStack, v, "item")
}
    // rust: "minecraft:trial_spawner" if k >= key(3689, 0) => {
    // rust: if let Some(Tag::List(items)) = v.get_mut("spawn_potentials") {
    // rust: for p in items {
    // rust: if let Some(d) = p.get_mut("data") {
    // rust: self.field(Ty::EntityTree, d, "entity");
}
}
}
    // rust: if let Some(d) = v.get_mut("spawn_data") {
    // rust: self.field(Ty::EntityTree, d, "entity");
}
}
    // rust: "minecraft:vault" if k >= key(3807, 0) => {
    // rust: if let Some(c) = v.get_mut("config") {
    // rust: self.field(Ty::ItemStack, c, "key_item");
}
    // rust: if let Some(c) = v.get_mut("server_data") {
    // rust: self.list(Ty::ItemStack, c, "items_to_eject");
}
    // rust: if let Some(c) = v.get_mut("shared_data") {
    // rust: self.field(Ty::ItemStack, c, "display_item");
}
}
    // rust: "minecraft:test_instance_block" if k >= key(4302, 0) => {
    // rust: if let Some(d) = v.get_mut("data") {
    // rust: self.field(Ty::TextComponent, d, "error_message");
}
    // rust: self.list_of_field(Ty::TextComponent, v, "errors", "text");
}
    // rust: _ => {}
}
}

item_stack :: proc(self: ^Self, v: ^Tag) {
}
    // rust: if self.k >= key(3818, 5) {
    // rust: self.field(Ty::ItemName, v, "id");
    // rust: self.field(Ty::DataComponents, v, "components");
    // rust: return;
}
    // rust: self.field(Ty::ItemName, v, "id");
    // rust: let Some(tag) = v.get_mut("tag") else {
    // rust: return;
}
    // rust: self.field(Ty::EntityTree, tag, "EntityTag");
    // rust: self.field(Ty::BlockEntity, tag, "BlockEntityTag");
    // rust: self.list(Ty::BlockName, tag, "CanDestroy");
    // rust: self.list(Ty::BlockName, tag, "CanPlaceOn");
    // rust: self.list(Ty::ItemStack, tag, "Items");
    // rust: self.list(Ty::ItemStack, tag, "ChargedProjectiles");
    // rust: self.list(Ty::TextComponent, tag, "pages");
    // rust: self.values(Ty::TextComponent, tag, "filtered_pages");
    // rust: if let Some(d) = tag.get_mut("display") {
    // rust: self.field(Ty::TextComponent, d, "Name");
    // rust: self.list(Ty::TextComponent, d, "Lore");
}
}

components :: proc(self: ^Self, v: ^Tag) {
}
    // rust: let k = self.k;
    // rust: if k < key(3818, 3) {
    // rust: return;
}
    // rust: let Tag::Compound(_) = v else {
    // rust: return;
}
    // rust: self.list_of_field(Ty::EntityTree, v, "minecraft:bees", "entity_data");
    // rust: self.field(Ty::BlockEntity, v, "minecraft:block_entity_data");
    // rust: self.list(Ty::ItemStack, v, "minecraft:bundle_contents");
    // rust: for c in ["minecraft:can_break", "minecraft:can_place_on"] {
    // rust: let Some(p) = v.get_mut(c) else {
    // rust: continue;
}
    // rust: if k >= key(4307, 0) {
                // A predicate or a list of them.
    // rust: if let Tag::List(items) = p {
    // rust: for item in items {
    // rust: self.blocks_predicate(item);
}
    // rust: } else {
    // rust: self.blocks_predicate(p);
}
    // rust: } else if let Some(Tag::List(items)) = p.get_mut("predicates") {
    // rust: for item in items {
    // rust: self.blocks_predicate(item);
}
}
}
    // rust: self.list(Ty::ItemStack, v, "minecraft:charged_projectiles");
    // rust: self.list_of_field(Ty::ItemStack, v, "minecraft:container", "item");
    // rust: self.field(Ty::EntityTree, v, "minecraft:entity_data");
    // rust: if k >= key(4996, 0) {
    // rust: if let Some(p) = v.get_mut("minecraft:pot_decorations") {
    // rust: for side in ["back", "left", "right", "front"] {
    // rust: self.field(Ty::ItemStack, p, side);
}
}
    // rust: } else {
    // rust: self.list(Ty::ItemName, v, "minecraft:pot_decorations");
}
    // rust: if k < key(4059, 0) {
    // rust: if let Some(f) = v.get_mut("minecraft:food") {
    // rust: self.field(Ty::ItemStack, f, "using_converts_to");
}
    // rust: } else {
    // rust: self.field(Ty::ItemStack, v, "minecraft:use_remainder");
    // rust: if let Some(e) = v.get_mut("minecraft:equippable")
    // rust: && let Some(a) = e.get_mut("allowed_entities")
    // rust: {
    // rust: if let Tag::List(_) = a {
    // rust: self.list_in(Ty::EntityName, a);
    // rust: } else {
    // rust: self.walk(Ty::EntityName, a);
}
}
    // rust: self.field(Ty::ItemStack, v, "minecraft:sulfur_cube_content");
}
    // rust: self.field(Ty::TextComponent, v, "minecraft:custom_name");
    // rust: self.field(Ty::TextComponent, v, "minecraft:item_name");
    // rust: self.list(Ty::TextComponent, v, "minecraft:lore");
    // rust: if let Some(b) = v.get_mut("minecraft:written_book_content")
    // rust: && let Some(Tag::List(pages)) = b.get_mut("pages")
    // rust: {
    // rust: for page in pages {
                // DSL.or({raw, filtered}, TEXT_COMPONENT): any compound is the filterable form.
    // rust: if let Tag::Compound(_) = page {
    // rust: self.field(Ty::TextComponent, page, "raw");
    // rust: self.field(Ty::TextComponent, page, "filtered");
    // rust: } else {
    // rust: self.walk(Ty::TextComponent, page);
}
}
}
}

blocks_predicate :: proc(self: ^Self, p: ^Tag) {
}
    // rust: if let Some(b) = p.get_mut("blocks") {
    // rust: if let Tag::List(_) = b {
    // rust: self.list_in(Ty::BlockName, b);
    // rust: } else {
    // rust: self.walk(Ty::BlockName, b);
}
}
}

text :: proc(self: ^Self, v: ^Tag) {
}
    // rust: let k = self.k;
    // rust: if k < key(4290, 0) {
    // rust: return;
}
    // rust: match v {
    // rust: Tag::List(_) => self.list_in(Ty::TextComponent, v),
    // rust: Tag::Compound(_) => {
    // rust: self.list(Ty::TextComponent, v, "extra");
    // rust: self.field(Ty::TextComponent, v, "separator");
    // rust: if k >= key(4292, 0) {
    // rust: if let Some(h) = v.get_mut("hover_event") {
    // rust: match as_str(h.get("action")).as_deref() {
    // rust: Some("show_text") => self.field(Ty::TextComponent, h, "value"),
    // rust: Some("show_item") => self.walk(Ty::ItemStack, h),
    // rust: Some("show_entity") => {
    // rust: self.field(Ty::EntityName, h, "id");
    // rust: self.field(Ty::TextComponent, h, "name");
}
    // rust: _ => {}
}
}
    // rust: } else if let Some(h) = v.get_mut("hoverEvent") {
    // rust: match as_str(h.get("action")).as_deref() {
    // rust: Some("show_text") => self.field(Ty::TextComponent, h, "contents"),
    // rust: Some("show_item") => {
    // rust: if let Some(c) = h.get_mut("contents") {
                                // DSL.or(ITEM_STACK, ITEM_NAME)
    // rust: if let Tag::Compound(_) = c {
    // rust: self.walk(Ty::ItemStack, c);
    // rust: } else {
    // rust: self.walk(Ty::ItemName, c);
}
}
}
    // rust: Some("show_entity") => {
    // rust: if let Some(c) = h.get_mut("contents") {
    // rust: self.field(Ty::EntityName, c, "type");
    // rust: self.field(Ty::TextComponent, c, "name");
}
}
    // rust: _ => {}
}
}
}
    // rust: _ => {}
}
}

    // `WORLD_GEN_SETTINGS` (V2832).
world_gen :: proc(self: ^Self, v: ^Tag) {
}
    // rust: if self.k < key(2551, 0) {
    // rust: return;
}
    // rust: let Some(Tag::Compound(dims)) = v.get_mut("dimensions") else {
    // rust: return;
}
    // rust: for dim in dims.values_mut() {
    // rust: let Some(g) = dim.get_mut("generator") else {
    // rust: continue;
}
    // rust: match as_str(g.get("type")).as_deref() {
    // rust: Some("minecraft:flat") => {
    // rust: if let Some(s) = g.get_mut("settings") {
    // rust: self.field(Ty::Biome, s, "biome");
    // rust: self.list_of_field(Ty::BlockName, s, "layers", "block");
}
}
    // rust: Some("minecraft:noise") => {
    // rust: if let Some(b) = g.get_mut("biome_source") {
    // rust: match as_str(b.get("type")).as_deref() {
    // rust: Some("minecraft:fixed") => self.field(Ty::Biome, b, "biome"),
    // rust: Some("minecraft:checkerboard") => self.list(Ty::Biome, b, "biomes"),
    // rust: _ => {}
}
}
    // rust: if let Some(s) = g.get_mut("settings")
    // rust: && let Tag::Compound(_) = s
    // rust: {
    // rust: self.field(Ty::BlockName, s, "default_block");
    // rust: self.field(Ty::BlockName, s, "default_fluid");
}
}
    // rust: _ => {}
}
}
}
}

// Block entity ids the schema at `k` knows (others are read as remainder).
block_entity_known :: proc(be: ^Tag, k: Key) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = namespaced(&as_str(be.get("id")).unwrap_or_default());
    // rust: if k < flat::END {
    // rust: return flat::legacy_block_entity_known(&id, k);
}
    // rust: let since = match id.as_str() {
    // rust: "minecraft:sculk_catalyst" => key(3076, 0),
    // rust: "minecraft:sculk_shrieker" => key(3078, 0),
    // rust: "minecraft:hanging_sign" => key(3202, 0),
    // rust: "minecraft:chiseled_bookshelf" => key(3204, 0),
    // rust: "minecraft:decorated_pot" => key(3327, 0),
    // rust: "minecraft:suspicious_sand" => return (key(3327, 0)..key(3438, 0)).contains(&k),
    // rust: "minecraft:crafter" => key(3682, 0),
    // rust: "minecraft:trial_spawner" => key(3689, 0),
    // rust: "minecraft:vault" => key(3807, 0),
    // rust: "minecraft:creaking_heart" => key(4071, 0),
    // rust: "minecraft:test_block" | "minecraft:test_instance_block" => key(4302, 0),
    // rust: "minecraft:copper_golem_statue" => key(4532, 0),
    // rust: "minecraft:shelf" => key(4533, 0),
    // rust: "minecraft:potent_sulfur" => key(4881, 0),
    // rust: "minecraft:bed" => return k < key(4885, 0),
    // rust: "minecraft:brushable_block" | "minecraft:calibrated_sculk_sensor" => key(3438, 0),
    // rust: _ => 0,
}
    // rust: k >= since && BLOCK_ENTITIES.contains(&id.as_str())
}

// Block entity types of the schemas from 1.20 on.
    // rust: const BLOCK_ENTITIES: &[&str] = &[
    // rust: "minecraft:furnace",
    // rust: "minecraft:chest",
    // rust: "minecraft:trapped_chest",
    // rust: "minecraft:ender_chest",
    // rust: "minecraft:jukebox",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:dropper",
    // rust: "minecraft:sign",
    // rust: "minecraft:mob_spawner",
    // rust: "minecraft:piston",
    // rust: "minecraft:brewing_stand",
    // rust: "minecraft:enchanting_table",
    // rust: "minecraft:end_portal",
    // rust: "minecraft:beacon",
    // rust: "minecraft:skull",
    // rust: "minecraft:daylight_detector",
    // rust: "minecraft:hopper",
    // rust: "minecraft:comparator",
    // rust: "minecraft:banner",
    // rust: "minecraft:structure_block",
    // rust: "minecraft:end_gateway",
    // rust: "minecraft:command_block",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:bed",
    // rust: "minecraft:conduit",
    // rust: "minecraft:barrel",
    // rust: "minecraft:smoker",
    // rust: "minecraft:blast_furnace",
    // rust: "minecraft:lectern",
    // rust: "minecraft:bell",
    // rust: "minecraft:jigsaw",
    // rust: "minecraft:campfire",
    // rust: "minecraft:beehive",
    // rust: "minecraft:sculk_sensor",
    // rust: "minecraft:sculk_catalyst",
    // rust: "minecraft:sculk_shrieker",
    // rust: "minecraft:hanging_sign",
    // rust: "minecraft:chiseled_bookshelf",
    // rust: "minecraft:decorated_pot",
    // rust: "minecraft:suspicious_sand",
    // rust: "minecraft:brushable_block",
    // rust: "minecraft:calibrated_sculk_sensor",
    // rust: "minecraft:crafter",
    // rust: "minecraft:trial_spawner",
    // rust: "minecraft:vault",
    // rust: "minecraft:creaking_heart",
    // rust: "minecraft:test_block",
    // rust: "minecraft:test_instance_block",
    // rust: "minecraft:copper_golem_statue",
    // rust: "minecraft:shelf",
    // rust: "minecraft:potent_sulfur",
    // rust: ];

// Visit every value of `target` under a `root`-typed value read with schema `k`.
walk :: proc(root: Ty, v: ^Tag, k: Key, target: Ty, f: ^dyn FnMut(^Tag) {
}
    // rust: Walker { k, target, f }.walk(root, v);
}
