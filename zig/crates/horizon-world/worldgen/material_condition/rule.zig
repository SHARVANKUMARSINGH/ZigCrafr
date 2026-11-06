//! Transpiled from Horizon Rust crate
//! Module: horizon-world_rule
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Compiled material rule composition, sharing the condition worker's context.
// use super::{
    // rust: CachedNoise, Compiled, Context, Facts, MaterialCondition, MaterialConditions,
    // rust: MaterialSurfaceQueries, PossibleBiomes, density::MaterialDensitySources,
}
// use crate::{registry::BlockStateId, worldgen::DecodeError};
// use horizon_core::{
    // rust: density::DensitySampler,
    // rust: noise::Noise,
    // rust: position::BlockPos,
    // rust: random::{PositionalRandom, RandomSource},
}
// use std::sync::Arc;

pub const MaterialRule = enum {
    Block(BlockStateId),
    Reference(Arc<MaterialRule>),
    /// Density roots must be compiled for the same world and sampler context.
    OreVein {,
    ore: BlockStateId,
    raw_ore: BlockStateId,
    filler: BlockStateId,
    raw_ore_chance: f32,
    density: Arc<dyn DensitySampler>,
    richness: Arc<dyn DensitySampler>,
    filler_gap: Arc<dyn DensitySampler>,
        /// Inclusive y bounds outside which `density` is never positive, so
        /// the vein places nothing there (`DensityGraph::positive_y_bounds`);
        /// `[i32::MIN, i32::MAX]` when unknown.
    positive_y: [i32; 2],
    // rust: },
    Sequence(Vec<MaterialRule>),
    Condition {,
    if_true: MaterialCondition,
    then_run: Box<MaterialRule>,
    // rust: },
    /// Vanilla calls this rule "bandlands"; it queries terracotta bands.
    Bandlands,
};
pub const MaterialRuleError = enum {
    UnknownRule,
    UnknownCondition,
    MissingBiomeProvider,
    BiomeQueryFailed,
    MissingBiome,
    CachedConditionUnavailable,
    MissingBandProvider,
    MissingDensityProvider,
    Density(horizon_core::density::SampleError),
    InvalidBandIndex,
};
    // rust: impl std::fmt::Display for MaterialRuleError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Self::Density(error) = self {
    // rust: return error.fmt(f);
}
    // rust: f.write_str(match self {
    // rust: Self::Density(_) => unreachable!(),
    // rust: Self::MissingDensityProvider => "missing material density provider",
    // rust: Self::UnknownRule => "unknown material rule",
    // rust: Self::UnknownCondition => "unknown material condition",
    // rust: Self::MissingBiomeProvider => "missing material biome provider",
    // rust: Self::BiomeQueryFailed => "material biome lookup failed",
    // rust: Self::MissingBiome => "material position has no biome",
    // rust: Self::CachedConditionUnavailable => "condition was updated without a cached result",
    // rust: Self::MissingBandProvider => "missing material band provider",
    // rust: Self::InvalidBandIndex => "negative material band index",
    // rust: })
}
}
    // rust: impl std::error::Error for MaterialRuleError {}
    // rust: impl From<horizon_core::density::SampleError> for MaterialRuleError {
pub fn from(error: horizon_core::density::SampleError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Density(error)
}
}

    // rust: pub(super) enum CompiledRule<R: RandomSource> {
    // rust: Empty,
    // rust: Block(BlockStateId),
    // rust: OreVein {
    // rust: blocks: [BlockStateId; 3],
    // rust: raw_ore_chance: f32,
    // rust: densities: [usize; 3],
    // rust: random: R::Positional,
    // rust: positive_y: [i32; 2],
    // rust: },
    // rust: Sequence(Vec<Self>),
    // rust: Condition {
    // rust: condition: Compiled<R>,
    // rust: rule: Box<Self>,
    // rust: },
    // rust: Bandlands,
}
    // rust: impl<R: RandomSource> CompiledRule<R> {
    // rust: fn compile<S: MaterialSurfaceQueries>(
    // rust: rule: MaterialRule,
    // rust: root: &R::Positional,
    // rust: context: &mut Context<S>,
    // rust: depth: usize,
    // rust: nodes: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: *nodes += 1;
    // rust: if depth >= 256 || *nodes > 65536 {
    // rust: return Err(DecodeError::Field("material rule size"));
}
    // rust: Ok(match rule {
    // rust: MaterialRule::Block(block) => Self::Block(block),
    // rust: MaterialRule::Reference(value) => {
    // rust: return Self::compile((*value).clone(), root, context, depth + 1, nodes);
}
    // rust: MaterialRule::OreVein {
    // rust: ore,
    // rust: raw_ore,
    // rust: filler,
    // rust: raw_ore_chance,
    // rust: density,
    // rust: richness,
    // rust: filler_gap,
    // rust: positive_y,
    // rust: } => {
    // rust: let density = context.surface.bind_density(density, true)?;
    // rust: let richness = context.surface.bind_density(richness, true)?;
    // rust: let gap = context.surface.bind_density(filler_gap, false)?;
    // rust: let random = root.from_hash_of("minecraft:ore").fork_positional();
    // rust: Self::OreVein {
    // rust: blocks: [ore, raw_ore, filler],
    // rust: raw_ore_chance,
    // rust: densities: [density, richness, gap],
    // rust: random,
    // rust: positive_y,
}
}
    // rust: MaterialRule::Bandlands => Self::Bandlands,
    // rust: MaterialRule::Condition { if_true, then_run } => {
                // Compile the predicate before the nested rule, regardless of
                // whether the predicate will match any subsequent position.
    // rust: let condition = Compiled::compile(if_true, root, context, depth + 1)?;
    // rust: let rule = Box::new(Self::compile(*then_run, root, context, depth + 1, nodes)?);
                // Compile both sides first: binding and errors must retain their order.
    // rust: match condition.constant_result() {
    // rust: Some(false) => Self::Empty,
    // rust: Some(true) => *rule,
    // rust: None => Self::Condition { condition, rule },
}
}
    // rust: MaterialRule::Sequence(mut children) => {
    // rust: if children.len() == 1 {
    // rust: return Self::compile(children.pop().unwrap(), root, context, depth + 1, nodes);
}
    // rust: let mut result = Vec::with_capacity(children.len());
    // rust: for child in children {
    // rust: let child = Self::compile(child, root, context, depth + 1, nodes)?;
    // rust: if !matches!(child, Self::Empty) {
    // rust: result.push(child);
}
}
    // rust: match result.len() {
    // rust: 0 => Self::Empty,
    // rust: 1 => result.pop().unwrap(),
    // rust: _ => Self::Sequence(result),
}
}
    // rust: })
}
    // rust: fn apply<S: MaterialSurfaceQueries>(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: context: &mut Context<S>,
    // rust: ) -> Result<Option<BlockStateId>, MaterialRuleError> {
    // rust: match self {
    // rust: Self::Empty => Ok(None),
    // rust: Self::Block(block) => Ok(Some(*block)),
    // rust: Self::OreVein {
    // rust: blocks,
    // rust: raw_ore_chance,
    // rust: densities,
    // rust: random,
    // rust: ..
    // rust: } => {
                // Densities use the context; randomness uses application coordinates.
    // rust: let density = context.surface.density(densities[0], context.position)?;
    // rust: if density <= 0.0 {
    // rust: return Ok(None);
}
    // rust: let mut random = random.at(position);
    // rust: if random.next_float() > density {
    // rust: return Ok(None);
}
    // rust: let richness = context.surface.density(densities[1], context.position)?;
    // rust: if random.next_float() < richness
    // rust: && context.surface.density(densities[2], context.position)? < 0.0
    // rust: {
    // rust: Ok(Some(if random.next_float() < *raw_ore_chance {
    // rust: blocks[1]
    // rust: } else {
    // rust: blocks[0]
    // rust: }))
    // rust: } else {
    // rust: Ok(Some(blocks[2]))
}
}
    // rust: Self::Bandlands => context.surface.band(position).map(Some),
    // rust: Self::Condition { condition, rule } => {
    // rust: if condition.test(context)? {
    // rust: rule.apply(position, context)
    // rust: } else {
    // rust: Ok(None)
}
}
    // rust: Self::Sequence(children) => {
    // rust: for child in children {
    // rust: if let Some(block) = child.apply(position, context)? {
    // rust: return Ok(Some(block));
}
}
    // rust: Ok(None)
}
}
}
}
    // rust: impl<R: RandomSource> CompiledRule<R>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    /// This rule where `facts` hold: conditions they decide are folded away,
    /// with what can no longer produce a block, and a sequence stops at its
    /// first child that always produces one. For every position the facts
    /// cover it gives the block the whole rule gives.
pub fn specialize(self: *Self, facts: Facts) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Empty => Self::Empty,
    // rust: Self::Block(block) => Self::Block(*block),
    // rust: Self::Bandlands => Self::Bandlands,
    // rust: Self::OreVein {
    // rust: blocks,
    // rust: raw_ore_chance,
    // rust: densities,
    // rust: random,
    // rust: positive_y: [low, high],
    // rust: } => {
                // A non-positive density returns before the vein's
                // positional random is drawn: nothing else is consumed.
    // rust: if low > high || facts.high < *low || facts.low > *high {
    // rust: return Self::Empty;
}
    // rust: Self::OreVein {
    // rust: blocks: *blocks,
    // rust: raw_ore_chance: *raw_ore_chance,
    // rust: densities: *densities,
    // rust: random: random.clone(),
    // rust: positive_y: [*low, *high],
}
}
    // rust: Self::Condition { condition, rule } => match condition.decided(facts) {
    // rust: Some(false) => Self::Empty,
    // rust: Some(true) => rule.specialize(facts),
    // rust: None => match rule.specialize(facts) {
    // rust: Self::Empty => Self::Empty,
    // rust: rule => Self::Condition {
    // rust: condition: condition.clone(),
    // rust: rule: Box::new(rule),
    // rust: },
    // rust: },
    // rust: },
    // rust: Self::Sequence(children) => {
    // rust: let mut result = Vec::new();
    // rust: for child in children {
    // rust: let child = child.specialize(facts);
    // rust: if matches!(child, Self::Empty) {
    // rust: continue;
}
    // rust: let last = child.always_produces();
    // rust: result.push(child);
    // rust: if last {
    // rust: break;
}
}
    // rust: match result.len() {
    // rust: 0 => Self::Empty,
    // rust: 1 => result.pop().unwrap(),
    // rust: _ => Self::Sequence(result),
}
}
}
}
    /// This rule as `compile` makes it for a chunk with `possible` biomes
    /// (a copy without them): the biome conditions they decide are constant,
    /// and folded away as `compile` folds them.
pub fn fold_biomes(self: *Self, possible: ?*PossibleBiomes) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Empty => Self::Empty,
    // rust: Self::Block(block) => Self::Block(*block),
    // rust: Self::Bandlands => Self::Bandlands,
    // rust: Self::OreVein {
    // rust: blocks,
    // rust: raw_ore_chance,
    // rust: densities,
    // rust: random,
    // rust: positive_y,
    // rust: } => Self::OreVein {
    // rust: blocks: *blocks,
    // rust: raw_ore_chance: *raw_ore_chance,
    // rust: densities: *densities,
    // rust: random: random.clone(),
    // rust: positive_y: *positive_y,
    // rust: },
    // rust: Self::Condition { condition, rule } => {
    // rust: let condition = match possible {
    // rust: Some(possible) => condition.fold_biomes(possible),
    // rust: None => condition.clone(),
}
    // rust: let rule = rule.fold_biomes(possible);
    // rust: match condition.constant_result() {
    // rust: Some(false) => Self::Empty,
    // rust: Some(true) => rule,
    // rust: None => Self::Condition {
    // rust: condition,
    // rust: rule: Box::new(rule),
    // rust: },
}
}
    // rust: Self::Sequence(children) => {
    // rust: let mut result: Vec<_> = children
    // rust: .iter()
    // rust: .map(|child| child.fold_biomes(possible))
    // rust: .filter(|child| !matches!(child, Self::Empty))
    // rust: .collect();
    // rust: match result.len() {
    // rust: 0 => Self::Empty,
    // rust: 1 => result.pop().unwrap(),
    // rust: _ => Self::Sequence(result),
}
}
}
}
    /// Whether applying this rule never gives `None` (only an error).
pub fn always_produces(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Block(_) | Self::Bandlands => true,
    // rust: Self::Sequence(children) => children.iter().any(Self::always_produces),
    // rust: Self::Empty | Self::OreVein { .. } | Self::Condition { .. } => false,
}
}
    /// The first y of each band in which this rule specialises differently
    /// from the band below, unordered, and whether the preliminary surface is
    /// asked for.
pub fn inputs(self: *Self, starts: *mut std.ArrayList(i32), surface: *mut bool) void {
}
    // rust: match self {
    // rust: Self::Condition { condition, rule } => {
    // rust: condition.inputs(starts, surface);
    // rust: rule.inputs(starts, surface);
}
    // rust: Self::Sequence(children) => {
    // rust: for child in children {
    // rust: child.inputs(starts, surface);
}
}
    // rust: Self::OreVein {
    // rust: positive_y: [low, high],
    // rust: ..
    // rust: } if low <= high => {
    // rust: if *low != i32::MIN {
    // rust: starts.push(*low);
}
    // rust: if *high != i32::MAX {
    // rust: starts.push(high + 1);
}
}
    // rust: _ => {}
}
}
}
    // rust: impl MaterialRule {
    /// The highest y at which an ore vein of this rule can place a block
    /// (`MaterialRule::OreVein::positive_y`), `i32::MIN` without veins.
pub fn ore_vein_top(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ore_vein_top_within(0, &mut 0)
}
pub fn ore_vein_top_within(self: *Self, depth: usize, nodes: *mut usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *nodes += 1;
        // Larger rules fail to compile (`CompiledRule::compile`); do not
        // bound them.
    // rust: if depth >= 256 || *nodes > 65536 {
    // rust: return i32::MAX;
}
    // rust: match self {
    // rust: Self::Block(_) | Self::Bandlands => i32::MIN,
    // rust: Self::Reference(rule) => rule.ore_vein_top_within(depth + 1, nodes),
    // rust: Self::OreVein {
    // rust: positive_y: [low, high],
    // rust: ..
    // rust: } => {
    // rust: if low > high {
    // rust: i32::MIN
    // rust: } else {
    // rust: *high
}
}
    // rust: Self::Sequence(children) => {
    // rust: let mut top = i32::MIN;
    // rust: for child in children {
    // rust: top = top.max(child.ore_vein_top_within(depth + 1, nodes));
}
    // rust: top
}
    // rust: Self::Condition { then_run, .. } => then_run.ore_vein_top_within(depth + 1, nodes),
}
}
}
/// A rule specialised (`CompiledRule::specialize`) for each band of y between
/// its vertical gradients' bounds and its ore veins' `positive_y` bounds, and
/// below and at or above the preliminary surface when the rule asks for it:
/// most blocks of a column, deep stone, then evaluate only the few rules that
/// can apply there. Each variant is made when first asked for.
pub const SurfaceVariants = struct {
    /// The rule the variants specialise.
    base: usize,
    /// The first y of each band after the first, ascending.
    starts: std.ArrayList(i32),
    /// Per band (two per band, below then above the surface, when
    /// `surface`): the variant's rule index once made, `Some(None)` when it
    /// gives no block.
    rules: std.ArrayList(?Option<usize)>,
    surface: bool,
};
    // rust: impl SurfaceVariants {
    /// The band holding `y`.
pub fn band(self: *Self, y: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.starts.partition_point(|&start| start <= y)
}
    /// The inclusive y bounds of `band`.
pub fn band_bounds(self: *Self, band: usize) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let low = if band == 0 {
    // rust: i32::MIN
    // rust: } else {
    // rust: self.starts[band - 1]
}
    // rust: let high = self.starts.get(band).map_or(i32::MAX, |&next| next - 1);
    // rust: [low, high]
}
}
    // rust: impl<R: RandomSource, S: MaterialSurfaceQueries> MaterialConditions<R, S>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    /// The bands of the specialised variants of rule `index`
    /// (`SurfaceVariants`); `surface_variant` makes each.
pub fn surface_variants(self: *Self, index: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rule = self
    // rust: .rules
    // rust: .get(index)
    // rust: .ok_or(MaterialRuleError::UnknownRule)?;
    // rust: let (mut starts, mut surface) = (Vec::new(), false);
    // rust: rule.inputs(&mut starts, &mut surface);
    // rust: starts.sort_unstable();
    // rust: starts.dedup();
    // rust: let sides = if surface { 2 } else { 1 };
    // rust: Ok(SurfaceVariants {
    // rust: base: index,
    // rust: rules: vec![None; (starts.len() + 1) * sides],
    // rust: starts,
    // rust: surface,
    // rust: })
}
    /// The rule index of the variant for `band`, `above` the preliminary
    /// surface (ignored unless `variants.surface`), or `None` when it gives
    /// no block at any position of the band.
    // rust: pub fn surface_variant(
    // rust: &mut self,
    // rust: variants: &mut SurfaceVariants,
    // rust: band: usize,
    // rust: above: bool,
    // rust: ) -> Option<usize> {
    // rust: let slot = if variants.surface {
    // rust: band * 2 + usize::from(above)
    // rust: } else {
    // rust: band
}
    // rust: if let Some(rule) = variants.rules[slot] {
    // rust: return rule;
}
    // rust: self.make_surface_variant(variants, band, above, slot)
}
    // rust: fn make_surface_variant(
    // rust: &mut self,
    // rust: variants: &mut SurfaceVariants,
    // rust: band: usize,
    // rust: above: bool,
    // rust: slot: usize,
    // rust: ) -> Option<usize> {
    // rust: let [low, high] = variants.band_bounds(band);
    // rust: let facts = Facts {
    // rust: low,
    // rust: high,
    // rust: above_surface: variants.surface.then_some(above),
}
    // rust: let rule = match self.rules[variants.base].specialize(facts) {
    // rust: CompiledRule::Empty => None,
    // rust: rule => {
    // rust: self.rules.push(rule);
    // rust: Some(self.rules.len() - 1)
}
}
    // rust: variants.rules[slot] = Some(rule);
    // rust: rule
}
}
/// A world's surface rule compiled once for every chunk of a generator
/// worker: the rule before any chunk's possible biomes fold it, the noises it
/// bound, and the densities (ore veins) it binds to each chunk's volume, in
/// the order it bound them.
pub const CompiledSurfaceRule = struct {
    rule: CompiledRule<R>,
    noises: Vec<(([]const u8,
    densities: std.ArrayList((Arc<dyn DensitySampler),
};
/// The densities `CompiledRule::compile` binds for `rule`, in its order,
/// with whether it samples each over the volume now.
pub fn density_bindings(rule: *MaterialRule, out: *mut std.ArrayList((Arc<dyn DensitySampler)) void {
}
    // rust: match rule {
    // rust: MaterialRule::Reference(value) => density_bindings(value, out),
    // rust: MaterialRule::OreVein {
    // rust: density,
    // rust: richness,
    // rust: filler_gap,
    // rust: ..
    // rust: } => out.extend([
    // rust: (Arc::clone(density), true),
    // rust: (Arc::clone(richness), true),
    // rust: (Arc::clone(filler_gap), false),
    // rust: ]),
    // rust: MaterialRule::Condition { then_run, .. } => density_bindings(then_run, out),
    // rust: MaterialRule::Sequence(children) => {
    // rust: for child in children {
    // rust: density_bindings(child, out);
}
}
    // rust: MaterialRule::Block(_) | MaterialRule::Bandlands => {}
}
}
    // rust: impl<R: RandomSource, S: MaterialSurfaceQueries> MaterialConditions<R, S>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    /// `add_rule`, compiling `rule` only the first time `shared` is used:
    /// later workers take the compiled rule and its noises, bind its densities
    /// to their own volume in the same order, and fold it with their own
    /// possible biomes as `compile` does. A worker that already holds rules or
    /// noises, or a possible biome the surface doesn't number, compiles as
    /// `add_rule` does.
    // rust: pub fn add_shared_rule(
    // rust: &mut self,
    // rust: rule: &MaterialRule,
    // rust: shared: &mut Option<CompiledSurfaceRule<R>>,
    // rust: ) -> Result<usize, DecodeError> {
    // rust: let fresh = self.rules.is_empty() && self.context.noises.is_empty();
    // rust: if !fresh || self.rules.len() >= 8192 {
    // rust: return self.add_rule(rule.clone());
}
    // rust: let mut ids = Vec::new();
    // rust: if let Some(names) = &self.context.possible_biomes {
    // rust: for name in names {
    // rust: let Some(Some(id)) = self.context.surface.biome_index(name) else {
    // rust: return self.add_rule(rule.clone());
}
    // rust: let word = id as usize / 64;
    // rust: if ids.len() <= word {
    // rust: ids.resize(word + 1, 0);
}
    // rust: ids[word] |= 1 << (id % 64);
}
}
    // rust: match shared {
    // rust: Some(shared) => {
    // rust: for (key, sampler) in &shared.noises {
    // rust: let is_3d = key.1;
    // rust: let index = self.context.noises.len();
    // rust: self.context.noises.push(CachedNoise {
    // rust: sampler: Arc::clone(sampler),
    // rust: is_3d,
    // rust: revision: if is_3d {
    // rust: self.context.block_revision
    // rust: } else {
    // rust: self.context.column_revision
}
    // rust: .wrapping_sub(1),
    // rust: value: 0.0,
    // rust: });
    // rust: self.context.noise_indices.insert(key.clone(), index);
}
    // rust: for (sampler, eager) in &shared.densities {
    // rust: self.context
    // rust: .surface
    // rust: .bind_density(Arc::clone(sampler), *eager)?;
}
}
    // rust: None => {
    // rust: let possible = self.context.possible_biomes.take();
    // rust: let compiled =
    // rust: CompiledRule::compile(rule.clone(), &self.root, &mut self.context, 0, &mut 0);
    // rust: self.context.possible_biomes = possible;
    // rust: let compiled = compiled?;
    // rust: let mut noises: Vec<_> = self
    // rust: .context
    // rust: .noise_indices
    // rust: .iter()
    // rust: .map(|(key, &index)| (index, key.clone()))
    // rust: .collect();
    // rust: noises.sort_unstable_by_key(|(index, _)| *index);
    // rust: let noises = noises
    // rust: .into_iter()
    // rust: .map(|(index, key)| (key, Arc::clone(&self.context.noises[index].sampler)))
    // rust: .collect();
    // rust: let mut densities = Vec::new();
    // rust: density_bindings(rule, &mut densities);
    // rust: *shared = Some(CompiledSurfaceRule {
    // rust: rule: compiled,
    // rust: noises,
    // rust: densities,
    // rust: });
}
}
    // rust: let shared = shared.as_ref().expect("compiled above");
    // rust: let possible = self
    // rust: .context
    // rust: .possible_biomes
    // rust: .as_ref()
    // rust: .map(|names| PossibleBiomes { names, ids });
    // rust: let folded = shared.rule.fold_biomes(possible.as_ref());
    // rust: let index = self.rules.len();
    // rust: self.rules.push(folded);
    // rust: Ok(index)
}
}
    // rust: impl<R: RandomSource, T: MaterialSurfaceQueries> MaterialConditions<R, MaterialDensitySources<T>> {
    /// Re-target the per-cell density bindings for a reused worker.
pub fn retarget_surface_densities(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.context.surface.retarget(position)
}
}
    // rust: impl<R: RandomSource, S: MaterialSurfaceQueries> MaterialConditions<R, S> {
    /// Compile all children in order, even after an unconditional block rule.
    /// Failed compilation never adds a partial rule to this worker.
pub fn add_rule(self: *Self, rule: MaterialRule) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.rules.len() >= 8192 {
    // rust: return Err(DecodeError::Field("material rule count"));
}
    // rust: let compiled = CompiledRule::compile(rule, &self.root, &mut self.context, 0, &mut 0)?;
    // rust: let index = self.rules.len();
    // rust: self.rules.push(compiled);
    // rust: Ok(index)
}
    /// Predicates read the worker's updated context. Position arguments are
    /// forwarded to block-producing rules independently, as in vanilla.
    // rust: pub fn try_apply(
    // rust: &mut self,
    // rust: index: usize,
    // rust: position: BlockPos,
    // rust: ) -> Result<Option<BlockStateId>, MaterialRuleError> {
    // rust: self.rules
    // rust: .get_mut(index)
    // rust: .ok_or(MaterialRuleError::UnknownRule)?
    // rust: .apply(position, &mut self.context)
}
}
