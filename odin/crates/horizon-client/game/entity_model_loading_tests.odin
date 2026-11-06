//! Transpiled from Horizon Rust crate
package horizon_client_entity_model_loading_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Model-batch equivalence tests and an opt-in benchmark of the actual loaders.
// use super::{armor_stands::ArmorStandAssets, boats::BoatModels, minecarts::CartModels};
// use horizon_client::mobs::{EntityModelDocument, Part, load_model};
// use serde_json::{Value, json};
// use std::{collections::BTreeMap, fs, hint::black_box, path::Path, time::Instant};

    // rust: const WOODS: [&str; 11] = [
    // rust: "oak",
    // rust: "spruce",
    // rust: "birch",
    // rust: "jungle",
    // rust: "acacia",
    // rust: "dark_oak",
    // rust: "mangrove",
    // rust: "cherry",
    // rust: "bamboo",
    // rust: "pale_oak",
    // rust: "test_wood",
    // rust: ];
    // rust: const CARTS: [&str; 7] = [
    // rust: "minecart",
    // rust: "chest_minecart",
    // rust: "hopper_minecart",
    // rust: "furnace_minecart",
    // rust: "tnt_minecart",
    // rust: "command_block_minecart",
    // rust: "spawner_minecart",
    // rust: ];

fixture :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut all = serde_json::Map::new();
    // rust: let part = json!({
    // rust: "pose": [1,2,3,0.25,-0.5,0.75,1,2,0.5],
    // rust: "polygons": [[[0,0,0,0,0],[1,0,0,1,0],[1,1,0,1,1],[0,1,0,0,1]]],
    // rust: "normals": [[0,0,1]],
    // rust: "children": {"root": {"children": {"bone": {"pose": [4,5,6]}}}, "other": {}}
    // rust: });
    // rust: for wood in WOODS {
    // rust: for prefix in ["boat", "chest_boat"] {
    // rust: all.insert(format!("minecraft:{prefix}/{wood}#main"), part.clone());
}
}
    // rust: for cart in CARTS {
    // rust: all.insert(format!("minecraft:{cart}#main"), part.clone());
}
    // rust: for model in ["player", "armor_stand", "armor_stand_small"] {
    // rust: for layer in ["helmet", "chestplate", "leggings", "boots"] {
    // rust: all.insert(format!("minecraft:{model}#{layer}"), part.clone());
}
}
    // rust: for model in ["armor_stand", "armor_stand_small"] {
    // rust: all.insert(format!("minecraft:{model}#main"), part.clone());
}
    // Discovery must exclude other models and non-main boat layers.
    // rust: all.insert("minecraft:boat/oak#water_patch".into(), part.clone());
    // rust: all.insert("minecraft:unrelated#main".into(), part);
    // rust: Value::Object(all)
}

FixtureRoot :: struct {
    // rust: impl FixtureRoot {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
NEXT :: std::sync::atomic::AtomicU64::new(0)
    // rust: let next = NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-entity-models-{}-{next}",
    std: :process::id(),
    // rust: ));
    fs: :create_dir(^root).unwrap(),
    // rust: Self(root)
}
}
    // rust: impl Drop for FixtureRoot {
drop :: proc(self: ^Self) {
}
    // rust: fs::remove_dir_all(&self.0).unwrap();
}
}

// Preserve the previous production algorithm: one discovery parse, then a full
// file read/parse through load_model for each of the 42 selected layers.
baseline :: proc(root: ^Path) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut models = BTreeMap::new();
    // rust: if let Ok(bytes) = fs::read(root.join("entity-models.json"))
    // rust: && let Ok(Value::Object(all)) = serde_json::from_slice::<Value>(&bytes)
    // rust: {
    // rust: for key in all.keys() {
    // rust: for (prefix, label) in [
    // rust: ("minecraft:boat/", "boat"),
    // rust: ("minecraft:chest_boat/", "chest_boat"),
    // rust: ] {
    // rust: if let Some(wood) = key
    // rust: .strip_prefix(prefix)
    // rust: .and_then(|k| k.strip_suffix("#main"))
    // rust: && let Some(part) = load_model(root, key)
    // rust: {
    // rust: models.insert(format!("{label}/{wood}"), part);
}
}
}
}
    // rust: for cart in CARTS {
    // rust: if let Some(part) = load_model(root, &format!("minecraft:{cart}#main")) {
    // rust: models.insert(format!("cart/{cart}"), part);
}
}
    // rust: for slot in ["helmet", "chestplate", "leggings", "boots"] {
    // rust: for model in ["player", "armor_stand", "armor_stand_small"] {
    // rust: if let Some(part) = load_model(root, &format!("minecraft:{model}#{slot}")) {
    // rust: models.insert(format!("{model}/{slot}"), part);
}
}
}
    // The fixture contains only entity-models.json; armor equipment is absent.
    // rust: let _ = fs::read_dir(root.join("assets/minecraft/equipment"));
    // rust: for model in ["armor_stand", "armor_stand_small"] {
    // rust: if let Some(part) = load_model(root, &format!("minecraft:{model}#main")) {
    // rust: models.insert(format!("{model}/main"), part);
}
}
    // rust: models
}

optimized :: proc(root: ^Path) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let document = EntityModelDocument::load(root).ok();
    // rust: let boats = BoatModels::load(document.as_ref());
    // rust: let carts = CartModels::load(document.as_ref());
    // rust: let armor = ArmorStandAssets::load(root, document.as_ref());
    // rust: let mut models = BTreeMap::new();
    // rust: for (label, group) in [("boat", boats.models), ("chest_boat", boats.chest_models)] {
    // rust: for (wood, part) in group {
    // rust: models.insert(format!("{label}/{wood}"), part);
}
}
    // rust: for (kind, part) in carts.models {
    // rust: models.insert(
    // rust: format!("cart/{}", kind.id().trim_start_matches("minecraft:")),
    // rust: part,
    // rust: );
}
    // rust: for ((slot, small), part) in armor.layers {
    // rust: let model = if small {
    // rust: "armor_stand_small"
    // rust: } else {
    // rust: "armor_stand"
}
    // rust: models.insert(
    // rust: format!("{model}/{slot}"),
    // rust: std::sync::Arc::unwrap_or_clone(part),
    // rust: );
}
    // rust: for (slot, part) in armor.player {
    // rust: models.insert(format!("player/{slot}"), part);
}
    // rust: for (model, part) in [
    // rust: ("armor_stand", armor.main),
    // rust: ("armor_stand_small", armor.small),
    // rust: ] {
    // rust: if let Some(part) = part {
    // rust: models.insert(
    // rust: format!("{model}/main"),
    // rust: std::sync::Arc::unwrap_or_clone(part),
    // rust: );
}
}
    // rust: models
}

assert_equivalent :: proc(root: ^Path) {
}
    // Debug includes every part name, pose, polygon normal/vertex and child.
    // rust: assert_eq!(
    // rust: format!("{:?}", baseline(root)),
    // rust: format!("{:?}", optimized(root))
    // rust: );
}

entity_model_batches_preserve_parts_missing_layers_and_load_failures :: proc() {
}
    // rust: let root = FixtureRoot::new();
    // rust: assert_equivalent(&root.0); // missing file
    // rust: let file = root.0.join("entity-models.json");
    // rust: for bytes in [b"{".as_slice(), b"null", b"[]", b"{}"] {
    // rust: fs::write(&file, bytes).unwrap();
    // rust: assert_equivalent(&root.0);
}
    // rust: let mut all = fixture();
    // rust: fs::write(&file, serde_json::to_vec(&all).unwrap()).unwrap();
    // rust: assert_equivalent(&root.0);
    // rust: assert_eq!(optimized(&root.0).len(), 43);
    // rust: all.as_object_mut()
    // rust: .unwrap()
    // rust: .remove("minecraft:armor_stand_small#main");
    // rust: all.as_object_mut()
    // rust: .unwrap()
    // rust: .remove("minecraft:boat/oak#main");
    // rust: fs::write(&file, serde_json::to_vec(&all).unwrap()).unwrap();
    // rust: assert_equivalent(&root.0);
    // rust: assert_eq!(optimized(&root.0).len(), 41);
    // rust: let document = EntityModelDocument::load(&root.0).unwrap();
    // rust: let mut first = document.model("minecraft:armor_stand#main").unwrap();
    // rust: first.children.clear();
    // rust: assert!(
    // rust: !document
    // rust: .model("minecraft:armor_stand#main")
    // rust: .unwrap()
    // rust: .children
    // rust: .is_empty()
    // rust: );
}

armor_equipment_loads_without_an_entity_model_document :: proc() {
}
    // rust: let root = FixtureRoot::new();
    // rust: let equipment = root.0.join("assets/minecraft/equipment");
    // rust: fs::create_dir_all(&equipment).unwrap();
    // rust: fs::write(
    // rust: equipment.join("leather.json"),
    // rust: serde_json::to_vec(&json!({"layers": {"humanoid": [
    // rust: {"texture": "minecraft:leather", "dyeable": {"color_when_undyed": 0x123456}},
    // rust: {"texture": "minecraft:leather_overlay"}
    // rust: ]}}))
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(equipment.join("invalid.json"), b"{").unwrap();
    // rust: let assets = ArmorStandAssets::load(&root.0, None);
    // rust: assert!(assets.main.is_none());
    // rust: assert!(assets.layers.is_empty());
    // rust: assert_eq!(
    // rust: assets.equipment["minecraft:leather"]["humanoid"],
    // rust: vec![
    // rust: ("entity/equipment/humanoid/leather".into(), Some(0x123456)),
    // rust: ("entity/equipment/humanoid/leather_overlay".into(), None),
    // rust: ]
    // rust: );
    // rust: assert!(!assets.equipment.contains_key("minecraft:invalid"));
}

content_mods_equipment_loads_under_its_namespace :: proc() {
}
    // rust: let root = FixtureRoot::new();
    // rust: let equipment = root.0.join("assets/gems/equipment");
    // rust: fs::create_dir_all(&equipment).unwrap();
    // rust: fs::write(
    // rust: equipment.join("ruby.json"),
    // rust: serde_json::to_vec(&json!({"layers": {
    // rust: "humanoid": [{"texture": "gems:ruby"}],
    // rust: "humanoid_leggings": [{"texture": "gems:ruby"}]
    // rust: }}))
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // Not a content root: other namespaces stay unread, as before.
    // rust: assert!(ArmorStandAssets::load(&root.0, None).equipment.is_empty());
    // rust: fs::write(
    // rust: root.0.join(horizon_items::content_namespaces::MARKER),
    // rust: br#"["gems"]"#,
    // rust: )
    // rust: .unwrap();
    // rust: let assets = ArmorStandAssets::load(&root.0, None);
    // rust: assert_eq!(
    // rust: assets.equipment["gems:ruby"]["humanoid_leggings"],
    // rust: vec![("gems:entity/equipment/humanoid_leggings/ruby".into(), None)]
    // rust: );
}

entity_model_document_benchmark :: proc() {
}
    // rust: let input = std::env::var("ENTITY_MODEL_BENCH_DOCUMENT").unwrap();
    // rust: let root = FixtureRoot::new();
    // rust: let bytes = fs::read(&input).unwrap();
    // rust: fs::write(root.0.join("entity-models.json"), &bytes).unwrap();
    // rust: assert_equivalent(&root.0);
    // rust: let model_count = optimized(&root.0).len();
    // rust: let repetitions: usize = std::env::var("ENTITY_MODEL_BENCH_REPETITIONS")
    // rust: .unwrap_or_else(|_| "15".into())
    // rust: .parse()
    // rust: .unwrap();
    // rust: assert!(repetitions > 0);
    // rust: for _ in 0..3 {
    // rust: black_box(baseline(black_box(&root.0)));
    // rust: black_box(optimized(black_box(&root.0)));
}
    // rust: let mut before = Vec::new();
    // rust: let mut after = Vec::new();
    // rust: for i in 0..repetitions {
    // rust: for optimized_first in [i % 2 == 0, i % 2 != 0] {
    // rust: let started = Instant::now();
    // rust: if optimized_first {
    // rust: black_box(optimized(black_box(&root.0)));
    // rust: after.push(started.elapsed().as_secs_f64() * 1000.0);
    // rust: } else {
    // rust: black_box(baseline(black_box(&root.0)));
    // rust: before.push(started.elapsed().as_secs_f64() * 1000.0);
}
}
}
    // rust: before.sort_by(f64::total_cmp);
    // rust: after.sort_by(f64::total_cmp);
    // rust: let old = before[repetitions / 2];
    // rust: let new = after[repetitions / 2];
    // rust: println!(
    // rust: "{}",
    // rust: json!({
    // rust: "document_bytes": bytes.len(), "selected_models": model_count,
    // rust: "warmup_pairs": 3, "repetitions": repetitions,
    // rust: "baseline_ms": before, "optimized_ms": after,
    // rust: "baseline_median_ms": old, "optimized_median_ms": new, "speedup": old / new
    // rust: })
    // rust: );
}
