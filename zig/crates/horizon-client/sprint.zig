//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sprint
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LocalPlayer sprint decisions around KeyboardInput.tick. Conditions are the
//! current player queries; setting sprint dispatches to the live attribute state.
// use crate::input;

pub const Keys = struct {
    forward: bool,
    backward: bool,
    left: bool,
    right: bool,
    jump: bool,
    shift: bool,
    sprint: bool,
    /// A controller stick's move vector (`[left, forward]`, Horizon's own),
    /// used instead of the keys' direction while it is pushed.
    analog: Option<[f32,
};
    // rust: impl Keys {
pub fn direction(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.analog {
    // rust: Some(v) => v,
    // rust: None => input::keyboard_direction(self.forward, self.backward, self.left, self.right),
}
}
    /// Add a stick's move vector: the direction flags code reading keys
    /// (sprint, vehicles, the server's input packet) see are set past a
    /// third of the travel.
pub fn with_stick(stick: ?[f32; 2]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some([left, forward]) = stick {
    // rust: self.forward |= forward > 0.3;
    // rust: self.backward |= forward < -0.3;
    // rust: self.left |= left > 0.3;
    // rust: self.right |= left < -0.3;
    // rust: self.analog = Some([left, forward]);
}
    // rust: self
}
}
pub const SprintState = struct {
    trigger_time: i32,
    previous_forward: bool,
    previous_shift: bool,
};
pub const Conditions = struct {
    sprinting: bool,
    mobility_restricted: bool,
    passenger: bool,
    vehicle_can_sprint: bool,
    vehicle_local: bool,
    enough_food: bool,
    may_fly: bool,
    flying: bool,
    shallow_water: bool,
    slow_item: bool,
    fall_flying: bool,
    under_water: bool,
    moving_slowly: bool,
    swimming: bool,
    in_water: bool,
    on_ground: bool,
    horizontal_collision: bool,
    minor_horizontal_collision: bool,
};
    // rust: impl Conditions {
pub fn possible(self: *Self, allow_shallow_water: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.mobility_restricted
    // rust: && if self.passenger {
    // rust: self.vehicle_can_sprint && self.vehicle_local
    // rust: } else {
    // rust: self.enough_food || self.may_fly
}
    // rust: && (allow_shallow_water || !self.shallow_water)
}
pub fn can_start(self: *Self, forward: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.sprinting
    // rust: && forward
    // rust: && self.possible(self.flying)
    // rust: && !self.slow_item
    // rust: && (!self.fall_flying || self.under_water)
    // rust: && (!self.moving_slowly || self.under_water)
}
pub fn should_stop(self: *Self, forward: bool, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.swimming {
    // rust: !self.possible(true) || !self.in_water || (!forward && !self.on_ground && !shift)
    // rust: } else {
    // rust: !self.possible(self.flying)
    // rust: || !forward
    // rust: || (self.horizontal_collision && !self.minor_horizontal_collision)
}
}
}
    // rust: impl SprintState {
    /// Runs the sprint phase. The default vanilla sprint window is seven ticks;
    /// it is supplied so the options binding can also select 0..10. The setter
    /// is called for every native request, including repeated true requests.
    // rust: pub fn tick<E>(
    // rust: &mut self,
    // rust: keys: Keys,
    // rust: conditions: Conditions,
    // rust: window: i32,
    // rust: mut set_sprinting: impl FnMut(bool) -> Result<(), E>,
    // rust: ) -> Result<(), E> {
    // rust: if self.trigger_time > 0 {
    // rust: self.trigger_time -= 1;
}
    // rust: let old_forward = self.previous_forward;
    // rust: let old_shift = self.previous_shift;
    // rust: let forward = keys.direction()[1] > 1.0e-5;
    // rust: self.previous_forward = forward;
    // rust: self.previous_shift = keys.shift;
    // rust: if old_shift || (conditions.slow_item && !conditions.passenger) || keys.backward {
    // rust: self.trigger_time = 0;
}
    // rust: let mut sprinting = conditions.sprinting;
    // rust: if conditions.can_start(forward) {
    // rust: if !old_forward {
    // rust: if self.trigger_time > 0 {
    // rust: set_sprinting(true)?;
    // rust: sprinting = true;
    // rust: } else {
    // rust: self.trigger_time = window;
}
}
    // rust: if keys.sprint {
    // rust: set_sprinting(true)?;
    // rust: sprinting = true;
}
}
    // rust: if sprinting && conditions.should_stop(forward, keys.shift) {
    // rust: set_sprinting(false)?;
}
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::*;

pub fn standing() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Conditions {
    // rust: enough_food: true,
    // rust: on_ground: true,
    // rust: ..Conditions::default()
}
}

pub fn step(state: *mut SprintState, keys: Keys, sprinting: *mut bool) void {
}
    // rust: let current = *sprinting;
    // rust: let mut next = current;
    // rust: state
    // rust: .tick(
    // rust: keys,
    // rust: Conditions {
    // rust: sprinting: current,
    // rust: ..standing()
    // rust: },
    // rust: 7,
    // rust: |value| {
    // rust: next = value;
    // rust: Ok::<(), ()>(())
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: *sprinting = next;
}

    /// Vanilla sprint is a state. Releasing the sprint key, including on the
    /// jump tick, keeps it while forward is held; releasing forward stops it.
pub fn sprint_survives_releasing_the_key_through_a_jump() void {
}
    // rust: let mut state = SprintState::default();
    // rust: let mut sprinting = false;
    // rust: step(
    // rust: &mut state,
    // rust: Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Keys::default()
    // rust: },
    // rust: &mut sprinting,
    // rust: );
    // rust: assert!(sprinting);
    // rust: step(
    // rust: &mut state,
    // rust: Keys {
    // rust: forward: true,
    // rust: jump: true,
    // rust: ..Keys::default()
    // rust: },
    // rust: &mut sprinting,
    // rust: );
    // rust: assert!(
    // rust: sprinting,
    // rust: "a jump after the sprint key comes up must stay a sprint"
    // rust: );
    // rust: step(
    // rust: &mut state,
    // rust: Keys {
    // rust: jump: true,
    // rust: ..Keys::default()
    // rust: },
    // rust: &mut sprinting,
    // rust: );
    // rust: assert!(!sprinting);
}
}
