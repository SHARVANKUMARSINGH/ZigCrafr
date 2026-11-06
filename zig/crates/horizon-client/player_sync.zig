//! Transpiled from Horizon Rust crate
//! Module: horizon-client_player_sync
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LocalPlayer.sendPosition and PositionMoveRotation.calculateAbsolute.
// use horizon_core::geometry::Vec3;
// use horizon_protocol::packets::play::{self, PlayerPosition, Serverbound as S, relative};

/// Only movement updates advance this baseline. A teleport acknowledgement is
/// separate and must not suppress the next tick's corrected position or look.
pub const PositionSender = struct {
    position: [f64,
    rotation: (f32,
    on_ground: bool,
    collision: bool,
    reminder: u32,
};

    // rust: impl PositionSender {
    // rust: pub fn update(
    // rust: &mut self,
    // rust: position: [f64; 3],
    // rust: rotation: (f32, f32),
    // rust: on_ground: bool,
    // rust: collision: bool,
    // rust: ) -> Option<S> {
    // rust: self.reminder += 1;
    // rust: let d: [f64; 3] = std::array::from_fn(|i| position[i] - self.position[i]);
    // rust: let moved =
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] > 2.0e-4 * 2.0e-4 || self.reminder >= 20;
    // rust: let rotated = rotation.0 - self.rotation.0 != 0.0 || rotation.1 - self.rotation.1 != 0.0;
    // rust: let flags = u8::from(on_ground) | u8::from(collision) << 1;
    // rust: let [x, y, z] = position;
    // rust: let (yaw, pitch) = rotation;
    // rust: let packet = if moved && rotated {
    // rust: Some(S::MovePlayerPosRot(play::MovePlayerPosRot {
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: yaw,
    // rust: pitch,
    // rust: flags,
    // rust: }))
    // rust: } else if moved {
    // rust: Some(S::MovePlayerPos(play::MovePlayerPos { x, y, z, flags }))
    // rust: } else if rotated {
    // rust: Some(S::MovePlayerRot(play::MovePlayerRot { yaw, pitch, flags }))
    // rust: } else if self.on_ground != on_ground || self.collision != collision {
    // rust: Some(S::MovePlayerStatus(play::MovePlayerStatus { flags }))
    // rust: } else {
    // rust: None
}
    // rust: if moved {
    // rust: self.position = position;
    // rust: self.reminder = 0;
}
    // rust: if rotated {
    // rust: self.rotation = rotation;
}
    // rust: self.on_ground = on_ground;
    // rust: self.collision = collision;
    // rust: packet
}
}

/// Rotate the old velocity before adding the relative delta components.
/// Angles deliberately use Java's double toRadians followed by a float cast.
    // rust: pub fn teleport_velocity(
    // rust: mut velocity: Vec3,
    // rust: old_rotation: (f32, f32),
    // rust: new_rotation: (f32, f32),
    // rust: packet: &PlayerPosition,
    // rust: ) -> Vec3 {
    // rust: if packet.relatives & relative::ROTATE_DELTA != 0 {
    // rust: let pitch = f64::from(old_rotation.1 - new_rotation.1).to_radians() as f32;
    // rust: let yaw = f64::from(old_rotation.0 - new_rotation.0).to_radians() as f32;
    // rust: velocity = velocity.rotate_x(pitch).rotate_y(yaw);
}
    // rust: let old = [velocity.x, velocity.y, velocity.z];
    // rust: let flags = [relative::DELTA_X, relative::DELTA_Y, relative::DELTA_Z];
    // rust: let result: [f64; 3] = std::array::from_fn(|i| {
    // rust: if packet.relatives & flags[i] != 0 {
    // rust: old[i] + packet.delta[i]
    // rust: } else {
    // rust: packet.delta[i]
}
    // rust: });
    // rust: Vec3::new(result[0], result[1], result[2])
}
