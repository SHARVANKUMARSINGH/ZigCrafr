//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_mesh
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Exposed voxel-column faces, merged without changing their block-scale UVs.
// use super::{Column, Span, Spans, TileKey};
// use crate::{
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: mesher::{OPAQUE_LAYER, SectionMesh, TerrainVertex, fluid_face},
    // rust: streaming::WorkerContext,
}
// use horizon_assets::model::Direction;
// use horizon_core::position::BlockPos;
// use horizon_world::registry::BlockStateId;
// use std::collections::BTreeMap;

pub const CELLS: usize = 16;

    // rust: pub(super) struct EdgeColumn<'a> {
    // rust: pub start: i32,
    // rust: pub end: i32,
    // rust: pub column: &'a Column,
    /// The neighbour is planned but not drawn yet: its terrain is not known
    /// to be empty, so the sides facing it are left out, not drawn as walls.
    // rust: pub unknown: bool,
}

pub const Tint = enum {
    None,
    Grass,
    Foliage,
    Dry,
    Water,
    Constant(u32),
};
pub const Style = struct {
    layer: u16,
    tint: Tint,
    translucent: bool,
};
pub const Styles = struct {
    faces: [?Style,
    fluid: u8,
    opaque: bool,
};
pub const Paint = struct {
    layer: u16,
    light: u16,
    color: u32,
    translucent: bool,
};
pub const Material = struct {
    faces: [?Paint,
    fluid: u8,
    opaque: bool,
};
    // rust: pub(super) struct Mesher {
    // rust: styles: FxHashMap<(BlockStateId, u8), Styles>,
}
    // rust: impl Mesher {
    // rust: pub(super) fn mesh(
    // rust: &mut self,
    // rust: key: TileKey,
    // rust: columns: &[&Column],
    // rust: covered: &FxHashSet<(i32, i32)>,
    // rust: covered_bounds: Option<[i32; 4]>,
    // rust: context: &WorkerContext,
    // rust: neighbors: &[Vec<EdgeColumn<'_>>; 4],
    // rust: finer: &[TileKey],
    // rust: ) -> SectionMesh {
    // rust: mesh_columns_with_edges(
    // rust: key,
    // rust: columns,
    // rust: covered,
    // rust: covered_bounds,
    // rust: neighbors,
    // rust: finer,
    // rust: |span, direction, at| self.material(span, direction, at, context),
    // rust: )
}
    /// `at`: the block column the face covers, for the grass colours that
    /// change across a biome (swamps).
    // rust: fn material(
    // rust: &mut self,
    // rust: span: &Span,
    // rust: direction: Direction,
    // rust: at: [i32; 2],
    // rust: context: &WorkerContext,
    // rust: ) -> Material {
    // rust: let styles = *self
    // rust: .styles
    // rust: .entry((span.state, direction as u8))
    // rust: .or_insert_with(|| {
    // rust: let assets = &context.assets;
    // rust: let name = assets
    // rust: .registry
    // rust: .state(span.state)
    // rust: .map_or("", |s| s.name.as_str());
    // rust: let fluid = match name {
    // rust: "minecraft:water" | "minecraft:bubble_column" => 1,
    // rust: "minecraft:lava" => 2,
    // rust: _ => 0,
}
    // rust: if fluid != 0 {
    // rust: let sprite = if fluid == 1 {
    // rust: "block/water_still"
    // rust: } else {
    // rust: "block/lava_still"
}
    // rust: let render = &context.render;
    // rust: let layer = render
    // rust: .sprite_layers
    // rust: .get(sprite)
    // rust: .or_else(|| render.sprite_layers.get(&format!("minecraft:{sprite}")))
    // rust: .copied()
    // rust: .unwrap_or(0) as u16;
    // rust: return Styles {
    // rust: faces: [
    // rust: Some(Style {
    // rust: layer,
    // rust: tint: if fluid == 1 { Tint::Water } else { Tint::None },
    // rust: translucent: fluid == 1,
    // rust: }),
    // rust: None,
    // rust: ],
    // rust: fluid,
    // rust: opaque: fluid == 2,
}
}
    // rust: let leaves = name.ends_with("_leaves");
    // rust: let tint = match name.strip_prefix("minecraft:").unwrap_or(name) {
    // rust: "spruce_leaves" => Tint::Constant(0x61_9961),
    // rust: "birch_leaves" => Tint::Constant(0x80_A755),
                    // Cherry (and other pre-coloured) leaves: the texture is
                    // already pink; biome foliage tint turns a grove yellow (#4688).
    // rust: "cherry_leaves"
    // rust: | "azalea_leaves"
    // rust: | "flowering_azalea_leaves"
    // rust: | "pale_oak_leaves" => Tint::None,
    // rust: "leaf_litter" => Tint::Dry,
    // rust: _ if leaves => Tint::Foliage,
    // rust: _ => Tint::Grass,
}
    // rust: let models = context
    // rust: .render
    // rust: .model_catalog
    // rust: .collect(span.state, BlockPos::new(0, 0, 0))
    // rust: .ok();
    // rust: let opaque = leaves
    // rust: || models
    // rust: .iter()
    // rust: .flatten()
    // rust: .flat_map(|(_, model)| &model.faces)
    // rust: .any(|face| !face.translucent);
    // rust: let mut matching = models
    // rust: .iter()
    // rust: .flatten()
    // rust: .flat_map(|(_, model)| &model.faces)
    // rust: .filter(|face| face.quad.facing == direction);
    // rust: let mut faces = [None; 2];
    // rust: for slot in &mut faces {
    // rust: let Some(face) = matching.next() else { break };
    // rust: *slot = Some(Style {
                        // As the mesher marks them: opaque leaves and faces over opaque
                        // texels skip the cutout and draw in the opaque pass.
    // rust: layer: face.layer as u16
    // rust: | if leaves || face.opaque {
    // rust: OPAQUE_LAYER
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: tint: if face.quad.tint_index >= 0 {
    // rust: tint
    // rust: } else {
    // rust: Tint::None
    // rust: },
    // rust: translucent: face.translucent && !leaves,
    // rust: });
                    // Grass's tinted side overlay must follow its untinted base.
    // rust: if name != "minecraft:grass_block"
    // rust: || matches!(direction, Direction::Up | Direction::Down)
    // rust: {
    // rust: break;
}
}
    // rust: Styles {
    // rust: opaque,
    // rust: faces,
    // rust: fluid,
}
    // rust: });
    // rust: let biome = context.biomes.get(span.biome);
    // rust: let shade = match direction {
    // rust: Direction::Up => 1.0,
    // rust: Direction::Down => 0.5,
    // rust: Direction::North | Direction::South => 0.8,
    // rust: Direction::West | Direction::East => 0.6,
}
    // rust: Material {
    // rust: faces: styles.faces.map(|face| {
    // rust: face.map(|face| {
    // rust: let rgb = match face.tint {
    // rust: Tint::None => 0xffffff,
    // rust: Tint::Grass => {
    // rust: context
    // rust: .biomes
    // rust: .grass(span.biome, f64::from(at[0]), f64::from(at[1]))
}
    // rust: Tint::Foliage => biome.foliage,
    // rust: Tint::Dry => biome.dry_foliage,
    // rust: Tint::Water => biome.water,
    // rust: Tint::Constant(color) => color,
}
    // rust: let channel = |shift: u32| (((rgb >> shift) & 255u32) as f32 * shade) as u32;
    // rust: Paint {
    // rust: layer: face.layer,
    // rust: light: span.light,
                        // The HDR tier, as the section mesher writes it, so a light source
                        // keeps shining across the LOD boundary.
    // rust: color: crate::mesher::emitting(
    // rust: channel(16) | channel(8) << 8 | channel(0) << 16 | 0xff000000,
    // rust: context.tables.hdr_tier(span.state),
    // rust: ),
    // rust: translucent: face.translucent,
}
    // rust: })
    // rust: }),
    // rust: fluid: styles.fluid,
    // rust: opaque: styles.opaque,
}
}
}

pub const Segment = struct {
    span: *'a Span,
    min: f32,
    max: f32,
    material: Material,
    top: bool,
    bottom: bool,
};
pub fn hides(neighbor: *Span, material: Material, current: *Span, current_material: Material) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: material.opaque
    // rust: || neighbor.state == current.state
    // rust: || (material.fluid != 0 && material.fluid == current_material.fluid)
}

pub const FaceKey = struct {
    direction: Direction,
    plane: u32,
    overlay: u8,
    layer: u16,
    light: u16,
    color: u32,
    translucent: bool,
};
pub const Rect = struct {
    u0: f32,
    v0: f32,
    u1: f32,
    v1: f32,
};
    // rust: type Faces = BTreeMap<FaceKey, Vec<Rect>>;
pub fn add_face(faces: *mut Faces, direction: Direction, plane: f32, rect: Rect, material: Material) void {
}
    // rust: for (overlay, paint) in material.faces.into_iter().enumerate() {
    // rust: let Some(paint) = paint else { continue };
        // The same fluid flags the section mesher sets, so the material stage's water
        // reaches the distant tiles too and the LOD boundary keeps one look.
    // rust: let color = if material.fluid != 0 {
    // rust: fluid_face(paint.color, direction as usize)
    // rust: } else {
    // rust: paint.color
}
    // rust: faces
    // rust: .entry(FaceKey {
    // rust: direction,
    // rust: plane: plane.to_bits(),
    // rust: overlay: overlay as u8,
    // rust: layer: paint.layer,
    // rust: light: paint.light,
    // rust: color,
    // rust: translucent: paint.translucent,
    // rust: })
    // rust: .or_default()
    // rust: .push(rect);
}
}

    // rust: fn mesh_columns(
    // rust: key: TileKey,
    // rust: columns: &[Column],
    // rust: covered: &FxHashSet<(i32, i32)>,
    // rust: covered_bounds: Option<[i32; 4]>,
    // rust: material: impl FnMut(&Span, Direction, [i32; 2]) -> Material,
    // rust: ) -> SectionMesh {
    // rust: mesh_columns_with_neighbors(key, columns, covered, covered_bounds, &[], material)
}
    // rust: fn mesh_columns_with_neighbors(
    // rust: key: TileKey,
    // rust: columns: &[Column],
    // rust: covered: &FxHashSet<(i32, i32)>,
    // rust: covered_bounds: Option<[i32; 4]>,
    // rust: neighbors: &[Column],
    // rust: material: impl FnMut(&Span, Direction, [i32; 2]) -> Material,
    // rust: ) -> SectionMesh {
    // rust: assert!(neighbors.is_empty() || neighbors.len() == 4 * CELLS);
    // rust: let stride = key.size() / CELLS as i32;
    // rust: let columns: Vec<&Column> = columns.iter().collect();
    // rust: let edges = std::array::from_fn(|side| {
    // rust: neighbors
    // rust: .get(side * CELLS..(side + 1) * CELLS)
    // rust: .unwrap_or(&[])
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(row, column)| EdgeColumn {
    // rust: start: row as i32 * stride,
    // rust: end: (row as i32 + 1) * stride,
    // rust: column,
    // rust: unknown: false,
    // rust: })
    // rust: .collect()
    // rust: });
    // rust: mesh_columns_with_edges(
    // rust: key,
    // rust: &columns,
    // rust: covered,
    // rust: covered_bounds,
    // rust: &edges,
    // rust: &[],
    // rust: material,
    // rust: )
}
/// From this tile level up a cell is 64 blocks wide or more: the strata
/// inside the ground cannot be told apart, so a column is its surface.
pub const HEIGHTMAP_LEVEL: u8 = 6;
/// `column` as a heightmap: its top solid span reaching down to the bottom of
/// the world (so the walls toward lower neighbours are one face of the
/// surface's material, merged along the cliff), and the fluid over it.
pub fn heightmap(column: *Column, mut fluid: impl FnMut(*Span) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((top, below)) = column.spans.split_last() else {
    // rust: return column.clone();
}
    // rust: let ground = |span: &Span| Span {
    // rust: min: crate::chunk::MIN_Y as i16,
    // rust: ..*span
}
    // rust: let mut spans = Spans::with_capacity(2);
    // rust: if !fluid(top) {
    // rust: spans.push(ground(top));
    // rust: } else if let Some(under) = below.iter().rev().find(|&span| !fluid(span)) {
        // The bed is under all of the water, however many spans the water
        // takes: a chunk's own columns shade it a span a light level, a
        // previewed far column one span for the run.
    // rust: spans.push(ground(under));
    // rust: spans.push(Span {
    // rust: min: under.max,
    // rust: ..*top
    // rust: });
    // rust: } else {
    // rust: spans.push(*top);
}
    // rust: Column {
    // rust: surface: column.surface,
    // rust: spans,
}
}
    // rust: fn mesh_columns_with_edges(
    // rust: key: TileKey,
    // rust: columns: &[&Column],
    // rust: covered: &FxHashSet<(i32, i32)>,
    // rust: covered_bounds: Option<[i32; 4]>,
    // rust: neighbors: &[Vec<EdgeColumn<'_>>; 4],
    // rust: finer: &[TileKey],
    // rust: mut material: impl FnMut(&Span, Direction, [i32; 2]) -> Material,
    // rust: ) -> SectionMesh {
    // rust: assert_eq!(columns.len(), CELLS * CELLS);
    // The heightmap columns are built here and borrowed like the tile's own.
    // rust: let heightmap_columns: Vec<Column>;
    // rust: let heightmap_refs: Vec<&Column>;
    // rust: let heightmap_edges: [Vec<Column>; 4];
    // rust: let heightmap_neighbors: [Vec<EdgeColumn<'_>>; 4];
    // rust: let (columns, neighbors) = if key.level >= HEIGHTMAP_LEVEL {
    // rust: let [ox, _, oz] = key.origin();
    // rust: let mut fluid = |span: &Span| material(span, Direction::Up, [ox, oz]).fluid != 0;
    // rust: heightmap_columns = columns
    // rust: .iter()
    // rust: .map(|column| heightmap(column, &mut fluid))
    // rust: .collect();
    // rust: heightmap_edges = neighbors.each_ref().map(|side| {
    // rust: side.iter()
    // rust: .map(|edge| heightmap(edge.column, &mut fluid))
    // rust: .collect()
    // rust: });
    // rust: heightmap_refs = heightmap_columns.iter().collect();
    // rust: heightmap_neighbors = std::array::from_fn(|side| {
    // rust: neighbors[side]
    // rust: .iter()
    // rust: .zip(&heightmap_edges[side])
    // rust: .map(|(edge, column)| EdgeColumn {
    // rust: start: edge.start,
    // rust: end: edge.end,
    // rust: column,
    // rust: unknown: edge.unknown,
    // rust: })
    // rust: .collect()
    // rust: });
    // rust: (&heightmap_refs[..], &heightmap_neighbors)
    // rust: } else {
    // rust: (columns, neighbors)
}
    // rust: let mut count = CELLS * CELLS;
    // rust: let edge_offsets = std::array::from_fn::<_, 4, _>(|side| {
    // rust: let start = count;
    // rust: count += neighbors[side].len();
    // rust: start
    // rust: });
    // rust: let stride = key.size() / CELLS as i32;
    // rust: let [ox, _, oz] = key.origin();
    // A cell meets full-detail or finer terrain: it is meshed in smaller steps.
    // rust: let cell_step = |x: usize, z: usize| {
    // rust: let (wx, wz) = (ox + x as i32 * stride, oz + z as i32 * stride);
    // rust: let overlaps = covered_bounds.is_some_and(|[x0, z0, x1, z1]| {
    // rust: wx < x1 && wx + stride > x0 && wz < z1 && wz + stride > z0
    // rust: });
    // rust: let mut step = if overlaps { stride.min(16) } else { stride };
    // rust: for other in finer {
    // rust: let [x, _, z] = other.origin();
    // rust: if wx < x + other.size() && x < wx + stride && wz < z + other.size() && z < wz + stride
    // rust: {
    // rust: step = step.min(other.size());
}
}
        // The cells of the coarsest tiles are thousands of blocks wide: a
        // few steps each keep the work bounded, the cut around finer terrain
        // coarse for as long as such a tile stands in for its children.
    // rust: step.max(stride / MAX_STEPS)
}
    // rust: let filled = fill_buried_gaps(
    // rust: columns,
    // rust: neighbors,
    // rust: stride,
    // rust: |x, z| cell_step(x, z) == stride,
    // rust: |span| material(span, Direction::Up, [ox, oz]).fluid != 0,
    // rust: );
    // A cell's faces take the colours at its centre. The tile's neighbours'
    // columns only hide faces, so their colours never show.
    // rust: let centre = |i: usize| {
    // rust: if i < CELLS * CELLS {
    // rust: [
    // rust: ox + (i % CELLS) as i32 * stride + stride / 2,
    // rust: oz + (i / CELLS) as i32 * stride + stride / 2,
    // rust: ]
    // rust: } else {
    // rust: [ox, oz]
}
}
    // rust: let mut materials = Vec::new();
    // rust: let prepared: Vec<Vec<Segment<'_>>> = filled
    // rust: .iter()
    // rust: .map(|column| column.as_ref())
    // rust: .chain(neighbors.iter().flatten().map(|edge| edge.column))
    // rust: .enumerate()
    // rust: .map(|(index, column)| {
    // rust: let at = centre(index);
    // rust: materials.clear();
    // rust: materials.extend(column.spans.iter().map(|s| material(s, Direction::Up, at)));
    // rust: column
    // rust: .spans
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, span)| span.min < span.max)
    // rust: .map(|(i, span)| {
    // rust: let current = materials[i];
    // rust: let top = !column.spans.get(i + 1).is_some_and(|next| {
    // rust: next.min == span.max && hides(next, materials[i + 1], span, current)
    // rust: });
    // rust: let bottom = i == 0
    // rust: || !(column.spans[i - 1].max == span.min
    // rust: && hides(&column.spans[i - 1], materials[i - 1], span, current));
    // rust: Segment {
    // rust: span,
    // rust: min: f32::from(span.min),
    // rust: max: f32::from(span.max)
    // rust: - if current.fluid != 0 && top {
    // rust: 1.0 / 9.0
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: material: current,
    // rust: top,
    // rust: bottom,
}
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .collect();
    // rust: let mut faces = Faces::new();
    // rust: let finer_keys: FxHashSet<_> = finer.iter().copied().collect();
    // rust: let mut finer_levels: Vec<_> = finer.iter().map(|key| key.level).collect();
    // rust: finer_levels.sort_unstable();
    // rust: finer_levels.dedup();
    // rust: let is_covered = |x: i32, z: i32| {
    // rust: covered.contains(&(x.div_euclid(16), z.div_euclid(16)))
    // rust: || finer_levels.iter().any(|&level| {
    // rust: let size = 16 << level;
    // rust: finer_keys.contains(&TileKey {
    // rust: x: x.div_euclid(size),
    // rust: z: z.div_euclid(size),
    // rust: level,
    // rust: })
    // rust: })
}
    // rust: for z in 0..CELLS {
    // rust: for x in 0..CELLS {
    // rust: let (wx, wz) = (ox + x as i32 * stride, oz + z as i32 * stride);
    // rust: let step = cell_step(x, z);
    // rust: let column = &prepared[z * CELLS + x];
    // rust: let own_sky = column.last().map_or(0, |top| top.span.light & 0xff);
    // rust: for dz in (0..stride).step_by(step as usize) {
    // rust: for dx in (0..stride).step_by(step as usize) {
    // rust: if is_covered(wx + dx, wz + dz) {
    // rust: continue;
}
    // rust: let (x0, z0) = (
    // rust: (x as i32 * stride + dx) as f32,
    // rust: (z as i32 * stride + dz) as f32,
    // rust: );
    // rust: let (x1, z1) = (x0 + step as f32, z0 + step as f32);
    // rust: for segment in column {
    // rust: if segment.top {
    // rust: add_face(
    // rust: &mut faces,
    // rust: Direction::Up,
    // rust: segment.max,
    // rust: Rect {
    // rust: u0: x0,
    // rust: v0: z0,
    // rust: u1: x1,
    // rust: v1: z1,
    // rust: },
    // rust: segment.material,
    // rust: );
}
    // rust: if segment.bottom {
    // rust: add_face(
    // rust: &mut faces,
    // rust: Direction::Down,
    // rust: segment.min,
    // rust: Rect {
    // rust: u0: x0,
    // rust: v0: z0,
    // rust: u1: x1,
    // rust: v1: z1,
    // rust: },
    // rust: material(segment.span, Direction::Down, centre(z * CELLS + x)),
    // rust: );
}
    // rust: for (direction, nx, nz, edge, nw, plane, u0, u1) in [
    // rust: (
    // rust: Direction::West,
    // rust: x as i32 - 1,
    // rust: z as i32,
    // rust: dx == 0,
    // rust: [wx + dx - 1, wz + dz],
    // rust: x0,
    // rust: z0,
    // rust: z1,
    // rust: ),
    // rust: (
    // rust: Direction::East,
    // rust: x as i32 + 1,
    // rust: z as i32,
    // rust: dx + step == stride,
    // rust: [wx + dx + step, wz + dz],
    // rust: x1,
    // rust: z0,
    // rust: z1,
    // rust: ),
    // rust: (
    // rust: Direction::North,
    // rust: x as i32,
    // rust: z as i32 - 1,
    // rust: dz == 0,
    // rust: [wx + dx, wz + dz - 1],
    // rust: z0,
    // rust: x0,
    // rust: x1,
    // rust: ),
    // rust: (
    // rust: Direction::South,
    // rust: x as i32,
    // rust: z as i32 + 1,
    // rust: dz + step == stride,
    // rust: [wx + dx, wz + dz + step],
    // rust: z1,
    // rust: x0,
    // rust: x1,
    // rust: ),
    // rust: ] {
                            // Near meshes may have culled against the real neighbor.
                            // Keep a finite seal where their full-detail area begins:
                            // opaque only, as the near water carries on into the far
                            // water and a seal shows through it as a wall.
    // rust: if is_covered(nw[0], nw[1]) {
    // rust: if segment.material.opaque {
    // rust: add_side(
    // rust: &mut faces,
    // rust: direction,
    // rust: plane,
    // rust: u0,
    // rust: u1,
    // rust: segment,
    // rust: &[],
    // rust: || material(segment.span, direction, centre(z * CELLS + x)),
    // rust: own_sky,
    // rust: );
}
    // rust: } else if !edge {
    // rust: add_side(
    // rust: &mut faces,
    // rust: direction,
    // rust: plane,
    // rust: u0,
    // rust: u1,
    // rust: segment,
    // rust: column,
    // rust: || material(segment.span, direction, centre(z * CELLS + x)),
    // rust: own_sky,
    // rust: );
    // rust: } else if (0..CELLS as i32).contains(&nx)
    // rust: && (0..CELLS as i32).contains(&nz)
    // rust: {
    // rust: add_side(
    // rust: &mut faces,
    // rust: direction,
    // rust: plane,
    // rust: u0,
    // rust: u1,
    // rust: segment,
    // rust: &prepared[nz as usize * CELLS + nx as usize],
    // rust: || material(segment.span, direction, centre(z * CELLS + x)),
    // rust: own_sky,
    // rust: );
    // rust: } else {
    // rust: let edge_side = match direction {
    // rust: Direction::West => 0,
    // rust: Direction::East => 1,
    // rust: Direction::North => 2,
    // rust: Direction::South => 3,
    // rust: _ => unreachable!(),
}
    // rust: if neighbors[edge_side].is_empty() {
    // rust: add_side(
    // rust: &mut faces,
    // rust: direction,
    // rust: plane,
    // rust: u0,
    // rust: u1,
    // rust: segment,
    // rust: &[],
    // rust: || material(segment.span, direction, centre(z * CELLS + x)),
    // rust: own_sky,
    // rust: );
}
                                // A coarse face can meet several finer columns.
                                // Clip each interval independently to avoid missing walls.
    // rust: for (i, edge) in neighbors[edge_side].iter().enumerate() {
    // rust: if edge.unknown {
    // rust: continue;
}
    // rust: let start = u0.max(edge.start as f32);
    // rust: let end = u1.min(edge.end as f32);
    // rust: if start < end {
    // rust: add_side(
    // rust: &mut faces,
    // rust: direction,
    // rust: plane,
    // rust: start,
    // rust: end,
    // rust: segment,
    // rust: &prepared[edge_offsets[edge_side] + i],
    // rust: || {
    // rust: material(
    // rust: segment.span,
    // rust: direction,
    // rust: centre(z * CELLS + x),
    // rust: )
    // rust: },
    // rust: own_sky,
    // rust: );
}
}
}
}
}
}
}
}
}
    // rust: let mut mesh = SectionMesh::default();
    // rust: for (key, mut rects) in faces {
    // rust: merge(&mut rects);
    // rust: for rect in rects {
    // rust: emit(&mut mesh, key, rect)
}
}
    // rust: mesh.finish_sprite_layers();
    // rust: mesh
}

    // rust: mod refinement_tests {
//     use super::*;
pub fn fallback_mesh_leaves_exactly_the_fine_tiles_footprints_empty() void {
}
    // rust: let parent = TileKey {
    // rust: x: -1,
    // rust: z: -1,
    // rust: level: 5,
}
        // Smaller than one coarse cell, away from the parent's outer edges.
    // rust: let fine = TileKey {
    // rust: x: -17,
    // rust: z: -17,
    // rust: level: 0,
}
    // rust: let columns = vec![
    // rust: Column {
    // rust: surface: None,
    // rust: spans: vec![Span {
    // rust: min: 0,
    // rust: max: 8,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 240,
    // rust: }]
    // rust: .into()
}
    // rust: 256
    // rust: ];
    // rust: let columns: Vec<&Column> = columns.iter().collect();
    // rust: let mesh = mesh_columns_with_edges(
    // rust: parent,
    // rust: &columns,
    // rust: &FxHashSet::default(),
    // rust: None,
    // rust: &[Vec::new(), Vec::new(), Vec::new(), Vec::new()],
    // rust: &[fine],
    // rust: |_, _, _| Material {
    // rust: faces: [
    // rust: Some(Paint {
    // rust: layer: 1,
    // rust: light: 240,
    // rust: color: u32::MAX,
    // rust: translucent: false,
    // rust: }),
    // rust: None,
    // rust: ],
    // rust: fluid: 0,
    // rust: opaque: true,
    // rust: },
    // rust: );
    // rust: let [ox, _, oz] = parent.origin();
    // rust: let [fx, _, fz] = fine.origin();
    // rust: let mut area = 0.0;
    // rust: for quad in mesh.solid.as_chunks::<4>().0 {
    // rust: if !quad.iter().all(|v| v.pos[1] == 8.0) {
    // rust: continue;
}
    // rust: let a = glam::Vec3::from(quad[0].pos);
    // rust: let b = glam::Vec3::from(quad[1].pos);
    // rust: let c = glam::Vec3::from(quad[2].pos);
    // rust: let normal = (b - a).cross(c - a);
    // rust: area += normal.y;
    // rust: let min_x = quad.iter().map(|v| v.pos[0]).fold(f32::INFINITY, f32::min) + ox as f32;
    // rust: let max_x = quad
    // rust: .iter()
    // rust: .map(|v| v.pos[0])
    // rust: .fold(f32::NEG_INFINITY, f32::max)
    // rust: + ox as f32;
    // rust: let min_z = quad.iter().map(|v| v.pos[2]).fold(f32::INFINITY, f32::min) + oz as f32;
    // rust: let max_z = quad
    // rust: .iter()
    // rust: .map(|v| v.pos[2])
    // rust: .fold(f32::NEG_INFINITY, f32::max)
    // rust: + oz as f32;
    // rust: assert!(
    // rust: !(min_x < (fx + 16) as f32
    // rust: && max_x > fx as f32
    // rust: && min_z < (fz + 16) as f32
    // rust: && max_z > fz as f32)
    // rust: );
}
    // rust: assert_eq!(area, (parent.size() * parent.size() - 256) as f32);
}
    /// A neighbour that is still to come draws no wall against it; an empty
    /// one (out of range) does.
pub fn unknown_neighbor_leaves_its_side_out() void {
}
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let columns = vec![
    // rust: Column {
    // rust: surface: None,
    // rust: spans: vec![Span {
    // rust: min: 0,
    // rust: max: 8,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 240,
    // rust: }]
    // rust: .into()
}
    // rust: 256
    // rust: ];
    // rust: let columns: Vec<&Column> = columns.iter().collect();
    // rust: let empty = Column::default();
    // rust: let east_quads = |unknown: bool| {
    // rust: let edge = |column| EdgeColumn {
    // rust: start: 0,
    // rust: end: 16,
    // rust: column,
    // rust: unknown,
}
    // rust: let neighbors = [Vec::new(), vec![edge(&empty)], Vec::new(), Vec::new()];
    // rust: let mesh = mesh_columns_with_edges(
    // rust: key,
    // rust: &columns,
    // rust: &FxHashSet::default(),
    // rust: None,
    // rust: &neighbors,
    // rust: &[],
    // rust: |_, _, _| Material {
    // rust: faces: [
    // rust: Some(Paint {
    // rust: layer: 1,
    // rust: light: 240,
    // rust: color: u32::MAX,
    // rust: translucent: false,
    // rust: }),
    // rust: None,
    // rust: ],
    // rust: fluid: 0,
    // rust: opaque: true,
    // rust: },
    // rust: );
    // rust: mesh.solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|quad| quad.iter().all(|v| v.pos[0] == 16.0))
    // rust: .count()
}
    // rust: assert!(east_quads(false) > 0, "a wall faces the empty neighbour");
    // rust: assert_eq!(east_quads(true), 0, "none faces the unknown one");
}
}

/// The tile's columns with the gaps no open air reaches filled with the
/// material below them, or the fluid above them (kelp and seagrass leave gaps
/// in water): a cave seen from nowhere adds no faces. A gap is open when a
/// neighbouring column's top lies below the gap's top, so that column's open
/// air looks into it, when a gap of the tile's neighbour meets it, or when it
/// meets an open gap of a neighbouring column: the air under a canopy reaches
/// the sky through any clearing, where filling it raised pillars of the floor
/// block. Unknown neighbours, and cells that `whole` rejects (they meet
/// full-detail or finer terrain), count as open; those cells keep their gaps.
    // rust: fn fill_buried_gaps<'a>(
    // rust: columns: &'a [&'a Column],
    // rust: neighbors: &'a [Vec<EdgeColumn<'a>>; 4],
    // rust: stride: i32,
    // rust: whole: impl Fn(usize, usize) -> bool,
    // rust: mut fluid: impl FnMut(&Span) -> bool,
    // rust: ) -> Vec<std::borrow::Cow<'a, Column>> {
//     use std::borrow::Cow;
    // rust: let top = |column: &Column| {
    // rust: column
    // rust: .spans
    // rust: .iter()
    // rust: .rev()
    // rust: .find(|span| span.min < span.max)
    // rust: .map_or(i16::MIN, |span| span.max)
}
    // Each column's gaps: the index of the span above, the gap's bottom and top.
    // rust: let gaps_of = |column: &Column| -> Vec<(usize, i16, i16)> {
    // rust: column
    // rust: .spans
    // rust: .windows(2)
    // rust: .enumerate()
    // rust: .filter(|(_, pair)| pair[0].max < pair[1].min)
    // rust: .map(|(k, pair)| (k + 1, pair[0].max, pair[1].min))
    // rust: .collect()
}
    // rust: let meets =
    // rust: |(lo, hi): (i16, i16), (other_lo, other_hi): (i16, i16)| lo < other_hi && other_lo < hi;
    // rust: let tops: [i16; CELLS * CELLS] = std::array::from_fn(|i| {
    // rust: if whole(i % CELLS, i / CELLS) {
    // rust: top(columns[i])
    // rust: } else {
    // rust: i16::MIN
}
    // rust: });
    // rust: let gaps: Vec<Vec<(usize, i16, i16)>> = (0..CELLS * CELLS)
    // rust: .map(|i| {
    // rust: if whole(i % CELLS, i / CELLS) {
    // rust: gaps_of(columns[i])
    // rust: } else {
    // rust: Vec::new()
}
    // rust: })
    // rust: .collect();
    // rust: let touching = |side: usize, cell: usize| {
    // rust: let (start, end) = (cell as i32 * stride, (cell as i32 + 1) * stride);
    // rust: neighbors[side]
    // rust: .iter()
    // rust: .filter(move |edge| edge.start < end && start < edge.end)
}
    // rust: let edge = |side: usize, cell: usize| {
    // rust: touching(side, cell)
    // rust: .map(|edge| top(edge.column))
    // rust: .min()
    // rust: .unwrap_or(i16::MIN)
}
    // A gap of the tile's neighbour may be open through tiles this one can't
    // see: it counts as open.
    // rust: let edge_gap = |side: usize, cell: usize, gap: (i16, i16)| {
    // rust: touching(side, cell).any(|edge| {
    // rust: gaps_of(edge.column)
    // rust: .iter()
    // rust: .any(|&(_, lo, hi)| meets((lo, hi), gap))
    // rust: })
}
    // rust: let around = |i: usize| {
    // rust: let (x, z) = (i % CELLS, i / CELLS);
    // rust: [
    // rust: (x > 0).then(|| i - 1),
    // rust: (x + 1 < CELLS).then(|| i + 1),
    // rust: (z > 0).then(|| i - CELLS),
    // rust: (z + 1 < CELLS).then(|| i + CELLS),
    // rust: ]
    // rust: .into_iter()
    // rust: .flatten()
}
    // rust: let mut open: Vec<Vec<bool>> = gaps.iter().map(|g| vec![false; g.len()]).collect();
    // rust: let mut reached = Vec::new();
    // rust: for i in 0..CELLS * CELLS {
    // rust: let (x, z) = (i % CELLS, i / CELLS);
    // rust: let lowest = [
    // rust: if x > 0 { tops[i - 1] } else { edge(0, z) },
    // rust: if x + 1 < CELLS {
    // rust: tops[i + 1]
    // rust: } else {
    // rust: edge(1, z)
    // rust: },
    // rust: if z > 0 { tops[i - CELLS] } else { edge(2, x) },
    // rust: if z + 1 < CELLS {
    // rust: tops[i + CELLS]
    // rust: } else {
    // rust: edge(3, x)
    // rust: },
    // rust: ]
    // rust: .into_iter()
    // rust: .min()
    // rust: .unwrap_or(i16::MIN);
    // rust: for (g, &(_, lo, hi)) in gaps[i].iter().enumerate() {
    // rust: let gap = (lo, hi);
    // rust: if hi > lowest
    // rust: || (x == 0 && edge_gap(0, z, gap))
    // rust: || (x + 1 == CELLS && edge_gap(1, z, gap))
    // rust: || (z == 0 && edge_gap(2, x, gap))
    // rust: || (z + 1 == CELLS && edge_gap(3, x, gap))
    // rust: {
    // rust: open[i][g] = true;
    // rust: reached.push((i, g));
}
}
}
    // rust: while let Some((i, g)) = reached.pop() {
    // rust: let (_, lo, hi) = gaps[i][g];
    // rust: for j in around(i) {
    // rust: for (h, &(_, other_lo, other_hi)) in gaps[j].iter().enumerate() {
    // rust: if !open[j][h] && meets((lo, hi), (other_lo, other_hi)) {
    // rust: open[j][h] = true;
    // rust: reached.push((j, h));
}
}
}
}
    // rust: columns
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, column)| {
    // rust: let column = *column;
    // rust: if open[i].iter().all(|&open| open) {
    // rust: return Cow::Borrowed(column);
}
    // rust: let mut filled = Column {
    // rust: surface: column.surface,
    // rust: spans: Spans::with_capacity(column.spans.len()),
}
    // rust: for (k, &span) in column.spans.iter().enumerate() {
    // rust: let mut span = span;
    // rust: let buried = gaps[i]
    // rust: .iter()
    // rust: .zip(&open[i])
    // rust: .any(|(&(above, _, _), &open)| above == k && !open);
    // rust: if buried && let Some(below) = filled.spans.last_mut() {
    // rust: if fluid(&span) {
    // rust: span.min = below.max;
    // rust: } else {
    // rust: below.max = span.min;
}
}
    // rust: filled.push(span);
}
    // rust: Cow::Owned(filled)
    // rust: })
    // rust: .collect()
}

/// Adds the parts of `segment`'s side not hidden by `neighbor`, the column
/// it faces. Parts above the neighbour's top face open air: reduced columns
/// and the seals at full-detail edges expose sides that were buried (their
/// recorded light is a cave's or none), so those take at least the sky light
/// over the top of the neighbour (or of this column, with no neighbour).
    // rust: fn add_side(
    // rust: faces: &mut Faces,
    // rust: direction: Direction,
    // rust: plane: f32,
    // rust: u0: f32,
    // rust: u1: f32,
    // rust: segment: &Segment<'_>,
    // rust: neighbor: &[Segment<'_>],
    // rust: mut side: impl FnMut() -> Material,
    // rust: own_sky: u16,
    // rust: ) {
    // rust: let (open, sky) = neighbor.last().map_or((f32::NEG_INFINITY, own_sky), |top| {
    // rust: (f32::from(top.span.max), top.span.light & 0xff)
    // rust: });
    // rust: let mut cached = None;
    // rust: let mut add = |v0: f32, v1: f32| {
    // rust: let side = match cached {
    // rust: Some(side) => side,
    // rust: None => {
    // rust: let side = side();
    // rust: cached = Some(side);
    // rust: side
}
}
    // rust: let mut lit = side;
    // rust: for paint in lit.faces.iter_mut().flatten() {
    // rust: paint.light = (paint.light & 0xff00) | (paint.light & 0xff).max(sky);
}
    // rust: let split = open.clamp(v0, v1);
    // rust: for (v0, v1, material) in [(v0, split, side), (split, v1, lit)] {
    // rust: if v0 < v1 {
    // rust: add_face(faces, direction, plane, Rect { u0, v0, u1, v1 }, material);
}
}
}
    // rust: let mut floor = segment.min;
    // rust: for next in neighbor {
    // rust: if next.max <= floor
    // rust: || next.min >= segment.max
    // rust: || !hides(next.span, next.material, segment.span, segment.material)
    // rust: {
    // rust: continue;
}
    // rust: if floor < next.min {
    // rust: add(floor, next.min.min(segment.max));
}
    // rust: floor = floor.max(next.max);
    // rust: if floor >= segment.max {
    // rust: break;
}
}
    // rust: if floor < segment.max {
    // rust: add(floor, segment.max);
}
}

pub fn merge(rects: *mut std.ArrayList(Rect)) void {
}
    // rust: rects.sort_unstable_by(|a, b| {
    // rust: a.v0.total_cmp(&b.v0)
    // rust: .then(a.v1.total_cmp(&b.v1))
    // rust: .then(a.u0.total_cmp(&b.u0))
    // rust: .then(a.u1.total_cmp(&b.u1))
    // rust: });
    // rust: let mut end = 0;
    // rust: for i in 0..rects.len() {
    // rust: let rect = rects[i];
    // rust: if end > 0
    // rust: && rects[end - 1].v0 == rect.v0
    // rust: && rects[end - 1].v1 == rect.v1
    // rust: && rects[end - 1].u1 == rect.u0
    // rust: {
    // rust: rects[end - 1].u1 = rect.u1;
    // rust: } else {
    // rust: rects[end] = rect;
    // rust: end += 1
}
}
    // rust: rects.truncate(end);
    // rust: rects.sort_unstable_by(|a, b| {
    // rust: a.u0.total_cmp(&b.u0)
    // rust: .then(a.u1.total_cmp(&b.u1))
    // rust: .then(a.v0.total_cmp(&b.v0))
    // rust: .then(a.v1.total_cmp(&b.v1))
    // rust: });
    // rust: end = 0;
    // rust: for i in 0..rects.len() {
    // rust: let rect = rects[i];
    // rust: if end > 0
    // rust: && rects[end - 1].u0 == rect.u0
    // rust: && rects[end - 1].u1 == rect.u1
    // rust: && rects[end - 1].v1 == rect.v0
    // rust: {
    // rust: rects[end - 1].v1 = rect.v1;
    // rust: } else {
    // rust: rects[end] = rect;
    // rust: end += 1
}
}
    // rust: rects.truncate(end);
}
/// The widest face `emit` writes, in blocks: its UVs, counted from the face's
/// corner, must stay within `TerrainVertex::tiled`'s range.
pub const MAX_FACE: f32 = 1024.0;
/// A face that would be more than this many `MAX_FACE` pieces is one quad
/// whose UVs are scaled to fit: a cell of the coarsest tiles is thousands to
/// millions of blocks wide, and the texture repeats within it are far below a
/// pixel.
pub const MAX_PIECES: f32 = 4.0;
/// Steps along a cell of a tile cut around finer terrain, at most.
pub const MAX_STEPS: i32 = 32;
pub fn emit(mesh: *mut SectionMesh, key: FaceKey, rect: Rect) void {
}
    // rust: let pieces = ((rect.u1 - rect.u0) / MAX_FACE).ceil() * ((rect.v1 - rect.v0) / MAX_FACE).ceil();
    // rust: if pieces > MAX_PIECES {
    // rust: let extent = (rect.u1 - rect.u0).max(rect.v1 - rect.v0);
    // rust: emit_quad(mesh, key, rect, (MAX_FACE / extent).min(1.0));
    // rust: return;
}
    // rust: let mut u0 = rect.u0;
    // rust: while u0 < rect.u1 {
    // rust: let u1 = rect.u1.min(u0 + MAX_FACE);
    // rust: let mut v0 = rect.v0;
    // rust: while v0 < rect.v1 {
    // rust: let v1 = rect.v1.min(v0 + MAX_FACE);
    // rust: emit_quad(mesh, key, Rect { u0, v0, u1, v1 }, 1.0);
    // rust: v0 = v1;
}
    // rust: u0 = u1;
}
}
/// `uv_scale` shrinks the UVs, in blocks from the face's corner, of a face
/// too wide for them.
pub fn emit_quad(mesh: *mut SectionMesh, key: FaceKey, rect: Rect, uv_scale: f32) void {
}
    // rust: mesh.note_sprite_layer(key.layer);
    // rust: let Rect { u0, v0, u1, v1 } = rect;
    // rust: let p = f32::from_bits(key.plane);
    // rust: let mut points = match key.direction {
    // rust: Direction::Up | Direction::Down => [[u0, p, v1], [u1, p, v1], [u1, p, v0], [u0, p, v0]],
    // rust: Direction::North | Direction::South => [[u0, v1, p], [u1, v1, p], [u1, v0, p], [u0, v0, p]],
    // rust: Direction::West | Direction::East => [[p, v1, u1], [p, v1, u0], [p, v0, u0], [p, v0, u1]],
}
    // rust: if matches!(
    // rust: key.direction,
    // rust: Direction::Down | Direction::South | Direction::East
    // rust: ) {
    // rust: points.reverse()
}
    // rust: let out = if key.translucent {
    // rust: &mut mesh.translucent
    // rust: } else {
    // rust: &mut mesh.solid
}
    // Tile origins are integer multiples of a block, so local coordinates
    // retain the world texture phase without distant-coordinate precision loss;
    // a whole number of blocks off each UV keeps it (terrain.wgsl's `tile_uv`
    // repeats the sprite per block) and counts it from the face's corner.
    // rust: let uvs = points.map(|pos| match key.direction {
    // rust: Direction::Up | Direction::Down => [pos[0], -pos[2]],
    // rust: Direction::North | Direction::South => [pos[0], -pos[1]],
    // rust: Direction::West | Direction::East => [pos[2], -pos[1]],
    // rust: });
    // rust: let corner = [0, 1].map(|i| {
    // rust: uvs.iter()
    // rust: .map(|uv| uv[i])
    // rust: .fold(f32::INFINITY, f32::min)
    // rust: .floor()
    // rust: });
    // rust: out.extend(points.into_iter().zip(uvs).map(|(pos, uv)| {
    // rust: TerrainVertex::tiled(
    // rust: pos,
    // rust: [
    // rust: (uv[0] - corner[0]) * uv_scale,
    // rust: (uv[1] - corner[1]) * uv_scale,
    // rust: ],
    // rust: key.layer,
    // rust: key.color,
    // rust: key.light,
    // rust: )
    // rust: }));
}

    // rust: mod tests {
//     use super::*;
pub fn span(min: i16, max: i16, state: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Span {
    // rust: min,
    // rust: max,
    // rust: state: BlockStateId(state),
    // rust: biome: 0,
    // rust: light: 240,
}
}
pub fn columns() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..CELLS * CELLS)
    // rust: .map(|_| Column {
    // rust: surface: None,
    // rust: spans: Spans::new(),
    // rust: })
    // rust: .collect()
}
pub fn material(span: *Span, _: Direction, _: [i32; 2]) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let water = span.state.0 == 2;
    // rust: Material {
    // rust: faces: [
    // rust: Some(Paint {
    // rust: layer: span.state.0 as u16,
    // rust: light: span.light,
    // rust: color: u32::MAX,
    // rust: translucent: water,
    // rust: }),
    // rust: None,
    // rust: ],
    // rust: fluid: u8::from(water),
    // rust: opaque: !water,
}
}
pub fn mesh(columns: *[Column]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mesh_columns(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
    // rust: },
    // rust: columns,
    // rust: &FxHashSet::default(),
    // rust: None,
    // rust: material,
    // rust: )
}
pub fn tiled_uv(v: *TerrainVertex) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.uv.map(|u| f32::from(u) / crate::mesher::TILED_UV_STEPS)
}
pub fn wide_faces_split_and_keep_their_texture_phase() void {
}
    // rust: let mut mesh = SectionMesh::default();
    // rust: let key = FaceKey {
    // rust: direction: Direction::Up,
    // rust: plane: 64.0f32.to_bits(),
    // rust: overlay: 0,
    // rust: layer: 1,
    // rust: light: 0,
    // rust: color: 0,
    // rust: translucent: false,
}
    // rust: emit(
    // rust: &mut mesh,
    // rust: key,
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.5,
    // rust: u1: 2500.0,
    // rust: v1: 16.0,
    // rust: },
    // rust: );
        // 2500 blocks: 1024 + 1024 + 452.
    // rust: assert_eq!(mesh.solid.len(), 3 * 4);
    // rust: let mut area = 0.0;
    // rust: for q in mesh.solid.as_chunks::<4>().0 {
    // rust: let x =
    // rust: |f: fn(f32, f32) -> f32, i: usize| q.iter().map(|v| v.pos[i]).reduce(f).unwrap();
    // rust: area += (x(f32::max, 0) - x(f32::min, 0)) * (x(f32::max, 2) - x(f32::min, 2));
    // rust: for v in q {
                // UVs follow the world position modulo a block.
    // rust: let uv = tiled_uv(v);
    // rust: assert_eq!((uv[0] - v.pos[0]).rem_euclid(1.0), 0.0);
    // rust: assert_eq!((uv[1] + v.pos[2]).rem_euclid(1.0), 0.0);
    // rust: assert!(uv[0] <= MAX_FACE + 1.0 && uv[1] <= MAX_FACE + 1.0);
}
}
    // rust: assert_eq!(area, 2500.0 * 15.5);
}
pub fn far_columns_are_heightmaps_of_their_surface_and_water() void {
}
    // rust: let fluid = |s: &Span| s.state.0 == 2;
    // rust: let strata = Column {
    // rust: surface: None,
    // rust: spans: vec![span(0, 60, 1), span(60, 63, 3), span(63, 64, 4)].into(),
}
    // rust: let flat = heightmap(&strata, fluid);
    // rust: assert_eq!(flat.spans, [span(-64, 64, 4)]);
    // rust: let sea = Column {
    // rust: surface: None,
    // rust: spans: vec![span(0, 50, 1), span(50, 62, 2)].into(),
}
    // rust: let flat = heightmap(&sea, fluid);
    // rust: assert_eq!(flat.spans, [span(-64, 50, 1), span(50, 62, 2)]);
    // rust: assert!(heightmap(&columns()[0], fluid).spans.is_empty());
        // A rolling landscape of strata: far tiles need a fraction of the quads.
    // rust: let rolling: Vec<Column> = (0..CELLS * CELLS)
    // rust: .map(|i| {
    // rust: let top = 64 + (i * 7 % 5) as i16;
    // rust: Column {
    // rust: surface: None,
    // rust: spans: vec![
    // rust: span(0, top - 4, 1),
    // rust: span(top - 4, top - 1, 3),
    // rust: span(top - 1, top, 4),
    // rust: ]
    // rust: .into(),
}
    // rust: })
    // rust: .collect();
    // rust: let quads = |level| {
    // rust: let key = TileKey { x: 0, z: 0, level };
    // rust: let mesh = mesh_columns(key, &rolling, &FxHashSet::default(), None, material);
    // rust: mesh.solid.len() / 4
}
    // rust: let (voxel, height) = (quads(HEIGHTMAP_LEVEL - 1), quads(HEIGHTMAP_LEVEL));
    // rust: assert!(height * 3 < voxel * 2, "{height} quads against {voxel}");
}
pub fn world_sized_faces_are_one_quad_with_uvs_that_fit() void {
}
    // rust: let mut mesh = SectionMesh::default();
    // rust: let key = FaceKey {
    // rust: direction: Direction::Up,
    // rust: plane: 64.0f32.to_bits(),
    // rust: overlay: 0,
    // rust: layer: 1,
    // rust: light: 0,
    // rust: color: 0,
    // rust: translucent: false,
}
    // rust: let size = 4_194_304.0;
    // rust: emit(
    // rust: &mut mesh,
    // rust: key,
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: size,
    // rust: v1: size / 2.0,
    // rust: },
    // rust: );
    // rust: assert_eq!(mesh.solid.len(), 4);
    // rust: let corners: Vec<[f32; 3]> = mesh.solid.iter().map(|v| v.pos).collect();
    // rust: assert!(
    // rust: corners.iter().any(|p| p[0] == size && p[2] == size / 2.0),
    // rust: "{corners:?}"
    // rust: );
    // rust: let top = mesh
    // rust: .solid
    // rust: .iter()
    // rust: .map(tiled_uv)
    // rust: .fold(0.0f32, |m, uv| m.max(uv[0]).max(uv[1]));
    // rust: assert!(top <= MAX_FACE + 1.0, "UV reaches {top}");
    // rust: assert!(
    // rust: top > MAX_FACE / 4.0,
    // rust: "the texture still repeats across the face"
    // rust: );
}
pub fn normal(q: *[TerrainVertex; 4]) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = |i: usize| glam::Vec3::from(q[i].pos);
    // rust: (p(1) - p(0)).cross(p(2) - p(0))
}
pub fn flat_solid_cube_merges_to_six_faces_with_block_scaled_uvs() void {
}
    // rust: let mut columns = columns();
    // rust: for column in &mut columns {
    // rust: column.spans = vec![span(0, 16, 1)].into()
}
    // rust: let mesh = mesh(&columns);
    // rust: assert_eq!(mesh.solid.len(), 6 * 4);
    // rust: assert!(mesh.translucent.is_empty());
    // rust: for q in mesh.solid.as_chunks::<4>().0.iter() {
    // rust: let center = q
    // rust: .iter()
    // rust: .map(|v| glam::Vec3::from(v.pos))
    // rust: .sum::<glam::Vec3>()
    // rust: / 4.0;
    // rust: assert!(normal(q).dot(center - glam::Vec3::splat(8.0)) > 0.0);
    // rust: assert_eq!(
    // rust: q.iter()
    // rust: .map(|v| tiled_uv(v)[0])
    // rust: .fold(f32::NEG_INFINITY, f32::max)
    // rust: - q.iter()
    // rust: .map(|v| tiled_uv(v)[0])
    // rust: .fold(f32::INFINITY, f32::min),
    // rust: 16.0
    // rust: );
    // rust: assert_eq!(
    // rust: q.iter()
    // rust: .map(|v| tiled_uv(v)[1])
    // rust: .fold(f32::NEG_INFINITY, f32::max)
    // rust: - q.iter()
    // rust: .map(|v| tiled_uv(v)[1])
    // rust: .fold(f32::INFINITY, f32::min),
    // rust: 16.0
    // rust: );
}
}
pub fn gaps_and_real_bottoms_remain_open_without_floor_curtains() void {
}
    // rust: let mut columns = columns();
    // rust: columns[0].spans = vec![span(3, 5, 1), span(8, 9, 1)].into();
    // rust: let mesh = mesh(&columns);
    // rust: assert_eq!(mesh.solid.len(), 12 * 4);
    // rust: assert!(
    // rust: mesh.solid
    // rust: .iter()
    // rust: .all(|v| (3.0..=5.0).contains(&v.pos[1]) || (8.0..=9.0).contains(&v.pos[1]))
    // rust: );
    // rust: assert!(
    // rust: mesh.solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .any(|q| q.iter().all(|v| v.pos[1] == 8.0) && normal(q).y < 0.0)
    // rust: );
}
pub fn neighbor_hides_only_its_occupied_side_intervals() void {
}
    // rust: let mut columns = columns();
    // rust: columns[0].spans = vec![span(0, 10, 1)].into();
    // rust: columns[1].spans = vec![span(0, 3, 1), span(7, 10, 1)].into();
    // rust: let mesh = mesh(&columns);
    // rust: let opening: Vec<_> = mesh
    // rust: .solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|q| q.iter().all(|v| v.pos[0] == 1.0) && normal(q).x > 0.0)
    // rust: .collect();
    // rust: assert_eq!(opening.len(), 1);
    // rust: assert_eq!(
    // rust: opening[0]
    // rust: .iter()
    // rust: .map(|v| v.pos[1])
    // rust: .fold(f32::INFINITY, f32::min),
    // rust: 3.0
    // rust: );
    // rust: assert_eq!(
    // rust: opening[0]
    // rust: .iter()
    // rust: .map(|v| v.pos[1])
    // rust: .fold(f32::NEG_INFINITY, f32::max),
    // rust: 7.0
    // rust: );
}
pub fn exposed_buried_sides_take_the_sky_light_over_their_neighbor() void {
}
    // rust: let mut columns = columns();
    // rust: let dark = |min, max| Span {
    // rust: light: 0,
    // rust: ..span(min, max, 1)
}
        // A reduced column whose lower blocks were buried (no light), next to
        // a lower column, and to one with a cave below its top.
    // rust: columns[0].spans = vec![dark(0, 9), span(9, 10, 1)].into();
    // rust: columns[1].spans = vec![span(0, 4, 1)].into();
    // rust: columns[CELLS].spans = vec![span(0, 2, 1), span(6, 12, 1)].into();
    // rust: let mesh = mesh(&columns);
    // rust: let quads = mesh.solid.as_chunks::<4>().0;
    // rust: let bounds = |q: &[TerrainVertex; 4]| {
    // rust: let ys = q.iter().map(|v| v.pos[1]);
    // rust: (
    // rust: ys.clone().fold(f32::INFINITY, f32::min),
    // rust: ys.fold(0.0, f32::max),
    // rust: )
}
        // Over the lower neighbour: open air, lit like its top.
    // rust: let open: Vec<_> = quads
    // rust: .iter()
    // rust: .filter(|q| q.iter().all(|v| v.pos[0] == 1.0 && v.pos[2] <= 1.0) && normal(q).x > 0.0)
    // rust: .collect();
    // rust: assert_eq!(open.len(), 1);
    // rust: assert_eq!(bounds(open[0]), (4.0, 10.0));
    // rust: assert!(open[0].iter().all(|v| v.light == 240));
        // Into the cave: its recorded light.
    // rust: let cave: Vec<_> = quads
    // rust: .iter()
    // rust: .filter(|q| q.iter().all(|v| v.pos[2] == 1.0 && v.pos[0] <= 1.0) && normal(q).z > 0.0)
    // rust: .collect();
    // rust: assert_eq!(cave.len(), 1);
    // rust: assert_eq!(bounds(cave[0]), (2.0, 6.0));
    // rust: assert!(cave[0].iter().all(|v| v.light == 0));
}
pub fn air_under_a_canopy_stays_open_through_a_clearing() void {
}
    // rust: let column = |spans: Vec<Span>| Column {
    // rust: surface: None,
    // rust: spans: spans.into(),
}
        // The tile's neighbours are solid hills: no open air from the sides.
    // rust: let hill_column = column(vec![span(0, 20, 1)]);
    // rust: let hill = || EdgeColumn {
    // rust: start: 0,
    // rust: end: CELLS as i32,
    // rust: column: &hill_column,
    // rust: unknown: false,
}
    // rust: let neighbors = [vec![hill()], vec![hill()], vec![hill()], vec![hill()]];
    // rust: let fill = |columns: &[Column]| -> Vec<Vec<Span>> {
    // rust: let columns: Vec<&Column> = columns.iter().collect();
    // rust: fill_buried_gaps(&columns, &neighbors, 1, |_, _| true, |_| false)
    // rust: .iter()
    // rust: .map(|filled| filled.spans.as_slice().to_vec())
    // rust: .collect()
}
    // rust: let mut forest = vec![column(vec![span(0, 5, 1), span(10, 14, 3)]); CELLS * CELLS];
        // A closed canopy hides the floor: filling it under there shows nowhere.
    // rust: assert!(fill(&forest).iter().all(|spans| spans[0].max == 10));
        // One clearing lets the sky in: the air under every tree stays air,
        // not a pillar of the floor block up to the leaves.
    // rust: forest[5 * CELLS + 5] = column(vec![span(0, 5, 1)]);
    // rust: let filled = fill(&forest);
    // rust: for (filled, column) in filled.iter().zip(&forest) {
    // rust: assert_eq!(filled.as_slice(), column.spans.as_slice());
}
        // A cave two columns wide sealed in rock is still filled.
    // rust: let mut rock = vec![column(vec![span(0, 20, 1)]); CELLS * CELLS];
    // rust: for cave in [5 * CELLS + 5, 5 * CELLS + 6] {
    // rust: rock[cave] = column(vec![span(0, 8, 1), span(12, 20, 1)]);
}
    // rust: assert!(
    // rust: fill(&rock)
    // rust: .iter()
    // rust: .all(|spans| spans.as_slice() == [span(0, 20, 1)])
    // rust: );
}
pub fn caves_no_neighbor_sees_into_add_no_faces() void {
}
    // rust: let mut columns = columns();
    // rust: for column in &mut columns {
    // rust: column.spans = vec![span(0, 20, 1)].into();
}
    // rust: let cave = 5 * CELLS + 5;
    // rust: columns[cave].spans = vec![span(0, 8, 1), span(12, 20, 1)].into();
    // rust: let at = |mesh: &SectionMesh, y: f32| {
    // rust: mesh.solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|q| q.iter().all(|v| v.pos[1] == y))
    // rust: .count()
}
        // Closed on every side: filled, no floor or ceiling.
    // rust: let closed = mesh(&columns);
    // rust: assert_eq!((at(&closed, 8.0), at(&closed, 12.0)), (0, 0));
    // rust: assert!(
    // rust: closed
    // rust: .solid
    // rust: .iter()
    // rust: .all(|v| v.pos[1] == 0.0 || v.pos[1] == 20.0)
    // rust: );
        // A lower neighbour's open air looks in: the cave stays.
    // rust: columns[cave + 1].spans = vec![span(0, 10, 1)].into();
    // rust: let open = mesh(&columns);
    // rust: assert_eq!((at(&open, 8.0), at(&open, 12.0)), (1, 1));
        // Kelp leaves a gap in water: water fills it, without inner faces.
    // rust: for column in &mut columns {
    // rust: column.spans = vec![span(0, 5, 1), span(5, 10, 2)].into();
}
    // rust: columns[cave].spans = vec![span(0, 5, 1), span(5, 7, 2), span(8, 10, 2)].into();
    // rust: let water = mesh(&columns);
    // rust: assert!(
    // rust: water
    // rust: .translucent
    // rust: .iter()
    // rust: .all(|v| v.pos[1] != 7.0 && v.pos[1] != 8.0)
    // rust: );
    // rust: let uniform = mesh(&vec![columns[0].clone(); CELLS * CELLS]);
    // rust: assert_eq!(water.translucent.len(), uniform.translucent.len());
}
pub fn greedy_faces_preserve_material_and_light_boundaries() void {
}
    // rust: let mut columns = columns();
    // rust: columns[0].spans = vec![span(0, 1, 1)].into();
    // rust: columns[1].spans = vec![span(0, 1, 3)].into();
    // rust: columns[2].spans = vec![Span {
    // rust: light: 16,
    // rust: ..span(0, 1, 3)
    // rust: }]
    // rust: .into();
    // rust: let mesh = mesh(&columns);
    // rust: let tops: Vec<_> = mesh
    // rust: .solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|q| normal(q).y > 0.0)
    // rust: .collect();
    // rust: assert_eq!(tops.len(), 3);
    // rust: assert_eq!(tops.iter().filter(|q| q[0].layer == 3).count(), 2);
    // rust: assert_eq!(tops.iter().filter(|q| q[0].light == 16).count(), 1);
    // rust: assert!(!mesh.solid.as_chunks::<4>().0.iter().any(|q| {
    // rust: normal(q).x != 0.0 && q.iter().all(|v| v.pos[0] == 1.0 || v.pos[0] == 2.0)
    // rust: }));
}
pub fn water_keeps_ground_surface_and_culls_shared_fluid_faces() void {
}
    // rust: let mut columns = columns();
    // rust: columns[0].spans = vec![span(0, 3, 1), span(3, 6, 2)].into();
    // rust: columns[1].spans = columns[0].spans.clone();
    // rust: let mesh = mesh(&columns);
    // rust: assert!(
    // rust: mesh.solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .any(|q| q.iter().all(|v| v.pos[1] == 3.0) && normal(q).y > 0.0)
    // rust: );
    // rust: assert!(
    // rust: mesh.translucent
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .all(|q| !(q.iter().all(|v| v.pos[0] == 1.0) && normal(q).x != 0.0))
    // rust: );
    // rust: assert!(mesh.translucent.as_chunks::<4>().0.iter().any(|q| {
    // rust: q.iter()
    // rust: .all(|v| (v.pos[1] - (6.0 - 1.0 / 9.0)).abs() < 0.001)
    // rust: && normal(q).y > 0.0
    // rust: }));
}
pub fn coarse_edge_clips_separate_fine_neighbor_heights() void {
}
    // rust: let mut columns = columns();
    // rust: for column in &mut columns {
    // rust: column.spans = vec![span(0, 16, 1)].into();
}
    // rust: let key = TileKey {
    // rust: x: -1,
    // rust: z: -1,
    // rust: level: 1,
}
    // rust: let mut neighbors: [Vec<EdgeColumn<'_>>; 4] = std::array::from_fn(|_| {
    // rust: vec![EdgeColumn {
    // rust: start: 0,
    // rust: end: 32,
    // rust: column: &columns[0],
    // rust: unknown: false,
    // rust: }]
    // rust: });
        // One fine column is lower than both the coarse cell and its sibling.
        // Sampling only the first neighbor would incorrectly hide this wall.
    // rust: let low = Column {
    // rust: surface: None,
    // rust: spans: vec![span(0, 8, 1)].into(),
}
    // rust: neighbors[0] = vec![
    // rust: EdgeColumn {
    // rust: start: 0,
    // rust: end: 1,
    // rust: column: &columns[0],
    // rust: unknown: false,
    // rust: },
    // rust: EdgeColumn {
    // rust: start: 1,
    // rust: end: 2,
    // rust: column: &low,
    // rust: unknown: false,
    // rust: },
    // rust: EdgeColumn {
    // rust: start: 2,
    // rust: end: 32,
    // rust: column: &columns[0],
    // rust: unknown: false,
    // rust: },
    // rust: ];
    // rust: let columns: Vec<&Column> = columns.iter().collect();
    // rust: let mesh = mesh_columns_with_edges(
    // rust: key,
    // rust: &columns,
    // rust: &FxHashSet::default(),
    // rust: None,
    // rust: &neighbors,
    // rust: &[],
    // rust: material,
    // rust: );
    // rust: let walls: Vec<_> = mesh
    // rust: .solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|quad| normal(quad).x < 0.0)
    // rust: .collect();
    // rust: assert_eq!(walls.len(), 1);
    // rust: let wall = walls[0];
    // rust: assert!(wall.iter().all(|v| v.pos[0] == 0.0
    // rust: && (1.0..=2.0).contains(&v.pos[2])
    // rust: && (8.0..=16.0).contains(&v.pos[1])));
    // rust: assert_eq!(normal(wall).length(), 8.0);
}
pub fn tile_halo_culls_shared_walls_but_keeps_steps_and_gaps() void {
}
    // rust: let mut columns = columns();
    // rust: for column in &mut columns {
    // rust: column.spans = vec![span(0, 16, 1)].into();
}
    // rust: let mut neighbors = columns[..4 * CELLS].to_vec();
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let covered = FxHashSet::default();
    // rust: let mesh = mesh_columns_with_neighbors(key, &columns, &covered, None, &neighbors, material);
    // rust: assert_eq!(
    // rust: mesh.solid.len(),
    // rust: 2 * 4,
    // rust: "only the top and real bottom remain"
    // rust: );
    // rust: assert!(
    // rust: mesh.solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .all(|q| normal(q).y != 0.0)
    // rust: );

    // rust: for column in &mut neighbors[CELLS..2 * CELLS] {
    // rust: column.spans = vec![span(0, 8, 1)].into();
}
    // rust: for column in &mut neighbors[..CELLS] {
    // rust: column.spans = vec![span(0, 3, 1), span(7, 16, 1)].into();
}
    // rust: let mesh = mesh_columns_with_neighbors(key, &columns, &covered, None, &neighbors, material);
    // rust: assert_eq!(mesh.solid.len(), 4 * 4);
    // rust: let sides: Vec<_> = mesh
    // rust: .solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|q| normal(q).y == 0.0)
    // rust: .collect();
    // rust: assert_eq!(sides.len(), 2);
    // rust: for q in sides {
    // rust: let min = q.iter().map(|v| v.pos[1]).fold(f32::INFINITY, f32::min);
    // rust: let max = q.iter().map(|v| v.pos[1]).fold(f32::NEG_INFINITY, f32::max);
    // rust: if normal(q).x > 0.0 {
    // rust: assert_eq!((min, max), (8.0, 16.0));
    // rust: } else {
    // rust: assert!(normal(q).x < 0.0);
    // rust: assert_eq!((min, max), (3.0, 7.0));
}
}
}
pub fn negative_parent_clips_chunks_without_internal_piece_walls() void {
}
    // rust: let mut columns = columns();
    // rust: for column in &mut columns {
    // rust: column.spans = vec![span(10, 12, 1)].into()
}
    // rust: let key = TileKey {
    // rust: x: -1,
    // rust: z: -1,
    // rust: level: 5,
}
    // rust: let [ox, _, oz] = key.origin();
    // rust: let mut covered = FxHashSet::default();
    // rust: covered.insert((ox.div_euclid(16), oz.div_euclid(16)));
    // rust: let mesh = mesh_columns(
    // rust: key,
    // rust: &columns,
    // rust: &covered,
    // rust: Some([ox, oz, ox + 16, oz + 16]),
    // rust: material,
    // rust: );
    // rust: assert!(mesh.solid.as_chunks::<4>().0.iter().all(|q| {
    // rust: if normal(q).y == 0.0 {
    // rust: return true;
}
    // rust: let center = q
    // rust: .iter()
    // rust: .map(|v| glam::Vec3::from(v.pos))
    // rust: .sum::<glam::Vec3>()
    // rust: / 4.0;
    // rust: !(center.x < 16.0 && center.z < 16.0)
    // rust: }));
    // rust: let cuts: Vec<_> = mesh
    // rust: .solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|q| {
    // rust: (q.iter().all(|v| v.pos[0] == 16.0) && normal(q).x < 0.0)
    // rust: || (q.iter().all(|v| v.pos[2] == 16.0) && normal(q).z < 0.0)
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(cuts.len(), 2);
    // rust: assert!(
    // rust: cuts.iter()
    // rust: .all(|q| q.iter().all(|v| (10.0..=12.0).contains(&v.pos[1]))),
    // rust: "cut faces keep finite voxel bounds"
    // rust: );
}
}
