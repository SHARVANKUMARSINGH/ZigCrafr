//! Transpiled from Horizon Rust crate
//! Module: horizon-world_end_gateway
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! End gateway structure placement and conditional block-entity configuration.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: integer, optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
}
// use crate::registry::BlockStateId;
// use serde_json::value::RawValue;

pub const EndGatewayFeature = struct {
    exit: Option<[i32,
    exact: bool,
    air: BlockStateId,
    bedrock: BlockStateId,
    gateway: BlockStateId,
};
pub const EndGatewayError = enum {
    World(E),
    Query(PlacementQueryError),
    WorkLimit,
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for EndGatewayError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("end gateway work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for EndGatewayError<E> {}
    // rust: impl EndGatewayFeature {
pub fn from_json(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let exact = serde_json::from_str(required(&object, "exact")?.get())?;
    // rust: let exit = optional(&object, "exit")
    // rust: .map(|raw| {
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.len() != 3 {
    // rust: return Err(DecodeError::Field("gateway exit"));
}
    // rust: Ok([
    // rust: integer(&values[0])?,
    // rust: integer(&values[1])?,
    // rust: integer(&values[2])?,
    // rust: ])
    // rust: })
    // rust: .transpose()?;
    // rust: let get = |name| {
    // rust: bindings
    // rust: .registry()
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown gateway block {name}")))
}
    // rust: Ok(Self {
    // rust: exit,
    // rust: exact,
    // rust: air: get("minecraft:air")?,
    // rust: bedrock: get("minecraft:bedrock")?,
    // rust: gateway: get("minecraft:end_gateway")?,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, EndGatewayError<W::Error>> {
    // rust: let offset =
    // rust: |d: [i32; 3]| -> [i32; 3] { std::array::from_fn(|i| origin[i].wrapping_add(d[i])) };
    // rust: let a = offset([-1, -2, -1]);
    // rust: let b = offset([1, 2, 1]);
    // rust: let min: [i32; 3] = std::array::from_fn(|i| a[i].min(b[i]));
    // rust: let sizes: [i32; 3] =
    // rust: std::array::from_fn(|i| a[i].max(b[i]).wrapping_sub(min[i]).wrapping_add(1));
    // rust: let count = sizes[0].wrapping_mul(sizes[1]).wrapping_mul(sizes[2]);
    // rust: let mut index: i32 = 0;
    // rust: let mut remaining = 1_048_576;
    // rust: while index != count {
    // rust: if remaining == 0 {
    // rust: return Err(EndGatewayError::WorkLimit);
}
    // rust: remaining -= 1;
    // rust: let quotient = index / sizes[0];
    // rust: let p = [
    // rust: min[0].wrapping_add(index % sizes[0]),
    // rust: min[1].wrapping_add(quotient % sizes[1]),
    // rust: min[2].wrapping_add(quotient / sizes[1]),
    // rust: ];
    // rust: index = index.wrapping_add(1);
    // rust: let x = p[0] == origin[0];
    // rust: let y = p[1] == origin[1];
    // rust: let z = p[2] == origin[2];
    // rust: let cap = p[1].wrapping_sub(origin[1]).wrapping_abs() == 2;
    // rust: let center = x && y && z;
    // rust: let state = if center {
    // rust: self.gateway
    // rust: } else if y {
    // rust: self.air
    // rust: } else if cap && x && z || !cap && (x || z) {
    // rust: self.bedrock
    // rust: } else {
    // rust: self.air
}
    // rust: world
    // rust: .set_block(p, state, 3)
    // rust: .map_err(EndGatewayError::World)?;
    // rust: if center {
    // rust: if let Some(exit) = self.exit {
                    // Native code looks up the entity even when the write returned false.
    // rust: world
    // rust: .configure_end_gateway(p, exit, self.exact)
    // rust: .map_err(EndGatewayError::Query)?;
}
}
}
    // rust: Ok(true)
}
}
