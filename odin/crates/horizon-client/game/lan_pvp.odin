//! Transpiled from Horizon Rust crate
package horizon_client_lan_pvp

import "core:fmt"
import "core:mem"
import "core:math"

// Players hitting players on a server (`Player.attack` on a player). The hit
// is worked out as the attacker (weapon, attack strength, critical hit,
// enchantments, a mace's smash) and lands on the victim like any player
// attack (blocking, armour, knockback), when the `pvp` game rule allows it
// (`ServerPlayer.canHarmPlayer`, `isPvpAllowed`). A player's arrow on
// another player lands the same way.
// use super::{Game, lan::LanHost, lan_mobs::guest_bounds, mace::Spared};
// use horizon_client::enchant::EffectContext;

// use horizon_client::{
    // rust: Result,
    // rust: health::HurtSource,
    // rust: mobs::Who,
    // rust: projectiles::{Hit, Projectile, ProjectileKind},
    // rust: text::Text,
}
// use horizon_core::geometry::{Aabb, Vec3};

// The player projectiles that meet other players: arrows (their hurt), and
// snowballs, eggs and mods' thrown types, which break on them
// (`Player.hurtServer` takes no 0 damage). Pearls, potions and wind charges
// fly past players as before.
    // rust: pub(super) fn meets_players(kind: &ProjectileKind) -> bool {
    // rust: matches!(
    // rust: kind,
    // rust: ProjectileKind::Arrow { .. }
    // rust: | ProjectileKind::Snowball
    // rust: | ProjectileKind::Egg
    // rust: | ProjectileKind::Thrown(_)
    // rust: )
}

// Who a player's attack lands on: a player by connection.
    // rust: pub(super) enum Victim {
    // rust: Guest(u32),
}

    // rust: impl Victim {
conn :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Victim::Guest(conn) = self;
    // rust: Some(conn)
}
}

// The attacker's side of the hit.
    // rust: pub(super) struct Strike {
    // The attacking guest, kept after their turn through `as_guest` ends.
    // rust: attacker: Option<u32>,
    // rust: amount: f32,
    // rust: scale: f32,
    // rust: crit: bool,
    // `Player.attack`'s `magicBoost > 0`: the enchantments added damage.
    // rust: magic: bool,
    // rust: from: [f64; 3],
    // `getSecondsToDisableBlocking` of the attacker's weapon.
    // rust: disable_blocking: f32,
    // rust: sweep: Option<[f64; 3]>,
    // `causeExtraKnockback`: its strength and direction (the attacker's
    // yaw), and whether the hit is a sprinting knockback attack.
    // rust: knockback: (f32, f64, f64),
    // rust: knockback_attack: bool,
    // The attacker's team, for the victim's `Player.canHarmPlayer`.
    // rust: team: Option<horizon_client::scoreboard::Team>,
    // The attacker's main-hand item with a custom name, for the death
    // message's `.item` form.
    // rust: item: Option<horizon_client::text::Text>,
    // The weapon's `minecraft:ignite` (Fire Aspect) on the victim, in
    // seconds (`EnchantmentHelper.doPostAttackEffects`).
    // rust: ignite: f32,
}

// A player's blow on another player as the native hooks name it: the hit's
// own push and its damage name no attacker yet, so the extra and the sweep's
// pushes don't either.
    // rust: const PVP_SOURCE: HurtSource<'static> = HurtSource {
    // rust: damage_type: "minecraft:player_attack",
    // rust: causing: 0,
    // rust: direct: 0,
}

// A sweep attack's reach to the other players (`Player.doSweepAttack`),
// worked out as the attacker.
    // rust: pub(super) struct Sweep {
    // The attacking guest (none: the host).
    // rust: attacker: Option<u32>,
    // rust: from: [f64; 3],
    // The damage after the enchantments and the attack strength.
    // rust: damage: f32,
    // The push along the attacker's yaw.
    // rust: knockback: (f64, f64),
    // rust: team: Option<horizon_client::scoreboard::Team>,
    // The target's box grown by (1, 0.25, 1).
    // rust: pub(super) hit_box: Aabb,
    // The entity id of the player the sweep started from, which it spares.
    // rust: pub(super) skip: Option<i32>,
    // The weapon's `minecraft:ignite` (Fire Aspect) on each swept player, in
    // seconds (`doPostAttackEffects` after a sweep hit lands).
    // rust: ignite: f32,
}

    // rust: impl Strike {
    // Whether it has extra knockback, which stops the attacker's sprint
    // once it lands (Player.causeExtraKnockback).
    // rust: pub(super) fn stops_sprint(&self) -> bool {
    // rust: self.knockback.0 > 0.0
}
}

    // rust: impl Game<'_> {
    // Whether the player a hit landed on stands on the ground.
    // rust: pub(super) fn pvp_victim_on_ground(host: &LanHost, victim: Victim) -> bool {
    // rust: match victim {
    // rust: Victim::Guest(conn) => host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| g.motion.as_deref())
    // rust: .is_some_and(|p| p.ground.on_ground),
}
}

    // The player `id` that guest `conn` attacks, if it is one.
    // rust: pub(super) fn pvp_victim(host: &LanHost, conn: u32, id: i32) -> Option<Victim> {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id == id && g.conn != conn && host.hub.here(g) && !g.dead)
    // rust: .map(|g| Victim::Guest(g.conn))
}

    // `Player.attack`'s `causeFoodExhaustion(0.1F)`, charged to the attacker
    // (the host, or a guest swapped in) only once the hit hurt the victim.
    // rust: pub(super) fn pvp_exhaustion(&mut self) {
    // rust: if let Some(p) = self.player.as_mut()
    // rust: && !self.creative
    // rust: {
    // rust: p.cause_food_exhaustion(0.1);
}
}

    // The attacker's side of `Player.attack` (the host, or a guest swapped
    // in): the damage, the charge reset and the swing.
    // rust: pub(super) fn pvp_strike(&mut self) -> Option<Strike> {
    // rust: let p = self.player.as_ref()?;
    // rust: let from = [p.position.x, p.position.y, p.position.z];
    // rust: let (amount, scale, crit, magic) = self.melee_damage("minecraft:player", true);
    // rust: let sweep = self.sweep_attack_position(scale, crit);
    // rust: let (strength, knockback_attack) = self.extra_knockback("minecraft:player", scale);
    // rust: let (xd, zd) = self.extra_knockback_direction();
    // rust: self.attack_ticks = 0;
    // rust: self.swing_arm();
        // LivingEntity.getSecondsToDisableBlocking: the held weapon's value,
        // none while another item is in use.
    // rust: let disable_blocking = if self.using.is_some() {
    // rust: 0.0
    // rust: } else {
    // rust: self.attack_item_info()
    // rust: .map_or(0.0, |i| i.disable_blocking_seconds)
}
    // rust: let ignite = self.weapon_ignite_seconds();
    // rust: Some(Strike {
    // rust: attacker: self.lan_acting,
    // rust: amount,
    // rust: scale,
    // rust: crit,
    // rust: magic,
    // rust: from,
    // rust: disable_blocking,
    // rust: sweep,
    // rust: knockback: (strength, xd, zd),
    // rust: knockback_attack,
    // rust: team: self.player_team().cloned(),
    // rust: item: self.main_hand_custom_name(),
    // rust: ignite,
    // rust: })
}

    // The held weapon's `minecraft:ignite` (Fire Aspect) seconds on a player
    // victim (`EnchantmentHelper.doPostAttackEffects`).
weapon_ignite_seconds :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let Some(held) = self.held().cloned() else {
    // rust: return 0.0;
}
    // rust: let ctx = EffectContext {
    // rust: this: Some("minecraft:player"),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let mut random = self.world.random.clone();
    // rust: world_stations!(self)
    // rust: .enchantments
    // rust: .ignite_seconds(held.enchantments(), &ctx, &mut random)
}

    // The guests by connection, with their entity ids.
    // rust: pub(super) fn lan_guest_entities(&self) -> Vec<(u32, u32)> {
    // rust: self.lan.as_ref().map_or_else(Vec::new, |host| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .map(|g| (g.conn, g.entity_id as u32))
    // rust: .collect()
    // rust: })
}

    // The player a player's projectile hit, when it hit one.
    // rust: pub(super) fn projectile_pvp_victim(&self, p: &Projectile, hit: Hit) -> Option<Victim> {
    // rust: if p.owner != Some(Who::Player) || !meets_players(&p.kind) {
    // rust: return None;
}
    // rust: let Hit::Entity { who, .. } = hit else {
    // rust: return None;
}
    // rust: match who {
    // rust: Who::Player => None,
    // rust: Who::Mob(id) => self
    // rust: .lan
    // rust: .as_ref()?
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id)
    // rust: .map(|g| Victim::Guest(g.conn)),
}
}

    // A player's projectile on a player: the hit runs as the victim, whose
    // hurt refuses it when the `pvp` game rule or their teams forbid it
    // (`ServerPlayer.canHarmPlayer`; `AbstractArrow.onHitEntity` then turns
    // the arrow back).
    // rust: pub(super) fn projectile_hits_player(
    // rust: &mut self,
    // rust: p: &Projectile,
    // rust: hit: Hit,
    // rust: victim: Victim,
    // rust: ) -> Result<()> {
    // rust: let Hit::Entity { at, .. } = hit else {
    // rust: return Ok(());
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return self.projectile_hit(p, hit);
}
    // rust: let team_of = |game: &Self, name: &str| game.score.board.players_team(name).cloned();
    // rust: let attacker = match p.guest {
    // rust: Some(conn) => host.hub.guest(conn).and_then(|g| team_of(self, &g.name)),
    // rust: None => self.player_team().cloned(),
}
    // rust: let target = match victim {
    // rust: Victim::Guest(conn) => host.hub.guest(conn).and_then(|g| team_of(self, &g.name)),
}
    // rust: let refused = !(self.ui.rules.bool("pvp")
    // rust: && horizon_client::scoreboard::teams_allow_damage(target.as_ref(), attacker.as_ref()));
    // rust: let on_player = Hit::Entity {
    // rust: who: Who::Player,
    // rust: at,
}
    // rust: let shooter = self.player_attacker(&host, p.guest);
    // rust: let result = match victim {
    // rust: Victim::Guest(conn) => self.guest_hit_by(&mut host, conn, |g| {
    // rust: g.combat.refuse_player_hit = refused;
    // rust: g.combat.projectile_attacker = shooter;
    // rust: let r = g.projectile_hit(p, on_player);
    // rust: g.combat.refuse_player_hit = false;
    // rust: g.combat.projectile_attacker = None;
    // rust: r
    // rust: }),
}
    // rust: self.lan = Some(host);
    // rust: result.unwrap_or(Ok(()))
}

    // rust: pub(super) fn player_attacker(&self, host: &LanHost, conn: Option<u32>) -> Option<(u32, Text)> {
    // rust: match conn {
    // rust: Some(conn) => {
    // rust: let g = host.hub.guest(conn)?;
    // rust: Some((g.entity_id as u32, self.player_text(&g.name, g.uuid)))
}
    // rust: None => None,
}
}

    // The hit landing on the victim with its extra knockback, then the
    // attacker's attack sound. Whether the victim was hurt.
    // rust: pub(super) fn pvp_land(&mut self, host: &mut LanHost, victim: Victim, s: &Strike) -> bool {
        // ServerPlayer.canHarmPlayer: the pvp game rule, then the victim's
        // team (Player.canHarmPlayer: allies only with friendly fire on).
    // rust: let team = match victim {
    // rust: Victim::Guest(conn) => host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| self.score.board.players_team(&g.name)),
}
    // rust: let harm = horizon_client::scoreboard::teams_allow_damage(team, s.team.as_ref());
    // rust: if s.knockback_attack {
    // rust: self.audio.play(
    // rust: "minecraft:entity.player.attack.knockback",
    // rust: Some(s.from),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
        // Player.attack: the hurt (with its knockback away from the
        // attacker), then causeExtraKnockback along the attacker's yaw.
        // CombatTracker: the attacking player is the death message's killer.
        // Without it the message is built with one argument and a template
        // that names a killer ("%1$s was slain by %2$s") shows as written.
    // rust: let attacker_note = s.attacker.and_then(|conn| {
    // rust: host.hub
    // rust: .guest(conn)
    // rust: .map(|a| (a.entity_id, self.player_text(&a.name, a.uuid)))
    // rust: });
    // rust: let attacker_id = self.player.as_ref().map_or(0, |p| p.entity_id);
    // rust: let land = |g: &mut Self| {
    // rust: let _attacker =
    // rust: g.knockback_scope(attacker_note.as_ref().map_or(attacker_id, |(id, _)| *id));
    // rust: g.combat.player_attacker = Some((s.from, s.disable_blocking));
    // rust: if let Some((id, name)) = attacker_note.clone() {
    // rust: g.note_player_attacker("minecraft:player_attack", id as u32, name, s.item.clone());
}
    // rust: let hurt = g.mob_hits_player(s.amount, s.from, "minecraft:player_attack");
    // rust: g.combat.player_attacker = None;
    // rust: let (strength, xd, zd) = s.knockback;
    // rust: if hurt && strength > 0.0 {
    // rust: if g.legacy_rules() {
    // rust: g.legacy_extra_knockback(f64::from(strength), (xd, zd));
    // rust: } else {
    // rust: g.knock_back_player(f64::from(strength), xd, zd, PVP_SOURCE);
}
}
            // Entity.igniteForSeconds on the victim: the fire timer only
            // rises, and a fire-immune victim (no player is by type) is spared.
    // rust: if hurt
    // rust: && s.ignite > 0.0
    // rust: && let Some(p) = g.player.as_mut()
    // rust: {
    // rust: let _ = p.ignite_for_ticks((s.ignite * 20.0) as i32);
}
            // The victim's thorns, dealt to the attacker below.
    // rust: let thorns = if hurt { g.thorns_damage() } else { Vec::new() };
    // rust: (hurt, thorns)
}
    // rust: let (hurt, thorns) = if self.ui.rules.bool("pvp") && harm {
    // rust: match victim {
    // rust: Victim::Guest(conn) => self.guest_struck_by(host, conn, land).unwrap_or_default(),
}
    // rust: } else {
    // rust: Default::default()
}
        // ServerPlayer.awardKillScore: the blow that kills a player.
    // rust: if hurt {
    // rust: let died = match victim {
                // A totem that fired is applied on the next tick_totem, so the
                // victim is still at zero health but is not dying.
    // rust: Victim::Guest(conn) => host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| g.motion.as_deref())
    // rust: .is_some_and(|p| p.health.dead_or_dying() && !p.health.totem_used),
}
    // rust: if died {
    // rust: match s.attacker {
    // rust: Some(conn) => {
    // rust: self.as_guest(host, conn, |g| g.award_custom_stat("player_kills", 1));
}
    // rust: None => self.award_custom_stat("player_kills", 1),
}
}
}
    // rust: if hurt && (s.crit || s.magic) {
    // rust: let target = match victim {
    // rust: Victim::Guest(conn) => host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| g.motion.as_deref().map(|p| (g.entity_id, p))),
}
    // rust: if let Some((id, p)) = target {
    // rust: let d = p.dimensions;
    // rust: let (feet, width, height) = (
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: f64::from(d.width),
    // rust: f64::from(d.height),
    // rust: );
    // rust: if s.crit {
    // rust: self.critical_hit(s.attacker, id, feet, width, height, false);
}
    // rust: if s.magic {
    // rust: self.critical_hit(s.attacker, id, feet, width, height, true);
}
}
}
    // rust: let thorns_cause = self.player_attacker(host, victim.conn());
    // rust: for damage in thorns {
    // rust: match s.attacker {
    // rust: None => {
    // rust: if let Some((id, name)) = &thorns_cause {
    // rust: self.note_named_attacker("minecraft:thorns", *id, name.clone());
}
    // rust: self.hurt_player_by("minecraft:thorns", damage);
}
    // rust: Some(conn) => {
    // rust: self.guest_hit_by(host, conn, |g| {
    // rust: if let Some((id, name)) = &thorns_cause {
    // rust: g.note_named_attacker("minecraft:thorns", *id, name.clone());
}
    // rust: g.hurt_player_by("minecraft:thorns", damage)
    // rust: });
}
}
}
    // rust: let sound = match (hurt, s.crit, s.scale > 0.9) {
    // rust: (false, ..) => "minecraft:entity.player.attack.nodamage",
    // rust: (true, true, _) => "minecraft:entity.player.attack.crit",
    // rust: (true, false, true) => "minecraft:entity.player.attack.strong",
    // rust: (true, false, false) => "minecraft:entity.player.attack.weak",
}
    // rust: if let Some(at) = s.sweep.filter(|_| hurt) {
            // The sweep around the player that was hit, as its attacker.
    // rust: let (area, id) = match victim {
    // rust: Victim::Guest(conn) => {
    // rust: let g = host.hub.guest(conn);
    // rust: (g.map(guest_bounds), g.map_or(-1, |g| g.entity_id))
}
}
    // rust: let target = area.map(|area| (area, Spared::Player(id)));
    // rust: match s.attacker {
    // rust: None => {
                    // The host is checked out here: collect the sweep for the players.
    // rust: self.combat.sweeps = Some(Vec::new());
    // rust: self.sweep_attack(at, Some(s.from), target, s.scale);
    // rust: for sweep in self.combat.sweeps.take().unwrap_or_default() {
    // rust: self.sweep_players(host, &sweep);
}
}
    // rust: Some(conn) => {
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.sweep_attack(at, Some(s.from), target, s.scale)
    // rust: });
}
}
    // rust: } else {
    // rust: self.audio.play(sound, Some(s.from), 1.0, 1.0);
}
    // rust: hurt
}

    // The sweep of the player in place, for the players it reaches: the
    // damage (`1 + ratio * baseDamage`, plus the enchantments against a
    // player, scaled by the attack strength) and who hits. The box is set
    // by the caller.
    // rust: pub(super) fn player_sweep(&mut self, base: f32, scale: f32) -> Sweep {
    // rust: let from = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or([0.0; 3], |p| [p.position.x, p.position.y, p.position.z]);
    // rust: let damage = self.enchanted_damage("minecraft:player", base) * scale;
    // rust: Sweep {
    // rust: attacker: self.lan_acting,
    // rust: from,
    // rust: damage,
    // rust: knockback: self.extra_knockback_direction(),
    // rust: team: self.player_team().cloned(),
    // rust: hit_box: Aabb::new(Vec3::ZERO, Vec3::ZERO),
    // rust: skip: None,
    // rust: ignite: self.weapon_ignite_seconds(),
}
}

    // A sweep from a mob hit reaches the other players. Inside a guest's
    // turn the host holds the other players (`as_guest`), so it waits for
    // the turn to end.
    // rust: pub(super) fn sweep_other_players(&mut self, sweep: Sweep) {
    // rust: if let Some(collect) = self.combat.sweeps.as_mut() {
    // rust: collect.push(sweep);
    // rust: } else if self.lan_acting.is_some() {
    // rust: self.creatures.sweeps.push(sweep);
    // rust: } else if let Some(mut host) = self.lan.take() {
    // rust: self.sweep_players(&mut host, &sweep);
    // rust: self.lan = Some(host);
}
}

    // The sweeps guests' turns put off.
    // rust: pub(super) fn flush_sweeps(&mut self) {
    // rust: for sweep in std::mem::take(&mut self.creatures.sweeps) {
    // rust: self.sweep_other_players(sweep);
}
}

    // `Player.doSweepAttack` on the players: each other player in the box,
    // closer than 3 blocks (`distanceToSqr < 9`) and not an ally
    // (`isAlliedTo`), is hurt (`ServerPlayer.canHarmPlayer`: the `pvp` rule)
    // and pushed 0.4 along the attacker's yaw.
    // rust: pub(super) fn sweep_players(&mut self, host: &mut LanHost, sweep: &Sweep) {
    // rust: let from = Vec3::new(sweep.from[0], sweep.from[1], sweep.from[2]);
    // rust: let mut victims = Vec::new();
    // rust: for g in &host.hub.guests {
    // rust: if host.hub.here(g)
    // rust: && g.loaded
    // rust: && !g.dead
    // rust: && !g.spectator()
    // rust: && sweep.attacker != Some(g.conn)
    // rust: && guest_bounds(g).intersects(sweep.hit_box)
    // rust: && Vec3::new(g.position[0], g.position[1], g.position[2]).distance_squared(from)
    // rust: < 9.0
    // rust: {
    // rust: let team = self.score.board.players_team(&g.name).cloned();
    // rust: victims.push((Victim::Guest(g.conn), g.entity_id, team));
}
}
    // rust: let (xd, zd) = sweep.knockback;
    // rust: let attacker = self.player_attacker(host, sweep.attacker);
    // rust: let attacker_id = self.player.as_ref().map_or(0, |p| p.entity_id);
    // rust: let land = |g: &mut Self| {
    // rust: let _attacker =
    // rust: g.knockback_scope(attacker.as_ref().map_or(attacker_id, |(id, _)| *id as i32));
    // rust: if let Some((id, name)) = &attacker {
    // rust: g.note_named_attacker("minecraft:player_attack", *id, name.clone());
}
    // rust: if g.mob_hits_player(sweep.damage, sweep.from, "minecraft:player_attack") {
    // rust: g.knock_back_player(0.4, xd, zd, PVP_SOURCE);
                // EnchantmentHelper.doPostAttackEffects, after the knockback.
    // rust: if sweep.ignite > 0.0
    // rust: && let Some(p) = g.player.as_mut()
    // rust: {
    // rust: let _ = p.ignite_for_ticks((sweep.ignite * 20.0) as i32);
}
}
}
    // rust: for (victim, id, team) in victims {
    // rust: if sweep.skip == Some(id)
    // rust: || horizon_client::scoreboard::teams_allied(team.as_ref(), sweep.team.as_ref())
    // rust: || !self.ui.rules.bool("pvp")
    // rust: {
    // rust: continue;
}
    // rust: let Victim::Guest(conn) = victim;
    // rust: self.guest_struck_by(host, conn, land);
}
}
}
