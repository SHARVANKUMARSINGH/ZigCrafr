//! Transpiled from Horizon Rust crate
package horizon_core_noise_parity

import "core:fmt"
import "core:mem"
import "core:math"

// Test transport for comparing noise with the downloaded vanilla artifacts.
// use horizon_core::{
    // rust: geometry::Axis,
    // rust: noise::{
    // rust: DensityVolume, GradientTable, Noise, NoiseBuildError, NoiseStack, NormalNoise,
    // rust: Normalization, PerlinNoise, SimplexNoise, SmearedPerlinNoise, wrap,
    // rust: },
    // rust: random::{LegacyRandom, RandomSource, XoroshiroRandom},
}
// use std::io::{self, BufRead, BufWriter, Write};
// use std::sync::Arc;

Sampler :: enum {
    Perlin(PerlinNoise),
    Simplex(SimplexNoise),
    Smeared(SmearedPerlinNoise),
    Stack(NoiseStack),
}
    // rust: impl Sampler {
table :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Perlin(n) => n.table(),
    // rust: Self::Simplex(n) => n.table(),
    // rust: Self::Smeared(n) => n.table(),
    // rust: Self::Stack(_) => panic!("stack has no gradient table"),
}
}
as_noise :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Perlin(n) => n,
    // rust: Self::Simplex(n) => n,
    // rust: Self::Smeared(n) => n,
    // rust: Self::Stack(n) => n,
}
}
shared_noise :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Perlin(n) => Arc::new(n.clone()),
    // rust: Self::Simplex(n) => Arc::new(n.clone()),
    // rust: Self::Smeared(n) => Arc::new(n.clone()),
    // rust: Self::Stack(n) => Arc::new(n.clone()),
}
}
range :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.as_noise().range()
}
get2 :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.as_noise().get2(x, z)
}
get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.as_noise().get3(x, y, z)
}
}
    // rust: fn read<T: std::str::FromStr>(
    // rust: args: &mut std::str::SplitWhitespace<'_>,
    // rust: ) -> Result<T, Box<dyn std::error::Error>> {
    // rust: args.next()
    // rust: .ok_or("missing argument")?
    // rust: .parse()
    // rust: .map_err(|_| "invalid argument".into())
}
double :: proc(args: ^std::str::SplitWhitespace<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(f64::from_bits(u64::from_str_radix(
    // rust: args.next().ok_or("missing double")?,
    // rust: 16,
    // rust: )?))
}
float :: proc(args: ^std::str::SplitWhitespace<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(f32::from_bits(u32::from_str_radix(
    // rust: args.next().ok_or("missing float")?,
    // rust: 16,
    // rust: )?))
}
bits :: proc(v: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_nan() { 0x7fc0_0000 } else { v.to_bits() }
}
dbits :: proc(v: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_nan() {
    // rust: 0x7ff8_0000_0000_0000
    // rust: } else {
    // rust: v.to_bits()
}
}
    // rust: fn create<R: RandomSource>(
    // rust: kind: &str,
    // rust: mut rng: R,
    // rust: skip: bool,
    // rust: scale: f64,
    // rust: out: &mut impl Write,
    // rust: ) -> io::Result<Sampler> {
    // rust: let sampler = match kind {
    // rust: "perlin" => Sampler::Perlin(PerlinNoise::new(&mut rng)),
    // rust: "simplex" => Sampler::Simplex(SimplexNoise::with_skipped_offsets(&mut rng, skip)),
    // rust: "smeared" => Sampler::Smeared(SmearedPerlinNoise::new(&mut rng, scale)),
    // rust: _ => {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidInput,
    // rust: "unknown sampler",
    // rust: ));
}
}
    // rust: let offsets = sampler.table().offsets();
    // rust: let range = sampler.range();
    // rust: let (lower, upper) = match range {
    // rust: Ok(range) => (bits(range[0]).to_string(), bits(range[1]).to_string()),
    // rust: Err(_) => ("error".to_owned(), "error".to_owned()),
}
    // rust: writeln!(
    // rust: out,
    // rust: "create {} {} {} {} {} {}",
    // rust: dbits(offsets[0]),
    // rust: dbits(offsets[1]),
    // rust: dbits(offsets[2]),
    // rust: lower,
    // rust: upper,
    // rust: rng.next_long()
    // rust: )?;
    // rust: write!(out, "permutations")?;
    // rust: for v in sampler.table().permutations() {
    // rust: write!(out, " {v}")?;
}
    // rust: writeln!(out)?;
    // rust: Ok(sampler)
}
    // rust: fn normal_probe<R: RandomSource>(
    // rust: out: &mut impl Write,
    // rust: definition: Result<NormalNoise, NoiseBuildError>,
    // rust: mut random: R,
    // rust: points: &[[f64; 3]],
    // rust: legacy: bool,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let Ok(definition) = definition else {
    // rust: writeln!(out, "normal error {}", random.next_long())?;
    // rust: return Ok(());
}
    // rust: let range = definition.range();
    // rust: writeln!(
    // rust: out,
    // rust: "normal {} {} {} {}",
    // rust: definition.octaves().len(),
    // rust: dbits(definition.normalization_factor()),
    // rust: bits(range[0]),
    // rust: bits(range[1])
    // rust: )?;
    // rust: for octave in definition.octaves() {
    // rust: writeln!(
    // rust: out,
    // rust: "octave {} {} {} {}",
    // rust: octave.octave_index,
    // rust: dbits(octave.frequency),
    // rust: dbits(octave.amplitude),
    // rust: octave.seed()
    // rust: )?;
}
    // rust: let created = if legacy {
    // rust: definition.create_for_legacy_nether_biome(&mut random)
    // rust: } else {
    // rust: definition.create(&mut random)
}
    // rust: match created {
    // rust: Err(_) => writeln!(out, "normal-create error")?,
    // rust: Ok(noise) => {
    // rust: let range = noise.range()?;
    // rust: writeln!(
    // rust: out,
    // rust: "normal-create {} {} {}",
    // rust: noise.layers().len(),
    // rust: bits(range[0]),
    // rust: bits(range[1])
    // rust: )?;
    // rust: for layer in noise.layers() {
    // rust: writeln!(
    // rust: out,
    // rust: "normal-layer {} {} {} {}",
    // rust: dbits(layer.frequency),
    // rust: bits(layer.amplitude),
    // rust: bits(layer.noise.get2(0.25, 0.75)),
    // rust: bits(layer.noise.get3(-17.25, 64.125, 32.5))
    // rust: )?;
}
    // rust: for &[x, y, z] in points {
    // rust: writeln!(
    // rust: out,
    // rust: "normal-query {} {}",
    // rust: bits(noise.get2(x, z)),
    // rust: bits(noise.get3(x, y, z))
    // rust: )?;
}
    // rust: let volume = DensityVolume::new([2, 5, 2], [-17, -64, 32], [4, 1, 4])?;
    // rust: let mut values: Vec<f32> = (0..volume.size())
    // rust: .map(|i| (i as f32 - 10.0) * 0.125)
    // rust: .collect();
    // rust: for (pass, amplitude) in [0.5, -0.25].into_iter().enumerate() {
    // rust: noise.add_to_volume(&mut values, volume, 0.125, 0.25, amplitude)?;
    // rust: for (i, value) in values.iter().enumerate() {
    // rust: writeln!(out, "normal-volume {pass} {i} {}", bits(*value))?;
}
}
}
}
    // rust: writeln!(out, "normal-parent {}", random.next_long())?;
    // rust: Ok(())
}
main :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let stdin = io::stdin();
    // rust: let mut out = BufWriter::new(io::stdout().lock());
    // rust: let mut samplers = Vec::new();
    // rust: for line in stdin.lock().lines() {
    // rust: let line = line?;
    // rust: let mut args = line.split_whitespace();
    // rust: match args.next().ok_or("missing operation")? {
    // rust: "normal" => {
    // rust: let kind = args.next().ok_or("missing RNG kind")?;
    // rust: let seed: i64 = read(&mut args)?;
    // rust: let parity: i32 = read(&mut args)?;
    // rust: let base: i32 = read(&mut args)?;
    // rust: let count: i32 = read(&mut args)?;
    // rust: let normalization: i32 = read(&mut args)?;
    // rust: let amplitude = double(&mut args)?;
    // rust: let modifiers: usize = read(&mut args)?;
    // rust: let modifiers = (0..modifiers)
    // rust: .map(|_| double(&mut args))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let point_count: usize = read(&mut args)?;
    // rust: let points = (0..point_count)
    // rust: .map(|_| Ok([double(&mut args)?, double(&mut args)?, double(&mut args)?]))
    // rust: .collect::<Result<Vec<_>, Box<dyn std::error::Error>>>()?;
    // rust: let definition = if parity & 1 != 0 {
    // rust: NormalNoise::create_parity(base, &modifiers)
    // rust: } else {
    // rust: (|| {
    // rust: let mut builder = NormalNoise::builder();
    // rust: builder
    // rust: .set_base_octave(base)
    // rust: .set_base_amplitude(amplitude)
    // rust: .set_normalization(match normalization {
    // rust: 0 => Normalization::Disabled,
    // rust: 1 => Normalization::Enabled,
    // rust: _ => Normalization::Legacy,
    // rust: });
    // rust: builder.set_octave_count(count)?;
    // rust: for (index, value) in modifiers.iter().enumerate() {
    // rust: builder.set_amplitude_modifier(index as i32, *value)?;
}
    // rust: builder.build()
    // rust: })()
}
    // rust: match kind {
    // rust: "legacy" => normal_probe(
    // rust: &mut out,
    // rust: definition,
    // rust: LegacyRandom::new(seed),
    // rust: &points,
    // rust: parity & 2 != 0,
    // rust: )?,
    // rust: "xoroshiro" => normal_probe(
    // rust: &mut out,
    // rust: definition,
    // rust: XoroshiroRandom::new(seed),
    // rust: &points,
    // rust: parity & 2 != 0,
    // rust: )?,
    // rust: _ => return Err("unknown stream".into()),
}
}
    // rust: "create" => {
    // rust: let kind = args.next().ok_or("missing sampler")?;
    // rust: let stream = args.next().ok_or("missing stream")?;
    // rust: let seed: i64 = read(&mut args)?;
    // rust: let skip: i32 = read(&mut args)?;
    // rust: let scale = double(&mut args)?;
    // rust: let sampler = match stream {
    // rust: "legacy" => create(kind, LegacyRandom::new(seed), skip != 0, scale, &mut out)?,
    // rust: "xoroshiro" => {
    // rust: create(kind, XoroshiroRandom::new(seed), skip != 0, scale, &mut out)?
}
    // rust: _ => return Err("unknown stream".into()),
}
    // rust: samplers.push(sampler);
}
    // rust: operation @ ("query" | "local") => {
    // rust: let id: usize = read(&mut args)?;
    // rust: let mut point = [double(&mut args)?, double(&mut args)?, double(&mut args)?];
    // rust: let mut derivative = [float(&mut args)?, float(&mut args)?, float(&mut args)?];
    // rust: let sampler = &samplers[id];
    // rust: if operation == "local" {
    // rust: for (value, offset) in point.iter_mut().zip(sampler.table().offsets()) {
    // rust: *value -= offset;
}
}
    // rust: let [x, y, z] = point;
    // rust: write!(
    // rust: out,
    // rust: "query {} {}",
    // rust: bits(sampler.get2(x, z)),
    // rust: bits(sampler.get3(x, y, z))
    // rust: )?;
    // rust: let value = match sampler {
    // rust: Sampler::Perlin(n) => Some(n.noise_with_derivative(x, y, z, &mut derivative)),
    // rust: Sampler::Smeared(n) => Some(n.noise_with_derivative(x, y, z, &mut derivative)),
    // rust: Sampler::Simplex(_) | Sampler::Stack(_) => None,
}
    // rust: if let Some(value) = value {
    // rust: write!(
    // rust: out,
    // rust: " {} {} {} {}",
    // rust: bits(value),
    // rust: bits(derivative[0]),
    // rust: bits(derivative[1]),
    // rust: bits(derivative[2])
    // rust: )?;
}
    // rust: writeln!(out)?;
}
    // rust: "volume" => {
    // rust: let id: usize = read(&mut args)?;
    // rust: let sizes = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let minimum = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let steps = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let xz_scale = double(&mut args)?;
    // rust: let y_scale = double(&mut args)?;
    // rust: let amplitude = float(&mut args)?;
    // rust: let seed: i64 = read(&mut args)?;
    // rust: let repeats: usize = read(&mut args)?;
    // rust: match DensityVolume::new(sizes, minimum, steps) {
    // rust: Err(_) => writeln!(out, "volume error")?,
    // rust: Ok(volume) => {
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let mut values: Vec<f32> = (0..volume.size() + 4)
    // rust: .map(|_| f32::from_bits(random.next_int() as u32))
    // rust: .collect();
    // rust: let sampler = &samplers[id];
    // rust: for _ in 0..repeats {
    // rust: sampler.as_noise().add_to_volume(
    // rust: &mut values,
    // rust: volume,
    // rust: xz_scale,
    // rust: y_scale,
    // rust: amplitude,
    // rust: )?;
}
    // rust: let maximum = volume.maximum();
    // rust: writeln!(
    // rust: out,
    // rust: "volume {} {} {} {}",
    // rust: volume.size(),
    // rust: maximum[0],
    // rust: maximum[1],
    // rust: maximum[2]
    // rust: )?;
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: for z in 0..sz {
    // rust: for x in 0..sx {
    // rust: for y in 0..sy {
    // rust: let index = volume.index([x, y, z]).unwrap();
    // rust: writeln!(
    // rust: out,
    // rust: "cell {index} {} {} {} {}",
    // rust: volume.block(Axis::X, x).unwrap(),
    // rust: volume.block(Axis::Y, y).unwrap(),
    // rust: volume.block(Axis::Z, z).unwrap(),
    // rust: bits(values[index])
    // rust: )?;
}
}
}
    // rust: for value in &values[volume.size()..] {
    // rust: writeln!(out, "tail {}", bits(*value))?;
}
}
}
}
    // rust: "stack" => {
    // rust: let count: usize = read(&mut args)?;
    // rust: let mut builder = NoiseStack::builder();
    // rust: for _ in 0..count {
    // rust: let flatten: i32 = read(&mut args)?;
    // rust: let id: usize = read(&mut args)?;
    // rust: let frequency = double(&mut args)?;
    // rust: let amplitude = float(&mut args)?;
    // rust: if flatten != 0 {
    // rust: let Sampler::Stack(stack) = &samplers[id] else {
    // rust: return Err("flatten expects a stack".into());
}
    // rust: builder.add_stack(stack, frequency, amplitude);
    // rust: } else {
    // rust: builder.add(samplers[id].shared_noise(), frequency, amplitude);
}
}
    // rust: match builder.build() {
    // rust: Err(_) => writeln!(out, "stack error")?,
    // rust: Ok(stack) => {
    // rust: let range = stack.range()?;
    // rust: writeln!(
    // rust: out,
    // rust: "stack {} {} {}",
    // rust: stack.layers().len(),
    // rust: bits(range[0]),
    // rust: bits(range[1])
    // rust: )?;
    // rust: for (index, layer) in stack.layers().iter().enumerate() {
    // rust: writeln!(
    // rust: out,
    // rust: "layer {} {} {}",
    // rust: dbits(layer.frequency),
    // rust: bits(layer.amplitude),
    // rust: bits(stack.get_layer(index).unwrap().get3(0.0, 0.0, 0.0))
    // rust: )?;
}
    // rust: samplers.push(Sampler::Stack(stack));
}
}
}
    // rust: "wrap" => writeln!(out, "wrap {}", dbits(wrap(double(&mut args)?)))?,
    // rust: _ => return Err("unknown operation".into()),
}
    // rust: if args.next().is_some() {
    // rust: return Err("extra argument".into());
}
}
    // rust: out.flush()?;
    // rust: Ok(())
}
