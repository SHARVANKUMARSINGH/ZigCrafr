//! Transpiled from Horizon Rust crate
package horizon_client_nav

import "core:fmt"
import "core:mem"
import "core:math"

// `PathNavigation` and its ground, wall-climbing, water-bound, flying and
// amphibious variants: path creation, waypoint following, corner cutting,
// stuck detection and path timeouts.
// use super::{
    // rust: Mob, MobWorld,
    // rust: path::{Evaluator, Finder, Path, PathMob, PathType},
}
// use horizon_core::geometry::Vec3;

NavKind :: enum {
    Ground,
    WallClimber,
    Water {,
    breach: bool,
    // rust: },
    Flying,
    // `AmphibiousPathNavigation` (`Axolotl`, `Drowned`, `Turtle`, and the
    // `Frog`, whose `FrogPathNavigation.prefersShallowSwimming` costs the
    // water nodes deeper than ten blocks under sea level.
    Amphibious {,
    prefers_shallow: bool,
    // rust: },
}
Navigation :: struct {
    kind: NavKind,
    path: Maybe(Path),
    speed_modifier: f64,
    tick: i64,
    last_stuck_check: i64,
    last_stuck_pos: Vec3,
    timeout_node: [i32,
    timeout_timer: i64,
    last_timeout_check: i64,
    timeout_limit: f64,
    max_distance_to_waypoint: f32,
    delayed_recompute: bool,
    // `ServerLevel.sendBlockUpdated` asked for a recompute: made at the next tick.
    pending_recompute: bool,
    time_last_recompute: i64,
    target_pos: Option<[i32,
    reach_range: i32,
    max_visited_multiplier: f32,
    stuck: bool,
    // Set through [`Mob::set_required_path_length`].
    required_path_length: f32,
    // `PathFinder.maxVisitedNodes`: the base follow range times 16 when the
    // navigation is made, then [`Mob::update_max_visited_nodes`].
    max_visited_nodes: i32,
    can_float: bool,
    can_open_doors: bool,
    can_pass_doors: bool,
    can_walk_over_fences: bool,
    avoid_sun: bool,
    below_surface: bool,
    // WallClimberNavigation.pathToPosition
    climb_to: Option<[i32,
}
// A controlling passenger uses the vehicle's actual navigation, but the
// passenger's private navigation still ticks in Mob.serverAiStep.
    // rust: pub(super) struct Redirect {
    // rust: pub own: Navigation,
    // rust: pub body: PathMob,
    // rust: pub follow_range: f32,
    // rust: pub passenger: bool,
    // rust: pub in_liquid: bool,
}
    // rust: impl Default for Navigation {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind: NavKind::Ground,
    // rust: path: None,
    // rust: speed_modifier: 0.0,
    // rust: tick: 0,
    // rust: last_stuck_check: 0,
    // rust: last_stuck_pos: Vec3::ZERO,
    // rust: timeout_node: [0; 3],
    // rust: timeout_timer: 0,
    // rust: last_timeout_check: 0,
    // rust: timeout_limit: 0.0,
    // rust: max_distance_to_waypoint: 0.5,
    // rust: delayed_recompute: false,
    // rust: pending_recompute: false,
    // rust: time_last_recompute: 0,
    // rust: target_pos: None,
    // rust: reach_range: 0,
    // rust: max_visited_multiplier: 1.0,
    // rust: stuck: false,
    // rust: required_path_length: 16.0,
    // rust: max_visited_nodes: 256,
    // rust: can_float: false,
    // rust: can_open_doors: false,
    // rust: can_pass_doors: true,
    // rust: can_walk_over_fences: false,
    // rust: avoid_sun: false,
    // rust: below_surface: false,
    // rust: climb_to: None,
}
}
}
    // rust: impl Navigation {
is_done :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.path.as_ref().is_none_or(Path::is_done)
}
is_in_progress :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.is_done()
}
stop :: proc(self: ^Self) {
}
    // rust: self.path = None;
}
reset_stuck_timeout :: proc(self: ^Self) {
}
    // rust: self.timeout_node = [0; 3];
    // rust: self.timeout_timer = 0;
    // rust: self.timeout_limit = 0.0;
    // rust: self.stuck = false;
}
evaluator :: proc(self: ^Self) -> E {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind {
    // rust: NavKind::Ground | NavKind::WallClimber => Evaluator::Walk,
    // rust: NavKind::Water { breach } => Evaluator::Swim { breach },
    // rust: NavKind::Flying => Evaluator::Fly,
    // rust: NavKind::Amphibious { prefers_shallow } => Evaluator::Amphibious { prefers_shallow },
}
}
can_cut_corner :: proc(t: PathType) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !matches!(
    // rust: t,
    // rust: PathType::FireInNeighbor | PathType::DamagingInNeighbor | PathType::WalkableDoor
    // rust: )
}
}
// `LivingEntity.getComfortableFallDistance`: the drop an entity accepts on
// top of what it was asked for.
comfortable_fall_distance :: proc(f: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (f + 3.0).floor() as i32
}
    // rust: impl Mob {
path_mob :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(redirect) = &self.ai.navigation_redirect {
    // rust: return redirect.body.clone();
}
    // rust: PathMob {
    // rust: position: self.position,
    // rust: width: self.width(),
    // rust: height: self.height(),
    // rust: on_ground: self.on_ground,
    // rust: in_water: self.fluids.in_water,
    // rust: max_up_step: self.kind.step_height as f32,
    // rust: max_fall_distance: self.max_fall_distance(),
    // rust: malus: self.ai.malus,
    // rust: can_float: self.ai.nav.can_float,
    // rust: can_open_doors: self.ai.nav.can_open_doors,
    // rust: can_pass_doors: self.ai.nav.can_pass_doors,
    // rust: can_walk_over_fences: self.ai.nav.can_walk_over_fences,
    // rust: stands_on_lava: self.kind.flags.lava_walker,
}
}
    // `Mob.getMaxFallDistance` (normal difficulty), with `Creeper`'s
    // override: a creeper that has a target falls by its own health, so a
    // full-health one walks off a 22-block drop instead of 3.
max_fall_distance :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.ai.target.is_none() {
    // rust: return comfortable_fall_distance(0.0);
}
    // rust: if self.species() == super::Species::Creeper {
    // rust: return comfortable_fall_distance(self.health - 1.0);
}
    // rust: let mut sacrifice = (self.health - self.attrs.max_health * 0.33) as i32;
    // rust: sacrifice -= 4;
    // rust: comfortable_fall_distance(sacrifice.max(0) as f32)
}
malus :: proc(self: ^Self, t: PathType) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.ai.malus[t as usize].unwrap_or_else(|| t.malus())
}
set_malus :: proc(self: ^Self, t: PathType, v: f32) {
}
    // rust: self.ai.malus[t as usize] = Some(v);
}
navigation_position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.ai
    // rust: .navigation_redirect
    // rust: .as_ref()
    // rust: .map_or(self.position, |r| r.body.position)
}
navigation_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.ai
    // rust: .navigation_redirect
    // rust: .as_ref()
    // rust: .map_or_else(|| self.height(), |r| r.body.height)
}
navigation_in_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.ai
    // rust: .navigation_redirect
    // rust: .as_ref()
    // rust: .map_or(self.fluids.in_water, |r| r.body.in_water)
}
    // PathNavigation.getMaxPathLength.
max_path_length :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.ai
    // rust: .navigation_redirect
    // rust: .as_ref()
    // rust: .map_or(self.attrs.follow_range as f32, |r| r.follow_range)
    // rust: .max(self.ai.nav.required_path_length)
}
    // `PathNavigation.updatePathfinderMaxVisitedNodes`: after a follow range
    // change and a new required path length.
update_max_visited_nodes :: proc(self: ^Self) {
}
    // rust: self.ai.nav.max_visited_nodes = (self.max_path_length() * 16.0).floor() as i32;
}
    // `PathNavigation.setRequiredPathLength`.
set_required_path_length :: proc(self: ^Self, length: f32) {
}
    // rust: self.ai.nav.required_path_length = length;
    // rust: self.update_max_visited_nodes();
}
can_update_path :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.ai.nav.kind {
            // GroundPathNavigation.canUpdatePath: onGround() || isInLiquid() ||
            // isPassenger(). A mob riding a vehicle keeps making and following
            // paths where it sits (`create_path_raw` and `recompute_path` refuse
            // without this).
    // rust: NavKind::Ground | NavKind::WallClimber => {
    // rust: self.ai.navigation_redirect.as_ref().map_or_else(
    // rust: || self.on_ground || self.is_in_liquid() || self.extra.mount.is_some(),
    // rust: |r| r.body.on_ground || r.in_liquid || r.passenger,
    // rust: )
}
    // rust: NavKind::Water { breach } => {
    // rust: breach
    // rust: || self
    // rust: .ai
    // rust: .navigation_redirect
    // rust: .as_ref()
    // rust: .map_or_else(|| self.is_in_liquid(), |r| r.in_liquid)
}
    // rust: NavKind::Flying | NavKind::Amphibious { .. } => true,
}
}
temp_mob_pos :: proc(self: ^Self, w: ^MobWorld) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match self.ai.nav.kind {
    // rust: NavKind::Ground | NavKind::WallClimber => Vec3::new(
    // rust: self.navigation_position().x,
    // rust: f64::from(self.surface_y(w)),
    // rust: self.navigation_position().z,
    // rust: ),
    // rust: NavKind::Water { .. } | NavKind::Amphibious { .. } => Vec3::new(
    // rust: self.navigation_position().x,
    // rust: self.navigation_position().y + f64::from(self.navigation_height()) * 0.5,
    // rust: self.navigation_position().z,
    // rust: ),
    // rust: NavKind::Flying => self.navigation_position(),
}
}
surface_y :: proc(self: ^Self, w: ^MobWorld) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (x, z) = (
    // rust: self.navigation_position().x.floor() as i32,
    // rust: self.navigation_position().z.floor() as i32,
    // rust: );
    // rust: if self.navigation_in_water() && self.ai.nav.can_float {
    // rust: let mut y = self.navigation_position().y.floor() as i32;
    // rust: let start = y;
    // rust: let mut steps = 0;
    // rust: while w.facts.get(w.world.block(x, y, z)).fluid == crate::blocks::Fluid::Water {
    // rust: y += 1;
    // rust: steps += 1;
    // rust: if steps > 16 {
    // rust: return start;
}
}
    // rust: y
    // rust: } else {
    // rust: (self.navigation_position().y + 0.5).floor() as i32
}
}
    // GroundPathNavigation.findSurfacePosition.
surface_position :: proc(self: ^Self, w: ^MobWorld, mut p: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let air = |p: [i32; 3]| w.facts.is_air(w.world.block(p[0], p[1], p[2]));
    // rust: let solid = |p: [i32; 3]| w.solid(p[0], p[1], p[2]);
    // rust: if air(p) {
    // rust: let mut q = [p[0], p[1] - 1, p[2]];
    // rust: while q[1] >= w.world.bottom_y() && air(q) {
    // rust: q[1] -= 1;
}
    // rust: if q[1] >= w.world.bottom_y() {
    // rust: return [q[0], q[1] + 1, q[2]];
}
    // rust: q[1] = p[1] + 1;
    // rust: while q[1] <= 319 && air(q) {
    // rust: q[1] += 1;
}
    // rust: p = q;
}
    // rust: if !solid(p) {
    // rust: return p;
}
    // rust: let mut q = [p[0], p[1] + 1, p[2]];
    // rust: while q[1] <= 319 && solid(q) {
    // rust: q[1] += 1;
}
    // rust: q
}
    // rust: pub(super) fn create_path_raw(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: targets: &[[i32; 3]],
    // rust: reach: i32,
    // rust: max_len: f32,
    // rust: ) -> Option<Path> {
    // rust: if targets.is_empty()
    // rust: || self.navigation_position().y < f64::from(w.world.bottom_y())
    // rust: || !self.can_update_path()
    // rust: {
    // rust: return None;
}
    // rust: if let (Some(path), Some(tp)) = (&self.ai.nav.path, self.ai.nav.target_pos)
    // rust: && !path.is_done()
    // rust: && targets.contains(&tp)
    // rust: {
    // rust: return Some(path.clone());
}
    // rust: let pm = self.path_mob();
    // rust: let max_visited =
    // rust: (self.ai.nav.max_visited_nodes as f32 * self.ai.nav.max_visited_multiplier) as i32;
    // rust: let finder = Finder::new(w, &pm, self.ai.nav.evaluator());
    // rust: let path = finder.find(targets, max_len, reach, max_visited);
    // rust: if let Some(p) = &path {
    // rust: self.ai.nav.target_pos = Some(p.target);
    // rust: self.ai.nav.reach_range = reach;
    // rust: self.ai.nav.reset_stuck_timeout();
}
    // rust: path
}
    // PathNavigation.createPath(BlockPos, reach) with the ground surface search.
create_path_to :: proc(self: ^Self, w: ^MobWorld, mut p: [i32; 3], reach: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.ai.nav.kind {
    // rust: NavKind::Ground | NavKind::WallClimber => {
    // rust: if !w.world.loaded(p[0], p[2]) {
    // rust: return None;
}
    // rust: if self.ai.nav.kind == NavKind::WallClimber {
    // rust: self.ai.nav.climb_to = Some(p);
}
    // rust: if !self.ai.nav.below_surface {
    // rust: p = self.surface_position(w, p);
}
}
    // rust: _ => {}
}
    // rust: let max = self.max_path_length();
    // rust: self.create_path_raw(w, &[p], reach, max)
}
    // PathNavigation.createPath(Set<BlockPos>, reach): the nearest of
    // several targets, without the ground surface search.
    // rust: pub fn create_path_to_any(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: targets: &[[i32; 3]],
    // rust: reach: i32,
    // rust: ) -> Option<Path> {
    // rust: let max = self.max_path_length();
    // rust: self.create_path_raw(w, targets, reach, max)
}
    // PathNavigation.createPath(Entity, reach).
    // rust: pub fn create_path_to_entity(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: at: [f64; 3],
    // rust: reach: i32,
    // rust: ) -> Option<Path> {
    // rust: let p = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: self.create_path_to(w, p, reach)
}
    // `PathNavigation.moveTo(Path, speed)`: `trimPath` runs before the
    // node count is checked, so a path the trim empties is refused.
nav_move_to_path :: proc(self: ^Self, w: ^MobWorld, path: Maybe(Path), speed: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(path) = path else {
    // rust: self.ai.nav.path = None;
    // rust: return false;
}
    // rust: if !path.same_as(self.ai.nav.path.as_ref()) {
    // rust: self.ai.nav.path = Some(path);
}
    // rust: if self.ai.nav.is_done() {
    // rust: return false;
}
    // rust: self.trim_path(w);
    // rust: if self.ai.nav.path.as_ref().is_none_or(|p| p.nodes.is_empty()) {
    // rust: return false;
}
    // rust: self.ai.nav.speed_modifier = speed;
    // rust: self.ai.nav.last_stuck_check = self.ai.nav.tick;
        // getTempMobPos needs the world for ground navigation; position is close enough
        // for the first stuck sample and is refreshed 100 ticks later.
    // rust: self.ai.nav.last_stuck_pos = self.navigation_position();
    // rust: true
}
    // PathNavigation.moveTo(x, y, z, speed): a path to the containing block.
nav_move_to :: proc(self: ^Self, w: ^MobWorld, at: [f64; 3], speed: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let p = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: let path = self.create_path_to(w, p, 1);
    // rust: self.nav_move_to_path(w, path, speed)
}
    // rust: pub fn nav_move_to_entity(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: at: [f64; 3],
    // rust: reach: i32,
    // rust: speed: f64,
    // rust: ) -> bool {
    // rust: let path = self.create_path_to_entity(w, at, reach);
    // rust: if self.ai.nav.kind == NavKind::WallClimber && path.is_none() {
            // WallClimberNavigation.moveTo(Entity): climb straight towards it.
    // rust: self.ai.nav.climb_to = Some([
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ]);
    // rust: self.ai.nav.speed_modifier = speed;
    // rust: return true;
}
    // rust: path.is_some() && self.nav_move_to_path(w, path, speed)
}
nav_stop :: proc(self: ^Self) {
}
    // rust: self.ai.nav.path = None;
}
recompute_path :: proc(self: ^Self, w: ^MobWorld) {
}
    // rust: if w.game_time - self.ai.nav.time_last_recompute <= 20 || !self.can_update_path() {
    // rust: self.ai.nav.delayed_recompute = true;
    // rust: } else if let Some(t) = self.ai.nav.target_pos {
    // rust: self.ai.nav.path = None;
    // rust: let reach = self.ai.nav.reach_range;
    // rust: self.ai.nav.path = self.create_path_to(w, t, reach);
    // rust: self.ai.nav.time_last_recompute = w.game_time;
    // rust: self.ai.nav.delayed_recompute = false;
}
}
    // `PathNavigation.trimPath` for cauldrons, then
    // `GroundPathNavigation.trimPath` with `avoidSun`: a mob that is out of the
    // sun keeps only the nodes before the first one the sky sees.
trim_path :: proc(self: ^Self, w: ^MobWorld) {
}
    // rust: if let Some(path) = &mut self.ai.nav.path {
    // rust: path.raise_cauldron_nodes(|x, y, z| {
    // rust: w.has_tag("minecraft:cauldrons", w.block_name(x, y, z))
    // rust: });
}
    // rust: if !self.ai.nav.avoid_sun
    // rust: || !matches!(self.ai.nav.kind, NavKind::Ground | NavKind::WallClimber)
    // rust: {
    // rust: return;
}
    // rust: let at = [
    // rust: self.navigation_position().x.floor() as i32,
    // rust: (self.navigation_position().y + 0.5).floor() as i32,
    // rust: self.navigation_position().z.floor() as i32,
    // rust: ];
    // rust: if w.can_see_sky(at[0], at[1], at[2]) {
    // rust: return;
}
    // rust: if let Some(path) = &mut self.ai.nav.path
    // rust: && let Some(i) = path.nodes.iter().position(|n| w.can_see_sky(n.x, n.y, n.z))
    // rust: {
    // rust: path.nodes.truncate(i);
}
}
    // `PathNavigation.shouldRecomputePath`: a block changed at `pos` near the
    // middle of what is left of the path.
should_recompute_path :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let nav = &self.ai.nav;
    // rust: if nav.delayed_recompute {
    // rust: return false;
}
    // rust: let Some(path) = nav.path.as_ref().filter(|p| !p.is_done()) else {
    // rust: return false;
}
    // rust: let Some(end) = path.nodes.last() else {
    // rust: return false;
}
    // rust: let middle = Vec3::new(
    // rust: (f64::from(end.x) + self.navigation_position().x) / 2.0,
    // rust: (f64::from(end.y) + self.navigation_position().y) / 2.0,
    // rust: (f64::from(end.z) + self.navigation_position().z) / 2.0,
    // rust: );
    // rust: super::doors::closer_to_center(pos, middle, (path.nodes.len() - path.next) as f64)
}
    // `ServerLevel.sendBlockUpdated` for a mob that should re-path: the
    // recompute happens at the start of its next navigation tick.
queue_path_recompute :: proc(self: ^Self) {
}
    // rust: self.ai.nav.pending_recompute = true;
}
    // Tick the private field while goal access is redirected to the vehicle.
nav_tick :: proc(self: ^Self, w: ^MobWorld) {
}
    // rust: let mut redirect = self.ai.navigation_redirect.take();
    // rust: if let Some(r) = &mut redirect {
    // rust: std::mem::swap(&mut self.ai.nav, &mut r.own);
}
    // rust: self.tick_own_navigation(w);
    // rust: if let Some(r) = &mut redirect {
    // rust: std::mem::swap(&mut self.ai.nav, &mut r.own);
}
    // rust: self.ai.navigation_redirect = redirect;
}
    // PathNavigation.tick.
tick_own_navigation :: proc(self: ^Self, w: ^MobWorld) {
}
    // rust: self.ai.nav.tick += 1;
    // rust: if std::mem::take(&mut self.ai.nav.pending_recompute) {
    // rust: self.recompute_path(w);
}
    // rust: if self.ai.nav.delayed_recompute {
    // rust: self.recompute_path(w);
}
    // rust: if self.ai.nav.kind == NavKind::WallClimber && self.ai.nav.is_done() {
    // rust: if let Some(t) = self.ai.nav.climb_to {
    // rust: let width = f64::from(self.width());
    // rust: let center = |p: [i32; 3]| {
    // rust: let (dx, dy, dz) = (
    // rust: f64::from(p[0]) + 0.5 - self.position.x,
    // rust: f64::from(p[1]) + 0.5 - self.position.y,
    // rust: f64::from(p[2]) + 0.5 - self.position.z,
    // rust: );
    // rust: dx * dx + dy * dy + dz * dz < width * width
}
    // rust: let same_level = [t[0], self.position.y.floor() as i32, t[2]];
    // rust: if !center(t) && (self.position.y <= f64::from(t[1]) || !center(same_level)) {
    // rust: let speed = self.ai.nav.speed_modifier;
    // rust: self.ai.mov.set_wanted(
    // rust: f64::from(t[0]),
    // rust: f64::from(t[1]),
    // rust: f64::from(t[2]),
    // rust: speed,
    // rust: );
    // rust: } else {
    // rust: self.ai.nav.climb_to = None;
}
}
    // rust: return;
}
    // rust: if self.ai.nav.is_done() {
    // rust: return;
}
    // rust: if self.can_update_path() {
    // rust: self.follow_the_path(w);
    // rust: } else if let Some(path) = &self.ai.nav.path
    // rust: && !path.is_done()
    // rust: {
    // rust: let mob = self.temp_mob_pos(w);
    // rust: let pos = path.entity_pos_at(path.next, self.width());
    // rust: let advance = match self.ai.nav.kind {
    // rust: NavKind::Flying => {
    // rust: self.position.x.floor() == pos.x.floor()
    // rust: && self.position.y.floor() == pos.y.floor()
    // rust: && self.position.z.floor() == pos.z.floor()
}
    // rust: _ => {
    // rust: mob.y > pos.y
    // rust: && !self.on_ground
    // rust: && mob.x.floor() == pos.x.floor()
    // rust: && mob.z.floor() == pos.z.floor()
}
}
    // rust: if advance && let Some(p) = &mut self.ai.nav.path {
    // rust: p.advance();
}
}
    // rust: if let Some(path) = &self.ai.nav.path
    // rust: && !path.is_done()
    // rust: {
    // rust: let target = path.entity_pos_at(path.next, self.width());
    // rust: let y = match self.ai.nav.kind {
    // rust: NavKind::Ground | NavKind::WallClimber => {
    // rust: let (bx, by, bz) = (
    // rust: target.x.floor() as i32,
    // rust: target.y.floor() as i32,
    // rust: target.z.floor() as i32,
    // rust: );
    // rust: if w.facts.is_air(w.world.block(bx, by - 1, bz)) {
    // rust: target.y
    // rust: } else {
    // rust: w.floor_level(bx, by, bz)
}
}
    // rust: _ => target.y,
}
    // rust: let speed = self.ai.nav.speed_modifier;
    // rust: self.ai.mov.set_wanted(target.x, y, target.z, speed);
}
}
follow_the_path :: proc(self: ^Self, w: ^MobWorld) {
}
    // rust: let mob_pos = self.temp_mob_pos(w);
    // rust: let width = self.width();
    // rust: self.ai.nav.max_distance_to_waypoint = if width > 0.75 {
    // rust: width / 2.0
    // rust: } else {
    // rust: 0.75 - width / 2.0
}
    // rust: let vertical = match self.ai.nav.kind {
    // rust: NavKind::Water { .. } => 0.5,
    // rust: _ => 1.0,
}
    // rust: let Some(path) = &self.ai.nav.path else {
    // rust: return;
}
    // rust: let n = path.next_node();
    // rust: let xd = (self.position.x - (f64::from(n.x) + 0.5)).abs();
    // rust: let yd = (self.position.y - f64::from(n.y)).abs();
    // rust: let zd = (self.position.z - (f64::from(n.z) + 0.5)).abs();
    // rust: let max = f64::from(self.ai.nav.max_distance_to_waypoint);
    // rust: let close = xd < max && zd < max && yd < vertical;
    // rust: if (close || Navigation::can_cut_corner(n.kind) && self.should_target_next_node(w, mob_pos))
    // rust: && let Some(p) = &mut self.ai.nav.path
    // rust: {
    // rust: p.advance();
}
    // rust: self.do_stuck_detection(w, mob_pos);
}
    // Vanilla's NaN-sensitive `!(a < b)` form.
should_target_next_node :: proc(self: ^Self, w: ^MobWorld, mob: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(path) = &self.ai.nav.path else {
    // rust: return false;
}
    // rust: if path.next + 1 >= path.nodes.len() {
    // rust: return false;
}
    // rust: let n = path.nodes[path.next];
    // rust: let current = Vec3::new(f64::from(n.x) + 0.5, f64::from(n.y), f64::from(n.z) + 0.5);
    // rust: let d = |a: Vec3, b: Vec3| (a.x - b.x).powi(2) + (a.y - b.y).powi(2) + (a.z - b.z).powi(2);
    // rust: if d(mob, current) >= 4.0 {
    // rust: return false;
}
    // rust: if self.can_move_directly(w, mob, path.entity_pos_at(path.next, self.width())) {
    // rust: return true;
}
    // rust: let m = path.nodes[path.next + 1];
    // rust: let next = Vec3::new(f64::from(m.x) + 0.5, f64::from(m.y), f64::from(m.z) + 0.5);
    // rust: let to_current = Vec3::new(current.x - mob.x, current.y - mob.y, current.z - mob.z);
    // rust: let to_next = Vec3::new(next.x - mob.x, next.y - mob.y, next.z - mob.z);
    // rust: let (cs, ns) = (to_current.length_squared(), to_next.length_squared());
    // rust: if !(ns < cs) && !(cs < 0.5) {
    // rust: return false;
}
    // rust: let a = to_current.normalize();
    // rust: let b = to_next.normalize();
    // rust: a.x * b.x + a.y * b.y + a.z * b.z < 0.0
}
can_move_directly :: proc(self: ^Self, w: ^MobWorld, from: Vec3, to: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.ai.nav.kind {
    // rust: NavKind::Flying => w.clear_between(
    // rust: from,
    // rust: Vec3::new(to.x, to.y + f64::from(self.height()) * 0.5, to.z),
    // rust: true,
    // rust: ),
    // rust: NavKind::Water { .. } => w.clear_between(
    // rust: from,
    // rust: Vec3::new(to.x, to.y + f64::from(self.height()) * 0.5, to.z),
    // rust: false,
    // rust: ),
    // rust: NavKind::Amphibious { .. } if self.is_in_liquid() => w.clear_between(
    // rust: from,
    // rust: Vec3::new(to.x, to.y + f64::from(self.height()) * 0.5, to.z),
    // rust: false,
    // rust: ),
    // rust: _ => false,
}
}
do_stuck_detection :: proc(self: ^Self, w: ^MobWorld, mob: Vec3) {
}
    // rust: let speed = self.ai.speed;
    // rust: let nav = &mut self.ai.nav;
    // rust: if nav.tick - nav.last_stuck_check > 100 {
    // rust: let effective = if speed >= 1.0 { speed } else { speed * speed };
    // rust: let threshold = f64::from(effective * 100.0 * 0.25);
    // rust: let d = (mob.x - nav.last_stuck_pos.x).powi(2)
    // rust: + (mob.y - nav.last_stuck_pos.y).powi(2)
    // rust: + (mob.z - nav.last_stuck_pos.z).powi(2);
    // rust: if d < threshold * threshold {
    // rust: nav.stuck = true;
    // rust: nav.path = None;
    // rust: } else {
    // rust: nav.stuck = false;
}
    // rust: nav.last_stuck_check = nav.tick;
    // rust: nav.last_stuck_pos = mob;
}
    // rust: if let Some(path) = &nav.path
    // rust: && !path.is_done()
    // rust: {
    // rust: let n = path.next_node();
    // rust: let pos = [n.x, n.y, n.z];
    // rust: if pos == nav.timeout_node {
    // rust: nav.timeout_timer += w.game_time - nav.last_timeout_check;
    // rust: } else {
    // rust: nav.timeout_node = pos;
    // rust: let c = Vec3::new(f64::from(n.x) + 0.5, f64::from(n.y), f64::from(n.z) + 0.5);
    // rust: let dist =
    // rust: ((mob.x - c.x).powi(2) + (mob.y - c.y).powi(2) + (mob.z - c.z).powi(2)).sqrt();
    // rust: nav.timeout_limit = if speed > 0.0 {
    // rust: dist / f64::from(speed) * 20.0
    // rust: } else {
    // rust: 0.0
}
}
    // rust: if nav.timeout_limit > 0.0 && nav.timeout_timer as f64 > nav.timeout_limit * 3.0 {
    // rust: nav.reset_stuck_timeout();
    // rust: nav.path = None;
}
    // rust: nav.last_timeout_check = w.game_time;
}
}
    // PathNavigation.isStableDestination for the mob's navigation.
stable_destination :: proc(self: ^Self, w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.species() == super::Species::Bee {
    // rust: return super::bee::stable_destination(w, p);
}
    // rust: if self.species() == super::Species::Turtle
    // rust: && let Some(stable) = super::turtle::stable_destination(self, w, p)
    // rust: {
    // rust: return stable;
}
        // StriderPathNavigation: lava too.
    // rust: if self.kind.flags.lava_walker && w.block_name(p[0], p[1], p[2]) == "minecraft:lava" {
    // rust: return true;
}
    // rust: match self.ai.nav.kind {
    // rust: NavKind::Ground | NavKind::WallClimber => {
    // rust: w.facts
    // rust: .get(w.world.block(p[0], p[1] - 1, p[2]))
    // rust: .solid_render
}
    // rust: NavKind::Water { .. } => !w.facts.get(w.world.block(p[0], p[1], p[2])).solid_render,
    // rust: NavKind::Flying => {
    // rust: w.data.state(w.world.block(p[0], p[1], p[2])).flags & super::data::STURDY_TOP != 0
}
    // rust: NavKind::Amphibious { .. } => !w.facts.is_air(w.world.block(p[0], p[1] - 1, p[2])),
}
}
}

    // rust: mod recompute_tests {
//     use super::*;
//     use crate::mobs::path::{Path, PathNode, PathType};

walker :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let kind = crate::mobs::sensor_scan_tests::kind();
    // rust: Mob::new(1, kind, Vec3::new(0.5, 0.0, 0.5), 0.0)
}
straight :: proc(len: i32) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Path {
    // rust: nodes: (0..len)
    // rust: .map(|x| PathNode {
    // rust: x,
    // rust: y: 0,
    // rust: z: 0,
    // rust: kind: PathType::Walkable,
    // rust: })
    // rust: .collect(),
    // rust: next: 0,
    // rust: target: [len - 1, 0, 0],
    // rust: dist_to_target: 0.0,
    // rust: reached: true,
}
}

    // `PathNavigation.shouldRecomputePath`: a block within (nodes left) of the
    // middle of the way to the path's end, and nothing while a recompute waits.
a_change_near_the_middle_of_the_path_asks_for_a_recompute :: proc() {
}
    // rust: let mut m = walker();
    // rust: assert!(!m.should_recompute_path([5, 0, 0]), "no path");
    // rust: m.ai.nav.path = Some(straight(11));
        // The middle of (10, 0, 0) and (0.5, 0, 0.5) is about (5.25, 0, 0.25);
        // 11 nodes are left.
    // rust: assert!(m.should_recompute_path([5, 0, 0]));
    // rust: assert!(m.should_recompute_path([5, 5, 0]));
    // rust: assert!(!m.should_recompute_path([5, 12, 0]), "too far");
    // rust: assert!(!m.should_recompute_path([-9, 0, 0]), "behind the mob");
    // rust: m.ai.nav.delayed_recompute = true;
    // rust: assert!(
    // rust: !m.should_recompute_path([5, 0, 0]),
    // rust: "one is already waiting"
    // rust: );
    // rust: m.ai.nav.delayed_recompute = false;
    // rust: m.ai.nav.path.as_mut().unwrap().next = 11;
    // rust: assert!(!m.should_recompute_path([5, 0, 0]), "the path is done");
}
}

    // rust: mod tests {
//     use super::*;
    // `Frog.FrogPathNavigation.prefersShallowSwimming` has to reach the path
    // finder, or the shallow-water malus never applies to a frog.
the_amphibious_navigation_keeps_its_shallow_preference :: proc() {
}
    // rust: let mut nav = Navigation::default();
    // rust: assert!(
    // rust: matches!(nav.evaluator(), Evaluator::Walk),
    // rust: "ground by default"
    // rust: );
    // rust: nav.kind = NavKind::Amphibious {
    // rust: prefers_shallow: true,
}
    // rust: assert!(matches!(
    // rust: nav.evaluator(),
    // rust: Evaluator::Amphibious {
    // rust: prefers_shallow: true
}
    // rust: ));
    // rust: nav.kind = NavKind::Amphibious {
    // rust: prefers_shallow: false,
}
    // rust: assert!(matches!(
    // rust: nav.evaluator(),
    // rust: Evaluator::Amphibious {
    // rust: prefers_shallow: false
}
    // rust: ));
}

    // `Creeper.getMaxFallDistance` replaces the shared
    // `health - a third` formula with its own `health - 1`: a creeper
    // chasing something drops 22 blocks at full health and 6 at four,
    // where the shared formula would have given 3.
a_creeper_falls_by_its_own_health_while_it_has_a_target :: proc() {
}
        // Skipped without the extracted vanilla data (CI's verify has none).
    // rust: crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:creeper"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: assert_eq!(m.max_fall_distance(), 3, "no target");
    // rust: m.ai.target = Some(crate::mobs::Who::Player);
    // rust: m.health = 20.0;
    // rust: assert_eq!(m.max_fall_distance(), 22, "full health, has a target");
    // rust: m.health = 4.0;
    // rust: assert_eq!(m.max_fall_distance(), 6, "hurt, has a target");
    // rust: });
}

    // `GroundPathNavigation.canUpdatePath`: `onGround() || isInLiquid() ||
    // isPassenger()`. A pig riding a vehicle - a chicken jockey, a husk on a
    // camel, a piglin on a hoglin - can still ask for a path and follow it.
a_mob_riding_a_vehicle_keeps_its_ground_navigation :: proc() {
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: std::sync::Arc::make_mut(&mut kind).species = crate::mobs::Species::Pig;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.on_ground = true;
    // rust: assert!(m.can_update_path(), "standing on the ground");
    // rust: m.on_ground = false;
    // rust: assert!(
    // rust: !m.can_update_path(),
    // rust: "in the air with no vehicle: no path is made or followed"
    // rust: );
    // rust: m.extra.mount = Some(7);
    // rust: assert!(m.can_update_path(), "riding a vehicle: isPassenger()");
    // rust: m.extra.mount = None;
    // rust: m.fluids.in_water = true;
    // rust: assert!(m.can_update_path(), "in a liquid");
}
}
