//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_sky
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The vanilla sky's geometry for a shader pack's `gbuffers_skybasic` (spec 2.3): the sky disc,
//! the sunset fan, the stars and the void disc, as Horizon's own sky draws them (terrain.wgsl,
//! stars.rs), built once into a vertex buffer. The frame's colours and rotations sit in a small
//! uniform (set 1) that the vertex inputs read. `gbuffers_skytextured` draws the frame's sun and
//! moon quads, textured from the shared atlas.

// use std::ops::Range;

// use wgpu::util::DeviceExt;

/// A sky vertex: a position and what it belongs to (`SKY`...).
pub const Vertex = struct {
    pos: [f32,
    kind: u32,
};

pub const SKY: u32 = 0;
pub const SUNSET_APEX: u32 = 1;
/// Rim of the sunset fan: `pos.xy` is (sin, cos) of its angle.
pub const SUNSET_RIM: u32 = 2;
pub const STAR: u32 = 3;
pub const VOID: u32 = 4;

/// The frame's sky (std140).
pub const Uniform = struct {
    /// Camera-relative world from star space.
    stars: [[f32,
    /// Sky colour, alpha 1.
    color: [f32,
    /// Sunset colour and alpha.
    sunrise: [f32,
    /// cos and sin of the sunset fan's turn, star brightness.
    sun: [f32,
};

/// A sun or moon vertex: position, atlas UV, RGBA8 colour.
pub const Celestial = struct {
    pos: [f32,
    uv: [f32,
    color: u32,
};

/// Quads of the sun and moon (and room to spare).
pub const CELESTIAL_QUADS: usize = 4;

    // rust: const CELESTIAL_ATTRIBUTES: [wgpu::VertexAttribute; 3] =
    // rust: wgpu::vertex_attr_array![0 => Float32x3, 1 => Float32x2, 2 => Unorm8x4];

    // rust: pub(super) const ATTRIBUTES: [wgpu::VertexAttribute; 2] =
    // rust: wgpu::vertex_attr_array![0 => Float32x3, 1 => Uint32];

/// What `gbuffers_skybasic` reads from these vertices.
pub fn inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let declarations =
    // rust: "layout(location = 0) in vec3 hz_v_pos;\nlayout(location = 1) in uint hz_v_kind;\n\
    // rust: layout(set = 1, binding = 0) uniform HzSky { mat4 hz_sky_stars; vec4 hz_sky_color; \
    // rust: vec4 hz_sky_sunrise; vec4 hz_sky_sun; };\n"
    // rust: .to_owned();
    // rust: let body = format!(
    // rust: "    vec3 hz_p = hz_v_pos;\n    \
    // rust: hz_Color = hz_sky_color;\n    \
    // rust: if (hz_v_kind == {SUNSET_APEX}u || hz_v_kind == {SUNSET_RIM}u) {{\n        \
    // rust: vec3 hz_l = vec3(0.0, 100.0, 0.0);\n        \
    // rust: hz_Color = hz_sky_sunrise;\n        \
    // rust: if (hz_v_kind == {SUNSET_RIM}u) {{\n            \
    // rust: hz_l = vec3(hz_v_pos.xy * 120.0, -hz_v_pos.y * 40.0 * hz_sky_sunrise.a);\n            \
    // rust: hz_Color.a = 0.0;\n        \
    // rust: }}\n        \
    // rust: vec3 hz_r = vec3(hz_l.x * hz_sky_sun.x - hz_l.y * hz_sky_sun.y, hz_l.x * hz_sky_sun.y + hz_l.y * hz_sky_sun.x, hz_l.z);\n        \
    // rust: hz_p = vec3(hz_r.x, -hz_r.z, hz_r.y);\n    \
    // rust: }} else if (hz_v_kind == {STAR}u) {{\n        \
    // rust: hz_p = (hz_sky_stars * vec4(hz_v_pos, 1.0)).xyz;\n        \
    // rust: hz_Color = vec4(hz_sky_sun.z);\n    \
    // rust: }} else if (hz_v_kind == {VOID}u) {{\n        \
    // rust: hz_Color = vec4(0.0, 0.0, 0.0, 1.0);\n    \
    // rust: }}\n    \
    // rust: hz_Vertex = vec4(hz_p, 1.0);\n    \
    // rust: hz_MultiTexCoord0 = vec4(0.0, 0.0, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(240.0, 240.0, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord2 = hz_MultiTexCoord1;\n    \
    // rust: hz_Normal = vec3(0.0, 0.0, 1.0);\n"
    // rust: );
    // rust: horizon_shaders::GbuffersInputs {
    // rust: declarations,
    // rust: body,
    // rust: attributes: vec![
    // rust: ("vaPosition".into(), "hz_Vertex.xyz".into()),
    // rust: ("vaColor".into(), "hz_Color".into()),
    // rust: ("vaNormal".into(), "hz_Normal".into()),
    // rust: ],
        // Tested at the far plane: the sky shows only where nothing else drew, and it writes no
        // depth. Its fragments read their own depth, as in Iris.
    // rust: after: String::new(),
    // rust: alpha_test: None,
    // rust: item_id_declared: false,
    // rust: far_depth: true,
}
}

/// What `gbuffers_skytextured` reads from the sun and moon's vertices.
pub fn celestial_inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_shaders::GbuffersInputs {
    // rust: declarations:
    // rust: "layout(location = 0) in vec3 hz_v_pos;\nlayout(location = 1) in vec2 hz_v_uv;\n\
    // rust: layout(location = 2) in vec4 hz_v_color;\n"
    // rust: .into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    \
    // rust: hz_MultiTexCoord0 = vec4(hz_v_uv, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(240.0, 240.0, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord2 = hz_MultiTexCoord1;\n    \
    // rust: hz_Color = hz_v_color;\n    \
    // rust: hz_Normal = vec3(0.0, 0.0, 1.0);\n"
    // rust: .into(),
    // rust: attributes: vec![
    // rust: ("vaPosition".into(), "hz_Vertex.xyz".into()),
    // rust: ("vaUV0".into(), "hz_v_uv".into()),
    // rust: ("vaColor".into(), "hz_Color".into()),
    // rust: ("vaNormal".into(), "hz_Normal".into()),
    // rust: ],
    // rust: after: String::new(),
    // rust: alpha_test: None,
    // rust: item_id_declared: false,
    // rust: far_depth: true,
}
}

/// One draw of the sky: its render stage, whether `gbuffers_skytextured` draws it, its vertices.
    // rust: pub(super) struct Part {
    // rust: pub stage: &'static str,
    // rust: pub textured: bool,
    // rust: pub range: Range<u32>,
}

/// A disc fan at height `y`, radius 512, as triangles (SkyRenderer's sky and void discs).
pub fn disc(y: f32, kind: u32, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: let sign = y.signum();
    // rust: let rim = |i: i32| {
    // rust: let a = (i as f32).to_radians();
    // rust: Vertex {
    // rust: pos: [sign * 512.0 * a.cos(), y, 512.0 * a.sin()],
    // rust: kind,
}
}
    // rust: let centre = Vertex {
    // rust: pos: [0.0, y, 0.0],
    // rust: kind,
}
    // rust: for i in (-180..180).step_by(45) {
    // rust: out.extend([centre, rim(i), rim(i + 45)]);
}
}

/// Cover the horizon and downward sky rays as well as the upper vanilla disc.
/// Uncovered directions retain the buffer's clear colour, affecting later sky/fog
/// compositing. Enclosing the camera gives the sky program fragments there too.
/// Depth stays at the far plane through `inputs`, so terrain remains in front.
pub fn horizon(out: *mut std.ArrayList(Vertex)) void {
}
    // rust: let corners = [
    // rust: [-512.0, -512.0, -512.0],
    // rust: [512.0, -512.0, -512.0],
    // rust: [512.0, 512.0, -512.0],
    // rust: [-512.0, 512.0, -512.0],
    // rust: [-512.0, -512.0, 512.0],
    // rust: [512.0, -512.0, 512.0],
    // rust: [512.0, 512.0, 512.0],
    // rust: [-512.0, 512.0, 512.0],
    // rust: ];
    // rust: for [a, b, c, d] in [
    // rust: [0, 1, 2, 3],
    // rust: [4, 7, 6, 5],
    // rust: [0, 4, 5, 1],
    // rust: [3, 2, 6, 7],
    // rust: [0, 3, 7, 4],
    // rust: [1, 5, 6, 2],
    // rust: ] {
    // rust: for i in [a, b, c, a, c, d] {
    // rust: out.push(Vertex {
    // rust: pos: corners[i],
    // rust: kind: SKY,
    // rust: });
}
}
}

    // rust: pub(super) struct PackSky {
    // rust: vertices: wgpu::Buffer,
    // rust: celestial: wgpu::Buffer,
    // rust: uniform: wgpu::Buffer,
    // rust: pub layout: wgpu::BindGroupLayout,
    // rust: group: wgpu::BindGroup,
    /// Vertex ranges of the sky disc, the sunset fan, the stars and the void.
    // rust: ranges: [Range<u32>; 4],
}

    // rust: impl PackSky {
pub fn new(device: *wgpu::Device) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = Vec::new();
    // rust: horizon(&mut v);
    // rust: disc(16.0, SKY, &mut v);
    // rust: let sky = 0..v.len() as u32;
    // rust: let apex = Vertex {
    // rust: pos: [0.0; 3],
    // rust: kind: SUNSET_APEX,
}
    // rust: let rim = |i: u32| {
    // rust: let a = i as f32 * std::f32::consts::TAU / 16.0;
    // rust: Vertex {
    // rust: pos: [a.sin(), a.cos(), 0.0],
    // rust: kind: SUNSET_RIM,
}
}
    // rust: for i in 0..16 {
    // rust: v.extend([apex, rim(i), rim(i + 1)]);
}
    // rust: let sunset = sky.end..v.len() as u32;
    // rust: v.extend(
    // rust: super::stars::star_triangles()
    // rust: .into_iter()
    // rust: .map(|pos| Vertex { pos, kind: STAR }),
    // rust: );
    // rust: let stars = sunset.end..v.len() as u32;
    // rust: disc(-4.0, VOID, &mut v);
    // rust: let void = stars.end..v.len() as u32;
    // rust: let vertices = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Shader pack sky"),
    // rust: contents: bytemuck::cast_slice(&v),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let celestial = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack sun and moon"),
    // rust: size: (std::mem::size_of::<Celestial>() * 6 * CELESTIAL_QUADS) as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack sky"),
    // rust: size: std::mem::size_of::<Uniform>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack sky"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack sky"),
    // rust: layout: &layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: uniform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: Self {
    // rust: vertices,
    // rust: celestial,
    // rust: uniform,
    // rust: layout,
    // rust: group,
    // rust: ranges: [sky, sunset, stars, void],
}
}

pub fn buffers() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRIBUTES,
    // rust: })]
}

pub fn celestial_buffers() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Celestial>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &CELESTIAL_ATTRIBUTES,
    // rust: })]
}

    /// Writes the frame's sky and returns its draws in vanilla's order: the disc, the sunset
    /// fan while the sun is near the horizon, the sun and the moon, the stars and, with the
    /// camera low, the void. `tilt` is the pack's `sunPathRotation` (degrees): the sun, moon
    /// and stars turn with it (7.1).
pub fn prepare(self: *Self, queue: *wgpu::Queue, frame: *super::Frame, tilt: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let turn = super::pack_uniforms::tilt_matrix(tilt);
    // rust: let sun_angle = frame.sky.sun_angle.to_radians();
        // The fan turns to the other horizon in the afternoon (terrain.wgsl's sunrise_weight).
    // rust: let flip = if sun_angle.sin() < 0.0 { 180f32 } else { 0.0 };
    // rust: let theta = (flip + 90.0).to_radians();
    // rust: let (rotation, brightness) = frame.stars.unwrap_or_default();
    // rust: let [r, g, b] = frame.sky.sky_color;
    // rust: let uniform = Uniform {
    // rust: stars: (turn * rotation).to_cols_array_2d(),
    // rust: color: [r, g, b, 1.0],
    // rust: sunrise: frame.sky.sunrise_color,
    // rust: sun: [theta.cos(), theta.sin(), brightness.clamp(0.0, 1.0), 0.0],
}
    // rust: queue.write_buffer(&self.uniform, 0, bytemuck::bytes_of(&uniform));
        // The sun's quad, then the moon's (Game::celestial_geometry), as triangles.
    // rust: let quads = frame
    // rust: .celestial
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .take(CELESTIAL_QUADS);
    // rust: let triangles: Vec<Celestial> = quads
    // rust: .clone()
    // rust: .flat_map(|q| [0, 1, 2, 0, 2, 3].map(|i| q[i]))
    // rust: .map(|v| Celestial {
    // rust: pos: turn.transform_vector3(v.pos.into()).into(),
    // rust: uv: v.uv,
    // rust: color: v.color,
    // rust: })
    // rust: .collect();
    // rust: queue.write_buffer(&self.celestial, 0, bytemuck::cast_slice(&triangles));
    // rust: let [sky, sunset, stars, void] = self.ranges.clone();
    // rust: let part = |stage, textured, range| Part {
    // rust: stage,
    // rust: textured,
    // rust: range,
}
    // rust: let mut parts = vec![part("SKY", false, sky)];
    // rust: if frame.sky.sunrise_color[3] > 0.001 {
    // rust: parts.push(part("SUNSET", false, sunset));
}
    // rust: for (i, stage) in ["SUN", "MOON"].into_iter().enumerate().take(quads.len()) {
    // rust: parts.push(part(stage, true, i as u32 * 6..i as u32 * 6 + 6));
}
    // rust: if frame.stars.is_some() {
    // rust: parts.push(part("STARS", false, stars));
}
    // rust: if frame.dark_disc {
    // rust: parts.push(part("VOID", false, void));
}
    // rust: parts
}

    /// Binds the vertices of the `textured` (sun and moon) or other parts.
pub fn bind(self: *Self, pass: *mut wgpu::RenderPass<'_>, textured: bool) void {
}
    // rust: if textured {
    // rust: pass.set_vertex_buffer(0, self.celestial.slice(..));
    // rust: } else {
    // rust: pass.set_bind_group(1, &self.group, &[]);
    // rust: pass.set_vertex_buffer(0, self.vertices.slice(..));
}
}
}
