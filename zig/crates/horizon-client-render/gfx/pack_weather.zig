//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_weather
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Rain and snow drawn by a shader pack's `gbuffers_weather` (spec 2.3): the game's weather
//! quads as entity vertices, their UV animation applied here rather than in Horizon's weather
//! shader, each kind textured from its own copy of its sprite so that the pack's `texture`
//! repeats it across the column as a standalone rain or snow texture would.

// use crate::weather::{Time, Vertex as WeatherVertex};

// use super::Vertex;
// use super::pack_post::Weather;

/// What `gbuffers_weather` reads from a weather vertex: camera-relative position, the UV in
/// repeats of the sprite, colour (with vanilla's fade) and light. Weather has no normal; the
/// pack sees straight up.
pub fn inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let declarations =
    // rust: "layout(location = 0) in vec3 hz_v_pos;\nlayout(location = 1) in vec2 hz_v_uv;\n\
    // rust: layout(location = 2) in uint hz_v_overlay;\nlayout(location = 3) in vec4 hz_v_color;\n\
    // rust: layout(location = 4) in uvec4 hz_v_light;\nlayout(location = 5) in vec4 hz_v_normal;\n"
    // rust: .to_owned();
    // rust: let body = "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    \
    // rust: hz_MultiTexCoord0 = vec4(hz_v_uv, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(float(hz_v_light.y), float(hz_v_light.x), 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord2 = hz_MultiTexCoord1;\n    \
    // rust: hz_Color = hz_v_color;\n    \
    // rust: hz_Normal = vec3(0.0, 1.0, 0.0);\n"
    // rust: .to_owned();
    // rust: let attributes = [
    // rust: ("vaPosition", "hz_Vertex.xyz"),
    // rust: ("vaUV0", "hz_v_uv"),
    // rust: ("vaUV2", "ivec2(hz_MultiTexCoord1.xy)"),
    // rust: ("vaColor", "hz_Color"),
    // rust: ("vaNormal", "hz_Normal"),
    // rust: ];
    // rust: horizon_shaders::GbuffersInputs {
    // rust: declarations,
    // rust: body,
    // rust: attributes: attributes
    // rust: .iter()
    // rust: .map(|&(n, v)| (n.to_owned(), v.to_owned()))
    // rust: .collect(),
    // rust: after: String::new(),
        // Vanilla's weather drops texels below 0.1, as Horizon's own weather shader does.
    // rust: alpha_test: Some(horizon_shaders::AlphaTest {
    // rust: op: ">",
    // rust: reference: 0.1,
    // rust: }),
    // rust: item_id_declared: false,
    // rust: far_depth: false,
}
}

/// The UV phase of `v` at `time`: `weather_phase` of entity.wgsl, on the CPU.
pub fn phase(v: *WeatherVertex, time: Time) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [ticks, fall_ticks, partial, _] = time.values;
    // rust: let a = v.animation;
    // rust: if v.snow == 0 {
    // rust: let t = ticks + a[1] + partial;
    // rust: return [0.0, (-t / 32.0 * a[0]) % 32.0];
}
    // rust: let t = ticks + partial;
    // rust: let du = t * 0.01 * a[2];
    // rust: let dv = t * a[3] * 0.001;
    // rust: let base = |lo: u32, hi: u32| f64::from_bits(u64::from(lo) | u64::from(hi) << 32);
    // rust: let u = (base(v.bases[0], v.bases[1]) + f64::from(du)) as f32;
    // rust: let v_base = (base(v.bases[2], v.bases[3]) + f64::from(dv)) as f32;
    // rust: [u, -(fall_ticks + partial) / 512.0 + v_base]
}

/// One kind's sprite copied out of the shared atlas: the sprite's rectangle (bits) and its view.
    // rust: type Sprite = Option<([u32; 4], wgpu::TextureView)>;

/// The pack's weather vertices and the rain and snow sprites, kept across frames.
pub const PackWeather = struct {
    vertices: wgpu::Buffer,
    capacity: usize,
    scratch: std.ArrayList(Vertex),
    sprites: [Sprite,
    /// Bumped when a sprite is copied again.
    generation: u64,
};

    // rust: impl PackWeather {
pub fn new(device: *wgpu::Device) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: vertices: Self::buffer(device, 64),
    // rust: capacity: 64,
    // rust: scratch: Vec::new(),
    // rust: sprites: [None, None],
    // rust: generation: 0,
}
}

pub fn buffer(device: *wgpu::Device, capacity: usize) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack weather"),
    // rust: size: (capacity * std::mem::size_of::<Vertex>()) as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}

    /// This frame's rain then snow (the game emits them in that order) as entity vertices, and
    /// the sprites they read. `None` when there is none.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: atlas: &wgpu::Texture,
    // rust: weather: &[WeatherVertex],
    // rust: time: Time,
    // rust: indices: &wgpu::Buffer,
    // rust: ) -> Option<Weather> {
    // rust: if weather.is_empty() {
    // rust: return None;
}
    // rust: let rain = weather.iter().take_while(|v| v.snow == 0).count() as u32 / 4;
    // rust: let snow = weather.len() as u32 / 4 - rain;
    // rust: for (kind, first) in [(0, weather.first()), (1, weather.get(rain as usize * 4))] {
    // rust: let Some(first) = first.filter(|v| v.snow as usize == kind) else {
    // rust: continue;
}
    // rust: let key = first.rect.map(f32::to_bits);
    // rust: if self.sprites[kind].as_ref().is_none_or(|s| s.0 != key) {
    // rust: let view = copy_sprite(device, encoder, atlas, first.rect);
    // rust: self.sprites[kind] = Some((key, view));
    // rust: self.generation += 1;
}
}
    // rust: self.scratch.clear();
    // rust: self.scratch.extend(weather.iter().map(|v| {
    // rust: let [du, dv] = phase(v, time);
    // rust: Vertex {
    // rust: pos: v.pos,
    // rust: uv: [v.uv[0] + du, v.uv[1] + dv],
    // rust: layer: 0,
    // rust: color: v.color,
    // rust: light: v.light,
    // rust: normal: [0; 4],

    // rust: glint_uv: [0.0, 0.0],
}
    // rust: }));
    // rust: if self.scratch.len() > self.capacity {
    // rust: self.capacity = self.scratch.len().next_power_of_two();
    // rust: self.vertices = Self::buffer(device, self.capacity);
}
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.vertices,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.scratch),
    // rust: );
    // rust: let view = |k: usize| self.sprites[k].as_ref().map(|s| s.1.clone());
    // rust: Some(Weather {
    // rust: vertices: self.vertices.clone(),
    // rust: indices: indices.clone(),
    // rust: quads: [0..rain, rain..rain + snow],
    // rust: sprites: [view(0), view(1)],
    // rust: generation: self.generation,
    // rust: })
}
}

/// A texture holding the atlas's texels under `rect` (normalised x, y, width, height), as
/// Horizon's weather shader reads them (`weather_texel`).
    // rust: pub(super) fn copy_sprite(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: atlas: &wgpu::Texture,
    // rust: rect: [f32; 4],
    // rust: ) -> wgpu::TextureView {
    // rust: let size = [atlas.width() as f32, atlas.height() as f32];
    // rust: let origin = [0, 1].map(|i| (rect[i] * size[i]).round() as u32);
    // rust: let extent = [0, 1].map(|i| ((rect[i + 2] * size[i]).round() as u32).max(1));
    // rust: let extent = [0, 1].map(|i| {
    // rust: extent[i].min(
    // rust: [atlas.width(), atlas.height()][i]
    // rust: .saturating_sub(origin[i])
    // rust: .max(1),
    // rust: )
    // rust: });
    // rust: let size = wgpu::Extent3d {
    // rust: width: extent[0],
    // rust: height: extent[1],
    // rust: depth_or_array_layers: 1,
}
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack weather sprite"),
    // rust: size,
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: atlas.format(),
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: encoder.copy_texture_to_texture(
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture: atlas,
    // rust: mip_level: 0,
    // rust: origin: wgpu::Origin3d {
    // rust: x: origin[0],
    // rust: y: origin[1],
    // rust: z: 0,
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture: &texture,
    // rust: mip_level: 0,
    // rust: origin: wgpu::Origin3d::ZERO,
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: size,
    // rust: );
    // rust: texture.create_view(&Default::default())
}

    // rust: mod tests {
//     use super::*;
//     use crate::weather::Parameters;

    /// The CPU phase matches the game's own weather columns (`Parameters::column`), which
    /// Horizon's weather shader is tested against.
pub fn phase_matches_the_weather_columns() void {
}
    // rust: for i in 0..512i32 {
    // rust: let x = i.wrapping_mul(45_238_971);
    // rust: let z = i.wrapping_mul(-418_711).wrapping_add(i32::MIN);
    // rust: let p = Parameters::new(x, z);
    // rust: let bases = p.snow_base.map(f64::to_bits);
    // rust: for ticks in [0, 511, 512, 131_071, 131_072, 1_000_003] {
    // rust: let partial = [0.0, 0.5, 0.999][i as usize % 3];
    // rust: for snow in [false, true] {
    // rust: let column = p.column(snow, ticks, x, -64, 320, z, 0, partial);
    // rust: let v = WeatherVertex {
    // rust: pos: [0.0; 3],
    // rust: uv: [0.0; 2],
    // rust: rect: [0.0; 4],
    // rust: animation: [
    // rust: p.rain_speed,
    // rust: p.rain_tick_offset,
    // rust: p.snow_drift[0],
    // rust: p.snow_drift[1],
    // rust: ],
    // rust: bases: [
    // rust: bases[0] as u32,
    // rust: (bases[0] >> 32) as u32,
    // rust: bases[1] as u32,
    // rust: (bases[1] >> 32) as u32,
    // rust: ],
    // rust: color: 0,
    // rust: light: 0,
    // rust: snow: u32::from(snow),
}
    // rust: let [u, v] = phase(&v, Time::new(ticks, partial));
    // rust: assert_eq!(
    // rust: [u.to_bits(), v.to_bits()],
    // rust: [column.u_offset.to_bits(), column.v_offset.to_bits()],
    // rust: "x {x} z {z} ticks {ticks} snow {snow}"
    // rust: );
}
}
}
}
}
