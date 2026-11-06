//! Transpiled from Horizon Rust crate
package horizon_shaders_mod

import "core:fmt"
import "core:mem"
import "core:math"

// A program's preprocessed GLSL (any version from 110 to 460, compatibility or core) turned
// into the Vulkan-flavoured GLSL 450 naga reads, then into validated naga modules (spec 1.6,
// 2.2). The rewrite works on preprocessing tokens and never adds or removes a line of the pack's
// code, so naga's line numbers map back through the preprocessor to the pack's files.
//
// What it does:
// - Loose uniforms go into one uniform block shared by both stages (`bool` stored as `int`).
// - Each sampler is split into a texture and a sampler object, combined again where it is used
//   (`sampler2D(t, s)`), or passed as two arguments to the pack's own functions.
// - The compatibility built-ins (`gl_Vertex`, `gl_MultiTexCoordN`, `gl_*Matrix`, `ftransform()`,
//   `gl_FragData`, `gl_FragColor`, `gl_TexCoord`, `texture2D`...) become declarations of ours,
//   named with the reserved prefix `hz_`; varyings get locations by name across the stages.
// - The pack's `main` becomes `hz_main`, called by a `main` of ours that sets the inputs and
//   adapts GL's conventions (spec 5.5): clip y is negated for every target but the window, so
//   memory rows are GL's rows and `gl_FragCoord` needs no change, and clip z goes from GL's
//   [-w, w] to [0, w], so stored depth is GL's window depth.
//
// Composite-style programs draw one quad from (0,0) to (1,1) with an identity model-view and an
// orthographic projection onto it, the texture coordinate equal to the position (OQ-6).

// use std::collections::BTreeMap;
// use std::fmt::Write;

// use naga::ShaderStage;
// use naga::front::glsl::{Frontend, Options};
// use naga::valid::{Capabilities, ValidationFlags, Validator};

// use crate::Preprocessed;

    // rust: mod anonymous_structs;
    // rust: mod array_constructors;
    // rust: mod atomic_vectors;
    // rust: mod buffer_bools;
    // rust: mod defaults;
    // rust: mod geometry;
    // rust: mod image_parameters;
    // rust: mod integer_bounds;
    // rust: mod interface_blocks;
    // rust: mod ordering;
    // rust: mod rewrite;
    // rust: mod scan;

    // rust: pub use geometry::{GeometryInputs, translate_geometry};

// use scan::Stage;

// What a program's stages need from the game.
Interface :: struct {
    // The uniform block at binding 0: its size and each value's name, GLSL type and offset.
    // Ours come first: `hz_target` (the target's width, height, 1/width, 1/height), and the
    // fixed-function fog the compatibility `gl_Fog` reads (OQ-28): `hz_fog_color` (vanilla's fog
    // colour) and `hz_fog` (density, start, end, 1 / (end - start)), then `hz_depth_linear`:
    // 1 where `shadowtex0`, `shadowtex1`, `shadow` and `watershadow` (x to w) read through a
    // plain sampler filter linearly, 0 where they take the nearest texel.
    uniform_size: u32,
    uniforms: [dynamic]Uniform,
    // std140 initial contents; runtime values overwrite their members each frame.
    initial_values: [dynamic]u8,
    // Each sampler: texture at `binding`, sampler object at `binding + 1`.
    samplers: [dynamic]Sampler,
    // The fragment stage's output locations.
    outputs: [dynamic]u32,
    // A gbuffers program reads `DRAW_UNIFORMS`: the block at set 2, binding 0, set per draw.
    draw: bool,
    // Storage images (`colorimg4`...), after the samplers.
    images: [dynamic]Image,
    // The SSBOs' bindings in set 4 (`bufferObject.<n>`).
    buffers: [dynamic]u32,
}

Image :: struct {
    name: string,
    // `image2D`, `uimage3D`...
    ty: string,
    // The format qualifier (`rgba16f`).
    format: string,
    // `readonly`, `writeonly`, empty for both, or `atomic` for an image an atomic function
    // uses.
    access: string,
    binding: u32,
    // A compute program's copy of image `before` as it was before the dispatch, which its
    // loads read (see `ordering`).
    before: Maybe(string),
}

// A compute program (`deferred4_a.csh`): its module, what it reads and writes, and how many
// work groups it runs: `workGroups`, or `workGroupsRender` times the target's size over the
// local size (1, 1 when neither is set).
ComputeProgram :: struct {
    module: naga::Module,
    interface: Interface,
    // Non-fatal translation diagnostics, located in the authored source.
    notes: [dynamic]Error,
    work_groups: Option<[u32,
    work_groups_render: [f32,
}

// The uniforms a gbuffers program reads per draw (5.3's "D"), in a block of their own
// (`HzDraw`, std140: four ints, a vec4; 32 bytes) the game sets for each draw.
    // rust: pub const DRAW_UNIFORMS: [(&str, &str); 5] = [
    // rust: ("renderStage", "int"),
    // rust: ("entityId", "int"),
    // rust: ("blockEntityId", "int"),
    // rust: ("currentRenderedItemId", "int"),
    // rust: ("entityColor", "vec4"),
    // rust: ];

Uniform :: struct {
    name: string,
    // The type the pack declared (`float`, `ivec2`, `mat4`; `bool` is stored as an `int`).
    ty: string,
    offset: u32,
}

Sampler :: struct {
    name: string,
    // The type the pack declared: `sampler2D`, `sampler2DShadow`, `usampler2D`, `sampler3D`...
    ty: string,
    binding: u32,
}

// A translation diagnostic at a pack file and line.
Error :: struct {
    file: string,
    line: u32,
    message: string,
}

Program :: struct {
    vertex: naga::Module,
    fragment: naga::Module,
    interface: Interface,
    // Non-fatal translation diagnostics, located in the authored source.
    notes: [dynamic]Error,
}

// Where the program draws, which decides the conventions of 5.5.
Target :: enum {
    // Pack buffers: rows stored as GL stores them.
    Buffers,
    // The window (`final`).
    Window,
}

// What a gbuffers-style program's vertex stage reads. The game writes it: it knows its vertex
// formats, the translator only places it.
GbuffersInputs :: struct {
    // GLSL declarations: the vertex inputs and any bindings of set 1.
    declarations: string,
    // GLSL statements that set `hz_Vertex`, `hz_Color`, `hz_MultiTexCoord0`,
    // `hz_MultiTexCoord1` and `hz_Normal` (the compatibility inputs), run first in `main`.
    body: string,
    // The value of each attribute a pack may declare (`mc_Entity`, `vaPosition`...), as a GLSL
    // expression of the declared type's size; an attribute not listed reads zero. Terrain
    // also supplies `mc_chunkFade`, an implicit float input rather than a declared attribute.
    attributes: Vec<(string,
    // GLSL statements run last in `main`, with `gl_Position` in wgpu's clip space.
    after: string,
    // The alpha test applied to output 0 (`gl_FragData[0]`, `gl_FragColor`), the loader's
    // (3.2 `alphaTest.<program>`): `None` keeps every fragment.
    alpha_test: Maybe(AlphaTest),
    // The program may read `currentRenderedItemId` without declaring it, as Iris 1.11.7
    // lets the hand's (observed with probe packs; terrain's may not).
    item_id_declared: bool,
    // The depth test sees the far plane (window depth 1) unless the program writes
    // `gl_FragDepth`, while `gl_FragCoord.z` stays the geometry's own: the sky shows only where
    // nothing else drew, and reads its own depth as in Iris 1.11.7.
    far_depth: bool,
}

// A fragment stays when its output 0's alpha compares to `reference` as `op` says (a GLSL
// comparison operator, `true` for GL's `ALWAYS`, `false` for `NEVER`).
AlphaTest :: struct {
    op: ^'static str,
    reference: f32,
}

    // rust: impl AlphaTest {
    // `alphaTest.<program>`'s value: `off`, or a GL comparison and a reference.
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut words = value.split_whitespace();
    // rust: let func = words.next()?;
    // rust: if func == "off" {
    // rust: return Some(None);
}
    // rust: let op = match func.trim_start_matches("GL_") {
    // rust: "NEVER" => "false",
    // rust: "LESS" => "<",
    // rust: "EQUAL" => "==",
    // rust: "LEQUAL" => "<=",
    // rust: "GREATER" => ">",
    // rust: "NOTEQUAL" => "!=",
    // rust: "GEQUAL" => ">=",
    // rust: "ALWAYS" => return Some(None),
    // rust: _ => return None,
}
    // rust: let reference = words.next()?.parse().ok()?;
    // rust: Some(Some(Self { op, reference }))
}
}

// Translates a composite-style program (`composite`, `deferred`, `final`...).
    // rust: pub fn translate_composite(
    // rust: vertex: &Preprocessed,
    // rust: fragment: &Preprocessed,
    // rust: target: Target,
    // rust: ) -> Result<Program, Vec<Error>> {
    // rust: translate(vertex, fragment, target, None, false)
}

// Translates a gbuffers-style program (`gbuffers_terrain`...) drawing the game's geometry
// described by `inputs`, into `target` (the pack's buffers).
    // rust: pub fn translate_gbuffers(
    // rust: vertex: &Preprocessed,
    // rust: fragment: &Preprocessed,
    // rust: target: Target,
    // rust: inputs: &GbuffersInputs,
    // rust: ) -> Result<Program, Vec<Error>> {
    // rust: translate(vertex, fragment, target, Some(inputs), false)
}

// Translates a shadow program (`shadow`, `shadow_water`...) drawing the game's geometry
// described by `inputs` from the shadow light: its model-view and projection matrices are the
// shadow camera's (5.2).
    // rust: pub fn translate_shadow(
    // rust: vertex: &Preprocessed,
    // rust: fragment: &Preprocessed,
    // rust: inputs: &GbuffersInputs,
    // rust: ) -> Result<Program, Vec<Error>> {
    // rust: translate(vertex, fragment, Target::Buffers, Some(inputs), true)
}

// The matrices of the compatibility profile in a gbuffers-style program, from the frame's.
GBUFFERS_MATRICES :: "    hz_ModelViewMatrix = gbufferModelView
    // rust: hz_ProjectionMatrix = gbufferProjection;\n    \
    // rust: hz_ModelViewProjectionMatrix = gbufferProjection * gbufferModelView;\n    \
    // rust: hz_ModelViewMatrixInverse = gbufferModelViewInverse;\n    \
    // rust: hz_ProjectionMatrixInverse = gbufferProjectionInverse;\n    \
    // rust: hz_NormalMatrix = mat3(gbufferModelView);\n    \
    // rust: mat4 hz_light = mat4(vec4(1.0 / 256.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0 / 256.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(1.0 / 32.0, 1.0 / 32.0, 0.0, 1.0));\n    \
    // rust: hz_TextureMatrix = mat4[8](mat4(1.0), hz_light, hz_light, mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0));\n";

// Whether `code` names `name` (a whole identifier).
uses_name :: proc(code: string, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let ident = |c: char| c.is_ascii_alphanumeric() || c == '_';
    // rust: code.match_indices(name)
    // rust: .any(|(at, _)| !code[..at].ends_with(ident) && !code[at + name.len()..].starts_with(ident))
}

    // rust: fn translate(
    // rust: vertex: &Preprocessed,
    // rust: fragment: &Preprocessed,
    // rust: target: Target,
    // rust: gbuffers: Option<&GbuffersInputs>,
    // rust: shadow: bool,
    // rust: ) -> Result<Program, Vec<Error>> {
    // rust: let matrices = if shadow {
    // rust: GBUFFERS_MATRICES.replace("gbuffer", "shadow")
    // rust: } else {
    // rust: GBUFFERS_MATRICES.to_owned()
}
    // Struct types without a name get one (`anonymous_structs`), interface blocks travel
    // as plain varyings (`interface_blocks`), and buffer vectors that atomic functions use by
    // component become arrays (`atomic_vectors`).
    // rust: let flat = |pp: &Preprocessed| {
    // rust: let named = anonymous_structs::name(&pp.code);
    // rust: let code = named.as_deref().unwrap_or(&pp.code);
    // rust: let flat = interface_blocks::flatten(code)
    // rust: .or(named)
    // rust: .map(|code| Preprocessed { code, ..pp.clone() });
    // rust: let split = atomic_vectors::rewrite(flat.as_ref().unwrap_or(pp));
    // rust: split.or(flat)
}
    // rust: let (vertex_flat, fragment_flat) = (flat(vertex), flat(fragment));
    // rust: let vertex = vertex_flat.as_ref().unwrap_or(vertex);
    // rust: let fragment = fragment_flat.as_ref().unwrap_or(fragment);
    // A `bool` member of a storage buffer travels as a `uint` (`buffer_bools`).
    // rust: let ((vertex_bools, vertex_bool_errors), (fragment_bools, fragment_bool_errors)) = (
    // rust: buffer_bools::rewrite(vertex),
    // rust: buffer_bools::rewrite(fragment),
    // rust: );
    // rust: let vertex = vertex_bools.as_ref().unwrap_or(vertex);
    // rust: let fragment = fragment_bools.as_ref().unwrap_or(fragment);
    // rust: let mut v = Stage::scan(vertex, ShaderStage::Vertex);
    // rust: let mut f = Stage::scan(fragment, ShaderStage::Fragment);
    // rust: v.gbuffers = gbuffers.is_some();
    // rust: f.gbuffers = gbuffers.is_some();
    // rust: let mut errors: Vec<Error> = v
    // rust: .errors
    // rust: .drain(..)
    // rust: .chain(f.errors.drain(..))
    // rust: .chain(vertex_bool_errors)
    // rust: .chain(fragment_bool_errors)
    // rust: .collect();

    // One uniform block and one set of samplers for both stages.
    // rust: let mut uniforms: BTreeMap<String, String> = BTreeMap::new();
    // rust: if gbuffers.is_some() {
    // rust: for name in [
    // rust: "gbufferModelView",
    // rust: "gbufferModelViewInverse",
    // rust: "gbufferProjection",
    // rust: "gbufferProjectionInverse",
    // rust: ] {
    // rust: uniforms.insert(name.to_owned(), "mat4".to_owned());
    // rust: if shadow {
    // rust: uniforms.insert(name.replace("gbuffer", "shadow"), "mat4".to_owned());
}
}
}
    // rust: let mut samplers: BTreeMap<String, String> = BTreeMap::new();
    // rust: for stage in [&v, &f] {
    // rust: for (name, ty, at) in &stage.uniforms {
    // rust: if let Some(old) = uniforms.insert(name.clone(), ty.clone())
    // rust: && &old != ty
    // rust: {
    // rust: errors.push(stage.error(
    // rust: *at,
    // rust: &format!("`{name}` is `{old}` in one stage and `{ty}` in the other"),
    // rust: ));
}
}
    // rust: for (name, ty) in &stage.samplers {
    // rust: samplers.insert(name.clone(), ty.clone());
}
}
    // rust: if gbuffers.is_some() {
        // The references use the geometry transform state instead of a second frame slot.
    // rust: for name in ["projectionMatrix", "modelViewMatrix"] {
    // rust: if uniforms.get(name).is_some_and(|ty| ty == "mat4") {
    // rust: uniforms.remove(name);
}
}
        // A compatibility-profile stage keeps reading the frame's `normalMatrix`.
    // rust: let normal = "normalMatrix";
    // rust: if uniforms.get(normal).is_some_and(|ty| ty == "mat3")
    // rust: && [&v, &f].into_iter().all(|stage| {
    // rust: stage.core_matrix(normal).is_some()
    // rust: || !stage.uniforms.iter().any(|(name, ..)| name == normal)
    // rust: })
    // rust: {
    // rust: uniforms.remove(normal);
}
        // The fragment stage's own `textureMatrix` keeps its frame slot (it reads zero).
    // rust: if !f.uniforms.iter().any(|(n, _, _)| n == "textureMatrix")
    // rust: && uniforms.get("textureMatrix").is_some_and(|ty| ty == "mat4")
    // rust: {
    // rust: uniforms.remove("textureMatrix");
}
}
    // `alphaTestRef` is the program's alpha test reference: a constant of the program.
    // rust: let alpha_test_ref = gbuffers
    // rust: .filter(|_| uniforms.get("alphaTestRef").is_some_and(|t| t == "float"))
    // rust: .map(|g| g.alpha_test.map_or(0.0, |t| t.reference));
    // rust: if alpha_test_ref.is_some() {
    // rust: uniforms.remove("alphaTestRef");
}
    // Per-draw values move to their own block; another type than the documented one keeps
    // the frame's block (and reads zero).
    // rust: let mut draw = false;
    // rust: if gbuffers.is_some() {
    // rust: for (name, ty) in DRAW_UNIFORMS {
    // rust: if uniforms.get(name).is_some_and(|t| t == ty) {
    // rust: uniforms.remove(name);
    // rust: draw = true;
}
}
        // Where Iris declares `currentRenderedItemId` itself, a program may read it undeclared;
        // `HzDraw` declares it.
    // rust: let item = "currentRenderedItemId";
    // rust: draw |= gbuffers.is_some_and(|g| g.item_id_declared)
    // rust: && !uniforms.contains_key(item)
    // rust: && [vertex, fragment]
    // rust: .iter()
    // rust: .any(|pp| uses_name(&pp.code, item));
}
    // rust: let samplers: Vec<Sampler> = samplers
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, (name, ty))| Sampler {
    // rust: name,
    // rust: ty,
    // rust: binding: 1 + 2 * i as u32,
    // rust: })
    // rust: .collect();
    // rust: let images = bind_images([&v, &f], samplers.len());

    // Varyings by name: the vertex outputs, then fragment inputs the vertex stage lacks. A
    // matrix or array travels as one varying per column or element (`varying_parts`), a
    // struct as its members packed into vectors (`struct_parts`).
    // rust: let mut locations: BTreeMap<String, (u32, String)> = BTreeMap::new();
    // rust: let mut split: BTreeMap<String, (String, Vec<(String, String)>)> = BTreeMap::new();
    // rust: let vars = v.outs.iter().map(|o| (&v, o));
    // rust: for (stage, var) in vars.chain(f.ins.iter().map(|i| (&f, i))) {
    // rust: if locations.contains_key(&var.name) || split.contains_key(&var.name) {
    // rust: continue;
}
    // rust: if var.structure {
    // rust: match struct_parts(&var.decl, &stage.structs) {
    // rust: Some(parts) => {
    // rust: let mut copies = Vec::new();
    // rust: for (k, (decl, members)) in parts.into_iter().enumerate() {
    // rust: let part = format!("hz_v_{}_{k}", var.name);
    // rust: let next = locations.len() as u32;
    // rust: locations.insert(part.clone(), (next, decl));
    // rust: for (swizzle, access) in members {
    // rust: copies.push((format!("{part}{swizzle}"), access));
}
}
    // rust: split.insert(var.name.clone(), (String::new(), copies));
}
    // rust: None => errors.push(Error {
    // rust: file: stage.pp.files.first().cloned().unwrap_or_default(),
    // rust: line: 0,
    // rust: message: format!("`{}`: this struct can't be a varying", var.name),
    // rust: }),
}
    // rust: continue;
}
    // rust: match varying_parts(&var.decl) {
    // rust: Some((global, parts)) => {
    // rust: let mut copies = Vec::new();
    // rust: for (k, (decl, access)) in parts.into_iter().enumerate() {
    // rust: let part = format!("hz_v_{}_{k}", var.name);
    // rust: let next = locations.len() as u32;
    // rust: locations.insert(part.clone(), (next, decl));
    // rust: copies.push((part, access));
}
    // rust: split.insert(var.name.clone(), (global, copies));
}
    // rust: None => {
    // rust: let next = locations.len() as u32;
    // rust: locations.insert(var.name.clone(), (next, var.decl.clone()));
}
}
}

    // Terrain's fade input is supplied without a pack declaration. Inject it only when
    // the renderer provides the actual value; other geometry and authored globals keep
    // their existing behavior.
    // rust: let chunk_fade = gbuffers
    // rust: .and_then(|g| g.attributes.iter().find(|(n, _)| n == "mc_chunkFade"))
    // rust: .filter(|_| uses_name(&vertex.code, "mc_chunkFade") && !v.globals.contains("mc_chunkFade"));
    // rust: let header = |stage: &Stage| {
    // rust: let mut h = resources(&uniforms, &samplers, &images);
    // rust: if let Some(reference) = alpha_test_ref {
    // rust: writeln!(h, "const float alphaTestRef = {reference:?};").unwrap();
}
    // rust: if draw {
    // rust: h.push_str(
    // rust: "layout(set = 2, binding = 0) uniform HzDraw { int renderStage; int entityId; \
    // rust: int blockEntityId; int currentRenderedItemId; vec4 entityColor; };\n",
    // rust: );
}
    // rust: let direction = if stage.kind == ShaderStage::Vertex {
    // rust: "out"
    // rust: } else {
    // rust: "in"
}
    // rust: for (name, (location, decl)) in &locations {
    // rust: writeln!(
    // rust: h,
    // rust: "layout(location = {location}) {direction} {}",
    // rust: decl.replace("@", name)
    // rust: )
    // rust: .unwrap();
}
    // rust: for (name, (global, _)) in split.iter().filter(|(_, (g, _))| !g.is_empty()) {
    // rust: writeln!(h, "{}", global.replace("@", name)).unwrap();
}
    // rust: if let (Some(inputs), ShaderStage::Vertex) = (gbuffers, stage.kind) {
    // rust: h.push_str(&inputs.declarations);
    // rust: h.push('\n');
    // rust: if chunk_fade.is_some() {
    // rust: h.push_str("float mc_chunkFade;\n");
}
}
    // rust: h.push_str(&stage.prelude());
    // rust: h
}
    // rust: let flip = if target == Target::Buffers { "-" } else { "" };
    // rust: let fog =
    // rust: "    hz_Fog = hz_FogParameters(hz_fog_color, hz_fog.x, hz_fog.y, hz_fog.z, hz_fog.w);\n";
    // rust: let mut vertex_main = String::from("\nvoid main() {\n");
    // rust: match gbuffers {
    // rust: None => vertex_main.push_str(
    // rust: "    vec2 hz_p = hz_quad[gl_VertexIndex];\n    hz_Vertex = vec4(hz_p, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord0 = hz_Vertex;\n    hz_Color = vec4(1.0);\n    hz_Normal = vec3(0.0, 0.0, 1.0);\n",
    // rust: ),
    // rust: Some(inputs) => {
    // rust: vertex_main.push_str(&matrices);
    // rust: vertex_main.push_str(&inputs.body);
}
}
    // rust: if let Some((_, value)) = chunk_fade {
    // rust: writeln!(vertex_main, "    mc_chunkFade = {value};").unwrap();
}
    // rust: for (name, value, ty) in &v.attributes {
    // rust: let value = match gbuffers {
            // Our quad's values for a composite.
    // rust: None => value.clone(),
            // The game's, or zero for anything it doesn't provide.
    // rust: Some(inputs) => match inputs.attributes.iter().find(|a| &a.0 == name) {
    // rust: Some((_, given)) => format!("{ty}({given})"),
    // rust: None => format!("{ty}(0)"),
    // rust: },
}
    // rust: writeln!(vertex_main, "    {name} = {value};").unwrap();
}
    // rust: vertex_main.push_str(fog);
    // rust: for name in &v.inits {
    // rust: writeln!(vertex_main, "    {name} = hz_init_{name}();").unwrap();
}
    // rust: vertex_main.push_str("    hz_main();\n");
    // A struct's own declaration is the pack's: only a stage that declares it copies it.
    // rust: let declared = |list: &[scan::Var], name: &str, global: &str| {
    // rust: !global.is_empty() || list.iter().any(|var| var.name == name)
}
    // rust: for (name, (global, copies)) in &split {
    // rust: if !declared(&v.outs, name, global) {
    // rust: continue;
}
    // rust: for (part, access) in copies {
    // rust: writeln!(vertex_main, "    {part} = {name}{access};").unwrap();
}
}
    // rust: write!(
    // rust: vertex_main,
    // rust: "    gl_Position = vec4(gl_Position.x, {flip}gl_Position.y, (gl_Position.z + gl_Position.w) * 0.5, gl_Position.w);\n{}}}\n",
    // rust: gbuffers.map_or("", |g| &g.after)
    // rust: )
    // rust: .unwrap();
    // rust: let mut fragment_main = String::from("\nvoid main() {\n");
    // rust: if gbuffers.is_some() {
    // rust: fragment_main.push_str(&matrices);
}
    // rust: fragment_main.push_str(fog);
    // rust: if f.frag_coord {
    // rust: fragment_main.push_str(match target {
    // rust: Target::Window => "    hz_FragCoord = vec4(gl_FragCoord.x, hz_target.y - gl_FragCoord.y, gl_FragCoord.zw);\n",
    // rust: Target::Buffers => "    hz_FragCoord = gl_FragCoord;\n",
    // rust: });
}
    // rust: for (name, (global, copies)) in &split {
    // rust: if !declared(&f.ins, name, global) {
    // rust: continue;
}
    // rust: for (part, access) in copies {
    // rust: writeln!(fragment_main, "    {name}{access} = {part};").unwrap();
}
}
    // rust: for name in &f.inits {
    // rust: writeln!(fragment_main, "    {name} = hz_init_{name}();").unwrap();
}
    // rust: if gbuffers.is_some_and(|g| g.far_depth) {
    // rust: fragment_main.push_str("    gl_FragDepth = 1.0;\n");
}
    // rust: fragment_main.push_str("    hz_main();\n");
    // rust: for copy in &f.out_copies {
    // rust: writeln!(fragment_main, "    {copy}").unwrap();
}
    // With `out` variables the pack tests alpha itself.
    // rust: if let Some(t) = gbuffers.and_then(|g| g.alpha_test)
    // rust: && f.outputs.contains(&0)
    // rust: && !f.frag_outs.iter().any(|(n, _)| *n == 0)
    // rust: {
    // rust: match t.op {
    // rust: "false" => fragment_main.push_str("    discard;\n"),
    // rust: op => writeln!(
    // rust: fragment_main,
    // rust: "    if (!(hz_out0.a {op} {:?})) {{ discard; }}",
    // rust: t.reference
    // rust: )
    // rust: .unwrap(),
}
}
    // rust: fragment_main.push_str("}\n");

    // rust: let v_text = format!(
    // rust: "{}{}{vertex_main}",
    // rust: header(&v),
    // rust: v.rewrite(&samplers, &uniforms)
    // rust: );
    // rust: let f_text = format!(
    // rust: "{}{}{fragment_main}",
    // rust: header(&f),
    // rust: f.rewrite(&samplers, &uniforms)
    // rust: );
    // rust: if !errors.is_empty() {
    // rust: return Err(errors);
}
    // rust: let vertex_module = compile(&v, &v_text, header(&v).lines().count());
    // rust: let fragment_module = compile(&f, &f_text, header(&f).lines().count());
    // rust: let (vertex, fragment) = match (vertex_module, fragment_module) {
    // rust: (Ok(v), Ok(f)) => (v, f),
    // rust: (a, b) => return Err(a.err().into_iter().chain(b.err()).flatten().collect()),
}
    // rust: let (initial_values, notes) = defaults::merge([(&v, &vertex), (&f, &fragment)])?;
    // rust: let (uniform_size, offsets) = block_layout(&fragment);
    // rust: let uniforms = offsets
    // rust: .into_iter()
    // rust: .filter_map(|(member, offset)| {
    // rust: let name = member
    // rust: .strip_prefix("hz_bool_")
    // rust: .unwrap_or(&member)
    // rust: .to_owned();
    // rust: let ty = if name.starts_with("hz_") {
    // rust: "vec4".to_owned()
    // rust: } else {
    // rust: uniforms.get(&name)?.clone()
}
    // rust: Some(Uniform { name, ty, offset })
    // rust: })
    // rust: .collect();
    // rust: let outputs = f.outputs.iter().copied().collect();
    // rust: let mut images = images;
    // rust: mark_atomic(&vertex, &mut images);
    // rust: mark_atomic(&fragment, &mut images);
    // rust: Ok(Program {
    // rust: notes,
    // rust: interface: Interface {
    // rust: uniform_size,
    // rust: initial_values,
    // rust: uniforms,
    // rust: samplers,
    // rust: outputs,
    // rust: draw,
    // rust: images,
    // rust: buffers: v.buffers.union(&f.buffers).copied().collect(),
    // rust: },
    // rust: vertex,
    // rust: fragment,
    // rust: })
}

// Images an atomic function uses (naga gave them atomic access) are bound for atomics.
mark_atomic :: proc(module: ^naga::Module, images: ^[Image]) {
}
    // rust: for (_, g) in module.global_variables.iter() {
    // rust: let naga::TypeInner::Image {
    // rust: class: naga::ImageClass::Storage { access, .. },
    // rust: ..
    // rust: } = module.types[g.ty].inner
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(b) = &g.binding
    // rust: && access.contains(naga::StorageAccess::ATOMIC)
    // rust: && let Some(i) = images.iter_mut().find(|i| i.binding == b.binding)
    // rust: {
    // rust: i.access = "atomic".into();
}
}
}

// The images of `stages`, by name, bound after `samplers` samplers.
bind_images :: proc(stages: [^Stage; 2], samplers: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut images: BTreeMap<String, scan::ImageDecl> = BTreeMap::new();
    // rust: for stage in stages {
    // rust: for i in &stage.images {
    // rust: images.entry(i.name.clone()).or_insert_with(|| i.clone());
}
}
    // rust: images
    // rust: .into_values()
    // rust: .enumerate()
    // rust: .map(|(k, i)| Image {
    // rust: name: i.name,
    // rust: ty: i.ty,
    // rust: format: i.format,
    // rust: access: i.access,
    // rust: binding: 1 + 2 * samplers as u32 + k as u32,
    // rust: before: None,
    // rust: })
    // rust: .collect()
}

// `#version 450`, the uniform block at binding 0, each sampler as a texture and a sampler
// object, and the images.
    // rust: fn resources(
    // rust: uniforms: &BTreeMap<String, String>,
    // rust: samplers: &[Sampler],
    // rust: images: &[Image],
    // rust: ) -> String {
    // rust: let mut h = String::from("#version 450\n");
    // rust: h.push_str("layout(set = 0, binding = 0) uniform HzUniforms { vec4 hz_target; vec4 hz_fog_color; vec4 hz_fog; vec4 hz_depth_linear;");
    // rust: for (name, ty) in uniforms {
    // rust: match ty.as_str() {
    // rust: "bool" => write!(h, " int hz_bool_{name};"),
    // rust: _ => match ty.split_once('[') {
    // rust: Some((base, size)) => write!(h, " {base} {name}[{size};"),
    // rust: None => write!(h, " {ty} {name};"),
    // rust: },
}
    // rust: .unwrap();
}
    // rust: h.push_str(" };\n");
    // rust: for s in samplers {
    // rust: let (texture, sampler) = split_sampler(&s.ty);
    // rust: writeln!(
    // rust: h,
    // rust: "layout(set = 0, binding = {}) uniform {texture} {}; layout(set = 0, binding = {}) uniform {sampler} hz_s_{};",
    // rust: s.binding, s.name, s.binding + 1, s.name
    // rust: )
    // rust: .unwrap();
}
    // rust: for i in images {
    // rust: writeln!(
    // rust: h,
    // rust: "layout(set = 0, binding = {}, {}) uniform {} {} {};",
    // rust: i.binding, i.format, i.access, i.ty, i.name
    // rust: )
    // rust: .unwrap();
}
    // rust: h
}

// Translates a compute program (`.csh`).
translate_compute :: proc(compute: ^Preprocessed) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let named = anonymous_structs::name(&compute.code).map(|code| Preprocessed {
    // rust: code,
    // rust: ..compute.clone()
    // rust: });
    // rust: let compute = named.as_ref().unwrap_or(compute);
    // rust: let split = atomic_vectors::rewrite(compute);
    // rust: let compute = split.as_ref().unwrap_or(compute);
    // rust: let (bools, bool_errors) = buffer_bools::rewrite(compute);
    // rust: let compute = bools.as_ref().unwrap_or(compute);
    // rust: let mut c = Stage::scan(compute, ShaderStage::Compute);
    // rust: let mut errors = std::mem::take(&mut c.errors);
    // rust: errors.extend(bool_errors);
    // rust: let mut uniforms: BTreeMap<String, String> = BTreeMap::new();
    // rust: for (name, ty, _) in &c.uniforms {
    // rust: uniforms.insert(name.clone(), ty.clone());
}
    // rust: let samplers: Vec<Sampler> = c
    // rust: .samplers
    // rust: .iter()
    // rust: .map(|(name, ty)| (name, ty))
    // rust: .collect::<BTreeMap<_, _>>()
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, (name, ty))| Sampler {
    // rust: name: name.clone(),
    // rust: ty: ty.clone(),
    // rust: binding: 1 + 2 * i as u32,
    // rust: })
    // rust: .collect();
    // rust: let mut images = bind_images([&c, &c], samplers.len());
    // rust: let code = c.rewrite(&samplers, &uniforms);
    // rust: let code = work_group_size(&code).unwrap_or_else(|message| {
    // rust: errors.push(Error {
    // rust: file: compute.files.first().cloned().unwrap_or_default(),
    // rust: line: 0,
    // rust: message,
    // rust: });
    // rust: code
    // rust: });
    // rust: let code = ordering::barriers_after_atomics(&code).unwrap_or(code);
    // rust: let declared: Vec<(String, bool)> = c
    // rust: .images
    // rust: .iter()
    // rust: .map(|i| (i.name.clone(), i.coherent))
    // rust: .collect();
    // rust: let before = ordering::snapshots(&code, &declared);
    // rust: let code = ordering::read_before(&code, &before);
    // rust: for name in before {
    // rust: let image = images.iter().find(|i| i.name == name).expect("declared");
    // rust: let copy = Image {
    // rust: name: ordering::before_name(&name),
    // rust: ty: image.ty.clone(),
    // rust: format: image.format.clone(),
    // rust: access: String::new(),
    // rust: binding: 1 + 2 * samplers.len() as u32 + images.len() as u32,
    // rust: before: Some(name),
}
    // rust: images.push(copy);
}
    // rust: let mut main = String::from("\nvoid main() {\n");
    // rust: main.push_str(
    // rust: "    hz_Fog = hz_FogParameters(hz_fog_color, hz_fog.x, hz_fog.y, hz_fog.z, hz_fog.w);\n",
    // rust: );
    // rust: for name in &c.inits {
    // rust: writeln!(main, "    {name} = hz_init_{name}();").unwrap();
}
    // rust: main.push_str("    hz_main();\n}\n");
    // rust: let header = resources(&uniforms, &samplers, &images) + &c.prelude();
    // rust: let text = format!("{header}{code}{main}");
    // `workGroups` is an ivec3, `workGroupsRender` a vec2 (a third number, the depth of a 2D
    // render, is taken as 1); anything else is not understood rather than guessed.
    // rust: let mut sizes = |name: &str, counts: &[usize]| {
    // rust: let v = constant(&c, name)?;
    // rust: if !counts.contains(&v.len()) {
    // rust: errors.push(Error {
    // rust: file: compute.files.first().cloned().unwrap_or_default(),
    // rust: line: 0,
    // rust: message: format!("`{name}` must have {counts:?} numbers, not {}", v.len()),
    // rust: });
    // rust: return None;
}
    // rust: Some(v)
}
    // rust: let work_groups = sizes("workGroups", &[3]).map(|v| [v[0] as u32, v[1] as u32, v[2] as u32]);
    // rust: let work_groups_render =
    // rust: sizes("workGroupsRender", &[2, 3]).map_or([1.0, 1.0], |v| [v[0] as f32, v[1] as f32]);
    // rust: if !errors.is_empty() {
    // rust: return Err(errors);
}
    // rust: let module = compile(&c, &text, header.lines().count()).map_err(|e| {
    // rust: errors.extend(e);
    // rust: std::mem::take(&mut errors)
    // rust: })?;
    // rust: let (uniform_size, offsets) = block_layout(&module);
    // rust: let (initial_values, notes) = defaults::merge([(&c, &module)])?;
    // rust: let mut interface = Interface {
    // rust: uniform_size,
    // rust: initial_values,
    // rust: uniforms: offsets
    // rust: .into_iter()
    // rust: .filter_map(|(member, offset)| {
    // rust: let name = member
    // rust: .strip_prefix("hz_bool_")
    // rust: .unwrap_or(&member)
    // rust: .to_owned();
    // rust: let ty = if name.starts_with("hz_") {
    // rust: "vec4".to_owned()
    // rust: } else {
    // rust: uniforms.get(&name)?.clone()
}
    // rust: Some(Uniform { name, ty, offset })
    // rust: })
    // rust: .collect(),
    // rust: samplers,
    // rust: outputs: Vec::new(),
    // rust: draw: false,
    // rust: images,
    // rust: buffers: c.buffers.iter().copied().collect(),
}
    // rust: mark_atomic(&module, &mut interface.images);
    // rust: Ok(ComputeProgram {
    // rust: notes,
    // rust: module,
    // rust: interface,
    // rust: work_groups,
    // rust: work_groups_render,
    // rust: })
}

// `code` with `gl_WorkGroupSize` written as the constant its `layout(local_size_*)` declares:
// GLSL defines it so, and naga's HLSL writer has no such built-in.
work_group_size :: proc(code: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut tokens: Vec<String> = crate::macros::lex(code)
    // rust: .into_iter()
    // rust: .map(str::to_owned)
    // rust: .collect();
    // rust: let mut sizes = [1u32; 3];
    // rust: let axes = ["local_size_x", "local_size_y", "local_size_z"];
    // rust: let sig: Vec<usize> = (0..tokens.len())
    // rust: .filter(|&i| scan::significant(&tokens[i]))
    // rust: .collect();
    // rust: for (k, &at) in sig.iter().enumerate() {
    // rust: let Some(axis) = axes.iter().position(|a| tokens[at] == *a) else {
    // rust: continue;
}
    // rust: if sig.get(k + 1).is_none_or(|&e| tokens[e] != "=") {
    // rust: continue;
}
        // The size's expression runs to the `,` or `)` that ends the qualifier.
    // rust: let mut depth = 0usize;
    // rust: let expr: Vec<usize> = sig[k + 2..]
    // rust: .iter()
    // rust: .copied()
    // rust: .take_while(|&i| match tokens[i].as_str() {
    // rust: "(" => {
    // rust: depth += 1;
    // rust: true
}
    // rust: ")" if depth > 0 => {
    // rust: depth -= 1;
    // rust: true
}
    // rust: "," | ")" if depth == 0 => false,
    // rust: _ => true,
    // rust: })
    // rust: .collect();
    // rust: let words: Vec<&str> = expr.iter().map(|&i| tokens[i].as_str()).collect();
    // rust: let size = ConstantSize::eval(&words)
    // rust: .ok_or_else(|| format!("`{}` is not a size Horizon can work out", axes[axis]))?;
    // rust: sizes[axis] = size;
        // naga takes a number there: the expression becomes its value.
    // rust: if let (Some(&first), Some(&last)) = (expr.first(), expr.last()) {
    // rust: tokens[first] = size.to_string();
    // rust: for t in &mut tokens[first + 1..=last] {
    // rust: t.retain(|c| c == '\n');
}
}
}
    // rust: let value = format!("uvec3({}u, {}u, {}u)", sizes[0], sizes[1], sizes[2]);
    // rust: for t in &mut tokens {
    // rust: if t == "gl_WorkGroupSize" {
    // rust: *t = value.clone();
}
}
    // rust: Ok(tokens.concat())
}

// A work group size given as an integer constant expression (GLSL 4.60, 4.4 and 4.4.1):
// numbers, `+ - * / %`, brackets, `min`, `max` and `gl_MaxComputeWorkGroupSize`, the minimum
// GLSL requires (`ivec3(1024, 1024, 64)`, 7.3); the translation knows no device.
ConstantSize :: struct {
    words: ^'w [^'w str],
    at: uint,
}

    // rust: impl<'w> ConstantSize<'w> {
eval :: proc(words: ^'w [^'w str]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut p = Self { words, at: 0 };
    // rust: let v = p.sum()?;
    // rust: (p.at == words.len())
    // rust: .then_some(v)
    // rust: .and_then(|v| u32::try_from(v).ok())
}

peek :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.words.get(self.at).copied()
}

eat :: proc(self: ^Self, word: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let found = self.peek() == Some(word);
    // rust: self.at += usize::from(found);
    // rust: found
}

sum :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = self.product()?;
    // rust: loop {
    // rust: if self.eat("+") {
    // rust: v = v.checked_add(self.product()?)?;
    // rust: } else if self.eat("-") {
    // rust: v = v.checked_sub(self.product()?)?;
    // rust: } else {
    // rust: return Some(v);
}
}
}

product :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = self.unary()?;
    // rust: loop {
    // rust: if self.eat("*") {
    // rust: v = v.checked_mul(self.unary()?)?;
    // rust: } else if self.eat("/") {
    // rust: v = v.checked_div(self.unary()?)?;
    // rust: } else if self.eat("%") {
    // rust: v = v.checked_rem(self.unary()?)?;
    // rust: } else {
    // rust: return Some(v);
}
}
}

unary :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.eat("-") {
    // rust: return self.unary()?.checked_neg();
}
    // rust: if self.eat("+") {
    // rust: return self.unary();
}
    // rust: if self.eat("(") {
    // rust: let v = self.sum()?;
    // rust: return self.eat(")").then_some(v);
}
    // rust: let word = self.peek()?;
    // rust: self.at += 1;
    // rust: match word {
    // rust: "min" | "max" => {
    // rust: if !self.eat("(") {
    // rust: return None;
}
    // rust: let a = self.sum()?;
    // rust: if !self.eat(",") {
    // rust: return None;
}
    // rust: let b = self.sum()?;
    // rust: if !self.eat(")") {
    // rust: return None;
}
    // rust: Some(if word == "min" { a.min(b) } else { a.max(b) })
}
    // rust: "gl_MaxComputeWorkGroupSize" => {
    // rust: if !self.eat(".") {
    // rust: return None;
}
    // rust: let axis = self.peek()?;
    // rust: self.at += 1;
    // rust: match axis {
    // rust: "x" => Some(1024),
    // rust: "y" => Some(1024),
    // rust: "z" => Some(64),
    // rust: _ => None,
}
}
    // rust: number => number.trim_end_matches(['u', 'U']).parse().ok(),
}
}
}

// The numbers of a constant's constructor, `const ivec3 name = ivec3(1, 2, 3);` → 1, 2, 3.
constant :: proc(stage: ^Stage, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let at = stage.tokens.iter().position(|&t| t == name)?;
    // rust: let rest = &stage.tokens[at + 1..];
    // rust: if rest.iter().find(|t| scan::significant(t)) != Some(&"=") {
    // rust: return None;
}
    // rust: let end = rest.iter().position(|&t| t == ";")?;
    // rust: let mut values: Vec<f64> = rest[..end]
    // rust: .iter()
    // rust: .filter_map(|t| t.trim_end_matches(['u', 'U', 'f', 'F']).parse().ok())
    // rust: .collect();
    // rust: if values.len() == 1 && values[0] >= 0.0 {
        // A vector constructor with one scalar fills every component (GLSL 5.4.2).
        // Only splat a literal; collecting a number out of an expression loses its operators.
    // rust: let words: Vec<_> = rest[..end]
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| scan::significant(t))
    // rust: .collect();
    // rust: let count = match words.as_slice() {
    // rust: ["=", "ivec2" | "uvec2" | "vec2", "(", _, ")"] => 2,
    // rust: ["=", "ivec3" | "uvec3" | "vec3", "(", _, ")"] => 3,
    // rust: _ => 1,
}
    // rust: values.resize(count, values[0]);
}
    // rust: Some(values)
}

// A matrix or array varying (`flat mat3 @[2];`): wgpu's stage interfaces take only scalars
// and vectors (WGSL), so it becomes a private global (`mat3 @[2];`) and one varying per
// column or element, each with the qualifiers and how to reach it (`[1][2]`). `None` for
// scalars and vectors, and for sizes that are not plain numbers.
varying_parts :: proc(decl: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (before, after) = decl.split_once('@')?;
    // rust: let mut words: Vec<&str> = before.split_whitespace().collect();
    // rust: let ty = words.pop()?;
    // rust: let qualifiers: String = words.iter().map(|w| format!("{w} ")).collect();
    // rust: let array = after.trim().trim_end_matches(';').trim();
    // rust: let mut sizes = Vec::new();
    // rust: let mut rest = array;
    // rust: while let Some(r) = rest.strip_prefix('[') {
    // rust: let (n, r) = r.split_once(']')?;
    // rust: sizes.push(n.trim().parse::<usize>().ok()?);
    // rust: rest = r.trim_start();
}
    // rust: if !rest.is_empty() {
    // rust: return None;
}
    // matC or matCxR: C columns of R rows.
    // rust: let column = ty.strip_prefix("mat").and_then(|d| {
    // rust: let (c, r) = d.split_once('x').unwrap_or((d, d));
    // rust: Some((c.parse::<usize>().ok()?, r.parse::<usize>().ok()?))
    // rust: });
    // rust: if sizes.is_empty() && column.is_none() {
    // rust: return None;
}
    // rust: let part_ty = column.map_or(ty.to_owned(), |(_, r)| format!("vec{r}"));
    // rust: if let Some((c, _)) = column {
    // rust: sizes.push(c);
}
    // rust: let count: usize = sizes.iter().product();
    // rust: let parts = (0..count)
    // rust: .map(|mut k| {
    // rust: let mut access = String::new();
    // rust: for &size in sizes.iter().rev() {
    // rust: access.insert_str(0, &format!("[{}]", k % size));
    // rust: k /= size;
}
    // rust: (format!("{qualifiers}{part_ty} @;"), access)
    // rust: })
    // rust: .collect();
    // rust: Some((format!("{ty} @{array};"), parts))
}

// A struct varying (`flat Params @;`) as vectors: its scalar, vector and matrix members, through
// nested structs and arrays, packed four components at a time by base type. Each part: its
// declaration and, per member, the swizzle of the part and how to reach the member (`.a[1].b`).
// `None` for a member that can't travel (`bool`, an unknown type, a size that is not a number).
    // rust: fn struct_parts(
    // rust: decl: &str,
    // rust: structs: &std::collections::HashMap<String, Vec<(String, String)>>,
    // rust: ) -> Option<Vec<(String, Vec<(String, String)>)>> {
    // rust: let (before, after) = decl.split_once('@')?;
    // rust: let mut words: Vec<&str> = before.split_whitespace().collect();
    // rust: let ty = words.pop()?;
    // rust: let qualifiers: String = words.iter().map(|w| format!("{w} ")).collect();
    // rust: let mut leaves = Vec::new();
    // rust: leaves_of(
    // rust: ty,
    // rust: after.trim().trim_end_matches(';'),
    // rust: String::new(),
    // rust: structs,
    // rust: &mut leaves,
    // rust: )?;
    // Slots of one base type and up to four components: (base, used, members (from, size, access)).
    // rust: let mut slots: Vec<(&str, usize, Vec<(usize, usize, String)>)> = Vec::new();
    // rust: for (base, size, access) in leaves {
    // rust: match slots
    // rust: .iter_mut()
    // rust: .find(|(b, used, _)| *b == base && used + size <= 4)
    // rust: {
    // rust: Some(slot) => {
    // rust: slot.2.push((slot.1, size, access));
    // rust: slot.1 += size;
}
    // rust: None => slots.push((base, size, vec![(0, size, access)])),
}
}
    // rust: Some(
    // rust: slots
    // rust: .into_iter()
    // rust: .map(|(base, used, members)| {
    // rust: let ty = match (base, used) {
    // rust: (b, 1) => b.to_owned(),
    // rust: ("float", n) => format!("vec{n}"),
    // rust: ("int", n) => format!("ivec{n}"),
    // rust: (_, n) => format!("uvec{n}"),
}
                // Integers only travel flat.
    // rust: let flat = if base != "float" && !qualifiers.contains("flat") {
    // rust: "flat "
    // rust: } else {
    // rust: ""
}
    // rust: let members = members
    // rust: .into_iter()
    // rust: .map(|(from, size, access)| {
    // rust: let swizzle = if used == 1 {
    // rust: String::new()
    // rust: } else {
    // rust: format!(".{}", &"xyzw"[from..from + size])
}
    // rust: (swizzle, access)
    // rust: })
    // rust: .collect();
    // rust: (format!("{flat}{qualifiers}{ty} @;"), members)
    // rust: })
    // rust: .collect(),
    // rust: )
}

// The scalars and vectors inside a value of type `ty` with array suffix `array`, reached by
// `access`: (base type, components, access).
    // rust: fn leaves_of(
    // rust: ty: &str,
    // rust: array: &str,
    // rust: access: String,
    // rust: structs: &std::collections::HashMap<String, Vec<(String, String)>>,
    // rust: out: &mut Vec<(&'static str, usize, String)>,
    // rust: ) -> Option<()> {
    // rust: if let Some(rest) = array.trim().strip_prefix('[') {
    // rust: let (n, rest) = rest.split_once(']')?;
    // rust: for k in 0..n.trim().parse::<usize>().ok()? {
    // rust: leaves_of(ty, rest, format!("{access}[{k}]"), structs, out)?;
}
    // rust: return Some(());
}
    // rust: if let Some(members) = structs.get(ty) {
    // rust: for (member_ty, member) in members {
    // rust: let (name, array) = member
    // rust: .split_once('[')
    // rust: .map_or((member.as_str(), ""), |(n, _)| (n, &member[n.len()..]));
    // rust: leaves_of(member_ty, array, format!("{access}.{name}"), structs, out)?;
}
    // rust: return Some(());
}
    // rust: if let Some(dims) = ty.strip_prefix("mat") {
    // rust: let (c, r) = dims.split_once('x').unwrap_or((dims, dims));
    // rust: let (c, r) = (c.parse::<usize>().ok()?, r.parse::<usize>().ok()?);
    // rust: for k in 0..c {
    // rust: out.push(("float", r, format!("{access}[{k}]")));
}
    // rust: return Some(());
}
    // rust: let (base, size) = match ty {
    // rust: "float" => ("float", 1),
    // rust: "int" => ("int", 1),
    // rust: "uint" => ("uint", 1),
    // rust: _ => {
    // rust: let (base, n) = if let Some(n) = ty.strip_prefix("vec") {
    // rust: ("float", n)
    // rust: } else if let Some(n) = ty.strip_prefix("ivec") {
    // rust: ("int", n)
    // rust: } else {
    // rust: ("uint", ty.strip_prefix("uvec")?)
}
    // rust: (base, n.parse().ok()?)
}
}
    // rust: out.push((base, size, access));
    // rust: Some(())
}

// `sampler2DShadow` → (`texture2D`, `samplerShadow`); `isampler3D` → (`itexture3D`, `sampler`).
    // rust: pub(super) fn split_sampler(ty: &str) -> (String, &'static str) {
    // rust: let shadow = ty.ends_with("Shadow");
    // rust: let base = ty
    // rust: .trim_end_matches("Shadow")
    // rust: .replacen("sampler", "texture", 1);
    // rust: (base, if shadow { "samplerShadow" } else { "sampler" })
}

// Parses and validates one stage; errors at the pack's files and lines.
compile :: proc(stage: ^Stage, text: string, header_lines: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let specialized = image_parameters::rewrite(text).map_err(|message| {
    // rust: vec![Error {
    // rust: file: stage.pp.files.first().cloned().unwrap_or_default(),
    // rust: line: 1,
    // rust: message,
    // rust: }]
    // rust: })?;
    // rust: let bounded = integer_bounds::rewrite(&array_constructors::rewrite(&specialized));
    // rust: let text = bounded.as_str();
    // rust: let at = |text: &str, span: naga::Span, message: String| {
    // rust: let start = span.to_range().map_or(0, |r| r.start);
    // rust: let line = text[..start.min(text.len())].matches('\n').count();
    // rust: match line
    // rust: .checked_sub(header_lines)
    // rust: .and_then(|l| stage.pp.lines.get(l))
    // rust: {
    // rust: Some(o) => Error {
    // rust: file: stage
    // rust: .pp
    // rust: .files
    // rust: .get(o.file as usize)
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: line: o.line,
    // rust: message,
    // rust: },
    // rust: None => Error {
    // rust: file: "<horizon>".into(),
    // rust: line: line as u32 + 1,
    // rust: message,
    // rust: },
}
}
    // rust: let parse = |text: &str| {
    // rust: Frontend::default()
    // rust: .parse(&Options::from(stage.kind), text)
    // rust: .map_err(|e| {
    // rust: e.errors
    // rust: .into_iter()
    // rust: .map(|e| at(text, e.meta, e.kind.to_string()))
    // rust: .collect::<Vec<_>>()
    // rust: })
}
    // naga's frontend refuses a few things GL takes: a scalar's swizzle (`f.x`, GLSL 4.20), a
    // matrix column's component written to (`m[1].y =`) and `min`/`max`/`clamp` of a `uint` and
    // integer literals, and a function prototype declared again. Each refusal is rewritten where
    // naga points, and the source parsed again.
    // rust: let mut text = std::borrow::Cow::Borrowed(text);
    // rust: let mut tries = 0;
    // rust: let mut module = loop {
    // rust: tries += 1;
    // rust: match Frontend::default().parse(&Options::from(stage.kind), &text) {
    // rust: Ok(m) => break m,
    // rust: Err(e) => match e.errors.iter().find_map(|e| {
    // rust: scalar_swizzle(&text, e)
    // rust: .or_else(|| unsigned_literals(&text, e))
    // rust: .or_else(|| repeated_prototype(&text, e))
    // rust: }) {
    // rust: Some(fixed) if tries < 256 => text = fixed.into(),
    // rust: _ => return parse(&text),
    // rust: },
}
}
    // rust: end_returns_give_zero(&mut module);
    // rust: Validator::new(ValidationFlags::all(), Capabilities::all())
    // rust: .subgroup_operations(naga::valid::SubgroupOperationSet::all())
    // rust: .subgroup_stages(naga::valid::ShaderStages::all())
    // rust: .validate(&module)
    // rust: .map_err(|e| {
    // rust: let span = e.spans().next().map_or(naga::Span::default(), |(s, _)| *s);
            // The validator nests its reasons: say them all.
    // rust: let inner = e.into_inner();
    // rust: let mut message = inner.to_string();
    // rust: let mut source = std::error::Error::source(&inner);
    // rust: while let Some(s) = source {
    // rust: write!(message, ": {s}").unwrap();
    // rust: source = s.source();
}
    // rust: vec![at(&text, span, message)]
    // rust: })?;
    // rust: Ok(module)
}

// GLSL lets a function that returns a value reach its end without a `return`: what it returns
// then is undefined (GLSL 4.60, 6.1). naga's frontend ends every body that can reach its end
// with a `return` of no value, which its validator refuses in such a function; those returns
// give the result type's zero instead.
end_returns_give_zero :: proc(module: ^naga::Module) {
}
fill :: proc(block: ^naga::Block, zero: ^dyn FnMut() -> n {
    // Ported from Horizon
    return {}
}
        // The ends naga's frontend gives a `return` to (`naga::proc::ensure_block_returns`).
    // rust: match block.last_mut() {
    // rust: Some(naga::Statement::Block(b)) => fill(b, zero),
    // rust: Some(naga::Statement::If { accept, reject, .. }) => {
    // rust: fill(accept, zero);
    // rust: fill(reject, zero);
}
    // rust: Some(naga::Statement::Switch { cases, .. }) => {
    // rust: for case in cases.iter_mut().filter(|c| !c.fall_through) {
    // rust: fill(&mut case.body, zero);
}
}
    // rust: Some(naga::Statement::Return { value }) if value.is_none() => *value = Some(zero()),
    // rust: _ => {}
}
}
    // rust: for (_, f) in module.functions.iter_mut() {
    // rust: let Some(ty) = f.result.as_ref().map(|r| r.ty) else {
    // rust: continue;
}
    // rust: let (body, expressions) = (&mut f.body, &mut f.expressions);
    // rust: let mut made = None;
    // rust: fill(body, &mut || {
    // rust: *made.get_or_insert_with(|| {
    // rust: expressions.append(naga::Expression::ZeroValue(ty), naga::Span::default())
    // rust: })
    // rust: });
}
}

// `text` without the scalar swizzle naga's frontend refused (`e`, GLSL 4.20's `f.x`, `f.xx`): one
// component dropped, more a vector constructor of the scalar.
scalar_swizzle :: proc(text: string, e: ^naga::front::glsl::Error) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !e
    // rust: .kind
    // rust: .to_string()
    // rust: .starts_with("Can't lookup field on this type")
    // rust: {
    // rust: return None;
}
    // rust: let r = e.meta.to_range()?;
    // rust: let field = text.get(r.clone())?.strip_prefix('.')?;
    // rust: let one = |c: char| field.chars().all(|f| f == c);
    // rust: let indexed = text[..r.start].trim_end().ends_with(']');
    // rust: let component = field.len() == 1 && "xyzwrgbastpq".contains(field);
    // rust: if field.is_empty()
    // rust: || field.len() > 4
    // rust: || !(one('x') || one('r') || one('s') || indexed && component)
    // rust: {
    // rust: return None;
}
    // rust: let mut out = text.to_owned();
    // rust: if field.len() == 1 && indexed {
        // A matrix column's component, written to: `m[1].y` as `m[1][1]`.
    // rust: let k = "xyzwrgbastpq".find(field).map(|k| k % 4)?;
    // rust: out.replace_range(r, &format!("[{k}]"));
    // rust: } else if field.len() == 1 {
    // rust: out.replace_range(r, "");
    // rust: } else {
    // rust: let start = expression_start(text, r.start)?;
    // rust: out.replace_range(r, ")");
    // rust: out.insert_str(start, &format!("vec{}(", field.len()));
}
    // rust: Some(out)
}

// `text` with the integer literals of the `min`/`max`/`clamp` call naga found ambiguous (`e`)
// made unsigned: with a `uint` beside them GL takes the `uint` overload.
unsigned_literals :: proc(text: string, e: ^naga::front::glsl::Error) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = e.kind.to_string();
    // rust: let f = kind
    // rust: .strip_prefix("Ambiguous best function for '")?
    // rust: .trim_end_matches('\'');
    // rust: if !matches!(f, "min" | "max" | "clamp") {
    // rust: return None;
}
    // rust: let r = e.meta.to_range()?;
    // rust: let call = text.get(r.clone())?;
    // rust: let b = call.as_bytes();
    // rust: let word = |c: u8| c.is_ascii_alphanumeric() || c == b'_' || c == b'.';
    // rust: let mut out = String::with_capacity(call.len() + 8);
    // rust: let mut i = 0;
    // rust: let mut changed = false;
    // rust: while i < b.len() {
    // rust: if b[i].is_ascii_digit() && (i == 0 || !word(b[i - 1])) {
    // rust: let start = i;
    // rust: while i < b.len() && b[i].is_ascii_digit() {
    // rust: i += 1;
}
    // rust: out.push_str(&call[start..i]);
    // rust: if i == b.len() || !(word(b[i])) {
    // rust: out.push('u');
    // rust: changed = true;
}
    // rust: continue;
}
    // rust: out.push(b[i] as char);
    // rust: i += 1;
}
    // rust: changed.then(|| format!("{}{out}{}", &text[..r.start], &text[r.end..]))
}

// `text` without the function prototype naga's frontend refused as declared before (`e`): GLSL
// lets a function be declared again (packs include the same helper's prototype from two
// files). The prototype and its `;` turn to spaces, keeping lines where they are; one with
// qualifiers before its type (naga's span starts at the type) is left alone.
repeated_prototype :: proc(text: string, e: ^naga::front::glsl::Error) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if e.kind.to_string() != "Prototype already defined" {
    // rust: return None;
}
    // rust: let r = e.meta.to_range()?;
    // rust: let end = r.end + text.get(r.end..)?.find(';')? + 1;
    // rust: if !text.get(r.end..end - 1)?.trim().is_empty() {
    // rust: return None;
}
    // rust: let before = text.get(..r.start)?.trim_end();
    // rust: let line = &before[before.rfind('\n').map_or(0, |n| n + 1)..];
    // rust: let boundary =
    // rust: before.is_empty() || before.ends_with([';', '}']) || line.trim_start().starts_with('#');
    // rust: if !boundary {
    // rust: return None;
}
    // rust: let blank: String = text[r.start..end]
    // rust: .chars()
    // rust: .map(|c| if c == '\n' { '\n' } else { ' ' })
    // rust: .collect();
    // rust: Some(format!("{}{blank}{}", &text[..r.start], &text[end..]))
}

// Where the operand that ends right before byte `end` begins: a name, a call or an index (with
// what it is of), or a bracketed expression.
expression_start :: proc(text: string, end: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = text.as_bytes();
    // rust: let mut i = end;
    // rust: while i > 0 && b[i - 1].is_ascii_whitespace() {
    // rust: i -= 1;
}
    // rust: loop {
    // rust: match b.get(i.checked_sub(1)?) {
    // rust: Some(b')') | Some(b']') => {
    // rust: let mut level = 0i32;
    // rust: loop {
    // rust: i = i.checked_sub(1)?;
    // rust: match b[i] {
    // rust: b')' | b']' => level += 1,
    // rust: b'(' | b'[' => {
    // rust: level -= 1;
    // rust: if level == 0 {
    // rust: break;
}
}
    // rust: _ => {}
}
}
}
    // rust: Some(c) if c.is_ascii_alphanumeric() || *c == b'_' || *c == b'.' => i -= 1,
    // rust: _ => return Some(i),
}
    // rust: if i == 0 {
    // rust: return Some(0);
}
}
}

// The uniform block's size and member offsets, from naga's layout.
block_layout :: proc(module: ^naga::Module) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: for (_, var) in module.global_variables.iter() {
    // rust: let frame = var
    // rust: .binding
    // rust: .as_ref()
    // rust: .is_some_and(|b| b.group == 0 && b.binding == 0);
    // rust: if var.space != naga::AddressSpace::Uniform || !frame {
    // rust: continue;
}
    // rust: if let naga::TypeInner::Struct { members, span } = &module.types[var.ty].inner {
    // rust: let offsets = members
    // rust: .iter()
    // rust: .filter_map(|m| Some((m.name.clone()?, m.offset)))
    // rust: .collect();
    // rust: return (*span, offsets);
}
}
    // rust: (16, vec![("hz_target".into(), 0)])
}

    // rust: mod tests {
//     use super::*;

    // A gbuffers program whose fragment stage writes `float(<name>)` after `decl`.
    // rust: fn item_program(
    // rust: program: &str,
    // rust: decl: &str,
    // rust: name: &str,
    // rust: game: &GbuffersInputs,
    // rust: ) -> Result<Program, Vec<Error>> {
    // rust: let vsh = "#version 330 compatibility\nvoid main() { gl_Position = ftransform(); }\n";
    // rust: let fsh = format!(
    // rust: "#version 330 compatibility\n{decl}\nlayout(location = 0) out vec4 c;\n\
    // rust: void main() {{ c = vec4(float({name})); }}\n"
    // rust: );
    // rust: let (v, f) = (format!("{program}.vsh"), format!("{program}.fsh"));
    // rust: let files = [
    // rust: (format!("shaders/{v}"), vsh.to_owned()),
    // rust: (format!("shaders/{f}"), fsh),
    // rust: ];
    // rust: let files: Vec<(&str, &str)> = files
    // rust: .iter()
    // rust: .map(|(a, b)| (a.as_str(), b.as_str()))
    // rust: .collect();
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let m = Macros::standard();
    // rust: translate_gbuffers(
    // rust: &preprocess(&pack, &v, &m),
    // rust: &preprocess(&pack, &f, &m),
    // rust: Target::Buffers,
    // rust: game,
    // rust: )
}

item_game :: proc() -> G {
    // Ported from Horizon
    return {}
}
    // rust: GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 game_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(game_pos, 1.0);\n".into(),
    // rust: ..Default::default()
}
}

    // `currentRenderedItemId` is set per draw, in `HzDraw`, as `entityId` is.
the_rendered_item_id_is_a_per_draw_value :: proc() {
}
    // rust: let decl = "uniform int currentRenderedItemId;";
    // rust: let p = item_program("gbuffers_hand", decl, "currentRenderedItemId", &item_game())
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let names: Vec<&str> = p
    // rust: .interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .map(|u| u.name.as_str())
    // rust: .collect();
    // rust: assert!(
    // rust: p.interface.draw && !names.contains(&"currentRenderedItemId"),
    // rust: "{names:?}"
    // rust: );
}

    // The hand's programs may read `currentRenderedItemId` without declaring it, as Iris lets
    // them; terrain's may not, nor a longer name that begins with it.
the_hand_may_read_the_rendered_item_id_undeclared :: proc() {
}
    // rust: let hand = GbuffersInputs {
    // rust: item_id_declared: true,
    // rust: ..item_game()
}
    // rust: let p = item_program("gbuffers_hand", "", "currentRenderedItemId", &hand)
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(p.interface.draw);
    // rust: assert!(
    // rust: item_program(
    // rust: "gbuffers_terrain",
    // rust: "",
    // rust: "currentRenderedItemId",
    // rust: &item_game()
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: let longer = "uniform int currentRenderedItemId2;";
    // rust: let p = item_program("gbuffers_hand", longer, "currentRenderedItemId2", &hand)
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(!p.interface.draw);
}

compute_dispatch_splats_absolute_vector_constants :: proc() {
}
    // rust: for (declaration, expected) in [
    // rust: ("const ivec3 workGroups = ivec3(1);", [1, 1, 1]),
    // rust: ("const ivec3 workGroups = ivec3(2);", [2, 2, 2]),
    // rust: ("const ivec3 workGroups = ivec3(2, 3, 4);", [2, 3, 4]),
    // rust: ] {
    // rust: let source = format!(
    // rust: "#version 430\nlayout(local_size_x=1) in;\n{declaration}\nvoid main(){{}}\n"
    // rust: );
    // rust: let pack =
    // rust: Pack::from_zip_bytes("dispatch.zip", zip(&[("shaders/composite.csh", &source)]))
    // rust: .unwrap();
    // rust: let program =
    // rust: translate_compute(&preprocess(&pack, "composite.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|errors| panic!("{declaration}: {errors:?}"));
    // rust: assert_eq!(program.work_groups, Some(expected), "{declaration}");
    // rust: assert_eq!(program.work_groups_render, [1.0, 1.0]);
}
}

compute_dispatch_splats_relative_vector_constants :: proc() {
}
    // rust: for (declaration, expected) in [
    // rust: ("const vec2 workGroupsRender = vec2(0.5);", [0.5, 0.5]),
    // rust: ("const vec3 workGroupsRender = vec3(0.25);", [0.25, 0.25]),
    // rust: (
    // rust: "const vec2 workGroupsRender = vec2(0.25, 0.75);",
    // rust: [0.25, 0.75],
    // rust: ),
    // rust: ("", [1.0, 1.0]),
    // rust: ] {
    // rust: let source = format!(
    // rust: "#version 430\nlayout(local_size_x=1) in;\n{declaration}\nvoid main(){{}}\n"
    // rust: );
    // rust: let pack =
    // rust: Pack::from_zip_bytes("dispatch.zip", zip(&[("shaders/composite.csh", &source)]))
    // rust: .unwrap();
    // rust: let program =
    // rust: translate_compute(&preprocess(&pack, "composite.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|errors| panic!("{declaration}: {errors:?}"));
    // rust: assert_eq!(program.work_groups_render, expected, "{declaration}");
    // rust: assert_eq!(program.work_groups, None);
}
}

    // Core matrix state and compatibility matrix state describe the same geometry transform.
gbuffers_core_matrices_use_frame_state :: proc() {
}
    // rust: for declaration in ["", "uniform mat4 projectionMatrix, modelViewMatrix;"] {
    // rust: for profile in ["330 compatibility", "330 core"] {
    // rust: let source = format!(
    // rust: "#version {profile}\n{declaration}\nin vec3 vaPosition;\nvoid main() {{ gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0); }}\n"
    // rust: );
    // rust: let p = core_matrix_program(&source, false).unwrap();
    // rust: for name in ["projectionMatrix", "modelViewMatrix"] {
    // rust: assert!(!p.interface.uniforms.iter().any(|u| u.name == name));
}
    // rust: for name in ["gbufferProjection", "gbufferModelView"] {
    // rust: assert!(p.interface.uniforms.iter().any(|u| u.name == name));
}
}
}
}

    // `normalMatrix` follows the geometry's transform in a core-profile gbuffers stage and stays
    // a uniform of the frame (zero) in a compatibility-profile one, as our #9136 probe's Iris
    // 1.11.7 pictures show at these four `#version` lines.
core_normal_matrix_uses_frame_state_in_the_core_profile_only :: proc() {
}
    // rust: for (profile, core) in [
    // rust: ("330 core", true),
    // rust: ("330", true),
    // rust: ("150", true),
    // rust: ("330 compatibility", false),
    // rust: ] {
    // rust: let source = format!(
    // rust: "#version {profile}\nuniform mat3 normalMatrix;\nin vec3 vaNormal;\nout vec3 n;\n\
    // rust: void main() {{ n = normalMatrix * vaNormal; gl_Position = vec4(n, 1.0); }}\n"
    // rust: );
    // rust: let p = core_matrix_program(&source, false).unwrap();
    // rust: let uniform = p
    // rust: .interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .any(|u| u.name == "normalMatrix");
    // rust: assert_eq!(uniform, !core, "{profile}");
}
}

    // `textureMatrix` in the vertex stage is the texture matrix state, not a frame uniform the
    // game has no value for; the fragment stage's own one keeps its slot (Iris 1.11.7 reads
    // zero there in our probe, #9080).
vertex_texture_matrix_is_not_a_frame_uniform :: proc() {
}
    // rust: let vertex = "#version 460 core\nuniform mat4 textureMatrix;\nin vec2 vaUV0;\nout vec2 uv;\n\
    // rust: void main() { uv = mat2(textureMatrix) * vaUV0 + textureMatrix[3].xy; gl_Position = vec4(1.0); }";
    // rust: let p = core_matrix_program(vertex, false).unwrap();
    // rust: assert!(
    // rust: !p.interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .any(|u| u.name == "textureMatrix")
    // rust: );
    // rust: let fragment = "#version 460 core\nuniform mat4 textureMatrix;\nout vec4 color;\n\
    // rust: void main() { color = textureMatrix[0]; }";
    // rust: let files = [
    // rust: ("shaders/gbuffers_terrain.vsh", vertex),
    // rust: ("shaders/gbuffers_terrain.fsh", fragment),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("texture-matrix.zip", zip(&files)).unwrap();
    // rust: let macros = Macros::standard();
    // rust: let p = translate_gbuffers(
    // rust: &preprocess(&pack, "gbuffers_terrain.vsh", &macros),
    // rust: &preprocess(&pack, "gbuffers_terrain.fsh", &macros),
    // rust: Target::Buffers,
    // rust: &GbuffersInputs::default(),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: p.interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .any(|u| u.name == "textureMatrix" && u.ty == "mat4")
    // rust: );
}

core_matrix_aliases_preserve_authored_names_and_errors :: proc() {
}
    // rust: for declarations in [
    // rust: "mat4 projectionMatrix = mat4(2.0), modelViewMatrix = mat4(3.0);",
    // rust: "mat4 projectionMatrix; mat4 modelViewMatrix;",
    // rust: "const mat4 projectionMatrix = mat4(2.0), modelViewMatrix = mat4(3.0);",
    // rust: "uniform mat4 projectionMatrix, modelViewMatrix;",
    // rust: ] {
    // rust: let source = format!(
    // rust: "#version 330\n{declarations}\n\
S :: struct {
    // rust: vec4 local(mat4 projectionMatrix, mat4 modelViewMatrix) {{\n\
    // rust: return projectionMatrix * modelViewMatrix * vec4(1.0); }}\n\
    // rust: void main() {{\n\
    // rust: S s; s.projectionMatrix = mat4(1.0); s.modelViewMatrix = mat4(1.0);\n\
    // rust: vec4 p = projectionMatrix * modelViewMatrix * vec4(1.0);\n\
    // rust: {{ mat4 projectionMatrix = modelViewMatrix; p += projectionMatrix * vec4(1.0); }}\n\
    // rust: for (int modelViewMatrix = 0; modelViewMatrix < 2; modelViewMatrix++) p.x += float(modelViewMatrix);\n\
    // rust: gl_Position = p + local(s.projectionMatrix, s.modelViewMatrix); }}"
    // rust: );
    // rust: core_matrix_program(&source, false).unwrap_or_else(|e| panic!("{declarations}: {e:?}"));
}
    // rust: core_matrix_program(
    // rust: "#version 330\nmat4 projectionMatrix() { return mat4(2.0); }\nvoid main() { gl_Position = projectionMatrix() * modelViewMatrix * vec4(1.0); }", false,
    // rust: ).unwrap();
    // rust: let unknown = core_matrix_program(
    // rust: "#version 330\nvoid main() { gl_Position = unknownMatrix * vec4(1.0); }",
    // rust: false,
    // rust: )
    // rust: .err()
    // rust: .unwrap();
    // rust: assert!(unknown.iter().any(|e| e.message.contains("unknownMatrix")));
    // rust: let shadow = core_matrix_program(
    // rust: "#version 330\nvoid main() { gl_Position = projectionMatrix * modelViewMatrix * vec4(1.0); }", true,
    // rust: ).unwrap();
    // rust: for name in ["shadowProjection", "shadowModelView"] {
    // rust: assert!(shadow.interface.uniforms.iter().any(|u| u.name == name));
}
        // Composite shaders have their own transform; undeclared core names stay errors.
    // rust: let composite = program(
    // rust: &[
    // rust: (
    // rust: "composite.vsh",
    // rust: "#version 330\nvoid main() { gl_Position = projectionMatrix * vec4(1.0); }",
    // rust: ),
    // rust: (
    // rust: "composite.fsh",
    // rust: "#version 330\nout vec4 c; void main() { c = vec4(1.0); }",
    // rust: ),
    // rust: ],
    // rust: Target::Buffers,
    // rust: )
    // rust: .err()
    // rust: .unwrap();
    // rust: assert!(
    // rust: composite
    // rust: .iter()
    // rust: .any(|e| e.message.contains("projectionMatrix"))
    // rust: );
}

core_matrix_program :: proc(source: string, shadow: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let files = [
    // rust: ("shaders/gbuffers_line.vsh", source),
    // rust: (
    // rust: "shaders/gbuffers_line.fsh",
    // rust: "#version 330\nout vec4 color; void main() { color = vec4(1.0); }",
    // rust: ),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("core-matrices.zip", zip(&files)).unwrap();
    // rust: let macros = Macros::standard();
    // rust: let vertex = preprocess(&pack, "gbuffers_line.vsh", &macros);
    // rust: let fragment = preprocess(&pack, "gbuffers_line.fsh", &macros);
    // rust: let inputs = GbuffersInputs {
    // rust: body: "hz_Vertex = vec4(0.25, 0.5, -2.0, 1.0);".into(),
    // rust: attributes: vec![("vaPosition".into(), "hz_Vertex.xyz".into())],
    // rust: ..Default::default()
}
    // rust: if shadow {
    // rust: translate_shadow(&vertex, &fragment, &inputs)
    // rust: } else {
    // rust: translate_gbuffers(&vertex, &fragment, Target::Buffers, &inputs)
}
}

compute_dispatch_does_not_guess_unsupported_scalar_expressions :: proc() {
}
    // rust: for declaration in [
    // rust: "const ivec3 workGroups = ivec3(-1);",
    // rust: "const vec2 workGroupsRender = vec2(-0.5);",
    // rust: "const ivec3 workGroups = ivec3(int(1.0));",
    // rust: ] {
    // rust: let source = format!(
    // rust: "#version 430\nlayout(local_size_x=1) in;\n{declaration}\nvoid main(){{}}\n"
    // rust: );
    // rust: let pack =
    // rust: Pack::from_zip_bytes("dispatch.zip", zip(&[("shaders/composite.csh", &source)]))
    // rust: .unwrap();
    // rust: assert!(
    // rust: translate_compute(&preprocess(&pack, "composite.csh", &Macros::standard()))
    // rust: .is_err(),
    // rust: "{declaration}"
    // rust: );
}
}
//     use crate::pack::tests::zip;
//     use crate::{Macros, Pack, preprocess};

program :: proc(files: ^[(string) {
}
    // rust: let files: Vec<(String, &str)> = files
    // rust: .iter()
    // rust: .map(|(p, t)| (format!("shaders/{p}"), *t))
    // rust: .collect();
    // rust: let files: Vec<(&str, &str)> = files.iter().map(|(p, t)| (p.as_str(), *t)).collect();
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let m = Macros::standard();
    // rust: translate_composite(
    // rust: &preprocess(&pack, "composite.vsh", &m),
    // rust: &preprocess(&pack, "composite.fsh", &m),
    // rust: target,
    // rust: )
}

VSH_120 :: "#version 120\nvarying vec2 texcoord;\nvoid main() {\n    gl_Position = ftransform()
    // rust: texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;\n}\n";

mixed_type_array_constructor_arguments_validate :: proc() {
}
        // Drivers take these; naga composed them unconverted ("Composing 0's component type").
    // rust: for body in [
    // rust: "int k[2] = int[2](1u, 2); return float(k[1]);",
    // rust: "float k[] = float[](1u, 2); return k[1];",
    // rust: "uint k[2] = uint[2](1.0, 2); return float(k[1]);",
    // rust: "vec2 k[2] = vec2[](ivec2(1), texcoord); return k[1].x;",
    // rust: ] {
    // rust: let fsh = format!(
    // rust: "#version 120\nvarying vec2 texcoord;\nfloat n2d() {{ {body} }}\nvoid main() {{ gl_FragColor = vec4(n2d()); }}\n"
    // rust: );
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", &fsh)],
    // rust: Target::Window,
    // rust: );
    // rust: assert!(p.is_ok(), "{body}: {:?}", p.err());
}
}

mixed_type_constructor_arguments_validate :: proc() {
}
        // Each kind of constructor and call, with arguments drivers convert (spec 5.4).
    // rust: let cases = [
    // rust: ("", "vec3 k = vec3(1u, 2, texcoord.x); return k.x;"),
    // rust: ("", "ivec2 k = ivec2(1u, 2.0); return float(k.x);"),
    // rust: ("", "mat2 m = mat2(1u, 2, texcoord.x, 4.0); return m[0].x;"),
    // rust: (
    // rust: "struct S { int a; float b; vec2 c; };\n",
    // rust: "S s = S(1u, 2, ivec2(3)); return s.b;",
    // rust: ),
    // rust: (
    // rust: "struct S { uint a; float b; };\n",
    // rust: "S s = S(1.0, 2); return s.b;",
    // rust: ),
    // rust: (
    // rust: "float h(float x, int y) { return x + float(y); }\n",
    // rust: "return h(1, 2);",
    // rust: ),
    // rust: ];
    // rust: let mut bad = Vec::new();
    // rust: for (decl, body) in cases {
    // rust: let fsh = format!(
    // rust: "#version 120\nvarying vec2 texcoord;\n{decl}float n2d() {{ {body} }}\nvoid main() {{ gl_FragColor = vec4(n2d()); }}\n"
    // rust: );
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", &fsh)],
    // rust: Target::Window,
    // rust: );
    // rust: if let Err(e) = p {
    // rust: bad.push(format!("{body}: {:?}", e.first().map(|e| &e.message)));
}
}
    // rust: assert!(bad.is_empty(), "{}", bad.join("\n"));
}

compatibility_programs_translate :: proc() {
}
    // rust: let fsh = "#version 120\nuniform sampler2D colortex0;\nuniform sampler2D depthtex0;\nuniform float viewWidth;\n\
    // rust: uniform bool hideGUI;\nuniform int frameCounter;\nvarying vec2 texcoord;\n\
    // rust: vec3 tint(sampler2D s, vec2 c) { return texture2D(s, c).rgb; }\nvoid main() {\n    \
    // rust: vec3 c = tint(colortex0, texcoord) * texture2D(depthtex0, texcoord).r;\n    if (hideGUI) c *= 0.5;\n    \
    // rust: /* DRAWBUFFERS:04 */\n    gl_FragData[0] = vec4(c, 1.0);\n    gl_FragData[1] = vec4(frameCounter / viewWidth);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap();
    // rust: let i = &p.interface;
    // rust: let samplers: Vec<(&str, u32)> = i
    // rust: .samplers
    // rust: .iter()
    // rust: .map(|s| (s.name.as_str(), s.binding))
    // rust: .collect();
    // rust: assert_eq!(samplers, [("colortex0", 1), ("depthtex0", 3)]);
    // rust: let uniforms: Vec<(&str, &str)> = i
    // rust: .uniforms
    // rust: .iter()
    // rust: .map(|u| (u.name.as_str(), u.ty.as_str()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: uniforms,
    // rust: [
    // rust: ("hz_target", "vec4"),
    // rust: ("hz_fog_color", "vec4"),
    // rust: ("hz_fog", "vec4"),
    // rust: ("hz_depth_linear", "vec4"),
    // rust: ("frameCounter", "int"),
    // rust: ("hideGUI", "bool"),
    // rust: ("viewWidth", "float")
    // rust: ]
    // rust: );
    // rust: assert_eq!(i.uniforms[0].offset, 0);
    // rust: assert!(i.uniform_size >= 28);
    // rust: assert_eq!(i.outputs, [0, 1]);
}

    // naga drops non-constant global initializers: they run in our `main`, one per declarator,
    // converting as GLSL's initialization does.
global_initializers_read_uniforms :: proc() {
}
    // rust: let fsh = "#version 120\nuniform float rainStrength;\nuniform ivec2 atlasSize;\n\
    // rust: vec2 size = atlasSize;\nvec3 a = vec3(rainStrength), b = a * 2.0, c;\n\
    // rust: const float k = rainStrength > 0.5 ? 1.0 : 0.0;\nfloat w[] = float[](rainStrength, 1.0);\n\
    // rust: void main() { c = b; gl_FragColor = vec4(a + c, size.x * k + w[0]); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Window,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // `sqrt` of a negative is undefined in GLSL: in functions it reads zero, as packs written
    // against GL drivers expect at `sqrt(1.0 - y * y)` with y rounding just above 1. A global
    // constant keeps the built-in, so it stays a constant (an array's size here).
sqrt_in_functions_never_takes_a_negative :: proc() {
}
    // rust: let fsh = "#version 120\nconst int n = int(sqrt(16.0));\nfloat w[n];\n\
    // rust: vec2 f(vec2 v) { float y = v.x; return vec2(sqrt(1.0 - y * y), sqrt(v).y); }\n\
    // rust: void main() { w[3] = 1.0; gl_FragColor = vec4(f(vec2(1.0)), w[3], 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Window,
    // rust: )
    // rust: .unwrap();
    // rust: let clamped = p.fragment.functions.iter().any(|(_, f)| {
    // rust: f.expressions.iter().any(|(_, e)| {
    // rust: matches!(e, naga::Expression::Math { fun: naga::MathFunction::Sqrt, arg, .. }
    // rust: if matches!(f.expressions[*arg], naga::Expression::Math { fun: naga::MathFunction::Max, .. }))
    // rust: })
    // rust: });
    // rust: assert!(clamped, "sqrt's argument is clamped at zero");
}

    // #8175: a `bool` member of a `layout(std430)` buffer (GLSL: size and alignment 4) is
    // "not host-shareable" to naga. The shapes packs write: read in a condition, in an
    // expression, written from a comparison, an array of them, beside other members.
bool_members_of_std430_buffers_translate :: proc() {
}
    // rust: let mut failures = Vec::new();
    // rust: for (block, body) in [
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { mat4 matrix; bool flag; };",
    // rust: "if (flag) { gl_FragColor = vec4(1.0); } else { gl_FragColor = vec4(0.0); }",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bool flag; };",
    // rust: "gl_FragColor = vec4(float(flag), 0.0, 0.0, 1.0);",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { int count; bool flag; } state;",
    // rust: "gl_FragColor = vec4(state.flag ? 1.0 : 0.0, float(state.count), 0.0, 1.0);",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bool flags[4]; };",
    // rust: "gl_FragColor = vec4(flags[2] && !flags[1] ? 1.0 : 0.0, 0.0, 0.0, 1.0);",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { vec2 size; bool flag; };",
    // rust: "flag = size.x > 1.0;
    // rust: gl_FragColor = vec4(size, flag ? 1.0 : 0.0, 1.0);",
    // rust: ),
    // rust: ] {
    // rust: let fsh = format!(
    // rust: "#version 430 compatibility
    // rust: {block}
    // rust: void main() {{
    // rust: {body}
    // rust: }}
    // rust: "
    // rust: );
    // rust: if let Err(e) = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", &fsh)],
    // rust: Target::Buffers,
    // rust: ) {
    // rust: failures.push(format!("`{block}` / `{body}`: {e:?}"));
}
}
    // rust: assert!(
    // rust: failures.is_empty(),
    // rust: "{}",
    // rust: failures.join(
    // rust: "
    // rust: "
    // rust: )
    // rust: );
}

    // #8175: what the rewrite cannot make sure of is refused with the member's name and its
    // line, not left to naga's "Global variable [6] '' is invalid".
bool_buffer_members_that_cannot_be_rewritten_are_named :: proc() {
}
    // rust: for (block, body, wanted) in [
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bool flag; };",
    // rust: "flag |= true;",
    // rust: "`flag`: `|=`",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bool flag; };",
    // rust: "bool other = (flag = true);",
    // rust: "`flag` is assigned inside an expression",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bool flag; };",
    // rust: "bool flag = false;",
    // rust: "`flag` is also declared as a local or parameter",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bvec2 pair; };",
    // rust: "",
    // rust: "`pair`: a `bvec2` is not supported",
    // rust: ),
    // rust: (
    // rust: "layout(std430, binding = 4) buffer State { bool flag; } states[2];",
    // rust: "",
    // rust: "an instance array",
    // rust: ),
    // rust: ] {
    // rust: let fsh = format!(
    // rust: "#version 430 compatibility
    // rust: {block}
    // rust: void main() {{
    // rust: {body}
    // rust: gl_FragColor = vec4(1.0);
    // rust: }}
    // rust: "
    // rust: );
    // rust: let errors = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", &fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .err()
    // rust: .unwrap_or_else(|| panic!("`{body}` translated"));
    // rust: let error = errors
    // rust: .iter()
    // rust: .find(|e| e.message.contains(wanted))
    // rust: .unwrap_or_else(|| panic!("`{wanted}` in {errors:?}"));
    // rust: assert_eq!(error.file, "composite.fsh");
    // rust: assert!(error.line >= 2, "{error:?}");
    // rust: assert!(!error.message.contains("host-shareable"), "{error:?}");
}
}

    // #8175: a compute program reads and writes a `bool` of its buffer too.
bool_members_of_std430_buffers_translate_in_compute_programs :: proc() {
}
    // rust: let source = "#version 430
    // rust: layout(local_size_x = 1) in;
    // rust: layout(std430, binding = 3) buffer State { int count; bool flag; };
    // rust: void main() {
    // rust: flag = count > 2;
    // rust: if (flag) { count = 0; }
}
    // rust: ";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/setup.csh", source)])).unwrap();
    // rust: let stage = crate::preprocess(&pack, "setup.csh", &crate::Macros::standard());
    // rust: let result = crate::translate_compute(&stage);
    // rust: assert!(result.is_ok(), "{:?}", result.err());
}

core_programs_translate :: proc() {
}
    // rust: let vsh = "#version 330 core\nin vec3 vaPosition;\nin vec2 vaUV0;\nuniform mat4 modelViewMatrix, projectionMatrix;\n\
    // rust: out vec2 uv;\nflat out int flatId;\nvoid main() {\n    \
    // rust: gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);\n    uv = vaUV0;\n    flatId = 1;\n}\n";
    // rust: let fsh = "#version 330 core\nin vec2 uv;\nuniform sampler2D colortex0;\nuniform usampler2D colortex5;\n\
    // rust: layout(location = 2) out vec4 color;\nvoid main() {\n    \
    // rust: if (texture(colortex0, uv).a < 0.1) discard;\n    color = texture(colortex0, uv) + float(texelFetch(colortex5, ivec2(gl_FragCoord.xy), 0).r);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    // rust: Target::Window,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(p.interface.outputs, [2]);
    // rust: assert!(
    // rust: p.interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .any(|u| u.name == "projectionMatrix" && u.ty == "mat4")
    // rust: );
}

    // `gl_FogFragCoord` travels from the vertex stage to the fragment stage as a float (MakeUp,
    // E-LITE, VanillAA).
fog_frag_coord_is_a_varying :: proc() {
}
    // rust: let vsh = "#version 120\nvarying vec2 texcoord;\nvoid main() {\n    gl_Position = ftransform();\n    \
    // rust: texcoord = gl_MultiTexCoord0.xy;\n    gl_FogFragCoord = length((gl_ModelViewMatrix * gl_Vertex).xyz);\n}\n";
    // rust: let fsh = "#version 120\nvarying vec2 texcoord;\n\
    // rust: void main() { gl_FragColor = vec4(vec3(texcoord, gl_FogFragCoord * 0.01), 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
        // Read by the fragment stage without the vertex stage writing it: still declared.
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // #8174: the interpolation qualifiers on a varying, in the order and the profile packs write
    // them. The reporter's own two-line pair first; each variant alone, so one failing shows.
interpolation_qualifiers_translate_on_varyings :: proc() {
}
    // rust: let vsh = |version: &str, decl: &str| {
    // rust: format!(
    // rust: "#version {version}
    // rust: {decl}
    // rust: void main() {{
    // rust: texcoord = gl_MultiTexCoord0.xy;
    // rust: gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    // rust: }}
    // rust: "
    // rust: )
}
    // rust: let fsh = |version: &str, decl: &str| {
    // rust: format!(
    // rust: "#version {version}
    // rust: {decl}
    // rust: void main() {{ gl_FragColor = vec4(texcoord, 0.0, 1.0); }}
    // rust: "
    // rust: )
}
    // rust: let mut failures = Vec::new();
    // rust: for version in ["430 compatibility", "330 compatibility", "430"] {
    // rust: for qualifier in [
    // rust: "flat",
    // rust: "smooth",
    // rust: "centroid",
    // rust: "noperspective",
    // rust: "centroid smooth",
    // rust: "flat centroid",
    // rust: "centroid flat",
    // rust: ] {
    // rust: for order in [0, 1] {
    // rust: let (out, input) = if order == 0 {
    // rust: (
    // rust: format!("{qualifier} out vec2 texcoord;"),
    // rust: format!("{qualifier} in vec2 texcoord;"),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: format!("out {qualifier} vec2 texcoord;"),
    // rust: format!("in {qualifier} vec2 texcoord;"),
    // rust: )
}
    // rust: let p = program(
    // rust: &[
    // rust: ("composite.vsh", &vsh(version, &out)),
    // rust: ("composite.fsh", &fsh(version, &input)),
    // rust: ],
    // rust: Target::Buffers,
    // rust: );
    // rust: if let Err(e) = p {
    // rust: failures.push(format!("{version}: `{out}` / `{input}`: {e:?}"));
}
}
}
}
    // rust: assert!(
    // rust: failures.is_empty(),
    // rust: "{}",
    // rust: failures.join(
    // rust: "
    // rust: "
    // rust: )
    // rust: );
}

    // #8174: the same qualifiers on the members of an interface block, which is how packs with
    // a `dimensions/` folder pass their varyings. Before #6875 the members' `flat` reached naga
    // as "Expected Void, Struct or a type, found Interpolation(Flat)".
interpolation_qualifiers_translate_on_interface_block_members :: proc() {
}
    // rust: let mut failures = Vec::new();
    // rust: for member in [
    // rust: "flat vec2 texcoord;",
    // rust: "flat int id; vec2 texcoord;",
    // rust: "smooth vec2 texcoord;",
    // rust: "centroid vec2 texcoord;",
    // rust: "noperspective vec2 texcoord;",
    // rust: "flat centroid vec2 texcoord;",
    // rust: "centroid flat vec2 texcoord;",
    // rust: "flat sample vec2 texcoord;",
    // rust: "sample flat vec2 texcoord;",
    // rust: "layout(location = 1) flat vec2 texcoord;",
    // rust: ] {
    // rust: let id_out = if member.contains("int id") {
    // rust: "    vOut.id = 1;
    // rust: "
    // rust: } else {
    // rust: ""
}
    // rust: let vsh = format!(
    // rust: "#version 430 compatibility
    // rust: out VertexData {{ {member} }} vOut;
    // rust: void main() {{
    // rust: {id_out}                     vOut.texcoord = gl_MultiTexCoord0.xy;
    // rust: gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    // rust: }}
    // rust: "
    // rust: );
    // rust: let fsh = format!(
    // rust: "#version 430 compatibility
    // rust: in VertexData {{ {member} }} vIn;
    // rust: void main() {{ gl_FragColor = vec4(vIn.texcoord, 0.0, 1.0); }}
    // rust: "
    // rust: );
    // rust: if let Err(e) = program(
    // rust: &[("composite.vsh", &vsh), ("composite.fsh", &fsh)],
    // rust: Target::Buffers,
    // rust: ) {
    // rust: failures.push(format!("`{member}`: {e:?}"));
}
}
    // rust: assert!(
    // rust: failures.is_empty(),
    // rust: "{}",
    // rust: failures.join(
    // rust: "
    // rust: "
    // rust: )
    // rust: );
}

frag_coord_is_set_for_every_target :: proc() {
}
    // rust: let fsh = "#version 120\nvoid main() { gl_FragColor = vec4(gl_FragCoord.x); }\n";
    // rust: for target in [Target::Buffers, Target::Window] {
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: target,
    // rust: )
    // rust: .unwrap();
    // rust: let m = &p.fragment;
    // rust: let (handle, _) = m
    // rust: .global_variables
    // rust: .iter()
    // rust: .find(|(_, g)| g.name.as_deref() == Some("hz_FragCoord"))
    // rust: .unwrap();
            // naga calls our `main` from its entry point: look in every function.
    // rust: let functions = m.functions.iter().map(|(_, f)| f);
    // rust: let stores = functions.chain([&m.entry_points[0].function]).any(|f| {
    // rust: f.body.iter().any(|s| match s {
    // rust: naga::Statement::Store { pointer, .. } => {
    // rust: matches!(f.expressions[*pointer], naga::Expression::GlobalVariable(h) if h == handle)
}
    // rust: _ => false,
    // rust: })
    // rust: });
    // rust: assert!(stores, "{target:?}: main does not set hz_FragCoord");
}
}

    // Code after an unconditional `discard` (BSL's `gbuffers_clouds` with its own clouds on)
    // or `return;` still makes a valid module.
code_after_discard_or_return_translates :: proc() {
}
    // rust: let vsh = "#version 120\nvoid main() { gl_Position = ftransform(); }\n";
    // rust: for fsh in [
    // rust: "#version 120\nuniform sampler2D texture;\nvoid main() {\n    discard;\n    vec4 c = texture2D(texture, vec2(0.5));\n    gl_FragData[0] = c;\n}\n",
    // rust: "#version 120\nvoid main() {\n    gl_FragData[0] = vec4(1.0);\n    return;\n    gl_FragData[0] = vec4(0.5);\n}\n",
    // rust: ] {
    // rust: let files = [
    // rust: ("shaders/gbuffers_clouds.vsh", vsh),
    // rust: ("shaders/gbuffers_clouds.fsh", fsh),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let m = Macros::standard();
    // rust: let inputs = GbuffersInputs {
    // rust: body: "    hz_Vertex = vec4(0.0, 0.0, 0.0, 1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: translate_gbuffers(
    // rust: &preprocess(&pack, "gbuffers_clouds.vsh", &m),
    // rust: &preprocess(&pack, "gbuffers_clouds.fsh", &m),
    // rust: Target::Buffers,
    // rust: &inputs,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{fsh}: {e:?}"));
}
}

the_alpha_test_discards_below_its_reference :: proc() {
}
    // rust: assert_eq!(
    // rust: AlphaTest::parse("GREATER 0.1"),
    // rust: Some(Some(AlphaTest {
    // rust: op: ">",
    // rust: reference: 0.1
    // rust: }))
    // rust: );
    // rust: assert_eq!(AlphaTest::parse("off"), Some(None));
    // rust: assert_eq!(AlphaTest::parse("GL_ALWAYS 0"), Some(None));
    // rust: assert_eq!(AlphaTest::parse("SOMETIMES 0.5"), None);
    // rust: let vsh = "#version 120\nvoid main() { gl_Position = ftransform(); }\n";
    // rust: let legacy = "#version 120\nvoid main() { gl_FragData[0] = vec4(0.5); }\n";
    // rust: let outs =
    // rust: "#version 330\nlayout(location = 0) out vec4 c;\nvoid main() { c = vec4(0.5); }\n";
    // rust: for (fsh, kills) in [(legacy, true), (outs, false)] {
    // rust: let files = [
    // rust: ("shaders/gbuffers_entities.vsh", vsh),
    // rust: ("shaders/gbuffers_entities.fsh", fsh),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let m = Macros::standard();
    // rust: let inputs = GbuffersInputs {
    // rust: body: "    hz_Vertex = vec4(0.0, 0.0, 0.0, 1.0);\n".into(),
    // rust: alpha_test: AlphaTest::parse("GREATER 0.1").unwrap(),
    // rust: ..Default::default()
}
    // rust: let p = translate_gbuffers(
    // rust: &preprocess(&pack, "gbuffers_entities.vsh", &m),
    // rust: &preprocess(&pack, "gbuffers_entities.fsh", &m),
    // rust: Target::Buffers,
    // rust: &inputs,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let functions = p.fragment.functions.iter().map(|(_, f)| f);
    // rust: let kill = functions
    // rust: .chain([&p.fragment.entry_points[0].function])
    // rust: .any(|f| format!("{:?}", f.body).contains("Kill"));
            // With `out` variables the pack tests alpha itself.
    // rust: assert_eq!(kill, kills, "{fsh}");
}
}

gbuffers_programs_read_the_games_vertices :: proc() {
}
    // rust: let vsh = "#version 120\nattribute vec4 mc_Entity;\nattribute vec2 mc_midTexCoord;\nvarying vec2 uv;\nvarying vec2 light;\n\
    // rust: varying vec4 color;\nvarying vec3 normal;\nvarying float id;\nvoid main() {\n    \
    // rust: gl_Position = ftransform();\n    uv = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;\n    \
    // rust: light = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;\n    color = gl_Color;\n    \
    // rust: normal = normalize(gl_NormalMatrix * gl_Normal);\n    id = mc_Entity.x + mc_midTexCoord.x;\n}\n";
    // rust: let fsh = "#version 120\nuniform sampler2D texture;\nuniform sampler2D lightmap;\nuniform mat4 gbufferModelView;\n\
    // rust: uniform int renderStage;\nvarying vec2 uv;\nvarying vec2 light;\nvarying vec4 color;\nvarying vec3 normal;\nvarying float id;\n\
    // rust: void main() {\n    vec4 c = texture2D(texture, uv) * texture2D(lightmap, light) * color;\n    \
    // rust: /* DRAWBUFFERS:02 */\n    gl_FragData[0] = c * gl_FragCoord.z * float(renderStage);\n    \
    // rust: gl_FragData[1] = vec4(normal * 0.5 + 0.5, id);\n}\n";
    // rust: let files: Vec<(String, &str)> =
    // rust: [("gbuffers_terrain.vsh", vsh), ("gbuffers_terrain.fsh", fsh)]
    // rust: .iter()
    // rust: .map(|(p, t)| (format!("shaders/{p}"), *t))
    // rust: .collect();
    // rust: let files: Vec<(&str, &str)> = files.iter().map(|(p, t)| (p.as_str(), *t)).collect();
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let m = Macros::standard();
    // rust: let game = GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 game_pos;\nlayout(location = 1) in uvec2 game_uv;".into(),
    // rust: body: "    hz_Vertex = vec4(game_pos, 1.0);\n    hz_MultiTexCoord0 = vec4(vec2(game_uv) / 32768.0, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(240.0, 240.0, 0.0, 1.0);\n    hz_Color = vec4(1.0);\n    hz_Normal = vec3(0.0, 1.0, 0.0);\n"
    // rust: .into(),
    // rust: attributes: vec![("mc_midTexCoord".into(), "vec2(game_uv) / 32768.0".into())],
    // rust: ..Default::default()
}
    // rust: let p = translate_gbuffers(
    // rust: &preprocess(&pack, "gbuffers_terrain.vsh", &m),
    // rust: &preprocess(&pack, "gbuffers_terrain.fsh", &m),
    // rust: Target::Buffers,
    // rust: &game,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let names: Vec<&str> = p
    // rust: .interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .map(|u| u.name.as_str())
    // rust: .collect();
    // rust: for name in [
    // rust: "gbufferModelView",
    // rust: "gbufferProjection",
    // rust: "gbufferModelViewInverse",
    // rust: ] {
    // rust: assert!(names.contains(&name), "{name} missing from {names:?}");
}
    // rust: assert_eq!(p.interface.outputs, vec![0, 1]);
        // renderStage is set per draw, in its own block.
    // rust: assert!(p.interface.draw && !names.contains(&"renderStage"));
    // rust: let per_draw = p.fragment.global_variables.iter().any(|(_, v)| {
    // rust: v.binding
    // rust: .as_ref()
    // rust: .is_some_and(|b| b.group == 2 && b.binding == 0)
    // rust: });
    // rust: assert!(per_draw);
    // rust: let inputs: Vec<&str> = p.vertex.entry_points[0]
    // rust: .function
    // rust: .arguments
    // rust: .iter()
    // rust: .filter_map(|a| a.name.as_deref())
    // rust: .collect();
    // rust: assert!(
    // rust: inputs.contains(&"game_pos") && inputs.contains(&"game_uv"),
    // rust: "{inputs:?}"
    // rust: );
        // From the light, the compatibility matrices are the shadow camera's.
    // rust: let shadow = translate_shadow(
    // rust: &preprocess(&pack, "gbuffers_terrain.vsh", &m),
    // rust: &preprocess(&pack, "gbuffers_terrain.fsh", &m),
    // rust: &game,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let names: Vec<&str> = (shadow.interface.uniforms.iter())
    // rust: .map(|u| u.name.as_str())
    // rust: .collect();
    // rust: for name in ["shadowModelView", "shadowProjection", "gbufferModelView"] {
    // rust: assert!(names.contains(&name), "{name} missing from {names:?}");
}
}

matrix_and_array_varyings_travel_in_parts :: proc() {
}
    // rust: let vsh = "#version 120\nvarying mat3 tbn;\nflat varying ivec2 ids[2];\nvarying mat2x3 m[2];\n\
    // rust: void main() {\n    gl_Position = ftransform();\n    tbn = mat3(2.0);\n    \
    // rust: ids[1] = ivec2(3);\n    m[1][0] = vec3(4.0);\n}\n";
    // rust: let fsh = "#version 120\nvarying mat3 tbn;\nflat varying ivec2 ids[2];\nvarying mat2x3 m[2];\n\
    // rust: void main() { gl_FragColor = vec4(tbn[2] + m[1][0], float(ids[1].x)); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let inputs = p.fragment.entry_points[0].function.arguments.len();
        // 3 columns + 2 elements + 2 x 2 columns, and the fragment position.
    // rust: assert!(inputs >= 9, "{inputs} inputs");
    // rust: assert_eq!(
    // rust: varying_parts("flat ivec2 @[2];").unwrap().1,
    // rust: [
    // rust: ("flat ivec2 @;".to_owned(), "[0]".to_owned()),
    // rust: ("flat ivec2 @;".to_owned(), "[1]".to_owned())
    // rust: ]
    // rust: );
    // rust: assert_eq!(varying_parts("mat2x3 @[2];").unwrap().1[3].1, "[1][1]");
    // rust: assert!(varying_parts("vec4 @;").is_none());
    // rust: assert!(varying_parts("vec4 @[N];").is_none());
}

sized_array_types_initialize_globals :: proc() {
}
    // rust: let fsh = "#version 400\nuniform float k;\nivec3[2] offsets = ivec3[](ivec3(1, 0, 0), ivec3(0, int(k), 0));\n\
    // rust: out vec4 c;\nvoid main() { c = vec4(offsets[1], 1.0); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

struct_varyings_travel_packed :: proc() {
}
    // rust: let lib = "struct Light { vec3 color; float power; int id; mat2 m; float k[2]; };\n";
    // rust: let vsh = "#version 400\n#include \"/lib.glsl\"\nflat out Light light;\nvoid main() {\n    \
    // rust: gl_Position = ftransform();\n    light.color = vec3(1.0);\n    light.id = 2;\n}\n";
    // rust: let fsh = "#version 400\n#include \"/lib.glsl\"\nflat in Light light;\nout vec4 c;\n\
    // rust: void main() { c = vec4(light.color * light.power * light.m[1].x * light.k[1], float(light.id)); }\n";
    // rust: let p = program(
    // rust: &[
    // rust: ("lib.glsl", lib),
    // rust: ("composite.vsh", vsh),
    // rust: ("composite.fsh", fsh),
    // rust: ],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
        // color and power, the matrix's columns, the array, and the int: four slots.
    // rust: let inputs = p.fragment.entry_points[0].function.arguments.len();
    // rust: assert_eq!(inputs, 4, "{inputs} inputs");
    // rust: let structs = std::collections::HashMap::from([(
    // rust: "S".to_owned(),
    // rust: vec![
    // rust: ("vec3".to_owned(), "a".to_owned()),
    // rust: ("int".to_owned(), "i".to_owned()),
    // rust: ("float".to_owned(), "b[2]".to_owned()),
    // rust: ],
    // rust: )]);
    // rust: assert_eq!(
    // rust: struct_parts("S @;", &structs).unwrap(),
    // rust: [
    // rust: (
    // rust: "vec4 @;".to_owned(),
    // rust: vec![
    // rust: (".xyz".to_owned(), ".a".to_owned()),
    // rust: (".w".to_owned(), ".b[0]".to_owned())
    // rust: ]
    // rust: ),
    // rust: (
    // rust: "flat int @;".to_owned(),
    // rust: vec![(String::new(), ".i".to_owned())]
    // rust: ),
    // rust: (
    // rust: "float @;".to_owned(),
    // rust: vec![(String::new(), ".b[1]".to_owned())]
    // rust: ),
    // rust: ]
    // rust: );
    // rust: let bools = std::collections::HashMap::from([(
    // rust: "B".to_owned(),
    // rust: vec![("bool".to_owned(), "b".to_owned())],
    // rust: )]);
    // rust: assert!(struct_parts("B @;", &bools).is_none());
}

vulkan_type_names_are_free_names :: proc() {
}
    // rust: let fsh = "#version 400\nuniform sampler2D colortex0;\nout vec4 c;\n\
    // rust: vec4 fetch(sampler2D sampler, vec2 p) { return texture(sampler, p); }\n\
    // rust: void main() { float texture2D = 1.0; c = fetch(colortex0, vec2(0.5)) * texture2D; }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

gathers_and_vertex_texture_reads_translate :: proc() {
}
    // rust: let vsh = "#version 400\nuniform sampler2D colortex1;\nout vec3 tint;\nvoid main() {\n    \
    // rust: gl_Position = ftransform();\n    tint = texture(colortex1, vec2(0.5)).rgb;\n}\n";
    // rust: let fsh = "#version 400\nuniform sampler2D colortex1;\nuniform sampler2D depthtex0;\nin vec3 tint;\nout vec4 c;\n\
S :: struct {
    // rust: void main() {\n    const S s = S(float[2](1.0, 2.0));\n    \
    // rust: vec4 d = textureGather(depthtex0, vec2(0.5)) + textureGather(colortex1, vec2(0.5), 3);\n    \
    // rust: c = vec4(tint * vec3(d.x > 0.5) * s.k[1], float(ivec2(d.xy) % 2));\n}\n";
    // rust: program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    Target: :Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

fields_and_elements_as_out_arguments_write_spirv :: proc() {
}
    // rust: let fsh = "#version 330\nstruct S { float a; vec2 b; };\nvoid f(out float x) { x = 0.5; }\n\
    // rust: void main() { S s; float arr[2]; f(s.a); f(arr[1]); f(s.b.y);\n\
    // rust: gl_FragData[0] = vec4(s.a, arr[1], s.b.y, 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: for module in [&p.vertex, &p.fragment] {
    // rust: let info = Validator::new(ValidationFlags::all(), Capabilities::all())
    // rust: .validate(module)
    // rust: .unwrap();
    // rust: let entry = &module.entry_points[0];
    // rust: let pipeline = naga::back::spv::PipelineOptions {
    // rust: shader_stage: entry.stage,
    // rust: entry_point: entry.name.clone(),
}
    // rust: naga::back::spv::write_vec(module, &info, &Default::default(), Some(&pipeline))
    // rust: .unwrap();
}
}

    // `textureGatherOffsets` (GLSL 4.60, 8.9.4), which naga lacks: offsets from a `const`
    // array or a constructor, a component, an unsigned texture and the depth compare form, in a
    // pack function that takes the sampler too; every form must reach SPIR-V.
shadow_depth_reads_through_a_plain_sampler_translate :: proc() {
}
        // One function given a colour buffer and a shadow depth, direct reads with a level, a
        // texel offset and a projection, and a local named like a depth sampler elsewhere.
    // rust: let fsh = "#version 330 compatibility\nuniform sampler2D colortex0;\n\
    // rust: uniform sampler2D shadowtex1;\nuniform sampler2D shadow;\n\
    // rust: vec4 tap(sampler2D s, vec2 p) {\n    \
    // rust: return texture2D(s, p) + texture2DLod(s, p, 0.0) + texture2DProj(s, vec3(p, 1.0));\n}\n\
    // rust: float lit(vec2 p) { float shadow = texture2D(shadowtex1, p).r; return shadow * 0.5; }\n\
    // rust: void main() {\n    vec2 uv = gl_FragCoord.xy / 64.0;\n    \
    // rust: gl_FragData[0] = tap(colortex0, uv) + tap(shadowtex1, uv) + texture(shadow, uv)\n        \
    // rust: + textureOffset(shadow, uv, ivec2(1, 0)) + textureProj(shadow, vec4(uv, 0.0, 1.0))\n        \
    // rust: + vec4(lit(uv));\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let info = Validator::new(ValidationFlags::all(), Capabilities::all())
    // rust: .validate(&p.fragment)
    // rust: .unwrap();
    // rust: let entry = &p.fragment.entry_points[0];
    // rust: let pipeline = naga::back::spv::PipelineOptions {
    // rust: shader_stage: entry.stage,
    // rust: entry_point: entry.name.clone(),
}
    // rust: naga::back::spv::write_vec(&p.fragment, &info, &Default::default(), Some(&pipeline))
    // rust: .unwrap();
}

texture_gather_offsets_translate :: proc() {
}
    // rust: let fsh = "#version 430\nuniform sampler2D colortex0;\nuniform usampler2D colortex5;\n\
    // rust: uniform sampler2DShadow shadowtex0;\nout vec4 c;\n\
    // rust: const ivec2 ring[4] = ivec2[4](ivec2(-1, 0), ivec2(1, 0), ivec2(0, -1), ivec2(0, 1));\n\
    // rust: float edge(sampler2D s, vec2 uv) { return textureGatherOffsets(s, uv, ring, 3).x; }\n\
    // rust: void main() {\n    vec2 uv = gl_FragCoord.xy / 64.0;\n    \
    // rust: vec4 a = textureGatherOffsets(colortex0, uv, ring);\n    \
    // rust: uvec4 b = textureGatherOffsets(colortex5, uv,\n        \
    // rust: ivec2[4](ivec2(0), ivec2(2, 0), ivec2(0, 2), ivec2(2)), 1);\n    \
    // rust: vec4 d = textureGatherOffsets(shadowtex0, uv, 0.5, ring);\n    \
    // rust: c = a + vec4(b) + d + edge(colortex0, uv);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let info = Validator::new(ValidationFlags::all(), Capabilities::all())
    // rust: .validate(&p.fragment)
    // rust: .unwrap();
    // rust: let entry = &p.fragment.entry_points[0];
    // rust: let pipeline = naga::back::spv::PipelineOptions {
    // rust: shader_stage: entry.stage,
    // rust: entry_point: entry.name.clone(),
}
    // rust: naga::back::spv::write_vec(&p.fragment, &info, &Default::default(), Some(&pipeline))
    // rust: .unwrap();
        // A program that doesn't call it gets none of it.
    // rust: let plain = program(
    // rust: &[
    // rust: ("composite.vsh", VSH_120),
    // rust: (
    // rust: "composite.fsh",
    // rust: "#version 120\nvoid main() { gl_FragColor = vec4(1.0); }\n",
    // rust: ),
    // rust: ],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: !plain
    // rust: .fragment
    // rust: .functions
    // rust: .iter()
    // rust: .any(|(_, f)| f.name.as_deref() == Some("hz_textureGatherOffsets"))
    // rust: );
}

    // `textureQueryLod` (GLSL 4.60, 8.9.1), which naga lacks, on 2D, 3D and integer samplers
    // and through a pack function that takes the sampler: every form reaches SPIR-V, and a
    // program that doesn't call it gets none of it.
texture_query_lod_translates :: proc() {
}
    // rust: let fsh = "#version 430\nuniform sampler2D colortex0;\nuniform sampler3D lut;\n\
    // rust: uniform usampler2D colortex5;\nout vec4 c;\n\
    // rust: float level(sampler2D s, vec2 uv) { return textureQueryLod(s, uv).x; }\n\
    // rust: void main() {\n    vec2 uv = gl_FragCoord.xy / 64.0;\n    \
    // rust: vec2 a = textureQueryLod(colortex0, uv);\n    \
    // rust: vec2 b = textureQueryLod(lut, vec3(uv, 0.5));\n    \
    // rust: vec2 d = textureQueryLod(colortex5, uv);\n    \
    // rust: c = vec4(a + b + d, level(colortex0, uv), 1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let info = Validator::new(ValidationFlags::all(), Capabilities::all())
    // rust: .validate(&p.fragment)
    // rust: .unwrap();
    // rust: let entry = &p.fragment.entry_points[0];
    // rust: let pipeline = naga::back::spv::PipelineOptions {
    // rust: shader_stage: entry.stage,
    // rust: entry_point: entry.name.clone(),
}
    // rust: naga::back::spv::write_vec(&p.fragment, &info, &Default::default(), Some(&pipeline))
    // rust: .unwrap();
    // rust: let plain = program(
    // rust: &[
    // rust: ("composite.vsh", VSH_120),
    // rust: (
    // rust: "composite.fsh",
    // rust: "#version 120\nvoid main() { gl_FragColor = vec4(1.0); }\n",
    // rust: ),
    // rust: ],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: !plain
    // rust: .fragment
    // rust: .functions
    // rust: .iter()
    // rust: .any(|(_, f)| f.name.as_deref() == Some("hz_textureQueryLod"))
    // rust: );
}

    // A `return` with code after it in its block (Miniature's hand: `#ifdef GBUFFERS_HAND
    // return 0.5 * diffuse; #endif` and the rest of the function), which naga's frontend
    // leaves half-built.
early_returns_with_values_translate :: proc() {
}
    // rust: let fsh = "#version 120\nuniform sampler2D shadowtex1;\nuniform mat4 shadowModelView;\n\
    // rust: float len2(vec3 v) { return dot(v, v); }\n\
    // rust: float f(float d, vec3 p) {\n    d *= 2.0;\n    return 0.5 * d;\n    \
    // rust: vec3 q = p * len2(p);\n    vec4 v = shadowModelView * vec4(q, 1.0);\n    \
    // rust: if (dot(q, q) < 4.0 && d > 0.0 && v.z < 1.0) {\n        \
    // rust: float s = texture2D(shadowtex1, v.st).x;\n        return d * s / shadowModelView[2].z;\n    }\n    \
    // rust: return d;\n}\nvoid main() { gl_FragColor = vec4(f(0.5, vec3(1.0))); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // A non-void function whose only `return` has unreachable code after it and no trailing
    // return at the end of the block (which naga would otherwise end with `return;` without a value).
early_return_without_trailing_return_translates :: proc() {
}
    // rust: let fsh = "#version 120\n\
    // rust: vec3 exposure(vec3 color) {\n    return color * 3.5;\n    int x = 1;\n}\n\
    // rust: void main() { gl_FragColor = vec4(exposure(vec3(1.0)), 1.0); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // GLSL's `dot` and `normalize` take a `float` too (genType); naga's take vectors only. A
    // pack's own `dot` is kept.
scalar_dot_and_normalize_translate :: proc() {
}
    // rust: let fsh = "#version 330\nuniform float k;\nout vec4 c;\n\
    // rust: void main() { c = vec4(dot(k, 2.0), normalize(k - 0.5), dot(vec2(k), vec2(1.0)), 1.0); }\n";
    // rust: let own = "#version 330\nuniform float k;\nout vec4 c;\nfloat dot(float a, float b) { return a + b; }\n\
    // rust: void main() { c = vec4(dot(k, 2.0)); }\n";
    // rust: for fsh in [fsh, own] {
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{fsh}: {e:?}"));
}
}

    // GL_AMD_shader_trinary_minmax adds `min3`, `max3` and `mid3` for genType, genIType and
    // genUType; naga has none of them. A pack's own `max3` is kept, with or without the
    // extension (glslangValidator takes both).
trinary_min_max_translate :: proc() {
}
    // rust: let ext = "#extension GL_AMD_shader_trinary_minmax : require\n";
    // rust: let calls = "uniform float k;\nuniform int i;\nuniform uint u;\nout vec4 c;\n\
    // rust: void main() {\n    vec3 v = vec3(k, 0.5, 0.25);\n    \
    // rust: float f = min3(k, 0.5, 0.25) + max3(v.xy, v.yz, v.zx).y + mid3(v, v.yzx, v.zxy).z\n        \
    // rust: + mid3(vec4(k), vec4(0.5), vec4(1.0)).w;\n    \
    // rust: ivec2 n = max3(ivec2(i), ivec2(2), ivec2(-1)) + ivec2(mid3(i, 3, 7), min3(ivec4(i), ivec4(1), ivec4(2)).x);\n    \
    // rust: uvec3 m = min3(uvec3(u), uvec3(2u), uvec3(9u)) + mid3(u, 4u, 8u) + max3(uvec4(u), uvec4(1u), uvec4(5u)).xyz;\n    \
    // rust: c = vec4(f, float(n.x + n.y), float(m.x), mid3(1.0, 2.0, 3.0));\n}\n";
    // rust: let own = "uniform float k;\nout vec4 c;\n\
    // rust: float max3(float a, float b, float c) { return max(a, max(b, c)); }\n\
    // rust: void main() { c = vec4(max3(k, 0.5, 0.25)); }\n";
    // rust: for fsh in [
    // rust: format!("#version 330\n{ext}{calls}"),
    // rust: format!("#version 330\n{ext}{own}"),
    // rust: format!("#version 330\n{own}"),
    // rust: ] {
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", &fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{fsh}: {e:?}"));
}
    // rust: let csh = format!(
    // rust: "#version 430\n{ext}layout(local_size_x = 1) in;\n\
    // rust: layout(std430, binding = 0) buffer B {{ uvec2 data; }} b;\n\
    // rust: void main() {{ b.data = uvec2(max3(b.data.x, 2u, 3u), min3(b.data, uvec2(1u), uvec2(4u)).y); }}\n"
    // rust: );
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/composite.csh", &csh)])).unwrap();
    // rust: translate_compute(&preprocess(&pack, "composite.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // GLSL converts a returned value to the function's type (Kappa's `GetEmissionScale`):
    // `return 1;` in a `float` function, an `int` or `ivec2` returned as `float` or `vec2`.
returns_convert_to_the_function_type :: proc() {
}
    // rust: let fsh = "#version 330\nuniform int k;\nout vec4 c;\n\
    // rust: float one() { return 1; }\nfloat twice(int a) { return a * 2 + 1; }\n\
    // rust: vec2 cell() { ivec2 p = ivec2(k, 3); return p; }\n\
    // rust: float unsigned_value() { uint u = 3u; return u; }\n\
    // rust: float early(float x) {\n    if (x > 0.5) return 2;\n    return x;\n}\n\
    // rust: void main() { c = vec4(one() + twice(k), cell(), unsigned_value() + early(0.7)); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // Returns that are an `if`'s branches, last in a function that returns a value (TAA's
    // `ClipAABB` in BSL, Complementary and Solas): naga ends such tail blocks with a `return`
    // of its own, which must not land in a guard of ours.
returns_as_branches_stay_plain :: proc() {
}
    // rust: let fsh = "#version 120\nuniform float k;\n\
    // rust: vec3 clip(vec3 a, vec3 b) {\n    vec3 d = b - a;\n    \
    // rust: if (k > 1.0) return a + d / k;\n    else return b;\n}\n\
    // rust: float pick(float x) {\n    if (x > 0.5) { return 1.0; }\n    return x;\n}\n\
    // rust: void main() { gl_FragColor = vec4(clip(vec3(0.0), vec3(1.0)), pick(k)); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // A vertex stage that redeclares `gl_PerVertex` and whose block instance shares its name
    // with a function's parameter: it still writes the position, and the
    // block still reaches the fragment stage.
a_per_vertex_redeclaration_and_a_parameter_named_like_the_instance :: proc() {
}
    // rust: let vsh = "#version 460\nout gl_PerVertex { vec4 gl_Position; };\n\
    // rust: float luma(vec3 v) { return dot(v, vec3(0.3, 0.6, 0.1)); }\n\
    // rust: out VertexData {\n    layout(location = 1, component = 0) vec2 coord;\n} v;\n\
    // rust: void main() { v.coord = vec2(luma(vec3(1.0))); gl_Position = vec4(0.0, 0.0, 0.5, 1.0); }\n";
    // rust: let fsh = "#version 460\nin VertexData {\n    layout(location = 1, component = 0) vec2 coord;\n} v;\n\
    // rust: /* RENDERTARGETS: 0 */\nlayout(location = 0) out vec4 c;\n\
    // rust: void main() { c = vec4(v.coord, 0.0, 1.0); }\n";
    // rust: program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // Interface blocks between the stages may give members their own interpolation (GLSL 4.60,
    // 4.3.9; Shrimple's gbuffers programs): a `flat` member arrives flat.
interface_block_members_keep_their_qualifiers :: proc() {
}
    // rust: let vsh = "#version 330 compatibility\nout VertexData {\n    flat int id;\n    vec2 uv;\n} vOut;\n\
    // rust: void main() { gl_Position = ftransform(); vOut.id = 3; vOut.uv = vec2(0.5); }\n";
    // rust: let fsh = "#version 330 compatibility\nin VertexData {\n    flat int id;\n    vec2 uv;\n} vIn;\n\
    // rust: void main() { gl_FragData[0] = vec4(float(vIn.id), vIn.uv, 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let entry = &p.fragment.entry_points[0].function;
    // rust: let mut flats = 0;
    // rust: for arg in &entry.arguments {
    // rust: let bindings: Vec<&naga::Binding> = match &p.fragment.types[arg.ty].inner {
    // rust: naga::TypeInner::Struct { members, .. } => {
    // rust: members.iter().filter_map(|m| m.binding.as_ref()).collect()
}
    // rust: _ => arg.binding.iter().collect(),
}
    // rust: for b in bindings {
    // rust: if let naga::Binding::Location {
    // rust: interpolation: Some(naga::Interpolation::Flat),
    // rust: ..
    // rust: } = b
    // rust: {
    // rust: flats += 1;
}
}
}
    // rust: assert_eq!(flats, 1, "one flat input, `id`");
}

    // A function that returns a value may reach its end without a `return` (GLSL 4.60, 6.1:
    // the value is undefined): after a loop (Lux's `MaxIdx`), an `if` without `else`, a
    // `switch` without `default`; it returns zero there. A function ending in its own
    // `return` keeps it.
functions_reaching_their_end_return_zero :: proc() {
}
    // rust: let fsh = "#version 330\nuniform int k;\nout vec4 c;\n\
S :: struct {
    // rust: float after_loop(float x) {\n    for (int i = 0; i < 4; i++) {\n        \
    // rust: if (x > float(i)) return float(i);\n    }\n}\n\
    // rust: vec3 after_if(float x) { if (x > 0.5) return vec3(x); }\n\
    // rust: int after_switch() { switch (k) { case 0: return 1; case 1: return 2; } }\n\
    // rust: S after_struct(float x) { if (x > 0.5) { return S(x, ivec2(k)); } }\n\
    // rust: float own(float x) { return x * 2.0; }\n\
    // rust: void main() {\n    float x = float(k) * 0.25;\n    \
    // rust: c = vec4(after_loop(x) + after_if(x).x, float(after_switch()), \
    // rust: after_struct(x).a, own(x));\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    Target: :Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let zero_returns = |name: &str| {
    // rust: let (_, f) = (p.fragment.functions.iter())
    // rust: .find(|(_, f)| f.name.as_deref() == Some(name))
    // rust: .unwrap_or_else(|| panic!("{name} missing"));
count :: proc(f: ^naga::Function, b: ^naga::Block) -> u {
    // Ported from Horizon
    return {}
}
    // rust: b.iter()
    // rust: .map(|s| match s {
    naga: :Statement::Return { value: Some(v) } => matches!(,
    // rust: f.expressions[*v],
    naga: :Expression::ZeroValue(t) if Some(t) == f.result.as_ref().map(|r| r.ty),
    // rust: )
    // rust: .into(),
    naga: :Statement::Block(b) => count(f,
    naga: :Statement::If { accept,
    // rust: count(f, accept) + count(f, reject)
}
    // rust: naga::Statement::Switch { cases, .. } => {
    // rust: cases.iter().map(|c| count(f, &c.body)).sum()
}
    // rust: naga::Statement::Loop { body, continuing, .. } => {
    // rust: count(f, body) + count(f, continuing)
}
    // rust: _ => 0,
    // rust: })
    // rust: .sum()
}
    // rust: count(f, &f.body)
}
    // rust: for name in ["after_loop", "after_if", "after_switch", "after_struct"] {
    // rust: assert!(zero_returns(name) > 0, "{name}: its end returns no zero");
}
    // rust: assert_eq!(zero_returns("own"), 0, "own: its own return was replaced");
}

    // A function may be declared again (GLSL 4.60, 6.1), before or after its definition: Bloop
    // includes the same helper's prototype from two files.
functions_declared_again_translate :: proc() {
}
    // rust: let fsh = "#version 330\nuniform float k;\nout vec4 c;\n\
    // rust: float f(float x);\nfloat f(float x);\nvec2 g(vec2 v, float s);\n\
    // rust: float f(float x) { return x * 2.0; }\nfloat f(float x);\n\
    // rust: vec2 g(vec2 v, float s) { return v * s; }\nvec2 g(vec2 v,\n       float s);\n\
    // rust: void main() { c = vec4(f(k), g(vec2(k), 3.0), 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: for name in ["f", "g"] {
    // rust: assert!(
    // rust: (p.fragment.functions.iter()).any(|(_, f)| f.name.as_deref() == Some(name)),
    // rust: "{name} missing"
    // rust: );
}
}

    // A prototype declared again leaves the lines after it where they were: an error below it
    // still names its own line.
errors_after_a_prototype_declared_again_keep_their_line :: proc() {
}
    // rust: let fsh = "#version 330\nout vec4 c;\nfloat f(float x);\nfloat f(float x\n);\n\
    // rust: float f(float x) { return x; }\nvoid main() { c = vec4(f(nowhere)); }\n";
    // rust: let errors = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .err()
    // rust: .expect("`nowhere` is not declared");
    // rust: assert!(
    // rust: errors
    // rust: .iter()
    // rust: .all(|e| e.line == 7 && e.message.contains("nowhere")),
    // rust: "{errors:?}"
    // rust: );
}

    // `if (c) return; else ...` keeps its `else`: the statements the translation guards with
    // `if (true)` must not take an `else` that belongs to the pack's `if`.
else_stays_with_its_if :: proc() {
}
    // rust: let fsh = "#version 120\nuniform float k;\n\
    // rust: void g(inout float x) { if (k > 0.5) return; else x = 3.0; }\n\
    // rust: float h(float x) { if (k > 0.5) return 1.0; else x = 2.0; return x; }\n\
    // rust: void main() {\n    float x = 0.0;\n    g(x);\n    \
    // rust: if (k > 0.9) discard; else x += h(x);\n    gl_FragColor = vec4(x);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
        // Our guards are `if (true)`: one with an `else` took the pack's.
guard_with_else :: proc(f: ^naga::Function, body: ^naga::Block) -> b {
    // Ported from Horizon
    return {}
}
    // rust: body.iter().any(|s| match s {
    // rust: naga::Statement::If {
    // rust: condition,
    // rust: accept,
    // rust: reject,
    // rust: } => {
    // rust: let ours = matches!(
    // rust: f.expressions[*condition],
    // rust: naga::Expression::Literal(naga::Literal::Bool(true))
    // rust: );
                    // naga ends a void function's tail blocks with a `return` of its own.
    // rust: let pack_code = reject.iter().any(|s| {
    // rust: !matches!(s, naga::Statement::Return { .. } | naga::Statement::Emit(_))
    // rust: });
    // rust: (ours && pack_code) || guard_with_else(f, accept) || guard_with_else(f, reject)
}
    // rust: naga::Statement::Block(b) => guard_with_else(f, b),
    // rust: _ => false,
    // rust: })
}
    // rust: for name in ["g", "h", "hz_main"] {
    // rust: let f = p
    // rust: .fragment
    // rust: .functions
    // rust: .iter()
    // rust: .find(|(_, f)| f.name.as_deref() == Some(name))
    // rust: .map(|(_, f)| f)
    // rust: .unwrap_or_else(|| panic!("{name} missing"));
    // rust: assert!(
    // rust: !guard_with_else(f, &f.body),
    // rust: "{name}: the pack's else moved into our if (true)"
    // rust: );
}
}

a_pack_keeps_its_own_inverse :: proc() {
}
    // rust: let fsh = "#version 120\nuniform mat4 gbufferProjection;\n\
    // rust: mat4 inverse(mat4 m) { return m; }\n\
    // rust: void main() { gl_FragData[0] = inverse(gbufferProjection) * vec4(1.0); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // Outputs with `component` qualifiers share one location (GLSL 4.60, 4.4.2): one target
    // at that location. The shapes glslangValidator rejects stay errors.
outputs_sharing_a_location_by_component_are_one_target :: proc() {
}
    // rust: let fsh = "#version 440\nlayout(location = 0, component = 0) out float r;\n\
    // rust: layout(location = 0, component = 1) out vec3 gba;\n\
    // rust: layout(location = 1, component = 1) out uvec3 words;\n\
    // rust: void main() { r = 0.0; gba = vec3(1.0, 0.0, 1.0); words = uvec3(1u); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert_eq!(p.interface.outputs, [0, 1]);
    // rust: let result = p.fragment.entry_points[0].function.result.as_ref().unwrap();
    // rust: let naga::TypeInner::Struct { members, .. } = &p.fragment.types[result.ty].inner else {
    // rust: panic!("two outputs are a struct");
}
    // rust: let targets: Vec<_> = members
    // rust: .iter()
    // rust: .map(|m| (m.binding.clone(), p.fragment.types[m.ty].inner.clone()))
    // rust: .collect();
    // rust: assert_eq!(targets.len(), 2, "{targets:?}");
    // rust: for (location, scalar) in [(0, naga::Scalar::F32), (1, naga::Scalar::U32)] {
    // rust: assert!(
    // rust: targets.iter().any(|(binding, ty)| matches!(
    // rust: binding,
    // rust: Some(naga::Binding::Location { location: l, .. }) if *l == location
    // rust: ) && *ty
    // rust: == naga::TypeInner::Vector {
    // rust: size: naga::VectorSize::Quad,
    // rust: scalar
    // rust: }),
    // rust: "{targets:?}"
    // rust: );
}
    // rust: for (outputs, name) in [
    // rust: (
    // rust: "layout(location = 0) out vec2 a; layout(location = 0, component = 1) out float b;",
    // rust: "b",
    // rust: ),
    // rust: (
    // rust: "layout(location = 0) out uint a; layout(location = 0, component = 1) out vec3 b;",
    // rust: "b",
    // rust: ),
    // rust: ("layout(location = 0, component = 2) out vec3 a;", "a"),
    // rust: ] {
    // rust: let fsh = format!("#version 440\n{outputs}\nvoid main() {{}}\n");
    // rust: let errors = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", &fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .err()
    // rust: .unwrap_or_else(|| panic!("{outputs} translated"));
    // rust: assert!(
    // rust: errors
    // rust: .iter()
    // rust: .any(|e| e.message.contains(&format!("`{name}`"))),
    // rust: "{outputs}: {errors:?}"
    // rust: );
}
}

narrow_outputs_widen_and_inverse_is_ours :: proc() {
}
    // rust: let fsh = "#version 400\nlayout(location = 0) out vec3 color;\nlayout(location = 1) out float depth;\n\
    // rust: uniform mat4 gbufferProjection;\nuniform mat3 m3;\n\
    // rust: void main() { color = (inverse(gbufferProjection) * vec4(1.0)).xyz * inverse(m3)[0]; depth = 0.5; }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let outputs: Vec<_> = p.fragment.entry_points[0]
    // rust: .function
    // rust: .result
    // rust: .iter()
    // rust: .flat_map(|r| match &p.fragment.types[r.ty].inner {
    // rust: naga::TypeInner::Struct { members, .. } => {
    // rust: members.iter().map(|m| m.ty).collect::<Vec<_>>()
}
    // rust: _ => vec![r.ty],
    // rust: })
    // rust: .map(|ty| p.fragment.types[ty].inner.clone())
    // rust: .collect();
    // rust: assert!(
    // rust: outputs.iter().all(|t| matches!(
    // rust: t,
    // rust: naga::TypeInner::Vector {
    // rust: size: naga::VectorSize::Quad,
    // rust: ..
}
    // rust: )),
    // rust: "{outputs:?}"
    // rust: );
    // rust: assert!(p.fragment.functions.iter().all(|(_, f)| {
    // rust: f.expressions.iter().all(|(_, e)| {
    // rust: !matches!(
    // rust: e,
    // rust: naga::Expression::Math {
    // rust: fun: naga::MathFunction::Inverse,
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: }));
}

    // A `shared` variable whose struct type has no name (GLSL 4.60, 4.1.8), as compute
    // programs keep their work group's tiles.
a_shared_struct_without_a_type_name_compiles :: proc() {
}
    // rust: let csh = "#version 460\nlayout(local_size_x = 8, local_size_y = 8) in;\n\
    // rust: shared struct {\n    uint sum;\n    uint tile[gl_WorkGroupSize.x][gl_WorkGroupSize.y];\n} lds;\n\
    // rust: layout(r32ui) uniform uimage2D colorimg4;\nvoid main() {\n    \
    // rust: lds.tile[gl_LocalInvocationID.x][gl_LocalInvocationID.y] = gl_LocalInvocationIndex;\n    \
    // rust: barrier();\n    imageStore(colorimg4, ivec2(gl_GlobalInvocationID.xy), uvec4(lds.tile[1][1]));\n}\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

buffer_blocks_bind_at_their_binding :: proc() {
}
    // rust: let csh = "#version 430\nlayout(local_size_x = 1) in;\n\
    // rust: layout(std430, binding = 2) readonly restrict buffer Lights { uint count; vec4 data[]; } lights;\n\
    // rust: layout(std430, binding = 5) buffer Counts { uint n[]; };\n\
    // rust: void main() { n[0] = 1u; }\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: let c = translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert_eq!(c.interface.buffers, [2, 5]);
    // rust: let missing = "#version 430\nlayout(local_size_x = 1) in;\nlayout(std430) buffer B { uint n; };\nvoid main() {}\n";
    // rust: let pack =
    // rust: Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", missing)])).unwrap();
    // rust: let errors = translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .err()
    // rust: .unwrap();
    // rust: assert!(errors[0].message.contains("needs a binding"), "{errors:?}");
}

atomics_on_shared_vector_components_compile :: proc() {
}
    // rust: let csh = "#version 430\nlayout(local_size_x = 4) in;\nshared ivec4 sums;\nshared uvec2 lights[8];\n\
    // rust: layout(r32i) uniform iimage2D colorimg5;\nvoid main() {\n    \
    // rust: if (gl_LocalInvocationIndex == 0u) sums = ivec4(0);\n    barrier();\n    \
    // rust: atomicAdd(sums.y, 1);\n    atomicMax(lights[gl_LocalInvocationIndex].x, 2u);\n    \
    // rust: sums += ivec4(1);\n    lights[gl_LocalInvocationIndex] += uvec2(1u);\n    \
    // rust: uvec2 l = lights[gl_LocalInvocationIndex];\n    barrier();\n    \
    // rust: imageStore(colorimg5, ivec2(0), ivec4(sums.y + int(lights[1].x + l.y)));\n}\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // The std430 offsets of the members of the buffer block at `binding`, by the names the
    // pack gave them (a split vector's `_hz` dropped, our padding left out), and its size.
buffer_layout :: proc(module: ^naga::Module, binding: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (_, global) = module
    // rust: .global_variables
    // rust: .iter()
    // rust: .find(|(_, g)| g.binding.as_ref().is_some_and(|b| b.binding == binding))
    // rust: .expect("the block");
    // rust: let ty = &module.types[global.ty];
    // rust: let naga::TypeInner::Struct { members, span } = &ty.inner else {
    // rust: panic!("{ty:?}");
}
    // rust: let members = members
    // rust: .iter()
    // rust: .filter_map(|m| {
    // rust: let name = m.name.as_deref()?;
    // rust: (!name.starts_with("hz_pad_"))
    // rust: .then(|| (name.trim_end_matches("_hz").to_owned(), m.offset))
    // rust: })
    // rust: .collect();
    // rust: (members, *span)
}

    // Atomic functions on a component of a buffer block's vector, which GLSL 4.60 8.11 allows
    // (our probe pack's shape, in a composite vertex stage): the program translates, and the
    // block keeps the std430 layout the fragment stage, which uses no atomics, gives it.
atomics_on_buffer_vector_components_compile_and_keep_the_layout :: proc() {
}
    // rust: let block = "layout(std430, binding = 2) restrict buffer probeSums { uint n; uvec2 a; uvec3 c[2]; uint m; uvec2 b; } sums;\n";
    // rust: let vsh = format!(
    // rust: "#version 430 compatibility\n{block}out vec2 uv;\nvoid main() {{\n    \
    // rust: atomicAdd(sums.a.x, 1u);\n    atomicMax(sums.b.y, uint(gl_VertexID));\n    \
    // rust: atomicOr(sums.c[gl_VertexID & 1].z, 2u);\n    sums.a += uvec2(1u);\n    \
    // rust: uv = vec2(sums.a.y + sums.c[1].x, sums.c.length());\n    gl_Position = ftransform();\n}}\n"
    // rust: );
    // rust: let fsh = format!(
    // rust: "#version 430 compatibility\n{block}in vec2 uv;\nvoid main() {{\n    \
    // rust: gl_FragData[0] = vec4(vec2(sums.a), vec2(sums.b)) + uv.x + float(sums.m + sums.c[0].z);\n}}\n"
    // rust: );
    // rust: let p = program(
    // rust: &[("composite.vsh", &vsh), ("composite.fsh", &fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let expected: Vec<(String, u32)> = [("n", 0), ("a", 8), ("c", 16), ("m", 48), ("b", 56)]
    // rust: .map(|(n, o)| (n.to_owned(), o))
    // rust: .into();
    // rust: assert_eq!(buffer_layout(&p.fragment, 2), (expected.clone(), 64));
    // rust: assert_eq!(buffer_layout(&p.vertex, 2), (expected, 64));
}

    // A block without an instance name: its member is named alone.
atomics_on_vector_components_of_an_unnamed_buffer_block_compile :: proc() {
}
    // rust: let csh = "#version 430\nlayout(local_size_x = 4) in;\n\
    // rust: layout(std430, binding = 1) buffer Counts { ivec4 counts; };\n\
    // rust: void main() {\n    atomicAdd(counts.w, 1);\n    ivec4 c = counts;\n    counts = c + 1;\n}\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

    // Atomic functions on a component of a shared vector, whatever its declaration: alone, in a
    // declaration of several names, a member of a shared struct (with whole-vector stores and
    // reads, or atomics only). The forms of #9085's probe; glslang accepts all of them.
atomics_on_shared_vector_components_compile_in_lists_and_structs :: proc() {
}
    // rust: let forms = [
    // rust: (
    // rust: "shared ivec3 mn;\nshared ivec3 mx;\n",
    // rust: "atomicMin(mn.x, i);\n    atomicMax(mx.x, i);",
    // rust: ),
    // rust: (
    // rust: "shared ivec3 mn, mx;\n",
    // rust: "atomicMin(mn.x, i);\n    atomicMax(mx.x, i);",
    // rust: ),
    // rust: (
    // rust: "shared struct { ivec3 mn; uint other; } sh;\n",
    // rust: "if (i == 0) sh.mn = ivec3(1000);\n    barrier();\n    atomicMin(sh.mn.x, i);\n    \
    // rust: barrier();\n    ivec3 r = sh.mn;\n    sh.other = uint(r.x);",
    // rust: ),
    // rust: (
    // rust: "shared struct { ivec3 mn; uint other; } sh;\n",
    // rust: "atomicMin(sh.mn.x, i);",
    // rust: ),
    // rust: ];
    // rust: for (decl, body) in forms {
    // rust: let csh = format!(
    // rust: "#version 460 core\nlayout(local_size_x = 8) in;\n{decl}void main() {{\n    \
    // rust: int i = int(gl_LocalInvocationIndex);\n    {body}\n}}\n"
    // rust: );
    // rust: let pack =
    // rust: Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", &csh)])).unwrap();
    // rust: let p = translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{csh}\n{e:?}"));
            // The struct keeps its other member; the vector's components are atomic.
    // rust: if decl.contains("struct") {
    // rust: let (_, sh) = p
    // rust: .module
    // rust: .global_variables
    // rust: .iter()
    // rust: .find(|(_, g)| g.space == naga::AddressSpace::WorkGroup)
    // rust: .expect("the shared struct");
    // rust: let naga::TypeInner::Struct { members, .. } = &p.module.types[sh.ty].inner else {
    // rust: panic!("{:?}", p.module.types[sh.ty]);
}
    // rust: let inner = |m: &naga::StructMember| p.module.types[m.ty].inner.clone();
    // rust: let [mn, other] = &members[..] else {
    // rust: panic!("{members:?}")
}
    // rust: let naga::TypeInner::Array { base, size, .. } = inner(mn) else {
    // rust: panic!("{mn:?}")
}
    // rust: assert_eq!(size, naga::ArraySize::Constant(3.try_into().unwrap()));
    // rust: assert!(matches!(
    // rust: p.module.types[base].inner,
    // rust: naga::TypeInner::Atomic(naga::Scalar::I32)
    // rust: ));
    // rust: assert!(matches!(
    // rust: inner(other),
    // rust: naga::TypeInner::Scalar(naga::Scalar::U32)
    // rust: ));
}
}
}

    // A stage's `#version` may come from a header it includes: the program is that version
    // (`shared` is a keyword in GLSL 4.30, not a name to rename).
the_version_may_come_from_an_included_header :: proc() {
}
    // rust: let csh = "#include \"/prelude/core.glsl\"\nlayout(local_size_x = 4) in;\n\
    // rust: shared uint counts[4];\nlayout(r32ui) uniform uimage2D colorimg4;\n\
    // rust: void main() {\n    counts[gl_LocalInvocationIndex] = 1u;\n    barrier();\n    \
    // rust: imageStore(colorimg4, ivec2(0), uvec4(counts[1]));\n}\n";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: ("shaders/deferred_a.csh", csh),
    // rust: ("shaders/prelude/core.glsl", "#version 460 core\n"),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let pp = preprocess(&pack, "deferred_a.csh", &Macros::standard());
    // rust: assert_eq!(pp.version, Some((460, Some("core".into()))));
    // rust: translate_compute(&pp).unwrap_or_else(|e| panic!("{e:?}"));
}

work_group_size_is_its_layout :: proc() {
}
    // rust: let csh = "#version 430\nlayout(local_size_x = 8, local_size_y = 4) in;\n\
    // rust: layout(r32ui) uniform uimage2D colorimg4;\nvoid main() {\n    \
    // rust: imageStore(colorimg4, ivec2(gl_WorkGroupSize.xy), uvec4(gl_WorkGroupSize.z));\n}\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: let c = translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let main = &c
    // rust: .module
    // rust: .functions
    // rust: .iter()
    // rust: .find(|f| f.1.name.as_deref() == Some("hz_main"))
    // rust: .unwrap()
    // rust: .1;
    // rust: assert!(
    // rust: main.expressions
    // rust: .iter()
    // rust: .any(|(_, e)| matches!(e, naga::Expression::Literal(naga::Literal::U32(8))))
    // rust: );
        // A constant expression (GLSL 4.60, 4.4) is worked out, also where naga reads it.
    // rust: assert_eq!(
    // rust: work_group_size(
    // rust: "layout(local_size_x = min(gl_MaxComputeWorkGroupSize.x, 256 * 2), local_size_y = (3 + 1) / 2) in;\n\
    // rust: uvec3 s = gl_WorkGroupSize;"
    // rust: )
    // rust: .as_deref(),
    // rust: Ok("layout(local_size_x = 512, local_size_y = 2) in;\nuvec3 s = uvec3(512u, 2u, 1u);")
    // rust: );
    // rust: assert_eq!(
    // rust: work_group_size("layout(local_size_x = SIZE) in;\nvoid main() {}"),
    // rust: Err("`local_size_x` is not a size Horizon can work out".into())
    // rust: );
    // rust: assert!(
    // rust: work_group_size("layout(local_size_x = 16) in;\nuvec3 s = gl_WorkGroupSize;")
    // rust: .is_ok_and(|c| c.contains("uvec3(16u, 1u, 1u)"))
    // rust: );
}

    // A work group size given as a constant expression (GLSL 4.60, 4.4 and 4.4.1), kept within
    // the implementation's: the program compiles with its value.
a_work_group_size_may_be_a_constant_expression :: proc() {
}
    // rust: let csh = "#version 460\nlayout(local_size_x = min(gl_MaxComputeWorkGroupSize.x, 256), \
    // rust: local_size_y = 1, local_size_z = 1) in;\n\
    // rust: layout(r32ui) uniform uimage2D colorimg4;\n\
    // rust: void main() { imageStore(colorimg4, ivec2(gl_GlobalInvocationID.xy), uvec4(1u)); }\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: let c = translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let entry = &c.module.entry_points[0];
    // rust: assert_eq!(entry.workgroup_size, [256, 1, 1]);
}

compute_programs_translate :: proc() {
}
    // rust: let csh = "#version 430\nlayout(local_size_x = 64) in;\nconst ivec3 workGroups = ivec3(2, 1, 1);\n\
    // rust: layout(rgba16f) writeonly uniform image2D colorimg4;\nuniform sampler2D colortex4;\n\
    // rust: uniform float frameTimeCounter;\nshared vec3 sums[64];\nvoid main() {\n    \
    // rust: uint i = gl_LocalInvocationID.x;\n    sums[i] = texelFetch(colortex4, ivec2(i, 0), 0).rgb * frameTimeCounter;\n    \
    // rust: barrier();\n    if (i == 0u) imageStore(colorimg4, ivec2(0), vec4(sums[0] + subgroupAdd(sums[1]), 1.0));\n}\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", csh)])).unwrap();
    // rust: let c = translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert_eq!(c.work_groups, Some([2, 1, 1]));
    // rust: assert_eq!(c.work_groups_render, [1.0, 1.0]);
    // rust: let render = |decl: &str| {
    // rust: let csh =
    // rust: format!("#version 430\nlayout(local_size_x = 8) in;\n{decl}\nvoid main() {{}}\n");
    // rust: let pack =
    // rust: Pack::from_zip_bytes("P.zip", zip(&[("shaders/deferred_a.csh", &csh)])).unwrap();
    // rust: translate_compute(&preprocess(&pack, "deferred_a.csh", &Macros::standard()))
    // rust: .map(|c| c.work_groups_render)
    // rust: .map_err(|e| e[0].message.clone())
}
    // rust: assert_eq!(
    // rust: render("const vec2 workGroupsRender = vec2(0.5, 0.25);"),
    // rust: Ok([0.5, 0.25])
    // rust: );
    // rust: assert_eq!(
    // rust: render("const vec3 workGroupsRender = vec3(0.5, 1.0, 1.0);"),
    // rust: Ok([0.5, 1.0])
    // rust: );
    // rust: assert!(render("const float workGroupsRender = 0.5;").is_err());
    // rust: assert_eq!(c.module.entry_points[0].workgroup_size, [64, 1, 1]);
    // rust: let i = &c.interface;
    // rust: assert_eq!(
    // rust: (i.samplers[0].binding, i.images[0].binding),
    // rust: (1, 3),
    // rust: "{:?}",
    // rust: i.images
    // rust: );
    // rust: assert_eq!(
    // rust: (i.images[0].format.as_str(), i.images[0].access.as_str()),
    // rust: ("rgba16f", "writeonly")
    // rust: );
}

locals_may_hide_a_sampler :: proc() {
}
    // rust: let fsh = "#version 120\nuniform sampler2D specular;\nstruct M { float specular; };\n\
    // rust: float f(float x) { float specular = x * 2.0; return specular; }\n\
    // rust: void main() { M m = M(0.5); gl_FragColor = texture2D(specular, vec2(0.5)) * f(m.specular); }\n";
    // rust: program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
}

errors_point_at_the_pack_file_and_line :: proc() {
}
    // rust: let fsh =
    // rust: "#version 120\n#include \"/lib/bad.glsl\"\nvoid main() { gl_FragColor = vec4(f()); }\n";
    // rust: let bad = "// fine\nfloat f() {\n    return undefinedThing;\n}\n";
    // rust: let errors = program(
    // rust: &[
    // rust: ("composite.vsh", VSH_120),
    // rust: ("composite.fsh", fsh),
    // rust: ("lib/bad.glsl", bad),
    // rust: ],
    // rust: Target::Buffers,
    // rust: )
    // rust: .err()
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (errors[0].file.as_str(), errors[0].line),
    // rust: ("lib/bad.glsl", 3),
    // rust: "{errors:?}"
    // rust: );
}

    // Swizzled scalars, GLSL 4.20's (Kappa's weather map: `noise(p).x`).
scalar_swizzles_translate :: proc() {
}
    // rust: let fsh = "#version 430\nout vec4 color;\nfloat noise(vec2 p) { return fract(p.x * 3.1); }\n\
    // rust: void main() {\n    float a = noise(gl_FragCoord.xy * 0.1).x;\n    float s = a.r * 2.0;\n    \
    // rust: vec2 w = s.xx + noise(vec2(a)).ss;\n    color = vec4(w, a, s);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // `x / 0.0` and `sqrt(-1.0)` are GL's infinity and NaN at run time; naga folds them into
    // constants and refuses them (Mellow, Bloop). `texelFetch2D` is GL_EXT_gpu_shader4's name
    // (Bliss).
infinities_nans_and_old_fetches_translate :: proc() {
}
    // rust: let fsh = "#version 330\nuniform sampler2D noisetex;\nout vec4 color;\nvoid main() {\n    \
    // rust: ivec2 t = ivec2(gl_FragCoord.xy);\n    \
    // rust: color = texelFetch2D(noisetex, t, 0) + vec4(-1.0 / 0.0) + vec4(sqrt(-1.0));\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // A matrix varying's column written by component, and `uint` with integer literals in
    // `max`, `min` and `clamp` (Kappa, Hysteria).
matrix_columns_and_unsigned_overloads_translate :: proc() {
}
    // rust: let vsh = "#version 330 compatibility\nout mat2x2 uv;\nvoid main() {\n    \
    // rust: uv = mat2x2(gl_MultiTexCoord0.xy, gl_MultiTexCoord1.xy);\n    \
    // rust: uv[1].y = uv[1].y * 0.5;\n    gl_Position = ftransform();\n}\n";
    // rust: let fsh = "#version 330\nin mat2x2 uv;\nout vec4 color;\nvoid main() {\n    uint n = 3u;\n    \
    // rust: uint s = max(n, 1);\n    s = min(s, 32) + uint(clamp(n, 0, 7));\n    \
    // rust: color = vec4(uv[0], uv[1]) / float(s);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", vsh), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // `const`s that call a built-in naga's constant evaluator lacks (`mix`, `smoothstep`...)
    // are evaluated where the program runs: a global by our `main`, a local in place (Bliss).
constants_naga_cannot_fold_are_evaluated_at_run_time :: proc() {
}
    // rust: let fsh = "#version 120\nvarying vec2 texcoord;\nconst vec3 tint = mix(vec3(0.2), vec3(1.0), 0.25);\n\
    // rust: const float edge = smoothstep(0.0, 1.0, 0.5), mid = 0.5;\n\
    // rust: float shade(float x) {\n    const float k = mix(0.5, 1.0, 0.3);\n    return x * k;\n}\n\
    // rust: void main() { gl_FragColor = vec4(tint * shade(texcoord.x) * edge * mid, 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // `const` parameters (`const in float x`, which naga's parser refuses) translate.
const_parameters_translate :: proc() {
}
    // rust: let fsh = "#version 120\nvarying vec2 texcoord;\n\
    // rust: float lift(const in float x) { return x * 2.0; }\n\
    // rust: vec2 both(const in vec2 a, const vec2 b, out float c) { c = a.x; return a + b; }\n\
    // rust: float twice(const in float x);\n\
    // rust: float twice(const in float x) { return lift(x); }\n\
    // rust: void main() { float c; vec2 v = both(texcoord, vec2(lift(0.5)), c); \
    // rust: gl_FragColor = vec4(v, twice(c), 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // Arrays of arrays nest as GL reads them in every spelling: naga's frontend reverses
    // `T x[A][B]`, `T[A][B]`, struct members and parameters, so `x[2][1]` of a `float[3][2]`
    // would index past the inner array.
arrays_of_arrays_keep_their_order :: proc() {
}
    // rust: let fsh = "#version 330\nout vec4 color;\nfloat m[3][2];\nfloat[2] n[3];\n\
S :: struct {
    // rust: void main() {\n    float k[3][2];\n    k[2][1] = 1.0;\n    m[2][1] = f(k);\n    \
    // rust: n[2][1] = float[3][2](float[2](1.0, 2.0), float[2](3.0, 4.0), float[2](5.0, 6.0))[2][1];\n    \
    // rust: S s;\n    s.a[3][1] = 2.0;\n    color = vec4(m[2][1], n[2][1], s.a[3][1], 1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    Target: :Buffers,
    // rust: )
    // rust: .unwrap();
    // rust: let outer = |name: &str| {
    // rust: let (_, g) = (p.fragment.global_variables.iter())
    // rust: .find(|(_, g)| g.name.as_deref() == Some(name))
    // rust: .unwrap();
    // rust: match p.fragment.types[g.ty].inner {
    naga: :TypeInner::Array { size,
    // rust: ref t => panic!("{t:?}"),
}
}
    // rust: let size = |n: u32| naga::ArraySize::Constant(std::num::NonZeroU32::new(n).unwrap());
    // rust: assert_eq!(outer("m"), size(3));
    // rust: assert_eq!(outer("n"), size(3));
}

    // A local named like the sampler parameter it reads in its own initializer (Potato's
    // depth-aware blur), and like a global sampler.
locals_named_like_samplers_read_them_first :: proc() {
}
    // rust: let fsh = "#version 330\nuniform sampler2D colortex1;\nuniform sampler2D depthtex0;\n\
    // rust: uniform sampler2D colortex2;\nin vec2 uv;\nout vec4 color;\n\
    // rust: vec3 blur(sampler2D tex, sampler2D depth, vec2 c) {\n    vec3 s = vec3(0.0);\n    \
    // rust: for (int i = 0; i < 2; i++) {\n        float depth = texture(depth, c).x;\n        \
    // rust: s += texture(tex, c).rgb * depth;\n    }\n    return s;\n}\n\
    // rust: void main() {\n    float colortex2 = texture(colortex2, uv).x;\n    \
    // rust: color = vec4(blur(colortex1, depthtex0, uv) * colortex2, 1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // A sampler named `texture`, called with the function of the same name (Bloop).
samplers_named_like_functions_translate :: proc() {
}
    // rust: let fsh = "#version 330\nuniform sampler2D texture;\nin vec2 uv;\nout vec4 color;\n\
    // rust: void main() {\n    color = texture(texture, uv) + texture(texture, uv, -1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // Parameters and locals named like a bool uniform hide it (GLSL 4.60, 4.2): the uniform is
    // only rewritten where it is the name in scope, and a prototype's parameter ends with it.
parameters_and_locals_named_like_bool_uniforms_hide_them :: proc() {
}
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
    // rust: float f(in bool hideGUI) { return hideGUI ? 1.0 : 0.0; }\n\
    // rust: float g() { bool hideGUI = gl_FragCoord.x > 0.5; return hideGUI ? 2.0 : 0.0; }\n\
    // rust: float h(bool hideGUI);\n\
    // rust: void main() { c = vec4(f(true), g(), h(false), hideGUI ? 1.0 : 0.0); }\n\
    // rust: float h(bool hideGUI) { return hideGUI ? 3.0 : 0.0; }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: let arg = |name: &str| {
    // rust: let (_, f) = (p.fragment.functions.iter())
    // rust: .find(|(_, f)| f.name.as_deref() == Some(name))
    // rust: .unwrap();
    // rust: f.arguments[0].name.clone()
}
    // rust: assert_eq!(arg("f").as_deref(), Some("hideGUI"));
    // rust: assert_eq!(arg("h").as_deref(), Some("hideGUI"));
    // rust: assert!(p.interface.uniforms.iter().any(|u| u.name == "hideGUI"));
        // `main` reads the uniform as an int compared with zero; `f`, `g` and `h` do not.
    // rust: assert!(reads_bool_uniform(&p));
    // rust: for name in ["f", "g", "h"] {
    // rust: let (_, func) = (p.fragment.functions.iter())
    // rust: .find(|(_, f)| f.name.as_deref() == Some(name))
    // rust: .unwrap();
    // rust: let uses = func.expressions.iter().any(|(_, e)| {
    // rust: matches!(
    // rust: e,
    // rust: naga::Expression::Binary {
    // rust: op: naga::BinaryOperator::NotEqual,
    // rust: ..
}
    // rust: )
    // rust: });
    // rust: assert!(!uses, "{name} read the uniform instead of its own hideGUI");
}
}

    // A struct member and a member access named like a bool uniform stay plain.
members_named_like_bool_uniforms_stay_plain :: proc() {
}
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
S :: struct {
    // rust: float f(S v) { return v.hideGUI ? 1.0 : 0.0; }\n\
    // rust: void main() { S s = S(true, 1.0); c = vec4(f(s), hideGUI ? 1.0 : 0.0, 0.0, 1.0); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    Target: :Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(reads_bool_uniform(&p));
}

    // Whether `hz_main` compares an int uniform with zero (a bool uniform read).
reads_bool_uniform :: proc(p: ^Program) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (_, main) = (p.fragment.functions.iter())
    // rust: .find(|(_, f)| f.name.as_deref() == Some("hz_main"))
    // rust: .unwrap();
    // rust: main.expressions.iter().any(|(_, e)| {
    // rust: matches!(
    // rust: e,
    // rust: naga::Expression::Binary {
    // rust: op: naga::BinaryOperator::NotEqual,
    // rust: ..
}
    // rust: )
    // rust: })
}

    // A `for` header's variable (and a second declarator) hide the uniform to the loop's end.
for_header_and_second_declarators_hide_bool_uniforms :: proc() {
}
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
    // rust: void main() {\n    float t = 0.0;\n    \
    // rust: for (bool hideGUI = false; t < 2.0; t += 1.0) { t += hideGUI ? 1.0 : 0.0; }\n    \
    // rust: for (int i = 0, hideGUI = 3; i < 2; i++) { t += float(hideGUI); }\n    \
    // rust: bool a = true, hideGUI = false, b = a;\n    t += hideGUI ? 1.0 : 0.0;\n    \
    // rust: c = vec4(t, b ? 1.0 : 0.0, 0.0, 1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(!reads_bool_uniform(&p), "the local hides the uniform");
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
    // rust: void main() {\n    float t = 0.0;\n    \
    // rust: for (bool hideGUI = false; t < 2.0; t += 1.0) { t += hideGUI ? 1.0 : 0.0; }\n    \
    // rust: for (int i = 0, k = 3; i < 2; i++) { t += float(k); }\n    \
    // rust: c = vec4(t, hideGUI ? 1.0 : 0.0, 0.0, 1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(reads_bool_uniform(&p), "the uniform is back after the loop");
}

    // A `for` loop with a single-statement body: its variable hides the uniform to the `;`.
unbraced_for_body_ends_the_hiding_at_its_statement :: proc() {
}
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
    // rust: void main() {\n    float t = 0.0;\n    \
    // rust: for (bool hideGUI = false; t < 2.0; t += 1.0) t += hideGUI ? 1.0 : 0.0;\n    \
    // rust: c = vec4(t, hideGUI ? 1.0 : 0.0, 0.0, 1.0);\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: )
    // rust: .unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(reads_bool_uniform(&p));
        // The body is a `return`, which the translator rewrites on its own.
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
    // rust: float f(float t) {\n    \
    // rust: for (bool hideGUI = false; t < 2.0; t += 1.0) return hideGUI ? 1.0 : t;\n    \
    // rust: return hideGUI ? 1.0 : 0.0;\n}\n\
    // rust: void main() { c = vec4(f(0.0)); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // A sampler parameter's name reused as a local of an inner block, then read again.
sampler_parameter_is_back_after_the_block_of_a_local :: proc() {
}
    // rust: let fsh = "#version 330\nuniform sampler2D colortex1;\nin vec2 uv;\nout vec4 color;\n\
    // rust: vec4 f(sampler2D tex, vec2 c) {\n    vec4 r = vec4(0.0);\n    \
    // rust: if (c.x > 0.5) { float tex = 2.0; r += vec4(tex); }\n    \
    // rust: return r + texture(tex, c);\n}\n\
    // rust: void main() { color = f(colortex1, uv); }\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: assert!(p.is_ok(), "{:?}", p.err());
}

    // A local in an inner block hides the uniform only to the block's end.
bool_uniform_is_back_after_the_block_of_a_local :: proc() {
}
    // rust: let fsh = "#version 330\nuniform bool hideGUI;\nout vec4 c;\n\
    // rust: void main() {\n    c = vec4(0.0);\n    \
    // rust: if (gl_FragCoord.x > 0.5) { bool hideGUI = true; c.r = hideGUI ? 1.0 : 0.0; }\n    \
    // rust: c.a = hideGUI ? 1.0 : 0.0;\n}\n";
    // rust: let p = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fsh)],
    // rust: Target::Buffers,
    // rust: );
    // rust: let p = p.unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert!(
    // rust: reads_bool_uniform(&p),
    // rust: "the uniform is back after the block"
    // rust: );
}

storage_buffer_extension_keeps_the_legacy_buffer_keyword :: proc() {
}
    // rust: let fragment = "#version 130\n#extension GL_ARB_shader_storage_buffer_object : enable\nlayout(std430,binding=0) readonly buffer Data{uvec4 cells[4];}data;void main(){gl_FragColor=vec4(data.cells[0]);}";
    // rust: let result = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fragment)],
    // rust: Target::Window,
    // rust: );
    // rust: assert!(result.is_ok(), "{:?}", result.err());
}
ordinary_legacy_buffer_identifiers_still_translate :: proc() {
}
    // rust: let fragment = "#version 120\nvoid main(){float buffer=0.5;gl_FragColor=vec4(buffer);}";
    // rust: let result = program(
    // rust: &[("composite.vsh", VSH_120), ("composite.fsh", fragment)],
    // rust: Target::Window,
    // rust: );
    // rust: assert!(result.is_ok(), "{:?}", result.err());
}
}

    // rust: mod image_parameter_tests {
//     use crate::{Macros, Pack, preprocess, translate_compute};
nested_image_helpers_specialize_multiple_storage_formats :: proc() {
}
    // rust: let src = "#version 430\nlayout(local_size_x=1)in;layout(rgba16f) uniform image3D imageA;layout(r32f) uniform image3D imageB;void write_value(writeonly image3D img,ivec3 p){imageStore(img,p,vec4(0.5));}\nvoid nested(image3D img,ivec3 p){write_value(img,p);}\nvoid main(){nested(imageA,ivec3(0));nested(imageB,ivec3(0));}";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "formats.zip",
    // rust: crate::pack::tests::zip(&[("shaders/setup.csh", src)]),
    // rust: )
    // rust: .unwrap();
    // rust: let result = translate_compute(&preprocess(&pack, "setup.csh", &Macros::standard()));
    // rust: assert!(result.is_ok(), "{:?}", result.err());
}
}

    // rust: mod mixed_integer_bounds_tests {
compute_clamp_with_signed_index_and_unsigned_bounds_compiles :: proc() {
}
    // rust: let source = "#version 430\nlayout(local_size_x=1) in; layout(std430,binding=0) buffer Data{uint result;};void main(){int index=int(gl_LocalInvocationID.x);result=clamp(index,0u,47u);}";
    // rust: let pack = crate::Pack::from_zip_bytes(
    // rust: "integer-bounds.zip",
    // rust: crate::pack::tests::zip(&[("shaders/setup.csh", source)]),
    // rust: )
    // rust: .unwrap();
    // rust: let stage = crate::preprocess(&pack, "setup.csh", &crate::Macros::standard());
    // rust: let result = crate::translate_compute(&stage);
    // rust: assert!(result.is_ok(), "{:?}", result.err());
}
}
