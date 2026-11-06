//! Transpiled from Horizon Rust crate
//! Module: horizon-client_doors
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Doors a mob gets through on its own: `DoorInteractGoal` with its two
//! users, `BreakDoorGoal` (zombies that can break doors, vindicators in a
//! raid) and `OpenDoorGoal` (`AbstractIllager.RaiderOpenDoorGoal`).
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: goals::{Cx, Goal, MOVE, goal_clone, reduced},
    // rust: nav::NavKind,
    // rust: raider,
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

/// `DefaultDoorBreakTime`: `BreakDoorGoal.getDoorBreakTime` is
/// `max(240, doorBreakTime)`, and the vindicator's 6 is below it.
pub const DOOR_BREAK_TIME: i32 = 240;

/// `GoalUtils.hasGroundPathNavigation`: ground, wall-climbing and
/// amphibious navigations walk.
pub fn can_navigate_ground(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: m.ai.nav.kind,
    // rust: NavKind::Ground | NavKind::WallClimber | NavKind::Amphibious { .. }
    // rust: )
}
/// `Zombie.setCanBreakDoors`: only a mob that walks can break doors, and
/// then its navigation opens them.
pub fn set_can_break_doors(m: *mut Mob, can_break: bool) void {
}
    // rust: let can_break = can_break && can_navigate_ground(m);
    // rust: m.extra.can_break_doors = can_break;
    // rust: m.ai.nav.can_open_doors = can_break;
}
/// The species that extend `Zombie` (`CanBreakDoors` is theirs to save).
pub fn is_zombie(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: )
}
/// `DoorBlock.isWoodenDoor`: a door a hand opens, which is any but iron.
pub fn wooden_door(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = w.block_name(p[0], p[1], p[2]);
    // rust: name.ends_with("_door") && name != "minecraft:iron_door"
}
/// `DoorInteractGoal`'s door: where it is and whether one is there.
pub const Interact = struct {
    door: [i32,
    has_door: bool,
};
    // rust: impl Interact {
    /// `DoorInteractGoal.canUse`: the mob bumped into something and a
    /// wooden door is on its path within 1.5 blocks, or at its own head.
pub fn can_use(self: *Self, m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !can_navigate_ground(m) || !m.horizontal_collision {
    // rust: return false;
}
    // rust: let Some(path) = m.ai.nav.path.as_ref().filter(|p| !p.is_done()) else {
    // rust: return false;
}
    // rust: for node in path
    // rust: .nodes
    // rust: .iter()
    // rust: .take((path.next + 2).min(path.nodes.len()))
    // rust: {
    // rust: self.door = [node.x, node.y + 1, node.z];
    // rust: let dx = m.position.x - f64::from(node.x);
    // rust: let dz = m.position.z - f64::from(node.z);
    // rust: if dx * dx + dz * dz <= 2.25 {
    // rust: self.has_door = wooden_door(w, self.door);
    // rust: if self.has_door {
    // rust: return true;
}
}
}
    // rust: let at = m.position;
    // rust: self.door = [
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32 + 1,
    // rust: at.z.floor() as i32,
    // rust: ];
    // rust: self.has_door = wooden_door(w, self.door);
    // rust: self.has_door
}
    /// `DoorInteractGoal.isOpen`: the door is still there and open.
pub fn is_open(self: *Self, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.has_door {
    // rust: return false;
}
    // rust: let d = self.door;
    // rust: if !w.block_name(d[0], d[1], d[2]).ends_with("_door") {
    // rust: self.has_door = false;
    // rust: return false;
}
    // rust: w.prop(d[0], d[1], d[2], "open") == Some("true")
}
    /// `DoorInteractGoal.setOpen`.
pub fn set_open(self: *Self, cx: *mut Cx, open: bool) void {
}
    // rust: let d = self.door;
    // rust: if self.has_door && cx.w.block_name(d[0], d[1], d[2]).ends_with("_door") {
    // rust: cx.events.push(MobEvent::SetDoorOpen { pos: d, open });
}
}
}
/// `BlockPos.closerToCenterThan`.
    // rust: pub(super) fn closer_to_center(p: [i32; 3], at: Vec3, distance: f64) -> bool {
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: )
    // rust: .distance_squared(at)
    // rust: < distance * distance
}

/// `BreakDoorGoal`: crack the door in the way for 240 ticks, then remove it.
/// A zombie does it on hard only; `Vindicator.VindicatorBreakDoorGoal` on
/// normal and hard, in a raid, and holds the mob's movement.
pub const BreakDoor = struct {
    interact: Interact,
    vindicator: bool,
    break_time: i32,
    last_break_progress: i32,
};
    // rust: impl BreakDoor {
    /// `Zombie.breakDoorGoal`, added when the zombie can break doors.
pub fn zombie() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(false)
}
    /// `Vindicator.VindicatorBreakDoorGoal`.
pub fn vindicator() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(true)
}
pub fn new(vindicator: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: interact: Interact::default(),
    // rust: vindicator,
    // rust: break_time: 0,
    // rust: last_break_progress: -1,
}
}
    /// `DOOR_BREAKING_PREDICATE`.
pub fn valid_difficulty(self: *Self, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.vindicator {
    // rust: w.difficulty.normal || w.difficulty.hard
    // rust: } else {
    // rust: w.difficulty.hard
}
}
    /// `BreakDoorGoal.canUse` after `DoorInteractGoal.canUse`.
pub fn can_break(self: *Self, m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.interact.can_use(m, w)
    // rust: && w.mob_griefing
    // rust: && self.valid_difficulty(w)
    // rust: && !self.interact.is_open(w)
}
}
    // rust: impl Goal for BreakDoor {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.vindicator { MOVE } else { 0 }
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.vindicator {
    // rust: return raider::has_active_raid(m)
    // rust: && m.random.next_int_bound(reduced(10)).unwrap_or(1) == 0
    // rust: && self.can_break(m, cx.w);
}
    // rust: m.extra.can_break_doors && self.can_break(m, cx.w)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (!self.vindicator || raider::has_active_raid(m))
    // rust: && self.break_time <= DOOR_BREAK_TIME
    // rust: && !self.interact.is_open(cx.w)
    // rust: && closer_to_center(self.interact.door, m.position, 2.0)
    // rust: && self.valid_difficulty(cx.w)
}
pub fn start(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: self.break_time = 0;
    // rust: if self.vindicator {
    // rust: m.ai.no_action_time = 0;
}
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: cx.events.push(MobEvent::DestroyProgress {
    // rust: mob: m.id,
    // rust: pos: self.interact.door,
    // rust: progress: -1,
    // rust: });
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let door = self.interact.door;
    // rust: if m.random.next_int_bound(20).unwrap_or(1) == 0 {
    // rust: cx.events.push(MobEvent::LevelEvent {
    // rust: id: 1019,
    // rust: pos: door,
    // rust: data: 0,
    // rust: });
    // rust: if !m.ai.swinging {
    // rust: m.swing();
}
}
    // rust: self.break_time += 1;
    // rust: let progress = (self.break_time as f32 / DOOR_BREAK_TIME as f32 * 10.0) as i32;
    // rust: if progress != self.last_break_progress {
    // rust: cx.events.push(MobEvent::DestroyProgress {
    // rust: mob: m.id,
    // rust: pos: door,
    // rust: progress,
    // rust: });
    // rust: self.last_break_progress = progress;
}
    // rust: if self.break_time == DOOR_BREAK_TIME && self.valid_difficulty(cx.w) {
    // rust: cx.events.push(MobEvent::BreakDoor {
    // rust: mob: m.id,
    // rust: pos: door,
    // rust: });
}
}
}

/// `AbstractIllager.RaiderOpenDoorGoal` (`OpenDoorGoal` that does not wait
/// to close): open the door in the way during a raid. It never continues, so
/// it closes the door again as soon as it stops.
pub const RaiderOpenDoor = struct {
    interact: Interact,
};
    // rust: impl Goal for RaiderOpenDoor {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.interact.can_use(m, cx.w) && raider::has_active_raid(m)
}
pub fn can_continue(self: *Self, _m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn start(self: *Self, _m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.interact.set_open(cx, true);
}
pub fn stop(self: *Self, _m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.interact.set_open(cx, false);
}
}

/// `InteractWithDoor.create()`, the piglin brain's core behaviour: while it
/// follows a path, open the doors it is leaving and entering and close the
/// ones it opened or passed through (within 3 blocks, and not the two of the
/// step it takes). It takes no flags and runs every tick, as a core behaviour
/// does. (Another piglin coming through a door is not looked for.)
pub const InteractWithDoor = struct {
    /// `lastCheckedNode` and `remainingCooldown`.
    last_checked: Option<[i32,
    cooldown: i32,
    /// `DOORS_TO_CLOSE`.
    doors: Vec<[i32,
};
    // rust: impl InteractWithDoor {
    /// A door mobs open (`MOB_INTERACTABLE_DOORS`) at `p`, and whether it is open.
pub fn door_open(w: *MobWorld, p: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = w.block_name(p[0], p[1], p[2]);
    // rust: (name.ends_with("_door") && w.has_tag("minecraft:mob_interactable_doors", name))
    // rust: .then(|| w.prop(p[0], p[1], p[2], "open") == Some("true"))
}
    /// `closeDoorsThatIHaveOpenedOrPassedThrough`.
pub fn close_doors(self: *Self, m: *Mob, cx: *mut Cx, from: [i32; 3], to: [i32; 3]) void {
}
    // rust: let doors = std::mem::take(&mut self.doors);
    // rust: for door in doors {
    // rust: if from == door || to == door {
    // rust: self.doors.push(door);
    // rust: continue;
}
    // rust: if !closer_to_center(door, m.position, 3.0) || Self::door_open(cx.w, door) != Some(true)
    // rust: {
    // rust: continue;
}
    // rust: cx.events.push(MobEvent::SetDoorOpen {
    // rust: pos: door,
    // rust: open: false,
    // rust: });
}
}
}
    // rust: impl Goal for InteractWithDoor {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.nav
    // rust: .path
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.next > 0 && !p.is_done())
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.can_use(m, cx)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(path) =
    // rust: m.ai.nav
    // rust: .path
    // rust: .as_ref()
    // rust: .filter(|p| p.next > 0 && !p.is_done())
    // rust: else {
    // rust: return;
}
    // rust: let node = |i: usize| [path.nodes[i].x, path.nodes[i].y, path.nodes[i].z];
    // rust: let (from, to) = (node(path.next - 1), node(path.next));
    // rust: if self.last_checked == Some(to) {
    // rust: self.cooldown = 20;
    // rust: } else {
    // rust: self.cooldown -= 1;
    // rust: if self.cooldown > 0 {
    // rust: return;
}
}
    // rust: self.last_checked = Some(to);
        // The door being left is remembered even when it is open already; the
        // one ahead only when this mob opens it.
    // rust: for (p, always) in [(from, true), (to, false)] {
    // rust: let Some(open) = Self::door_open(cx.w, p) else {
    // rust: continue;
}
    // rust: if !open {
    // rust: cx.events.push(MobEvent::SetDoorOpen { pos: p, open: true });
}
    // rust: if (always || !open) && !self.doors.contains(&p) {
    // rust: self.doors.push(p);
}
}
    // rust: self.close_doors(m, cx, from, to);
}
}
