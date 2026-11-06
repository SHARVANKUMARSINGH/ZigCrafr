//! Transpiled from Horizon Rust crate
//! Module: horizon-world_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::DATA_VERSION;
// use serde_json::json;
// use std::{
    // rust: path::PathBuf,
    // rust: sync::atomic::{AtomicU64, Ordering},
}

pub const Fixture = struct {};
    // rust: impl Fixture {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: AtomicU64 = AtomicU64::new(0);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-damage-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: let types: Vec<_> = ["fall", "stalagmite", "starve"].into_iter().map(|name| json!({
    // rust: "id": format!("minecraft:{name}"), "message_id": name,
    // rust: "exhaustion": "3dcccccd", "scaling": "never", "effects": "hurt", "death_message_type": "default"
    // rust: })).collect();
    // rust: fs::write(
    // rust: root.join("damage-catalog.json"),
    // rust: json!({"data_version": DATA_VERSION, "types": types}).to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("damage-tags.json"),
    // rust: json!({"minecraft:bypasses_armor": "{\"values\":[\"minecraft:fall\"]}"}).to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: Self(root)
}
pub fn write(self: *Self, path: []const u8, value: Value) void {
}
    // rust: let path = self.0.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, value.to_string()).unwrap();
}
}
    // rust: impl Drop for Fixture {
pub fn drop(self: *Self) void {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}
pub fn definition(message: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({"message_id": message, "scaling": "never", "exhaustion": 0.125})
}
pub fn file(id: []const u8, value: Value) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (id.into(), vec![value.to_string().into_bytes()])
}

pub fn root_namespaces_and_ordered_world_overrides_preserve_vanilla_indices() void {
}
    // rust: let f = Fixture::new();
    // rust: let base = Catalog::load(&f.0, &PackOverlay::NONE).unwrap();
    // rust: let fall = base.id("minecraft:fall").unwrap();
    // rust: f.write("data/demo/damage_type/hot/air.json", definition("root"));
    // rust: let mut heat = file("damage_type/demo:hot/air", definition("low"));
    // rust: heat.1.push(definition("high").to_string().into_bytes());
    // rust: let files = vec![heat, file("damage_type/aaa:new", definition("new"))];
    // rust: let packed = base
    // rust: .with_packs(&f.0, &PackOverlay { files: &files })
    // rust: .unwrap();
    // rust: assert_eq!(packed.id("minecraft:fall"), Some(fall));
    // rust: assert_eq!(
    // rust: packed
    // rust: .definition(packed.id("demo:hot/air").unwrap())
    // rust: .unwrap()
    // rust: .message_id,
    // rust: "high"
    // rust: );
    // rust: assert_eq!(
    // rust: packed
    // rust: .definition(packed.id("aaa:new").unwrap())
    // rust: .unwrap()
    // rust: .effects,
    // rust: "hurt"
    // rust: );
    // rust: assert!(
    // rust: base.id("demo:hot/air").is_none(),
    // rust: "the immutable base is unchanged"
    // rust: );
}

pub fn reload_rebinds_tags_but_ignores_changed_removed_and_added_definitions() void {
}
    // rust: let f = Fixture::new();
    // rust: let files = vec![
    // rust: file("damage_type/demo:heat", definition("original")),
    // rust: file(
    // rust: "tags/minecraft:damage_type/is_fire",
    // rust: json!({"values":["demo:heat"]}),
    // rust: ),
    // rust: ];
    // rust: let open = Catalog::load(&f.0, &PackOverlay { files: &files }).unwrap();
    // rust: let heat = open.id("demo:heat").unwrap();
    // rust: assert!(open.in_tag(heat, "minecraft:is_fire"));
    // rust: let changed = vec![
    // rust: file("damage_type/demo:heat", json!({"invalid":true})),
    // rust: file("damage_type/demo:new", definition("added")),
    // rust: file(
    // rust: "tags/demo:damage_type/optional",
    // rust: json!({"values":[{"id":"demo:new","required":false}, "demo:heat"]}),
    // rust: ),
    // rust: ];
    // rust: let reloaded = open
    // rust: .reload_tags(&f.0, &PackOverlay { files: &changed })
    // rust: .unwrap();
    // rust: assert_eq!(reloaded.id("demo:heat"), Some(heat));
    // rust: assert_eq!(reloaded.definition(heat).unwrap().message_id, "original");
    // rust: assert!(reloaded.id("demo:new").is_none());
    // rust: assert!(!reloaded.in_tag(heat, "minecraft:is_fire"));
    // rust: assert_eq!(
    // rust: reloaded.tag_members("demo:optional").collect::<Vec<_>>(),
    // rust: ["demo:heat"]
    // rust: );
    // rust: let disabled = reloaded.reload_tags(&f.0, &PackOverlay::NONE).unwrap();
    // rust: assert_eq!(disabled.id("demo:heat"), Some(heat));
    // rust: assert_eq!(disabled.tag_members("demo:optional").count(), 0);
}

pub fn replace_nested_optional_and_missing_required_tags_share_one_resolution() void {
}
    // rust: let f = Fixture::new();
    // rust: f.write("data/demo/damage_type/heat.json", definition("heat"));
    // rust: f.write(
    // rust: "data/demo/tags/damage_type/nested.json",
    // rust: json!({"values":["demo:heat"]}),
    // rust: );
    // rust: let files = vec![
    // rust: file(
    // rust: "tags/minecraft:damage_type/bypasses_armor",
    // rust: json!({"replace":true,"values":["#demo:nested", {"id":"demo:absent","required":false}]}),
    // rust: ),
    // rust: file(
    // rust: "tags/demo:damage_type/broken",
    // rust: json!({"values":["demo:absent"]}),
    // rust: ),
    // rust: file(
    // rust: "tags/demo:damage_type/broken_child",
    // rust: json!({"values":["#demo:broken"]}),
    // rust: ),
    // rust: ];
    // rust: let catalog = Catalog::load(&f.0, &PackOverlay { files: &files }).unwrap();
    // rust: assert_eq!(
    // rust: catalog
    // rust: .tag_members("minecraft:bypasses_armor")
    // rust: .collect::<Vec<_>>(),
    // rust: ["demo:heat"]
    // rust: );
    // rust: assert!(!catalog.in_tag(
    // rust: catalog.id("minecraft:fall").unwrap(),
    // rust: "minecraft:bypasses_armor"
    // rust: ));
    // rust: assert!(
    // rust: !catalog
    // rust: .tags()
    // rust: .any(|id| id == "demo:broken" || id == "demo:broken_child")
    // rust: );
}

pub fn independent_worlds_never_share_reload_state() void {
}
    // rust: let f = Fixture::new();
    // rust: let a = vec![
    // rust: file("damage_type/demo:heat", definition("a")),
    // rust: file(
    // rust: "tags/minecraft:damage_type/is_fire",
    // rust: json!({"values":["demo:heat"]}),
    // rust: ),
    // rust: ];
    // rust: let b = vec![file("damage_type/demo:heat", definition("b"))];
    // rust: let a = Catalog::load(&f.0, &PackOverlay { files: &a }).unwrap();
    // rust: let b = Catalog::load(&f.0, &PackOverlay { files: &b }).unwrap();
    // rust: assert!(a.in_tag(a.id("demo:heat").unwrap(), "minecraft:is_fire"));
    // rust: assert!(!b.in_tag(b.id("demo:heat").unwrap(), "minecraft:is_fire"));
    // rust: let _ = a.reload_tags(&f.0, &PackOverlay::NONE).unwrap();
    // rust: assert_eq!(
    // rust: b.definition(b.id("demo:heat").unwrap()).unwrap().message_id,
    // rust: "b"
    // rust: );
}

pub fn invalid_top_definition_refuses_the_snapshot_without_mutating_base() void {
}
    // rust: let f = Fixture::new();
    // rust: let base = Catalog::load(&f.0, &PackOverlay::NONE).unwrap();
    // rust: let mut file = file("damage_type/demo:heat", definition("valid-low-priority"));
    // rust: file.1.push(
    // rust: json!({"message_id":"invalid", "scaling":"invalid", "exhaustion":0})
    // rust: .to_string()
    // rust: .into_bytes(),
    // rust: );
    // rust: assert!(
    // rust: base.with_packs(&f.0, &PackOverlay { files: &[file] })
    // rust: .is_err()
    // rust: );
    // rust: assert!(base.id("demo:heat").is_none());
}
