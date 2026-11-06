//! Transpiled from Horizon Rust crate
package horizon_world_router

import "core:fmt"
import "core:mem"
import "core:math"

// The eight terrain-router fields used by Java Edition 26.3.
// use super::{DecodeError, Object, climate::ClimateSampler, density::DensityRegistry, required};
// use horizon_core::density::{
    // rust: DensitySampler,
    // rust: graph::{CompileError, DensityCompiler, FunctionId},
}
// use std::sync::Arc;

// Declaration and compilation order: the six climate fields, surface, density.
RouterField :: enum {
    Temperature,
    Vegetation,
    Continents,
    Erosion,
    Depth,
    Ridges,
    ChunkSurfaceLevel,
    FinalDensity,
}
    // rust: impl RouterField {
    // rust: pub const ALL: [Self; 8] = [
    // rust: Self::Temperature,
    // rust: Self::Vegetation,
    // rust: Self::Continents,
    // rust: Self::Erosion,
    // rust: Self::Depth,
    // rust: Self::Ridges,
    // rust: Self::ChunkSurfaceLevel,
    // rust: Self::FinalDensity,
    // rust: ];
    // rust: pub const fn name(self) -> &'static str {
    // rust: match self {
    // rust: Self::Temperature => "temperature",
    // rust: Self::Vegetation => "vegetation",
    // rust: Self::Continents => "continents",
    // rust: Self::Erosion => "erosion",
    // rust: Self::Depth => "depth",
    // rust: Self::Ridges => "ridges",
    // rust: Self::ChunkSurfaceLevel => "chunk_surface_level",
    // rust: Self::FinalDensity => "final_density",
}
}
}

// Root IDs belong to the registry graph used to decode this router.
NoiseRouter :: struct {
    functions: [FunctionId,
}
    // rust: impl NoiseRouter {
    // Decode the router object itself. Noise settings, aquifer and material
    // configuration are separate codecs and are not parsed by this method.
    // Missing/null fields or any invalid root leave the registry unchanged.
from_json :: proc(json: string, registry: ^DensityRegistry) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let inputs = RouterField::ALL
    // rust: .iter()
    // rust: .map(|field| required(&object, field.name()).map(|raw| raw.get()))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let functions = registry
    // rust: .decode_functions(&inputs)?
    // rust: .try_into()
    // rust: .map_err(|_| DecodeError::Field("router field count"))?;
    // rust: Ok(Self { functions })
}
function :: proc(self: ^Self, field: RouterField) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.functions[field as usize]
}
    // One compiler owns the cache namespace for every router field. Existing
    // compiler samplers and cache IDs are reused rather than reset per root.
compile :: proc(self: ^Self, compiler: ^DensityCompiler) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let samplers = self
    // rust: .functions
    // rust: .iter()
    // rust: .map(|id| compiler.get_sampler(*id))
    // rust: .collect::<Result<Vec<_>, _>>()?
    // rust: .try_into()
    // rust: .expect("one sampler for each of eight router fields");
    // rust: Ok(RouterSamplers { samplers })
}
    // Compile only the six climate roots, in vanilla's sampler-binding order.
    // rust: pub fn compile_climate(
    // rust: self,
    // rust: compiler: &mut DensityCompiler,
    // rust: ) -> Result<ClimateSampler, CompileError> {
    // rust: let samplers = self.functions[..6]
    // rust: .iter()
    // rust: .map(|id| compiler.get_sampler(*id))
    // rust: .collect::<Result<Vec<_>, _>>()?
    // rust: .try_into()
    // rust: .expect("one sampler for each of six climate fields");
    // rust: Ok(ClimateSampler::new(samplers))
}
}
RouterSamplers :: struct {
    samplers: [^dyn DensitySampler,
}
    // rust: impl RouterSamplers {
get :: proc(self: ^Self, field: RouterField) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.samplers[field as usize]
}
climate_sampler :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: ClimateSampler::new(std::array::from_fn(|i| self.samplers[i].clone()))
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::density::SamplerContext;
//     use std::collections::BTreeMap;

roots_share_holder_cache_and_failed_router_leaves_graph_unchanged :: proc() {
}
    // rust: let mut registry = DensityRegistry::from_json(
    // rust: &BTreeMap::new(),
    // rust: &BTreeMap::from([(
    // rust: "minecraft:shared".into(),
    // rust: r#"{"type":"cache","input":{"type":"gradient","axis":"x","from_coordinate":0,"to_coordinate":16,"from_value":-1,"to_value":1}}"#.into(),
    // rust: )]),
    // rust: )
    // rust: .unwrap();
    // rust: let object: BTreeMap<_, _> = RouterField::ALL
    // rust: .iter()
    // rust: .map(|field| (field.name(), "minecraft:shared"))
    // rust: .collect();
    // rust: let json = serde_json::to_string(&object).unwrap();
    // rust: let expected = registry
    // rust: .graph()
    // rust: .clone()
    // rust: .insert(horizon_core::density::graph::GraphNode::Constant(123.0))
    // rust: .unwrap();
    // rust: let invalid = json
    // rust: .replace(
    // rust: "\"temperature\":\"minecraft:shared\"",
    // rust: "\"temperature\":123",
    // rust: )
    // rust: .replace(
    // rust: "\"final_density\":\"minecraft:shared\"",
    // rust: "\"final_density\":{\"type\":\"missing\"}",
    // rust: );
    // rust: assert!(NoiseRouter::from_json(&invalid, &mut registry).is_err());
    // rust: assert_eq!(registry.decode_functions(&["123"]).unwrap()[0], expected);
    // rust: let router = NoiseRouter::from_json(&json, &mut registry).unwrap();
    // rust: for field in RouterField::ALL {
    // rust: assert_eq!(
    // rust: router.function(field),
    // rust: registry.reference("minecraft:shared").unwrap()
    // rust: );
}
    // rust: let mut compiler = DensityCompiler::new_seeded(registry.into_graph(), 0, false);
    // rust: let samplers = router.compile(&mut compiler).unwrap();
    // rust: assert_eq!(compiler.cache_count(), 1);
    // rust: let mut context = SamplerContext::cached();
    // rust: for field in RouterField::ALL {
    // rust: assert_eq!(
    // rust: samplers
    // rust: .get(field)
    // rust: .sample_value(&mut context, [4, 99, -32])
    // rust: .unwrap(),
    // rust: -0.5
    // rust: );
}
}
}
