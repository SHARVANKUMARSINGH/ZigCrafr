//! Transpiled from Horizon Rust crate
package horizon_client_input_interaction_input

import "core:fmt"
import "core:mem"
import "core:math"

// The mouse-key portion of Minecraft.handleKeybinds. Events only count clicks;
// the client tick consumes them before player movement and CLIENT_TICK_END.
InteractionInput :: struct {
    clicks: [u32,
}

Button :: enum {
    Attack,
    Use,
    Pick,
}

    // rust: pub trait InteractionWorld {
    // Minecraft.pick before handleKeybinds: the tick's `hitResult`, which
    // every click of the tick reads, even after one of them changed the
    // block it names (a creative break, then a use that replaces it).
pick_hit_result :: proc(self: ^Self) {
}
    // The tick's clicks are done: later picks follow the crosshair again.
release_hit_result :: proc(self: ^Self) {
}
using_item :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
release_using :: proc(self: ^Self) {
}
start_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
start_use :: proc(self: ^Self) {
}
pick :: proc(self: ^Self) {
}
use_delay :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
continue_attack :: proc(self: ^Self, down: bool) {
}
}

// Minecraft.startUseItem dispatches one hit result per hand. A passing
// entity interaction falls back to the item, without trying a block behind it.
    // rust: pub trait TargetUseWorld {
use_entity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
use_block :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
use_item :: proc(self: ^Self) {
}
}

use_on_target :: proc(world: ^impl TargetUseWorld, entity: bool) {
}
    // rust: let consumed = if entity {
    // rust: world.use_entity()
    // rust: } else {
    // rust: world.use_block()
}
    // rust: if !consumed {
    // rust: world.use_item();
}
}

    // rust: impl InteractionInput {
press :: proc(self: ^Self, button: Button) {
}
    // rust: self.clicks[button as usize] += 1;
}
tick :: proc(self: ^Self, world: ^impl InteractionWorld, attack_down: bool, use_down: bool) {
}
    // rust: let [attack, use_item, pick] = std::mem::take(&mut self.clicks);
    // rust: world.pick_hit_result();
    // rust: let mut instant = false;
    // rust: if world.using_item() {
    // rust: if !use_down {
    // rust: world.release_using();
}
            // Vanilla drains all three click queues while using an item,
            // including the tick that releases it.
    // rust: } else {
    // rust: for _ in 0..attack {
    // rust: instant |= world.start_attack();
}
    // rust: for _ in 0..use_item {
    // rust: world.start_use();
}
    // rust: for _ in 0..pick {
    // rust: world.pick();
}
}
    // rust: if use_down && world.use_delay() == 0 && !world.using_item() {
    // rust: world.start_use();
}
    // rust: world.continue_attack(!instant && attack_down);
    // rust: world.release_hit_result();
}
}

// The sentence of `Minecraft.handleKeybinds` that follows a key which opened
// a screen: `Gui.setScreen` has already run `KeyMapping.releaseAll()`, so
// `key.use` reads up and the same call releases an active use
// (`player.isUsingItem() && !keyUse.isDown()` → `MultiPlayerGameMode.releaseUsingItem`).
// Only the screens opened from the keybinds do this (the inventory, chat and
// advancements); the pause menu, server containers, mount inventories and
// dialogs release on the first tick after closing instead, as vanilla does.
release_on_screen_open :: proc(world: ^impl InteractionWorld) {
}
    // rust: if world.using_item() {
    // rust: world.release_using();
}
}

    // rust: mod tests {
//     use super::*;

World :: struct {
    using: bool,
    destroying: bool,
    delay: u32,
    begin_using: bool,
    events: [dynamic]^'static str,
}
    // rust: impl InteractionWorld for World {
pick_hit_result :: proc(self: ^Self) {
}
release_hit_result :: proc(self: ^Self) {
}
using_item :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.using
}
release_using :: proc(self: ^Self) {
}
    // rust: self.events.push("release");
    // rust: self.using = false;
}
start_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.events.push("attack");
    // rust: false
}
start_use :: proc(self: ^Self) {
}
    // rust: if !self.destroying {
    // rust: self.events.push("use");
    // rust: self.delay = 4;
    // rust: self.using = self.begin_using;
}
}
pick :: proc(self: ^Self) {
}
    // rust: self.events.push("pick");
}
use_delay :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.delay
}
continue_attack :: proc(self: ^Self, _: bool) {
}
    // rust: self.events.push("continue");
}
}

quick_clicks_wait_for_a_tick_and_follow_keybind_order :: proc() {
}
    // rust: let mut input = InteractionInput::default();
    // rust: let mut world = World::default();
    // rust: input.press(Button::Use);
    // rust: input.press(Button::Pick);
    // rust: input.press(Button::Attack);
    // rust: assert!(world.events.is_empty());
        // Both edges can arrive between ticks; the press still acts once.
    // rust: input.tick(&mut world, false, false);
    // rust: assert_eq!(world.events, ["attack", "use", "pick", "continue"]);
    // rust: world.events.clear();
    // rust: input.tick(&mut world, false, false);
    // rust: assert_eq!(
    // rust: world.events,
    // rust: ["continue"],
    // rust: "no spurious release or repeated click"
    // rust: );
}

releasing_actual_item_use_discards_clicks_for_that_tick :: proc() {
}
    // rust: let mut input = InteractionInput::default();
    // rust: let mut world = World {
    // rust: using: true,
    // rust: ..Default::default()
}
    // rust: for button in [Button::Attack, Button::Use, Button::Pick] {
    // rust: input.press(button);
}
    // rust: input.tick(&mut world, true, false);
    // rust: assert_eq!(world.events, ["release", "continue"]);
}

holding_use_respects_the_delay_and_active_digging :: proc() {
}
    // rust: let mut input = InteractionInput::default();
    // rust: let mut world = World {
    // rust: destroying: true,
    // rust: ..Default::default()
}
    // rust: input.press(Button::Use);
    // rust: input.tick(&mut world, true, true);
    // rust: assert_eq!(world.events, ["continue"]);
    // rust: world.destroying = false;
    // rust: world.events.clear();
    // rust: input.tick(&mut world, false, true);
    // rust: assert_eq!(world.events, ["use", "continue"]);
    // rust: world.events.clear();
    // rust: input.tick(&mut world, false, true);
    // rust: assert_eq!(world.events, ["continue"]);
}

a_quick_use_click_releases_on_the_following_tick :: proc() {
}
    // rust: let mut input = InteractionInput::default();
    // rust: let mut world = World {
    // rust: begin_using: true,
    // rust: ..Default::default()
}
    // rust: input.press(Button::Use);
    // rust: input.tick(&mut world, false, false);
    // rust: assert_eq!(world.events, ["use", "continue"]);
    // rust: assert!(world.using);
    // rust: world.events.clear();
    // rust: input.tick(&mut world, false, false);
    // rust: assert_eq!(world.events, ["release", "continue"]);
}

    // A floating block in front of the crosshair, nothing behind it, and a
    // block item in the hand of a creative player.
Column :: struct {
    block: bool,
    hit: Maybe(Option<())>,
    placed: bool,
}
    // rust: impl Column {
        // Minecraft.hitResult: the tick's pick, or a fresh one outside it.
target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.hit.unwrap_or(self.block.then_some(()))
}
}
    // rust: impl InteractionWorld for Column {
pick_hit_result :: proc(self: ^Self) {
}
    // rust: self.hit = Some(self.target());
}
release_hit_result :: proc(self: ^Self) {
}
    // rust: self.hit = None;
}
using_item :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
release_using :: proc(self: ^Self) {
}
start_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
            // MultiPlayerGameMode.startDestroyBlock in creative: the
            // predicted break leaves air.
    // rust: if self.target().is_some() {
    // rust: self.block = false;
}
    // rust: !self.block
}
start_use :: proc(self: ^Self) {
}
            // BlockItem.place: the clicked block, now air, can be replaced.
    // rust: if self.target().is_some() && !self.block {
    // rust: self.block = true;
    // rust: self.placed = true;
}
}
pick :: proc(self: ^Self) {
}
use_delay :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
continue_attack :: proc(self: ^Self, _: bool) {
}
}

attack_and_use_in_one_tick_share_the_hit_result :: proc() {
}
        // #3006: both buttons at once replace the block the crosshair is on.
    // rust: let mut input = InteractionInput::default();
    // rust: let mut world = Column {
    // rust: block: true,
    // rust: ..Default::default()
}
    // rust: input.press(Button::Attack);
    // rust: input.press(Button::Use);
    // rust: input.tick(&mut world, false, false);
    // rust: assert!(world.placed, "the use acts on the block the attack broke");
    // rust: assert!(world.block);
    // rust: assert!(world.hit.is_none(), "the next pick follows the crosshair");
}
}
