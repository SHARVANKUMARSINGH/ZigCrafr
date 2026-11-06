//! Transpiled from Horizon Rust crate
package horizon_client_data

import "core:fmt"
import "core:mem"
import "core:math"

// Facts the mob AI and renderer read from vanilla code, exported by
// `VanillaMobDataExporter` into `mob-data.json`: per-state pathfinding types
// (`WalkNodeEvaluator.getPathTypeFromState` with vanilla's tags bound),
// pathfindability, spawn-surface predicates, collision tops, each entity
// type's spawn placement and the client's keyframe animation definitions.
// use super::keyframes::Animation;
// use super::path::PathType;
// use crate::blocks::{BlockFacts, Fluid};
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path};

LAND :: 1
WATER :: 2
AIR :: 4
// `isValidSpawn` for a typical monster (zombie).
VALID_SPAWN :: 8
// `isValidSpawn` for ocelots/parrots (leaves allowed).
VALID_SPAWN_LEAVES :: 16
// `isValidSpawn` for polar bears (ice allowed).
VALID_SPAWN_ICE :: 32
REDSTONE_CONDUCTOR :: 64
// `NaturalSpawner.isValidEmptySpawnBlock` for a zombie.
VALID_EMPTY_SPAWN :: 128
STURDY_TOP :: 256
// BlockState.isSolid
SOLID :: 512
SOLID_RENDER :: 1024

StateData :: struct {
    path: PathType,
    flags: u16,
    // Collision shape top (0 when the shape is empty).
    top: f32,
}
Placement :: enum {
    OnGround,
    InWater,
    InLava,
    NoRestrictions,
}
MobData :: struct {
    states: [dynamic]StateData,
    placements: HashMap<string,
    // Each entity type's `SpawnPlacements.getHeightmapType`.
    heightmaps: HashMap<string,
    animations: HashMap<string,
    // Replaced when the resource packs change (the rest of `MobData` never is).
    villager_hats: std::sync::RwLock<super::villager_hats::VillagerHats>,
    // The packs' custom entity models (OptiFine CEM); replaced when the resource packs change.
    cem: std::sync::RwLock<std::sync::^super::cem::CemModels>,
    // The packs' random entity textures, replaced with them too.
    random_textures: std::sync::RwLock<horizon_optifine::random_textures::RandomTextures>,
    // The packs' emissive overlays of entity textures, replaced with them too.
    emissive: std::sync::RwLock<std::sync::^horizon_optifine::emissive::Emissive>,
    // ETF's blinking textures, replaced with the packs too.
    blinks: std::sync::RwLock<horizon_optifine::blink::Blinks>,
    // Biome tags (spawns_warm_variant_farm_animals, is_ocean...) by tag id.
    biome_tags: HashMap<string,
    // Entity type tags (`data/*/tags/entity_type`).
    entity_tags: HashMap<string,
    // The villager POI type of every block state (`PoiTypes.forState`),
    // worked out the first time a villager looks for one.
    pois: std::sync::OnceLock<[dynamic]Maybe(super::villager_brain::Poi)>,
    // [`MobData::placement`] of each species' entity type (by `Species as
    // usize`), worked out the first time a spawn asks.
    species_placements: std::sync::OnceLock<[dynamic]Placement>,
}
    // rust: impl MobData {
load :: proc(root: ^Path, facts: ^BlockFacts) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let parsed: Option<Value> = fs::read(root.join("mob-data.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok());
    // rust: let mut data = match parsed {
    // rust: Some(v)
    // rust: if v["states"]
    // rust: .as_array()
    // rust: .is_some_and(|a| a.len() == facts.states.len()) =>
    // rust: {
    // rust: Self::from_json(&v)
}
    // rust: _ => Self::fallback(facts),
}
    // rust: data.biome_tags = crate::items::load_tags(
    // rust: root,
    // rust: "worldgen/biome",
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap_or_default();
    // rust: data.entity_tags =
    // rust: crate::items::load_tags(root, "entity_type", &horizon_world::loot::PackOverlay::NONE)
    // rust: .unwrap_or_default();
    // rust: data.villager_hats = std::sync::RwLock::new(super::villager_hats::VillagerHats::load(root));
    // rust: let random = horizon_optifine::random_textures::RandomTextures::scan(root);
    // rust: let blinks = horizon_optifine::blink::Blinks::scan(root, &random);
    // rust: let mut emissive = horizon_optifine::emissive::Emissive::scan(root, &random);
    // rust: emissive.pair_beside(root, blinks.files());
    // rust: data.emissive = std::sync::RwLock::new(std::sync::Arc::new(emissive));
    // rust: data.blinks = std::sync::RwLock::new(blinks);
    // rust: data.random_textures = std::sync::RwLock::new(random);
    // rust: data
}
    // Only the keyframe animation definitions of `mob-data.json`.
load_animations :: proc(root: ^Path) -> H {
    // Ported from Horizon
    return {}
}
    // rust: fs::read(root.join("mob-data.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: .map(|v| Self::from_json(&v).animations)
    // rust: .unwrap_or_default()
}
entity_has :: proc(self: ^Self, tag: string, entity: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.entity_tags
    // rust: .get(tag)
    // rust: .is_some_and(|s| s.contains(entity))
}
biome_has :: proc(self: ^Self, tag: string, biome: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.biome_tags.get(tag).is_some_and(|s| s.contains(biome))
}
from_json :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let states = v["states"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|s| StateData {
    // rust: path: PathType::from_name(s[0].as_str().unwrap_or("BLOCKED")),
    // rust: flags: s[1].as_u64().unwrap_or(0) as u16,
    // rust: top: s[2].as_f64().unwrap_or(0.0) as f32,
    // rust: })
    // rust: .collect();
    // rust: let placements = v["placements"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(k, p)| {
    // rust: let placement = match p["placement"].as_str() {
    // rust: Some("on_ground") => Placement::OnGround,
    // rust: Some("in_water") => Placement::InWater,
    // rust: Some("in_lava") => Placement::InLava,
    // rust: _ => Placement::NoRestrictions,
}
    // rust: (k.clone(), placement)
    // rust: })
    // rust: .collect();
    // rust: let heightmaps = v["placements"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|(k, p)| Some((k.clone(), p["heightmap"].as_str()?.to_owned())))
    // rust: .collect();
    // rust: let animations = v["animations"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(k, a)| (k.clone(), Animation::parse(a)))
    // rust: .collect();
    // rust: Self {
    // rust: states,
    // rust: placements,
    // rust: heightmaps,
    // rust: animations,
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: biome_tags: HashMap::new(),
    // rust: entity_tags: HashMap::new(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
}
    // Without the export, approximate path types from the gameplay facts.
fallback :: proc(facts: ^BlockFacts) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let states = facts
    // rust: .states
    // rust: .iter()
    // rust: .map(|f| {
    // rust: let name = &*f.name;
    // rust: let path = if matches!(
    // rust: name,
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: ) {
    // rust: PathType::Open
    // rust: } else if f.fluid == Fluid::Lava && !f.waterlogged {
    // rust: PathType::Lava
    // rust: } else if name.ends_with("fence") || name.ends_with("_wall") {
    // rust: PathType::Fence
    // rust: } else if name.ends_with("leaves") {
    // rust: PathType::Leaves
    // rust: } else if name == "minecraft:fire" || name == "minecraft:magma_block" {
    // rust: PathType::Fire
    // rust: } else if f.full_collision {
    // rust: PathType::Blocked
    // rust: } else if f.fluid == Fluid::Water {
    // rust: PathType::Water
    // rust: } else {
    // rust: PathType::Open
}
    // rust: let mut flags = 0;
    // rust: if !f.full_collision {
    // rust: flags |= LAND | AIR | VALID_EMPTY_SPAWN;
}
    // rust: if f.fluid == Fluid::Water {
    // rust: flags |= WATER;
}
    // rust: if f.full_collision {
    // rust: flags |=
    // rust: VALID_SPAWN | VALID_SPAWN_ICE | REDSTONE_CONDUCTOR | STURDY_TOP | SOLID;
}
    // rust: StateData {
    // rust: path,
    // rust: flags,
    // rust: top: if f.full_collision { 1.0 } else { 0.0 },
}
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: states,
    // rust: placements: HashMap::new(),
    // rust: heightmaps: HashMap::new(),
    // rust: animations: HashMap::new(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: biome_tags: HashMap::new(),
    // rust: entity_tags: HashMap::new(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
}
state :: proc(self: ^Self, id: horizon_world::registry::BlockStateId) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(StateData {
    // rust: path: PathType::Blocked,
    // rust: flags: 0,
    // rust: top: 1.0,
    // rust: })
}
    // `SpawnPlacements.getHeightmapType` (MOTION_BLOCKING_NO_LEAVES unless registered).
heightmap :: proc(self: ^Self, entity: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.heightmaps
    // rust: .get(entity)
    // rust: .map_or("MOTION_BLOCKING_NO_LEAVES", String::as_str)
}
placement :: proc(self: ^Self, entity: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.placements
    // rust: .get(entity)
    // rust: .copied()
    // rust: .unwrap_or(Placement::OnGround)
}
    // [`MobData::placement`] of the species' entity type, without building
    // its id: natural spawning asks it for every position it tries.
species_placement :: proc(self: ^Self, s: super::Species) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let table = self.species_placements.get_or_init(|| {
    // rust: let defs = super::species::ALL;
    // rust: let len = defs
    // rust: .iter()
    // rust: .map(|d| d.species as usize + 1)
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: let mut table = vec![Placement::OnGround; len];
            // `species::def` takes a species' first definition: so does this.
    // rust: for d in defs.iter().rev() {
    // rust: table[d.species as usize] = self.placement(&format!("minecraft:{}", d.name));
}
    // rust: table
    // rust: });
    // rust: table.get(s as usize).copied().unwrap_or_else(|| {
    // rust: self.placement(&format!("minecraft:{}", super::species::def(s).name))
    // rust: })
}
}
