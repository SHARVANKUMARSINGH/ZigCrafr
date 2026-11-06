//! Transpiled from Horizon Rust crate
package horizon_client_boat_leads

import "core:fmt"
import "core:mem"
import "core:math"

// Leads on boats and rafts (`AbstractBoat implements Leashable`): putting a
// lead on one, taking it off, `Leashable.tickLeash` (the pull of the rope,
// the lead snapping past twelve blocks), saving who holds it, and dropping
// the lead when the boat breaks. The rope is drawn by `leads.rs`
// (`LeashFeatureRenderer`, four ropes from a boat to a happy ghast).
// A boat is also a holder (`Holder::Boat`): `Entity.interact`'s sneak click
// ties the player's mobs and boats to it.
//
// The elastic pull of a ridden boat: `Leashable.tickLeash` runs on the
// server only, and the server's boat that its rider's client drives takes
// that client's position back (`handleMoveVehicle`), so vanilla never moves
// it by the rope either. Here the pull lands on the server's copy and the
// rider's client overwrites it the same way (`tick_boats`).
// use super::{Game, boats::Boat};
// use horizon_client::actions::Action;
// use horizon_client::mobs::leash::{self, Holder, HolderState, Pending};
// use horizon_core::geometry::Vec3;
// use horizon_world::nbt::Tag;

// `AbstractBoat`'s `getBbWidth` and `getBbHeight`.
WIDTH :: 1.375
HEIGHT :: 0.5625

// Where the other end of a boat's lead is.
Held :: enum {
    // The holder is gone: the lead comes off (`canInteractWithLevel`).
    Gone,
    // In another level or not loaded: nothing happens (`level() ==`).
    Elsewhere,
    // Its state, and whether it holds a quad lead.
    At(HolderState, bool),
}

center :: proc(b: ^Boat) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(
    // rust: b.position.x,
    // rust: b.position.y + f64::from(HEIGHT) / 2.0,
    // rust: b.position.z,
    // rust: )
}
// A boat as a lead's holder (`HolderState`), with its id.
    // rust: pub(super) fn boat_state(b: &Boat) -> (u32, HolderState) {
    // rust: (
    // rust: b.id,
    // rust: HolderState {
    // rust: position: b.position,
    // rust: center: center(b),
    // rust: width: f64::from(WIDTH),
    // rust: height: f64::from(HEIGHT),
    // rust: yaw: b.yaw,
    // rust: velocity: b.velocity,
    // rust: },
    // rust: )
}
distance :: proc(a: Vec3, b: Vec3) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((a.x - b.x).powi(2) + (a.y - b.y).powi(2) + (a.z - b.z).powi(2)).sqrt()
}

    // rust: impl Game<'_> {
    // The player whose lead this is: the lead's `leash_player`, else the
    // local player.
boat_leash_player :: proc(self: ^Self, b: ^Boat) -> O {
    // Ported from Horizon
    return {}
}
    // rust: b.leash_player.or(self.level.player_uuid)
}
boat_holder :: proc(self: ^Self, holder: Holder, player: Maybe([i32; 4])) -> H {
    // Ported from Horizon
    return {}
}
    // rust: match holder {
    // rust: Holder::Player => {
    // rust: let want = player.or(self.level.player_uuid);
                // A server's guest (single player's window included) first.
    // rust: let guest = self.lan.as_ref().and_then(|host| {
    // rust: let g = host.hub.guests.iter().find(|g| {
    // rust: Some(horizon_client::lan::playerdata::uuid_ints(g.uuid)) == want
    // rust: })?;
    // rust: Some((host, g))
    // rust: });
    // rust: if let Some((host, g)) = guest {
    // rust: if !host.hub.here(g) || !g.loaded {
    // rust: return Held::Elsewhere;
}
    // rust: if g.dead || g.spectator() {
    // rust: return Held::Gone;
}
    // rust: let bounds = g.bounds();
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let moved = [0, 1, 2].map(|k| g.position[k] - g.previous_position[k]);
    // rust: return Held::At(
    // rust: HolderState {
    // rust: position: Vec3::new(g.position[0], g.position[1], g.position[2]),
    // rust: center: Vec3::new(
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: ),
    // rust: width: hi.x - lo.x,
    // rust: height: hi.y - lo.y,
    // rust: yaw: g.yaw,
    // rust: velocity: Vec3::new(moved[0], moved[1], moved[2]),
    // rust: },
    // rust: false,
    // rust: );
}
    // rust: if want != self.level.player_uuid {
                    // A player who left: Entity.remove drops what they led.
    // rust: return Held::Gone;
}
    // rust: let Some(v) = self.player_view() else {
    // rust: return Held::Elsewhere;
}
    // rust: if !v.alive || v.spectator {
    // rust: return Held::Gone;
}
    // rust: let lo = v.bounds.min_position();
    // rust: let size = v.bounds.max_position().subtract(lo);
    // rust: Held::At(
    // rust: HolderState {
    // rust: position: v.position,
    // rust: center: Vec3::new(v.position.x, lo.y + size.y / 2.0, v.position.z),
    // rust: width: size.x,
    // rust: height: size.y,
    // rust: yaw: v.yaw,
    // rust: velocity: v.velocity,
    // rust: },
    // rust: false,
    // rust: )
}
    // rust: Holder::Mob(id) => {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id && m.alive()) else {
    // rust: return Held::Gone;
}
    // rust: let (lo, hi) = (m.bounds().min_position(), m.bounds().max_position());
    // rust: Held::At(
    // rust: HolderState {
    // rust: position: m.position,
    // rust: center: Vec3::new(
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: ),
    // rust: width: hi.x - lo.x,
    // rust: height: hi.y - lo.y,
    // rust: yaw: m.yaw,
    // rust: velocity: m.velocity,
    // rust: },
    // rust: leash::quad_holder_offsets(m).is_some(),
    // rust: )
}
    // rust: Holder::Boat(id) => match self.boats.iter().find(|o| o.id == id) {
                // supportQuadLeashAsHolder is the ghasts' alone.
    // rust: Some(o) => Held::At(boat_state(o).1, false),
    // rust: None => Held::Gone,
    // rust: },
    // rust: Holder::Knot(pos) => {
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]));
    // rust: let fence = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:fences")
    // rust: .is_some_and(|s| s.contains(&*name.name));
    // rust: if fence {
    // rust: Held::At(leash::knot_state(pos), false)
    // rust: } else {
    // rust: Held::Gone
}
}
}
}

    // `Leashable.dropLeash` / `removeLeash` on a boat: the lead falls as an
    // item (`drop`). The change reaches clients through the entity tracker.
release_boat_leash :: proc(self: ^Self, b: ^Boat, drop: bool) {
}
    // rust: if b.leash.take().is_none() {
    // rust: return;
}
    // rust: b.leash_player = None;
    // rust: if drop {
    // rust: self.drop_lead_item([b.position.x, b.position.y, b.position.z]);
}
}

    // `AbstractBoat.remove`: a boat that is destroyed drops its lead.
    // rust: pub(super) fn boat_removed(&mut self, b: &Boat) {
    // rust: let mut b = b.clone();
    // rust: let pending = b.leash_pending.take().is_some();
    // rust: if b.leash.is_some() || pending {
    // rust: let at = [b.position.x, b.position.y, b.position.z];
    // rust: b.leash = None;
    // rust: self.drop_lead_item(at);
}
}

    // `Leashable.tickLeash` for a boat, at the end of `Entity.baseTick`.
    // rust: pub(super) fn tick_boat_leash(&mut self, b: &mut Boat) {
    // rust: b.age += 1;
    // rust: if let Some(pending) = b.leash_pending {
    // rust: self.restore_boat_leash(b, pending);
}
    // rust: let Some(holder) = b.leash else {
    // rust: return;
}
    // rust: let (state, quad) = match self.boat_holder(holder, b.leash_player) {
    // rust: Held::Elsewhere => return,
            // !leashHolder.canInteractWithLevel(): dropLeash with entity_drops
            // on, else removeLeash.
    // rust: Held::Gone => {
    // rust: let drops = self.ui.rules.bool("entity_drops");
    // rust: self.release_boat_leash(b, drops);
    // rust: return;
}
    // rust: Held::At(state, quad) => (state, quad),
}
        // Leashable.whenLeashedTo: `leashHolder.notifyLeashHolder(this)`; a
        // boat supports a quad lead.
    // rust: if let Holder::Mob(id) = holder
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: horizon_client::mobs::happy_ghast::notify_leash_holder(m);
}
    // rust: let away = distance(state.center, center(b));
    // rust: if away > leash::SNAP {
    // rust: let p = state.position;
    // rust: self.lead_sound("break", [p.x, p.y, p.z]);
    // rust: self.release_boat_leash(b, true);
    // rust: return;
}
    // rust: if away > leash::ELASTIC - state.width - f64::from(WIDTH)
    // rust: && let Some((force, torque)) = leash::elastic_pull(
    // rust: b.position,
    // rust: b.yaw,
    // rust: (f64::from(WIDTH), f64::from(HEIGHT)),
    // rust: &state,
    // rust: b.velocity,
    // rust: quad,
    // rust: )
    // rust: {
    // rust: b.leash_spin += 10.0 * torque;
    // rust: let relative = Vec3::new(
    // rust: state.velocity.x - b.velocity.x,
    // rust: state.velocity.y - b.velocity.y,
    // rust: state.velocity.z - b.velocity.z,
    // rust: );
    // rust: b.velocity = Vec3::new(
    // rust: b.velocity.x + force[0] * 0.8 + relative.x * 0.11,
    // rust: b.velocity.y + force[1] * 0.2 + relative.y * 0.11,
    // rust: b.velocity.z + force[2] * 0.8 + relative.z * 0.11,
    // rust: );
}
    // rust: b.yaw = (f64::from(b.yaw) - b.leash_spin) as f32;
    // rust: b.leash_spin *= f64::from(self.boat_angular_friction(b));
}

    // `Leashable.angularFriction`.
boat_angular_friction :: proc(self: ^Self, b: ^Boat) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if b.on_ground {
    // rust: let (x, z) = (b.position.x.floor() as i32, b.position.z.floor() as i32);
    // rust: let y = (b.position.y - 0.500_001).floor() as i32;
    // rust: self.res.facts().get(self.world.block(x, y, z)).friction * 0.91
    // rust: } else if b.in_liquid() {
    // rust: 0.8
    // rust: } else {
    // rust: 0.91
}
}

    // `Leashable.restoreLeashFromSave`: a holder read from a save becomes
    // real once its entity is found; one that never shows up in 100 ticks
    // drops the lead.
restore_boat_leash :: proc(self: ^Self, b: ^Boat, pending: Pending) {
}
    // rust: let found = match pending {
    // rust: Pending::Knot(p) => Some((Holder::Knot(p), None)),
    // rust: Pending::Uuid(u) => {
    // rust: let guest = self.lan.as_ref().is_some_and(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .any(|g| horizon_client::lan::playerdata::uuid_ints(g.uuid) == u)
    // rust: });
    // rust: if guest || (self.level.player_uuid == Some(u) && self.player.is_some()) {
    // rust: Some((Holder::Player, Some(u)))
    // rust: } else {
    // rust: self.mob_by_uuid(u)
    // rust: .map(|id| (Holder::Mob(id), None))
    // rust: .or_else(|| self.boat_by_uuid(u).map(|id| (Holder::Boat(id), None)))
}
}
}
    // rust: if let Some((holder, player)) = found {
    // rust: b.leash = Some(holder);
    // rust: b.leash_player = player;
    // rust: b.leash_pending = None;
    // rust: } else if b.age > 100 {
    // rust: b.leash_pending = None;
    // rust: self.drop_lead_item([b.position.x, b.position.y, b.position.z]);
}
}

    // The `leash` tag of a boat about to be saved.
    // rust: pub(super) fn write_boat_leash(&mut self, tag: &mut Tag, index: usize) {
    // rust: let Tag::Compound(map) = tag else { return };
    // rust: map.remove(&"leash".into());
    // rust: let b = &self.boats[index];
    // rust: let (holder, pending, player) = (b.leash, b.leash_pending, self.boat_leash_player(b));
    // rust: let value = match (holder, pending) {
    // rust: (Some(Holder::Mob(id)), _) => {
    // rust: let uuid = self.mob_uuid(id);
    // rust: leash::to_nbt(Holder::Mob(id), Some(uuid))
}
    // rust: (Some(Holder::Boat(id)), _) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: leash::to_nbt(Holder::Boat(id), Some(uuid))
}
    // rust: (Some(h), _) => leash::to_nbt(h, player),
    // rust: (None, Some(Pending::Knot(p))) => leash::to_nbt(Holder::Knot(p), None),
    // rust: (None, Some(Pending::Uuid(u))) => leash::to_nbt(Holder::Player, Some(u)),
    // rust: _ => None,
}
    // rust: if let Some(v) = value {
    // rust: map.insert("leash".into(), v);
}
}

    // Whether the player acting holds this boat's lead.
boat_led_by_player :: proc(self: ^Self, i: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let me = self.acting_player_uuid();
    // rust: let b = &self.boats[i];
    // rust: b.leash == Some(Holder::Player) && self.boat_leash_player(b) == Some(me)
}

    // The boat with this UUID (`ServerLevel.getEntity`).
    // rust: pub(super) fn boat_by_uuid(&self, uuid: [i32; 4]) -> Option<u32> {
    // rust: self.persist
    // rust: .uuids
    // rust: .iter()
    // rust: .find(|(id, u)| **u == uuid && self.boats.iter().any(|b| b.id == **id))
    // rust: .map(|(id, _)| *id)
}

    // The boats on the acting player's lead within 32 blocks of a point
    // (`Leashable.leashableInArea`).
    // rust: pub(super) fn player_led_boats(&mut self, around: glam::DVec3) -> Vec<usize> {
    // rust: (0..self.boats.len())
    // rust: .filter(|&i| {
    // rust: let c = center(&self.boats[i]);
    // rust: self.boat_led_by_player(i)
    // rust: && (c.x - around.x).abs() <= 16.0 + f64::from(WIDTH) / 2.0
    // rust: && (c.y - around.y).abs() <= 16.0
    // rust: && (c.z - around.z).abs() <= 16.0 + f64::from(WIDTH) / 2.0
    // rust: })
    // rust: .collect()
}

    // The boats whose lead hangs on `holder`.
    // rust: pub(super) fn boats_on(&self, holder: Holder) -> Vec<usize> {
    // rust: (0..self.boats.len())
    // rust: .filter(|&i| self.boats[i].leash == Some(holder))
    // rust: .collect()
}

    // `Leashable.canHaveALeashAttachedTo` for the boat at `i` and an entity
    // whose box centre is `at`.
boat_can_attach :: proc(self: ^Self, i: uint, at: glam::DVec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let c = center(&self.boats[i]);
    // rust: distance(Vec3::new(at.x, at.y, at.z), c) <= leash::SNAP
}

    // The acting player's boats on a lead go to `to` (`Entity.interact` of a
    // sneak click on a mob, `LeadItem.bindPlayerMobs`, the knot's
    // `interact`), the ones in reach of `at`. Whether any did.
    // rust: pub(super) fn tie_player_boats(&mut self, at: glam::DVec3, to: Holder) -> bool {
    // rust: let mut any = false;
    // rust: for i in self.player_led_boats(at) {
            // Leashable.setLeashedTo: `this != holder`.
    // rust: if to == Holder::Boat(self.boats[i].id) {
    // rust: continue;
}
    // rust: if self.boat_can_attach(i, at) {
    // rust: self.boats[i].leash = Some(to);
    // rust: self.boats[i].leash_player = None;
    // rust: any = true;
}
}
    // rust: any
}

    // `LeashFenceKnotEntity.interact`: the boats on the knot go back on the
    // acting player's lead. Whether any did.
    // rust: pub(super) fn take_knot_boats(&mut self, knot: [i32; 3]) -> bool {
    // rust: let me = self.acting_player_uuid();
    // rust: let player = self.player_center();
    // rust: let mut any = false;
    // rust: for i in self.boats_on(Holder::Knot(knot)) {
    // rust: if self.boat_can_attach(i, player) {
    // rust: self.boats[i].leash = Some(Holder::Player);
    // rust: self.boats[i].leash_player = Some(me);
    // rust: any = true;
}
}
    // rust: any
}

    // `Leashable.dropLeash` for each boat in `list`.
    // rust: pub(super) fn drop_boat_leashes(&mut self, list: &[usize]) {
    // rust: for &i in list {
    // rust: let mut b = self.boats[i].clone();
    // rust: self.release_boat_leash(&mut b, true);
    // rust: self.boats[i] = b;
}
}

    // `Entity.interact`'s lead part for the boat at `i`; whether it took
    // the click.
    // rust: pub(super) fn interact_boat_leash(&mut self, i: usize) -> bool {
    // rust: let item = self.held().map(|s| s.item.to_string());
    // rust: let c = center(&self.boats[i]);
    // rust: let at = [c.x, c.y, c.z];
    // rust: let id = self.boats[i].id;
        // The sneak branch: the player's mobs and boats on leads are re-tied
        // to this boat.
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: if sneaking
    // rust: && self.tie_player_leads(glam::DVec3::new(c.x, c.y, c.z), Holder::Boat(id), None)
    // rust: {
    // rust: self.lead_game_event("minecraft:entity_action", at);
    // rust: self.lead_sound("tied", at);
    // rust: return true;
}
        // Entity.shearOffAllLeashConnections: its own lead and every one
        // hanging on it.
    // rust: if item.as_deref() == Some("minecraft:shears") {
    // rust: let held_mobs: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.leash == Some(Holder::Boat(id)))
    // rust: .map(|m| m.id)
    // rust: .collect();
    // rust: let mut held_boats = self.boats_on(Holder::Boat(id));
    // rust: if self.boats[i].leash.is_some() {
    // rust: held_boats.push(i);
}
    // rust: if !held_mobs.is_empty() || !held_boats.is_empty() {
    // rust: for m in held_mobs {
    // rust: self.break_leash(m, true, false);
}
    // rust: self.drop_boat_leashes(&held_boats);
    // rust: self.lead_game_event("minecraft:shear", at);
    // rust: self.audio
    // rust: .play("minecraft:item.shears.snip", Some(at), 1.0, 1.0);
    // rust: self.damage_held_tool();
    // rust: return true;
}
}
    // rust: if self.boat_led_by_player(i) {
            // hasInfiniteMaterials: removeLeash, else dropLeash.
    // rust: let drop = !self.creative;
    // rust: let mut b = self.boats[i].clone();
    // rust: self.release_boat_leash(&mut b, drop);
    // rust: self.boats[i] = b;
    // rust: self.lead_game_event("minecraft:entity_interact", at);
    // rust: self.lead_sound("untied", at);
    // rust: return true;
}
    // rust: let taken_by_player = self.boats[i].leash == Some(Holder::Player);
    // rust: if item.as_deref() == Some("minecraft:lead") && !taken_by_player {
    // rust: let player = self.player_center();
    // rust: if self.boat_can_attach(i, player) {
    // rust: let mut b = self.boats[i].clone();
    // rust: self.release_boat_leash(&mut b, true);
    // rust: b.leash = Some(Holder::Player);
    // rust: b.leash_player = Some(self.acting_player_uuid());
    // rust: self.boats[i] = b;
    // rust: self.lead_sound("tied", at);
                // The lead is always used up.
    // rust: if let Some(stack) = self.held_mut().as_mut() {
    // rust: stack.count -= 1;
    // rust: if stack.count == 0 {
    // rust: *self.held_mut() = None;
}
}
    // rust: return true;
}
}
    // rust: false
}

    // The leads on boats that hang on a player or a mob, for the entity
    // tracker: the holder's entity id (`ClientboundSetEntityLinkPacket`).
    // rust: pub(super) fn boat_leash_link(&self, b: &Boat, guests: &[(u128, i32)]) -> Option<i32> {
    // rust: match b.leash? {
    // rust: Holder::Player => {
    // rust: let uuid = self.boat_leash_player(b);
    // rust: guests
    // rust: .iter()
    // rust: .find(|(u, _)| Some(horizon_client::lan::playerdata::uuid_ints(*u)) == uuid)
    // rust: .map(|&(_, id)| id)
}
    // rust: Holder::Mob(id) | Holder::Boat(id) => Some(id as i32),
    // rust: Holder::Knot(p) => self.knot_ids.get(&p).map(|&id| id as i32),
}
}
}

    // rust: mod tests {
//     use super::*;

a_boat_is_centred_half_its_height_up :: proc() {
}
    // rust: let b = Boat::new(1, "oak".into(), Vec3::new(1.0, 64.0, 2.0), 0.0);
    // rust: let c = center(&b);
    // rust: assert_eq!((c.x, c.z), (1.0, 2.0));
    // rust: assert!((c.y - 64.28125).abs() < 1e-9);
}
a_boat_holds_a_lead_from_its_centre :: proc() {
}
    // rust: let mut b = Boat::new(7, "oak".into(), Vec3::new(1.0, 64.0, 2.0), 90.0);
    // rust: b.velocity = Vec3::new(0.1, 0.0, 0.0);
    // rust: let (id, s) = boat_state(&b);
    // rust: assert_eq!(id, 7);
    // rust: assert!((s.center.y - 64.28125).abs() < 1e-9);
    // rust: assert!((s.width - 1.375).abs() < 1e-9 && (s.height - 0.5625).abs() < 1e-9);
    // rust: assert_eq!((s.yaw, s.velocity.x), (90.0, 0.1));
}
a_boat_holder_is_an_entity_not_a_player :: proc() {
}
    // rust: assert_eq!(Holder::Boat(7).who(), None);
    // rust: assert_ne!(Holder::Boat(7), Holder::Mob(7));
}
distances_are_euclidean :: proc() {
}
    // rust: let d = distance(Vec3::new(0.0, 0.0, 0.0), Vec3::new(3.0, 4.0, 0.0));
    // rust: assert!((d - 5.0).abs() < 1e-12);
}
}
