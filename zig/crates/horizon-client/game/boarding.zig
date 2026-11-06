//! Transpiled from Horizon Rust crate
//! Module: horizon-client_boarding
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The player's `Entity.boardingCooldown`: 60 ticks after leaving a vehicle in
//! which a non-forced `startRiding` (`Entity.canRide`) is refused.
//! Mobs keep theirs in `extra.boarding_cooldown`; a server's guests keep theirs
//! in `Guest::boarding_cooldown`, swapped in for their turn like `riding`.
// use super::{Game, boat_passengers::BOARDING_COOLDOWN};

/// `Entity.baseTick`: the cooldown counts down while positive.
    // rust: pub(super) fn tick_down(cooldown: i32) -> i32 {
    // rust: (cooldown - 1).max(0)
}

/// `Entity.removePassenger`: the passenger that left sets its cooldown to 60.
/// `was` and `now` are its vehicle before and after.
    // rust: pub(super) fn after_leaving(cooldown: i32, was: Option<u32>, now: Option<u32>) -> i32 {
    // rust: if was.is_some() && now.is_none() {
    // rust: BOARDING_COOLDOWN
    // rust: } else {
    // rust: cooldown
}
}

/// `Entity.getIndirectPassengersStream` for `vehicle`: the vehicle and every
/// vehicle riding it, directly or through another rider. `mounts` holds
/// `(vehicle, its vehicle)` for every mob.
    // rust: pub(super) fn passenger_vehicles(vehicle: u32, mounts: &[(u32, Option<u32>)]) -> Vec<u32> {
    // rust: let mut ids = vec![vehicle];
    // rust: let mut i = 0;
    // rust: while i < ids.len() {
    // rust: let v = ids[i];
    // rust: i += 1;
    // rust: for &(id, mount) in mounts {
    // rust: if mount == Some(v) && !ids.contains(&id) {
    // rust: ids.push(id);
}
}
}
    // rust: ids
}

    // rust: impl Game<'_> {
    /// `Entity.startRiding` for the acting player: the rider link, then
    /// `CriteriaTriggers.START_RIDING_TRIGGER` for every server player the
    /// vehicle carries.
    // rust: pub(super) fn start_riding(&mut self, vehicle: u32) {
    // rust: self.riding = Some(vehicle);
    // rust: self.note_started_riding(vehicle);
}

    /// A rider link changed on `vehicle` (`sendEventAndTriggers`). Every
    /// player aboard hears the trigger; a host's turn can fire it now, while
    /// a guest's turn (the hub held by its action) leaves it for
    /// [`Self::flush_started_riding`] once every player is back in place.
    // rust: pub(super) fn note_started_riding(&mut self, vehicle: u32) {
    // rust: self.started_riding.push(vehicle);
    // rust: if self.lan.is_some() && self.lan_acting.is_none() {
    // rust: self.flush_started_riding();
}
}

    /// Fires the queued `started_riding` triggers with every player in place.
    // rust: pub(super) fn flush_started_riding(&mut self) {
    // rust: for vehicle in std::mem::take(&mut self.started_riding) {
    // rust: self.trigger_started_riding(vehicle);
}
}

    /// `Entity.canRide` for the player acting now (the host's, or the guest
    /// whose turn it is): the cooldown has elapsed, and the player did not
    /// leave a vehicle since the tick began (the tick that starts the
    /// cooldown has not run yet).
    // rust: pub(super) fn may_board(&self) -> bool {
    // rust: self.boarding_cooldown <= 0 && !(self.riding_at_tick.is_some() && self.riding.is_none())
}
    /// The host's own cooldown, once per tick.
    // rust: pub(super) fn tick_boarding(&mut self) {
    // rust: self.boarding_cooldown = tick_down(self.boarding_cooldown);
    // rust: self.boarding_cooldown =
    // rust: after_leaving(self.boarding_cooldown, self.riding_at_tick, self.riding);
    // rust: self.riding_at_tick = self.riding;
}
}

    // rust: mod tests {
//     use super::*;
pub fn leaving_sets_sixty_and_boarding_waits_it_out() void {
}
    // rust: let mut cd = after_leaving(0, Some(7), None);
    // rust: assert_eq!(cd, 60);
    // rust: for _ in 0..59 {
    // rust: cd = tick_down(cd);
    // rust: assert!(cd > 0, "still refused");
}
    // rust: cd = tick_down(cd);
    // rust: assert_eq!(cd, 0, "allowed on the sixtieth tick");
}
pub fn staying_or_boarding_does_not_set_it() void {
}
    // rust: assert_eq!(after_leaving(0, Some(7), Some(7)), 0);
    // rust: assert_eq!(after_leaving(0, None, Some(7)), 0);
    // rust: assert_eq!(after_leaving(0, None, None), 0);
}
pub fn never_negative() void {
}
    // rust: assert_eq!(tick_down(0), 0);
}
pub fn started_riding_reaches_every_rider_of_the_vehicle() void {
}
        // Entity.startRiding: START_RIDING_TRIGGER for every ServerPlayer in
        // entityToRide.getIndirectPassengersStream(). A mob between two
        // riders is still part of that stream, and another vehicle is not.
    // rust: let mounts = [(7, Some(5)), (8, Some(7)), (9, Some(4))];
    // rust: let aboard = passenger_vehicles(5, &mounts);
    // rust: assert!(aboard.contains(&5), "the rider on the vehicle itself");
    // rust: assert!(aboard.contains(&7), "the mob in the vehicle's seat");
    // rust: assert!(aboard.contains(&8), "the rider of that mob");
    // rust: assert!(!aboard.contains(&9), "a mob riding another vehicle");
    // rust: assert!(!aboard.contains(&6), "a mob riding nothing");
}
}
