//! Transpiled from Horizon Rust crate
package horizon_client_render_block_entity_render_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use crate::{
    // rust: block_entity_render::{
    // rust: BlockAnim, BlockEntityRenderer, BlockEntityShapes, CacheOptions, ChestPart, Kind,
    // rust: ModelPart, SIGN_TEXT_KEEP, Scene, StaticSectionRevision, classify,
    // rust: },
    // rust: chunk::Chunk,
    // rust: font::Glyph,
    // rust: hud::Rect,
    // rust: mesher::Vertex,
    // rust: signs::{SignData, SignText},
    // rust: world::World,
}
// use glam::{DVec3, Mat4, Quat, Vec3};
// use horizon_world::registry::BlockStateId;
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: collections::{HashMap, HashSet},
    // rust: sync::Arc,
}

unit_pose :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0]
}

quad :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0],
    // rust: [16.0, 0.0, 0.0, 1.0, 0.0],
    // rust: [16.0, 16.0, 0.0, 1.0, 1.0],
    // rust: [0.0, 16.0, 0.0, 0.0, 1.0],
    // rust: ]
}

horizontal_quad :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0],
    // rust: [16.0, 0.0, 0.0, 1.0, 0.0],
    // rust: [16.0, 0.0, 16.0, 1.0, 1.0],
    // rust: [0.0, 0.0, 16.0, 0.0, 1.0],
    // rust: ]
}

part :: proc(y: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: ModelPart {
    // rust: pose: [0.0, y, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![quad()],
    // rust: children: Vec::new(),
}
}

    // rust: fn renderer_with_shapes(
    // rust: models: HashMap<&'static str, ModelPart>,
    // rust: kinds: Vec<Kind>,
    // rust: pot_patterns: HashMap<String, String>,
    // rust: ) -> BlockEntityRenderer {
    // rust: let vanilla = Arc::new(BlockEntityShapes::new(models, HashMap::new()));
    // rust: BlockEntityRenderer {
    // rust: vanilla: vanilla.clone(),
    // rust: shapes: std::sync::RwLock::new(vanilla),
    // rust: kinds,
    // rust: pot_patterns,
    // rust: ..Default::default()
}
}

shulker_renderer :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let model = ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: Vec::new(),
    // rust: children: vec![("base".into(), part(0.0)), ("lid".into(), part(24.0))],
}
    // rust: renderer_with_shapes(
    // rust: HashMap::from([("shulker_box", model)]),
    // rust: vec![Kind::Shulker {
    // rust: texture: "entity/shulker/shulker".into(),
    // rust: facing: "up",
    // rust: }],
    // rust: HashMap::new(),
    // rust: )
}

bell_renderer :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let model = ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: Vec::new(),
    // rust: children: vec![("bell_body".into(), part(0.0))],
}
    // rust: renderer_with_shapes(
    // rust: HashMap::from([("bell", model)]),
    // rust: vec![Kind::Bell],
    // rust: HashMap::new(),
    // rust: )
}

chest_model :: proc(offset: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let chest_part = |y| ModelPart {
    // rust: pose: [0.0, y, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![quad(), horizontal_quad()],
    // rust: children: Vec::new(),
}
    // rust: ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: Vec::new(),
    // rust: children: vec![
    // rust: ("base".into(), chest_part(offset)),
    // rust: ("lid".into(), chest_part(offset + 8.0)),
    // rust: ("lock".into(), chest_part(offset + 8.0)),
    // rust: ],
}
}

chest_renderer_with :: proc(kinds: [dynamic]Kind) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let models = HashMap::from([
    // rust: ("chest", chest_model(0.0)),
    // rust: ("double_chest_left", chest_model(1.0)),
    // rust: ("double_chest_right", chest_model(2.0)),
    // rust: ]);
    // Shape construction precomputes closed-chest geometry so the fixture covers
    // the cached world path as well as the direct model path.
    // rust: renderer_with_shapes(models, kinds, HashMap::new())
}

chest_renderer :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: chest_renderer_with(vec![Kind::Chest {
    // rust: block: "chest".into(),
    // rust: texture: "entity/chest/normal",
    // rust: part: ChestPart::Single,
    // rust: y_rot: 90.0,
    // rust: double_with: None,
    // rust: }])
}

classified_chest :: proc(name: string, facing: string, part: string) -> K {
    // Ported from Horizon
    return {}
}
    // rust: classify(name, &|property| match property {
    // rust: "facing" => Some(facing.to_owned()),
    // rust: "type" => Some(part.to_owned()),
    // rust: _ => None,
    // rust: })
}

decorated_pot_renderer :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let sides = ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: Vec::new(),
    // rust: children: ["back", "left", "right", "front"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, name)| (name.into(), part(i as f32)))
    // rust: .collect(),
}
    // rust: renderer_with_shapes(
    // rust: HashMap::from([
    // rust: ("decorated_pot_base", part(0.0)),
    // rust: ("decorated_pot_sides", sides),
    // rust: ]),
    // rust: vec![Kind::DecoratedPot { y_rot: 0.0 }],
    // rust: ["back", "left", "right", "front"]
    // rust: .into_iter()
    // rust: .map(|side| {
    // rust: (
    // rust: format!("{side}_pattern"),
    // rust: format!("entity/decorated_pot/{side}_pattern"),
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: )
}

banner_renderer :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let banner_model = |name: &str| ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: Vec::new(),
    // rust: children: vec![(name.into(), part(0.0))],
}
    // rust: let standing = classify("minecraft:red_banner", &|property| match property {
    // rust: "rotation" => Some("0".into()),
    // rust: _ => None,
    // rust: });
    // rust: let wall = classify("minecraft:red_wall_banner", &|property| match property {
    // rust: "facing" => Some("north".into()),
    // rust: _ => None,
    // rust: });
    // rust: renderer_with_shapes(
    // rust: HashMap::from([
    // rust: ("standing_banner", banner_model("pole")),
    // rust: ("standing_banner_flag", banner_model("flag")),
    // rust: ("wall_banner", banner_model("pole")),
    // rust: ("wall_banner_flag", banner_model("flag")),
    // rust: ]),
    // rust: vec![standing, wall],
    // rust: HashMap::new(),
    // rust: )
}

copper_statue_renderer :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let model = |copies: usize| ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: vec![quad(); copies],
    // rust: children: Vec::new(),
}
    // rust: renderer_with_shapes(
    // rust: HashMap::from([
    // rust: ("copper_golem", model(1)),
    // rust: ("copper_golem_sitting", model(2)),
    // rust: ]),
    // rust: vec![
    // rust: Kind::CopperGolem {
    // rust: texture: "entity/copper_golem/copper_golem",
    // rust: pose: "standing",
    // rust: facing: "north",
    // rust: },
    // rust: Kind::CopperGolem {
    // rust: texture: "entity/copper_golem/copper_golem",
    // rust: pose: "sitting",
    // rust: facing: "north",
    // rust: },
    // rust: ],
    // rust: HashMap::new(),
    // rust: )
}

sprites :: proc(texture: string) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashMap::from([(
    // rust: texture.to_owned(),
    // rust: Rect {
    // rust: u0: 0.125,
    // rust: v0: 0.25,
    // rust: u1: 0.375,
    // rust: v1: 0.5,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: )])
}

sprite_atlas :: proc(textures: ^[string]) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let count = textures.len() as f32;
    // rust: textures
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(index, texture)| {
    // rust: let u0 = index as f32 / count;
    // rust: let u1 = (index + 1) as f32 / count;
    // rust: (
    // rust: (*texture).to_owned(),
    // rust: Rect {
    // rust: u0,
    // rust: v0: 0.0,
    // rust: u1,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect()
}

    // rust: fn render_direct(
    // rust: renderer: &BlockEntityRenderer,
    // rust: scene: &Scene,
    // rust: blocks: &[([i32; 3], u32)],
    // rust: ) -> Vec<Vertex> {
    // rust: let mut vertices = Vec::new();
    // rust: for &(pos, state) in blocks {
    // rust: let origin = (DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]))
    // rust: - scene.camera)
    // rust: .as_vec3();
    // rust: renderer.render_block(
    // rust: scene,
    // rust: pos,
    // rust: state,
    // rust: Mat4::from_translation(origin),
    // rust: scene.world.light(pos[0], pos[1], pos[2]),
    // rust: &mut vertices,
    // rust: );
}
    // rust: vertices
}

assert_same_vertices :: proc(actual: ^[Vertex], expected: ^[Vertex]) {
}
    // rust: assert_eq!(actual.len(), expected.len());
    // rust: for (actual, expected) in actual.iter().zip(expected) {
    // rust: assert!(
    // rust: (Vec3::from_array(actual.pos) - Vec3::from_array(expected.pos)).length() < 1e-5,
    // rust: "positions differ: {:?} != {:?}",
    // rust: actual.pos,
    // rust: expected.pos
    // rust: );
    // rust: assert_eq!(
    // rust: (
    // rust: actual.uv,
    // rust: actual.layer,
    // rust: actual.color,
    // rust: actual.light,
    // rust: actual.normal,
    // rust: actual.glint_uv,
    // rust: ),
    // rust: (
    // rust: expected.uv,
    // rust: expected.layer,
    // rust: expected.color,
    // rust: expected.light,
    // rust: expected.normal,
    // rust: expected.glint_uv,
    // rust: )
    // rust: );
}
}

assert_vertices_move :: proc(first: ^[Vertex], second: ^[Vertex]) {
}
    // rust: assert_eq!(first.len(), second.len());
    // rust: assert!(
    // rust: first
    // rust: .iter()
    // rust: .zip(second)
    // rust: .any(|(a, b)| (Vec3::from_array(a.pos) - Vec3::from_array(b.pos)).length() > 1e-4),
    // rust: "animated frames unexpectedly have identical geometry"
    // rust: );
}

assert_vertices_differ :: proc(first: ^[Vertex], second: ^[Vertex]) {
}
    // rust: assert_eq!(first.len(), second.len());
    // rust: assert!(
    // rust: first.iter().zip(second).any(|(a, b)| {
    // rust: (Vec3::from_array(a.pos) - Vec3::from_array(b.pos)).length() > 1e-4
    // rust: || a.uv != b.uv
    // rust: || a.color != b.color
    // rust: || a.light != b.light
    // rust: }),
    // rust: "expected at least one vertex attribute to change"
    // rust: );
}

batched_callbacks_preserve_entity_ranges_and_allow_immediate_culling :: proc() {
}
    // rust: let renderer = shulker_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprites("entity/shulker/shulker");
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(3.25, 64.5, -4.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // Reverse local-position order to check that cache indexing does not
    // change the order of emitted entities.
    // rust: let blocks = [([1, 64, 0], 0), ([0, 64, 0], 0)];
    // rust: let options = CacheOptions {
    // rust: shulker_boxes: true,
    // rust: ..Default::default()
}
    // rust: let mut expected = Vec::new();
    // rust: renderer.render(&scene, blocks.iter(), &mut expected);

    // rust: let before = RefCell::new(Vec::new());
    // rust: let after = RefCell::new(Vec::new());
    // rust: let mut actual = Vec::new();
    // rust: renderer.render_with_cache_options_and_callbacks(
    // rust: &scene,
    // rust: blocks.iter(),
    // rust: options,
    // rust: 0,
    // rust: None,
    // rust: &mut actual,
    // rust: |pos, state, start| before.borrow_mut().push((pos, state, start)),
    // rust: |pos, state, start, out| after.borrow_mut().push((pos, state, start, out.len())),
    // rust: );
    // rust: assert_same_vertices(&actual, &expected);
    // rust: assert_eq!(
    // rust: *before.borrow(),
    // rust: vec![(blocks[0].0, 0, 0), (blocks[1].0, 0, 8)]
    // rust: );
    // rust: assert_eq!(
    // rust: *after.borrow(),
    // rust: vec![(blocks[0].0, 0, 0, 8), (blocks[1].0, 0, 8, 16)]
    // rust: );
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 2);

    // The culler may discard the first entity before the next one is drawn.
    // The second callback must then see the compacted output's new start.
    // rust: let starts = RefCell::new(Vec::new());
    // rust: let ranges = RefCell::new(Vec::new());
    // rust: actual.clear();
    // rust: renderer.render_with_cache_options_and_callbacks(
    // rust: &scene,
    // rust: blocks.iter(),
    // rust: options,
    // rust: 0,
    // rust: None,
    // rust: &mut actual,
    // rust: |_, _, start| starts.borrow_mut().push(start),
    // rust: |pos, _, start, out| {
    // rust: ranges.borrow_mut().push((start, out.len()));
    // rust: if pos == blocks[0].0 {
    // rust: out.truncate(start);
}
    // rust: },
    // rust: );
    // rust: assert_eq!(*starts.borrow(), vec![0, 0]);
    // rust: assert_eq!(*ranges.borrow(), vec![(0, 8), (0, 8)]);
    // rust: let mut second_only = Vec::new();
    // rust: renderer.render(&scene, std::iter::once(&blocks[1]), &mut second_only);
    // rust: assert_same_vertices(&actual, &second_only);
}

static_cache_qualifies_local_positions_by_section_and_drops_old_entries :: proc() {
}
    // rust: let renderer = shulker_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprites("entity/shulker/shulker");
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let options = CacheOptions {
    // rust: shulker_boxes: true,
    // rust: ..Default::default()
}
    // rust: let same_local_index = [([0, 64, 0], 0), ([0, 80, 0], 0)];
    // rust: let mut both = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, same_local_index.iter(), options, &mut both);
    // rust: assert_same_vertices(&both, &render_direct(&renderer, &scene, &same_local_index));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 2);

    // rust: scene.game_time = SIGN_TEXT_KEEP + 1;
    // rust: let one = [same_local_index[0]];
    // rust: let mut retained = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, one.iter(), options, &mut retained);
    // rust: assert_same_vertices(&retained, &render_direct(&renderer, &scene, &one));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}

gpu_static_cache_uses_section_local_chests_and_keeps_visibility_separate :: proc() {
}
    // rust: let renderer = chest_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprites("entity/chest/normal");
    // rust: let opaque_sprites = HashSet::new();
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let openness = Cell::new(0.0);
    // rust: let lid = |pos: [i32; 3]| {
    // rust: if pos == [100, 70, -32] {
    // rust: openness.get()
    // rust: } else {
    // rust: 0.0
}
}
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::new(99.25, 70.5, -31.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &opaque_sprites,
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &lid,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([100, 70, -32], 0)];
    // rust: let other_block = [([116, 70, -32], 0)];
    // rust: let candidates = [blocks[0], other_block[0]];
    // rust: let first_section_membership_revision = Cell::new(1);
    // rust: let membership_revision = Cell::new(1);
    // rust: let options = CacheOptions {
    // rust: chests: true,
    // rust: ..Default::default()
}
    // rust: let render_static = |scene: &Scene,
    // rust: visible: &[([i32; 3], u32)],
    // rust: candidates: &[([i32; 3], u32)]| {
    // rust: let mut dynamic = Vec::new();
    // rust: let (static_sections, visible_sections, stats) = renderer.render_with_gpu_cache_options(
    // rust: scene,
    // rust: visible.iter(),
    // rust: candidates.iter(),
    // rust: options,
    // rust: membership_revision.get(),
    // rust: |pos| {
    // rust: Some(StaticSectionRevision {
    // rust: mesh: 1,
    // rust: block_entities: if pos[0] == 6 {
    // rust: first_section_membership_revision.get()
    // rust: } else {
    // rust: 1
    // rust: },
    // rust: })
    // rust: },
    // rust: &mut dynamic,
    // rust: );
    // rust: (dynamic, static_sections, visible_sections, stats)
}
    // rust: let (dynamic, first, first_visible, first_stats) = render_static(&scene, &blocks, &candidates);
    // rust: assert!(dynamic.is_empty());
    // rust: assert_eq!(first.len(), 2);
    // rust: assert_eq!(first_visible.len(), 1);
    // rust: assert_eq!(first_stats.snapshot_rebuilds, 2);
    // rust: let camera_relative = first[0]
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|vertex| Vertex {
    // rust: pos: std::array::from_fn(|i| {
    // rust: vertex.pos[i] + (f64::from(first[0].origin[i]) - scene.camera.to_array()[i]) as f32
    // rust: }),
    // rust: ..*vertex
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: assert_same_vertices(&camera_relative, &render_direct(&renderer, &scene, &blocks));

    // rust: let (_, same, _, same_stats) = render_static(&scene, &blocks, &candidates);
    // rust: assert!(Arc::ptr_eq(&same, &first));
    // rust: assert_eq!(same_stats.snapshot_rebuilds, 0);

    // Camera translation only updates a per-section transform uniform.
    // rust: scene.camera = DVec3::new(99.75, 70.9, -31.2);
    // rust: let (_, within_block, _, within_stats) = render_static(&scene, &blocks, &candidates);
    // rust: assert!(Arc::ptr_eq(&within_block, &first));
    // rust: assert_eq!(within_stats.snapshot_rebuilds, 0);

    // Crossing a block boundary does not rebuild section-local
    // vertex data. The transform remains camera-relative in f64.
    // rust: scene.camera.x += 1.0;
    // rust: let (_, moved, _, moved_stats) = render_static(&scene, &blocks, &candidates);
    // rust: assert!(Arc::ptr_eq(&moved, &first));
    // rust: assert_eq!(moved_stats.snapshot_rebuilds, 0);
    // rust: let camera_relative = moved[0]
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|vertex| Vertex {
    // rust: pos: std::array::from_fn(|i| {
    // rust: vertex.pos[i] + (f64::from(moved[0].origin[i]) - scene.camera.to_array()[i]) as f32
    // rust: }),
    // rust: ..*vertex
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: assert_same_vertices(&camera_relative, &render_direct(&renderer, &scene, &blocks));

    // Frustum changes only the visible section list, not the cached snapshot.
    // rust: let (_, hidden, hidden_visible, hidden_stats) = render_static(&scene, &[], &candidates);
    // rust: assert_eq!(hidden_visible.len(), 0);
    // rust: assert!(Arc::ptr_eq(&hidden, &first));
    // rust: assert_eq!(hidden_stats.snapshot_rebuilds, 0);

    // Turning to a different prewarmed section changes which buffer draws but
    // leaves both section snapshots untouched.
    // rust: let (_, rotated, rotated_visible, rotated_stats) =
    // rust: render_static(&scene, &other_block, &candidates);
    // rust: assert_eq!(rotated_visible.len(), 1);
    // rust: assert!(Arc::ptr_eq(&rotated, &first));
    // rust: assert_eq!(rotated_stats.snapshot_rebuilds, 0);

    // Removing the last block entity in one section invalidates only that
    // section, even though the next candidate scan has no entry for it.
    // rust: first_section_membership_revision.set(2);
    // rust: membership_revision.set(2);
    // rust: let (_, after_removal, remaining_visible, removal_stats) =
    // rust: render_static(&scene, &other_block, &other_block);
    // rust: assert_eq!(after_removal.len(), 1);
    // rust: assert_eq!(remaining_visible, rotated_visible);
    // rust: assert_eq!(removal_stats.snapshot_rebuilds, 0);
    // rust: openness.set(0.3);
    // rust: let (opening_dynamic, opening_static, opening_visible, opening_stats) =
    // rust: render_static(&scene, &blocks, &candidates);
    // rust: assert!(!opening_dynamic.is_empty());
    // rust: assert!(opening_visible.is_empty());
    // rust: assert_eq!(opening_static.len(), 1);
    // The opened chest's section had already been removed above. It stays on
    // the dynamic path, so opening it does not rebuild the remaining section.
    // rust: assert_eq!(opening_stats.snapshot_rebuilds, 0);
    // rust: assert_same_vertices(&opening_dynamic, &render_direct(&renderer, &scene, &blocks));

    // A resource reload invalidates cached UV geometry even when it reuses the
    // same atlas coordinates.
    // rust: scene.atlas_revision = 2;
    // rust: let (_, reloaded, _, reload_stats) = render_static(&scene, &blocks, &candidates);
    // rust: assert_eq!(reload_stats.snapshot_rebuilds, 1);
    // rust: assert!(!Arc::ptr_eq(&reloaded, &opening_static));

    // A resource-pack sprite with fractional alpha must use the ordinary
    // blended entity path instead of the no-blend cutout snapshot.
    // rust: let translucent_sprites = HashSet::from(["entity/chest/normal".to_owned()]);
    // rust: scene.translucent_sprites = &translucent_sprites;
    // rust: scene.atlas_revision = 3;
    // rust: let (translucent_dynamic, translucent_static, _, _) =
    // rust: render_static(&scene, &other_block, &candidates);
    // rust: assert!(!translucent_dynamic.is_empty());
    // rust: assert!(translucent_static.is_empty());
}

sign_text_cache_can_be_disabled_and_reenabled_without_changing_output :: proc() {
}
    // rust: let renderer = BlockEntityRenderer {
    // rust: kinds: vec![Kind::Sign {
    // rust: hanging: false,
    // rust: wall: false,
    // rust: angle: 0.0,
    // rust: }],
    // rust: ..Default::default()
}
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = HashMap::new();
    // rust: let data = SignData {
    // rust: front: SignText {
    // rust: lines: ["cached".into(), "text".into(), String::new(), String::new()],
    // rust: ..Default::default()
    // rust: },
    // rust: ..Default::default()
}
    // rust: let sign_data = &data;
    // rust: let sign = move |_: [i32; 3]| Some(sign_data);
    // rust: let glyph = |_: char| Glyph {
    // rust: rect: Some(Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 0.0625,
    // rust: v1: 0.0625,
    // rust: w: 8,
    // rust: h: 8,
    // rust: }),
    // rust: right: 8.0,
    // rust: bottom: 8.0,
    // rust: advance: 6.0,
    // rust: ..Glyph::default()
}
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &sign,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &glyph,
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([0, 64, 0], 0)];
    // rust: let enabled = CacheOptions {
    // rust: signs: true,
    // rust: ..Default::default()
}
    // rust: let disabled = CacheOptions::default();
    // rust: let mut cached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), enabled, &mut cached);
    // rust: assert_same_vertices(&cached, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(renderer.sign_texts.lock().unwrap().signs.len(), 1);

    // rust: let mut uncached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), disabled, &mut uncached);
    // rust: assert_same_vertices(&uncached, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(renderer.sign_texts.lock().unwrap().signs.len(), 0);

    // rust: let mut recached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), enabled, &mut recached);
    // rust: assert_same_vertices(&recached, &uncached);
    // rust: assert_eq!(renderer.sign_texts.lock().unwrap().signs.len(), 1);
}

shulker_cache_tracks_settled_poses_and_does_not_freeze_opening_animation :: proc() {
}
    // rust: let renderer = shulker_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprites("entity/shulker/shulker");
    // rust: let pose = Cell::new((0.0, 0.0));
    // rust: let anim = |_: [i32; 3]| BlockAnim {
    // rust: shulker: pose.get(),
    // rust: ..Default::default()
}
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.0, 64.0, -3.0),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([0, 64, 0], 0)];
    // rust: let options = CacheOptions {
    // rust: shulker_boxes: true,
    // rust: ..Default::default()
}
    // rust: let render_cached = |scene: &Scene| {
    // rust: let mut vertices = Vec::new();
    // rust: renderer.render_with_cache_options(scene, blocks.iter(), options, &mut vertices);
    // rust: vertices
}
    // rust: let render_uncached = |scene: &Scene| {
    // rust: let mut vertices = Vec::new();
    // rust: renderer.render(scene, blocks.iter(), &mut vertices);
    // rust: vertices
}

    // rust: let closed = render_cached(&scene);
    // rust: assert_same_vertices(&closed, &render_uncached(&scene));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: pose.set((0.25, 0.0));
    // rust: let opening_early = render_cached(&scene);
    // rust: assert_same_vertices(&opening_early, &render_uncached(&scene));
    // rust: pose.set((0.75, 0.0));
    // rust: let opening_late = render_cached(&scene);
    // rust: assert_vertices_move(&closed, &opening_early);
    // rust: assert_vertices_move(&opening_early, &opening_late);
    // rust: assert_same_vertices(&opening_late, &render_uncached(&scene));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 0);

    // rust: pose.set((1.0, 1.0));
    // rust: let open = render_cached(&scene);
    // rust: assert_vertices_move(&opening_late, &open);
    // rust: assert_same_vertices(&open, &render_uncached(&scene));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
    // rust: assert_same_vertices(&open, &render_cached(&scene));
}

shulker_cache_covers_all_colors_and_facing_directions :: proc() {
}
    // rust: let colors = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];
    // rust: let facings = ["up", "down", "north", "south", "west", "east"];
    // rust: let kinds = colors
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(index, color)| {
    // rust: let name = format!("minecraft:{color}_shulker_box");
    // rust: let facing = facings[index % facings.len()];
    // rust: classify(&name, &|property| {
    // rust: (property == "facing").then(|| facing.to_owned())
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut renderer = shulker_renderer();
    // rust: renderer.kinds = kinds;
    // rust: let textures: Vec<_> = colors
    // rust: .iter()
    // rust: .map(|color| format!("entity/shulker/shulker_{color}"))
    // rust: .collect();
    // rust: let texture_refs: Vec<_> = textures.iter().map(String::as_str).collect();
    // rust: let sprites = sprite_atlas(&texture_refs);
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let options = CacheOptions {
    // rust: shulker_boxes: true,
    // rust: ..Default::default()
}
    // rust: let pos = [0, 64, 0];
    // rust: let mut previous: Option<Vec<Vertex>> = None;
    // rust: for state in 0..colors.len() as u32 {
    // rust: let blocks = [(pos, state)];
    // rust: let mut cached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), options, &mut cached);
    // rust: assert_same_vertices(&cached, &render_direct(&renderer, &scene, &blocks));
    // rust: let sprite = sprites.get(&textures[state as usize]).unwrap();
    // rust: assert_eq!(cached[0].uv, [sprite.u0, sprite.v0]);
    // rust: if let Some(previous) = &previous {
    // rust: assert_vertices_differ(previous, &cached);
}
    // rust: previous = Some(cached);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}
}

cached_bells_keep_shaking_until_the_animation_ends :: proc() {
}
    // rust: let renderer = bell_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprites("entity/bell/bell_body");
    // rust: let ticks = Cell::new(2);
    // rust: let shaking = Cell::new(true);
    // rust: let anim = |_: [i32; 3]| BlockAnim {
    // rust: bell_ticks: ticks.get(),
    // rust: bell_shake: shaking.get().then_some("north"),
    // rust: ..Default::default()
}
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.0, 64.0, -3.0),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 0.25,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([0, 64, 0], 0)];
    // rust: let options = CacheOptions {
    // rust: bells: true,
    // rust: ..Default::default()
}
    // rust: let render = || {
    // rust: let mut vertices = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), options, &mut vertices);
    // rust: vertices
}

    // rust: let first_shake = render();
    // rust: ticks.set(7);
    // rust: let second_shake = render();
    // rust: assert_vertices_move(&first_shake, &second_shake);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 0);
    // rust: assert_same_vertices(&second_shake, &{
    // rust: let mut expected = Vec::new();
    // rust: renderer.render(&scene, blocks.iter(), &mut expected);
    // rust: expected
    // rust: });

    // rust: shaking.set(false);
    // rust: let settled = render();
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
    // rust: shaking.set(true);
    // rust: ticks.set(11);
    // rust: let resumed_shake = render();
    // rust: assert_vertices_move(&settled, &resumed_shake);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 0);
}

cached_closed_chests_match_the_direct_model_and_rebuild_when_opening :: proc() {
}
    // rust: let renderer = chest_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprite_atlas(&["entity/chest/normal"]);
    // rust: let opening = Cell::new(0.0);
    // rust: let lid = |_: [i32; 3]| opening.get();
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &lid,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([0, 64, 0], 0)];
    // rust: let options = CacheOptions {
    // rust: chests: true,
    // rust: ..Default::default()
}
    // rust: let render_cached = |scene: &Scene| {
    // rust: let mut vertices = Vec::new();
    // rust: renderer.render_with_cache_options(scene, blocks.iter(), options, &mut vertices);
    // rust: vertices
}

    // rust: let closed = render_cached(&scene);
    // rust: assert_same_vertices(&closed, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
    // rust: assert_same_vertices(&closed, &render_cached(&scene));

    // rust: opening.set(0.65);
    // rust: let opening_frame = render_cached(&scene);
    // rust: assert_same_vertices(&opening_frame, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_vertices_move(&closed, &opening_frame);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 0);

    // rust: opening.set(0.0);
    // rust: let closed_again = render_cached(&scene);
    // rust: assert_same_vertices(&closed_again, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
    // rust: scene.nether = true;
    // rust: let nether_closed = render_cached(&scene);
    // rust: assert_same_vertices(&nether_closed, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_vertices_differ(&closed_again, &nether_closed);
}

closed_chest_cache_covers_all_materials_and_atlas_reloads :: proc() {
}
    // rust: let variants = [
    // rust: ("minecraft:chest", "entity/chest/normal"),
    // rust: ("minecraft:trapped_chest", "entity/chest/trapped"),
    // rust: ("minecraft:ender_chest", "entity/chest/ender"),
    // rust: ("minecraft:copper_chest", "entity/chest/copper"),
    // rust: (
    // rust: "minecraft:exposed_copper_chest",
    // rust: "entity/chest/copper_exposed",
    // rust: ),
    // rust: (
    // rust: "minecraft:weathered_copper_chest",
    // rust: "entity/chest/copper_weathered",
    // rust: ),
    // rust: (
    // rust: "minecraft:oxidized_copper_chest",
    // rust: "entity/chest/copper_oxidized",
    // rust: ),
    // rust: ("minecraft:waxed_copper_chest", "entity/chest/copper"),
    // rust: (
    // rust: "minecraft:waxed_exposed_copper_chest",
    // rust: "entity/chest/copper_exposed",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_weathered_copper_chest",
    // rust: "entity/chest/copper_weathered",
    // rust: ),
    // rust: (
    // rust: "minecraft:waxed_oxidized_copper_chest",
    // rust: "entity/chest/copper_oxidized",
    // rust: ),
    // rust: ];
    // rust: let kinds = variants
    // rust: .iter()
    // rust: .map(|(name, _)| classified_chest(name, "east", "single"))
    // rust: .collect();
    // rust: let renderer = chest_renderer_with(kinds);
    // rust: let textures: Vec<_> = variants.iter().map(|(_, texture)| *texture).collect();
    // rust: let sprites = sprite_atlas(&textures);
    // rust: let world = World::new(BlockStateId(99), 1);
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let pos = [0, 64, 0];
    // rust: let options = CacheOptions {
    // rust: chests: true,
    // rust: ..Default::default()
}
    // rust: let mut previous_texture = None;
    // rust: let mut previous_uv = None;
    // rust: for (state, (_, texture)) in variants.iter().enumerate() {
    // rust: let blocks = [(pos, state as u32)];
    // rust: let mut cached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), options, &mut cached);
    // rust: assert_same_vertices(&cached, &render_direct(&renderer, &scene, &blocks));
    // rust: let sprite = sprites.get(*texture).unwrap();
    // rust: assert_eq!(cached[0].uv, [sprite.u0, sprite.v0]);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
    // rust: if previous_texture != Some(*texture) {
    // rust: assert_ne!(previous_uv, Some(cached[0].uv));
}
    // rust: previous_texture = Some(*texture);
    // rust: previous_uv = Some(cached[0].uv);
}

    // A resource reload may move the same sprite without changing block state.
    // Cached UVs must follow the new atlas rectangle.
    // rust: let changed = HashMap::from([(
    // rust: "entity/chest/copper_oxidized".to_owned(),
    // rust: Rect {
    // rust: u0: 0.75,
    // rust: v0: 0.5,
    // rust: u1: 1.0,
    // rust: v1: 0.75,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: )]);
    // rust: let state = variants.len() as u32 - 1;
    // rust: let blocks = [(pos, state)];
    // rust: let old_uv = previous_uv.unwrap();
    // rust: scene.sprites = &changed;
    // rust: let mut after_reload = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), options, &mut after_reload);
    // rust: assert_same_vertices(&after_reload, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(after_reload[0].uv, [0.75, 0.5]);
    // rust: assert_ne!(old_uv, after_reload[0].uv);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}

double_chest_cache_bypasses_both_halves_while_either_lid_is_open :: proc() {
}
    // rust: let renderer = chest_renderer_with(vec![
    // rust: classified_chest("minecraft:chest", "north", "left"),
    // rust: classified_chest("minecraft:chest", "north", "right"),
    // rust: classified_chest("minecraft:trapped_chest", "north", "right"),
    // rust: classified_chest("minecraft:chest", "south", "right"),
    // rust: ]);
    // rust: let mut world = World::new(BlockStateId(99), 1);
    // rust: world.chunks.insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: world.set(0, 64, 0, BlockStateId(0)).unwrap();
    // rust: world.set(1, 64, 0, BlockStateId(1)).unwrap();
    // rust: let sprites = sprite_atlas(&[
    // rust: "entity/chest/normal_left",
    // rust: "entity/chest/normal_right",
    // rust: "entity/chest/trapped_right",
    // rust: ]);
    // rust: let openings = Cell::new([0.0, 0.0]);
    // rust: let lid = |pos: [i32; 3]| openings.get()[usize::from(pos[0] != 0)];
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &lid,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let pair = [([0, 64, 0], 0), ([1, 64, 0], 1)];
    // rust: let options = CacheOptions {
    // rust: chests: true,
    // rust: ..Default::default()
}
    // rust: let mut closed = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, pair.iter(), options, &mut closed);
    // rust: assert_same_vertices(&closed, &render_direct(&renderer, &scene, &pair));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 2);

    // rust: openings.set([0.0, 0.6]);
    // rust: let left = [pair[0]];
    // rust: let mut opening_neighbor = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, left.iter(), options, &mut opening_neighbor);
    // rust: assert_same_vertices(&opening_neighbor, &render_direct(&renderer, &scene, &left));
    // rust: assert_vertices_move(&closed[..24], &opening_neighbor);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: openings.set([0.0, 0.0]);
    // rust: let mut closed_again = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, pair.iter(), options, &mut closed_again);
    // rust: assert_same_vertices(&closed_again, &render_direct(&renderer, &scene, &pair));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 2);

    // rust: let left_kind = renderer.chest_openness_of(
    // rust: pair[0].0,
    // rust: pair[0].1,
    // rust: &|pos| if pos[0] == 1 { 2 } else { 99 },
    // rust: &|pos| if pos[0] == 0 { 0.0 } else { 0.8 },
    // rust: );
    // rust: assert_eq!(left_kind, (0.0, None), "a trapped chest is not its partner");
    // rust: let wrong_facing = renderer.chest_openness_of(
    // rust: pair[0].0,
    // rust: pair[0].1,
    // rust: &|pos| if pos[0] == 1 { 3 } else { 99 },
    // rust: &|pos| if pos[0] == 0 { 0.0 } else { 0.8 },
    // rust: );
    // rust: assert_eq!(wrong_facing, (0.0, None), "mismatched facings do not pair");
}

decorated_pot_cache_tracks_sherds_and_bypasses_wobble_animation :: proc() {
}
    // rust: let renderer = decorated_pot_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprite_atlas(&[
    // rust: "entity/decorated_pot/decorated_pot_base",
    // rust: "entity/decorated_pot/decorated_pot_side",
    // rust: "entity/decorated_pot/back_pattern",
    // rust: "entity/decorated_pot/left_pattern",
    // rust: "entity/decorated_pot/right_pattern",
    // rust: "entity/decorated_pot/front_pattern",
    // rust: ]);
    // rust: let animation = RefCell::new(BlockAnim::default());
    // rust: let anim = |_: [i32; 3]| animation.borrow().clone();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([0, 64, 0], 0)];
    // rust: let options = CacheOptions {
    // rust: decorated_pots: true,
    // rust: ..Default::default()
}
    // rust: let render_cached = || {
    // rust: let mut vertices = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), options, &mut vertices);
    // rust: vertices
}

    // rust: let plain = render_cached();
    // rust: assert_same_vertices(&plain, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: animation.borrow_mut().sherds = [
    // rust: Some("back_pattern".into()),
    // rust: Some("left_pattern".into()),
    // rust: Some("right_pattern".into()),
    // rust: Some("front_pattern".into()),
    // rust: ];
    // rust: let patterned = render_cached();
    // rust: assert_same_vertices(&patterned, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_vertices_differ(&plain, &patterned);
    // rust: for (side, pattern) in ["back", "left", "right", "front"].iter().enumerate() {
    // rust: let sprite = sprites
    // rust: .get(&format!("entity/decorated_pot/{pattern}_pattern"))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: patterned[(side + 1) * 4].uv,
    // rust: [sprite.u0, sprite.v0],
    // rust: "the {pattern} sherd uses its own sprite"
    // rust: );
    // rust: assert_ne!(plain[(side + 1) * 4].uv, patterned[(side + 1) * 4].uv);
}
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: animation.borrow_mut().wobble = Some((true, 0.5));
    // rust: let wobbling = render_cached();
    // rust: assert_same_vertices(&wobbling, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_vertices_move(&patterned, &wobbling);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 0);
}

banner_cache_keeps_the_pole_static_while_the_flag_and_patterns_update :: proc() {
}
    // rust: let renderer = banner_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprite_atlas(&[
    // rust: "entity/banner/banner_base",
    // rust: "entity/banner/base",
    // rust: "entity/banner/pattern",
    // rust: "entity/banner/alternate_pattern",
    // rust: ]);
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let patterns = RefCell::new(vec![("entity/banner/pattern".to_owned(), 0x123456)]);
    // rust: let banner_patterns = |_: [i32; 3]| patterns.borrow().clone();
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &banner_patterns,
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let blocks = [([0, 64, 0], 0)];
    // rust: let options = CacheOptions {
    // rust: banners: true,
    // rust: ..Default::default()
}
    // rust: let render_cached = |scene: &Scene| {
    // rust: let mut vertices = Vec::new();
    // rust: renderer.render_with_cache_options(scene, blocks.iter(), options, &mut vertices);
    // rust: vertices
}

    // rust: let first = render_cached(&scene);
    // rust: assert_eq!(
    // rust: first.len(),
    // rust: 16,
    // rust: "pole, flag, base pattern, and overlay pattern"
    // rust: );
    // rust: assert_same_vertices(&first, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: scene.game_time = 25;
    // rust: let next_frame = render_cached(&scene);
    // rust: assert_same_vertices(&next_frame, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_same_vertices(&first[..4], &next_frame[..4]);
    // rust: let first_pattern = sprites.get("entity/banner/pattern").unwrap();
    // rust: assert_eq!(next_frame[12].uv, [first_pattern.u0, first_pattern.v0]);
    // rust: assert_vertices_move(&first[4..], &next_frame[4..]);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: patterns.borrow_mut()[0] = ("entity/banner/alternate_pattern".to_owned(), 0xABCDEF);
    // rust: let new_pattern = render_cached(&scene);
    // rust: assert_same_vertices(&new_pattern, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_same_vertices(&next_frame[..4], &new_pattern[..4]);
    // rust: let alternate = sprites.get("entity/banner/alternate_pattern").unwrap();
    // rust: assert_eq!(new_pattern[12].uv, [alternate.u0, alternate.v0]);
    // rust: assert_vertices_differ(&next_frame[4..], &new_pattern[4..]);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}

cached_wall_banner_poles_use_the_wall_model :: proc() {
}
    // rust: let renderer = banner_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprite_atlas(&["entity/banner/banner_base", "entity/banner/base"]);
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let pos = [0, 64, 0];
    // rust: let options = CacheOptions {
    // rust: banners: true,
    // rust: ..Default::default()
}
    // rust: let standing = [(pos, 0)];
    // rust: let wall = [(pos, 1)];
    // rust: let mut cached_standing = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, standing.iter(), options, &mut cached_standing);
    // rust: assert_same_vertices(
    // rust: &cached_standing,
    // rust: &render_direct(&renderer, &scene, &standing),
    // rust: );
    // rust: let mut cached_wall = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, wall.iter(), options, &mut cached_wall);
    // rust: assert_same_vertices(&cached_wall, &render_direct(&renderer, &scene, &wall));
    // rust: assert_vertices_differ(&cached_standing[..4], &cached_wall[..4]);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}

copper_statue_cache_rebuilds_when_its_pose_state_changes :: proc() {
}
    // rust: let renderer = copper_statue_renderer();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = sprite_atlas(&["entity/copper_golem/copper_golem"]);
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let options = CacheOptions {
    // rust: copper_golem_statues: true,
    // rust: ..Default::default()
}
    // rust: let standing = [([0, 64, 0], 0)];
    // rust: let sitting = [([0, 64, 0], 1)];
    // rust: let mut cached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, standing.iter(), options, &mut cached);
    // rust: assert_same_vertices(&cached, &render_direct(&renderer, &scene, &standing));
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);

    // rust: cached.clear();
    // rust: renderer.render_with_cache_options(&scene, sitting.iter(), options, &mut cached);
    // rust: assert_same_vertices(&cached, &render_direct(&renderer, &scene, &sitting));
    // rust: assert_eq!(cached.len(), 8, "the sitting model has two fixture quads");
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}

copper_statue_cache_covers_weathering_waxing_and_all_poses :: proc() {
}
    // rust: let variants = [
    // rust: ("copper_golem_statue", "entity/copper_golem/copper_golem"),
    // rust: (
    // rust: "exposed_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_exposed",
    // rust: ),
    // rust: (
    // rust: "weathered_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_weathered",
    // rust: ),
    // rust: (
    // rust: "oxidized_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_oxidized",
    // rust: ),
    // rust: (
    // rust: "waxed_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem",
    // rust: ),
    // rust: (
    // rust: "waxed_exposed_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_exposed",
    // rust: ),
    // rust: (
    // rust: "waxed_weathered_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_weathered",
    // rust: ),
    // rust: (
    // rust: "waxed_oxidized_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_oxidized",
    // rust: ),
    // rust: ];
    // rust: let poses = ["standing", "running", "sitting", "star"];
    // rust: let kinds = variants
    // rust: .iter()
    // rust: .flat_map(|(name, _)| {
    // rust: poses.iter().map(move |pose| {
    // rust: let name = format!("minecraft:{name}");
    // rust: classify(&name, &|property| match property {
    // rust: "facing" => Some("east".into()),
    // rust: "copper_golem_pose" => Some((*pose).into()),
    // rust: _ => None,
    // rust: })
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let model = |copies| ModelPart {
    // rust: pose: unit_pose(),
    // rust: polygons: vec![quad(); copies],
    // rust: children: Vec::new(),
}
    // rust: let renderer = renderer_with_shapes(
    // rust: HashMap::from([
    // rust: ("copper_golem", model(1)),
    // rust: ("copper_golem_running", model(2)),
    // rust: ("copper_golem_sitting", model(3)),
    // rust: ("copper_golem_star", model(4)),
    // rust: ]),
    // rust: kinds,
    // rust: HashMap::new(),
    // rust: );
    // rust: let texture_strings: Vec<_> = variants.iter().map(|(_, texture)| *texture).collect();
    // rust: let sprites = sprite_atlas(&texture_strings);
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let anim = |_: [i32; 3]| BlockAnim::default();
    // rust: let scene = Scene {
    // rust: camera: DVec3::new(2.25, 64.5, -3.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &anim,
    // rust: texts: None,
    // rust: partial: 1.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let options = CacheOptions {
    // rust: copper_golem_statues: true,
    // rust: ..Default::default()
}
    // rust: let pos = [0, 64, 0];
    // rust: let mut previous_texture = None;
    // rust: let mut previous_uv = None;
    // rust: for (variant, (_, texture)) in variants.iter().enumerate() {
    // rust: for (pose, _) in poses.iter().enumerate() {
    // rust: let state = (variant * poses.len() + pose) as u32;
    // rust: let blocks = [(pos, state)];
    // rust: let mut cached = Vec::new();
    // rust: renderer.render_with_cache_options(&scene, blocks.iter(), options, &mut cached);
    // rust: assert_same_vertices(&cached, &render_direct(&renderer, &scene, &blocks));
    // rust: assert_eq!(cached.len(), 4 * (pose + 1));
    // rust: let sprite = sprites.get(*texture).unwrap();
    // rust: assert_eq!(cached[0].uv, [sprite.u0, sprite.v0]);
    // rust: if previous_texture != Some(*texture) {
    // rust: assert_ne!(previous_uv, Some(cached[0].uv));
}
    // rust: previous_texture = Some(*texture);
    // rust: previous_uv = Some(cached[0].uv);
    // rust: assert_eq!(renderer.static_geometry.lock().unwrap().len, 1);
}
}
}
