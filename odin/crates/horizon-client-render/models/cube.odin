//! Transpiled from Horizon Rust crate
package horizon_client_render_cube

import "core:fmt"
import "core:mem"
import "core:math"

// Exact unit-cube faces eligible for repeated-texture greedy rectangles.
// use super::catalog::BakedFace;
// use horizon_assets::model::Direction;

CubeStyle :: struct {
    layer: u32,
    // UV at spatial (u,v)=(0,0), then the two signed unit-axis derivatives.
    uv: [i8,
    shade_bits: u32,
}
shade :: proc(face: ^BakedFace) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match face
    // rust: .quad
    // rust: .shade_direction_override
    // rust: .unwrap_or(face.quad.facing)
    // rust: {
    // rust: Direction::Down => 0.5,
    // rust: Direction::Up => 1.0,
    // rust: Direction::North | Direction::South => 0.8,
    // rust: Direction::West | Direction::East => 0.6,
}
}
cube_styles :: proc(faces: ^[BakedFace]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if faces.len() != 6 {
    // rust: return None;
}
    // rust: let mut styles = [None; 6];
    // rust: for face in faces {
    // rust: if !face.opaque
    // rust: || face.translucent
    // rust: || face.quad.tint_index != -1
    // rust: || face.quad.light_emission != 0
    // rust: || face.quad.light != [0; 2]
    // rust: || face.quad.color.is_some()
    // rust: || face.quad.ambient_occlusion.is_some()
    // rust: || face.quad.render_type.is_some()
    // rust: {
    // rust: return None;
}
    // rust: let q = &face.quad;
    // rust: let direction = q.cull?;
    // rust: if q.facing != direction || styles[direction as usize].is_some() {
    // rust: return None;
}
    // rust: let (axis, u, v) = match direction {
    // rust: Direction::Down | Direction::Up => (1, 0, 2),
    // rust: Direction::North | Direction::South => (2, 0, 1),
    // rust: Direction::West | Direction::East => (0, 2, 1),
}
    // rust: let plane = if (direction as usize).is_multiple_of(2) {
    // rust: 0.0
    // rust: } else {
    // rust: 1.0
}
    // rust: let mut uv = [None; 4];
    // rust: for (p, texture) in q.positions.iter().zip(q.uv) {
    // rust: if p[axis] != plane
    // rust: || ![p[u], p[v], texture[0], texture[1]]
    // rust: .iter()
    // rust: .all(|&x| x == 0.0 || x == 1.0)
    // rust: {
    // rust: return None;
}
    // rust: let index = p[u] as usize + 2 * p[v] as usize;
    // rust: if uv[index].replace(texture.map(|x| x as i8)).is_some() {
    // rust: return None;
}
}
    // rust: let [a, b, c, d] = uv.map(|v| v.unwrap());
    // rust: let du = [b[0] - a[0], b[1] - a[1]];
    // rust: let dv = [c[0] - a[0], c[1] - a[1]];
    // rust: if d != [a[0] + du[0] + dv[0], a[1] + du[1] + dv[1]]
    // rust: || (du[0] * dv[1] - du[1] * dv[0]).abs() != 1
    // rust: {
    // rust: return None;
}
    // rust: styles[direction as usize] = Some(CubeStyle {
    // rust: layer: face.layer,
    // rust: uv: [a[0], a[1], du[0], du[1], dv[0], dv[1]],
    // rust: shade_bits: shade(face).to_bits(),
    // rust: });
}
    // rust: Some(styles.map(|v| v.unwrap()))
}

    // rust: mod tests {
//     use super::*;
//     use horizon_assets::{
    // rust: bake::{BlockModelTransform, bake_model_transformed},
    // rust: model::CuboidModel,
    // rust: resolve::ModelLibrary,
}
//     use serde_json::json;
projected_cube_uvs_match_baked_quarter_turns :: proc() {
}
    // rust: let faces: serde_json::Map<String, serde_json::Value> = Direction::ALL
    // rust: .into_iter()
    // rust: .map(|d| {
    // rust: (
    // rust: d.name().to_owned(),
    // rust: json!({"texture":"#all","cullface":d.name()}),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let model = CuboidModel::from_json(&json!({"textures":{"all":"horizon:probe"},"elements":[{"from":[0,0,0],"to":[16,16,16],"faces":faces}]}).to_string()).unwrap();
    // rust: let library = ModelLibrary::new([("horizon:cube".to_owned(), model)].into()).unwrap();
    // rust: let model = library.resolve("horizon:cube").unwrap();
    // rust: let mut eligible = 0;
    // rust: for x in 0..4 {
    // rust: for y in 0..4 {
    // rust: for z in 0..4 {
    // rust: for lock in [false, true] {
    // rust: let faces: Vec<_> = bake_model_transformed(
    // rust: &model,
    // rust: BlockModelTransform::new([x, y, z], lock),
    // rust: )
    // rust: .unwrap()
    // rust: .into_iter()
    // rust: .map(|quad| BakedFace {
    // rust: quad,
    // rust: layer: 7,
    // rust: opaque: true,
    // rust: translucent: false,
    // rust: fusion: None,
    // rust: })
    // rust: .collect();
    // rust: let Some(styles) = cube_styles(&faces) else {
    // rust: assert!(lock);
    // rust: continue;
}
    // rust: eligible += 1;
    // rust: for face in &faces {
    // rust: let direction = face.quad.cull.unwrap();
    // rust: let (u, v) = match direction {
    // rust: Direction::Down | Direction::Up => (0, 2),
    // rust: Direction::North | Direction::South => (0, 1),
    // rust: _ => (2, 1),
}
    // rust: let style = styles[direction as usize];
    // rust: let [a, b, c, d, e, f] = style.uv.map(f32::from);
    // rust: for (p, uv) in face.quad.positions.iter().zip(face.quad.uv) {
    // rust: assert_eq!([a + c * p[u] + e * p[v], b + d * p[u] + f * p[v]], uv);
}
}
}
}
}
}
    // rust: assert!(eligible >= 64);
    // rust: let mut faces: Vec<_> =
    // rust: bake_model_transformed(&model, BlockModelTransform::new([0; 3], false))
    // rust: .unwrap()
    // rust: .into_iter()
    // rust: .map(|quad| BakedFace {
    // rust: quad,
    // rust: layer: 0,
    // rust: opaque: true,
    // rust: translucent: false,
    // rust: fusion: None,
    // rust: })
    // rust: .collect();
    // rust: faces[0].opaque = false;
    // rust: assert!(cube_styles(&faces).is_none());
    // rust: faces[0].opaque = true;
    // rust: faces[0].quad.positions[0][0] = 0.25;
    // rust: assert!(cube_styles(&faces).is_none());
}
}
