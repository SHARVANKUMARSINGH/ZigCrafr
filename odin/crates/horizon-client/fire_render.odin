//! Transpiled from Horizon Rust crate
package horizon_client_fire_render

import "core:fmt"
import "core:mem"
import "core:math"

// Animated burning-entity flames; the first-person overlay uses screen_effects.
// use crate::{hud::Rect, mesher::Vertex};
// use std::collections::HashMap;

    // rust: pub fn flames(
    // rust: position: [f64; 3],
    // rust: width: f32,
    // rust: height: f32,
    // rust: camera: glam::DVec3,
    // rust: yaw: f32,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: scene_light: u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let (Some(a), Some(b)) = (sprites.get("block/fire_0"), sprites.get("block/fire_1")) else {
    // rust: return;
}
    // rust: let scale = width * 1.4;
    // rust: if scale <= 0.0 {
    // rust: return;
}
    // rust: let origin = glam::DVec3::from(position) - camera;
    // rust: let rotation = glam::Mat3::from_rotation_y(std::f32::consts::PI - yaw.to_radians());
    // rust: let mut remaining = height / scale;
    // rust: let mut half = 0.5f32;
    // rust: let mut y = 0.0f32;
    // rust: let mut z = 0.3 - (remaining as i32) as f32 * 0.02;
    // rust: let mut index = 0;
    // rust: while remaining > 0.0 {
    // rust: let r = if index % 2 == 0 { a } else { b };
    // rust: let (u0, u1) = if (index / 2) % 2 == 0 {
    // rust: (r.u0, r.u1)
    // rust: } else {
    // rust: (r.u1, r.u0)
}
    // rust: for (p, uv) in [
    // rust: ([-half, y, z], [u0, r.v1]),
    // rust: ([half, y, z], [u1, r.v1]),
    // rust: ([half, y + 1.4, z], [u1, r.v0]),
    // rust: ([-half, y + 1.4, z], [u0, r.v0]),
    // rust: ] {
    // rust: let p = origin.as_vec3() + rotation * (glam::Vec3::from(p) * scale);
    // rust: out.push(Vertex {
    // rust: pos: p.to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xffff_ffff,
    // rust: light: 0xf000 | (u32::from(scene_light >> 4) * 16),
    // rust: normal: [0; 4],

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
    // rust: remaining -= 0.45;
    // rust: y += 0.45;
    // rust: half *= 0.9;
    // rust: z -= 0.03;
    // rust: index += 1;
}
}

    // rust: mod tests {
flames_cover_entity_height_and_alternate_animated_sprites :: proc() {
}
    // rust: let rect = |u0| super::Rect {
    // rust: u0,
    // rust: v0: 0.0,
    // rust: u1: u0 + 0.1,
    // rust: v1: 0.1,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: let sprites = super::HashMap::from([
    // rust: ("block/fire_0".into(), rect(0.0)),
    // rust: ("block/fire_1".into(), rect(0.5)),
    // rust: ]);
    // rust: let mut out = Vec::new();
    // rust: super::flames(
    // rust: [0.0; 3],
    // rust: 0.6,
    // rust: 1.8,
    // rust: glam::DVec3::ZERO,
    // rust: 0.0,
    // rust: &sprites,
    // rust: 0,
    // rust: &mut out,
    // rust: );
    // rust: assert_eq!(out.len() % 4, 0);
    // rust: assert!(
    // rust: out[0].pos[2] < 0.0,
    // rust: "billboard depth bias must face the camera"
    // rust: );
    // rust: assert!(
    // rust: out.iter().all(|v| v.light == 0xf000),
    // rust: "fire forces block light to 15 but preserves scene sky light"
    // rust: );
    // rust: assert!(out.len() >= 20);
    // rust: assert!(out.iter().any(|v| v.pos[1] >= 1.8));
    // rust: assert!(
    // rust: out.iter().all(|v| v.layer == 0),
    // rust: "flames must not use the breaking-cracks UV-remap material"
    // rust: );
    // rust: assert!(out[..4].iter().all(|v| v.uv[0] <= 0.1));
    // rust: assert!(out[4..8].iter().all(|v| v.uv[0] >= 0.5));
}
}
