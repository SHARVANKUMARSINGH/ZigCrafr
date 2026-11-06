//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_test_block
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `TestBlockEntity`: the test block's mode, message and powered flag, with
//! its save format (`saveAdditional` / `loadAdditional`).
// use horizon_client_core::nbt_value::{number, string, text};
// use horizon_world::nbt::Tag;

/// `TestBlockMode`, in id order.
pub const TestBlockMode = enum {
    Start,
    Log,
    Fail,
    Accept,
};

    // rust: impl TestBlockMode {
pub const ALL: [Self; 4] = [Self::Start, Self::Log, Self::Fail, Self::Accept];
    /// `getSerializedName`: the block state's `mode` value.
pub fn serialized_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Start => "start",
    // rust: Self::Log => "log",
    // rust: Self::Fail => "fail",
    // rust: Self::Accept => "accept",
}
}
pub fn of_serialized_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|m| m.serialized_name() == name)
}
pub fn id(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as i32
}
    /// `ByIdMap.continuous(.., OutOfBoundsStrategy.ZERO)`.
pub fn by_id(id: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from(id)
    // rust: .ok()
    // rust: .and_then(|i| Self::ALL.get(i).copied())
    // rust: .unwrap_or(Self::Start)
}
    /// `getDisplayName`'s lang key.
pub fn label_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("test_block.mode.{}", self.serialized_name())
}
    /// `getDetailedMessage`'s lang key.
pub fn info_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("test_block.mode_info.{}", self.serialized_name())
}
}

pub const TestBlock = struct {
    mode: TestBlockMode,
    message: []const u8,
    powered: bool,
    /// `triggered`: not saved; the game test reads and clears it.
    triggered: bool,
};

/// What a `TestBlockEntity` call asks of the level.
pub const Effects = struct {
    /// `level.updateNeighborsAt(pos, block)`.
    update_neighbors: bool,
    /// `log()`.
    log: bool,
};

    // rust: impl TestBlock {
    /// `new TestBlockEntity(pos, state)`: the mode is the state's.
pub fn new(mode: TestBlockMode) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mode,
    // rust: message: String::new(),
    // rust: powered: false,
    // rust: triggered: false,
}
}

    /// `reset`.
pub fn reset(self: *Self) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.triggered = false;
    // rust: let start = self.mode == TestBlockMode::Start;
    // rust: if start {
    // rust: self.powered = false;
}
    // rust: Effects {
    // rust: update_neighbors: start,
    // rust: log: false,
}
}

    /// `trigger`: a start block powers up and logs; the others log (LOG
    /// only) and remember they were triggered.
pub fn trigger(self: *Self) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.mode == TestBlockMode::Start {
    // rust: self.powered = true;
    // rust: return Effects {
    // rust: update_neighbors: true,
    // rust: log: true,
}
}
    // rust: self.triggered = true;
    // rust: Effects {
    // rust: update_neighbors: false,
    // rust: log: self.mode == TestBlockMode::Log,
}
}

    /// `TestBlock.neighborChanged`: `signal` is `hasNeighborSignal`; a start
    /// block ignores it, the others trigger on a rising signal.
pub fn neighbor_changed(self: *Self, signal: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.mode == TestBlockMode::Start {
    // rust: return None;
}
    // rust: if signal && !self.powered {
    // rust: self.powered = true;
    // rust: Some(self.trigger())
    // rust: } else {
    // rust: if !signal && self.powered {
    // rust: self.powered = false;
}
    // rust: None
}
}

    /// `TestBlock.ownSignal`: a powered start block gives 15.
pub fn own_signal(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.mode == TestBlockMode::Start && self.powered {
    // rust: 15
    // rust: } else {
    // rust: 0
}
}

    /// `saveAdditional` (also `getUpdateTag`, which is `saveCustomOnly`).
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec![
    // rust: ("mode", string(self.mode.serialized_name())),
    // rust: ("message", string(&self.message)),
    // rust: ("powered", Tag::Byte(i8::from(self.powered))),
    // rust: ]
}

    /// `loadAdditional`: a missing or unknown mode is FAIL.
pub fn load(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mode: text(tag.get("mode"))
    // rust: .and_then(|m| TestBlockMode::of_serialized_name(&m))
    // rust: .unwrap_or(TestBlockMode::Fail),
    // rust: message: text(tag.get("message")).unwrap_or_default(),
    // rust: powered: number(tag.get("powered")).is_some_and(|v| v != 0),
    // rust: triggered: false,
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn saves_and_loads_like_test_block_entity() void {
}
    // rust: let block = TestBlock {
    // rust: mode: TestBlockMode::Accept,
    // rust: message: "all done".into(),
    // rust: powered: true,
    // rust: triggered: false,
}
    // rust: let tag = Tag::compound(block.save());
    // rust: assert_eq!(text(tag.get("mode")).as_deref(), Some("accept"));
    // rust: assert_eq!(TestBlock::load(&tag), block);
}

pub fn start_blocks_power_up_and_the_others_trigger_on_a_rising_signal() void {
}
    // rust: let mut start = TestBlock::new(TestBlockMode::Start);
    // rust: assert_eq!(start.neighbor_changed(true), None);
    // rust: assert_eq!(start.own_signal(), 0);
    // rust: let effects = start.trigger();
    // rust: assert!(effects.update_neighbors && effects.log && start.own_signal() == 15);
    // rust: assert!(start.reset().update_neighbors && start.own_signal() == 0);

    // rust: let mut log = TestBlock::new(TestBlockMode::Log);
    // rust: let effects = log.neighbor_changed(true).unwrap();
    // rust: assert!(effects.log && !effects.update_neighbors && log.triggered && log.powered);
        // Still powered: no second trigger; a fall clears the flag.
    // rust: assert_eq!(log.neighbor_changed(true), None);
    // rust: assert_eq!(log.neighbor_changed(false), None);
    // rust: assert!(!log.powered && log.triggered);
    // rust: assert!(!log.reset().update_neighbors && !log.triggered);
    // rust: let mut accept = TestBlock::new(TestBlockMode::Accept);
    // rust: assert!(!accept.neighbor_changed(true).unwrap().log);
}

pub fn load_defaults_to_fail_and_ids_wrap_to_start() void {
}
    // rust: let block = TestBlock::load(&Tag::compound(Vec::<(&str, Tag)>::new()));
    // rust: assert_eq!(block, TestBlock::new(TestBlockMode::Fail));
    // rust: assert_eq!(TestBlockMode::by_id(3), TestBlockMode::Accept);
    // rust: assert_eq!(TestBlockMode::by_id(9), TestBlockMode::Start);
    // rust: assert_eq!(TestBlockMode::Log.id(), 1);
}
}
