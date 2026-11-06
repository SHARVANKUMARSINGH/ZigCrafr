//! Transpiled from Horizon Rust crate
package horizon_shader_api_check

import "core:fmt"
import "core:mem"
import "core:math"

// The check a pack passes before it runs: in the game when it loads (a pack
// that fails keeps the last good one drawing), in the launcher before it
// installs, in the registry's CI, and in `horizon-shader check`.
//
// Each stage is built as the renderer builds it, parsed and validated by
// naga, checked against its signature and the API's rules (no bindings, no
// entry points, no `horizon_` names), then translated to SPIR-V, Metal and
// HLSL with its options at their defaults, minimums and maximums.
// use crate::manifest::{OptionKind, PackOption};
// use crate::package::Pack;
// use crate::stages::{Composed, StageKind, compose};
// use naga::valid::{Capabilities, ModuleInfo, ValidationFlags, Validator};
// use std::collections::HashSet;
// use std::fmt;

// naga expressions a stage may hold, over all its functions.
MAX_EXPRESSIONS :: 20_000
// Texture reads (samples, gathers and loads) a stage may write.
MAX_TEXTURE_READS :: 64

// What is wrong, and where: a file of the pack, with the line and column
// when known (0 when not).
Problem :: struct {
    file: string,
    line: uint,
    column: uint,
    message: string,
}

    // rust: impl fmt::Display for Problem {
fmt :: proc(self: ^Self, f: ^fmt::Formatter) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.line == 0 {
    // rust: write!(f, "{}: {}", self.file, self.message)
    // rust: } else {
    // rust: write!(
    // rust: f,
    // rust: "{}:{}:{}: {}",
    // rust: self.file, self.line, self.column, self.message
    // rust: )
}
}
}

problem :: proc(file: string, message: impl Into<string>) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Problem {
    // rust: file: file.to_owned(),
    // rust: line: 0,
    // rust: column: 0,
    // rust: message: message.into(),
}
}

// One stage that passed, ready for the renderer.
CheckedStage :: struct {
    kind: StageKind,
    file: string,
    // The manifest's name for it, else its file.
    label: string,
    module: naga::Module,
    info: ModuleInfo,
    // The stage's WGSL without the entry points (the prelude, the shared
    // files, the file), for a renderer that calls the stage function from
    // its own shader (the sky).
    source: string,
    expressions: uint,
    texture_reads: uint,
}

    // rust: impl CheckedStage {
    // Whether the stage's function, or a function it calls, reads the prelude's `global`
    // (a resource of the stage, such as `reflection`).
reads :: proc(self: ^Self, global: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((function, _)) = self
    // rust: .module
    // rust: .functions
    // rust: .iter()
    // rust: .find(|(_, f)| f.name.as_deref() == Some(self.kind.function()))
    // rust: else {
    // rust: return false;
}
    // rust: self.module
    // rust: .global_variables
    // rust: .iter()
    // rust: .filter(|(_, g)| g.name.as_deref() == Some(global))
    // rust: .any(|(handle, _)| !self.info[function][handle].is_empty())
}
}

Report :: struct {
    stages: [dynamic]CheckedStage,
    // The manifest's `[sky]`.
    sky: Maybe(crate::manifest::Stage),
    // The manifest's `[reflection]`.
    reflection: Maybe(crate::manifest::Reflection),
    // The manifest's `[shadow]`.
    shadow: Maybe(crate::manifest::Shadow),
    // The manifest's `[material] fog`: whether Horizon fogs the material's colour.
    material_fog: bool,
    // The manifest's `[[textures]]`, and each image decoded, in that order.
    textures: Vec<(crate::manifest::PackTexture,
    // The manifest the stages were checked against.
    manifest: crate::manifest::Manifest,
}

Image :: struct {
    width: u32,
    height: u32,
    // RGBA, 8 bits a channel, rows from the top.
    rgba: [dynamic]u8,
}

// Decodes the PNG `bytes` into RGBA8.
decode_png :: proc(bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(bytes));
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info().map_err(|e| e.to_string())?;
    // rust: let (width, height) = (reader.info().width, reader.info().height);
    // rust: let max = crate::manifest::MAX_TEXTURE_SIZE;
    // rust: if width == 0 || height == 0 || width > max || height > max {
    // rust: return Err(format!(
    // rust: "{width}×{height}; a texture is at most {max}×{max}"
    // rust: ));
}
    // rust: let mut buffer = vec![0; reader.output_buffer_size().ok_or("too large")?];
    // rust: let frame = reader.next_frame(&mut buffer).map_err(|e| e.to_string())?;
    // rust: let data = &buffer[..frame.buffer_size()];
    // rust: let pixels = (width * height) as usize;
    // rust: let rgba = match frame.color_type {
    // rust: png::ColorType::Rgba => data.to_vec(),
    // rust: png::ColorType::Rgb => data
    // rust: .chunks(3)
    // rust: .flat_map(|c| [c[0], c[1], c[2], 255])
    // rust: .collect(),
    // rust: png::ColorType::GrayscaleAlpha => data
    // rust: .chunks(2)
    // rust: .flat_map(|c| [c[0], c[0], c[0], c[1]])
    // rust: .collect(),
    // rust: png::ColorType::Grayscale => data.iter().flat_map(|&g| [g, g, g, 255]).collect(),
    // rust: png::ColorType::Indexed => return Err("indexed colour was not expanded".into()),
}
    // rust: if rgba.len() != pixels * 4 {
    // rust: return Err("unexpected pixel data".into());
}
    // rust: Ok(Image {
    // rust: width,
    // rust: height,
    // rust: rgba,
    // rust: })
}

// Checks every stage of `pack`, and that each option is an `override` of
// its type in some stage, or one `[shadow]` sizes its map by. Returns every problem
// found, not just the first.
check :: proc(pack: ^Pack) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m = &pack.manifest;
    // rust: let stages = m
    // rust: .sky
    // rust: .iter()
    // rust: .map(|s| (StageKind::Sky, s))
    // rust: .chain(m.vertex.iter().map(|s| (StageKind::Vertex, s)))
    // rust: .chain(m.material.iter().map(|s| (StageKind::Material, s)))
    // rust: .chain(m.weather.iter().map(|s| (StageKind::Weather, s)))
    // rust: .chain(m.post.iter().map(|s| (StageKind::Post, s)))
    // rust: .chain(m.tonemap.iter().map(|s| (StageKind::Tonemap, s)));
    // rust: let (mut checked, mut problems) = (Vec::new(), Vec::new());
    // rust: for (kind, stage) in stages {
    // rust: match check_stage(pack, kind, &stage.file) {
    // rust: Ok(mut c) => {
    // rust: c.label = stage.name.clone().unwrap_or_else(|| stage.file.clone());
    // rust: checked.push(c);
}
    // rust: Err(p) => problems.extend(p),
}
}
    // The options the shadow map's size follows need no `override`: the frame has the size.
    // rust: let sizes: Vec<&String> = m
    // rust: .shadow
    // rust: .iter()
    // rust: .flat_map(|s| s.resolution_option.iter().chain(&s.distance_option))
    // rust: .collect();
    // rust: if problems.is_empty() {
    // rust: for option in m.options.iter().filter(|o| !sizes.contains(&&o.id)) {
    // rust: let used = checked.iter().any(|c| {
    // rust: c.module
    // rust: .overrides
    // rust: .iter()
    // rust: .any(|(_, o)| o.name.as_deref() == Some(&option.id))
    // rust: });
    // rust: if !used {
    // rust: problems.push(problem(
    // rust: crate::MANIFEST,
    // rust: format!(
    // rust: "option {:?}: no stage declares `override {}: {}`",
    // rust: option.id,
    // rust: option.id,
    // rust: option.kind.wgsl_type()
    // rust: ),
    // rust: ));
}
}
}
    // rust: let mut textures = Vec::new();
    // rust: for t in &m.textures {
    // rust: match decode_png(pack.source_bytes(&t.file).unwrap_or_default()) {
    // rust: Ok(image) => textures.push((t.clone(), image)),
    // rust: Err(e) => problems.push(problem(&t.file, e)),
}
}
    // rust: if problems.is_empty() {
    // rust: Ok(Report {
    // rust: sky: pack.manifest.sky.clone(),
    // rust: stages: checked,
    // rust: textures,
    // rust: reflection: m.reflection.clone(),
    // rust: shadow: m.shadow.clone(),
    // rust: material_fog: m.material.as_ref().and_then(|s| s.fog).unwrap_or(true),
    // rust: manifest: m.clone(),
    // rust: })
    // rust: } else {
    // rust: Err(problems)
}
}

// Builds and checks one stage of `pack` from its file.
check_stage :: proc(pack: ^Pack, kind: StageKind, file: string) -> R {
    // Ported from Horizon
    return {}
}
    // First without the entry points, so a missing or mistyped stage function
    // is reported as such rather than as a call that doesn't resolve.
    // rust: let mut own = compose(pack, kind, file);
    // rust: let entries = own.parts.pop().expect("entries are the last part");
    // rust: own.text.truncate(entries.1.start);
    // The material prelude's LabPBR functions call into the renderer: a stand-in here.
    // rust: if kind == StageKind::Material {
    // rust: own.text += crate::stages::PBR_STUB;
}
    // rust: let module = parse(&own)?;
    // rust: own.text.truncate(entries.1.start);
    // rust: let mut problems = signature(&module, kind, file);
    // rust: if kind == StageKind::Material && pack.manifest.displacement.is_some() {
    // rust: problems.extend(function_signature(
    // rust: &module,
    // rust: "displacement",
    // rust: &["DisplacementInput"],
    // rust: "f32",
    // rust: crate::stages::DISPLACEMENT_SIGNATURE,
    // rust: file,
    // rust: ));
}
    // rust: problems.extend(api_rules(&module, kind, &own));
    // rust: problems.extend(options(&module, &pack.manifest.options, file));
    // rust: if !problems.is_empty() {
    // rust: return Err(problems);
}
    // rust: let composed = compose(pack, kind, file);
    // rust: let module = parse(&composed)?;
    // rust: let info = Validator::new(ValidationFlags::all(), Capabilities::default())
    // rust: .validate(&module)
    // rust: .map_err(|e| {
    // rust: let at = e.spans().next().and_then(|(span, _)| span.to_range());
    // rust: let mut message = e.as_inner().to_string();
    // rust: let mut source = std::error::Error::source(e.as_inner());
    // rust: while let Some(s) = source {
    // rust: message += &format!(": {s}");
    // rust: source = s.source();
}
    // rust: vec![located(&composed, at.map(|r| r.start), message)]
    // rust: })?;
    // rust: let (expressions, texture_reads) = cost(&module);
    // rust: let mut problems = Vec::new();
    // rust: if expressions > MAX_EXPRESSIONS {
    // rust: problems.push(problem(
    // rust: file,
    // rust: format!("{expressions} expressions; a stage may hold {MAX_EXPRESSIONS}"),
    // rust: ));
}
    // rust: if texture_reads > MAX_TEXTURE_READS {
    // rust: problems.push(problem(
    // rust: file,
    // rust: format!("{texture_reads} texture reads; a stage may write {MAX_TEXTURE_READS}"),
    // rust: ));
}
    // rust: problems.extend(translate(&module, &info, &pack.manifest.options, file));
    // rust: if !problems.is_empty() {
    // rust: return Err(problems);
}
    // rust: Ok(CheckedStage {
    // rust: kind,
    // rust: file: file.to_owned(),
    // rust: label: file.to_owned(),
    // rust: module,
    // rust: info,
    // rust: source: own.text,
    // rust: expressions,
    // rust: texture_reads,
    // rust: })
}

located :: proc(composed: ^Composed, offset: Maybe(uint), message: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: match offset {
    // rust: Some(at) => {
    // rust: let (file, line, column) = composed.locate(at);
    // rust: Problem {
    // rust: file: file.to_owned(),
    // rust: line,
    // rust: column,
    // rust: message,
}
}
    // rust: None => problem(&composed.parts[composed.parts.len() - 2].0, message),
}
}

parse :: proc(composed: ^Composed) -> R {
    // Ported from Horizon
    return {}
}
    // rust: naga::front::wgsl::parse_str(&composed.text).map_err(|e| {
    // rust: let label = e.labels().next();
    // rust: let mut message = e.message().to_owned();
    // rust: if let Some((_, text)) = label.filter(|(_, t)| !t.is_empty() && !message.contains(*t)) {
    // rust: message += &format!(" ({text})");
}
    // rust: let at = label.and_then(|(span, _)| span.to_range()).map(|r| r.start);
    // rust: vec![located(composed, at, message)]
    // rust: })
}

type_name :: proc(module: ^naga::Module, ty: naga::Handle<naga::Type>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let t = &module.types[ty];
    // rust: if let Some(name) = &t.name {
    // rust: return name.clone();
}
    // rust: match t.inner {
    // rust: naga::TypeInner::Scalar(s) => scalar_name(s).to_owned(),
    // rust: naga::TypeInner::Vector { size, scalar } => {
    // rust: format!("vec{}<{}>", size as u8, scalar_name(scalar))
}
    // rust: _ => format!("{:?}", t.inner),
}
}

scalar_name :: proc(s: naga::Scalar) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (s.kind, s.width) {
    // rust: (naga::ScalarKind::Bool, _) => "bool",
    // rust: (naga::ScalarKind::Float, 4) => "f32",
    // rust: (naga::ScalarKind::Sint, 4) => "i32",
    // rust: (naga::ScalarKind::Uint, 4) => "u32",
    // rust: _ => "another scalar",
}
}

signature :: proc(module: ^naga::Module, kind: StageKind, file: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let found = module
    // rust: .functions
    // rust: .iter()
    // rust: .find(|(_, f)| f.name.as_deref() == Some(kind.function()));
    // rust: let Some((_, f)) = found else {
    // rust: return vec![problem(file, format!("defines no `{}`", kind.signature()))];
}
    // rust: let args: Vec<String> = f
    // rust: .arguments
    // rust: .iter()
    // rust: .map(|a| type_name(module, a.ty))
    // rust: .collect();
    // rust: let result = f.result.as_ref().map(|r| type_name(module, r.ty));
    // rust: if args == [kind.input().name] && result.as_deref() == Some(kind.output()) {
    // rust: return Vec::new();
}
    // rust: vec![problem(
    // rust: file,
    // rust: format!(
    // rust: "`fn {}({}) -> {}` should be `{}`",
    // rust: kind.function(),
    // rust: args.join(", "),
    // rust: result.as_deref().unwrap_or("()"),
    // rust: kind.signature()
    // rust: ),
    // rust: )]
}

// The module defines `fn <name>(<args>) -> <output>`, written out as `expected`.
    // rust: fn function_signature(
    // rust: module: &naga::Module,
    // rust: name: &str,
    // rust: args_expected: &[&str],
    // rust: output: &str,
    // rust: expected: &str,
    // rust: file: &str,
    // rust: ) -> Vec<Problem> {
    // rust: let found = module
    // rust: .functions
    // rust: .iter()
    // rust: .find(|(_, f)| f.name.as_deref() == Some(name));
    // rust: let Some((_, f)) = found else {
    // rust: return vec![problem(file, format!("defines no `{expected}`"))];
}
    // rust: let args: Vec<String> = f
    // rust: .arguments
    // rust: .iter()
    // rust: .map(|a| type_name(module, a.ty))
    // rust: .collect();
    // rust: let result = f.result.as_ref().map(|r| type_name(module, r.ty));
    // rust: if args == args_expected && result.as_deref() == Some(output) {
    // rust: return Vec::new();
}
    // rust: vec![problem(
    // rust: file,
    // rust: format!(
    // rust: "`fn {name}({}) -> {}` should be `{expected}`",
    // rust: args.join(", "),
    // rust: result.as_deref().unwrap_or("()"),
    // rust: ),
    // rust: )]
}

// The names of everything a module defines at its top level.
names :: proc(module: ^naga::Module) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let types = module.types.iter().filter_map(|(_, t)| t.name.clone());
    // rust: let functions = module.functions.iter().filter_map(|(_, f)| f.name.clone());
    // rust: let globals = module
    // rust: .global_variables
    // rust: .iter()
    // rust: .filter_map(|(_, g)| g.name.clone());
    // rust: let constants = module.constants.iter().filter_map(|(_, c)| c.name.clone());
    // rust: let overrides = module.overrides.iter().filter_map(|(_, o)| o.name.clone());
    // rust: types
    // rust: .chain(functions)
    // rust: .chain(globals)
    // rust: .chain(constants)
    // rust: .chain(overrides)
    // rust: .collect()
}

// A pack's files declare no bindings, no entry points and no `horizon_`
// names: what the prelude doesn't define is the pack's.
api_rules :: proc(module: ^naga::Module, kind: StageKind, own: ^Composed) -> V {
    // Ported from Horizon
    return {}
}
    // The prelude as composed: the stage's own, with the pack's `[[textures]]`. The material
    // prelude's LabPBR functions call into the renderer: its stand-in is ours too.
    // rust: let mut text = own.text[own.parts[0].1.clone()].to_owned();
    // rust: if kind == StageKind::Material {
    // rust: text += crate::stages::PBR_STUB;
}
    // rust: let prelude = naga::front::wgsl::parse_str(&text).expect("the prelude parses");
    // rust: let ours = names(&prelude);
    // rust: let file = &own.parts[own.parts.len() - 1].0;
    // rust: let mut problems = Vec::new();
    // rust: for e in &module.entry_points {
    // rust: problems.push(problem(
    // rust: file,
    // rust: format!(
    // rust: "declares the entry point `{}`: a stage is a function, Horizon adds the entry points",
    // rust: e.name
    // rust: ),
    // rust: ));
}
    // rust: for (_, g) in module.global_variables.iter() {
    // rust: let name = g.name.clone().unwrap_or_default();
    // rust: if g.binding.is_some() && !ours.contains(&name) {
    // rust: problems.push(problem(
    // rust: file,
    // rust: format!(
    // rust: "declares the binding `{name}`: a stage reads only the resources of its prelude"
    // rust: ),
    // rust: ));
}
}
    // rust: let mut theirs: Vec<String> = names(module)
    // rust: .into_iter()
    // rust: .filter(|n| !ours.contains(n) && n.starts_with("horizon_"))
    // rust: .collect();
    // rust: theirs.sort();
    // rust: for name in theirs {
    // rust: problems.push(problem(
    // rust: file,
    // rust: format!("`{name}`: names starting with horizon_ are Horizon's"),
    // rust: ));
}
    // rust: problems
}

// Each `override` is an option of its type, or has a default of its own.
options :: proc(module: ^naga::Module, options: ^[PackOption], file: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut problems = Vec::new();
    // rust: for (_, o) in module.overrides.iter() {
    // rust: let name = o.name.as_deref().unwrap_or("?");
    // rust: let ty = type_name(module, o.ty);
    // rust: match options.iter().find(|opt| opt.id == name) {
    // rust: Some(opt) if ty != opt.kind.wgsl_type() => problems.push(problem(
    // rust: file,
    // rust: format!(
    // rust: "`override {name}: {ty}`: option {name:?} is a {}, so its override is `{}`",
    // rust: kind_name(&opt.kind),
    // rust: opt.kind.wgsl_type()
    // rust: ),
    // rust: )),
    // rust: None if o.init.is_none() => problems.push(problem(
    // rust: file,
    // rust: format!("`override {name}` has no default and no [[options]] entry"),
    // rust: )),
    // rust: _ => {}
}
}
    // rust: problems
}

kind_name :: proc(kind: ^OptionKind) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: OptionKind::Bool { .. } => "bool",
    // rust: OptionKind::Float { .. } => "float",
    // rust: OptionKind::Int { .. } => "int",
    // rust: OptionKind::Choice { .. } => "choice",
}
}

cost :: proc(module: ^naga::Module) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let functions = module
    // rust: .functions
    // rust: .iter()
    // rust: .map(|(_, f)| f)
    // rust: .chain(module.entry_points.iter().map(|e| &e.function));
    // rust: let (mut expressions, mut reads) = (0, 0);
    // rust: for f in functions {
    // rust: expressions += f.expressions.len();
    // rust: reads += f
    // rust: .expressions
    // rust: .iter()
    // rust: .filter(|(_, e)| {
    // rust: matches!(
    // rust: e,
    // rust: naga::Expression::ImageSample { .. } | naga::Expression::ImageLoad { .. }
    // rust: )
    // rust: })
    // rust: .count();
}
    // rust: (expressions, reads)
}

// The option values a pack is translated with: its defaults, then every
// option at its minimum, then at its maximum.
option_sets :: proc(options: ^[PackOption]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let at = |pick: fn(&OptionKind) -> f64| {
    // rust: options
    // rust: .iter()
    // rust: .map(|o| (o.id.clone(), pick(&o.kind)))
    // rust: .collect()
}
    // rust: [
    // rust: ("defaults", at(OptionKind::default_constant)),
    // rust: (
    // rust: "minimums",
    // rust: at(|k| match *k {
    // rust: OptionKind::Bool { .. } | OptionKind::Choice { .. } => 0.0,
    // rust: OptionKind::Float { min, .. } => f64::from(min),
    // rust: OptionKind::Int { min, .. } => f64::from(min),
    // rust: }),
    // rust: ),
    // rust: (
    // rust: "maximums",
    // rust: at(|k| match k {
    // rust: OptionKind::Bool { .. } => 1.0,
    // rust: OptionKind::Choice { values, .. } => (values.len() - 1) as f64,
    // rust: OptionKind::Float { max, .. } => f64::from(*max),
    // rust: OptionKind::Int { max, .. } => f64::from(*max),
    // rust: }),
    // rust: ),
    // rust: ]
}

// Translates every entry point for Vulkan (SPIR-V), Metal and DirectX 12
// (HLSL) with each option set, as wgpu does when it builds the pipelines.
    // rust: fn translate(
    // rust: module: &naga::Module,
    // rust: info: &ModuleInfo,
    // rust: options: &[PackOption],
    // rust: file: &str,
    // rust: ) -> Vec<Problem> {
    // rust: let present: HashSet<&str> = module
    // rust: .overrides
    // rust: .iter()
    // rust: .filter_map(|(_, o)| o.name.as_deref())
    // rust: .collect();
    // rust: let mut problems = Vec::new();
    // rust: for (set, values) in option_sets(options) {
    // rust: let mut constants = naga::back::PipelineConstants::default();
    // rust: for (id, value) in values
    // rust: .into_iter()
    // rust: .filter(|(id, _)| present.contains(id.as_str()))
    // rust: {
    // rust: constants.insert(id, value);
}
    // rust: for e in &module.entry_points {
    // rust: let fail = |backend: &str, err: String| {
    // rust: problem(
    // rust: file,
    // rust: format!("with the options at their {set}, {backend} refuses it: {err}"),
    // rust: )
}
    // rust: let processed = naga::back::pipeline_constants::process_overrides(
    // rust: module,
    // rust: info,
    // rust: Some((e.stage, &e.name)),
    // rust: &constants,
    // rust: );
    // rust: let (m, i) = match processed {
    // rust: Ok(p) => p,
    // rust: Err(err) => {
    // rust: problems.push(fail("the override step", err.to_string()));
    // rust: return problems;
}
}
    // rust: let spv = naga::back::spv::write_vec(
    // rust: &m,
    // rust: &i,
    // rust: &naga::back::spv::Options::default(),
    // rust: Some(&naga::back::spv::PipelineOptions {
    // rust: shader_stage: e.stage,
    // rust: entry_point: e.name.clone(),
    // rust: }),
    // rust: );
    // rust: let msl = naga::back::msl::write_string(
    // rust: &m,
    // rust: &i,
    // rust: &naga::back::msl::Options {
    // rust: lang_version: (2, 2),
    // rust: ..Default::default()
    // rust: },
    // rust: &naga::back::msl::PipelineOptions {
    // rust: entry_point: Some((e.stage, e.name.clone())),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: let mut hlsl = String::new();
    // rust: let hlsl_result = naga::back::hlsl::Writer::new(
    // rust: &mut hlsl,
    // rust: &naga::back::hlsl::Options::default(),
    // rust: &naga::back::hlsl::PipelineOptions {
    // rust: entry_point: Some((e.stage, e.name.clone())),
    // rust: },
    // rust: )
    // rust: .write(&m, &i, None);
    // rust: let errors = [
    // rust: ("Vulkan (SPIR-V)", spv.err().map(|e| e.to_string())),
    // rust: ("Metal", msl.err().map(|e| e.to_string())),
    // rust: (
    // rust: "DirectX 12 (HLSL)",
    // rust: hlsl_result.err().map(|e| e.to_string()),
    // rust: ),
    // rust: ];
    // rust: for (backend, err) in errors {
    // rust: if let Some(err) = err {
    // rust: problems.push(fail(backend, err));
}
}
    // rust: if !problems.is_empty() {
    // rust: return problems;
}
}
}
    // rust: problems
}
