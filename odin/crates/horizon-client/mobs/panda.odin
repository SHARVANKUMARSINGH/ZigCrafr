//! Transpiled from Horizon Rust crate
package horizon_client_panda

import "core:fmt"
import "core:mem"
import "core:math"

// Pandas (`Panda`): the genes and what they show, the sit, lie-on-back, roll
// and sneeze states with their goals, the unhappy and eat counters, and the
// client side of the three amounts `PandaModel.setupAnim` reads.
//
// `extra.variant` and `extra.variant2` are the main and the hidden gene
// (`MAIN_GENE_ID`, `HIDDEN_GENE_ID`); the rest is [`State`], whose `flags`,
// `unhappy`, `sneeze` and `eat` are the synched data a server sends.
// use super::{
    // rust: DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: body_anim::Panda as Pose,
    // rust: finalize::{self, Attr},
    // rust: goals::{
    // rust: Avoid, AvoidEntity, Breed, Cx, Float, FollowParent, Goal, HurtByTarget, JUMP, LOOK, MOVE,
    // rust: MeleeAttack, Panic, RandomLookAround, Stroll, Tempt, goal_clone, reduced,
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{
    // rust: Vec3,
    // rust: trig::{DEG_TO_RAD, Mth},
    // rust: },
    // rust: jmath,
    // rust: random::{LegacyRandom, RandomSource},
}

// `Panda.Gene` ids (the order of `Gene.values()`).
LAZY :: 1
WORRIED :: 2
PLAYFUL :: 3
WEAK :: 5
AGGRESSIVE :: 6
// `Gene.getSerializedName`, by id.
    // rust: pub const GENES: [&str; 7] = [
    // rust: "normal",
    // rust: "lazy",
    // rust: "worried",
    // rust: "playful",
    // rust: "brown",
    // rust: "weak",
    // rust: "aggressive",
    // rust: ];

// `DATA_ID_FLAGS`.
FLAG_SNEEZE :: 2
FLAG_ROLL :: 4
FLAG_SIT :: 8
FLAG_ON_BACK :: 16

// The crumbs of one bite: where and how fast each one flies.
    // rust: pub type Crumbs = Vec<([f64; 3], [f64; 3])>;

State :: struct {
    // `DATA_ID_FLAGS` (sneezing, rolling, sitting, on its back).
    flags: u8,
    // `UNHAPPY_COUNTER`, `SNEEZE_COUNTER` and `EAT_COUNTER`.
    unhappy: i32,
    sneeze: i32,
    eat: i32,
    got_bamboo: bool,
    did_bite: bool,
    // `rollCounter`, which a client counts for itself.
    roll_counter: i32,
    roll_delta: [f64,
    // `sitAmount`, `onBackAmount` and `rollAmount` with the tick before.
    sit_amount: [f32,
    on_back_amount: [f32,
    roll_amount: [f32,
    // `isScared` as of the last tick (the model and the item layer read it).
    scared: bool,
    // `PandaLookAtPlayerGoal.lookAt`, which the breed goal can set.
    look_at: Maybe(Who),
    // What the game saw on the ground: any food within 6 blocks, and the
    // first within 8.
    food_near: bool,
    food_at: Option<[f64,
    // The size of the stack in its mouth (the mob holds one item id).
    held_count: u32,
    // What a window draws of the last bite and sneeze, taken by `effects`.
    crumbs: Maybe(Crumbs),
    sneezed: Option<([f64,
}

st :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.panda.get_or_insert_with(Default::default)
}
get :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.panda.as_deref()
}
flag :: proc(m: ^Mob, f: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(m).is_some_and(|s| s.flags & f != 0)
}
set_flag :: proc(m: ^Mob, f: u8, on: bool) {
}
    // rust: let s = st(m);
    // rust: if on {
    // rust: s.flags |= f;
    // rust: } else {
    // rust: s.flags &= !f;
}
}

// ---- genes ----------------------------------------------------------------

// `Panda.getVariant`: the gene a panda shows.
variant :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: finalize::panda_variant(m.extra.variant, m.extra.variant2)
}
is_lazy :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: variant(m) == LAZY
}
is_worried :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: variant(m) == WORRIED
}
is_playful :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: variant(m) == PLAYFUL
}
is_weak :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: variant(m) == WEAK
}
// `Panda.isAggressive`: the gene, not the mob flag.
is_aggressive :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: variant(m) == AGGRESSIVE
}
// `Panda.Gene.getRandom`.
random_gene :: proc(random: ^impl RandomSource) -> u {
    // Ported from Horizon
    return {}
}
    // rust: finalize::panda_gene(random.next_int_bound(16).unwrap_or(0))
}
// `Panda.setAttributes`: a weak panda has 10 health, a lazy one is slow.
set_attributes :: proc(m: ^Mob) {
}
    // rust: if is_weak(m) {
    // rust: finalize::set_base(m, Attr::MaxHealth, 10.0);
}
    // rust: if is_lazy(m) {
    // rust: finalize::set_base(m, Attr::MovementSpeed, f64::from(0.07_f32));
}
}
// `Panda.getBreedOffspring`: `setGeneFromParents`, then `setAttributes`, on
// a baby the game made (its attributes go back to the type's first).
inherit :: proc(child: ^Mob, parent: ^Mob, partner: ^Mob) {
}
    // rust: let r = &mut child.random;
    // rust: let one_of = |p: &Mob, r: &mut LegacyRandom| {
    // rust: if r.next_boolean() {
    // rust: p.extra.variant
    // rust: } else {
    // rust: p.extra.variant2
}
}
    // rust: let (mut main, mut hidden) = if r.next_boolean() {
    // rust: let main = one_of(parent, r);
    // rust: (main, one_of(partner, r))
    // rust: } else {
    // rust: let main = one_of(partner, r);
    // rust: (main, one_of(parent, r))
}
    // rust: if r.next_int_bound(32).unwrap_or(1) == 0 {
    // rust: main = random_gene(r);
}
    // rust: if r.next_int_bound(32).unwrap_or(1) == 0 {
    // rust: hidden = random_gene(r);
}
    // rust: child.extra.variant = main;
    // rust: child.extra.variant2 = hidden;
    // rust: for a in [Attr::MaxHealth, Attr::MovementSpeed] {
    // rust: if let Some(value) = finalize::default_value(child, a) {
    // rust: finalize::set_base(child, a, value);
}
}
    // rust: set_attributes(child);
    // rust: child.health = finalize::max_health(child);
}
// `Panda.Gene.CODEC` for `MainGene` and `HiddenGene`.
gene_from_name :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: GENES.iter().position(|g| *g == name).unwrap_or(0) as u8
}

// ---- state ----------------------------------------------------------------

is_sitting :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FLAG_SIT)
}
is_rolling :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FLAG_ROLL)
}
// `Panda.isOnBack`.
is_on_back :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FLAG_ON_BACK)
}
is_eating :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(m).is_some_and(|s| s.eat > 0)
}
// `Panda.isScared`: a worried panda in a thunderstorm.
is_scared :: proc(m: ^Mob, thundering: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_worried(m) && thundering
}
// `Panda.canPerformAction`.
can_perform_action :: proc(m: ^Mob, thundering: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !is_on_back(m) && !is_scared(m, thundering) && !is_eating(m) && !is_rolling(m) && !is_sitting(m)
}
sit :: proc(m: ^Mob, on: bool) {
}
    // rust: set_flag(m, FLAG_SIT, on);
}
eat :: proc(m: ^Mob, on: bool) {
}
    // rust: st(m).eat = i32::from(on);
}
// `Panda.sneeze`: ending it resets the counter.
sneeze :: proc(m: ^Mob, on: bool) {
}
    // rust: set_flag(m, FLAG_SNEEZE, on);
    // rust: if !on {
    // rust: st(m).sneeze = 0;
}
}
// `Panda.tryToSit`.
try_to_sit :: proc(m: ^Mob) {
}
    // rust: if !m.fluids.in_water {
    // rust: m.ai.zza = 0.0;
    // rust: m.nav_stop();
    // rust: sit(m, true);
}
}
// `Panda.mobInteract` with bamboo in hand while it has a target.
got_bamboo :: proc(m: ^Mob) {
}
    // rust: st(m).got_bamboo = true;
}
// `Panda.hurtServer`: any hurt gets it up.
hurt :: proc(m: ^Mob) {
}
    // rust: sit(m, false);
}
// `Panda.doHurtTarget`: a bite that is not an aggressive panda's.
bit :: proc(m: ^Mob) {
}
    // rust: if !is_aggressive(m) {
    // rust: st(m).did_bite = true;
}
}
// `Panda.setOnBack(false)` from a click on a panda on its back.
get_up :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let was = is_on_back(m);
    // rust: if was {
    // rust: set_flag(m, FLAG_ON_BACK, false);
}
    // rust: was
}
// `Panda.eat(true)` at the first bite of what a player gave it.
start_eating :: proc(m: ^Mob) {
}
    // rust: eat(m, true);
}
// `isScared` as of its last tick, for a click or a sneeze.
scared :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(m).is_some_and(|s| s.scared)
}
// `setItemSlot(MAINHAND, stack)` and `setGuaranteedDrop`, or just the size
// of a stack it was given.
hold :: proc(m: ^Mob, item: string, count: u32, guaranteed: bool) {
}
    // rust: finalize::set_item(m, super::gear::MAIN, item);
    // rust: if guaranteed {
    // rust: finalize::set_drop_chance(m, super::gear::MAIN, 2.0);
}
    // rust: st(m).held_count = count;
}
// What its goals look for on the ground, found by the game each tick.
set_food :: proc(m: ^Mob, near: bool, at: Maybe([f64; 3])) {
}
    // rust: let s = st(m);
    // rust: s.food_near = near;
    // rust: s.food_at = at;
}
// The size of the stack in its mouth, for what it drops.
held_count :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: get(m).map_or(1, |s| s.held_count.max(1))
}

// ---- synched data ---------------------------------------------------------

// `DATA_ID_FLAGS` from a server: a sneeze that ends is a sneeze that was
// done (`afterSneeze`'s particle).
set_flags :: proc(m: ^Mob, flags: u8) {
}
    // rust: if flag(m, FLAG_SNEEZE) && flags & FLAG_SNEEZE == 0 {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let particle = sneeze_particle(at, m.width(), m.body_yaw, m.eye_y(), m.velocity);
    // rust: st(m).sneezed = Some(particle);
}
    // rust: st(m).flags = flags;
}
// `UNHAPPY_COUNTER` and `SNEEZE_COUNTER` from a server.
set_unhappy :: proc(m: ^Mob, unhappy: i32) {
}
    // rust: st(m).unhappy = unhappy;
}
set_sneeze :: proc(m: ^Mob, sneeze: i32) {
}
    // rust: st(m).sneeze = sneeze;
}
// `EAT_COUNTER` from a server: a bite every five.
set_eat :: proc(m: ^Mob, eat: i32) {
}
    // rust: let bite = eat > 0 && eat % 5 == 0 && st(m).eat != eat && m.extra.main_hand.is_some();
    // rust: st(m).eat = eat;
    // rust: if bite {
    // rust: let crumbs = crumbs(m);
    // rust: st(m).crumbs = Some(crumbs);
}
}
// What the window draws since the last call: the crumbs of a bite and the
// sneeze's particle (position, velocity).
effects :: proc(m: ^Mob) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match m.extra.panda.as_deref_mut() {
    // rust: Some(s) => (s.crumbs.take(), s.sneezed.take()),
    // rust: None => (None, None),
}
}

// ---- the tick --------------------------------------------------------------

// `Entity.playSound`: at the feet, never from a silent mob.
play :: proc(m: ^Mob, sound: ^'static str, volume: f32, pitch: f32, events: ^[dynamic]MobEvent) {
}
    // rust: if !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound(sound, at, volume, pitch));
}
}
lerp :: proc(a: f32, o: f32, n: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: o + a * (n - o)
}
// `updateSitAmount`, `updateOnBackAnimation` and `updateRollAmount`.
step_amount :: proc(amount: ^[f32; 2], on: bool) {
}
    // rust: amount[0] = amount[1];
    // rust: amount[1] = if on {
    // rust: (amount[1] + 0.15).min(1.0)
    // rust: } else {
    // rust: (amount[1] - 0.19).max(0.0)
}
}
update_amounts :: proc(m: ^Mob) {
}
    // rust: let (sit, back, roll) = (is_sitting(m), is_on_back(m), is_rolling(m));
    // rust: let s = st(m);
    // rust: step_amount(&mut s.sit_amount, sit);
    // rust: step_amount(&mut s.on_back_amount, back);
    // rust: step_amount(&mut s.roll_amount, roll);
}
// `Panda.handleRoll`; a client counts the roll and leaves the motion to the
// server.
handle_roll :: proc(m: ^Mob, server: bool) {
}
    // rust: let counter = {
    // rust: let s = st(m);
    // rust: s.roll_counter += 1;
    // rust: s.roll_counter
}
    // rust: if counter > 32 {
    // rust: set_flag(m, FLAG_ROLL, false);
    // rust: } else if server {
    // rust: let movement = m.velocity;
    // rust: if counter == 1 {
    // rust: let angle = m.yaw * DEG_TO_RAD;
    // rust: let multiplier = if m.is_baby() { 0.1_f32 } else { 0.2_f32 };
    // rust: let delta = [
    // rust: movement.x + f64::from(-angle.msin() * multiplier),
    // rust: movement.z + f64::from(angle.mcos() * multiplier),
    // rust: ];
    // rust: st(m).roll_delta = delta;
    // rust: m.velocity = Vec3::new(delta[0], 0.27, delta[1]);
    // rust: } else if counter != 7 && counter != 15 && counter != 23 {
    // rust: let [x, z] = st(m).roll_delta;
    // rust: m.velocity = Vec3::new(x, movement.y, z);
    // rust: } else {
    // rust: let y = if m.on_ground { 0.27 } else { movement.y };
    // rust: m.velocity = Vec3::new(0.0, y, 0.0);
}
}
}
rnd :: proc(m: ^Mob, bound: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.random.next_int_bound(bound).unwrap_or(0)
}
// `Panda.handleEating`: the bite's sound and crumbs, and the end of a meal.
handle_eating :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let holds = m.extra.main_hand.is_some();
    // rust: if !is_eating(m) && is_sitting(m) && !is_scared(m, w.thundering) && holds && rnd(m, 80) == 1 {
    // rust: eat(m, true);
    // rust: } else if !holds || !is_sitting(m) {
    // rust: eat(m, false);
}
    // rust: if !is_eating(m) {
    // rust: return;
}
    // addEatingParticles
    // rust: if st(m).eat % 5 == 0 {
    // rust: let volume = 0.5 + 0.5 * rnd(m, 2) as f32;
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: play(m, "entity.panda.eat", volume, pitch, events);
    // rust: if holds {
    // rust: let crumbs = crumbs(m);
    // rust: st(m).crumbs = Some(crumbs);
}
}
    // rust: let count = st(m).eat;
    // rust: if count > 80 && rnd(m, 20) == 1 {
    // rust: let eats_from_ground = m.extra.main_hand.as_deref().is_some_and(|item| {
    // rust: w.items
    // rust: .and_then(|i| i.item_tags.get("minecraft:panda_eats_from_ground"))
    // rust: .is_some_and(|tag| tag.contains(item))
    // rust: });
    // rust: if count > 100 && eats_from_ground {
    // rust: super::drops::clear_slot(m, "mainhand");
    // rust: sit(m, false);
}
    // rust: eat(m, false);
    // rust: return;
}
    // rust: st(m).eat += 1;
}
// The six crumbs of `addEatingParticles`, drawn as the server draws them.
crumbs :: proc(m: ^Mob) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let (x_rot, y_rot) = (-m.head_pitch * DEG_TO_RAD, -m.yaw * DEG_TO_RAD);
    // rust: let body = -m.body_yaw * DEG_TO_RAD;
    // rust: let (x, y, z) = (m.position.x, m.eye_y() + 1.0, m.position.z);
    // rust: (0..6)
    // rust: .map(|_| {
    // rust: let r = &mut m.random;
    // rust: let mut f = || f64::from(r.next_float());
    // rust: let v = Vec3::new((f() - 0.5) * 0.1, f() * 0.1 + 0.1, (f() - 0.5) * 0.1)
    // rust: .rotate_x(x_rot)
    // rust: .rotate_y(y_rot);
    // rust: let p = Vec3::new((f() - 0.5) * 0.8, -f() * 0.6 - 0.3, 1.0 + (f() - 0.5) * 0.4)
    // rust: .rotate_y(body);
    // rust: ([p.x + x, p.y + y, p.z + z], [v.x, v.y + 0.05, v.z])
    // rust: })
    // rust: .collect()
}
// `afterSneeze`'s particle, from the nose.
    // rust: fn sneeze_particle(
    // rust: at: [f64; 3],
    // rust: width: f32,
    // rust: body_yaw: f32,
    // rust: eye: f64,
    // rust: movement: Vec3,
    // rust: ) -> ([f64; 3], [f64; 3]) {
    // rust: let reach = f64::from(width + 1.0) * 0.5;
    // rust: let angle = body_yaw * DEG_TO_RAD;
    // rust: (
    // rust: [
    // rust: at[0] - reach * f64::from(angle.msin()),
    // rust: eye - f64::from(0.1_f32),
    // rust: at[2] + reach * f64::from(angle.mcos()),
    // rust: ],
    // rust: [movement.x, 0.0, movement.z],
    // rust: )
}
// `Panda.afterSneeze`: the particle, the sound, a start for the grown pandas
// about, and a slime ball one sneeze in 700.
after_sneeze :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let particle = sneeze_particle(at, m.width(), m.body_yaw, m.eye_y(), m.velocity);
    // rust: st(m).sneezed = Some(particle);
    // rust: play(m, "entity.panda.sneeze", 1.0, 1.0, events);
    // rust: events.push(MobEvent::PandaSneezed { mob: m.id });
    // rust: events.push(MobEvent::GiftLoot {
    // rust: mob: m.id,
    // rust: table: "minecraft:gameplay/panda_sneeze",
    // rust: at,
    // rust: });
}
// `Panda.tick` after `super.tick()`.
tick :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let thundering = w.thundering;
    // rust: if is_worried(m) {
    // rust: if thundering && !m.fluids.in_water {
    // rust: sit(m, true);
    // rust: eat(m, false);
    // rust: } else if !is_eating(m) {
    // rust: sit(m, false);
}
}
    // rust: if m.ai.target.is_none() {
    // rust: let s = st(m);
    // rust: s.got_bamboo = false;
    // rust: s.did_bite = false;
}
    // rust: let unhappy = st(m).unhappy;
    // rust: if unhappy > 0 {
    // rust: if let Some(t) = m.target_info(w) {
    // rust: m.turn_to([t.position.x, t.eye_y, t.position.z], 90.0, 90.0);
}
    // rust: if unhappy == 29 || unhappy == 14 {
    // rust: play(m, "entity.panda.cant_breed", 1.0, 1.0, events);
}
    // rust: st(m).unhappy -= 1;
}
    // rust: if flag(m, FLAG_SNEEZE) {
    // rust: let count = {
    // rust: let s = st(m);
    // rust: s.sneeze += 1;
    // rust: s.sneeze
}
    // rust: if count > 20 {
    // rust: sneeze(m, false);
    // rust: after_sneeze(m, events);
    // rust: } else if count == 1 {
    // rust: play(m, "entity.panda.pre_sneeze", 1.0, 1.0, events);
}
}
    // rust: if is_rolling(m) {
    // rust: handle_roll(m, true);
    // rust: } else {
    // rust: st(m).roll_counter = 0;
}
    // rust: if is_sitting(m) {
    // rust: m.head_pitch = 0.0;
}
    // rust: st(m).scared = is_scared(m, thundering);
    // rust: update_amounts(m);
    // rust: handle_eating(m, w, events);
    // updateOnBackAnimation and updateRollAmount ran with the others.
}
// `Panda.tick` for a panda a client only displays: the flags and counters
// are the server's; the amounts and the roll count are the client's own.
client_tick :: proc(m: ^Mob, thundering: bool) {
}
    // rust: if is_rolling(m) {
    // rust: handle_roll(m, false);
    // rust: } else {
    // rust: st(m).roll_counter = 0;
}
    // rust: if is_sitting(m) {
    // rust: m.head_pitch = 0.0;
}
    // rust: st(m).scared = is_scared(m, thundering);
    // rust: update_amounts(m);
}

// ---- drawing ---------------------------------------------------------------

// `PandaRenderer.getTextureLocation`.
texture :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let v = usize::from(variant(m)).min(GENES.len() - 1);
    // rust: let gene = GENES[v];
    // rust: match (m.is_baby(), gene) {
    // rust: (false, "normal") => "entity/panda/panda".into(),
    // rust: (false, g) => format!("entity/panda/panda_{g}"),
    // rust: (true, "normal") => "entity/panda/panda_baby".into(),
    // rust: (true, g) => format!("entity/panda/{g}_panda_baby"),
}
}
// What `PandaRenderState` gives `PandaModel.setupAnim`.
pose :: proc(m: ^Mob, partial: f32) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = get(m) else {
    // rust: return Pose::default();
}
    // rust: let amount = |a: &[f32; 2]| lerp(partial, a[0], a[1]);
    // rust: Pose {
    // rust: unhappy: s.unhappy > 0,
    // rust: sneezing: s.flags & FLAG_SNEEZE != 0,
    // rust: sneeze_time: s.sneeze,
    // rust: eating: s.eat > 0,
    // rust: scared: s.scared,
    // rust: sit_amount: amount(&s.sit_amount),
    // rust: lie_on_back_amount: amount(&s.on_back_amount),
    // rust: roll_amount: if m.is_baby() {
    // rust: 0.0
    // rust: } else {
    // rust: amount(&s.roll_amount)
    // rust: },
}
}
// `PandaRenderer.setupRotations` after the common ones: the roll over, the
// sit up and the lie on its back, and a scared panda's shiver.
rotations :: proc(m: ^Mob, partial: f32) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
    // rust: let Some(s) = get(m) else {
    // rust: return Mat4::IDENTITY;
}
    // rust: let baby = m.is_baby();
    // rust: let x_rot = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * partial;
    // rust: let mut t = Mat4::IDENTITY;
    // rust: let translate = |y: f32| Mat4::from_translation(Vec3::new(0.0, y, 0.0));
    // rust: let tilt = |degrees: f32| Mat4::from_rotation_x(degrees.to_radians());
    // rust: if s.roll_counter > 0 {
    // rust: let time = s.roll_counter as f32 + partial;
    // rust: let (pos, frac) = (time.floor() as i32, time.fract());
    // rust: let next = pos + 1;
    // rust: let y = if baby { 0.3 } else { 0.8 };
        // getAngle: the angle between this step and the next, except in the
        // last step of a quarter.
    // rust: let angle = |this: f32, next_angle: f32, threshold: i32| {
    // rust: if next < threshold {
    // rust: lerp(frac, this, next_angle)
    // rust: } else {
    // rust: this
}
}
    // rust: let quarter = pos / 8;
    // rust: if (0..4).contains(&quarter) {
    // rust: let base = 90.0 * quarter as f32;
    // rust: let step = |p: i32| base + 90.0 * (p - quarter * 8) as f32 / 7.0;
    // rust: let a = angle(step(pos), step(next), (quarter + 1) * 8);
    // rust: let lift = match quarter {
    // rust: 0 => (y + 0.2) * (a / 90.0),
    // rust: 1 => y + 0.2 + (y - 0.2) * (a - 90.0) / 90.0,
    // rust: 2 => y + y * (270.0 - a) / 90.0,
    // rust: _ => y * ((360.0 - a) / 90.0),
}
    // rust: t = t * translate(lift) * tilt(-a);
}
}
    // rust: let sit = s.sit_amount;
    // rust: let sit = lerp(partial, sit[0], sit[1]);
    // rust: if sit > 0.0 {
    // rust: t = t * translate(0.8 * sit) * tilt(lerp(sit, x_rot, x_rot + 90.0)) * translate(-sit);
    // rust: if s.scared {
    // rust: let age = m.age as f32 + partial;
    // rust: let shake = (jmath::cos(f64::from(age * 1.25))
    // rust: * std::f64::consts::PI
    // rust: * f64::from(0.05_f32)) as f32;
    // rust: t *= Mat4::from_rotation_y(shake.to_radians());
    // rust: if baby {
    // rust: t *= Mat4::from_translation(Vec3::new(0.0, 0.8, 0.55));
}
}
}
    // rust: let back = lerp(partial, s.on_back_amount[0], s.on_back_amount[1]);
    // rust: if back > 0.0 {
    // rust: let y = if baby { 0.5 } else { 1.3 };
    // rust: t = t * translate(y * back) * tilt(lerp(back, x_rot, x_rot + 180.0));
}
    // rust: t
}
// `PandaHoldsItemLayer`: where the item in its mouth sits, in the model's
// space, while it sits and eats.
item_offset :: proc(m: ^Mob, partial: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = get(m)?;
    // rust: if m.extra.main_hand.is_none() || s.flags & FLAG_SIT == 0 || s.scared {
    // rust: return None;
}
    // rust: let (mut y, mut z) = (1.4_f32, -0.6_f32);
    // rust: if s.eat > 0 {
    // rust: let bite = ((m.age as f32 + partial) * 0.6).msin();
    // rust: z -= 0.2 * bite + 0.2;
    // rust: y -= 0.09 * bite;
}
    // rust: Some(glam::Mat4::from_translation(glam::Vec3::new(0.1, y, z)))
}

// ---- goals -----------------------------------------------------------------

// A goal that starts only when `when` allows it (`PandaAttackGoal`,
// `PandaAvoidGoal`).
When :: struct {
    goal: G,
    when: fn(^Mob,
}
    // rust: impl<G: Goal + Clone + 'static> Goal for When<G> {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (self.when)(m, cx.w) && self.goal.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.can_continue(m, cx)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.interruptable()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.goal.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.goal.stop(m, cx)
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.every_tick()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.goal.tick(m, cx)
}
}
acts :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: can_perform_action(m, w.thundering)
}
avoids :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_worried(m) && acts(m, w)
}

// `PandaPanicGoal`: panics at the environment only, and not while sitting.
PandaPanic :: struct {
    // rust: impl Goal for PandaPanic {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "Panic"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: environmental(m) && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if is_sitting(m) {
    // rust: m.nav_stop();
    // rust: false
    // rust: } else {
    // rust: self.0.can_continue(m, cx)
}
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
}
// `DamageTypeTags.PANIC_ENVIRONMENTAL_CAUSES`, or burning.
environmental :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.fire_ticks > 0 && !m.kind.flags.fire_immune
    // rust: || m.last_damage.is_some_and(|(d, t)| {
    // rust: matches!(
    // rust: d.kind,
    // rust: DamageKind::OnFire
    // rust: | DamageKind::InFire
    // rust: | DamageKind::Lava
    // rust: | DamageKind::Cactus
    // rust: | DamageKind::LightningBolt
    // rust: | DamageKind::HotFloor
    // rust: ) && i64::from(m.age) - t <= 40
    // rust: })
}

// `PandaBreedGoal`: a panda in love finds no mate happy unless there is
// bamboo about.
PandaBreed :: struct {
    breed: Breed,
    unhappy_cooldown: i64,
}
    // rust: impl PandaBreed {
    // `canFindBamboo`: any bamboo within 7 blocks and 2 up.
can_find_bamboo :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: (0..3).any(|y| {
    // rust: (-7..=7).any(|x| {
    // rust: (-7..=7)
    // rust: .any(|z| w.block_name(at[0] + x, at[1] + y, at[2] + z) == "minecraft:bamboo")
    // rust: })
    // rust: })
}
}
    // rust: impl Goal for PandaBreed {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "Breed"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.breed.can_use(m, cx) || st(m).unhappy != 0 {
    // rust: return false;
}
    // rust: if Self::can_find_bamboo(m, cx.w) {
    // rust: return true;
}
    // rust: if self.unhappy_cooldown <= i64::from(m.age) {
    // rust: st(m).unhappy = 32;
    // rust: self.unhappy_cooldown = i64::from(m.age) + 600;
            // The nearest player it looks at while it sulks.
    // rust: let seen = m.can_see_player(cx.w, 8.0);
    // rust: st(m).look_at = seen.then_some(Who::Player);
}
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.breed.can_continue(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.breed.stop(m, cx)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.breed.tick(m, cx)
}
}

// `PandaHurtByTargetGoal`: a panda that was fed bamboo or bit lets go.
PandaHurtBy :: struct {
    // rust: impl Goal for PandaHurtBy {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let s = st(m);
    // rust: if s.got_bamboo || s.did_bite {
    // rust: m.ai.target = None;
    // rust: false
    // rust: } else {
    // rust: self.0.can_continue(m, cx)
}
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
}

// What `PandaSitGoal` and `PandaLieOnBackGoal` ask each tick of their run.
rest_goes_on :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.fluids.in_water && (is_lazy(m) || rnd(m, reduced(600)) != 1) {
    // rust: rnd(m, reduced(2000)) != 1
    // rust: } else {
    // rust: false
}
}

// `PandaSitGoal`: sit down with bamboo or cake in the mouth, or go to get
// some from the ground.
PandaSit :: struct {
    cooldown: i64,
}
    // rust: impl Goal for PandaSit {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.cooldown > i64::from(m.age)
    // rust: || m.is_baby()
    // rust: || m.fluids.in_water
    // rust: || !acts(m, cx.w)
    // rust: || st(m).unhappy > 0
    // rust: {
    // rust: return false;
}
    // rust: m.extra.main_hand.is_some() || st(m).food_near
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: rest_goes_on(m)
}
tick :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: if !is_sitting(m) && m.extra.main_hand.is_some() {
    // rust: try_to_sit(m);
}
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.extra.main_hand.is_none() {
    // rust: if let Some(at) = st(m).food_at {
    // rust: m.nav_move_to_entity(cx.w, at, 0, f64::from(1.2_f32));
}
    // rust: } else {
    // rust: try_to_sit(m);
}
    // rust: self.cooldown = 0;
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(item) = m.extra.main_hand.clone() {
    // rust: let count = held_count(m);
    // rust: cx.events.push(MobEvent::DropItem {
    // rust: mob: m.id,
    // rust: item,
    // rust: count,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: super::drops::clear_slot(m, "mainhand");
    // rust: let wait = if is_lazy(m) {
    // rust: rnd(m, 50) + 10
    // rust: } else {
    // rust: rnd(m, 150) + 10
}
    // rust: self.cooldown = i64::from(m.age) + i64::from(wait) * 20;
}
    // rust: sit(m, false);
}
}

// `PandaLieOnBackGoal`: a lazy panda now and then lies down.
PandaLieOnBack :: struct {
    cooldown: i64,
}
    // rust: impl Goal for PandaLieOnBack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.cooldown < i64::from(m.age) && is_lazy(m) && acts(m, cx.w) && rnd(m, reduced(400)) == 1
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: rest_goes_on(m)
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, FLAG_ON_BACK, true);
    // rust: self.cooldown = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, FLAG_ON_BACK, false);
    // rust: self.cooldown = i64::from(m.age) + 200;
}
}

// `PandaSneezeGoal`: a cub sneezes now and then, a weak one more.
PandaSneeze :: struct {
    // rust: impl Goal for PandaSneeze {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !(m.is_baby() && acts(m, cx.w)) {
    // rust: return false;
}
    // rust: if is_weak(m) && rnd(m, reduced(500)) == 1 {
    // rust: true
    // rust: } else {
    // rust: rnd(m, reduced(6000)) == 1
}
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: sneeze(m, true);
}
}

// `PandaLookAtPlayerGoal`: looks at the nearest player, or at the one the
// breed goal sulks at.
PandaLook :: struct {
    look_time: i32,
}
    // rust: impl PandaLook {
target :: proc(m: ^Mob, cx: ^Cx) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match get(m)?.look_at? {
    // rust: Who::Player => {
    // rust: cx.w.player
    // rust: .as_ref()
    // rust: .filter(|p| p.alive)
    // rust: .map(|p| (p.position, p.eye[1]))
}
    // rust: Who::Mob(id) => {
    // rust: cx.w.seen(id)
    // rust: .filter(|s| s.alive)
    // rust: .map(|s| (s.position, s.eye_y))
}
}
}
}
    // rust: impl Goal for PandaLook {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: LOOK
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "LookAtPlayer"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.random.next_float() >= 0.02 {
    // rust: return false;
}
    // rust: if st(m).look_at.is_none() {
    // rust: let seen = m.can_see_player(cx.w, 6.0);
    // rust: st(m).look_at = seen.then_some(Who::Player);
}
    // rust: acts(m, cx.w) && st(m).look_at.is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((at, _)) = Self::target(m, cx) else {
    // rust: return false;
}
    // rust: m.distance_sqr(at) <= 36.0 && self.look_time > 0
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.look_time = reduced(40 + rnd(m, 40));
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: st(m).look_at = None;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some((at, eye)) = Self::target(m, cx) {
    // rust: m.look_at([at.x, eye, at.z]);
    // rust: self.look_time -= 1;
}
}
}

// `PandaRollGoal`: a cub, or a playful panda, rolls over when it faces a
// drop and now and then at random.
PandaRoll :: struct {
    // rust: impl Goal for PandaRoll {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK | JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !((m.is_baby() || is_playful(m)) && m.on_ground) || !acts(m, cx.w) {
    // rust: return false;
}
    // rust: let angle = m.yaw * DEG_TO_RAD;
    // rust: let (x_dir, z_dir) = (-angle.msin(), angle.mcos());
    // rust: let step = |d: f32| if d.abs() > 0.5 { d.signum() as i32 } else { 0 };
    // rust: let (x, z) = (
    // rust: m.position.x.floor() as i32 + step(x_dir),
    // rust: m.position.z.floor() as i32 + step(z_dir),
    // rust: );
    // rust: let below = m.position.y.floor() as i32 - 1;
    // rust: if cx.w.facts.is_air(cx.w.world.block(x, below, z)) {
    // rust: return true;
}
    // rust: if is_playful(m) && rnd(m, reduced(60)) == 1 {
    // rust: true
    // rust: } else {
    // rust: rnd(m, reduced(500)) == 1
}
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, FLAG_ROLL, true);
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}

// `Panda.registerGoals`.
register :: proc(m: ^Mob) {
}
    // rust: let food = m.kind.food.clone();
    // rust: let monsters = super::species::ALL
    // rust: .iter()
    // rust: .map(|d| d.species)
    // rust: .filter(|s| super::ai::is_monster(*s))
    // rust: .collect::<Vec<Species>>();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(2, PandaPanic(Panic::new(2.0)));
    // rust: g.add(
    // rust: 2,
    // rust: PandaBreed {
    // rust: breed: Breed::new(1.0),
    // rust: unhappy_cooldown: 0,
    // rust: },
    // rust: );
    // rust: g.add(
    // rust: 3,
    // rust: When {
    // rust: goal: MeleeAttack::new(f64::from(1.2_f32), true),
    // rust: when: acts,
    // rust: },
    // rust: );
    // rust: g.add(4, Tempt::new(1.0, food, false));
    // rust: g.add(
    // rust: 6,
    // rust: When {
    // rust: goal: AvoidEntity::new(Avoid::Player, 8.0, 2.0, 2.0),
    // rust: when: avoids,
    // rust: },
    // rust: );
    // rust: g.add(
    // rust: 6,
    // rust: When {
    // rust: goal: AvoidEntity::new(Avoid::Species(monsters), 4.0, 2.0, 2.0),
    // rust: when: avoids,
    // rust: },
    // rust: );
    // rust: g.add(7, PandaSit::default());
    // rust: g.add(8, PandaLieOnBack::default());
    // rust: g.add(8, PandaSneeze);
    // rust: g.add(9, PandaLook::default());
    // rust: g.add(10, RandomLookAround::default());
    // rust: g.add(12, PandaRoll);
    // rust: g.add(13, FollowParent::new(1.25));
    // rust: g.add(14, Stroll::avoiding_water(1.0));
    // alertOther: only an aggressive panda joins in.
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: PandaHurtBy(
    // rust: HurtByTarget::new()
    // rust: .alert()
    // rust: .alert_if(|s| s.species == Species::Panda && s.variant == AGGRESSIVE),
    // rust: ),
    // rust: );
}
