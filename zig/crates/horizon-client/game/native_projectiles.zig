//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_projectiles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Projectile impacts for native mods (`native_projectile_impact`, NeoForge's
//! `ProjectileImpactEvent`). `tick_projectiles` flies every projectile first and
//! collects the impacts; once its worlds are let go, the mods hear each one, and a
//! projectile whose impact a mod canceled flies the tick again from where it was,
//! through whatever it hit.
// use super::{
    // rust: Game,
    // rust: creatures::{ProjWorld, wind_charge_hit},
    // rust: dragon::{CRYSTAL_IDS, SPECIAL},
    // rust: lan_pvp::meets_players,
    // rust: native_hooks::mob_kind,
}
// use horizon_client::{
    // rust: arrows::ArrowEvent,
    // rust: mobs::Who,
    // rust: projectiles::{Hit, Projectile},
}
// use horizon_core::geometry::Vec3;
// use std::ops::Range;

/// A projectile's impact in one tick of `tick_projectiles`.
    // rust: pub(super) struct Impact {
    /// Where the projectile was in the tick's list.
    // rust: pub index: usize,
    /// The projectile before the tick.
    // rust: pub before: Projectile,
    // rust: pub hit: Hit,
    /// Where its hit is in the tick's `hits`.
    // rust: pub hit_slot: usize,
    /// Where its arrow events are in the tick's `arrow_events`.
    // rust: pub events: Range<usize>,
}

/// The type the mods know a projectile by: a spectral arrow is its own.
pub fn projectile_type(p: *Projectile) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let spectral = p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .is_some_and(|a| &*a.pickup_item.item == "minecraft:spectral_arrow");
    // rust: if spectral {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: p.kind.id()
}
}

    // rust: impl Game<'_> {
    /// Whether this game is a server that flies projectiles for the mods (the
    /// server thread or a dedicated server, never a client) and a mod asked to hear their impacts
    /// (`native_hears_projectile_impacts`). Without one, the tick keeps no copy
    /// of its projectiles: it costs nothing.
    // rust: pub(super) fn native_hears_impacts(&self) -> bool {
    // rust: if self.serving.is_none() && self.options.dedicated.is_none() {
    // rust: return false;
}
    // rust: let mut hears = false;
    // rust: self.native_hears_projectile_impacts(&mut hears);
    // rust: hears
}

    /// The entity id of the one who shot `p`: a mob's, a player's, else 0.
pub fn native_impact_owner(self: *Self, p: *Projectile) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match p.owner {
    // rust: Some(Who::Mob(id)) => id,
    // rust: Some(Who::Player) => self.native_thrower(p.guest),
    // rust: None => 0,
}
}

    /// The entity id of the player who threw something: the guest `guest`, or
    /// the host.
pub fn native_thrower(self: *Self, guest: ?u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match guest {
    // rust: Some(conn) => self
    // rust: .lan_guest_entities()
    // rust: .into_iter()
    // rust: .find(|&(c, _)| c == conn)
    // rust: .map_or(0, |(_, id)| id),
    // rust: None => 0,
}
}

    /// `native_projectile_impact` for a player's thrown trident, which
    /// `tick_tridents` flies rather than `tick_projectiles`: it hit the mob
    /// `mob`, or with `mob` None the block at `block` on its `face`, at `at`.
    /// Whether a mod canceled it.
    // rust: pub(super) fn native_trident_impact(
    // rust: &mut self,
    // rust: trident: u32,
    // rust: guest: Option<u32>,
    // rust: mob: Option<u32>,
    // rust: block: [i32; 3],
    // rust: face: [i32; 3],
    // rust: at: Vec3,
    // rust: ) -> bool {
    // rust: if !self.native_hears_impacts() {
    // rust: return false;
}
    // rust: let owner = self.native_thrower(guest);
    // rust: let (entity, entity_kind) = match mob {
    // rust: Some(id) => {
    // rust: let (entity, kind) = self.native_impact_entity(id);
    // rust: (Some(entity), kind)
}
    // rust: None => (None, String::new()),
}
    // rust: let dimension = self.dim.id();
    // rust: let mut canceled = false;
    // rust: self.native_projectile_impact(
    // rust: dimension,
    // rust: trident,
    // rust: "minecraft:trident",
    // rust: owner,
    // rust: entity,
    // rust: &entity_kind,
    // rust: block,
    // rust: face,
    // rust: [at.x, at.y, at.z],
    // rust: &mut canceled,
    // rust: );
    // rust: canceled
}

    /// The entity id and type a projectile's hit on the reserved or ordinary
    /// `id` stands for: a dragon part is the dragon, an End crystal its own id.
pub fn native_impact_entity(self: *Self, id: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id >= SPECIAL {
    // rust: return if id < CRYSTAL_IDS {
    // rust: let dragon = self.dragon.as_ref().map_or(0, |d| d.id);
    // rust: (dragon, "minecraft:ender_dragon".into())
    // rust: } else {
    // rust: let crystal = self.crystals.get((id - CRYSTAL_IDS) as usize);
    // rust: (crystal.map_or(0, |c| c.id), "minecraft:end_crystal".into())
}
}
    // rust: if let Some(mob) = self.mobs.iter().find(|m| m.id == id) {
    // rust: return (id, mob_kind(mob));
}
    // rust: if let Some(cart) = self.carts.iter().find(|c| c.id == id) {
    // rust: return (id, cart.kind.id().into());
}
    // rust: if self.lan_guest_entities().iter().any(|&(_, e)| e == id) {
    // rust: return (id, "minecraft:player".into());
}
    // rust: (id, String::new())
}

    /// `native_projectile_impact` for each of `impacts`: whether the mods
    /// canceled it. A hit on a wind charge is not told.
pub fn native_projectile_impacts(self: *Self, impacts: *[Impact]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dimension = self.dim.id();
    // rust: let mut canceled = Vec::with_capacity(impacts.len());
    // rust: for impact in impacts {
    // rust: let p = &impact.before;
    // rust: let (entity, entity_kind, block, face, at) = match impact.hit {
    // rust: Hit::Block { pos, at, face } => (None, String::new(), pos, face, at),
    // rust: Hit::Entity {
    // rust: who: Who::Mob(id),
    // rust: at,
    // rust: } => {
    // rust: if wind_charge_hit(id).is_some() {
    // rust: canceled.push(false);
    // rust: continue;
}
    // rust: let (entity, kind) = self.native_impact_entity(id);
    // rust: (Some(entity), kind, [0; 3], [0; 3], at)
}
                // A server's players are hit as their entities, never as `Player`.
    // rust: Hit::Entity {
    // rust: who: Who::Player, ..
    // rust: } => {
    // rust: canceled.push(false);
    // rust: continue;
}
    // rust: Hit::None => {
    // rust: canceled.push(false);
    // rust: continue;
}
}
    // rust: let owner = self.native_impact_owner(p);
    // rust: let mut stop = false;
    // rust: self.native_projectile_impact(
    // rust: dimension,
    // rust: p.id,
    // rust: projectile_type(p),
    // rust: owner,
    // rust: entity,
    // rust: &entity_kind,
    // rust: block,
    // rust: face,
    // rust: [at.x, at.y, at.z],
    // rust: &mut stop,
    // rust: );
    // rust: canceled.push(stop);
}
    // rust: canceled
}

    /// The end of a tick of `tick_projectiles` that met `impacts`, with
    /// `projectiles` in place (those it keeps, as `listed` says of the tick's
    /// list): the mods hear each, and a projectile one canceled flies the tick
    /// again from before it, through what it hit. Its hit and its arrow events are
    /// taken out of `hits` and `arrow_events`, and it goes back among the
    /// projectiles. One a mod removed in its hook stays removed.
    // rust: pub(super) fn native_settle_impacts(
    // rust: &mut self,
    // rust: projectiles: &mut Vec<Projectile>,
    // rust: listed: &[bool],
    // rust: impacts: Vec<Impact>,
    // rust: hits: &mut Vec<(Projectile, Hit)>,
    // rust: arrow_events: &mut Vec<(Vec3, ArrowEvent)>,
    // rust: ) {
        // The mods see the projectiles where they will be, as `projectile_hit` does.
    // rust: self.creatures.projectiles = std::mem::take(projectiles).into();
    // rust: let canceled = self.native_projectile_impacts(&impacts);
    // rust: *projectiles = std::mem::take(&mut self.creatures.projectiles).into();
    // rust: if !canceled.contains(&true) {
    // rust: return;
}
    // rust: let mut drop_hits = vec![false; hits.len()];
    // rust: let mut drop_events = vec![false; arrow_events.len()];
    // rust: let mut flown = Vec::new();
    // rust: for (impact, _) in impacts.into_iter().zip(canceled).filter(|(_, c)| *c) {
    // rust: drop_hits[impact.hit_slot] = true;
    // rust: drop_events[impact.events.clone()].fill(true);
    // rust: let present = projectiles.iter().position(|q| q.id == impact.before.id);
    // rust: if present.is_none() && listed[impact.index] {
    // rust: continue;
}
    // rust: let mut before = impact.before;
            // Replaying a canceled impact must not repeat the first-tick event
            // already queued by the original tick.
    // rust: before.has_been_shot = hits[impact.hit_slot].0.has_been_shot;
    // rust: let (p, keep, events) = self.native_projectile_through(before);
    // rust: flown.extend(events);
    // rust: match (present, keep) {
    // rust: (Some(i), true) => projectiles[i] = p,
    // rust: (Some(i), false) => {
    // rust: projectiles.remove(i);
}
    // rust: (None, true) => projectiles.push(p),
    // rust: (None, false) => {}
}
}
    // rust: let mut n = 0;
    // rust: hits.retain(|_| {
    // rust: n += 1;
    // rust: !drop_hits[n - 1]
    // rust: });
    // rust: let mut n = 0;
    // rust: arrow_events.retain(|_| {
    // rust: n += 1;
    // rust: !drop_events[n - 1]
    // rust: });
    // rust: arrow_events.extend(flown);
}

    /// `p`, as it was before its tick, flown that tick through what it hit
    /// (`Projectile::tick_through`, `arrows::tick_through`): the projectile after
    /// it, whether it stays, and the arrow events it made.
    // rust: fn native_projectile_through(
    // rust: &self,
    // rust: mut p: Projectile,
    // rust: ) -> (Projectile, bool, Vec<(Vec3, ArrowEvent)>) {
    // rust: let mob_shot = !matches!(p.owner, Some(Who::Player));
    // rust: let pvp = !mob_shot && meets_players(&p.kind);
        // A guest's shot flies from that guest, as in `tick_projectiles`.
    // rust: let shooter = p
    // rust: .guest
    // rust: .filter(|_| pvp)
    // rust: .and_then(|c| self.lan_guest_entities().into_iter().find(|&(g, _)| g == c))
    // rust: .map(|(_, id)| Who::Mob(id));
    // rust: if shooter.is_some() {
    // rust: p.owner = shooter;
}
    // rust: let mut targets = self.projectile_targets();
    // rust: if mob_shot || pvp {
    // rust: targets.extend(self.lan_projectile_targets());
}
    // rust: let rain = self.arrow_rain();
    // rust: let scene = self.arrow_scene(&rain);
    // rust: let (keep, _) = if p.arrow.is_some() {
    // rust: horizon_client::arrows::tick_through(&mut p, &scene, &targets)
    // rust: } else {
    // rust: let w = self.mob_world_base(&[]);
    // rust: p.tick_through(&ProjWorld {
    // rust: w: &w,
    // rust: targets,
    // rust: border: Some(self.border.bounds()),
    // rust: })
}
    // rust: if shooter.is_some() {
    // rust: p.owner = Some(Who::Player);
}
    // rust: let at = p.position;
    // rust: let events = p
    // rust: .arrow
    // rust: .as_mut()
    // rust: .map(|a| a.events.drain(..).map(|e| (at, e)).collect())
    // rust: .unwrap_or_default();
    // rust: (p, keep, events)
}
}
