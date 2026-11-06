//! Transpiled from Horizon Rust crate
package horizon_client_render_stars

import "core:fmt"
import "core:mem"
import "core:math"

// The night sky's stars, built once into a static vertex buffer as
// `SkyRenderer.buildStars` does, and drawn each frame with one small uniform
// (the sky's rotation and the star brightness) instead of being regenerated
// and uploaded every frame.
// use glam::{Mat4, Vec3};
// use horizon_core::random::RandomSource;
// use wgpu::util::DeviceExt;

// `SkyRenderer.buildStars` with its fixed seed: up to 1500 quads on a
// sphere of radius 100, each turned to face the centre and spun about its
// own axis, as triangles (two per quad).
star_triangles :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut random = horizon_core::random::LegacyRandom::new(10842);
    // rust: let mut out = Vec::with_capacity(1500 * 6);
    // rust: for _ in 0..1500 {
    // rust: let x = random.next_float() * 2.0 - 1.0;
    // rust: let y = random.next_float() * 2.0 - 1.0;
    // rust: let z = random.next_float() * 2.0 - 1.0;
    // rust: let size = 0.15 + random.next_float() * 0.1;
    // rust: let l = x * x + y * y + z * z;
    // rust: if l <= 0.010_000_001 || l >= 1.0 {
    // rust: continue;
}
    // rust: let center = Vec3::new(x, y, z).normalize() * 100.0;
    // rust: let z_rot = (random.next_double() * std::f64::consts::TAU) as f32;
        // Matrix3f.rotateTowards(-center, up).rotateZ(-zRot).
    // rust: let forward = -center.normalize();
    // rust: let right = Vec3::Y.cross(forward).normalize_or(Vec3::X);
    // rust: let up = forward.cross(right);
    // rust: let (s, c) = (-z_rot).sin_cos();
    // rust: let (r2, u2) = (right * c + up * s, up * c - right * s);
    // rust: let corner = |a: f32, b: f32| (center + r2 * a + u2 * b).to_array();
    // rust: let quad = [
    // rust: corner(size, -size),
    // rust: corner(size, size),
    // rust: corner(-size, size),
    // rust: corner(-size, -size),
    // rust: ];
    // rust: out.extend([quad[0], quad[1], quad[2], quad[0], quad[2], quad[3]]);
}
    // rust: out
}

Uniform :: struct {
    clip_from_sky: [[f32,
    color: [f32,
}

    // rust: pub(super) struct Stars {
    // rust: pipeline: wgpu::RenderPipeline,
    // rust: group: wgpu::BindGroup,
    // rust: uniform: wgpu::Buffer,
    // rust: vertices: wgpu::Buffer,
    // rust: count: u32,
}

    // rust: impl Stars {
    // rust: pub(super) fn new(device: &wgpu::Device, format: wgpu::TextureFormat) -> Self {
    // rust: let triangles = star_triangles();
    // rust: let vertices = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Stars vertex buffer"),
    // rust: contents: bytemuck::cast_slice(&triangles),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Stars rotation and brightness"),
    // rust: size: std::mem::size_of::<Uniform>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Stars bindings"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Stars resources"),
    // rust: layout: &layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: uniform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Stars shader"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("stars.wgsl").into()),
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Stars layout"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let attributes = wgpu::vertex_attr_array![0 => Float32x3];
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Stars"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_stars"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_stars"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
                    // RenderPipelines.STARS: the celestial blend (src alpha, one), with the
                    // colour premultiplied in fs_stars, so its alpha can carry HDR's mark.
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent::REPLACE,
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: Self {
    // rust: pipeline,
    // rust: group,
    // rust: uniform,
    // rust: vertices,
    // rust: count: triangles.len() as u32,
}
}

    // This frame's sky rotation (camera-relative world from star space,
    // times the view projection) and star brightness.
    // rust: pub(super) fn prepare(
    // rust: &self,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: clip_from_sky: Mat4,
    // rust: brightness: f32,
    // rust: ) {
    // rust: let b = brightness.clamp(0.0, 1.0);
    // rust: let uniform = Uniform {
    // rust: clip_from_sky: clip_from_sky.to_cols_array_2d(),
    // rust: color: [b; 4],
}
    // rust: uploads.buffer(encoder, &self.uniform, 0, bytemuck::bytes_of(&uniform));
}

    // rust: pub(super) fn draw(&self, pass: &mut wgpu::RenderPass<'_>) {
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_vertex_buffer(0, self.vertices.slice(..));
    // rust: pass.draw(0..self.count, 0..1);
}
}

    // rust: mod tests {
//     use super::*;

stars_lie_on_the_sky_sphere_as_whole_quads :: proc() {
}
    // rust: let triangles = star_triangles();
        // About 52% of the cube's random points fall inside the unit ball.
    // rust: assert!((700 * 6..1500 * 6).contains(&triangles.len()));
    // rust: assert_eq!(triangles.len() % 6, 0);
    // rust: for p in &triangles {
    // rust: let r = Vec3::from_array(*p).length();
    // rust: assert!((99.9..100.1).contains(&r), "{r}");
}
    // rust: assert_eq!(triangles, star_triangles());
}
}
