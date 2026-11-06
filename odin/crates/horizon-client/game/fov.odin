//! Transpiled from Horizon Rust crate
package horizon_client_fov

import "core:fmt"
import "core:mem"
import "core:math"

// Field of view (`Camera.tickFov`, `calculateFov`,
// `AbstractClientPlayer.getFieldOfViewModifier`), view and hurt bobbing
// (`GameRenderer.bobHurt`, `bobView`), the portal and Nausea spin
// (`GameRenderer.renderLevel`) and the spyglass (`SpyglassItem`,
// `Hud.extractSpyglassOverlay`). The arithmetic is `horizon_client::camera`.
// use super::Game;
// use horizon_client::{
    // rust: camera::{
    // rust: BobState, CameraFluid, FovPlayer, HurtBob, UseItem, bob_matrix, field_of_view_modifier,
    // rust: spinning_effect_matrix,
    // rust: },
    // rust: fog::{FogType, fog_type},
    // rust: hud::HudBatch,
    // rust: hud_layout, hud_overlays,
}

// `Abilities.walkingSpeed`.
WALKING_SPEED :: 0.1

valid_fov_modifier :: proc(modifier: f32, fallback: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if modifier.is_finite() && (0.01..=10.0).contains(&modifier) {
    // rust: modifier
    // rust: } else {
    // rust: fallback
}
}

    // rust: impl Game<'_> {
    // `Player.isScoping`: using a spyglass.
    // rust: pub(super) fn scoping(&self) -> bool {
    // rust: self.using
    // rust: .and_then(|(slot, _)| self.stack_in(slot))
    // rust: .is_some_and(|s| &*s.item == "minecraft:spyglass")
}
    // `options.fovEffectScale`.
    // rust: pub(super) fn fov_effect_scale(&self) -> f32 {
    // rust: self.settings.file.double("fovEffectScale") as f32
}
    // `options.screenEffectScale` (Distortion Effects).
    // rust: pub(super) fn screen_effect_scale(&self) -> f32 {
    // rust: self.settings.file.double("screenEffectScale") as f32
}
    // `LocalPlayer.getEffectBlendFactor(NAUSEA, partial)`: 0 without the effect.
    // rust: pub(super) fn nausea_blend(&self, partial: f32) -> f32 {
    // rust: if self.potions.effects.get("nausea").is_none() {
    // rust: return 0.0;
}
    // rust: let fx = &self.screen_fx;
    // rust: fx.o_nausea + partial * (fx.nausea - fx.o_nausea)
}
    // The spin `GameRenderer.renderLevel` multiplies into the level's
    // projection: the larger of the portal and Nausea intensities, scaled by
    // Distortion Effects squared, turning by `LocalPlayer.getSpinningEffectAngle`.
    // rust: pub(super) fn spinning_matrix(&self, partial: f32) -> glam::Mat4 {
    // rust: let fx = &self.screen_fx;
    // rust: let portal = fx.o_portal + partial * (fx.portal - fx.o_portal);
    // rust: let scale = self.screen_effect_scale();
    // rust: let intensity = portal.max(self.nausea_blend(partial)) * (scale * scale);
    // rust: spinning_effect_matrix(intensity, fx.spinning_time + partial * fx.spinning_speed)
}
    // What `AbstractClientPlayer.getFieldOfViewModifier` reads.
fov_player :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.player.as_ref()?;
    // rust: let using = self.using.and_then(|(slot, ticks)| {
    // rust: let stack = self.stack_in(slot)?;
    // rust: let item = match &*stack.item {
    // rust: "minecraft:bow" => UseItem::Bow,
    // rust: "minecraft:spyglass" => UseItem::Spyglass,
    // rust: _ => UseItem::Other,
}
    // rust: Some((item, ticks as i32))
    // rust: });
    // rust: Some(FovPlayer {
    // rust: flying: p.flying,
    // rust: walking_speed: WALKING_SPEED,
            // Player.aiStep keeps `speed` as the float movement speed attribute.
    // rust: movement_speed: f64::from(p.speed),
    // rust: using,
    // rust: })
}
    // `Camera.tick`: the eye height and the field-of-view modifier ease
    // halfway toward the player's each tick.
    // rust: pub(super) fn tick_fov(&mut self) {
    // rust: let first_person = self.camera_type.first_person();
    // rust: let effect = self.fov_effect_scale();
    // rust: let target = self.fov_player().map_or(1.0, |player| {
    // rust: let base = field_of_view_modifier(&player, first_person, effect);
    // rust: let mut modifier = base;
    // rust: self.native_compute_fov_modifier(&player, base, &mut modifier);
    // rust: valid_fov_modifier(modifier, base)
    // rust: });
    // rust: let target = self.zoomed_fov_target(target);
        // A server's spectator camera on a mob: its eye height. Its modifier
        // stays 1 (another player's own modifier is not modelled here); the
        // zoom extra still narrows it.
    // rust: if let Some(m) = self.camera_mob() {
    // rust: let eye = m.eye_height() as f32;
    // rust: self.view.tick(Some(eye), self.zoomed_fov_target(1.0));
    // rust: return;
}
    // rust: let eye = self.player.as_ref().map(|p| {
    // rust: if self.sleeping.is_some() {
    // rust: 0.2
    // rust: } else {
    // rust: p.dimensions.eye_height
}
    // rust: });
    // rust: self.view.tick(eye, target);
}
    // The player's `deathTime` while dead or dying: whole ticks counted by
    // `LivingEntity.tickDeath`, so `deathTime + partialTicks` in
    // `Camera.extractRenderState` rises smoothly across frames.
    // rust: pub(super) fn death_time(&self) -> Option<i32> {
    // rust: let p = self.player.as_ref()?;
    // rust: p.health
    // rust: .dead_or_dying()
    // rust: .then(|| self.ui.death_time.min(i32::MAX as u32) as i32)
}
    // The fluid at the camera, as `Camera.getFluidInCamera` reports it.
    // rust: pub(super) fn camera_fluid(&self, camera: [f64; 3]) -> CameraFluid {
    // rust: match fog_type(&self.world, self.res.facts(), camera, &self.near_plane()) {
    // rust: FogType::Water => CameraFluid::Water,
    // rust: FogType::Lava => CameraFluid::Lava,
    // rust: FogType::PowderSnow => CameraFluid::PowderSnow,
    // rust: FogType::Atmospheric => CameraFluid::None,
}
}
    // `Camera.calculateFov` with `modifyFovBasedOnDeathOrFluid`.
    // rust: pub(super) fn fov_degrees(&self, partial: f32, camera: [f64; 3]) -> f32 {
    // rust: let fov = self.view.calculate_fov(
    // rust: partial,
    // rust: self.settings.fov as i32,
    // rust: self.fov_effect_scale(),
    // rust: self.death_time(),
    // rust: self.camera_fluid(camera),
    // rust: false,
    // rust: );
    // rust: let vanilla = self.zoomed_fov_degrees(fov);
    // rust: let mut degrees = vanilla;
    // rust: self.native_compute_fov(partial, camera, &mut degrees);
    // rust: if degrees.is_finite() && (1.0..=179.0).contains(&degrees) {
    // rust: degrees
    // rust: } else {
    // rust: vanilla
}
}
    // How many times the view is magnified right now: the player's field of
    // view over the one actually in use, and 1 when nothing is zooming.
    //
    // Reads the result rather than any one zoom, so it covers all three:
    // the spyglass (`AbstractClientPlayer.getFieldOfViewModifier`'s tenth
    // while `isScoping`), the zoom mod (`native_zoom`) and any mod that
    // narrows the field of view through `native_compute_fov`.
    // rust: pub(super) fn zoom_magnification(&self, camera: [f64; 3]) -> f32 {
    // rust: let now = self.fov_degrees(1.0, camera);
    // rust: let base = self.settings.fov.clamp(1.0, 179.0);
    // rust: if now.is_finite() && now > 0.5 {
    // rust: (base / now).max(1.0)
    // rust: } else {
    // rust: 1.0
}
}
    // What far terrain should plan for a zoomed view, or `None` when the
    // `lodZoomDetail` extra is off or nothing is zooming (`lod::ZoomAim`).
    // rust: pub(super) fn lod_aim(&self, camera: [f64; 3]) -> Option<horizon_client::lod::ZoomAim> {
    // rust: if !self.settings.extras.lod_zoom_detail {
    // rust: return None;
}
    // rust: horizon_client::lod::ZoomAim::new(
    // rust: self.yaw,
    // rust: self.fov_degrees(1.0, camera),
    // rust: self.zoom_magnification(camera),
    // rust: )
}
    // `Camera.calculateHudFov`: the first-person hand's field of view.
    // rust: pub(super) fn hud_fov_degrees(&self, partial: f32, camera: [f64; 3]) -> f32 {
    // rust: self.view.calculate_hud_fov(
    // rust: partial,
    // rust: self.fov_effect_scale(),
    // rust: self.death_time(),
    // rust: self.camera_fluid(camera),
    // rust: )
}
    // The pose `GameRenderer.renderLevel` multiplies into the projection:
    // `bobHurt`, then `bobView` with the View Bobbing option.
    // rust: pub(super) fn bob_matrix(&self, partial: f32) -> glam::Mat4 {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return glam::Mat4::IDENTITY;
}
    // rust: let hurt = &p.health.hurt;
    // rust: let state = BobState {
    // rust: living: Some(HurtBob {
    // rust: hurt_time: p.health.hurt_animation_time as f32 - partial,
    // rust: hurt_duration: hurt.hurt_duration,
    // rust: hurt_dir: p.health.hurt_dir,
    // rust: death_time: self.death_time().map(|t| t as f32 + partial),
    // rust: }),
    // rust: player: Some((
    // rust: self.avatar.backwards_interpolated_walk_distance(partial),
    // rust: self.avatar.interpolated_bob(partial),
    // rust: )),
}
    // rust: let tilt = self.settings.file.double("damageTiltStrength");
    // rust: glam::Mat4::from_cols_array(&bob_matrix(&state, tilt, self.settings.view_bobbing).m)
    // rust: * self.native_shake_matrix(partial)
}
    // `AbstractClientPlayer.tick` and `aiStep` (`ClientAvatarState.tick`,
    // `updateBob`), `rideTick`'s `resetBob` and `LocalPlayer.move`'s walked
    // distance, after the player's movement this tick. `before` is the
    // ground state, velocity and position at the start of the tick.
    // rust: pub(super) fn tick_avatar(&mut self, before: (bool, [f64; 3], [f64; 3]), riding: bool) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let (ground, velocity, start) = before;
    // rust: let swimming = p.pose == horizon_client::pose::Pose::Swimming;
    // rust: let alive = !p.health.dead_or_dying();
    // rust: let (dx, dz) = (
    // rust: (p.position.x - start[0]) as f32,
    // rust: (p.position.z - start[2]) as f32,
    // rust: );
    // rust: self.avatar.tick(start);
    // rust: self.avatar
    // rust: .update_bob(ground && alive && !swimming, velocity);
    // rust: if riding {
    // rust: self.avatar.reset_bob();
    // rust: } else {
    // rust: self.avatar.add_walked(dx, dz);
}
}
    // `SpyglassItem.use`: the sound, then start scoping (a mod's `Start`
    // may refuse that, not the sound).
    // rust: pub(super) fn use_spyglass(&mut self) {
        // Player.playSound: at the feet (getY), not the eyes.
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: self.audio.play("minecraft:item.spyglass.use", at, 1.0, 1.0);
    // rust: self.award_stat("used", "minecraft:spyglass", 1);
    // rust: self.start_using_item();
}
    // `SpyglassItem.releaseUsing` / `finishUsingItem` (after 1200 ticks).
    // rust: pub(super) fn stop_spyglass(&mut self) {
    // rust: let at = self.eye_position();
    // rust: self.audio
    // rust: .play("minecraft:item.spyglass.stop_using", at, 1.0, 1.0);
}
    // `Hud.extractCameraOverlays`: the spyglass scope, its size easing
    // towards 1.125 by half the frame's game ticks and reset to 0.5 while
    // not scoping in first person.
    // rust: pub(super) fn draw_spyglass(&mut self, batch: &mut HudBatch) {
    // rust: self.scope_scale += 0.5 * self.frame_ticks * (1.125 - self.scope_scale);
    // rust: if !self.camera_type.first_person() {
    // rust: return;
}
    // rust: if !self.scoping() {
    // rust: self.scope_scale = 0.5;
    // rust: return;
}
    // rust: let draws =
    // rust: hud_overlays::spyglass(batch.width as i32, batch.height as i32, self.scope_scale);
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
}

    // rust: mod tests {
//     use super::valid_fov_modifier;
modifier_validation :: proc() {
}
    // rust: assert_eq!(valid_fov_modifier(0.5, 1.0), 0.5);
    // rust: for value in [f32::NAN, f32::INFINITY, 0.0, 10.1] {
    // rust: assert_eq!(valid_fov_modifier(value, 1.0), 1.0);
}
}
}
