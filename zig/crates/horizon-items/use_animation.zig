//! Transpiled from Horizon Rust crate
//! Module: horizon-items_use_animation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The use animation a `consumable` component names.

pub fn consumable_animation(v: *serde_json::Value) h {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_world::consumable::UseAnimation;
    // rust: match v
    // rust: .get("animation")
    // rust: .and_then(serde_json::Value::as_str)
    // rust: .unwrap_or("eat")
    // rust: {
    // rust: "eat" => UseAnimation::Eat,
    // rust: "drink" => UseAnimation::Drink,
    // rust: _ => UseAnimation::None,
}
}
