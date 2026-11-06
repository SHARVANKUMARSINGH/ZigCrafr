//! Transpiled from Horizon Rust crate
//! Module: horizon-world_settings
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vertical terrain bounds used by Java Edition 26.3.
// use super::{DecodeError, Object, int_range, required};

pub const NoiseSettings = struct {
    min_y: i32,
    height: i32,
};
    // rust: impl NoiseSettings {
    /// The record constructor itself does not check bounds or alignment.
    // rust: pub const fn new(min_y: i32, height: i32) -> Self {
    // rust: Self { min_y, height }
}
    /// Vanilla's create helper checks the wrapped upper bound, then height
    /// alignment, then minimum alignment. JSON adds stricter field bounds.
pub fn create(min_y: i32, height: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min_y.wrapping_add(height) > 2032 {
    // rust: return Err(DecodeError::Field("noise upper bound"));
}
    // rust: if height % 16 != 0 {
    // rust: return Err(DecodeError::Field("noise height alignment"));
}
    // rust: if min_y % 16 != 0 {
    // rust: return Err(DecodeError::Field("noise minimum alignment"));
}
    // rust: Ok(Self::new(min_y, height))
}
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let min_y = int_range(required(&object, "min_y")?, "noise minimum", -2032, 2031)?;
    // rust: let height = int_range(required(&object, "height")?, "noise height", 0, 4064)?;
    // rust: Self::create(min_y, height)
}
    /// Accessor maximum is minimum + height - 1 with Java integer wrapping.
    /// Disjoint ranges can produce negative heights; vanilla does not clamp
    /// those to zero or reapply codec alignment constraints to the result.
pub fn clamp_to_height(self: *Self, accessor_minimum: i32, accessor_height: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min_y = self.min_y.max(accessor_minimum);
    // rust: let upper = self
    // rust: .min_y
    // rust: .wrapping_add(self.height)
    // rust: .min(accessor_minimum.wrapping_add(accessor_height));
    // rust: Self::new(min_y, upper.wrapping_sub(min_y))
}
}
