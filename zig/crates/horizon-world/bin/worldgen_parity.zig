//! Transpiled from Horizon Rust crate
//! Module: horizon-world_worldgen_parity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Original transport for version-specific JSON decoding comparisons.
// use horizon_core::{
    // rust: density::{
    // rust: SamplerContext,
    // rust: graph::{DensityCompiler, FunctionId},
    // rust: },
    // rust: noise::DensityVolume,
    // rust: noise::{Noise, NormalNoise},
    // rust: random::{LegacyRandom, RandomSource, XoroshiroRandom},
}
// use horizon_world::worldgen::{
    // rust: decode_noise,
    // rust: density::DensityRegistry,
    // rust: router::{NoiseRouter, RouterField},
}
// use std::io::{self, BufRead, Write};

pub fn bits(value: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value.is_nan() {
    // rust: 0x7fc0_0000
    // rust: } else {
    // rust: value.to_bits()
}
}
    // rust: fn probe(
    // rust: noise: &NormalNoise,
    // rust: random: &mut impl RandomSource,
    // rust: nether: bool,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let sampler = match if nether {
    // rust: noise.create_for_legacy_nether_biome(random)
    // rust: } else {
    // rust: noise.create(random)
    // rust: } {
    // rust: Ok(sampler) => sampler,
    // rust: Err(_) => {
    // rust: writeln!(out, "sample error {}", random.next_long())?;
    // rust: return Ok(());
}
}
    // rust: for [x, y, z] in [
    // rust: [0., 0., 0.],
    // rust: [-17.25, 64.125, 32.5],
    // rust: [30e6, -64., -30e6],
    // rust: [1.25, -0.5, -3.75],
    // rust: [33554432., -2048., -33554433.],
    // rust: ] {
    // rust: writeln!(
    // rust: out,
    // rust: "query {} {}",
    // rust: bits(sampler.get2(x, z)),
    // rust: bits(sampler.get3(x, y, z))
    // rust: )?;
}
    // rust: writeln!(out, "parent {}", random.next_long())?;
    // rust: Ok(())
}
    // rust: fn registry_probe(
    // rust: path: &str,
    // rust: seed: i64,
    // rust: legacy: bool,
    // rust: optimized: bool,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let bundle: std::collections::BTreeMap<String, std::collections::BTreeMap<String, String>> =
    // rust: serde_json::from_str(&std::fs::read_to_string(path)?)?;
    // rust: let registry = DensityRegistry::from_json(&bundle["noises"], &bundle["densities"])?;
    // rust: let entries: Vec<_> = registry
    // rust: .entries()
    // rust: .map(|(name, id)| (name.to_owned(), id))
    // rust: .collect();
    // rust: let mut compiler = DensityCompiler::new_seeded(registry.into_graph(), seed, legacy);
    // rust: writeln!(out, "registry {}", entries.len())?;
    // rust: for (name, id) in entries {
    // rust: sample_root(
    // rust: &mut compiler,
    // rust: id,
    // rust: &name,
    // rust: optimized,
    // rust: false,
    // rust: &mut SamplerContext::cached(),
    // rust: out,
    // rust: )?;
}
    // rust: Ok(())
}
    // rust: fn sample_root(
    // rust: compiler: &mut DensityCompiler,
    // rust: id: FunctionId,
    // rust: name: &str,
    // rust: optimized: bool,
    // rust: router: bool,
    // rust: context: &mut SamplerContext,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let range = compiler.graph().range(id)?;
    // rust: writeln!(
    // rust: out,
    // rust: "entry {name} {} {} {}",
    // rust: bits(range.min()),
    // rust: bits(range.max()),
    // rust: compiler.graph().domain_axes(id)?
    // rust: )?;
    // rust: let sampler = match if optimized {
    // rust: compiler.get_sampler(id)
    // rust: } else {
    // rust: compiler.compile_raw(id)
    // rust: } {
    // rust: Ok(sampler) => sampler,
    // rust: Err(_) => {
    // rust: writeln!(out, "compile error")?;
    // rust: return Ok(());
}
}
    // rust: writeln!(out, "compile ok {}", compiler.cache_count())?;
    // rust: for position in [
    // rust: [0, 0, 0],
    // rust: [-17, -64, 32],
    // rust: [30000000, 319, -30000000],
    // rust: [1, -1, -1],
    // rust: ] {
    // rust: writeln!(
    // rust: out,
    // rust: "density {}",
    // rust: bits(sampler.sample_value(context, position)?)
    // rust: )?;
}
    // rust: let mut volumes = vec![
    // rust: ([2, 9, 2], [-17, -64, 32], [1, 1, 1]),
    // rust: ([2, 9, 2], [-16, -64, 32], [4, 8, 4]),
    // rust: ];
    // rust: if router {
    // rust: volumes.push(([3, 1, 2], [-17, 0, 32], [4, 1, 4]));
}
    // rust: for (extents, minimum, steps) in volumes {
    // rust: let volume = DensityVolume::new(extents, minimum, steps)?;
    // rust: let mut buffer = vec![0.; volume.size()];
    // rust: for _ in 0..2 {
    // rust: let result = sampler.sample_volume(context, &mut buffer, volume);
    // rust: writeln!(
    // rust: out,
    // rust: "volume {}",
    // rust: if result.is_ok() { "ok" } else { "error" }
    // rust: )?;
    // rust: for value in &buffer {
    // rust: writeln!(out, "cell {}", bits(*value))?;
}
}
}
    // rust: Ok(())
}
    // rust: fn router_probe(
    // rust: path: &str,
    // rust: setting: &str,
    // rust: seed: i64,
    // rust: legacy: bool,
    // rust: optimized: bool,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let bundle: std::collections::BTreeMap<String, std::collections::BTreeMap<String, String>> =
    // rust: serde_json::from_str(&std::fs::read_to_string(path)?)?;
    // rust: let mut registry = DensityRegistry::from_json(&bundle["noises"], &bundle["densities"])?;
    // rust: let settings: std::collections::BTreeMap<String, Box<serde_json::value::RawValue>> =
    // rust: serde_json::from_str(&bundle["settings"][setting])?;
    // rust: let router = NoiseRouter::from_json(settings["noise_router"].get(), &mut registry)?;
    // rust: let mut compiler = DensityCompiler::new_seeded(registry.into_graph(), seed, legacy);
    // rust: let mut context = SamplerContext::cached();
    // rust: writeln!(out, "router {setting} 8")?;
    // rust: for field in RouterField::ALL {
    // rust: sample_root(
    // rust: &mut compiler,
    // rust: router.function(field),
    // rust: field.name(),
    // rust: optimized,
    // rust: true,
    // rust: &mut context,
    // rust: out,
    // rust: )?;
}
    // rust: let climate = router.compile_climate(&mut compiler)?;
    // rust: writeln!(out, "climate caches {}", compiler.cache_count())?;
    // rust: for position in [
    // rust: [0, 0, 0],
    // rust: [-5, -16, 8],
    // rust: [7500000, 79, -7500000],
    // rust: [i32::MIN, i32::MAX, -1],
    // rust: [536870912, -536870913, 17],
    // rust: [-4, 0, 8],
    // rust: ] {
    // rust: write!(out, "climate")?;
    // rust: for value in climate.sample(&mut context, position)?.parameters() {
    // rust: write!(out, " {value}")?;
}
    // rust: writeln!(out)?;
}
    // rust: for (preset, json) in &bundle["presets"] {
    // rust: let source =
    // rust: horizon_world::worldgen::biome::MultiNoiseBiomeSource::from_quantized_json(json)?;
    // rust: writeln!(
    // rust: out,
    // rust: "biomes {preset} {}",
    // rust: source.parameters().entries().len()
    // rust: )?;
    // rust: let mut resolver = source.resolver(&climate);
    // rust: for position in [
    // rust: [0, 0, 0],
    // rust: [-5, -16, 8],
    // rust: [7500000, 79, -7500000],
    // rust: [i32::MIN, i32::MAX, -1],
    // rust: [536870912, -536870913, 17],
    // rust: [-4, 0, 8],
    // rust: ] {
    // rust: writeln!(out, "biome {}", resolver.sample(&mut context, position)?)?;
}
    // rust: for (minimum, extents) in [
    // rust: ([-5, -16, 8], [3, 4, 2]),
    // rust: ([-4, -16, 8], [3, 4, 2]),
    // rust: ([i32::MAX - 1, i32::MIN, -1], [2, 2, 2]),
    // rust: ] {
    // rust: let volume = resolver.prepare_volume(&mut context, minimum, extents)?;
    // rust: let mut positions = Vec::new();
    // rust: for z in 0..extents[2] {
    // rust: for x in 0..extents[0] {
    // rust: for y in 0..extents[1] {
    // rust: positions.push([
    // rust: minimum[0].wrapping_add(x),
    // rust: minimum[1].wrapping_add(y),
    // rust: minimum[2].wrapping_add(z),
    // rust: ]);
}
}
}
    // rust: for position in positions
    // rust: .iter()
    // rust: .chain(positions.iter().rev())
    // rust: .chain(positions.iter().take(3))
    // rust: {
    // rust: writeln!(
    // rust: out,
    // rust: "biomecell {}",
    // rust: resolver.sample_prepared(&volume, *position)?
    // rust: )?;
}
}
}
    // rust: Ok(())
}
    // rust: fn index_probe(
    // rust: branching: usize,
    // rust: json: &str,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
//     use horizon_world::worldgen::climate::{ClimateIndex, Parameter, ParameterPoint, TargetPoint};
    // rust: let input: serde_json::Value = serde_json::from_str(json)?;
    // rust: let mut entries = Vec::new();
    // rust: for (id, entry) in input["entries"]
    // rust: .as_array()
    // rust: .ok_or("entries")?
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: let coords = entry["coordinates"].as_array().ok_or("coordinates")?;
    // rust: let mut coordinates = [Parameter::new(0, 0); 6];
    // rust: for (coordinate, value) in coordinates.iter_mut().zip(coords) {
    // rust: *coordinate = Parameter::new(
    // rust: value[0].as_i64().ok_or("minimum")?,
    // rust: value[1].as_i64().ok_or("maximum")?,
    // rust: );
}
    // rust: entries.push((
    // rust: ParameterPoint {
    // rust: coordinates,
    // rust: offset: entry["offset"].as_i64().ok_or("offset")?,
    // rust: },
    // rust: id,
    // rust: ));
}
    // rust: let index = match ClimateIndex::with_branching(entries, branching) {
    // rust: Ok(index) => index,
    // rust: Err(_) => {
    // rust: writeln!(out, "index error")?;
    // rust: return Ok(());
}
}
    // rust: writeln!(out, "index ok {}", index.entries().len())?;
    // rust: for id in index.leaf_order() {
    // rust: writeln!(out, "leaf {id}")?;
}
    // rust: let mut cached = index.searcher();
    // rust: for target in input["targets"].as_array().ok_or("targets")? {
    // rust: let values = target.as_array().ok_or("target")?;
    // rust: let point = TargetPoint {
    // rust: temperature: values[0].as_i64().ok_or("temperature")?,
    // rust: humidity: values[1].as_i64().ok_or("humidity")?,
    // rust: continentalness: values[2].as_i64().ok_or("continentalness")?,
    // rust: erosion: values[3].as_i64().ok_or("erosion")?,
    // rust: depth: values[4].as_i64().ok_or("depth")?,
    // rust: weirdness: values[5].as_i64().ok_or("weirdness")?,
}
    // rust: let brute = index.brute_force(point);
    // rust: writeln!(
    // rust: out,
    // rust: "brute {brute} {}",
    // rust: index.entries()[*brute].0.fitness(point)
    // rust: )?;
    // rust: for (label, result) in [
    // rust: ("cached", cached.find(point)),
    // rust: ("fresh", index.searcher().find(point)),
    // rust: ] {
    // rust: match result {
    // rust: Ok(id) => writeln!(
    // rust: out,
    // rust: "{label} {id} {}",
    // rust: index.entries()[*id].0.fitness(point)
    // rust: )?,
    // rust: Err(_) => writeln!(out, "{label} error")?,
}
}
}
    // rust: Ok(())
}
    // rust: fn settings_probe(
    // rust: settings: horizon_world::worldgen::settings::NoiseSettings,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: writeln!(out, "settings {} {}", settings.min_y, settings.height)?;
    // rust: for (minimum, height) in [
    // rust: (-64, 384),
    // rust: (0, 128),
    // rust: (-2032, 4064),
    // rust: (17, 15),
    // rust: (2048, 16),
    // rust: (i32::MAX, 1),
    // rust: (i32::MIN, i32::MAX),
    // rust: ] {
    // rust: let clamped = settings.clamp_to_height(minimum, height);
    // rust: writeln!(out, "clamped {} {}", clamped.min_y, clamped.height)?;
}
    // rust: Ok(())
}
pub fn aquifer_probe(line: []const u8, out: *mut impl Write) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_world::{
    // rust: registry::BlockStateId,
    // rust: worldgen::aquifer::{DisabledAquifer, FluidPicker, FluidStatus, GlobalFluidPicker},
}
//     use std::sync::atomic::{AtomicUsize, Ordering};
pub const Counted = struct {
    picker: GlobalFluidPicker,
    calls: AtomicUsize,
};
    // rust: impl FluidPicker for Counted {
pub fn compute(self: *Self, position: [i32; 3]) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.calls.fetch_add(1, Ordering::Relaxed);
    // rust: self.picker.compute(position)
}
}
    // rust: let args: Vec<_> = line.split_whitespace().collect();
    // rust: let sea = args[1].parse::<i32>()?;
    // rust: let fluid = BlockStateId(args[2].parse::<u32>()?);
    // rust: let position = [args[3].parse()?, args[4].parse()?, args[5].parse()?];
    // rust: let density = f64::from_bits(u64::from_str_radix(args[6], 16)?);
    // Local labels correspond to actual reference default block states. They
    // exercise identity-based selection independently of numeric registry IDs.
    // rust: let picker = GlobalFluidPicker::new(sea, fluid, BlockStateId(1), BlockStateId(2));
    // rust: let status = picker.compute(position);
    // rust: writeln!(
    // rust: out,
    // rust: "fluid {} {} {}",
    // rust: status.level,
    // rust: status.state.0,
    // rust: status.at(position[1], BlockStateId(2)).0
    // rust: )?;
    // rust: let counted = Counted {
    // rust: picker,
    // rust: calls: AtomicUsize::new(0),
}
    // rust: let aquifer = DisabledAquifer::new(&counted, BlockStateId(2));
    // rust: let substance = aquifer.compute_substance(position, density);
    // rust: let label = substance.map_or_else(|| "default_solid".to_string(), |id| id.0.to_string());
    // rust: writeln!(
    // rust: out,
    // rust: "substance {label} {} {}",
    // rust: aquifer.should_schedule_fluid_update(),
    // rust: counted.calls.load(Ordering::Relaxed)
    // rust: )?;
    // rust: Ok(())
}
pub fn noise_aquifer_probe(line: []const u8, out: *mut impl Write) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_core::{
    // rust: density::{ConstantSampler, DensitySampler, SampleError},
    // rust: random::PositionalRandom,
}
//     use horizon_world::{
    // rust: registry::BlockStateId,
    // rust: worldgen::aquifer::{
    // rust: AquiferBlockStates, AquiferConfig, AquiferField, AquiferSamplers, FluidPicker,
    // rust: FluidStatus, GlobalFluidPicker, NoiseBasedAquifer,
    // rust: },
}
//     use std::sync::{Arc, Mutex};
pub const Traced = struct {
    sampler: *dyn DensitySampler,
    field: usize,
    events: *Mutex<std.ArrayList([]const u8)>,
    calls: Mutex<usize>,
    fail: ?usize,
};
    // rust: impl Traced {
pub fn enter(self: *Self, event: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.events.lock().unwrap().push(event);
    // rust: let mut calls = self.calls.lock().unwrap();
    // rust: *calls += 1;
    // rust: if self.fail == Some(*calls) {
    // rust: self.events
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push(format!("sample failure {}", self.field));
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: } else {
    // rust: Ok(())
}
}
}
    // rust: impl DensitySampler for Traced {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: self.enter(format!(
    // rust: "sample {} value {} {} {}",
    // rust: self.field, position[0], position[1], position[2]
    // rust: ))?;
    // rust: let result = self.sampler.sample_value(context, position);
    // rust: self.events.lock().unwrap().push(match result {
    // rust: Ok(value) => format!("value {}", bits(value)),
    // rust: Err(_) => "value error".into(),
    // rust: });
    // rust: result
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: let size = volume.sizes();
    // rust: let min = volume.minimum();
    // rust: let steps = volume.steps();
    // rust: self.enter(format!(
    // rust: "sample {} volume {} {} {} {} {} {} {} {} {}",
    // rust: self.field,
    // rust: size[0],
    // rust: size[1],
    // rust: size[2],
    // rust: min[0],
    // rust: min[1],
    // rust: min[2],
    // rust: steps[0],
    // rust: steps[1],
    // rust: steps[2]
    // rust: ))?;
    // rust: let result = self.sampler.sample_volume(context, buffer, volume);
    // rust: let mut events = self.events.lock().unwrap();
    // rust: events.push(format!(
    // rust: "sample volume {}",
    // rust: if result.is_ok() { "ok" } else { "error" }
    // rust: ));
    // rust: events.extend(
    // rust: buffer
    // rust: .iter()
    // rust: .map(|value| format!("sample cell {}", bits(*value))),
    // rust: );
    // rust: result
}
}
pub const Picker = struct {
    inner: GlobalFluidPicker,
    events: *Mutex<std.ArrayList([]const u8)>,
};
    // rust: impl FluidPicker for Picker {
pub fn compute(self: *Self, position: [i32; 3]) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let status = self.inner.compute(position);
    // rust: self.events.lock().unwrap().push(format!(
    // rust: "pick {} {} {} {} {}",
    // rust: position[0], position[1], position[2], status.level, status.state.0
    // rust: ));
    // rust: status
}
}
pub const Blocks = struct {};
    // rust: impl AquiferBlockStates for Blocks {
pub fn air(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockStateId(2)
}
pub fn lava(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockStateId(1)
}
pub fn is_air(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s.0, 2 | 4 | 5)
}
pub fn is_lava(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s.0, 1 | 7)
}
pub fn is_water(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s.0, 0 | 6)
}
}
pub fn flush(events: *Mutex<std.ArrayList([]const u8)>, out: *mut impl Write) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for event in events.lock().unwrap().drain(..) {
    // rust: writeln!(out, "{event}")?;
}
    // rust: Ok(())
}
    // rust: fn run<F: PositionalRandom>(
    // rust: samplers: AquiferSamplers,
    // rust: picker: Picker,
    // rust: random: F,
    // rust: volume: DensityVolume,
    // rust: queries: &serde_json::Value,
    // rust: events: Arc<Mutex<Vec<String>>>,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let mut context = SamplerContext::cached();
    // rust: let created =
    // rust: NoiseBasedAquifer::new(samplers, picker, random, Blocks, volume, &mut context);
    // rust: flush(&events, out)?;
    // rust: let mut aquifer = match created {
    // rust: Ok(value) => value,
    // rust: Err(_) => {
    // rust: writeln!(out, "aquifer create error")?;
    // rust: return Ok(());
}
}
    // rust: writeln!(out, "aquifer ready {}", aquifer.skip_sampling_above_y())?;
    // rust: for query in queries.as_array().ok_or("queries")? {
    // rust: let position = [
    // rust: query[0].as_i64().ok_or("x")? as i32,
    // rust: query[1].as_i64().ok_or("y")? as i32,
    // rust: query[2].as_i64().ok_or("z")? as i32,
    // rust: ];
    // rust: let density = f64::from_bits(u64::from_str_radix(
    // rust: query[3].as_str().ok_or("density")?,
    // rust: 16,
    // rust: )?);
    // rust: let result = aquifer.compute_substance(&mut context, position, density);
    // rust: flush(&events, out)?;
    // rust: let result = match result {
    // rust: Ok(Some(state)) => state.0.to_string(),
    // rust: Ok(None) => "default_solid".into(),
    // rust: Err(_) => "error".into(),
}
    // rust: writeln!(
    // rust: out,
    // rust: "aquifer result {result} {}",
    // rust: aquifer.should_schedule_fluid_update()
    // rust: )?;
}
    // rust: for (index, (location, status)) in aquifer.cached_cells().enumerate() {
    // rust: let status = status.map_or("none".into(), |s| format!("{} {}", s.level, s.state.0));
    // rust: writeln!(out, "aquifer cell {index} {location} {status}")?;
}
    // rust: let mut surfaces: Vec<_> = aquifer.cached_surfaces().collect();
    // rust: surfaces.sort_by_key(|entry| entry.0);
    // rust: for (key, value) in surfaces {
    // rust: writeln!(out, "aquifer surface {key} {value}")?;
}
    // rust: Ok(())
}
    // rust: let fields: Vec<_> = line.splitn(6, ' ').collect();
    // rust: let seed: i64 = fields[1].parse()?;
    // rust: let legacy = fields[2] == "1";
    // rust: let bundle: std::collections::BTreeMap<String, std::collections::BTreeMap<String, String>> =
    // rust: serde_json::from_str(&std::fs::read_to_string(fields[3])?)?;
    // rust: let fixture: serde_json::Value = serde_json::from_str(fields[5])?;
    // rust: let mut registry = DensityRegistry::from_json(&bundle["noises"], &bundle["densities"])?;
    // rust: let settings: std::collections::BTreeMap<String, Box<serde_json::value::RawValue>> =
    // rust: serde_json::from_str(&bundle["settings"][fields[4]])?;
    // rust: let config_text = fixture
    // rust: .get("config")
    // rust: .map(|c| c.as_str().ok_or("config string"))
    // rust: .transpose()?
    // rust: .unwrap_or_else(|| settings.get("aquifers").map_or("null", |v| v.get()));
    // rust: let config = match AquiferConfig::from_json(config_text, &mut registry) {
    // rust: Ok(config) => config,
    // rust: Err(_) => {
    // rust: writeln!(out, "aquifer config error")?;
    // rust: return Ok(());
}
}
    // rust: let mut compiler = DensityCompiler::new_seeded(registry.into_graph(), seed, legacy);
    // rust: let samplers = match config.compile(&mut compiler) {
    // rust: Ok(s) => s,
    // rust: Err(_) => {
    // rust: writeln!(out, "aquifer compile error")?;
    // rust: return Ok(());
}
}
    // rust: writeln!(out, "aquifer compile ok {}", compiler.cache_count())?;
    // rust: let events = Arc::new(Mutex::new(Vec::new()));
    // rust: let mut traced = Vec::new();
    // rust: for field in AquiferField::ALL {
    // rust: let i = field as usize;
    // rust: let sampler = if let Some(value) = fixture
    // rust: .get("overrides")
    // rust: .and_then(|v| v.get(i))
    // rust: .and_then(|v| v.as_str())
    // rust: {
    // rust: Arc::new(ConstantSampler(f32::from_bits(u32::from_str_radix(
    // rust: value, 16,
    // rust: )?))) as Arc<dyn DensitySampler>
    // rust: } else {
    // rust: samplers.get(field).clone()
}
    // rust: let fail = fixture
    // rust: .get("fail")
    // rust: .filter(|f| f[0].as_u64() == Some(i as u64))
    // rust: .and_then(|f| f[1].as_u64())
    // rust: .map(|n| n as usize);
    // rust: traced.push(Arc::new(Traced {
    // rust: sampler,
    // rust: field: i,
    // rust: events: events.clone(),
    // rust: calls: Mutex::new(0),
    // rust: fail,
    // rust: }) as Arc<dyn DensitySampler>);
}
    // rust: let samplers = AquiferSamplers::new(traced.try_into().unwrap());
    // rust: let array = |name: &str| -> Result<[i32; 3], Box<dyn std::error::Error>> {
    // rust: Ok(std::array::from_fn(|i| {
    // rust: fixture[name][i].as_i64().unwrap() as i32
    // rust: }))
}
    // rust: let volume = DensityVolume::new(array("sizes")?, array("minimum")?, array("steps")?)?;
    // rust: let picker = Picker {
    // rust: inner: GlobalFluidPicker::new(
    // rust: fixture["sea"].as_i64().ok_or("sea")? as i32,
    // rust: BlockStateId(fixture["fluid"].as_u64().ok_or("fluid")? as u32),
    // rust: BlockStateId(1),
    // rust: BlockStateId(2),
    // rust: ),
    // rust: events: events.clone(),
}
    // rust: if legacy {
    // rust: let random = LegacyRandom::new(seed)
    // rust: .fork_positional()
    // rust: .from_hash_of("minecraft:aquifer")
    // rust: .fork_positional();
    // rust: run(
    // rust: samplers,
    // rust: picker,
    // rust: random,
    // rust: volume,
    // rust: &fixture["queries"],
    // rust: events,
    // rust: out,
    // rust: )
    // rust: } else {
    // rust: let random = XoroshiroRandom::new(seed)
    // rust: .fork_positional()
    // rust: .from_hash_of("minecraft:aquifer")
    // rust: .fork_positional();
    // rust: run(
    // rust: samplers,
    // rust: picker,
    // rust: random,
    // rust: volume,
    // rust: &fixture["queries"],
    // rust: events,
    // rust: out,
    // rust: )
}
}

    // rust: fn tags_probe(
    // rust: fixture: &serde_json::Value,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
//     use horizon_world::worldgen::tags::TagDefinitions;
    // rust: writeln!(
    // rust: out,
    // rust: "tags resources {}",
    // rust: fixture["files"].as_array().ok_or("files")?.len()
    // rust: )?;
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for file in fixture["files"].as_array().ok_or("files")? {
    // rust: let name = file[0].as_str().ok_or("name")?;
    // rust: let source = file[1].as_str().ok_or("source")?;
    // rust: if definitions
    // rust: .apply_json(name, source, file[2].as_str().ok_or("json")?)
    // rust: .is_err()
    // rust: {
            // Fixture names are valid. Codec errors can introduce empty tags.
    // rust: let canonical = definitions
    // rust: .definitions()
    // rust: .keys()
    // rust: .find(|key| key.as_str() == name || key.as_str() == format!("minecraft:{name}"))
    // rust: .ok_or("tag name")?;
    // rust: writeln!(out, "tag resource error {canonical} {source}")?;
}
}
    // rust: let mut trace = Vec::new();
    // rust: let result = definitions.build(|id, required| {
    // rust: trace.push(format!("tag lookup {id} {required}"));
    // rust: fixture["elements"]
    // rust: .get(id)
    // rust: .and_then(|v| v.as_str())
    // rust: .map(str::to_owned)
    // rust: })?;
    // rust: for event in trace {
    // rust: writeln!(out, "{event}")?;
}
    // rust: writeln!(out, "tags built {}", result.tags.len())?;
    // rust: for (name, values) in result.tags {
    // rust: writeln!(out, "tag members {name} {}", values.len())?;
    // rust: for value in values {
    // rust: writeln!(out, "tag member {value}")?;
}
}
    // rust: for name in result.missing.keys() {
    // rust: writeln!(out, "tag missing {name}")?;
}
    // rust: Ok(())
}
pub fn tag_registry_probe(path: []const u8, out: *mut impl Write) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bundle: std::collections::BTreeMap<String, std::collections::BTreeMap<String, String>> =
    // rust: serde_json::from_str(&std::fs::read_to_string(path)?)?;
    // rust: let files: Vec<_> = bundle["tags"]
    // rust: .iter()
    // rust: .map(|(name, json)| serde_json::json!([name, "vanilla", json]))
    // rust: .collect();
    // rust: tags_probe(
    // rust: &serde_json::json!({"files":files,"elements":bundle["block_elements"]}),
    // rust: out,
    // rust: )
}

pub fn main() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = io::BufWriter::new(io::stdout().lock());
    // rust: for line in io::stdin().lock().lines() {
    // rust: let line = line?;
    // rust: let mut args = line.splitn(5, ' ');
    // rust: let command = args.next().ok_or("command")?;
    // rust: if command == "tag_entry" {
    // rust: match horizon_world::worldgen::tags::TagEntry::from_json(
    // rust: line.strip_prefix("tag_entry ").ok_or("entry")?,
    // rust: ) {
    // rust: Ok(e) => writeln!(out, "tag entry {}", e.display())?,
    // rust: Err(_) => writeln!(out, "tag entry error")?,
}
    // rust: continue;
}
    // rust: if command == "tag_file" {
    // rust: match horizon_world::worldgen::tags::TagFile::from_json(
    // rust: line.strip_prefix("tag_file ").ok_or("file")?,
    // rust: ) {
    // rust: Ok(file) => {
    // rust: writeln!(out, "tag file {} {}", file.replace, file.entries.len())?;
    // rust: for e in file.entries {
    // rust: writeln!(out, "tag entry {}", e.display())?;
}
}
    // rust: Err(_) => writeln!(out, "tag file error")?,
}
    // rust: continue;
}
    // rust: if command == "tag_registry" {
    // rust: tag_registry_probe(
    // rust: line.strip_prefix("tag_registry ").ok_or("registry")?,
    // rust: &mut out,
    // rust: )?;
    // rust: continue;
}
    // rust: if command == "tags" {
    // rust: tags_probe(
    // rust: &serde_json::from_str(line.strip_prefix("tags ").ok_or("tags")?)?,
    // rust: &mut out,
    // rust: )?;
    // rust: continue;
}
    // rust: if command == "noise_aquifer" {
    // rust: noise_aquifer_probe(&line, &mut out)?;
    // rust: continue;
}
    // rust: if command == "aquifer" {
    // rust: aquifer_probe(&line, &mut out)?;
    // rust: continue;
}
    // rust: if command == "noise_settings" {
    // rust: match horizon_world::worldgen::settings::NoiseSettings::from_json(
    // rust: line.strip_prefix("noise_settings ")
    // rust: .ok_or("settings json")?,
    // rust: ) {
    // rust: Ok(settings) => settings_probe(settings, &mut out)?,
    // rust: Err(_) => writeln!(out, "settings error")?,
}
    // rust: continue;
}
    // rust: if command == "settings_create" {
    // rust: let values: Vec<i32> = line
    // rust: .split_whitespace()
    // rust: .skip(1)
    // rust: .map(str::parse)
    // rust: .collect::<Result<_, _>>()?;
    // rust: match horizon_world::worldgen::settings::NoiseSettings::create(values[0], values[1]) {
    // rust: Ok(settings) => settings_probe(settings, &mut out)?,
    // rust: Err(_) => writeln!(out, "settings error")?,
}
    // rust: continue;
}
    // rust: if command == "climate_parameter" {
    // rust: match horizon_world::worldgen::climate::decode_parameter(
    // rust: line.strip_prefix("climate_parameter ")
    // rust: .ok_or("parameter json")?,
    // rust: ) {
    // rust: Ok(p) => writeln!(out, "parameter {} {}", p.min, p.max)?,
    // rust: Err(_) => writeln!(out, "parameter error")?,
}
    // rust: continue;
}
    // rust: if command == "climate_point" {
    // rust: match horizon_world::worldgen::climate::decode_parameter_point(
    // rust: line.strip_prefix("climate_point ").ok_or("point json")?,
    // rust: ) {
    // rust: Ok(p) => {
    // rust: write!(out, "parameterpoint")?;
    // rust: for coordinate in p.coordinates {
    // rust: write!(out, " {} {}", coordinate.min, coordinate.max)?;
}
    // rust: writeln!(out, " {}", p.offset)?;
}
    // rust: Err(_) => writeln!(out, "parameterpoint error")?,
}
    // rust: continue;
}
    // rust: if command == "index" {
    // rust: let mut args = line.splitn(3, ' ');
    // rust: args.next();
    // rust: let branching = args.next().ok_or("branching")?.parse::<usize>()?;
    // rust: index_probe(branching, args.next().ok_or("index json")?, &mut out)?;
    // rust: continue;
}
    // rust: if command == "quantize" {
    // rust: let mut values = line.split_whitespace().skip(1);
    // rust: write!(out, "quantized")?;
    // rust: for _ in 0..6 {
    // rust: let value = f32::from_bits(u32::from_str_radix(values.next().ok_or("float")?, 16)?);
    // rust: write!(
    // rust: out,
    // rust: " {}",
    // rust: horizon_world::worldgen::climate::quantize(value)
    // rust: )?;
}
    // rust: writeln!(out)?;
    // rust: let value = values.next().ok_or("long")?.parse::<i64>()?;
    // rust: writeln!(
    // rust: out,
    // rust: "unquantized {}",
    // rust: bits(horizon_world::worldgen::climate::unquantize(value))
    // rust: )?;
    // rust: continue;
}
    // rust: let seed = args.next().ok_or("seed")?.parse::<i64>()?;
    // rust: let legacy = args.next().ok_or("stream")? == "1";
    // rust: let nether = args.next().ok_or("nether")? == "1";
    // rust: let json = args.next().ok_or("json")?;
    // rust: if command == "router" {
    // rust: let (path, setting) = json.split_once(' ').ok_or("router setting")?;
    // rust: router_probe(path, setting, seed, legacy, nether, &mut out)?;
    // rust: continue;
}
    // rust: if command == "registry" {
    // rust: registry_probe(json, seed, legacy, nether, &mut out)?;
    // rust: continue;
}
    // rust: if command != "noise" {
    // rust: return Err("unknown command".into());
}
    // rust: let noise = match decode_noise(json) {
    // rust: Ok(noise) => noise,
    // rust: Err(_) => {
    // rust: writeln!(out, "decode error")?;
    // rust: continue;
}
}
    // rust: let [min, max] = noise.range();
    // rust: writeln!(
    // rust: out,
    // rust: "decode {} {} {} {}",
    // rust: noise.octaves().len(),
    // rust: noise.normalization_factor().to_bits(),
    // rust: bits(min),
    // rust: bits(max)
    // rust: )?;
    // rust: for octave in noise.octaves() {
    // rust: writeln!(
    // rust: out,
    // rust: "octave {} {} {}",
    // rust: octave.octave_index,
    // rust: octave.frequency.to_bits(),
    // rust: octave.amplitude.to_bits()
    // rust: )?;
}
    // rust: if legacy {
    // rust: probe(&noise, &mut LegacyRandom::new(seed), nether, &mut out)?;
    // rust: } else {
    // rust: probe(&noise, &mut XoroshiroRandom::new(seed), nether, &mut out)?;
}
}
    // rust: Ok(())
}
