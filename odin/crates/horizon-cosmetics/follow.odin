//! Transpiled from Horizon Rust crate
package horizon_cosmetics_follow

import "core:fmt"
import "core:mem"
import "core:math"

// How a companion follows its wearer: a smoothed lag toward its anchor, and the two rules that
// keep it out of the way (out of a cone in front of a first-person camera, clear of the head).

// use glam::{DVec3, Vec3};

// Half the angle of the cone in front of a first-person camera a companion never enters
// (degrees): the middle of the view, crosshair included.
VIEW_CONE :: 35.0
// Farther than this from its anchor (blocks), a companion jumps there instead of flying: the
// wearer teleported, or came into view.
SNAP :: 8.0

// A companion's place in the world and the way it faces.
Follow :: struct {
    pos: DVec3,
    // Degrees, as an entity's yaw.
    yaw: f32,
}

    // rust: impl Follow {
    // A companion already at `target`, facing `yaw`.
at :: proc(target: DVec3, yaw: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { pos: target, yaw }
}

    // Moves toward `target` facing toward `yaw` over `dt` seconds, as a first-order lag with a
    // time constant of `lag` ticks: frame-rate independent, never past the target.
step :: proc(self: ^Self, target: DVec3, yaw: f32, lag: f32, dt: f32) {
}
    // rust: if self.pos.distance_squared(target) > SNAP * SNAP || !self.pos.is_finite() {
    // rust: *self = Self::at(target, yaw);
    // rust: return;
}
    // rust: let k = 1.0 - (-dt.max(0.0) * 20.0 / lag.max(1.0)).exp();
    // rust: self.pos += (target - self.pos) * f64::from(k);
    // rust: let turn = (yaw - self.yaw + 180.0).rem_euclid(360.0) - 180.0;
    // rust: self.yaw += turn * k;
}
}

// `p` (blocks from a first-person camera) moved out of the cone of `VIEW_CONE` around `forward`
// (unit), keeping its distance: turned toward the cone's edge on its own side, or toward
// `side` (unit, the camera's left say) when it sits right on the axis.
out_of_view :: proc(p: Vec3, forward: Vec3, side: Vec3) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let length = p.length();
    // rust: if length < 1e-6 {
    // rust: return side * 0.5;
}
    // rust: let along = p.dot(forward);
    // rust: let cone = VIEW_CONE.to_radians();
    // rust: if along <= length * cone.cos() {
    // rust: return p;
}
    // rust: let across = p - forward * along;
    // rust: let out = across.try_normalize().unwrap_or(side);
    // Just past the edge, so rounding keeps it out.
    // rust: let edge = cone + 0.01;
    // rust: (forward * edge.cos() + out * edge.sin()) * length
}

// `p` pushed straight away from `head` until it is at least `min` from it (all in blocks).
clear_of :: proc(p: Vec3, head: Vec3, min: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let d = p - head;
    // rust: let length = d.length();
    // rust: if length >= min {
    // rust: return p;
}
    // rust: let away = d.try_normalize().unwrap_or(Vec3::Y);
    // rust: head + away * min
}

    // rust: mod tests {
//     use super::*;

follows_with_a_lag_that_does_not_depend_on_the_frame_rate :: proc() {
}
    // rust: let target = DVec3::new(1.0, 0.0, 0.0);
        // A lag of 8 ticks: after 8 ticks (0.4 s) it has come 1 - 1/e of the way.
    // rust: let mut slow = Follow::at(DVec3::ZERO, 0.0);
    // rust: let mut fast = slow;
    // rust: for _ in 0..24 {
    // rust: slow.step(target, 90.0, 8.0, 1.0 / 60.0);
}
    // rust: for _ in 0..96 {
    // rust: fast.step(target, 90.0, 8.0, 1.0 / 240.0);
}
    // rust: let expected = 1.0 - (-1.0_f64).exp();
    // rust: assert!((slow.pos.x - expected).abs() < 1e-4, "{}", slow.pos.x);
    // rust: assert!((fast.pos.x - expected).abs() < 1e-4, "{}", fast.pos.x);
    // rust: assert!((slow.yaw - 90.0 * expected as f32).abs() < 1e-2);
        // A long frame never carries it past.
    // rust: slow.step(target, 90.0, 8.0, 10.0);
    // rust: assert!(slow.pos.x <= 1.0 && (slow.pos.x - 1.0).abs() < 1e-6);
}

turns_the_short_way_and_snaps_after_a_teleport :: proc() {
}
    // rust: let mut f = Follow::at(DVec3::ZERO, 170.0);
    // rust: f.step(DVec3::ZERO, -170.0, 1.0, 10.0);
        // Through 180, not back through 0.
    // rust: assert!((f.yaw - 190.0).abs() < 1e-3, "{}", f.yaw);
    // rust: let far = DVec3::new(100.0, 64.0, -3.0);
    // rust: f.step(far, 0.0, 40.0, 0.001);
    // rust: assert_eq!(f, Follow::at(far, 0.0));
}

stays_out_of_the_middle_of_a_first_person_view :: proc() {
}
    // rust: let forward = Vec3::NEG_Z;
    // rust: let left = Vec3::NEG_X;
    // rust: let cone = VIEW_CONE.to_radians().cos();
        // Right in front, a little to the right: pushed out to the right, as far away.
    // rust: let p = Vec3::new(0.1, 0.0, -1.0);
    // rust: let q = out_of_view(p, forward, left);
    // rust: assert!(q.normalize().dot(forward) < cone);
    // rust: assert!((q.length() - p.length()).abs() < 1e-5);
    // rust: assert!(q.x > 0.0 && q.y.abs() < 1e-6);
        // Dead centre: toward the side given.
    // rust: assert!(out_of_view(Vec3::new(0.0, 0.0, -1.0), forward, left).x < 0.0);
        // Already beside or behind: unchanged.
    // rust: for p in [Vec3::new(1.0, 0.0, -0.5), Vec3::new(0.0, 0.0, 1.0)] {
    // rust: assert_eq!(out_of_view(p, forward, left), p);
}
}

keeps_its_distance_from_the_head :: proc() {
}
    // rust: let head = Vec3::new(0.0, 1.5, 0.0);
    // rust: let p = clear_of(Vec3::new(0.2, 1.5, 0.0), head, 0.75);
    // rust: assert!((p - Vec3::new(0.75, 1.5, 0.0)).length() < 1e-6);
    // rust: assert_eq!(
    // rust: clear_of(Vec3::new(1.0, 1.5, 0.0), head, 0.75),
    // rust: Vec3::new(1.0, 1.5, 0.0)
    // rust: );
}
}
