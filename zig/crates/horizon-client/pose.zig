//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pose
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resident player pose, native dimension arithmetic and dry pose-fit selection.
//! Full synchronized entity schemas, sleeping and fluid/flight lifecycles remain
//! separate from these stored movement fields.
// use crate::{
    // rust: Result,
    // rust: motion::{MotionWorld, PlayerMotion},
}
// use horizon_core::geometry::{Aabb, Vec3};

pub const Pose = enum {
    Standing,
    Crouching,
    Swimming,
    FallFlying,
    SpinAttack,
    Sleeping,
};
    // rust: impl Pose {
    /// `Pose` by its network id (`Pose.id`); the poses a player never takes
    /// are standing.
pub fn from_id(id: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: 1 => Self::FallFlying,
    // rust: 2 => Self::Sleeping,
    // rust: 3 => Self::Swimming,
    // rust: 4 => Self::SpinAttack,
    // rust: 5 => Self::Crouching,
    // rust: _ => Self::Standing,
}
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Standing => "STANDING",
    // rust: Self::Crouching => "CROUCHING",
    // rust: Self::Swimming => "SWIMMING",
    // rust: Self::FallFlying => "FALL_FLYING",
    // rust: Self::SpinAttack => "SPIN_ATTACK",
    // rust: Self::Sleeping => "SLEEPING",
}
}
    /// `Avatar.POSES` (and `LivingEntity.SLEEPING_DIMENSIONS`): the box of a
    /// player or mannequin in this pose; sleeping ignores the scale.
pub fn dimensions(self: *Self, scale: f32) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (width, height, eye_height) = match self {
    // rust: Self::Standing => (0.6 * scale, 1.8 * scale, 1.62 * scale),
    // rust: Self::Crouching => (0.6 * scale, 1.5 * scale, 1.27 * scale),
    // rust: Self::Swimming | Self::FallFlying | Self::SpinAttack => {
    // rust: (0.6 * scale, 0.6 * scale, 0.4 * scale)
}
    // rust: Self::Sleeping => (0.2, 0.2, 0.2),
}
    // rust: Dimensions {
    // rust: width,
    // rust: height,
    // rust: eye_height,
}
}
}
pub const Dimensions = struct {
    width: f32,
    height: f32,
    eye_height: f32,
};
    // rust: impl Dimensions {
pub fn bounds(self: *Self, position: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from(self.width / 2.0);
    // rust: Aabb::new(
    // rust: Vec3::new(position.x - half, position.y, position.z - half),
    // rust: Vec3::new(
    // rust: position.x + half,
    // rust: position.y + f64::from(self.height),
    // rust: position.z + half,
    // rust: ),
    // rust: )
}
}
    // rust: impl PlayerMotion {
    /// `LivingEntity.aiStep` counting down `autoSpinAttackTicks` for a
    /// server's copy of a player, which runs no client tick: the spin ends
    /// after its ticks and its damage goes with it, so the pose (and the eye
    /// a bow or a trident is shot from) comes back to standing.
pub fn count_down_server_spin(self: *Self) void {
}
    // rust: if self.auto_spin_attack_ticks > 0 {
    // rust: self.auto_spin_attack_ticks -= 1;
    // rust: if self.auto_spin_attack_ticks <= 0 {
    // rust: self.auto_spin_attack_dmg = 0.0;
}
}
}
pub fn dimensions_for_pose(self: *Self, pose: Pose) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(pose.dimensions(self.attribute("minecraft:scale")? as f32))
}
pub fn refresh_dimensions(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scale = self.attribute("minecraft:scale")? as f32;
    // rust: self.dimensions = self.pose.dimensions(self.scale);
    // rust: Ok(())
}
pub fn set_pose(self: *Self, pose: Pose) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.pose != pose {
    // rust: self.pose = pose;
    // rust: self.refresh_dimensions()?;
}
    // rust: Ok(())
}
    /// `LivingEntity.startSleeping` and `stopSleeping` set the pose at once
    /// (the 0.2 box in the bed, standing again after).
pub fn set_sleeping(self: *Self, sleeping: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.sleeping != sleeping {
    // rust: self.sleeping = sleeping;
    // rust: self.set_pose(if sleeping {
    // rust: Pose::Sleeping
    // rust: } else {
    // rust: Pose::Standing
    // rust: })?;
}
    // rust: Ok(())
}
    /// `LocalPlayer.isMovingSlowly`: crouching, or `Entity.isVisuallyCrawling`
    /// (visually swimming out of water). `LivingEntity.isVisuallySwimming`
    /// counts the swimming pose and the fall-flying pose a glide that just
    /// ended still holds, so the tick after an elytra lands moves at sneaking
    /// speed (#8295).
pub fn moving_slowly(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let visually_swimming =
    // rust: self.pose == Pose::Swimming || (!self.fall_flying && self.pose == Pose::FallFlying);
    // rust: self.local_crouching || (visually_swimming && !self.fluids.was_touching_water)
}
}
    // rust: impl MotionWorld<'_, '_, '_> {
pub fn can_fit_pose(self: *Self, pose: Pose) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bounds = self
    // rust: .player
    // rust: .dimensions_for_pose(pose)?
    // rust: .bounds(self.player.position);
    // rust: self.no_player_collision(bounds.deflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7)))
}
    /// LocalPlayer.aiStep computes crouching BEFORE KeyboardInput.tick, using
    /// the old shift input. This is distinct from Entity's current pose.
pub fn update_local_crouching(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.local_crouching = !self.player.flying
    // rust: && !self.player.swimming
    // rust: && self.can_fit_pose(Pose::Crouching)?
    // rust: && (self.player.shift_key_down || !self.can_fit_pose(Pose::Standing)?);
    // rust: Ok(())
}
    /// Dry Player.updatePlayerPose after movement: crawl when neither standing
    /// nor crouching fits; leave the current pose if even crawling cannot fit.
pub fn update_player_pose(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.can_fit_pose(Pose::Swimming)? {
    // rust: return Ok(());
}
        // Player.getDesiredPose: sleeping, swimming, gliding, Riptide's spin.
    // rust: let desired = if self.player.sleeping {
    // rust: Pose::Sleeping
    // rust: } else if self.player.swimming {
    // rust: Pose::Swimming
    // rust: } else if self.player.fall_flying {
    // rust: Pose::FallFlying
    // rust: } else if self.player.auto_spin_attack_ticks > 0 {
    // rust: Pose::SpinAttack
    // rust: } else if self.player.shift_key_down && !self.player.flying {
    // rust: Pose::Crouching
    // rust: } else {
    // rust: Pose::Standing
}
    // rust: let pose = if self.player.spectator || self.can_fit_pose(desired)? {
    // rust: desired
    // rust: } else if self.can_fit_pose(Pose::Crouching)? {
    // rust: Pose::Crouching
    // rust: } else {
    // rust: Pose::Swimming
}
    // rust: self.player.set_pose(pose)
}
    /// The end of a server's copy of a player's tick (`ServerPlayer.doTick`
    /// runs `Player.tick`): `LivingEntity.aiStep` counts a Riptide spin down,
    /// `LivingEntity.tick` then runs `refreshDirtyAttributes` (a changed
    /// `minecraft:scale` rebuilds the box, `onAttributeUpdated`), and
    /// `Player.tick` ends with `updatePlayerPose`. The server checks the
    /// player's moves with that box (#3684).
pub fn server_player_pose_tick(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.count_down_server_spin();
    // rust: self.player.refresh_attributes()?;
    // rust: self.update_player_pose()
}
    /// The pose part of `Player.tick` for a passenger (`Entity.rideTick` runs
    /// `tick`, not the travel): `Entity.updateSwimming` stops a swim, since it
    /// needs `!isPassenger()`, and `updatePlayerPose` follows. A player who
    /// boards a boat while swimming sits up instead of lying under it (#3308).
    /// The server's `LivingEntity.updateFallFlying` ends a glide the same way
    /// (`canGlide` needs `!isPassenger()`) and `LivingEntity.tick` resets
    /// `fallFlyTicks`: a player who boards while gliding sits up instead of
    /// keeping the glide pose (#3093).
    /// `Entity.baseTick` still samples the fluids first, in the box the vehicle
    /// allows (the boat the game stores in the player's fluid state), so a boat
    /// afloat keeps the eyes dry.
pub fn passenger_pose_tick(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.fluids.was_eye_in_water = self.player.is_eye_in_fluid(crate::motion::WATER);
    // rust: self.update_fluids()?;
        // Player.tick: a passenger is never on the ground (setOnGround(false)
        // clears the supporting block too), so its look packets say so.
    // rust: self.player.ground.on_ground = false;
    // rust: self.player.ground.on_ground_no_blocks = false;
    // rust: self.player.ground.supporting_block = None;
    // rust: self.player.swimming = false;
    // rust: self.player.fall_flying = false;
    // rust: self.player.fall_fly_ticks = 0;
    // rust: self.update_player_pose()?;
        // A cushion's seat puts the feet in the support block, so neither
        // standing nor crawling fits and `updatePlayerPose` keeps the old
        // pose. A prior swim would stick (#4509); sit up like a boat rider.
    // rust: if self.player.pose == Pose::Swimming && !self.player.sleeping {
    // rust: self.player.set_pose(Pose::Standing)?;
}
    // rust: Ok(())
}
}
