//! Transpiled from Horizon Rust crate
//! Module: horizon-world_material_condition
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Numeric material conditions and their column/block evaluation caches.
//!
//! This worker owns its condition caches so they cannot be reused accidentally
//! against a different column context.
    // rust: mod codec;
    // rust: mod density;
    // rust: mod library;
    // rust: mod noise;
    // rust: mod rule;
// use super::{
    // rust: DecodeError,
    // rust: anchor::{VerticalAnchor, WorldGenerationContext},
    // rust: material_surface::MaterialSurface,
}
// use crate::registry::BlockStateId;
    // rust: pub use codec::{MaterialBiomeTag, MaterialConditionReference, MaterialConditionRegistry};
    // rust: pub use density::MaterialDensitySources;
// use horizon_core::noise::Noise;
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{PositionalRandom, RandomSource},
}
    // rust: pub use library::MaterialRuleLibrary;
    // rust: pub use noise::MaterialNoiseSources;
// use rule::CompiledRule;
    // rust: pub use rule::{CompiledSurfaceRule, SurfaceVariants};
    // rust: pub use rule::{MaterialRule, MaterialRuleError};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

/// Surface inputs come from the material system. Implementations should keep
/// world configuration fixed for the lifetime of a condition worker.
    // rust: pub trait MaterialSurfaceQueries {
    /// Bind a compiled density root, optionally sampling the expected chunk now.
    // rust: fn bind_density(
    // rust: &mut self,
    // rust: _sampler: Arc<dyn horizon_core::density::DensitySampler>,
    // rust: _eager: bool,
    // rust: ) -> Result<usize, DecodeError> {
    // rust: Err(DecodeError::Field("missing material density provider"))
}
pub fn density(self: *Self, _index: usize, _position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(MaterialRuleError::MissingDensityProvider)
}
pub fn preliminary_surface(self: *Self, _position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(MaterialRuleError::MissingDensityProvider)
}
pub fn possible_biomes(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn biome(self: *Self, _position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(MaterialRuleError::MissingBiomeProvider)
}
    /// `biome` as the index `biome_index` gives its name, for queries that
    /// number their biomes: biome conditions then compare numbers.
pub fn biome_id(self: *Self, _position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(MaterialRuleError::MissingBiomeProvider)
}
    /// `Some` when `biome_id` answers: the index of the biome `name` (`None`
    /// inside when no biome has that name).
pub fn biome_index(self: *Self, _name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
    // rust: fn melts_frozen_ocean(
    // rust: &mut self,
    // rust: _biome: &str,
    // rust: _position: BlockPos,
    // rust: _sea_level: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: Err(MaterialRuleError::MissingBiomeProvider)
}
    // rust: fn cold_enough_to_snow(
    // rust: &mut self,
    // rust: _biome: &str,
    // rust: _position: BlockPos,
    // rust: _sea_level: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: Err(MaterialRuleError::MissingBiomeProvider)
}
pub fn bind_noise(self: *Self, _name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(DecodeError::Field("missing material noise provider"))
}
pub fn surface_depth(self: *Self, x: i32, z: i32) i;
pub fn surface_secondary(self: *Self, x: i32, z: i32) f;
pub fn band(self: *Self, _position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(MaterialRuleError::MissingBandProvider)
}
}
    // rust: impl<T: MaterialSurfaceQueries + ?Sized> MaterialSurfaceQueries for &mut T {
    // rust: fn bind_density(
    // rust: &mut self,
    // rust: sampler: Arc<dyn horizon_core::density::DensitySampler>,
    // rust: eager: bool,
    // rust: ) -> Result<usize, DecodeError> {
    // rust: (**self).bind_density(sampler, eager)
}
pub fn density(self: *Self, index: usize, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).density(index, position)
}
pub fn preliminary_surface(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).preliminary_surface(position)
}
pub fn possible_biomes(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).possible_biomes()
}
pub fn biome(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).biome(position)
}
pub fn biome_id(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).biome_id(position)
}
pub fn biome_index(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).biome_index(name)
}
    // rust: fn cold_enough_to_snow(
    // rust: &mut self,
    // rust: biome: &str,
    // rust: position: BlockPos,
    // rust: sea: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: (**self).cold_enough_to_snow(biome, position, sea)
}
    // rust: fn melts_frozen_ocean(
    // rust: &mut self,
    // rust: biome: &str,
    // rust: position: BlockPos,
    // rust: sea: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: (**self).melts_frozen_ocean(biome, position, sea)
}
pub fn bind_noise(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).bind_noise(name)
}
pub fn surface_depth(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).surface_depth(x, z)
}
pub fn surface_secondary(self: *Self, x: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).surface_secondary(x, z)
}
pub fn band(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).band(position)
}
}
    // rust: impl<P: PositionalRandom> MaterialSurfaceQueries for MaterialSurface<P> {
pub fn band(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MaterialSurface::band(self, [position.x, position.y, position.z])
    // rust: .ok_or(MaterialRuleError::InvalidBandIndex)
}
pub fn surface_depth(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MaterialSurface::surface_depth(self, x, z)
}
pub fn surface_secondary(self: *Self, x: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MaterialSurface::surface_secondary(self, x, z)
}
}

pub const MaterialCondition = enum {
    Hole,
    Steep,
    Biome(Vec<String>),
    BiomeTag(MaterialBiomeTag),
    Temperature,
    AbovePreliminarySurface,
    NoiseThreshold {,
    noise: String,
    min: f64,
    max: f64,
    is_3d: bool,
    // rust: },
    YAbove {,
    anchor: VerticalAnchor,
    surface_depth_multiplier: i32,
    add_stone_depth: bool,
    // rust: },
    Water {,
    offset: i32,
    surface_depth_multiplier: i32,
    add_stone_depth: bool,
    // rust: },
    StoneDepth {,
    offset: i32,
    add_surface_depth: bool,
    secondary_depth_range: i32,
    ceiling: bool,
    // rust: },
    VerticalGradient {,
    random_name: String,
    true_at_and_below: VerticalAnchor,
    false_at_and_above: VerticalAnchor,
    // rust: },
    Not(Box<MaterialCondition>),
    Reference(MaterialConditionReference),
};

pub const Context = struct {
    surface: S,
    generation: WorldGenerationContext,
    column_revision: i64,
    block_revision: i64,
    position: BlockPos,
    gradient: [i32,
    depth: i32,
    water_height: i32,
    stone_above: i32,
    stone_below: i32,
    secondary_revision: i64,
    secondary: f64,
    minimum_revision: i64,
    minimum: i32,
    noises: std.ArrayList(CachedNoise),
    noise_indices: BTreeMap<([]const u8,
    possible_biomes: ?BTreeSet<[]const u8>,
    biome: ?*str,
    biome_id: ?u32,
};
pub const CachedNoise = struct {
    sampler: *dyn Noise,
    is_3d: bool,
    revision: i64,
    value: f64,
};
    // rust: impl<S: MaterialSurfaceQueries> Context<S> {
pub fn minimum_surface_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.minimum_revision != self.column_revision {
            // Vanilla stamps before sampling, including when sampling fails.
    // rust: self.minimum_revision = self.column_revision;
    // rust: let value = self.surface.preliminary_surface(BlockPos::new(
    // rust: self.position.x,
    // rust: 0,
    // rust: self.position.z,
    // rust: ))?;
            // 26.3 floors before the saturating Java numeric conversion.
    // rust: let floor = value.floor() as i32;
    // rust: self.minimum = floor.wrapping_add(self.depth).wrapping_sub(8);
}
    // rust: Ok(self.minimum)
}
pub fn biome(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.biome.is_none() {
    // rust: self.biome = self.surface.biome(self.position)?;
}
    // rust: Ok(self.biome.clone())
}
pub fn biome_id(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.biome_id.is_none() {
    // rust: self.biome_id = self.surface.biome_id(self.position)?;
}
    // rust: Ok(self.biome_id)
}
pub fn bind_noise(self: *Self, name: []const u8, is_3d: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (name.to_owned(), is_3d);
    // rust: if let Some(index) = self.noise_indices.get(&key) {
    // rust: return Ok(*index);
}
    // rust: let sampler = self.surface.bind_noise(name)?;
    // rust: let index = self.noises.len();
    // rust: self.noises.push(CachedNoise {
    // rust: sampler,
    // rust: is_3d,
    // rust: revision: if is_3d {
    // rust: self.block_revision
    // rust: } else {
    // rust: self.column_revision
}
    // rust: .wrapping_sub(1),
    // rust: value: 0.0,
    // rust: });
    // rust: self.noise_indices.insert(key, index);
    // rust: Ok(index)
}
pub fn noise(self: *Self, index: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let noise = &mut self.noises[index];
    // rust: let revision = if noise.is_3d {
    // rust: self.block_revision
    // rust: } else {
    // rust: self.column_revision
}
    // rust: if noise.revision != revision {
    // rust: noise.value = f64::from(noise.sampler.get3(
    // rust: f64::from(self.position.x),
    // rust: if noise.is_3d {
    // rust: f64::from(self.position.y)
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: f64::from(self.position.z),
    // rust: ));
    // rust: noise.revision = revision;
}
    // rust: noise.value
}
pub fn secondary(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.secondary_revision != self.column_revision {
    // rust: self.secondary_revision = self.column_revision;
    // rust: self.secondary = self
    // rust: .surface
    // rust: .surface_secondary(self.position.x, self.position.z);
}
    // rust: self.secondary
}
}
pub const Compiled = struct {
    kind: Kind<R>,
    revision: i64,
    result: ?bool,
};
pub const Kind = enum {
    Simple(MaterialCondition),
    Biome(BTreeSet<String>),
    /// `Biome` for queries that number their biomes: a bit per index.
    BiomeIds(Vec<u64>),
    Constant(bool),
    Noise {,
    sampler: usize,
    min: f64,
    max: f64,
    // rust: },
    Gradient {,
    low: i32,
    high: i32,
    random: R::Positional,
    // rust: },
    Not(Box<Compiled<R>>),
};
/// What a specialised rule may assume about every position it is applied to
/// (`CompiledRule::specialize`): its y lies in `low..=high`, and whether it is
/// at or above the column's preliminary surface level, when known.
pub const Facts = struct {
    low: i32,
    high: i32,
    above_surface: ?bool,
};
    // rust: impl<R: RandomSource> Clone for Kind<R>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Simple(condition) => Self::Simple(condition.clone()),
    // rust: Self::Biome(names) => Self::Biome(names.clone()),
    // rust: Self::BiomeIds(bits) => Self::BiomeIds(bits.clone()),
    // rust: Self::Constant(value) => Self::Constant(*value),
    // rust: Self::Noise { sampler, min, max } => Self::Noise {
    // rust: sampler: *sampler,
    // rust: min: *min,
    // rust: max: *max,
    // rust: },
    // rust: Self::Gradient { low, high, random } => Self::Gradient {
    // rust: low: *low,
    // rust: high: *high,
    // rust: random: random.clone(),
    // rust: },
    // rust: Self::Not(child) => Self::Not(child.clone()),
}
}
}
    // rust: impl<R: RandomSource> Clone for Compiled<R>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: kind: self.kind.clone(),
    // rust: revision: self.revision,
    // rust: result: self.result,
}
}
}
/// A chunk's possible biomes, by name and, where the surface numbers its
/// biomes, as a bit per index (`Kind::BiomeIds`).
pub const PossibleBiomes = struct {
    names: *'a BTreeSet<[]const u8>,
    ids: std.ArrayList(u64),
};
    // rust: impl<R: RandomSource> Compiled<R>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    /// This condition as `compile` makes it for a chunk with `possible`
    /// biomes: a biome condition none of them, or all of them, meet is
    /// constant.
pub fn fold_biomes(self: *Self, possible: *PossibleBiomes) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let decided = match &self.kind {
    // rust: Kind::Biome(names) if names.is_disjoint(possible.names) => Some(false),
    // rust: Kind::Biome(names) if possible.names.is_subset(names) => Some(true),
    // rust: Kind::BiomeIds(bits) => {
    // rust: let bit = |ids: &[u64], i: usize| ids.get(i).copied().unwrap_or(0);
    // rust: let mut words = 0..possible.ids.len().max(bits.len());
    // rust: if words
    // rust: .clone()
    // rust: .all(|i| bit(bits, i) & bit(&possible.ids, i) == 0)
    // rust: {
    // rust: Some(false)
    // rust: } else if words.all(|i| bit(&possible.ids, i) & !bit(bits, i) == 0) {
    // rust: Some(true)
    // rust: } else {
    // rust: None
}
}
    // rust: Kind::Not(child) => {
    // rust: return Self {
    // rust: kind: Kind::Not(Box::new(child.fold_biomes(possible))),
    // rust: revision: self.revision,
    // rust: result: self.result,
}
}
    // rust: _ => None,
}
    // rust: match decided {
    // rust: Some(value) => Self {
    // rust: kind: Kind::Constant(value),
    // rust: revision: self.revision,
    // rust: result: self.result,
    // rust: },
    // rust: None => self.clone(),
}
}
}
    // rust: impl<R: RandomSource> Compiled<R> {
    /// The value `facts` decide for this condition at every position they
    /// cover. Conditions read the position and the world, never change them,
    /// so one decided in advance gives what testing it would.
pub fn decided(self: *Self, facts: Facts) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.kind {
    // rust: Kind::Constant(value) => Some(*value),
    // rust: Kind::Simple(MaterialCondition::AbovePreliminarySurface) => facts.above_surface,
    // rust: Kind::Gradient { low, high, .. } => {
    // rust: if facts.high <= *low {
    // rust: Some(true)
    // rust: } else if facts.low >= *high {
    // rust: Some(false)
    // rust: } else {
    // rust: None
}
}
    // rust: Kind::Not(child) => child.decided(facts).map(|value| !value),
    // rust: _ => None,
}
}
    /// The first y of each band its vertical gradients decide differently
    /// from the band below, and whether the preliminary surface is asked for.
pub fn inputs(self: *Self, starts: *mut std.ArrayList(i32), surface: *mut bool) void {
}
    // rust: match &self.kind {
            // True at and below `low`, random between, false at and above
            // `high`: decided within each band these bound.
    // rust: Kind::Gradient { low, high, .. } => starts.extend([low.saturating_add(1), *high]),
    // rust: Kind::Simple(MaterialCondition::AbovePreliminarySurface) => *surface = true,
    // rust: Kind::Not(child) => child.inputs(starts, surface),
    // rust: _ => {}
}
}
pub fn constant_result(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.kind {
    // rust: Kind::Constant(value) => Some(*value),
    // rust: Kind::Not(child) => child.constant_result().map(|value| !value),
    // rust: _ => None,
}
}

    // rust: fn compile<S: MaterialSurfaceQueries>(
    // rust: condition: MaterialCondition,
    // rust: root: &R::Positional,
    // rust: context: &mut Context<S>,
    // rust: depth: usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth >= 256 {
    // rust: return Err(DecodeError::Field("material condition depth"));
}
    // rust: let column = matches!(
    // rust: condition,
    // rust: MaterialCondition::Hole | MaterialCondition::Steep
    // rust: );
    // rust: let kind = match condition {
    // rust: MaterialCondition::BiomeTag(tag) => {
    // rust: return Self::compile(
    // rust: MaterialCondition::Biome(tag.members().to_vec()),
    // rust: root,
    // rust: context,
    // rust: depth + 1,
    // rust: );
}
    // rust: MaterialCondition::Biome(names) => {
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("biome condition size"));
}
    // rust: let names = names
    // rust: .iter()
    // rust: .map(|name| codec::identifier(name))
    // rust: .collect::<Result<BTreeSet<_>, _>>()?;
    // rust: match &context.possible_biomes {
    // rust: Some(possible) if names.is_disjoint(possible) => Kind::Constant(false),
    // rust: Some(possible) if possible.is_subset(&names) => Kind::Constant(true),
                    // An empty list would not ask whether the surface numbers
                    // its biomes.
    // rust: _ if names.is_empty() => Kind::Biome(names),
    // rust: _ => match names
    // rust: .iter()
    // rust: .map(|name| context.surface.biome_index(name))
    // rust: .collect::<Option<Vec<_>>>()
    // rust: {
                        // Names no biome has never match the block's biome.
    // rust: Some(ids) => {
    // rust: let mut bits = Vec::new();
    // rust: for id in ids.into_iter().flatten() {
    // rust: let word = id as usize / 64;
    // rust: if bits.len() <= word {
    // rust: bits.resize(word + 1, 0);
}
    // rust: bits[word] |= 1 << (id % 64);
}
    // rust: Kind::BiomeIds(bits)
}
    // rust: None => Kind::Biome(names),
    // rust: },
}
}
    // rust: MaterialCondition::NoiseThreshold {
    // rust: noise,
    // rust: min,
    // rust: max,
    // rust: is_3d,
    // rust: } => Kind::Noise {
    // rust: sampler: context.bind_noise(&codec::identifier(&noise)?, is_3d)?,
    // rust: min,
    // rust: max,
    // rust: },
    // rust: MaterialCondition::Reference(reference) => {
    // rust: return Self::compile(reference.value().clone(), root, context, depth + 1);
}
    // rust: MaterialCondition::Not(child) => {
    // rust: Kind::Not(Box::new(Self::compile(*child, root, context, depth + 1)?))
}
    // rust: MaterialCondition::VerticalGradient {
    // rust: random_name,
    // rust: true_at_and_below,
    // rust: false_at_and_above,
    // rust: } => {
    // rust: let random_name = codec::identifier(&random_name)?;
    // rust: Kind::Gradient {
    // rust: low: true_at_and_below.resolve(context.generation),
    // rust: high: false_at_and_above.resolve(context.generation),
    // rust: random: root.from_hash_of(&random_name).fork_positional(),
}
}
    // rust: other => Kind::Simple(other),
}
    // rust: Ok(Self {
    // rust: kind,
    // rust: revision: if column {
    // rust: context.column_revision
    // rust: } else {
    // rust: context.block_revision
}
    // rust: .wrapping_sub(1),
    // rust: result: None,
    // rust: })
}
    // rust: fn test<S: MaterialSurfaceQueries>(
    // rust: &mut self,
    // rust: context: &mut Context<S>,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: if let Kind::Constant(value) = self.kind {
    // rust: return Ok(value);
}
    // rust: if matches!(
    // rust: self.kind,
    // rust: Kind::Simple(MaterialCondition::AbovePreliminarySurface)
    // rust: ) {
    // rust: return Ok(context.position.y >= context.minimum_surface_level()?);
}
    // rust: if matches!(self.kind, Kind::Simple(MaterialCondition::Temperature)) {
    // rust: let biome = context.biome()?.ok_or(MaterialRuleError::MissingBiome)?;
    // rust: return context.surface.cold_enough_to_snow(
    // rust: &biome,
    // rust: context.position,
    // rust: context.generation.sea_level,
    // rust: );
}
    // rust: if let Kind::Noise { sampler, min, max } = &self.kind {
    // rust: let value = context.noise(*sampler);
    // rust: return Ok(value >= *min && value <= *max);
}
    // rust: if let Kind::Not(child) = &mut self.kind {
    // rust: return child.test(context).map(|value| !value);
}
    // rust: let column = matches!(
    // rust: self.kind,
    // rust: Kind::Simple(MaterialCondition::Hole | MaterialCondition::Steep)
    // rust: );
    // rust: let revision = if column {
    // rust: context.column_revision
    // rust: } else {
    // rust: context.block_revision
}
    // rust: if self.revision == revision {
    // rust: return self
    // rust: .result
    // rust: .ok_or(MaterialRuleError::CachedConditionUnavailable);
}
    // rust: self.revision = revision;
    // rust: let result = match &self.kind {
    // rust: Kind::Biome(names) => names.contains(
    // rust: context
    // rust: .biome()?
    // rust: .ok_or(MaterialRuleError::MissingBiome)?
    // rust: .as_ref(),
    // rust: ),
    // rust: Kind::BiomeIds(bits) => {
    // rust: let id = context.biome_id()?.ok_or(MaterialRuleError::MissingBiome)?;
    // rust: bits.get(id as usize / 64)
    // rust: .is_some_and(|word| word >> (id % 64) & 1 == 1)
}
    // rust: Kind::Simple(MaterialCondition::Hole) => context.depth <= 0,
    // rust: Kind::Simple(MaterialCondition::Steep) => {
    // rust: context.gradient[0] <= -4 || context.gradient[1] >= 4
}
    // rust: Kind::Simple(MaterialCondition::YAbove {
    // rust: anchor,
    // rust: surface_depth_multiplier,
    // rust: add_stone_depth,
    // rust: }) => {
    // rust: let y = context.position.y.wrapping_add(if *add_stone_depth {
    // rust: context.stone_above
    // rust: } else {
    // rust: 0
    // rust: });
    // rust: y >= anchor
    // rust: .resolve(context.generation)
    // rust: .wrapping_add(context.depth.wrapping_mul(*surface_depth_multiplier))
}
    // rust: Kind::Simple(MaterialCondition::Water {
    // rust: offset,
    // rust: surface_depth_multiplier,
    // rust: add_stone_depth,
    // rust: }) => {
    // rust: context.water_height == i32::MIN
    // rust: || context.position.y.wrapping_add(if *add_stone_depth {
    // rust: context.stone_above
    // rust: } else {
    // rust: 0
    // rust: }) >= context
    // rust: .water_height
    // rust: .wrapping_add(*offset)
    // rust: .wrapping_add(context.depth.wrapping_mul(*surface_depth_multiplier))
}
    // rust: Kind::Simple(MaterialCondition::StoneDepth {
    // rust: offset,
    // rust: add_surface_depth,
    // rust: secondary_depth_range,
    // rust: ceiling,
    // rust: }) => {
    // rust: let stone = if *ceiling {
    // rust: context.stone_below
    // rust: } else {
    // rust: context.stone_above
}
    // rust: let surface = if *add_surface_depth { context.depth } else { 0 };
    // rust: let secondary = if *secondary_depth_range == 0 {
    // rust: 0
    // rust: } else {
    // rust: (0.0 + ((context.secondary() - -1.0) / (1.0 - -1.0))
    // rust: * (f64::from(*secondary_depth_range) - 0.0)) as i32
}
    // rust: stone
    // rust: <= 1i32
    // rust: .wrapping_add(*offset)
    // rust: .wrapping_add(surface)
    // rust: .wrapping_add(secondary)
}
    // rust: Kind::Gradient { low, high, random } => {
    // rust: let y = context.position.y;
    // rust: if y <= *low {
    // rust: true
    // rust: } else if y >= *high {
    // rust: false
    // rust: } else {
    // rust: let probability = 1.0
    // rust: + ((f64::from(y) - f64::from(*low)) / (f64::from(*high) - f64::from(*low)))
    // rust: * (0.0 - 1.0);
    // rust: f64::from(random.at(context.position).next_float()) < probability
}
}
    // rust: _ => unreachable!("all recursive and gradient definitions are compiled"),
}
    // rust: self.result = Some(result);
    // rust: Ok(result)
}
}

/// A thread-local material-condition worker. Surface state and evaluations are
/// owned together; updates invalidate exactly the corresponding vanilla caches.
pub const MaterialConditions = struct {
    root: R::Positional,
    context: Context<S>,
    conditions: std.ArrayList(Compiled<R)>,
    rules: std.ArrayList(CompiledRule<R)>,
};
    // rust: impl<R: RandomSource, S: MaterialSurfaceQueries> MaterialConditions<R, S> {
pub fn new(generation: WorldGenerationContext, root: R::Positional, surface: S) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let possible_biomes = surface.possible_biomes();
    // rust: Self::with_possible_biomes(generation, root, surface, possible_biomes)
}
    // rust: pub(crate) fn with_possible_biomes(
    // rust: generation: WorldGenerationContext,
    // rust: root: R::Positional,
    // rust: surface: S,
    // rust: possible_biomes: Option<BTreeSet<String>>,
    // rust: ) -> Self {
    // rust: Self {
    // rust: root,
    // rust: context: Context {
    // rust: surface,
    // rust: generation,
    // rust: column_revision: i64::MIN + 1,
    // rust: block_revision: i64::MIN + 1,
    // rust: position: BlockPos::new(0, 0, 0),
    // rust: gradient: [0, 0],
    // rust: depth: 0,
    // rust: water_height: 0,
    // rust: stone_above: 0,
    // rust: stone_below: 0,
    // rust: secondary_revision: i64::MIN,
    // rust: secondary: 0.0,
    // rust: minimum_revision: i64::MIN,
    // rust: minimum: 0,
    // rust: noises: Vec::new(),
    // rust: noise_indices: BTreeMap::new(),
    // rust: possible_biomes,
    // rust: biome: None,
    // rust: biome_id: None,
    // rust: },
    // rust: conditions: Vec::new(),
    // rust: rules: Vec::new(),
}
}
    /// Compile a condition at the current context revision. Gradient bounds and
    /// named random factories are bound now, before the first evaluation.
pub fn add(self: *Self, condition: MaterialCondition) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.conditions.len() >= 8192 {
    // rust: return Err(DecodeError::Field("material condition count"));
}
    // rust: let compiled = Compiled::compile(condition, &self.root, &mut self.context, 0)?;
    // rust: let index = self.conditions.len();
    // rust: self.conditions.push(compiled);
    // rust: Ok(index)
}
pub fn update_xz(self: *Self, x: i32, z: i32, gradient_x: i32, gradient_z: i32) void {
}
    // rust: self.context.column_revision = self.context.column_revision.wrapping_add(1);
    // rust: self.context.block_revision = self.context.block_revision.wrapping_add(1);
    // rust: self.context.position.x = x;
    // rust: self.context.position.z = z;
    // rust: self.context.gradient = [gradient_x, gradient_z];
    // rust: self.context.depth = self.context.surface.surface_depth(x, z);
}
pub fn update_y(self: *Self, stone_above: i32, stone_below: i32, water_height: i32, y: i32) void {
}
    // rust: self.context.block_revision = self.context.block_revision.wrapping_add(1);
    // rust: self.context.biome = None;
    // rust: self.context.biome_id = None;
    // rust: self.context.position.y = y;
    // rust: self.context.stone_above = stone_above;
    // rust: self.context.stone_below = stone_below;
    // rust: self.context.water_height = water_height;
}
pub fn test(self: *Self, index: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.conditions
    // rust: .get_mut(index)
    // rust: .ok_or(MaterialRuleError::UnknownCondition)?
    // rust: .test(&mut self.context)
}
    /// Direct biome lookup for the outer column scan, independent of condition caching.
pub fn biome_at(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.context.surface.biome(position)
}
    // rust: pub fn melts_frozen_ocean(
    // rust: &mut self,
    // rust: biome: &str,
    // rust: position: BlockPos,
    // rust: sea_level: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: self.context
    // rust: .surface
    // rust: .melts_frozen_ocean(biome, position, sea_level)
}
pub fn minimum_surface_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.context.minimum_surface_level()
}
pub fn into_surface(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.context.surface
}
pub fn surface_depth(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.context.depth
}
pub fn surface_secondary(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.context.secondary()
}
}
