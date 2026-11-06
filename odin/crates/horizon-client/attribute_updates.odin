//! Transpiled from Horizon Rust crate
package horizon_client_attribute_updates

import "core:fmt"
import "core:mem"
import "core:math"

// Resident ServerPlayer pending attribute callbacks over its owned live map.
// Waypoint requests are observable boundaries; manager/network delivery is
// still supplied by the eventual multiplayer runtime.
// use crate::{
    // rust: Result,
    // rust: health::Updates,
    // rust: motion::{MotionEvent, PlayerMotion},
}
// use horizon_world::{
    // rust: attribute_map::ValueKind,
    // rust: attribute_updates::{self, UpdateWorld, UpdatedAttribute},
    // rust: attributes::live::{self, Handle, Key, LiveAttributes},
    // rust: live_attribute_updates::{self as live_updates, LiveAttributeWorld},
    // rust: living_health::{self, HealthWorld},
    // rust: object_open_set::CursorError,
}
// use std::io;

    // rust: impl PlayerMotion {
    // LivingEntity.tick refreshes these callbacks after aiStep and before the
    // enclosing Player.tick selects its pose. Synchronization stays queued.
refresh_attributes :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: live_updates::refresh(self)
}
    // `Player.internalSetAbsorptionAmount`: the amount as given, unclamped
    // (the saved `AbsorptionAmount`, or what a client's server sent).
internal_set_absorption :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.store_absorption(value)
}
}
    // rust: impl HealthWorld for PlayerMotion {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type Data = ();
health :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.health.health())
}
health_data :: proc(self: ^Self) {
}
max_health_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.attribute("minecraft:max_health")
}
max_absorption_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.attribute("minecraft:max_absorption")
}
store_health :: proc(self: ^Self, _: () {
}
    // rust: self.health.data.set(
    // rust: self.health.ids.health,
    // rust: value,
    // rust: false,
    // rust: &mut Updates(&mut self.events),
    // rust: )?;
    // rust: Ok(())
}
store_absorption :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
        // Player.internalSetAbsorptionAmount stores the already clamped value
        // through its current synchronized data, without another limit query.
    // rust: self.health.data.set(
    // rust: self.health.ids.absorption,
    // rust: value,
    // rust: false,
    // rust: &mut Updates(&mut self.events),
    // rust: )?;
    // rust: Ok(())
}
dead_flag :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.health.dead
}
dispatch_set_health :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: living_health::set_health(self, value)
}
}
    // rust: impl UpdateWorld<Key> for PlayerMotion {
    // rust: type Level = ();
    // rust: type Manager = ();
    // rust: type Attributes = ();
attribute_kind :: proc(self: ^Self, attribute: ^Key) -> U {
    // Ported from Horizon
    return {}
}
    // rust: live_updates::kind(attribute)
}
absorption :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.health.absorption())
}
refresh_dimensions :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: PlayerMotion::refresh_dimensions(self)
}
level :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
is_server_level :: proc(self: ^Self, _: () {
}
    // rust: true
}
waypoint_manager :: proc(self: ^Self, _: () {
}
    // rust: Ok(())
}
attributes_field :: proc(self: ^Self) {
}
attribute_value_in :: proc(self: ^Self, _: () {
}
    // rust: self.attributes
    // rust: .value(Some(attribute), ValueKind::Computed)
    // rust: .map_err(Self::attribute_error)
}
track_waypoint :: proc(self: ^Self, _: () {
}
    // rust: self.events.push(MotionEvent::Waypoint {
    // rust: receiver: false,
    // rust: enabled: track,
    // rust: });
    // rust: Ok(())
}
}
    // rust: impl LiveAttributeWorld for PlayerMotion {
    // rust: type Identity = Box<dyn horizon_world::attributes::live::Identities>;
get_attributes :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
live_attributes :: proc(self: ^Self, _: () {
}
    // rust: &self.attributes
}
live_attributes_mut :: proc(self: ^Self, _: () {
}
    // rust: &mut self.attributes
}
instance_attribute :: proc(self: ^Self, instance: Maybe(Handle)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let instance =
    // rust: instance.ok_or_else(|| io::Error::other("null pending attribute instance"))?;
    // rust: self.attributes
    // rust: .attribute(&instance)
    // rust: .cloned()
    // rust: .map_err(Self::attribute_error)
}
attribute_error :: proc(error: live::Error) -> S {
    // Ported from Horizon
    return {}
}
    // rust: io::Error::other(format!("resident attribute: {error:?}")).into()
}
cursor_error :: proc(error: CursorError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: io::Error::other(format!("resident attribute cursor: {error:?}")).into()
}
dispatch_attribute_updated :: proc(self: ^Self, attribute: Key) -> R {
    // Ported from Horizon
    return {}
}
        // ServerPlayer.onAttributeUpdated handles receive range, then calls
        // the inherited LivingEntity handler, including for this same holder.
    // rust: if attribute.name() == "minecraft:waypoint_receive_range" {
    // rust: let value = self
    // rust: .attributes
    // rust: .value(Some(attribute.clone()), ValueKind::Computed)
    // rust: .map_err(Self::attribute_error)?;
    // rust: self.events.push(MotionEvent::Waypoint {
    // rust: receiver: true,
    // rust: enabled: value > 0.0,
    // rust: });
}
    // rust: attribute_updates::updated(self, attribute)
}
}
