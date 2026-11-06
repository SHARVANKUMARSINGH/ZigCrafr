//! Transpiled from Horizon Rust crate
package horizon_client_native_entities

import "core:fmt"
import "core:mem"
import "core:math"

// Entities for native server mods (docs/native-mods.md, "Entities"): spawn
// any entity from its compound as `/summon` does, and move, show or remove
// the entities Horizon keeps without simulating them (displays, markers,
// interactions), which is what a mod needs for models that move: an
// `item_display` showing an item model from the mod's assets. They act where
// the world is simulated, in the level in place, which each names by its
// `dimension` (`minecraft:overworld`) as `native_set_block` does.
// use super::{
    // rust: Game,
    // rust: commands::{Target, place_summoned},
}
// use horizon_core::geometry::Vec3;
// use horizon_world::nbt::{Compound, Tag};

// A display's transformation and interpolation (`Display`'s
// `transformation`, `interpolation_duration` and `teleport_duration`):
// a translation, a left rotation (a quaternion `[x, y, z, w]`), a scale and a
// right rotation, eased over `interpolation` ticks from what it showed;
// `teleport` ticks ease a move (0 to 59).
    // rust: pub(super) struct NativeDisplay {
    // rust: pub translation: [f32; 3],
    // rust: pub left_rotation: [f32; 4],
    // rust: pub scale: [f32; 3],
    // rust: pub right_rotation: [f32; 4],
    // rust: pub interpolation: i32,
    // rust: pub teleport: i32,
}

    // rust: impl Default for NativeDisplay {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: translation: [0.0; 3],
    // rust: left_rotation: [0.0, 0.0, 0.0, 1.0],
    // rust: scale: [1.0; 3],
    // rust: right_rotation: [0.0, 0.0, 0.0, 1.0],
    // rust: interpolation: 0,
    // rust: teleport: 0,
}
}
}

    // rust: impl NativeDisplay {
    // Whether every value is finite, the quaternions aren't zero and the
    // durations are in range.
valid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let finite = |v: &[f32]| v.iter().all(|x| x.is_finite());
    // rust: let unit = |q: &[f32; 4]| q.iter().map(|x| x * x).sum::<f32>() > 1.0e-12;
    // rust: finite(&self.translation)
    // rust: && finite(&self.left_rotation)
    // rust: && finite(&self.scale)
    // rust: && finite(&self.right_rotation)
    // rust: && unit(&self.left_rotation)
    // rust: && unit(&self.right_rotation)
    // rust: && (0..=1_000_000).contains(&self.interpolation)
    // rust: && (0..=59).contains(&self.teleport)
}
    // Writes its keys into a display's compound. `start` is the
    // interpolation's start delay: entity data reaches clients only when it
    // changes (as vanilla's does unless forced), and a display restarts its
    // interpolation only when the start comes, so each write flips it
    // between 0 and -1.
write :: proc(self: ^Self, tag: ^Compound) {
}
    // rust: let floats = |v: &[f32]| Tag::List(v.iter().map(|x| Tag::Float(x.to_bits())).collect());
    // rust: let mut t = Compound::new();
    // rust: t.insert("translation".into(), floats(&self.translation));
    // rust: t.insert("left_rotation".into(), floats(&self.left_rotation));
    // rust: t.insert("scale".into(), floats(&self.scale));
    // rust: t.insert("right_rotation".into(), floats(&self.right_rotation));
    // rust: tag.insert("transformation".into(), Tag::Compound(t));
    // rust: tag.insert(
    // rust: "interpolation_duration".into(),
    // rust: Tag::Int(self.interpolation),
    // rust: );
    // rust: tag.insert("teleport_duration".into(), Tag::Int(self.teleport));
    // rust: let start = match tag.get(&"start_interpolation".into()) {
    // rust: Some(Tag::Int(0)) => -1,
    // rust: _ => 0,
}
    // rust: tag.insert("start_interpolation".into(), Tag::Int(start));
}
}

// Whether a position is one `/summon` takes.
position_ok :: proc(pos: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: pos.iter().all(|v| v.is_finite())
    // rust: && pos[0].abs() < 30_000_000.0
    // rust: && pos[2].abs() < 30_000_000.0
    // rust: && (-20_000_000.0..20_000_000.0).contains(&pos[1])
}

// The id of a summoned stack's root: its command target's, else `first`,
// the first id handed out, when an entity no command target stands for
// (`live`) holds it.
root_id :: proc(target: Maybe(Target), first: u32, live: impl Fn(u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match target {
    // rust: Some(t) => target_id(t),
    // rust: None => live(first).then_some(first),
}
}

// The entity id a summoned stack's root is known by.
target_id :: proc(t: Target) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Target::Mob(id)
    // rust: | Target::Item(id)
    // rust: | Target::Orb(id)
    // rust: | Target::Projectile(id)
    // rust: | Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Painting(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id)
    // rust: | Target::Crystal(id)
    // rust: | Target::Dragon(id)
    // rust: | Target::Tnt(id)
    // rust: | Target::Falling(id)
    // rust: | Target::Rocket(id)
    // rust: | Target::Trident(id)
    // rust: | Target::Spawner(id)
    // rust: | Target::Cloud(id) => Some(id),
    // rust: Target::Player | Target::Guest(_) => None,
}
}

    // rust: impl Game<'_> {
    // Whether this game simulates the level `dimension`.
native_simulates_level :: proc(self: ^Self, dimension: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (self.serving.is_some() || self.options.dedicated.is_some()) && dimension == self.dim.id()
}
    // Spawns an entity of `kind` (`minecraft:item_display`) at `pos` in the
    // level in place, `dimension`, from `nbt` (its compound, as `/summon
    // <kind> <pos> <nbt>` takes it; passengers included): its id. None on a
    // client's copy of the world, for another dimension, a position outside
    // `/summon`'s bounds, a chunk that isn't loaded, a kind Horizon can't
    // load, or one a mod kept out (`native_entity_join_level`). API
    // 59.
    // rust: pub(super) fn native_summon(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: kind: &str,
    // rust: pos: [f64; 3],
    // rust: nbt: Compound,
    // rust: ) -> Option<u32> {
    // rust: if !self.native_simulates_level(dimension) || !position_ok(pos) {
    // rust: return None;
}
    // rust: let chunk = ((pos[0].floor() as i32) >> 4, (pos[2].floor() as i32) >> 4);
    // rust: if !self.world.chunks.contains_key(&chunk) {
    // rust: return None;
}
    // rust: let mut tag = nbt;
    // rust: tag.insert("id".into(), Tag::String(kind.into()));
        // As `/summon` does: every entity of the stack, passengers included,
        // stands at `pos`.
    // rust: let mut tag = Tag::Compound(tag);
    // rust: place_summoned(&mut tag, pos);
    // rust: let from = self.mobs.len();
    // rust: let first = self.next_entity + 1;
    // rust: let deferred = (self.tnts.len(), self.falling.len(), self.rockets.len());
    // rust: let target = self.spawn_entity_from_nbt(tag);
        // These roots take their id as they load, and a rocket has no command
        // Target variant. Select the newly appended root, never an older waiting entity.
    // rust: let root = match kind {
    // rust: "minecraft:tnt" => self.tnts.get_mut(deferred.0).map(|e| &mut e.id),
    // rust: "minecraft:falling_block" => self.falling.get_mut(deferred.1).map(|e| &mut e.id),
    // rust: "minecraft:firework_rocket" => self.rockets.get_mut(deferred.2).map(|e| &mut e.id),
    // rust: _ => None,
}
    // rust: let root = root.map(|id| super::lan_entities::assign_entity_id(&mut self.next_entity, id));
    // rust: self.native_mobs_joined(from, false);
        // Otherwise the root is the first entity spawned, also for kinds no
        // command target stands for (experience orbs, end crystals, cushions). An id handed out to an
        // entity a mod then kept out is not given back, so the root must be
        // there.
    // rust: root.or_else(|| {
    // rust: root_id(target, first, |id| {
    // rust: self.orbs.iter().any(|o| o.id == id)
    // rust: || self.crystals.iter().any(|c| c.id == id)
    // rust: || self.cushions.iter().any(|c| c.id == id)
    // rust: })
    // rust: })
}
    // Moves entity `id`, one Horizon keeps without simulating (a display, a
    // marker, an interaction), to `pos` facing `yaw` and `pitch` in degrees;
    // a display eases there over its `teleport` ticks. False for no such
    // entity, another dimension or a position outside `/summon`'s bounds.
    // Mobs move with `native_teleport_mob`. API 59.
    // rust: pub(super) fn native_move_entity(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: id: u32,
    // rust: pos: [f64; 3],
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: ) -> bool {
    // rust: if !self.native_simulates_level(dimension)
    // rust: || !position_ok(pos)
    // rust: || !yaw.is_finite()
    // rust: || !pitch.is_finite()
    // rust: {
    // rust: return false;
}
    // rust: let Some(o) = self.others.iter_mut().find(|o| o.id == id) else {
    // rust: return false;
}
    // rust: o.position = Vec3::new(pos[0], pos[1], pos[2]);
    // rust: o.yaw = yaw.rem_euclid(360.0);
    // rust: o.pitch = pitch.clamp(-90.0, 90.0);
    // rust: true
}
    // Sets the transformation and interpolation of display `id` (a
    // `block_display`, `item_display` or `text_display`): players see it
    // ease from what it showed over `interpolation` ticks. False for no such
    // display, another dimension, or a value that isn't finite, a zero
    // quaternion, or a duration out of range. API 59.
    // rust: pub(super) fn native_set_display(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: id: u32,
    // rust: display: &NativeDisplay,
    // rust: ) -> bool {
    // rust: if !self.native_simulates_level(dimension) || !display.valid() {
    // rust: return false;
}
    // rust: let is_display = self.others.iter().any(|o| {
    // rust: o.id == id
    // rust: && matches!(
    // rust: o.kind.as_str(),
    // rust: "minecraft:block_display" | "minecraft:item_display" | "minecraft:text_display"
    // rust: )
    // rust: });
    // rust: if !is_display {
    // rust: return false;
}
    // rust: let tag = self
    // rust: .persist
    // rust: .raw
    // rust: .entry(id)
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: let Tag::Compound(c) = tag else {
    // rust: return false;
}
    // rust: display.write(c);
    // rust: true
}
    // Removes entity `id`, one Horizon keeps without simulating, as `/kill`
    // does (it drops nothing and isn't saved). False for no such entity or
    // another dimension. Mobs go with `native_remove_mob`. API
    // 59.
    // rust: pub(super) fn native_remove_entity(&mut self, dimension: &str, id: u32) -> bool {
    // rust: if !self.native_simulates_level(dimension) || !self.others.iter().any(|o| o.id == id) {
    // rust: return false;
}
    // rust: self.others.retain(|o| o.id != id);
    // rust: self.persist.raw.remove(&id);
    // rust: true
}
}

// The entities the walk does not hold: Horizon keeps these in lists of their own.
Apart :: enum {
    Crystal(usize),
    Cushion(usize),
    Painting(usize),
    Frame(usize),
    Dragon,
}

// One entity a mod is told of: in the walk, or apart from it.
Slot :: enum {
    Walk(super::entity::EntityHandle),
    Apart(Apart),
}

// Entities joining and leaving the level (`native_entity_join_level`,
// `native_entity_leave_level`), for every kind in the entity walk and the
// five kept apart from it. Kept out of `native_hooks.rs`, whose lines may not hold macros.
    // rust: impl Game<'_> {
    // Whether an entity may be waiting to be told of: one with an id above
    // the last announced, or one of the kinds that take their id late and
    // have none. Reads a counter and five lists' ids; no walk.
joins_pending :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.next_entity > self.persist.joined_mark
    // rust: || self.tnts.iter().any(|t| t.id == 0)
    // rust: || self.falling.iter().any(|f| f.id == 0)
    // rust: || self.creatures.projectiles.iter().any(|p| p.id == 0)
    // rust: || self.tridents.iter().any(|t| t.id == 0)
    // rust: || self.rockets.iter().any(|r| r.id == 0)
}
    // Tells `native_entity_join_level` once for every entity added since the
    // last call, of any kind, in the order they were created (ids count up
    // from one counter). A mod that cancels takes the entity back out here,
    // before it ticks again, and `/summon` of it fails (`joins_canceled`).
    // `loaded_from_disk` is for the entities that came with a chunk. Returns
    // whether `watch` (an id, or 0) is still in the level. Walks the lists
    // with static dispatch and allocates nothing but the kind name of an
    // entity it announces; nothing runs when no mod is loaded, on a client
    // of a server (which tells nothing), or when nothing is new.
    // rust: pub(super) fn native_joins_flush(&mut self, loaded_from_disk: bool, watch: u32) -> bool {
    // rust: if self.remote.is_some() || crate::mod_api::mods().is_empty() || !self.joins_pending() {
    // rust: return true;
}
    // rust: for t in &mut self.tnts {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut t.id);
}
    // rust: for f in &mut self.falling {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut f.id);
}
    // rust: for p in &mut self.creatures.projectiles {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut p.id);
}
    // rust: for t in &mut self.tridents {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut t.id);
}
    // rust: for r in &mut self.rockets {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut r.id);
}
    // rust: let mut kept = true;
    // rust: while let Some((slot, id)) = self.next_unannounced() {
    // rust: self.persist.joined_mark = id;
    // rust: let (kind, at) = self.slot_kind_and_position(slot);
    // rust: let mut canceled = false;
    // rust: let dimension = self.dim.id();
    // rust: self.native_entity_join_level(
    // rust: dimension,
    // rust: id,
    // rust: &kind,
    // rust: [at.x, at.y, at.z],
    // rust: loaded_from_disk,
    // rust: &mut canceled,
    // rust: );
    // rust: if canceled {
    // rust: self.persist.joins_canceled += 1;
    // rust: self.forget_entity(id);
                // Handles are indexes: the entity is taken out before any
                // other change to its list.
    // rust: self.discard_slot(slot);
    // rust: kept &= id != watch;
    // rust: } else {
    // rust: self.persist.live.push((id, kind.into_owned(), true));
}
}
        // Ids taken and never announced (the dragon's parts, another level's
        // entities) must not keep the next flush walking.
    // rust: self.persist.joined_mark = self.persist.joined_mark.max(self.next_entity);
    // rust: kept
}
    // The entity with the lowest id above the last one announced.
next_unannounced :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use super::entity::Entity;
    // rust: let mark = self.persist.joined_mark;
    // rust: let mut best: Option<(Slot, u32)> = None;
    // rust: let mut offer = |slot: Slot, id: u32| {
    // rust: if id > mark && best.is_none_or(|(_, b)| id < b) {
    // rust: best = Some((slot, id));
}
}
    // rust: for handle in self.entity_handles() {
    // rust: offer(
    // rust: Slot::Walk(handle),
    // rust: super::entity::with_entity!(self, handle, e => e.id()),
    // rust: );
}
    // rust: for (i, c) in self.crystals.iter().enumerate() {
    // rust: offer(Slot::Apart(Apart::Crystal(i)), c.id);
}
    // rust: for (i, c) in self.cushions.iter().enumerate() {
    // rust: offer(Slot::Apart(Apart::Cushion(i)), c.id);
}
    // rust: for (i, p) in self.paintings.iter().enumerate() {
    // rust: offer(Slot::Apart(Apart::Painting(i)), p.id);
}
    // rust: for (i, f) in self.item_frames.iter().enumerate() {
    // rust: offer(Slot::Apart(Apart::Frame(i)), f.id);
}
    // rust: if let Some(d) = &self.dragon {
    // rust: offer(Slot::Apart(Apart::Dragon), d.id);
}
    // rust: best
}
    // The type id and position a mod is told of.
slot_kind_and_position :: proc(self: ^Self, slot: Slot) -> ( {
    // Ported from Horizon
    return {}
}
//         use super::entity::Entity;
    // rust: let block = |p: [i32; 3]| {
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: )
}
    // rust: match slot {
    // rust: Slot::Walk(h) => {
    // rust: super::entity::with_entity!(self, h, e => (e.native_type(), e.position()))
}
    // rust: Slot::Apart(Apart::Crystal(i)) => {
    // rust: ("minecraft:end_crystal".into(), self.crystals[i].position)
}
    // rust: Slot::Apart(Apart::Cushion(i)) => {
    // rust: ("minecraft:cushion".into(), self.cushions[i].position)
}
    // rust: Slot::Apart(Apart::Painting(i)) => {
    // rust: ("minecraft:painting".into(), block(self.paintings[i].pos))
}
    // rust: Slot::Apart(Apart::Frame(i)) => {
    // rust: let f = &self.item_frames[i];
    // rust: let kind = if f.glow {
    // rust: "minecraft:glow_item_frame"
    // rust: } else {
    // rust: "minecraft:item_frame"
}
    // rust: (kind.into(), block(f.pos))
}
    // rust: Slot::Apart(Apart::Dragon) => (
    // rust: "minecraft:ender_dragon".into(),
    // rust: self.dragon.as_ref().map_or(Vec3::ZERO, |d| d.position),
    // rust: ),
}
}
    // Takes the entity out of the level, before it ever ticked.
discard_slot :: proc(self: ^Self, slot: Slot) {
}
    // rust: match slot {
    // rust: Slot::Walk(h) => self.discard_entity(h),
    // rust: Slot::Apart(Apart::Crystal(i)) => drop(self.crystals.remove(i)),
    // rust: Slot::Apart(Apart::Cushion(i)) => drop(self.cushions.remove(i)),
    // rust: Slot::Apart(Apart::Painting(i)) => drop(self.paintings.remove(i)),
    // rust: Slot::Apart(Apart::Frame(i)) => drop(self.item_frames.remove(i)),
    // rust: Slot::Apart(Apart::Dragon) => self.dragon = None,
}
}
    // Entities that were moved, not added (a portal's arrival keeps being
    // silent): everything now in the level counts as announced, and will
    // be told when it leaves.
    // rust: pub(super) fn native_joins_skip(&mut self) {
    // rust: if self.remote.is_none() && !crate::mod_api::mods().is_empty() {
    // rust: while let Some((slot, id)) = self.next_unannounced() {
    // rust: self.persist.joined_mark = id;
    // rust: let kind = self.slot_kind_and_position(slot).0.into_owned();
    // rust: self.persist.live.push((id, kind, true));
}
}
    // rust: self.persist.joined_mark = self.persist.joined_mark.max(self.next_entity);
}
    // An entity taken out of the level without leaving it (an item through
    // an End gateway): forgotten, not told of.
    // rust: pub(super) fn native_leave_skip(&mut self, id: u32) {
    // rust: if let Ok(i) = self.persist.live.binary_search_by_key(&id, |l| l.0) {
    // rust: self.persist.live.remove(i);
}
}
    // Entity `id` has left the level: told once, if mods were told it joined.
    // rust: pub(super) fn native_entity_left(&mut self, id: u32) {
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: if let Ok(i) = self.persist.live.binary_search_by_key(&id, |l| l.0) {
    // rust: let (id, kind, _) = self.persist.live.remove(i);
    // rust: let dimension = self.dim.id();
    // rust: self.native_entity_leave_level(dimension, id, &kind);
}
}
    // Tells `native_entity_leave_level` for every announced entity that is
    // no longer in any list (died, despawned, picked up, burnt, blown up, gone
    // through a portal, unloaded), lowest id first. Marks the entities still
    // there in the registry and tells the rest: no allocation, and nothing
    // runs when no mod is loaded or none was announced.
    // rust: pub(super) fn native_leaves_flush(&mut self) {
//         use super::entity::Entity;
    // rust: if self.persist.live.is_empty() || self.remote.is_some() {
    // rust: return;
}
    // rust: for l in &mut self.persist.live {
    // rust: l.2 = false;
}
    // rust: let live = &mut self.persist.live;
    // rust: let mut seen = |id: u32| {
    // rust: if let Ok(i) = live.binary_search_by_key(&id, |l| l.0) {
    // rust: live[i].2 = true;
}
}
    // rust: super::entity::for_each_entity!(super::entity::entity_lists_of!(self), e => {
    // rust: seen(e.id());
    // rust: });
    // rust: self.crystals.iter().for_each(|c| seen(c.id));
    // rust: self.cushions.iter().for_each(|c| seen(c.id));
    // rust: self.paintings.iter().for_each(|p| seen(p.id));
    // rust: self.item_frames.iter().for_each(|f| seen(f.id));
    // rust: if let Some(d) = &self.dragon {
    // rust: seen(d.id);
}
    // rust: while let Some(i) = self.persist.live.iter().position(|l| !l.2) {
    // rust: let (id, kind, _) = self.persist.live.remove(i);
    // rust: let dimension = self.dim.id();
    // rust: self.native_entity_leave_level(dimension, id, &kind);
}
}
}

    // rust: mod tests {
//     use super::*;

a_display_write_flips_the_start_so_clients_restart_the_ease :: proc() {
}
    // rust: let display = NativeDisplay {
    // rust: translation: [0.0, 1.5, 0.0],
    // rust: scale: [2.0; 3],
    // rust: interpolation: 10,
    // rust: ..NativeDisplay::default()
}
    // rust: assert!(display.valid());
    // rust: let mut tag = Compound::new();
    // rust: display.write(&mut tag);
    // rust: assert_eq!(tag.get(&"start_interpolation".into()), Some(&Tag::Int(0)));
    // rust: assert_eq!(
    // rust: tag.get(&"interpolation_duration".into()),
    // rust: Some(&Tag::Int(10))
    // rust: );
    // rust: display.write(&mut tag);
    // rust: assert_eq!(tag.get(&"start_interpolation".into()), Some(&Tag::Int(-1)));
    // rust: display.write(&mut tag);
    // rust: assert_eq!(tag.get(&"start_interpolation".into()), Some(&Tag::Int(0)));
    // rust: let Some(Tag::Compound(t)) = tag.get(&"transformation".into()) else {
    // rust: panic!("no transformation");
}
    // rust: assert_eq!(
    // rust: t.get(&"scale".into()),
    // rust: Some(&Tag::List(vec![Tag::Float(2.0f32.to_bits()); 3]))
    // rust: );
}

a_display_refuses_values_it_cant_show :: proc() {
}
    // rust: let ok = NativeDisplay::default();
    // rust: assert!(ok.valid());
    // rust: assert!(
    // rust: !NativeDisplay {
    // rust: scale: [f32::NAN, 1.0, 1.0],
    // rust: ..ok
}
    // rust: .valid()
    // rust: );
    // rust: assert!(
    // rust: !NativeDisplay {
    // rust: left_rotation: [0.0; 4],
    // rust: ..ok
}
    // rust: .valid()
    // rust: );
    // rust: assert!(!NativeDisplay { teleport: 60, ..ok }.valid());
    // rust: assert!(
    // rust: !NativeDisplay {
    // rust: interpolation: -1,
    // rust: ..ok
}
    // rust: .valid()
    // rust: );
}

a_passenger_without_a_position_stands_where_the_stack_is_summoned :: proc() {
}
    // rust: let mut rider = Compound::new();
    // rust: rider.insert("id".into(), Tag::String("minecraft:pig".into()));
    // rust: let mut root = Compound::new();
    // rust: root.insert("id".into(), Tag::String("minecraft:pig".into()));
    // rust: root.insert("Passengers".into(), Tag::List(vec![Tag::Compound(rider)]));
    // rust: let mut tag = Tag::Compound(root);
    // rust: place_summoned(&mut tag, [1.5, 70.0, -2.5]);
    // rust: let pos = Tag::List(
    // rust: [1.5, 70.0, -2.5]
    // rust: .map(|v: f64| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: );
    // rust: let Tag::Compound(root) = &tag else { panic!() };
    // rust: assert_eq!(root.get(&"Pos".into()), Some(&pos));
    // rust: let Some(Tag::List(riders)) = root.get(&"Passengers".into()) else {
    // rust: panic!("no passengers");
}
    // rust: let Tag::Compound(rider) = &riders[0] else {
    // rust: panic!()
}
    // rust: assert_eq!(rider.get(&"Pos".into()), Some(&pos));
}

an_orb_root_has_an_id_only_while_it_is_in_the_level :: proc() {
}
        // Spawned: the orb holds the first id.
    // rust: assert_eq!(root_id(None, 36, |id| id == 36), Some(36));
        // A mod kept it out: id 36 was handed out, but no entity holds it.
    // rust: assert_eq!(root_id(None, 36, |_| false), None);
        // A command target answers for itself.
    // rust: assert_eq!(root_id(Some(Target::Mob(40)), 36, |_| false), Some(40));
    // rust: assert_eq!(root_id(Some(Target::Player), 36, |_| true), None);
}

summon_positions_are_summons :: proc() {
}
    // rust: assert!(position_ok([0.5, 64.0, 0.5]));
    // rust: assert!(!position_ok([3.0e7, 64.0, 0.5]));
    // rust: assert!(!position_ok([0.5, f64::NAN, 0.5]));
}
}
