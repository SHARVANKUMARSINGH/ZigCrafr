//! Transpiled from Horizon Rust crate
//! Module: horizon-world_inventory_use
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Living item-use lifecycle bound to player inventory, shared stack identity
//! and synchronized using/offhand bytes. Item effects and level services remain
//! explicit so their callbacks can observe or mutate the same stored state.
// use crate::{
    // rust: item_stack_refs::StackRef,
    // rust: item_use_lifecycle::{UseLifecycleWorld, UseState},
    // rust: living_use_flags,
    // rust: player_equipment::{self, InteractionHand},
    // rust: player_inventory::{EquipmentSlot, PlayerInventory},
    // rust: synced_values::{DataError, DataValue, Observer, SyncedValues},
}
    // rust: pub type ActiveStack<I, K, V> = UseState<StackRef<I, K, V>>;
pub const UseView = struct {
    inventory: *'a mut PlayerInventory<I,
    flags: *'a mut SyncedValues<u8>,
};
    // rust: impl<I, K, V> UseView<'_, I, K, V> {
pub fn reborrow(self: *Self) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: UseView {
    // rust: inventory: self.inventory,
    // rust: flags: self.flags,
}
}
}
    // rust: pub trait UseServices<I, K, V> {
    // rust: type Error;
    // rust: type Level: Copy;
    // rust: fn level(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: ) -> Result<Self::Level, Self::Error>;
    // rust: fn is_client(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn remaining_ticks(
    // rust: &mut self,
    // rust: _view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: ) -> Result<i32, Self::Error> {
    // rust: Ok(state.remaining)
}
    // rust: fn item_tick(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: level: Self::Level,
    // rust: remaining: i32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn use_on_release(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn release_item(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: level: Self::Level,
    // rust: remaining: i32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn finish_item(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: level: Self::Level,
    // rust: ) -> Result<StackRef<I, K, V>, Self::Error>;
    // rust: fn finish_vibration(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn on_equip(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: slot: EquipmentSlot,
    // rust: old: StackRef<I, K, V>,
    // rust: new: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn on_synced(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: id: u8,
    // rust: ) -> Result<(), Self::Error>;
}
pub const InventoryUse = struct {
    inventory: PlayerInventory<I,
    flags: SyncedValues<u8>,
    services: S,
    empty: StackRef<I,
};
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, S> InventoryUse<I, K, V, S> {
    // rust: pub fn new(
    // rust: inventory: PlayerInventory<I, K, V>,
    // rust: flags: SyncedValues<u8>,
    // rust: services: S,
    // rust: ) -> Result<Self, u8> {
    // rust: flags.get(living_use_flags::FLAGS_ID)?;
    // rust: let empty = inventory.stacks().empty();
    // rust: Ok(Self {
    // rust: inventory,
    // rust: flags,
    // rust: services,
    // rust: empty,
    // rust: })
}
}
pub const FlagObserver = struct {
    inventory: *'a mut PlayerInventory<I,
    state: *'a mut ActiveStack<I,
    services: *'a mut S,
};
    // rust: impl<I, K, V, S: UseServices<I, K, V>> Observer<u8> for FlagObserver<'_, I, K, V, S> {
    // rust: type Error = S::Error;
pub fn updated(self: *Self, flags: *mut SyncedValues<u8>, id: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.services.on_synced(
    // rust: UseView {
    // rust: inventory: self.inventory,
    // rust: flags,
    // rust: },
    // rust: self.state,
    // rust: id,
    // rust: )
}
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, S: UseServices<I, K, V>> UseLifecycleWorld
    // rust: for InventoryUse<I, K, V, S>
    // rust: {
    // rust: type Error = S::Error;
    // rust: type Item = StackRef<I, K, V>;
    // rust: type Hand = InteractionHand;
    // rust: type Level = S::Level;
pub fn empty_item(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.empty.clone()
}
pub fn is_empty(self: *Self, item: Self::Item) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item.read().is_empty()
}
pub fn same_item_type(self: *Self, a: Self::Item, b: Self::Item) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.read().same_item(&b.read())
}
pub fn using_item(self: *Self, _: *mut ActiveStack<I) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(living_use_flags::using_item(&self.flags).expect("validated flags"))
}
pub fn used_hand(self: *Self, _: *mut ActiveStack<I) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(living_use_flags::used_hand(&self.flags).expect("validated flags"))
}
    // rust: fn hand_item(
    // rust: &mut self,
    // rust: _: &mut ActiveStack<I, K, V>,
    // rust: hand: InteractionHand,
    // rust: ) -> Result<Self::Item, Self::Error> {
    // rust: Ok(player_equipment::get_hand(&self.inventory, hand))
}
    // rust: fn set_hand_item(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: hand: InteractionHand,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error> {
    // rust: let old = player_equipment::set(&mut self.inventory, hand.slot(), item.clone());
    // rust: self.services.on_equip(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: hand.slot(),
    // rust: old,
    // rust: item,
    // rust: )
}
pub fn level(self: *Self, state: *mut ActiveStack<I) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.services.level(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: )
}
    // rust: fn is_client(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.services.is_client(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: level,
    // rust: )
}
pub fn remaining_ticks(self: *Self, state: *mut ActiveStack<I) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.services.remaining_ticks(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: )
}
    // rust: fn item_tick(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: Self::Item,
    // rust: level: Self::Level,
    // rust: remaining: i32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.services.item_tick(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: level,
    // rust: remaining,
    // rust: )
}
    // rust: fn use_on_release(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: Self::Item,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.services.use_on_release(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: )
}
    // rust: fn release_item(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: Self::Item,
    // rust: level: Self::Level,
    // rust: remaining: i32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.services.release_item(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: level,
    // rust: remaining,
    // rust: )
}
    // rust: fn finish_item(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: Self::Item,
    // rust: level: Self::Level,
    // rust: ) -> Result<Self::Item, Self::Error> {
    // rust: self.services.finish_item(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: level,
    // rust: )
}
    // rust: fn set_using_flag(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: using: bool,
    // rust: ) -> Result<(), Self::Error> {
    // rust: let mut observer = FlagObserver {
    // rust: inventory: &mut self.inventory,
    // rust: state,
    // rust: services: &mut self.services,
}
    // rust: living_use_flags::set_flag(&mut self.flags, 1, using, &mut observer).map_err(|error| {
    // rust: match error {
    // rust: DataError::Observer(e) => e,
    // rust: DataError::UnknownId(_) => unreachable!("validated flags"),
}
    // rust: })
}
    // rust: fn finish_vibration(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.services.finish_vibration(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: )
}
}

/// Duration dispatch used when client synchronization discovers a newly held
/// active stack. Implementations retain the captured stack across callbacks.
    // rust: pub trait DurationServices<I, K, V>: UseServices<I, K, V> {
    // rust: fn duration(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<i32, Self::Error>;
}
/// LivingEntity's reaction to DATA_LIVING_ENTITY_FLAGS after Entity's observer
/// has run. Other synchronized keys (pose, sleeping position, etc.) are separate.
    // rust: pub fn flags_updated<
    // rust: I: Copy + Eq,
    // rust: K: Clone + Eq,
    // rust: V: Clone + PartialEq,
    // rust: S: DurationServices<I, K, V>,
    // rust: >(
    // rust: services: &mut S,
    // rust: mut view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: ) -> Result<(), S::Error> {
    // rust: let level = services.level(view.reborrow(), state)?;
    // rust: if !services.is_client(view.reborrow(), state, level)? {
    // rust: return Ok(());
}
    // rust: if living_use_flags::using_item(view.flags).expect("validated flags")
    // rust: && state.item.read().is_empty()
    // rust: {
    // rust: let hand = living_use_flags::used_hand(view.flags).expect("validated flags");
    // rust: state.item = player_equipment::get_hand(view.inventory, hand);
    // rust: if !state.item.read().is_empty() {
    // rust: let item = state.item.clone();
    // rust: state.remaining = services.duration(view, state, item)?;
}
    // rust: } else if !living_use_flags::using_item(view.flags).expect("validated flags")
    // rust: && !state.item.read().is_empty()
    // rust: {
    // rust: state.item = view.inventory.stacks().empty();
    // rust: state.remaining = 0;
}
    // rust: Ok(())
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, S: UseServices<I, K, V>>
    // rust: InventoryUse<I, K, V, S>
    // rust: {
    // rust: pub fn assign_flags(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: values: &[DataValue<u8>],
    // rust: ) -> Result<(), DataError<S::Error>> {
    // rust: let mut observer = FlagObserver {
    // rust: inventory: &mut self.inventory,
    // rust: state,
    // rust: services: &mut self.services,
}
    // rust: self.flags.assign(values, &mut observer)
}
    // rust: pub fn set_flag(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: mask: i32,
    // rust: value: bool,
    // rust: ) -> Result<(), DataError<S::Error>> {
    // rust: let mut observer = FlagObserver {
    // rust: inventory: &mut self.inventory,
    // rust: state,
    // rust: services: &mut self.services,
}
    // rust: living_use_flags::set_flag(&mut self.flags, mask, value, &mut observer)
}
}

/// Services needed by startUsingItem in addition to the stored lifecycle.
    // rust: pub trait StartServices<I, K, V>: DurationServices<I, K, V> {
    // rust: fn synchronize_equipment(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: level: Self::Level,
    // rust: hand: InteractionHand,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn start_vibration(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
pub fn has_kinetic_weapon(self: *Self, item: *StackRef<I) b;
    /// The caller owns the actual enemy map. Reset it at this native point.
    // rust: fn reset_recent_kinetic_enemies(
    // rust: &mut self,
    // rust: view: UseView<'_, I, K, V>,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: );
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, S: StartServices<I, K, V>>
    // rust: crate::item_use_start::StartUseWorld for InventoryUse<I, K, V, S>
    // rust: {
    // rust: fn duration(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<i32, Self::Error> {
    // rust: self.services.duration(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: )
}
    // rust: fn synchronize_equipment(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: level: Self::Level,
    // rust: hand: InteractionHand,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.services.synchronize_equipment(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: level,
    // rust: hand,
    // rust: item,
    // rust: )
}
pub fn is_off_hand(self: *Self, hand: InteractionHand) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: hand == InteractionHand::Off
}
    // rust: fn set_off_hand_flag(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: off: bool,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.set_flag(state, 2, off).map_err(|error| match error {
    // rust: DataError::Observer(e) => e,
    // rust: DataError::UnknownId(_) => unreachable!("validated flags"),
    // rust: })
}
    // rust: fn start_vibration(
    // rust: &mut self,
    // rust: state: &mut ActiveStack<I, K, V>,
    // rust: item: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.services.start_vibration(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: item,
    // rust: )
}
pub fn has_kinetic_weapon(self: *Self, item: StackRef<I) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.services.has_kinetic_weapon(&item)
}
pub fn reset_recent_kinetic_enemies(self: *Self, state: *mut ActiveStack<I) void {
}
    // rust: self.services.reset_recent_kinetic_enemies(
    // rust: UseView {
    // rust: inventory: &mut self.inventory,
    // rust: flags: &mut self.flags,
    // rust: },
    // rust: state,
    // rust: )
}
}
