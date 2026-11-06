//! Transpiled from Horizon Rust crate
package horizon_client_datapack_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

datapack_damage_new_world_drops_a_removed_resource_root_definition :: proc() {
}
//     use horizon_world::loot::PackOverlay;
    // rust: let prepared = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let root = std::env::temp_dir().join(format!("horizon-damage-root-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/demo/damage_type")).unwrap();
    // rust: for file in [
    // rust: "damage-catalog.json",
    // rust: "damage-tags.json",
    // rust: "player-float-ids.json",
    // rust: ] {
    // rust: fs::copy(prepared.join(file), root.join(file)).unwrap();
}
    // rust: let definition = root.join("data/demo/damage_type/installed.json");
    // rust: fs::write(
    // rust: &definition,
    // rust: r#"{"message_id":"installed","scaling":"never","exhaustion":0.25}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let cached_resources = HealthResources::load(&root).unwrap();
    // rust: let first_world = cached_resources
    // rust: .with_packs(&root, &PackOverlay::NONE, false)
    // rust: .unwrap();
    // rust: let custom = first_world.damage.id("demo:installed").unwrap();
    // rust: let vanilla = first_world.damage.id("minecraft:fall").unwrap();
    // rust: fs::remove_file(definition).unwrap();
    // rust: let reloaded = first_world
    // rust: .with_packs(&root, &PackOverlay::NONE, true)
    // rust: .unwrap();
    // rust: assert_eq!(reloaded.damage.id("demo:installed"), Some(custom));
    // rust: let next_world = cached_resources
    // rust: .with_packs(&root, &PackOverlay::NONE, false)
    // rust: .unwrap();
    // rust: assert!(next_world.damage.id("demo:installed").is_none());
    // rust: assert_eq!(next_world.damage.id("minecraft:fall"), Some(vanilla));
    // rust: assert_eq!(first_world.damage.id("demo:installed"), Some(custom));
    // rust: fs::remove_dir_all(root).unwrap();
}

datapack_damage_initial_snapshot_uses_the_prepared_worlds_features :: proc() {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let world =
    // rust: std::env::temp_dir().join(format!("horizon-damage-features-{}", std::process::id()));
    // rust: let pack = world.join("datapacks/feature_damage");
    // rust: let _ = fs::remove_dir_all(&world);
    // rust: fs::create_dir_all(pack.join("data/demo/damage_type")).unwrap();
    // rust: fs::write(
    // rust: pack.join("pack.mcmeta"),
    // rust: r#"{"features":{"enabled":["minecraft:trade_rebalance"]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: pack.join("data/demo/damage_type/heat.json"),
    // rust: r#"{"message_id":"heat","scaling":"never","exhaustion":0.1}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: world.join("datapacks.json"),
    // rust: r#"{"enabled":["file/feature_damage"],"disabled":[]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let packs = crate::datapack::discover_with_features(&world, &root);
    // rust: let snapshot = |features: &[String]| {
    // rust: let enabled = crate::datapack::enabled_ids(&world, &packs, features);
    // rust: let selected: Vec<_> = enabled
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: let store = crate::datapack::DataStore::load(&selected);
    // rust: let files: Vec<_> = store.files.into_iter().collect();
    // rust: horizon_world::damage_source::Catalog::load(
    // rust: &root,
    // rust: &horizon_world::loot::PackOverlay { files: &files },
    // rust: )
    // rust: .unwrap()
}
    // rust: let stale = snapshot(&["minecraft:vanilla".into()]);
    // rust: assert!(stale.id("demo:heat").is_none());
    // rust: let prepared = snapshot(&[
    // rust: "minecraft:vanilla".into(),
    // rust: "minecraft:trade_rebalance".into(),
    // rust: ]);
    // rust: assert!(prepared.id("demo:heat").is_some());
    // rust: fs::remove_dir_all(world).unwrap();
}

// Ordinary player hurt, using a custom source and a frozen-registry tag reload.
datapack_damage_uses_custom_identity_armor_fire_and_reloaded_tags :: proc() {
}
//     use horizon_world::loot::PackOverlay;
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let files = vec![
    // rust: ("damage_type/demo:heated_air".into(), vec![br#"{"message_id":"heated_air","scaling":"never","exhaustion":0.25,"effects":"burning"}"#.to_vec()]),
    // rust: ("tags/minecraft:damage_type/is_fire".into(), vec![br#"{"values":["demo:heated_air"]}"#.to_vec()]),
    // rust: ("tags/minecraft:damage_type/bypasses_armor".into(), vec![br#"{"values":["demo:heated_air"]}"#.to_vec()]),
    // rust: ];
    // rust: let open = resources
    // rust: .health
    // rust: .with_packs(&root, &PackOverlay { files: &files }, false)
    // rust: .unwrap();
    // rust: let id = open.damage.id("demo:heated_air").unwrap();
    // rust: let player = || {
    // rust: let mut p = PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO).unwrap();
    // rust: p.entity_id = 9701;
    // rust: let key = p.attributes.key("minecraft:armor").unwrap();
    // rust: let armor = p.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: p.attributes
    // rust: .edit(&armor, |a, o| a.set_base_value(20.0, o))
    // rust: .unwrap();
    // rust: p
}
    // rust: let rules = HealthRules::default();
    // rust: let mut armored = player();
    // rust: assert!(armored.hurt(&open, rules, id, 4.0).unwrap());
    // rust: assert_eq!(armored.health.health(), 16.0);
    // rust: assert_eq!(armored.health.food.exhaustion, 0.25);
    // rust: assert_eq!(armored.hurt_log.last().unwrap().source, "demo:heated_air");
    // rust: let mut resistant = player();
    // rust: resistant.status.fire_resistance = true;
    // rust: assert!(!resistant.hurt(&open, rules, id, 4.0).unwrap());
    // rust: assert_eq!(resistant.health.health(), 20.0);
    // rust: let mut item_rules = crate::enchant::Enchantments::default();
    // rust: item_rules.bind_damage_catalog(&open.damage);
    // rust: assert!(item_rules.damage_tags["minecraft:is_fire"].contains("demo:heated_air"));
    // Disable the pack: the registered type remains, its added tags do not.
    // rust: let reload = open.with_packs(&root, &PackOverlay::NONE, true).unwrap();
    // rust: assert_eq!(reload.damage.id("demo:heated_air"), Some(id));
    // rust: let mut after = player();
    // rust: after.status.fire_resistance = true;
    // rust: assert!(after.hurt(&reload, rules, id, 4.0).unwrap());
    // rust: assert!(
    // rust: after.health.health() > 16.0 && after.health.health() < 20.0,
    // rust: "the same source now encounters armor and ignores fire resistance"
    // rust: );
    // rust: item_rules.bind_damage_catalog(&reload.damage);
    // rust: assert!(!item_rules.damage_tags["minecraft:is_fire"].contains("demo:heated_air"));
    // rust: assert!(
    // rust: open.damage.in_tag(id, "minecraft:is_fire"),
    // rust: "another snapshot remains unchanged"
    // rust: );
}
