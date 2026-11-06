//! Transpiled from Horizon Rust crate
package horizon_world_food_storage

import "core:fmt"
import "core:mem"
import "core:math"

// FoodData fields in a vanilla player NBT compound.
// use crate::{
    // rust: food::FoodData,
    // rust: nbt::{Compound, JavaString, Tag},
}
int :: proc(tag: Maybe(^Tag), default: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::Byte(v)) => i32::from(*v),
    // rust: Some(Tag::Short(v)) => i32::from(*v),
    // rust: Some(Tag::Int(v)) => *v,
    // rust: Some(Tag::Long(v)) => *v as i32,
    // rust: Some(Tag::Float(v)) => f32::from_bits(*v).floor() as i32,
    // rust: Some(Tag::Double(v)) => f64::from_bits(*v).floor() as i32,
    // rust: _ => default,
}
}
float :: proc(tag: Maybe(^Tag), default: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::Byte(v)) => f32::from(*v),
    // rust: Some(Tag::Short(v)) => f32::from(*v),
    // rust: Some(Tag::Int(v)) => *v as f32,
    // rust: Some(Tag::Long(v)) => *v as f32,
    // rust: Some(Tag::Float(v)) => f32::from_bits(*v),
    // rust: Some(Tag::Double(v)) => f64::from_bits(*v) as f32,
    // rust: _ => default,
}
}
    // rust: impl FoodData {
    // Missing or nonnumeric values reset each field to its native default.
    // Numeric values are converted without clamping the resulting food state.
read_nbt :: proc(self: ^Self, tag: ^Compound) {
}
    // rust: let get = |s: &str| tag.get(&JavaString::from(s));
    // rust: self.food = int(get("foodLevel"), 20);
    // rust: self.timer = int(get("foodTickTimer"), 0);
    // rust: self.saturation = float(get("foodSaturationLevel"), 5.0);
    // rust: self.exhaustion = float(get("foodExhaustionLevel"), 0.0);
}
    // Writes these four fields while preserving other player data. Java float
    // tag factories normalize both signed zeros to the shared positive zero.
write_nbt :: proc(self: ^Self, tag: ^Compound) {
}
    // rust: let float = |v: f32| Tag::Float(if v == 0.0 { 0 } else { v.to_bits() });
    // rust: tag.insert("foodLevel".into(), Tag::Int(self.food));
    // rust: tag.insert("foodTickTimer".into(), Tag::Int(self.timer));
    // rust: tag.insert("foodSaturationLevel".into(), float(self.saturation));
    // rust: tag.insert("foodExhaustionLevel".into(), float(self.exhaustion));
}
}
