//! Transpiled from Horizon Rust crate
package horizon_client_leads

import "core:fmt"
import "core:mem"
import "core:math"

// Leads on the game side: putting them on and taking them off mobs
// (`Entity.interact`'s leash part), fence knots (`LeadItem.useOn` and
// `LeashFenceKnotEntity.interact`), loading and saving who holds what,
// breaking, and drawing the rope (`LeashFeatureRenderer`) and the knot.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::leash::{self, Holder, Pending},
    // rust: mod_api::NativeLootDrops,
}
// use horizon_world::nbt::Tag;

// `Vec3.yRot(angle)`.
// `LocalPlayer.getRopeHoldPosition`'s `Mth.lerp(partialTick * 0.5F, getYRot(),
// yRotO)` and the same for the pitch, in radians.
rope_hold_angles :: proc(now: (f32) {
}
    // rust: let t = alpha * 0.5;
    // rust: let lerp = |a: f32, b: f32| a + t * (b - a);
    // rust: (
    // rust: f64::from(lerp(now.0, old.0) * (std::f32::consts::PI / 180.0)),
    // rust: f64::from(lerp(now.1, old.1) * (std::f32::consts::PI / 180.0)),
    // rust: )
}
rot_y :: proc(v: glam::DVec3, angle: f64) -> g {
    // Ported from Horizon
    return {}
}
    // rust: let (s, c) = (angle.sin(), angle.cos());
    // rust: glam::DVec3::new(v.x * c + v.z * s, v.y, v.z * c - v.x * s)
}
// `Entity.getRopeHoldPosition` of a boat: 0.7 of its eye height (0.5625) up.
boat_hold :: proc() -> g {
    // Ported from Horizon
    return {}
}
    // rust: glam::DVec3::new(0.0, f64::from(0.5625_f32) * 0.7, 0.0)
}
pack_light :: proc(light: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8)
}
abgr :: proc(r: f32, g: f32, b: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let c = |v: f32| (v * 255.0) as u32 & 255;
    // rust: 0xFF00_0000 | c(b) << 16 | c(g) << 8 | c(r)
}
// One leashed entity's rope, as `EntityRenderer.extractRenderState` reads it.
Rope :: struct {
    holder: Holder,
    // `getPosition(partialTicks)`.
    here: glam::DVec3,
    // `getPreciseBodyRotation` in radians.
    body: f64,
    // `getLeashOffset`.
    offset: [f64,
    // `getQuadLeashOffsets`, when the entity supports a quad lead.
    quad: Option<[[f64,
}
// Whether a mob's lead is held by `acting` (`getLeashHolder() == player`).
    // rust: fn held_by_acting_player(
    // rust: leash: Option<Holder>,
    // rust: leash_player: Option<[i32; 4]>,
    // rust: acting: [i32; 4],
    // rust: ) -> bool {
    // rust: leash == Some(Holder::Player) && leash_player.is_none_or(|p| p == acting)
}

// Resolve a `Pending` leash holder loaded from NBT.
    // rust: fn resolve_pending_leash(
    // rust: pending: Pending,
    // rust: player_uuid: [i32; 4],
    // rust: owner_uuid: Option<[i32; 4]>,
    // rust: is_guest: impl FnOnce([i32; 4]) -> bool,
    // rust: mob_by_uuid: impl FnOnce([i32; 4]) -> Option<u32>,
    // rust: boat_by_uuid: impl FnOnce([i32; 4]) -> Option<u32>,
    // rust: ) -> Option<(Holder, Option<[i32; 4]>)> {
    // rust: match pending {
    // rust: Pending::Knot(p) => Some((Holder::Knot(p), None)),
    // rust: Pending::Uuid(u) if is_guest(u) || owner_uuid == Some(u) => Some((Holder::Player, Some(u))),
        // Old integrated worlds wrote offline_uuid("Player") for every holder.
        // Only that known sentinel can be mapped to the integrated owner; a
        // different level player UUID may belong to somebody else. Old guest
        // leashes lost their real UUID, so this owner recovery is best effort.
    // rust: Pending::Uuid(u)
    // rust: if u == player_uuid
    // rust: && u == horizon_client::lan::playerdata::uuid_ints(
    // rust: horizon_protocol::crypto::offline_uuid("Player"),
    // rust: )
    // rust: && owner_uuid.is_some() =>
    // rust: {
    // rust: Some((Holder::Player, owner_uuid))
}
    // rust: Pending::Uuid(u) => mob_by_uuid(u)
    // rust: .map(|id| (Holder::Mob(id), None))
    // rust: .or_else(|| boat_by_uuid(u).map(|id| (Holder::Boat(id), None))),
}
}

// Write a mob's `leash` NBT entry into `tag`.
    // rust: fn write_mob_leash_tag(
    // rust: tag: &mut Tag,
    // rust: holder: Option<Holder>,
    // rust: pending: Option<Pending>,
    // rust: leash_player: Option<[i32; 4]>,
    // rust: level_player_uuid: Option<[i32; 4]>,
    // rust: mob_uuid: impl FnOnce(u32) -> [i32; 4],
    // rust: ) {
    // rust: let Tag::Compound(map) = tag else { return };
    // rust: map.remove(&"leash".into());
    // rust: let uuid = match (holder, pending) {
    // rust: (Some(Holder::Player), _) => leash_player.or(level_player_uuid).or(Some([0, 0, 0, 1])),
    // rust: (Some(Holder::Mob(id) | Holder::Boat(id)), _) => Some(mob_uuid(id)),
    // rust: (_, Some(Pending::Uuid(u))) => Some(u),
    // rust: _ => None,
}
    // rust: let value = match (holder, pending) {
    // rust: (Some(h), _) => leash::to_nbt(h, uuid),
    // rust: (None, Some(Pending::Knot(p))) => leash::to_nbt(Holder::Knot(p), None),
    // rust: (None, Some(Pending::Uuid(u))) => leash::to_nbt(Holder::Player, Some(u)),
    // rust: _ => None,
}
    // rust: if let Some(v) = value {
    // rust: map.insert("leash".into(), v);
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn lead_sound(&mut self, sound: &str, at: [f64; 3]) {
    // rust: self.audio
    // rust: .play(&format!("minecraft:item.lead.{sound}"), Some(at), 1.0, 1.0);
}
    // `Leashable.canHaveALeashAttachedTo` for the mob at `index` and a
    // holder whose box centre is `center`: within snapping range and
    // leashable.
    // rust: pub(super) fn can_attach_lead(&self, index: usize, center: glam::DVec3) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if !leash::can_be_leashed(m) || !m.alive() {
    // rust: return false;
}
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mine = glam::DVec3::new(
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: );
    // rust: mine.distance(center) <= leash::SNAP
}
    // `Entity.gameEvent(event, player)` for a lead: the acting player is the source.
    // rust: pub(super) fn lead_game_event(&mut self, event: &'static str, at: [f64; 3]) {
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event(event, at, ctx);
}
    // `Entity.interact`'s sneak branch: the mobs and boats on the player's
    // lead within reach of `center` that `canHaveALeashAttachedTo` the
    // entity (`skip` is the entity itself) are re-tied to `to`. Whether any
    // was.
    // rust: pub(super) fn tie_player_leads(
    // rust: &mut self,
    // rust: center: glam::DVec3,
    // rust: to: Holder,
    // rust: skip: Option<usize>,
    // rust: ) -> bool {
    // rust: let mut any = false;
    // rust: for j in self.player_leashed(center) {
    // rust: if Some(j) != skip && self.can_attach_lead(j, center) {
    // rust: self.mobs[j].extra.leash = Some(to);
    // rust: any = true;
}
}
        // The boats on the player's lead too (game/boat_leads.rs).
    // rust: any | self.tie_player_boats(center, to)
}
    // rust: pub(super) fn player_center(&self) -> glam::DVec3 {
    // rust: self.player.as_ref().map_or(glam::DVec3::ZERO, |p| {
    // rust: glam::DVec3::new(
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.height) / 2.0,
    // rust: p.position.z,
    // rust: )
    // rust: })
}
    // The mobs on the acting player's lead within 32 blocks of a point
    // (`Leashable.leashableInArea` with `getLeashHolder() == player`).
    // rust: pub(super) fn player_leashed(&self, around: glam::DVec3) -> Vec<usize> {
    // rust: let acting = self.acting_uuid();
    // rust: (0..self.mobs.len())
    // rust: .filter(|&i| {
    // rust: let m = &self.mobs[i];
    // rust: held_by_acting_player(m.extra.leash, m.extra.leash_player, acting)
    // rust: && (m.position.x - around.x).abs() <= 16.0
    // rust: && (m.position.y - around.y).abs() <= 16.0
    // rust: && (m.position.z - around.z).abs() <= 16.0
    // rust: })
    // rust: .collect()
}
    // `Entity.spawnAtLocation(level, Items.LEAD)`: the item entity draws its
    // motion from its own random, not the level's.
    // rust: pub(super) fn drop_lead_item(&mut self, at: [f64; 3]) {
    // rust: let v = super::dispenser::new_item_motion();
    // rust: self.spawn_item(ItemStack::new("minecraft:lead", 1), at, v, 10);
}
    // `Leashable.dropLeash` / `removeLeash`: the lead falls as an item.
    // rust: pub(super) fn break_leash(&mut self, id: u32, drop: bool, sound: bool) {
    // rust: self.drop_leash(id, drop, sound, false);
}
    // `Entity.dropAllLeashConnections`: every mob and boat leashed to the
    // acting player, inside the 32-block box around the player's centre,
    // drops its lead. Then `GameEvent.SHEAR`. Whether anything dropped.
    // The player is not `Leashable`, so there is no lead of their own.
    // rust: pub(super) fn drop_all_leash_connections(&mut self) -> bool {
    // rust: let center = self.player_center();
    // rust: let mobs: Vec<u32> = self
    // rust: .player_leashed(center)
    // rust: .into_iter()
    // rust: .map(|i| self.mobs[i].id)
    // rust: .collect();
    // rust: let boats = self.player_led_boats(center);
    // rust: if mobs.is_empty() && boats.is_empty() {
    // rust: return false;
}
    // rust: for id in mobs {
            // One snap is played by the caller (`SoundEvents.LEAD_BREAK`),
            // not a break sound on each leashed entity.
    // rust: self.break_leash(id, true, false);
}
    // rust: self.drop_boat_leashes(&boats);
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or([center.x, center.y, center.z], |p| {
    // rust: [p.position.x, p.position.y, p.position.z]
    // rust: });
        // `gameEvent(GameEvent.SHEAR, null)`: the player is the position, not the source.
    // rust: let ctx = self.who_context(None, None);
    // rust: self.post_game_event("minecraft:shear", at, ctx);
    // rust: true
}
    // `break_leash` by the acting player's use (untying it, shears).
break_leash_used :: proc(self: ^Self, id: u32, drop: bool) {
}
    // rust: self.drop_leash(id, drop, false, true);
}
drop_leash :: proc(self: ^Self, id: u32, drop: bool, sound: bool, used: bool) {
}
    // rust: let killer = self.lead_killers.remove(&id).map(|(killer, _)| killer);
    // rust: let Some((alive, at, kind)) = self.mobs.iter_mut().find(|m| m.id == id).and_then(|m| {
    // rust: horizon_client::mobs::leash::remove(m)?;
    // rust: Some((
    // rust: m.alive(),
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: super::native_hooks::mob_kind(m),
    // rust: ))
    // rust: }) else {
    // rust: return;
}
    // rust: self.native_entity_unleash(id, &kind);
    // rust: if used
    // rust: && let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_unleash_entity(player, &name, id);
}
        // Leashable.tickLeash gates a dying entity's lead drop on entity_drops.
    // rust: let drop = drop && (alive || self.ui.rules.bool("entity_drops"));
    // rust: if sound {
    // rust: self.lead_sound("break", at);
}
    // rust: if !drop {
    // rust: return;
}
        // The mods' say when a player is behind it: the user, else the
        // killer of a mob that died leashed.
    // rust: let player = if used {
    // rust: Some(self.native_acting_id())
    // rust: } else {
    // rust: killer
}
    // rust: let Some(player) = player else {
    // rust: self.drop_lead_item(at);
    // rust: return;
}
    // rust: let mut drops = vec![ItemStack::new("minecraft:lead", 1)];
    // rust: let context = NativeLootDrops {
    // rust: table: "",
    // rust: dimension: self.dim.id(),
    // rust: origin: at,
    // rust: block: None,
    // rust: entity: Some((id, &kind)),
    // rust: player: Some(player),
    // rust: tool: None,
    // rust: explosion: None,
    // rust: used,
}
    // rust: self.native_loot_drops(&context, &mut drops);
    // rust: for stack in drops {
    // rust: if stack.count > 0 && &*stack.item != "minecraft:air" {
    // rust: let v = super::dispenser::new_item_motion();
    // rust: self.spawn_item(stack, at, v, 10);
}
}
}
    // Holders read from a save become real once the entity is found; a
    // holder that never shows up drops the lead after 100 ticks.
    // rust: pub(super) fn tick_leads(&mut self) {
        // A corpse gone without dropping its lead takes its killer along.
        // Only this level's: the others' mobs aren't in place.
    // rust: if !self.lead_killers.is_empty() {
    // rust: let (mobs, dim) = (&self.mobs, self.dim);
    // rust: self.lead_killers
    // rust: .retain(|id, (_, at)| *at != dim || mobs.iter().any(|m| m.id == *id && !m.removed));
}
    // rust: let player_uuid = self.level.player_uuid.unwrap_or([0, 0, 0, 1]);
    // rust: let owner_uuid = self
    // rust: .serving
    // rust: .as_ref()
    // rust: .map(|s| s.owner)
    // rust: .or_else(|| self.lan.as_ref().and_then(|h| h.hub.singleplayer_owner))
    // rust: .map(horizon_client::lan::playerdata::uuid_ints);
    // rust: for i in 0..self.mobs.len() {
    // rust: let Some(pending) = self.mobs[i].extra.leash_pending else {
    // rust: continue;
}
    // rust: let holder = resolve_pending_leash(
    // rust: pending,
    // rust: player_uuid,
    // rust: owner_uuid,
    // rust: |u| {
    // rust: self.lan.as_ref().is_some_and(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .any(|g| horizon_client::lan::playerdata::uuid_ints(g.uuid) == u)
    // rust: })
    // rust: },
    // rust: |u| self.mob_by_uuid(u),
    // rust: |u| self.boat_by_uuid(u),
    // rust: );
    // rust: let m = &mut self.mobs[i];
    // rust: if let Some((h, player)) = holder {
    // rust: if h == Holder::Player {
    // rust: m.extra.leash_player = player;
}
    // rust: m.extra.leash = Some(h);
    // rust: m.extra.leash_pending = None;
    // rust: } else if m.age > 100 {
    // rust: m.extra.leash_pending = None;
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: self.drop_lead_item(at);
}
}
}
    // The `leash` tag of a mob about to be saved.
    // rust: pub(super) fn write_leash(&mut self, tag: &mut Tag, index: usize) {
    // rust: let m = &self.mobs[index];
    // rust: let (holder, pending, leash_player) =
    // rust: (m.extra.leash, m.extra.leash_pending, m.extra.leash_player);
    // rust: let level_player_uuid = self.level.player_uuid;
    // rust: write_mob_leash_tag(
    // rust: tag,
    // rust: holder,
    // rust: pending,
    // rust: leash_player,
    // rust: level_player_uuid,
    // rust: |id| self.mob_uuid(id),
    // rust: );
}
    // `Entity.interact`'s leash part for a mob. Returns whether it was used.
    // rust: pub(super) fn interact_leash(&mut self, index: usize, item: &str) -> bool {
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let id = self.mobs[index].id;
    // rust: let at = self.mobs[index].center();
    // rust: if !self.mobs[index].alive() {
    // rust: return false;
}
        // Sneaking with mobs in hand: tie them to this one.
    // rust: if sneaking && leash::can_be_leashed(&self.mobs[index]) && !self.mobs[index].is_baby() {
    // rust: let b = self.mobs[index].bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let center = glam::DVec3::new(
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: );
    // rust: if self.tie_player_leads(center, Holder::Mob(id), Some(index)) {
    // rust: self.lead_game_event("minecraft:entity_action", at);
    // rust: self.lead_sound("tied", at);
    // rust: return true;
}
}
    // rust: if item == "minecraft:shears" {
    // rust: let mut dropped = false;
    // rust: if self.mobs[index].extra.leash.is_some() {
    // rust: self.break_leash_used(id, true);
    // rust: dropped = true;
}
    // rust: let others: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.leash == Some(Holder::Mob(id)))
    // rust: .map(|m| m.id)
    // rust: .collect();
    // rust: for o in others {
    // rust: self.break_leash_used(o, true);
    // rust: dropped = true;
}
    // rust: let boats = self.boats_on(Holder::Mob(id));
    // rust: dropped |= !boats.is_empty();
    // rust: self.drop_boat_leashes(&boats);
    // rust: if dropped {
    // rust: self.lead_game_event("minecraft:shear", at);
    // rust: self.audio
    // rust: .play("minecraft:item.shears.snip", Some(at), 1.0, 1.0);
    // rust: self.damage_held_tool();
    // rust: return true;
}
}
        // Mob.checkAndHandleImportantInteractions: only the player the lead
        // is tied to unties it (`getLeashHolder() == player`).
    // rust: let acting = self.acting_player_uuid();
    // rust: if held_by_acting_player(
    // rust: self.mobs[index].extra.leash,
    // rust: self.mobs[index].extra.leash_player,
    // rust: acting,
    // rust: ) {
    // rust: let creative = self.creative;
    // rust: self.break_leash_used(id, !creative);
    // rust: self.lead_game_event("minecraft:entity_interact", at);
    // rust: self.lead_sound("untied", at);
    // rust: return true;
}
    // rust: if item == "minecraft:lead" {
    // rust: let center = self.player_center();
    // rust: if self.can_attach_lead(index, center) {
    // rust: if self.mobs[index].extra.leash.is_some() {
    // rust: self.break_leash_used(id, true);
}
    // rust: let holder = self.acting_player_uuid();
    // rust: self.mobs[index].extra.leash = Some(Holder::Player);
    // rust: self.mobs[index].extra.leash_player = Some(holder);
    // rust: self.lead_sound("tied", at);
                // `Player.interactOn` restores the count of a player with
                // infinite materials (creative); others spend the lead.
    // rust: if !self.creative
    // rust: && let Some(stack) = self.held_mut().as_mut()
    // rust: {
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
    // `LeadItem.useOn` on the fence the crosshair hits.
    // rust: pub(super) fn interact_knot(&mut self) -> bool {
    // rust: let Some(hit) = self.pick() else {
    // rust: return false;
}
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]));
    // rust: if !self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:fences")
    // rust: .is_some_and(|s| s.contains(&*name.name))
    // rust: {
    // rust: return false;
}
        // `FenceBlock.useWithoutItem` / `LeadItem.useOn` only tie the player's own mobs
        // (`LeadItem.bindPlayerMobs`). A client whose crosshair met the knot sends Interact with
        // the knot's id instead. Taking a mob back here would undo a tie: the client sends the
        // click once for each hand.
    // rust: self.use_knot(hit.pos, false)
}
    // A click at the fence at `knot_pos`: `knot_hit` for `LeashFenceKnotEntity.interact`,
    // otherwise `LeadItem.useOn`. Returns whether it was used.
    // rust: pub(super) fn use_knot(&mut self, knot_pos: [i32; 3], knot_hit: bool) -> bool {
    // rust: let knot = leash::knot_state(knot_pos).center;
    // rust: let center = glam::DVec3::new(knot.x, knot.y, knot.z);
    // rust: let at = [center.x, center.y, center.z];
    // rust: let existing: Vec<usize> = (0..self.mobs.len())
    // rust: .filter(|&i| self.mobs[i].extra.leash == Some(Holder::Knot(knot_pos)))
    // rust: .collect();
    // rust: let existing_boats = self.boats_on(Holder::Knot(knot_pos));
    // rust: let held_item = self.held().map(|s| s.item.to_string());
    // rust: let sneaking = self.keys.held(Action::Sneak);
        // Shears snip every lead on the knot.
    // rust: if knot_hit && held_item.as_deref() == Some("minecraft:shears") {
    // rust: for i in existing {
    // rust: let id = self.mobs[i].id;
    // rust: self.break_leash_used(id, true);
}
    // rust: self.drop_boat_leashes(&existing_boats);
    // rust: self.audio
    // rust: .play("minecraft:item.shears.snip", Some(at), 1.0, 1.0);
    // rust: self.damage_held_tool();
    // rust: return true;
}
    // rust: let in_hand = self.player_leashed(center);
    // rust: let boats_in_hand = self.player_led_boats(center);
        // The knot is only made for the lead item, or when mobs already hang on it.
    // rust: if held_item.as_deref() != Some("minecraft:lead")
    // rust: && existing.is_empty()
    // rust: && existing_boats.is_empty()
    // rust: && in_hand.is_empty()
    // rust: && boats_in_hand.is_empty()
    // rust: {
    // rust: return false;
}
        // A knot is made when a lead is tied to a fence that has none.
    // rust: if existing.is_empty()
    // rust: && existing_boats.is_empty()
    // rust: && (!in_hand.is_empty() || !boats_in_hand.is_empty())
    // rust: && self.hanging_place_cancelled("minecraft:leash_knot", knot_pos)
    // rust: {
    // rust: return true;
}
    // rust: let mut attached = self.tie_player_boats(center, Holder::Knot(knot_pos));
    // rust: for j in in_hand {
    // rust: if self.can_attach_lead(j, center) {
    // rust: self.mobs[j].extra.leash = Some(Holder::Knot(knot_pos));
    // rust: attached = true;
}
}
    // rust: if !attached && !sneaking && knot_hit {
    // rust: let player = self.player_center();
    // rust: let holder = self.acting_player_uuid();
    // rust: for i in existing {
    // rust: if self.can_attach_lead(i, player) {
    // rust: self.mobs[i].extra.leash = Some(Holder::Player);
    // rust: self.mobs[i].extra.leash_player = Some(holder);
    // rust: attached = true;
}
}
    // rust: attached |= self.take_knot_boats(knot_pos);
}
    // rust: if attached {
    // rust: self.lead_sound("tied", at);
    // rust: self.swing_arm();
}
    // rust: attached
}
    // `LeashFeatureRenderer` for every lead and `LeashKnotRenderer` for the knots.
    // rust: pub(super) fn leash_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let white = atlas.font.white();
    // rust: let uv = [
    // rust: [white.u0, white.v1],
    // rust: [white.u1, white.v1],
    // rust: [white.u1, white.v0],
    // rust: [white.u0, white.v0],
    // rust: ];
    // rust: let lerp3 = |a: horizon_core::geometry::Vec3, b: horizon_core::geometry::Vec3| {
    // rust: glam::DVec3::new(
    // rust: a.x + (b.x - a.x) * alpha,
    // rust: a.y + (b.y - a.y) * alpha,
    // rust: a.z + (b.z - a.z) * alpha,
    // rust: )
}
    // rust: let mut knots: Vec<[i32; 3]> = Vec::new();
        // EntityRenderer.extractRenderState: a leashed mob or boat (an
        // `AbstractBoat` is `Leashable` too) with where it hangs.
    // rust: let body_of = |previous: f32, current: f32| {
    // rust: f64::from(
    // rust: previous + horizon_client::mobs::living::wrap(current - previous) * alpha as f32,
    // rust: )
    // rust: .to_radians()
}
    // rust: let mut ropes: Vec<Rope> = Vec::new();
    // rust: for m in &self.mobs {
    // rust: if let Some(holder) = m.extra.leash {
    // rust: ropes.push(Rope {
    // rust: holder,
    // rust: here: lerp3(m.previous, m.position),
    // rust: body: body_of(m.previous_body_yaw, m.body_yaw),
    // rust: offset: leash::leash_offset(m),
    // rust: quad: leash::supports_quad_leash(m.species())
    // rust: .then(|| leash::quad_leash_offsets(m)),
    // rust: });
}
}
    // rust: for b in &self.boats {
    // rust: if let Some(holder) = b.leash {
    // rust: ropes.push(Rope {
    // rust: holder,
    // rust: here: lerp3(b.previous, b.position),
                    // Entity.getPreciseBodyRotation: the boat's yaw.
    // rust: body: body_of(b.previous_yaw, b.yaw),
    // rust: offset: leash::boat_leash_offset(),
    // rust: quad: Some(leash::boat_quad_leash_offsets()),
    // rust: });
}
}
    // rust: for rope in ropes {
    // rust: let Rope {
    // rust: holder,
    // rust: here,
    // rust: body,
    // rust: offset,
    // rust: quad,
    // rust: } = rope;
            // One lead from the leash offset to the holder's rope hold
            // position, or, when the holder is a happy ghast and the leashee
            // supports a quad lead, four from `getQuadLeashOffsets` to
            // `getQuadLeashHolderOffsets`.
    // rust: let mut ends: Vec<(glam::DVec3, glam::DVec3, bool)> = Vec::new();
    // rust: let quad = match (holder, quad) {
    // rust: (Holder::Mob(id), Some(offsets)) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .and_then(|o| leash::quad_holder_offsets(o).map(|h| (o, h, offsets))),
    // rust: _ => None,
}
    // rust: if let Some((roper, holder_points, own)) = quad {
    // rust: let roper_body = body_of(roper.previous_body_yaw, roper.body_yaw);
    // rust: let holder_pos = lerp3(roper.previous, roper.position);
    // rust: for (mine, theirs) in own.iter().zip(holder_points) {
    // rust: let start = here + rot_y(glam::DVec3::from_array(*mine), -body);
    // rust: let end = holder_pos + rot_y(glam::DVec3::from_array(theirs), -roper_body);
    // rust: ends.push((start, end, false));
}
    // rust: } else {
    // rust: let offset = rot_y(glam::DVec3::from_array(offset), -body);
    // rust: let start = here + offset;
    // rust: let end = match holder {
    // rust: Holder::Knot(p) => {
    // rust: if !knots.contains(&p) {
    // rust: knots.push(p);
}
    // rust: glam::DVec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.375 + 0.2,
    // rust: f64::from(p[2]) + 0.5,
    // rust: )
}
    // rust: Holder::Mob(id) => {
    // rust: let Some(o) = self.mobs.iter().find(|o| o.id == id) else {
    // rust: continue;
}
    // rust: lerp3(o.previous, o.position)
    // rust: + glam::DVec3::new(0.0, o.eye_height() * 0.7, 0.0)
}
    // rust: Holder::Boat(id) => {
    // rust: let Some(o) = self.boats.iter().find(|o| o.id == id) else {
    // rust: continue;
}
    // rust: lerp3(o.previous, o.position) + boat_hold()
}
    // rust: Holder::Player => {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: continue;
}
    // rust: self.player_rope_hold(p, alpha)
}
}
    // rust: ends.push((start, end, true));
}
    // rust: let light = |p: glam::DVec3| {
    // rust: self.world
    // rust: .light(p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32)
}
            // Block and sky light averaged between the two ends.
    // rust: let (a, b) = (light(ends[0].0), light(ends[0].1));
    // rust: let packed = pack_light((((a >> 4) + (b >> 4)) / 2) << 4 | (((a & 15) + (b & 15)) / 2));
    // rust: for (start, end, slack) in ends {
    // rust: let d = end - start;
    // rust: let k = 1.0 / (d.x * d.x + d.z * d.z).sqrt().max(1e-6) * 0.05 / 2.0;
    // rust: let (dx_off, dz_off) = (d.z * k, d.x * k);
    // rust: let point = |step: i32, fudge: f64| {
    // rust: let progress = f64::from(step) / 24.0;
                    // LeashFeatureRenderer.addVertexPair: a quad lead is straight.
    // rust: let y = if !slack {
    // rust: d.y * progress
    // rust: } else if d.y > 0.0 {
    // rust: d.y * progress * progress
    // rust: } else {
    // rust: d.y - d.y * (1.0 - progress) * (1.0 - progress)
}
    // rust: let base = start + glam::DVec3::new(d.x * progress, y, d.z * progress);
    // rust: (
    // rust: base + glam::DVec3::new(-dx_off, fudge, dz_off),
    // rust: base + glam::DVec3::new(dx_off, 0.05 - fudge, -dz_off),
    // rust: )
}
    // rust: for (fudge, backwards) in [(0.05, false), (0.0, true)] {
    // rust: for step in 0..24 {
    // rust: let shade = |s: i32| {
    // rust: let dark = s % 2 == i32::from(backwards);
    // rust: let f = if dark { 0.7 } else { 1.0 };
    // rust: abgr(0.5 * f, 0.4 * f, 0.3 * f)
}
    // rust: let (a0, b0) = point(step, fudge);
    // rust: let (a1, b1) = point(step + 1, fudge);
    // rust: let color = shade(step);
                        // Both faces: the leash is not culled.
    // rust: for quad in [[a0, b0, b1, a1], [a1, b1, b0, a0]] {
    // rust: for (v, uv) in quad.iter().zip(uv) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: (*v - camera).as_vec3().to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color,
    // rust: light: packed,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
}
}
        // The knots: a 6 by 8 by 6 pixel block on the fence post.
    // rust: let Some(model) = self.entity_models.leash_knot.as_ref() else {
    // rust: return;
}
    // rust: let Some(r) = atlas.sprites.get("entity/lead_knot/lead_knot").copied() else {
    // rust: return;
}
    // rust: for p in knots {
    // rust: let state = leash::knot_state(p);
    // rust: let at =
    // rust: glam::DVec3::new(state.position.x, state.position.y, state.position.z) - camera;
    // rust: let base = glam::Mat4::from_translation(at.as_vec3())
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0));
    // rust: let poses = horizon_client::mobs::anim::Poses::new(model);
    // rust: let light = pack_light(self.world.light(p[0], p[1], p[2]));
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: 0xFFFF_FFFF,
    // rust: light,
    // rust: 0,
    // rust: out,
    // rust: );
}
}
    // `Player.getRopeHoldPosition` (and `LocalPlayer`'s in first person).
    // rust: fn player_rope_hold(
    // rust: &self,
    // rust: p: &horizon_client::motion::PlayerMotion,
    // rust: alpha: f64,
    // rust: ) -> glam::DVec3 {
    // rust: let pos = glam::DVec3::new(p.position.x, p.position.y, p.position.z);
        // Player.getRopeHoldPosition: `0.22 * (RIGHT ? -1 : 1)`.
    // rust: let hand_dir = if self.settings.main_hand_left {
    // rust: 1.0
    // rust: } else {
    // rust: -1.0
}
    // rust: if self.camera_type.first_person() {
    // rust: let (yaw, pitch) =
    // rust: rope_hold_angles((self.yaw, self.pitch), self.rope_rot_old, alpha as f32);
    // rust: let v = glam::DVec3::new(0.39 * hand_dir, -0.6, 0.3);
            // Vec3.xRot(-pitch) then yRot(-yaw).
    // rust: let (s, c) = ((-pitch).sin(), (-pitch).cos());
    // rust: let v = glam::DVec3::new(v.x, v.y * c + v.z * s, v.z * c - v.y * s);
            // Entity.getEyePosition(partialTick).
    // rust: let feet = self.previous_position.lerp(p.position, alpha);
    // rust: let eye = glam::DVec3::new(feet.x, feet.y + f64::from(p.dimensions.eye_height), feet.z);
    // rust: return rot_y(v, -yaw) + eye;
}
    // rust: let yaw = f64::from(self.yaw.to_radians());
    // rust: let crouching = self.keys.held(Action::Sneak);
    // rust: let v = glam::DVec3::new(
    // rust: 0.22 * hand_dir,
    // rust: f64::from(p.dimensions.height) - 1.0,
    // rust: if crouching { -0.2 } else { 0.07 },
    // rust: );
    // rust: pos + rot_y(v, -yaw)
}
}

    // rust: mod rope_hold_tests {
//     use super::{
    // rust: Holder, Pending, Tag, held_by_acting_player, leash, resolve_pending_leash,
    // rust: rope_hold_angles, write_mob_leash_tag,
}
//     use horizon_client::lan::playerdata::uuid_ints;
//     use horizon_protocol::crypto::offline_uuid;

rope_hold_angles_lerp_by_half_the_partial_tick :: proc() {
}
        // Mth.lerp(pt * 0.5, yRot, yRotO): at pt 1 the view is halfway to the old one.
    // rust: let (y, x) = rope_hold_angles((90.0, 20.0), (50.0, 0.0), 1.0);
    // rust: assert!((y - 70.0_f64.to_radians()).abs() < 1e-6);
    // rust: assert!((x - 10.0_f64.to_radians()).abs() < 1e-6);
    // rust: let (y, _) = rope_hold_angles((90.0, 20.0), (50.0, 0.0), 0.0);
    // rust: assert!((y - 90.0_f64.to_radians()).abs() < 1e-6);
}

player_leash_survives_save_and_reopen_for_owner_and_guest :: proc() {
}
        // Integrated servers initialize `level.player_uuid` to `offline_uuid("Player")`,
        // while the single-player owner joins `hub.guests` under their actual profile UUID.
    // rust: let level_player_uuid = uuid_ints(offline_uuid("Player"));
    // rust: let owner_uuid = uuid_ints(offline_uuid("Player46606"));
    // rust: let guest_uuid = uuid_ints(offline_uuid("Alex"));

    // rust: for acting in [owner_uuid, guest_uuid] {
    // rust: let mut tag = Tag::Compound(Default::default());
    // rust: write_mob_leash_tag(
    // rust: &mut tag,
    // rust: Some(Holder::Player),
    // rust: None,
    // rust: Some(acting),
    // rust: Some(level_player_uuid),
    // rust: |_| [0; 4],
    // rust: );
    // rust: let pending = leash::pending_from_nbt(tag.get("leash")).expect("saved leash tag");
    // rust: assert_eq!(pending, Pending::Uuid(acting));

    // rust: let (holder, restored_player) = resolve_pending_leash(
    // rust: pending,
    // rust: level_player_uuid,
    // rust: Some(owner_uuid),
    // rust: |u| u == owner_uuid || u == guest_uuid,
    // rust: |_| None,
    // rust: |_| None,
    // rust: )
    // rust: .expect("restored player leash");
    // rust: assert_eq!(holder, Holder::Player);
    // rust: assert_eq!(restored_player, Some(acting));
    // rust: assert!(held_by_acting_player(Some(holder), restored_player, acting));
    // rust: let other = if acting == owner_uuid {
    // rust: guest_uuid
    // rust: } else {
    // rust: owner_uuid
}
    // rust: assert!(!held_by_acting_player(Some(holder), restored_player, other));
}
}

legacy_singleplayer_uuid_leash_restores_to_integrated_owner :: proc() {
}
    // rust: let level_player_uuid = uuid_ints(offline_uuid("Player"));
    // rust: let owner_uuid = uuid_ints(offline_uuid("Player46606"));

    // rust: let (holder, restored_player) = resolve_pending_leash(
    // rust: Pending::Uuid(level_player_uuid),
    // rust: level_player_uuid,
    // rust: Some(owner_uuid),
    // rust: |_| false,
    // rust: |_| None,
    // rust: |_| None,
    // rust: )
    // rust: .expect("restored legacy singleplayer leash");
    // rust: assert_eq!(holder, Holder::Player);
    // rust: assert_eq!(restored_player, Some(owner_uuid));
    // rust: assert!(held_by_acting_player(
    // rust: Some(holder),
    // rust: restored_player,
    // rust: owner_uuid
    // rust: ));
}

an_absent_players_uuid_is_not_reassigned_to_the_owner :: proc() {
}
    // rust: let owner = uuid_ints(offline_uuid("LeashOwner"));
    // rust: let absent = uuid_ints(offline_uuid("Alex"));
        // Even an imported world's player UUID is not evidence of ownership.
    // rust: for level in [uuid_ints(offline_uuid("Player")), absent] {
    // rust: assert!(
    // rust: resolve_pending_leash(
    // rust: Pending::Uuid(absent),
    // rust: level,
    // rust: Some(owner),
    // rust: |_| false,
    // rust: |_| None,
    // rust: |_| None,
    // rust: )
    // rust: .is_none()
    // rust: );
}
        // An entity with that UUID still resolves as an entity, not the owner.
    // rust: assert_eq!(
    // rust: resolve_pending_leash(
    // rust: Pending::Uuid(absent),
    // rust: absent,
    // rust: Some(owner),
    // rust: |_| false,
    // rust: |u| (u == absent).then_some(17),
    // rust: |_| None,
    // rust: ),
    // rust: Some((Holder::Mob(17), None))
    // rust: );
}

legacy_player_uuid_without_an_integrated_owner_stays_pending :: proc() {
}
    // rust: let legacy = uuid_ints(offline_uuid("Player"));
    // rust: assert!(
    // rust: resolve_pending_leash(
    // rust: Pending::Uuid(legacy),
    // rust: legacy,
    // rust: None,
    // rust: |_| false,
    // rust: |_| None,
    // rust: |_| None,
    // rust: )
    // rust: .is_none()
    // rust: );
}
}
