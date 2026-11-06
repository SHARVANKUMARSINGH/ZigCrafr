//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_command_block
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `CommandBlockEntity` with its `BaseCommandBlock`: the command, the success
//! count comparators read, the output it keeps, and the powered, automatic
//! and condition flags `CommandBlock.tick` runs on.
    // rust: pub use crate::chunk::block_entity::CommandBlock;
// use horizon_client_core::{
    // rust: nbt_value::{number, text},
    // rust: scoreboard,
    // rust: text::Text,
}
// use horizon_world::nbt::Tag;

/// `CommandBlockEntity.Mode`, in declaration order (the edit screen's mode
/// button cycles through it).
pub const Mode = enum {
    Sequence,
    Auto,
    Redstone,
};

    // rust: impl Mode {
    /// `CommandBlockEntity.getMode`: the block the entity sits in.
pub fn of_block(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "minecraft:command_block" => Some(Self::Redstone),
    // rust: "minecraft:repeating_command_block" => Some(Self::Auto),
    // rust: "minecraft:chain_command_block" => Some(Self::Sequence),
    // rust: _ => None,
}
}
    /// The block `ServerGamePacketListenerImpl.handleSetCommandBlock` puts
    /// down for a mode.
pub fn block(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Sequence => "minecraft:chain_command_block",
    // rust: Self::Auto => "minecraft:repeating_command_block",
    // rust: Self::Redstone => "minecraft:command_block",
}
}
    /// `Enum.ordinal`, which `ServerboundSetCommandBlockPacket` writes.
pub fn ordinal(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Sequence => 0,
    // rust: Self::Auto => 1,
    // rust: Self::Redstone => 2,
}
}
    /// The mode of a packet's ordinal; `handleSetCommandBlock` treats any
    /// other value as a plain command block (its `default` branch).
pub fn from_ordinal(ordinal: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ordinal {
    // rust: 0 => Self::Sequence,
    // rust: 1 => Self::Auto,
    // rust: _ => Self::Redstone,
}
}
    /// `CycleButton`: the next value, wrapping round.
pub fn next(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Sequence => Self::Auto,
    // rust: Self::Auto => Self::Redstone,
    // rust: Self::Redstone => Self::Sequence,
}
}
    /// `CommandBlockEditScreen`'s label for the mode.
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Sequence => "advMode.mode.sequence",
    // rust: Self::Auto => "advMode.mode.auto",
    // rust: Self::Redstone => "advMode.mode.redstone",
}
}
}

/// The `automatic` flag `CommandBlock` gives its entity: chain command blocks
/// are always active when placed.
pub fn automatic_block(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name == "minecraft:chain_command_block"
}

    // rust: impl Default for CommandBlock {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: command: String::new(),
    // rust: success_count: 0,
    // rust: custom_name: None,
    // rust: track_output: true,
    // rust: last_output: None,
    // rust: update_last_execution: true,
    // rust: last_execution: -1,
    // rust: powered: false,
    // rust: auto: false,
    // rust: condition_met: false,
}
}
}

    // rust: impl CommandBlock {
    /// `CommandBlockEntity.loadAdditional` with `BaseCommandBlock.load`.
pub fn load(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flag = |key: &str, default: bool| number(tag.get(key)).map_or(default, |v| v != 0);
    // rust: let track_output = flag("TrackOutput", true);
    // rust: let update_last_execution = flag("UpdateLastExecution", true);
    // rust: Self {
    // rust: command: text(tag.get("Command")).unwrap_or_default(),
    // rust: success_count: number(tag.get("SuccessCount")).unwrap_or(0) as i32,
    // rust: custom_name: tag.get("CustomName").cloned(),
    // rust: track_output,
    // rust: last_output: track_output
    // rust: .then(|| tag.get("LastOutput"))
    // rust: .flatten()
    // rust: .map(|t| scoreboard::comp_text(&scoreboard::tag_to_json(t))),
    // rust: update_last_execution,
    // rust: last_execution: if update_last_execution {
    // rust: number(tag.get("LastExecution")).unwrap_or(-1)
    // rust: } else {
    // rust: -1
    // rust: },
    // rust: powered: flag("powered", false),
    // rust: auto: flag("auto", false),
    // rust: condition_met: flag("conditionMet", false),
}
}
    /// `CommandBlockEntity.saveAdditional`. The last output is written as a
    /// plain string component.
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = vec![
    // rust: ("Command", Tag::String(self.command.as_str().into())),
    // rust: ("SuccessCount", Tag::Int(self.success_count)),
    // rust: ];
    // rust: if let Some(name) = &self.custom_name {
    // rust: out.push(("CustomName", name.clone()));
}
    // rust: out.push(("TrackOutput", Tag::Byte(i8::from(self.track_output))));
    // rust: if self.track_output
    // rust: && let Some(last) = &self.last_output
    // rust: {
    // rust: out.push(("LastOutput", Tag::String(last.plain().as_str().into())));
}
    // rust: out.push((
    // rust: "UpdateLastExecution",
    // rust: Tag::Byte(i8::from(self.update_last_execution)),
    // rust: ));
    // rust: if self.update_last_execution && self.last_execution != -1 {
    // rust: out.push(("LastExecution", Tag::Long(self.last_execution)));
}
    // rust: out.push(("powered", Tag::Byte(i8::from(self.powered))));
    // rust: out.push(("conditionMet", Tag::Byte(i8::from(self.condition_met))));
    // rust: out.push(("auto", Tag::Byte(i8::from(self.auto))));
    // rust: out
}
    /// `BaseCommandBlock.setCommand`: a new command starts at no successes.
pub fn set_command(self: *Self, command: []const u8) void {
}
    // rust: self.command = command.to_owned();
    // rust: self.success_count = 0;
}
    /// `getLastOutput().getString()`: what the edit screen shows.
pub fn last_output_string(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.last_output
    // rust: .as_ref()
    // rust: .map(Text::plain)
    // rust: .unwrap_or_default()
}
    /// `getName`: the custom name, else `@`.
pub fn name(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.custom_name.as_ref().map_or_else(
    // rust: || Text::literal("@"),
    // rust: |t| scoreboard::comp_text(&scoreboard::tag_to_json(t)),
    // rust: )
}
}

/// What `CommandBlock.tick` does with a block of `mode` whose condition was
/// `met` when last checked: run its command (`Some(true)`), clear the success
/// count of a conditional block (`Some(false)`), or nothing. Chain blocks
/// only run from the block before them (`executeChain`).
pub fn tick_action(mode: Mode, met: bool, conditional: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match mode {
    // rust: Mode::Sequence => None,
    // rust: _ if met => Some(true),
    // rust: _ if conditional => Some(false),
    // rust: _ => None,
}
}

/// `CommandBlock.tick`: a repeating block ticks again next tick while powered
/// or always active.
pub fn repeats(mode: Mode, powered: bool, auto: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mode == Mode::Auto && (powered || auto)
}

/// `CommandBlock.setPoweredAndUpdate`: a rising signal schedules the impulse
/// or repeating block's tick unless it is always active anyway.
pub fn power_schedules(mode: Mode, was_powered: bool, powered: bool, auto: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: powered && !was_powered && !auto && mode != Mode::Sequence
}

    // rust: mod tests {
//     use super::*;

pub fn modes_cycle_and_map_to_blocks() void {
}
    // rust: for mode in [Mode::Sequence, Mode::Auto, Mode::Redstone] {
    // rust: assert_eq!(Mode::of_block(mode.block()), Some(mode));
}
    // rust: assert_eq!(Mode::Redstone.next(), Mode::Sequence);
    // rust: assert_eq!(Mode::Sequence.next(), Mode::Auto);
    // rust: assert!(automatic_block("minecraft:chain_command_block"));
    // rust: assert!(!automatic_block("minecraft:repeating_command_block"));
}

pub fn tick_follows_the_condition() void {
}
    // rust: assert_eq!(tick_action(Mode::Redstone, true, false), Some(true));
    // rust: assert_eq!(tick_action(Mode::Redstone, false, true), Some(false));
    // rust: assert_eq!(tick_action(Mode::Auto, false, false), None);
    // rust: assert_eq!(tick_action(Mode::Sequence, true, false), None);
    // rust: assert!(repeats(Mode::Auto, false, true));
    // rust: assert!(!repeats(Mode::Auto, false, false));
    // rust: assert!(!repeats(Mode::Redstone, true, true));
}

pub fn only_a_rising_edge_schedules() void {
}
    // rust: assert!(power_schedules(Mode::Redstone, false, true, false));
    // rust: assert!(!power_schedules(Mode::Redstone, true, true, false));
    // rust: assert!(!power_schedules(Mode::Redstone, false, true, true));
    // rust: assert!(!power_schedules(Mode::Sequence, false, true, false));
}

pub fn saves_like_base_command_block() void {
}
    // rust: let block = CommandBlock {
    // rust: command: "say hi".into(),
    // rust: success_count: 1,
    // rust: last_output: Some(Text::literal("[12:00:00] hi")),
    // rust: last_execution: 42,
    // rust: powered: true,
    // rust: ..CommandBlock::default()
}
    // rust: let tag = Tag::compound(block.save());
    // rust: let back = CommandBlock::load(&tag);
    // rust: assert_eq!(back.command, "say hi");
    // rust: assert_eq!(back.success_count, 1);
    // rust: assert_eq!(back.last_output_string(), "[12:00:00] hi");
    // rust: assert_eq!(back.last_execution, 42);
    // rust: assert!(back.powered && !back.auto && back.track_output);
        // Not tracking output drops it, and no execution time is kept at -1.
    // rust: let quiet = CommandBlock {
    // rust: track_output: false,
    // rust: last_output: Some(Text::literal("x")),
    // rust: ..CommandBlock::default()
}
    // rust: let tag = Tag::compound(quiet.save());
    // rust: assert!(tag.get("LastOutput").is_none() && tag.get("LastExecution").is_none());
    // rust: assert_eq!(CommandBlock::load(&tag).last_output, None);
}
}
