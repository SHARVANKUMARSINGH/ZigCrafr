//! Transpiled from Horizon Rust crate
package horizon_world_carver

import "core:fmt"
import "core:mem"
import "core:math"

// Seeded carver paths using pinned scalar providers and shared mask geometry.
    // rust: mod canyon;
    // rust: mod generation;
// use super::{
    // rust: DecodeError, Object,
    // rust: anchor::WorldGenerationContext,
    // rust: density::identifier,
    // rust: height_provider::HeightProvider,
    // rust: number_text, optional, required,
    // rust: value_provider::{FloatProvider, IntProvider},
}
    // rust: pub use canyon::{CanyonCarver, CanyonShape};
    // rust: pub use generation::{
    // rust: CarverCatalog, MaskGenerationError, WorldCarver, generate_carving_mask, large_feature_random,
}
// use horizon_core::{
    // rust: carving::{CarveError, CarverOutput, can_reach, carve_ellipsoid_with_budget},
    // rust: geometry::trig::{cos, sin},
    // rust: position::ChunkPos,
    // rust: random::{InvalidBound, LegacyRandom, RandomSource},
}

CaveCarver :: struct {
    probability: f32,
    y: HeightProvider,
    count: IntProvider,
    thickness: FloatProvider,
    weird_thickness_bias: bool,
    room_vertical_radius_multiplier: FloatProvider,
    horizontal_radius_multiplier: FloatProvider,
    vertical_radius_multiplier: FloatProvider,
    start_vertical_radius_multiplier: FloatProvider,
    floor_level: FloatProvider,
}
CarverError :: enum {
    Random(InvalidBound),
    Geometry(CarveError<E>),
    IterationLimit,
    InvalidBounds,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for CarverError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::Geometry(e) => e.fmt(f),
    // rust: Self::IterationLimit => f.write_str("carver work limit exceeded"),
    // rust: Self::InvalidBounds => f.write_str("carver output or generation bounds are invalid"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for CarverError<E> {}
    // rust: impl<E> From<InvalidBound> for CarverError<E> {
from :: proc(e: InvalidBound) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Random(e)
}
}
    // rust: impl<E> From<CarveError<E>> for CarverError<E> {
from :: proc(e: CarveError<E>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Geometry(e)
}
}
    // rust: impl CaveCarver {
from_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: if kind != "minecraft:cave" {
    // rust: return Err(DecodeError::Field("cave carver type"));
}
    // rust: let probability: f32 = number_text(required(&object, "probability")?)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("carver probability"))?;
    // rust: if !(0.0..=1.0).contains(&probability) || probability.is_sign_negative() {
    // rust: return Err(DecodeError::Field("carver probability"));
}
    // rust: let count = IntProvider::from_json(required(&object, "count")?.get())?;
    // rust: if count.bounds()[0] < 0 {
    // rust: return Err(DecodeError::Field("carver count"));
}
    // rust: let provider = |name| FloatProvider::from_json(required(&object, name)?.get());
    // rust: let thickness = provider("thickness")?;
    // rust: if thickness.bounds()[0] < 0. {
    // rust: return Err(DecodeError::Field("carver thickness"));
}
    // rust: let floor_level = provider("floor_level")?;
    // rust: if floor_level.bounds()[0] < -1. || floor_level.bounds()[1] > 1. {
    // rust: return Err(DecodeError::Field("carver floor"));
}
    // rust: Ok(Self {
    // rust: probability,
    // rust: y: HeightProvider::from_json(required(&object, "y")?.get())?,
    // rust: count,
    // rust: thickness,
    // rust: weird_thickness_bias: optional(&object, "weird_thickness_bias")
    // rust: .map(|v| serde_json::from_str(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: room_vertical_radius_multiplier: provider("room_vertical_radius_multiplier")?,
    // rust: horizontal_radius_multiplier: provider("horizontal_radius_multiplier")?,
    // rust: vertical_radius_multiplier: provider("vertical_radius_multiplier")?,
    // rust: start_vertical_radius_multiplier: optional(&object, "start_vertical_radius_multiplier")
    // rust: .map(|v| FloatProvider::from_json(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(FloatProvider::Constant(1.)),
    // rust: floor_level,
    // rust: })
}
is_start_chunk :: proc(self: ^Self, random: ^impl RandomSource) -> b {
    // Ported from Horizon
    return {}
}
    // rust: random.next_float() <= self.probability
}
    // Carve one origin chunk's paths into the target output. The caller performs
    // start-chunk selection separately. Local tunnel RNGs always use the legacy
    // algorithm, regardless of the caller's RNG. At most 4096 starts and 2^24
    // candidate cells are allowed; errors preserve random draws and prior output.
    // rust: pub fn carve<O: CarverOutput>(
    // rust: &self,
    // rust: context: WorldGenerationContext,
    // rust: random: &mut impl RandomSource,
    // rust: target: ChunkPos,
    // rust: origin: ChunkPos,
    // rust: output: &mut O,
    // rust: ) -> Result<bool, CarverError<O::Error>> {
    // rust: let count = self.count.sample(random)?;
    // rust: if count > 4096 {
    // rust: return Err(CarverError::IterationLimit);
}
    // rust: let mut budget = 1 << 24;
    // rust: for _ in 0..count {
    // rust: let x = f64::from(
    // rust: origin
    // rust: .x
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(random.next_int_bound(16)?),
    // rust: );
    // rust: let y = f64::from(self.y.sample(random, context)?);
    // rust: let z = f64::from(
    // rust: origin
    // rust: .z
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(random.next_int_bound(16)?),
    // rust: );
    // rust: let horizontal = f64::from(self.horizontal_radius_multiplier.sample(random));
    // rust: let vertical = f64::from(self.vertical_radius_multiplier.sample(random));
    // rust: let start_vertical = f64::from(self.start_vertical_radius_multiplier.sample(random));
    // rust: let floor = f64::from(self.floor_level.sample(random));
    // rust: let mut run = CaveRun {
    // rust: target,
    // rust: output,
    // rust: budget: &mut budget,
    // rust: horizontal,
    // rust: vertical,
    // rust: floor,
}
    // rust: let mut tunnels = 1;
    // rust: if random.next_int_bound(4)? == 0 {
    // rust: let multiplier = f64::from(self.room_vertical_radius_multiplier.sample(random));
    // rust: let thickness = 1. + random.next_float() * 6.;
    // rust: let radius =
    // rust: 1.5 + f64::from(sin(f64::from(std::f32::consts::FRAC_PI_2)) * thickness);
    // rust: run.ellipsoid([x + 1., y, z], radius, radius * multiplier)?;
    // rust: tunnels += random.next_int_bound(4)?;
}
    // rust: for _ in 0..tunnels {
    // rust: let yaw = random.next_float() * std::f32::consts::TAU;
    // rust: let pitch = (random.next_float() - 0.5) / 4.;
    // rust: let mut thickness = self.thickness.sample(random);
    // rust: if self.weird_thickness_bias && random.next_int_bound(10)? == 0 {
    // rust: thickness *= random.next_float() * random.next_float() * 3. + 1.;
}
    // rust: let end = 112 - random.next_int_bound(28)?;
    // rust: run.tunnel(Tunnel {
    // rust: seed: random.next_long(),
    // rust: position: [x, y, z],
    // rust: thickness,
    // rust: yaw,
    // rust: pitch,
    // rust: start: 0,
    // rust: end,
    // rust: vertical_scale: start_vertical,
    // rust: })?;
}
}
    // rust: Ok(true)
}
}
CaveRun :: struct {
    target: ChunkPos,
    output: ^'a mut O,
    budget: ^'a mut uint,
    horizontal: f64,
    vertical: f64,
    floor: f64,
}
Tunnel :: struct {
    seed: i64,
    position: [f64,
    thickness: f32,
    yaw: f32,
    pitch: f32,
    start: i32,
    end: i32,
    vertical_scale: f64,
}
    // rust: impl<O: CarverOutput> CaveRun<'_, O> {
    // rust: fn ellipsoid(
    // rust: &mut self,
    // rust: position: [f64; 3],
    // rust: horizontal: f64,
    // rust: vertical: f64,
    // rust: ) -> Result<(), CarverError<O::Error>> {
    // rust: let floor = self.floor;
    // rust: Ok(carve_ellipsoid_with_budget(
    // rust: self.target,
    // rust: position,
    // rust: horizontal,
    // rust: vertical,
    // rust: self.output,
    // rust: |[x, y, z], _| y <= floor || x * x + y * y + z * z >= 1.,
    // rust: self.budget,
    // rust: )?)
}
tunnel :: proc(self: ^Self, mut path: Tunnel) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut random = LegacyRandom::new(path.seed);
    // rust: let split = random.next_int_bound(path.end / 2)? + path.end / 4;
    // rust: let gentle = random.next_int_bound(6)? == 0;
    // rust: let (mut yaw_change, mut pitch_change) = (0f32, 0f32);
    // rust: for step in path.start..path.end {
    // rust: let radius = 1.5
    // rust: + f64::from(
    // rust: sin(f64::from(
    // rust: std::f32::consts::PI * step as f32 / path.end as f32,
    // rust: )) * path.thickness,
    // rust: );
    // rust: let vertical = radius * path.vertical_scale;
    // rust: let cos_pitch = cos(f64::from(path.pitch));
    // rust: path.position[0] += f64::from(cos(f64::from(path.yaw)) * cos_pitch);
    // rust: path.position[1] += f64::from(sin(f64::from(path.pitch)));
    // rust: path.position[2] += f64::from(sin(f64::from(path.yaw)) * cos_pitch);
    // rust: path.pitch *= if gentle { 0.92 } else { 0.7 };
    // rust: path.pitch += pitch_change * 0.1;
    // rust: path.yaw += yaw_change * 0.1;
    // rust: pitch_change *= 0.9;
    // rust: yaw_change *= 0.75;
    // rust: pitch_change += (random.next_float() - random.next_float()) * random.next_float() * 2.;
    // rust: yaw_change += (random.next_float() - random.next_float()) * random.next_float() * 4.;
    // rust: if step == split && path.thickness > 1. {
    // rust: let seed = random.next_long();
    // rust: let thickness = random.next_float() * 0.5 + 0.5;
    // rust: self.tunnel(Tunnel {
    // rust: seed,
    // rust: thickness,
    // rust: yaw: path.yaw - std::f32::consts::FRAC_PI_2,
    // rust: pitch: path.pitch / 3.,
    // rust: start: step,
    // rust: vertical_scale: 1.,
    // rust: ..path
    // rust: })?;
    // rust: let seed = random.next_long();
    // rust: let thickness = random.next_float() * 0.5 + 0.5;
    // rust: self.tunnel(Tunnel {
    // rust: seed,
    // rust: thickness,
    // rust: yaw: path.yaw + std::f32::consts::FRAC_PI_2,
    // rust: pitch: path.pitch / 3.,
    // rust: start: step,
    // rust: vertical_scale: 1.,
    // rust: ..path
    // rust: })?;
    // rust: return Ok(());
}
    // rust: if random.next_int_bound(4)? == 0 {
    // rust: continue;
}
    // rust: if !can_reach(
    // rust: self.target,
    // rust: path.position[0],
    // rust: path.position[2],
    // rust: step,
    // rust: path.end,
    // rust: path.thickness,
    // rust: ) {
    // rust: return Ok(());
}
    // rust: self.ellipsoid(
    // rust: path.position,
    // rust: radius * self.horizontal,
    // rust: vertical * self.vertical,
    // rust: )?;
}
    // rust: Ok(())
}
}
