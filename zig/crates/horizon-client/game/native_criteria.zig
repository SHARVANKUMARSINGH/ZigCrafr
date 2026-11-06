//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_criteria
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A mod's own advancement criteria triggers (docs/native-mods.md,
//! "Advancement triggers"). An advancement of a content mod or a world's data
//! pack names a trigger of the mod's (`mymod:pipe_connected`); the tree keeps
//! it as it keeps vanilla's, and the mod fires it where its event happens, as
//! a NeoForge mod calls its own `SimpleCriterionTrigger.trigger`.
// use super::{Game, advancements::item_view, commands::Target};
// use horizon_client::{
    // rust: advancements::{self as adv, EntityView},
    // rust: items::ItemStack,
}
// use serde_json::Value;

/// One open criterion of a mod's trigger, as the mod's test sees it.
pub const NativeCriterion = struct {
    /// The criterion's `conditions`, `Null` when it has none. Its `player`
    /// predicate is the game's to test, as vanilla's `SimpleInstance.player`.
    conditions: *'a Value,
    world: *'a dyn adv::World,
};

    // rust: impl NativeCriterion<'_> {
    /// Whether `stack` passes the item predicate under `key` in the
    /// conditions, as the game's own triggers read an `ItemPredicate`:
    /// `items` (an id, a list or a `#tag`), `count`, the `potion_contents`
    /// and `damage` components, and the `enchantments` and `damage`
    /// predicates; other components and predicates aren't checked. A missing
    /// key passes, as an absent `Optional<ItemPredicate>` does.
pub fn item(self: *Self, key: []const u8, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: adv::item(&self.conditions[key], &item_view(stack), self.world)
}
}

/// Whether a mod may fire `trigger`: a namespaced id outside `minecraft`,
/// whose triggers the game fires from its own events.
pub fn mod_trigger(trigger: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: trigger
    // rust: .split_once(':')
    // rust: .is_some_and(|(ns, path)| !ns.is_empty() && !path.is_empty() && ns != "minecraft")
}

/// Helpers for server mods, kept as stable as the hook points.
// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Fires the mod's criteria trigger `trigger` (`mymod:pipe_connected`)
    /// for the player with that UUID: vanilla's
    /// `SimpleCriterionTrigger.trigger`. Each criterion of theirs with that
    /// trigger, not yet granted, of an advancement not yet done, is tested
    /// by `test` and then by its `player` predicate; those that pass are
    /// granted, and an advancement they complete is awarded with its toast,
    /// chat line and rewards, as the game's own triggers award.
    ///
    /// The acting player is reached inside their hook; any player on the
    /// server, in their own level, only where no player's state is swapped in
    /// (`native_tick`, `native_menu_clicked`), as `native_run_command`. True
    /// when the player was reached, whether or not anything was granted;
    /// false off a server, when the player isn't on or can't be reached from
    /// here, and for a `minecraft:` trigger or a name without a namespace.
    /// API 69.
    // rust: pub(super) fn native_trigger_criterion(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: trigger: &str,
    // rust: test: impl Fn(&NativeCriterion<'_>) -> bool,
    // rust: ) -> bool {
    // rust: if !mod_trigger(trigger) || self.remote.is_some() {
    // rust: return false;
}
    // rust: if self.lan_acting_uuid == Some(uuid) {
    // rust: self.trigger_mod_criteria(trigger, &test);
    // rust: return true;
}
    // rust: if self.lan_acting.is_some() {
    // rust: return false;
}
    // rust: let Some(conn) = self.lan.as_ref().and_then(|host| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.placed && g.uuid == uuid)
    // rust: .map(|g| g.conn)
    // rust: }) else {
    // rust: return false;
}
        // In their level: the predicates read where they are, and a reward
        // that doesn't fit drops there.
    // rust: self.for_player(Target::Guest(conn), |g| {
    // rust: g.trigger_mod_criteria(trigger, &test)
    // rust: })
    // rust: .is_some()
}

    /// `native_trigger_criterion` with its test behind a reference, as a
    /// trait mod calls it through `dyn Host`: the same players, criteria and
    /// answer. API @API:host_bridge@.
    // rust: pub(super) fn native_trigger_mod_criterion(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: trigger: &str,
    // rust: test: &dyn Fn(&NativeCriterion<'_>) -> bool,
    // rust: ) -> bool {
    // rust: self.native_trigger_criterion(uuid, trigger, test)
}

    /// `trigger` for a mod's trigger, for the player in place.
pub fn trigger_mod_criteria(self: *Self, trigger: []const u8, test: *dyn Fn(*NativeCriterion<'_>) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let me = self.player_entity_for(trigger);
    // rust: self.trigger(trigger, |conditions, world| {
    // rust: passes(conditions, &me, world, test)
    // rust: });
}
}

/// `SimpleCriterionTrigger.trigger`'s test of one criterion for the player
/// `me`: the mod's matcher, then the `player` predicate, in the player's own
/// context (`EntityPredicate.createContext(player, player)`).
    // rust: fn passes(
    // rust: conditions: &Value,
    // rust: me: &EntityView,
    // rust: world: &dyn adv::World,
    // rust: test: &dyn Fn(&NativeCriterion<'_>) -> bool,
    // rust: ) -> bool {
    // rust: let player = adv::Entities {
    // rust: this: Some(me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: test(&NativeCriterion { conditions, world })
    // rust: && adv::conditions(&conditions["player"], &player, world)
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;
//     use std::collections::BTreeMap;

pub const Plains = struct {};
    // rust: impl adv::World for Plains {
pub fn dimension(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "minecraft:overworld"
}
pub fn weather(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (false, false)
}
pub fn biome(self: *Self, _: [i32; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "minecraft:plains".into()
}
pub fn structures(self: *Self, _: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec::new()
}
pub fn block(self: *Self, _: [i32; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ("minecraft:air".into(), BTreeMap::new())
}
pub fn fluid(self: *Self, _: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn can_see_sky(self: *Self, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn light(self: *Self, _: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 15
}
pub fn smokey(self: *Self, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn in_tag(self: *Self, registry: []const u8, tag: []const u8, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: registry == "item" && tag == "c:ingots/copper" && id == "minecraft:copper_ingot"
}
}

    /// A mod's `pipe_connected` criterion: the pipe's item by a convention
    /// tag, and only for a player on fire (a loot condition list, as
    /// vanilla's advancements write `player`).
pub fn criterion() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "pipe": {"items": "#c:ingots/copper", "count": {"min": 2}},
    // rust: "player": [{
    // rust: "condition": "minecraft:entity_properties",
    // rust: "entity": "this",
    // rust: "predicate": {"flags": {"is_on_fire": true}}
    // rust: }]
    // rust: })
}

pub fn a_mods_criterion_takes_its_own_test_and_the_player_predicate() void {
}
    // rust: let burning = EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: on_fire: true,
    // rust: ..EntityView::default()
}
    // rust: let calm = EntityView {
    // rust: on_fire: false,
    // rust: ..burning.clone()
}
    // rust: let copper = ItemStack::new("minecraft:copper_ingot", 2);
    // rust: let pipe = |stack: &ItemStack| {
    // rust: let stack = stack.clone();
    // rust: move |c: &NativeCriterion<'_>| c.item("pipe", &stack)
}
    // rust: let c = criterion();
    // rust: assert!(passes(&c, &burning, &Plains, &pipe(&copper)));
    // rust: assert!(
    // rust: !passes(&c, &calm, &Plains, &pipe(&copper)),
    // rust: "the player predicate"
    // rust: );
    // rust: let one = ItemStack::new("minecraft:copper_ingot", 1);
    // rust: assert!(
    // rust: !passes(&c, &burning, &Plains, &pipe(&one)),
    // rust: "the item's count"
    // rust: );
    // rust: let iron = ItemStack::new("minecraft:iron_ingot", 2);
    // rust: assert!(!passes(&c, &burning, &Plains, &pipe(&iron)), "the tag");
        // A criterion without the key or any conditions passes the item test.
    // rust: let any = |c: &NativeCriterion<'_>| c.item("filter", &iron);
    // rust: assert!(passes(&c, &burning, &Plains, &any));
    // rust: assert!(passes(&Value::Null, &calm, &Plains, &any));
}

pub fn mods_fire_only_their_own_namespaced_triggers() void {
}
    // rust: assert!(mod_trigger("mymod:pipe_connected"));
    // rust: assert!(!mod_trigger("minecraft:inventory_changed"));
    // rust: assert!(!mod_trigger("inventory_changed"));
    // rust: assert!(!mod_trigger(":pipe_connected"));
}
}
