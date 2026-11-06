//! Transpiled from Horizon Rust crate
//! Module: horizon-client_cauldron
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `CauldronInteractions`: what an item does to an empty, water, lava or
//! powder snow cauldron. `tools/test_cauldron_parity.py` compares every item
//! with vanilla's `useItemOn`.
// use crate::items::{ItemStack, Items};

/// `ItemTags.CAULDRON_CAN_REMOVE_DYE` membership.
pub fn removes_dye(items: *Items, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items
    // rust: .item_tags
    // rust: .get("minecraft:cauldron_can_remove_dye")
    // rust: .is_some_and(|members| members.contains(item))
}
// use horizon_world::chunk::BlockState;

/// The player side of an interaction.
    // rust: pub trait Player {
pub fn creative(self: *Self) b;
    /// The stack in the interacting hand.
pub fn hand(self: *Self) *;
    /// `Inventory.add`; the leftover stays in `stack`.
pub fn add(self: *Self, stack: *mut ItemStack) b;
    /// `Inventory.contains`.
pub fn contains(self: *Self, stack: *ItemStack) b;
pub fn drop_stack(self: *Self, stack: ItemStack) void;
}

pub const Outcome = enum {
    /// `InteractionResult.SUCCESS`
    Success,
    /// `InteractionResult.CONSUME`
    Consume,
    /// `TRY_WITH_EMPTY_HAND`
    Pass,
};

pub const Interaction = struct {
    outcome: Outcome,
    /// The cauldron's new state.
    block: ?BlockState,
    sound: ?*'static str,
    /// The custom statistic the player earns (`use_cauldron`, ...).
    stat: ?*'static str,
};

pub fn state(name: []const u8, level: ?u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockState {
    // rust: name: name.to_owned(),
    // rust: properties: level
    // rust: .map(|l| ("level".to_owned(), l.to_string()))
    // rust: .into_iter()
    // rust: .collect(),
}
}

pub fn pass() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Interaction {
    // rust: outcome: Outcome::Pass,
    // rust: block: None,
    // rust: sound: None,
    // rust: stat: None,
}
}

/// `ItemUtils.createFilledResult`.
pub fn filled(player: *mut dyn Player, new: ItemStack, limit_creative: bool) void {
}
    // rust: let creative = player.creative();
    // rust: if limit_creative && creative {
    // rust: if !player.contains(&new) {
    // rust: let mut new = new;
    // rust: player.add(&mut new);
}
    // rust: return;
}
    // rust: let hand = player.hand();
    // rust: if !creative && let Some(held) = hand.as_mut() {
    // rust: held.count -= 1;
    // rust: if held.count == 0 {
    // rust: *hand = None;
}
}
    // rust: if hand.is_none() {
    // rust: *hand = Some(new);
    // rust: return;
}
    // rust: let mut new = new;
    // rust: if !player.add(&mut new) {
    // rust: player.drop_stack(new);
}
}

/// `LayeredCauldronBlock.handleEntityOnFireInside`: a burning entity in a
/// water cauldron lowers it a level; a powder snow cauldron becomes a water
/// cauldron of its level first, then lowers.
pub fn extinguished(cauldron: *BlockState) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cauldron.name == "minecraft:powder_snow_cauldron" {
    // rust: let mut water = cauldron.clone();
    // rust: water.name = "minecraft:water_cauldron".into();
    // rust: lowered(&water)
    // rust: } else {
    // rust: lowered(cauldron)
}
}

/// `LayeredCauldronBlock.lowerFillLevel`.
pub fn lowered(cauldron: *BlockState) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let level: u8 = cauldron
    // rust: .properties
    // rust: .get("level")
    // rust: .and_then(|l| l.parse().ok())
    // rust: .unwrap_or(1);
    // rust: if level <= 1 {
    // rust: state("minecraft:cauldron", None)
    // rust: } else {
    // rust: let mut next = cauldron.clone();
    // rust: next.properties
    // rust: .insert("level".into(), (level - 1).to_string());
    // rust: next
}
}

pub fn changed(block: BlockState, sound: ?*'static str, stat: *'static str) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Interaction {
    // rust: outcome: Outcome::Success,
    // rust: block: Some(block),
    // rust: sound,
    // rust: stat: Some(stat),
}
}

    // rust: const COLORS: [&str; 16] = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];

/// The cauldron interaction of the held item (`useItemOn`); the hand stack is
/// changed through `player`. `removes_dye` is whether the held item is in the
/// `cauldron_can_remove_dye` tag.
    // rust: pub fn interact(
    // rust: cauldron: &BlockState,
    // rust: under_water: bool,
    // rust: removes_dye: bool,
    // rust: player: &mut dyn Player,
    // rust: ) -> Interaction {
    // rust: let Some(held) = player.hand().clone() else {
    // rust: return pass();
}
    // rust: let kind = match cauldron.name.as_str() {
    // rust: "minecraft:cauldron" => "empty",
    // rust: "minecraft:water_cauldron" => "water",
    // rust: "minecraft:lava_cauldron" => "lava",
    // rust: "minecraft:powder_snow_cauldron" => "powder_snow",
    // rust: _ => return pass(),
}
    // rust: let level: u8 = cauldron
    // rust: .properties
    // rust: .get("level")
    // rust: .and_then(|l| l.parse().ok())
    // rust: .unwrap_or(0);
    // rust: let item = &*held.item;
    // rust: let water_potion = held.data().and_then(|d| d.potion.as_deref()) == Some("minecraft:water");
    // Dispatcher.get: tags first, then the item map.
    // rust: if kind == "water" && removes_dye {
    // rust: if held.data().and_then(|d| d.dyed_color).is_none() {
    // rust: return pass();
}
    // rust: if let Some(stack) = player.hand().as_mut() {
    // rust: stack.data_mut().dyed_color = None;
    // rust: stack.tidy();
}
    // rust: return changed(lowered(cauldron), None, "clean_armor");
}
    // rust: let fill_bucket = |player: &mut dyn Player, new: &str, can_fill: bool, sound| {
    // rust: if !can_fill {
    // rust: return pass();
}
    // rust: filled(player, ItemStack::new(new, 1), true);
    // rust: changed(
    // rust: state("minecraft:cauldron", None),
    // rust: Some(sound),
    // rust: "use_cauldron",
    // rust: )
}
    // rust: let empty_bucket = |player: &mut dyn Player, block: BlockState, sound| {
    // rust: filled(player, ItemStack::new("minecraft:bucket", 1), true);
    // rust: changed(block, Some(sound), "fill_cauldron")
}
    // rust: match item {
    // rust: "minecraft:lava_bucket" => {
    // rust: return if under_water {
    // rust: Interaction {
    // rust: outcome: Outcome::Consume,
    // rust: block: None,
    // rust: sound: None,
    // rust: stat: None,
}
    // rust: } else {
    // rust: empty_bucket(
    // rust: player,
    // rust: state("minecraft:lava_cauldron", None),
    // rust: "minecraft:item.bucket.empty_lava",
    // rust: )
}
}
    // rust: "minecraft:water_bucket" => {
    // rust: return empty_bucket(
    // rust: player,
    // rust: state("minecraft:water_cauldron", Some(3)),
    // rust: "minecraft:item.bucket.empty",
    // rust: );
}
    // rust: "minecraft:powder_snow_bucket" => {
    // rust: return if under_water {
    // rust: Interaction {
    // rust: outcome: Outcome::Consume,
    // rust: block: None,
    // rust: sound: None,
    // rust: stat: None,
}
    // rust: } else {
    // rust: empty_bucket(
    // rust: player,
    // rust: state("minecraft:powder_snow_cauldron", Some(3)),
    // rust: "minecraft:item.bucket.empty_powder_snow",
    // rust: )
}
}
    // rust: _ => {}
}
    // rust: match (kind, item) {
    // rust: ("empty", "minecraft:potion") => {
    // rust: if !water_potion {
    // rust: return pass();
}
    // rust: filled(player, ItemStack::new("minecraft:glass_bottle", 1), true);
    // rust: changed(
    // rust: state("minecraft:water_cauldron", Some(1)),
    // rust: Some("minecraft:item.bottle.empty"),
    // rust: "use_cauldron",
    // rust: )
}
    // rust: ("water", "minecraft:bucket") => fill_bucket(
    // rust: player,
    // rust: "minecraft:water_bucket",
    // rust: level == 3,
    // rust: "minecraft:item.bucket.fill",
    // rust: ),
    // rust: ("water", "minecraft:glass_bottle") => {
    // rust: filled(
    // rust: player,
    // rust: ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water"),
    // rust: true,
    // rust: );
    // rust: changed(
    // rust: lowered(cauldron),
    // rust: Some("minecraft:item.bottle.fill"),
    // rust: "use_cauldron",
    // rust: )
}
    // rust: ("water", "minecraft:potion") => {
    // rust: if level == 3 || !water_potion {
    // rust: return pass();
}
    // rust: filled(player, ItemStack::new("minecraft:glass_bottle", 1), true);
    // rust: let mut next = cauldron.clone();
            // BlockState.cycle on a 1..=3 property
    // rust: next.properties
    // rust: .insert("level".into(), (level % 3 + 1).to_string());
    // rust: changed(next, Some("minecraft:item.bottle.empty"), "use_cauldron")
}
    // rust: ("water", name)
    // rust: if name
    // rust: .strip_prefix("minecraft:")
    // rust: .and_then(|n| n.strip_suffix("_banner"))
    // rust: .is_some_and(|c| COLORS.contains(&c)) =>
    // rust: {
    // rust: let layers = held.data().map_or(0, |d| d.banner_patterns.len());
    // rust: if layers == 0 {
    // rust: return pass();
}
    // rust: let mut cleaned = held.clone();
    // rust: cleaned.count = 1;
    // rust: cleaned.data_mut().banner_patterns.pop();
    // rust: cleaned.tidy();
    // rust: filled(player, cleaned, false);
    // rust: changed(lowered(cauldron), None, "clean_banner")
}
    // rust: ("water", name)
    // rust: if name
    // rust: .strip_prefix("minecraft:")
    // rust: .and_then(|n| n.strip_suffix("_shulker_box"))
    // rust: .is_some_and(|c| COLORS.contains(&c)) =>
    // rust: {
    // rust: filled(player, held.transmute("minecraft:shulker_box", 1), false);
    // rust: changed(lowered(cauldron), None, "clean_shulker_box")
}
    // rust: ("lava", "minecraft:bucket") => fill_bucket(
    // rust: player,
    // rust: "minecraft:lava_bucket",
    // rust: true,
    // rust: "minecraft:item.bucket.fill_lava",
    // rust: ),
    // rust: ("powder_snow", "minecraft:bucket") => fill_bucket(
    // rust: player,
    // rust: "minecraft:powder_snow_bucket",
    // rust: level == 3,
    // rust: "minecraft:item.bucket.fill_powder_snow",
    // rust: ),
    // rust: _ => pass(),
}
}

/// What `interact` would answer for `held`, changing nothing: a client's
/// `useItemOn`, where every interaction checks the same conditions and acts
/// only `if (!level.isClientSide())`.
    // rust: pub fn outcome(
    // rust: cauldron: &BlockState,
    // rust: under_water: bool,
    // rust: removes_dye: bool,
    // rust: held: &ItemStack,
    // rust: ) -> Outcome {
pub const Dry = struct {};
    // rust: impl Player for Dry {
pub fn creative(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn hand(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.0
}
pub fn add(self: *Self, _: *mut ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn contains(self: *Self, _: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn drop_stack(self: *Self, _: ItemStack) void {
}
}
    // rust: interact(
    // rust: cauldron,
    // rust: under_water,
    // rust: removes_dye,
    // rust: &mut Dry(Some(held.clone())),
    // rust: )
    // rust: .outcome
}

    // rust: mod tests {
//     use super::*;

pub fn a_client_sees_the_bucket_taken_without_acting() void {
}
    // rust: let empty = state("minecraft:cauldron", None);
    // rust: let water = |l| state("minecraft:water_cauldron", Some(l));
    // rust: let stack = |id| ItemStack::new(id, 1);
    // rust: let outcome = |c: &BlockState, under_water, id| outcome(c, under_water, false, &stack(id));
    // rust: assert_eq!(
    // rust: outcome(&empty, false, "minecraft:water_bucket"),
    // rust: Outcome::Success
    // rust: );
    // rust: assert_eq!(
    // rust: outcome(&empty, false, "minecraft:lava_bucket"),
    // rust: Outcome::Success
    // rust: );
        // fillLavaInteraction under water: CONSUME, the bucket kept.
    // rust: assert_eq!(
    // rust: outcome(&empty, true, "minecraft:lava_bucket"),
    // rust: Outcome::Consume
    // rust: );
    // rust: assert_eq!(
    // rust: outcome(&water(3), false, "minecraft:bucket"),
    // rust: Outcome::Success
    // rust: );
        // fillBucket needs a full cauldron.
    // rust: assert_eq!(outcome(&water(2), false, "minecraft:bucket"), Outcome::Pass);
    // rust: assert_eq!(outcome(&empty, false, "minecraft:bucket"), Outcome::Pass);
    // rust: assert_eq!(outcome(&empty, false, "minecraft:stone"), Outcome::Pass);
}

pub fn a_burning_entity_lowers_water_and_melts_powder_snow() void {
}
    // rust: let water = |l| state("minecraft:water_cauldron", Some(l));
    // rust: assert_eq!(extinguished(&water(3)), water(2));
    // rust: assert_eq!(extinguished(&water(1)), state("minecraft:cauldron", None));
        // Powder snow turns to water of its level, then lowers.
    // rust: assert_eq!(
    // rust: extinguished(&state("minecraft:powder_snow_cauldron", Some(3))),
    // rust: water(2)
    // rust: );
    // rust: assert_eq!(
    // rust: extinguished(&state("minecraft:powder_snow_cauldron", Some(1))),
    // rust: state("minecraft:cauldron", None)
    // rust: );
}
}
