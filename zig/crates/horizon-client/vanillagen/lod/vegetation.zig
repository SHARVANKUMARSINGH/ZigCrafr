//! Transpiled from Horizon Rust crate
//! Module: horizon-client_vegetation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Seed-stable visual vegetation from the world's own feature data: trees, and
//! the End's chorus plants.
//! shortcut: these positions approximate native placement; saved/visited and
//! completed native chunks replace them rather than changing gameplay worldgen.
// use crate::{
    // rust: fast_hash::FxHashMap,
    // rust: lod::{Column, Span, Surface},
}
// use horizon_world::{
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::generator::GeneratorData,
}
// use serde_json::Value;

/// The widest LOD cell that draws chorus: a cell is drawn as a full-footprint
/// column, so a one-block plant in a wider cell would read as a coloured slab.
pub const CHORUS_CELL: i32 = 4;

pub const Tree = struct {
    leaves: BlockStateId,
    log: BlockStateId,
    height: i32,
    variation: i32,
    radius: i32,
    count: f64,
};
pub const Chorus = struct {
    plant: BlockStateId,
    flower: BlockStateId,
    /// Expected plants per chunk (`minecraft:chorus_plant`'s placement).
    count: f64,
};
    // rust: pub(super) struct Vegetation {
    // rust: trees: FxHashMap<u16, Vec<Tree>>,
    // rust: chorus: FxHashMap<u16, Chorus>,
    // rust: seed: u64,
    // rust: registry: &'static BlockRegistry,
}
pub fn mean(v: *Value) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(n) = v.as_f64() {
    // rust: return n;
}
    // rust: let distribution = v["distribution"].as_array();
    // rust: if let Some(entries) = distribution {
    // rust: let total: f64 = entries
    // rust: .iter()
    // rust: .map(|e| e["weight"].as_f64().unwrap_or(0.))
    // rust: .sum();
    // rust: if total > 0. {
    // rust: return entries
    // rust: .iter()
    // rust: .map(|e| mean(&e["data"]) * e["weight"].as_f64().unwrap_or(0.))
    // rust: .sum::<f64>()
    // rust: / total;
}
}
    // rust: (v["min_inclusive"].as_f64().unwrap_or(0.) + v["max_inclusive"].as_f64().unwrap_or(0.)) * 0.5
}
pub fn block(v: *Value, registry: *BlockRegistry) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = v
    // rust: .as_str()
    // rust: .or_else(|| v["id"].as_str())
    // rust: .or_else(|| v["Name"].as_str())?;
    // rust: registry.default_state(name)
}
    // rust: fn gather(
    // rust: data: &GeneratorData,
    // rust: value: &Value,
    // rust: placed: bool,
    // rust: count: f64,
    // rust: depth: usize,
    // rust: out: &mut Vec<Tree>,
    // rust: chorus: &mut Option<Chorus>,
    // rust: ) {
    // rust: if depth > 12 || count <= 0. {
    // rust: return;
}
    // rust: if let Some(name) = value.as_str() {
    // rust: let json = if placed {
    // rust: data.placed_feature_json(name)
    // rust: } else {
    // rust: data.configured_feature_json(name)
}
    // rust: if let Some(json) = json.and_then(|s| serde_json::from_str::<Value>(s).ok()) {
    // rust: gather(data, &json, placed, count, depth + 1, out, chorus);
}
    // rust: return;
}
    // rust: if placed {
    // rust: let mut count = count;
    // rust: if let Some(modifiers) = value["placement"].as_array() {
    // rust: for modifier in modifiers {
    // rust: match modifier["type"]
    // rust: .as_str()
    // rust: .unwrap_or("")
    // rust: .strip_prefix("minecraft:")
    // rust: .unwrap_or("")
    // rust: {
    // rust: "count" | "count_on_every_layer" => count *= mean(&modifier["count"]),
    // rust: "rarity_filter" => count /= modifier["chance"].as_f64().unwrap_or(1.).max(1.),
    // rust: "count_extra" => {
    // rust: count *= modifier["count"].as_f64().unwrap_or(0.)
    // rust: + modifier["extra_count"].as_f64().unwrap_or(0.)
    // rust: * modifier["extra_chance"].as_f64().unwrap_or(0.)
}
    // rust: _ => {}
}
}
}
    // rust: gather(
    // rust: data,
    // rust: &value["feature"],
    // rust: false,
    // rust: count,
    // rust: depth + 1,
    // rust: out,
    // rust: chorus,
    // rust: );
    // rust: return;
}
    // rust: let config = if value["config"].is_object() {
    // rust: &value["config"]
    // rust: } else {
    // rust: value
}
    // rust: match value["type"].as_str().unwrap_or("") {
    // rust: "minecraft:chorus_plant" => {
            // A stateless feature: the tip is always a fully grown flower, and
            // the trunk height (2..=5) is a property of its block behaviour.
    // rust: let registry = data.registry();
    // rust: let (Some(plant), Some(base)) = (
    // rust: registry.default_state("minecraft:chorus_plant"),
    // rust: registry.default_state("minecraft:chorus_flower"),
    // rust: ) else {
    // rust: return;
}
    // rust: let Some(mut state) = registry.state(base).cloned() else {
    // rust: return;
}
    // rust: state.properties.insert("age".into(), "5".into());
    // rust: let Some(flower) = registry.id(&state) else {
    // rust: return;
}
    // rust: match chorus {
    // rust: Some(existing) => existing.count += count,
    // rust: None => {
    // rust: *chorus = Some(Chorus {
    // rust: plant,
    // rust: flower,
    // rust: count,
    // rust: })
}
}
}
    // rust: "minecraft:tree" => {
    // rust: let (Some(leaves), Some(log)) = (
    // rust: block(&config["foliage_provider"], data.registry()),
    // rust: block(&config["trunk_provider"], data.registry()),
    // rust: ) else {
    // rust: return;
}
    // rust: let trunk = &config["trunk_placer"];
    // rust: out.push(Tree {
    // rust: leaves,
    // rust: log,
    // rust: height: trunk["base_height"].as_i64().unwrap_or(5) as i32,
    // rust: variation: (trunk["height_rand_a"].as_i64().unwrap_or(0)
    // rust: + trunk["height_rand_b"].as_i64().unwrap_or(0))
    // rust: as i32,
    // rust: radius: mean(&config["foliage_placer"]["radius"])
    // rust: .round()
    // rust: .clamp(2., 6.) as i32,
    // rust: count,
    // rust: });
}
    // rust: "minecraft:random_selector" => {
    // rust: let mut remaining = count;
    // rust: if let Some(features) = config["features"].as_array() {
    // rust: for entry in features {
    // rust: let chance = entry["chance"].as_f64().unwrap_or(0.).clamp(0., 1.);
    // rust: gather(
    // rust: data,
    // rust: &entry["feature"],
    // rust: true,
    // rust: remaining * chance,
    // rust: depth + 1,
    // rust: out,
    // rust: chorus,
    // rust: );
    // rust: remaining *= 1. - chance;
}
}
    // rust: gather(
    // rust: data,
    // rust: &config["default"],
    // rust: true,
    // rust: remaining,
    // rust: depth + 1,
    // rust: out,
    // rust: chorus,
    // rust: );
}
    // rust: "minecraft:random_boolean_selector" => {
    // rust: for key in ["feature_true", "feature_false"] {
    // rust: gather(
    // rust: data,
    // rust: &config[key],
    // rust: true,
    // rust: count * 0.5,
    // rust: depth + 1,
    // rust: out,
    // rust: chorus,
    // rust: );
}
}
    // rust: "minecraft:simple_random_selector" => {
    // rust: if let Some(features) = config["features"].as_array() {
    // rust: for feature in features {
    // rust: gather(
    // rust: data,
    // rust: feature,
    // rust: true,
    // rust: count / features.len().max(1) as f64,
    // rust: depth + 1,
    // rust: out,
    // rust: chorus,
    // rust: );
}
}
}
    // rust: _ => {}
}
}
    // rust: pub(super) fn hash(seed: u64, x: i32, z: i32) -> u64 {
    // rust: let mut n = seed
    // rust: ^ (x as u64).wrapping_mul(0x9e3779b97f4a7c15)
    // rust: ^ (z as u64).wrapping_mul(0xd1b54a32d192ed03);
    // rust: n = (n ^ n >> 30).wrapping_mul(0xbf58476d1ce4e5b9);
    // rust: n = (n ^ n >> 27).wrapping_mul(0x94d049bb133111eb);
    // rust: n ^ n >> 31
}
/// The chorus plant whose root falls in this output cell: its height, or none.
/// `count` is per chunk, so a 4×4 cell holds one with probability `count/16`;
/// a wider cell scans the cells it covers and keeps the expected density.
pub fn chorus_at(seed: u64, count: f64, x: i32, z: i32, width: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width > CHORUS_CELL || count <= 0. {
    // rust: return None;
}
    // rust: let probability = (count / 16.).min(1.);
    // rust: for cz in z.div_euclid(4)..=(z + width - 1).div_euclid(4) {
    // rust: for cx in x.div_euclid(4)..=(x + width - 1).div_euclid(4) {
    // rust: let n = hash(seed, cx, cz);
    // rust: if (n as u32 as f64 / u32::MAX as f64) >= probability {
    // rust: continue;
}
    // rust: let tx = cx * 4 + ((n >> 32) & 3) as i32;
    // rust: let tz = cz * 4 + ((n >> 34) & 3) as i32;
    // rust: if tx < x || tx >= x + width || tz < z || tz >= z + width {
    // rust: continue;
}
    // rust: return Some(2 + ((n >> 40) % 4) as i32);
}
}
    // rust: None
}
    // rust: impl Vegetation {
    // rust: pub(super) fn new(data: &GeneratorData, map: &[u16], seed: i64) -> Self {
    // rust: let mut trees = FxHashMap::default();
    // rust: let mut chorus = FxHashMap::default();
    // rust: for (index, &biome) in map.iter().enumerate() {
    // rust: let Ok(json) = serde_json::from_str::<Value>(
    // rust: data.biome_json(horizon_world::worldgen::biome::BiomeId(index as u32)),
    // rust: ) else {
    // rust: continue;
}
    // rust: let mut list = Vec::new();
    // rust: let mut plant = None;
    // rust: if let Some(steps) = json["features"].as_array() {
    // rust: for step in steps {
    // rust: if let Some(features) = step.as_array() {
    // rust: for feature in features {
    // rust: gather(data, feature, true, 1., 0, &mut list, &mut plant);
}
}
}
}
    // rust: if !list.is_empty() {
    // rust: trees.insert(biome, list);
}
    // rust: if let Some(plant) = plant {
    // rust: chorus.insert(biome, plant);
}
}
    // rust: Self {
    // rust: trees,
    // rust: chorus,
    // rust: seed: seed as u64,
    // rust: registry: data.registry(),
}
}
    // rust: pub(super) fn apply(&self, column: &mut Column, x: i32, z: i32, width: i32, light: u16) {
    // rust: let Some(surface) = column.surface else {
    // rust: return;
}
    // rust: if surface.water.is_some_and(|(y, _)| y >= surface.height) {
    // rust: return;
}
    // rust: let ground = self
    // rust: .registry
    // rust: .state(surface.state)
    // rust: .map_or("", |s| s.name.as_str());
    // rust: if ground == "minecraft:end_stone" {
    // rust: self.apply_chorus(column, surface, x, z, width, light);
    // rust: return;
}
    // rust: if !matches!(
    // rust: ground,
    // rust: "minecraft:grass_block"
    // rust: | "minecraft:dirt"
    // rust: | "minecraft:coarse_dirt"
    // rust: | "minecraft:podzol"
    // rust: | "minecraft:mycelium"
    // rust: | "minecraft:rooted_dirt"
    // rust: | "minecraft:moss_block"
    // rust: ) {
    // rust: return;
}
    // rust: let Some(trees) = self.trees.get(&surface.biome) else {
    // rust: return;
}
    // rust: let total: f64 = trees.iter().map(|tree| tree.count).sum();
    // rust: let choose = |n: u64| {
    // rust: let mut value = (n as u32 as f64 / u32::MAX as f64) * total;
    // rust: for tree in trees {
    // rust: value -= tree.count;
    // rust: if value <= 0. {
    // rust: return tree;
}
}
    // rust: &trees[trees.len() - 1]
}
    // rust: let mut best = None;
    // rust: if width >= 16 {
    // rust: let n = hash(self.seed, x.div_euclid(4), z.div_euclid(4));
    // rust: let tree = choose(n);
    // rust: let coverage = 1.
    // rust: - (-total * f64::from(tree.radius * tree.radius) * std::f64::consts::PI / 256.)
    // rust: .exp();
    // rust: if coverage >= 0.25 {
    // rust: let height = tree.height + ((n >> 32) & 1) as i32;
                // The cell's representative tree stands in it: its trunk
                // is drawn under the crown.
    // rust: best = Some((
    // rust: surface.height + height.max(4),
    // rust: surface.height + height.max(4) - tree.radius * 2,
    // rust: *tree,
    // rust: true,
    // rust: ));
}
    // rust: } else {
    // rust: let radius = trees.iter().map(|t| t.radius).max().unwrap_or(2);
    // rust: for cz in (z - radius).div_euclid(4)..=(z + radius).div_euclid(4) {
    // rust: for cx in (x - radius).div_euclid(4)..=(x + radius).div_euclid(4) {
    // rust: let n = hash(self.seed, cx, cz);
    // rust: if (n as u32 as f64 / u32::MAX as f64) >= (total / 16.).min(1.) {
    // rust: continue;
}
    // rust: let tree = *choose(n.rotate_left(21));
    // rust: let tx = cx * 4 + ((n >> 32) & 3) as i32;
    // rust: let tz = cz * 4 + ((n >> 34) & 3) as i32;
    // rust: let d2 = (x - tx).pow(2) + (z - tz).pow(2);
    // rust: if d2 > tree.radius.pow(2) {
    // rust: continue;
}
    // rust: let height =
    // rust: tree.height + ((n >> 40) % (tree.variation.max(0) + 1) as u64) as i32;
    // rust: let cap = ((tree.radius.pow(2) - d2) as f32).sqrt().ceil() as i32;
    // rust: let top = surface.height + height + cap.min(2);
    // rust: let bottom = surface.height + height - tree.radius;
                    // `x`, `z` are the cell's centre: its trunk is the
                    // cell's if it stands anywhere in the cell.
    // rust: let (x0, z0) = (x - width / 2, z - width / 2);
    // rust: let inside = (x0..x0 + width).contains(&tx) && (z0..z0 + width).contains(&tz);
    // rust: if best.as_ref().is_none_or(|&(y, _, _, _)| top > y) {
    // rust: best = Some((top, bottom, tree, inside));
}
}
}
}
    // rust: if let Some((top, bottom, tree, trunk)) = best {
            // In a cell wider than a block, a crown whose trunk stands in
            // another cell reaches down to the ground, as reducing real
            // chunks fills it (`Column::reduced`): a crown over air read from
            // afar as a box hanging in the sky. Single blocks keep the gap.
    // rust: let bottom = if trunk || width == 1 {
    // rust: bottom.max(surface.height + 1)
    // rust: } else {
    // rust: surface.height
}
    // rust: if trunk {
    // rust: column.push(Span {
    // rust: min: surface.height as i16,
    // rust: max: bottom as i16,
    // rust: state: tree.log,
    // rust: biome: surface.biome,
    // rust: light,
    // rust: });
}
    // rust: column.push(Span {
    // rust: min: bottom as i16,
    // rust: max: top.max(bottom + 1) as i16,
    // rust: state: tree.leaves,
    // rust: biome: surface.biome,
    // rust: light,
    // rust: });
    // rust: column.surface = Some(Surface {
    // rust: height: top.max(bottom + 1),
    // rust: state: tree.leaves,
    // rust: ..surface
    // rust: });
}
}
    /// A chorus plant as its place-and-grow feature leaves it: a 2..=5 block
    /// stem under one fully grown flower, or a full-cell stand-in where the
    /// output cell covers several blocks.
    // rust: fn apply_chorus(
    // rust: &self,
    // rust: column: &mut Column,
    // rust: surface: Surface,
    // rust: x: i32,
    // rust: z: i32,
    // rust: width: i32,
    // rust: light: u16,
    // rust: ) {
    // rust: let Some(chorus) = self.chorus.get(&surface.biome) else {
    // rust: return;
}
    // rust: let Some(height) = chorus_at(self.seed, chorus.count, x, z, width) else {
    // rust: return;
}
    // rust: let base = surface.height;
    // rust: let top = base + height;
    // rust: column.push(Span {
    // rust: min: base as i16,
    // rust: max: top as i16,
    // rust: state: chorus.plant,
    // rust: biome: surface.biome,
    // rust: light,
    // rust: });
    // rust: column.push(Span {
    // rust: min: top as i16,
    // rust: max: (top + 1) as i16,
    // rust: state: chorus.flower,
    // rust: biome: surface.biome,
    // rust: light,
    // rust: });
    // rust: column.surface = Some(Surface {
    // rust: height: top + 1,
    // rust: state: chorus.flower,
    // rust: ..surface
    // rust: });
}
    // rust: pub(super) fn chorus_count(&self, biome: u16) -> Option<f64> {
    // rust: self.chorus.get(&biome).map(|chorus| chorus.count)
}
}

    // rust: mod tests {
//     use super::*;

pub fn chorus_density_and_height_follow_the_placements() void {
}
    // rust: let mut plants = 0;
    // rust: for z in 0..256 {
    // rust: for x in 0..256 {
    // rust: if let Some(height) = chorus_at(7, 1., x, z, 1) {
    // rust: plants += 1;
    // rust: assert!((2..=5).contains(&height), "height {height}");
}
}
}
        // One plant per chunk: 256² blocks hold 256 plants, within hash noise.
    // rust: assert!((180..=330).contains(&plants), "plants: {plants}");
    // rust: assert_eq!(chorus_at(7, 1., 0, 0, 1), chorus_at(7, 1., 0, 0, 1));
    // rust: assert_eq!(chorus_at(7, 1., 0, 0, 16), None);
    // rust: assert_eq!(chorus_at(7, 0., 0, 0, 1), None);

    // rust: let mut wide = 0;
    // rust: for z in (0..64).step_by(4) {
    // rust: for x in (0..64).step_by(4) {
    // rust: wide += usize::from(chorus_at(7, 1., x, z, 4).is_some());
}
}
    // rust: assert!((4..=40).contains(&wide), "4×4-cell plants: {wide}");
}
}
