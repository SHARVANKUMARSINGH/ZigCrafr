//! Transpiled from Horizon Rust crate
package horizon_client_wind

import "core:fmt"
import "core:mem"
import "core:math"

// Wind charges: the item a player throws (`WindChargeItem`), the charges
// breezes shoot, and the burst they make (`ServerExplosion` with
// `TRIGGER_BLOCK`: no damage, only knockback and the blocks that react).
// use super::Game;
// use super::entity::{Blast, Entity as _, for_each_entity_mut};
// use horizon_client::advancements::EntityView;
// use horizon_client::join_seq::Joined as _;
// use horizon_client::{
    // rust: Result,
    // rust: mobs::{Damage, DamageKind, Species, Who},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: projectiles::{Hit, Projectile, ProjectileKind},
}
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::level::PlayerContext;
// use std::collections::BTreeSet;

// `WindCharge.RADIUS` and the knockback multiplier of its damage calculator.
PLAYER_RADIUS :: 1.2
PLAYER_KNOCKBACK :: 1.22
// `BreezeWindCharge.RADIUS`.
BREEZE_RADIUS :: 3.0

// A burst `wind_burst` puts off until a guest's turn is over.
    // rust: pub(super) struct Burst {
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: multiplier: f32,
    // rust: breeze: bool,
    // rust: wind_charge: bool,
}
// Whether a wind push must wait for the entity's own tick: it joined before
// the charge (`id` below the charge's), so vanilla has ticked it already this
// game tick, and its kind ticks after the projectiles here.
    // rust: fn push_waits_for_tick<T: PartialOrd>(
    // rust: ticks_after_projectiles: bool,
    // rust: joined: T,
    // rust: charge: Option<T>,
    // rust: ) -> bool {
    // rust: ticks_after_projectiles && charge.is_some_and(|c| joined < c)
}
// `Projectile.deflect` with `ProjectileDeflection.REVERSE`.
    // rust: pub(super) fn reverse(p: &mut Projectile, jitter: f32) {
    // rust: p.velocity = Vec3::new(
    // rust: p.velocity.x * -0.5,
    // rust: p.velocity.y * -0.5,
    // rust: p.velocity.z * -0.5,
    // rust: );
    // rust: p.yaw += 170.0 + jitter * 20.0;
}
// Whether a block reacts to a wind charge's burst by being used.
triggers :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let n = name.trim_start_matches("minecraft:");
    // Doors and trapdoors open unless iron; gates, buttons, levers and bells react.
    // rust: (n.ends_with("_door") || n.ends_with("_trapdoor")) && !n.starts_with("iron_")
    // rust: || n.ends_with("_fence_gate")
    // rust: || n.ends_with("_button")
    // rust: || n == "lever"
    // rust: || n == "bell"
}
    // rust: impl Game<'_> {
    // `WindChargeItem.use`.
    // rust: pub(super) fn throw_wind_charge(&mut self) -> Result<bool> {
    // rust: let (Some(eye), Some(p)) = (self.eye_position(), self.player.as_ref()) else {
    // rust: return Ok(false);
}
    // rust: let (on_ground, pos) = (p.ground.on_ground, p.position);
    // rust: let velocity = self.known_player_movement();
    // rust: let start = Vec3::new(pos.x, eye[1], pos.z);
    // rust: let mut proj = Projectile::new(ProjectileKind::WindCharge, start, Some(Who::Player));
    // rust: proj.shoot_from_rotation(
    // rust: &mut self.world.random,
    // rust: self.pitch,
    // rust: self.yaw,
    // rust: 0.0,
    // rust: 1.5,
    // rust: 1.0,
    // rust: velocity,
    // rust: on_ground,
    // rust: );
    // rust: self.add_projectile(proj);
    // rust: let pitch = 0.4 / (self.world.random.next_float() * 0.4 + 0.8);
    // rust: self.audio
    // rust: .play("minecraft:entity.wind_charge.throw", Some(eye), 0.5, pitch);
    // rust: self.award_stat("used", "minecraft:wind_charge", 1);
    // rust: self.swing_arm();
    // rust: if !self.creative
    // rust: && let Some(s) = self.held_mut().as_mut()
    // rust: {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *self.held_mut() = None;
}
}
    // rust: Ok(true)
}
    // A wind charge meeting an entity or a block (or flying too high).
    // rust: pub(super) fn wind_charge_hit(&mut self, p: &Projectile, hit: Hit) -> Result<()> {
    // rust: let breeze = p.kind == ProjectileKind::BreezeWindCharge;
    // rust: let (radius, knockback) = if breeze {
    // rust: (BREEZE_RADIUS, 1.0)
    // rust: } else {
    // rust: (PLAYER_RADIUS, PLAYER_KNOCKBACK)
}
    // rust: let center = match hit {
    // rust: Hit::Entity { who, at } => {
    // rust: self.wind_charge_damage(p, who);
    // rust: [at.x, at.y, at.z]
}
            // onHitBlock: a quarter of a block out along the face.
    // rust: Hit::Block { at, face, .. } => [
    // rust: at.x + f64::from(face[0]) * 0.25,
    // rust: at.y + f64::from(face[1]) * 0.25,
    // rust: at.z + f64::from(face[2]) * 0.25,
    // rust: ],
    // rust: Hit::None => return Ok(()),
}
    // rust: self.creatures.wind_source = Some(p.join_seq());
    // rust: let burst = self.wind_burst(center, radius, knockback, breeze, !breeze);
    // rust: self.creatures.wind_source = None;
    // rust: burst
}
    // `AbstractWindCharge.onHitEntity`: one point of damage.
wind_charge_damage :: proc(self: ^Self, p: ^Projectile, who: Who) {
}
    // rust: let owner_breeze = matches!(p.owner, Some(Who::Mob(id))
    // rust: if self.mobs.iter().any(|m| m.id == id && m.species() == Species::Breeze));
    // rust: match who {
    // rust: Who::Player => {
    // rust: if !self.creative {
    // rust: self.mob_hits_player_kind(
    // rust: 1.0,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:wind_charge",
    // rust: );
}
}
            // An ender dragon part takes the point of damage too; a crystal is
            // not hit (`AbstractWindCharge.canHitEntity`).
    // rust: Who::Mob(id) if id >= super::dragon::SPECIAL => {
    // rust: if id < super::dragon::SPECIAL + 8 {
    // rust: self.hit_special(
    // rust: id,
    // rust: 1.0,
    // rust: p.owner == Some(Who::Player),
    // rust: horizon_client::mobs::DamageKind::WindCharge,
    // rust: Some(&p.kind),
    // rust: );
}
}
    // rust: Who::Mob(id) => {
    // rust: let source = Damage {
    // rust: kind: DamageKind::Thrown,
    // rust: attacker: p.owner,
    // rust: from: Some([p.previous.x, p.previous.y, p.previous.z]),
    // rust: attacker_species: owner_breeze.then_some(Species::Breeze),
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
                    // Breeze.isInvulnerableTo: its own kind's charges.
    // rust: if owner_breeze && m.species() == Species::Breeze {
    // rust: return;
}
                    // Refused before the hurt, so the kill is not credited
                    // either; the burst of `wind_charge_hit` still goes off.
    // rust: if horizon_client::mobs::wither::armor_refuses(m, &p.kind) {
    // rust: return;
}
    // rust: m.damage(1.0, source);
}
    // rust: if p.owner == Some(Who::Player) {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
}
}
}
}
    // The exploded positions: rays through everything but the blocks that
    // stop wind (`blocks_wind_charge_explosions`).
wind_positions :: proc(self: ^Self, center: [f64; 3], radius: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let stops = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:blocks_wind_charge_explosions")
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: let (min_y, max_y) = (self.world.bottom_y(), self.world.top_y());
    // rust: let mut set: BTreeSet<[i32; 3]> = BTreeSet::new();
    // rust: for xx in 0..16 {
    // rust: for yy in 0..16 {
    // rust: for zz in 0..16 {
    // rust: if !(xx == 0 || xx == 15 || yy == 0 || yy == 15 || zz == 0 || zz == 15) {
    // rust: continue;
}
    // rust: let mut d = [
    // rust: f64::from(xx as f32 / 15.0 * 2.0 - 1.0),
    // rust: f64::from(yy as f32 / 15.0 * 2.0 - 1.0),
    // rust: f64::from(zz as f32 / 15.0 * 2.0 - 1.0),
    // rust: ];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: for c in &mut d {
    // rust: *c /= len;
}
    // rust: let mut power = radius * (0.7 + self.world.random.next_float() * 0.6);
    // rust: let mut at = center;
    // rust: while power > 0.0 {
    // rust: let pos = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: if pos[1] < min_y || pos[1] >= max_y {
    // rust: break;
}
    // rust: let name = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name;
    // rust: if stops.contains(&**name) {
    // rust: power -= (3_600_000.0_f32 + 0.3) * 0.3;
}
    // rust: if power > 0.0 {
    // rust: set.insert(pos);
}
    // rust: for i in 0..3 {
    // rust: at[i] += d[i] * f64::from(0.3_f32);
}
    // rust: power -= 0.225_000_01;
}
}
}
}
    // rust: set.into_iter().collect()
}
    // `ServerExplosion.hurtEntities` for a calculator that damages nothing:
    // knockback scaled by distance, exposure and the multiplier. Returns the
    // guests it pushed and by how much (`hitPlayers`), which their clients
    // apply from the burst's packet.
    // rust: fn wind_knockback(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: multiplier: f32,
    // rust: breeze: bool,
    // rust: wind_charge: bool,
    // rust: blocks: &[[i32; 3]],
    // rust: ) -> Vec<(u32, [f64; 3])> {
        // ServerExplosion.shouldAffectBlocklikeEntities
    // rust: let blocklike = !breeze && !wind_charge && self.ui.rules.bool("mob_griefing");
    // rust: let diameter = f64::from(radius * 2.0);
    // rust: let distance = |p: [f64; 3]| {
    // rust: ((p[0] - center[0]).powi(2) + (p[1] - center[1]).powi(2) + (p[2] - center[2]).powi(2))
    // rust: .sqrt()
}
    // rust: let direction = |origin: [f64; 3]| {
    // rust: let d = [
    // rust: origin[0] - center[0],
    // rust: origin[1] - center[1],
    // rust: origin[2] - center[2],
    // rust: ];
    // rust: let l = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if l < 1.0e-5 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [d[0] / l, d[1] / l, d[2] / l]
}
}
        // The player, then every other player in the level (LAN guests),
        // each swapped in as the player. In a guest's turn (a mace's wind
        // burst) the player is that guest.
    // rust: let own = self.wind_push_player(center, radius, multiplier, breeze, wind_charge, blocks);
    // rust: let mut pushed: Vec<_> = self.lan_acting.zip(own).into_iter().collect();
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: let guests: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in guests {
    // rust: let push = self.as_guest(&mut host, conn, |g| {
    // rust: g.wind_push_player(center, radius, multiplier, breeze, wind_charge, blocks)
    // rust: });
    // rust: if let Some(Some(push)) = push {
    // rust: pushed.push((conn, push));
}
}
    // rust: self.lan = Some(host);
}
    // rust: let multiplier = f64::from(multiplier);
        // Every other entity takes `Entity.pushFromExplosion` alike: its
        // distance is from its feet, its direction from its eyes. A kind sits
        // out where its `ignoreExplosion` says (items and visible stands for a
        // charge, vehicles for a mob's burst with mob griefing off).
    // rust: let burst = Blast {
    // rust: vehicles_ignore: breeze && !self.ui.rules.bool("mob_griefing"),
    // rust: items_ignore: !blocklike,
    // rust: spared: None,
}
    // rust: let source = self.creatures.wind_source;
    // rust: let done = self.ordered.done;
    // rust: let mut late = Vec::new();
    // rust: let mut entities = self.take_entities();
    // rust: for_each_entity_mut!(entities, entity => {
    // rust: if entity.ignores_explosion(&burst) || !entity.pushed_by_wind() {
    // rust: continue;
}
    // rust: let feet = entity.position();
    // rust: let feet = [feet.x, feet.y, feet.z];
    // rust: let dist = distance(feet) / diameter;
    // rust: if dist > 1.0 {
    // rust: continue;
}
    // rust: let b = entity.explosion_box();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let exposure = self.seen_percent(center, [lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: let power = (1.0 - dist) * f64::from(exposure) * multiplier;
    // rust: let dir = direction([feet[0], feet[1] + entity.explosion_eye_height(), feet[2]]);
    // rust: let mut push = [dir[0] * power, dir[1] * power, dir[2] * power];
    // rust: let id = Some(entity.id());
    // rust: self.native_explosion_knockback(self.dim.id(), center, blocks, id, &mut push);
    // rust: let push = Vec3::new(push[0], push[1], push[2]);
            // ServerLevel ticks entities in the order they joined. One that
            // joined before the charge has ticked by now in vanilla, so the
            // push is for its next tick; here its kind ticks after the
            // projectiles, so the push waits for that tick to run.
            // Joined before the charge and not ticked yet: the push is for its next tick.
    // rust: let waiting = entity.ticks_after_projectiles()
    // rust: && done.is_none_or(|d| entity.join_seq() > d);
    // rust: if push_waits_for_tick(waiting, entity.join_seq(), source) {
    // rust: late.push((entity.id(), push));
    // rust: } else {
    // rust: entity.push_from_explosion(push);
}
    // rust: });
    // rust: self.restore_entities(entities);
    // rust: self.creatures.late_wind_pushes.extend(late);
    // rust: pushed
}
    // The pushes `wind_knockback` held for entities that tick after the
    // projectiles, applied once those entities have ticked.
    // rust: pub(super) fn apply_late_wind_pushes(&mut self) {
    // rust: let late = std::mem::take(&mut self.creatures.late_wind_pushes);
    // rust: if late.is_empty() {
    // rust: return;
}
    // rust: let mut entities = self.take_entities();
    // rust: for_each_entity_mut!(entities, entity => {
    // rust: if let Some((_, push)) = late.iter().find(|(id, _)| *id == entity.id()) {
    // rust: entity.push_from_explosion(*push);
}
    // rust: });
    // rust: self.restore_entities(entities);
}
    // `ServerExplosion.hurtEntities` for the player: the push, less
    // explosion knockback resistance, and `ServerPlayer.onExplosionHit`.
    // Returns the push for players eligible for the explosion packet.
    // rust: fn wind_push_player(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: multiplier: f32,
    // rust: breeze: bool,
    // rust: wind_charge: bool,
    // rust: blocks: &[[i32; 3]],
    // rust: ) -> Option<[f64; 3]> {
    // rust: if self.spectator() {
    // rust: return None;
}
    // rust: let resistance = self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:explosion_knockback_resistance").ok())
    // rust: .unwrap_or(0.0);
    // rust: let creative = self.creative;
    // rust: let p = self.player.as_ref()?;
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: let dist = ((feet[0] - center[0]).powi(2)
    // rust: + (feet[1] - center[1]).powi(2)
    // rust: + (feet[2] - center[2]).powi(2))
    // rust: .sqrt()
    // rust: / f64::from(radius * 2.0);
    // rust: let flying = creative && p.flying;
    // rust: if dist > 1.0 {
    // rust: return None;
}
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let h = f64::from(p.dimensions.height);
    // rust: let eye = [
    // rust: feet[0] - center[0],
    // rust: feet[1] + f64::from(p.dimensions.eye_height) - center[1],
    // rust: feet[2] - center[2],
    // rust: ];
    // rust: let exposure = self.seen_percent(
    // rust: center,
    // rust: [feet[0] - w, feet[1], feet[2] - w],
    // rust: [feet[0] + w, feet[1] + h, feet[2] + w],
    // rust: );
    // rust: let power = (1.0 - dist) * f64::from(exposure) * f64::from(multiplier) * (1.0 - resistance);
    // rust: let l = (eye[0] * eye[0] + eye[1] * eye[1] + eye[2] * eye[2]).sqrt();
    // rust: let mut push = if l < 1.0e-5 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: eye.map(|d| d / l * power)
}
    // rust: self.native_explosion_knockback(self.dim.id(), center, blocks, None, &mut push);
    // rust: let p = self.player.as_mut()?;
    // rust: p.velocity = Vec3::new(
    // rust: p.velocity.x + push[0],
    // rust: p.velocity.y + push[1],
    // rust: p.velocity.z + push[2],
    // rust: );
        // ServerPlayer.onExplosionHit: a wind charge's burst cancels the
        // fall; any other burst ends the grace of the last impulse.
    // rust: let at = p.position;
    // rust: p.impulse.set_ignore_fall_damage(wind_charge, Some(at));
        // The cause is the charge that burst (`ServerExplosion.source`); a mace's
        // burst has none.
    // rust: let cause = if wind_charge {
    // rust: Some("minecraft:wind_charge")
    // rust: } else if breeze {
    // rust: Some("minecraft:breeze_wind_charge")
    // rust: } else {
    // rust: None
}
    // rust: .map(|kind| EntityView {
    // rust: kind: kind.into(),
    // rust: position: center,
    // rust: ..EntityView::default()
    // rust: });
    // rust: self.adv.marks.blast = Some(([at.x, at.y, at.z], cause));
    // rust: (!flying).then_some(push)
}
    // The burst: knockback, the blocks that react, the gust and the sound.
    // rust: pub(super) fn wind_burst(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: multiplier: f32,
    // rust: breeze: bool,
    // rust: wind_charge: bool,
    // rust: ) -> Result<()> {
        // In a guest's turn (their charge landing, their mace's burst) the
        // host holds the other players (`as_guest`): the burst waits for the
        // turn to end so that it reaches every player, the guest too.
    // rust: if self.lan_acting.is_some() && self.lan.is_none() {
    // rust: self.creatures.wind_bursts.push(Burst {
    // rust: center,
    // rust: radius,
    // rust: multiplier,
    // rust: breeze,
    // rust: wind_charge,
    // rust: });
    // rust: return Ok(());
}
        // ServerExplosion.explode: the blast is heard first.
    // rust: let ctx = horizon_client::sculk::Context::default();
    // rust: self.post_game_event("minecraft:explode", center, ctx);
    // rust: let mut targets = self.wind_positions(center, radius);
    // rust: let pushed = self.wind_knockback(center, radius, multiplier, breeze, wind_charge, &targets);
    // rust: let block_count = targets.len();
        // Explosion.canTriggerBlocks: a breeze's charge needs mob griefing.
    // rust: if !breeze || self.ui.rules.bool("mob_griefing") {
            // Util.shuffle(list, level.random)
    // rust: for i in (2..=targets.len()).rev() {
    // rust: let swap = self.world.random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: targets.swap(i - 1, swap);
}
    // rust: for pos in targets {
    // rust: self.wind_trigger_block(pos)?;
}
}
    // rust: let sound = if breeze {
    // rust: "minecraft:entity.breeze.wind_burst"
    // rust: } else {
    // rust: "minecraft:entity.wind_charge.wind_burst"
}
    // rust: let pitch = (1.0
    // rust: + (super::explosion::client_float() - super::explosion::client_float()) * 0.2)
    // rust: * 0.7;
    // rust: self.audio.play(sound, Some(center), 4.0, pitch);
        // Explosion.isSmall: below a radius of 2.
    // rust: let ty = if radius < 2.0 {
    // rust: ParticleType::GustEmitterSmall
    // rust: } else {
    // rust: ParticleType::GustEmitterLarge
}
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ty), center, [1.0, 0.0, 0.0]);
    // rust: self.lan_wind_burst(center, radius, sound, block_count, &pushed);
    // rust: Ok(())
}
    // The bursts guests' turns put off.
    // rust: pub(super) fn flush_wind_bursts(&mut self) -> Result<()> {
    // rust: self.flush_smash_pushes();
    // rust: for b in std::mem::take(&mut self.creatures.wind_bursts) {
    // rust: self.wind_burst(b.center, b.radius, b.multiplier, b.breeze, b.wind_charge)?;
}
    // rust: Ok(())
}
    // `BlockBehaviour.onExplosionHit` for `TRIGGER_BLOCK`: doors, gates,
    // buttons, levers and bells react as if used; candles go out.
wind_trigger_block :: proc(self: ^Self, pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: let prop = |game: &Self, key: &str| {
    // rust: game.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get(key).cloned())
}
    // rust: if name.ends_with("candle") || name.ends_with("candle_cake") {
            // AbstractCandleBlock.onExplosionHit: extinguish(null, ...), the
            // candle's own sound and a block-change game event (the smoke is a
            // client-level particle, which a server level never draws).
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.extinguish_candle(level, ticks, BlockPos::new(pos[0], pos[1], pos[2]))
    // rust: });
    // rust: self.process_level_events()?;
    // rust: return Ok(());
}
    // rust: if !triggers(&name) {
    // rust: return Ok(());
}
        // BellBlock.onExplosionHit: attemptToRing with no direction, so the bell
        // rings toward its facing, not the face the burst came from,
        // powered or not.
    // rust: if &*name == "minecraft:bell" {
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.bell_attempt_to_ring(level, ticks, BlockPos::new(pos[0], pos[1], pos[2]))
    // rust: });
    // rust: self.process_level_events()?;
    // rust: return Ok(());
}
        // Doors react in their lower half only; powered ones and pressed
        // buttons stay as they are.
    // rust: if name.ends_with("_door") && prop(self, "half").as_deref() != Some("lower") {
    // rust: return Ok(());
}
    // rust: if prop(self, "powered").as_deref() == Some("true") && &*name != "minecraft:lever" {
    // rust: return Ok(());
}
        // FenceGateBlock.onExplosionHit toggles the gate without turning it
        // towards anyone, as a click would.
    // rust: if name.ends_with("_fence_gate") {
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.fence_gate_exploded(level, ticks, BlockPos::new(pos[0], pos[1], pos[2]))
    // rust: });
    // rust: self.process_level_events()?;
    // rust: return Ok(());
}
    // rust: let at = Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
    // rust: let player = PlayerContext {
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: may_build: true,
    // rust: can_eat: false,
    // rust: game_master: false,
}
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.use_without_item(
    // rust: level,
    // rust: ticks,
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: Direction::Up,
    // rust: at,
    // rust: player,
    // rust: )
    // rust: });
    // rust: self.process_level_events()?;
    // rust: Ok(())
}
    // `WindChargeRenderer`: the spinning charge and its wind.
    // rust: pub(super) fn wind_charge_geometry(
    // rust: &self,
    // rust: p: &Projectile,
    // rust: at: glam::Vec3,
    // rust: light: u32,
    // rust: partial: f32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let Some(model) = self.entity_models.wind_charge.as_ref() else {
    // rust: return;
}
    // rust: let Some(r) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/projectiles/wind_charge")
    // rust: .copied()
    // rust: else {
    // rust: return;
}
        // `EntityRenderState.ageInTicks`: the tick count plus the partial tick.
    // rust: let age = p.age as f32 + partial;
    // rust: let mut poses = horizon_client::mobs::anim::Poses::new(model);
    // rust: poses.yrot("wind_charge", -age * 16.0_f32.to_radians());
    // rust: poses.yrot("wind", age * 16.0_f32.to_radians());
    // rust: let base = glam::Mat4::from_translation(at)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0));
    // rust: let start = out.len();
    // rust: horizon_client::mobs::render::draw_scrolled(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: horizon_client::mobs::render::scroll_offset(
    // rust: age,
    // rust: horizon_client::mobs::render::WIND_CHARGE_SCROLL,
    // rust: ),
    // rust: 0xFFFF_FFFF,
    // rust: light,
    // rust: 0,
    // rust: out,
    // rust: );
        // `RenderTypes.breezeWind` has an `OitPipelineSet`.
    // rust: for vertex in &mut out[start..] {
    // rust: vertex.layer |= horizon_client::gfx::OIT_ENTITY;
}
}
}
    // rust: mod tests {
//     use super::*;

a_burst_opens_wooden_doors_but_not_iron_ones :: proc() {
}
    // rust: assert!(triggers("minecraft:oak_door"));
    // rust: assert!(triggers("minecraft:copper_trapdoor"));
    // rust: assert!(!triggers("minecraft:iron_door"));
    // rust: assert!(!triggers("minecraft:iron_trapdoor"));
    // rust: assert!(triggers("minecraft:lever"));
    // rust: assert!(triggers("minecraft:stone_button"));
    // rust: assert!(triggers("minecraft:bell"));
    // rust: assert!(!triggers("minecraft:stone"));
}
    // ServerLevel ticks entities in join order: an orb, falling block or TNT that
    // joined before the charge has moved by the time the charge bursts, so the
    // push belongs to its next tick; one that joined after has not.
a_push_waits_only_for_late_ticking_kinds_that_joined_before_the_charge :: proc() {
}
//         use crate::game::entity::Entity;
    // rust: assert!(push_waits_for_tick(true, 3, Some(7)));
    // rust: assert!(!push_waits_for_tick(true, 9, Some(7)), "joined after");
    // rust: assert!(!push_waits_for_tick(false, 3, Some(7)), "ticks before it");
    // rust: assert!(!push_waits_for_tick(true, 3, None), "not a charge's burst");
    // rust: let tnt = crate::game::tnt::PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: id: 1,
    // rust: position: Vec3::ZERO,
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::ZERO,
    // rust: fuse: 80,
    // rust: on_ground: false,
    // rust: owner: None,
    // rust: guest: None,
    // rust: no_gravity: false,
    // rust: power: 4.0,
    // rust: block_state: None,
    // rust: join: Default::default(),
}
    // rust: assert!(Entity::ticks_after_projectiles(&tnt));
    // rust: let arrow = Projectile::new(ProjectileKind::Snowball, Vec3::ZERO, None);
    // rust: assert!(!Entity::ticks_after_projectiles(&arrow));
}
a_deflected_projectile_turns_around_at_half_speed :: proc() {
}
    // rust: let mut p = Projectile::new(ProjectileKind::Snowball, Vec3::ZERO, None);
    // rust: p.velocity = Vec3::new(2.0, -1.0, 0.0);
    // rust: reverse(&mut p, 0.5);
    // rust: assert!((p.velocity.x + 1.0).abs() < 1e-9 && (p.velocity.y - 0.5).abs() < 1e-9);
    // rust: assert!((p.yaw - 180.0).abs() < 1e-4);
}
}
