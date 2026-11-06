//! Transpiled from Horizon Rust crate
//! Module: horizon-world_decoration
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Biome-selected feature scheduling. Structure decoration is a separate stage.
// use super::{
    // rust: feature_sort::{FeatureIdentity, FeatureSortError, StepFeatureData, build_features_per_step},
    // rust: placement::FeaturePlacer,
}
// use horizon_core::{
    // rust: position::ChunkPos,
    // rust: random::{WorldgenRandom, XoroshiroRandom},
}
// use std::collections::{BTreeMap, BTreeSet};

    // rust: pub use super::biome::BiomeId as DecorationBiome;

/// Transport for resident section palettes and generation progress.
    // rust: pub trait DecorationWorld {
    // rust: type Error;
pub fn min_section_y(self: *Self) R;
    /// Return values present in every section's biome palette, including values
    /// outside the generator's possible-biome set. Duplicates are allowed.
pub fn chunk_biomes(self: *Self, chunk: ChunkPos) R;
    // rust: fn set_currently_generating(
    // rust: &mut self,
    // rust: feature: Option<FeatureIdentity>,
    // rust: ) -> Result<(), Self::Error>;
}

pub const DecorationError = enum {
    World(E),
    Feature { feature: FeatureIdentity, error: E },
    WorkLimit,
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for DecorationError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Feature { feature, error } => write!(f, "feature {}: {error}", feature.0),
    // rust: Self::WorkLimit => f.write_str("decoration work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for DecorationError<E> {}

pub const FeatureDecorationPlan = struct {
    biomes: BTreeMap<DecorationBiome,
    steps: std.ArrayList(StepFeatureData),
};
    // rust: impl FeatureDecorationPlan {
    /// The list must preserve the generator's possible-biome encounter order.
    /// Each biome identity occurs once; feature identity is allocation identity.
    // rust: pub fn new(
    // rust: biomes: Vec<(DecorationBiome, Vec<Vec<FeatureIdentity>>)>,
    // rust: ) -> Result<Self, FeatureSortError> {
    // rust: let ordered = biomes
    // rust: .iter()
    // rust: .map(|(_, steps)| steps.clone())
    // rust: .collect::<Vec<_>>();
    // rust: let steps = build_features_per_step(&ordered)?;
    // rust: let count = biomes.len();
    // rust: let biomes = biomes.into_iter().collect::<BTreeMap<_, _>>();
    // rust: if biomes.len() != count {
    // rust: return Err(FeatureSortError::DuplicateBiome);
}
    // rust: Ok(Self { biomes, steps })
}

    /// The step and the step-local index vanilla mixes into `set_feature_seed`.
    // rust: pub(super) fn seed(&self, feature: FeatureIdentity) -> Option<(usize, usize)> {
    // rust: self.steps
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find_map(|(step, data)| data.index(feature).map(|index| (index, step)))
}

    /// Execute the feature branch of chunk decoration with structures disabled.
    /// The callback must place the identified root with a biome-check context.
    /// It receives one shared placer and the correctly reseeded random stream;
    /// false results are ignored. Errors stop immediately without clearing the
    /// current-feature marker. A subsequent call starts with fresh placer state.
    // rust: pub fn decorate_features<W: DecorationWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: chunk: ChunkPos,
    // rust: world_seed: i64,
    // rust: place: impl FnMut(
    // rust: &mut W,
    // rust: &mut FeaturePlacer,
    // rust: &mut WorldgenRandom<XoroshiroRandom>,
    // rust: FeatureIdentity,
    // rust: [i32; 3],
    // rust: ) -> Result<bool, W::Error>,
    // rust: ) -> Result<(), DecorationError<W::Error>> {
    // rust: self.decorate(world, chunk, world_seed, 0, |_, _, _, _| Ok(()), place)
}

    /// Like `decorate_features`, running `structures` at the start of each of
    /// `max(structure_steps, feature steps)` steps, before that step's
    /// features (vanilla applyBiomeDecoration). It receives the shared random
    /// and decoration seed; it seeds per structure itself.
    // rust: pub fn decorate<W: DecorationWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: chunk: ChunkPos,
    // rust: world_seed: i64,
    // rust: structure_steps: usize,
    // rust: mut structures: impl FnMut(
    // rust: &mut W,
    // rust: &mut WorldgenRandom<XoroshiroRandom>,
    // rust: i64,
    // rust: usize,
    // rust: ) -> Result<(), W::Error>,
    // rust: mut place: impl FnMut(
    // rust: &mut W,
    // rust: &mut FeaturePlacer,
    // rust: &mut WorldgenRandom<XoroshiroRandom>,
    // rust: FeatureIdentity,
    // rust: [i32; 3],
    // rust: ) -> Result<bool, W::Error>,
    // rust: ) -> Result<(), DecorationError<W::Error>> {
    // rust: let origin = [
    // rust: chunk.x.wrapping_shl(4),
    // rust: world
    // rust: .min_section_y()
    // rust: .map_err(DecorationError::World)?
    // rust: .wrapping_shl(4),
    // rust: chunk.z.wrapping_shl(4),
    // rust: ];
    // rust: let mut random = WorldgenRandom::new(XoroshiroRandom::new(0));
    // rust: let seed = random.set_decoration_seed(world_seed, origin[0], origin[2]);
        // ChunkPos.rangeClosed overflows into a huge reversed traversal at the
        // extreme i32 chunk coordinates. Bound that unsupported work explicitly.
    // rust: if [chunk.x, chunk.z]
    // rust: .iter()
    // rust: .any(|v| *v == i32::MIN || *v == i32::MAX)
    // rust: {
    // rust: return Err(DecorationError::WorkLimit);
}
    // rust: let mut present = BTreeSet::new();
    // rust: for z in chunk.z - 1..=chunk.z + 1 {
    // rust: for x in chunk.x - 1..=chunk.x + 1 {
    // rust: let values = world
    // rust: .chunk_biomes(ChunkPos::new(x, z))
    // rust: .map_err(DecorationError::World)?;
    // rust: if values.len() > 65536 {
    // rust: return Err(DecorationError::WorkLimit);
}
    // rust: present.extend(values.into_iter().filter(|id| self.biomes.contains_key(id)));
}
}
    // rust: let mut placer = FeaturePlacer::new();
    // rust: for step in 0..structure_steps.max(self.steps.len()) {
    // rust: structures(world, &mut random, seed, step).map_err(DecorationError::World)?;
    // rust: let Some(data) = self.steps.get(step) else {
    // rust: continue;
}
    // rust: let mut selected = BTreeSet::new();
    // rust: for biome in &present {
    // rust: if let Some(features) = self.biomes[biome].get(step) {
    // rust: selected.extend(features.iter().map(|feature| {
    // rust: data.index(*feature)
    // rust: .expect("plan owns complete biome feature lists")
    // rust: }));
}
}
    // rust: for index in selected {
    // rust: let feature = data.features()[index];
    // rust: random.set_feature_seed(seed, index as i32, step as i32);
    // rust: world
    // rust: .set_currently_generating(Some(feature))
    // rust: .map_err(|error| DecorationError::Feature { feature, error })?;
    // rust: place(world, &mut placer, &mut random, feature, origin)
    // rust: .map_err(|error| DecorationError::Feature { feature, error })?;
}
}
    // rust: world
    // rust: .set_currently_generating(None)
    // rust: .map_err(DecorationError::World)
}
}
