//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_reuse_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::chunk::Light;

pub fn padded_reuse_resets_missing_neighbors_and_matches_chunk_reads_across_layouts() void {
}
    // rust: let mut pad = Padded::default();
    // rust: let mut own = Box::new([u32::MAX; 4096]);
    // rust: for min_y in [MIN_Y, -256, 0, 256] {
    // rust: let layout = crate::chunk::ColumnLayout::new(min_y, 32).unwrap();
    // rust: let base_y = min_y + 16;
    // rust: let mut center = Chunk::with_layout(0, 0, layout);
    // rust: center.set(0, base_y, 0, 7);
    // rust: center.set(15, base_y + 15, 15, 9);
    // rust: let mut neighbor = Chunk::with_layout(1, 0, layout);
    // rust: neighbor.set(0, base_y + 2, 3, 11);
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&center);
    // rust: region[1][2] = Some(&neighbor);
    // rust: pad.fill(&region, 1, &mut own);
    // rust: let buffers = (pad.blocks.as_ptr(), pad.light.as_ptr());
    // rust: for current in [region, [[None; 3]; 3], region] {
    // rust: pad.fill(&current, 1, &mut own);
    // rust: for y in -B..16 + B {
    // rust: for z in -B..16 + B {
    // rust: for x in -B..16 + B {
    // rust: let chunk = current[((z + 16) >> 4) as usize][((x + 16) >> 4) as usize];
                        // A missing neighbour continues the centre's edge column.
    // rust: let (block, light) = match (chunk, current[1][1]) {
    // rust: (Some(c), _) => (
    // rust: c.get(x & 15, base_y + y, z & 15),
    // rust: c.light(x & 15, base_y + y, z & 15),
    // rust: ),
    // rust: (None, Some(c)) => {
    // rust: let (ex, ez) = (x.clamp(0, 15), z.clamp(0, 15));
    // rust: (c.get(ex, base_y + y, ez), c.light(ex, base_y + y, ez))
}
    // rust: (None, None) => (0, 0xF0),
}
    // rust: assert_eq!(pad.blocks[pi(x, y, z)], block);
    // rust: assert_eq!(pad.light[pi(x, y, z)], light);
}
}
}
    // rust: assert_eq!(buffers, (pad.blocks.as_ptr(), pad.light.as_ptr()));
}
}
}

pub fn padded_fill_reads_every_neighbour_and_its_light_like_chunk_reads() void {
}
    // rust: let mut state = 0x2545_F491_4F6C_DD1Du64;
    // rust: let mut next = move || {
    // rust: state ^= state << 13;
    // rust: state ^= state >> 7;
    // rust: state ^= state << 17;
    // rust: state
}
    // rust: let mut pad = Padded::default();
    // rust: let mut own = Box::new([0; 4096]);
    // rust: for min_y in [MIN_Y, 0] {
    // rust: let layout = crate::chunk::ColumnLayout::new(min_y, 32 * 16).unwrap();
        // Nine chunks with their own blocks and per-block light, near the
        // bottom and top sections too, where the padding leaves the column.
    // rust: let chunks: Vec<Chunk> = (0..9)
    // rust: .map(|i| {
    // rust: let mut c = Chunk::with_layout(i % 3 - 1, i / 3 - 1, layout);
    // rust: for s in [0, 1, 30, 31] {
    // rust: for _ in 0..300 {
    // rust: let (x, y, z) = (next() % 16, next() % 16, next() % 16);
    // rust: let y = min_y + s * 16 + y as i32;
    // rust: c.set(x as i32, y, z as i32, 1 + (next() % 40) as u32);
}
    // rust: let mut light = Box::new([0u8; 4096]);
    // rust: light.iter_mut().for_each(|l| *l = next() as u8);
    // rust: std::sync::Arc::make_mut(&mut c.sections[s as usize]).light =
    // rust: Light::Full(light);
}
    // rust: c
    // rust: })
    // rust: .collect();
    // rust: let region: [[Option<&Chunk>; 3]; 3] =
    // rust: std::array::from_fn(|rz| std::array::from_fn(|rx| Some(&chunks[rz * 3 + rx])));
    // rust: for sy in [0, 1, 30, 31] {
    // rust: pad.fill(&region, sy, &mut own);
    // rust: let base_y = min_y + sy * 16;
    // rust: for y in -B..16 + B {
    // rust: for z in -B..16 + B {
    // rust: for x in -B..16 + B {
    // rust: let c = region[((z + 16) >> 4) as usize][((x + 16) >> 4) as usize].unwrap();
    // rust: let (cx, cy, cz) = (x & 15, base_y + y, z & 15);
    // rust: assert_eq!(
    // rust: pad.blocks[pi(x, y, z)],
    // rust: c.get(cx, cy, cz),
    // rust: "{min_y} {sy} {x} {y} {z}"
    // rust: );
    // rust: assert_eq!(
    // rust: pad.light[pi(x, y, z)],
    // rust: c.light(cx, cy, cz),
    // rust: "{min_y} {sy} {x} {y} {z}"
    // rust: );
}
}
}
}
}
}

/// Run explicitly with prepared assets; never silently pass without exercising geometry.
/// With a shader pack lighting the faces, every face of a lone stone block has one colour; the
/// game's face shading (up 1.0, down 0.5, north/south 0.8, east/west 0.6) is left to the pack.
pub fn a_shader_pack_lights_the_faces_itself() void {
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility.clone()).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap().0;
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(8, MIN_Y + 8, 8, stone);
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&chunk);
    // rust: let colours = |shader_pack_lighting| {
    // rust: let mut mesher = Mesher {
    // rust: nether_shading: false,
    // rust: shader_pack_lighting,
    // rust: separate_ao: false,
    // rust: shader_pack: false,
    // rust: assets: &assets,
    // rust: render: &render,
    // rust: tables: &tables,
    // rust: biomes: &biomes,
    // rust: visibility: visibility.clone(),
    // rust: zoom: BiomeZoom::new(0),
    // rust: blend_radius: 0,
    // rust: smooth_lighting: false,
    // rust: cutout_leaves: true,
    // rust: translucent_layers: &[],
    // rust: leaf_culling: LeafCullingMode::Off,
}
    // rust: let mut colours: Vec<u32> = mesher
    // rust: .mesh(&region, 0)
    // rust: .solid
    // rust: .iter()
    // rust: .map(|v| v.color)
    // rust: .collect();
    // rust: colours.sort_unstable();
    // rust: colours.dedup();
    // rust: colours
}
    // rust: assert_eq!(colours(false).len(), 4);
    // rust: assert_eq!(colours(true).len(), 1);
}

/// Run explicitly with prepared assets. With a shader pack lighting the faces, every face of a
/// block and of a lava source takes the dimension's up-face brightness, as Iris 1.11.7 gives our
/// probe pack: 0.9 in the Nether (`CardinalLighting.NETHER`'s up, 229 of 255), 1.0 elsewhere.
pub fn a_shader_pack_lights_every_nether_face_like_an_up_face() void {
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility.clone()).unwrap();
    // rust: let state = |name| assets.registry.default_state(name).unwrap().0;
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(4, MIN_Y + 8, 4, state("minecraft:netherrack"));
    // rust: chunk.set(11, MIN_Y + 8, 11, state("minecraft:lava"));
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&chunk);
    // rust: let colours = |nether_shading| {
    // rust: let mut mesher = Mesher {
    // rust: nether_shading,
    // rust: shader_pack_lighting: true,
    // rust: separate_ao: false,
    // rust: shader_pack: false,
    // rust: assets: &assets,
    // rust: render: &render,
    // rust: tables: &tables,
    // rust: biomes: &biomes,
    // rust: visibility: visibility.clone(),
    // rust: zoom: BiomeZoom::new(0),
    // rust: blend_radius: 0,
    // rust: smooth_lighting: false,
    // rust: cutout_leaves: true,
    // rust: translucent_layers: &[],
    // rust: leaf_culling: LeafCullingMode::Off,
}
    // rust: let mesh = mesher.mesh(&region, 0);
        // Both blocks' six faces: 2 × 6 quads of 4 vertices.
    // rust: let all: Vec<_> = mesh.solid.iter().chain(&mesh.translucent).collect();
    // rust: assert!(all.len() >= 48, "{} vertices", all.len());
    // rust: let mut colours: Vec<u32> = all.iter().map(|v| v.color & 0xFF_FFFF).collect();
    // rust: colours.sort_unstable();
    // rust: colours.dedup();
    // rust: colours
}
    // rust: assert_eq!(colours(true), [0xE5_E5E5]);
    // rust: assert_eq!(colours(false), [0xFF_FFFF]);
}

pub fn separate_ao_passes_ao_in_alpha_without_darkening_rgb() void {
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility.clone()).unwrap();
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap().0;
    // rust: let mut chunk = Chunk::empty(0, 0);
    // Place stone with neighbouring blocks to create AO variations.
    // rust: chunk.set(8, MIN_Y + 8, 8, stone);
    // rust: chunk.set(9, MIN_Y + 8, 8, stone);
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&chunk);
    // rust: let mut mesher = Mesher {
    // rust: nether_shading: false,
    // rust: shader_pack_lighting: true,
    // rust: separate_ao: true,
    // rust: shader_pack: false,
    // rust: assets: &assets,
    // rust: render: &render,
    // rust: tables: &tables,
    // rust: biomes: &biomes,
    // rust: visibility,
    // rust: zoom: BiomeZoom::new(0),
    // rust: blend_radius: 0,
    // rust: smooth_lighting: true,
    // rust: cutout_leaves: true,
    // rust: translucent_layers: &[],
    // rust: leaf_culling: LeafCullingMode::Off,
}
    // rust: let mesh = mesher.mesh(&region, 0);
    // rust: assert!(!mesh.solid.is_empty());
    // rust: for v in &mesh.solid {
        // RGB components should be pure un-darkened white (0xFFFFFF) because shader_pack_lighting is on.
    // rust: assert_eq!(v.color & 0x00FF_FFFF, 0x00FF_FFFF);
        // Alpha holds the AO factor, which must be non-zero.
    // rust: assert!(v.color >> 24 > 0);
}
}

pub fn reused_mesh_matches_fresh_geometry_across_sections_and_resource_reload() void {
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let state = |name| assets.registry.default_state(name).unwrap().0;
    // rust: let names = [
    // rust: "minecraft:stone",
    // rust: "minecraft:glass",
    // rust: "minecraft:grass_block",
    // rust: "minecraft:oak_leaves",
    // rust: "minecraft:water",
    // rust: "minecraft:chest",
    // rust: ];
    // rust: let mut dense = Chunk::empty(0, 0);
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: dense.set(
    // rust: x,
    // rust: MIN_Y + 4,
    // rust: z,
    // rust: state(names[((x + z) as usize) % names.len()]),
    // rust: );
}
}
    // rust: let mut sparse = Chunk::empty(-3, 5);
    // rust: sparse.set(0, MIN_Y + 15, 0, state("minecraft:short_grass"));
    // rust: sparse.set(15, MIN_Y + 1, 15, state("minecraft:lava"));
    // rust: let empty = Chunk::empty(0, 0);
    // rust: let mut neighbor = Chunk::empty(1, 0);
    // rust: neighbor.set(0, MIN_Y + 4, 0, state("minecraft:stone"));
    // rust: let mut custom = Chunk::with_layout(2, -4, crate::chunk::ColumnLayout::new(-256, 64).unwrap());
    // rust: custom.set(1, -252, 2, state("minecraft:chest"));
    // rust: let mut scratch = MeshScratch::default();
    // rust: let mut recycled = SectionMesh::default();
    // The same scratch and output buffers survive a resource reload. They must
    // contain no references into the previous RenderAssets or MeshTables.
    // rust: for reload in 0..2 {
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility.clone()).unwrap();
    // rust: let mut mesher = Mesher {
    // rust: nether_shading: false,
    // rust: shader_pack_lighting: false,
    // rust: separate_ao: false,
    // rust: shader_pack: false,
    // rust: assets: &assets,
    // rust: render: &render,
    // rust: tables: &tables,
    // rust: biomes: &biomes,
    // rust: visibility,
    // rust: zoom: BiomeZoom::new(42),
    // rust: blend_radius: 2,
    // rust: smooth_lighting: reload == 0,
    // rust: cutout_leaves: reload == 0,
    // rust: translucent_layers: &[],
    // rust: leaf_culling: LeafCullingMode::Off,
}
    // rust: for (case, (center, east)) in [
    // rust: (&empty, None),
    // rust: (&dense, Some(&neighbor)),
    // rust: (&sparse, None),
    // rust: (&empty, None),
    // rust: (&dense, None),
    // rust: (&custom, None),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(center);
    // rust: region[1][2] = east;
    // rust: let mut fresh = mesher.mesh(&region, 0);
    // rust: recycled = mesher.mesh_reusing(&region, 0, recycled, &mut scratch);
    // rust: if reload == 0 && case == 0 {
    // rust: assert!(scratch.own.is_none());
    // rust: assert_eq!(scratch.padded.blocks.capacity(), 0);
    // rust: assert_eq!(scratch.padded.light.capacity(), 0);
    // rust: assert_eq!(scratch.solid_rows.capacity(), 0);
}
    // rust: fresh.sort_solid();
    // rust: recycled.sort_solid();
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<TerrainVertex, u8>(&fresh.solid),
    // rust: bytemuck::cast_slice::<TerrainVertex, u8>(&recycled.solid)
    // rust: );
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<TerrainVertex, u8>(&fresh.translucent),
    // rust: bytemuck::cast_slice::<TerrainVertex, u8>(&recycled.translucent)
    // rust: );
    // rust: assert_eq!(fresh.block_entities, recycled.block_entities);
    // rust: assert_eq!(fresh.visibility, recycled.visibility);
    // rust: assert_eq!(fresh.sides, recycled.sides);
    // rust: assert_eq!(fresh.bounds, recycled.bounds);
    // rust: if std::ptr::eq(center, &dense) {
    // rust: assert!(!fresh.solid.is_empty());
    // rust: assert!(!fresh.translucent.is_empty());
    // rust: assert!(!fresh.block_entities.is_empty());
}
    // rust: if std::ptr::eq(center, &custom) {
    // rust: assert_eq!(
    // rust: fresh.block_entities,
    // rust: [([33, -252, -62], state("minecraft:chest"))]
    // rust: );
}
}
}
}

/// An isolated scratch-stage comparison, not a whole-mesher or FPS benchmark.
/// Output each sample so the caller can retain the observations and spread.
pub fn benchmark_padded_reuse() void {
}
pub const ITERATIONS: usize = 4096;
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: chunk.set(x, MIN_Y + y, z, 1 + ((x + y + z) % 7) as u32);
}
}
}
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&chunk);
    // rust: let mut pad = Padded::new(&region, 0);
    // rust: let mut own = Box::new([0; 4096]);
    // rust: let pointers = (pad.blocks.as_ptr(), pad.light.as_ptr(), own.as_ptr());
    // rust: let bytes = pad.blocks.capacity() * 4 + pad.light.capacity() + 4096 * 4;
    // Warm both code paths and the process allocator before recording samples.
    // rust: for _ in 0..1024 {
    // rust: std::hint::black_box(Padded::new(std::hint::black_box(&region), 0));
    // rust: pad.fill(std::hint::black_box(&region), 0, &mut own);
    // rust: std::hint::black_box(&pad);
}
    // rust: for sample in 0..9 {
        // Alternate execution order to expose, rather than hide, order effects.
    // rust: for reused in [sample % 2 == 0, sample % 2 != 0] {
    // rust: let start = std::time::Instant::now();
    // rust: for _ in 0..ITERATIONS {
    // rust: if reused {
    // rust: pad.fill(std::hint::black_box(&region), 0, &mut own);
    // rust: std::hint::black_box(&pad);
    // rust: } else {
    // rust: std::hint::black_box(Padded::new(std::hint::black_box(&region), 0));
}
}
    // rust: println!(
    // rust: "{{\"sample\":{sample},\"reused\":{reused},\"iterations\":{ITERATIONS},\"elapsed_ms\":{:.6},\"scratch_bytes\":{bytes}}}",
    // rust: start.elapsed().as_secs_f64() * 1000.0
    // rust: );
    // rust: assert_eq!(
    // rust: pointers,
    // rust: (pad.blocks.as_ptr(), pad.light.as_ptr(), own.as_ptr())
    // rust: );
}
}
}

/// Run explicitly with prepared assets. Under a `shaders/` pack, a still water top (a source
/// in a stone basin, flat) starts from its south-west corner, so its triangles meet along
/// north-east to south-west as Iris 1.11.7's do in our probes (`fluid::splits_north_east`);
/// without one it keeps vanilla's north-west start (`FluidRenderer.tesselate`).
pub fn a_shader_pack_s_still_water_top_starts_at_its_south_west_corner() void {
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility.clone()).unwrap();
    // rust: let state = |name| assets.registry.default_state(name).unwrap().0;
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for x in 7..=9 {
    // rust: for z in 7..=9 {
    // rust: chunk.set(x, MIN_Y + 7, z, state("minecraft:stone"));
    // rust: chunk.set(x, MIN_Y + 8, z, state("minecraft:stone"));
}
}
    // rust: chunk.set(8, MIN_Y + 8, 8, state("minecraft:water"));
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&chunk);
    // rust: let first_corner = |shader_pack| {
    // rust: let mut mesher = Mesher {
    // rust: nether_shading: false,
    // rust: shader_pack_lighting: shader_pack,
    // rust: separate_ao: false,
    // rust: shader_pack,
    // rust: assets: &assets,
    // rust: render: &render,
    // rust: tables: &tables,
    // rust: biomes: &biomes,
    // rust: visibility: visibility.clone(),
    // rust: zoom: BiomeZoom::new(0),
    // rust: blend_radius: 0,
    // rust: smooth_lighting: true,
    // rust: cutout_leaves: true,
    // rust: translucent_layers: &[],
    // rust: leaf_culling: LeafCullingMode::Off,
}
    // rust: let mesh = mesher.mesh(&region, 0);
        // The top and its backward face, both from the same first corner.
    // rust: let tops: Vec<[f32; 3]> = mesh
    // rust: .translucent
    // rust: .chunks(4)
    // rust: .filter(|q| q.iter().all(|v| v.pos[1] > 8.5 && v.pos[1] < 9.0))
    // rust: .map(|q| q[0].pos)
    // rust: .collect();
    // rust: assert_eq!(tops.len(), 2, "{tops:?}");
    // rust: assert_eq!(tops[0], tops[1]);
    // rust: [tops[0][0], tops[0][2]]
}
    // rust: assert_eq!(first_corner(false), [8.0, 8.0]);
    // rust: assert_eq!(first_corner(true), [8.0, 9.0]);
}
