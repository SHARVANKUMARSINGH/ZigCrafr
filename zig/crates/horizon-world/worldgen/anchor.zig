//! Transpiled from Horizon Rust crate
//! Module: horizon-world_anchor
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vertical anchors and their generation bounds in Java Edition 26.3.
// use super::{DecodeError, Object, int_range, required};

pub const WorldGenerationContext = struct {
    min_y: i32,
    height: i32,
    sea_level: i32,
};
    // rust: impl WorldGenerationContext {
    // rust: pub const fn new(min_y: i32, height: i32, sea_level: i32) -> Self {
    // rust: Self {
    // rust: min_y,
    // rust: height,
    // rust: sea_level,
}
}

    /// Vanilla combines the two minima and heights independently. This is
    /// deliberately different from intersecting the two vertical intervals.
    // rust: pub fn with_generator(
    // rust: level_min: i32,
    // rust: level_height: i32,
    // rust: generator_min: i32,
    // rust: generator_height: i32,
    // rust: generator_sea_level: i32,
    // rust: ) -> Self {
    // rust: Self::new(
    // rust: level_min.max(generator_min),
    // rust: level_height.min(generator_height),
    // rust: generator_sea_level,
    // rust: )
}
}

pub const VerticalAnchor = enum {
    Absolute(i32),
    AboveBottom(i32),
    BelowTop(i32),
    RelativeToSeaLevel(i32),
};
    // rust: impl VerticalAnchor {
pub const BOTTOM: Self = Self::AboveBottom(0);
pub const TOP: Self = Self::BelowTop(0);
pub const SEA_LEVEL: Self = Self::RelativeToSeaLevel(0);

    /// Runtime anchors accept every signed integer, with Java wrapping.
pub fn resolve(self: *Self, context: WorldGenerationContext) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Absolute(y) => y,
    // rust: Self::AboveBottom(offset) => context.min_y.wrapping_add(offset),
    // rust: Self::BelowTop(offset) => context
    // rust: .height
    // rust: .wrapping_sub(1)
    // rust: .wrapping_add(context.min_y)
    // rust: .wrapping_sub(offset),
    // rust: Self::RelativeToSeaLevel(offset) => context.sea_level.wrapping_add(offset),
}
}

pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let field = |name| {
    // rust: required(&object, name)
    // rust: .and_then(|raw| int_range(raw, name, -2032, 2031))
    // rust: .ok()
}
        // The codec nests exclusive alternatives. An ambiguous inner choice
        // fails that branch, allowing a valid outer branch to succeed.
    // rust: let exclusive = |left, right| match (left, right) {
    // rust: (Some(value), None) | (None, Some(value)) => Some(value),
    // rust: _ => None,
}
    // rust: exclusive(
    // rust: field("absolute").map(Self::Absolute),
    // rust: exclusive(
    // rust: field("above_bottom").map(Self::AboveBottom),
    // rust: exclusive(
    // rust: field("below_top").map(Self::BelowTop),
    // rust: field("relative_to_sea_level").map(Self::RelativeToSeaLevel),
    // rust: ),
    // rust: ),
    // rust: )
    // rust: .ok_or(DecodeError::Field("vertical anchor"))
}

    /// Encode through the same field bounds as the vanilla codec. Constructed
    /// runtime anchors can resolve successfully while failing this validation.
pub fn to_json(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (name, value) = match self {
    // rust: Self::Absolute(y) => ("absolute", y),
    // rust: Self::AboveBottom(offset) => ("above_bottom", offset),
    // rust: Self::BelowTop(offset) => ("below_top", offset),
    // rust: Self::RelativeToSeaLevel(offset) => ("relative_to_sea_level", offset),
}
    // rust: if !(-2032..=2031).contains(&value) {
    // rust: return Err(DecodeError::Field("vertical anchor"));
}
    // rust: Ok(format!("{{\"{name}\":{value}}}"))
}
}
