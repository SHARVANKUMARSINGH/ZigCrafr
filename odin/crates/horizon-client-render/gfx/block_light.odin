//! Transpiled from Horizon Rust crate
package horizon_client_render_block_light

import "core:fmt"
import "core:mem"
import "core:math"

// The colour of block light for Horizon's shader packs (`[[lights]]`, docs/api/shaders.md):
// a grid of cells around the camera, each holding the colour of the light sources that
// reach it, averaged by how near each is, which the material stage reads through the
// prelude's `block_light_color`. Block light keeps its own brightness (the light engine's,
// which walls stop): the grid only tints it, so it needs no occlusion of its own.
//
// The grid is rebuilt on the CPU when the camera moves on to another 16-block step or the
// light sources change, from the sources the section meshes list (`SectionMesh::lights`).

// use crate::fast_hash::FxHashMap;
// use glam::{DVec3, Vec3};

// use super::SectionKey;

// Cells along each side of the grid.
SIZE :: 64
// The side of a cell, in blocks: the grid spans 128 blocks.
CELL :: 2.0
// The grid moves in steps of this many blocks.
STEP :: 16
// The most sources one rebuild splats, the nearest first (a lava lake lists thousands).
MAX_SOURCES :: 2048
// `[[lights]]` colours go up to 4; the cells keep them over 4 in 8 bits.
COLOR_RANGE :: 4.0

// The light a block state gives off: its `[[lights]]` colour and its level, 1 to 15.
    // rust: pub type LightTable = FxHashMap<u32, ([f32; 3], u8)>;

BlockLight :: struct {
    texture: wgpu::Texture,
    view: wgpu::TextureView,
    // `block_light_grid`: the grid's corner, camera-relative, and the side of a cell.
    grid: wgpu::Buffer,
    table: LightTable,
    // The world corner and the sources' revision the texture was last built for.
    built: Option<([i32,
}

    // rust: impl BlockLight {
new :: proc(device: ^wgpu::Device, table: LightTable) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Native shader pack block light colours"),
    // rust: size: wgpu::Extent3d {
    // rust: width: SIZE,
    // rust: height: SIZE,
    // rust: depth_or_array_layers: SIZE,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D3,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: let grid = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Native shader pack block light grid"),
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: Self {
    // rust: view: texture.create_view(&Default::default()),
    // rust: texture,
    // rust: grid,
    // rust: table,
    // rust: built: None,
}
}

    // Places the grid around `camera`, rebuilding it when it moved or `revision` (of
    // `sections`' sources) changed.
    // rust: pub fn update(
    // rust: &mut self,
    // rust: queue: &wgpu::Queue,
    // rust: camera: DVec3,
    // rust: sections: &FxHashMap<SectionKey, Vec<([i32; 3], u32)>>,
    // rust: revision: u64,
    // rust: ) {
    // rust: let half = (SIZE as f32 * CELL / 2.0) as f64;
    // rust: let origin = ((camera - half) / f64::from(STEP))
    // rust: .floor()
    // rust: .as_ivec3()
    // rust: .to_array()
    // rust: .map(|v| v * STEP);
    // rust: let corner = (glam::IVec3::from(origin).as_dvec3() - camera).as_vec3();
    // rust: queue.write_buffer(
    // rust: &self.grid,
    // rust: 0,
    // rust: bytemuck::cast_slice(&[corner.x, corner.y, corner.z, CELL]),
    // rust: );
    // rust: if self.built == Some((origin, revision)) {
    // rust: return;
}
    // rust: self.built = Some((origin, revision));
    // rust: let cells = build(&self.table, origin, camera, sections);
    // rust: queue.write_texture(
    // rust: self.texture.as_image_copy(),
    // rust: &cells,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(SIZE * 4),
    // rust: rows_per_image: Some(SIZE),
    // rust: },
    // rust: self.texture.size(),
    // rust: );
}
}

// The cells of the grid with its corner at `origin`: RGBA8, x fastest, then y, then z.
    // rust: fn build(
    // rust: table: &LightTable,
    // rust: origin: [i32; 3],
    // rust: camera: DVec3,
    // rust: sections: &FxHashMap<SectionKey, Vec<([i32; 3], u32)>>,
    // rust: ) -> Vec<u8> {
    // rust: let n = SIZE as usize;
    // rust: let mut cells = vec![0u8; n * n * n * 4];
    // rust: if table.is_empty() {
    // rust: return cells;
}
    // rust: let span = SIZE as i32 * CELL as i32;
    // Sections the grid or the light reaching into it (15 blocks) touches.
    // rust: let lo = origin.map(|v| (v - 15).div_euclid(16));
    // rust: let hi = origin.map(|v| (v + span + 15).div_euclid(16));
    // rust: let mut sources: Vec<(Vec3, [f32; 3], f32, f64)> = Vec::new();
    // rust: for (key, lights) in sections {
    // rust: let key = [key.0, key.1 + crate::chunk::MIN_Y.div_euclid(16), key.2];
    // rust: if (0..3).any(|i| key[i] < lo[i] || key[i] > hi[i]) {
    // rust: continue;
}
    // rust: for &(pos, state) in lights {
    // rust: let Some(&(color, level)) = table.get(&state) else {
    // rust: continue;
}
    // rust: let center = glam::IVec3::from(pos).as_dvec3() + 0.5;
    // rust: let local = (center - glam::IVec3::from(origin).as_dvec3()).as_vec3();
    // rust: sources.push((
    // rust: local,
    // rust: color,
    // rust: f32::from(level),
    // rust: center.distance_squared(camera),
    // rust: ));
}
}
    // rust: if sources.len() > MAX_SOURCES {
    // rust: sources.select_nth_unstable_by(MAX_SOURCES, |a, b| a.3.total_cmp(&b.3));
    // rust: sources.truncate(MAX_SOURCES);
}
    // rust: let mut sum = vec![[0.0f32; 4]; n * n * n];
    // rust: for (at, color, reach, _) in sources {
    // rust: let first = ((at - reach) / CELL).floor().max(Vec3::ZERO).as_ivec3();
    // rust: let last = ((at + reach) / CELL)
    // rust: .ceil()
    // rust: .min(Vec3::splat(SIZE as f32 - 1.0))
    // rust: .as_ivec3();
    // rust: for z in first.z..=last.z {
    // rust: for y in first.y..=last.y {
    // rust: for x in first.x..=last.x {
    // rust: let cell = (Vec3::new(x as f32, y as f32, z as f32) + 0.5) * CELL;
    // rust: let d = cell.distance(at);
    // rust: if d >= reach {
    // rust: continue;
}
                    // As block light falls off: strongest at the source, gone at its level.
    // rust: let w = (1.0 - d / reach).powi(2);
    // rust: let s = &mut sum[x as usize + n * (y as usize + n * z as usize)];
    // rust: s[0] += color[0] * w;
    // rust: s[1] += color[1] * w;
    // rust: s[2] += color[2] * w;
    // rust: s[3] += w;
}
}
}
}
    // rust: for (cell, s) in cells.as_chunks_mut::<4>().0.iter_mut().zip(&sum) {
    // rust: if s[3] <= 0.0 {
    // rust: continue;
}
    // rust: let byte = |v: f32| (v.clamp(0.0, 1.0) * 255.0).round() as u8;
    // rust: for i in 0..3 {
    // rust: cell[i] = byte(s[i] / s[3] / COLOR_RANGE);
}
    // rust: cell[3] = byte(s[3]);
}
    // rust: cells
}

    // rust: mod tests {
//     use super::*;

a_source_tints_the_cells_it_reaches_with_its_colour :: proc() {
}
    // rust: let mut table = LightTable::default();
    // rust: table.insert(7, ([2.0, 1.0, 0.0], 14));
    // rust: let mut sections = FxHashMap::default();
        // A torch at world (8, 64, 8): section y = (64 - MIN_Y) / 16.
    // rust: let sy = (64 - crate::chunk::MIN_Y) / 16;
    // rust: sections.insert((0, sy, 0), vec![([8, 64, 8], 7)]);
    // rust: let camera = DVec3::new(8.0, 64.0, 8.0);
    // rust: let origin = [-64, 0, -64];
    // rust: let cells = build(&table, origin, camera, &sections);
    // rust: let n = SIZE as usize;
    // rust: let at = |p: [i32; 3]| {
    // rust: let c = p
    // rust: .iter()
    // rust: .zip(origin)
    // rust: .map(|(v, o)| ((v - o) as f32 / CELL) as usize)
    // rust: .collect::<Vec<_>>();
    // rust: let i = (c[0] + n * (c[1] + n * c[2])) * 4;
    // rust: [cells[i], cells[i + 1], cells[i + 2], cells[i + 3]]
}
    // rust: let near = at([8, 64, 8]);
        // The colour over 4, whatever the weight: (2, 1, 0) / 4.
    // rust: assert_eq!(&near[..3], &[128, 64, 0]);
    // rust: assert!(near[3] > 150);
    // rust: assert_eq!(at([8, 64, 40]), [0; 4], "past its level, nothing");
    // rust: assert!(
    // rust: build(&LightTable::default(), origin, camera, &sections)
    // rust: .iter()
    // rust: .all(|&b| b == 0)
    // rust: );
}
}
