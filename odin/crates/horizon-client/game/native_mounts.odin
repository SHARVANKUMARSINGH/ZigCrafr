//! Transpiled from Horizon Rust crate
package horizon_client_native_mounts

import "core:fmt"
import "core:mem"
import "core:math"

// Mounting for native mods (`native_entity_mount`: NeoForge's `EntityMountEvent`). Each place
// the acting player or a mob gets on or off a vehicle asks `native_may_board` or
// `native_may_leave` first, and does nothing when a mod says no.
// use super::{Game, native_hooks::mob_kind};

    // rust: impl Game<'_> {
    // Whether this game is a server whose mounts the mods hear: the server thread or a
    // dedicated server, never a client.
native_hears_mounts :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.serving.is_some() || self.options.dedicated.is_some()
}

    // The entity id of the acting player: a guest's while their action runs (kept with the
    // action, as the hub is often out of `lan` then), else none (0).
    // rust: pub(super) fn native_acting_entity(&self) -> u32 {
    // rust: match self.lan_acting {
    // rust: Some(conn) => self.lan_acting_entity.unwrap_or_else(|| {
    // rust: let guests = self.lan_guest_entities();
    // rust: guests.iter().find(|g| g.0 == conn).map_or(0, |g| g.1)
    // rust: }),
    // rust: None => 0,
}
}

    // The type of the vehicle with entity id `id`.
native_vehicle_kind :: proc(self: ^Self, id: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: b.entity_type()
    // rust: } else if let Some(c) = self.carts.iter().find(|c| c.id == id) {
    // rust: c.kind.id().into()
    // rust: } else if self.cushions.iter().any(|c| c.id == id) {
    // rust: "minecraft:cushion".into()
    // rust: } else if let Some(m) = self.mobs.iter().find(|m| m.id == id) {
    // rust: mob_kind(m)
    // rust: } else {
    // rust: String::new()
}
}

    // `native_entity_mount` for `rider` (the acting player when `None`) and `vehicle`: whether
    // the mounting or dismounting goes ahead.
native_mount_allowed :: proc(self: ^Self, rider: Maybe(u32), vehicle: u32, mounting: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.native_hears_mounts() {
    // rust: return true;
}
    // rust: let (entity, kind) = match rider {
    // rust: Some(id) => (
    // rust: id,
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or_else(String::new, mob_kind),
    // rust: ),
    // rust: None => (self.native_acting_entity(), "minecraft:player".into()),
}
    // rust: let vehicle_kind = self.native_vehicle_kind(vehicle);
    // rust: let mut canceled = false;
    // rust: self.native_entity_mount(
    // rust: self.dim.id(),
    // rust: entity,
    // rust: &kind,
    // rust: vehicle,
    // rust: &vehicle_kind,
    // rust: mounting,
    // rust: &mut canceled,
    // rust: );
    // rust: !canceled
}

    // The acting player is about to board `vehicle`: false when a mod canceled it.
    // rust: pub(super) fn native_may_board(&mut self, vehicle: u32) -> bool {
    // rust: self.native_mount_allowed(None, vehicle, true)
}

    // The acting player is about to get off `vehicle`: false when a mod canceled it.
    // rust: pub(super) fn native_may_leave(&mut self, vehicle: u32) -> bool {
    // rust: self.native_mount_allowed(None, vehicle, false)
}

    // The mob `rider` is about to board (`mounting`) or leave `vehicle`: false when a mod
    // canceled it.
    // rust: pub(super) fn native_mob_may_ride(&mut self, rider: u32, vehicle: u32, mounting: bool) -> bool {
    // rust: self.native_mount_allowed(Some(rider), vehicle, mounting)
}
}
