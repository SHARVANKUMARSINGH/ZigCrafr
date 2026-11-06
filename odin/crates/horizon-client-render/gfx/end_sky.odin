//! Transpiled from Horizon Rust crate
package horizon_client_render_end_sky

import "core:fmt"
import "core:mem"
import "core:math"

// The End sky's six tiled faces, retained for the lifetime of the renderer's atlas.
// use crate::mesher::Vertex;
// use wgpu::util::DeviceExt;

VERTICES :: 6 * 16 * 16 * 4

    // rust: pub(super) struct EndSky {
    // rust: mesh: Option<([f32; 4], wgpu::Buffer)>,
}

    // rust: impl EndSky {
    // Called only when the End sky is enabled. Rebuild on atlas UV changes;
    // resource reload and device recreation also replace the owning renderer.
    // rust: pub(super) fn prepare(&mut self, device: &wgpu::Device, uv: Option<[f32; 4]>) {
    // rust: let Some(uv) = uv else {
    // rust: self.mesh = None;
    // rust: return;
}
    // rust: if self.mesh.as_ref().is_some_and(|(old, _)| *old == uv) {
    // rust: return;
}
    // rust: let vertices = vertices(uv);
    // rust: let buffer = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("End sky vertices"),
    // rust: contents: bytemuck::cast_slice(&vertices),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: self.mesh = Some((uv, buffer));
}

    // The celestial pipeline, atlas bind group and quad indices are already bound.
    // rust: pub(super) fn draw(&self, pass: &mut wgpu::RenderPass<'_>) {
    // rust: if let Some((_, buffer)) = &self.mesh {
    // rust: pass.set_vertex_buffer(0, buffer.slice(..));
    // rust: pass.draw_indexed(0..VERTICES / 4 * 6, 0, 0..1);
}
}
}

// SkyRenderer.buildEndSky: six faces of end_sky.png tiled 16 times,
// tinted 0x282828. The atlas does not wrap, so each face is 16×16 quads.
vertices :: proc(uv: [f32; 4]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(VERTICES as usize);
//     use std::f32::consts::FRAC_PI_2;
    // rust: let faces = [
    // rust: glam::Mat4::IDENTITY,
    // rust: glam::Mat4::from_rotation_x(FRAC_PI_2),
    // rust: glam::Mat4::from_rotation_x(-FRAC_PI_2),
    // rust: glam::Mat4::from_rotation_x(std::f32::consts::PI),
    // rust: glam::Mat4::from_rotation_z(FRAC_PI_2),
    // rust: glam::Mat4::from_rotation_z(-FRAC_PI_2),
    // rust: ];
    // rust: let step = 200.0 / 16.0;
    // rust: for pose in faces {
    // rust: for a in 0..16 {
    // rust: for b in 0..16 {
    // rust: let (x0, z0) = (-100.0 + step * a as f32, -100.0 + step * b as f32);
    // rust: let (x1, z1) = (x0 + step, z0 + step);
    // rust: let corners = [
    // rust: (x0, z0, [uv[0], uv[1]]),
    // rust: (x0, z1, [uv[0], uv[3]]),
    // rust: (x1, z1, [uv[2], uv[3]]),
    // rust: (x1, z0, [uv[2], uv[1]]),
    // rust: ];
    // rust: for (x, z, uv) in corners {
    // rust: let p = pose.transform_point3(glam::Vec3::new(x, -100.0, z));
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.to_array(),
    // rust: uv,
    // rust: layer: 2,
    // rust: color: 0xFF28_2828,
    // rust: light: 0,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
    // rust: out
}

    // rust: mod tests;
