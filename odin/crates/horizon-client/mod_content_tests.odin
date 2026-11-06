//! Transpiled from Horizon Rust crate
package horizon_client_mod_content_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::{assets::Assets, blocks::BlockFacts, items::Items};

renames_ids_keys_and_states :: proc() {
}
    // rust: let mut r = Rename::new("minecraft:iron_block", "ruby:ruby_block");
    // rust: r.states = 10..12;
    // rust: r.first = 100;
    // rust: assert_eq!(
    // rust: r.string("minecraft:iron_block").as_deref(),
    // rust: Some("ruby:ruby_block")
    // rust: );
    // rust: assert_eq!(
    // rust: r.string("Block{minecraft:iron_block}").as_deref(),
    // rust: Some("Block{ruby:ruby_block}")
    // rust: );
    // rust: assert_eq!(
    // rust: r.string("block.minecraft.iron_block").as_deref(),
    // rust: Some("block.ruby.ruby_block")
    // rust: );
    // rust: assert_eq!(r.string("minecraft:iron_blocks"), None);
    // rust: assert_eq!(r.string("block.minecraft.iron_bars"), None);
    // rust: assert_eq!(
    // rust: (r.id(9), r.id(10), r.id(11), r.id(12)),
    // rust: (None, Some(100), Some(101), None)
    // rust: );
}

json_keeps_key_order_and_numbers :: proc() {
}
    // rust: let text = r#"{"z":1,"a":[0.6,5.0,-1,{"m":null,"b":true}],"k":"v"}"#;
    // rust: let doc: J = serde_json::from_str(text).unwrap();
    // rust: assert_eq!(serde_json::to_string(&doc).unwrap(), text);
}

item_components_patch_the_template_entry :: proc() {
}
    // rust: let mut entry: J =
    // rust: serde_json::from_str(r#"{"minecraft:max_damage": 250, "minecraft:repairable": {}}"#)
    // rust: .unwrap();
    // rust: let known: BTreeSet<String> = [
    // rust: "minecraft:max_damage",
    // rust: "minecraft:repairable",
    // rust: "minecraft:food",
    // rust: ]
    // rust: .map(str::to_owned)
    // rust: .into();
    // rust: let patch = |text: &str| -> Vec<(String, J)> {
    // rust: let J::Obj(o) = serde_json::from_str(text).unwrap() else {
    // rust: unreachable!()
}
    // rust: o
}
    // rust: patch_components(
    // rust: &mut entry,
    // rust: &patch(r#"{"minecraft:max_damage": 900, "!minecraft:repairable": {}, "minecraft:food": {"nutrition": 4}}"#),
    // rust: &known,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: serde_json::to_string(&entry).unwrap(),
    // rust: r#"{"minecraft:max_damage":900,"minecraft:food":{"nutrition":4}}"#
    // rust: );
    // rust: for typo in [r#"{"minecraft:fod": {}}"#, r#"{"!minecraft:fod": {}}"#] {
    // rust: let e = patch_components(&mut entry, &patch(typo), &known).unwrap_err();
    // rust: assert_eq!(e, "minecraft:fod is not a known component type");
}
}

creative_tabs_keep_vanilla_items_missing_from_search :: proc() {
}
    // rust: let tab = horizon_mods::content::CreativeTab {
    // rust: id: "test:restricted".into(),
    // rust: title: "Restricted".into(),
    // rust: icon: "minecraft:barrier".into(),
    // rust: items: [
    // rust: "minecraft:barrier",
    // rust: "minecraft:command_block",
    // rust: "minecraft:written_book",
    // rust: "minecraft:knowledge_book",
    // rust: ]
    // rust: .map(str::to_owned)
    // rust: .into(),
}
    // rust: let plan = Plan {
    // rust: blocks: Vec::new(),
    // rust: items: Vec::new(),
    // rust: vanilla_items: tab.items.iter().cloned().collect(),
    // rust: effects: Vec::new(),
    // rust: entity_types: Vec::new(),
    // rust: menu_types: Vec::new(),
    // rust: states: 0,
    // rust: defaults: BTreeMap::new(),
    // rust: sounds: BTreeMap::new(),
    // rust: tabs: vec![&tab],
    // rust: names: BTreeMap::new(),
}
    // rust: let mut doc: J = serde_json::from_str(
    // rust: r#"{"tabs":[{"type":"SEARCH","items":["{count:1,id:\"minecraft:stone\"}"]}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: plan.creative_tabs(&mut doc).unwrap();
    // rust: let doc: serde_json::Value = serde_json::to_value(doc).unwrap();
    // rust: assert_eq!(
    // rust: doc["tabs"][1]["items"],
    // rust: serde_json::json!([
    // rust: "{count:1,id:\"minecraft:barrier\"}",
    // rust: "{count:1,id:\"minecraft:command_block\"}",
    // rust: "{count:1,id:\"minecraft:written_book\"}",
    // rust: "{count:1,id:\"minecraft:knowledge_book\"}",
    // rust: ])
    // rust: );
}

// A block item's patch goes over its template block's item, and a type no
// vanilla item has fails the build.
block_items_patch_their_template_item :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-block-item-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let base = scratch.join("base");
    // rust: fs::create_dir_all(&base).unwrap();
    // rust: fs::write(
    // rust: base.join("facts.json"),
    // rust: r#"{"states": [["minecraft:iron_block"]], "defaults": {"minecraft:iron_block": 0}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: base.join("gameplay-facts.json"),
    // rust: r#"{"states": [{"item": "minecraft:iron_block"}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let items = r##"{"minecraft:iron_block": {"minecraft:max_stack_size": 64,
    // rust: "minecraft:item_name": {"translate": "block.minecraft.iron_block"}},
    // rust: "minecraft:netherite_block": {"minecraft:damage_resistant": {"types": "#minecraft:is_fire"}}}"##;
    // rust: let block = |dir: &str, components: &str| {
    // rust: folder_mod(
    // rust: &scratch.join(dir),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("ruby", "")),
    // rust: (
    // rust: "data/ruby/horizon/block/ruby_block.json",
    // rust: &format!(
    // rust: r#"{{"template": "minecraft:iron_block", "components": {components}}}"#
    // rust: ),
    // rust: ),
    // rust: ],
    // rust: )
}
    // rust: let mods = [block(
    // rust: "ruby",
    // rust: r##"{"minecraft:max_stack_size": 16, "minecraft:damage_resistant": {"types": "#minecraft:is_fire"}}"##,
    // rust: )];
    // rust: let mut doc: J = serde_json::from_str(items).unwrap();
    // rust: Plan::new(&base, &mods)
    // rust: .unwrap()
    // rust: .json("items.json", &mut doc)
    // rust: .unwrap();
    // rust: let doc: serde_json::Value = serde_json::to_value(&doc).unwrap();
    // rust: assert_eq!(
    // rust: doc["ruby:ruby_block"],
    // rust: serde_json::json!({"minecraft:max_stack_size": 16,
    // rust: "minecraft:item_name": {"translate": "block.ruby.ruby_block"},
    // rust: "minecraft:damage_resistant": {"types": "#minecraft:is_fire"}})
    // rust: );
    // rust: assert_eq!(doc["minecraft:iron_block"]["minecraft:max_stack_size"], 64);
    // rust: let mods = [block("typo", r#"{"minecraft:fod": {}}"#)];
    // rust: let mut doc: J = serde_json::from_str(items).unwrap();
    // rust: let e = Plan::new(&base, &mods)
    // rust: .unwrap()
    // rust: .json("items.json", &mut doc)
    // rust: .unwrap_err();
    // rust: assert_eq!(
    // rust: e.to_string(),
    // rust: "ruby:ruby_block: minecraft:fod is not a known component type"
    // rust: );
    // rust: fs::remove_dir_all(scratch).unwrap();
}

tags_merge_without_repeats :: proc() {
}
    // rust: let vanilla = r#"{"values": ["minecraft:stone"]}"#;
    // rust: let more = [
    // rust: J::Str("ruby:ruby_block".into()),
    // rust: J::Str("minecraft:stone".into()),
    // rust: ];
    // rust: let merged: serde_json::Value =
    // rust: serde_json::from_str(&merge_tag(Some(vanilla), &more, "t").unwrap()).unwrap();
    // rust: assert_eq!(
    // rust: merged["values"],
    // rust: serde_json::json!(["minecraft:stone", "ruby:ruby_block"])
    // rust: );
}

a_mods_atlas_sources_follow_vanillas :: proc() {
}
    // rust: let vanilla = r#"{"sources": [{"type": "directory", "source": "block", "prefix": "block/"}]}"#;
    // rust: let more = [J::Obj(vec![
    // rust: ("type".into(), J::Str("directory".into())),
    // rust: ("source".into(), J::Str("mek_chemical".into())),
    // rust: ])];
    // rust: let merged: serde_json::Value =
    // rust: serde_json::from_str(&merge_atlas(Some(vanilla), &more, "a").unwrap()).unwrap();
    // rust: let sources: Vec<_> = merged["sources"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|s| s["source"].as_str().unwrap())
    // rust: .collect();
    // rust: assert_eq!(sources, ["block", "mek_chemical"]);
}

// Registry IDs and state IDs must not depend on package discovery order.
allocated_ids_follow_mod_and_entry_order_after_vanilla :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-order-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let base = scratch.join("base");
    // rust: fs::create_dir_all(&base).unwrap();
    // rust: fs::write(
    // rust: base.join("facts.json"),
    // rust: r#"{"states": [["minecraft:iron_block"], ["minecraft:iron_block"], ["minecraft:stone"]],
    // rust: "defaults": {"minecraft:iron_block": 0, "minecraft:stone": 2}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: base.join("gameplay-facts.json"),
    // rust: r#"{"states": [{"item":"minecraft:iron_block"}, {"item":"minecraft:iron_block"},
    // rust: {"item":"minecraft:stone"}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: base.join("items.json"),
    // rust: r#"{"minecraft:stone": {}, "minecraft:iron_block": {}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: base.join("registries.json"),
    // rust: r#"{"minecraft:item":{"entries":{"minecraft:stone":{"protocol_id":4},
    // rust: "minecraft:iron_block":{"protocol_id":9}}},
    // rust: "minecraft:block":{"entries":{"minecraft:stone":{"protocol_id":7},
    // rust: "minecraft:iron_block":{"protocol_id":11}}},
    // rust: "minecraft:mob_effect":{"entries":{"minecraft:speed":{"protocol_id":0},
    // rust: "minecraft:luck":{"protocol_id":25}}},
    // rust: "minecraft:block_entity_type":{"entries":{"minecraft:chest":{"protocol_id":1}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::create_dir_all(base.join("assets/minecraft/blockstates")).unwrap();
    // rust: fs::write(
    // rust: base.join("assets/minecraft/blockstates/iron_block.json"),
    // rust: "{}",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(base.join("assets/minecraft/blockstates/stone.json"), "{}").unwrap();
    // rust: let ruby = folder_mod(
    // rust: &scratch.join("ruby"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("ruby", "")),
    // rust: (
    // rust: "data/ruby/horizon/block/zblock.json",
    // rust: r#"{"template":"minecraft:stone"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/item/aitem.json",
    // rust: r#"{"template":"minecraft:stone"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/mob_effect/glow.json",
    // rust: r#"{"category":"beneficial","color":16711680}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let alpha = folder_mod(
    // rust: &scratch.join("alpha"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("alpha", "")),
    // rust: (
    // rust: "data/alpha/horizon/block/zblock.json",
    // rust: r#"{"template":"minecraft:iron_block"}"#,
    // rust: ),
    // rust: (
    // rust: "data/alpha/horizon/item/aitem.json",
    // rust: r#"{"template":"minecraft:stone"}"#,
    // rust: ),
    // rust: (
    // rust: "data/alpha/horizon/mob_effect/zap.json",
    // rust: r#"{"category":"harmful","color":255}"#,
    // rust: ),
    // rust: (
    // rust: "data/alpha/horizon/mob_effect/dull.json",
    // rust: r#"{"category":"neutral","color":0}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let mut mods = vec![ruby, alpha];
    // rust: for index in 0..2 {
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let blocks: Vec<_> = plan
    // rust: .blocks
    // rust: .iter()
    // rust: .map(|block| {
    // rust: (
    // rust: block.decl.id.as_str(),
    // rust: block.rename.first,
    // rust: block.rename.states.len(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(blocks, [("alpha:zblock", 3, 2), ("ruby:zblock", 5, 1)]);
    // rust: let items: Vec<_> = plan
    // rust: .items
    // rust: .iter()
    // rust: .map(|item| item.rename.to.as_str())
    // rust: .collect();
    // rust: assert_eq!(
    // rust: items,
    // rust: ["alpha:aitem", "alpha:zblock", "ruby:aitem", "ruby:zblock"]
    // rust: );

        // Exercise the same registry rewrite the game and server read.
    // rust: let mut registry: J = serde_json::from_str(
    // rust: r#"{"minecraft:item":{"entries":{"minecraft:stone":{"protocol_id":4},
    // rust: "minecraft:iron_block":{"protocol_id":9}}},
    // rust: "minecraft:block":{"entries":{"minecraft:stone":{"protocol_id":7},
    // rust: "minecraft:iron_block":{"protocol_id":11}}},
    // rust: "minecraft:mob_effect":{"entries":{"minecraft:speed":{"protocol_id":0},
    // rust: "minecraft:luck":{"protocol_id":25}}},
    // rust: "minecraft:block_entity_type":{"entries":{"minecraft:chest":{"protocol_id":1}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: plan.json("registries.json", &mut registry).unwrap();
    // rust: let registry: serde_json::Value =
    // rust: serde_json::from_str(&serde_json::to_string(&registry).unwrap()).unwrap();
    // rust: let id = |kind: &str, name: &str| {
    // rust: registry[kind]["entries"][name]["protocol_id"]
    // rust: .as_u64()
    // rust: .unwrap()
}
    // rust: assert_eq!(id("minecraft:item", "minecraft:stone"), 4);
    // rust: assert_eq!(id("minecraft:item", "minecraft:iron_block"), 9);
    // rust: assert_eq!(id("minecraft:item", "alpha:aitem"), 10);
    // rust: assert_eq!(id("minecraft:item", "alpha:zblock"), 11);
    // rust: assert_eq!(id("minecraft:item", "ruby:aitem"), 12);
    // rust: assert_eq!(id("minecraft:item", "ruby:zblock"), 13);
    // rust: assert_eq!(id("minecraft:block", "minecraft:stone"), 7);
    // rust: assert_eq!(id("minecraft:block", "minecraft:iron_block"), 11);
    // rust: assert_eq!(id("minecraft:block", "alpha:zblock"), 12);
    // rust: assert_eq!(id("minecraft:block", "ruby:zblock"), 13);
        // Each mod block names a block entity type, after vanilla's.
    // rust: assert_eq!(id("minecraft:block_entity_type", "minecraft:chest"), 1);
    // rust: assert_eq!(id("minecraft:block_entity_type", "alpha:zblock"), 2);
    // rust: assert_eq!(id("minecraft:block_entity_type", "ruby:zblock"), 3);

    // rust: assert_eq!(id("minecraft:mob_effect", "minecraft:luck"), 25);
    // rust: assert_eq!(id("minecraft:mob_effect", "alpha:dull"), 26);
    // rust: assert_eq!(id("minecraft:mob_effect", "alpha:zap"), 27);
    // rust: assert_eq!(id("minecraft:mob_effect", "ruby:glow"), 28);

        // `/effect` and the mob_effect arguments check ids against this table.
    // rust: let mut commands: J = serde_json::from_str(
    // rust: r#"{"blocks":[],"items":[],"effects":["minecraft:speed"],
    // rust: "by_registry":{"minecraft:mob_effect":{"ids":["minecraft:speed"]}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: plan.json("command-registries.json", &mut commands).unwrap();
    // rust: let commands: serde_json::Value =
    // rust: serde_json::from_str(&serde_json::to_string(&commands).unwrap()).unwrap();
    // rust: let want = ["minecraft:speed", "alpha:dull", "alpha:zap", "ruby:glow"];
    // rust: assert_eq!(commands["effects"], serde_json::json!(want));
    // rust: assert_eq!(
    // rust: commands["by_registry"]["minecraft:mob_effect"]["ids"],
    // rust: serde_json::json!(want)
    // rust: );
    // rust: drop(plan);

    // rust: let output = scratch.join(format!("output-{index}"));
    // rust: build(&base, &mods, &output).unwrap();
    // rust: let built: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(output.join("registries.json")).unwrap()).unwrap();
    // rust: assert_eq!(
    // rust: built, registry,
    // rust: "the built root must use the tested allocation"
    // rust: );
    // rust: mods.reverse();
}
    // rust: fs::remove_dir_all(scratch).unwrap();
}

prepared :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let manifest = Path::new(env!("CARGO_MANIFEST_DIR"));
    // rust: [
    // rust: manifest.join("../../.local/horizon-client/26.3"),
    // rust: manifest.join("../../../../.local/horizon-client/26.3"),
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|root| root.join("gameplay-facts.json").exists())
}

// A content mod folder: a full block, a door and an item-less glass from
// templates, items, a recipe, a vanilla tag addition and a language file.
ruby_mod :: proc(dir: ^Path) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let files: [(&str, &str); 11] = [
    // rust: (
    // rust: "horizon-mod.toml",
    // rust: "id = \"ruby\"\nname = \"Ruby\"\nversion = \"0.1.0\"\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n",
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/block/ruby_block.json",
    // rust: r##"{"template": "minecraft:iron_block", "properties": {"hardness": 4.0, "light": 3,
    // rust: "sounds": "minecraft:amethyst_block", "map_color": 28, "friction": 0.8,
    // rust: "random_ticks": true, "occludes": false},
    // rust: "components": {"minecraft:max_stack_size": 16,
    // rust: "minecraft:damage_resistant": {"types": "#minecraft:is_fire"}}}"##,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/block/ruby_door.json",
    // rust: r#"{"template": "minecraft:oak_door"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/block/ruby_glass.json",
    // rust: r#"{"template": "minecraft:glass", "item": false,
    // rust: "properties": {"render_shape": "ENTITYBLOCK_ANIMATED"}}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/item/ruby.json",
    // rust: r#"{"template": "minecraft:diamond", "max_stack_size": 16, "rarity": "rare"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/item/ruby_sword.json",
    // rust: r#"{"template": "minecraft:iron_sword", "components": {"minecraft:max_damage": 900,
    // rust: "minecraft:attribute_modifiers": [{"type": "minecraft:attack_damage",
    // rust: "id": "minecraft:base_attack_damage", "amount": 7.0,
    // rust: "operation": "add_value", "slot": "mainhand"}],
    // rust: "!minecraft:repairable": {}}}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/item/ruby_stew.json",
    // rust: r#"{"template": "minecraft:mushroom_stew", "crafting_remainder": "minecraft:bowl"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/recipe/ruby_from_stew.json",
    // rust: r#"{"type": "minecraft:crafting_shapeless", "category": "misc",
    // rust: "ingredients": ["ruby:ruby_stew"], "result": {"id": "ruby:ruby"}}"#,
    // rust: ),
        // Carried-over tags name blocks left out and other mods' ids too.
    // rust: (
    // rust: "data/minecraft/tags/block/mineable/pickaxe.json",
    // rust: r##"{"values": ["ruby:ruby_block", "ruby:left_out", "othermod:thing",
    // rust: {"id": "othermod:optional", "required": false}, "#c:storage_blocks/ruby"]}"##,
    // rust: ),
    // rust: (
    // rust: "data/c/tags/item/gems/ruby.json",
    // rust: r#"{"values": ["ruby:ruby", "othermod:ruby"]}"#,
    // rust: ),
    // rust: (
    // rust: "assets/ruby/lang/en_us.json",
    // rust: r#"{"block.ruby.ruby_block": "Block of Ruby"}"#,
    // rust: ),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: let path = dir.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let package = horizon_mods::Package::read(dir).unwrap();
    // rust: ContentMod {
    // rust: id: "ruby".into(),
    // rust: content: Content::read(dir, &package.manifest).unwrap(),
}
}

// The overlay over the real prepared resources: every loader reads it, the
// new blocks behave like their templates with the overrides, and vanilla's
// states are where they were.
content_root_loads_with_every_table :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-content-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = ruby_mod(&scratch.join("ruby"));
    // The base as a relative path (cargo runs tests in the crate's folder):
    // the overlay's links still resolve.
    // rust: let relative = Path::new("../../.local/horizon-client/26.3");
    // rust: let root = resource_root(relative, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: assert_ne!(root, base);

    // rust: let vanilla = Assets::load(&base).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let (old, new) = (vanilla.registry, assets.registry);
    // rust: let n = old.len() as u32;
    // rust: let iron = old.default_state("minecraft:iron_block").unwrap();
    // rust: let door = old.default_state("minecraft:oak_door").unwrap();
    // rust: let door_first = (0..n)
    // rust: .map(BlockStateId)
    // rust: .find(|&s| old.state(s).unwrap().name == "minecraft:oak_door")
    // rust: .unwrap();
    // Vanilla keeps its ids; blocks come after, sorted: ruby_block, ruby_door, ruby_glass.
    // rust: assert_eq!(new.len(), old.len() + 1 + 64 + 1);
    // rust: assert_eq!(new.default_state("minecraft:iron_block"), Some(iron));
    // rust: let ruby = new.default_state("ruby:ruby_block").unwrap();
    // rust: assert_eq!(ruby, BlockStateId(n));
    // rust: let ruby_door = new.default_state("ruby:ruby_door").unwrap();
    // rust: assert_eq!(ruby_door, BlockStateId(n + 1 + (door.0 - door_first.0)));
    // rust: assert_eq!(
    // rust: new.default_state("ruby:ruby_glass"),
    // rust: Some(BlockStateId(n + 65))
    // rust: );
    // Network ids: the new items and blocks follow vanilla's in the registries report, which
    // the game and its server both read (a missing one travels as air).
    // rust: let report = |root: &Path| {
    // rust: horizon_protocol::registry::Builtin::load(&root.join("registries.json")).unwrap()
}
    // rust: let (vanilla_ids, ids) = (report(&base), report(&root));
    // rust: let item = |b: &horizon_protocol::registry::Builtin, name: &str| {
    // rust: b.get("minecraft:item").and_then(|r| r.id(name))
}
    // rust: let vanilla_items = (0..)
    // rust: .take_while(|&i| vanilla_ids.get("minecraft:item").unwrap().name(i).is_some())
    // rust: .count() as i32;
    // rust: assert_eq!(
    // rust: item(&ids, "minecraft:stone"),
    // rust: item(&vanilla_ids, "minecraft:stone")
    // rust: );
    // rust: let ruby_item = item(&ids, "ruby:ruby_block").unwrap();
    // rust: assert!(ruby_item >= vanilla_items, "{ruby_item} < {vanilla_items}");
    // rust: assert_eq!(
    // rust: ids.get("minecraft:item").unwrap().name(ruby_item),
    // rust: Some("ruby:ruby_block")
    // rust: );
    // rust: assert!(item(&ids, "ruby:ruby_glass").is_none(), "no item declared");
    // rust: assert!(
    // rust: ids.get("minecraft:block")
    // rust: .unwrap()
    // rust: .id("ruby:ruby_glass")
    // rust: .is_some()
    // rust: );

    // rust: let old_facts = BlockFacts::load(&base, old).unwrap();
    // rust: let facts = BlockFacts::load(&root, new).unwrap();
    // rust: let shared_json: serde_json::Value = serde_json::from_reader(std::io::BufReader::new(
    // rust: fs::File::open(root.join("block-behaviours.json")).unwrap(),
    // rust: ))
    // rust: .unwrap();
    // rust: let (shared_facts, shared_behaviours) =
    // rust: BlockFacts::load_with_behaviours(&root, new, &shared_json).unwrap();
    // rust: let independent_behaviours = horizon_world::level::Behaviours::load(new, &root).unwrap();
    // rust: let (deferred_facts, gameplay) =
    // rust: BlockFacts::load_with_projection(&root, new, &shared_json, true).unwrap();
    // rust: let deferred_behaviours =
    // rust: horizon_world::level::Behaviours::load_with_gameplay(new, &root, &shared_json, &gameplay)
    // rust: .unwrap();
    // rust: assert_eq!(shared_facts.states.len(), facts.states.len());
    // `random_ticks` makes the block tick randomly although its template (iron) never does; the
    // sections' counts read the same flag (`random_tick_candidate`).
    // rust: assert!(independent_behaviours.is_randomly_ticking(ruby));
    // rust: assert!(independent_behaviours.random_tick_candidate(ruby));
    // rust: assert!(!independent_behaviours.is_randomly_ticking(iron));
    // rust: assert!(deferred_behaviours.is_randomly_ticking(ruby));
    // `occludes: false` (noOcclusion): the iron-template block occludes nothing, iron still does.
    // rust: assert!(!facts.get(ruby).can_occlude && !facts.get(ruby).solid_render);
    // Its light dampening is a non-solid full block's, as leaves' and spawners' are (iron's is 15).
    // rust: assert_eq!(
    // rust: (facts.get(ruby).dampening, facts.get(iron).dampening),
    // rust: (1, 15)
    // rust: );
    // rust: assert!(facts.get(iron).can_occlude && facts.get(iron).solid_render);
    // rust: let definitions: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(root.join("render-definitions.json")).unwrap()).unwrap();
    // rust: assert_eq!(
    // rust: definitions["ruby:ruby_block"]["can_occlude"], false,
    // rust: "faces beside it are drawn"
    // rust: );
    // rust: assert_eq!(definitions["minecraft:iron_block"]["can_occlude"], true);
    // `render_shape` leaves the glass's model out of the chunk mesh; the block keeps the template's.
    // rust: assert_eq!(
    // rust: facts.get(BlockStateId(n + 65)).render_shape,
    // rust: crate::blocks::RenderShape::Animated
    // rust: );
    // rust: assert_eq!(
    // rust: facts.get(ruby).render_shape,
    // rust: crate::blocks::RenderShape::Model
    // rust: );
    // rust: for state in [ruby, ruby_door, BlockStateId(n + 65)] {
    // rust: assert_eq!(shared_facts.get(state).hardness, facts.get(state).hardness);
    // rust: assert_eq!(
    // rust: deferred_facts.get(state).hardness,
    // rust: facts.get(state).hardness
    // rust: );
    // rust: assert_eq!(deferred_facts.get(state).classes, facts.get(state).classes);
    // rust: assert_eq!(
    // rust: deferred_behaviours.facts(state).flags,
    // rust: independent_behaviours.facts(state).flags
    // rust: );
    // rust: assert_eq!(
    // rust: deferred_behaviours.data(state).sounds.place,
    // rust: independent_behaviours.data(state).sounds.place
    // rust: );
    // rust: assert_eq!(shared_facts.get(state).emission, facts.get(state).emission);
    // rust: assert_eq!(shared_facts.get(state).classes, facts.get(state).classes);
    // rust: assert_eq!(
    // rust: shared_behaviours.facts(state).flags,
    // rust: independent_behaviours.facts(state).flags,
    // rust: );
    // rust: assert_eq!(
    // rust: shared_behaviours.data(state).sounds.place,
    // rust: independent_behaviours.data(state).sounds.place,
    // rust: );
}

    // rust: let (a, b) = (old_facts.get(iron), facts.get(ruby));
    // rust: assert_eq!((b.hardness, b.emission, b.friction), (4.0, 3, 0.8));
    // rust: assert_eq!(b.explosion_resistance, a.explosion_resistance);
    // rust: assert_eq!(b.outline, a.outline);
    // rust: assert_eq!(b.classes, a.classes);
    // rust: assert_eq!(&*b.item, "ruby:ruby_block");
    // rust: assert_eq!(b.map_color, 28);
    // rust: let amethyst = old_facts.get(old.default_state("minecraft:amethyst_block").unwrap());
    // rust: assert_eq!(b.sounds.break_sound, amethyst.sounds.break_sound);
    // rust: for i in 0..64 {
    // rust: let (v, m) = (
    // rust: old_facts.get(BlockStateId(door_first.0 + i)),
    // rust: facts.get(BlockStateId(n + 1 + i)),
    // rust: );
    // rust: assert_eq!(
    // rust: (v.outline.clone(), v.hardness, v.classes.clone()),
    // rust: (m.outline.clone(), m.hardness, m.classes.clone())
    // rust: );
    // rust: assert_eq!(&*m.name, "ruby:ruby_door");
}
    // rust: let glass = facts.get(BlockStateId(n + 65));
    // rust: assert_eq!(&*glass.item, "minecraft:air");
    // Vanilla's own rows are untouched.
    // rust: assert_eq!(facts.get(iron).hardness, a.hardness);
    // rust: assert_eq!(&*facts.get(iron).name, "minecraft:iron_block");

    // rust: let items = Items::load(&root, new, &facts, &PackOverlay::NONE).unwrap();
    // rust: let ruby_block = &items.items["ruby:ruby_block"];
    // rust: assert_eq!(ruby_block.block, Some(ruby));
    // rust: let iron_block = &items.items["minecraft:iron_block"];
    // rust: assert_eq!((ruby_block.max_stack, iron_block.max_stack), (16, 64));
    // rust: assert!(ruby_block.fire_resistant && !iron_block.fire_resistant);
    // rust: let gem = &items.items["ruby:ruby"];
    // rust: assert_eq!(gem.max_stack, 16);
    // rust: let sword = &items.items["ruby:ruby_sword"];
    // rust: let iron_sword = &items.items["minecraft:iron_sword"];
    // rust: assert_eq!((sword.max_damage, iron_sword.max_damage), (900, 250));
    // rust: assert_eq!(sword.modifiers.len(), 1);
    // rust: assert_eq!(sword.modifiers[0].2, 7.0);
    // rust: assert_eq!(sword.tool.len(), iron_sword.tool.len());
    // The stew leaves its bowl in the grid; vanilla's stew leaves none.
    // rust: let stew = &items.items["ruby:ruby_stew"];
    // rust: assert_eq!(stew.crafting_remainder.as_deref(), Some("minecraft:bowl"));
    // rust: assert_eq!(
    // rust: items.items["minecraft:mushroom_stew"].crafting_remainder,
    // rust: None
    // rust: );
    // rust: let recipes = crate::crafting::Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let grid = [
    // rust: Some(crate::items::ItemStack::new("ruby:ruby_stew", 1)),
    // rust: None,
    // rust: None,
    // rust: None,
    // rust: ];
    // rust: let (id, result) = recipes.find(&grid, 2).unwrap();
    // rust: assert_eq!(&*result.item, "ruby:ruby");
    // rust: let rest = recipes.remainders(id, &grid, 2);
    // rust: assert_eq!(rest[0].as_ref().map(|s| &*s.item), Some("minecraft:bowl"));
    // rust: assert!(!items.items.contains_key("ruby:ruby_glass"));
    // rust: let pickaxe = &items.block_tags["minecraft:mineable/pickaxe"];
    // rust: assert!(pickaxe.contains("ruby:ruby_block"));
    // rust: assert!(!pickaxe.contains("ruby:left_out") && !pickaxe.contains("othermod:thing"));
    // rust: assert!(pickaxe.contains("minecraft:stone"));
    // Convention tags load, with the ids nobody registers dropped.
    // rust: assert_eq!(items.item_tag_order["c:gems/ruby"], ["ruby:ruby"]);

    // rust: crate::collisions::load(&root, new).unwrap();
    // rust: crate::models::load_visibility(&root, new).unwrap();
    // rust: crate::light::LightTables::load(&root, new, &facts).unwrap();
    // rust: crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: horizon_world::worldgen::generator::GeneratorData::load(&root.join("worldgen"), new).unwrap();
    // rust: assert!(root.join("assets/ruby/lang/en_us.json").is_file());
    // Blocks without a blockstate of their own take their template's.
    // rust: assert_eq!(
    // rust: fs::read(root.join("assets/ruby/blockstates/ruby_door.json")).unwrap(),
    // rust: fs::read(base.join("assets/minecraft/blockstates/oak_door.json")).unwrap()
    // rust: );

    // The base root was only read.
    // rust: assert!(
    // rust: fs::symlink_metadata(base.join("facts.json"))
    // rust: .unwrap()
    // rust: .is_file()
    // rust: );
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

refuses_unknown_templates_and_vanilla_ids :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-refuse-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let mut m = ruby_mod(&scratch.join("ruby"));
    // rust: m.content.blocks[0].template = "minecraft:not_a_block".into();
    // rust: let e = build(&base, std::slice::from_ref(&m), &scratch.join("out")).unwrap_err();
    // rust: assert!(e.to_string().contains("is not a block"), "{e}");
    // rust: m.content.blocks[0].template = "minecraft:iron_block".into();
    // rust: let stew = m
    // rust: .content
    // rust: .items
    // rust: .iter_mut()
    // rust: .find(|i| i.id == "ruby:ruby_stew");
    // rust: stew.unwrap().crafting_remainder = Some("minecraft:bowll".into());
    // rust: let e = build(&base, std::slice::from_ref(&m), &scratch.join("out")).unwrap_err();
    // rust: assert!(
    // rust: e.to_string()
    // rust: .contains(r#"crafting_remainder "minecraft:bowll" is not an item"#),
    // rust: "{e}"
    // rust: );
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

refuses_more_states_than_a_world_holds :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-states-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let mut m = ruby_mod(&scratch.join("ruby"));
    // Redstone wire has 1296 states: 810 copies pass 2^20 with any game.
    // rust: let mut wire = m.content.blocks[0].clone();
    // rust: wire.template = "minecraft:redstone_wire".into();
    // rust: for i in 0..810 {
    // rust: let mut b = wire.clone();
    // rust: b.id = format!("ruby:wire_{i}");
    // rust: m.content.blocks.push(b);
}
    // rust: let e = build(&base, std::slice::from_ref(&m), &scratch.join("out")).unwrap_err();
    // rust: assert!(
    // rust: e.to_string()
    // rust: .contains("more than the 1048576 a world can hold"),
    // rust: "{e}"
    // rust: );
    // rust: assert!(e.to_string().contains("the mods: ruby "), "{e}");
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

builds_past_sixteen_bit_states :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-wide-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let mut m = ruby_mod(&scratch.join("ruby"));
    // 40 redstone wires: 51,840 states, past 65,536 with vanilla's 35,723.
    // rust: let mut wire = m.content.blocks[0].clone();
    // rust: wire.template = "minecraft:redstone_wire".into();
    // rust: for i in 0..40 {
    // rust: let mut b = wire.clone();
    // rust: b.id = format!("ruby:wire_{i}");
    // rust: m.content.blocks.push(b);
}
    // rust: build(&base, std::slice::from_ref(&m), &scratch.join("out")).unwrap();
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

no_content_keeps_the_base_root :: proc() {
}
    // rust: let base = Path::new("/nonexistent/base");
    // rust: assert_eq!(
    // rust: resource_root(base, &[], Path::new("/nonexistent/cache")).unwrap(),
    // rust: base
    // rust: );
}

// use horizon_world::loot::PackOverlay;
// use horizon_world::registry::BlockStateId;

shared_behaviour_document_matches_independent_loaders :: proc() {
}
    // rust: let Some(root) = prepared() else { return };
    // rust: let assets = Assets::load(&root).expect("assets");
    // rust: let doc: serde_json::Value = serde_json::from_reader(std::io::BufReader::new(
    // rust: std::fs::File::open(root.join("block-behaviours.json")).unwrap(),
    // rust: ))
    // rust: .unwrap();
    // rust: let original = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let (shared, b) = BlockFacts::load_with_behaviours(&root, assets.registry, &doc).unwrap();
    // rust: let (deferred_facts, projection) =
    // rust: BlockFacts::load_with_projection(&root, assets.registry, &doc, true).unwrap();
    // rust: let deferred = horizon_world::level::Behaviours::load_with_gameplay(
    // rust: assets.registry,
    // rust: &root,
    // rust: &doc,
    // rust: &projection,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(deferred_facts.states.len(), shared.states.len());
    // rust: assert_eq!(original.states.len(), shared.states.len());
    // rust: for (a, b) in original.states.iter().zip(&shared.states) {
    // rust: assert_eq!(a.classes, b.classes);
    // rust: assert_eq!(a.legacy_solid, b.legacy_solid);
    // rust: assert_eq!(a.sturdy_full, b.sturdy_full);
    // rust: assert_eq!(a.emission, b.emission);
    // rust: assert_eq!(a.dampening, b.dampening);
    // rust: assert_eq!(a.hardness, b.hardness);
    // rust: assert_eq!(a.sounds.volume, b.sounds.volume);
    // rust: assert_eq!(a.sounds.pitch, b.sounds.pitch);
}
    // rust: let a = horizon_world::level::Behaviours::load(assets.registry, &root).unwrap();
    // rust: for id in 0..assets.registry.len() {
    // rust: let state = horizon_world::registry::BlockStateId(id as u32);
    // rust: let (a_state, b_state) = (a.facts(state), b.facts(state));
    // rust: let deferred_state = deferred.facts(state);
    // rust: assert_eq!(b_state.flags, deferred_state.flags);
    // rust: assert_eq!(b_state.emission, deferred_state.emission);
    // rust: assert_eq!(b_state.dampening, deferred_state.dampening);
    // rust: assert_eq!(b_state.hardness, deferred_state.hardness);
    // rust: assert_eq!(b_state.push, deferred_state.push);
    // rust: assert_eq!(a_state.flags, b_state.flags);
    // rust: assert_eq!(a_state.sturdy, b_state.sturdy);
    // rust: assert_eq!(a_state.weak, b_state.weak);
    // rust: assert_eq!(a_state.strong, b_state.strong);
    // rust: assert_eq!(a_state.fluid, b_state.fluid);
    // rust: assert_eq!(a_state.emission, b_state.emission);
    // rust: assert_eq!(a_state.dampening, b_state.dampening);
    // rust: assert_eq!(a_state.hardness, b_state.hardness);
    // rust: assert_eq!(a_state.push, b_state.push);
    // rust: assert_eq!(a_state.instrument, b_state.instrument);
    // rust: assert_eq!(a_state.shape, b_state.shape);
    // rust: let (a_sound, b_sound) = (&a.data(state).sounds, &b.data(state).sounds);
    // rust: assert_eq!(a_sound.volume, b_sound.volume);
    // rust: assert_eq!(a_sound.pitch, b_sound.pitch);
    // rust: assert_eq!(a_sound.place, b_sound.place);
    // rust: assert_eq!(a_sound.break_, b_sound.break_);
    // rust: assert_eq!(a_sound.fall, b_sound.fall);
}
}

independent_reloads_read_changed_behaviour_json_and_report_invalid_files :: proc() {
}
    // rust: let Some(base) = prepared() else { return };
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-json-reloads-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: fs::create_dir_all(&scratch).unwrap();
    // Keep the remaining resource tree intact without copying a huge prepared client.
    // rust: for entry in fs::read_dir(&base).unwrap() {
    // rust: let entry = entry.unwrap();
    // rust: std::os::unix::fs::symlink(entry.path(), scratch.join(entry.file_name())).unwrap();
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let registry = assets.registry;
    // rust: let original = fs::read(base.join("block-behaviours.json")).unwrap();
    // rust: fs::remove_file(scratch.join("block-behaviours.json")).unwrap();
    // rust: fs::write(scratch.join("block-behaviours.json"), &original).unwrap();
    // Independent facts and behaviours can load first, followed by paired data.
    // rust: let independent_first = BlockFacts::load(&scratch, registry).unwrap();
    // rust: let independent_world_first =
    // rust: horizon_world::level::Behaviours::load(registry, &scratch).unwrap();
    // rust: let (facts, paired_world) = BlockFacts::load_pair(&scratch, registry).unwrap();
    // rust: assert_eq!(facts.states.len(), registry.len());
    // rust: for state in [0, 1, registry.len() - 1] {
    // rust: let state = horizon_world::registry::BlockStateId(state as u32);
    // rust: assert_eq!(
    // rust: facts.get(state).classes,
    // rust: independent_first.get(state).classes
    // rust: );
    // rust: assert_eq!(
    // rust: facts.get(state).sounds.place,
    // rust: independent_first.get(state).sounds.place
    // rust: );
    // rust: assert_eq!(
    // rust: paired_world.facts(state).flags,
    // rust: independent_world_first.facts(state).flags
    // rust: );
}

    // Override one exported state bit at the same path and verify that a later
    // independent and paired read sees it while the original resource root does not.
    // rust: let mut changed: serde_json::Value = serde_json::from_slice(&original).unwrap();
    // rust: let original_bits = changed["states"][0][1].as_u64().unwrap();
    // rust: changed["states"][0][1] = (original_bits ^ 1).into();
    // rust: fs::write(
    // rust: scratch.join("block-behaviours.json"),
    // rust: serde_json::to_vec(&changed).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let changed_pair = BlockFacts::load_pair(&scratch, registry).unwrap();
    // rust: let changed_independent = BlockFacts::load(&scratch, registry).unwrap();
    // rust: let base_facts = BlockFacts::load(&base, registry).unwrap();
    // rust: let state = horizon_world::registry::BlockStateId(0);
    // rust: assert_ne!(
    // rust: changed_pair.0.get(state).legacy_solid,
    // rust: base_facts.get(state).legacy_solid
    // rust: );
    // rust: assert_eq!(
    // rust: changed_pair.0.get(state).legacy_solid,
    // rust: changed_independent.get(state).legacy_solid
    // rust: );
    // The world loader sees the same overridden legacy solidity flag.
    // rust: let changed_world = horizon_world::level::Behaviours::load(registry, &scratch).unwrap();
    // rust: assert_eq!(
    // rust: changed_world.facts(state).flags & 1 != 0,
    // rust: changed_pair.0.get(state).legacy_solid
    // rust: );

    // rust: fs::write(scratch.join("block-behaviours.json"), b"{").unwrap();
    // rust: let paired_error = BlockFacts::load_pair(&scratch, registry)
    // rust: .err()
    // rust: .unwrap()
    // rust: .to_string();
    // rust: let independent_error = BlockFacts::load(&scratch, registry)
    // rust: .err()
    // rust: .unwrap()
    // rust: .to_string();
    // rust: assert_eq!(paired_error, independent_error);
    // rust: assert!(horizon_world::level::Behaviours::load(registry, &scratch).is_err());

    // rust: fs::write(scratch.join("block-behaviours.json"), b"{}").unwrap();
    // rust: assert!(BlockFacts::load_pair(&scratch, registry).is_err());
    // rust: assert!(BlockFacts::load(&scratch, registry).is_err());
    // rust: assert!(horizon_world::level::Behaviours::load(registry, &scratch).is_err());

    // rust: fs::write(scratch.join("block-behaviours.json"), original).unwrap();
    // rust: assert_eq!(
    // rust: BlockFacts::load_pair(&scratch, registry)
    // rust: .unwrap()
    // rust: .0
    // rust: .states
    // rust: .len(),
    // rust: registry.len()
    // rust: );
    // rust: fs::remove_file(scratch.join("gameplay-facts.json")).unwrap();
    // rust: fs::write(scratch.join("gameplay-facts.json"), b"{\"states\":[]}").unwrap();
    // rust: assert!(BlockFacts::load_pair(&scratch, registry).is_err());
    // rust: assert!(BlockFacts::load(&scratch, registry).is_err());
    // rust: assert!(horizon_world::level::Behaviours::load(registry, &scratch).is_err());
    // rust: fs::write(scratch.join("gameplay-facts.json"), b"{").unwrap();
    // rust: assert!(BlockFacts::load_pair(&scratch, registry).is_err());
    // rust: assert!(BlockFacts::load(&scratch, registry).is_err());
    // rust: assert!(horizon_world::level::Behaviours::load(registry, &scratch).is_err());
    // rust: fs::write(
    // rust: scratch.join("gameplay-facts.json"),
    // rust: fs::read(base.join("gameplay-facts.json")).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: BlockFacts::load_pair(&scratch, registry)
    // rust: .unwrap()
    // rust: .0
    // rust: .states
    // rust: .len(),
    // rust: registry.len()
    // rust: );
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// A built root is kept for later starts, and built again when a mod's
// files change.
content_root_is_reused_until_a_mod_changes :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-reuse-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = ruby_mod(&scratch.join("ruby"));
    // rust: let cache = scratch.join("cache");
    // rust: let root = resource_root(&base, std::slice::from_ref(&m), &cache).unwrap();
    // A rebuild starts from an empty folder: this file tells them apart.
    // rust: let sentinel = root.join("sentinel");
    // rust: fs::write(&sentinel, b"").unwrap();
    // rust: assert_eq!(
    // rust: resource_root(&base, std::slice::from_ref(&m), &cache).unwrap(),
    // rust: root
    // rust: );
    // rust: assert!(sentinel.exists(), "an unchanged mod rebuilt the root");
    // rust: let lang = scratch.join("ruby/assets/ruby/lang/en_us.json");
    // rust: fs::write(&lang, r#"{"block.ruby.ruby_block": "Ruby Block"}"#).unwrap();
    // rust: let file = fs::File::options().write(true).open(&lang).unwrap();
    // rust: file.set_modified(std::time::SystemTime::now() + std::time::Duration::from_secs(5))
    // rust: .unwrap();
    // rust: let rebuilt = resource_root(&base, std::slice::from_ref(&m), &cache).unwrap();
    // rust: assert_ne!(rebuilt, root, "a changed mod reused the old root");
    // rust: assert!(
    // rust: fs::read_to_string(rebuilt.join("assets/ruby/lang/en_us.json"))
    // rust: .unwrap()
    // rust: .contains("Ruby Block")
    // rust: );
    // The root a running game was given is never changed under it.
    // rust: assert!(sentinel.exists(), "a changed mod rebuilt the root in place");
    // rust: assert!(
    // rust: fs::read_to_string(root.join("assets/ruby/lang/en_us.json"))
    // rust: .unwrap()
    // rust: .contains("Block of Ruby")
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// A structure mod's worldgen reaches the worldgen loader: its structure,
// set, pool and templates join the bundles, and its biome tag keeps only
// what the loader knows.
content_root_carries_a_structure_mod :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-worldgen-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let dir = scratch.join("huts");
    // rust: let files = [
    // rust: (
    // rust: "horizon-mod.toml",
    // rust: "id = \"huts\"\nname = \"Huts\"\nversion = \"1.0\"\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n",
    // rust: ),
    // rust: (
    // rust: "data/huts/worldgen/structure/hut.json",
    // rust: r##"{"type": "minecraft:jigsaw", "biomes": "#huts:has_hut", "step": "surface_structures",
    // rust: "spawn_overrides": {}, "terrain_adaptation": "beard_thin", "start_pool": "huts:hut/start",
    // rust: "size": 1, "start_height": {"absolute": 0}, "project_start_to_heightmap": "WORLD_SURFACE_WG",
    // rust: "max_distance_from_center": 80}"##,
    // rust: ),
    // rust: (
    // rust: "data/huts/worldgen/template_pool/hut/start.json",
    // rust: r#"{"fallback": "minecraft:empty", "elements": [{"weight": 1, "element": {
    // rust: "element_type": "minecraft:single_pool_element", "location": "huts:hut",
    // rust: "projection": "rigid", "processors": "minecraft:empty"}}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/huts/worldgen/structure_set/huts.json",
    // rust: r#"{"structures": [{"structure": "huts:hut", "weight": 1}],
    // rust: "placement": {"type": "minecraft:random_spread", "salt": 7, "spacing": 4, "separation": 2}}"#,
    // rust: ),
    // rust: (
    // rust: "data/huts/tags/worldgen/biome/has_hut.json",
    // rust: r##"{"values": ["#minecraft:is_overworld", "#c:is_plains", "othermod:glade", "minecraft:plains"]}"##,
    // rust: ),
        // Additions to vanilla's set, pool and processor list; a target nobody
        // defines is skipped. A lower priority goes first.
    // rust: (
    // rust: "data/huts/worldgen/structure_set/added/villages.json",
    // rust: r#"{"horizon:add_to": "minecraft:villages",
    // rust: "structures": [{"structure": "huts:hut", "weight": 3}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/huts/worldgen/template_pool/added/houses.json",
    // rust: r#"{"horizon:add_to": ["othermod:houses", "minecraft:village/plains/houses"],
    // rust: "elements": [{"weight": 2, "element": {"element_type": "minecraft:single_pool_element",
    // rust: "location": "huts:hut", "projection": "rigid", "processors": "minecraft:empty"}}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/huts/worldgen/template_pool/added/more_houses.json",
    // rust: r#"{"horizon:add_to": "minecraft:village/plains/houses", "horizon:priority": 10,
    // rust: "elements": [{"weight": 1, "element": {"element_type": "minecraft:empty_pool_element"}}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/huts/worldgen/processor_list/added/mossy.json",
    // rust: r#"{"horizon:add_to": "minecraft:mossify_10_percent",
    // rust: "processors": [{"processor_type": "minecraft:nop"}]}"#,
    // rust: ),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: let path = dir.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // The template: vanilla's smallest plains house, as the mod's own file.
    // rust: let house =
    // rust: base.join("worldgen/structure/minecraft/village/plains/houses/plains_small_house_1.nbt");
    // rust: fs::create_dir_all(dir.join("data/huts/structure")).unwrap();
    // rust: fs::copy(&house, dir.join("data/huts/structure/hut.nbt")).unwrap();
    // rust: let package = horizon_mods::Package::read(&dir).unwrap();
    // rust: let m = ContentMod {
    // rust: id: "huts".into(),
    // rust: content: Content::read(&dir, &package.manifest).unwrap(),
}
    // rust: let root = resource_root(&base, &[m], &scratch.join("cache")).unwrap();
    // rust: assert!(root.join("worldgen/structure/huts/hut.nbt").exists());
    // rust: let tags: BTreeMap<String, String> =
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/biome_tags.json")).unwrap()).unwrap();
    // rust: let hut: serde_json::Value = serde_json::from_str(&tags["huts:has_hut"]).unwrap();
    // rust: assert_eq!(
    // rust: hut["values"],
    // rust: serde_json::json!(["#minecraft:is_overworld", "minecraft:plains"])
    // rust: );
    // The additions join vanilla's entries at the end and are no set or pool
    // of their own.
    // rust: let bundle = |name: &str, base: &Path| -> BTreeMap<String, String> {
    // rust: serde_json::from_slice(&fs::read(base.join("worldgen").join(name)).unwrap()).unwrap()
}
    // rust: for (name, id, list, added) in [
    // rust: (
    // rust: "structure_sets.json",
    // rust: "minecraft:villages",
    // rust: "structures",
    // rust: vec![serde_json::json!({"structure": "huts:hut", "weight": 3})],
    // rust: ),
    // rust: (
    // rust: "template_pools.json",
    // rust: "minecraft:village/plains/houses",
    // rust: "elements",
    // rust: vec![
    // rust: serde_json::json!({"weight": 1, "element": {"element_type": "minecraft:empty_pool_element"}}),
    // rust: serde_json::json!({"weight": 2, "element": {"element_type": "minecraft:single_pool_element",
    // rust: "location": "huts:hut", "projection": "rigid", "processors": "minecraft:empty"}}),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "processor_lists.json",
    // rust: "minecraft:mossify_10_percent",
    // rust: "processors",
    // rust: vec![serde_json::json!({"processor_type": "minecraft:nop"})],
    // rust: ),
    // rust: ] {
    // rust: let (ours, vanilla) = (bundle(name, &root), bundle(name, &base));
    // rust: let entries = |text: &str| -> Vec<serde_json::Value> {
    // rust: let v: serde_json::Value = serde_json::from_str(text).unwrap();
    // rust: v[list].as_array().unwrap().clone()
}
    // rust: let mut expected = entries(&vanilla[id]);
    // rust: expected.extend(added);
    // rust: assert_eq!(entries(&ours[id]), expected, "{id}");
    // rust: assert!(!ours.keys().any(|k| k.starts_with("huts:added/")), "{name}");
    // rust: assert!(!ours.contains_key("othermod:houses"));
}

    // The commands suggest the mod's structure, set and pool.
    // rust: let registries: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(root.join("command-registries.json")).unwrap()).unwrap();
    // rust: for (registry, id) in [
    // rust: ("minecraft:worldgen/structure", "huts:hut"),
    // rust: ("minecraft:worldgen/structure_set", "huts:huts"),
    // rust: ("minecraft:worldgen/template_pool", "huts:hut/start"),
    // rust: ] {
    // rust: let ids = registries["by_registry"][registry]["ids"]
    // rust: .as_array()
    // rust: .unwrap();
    // rust: assert!(ids.iter().any(|v| v == id), "{registry} lacks {id}");
    // rust: assert!(
    // rust: ids.iter()
    // rust: .any(|v| v.as_str().unwrap().starts_with("minecraft:"))
    // rust: );
}

    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let terrain = crate::vanillagen::VanillaTerrain::new(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap();
    // rust: let (name, at) = terrain
    // rust: .locate(&["huts:hut".to_owned()], [0, 64, 0], 16)
    // rust: .expect("the mod's structure generates");
    // rust: assert_eq!(name, "huts:hut");
    // rust: assert!(at[0].abs() < 1024 && at[2].abs() < 1024, "{at:?}");
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// `FlatLevelSource.createState`: a superflat world runs the structure sets its
// `structure_overrides` allow (the classic flat world: strongholds and villages) on its
// flat ground, and no other set, with the layers where the terrain would be.
a_superflat_world_runs_its_structure_sets_on_flat_ground :: proc() {
}
//     use crate::streaming::ChunkGenerator;
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let flat = horizon_world::worldgen::generator::FlatSettings {
    // rust: layers: vec![
    // rust: ("minecraft:bedrock".into(), 1),
    // rust: ("minecraft:dirt".into(), 2),
    // rust: ("minecraft:grass_block".into(), 1),
    // rust: ],
    // rust: biome: "minecraft:plains".into(),
    // rust: structure_overrides: Some(vec![
    // rust: "minecraft:strongholds".into(),
    // rust: "minecraft:villages".into(),
    // rust: ]),
    // rust: features: false,
    // rust: lakes: false,
}
    // rust: let terrain = crate::vanillagen::VanillaTerrain::for_flat(
    // rust: &base.join("worldgen"),
    // rust: &Default::default(),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: &flat,
    // rust: true,
    // rust: )
    // rust: .unwrap();
    // A village and a stronghold are found; a mineshaft is not in the overrides.
    // rust: let village = terrain.locate(&["minecraft:village_plains".to_owned()], [0, 64, 0], 12);
    // rust: assert!(village.is_some(), "no plains village near the origin");
    // rust: assert!(
    // rust: terrain
    // rust: .locate(&["minecraft:stronghold".to_owned()], [0, 64, 0], 12)
    // rust: .is_some()
    // rust: );
    // rust: assert!(
    // rust: terrain
    // rust: .locate(&["minecraft:mineshaft".to_owned()], [0, 64, 0], 12)
    // rust: .is_none()
    // rust: );
    // The layers: bedrock, two dirt and grass from the level's minimum Y, air above.
    // rust: let mut worker = terrain.worker();
    // rust: let chunk = terrain.finish(terrain.proto(&mut worker, 3, 3));
    // rust: let name = |y| {
    // rust: let id = chunk.block(3 * 16 + 5, y, 3 * 16 + 7);
    // rust: assets.registry.state(id).unwrap().name.clone()
}
    // rust: assert_eq!(
    // rust: [-65, -64, -63, -62, -61, -60].map(name),
    // rust: [
    // rust: "minecraft:air",
    // rust: "minecraft:bedrock",
    // rust: "minecraft:dirt",
    // rust: "minecraft:dirt",
    // rust: "minecraft:grass_block",
    // rust: "minecraft:air"
    // rust: ]
    // rust: .map(String::from)
    // rust: );
}

// `adjustGenerationSettings`: the Overworld preset decorates its plains with grass,
// flowers and trees even with no structure set (`structure_overrides: []`, or
// `generate_structures` off), and without `features` the same layers stay bare.
a_decorated_superflat_world_without_structures_grows_its_features :: proc() {
}
//     use crate::streaming::ChunkGenerator;
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // Blocks above the grass (the top layer is at the level's minimum Y + 63) in the
    // chunk at 4, 4 once its 3×3 region is decorated.
    // rust: let above_ground = |features| {
    // rust: let flat = horizon_world::worldgen::generator::FlatSettings {
    // rust: layers: vec![
    // rust: ("minecraft:bedrock".into(), 1),
    // rust: ("minecraft:stone".into(), 59),
    // rust: ("minecraft:dirt".into(), 3),
    // rust: ("minecraft:grass_block".into(), 1),
    // rust: ],
    // rust: biome: "minecraft:plains".into(),
    // rust: structure_overrides: Some(vec![]),
    // rust: features,
    // rust: lakes: false,
}
    // rust: let terrain = crate::vanillagen::VanillaTerrain::for_flat(
    // rust: &base.join("worldgen"),
    // rust: &Default::default(),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: &flat,
    // rust: false,
    // rust: )
    // rust: .unwrap();
    // rust: let mut worker = terrain.worker();
    // rust: let mut region: [_; 9] =
    // rust: std::array::from_fn(|i| terrain.proto(&mut worker, 3 + i as i32 % 3, 3 + i as i32 / 3));
    // rust: terrain.decorate(&mut worker, &mut region);
    // rust: let [_, _, _, _, center, ..] = region;
    // rust: let chunk = terrain.finish(center);
    // rust: let mut found = Vec::new();
    // rust: for y in 0..16 {
    // rust: for z in 64..80 {
    // rust: for x in 64..80 {
    // rust: let name = &assets.registry.state(chunk.block(x, y, z)).unwrap().name;
    // rust: if name != "minecraft:air" {
    // rust: found.push(name.clone());
}
}
}
}
    // rust: found
}
    // rust: let decorated = above_ground(true);
    // rust: assert!(
    // rust: decorated.iter().any(|n| n == "minecraft:short_grass"),
    // rust: "{decorated:?}"
    // rust: );
    // rust: assert_eq!(above_ground(false), Vec::<String>::new());
}

// `createForFlat` searches the stronghold rings with seed 0, so a superflat world's
// strongholds are in the same place on every seed; a layer that is not opaque to
// `MOTION_BLOCKING` is `null`, left out of `buildTerrain` for the fill after the structures.
a_superflat_world_keeps_its_strongholds_on_every_seed_and_leaves_null_layers_for_the_fill :: proc() {
}
//     use crate::streaming::ChunkGenerator;
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let flat = horizon_world::worldgen::generator::FlatSettings {
    // rust: layers: vec![
    // rust: ("minecraft:bedrock".into(), 1),
    // rust: ("minecraft:dirt".into(), 2),
    // rust: ("minecraft:snow".into(), 1),
    // rust: ],
    // rust: biome: "minecraft:plains".into(),
    // rust: structure_overrides: Some(vec!["minecraft:strongholds".into()]),
    // rust: features: false,
    // rust: lakes: false,
}
    // rust: let make = |seed| {
    // rust: crate::vanillagen::VanillaTerrain::for_flat(
    // rust: &base.join("worldgen"),
    // rust: &Default::default(),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: seed,
    // rust: &flat,
    // rust: true,
    // rust: )
    // rust: .unwrap()
}
    // rust: let stronghold = |seed| {
    // rust: make(seed)
    // rust: .locate(&["minecraft:stronghold".to_owned()], [0, 64, 0], 100)
    // rust: .expect("a stronghold")
}
    // rust: assert_eq!(stronghold(1234), stronghold(-987654321));
    // `moveBelowSeaLevel(-63, ChunkGenerator.getMinY() = 0, ..)`: the sea level less 10 is far
    // below the room's height above 0, so the stronghold's top lands at `ySpan + 1` above Y 0
    // (with the level's -64 it would sit 64 blocks lower). The start's box is inflated by 12
    // for the terrain adaptation: the pieces span Y 2 to 36, the box -10 to 48.
    // rust: let (_, at) = stronghold(1234);
    // rust: let starts = make(1234).starts_at(at[0] >> 4, at[2] >> 4);
    // rust: let start = starts
    // rust: .iter()
    // rust: .find(|s| s.name == "minecraft:stronghold")
    // rust: .expect("the stronghold start");
    // rust: assert!(
    // rust: start.bounding_box.min[1] >= -12,
    // rust: "the stronghold sits below the generator's Y 0: {:?}",
    // rust: start.bounding_box
    // rust: );
    // rust: let terrain = make(1234);
    // rust: let mut worker = terrain.worker();
    // rust: let chunk = terrain.finish(terrain.proto(&mut worker, 3, 3));
    // rust: let name = |y| {
    // rust: let id = chunk.block(3 * 16 + 5, y, 3 * 16 + 7);
    // rust: assets.registry.state(id).unwrap().name.clone()
}
    // The snow layer (index 3, y -61) is filled later, not by the terrain.
    // rust: assert_eq!(
    // rust: [-64, -63, -62, -61].map(name),
    // rust: [
    // rust: "minecraft:bedrock",
    // rust: "minecraft:dirt",
    // rust: "minecraft:dirt",
    // rust: "minecraft:air"
    // rust: ]
    // rust: .map(String::from)
    // rust: );
}

// `structure_overrides` is a lenient field: a list naming a structure set that does not exist
// fails to decode and counts as absent, so every set generates.
a_superflat_structure_override_naming_no_set_lets_every_set_generate :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let flat = horizon_world::worldgen::generator::FlatSettings {
    // rust: layers: vec![
    // rust: ("minecraft:bedrock".into(), 1),
    // rust: ("minecraft:dirt".into(), 2),
    // rust: ("minecraft:grass_block".into(), 1),
    // rust: ],
    // rust: biome: "minecraft:plains".into(),
    // rust: structure_overrides: Some(vec!["minecraft:village".into()]),
    // rust: features: false,
    // rust: lakes: false,
}
    // rust: let terrain = crate::vanillagen::VanillaTerrain::for_flat(
    // rust: &base.join("worldgen"),
    // rust: &Default::default(),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: &flat,
    // rust: true,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: terrain
    // rust: .locate(&["minecraft:stronghold".to_owned()], [0, 64, 0], 12)
    // rust: .is_some()
    // rust: );
    // rust: assert!(
    // rust: terrain
    // rust: .locate(&["minecraft:village_plains".to_owned()], [0, 64, 0], 12)
    // rust: .is_some()
    // rust: );
}

// A mod's mob effect gets the network id after vanilla's last, on the game
// and its server alike, and joins the ids `/effect` and its suggestions
// check.
content_root_registers_a_mod_mob_effect :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-effect-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("glow"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("glow", "")),
    // rust: (
    // rust: "data/glow/horizon/mob_effect/radiance.json",
    // rust: r#"{"category": "beneficial", "color": 16773120}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let report = |root: &Path| {
    // rust: horizon_protocol::registry::Builtin::load(&root.join("registries.json")).unwrap()
}
    // rust: let (vanilla, ids) = (report(&base), report(&root));
    // rust: let vanilla = vanilla.get("minecraft:mob_effect").unwrap();
    // rust: let ids = ids.get("minecraft:mob_effect").unwrap();
    // rust: let count = (0..).take_while(|&i| vanilla.name(i).is_some()).count() as i32;
    // rust: assert_eq!(ids.id("glow:radiance"), Some(count));
    // rust: assert_eq!(ids.id("minecraft:speed"), vanilla.id("minecraft:speed"));
    // rust: let commands: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(root.join("command-registries.json")).unwrap()).unwrap();
    // rust: for ids in [
    // rust: &commands["effects"],
    // rust: &commands["by_registry"]["minecraft:mob_effect"]["ids"],
    // rust: ] {
    // rust: let ids = ids.as_array().unwrap();
    // rust: assert!(ids.contains(&"glow:radiance".into()) && ids.contains(&"minecraft:speed".into()));
}
    // rust: assert!(root.join(crate::content_identity::MARKER).exists());
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// A mod that adds only an item still moves the item network ids, so a game
// without it must fail the content check rather than show other items.
content_root_with_only_an_item_checks_its_identity :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-item-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("gem"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("gem", "")),
    // rust: (
    // rust: "data/gem/horizon/item/opal.json",
    // rust: r#"{"template": "minecraft:diamond"}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let ids = horizon_protocol::registry::Builtin::load(&root.join("registries.json")).unwrap();
    // rust: assert!(ids.get("minecraft:item").unwrap().id("gem:opal").is_some());
    // rust: assert!(root.join(crate::content_identity::MARKER).exists());
    // rust: assert_ne!(
    // rust: crate::content_identity::identity(&root).unwrap(),
    // rust: crate::content_identity::identity(&base).unwrap()
    // rust: );
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// a living mod type's row in `entity-types.json` is its template's with
// `template` added and its own attribute bases; every other value keeps the
// template's text, to the digit. An attribute the template lacks is refused.
a_living_mod_types_row_is_its_templates_with_its_attributes :: proc() {
}
    // rust: let zombie = r#"{"width":0.6,"height":1.95,"eye_height":1.74,"category":"monster",
    // rust: "fire_immune":false,"attributes":{"minecraft:max_health":20.0,
    // rust: "minecraft:movement_speed":0.23000000417232513,"minecraft:armor":2.0}}"#;
    // rust: let row = serde_json::value::RawValue::from_string(zombie.to_owned()).unwrap();
    // rust: let ghoul = |attributes: &[(&str, f64)]| EntityType {
    // rust: id: "ruby:ghoul".into(),
    // rust: template: "minecraft:zombie".into(),
    // rust: item: None,
    // rust: damage: 0.0,
    // rust: attributes: attributes
    // rust: .iter()
    // rust: .map(|(a, v)| (a.to_string(), *v))
    // rust: .collect(),
}
    // rust: let written = mod_entity_row(&row, &ghoul(&[("minecraft:max_health", 40.0)])).unwrap();
    // rust: let written: serde_json::Value = serde_json::from_slice(&written).unwrap();
    // rust: let mut expected: serde_json::Value = serde_json::from_str(zombie).unwrap();
    // rust: expected["attributes"]["minecraft:max_health"] = 40.0.into();
    // rust: expected["template"] = "minecraft:zombie".into();
    // rust: assert_eq!(written, expected);
    // the untouched speed keeps the template's text, not a reparsed float.
    // rust: let text = String::from_utf8(mod_entity_row(&row, &ghoul(&[])).unwrap()).unwrap();
    // rust: assert!(text.contains("0.23000000417232513"), "{text}");
    // rust: let e = mod_entity_row(&row, &ghoul(&[("minecraft:flying_speed", 1.0)])).unwrap_err();
    // rust: assert!(e.contains("not one of minecraft:zombie's"), "{e}");
}

// a mod's thrown entity type gets the network id after vanilla's last, the
// commands accept it, and it changes the content identity.
content_root_registers_a_mod_entity_type :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-entity-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("example"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("example", "")),
    // rust: (
    // rust: "data/example/horizon/item/gem.json",
    // rust: r#"{"template": "minecraft:snowball"}"#,
    // rust: ),
    // rust: (
    // rust: "data/example/horizon/entity_type/bolt.json",
    // rust: r#"{"template": "minecraft:snowball", "item": "example:gem", "damage": 2}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let report = |root: &Path| {
    // rust: horizon_protocol::registry::Builtin::load(&root.join("registries.json")).unwrap()
}
    // rust: let (vanilla, ids) = (report(&base), report(&root));
    // rust: let vanilla = vanilla.get("minecraft:entity_type").unwrap();
    // rust: let ids = ids.get("minecraft:entity_type").unwrap();
    // rust: let count = (0..).take_while(|&i| vanilla.name(i).is_some()).count() as i32;
    // rust: assert_eq!(ids.id("example:bolt"), Some(count));
    // rust: assert_eq!(
    // rust: ids.id("minecraft:snowball"),
    // rust: vanilla.id("minecraft:snowball")
    // rust: );
    // rust: let commands: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(root.join("command-registries.json")).unwrap()).unwrap();
    // rust: for ids in [
    // rust: &commands["entity_types"],
    // rust: &commands["by_registry"]["minecraft:entity_type"]["ids"],
    // rust: ] {
    // rust: assert!(ids.as_array().unwrap().contains(&"example:bolt".into()));
}
    // its size and eyes are the snowball's, for `execute anchored eyes` and spawners.
    // rust: let types: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(root.join("entity-types.json")).unwrap()).unwrap();
    // rust: assert!(types["minecraft:snowball"].is_object());
    // rust: let mut bolt = types["example:bolt"].clone();
    // rust: assert_eq!(bolt["template"], "minecraft:snowball");
    // rust: bolt.as_object_mut().unwrap().remove("template");
    // rust: assert_eq!(bolt, types["minecraft:snowball"]);
    // the rewritten table keeps vanilla's floats to the bit (a zombie's speed).
    // rust: let speed = |root: &Path| {
    // rust: let attributes =
    // rust: crate::mobs::exact_attributes(&fs::read(root.join("entity-types.json")).unwrap());
    // rust: attributes["minecraft:zombie"]["minecraft:movement_speed"]
}
    // rust: assert_eq!(speed(&root).to_bits(), speed(&base).to_bits());
    // rust: assert!(root.join(crate::content_identity::MARKER).exists());
    // rust: let identity = crate::content_identity::identity;
    // rust: assert_ne!(identity(&root).unwrap(), identity(&base).unwrap());
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// a mod's menu type gets the menu network id after vanilla's last, and it
// changes the content identity.
content_root_registers_a_mod_menu_type :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-menu-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("example"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("example", "")),
    // rust: (
    // rust: "data/example/horizon/menu/press.json",
    // rust: r#"{"slots": 9, "data_slots": 2, "results": [7, 8]}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let report = |root: &Path| {
    // rust: horizon_protocol::registry::Builtin::load(&root.join("registries.json")).unwrap()
}
    // rust: let (vanilla, ids) = (report(&base), report(&root));
    // rust: let vanilla = vanilla.get("minecraft:menu").unwrap();
    // rust: let ids = ids.get("minecraft:menu").unwrap();
    // rust: let count = (0..).take_while(|&i| vanilla.name(i).is_some()).count() as i32;
    // rust: assert_eq!(ids.id("example:press"), Some(count));
    // rust: assert_eq!(ids.id("minecraft:furnace"), vanilla.id("minecraft:furnace"));
    // rust: assert!(root.join(crate::content_identity::MARKER).exists());
    // rust: let identity = crate::content_identity::identity;
    // rust: assert_ne!(identity(&root).unwrap(), identity(&base).unwrap());
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// A content mod folder from `(path, text)` pairs, read as the game reads it.
folder_mod :: proc(dir: ^Path, files: ^[(string) {
}
    // rust: for (name, text) in files {
    // rust: let path = dir.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let package = horizon_mods::Package::read(dir).unwrap();
    // rust: ContentMod {
    // rust: id: package.manifest.id.clone(),
    // rust: content: Content::read(dir, &package.manifest).unwrap(),
}
}

manifest :: proc(id: string, namespaces: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "id = \"{id}\"\nname = \"{id}\"\nversion = \"1.0\"\napi = \"0.2\"\ncapabilities = [\"registries\"]\nnamespaces = [{namespaces}]\n"
    // rust: )
}

// A mod whose files sit under namespaces besides its id (Towns and Towers'
// `kaisyn`): they join the root, and loaders read those namespaces.
listed_namespaces_join_the_root :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-ns-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let toml = manifest("towers", "\"kaisyn\"");
    // rust: let m = folder_mod(
    // rust: &scratch.join("towers"),
    // rust: &[
    // rust: ("horizon-mod.toml", &toml),
    // rust: (
    // rust: "data/kaisyn/worldgen/processor_list/mossy.json",
    // rust: r#"{"processors": []}"#,
    // rust: ),
    // rust: (
    // rust: "data/kaisyn/tags/worldgen/biome/has_tower.json",
    // rust: r#"{"values": ["minecraft:plains"]}"#,
    // rust: ),
    // rust: (
    // rust: "assets/kaisyn/lang/en_us.json",
    // rust: r#"{"block.kaisyn.x": "X"}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = scratch.join("root");
    // rust: build(&base, &[m], &root).unwrap();
    // rust: assert_eq!(namespaces(&root), ["kaisyn", "towers"]);
    // rust: assert!(tag_namespaces(&root).contains(&"kaisyn".to_owned()));
    // rust: let lists: BTreeMap<String, String> =
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/processor_lists.json")).unwrap())
    // rust: .unwrap();
    // rust: assert!(lists.contains_key("kaisyn:mossy"));
    // rust: let tags: BTreeMap<String, String> =
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/biome_tags.json")).unwrap()).unwrap();
    // rust: assert!(tags.contains_key("kaisyn:has_tower"));
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// A mod's `assets/minecraft/atlases/blocks.json` adds its sources after vanilla's.
a_content_root_appends_a_mods_atlas_sources :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-atlas-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("gauge"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("gauge", "")),
    // rust: (
    // rust: "assets/minecraft/atlases/blocks.json",
    // rust: r#"{"sources": [{"type": "minecraft:directory", "source": "gauge_liquid", "prefix": "gauge_liquid/"}]}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = scratch.join("root");
    // rust: build(&base, &[m], &root).unwrap();
    // rust: let sources = |dir: &Path| -> Vec<serde_json::Value> {
    // rust: let text = fs::read(dir.join("assets/minecraft/atlases/blocks.json")).unwrap();
    // rust: let doc: serde_json::Value = serde_json::from_slice(&text).unwrap();
    // rust: doc["sources"].as_array().unwrap().clone()
}
    // rust: let (vanilla, built) = (sources(&base), sources(&root));
    // rust: assert_eq!(built.len(), vanilla.len() + 1);
    // rust: assert_eq!(built[..vanilla.len()], vanilla[..]);
    // rust: assert_eq!(built[vanilla.len()]["source"], "gauge_liquid");
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// Two mods owning one namespace (one's listed namespace is the other's id,
// or both list it) are refused together, naming both.
mods_sharing_a_namespace_are_refused :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-clash-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let towers = folder_mod(
    // rust: &scratch.join("towers"),
    // rust: &[("horizon-mod.toml", &manifest("towers", "\"kaisyn\""))],
    // rust: );
    // rust: let kaisyn = folder_mod(
    // rust: &scratch.join("kaisyn"),
    // rust: &[("horizon-mod.toml", &manifest("kaisyn", ""))],
    // rust: );
    // rust: let other = folder_mod(
    // rust: &scratch.join("other"),
    // rust: &[("horizon-mod.toml", &manifest("other", "\"kaisyn\""))],
    // rust: );
    // The check runs before the base is read.
    // rust: let base = scratch.join("no-base");
    // rust: let out = scratch.join("root");
    // rust: let e = build(&base, &[towers, kaisyn], &out).unwrap_err();
    // rust: assert_eq!(
    // rust: e.to_string(),
    // rust: "mods towers and kaisyn both use the namespace kaisyn; turn one of them off"
    // rust: );
    // rust: let towers = folder_mod(
    // rust: &scratch.join("towers"),
    // rust: &[("horizon-mod.toml", &manifest("towers", "\"kaisyn\""))],
    // rust: );
    // rust: let e = build(&base, &[towers, other], &out).unwrap_err();
    // rust: assert!(e.to_string().starts_with("mods towers and other"), "{e}");
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// Mods merge into a tag in load order, as data packs do: each adds its
// values, and one that replaces drops what came before it, with a warning
// naming what it dropped.
tags_merge_in_load_order_and_replace_warns :: proc() {
}
    // rust: let v = |ids: &[&str]| -> Vec<J> { ids.iter().map(|i| J::Str((*i).into())).collect() };
    // rust: let file = "data/minecraft/tags/worldgen/biome/has_structure/village_plains.json";
    // rust: let mut merge = TagMerge::default();
    // rust: assert_eq!(merge.add("a", file, false, true, &v(&["a:x"])), None);
    // rust: let warning = merge.add("b", file, true, true, &v(&["minecraft:plains"]));
    // rust: assert_eq!(
    // rust: warning.as_deref(),
    // rust: Some(
    // rust: "mod b replaces data/minecraft/tags/worldgen/biome/has_structure/village_plains.json: \
    // rust: vanilla's entries and those of a are left out, as a data pack's replace does; \
    // rust: the mods after it in load order still add to it"
    // rust: )
    // rust: );
    // rust: assert_eq!(merge.add("c", file, false, true, &v(&["c:y"])), None);
    // rust: assert!(merge.replaced);
    // rust: assert_eq!(merge.values, v(&["minecraft:plains", "c:y"]));
    // A second replace drops only the mods' entries.
    // rust: let warning = merge.add("d", file, true, true, &v(&["d:z"])).unwrap();
    // rust: assert!(
    // rust: warning.contains(": those of b, c are left out"),
    // rust: "{warning}"
    // rust: );
    // rust: assert_eq!(merge.values, v(&["d:z"]));
    // A mod replacing a tag of its own that nobody added to drops nothing.
    // rust: let own = "data/a/tags/item/gems.json";
    // rust: assert_eq!(
    // rust: TagMerge::default().add("a", own, true, false, &v(&["a:x"])),
    // rust: None
    // rust: );
}

// A replacing mod's tag leaves vanilla's entries out of the tag file and of
// the worldgen loader's biome tags, and the root keeps the warning for the
// starts that reuse it.
a_replacing_mod_tag_reaches_the_root :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-replace-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let file = "data/minecraft/tags/worldgen/biome/has_structure/village_plains.json";
    // rust: let adds = folder_mod(
    // rust: &scratch.join("adds"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("adds", "")),
    // rust: (file, r#"{"values": ["minecraft:forest"]}"#),
    // rust: ],
    // rust: );
    // rust: let towns = folder_mod(
    // rust: &scratch.join("towns"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("towns", "")),
    // rust: (file, r#"{"replace": true, "values": ["minecraft:plains"]}"#),
    // rust: ],
    // rust: );
    // rust: let late = folder_mod(
    // rust: &scratch.join("late"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("late", "")),
    // rust: (file, r#"{"values": ["minecraft:savanna"]}"#),
    // rust: ],
    // rust: );
    // rust: let vanilla: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(base.join(file)).unwrap()).unwrap();
    // rust: assert!(vanilla["values"].as_array().unwrap().len() > 1, "{vanilla}");
    // rust: let root = resource_root(&base, &[adds, towns, late], &scratch.join("cache")).unwrap();
    // rust: let expected = serde_json::json!(["minecraft:plains", "minecraft:savanna"]);
    // rust: let tag: serde_json::Value =
    // rust: serde_json::from_slice(&fs::read(root.join(file)).unwrap()).unwrap();
    // rust: assert_eq!(tag["values"], expected);
    // rust: let tags: BTreeMap<String, String> =
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/biome_tags.json")).unwrap()).unwrap();
    // rust: let bundled: serde_json::Value =
    // rust: serde_json::from_str(&tags["minecraft:has_structure/village_plains"]).unwrap();
    // rust: assert_eq!(bundled["values"], expected);
    // rust: let warnings = fs::read_to_string(root.join(WARNINGS)).unwrap();
    // rust: assert!(
    // rust: warnings.starts_with("mod towns replaces data/minecraft/tags/worldgen/biome/has_structure/village_plains.json: vanilla's entries and those of adds are left out"),
    // rust: "{warnings}"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// `StructureCheck.onStructureLoad`: the references a chunk saved for its start
// count, so a map skips a start a vanilla map already pointed at.
exploration_maps_skip_the_starts_a_chunk_saved_as_referenced :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let terrain = crate::vanillagen::VanillaTerrain::new(
    // rust: &base.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap();
    // rust: let names = ["minecraft:buried_treasure".to_owned()];
    // rust: let first = terrain
    // rust: .locate_for_map(&names, [0, 64, 0], 50, true)
    // rust: .unwrap();
    // Another terrain, on the same seed, whose chunks saved one reference for it.
    // rust: let fresh = crate::vanillagen::VanillaTerrain::new(
    // rust: &base.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap();
    // rust: let (name, at) = (first.0.clone(), (first.1[0] >> 4, first.1[2] >> 4));
    // rust: fresh.set_saved_references(std::sync::Arc::new(move |n, x, z| {
    // rust: i32::from(n == name && (x, z) == at)
    // rust: }));
    // rust: let next = fresh.locate_for_map(&names, [0, 64, 0], 50, true).unwrap();
    // rust: assert_ne!(next.1, first.1, "the saved reference is skipped");
    // rust: assert_eq!(
    // rust: fresh.locate_for_map(&names, [0, 64, 0], 50, false).unwrap(),
    // rust: first,
    // rust: "a map that does not skip still finds it"
    // rust: );
}

// `ChunkGenerator.findNearestMapStructure` with `createReference`: an
// exploration map that skips known structures points at a start no map
// pointed at before, and a reopened world remembers which.
exploration_maps_skip_the_structures_maps_pointed_at :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-map-refs-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let open = || {
    // rust: let terrain = crate::vanillagen::VanillaTerrain::new(
    // rust: &base.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap();
    // rust: terrain.set_reference_file(scratch.join("refs.json"));
    // rust: terrain
}
    // rust: let names = ["minecraft:buried_treasure".to_owned()];
    // rust: let terrain = open();
    // rust: let first = terrain
    // rust: .locate_for_map(&names, [0, 64, 0], 50, true)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: terrain.locate(&names, [0, 64, 0], 50).unwrap(),
    // rust: first,
    // rust: "/locate still finds the nearest"
    // rust: );
    // rust: let second = terrain
    // rust: .locate_for_map(&names, [0, 64, 0], 50, true)
    // rust: .unwrap();
    // rust: assert_ne!(second.1, first.1, "the second map points elsewhere");
    // rust: let again = terrain
    // rust: .locate_for_map(&names, [0, 64, 0], 50, false)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: again, first,
    // rust: "without skipping the nearest is still the first"
    // rust: );
    // rust: drop(terrain);
    // rust: let third = open().locate_for_map(&names, [0, 64, 0], 50, true).unwrap();
    // rust: assert!(
    // rust: third.1 != first.1 && third.1 != second.1,
    // rust: "a reopened world remembers {first:?} and {second:?}, found {third:?}"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// `NoiseBasedChunkGenerator.addDebugScreenInfo`: F3's `Density` line lists
// the noise settings' `debug_functions` with three decimals.
debug_density_line_lists_the_noise_settings_functions :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let terrain = crate::vanillagen::VanillaTerrain::new(
    // rust: &base.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap();
    // rust: let line = terrain.density_debug_line([0, 70, 0]).unwrap();
    // rust: let labels: Vec<&str> = line
    // rust: .strip_prefix("Density ")
    // rust: .unwrap()
    // rust: .split(' ')
    // rust: .step_by(2)
    // rust: .collect();
    // rust: assert_eq!(
    // rust: labels,
    // rust: ["N:", "T:", "V:", "C:", "E:", "D:", "W:", "PV:", "PS:"],
    // rust: "{line}"
    // rust: );
    // rust: assert!(
    // rust: line.split(' ')
    // rust: .skip(2)
    // rust: .step_by(2)
    // rust: .all(|v| v.split('.').nth(1).is_some_and(|d| d.len() == 3)),
    // rust: "{line}"
    // rust: );
}

content_shapes_drive_outline_and_collision :: proc() {
}
//     use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3},
    // rust: position::BlockPos,
}
//     use horizon_world::{collision::CachedCollisionRegistry, registry::BlockStateId};
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch =
    // rust: std::env::temp_dir().join(format!("horizon-content-shapes-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("mod"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("shapetest", "")),
    // rust: (
    // rust: "data/shapetest/horizon/block/rod.json",
    // rust: r#"{"template":"minecraft:oak_log","shapes":{"property":"axis","values":{"x":[[0,0.25,0.25,1,0.75,0.75]],"y":[[0.25,0,0.25,0.75,1,0.75]],"z":[[0.25,0.25,0,0.75,0.75,1]]}}}"#,
    // rust: ),
    // rust: (
    // rust: "data/shapetest/horizon/block/plain.json",
    // rust: r#"{"template":"minecraft:oak_log"}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, &[m], &scratch.join("cache")).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = BlockFacts::load(&root, registry).unwrap();
    // rust: let (named, _) = nbt::read_named(
    // rust: &fs::read(root.join("cached-collision.nbt")).unwrap(),
    // rust: Limits::tables(),
    // rust: )
    // rust: .unwrap();
    // rust: let collision = CachedCollisionRegistry::from_nbt(&named.tag, registry).unwrap();
    // rust: for axis in ["x", "y", "z"] {
    // rust: let state = (0..registry.len())
    // rust: .map(|i| BlockStateId(i as u32))
    // rust: .find(|id| {
    // rust: let s = registry.state(*id).unwrap();
    // rust: s.name == "shapetest:rod" && s.properties.get("axis").is_some_and(|v| v == axis)
    // rust: })
    // rust: .unwrap();
    // rust: let shape = collision.cached_shape(state).unwrap().unwrap();
    // rust: let f = facts.get(state);
    // rust: assert_eq!(shape.boxes().len(), 1);
    // rust: assert_eq!(f.outline.len(), 1);
    // rust: assert_eq!(f.outline_edges.len(), 12);
    // rust: let expected = match axis {
    // rust: "x" => [0., 0.25, 0.25, 1., 0.75, 0.75],
    // rust: "y" => [0.25, 0., 0.25, 0.75, 1., 0.75],
    // rust: _ => [0.25, 0.25, 0., 0.75, 0.75, 1.],
}
    // rust: assert_eq!(f.outline[0], expected);
    // rust: let start = Vec3::new(-1., 0.5, 0.5);
    // rust: let end = Vec3::new(2., 0.5, 0.5);
    // rust: let target = BlockPos::new(0, 0, 0);
    // rust: assert!(shape.clip(start, end, target).is_some());
    // rust: let bounds = f.outline[0];
    // rust: let outline = Aabb::new(
    // rust: Vec3::new(bounds[0], bounds[1], bounds[2]),
    // rust: Vec3::new(bounds[3], bounds[4], bounds[5]),
    // rust: );
    // rust: assert_eq!(
    // rust: shape.clip(start, end, target),
    // rust: Aabb::clip_boxes([outline], start, end, target)
    // rust: );
    // rust: let player = Aabb::new(Vec3::new(-1., 0.4, 0.4), Vec3::new(-0.2, 0.6, 0.6));
    // rust: assert!((shape.collide(Axis::X, player, 2.) - (expected[0] + 0.2)).abs() < 1e-9);
    // rust: let miss = Aabb::new(Vec3::new(-1., 0.05, 0.05), Vec3::new(-0.2, 0.15, 0.15));
    // rust: assert_eq!(shape.collide(Axis::X, miss, 2.), 2.);
}
    // rust: let plain = registry.default_state("shapetest:plain").unwrap();
    // rust: let oak = registry.default_state("minecraft:oak_log").unwrap();
    // rust: assert_eq!(facts.get(plain).outline, facts.get(oak).outline);
    // rust: assert_eq!(
    // rust: collision.cached_shape(plain).unwrap().unwrap().boxes(),
    // rust: collision.cached_shape(oak).unwrap().unwrap().boxes()
    // rust: );
    // rust: fs::remove_dir_all(scratch).unwrap();
}

content_block_default_state_is_validated_and_overlaid :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-default-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let base = scratch.join("base");
    // rust: fs::create_dir_all(&base).unwrap();
    // rust: let facts = r#"{"states":[
    // rust: ["minecraft:piston",false,false,"",{"id":"minecraft:piston","properties":{"facing":"up","extended":"false"}}],
    // rust: ["minecraft:piston",false,false,"",{"id":"minecraft:piston","properties":{"facing":"north","extended":"false"}}],
    // rust: ["minecraft:piston",false,false,"",{"id":"minecraft:piston","properties":{"facing":"north","extended":"true"}}]],
    // rust: "defaults":{"minecraft:piston":0}}"#;
    // rust: fs::write(base.join("facts.json"), facts).unwrap();
    // rust: fs::write(base.join("gameplay-facts.json"), r#"{"states":[{"item":"minecraft:piston"},{"item":"minecraft:piston"},{"item":"minecraft:piston"}]}"#).unwrap();
    // rust: fs::write(base.join("items.json"), r#"{"minecraft:piston":{}}"#).unwrap();
    // rust: fs::write(base.join("registries.json"), r#"{"minecraft:item":{"entries":{"minecraft:piston":{"protocol_id":0}}},"minecraft:block":{"entries":{"minecraft:piston":{"protocol_id":0}}}}"#).unwrap();
    // rust: for (declaration, expected) in [
    // rust: (r#"{"template":"minecraft:piston"}"#, Some(3)),
    // rust: (
    // rust: r#"{"template":"minecraft:piston","default_state":{"facing":"north"}}"#,
    // rust: Some(4),
    // rust: ),
    // rust: (
    // rust: r#"{"template":"minecraft:piston","default_state":{"facing":"north","extended":"true"}}"#,
    // rust: Some(5),
    // rust: ),
    // rust: (
    // rust: r#"{"template":"minecraft:piston","default_state":{"facing":"sideways"}}"#,
    // rust: None,
    // rust: ),
    // rust: (
    // rust: r#"{"template":"minecraft:piston","default_state":{"direction":"north"}}"#,
    // rust: None,
    // rust: ),
    // rust: ] {
    // rust: let m = folder_mod(
    // rust: &scratch.join("mod"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("testmod", "")),
    // rust: ("data/testmod/horizon/block/test.json", declaration),
    // rust: ],
    // rust: );
    // rust: let mods = [m];
    // rust: match (Plan::new(&base, &mods), expected) {
    // rust: (Ok(plan), Some(id)) => {
    // rust: let mut doc: J = serde_json::from_str(facts).unwrap();
    // rust: plan.json("facts.json", &mut doc).unwrap();
    // rust: assert_eq!(
    // rust: doc.get("defaults").unwrap().get("testmod:test"),
    // rust: Some(&J::Num(id.into()))
    // rust: );
}
    // rust: (Err(e), None) => assert!(e.to_string().contains("testmod:test"), "{e}"),
    // rust: _ => panic!("unexpected result for {declaration}"),
}
}
    // A malformed registry with duplicate states must not choose one silently.
    // rust: let duplicate = facts.replace(
    // rust: r#"["minecraft:piston",false,false,"",{"id":"minecraft:piston","properties":{"facing":"north","extended":"true"}}]"#,
    // rust: r#"["minecraft:piston",false,false,"",{"id":"minecraft:piston","properties":{"facing":"north","extended":"false"}}]"#,
    // rust: );
    // rust: fs::write(base.join("facts.json"), duplicate).unwrap();
    // rust: let m = folder_mod(
    // rust: &scratch.join("mod"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("testmod", "")),
    // rust: (
    // rust: "data/testmod/horizon/block/test.json",
    // rust: r#"{"template":"minecraft:piston","default_state":{"facing":"north"}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let error = match Plan::new(&base, &[m]) {
    // rust: Err(e) => e.to_string(),
    // rust: Ok(_) => panic!("duplicate states accepted"),
}
    // rust: assert!(error.contains("matches 2 states"), "{error}");
    // rust: fs::remove_dir_all(scratch).unwrap();
}

shapes_reject_unknown_or_missing_template_values :: proc() {
}
    // rust: let Some(base) = prepared() else { return };
    // rust: let scratch =
    // rust: std::env::temp_dir().join(format!("horizon-shape-invalid-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: for declaration in [
    // rust: r#"{"template":"minecraft:oak_log","shapes":{"property":"typo","values":{"x":[]}}}"#,
    // rust: r#"{"template":"minecraft:oak_log","shapes":{"property":"axis","values":{"x":[]}}}"#,
    // rust: r#"{"template":"minecraft:oak_log","shapes":{"property":"axis","values":{"x":[],"y":[],"z":[],"bad":[]}}}"#,
    // rust: ] {
    // rust: let m = folder_mod(
    // rust: &scratch.join("mod"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("shapetest", "")),
    // rust: ("data/shapetest/horizon/block/rod.json", declaration),
    // rust: ],
    // rust: );
    // rust: let mods = [m];
    // rust: let e = match Plan::new(&base, &mods) {
    // rust: Ok(_) => panic!("accepted {declaration}"),
    // rust: Err(e) => e.to_string(),
}
    // rust: assert!(e.contains("shapetest:rod"), "{e}");
}
    // rust: fs::remove_dir_all(scratch).unwrap();
}

// A connecting block (template `minecraft:chorus_plant`, `connects_to` a
// tag) joins itself and its tag's blocks on each side, needs no support, and
// leaves vanilla's chorus plant as it was.
connecting_blocks_join_themselves_and_their_tag :: proc() {
}
//     use horizon_core::position::BlockPos;
//     use horizon_core::random::LegacyRandom;
//     use horizon_world::level::{Behaviours, LevelAccess, Ticks};
//     use std::collections::HashMap;

    // rust: let Some(_) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-pipe-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let dir = scratch.join("cable");
    // rust: for (name, text) in [
    // rust: (
    // rust: "horizon-mod.toml",
    // rust: "id = \"cable\"\nname = \"Cable\"\nversion = \"0.1.0\"\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n",
    // rust: ),
    // rust: (
    // rust: "data/cable/horizon/block/tin_cable.json",
    // rust: r##"{"template": "minecraft:chorus_plant", "connects_to": "#cable:joins", "thickness": 4}"##,
    // rust: ),
    // rust: (
    // rust: "data/cable/horizon/block/machine.json",
    // rust: r#"{"template": "minecraft:iron_block"}"#,
    // rust: ),
    // rust: (
    // rust: "data/cable/tags/block/joins.json",
    // rust: r#"{"values": ["cable:machine"]}"#,
    // rust: ),
    // rust: ] {
    // rust: let path = dir.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let package = horizon_mods::Package::read(&dir).unwrap();
    // rust: let m = ContentMod {
    // rust: id: "cable".into(),
    // rust: content: Content::read(&dir, &package.manifest).unwrap(),
}
    // rust: let relative = Path::new("../../.local/horizon-client/26.3");
    // rust: let root = resource_root(relative, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let b = Behaviours::load(registry, &root).unwrap();

Level :: struct {
    blocks: HashMap<BlockPos,
    air: BlockStateId,
    random: LegacyRandom,
}
    // rust: impl LevelAccess for Level {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.get(&pos).copied().unwrap_or(self.air)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.blocks.insert(pos, state).unwrap_or(self.air))
}
is_loaded :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.random
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
}
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let mut level = Level {
    // rust: blocks: HashMap::new(),
    // rust: air,
    // rust: random: LegacyRandom::new(1),
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: ticks
    // rust: .add_empty_chunk(horizon_core::position::ChunkPos::new(0, 0))
    // rust: .unwrap();
    // rust: let sides = |state: BlockStateId| {
    // rust: let s = registry.state(state).unwrap();
    // rust: ["down", "up", "north", "south", "west", "east"]
    // rust: .into_iter()
    // rust: .filter(|k| s.properties.get(*k).map(String::as_str) == Some("true"))
    // rust: .collect::<Vec<_>>()
}
    // rust: let at = |x, y, z| BlockPos::new(x, y, z);
    // rust: let machine = registry.default_state("cable:machine").unwrap();
    // rust: let cable = registry.default_state("cable:tin_cable").unwrap();
    // A cable beside a machine (in its tag) and a stone joins the machine only,
    // and floats: no chorus plant support.
    // rust: b.set_block(&mut level, &mut ticks, at(1, 64, 0), machine, 3);
    // rust: b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: at(-1, 64, 0),
    // rust: registry.default_state("minecraft:stone").unwrap(),
    // rust: 3,
    // rust: );
    // rust: let placed = b.update_from_neighbour_shapes(&mut level, &mut ticks, at(0, 64, 0), cable);
    // rust: b.set_block(&mut level, &mut ticks, at(0, 64, 0), placed, 3);
    // rust: assert_eq!(sides(level.block_state(at(0, 64, 0))), ["east"]);
    // rust: assert!(b.can_survive(&mut level, &mut ticks, at(0, 64, 0), placed));
    // A second cable above: both join, through the neighbour's shape update.
    // rust: let above = b.update_from_neighbour_shapes(&mut level, &mut ticks, at(0, 65, 0), cable);
    // rust: b.set_block(&mut level, &mut ticks, at(0, 65, 0), above, 3);
    // rust: assert_eq!(sides(level.block_state(at(0, 65, 0))), ["down"]);
    // rust: assert_eq!(sides(level.block_state(at(0, 64, 0))), ["up", "east"]);
    // The machine gone: the arm goes too.
    // rust: b.set_block(&mut level, &mut ticks, at(1, 64, 0), air, 3);
    // rust: assert_eq!(sides(level.block_state(at(0, 64, 0))), ["up"]);
    // Its shapes are 4 pixels across: the outline and the cached collision.
    // rust: let joined = level.block_state(at(0, 64, 0));
    // rust: let thin = horizon_world::collision::pipe_shape(4.0, [false, true, false, false, false, false])
    // rust: .unwrap();
    // rust: let facts = BlockFacts::load(&root, registry).unwrap();
    // rust: let outline = &facts.get(joined).outline;
    // rust: assert_eq!(outline.len(), thin.boxes().len());
    // rust: let file =
    // rust: horizon_world::registry::BlockTableFile::open(&root.join("cached-collision.nbt"), registry)
    // rust: .unwrap();
    // rust: let cached = horizon_world::collision::CachedCollisionRegistry::from_table(
    // rust: file.table("collision").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(cached.has_canonical_identities());
    // rust: let shape = cached.cached_shape(joined).unwrap().unwrap();
    // rust: assert_eq!(shape.boxes(), thin.boxes());
    // rust: assert_eq!(
    // rust: shape
    // rust: .bounds()
    // rust: .map(|b| b.min(horizon_core::geometry::Axis::X)),
    // rust: Some(0.375)
    // rust: );
    // Vanilla's chorus plant keeps its own rules: it doesn't join the machine.
    // rust: b.set_block(&mut level, &mut ticks, at(5, 64, 0), machine, 3);
    // rust: let chorus = registry.default_state("minecraft:chorus_plant").unwrap();
    // rust: let chorus = b.update_from_neighbour_shapes(&mut level, &mut ticks, at(4, 64, 0), chorus);
    // rust: assert!(sides(chorus).is_empty());
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// An old chunk's saved jigsaw start comes back with its pieces (`StructureStart.loadStaticStart`):
// a village this seed makes, saved as an older version would have, is loaded from its `Children`
// and has the same pieces, boxes and positions, so the neighbours can place what crosses into
// them. A legacy structure with no loader is the generator's own start when it has the same
// pieces' box, and name and box alone when it has not.
an_old_chunks_saved_village_comes_back_with_its_pieces :: proc() {
}
//     use horizon_core::position::ChunkPos;
//     use horizon_world::{
    // rust: nbt::Tag,
    // rust: worldgen::blending::{OldWorld, SavedStart},
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let assets = Assets::load(&base).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&base).unwrap();
    // rust: let open = || {
    // rust: crate::vanillagen::VanillaTerrain::new(
    // rust: &base.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap()
}
    // rust: let villages: Vec<String> = ["plains", "desert", "savanna", "snowy", "taiga"]
    // rust: .iter()
    // rust: .map(|k| format!("minecraft:village_{k}"))
    // rust: .collect();
    // rust: let made = open();
    // rust: let (name, at) = made
    // rust: .locate(&villages, [0, 64, 0], 100)
    // rust: .expect("a village near the origin");
    // rust: let (cx, cz) = (at[0] >> 4, at[2] >> 4);
    // rust: let original = made
    // rust: .starts_at(cx, cz)
    // rust: .into_iter()
    // rust: .find(|s| s.name == name)
    // rust: .expect("the village start");
    // rust: assert!(original.pieces.len() > 1);
    // Saved the way a chunk keeps it: the start's tag, its Children and their union box.
    // rust: let Some(Tag::Compound(saved)) = original.save() else {
    // rust: panic!("the village saves");
}
    // rust: let Some(Tag::List(children)) = saved.get(&"Children".into()).cloned() else {
    // rust: panic!("Children");
}
    // rust: let bounds = original
    // rust: .pieces
    // rust: .iter()
    // rust: .map(|p| p.bounding_box())
    // rust: .fold(None::<[i32; 6]>, |u, b| {
    // rust: let [x0, y0, z0, x1, y1, z1] =
    // rust: [b.min[0], b.min[1], b.min[2], b.max[0], b.max[1], b.max[2]];
    // rust: Some(match u {
    // rust: None => [x0, y0, z0, x1, y1, z1],
    // rust: Some(u) => [
    // rust: u[0].min(x0),
    // rust: u[1].min(y0),
    // rust: u[2].min(z0),
    // rust: u[3].max(x1),
    // rust: u[4].max(y1),
    // rust: u[5].max(z1),
    // rust: ],
    // rust: })
    // rust: });
Saved :: struct {
    chunk: (i32,
    start: SavedStart,
}
    // rust: impl OldWorld for Saved {
is_old_chunk_around :: proc(self: ^Self, center: ChunkPos, range: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (center.x - self.chunk.0).abs() <= range && (center.z - self.chunk.1).abs() <= range
}
    // rust: fn blending(
    // rust: &self,
    // rust: _: i32,
    // rust: _: i32,
    // rust: ) -> Option<std::sync::Arc<horizon_world::worldgen::blending::BlendingData>> {
    // rust: None
}
    // rust: fn old_biomes(
    // rust: &self,
    // rust: _: i32,
    // rust: _: i32,
    // rust: ) -> Option<
    // rust: std::sync::Arc<
    // rust: horizon_world::worldgen::biome_chunk::BiomeChunk<
    // rust: horizon_world::worldgen::biome::BiomeId,
    // rust: >,
    // rust: >,
    // rust: > {
    // rust: None
}
saved_starts :: proc(self: ^Self, x: i32, z: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if (x, z) == self.chunk {
    // rust: vec![self.start.clone()]
    // rust: } else {
    // rust: Vec::new()
}
}
}
    // rust: let loaded = open();
    // rust: loaded.set_old_world(std::sync::Arc::new(Saved {
    // rust: chunk: (cx, cz),
        // No box to compare: the pieces can only come from the Children.
    // rust: start: SavedStart {
    // rust: name: name.clone(),
    // rust: bounds: None,
    // rust: pieces: children.clone(),
    // rust: },
    // rust: }));
    // rust: let back = loaded
    // rust: .starts_at(cx, cz)
    // rust: .into_iter()
    // rust: .find(|s| s.name == name)
    // rust: .expect("the saved start");
    // rust: assert_eq!(
    // rust: back.pieces.len(),
    // rust: original.pieces.len(),
    // rust: "every piece is loaded"
    // rust: );
    // rust: for (a, b) in original.pieces.iter().zip(&back.pieces) {
    // rust: assert_eq!(a.bounding_box(), b.bounding_box());
    // rust: assert_eq!(a.type_name(), b.type_name());
    // rust: assert_eq!(a.save(), b.save(), "a piece saves as it was loaded");
}
    // rust: assert_eq!(back.bounding_box, original.bounding_box);
    // No pieces to load and a box no generated start has: the name and the box only.
    // rust: let odd = open();
    // rust: odd.set_old_world(std::sync::Arc::new(Saved {
    // rust: chunk: (cx, cz),
    // rust: start: SavedStart {
    // rust: name: name.clone(),
    // rust: bounds: Some([0, 0, 0, 1, 1, 1]),
    // rust: pieces: Vec::new(),
    // rust: },
    // rust: }));
    // rust: let stub = odd
    // rust: .starts_at(cx, cz)
    // rust: .into_iter()
    // rust: .find(|s| s.name == name)
    // rust: .unwrap();
    // rust: assert!(stub.pieces.is_empty());
    // rust: assert_eq!(stub.bounding_box.min, [0, 0, 0]);
    // The box of the start this generator makes there: it is that start.
    // rust: let same = open();
    // rust: same.set_old_world(std::sync::Arc::new(Saved {
    // rust: chunk: (cx, cz),
    // rust: start: SavedStart {
    // rust: name: name.clone(),
    // rust: bounds,
    // rust: pieces: Vec::new(),
    // rust: },
    // rust: }));
    // rust: let rebuilt = same
    // rust: .starts_at(cx, cz)
    // rust: .into_iter()
    // rust: .find(|s| s.name == name)
    // rust: .unwrap();
    // rust: assert_eq!(rebuilt.pieces.len(), original.pieces.len());
}

// A recipe's `result` is a stack's fields or a bare item id, as vanilla's `ItemStackTemplate`
// codec reads it (#4904): a mod's recipes make its own items either way.
mod_recipe_results_are_an_item_stack_or_a_bare_item_id :: proc() {
}
    // rust: if prepared().is_none() {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-results-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let dir = scratch.join("ruby");
    // rust: let _ = ruby_mod(&dir);
    // Each recipe takes one item no vanilla recipe crafts alone and makes one of the mod's.
    // rust: let cases = [
    // rust: (
    // rust: "stack",
    // rust: "minecraft:diamond",
    // rust: r#"{"id": "ruby:ruby"}"#,
    // rust: "ruby:ruby",
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: "bare_id",
    // rust: "minecraft:flint",
    // rust: r#""ruby:ruby""#,
    // rust: "ruby:ruby",
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: "bare_block_item",
    // rust: "minecraft:ghast_tear",
    // rust: r#""ruby:ruby_block""#,
    // rust: "ruby:ruby_block",
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: "counted",
    // rust: "minecraft:ender_pearl",
    // rust: r#"{"id": "ruby:ruby_block", "count": 3}"#,
    // rust: "ruby:ruby_block",
    // rust: 3,
    // rust: ),
    // rust: ];
    // rust: for (name, input, result, _, _) in cases {
    // rust: let recipe = format!(
    // rust: r#"{{"type": "minecraft:crafting_shapeless", "ingredients": ["{input}"], "result": {result}}}"#
    // rust: );
    // rust: fs::write(dir.join(format!("data/ruby/recipe/{name}.json")), recipe).unwrap();
}
    // rust: let package = horizon_mods::Package::read(&dir).unwrap();
    // rust: let m = ContentMod {
    // rust: id: "ruby".into(),
    // rust: content: Content::read(&dir, &package.manifest).unwrap(),
}
    // rust: let relative = Path::new("../../.local/horizon-client/26.3");
    // rust: let root = resource_root(relative, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let new = assets.registry;
    // rust: let facts = BlockFacts::load(&root, new).unwrap();
    // rust: let items = Items::load(&root, new, &facts, &PackOverlay::NONE).unwrap();
    // rust: let recipes = crate::crafting::Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: for (name, input, _, item, count) in cases {
    // rust: let grid = [
    // rust: Some(crate::items::ItemStack::new(input, 1)),
    // rust: None,
    // rust: None,
    // rust: None,
    // rust: ];
    // rust: let (_, made) = recipes
    // rust: .find(&grid, 2)
    // rust: .unwrap_or_else(|| panic!("{name}: no recipe"));
    // rust: assert_eq!((&*made.item, made.count), (item, count), "{name}");
}
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// A mod's creative tab comes after vanilla's, on page 1 in the first top
// slot, with only the items the game has; its new items join the search tab
// under their English names.
creative_tabs_come_on_their_own_page :: proc() {
}
    // rust: let Some(_) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-tabs-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let dir = scratch.join("gems");
    // rust: for (name, text) in [
    // rust: (
    // rust: "horizon-mod.toml",
    // rust: "id = \"gems\"\nname = \"Gems\"\nversion = \"0.1.0\"\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n",
    // rust: ),
    // rust: (
    // rust: "data/gems/horizon/item/ruby.json",
    // rust: r#"{"template": "minecraft:diamond"}"#,
    // rust: ),
    // rust: (
    // rust: "data/gems/horizon/block/ruby_block.json",
    // rust: r#"{"template": "minecraft:diamond_block"}"#,
    // rust: ),
    // rust: (
    // rust: "data/gems/horizon/creative_tab/gems.json",
    // rust: r#"{"title": "Gems", "icon": "gems:ruby", "items": ["gems:ruby", "minecraft:diamond", "gems:missing"]}"#,
    // rust: ),
    // rust: (
    // rust: "assets/gems/lang/en_us.json",
    // rust: r#"{"item.gems.ruby": "Ruby"}"#,
    // rust: ),
    // rust: ] {
    // rust: let path = dir.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let package = horizon_mods::Package::read(&dir).unwrap();
    // rust: let m = ContentMod {
    // rust: id: "gems".into(),
    // rust: content: Content::read(&dir, &package.manifest).unwrap(),
}
    // rust: let relative = Path::new("../../.local/horizon-client/26.3");
    // rust: let root = resource_root(relative, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let mut creative = crate::creative::Creative::load(&root).unwrap();
    // rust: assert_eq!(creative.pages(), 2);
    // rust: let i = creative
    // rust: .tabs
    // rust: .iter()
    // rust: .position(|t| t.id == "gems:gems")
    // rust: .unwrap();
    // rust: let tab = &creative.tabs[i];
    // rust: assert_eq!(
    // rust: (tab.page, tab.top, tab.column, tab.title.as_str()),
    // rust: (1, true, 0, "Gems")
    // rust: );
    // rust: let items: Vec<&str> = tab.items.iter().map(|s| &*s.item).collect();
    // rust: assert_eq!(items, ["gems:ruby", "minecraft:diamond"]);
    // rust: assert!(
    // rust: creative
    // rust: .search_items()
    // rust: .iter()
    // rust: .any(|s| &*s.item == "gems:ruby")
    // rust: );
    // A block's item is in search once.
    // rust: let blocks = creative
    // rust: .search_items()
    // rust: .iter()
    // rust: .filter(|s| &*s.item == "gems:ruby_block");
    // rust: assert_eq!(blocks.count(), 1);
    // Search, on every page, stays selected over a page turn.
    // rust: let search = creative.tabs.iter().position(|t| t.search).unwrap();
    // rust: creative.select(search);
    // rust: creative.set_page(1);
    // rust: assert_eq!((creative.selected, creative.page), (search, 1));
    // rust: creative.select(0);
    // Page 1 shows the mod's tab and the right-hand ones, not vanilla's.
    // rust: creative.set_page(1);
    // rust: assert_eq!(creative.selected, i);
    // rust: let shown: Vec<&str> = creative
    // rust: .tabs
    // rust: .iter()
    // rust: .filter(|t| creative.on_page(t))
    // rust: .map(|t| t.id.as_str())
    // rust: .collect();
    // rust: assert!(
    // rust: shown.contains(&"gems:gems") && shown.contains(&"minecraft:search"),
    // rust: "{shown:?}"
    // rust: );
    // rust: assert!(!shown.contains(&"minecraft:building_blocks"), "{shown:?}");
    // Selecting a vanilla tab goes back to its page.
    // rust: creative.select(0);
    // rust: assert_eq!(creative.page, 0);
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// A block that gives each of its template's states a run moves a template
// state to the first of its own: the combination every declared property is
// at its default for, which is the one the id cursor points at first.
a_fan_out_rename_moves_a_template_state_to_its_first_state :: proc() {
}
    // rust: let mut r = Rename::new("minecraft:test", "testmod:test");
    // rust: r.states = 10..12;
    // rust: r.first = 100;
    // rust: r.fanout = 6;
    // rust: assert_eq!(
    // rust: (r.id(9), r.id(10), r.id(11), r.id(12)),
    // rust: (None, Some(100), Some(106), None)
    // rust: );
}

// A base root of one template with two states, and a mod that adds a block
// to it. `declarations` go in as the block file.
block_base :: proc(tag: string, declarations: ^[string]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: block_base_of(
    // rust: tag,
    // rust: declarations,
    // rust: r#"{"states":[
    // rust: ["minecraft:test",false,false,"",{"id":"minecraft:test","properties":{"axis":"x"}}],
    // rust: ["minecraft:test",false,false,"",{"id":"minecraft:test","properties":{"axis":"y"}}]],
    // rust: "defaults":{"minecraft:test":0}}"#,
    // rust: )
}

// The same over a base root whose `facts.json` is `facts`: the other tables
// the plan reads are built from its state count, so a template can have one
// state and no properties of its own (a `stone`) as easily as two.
block_base_of :: proc(tag: string, declarations: ^[string], facts: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-{tag}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let base = scratch.join("base");
    // rust: fs::create_dir_all(&base).unwrap();
    // rust: fs::write(base.join("facts.json"), facts).unwrap();
    // rust: let count = match serde_json::from_str::<J>(facts).unwrap().get("states") {
    // rust: Some(J::Arr(rows)) => rows.len(),
    // rust: _ => panic!("{tag}: facts.json has no states"),
}
    // rust: let rows = vec![r#"{"item":"minecraft:test"}"#; count].join(",");
    // rust: fs::write(
    // rust: base.join("gameplay-facts.json"),
    // rust: format!(r#"{{"states":[{rows}]}}"#),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(base.join("items.json"), r#"{"minecraft:test":{}}"#).unwrap();
    // rust: fs::write(
    // rust: base.join("registries.json"),
    // rust: r#"{"minecraft:item":{"entries":{"minecraft:test":{"protocol_id":0}}},"minecraft:block":{"entries":{"minecraft:test":{"protocol_id":0}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mods: Vec<ContentMod> = declarations
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, declaration)| {
    // rust: let dir = scratch.join(format!("mod{i}"));
    // rust: folder_mod(
    // rust: &dir,
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("testmod", "")),
    // rust: ("data/testmod/horizon/block/test.json", *declaration),
    // rust: ],
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: (base, mods)
}

tuple_shapes_follow_final_state_order_and_separate_collision :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"active":{"type":"boolean"}},
    // rust: "shapes":{"properties":["axis","active"],
    // rust: "values":{"x,true":[[0,0,0,0.5,1,1]]},"default":[[0,0,0,1,1,1]]},
    // rust: "collision_shapes":{"properties":["active","axis"],
    // rust: "values":{"true,x":[[0,0,0,0.25,1,1]]},"default":[]}}"#;
    // rust: let (base, mods) = block_base("tuple-shapes", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let block = &plan.blocks[0];
    // rust: let shapes = block.shapes.as_ref().unwrap();
    // rust: let collisions = block.collision_shapes.as_ref().unwrap();
    // rust: assert_eq!(shapes.len(), 4);
    // rust: assert_eq!(collisions.len(), 4);
    // rust: for (index, (template, combo)) in block.state_combinations().enumerate() {
    // rust: let special = template == 0
    // rust: && combo
    // rust: .iter()
    // rust: .any(|(name, value)| name == "active" && value == "true");
    // rust: assert_eq!(
    // rust: shapes[index].bounds().unwrap().max(Axis::X),
    // rust: if special { 0.5 } else { 1.0 }
    // rust: );
    // rust: assert_eq!(collisions[index].is_empty(), !special);
    // rust: if special {
    // rust: assert_eq!(collisions[index].bounds().unwrap().max(Axis::X), 0.25);
}
}
    // rust: let mut gameplay: J =
    // rust: serde_json::from_slice(&fs::read(base.join("gameplay-facts.json")).unwrap()).unwrap();
    // rust: plan.json("gameplay-facts.json", &mut gameplay).unwrap();
    // rust: let Some(J::Arr(rows)) = gameplay.get("states") else {
    // rust: panic!("states")
}
    // rust: for (index, row) in rows[2..].iter().enumerate() {
    // rust: assert_eq!(row.get("full_collision"), Some(&J::Bool(false)));
    // rust: let Some(J::Arr(outline)) = row.get("outline") else {
    // rust: panic!("outline")
}
    // rust: assert_eq!(outline.len(), shapes[index].boxes().len());
}
    // rust: let mut tag = Tag::Compound(Compound::from([
    // rust: (
    // rust: JavaString::from("states"),
    // rust: Tag::List(vec![test_state_row("x"), test_state_row("y")]),
    // rust: ),
    // rust: (JavaString::from("shapes"), Tag::List(Vec::new())),
    // rust: (
    // rust: JavaString::from("cached_shapes"),
    // rust: Tag::IntArray(vec![-1, -1]),
    // rust: ),
    // rust: ]));
    // rust: plan.nbt(&mut tag);
    // rust: plan.collision_shapes(&mut tag).unwrap();
    // rust: let Some(Tag::List(entries)) = tag.get("shapes") else {
    // rust: panic!("shapes")
}
    // rust: let Some(Tag::IntArray(mapping)) = tag.get("cached_shapes") else {
    // rust: panic!("mapping")
}
    // rust: for (index, shape) in collisions.iter().enumerate() {
    // rust: assert_eq!(entries[mapping[2 + index] as usize], encode_shape(shape));
}
    // rust: fs::remove_dir_all(base.parent().unwrap()).unwrap();
}

collision_only_preserves_outline_and_shape_typos_are_errors :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","collision_shapes":{"default":[]}}"#;
    // rust: let (base, mods) = block_base("collision-only", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: assert!(plan.blocks[0].shapes.is_none());
    // rust: assert!(
    // rust: plan.blocks[0]
    // rust: .collision_shapes
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .all(VoxelShape::is_empty)
    // rust: );
    // rust: let mut gameplay: J =
    // rust: serde_json::from_str(r#"{"states":[{"outline":[[0,0,0,1,1,1]]},{"outline":[]}]}"#).unwrap();
    // rust: plan.json("gameplay-facts.json", &mut gameplay).unwrap();
    // rust: let Some(J::Arr(rows)) = gameplay.get("states") else {
    // rust: panic!("states")
}
    // rust: assert_eq!(rows[0].get("outline"), rows[2].get("outline"));
    // rust: assert_eq!(rows[1].get("outline"), rows[3].get("outline"));
    // rust: assert_eq!(rows[2].get("full_collision"), Some(&J::Bool(false)));
    // rust: fs::remove_dir_all(base.parent().unwrap()).unwrap();
    // rust: for (index, table) in [
    // rust: r#"{"properties":["axis","typo"],"default":[]}"#,
    // rust: r#"{"properties":["axis"],"values":{"bad":[]},"default":[]}"#,
    // rust: r#"{"properties":["axis"],"values":{"x":[]}}"#,
    // rust: ]
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: let declaration = format!(r#"{{"template":"minecraft:test","collision_shapes":{table}}}"#);
    // rust: let (base, mods) = block_base(&format!("collision-typo-{index}"), &[&declaration]);
    // rust: assert!(Plan::new(&base, &mods).is_err(), "{table}");
    // rust: fs::remove_dir_all(base.parent().unwrap()).unwrap();
}
}

// A block's states are its template's times the combinations of the state
// properties it declares, in a fixed order with every default first.
content_block_state_properties_fan_out_its_states :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"lit":{"type":"boolean"},
    // rust: "facing":{"type":"enum","values":["north","south","east"]}}}"#;
    // rust: let (base, mods) = block_base("block-states", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let facts = fs::read_to_string(base.join("facts.json")).unwrap();
    // rust: let mut doc: J = serde_json::from_str(&facts).unwrap();
    // rust: plan.json("facts.json", &mut doc).unwrap();
    // Two template states times the six combinations, after the template's.
    // rust: let Some(J::Arr(rows)) = doc.get("states") else {
    // rust: panic!("no states")
}
    // rust: assert_eq!(rows.len(), 2 + 12);
    // The default is the first combination of the template's default state.
    // rust: assert_eq!(
    // rust: doc.get("defaults").unwrap().get("testmod:test"),
    // rust: Some(&J::Num(2.into()))
    // rust: );
    // rust: let properties = |i: usize| -> BTreeMap<String, String> {
    // rust: let J::Arr(row) = &rows[i] else {
    // rust: panic!("row {i} is not a state")
}
    // rust: let Some(J::Obj(state)) = row.get(4) else {
    // rust: panic!("row {i} has no state")
}
    // rust: let Some((_, J::Obj(p))) = state.iter().find(|(k, _)| k == "properties") else {
    // rust: panic!("row {i} has no properties")
}
    // rust: p.iter()
    // rust: .map(|(k, v)| match v {
    // rust: J::Str(s) => (k.clone(), s.clone()),
    // rust: _ => panic!("{k} is not a string"),
    // rust: })
    // rust: .collect()
}
    // By name `facing` varies slowest, and each one's default comes first.
    // rust: assert_eq!(
    // rust: properties(2),
    // rust: BTreeMap::from([
    // rust: ("axis".to_owned(), "x".to_owned()),
    // rust: ("facing".to_owned(), "north".to_owned()),
    // rust: ("lit".to_owned(), "false".to_owned()),
    // rust: ])
    // rust: );
    // And the last is the second template state and the last combination.
    // rust: assert_eq!(
    // rust: properties(13),
    // rust: BTreeMap::from([
    // rust: ("axis".to_owned(), "y".to_owned()),
    // rust: ("facing".to_owned(), "east".to_owned()),
    // rust: ("lit".to_owned(), "true".to_owned()),
    // rust: ])
    // rust: );
    // Every state of the block is a different one: the registry indexes
    // states by their name and properties, so a repeat would be a collision.
    // rust: let states: BTreeSet<BTreeMap<String, String>> = (2..14).map(properties).collect();
    // rust: assert_eq!(states.len(), 12);
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

// A declared property whose name sorts before the template's goes in vanilla's order
// (`StateDefinition`): all the names sorted, the first slowest, so `alpha` varies slower than the
// template's `axis`. A state table that read the rows in the other order stopped the game at
// load ("registry state order differs from vanilla's state definition").
content_block_state_properties_follow_vanilla_name_order :: proc() {
}
    // rust: let (base, mods) = block_base(
    // rust: "block-name-order",
    // rust: &[r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"alpha":{"type":"boolean"}}}"#],
    // rust: );
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let facts = fs::read_to_string(base.join("facts.json")).unwrap();
    // rust: let mut doc: J = serde_json::from_str(&facts).unwrap();
    // rust: plan.json("facts.json", &mut doc).unwrap();
    // rust: let Some(J::Arr(rows)) = doc.get("states") else {
    // rust: panic!("no states")
}
    // rust: assert_eq!(rows.len(), 2 + 4);
    // rust: let properties = |i: usize| -> (String, String) {
    // rust: let J::Arr(row) = &rows[i] else {
    // rust: panic!("row {i} is not a state")
}
    // rust: let Some(J::Obj(state)) = row.get(4) else {
    // rust: panic!("row {i} has no state")
}
    // rust: let Some((_, J::Obj(p))) = state.iter().find(|(k, _)| k == "properties") else {
    // rust: panic!("row {i} has no properties")
}
    // rust: let value = |name: &str| match p.iter().find(|(k, _)| k == name) {
    // rust: Some((_, J::Str(s))) => s.clone(),
    // rust: _ => panic!("row {i} has no {name}"),
}
    // rust: (value("alpha"), value("axis"))
}
    // rust: let own = |a: &str, b: &str| (a.to_owned(), b.to_owned());
    // `alpha` slowest, then `axis`: the first name varies slowest, as in vanilla.
    // rust: assert_eq!(
    // rust: (2..6).map(properties).collect::<Vec<_>>(),
    // rust: [
    // rust: own("false", "x"),
    // rust: own("false", "y"),
    // rust: own("true", "x"),
    // rust: own("true", "y")
    // rust: ]
    // rust: );
    // The default is the template's default state with every declared property at its default.
    // rust: assert_eq!(
    // rust: doc.get("defaults").unwrap().get("testmod:test"),
    // rust: Some(&J::Num(2.into()))
    // rust: );
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

// `state_order` over the template's and the declared properties together.
block_states_are_laid_out_in_vanilla_order :: proc() {
}
    // rust: let p = |name: &str, len: u32| (name.to_owned(), len);
    // Every declared name after the template's: the template's states times the combinations,
    // as before, so ids of existing blocks do not move.
    // rust: let order = state_order(&[p("axis", 2)], &[p("lit", 2)]);
    // rust: assert_eq!(order, [(0, 0), (0, 1), (1, 0), (1, 1)]);
    // No declared property, or no template property: the identity, whichever side it is on.
    // rust: assert_eq!(state_order(&[p("axis", 3)], &[]), [(0, 0), (1, 0), (2, 0)]);
    // rust: assert_eq!(state_order(&[], &[p("lit", 2)]), [(0, 0), (0, 1)]);
    // rust: assert_eq!(state_order(&[], &[]), [(0, 0)]);
    // `bites` (4 values) before `facing` (4 values): the declared one slowest.
    // rust: let order = state_order(&[p("facing", 4)], &[p("bites", 4)]);
    // rust: assert_eq!(order.len(), 16);
    // rust: assert!(
    // rust: order
    // rust: .iter()
    // rust: .enumerate()
    // rust: .all(|(j, &(s, c))| (s, c) == (j as u32 % 4, j as u32 / 4))
    // rust: );
    // Interleaved: `b` between the template's `a` and `c`. a (2), b (2), c (3), a slowest.
    // rust: let order = state_order(&[p("a", 2), p("c", 3)], &[p("b", 2)]);
    // rust: assert_eq!(order.len(), 12);
    // Template state = a * 3 + c, combo = b.
    // rust: assert_eq!(order[0], (0, 0));
    // rust: assert_eq!(order[1], (1, 0));
    // rust: assert_eq!(order[3], (0, 1));
    // rust: assert_eq!(order[6], (3, 0));
    // rust: assert_eq!(order[11], (5, 1));
    // Every pair appears once.
    // rust: let mut seen = order.clone();
    // rust: seen.sort_unstable();
    // rust: seen.dedup();
    // rust: assert_eq!(seen.len(), 12);
}

// The declared default comes first in the run, so its id is the block's
// default with no arithmetic of its own.
content_block_state_properties_put_the_declared_default_first :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"facing":{"type":"enum","values":["north","south","east"]}},
    // rust: "default_state":{"facing":"south"}}"#;
    // rust: let (base, mods) = block_base("block-default-first", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let facts = fs::read_to_string(base.join("facts.json")).unwrap();
    // rust: let mut doc: J = serde_json::from_str(&facts).unwrap();
    // rust: plan.json("facts.json", &mut doc).unwrap();
    // rust: let Some(J::Arr(rows)) = doc.get("states") else {
    // rust: panic!("no states")
}
    // Two template states times three values.
    // rust: assert_eq!(rows.len(), 2 + 6);
    // rust: let facing = |i: usize| -> String {
    // rust: let J::Arr(row) = &rows[i] else {
    // rust: panic!("row {i} is not a state")
}
    // rust: let Some(J::Obj(state)) = row.get(4) else {
    // rust: panic!("row {i} has no state")
}
    // rust: match state
    // rust: .iter()
    // rust: .find(|(k, _)| k == "properties")
    // rust: .map(|(_, p)| p)
    // rust: {
    // rust: Some(p) => match p.get("facing") {
    // rust: Some(J::Str(s)) => s.clone(),
    // rust: _ => panic!("row {i} has no facing"),
    // rust: },
    // rust: None => panic!("row {i} has no properties"),
}
}
    // The declared default is the block's default, and it comes first.
    // rust: assert_eq!(
    // rust: doc.get("defaults").unwrap().get("testmod:test"),
    // rust: Some(&J::Num(2.into()))
    // rust: );
    // rust: assert_eq!(facing(2), "south");
    // The rest keep their declared order, rotated to start at the default.
    // rust: assert_eq!(
    // rust: (facing(3), facing(4)),
    // rust: ("east".to_owned(), "north".to_owned())
    // rust: );
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

// What a declaration may not do: shadow its template's property, name a
// value its own property does not have, or ask for more states than a world
// holds.
content_block_state_properties_are_validated :: proc() {
}
    // The template's `axis` is not the mod's to redefine.
    // rust: let (base, mods) = block_base(
    // rust: "block-shadow",
    // rust: &[r#"{"template":"minecraft:test","state_properties":{"axis":{"type":"boolean"}}}"#],
    // rust: );
    // rust: let error = match Plan::new(&base, &mods) {
    // rust: Err(e) => e.to_string(),
    // rust: Ok(_) => panic!("a shadowed template property was accepted"),
}
    // rust: assert!(error.contains("axis is already on"), "{error}");
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();

    // A default is one of the values the block declared.
    // rust: let (base, mods) = block_base(
    // rust: "block-bad-default",
    // rust: &[r#"{"template":"minecraft:test",
    // rust: "state_properties":{"lit":{"type":"boolean"}},"default_state":{"lit":"maybe"}}"#],
    // rust: );
    // rust: let error = match Plan::new(&base, &mods) {
    // rust: Err(e) => e.to_string(),
    // rust: Ok(_) => panic!("a default outside a property's values was accepted"),
}
    // rust: assert!(error.contains("is not one of its values"), "{error}");
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();

    // Twenty-one booleans are more combinations than a world can hold, and
    // are refused before the product is built.
    // rust: let declared: Vec<String> = (0..21)
    // rust: .map(|i| format!(r#""p{i}":{{"type":"boolean"}}"#))
    // rust: .collect();
    // rust: let declaration = format!(
    // rust: r#"{{"template":"minecraft:test","item":false,"state_properties":{{{}}}}}"#,
    // rust: declared.join(",")
    // rust: );
    // rust: let (base, mods) = block_base("block-too-many", &[&declaration]);
    // rust: let error = match Plan::new(&base, &mods) {
    // rust: Err(e) => e.to_string(),
    // rust: Ok(_) => panic!("more states than a world holds were accepted"),
}
    // rust: assert!(
    // rust: error.contains("more than the") && error.contains("world can hold"),
    // rust: "{error}"
    // rust: );
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

// A `default_state` that names only properties the block itself declares
// asks the template for nothing: `stone` has a single state and no properties
// at all, and a block that gives it `lit` can still default `lit`.
a_declared_property_defaults_on_a_template_with_none :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"lit":{"type":"boolean"}},
    // rust: "default_state":{"lit":"true"}}"#;
    // rust: let (base, mods) = block_base_of(
    // rust: "block-propertyless-default",
    // rust: &[declaration],
    // rust: r#"{"states":[["minecraft:test",true,true,"",{"id":"minecraft:test"}]],
    // rust: "defaults":{"minecraft:test":0}}"#,
    // rust: );
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let mut doc: J =
    // rust: serde_json::from_str(&fs::read_to_string(base.join("facts.json")).unwrap()).unwrap();
    // rust: plan.json("facts.json", &mut doc).unwrap();
    // rust: let Some(J::Arr(rows)) = doc.get("states") else {
    // rust: panic!("no states")
}
    // One template state times the two combinations of `lit`.
    // rust: assert_eq!(rows.len(), 1 + 2);
    // rust: let lit = |i: usize| -> Option<String> {
    // rust: let J::Arr(row) = rows.get(i)? else {
    // rust: return None;
}
    // rust: let J::Obj(state) = row.get(4)? else {
    // rust: return None;
}
    // rust: let (_, properties) = state.iter().find(|(k, _)| k == "properties")?;
    // rust: match properties.get("lit") {
    // rust: Some(J::Str(s)) => Some(s.clone()),
    // rust: _ => None,
}
}
    // The declared default opens the block's run, and the other value follows.
    // rust: assert_eq!(lit(1).as_deref(), Some("true"));
    // rust: assert_eq!(lit(2).as_deref(), Some("false"));
    // The block's default state is the first of its run.
    // rust: assert_eq!(
    // rust: doc.get("defaults").unwrap().get("testmod:test"),
    // rust: Some(&J::Num(1.into()))
    // rust: );
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

named_definitions_follow_the_block_state_fanout :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"lit":{"type":"boolean"}},
    // rust: "default_state":{"lit":"true"}}"#;
    // rust: let (base, mods) = block_base("named-state-fanout", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let mut models: J = serde_json::from_str(
    // rust: r#"{"minecraft:test":{
    // rust: "schema":{"axis":{"named":["x","y"]}},
    // rust: "states":[{"axis":"x"},{"axis":"y"}]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: plan.json("model-states.json", &mut models).unwrap();
    // rust: let added = models.get("testmod:test").unwrap();
    // rust: let expected: J = serde_json::from_str(
    // rust: r#"{"axis":{"named":["x","y"]},
    // rust: "lit":{"named":["false","true"]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(added.get("schema"), Some(&expected));
    // rust: let expected: J = serde_json::from_str(
    // rust: r#"[
    // rust: {"axis":"x","lit":"true"},{"axis":"x","lit":"false"},
    // rust: {"axis":"y","lit":"true"},{"axis":"y","lit":"false"}]"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(added.get("states"), Some(&expected));

    // rust: let mut render: J = serde_json::from_str(
    // rust: r#"{"minecraft:test":{
    // rust: "default":0,"can_occlude":true,"bars_tag":false,"rule":"never",
    // rust: "states":[0,1]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: plan.json("render-definitions.json", &mut render).unwrap();
    // rust: let added = render.get("testmod:test").unwrap();
    // rust: let expected: J = serde_json::from_str("[2,3,4,5]").unwrap();
    // rust: assert_eq!(added.get("states"), Some(&expected));
    // rust: assert_eq!(added.get("default"), Some(&J::Num(2.into())));

    // rust: for (file, json) in [
    // rust: (
    // rust: "landing-definitions.json",
    // rust: r#"{"minecraft:test":{"fall":"Block","bounce":false}}"#,
    // rust: ),
    // rust: (
    // rust: "worldgen/blocks/survival-rules.json",
    // rust: r#"{"minecraft:test":"Always"}"#,
    // rust: ),
    // rust: ] {
    // rust: let mut doc: J = serde_json::from_str(json).unwrap();
    // rust: plan.json(file, &mut doc).unwrap();
    // rust: assert_eq!(doc.get("testmod:test"), doc.get("minecraft:test"), "{file}");
}
    // rust: fs::remove_dir_all(base.parent().unwrap()).unwrap();
}

// An NBT state row for the two-state `minecraft:test` template, the shape
// `BlockState::to_nbt` writes.
test_state_row :: proc(axis: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::Compound(Compound::from([
    // rust: (
    // rust: JavaString::from("id"),
    // rust: Tag::String(JavaString::from("minecraft:test")),
    // rust: ),
    // rust: (
    // rust: JavaString::from("properties"),
    // rust: Tag::Compound(Compound::from([(
    // rust: JavaString::from("axis"),
    // rust: Tag::String(JavaString::from(axis)),
    // rust: )])),
    // rust: ),
    // rust: ]))
}

// The NBT tables fan out like the JSON ones: `cached-collision.nbt`,
// `occlusion.nbt` and the rest get one row per combination, so `states` and
// `cached_shapes` stay the same length, and each row carries the properties
// its combination declares.
the_nbt_tables_fan_out_with_the_states :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"lit":{"type":"boolean"}}}"#;
    // rust: let (base, mods) = block_base("block-nbt-fanout", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // rust: let mut tag = Tag::Compound(Compound::from([
    // rust: (
    // rust: JavaString::from("states"),
    // rust: Tag::List(vec![test_state_row("x"), test_state_row("y")]),
    // rust: ),
    // rust: (JavaString::from("cached_shapes"), Tag::IntArray(vec![7, 9])),
    // rust: ]));
    // rust: plan.nbt(&mut tag);
    // rust: let Some(Tag::List(states)) = tag.get("states") else {
    // rust: panic!("no states")
}
    // rust: let Some(Tag::IntArray(shapes)) = tag.get("cached_shapes") else {
    // rust: panic!("no cached_shapes")
}
    // Two template states times the two combinations of `lit`, and the shapes
    // stay parallel to the states — that is what makes the file load.
    // rust: assert_eq!(states.len(), 2 + 4);
    // rust: assert_eq!(shapes.len(), states.len());
    // A combination keeps the shape of the template state it came from.
    // rust: assert_eq!(shapes, &vec![7, 9, 7, 7, 9, 9]);
    // rust: let properties = |i: usize| -> BTreeMap<String, String> {
    // rust: let Some(Tag::Compound(c)) = states.get(i) else {
    // rust: panic!("row {i} is not a compound")
}
    // rust: let Some(Tag::Compound(p)) = c.get(&JavaString::from("properties")) else {
    // rust: panic!("row {i} has no properties")
}
    // rust: p.iter()
    // rust: .filter_map(|(k, v)| match v {
    // rust: Tag::String(s) => Some((k.to_string_lossy(), s.to_string_lossy())),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
    // rust: let mut expected: Vec<String> = Vec::new();
    // rust: for axis in ["x", "y"] {
    // rust: for lit in ["false", "true"] {
    // rust: expected.push(format!("{axis}/{lit}"));
}
}
    // rust: let seen: Vec<String> = (2..states.len())
    // rust: .map(|i| {
    // rust: let p = properties(i);
            // The declared properties are the only ones on the row.
    // rust: assert_eq!(p.len(), 2, "row {i} is {p:?}");
    // rust: let axis = p.get("axis").cloned().unwrap_or_default();
    // rust: let lit = p.get("lit").cloned().unwrap_or_default();
    // rust: format!("{axis}/{lit}")
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(seen, expected);
    // rust: for i in 2..states.len() {
    // rust: let Some(Tag::String(id)) = states[i].get("id") else {
    // rust: panic!("row {i} has no id")
}
    // rust: assert_eq!(id.to_string_lossy(), "testmod:test");
}
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

// A block's shape and its count in `structure-blocks.json` cover every
// combination too: the table's declared total and the lengths of its lists
// grow by the fan-out, and every state of the block maps to a shape.
a_shape_and_the_state_count_cover_every_combination :: proc() {
}
    // rust: let declaration = r#"{"template":"minecraft:test","item":false,
    // rust: "state_properties":{"lit":{"type":"boolean"}},
    // rust: "shapes":{"property":"axis","values":{"x":[[0,0,0,1,1,1]],"y":[[0,0,0,0.5,1,1]]}}}"#;
    // rust: let (base, mods) = block_base("block-shape-fanout", &[declaration]);
    // rust: let plan = Plan::new(&base, &mods).unwrap();
    // The template's two states, no shapes yet, every vanilla state unmapped.
    // `nbt` grows the arrays to the block's four states and `collision_shapes`
    // writes into them, in the order the real path applies them.
    // rust: let mut tag = Tag::Compound(Compound::from([
    // rust: (
    // rust: JavaString::from("states"),
    // rust: Tag::List(vec![test_state_row("x"), test_state_row("y")]),
    // rust: ),
    // rust: (JavaString::from("shapes"), Tag::List(Vec::new())),
    // rust: (
    // rust: JavaString::from("cached_shapes"),
    // rust: Tag::IntArray(vec![-1, -1]),
    // rust: ),
    // rust: ]));
    // rust: plan.nbt(&mut tag);
    // rust: plan.collision_shapes(&mut tag).unwrap();
    // rust: let Some(Tag::List(entries)) = tag.get("shapes") else {
    // rust: panic!("no shapes")
}
    // rust: let Some(Tag::IntArray(mapping)) = tag.get("cached_shapes") else {
    // rust: panic!("no cached_shapes")
}
    // One shape per template state, shared by that state's combinations.
    // rust: assert_eq!(entries.len(), 2);
    // rust: assert_eq!(mapping.len(), 2 + 4);
    // rust: let added = &mapping[2..];
    // rust: assert!(added.iter().all(|id| *id >= 0), "{added:?}");
    // rust: assert_eq!((added[0], added[1]), (added[0], added[0]));
    // rust: assert_eq!((added[2], added[3]), (added[2], added[2]));
    // rust: assert_ne!(added[0], added[2]);

    // rust: let rows = "[[false,false],[false,false]]";
    // rust: let text = format!(r#"{{"rotate":{rows},"mirror":{rows},"full_block":{rows},"states":2}}"#);
    // rust: let mut doc: J = serde_json::from_str(&text).unwrap();
    // rust: plan.json("worldgen/blocks/structure-blocks.json", &mut doc)
    // rust: .unwrap();
    // rust: for key in ["rotate", "mirror", "full_block"] {
    // rust: let Some(J::Arr(list)) = doc.get(key) else {
    // rust: panic!("{key} is not a list")
}
    // rust: assert_eq!(list.len(), 2 + 4, "{key}");
}
    // The declared total agrees with the lists, which is what a loader checks.
    // rust: assert_eq!(doc.get("states"), Some(&J::Num(6.into())));
    // rust: fs::remove_dir_all(&base).unwrap();
    // rust: fs::remove_dir_all(base.parent().unwrap().join("mod0")).ok();
}

// A base root of one block with three biomes, two biome tags (one nesting
// the other), three vanilla placed features and entity types: what biome
// modifiers read.
biome_base :: proc(tag: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let (base, _) = block_base(tag, &[]);
    // rust: let worldgen = base.join("worldgen");
    // rust: fs::create_dir_all(&worldgen).unwrap();
    // rust: let bundle = |entries: &[(&str, &str)]| -> String {
    // rust: let map: BTreeMap<&str, &str> = entries.iter().copied().collect();
    // rust: serde_json::to_string(&map).unwrap()
}
    // rust: let files = [
    // rust: (
    // rust: "biomes.json",
    // rust: bundle(&[
    // rust: (
    // rust: "minecraft:plains",
    // rust: r#"{"temperature":0.8,"features":[[],["minecraft:lake"],[],[],[],[],["minecraft:ore_coal"]],"attributes":{"minecraft:gameplay/natural_mob_spawns":{"argument":{"spawn_costs":{"minecraft:skeleton":{"energy_budget":0.7,"charge":0.15}},"spawns_by_category":{"monster":[{"type":"minecraft:zombie","count":4,"weight":95},{"type":"minecraft:skeleton","count":4,"weight":100}]}},"modifier":"overlay"}}}"#,
    // rust: ),
    // rust: ("minecraft:desert", r#"{"features":[["minecraft:fossil"]]}"#),
    // rust: (
    // rust: "minecraft:nether_wastes",
    // rust: r#"{"temperature":2.0,"features":[[],[],[],[],[],[],["minecraft:ore_coal"]]}"#,
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "biome_tags.json",
    // rust: bundle(&[
    // rust: (
    // rust: "minecraft:is_overworld",
    // rust: r##"{"values":["#minecraft:is_plains_like","minecraft:desert",{"id":"othermod:x","required":false}]}"##,
    // rust: ),
    // rust: (
    // rust: "minecraft:is_plains_like",
    // rust: r#"{"values":["minecraft:plains"]}"#,
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "placed_features.json",
    // rust: bundle(&[
    // rust: ("minecraft:ore_coal", "{}"),
    // rust: ("minecraft:lake", "{}"),
    // rust: ("minecraft:fossil", "{}"),
    // rust: ]),
    // rust: ),
    // rust: ("features.json", bundle(&[])),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: fs::write(worldgen.join(name), text).unwrap();
}
    // rust: fs::write(
    // rust: base.join("entity-types.json"),
    // rust: r#"{"minecraft:zombie":{"category":"monster"},"minecraft:skeleton":{"category":"monster"},"minecraft:stray":{"category":"monster"},"minecraft:rabbit":{"category":"creature"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let entity_tags = base.join("data/minecraft/tags/entity_type");
    // rust: fs::create_dir_all(&entity_tags).unwrap();
    // rust: fs::write(
    // rust: entity_tags.join("skeletons.json"),
    // rust: r#"{"values":["minecraft:skeleton","minecraft:stray",{"id":"othermod:bone","required":false}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: base
}

// A mod adding a zinc ore and its biome modifiers (`(file name, text)`).
zinc_mod :: proc(dir: ^Path, modifiers: ^[(string) {
}
    // rust: let mut files = vec![
    // rust: ("horizon-mod.toml".to_owned(), manifest("zinc", "")),
    // rust: (
    // rust: "data/zinc/worldgen/configured_feature/ore_zinc.json".to_owned(),
    // rust: r#"{"type":"minecraft:ore","config":{}}"#.to_owned(),
    // rust: ),
    // rust: (
    // rust: "data/zinc/worldgen/placed_feature/ore_zinc.json".to_owned(),
    // rust: r#"{"feature":"zinc:ore_zinc","placement":[]}"#.to_owned(),
    // rust: ),
    // rust: ];
    // rust: for (name, text) in modifiers {
    // rust: files.push((
    // rust: format!("data/zinc/neoforge/biome_modifier/{name}.json"),
    // rust: (*text).to_owned(),
    // rust: ));
}
    // rust: let files: Vec<(&str, &str)> = files
    // rust: .iter()
    // rust: .map(|(a, b)| (a.as_str(), b.as_str()))
    // rust: .collect();
    // rust: folder_mod(dir, &files)
}

biome_features :: proc(root: ^Path) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let bundle: BTreeMap<String, String> =
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/biomes.json")).unwrap()).unwrap();
    // rust: bundle
    // rust: .into_iter()
    // rust: .map(|(id, text)| {
    // rust: let v: serde_json::Value = serde_json::from_str(&text).unwrap();
    // rust: (id, v["features"].clone())
    // rust: })
    // rust: .collect()
}

// `neoforge:add_features` puts a mod's ore at the end of its step in every
// biome of an overworld tag, `remove_features` takes a vanilla feature out,
// and the biomes no modifier names keep their text.
biome_modifiers_place_mod_features_in_vanilla_biomes :: proc() {
}
    // rust: let base = biome_base("biome-modifiers");
    // rust: let scratch = base.parent().unwrap().to_owned();
    // rust: let m = zinc_mod(
    // rust: &scratch.join("zinc"),
    // rust: &[
    // rust: (
    // rust: "add_zinc",
    // rust: r##"{"type":"neoforge:add_features","biomes":"#minecraft:is_overworld",
    // rust: "features":"zinc:ore_zinc","step":"underground_ores"}"##,
    // rust: ),
            // Adds before removes, whatever the file order.
    // rust: (
    // rust: "a_no_fossils",
    // rust: r#"{"type":"neoforge:remove_features","biomes":["minecraft:desert"],
    // rust: "features":["minecraft:fossil"],"steps":["raw_generation"]}"#,
    // rust: ),
    // rust: ("nothing", r#"{"type":"neoforge:none"}"#),
    // rust: ],
    // rust: );
    // rust: let out = scratch.join("out");
    // rust: build(&base, &[m], &out).unwrap();
    // rust: let features = biome_features(&out);
    // rust: assert_eq!(
    // rust: features["minecraft:plains"],
    // rust: serde_json::json!([
    // rust: [],
    // rust: ["minecraft:lake"],
    // rust: [],
    // rust: [],
    // rust: [],
    // rust: [],
    // rust: ["minecraft:ore_coal", "zinc:ore_zinc"]
    // rust: ])
    // rust: );
    // A biome with fewer steps gets the ones up to the modifier's.
    // rust: assert_eq!(
    // rust: features["minecraft:desert"],
    // rust: serde_json::json!([[], [], [], [], [], [], ["zinc:ore_zinc"]])
    // rust: );
    // rust: let text = |root: &Path| -> BTreeMap<String, String> {
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/biomes.json")).unwrap()).unwrap()
}
    // rust: assert_eq!(
    // rust: text(&out)["minecraft:nether_wastes"],
    // rust: text(&base)["minecraft:nether_wastes"]
    // rust: );
    // rust: let plains: serde_json::Value = serde_json::from_str(&text(&out)["minecraft:plains"]).unwrap();
    // rust: assert_eq!(plains["temperature"], serde_json::json!(0.8));

    // The generator's sorter places vanilla's features where they were and
    // the ore after the coal it follows: the order applyBiomeDecoration uses.
//     use horizon_world::worldgen::feature_sort::{FeatureIdentity, build_features_per_step};
    // rust: let mut ids: Vec<String> = Vec::new();
    // rust: let mut plan = |biomes: &[&str], features: &BTreeMap<String, serde_json::Value>| {
    // rust: let lists: Vec<Vec<Vec<FeatureIdentity>>> = biomes
    // rust: .iter()
    // rust: .map(|b| {
    // rust: features[*b]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|step| {
    // rust: step.as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|f| {
    // rust: let f = f.as_str().unwrap().to_owned();
    // rust: let i = ids.iter().position(|x| *x == f).unwrap_or_else(|| {
    // rust: ids.push(f);
    // rust: ids.len() - 1
    // rust: });
    // rust: FeatureIdentity(i as u32)
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .collect();
    // rust: build_features_per_step(&lists).unwrap()
}
    // rust: let overworld = ["minecraft:plains", "minecraft:desert"];
    // rust: let steps = plan(&overworld, &features);
    // rust: let names = |s: usize, ids: &[String]| -> Vec<String> {
    // rust: steps[s]
    // rust: .features()
    // rust: .iter()
    // rust: .map(|f| ids[f.0 as usize].clone())
    // rust: .collect()
}
    // rust: assert_eq!(names(6, &ids), ["minecraft:ore_coal", "zinc:ore_zinc"]);
    // rust: assert_eq!(names(1, &ids), ["minecraft:lake"]);
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// A mod with features but no modifier leaves vanilla's biome bundle alone.
biome_modifiers_none_keep_the_vanilla_biomes :: proc() {
}
    // rust: let base = biome_base("biome-modifiers-none");
    // rust: let scratch = base.parent().unwrap().to_owned();
    // rust: let out = scratch.join("out");
    // rust: build(&base, &[zinc_mod(&scratch.join("zinc"), &[])], &out).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(out.join("worldgen/biomes.json")).unwrap(),
    // rust: fs::read(base.join("worldgen/biomes.json")).unwrap()
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// An unknown biome, biome tag, feature, entity type, step or modifier type is
// skipped with a warning or fails the build with the mod and file named.
biome_modifiers_refuse_unknown_names :: proc() {
}
    // rust: let base = biome_base("biome-modifiers-errors");
    // rust: let scratch = base.parent().unwrap().to_owned();
    // A name the root doesn't have, or a type not read yet: that modifier is
    // skipped with a warning (another mod's ids, `#c:` tags and `add_carvers`
    // are common in real mods), and the mods still load.
    // rust: for (i, (modifier, warning)) in [
    // rust: (
    // rust: r##"{"type":"neoforge:add_features","biomes":"#minecraft:is_moon",
    // rust: "features":"zinc:ore_zinc","step":"underground_ores"}"##,
    // rust: "unknown biome tag #minecraft:is_moon",
    // rust: ),
    // rust: (
    // rust: r#"{"type":"neoforge:add_features","biomes":"minecraft:moon",
    // rust: "features":"zinc:ore_zinc","step":"underground_ores"}"#,
    // rust: "unknown biome minecraft:moon",
    // rust: ),
    // rust: (
    // rust: r#"{"type":"neoforge:add_features","biomes":"minecraft:plains",
    // rust: "features":"zinc:ore_tin","step":"underground_ores"}"#,
    // rust: "unknown placed feature zinc:ore_tin",
    // rust: ),
    // rust: (
    // rust: r#"{"type":"neoforge:add_spawns","biomes":"minecraft:plains",
    // rust: "spawners":{"type":"zinc:goblin","weight":10,"minCount":1,"maxCount":2}}"#,
    // rust: "unknown entity type zinc:goblin",
    // rust: ),
    // rust: (
    // rust: r##"{"type":"neoforge:remove_spawns","biomes":"minecraft:plains",
    // rust: "entity_types":"#minecraft:is_goblin"}"##,
    // rust: "unknown entity type tag #minecraft:is_goblin",
    // rust: ),
    // rust: (
    // rust: r#"{"type":"neoforge:add_carvers","biomes":"minecraft:plains","carvers":[]}"#,
    // rust: "biome modifier type \"add_carvers\" skipped",
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let m = zinc_mod(&scratch.join(format!("zinc{i}")), &[("bad", modifier)]);
    // rust: let warnings = build(&base, &[m], &scratch.join(format!("out{i}"))).unwrap();
    // rust: assert!(
    // rust: warnings.iter().any(|w| w.contains(warning)
    // rust: && w.contains("mod zinc: data/zinc/neoforge/biome_modifier/bad.json")),
    // rust: "{warnings:?}"
    // rust: );
}
    // A malformed modifier of a type Horizon reads is the mod's error.
    // rust: for (i, (modifier, err)) in [
    // rust: (
    // rust: r#"{"type":"neoforge:add_features","biomes":"minecraft:plains",
    // rust: "features":"zinc:ore_zinc","step":"ores"}"#,
    // rust: "unknown generation step \"ores\"",
    // rust: ),
    // rust: (
    // rust: r#"{"type":"neoforge:add_spawns","biomes":"minecraft:plains",
    // rust: "spawners":{"type":"minecraft:zombie","weight":10,"minCount":5,"maxCount":2}}"#,
    // rust: "minCount (5) > maxCount (2)",
    // rust: ),
    // rust: (
    // rust: r#"{"type":"neoforge:add_spawn_costs","biomes":"minecraft:plains",
    // rust: "entity_types":"minecraft:zombie","spawn_cost":{"energy_budget":0.7}}"#,
    // rust: "spawn_cost: no charge",
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let m = zinc_mod(&scratch.join(format!("zinc-err{i}")), &[("bad", modifier)]);
    // rust: let e = build(&base, &[m], &scratch.join(format!("out-err{i}")))
    // rust: .unwrap_err()
    // rust: .to_string();
    // rust: assert!(e.contains(err), "{e}");
    // rust: assert!(
    // rust: e.contains("mod zinc: data/zinc/neoforge/biome_modifier/bad.json"),
    // rust: "{e}"
    // rust: );
}
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// `add_spawns`, `remove_spawns`, `add_spawn_costs` and `remove_spawn_costs`
// rewrite `minecraft:gameplay/natural_mob_spawns` in the biomes they name:
// additions before removals regardless of file order, spawners placed under
// their entity type's category with `minCount`/`maxCount` converted to
// `count`, and untouched biomes left byte for byte as they were.
biome_modifiers_change_mob_spawns_and_spawn_costs :: proc() {
}
    // rust: let base = biome_base("biome-modifiers-spawns");
    // rust: let scratch = base.parent().unwrap().to_owned();
    // rust: let m = zinc_mod(
    // rust: &scratch.join("zinc"),
    // rust: &[
            // Listed before `add_spawns`, but removals run after additions:
            // takes out vanilla's `minecraft:skeleton` and the added
            // `minecraft:stray` via `#minecraft:skeletons`.
    // rust: (
    // rust: "a_no_skeletons",
    // rust: r##"{"type":"neoforge:remove_spawns","biomes":"#minecraft:is_overworld",
    // rust: "entity_types":"#minecraft:skeletons"}"##,
    // rust: ),
    // rust: (
    // rust: "a_no_skeleton_cost",
    // rust: r##"{"type":"neoforge:remove_spawn_costs","biomes":"minecraft:plains",
    // rust: "entity_types":"#minecraft:skeletons"}"##,
    // rust: ),
            // Single spawner object (`minCount == maxCount` -> integer `count`)
            // on a biome that had no `attributes` at all (`desert`), and on `plains`.
    // rust: (
    // rust: "add_rabbits",
    // rust: r##"{"type":"neoforge:add_spawns","biomes":"#minecraft:is_overworld",
    // rust: "spawners":{"type":"minecraft:rabbit","weight":12,"minCount":3,"maxCount":3}}"##,
    // rust: ),
            // Array of spawners (`minCount < maxCount` -> `minecraft:uniform`).
    // rust: (
    // rust: "add_monsters",
    // rust: r#"{"type":"forge:add_spawns","biomes":"plains",
    // rust: "spawners":[
    // rust: {"type":"stray","weight":80,"minCount":1,"maxCount":4},
    // rust: {"type":"minecraft:zombie","weight":20,"minCount":2,"maxCount":5}
    // rust: ]}"#,
    // rust: ),
    // rust: (
    // rust: "add_zombie_cost",
    // rust: r#"{"type":"neoforge:add_spawn_costs","biomes":["minecraft:plains","minecraft:desert"],
    // rust: "entity_types":["minecraft:zombie","minecraft:stray"],
    // rust: "spawn_cost":{"energy_budget":0.85,"charge":0.2}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let out = scratch.join("out");
    // rust: let warnings = build(&base, &[m], &out).unwrap();
    // rust: assert!(warnings.is_empty(), "{warnings:?}");

    // rust: let text = |root: &Path| -> BTreeMap<String, String> {
    // rust: serde_json::from_slice(&fs::read(root.join("worldgen/biomes.json")).unwrap()).unwrap()
}
    // rust: let out_biomes = text(&out);
    // Untouched biome keeps its exact bytes.
    // rust: assert_eq!(
    // rust: out_biomes["minecraft:nether_wastes"],
    // rust: text(&base)["minecraft:nether_wastes"]
    // rust: );

    // rust: let plains: serde_json::Value = serde_json::from_str(&out_biomes["minecraft:plains"]).unwrap();
    // rust: let plains_spawns = &plains["attributes"]["minecraft:gameplay/natural_mob_spawns"]["argument"];
    // `minecraft:skeleton` and the added `minecraft:stray` were removed by
    // `remove_spawns`, while vanilla's zombie, the second zombie spawner, and
    // the rabbit in `creature` remain.
    // rust: assert_eq!(
    // rust: plains_spawns["spawns_by_category"],
    // rust: serde_json::json!({
    // rust: "monster": [
    // rust: {"type": "minecraft:zombie", "count": 4, "weight": 95},
    // rust: {
    // rust: "type": "minecraft:zombie",
    // rust: "count": {"type": "minecraft:uniform", "min_inclusive": 2, "max_inclusive": 5},
    // rust: "weight": 20
}
    // rust: ],
    // rust: "creature": [
    // rust: {"type": "minecraft:rabbit", "count": 3, "weight": 12}
    // rust: ]
    // rust: })
    // rust: );
    // `skeleton` and `stray` costs were removed on `plains`; `zombie` cost remains.
    // rust: assert_eq!(
    // rust: plains_spawns["spawn_costs"],
    // rust: serde_json::json!({
    // rust: "minecraft:zombie": {"energy_budget": 0.85, "charge": 0.2}
    // rust: })
    // rust: );

    // rust: let desert: serde_json::Value = serde_json::from_str(&out_biomes["minecraft:desert"]).unwrap();
    // rust: let desert_spawns = &desert["attributes"]["minecraft:gameplay/natural_mob_spawns"]["argument"];
    // rust: assert_eq!(
    // rust: desert_spawns["spawns_by_category"],
    // rust: serde_json::json!({
    // rust: "creature": [
    // rust: {"type": "minecraft:rabbit", "count": 3, "weight": 12}
    // rust: ]
    // rust: })
    // rust: );
    // rust: assert_eq!(
    // rust: desert_spawns["spawn_costs"],
    // rust: serde_json::json!({
    // rust: "minecraft:zombie": {"energy_budget": 0.85, "charge": 0.2},
    // rust: "minecraft:stray": {"energy_budget": 0.85, "charge": 0.2}
    // rust: })
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// Over the real prepared resources: a mod's ore, added to
// `#minecraft:is_overworld` by a biome modifier, generates in a fresh
// world's chunk; without the modifier the same placed feature does not
// (its `biome` filter only passes in biomes that list it).
content_root_generates_a_biome_modifier_ore :: proc() {
}
//     use crate::streaming::{ChunkGenerator, Proto};
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-ore-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let ore = |modifier: bool| -> usize {
    // rust: let mut files = vec![
    // rust: ("horizon-mod.toml", manifest("zinc", "")),
    // rust: (
    // rust: "data/zinc/horizon/block/zinc_ore.json",
    // rust: r#"{"template": "minecraft:iron_ore"}"#.to_owned(),
    // rust: ),
    // rust: (
    // rust: "data/zinc/worldgen/configured_feature/ore_zinc.json",
    // rust: r##"{"type": "minecraft:ore", "size": 9, "discard_chance_on_air_exposure": 0.0,
    // rust: "targets": [{"target": {"predicate_type": "minecraft:tag_match",
    // rust: "tag": "minecraft:stone_ore_replaceables"},
    // rust: "state": "zinc:zinc_ore"}]}"##
    // rust: .to_owned(),
    // rust: ),
    // rust: (
    // rust: "data/zinc/worldgen/placed_feature/ore_zinc.json",
    // rust: r#"{"feature": "zinc:ore_zinc", "placement": [
    // rust: {"type": "minecraft:count", "count": 40}, {"type": "minecraft:in_square"},
    // rust: {"type": "minecraft:height_range", "height": {"type": "minecraft:uniform",
    // rust: "min_inclusive": {"absolute": -32}, "max_inclusive": {"absolute": 48}}},
    // rust: {"type": "minecraft:biome"}]}"#
    // rust: .to_owned(),
    // rust: ),
    // rust: ];
    // rust: if modifier {
    // rust: files.push((
    // rust: "data/zinc/neoforge/biome_modifier/add_zinc.json",
    // rust: r##"{"type": "neoforge:add_features", "biomes": "#minecraft:is_overworld",
    // rust: "features": "zinc:ore_zinc", "step": "underground_ores"}"##
    // rust: .to_owned(),
    // rust: ));
}
    // rust: let files: Vec<(&str, &str)> = files.iter().map(|(a, b)| (*a, b.as_str())).collect();
    // rust: let dir = scratch.join(format!("zinc-{modifier}"));
    // rust: let m = folder_mod(&dir, &files);
    // rust: let root = resource_root(&base, &[m], &dir.join("cache")).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let zinc = assets.registry.default_state("zinc:zinc_ore").unwrap().0;
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let terrain = crate::vanillagen::VanillaTerrain::new(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )
    // rust: .unwrap();
    // rust: let mut worker = terrain.worker();
    // rust: let mut region: [Proto; 9] =
    // rust: std::array::from_fn(|i| terrain.proto(&mut worker, i as i32 % 3 - 1, i as i32 / 3 - 1));
    // rust: terrain.decorate(&mut worker, &mut region);
    // rust: let [_, _, _, _, center, ..] = region;
    // rust: let chunk = terrain.finish(center);
    // rust: let mut count = 0;
    // rust: for y in chunk.min_y()..chunk.max_y() {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: count += usize::from(chunk.get(x, y, z) == zinc);
}
}
}
    // rust: count
}
    // rust: assert!(ore(true) > 0, "the modifier's ore generates");
    // rust: assert_eq!(ore(false), 0, "no modifier, no ore");
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// `biomes` may be one id or a list of ids as well as a tag (NeoForge's
// HolderSet forms); an id may leave out `minecraft:`.
biome_modifiers_take_one_biome_or_a_list :: proc() {
}
    // rust: let base = biome_base("biome-modifiers-lists");
    // rust: let scratch = base.parent().unwrap().to_owned();
    // rust: let m = zinc_mod(
    // rust: &scratch.join("zinc"),
    // rust: &[
    // rust: (
    // rust: "list",
    // rust: r#"{"type":"neoforge:add_features","biomes":["minecraft:plains","nether_wastes"],
    // rust: "features":"zinc:ore_zinc","step":"underground_ores"}"#,
    // rust: ),
    // rust: (
    // rust: "one",
    // rust: r#"{"type":"neoforge:add_features","biomes":"minecraft:desert",
    // rust: "features":["minecraft:lake"],"step":"lakes"}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let out = scratch.join("out");
    // rust: build(&base, &[m], &out).unwrap();
    // rust: let features = biome_features(&out);
    // rust: assert_eq!(
    // rust: features["minecraft:plains"][6],
    // rust: serde_json::json!(["minecraft:ore_coal", "zinc:ore_zinc"])
    // rust: );
    // rust: assert_eq!(
    // rust: features["minecraft:nether_wastes"][6],
    // rust: serde_json::json!(["minecraft:ore_coal", "zinc:ore_zinc"])
    // rust: );
    // rust: assert_eq!(
    // rust: features["minecraft:desert"],
    // rust: serde_json::json!([["minecraft:fossil"], ["minecraft:lake"]])
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// Blocks and items a native mod declares in code join the content plan:
// inside the content mod of their namespace, or as one of their own, with
// ids after vanilla's as files' are.
blocks_and_items_declared_in_code_get_ids :: proc() {
}
//     use horizon_mods::content::{Block, Item};
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-declared-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let known = known_components(&base).unwrap();
    // rust: let block = |id: &str| Block {
    // rust: id: id.into(),
    // rust: template: "minecraft:oak_log".into(),
    // rust: item: true,
    // rust: ..Block::default()
}
    // rust: let wrench = Item {
    // rust: id: "gears:wrench".into(),
    // rust: template: "minecraft:stick".into(),
    // rust: max_stack_size: Some(1),
    // rust: ..Item::default()
}
    // rust: let mut mods = vec![ruby_mod(&scratch.join("ruby"))];
    // rust: let errors = accept_declared(
    // rust: &mut mods,
    // rust: &[block("ruby:ruby_log"), block("gears:shaft")],
    // rust: &[wrench],
    // rust: &known,
    // rust: );
    // rust: assert!(errors.is_empty(), "{errors:?}");
    // rust: assert_eq!(mods.len(), 2);
    // rust: assert!(
    // rust: mods[0]
    // rust: .content
    // rust: .blocks
    // rust: .iter()
    // rust: .any(|b| b.id == "ruby:ruby_log")
    // rust: );
    // rust: assert_eq!(mods[1].id, "gears");
    // A namespace another mod owns, and a clash with a file's block, are refused whole.
    // rust: let refused = accept_declared(
    // rust: &mut mods,
    // rust: &[block("ruby:ruby_block"), block("ruby:ruby_post")],
    // rust: &[],
    // rust: &known,
    // rust: );
    // rust: assert_eq!(refused.len(), 1, "{refused:?}");
    // rust: assert!(
    // rust: !mods[0]
    // rust: .content
    // rust: .blocks
    // rust: .iter()
    // rust: .any(|b| b.id == "ruby:ruby_post")
    // rust: );

    // rust: let root = resource_root(&base, &mods, &scratch.join("cache")).unwrap();
    // rust: let vanilla = Assets::load(&base).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let n = vanilla.registry.len() as u32;
    // rust: let log_states = (0..n)
    // rust: .filter(|&s| vanilla.registry.state(BlockStateId(s)).unwrap().name == "minecraft:oak_log")
    // rust: .count() as u32;
    // Sorted by mod, then block: gears:shaft, then ruby's ruby_block, ruby_door, ruby_glass, ruby_log.
    // rust: let shaft = (n..assets.registry.len() as u32)
    // rust: .find(|&s| assets.registry.state(BlockStateId(s)).unwrap().name == "gears:shaft")
    // rust: .unwrap();
    // rust: assert_eq!(shaft, n);
    // rust: assert!(assets.registry.default_state("ruby:ruby_log").is_some());
    // rust: assert_eq!(
    // rust: assets.registry.len() as u32,
    // rust: n + log_states + 1 + 64 + 1 + log_states
    // rust: );
    // rust: let ids = horizon_protocol::registry::Builtin::load(&root.join("registries.json")).unwrap();
    // rust: for item in ["gears:shaft", "gears:wrench", "ruby:ruby_log"] {
    // rust: assert!(
    // rust: ids.get("minecraft:item").unwrap().id(item).is_some(),
    // rust: "{item}"
    // rust: );
}
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let items = Items::load(&root, assets.registry, &facts, &PackOverlay::NONE).unwrap();
    // rust: assert_eq!(items.items["gears:wrench"].max_stack, 1);
    // rust: assert!(items.items["gears:shaft"].block.is_some());
    // The same declarations reuse the root; others build a new one.
    // rust: assert_eq!(
    // rust: resource_root(&base, &mods, &scratch.join("cache")).unwrap(),
    // rust: root
    // rust: );
    // Changed declarations build a root of their own: the old one stays as
    // it was, for a switch back to that set.
    // rust: let stamp = fs::read(root.join(STAMP)).unwrap();
    // rust: mods[1].content.items[0].max_stack_size = Some(2);
    // rust: let changed = resource_root(&base, &mods, &scratch.join("cache")).unwrap();
    // rust: assert_ne!(changed, root);
    // rust: assert_ne!(fs::read(changed.join(STAMP)).unwrap(), stamp);
    // rust: assert_eq!(fs::read(root.join(STAMP)).unwrap(), stamp);
    // rust: let _ = fs::remove_dir_all(&scratch);
}

a_file_item_whose_remainder_was_refused_takes_only_its_mod_out :: proc() {
}
//     use horizon_mods::content::Item;
    // rust: let item = |id: &str, remainder: Option<&str>| Item {
    // rust: id: id.into(),
    // rust: template: "minecraft:diamond".into(),
    // rust: crafting_remainder: remainder.map(str::to_owned),
    // rust: ..Item::default()
}
    // rust: let make = |id: &str, items: Vec<Item>| {
    // rust: let mut content = Content::declared(id);
    // rust: content.items = items;
    // rust: ContentMod {
    // rust: id: id.into(),
    // rust: content,
}
}
    // rust: let mut jar = make("jar", vec![item("jar:tool", Some("jar:jar"))]);
    // rust: jar.content.blocks.push(horizon_mods::content::Block {
    // rust: id: "jar:jar".into(),
    // rust: template: "minecraft:glass".into(),
    // rust: item: true,
    // rust: ..Default::default()
    // rust: });
    // rust: let mut mods = vec![
    // rust: jar,
    // rust: make(
    // rust: "good",
    // rust: vec![
    // rust: item("good:tool", Some("good:wrench")),
    // rust: item("good:wrench", None),
    // rust: ],
    // rust: ),
    // rust: make("bad", vec![item("bad:tool", Some("bad:wrench"))]),
    // rust: make(
    // rust: "vanilla",
    // rust: vec![item("vanilla:soup", Some("minecraft:bowl"))],
    // rust: ),
    // rust: ];
    // rust: let dropped = drop_dangling_remainders(&mut mods);
    // rust: assert_eq!(dropped.len(), 1, "{dropped:?}");
    // rust: assert!(dropped[0].contains("bad"), "{dropped:?}");
    // rust: let left: Vec<&str> = mods.iter().map(|m| m.id.as_str()).collect();
    // A remainder that is the mod's own block item is kept too (`jar`).
    // rust: assert_eq!(left, ["jar", "good", "vanilla"]);
}

// A sign's four forms come from its template, whatever the blocks are named,
// its wood from its declaration, and its item places the wall form it names
// and is that form's item too. A `road_sign` of stone is no sign.
signs_take_their_form_wood_and_wall_block_from_their_declaration :: proc() {
}
//     use horizon_world::level::{Behaviours, ItemKind};

    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-signs-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("signs"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("signs", "")),
    // rust: (
    // rust: "data/signs/horizon/block/notice.json",
    // rust: r#"{"template": "minecraft:oak_sign", "wood_type": "signs:elm", "wall_block": "signs:board"}"#,
    // rust: ),
    // rust: (
    // rust: "data/signs/horizon/block/board.json",
    // rust: r#"{"template": "minecraft:oak_wall_sign", "wood_type": "signs:elm", "item": false}"#,
    // rust: ),
    // rust: (
    // rust: "data/signs/horizon/block/lantern.json",
    // rust: r#"{"template": "minecraft:spruce_hanging_sign", "wall_block": "signs:bracket"}"#,
    // rust: ),
    // rust: (
    // rust: "data/signs/horizon/block/bracket.json",
    // rust: r#"{"template": "minecraft:spruce_wall_hanging_sign", "wood_type": "cherry", "item": false}"#,
    // rust: ),
    // rust: (
    // rust: "data/signs/horizon/block/road_sign.json",
    // rust: r#"{"template": "minecraft:stone"}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, std::slice::from_ref(&m), &scratch.join("cache")).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = BlockFacts::load(&root, registry).unwrap();
    // rust: let behaviours = Behaviours::load(registry, &root).unwrap();
    // rust: let block = |name: &str| facts.get(registry.default_state(name).unwrap());
    // rust: let form = |hanging, wall| Some(crate::blocks::SignForm { hanging, wall });
    // rust: assert_eq!(block("signs:notice").sign_form(), form(false, false));
    // rust: assert_eq!(block("signs:board").sign_form(), form(false, true));
    // rust: assert_eq!(block("signs:lantern").sign_form(), form(true, false));
    // rust: assert_eq!(block("signs:bracket").sign_form(), form(true, true));
    // rust: assert_eq!(block("signs:road_sign").sign_form(), None);
    // rust: assert_eq!(
    // rust: block("minecraft:oak_wall_sign").sign_form(),
    // rust: form(false, true)
    // rust: );
    // The declared wood, or the template's.
    // rust: assert_eq!(facts.wood_type("signs:notice"), Some("signs:elm"));
    // rust: assert_eq!(facts.wood_type("signs:bracket"), Some("cherry"));
    // rust: assert_eq!(facts.wood_type("signs:lantern"), Some("spruce"));
    // rust: assert_eq!(
    // rust: facts.wood_type("minecraft:dark_oak_wall_sign"),
    // rust: Some("dark_oak")
    // rust: );
    // rust: assert_eq!(facts.wood_type("signs:road_sign"), None);
    // Each item places its sign and the wall form it names, which it is the item of.
    // rust: let id = |name: &str| behaviours.table.block_by_name(name);
    // rust: let notice = behaviours.item_binding("signs:notice").unwrap();
    // rust: assert_eq!(notice.kind, ItemKind::StandingAndWall);
    // rust: assert_eq!(
    // rust: (Some(notice.block), notice.wall_block),
    // rust: (id("signs:notice"), id("signs:board"))
    // rust: );
    // rust: let lantern = behaviours.item_binding("signs:lantern").unwrap();
    // rust: assert_eq!(lantern.kind, ItemKind::HangingSign);
    // rust: assert_eq!(
    // rust: (Some(lantern.block), lantern.wall_block),
    // rust: (id("signs:lantern"), id("signs:bracket"))
    // rust: );
    // rust: assert_eq!(&*block("signs:board").item, "signs:notice");
    // rust: assert_eq!(&*block("signs:bracket").item, "signs:lantern");
    // rust: let mut renderer =
    // rust: crate::block_entity_render::BlockEntityRenderer::load(&root, registry).unwrap();
    // rust: renderer.add_mod_signs(&facts, registry);
    // rust: for name in [
    // rust: "signs:notice",
    // rust: "signs:board",
    // rust: "signs:lantern",
    // rust: "signs:bracket",
    // rust: ] {
    // rust: assert!(
    // rust: renderer.renders(registry.default_state(name).unwrap().0),
    // rust: "{name}"
    // rust: );
}
    // rust: assert!(!renderer.renders(registry.default_state("signs:road_sign").unwrap().0));
    // Vanilla's pair stays as it was.
    // rust: let oak = behaviours.item_binding("minecraft:oak_sign").unwrap();
    // rust: assert_eq!(oak.wall_block, id("minecraft:oak_wall_sign"));
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// `WorldGenRegion.setBlock`: a feature that places a mod's sign leaves it its
// block entity, which goes by the template's class and not the block's name.
a_feature_gives_a_mods_sign_its_block_entity :: proc() {
}
//     use crate::containers::BlockEntity;
//     use crate::streaming::{ChunkGenerator, Proto};

    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch =
    // rust: std::env::temp_dir().join(format!("horizon-mod-sign-feature-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let m = folder_mod(
    // rust: &scratch.join("post"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("post", "")),
    // rust: (
    // rust: "data/post/horizon/block/notice.json",
    // rust: r#"{"template": "minecraft:oak_sign"}"#,
    // rust: ),
    // rust: (
    // rust: "data/post/worldgen/configured_feature/notice.json",
    // rust: r#"{"type": "minecraft:ore", "size": 9, "discard_chance_on_air_exposure": 0.0,
    // rust: "targets": [{"target": {"predicate_type": "minecraft:tag_match",
    // rust: "tag": "minecraft:stone_ore_replaceables"},
    // rust: "state": "post:notice"}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/post/worldgen/placed_feature/notice.json",
    // rust: r#"{"feature": "post:notice", "placement": [
    // rust: {"type": "minecraft:count", "count": 40}, {"type": "minecraft:in_square"},
    // rust: {"type": "minecraft:height_range", "height": {"type": "minecraft:uniform",
    // rust: "min_inclusive": {"absolute": -32}, "max_inclusive": {"absolute": 48}}},
    // rust: {"type": "minecraft:biome"}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/post/neoforge/biome_modifier/add_notice.json",
    // rust: r##"{"type": "neoforge:add_features", "biomes": "#minecraft:is_overworld",
    // rust: "features": "post:notice", "step": "underground_ores"}"##,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let root = resource_root(&base, &[m], &scratch.join("cache")).unwrap();
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = BlockFacts::load(&root, registry).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let notice = registry.default_state("post:notice").unwrap().0;
    // rust: let generate = |signs: bool| -> (usize, usize) {
    // rust: let mut terrain =
    // rust: crate::vanillagen::VanillaTerrain::new(&root.join("worldgen"), registry, &biomes, 1234)
    // rust: .unwrap();
    // rust: if signs {
    // rust: terrain.add_mod_signs(&facts);
}
    // rust: let mut worker = terrain.worker();
    // rust: let mut region: [Proto; 9] =
    // rust: std::array::from_fn(|i| terrain.proto(&mut worker, i as i32 % 3 - 1, i as i32 / 3 - 1));
    // rust: terrain.decorate(&mut worker, &mut region);
    // rust: let [_, _, _, _, center, ..] = region;
    // rust: let chunk = terrain.finish(center);
    // rust: let mut placed = 0;
    // rust: for y in chunk.min_y()..chunk.max_y() {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: placed += usize::from(chunk.get(x, y, z) == notice);
}
}
}
    // rust: let entities = chunk
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter(|(_, e)| matches!(e, BlockEntity::Sign(s) if !s.hanging))
    // rust: .count();
    // rust: (placed, entities)
}
    // rust: let (placed, entities) = generate(false);
    // rust: assert!(placed > 0, "the feature places the sign");
    // rust: assert_eq!(entities, 0, "by its name alone it has none");
    // rust: assert_eq!(generate(true), (placed, placed));
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// A small stand-in for the base root: nested folders, an empty file, an empty folder.
small_base :: proc(base: ^Path) {
}
    // rust: for (name, bytes) in [
    // rust: ("items.json", &b"{}"[..]),
    // rust: ("empty.log", &b""[..]),
    // rust: ("assets/minecraft/lang/en_us.json", &b"{\"a\": 1}"[..]),
    // rust: (
    // rust: "data/minecraft/tags/block/logs.json",
    // rust: &b"{\"values\": []}"[..],
    // rust: ),
    // rust: ] {
    // rust: let path = base.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, bytes).unwrap();
}
    // rust: fs::create_dir_all(base.join("worldgen/empty-folder")).unwrap();
}

// Every folder (`None`) and file (`Some(bytes)`) under `root`, by relative path.
tree :: proc(root: ^Path) -> B {
    // Ported from Horizon
    return {}
}
walk :: proc(root: ^Path, dir: ^Path, out: ^BTreeMap<string) {
}
    // rust: for entry in fs::read_dir(dir).unwrap().flatten() {
    // rust: let path = entry.path();
    // rust: let rel = path
    // rust: .strip_prefix(root)
    // rust: .unwrap()
    // rust: .to_string_lossy()
    // rust: .replace('\\', "/");
    // rust: if path.is_dir() {
    // rust: out.insert(rel, None);
    // rust: walk(root, &path, out);
    // rust: } else {
    // rust: out.insert(rel, Some(fs::read(&path).unwrap()));
}
}
}
    // rust: let mut out = BTreeMap::new();
    // rust: walk(root, root, &mut out);
    // rust: out
}

// Writes into a file where it is (same data), not by replacing it: what a link shares and a copy does not.
edit_in_place :: proc(path: ^Path, bytes: []u8) {
}
//     use std::io::Write;
    // rust: let mut file = fs::File::options()
    // rust: .write(true)
    // rust: .truncate(true)
    // rust: .open(path)
    // rust: .unwrap();
    // rust: file.write_all(bytes).unwrap();
}

// The overlay looks like the base, and shares its files (a hard link on Windows, a symlink elsewhere) rather than
// holding copies of them.
the_overlay_shares_the_base_files :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-share-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let (base, out) = (scratch.join("base"), scratch.join("root"));
    // rust: small_base(&base);
    // rust: Overlay::new(&base, &out).unwrap();
    // rust: assert_eq!(tree(&out), tree(&base));
    // rust: edit_in_place(
    // rust: &base.join("assets/minecraft/lang/en_us.json"),
    // rust: b"{\"a\": 2}",
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/lang/en_us.json")).unwrap(),
    // rust: b"{\"a\": 2}",
    // rust: "the overlay copied the base file instead of linking it"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// Writing a file of the overlay replaces the name, so the base file it was linked to keeps its bytes and the other
// files of the overlay still follow the base.
writing_into_the_overlay_leaves_the_base_alone :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-write-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let (base, out) = (scratch.join("base"), scratch.join("root"));
    // rust: small_base(&base);
    // rust: let overlay = Overlay::new(&base, &out).unwrap();
    // rust: let before = tree(&base);
    // rust: overlay
    // rust: .write(
    // rust: "data/minecraft/tags/block/logs.json",
    // rust: b"{\"values\": [\"mod:log\"]}",
    // rust: )
    // rust: .unwrap();
    // rust: overlay.write("items.json", b"{\"mod\": 1}").unwrap();
    // rust: overlay.write("assets/mod/new.json", b"{}").unwrap();
    // rust: assert_eq!(tree(&base), before, "a write reached the base");
    // rust: assert_eq!(
    // rust: fs::read(out.join("data/minecraft/tags/block/logs.json")).unwrap(),
    // rust: b"{\"values\": [\"mod:log\"]}"
    // rust: );
    // rust: assert_eq!(fs::read(out.join("items.json")).unwrap(), b"{\"mod\": 1}");
    // rust: edit_in_place(
    // rust: &base.join("assets/minecraft/lang/en_us.json"),
    // rust: b"{\"a\": 3}",
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/lang/en_us.json")).unwrap(),
    // rust: b"{\"a\": 3}"
    // rust: );
    // A rebuild starts by removing the overlay: that removes names, not the base's data.
    // rust: fs::remove_dir_all(&out).unwrap();
    // rust: assert_eq!(fs::read(base.join("items.json")).unwrap(), b"{}");
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// Where a hard link cannot be made (another volume, a filesystem without links) a file is copied, as it always was
// on Windows; where it can, the file is linked.
a_file_is_linked_or_else_copied :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-linkfile-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: fs::create_dir_all(&scratch).unwrap();
    // rust: let target = scratch.join("base.json");
    // rust: fs::write(&target, b"original").unwrap();

    // rust: let linked = scratch.join("linked.json");
    // rust: link_file(&target, &linked, |from, to| fs::hard_link(from, to)).unwrap();
    // rust: edit_in_place(&target, b"edited");
    // rust: assert_eq!(fs::read(&linked).unwrap(), b"edited", "not a link");

    // rust: let copied = scratch.join("copied.json");
    // rust: fs::write(&target, b"original").unwrap();
    // rust: link_file(&target, &copied, |_, _| {
    // rust: Err(std::io::Error::other("no links here"))
    // rust: })
    // rust: .unwrap();
    // rust: edit_in_place(&target, b"edited");
    // rust: assert_eq!(fs::read(&copied).unwrap(), b"original", "not a copy");

    // A target that is not there is an error whichever way the file is made.
    // rust: let missing = link_file(
    // rust: &scratch.join("missing.json"),
    // rust: &scratch.join("x.json"),
    // rust: |from, to| fs::hard_link(from, to),
    // rust: );
    // rust: assert!(missing.is_err());
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// A symlink in the base is copied through, as before; linked, the overlay's file would be a symlink too.
a_symlink_file_is_copied_through :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-symfile-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: fs::create_dir_all(&scratch).unwrap();
    // rust: fs::write(scratch.join("real.json"), b"real").unwrap();
    // rust: std::os::unix::fs::symlink("real.json", scratch.join("alias.json")).unwrap();
    // rust: let at = scratch.join("copy.json");
    // rust: link_file(&scratch.join("alias.json"), &at, |from, to| {
    // rust: fs::hard_link(from, to)
    // rust: })
    // rust: .unwrap();
    // rust: assert!(!fs::symlink_metadata(&at).unwrap().file_type().is_symlink());
    // rust: assert_eq!(fs::read(&at).unwrap(), b"real");
    // rust: let _ = fs::remove_dir_all(&scratch);
}

// A content mod of recipes, a tag and a name, for vanilla's items: what
// switches live (docs/design/mod-hotload.md).
glint_mod :: proc(dir: ^Path) -> C {
    // Ported from Horizon
    return {}
}
    // rust: folder_mod(
    // rust: dir,
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("glint", "")),
    // rust: (
    // rust: "data/glint/recipe/diamond_from_dirt.json",
    // rust: r#"{"type": "minecraft:crafting_shapeless", "category": "misc",
    // rust: "ingredients": ["minecraft:dirt", "minecraft:dirt"],
    // rust: "result": {"id": "minecraft:diamond"}}"#,
    // rust: ),
    // rust: (
    // rust: "data/c/tags/item/gems/glint.json",
    // rust: r#"{"values": ["minecraft:diamond"]}"#,
    // rust: ),
    // rust: (
    // rust: "assets/glint/lang/en_us.json",
    // rust: r#"{"glint.hello": "Hello"}"#,
    // rust: ),
    // rust: ],
    // rust: )
}

only_assets_and_data_switch_live :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-live-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: assert_eq!(
    // rust: live_switch(&glint_mod(&scratch.join("glint")).content),
    // rust: Ok(())
    // rust: );
    // rust: let ruby = ruby_mod(&scratch.join("ruby"));
    // rust: assert_eq!(
    // rust: live_switch(&ruby.content),
    // rust: Err("horizon.mods.switch.registries")
    // rust: );
    // rust: let effect = folder_mod(
    // rust: &scratch.join("fx"),
    // rust: &[
    // rust: ("horizon-mod.toml", &manifest("fx", "")),
    // rust: (
    // rust: "data/fx/horizon/mob_effect/glow.json",
    // rust: r#"{"category": "harmful", "color": 1}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: live_switch(&effect.content),
    // rust: Err("horizon.mods.switch.registries")
    // rust: );
    // rust: for (id, file, text) in [
    // rust: (
    // rust: "ores",
    // rust: "data/ores/neoforge/biome_modifier/add.json",
    // rust: r#"{"type": "neoforge:none"}"#,
    // rust: ),
    // rust: (
    // rust: "village",
    // rust: "data/minecraft/tags/worldgen/biome/has_structure/village_plains.json",
    // rust: r#"{"values": []}"#,
    // rust: ),
    // rust: (
    // rust: "feat",
    // rust: "data/feat/worldgen/placed_feature/rock.json",
    // rust: r#"{"feature": "minecraft:ore_iron", "placement": []}"#,
    // rust: ),
    // rust: ] {
    // rust: let m = folder_mod(
    // rust: &scratch.join(id),
    // rust: &[("horizon-mod.toml", &manifest(id, "")), (file, text)],
    // rust: );
    // rust: assert_eq!(
    // rust: live_switch(&m.content),
    // rust: Err("horizon.mods.switch.worldgen"),
    // rust: "{file}"
    // rust: );
}
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

// On, off and on again: each root has what its set of mods has, a switch
// never changes a root a game was given, and a set seen before reuses its
// root without building it again.
a_data_mod_loads_unloads_and_loads_again :: proc() {
}
    // rust: let Some(base) = prepared() else {
    // rust: return;
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-reload-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let cache = scratch.join("cache");
    // rust: let glint = glint_mod(&scratch.join("glint"));
    // rust: let dirt = || Some(crate::items::ItemStack::new("minecraft:dirt", 1));
    // rust: let grid = [dirt(), dirt(), None, None];
    // What a world reads from a root: the item tags and the recipes.
    // rust: let tables = |root: &Path| {
    // rust: let assets = Assets::load(root).unwrap();
    // rust: let facts = BlockFacts::load(root, assets.registry).unwrap();
    // rust: let items = Items::load(root, assets.registry, &facts, &PackOverlay::NONE).unwrap();
    // rust: let recipes = crate::crafting::Recipes::load(root, &items, &PackOverlay::NONE).unwrap();
    // rust: let crafted = recipes.find(&grid, 2).map(|(_, out)| out.item.to_string());
    // rust: let tagged = items.item_tag_order.get("c:gems/glint").cloned();
    // rust: (
    // rust: crafted,
    // rust: tagged,
    // rust: root.join("assets/glint/lang/en_us.json").is_file(),
    // rust: )
}
    // rust: let loaded = (
    // rust: Some("minecraft:diamond".to_owned()),
    // rust: Some(vec!["minecraft:diamond".to_owned()]),
    // rust: true,
    // rust: );

    // rust: let started = std::time::Instant::now();
    // rust: let on = resource_root(&base, std::slice::from_ref(&glint), &cache).unwrap();
    // rust: eprintln!("content root built in {} ms", started.elapsed().as_millis());
    // rust: assert_ne!(on, base);
    // rust: assert_eq!(tables(&on), loaded);

    // Off: the base root, without any of it.
    // rust: let off = resource_root(&base, &[], &cache).unwrap();
    // rust: assert_eq!(off, base);
    // rust: assert_eq!(tables(&off), (None, None, false));
    // rust: assert!(on.join("assets/glint/lang/en_us.json").is_file());

    // On again: the same root, not built again.
    // rust: let sentinel = on.join("sentinel");
    // rust: fs::write(&sentinel, b"").unwrap();
    // rust: let started = std::time::Instant::now();
    // rust: let again = resource_root(&base, std::slice::from_ref(&glint), &cache).unwrap();
    // rust: eprintln!(
    // rust: "content root reused in {} ms",
    // rust: started.elapsed().as_millis()
    // rust: );
    // rust: assert_eq!(again, on);
    // rust: assert!(sentinel.exists());
    // rust: assert_eq!(tables(&again), loaded);

    // Another set of mods builds its own root beside it and leaves this one as it was.
    // rust: let ruby = ruby_mod(&scratch.join("ruby"));
    // rust: let package = horizon_mods::Package::read(&scratch.join("glint")).unwrap();
    // rust: let glint_again = ContentMod {
    // rust: id: "glint".into(),
    // rust: content: Content::read(&scratch.join("glint"), &package.manifest).unwrap(),
}
    // rust: let both = resource_root(&base, &[glint_again, ruby], &cache).unwrap();
    // rust: assert_ne!(both, on);
    // rust: assert!(sentinel.exists());
    // rust: assert_eq!(tables(&both).0, loaded.0);
    // rust: fs::remove_dir_all(&scratch).unwrap();
}

roots_unused_for_a_day_are_removed :: proc() {
}
    // rust: let scratch = std::env::temp_dir().join(format!("horizon-mod-prune-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&scratch);
    // rust: let roots = scratch.join("mod-content");
    // rust: let root = |name: &str, age_s: u64| {
    // rust: let dir = roots.join(name);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let stamp = dir.join(STAMP);
    // rust: fs::write(&stamp, b"x").unwrap();
    // rust: let file = fs::File::options().write(true).open(&stamp).unwrap();
    // rust: file.set_modified(std::time::SystemTime::now() - std::time::Duration::from_secs(age_s))
    // rust: .unwrap();
    // rust: dir
}
    // rust: let current = root("00000000000000aa", 3 * 86400);
    // rust: let recent = root("00000000000000bb", 60);
    // rust: let stale = root("00000000000000cc", 2 * 86400);
    // Not a root's name: never touched while the folder has no root of the old layout.
    // rust: let other = roots.join("notes");
    // rust: fs::create_dir_all(&other).unwrap();
    // rust: prune_roots(&roots, &current, KEEP_ROOTS);
    // rust: assert!(current.exists() && recent.exists() && other.exists());
    // rust: assert!(!stale.exists());
    // An older game's single root, built straight in the folder, goes.
    // rust: fs::write(roots.join(STAMP), b"old").unwrap();
    // rust: fs::create_dir_all(roots.join("assets/minecraft")).unwrap();
    // rust: prune_roots(&roots, &current, KEEP_ROOTS);
    // rust: assert!(!roots.join(STAMP).exists() && !roots.join("assets").exists());
    // rust: assert!(current.exists() && recent.exists());
    // rust: fs::remove_dir_all(&scratch).unwrap();
}
