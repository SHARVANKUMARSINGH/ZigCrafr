//! Transpiled from Horizon Rust crate
package horizon_client_render_native_material

import "core:fmt"
import "core:mem"
import "core:math"

// The material stage of Horizon's own shader packs (docs/shaders.md): the pack's `material`
// function gives the lit colour of each point of a block's surface, before the alpha test and
// fog. Terrain still draws with Horizon's meshes, culling and draw lists; only its pipelines
// change. Their shader is the pack's stage (`CheckedStage::source`), then a copy of
// terrain.wgsl's terrain section whose names all take a `horizon_terrain_` prefix
// (`wgsl_prefix.rs`), then entries that hand the pack what vanilla's `fs_solid` and
// `fs_translucent` combine: the texture, the vertex tint, the light levels and the lightmap's
// colour. They read the terrain's group 0, the flat draws' group 1 where those run, and the
// pack's frame at group 3.

// use horizon_shader_api::{check::CheckedStage, stages::GROUP};

// use super::native_post::{NativeFrame, present_constants};
// use super::wgsl_prefix::{TERRAIN, prefixed, section};

PREFIX :: "horizon_terrain_"

// The entries around the pack's `material`: vanilla's vertex work without the lightmap
// product, then the material, the alpha test and fog as `fs_solid` and `fs_translucent` do.
    // rust: const ENTRIES: &str = "
// The manifest's `[material] fog`: false when the pack fogs its surfaces itself.
    // rust: override horizon_material_fog: bool = true;
horizon_material_fogged :: proc(color: vec4<f32>, spherical: f32, cylindrical: f32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: if horizon_material_fog {
    // rust: return horizon_terrain_apply_fog(color, spherical, cylindrical);
}
    // rust: return color;
}
HorizonMaterialOut :: struct {
    // rust: @builtin(position) clip: vec4<f32>,
    // rust: @location(0) uv: vec2<f32>,
    // rust: @location(1) @interpolate(flat) layer: u32,
    // rust: @location(2) tint: vec4<f32>,
    // rust: @location(3) light: vec2<f32>,
    // rust: @location(4) lightmap: vec3<f32>,
    // rust: @location(5) position: vec3<f32>,
    // rust: @location(6) spherical: f32,
    // rust: @location(7) cylindrical: f32,
    // rust: @location(8) @interpolate(flat) face: u32,
    // rust: @location(9) @interpolate(flat) fluid_quad: u32,
    // rust: @location(10) @interpolate(flat) emission: f32,
    // terrain.wgsl's `emission`, for HDR output's mark.
    // rust: @location(11) @interpolate(flat) hdr_code: u32,
    // The point on the flat face (`position` without `[displacement]`'s relief), how much of
    // that relief it has (`MaterialInput.displaced`) and the face's normal (0 when the
    // fragment finds it).
    // rust: @location(12) base: vec3<f32>,
    // rust: @location(13) displaced: f32,
    // rust: @location(14) @interpolate(flat) normal: vec3<f32>,
}
    // rust: fn horizon_material_vertex(position: vec3<f32>, uv: vec2<f32>, layer: u32, color: vec4<f32>,
    // rust: light: vec2<u32>, origin: vec3<f32>) -> HorizonMaterialOut {
    // rust: let pos = horizon_material_displace(position + origin, uv, layer, color, light);
    // rust: return horizon_material_out(pos, uv, layer, color, vec2<f32>(light));
}
// `light`: sky, block, 16 per level.
    // rust: fn horizon_material_out(pos: vec3<f32>, uv: vec2<f32>, layer: u32, color: vec4<f32>,
    // rust: light: vec2<f32>) -> HorizonMaterialOut {
    // rust: var out: HorizonMaterialOut;
    // rust: out.clip = horizon_terrain_globals.view_proj * vec4(pos, 1.0);
    // rust: out.uv = uv;
    // rust: out.layer = layer;
    // rust: out.tint = vec4(color.rgb, 1.0);
    // rust: let block = max(light.y, horizon_terrain_dynamic_block_light(pos));
    // rust: let sky = light.x;
    // 16 per level, 15 levels.
    // rust: out.light = min(vec2(block, sky) / 240.0, vec2(1.0));
    // rust: out.lightmap = horizon_terrain_sample_lightmap(sky / 16.0, block / 16.0).rgb;
    // rust: out.position = pos;
    // rust: out.spherical = length(pos);
    // rust: out.cylindrical = max(length(pos.xz), abs(pos.y));
    // The colour's alpha byte (mesher.rs's `fluid_face` and `emitting`): a fluid quad's
    // high nibble is 8 + its face (0..5), every other quad keeps 0xF there; the low nibble
    // is 15 minus the face's HDR tier. Every corner of a quad carries the same byte, so the
    // interpolated value rounds back exactly.
    // rust: let flags = u32(round(color.a * 255.0));
    // rust: let high = flags >> 4u;
    // rust: let fluid = high >= 8u && (high & 7u) < 6u;
    // rust: out.face = select(0u, high & 7u, fluid);
    // rust: out.fluid_quad = u32(fluid);
    // The tier (0 none, 1 low, 2 incandescent, 3 bright, 4 very bright) as how strongly the
    // face shines: a redstone torch 7/15, a torch 14/15, glowstone 1.
    // rust: out.hdr_code = 15u - (flags & 15u);
    // Codes above 4 are the same tiers, shining all over rather than in their bright parts.
    // rust: let tier = select(out.hdr_code, out.hdr_code - 4u, out.hdr_code > 4u);
    // rust: out.emission = select(min(f32(tier) * 7.0 / 15.0, 1.0), 0.0, tier == 0u);
    // rust: out.base = pos;
    // rust: out.displaced = 0.0;
    // rust: out.normal = vec3(0.0);
    // rust: return out;
}
    // rust: @vertex fn horizon_material_vs(
    // rust: @location(0) position: vec3<f32>, @location(1) uv: vec2<u32>,
    // rust: @location(2) layer: u32, @location(3) color: vec4<f32>, @location(4) light: vec2<u32>,
    // rust: @location(5) origin: vec4<f32>) -> HorizonMaterialOut {
    // rust: return horizon_material_vertex(position, horizon_terrain_terrain_uv(uv, origin.w), layer,
    // rust: color, light, origin.xyz);
}
    // rust: @vertex fn horizon_material_vs_flat(
    // rust: @builtin(vertex_index) vertex: u32,
    // rust: @location(0) position: vec3<f32>, @location(1) uv: vec2<u32>,
    // rust: @location(2) layer: u32, @location(3) color: vec4<f32>, @location(4) light: vec2<u32>
    // rust: ) -> HorizonMaterialOut {
    // rust: let origin = horizon_terrain_slot_origins[horizon_terrain_block_slots[vertex >> 8u]];
    // rust: return horizon_material_vertex(position, horizon_terrain_terrain_uv(uv, origin.w), layer,
    // rust: color, light, origin.xyz);
}
// The prelude's `block_normal_map` and `block_specular_map`: the resource packs' LabPBR maps
// in the pack's frame group (3), one array each, a blank 1x1 without them.
    // rust: @group(3) @binding(12) var horizon_pbr_normals: texture_2d_array<f32>;
    // rust: @group(3) @binding(13) var horizon_pbr_specular: texture_2d_array<f32>;
horizon_block_pbr_present :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: return textureDimensions(horizon_pbr_normals).x > 1u;
}
horizon_block_pbr_size :: proc() -> v {
    // Ported from Horizon
    return {}
}
    // rust: return vec2<f32>(textureDimensions(horizon_pbr_normals).xy);
}
horizon_block_pbr :: proc(uv: vec2<f32>, layer: u32, lod: f32, map: u32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: if !horizon_block_pbr_present() || layer >= textureNumLayers(horizon_pbr_normals) {
    // rust: return select(vec4<f32>(0.5, 0.5, 1.0, 1.0), vec4<f32>(0.0), map == 1u);
}
    // rust: let s = horizon_terrain_sprite_sampler;
    // The maps may be smaller than the colour: the same footprint is fewer of their texels.
    // rust: let scale = f32(textureDimensions(horizon_terrain_sprites).x)
    // rust: / f32(textureDimensions(horizon_pbr_normals).x);
    // rust: let l = max(lod - log2(scale), 0.0);
    // rust: if map == 0u {
    // rust: return textureSampleLevel(horizon_pbr_normals, s, uv, i32(layer), l);
}
    // rust: return textureSampleLevel(horizon_pbr_specular, s, uv, i32(layer), l);
}
// The prelude's `block_texture`: a sprite of the terrain's arrays at a mip level.
horizon_block_size :: proc() -> v {
    // Ported from Horizon
    return {}
}
    // rust: return vec2<f32>(textureDimensions(horizon_terrain_sprites).xy);
}
horizon_block_sample :: proc(uv: vec2<f32>, layer: u32, lod: f32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let s = horizon_terrain_sprite_sampler;
    // rust: let l = i32(layer % horizon_terrain_SPRITE_SPLIT);
    // rust: switch layer / horizon_terrain_SPRITE_SPLIT {
    // rust: case 0u: { return textureSampleLevel(horizon_terrain_sprites, s, uv, l, lod); }
    // rust: case 1u: { return textureSampleLevel(horizon_terrain_sprites_1, s, uv, l, lod); }
    // rust: case 2u: { return textureSampleLevel(horizon_terrain_sprites_2, s, uv, l, lod); }
    // rust: case 3u: { return textureSampleLevel(horizon_terrain_sprites_3, s, uv, l, lod); }
    // rust: case 4u: { return textureSampleLevel(horizon_terrain_sprites_4, s, uv, l, lod); }
    // rust: case 5u: { return textureSampleLevel(horizon_terrain_sprites_5, s, uv, l, lod); }
    // rust: case 6u: { return textureSampleLevel(horizon_terrain_sprites_6, s, uv, l, lod); }
    // rust: default: { return textureSampleLevel(horizon_terrain_sprites_7, s, uv, l, lod); }
}
}
horizon_material_color :: proc(in: HorizonMaterialOut, translucent: bool) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let albedo = horizon_terrain_sprite(in.uv, in.layer & 0x7fffu);
    // rust: horizon_block_layer = in.layer & 0x7fffu;
    // The mip level of this point in the texture: its texels, as the sampler would pick.
    // rust: let texels = in.uv * horizon_block_size();
    // rust: let footprint = max(dot(dpdx(texels), dpdx(texels)), dot(dpdy(texels), dpdy(texels)));
    // rust: horizon_block_lod = max(0.5 * log2(max(footprint, 1e-8)), 0.0);
    // Water draws translucent and lava solid, so the pass resolves the fluid kind.
    // rust: let fluid = select(0u, select(2u, 1u, translucent), in.fluid_quad != 0u);
    // `[displacement]`'s grid hands down its face's normal: its relief is the pack's to shade.
    // rust: let normal = select(horizon_material_normal(in.position), in.normal,
    // rust: dot(in.normal, in.normal) > 0.5);
    // rust: horizon_material_face_normal = normal;
    // rust: horizon_surface = vec4<f32>(0.0);
    // rust: let tangent = horizon_material_tangent(in.base, in.uv, normal);
    // rust: return material(MaterialInput(albedo, in.tint, in.light, in.lightmap, in.position, in.uv,
    // rust: translucent, horizon_sprite_tags(in.layer & 0x7fffu),
    // rust: horizon_sprite_material(in.layer & 0x7fffu), in.clip.xy / frame.resolution,
    // rust: in.face, fluid, in.emission, normal, tangent,
    // rust: horizon_terrain_native_colored_light(in.position), in.displaced)).color;
}
    // rust: var<private> horizon_material_face_normal: vec3<f32>;
HorizonMaterialSolid :: struct {
    // rust: @location(0) color: vec4<f32>,
    // The surface target's data: `set_surface`'s, then the fragment's depth, which the post
    // stage's `surface_at` compares with the final depth.
    // Its four floats' bits (`SURFACE_FORMAT` is an integer format).
    // rust: @location(1) surface: vec4<u32>,
}
// What `fs_solid` leaves in the frame's alpha for HDR output, from the sprite before the pack's
// material: the pack decides the colour, Horizon still knows which pixels are light sources.
horizon_material_mark :: proc(in: HorizonMaterialOut, texel: vec4<f32>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if in.hdr_code > 0u {
    // rust: let whole = in.hdr_code > 4u;
    // rust: let tier = select(in.hdr_code, in.hdr_code - 4u, whole);
    // rust: let l = in.layer & 0x7fffu;
    // rust: let t = textureLoad(horizon_terrain_emission_thresholds,
    // rust: vec2(i32(l % horizon_terrain_SPRITE_SPLIT), i32(l / horizon_terrain_SPRITE_SPLIT)), 0);
    // rust: let y = horizon_terrain_brightness(texel.rgb);
    // rust: if whole || y >= t.r {
    // rust: return horizon_terrain_hdr_mark(tier, y);
}
}
    // rust: return 1.0;
}
    // rust: @fragment fn horizon_material_fs_solid(in: HorizonMaterialOut) -> HorizonMaterialSolid {
    // `[displacement]`'s grid draws these pixels.
    // rust: if length(in.base) < horizon_displace_distance - 0.05 && horizon_displaced_layer(in.layer) {
    // rust: discard;
}
    // rust: return horizon_material_solid(in);
}
horizon_material_solid :: proc(in: HorizonMaterialOut) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let color = horizon_material_color(in, false);
    // rust: let texel = horizon_terrain_sprite(in.uv, in.layer & 0x7fffu);
    // Bit 15 of the layer marks opaque leaves (forceOpaque): no alpha cutout.
    // rust: if color.a < 0.5 && (in.layer & 0x8000u) == 0u { discard; }
    // rust: if horizon_surface.w == 0.0 {
    // rust: set_surface(horizon_material_face_normal, 0.0, 0.0);
}
    // rust: var out: HorizonMaterialSolid;
    // rust: let mark = horizon_material_mark(in, texel);
    // rust: out.color = horizon_material_fogged(vec4(color.rgb, mark), in.spherical, in.cylindrical);
    // rust: out.surface = bitcast<vec4<u32>>(vec4(horizon_surface.xyz, in.clip.z));
    // rust: return out;
}
    // rust: @fragment fn horizon_material_fs_translucent(in: HorizonMaterialOut) -> @location(0) vec4<f32> {
    // rust: let color = horizon_material_color(in, true);
    // rust: if color.a < 0.01 { discard; }
    // rust: return horizon_material_fogged(color, in.spherical, in.cylindrical);
}
    // rust: ";

// `[displacement]`'s grid (gfx/displace.rs): one instance a quad the pick chose, its corners
// read from the copy of the arena, each of its cells two triangles moved along the face's
// normal by the pack's `displacement`, measured from the texture's mean height so that the
// face's edges, pinned there, meet their neighbours whatever their relief.
    // rust: const DISPLACED_ENTRIES: &str = "
    // rust: @vertex fn horizon_material_vs_displaced(@builtin(vertex_index) v: u32,
    // rust: @builtin(instance_index) instance: u32) -> HorizonMaterialOut {
    // rust: let p = horizon_displace_point(v, instance);
    // rust: var out = horizon_material_out(p.position, p.uv, p.layer, p.color, p.light);
    // rust: out.base = p.base;
    // rust: out.displaced = p.near;
    // rust: out.normal = p.normal;
    // rust: return out;
}
    // rust: @fragment fn horizon_material_fs_displaced(in: HorizonMaterialOut) -> HorizonMaterialSolid {
    // rust: if length(in.base) >= horizon_displace_distance + 0.05 {
    // rust: discard;
}
    // rust: return horizon_material_solid(in);
}
    // rust: ";

// What the material's displaced pipeline is built against: `[displacement]`'s values and
// its group 1.
DisplacedShape :: struct {
    distance: f32,
    cells: u32,
    steps: bool,
    layout: ^'a wgpu::BindGroupLayout,
}

// What terrain pipelines are built against: the renderer's layouts and constants.
TerrainShape :: struct {
    // The terrain's group 0.
    globals: ^'a wgpu::BindGroupLayout,
    // The flat draws' group 1, where they run (`flat.rs`).
    flat: Maybe(^'a wgpu::BindGroupLayout),
    // terrain.wgsl's `SPRITE_ARRAYS` and `SPRITE_SPLIT`.
    sprites: [f64,
    // The world target's colour format.
    format: wgpu::TextureFormat,
    // The pack's tags of each tagged sprite layer, as `(layer, bits)`
    // (`Manifest::sprite_tags`).
    sprite_tags: ^'a [(u32,
    // The pack's material id of each sprite layer with one, as `(layer, id)`
    // (`Manifest::sprite_materials`).
    sprite_materials: ^'a [(u32,
    // The entities' group 0 (their atlas), for the shadow pass's entity draw.
    entities: ^'a wgpu::BindGroupLayout,
    // The weather's groups 0 and 1 (the entities' atlas, the fall clock), for the weather
    // stage.
    weather_groups: [^'a wgpu::BindGroupLayout,
    // The resource packs' LabPBR maps (normals, specular), when they ship any.
    pbr: Option<^'a [wgpu::Texture,
}

// The pack's terrain pipelines: solid (with the cutout test) and translucent, for the
// renderer's instanced draws and, where they run, its flat ones.
NativeMaterial :: struct {
    solid: wgpu::RenderPipeline,
    translucent: wgpu::RenderPipeline,
    flat: Option<(wgpu::RenderPipeline,
    // `[displacement]`'s grid of the solid terrain near the camera (gfx/displace.rs).
    displaced: Maybe(wgpu::RenderPipeline),
    // The stage calls `set_surface`: its solid pipelines also write the surface target.
    writes_surface: bool,
}

// terrain.wgsl's terrain section (its globals, bindings, sampling, lighting and fog), with
// every name it declares prefixed.
vanilla_terrain :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: prefixed(
    // rust: section(TERRAIN, "struct Globals {", "// Sky (SkyRenderer)"),
    // rust: PREFIX,
    // rust: )
}

// The function `name(layer)`, the value of each sprite layer in `table` and 0 for the rest:
// `horizon_sprite_tags` (`MaterialInput.tags`) and `horizon_sprite_material`
// (`MaterialInput.material`).
    // rust: pub(super) fn layer_table(name: &str, table: &[(u32, u32)]) -> String {
    // rust: let mut out = format!("fn {name}(layer: u32) -> u32 {{\n    switch layer {{\n");
    // rust: let mut table = table.to_vec();
    // rust: table.sort_unstable_by_key(|&(layer, value)| (value, layer));
    // rust: for group in table.chunk_by(|a, b| a.1 == b.1) {
    // rust: let layers: Vec<String> = group.iter().map(|(layer, _)| format!("{layer}u")).collect();
    // rust: out += &format!(
    // rust: "        case {}: {{ return {}u; }}\n",
    // rust: layers.join(", "),
    // rust: group[0].1
    // rust: );
}
    // rust: out + "        default: { return 0u; }\n    }\n}\n"
}

// Where a corner of terrain is drawn without a vertex stage.
    // rust: pub(super) const DISPLACE_VANILLA: &str = "
    // rust: fn horizon_material_displace(pos: vec3<f32>, uv: vec2<f32>, layer: u32, color: vec4<f32>,
    // rust: light: vec2<u32>) -> vec3<f32> {
    // rust: return pos;
}
    // rust: ";

// The vertex stage's call, with its inputs from terrain's vertex.
    // rust: pub(super) const DISPLACE_PACK: &str = "
    // rust: fn horizon_material_displace(pos: vec3<f32>, uv: vec2<f32>, layer: u32, color: vec4<f32>,
    // rust: light: vec2<u32>) -> vec3<f32> {
    // rust: let flags = u32(round(color.a * 255.0));
    // rust: let high = flags >> 4u;
    // rust: let fluid = high >= 8u && (high & 7u) < 6u;
    // rust: let lit = min(vec2(f32(light.y), f32(light.x)) / 240.0, vec2(1.0));
    // rust: return vertex(VertexInput(pos, uv, horizon_sprite_material(layer & 0x7fffu), lit,
    // rust: vec4(color.rgb, 1.0), select(0u, high & 7u, fluid), u32(fluid)));
}
    // rust: ";

// The surface target (the post stage's `scene_surface`): the bits of four floats, x the normal
// (two snorm16 in its bits), y smoothness, z the pack's data, w the fragment's depth. Stored
// as unsigned integers, not `Rgba32Float`: RGBA32UI is colour-renderable on every backend,
// where OpenGL (GLES 3 semantics) refuses RGBA32F as a render attachment, and integers keep
// the packed normal's bits exact.
SURFACE_FORMAT :: wgpu::TextureFormat::Rgba32Uint

// The terrain shader for the pack's material stage `source`, with its sprite `tags` and
// `materials`, and the vertex stage in its module when `vertex`.
    // rust: fn shader_source(
    // rust: source: &str,
    // rust: tags: &[(u32, u32)],
    // rust: materials: &[(u32, u32)],
    // rust: vertex: bool,
    // rust: displaced: bool,
    // rust: ) -> String {
    // rust: format!(
    // rust: "{source}\n// Horizon's terrain (terrain.wgsl)\n{}{}{}{}{ENTRIES}{}{}",
    // rust: vanilla_terrain(),
    // rust: if vertex {
    // rust: DISPLACE_PACK
    // rust: } else {
    // rust: DISPLACE_VANILLA
    // rust: },
    // rust: layer_table("horizon_sprite_tags", tags),
    // rust: layer_table("horizon_sprite_material", materials),
    // rust: super::displace::RELIEF,
    // rust: if displaced {
    // rust: super::displace::GRID.to_owned() + DISPLACED_ENTRIES
    // rust: } else {
    // rust: String::new()
}
    // rust: )
}

// The material's naga module, its errors in the stage's file.
    // rust: fn module(
    // rust: stage: &CheckedStage,
    // rust: tags: &[(u32, u32)],
    // rust: materials: &[(u32, u32)],
    // rust: vertex: bool,
    // rust: displaced: bool,
    // rust: ) -> Result<naga::Module, String> {
    // rust: let text = shader_source(&stage.source, tags, materials, vertex, displaced);
    // rust: naga::front::wgsl::parse_str(&text)
    // rust: .map_err(|e| format!("{}: {}", stage.file, e.emit_to_string(&text)))
}

    // rust: impl NativeMaterial {
    // The pipelines of the pack's material `stage` with the option values `constants`.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: shape: &TerrainShape<'_>,
    // rust: frame: &NativeFrame,
    // rust: stage: &CheckedStage,
    // rust: constants: &[(String, f64)],
    // rust: fog: bool,
    // rust: vertex: bool,
    // rust: displaced: Option<&DisplacedShape<'_>>,
    // rust: ) -> Result<Self, String> {
    // rust: let writes_surface = horizon_shader_api::stages::calls_set_surface(&stage.source);
    // rust: let module = module(
    // rust: stage,
    // rust: shape.sprite_tags,
    // rust: shape.sprite_materials,
    // rust: vertex,
    // rust: displaced.is_some(),
    // rust: )?;
    // rust: let mut constants = present_constants(&module, constants);
    // rust: let sprite_names = [
    // rust: "horizon_terrain_SPRITE_ARRAYS",
    // rust: "horizon_terrain_SPRITE_SPLIT",
    // rust: ];
    // rust: constants.extend(sprite_names.into_iter().zip(shape.sprites));
    // rust: constants.push(("horizon_material_fog", f64::from(u8::from(fog))));
    // rust: constants.push((
    // rust: "horizon_displace_distance",
    // rust: displaced.map_or(0.0, |d| f64::from(d.distance)),
    // rust: ));
    // rust: if let Some(d) = displaced {
    // rust: constants.push(("horizon_displace_cells", f64::from(d.cells)));
    // rust: constants.push(("horizon_displace_steps", f64::from(u8::from(d.steps))));
}
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(&stage.label),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: });
    // rust: let layout = |flat: Option<&wgpu::BindGroupLayout>| {
    // rust: let mut groups: [Option<&wgpu::BindGroupLayout>; GROUP as usize + 1] =
    // rust: Default::default();
    // rust: groups[0] = Some(shape.globals);
    // rust: groups[1] = flat;
    // rust: groups[GROUP as usize] = Some(&frame.layout);
    // rust: device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Native shader pack terrain"),
    // rust: bind_group_layouts: &groups,
    // rust: ..Default::default()
    // rust: })
}
    // rust: let instance_attributes = wgpu::vertex_attr_array![5=>Float32x4];
    // rust: let vertices = wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<super::TerrainVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &super::TERRAIN_ATTRIBUTES,
}
    // rust: let instances = wgpu::VertexBufferLayout {
    // rust: array_stride: 16,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &instance_attributes,
}
        // As the renderer's terrain pipelines (gfx.rs): back faces culled, reversed depth.
    // rust: let pipeline = |layout: &wgpu::PipelineLayout,
    // rust: vertex: &str,
    // rust: buffers: &[Option<wgpu::VertexBufferLayout<'_>>],
    // rust: fragment: &str,
    // rust: blend: Option<wgpu::BlendState>| {
    // rust: let options = wgpu::PipelineCompilationOptions {
    // rust: constants: &constants,
    // rust: ..Default::default()
}
    // rust: let solid_targets = [
    // rust: Some(wgpu::ColorTargetState {
    // rust: format: shape.format,
    // rust: blend,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: }),
    // rust: Some(wgpu::ColorTargetState {
    // rust: format: SURFACE_FORMAT,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: }),
    // rust: ];
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(&stage.label),
    // rust: layout: Some(layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some(vertex),
    // rust: compilation_options: options.clone(),
    // rust: buffers,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: options,
    // rust: targets: if fragment != "horizon_material_fs_translucent" && writes_surface {
    // rust: &solid_targets
    // rust: } else {
    // rust: &solid_targets[..1]
    // rust: },
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let blend = Some(wgpu::BlendState::ALPHA_BLENDING);
    // rust: let instanced = layout(None);
    // rust: let buffers = [Some(vertices.clone()), Some(instances)];
    // rust: let solid = pipeline(
    // rust: &instanced,
    // rust: "horizon_material_vs",
    // rust: &buffers,
    // rust: "horizon_material_fs_solid",
    // rust: None,
    // rust: );
    // rust: let translucent = pipeline(
    // rust: &instanced,
    // rust: "horizon_material_vs",
    // rust: &buffers,
    // rust: "horizon_material_fs_translucent",
    // rust: blend,
    // rust: );
    // rust: let flat = shape.flat.map(|group| {
    // rust: let layout = layout(Some(group));
    // rust: let buffers = [Some(vertices.clone())];
    // rust: let vs = "horizon_material_vs_flat";
    // rust: (
    // rust: pipeline(&layout, vs, &buffers, "horizon_material_fs_solid", None),
    // rust: pipeline(
    // rust: &layout,
    // rust: vs,
    // rust: &buffers,
    // rust: "horizon_material_fs_translucent",
    // rust: blend,
    // rust: ),
    // rust: )
    // rust: });
        // The grid's corners come from its group 1, not from vertex buffers.
    // rust: let displaced = displaced.map(|d| {
    // rust: pipeline(
    // rust: &layout(Some(d.layout)),
    // rust: "horizon_material_vs_displaced",
    // rust: &[],
    // rust: "horizon_material_fs_displaced",
    // rust: None,
    // rust: )
    // rust: });
    // rust: if let Some(e) = pollster::block_on(scope.pop()) {
    // rust: return Err(format!("{}: {e}", stage.file));
}
    // rust: Ok(Self {
    // rust: solid,
    // rust: translucent,
    // rust: flat,
    // rust: displaced,
    // rust: writes_surface,
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_shader_api::{MANIFEST, Pack, StageKind, check};

stage :: proc(material: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let manifest = "schema = 1\nid = \"t\"\nname = \"T\"\nversion = \"1\"\napi = \"0.1\"\n\
    // rust: [material]\nfile = \"material.wgsl\"\n\
    // rust: [[options]]\nid = \"gain\"\nname = \"Gain\"\ntype = \"float\"\n\
    // rust: default = 1.0\nmin = 0.0\nmax = 2.0\n";
    // rust: let files = [(MANIFEST, manifest), ("material.wgsl", material)]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: let mut report = check(&Pack::from_files(files).unwrap()).unwrap();
    // rust: assert_eq!(report.stages[0].kind, StageKind::Material);
    // rust: report.stages.remove(0)
}

the_terrain_takes_a_prefix_and_validates_with_a_pack :: proc() {
}
    // rust: let terrain = vanilla_terrain();
    // rust: for name in [
    // rust: "Globals",
    // rust: "globals",
    // rust: "sprites_7",
    // rust: "sprite",
    // rust: "SPRITE_SPLIT",
    // rust: "block_slots",
    // rust: "sample_lightmap",
    // rust: "apply_fog",
    // rust: ] {
    // rust: assert!(terrain.contains(&format!("{PREFIX}{name}")), "{name}");
}
    // rust: assert!(!terrain.contains("fs_sky"), "the sky stays out");
        // A pack may use any name Horizon's terrain uses unprefixed.
    // rust: let own = "override gain: f32;\nconst PI: f32 = 3.0;\n\
sprite :: proc(c: vec4<f32>) -> v {
    // Ported from Horizon
    return {}
}
apply_fog :: proc(c: vec4<f32>) -> v {
    // Ported from Horizon
    return {}
}
material :: proc(input: MaterialInput) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lit = input.albedo * input.tint * vec4(input.lightmap, 1.0);\n    \
    // rust: let t = vec2<i32>(input.screen * frame.resolution);\n    \
    // rust: let behind = textureLoad(opaque_color, t, 0) * textureLoad(opaque_depth, t, 0);\n    \
    // rust: let mirrored = textureSampleLevel(reflection, reflection_sampler, input.screen, 0.0);\n    \
    // rust: let kind = f32(input.face + input.fluid) * input.emission * mirrored.a;\n    \
    // rust: let frame_of = vec4(cross(input.normal, input.tangent.xyz) * input.tangent.w, kind);\n    \
    // rust: return Surface(apply_fog(sprite(lit)) + (behind + frame_of) * 0.0);\n}\n";
    // rust: let stage = stage(own);
    // rust: let tags = [(7, 1), (3, 1), (9, 2)];
    // rust: let materials = [(5, 1000)];
    // rust: assert!(layer_table("t", &tags).contains("case 3u, 7u: { return 1u; }"));
    // rust: let module = module(&stage, &tags, &materials, false, false).unwrap();
    // rust: let info = naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap_or_else(|e| {
    // rust: panic!(
    // rust: "{}",
    // rust: e.emit_to_string(&shader_source(
    // rust: &stage.source,
    // rust: &tags,
    // rust: &materials,
    // rust: false,
    // rust: false
    // rust: ))
    // rust: )
    // rust: });
    // rust: let entries: Vec<&str> = module
    // rust: .entry_points
    // rust: .iter()
    // rust: .map(|e| e.name.as_str())
    // rust: .collect();
    // rust: for entry in [
    // rust: "horizon_material_vs",
    // rust: "horizon_material_vs_flat",
    // rust: "horizon_material_fs_solid",
    // rust: "horizon_material_fs_translucent",
    // rust: ] {
    // rust: assert!(entries.contains(&entry), "{entry}");
}
    // rust: drop(info);
    // rust: assert_eq!(
    // rust: present_constants(&module, &[("gain".into(), 1.5), ("other".into(), 1.0)]),
    // rust: [("gain", 1.5)]
    // rust: );
}

the_displaced_grid_validates_with_a_pack :: proc() {
}
    // rust: let manifest = "schema = 1\nid = \"t\"\nname = \"T\"\nversion = \"1\"\napi = \"0.1\"\n\
    // rust: [material]\nfile = \"material.wgsl\"\n[displacement]\n";
    // rust: let material = "fn material(input: MaterialInput) -> Surface {\n    \
    // rust: return Surface(input.albedo * (1.0 - 0.5 * input.displaced));\n}\n\
displacement :: proc(input: DisplacementInput) -> f {
    // Ported from Horizon
    return {}
}
    // rust: return (1.0 - input.height) * 0.125 * f32(input.material + 1u);\n}\n";
    // rust: let files = [(MANIFEST, manifest), ("material.wgsl", material)]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: let mut report = check(&Pack::from_files(files).unwrap()).unwrap();
    // rust: let stage = report.stages.remove(0);
    // rust: let materials = [(5, 1000)];
    // rust: let module = module(&stage, &[], &materials, false, true).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap_or_else(|e| {
    // rust: let text = shader_source(&stage.source, &[], &materials, false, true);
    // rust: panic!("{}", e.emit_to_string(&text))
    // rust: });
    // rust: for entry in [
    // rust: "horizon_material_vs_displaced",
    // rust: "horizon_material_fs_displaced",
    // rust: ] {
    // rust: assert!(
    // rust: module.entry_points.iter().any(|e| e.name == entry),
    // rust: "{entry}"
    // rust: );
}
}
}
