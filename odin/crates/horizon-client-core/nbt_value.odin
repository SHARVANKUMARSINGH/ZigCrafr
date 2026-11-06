//! Transpiled from Horizon Rust crate
package horizon_client_core_nbt_value

import "core:fmt"
import "core:mem"
import "core:math"

// Reading and writing single NBT values the way vanilla's codecs accept them.
// use horizon_world::nbt::Tag;

string :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(s.into())
}
text :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
// Any numeric tag as i64 (vanilla's `getIntOr` etc. accept every number type).
number :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag? {
    // rust: Tag::Byte(v) => i64::from(*v),
    // rust: Tag::Short(v) => i64::from(*v),
    // rust: Tag::Int(v) => i64::from(*v),
    // rust: Tag::Long(v) => *v,
    // rust: Tag::Float(b) => f32::from_bits(*b) as i64,
    // rust: Tag::Double(b) => f64::from_bits(*b) as i64,
    // rust: _ => return None,
    // rust: })
}
// Any numeric tag as f64, keeping a float's or double's fraction.
float :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag? {
    // rust: Tag::Float(b) => f64::from(f32::from_bits(*b)),
    // rust: Tag::Double(b) => f64::from_bits(*b),
    // rust: other => number(Some(other))? as f64,
    // rust: })
}
