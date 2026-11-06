//! Transpiled from Horizon Rust crate
package horizon_client_lan_camera

import "core:fmt"
import "core:mem"
import "core:math"

// A spectating guest's camera (`ServerPlayer.camera`): chosen by a click
// (`handleSpectatorAction`) or `/spectate`, followed every tick, dropped
// when the entity dies, the player sneaks, is teleported or leaves
// spectator mode.
// use super::{Game, commands::Target, lan::LanHost};
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_protocol::packets::play::{self, Clientbound as C};

// Where a camera entity is, which way it looks and its box.
    // rust: pub(super) struct CameraExtra {
    // rust: pub position: [f64; 3],
    // rust: pub rotation: [f32; 2],
    // rust: pub bounds: Aabb,
}

// `ServerPlayer.camera` of one guest other than itself.
    // rust: pub(super) struct GuestCamera {
    // The camera entity's network id.
    // rust: pub id: i32,
    // The guest's teleport counter once the view moved to the camera: a
    // later teleport is `teleportTo(.., resetCamera = true)`.
    // rust: teleports: i32,
}

// Whether `ServerPlayer.tick` hands the view back to the player: the
// camera is gone (`!isAlive`), the player wants to stop riding (sneaks),
// left spectator mode (`setGameMode`) or was teleported (`resetCamera`).
camera_ends :: proc(alive: bool, sneaking: bool, spectator: bool, teleported: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !alive || sneaking || !spectator || teleported
}

    // rust: impl Game<'_> {
    // `ServerPlayer.isAlive` of the camera, with where it is and how it
    // looks (`absSnapTo`'s arguments): a player, the host or any other
    // entity of the level, by network id.
camera_state :: proc(self: ^Self, host: ^LanHost, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(g) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id == id && host.hub.here(g))
    // rust: {
    // rust: return (!g.dead).then_some((g.position, [g.yaw, g.pitch]));
}
    // rust: if let Some(special) = self.camera_extra(id) {
    // rust: return Some((special.position, special.rotation));
}
    // rust: let t = self.level_entity(id)?;
    // rust: if let Target::Mob(m) = t
    // rust: && !self.mobs.iter().any(|x| x.id == m && x.alive())
    // rust: {
    // rust: return None;
}
    // rust: Some((self.target_position(t)?, self.target_rotation(t)))
}

    // The camera targets `Target` does not name: primed TNT and falling
    // blocks (`isPickable` is `!isRemoved`) and `EnderDragonPart`s
    // (`ServerLevel.getEntityOrPart`; `isPickable` is `true`, and a part
    // never turns).
    // rust: pub(super) fn camera_extra(&self, id: i32) -> Option<CameraExtra> {
    // rust: let id = u32::try_from(id).ok().filter(|&id| id != 0)?;
    // rust: let at = |v: Vec3| [v.x, v.y, v.z];
    // rust: if let Some(t) = self.tnts.iter().find(|t| t.id == id) {
    // rust: return Some(CameraExtra {
    // rust: position: at(t.position),
    // rust: rotation: [0.0; 2],
    // rust: bounds: t.bounds(),
    // rust: });
}
    // rust: if let Some(f) = self.falling.iter().find(|f| f.id == id) {
            // EntityType.FALLING_BLOCK: 0.98 x 0.98.
    // rust: let h = 0.49;
    // rust: return Some(CameraExtra {
    // rust: position: at(f.position),
    // rust: rotation: [0.0; 2],
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(f.position.x - h, f.position.y, f.position.z - h),
    // rust: Vec3::new(f.position.x + h, f.position.y + 0.98, f.position.z + h),
    // rust: ),
    // rust: });
}
    // rust: let (position, bounds) = self.dragon_part(id)?;
    // rust: Some(CameraExtra {
    // rust: position: at(position),
    // rust: rotation: [0.0; 2],
    // rust: bounds,
    // rust: })
}

    // `Entity.isPickable` of the entity with that id.
camera_pickable :: proc(self: ^Self, host: ^LanHost, id: i32) -> b {
    // Ported from Horizon
    return {}
}
        // Player.isPickable: not a spectator.
    // rust: if let Some(g) = host.hub.guests.iter().find(|g| g.entity_id == id) {
    // rust: return !g.spectator() && !g.dead;
}
    // rust: if self.camera_extra(id).is_some() {
    // rust: return true;
}
    // rust: match self.level_entity(id) {
            // Projectile.isPickable: the redirectable projectiles
            // (`#redirectable_projectile`); ShulkerBullet's is `true`.
    // rust: Some(t @ Target::Projectile(_)) => matches!(
    // rust: self.target_type(t).as_str(),
    // rust: "minecraft:fireball"
    // rust: | "minecraft:wind_charge"
    // rust: | "minecraft:breeze_wind_charge"
    // rust: | "minecraft:shulker_bullet"
    // rust: ),
            // LivingEntity: not removed. ArmorStand: not a marker.
    // rust: Some(Target::Mob(_)) => self.camera_state(host, id).is_some(),
    // rust: Some(Target::Stand(s)) => self.armor_stands.iter().any(|a| a.id == s && !a.marker),
            // BlockAttachedEntity, minecarts, boats, end crystals.
    // rust: Some(Target::Frame(_) | Target::Painting(_) | Target::Boat(_) | Target::Cart(_))
    // rust: | Some(Target::Crystal(_)) => true,
            // Interaction.
    // rust: Some(t @ Target::Other(_)) => self.target_type(t) == "minecraft:interaction",
    // rust: _ => false,
}
}

    // `ServerGamePacketListenerImpl.handleSpectatorAction`.
    // rust: pub(super) fn guest_spectator_action(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: gi: usize,
    // rust: target: Option<i32>,
    // rust: ) {
    // rust: let g = &host.hub.guests[gi];
    // rust: if !g.loaded || !g.spectator() {
    // rust: return;
}
    // rust: let conn = g.conn;
    // rust: let Some(id) = target else {
    // rust: return;
}
    // rust: let Some(bounds) = self
    // rust: .guest_target_box(host, gi, id)
    // rust: .or_else(|| self.camera_extra(id).map(|e| e.bounds))
    // rust: else {
    // rust: return;
}
    // rust: let Some((at, _)) = self.camera_state(host, id) else {
    // rust: return;
}
    // rust: let block = at.map(|v| v.floor() as i32);
    // rust: if !self
    // rust: .border
    // rust: .contains(f64::from(block[0]), f64::from(block[2]))
    // rust: {
    // rust: return;
}
    // rust: if self.as_guest(host, conn, |g| {
    // rust: g.within_entity_interaction_range(&bounds, 3.0)
    // rust: }) != Some(true)
    // rust: {
    // rust: return;
}
    // rust: if self.camera_pickable(host, id) {
    // rust: self.guest_set_camera(host, gi, Some(id));
}
}

    // `ServerPlayer.setCamera`: the view moves to the new camera, which
    // the client is told, or back to the player (`None`).
    // rust: pub(super) fn guest_set_camera(&mut self, host: &mut LanHost, gi: usize, camera: Option<i32>) {
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (conn, own, uuid, name) = (guest.conn, guest.entity_id, guest.uuid, guest.name.clone());
    // rust: let previous = self.cmds.guest_cameras.get(&conn).map(|c| c.id);
    // rust: let camera = camera.filter(|id| *id != own);
    // rust: if self.cmds.guest_cameras.get(&conn).map(|c| c.id) == camera {
    // rust: return;
}
    // rust: let at = match camera {
    // rust: Some(id) => self.camera_state(host, id).map(|s| s.0),
    // rust: None => Some(host.hub.guests[gi].position),
}
    // rust: match camera {
    // rust: Some(id) => {
    // rust: self.cmds
    // rust: .guest_cameras
    // rust: .insert(conn, GuestCamera { id, teleports: 0 });
}
    // rust: None => {
    // rust: self.cmds.guest_cameras.remove(&conn);
}
}
        // ServerPlayer.broadcastToPlayer: a spectator with a camera is shown to nobody.
    // rust: host.hub.guests[gi].watching = camera.is_some();
        // teleportTo(level, camera.x, y, z): same look.
    // rust: host.hub.teleport(gi, at);
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SetCamera(play::SetCamera {
    // rust: camera_id: camera.unwrap_or(own),
    // rust: }),
    // rust: );
    // rust: let teleports = host.hub.guests[gi].teleport_counter;
    // rust: if let Some(c) = self.cmds.guest_cameras.get_mut(&conn) {
    // rust: c.teleports = teleports;
}
    // rust: if camera.is_none()
    // rust: && let Some(entity_id) = previous
    // rust: {
    // rust: self.native_player_stop_spectating_entity(uuid, &name, entity_id);
}
}

    // The camera part of `ServerPlayer.tick` for every guest, after the
    // `/spectate` requests commands queued.
    // rust: pub(super) fn tick_guest_cameras(&mut self, host: &mut LanHost) {
    // rust: for (conn, id) in std::mem::take(&mut self.cmds.camera_requests) {
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) {
    // rust: self.guest_set_camera(host, gi, id);
}
}
    // rust: let cameras: Vec<(u32, GuestCamera)> = self
    // rust: .cmds
    // rust: .guest_cameras
    // rust: .iter()
    // rust: .map(|(c, v)| (*c, *v))
    // rust: .collect();
    // rust: for (conn, camera) in cameras {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: self.cmds.guest_cameras.remove(&conn);
    // rust: continue;
}
    // rust: let g = &host.hub.guests[gi];
    // rust: let state = self.camera_state(host, camera.id);
    // rust: if camera_ends(
    // rust: state.is_some(),
    // rust: g.sneaking,
    // rust: g.spectator(),
    // rust: g.teleport_counter != camera.teleports,
    // rust: ) {
    // rust: self.guest_set_camera(host, gi, None);
    // rust: } else if let Some((at, [yaw, pitch])) = state {
                // absSnapTo; the level's chunk source follows the player.
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.position = at;
    // rust: (g.yaw, g.pitch) = (yaw, pitch);
}
}
}
}

    // rust: mod tests {
//     use super::camera_ends;

    // A living camera is followed until the player sneaks, leaves
    // spectator mode or is teleported; a dead one ends it at once.
camera_ends_like_server_player_tick :: proc() {
}
    // rust: assert!(!camera_ends(true, false, true, false));
    // rust: assert!(camera_ends(false, false, true, false));
    // rust: assert!(camera_ends(true, true, true, false));
    // rust: assert!(camera_ends(true, false, false, false));
    // rust: assert!(camera_ends(true, false, true, true));
}
}
