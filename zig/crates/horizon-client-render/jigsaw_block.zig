//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_jigsaw_block
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `JigsawBlockEntity`: the jigsaw block's name, target, pool, joint, final
//! state and priorities, with its save format (`saveAdditional` /
//! `loadAdditional`).
// use crate::structure_block::parse_identifier;
// use horizon_client_core::nbt_value::{number, string, text};
// use horizon_world::nbt::Tag;

/// `JigsawBlockEntity.EMPTY_ID` and `Pools.EMPTY`.
pub const EMPTY_ID: []const u8 = "minecraft:empty";

/// `JigsawBlockEntity.JointType`.
pub const JointType = enum {
    Rollable,
    Aligned,
};

    // rust: impl JointType {
pub const ALL: [Self; 2] = [Self::Rollable, Self::Aligned];
pub fn serialized_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Rollable => "rollable",
    // rust: Self::Aligned => "aligned",
}
}
pub fn of_serialized_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|j| j.serialized_name() == name)
}
    /// `JointType.getTranslatedName`'s lang key.
pub fn label_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("jigsaw_block.joint.{}", self.serialized_name())
}
    /// `StructureTemplate.getDefaultJointType`: the joint of a block whose
    /// front faces `front` (the first word of its `orientation` value).
pub fn default_for_front(front: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_vertical_front(front) {
    // rust: Self::Rollable
    // rust: } else {
    // rust: Self::Aligned
}
}
}

/// `JigsawBlock.getFrontFacing(state)` from the `orientation` value
/// (`down_east`, `north_up`...): its front is the part before the `_`.
pub fn front_of_orientation(orientation: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: orientation.split('_').next().unwrap_or(orientation)
}

pub fn is_vertical_front(front: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(front, "up" | "down")
}

pub const JigsawBlock = struct {
    name: []const u8,
    target: []const u8,
    pool: []const u8,
    joint: JointType,
    final_state: []const u8,
    placement_priority: i32,
    selection_priority: i32,
};

    // rust: impl Default for JigsawBlock {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: name: EMPTY_ID.into(),
    // rust: target: EMPTY_ID.into(),
    // rust: pool: EMPTY_ID.into(),
    // rust: joint: JointType::Rollable,
    // rust: final_state: "minecraft:air".into(),
    // rust: placement_priority: 0,
    // rust: selection_priority: 0,
}
}
}

    // rust: impl JigsawBlock {
    /// `saveAdditional` (also `getUpdateTag`, which is `saveCustomOnly`).
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec![
    // rust: ("name", string(&self.name)),
    // rust: ("target", string(&self.target)),
    // rust: ("pool", string(&self.pool)),
    // rust: ("final_state", string(&self.final_state)),
    // rust: ("joint", string(self.joint.serialized_name())),
    // rust: ("placement_priority", Tag::Int(self.placement_priority)),
    // rust: ("selection_priority", Tag::Int(self.selection_priority)),
    // rust: ]
}

    /// `loadAdditional`. A missing joint takes `default_joint`
    /// (`StructureTemplate.getDefaultJointType` of the block's state).
pub fn load(tag: *Tag, default_joint: JointType) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = |key: &str| {
    // rust: text(tag.get(key))
    // rust: .and_then(|s| parse_identifier(&s))
    // rust: .unwrap_or_else(|| EMPTY_ID.into())
}
    // rust: Self {
    // rust: name: id("name"),
    // rust: target: id("target"),
    // rust: pool: id("pool"),
    // rust: final_state: text(tag.get("final_state")).unwrap_or_else(|| "minecraft:air".into()),
    // rust: joint: text(tag.get("joint"))
    // rust: .and_then(|j| JointType::of_serialized_name(&j))
    // rust: .unwrap_or(default_joint),
    // rust: placement_priority: number(tag.get("placement_priority")).unwrap_or(0) as i32,
    // rust: selection_priority: number(tag.get("selection_priority")).unwrap_or(0) as i32,
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn saves_and_loads_like_jigsaw_block_entity() void {
}
    // rust: let block = JigsawBlock {
    // rust: name: "minecraft:bottom".into(),
    // rust: target: "test:top".into(),
    // rust: pool: "minecraft:village/plains/houses".into(),
    // rust: joint: JointType::Aligned,
    // rust: final_state: "minecraft:stone[x=1]".into(),
    // rust: placement_priority: 4,
    // rust: selection_priority: -1,
}
    // rust: let tag = Tag::compound(block.save());
    // rust: assert_eq!(text(tag.get("joint")).as_deref(), Some("aligned"));
    // rust: assert_eq!(JigsawBlock::load(&tag, JointType::Rollable), block);
}

pub fn load_defaults_like_vanilla() void {
}
    // rust: let tag = Tag::compound(vec![
    // rust: ("name", string("Bad Name")),
    // rust: ("target", string("door")),
    // rust: ]);
    // rust: let block = JigsawBlock::load(&tag, JointType::Aligned);
    // rust: assert_eq!(block.name, EMPTY_ID);
    // rust: assert_eq!(block.target, "minecraft:door");
    // rust: assert_eq!(block.pool, EMPTY_ID);
    // rust: assert_eq!(block.final_state, "minecraft:air");
    // rust: assert_eq!(block.joint, JointType::Aligned);
    // rust: assert_eq!(JointType::default_for_front("up"), JointType::Rollable);
    // rust: assert_eq!(
    // rust: JointType::default_for_front(front_of_orientation("north_up")),
    // rust: JointType::Aligned
    // rust: );
}
}
