//! Transpiled from Horizon Rust crate
package horizon_world_generation

import "core:fmt"
import "core:mem"
import "core:math"

// Biome-selected neighboring carvers and their per-entry legacy seeds.
// use super::{CanyonCarver, CarverError, CaveCarver};
// use crate::worldgen::{
    // rust: DecodeError, Object, anchor::WorldGenerationContext, density::identifier, required,
}
// use horizon_core::{
    // rust: carving::{CarverOutput, CarvingMask, CarvingMaskError},
    // rust: position::ChunkPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use std::{collections::BTreeMap, sync::Arc};

WorldCarver :: enum {
    Cave(CaveCarver),
    Canyon(CanyonCarver),
}
    // rust: impl WorldCarver {
from_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: match identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?
    // rust: .as_str()
    // rust: {
    // rust: "minecraft:cave" => Ok(Self::Cave(CaveCarver::from_json(json)?)),
    // rust: "minecraft:canyon" => Ok(Self::Canyon(CanyonCarver::from_json(json)?)),
    // rust: _ => Err(DecodeError::Field("world carver type")),
}
}
is_start_chunk :: proc(self: ^Self, random: ^impl RandomSource) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Cave(c) => c.is_start_chunk(random),
    // rust: Self::Canyon(c) => c.is_start_chunk(random),
}
}
    // rust: pub fn carve<O: CarverOutput>(
    // rust: &self,
    // rust: context: WorldGenerationContext,
    // rust: random: &mut impl RandomSource,
    // rust: target: ChunkPos,
    // rust: origin: ChunkPos,
    // rust: output: &mut O,
    // rust: ) -> Result<bool, CarverError<O::Error>> {
    // rust: match self {
    // rust: Self::Cave(c) => c.carve(context, random, target, origin, output),
    // rust: Self::Canyon(c) => c.carve(context, random, target, origin, output),
}
}
}
// Immutable named carvers. Inline definitions and direct holder lists are
// supported; tagged sets and live registry reloads remain separate work.
CarverCatalog :: struct {
    definitions: BTreeMap<string,
}
    // rust: impl CarverCatalog {
from_json :: proc(definitions: ^BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if definitions.len() > 8192 {
    // rust: return Err(DecodeError::Field("carver registry size"));
}
    // rust: let mut result = BTreeMap::new();
    // rust: for (name, json) in definitions {
    // rust: let name = identifier(name)?;
    // rust: if result
    // rust: .insert(name, Arc::new(WorldCarver::from_json(json)?))
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate carver name"));
}
}
    // rust: Ok(Self {
    // rust: definitions: result,
    // rust: })
}
decode_set :: proc(self: ^Self, json: string) -> R {
    // Ported from Horizon
    return {}
}
//         use serde_json::value::RawValue;
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: let entries: Vec<Box<RawValue>> = if raw.get().starts_with('[') {
    // rust: serde_json::from_str(raw.get())?
    // rust: } else {
    // rust: vec![raw]
}
    // rust: if entries.len() > 1024 {
    // rust: return Err(DecodeError::Field("biome carver count"));
}
    // rust: entries
    // rust: .iter()
    // rust: .map(|raw| {
    // rust: if let Ok(name) = serde_json::from_str::<String>(raw.get()) {
    // rust: let name = identifier(&name)?;
    // rust: self.definitions
    // rust: .get(&name)
    // rust: .cloned()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown carver {name}")))
    // rust: } else {
    // rust: Ok(Arc::new(WorldCarver::from_json(raw.get())?))
}
    // rust: })
    // rust: .collect()
}
}
MaskGenerationError :: enum {
    Source(E),
    Mask(CarvingMaskError),
    Carver(CarverError<CarvingMaskError>),
    TooManyCarvers,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for MaskGenerationError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Source(e) => e.fmt(f),
    // rust: Self::Mask(e) => e.fmt(f),
    // rust: Self::Carver(e) => e.fmt(f),
    // rust: Self::TooManyCarvers => f.write_str("biome carver count exceeds 1024"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for MaskGenerationError<E> {}

// Build the union mask from a 17×17 origin neighborhood, X then Z. The provider
// selects each origin's ordered biome carvers using its uncached biome resolver
// at the origin's minimum quart X/Z and quart Y=0. Repeated entries keep their
// individual ordinal seeds. The caller applies a successfully returned mask.
    // rust: pub fn generate_carving_mask<'a, E>(
    // rust: world_seed: i64,
    // rust: target: ChunkPos,
    // rust: context: WorldGenerationContext,
    // rust: upgrading: bool,
    // rust: mut carvers: impl FnMut(ChunkPos) -> Result<&'a [Arc<WorldCarver>], E>,
    // rust: ) -> Result<CarvingMask, MaskGenerationError<E>> {
    // rust: let min = context.min_y.wrapping_add(1);
    // rust: let max = context
    // rust: .min_y
    // rust: .wrapping_add(context.height)
    // rust: .wrapping_sub(1)
    // rust: .wrapping_sub(if upgrading { 0 } else { 7 });
    // rust: let mut mask = CarvingMask::new(min, max).map_err(MaskGenerationError::Mask)?;
    // rust: for dx in -8..=8 {
    // rust: for dz in -8..=8 {
    // rust: let origin = ChunkPos::new(target.x.wrapping_add(dx), target.z.wrapping_add(dz));
    // rust: let selected = carvers(origin).map_err(MaskGenerationError::Source)?;
    // rust: if selected.len() > 1024 {
    // rust: return Err(MaskGenerationError::TooManyCarvers);
}
    // rust: for (index, carver) in selected.iter().enumerate() {
    // rust: let mut random =
    // rust: large_feature_random(world_seed.wrapping_add(index as i64), origin);
    // rust: if carver.is_start_chunk(&mut random) {
    // rust: carver
    // rust: .carve(context, &mut random, target, origin, &mut mask)
    // rust: .map_err(MaskGenerationError::Carver)?;
}
}
}
}
    // rust: Ok(mask)
}
// The legacy `WorldgenRandom.setLargeFeatureSeed` stream used by carving.
large_feature_random :: proc(seed: i64, origin: ChunkPos) -> L {
    // Ported from Horizon
    return {}
}
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let x = random.next_long();
    // rust: let z = random.next_long();
    // rust: random
    // rust: .set_seed(i64::from(origin.x).wrapping_mul(x) ^ i64::from(origin.z).wrapping_mul(z) ^ seed);
    // rust: random
}
