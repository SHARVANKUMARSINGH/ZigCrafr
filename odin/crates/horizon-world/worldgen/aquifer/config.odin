//! Transpiled from Horizon Rust crate
package horizon_world_config

import "core:fmt"
import "core:mem"
import "core:math"

// The six density roots in the 26.3 aquifer configuration.
// use super::super::{DecodeError, Object, density::DensityRegistry, required};
// use horizon_core::density::{
    // rust: DensitySampler,
    // rust: graph::{CompileError, DensityCompiler, FunctionId},
}
// use std::sync::Arc;

AquiferField :: enum {
    Barrier,
    Floodedness,
    Spread,
    Lava,
    Exclusion,
    SurfaceLevel,
}
    // rust: impl AquiferField {
    // rust: pub const ALL: [Self; 6] = [
    // rust: Self::Barrier,
    // rust: Self::Floodedness,
    // rust: Self::Spread,
    // rust: Self::Lava,
    // rust: Self::Exclusion,
    // rust: Self::SurfaceLevel,
    // rust: ];
    // rust: pub const fn name(self) -> &'static str {
    // rust: match self {
    // rust: Self::Barrier => "barrier",
    // rust: Self::Floodedness => "fluid_level_floodedness",
    // rust: Self::Spread => "fluid_level_spread",
    // rust: Self::Lava => "lava",
    // rust: Self::Exclusion => "exclusion",
    // rust: Self::SurfaceLevel => "surface_level",
}
}
}
AquiferConfig :: struct {
    functions: [FunctionId,
}
    // rust: impl AquiferConfig {
    // Decode all roots atomically into the caller's registry graph.
from_json :: proc(json: string, registry: ^DensityRegistry) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let inputs = AquiferField::ALL
    // rust: .iter()
    // rust: .map(|f| required(&object, f.name()).map(|v| v.get()))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let functions = registry
    // rust: .decode_functions(&inputs)?
    // rust: .try_into()
    // rust: .map_err(|_| DecodeError::Field("aquifer field count"))?;
    // rust: Ok(Self { functions })
}
function :: proc(self: ^Self, field: AquiferField) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.functions[field as usize]
}
    // Preserve vanilla's binding order and the shared compiler cache namespace.
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
    // rust: .expect("six aquifer roots");
    // rust: Ok(AquiferSamplers { samplers })
}
}
AquiferSamplers :: struct {
    samplers: [^dyn DensitySampler,
}
    // rust: impl AquiferSamplers {
    // Bind already compiled roots in AquiferField::ALL order.
new :: proc(samplers: [^dyn DensitySampler; 6]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { samplers }
}
get :: proc(self: ^Self, field: AquiferField) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.samplers[field as usize]
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::density::{SamplerContext, graph::GraphNode};
//     use std::collections::BTreeMap;
bindings_share_named_cache_and_failed_decode_is_atomic :: proc() {
}
    // rust: let mut registry = DensityRegistry::from_json(&BTreeMap::new(), &BTreeMap::from([("minecraft:shared".into(), r#"{"type":"cache","input":{"type":"gradient","axis":"x","from_coordinate":0,"to_coordinate":16,"from_value":0,"to_value":1}}"#.into())])).unwrap();
    // rust: let roots: BTreeMap<_, _> = AquiferField::ALL
    // rust: .iter()
    // rust: .map(|f| (f.name(), "minecraft:shared"))
    // rust: .collect();
    // rust: let json = serde_json::to_string(&roots).unwrap();
    // rust: let expected = registry
    // rust: .graph()
    // rust: .clone()
    // rust: .insert(GraphNode::Constant(123.))
    // rust: .unwrap();
    // rust: let invalid = json
    // rust: .replace("\"barrier\":\"minecraft:shared\"", "\"barrier\":123")
    // rust: .replace(
    // rust: "\"surface_level\":\"minecraft:shared\"",
    // rust: "\"surface_level\":{}",
    // rust: );
    // rust: assert!(AquiferConfig::from_json(&invalid, &mut registry).is_err());
    // rust: assert_eq!(registry.decode_functions(&["123"]).unwrap()[0], expected);
    // rust: let config = AquiferConfig::from_json(&json, &mut registry).unwrap();
    // rust: let mut compiler = DensityCompiler::new_seeded(registry.into_graph(), 0, false);
    // rust: let samplers = config.compile(&mut compiler).unwrap();
    // rust: assert_eq!(compiler.cache_count(), 1);
    // rust: let mut context = SamplerContext::cached();
    // rust: for field in AquiferField::ALL {
    // rust: assert_eq!(
    // rust: samplers
    // rust: .get(field)
    // rust: .sample_value(&mut context, [4, -54, 0])
    // rust: .unwrap(),
    // rust: 0.25
    // rust: );
}
}
}
