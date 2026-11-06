//! Transpiled from Horizon Rust crate
package horizon_world_item_defaults

import "core:fmt"
import "core:mem"
import "core:math"

// Items' default components, as everything in the game reads them: the
// resource root's `items.json` (vanilla's default-component report, with a
// content mod's items), then what native mods change in it
// ([`native_modify_default_components`], NeoForge's `ModifyDefaultComponentsEvent`).
// The item table, loot, enchanting, item models and the other readers all
// come through [`read`], so a mod's change reaches each of them, and stacks
// are saved and sent against the changed defaults as against vanilla's.

// use serde_json::{Map, Value};
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs, io,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex, Weak},
}

// An immutable default-component snapshot. Kept only while a resource load
// holds it: a later load reads the files and applies native hooks afresh.
    // rust: pub type Defaults = BTreeMap<String, Value>;
SHARED :: Mutex::new(Vec::new())

// Share parsed defaults with the other tables built during this load. Callers
// that need a fresh read regardless of other loads can still use [`read`].
shared :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let held = || {
    // rust: SHARED
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .iter()
    // rust: .find(|(path, _)| path == root)
    // rust: .and_then(|(_, value)| value.upgrade())
}
    // rust: if let Some(value) = held() {
    // rust: return Ok(value);
}
    // Native hooks run without the cache lock, so they can read other data.
    // rust: let value = Arc::new(read(root)?);
    // rust: let mut cache = SHARED.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(other) = cache
    // rust: .iter()
    // rust: .find(|(path, _)| path == root)
    // rust: .and_then(|(_, v)| v.upgrade())
    // rust: {
    // rust: return Ok(other);
}
    // rust: cache.retain(|(_, value)| value.strong_count() > 0);
    // rust: cache.push((root.to_owned(), Arc::downgrade(&value)));
    // rust: Ok(value)
}

// The largest stack size a native mod may set: `ItemStack.count` is a `u32`,
// but the count is a VarInt on the wire and is saved as an `int`, so a
// larger one would turn negative (and lose its item) on the way out.
MAX_STACK_SIZE :: i32::MAX as i64

// Vanilla's `ExtraCodecs.intRange(1, 99)` on a data pack's own value.
VANILLA_MAX_STACK_SIZE :: 99
STACK_SIZE :: "minecraft:max_stack_size"

// `value` as a stack size in `1..=max`, or None when it is not a number.
stack_size :: proc(value: ^Value, max: i64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: value.as_f64().map(|n| (n as i64).clamp(1, max))
}

// Hook point for native mods (docs/native-mods.md, listed in `native-hooks.json`
// with those of `horizon-client/src/game/native_hooks.rs`): `components` holds
// `item`'s default components in `items.json`'s form (`"minecraft:max_stack_size": 16`,
// `"minecraft:food": {"nutrition": 4, "saturation": 2.4}`); insert or replace one to
// set it, remove it to take it away (a stack size outside 1 to `i32::MAX` is
// brought back into it, and one that is not a number leaves the data pack's
// own). Asked for every item each time the game reads the defaults, from any
// thread, several times as resources load and again when a world's data packs
// load: answer the same each time. Client and server each ask their own mods,
// as NeoForge does, so both sides need the mod.
// 79.
native_modify_default_components :: proc(item: string, components: ^Map<string) {
}
    // rust: crate::native_load_hooks::modify_default_components(item, components);
}

// Every item's default components at `root`, by item id, with the mods'
// changes applied. A data pack's own stack size is kept to vanilla's 1 to 99
// (`ExtraCodecs.intRange`); a mod's, which no codec decodes, to 1 to
// [`MAX_STACK_SIZE`], the count the wire and the save carry.
read :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut items: BTreeMap<String, Value> =
    // rust: serde_json::from_slice(&fs::read(root.join("items.json"))?)?;
    // rust: for (item, components) in &mut items {
    // rust: if let Value::Object(components) = components {
            // A data pack's own value goes through vanilla's codec.
    // rust: if let Some(size) = components
    // rust: .get(STACK_SIZE)
    // rust: .and_then(|size| stack_size(size, VANILLA_MAX_STACK_SIZE))
    // rust: {
    // rust: components.insert(STACK_SIZE.into(), size.into());
}
    // rust: let pack = components.get(STACK_SIZE).cloned();
    // rust: native_modify_default_components(item, components);
            // The hook bypasses the codec, and a size of 0 would break stack
            // arithmetic; keep whatever it leaves a number every reader can
            // use. A mod that takes the component away keeps it away, and a
            // value that is not a number falls back to the data pack's (each
            // table would otherwise read its own default from it).
    // rust: match components.get(STACK_SIZE).cloned() {
    // rust: None => {}
    // rust: Some(size) => match stack_size(&size, MAX_STACK_SIZE) {
    // rust: Some(size) => {
    // rust: components.insert(STACK_SIZE.into(), size.into());
}
    // rust: None => match pack {
    // rust: Some(pack) => {
    // rust: components.insert(STACK_SIZE.into(), pack);
}
    // rust: None => {
    // rust: components.remove(STACK_SIZE);
}
    // rust: },
    // rust: },
}
}
}
    // rust: Ok(items)
}

    // rust: mod tests {
//     use std::fs;

a_load_shares_one_snapshot_and_the_next_load_reads_changes :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-default-snapshot-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: let write = |size| {
    // rust: fs::write(
    // rust: root.join("items.json"),
    // rust: format!(r#"{{"test:item":{{"minecraft:max_stack_size":{size}}}}}"#),
    // rust: )
    // rust: .unwrap()
}
    // rust: write(16);
    // rust: let first = super::shared(&root).unwrap();
    // rust: write(64);
    // rust: let second = super::shared(&root).unwrap();
    // rust: assert_eq!(second["test:item"]["minecraft:max_stack_size"], 16);
        // Explicit fresh reads remain available even while a load owns its snapshot.
    // rust: assert_eq!(
    // rust: super::read(&root).unwrap()["test:item"]["minecraft:max_stack_size"],
    // rust: 64
    // rust: );
    // rust: drop((first, second));
    // rust: let next = super::shared(&root).unwrap();
    // rust: assert_eq!(next["test:item"]["minecraft:max_stack_size"], 64);
    // rust: drop(next);
    // rust: fs::write(root.join("items.json"), "broken").unwrap();
    // rust: assert!(super::shared(&root).is_err());
    // rust: write(2);
    // rust: assert_eq!(
    // rust: super::shared(&root).unwrap()["test:item"]["minecraft:max_stack_size"],
    // rust: 2
    // rust: );
    // rust: fs::remove_dir_all(root).unwrap();
}

    // A data pack's stack size is kept to vanilla's 1..=99, so stack
    // arithmetic never sees a 0, and a mod may raise it above 99 (up to the
    // count the wire and the save carry).
data_pack_sizes_stay_in_vanilla_range :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-stack-sizes-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: let items = r#"{"a:none": {"minecraft:max_stack_size": 0},
    // rust: "a:less": {"minecraft:max_stack_size": -5},
    // rust: "a:many": {"minecraft:max_stack_size": 500},
    // rust: "a:some": {"minecraft:max_stack_size": 16}, "a:unset": {}}"#;
    // rust: fs::write(root.join("items.json"), items).unwrap();
    // rust: let items = super::read(&root).unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let size = |id: &str| items[id].get("minecraft:max_stack_size").cloned();
    // rust: assert_eq!(
    // rust: ["a:none", "a:less", "a:many", "a:some", "a:unset"].map(size),
    // rust: [
    // rust: Some(1.into()),
    // rust: Some(1.into()),
    // rust: Some(99.into()),
    // rust: Some(16.into()),
    // rust: None
    // rust: ]
    // rust: );
}

    // A mod's own size is kept to 1..=i32::MAX, a value that is not a number
    // leaves the data pack's, and a removed component stays removed.
mod_sizes_are_sanitised :: proc() {
}
    // rust: let _ = crate::native_load_hooks::install(crate::native_load_hooks::NativeLoadHooks {
    // rust: loot_table_load: |_, _| {},
    // rust: modify_default_components: |item, components| match item {
    // rust: "a:raised" => {
    // rust: components.insert(super::STACK_SIZE.into(), 500.into());
}
    // rust: "a:zero" => {
    // rust: components.insert(super::STACK_SIZE.into(), 0.into());
}
    // rust: "a:huge" => {
    // rust: components.insert(super::STACK_SIZE.into(), u64::MAX.into());
}
    // rust: "a:string" => {
    // rust: components.insert(super::STACK_SIZE.into(), "500".into());
}
    // rust: "a:removed" => {
    // rust: components.remove(super::STACK_SIZE);
}
    // rust: _ => {}
    // rust: },
    // rust: loot_function: |_, _, _, _| {},
    // rust: loot_condition: |_, _, _, _| {},
    // rust: });
    // rust: let root = std::env::temp_dir().join(format!("horizon-mod-sizes-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: let items = r#"{"a:raised": {"minecraft:max_stack_size": 64},
    // rust: "a:zero": {"minecraft:max_stack_size": 16},
    // rust: "a:huge": {"minecraft:max_stack_size": 64},
    // rust: "a:string": {"minecraft:max_stack_size": 16},
    // rust: "a:removed": {"minecraft:max_stack_size": 64}}"#;
    // rust: fs::write(root.join("items.json"), items).unwrap();
    // rust: let items = super::read(&root).unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let size = |id: &str| items[id].get("minecraft:max_stack_size").cloned();
    // rust: assert_eq!(
    // rust: ["a:raised", "a:zero", "a:huge", "a:string", "a:removed"].map(size),
    // rust: [
    // rust: Some(500.into()),
    // rust: Some(1.into()),
    // rust: Some(super::MAX_STACK_SIZE.into()),
    // rust: Some(16.into()),
    // rust: None
    // rust: ]
    // rust: );
}
}
