//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_biome
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Biome colours from the pinned biome definitions and colormaps
//! (`Biome.getGrassColor`/`getFoliageColor`/..., `BlockTintSources`).
// use crate::Result;
// use horizon_core::{noise::SimplexNoise, position::BlockPos, random::LegacyRandom};
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: path::Path,
    // rust: sync::Arc,
}

pub const GrassModifier = enum {
    None,
    DarkForest,
    Swamp,
};
pub const SpawnEntry = struct {
    entity: []const u8,
    weight: u32,
    min: u32,
    max: u32,
    /// A `ConstantInt` count (sampling draws nothing).
    constant: bool,
};
/// A `natural_mob_spawns` / `spawn_overrides` entry list.
pub fn parse_entries(list: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: list.as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let count = &e["count"];
    // rust: let (min, max, constant) = match count {
    // rust: Value::Number(n) => {
    // rust: let n = n.as_u64().unwrap_or(1) as u32;
    // rust: (n, n, true)
}
    // rust: c if c["type"].as_str() == Some("minecraft:constant") => {
    // rust: let n = c["value"].as_u64().unwrap_or(1) as u32;
    // rust: (n, n, true)
}
    // rust: c => (
    // rust: c["min_inclusive"].as_u64().unwrap_or(1) as u32,
    // rust: c["max_inclusive"].as_u64().unwrap_or(1) as u32,
    // rust: false,
    // rust: ),
}
    // rust: Some(SpawnEntry {
    // rust: entity: e["type"].as_str()?.to_owned(),
    // rust: weight: e["weight"].as_u64().unwrap_or(1) as u32,
    // rust: min,
    // rust: max,
    // rust: constant,
    // rust: })
    // rust: })
    // rust: .collect()
}
/// `MobSpawnSettings.MobSpawnCost`.
pub const SpawnCost = struct {
    energy_budget: f64,
    charge: f64,
};
/// The `spawn_costs` of a `natural_mob_spawns` value.
pub fn parse_costs(costs: *Value) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: costs
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(k, c)| {
    // rust: (
    // rust: k.clone(),
    // rust: SpawnCost {
    // rust: energy_budget: c["energy_budget"].as_f64().unwrap_or(0.0),
    // rust: charge: c["charge"].as_f64().unwrap_or(0.0),
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect()
}

pub const BiomeInfo = struct {
    /// `natural_mob_spawns` by category (creature, monster, ...).
    spawns: HashMap<[]const u8,
    /// `natural_mob_spawns` spawn costs by entity type.
    spawn_costs: HashMap<[]const u8,
    /// The `gameplay/creature_world_gen_spawn_probability` attribute.
    creature_probability: f32,
    /// The `gameplay/increased_fire_burnout` attribute (jungles, swamps, peaks,
    /// mushroom fields).
    increased_fire_burnout: bool,
    name: []const u8,
    temperature: f32,
    /// `temperature_modifier: frozen` (the frozen oceans).
    frozen: bool,
    downfall: f32,
    precipitation: bool,
    grass: u32,
    modifier: GrassModifier,
    foliage: u32,
    dry_foliage: u32,
    water: u32,
    sky: ?u32,
    /// The biome's own fog colour attribute; otherwise the dimension's applies.
    fog: ?u32,
    water_fog: u32,
    /// `BiomeGenerationSettings.features`: the placed feature ids of each
    /// `GenerationStep.Decoration` step, in order.
    features: std.ArrayList(Vec<[]const u8)>,
};
    // rust: impl BiomeInfo {
    /// `Biome.getHeightAdjustedTemperature`: the frozen modifier, then cooler
    /// with height above `sea_level + 17`.
pub fn temperature_at(self: *Self, pos: BlockPos, sea_level: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_world::worldgen::biome_temperature::{
    // rust: BiomeTemperatureSettings, TemperatureModifier,
}
    // rust: BiomeTemperatureSettings {
    // rust: base_temperature: self.temperature,
    // rust: modifier: if self.frozen {
    // rust: TemperatureModifier::Frozen
    // rust: } else {
    // rust: TemperatureModifier::None
    // rust: },
    // rust: has_precipitation: self.precipitation,
    // rust: downfall: self.downfall,
}
    // rust: .height_adjusted(pos, sea_level)
}
    /// `Biome.getPrecipitationAt` in the Overworld (sea level 63): None
    /// without precipitation, else whether it falls as snow
    /// (`getHeightAdjustedTemperature` below 0.15).
pub fn snows_at(self: *Self, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.precipitation
    // rust: .then(|| self.temperature_at(BlockPos::new(x, y, z), 63) < 0.15)
}
}
/// The game's biomes, by id. The built-in (vanilla) biomes come first, in
/// file order, and keep their ids whatever a world's data packs do; a pack's
/// new biomes follow them (`with_packs`). Those are the client's own ids:
/// the network registry's are `registry_order`'s.
pub const Biomes = struct {
    list: std.ArrayList(BiomeInfo),
    index: HashMap<[]const u8,
    info_noise: SimplexNoise,
    colormaps: *Colormaps,
    /// The built-in biomes, the first of `list` unless packs replaced them.
    builtin: *std.ArrayList(BiomeInfo),
    /// The data packs' biome files (new biomes and replaced built-in ones),
    /// for the tables that read more of a biome than `BiomeInfo` keeps.
    packs: BTreeMap<[]const u8,
};
/// The grass, foliage and dry foliage colormaps.
pub const Colormaps = struct {
    grass: std.ArrayList(u32),
    foliage: std.ArrayList(u32),
    dry: std.ArrayList(u32),
};
pub fn color(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::String(s) => u32::from_str_radix(s.trim_start_matches('#'), 16)
    // rust: .ok()
    // rust: .map(|c| c & 0xFF_FFFF),
    // rust: Value::Number(n) => n.as_i64().map(|c| c as u32 & 0xFF_FFFF),
    // rust: _ => None,
}
}
pub fn colormap(root: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = root.join(format!("assets/minecraft/textures/colormap/{name}.png"));
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(horizon_core::prepared_files::read(
    // rust: &path,
    // rust: )?));
    // rust: decoder.ignore_checksums(true);
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info()?;
    // rust: let mut bytes = vec![0; reader.output_buffer_size().ok_or("colormap too large")?];
    // rust: let info = reader.next_frame(&mut bytes)?;
    // rust: let channels = info.color_type.samples();
    // rust: Ok(bytes[..info.buffer_size()]
    // rust: .chunks_exact(channels)
    // rust: .map(|p| u32::from(p[0]) << 16 | u32::from(p[1]) << 8 | u32::from(p[2]))
    // rust: .collect())
}
/// `GrassColor.get`/`FoliageColor.get`: temperature and downfall index a 256x256 map.
pub fn sample(map: *[u32], temperature: f32, downfall: f32, fallback: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let temperature = f64::from(temperature.clamp(0.0, 1.0));
    // rust: let downfall = f64::from(downfall.clamp(0.0, 1.0)) * temperature;
    // rust: let x = ((1.0 - temperature) * 255.0) as i32;
    // rust: let y = ((1.0 - downfall) * 255.0) as i32;
    // rust: let index = (y << 8 | x) as usize;
    // rust: map.get(index).copied().unwrap_or(fallback)
}
    // rust: impl BiomeInfo {
    /// A biome file's (`worldgen/biome/<name>.json`) values, the colours it
    /// leaves out sampled from the colormaps.
pub fn from_json(name: []const u8, v: *Value, maps: *Colormaps) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let effects = &v["effects"];
    // rust: let attributes = &v["attributes"];
    // rust: let temperature = v["temperature"].as_f64().unwrap_or(0.5) as f32;
    // rust: let downfall = v["downfall"].as_f64().unwrap_or(0.5) as f32;
    // rust: let modifier = match effects["grass_color_modifier"].as_str() {
    // rust: Some("dark_forest") => GrassModifier::DarkForest,
    // rust: Some("swamp") => GrassModifier::Swamp,
    // rust: _ => GrassModifier::None,
}
    // rust: let mut spawns: HashMap<String, Vec<SpawnEntry>> = HashMap::new();
    // rust: let natural = &attributes["minecraft:gameplay/natural_mob_spawns"];
        // A modifier object ({argument, modifier: overlay}) or the plain value;
        // the overlay over the dimension's empty default is the biome's value.
    // rust: let natural = if natural["argument"].is_object() {
    // rust: &natural["argument"]
    // rust: } else {
    // rust: natural
}
    // rust: let categories = &natural["spawns_by_category"];
    // rust: for (category, entries) in categories.as_object().into_iter().flatten() {
    // rust: let list = parse_entries(entries);
    // rust: spawns.insert(category.clone(), list);
}
    // rust: BiomeInfo {
    // rust: spawns,
    // rust: spawn_costs: parse_costs(&natural["spawn_costs"]),
    // rust: creature_probability:
    // rust: attributes["minecraft:gameplay/creature_world_gen_spawn_probability"]
    // rust: .as_f64()
    // rust: .unwrap_or(0.1) as f32,
    // rust: increased_fire_burnout: attributes["minecraft:gameplay/increased_fire_burnout"]
    // rust: .as_bool()
    // rust: .unwrap_or(false),
    // rust: temperature,
    // rust: frozen: v["temperature_modifier"].as_str() == Some("frozen"),
    // rust: downfall,
    // rust: precipitation: v["has_precipitation"].as_bool().unwrap_or(true),
    // rust: grass: color(&effects["grass_color"])
    // rust: .unwrap_or_else(|| sample(&maps.grass, temperature, downfall, 0xFF00FF)),
    // rust: modifier,
    // rust: foliage: color(&effects["foliage_color"])
    // rust: .unwrap_or_else(|| sample(&maps.foliage, temperature, downfall, 0x48B518)),
    // rust: dry_foliage: color(&effects["dry_foliage_color"])
    // rust: .unwrap_or_else(|| sample(&maps.dry, temperature, downfall, 0x5D4930)),
    // rust: water: color(&effects["water_color"]).unwrap_or(0x3F76E4),
    // rust: sky: color(&attributes["minecraft:visual/sky_color"]),
    // rust: fog: color(&attributes["minecraft:visual/fog_color"]),
    // rust: water_fog: color(&attributes["minecraft:visual/water_fog_color"]).unwrap_or(0x050533),
    // rust: features: v["features"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|step| {
    // rust: step.as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: .map(str::to_owned)
    // rust: .collect()
    // rust: })
    // rust: .collect(),
    // rust: name,
}
}
}
/// `Identifier.compareTo`: the path first, then the namespace.
pub fn identifier_order(a: []const u8, b: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
pub fn split(id: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: (path, ns)
}
    // rust: split(a).cmp(&split(b))
}
    // rust: impl Biomes {
pub fn load(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let maps = Colormaps {
    // rust: grass: colormap(root, "grass")?,
    // rust: foliage: colormap(root, "foliage")?,
    // rust: dry: colormap(root, "dry_foliage")?,
}
    // rust: let mut list = Vec::new();
        // The folder's own files (not its subfolders'), by file name: through `json_folder`,
        // from the prepared data file when there is one.
    // rust: let folder = horizon_world::json_folder::read(&root.join("data/minecraft/worldgen/biome"))?;
    // rust: let mut files: Vec<_> = folder
    // rust: .files
    // rust: .iter()
    // rust: .filter(|f| !f.name.contains('/'))
    // rust: .collect();
    // rust: files.sort_by_cached_key(|f| format!("{}.json", f.name));
    // rust: for file in files {
    // rust: let v: Value = horizon_world::json_file::parse(&file.path, file.bytes()?)?;
    // rust: list.push(BiomeInfo::from_json(
    // rust: format!("minecraft:{}", file.name),
    // rust: &v,
    // rust: &maps,
    // rust: ));
}
    // rust: let index = list
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, b)| (b.name.clone(), i as u16))
    // rust: .collect();
    // rust: Ok(Self {
    // rust: builtin: Arc::new(list.clone()),
    // rust: list,
    // rust: index,
    // rust: colormaps: Arc::new(maps),
    // rust: packs: BTreeMap::new(),
    // rust: info_noise: SimplexNoise::with_skipped_offsets(&mut LegacyRandom::new(2345), true),
    // rust: })
}
    /// The built-in biomes with a world's data packs' biome files (id →
    /// JSON) over them, as `RegistryDataLoader` builds the registry: a file
    /// for a built-in biome replaces it, keeping its id, and new biomes join
    /// after the built-in ones, in registry order. Starts from the built-in
    /// table whatever packs `self` has.
    // rust: pub fn with_packs<'a>(&self, files: impl IntoIterator<Item = (&'a str, &'a Value)>) -> Self {
    // rust: let mut out = self.builtin_only();
    // rust: let mut files: Vec<(&str, &Value)> = files.into_iter().collect();
    // rust: files.sort_by(|a, b| identifier_order(a.0, b.0));
    // rust: for (name, json) in files {
    // rust: let info = BiomeInfo::from_json(name.to_owned(), json, &out.colormaps);
    // rust: match out.index.get(name) {
    // rust: Some(&id) => out.list[usize::from(id)] = info,
    // rust: None if out.list.len() < usize::from(u16::MAX) => {
    // rust: out.index.insert(name.to_owned(), out.list.len() as u16);
    // rust: out.list.push(info);
}
    // rust: None => continue,
}
    // rust: out.packs.insert(name.to_owned(), Arc::new(json.clone()));
}
    // rust: out
}
    /// The built-in biomes alone: this table without what packs gave it.
pub fn builtin_only(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = self.clone();
    // rust: if self.packs.is_empty() {
    // rust: return out;
}
    // rust: out.list = self.builtin.to_vec();
    // rust: let builtin = out.list.len();
    // rust: out.index.retain(|_, id| usize::from(*id) < builtin);
    // rust: out.packs.clear();
    // rust: out
}
    /// The data pack file a world's biome `name` came from, if a pack added
    /// or replaced it.
pub fn pack_file(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.packs.get(name).map(|v| &**v)
}
    /// Whether data packs added or replaced any biome.
pub fn has_packs(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.packs.is_empty()
}
    /// The biome names in the network registry's order: `RegistryDataLoader`
    /// sorts a registry's files by `Identifier` (path, then namespace).
pub fn registry_order(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut names: Vec<&str> = self.list.iter().map(|b| b.name.as_str()).collect();
    // rust: names.sort_by(|a, b| identifier_order(a, b));
    // rust: names
}
pub fn id(self: *Self, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.index
    // rust: .get(name)
    // rust: .or_else(|| self.index.get("minecraft:plains"))
    // rust: .copied()
    // rust: .unwrap_or(0)
}
    /// Whether the game has the biome `name`.
pub fn contains(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.index.contains_key(name)
}
pub fn get(self: *Self, id: u16) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.list[usize::from(id).min(self.list.len() - 1)]
}
pub fn grass(self: *Self, id: u16, x: f64, z: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.get(id);
    // rust: match b.modifier {
    // rust: GrassModifier::None => b.grass,
    // rust: GrassModifier::DarkForest => ((b.grass & 0xFE_FEFE) + 0x28_340A) >> 1,
    // rust: GrassModifier::Swamp => {
    // rust: if f64::from(self.info_noise.get2(x * 0.0225, z * 0.0225)) < -0.1 {
    // rust: 0x4C_763C
    // rust: } else {
    // rust: 0x6A_7039
}
}
}
}
}

/// A biome's colours as a mod may change them (`native_biome_colors`), each
/// 0xRRGGBB: what tints grass (before the dark forest's modifier; the swamp's
/// noise colours replace it), leaves and vines, dry foliage (leaf litter) and
/// water.
pub const BiomeColors = struct {
    grass: u32,
    foliage: u32,
    dry_foliage: u32,
    water: u32,
};

    // rust: impl Biomes {
    /// This table with each biome's colours passed through `f`, given the
    /// biome's name (`minecraft:plains`) and its colours; None when `f`
    /// changed none. Bits past 0xFFFFFF are dropped.
pub fn with_colors(self: *Self, mut f: impl FnMut([]const u8) void {
}
    // rust: let mut out = self.clone();
    // rust: let mut changed = false;
    // rust: for b in &mut out.list {
    // rust: let before = BiomeColors {
    // rust: grass: b.grass,
    // rust: foliage: b.foliage,
    // rust: dry_foliage: b.dry_foliage,
    // rust: water: b.water,
}
    // rust: let mut colors = before;
    // rust: f(&b.name, &mut colors);
    // rust: let after = BiomeColors {
    // rust: grass: colors.grass & 0xFF_FFFF,
    // rust: foliage: colors.foliage & 0xFF_FFFF,
    // rust: dry_foliage: colors.dry_foliage & 0xFF_FFFF,
    // rust: water: colors.water & 0xFF_FFFF,
}
    // rust: if after != before {
    // rust: changed = true;
    // rust: b.grass = after.grass;
    // rust: b.foliage = after.foliage;
    // rust: b.dry_foliage = after.dry_foliage;
    // rust: b.water = after.water;
}
}
    // rust: changed.then_some(out)
}

    /// This table (the biome files') with its colours passed through `f`, when
    /// they differ from `current`'s: what a refresh of a table already
    /// coloured by `f` once must not compound.
    // rust: pub fn recolored_from(
    // rust: &self,
    // rust: current: &Self,
    // rust: f: impl FnMut(&str, &mut BiomeColors),
    // rust: ) -> Option<Self> {
    // rust: let out = self.with_colors(f).unwrap_or_else(|| self.clone());
    // rust: let tints = |b: &BiomeInfo| (b.grass, b.foliage, b.dry_foliage, b.water);
    // rust: let same = out.list.len() == current.list.len()
    // rust: && out
    // rust: .list
    // rust: .iter()
    // rust: .zip(&current.list)
    // rust: .all(|(a, b)| tints(a) == tints(b));
    // rust: (!same).then_some(out)
}
}

/// A 24-bit colour as sRGB components in 0..1.
pub fn rgb(c: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [16, 8, 0].map(|shift| (c >> shift & 255) as f32 / 255.0)
}

/// `GaussianSampler.GAUSSIAN_SAMPLE_KERNEL`.
pub const GAUSSIAN_KERNEL: [f64; 7] = [0.0, 1.0, 4.0, 6.0, 4.0, 1.0, 0.0];

/// `EnvironmentAttributeProbe.tick`: `GaussianSampler.sample` over the noise
/// biomes (quart cells) around `position`, in blocks. Each biome comes once
/// with its summed weight, in the order it was first sampled, as
/// `SpatialAttributeInterpolator` keeps them (zero weights included).
    // rust: pub fn gaussian_weights(
    // rust: position: [f64; 3],
    // rust: mut biome_at_quart: impl FnMut(i32, i32, i32) -> u16,
    // rust: ) -> Vec<(u16, f64)> {
    // rust: let p = position.map(|c| c * 0.25 - 0.5);
    // rust: let integral = p.map(|c| c.floor() as i32);
    // rust: let relative: [f64; 3] = std::array::from_fn(|i| p[i] - f64::from(integral[i]));
    // rust: let weight = |axis: usize, i: usize| {
    // rust: let (start, end) = (GAUSSIAN_KERNEL[i + 1], GAUSSIAN_KERNEL[i]);
    // rust: start + relative[axis] * (end - start)
}
    // rust: let mut weights: Vec<(u16, f64)> = Vec::new();
    // rust: for z in 0..6 {
    // rust: let wz = weight(2, z);
    // rust: for x in 0..6 {
    // rust: let wx = weight(0, x);
    // rust: for y in 0..6 {
    // rust: let wy = weight(1, y);
    // rust: let biome = biome_at_quart(
    // rust: integral[0] - 2 + x as i32,
    // rust: integral[1] - 2 + y as i32,
    // rust: integral[2] - 2 + z as i32,
    // rust: );
    // rust: let w = wx * wy * wz;
    // rust: match weights.iter_mut().find(|(b, _)| *b == biome) {
    // rust: Some((_, total)) => *total += w,
    // rust: None => weights.push((biome, w)),
}
}
}
}
    // rust: weights
}

/// `SpatialAttributeInterpolator.applyAttributeLayer` for an RGB colour
/// (`ARGB.srgbLerp`: a component-wise lerp of the sRGB values).
pub fn blend_rgb(weights: *[(u16) void {
}
    // rust: let mut result: Option<[f32; 3]> = None;
    // rust: let mut accumulated = 0.0;
    // rust: for &(biome, weight) in weights {
    // rust: let v = value(biome);
    // rust: accumulated += weight;
    // rust: result = Some(match result {
    // rust: None => v,
    // rust: Some(r) => {
    // rust: let t = (weight / accumulated) as f32;
    // rust: std::array::from_fn(|i| r[i] + (v[i] - r[i]) * t)
}
    // rust: });
}
    // rust: result.unwrap_or([0.0; 3])
}

    // rust: mod pack_tests {
//     use super::*;
//     use serde_json::json;

    /// A built-in table of `names` (no colormaps: sampled colours fall back).
pub fn builtin(names: *[[]const u8]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let maps = Colormaps {
    // rust: grass: Vec::new(),
    // rust: foliage: Vec::new(),
    // rust: dry: Vec::new(),
}
    // rust: let list: Vec<BiomeInfo> = names
    // rust: .iter()
    // rust: .map(|n| BiomeInfo::from_json((*n).to_owned(), &json!({}), &maps))
    // rust: .collect();
    // rust: Biomes {
    // rust: builtin: Arc::new(list.clone()),
    // rust: index: list
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, b)| (b.name.clone(), i as u16))
    // rust: .collect(),
    // rust: list,
    // rust: info_noise: SimplexNoise::with_skipped_offsets(&mut LegacyRandom::new(2345), true),
    // rust: colormaps: Arc::new(maps),
    // rust: packs: BTreeMap::new(),
}
}

pub fn registry_order_is_path_then_namespace() void {
}
//         use std::cmp::Ordering::*;
    // rust: assert_eq!(identifier_order("minecraft:a", "minecraft:b"), Less);
    // rust: assert_eq!(identifier_order("z:a", "a:b"), Less);
    // rust: assert_eq!(identifier_order("b:same", "a:same"), Greater);
    // rust: assert_eq!(identifier_order("minecraft:a", "minecraft:a_b"), Less);
    // rust: assert_eq!(identifier_order("minecraft:a-b", "minecraft:a"), Greater);
}

pub fn packs_replace_in_place_and_add_after_the_builtin_biomes() void {
}
    // rust: let base = builtin(&["minecraft:meadow", "minecraft:plains", "minecraft:river"]);
    // rust: let red = json!({"temperature": 2.0, "effects": {"water_color": "#ff0000"}});
    // rust: let hot = json!({"effects": {"grass_color": 0x123456}});
    // rust: let files = [
    // rust: ("pack:zeta", &hot),
    // rust: ("minecraft:molten_peaks", &hot),
    // rust: ("minecraft:river", &red),
    // rust: ];
    // rust: let world = base.with_packs(files);
        // The built-in ids stay; the river takes the pack's values.
    // rust: assert_eq!(world.id("minecraft:plains"), 1);
    // rust: assert_eq!(world.id("minecraft:river"), 2);
    // rust: assert_eq!(world.get(2).water, 0xFF0000);
    // rust: assert_eq!(world.get(2).temperature, 2.0);
        // New biomes follow, in registry order.
    // rust: assert_eq!(world.id("minecraft:molten_peaks"), 3);
    // rust: assert_eq!(world.id("pack:zeta"), 4);
    // rust: assert_eq!(world.get(3).grass, 0x123456);
    // rust: assert!(world.pack_file("minecraft:river").is_some());
    // rust: assert!(world.pack_file("minecraft:plains").is_none());
        // The network registry sorts every name by path, then namespace.
    // rust: assert_eq!(
    // rust: world.registry_order(),
    // rust: [
    // rust: "minecraft:meadow",
    // rust: "minecraft:molten_peaks",
    // rust: "minecraft:plains",
    // rust: "minecraft:river",
    // rust: "pack:zeta"
    // rust: ]
    // rust: );
        // Another world starts again from the built-in biomes.
    // rust: let other = world.with_packs([]);
    // rust: assert_eq!(other.list.len(), 3);
    // rust: assert!(!other.contains("minecraft:molten_peaks"));
    // rust: assert_eq!(other.get(2).water, 0x3F76E4);
    // rust: assert!(!other.has_packs());
}
}

    // rust: mod color_tests {
//     use super::*;
//     use serde_json::json;

pub fn biomes() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let maps = Colormaps {
    // rust: grass: Vec::new(),
    // rust: foliage: Vec::new(),
    // rust: dry: Vec::new(),
}
    // rust: let effects = |grass: u32, modifier: &str| {
    // rust: json!({"effects": {"grass_color": grass, "foliage_color": 0x112233,
    // rust: "dry_foliage_color": 0x445566, "water_color": 0x3F76E4,
    // rust: "grass_color_modifier": modifier}})
}
    // rust: let list = vec![
    // rust: BiomeInfo::from_json("minecraft:plains".into(), &effects(0x91BD59, "none"), &maps),
    // rust: BiomeInfo::from_json(
    // rust: "minecraft:dark_forest".into(),
    // rust: &effects(0x91BD59, "dark_forest"),
    // rust: &maps,
    // rust: ),
    // rust: ];
    // rust: Biomes {
    // rust: builtin: Arc::new(list.clone()),
    // rust: index: list
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, b)| (b.name.clone(), i as u16))
    // rust: .collect(),
    // rust: list,
    // rust: info_noise: SimplexNoise::with_skipped_offsets(&mut LegacyRandom::new(2345), true),
    // rust: colormaps: Arc::new(maps),
    // rust: packs: BTreeMap::new(),
}
}

pub fn a_change_reaches_the_tints_the_mesher_reads() void {
}
    // rust: let autumn = biomes()
    // rust: .with_colors(|name, c| {
    // rust: c.foliage = 0xD2691E;
    // rust: if name == "minecraft:plains" {
    // rust: c.grass = 0xBFA055;
}
    // rust: })
    // rust: .expect("changed");
    // rust: let plains = autumn.id("minecraft:plains");
    // rust: assert_eq!(autumn.grass(plains, 0.0, 0.0), 0xBFA055);
    // rust: assert_eq!(autumn.get(plains).foliage, 0xD2691E);
    // rust: assert_eq!(autumn.get(plains).dry_foliage, 0x445566);
    // rust: assert_eq!(autumn.get(plains).water, 0x3F76E4);
        // The dark forest's modifier still darkens its (unchanged) grass:
        // ((0x91BD59 & 0xFEFEFE) + 0x28340A) >> 1.
    // rust: let dark = autumn.id("minecraft:dark_forest");
    // rust: assert_eq!(autumn.grass(dark, 0.0, 0.0), 0x5C7831);
    // rust: assert_eq!(autumn.get(dark).foliage, 0xD2691E);
}

pub fn no_change_gives_none_and_alpha_bits_are_dropped() void {
}
    // rust: assert!(biomes().with_colors(|_, _| {}).is_none());
    // rust: assert!(
    // rust: biomes()
    // rust: .with_colors(|_, c| c.water |= 0xFF00_0000)
    // rust: .is_none()
    // rust: );
    // rust: let blue = biomes()
    // rust: .with_colors(|_, c| c.water = 0xFF00_00FF)
    // rust: .expect("changed");
    // rust: assert_eq!(blue.get(0).water, 0x0000FF);
}
}

    // rust: mod blend_tests {
//     use super::*;

pub fn one_biome_keeps_its_colour() void {
}
    // rust: let weights = gaussian_weights([10.3, 64.0, -7.9], |_, _, _| 4);
    // rust: assert_eq!(weights.len(), 1);
        // The kernel sums to 16 per axis whatever the offset.
    // rust: assert!((weights[0].1 - 16f64.powi(3)).abs() < 1e-9);
    // rust: assert_eq!(blend_rgb(&weights, |_| [0.2, 0.4, 0.6]), [0.2, 0.4, 0.6]);
}

pub fn colour_changes_gradually_across_a_boundary() void {
}
        // Biome 1 for quart x >= 0 (block x >= 0), biome 0 below.
    // rust: let at = |x: f64| {
    // rust: let w = gaussian_weights([x, 40.0, 0.0], |qx, _, _| u16::from(qx >= 0));
    // rust: blend_rgb(&w, |b| if b == 1 { [1.0, 0.0, 0.0] } else { [0.0; 3] })[0]
}
    // rust: assert_eq!(at(-12.0), 0.0);
    // rust: assert_eq!(at(12.0), 1.0);
        // Halfway at the boundary, rising steadily through it.
    // rust: assert!((at(0.0) - 0.5).abs() < 1e-5, "{}", at(0.0));
    // rust: let mut last = 0.0;
    // rust: for i in -16..=16 {
    // rust: let v = at(f64::from(i) * 0.5);
    // rust: assert!(v >= last - 1e-6, "{v} < {last} at {i}");
    // rust: last = v;
}
    // rust: assert!(at(-2.0) > 0.0 && at(-2.0) < 0.5);
}
}
