//! Transpiled from Horizon Rust crate
//! Module: horizon-client_item_activation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The item that spins up to the screen when it activates (the totem of
//! undying): `net.minecraft.client.player.ItemActivation`, set by
//! `LocalPlayer.displayItemActivation`, ticked by `GameRenderer.tick`, and
//! posed by `ScreenEffectRenderer.renderItemActivationAnimation`.
// use crate::items::ItemStack;
// use glam::{Mat4, Vec3};
// use horizon_core::{geometry::trig::Mth, random::RandomSource};

/// `ItemActivation.ANIMATION_LENGTH`, in ticks.
pub const ANIMATION_LENGTH: i32 = 40;

pub const ItemActivation = struct {
    item: ?ItemStack,
    ticks: i32,
    off_x: f32,
    off_y: f32,
};

    // rust: impl ItemActivation {
    /// `ItemActivation.tick`: the item goes when the count reaches 0.
pub fn tick(self: *Self) void {
}
    // rust: if self.ticks > 0 {
    // rust: self.ticks -= 1;
    // rust: if self.ticks == 0 {
    // rust: self.item = None;
}
}
}
    /// `ItemActivation.reset` (`GameRenderer.resetData`).
pub fn reset(self: *Self) void {
}
    // rust: self.item = None;
    // rust: self.ticks = 0;
}
    /// `ItemActivation.activate`: a copy of the stack, the full length, and
    /// two random offsets in [-1, 1) for where on the screen it flies.
pub fn activate(self: *Self, item: ItemStack, random: *mut impl RandomSource) void {
}
    // rust: self.item = Some(item);
    // rust: self.ticks = ANIMATION_LENGTH;
    // rust: self.off_x = random.next_float() * 2.0 - 1.0;
    // rust: self.off_y = random.next_float() * 2.0 - 1.0;
}
    /// `ItemActivation.isActive`: the item to draw, while it shows.
pub fn active(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.item.as_ref().filter(|_| self.ticks > 0)
}
    /// The item's view-space pose this frame, before its `FIXED` display
    /// transform; `aspect` is the window's width over its height.
pub fn pose(self: *Self, partial: f32, aspect: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.active()?;
    // rust: Some(animation_pose(
    // rust: self.ticks, partial, self.off_x, self.off_y, aspect,
    // rust: ))
}
}

/// `ScreenEffectRenderer.renderItemActivationAnimation`: a quintic over the
/// 40 ticks brings the item from 10 blocks out to 1 and back while it turns
/// 900 degrees about Y and rocks 6 degrees about X and Z, drawn with the
/// hand's projection and no camera transform.
pub fn animation_pose(ticks: i32, partial: f32, off_x: f32, off_y: f32, aspect: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tick = ANIMATION_LENGTH - ticks;
    // rust: let t = (tick as f32 + partial) / 40.0;
    // rust: let t2 = t * t;
    // rust: let t3 = t * t2;
    // rust: let curve = 10.25 * t3 * t2 - 24.95 * t2 * t2 + 25.5 * t3 - 13.8 * t2 + 4.0 * t;
    // rust: let angle = curve * std::f32::consts::PI;
    // rust: let x = off_x * 0.3 * aspect;
    // rust: let y = off_y * 0.3;
    // rust: let swing = (angle * 2.0).msin().abs();
    // rust: Mat4::from_translation(Vec3::new(x * swing, y * swing, -10.0 + 9.0 * angle.msin()))
    // rust: * Mat4::from_scale(Vec3::splat(0.8))
    // rust: * Mat4::from_rotation_y((900.0 * angle.msin().abs()).to_radians())
    // rust: * Mat4::from_rotation_x((6.0 * (t * 8.0).mcos()).to_radians())
    // rust: * Mat4::from_rotation_z((6.0 * (t * 8.0).mcos()).to_radians())
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

pub fn totem() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new("minecraft:totem_of_undying", 1)
}

pub fn it_shows_for_forty_ticks() void {
}
    // rust: let mut a = ItemActivation::default();
    // rust: assert!(a.active().is_none());
    // rust: a.activate(totem(), &mut LegacyRandom::new(0));
    // rust: for _ in 0..39 {
    // rust: a.tick();
    // rust: assert!(a.active().is_some());
}
    // rust: a.tick();
    // rust: assert!(a.active().is_none());
    // rust: assert!(a.pose(0.0, 1.0).is_none());
}

pub fn the_offsets_are_two_floats_from_the_players_random() void {
}
        // java.util.Random(0): nextFloat() 0.73096776, then 0.831441.
    // rust: let mut a = ItemActivation::default();
    // rust: a.activate(totem(), &mut LegacyRandom::new(0));
    // rust: assert!((a.off_x - 0.461_935_5).abs() < 1e-6, "{}", a.off_x);
    // rust: assert!((a.off_y - 0.662_882).abs() < 1e-6, "{}", a.off_y);
}

pub fn it_comes_from_ten_blocks_out_to_one_and_back() void {
}
    // rust: let at = |ticks, partial| {
    // rust: animation_pose(ticks, partial, 0.5, -0.5, 16.0 / 9.0)
    // rust: .w_axis
    // rust: .truncate()
}
        // First tick: straight ahead, 10 out.
    // rust: assert_eq!(at(40, 0.0), Vec3::new(0.0, 0.0, -10.0));
        // Halfway the curve is 0.4984375: almost PI/2, so about 1 out and
        // the sideways swing (|sin 2a|) nearly gone.
    // rust: let mid = at(20, 0.0);
    // rust: assert!((mid.z - -1.0).abs() < 1e-3, "{mid}");
    // rust: let a = 0.498_437_5 * std::f32::consts::PI;
    // rust: let swing = (a * 2.0).msin().abs();
    // rust: assert!((mid.x - 0.5 * 0.3 * 16.0 / 9.0 * swing).abs() < 1e-6);
    // rust: assert!((mid.y - -0.5 * 0.3 * swing).abs() < 1e-6);
        // A quarter in (curve 0.4484863): already near, swung to the side.
    // rust: let quarter = at(30, 0.0);
    // rust: let a = 0.448_486_33 * std::f32::consts::PI;
    // rust: assert!((quarter.z - (-10.0 + 9.0 * a.msin())).abs() < 1e-5);
    // rust: let swing = (a * 2.0).msin().abs();
    // rust: assert!((quarter.x - 0.5 * 0.3 * 16.0 / 9.0 * swing).abs() < 1e-6);
        // Partial ticks move it smoothly between ticks.
    // rust: let between = at(39, 0.5).z;
    // rust: assert!(between > at(39, 0.0).z && between < at(38, 0.0).z);
}

pub fn it_is_scaled_to_four_fifths() void {
}
    // rust: let m = animation_pose(25, 0.3, 0.0, 0.0, 1.0);
    // rust: let (scale, _, _) = m.to_scale_rotation_translation();
    // rust: assert!((scale - Vec3::splat(0.8)).abs().max_element() < 1e-5);
}
}
