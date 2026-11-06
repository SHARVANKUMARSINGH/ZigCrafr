//! Transpiled from Horizon Rust crate
package horizon_client_render_view

import "core:fmt"
import "core:mem"
import "core:math"

// The views a frame is drawn from. A flat screen has one; a headset has
// one per eye. Every view shares the frame's camera position, so the
// camera-relative world (section origins, entity offsets) is built once and
// only each view's rotation and lens differ.

// use glam::Mat4;

// The most views one frame draws.
MAX_VIEWS :: 2

// One eye's view of the camera-relative world.
View :: struct {
    // Camera-relative world to eye: a rotation, plus the eye's offset from
    // the camera on a headset.
    view: Mat4,
    // Reversed-Z perspective: the near plane at depth 1, far at 0.
    projection: Mat4,
    // Width over height of the image this view fills.
    aspect: f32,
    // `tan(fov_y / 2)`, for shaders rebuilding view rays from NDC.
    tan_half_fov: f32,
}

    // rust: impl View {
    // The flat-screen view: vanilla's camera rotation and a symmetric
    // vertical field of view.
screen :: proc(yaw: f32, pitch: f32, fov_degrees: f32, aspect: f32, far: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: view: crate::camera::view_matrix(yaw, pitch),
    // rust: projection: super::world_projection(fov_degrees, aspect, far),
    // rust: aspect,
    // rust: tan_half_fov: (fov_degrees.to_radians() / 2.0).tan(),
}
}

    // Clip space from the camera-relative world, with `pose` (view bobbing,
    // nausea spin) between the lens and the rotation.
view_proj :: proc(self: ^Self, pose: Mat4) -> M {
    // Ported from Horizon
    return {}
}
    // rust: self.projection * pose * self.view
}
}

// Every view of a frame, and the one geometry is culled with.
ViewSet :: struct {
    views: [View,
    len: uint,
    cull: View,
}

    // rust: impl ViewSet {
    // A frame drawn from `view` alone, culled with it.
single :: proc(view: View) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: views: [view; MAX_VIEWS],
    // rust: len: 1,
    // rust: cull: view,
}
}

    // The view the HUD, hand and screen-space effects follow.
primary :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.views[0]
}

views :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.views[..self.len]
}

    // The view whose frustum covers every other view's.
cull :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.cull
}
}

    // rust: mod tests {
//     use super::*;

    // The formulas `Renderer` used before views existed, kept to pin the
    // screen view to them bit for bit.
legacy_view_proj :: proc(fov: f32, yaw: f32, pitch: f32, pose: Mat4, aspect: f32, far: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: super::super::world_projection(fov, aspect, far)
    // rust: * pose
    // rust: * crate::camera::view_matrix(yaw, pitch)
}

poses :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: Mat4::IDENTITY,
    // rust: Mat4::from_translation(glam::Vec3::new(0.013, -0.027, 0.0))
    // rust: * Mat4::from_rotation_z(0.021),
    // rust: Mat4::from_rotation_y(0.4) * Mat4::from_scale(glam::Vec3::new(1.1, 0.9, 1.0)),
    // rust: ]
}

the_screen_view_matches_the_legacy_projection_bit_for_bit :: proc() {
}
    // rust: for (fov, yaw, pitch, aspect, far) in [
    // rust: (70.0, 0.0, 0.0, 16.0 / 9.0, 512.0),
    // rust: (110.0, -137.25, 61.5, 21.0 / 9.0, 8192.0),
    // rust: (30.0, 359.9, -90.0, 4.0 / 3.0, 96.0),
    // rust: (82.333, 12.5, 7.75, 1.0, 1024.0),
    // rust: ] {
    // rust: let view = View::screen(yaw, pitch, fov, aspect, far);
    // rust: for pose in poses() {
    // rust: let old = legacy_view_proj(fov, yaw, pitch, pose, aspect, far);
    // rust: let new = view.view_proj(pose);
    // rust: assert_eq!(
    // rust: old.to_cols_array().map(f32::to_bits),
    // rust: new.to_cols_array().map(f32::to_bits),
    // rust: "fov {fov} yaw {yaw} pitch {pitch}"
    // rust: );
}
    // rust: assert_eq!(view.view, crate::camera::view_matrix(yaw, pitch));
    // rust: assert_eq!(
    // rust: view.tan_half_fov.to_bits(),
    // rust: (fov.to_radians() / 2.0).tan().to_bits()
    // rust: );
    // rust: assert_eq!(view.aspect.to_bits(), aspect.to_bits());
}
}

a_single_view_set_draws_and_culls_with_its_view :: proc() {
}
    // rust: let view = View::screen(45.0, 10.0, 70.0, 16.0 / 9.0, 512.0);
    // rust: let set = ViewSet::single(view);
    // rust: assert_eq!(set.views(), &[view]);
    // rust: assert_eq!(*set.primary(), view);
    // rust: assert_eq!(*set.cull(), view);
}
}
