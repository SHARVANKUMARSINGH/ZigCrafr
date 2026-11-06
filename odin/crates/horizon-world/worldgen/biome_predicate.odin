//! Transpiled from Horizon Rust crate
package horizon_world_biome_predicate

import "core:fmt"
import "core:mem"
import "core:math"

// Immutable biome identities and resolved holder sets for world predicates.
// use super::{DecodeError, biome::BiomeId, density::identifier};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}
BiomePredicateBindings :: struct {
    names: BTreeMap<string,
    tags: BTreeMap<string,
}
    // rust: impl BiomePredicateBindings {
    // IDs must belong to the same registry snapshot as the world's biome query.
    // rust: pub fn new(
    // rust: names: &BTreeMap<String, BiomeId>,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if names.len() > 8192 || tags.len() > 8192 {
    // rust: return Err(DecodeError::Field("predicate biome registry size"));
}
    // rust: let mut canonical = BTreeMap::new();
    // rust: let mut ids = BTreeSet::new();
    // rust: for (name, id) in names {
    // rust: if canonical.insert(identifier(name)?, *id).is_some() || !ids.insert(*id) {
    // rust: return Err(DecodeError::Field("duplicate predicate biome identity"));
}
}
    // rust: let mut bound_tags = BTreeMap::new();
    // rust: for (name, entries) in tags {
    // rust: if entries.len() > 8192 {
    // rust: return Err(DecodeError::Field("predicate biome tag size"));
}
    // rust: let values = entries
    // rust: .iter()
    // rust: .map(|entry| {
    // rust: canonical
    // rust: .get(&identifier(entry)?)
    // rust: .copied()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown biome {entry}")))
    // rust: })
    // rust: .collect::<Result<BTreeSet<_>, _>>()?;
    // rust: if bound_tags
    // rust: .insert(super::tags::identifier(name)?, Arc::new(values))
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate predicate biome tag"));
}
}
    // rust: Ok(Self {
    // rust: names: canonical,
    // rust: tags: bound_tags,
    // rust: })
}
resolve :: proc(self: ^Self, json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Ok(name) = serde_json::from_str::<String>(json) {
    // rust: if let Some(tag) = name.strip_prefix('#') {
    // rust: return self
    // rust: .tags
    // rust: .get(&super::tags::identifier(tag)?)
    // rust: .cloned()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown biome tag {tag}")));
}
    // rust: return Ok(Arc::new(BTreeSet::from([self.biome(&name)?])));
}
    // rust: let names: Vec<String> = serde_json::from_str(json)?;
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("predicate biome holder list"));
}
    // rust: Ok(Arc::new(
    // rust: names
    // rust: .iter()
    // rust: .map(|name| self.biome(name))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ))
}
biome :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.names
    // rust: .get(&identifier(name)?)
    // rust: .copied()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown biome {name}")))
}
}
