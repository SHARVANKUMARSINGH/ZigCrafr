//! Transpiled from Horizon Rust crate
//! Module: horizon-client_end_crystal
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `EndCrystalRenderer` and `EndCrystalModel.setupAnim`: the crystal's bob
//! and the poses of its base, glass and cube.
// use crate::mobs::{Part, anim::Poses};
// use horizon_core::geometry::trig::Mth;

/// `EndCrystalRenderer.getY`: the crystal's bob below its resting height.
pub fn y(age: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hh = (age * 0.2).msin() / 2.0 + 0.5;
    // rust: (hh * hh + hh) * 0.4 - 1.4
}

/// `EndCrystalModel.setupAnim`: the base shown or not, the glass raised by
/// half the bob (in model pixels) and the three cubes turned with
/// `ModelPart.rotateBy`, which stores the composed rotation as ZYX angles.
pub fn poses(model: *Part, age: f32, show_bottom: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut poses = Poses::new(model);
    // rust: poses.visible("base", show_bottom);
    // rust: let speed = age * 3.0;
    // rust: let sin45 = std::f32::consts::FRAC_PI_4.sin();
    // rust: let tilt = glam::Quat::from_axis_angle(
    // rust: glam::Vec3::new(sin45, 0.0, sin45),
    // rust: std::f32::consts::FRAC_PI_3,
    // rust: );
    // rust: let spin = glam::Quat::from_rotation_y(speed.to_radians());
    // rust: poses.get("outer_glass")[1] += y(age) * 16.0 / 2.0;
    // rust: for (part, rotation) in [
    // rust: ("outer_glass", spin * tilt),
    // rust: ("inner_glass", tilt * spin),
    // rust: ("cube", tilt * spin),
    // rust: ] {
    // rust: let (z, y, x) = rotation.to_euler(glam::EulerRot::ZYX);
    // rust: let pose = poses.get(part);
    // rust: pose[3] = x;
    // rust: pose[4] = y;
    // rust: pose[5] = z;
}
    // rust: poses
}
