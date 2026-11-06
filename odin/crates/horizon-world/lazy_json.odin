//! Transpiled from Horizon Rust crate
package horizon_world_lazy_json

import "core:fmt"
import "core:mem"
import "core:math"

// JSON data kept as its text and read into a [`Value`] the first time it is
// used. A `Value` holds a B-tree node (~0.5 KB) per object: data packs'
// small, many files (loot tables, advancement criteria) took ~10× their
// JSON's size, most of it never read.
// use serde_json::Value;
// use std::sync::OnceLock;

LazyJson :: struct {
    json: ^str,
    value: OnceLock<Value>,
}
    // rust: impl LazyJson {
    // `value`'s JSON, read back on first use.
new :: proc(value: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: json: value.to_string().into_boxed_str(),
    // rust: value: OnceLock::new(),
}
}
    // The value, read once and kept.
get :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.value
    // rust: .get_or_init(|| serde_json::from_str(&self.json).expect("written from a Value"))
}
    // The JSON text as written, without reading it.
json :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.json
}
    // The value without keeping it: for a pass over every entry (an
    // index) that would otherwise keep them all.
read :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
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
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.get()
}
}
    // rust: impl From<Value> for LazyJson {
from :: proc(value: Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lazy = Self::new(&value);
        // Already read: keep it rather than read it again.
    // rust: let _ = lazy.value.set(value);
    // rust: lazy
}
}
    // rust: impl Clone for LazyJson {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: json: self.json.clone(),
    // rust: value: self.value.clone(),
}
}
}
    // rust: impl std::fmt::Debug for LazyJson {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(&self.json)
}
}

    // rust: mod tests {
//     use super::*;

    // Read back as written: floats, integers past 2^53, escapes, nesting,
    // and `read` gives the same value without keeping it.
reads_back_as_written :: proc() {
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
