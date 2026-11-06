//! Transpiled from Horizon Rust crate
//! Module: horizon-world_lazy_json
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! JSON data kept as its text and read into a [`Value`] the first time it is
//! used. A `Value` holds a B-tree node (~0.5 KB) per object: data packs'
//! small, many files (loot tables, advancement criteria) took ~10× their
//! JSON's size, most of it never read.
// use serde_json::Value;
// use std::sync::OnceLock;

pub const LazyJson = struct {
    json: *str,
    value: OnceLock<Value>,
};
    // rust: impl LazyJson {
    /// `value`'s JSON, read back on first use.
pub fn new(value: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: json: value.to_string().into_boxed_str(),
    // rust: value: OnceLock::new(),
}
}
    /// The value, read once and kept.
pub fn get(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value
    // rust: .get_or_init(|| serde_json::from_str(&self.json).expect("written from a Value"))
}
    /// The JSON text as written, without reading it.
pub fn json(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.json
}
    /// The value without keeping it: for a pass over every entry (an
    /// index) that would otherwise keep them all.
pub fn read(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.value.get() {
    // rust: Some(value) => std::borrow::Cow::Borrowed(value),
    // rust: None => std::borrow::Cow::Owned(
    // rust: serde_json::from_str(&self.json).expect("written from a Value"),
    // rust: ),
}
}
}
    // rust: impl std::ops::Deref for LazyJson {
    // rust: type Target = Value;
pub fn deref(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get()
}
}
    // rust: impl From<Value> for LazyJson {
pub fn from(value: Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lazy = Self::new(&value);
        // Already read: keep it rather than read it again.
    // rust: let _ = lazy.value.set(value);
    // rust: lazy
}
}
    // rust: impl Clone for LazyJson {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: json: self.json.clone(),
    // rust: value: self.value.clone(),
}
}
}
    // rust: impl std::fmt::Debug for LazyJson {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(&self.json)
}
}

    // rust: mod tests {
//     use super::*;

    /// Read back as written: floats, integers past 2^53, escapes, nesting,
    /// and `read` gives the same value without keeping it.
pub fn reads_back_as_written() void {
}
    // rust: let value: Value = serde_json::from_str(
    // rust: r#"{"rolls": 1.5, "min": -2.25e-7, "max": 1e300, "weight": 9007199254740993,
    // rust: "name": "é\n\"", "z": null, "a": [true, false, {"b": []}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let lazy = LazyJson::new(&value);
    // rust: assert_eq!(*lazy.read(), value);
    // rust: assert!(lazy.value.get().is_none());
    // rust: assert_eq!(lazy.get(), &value);
    // rust: assert_eq!(lazy["a"][2]["b"], Value::Array(vec![]));
    // rust: assert_eq!(*lazy.clone(), value);
}
}
