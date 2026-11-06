//! Transpiled from Horizon Rust crate
package horizon_client_core_registries

import "core:fmt"
import "core:mem"
import "core:math"

// Registry contents and source state that commands validate and complete
// arguments against (what the server's registry access holds).
// use std::collections::BTreeMap;

// Registry contents and source state used to validate and complete arguments.
Registries :: struct {
    // Permission level of the command source.
    permission: u8,
    items: [dynamic]string,
    item_tags: [dynamic]string,
    // Block id -> (property, allowed values).
    blocks: BTreeMap<string,
    block_tags: [dynamic]string,
    // Entity types that `summon` can create.
    summonable: [dynamic]string,
    // Every entity type (selector `type=`).
    entity_types: [dynamic]string,
    effects: [dynamic]string,
    enchantments: [dynamic]string,
    structures: [dynamic]string,
    biomes: [dynamic]string,
    dimensions: [dynamic]string,
    clocks: [dynamic]string,
    timelines: [dynamic]string,
    time_markers: [dynamic]string,
    advancements: [dynamic]string,
    // Game rule name -> integer-valued.
    game_rules: Vec<(string,
    players: [dynamic]string,
    // A dedicated server's lists, for the completions of `/op`, `/deop`, `/pardon`, `/pardon-ip` and
    // `/whitelist`: the operators' names, the banned names and addresses, the whitelisted names.
    ops: [dynamic]string,
    banned_players: [dynamic]string,
    banned_ips: [dynamic]string,
    whitelisted: [dynamic]string,
    // `ClientSuggestionProvider.customCompletionSuggestions`: the extra chat
    // completions the server sent (ClientboundCustomChatCompletionsPacket),
    // each once.
    custom_completions: std::collections::BTreeSet<string>,
    // Scoreboard objective names, team names and tracked score holders.
    objectives: [dynamic]string,
    teams: [dynamic]string,
    tracked: [dynamic]string,
    // Loaded datapack functions (`ns:path`) and function tags (`ns:path`).
    functions: [dynamic]string,
    // `/data ... storage` ids.
    storages: [dynamic]string,
    // Boss bar ids and datapack predicate ids.
    bossbars: [dynamic]string,
    predicates: [dynamic]string,
    item_modifiers: [dynamic]string,
    schedules: [dynamic]string,
    stopwatches: [dynamic]string,
    recipes: [dynamic]string,
    sounds: [dynamic]string,
    damage_types: [dynamic]string,
    attributes: [dynamic]string,
    loot_tables: [dynamic]string,
    templates: [dynamic]string,
    random_sequences: [dynamic]string,
    datapacks_enabled: [dynamic]string,
    datapacks_disabled: [dynamic]string,
    function_tags: [dynamic]string,
    // The block the source is looking at (relevant coordinates).
    target_block: Option<[i32,
    // `ClientSuggestionProvider.getSelectedEntities`: the UUID of the
    // entity under the crosshair (`Entity.getStringUUID`), if any.
    selected_entities: [dynamic]string,
    // `ClientSuggestionProvider.getAbsoluteCoordinates`: the exact point of
    // that block hit, each coordinate as `%.2f` (`Locale.ROOT`).
    target_point: Option<[string,
    // Every registry's element and tag ids (`minecraft:item` -> ...), as
    // the server's registry access and reloadable registries hold them.
    by_registry: BTreeMap<string,
    // Blocks whose default state has a block entity.
    block_entities: std::collections::BTreeSet<string>,
    // Block tag -> member blocks.
    block_tag_members: BTreeMap<string,
    // Data component types with a codec (not transient).
    persistent_components: [dynamic]string,
    // Recipes `/recipe` can give (not special).
    learnable_recipes: [dynamic]string,
    // Advancement id -> criterion names.
    advancement_criteria: BTreeMap<string,
    // World clock -> time markers shown in commands.
    clock_time_markers: BTreeMap<string,
    // Trigger objectives the source may use (`/trigger` suggestions).
    trigger_objectives: [dynamic]string,
    // Objectives with the `trigger` criterion -> holder -> whether its score is locked.
    trigger_scores: BTreeMap<string,
}
// The ids and tag ids of one registry.
RegistryIds :: struct {
    ids: [dynamic]string,
    tags: [dynamic]string,
}
EMPTY :: &[]
// ClientboundCustomChatCompletionsPacket.Action.
CustomCompletionAction :: enum {
    Add,
    Remove,
    Set,
}
    // rust: impl CustomCompletionAction {
    // `Action.BY_ID`: `ByIdMap.continuous` with `OutOfBoundsStrategy.ZERO`,
    // so an unknown id is `ADD`.
from_id :: proc(id: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: 1 => Self::Remove,
    // rust: 2 => Self::Set,
    // rust: _ => Self::Add,
}
}
}
// `ClientSuggestionProvider.modifyCustomCompletions`: the server adds,
// removes or replaces the extra chat completions.
    // rust: pub fn modify_custom_completions(
    // rust: set: &mut std::collections::BTreeSet<String>,
    // rust: action: CustomCompletionAction,
    // rust: entries: &[String],
    // rust: ) {
    // rust: match action {
    // rust: CustomCompletionAction::Add => set.extend(entries.iter().cloned()),
    // rust: CustomCompletionAction::Remove => {
    // rust: for e in entries {
    // rust: set.remove(e);
}
}
    // rust: CustomCompletionAction::Set => {
    // rust: set.clear();
    // rust: set.extend(entries.iter().cloned());
}
}
}
    // rust: impl Registries {
    // `ClientSuggestionProvider.getCustomTabSuggestions`: what chat (not a
    // command) completes, the online players' names with the server's custom
    // completions, each once.
custom_tab_suggestions :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.players
    // rust: .iter()
    // rust: .chain(&self.custom_completions)
    // rust: .map(String::as_str)
    // rust: .collect()
}
    // Fill what the game did not build itself from vanilla's exported
    // registries (`command-registries.json`, written by
    // `VanillaCommandParseOracle registries`): built-in registries such as
    // mob effects, data component types and dialogs, block entities and tag
    // members. Registries that data packs reload stay with the game.
fill_from_export :: proc(self: ^Self, r: ^serde_json::Value) {
}
strings :: proc(v: ^serde_json::Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: v.as_array()
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .filter_map(|x| x.as_str().map(str::to_owned))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default()
}
    // rust: let fill = |field: &mut Vec<String>, key: &str| {
    // rust: if field.is_empty() {
    // rust: *field = strings(&r[key]);
}
}
    // rust: fill(&mut self.effects, "effects");
    // rust: fill(&mut self.enchantments, "enchantments");
    // rust: fill(&mut self.attributes, "attributes");
    // rust: fill(&mut self.damage_types, "damage_types");
    // rust: fill(&mut self.templates, "templates");
    // rust: fill(&mut self.persistent_components, "persistent_components");
    // rust: fill(&mut self.learnable_recipes, "learnable_recipes");
    // rust: if self.summonable.is_empty() {
    // rust: self.summonable = strings(&r["summonable"]);
    // rust: self.summonable.sort();
    // rust: self.summonable.dedup();
}
    // rust: if self.entity_types.is_empty() {
    // rust: self.entity_types = strings(&r["entity_types"]);
    // rust: self.entity_types.sort();
    // rust: self.entity_types.dedup();
}
    // rust: const RELOADED: [&str; 5] = [
    // rust: "minecraft:advancement",
    // rust: "minecraft:recipe",
    // rust: "minecraft:loot_table",
    // rust: "minecraft:predicate",
    // rust: "minecraft:item_modifier",
    // rust: ];
    // rust: for (name, entry) in r["by_registry"].as_object().into_iter().flatten() {
    // rust: if RELOADED.contains(&name.as_str()) || self.by_registry.contains_key(name) {
    // rust: continue;
}
    // rust: self.by_registry.insert(
    // rust: name.clone(),
    // rust: RegistryIds {
    // rust: ids: strings(&entry["ids"]),
    // rust: tags: strings(&entry["tags"]),
    // rust: },
    // rust: );
}
    // rust: if self.block_entities.is_empty() {
    // rust: self.block_entities = strings(&r["block_entities"]).into_iter().collect();
}
    // rust: if self.block_tag_members.is_empty() {
    // rust: for (tag, members) in r["block_tag_members"].as_object().into_iter().flatten() {
    // rust: self.block_tag_members.insert(tag.clone(), strings(members));
}
}
    // rust: if self.clock_time_markers.is_empty() {
    // rust: for (clock, markers) in r["clock_time_markers"].as_object().into_iter().flatten() {
    // rust: self.clock_time_markers
    // rust: .insert(clock.clone(), strings(markers));
}
}
    // rust: if self.advancement_criteria.is_empty() {
    // rust: for (id, criteria) in r["advancement_criteria"].as_object().into_iter().flatten() {
    // rust: self.advancement_criteria
    // rust: .insert(id.clone(), strings(criteria));
}
}
}
    // Only what [`Self::fill_from_export`] takes from an export, to keep
    // in place of the export itself (a third of its memory).
from_export :: proc(r: ^serde_json::Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Self::default();
    // rust: out.fill_from_export(r);
    // rust: out
}
    // [`Self::fill_from_export`] from an export already read with
    // [`Self::from_export`]: each field the game left empty, each registry
    // it did not list.
fill_from_exported :: proc(self: ^Self, e: ^Self) {
}
    // rust: let fill = |field: &mut Vec<String>, from: &Vec<String>| {
    // rust: if field.is_empty() {
    // rust: field.clone_from(from);
}
}
    // rust: fill(&mut self.effects, &e.effects);
    // rust: fill(&mut self.enchantments, &e.enchantments);
    // rust: fill(&mut self.attributes, &e.attributes);
    // rust: fill(&mut self.damage_types, &e.damage_types);
    // rust: fill(&mut self.templates, &e.templates);
    // rust: fill(&mut self.persistent_components, &e.persistent_components);
    // rust: fill(&mut self.learnable_recipes, &e.learnable_recipes);
    // rust: if self.summonable.is_empty() {
    // rust: self.summonable.clone_from(&e.summonable);
    // rust: self.summonable.sort();
    // rust: self.summonable.dedup();
}
    // rust: if self.entity_types.is_empty() {
    // rust: self.entity_types.clone_from(&e.entity_types);
    // rust: self.entity_types.sort();
    // rust: self.entity_types.dedup();
}
    // rust: for (name, ids) in &e.by_registry {
    // rust: if !self.by_registry.contains_key(name) {
    // rust: self.by_registry.insert(name.clone(), ids.clone());
}
}
    // rust: if self.block_entities.is_empty() {
    // rust: self.block_entities.clone_from(&e.block_entities);
}
    // rust: if self.block_tag_members.is_empty() {
    // rust: self.block_tag_members.clone_from(&e.block_tag_members);
}
    // rust: if self.clock_time_markers.is_empty() {
    // rust: self.clock_time_markers.clone_from(&e.clock_time_markers);
}
    // rust: if self.advancement_criteria.is_empty() {
    // rust: self.advancement_criteria
    // rust: .clone_from(&e.advancement_criteria);
}
}
    // The element ids of a registry (sorted).
ids :: proc(self: ^Self, registry: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(r) = self.by_registry.get(registry) {
    // rust: return &r.ids;
}
    // rust: match registry {
    // rust: "minecraft:item" => &self.items,
    // rust: "minecraft:entity_type" => &self.entity_types,
    // rust: "minecraft:mob_effect" => &self.effects,
    // rust: "minecraft:enchantment" => &self.enchantments,
    // rust: "minecraft:worldgen/structure" => &self.structures,
    // rust: "minecraft:worldgen/biome" => &self.biomes,
    // rust: "minecraft:world_clock" => &self.clocks,
    // rust: "minecraft:timeline" => &self.timelines,
    // rust: "minecraft:attribute" => &self.attributes,
    // rust: "minecraft:damage_type" => &self.damage_types,
    // rust: "minecraft:sound_event" => &self.sounds,
    // rust: "minecraft:predicate" => &self.predicates,
    // rust: "minecraft:item_modifier" => &self.item_modifiers,
    // rust: "minecraft:loot_table" => &self.loot_tables,
    // rust: "minecraft:recipe" => &self.recipes,
    // rust: "minecraft:advancement" => &self.advancements,
    // rust: _ => EMPTY,
}
}
    // The tag ids of a registry (sorted).
tags :: proc(self: ^Self, registry: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(r) = self.by_registry.get(registry) {
    // rust: return &r.tags;
}
    // rust: match registry {
    // rust: "minecraft:item" => &self.item_tags,
    // rust: "minecraft:block" => &self.block_tags,
    // rust: _ => EMPTY,
}
}
}
