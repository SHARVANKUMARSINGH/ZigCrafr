//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_models
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A blockstate-driven inspection gallery, separate from gameplay simulation.
    // rust: pub mod catalog;
    // rust: mod cube;
// use crate::{Result, sprites::Sprites};
    // rust: pub use catalog::StateModels;
// use catalog::descriptor;
    // rust: pub use cube::CubeStyle;
// use horizon_core::position::BlockPos;
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use serde_json::{Value, json};
// use std::path::Path;

/// The standalone models native mods asked for (`native_standalone_models`).
pub const STANDALONE: std::sync::OnceLock<std.ArrayList([]const u8)> = std::sync::OnceLock::new();

/// Sets the models no blockstate names that every resource load bakes
/// beside the block models ([`StateModels::standalone`]): once, at start,
/// as vanilla's `ModelEvent.RegisterStandalone` is posted once per model
/// discovery. Names are sorted and deduplicated; one without a namespace
/// (`mymod:block/shaft_half`) is dropped. False when already set.
pub fn register_standalone(mut names: std.ArrayList([]const u8)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: names.retain(|n| {
    // rust: n.split_once(':')
    // rust: .is_some_and(|(ns, path)| !ns.is_empty() && !path.is_empty())
    // rust: });
    // rust: names.sort();
    // rust: names.dedup();
    // rust: STANDALONE.set(names).is_ok()
}

/// What [`register_standalone`] set; none before.
pub fn standalone() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: STANDALONE.get().map_or(&[], Vec::as_slice)
}

    // rust: type Placement = (&'static str, &'static [(&'static str, &'static str)]);
    // rust: const GALLERY: [Placement; 16] = [
    // rust: (
    // rust: "oak_stairs",
    // rust: &[
    // rust: ("facing", "north"),
    // rust: ("half", "top"),
    // rust: ("shape", "inner_left"),
    // rust: ],
    // rust: ),
    // rust: ("stone_slab", &[("type", "top")]),
    // rust: ("anvil", &[("facing", "east")]),
    // rust: ("torch", &[]),
    // rust: ("lantern", &[]),
    // rust: ("oak_fence", &[("north", "true"), ("east", "true")]),
    // rust: ("oak_fence_gate", &[("facing", "west"), ("open", "true")]),
    // rust: ("iron_bars", &[("north", "true"), ("south", "true")]),
    // rust: ("cobweb", &[]),
    // rust: ("grindstone", &[("face", "wall"), ("facing", "west")]),
    // rust: ("ladder", &[("facing", "west")]),
    // rust: ("amethyst_cluster", &[("facing", "east")]),
    // rust: ("stone", &[]),
    // rust: ("stone", &[]),
    // rust: ("stone", &[]),
    // rust: ("stone", &[]),
    // rust: ];

pub const ModelInstance = struct {
    positions: [[f32,
    uv: [[f32,
    layer: u32,
    shade: f32,
};
pub const PreparedModels = struct {
    catalog: StateModels,
    placements: Vec<(BlockPos,
    states: std.ArrayList(Value),
};
    // rust: pub fn prepare(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: sprites: &mut Sprites,
    // rust: ) -> Result<PreparedModels> {
    // rust: prepare_with_models(
    // rust: root,
    // rust: registry,
    // rust: sprites,
    // rust: &crate::model_library::ParsedModels::default(),
    // rust: )
}
    // rust: pub(crate) fn prepare_with_models(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: sprites: &mut Sprites,
    // rust: models: &crate::model_library::ParsedModels,
    // rust: ) -> Result<PreparedModels> {
    // rust: let facts: std::collections::BTreeMap<String, Value> =
    // rust: horizon_world::json_file::read(&root.join("model-states.json"))?;
    // rust: let blocks: Vec<&str> = facts
    // rust: .keys()
    // rust: .filter(|name| registry.default_state(name).is_some())
    // rust: .map(|name| name.strip_prefix("minecraft:").unwrap_or(name))
    // rust: .collect();
    // rust: let mut catalog = {
    // rust: let _step = crate::spans::startup::step("core.bake_states");
    // rust: StateModels::from_facts_with_models(root, registry, &blocks, sprites, &facts, models)?
}
    // rust: {
    // rust: let _step = crate::spans::startup::step("core.bake_standalone");
    // rust: catalog.bake_standalone(root, sprites, models, standalone())?;
}
    // rust: let mut placements = Vec::new();
    // rust: let mut states = Vec::new();
    // rust: for (index, (name, properties)) in GALLERY.iter().enumerate() {
    // rust: let state = registry.resolve(&descriptor(name, properties))?;
    // rust: let actual = registry
    // rust: .state(state)
    // rust: .ok_or("missing gallery registry state")?;
    // rust: let position = BlockPos::new((index % 4) as i32 * 4 - 7, 4, (index / 4) as i32 * 4 + 14);
        // A state no definition binds (a pack's partial blockstate file
        // without vanilla's below it) is left out, as the mesher skips it,
        // instead of failing the whole pack.
    // rust: let selected = match catalog.collect(state, position) {
    // rust: Ok(selected) => selected,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: gallery block {name} has no model: {e}");
    // rust: continue;
}
}
    // rust: states.push(json!({"block":actual.name,"properties":actual.properties,"state_id":state.0,
    // rust: "position":[position.x,position.y,position.z],
    // rust: "models":selected.iter().map(|(v,_)| json!({"model":v.model,"rotations":v.rotations,"uv_lock":v.uv_lock})).collect::<Vec<_>>()}));
    // rust: placements.push((position, state));
}
    // rust: Ok(PreparedModels {
    // rust: catalog,
    // rust: placements,
    // rust: states,
    // rust: })
}
pub fn instance(face: *catalog::BakedFace, position: BlockPos) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let origin = [position.x as f32, position.y as f32, position.z as f32];
    // rust: ModelInstance {
    // rust: positions: face
    // rust: .quad
    // rust: .positions
    // rust: .map(|v| std::array::from_fn(|i| v[i] + origin[i])),
    // rust: uv: face.quad.uv,
    // rust: layer: face.layer,
    // rust: shade: cube::shade(face),
}
}

    // rust: pub fn load_visibility(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: ) -> Result<horizon_world::block_render::FaceVisibility> {
//     use horizon_world::{
    // rust: block_render::{FaceVisibility, RenderDefinition, SkipRendering},
    // rust: collision::CachedCollisionRegistry,
    // rust: registry::BlockTableFile,
}
//     use std::collections::BTreeMap;
    // rust: let file = BlockTableFile::open(&root.join("occlusion.nbt"), registry)?;
    // rust: let occlusion = CachedCollisionRegistry::from_table(file.table("occlusion")?)?;
    // rust: let raw: BTreeMap<String, Value> =
    // rust: horizon_world::json_file::read(&root.join("render-definitions.json"))?;
    // rust: let definitions = raw
    // rust: .into_iter()
    // rust: .map(|(name, v)| {
    // rust: let skip = match v["rule"].as_str().ok_or("missing render rule")? {
    // rust: "never" => SkipRendering::Never,
    // rust: "same_block" => SkipRendering::SameBlock,
    // rust: "bars" => SkipRendering::Bars,
    // rust: "leaves" => SkipRendering::Leaves,
    // rust: "liquid" => SkipRendering::Liquid,
    // rust: "mangrove_roots" => SkipRendering::MangroveRoots,
    // rust: _ => return Err("unrecognized render rule"),
}
    // rust: Ok((
    // rust: name,
    // rust: RenderDefinition {
    // rust: skip,
    // rust: can_occlude: v["can_occlude"].as_bool().ok_or("missing occlusion flag")?,
    // rust: bars_tag: v["bars_tag"].as_bool().ok_or("missing bars tag")?,
    // rust: },
    // rust: ))
    // rust: })
    // rust: .collect::<std::result::Result<_, &str>>()?;
    // rust: Ok(FaceVisibility::new(&occlusion, &definitions)?)
}

    // rust: mod tests {
pub fn standalone_names_are_namespaced_sorted_and_set_once() void {
}
    // rust: assert!(super::standalone().is_empty());
    // rust: let names = [
    // rust: "lanef:block/b",
    // rust: "nonamespace",
    // rust: ":x",
    // rust: "lanef:",
    // rust: "lanef:block/a",
    // rust: "lanef:block/b",
    // rust: ];
    // rust: assert!(super::register_standalone(names.map(str::to_owned).into()));
    // rust: assert_eq!(super::standalone(), ["lanef:block/a", "lanef:block/b"]);
    // rust: assert!(!super::register_standalone(vec!["other:block/c".into()]));
    // rust: assert_eq!(super::standalone(), ["lanef:block/a", "lanef:block/b"]);
}
}
