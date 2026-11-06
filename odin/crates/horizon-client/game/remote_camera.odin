//! Transpiled from Horizon Rust crate
package horizon_client_remote_camera

import "core:fmt"
import "core:mem"
import "core:math"

// A server's spectator camera (`ClientPacketListener.handleSetCamera`,
// `Minecraft.cameraEntity`): `/spectate` or a spectator's click (sent as
// `MultiPlayerGameMode.spectate`) attaches the view to another entity. The
// view follows that entity while the player stands still and sends no moves
// (`LocalPlayer.isControlledCamera`); the server keeps its player on the
// camera and lets go when the player sneaks.
// use super::Game;
// use horizon_client::{
    // rust: camera::{CameraEntity, LivingCamera},
    // rust: mobs::Mob,
}

// `Minecraft.setCameraEntity` from a ClientboundSetCameraPacket: the player's
// own id puts the view back on the player; an id the level does not hold
// changes nothing (`ClientboundSetCameraPacket.getEntity` is null).
    // rust: pub(super) fn camera_after_packet(
    // rust: current: Option<i32>,
    // rust: player_id: i32,
    // rust: camera_id: i32,
    // rust: in_level: bool,
    // rust: ) -> Option<i32> {
    // rust: if camera_id == player_id {
    // rust: None
    // rust: } else if in_level {
    // rust: Some(camera_id)
    // rust: } else {
    // rust: current
}
}

// `Camera.alignWithEntity`'s view of a mob or another player: its
// interpolated position, `getViewYRot`/`getViewXRot` and eye height, with
// its scale and camera distance for a detached view. A living entity's
// `getViewYRot` is its head's yaw (`yHeadRot`), not its body's `yRot`.
    // rust: pub(super) fn mob_camera_entity(m: &Mob) -> CameraEntity {
    // rust: let attribute =
    // rust: |name: &str, default: f64| m.kind.attributes.get(name).copied().unwrap_or(default);
    // rust: CameraEntity {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: previous: [m.previous.x, m.previous.y, m.previous.z],
    // rust: x_rot: m.head_pitch,
    // rust: y_rot: m.head_yaw,
    // rust: x_rot_o: m.previous_head_pitch,
    // rust: y_rot_o: m.previous_head_yaw,
    // rust: eye_height: m.eye_height() as f32,
    // rust: living: Some(LivingCamera {
    // rust: scale: attribute("minecraft:scale", 1.0) as f32,
    // rust: camera_distance: attribute("minecraft:camera_distance", 4.0),
    // rust: sleeping: None,
    // rust: dead: None,
    // rust: }),
    // rust: mount: None,
}
}

// `GameRenderer.checkEntityPostEffect`: the chain a spectated creeper, spider
// or enderman puts on the screen.
    // rust: pub(super) fn entity_post_effect(kind: &str) -> Option<&'static str> {
    // rust: match kind.strip_prefix("minecraft:").unwrap_or(kind) {
    // rust: "creeper" => Some("minecraft:creeper"),
        // CaveSpider extends Spider.
    // rust: "spider" | "cave_spider" => Some("minecraft:spider"),
    // rust: "enderman" => Some("minecraft:invert"),
    // rust: _ => None,
}
}

    // rust: impl Game<'_> {
    // `ClientPacketListener.handleSetCamera`.
    // rust: pub(super) fn remote_set_camera(&mut self, camera_id: i32) {
    // rust: let in_level = self.mobs.iter().any(|m| m.id == camera_id as u32);
    // rust: let player = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.entity_id == camera_id);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.camera = camera_after_packet(r.camera, r.entity_id, camera_id, in_level);
}
        // Minecraft.setCameraEntity, for an entity the level holds.
    // rust: if in_level || player {
    // rust: self.check_entity_post_effect(true);
}
}
    // `GameRenderer.checkEntityPostEffect` for the camera entity, or for none
    // (`first_person` false: the third-person view clears it).
    // rust: pub(super) fn check_entity_post_effect(&mut self, first_person: bool) {
    // rust: self.spectated_post_effect = self
    // rust: .camera_mob()
    // rust: .filter(|_| first_person)
    // rust: .and_then(|m| entity_post_effect(&m.kind.id));
}
    // The entity a server attached the view to, when it is not the player.
    // rust: pub(super) fn remote_camera_id(&self) -> Option<u32> {
    // rust: self.remote.as_ref()?.camera.map(|id| id as u32)
}
    // `LocalPlayer.isControlledCamera`: the view is the player's own.
    // rust: pub(super) fn controls_camera(&self) -> bool {
    // rust: self.remote_camera_id().is_none()
}
    // The mob the view follows, while the level still holds it.
    // rust: pub(super) fn camera_mob(&self) -> Option<&Mob> {
    // rust: let id = self.remote_camera_id()?;
    // rust: self.mobs.iter().find(|m| m.id == id)
}
    // The entity under a spectator's crosshair (`Minecraft.hitResult` as an
    // `EntityHitResult`): the nearest mob or object before any block.
    // rust: pub(super) fn spectator_click_target(&self) -> Option<i32> {
    // rust: let mob = self.mob_hit().map(|(i, d, _)| (self.mobs[i].id as i32, d));
    // rust: let object = self.remote_object_hit(false).map(|h| (h.id, h.distance));
    // rust: [mob, object]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|(_, d)| self.before_block(*d))
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(id, _)| id)
}
    // `LevelRenderer`: the camera entity is not drawn from its own eyes.
    // rust: pub(super) fn hides_as_camera(&self, id: u32) -> bool {
    // rust: self.camera_type.first_person() && self.remote_camera_id() == Some(id)
}
}

    // rust: mod tests {
//     use super::{camera_after_packet, entity_post_effect};

    // Only a creeper, spider or enderman has a spectator chain.
spectated_entities_pick_their_chain :: proc() {
}
    // rust: assert_eq!(
    // rust: entity_post_effect("minecraft:creeper"),
    // rust: Some("minecraft:creeper")
    // rust: );
    // rust: assert_eq!(
    // rust: entity_post_effect("minecraft:spider"),
    // rust: Some("minecraft:spider")
    // rust: );
    // rust: assert_eq!(
    // rust: entity_post_effect("minecraft:enderman"),
    // rust: Some("minecraft:invert")
    // rust: );
    // rust: assert_eq!(
    // rust: entity_post_effect("minecraft:cave_spider"),
    // rust: Some("minecraft:spider")
    // rust: );
    // rust: assert_eq!(entity_post_effect("minecraft:cow"), None);
}

    // The camera goes to a known entity, back to the player on its own id,
    // and stays where it is for an entity the level does not hold.
set_camera_follows_vanilla :: proc() {
}
    // rust: assert_eq!(camera_after_packet(None, 5, 9, true), Some(9));
    // rust: assert_eq!(camera_after_packet(Some(9), 5, 5, false), None);
    // rust: assert_eq!(camera_after_packet(Some(9), 5, 12, false), Some(9));
    // rust: assert_eq!(camera_after_packet(None, 5, 12, false), None);
}
}
