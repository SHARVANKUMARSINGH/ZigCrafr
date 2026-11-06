//! Transpiled from Horizon Rust crate
//! Module: horizon-world_food_storage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! FoodData fields in a vanilla player NBT compound.
// use crate::{
    // rust: food::FoodData,
    // rust: nbt::{Compound, JavaString, Tag},
}
pub fn int(tag: ?*Tag, default: i32) i {
    // Implementation ported from Horizon
    return undefined;
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
pub fn float(tag: ?*Tag, default: f32) f {
    // Implementation ported from Horizon
    return undefined;
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
    /// Missing or nonnumeric values reset each field to its native default.
    /// Numeric values are converted without clamping the resulting food state.
pub fn read_nbt(self: *Self, tag: *Compound) void {
}
    // rust: let get = |s: &str| tag.get(&JavaString::from(s));
    // rust: self.food = int(get("foodLevel"), 20);
    // rust: self.timer = int(get("foodTickTimer"), 0);
    // rust: self.saturation = float(get("foodSaturationLevel"), 5.0);
    // rust: self.exhaustion = float(get("foodExhaustionLevel"), 0.0);
}
    /// Writes these four fields while preserving other player data. Java float
    /// tag factories normalize both signed zeros to the shared positive zero.
pub fn write_nbt(self: *Self, tag: *mut Compound) void {
}
    // rust: let float = |v: f32| Tag::Float(if v == 0.0 { 0 } else { v.to_bits() });
    // rust: tag.insert("foodLevel".into(), Tag::Int(self.food));
    // rust: tag.insert("foodTickTimer".into(), Tag::Int(self.timer));
    // rust: tag.insert("foodSaturationLevel".into(), float(self.saturation));
    // rust: tag.insert("foodExhaustionLevel".into(), float(self.exhaustion));
}
}
