//! Transpiled from Horizon Rust crate
package horizon_client_render_jigsaw_block

import "core:fmt"
import "core:mem"
import "core:math"

// `JigsawBlockEntity`: the jigsaw block's name, target, pool, joint, final
// state and priorities, with its save format (`saveAdditional` /
// `loadAdditional`).
// use crate::structure_block::parse_identifier;
// use horizon_client_core::nbt_value::{number, string, text};
// use horizon_world::nbt::Tag;

// `JigsawBlockEntity.EMPTY_ID` and `Pools.EMPTY`.
EMPTY_ID :: "minecraft:empty"

// `JigsawBlockEntity.JointType`.
JointType :: enum {
    Rollable,
    Aligned,
}

    // rust: impl JointType {
ALL :: [Self::Rollable, Self::Aligned]
serialized_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Rollable => "rollable",
    // rust: Self::Aligned => "aligned",
}
}
of_serialized_name :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|j| j.serialized_name() == name)
}
    // `JointType.getTranslatedName`'s lang key.
label_key :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("jigsaw_block.joint.{}", self.serialized_name())
}
    // `StructureTemplate.getDefaultJointType`: the joint of a block whose
    // front faces `front` (the first word of its `orientation` value).
default_for_front :: proc(front: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if is_vertical_front(front) {
    // rust: Self::Rollable
    // rust: } else {
    // rust: Self::Aligned
}
}
}

// `JigsawBlock.getFrontFacing(state)` from the `orientation` value
// (`down_east`, `north_up`...): its front is the part before the `_`.
front_of_orientation :: proc(orientation: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: orientation.split('_').next().unwrap_or(orientation)
}

is_vertical_front :: proc(front: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(front, "up" | "down")
}

JigsawBlock :: struct {
    name: string,
    target: string,
    pool: string,
    joint: JointType,
    final_state: string,
    placement_priority: i32,
    selection_priority: i32,
}

    // rust: impl Default for JigsawBlock {
default :: proc() -> S {
    // Ported from Horizon
    return {}
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
    // `saveAdditional` (also `getUpdateTag`, which is `saveCustomOnly`).
save :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
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

    // `loadAdditional`. A missing joint takes `default_joint`
    // (`StructureTemplate.getDefaultJointType` of the block's state).
load :: proc(tag: ^Tag, default_joint: JointType) -> S {
    // Ported from Horizon
    return {}
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

saves_and_loads_like_jigsaw_block_entity :: proc() {
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

load_defaults_like_vanilla :: proc() {
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
