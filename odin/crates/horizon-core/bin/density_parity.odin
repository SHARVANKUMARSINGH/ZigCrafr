//! Transpiled from Horizon Rust crate
package horizon_core_density_parity

import "core:fmt"
import "core:mem"
import "core:math"

// Original line transport for differential tests of density evaluation.
// use horizon_core::density::graph::{
    // rust: DensityCompiler, DensityGraph, FunctionId, GraphBinary, GraphNode, GraphUnary, NoiseId,
}
// use horizon_core::{
    // rust: density::{
    // rust: BinaryOp, BinarySampler, BlendDensitySampler, BlendedNoise, CachingDensitySampler,
    // rust: ConstantSampler, ContextBoundSampler, CubicSpline, DensitySampler, DensityValue,
    // rust: DistanceMetric, DistanceToPointSampler, EmptyBlender, FindTopSurfaceSampler,
    // rust: GradientSampler, InterpolatedSampler, Interval, IntervalError, IntervalSelectSampler,
    // rust: LerpSampler, NoiseSampler, PowerSampler, RangeChoiceSampler, RoundMode, RoundSampler,
    // rust: SamplerContext, ShiftNoiseKind, ShiftedNoiseSampler, SliceAxes, SliceSampler, SplinePoint,
    // rust: SplineSampler, TilingMode, UnaryOp, UnarySampler, WorldField, WorldFields,
    // rust: compile_shift_noise, compile_surface_search, create_blended_fbm,
    // rust: },
    // rust: geometry::Axis,
    // rust: noise::{
    // rust: DensityVolume, Noise, NormalNoise, Normalization, PerlinNoise, SimplexNoise,
    // rust: SmearedPerlinNoise,
    // rust: },
    // rust: random::{LegacyRandom, RandomSource, XoroshiroRandom},
}
// use std::{
    // rust: io::{self, BufRead, BufWriter, Write},
    // rust: sync::Arc,
}
CountedSampler :: struct {
    input: ^dyn DensitySampler,
    calls: Arc<[std::sync::atomic::AtomicUsize,
}
    // rust: impl DensitySampler for CountedSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, horizon_core::density::SampleError> {
    // rust: self.calls[0].fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: self.input.sample_value(context, position)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), horizon_core::density::SampleError> {
    // rust: self.calls[1].fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: self.input.sample_volume(context, buffer, volume)
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
float :: proc(args: ^std::str::SplitWhitespace<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(f32::from_bits(u32::from_str_radix(
    // rust: args.next().ok_or("missing float")?,
    // rust: 16,
    // rust: )?))
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
bits :: proc(v: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_nan() { 0x7fc0_0000 } else { v.to_bits() }
}
noise :: proc(kind: string, mut random: impl RandomSource, scale: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: "normal" => {
    // rust: let mut definition = NormalNoise::builder();
    // rust: definition.set_base_octave(-7);
    // rust: definition.set_octave_count(4).unwrap();
    // rust: Arc::new(definition.build().unwrap().create(&mut random).unwrap())
}
    // rust: "perlin" => Arc::new(PerlinNoise::new(&mut random)),
    // rust: "simplex" => Arc::new(SimplexNoise::new(&mut random)),
    // rust: "smeared" => Arc::new(SmearedPerlinNoise::new(&mut random, scale)),
    // rust: _ => panic!("unknown noise kind"),
}
}
    // rust: fn interval_output(
    // rust: out: &mut impl Write,
    // rust: name: &str,
    // rust: result: Result<Interval, IntervalError>,
    // rust: ) -> io::Result<()> {
    // rust: match result {
    // rust: Ok(range) => writeln!(
    // rust: out,
    // rust: "bounds {name} {} {} {} {}",
    // rust: bits(range.min()),
    // rust: bits(range.max()),
    // rust: u8::from(range.is_nai()),
    // rust: range.java_hash_code()
    // rust: ),
    // rust: Err(_) => writeln!(out, "bounds {name} error"),
}
}
    // rust: fn blended_probe(
    // rust: random: &mut impl RandomSource,
    // rust: definition: BlendedNoise,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<Option<Arc<dyn DensitySampler>>, Box<dyn std::error::Error>> {
    // rust: interval_output(out, "blended", definition.range())?;
    // rust: let result = definition.compile(random);
    // rust: writeln!(
    // rust: out,
    // rust: "blended {} {}",
    // rust: if result.is_ok() { "ok" } else { "error" },
    // rust: random.next_long()
    // rust: )?;
    // rust: Ok(result
    // rust: .ok()
    // rust: .map(|value| Arc::new(value) as Arc<dyn DensitySampler>))
}
    // rust: fn fbm_probe(
    // rust: random: &mut impl RandomSource,
    // rust: octave: i32,
    // rust: smear: f64,
    // rust: amplitude: f64,
    // rust: out: &mut impl Write,
    // rust: ) -> Result<(), Box<dyn std::error::Error>> {
    // rust: let result = create_blended_fbm(random, octave, smear, amplitude);
    // rust: match result {
    // rust: Ok(stack) => {
    // rust: let range = stack.range()?;
    // rust: writeln!(
    // rust: out,
    // rust: "fbm {} {} {}",
    // rust: stack.layers().len(),
    // rust: bits(range[0]),
    // rust: bits(range[1])
    // rust: )?;
    // rust: for layer in stack.layers() {
    // rust: writeln!(
    // rust: out,
    // rust: "fbm-layer {} {} {}",
    // rust: layer.frequency.to_bits(),
    // rust: bits(layer.amplitude),
    // rust: bits(layer.noise.get3(-17.25, 64.125, 32.5))
    // rust: )?;
}
    // rust: for point in [
    // rust: [0.0; 3],
    // rust: [-17.25, 64.125, 32.5],
    // rust: [3e7, -64.0, -3e7],
    // rust: [f64::INFINITY; 3],
    // rust: ] {
    // rust: writeln!(
    // rust: out,
    // rust: "fbm-query {} {}",
    // rust: bits(stack.get2(point[0], point[2])),
    // rust: bits(stack.get3(point[0], point[1], point[2]))
    // rust: )?;
}
    // rust: let volume = DensityVolume::new([2, 5, 2], [-17, -64, 32], [4, 1, 4])?;
    // rust: let mut buffer = vec![0.0; volume.size() + 2];
    // rust: for (i, v) in buffer.iter_mut().enumerate() {
    // rust: *v = (i as f32 - 10.0) * 0.125;
}
    // rust: stack.add_to_volume(&mut buffer, volume, 0.125, 0.25, -0.5)?;
    // rust: for value in buffer {
    // rust: writeln!(out, "fbm-cell {}", bits(value))?;
}
}
    // rust: Err(_) => writeln!(out, "fbm error")?,
}
    // rust: writeln!(out, "fbm-parent {}", random.next_long())?;
    // rust: Ok(())
}
main :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut samplers: Vec<Arc<dyn DensitySampler>> = Vec::new();
    // rust: let mut graph_compiler = DensityCompiler::new(DensityGraph::new());
    // rust: let mut functions: Vec<FunctionId> = Vec::new();
    // rust: let mut graph_splines: Vec<CubicSpline<FunctionId>> = Vec::new();
    // rust: let mut graph_noises: Vec<NoiseId> = Vec::new();
    // rust: let mut noises = Vec::new();
    // rust: let mut splines: Vec<CubicSpline> = Vec::new();
    // rust: let mut counters: Vec<Arc<[std::sync::atomic::AtomicUsize; 2]>> = Vec::new();
    // rust: let mut context = SamplerContext::default();
    // rust: let mut out = BufWriter::new(io::stdout().lock());
    // rust: for line in io::stdin().lock().lines() {
    // rust: let line = line?;
    // rust: let mut args = line.split_whitespace();
    // rust: match args.next().ok_or("empty command")? {
    // rust: "constant" => {
    // rust: samplers.push(Arc::new(ConstantSampler(float(&mut args)?)));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "gradient" => {
    // rust: let axis = Axis::ALL[read::<usize>(&mut args)?];
    // rust: let tiling = [
    // rust: TilingMode::ClampToEdge,
    // rust: TilingMode::Repeat,
    // rust: TilingMode::MirroredRepeat,
    // rust: ][read::<usize>(&mut args)?];
    // rust: let from = read(&mut args)?;
    // rust: let to = read(&mut args)?;
    // rust: let low = float(&mut args)?;
    // rust: let high = float(&mut args)?;
    // rust: samplers.push(Arc::new(GradientSampler::new(
    // rust: axis, tiling, from, to, low, high,
    // rust: )));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "noise" => {
    // rust: let kind = args.next().ok_or("missing noise kind")?;
    // rust: let stream = args.next().ok_or("missing stream")?;
    // rust: let seed = read(&mut args)?;
    // rust: let scale = double(&mut args)?;
    // rust: let source = if stream == "legacy" {
    // rust: noise(kind, LegacyRandom::new(seed), scale)
    // rust: } else {
    // rust: noise(kind, XoroshiroRandom::new(seed), scale)
}
    // rust: let sampler = NoiseSampler {
    // rust: noise: source,
    // rust: xz_scale: double(&mut args)?,
    // rust: y_scale: double(&mut args)?,
}
    // rust: noises.push(sampler.clone());
    // rust: samplers.push(Arc::new(sampler));
    // rust: writeln!(out, "noise {} {}", noises.len() - 1, samplers.len() - 1)?;
}
    // rust: "shift" => {
    // rust: let source = noises[read::<usize>(&mut args)?].clone();
    // rust: let x = read::<usize>(&mut args)?;
    // rust: let y = read::<i32>(&mut args)?;
    // rust: let z = read::<usize>(&mut args)?;
    // rust: samplers.push(Arc::new(ShiftedNoiseSampler {
    // rust: source,
    // rust: shift_x: samplers[x].clone(),
    // rust: shift_y: if y < 0 {
    // rust: None
    // rust: } else {
    // rust: Some(samplers[y as usize].clone())
    // rust: },
    // rust: shift_z: samplers[z].clone(),
    // rust: }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "unary" => {
    // rust: let kind = args.next().ok_or("missing unary kind")?;
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let a = float(&mut args)?;
    // rust: let b = float(&mut args)?;
    // rust: let operation = match kind {
    // rust: "abs" => UnaryOp::Abs,
    // rust: "negate" => UnaryOp::Negate,
    // rust: "square" => UnaryOp::Square,
    // rust: "cube" => UnaryOp::Cube,
    // rust: "sqrt" => UnaryOp::Sqrt,
    // rust: "log" => UnaryOp::Log,
    // rust: "reciprocal" => UnaryOp::Reciprocal,
    // rust: "sign" => UnaryOp::Sign,
    // rust: "squeeze" => UnaryOp::Squeeze,
    // rust: "leaky" => UnaryOp::LeakyRelu(a),
    // rust: "add" => UnaryOp::Add(a),
    // rust: "sub" => UnaryOp::SubtractFrom(a),
    // rust: "mul" => UnaryOp::Multiply(a),
    // rust: "div" => UnaryOp::DivideInto(a),
    // rust: "min" => UnaryOp::Minimum(a),
    // rust: "max" => UnaryOp::Maximum(a),
    // rust: "clamp" => UnaryOp::Clamp { min: a, max: b },
    // rust: _ => return Err("unknown unary kind".into()),
}
    // rust: samplers.push(Arc::new(UnarySampler { input, operation }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "power" => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let sampler: Arc<dyn DensitySampler> = match mode {
    // rust: 0 => Arc::new(PowerSampler {
    // rust: base: samplers[read::<usize>(&mut args)?].clone(),
    // rust: exponent: samplers[read::<usize>(&mut args)?].clone(),
    // rust: }),
    // rust: 1 => {
    // rust: let base = double(&mut args)?;
    // rust: Arc::new(UnarySampler {
    // rust: input: samplers[read::<usize>(&mut args)?].clone(),
    // rust: operation: UnaryOp::PowerBase(base),
    // rust: })
}
    // rust: 2 => {
    // rust: let base = samplers[read::<usize>(&mut args)?].clone();
    // rust: Arc::new(UnarySampler {
    // rust: input: base,
    // rust: operation: UnaryOp::PowerExponent(double(&mut args)?),
    // rust: })
}
    // rust: _ => return Err("unknown power mode".into()),
}
    // rust: samplers.push(sampler);
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "round" => {
    // rust: let mode = [
    // rust: RoundMode::Floor,
    // rust: RoundMode::Round,
    // rust: RoundMode::Ceil,
    // rust: RoundMode::Truncate,
    // rust: ][read::<usize>(&mut args)?];
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let multiple = read::<i32>(&mut args)?;
    // rust: let multiple = if multiple < 0 {
    // rust: None
    // rust: } else {
    // rust: Some(samplers[multiple as usize].clone())
}
    // rust: samplers.push(Arc::new(RoundSampler {
    // rust: mode,
    // rust: input,
    // rust: multiple,
    // rust: }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "binary" => {
    // rust: let kind = args.next().ok_or("missing binary kind")?;
    // rust: let left = samplers[read::<usize>(&mut args)?].clone();
    // rust: let right = samplers[read::<usize>(&mut args)?].clone();
    // rust: let bound = float(&mut args)?;
    // rust: let operation = match kind {
    // rust: "add" => BinaryOp::Add,
    // rust: "sub" => BinaryOp::Subtract,
    // rust: "mul" => BinaryOp::Multiply,
    // rust: "div" => BinaryOp::Divide,
    // rust: "min" => BinaryOp::Minimum { right_min: bound },
    // rust: "max" => BinaryOp::Maximum { right_max: bound },
    // rust: _ => return Err("unknown binary kind".into()),
}
    // rust: samplers.push(Arc::new(BinarySampler {
    // rust: left,
    // rust: right,
    // rust: operation,
    // rust: }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "choice" => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let min_inclusive = float(&mut args)?;
    // rust: let max_exclusive = float(&mut args)?;
    // rust: let sampler: Arc<dyn DensitySampler> = if mode == 1 {
    // rust: let inside = float(&mut args)?;
    // rust: let outside = float(&mut args)?;
    // rust: Arc::new(UnarySampler {
    // rust: input,
    // rust: operation: UnaryOp::ConstantRangeChoice {
    // rust: min_inclusive,
    // rust: max_exclusive,
    // rust: inside,
    // rust: outside,
    // rust: },
    // rust: })
    // rust: } else {
    // rust: let when_in_range = samplers[read::<usize>(&mut args)?].clone();
    // rust: let when_out_of_range = samplers[read::<usize>(&mut args)?].clone();
    // rust: Arc::new(RangeChoiceSampler {
    // rust: input,
    // rust: min_inclusive,
    // rust: max_exclusive,
    // rust: when_in_range,
    // rust: when_out_of_range,
    // rust: })
}
    // rust: samplers.push(sampler);
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "lerp" => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let alpha = samplers[read::<usize>(&mut args)?].clone();
    // rust: let first = if mode == 1 {
    // rust: DensityValue::Constant(float(&mut args)?)
    // rust: } else {
    // rust: DensityValue::Sampler(samplers[read::<usize>(&mut args)?].clone())
}
    // rust: let second = if mode == 2 {
    // rust: DensityValue::Constant(float(&mut args)?)
    // rust: } else {
    // rust: DensityValue::Sampler(samplers[read::<usize>(&mut args)?].clone())
}
    // rust: samplers.push(Arc::new(LerpSampler {
    // rust: alpha,
    // rust: first,
    // rust: second,
    // rust: }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "interval" => {
    // rust: let _specialization = read::<u8>(&mut args)?;
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let count = read::<usize>(&mut args)?;
    // rust: let thresholds = (0..count)
    // rust: .map(|_| float(&mut args))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let branches = (0..=count)
    // rust: .map(|_| read::<usize>(&mut args).map(|id| samplers[id].clone()))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: samplers.push(Arc::new(IntervalSelectSampler::new(
    // rust: input, thresholds, branches,
    // rust: )?));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "bounds" => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let a = float(&mut args)?;
    // rust: let b = float(&mut args)?;
    // rust: let c = float(&mut args)?;
    // rust: let d = float(&mut args)?;
    // rust: let e = float(&mut args)?;
    // rust: let f = float(&mut args)?;
    // rust: let result = match mode {
    // rust: 0 => Interval::new(a, b),
    // rust: 1 => Interval::symmetric(a),
    // rust: 2 => Interval::exact(a),
    // rust: 3 => Ok(Interval::encapsulating_values(a, b)),
    // rust: 4 => Ok(Interval::NAI),
    // rust: 5 => Ok(Interval::INFINITE),
    // rust: _ => return Err("unknown interval constructor".into()),
}
    // rust: interval_output(&mut out, "create", result)?;
    // rust: if let Ok(left) = result {
    // rust: let right = Interval::encapsulating_values(c, d);
    // rust: let third = Interval::encapsulating_values(e, f);
    // rust: interval_output(&mut out, "right", Ok(right))?;
    // rust: for (name, value) in [
    // rust: ("add", left.add_range(right)),
    // rust: ("sub", left.subtract_range(right)),
    // rust: ("mul", left.multiply_range(right)),
    // rust: ("div", left.divide_range(right)),
    // rust: ("min", left.minimum(right)),
    // rust: ("max", left.maximum(right)),
    // rust: ("reciprocal", left.reciprocal()),
    // rust: ("abs", left.abs()),
    // rust: ("square", left.square()),
    // rust: ("sign", left.sign()),
    // rust: ("power", left.power(right)),
    // rust: ] {
    // rust: interval_output(&mut out, name, Ok(value))?;
}
    // rust: interval_output(&mut out, "clamp", left.clamp(c, d))?;
    // rust: interval_output(&mut out, "log", left.log())?;
    // rust: interval_output(&mut out, "lerp-values", Ok(left.lerp_values(c, d)))?;
    // rust: interval_output(&mut out, "lerp-ranges", Ok(left.lerp_ranges(right, third)))?;
    // rust: interval_output(&mut out, "map-negate", left.map_monotonic(|v| -v))?;
    // rust: interval_output(&mut out, "map-cube", left.map_monotonic(|v| v * v * v))?;
    // rust: interval_output(
    // rust: &mut out,
    // rust: "map-sqrt",
    // rust: left.map_monotonic(|v| (v as f64).sqrt() as f32),
    // rust: )?;
    // rust: interval_output(&mut out, "map-reciprocal", left.map_monotonic(|v| 1.0 / v))?;
    // rust: interval_output(
    // rust: &mut out,
    // rust: "hull",
    // rust: Interval::encapsulating(&[left, right, third]),
    // rust: )?;
    // rust: interval_output(&mut out, "empty", Interval::encapsulating(&[]))?;
    // rust: writeln!(
    // rust: out,
    // rust: "bounds query {} {} {} {}",
    // rust: u8::from(left.contains(e)),
    // rust: u8::from(left.intersects(right)),
    // rust: u8::from(left == right),
    // rust: u8::from(left == result.unwrap())
    // rust: )?;
}
}
    // rust: "offset" => {
    // rust: let kind = [
    // rust: ShiftNoiseKind::Shift,
    // rust: ShiftNoiseKind::ShiftA,
    // rust: ShiftNoiseKind::ShiftB,
    // rust: ][read::<usize>(&mut args)?];
    // rust: let noise = noises[read::<usize>(&mut args)?].noise.clone();
    // rust: samplers.push(compile_shift_noise(noise, kind));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "blended" | "blendfail" => {
    // rust: let stream = args.next().ok_or("missing stream")?;
    // rust: let seed = read(&mut args)?;
    // rust: let definition = BlendedNoise {
    // rust: xz_scale: double(&mut args)?,
    // rust: y_scale: double(&mut args)?,
    // rust: xz_factor: double(&mut args)?,
    // rust: y_factor: double(&mut args)?,
    // rust: smear_scale_multiplier: double(&mut args)?,
}
    // rust: let result = if stream == "legacy" {
    // rust: blended_probe(&mut LegacyRandom::new(seed), definition, &mut out)?
    // rust: } else {
    // rust: blended_probe(&mut XoroshiroRandom::new(seed), definition, &mut out)?
}
    // rust: if let Some(sampler) = result {
    // rust: samplers.push(sampler);
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
}
    // rust: "blendfbm" => {
    // rust: let stream = args.next().ok_or("missing stream")?;
    // rust: let seed = read(&mut args)?;
    // rust: let octave = read(&mut args)?;
    // rust: let smear = double(&mut args)?;
    // rust: let amplitude = double(&mut args)?;
    // rust: if stream == "legacy" {
    // rust: fbm_probe(
    // rust: &mut LegacyRandom::new(seed),
    // rust: octave,
    // rust: smear,
    // rust: amplitude,
    // rust: &mut out,
    // rust: )?;
    // rust: } else {
    // rust: fbm_probe(
    // rust: &mut XoroshiroRandom::new(seed),
    // rust: octave,
    // rust: smear,
    // rust: amplitude,
    // rust: &mut out,
    // rust: )?;
}
}
    // rust: "distance" => {
    // rust: let metric = [
    // rust: DistanceMetric::Euclidean,
    // rust: DistanceMetric::EuclideanSquared,
    // rust: DistanceMetric::Manhattan,
    // rust: DistanceMetric::Chebyshev,
    // rust: ][read::<usize>(&mut args)?];
    // rust: let point = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: samplers.push(Arc::new(DistanceToPointSampler { point, metric }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "metric" => {
    // rust: let x = float(&mut args)?;
    // rust: let y = float(&mut args)?;
    // rust: let z = float(&mut args)?;
    // rust: for metric in [
    // rust: DistanceMetric::Euclidean,
    // rust: DistanceMetric::EuclideanSquared,
    // rust: DistanceMetric::Manhattan,
    // rust: DistanceMetric::Chebyshev,
    // rust: ] {
    // rust: writeln!(
    // rust: out,
    // rust: "metric {} {}",
    // rust: bits(metric.compute2(x, y)),
    // rust: bits(metric.compute3(x, y, z))
    // rust: )?;
}
}
    // rust: "wcontext" => {
    // rust: let cached = read::<u8>(&mut args)? != 0;
    // rust: let mut fields = WorldFields::default();
    // rust: for field in [
    // rust: WorldField::BlendAlpha,
    // rust: WorldField::BlendOffset,
    // rust: WorldField::Beardifier,
    // rust: ] {
    // rust: let binding = read::<isize>(&mut args)?;
    // rust: if binding >= 0 {
    // rust: fields = fields.with_field(field, samplers[binding as usize].clone());
}
}
    // rust: if read::<u8>(&mut args)? != 0 {
    // rust: fields = fields.with_blender(Arc::new(EmptyBlender));
}
    // rust: context = (if cached {
    // rust: SamplerContext::cached()
    // rust: } else {
    // rust: SamplerContext::default()
    // rust: })
    // rust: .with_world_fields(fields);
    // rust: writeln!(out, "context")?;
}
    // rust: "wfield" => {
    // rust: let field = [
    // rust: WorldField::BlendAlpha,
    // rust: WorldField::BlendOffset,
    // rust: WorldField::Beardifier,
    // rust: ][read::<usize>(&mut args)?];
    // rust: let fallback = read::<isize>(&mut args)?;
    // rust: samplers.push(Arc::new(if fallback < 0 {
    // rust: ContextBoundSampler::new(field)
    // rust: } else {
    // rust: ContextBoundSampler::with_fallback(field, samplers[fallback as usize].clone())
    // rust: }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "blenddensity" => {
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: samplers.push(Arc::new(BlendDensitySampler { input }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "context" => {
    // rust: context = if read::<u8>(&mut args)? == 0 {
    // rust: SamplerContext::default()
    // rust: } else {
    // rust: SamplerContext::cached()
}
    // rust: writeln!(out, "context")?;
}
    // rust: "counted" => {
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let calls = Arc::new(std::array::from_fn(|_| {
    // rust: std::sync::atomic::AtomicUsize::new(0)
    // rust: }));
    // rust: counters.push(calls.clone());
    // rust: samplers.push(Arc::new(CountedSampler { input, calls }));
    // rust: writeln!(out, "counted {} {}", counters.len() - 1, samplers.len() - 1)?;
}
    // rust: "counts" => {
    // rust: let calls = &counters[read::<usize>(&mut args)?];
    // rust: writeln!(
    // rust: out,
    // rust: "counts {} {}",
    // rust: calls[0].load(std::sync::atomic::Ordering::Relaxed),
    // rust: calls[1].load(std::sync::atomic::Ordering::Relaxed)
    // rust: )?;
}
    // rust: "greset" => {
    // rust: graph_compiler = DensityCompiler::new(DensityGraph::new());
    // rust: functions.clear();
    // rust: graph_splines.clear();
    // rust: graph_noises.clear();
    // rust: context = SamplerContext::default();
    // rust: writeln!(out, "graph-reset")?;
}
    // rust: "gseed" => {
    // rust: let seed = read::<i64>(&mut args)?;
    // rust: let legacy = read::<u8>(&mut args)? != 0;
    // rust: graph_compiler = DensityCompiler::new_seeded(DensityGraph::new(), seed, legacy);
    // rust: functions.clear();
    // rust: graph_splines.clear();
    // rust: graph_noises.clear();
    // rust: context = SamplerContext::default();
    // rust: writeln!(out, "graph-seed")?;
}
    // rust: "gready" => writeln!(out, "graph-ready")?,
    // rust: "gend" => {
    // rust: functions.push(graph_compiler.graph_mut().insert(GraphNode::EndIslands)?);
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: "gregister" => {
    // rust: let name = args.next().ok_or("missing noise identifier")?.to_owned();
    // rust: let mut builder = NormalNoise::builder();
    // rust: builder
    // rust: .set_base_octave(read(&mut args)?)
    // rust: .set_base_amplitude(double(&mut args)?);
    // rust: builder.set_octave_count(read(&mut args)?)?;
    // rust: builder.set_normalization(
    // rust: [
    // rust: Normalization::Disabled,
    // rust: Normalization::Enabled,
    // rust: Normalization::Legacy,
    // rust: ][read::<usize>(&mut args)?],
    // rust: );
    // rust: let modifiers = read::<usize>(&mut args)?;
    // rust: for index in 0..modifiers {
    // rust: builder.set_amplitude_modifier(index as i32, double(&mut args)?)?;
}
    // rust: graph_noises.push(
    // rust: graph_compiler
    // rust: .graph_mut()
    // rust: .register_noise(name, builder.build()?)?,
    // rust: );
    // rust: writeln!(out, "graph-noise {}", graph_noises.len() - 1)?;
}
    // rust: "ginstance" => {
    // rust: let id = graph_noises[read::<usize>(&mut args)?];
    // rust: let a = graph_compiler.get_noise_sampler(id)?;
    // rust: let b = graph_compiler.get_noise_sampler(id)?;
    // rust: writeln!(out, "graph-instance {}", u8::from(Arc::ptr_eq(&a, &b)))?;
}
    // rust: "gbind" => {
    // rust: let sampler = samplers[read::<usize>(&mut args)?].clone();
    // rust: let range = Interval::encapsulating_values(float(&mut args)?, float(&mut args)?);
    // rust: let axes = read(&mut args)?;
    // rust: functions.push(graph_compiler.graph_mut().bind(sampler, range, axes)?);
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: "gsconstant" => {
    // rust: graph_splines.push(CubicSpline::Constant(float(&mut args)?));
    // rust: writeln!(out, "graph-spline {}", graph_splines.len() - 1)?;
}
    // rust: "gspoints" => {
    // rust: let coordinate = functions[read::<usize>(&mut args)?];
    // rust: let count = read::<usize>(&mut args)?;
    // rust: let mut points = Vec::with_capacity(count);
    // rust: for _ in 0..count {
    // rust: let location = float(&mut args)?;
    // rust: let derivative = float(&mut args)?;
    // rust: let value = graph_splines[read::<usize>(&mut args)?].clone();
    // rust: points.push(SplinePoint {
    // rust: location,
    // rust: derivative,
    // rust: value,
    // rust: });
}
    // rust: graph_splines.push(CubicSpline::multipoint(coordinate, points)?);
    // rust: writeln!(out, "graph-spline {}", graph_splines.len() - 1)?;
}
    // rust: "gref" => {
    // rust: let input = functions[read::<usize>(&mut args)?];
    // rust: functions.push(graph_compiler.graph_mut().insert(GraphNode::Reference {
    // rust: input,
    // rust: holder: None,
    // rust: })?);
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: "gnamed" => {
    // rust: let name = read::<String>(&mut args)?;
    // rust: let input = functions[read::<usize>(&mut args)?];
    // rust: functions.push(graph_compiler.graph_mut().register_function(name, input)?);
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: "glookup" => {
    // rust: let name = read::<String>(&mut args)?;
    // rust: functions.push(
    // rust: graph_compiler
    // rust: .graph()
    // rust: .function(&name)
    // rust: .ok_or("unknown density name")?,
    // rust: );
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: "gspline" => {
    // rust: let spline = graph_splines[read::<usize>(&mut args)?].clone();
    // rust: functions.push(
    // rust: graph_compiler
    // rust: .graph_mut()
    // rust: .insert(GraphNode::Spline(spline))?,
    // rust: );
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: command @ ("gconst" | "ggradient" | "gunary" | "gbinary" | "gclamp" | "gchoice"
    // rust: | "glerp" | "gslice" | "gcache" | "ginterp" | "gsurface" | "ginterval"
    // rust: | "gdistance" | "gnoise" | "goffset" | "gblended" | "ground" | "gpow"
    // rust: | "gwfield" | "gblenddensity") => {
    // rust: let reference = |args: &mut std::str::SplitWhitespace<'_>| -> Result<FunctionId,Box<dyn std::error::Error>> { Ok(functions[read::<usize>(args)?]) };
    // rust: let node = match command {
    // rust: "gconst" => GraphNode::Constant(float(&mut args)?),
    // rust: "gwfield" => GraphNode::WorldField(
    // rust: [
    // rust: WorldField::BlendAlpha,
    // rust: WorldField::BlendOffset,
    // rust: WorldField::Beardifier,
    // rust: ][read::<usize>(&mut args)?],
    // rust: ),
    // rust: "gblenddensity" => GraphNode::BlendDensity(reference(&mut args)?),
    // rust: "gpow" => GraphNode::Power {
    // rust: base: reference(&mut args)?,
    // rust: exponent: reference(&mut args)?,
    // rust: },
    // rust: "ground" => GraphNode::Round {
    // rust: mode: [
    // rust: RoundMode::Floor,
    // rust: RoundMode::Round,
    // rust: RoundMode::Ceil,
    // rust: RoundMode::Truncate,
    // rust: ][read::<usize>(&mut args)?],
    // rust: input: reference(&mut args)?,
    // rust: multiple: reference(&mut args)?,
    // rust: },
    // rust: "gnoise" => GraphNode::Noise {
    // rust: noise: graph_noises[read::<usize>(&mut args)?],
    // rust: xz_scale: double(&mut args)?,
    // rust: y_scale: double(&mut args)?,
    // rust: shift_x: reference(&mut args)?,
    // rust: shift_y: reference(&mut args)?,
    // rust: shift_z: reference(&mut args)?,
    // rust: },
    // rust: "goffset" => GraphNode::OffsetNoise {
    // rust: noise: graph_noises[read::<usize>(&mut args)?],
    // rust: kind: [
    // rust: ShiftNoiseKind::Shift,
    // rust: ShiftNoiseKind::ShiftA,
    // rust: ShiftNoiseKind::ShiftB,
    // rust: ][read::<usize>(&mut args)?],
    // rust: },
    // rust: "gblended" => GraphNode::BlendedNoise(BlendedNoise {
    // rust: xz_scale: double(&mut args)?,
    // rust: y_scale: double(&mut args)?,
    // rust: xz_factor: double(&mut args)?,
    // rust: y_factor: double(&mut args)?,
    // rust: smear_scale_multiplier: double(&mut args)?,
    // rust: }),
    // rust: "gdistance" => GraphNode::DistanceToPoint {
    // rust: point: [read(&mut args)?, read(&mut args)?, read(&mut args)?],
    // rust: metric: [
    // rust: DistanceMetric::Euclidean,
    // rust: DistanceMetric::EuclideanSquared,
    // rust: DistanceMetric::Manhattan,
    // rust: DistanceMetric::Chebyshev,
    // rust: ][read::<usize>(&mut args)?],
    // rust: },
    // rust: "ginterval" => {
    // rust: let input = reference(&mut args)?;
    // rust: let count: usize = read(&mut args)?;
    // rust: let thresholds = (0..count)
    // rust: .map(|_| float(&mut args))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let branches =
    // rust: (0..=count)
    // rust: .map(|_| reference(&mut args))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: GraphNode::IntervalSelect {
    // rust: input,
    // rust: thresholds: thresholds.into(),
    // rust: branches,
}
}
    // rust: "ggradient" => {
    // rust: let axis = [Axis::X, Axis::Y, Axis::Z][read::<usize>(&mut args)?];
    // rust: let tiling = [
    // rust: TilingMode::ClampToEdge,
    // rust: TilingMode::Repeat,
    // rust: TilingMode::MirroredRepeat,
    // rust: ][read::<usize>(&mut args)?];
    // rust: GraphNode::Gradient {
    // rust: axis,
    // rust: tiling,
    // rust: from: read(&mut args)?,
    // rust: to: read(&mut args)?,
    // rust: low: float(&mut args)?,
    // rust: high: float(&mut args)?,
}
}
    // rust: "gunary" => {
    // rust: let kind = [
    // rust: GraphUnary::Abs,
    // rust: GraphUnary::Square,
    // rust: GraphUnary::Cube,
    // rust: GraphUnary::HalfNegative,
    // rust: GraphUnary::QuarterNegative,
    // rust: GraphUnary::Reciprocal,
    // rust: GraphUnary::Negate,
    // rust: GraphUnary::Squeeze,
    // rust: GraphUnary::Sign,
    // rust: GraphUnary::Log,
    // rust: GraphUnary::Sqrt,
    // rust: ][read::<usize>(&mut args)?];
    // rust: GraphNode::Unary {
    // rust: kind,
    // rust: input: reference(&mut args)?,
}
}
    // rust: "gbinary" => {
    // rust: let kind = [
    // rust: GraphBinary::Add,
    // rust: GraphBinary::Subtract,
    // rust: GraphBinary::Multiply,
    // rust: GraphBinary::Divide,
    // rust: GraphBinary::Minimum,
    // rust: GraphBinary::Maximum,
    // rust: ][read::<usize>(&mut args)?];
    // rust: GraphNode::Binary {
    // rust: kind,
    // rust: left: reference(&mut args)?,
    // rust: right: reference(&mut args)?,
}
}
    // rust: "gclamp" => GraphNode::Clamp {
    // rust: input: reference(&mut args)?,
    // rust: min: float(&mut args)?,
    // rust: max: float(&mut args)?,
    // rust: },
    // rust: "gchoice" => GraphNode::Choice {
    // rust: input: reference(&mut args)?,
    // rust: min: float(&mut args)?,
    // rust: max: float(&mut args)?,
    // rust: inside: reference(&mut args)?,
    // rust: outside: reference(&mut args)?,
    // rust: },
    // rust: "glerp" => GraphNode::Lerp {
    // rust: alpha: reference(&mut args)?,
    // rust: first: reference(&mut args)?,
    // rust: second: reference(&mut args)?,
    // rust: },
    // rust: "gslice" => GraphNode::Slice {
    // rust: axis: [Axis::X, Axis::Y, Axis::Z][read::<usize>(&mut args)?],
    // rust: coordinate: read(&mut args)?,
    // rust: input: reference(&mut args)?,
    // rust: },
    // rust: "gcache" => GraphNode::Cache(reference(&mut args)?),
    // rust: "ginterp" => GraphNode::Interpolated {
    // rust: input: reference(&mut args)?,
    // rust: xz: read(&mut args)?,
    // rust: y: read(&mut args)?,
    // rust: },
    // rust: "gsurface" => GraphNode::Surface {
    // rust: density: reference(&mut args)?,
    // rust: upper: reference(&mut args)?,
    // rust: lower: read(&mut args)?,
    // rust: height: read(&mut args)?,
    // rust: },
    // rust: _ => unreachable!(),
}
    // rust: functions.push(graph_compiler.graph_mut().insert(node)?);
    // rust: writeln!(out, "graph-create {}", functions.len() - 1)?;
}
    // rust: "ginfo" => {
    // rust: let id = functions[read::<usize>(&mut args)?];
    // rust: let range = graph_compiler
    // rust: .graph()
    // rust: .range(id)
    // rust: .map_err(|_| IntervalError::NanBound);
    // rust: interval_output(&mut out, "graph", range)?;
    // rust: writeln!(
    // rust: out,
    // rust: "graph-axes {}",
    // rust: graph_compiler.graph().domain_axes(id)?
    // rust: )?;
}
    // rust: "gsame" => {
    // rust: let a = functions[read::<usize>(&mut args)?];
    // rust: let b = functions[read::<usize>(&mut args)?];
    // rust: writeln!(
    // rust: out,
    // rust: "graph-same {}",
    // rust: u8::from(graph_compiler.graph().java_equals(a, b)?)
    // rust: )?;
}
    // rust: command @ ("gcompile" | "gtry") => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let id = functions[read::<usize>(&mut args)?];
    // rust: let result = if mode == 0 {
    // rust: graph_compiler.compile_raw(id)
    // rust: } else {
    // rust: graph_compiler.get_sampler(id)
}
    // rust: if command == "gtry" {
    // rust: writeln!(
    // rust: out,
    // rust: "graph-try {} {}",
    // rust: if result.is_ok() { "ok" } else { "error" },
    // rust: graph_compiler.cache_count()
    // rust: )?;
    // rust: } else {
    // rust: let sampler = result?;
    // rust: let same = if mode == 0 {
    // rust: -1
    // rust: } else {
    // rust: i32::from(Arc::ptr_eq(&sampler, &graph_compiler.get_sampler(id)?))
}
    // rust: samplers.push(sampler);
    // rust: writeln!(
    // rust: out,
    // rust: "graph-compile {} {} {}",
    // rust: samplers.len() - 1,
    // rust: graph_compiler.cache_count(),
    // rust: same
    // rust: )?;
}
}
    // rust: "spconstant" => {
    // rust: splines.push(CubicSpline::Constant(float(&mut args)?));
    // rust: writeln!(out, "spline {}", splines.len() - 1)?;
}
    // rust: "sppoints" => {
    // rust: let coordinate = read(&mut args)?;
    // rust: let count = read::<usize>(&mut args)?;
    // rust: let mut points = Vec::new();
    // rust: for _ in 0..count {
    // rust: let location = float(&mut args)?;
    // rust: let derivative = float(&mut args)?;
    // rust: let value = splines[read::<usize>(&mut args)?].clone();
    // rust: points.push(SplinePoint {
    // rust: location,
    // rust: derivative,
    // rust: value,
    // rust: });
}
    // rust: splines.push(CubicSpline::multipoint(coordinate, points)?);
    // rust: writeln!(out, "spline {}", splines.len() - 1)?;
}
    // rust: "spfail" => {
    // rust: let spline = &splines[read::<usize>(&mut args)?];
    // rust: writeln!(
    // rust: out,
    // rust: "spline-compile {}",
    // rust: if SplineSampler::new(spline, &samplers).is_err() {
    // rust: "error"
    // rust: } else {
    // rust: "ok"
}
    // rust: )?;
}
    // rust: "sprange" => {
    // rust: let spline = &splines[read::<usize>(&mut args)?];
    // rust: let mut ranges = [Interval::NAI; 3];
    // rust: for range in &mut ranges {
    // rust: *range = Interval::encapsulating_values(float(&mut args)?, float(&mut args)?);
}
    // rust: interval_output(&mut out, "spline", spline.range(&mut |id| ranges[id % 3]))?;
}
    // rust: "spsampler" => {
    // rust: let spline = &splines[read::<usize>(&mut args)?];
    // rust: samplers.push(Arc::new(SplineSampler::new(spline, &samplers)?));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "surface" => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let density = samplers[read::<usize>(&mut args)?].clone();
    // rust: let upper = samplers[read::<usize>(&mut args)?].clone();
    // rust: let lower = read(&mut args)?;
    // rust: let height = read(&mut args)?;
    // rust: let sampler: Arc<dyn DensitySampler> = if mode == 0 {
    // rust: Arc::new(FindTopSurfaceSampler::new(density, upper, lower, height)?)
    // rust: } else {
    // rust: Arc::new(compile_surface_search(density, upper, lower, height)?)
}
    // rust: samplers.push(sampler);
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "interpolate" => {
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let xz = read(&mut args)?;
    // rust: let y = read(&mut args)?;
    // rust: samplers.push(Arc::new(InterpolatedSampler::new(input, xz, y)?));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "slice" => {
    // rust: let mode = read::<u8>(&mut args)?;
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: let a = read(&mut args)?;
    // rust: let b = read(&mut args)?;
    // rust: let axes = match mode {
    // rust: 0 => SliceAxes::X(a),
    // rust: 1 => SliceAxes::Y(a),
    // rust: 2 => SliceAxes::Z(a),
    // rust: 3 => SliceAxes::Xz { x: a, z: b },
    // rust: _ => return Err("invalid slice mode".into()),
}
    // rust: samplers.push(Arc::new(SliceSampler { input, axes }));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "cache" => {
    // rust: let id = read::<usize>(&mut args)?;
    // rust: let input = samplers[read::<usize>(&mut args)?].clone();
    // rust: samplers.push(Arc::new(CachingDensitySampler::new(id, input)?));
    // rust: writeln!(out, "create {}", samplers.len() - 1)?;
}
    // rust: "lookup" => {
    // rust: let sizes = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let minimum = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let steps = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let position = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let volume = DensityVolume::new(sizes, minimum, steps)?;
    // rust: writeln!(
    // rust: out,
    // rust: "lookup {}",
    // rust: volume.index_of_block(position).map_or(-1, |v| v as i32)
    // rust: )?;
}
    // rust: "query" => {
    // rust: let sampler = &samplers[read::<usize>(&mut args)?];
    // rust: let position = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: match sampler.sample_value(&mut context, position) {
    // rust: Ok(value) => writeln!(out, "query {}", bits(value))?,
    // rust: Err(_) => writeln!(out, "query error")?,
}
}
    // rust: "volume" => {
    // rust: let sampler = &samplers[read::<usize>(&mut args)?];
    // rust: let sizes = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let minimum = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let steps = [read(&mut args)?, read(&mut args)?, read(&mut args)?];
    // rust: let tail = read::<usize>(&mut args)?;
    // rust: let seed = read(&mut args)?;
    // rust: let repeats = read::<usize>(&mut args)?;
    // rust: let volume = DensityVolume::new(sizes, minimum, steps)?;
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let mut buffer: Vec<_> = (0..volume.size() + tail)
    // rust: .map(|_| f32::from_bits(random.next_int() as u32))
    // rust: .collect();
    // rust: for pass in 0..repeats {
    // rust: let result = sampler.sample_volume(&mut context, &mut buffer, volume);
    // rust: writeln!(
    // rust: out,
    // rust: "volume {pass} {}",
    // rust: if result.is_ok() { "ok" } else { "error" }
    // rust: )?;
    // rust: for (i, value) in buffer.iter().enumerate() {
    // rust: writeln!(out, "cell {i} {}", bits(*value))?;
}
}
}
    // rust: _ => return Err("unknown command".into()),
}
    // rust: if args.next().is_some() {
    // rust: return Err("extra argument".into());
}
}
    // rust: out.flush()?;
    // rust: Ok(())
}
