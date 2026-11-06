//! Transpiled from Horizon Rust crate
package horizon_world_feature_sort

import "core:fmt"
import "core:mem"
import "core:math"

// Deterministic feature ordering across biome generation steps.
// use std::collections::{BTreeMap, BTreeSet};

// A placed-feature object identity, assigned by the owning registry snapshot.
// Structurally equal but separately allocated features need distinct IDs.
FeatureIdentity :: struct {

StepFeatureData :: struct {
    features: [dynamic]FeatureIdentity,
    indices: BTreeMap<FeatureIdentity,
}
    // rust: impl StepFeatureData {
features :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.features
}
index :: proc(self: ^Self, feature: FeatureIdentity) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.indices.get(&feature).copied()
}
}
FeatureSortError :: enum {
    Cycle,
    WorkLimit,
    DuplicateBiome,
}
    // rust: impl std::fmt::Display for FeatureSortError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::Cycle => "feature order cycle found",
    // rust: Self::WorkLimit => "feature ordering input limit exceeded",
    // rust: Self::DuplicateBiome => "duplicate biome identity in decoration plan",
    // rust: })
}
}
    // rust: impl std::error::Error for FeatureSortError {}

// Inputs preserve biome order, step order and each holder set's encounter order.
    // rust: pub fn build_features_per_step(
    // rust: biomes: &[Vec<Vec<FeatureIdentity>>],
    // rust: ) -> Result<Vec<StepFeatureData>, FeatureSortError> {
    // rust: if biomes.len() > 8192 {
    // rust: return Err(FeatureSortError::WorkLimit);
}
    // rust: type Node = (usize, usize); // Native comparator: step, then first identity index.
    // rust: let mut identities = BTreeMap::new();
    // rust: let mut encountered = Vec::new();
    // rust: let mut graph = BTreeMap::<Node, BTreeSet<Node>>::new();
    // rust: let mut steps = 0;
    // rust: let mut remaining = 65536usize;
    // rust: for biome in biomes {
    // rust: if biome.len() > 8192 {
    // rust: return Err(FeatureSortError::WorkLimit);
}
    // rust: steps = steps.max(biome.len());
    // rust: let mut previous = None;
    // rust: for (step, features) in biome.iter().enumerate() {
    // rust: remaining = remaining
    // rust: .checked_sub(1)
    // rust: .ok_or(FeatureSortError::WorkLimit)?;
    // rust: for feature in features {
    // rust: remaining = remaining
    // rust: .checked_sub(1)
    // rust: .ok_or(FeatureSortError::WorkLimit)?;
    // rust: let index = *identities.entry(*feature).or_insert_with(|| {
    // rust: encountered.push(*feature);
    // rust: encountered.len() - 1
    // rust: });
    // rust: let node = (step, index);
    // rust: graph.entry(node).or_default();
    // rust: if let Some(previous) = previous {
    // rust: graph.entry(previous).or_default().insert(node);
}
    // rust: previous = Some(node);
}
}
}
    // rust: let mut colors = BTreeMap::<Node, u8>::new();
    // rust: let mut ordered = Vec::with_capacity(graph.len());
    // rust: let mut stack = Vec::new();
    // rust: for &root in graph.keys() {
    // rust: if colors.get(&root) == Some(&2) {
    // rust: continue;
}
    // rust: stack.push((root, false));
    // rust: while let Some((node, finish)) = stack.pop() {
    // rust: if finish {
    // rust: colors.insert(node, 2);
    // rust: ordered.push(node);
    // rust: continue;
}
    // rust: match colors.get(&node) {
    // rust: Some(2) => continue,
    // rust: Some(1) => return Err(FeatureSortError::Cycle),
    // rust: _ => {}
}
    // rust: colors.insert(node, 1);
    // rust: stack.push((node, true));
    // rust: stack.extend(graph[&node].iter().rev().map(|&next| (next, false)));
}
}
    // rust: let mut result = (0..steps)
    // rust: .map(|_| StepFeatureData {
    // rust: features: Vec::new(),
    // rust: indices: BTreeMap::new(),
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: for (step, index) in ordered.into_iter().rev() {
    // rust: let feature = encountered[index];
    // rust: let data = &mut result[step];
    // rust: data.indices.insert(feature, data.features.len());
    // rust: data.features.push(feature);
}
    // rust: Ok(result)
}
