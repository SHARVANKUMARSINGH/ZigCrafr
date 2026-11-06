//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_providers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's `context_int_provider` and `context_float_provider` values (furnace
//! fuel times, brewing times), evaluated from the data pack's JSON.
// use crate::items::{ItemStack, Items};
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path};

/// Evaluator for `context_int_provider` / `context_float_provider` values.
pub const Providers = struct {
    ints: HashMap<[]const u8,
    floats: HashMap<[]const u8,
};
pub fn load_dir(dir: *Path, prefix: []const u8, out: *mut HashMap<[]const u8) void {
}
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}
    // rust: for e in entries.flatten() {
    // rust: let p = e.path();
    // rust: let name = p
    // rust: .file_stem()
    // rust: .and_then(|s| s.to_str())
    // rust: .unwrap_or("")
    // rust: .to_owned();
    // rust: if p.is_dir() {
    // rust: load_dir(&p, &format!("{prefix}{name}/"), out);
    // rust: } else if let Ok(bytes) = fs::read(&p)
    // rust: && let Ok(v) = serde_json::from_slice(&bytes)
    // rust: {
    // rust: out.insert(format!("minecraft:{prefix}{name}"), v);
}
}
}
    // rust: impl Providers {
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ints = HashMap::new();
    // rust: let mut floats = HashMap::new();
    // rust: load_dir(
    // rust: &root.join("data/minecraft/context_int_provider"),
    // rust: "",
    // rust: &mut ints,
    // rust: );
    // rust: load_dir(
    // rust: &root.join("data/minecraft/context_float_provider"),
    // rust: "",
    // rust: &mut floats,
    // rust: );
    // rust: Self { ints, floats }
}
pub fn eval(v: *Value, fast: bool, table: *HashMap<[]const u8, depth: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 16 {
    // rust: return 0.0;
}
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().unwrap_or(0.0),
    // rust: Value::String(name) => table
    // rust: .get(name)
    // rust: .map_or(0.0, |v| Self::eval(v, fast, table, depth + 1)),
    // rust: Value::Object(o) => {
    // rust: let f =
    // rust: |k: &str| Self::eval(o.get(k).unwrap_or(&Value::Null), fast, table, depth + 1);
    // rust: match o.get("type").and_then(Value::as_str).unwrap_or("") {
    // rust: "minecraft:div" => {
    // rust: let r = f("right");
    // rust: if r == 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: (f("left") / r).trunc()
}
}
    // rust: "minecraft:mul" => f("left") * f("right"),
    // rust: "minecraft:add" | "minecraft:sum" => f("left") + f("right"),
    // rust: "minecraft:sub" => f("left") - f("right"),
    // rust: "minecraft:constant" => f("value"),
    // rust: "minecraft:conditional" => {
                        // The only condition in the pinned data: block/fast_cooking.
    // rust: let condition = o.get("condition").and_then(Value::as_str)
    // rust: == Some("minecraft:block/fast_cooking");
    // rust: if condition && fast {
    // rust: f("on_true")
    // rust: } else {
    // rust: f("on_false")
}
}
    // rust: _ => 0.0,
}
}
    // rust: _ => 0.0,
}
}
    /// A plain `context_int_provider` value or reference (no context conditions).
pub fn int_value(self: *Self, v: *Value) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::eval(v, false, &self.ints, 0) as i32
}
    /// A plain `context_float_provider` value or reference; `default` when absent.
pub fn float_value(self: *Self, v: *Value, default: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v.is_null() {
    // rust: default
    // rust: } else {
    // rust: Self::eval(v, false, &self.floats, 0) as f32
}
}
pub fn empty() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: ints: HashMap::new(),
    // rust: floats: HashMap::new(),
}
}
pub fn burn_time(self: *Self, items: *Items, stack: *ItemStack, fast: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.fuel.as_ref())
    // rust: .map_or(0, |(time, _)| Self::eval(time, fast, &self.ints, 0) as i32)
}
pub fn speed(self: *Self, items: *Items, stack: *ItemStack, fast: bool) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.fuel.as_ref())
    // rust: .map_or(1.0, |(_, speed)| {
    // rust: Self::eval(speed, fast, &self.floats, 0) as f32
    // rust: })
}
}
