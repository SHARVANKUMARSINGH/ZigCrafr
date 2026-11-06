//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_inter_stage_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Every render pipeline's stage interface against the weakest GPUs' limit (#8195).
//!
//! OpenGL 3.3 drivers (a GeForce 9100M G) allow `max_inter_stage_shader_variables` = 15, and wgpu
//! counts the fragment stage's built-in inputs (`front_facing`, `sample_index`, ...) against it.
//! A pipeline over that limit panics at start-up on such a GPU, with no way to run the game, so
//! this checks the shaders with naga, without a GPU.

// use std::path::{Path, PathBuf};

/// `Limits::downlevel_defaults().max_inter_stage_shader_variables`, the least a GPU offers.
pub const LIMIT: u32 = 15;

/// One entry point's variables: the user-defined `@location`s and the built-ins wgpu counts.
pub const Interface = struct {
    entry: []const u8,
    /// Vertex outputs or fragment inputs, user-defined.
    user: u32,
    /// The fragment stage's `front_facing`, `sample_index`, `sample_mask` and `primitive_index`
    /// inputs, which wgpu counts as one variable each; 0 for a vertex stage.
    built_ins: u32,
};

    // rust: impl Interface {
pub fn total(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.user + self.built_ins
}
}

/// The bindings an argument or a result carries, a struct's members flattened.
    // rust: fn bindings(
    // rust: module: &naga::Module,
    // rust: binding: &Option<naga::Binding>,
    // rust: ty: naga::Handle<naga::Type>,
    // rust: ) -> Vec<naga::Binding> {
    // rust: if let Some(binding) = binding {
    // rust: return vec![binding.clone()];
}
    // rust: match &module.types[ty].inner {
    // rust: naga::TypeInner::Struct { members, .. } => {
    // rust: members.iter().filter_map(|m| m.binding.clone()).collect()
}
    // rust: _ => Vec::new(),
}
}

pub fn is_location(binding: *naga::Binding) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(binding, naga::Binding::Location { .. })
}

/// The stage interface of every vertex and fragment entry point of `source`.
pub fn interfaces(source: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let module = naga::front::wgsl::parse_str(source).unwrap();
    // rust: let mut out = Vec::new();
    // rust: for entry in &module.entry_points {
    // rust: let function = &entry.function;
    // rust: let (user, built_ins) = match entry.stage {
    // rust: naga::ShaderStage::Vertex => {
    // rust: let outputs: Vec<_> = function
    // rust: .result
    // rust: .iter()
    // rust: .flat_map(|r| bindings(&module, &r.binding, r.ty))
    // rust: .collect();
    // rust: (outputs.iter().filter(|b| is_location(b)).count(), 0)
}
    // rust: naga::ShaderStage::Fragment => {
    // rust: let inputs: Vec<_> = function
    // rust: .arguments
    // rust: .iter()
    // rust: .flat_map(|a| bindings(&module, &a.binding, a.ty))
    // rust: .collect();
    // rust: let built_ins = inputs
    // rust: .iter()
    // rust: .filter(|b| {
    // rust: matches!(
    // rust: b,
    // rust: naga::Binding::BuiltIn(
    // rust: naga::BuiltIn::FrontFacing
    // rust: | naga::BuiltIn::SampleIndex
    // rust: | naga::BuiltIn::SampleMask
    // rust: | naga::BuiltIn::PrimitiveIndex
    // rust: )
    // rust: )
    // rust: })
    // rust: .count();
    // rust: (inputs.iter().filter(|b| is_location(b)).count(), built_ins)
}
    // rust: _ => continue,
}
    // rust: out.push(Interface {
    // rust: entry: entry.name.clone(),
    // rust: user: user as u32,
    // rust: built_ins: built_ins as u32,
    // rust: });
}
    // rust: out
}

/// The shaders as the renderer assembles them, by the `.wgsl` files each is made of.
pub fn composed() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entity = crate::overlay::wgsl_constants() + include_str!("../entity.wgsl");
    // rust: vec![
    // rust: ("entity", vec!["entity.wgsl"], entity.clone()),
    // rust: (
    // rust: "GPU culling occlusion test",
    // rust: vec!["gpu_culling.wgsl", "gpu_occlusion.wgsl"],
    // rust: include_str!("gpu_culling.wgsl").to_owned() + include_str!("gpu_occlusion.wgsl"),
    // rust: ),
    // rust: (
    // rust: "static entity",
    // rust: vec!["entity.wgsl", "static_entity.wgsl"],
    // rust: entity.clone() + include_str!("../static_entity.wgsl"),
    // rust: ),
    // rust: (
    // rust: "improved transparency clouds",
    // rust: vec!["entity.wgsl", "oit.wgsl", "oit_clouds.wgsl"],
    // rust: entity.clone() + include_str!("../oit.wgsl") + include_str!("../oit_clouds.wgsl"),
    // rust: ),
    // rust: (
    // rust: "improved transparency features",
    // rust: vec!["entity.wgsl", "oit.wgsl", "oit_features.wgsl"],
    // rust: entity + include_str!("../oit.wgsl") + include_str!("../oit_features.wgsl"),
    // rust: ),
    // rust: (
    // rust: "improved transparency world",
    // rust: vec!["terrain.wgsl", "oit.wgsl", "oit_world.wgsl"],
    // rust: include_str!("../terrain.wgsl").to_owned()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_world.wgsl"),
    // rust: ),
    // rust: (
    // rust: "visibility buffer",
    // rust: vec!["terrain.wgsl", "visbuffer.wgsl"],
    // rust: include_str!("../terrain.wgsl").to_owned() + include_str!("../visbuffer.wgsl"),
    // rust: ),
    // rust: (
    // rust: "improved transparency world border",
    // rust: vec!["border.wgsl", "oit.wgsl", "oit_border.wgsl"],
    // rust: include_str!("../border.wgsl").to_owned()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_border.wgsl"),
    // rust: ),
    // rust: ]
}

pub fn wgsl_files(dir: *Path, out: *mut std.ArrayList(PathBuf)) void {
}
    // rust: for entry in std::fs::read_dir(dir).unwrap().flatten() {
    // rust: let path = entry.path();
    // rust: if path.is_dir() {
    // rust: wgsl_files(&path, out);
    // rust: } else if path.extension().is_some_and(|e| e == "wgsl") {
    // rust: out.push(path);
}
}
}

/// Every shader: the assembled ones, and each `.wgsl` file that stands alone. A file that does
/// not (it needs another's declarations) must be part of an assembled one, so that a new shader
/// cannot slip past the audit.
pub fn audited() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let composed = composed();
    // rust: let mut files = Vec::new();
    // rust: wgsl_files(
    // rust: &Path::new(env!("CARGO_MANIFEST_DIR")).join("src"),
    // rust: &mut files,
    // rust: );
    // rust: files.sort();
    // rust: let mut out: Vec<(String, Vec<Interface>)> = composed
    // rust: .iter()
    // rust: .map(|(name, _, source)| ((*name).to_owned(), interfaces(source)))
    // rust: .collect();
    // rust: for file in files {
    // rust: let name = file.file_name().unwrap().to_string_lossy().into_owned();
    // rust: let source = std::fs::read_to_string(&file).unwrap();
    // rust: let alone = naga::front::wgsl::parse_str(&source).is_ok();
    // rust: let part = composed.iter().any(|(_, parts, _)| parts.contains(&&*name));
    // rust: assert!(
    // rust: alone || part,
    // rust: "{name} needs other files' declarations: add its assembly to `composed`"
    // rust: );
    // rust: if alone {
    // rust: out.push((name, interfaces(&source)));
}
}
    // rust: out
}

pub fn no_pipeline_exceeds_the_weakest_gpus_inter_stage_limit() void {
}
    // rust: let mut over = Vec::new();
    // rust: for (shader, entries) in audited() {
    // rust: for e in entries {
    // rust: if e.total() > LIMIT {
    // rust: over.push(format!(
    // rust: "{shader}::{}: {} user-defined + {} built-in = {} > {LIMIT}",
    // rust: e.entry,
    // rust: e.user,
    // rust: e.built_ins,
    // rust: e.total()
    // rust: ));
}
}
}
    // rust: assert!(over.is_empty(), "over the limit:\n{}", over.join("\n"));
}

/// The audit counts what wgpu counts (the failure of #8195: 15 user-defined + `FrontFacing`).
pub fn a_front_facing_input_counts_against_the_limit() void {
}
    // rust: let source = "struct Io { @builtin(position) p: vec4<f32>, @location(0) a: vec4<f32>, @location(1) b: f32 }
    // rust: @vertex fn vs() -> Io { return Io(vec4<f32>(0.0), vec4<f32>(0.0), 0.0); }
    // rust: @fragment fn fs(in: Io, @builtin(front_facing) f: bool) -> @location(0) vec4<f32> { return in.a; }";
    // rust: assert_eq!(
    // rust: interfaces(source),
    // rust: vec![
    // rust: Interface {
    // rust: entry: "vs".into(),
    // rust: user: 2,
    // rust: built_ins: 0
    // rust: },
    // rust: Interface {
    // rust: entry: "fs".into(),
    // rust: user: 2,
    // rust: built_ins: 1
    // rust: },
    // rust: ]
    // rust: );
}
