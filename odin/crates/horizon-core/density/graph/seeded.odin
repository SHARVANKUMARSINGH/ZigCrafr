//! Transpiled from Horizon Rust crate
package horizon_core_seeded

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::{
    // rust: noise::NormalNoise,
    // rust: random::{
    // rust: LegacyPositionalRandom, LegacyRandom, PositionalRandom, RandomSource,
    // rust: XoroshiroPositionalRandom, XoroshiroRandom,
    // rust: },
}
// use std::sync::Mutex;

Factory :: enum {
    Legacy(LegacyPositionalRandom),
    Xoroshiro(XoroshiroPositionalRandom),
}

// The seed-dependent portion of vanilla's RandomState compile context.
    // rust: pub(super) struct SeededContext {
    // rust: seed: i64,
    // rust: factory: Factory,
    // rust: instances: Mutex<HashMap<NoiseId, Arc<dyn Noise>>>,
}
    // rust: impl SeededContext {
    // rust: pub(super) fn end_islands(&self) -> Arc<dyn DensitySampler> {
    // rust: Arc::new(EndIslandSampler::new(self.seed))
}
    // rust: pub(super) fn new(seed: i64, legacy: bool) -> Self {
    // rust: let factory = if legacy {
    // rust: Factory::Legacy(LegacyRandom::new(seed).fork_positional())
    // rust: } else {
    // rust: Factory::Xoroshiro(XoroshiroRandom::new(seed).fork_positional())
}
    // rust: Self {
    // rust: seed,
    // rust: factory,
    // rust: instances: Mutex::new(HashMap::new()),
}
}
    // rust: pub(super) fn noise(
    // rust: &self,
    // rust: graph: &DensityGraph,
    // rust: id: NoiseId,
    // rust: ) -> Result<Arc<dyn Noise>, CompileError> {
    // rust: let entry = graph.noise_entry(id)?;
        // Nether biome compatibility samplers are recreated on every lookup;
        // vanilla bypasses its normal named-noise instance map for these keys.
    // rust: let legacy_offset = match entry.name.as_str() {
    // rust: "minecraft:nether/temperature" => Some(0),
    // rust: "minecraft:nether/vegetation" => Some(1),
    // rust: _ => None,
}
    // rust: if let Some(offset) = legacy_offset {
    // rust: return Ok(Arc::new(entry.definition.create_for_legacy_nether_biome(
    // rust: &mut LegacyRandom::new(self.seed.wrapping_add(offset)),
    // rust: )?));
}
    // rust: let mut instances = self
    // rust: .instances
    // rust: .lock()
    // rust: .map_err(|_| CompileError::PoisonedNoiseCache)?;
    // rust: if let Some(noise) = instances.get(&id) {
    // rust: return Ok(noise.clone());
}
    // rust: let noise: Arc<dyn Noise> = match &self.factory {
    // rust: Factory::Legacy(factory) => Arc::new(
    // rust: entry
    // rust: .definition
    // rust: .create(&mut factory.from_hash_of(&entry.name))?,
    // rust: ),
    // rust: Factory::Xoroshiro(factory) => Arc::new(
    // rust: entry
    // rust: .definition
    // rust: .create(&mut factory.from_hash_of(&entry.name))?,
    // rust: ),
}
    // rust: instances.insert(id, noise.clone());
    // rust: Ok(noise)
}
    // rust: pub(super) fn blended(
    // rust: &self,
    // rust: definition: BlendedNoise,
    // rust: ) -> Result<Arc<dyn DensitySampler>, CompileError> {
    // rust: Ok(match &self.factory {
    // rust: Factory::Legacy(_) => Arc::new(definition.compile(&mut LegacyRandom::new(self.seed))?),
    // rust: Factory::Xoroshiro(factory) => {
    // rust: Arc::new(definition.compile(&mut factory.from_hash_of("minecraft:terrain"))?)
}
    // rust: })
}
}

    // rust: pub(super) struct NoiseEntry {
    // rust: pub(super) name: String,
    // rust: pub(super) definition: NormalNoise,
}
