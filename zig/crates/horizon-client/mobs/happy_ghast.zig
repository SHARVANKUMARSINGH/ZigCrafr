//! Transpiled from Horizon Rust crate
//! Module: horizon-client_happy_ghast
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Happy ghasts and ghastlings (`HappyGhast`, `HappyGhastAi`): the adult
//! floats about following torchlight of snowballs and harnesses, the
//! ghastling follows players and adults, a harnessed adult can be ridden and
//! flown, healing is slow (fast in the rain) and `HappyGhastModel`.
// use super::{
    // rust: Mob, MobEvent, MobWorld,
    // rust: anim::{Poses, State},
    // rust: control::{LookKind, MoveKind, Operation},
    // rust: goals::{Cx, Float, Goal, LOOK, MOVE, goal_clone},
    // rust: nav::NavKind,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}

// Happy ghast state: `head` the harness, `scratch[0]` 1 once set up as a
// baby and 2 as an adult, `ai.home` the restriction, `counter`
// the end tick of the follow-an-adult range pick.
// `scratch[1]` is `leashHolderTime` on the server and `IS_LEASH_HOLDER` (1 or 0) on a client.
/// `HappyGhast.notifyLeashHolder` for a leashed mob that supports a quad lead.
pub fn notify_leash_holder(m: *mut Mob) void {
}
    // rust: if m.species() == super::Species::HappyGhast {
    // rust: m.extra.scratch[1] = 5;
}
}
/// `HappyGhast.isLeashHolder`: `IS_LEASH_HOLDER`, true while a quad-leashed
/// mob hangs on it (and four ticks after).
pub fn is_leash_holder(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.scratch[1] > 0
}
/// `Attributes.FLYING_SPEED` and the speed `travel` uses (`* 5 / 3`).
pub const FLYING_SPEED: f64 = 0.05;
pub const AIR_SPEED: f32 = 0.05 * 5.0 / 3.0;

pub fn register(m: *mut Mob) void {
}
    // rust: setup(m, m.is_baby());
}
/// `adultGhastSetup` and `babyGhastSetup`: the ghastling flies with a
/// `FlyingMoveControl` and has no goals (its brain drives it); the adult
/// floats with `GhastMoveControl` and three goals, its brain stopped.
pub fn setup(m: *mut Mob, baby: bool) void {
}
    // rust: let was = m.extra.scratch[0];
    // rust: m.extra.scratch[0] = if baby { 1 } else { 2 };
    // rust: m.ai.goals.clear();
    // rust: m.ai.nav.stop();
    // A new move and look control (nothing wanted) and navigation.
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: m.ai.mov.wanted = [0.0; 3];
    // rust: m.ai.mov.speed_modifier = 0.0;
    // rust: m.ai.look.wanted = [0.0; 3];
    // rust: m.ai.look.cooldown = 0;
    // rust: m.extra.counter2 = 0;
    // The new navigation's PathNavigation constructor.
    // rust: m.ai.nav.required_path_length = 16.0;
    // rust: m.ai.nav.max_visited_nodes =
    // rust: (super::finalize::base_value(m, super::finalize::Attr::FollowRange) * 16.0).floor() as i32;
    // rust: if baby {
    // rust: m.ai.look.kind = LookKind::Default;
    // rust: m.ai.mov.kind = MoveKind::Flying {
    // rust: max_turn: 180.0,
    // rust: hovers: true,
}
        // BabyFlyingPathNavigation.
    // rust: m.ai.nav.kind = NavKind::Flying;
    // rust: m.ai.nav.can_float = true;
    // rust: m.set_required_path_length(48.0);
    // rust: return;
}
    // rust: if was == 1 {
    // rust: super::animal_brain::grown_up(m);
}
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.ai.nav.kind = NavKind::Ground;
    // rust: m.ai.look.kind = LookKind::HappyGhast;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(3, HappyGhastFloat);
    // rust: g.add(4, GhastTempt::default());
    // rust: g.add(5, FloatAround { blocks: 16 });
}
pub fn wearing_harness(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.body.is_some()
}
/// `getControllingPassenger`: a player on a harnessed adult.
pub fn controlled(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.rider.is_some() && harnessed_adult(m)
}
/// A harnessed adult, whether or not a rider is on it yet.
pub fn harnessed_adult(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wearing_harness(m) && !m.is_baby()
}
/// `getHappyGhastRestrictionRadius`.
pub fn restriction_radius(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.is_baby() && m.extra.body.is_none() {
    // rust: 64
    // rust: } else {
    // rust: 32
}
}
/// `Mob.isWithinHome` for the ghast's restriction.
pub fn within_home(m: *Mob, p: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((h, r)) = m.ai.home else {
    // rust: return true;
}
    // rust: let r = f64::from(r);
    // rust: let (dx, dy, dz) = (
    // rust: f64::from(h[0]) + 0.5 - p.x,
    // rust: f64::from(h[1]) + 0.5 - p.y,
    // rust: f64::from(h[2]) + 0.5 - p.z,
    // rust: );
    // rust: dx * dx + dy * dy + dz * dz < r * r
}
/// `isOnStillTimeout`: a player standing on it (or just off it) holds it
/// still (`serverStillTimeout`, kept in `counter`).
pub fn on_still_timeout(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.is_baby() && m.extra.counter > 0
}
/// Client-side `HappyGhast.canBeCollidedWith(Player)`.
pub fn collides_with_player(m: *Mob, feet_y: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: player_collision(
    // rust: m.alive(),
    // rust: m.is_baby(),
    // rust: on_still_timeout(m),
    // rust: feet_y,
    // rust: m.bounds().max_position().y,
    // rust: )
}
pub fn player_collision(alive: bool, baby: bool, still: bool, feet_y: f64, top: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: alive && !baby && (feet_y >= top || still)
}
/// `Mob.stopInPlace`.
pub fn stop_in_place(m: *mut Mob) void {
}
    // rust: m.ai.nav.stop();
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.yya = 0.0;
    // rust: m.ai.zza = 0.0;
    // rust: m.ai.speed = 0.0;
    // rust: m.velocity = Vec3::ZERO;
}
/// `Ghast.GhastMoveControl(careful)`: held still on a still timeout, else
/// a push toward the wanted point every 2 to 6 ticks while the way there
/// is clear.
pub fn move_control(m: *mut Mob, w: *MobWorld) void {
}
    // rust: if on_still_timeout(m) {
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: stop_in_place(m);
}
    // rust: if m.ai.mov.operation != Operation::MoveTo {
    // rust: return;
}
    // floatDuration-- <= 0
    // rust: let duration = m.extra.counter2;
    // rust: m.extra.counter2 -= 1;
    // rust: if duration > 0 {
    // rust: return;
}
    // rust: m.extra.counter2 += m.random.next_int_bound(5).unwrap_or(0) + 2;
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let travel = Vec3::new(wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: if can_reach(m, w, travel) {
        // travel.normalize().scale(FLYING_SPEED * 5 / 3)
    // rust: let len = (travel.x * travel.x + travel.y * travel.y + travel.z * travel.z).sqrt();
    // rust: let unit = if len < f64::from(1.0e-5_f32) {
    // rust: Vec3::ZERO
    // rust: } else {
    // rust: Vec3::new(travel.x / len, travel.y / len, travel.z / len)
}
    // rust: let speed = FLYING_SPEED * 5.0 / 3.0;
    // rust: m.velocity =
    // rust: m.velocity
    // rust: .add_vector(Vec3::new(unit.x * speed, unit.y * speed, unit.z * speed));
    // rust: } else {
    // rust: m.ai.mov.operation = Operation::Wait;
}
}
/// `EntityDimensions.makeBoundingBox` at another position.
pub fn bounds_at(m: *Mob, p: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from(m.width()) / 2.0;
    // rust: let h = f64::from(m.height());
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(p.x + half, p.y + h, p.z + half),
    // rust: )
}
/// `GhastMoveControl.canReach`: every block around the destination box can
/// be crossed, and so can every block the box sweeps through on the way.
pub fn can_reach(m: *Mob, w: *MobWorld, travel: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let aabb = m.bounds();
    // rust: let dest = aabb.move_by(travel);
    // rust: let around = dest.inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: let (lo, hi) = (around.min_position(), around.max_position());
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: if !traversal_possible(m, w, None, [x, y, z], false, false) {
    // rust: return false;
}
}
}
}
    // rust: let (water, lava) = (m.fluids.in_water, m.fluids.in_lava);
    // rust: let start = m.position;
    // rust: let end = start.add_vector(travel);
    // rust: horizon_core::geometry::sweep_intersected_blocks(start, end, dest, 1 << 22, |p, _| {
    // rust: let at = [p.x, p.y, p.z];
    // rust: let unit = Aabb::new(
    // rust: Vec3::new(f64::from(at[0]), f64::from(at[1]), f64::from(at[2])),
    // rust: Vec3::new(
    // rust: f64::from(at[0]) + 1.0,
    // rust: f64::from(at[1]) + 1.0,
    // rust: f64::from(at[2]) + 1.0,
    // rust: ),
    // rust: );
    // rust: aabb.intersects(unit) || traversal_possible(m, w, Some((start, end)), at, water, lava)
    // rust: })
    // rust: .unwrap_or(false)
}
/// `GhastMoveControl.blockTraversalPossible` for a careful ghast: air, or no
/// collision (along the way when `along` is given), never a
/// `#happy_ghast_avoids` block, and a fluid only where the ghast already is.
    // rust: fn traversal_possible(
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: along: Option<(Vec3, Vec3)>,
    // rust: p: [i32; 3],
    // rust: through_water: bool,
    // rust: through_lava: bool,
    // rust: ) -> bool {
    // rust: let state = w.world.block(p[0], p[1], p[2]);
    // rust: if w.facts.is_air(state) {
    // rust: return true;
}
    // rust: let boxes = w.block_collision_boxes(p[0], p[1], p[2]);
    // rust: let no_collisions = match along {
    // rust: Some((from, to)) => !bounds_at(m, from).collided_along_vector(to.subtract(from), &boxes),
    // rust: None => boxes.is_empty(),
}
    // rust: if w.has_tag(
    // rust: "minecraft:happy_ghast_avoids",
    // rust: w.block_name(p[0], p[1], p[2]),
    // rust: ) {
    // rust: return false;
}
    // rust: let (fluid, height) = w.fluid_height(p[0], p[1], p[2]);
    // rust: if fluid != crate::blocks::Fluid::None {
    // rust: let collided = match along {
    // rust: None => true,
            // collidedWithFluid: the fluid's own height.
    // rust: Some((from, to)) => {
    // rust: let fluid_box = Aabb::new(
    // rust: Vec3::new(f64::from(p[0]), f64::from(p[1]), f64::from(p[2])),
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 1.0,
    // rust: f64::from(p[1]) + height,
    // rust: f64::from(p[2]) + 1.0,
    // rust: ),
    // rust: );
    // rust: bounds_at(m, from).collided_along_vector(to.subtract(from), &[fluid_box])
}
}
    // rust: if collided {
    // rust: return match fluid {
    // rust: crate::blocks::Fluid::Water => through_water,
    // rust: _ => through_lava,
}
}
}
    // rust: no_collisions
}
/// `HappyGhast.HappyGhastLookControl`: square to the world on a still
/// timeout, face what it looks at, else face its motion
/// (`Ghast.faceMovementDirection`).
pub fn look_control(m: *mut Mob) void {
}
//     use horizon_core::geometry::trig;
    // rust: let to_deg = 180.0_f32 / std::f32::consts::PI;
    // rust: if on_still_timeout(m) {
        // Mth.wrapDegrees90
    // rust: let mut close = m.yaw % 90.0;
    // rust: if close >= 45.0 {
    // rust: close -= 90.0;
}
    // rust: if close < -45.0 {
    // rust: close += 90.0;
}
    // rust: m.yaw -= close;
    // rust: m.head_yaw = m.yaw;
    // rust: } else if m.ai.look.cooldown > 0 {
    // rust: m.ai.look.cooldown -= 1;
    // rust: let [wx, _, wz] = m.ai.look.wanted;
    // rust: m.yaw = -(trig::atan2(wx - m.position.x, wz - m.position.z) as f32) * to_deg;
    // rust: m.body_yaw = m.yaw;
    // rust: m.head_yaw = m.body_yaw;
    // rust: } else if m.ai.target.is_none() {
    // rust: let v = m.velocity;
    // rust: m.yaw = -(trig::atan2(v.x, v.z) as f32) * to_deg;
    // rust: m.body_yaw = m.yaw;
}
}
/// `HappyGhast.tick`'s still timeout: it runs out (after the first three
/// seconds) unless a player stands on top (`scanPlayerAboveGhast`).
pub fn still_tick(m: *mut Mob, w: *MobWorld) void {
}
    // rust: if m.is_baby() {
    // rust: m.extra.counter = 0;
    // rust: return;
}
    // rust: if m.extra.counter > 0 && m.age > 60 {
    // rust: m.extra.counter -= 1;
}
    // rust: if player_above(m, w) {
    // rust: m.extra.counter = 10;
}
}
/// `scanPlayerAboveGhast`: a player (not one riding a happy ghast) within
/// a block around the top, up to half the ghast's height above it.
pub fn player_above(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = w.player.as_ref().filter(|p| !p.spectator) else {
    // rust: return false;
}
    // rust: if m.rider.is_some() {
    // rust: return false;
}
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let area = Aabb::new(
    // rust: Vec3::new(lo.x - 1.0, hi.y - f64::from(1.0e-5_f32), lo.z - 1.0),
    // rust: Vec3::new(hi.x + 1.0, hi.y + (hi.y - lo.y) / 2.0, hi.z + 1.0),
    // rust: );
    // rust: area.contains(p.position)
}
/// `HappyGhastFloatGoal`: a `FloatGoal` off a still timeout.
pub const HappyGhastFloat = struct {};
    // rust: impl Goal for HappyGhastFloat {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "HappyGhastFloatGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Float.flags()
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !on_still_timeout(m) && Float.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Float.can_use(m, cx)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: Float.tick(m, cx)
}
}
/// `TemptGoal.ForNonPathfinders`: drift toward a player holding food, or
/// food and harnesses for a bare adult.
pub const GhastTempt = struct {
    calm_down: i32,
};
    // rust: impl GhastTempt {
pub fn wants(m: *Mob, item: *?std::sync::*str) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(i) = item else { return false };
    // rust: let harness = !wearing_harness(m) && !m.is_baby() && i.ends_with("_harness");
    // rust: harness || m.kind.food.iter().any(|f| f.as_str() == &**i)
}
}
    // rust: impl Goal for GhastTempt {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "ForNonPathfinders"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.calm_down > 0 {
    // rust: self.calm_down -= 1;
    // rust: return false;
}
    // rust: let Some(p) = &cx.w.player else { return false };
        // getNearestPlayer(TargetingConditions.forNonCombat()
        // .ignoreLineOfSight().range(TEMPT_RANGE 16)): creative players too.
    // rust: let range =
    // rust: (16.0_f64 * p.visibility_percent(Some(m.kind.id.as_str()), cx.w.items)).max(2.0);
    // rust: p.alive
    // rust: && !p.spectator
    // rust: && (Self::wants(m, &p.main_hand) || Self::wants(m, &p.off_hand))
    // rust: && m.distance_sqr(p.position) <= range * range
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
        // stopNavigation: setWait; calmDown = reducedTickDelay(100).
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: self.calm_down = super::goals::reduced(100);
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(p) = cx.w.player.clone() else { return };
    // rust: m.look_at(p.eye);
        // stopDistance 7.
    // rust: if m.distance_sqr(p.position) < 49.0 {
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: } else {
    // rust: let f = m.random.next_double();
    // rust: let at = [
    // rust: (p.eye[0] - m.position.x) * f + m.position.x,
    // rust: (p.eye[1] - m.position.y) * f + m.position.y,
    // rust: (p.eye[2] - m.position.z) * f + m.position.z,
    // rust: ];
    // rust: m.ai.mov.set_wanted(at[0], at[1], at[2], 1.0);
}
}
}
/// `Ghast.RandomFloatAroundGoal` with a restriction and a wish for open
/// air next to something solid.
pub const FloatAround = struct {
    blocks: i32,
};
    // rust: impl FloatAround {
pub fn good(self: *Self, w: *MobWorld, p: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.blocks <= 0 {
    // rust: return true;
}
    // rust: let at = [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: if !w.facts.is_air(w.world.block(at[0], at[1], at[2])) {
    // rust: return false;
}
    // rust: for d in [
    // rust: [1, 0, 0],
    // rust: [-1, 0, 0],
    // rust: [0, 1, 0],
    // rust: [0, -1, 0],
    // rust: [0, 0, 1],
    // rust: [0, 0, -1],
    // rust: ] {
    // rust: for i in 1..self.blocks {
    // rust: if !w.facts.is_air(w.world.block(
    // rust: at[0] + d[0] * i,
    // rust: at[1] + d[1] * i,
    // rust: at[2] + d[2] * i,
    // rust: )) {
    // rust: return true;
}
}
}
    // rust: false
}
}
    // rust: impl Goal for FloatAround {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "RandomFloatAroundGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.ai.mov.has_wanted() {
    // rust: return true;
}
    // rust: let [x, y, z] = m.ai.mov.wanted;
    // rust: let d =
    // rust: (x - m.position.x).powi(2) + (y - m.position.y).powi(2) + (z - m.position.z).powi(2);
    // rust: !(1.0..=3600.0).contains(&d)
}
pub fn can_continue(self: *Self, _: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
    /// `getSuitableFlyToPosition`: the first of 64 random points within 16
    /// blocks (and home) that is good; failing that, the last point, kept
    /// below the motion-blocking surface.
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let c = m.position;
    // rust: let choose = |m: &mut Mob| {
    // rust: let r = &mut m.random;
    // rust: Vec3::new(
    // rust: c.x + f64::from((r.next_float() * 2.0 - 1.0) * 16.0),
    // rust: c.y + f64::from((r.next_float() * 2.0 - 1.0) * 16.0),
    // rust: c.z + f64::from((r.next_float() * 2.0 - 1.0) * 16.0),
    // rust: )
}
    // rust: let mut result: Option<Vec3> = None;
    // rust: for _ in 0..64 {
    // rust: let t = choose(m);
    // rust: result = within_home(m, t).then_some(t);
    // rust: if let Some(t) = result
    // rust: && self.good(cx.w, t)
    // rust: {
    // rust: m.ai.mov.set_wanted(t.x, t.y, t.z, 1.0);
    // rust: return;
}
}
    // rust: let mut t = result.unwrap_or_else(|| choose(m));
    // rust: let top =
    // rust: cx.w.motion_blocking_height(t.x.floor() as i32, t.z.floor() as i32);
    // rust: if top < t.y.floor() as i32 && top > cx.w.world.bottom_y() {
    // rust: t.y = m.position.y - (m.position.y - t.y).abs();
}
    // rust: m.ai.mov.set_wanted(t.x, t.y, t.z, 1.0);
}
}
/// What a rider asks (`getRiddenInput`, `tickRidden`).
pub fn ridden(m: *mut Mob) void {
}
    // rust: let Some(r) = m.rider else { return };
    // tickRidden: turn 8% of the way toward the rider's yaw; pitch half of theirs.
    // rust: let diff = super::living::wrap(r.yaw - m.yaw);
    // rust: m.yaw += diff * 0.08;
    // rust: m.head_pitch = r.pitch * 0.5;
    // rust: m.body_yaw = m.yaw;
    // rust: m.head_yaw = m.yaw;
    // rust: m.ai.nav.stop();
    // rust: let (mut forward, mut up) = (0.0, 0.0);
    // rust: if r.forward != 0.0 {
    // rust: let mut f = r.pitch.to_radians().cos();
    // rust: let mut u = -r.pitch.to_radians().sin();
    // rust: if r.forward < 0.0 {
    // rust: f *= -0.5;
    // rust: u *= -0.5;
}
    // rust: forward = f;
    // rust: up = u;
}
    // rust: if r.jumping {
    // rust: up += 0.5;
}
    // rust: let scale = 3.9 * FLYING_SPEED as f32;
    // rust: m.ai.xxa = r.strafe * scale;
    // rust: m.ai.yya = up * scale;
    // rust: m.ai.zza = forward * scale;
    // rust: m.ai.mov.operation = Operation::Wait;
}
/// The adult or ghastling setup for its age (`ageBoundaryReached`).
pub fn ensure_setup(m: *mut Mob) void {
}
    // rust: let baby = m.is_baby();
    // rust: if m.extra.scratch[0] != if baby { 1 } else { 2 } {
    // rust: setup(m, baby);
}
}
/// `HappyGhast.aiStep`, `tick` and `checkRestriction`: the adult/baby
/// setup at the age boundary, the home, face-the-motion and slow healing.
pub fn ai_step(m: *mut Mob, w: *MobWorld) void {
}
    // rust: ensure_setup(m);
    // HappyGhast.tick: `leashHolderTime` runs down (the synced flag follows it).
    // rust: if m.extra.scratch[1] > 0 {
    // rust: m.extra.scratch[1] -= 1;
}
    // checkRestriction.
    // rust: if m.extra.leash.is_none() && m.rider.is_none() {
    // rust: let radius = restriction_radius(m);
    // rust: let here = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
        // !hasHome || !home.closerThan(blockPosition, radius + 16) || radius changed
    // rust: let stale = match m.ai.home {
    // rust: Some((h, r)) => {
    // rust: (h[0] - here[0]).pow(2) + (h[1] - here[1]).pow(2) + (h[2] - here[2]).pow(2)
    // rust: >= (radius + 16).pow(2)
    // rust: || radius != r
}
    // rust: None => true,
}
    // rust: if stale {
    // rust: m.ai.home = Some((here, radius));
}
}
    // continuousHeal: a point every 30 seconds, every second in rain or snow
    // (Level.precipitationAt).
    // rust: if m.alive() && m.death_time == 0 && m.health < m.attrs.max_health {
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let wet = w.precipitation_at(x, y, z).is_some();
    // rust: let interval = if wet { 20 } else { 600 };
    // rust: if m.age.is_multiple_of(interval) {
    // rust: m.heal(1.0);
}
}
    // rust: still_tick(m, w);
}
/// Sounds: the ghastling has its own.
pub fn sounds(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.is_baby() {
    // rust: [
    // rust: "entity.ghastling.ambient",
    // rust: "entity.ghastling.hurt",
    // rust: "entity.ghastling.death",
    // rust: ]
    // rust: } else {
    // rust: [
    // rust: "entity.happy_ghast.ambient",
    // rust: "entity.happy_ghast.hurt",
    // rust: "entity.happy_ghast.death",
    // rust: ]
}
}
/// `getSoundVolume`: 4 for adults, 1 for ghastlings.
pub fn volume(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.is_baby() { 1.0 } else { 4.0 }
}
/// `HappyGhastModel.setupAnim`: the tentacles, and the body squeezed under a harness.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // HappyGhastHarnessModel.setupAnim: the goggles down while ridden
    // (vanilla's literal -0.7854, not -PI/4).
    // rust: if p.has("goggles") {
    // rust: let g = p.get("goggles");
    // rust: if m.rider.is_some() {
    // rust: g[3] = 0.0;
    // rust: g[1] = 14.0;
    // rust: } else {
    // rust: g[3] = -0.7854;
    // rust: g[1] = 9.0;
}
}
    // rust: if wearing_harness(m) {
    // rust: let b = p.get("body");
    // rust: b[6] = 0.9375;
    // rust: b[7] = 0.9375;
    // rust: b[8] = 0.9375;
}
    // rust: super::nether::ghast_anim(s, p);
}
/// Texture of the harness layer for the worn item.
pub fn harness_texture(item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = item.strip_prefix("minecraft:")?;
    // rust: name.ends_with("_harness")
    // rust: .then(|| format!("entity/equipment/happy_ghast_body/{name}"))
}
/// Events for the player getting on or off.
pub fn goggles(down: bool, m: *Mob) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MobEvent::Sound(
    // rust: if down {
    // rust: "entity.happy_ghast.harness_goggles_down"
    // rust: } else {
    // rust: "entity.happy_ghast.harness_goggles_up"
    // rust: },
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: )
}
    // rust: mod tests {
//     use super::*;

pub fn player_collision_matches_vanilla_top_and_still_timeout_rules() void {
}
    // rust: assert!(player_collision(true, false, false, 84.0, 84.0));
    // rust: assert!(player_collision(true, false, false, 85.0, 84.0));
    // rust: assert!(!player_collision(true, false, false, 83.99, 84.0));
    // rust: assert!(player_collision(true, false, true, 83.99, 84.0));
    // rust: assert!(!player_collision(true, true, true, 84.0, 84.0));
    // rust: assert!(!player_collision(false, false, true, 84.0, 84.0));
}

pub fn a_harness_names_its_texture() void {
}
    // rust: assert_eq!(
    // rust: harness_texture("minecraft:red_harness").as_deref(),
    // rust: Some("entity/equipment/happy_ghast_body/red_harness")
    // rust: );
    // rust: assert_eq!(harness_texture("minecraft:saddle"), None);
}
pub fn travel_speed_is_five_thirds_of_the_flying_speed() void {
}
    // rust: assert!((f64::from(AIR_SPEED) - FLYING_SPEED * 5.0 / 3.0).abs() < 1e-7);
}

    /// `HappyGhast.ageBoundaryReached` runs the setup at the age crossing, not
    /// at the next tick: `DriedGhastBlock.spawnGhastling` makes its ghastling a
    /// baby before `addFreshEntity`, and `AgeableMob.setAge` calls
    /// `ageBoundaryReached` there. Without it the hatched ghastling joins the
    /// level with the adult's three goals, its ground navigation and its brain
    /// stopped, and only its first `aiStep` (`ensure_setup`) fixes that.
pub fn a_hatched_ghastling_is_set_up_as_one_at_the_age_crossing() void {
}
//         use crate::mobs::Species;
    // rust: let mut t = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: t.species = Species::HappyGhast;
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(t),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: );
        // `Mob::new` registers the adult's goals (HappyGhastFloat, its tempt
        // goal and FloatAround) for the age-zero ghast it makes.
    // rust: assert_eq!(m.extra.scratch[0], 2, "an adult's setup at construction");
    // rust: assert!(m.ai.goals.has("HappyGhastFloatGoal"));

    // rust: crate::mobs::finalize::set_age(&mut m, -24000);

    // rust: assert!(m.is_baby());
    // rust: assert_eq!(m.extra.scratch[0], 1, "babyGhastSetup ran");
    // rust: assert!(
    // rust: !m.ai.goals.has("HappyGhastFloatGoal")
    // rust: && !m.ai.goals.has("RandomFloatAroundGoal")
    // rust: && !m.ai.goals.has("ForNonPathfinders"),
    // rust: "a ghastling has no goals: its brain drives it"
    // rust: );
    // rust: assert_eq!(m.ai.nav.kind, crate::mobs::nav::NavKind::Flying);
    // rust: assert!(m.ai.nav.can_float);
}
}
