//! Transpiled from Horizon Rust crate
package horizon_client_render_effects

import "core:fmt"
import "core:mem"
import "core:math"

// Player status effects (`MobEffectInstance` / `LivingEntity.activeEffects`):
// add/update with hidden effects, per-tick application of the periodic
// effects (regeneration, poison, wither, hunger, saturation, instant
// effects), and the derived flags the movement and damage code read.
// use horizon_client_core::potions;

EffectInstance :: struct {
    // Effect id: vanilla's without namespace (`speed`, `poison`, ...), a
    // content mod's `<ns>:<path>`.
    id: ^'static str,
    // Remaining ticks; -1 is infinite.
    duration: i32,
    amplifier: i32,
    ambient: bool,
    visible: bool,
    hidden: Maybe(^EffectInstance),
}
    // rust: impl EffectInstance {
new :: proc(id: ^'static str, duration: i32, amplifier: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: id,
    // rust: duration,
    // rust: amplifier: amplifier.clamp(0, 255),
    // rust: ambient: false,
    // rust: visible: true,
    // rust: hidden: None,
}
}
infinite :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.duration == -1
}
    // `MobEffectInstance.endsWithin`.
ends_within :: proc(self: ^Self, ticks: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.infinite() && self.duration <= ticks
}
shorter_than :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.infinite() && (self.duration < other.duration || other.infinite())
}
    // `MobEffectInstance.update`.
update :: proc(self: ^Self, take: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut changed = false;
    // rust: if take.amplifier > self.amplifier {
    // rust: if take.shorter_than(self) {
    // rust: let previous = self.hidden.take();
    // rust: let mut copy = self.clone();
    // rust: copy.hidden = previous;
    // rust: self.hidden = Some(Box::new(copy));
}
    // rust: self.amplifier = take.amplifier;
    // rust: self.duration = take.duration;
    // rust: changed = true;
    // rust: } else if self.shorter_than(take) {
    // rust: if take.amplifier == self.amplifier {
    // rust: self.duration = take.duration;
    // rust: changed = true;
    // rust: } else if let Some(h) = self.hidden.as_mut() {
    // rust: h.update(take);
    // rust: } else {
    // rust: self.hidden = Some(Box::new(EffectInstance {
    // rust: hidden: None,
    // rust: ..take.clone()
    // rust: }));
}
}
    // rust: if !take.ambient && self.ambient || changed {
    // rust: self.ambient = take.ambient;
    // rust: changed = true;
}
    // rust: if take.visible != self.visible {
    // rust: self.visible = take.visible;
    // rust: changed = true;
}
    // rust: changed
}
    // `MobEffectInstance.tickClient`: a client counts its effects down
    // (the server removes them).
tick_client :: proc(self: ^Self) {
}
    // rust: if self.infinite() || self.duration > 0 {
    // rust: self.tick_down();
    // rust: self.downgrade();
}
}
tick_down :: proc(self: ^Self) {
}
    // rust: if let Some(h) = self.hidden.as_mut() {
    // rust: h.tick_down();
}
    // rust: if !self.infinite() {
    // rust: self.duration -= 1;
}
}
downgrade :: proc(self: ^Self) {
}
    // rust: if self.duration == 0
    // rust: && let Some(h) = self.hidden.take()
    // rust: {
    // rust: let h = *h;
    // rust: self.duration = h.duration;
    // rust: self.amplifier = h.amplifier;
    // rust: self.ambient = h.ambient;
    // rust: self.visible = h.visible;
    // rust: self.hidden = h.hidden;
}
}
}
// What an effect tick asks the game to do to the player.
EffectAction :: enum {
    Heal(f32),
    // Damage with a damage type id (`minecraft:magic`, `minecraft:wither`).
    Hurt(&'static str, f32),
    // PoisonMobEffect: one magic damage while above one health.
    Poison,
    Exhaust(f32),
    // FoodData.eat(nutrition, saturation modifier).
    Eat(i32, f32),
}
// `shouldApplyEffectTickThisTick` + `applyEffectTick` for the periodic effects.
periodic :: proc(id: string, tick: i32, amp: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let every = |base: i32| {
    // rust: let interval = base >> amp;
    // rust: interval <= 0 || tick % interval == 0
}
    // rust: match id {
    // rust: "regeneration" if every(50) => Some(EffectAction::Heal(1.0)),
    // rust: "poison" if every(25) => Some(EffectAction::Poison),
    // rust: "wither" if every(40) => Some(EffectAction::Hurt("minecraft:wither", 1.0)),
    // rust: "hunger" => Some(EffectAction::Exhaust(0.005 * (amp + 1) as f32)),
    // rust: "saturation" if tick >= 1 => Some(EffectAction::Eat(amp + 1, 1.0)),
    // rust: "instant_health" if tick >= 1 => Some(EffectAction::Heal((4 << amp.min(30)) as f32)),
    // rust: "instant_damage" if tick >= 1 => Some(EffectAction::Hurt(
    // rust: "minecraft:magic",
    // rust: (6 << amp.min(30)) as f32,
    // rust: )),
    // rust: _ => None,
}
}
// `HealOrHarmMobEffect.applyInstantaneousEffect` (potions apply these directly;
// the amount rounds to the nearest whole point).
instant :: proc(id: string, amp: i32, scale: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: "instant_health" => Some(EffectAction::Heal(
    // rust: (scale * f64::from(4 << amp.min(30)) + 0.5) as i32 as f32,
    // rust: )),
    // rust: "instant_damage" => Some(EffectAction::Hurt(
    // rust: "minecraft:magic",
    // rust: (scale * f64::from(6 << amp.min(30)) + 0.5) as i32 as f32,
    // rust: )),
    // rust: "saturation" => Some(EffectAction::Eat(amp + 1, 1.0)),
    // rust: _ => None,
}
}
// `MobEffectInstance.withScaledDuration`: max(floor(d * scale), 1), leaving
// an infinite (-1) or zero duration alone.
scaled_duration :: proc(duration: i32, scale: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if duration == -1 || duration == 0 {
    // rust: duration
    // rust: } else {
    // rust: ((duration as f32 * scale).floor() as i32).max(1)
}
}
// What an omen's `applyEffectTick` decided.
OmenTick :: enum {
    // It returned true: the effect counts down as usual.
    Continue,
    // It returned false: the effect goes.
    Remove,
    // It added this effect, then returned false.
    Add(EffectInstance),
}
PlayerEffects :: struct {
    list: [dynamic]EffectInstance,
    tick_count: i32,
    // How many times `add` added or updated an effect: each is one
    // `onEffectAdded` or `onEffectUpdated` (`EffectsChangedTrigger`).
    changes: u32,
}
    // rust: impl PlayerEffects {
get :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.list.iter().find(|e| e.id == id)
}
amplifier :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.get(id).map(|e| e.amplifier)
}
    // `LivingEntity.addEffect`; returns whether anything changed.
add :: proc(self: ^Self, effect: EffectInstance) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let changed = match self.list.iter_mut().find(|e| e.id == effect.id) {
    // rust: Some(existing) => existing.update(&effect),
    // rust: None => {
    // rust: self.list.push(effect);
    // rust: true
}
}
    // rust: if changed {
    // rust: self.changes = self.changes.wrapping_add(1);
}
    // rust: changed
}
clear :: proc(self: ^Self) {
}
    // rust: self.list.clear();
}
    // The effects of a saved player (`Player.active_effects`: id,
    // duration, amplifier, ambient, particles visible).
from_saved :: proc(saved: ^[(string) {
}
    // rust: let mut effects = Self::default();
    // rust: for (id, duration, amplifier, ambient, particles) in saved {
    // rust: if let Some(def) = potions::effect(id) {
    // rust: let mut e = EffectInstance::new(def.id, *duration, *amplifier);
    // rust: e.ambient = *ambient;
    // rust: e.visible = *particles;
    // rust: effects.add(e);
}
}
    // rust: effects
}
    // `Player.active_effects` for the save.
saved :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.list
    // rust: .iter()
    // rust: .map(|e| {
    // rust: (
    // rust: potions::namespaced(e.id).to_owned(),
    // rust: e.duration,
    // rust: e.amplifier,
    // rust: e.ambient,
    // rust: e.visible,
    // rust: )
    // rust: })
    // rust: .collect()
}
    // ClientboundUpdateMobEffectPacket's flags without blending: ambient,
    // particles visible and the icon shown (always, for these effects).
flags :: proc(e: ^EffectInstance) -> i {
    // Ported from Horizon
    return {}
}
    // rust: i8::from(e.ambient) | i8::from(e.visible) << 1 | 4
}
    // `LivingEntity.tickEffects` (server part) with the omens' effect ticks:
    // `omen` answers `BadOmenMobEffect` (every tick), `RaidOmenMobEffect`
    // (on its last tick) and a content mod's effect (every tick, with the
    // tick count `shouldApplyEffectTickThisTick` takes); `absorption_empty`
    // is `AbsorptionMobEffect`'s answer: the effect ends once the
    // absorption is used up. Returns the actions to apply, in order, and
    // whether Raid Omen was newly added.
    //
    // Bad Omen turning into a new Raid Omen adds an entry to the map being
    // iterated: vanilla's iterator then throws a
    // `ConcurrentModificationException`, which `tickEffects` swallows. Bad
    // Omen stays (not counted down) and the effects after it are not
    // ticked; the next tick refreshes Raid Omen and drops Bad Omen.
    // rust: pub fn tick_with(
    // rust: &mut self,
    // rust: omen: &mut dyn FnMut(&EffectInstance, i32) -> OmenTick,
    // rust: absorption_empty: bool,
    // rust: ) -> (Vec<EffectAction>, bool) {
    // rust: self.tick_count = self.tick_count.wrapping_add(1);
    // rust: let mut actions = Vec::new();
    // rust: let mut added = false;
    // rust: let mut i = 0;
    // rust: while i < self.list.len() {
    // rust: let e = &self.list[i];
    // rust: if !(e.infinite() || e.duration > 0) {
    // rust: self.list.remove(i);
    // rust: continue;
}
    // rust: let t = if e.infinite() {
    // rust: self.tick_count
    // rust: } else {
    // rust: e.duration
}
    // rust: if let Some(a) = periodic(e.id, t, e.amplifier) {
    // rust: actions.push(a);
}
    // rust: let answer = match e.id {
    // rust: "bad_omen" => omen(e, t),
    // rust: "raid_omen" if t == 1 => omen(e, t),
    // rust: id if potions::is_mod_effect(id) => omen(e, t),
    // rust: "absorption" if absorption_empty => OmenTick::Remove,
    // rust: _ => OmenTick::Continue,
}
    // rust: match answer {
    // rust: OmenTick::Continue => {}
    // rust: OmenTick::Remove => {
    // rust: self.list.remove(i);
    // rust: continue;
}
    // rust: OmenTick::Add(effect) => {
    // rust: if let Some(existing) = self.list.iter_mut().find(|x| x.id == effect.id) {
    // rust: existing.update(&effect);
    // rust: self.list.remove(i);
    // rust: continue;
}
    // rust: self.list.push(effect);
    // rust: added = true;
    // rust: break;
}
}
    // rust: let e = &mut self.list[i];
    // rust: e.tick_down();
    // rust: e.downgrade();
    // rust: if e.infinite() || e.duration > 0 {
    // rust: i += 1;
    // rust: } else {
    // rust: self.list.remove(i);
}
}
    // rust: (actions, added)
}
    // `LivingEntity.tickEffects` (server part): actions to apply, in order.
tick :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.tick_count = self.tick_count.wrapping_add(1);
    // rust: let mut actions = Vec::new();
    // rust: let tick_count = self.tick_count;
    // rust: self.list.retain_mut(|e| {
    // rust: if !(e.infinite() || e.duration > 0) {
    // rust: return false;
}
    // rust: let t = if e.infinite() { tick_count } else { e.duration };
    // rust: if let Some(a) = periodic(e.id, t, e.amplifier) {
    // rust: actions.push(a);
}
    // rust: e.tick_down();
    // rust: e.downgrade();
    // rust: e.infinite() || e.duration > 0
    // rust: });
    // rust: actions
}
    // Effects applied by drinking a potion (`PotionContents.applyToLivingEntity`).
    // rust: pub fn potion_effects(
    // rust: potion: Option<&str>,
    // rust: scale: f32,
    // rust: ) -> (Vec<EffectInstance>, Vec<EffectAction>) {
    // rust: let effects = potion
    // rust: .and_then(potions::potion)
    // rust: .map_or(&[][..], |d| d.effects);
    // rust: Self::contents_effects(effects, scale)
}
    // `PotionContents.forEachEffect`'s effects, as `potion_effects`.
    // rust: pub fn contents_effects(
    // rust: effects: &[(&'static str, i32, i32)],
    // rust: scale: f32,
    // rust: ) -> (Vec<EffectInstance>, Vec<EffectAction>) {
    // rust: let mut lasting = Vec::new();
    // rust: let mut now = Vec::new();
    // rust: for (id, duration, amp) in effects {
    // rust: let id = potions::effect(id).map_or("speed", |e| e.id);
    // rust: if potions::effect(id).is_some_and(|e| e.instant) {
    // rust: now.extend(instant(id, *amp, 1.0));
    // rust: } else {
    // rust: lasting.push(EffectInstance::new(
    // rust: id,
    // rust: scaled_duration(*duration, scale),
    // rust: *amp,
    // rust: ));
}
}
    // rust: (lasting, now)
}
    // Flags for movement and damage code.
status :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: StatusFlags {
    // rust: jump_boost: self.amplifier("jump_boost"),
    // rust: slow_falling: self.get("slow_falling").is_some(),
    // rust: levitation: self.amplifier("levitation"),
    // rust: resistance: self.amplifier("resistance"),
    // rust: fire_resistance: self.get("fire_resistance").is_some(),
    // rust: dolphins_grace: self.get("dolphins_grace").is_some(),
    // rust: weaving: self.get("weaving").is_some(),
    // rust: water_breathing: self.get("water_breathing").is_some()
    // rust: || self.get("conduit_power").is_some(),
    // rust: breath_of_the_nautilus: self.get("breath_of_the_nautilus").is_some(),
    // rust: protection: Vec::new(),
}
}
    // Attribute modifiers of active effects: (attribute, id, amount, operation).
modifiers :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for e in &self.list {
    // rust: if let Some((a, id, amount, op)) = effect_modifier(e.id) {
    // rust: out.push((a, id, amount * f64::from(e.amplifier + 1), op));
}
}
    // rust: out
}
    // `Player.getDestroySpeed` effect factors (haste/conduit, mining fatigue).
mining_speed_factor :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut f = 1.0;
    // rust: let haste = self.amplifier("haste").max(self.amplifier("conduit_power"));
    // rust: if let Some(a) = haste {
    // rust: f *= 1.0 + (a + 1) as f32 * 0.2;
}
    // rust: if let Some(a) = self.amplifier("mining_fatigue") {
    // rust: f *= horizon_core::jmath::pow(0.3, f64::from(a + 1)) as f32;
}
    // rust: f
}
}
// Effect and equipment facts the movement and damage kernels query.
StatusFlags :: struct {
    jump_boost: Maybe(i32),
    slow_falling: bool,
    levitation: Maybe(i32),
    resistance: Maybe(i32),
    fire_resistance: bool,
    dolphins_grace: bool,
    // Weaving: cobwebs hold half as much (`WebBlock.entityInside`).
    weaving: bool,
    water_breathing: bool,
    breath_of_the_nautilus: bool,
    // Armor enchantment protection per damage type id (`EnchantmentHelper.getDamageProtection`).
    protection: Vec<(string,
}
    // rust: impl StatusFlags {
protection :: proc(self: ^Self, damage_type: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.protection
    // rust: .iter()
    // rust: .find(|(t, _)| *t == damage_type)
    // rust: .map_or(0.0, |(_, p)| *p)
}
}

// The attribute modifier an effect adds at amplifier 0
// (`MobEffect.addAttributeModifier`): (attribute, id, amount, operation).
// Each level multiplies the amount (`amplifier + 1`). Vanilla's amounts are
// `float` literals widened to the modifier's `double`, so `f64::from` the
// `f32` to keep the low digits.
effect_modifier :: proc(effect: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match effect {
    // rust: "speed" => Some((
    // rust: "minecraft:movement_speed",
    // rust: "minecraft:effect.speed",
    // rust: f64::from(0.2f32),
    // rust: "add_multiplied_total",
    // rust: )),
    // rust: "slowness" => Some((
    // rust: "minecraft:movement_speed",
    // rust: "minecraft:effect.slowness",
    // rust: f64::from(-0.15f32),
    // rust: "add_multiplied_total",
    // rust: )),
    // rust: "haste" => Some((
    // rust: "minecraft:attack_speed",
    // rust: "minecraft:effect.haste",
    // rust: f64::from(0.1f32),
    // rust: "add_multiplied_total",
    // rust: )),
    // rust: "mining_fatigue" => Some((
    // rust: "minecraft:attack_speed",
    // rust: "minecraft:effect.mining_fatigue",
    // rust: f64::from(-0.1f32),
    // rust: "add_multiplied_total",
    // rust: )),
    // rust: "strength" => Some((
    // rust: "minecraft:attack_damage",
    // rust: "minecraft:effect.strength",
    // rust: 3.0,
    // rust: "add_value",
    // rust: )),
    // rust: "weakness" => Some((
    // rust: "minecraft:attack_damage",
    // rust: "minecraft:effect.weakness",
    // rust: -4.0,
    // rust: "add_value",
    // rust: )),
    // rust: "jump_boost" => Some((
    // rust: "minecraft:safe_fall_distance",
    // rust: "minecraft:effect.jump_boost",
    // rust: 1.0,
    // rust: "add_value",
    // rust: )),
    // rust: "health_boost" => Some((
    // rust: "minecraft:max_health",
    // rust: "minecraft:effect.health_boost",
    // rust: 4.0,
    // rust: "add_value",
    // rust: )),
    // rust: "absorption" => Some((
    // rust: "minecraft:max_absorption",
    // rust: "minecraft:effect.absorption",
    // rust: 4.0,
    // rust: "add_value",
    // rust: )),
    // rust: "luck" => Some(("minecraft:luck", "minecraft:effect.luck", 1.0, "add_value")),
    // rust: "unluck" => Some((
    // rust: "minecraft:luck",
    // rust: "minecraft:effect.unluck",
    // rust: -1.0,
    // rust: "add_value",
    // rust: )),
    // rust: _ => None,
}
}

    // rust: mod tests {
//     use super::*;

adding_counts_a_change_only_when_the_effect_changed :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("speed", 100, 0));
    // rust: assert_eq!(fx.changes, 1);
        // A longer duration updates the effect (`onEffectUpdated`).
    // rust: fx.add(EffectInstance::new("speed", 200, 0));
    // rust: assert_eq!(fx.changes, 2);
        // A shorter one with the same amplifier is hidden by nothing: no change.
    // rust: fx.add(EffectInstance::new("speed", 50, 0));
    // rust: assert_eq!(fx.changes, 2);
}

bad_omen_in_a_village_becomes_raid_omen_over_two_ticks :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("bad_omen", 100, 1));
    // rust: fx.add(EffectInstance::new("speed", 50, 0));
    // rust: let mut convert = |e: &EffectInstance, _: i32| match e.id {
    // rust: "bad_omen" => OmenTick::Add(EffectInstance::new("raid_omen", 600, e.amplifier)),
    // rust: _ => OmenTick::Continue,
}
        // The first tick adds Raid Omen and stops there (the iterator's
        // ConcurrentModificationException): Bad Omen and Speed stay as they were.
    // rust: let (_, added) = fx.tick_with(&mut convert, false);
    // rust: assert!(added);
    // rust: assert_eq!(fx.get("bad_omen").unwrap().duration, 100);
    // rust: assert_eq!(fx.get("speed").unwrap().duration, 50);
    // rust: assert_eq!(fx.get("raid_omen").unwrap().duration, 600);
        // The second refreshes Raid Omen and drops Bad Omen.
    // rust: let (_, added) = fx.tick_with(&mut convert, false);
    // rust: assert!(!added);
    // rust: assert!(fx.get("bad_omen").is_none());
    // rust: assert_eq!(fx.get("speed").unwrap().duration, 49);
    // rust: assert_eq!(fx.get("raid_omen").unwrap().amplifier, 1);
}
    // The only test here that registers mod effects (once per process).
a_mod_effect_saves_under_its_namespace :: proc() {
}
    // rust: potions::register_mod_effects([(
    // rust: "ruby:glow".to_owned(),
    // rust: 0xFF0000,
    // rust: potions::Category::Neutral,
    // rust: )]);
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new(
    // rust: potions::effect("ruby:glow").unwrap().id,
    // rust: 600,
    // rust: 1,
    // rust: ));
    // rust: let saved = fx.saved();
    // rust: assert_eq!(saved, [("ruby:glow".to_owned(), 600, 1, false, true)]);
    // rust: assert_eq!(PlayerEffects::from_saved(&saved).list, fx.list);
        // Without its mod the saved effect is dropped, as an unknown id is.
    // rust: assert!(
    // rust: PlayerEffects::from_saved(&[("gone:glow".into(), 600, 1, false, true)])
    // rust: .list
    // rust: .is_empty()
    // rust: );
}
    // A content mod's effect answers each tick before it counts down (an
    // infinite one with the tick count), and goes at once on Remove.
a_mod_effect_answers_before_it_counts_down :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("ruby:glow", 3, 1));
    // rust: fx.add(EffectInstance::new("ruby:bleed", -1, 0));
    // rust: let mut seen = Vec::new();
    // rust: let mut answer = |e: &EffectInstance, t: i32| {
    // rust: seen.push((e.id, t));
    // rust: match (e.id, t) {
    // rust: ("ruby:glow", 2) => OmenTick::Remove,
    // rust: _ => OmenTick::Continue,
}
}
    // rust: fx.tick_with(&mut answer, false);
    // rust: fx.tick_with(&mut answer, false);
    // rust: let ticks = [
    // rust: ("ruby:glow", 3),
    // rust: ("ruby:bleed", 1),
    // rust: ("ruby:glow", 2),
    // rust: ("ruby:bleed", 2),
    // rust: ];
    // rust: assert_eq!(seen, ticks);
    // rust: assert!(fx.get("ruby:glow").is_none());
    // rust: assert_eq!(fx.get("ruby:bleed").unwrap().duration, -1);
}
raid_omen_acts_on_its_last_tick :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("raid_omen", 2, 0));
    // rust: let mut seen = Vec::new();
    // rust: let mut watch = |e: &EffectInstance, _: i32| {
    // rust: seen.push(e.duration);
    // rust: OmenTick::Remove
}
    // rust: fx.tick_with(&mut watch, false);
    // rust: assert!(fx.get("raid_omen").is_some());
    // rust: fx.tick_with(&mut watch, false);
    // rust: assert!(fx.get("raid_omen").is_none());
    // rust: assert_eq!(seen, vec![1]);
}

update_keeps_stronger_and_hides_longer :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("speed", 9600, 0));
        // A stronger but shorter effect takes over and hides the long one.
    // rust: fx.add(EffectInstance::new("speed", 1800, 1));
    // rust: let e = fx.get("speed").unwrap();
    // rust: assert_eq!((e.amplifier, e.duration), (1, 1800));
    // rust: assert_eq!(
    // rust: e.hidden.as_ref().map(|h| (h.amplifier, h.duration)),
    // rust: Some((0, 9600))
    // rust: );
    // rust: for _ in 0..1800 {
    // rust: fx.tick();
}
    // rust: let e = fx.get("speed").unwrap();
    // rust: assert_eq!((e.amplifier, e.duration), (0, 7800));
        // Weaker and shorter: ignored.
    // rust: assert!(!fx.add(EffectInstance::new("speed", 100, 0)));
}

regeneration_and_poison_intervals :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("regeneration", 900, 0));
    // rust: let heals = (0..900)
    // rust: .flat_map(|_| fx.tick())
    // rust: .filter(|a| *a == EffectAction::Heal(1.0))
    // rust: .count();
        // Duration 900..1 divisible by 50: 18 heals.
    // rust: assert_eq!(heals, 18);
    // rust: assert!(fx.get("regeneration").is_none());
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("poison", 432, 1));
    // rust: let hurts = (0..432)
    // rust: .flat_map(|_| fx.tick())
    // rust: .filter(|a| matches!(a, EffectAction::Poison))
    // rust: .count();
        // Interval 25 >> 1 = 12: 432/12 = 36 hits.
    // rust: assert_eq!(hurts, 36);
}

potions_split_instant_and_lasting :: proc() {
}
    // rust: let (lasting, now) = PlayerEffects::potion_effects(Some("minecraft:strong_healing"), 1.0);
    // rust: assert!(lasting.is_empty());
    // rust: assert_eq!(now, vec![EffectAction::Heal(8.0)]);
    // rust: let (lasting, _) = PlayerEffects::potion_effects(Some("minecraft:long_swiftness"), 0.25);
    // rust: assert_eq!((lasting[0].id, lasting[0].duration), ("speed", 2400));
    // rust: let (lasting, _) = PlayerEffects::potion_effects(Some("minecraft:turtle_master"), 1.0);
    // rust: assert_eq!(lasting.len(), 2);
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("haste", 100, 1));
    // rust: assert!((fx.mining_speed_factor() - 1.4).abs() < 1e-6);
    // rust: assert_eq!(fx.modifiers().len(), 1);
}

absorption_modifier_scales_with_amplifier :: proc() {
}
    // rust: let mut fx = PlayerEffects::default();
    // rust: fx.add(EffectInstance::new("absorption", 2400, 0));
    // rust: assert_eq!(
    // rust: fx.modifiers(),
    // rust: vec![(
    // rust: "minecraft:max_absorption",
    // rust: "minecraft:effect.absorption",
    // rust: 4.0,
    // rust: "add_value",
    // rust: )]
    // rust: );
    // rust: fx.add(EffectInstance::new("absorption", 2400, 3));
    // rust: assert_eq!(
    // rust: fx.modifiers(),
    // rust: vec![(
    // rust: "minecraft:max_absorption",
    // rust: "minecraft:effect.absorption",
    // rust: 16.0,
    // rust: "add_value",
    // rust: )]
    // rust: );
}
}
