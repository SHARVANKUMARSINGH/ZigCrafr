//! Transpiled from Horizon Rust crate
//! Module: horizon-world_live_attribute_updates
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LivingEntity query/refresh dispatch over registered live attribute storage.
// use crate::{
    // rust: attribute_map::ValueKind,
    // rust: attribute_updates::{self, UpdateWorld, UpdatedAttribute},
    // rust: attributes::live::{Error, Handle, Key, LiveAttributes},
    // rust: object_open_set::CursorError,
}

/// Entity handles keep a captured map alive even if a callback changes the
/// entity's current attributes. Map and instance accessors are direct storage
/// reads; virtual entity methods remain explicit dispatch points.
    // rust: pub trait LiveAttributeWorld: UpdateWorld<Key> {
    // rust: type Identity: FnMut() -> i32;
pub fn get_attributes(self: *Self) R;
pub fn live_attributes(self: *Self, map: Self::Attributes) *;
pub fn live_attributes_mut(self: *Self, map: Self::Attributes) void;
    // rust: -> &mut LiveAttributes<Self::Identity>;
    /// Resolve the queued instance itself, including an instance from another
    /// map if a caller has explicitly placed it in this map's pending set.
pub fn instance_attribute(self: *Self, instance: ?Handle) R;
pub fn attribute_error(error: Error) S;
pub fn cursor_error(error: CursorError) S;
pub fn dispatch_attribute_updated(self: *Self, attribute: Key) R;
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: attribute_updates::updated(self, attribute)
}
}

/// Registered holder names are unique in a catalog. This classifier is for
/// registered attributes; custom holder dispatch can implement UpdateWorld.
pub fn kind(attribute: *Key) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match attribute.name() {
    // rust: "minecraft:max_health" => UpdatedAttribute::MaxHealth,
    // rust: "minecraft:max_absorption" => UpdatedAttribute::MaxAbsorption,
    // rust: "minecraft:scale" => UpdatedAttribute::Scale,
    // rust: "minecraft:waypoint_transmit_range" => UpdatedAttribute::WaypointRange,
    // rust: _ => UpdatedAttribute::Other,
}
}

/// Base body of getAttributeValue/getAttributeBaseValue, including the virtual
/// getAttributes call. Querying defaults does not create instances.
    // rust: pub fn value<W: LiveAttributeWorld>(
    // rust: world: &mut W,
    // rust: attribute: Option<Key>,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, W::Error> {
    // rust: let map = world.get_attributes()?;
    // rust: value_in(world, map, attribute, kind)
}

/// Query an already captured map, as used by waypoint updates after their
/// direct attributes-field read. This does not call virtual getAttributes.
    // rust: pub fn value_in<W: LiveAttributeWorld>(
    // rust: world: &mut W,
    // rust: map: W::Attributes,
    // rust: attribute: Option<Key>,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, W::Error> {
    // rust: world
    // rust: .live_attributes_mut(map)
    // rust: .value(attribute, kind)
    // rust: .map_err(W::attribute_error)
}

/// Base private refresh body for concrete registered AttributeMaps. Callbacks
/// may change map selection or mutate the captured pending set. Clear that set
/// only after the live cursor and every attribute callback finish successfully.
    // rust: pub fn refresh<W: LiveAttributeWorld>(world: &mut W) -> Result<(), W::Error> {
    // rust: let map = world.get_attributes()?;
    // rust: let mut cursor = world.live_attributes(map).updates().cursor();
    // rust: while cursor.has_next() {
    // rust: let instance = world
    // rust: .live_attributes(map)
    // rust: .updates()
    // rust: .next(&mut cursor)
    // rust: .map_err(W::cursor_error)?;
    // rust: let attribute = world.instance_attribute(instance)?;
    // rust: world.dispatch_attribute_updated(attribute)?;
}
    // rust: world.live_attributes_mut(map).updates_mut().clear();
    // rust: Ok(())
}
