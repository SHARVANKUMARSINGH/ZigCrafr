//! Transpiled from Horizon Rust crate
package horizon_client_lan_mobs

import "core:fmt"
import "core:mem"
import "core:math"

// Mobs and the guests of an open world. The mob code sees one player
// (`MobWorld.player`, `Who::Player`); with guests on, each mob sees the
// player vanilla's `Level.getNearestPlayer` would give it, and keeps the
// guest it targets until it lets go. What it then does to `Who::Player`
// (hits, pushes, fire, its projectiles) runs with that guest swapped in.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: mobs::{Mob, MobEvent, PlayerView, Species, Who},
    // rust: projectiles::{Hit, Projectile},
}
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_protocol::packets::play::{self, Clientbound as C};

// The guests mobs can see this tick, by connection.
    // rust: pub(super) type GuestViews = Vec<(u32, PlayerView)>;

// The player a mob sees this tick: `None` for the host, else a guest.
// A mob that targets a guest, or that a guest hurt in the last 100 ticks
// (`LivingEntity.getLastHurtByMob`), keeps them while they are still a
// valid target; otherwise it sees the nearest player
// (`TargetingConditions`: alive, neither creative nor spectator), or the
// nearest one that is not a spectator if none qualifies.
    // rust: pub(super) fn player_for(
    // rust: m: &Mob,
    // rust: host: Option<&PlayerView>,
    // rust: guests: &GuestViews,
    // rust: bound: Option<u32>,
    // rust: ) -> Option<u32> {
    // A tame cat reads its owner wherever they are while they sleep, or just
    // woke up (`CatRelaxOnOwnerGoal` uses `getOwner`, not the nearest player).
    // rust: if m.species() == Species::Cat
    // rust: && m.extra.tame
    // rust: && let Some(owner) = m.extra.owner
    // rust: {
    // rust: let asleep = |v: &PlayerView| v.uuid == owner && (v.sleeping || v.sleep_timer > 0);
    // rust: if host.is_some_and(asleep) {
    // rust: return None;
}
    // rust: if let Some((conn, _)) = guests.iter().find(|(_, v)| asleep(v)) {
    // rust: return Some(*conn);
}
}
    // An iron golem's anger is for the player who hit it (`NeutralMob` keeps
    // the angry-at UUID), and outlasts the 100 ticks of `getLastHurtByMob`:
    // while it lasts, the golem keeps that player, not whoever is nearest.
    // rust: let angry = m.species() == Species::IronGolem && m.extra.anger > 0;
    // rust: let targeting = m.ai.target == Some(Who::Player)
    // rust: || angry
    // rust: || m.ai.last_hurt_by == Some(Who::Player) && m.age as i32 - m.ai.last_hurt_by_time <= 100;
    // A tame wolf, cat or parrot sees its owner (`TamableAnimal.getOwner`), while they
    // are in play, whoever is nearer. Not while it targets or was just hurt by
    // a player: then `Who::Player` is that attacker, whoever it is, and the
    // owner goals ignore it until the wolf lets go.
    // rust: if !targeting
    // rust: && matches!(m.species(), Species::Wolf | Species::Cat | Species::Parrot)
    // rust: && m.extra.tame
    // rust: && let Some(owner) = m.extra.owner
    // rust: {
    // rust: if host.is_some_and(|v| v.alive && v.uuid == owner) {
    // rust: return None;
}
    // rust: if let Some((conn, _)) = guests.iter().find(|(_, v)| v.alive && v.uuid == owner) {
    // rust: return Some(*conn);
}
}
    // A mob on a player's lead follows and measures its rope against the
    // player who holds it, not whoever is nearest or in survival mode.
    // rust: if m.extra.leash == Some(horizon_client::mobs::leash::Holder::Player)
    // rust: && let Some(holder) = m.extra.leash_player
    // rust: {
    // rust: if host.is_some_and(|v| v.uuid == holder) {
    // rust: return None;
}
    // rust: if let Some((conn, _)) = guests.iter().find(|(_, v)| v.uuid == holder) {
    // rust: return Some(*conn);
}
}
    // rust: choose(m.position, targeting, host, guests, bound)
}

    // rust: fn choose(
    // rust: at: Vec3,
    // rust: targeting: bool,
    // rust: host: Option<&PlayerView>,
    // rust: guests: &GuestViews,
    // rust: bound: Option<u32>,
    // rust: ) -> Option<u32> {
    // rust: let targetable = |v: &PlayerView| v.alive && !v.creative && !v.spectator;
    // rust: if targeting
    // rust: && let Some(conn) = bound
    // rust: && guests.iter().any(|(c, v)| *c == conn && targetable(v))
    // rust: {
    // rust: return Some(conn);
}
    // rust: let d = |v: &PlayerView| at.distance_squared(v.position);
    // rust: let nearest = |ok: &dyn Fn(&PlayerView) -> bool| {
    // rust: let mut best = host.filter(|v| ok(v)).map(|v| (None, d(v)));
    // rust: for (conn, v) in guests.iter().filter(|(_, v)| ok(v)) {
    // rust: if best.is_none_or(|(_, b)| d(v) < b) {
    // rust: best = Some((Some(*conn), d(v)));
}
}
    // rust: best
}
    // rust: nearest(&targetable)
    // rust: .or_else(|| nearest(&|v: &PlayerView| v.alive && !v.spectator))
    // rust: .and_then(|(conn, _)| conn)
}

// The events of a mob's tick that act on the player it sees.
    // rust: pub(super) fn acts_on_player(e: &MobEvent) -> bool {
    // rust: matches!(
    // rust: e,
    // rust: MobEvent::AttackPlayer(..)
    // rust: | MobEvent::CubeHurtPlayer { .. }
    // rust: | MobEvent::AttackPlayerWithEffect { .. }
    // rust: | MobEvent::StingPlayer { .. }
    // rust: | MobEvent::DamagePlayer { .. }
    // rust: | MobEvent::SonicBoom {
    // rust: target: Who::Player,
    // rust: ..
}
    // rust: | MobEvent::Push {
    // rust: target: Who::Player,
    // rust: ..
}
    // rust: | MobEvent::Knockback {
    // rust: target: Who::Player,
    // rust: ..
}
    // rust: | MobEvent::StabDismount {
    // rust: target: Who::Player,
}
    // rust: | MobEvent::Ignite {
    // rust: target: Who::Player,
    // rust: ..
}
    // rust: | MobEvent::Launch {
    // rust: target: Who::Player,
    // rust: ..
}
    // rust: | MobEvent::EffectPlayer { .. }
    // rust: | MobEvent::AxolotlSupportPlayer { .. }
    // rust: | MobEvent::ParrotToShoulder { .. }
    // rust: )
}

// A guest's `player_view`, taken with their state swapped in, as the mobs see
// them. Their last attacker and last victim stay: a tamed wolf defends and
// helps whoever owns it (`OwnerHurtByTargetGoal`, `OwnerHurtTargetGoal`), and
// the window's own player is a guest of its server thread.
guest_view :: proc(mut v: PlayerView, uuid: u128, moved: [f64; 3]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: v.hero = false;
    // rust: v.velocity = Vec3::new(moved[0], moved[1], moved[2]);
    // rust: v.uuid = horizon_client::lan::playerdata::uuid_ints(uuid);
    // rust: v.allies = Default::default();
    // rust: v.remote = true;
    // rust: v
}

    // rust: impl Game<'_> {
    // How mobs see each guest in play (`player_view` with the guest swapped
    // in).
    // rust: pub(super) fn lan_guest_views(&mut self) -> GuestViews {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return Vec::new();
}
    // rust: let conns: Vec<(u32, u128, [f64; 3])> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead)
    // rust: .map(|g| {
    // rust: let moved = [0, 1, 2].map(|k| g.position[k] - g.previous_position[k]);
    // rust: (g.conn, g.uuid, moved)
    // rust: })
    // rust: .collect();
    // rust: let mut views = Vec::new();
    // rust: for (conn, uuid, moved) in conns {
    // rust: if let Some(Some(v)) = self.as_guest(&mut host, conn, |g| g.player_view()) {
    // rust: views.push((conn, guest_view(v, uuid, moved)));
}
}
    // rust: self.lan = Some(host);
    // rust: views
}

    // Runs `f` as each guest in play here, for what strikes every player in
    // an area (`Level.getEntities`), not only the window's own.
    // rust: pub(super) fn each_guest_hit(&mut self, f: impl FnMut(&mut Self)) {
    // rust: self.each_guest_hit_except(None, f);
}

    // [`Self::each_guest_hit`] leaving out the guest `except` (the one a
    // firework rocket is attached to, which it hurts on its own).
    // rust: pub(super) fn each_guest_hit_except(
    // rust: &mut self,
    // rust: except: Option<u32>,
    // rust: mut f: impl FnMut(&mut Self),
    // rust: ) {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: let conns: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead && Some(g.conn) != except)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: self.guest_hit_by(&mut host, conn, &mut f);
}
    // rust: self.lan = Some(host);
}

    // Mob events aimed at a guest, run as that guest (`guest_hit_by`).
    // rust: pub(super) fn lan_guest_mob_events(&mut self, events: Vec<(u32, MobEvent)>) {
    // rust: if events.is_empty() {
    // rust: return;
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: for (conn, e) in events {
    // rust: self.guest_hit_by(&mut host, conn, |g| {
    // rust: let _ = g.handle_mob_events(vec![e]);
    // rust: });
}
    // rust: self.lan = Some(host);
}

    // The guests' boxes for the blocks entities trigger (pressure plates,
    // tripwires, detector rails): `Entity.checkInsideBlocks` and
    // `Level.getEntities` see every player in the level, but not spectators
    // (`Entity.isIgnoringBlockTriggers`).
    // rust: pub(super) fn lan_block_trigger_boxes(&self) -> Vec<([f64; 3], [f64; 3])> {
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return Vec::new();
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead && !g.spectator())
    // rust: .map(|g| {
    // rust: let b = g.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z])
    // rust: })
    // rust: .collect()
}
    // The same guests' cast fishing hooks, for `GameLevel::trigger_projectiles`.
    // rust: pub(super) fn lan_hook_triggers(&self, out: &mut Vec<(Aabb, bool)>) {
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return;
}
    // rust: out.extend(
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead && !g.spectator())
    // rust: .filter_map(|g| host.play.get(&g.conn)?.hook.as_ref())
    // rust: .map(|hook| (hook.bounds(), hook.applies_block_effects())),
    // rust: );
}
    // The same guests' feet and whether they stand on the ground, for the
    // blocks that also ask that (`BigDripleafBlock.canEntityTilt`).
    // rust: pub(super) fn lan_guest_feet(&self) -> Vec<([f64; 3], bool)> {
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return Vec::new();
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead && !g.spectator())
    // rust: .map(|g| (g.position, g.on_ground))
    // rust: .collect()
}

    // The guests a projectile can hit, under their entity ids.
    // rust: pub(super) fn lan_projectile_targets(&self) -> Vec<(Who, Aabb)> {
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return Vec::new();
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead && !g.spectator())
    // rust: .map(|g| (Who::Mob(g.entity_id as u32), guest_bounds(g)))
    // rust: .collect()
}

    // A projectile that hit a guest: its hit runs as theirs. False when
    // `id` is not a guest.
    // rust: pub(super) fn lan_projectile_hit(&mut self, p: &Projectile, id: u32, at: Vec3) -> bool {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return false;
}
    // rust: let conn = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id)
    // rust: .map(|g| g.conn);
    // rust: if let Some(conn) = conn {
    // rust: self.guest_hit_by(&mut host, conn, |g| {
    // rust: let hit = Hit::Entity {
    // rust: who: Who::Player,
    // rust: at,
}
    // rust: let _ = g.projectile_hit(p, hit);
    // rust: });
}
    // rust: self.lan = Some(host);
    // rust: conn.is_some()
}
}

    // rust: impl Game<'_> {
    // Hurt a guest: `f` runs as them, and the knockback it gave reaches
    // their client. A hurt marks the velocity (Entity.markHurt), which goes
    // out once the guest's server copy has travelled (`guest_server_tick`);
    // a push with no hurt goes out at once.
    // rust: pub(super) fn guest_hit_by<R>(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: f: impl FnOnce(&mut Self) -> R,
    // rust: ) -> Option<R> {
    // rust: let (result, pushed) = self.as_guest(host, conn, |g| {
    // rust: let before = g.player.as_ref().map(|p| p.velocity);
    // rust: let result = f(g);
    // rust: let pushed = g
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| !p.health.sync_velocity && Some(p.velocity) != before)
    // rust: .map(|p| p.velocity);
    // rust: (result, pushed)
    // rust: })?;
    // rust: self.send_guest_motion(host, conn, pushed);
    // rust: Some(result)
}

    // A player's melee hit on a guest (Player.causeExtraKnockback on a
    // ServerPlayer): a hurt that marked the velocity sends it at once, and
    // the server's copy goes back to the velocity it had before the hit.
    // rust: pub(super) fn guest_struck_by<R>(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: f: impl FnOnce(&mut Self) -> R,
    // rust: ) -> Option<R> {
    // rust: let (result, sent) = self.as_guest(host, conn, |g| {
    // rust: let before = g.player.as_ref().map(|p| p.velocity);
    // rust: let result = f(g);
    // rust: let sent = g.player.as_mut().zip(before).and_then(|(p, before)| {
    // rust: std::mem::take(&mut p.health.sync_velocity)
    // rust: .then(|| std::mem::replace(&mut p.velocity, before))
    // rust: });
    // rust: (result, sent)
    // rust: })?;
    // rust: self.send_guest_motion(host, conn, sent);
    // rust: Some(result)
}

    // ClientboundSetEntityMotionPacket to a guest about themselves.
    // rust: pub(super) fn send_guest_motion(&self, host: &LanHost, conn: u32, velocity: Option<Vec3>) {
    // rust: if let (Some(v), Some(g)) = (velocity, host.hub.guest(conn)) {
    // rust: g.send(&C::SetEntityMotion(play::SetEntityMotion {
    // rust: id: g.entity_id,
    // rust: velocity: [v.x, v.y, v.z],
    // rust: }));
}
}
}

// A guest as the blocks that look for players see them
// (`PlayerDetector`, `level.getPlayers`: the dead ones too).
    // rust: pub(super) struct Present {
    // rust: pub uuid: [i32; 4],
    // rust: pub position: [f64; 3],
    // rust: pub eye: [f64; 3],
    // rust: pub height: f32,
    // rust: pub creative: bool,
    // rust: pub spectator: bool,
    // rust: pub alive: bool,
    // Trial Omen, else Bad Omen, among the guest's effects.
    // rust: pub omen: Option<horizon_client::mobs::trial_spawner::Omen>,
}

    // rust: impl Game<'_> {
    // Every guest in the world (`ServerLevel.getPlayers` past the host).
    // rust: pub(super) fn lan_present(&self) -> Vec<Present> {
    // rust: let guests = self
    // rust: .lan
    // rust: .iter()
    // rust: .flat_map(|h| h.hub.guests.iter().filter(|g| h.hub.here(g)));
    // rust: guests
    // rust: .filter(|g| g.loaded)
    // rust: .map(|g| {
    // rust: let [x, y, z] = g.position;
                // The acting guest's effects are on the game while their turn runs.
    // rust: let effects = if self.lan_acting == Some(g.conn) {
    // rust: &self.potions.effects
    // rust: } else {
    // rust: &g.effects
}
    // rust: Present {
    // rust: uuid: horizon_client::lan::playerdata::uuid_ints(g.uuid),
    // rust: position: g.position,
    // rust: eye: [x, y + g.eye_height(), z],
    // rust: height: g.dimensions().height,
    // rust: creative: g.creative(),
    // rust: spectator: g.spectator(),
    // rust: alive: !g.dead,
    // rust: omen: omen_of(effects),
}
    // rust: })
    // rust: .collect()
}
    // The UUID of the player acting: the guest `as_guest` runs, else the host.
    // rust: pub(super) fn acting_uuid(&self) -> [i32; 4] {
    // rust: self.lan_acting_uuid
    // rust: .map(horizon_client::lan::playerdata::uuid_ints)
    // rust: .or(self.level.player_uuid)
    // rust: .unwrap_or_default()
}
}

// `TrialSpawner.findPlayerWithOminousEffect`: Trial Omen first, then Bad Omen.
    // rust: pub(super) fn omen_of(
    // rust: effects: &horizon_client::effects::PlayerEffects,
    // rust: ) -> Option<horizon_client::mobs::trial_spawner::Omen> {
//     use horizon_client::mobs::trial_spawner::Omen;
    // rust: if effects.get("trial_omen").is_some() {
    // rust: Some(Omen::Trial)
    // rust: } else {
    // rust: effects.get("bad_omen").map(|_| Omen::Bad)
}
}

// A guest's bounding box, by its pose (`Avatar.POSES`).
    // rust: pub(super) fn guest_bounds(g: &horizon_client::lan::guest::Guest) -> Aabb {
    // rust: g.bounds()
}

    // rust: mod tests {
//     use super::*;

a_guests_view_keeps_who_hurt_them_and_who_they_hurt :: proc() {
}
    // rust: let mut v = view(0.0, false);
    // rust: v.hurt_by = Some((Who::Mob(7), 90));
    // rust: v.last_hurt = Some((Who::Mob(8), 95));
    // rust: let seen = guest_view(v, 5, [1.0, 0.0, 0.0]);
    // rust: assert_eq!(seen.hurt_by, Some((Who::Mob(7), 90)));
    // rust: assert_eq!(seen.last_hurt, Some((Who::Mob(8), 95)));
    // rust: assert!(seen.remote);
    // rust: assert_eq!(seen.velocity, Vec3::new(1.0, 0.0, 0.0));
}

view :: proc(x: f64, creative: bool) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PlayerView {
    // rust: position: Vec3::new(x, 64.0, 0.0),
    // rust: bounds: Aabb::new(Vec3::new(x, 64.0, 0.0), Vec3::new(x, 65.8, 0.0)),
    // rust: eye: [x, 65.62, 0.0],
    // rust: alive: true,
    // rust: creative,
    // rust: sneaking: false,
    // rust: swimming: false,
    // rust: look: [0.0; 3],
    // rust: main_hand: None,
    // rust: off_hand: None,
    // rust: head: None,
    // rust: chest: None,
    // rust: legs: None,
    // rust: feet: None,
    // rust: armor_cover: 0.0,
    // rust: invisible: false,
    // rust: spectator: false,
    // rust: gold_armor: false,
    // rust: hurt_by: None,
    // rust: last_hurt: None,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: sprinting: false,
    // rust: riding: false,
    // rust: hero: false,
    // rust: effects: Vec::new(),
    // rust: uuid: [0; 4],
    // rust: allies: Default::default(),
    // rust: remote: false,
    // rust: sleeping: false,
    // rust: sleep_timer: 0,
    // rust: passenger: false,
    // rust: riding_vehicle: None,
    // rust: vehicle: None,
}
}

MOB :: Vec3::new(0.0, 64.0, 0.0)

the_nearest_survival_player_is_seen :: proc() {
}
    // rust: let host = view(10.0, false);
    // rust: let guests = vec![(7, view(3.0, false)), (8, view(-5.0, false))];
    // rust: assert_eq!(choose(MOB, false, Some(&host), &guests, None), Some(7));
        // A creative guest is passed over for the host further away.
    // rust: let guests = vec![(7, view(3.0, true))];
    // rust: assert_eq!(choose(MOB, false, Some(&host), &guests, None), None);
        // Nobody targetable: the nearest one is still seen.
    // rust: let host = view(10.0, true);
    // rust: assert_eq!(choose(MOB, false, Some(&host), &guests, None), Some(7));
    // rust: assert_eq!(choose(MOB, false, None, &Vec::new(), None), None);
}

a_targeted_guest_stays_the_target :: proc() {
}
    // rust: let host = view(1.0, false);
    // rust: let guests = vec![(7, view(12.0, false))];
    // rust: assert_eq!(choose(MOB, true, Some(&host), &guests, Some(7)), Some(7));
        // Gone creative: the mob looks again.
    // rust: let guests = vec![(7, view(12.0, true))];
    // rust: assert_eq!(choose(MOB, true, Some(&host), &guests, Some(7)), None);
        // Without a target the nearest player wins.
    // rust: let guests = vec![(7, view(12.0, false))];
    // rust: assert_eq!(choose(MOB, false, Some(&host), &guests, Some(7)), None);
}

a_leashed_mob_sees_its_holder_even_when_another_player_is_closer :: proc() {
}
    // rust: let Some(mut cow) = mob_of("minecraft:cow") else {
    // rust: return;
}
    // rust: let mut holder = view(10.0, true);
    // rust: holder.uuid = [1, 2, 3, 4];
    // rust: let mut nearby = view(1.0, false);
    // rust: nearby.uuid = [5, 6, 7, 8];
    // rust: cow.extra.leash = Some(horizon_client::mobs::leash::Holder::Player);
    // rust: cow.extra.leash_player = Some(holder.uuid);
    // rust: let guests = vec![(7, holder.clone()), (8, nearby.clone())];
    // rust: assert_eq!(player_for(&cow, None, &guests, None), Some(7));
    // rust: assert_eq!(
    // rust: player_for(&cow, Some(&holder), &vec![(8, nearby)], None),
    // rust: None
    // rust: );
}

    // The mob of the prepared resources' type `kind` (None without them).
mob_of :: proc(kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let types = horizon_client::mobs::MobTypes::load(&root).ok()?;
    // rust: let t = std::sync::Arc::new(types.types.get(kind)?.clone());
    // rust: Some(Mob::new(1, t, MOB, 0.0))
}

    // #6781: a golem a guest hit stays angry for 400+ ticks but remembers
    // its last attacker for 100. After that it must still see the guest it
    // is angry at, not the bystander standing nearer.
an_angry_golem_keeps_the_player_who_hit_it :: proc() {
}
    // rust: let Some(mut golem) = mob_of("minecraft:iron_golem") else {
    // rust: return;
}
    // rust: golem.age = 500;
    // rust: golem.ai.last_hurt_by = Some(Who::Player);
    // rust: golem.ai.last_hurt_by_time = 100;
    // rust: golem.ai.target = None;
    // rust: golem.extra.anger = 300;
        // The attacker (conn 7) ran off; a bystander (conn 8) is nearer.
    // rust: let guests = vec![(7, view(30.0, false)), (8, view(3.0, false))];
    // rust: assert_eq!(player_for(&golem, None, &guests, Some(7)), Some(7));
        // Calm again: the nearest player is seen.
    // rust: golem.extra.anger = 0;
    // rust: assert_eq!(player_for(&golem, None, &guests, Some(7)), Some(8));
}
}
