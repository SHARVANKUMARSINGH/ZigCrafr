//! Transpiled from Horizon Rust crate
package horizon_world_catalog

import "core:fmt"
import "core:mem"
import "core:math"

// Immutable resource snapshots for named state-provider holders.
// use super::{BlockStateProvider, DecodeError, StateProviderBindings, identifier};
// use serde_json::value::RawValue;
// use std::collections::BTreeMap;

StateProviderCatalog :: struct {
    resources: BTreeMap<string,
}
    // rust: impl StateProviderCatalog {
    // Store resources without evaluating unused definitions. Resolving a root
    // validates its reachable providers, including branches not sampled at run
    // time. Cycles and excessive expansion fail the shared depth/work budget.
from_resources :: proc(resources: ^BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if resources.len() > 8192 {
    // rust: return Err(DecodeError::Field("state provider resource count"));
}
    // rust: let mut result = BTreeMap::new();
    // rust: for (name, json) in resources {
    // rust: if result
    // rust: .insert(identifier(name)?, serde_json::from_str(json)?)
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate state provider resource"));
}
}
    // rust: Ok(Self { resources: result })
}
    // rust: pub(super) fn lookup(&self, name: &str) -> Option<&str> {
    // rust: self.resources.get(name).map(|v| v.get())
}
    // Decode the holder codec: an inline direct provider or a registry name.
    // rust: pub fn provider(
    // rust: &self,
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: ) -> Result<BlockStateProvider, DecodeError> {
    // rust: BlockStateProvider::decode_holder(json, bindings, 0, &mut 65536, Some(self))
}
    // rust: pub(crate) fn provider_with_budget(
    // rust: &self,
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<BlockStateProvider, DecodeError> {
    // rust: BlockStateProvider::decode_holder(json, bindings, depth, remaining, Some(self))
}
    // Decode DIRECT_CODEC while allowing nested named holder references.
    // rust: pub fn direct_provider(
    // rust: &self,
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: ) -> Result<BlockStateProvider, DecodeError> {
    // rust: BlockStateProvider::decode(json, bindings, 0, &mut 65536, Some(self))
}
    // Decode TYPED_CODEC while allowing nested named holder references.
    // rust: pub fn typed_provider(
    // rust: &self,
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: ) -> Result<BlockStateProvider, DecodeError> {
    // rust: BlockStateProvider::decode_typed(json, bindings, 0, &mut 65536, Some(self))
}
}
