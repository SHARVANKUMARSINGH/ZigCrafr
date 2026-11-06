//! Transpiled from Horizon Rust crate
//! Module: horizon-client_hand
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The local player's hand: clicks and held attack through
//! `horizon_client::first_person` (`Minecraft.startAttack` /
//! `continueAttack`, `MultiPlayerGameMode` block breaking), the arm swing
//! (`LivingEntity.SwingState`) and the first-person equip heights
//! (`FirstPersonHandsAndItems`) with the item swap ticker they read.
// use super::{Game, Mining, Screen, minecarts::CartKind};
// use horizon_client::{
    // rust: Result,
    // rust: attack_strength::HeldStack,
    // rust: first_person::{Hand, HandWorld, Hit, SwingAnimation, UseResult, swing_duration},
    // rust: items::ItemStack,
}
// use horizon_core::geometry::{Aabb, Vec3};

/// The off hand's place in `visible_hands` (the main hand uses its hotbar slot).
pub const OFFHAND: usize = usize::MAX;

/// `AttackRange.effectiveMinRange`, `effectiveMaxRange` (for a player) and
/// `hitboxMargin` of an `attack_range` component.
pub fn attack_reach(range: *serde_json::Value, creative: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = |key: &str, default: f32| range[key].as_f64().map_or(default, |v| v as f32);
    // rust: let (min, max) = if creative {
    // rust: (
    // rust: value("min_creative_reach", 0.0),
    // rust: value("max_creative_reach", 5.0),
    // rust: )
    // rust: } else {
    // rust: (value("min_reach", 0.0), value("max_reach", 3.0))
}
    // rust: (min, max, value("hitbox_margin", 0.3))
}

pub fn v3(v: [f64; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(v[0], v[1], v[2])
}

/// `LocalPlayer.raycastHitResult` with an item that has an attack range
/// (`AttackRange.getClosesetHit`): the distance from the eye to the nearest
/// box hit along the item's own `reach`, which goes past the plain pick's
/// 3 blocks (a spear's 4.5). A miss falls back to the plain pick (`None`).
    // rust: fn reach_pick(
    // rust: boxes: &[(usize, Aabb)],
    // rust: eye: Vec3,
    // rust: look: Vec3,
    // rust: movement: Vec3,
    // rust: reach: (f32, f32, f32),
    // rust: clip: impl Fn(Vec3, Vec3) -> Option<Vec3>,
    // rust: ) -> Option<f64> {
    // rust: super::spear::hits_in_reach(boxes, eye, look, movement, reach, clip)
    // rust: .into_iter()
    // rust: .map(|(_, at)| eye.distance_squared(at).sqrt())
    // rust: .reduce(f64::min)
}

/// `AttackRange.isInRange`: float bounds, then inclusive double comparison.
pub fn attack_range_contains(range: *serde_json::Value, distance: f64, creative: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min, max, margin) = attack_reach(range, creative);
    // rust: distance >= f64::from(min - margin) && distance <= f64::from(max + margin)
}

/// `FirstPersonHandsAndItems.shouldInstantlyReplaceVisibleItem`'s
/// `ItemStack.matchesIgnoringComponents(visible, held,
/// DataComponentType::ignoreSwapAnimation)` for one hand (every item plays
/// the swap animation, `ItemModelResolver.shouldPlaySwapAnimation`): the same
/// stack object, or an equal one, whose damage (the one component built
/// with `ignoreSwapAnimation`) may differ.
///
/// A stack that stays in its slot with the same item is the same object,
/// whatever its count or damage (vanilla shrinks, grows and damages it in
/// place), unless the slot was `replaced` by one the hand doesn't show yet:
/// swapping the hands (`setItemInHand`, and the server's slot updates that
/// answer it) puts another object in both (#2866).
    // rust: fn shows_held_stack(
    // rust: visible: &(usize, Option<ItemStack>),
    // rust: held: &(usize, Option<ItemStack>),
    // rust: replaced: bool,
    // rust: ) -> bool {
    // rust: let same_object = visible.0 == held.0 && !replaced;
    // rust: match (&visible.1, &held.1) {
    // rust: (Some(a), Some(b)) if same_object => a.item == b.item,
    // rust: (a, b) => matches_for_swap(a.as_ref(), b.as_ref()),
}
}

/// `ItemStack.matchesIgnoringComponents(a, b,
/// DataComponentType::ignoreSwapAnimation)`: the same count, item and
/// components but damage.
    // rust: pub(super) fn matches_for_swap(a: Option<&ItemStack>, b: Option<&ItemStack>) -> bool {
    // rust: match (a, b) {
    // rust: (None, None) => true,
    // rust: (Some(a), Some(b)) => a.count == b.count && a.item == b.item && a.extra == b.extra,
    // rust: _ => false,
}
}

/// `AttackRange.isInRange(attacker, box, buffer)` with the reach of
/// `attack_reach` (or `AttackRange.defaultFor`'s, from the entity interaction
/// range): the eye's distance to the box, inclusive.
pub fn in_attack_range(distance: f64) void {
}
    // rust: distance >= f64::from(min - margin) - buffer && distance <= f64::from(max + margin) + buffer
}

    // rust: impl Game<'_> {
    /// `getAttributeValue` of an interaction range of the player in place (a
    /// guest swapped in on a server): creative's modifiers are on it
    /// (`update_player_attributes`), as are `/attribute`'s and the items'.
    // rust: pub(super) fn interaction_range(
    // rust: &mut self,
    // rust: attribute: &str,
    // rust: survival: f64,
    // rust: creative: f64,
    // rust: ) -> f64 {
    // rust: let otherwise = if self.creative { creative } else { survival };
    // rust: self.player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute(attribute).ok())
    // rust: .unwrap_or(otherwise)
}

    /// ServerGamePacketListenerImpl.handleAttack's
    /// `Player.isWithinAttackRange(mainHandItem, box, 3.0)` for the player in
    /// place: the held item's `attack_range`, else `AttackRange.defaultFor`
    /// (0 to the entity interaction range, no margin). Out of range, vanilla
    /// drops the attack without a word.
    // rust: pub(super) fn within_attack_range(&mut self, target: &Aabb) -> bool {
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return false;
}
    // rust: let range = self.held().and_then(|stack| {
    // rust: self.pack
    // rust: .item_renderer
    // rust: .models
    // rust: .components(&horizon_client::item_render::stack_view(stack))
    // rust: .get("minecraft:attack_range")
    // rust: .cloned()
    // rust: });
    // rust: let reach = match &range {
    // rust: Some(r) => attack_reach(r, self.creative),
    // rust: None => {
    // rust: let range = self.interaction_range("minecraft:entity_interaction_range", 3.0, 5.0);
    // rust: (0.0, range as f32, 0.0)
}
}
    // rust: let distance = target.distance_squared_to_point(v3(eye)).sqrt();
    // rust: in_attack_range(distance, reach, 3.0)
}

    /// `Player.isWithinEntityInteractionRange(box, buffer)` for the player in
    /// place (ServerGamePacketListenerImpl.handleInteract, with 3).
    // rust: pub(super) fn within_entity_interaction_range(&mut self, target: &Aabb, buffer: f64) -> bool {
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return false;
}
    // rust: let range = self.interaction_range("minecraft:entity_interaction_range", 3.0, 5.0) + buffer;
    // rust: target.distance_squared_to_point(v3(eye)) < range * range
}

    /// A slot of the inventory (`OFFHAND_SLOT` for the off hand) was set to
    /// a new stack: the hand holding it compares it as another `ItemStack`
    /// (`shows_held_stack`) until the hand shows the held stack again.
    // rust: pub(super) fn hand_stack_replaced(&mut self, slot: usize) {
    // rust: if slot == self.selected {
    // rust: self.hands_replaced[0] = true;
}
    // rust: if slot == super::shield::OFFHAND_SLOT {
    // rust: self.hands_replaced[1] = true;
}
}
    /// Opening a screen stops breaking before the next game tick (which may pause).
    // rust: pub(super) fn stop_mining(&mut self) {
    // rust: if self.clicks.destroying.active {
    // rust: let pos = self.clicks.destroying.pos;
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.tutorial_destroy(state, -1.0);
}
    // rust: let mut destroying = std::mem::take(&mut self.clicks.destroying);
    // rust: destroying.stop(&mut GameHands {
    // rust: game: self,
    // rust: error: None,
    // rust: });
    // rust: self.clicks.destroying = destroying;
    // rust: self.attack_clicks = 0;
    // rust: self.use_clicks = 0;
    // rust: self.request_remote_mining_stop();
    // rust: self.mining = None;
}
    /// `LivingEntity.swing` with `getModifiedSwingDuration`.
    // rust: pub(super) fn swing_hand(&mut self, hand: Hand, animation: SwingAnimation) {
    // rust: let effects = &self.potions.effects;
    // rust: let dig_speed = effects
    // rust: .amplifier("haste")
    // rust: .max(effects.amplifier("conduit_power"));
    // rust: let fatigue = effects.amplifier("mining_fatigue");
    // rust: let duration = swing_duration(animation, dig_speed, fatigue);
    // rust: if self.swing.start_if_able(hand, animation, duration) {
    // rust: self.swings_started += 1;
}
}
    /// `swing(hand)` for the hand that acts, with the default animation.
    // rust: pub(super) fn swing_arm(&mut self) {
    // rust: self.swing_hand(self.hand, SwingAnimation::DEFAULT);
}
    /// `Player.resetAttackStrengthTicker`.
    // rust: pub(super) fn reset_attack_strength(&mut self) {
    // rust: self.attack_ticks = 0;
    // rust: self.hand_strength.reset();
}
    /// `Minecraft.tick`'s `pick`, then `handleKeybinds`' number keys: the
    /// tick's clicks act on what the item held before the keys picked (a
    /// spear's 4.5 blocks), with the item the keys select (attribute
    /// swapping a spear's reach onto a mace).
    // rust: pub(super) fn pick_tick_targets(&mut self) {
    // rust: self.tick_hit = Some(self.pick());
    // rust: self.tick_mob = None;
    // rust: let mob = match self.active_attack_range() {
    // rust: Some(range) => self.attack_range_pick(&range),
    // rust: None => None,
}
    // rust: self.tick_mob = Some(mob.unwrap_or_else(|| self.mob_hit()));
    // rust: self.select_queued_hotbar();
}
    /// `handleKeybinds`' number keys (`keyHotbarSlots[i].consumeClick`).
    // rust: pub(super) fn select_queued_hotbar(&mut self) {
    // rust: for slot in std::mem::take(&mut self.hotbar_presses) {
    // rust: self.selected = slot;
}
}
    /// The tick's clicks are done: later picks follow the crosshair again.
    // rust: pub(super) fn release_tick_targets(&mut self) {
    // rust: self.tick_hit = None;
    // rust: self.tick_mob = None;
}
    /// `Minecraft.startAttack` on an entity: a main-hand item with an
    /// `attack_range` attacks only a hit inside it.
    // rust: pub(super) fn held_range_allows(&self, distance: f64) -> bool {
    // rust: let range = self.held().and_then(|stack| {
    // rust: self.pack
    // rust: .item_renderer
    // rust: .models
    // rust: .components(&horizon_client::item_render::stack_view(stack))
    // rust: .get("minecraft:attack_range")
    // rust: .cloned()
    // rust: });
    // rust: range.is_none_or(|r| attack_range_contains(&r, distance, self.creative))
}
    /// `LocalPlayer.raycastHitResult`'s item (`getActiveItem`: the one in
    /// use, else the main hand's) `attack_range` component.
pub fn active_attack_range(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let active = self
    // rust: .using
    // rust: .and_then(|(slot, _)| self.inventory.get(slot).and_then(Option::as_ref))
    // rust: .or_else(|| self.held())?;
    // rust: self.pack
    // rust: .item_renderer
    // rust: .models
    // rust: .components(&horizon_client::item_render::stack_view(active))
    // rust: .get("minecraft:attack_range")
    // rust: .cloned()
}
    /// `AttackRange.getClosesetHit` against the mobs `mob_hit` can pick
    /// (`EntitySelector.CAN_BE_PICKED`), as `raycastHitResult` reads it: the
    /// nearest mob hit within the item's reach; no mob when the clip met a
    /// block within the block reach (`getHitEntitiesAlong`'s block result,
    /// kept by `filterHitResult`); `None` on a miss, where the plain pick
    /// decides.
    // rust: fn attack_range_pick(
    // rust: &self,
    // rust: range: &serde_json::Value,
    // rust: ) -> Option<Option<(usize, f64, [f64; 3])>> {
    // rust: let eye = v3(self.eye_position()?);
    // rust: let look = v3(super::view_vector(self.yaw, self.pitch));
    // rust: let reach = attack_reach(range, self.creative);
    // rust: let camera = self.remote_camera_id();
    // rust: let boxes: Vec<(usize, Aabb)> = (self.mobs.iter().enumerate())
    // rust: .filter(|(_, m)| !m.removed && Some(m.id) != self.riding && Some(m.id) != camera)
    // rust: .map(|(i, m)| (i, m.bounds()))
    // rust: .collect();
    // rust: let clip = |from: Vec3, to: Vec3| {
    // rust: let length = from.distance_squared(to).sqrt();
    // rust: let d = to.subtract(from).scale(1.0 / length);
    // rust: (length > 0.0)
    // rust: .then(|| self.clip_ray([from.x, from.y, from.z], [d.x, d.y, d.z], length))
    // rust: .flatten()
    // rust: .map(|hit| Vec3::new(hit.point[0], hit.point[1], hit.point[2]))
}
    // rust: let movement = self.known_player_movement();
    // rust: let nearest = super::spear::hits_in_reach(&boxes, eye, look, movement, reach, clip)
    // rust: .into_iter()
    // rust: .map(|(i, at)| {
    // rust: let feet = self.mobs[i].position;
    // rust: (
    // rust: i,
    // rust: eye.distance_squared(at).sqrt(),
    // rust: super::interact_location(at, feet),
    // rust: )
    // rust: })
    // rust: .reduce(|a, b| if b.1 < a.1 { b } else { a });
    // rust: if nearest.is_some() {
    // rust: return Some(nearest);
}
    // rust: let to = eye.add_vector(look.scale(f64::from(reach.1) + movement.dot(look).max(0.0)));
    // rust: clip(eye, to)
    // rust: .is_some_and(|block| eye.distance_squared(block) <= self.block_reach.powi(2))
    // rust: .then_some(None)
}
    /// The attack and use part of `Minecraft.tick` for the local player:
    /// attack clicks since the last tick and the held attack button.
    // rust: pub(super) fn tick_local_hand(&mut self) -> Result<()> {
    // rust: let attack_clicks = std::mem::take(&mut self.attack_clicks);
    // rust: let use_clicks = std::mem::take(&mut self.use_clicks);
    // rust: if self.screen == Screen::Playing && self.title.is_none() && self.sleeping.is_none() {
    // rust: let mut clicks = std::mem::take(&mut self.clicks);
            // keyAttack.isDown(); playing implies the grabbed mouse here
            // (scripts under --control hold buttons without grabbing it).
    // rust: let down = self.left;
    // rust: let ticks = self.clicks.destroying.ticks;
            // Minecraft.hitResult is picked once per tick, before the number
            // keys: a creative break does not move the use that follows it
            // past the broken block.
    // rust: self.pick_tick_targets();
    // rust: let mut world = GameHands {
    // rust: game: self,
    // rust: error: None,
}
    // rust: clicks.tick(&mut world, attack_clicks, 0, down, false);
    // rust: let error = world.error.take();
    // rust: self.clicks = clicks;
    // rust: if let Some(e) = error {
    // rust: self.release_tick_targets();
    // rust: return Err(e);
}
            // Use clicks follow the attack clicks within the tick, against
            // the block the attack may just have broken.
    // rust: let mut used = Ok(());
    // rust: for _ in 0..use_clicks {
    // rust: if self.using.is_some() {
    // rust: break;
}
    // rust: used = self.use_with_hand();
    // rust: self.use_delay = 4;
    // rust: if used.is_err() {
    // rust: break;
}
}
    // rust: self.release_tick_targets();
    // rust: used?;
            // A tick of breaking: the hit sound every fourth tick and the
            // cracking particles.
    // rust: let d = &self.clicks.destroying;
    // rust: if d.active && d.ticks > ticks {
    // rust: let (pos, first) = (d.pos, (d.ticks as u32 - 1).is_multiple_of(4));
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if first {
    // rust: let sounds = self.res.facts().get(state).sounds.clone();
    // rust: self.audio.play(
    // rust: &sounds.hit,
    // rust: Some(pos.map(|v| f64::from(v) + 0.5)),
    // rust: (sounds.volume + 1.0) / 8.0,
    // rust: sounds.pitch * 0.5,
    // rust: );
}
    // rust: if let Some(hit) = self.pick() {
    // rust: self.crack_particle(pos, hit.face, state);
}
}
    // rust: } else {
            // Minecraft.tick: a screen keeps the attack from starting, and
            // opening it released the keys (`KeyMapping.releaseAll`).
    // rust: self.clicks.miss_time = 10000;
    // rust: self.hotbar_presses.clear();
}
    // rust: let d = &self.clicks.destroying;
    // rust: self.mining = d.active.then_some(Mining {
    // rust: pos: d.pos,
    // rust: progress: d.progress,
    // rust: ticks: d.ticks as u32,
    // rust: });
    // rust: if let Some(mining) = &self.mining {
    // rust: let pos = mining.pos;
    // rust: let progress = mining.progress;
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.tutorial_destroy(state, progress);
}
    // rust: Ok(())
}
    /// `BlockBehaviour.getDestroyProgress` with `Player.getDestroySpeed`.
    // rust: pub(super) fn destroy_progress(&mut self, pos: [i32; 3]) -> f32 {
    // rust: let block_break_speed = self.block_break_speed();
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let facts = self.res.facts().get(state);
    // rust: if facts.hardness == -1.0 {
    // rust: return 0.0;
}
    // rust: let held = self.held();
    // rust: let mut speed = self.items().mining_speed(held, &facts.name);
    // rust: let hardness = facts.hardness;
    // rust: let harvest = !facts.requires_tool || self.items().correct_for_drops(held, &facts.name);
    // rust: speed = self.modify_destroy_speed(speed);
    // rust: speed *= block_break_speed;
    // rust: if let Some(eye) = self.eye_position()
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(
    // rust: eye[0].floor() as i32,
    // rust: eye[1].floor() as i32,
    // rust: eye[2].floor() as i32,
    // rust: ))
    // rust: .fluid
    // rust: == horizon_client::blocks::Fluid::Water
    // rust: {
    // rust: speed *= self.submerged_mining_speed();
}
    // rust: if self.player.as_ref().is_some_and(|p| !p.ground.on_ground) {
    // rust: speed /= 5.0;
}
    // rust: speed / hardness / if harvest { 30.0 } else { 100.0 }
}
    /// A key for the main-hand stack (`destroyingItem`): its item and components.
    // rust: pub(super) fn main_hand_key(&self) -> String {
    // rust: self.held()
    // rust: .map_or(String::new(), |s| format!("{} {:?}", s.item, s.extra))
}
    /// Whether an attack would hit an entity rather than the block behind
    /// it: the crosshair's `EntityHitResult`.
    // rust: pub(super) fn entity_targeted(&self) -> bool {
    // rust: let before = |d: Option<f64>| d.is_some_and(|d| self.before_block(d));
    // rust: before(self.painting_hit().map(|h| h.1))
    // rust: || before(self.frame_hit().map(|h| h.1))
    // rust: || before(self.armor_stand_hit().map(|h| h.1))
    // rust: || before(self.cushion_hit().map(|h| h.1))
    // rust: || before(self.boat_hit().map(|h| h.1))
    // rust: || before(self.cart_hit().map(|h| h.1))
    // rust: || before(self.interaction_hit().map(|h| h.1))
    // rust: || before(self.dragon_hit().map(|h| h.1))
    // rust: || before(self.mob_hit().map(|h| h.1))
    // rust: || before(self.redirectable_hit().map(|h| h.1))
}
    /// `LocalPlayer.isHandsBusy`: paddling a boat.
    // rust: pub(super) fn hands_busy(&self) -> bool {
    // rust: self.riding
    // rust: .is_some_and(|id| self.boats.iter().any(|b| b.id == id))
    // rust: && [
    // rust: winit::keyboard::KeyCode::KeyW,
    // rust: winit::keyboard::KeyCode::KeyS,
    // rust: winit::keyboard::KeyCode::KeyA,
    // rust: winit::keyboard::KeyCode::KeyD,
    // rust: ]
    // rust: .iter()
    // rust: .any(|k| self.movement_key_held(*k))
}
    /// `MultiPlayerGameMode.startUseItem`'s bookkeeping around the game's
    /// use: nothing starts while a block is being broken or the hands are
    /// busy, and `LocalPlayer.itemUsed` drops the hand after a use that
    /// swung and spent (or, with infinite materials, kept) the item, or that
    /// started using it.
    // rust: pub(super) fn use_with_hand(&mut self) -> Result<()> {
    // rust: if self.clicks.destroying.active || self.hands_busy() {
    // rust: return Ok(());
}
    // rust: let before = [self.stack_in(self.selected).cloned(), self.offhand.clone()];
    // rust: let swings = self.swings_started;
    // rust: let using = self.using.is_some();
    // rust: let Some(hand) = self.use_item()? else {
    // rust: return Ok(());
}
    // rust: let (before, after) = match hand {
    // rust: Hand::Main => (&before[0], self.stack_in(self.selected).cloned()),
    // rust: Hand::Off => (&before[1], self.offhand.clone()),
}
    // rust: let swung = self.swings_started != swings;
    // rust: let spent = match (before, &after) {
    // rust: (Some(a), Some(b)) => a.count != b.count || a.item != b.item || self.creative,
    // rust: _ => false,
}
    // rust: if (swung && spent) || (!using && self.using.is_some() && after.is_some()) {
    // rust: self.heights.item_used(hand);
}
    // rust: Ok(())
}
    /// `LocalPlayer.tick`: the swing (`LivingEntity.baseTick`), the attack
    /// strength and item swap tickers (`Player.tick`), then
    /// `FirstPersonHandsAndItems.tick`.
    // rust: pub(super) fn tick_hand(&mut self) {
        // LocalPlayer.applyInput (the camera is the player's own).
    // rust: if self.player.is_some() {
    // rust: self.sway.tick_wrapped(self.pitch, self.yaw);
}
    // rust: self.swing.tick();
    // rust: let main = self.inventory[self.selected].clone();
        // Player.tick: a different item resets the attack strength, and
        // detectEquipmentUpdates gives the player its modifiers.
    // rust: if self.hand_strength.tick(main.as_ref().map(|s| HeldStack {
    // rust: item: s.item.to_string(),
    // rust: rest: format!("{} {} {:?}", s.count, s.damage, s.extra),
    // rust: })) {
    // rust: self.attack_ticks = 0;
    // rust: self.apply_equipment();
}
    // rust: self.attack_item = main.as_ref().map(|s| s.item.clone());
    // rust: let next = [(self.selected, main), (OFFHAND, self.offhand.clone())];
    // rust: let mut changed = [false; 2];
    // rust: for h in 0..2 {
    // rust: let replaced = self.hands_replaced[h];
    // rust: let same = shows_held_stack(&self.visible_hands[h], &next[h], replaced);
    // rust: if same {
    // rust: self.visible_hands[h] = next[h].clone();
    // rust: self.hands_replaced[h] = false;
}
    // rust: changed[h] = !same;
}
    // rust: let speed = self.main_hand_attack_speed();
    // rust: let replace = self.heights.tick_with(
    // rust: self.hands_busy(),
    // rust: self.hand_strength.swap_scale(1.0, speed),
    // rust: changed,
    // rust: self.settings.extras.pvp.combat.legacy,
    // rust: );
    // rust: for h in 0..2 {
    // rust: if replace[h] {
    // rust: self.visible_hands[h] = next[h].clone();
    // rust: self.hands_replaced[h] = false;
}
}
}
    /// `Minecraft.crosshairPickEntity` when it is a `LivingEntity`: whether
    /// it is alive (the nearest entity under the crosshair, before any block).
    // rust: pub(super) fn crosshair_living(&self) -> Option<bool> {
    // rust: let nearest = |hits: &[Option<f64>]| hits.iter().flatten().copied().reduce(f64::min);
    // rust: let other = nearest(&[
    // rust: self.painting_hit().map(|h| h.1),
    // rust: self.frame_hit().map(|h| h.1),
    // rust: self.boat_hit().map(|h| h.1),
    // rust: self.cart_hit().map(|h| h.1),
    // rust: self.dragon_hit().map(|h| h.1),
    // rust: ]);
    // rust: let active = self
    // rust: .using
    // rust: .and_then(|(slot, _)| self.inventory.get(slot).and_then(Option::as_ref))
    // rust: .or_else(|| self.held());
    // rust: let range = active.and_then(|stack| {
    // rust: self.pack
    // rust: .item_renderer
    // rust: .models
    // rust: .components(&horizon_client::item_render::stack_view(stack))
    // rust: .get("minecraft:attack_range")
    // rust: .cloned()
    // rust: });
    // rust: let spear = range.as_ref().and_then(|r| {
    // rust: let eye = self.eye_position()?;
    // rust: let look = super::view_vector(self.yaw, self.pitch);
    // rust: let reach = attack_reach(r, self.creative);
    // rust: let boxes = self.hittable_mob_boxes();
    // rust: let clip = |from: Vec3, to: Vec3| {
    // rust: let length = from.distance_squared(to).sqrt();
    // rust: let d = to.subtract(from).scale(1.0 / length);
    // rust: (length > 0.0)
    // rust: .then(|| self.clip_ray([from.x, from.y, from.z], [d.x, d.y, d.z], length))
    // rust: .flatten()
    // rust: .map(|hit| Vec3::new(hit.point[0], hit.point[1], hit.point[2]))
}
    // rust: let movement = self.known_player_movement();
    // rust: reach_pick(&boxes, v3(eye), v3(look), movement, reach, clip)
    // rust: });
    // rust: let living = match spear {
    // rust: Some(distance) => distance,
    // rust: None => nearest(&[
    // rust: self.mob_hit().map(|h| h.1),
    // rust: self.armor_stand_hit().map(|h| h.1),
    // rust: ])?,
}
    // rust: if (spear.is_none() && !self.before_block(living)) || other.is_some_and(|o| o <= living) {
    // rust: return None;
}
        // Hud.extractCrosshair: with an attack range, the hit must be in it.
    // rust: if let Some(range) = &range
    // rust: && !attack_range_contains(range, living, self.creative)
    // rust: {
    // rust: return None;
}
        // Only alive mobs are hit, so a picked living entity is alive.
    // rust: Some(true)
}
    /// `Hud.canRenderCrosshairForSpectator` for the nearest hit in reach: an
    /// entity that is a `MenuProvider` (a chest or hopper minecart, a chest
    /// boat), or a block whose `showAsInteractableInSpectatorMode` holds.
    // rust: pub(super) fn spectator_crosshair(&self) -> bool {
    // rust: let cart = self.cart_hit().map(|(i, d)| {
    // rust: let kind = &self.carts[i].kind;
    // rust: (d, matches!(kind, CartKind::Chest | CartKind::Hopper))
    // rust: });
    // rust: let boat = self.boat_hit().map(|(i, d)| (d, self.boats[i].chest));
    // rust: let others = [
    // rust: self.mob_hit().map(|h| h.1),
    // rust: self.armor_stand_hit().map(|h| h.1),
    // rust: self.cushion_hit().map(|h| h.1),
    // rust: self.painting_hit().map(|h| h.1),
    // rust: self.frame_hit().map(|h| h.1),
    // rust: self.dragon_hit().map(|h| h.1),
    // rust: ];
    // rust: let nearest = cart
    // rust: .into_iter()
    // rust: .chain(boat)
    // rust: .chain(others.into_iter().flatten().map(|d| (d, false)))
    // rust: .min_by(|a, b| a.0.total_cmp(&b.0));
    // rust: if let Some((distance, menu)) = nearest
    // rust: && self.before_block(distance)
    // rust: {
    // rust: return menu;
}
    // rust: let Some(hit) = self.pick() else {
    // rust: return false;
}
    // rust: let id = &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]))
    // rust: .name;
    // rust: let name = id.trim_start_matches("minecraft:");
    // rust: match name {
            // BlockBehaviour.getMenuProvider and `instanceof Portal`.
    // rust: "crafting_table" | "enchanting_table" | "anvil" | "chipped_anvil" | "damaged_anvil"
    // rust: | "stonecutter" | "loom" | "cartography_table" | "grindstone" | "smithing_table"
    // rust: | "barrel" | "furnace" | "blast_furnace" | "smoker" | "brewing_stand" | "hopper"
    // rust: | "dispenser" | "dropper" | "crafter" | "lectern" | "beacon" | "nether_portal"
    // rust: | "end_portal" | "end_gateway" => true,
            // ChestBlock.getMenuProvider: none while a redstone conductor
            // sits on top of either half (a sitting cat aside). Copper
            // chests are `ChestBlock`s too.
    // rust: _ if horizon_client::containers::is_chest_block(id) => {
    // rust: let key = (hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let blocked = |p: (i32, i32, i32)| {
    // rust: let above = self.world.block(p.0, p.1 + 1, p.2);
    // rust: self.res.behaviours().facts(above).flags
    // rust: & horizon_world::level::data::state_flags::CONDUCTOR
    // rust: != 0
}
    // rust: !blocked(key) && self.chest_other_half(key).is_none_or(|o| !blocked(o))
}
    // rust: _ => name.ends_with("shulker_box"),
}
}
    /// `Attributes.ATTACK_SPEED` with the main-hand item's modifier and the
    /// Haste and Mining Fatigue modifiers (`ADD_MULTIPLIED_TOTAL`), clamped to
    /// the attribute's range.
    // rust: pub(super) fn main_hand_attack_speed(&self) -> f64 {
        // The base comes from the player's attribute map so `/attribute ... base set` applies.
    // rust: let base = self
    // rust: .player
    // rust: .as_ref()
    // rust: .and_then(|player| {
    // rust: let key = player.attributes.key("minecraft:attack_speed")?;
    // rust: let handle = player.attributes.lookup(Some(&key))?;
    // rust: player
    // rust: .attributes
    // rust: .instance(&handle)
    // rust: .ok()
    // rust: .map(|value| value.base_value())
    // rust: })
    // rust: .unwrap_or(horizon_client::attack_strength::BASE_ATTACK_SPEED);
    // rust: let value = base
    // rust: + self
    // rust: .attack_item_info()
    // rust: .map_or(0.0, |i| f64::from(i.attack_speed));
    // rust: self.potions
    // rust: .effects
    // rust: .modifiers()
    // rust: .into_iter()
    // rust: .filter(|m| m.0 == "minecraft:attack_speed")
    // rust: .fold(value, |v, m| v * (1.0 + m.2))
    // rust: .clamp(0.0, 1024.0)
}
    /// The item whose attack damage and speed modifiers the player has (`attack_item`).
    // rust: pub(super) fn attack_item_info(&self) -> Option<&horizon_client::items::ItemInfo> {
    // rust: self.items().get(self.attack_item.as_deref()?)
}

    /// `Player.attack`: the attack damage attribute, with the held weapon's
    /// and the effects' modifiers on it.
    // rust: pub(super) fn attack_damage(&mut self) -> f32 {
    // rust: self.player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:attack_damage").ok())
    // rust: .unwrap_or(1.0) as f32
}

    /// `evaluateWhichHandsToRender`: which of the main and off hand show.
    // rust: pub(super) fn hands_to_render(&self) -> [bool; 2] {
    // rust: let held = |slot| {
    // rust: self.stack_in(slot)
    // rust: .map(|s: &ItemStack| (&*s.item, s.data().is_some_and(|d| !d.charged.is_empty())))
}
    // rust: let using = self.used_hand().zip(
    // rust: self.using
    // rust: .and_then(|(slot, _)| self.stack_in(slot))
    // rust: .map(|s| &*s.item),
    // rust: );
    // rust: horizon_client::first_person::hands_to_render(
    // rust: [held(self.selected), held(super::shield::OFFHAND_SLOT)],
    // rust: using,
    // rust: )
}
    /// The visible main- and off-hand items.
    // rust: pub(super) fn visible_hand_items(&self) -> [Option<ItemStack>; 2] {
    // rust: [
    // rust: self.visible_hands[0].1.clone(),
    // rust: self.visible_hands[1].1.clone(),
    // rust: ]
}
}

/// The game as `first_person`'s world: the crosshair, breaking and attacking.
pub const GameHands = struct {
    game: *'g mut Game<'a>,
    error: ?*dyn std::error::Error,
};
    // rust: impl GameHands<'_, '_> {
    /// The main-hand item's `kinetic_weapon` and `piercing_weapon`, a spear's.
pub fn attack_kinetic(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game
    // rust: .held()
    // rust: .and_then(|s| horizon_client::spear::Kinetic::of(&s.item))
}
pub fn keep(self: *Self, r: Result<() void {
}
    // rust: if let Err(e) = r
    // rust: && self.error.is_none()
    // rust: {
    // rust: self.error = Some(e);
}
}
}
    // rust: impl HandWorld for GameHands<'_, '_> {
pub fn hit(self: *Self) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.game.entity_targeted() {
    // rust: return Hit::Entity;
}
    // rust: match self.game.pick() {
    // rust: Some(h) => Hit::Block {
    // rust: pos: h.pos,
    // rust: face: match h.face {
    // rust: [0, -1, 0] => 0,
    // rust: [0, 1, 0] => 1,
    // rust: [0, 0, -1] => 2,
    // rust: [0, 0, 1] => 3,
    // rust: [-1, 0, 0] => 4,
    // rust: _ => 5,
    // rust: },
    // rust: },
    // rust: None => Hit::Miss,
}
}
pub fn is_air(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.game.world.block(pos[0], pos[1], pos[2]);
    // rust: self.game.res.facts().get(state).name.ends_with("air")
}
pub fn creative(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.creative
}
pub fn spectator(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.spectator()
}
pub fn instabuild(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.creative
}
pub fn hands_busy(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.hands_busy()
}
pub fn using_item(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.using.is_some()
}
pub fn item_enabled(self: *Self, _: Hand) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn held_empty(self: *Self, hand: Hand) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match hand {
    // rust: Hand::Main => self.game.held().is_none(),
    // rust: Hand::Off => self.game.offhand.is_none(),
}
}
pub fn held_count(self: *Self, hand: Hand) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stack = match hand {
    // rust: Hand::Main => self.game.held(),
    // rust: Hand::Off => self.game.offhand.as_ref(),
}
    // rust: stack.map_or(0, |s| s.count as i32)
}
pub fn infinite_materials(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.creative
}
pub fn cannot_attack(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ticker = self.game.hand_strength.ticker;
    // rust: self.game.cannot_attack_with_item(ticker, 0)
}
pub fn piercing_weapon(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attack_kinetic().is_some()
}
pub fn attack_animation(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attack_kinetic()
    // rust: .map_or(SwingAnimation::DEFAULT, |k| k.attack_animation())
}
pub fn interact_animation(self: *Self, _: Hand) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SwingAnimation::DEFAULT
}
pub fn piercing_attack(self: *Self, _: SwingAnimation) void {
}
        // The server's part (`PiercingWeapon.attack`), then the client's:
        // the sound `MultiPlayerGameMode.piercingAttack` plays.
    // rust: if let Some(sound) = self.game.jab() {
    // rust: self.game.play_at_feet(sound);
}
    // rust: self.game.hand_strength.reset_attack();
}
pub fn attack_entity(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.attack()
}
pub fn block_action_restricted(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.block_action_restricted(pos)
}
pub fn within_border(self: *Self, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn attack_block(self: *Self, pos: [i32; 3]) void {
}
        // RedStoneOreBlock.interact: the dust comes whether or not the ore was lit.
    // rust: self.game.redstone_ore_particles(pos);
    // rust: let result = self.game.attack_block(pos);
    // rust: self.keep(result);
}
pub fn destroy_progress(self: *Self, pos: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.destroy_progress(pos)
}
pub fn destroy_block(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_air(pos) {
    // rust: return false;
}
        // Item.canDestroyBlock: swords, tridents and maces cannot break
        // blocks in creative.
    // rust: let held = self.game.held().map(|s| s.item.to_string());
    // rust: if self.game.creative
    // rust: && held.is_some_and(|i| {
    // rust: i.ends_with("_sword") || i == "minecraft:trident" || i == "minecraft:mace"
    // rust: })
    // rust: {
    // rust: return false;
}
    // rust: let state = self.game.world.block(pos[0], pos[1], pos[2]);
    // rust: self.game.tutorial_destroy(state, 1.0);
    // rust: let r = self.game.break_block(pos);
    // rust: self.keep(r);
    // rust: true
}
pub fn main_hand_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.main_hand_key()
}
pub fn destroy_stage(self: *Self, _: [i32; 3], _: ?i32) void {
}
pub fn swing(self: *Self, hand: Hand, animation: SwingAnimation) void {
}
    // rust: self.game.swing_hand(hand, animation);
}
pub fn reset_attack_strength(self: *Self) void {
}
    // rust: self.game.reset_attack_strength();
}
pub fn entity_within_border(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn use_on_entity(self: *Self, _: Hand) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn use_on_block(self: *Self, _: Hand) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: UseResult::Pass
}
pub fn use_item(self: *Self, _: Hand) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: UseResult::Pass
}
pub fn item_used(self: *Self, hand: Hand) void {
}
    // rust: self.game.heights.item_used(hand);
}
pub fn release_using(self: *Self) void {
}
}

    // rust: mod tests {
//     use super::*;

    /// A zombie-sized box whose near face is `distance` blocks ahead of an
    /// eye at the origin looking along +z.
pub fn mob_ahead(distance: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min = Vec3::new(-0.3, -1.0, distance);
    // rust: vec![(0, Aabb::new(min, min.add_vector(Vec3::new(0.6, 1.95, 0.6))))]
}

pub fn a_spear_picks_a_mob_past_the_plain_reach() void {
}
        // #3209: a mob 4 blocks ahead is out of the plain pick's 3 blocks but
        // within a spear's attack range (min 2, max 4.5, margin 0.125), so the
        // crosshair picks it and the attack indicator shows.
    // rust: let spear = serde_json::json!({
    // rust: "min_reach": 2.0, "max_reach": 4.5,
    // rust: "min_creative_reach": 2.0, "max_creative_reach": 6.5,
    // rust: "hitbox_margin": 0.125,
    // rust: });
    // rust: let (eye, look) = (Vec3::ZERO, Vec3::new(0.0, 0.0, 1.0));
    // rust: let boxes = mob_ahead(4.0);
    // rust: let reach = attack_reach(&spear, false);
    // rust: let pick = reach_pick(&boxes, eye, look, Vec3::ZERO, reach, |_, _| None);
    // rust: assert_eq!(pick, Some(4.0));
    // rust: assert!(attack_range_contains(&spear, 4.0, false));
        // Past the maximum plus the margin: no pick.
    // rust: let far = mob_ahead(4.7);
    // rust: assert_eq!(
    // rust: reach_pick(&far, eye, look, Vec3::ZERO, reach, |_, _| None),
    // rust: None
    // rust: );
        // A block nearer than the minimum reach takes the pick.
    // rust: let wall = |from: Vec3, _: Vec3| Some(from.add_vector(Vec3::new(0.0, 0.0, 1.0)));
    // rust: assert_eq!(reach_pick(&boxes, eye, look, Vec3::ZERO, reach, wall), None);
}

pub fn the_server_takes_attacks_within_vanilla_reach_only() void {
}
        // handleAttack: AttackRange.defaultFor (0 to the entity interaction
        // range, no margin) plus 3, inclusive: 6 in survival, 8 in creative.
    // rust: let survival = (0.0, 3.0, 0.0);
    // rust: assert!(in_attack_range(6.0, survival, 3.0));
    // rust: assert!(!in_attack_range(6.01, survival, 3.0));
    // rust: assert!(!in_attack_range(50.0, survival, 3.0));
    // rust: let creative = (0.0, 5.0, 0.0);
    // rust: assert!(in_attack_range(8.0, creative, 3.0));
    // rust: assert!(!in_attack_range(8.01, creative, 3.0));
        // A spear's own range, with its margin, from the server's side too.
    // rust: let spear = serde_json::json!({"min_reach": 2.0, "max_reach": 4.5, "hitbox_margin": 0.125});
    // rust: let reach = attack_reach(&spear, false);
    // rust: assert!(in_attack_range(7.625, reach, 3.0));
    // rust: assert!(!in_attack_range(7.7, reach, 3.0));
}

pub fn stack(item: []const u8, count: u32, damage: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(ItemStack {
    // rust: item: item.into(),
    // rust: count,
    // rust: damage,
    // rust: extra: None,
    // rust: })
}

pub fn a_swapped_in_stack_of_the_same_item_re_equips() void {
}
        // #2866: F swaps 64 torches into the off hand that held 32. The off
        // hand's slot stays, but the server's slot update puts another stack
        // object there; a different count fails matchesIgnoringComponents,
        // so the hand plays the swap animation.
    // rust: let visible = (OFFHAND, stack("minecraft:torch", 32, 0));
    // rust: let held = (OFFHAND, stack("minecraft:torch", 64, 0));
    // rust: assert!(!shows_held_stack(&visible, &held, true));
        // The same stack shrunk in place (a torch placed): no animation.
    // rust: assert!(shows_held_stack(&visible, &held, false));
        // An equal stack replaced it: shown at once.
    // rust: assert!(shows_held_stack(&visible, &visible.clone(), true));
        // DataComponents.DAMAGE ignores the swap animation: a sword with
        // other damage swapped in shows at once.
    // rust: let sword = (OFFHAND, stack("minecraft:iron_sword", 1, 3));
    // rust: let worn = (OFFHAND, stack("minecraft:iron_sword", 1, 40));
    // rust: assert!(shows_held_stack(&sword, &worn, true));
        // Another component (an anvil's repair cost) differs.
    // rust: let mut named = worn.clone();
    // rust: named.1.as_mut().unwrap().extra = Some(Box::new(horizon_client::item_data::StackData {
    // rust: repair_cost: 1,
    // rust: ..Default::default()
    // rust: }));
    // rust: assert!(!shows_held_stack(&sword, &named, true));
        // The main hand changing hotbar slot to an equal stack: instant; to
        // a different count: animation.
    // rust: let (a, b) = (
    // rust: (0, stack("minecraft:torch", 32, 0)),
    // rust: (1, stack("minecraft:torch", 32, 0)),
    // rust: );
    // rust: assert!(shows_held_stack(&a, &b, false));
    // rust: let c = (1, stack("minecraft:torch", 5, 0));
    // rust: assert!(!shows_held_stack(&a, &c, false));
    // rust: assert!(shows_held_stack(&(0, None), &(OFFHAND, None), true));
}

pub fn attack_range_uses_inclusive_float_bounds() void {
}
    // rust: let range = serde_json::json!({
    // rust: "min_reach": 2.0, "max_reach": 4.5,
    // rust: "min_creative_reach": 2.0, "max_creative_reach": 6.5,
    // rust: "hitbox_margin": 0.125,
    // rust: });
    // rust: for (creative, min, max) in [(false, 1.875, 4.625), (true, 1.875, 6.625)] {
    // rust: for distance in [min, max] {
    // rust: assert!(attack_range_contains(&range, distance, creative));
}
    // rust: for distance in [min - 0.0001, max + 0.0001] {
    // rust: assert!(!attack_range_contains(&range, distance, creative));
}
}
    // rust: let defaults = serde_json::json!({});
    // rust: for (creative, reach) in [(false, 3.0f32), (true, 5.0f32)] {
    // rust: let max = f64::from(reach + 0.3f32);
    // rust: assert!(attack_range_contains(&defaults, max, creative));
    // rust: assert!(!attack_range_contains(&defaults, max + 1e-8, creative));
}
}
}
