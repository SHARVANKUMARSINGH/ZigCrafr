//! Transpiled from Horizon Rust crate
package horizon_client_transport_items

import "core:fmt"
import "core:mem"
import "core:math"

// `TransportItemsBetweenContainers` as the copper golem's brain runs it
// (`CopperGolemAi`): find the nearest wanted chest (a copper chest with
// nothing in hand, a chest or trapped chest holding something), walk to it,
// queue while another golem has it open, open it for 60 ticks and take up
// to 16 items or put the carried stack down, remembering visited and
// unreachable chests.
//
// The chests are read from the world; what changes them comes out as
// [`MobEvent::ChestOpen`] and [`MobEvent::ChestSlot`] for the host to apply
// before the next mob ticks.
// use super::{
    // rust: Mob, MobEvent, MobWorld,
    // rust: animal_brain::{Bx, Tracker, WalkTarget, mem, mem_ref},
    // rust: copper_golem as cg,
}
// use crate::{containers::BlockEntity, items::ItemStack};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}
// use horizon_world::java_hash_map::{JavaHashMap, JavaKey};

// `TransportItemState`.
State :: enum {
    Travelling,
    Queuing,
    Interacting,
}
// `ContainerInteractionState`.
Interaction :: enum {
    PickupItem,
    PickupNoItem,
    PlaceItem,
    PlaceNoItem,
}

// `TransportItemTarget`: the chest and its block state when it was chosen.
Target :: struct {
    pos: [i32,
    name: string,
    // The halves of the container in slot order (the right half first).
    halves: Vec<[i32,
}

    // rust: pub(super) struct Transport {
    // rust: pub(super) running: bool,
    // rust: end: i64,
    // rust: target: Option<Target>,
    // rust: state: State,
    // rust: interaction: Option<Interaction>,
    // rust: ticks: i32,
}
    // rust: impl Default for Transport {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: running: false,
    // rust: end: 0,
    // rust: target: None,
    // rust: state: State::Travelling,
    // rust: interaction: None,
    // rust: ticks: 0,
}
}
}

// The golem's held stack (`getMainHandItem`).
held :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.items.first().and_then(Option::as_ref)
}
// `setItemSlot(MAINHAND, ..)`, keeping the rendered copy in step.
set_held :: proc(m: ^Mob, stack: Maybe(ItemStack)) {
}
    // rust: let stack = stack.filter(|s| s.count > 0);
    // rust: m.extra.set_main_hand_stack(stack.clone());
    // rust: m.extra.ints[1] = stack.as_ref().map_or(0, |s| s.count as i32);
    // rust: if m.extra.items.is_empty() {
    // rust: m.extra.items.push(None);
}
    // rust: m.extra.items[0] = stack;
}

name_at :: proc(w: ^MobWorld, p: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: w.facts
    // rust: .get(w.world.block(p[0], p[1], p[2]))
    // rust: .name
    // rust: .to_string()
}
is_chest_block :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(name, "minecraft:chest" | "minecraft:trapped_chest") || name.ends_with("copper_chest")
}
// `CopperGolemAi.TRANSPORT_ITEM_SOURCE_BLOCK` / `_DESTINATION_BLOCK`.
wanted :: proc(w: ^MobWorld, m: ^Mob, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if held(m).is_none() {
    // rust: w.has_tag("minecraft:copper_chests", name) || w.has_tag("copper_chests", name)
    // rust: } else {
    // rust: matches!(name, "minecraft:chest" | "minecraft:trapped_chest")
}
}
// `ChestBlock.getConnectedBlockPos`: the other half of a double chest.
connected :: proc(w: ^MobWorld, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = w.prop(p[0], p[1], p[2], "type")?;
    // rust: if kind == "single" {
    // rust: return None;
}
    // rust: let facing = w.prop(p[0], p[1], p[2], "facing")?;
    // LEFT: facing.getClockWise(), else getCounterClockWise().
    // rust: let order = ["north", "east", "south", "west"];
    // rust: let i = order.iter().position(|f| *f == facing)?;
    // rust: let dir = order[if kind == "left" {
    // rust: (i + 1) % 4
    // rust: } else {
    // rust: (i + 3) % 4
    // rust: }];
    // rust: let (dx, dz) = match dir {
    // rust: "north" => (0, -1),
    // rust: "south" => (0, 1),
    // rust: "east" => (1, 0),
    // rust: _ => (-1, 0),
}
    // rust: Some([p[0] + dx, p[1], p[2] + dz])
}
// `ChestBlock.isChestBlockedAt` (a cat sitting on it aside): a redstone
// conductor above.
blocked :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let above = w.world.block(p[0], p[1] + 1, p[2]);
    // rust: w.data.state(above).flags & super::data::REDSTONE_CONDUCTOR != 0
}
// `ChestBlock.getContainer(.., false)`: the chest's halves in slot order,
// none when either half is blocked.
container :: proc(w: ^MobWorld, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if blocked(w, p) {
    // rust: return None;
}
    // rust: let mut halves = vec![p];
    // rust: if let Some(other) = connected(w, p) {
    // rust: let same = w.world.block(other[0], other[1], other[2]) == w.world.block(p[0], p[1], p[2])
    // rust: || name_at(w, other) == name_at(w, p)
    // rust: && w.prop(other[0], other[1], other[2], "facing")
    // rust: == w.prop(p[0], p[1], p[2], "facing")
    // rust: && w.prop(other[0], other[1], other[2], "type")
    // rust: .is_some_and(|t| t != "single")
    // rust: && w.prop(other[0], other[1], other[2], "type") != w.prop(p[0], p[1], p[2], "type");
    // rust: if same
    // rust: && matches!(
    // rust: w.world.block_entities.get(&(other[0], other[1], other[2])),
    // rust: Some(BlockEntity::Chest(_))
    // rust: )
    // rust: {
    // rust: if blocked(w, other) {
    // rust: return None;
}
    // rust: if w.prop(p[0], p[1], p[2], "type") == Some("right") {
    // rust: halves.push(other);
    // rust: } else {
    // rust: halves.insert(0, other);
}
}
}
    // rust: Some(halves)
}
slots :: proc(w: ^MobWorld, halves: ^[[i32; 3]]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: halves
    // rust: .iter()
    // rust: .filter_map(|h| w.world.block_entities.get(&(h[0], h[1], h[2])))
    // rust: .flat_map(|e| e.slots().to_vec())
    // rust: .collect()
}
// Where slot `n` of the container is: the half and its own slot.
slot_at :: proc(w: ^MobWorld, halves: ^[[i32; 3]], mut n: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: for h in halves {
    // rust: let len = w
    // rust: .world
    // rust: .block_entities
    // rust: .get(&(h[0], h[1], h[2]))?
    // rust: .slots()
    // rust: .len();
    // rust: if n < len {
    // rust: return Some((*h, n));
}
    // rust: n -= len;
}
    // rust: None
}
max_stack :: proc(w: ^MobWorld, s: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: w.items
    // rust: .and_then(|i| i.get(&s.item))
    // rust: .map_or(64, |i| i.max_stack)
    // rust: .max(1)
}

// `BlockPos` keys in a chunk's block entity map.
PosKey :: struct {
    // rust: impl JavaKey for PosKey {
java_hash :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
        // Vec3i.hashCode.
    // rust: (self.0[1].wrapping_add(self.0[2].wrapping_mul(31)))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(self.0[0])
}
tie_break :: proc(self: ^Self, _: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: std::cmp::Ordering::Less
}
}

// `AABB.ofSize(center, ..)` of the mob's box, and whether the chest's
// collision box grown by `distance` (and 0.5 up and down) reaches it.
within :: proc(w: ^MobWorld, m: ^Mob, distance: f64, t: ^Target, from: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let size = m.bounds().size();
    // rust: let moved = Aabb::new(
    // rust: Vec3::new(
    // rust: from[0] - size.x / 2.0,
    // rust: from[1] - size.y / 2.0,
    // rust: from[2] - size.z / 2.0,
    // rust: ),
    // rust: Vec3::new(
    // rust: from[0] + size.x / 2.0,
    // rust: from[1] + size.y / 2.0,
    // rust: from[2] + size.z / 2.0,
    // rust: ),
    // rust: );
    // getCollisionShape of the state the target was chosen with: the block
    // there now (the target is dropped once it changes).
    // rust: let Some(shape) = w.collision_bounds(t.pos) else {
    // rust: return false;
}
    // rust: let p = Vec3::new(
    // rust: f64::from(t.pos[0]),
    // rust: f64::from(t.pos[1]),
    // rust: f64::from(t.pos[2]),
    // rust: );
    // rust: shape
    // rust: .inflate(Vec3::new(distance, 0.5, distance))
    // rust: .move_by(p)
    // rust: .intersects(moved)
}
center :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: m.position.x,
    // rust: m.position.y + m.bounds().size().y / 2.0,
    // rust: m.position.z,
    // rust: ]
}
finished_path :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.nav.path.as_ref().is_some_and(|p| p.is_done())
}
// `getInteractionRange`.
range :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if finished_path(m) { 1.0 } else { 0.5 }
}
// `stopInPlace`.
stop_in_place :: proc(m: ^Mob) {
}
    // rust: m.nav_stop();
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.yya = 0.0;
    // rust: m.ai.speed = 0.0;
    // rust: m.velocity.x = 0.0;
    // rust: m.velocity.z = 0.0;
}
// `ContainerOpenersCounter.getEntitiesWithContainerOpen`: the golems with
// either half of the chest open, within the counter's interaction range
// plus 4.
openers :: proc(w: ^MobWorld, m: ^Mob, p: [i32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let area = opener_area(w, p);
    // rust: let me = usize::from(has_open(w, m, p));
    // rust: me + w
    // rust: .others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.id != m.id && s.alive && holds(w, s.opened_chest, p) && s.bounds.intersects(area)
    // rust: })
    // rust: .count()
}
// `CopperGolem.hasContainerOpen`: its opened chest is `p` or `p`'s other half.
holds :: proc(w: ^MobWorld, opened: Maybe([i32; 3]), p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: opened.is_some_and(|o| o == p || connected(w, o) == Some(p))
}
// Whether the counter at `p` lists this golem.
has_open :: proc(w: ^MobWorld, m: ^Mob, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: holds(w, m.extra.opened_chest, p) && m.bounds().intersects(opener_area(w, p))
}
opener_area :: proc(w: ^MobWorld, p: [i32; 3]) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let range = w
    // rust: .world
    // rust: .chest_openers
    // rust: .get(&(p[0], p[1], p[2]))
    // rust: .map_or(0.0, |o| o.1)
    // rust: + 4.0;
    // rust: Aabb::new(
    // rust: Vec3::new(
    // rust: f64::from(p[0]) - range,
    // rust: f64::from(p[1]) - range,
    // rust: f64::from(p[2]) - range,
    // rust: ),
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 1.0 + range,
    // rust: f64::from(p[1]) + 1.0 + range,
    // rust: f64::from(p[2]) + 1.0 + range,
    // rust: ),
    // rust: )
}
// `ChestBlockEntity.startOpen` / `stopOpen` by a golem (interaction range
// 3): the opener count changes and the first opener or the last closer
// plays the chest's sound (`ChestBlockEntity.playSound`, at the middle of
// a double chest from its right half, none from its left).
open_or_close :: proc(cx: ^Bx, p: [i32; 3], open: bool) {
}
    // rust: let w = cx.w;
    // rust: let count = w
    // rust: .world
    // rust: .chest_openers
    // rust: .get(&(p[0], p[1], p[2]))
    // rust: .map_or(0, |o| o.0);
    // rust: let sounds = if open { count == 0 } else { count == 1 };
    // rust: if sounds
    // rust: && let Some(kind) = w.prop(p[0], p[1], p[2], "type")
    // rust: && kind != "left"
    // rust: {
    // rust: let mut at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: if kind == "right"
    // rust: && let Some(o) = connected(w, p)
    // rust: {
    // rust: at[0] += f64::from(o[0] - p[0]) * 0.5;
    // rust: at[2] += f64::from(o[2] - p[2]) * 0.5;
}
    // rust: let name = name_at(w, p);
    // rust: let base = name
    // rust: .trim_start_matches("minecraft:")
    // rust: .trim_start_matches("waxed_");
    // rust: let sound = match (base.ends_with("copper_chest"), base.split('_').next(), open) {
    // rust: (false, _, true) => "block.chest.open",
    // rust: (false, _, false) => "block.chest.close",
    // rust: (true, Some("weathered"), true) => "block.copper_chest_weathered.open",
    // rust: (true, Some("weathered"), false) => "block.copper_chest_weathered.close",
    // rust: (true, Some("oxidized"), true) => "block.copper_chest_oxidized.open",
    // rust: (true, Some("oxidized"), false) => "block.copper_chest_oxidized.close",
    // rust: (true, _, true) => "block.copper_chest.open",
    // rust: (true, _, false) => "block.copper_chest.close",
}
    // rust: let pitch = cx.lr.next_float() * 0.1 + 0.9;
    // rust: cx.events.push(MobEvent::Sound(sound, at, 0.5, pitch));
}
    // rust: cx.events.push(MobEvent::ChestOpen { chest: p, open });
}

    // rust: impl Transport {
    // `Behavior.tryStart`: no transport cooldown, not panicking, not
    // leashed; the duration draw, then `start`.
    // rust: pub(super) fn try_start(&mut self, m: &mut Mob, cx: &mut Bx) -> bool {
    // rust: let mm = mem(m);
    // rust: if mm.transport_items_cooldown_ticks.present() || mm.is_panicking.present() {
    // rust: return false;
}
    // rust: if m.extra.leash.is_some() {
    // rust: return false;
}
    // rust: self.running = true;
    // rust: self.end = cx.now + i64::from(cx.lr.next_int_bound(1).unwrap_or(0)) + 60;
    // rust: m.ai.nav.below_surface = true;
    // rust: true
}
    // rust: pub(super) fn tick_or_stop(&mut self, m: &mut Mob, cx: &mut Bx) {
    // rust: let mm = mem(m);
    // rust: let can_still = !mm.transport_items_cooldown_ticks.present()
    // rust: && !mm.is_panicking.present()
    // rust: && m.extra.leash.is_none();
    // rust: if !can_still {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: self.tick(m, cx);
}
    // rust: pub(super) fn do_stop(&mut self, m: &mut Mob, cx: &mut Bx) {
    // rust: self.running = false;
    // rust: self.on_start_travelling(m, cx);
    // rust: m.ai.nav.below_surface = false;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
}
    // rust: let updated = self.update_invalid_target(m, cx);
    // rust: let Some(target) = self.target.clone() else {
            // `this.stop(..)`: the stop effects, the behaviour still running.
    // rust: self.on_start_travelling(m, cx);
    // rust: m.ai.nav.below_surface = false;
    // rust: return;
}
    // rust: if updated {
    // rust: return;
}
    // rust: if self.state == State::Queuing && !self.another_interacting(m, cx.w, &target) {
    // rust: self.state = State::Travelling;
    // rust: self.walk_towards(m);
}
    // rust: if self.state == State::Travelling {
    // rust: let c = center(m);
    // rust: if within(cx.w, m, 3.0, &target, c) && self.another_interacting(m, cx.w, &target) {
    // rust: stop_in_place(m);
    // rust: self.state = State::Queuing;
    // rust: } else if within(cx.w, m, range(m), &target, c) {
    // rust: self.interaction = Some(reached_interaction(m, cx.w, &target.halves));
    // rust: self.state = State::Interacting;
    // rust: } else {
    // rust: self.walk_towards(m);
}
}
    // rust: if self.state == State::Interacting {
    // rust: self.on_reached(m, cx, &target);
}
}
update_invalid_target :: proc(self: ^Self, m: ^Mob, cx: ^Bx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.has_valid_target(m, cx) {
    // rust: return false;
}
    // rust: self.stop_targeting(m);
    // rust: match self.find_target(m, cx.w) {
    // rust: Some(t) => {
    // rust: let pos = t.pos;
    // rust: self.target = Some(t);
    // rust: self.on_start_travelling(m, cx);
    // rust: self.set_visited(m, pos);
}
    // rust: None => self.enter_cooldown(m),
}
    // rust: true
}
has_valid_target :: proc(self: ^Self, m: ^Mob, cx: ^Bx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(t) = self.target.clone() else {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let unchanged = matches!(
    // rust: w.world.block_entities.get(&(t.pos[0], t.pos[1], t.pos[2])),
    // rust: Some(BlockEntity::Chest(_))
    // rust: ) && is_chest_block(&name_at(w, t.pos));
    // rust: if !(wanted(w, m, &t.name) && unchanged) || blocked(w, t.pos) {
    // rust: return false;
}
    // rust: if self.state != State::Travelling {
    // rust: return true;
}
    // rust: if self.valid_travelling_path(m, w, &t) {
    // rust: return true;
}
    // rust: self.mark_unreachable(m, t.pos);
    // rust: false
}
valid_travelling_path :: proc(self: ^Self, m: ^Mob, w: ^MobWorld, t: ^Target) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let path = match &m.ai.nav.path {
    // rust: Some(p) => Some(p.clone()),
    // rust: None => m.create_path_to(w, t.pos, 0),
}
    // rust: let from = match path.as_ref().and_then(|p| p.end()) {
    // rust: Some(n) => [f64::from(n.x) + 0.5, f64::from(n.y), f64::from(n.z) + 0.5],
    // rust: None => [m.position.x, m.position.y, m.position.z],
}
    // rust: let from = [from[0], from[1] + m.bounds().size().y / 2.0, from[2]];
    // rust: let reach = within(w, m, range(m), t, from);
    // rust: (path.is_none() && !reach) || reach && sees_a_side(w, t.pos, from)
}
find_target :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bx = m.position.x.floor() as i32;
    // rust: let by = m.position.y.floor() as i32;
    // rust: let bz = m.position.z.floor() as i32;
    // rust: let (h, v): (i32, i32) = if m.extra.mount.is_some() {
    // rust: (1, 1)
    // rust: } else {
    // rust: (32, 8)
}
    // rust: let visited = mem_list(m, false);
    // rust: let unreachable = mem_list(m, true);
    // rust: let (cx, cz) = (bx >> 4, bz >> 4);
    // rust: let r = h.div_euclid(16) + 1;
        // Each chunk's block entities in their HashMap's order.
    // rust: let mut by_chunk: std::collections::HashMap<(i32, i32), Vec<[i32; 3]>> = Default::default();
    // rust: for (k, e) in &w.world.block_entities {
    // rust: if matches!(e, BlockEntity::Chest(_)) {
    // rust: by_chunk
    // rust: .entry((k.0 >> 4, k.2 >> 4))
    // rust: .or_default()
    // rust: .push([k.0, k.1, k.2]);
}
}
    // rust: let mut best: Option<(f64, Target)> = None;
    // rust: for z in cz - r..=cz + r {
    // rust: for x in cx - r..=cx + r {
    // rust: let Some(list) = by_chunk.get_mut(&(x, z)) else {
    // rust: continue;
}
    // rust: list.sort();
    // rust: let mut map: JavaHashMap<PosKey, ()> = JavaHashMap::default();
    // rust: for p in list.iter() {
    // rust: map.put(PosKey(*p), ());
}
    // rust: for (key, _) in map.entries() {
    // rust: let p = key.0;
    // rust: let d = (f64::from(p[0]) + 0.5 - m.position.x).powi(2)
    // rust: + (f64::from(p[1]) + 0.5 - m.position.y).powi(2)
    // rust: + (f64::from(p[2]) + 0.5 - m.position.z).powi(2);
    // rust: if best.as_ref().map_or(f64::from(f32::MAX), |b| b.0) <= d {
    // rust: continue;
}
                    // The search box: the mob's block grown by h, v, h.
    // rust: let inside = (bx - h..bx + 1 + h).contains(&p[0])
    // rust: && (by - v..by + 1 + v).contains(&p[1])
    // rust: && (bz - h..bz + 1 + h).contains(&p[2]);
    // rust: if !inside {
    // rust: continue;
}
    // rust: let Some(halves) = container(w, p) else {
    // rust: continue;
}
    // rust: let name = name_at(w, p);
    // rust: let seen =
    // rust: std::iter::once(p)
    // rust: .chain(connected(w, p).filter(|o| {
    // rust: w.world.block_entities.contains_key(&(o[0], o[1], o[2]))
    // rust: }))
    // rust: .any(|q| visited.contains(&q) || unreachable.contains(&q));
    // rust: if wanted(w, m, &name) && !seen {
    // rust: best = Some((
    // rust: d,
    // rust: Target {
    // rust: pos: p,
    // rust: name,
    // rust: halves,
    // rust: },
    // rust: ));
}
}
}
}
    // rust: best.map(|b| b.1)
}
    // `isAnotherMobInteractingWithTarget`: either half has an opener.
another_interacting :: proc(self: ^Self, m: ^Mob, w: ^MobWorld, t: ^Target) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut chests = vec![t.pos];
    // rust: if let Some(o) = connected(w, t.pos)
    // rust: && w.world.block_entities.contains_key(&(o[0], o[1], o[2]))
    // rust: {
    // rust: chests.push(o);
}
    // rust: chests.iter().any(|p| openers(w, m, *p) > 0)
}
walk_towards :: proc(self: ^Self, m: ^Mob) {
}
    // rust: if let Some(t) = &self.target {
            // BehaviorUtils.setWalkAndLookTargetMemories(body, pos, 1, 0).
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Block(t.pos));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Block(t.pos),
    // rust: speed: 1.0,
    // rust: close: 0,
    // rust: });
}
}
on_reached :: proc(self: ^Self, m: ^Mob, cx: ^Bx, t: ^Target) {
}
    // rust: if !within(cx.w, m, 2.0, t, center(m)) {
    // rust: self.on_start_travelling(m, cx);
    // rust: return;
}
    // rust: self.ticks += 1;
        // onTargetInteraction.
    // rust: mem(m).look_target.set(Tracker::Block(t.pos));
    // rust: stop_in_place(m);
    // rust: if let Some(i) = self.interaction {
    // rust: let (state, sound) = match i {
    // rust: Interaction::PickupItem => (cg::GETTING_ITEM, "entity.copper_golem.no_item_get"),
    // rust: Interaction::PickupNoItem => {
    // rust: (cg::GETTING_NO_ITEM, "entity.copper_golem.no_item_no_get")
}
    // rust: Interaction::PlaceItem => (cg::DROPPING_ITEM, "entity.copper_golem.item_drop"),
    // rust: Interaction::PlaceNoItem => {
    // rust: (cg::DROPPING_NO_ITEM, "entity.copper_golem.item_no_drop")
}
}
    // rust: if self.ticks == 1 {
                // container.startOpen, before setOpenedChestPos.
    // rust: for h in &t.halves {
    // rust: open_or_close(cx, *h, true);
}
    // rust: m.extra.opened_chest = Some(t.pos);
    // rust: m.extra.variant3 = state;
}
    // rust: if self.ticks == 9 && !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events.push(MobEvent::Sound(sound, at, 1.0, 1.0));
}
    // rust: if self.ticks == 60 {
                // container.getEntitiesWithContainerOpen().contains(body):
                // only a single chest lists its openers (CompoundContainer
                // keeps Container's empty list, so a double chest is left
                // to the openers recheck).
    // rust: if t.halves.len() == 1 && has_open(cx.w, m, t.pos) {
    // rust: open_or_close(cx, t.pos, false);
}
    // rust: m.extra.opened_chest = None;
}
}
    // rust: if self.ticks >= 60 {
    // rust: let items = slots(cx.w, &t.halves);
    // rust: if held(m).is_none() {
    // rust: if items.iter().any(Option::is_some) {
    // rust: self.pick_up(m, cx, &t.halves, &items);
    // rust: } else {
    // rust: self.stop_targeting(m);
}
    // rust: } else if leaving_ok(m, &items) {
    // rust: self.put_down(m, cx, &t.halves, items);
    // rust: } else {
    // rust: self.stop_targeting(m);
}
    // rust: self.on_start_travelling(m, cx);
}
}
    // `pickUpItems`: up to 16 of the first non-empty slot.
    // rust: fn pick_up(
    // rust: &mut self,
    // rust: m: &mut Mob,
    // rust: cx: &mut Bx,
    // rust: halves: &[[i32; 3]],
    // rust: items: &[Option<ItemStack>],
    // rust: ) {
    // rust: if let Some((n, s)) = items
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find_map(|(n, s)| s.as_ref().map(|s| (n, s.clone())))
    // rust: {
    // rust: let take = s.count.min(16);
    // rust: let mut left = s.clone();
    // rust: left.count -= take;
    // rust: let mut got = s;
    // rust: got.count = take;
    // rust: if let Some((h, slot)) = slot_at(cx.w, halves, n) {
    // rust: cx.events.push(MobEvent::ChestSlot {
    // rust: chest: h,
    // rust: slot,
    // rust: stack: (left.count > 0).then_some(left),
    // rust: });
}
    // rust: set_held(m, Some(got));
}
    // rust: self.clear_memories(m);
}
    // `putDownItem` (`addItemsToContainer`, which takes from the carried
    // stack all the room a slot had, not what it put there).
    // rust: fn put_down(
    // rust: &mut self,
    // rust: m: &mut Mob,
    // rust: cx: &mut Bx,
    // rust: halves: &[[i32; 3]],
    // rust: items: Vec<Option<ItemStack>>,
    // rust: ) {
    // rust: let mut carried = held(m).cloned();
    // rust: for (n, slot) in items.into_iter().enumerate() {
    // rust: let Some(stack) = carried.clone() else { break };
    // rust: match slot {
    // rust: None => {
    // rust: if let Some((h, s)) = slot_at(cx.w, halves, n) {
    // rust: cx.events.push(MobEvent::ChestSlot {
    // rust: chest: h,
    // rust: slot: s,
    // rust: stack: Some(stack),
    // rust: });
}
    // rust: carried = None;
    // rust: break;
}
    // rust: Some(mut there) => {
    // rust: let max = max_stack(cx.w, &there);
    // rust: if there.item == stack.item
    // rust: && there.extra == stack.extra
    // rust: && there.damage == stack.damage
    // rust: && there.count < max
    // rust: {
    // rust: let room = max - there.count;
    // rust: let add = room.min(stack.count);
    // rust: there.count += add;
    // rust: if let Some((h, s)) = slot_at(cx.w, halves, n) {
    // rust: cx.events.push(MobEvent::ChestSlot {
    // rust: chest: h,
    // rust: slot: s,
    // rust: stack: Some(there),
    // rust: });
}
    // rust: let left = i64::from(stack.count) - i64::from(room);
    // rust: if left <= 0 {
    // rust: carried = None;
    // rust: break;
}
    // rust: let mut rest = stack;
    // rust: rest.count = left as u32;
    // rust: carried = Some(rest);
}
}
}
}
    // rust: let emptied = carried.is_none();
    // rust: set_held(m, carried);
    // rust: if emptied {
    // rust: self.clear_memories(m);
    // rust: } else {
    // rust: self.stop_targeting(m);
}
}
on_start_travelling :: proc(self: ^Self, m: ^Mob, _: ^Bx) {
}
        // CopperGolemAi.onTravelling: clearOpenedChestPos, IDLE.
    // rust: m.extra.opened_chest = None;
    // rust: m.extra.variant3 = cg::IDLE;
    // rust: self.state = State::Travelling;
    // rust: self.interaction = None;
    // rust: self.ticks = 0;
}
stop_targeting :: proc(self: ^Self, m: ^Mob) {
}
    // rust: self.ticks = 0;
    // rust: self.target = None;
    // rust: m.nav_stop();
    // rust: mem(m).walk_target.clear();
}
clear_memories :: proc(self: ^Self, m: ^Mob) {
}
    // rust: self.stop_targeting(m);
    // rust: let mm = mem(m);
    // rust: mm.visited_block_positions.clear();
    // rust: mm.unreachable_transport_block_positions.clear();
}
enter_cooldown :: proc(self: ^Self, m: ^Mob) {
}
    // rust: self.stop_targeting(m);
    // rust: let mm = mem(m);
    // rust: mm.transport_items_cooldown_ticks.set(140);
    // rust: mm.visited_block_positions.clear();
    // rust: mm.unreachable_transport_block_positions.clear();
}
set_visited :: proc(self: ^Self, m: ^Mob, p: [i32; 3]) {
}
    // rust: let mut list = mem_list(m, false);
    // rust: if !list.contains(&p) {
    // rust: list.push(p);
}
    // rust: if list.len() > 10 {
    // rust: self.enter_cooldown(m);
    // rust: } else {
    // rust: mem(m).visited_block_positions.set_ttl(list, 6000);
}
}
mark_unreachable :: proc(self: ^Self, m: ^Mob, p: [i32; 3]) {
}
    // rust: let mut visited = mem_list(m, false);
    // rust: visited.retain(|q| *q != p);
    // rust: let mut unreachable = mem_list(m, true);
    // rust: if !unreachable.contains(&p) {
    // rust: unreachable.push(p);
}
    // rust: if unreachable.len() > 50 {
    // rust: self.enter_cooldown(m);
    // rust: } else {
    // rust: let mm = mem(m);
    // rust: mm.visited_block_positions.set_ttl(visited, 6000);
    // rust: mm.unreachable_transport_block_positions
    // rust: .set_ttl(unreachable, 6000);
}
}
}
mem_list :: proc(m: ^Mob, unreachable: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(mm) = mem_ref(m) else {
    // rust: return Vec::new();
}
    // rust: let slot = if unreachable {
    // rust: &mm.unreachable_transport_block_positions
    // rust: } else {
    // rust: &mm.visited_block_positions
}
    // rust: slot.get().cloned().unwrap_or_default()
}
// `matchesLeavingItemsRequirement`: an empty container, or one holding the
// carried item.
leaving_ok :: proc(m: ^Mob, items: ^[Maybe(ItemStack)]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let carried = held(m);
    // rust: items.iter().all(Option::is_none)
    // rust: || items
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|s| carried.is_some_and(|c| c.item == s.item))
}
reached_interaction :: proc(m: ^Mob, w: ^MobWorld, halves: ^[[i32; 3]]) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let items = slots(w, halves);
    // rust: if held(m).is_none() {
    // rust: if items.iter().any(Option::is_some) {
    // rust: Interaction::PickupItem
    // rust: } else {
    // rust: Interaction::PickupNoItem
}
    // rust: } else if leaving_ok(m, &items) {
    // rust: Interaction::PlaceItem
    // rust: } else {
    // rust: Interaction::PlaceNoItem
}
}
// `canSeeAnyTargetSide`: a clip from `eye` to the middle of any face of the
// chest's block hits that block.
sees_a_side :: proc(w: ^MobWorld, p: [i32; 3], eye: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let c = Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // Direction order: down, up, north, south, west, east.
    // rust: let steps = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
    // rust: let from = Vec3::new(eye[0], eye[1], eye[2]);
    // rust: steps.iter().any(|s| {
    // rust: let to = Vec3::new(
    // rust: c.x + 0.5 * f64::from(s[0]),
    // rust: c.y + 0.5 * f64::from(s[1]),
    // rust: c.z + 0.5 * f64::from(s[2]),
    // rust: );
    // rust: w.clip_block_at(from, to) == Some(p)
    // rust: })
}
