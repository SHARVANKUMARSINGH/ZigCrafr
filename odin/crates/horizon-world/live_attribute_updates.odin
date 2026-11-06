//! Transpiled from Horizon Rust crate
package horizon_world_live_attribute_updates

import "core:fmt"
import "core:mem"
import "core:math"

// LivingEntity query/refresh dispatch over registered live attribute storage.
// use crate::{
    // rust: attribute_map::ValueKind,
    // rust: attribute_updates::{self, UpdateWorld, UpdatedAttribute},
    // rust: attributes::live::{Error, Handle, Key, LiveAttributes},
    // rust: object_open_set::CursorError,
}

// Entity handles keep a captured map alive even if a callback changes the
// entity's current attributes. Map and instance accessors are direct storage
// reads; virtual entity methods remain explicit dispatch points.
    // rust: pub trait LiveAttributeWorld: UpdateWorld<Key> {
    // rust: type Identity: FnMut() -> i32;
get_attributes :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
live_attributes :: proc(self: ^Self, map: Self::Attributes) -> ^ {
    // Ported from Horizon
    return {}
}
live_attributes_mut :: proc(self: ^Self, map: Self::Attributes) {
}
    // rust: -> &mut LiveAttributes<Self::Identity>;
    // Resolve the queued instance itself, including an instance from another
    // map if a caller has explicitly placed it in this map's pending set.
instance_attribute :: proc(self: ^Self, instance: Maybe(Handle)) -> R {
    // Ported from Horizon
    return {}
}
attribute_error :: proc(error: Error) -> S {
    // Ported from Horizon
    return {}
}
cursor_error :: proc(error: CursorError) -> S {
    // Ported from Horizon
    return {}
}
dispatch_attribute_updated :: proc(self: ^Self, attribute: Key) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: attribute_updates::updated(self, attribute)
}
}

// Registered holder names are unique in a catalog. This classifier is for
// registered attributes; custom holder dispatch can implement UpdateWorld.
kind :: proc(attribute: ^Key) -> U {
    // Ported from Horizon
    return {}
}
    // rust: match attribute.name() {
    // rust: "minecraft:max_health" => UpdatedAttribute::MaxHealth,
    // rust: "minecraft:max_absorption" => UpdatedAttribute::MaxAbsorption,
    // rust: "minecraft:scale" => UpdatedAttribute::Scale,
    // rust: "minecraft:waypoint_transmit_range" => UpdatedAttribute::WaypointRange,
    // rust: _ => UpdatedAttribute::Other,
}
}

// Base body of getAttributeValue/getAttributeBaseValue, including the virtual
// getAttributes call. Querying defaults does not create instances.
    // rust: pub fn value<W: LiveAttributeWorld>(
    // rust: world: &mut W,
    // rust: attribute: Option<Key>,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, W::Error> {
    // rust: let map = world.get_attributes()?;
    // rust: value_in(world, map, attribute, kind)
}

// Query an already captured map, as used by waypoint updates after their
// direct attributes-field read. This does not call virtual getAttributes.
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

// Base private refresh body for concrete registered AttributeMaps. Callbacks
// may change map selection or mutate the captured pending set. Clear that set
// only after the live cursor and every attribute callback finish successfully.
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
