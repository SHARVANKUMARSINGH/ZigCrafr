//! Transpiled from Horizon Rust crate
package horizon_items_use_animation

import "core:fmt"
import "core:mem"
import "core:math"

// The use animation a `consumable` component names.

consumable_animation :: proc(v: ^serde_json::Value) -> h {
    // Ported from Horizon
    return {}
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
