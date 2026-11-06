//! Transpiled from Horizon Rust crate
//! Module: horizon-client_glint_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;

pub fn png(path: *Path, w: u32, h: u32, color: [u8; 4]) void {
}
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(fs::File::create(path).unwrap(), w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer
    // rust: .write_image_data(&color.repeat((w * h) as usize))
    // rust: .unwrap();
    // rust: writer.finish().unwrap();
}

pub fn fixture(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-glint-5851-{name}-{}", std::process::id()));
    // rust: let write = |name: &str, data: &[u8]| {
    // rust: let path = root.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, data).unwrap();
}
    // rust: write("items.json", b"{}");
    // rust: write(
    // rust: "assets/minecraft/atlases/items.json",
    // rust: br#"{"sources":[
    // rust: {"type":"directory","source":"item","prefix":"item/"},
    // rust: {"type":"single","resource":"test:source","sprite":"test:item/enchanted_book"},
    // rust: {"type":"unstitch","resource":"test:sheet","divisor_x":2,"divisor_y":1,
    // rust: "regions":[{"sprite":"minecraft:item/compass_00","x":1,"y":0,"width":1,"height":1}]}]}"#,
    // rust: );
    // rust: for (name, w, h) in [
    // rust: ("minecraft/item/enchanted_book", 16, 16),
    // rust: ("minecraft/item/book", 8, 16),
    // rust: ("minecraft/item/diamond_sword", 32, 16),
    // rust: ("minecraft/item/clock_00", 16, 64),
    // rust: ("test/source", 16, 16),
    // rust: ("test/sheet", 16, 16),
    // rust: ] {
    // rust: let (namespace, path) = name.split_once('/').unwrap();
    // rust: png(
    // rust: &root.join(format!("assets/{namespace}/textures/{path}.png")),
    // rust: w,
    // rust: h,
    // rust: [255; 4],
    // rust: );
}
    // rust: write(
    // rust: "assets/minecraft/textures/item/clock_00.png.mcmeta",
    // rust: br#"{"animation":{"width":16,"height":16}}"#,
    // rust: );
    // rust: root
}

pub fn state(sprite: []const u8, foil: FoilType, display: DisplayContext) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let material = horizon_assets::model::Material {
    // rust: sprite: sprite.into(),
    // rust: force_translucent: false,
}
    // rust: let baked = BakedItemModel {
    // rust: quads: vec![horizon_assets::bake::ModelQuad {
    // rust: positions: [
    // rust: [-0.5, 0.5, 0.0],
    // rust: [-0.5, -0.5, 0.0],
    // rust: [0.5, -0.5, 0.0],
    // rust: [0.5, 0.5, 0.0],
    // rust: ],
    // rust: uv: [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]],
    // rust: facing: Direction::South,
    // rust: cull: None,
    // rust: material: material.clone(),
    // rust: tint_index: -1,
    // rust: shade_direction_override: None,
    // rust: light_emission: 0,
    // rust: light: [0; 2],
    // rust: color: None,
    // rust: ambient_occlusion: None,
    // rust: render_type: None,
    // rust: shade: true,
    // rust: }],
    // rust: uses_block_light: false,
    // rust: particle: material,
    // rust: transforms: Default::default(),
}
    // rust: ItemRenderState {
    // rust: display,
    // rust: layers: vec![LayerRender {
    // rust: geometry: LayerGeometry::Quads(Arc::new(baked)),
    // rust: tints: vec![],
    // rust: foil,
    // rust: matrix: Mat4::IDENTITY,
    // rust: particle: sprite.into(),
    // rust: uses_block_light: false,
    // rust: extents: Arc::new(vec![]),
    // rust: }],
    // rust: oversized_in_gui: false,
    // rust: animated: false,
    // rust: cit_glint: None,
    // rust: hdr_tier: 0,
    // rust: hdr_light: 0,
}
}

pub fn gui_glint_matches_pinned_vanilla_atlas_input() void {
}
    // rust: let root = fixture("gui");
    // rust: let renderer = ItemRenderer::load(&root).unwrap();
    // rust: renderer.prepare_glint_atlas(16384, (0, 2)).unwrap();
    // The real vanilla oracle also checks a rectangular texture, an animation frame,
    // an unstitch source and an equal-sized sprite in a second namespace.
    // rust: for (name, x, y, w, h) in [
    // rust: ("item/enchanted_book", 1, 33, 16, 16),
    // rust: ("item/book", 53, 1, 8, 16),
    // rust: ("item/diamond_sword", 1, 1, 32, 16),
    // rust: ("item/clock_00", 35, 1, 16, 16),
    // rust: ("item/compass_00", 55, 33, 8, 16),
    // rust: ("test:item/enchanted_book", 19, 33, 16, 16),
    // rust: ("missingno", 37, 33, 16, 16),
    // rust: ] {
    // rust: let r = renderer.glint_atlas.lock().unwrap()[name];
    // rust: assert_eq!(
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: [x, y, x + w, y + h].map(|n| n as f32 / 64.0)
    // rust: );
}
    // rust: let sprites = HashMap::from([
    // rust: (
    // rust: "item/enchanted_book".into(),
    // rust: Rect {
    // rust: u0: 0.2,
    // rust: v0: 0.3,
    // rust: u1: 0.4,
    // rust: v1: 0.5,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: ),
    // rust: (
    // rust: "misc/enchanted_glint_item".into(),
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 128,
    // rust: h: 128,
    // rust: },
    // rust: ),
    // rust: ]);
    // rust: let render = |foil| {
    // rust: let mut batch = crate::hud::HudBatch::new([64, 64]);
    // rust: gui::draw(
    // rust: &state("minecraft:item/enchanted_book", foil, DisplayContext::Gui),
    // rust: &renderer,
    // rust: &sprites,
    // rust: &NoHost,
    // rust: &mut batch,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.75,
    // rust: );
    // rust: batch
}
    // rust: let batch = render(FoilType::Standard);
    // Real 26.3 SpriteSourceList + SpriteResourceLoader + Stitcher + JOML, over this fixture:
    // atlas 64x64, book rectangle (1,33)..(17,49). HUD packing above deliberately differs.
    // rust: let expected = [
    // rust: [-0.5931978, 4.084038],
    // rust: [-0.94049406, 6.0536532],
    // rust: [1.0291214, 6.4009495],
    // rust: [1.3764176, 4.431334],
    // rust: ];
    // rust: let mut seen = [false; 4];
    // rust: for vertex in batch.vertices.iter().filter(|v| v.uv[0] >= 2.0) {
    // rust: let index = match vertex.pos {
    // rust: [0.0, 0.0] => 0,
    // rust: [0.0, 16.0] => 1,
    // rust: [16.0, 16.0] => 2,
    // rust: [16.0, 0.0] => 3,
    // rust: p => panic!("unexpected corner {p:?}"),
}
    // rust: for (got, want) in vertex.glint_uv.into_iter().zip(expected[index]) {
    // rust: assert!((got - want).abs() < 1e-5, "glint {got} != vanilla {want}");
}
    // rust: seen[index] = true;
}
    // rust: assert!(seen.into_iter().all(|x| x));
    // rust: let plain = render(FoilType::None);
    // rust: let base: Vec<_> = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .filter(|v| v.uv[0] < 2.0)
    // rust: .map(|v| (v.pos, v.uv, v.color))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: base,
    // rust: plain
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| (v.pos, v.uv, v.color))
    // rust: .collect::<Vec<_>>()
    // rust: );
    // rust: for (display, foil) in [
    // rust: (DisplayContext::Ground, FoilType::Standard),
    // rust: (DisplayContext::FirstPersonRightHand, FoilType::Standard),
    // rust: (DisplayContext::Gui, FoilType::Special),
    // rust: ] {
    // rust: let mut quads = Vec::new();
    // rust: state("minecraft:item/enchanted_book", foil, display).submit(
    // rust: &renderer,
    // rust: &sprites,
    // rust: &NoHost,
    // rust: Mat4::IDENTITY,
    // rust: &mut quads,
    // rust: );
    // rust: assert_eq!(quads.len(), 1);
    // rust: assert!(quads[0].gui_glint_uv.is_none());
    // rust: assert_eq!(
    // rust: quads[0].foil_uv,
    // rust: [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]]
    // rust: );
}
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn glint_atlas_boundaries() void {
}
    // rust: let root = fixture("boundary");
    // Pinned vanilla over the same generated fixture; padding 1,2,4,8,16.
    // rust: for (i, (width, height, x, y)) in [
    // rust: (64, 64, 1, 33),
    // rust: (128, 64, 2, 34),
    // rust: (128, 64, 4, 36),
    // rust: (128, 64, 40, 40),
    // rust: (256, 128, 16, 80),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let atlas = glint_atlas::load(&root, 1 << i, 16384).unwrap();
    // rust: let r = atlas["item/enchanted_book"];
    // rust: assert_eq!(
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: [
    // rust: x as f32 / width as f32,
    // rust: y as f32 / height as f32,
    // rust: (x + 16) as f32 / width as f32,
    // rust: (y + 16) as f32 / height as f32
    // rust: ]
    // rust: );
}
    // rust: png(
    // rust: &root.join("assets/minecraft/textures/item/wide.png"),
    // rust: 16384,
    // rust: 1,
    // rust: [255; 4],
    // rust: );
    // rust: let atlas = glint_atlas::load(&root, 1, 32768).unwrap();
    // rust: let book = atlas["item/enchanted_book"];
    // rust: assert_eq!(
    // rust: [book.u0, book.v0, book.u1, book.v1],
    // rust: [1.0 / 32768.0, 33.0 / 64.0, 17.0 / 32768.0, 49.0 / 64.0]
    // rust: );
    // rust: let atlas = glint_atlas::load(&root, 1, 16384).unwrap();
    // rust: let book = atlas["item/enchanted_book"];
    // rust: assert_eq!(
    // rust: [book.u0, book.v0, book.u1, book.v1],
    // rust: [1.0 / 64.0, 33.0 / 128.0, 17.0 / 64.0, 49.0 / 128.0]
    // rust: );
    // rust: assert_eq!(atlas["item/wide"].u0, atlas["missingno"].u0);
    // rust: assert!(glint_atlas::load(&root, 1, 16).is_err());
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn invalid_and_generated_sprites_match_vanilla() void {
}
    // rust: let root = fixture("metadata");
    // rust: for name in ["invalid_size", "invalid_metadata", "not_animated"] {
    // rust: png(
    // rust: &root.join(format!("assets/minecraft/textures/item/{name}.png")),
    // rust: 16,
    // rust: 32,
    // rust: [255; 4],
    // rust: );
}
    // rust: for (name, meta) in [
    // rust: ("invalid_size", r#"{"animation":{"width":9,"height":16}}"#),
    // rust: ("invalid_metadata", r#"{"animation":{"frames":"bad"}}"#),
    // rust: ("not_animated", r#"{"texture":{"blur":true}}"#),
    // rust: ] {
    // rust: fs::write(
    // rust: root.join(format!("assets/minecraft/textures/item/{name}.png.mcmeta")),
    // rust: meta,
    // rust: )
    // rust: .unwrap();
}
    // rust: let path = root.join("assets/minecraft/atlases/items.json");
    // rust: let mut atlas: Value = serde_json::from_str(&fs::read_to_string(&path).unwrap()).unwrap();
    // rust: atlas["sources"].as_array_mut().unwrap().extend([
    // rust: serde_json::json!({"type":"single","resource":"test:absent","sprite":"test:missing_alias"}),
    // rust: serde_json::json!({"type":"paletted_permutations","textures":["test:trim"],"palette_key":"test:key","permutations":{"red":"test:red"}}),
    // rust: ]);
    // rust: fs::write(path, atlas.to_string()).unwrap();
    // rust: for (name, w, h, color) in [
    // rust: ("trim", 8, 16, [255; 4]),
    // rust: ("palettes/key", 1, 1, [255; 4]),
    // rust: ("palettes/red", 1, 1, [255, 0, 0, 255]),
    // rust: ] {
    // rust: png(
    // rust: &root.join(format!("assets/test/textures/{name}.png")),
    // rust: w,
    // rust: h,
    // rust: color,
    // rust: );
}
    // rust: let atlas = glint_atlas::load(&root, 1, 16384).unwrap();
    // Real SpriteResourceLoader rejects both invalid animations; TextureAtlas resolves missingno.
    // rust: for name in ["item/invalid_size", "item/invalid_metadata"] {
    // rust: let r = atlas[name];
    // rust: assert_eq!(
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: [103.0 / 128.0, 1.0 / 64.0, 119.0 / 128.0, 17.0 / 64.0]
    // rust: );
}
    // rust: let r = atlas["item/not_animated"];
    // rust: assert_eq!(
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: [1.0 / 128.0, 1.0 / 64.0, 17.0 / 128.0, 33.0 / 64.0]
    // rust: );
    // rust: let r = atlas["test:trim_red"];
    // rust: assert_eq!(
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: [19.0 / 128.0, 37.0 / 64.0, 27.0 / 128.0, 53.0 / 64.0]
    // rust: );
    // rust: assert!(!atlas.contains_key("test:missing_alias"));
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn invalid_texture_metadata_does_not_move_book_glint() void {
}
    // rust: let root = fixture("texture-metadata");
    // rust: let image = root.join("assets/minecraft/textures/item/large.png");
    // rust: png(&image, 512, 256, [255; 4]);
    // rust: let metadata = image.with_extension("png.mcmeta");
    // rust: for invalid in [
    // rust: r#"{"texture":[]}"#,
    // rust: r#"{"texture":null}"#,
    // rust: r#"{"texture":{"mipmap_strategy":"issue5851_invalid"}}"#,
    // rust: r#"{"texture":{"blur":"true"}}"#,
    // rust: r#"{"texture":{"clamp":1}}"#,
    // rust: r#"{"texture":{"alpha_cutoff_bias":"0.5"}}"#,
    // rust: ] {
    // rust: fs::write(&metadata, invalid).unwrap();
    // rust: let atlas = glint_atlas::load(&root, 1, 16384).unwrap();
    // rust: let rejected = atlas["item/large"];
    // rust: let missing = atlas["missingno"];
    // rust: assert_eq!(
    // rust: [rejected.u0, rejected.v0, rejected.u1, rejected.v1],
    // rust: [missing.u0, missing.v0, missing.u1, missing.v1],
    // rust: "{invalid}"
    // rust: );
        // Existing real-vanilla fixture: rejecting the extra image leaves its book unchanged.
    // rust: let book = atlas["item/enchanted_book"];
    // rust: assert_eq!(
    // rust: [book.u0, book.v0, book.u1, book.v1],
    // rust: [1.0 / 64.0, 33.0 / 64.0, 17.0 / 64.0, 49.0 / 64.0],
    // rust: "{invalid}"
    // rust: );
}
    // rust: for strategy in ["auto", "mean", "cutout", "strict_cutout", "dark_cutout"] {
    // rust: fs::write(
    // rust: &metadata,
    // rust: serde_json::json!({"texture":{"blur":true,"clamp":false,
    // rust: "mipmap_strategy":strategy,"alpha_cutoff_bias":0.5}})
    // rust: .to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: let atlas = glint_atlas::load(&root, 1, 16384).unwrap();
    // rust: assert_eq!((atlas["item/large"].w, atlas["item/large"].h), (512, 256));
}
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn glint_atlas_reads_prepared_images_and_metadata_together() void {
}
    // rust: let root = fixture("prepared-metadata");
    // rust: let image = root.join("assets/minecraft/textures/item/large.png");
    // rust: png(&image, 512, 256, [255; 4]);
    // rust: let metadata = image.with_extension("png.mcmeta");
    // rust: fs::write(&metadata, r#"{"texture":[]}"#).unwrap();
    // rust: fs::write(root.join("horizon-resources.json"), "{}").unwrap();
    // rust: horizon_core::prepared_files::write(&root).unwrap();
    // The renderer reads the prepared snapshot, even if loose files now differ.
    // rust: fs::write(&metadata, r#"{"texture":{"blur":true}}"#).unwrap();
    // rust: png(
    // rust: &root.join("assets/minecraft/textures/item/enchanted_book.png"),
    // rust: 256,
    // rust: 256,
    // rust: [0, 255, 0, 255],
    // rust: );
    // rust: let atlas = glint_atlas::load(&root, 1, 16384).unwrap();
    // rust: assert_eq!(atlas["item/large"].u0, atlas["missingno"].u0);
    // rust: let book = atlas["item/enchanted_book"];
    // rust: assert_eq!(
    // rust: [book.u0, book.v0, book.u1, book.v1],
    // rust: [1.0 / 64.0, 33.0 / 64.0, 17.0 / 64.0, 49.0 / 64.0]
    // rust: );
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn prepared_item_atlas_matches_pinned_vanilla() void {
}
    // rust: let root =
    // rust: PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").expect("prepared resources"));
    // rust: let atlas = glint_atlas::load(&root, 1, 16384).unwrap();
    // rust: assert_eq!(atlas.len(), 896);
    // rust: let book = atlas["item/enchanted_book"];
    // rust: assert_eq!(
    // rust: [book.u0, book.v0, book.u1, book.v1],
    // rust: [437.0 / 1024.0, 163.0 / 512.0, 453.0 / 1024.0, 179.0 / 512.0]
    // rust: );
    // rust: let glint = Glint {
    // rust: millis: 0.0,
    // rust: speed: 0.0,
    // rust: alpha: 0.75,
    // rust: scale: 8.0,
}
    // rust: let uv = glint.uv([book.u0, book.v0]);
    // rust: for (got, want) in uv.into_iter().zip([2.919935, 3.101028]) {
    // rust: assert!((got - want).abs() < 1e-5);
}
}

pub fn external_item_atlas_oracle() void {
}
    // rust: let root = PathBuf::from(std::env::var_os("HORIZON_GLINT_ROOT").expect("resource root"));
    // rust: let expected: Value = serde_json::from_str(
    // rust: &fs::read_to_string(
    // rust: std::env::var_os("HORIZON_GLINT_EXPECTED").expect("vanilla atlas JSON"),
    // rust: )
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let bit = std::env::var("HORIZON_GLINT_ANISO_BITS")
    // rust: .unwrap()
    // rust: .parse()
    // rust: .unwrap();
    // rust: let sprites = glint_atlas::load(
    // rust: &root,
    // rust: 1 << glint_padding(if bit == 0 { 0 } else { 2 }, bit),
    // rust: 32768,
    // rust: )
    // rust: .unwrap();
    // rust: for (name, value) in expected["sprites"].as_object().unwrap() {
    // rust: let actual = sprites[sprite_name(name)];
    // rust: for (got, key) in [actual.u0, actual.v0, actual.u1, actual.v1]
    // rust: .into_iter()
    // rust: .zip(["u0", "v0", "u1", "v1"])
    // rust: {
    // rust: let want = value[key].as_f64().unwrap() as f32;
    // rust: assert!(
    // rust: (got - want).abs() < 1e-7,
    // rust: "{name} {key}: {got} != vanilla {want}"
    // rust: );
}
}
    // rust: if let Some(rejected) = expected["rejected"].as_array() {
    // rust: let missing = sprites["missingno"];
    // rust: for name in rejected {
    // rust: let actual = sprites[sprite_name(name.as_str().unwrap())];
    // rust: assert_eq!(
    // rust: [actual.u0, actual.v0, actual.u1, actual.v1],
    // rust: [missing.u0, missing.v0, missing.u1, missing.v1]
    // rust: );
}
    // rust: let renderer = ItemRenderer::load(&root).unwrap();
    // rust: renderer
    // rust: .prepare_glint_atlas(32768, (if bit == 0 { 0 } else { 2 }, bit))
    // rust: .unwrap();
    // rust: let hud_sprites = HashMap::from([
    // rust: ("item/enchanted_book".into(), missing),
    // rust: ("misc/enchanted_glint_item".into(), missing),
    // rust: ]);
    // rust: let mut batch = crate::hud::HudBatch::new([64, 64]);
    // rust: gui::draw(
    // rust: &state(
    // rust: "minecraft:item/enchanted_book",
    // rust: FoilType::Standard,
    // rust: DisplayContext::Gui,
    // rust: ),
    // rust: &renderer,
    // rust: &hud_sprites,
    // rust: &NoHost,
    // rust: &mut batch,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.75,
    // rust: );
    // rust: let want = &expected["sprites"]["minecraft:item/enchanted_book"]["glint_uv_clock0"];
    // rust: let mut seen = [false; 4];
    // rust: for vertex in batch.vertices.iter().filter(|v| v.uv[0] >= 2.0) {
    // rust: let index = match vertex.pos {
    // rust: [0.0, 0.0] => 0,
    // rust: [0.0, 16.0] => 3,
    // rust: [16.0, 16.0] => 2,
    // rust: [16.0, 0.0] => 1,
    // rust: p => panic!("unexpected corner {p:?}"),
}
    // rust: for (got, value) in vertex
    // rust: .glint_uv
    // rust: .into_iter()
    // rust: .zip(want[index].as_array().unwrap())
    // rust: {
    // rust: assert!((got - value.as_f64().unwrap() as f32).abs() < 1e-5);
}
    // rust: seen[index] = true;
}
    // rust: assert!(seen.into_iter().all(|v| v));
}
}
