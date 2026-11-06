//! Transpiled from Horizon Rust crate
package horizon_client_render_breaking

import "core:fmt"
import "core:mem"
import "core:math"

// BlockModelFeatureRenderer breaking quads and SheetedDecalTextureGenerator UVs.
// use crate::{camera::joml, mesher::Vertex, models::catalog::BakedModel};
// use horizon_assets::model::Direction;
// use std::f32::consts::{FRAC_PI_2, PI};

// Project in model space: the inverse decal pose cancels the block translation/offset.
decal_uv :: proc(z]: [f32; 3], direction: Direction) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let sy = joml::sin(PI);
    // rust: let cy = joml::cos_from_sin(sy, PI);
    // rust: let sx = joml::sin(-FRAC_PI_2);
    // rust: let cx = joml::cos_from_sin(sx, -FRAC_PI_2);
    // rust: let p = [cy * x + sy * z, y, -sy * x + cy * z];
    // rust: let p = [p[0], cx * p[1] - sx * p[2], sx * p[1] + cx * p[2]];
    // rust: let (angle_x, angle_z) = match direction {
    // rust: Direction::Down => (PI, 0.0),
    // rust: Direction::Up => (0.0, 0.0),
    // rust: Direction::North => (FRAC_PI_2, PI),
    // rust: Direction::South => (FRAC_PI_2, 0.0),
    // rust: Direction::West => (FRAC_PI_2, FRAC_PI_2),
    // rust: Direction::East => (FRAC_PI_2, -FRAC_PI_2),
}
    // rust: let p = joml::Quat::rotation_yxz(0.0, angle_x, angle_z).transform(p);
    // rust: [-p[0], -p[1]]
}

// The light bytes of a crack vertex: the pass is unlit, so they carry the origin of the
// vertex's destroy stage sprite (each crack in `LevelRenderer.destroyingBlocks` has its own
// stage; every stage sprite has the same size, `crumbling_sprite.zw`).
stage_light :: proc(v0]: [f32; 2]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let q = |x: f32| (x.clamp(0.0, 1.0) * 65535.0).round() as u32;
    // rust: q(u0) | (q(v0) << 16)
}

    // rust: pub fn geometry(
    // rust: model: &BakedModel,
    // rust: origin: glam::Vec3,
    // rust: translucent: bool,
    // rust: stage: [f32; 2],
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // Vanilla visits all six cull groups and then the unculled faces, even beside solid neighbours.
    // rust: for cull in Direction::ALL.map(Some).into_iter().chain([None]) {
    // rust: for face in model.faces.iter().filter(|face| face.quad.cull == cull) {
    // rust: for pos in face.quad.positions {
    // rust: out.push(Vertex {
    // rust: pos: (origin + glam::Vec3::from(pos)).to_array(),
    // rust: uv: decal_uv(pos, face.quad.facing),
    // rust: layer: if translucent { 12 } else { 11 },
    // rust: color: 0xffff_ffff,
    // rust: light: stage_light(stage),
    // rust: normal: [0; 4],

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}

// Project a block entity's transformed quads onto the same destroy-stage pass.
entity_geometry :: proc(vertices: ^[Vertex], origin: glam::Vec3, stage: [f32; 2]) {
}
    // rust: for quad in vertices.as_chunks_mut::<4>().0 {
    // rust: let positions = [0, 1, 2].map(|i| glam::Vec3::from(quad[i].pos));
    // rust: let normal = (positions[1] - positions[0]).cross(positions[2] - positions[0]);
    // rust: let mut facing = Direction::North;
    // rust: let mut best = f32::from_bits(1);
    // rust: for (direction, dot) in [
    // rust: (Direction::Down, -normal.y),
    // rust: (Direction::Up, normal.y),
    // rust: (Direction::North, -normal.z),
    // rust: (Direction::South, normal.z),
    // rust: (Direction::West, -normal.x),
    // rust: (Direction::East, normal.x),
    // rust: ] {
    // rust: if dot > best {
    // rust: facing = direction;
    // rust: best = dot;
}
}
    // rust: for vertex in quad {
    // rust: vertex.uv = decal_uv((glam::Vec3::from(vertex.pos) - origin).to_array(), facing);
    // rust: vertex.layer = 11;
    // rust: vertex.color = 0xffff_ffff;
    // rust: vertex.light = stage_light(stage);
}
}
}

    // rust: mod tests {
//     use super::*;

stage_origin_survives_the_light_bytes :: proc() {
}
        // entity.wgsl's `wrap`: the low and high 16 bits over 65535.
    // rust: for origin in [[0.0, 0.0], [0.5, 0.25], [0.123_456, 0.987_654], [1.0, 1.0]] {
    // rust: let light = stage_light(origin);
    // rust: let back = [
    // rust: (light & 0xffff) as f32 / 65535.0,
    // rust: (light >> 16) as f32 / 65535.0,
    // rust: ];
    // rust: for k in 0..2 {
    // rust: assert!(
    // rust: (back[k] - origin[k]).abs() <= 0.5 / 65535.0,
    // rust: "{origin:?} -> {back:?}"
    // rust: );
}
}
}
//     use crate::models::catalog::BakedFace;
//     use horizon_assets::{bake::ModelQuad, model::Material};
slab_top :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: BakedModel {
    // rust: ambient_occlusion: true,
    // rust: particle: None,
    // rust: cube: None,
    // rust: faces: vec![BakedFace {
    // rust: layer: 0,
    // rust: opaque: true,
    // rust: translucent: false,
    // rust: fusion: None,
    // rust: quad: ModelQuad {
    // rust: positions: [
    // rust: [0.0, 0.5, 0.0],
    // rust: [0.0, 0.5, 1.0],
    // rust: [1.0, 0.5, 1.0],
    // rust: [1.0, 0.5, 0.0],
    // rust: ],
    // rust: uv: [[0.0; 2]; 4],
    // rust: facing: Direction::Up,
    // rust: cull: None,
    // rust: material: Material {
    // rust: sprite: "block/stone".into(),
    // rust: force_translucent: false,
    // rust: },
    // rust: tint_index: -1,
    // rust: shade_direction_override: None,
    // rust: light_emission: 0,
    // rust: light: [0; 2],
    // rust: color: None,
    // rust: ambient_occlusion: None,
    // rust: render_type: None,
    // rust: shade: true,
    // rust: },
    // rust: }],
}
}
slab_overlay_follows_baked_top_not_unit_cube :: proc() {
}
    // rust: let model = slab_top();
    // rust: let mut vertices = Vec::new();
    // rust: geometry(
    // rust: &model,
    // rust: glam::Vec3::new(2.0, 3.0, 4.0),
    // rust: false,
    // rust: [0.0; 2],
    // rust: &mut vertices,
    // rust: );
    // rust: assert_eq!(vertices.len(), 4);
    // rust: for (v, p) in vertices.iter().zip(model.faces[0].quad.positions) {
    // rust: assert_eq!(v.pos, [p[0] + 2.0, p[1] + 3.0, p[2] + 4.0]);
    // rust: assert_eq!(v.color, 0xffff_ffff);
}
}
entity_overlay_uses_block_local_projected_uvs :: proc() {
}
    // rust: let origin = glam::Vec3::new(12.0, -3.0, 8.0);
    // rust: let mut expected = Vec::new();
    // rust: geometry(&slab_top(), origin, false, [0.0; 2], &mut expected);
    // rust: let mut actual = expected.clone();
    // rust: for vertex in &mut actual {
    // rust: vertex.uv = [0.0; 2];
    // rust: vertex.layer = 0;
    // rust: vertex.color = 0;
}
    // rust: entity_geometry(&mut actual, origin, [0.0; 2]);
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&actual),
    // rust: bytemuck::cast_slice::<_, u8>(&expected)
    // rust: );
}

small_faces_use_projected_not_stretched_uvs :: proc() {
}
    // rust: let a = decal_uv([0.0, 0.0, 0.0], Direction::North);
    // rust: let b = decal_uv([0.0, 0.5, 0.0], Direction::North);
    // rust: assert!(((b[1] - a[1]).abs() - 0.5).abs() < 1e-6);
}
translucent_overlay_has_its_own_pass :: proc() {
}
    // rust: let mut vertices = Vec::new();
    // rust: geometry(&slab_top(), glam::Vec3::ZERO, true, [0.0; 2], &mut vertices);
    // rust: assert!(vertices.iter().all(|v| v.layer == 12));
}
empty_model_has_no_cube_overlay :: proc() {
}
    // rust: let mut model = slab_top();
    // rust: model.faces.clear();
    // rust: let mut vertices = Vec::new();
    // rust: geometry(&model, glam::Vec3::ZERO, false, [0.0; 2], &mut vertices);
    // rust: assert!(vertices.is_empty());
}
}
