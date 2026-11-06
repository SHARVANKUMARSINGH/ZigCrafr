//! Transpiled from Horizon Rust crate
package horizon_client_arrows_client_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use horizon_core::geometry::{Axis, VoxelShape};
// use horizon_world::{collision::CachedCollisionRegistry, nbt::Tag, registry::BlockRegistry};
// use std::{collections::BTreeSet, sync::Arc};
text :: proc(value: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(value.into())
}
shape_tag :: proc(shape: ^VoxelShape) -> T {
    // Ported from Horizon
    return {}
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

run :: proc(cells: ^[([i32; 3]) {
}
    // rust: run_with(cells, ticks, shared_fire, |_| {})
}
    // rust: fn run_with(
    // rust: cells: &[([i32; 3], u32)],
    // rust: ticks: usize,
    // rust: shared_fire: bool,
    // rust: setup: impl FnOnce(&mut Projectile),
    // rust: ) -> Vec<Projectile> {
    // rust: let mut definitions = vec![("air", None), ("stone", None)];
    // rust: for level in 0..16 {
    // rust: definitions.push(("water", Some(("level", level.to_string()))));
}
    // rust: for drag in [false, true] {
    // rust: definitions.push(("bubble_column", Some(("drag", drag.to_string()))));
}
    // rust: let states: Vec<_> = definitions
    // rust: .iter()
    // rust: .map(|(name, property)| {
    // rust: let mut fields = vec![("id", text(&format!("minecraft:{name}")))];
    // rust: if let Some((key, value)) = property {
    // rust: fields.push(("properties", Tag::compound([(*key, text(value))])));
}
    // rust: Tag::compound(fields)
    // rust: })
    // rust: .collect();
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ("states", Tag::List(states.clone())),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:air", Tag::Int(0)),
    // rust: ("minecraft:stone", Tag::Int(1)),
    // rust: ("minecraft:water", Tag::Int(2)),
    // rust: ("minecraft:bubble_column", Tag::Int(18)),
    // rust: ]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap();
NEXT :: std::sync::atomic::AtomicU64::new(0)
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-client-arrow-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
    // rust: ));
    // rust: std::fs::create_dir(&root).unwrap();
    // rust: std::fs::write(
    // rust: root.join("gameplay-facts.json"),
    // rust: serde_json::json!({"states":(0..states.len()).map(|id|serde_json::json!({"id":id})).collect::<Vec<_>>()} ).to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: let behaviours = serde_json::json!({"states":(0..states.len()).map(|id|if id==1{[63,0]}else{[0,0]}).collect::<Vec<_>>(),"blocks":(["air","stone","water","bubble_column"].iter().map(|name|serde_json::json!({"name":format!("minecraft:{name}"),"class":["Block"]})).collect::<Vec<_>>())});
    // rust: let facts = BlockFacts::load_with_behaviour_json(&root, &registry, &behaviours).unwrap();
    // rust: std::fs::remove_dir_all(root).unwrap();
    // rust: let table = Tag::compound([
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ("states", Tag::List(states)),
    // rust: (
    // rust: "shapes",
    // rust: Tag::List(vec![
    // rust: shape_tag(&VoxelShape::empty()),
    // rust: shape_tag(&VoxelShape::block()),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "cached_shapes",
    // rust: Tag::IntArray((0..20).map(|id| i32::from(id == 1)).collect()),
    // rust: ),
    // rust: ]);
    // rust: let collision = BlockCollisionRegistry::new(Arc::new(
    // rust: CachedCollisionRegistry::from_nbt(&table, &registry).unwrap(),
    // rust: ))
    // rust: .unwrap();
    // rust: let fluids = FluidResources::from_registry(&registry, &facts, &BTreeSet::new()).unwrap();
    // rust: let mut world = World::new(BlockStateId(0), 0);
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
    // rust: let scene = ArrowScene {
    // rust: world: &world,
    // rust: registry: &registry,
    // rust: facts: &facts,
    // rust: collision: &collision,
    // rust: fluids: &fluids,
    // rust: raining: &|_| false,
    // rust: mob_griefing: true,
    // rust: tnt_explodes: true,
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: Vec3::new(0.5, 18.5, 0.5),
    // rust: None,
    // rust: );
    // rust: p.velocity = Vec3::new(1.0, 0.2, 0.0);
    // rust: p.arrow.as_mut().unwrap().synced_fire = shared_fire;
    // rust: p.arrow.as_mut().unwrap().fire_ticks = 80;
    // rust: setup(&mut p);
    // rust: let mut result = Vec::new();
    // rust: for _ in 0..ticks {
    // rust: p.arrow.as_mut().unwrap().events.clear();
    // rust: tick_client(&mut p, &scene);
    // rust: result.push(p.clone());
}
    // rust: result
}
first_water_tick_moves_before_water_inertia_and_keeps_synced_flames :: proc() {
}
    // rust: let mut cells = Vec::new();
    // rust: for x in -2..6 {
    // rust: for y in 16..21 {
    // rust: for z in -2..3 {
    // rust: cells.push(([x, y, z], 2));
}
}
}
    // rust: for shared_fire in [false, true] {
    // rust: let steps = run(&cells, 5, shared_fire);
    // rust: let p = &steps[0];
    // rust: assert_eq!(p.position, Vec3::new(1.5, 18.7, 0.5));
    // rust: assert_eq!(p.velocity.x.to_bits(), 0x3fef_ae14_8000_0000);
    // rust: assert_eq!(p.velocity.y.to_bits(), 0x3fc2_f1aa_0000_0000);
    // rust: for p in steps {
    // rust: let st = p.arrow.as_ref().unwrap();
    // rust: assert!(st.was_touching_water);
    // rust: assert_eq!(st.fire_ticks, 0);
    // rust: assert_eq!(st.on_fire(), shared_fire);
}
}
}

client_arrow_parity_fixture :: proc() {
}
//     use std::io::Write;
    // rust: let input =
    // rust: std::fs::read_to_string(std::env::var("HORIZON_CLIENT_ARROW_INPUT").unwrap()).unwrap();
    // rust: let mut output =
    // rust: std::fs::File::create(std::env::var("HORIZON_CLIENT_ARROW_OUTPUT").unwrap()).unwrap();
    // rust: let bits = |v: Vec3| {
    // rust: format!(
    // rust: "{:016x},{:016x},{:016x}",
    // rust: v.x.to_bits(),
    // rust: v.y.to_bits(),
    // rust: v.z.to_bits()
    // rust: )
}
    // rust: for line in input.lines() {
    // rust: let row: serde_json::Value = serde_json::from_str(line).unwrap();
    // rust: let cells: Vec<_> = row["cells"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|cell| {
    // rust: let at = std::array::from_fn(|i| cell[i].as_i64().unwrap() as i32);
    // rust: let id = match cell[3].as_str().unwrap() {
    // rust: "minecraft:air" => 0,
    // rust: "minecraft:stone" => 1,
    // rust: "minecraft:water" => {
    // rust: 2 + cell.get(4).and_then(|v| v.as_i64()).unwrap_or(0) as u32
}
    // rust: "minecraft:bubble_column" => {
    // rust: 18 + u32::from(cell.get(4).and_then(|v| v.as_bool()).unwrap_or(false))
}
    // rust: other => panic!("unsupported fixture block {other}"),
}
    // rust: (at, id)
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(row["position"], serde_json::json!([0.5, 18.5, 0.5]));
    // rust: assert_eq!(row["velocity"], serde_json::json!([1, 0.2, 0]));
    // rust: let steps = run_with(
    // rust: &cells,
    // rust: row["ticks"].as_u64().unwrap() as usize,
    // rust: row["sharedFire"].as_bool().unwrap_or(false),
    // rust: |p| {
    // rust: p.no_gravity = row["noGravity"].as_bool().unwrap_or(false);
    // rust: let st = p.arrow.as_mut().unwrap();
    // rust: st.no_physics = row["noPhysics"].as_bool().unwrap_or(false);
    // rust: if let Some(in_ground) = row["inGround"].as_bool() {
    // rust: st.in_ground = in_ground;
    // rust: p.stuck = in_ground;
    // rust: st.life = 1199;
}
    // rust: },
    // rust: );
    // rust: let records: Vec<_> = steps
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let st = p.arrow.as_ref().unwrap();
    // rust: let mut record = format!(
    // rust: "{}/{}/{}",
    // rust: bits(p.position),
    // rust: bits(p.velocity),
    // rust: st.was_touching_water
    // rust: );
    // rust: if row.get("sharedFire").is_some() {
    // rust: record.push_str(&format!("/{}/{}", st.fire_ticks, st.on_fire()));
}
    // rust: if row.get("inGround").is_some() {
    // rust: record.push_str(&format!("/{}", st.removed));
}
    // rust: record
    // rust: })
    // rust: .collect();
    // rust: writeln!(output, "{}", records.join(" ")).unwrap();
}
}

water_bubbles_use_damped_motion_and_crit_streaks_use_original_motion :: proc() {
}
    // rust: let cells: Vec<_> = (-2..6)
    // rust: .flat_map(|x| (16..21).flat_map(move |y| (-2..3).map(move |z| ([x, y, z], 2))))
    // rust: .collect();
    // rust: let steps = run_with(&cells, 2, false, |p| p.set_critical(true));
    // rust: let previous = &steps[0];
    // rust: let current = &steps[1];
    // rust: let original = previous.velocity;
    // rust: let damped = original.scale(f64::from(0.6f32));
    // rust: let events = &current.arrow.as_ref().unwrap().events;
    // rust: let bubbles: Vec<_> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: ArrowEvent::Particle {
    // rust: kind: ArrowParticle::Bubble,
    // rust: position,
    // rust: velocity,
    // rust: } => Some((*position, *velocity)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(bubbles.len(), 4);
    // rust: for (position, velocity) in bubbles {
    // rust: assert_eq!(velocity, damped);
    // rust: assert_eq!(position, previous.position.add_vector(damped.scale(-0.25)));
}
    // rust: let crits: Vec<_> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: ArrowEvent::Particle {
    // rust: kind: ArrowParticle::Crit,
    // rust: position,
    // rust: velocity,
    // rust: } => Some((*position, *velocity)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(crits.len(), 4);
    // rust: for (i, (position, velocity)) in crits.into_iter().enumerate() {
    // rust: assert_eq!(
    // rust: position,
    // rust: previous.position.add_vector(original.scale(i as f64 / 4.0))
    // rust: );
    // rust: assert_eq!(
    // rust: velocity,
    // rust: Vec3::new(-original.x, -original.y + 0.2, -original.z)
    // rust: );
}
}
air_and_stuck_arrows_leave_no_water_bubbles :: proc() {
}
    // rust: for critical in [false, true] {
    // rust: let steps = run_with(&[], 1, false, |p| p.set_critical(critical));
    // rust: let events = &steps[0].arrow.as_ref().unwrap().events;
    // rust: assert!(!events.iter().any(|e| matches!(
    // rust: e,
    // rust: ArrowEvent::Particle {
    // rust: kind: ArrowParticle::Bubble,
    // rust: ..
}
    // rust: )));
    // rust: assert_eq!(
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(
    // rust: e,
    // rust: ArrowEvent::Particle {
    // rust: kind: ArrowParticle::Crit,
    // rust: ..
}
    // rust: ))
    // rust: .count(),
    // rust: if critical { 4 } else { 0 }
    // rust: );
}
    // rust: let steps = run_with(&[([0, 18, 0], 1)], 2, false, |p| p.set_critical(true));
    // rust: assert!(steps[1].stuck);
    // rust: assert!(
    // rust: !steps[1]
    // rust: .arrow
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, ArrowEvent::Particle { .. }))
    // rust: );
}
remote_arrow_preserves_previous_rotation_as_it_turns_and_falls :: proc() {
}
    // rust: let steps = run_with(&[], 30, false, |p| {
    // rust: p.shoot(&mut LegacyRandom::new(7), [0.0, 1.0, 0.0], 0.3, 0.0);
    // rust: assert_eq!(p.previous_pitch, p.pitch);
    // rust: assert_eq!(p.previous_yaw, p.yaw);
    // rust: assert!((p.pitch - 90.0).abs() < 1e-4);
    // rust: });
    // rust: for pair in steps.windows(2) {
    // rust: assert_eq!(pair[1].previous_pitch, pair[0].pitch);
    // rust: assert_eq!(pair[1].previous_yaw, pair[0].yaw);
}
    // rust: assert!(steps.last().unwrap().pitch < 0.0);
}
// `Entity.playSound` hands `Level.playSound` no player and
// `ClientLevel.playSeededSound` plays only for its own player, so a client's
// arrow makes no sound itself: the server's sound packets carry its hit and
// splash.
a_client_arrow_hitting_stone_or_entering_water_plays_no_sound_itself :: proc() {
}
    // rust: let stone = run(&[([1, 18, 0], 1)], 2, false);
    // rust: assert!(
    // rust: stone.iter().any(|p| p.stuck),
    // rust: "the arrow sticks in the stone"
    // rust: );
    // rust: let mut water = Vec::new();
    // rust: for x in 2..8 {
    // rust: for y in 16..21 {
    // rust: for z in -2..3 {
    // rust: water.push(([x, y, z], 2));
}
}
}
    // rust: let wet = run(&water, 4, false);
    // rust: assert!(
    // rust: wet.last()
    // rust: .unwrap()
    // rust: .arrow
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .was_touching_water,
    // rust: "the arrow entered the water"
    // rust: );
    // rust: for p in stone.iter().chain(&wet) {
    // rust: let events = &p.arrow.as_ref().unwrap().events;
    // rust: assert!(
    // rust: !events.iter().any(|e| matches!(e, ArrowEvent::Sound { .. })),
    // rust: "{events:?}"
    // rust: );
}
}
