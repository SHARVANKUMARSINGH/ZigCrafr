//! Transpiled from Horizon Rust crate
//! Module: horizon-client_item_use
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `LivingEntity.startUsingItem` and the use over time of items vanilla's
//! `Item` subclasses don't know: what `Item.getUseDuration` answers, a
//! native mod's own item counted down to its `finishUsingItem`, and the hand
//! pose of a `getUseAnimation` (`native_use_duration`, `native_use_animation`,
//! `native_living_entity_use_item_start`, `native_living_entity_use_item_finish`),
//! and each tick and the release of a use (`native_living_entity_use_item_tick`,
//! `native_on_use_tick`, `native_living_entity_use_item_stop`, `native_release_using`).
// use super::Game;
// use horizon_client::{
    // rust: items::{ItemInfo, ItemStack},
    // rust: spear::Kinetic,
}
// use horizon_world::consumable::UseAnimation;

    // rust: impl Game<'_> {
    /// `LivingEntity.startUsingItem` for the acting player's hand: nothing
    /// when a use runs already or the hand is empty. The use lasts
    /// `getUseDuration` ticks, which mods may change or refuse
    /// (`LivingEntityUseItemEvent.Start`), on both sides as in vanilla. True
    /// when the use started.
    // rust: pub(super) fn start_using_item(&mut self) -> bool {
    // rust: let Some(stack) = self.held().cloned().filter(|_| self.using.is_none()) else {
    // rust: return false;
}
    // rust: let own = self.use_duration(&stack);
    // rust: let (mut duration, mut canceled) = (own, false);
    // rust: let hand = self.hand;
    // rust: self.native_living_entity_use_item_start(&stack, None, hand, &mut duration, &mut canceled);
    // rust: let Some(ticks_set) = start_of(own, duration, canceled) else {
    // rust: return false;
}
    // rust: self.using = Some((self.held_slot(), 0));
    // rust: self.use_duration = duration;
    // rust: self.use_ticks_set = ticks_set;
        // A new charge hears the crossbow's loading sounds again
        // (`game/crossbow.rs`).
    // rust: self.crossbow_sounds = [false; 2];
    // rust: true
}
    /// `ItemStack.getUseDuration`: a consumable's time, 72000 for what is
    /// held until let go, the fixed times of brushes, bundles, spyglasses and
    /// goat horns, 0 for the rest, then a mod's answer.
    // rust: pub(super) fn use_duration(&self, stack: &ItemStack) -> i32 {
    // rust: let info = self.items().get(&stack.item);
    // rust: let mut duration = match &*stack.item {
    // rust: "minecraft:bow" | "minecraft:crossbow" | "minecraft:trident" => 72_000,
    // rust: "minecraft:spyglass" => 1200,
    // rust: "minecraft:brush" => 200,
    // rust: _ if info.is_some_and(|i| i.bundle) => 200,
    // rust: _ if let Some(i) = self.res.items().instrument(stack) => i.use_ticks(),
    // rust: _ => match info {
    // rust: Some(i) if let Some(c) = &i.consumable => c.ticks(),
    // rust: Some(i) if i.blocks_attacks.is_some() => 72_000,
    // rust: _ if Kinetic::of(&stack.item).is_some() => 72_000,
    // rust: _ => 0,
    // rust: },
}
    // rust: self.native_use_duration(stack, &mut duration);
    // rust: duration
}
    /// Whether `stack` is a mod's item that only a mod uses over time: no
    /// `consumable`, `blocks_attacks` or kinetic weapon of vanilla's own, and
    /// a `native_use_duration` above 0. Its use is its own `Item.use`.
    // rust: pub(super) fn mod_use(&self, stack: &ItemStack) -> bool {
    // rust: !stack.item.starts_with("minecraft:")
    // rust: && self
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.consumable.is_none() && i.blocks_attacks.is_none())
    // rust: && Kinetic::of(&stack.item).is_none()
    // rust: && self.use_duration(stack) > 0
}
    /// A right click with a `mod_use` item: `startUsingItem` (CONSUME).
    // rust: pub(super) fn start_mod_use(&mut self, stack: &ItemStack) -> bool {
    // rust: if !self.mod_use(stack) {
    // rust: return false;
}
    // rust: self.start_using_item();
    // rust: true
}
    /// `LivingEntity.updateUsingItem` for a `mod_use` item used `ticks` so far:
    /// `completeUsingItem` once its duration ran out.
    // rust: pub(super) fn tick_mod_use(&mut self, slot: usize, ticks: u32, stack: &ItemStack) {
    // rust: self.item_on_use_tick(stack, ticks);
    // rust: if let Some(ticks) = count_down(ticks, self.use_duration) {
    // rust: self.using = Some((slot, ticks));
    // rust: return;
}
    // rust: let Some(info) = self.items().get(&stack.item).cloned() else {
    // rust: self.using = None;
    // rust: return;
}
    // rust: self.complete_using_item(slot, stack, &info);
}
    /// `ServerPlayer.completeUsingItem` of `stack` in `slot`: the client is
    /// told, `ItemStack.finishUsingItem` (a consumable is eaten, a potion
    /// drunk, a spyglass lowered, anything else given back) with its use
    /// cooldown, then `LivingEntityUseItemEvent.Finish`.
    // rust: pub(super) fn complete_using_item(&mut self, slot: usize, stack: &ItemStack, info: &ItemInfo) {
        // a potion is drunk (no last tick of its own: a mod's tick ran it out).
    // rust: if self.finish_drinking(slot, stack) {
    // rust: self.use_item_finished(stack);
    // rust: self.use_vibration(stack);
    // rust: return;
}
    // rust: self.using = None;
    // rust: self.send_use_item_complete();
    // rust: self.apply_use_cooldown(stack);
    // rust: if let Some(consumable) = &info.consumable {
    // rust: self.finish_consuming(info, consumable, stack);
    // rust: } else if &*stack.item == "minecraft:spyglass" {
    // rust: self.stop_spyglass();
}
    // rust: self.use_item_finished(stack);
        // `LivingEntity.completeUsingItem` ends with `stopUsingItem`.
    // rust: self.use_vibration(stack);
}
    /// `LivingEntityUseItemEvent.Finish` after `finishUsingItem` of `stack`
    /// (no ticks left): the hand holds what a mod made the result.
    // rust: pub(super) fn use_item_finished(&mut self, stack: &ItemStack) {
    // rust: let mut result = self.held().cloned();
    // rust: let before = result.clone();
    // rust: let hand = self.hand;
    // rust: self.native_living_entity_use_item_finish(stack, None, hand, 0, &mut result);
    // rust: if result != before {
    // rust: *self.held_mut() = result.filter(|s| s.count > 0);
}
}
    /// `LivingEntityUseItemEvent.Tick` for `stack` in use `ticks` so far, as
    /// `updatingUsingItem` starts: a mod may change the ticks left, which
    /// moves the end. False when it ran the use out (`tick_ran_out`): the
    /// item's tick and countdown are skipped.
    // rust: pub(super) fn use_item_ticked(&mut self, stack: &ItemStack, ticks: u32) -> bool {
    // rust: let before = ticks_left(self.use_duration, ticks);
    // rust: let (mut remaining, mut canceled) = (before, false);
    // rust: let hand = self.used_hand().unwrap_or(self.hand);
    // rust: self.native_living_entity_use_item_tick(stack, None, hand, &mut remaining, &mut canceled);
    // rust: let (left, set) = tick_left(before, remaining, canceled, self.use_ticks_set);
    // rust: self.use_ticks_set = set;
    // rust: self.use_duration = duration_leaving(ticks, left);
    // rust: left > 0 || !set
}
    /// A mod's `Item.onUseTick` of `stack` used `ticks`, while ticks are left.
    // rust: pub(super) fn item_on_use_tick(&mut self, stack: &ItemStack, ticks: u32) {
    // rust: let remaining = ticks_left(self.use_duration, ticks);
    // rust: if remaining > 0 {
    // rust: self.native_on_use_tick(stack, None, remaining);
}
}
    /// How long `stack`, used `ticks`, counts as held: `getUseDuration` less
    /// the ticks left (`BowItem.releaseUsing`, `CrossbowItem.onUseTick`,
    /// `TridentItem.releaseUsing`), `ticks` unless a mod's Start or Tick
    /// moved the ticks left.
    // rust: pub(super) fn ticks_held(&self, stack: &ItemStack, ticks: u32) -> u32 {
    // rust: held(
    // rust: self.use_duration(stack),
    // rust: ticks_left(self.use_duration, ticks),
    // rust: )
}
    /// `LivingEntityUseItemEvent.Stop` as `releaseUsingItem` lets go of
    /// `stack` used `ticks`: false when a mod skips its `releaseUsing`.
    // rust: pub(super) fn use_item_stopped(&mut self, stack: &ItemStack, ticks: u32) -> bool {
    // rust: let mut canceled = false;
    // rust: let remaining = ticks_left(self.use_duration, ticks);
    // rust: let hand = self.hand;
    // rust: self.native_living_entity_use_item_stop(stack, None, hand, remaining, &mut canceled);
    // rust: !canceled
}
    /// A mod's `Item.releaseUsing` of `stack` used `ticks`: when it says it
    /// was used, `ItemStack.releaseUsing` applies the use cooldown.
    // rust: pub(super) fn mod_release_using(&mut self, stack: &ItemStack, ticks: u32) {
    // rust: let mut used = false;
    // rust: let remaining = ticks_left(self.use_duration, ticks);
    // rust: self.native_release_using(stack, None, remaining, &mut used);
    // rust: if used {
    // rust: self.apply_use_cooldown(stack);
}
}
    /// `Player.canEat(canAlwaysEat)` for `stack`, food that is eaten only
    /// when hungry, then a mod's answer.
    // rust: pub(super) fn can_eat(&self, stack: &ItemStack, can_always_eat: bool) -> bool {
    // rust: let mut can_eat = can_always_eat
    // rust: || self.creative
    // rust: || self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.health.food.food < 20);
    // rust: self.native_can_eat(stack, &mut can_eat);
    // rust: can_eat
}
}

/// The ticks left after a mod's `Tick`, a cancel being NeoForge's -1, and
/// whether a mod ever set this use's: once one did, the use goes on only
/// while some are left, else it ran out. A use no mod touched goes on as
/// vanilla's own do (an eye of ender's has none from the start).
pub fn tick_left(before: i32, remaining: i32, canceled: bool, set: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let left = if canceled { -1 } else { remaining };
    // rust: (left, set || canceled || remaining != before)
}

/// What `releaseUsingItem` runs of a release: the item's own and a mod's
/// `releaseUsing` (not when a mod's `Stop` canceled, nor when the hand
/// changed item, which stops the use without one), and the spyglass's
/// sound (not when canceled).
    // rust: pub(super) fn release_parts(canceled: bool, hand_changed: bool) -> (bool, bool) {
    // rust: (!canceled && !hand_changed, !canceled)
}

    // rust: pub(super) fn bow_release_power(has_ammo: bool, charge: i32, canceled: bool) -> Option<f32> {
    // rust: if canceled || charge < 0 || !has_ammo {
    // rust: return None;
}
    // rust: let f = charge as f32 / 20.0;
    // rust: let power = ((f * f + f * 2.0) / 3.0).min(1.0);
    // rust: (power >= 0.1).then_some(power)
}

/// `useItemRemaining` of a use of `duration` ticks, `ticks` old.
pub fn ticks_left(duration: i32, ticks: u32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: duration.saturating_sub_unsigned(ticks)
}

/// `getUseDuration(stack) - remainingTime` of a use of `own` ticks with
/// `remaining` left, none below 0.
pub fn held(own: i32, remaining: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: u32::try_from(i64::from(own) - i64::from(remaining)).unwrap_or(0)
}

/// The duration that leaves `remaining` ticks of a use `ticks` old, as a
/// mod's `Tick` set them.
pub fn duration_leaving(ticks: u32, remaining: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: remaining.saturating_add_unsigned(ticks)
}

/// What a `Start` left of a use of `own` ticks: None refused (a cancel, or
/// a time below 0, as NeoForge's `startUsingItem` returns), else whether a
/// mod set the ticks left to none. Such a use runs out on its first tick
/// (`tick_left`), as NeoForge's `--useItemRemaining <= 0` completes it, while
/// an item's own 0 (an eye of ender) is held until let go, as vanilla's.
pub fn start_of(own: i32, duration: i32, canceled: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (!canceled && duration >= 0).then_some(duration == 0 && own != 0)
}

/// `Consumable.startConsuming`: a time of 0 or less is no use, the item is
/// consumed at once (`onConsume`).
    // rust: pub(super) fn consumes_at_once(consume_ticks: i32) -> bool {
    // rust: consume_ticks <= 0
}

/// `updateUsingItem`'s `--useItemRemaining == 0` for a use `ticks` old of
/// `duration` ticks: the ticks used after this one, none on the tick it runs
/// out. A time of 0 or less, or one a mod cut below what was used, never
/// does: the use lasts until let go.
    // rust: pub(super) fn count_down(ticks: u32, duration: i32) -> Option<u32> {
    // rust: let ticks = ticks + 1;
    // rust: (i64::from(duration) - i64::from(ticks) != 0).then_some(ticks)
}

/// The first person pose of a hand using an item of `animation`
/// (`ItemInHandRenderer.renderArmWithItem`'s switch), for an item of no
/// pose of its own.
    // rust: pub(super) fn use_pose(
    // rust: animation: UseAnimation,
    // rust: remaining: f32,
    // rust: duration: f32,
    // rust: partial: f32,
    // rust: ) -> horizon_client::first_person::ItemPose {
//     use horizon_client::first_person::ItemPose;
    // rust: let ticks_used = duration - (remaining - partial + 1.0);
    // rust: match animation {
    // rust: UseAnimation::Eat | UseAnimation::Drink => ItemPose::Eat {
    // rust: remaining,
    // rust: duration,
    // rust: partial,
    // rust: },
    // rust: UseAnimation::Bow => ItemPose::Bow { ticks_used },
    // rust: UseAnimation::Trident => ItemPose::Trident { ticks_used },
    // rust: UseAnimation::Brush => ItemPose::Brush { remaining, partial },
    // rust: _ => ItemPose::Using,
}
}

    // rust: mod tests {
//     use super::{
    // rust: bow_release_power, consumes_at_once, count_down, duration_leaving, held, release_parts,
    // rust: start_of, tick_left, ticks_left, use_pose,
}
//     use horizon_client::first_person::ItemPose;
//     use horizon_world::consumable::UseAnimation;

pub fn a_use_runs_out_on_its_last_tick() void {
}
        // a 32 tick food: ticks 0 to 30 go on, the 32nd tick finishes it.
    // rust: assert_eq!(count_down(0, 32), Some(1));
    // rust: assert_eq!(count_down(30, 32), Some(31));
    // rust: assert_eq!(count_down(31, 32), None);
        // a one tick use finishes on its first tick.
    // rust: assert_eq!(count_down(0, 1), None);
        // no time, or one below what was used, waits for the release.
    // rust: assert_eq!(count_down(0, 0), Some(1));
    // rust: assert_eq!(count_down(10, 4), Some(11));
    // rust: assert_eq!(count_down(5, 72_000), Some(6));
}

pub fn a_started_use_finishes_after_its_duration() void {
}
        // start at 0 ticks, count down each tick, finish when it runs out.
    // rust: for duration in [1, 16, 32, 40] {
    // rust: let (mut ticks, mut ticked) = (0, 0);
    // rust: while let Some(next) = count_down(ticks, duration) {
    // rust: ticks = next;
    // rust: ticked += 1;
}
    // rust: assert_eq!(ticked + 1, duration);
}
}

pub fn a_start_below_0_refuses_the_use_and_a_mods_0_runs_out() void {
}
        // a cancel or a time below 0 refuses it.
    // rust: assert_eq!(start_of(32, 32, true), None);
    // rust: assert_eq!(start_of(32, -1, false), None);
    // rust: assert_eq!(start_of(0, -1, false), None);
        // a mod's 0 starts it, and its first tick runs it out.
    // rust: assert_eq!(start_of(32, 0, false), Some(true));
    // rust: let (left, set) = tick_left(0, 0, false, true);
    // rust: assert!(!(left > 0 || !set));
        // an item's own 0 (an eye of ender) goes on, as a changed time does.
    // rust: assert_eq!(start_of(0, 0, false), Some(false));
    // rust: let (left, set) = tick_left(0, 0, false, false);
    // rust: assert!(left > 0 || !set);
    // rust: assert_eq!(start_of(32, 64, false), Some(false));
}

pub fn a_tick_moves_the_end_of_a_use() void {
}
        // a 32 tick use, 10 ticks in: 22 left.
    // rust: assert_eq!(ticks_left(32, 10), 22);
        // a mod leaves 1 tick: the next tick finishes it.
    // rust: let duration = duration_leaving(10, 1);
    // rust: assert_eq!(count_down(10, duration), None);
        // or 30 more: it goes on to tick 40.
    // rust: let duration = duration_leaving(10, 30);
    // rust: assert_eq!(duration, 40);
    // rust: assert_eq!(count_down(38, duration), Some(39));
    // rust: assert_eq!(count_down(39, duration), None);
        // left as it was, nothing moves.
    // rust: assert_eq!(duration_leaving(10, ticks_left(32, 10)), 32);
}

pub fn a_tick_of_no_time_left_runs_the_use_out() void {
}
    // rust: let goes_on = |(left, set): (i32, bool)| left > 0 || !set;
        // untouched, a use goes on, even one of no time (an eye of ender).
    // rust: assert_eq!(tick_left(20, 20, false, false), (20, false));
    // rust: assert!(goes_on(tick_left(-3, -3, false, false)));
        // a mod's ticks left go on while above 0.
    // rust: assert_eq!(tick_left(20, 5, false, false), (5, true));
    // rust: assert!(goes_on(tick_left(20, 5, false, false)));
        // a cancel is -1 left, and it or 0 or less set runs the use out.
    // rust: assert_eq!(tick_left(20, 20, true, false), (-1, true));
    // rust: assert!(!goes_on(tick_left(20, 0, false, false)));
    // rust: assert!(!goes_on(tick_left(20, -1, false, false)));
        // a use a mod ran out stays out on the next ticks (a crossbow frozen).
    // rust: assert!(!goes_on(tick_left(-1, -1, false, true)));
        // and goes on again if a mod gives it ticks back, as NeoForge's.
    // rust: assert!(goes_on(tick_left(-1, 10, false, true)));
}

pub fn a_release_runs_what_vanilla_runs() void {
}
        // let go: the item's release and the spyglass's sound.
    // rust: assert_eq!(release_parts(false, false), (true, true));
        // a mod's Stop canceled: neither.
    // rust: assert_eq!(release_parts(true, false), (false, false));
        // another item in the hand: no release (Horizon still lowers a spyglass).
    // rust: assert_eq!(release_parts(false, true), (false, true));
}

pub fn bow_release_respects_charge_cancel_and_ammo() void {
}
    // rust: assert_eq!(bow_release_power(true, 20, false), Some(1.0));
    // rust: assert_eq!(bow_release_power(true, 10, false), Some(5.0 / 12.0));
    // rust: assert_eq!(bow_release_power(true, 0, false), None);
    // rust: assert_eq!(bow_release_power(true, -1, false), None);
    // rust: assert_eq!(bow_release_power(true, 20, true), None);
    // rust: assert_eq!(bow_release_power(false, 20, false), None);
}

pub fn a_moved_end_moves_the_charge() void {
}
        // a bow held 10 ticks of 72000: 10, as vanilla's.
    // rust: assert_eq!(held(72_000, ticks_left(72_000, 10)), 10);
        // a mod's Tick leaves 71000 at tick 10: it counts as held 1000.
    // rust: assert_eq!(
    // rust: held(72_000, ticks_left(duration_leaving(10, 71_000), 10)),
    // rust: 1000
    // rust: );
        // more ticks left than the item's own time: not held at all.
    // rust: assert_eq!(held(72_000, 80_000), 0);
}

pub fn a_release_tells_how_long_the_item_was_held() void {
}
        // a bow-like item held 25 ticks of 72000: the time left gives the charge back.
    // rust: let left = ticks_left(72_000, 25);
    // rust: assert_eq!(left, 71_975);
    // rust: assert_eq!(72_000 - left, 25);
        // released at once.
    // rust: assert_eq!(ticks_left(72_000, 0), 72_000);
}

pub fn a_food_of_no_time_is_eaten_at_once() void {
}
    // rust: assert!(consumes_at_once(0));
    // rust: assert!(consumes_at_once(-3));
    // rust: assert!(!consumes_at_once(1));
    // rust: assert!(!consumes_at_once(32));
}

pub fn a_use_animation_picks_the_hand_pose() void {
}
    // rust: let pose = |animation| use_pose(animation, 12.0, 32.0, 0.5);
    // rust: assert!(matches!(
    // rust: pose(UseAnimation::Drink),
    // rust: ItemPose::Eat { remaining, duration, partial }
    // rust: if (remaining, duration, partial) == (12.0, 32.0, 0.5)
    // rust: ));
        // ticks used: 32 - (12 - 0.5 + 1).
    // rust: assert!(
    // rust: matches!(pose(UseAnimation::Bow), ItemPose::Bow { ticks_used } if ticks_used == 19.5)
    // rust: );
    // rust: assert!(matches!(
    // rust: pose(UseAnimation::Trident),
    // rust: ItemPose::Trident { ticks_used } if ticks_used == 19.5
    // rust: ));
    // rust: assert!(matches!(
    // rust: pose(UseAnimation::Brush),
    // rust: ItemPose::Brush { remaining, partial } if (remaining, partial) == (12.0, 0.5)
    // rust: ));
    // rust: for animation in [
    // rust: UseAnimation::None,
    // rust: UseAnimation::Block,
    // rust: UseAnimation::Spyglass,
    // rust: ] {
    // rust: assert!(matches!(pose(animation), ItemPose::Using));
}
}
}
