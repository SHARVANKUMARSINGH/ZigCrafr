//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_claimed_items
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A client mod's view and its own items (docs/native-mods.md, "A client mod's view and items"): the
//! first block along the view, across the distant terrain past the loaded chunks, and items whose
//! right-click is the mod's alone, heard as use events the mod polls.
// use super::Game;
// use std::collections::BTreeMap;

/// A stack as a client mod's use events carry it.
pub const NativeHeldItem = struct {
    id: []const u8,
    count: u32,
    /// The inventory slot: 0 to 8, the hotbar (a mod use is the main hand's).
    slot: u32,
    /// `minecraft:custom_name` as SNBT, when the stack has one.
    custom_name: ?[]const u8,
    /// `minecraft:custom_data` as SNBT, when the stack has some.
    custom_data: ?[]const u8,
};
/// The block a ray along the view meets.
pub const NativeHit = struct {
    block_x: i32,
    block_y: i32,
    block_z: i32,
    /// Where the ray meets the block.
    x: f64,
    y: f64,
    z: f64,
    /// The block's id (`minecraft:stone`).
    block: []const u8,
};
/// What happened to a mod's claimed item, oldest first.
pub const NativeModEvent = enum {
    /// A right-click with the item began its use: the stack, and 0 ticks.
    UseStart(NativeHeldItem, u32),
    /// The use ended: the stack it began with, and the ticks it was held. It
    /// ends when the button comes up, the hand's item changes or leaves the
    /// claim, the player respawns, or the game joins a server.
    UseStop(NativeHeldItem, u32),
};
/// The farthest a ray along the view reaches, in blocks.
    // rust: pub(crate) const RAYCAST_MAX: f32 = 1024.0;
/// The ids a mod may claim.
pub const CLAIMS_MAX: usize = 64;
/// Events kept for a mod between two polls.
pub const EVENTS_MAX: usize = 256;

/// A claimed item's use under way.
pub const ModUse = struct {
    mod_id: []const u8,
    item: NativeHeldItem,
    /// The player's `using` while it is this use: its slot and ticks.
    slot: usize,
    ticks: u32,
};

/// The items client mods claim, their events waiting for a poll, and the use under way.
    // rust: pub(super) struct ModInput {
    // rust: claims: BTreeMap<String, Vec<String>>,
    // rust: events: BTreeMap<String, Vec<NativeModEvent>>,
    // rust: using: Option<ModUse>,
}

    // rust: impl ModInput {
pub fn claim(self: *Self, mod_id: []const u8, ids: *[[]const u8]) void {
}
    // rust: let ids = ids.iter().take(CLAIMS_MAX).cloned().collect();
    // rust: self.claims.insert(mod_id.to_owned(), ids);
}
    /// The mod that claims `item`, the first in id order.
    // rust: pub(super) fn claimant(&self, item: &str) -> Option<&str> {
    // rust: self.claims
    // rust: .iter()
    // rust: .find(|(_, ids)| ids.iter().any(|i| i == item))
    // rust: .map(|(id, _)| id.as_str())
}
pub fn push(self: *Self, mod_id: []const u8, event: NativeModEvent) void {
}
    // rust: let events = self.events.entry(mod_id.to_owned()).or_default();
    // rust: if events.len() < EVENTS_MAX {
    // rust: events.push(event);
}
}
pub fn poll(self: *Self, mod_id: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.events.remove(mod_id).unwrap_or_default()
}
    /// Mod `mod_id`'s use of `item` in `slot` begins, ending any other first.
pub fn start(self: *Self, mod_id: []const u8, item: NativeHeldItem, slot: usize) void {
}
    // rust: self.end();
    // rust: self.push(mod_id, NativeModEvent::UseStart(item.clone(), 0));
    // rust: self.using = Some(ModUse {
    // rust: mod_id: mod_id.to_owned(),
    // rust: item,
    // rust: slot,
    // rust: ticks: 0,
    // rust: });
}
    /// Whether the player's use (`Game.using`) is the mod use under way. A
    /// use the game reset and another item's begun since are not.
pub fn owns(self: *Self, using: Option<(usize) void {
}
    // rust: self.using
    // rust: .as_ref()
    // rust: .is_some_and(|u| using == Some((u.slot, u.ticks)))
}
pub fn tick(self: *Self) void {
}
    // rust: if let Some(u) = &mut self.using {
    // rust: u.ticks += 1;
}
}
    /// The use under way ends: its mod hears `UseStop`.
pub fn end(self: *Self) void {
}
    // rust: if let Some(u) = self.using.take() {
    // rust: self.push(&u.mod_id, NativeModEvent::UseStop(u.item, u.ticks));
}
}
}

    // rust: impl Game<'_> {
    /// The stack in inventory slot `slot` as a mod's events carry it.
pub fn mod_held(self: *Self, slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stack = self.stack_in(slot)?;
    // rust: let extra = stack.extra.as_deref();
    // rust: Some(NativeHeldItem {
    // rust: id: stack.item.to_string(),
    // rust: count: stack.count,
    // rust: slot: slot as u32,
    // rust: custom_name: extra
    // rust: .and_then(|e| e.custom_name.as_ref())
    // rust: .map(horizon_client::snbt::to_snbt),
    // rust: custom_data: extra
    // rust: .and_then(|e| e.other("minecraft:custom_data"))
    // rust: .map(horizon_client::snbt::to_snbt),
    // rust: })
}
    /// The first block along the view within `distance` (at most 1024), past the loaded chunks over the distant terrain. API 116.
    // rust: pub(super) fn native_raycast(&self, distance: f32) -> Option<NativeHit> {
    // rust: let (d, hit) = self.native_view_hit()?;
    // rust: (d <= distance.clamp(0.0, RAYCAST_MAX)).then_some(hit)
}
    /// The first block along the view within `RAYCAST_MAX`, and its distance. API 116.
    // rust: pub(super) fn native_view_hit(&self) -> Option<(f32, NativeHit)> {
    // rust: self.player.as_ref()?;
    // rust: let eye = self.eye_position()?;
    // rust: let dir = super::view_vector(self.yaw, self.pitch);
    // rust: let reach = f64::from(RAYCAST_MAX);
    // rust: let (pos, point, state) = match self.clip_ray(eye, dir, reach) {
    // rust: Some(hit) => (
    // rust: hit.pos,
    // rust: hit.point,
    // rust: self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]),
    // rust: ),
    // rust: None => self.lod_ray(eye, dir, reach)?,
}
    // rust: let distance = (0..3)
    // rust: .map(|i| (point[i] - eye[i]).powi(2))
    // rust: .sum::<f64>()
    // rust: .sqrt();
    // rust: Some((
    // rust: distance as f32,
    // rust: NativeHit {
    // rust: block_x: pos[0],
    // rust: block_y: pos[1],
    // rust: block_z: pos[2],
    // rust: x: point[0],
    // rust: y: point[1],
    // rust: z: point[2],
    // rust: block: self.res.facts().get(state).name.to_string(),
    // rust: },
    // rust: ))
}
    /// A ray over the distant terrain (`Lod::ground`) past the loaded chunks, a block at a time.
    // rust: fn lod_ray(
    // rust: &self,
    // rust: eye: [f64; 3],
    // rust: dir: [f64; 3],
    // rust: reach: f64,
    // rust: ) -> Option<([i32; 3], [f64; 3], horizon_world::registry::BlockStateId)> {
    // rust: let lod = self.lod.as_ref()?;
    // rust: let mut t = 0.0;
    // rust: while t <= reach {
    // rust: let p = [
    // rust: eye[0] + dir[0] * t,
    // rust: eye[1] + dir[1] * t,
    // rust: eye[2] + dir[2] * t,
    // rust: ];
    // rust: let (x, z) = (p[0].floor() as i32, p[2].floor() as i32);
    // rust: if !self.world.loaded(x, z)
    // rust: && let Some((height, state)) = lod.ground(x, z)
    // rust: && p[1] <= f64::from(height)
    // rust: {
    // rust: return Some(([x, height - 1, z], [p[0], f64::from(height), p[2]], state));
}
    // rust: t += 1.0;
}
    // rust: None
}
    /// Right-clicks with these items (at most 64 ids) are mod `mod_id`'s; a later call replaces the list. API 116.
    // rust: pub(super) fn native_claim_items(&mut self, mod_id: &str, ids: &[String]) {
    // rust: self.native_input.claim(mod_id, ids);
}
    /// Mod `mod_id`'s events since its last poll (at most 256 wait). API 116.
    // rust: pub(super) fn native_poll(&mut self, mod_id: &str) -> Vec<NativeModEvent> {
    // rust: self.native_input.poll(mod_id)
}
    /// `use_hand`: a right-click with an item a mod claims starts its use for
    /// that mod and nothing else happens. True when a mod took it.
    // rust: pub(super) fn mod_use_start(&mut self) -> bool {
    // rust: if self.guest_use.is_some() || self.using.is_some() {
    // rust: return false;
}
        // With no use, a mod use the game reset without telling it is over.
    // rust: self.native_input.end();
    // rust: let slot = self.held_slot();
    // rust: let Some(item) = self.mod_held(slot) else {
    // rust: return false;
}
    // rust: let Some(id) = self.native_input.claimant(&item.id).map(str::to_owned) else {
    // rust: return false;
}
    // rust: self.native_input.start(&id, item, slot);
    // rust: self.using = Some((slot, 0));
    // rust: true
}
    /// `tick_used_item` for a claimed item: counts the ticks held and ends
    /// the use when the button comes up. True when the player's use is a
    /// mod's; a mod use the game reset ends, and the player's own use goes on.
    // rust: pub(super) fn mod_use_tick(&mut self, slot: usize, ticks: u32, released: bool) -> bool {
    // rust: if !self.native_input.owns(Some((slot, ticks))) {
    // rust: self.native_input.end();
    // rust: return false;
}
    // rust: let still_claimed = self.native_input.using.as_ref().is_some_and(|u| {
    // rust: self.stack_in(slot)
    // rust: .is_some_and(|s| self.native_input.claimant(&s.item) == Some(u.mod_id.as_str()))
    // rust: });
    // rust: if released || !still_claimed {
    // rust: self.native_input.end();
    // rust: self.using = None;
    // rust: } else {
    // rust: self.native_input.tick();
    // rust: self.using = Some((slot, ticks + 1));
}
    // rust: true
}
    /// The player's use was reset (a respawn, a join, the hand's item
    /// changed): a mod use under way ends and its mod hears `UseStop`.
    // rust: pub(super) fn end_mod_use(&mut self) {
    // rust: self.native_input.end();
}
}

    // rust: mod input_tests {
//     use super::*;

pub fn stick(slot: u32) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NativeHeldItem {
    // rust: id: "minecraft:stick".into(),
    // rust: count: 1,
    // rust: slot,
    // rust: custom_name: None,
    // rust: custom_data: Some("{orbital:1b}".into()),
}
}

pub fn items_are_claimed_by_the_first_mod_in_id_order() void {
}
    // rust: let mut input = ModInput::default();
    // rust: let ids = |v: &[&str]| v.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    // rust: input.claim("zeta", &ids(&["orbital:remote", "minecraft:stick"]));
    // rust: input.claim("alpha", &ids(&["minecraft:stick"]));
    // rust: assert_eq!(input.claimant("minecraft:stick"), Some("alpha"));
    // rust: assert_eq!(input.claimant("orbital:remote"), Some("zeta"));
    // rust: assert_eq!(input.claimant("minecraft:dirt"), None);
    // rust: input.claim("alpha", &[]);
    // rust: assert_eq!(input.claimant("minecraft:stick"), Some("zeta"));
    // rust: let many: Vec<String> = (0..100).map(|i| format!("m:item{i}")).collect();
    // rust: input.claim("alpha", &many);
    // rust: assert_eq!(input.claimant("m:item63"), Some("alpha"));
    // rust: assert_eq!(input.claimant("m:item64"), None, "64 at most");
}

pub fn events_wait_for_their_mod_up_to_a_limit() void {
}
    // rust: let mut input = ModInput::default();
    // rust: for _ in 0..EVENTS_MAX + 10 {
    // rust: input.push("a", NativeModEvent::UseStart(stick(0), 0));
}
    // rust: input.push("b", NativeModEvent::UseStop(stick(0), 3));
    // rust: assert_eq!(input.poll("a").len(), EVENTS_MAX);
    // rust: assert!(input.poll("a").is_empty());
    // rust: assert_eq!(input.poll("b"), vec![NativeModEvent::UseStop(stick(0), 3)]);
}

pub fn a_claimed_use_is_the_mods_while_it_runs() void {
}
    // rust: let mut input = ModInput::default();
    // rust: input.start("orbital", stick(2), 2);
    // rust: assert!(input.owns(Some((2, 0))));
    // rust: input.tick();
    // rust: input.tick();
    // rust: assert!(input.owns(Some((2, 2))));
    // rust: input.end();
    // rust: assert!(!input.owns(Some((2, 2))));
    // rust: assert_eq!(
    // rust: input.poll("orbital"),
    // rust: vec![
    // rust: NativeModEvent::UseStart(stick(2), 0),
    // rust: NativeModEvent::UseStop(stick(2), 2),
    // rust: ]
    // rust: );
}

pub fn an_interrupted_claimed_use_leaves_the_next_use_alone() void {
}
        // A respawn ends the use: the mod hears it stop, and a vanilla use
        // begun next in the same slot is not taken for the mod's.
    // rust: let mut input = ModInput::default();
    // rust: input.start("orbital", stick(0), 0);
    // rust: input.tick();
    // rust: input.end();
    // rust: assert!(!input.owns(Some((0, 0))));
    // rust: assert_eq!(
    // rust: input.poll("orbital").last(),
    // rust: Some(&NativeModEvent::UseStop(stick(0), 1))
    // rust: );
        // A reset the mod use never heard of (`Game.using` cleared alone):
        // the player's next use, from 0 ticks or in another slot, is still
        // not the mod's, and ending it then tells the mod once.
    // rust: input.start("orbital", stick(0), 0);
    // rust: input.tick();
    // rust: input.tick();
    // rust: assert!(!input.owns(None));
    // rust: assert!(!input.owns(Some((0, 0))), "a vanilla use from 0 ticks");
    // rust: assert!(!input.owns(Some((1, 2))), "another slot");
    // rust: input.end();
    // rust: input.end();
    // rust: let events = input.poll("orbital");
    // rust: assert_eq!(events.len(), 2);
    // rust: assert_eq!(events[1], NativeModEvent::UseStop(stick(0), 2));
}
}
