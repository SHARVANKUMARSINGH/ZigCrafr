//! Transpiled from Horizon Rust crate
//! Module: horizon-client_shulker_space_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use horizon_core::geometry::{Axis, VoxelShape};
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: collision::CachedCollisionRegistry,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use std::sync::Arc;

pub fn text(value: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::String(value.into())
}
pub fn shape_tag(shape: *VoxelShape) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sizes = shape.sizes();
    // rust: let mut bits = Vec::new();
    // rust: for z in 0..sizes[2] {
    // rust: for y in 0..sizes[1] {
    // rust: for x in 0..sizes[0] {
    // rust: bits.push(u8::from(shape.is_full(x as i32, y as i32, z as i32)));
}
}
}
    // rust: let (min, max) = shape.discrete_bounds();
    // rust: let mut fields = vec![
    // rust: ("occupied", Tag::ByteArray(bits)),
    // rust: ("cube", Tag::Byte(i8::from(shape.is_cube()))),
    // rust: (
    // rust: "cube_axes",
    // rust: Tag::Byte(
    // rust: shape
    // rust: .cube_coordinate_axes()
    // rust: .iter()
    // rust: .enumerate()
    // rust: .fold(0, |mask, (i, on)| mask | (i8::from(*on) << i)),
    // rust: ),
    // rust: ),
    // rust: ("discrete_min", Tag::IntArray(min.to_vec())),
    // rust: ("discrete_max", Tag::IntArray(max.to_vec())),
    // rust: ];
    // rust: for (axis, name) in [(Axis::X, "x"), (Axis::Y, "y"), (Axis::Z, "z")] {
    // rust: fields.push((
    // rust: name,
    // rust: Tag::LongArray(
    // rust: shape
    // rust: .coordinates(axis)
    // rust: .iter()
    // rust: .map(|v| v.to_bits() as i64)
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: Tag::compound(fields)
}

pub fn fixture() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = ["air", "soul_sand", "stone", "scaffolding", "oak_slab"];
    // rust: let states: Vec<_> = names
    // rust: .iter()
    // rust: .map(|name| {
    // rust: let mut fields = vec![("id", text(&format!("minecraft:{name}")))];
    // rust: if *name == "scaffolding" {
    // rust: fields.push((
    // rust: "properties",
    // rust: Tag::compound([
    // rust: ("distance", text("7")),
    // rust: ("bottom", text("false")),
    // rust: ("waterlogged", text("false")),
    // rust: ]),
    // rust: ));
}
    // rust: Tag::compound(fields)
    // rust: })
    // rust: .collect();
    // rust: let registry_tag = Tag::compound([
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ("states", Tag::List(states.clone())),
    // rust: (
    // rust: "defaults",
    // rust: Tag::Compound(
    // rust: names
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, name)| {
    // rust: (
    // rust: format!("minecraft:{name}").as_str().into(),
    // rust: Tag::Int(i as i32),
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ]);
    // rust: let registry = BlockRegistry::from_nbt(&registry_tag).unwrap();
pub const NEXT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-shulker-space-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
    // rust: ));
    // rust: std::fs::create_dir(&root).unwrap();
    // Original minimal facts: air identity and generic sturdy flags, deliberately
    // distinct from the soul sand's lower collision shape.
    // rust: let facts = serde_json::json!({"states":(0..names.len()).map(|id|serde_json::json!({"id":id})).collect::<Vec<_>>()});
    // rust: std::fs::write(root.join("gameplay-facts.json"), facts.to_string()).unwrap();
    // rust: let behaviours = serde_json::json!({"states":[[0,0],[63,0],[63,0],[0,0],[1,0]],"blocks":names.iter().map(|name|serde_json::json!({"name":format!("minecraft:{name}"),"class":["Block"]})).collect::<Vec<_>>()});
    // rust: let facts =
    // rust: crate::blocks::BlockFacts::load_with_behaviour_json(&root, &registry, &behaviours).unwrap();
    // rust: std::fs::remove_dir_all(root).unwrap();
    // rust: let box_shape =
    // rust: |height| VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, height, 1.0))).unwrap();
    // rust: let shapes = [
    // rust: VoxelShape::empty(),
    // rust: box_shape(0.875),
    // rust: VoxelShape::block(),
    // rust: VoxelShape::block(),
    // rust: box_shape(0.5),
    // rust: ];
    // rust: let table = Tag::compound([
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ("states", Tag::List(states)),
    // rust: ("shapes", Tag::List(shapes.iter().map(shape_tag).collect())),
    // rust: ("cached_shapes", Tag::IntArray(vec![0, 1, 2, 3, 4])),
    // rust: ]);
    // rust: (registry, facts, table)
}

pub fn check(current: Vec3, cells: *[([i32; 3]) void {
}
    // rust: let (registry, facts, table) = fixture();
    // rust: let cached = CachedCollisionRegistry::from_nbt(&table, &registry).unwrap();
    // rust: let binding = BlockCollisionRegistry::new(Arc::new(cached)).unwrap();
    // rust: let mut world = crate::world::World::new(BlockStateId(0), 0);
    // rust: for x in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: world
    // rust: .chunks
    // rust: .insert((x, z), Arc::new(crate::chunk::Chunk::empty(x, z)));
}
}
    // rust: for &(p, state) in cells {
    // rust: world.set(p[0], p[1], p[2], BlockStateId(state)).unwrap();
}
    // rust: let mut mob = super::tests::shulker();
    // rust: mob.position = current;
    // rust: BlockSpace {
    // rust: world: &world,
    // rust: registry: &registry,
    // rust: facts: &facts,
    // rust: binding: &binding,
    // rust: powder_walkable: false,
}
    // rust: .can_stay_at(&mob, target, face)
}

pub fn soul_sand_only_accepts_attachment_to_its_bottom() void {
}
    // rust: for (face, step) in STEPS.iter().enumerate() {
    // rust: let support = [step[0], 64 + step[1], step[2]];
    // rust: assert_eq!(
    // rust: check(
    // rust: Vec3::new(8.5, 64.0, 8.5),
    // rust: &[(support, 1)],
    // rust: [0, 64, 0],
    // rust: face as u8
    // rust: ),
    // rust: face == 1,
    // rust: "face {face}"
    // rust: );
}
}

pub fn scaffolding_uses_the_shulkers_current_height_before_and_after_teleport() void {
}
    // rust: let cells = [([0, 63, 0], 3), ([0, 65, 0], 4)];
    // rust: assert!(check(Vec3::new(0.5, 62.0, 0.5), &cells, [0, 64, 0], 1));
    // rust: assert!(!check(Vec3::new(0.5, 64.0, 0.5), &cells, [0, 64, 0], 1));
}

pub fn shulker_space_parity_fixture() void {
}
//     use std::io::Write;
    // rust: let input =
    // rust: std::fs::read_to_string(std::env::var("HORIZON_SHULKER_SPACE_INPUT").unwrap()).unwrap();
    // rust: let mut output =
    // rust: std::fs::File::create(std::env::var("HORIZON_SHULKER_SPACE_OUTPUT").unwrap()).unwrap();
    // rust: for line in input.lines() {
    // rust: let row: serde_json::Value = serde_json::from_str(line).unwrap();
    // rust: let current = &row["current"];
    // rust: let current = Vec3::new(
    // rust: current[0].as_f64().unwrap(),
    // rust: current[1].as_f64().unwrap(),
    // rust: current[2].as_f64().unwrap(),
    // rust: );
    // rust: let target = std::array::from_fn(|i| row["target"][i].as_i64().unwrap() as i32);
    // rust: let cells: Vec<_> = row["cells"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|cell| {
    // rust: let pos = std::array::from_fn(|i| cell[i].as_i64().unwrap() as i32);
    // rust: let state = match cell[3].as_str().unwrap() {
    // rust: "minecraft:air" => 0,
    // rust: "minecraft:soul_sand" => 1,
    // rust: "minecraft:stone" => 2,
    // rust: "minecraft:scaffolding" => 3,
    // rust: "minecraft:oak_slab" => 4,
    // rust: _ => panic!("unknown fixture block"),
}
    // rust: (pos, state)
    // rust: })
    // rust: .collect();
    // rust: writeln!(
    // rust: output,
    // rust: "{}",
    // rust: check(current, &cells, target, row["face"].as_u64().unwrap() as u8)
    // rust: )
    // rust: .unwrap();
}
}
