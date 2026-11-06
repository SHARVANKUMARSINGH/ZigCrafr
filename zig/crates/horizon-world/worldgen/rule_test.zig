//! Transpiled from Horizon Rust crate
//! Module: horizon-world_rule_test
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registry-bound replacement predicates with ordered short-circuit evaluation.
// use super::{
    // rust: DecodeError, Object, block_feature::FeatureBlockBindings, density::identifier, integer,
    // rust: number_text, required,
}
// use crate::{
    // rust: block_properties::BoundBlockProperty,
    // rust: fluid::{FluidKind, FluidStateTable},
    // rust: registry::BlockStateId,
}
// use horizon_core::random::RandomSource;
// use serde_json::value::RawValue;
// use std::{collections::BTreeSet, sync::Arc};

pub const RuleTest = struct {};
pub const Node = enum {
    True,
    Not(Box<RuleTest>),
    All(Vec<RuleTest>),
    Any(Vec<RuleTest>),
    States(Arc<BTreeSet<BlockStateId>>),
    State(BlockStateId),
    RandomStates(Arc<BTreeSet<BlockStateId>>, f32),
    RandomState(BlockStateId, f32),
    Height(i32, i32),
    Phase(Box<MatterPhase>),
};
/// `horizon:matter_phase`: Repurposed Structures' MatterPhaseRuleTest, which
/// its mineshafts and Nether monument use to match a block by what it is
/// made of (`phase_to_test_for`), optionally inverted (`invert_condition`).
pub const MatterPhase = struct {
    phase: Phase,
    invert: bool,
    air: [BlockStateId,
    fluids: *FluidStateTable,
    /// Only for `SOLID`.
    can_occlude: ?BoundBlockProperty,
    /// Blocks.RAIL and Blocks.CHAIN (26.3's iron chain).
    rail_or_chain: BTreeSet<BlockStateId>,
};
pub const Phase = enum {
    Solid,
    Liquid,
    Air,
    AirRailOrChain,
    LiquidRailOrChain,
};
    // rust: impl MatterPhase {
pub fn decode(object: *Object, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name: String = serde_json::from_str(required(object, "phase_to_test_for")?.get())?;
    // rust: let phase = match name.as_str() {
    // rust: "SOLID" => Phase::Solid,
    // rust: "LIQUID" => Phase::Liquid,
    // rust: "AIR" => Phase::Air,
    // rust: "AIR_RAIL_OR_CHAIN" => Phase::AirRailOrChain,
    // rust: "LIQUID_RAIL_OR_CHAIN" => Phase::LiquidRailOrChain,
    // rust: _ => return Err(DecodeError::Field("matter phase")),
}
    // rust: let invert = match object.get("invert_condition") {
    // rust: Some(v) => serde_json::from_str(v.get())?,
    // rust: None => false,
}
    // rust: let can_occlude = match phase {
    // rust: Phase::Solid => Some(
    // rust: bindings
    // rust: .can_occlude
    // rust: .clone()
    // rust: .ok_or(DecodeError::Field("matter phase block properties"))?,
    // rust: ),
    // rust: _ => None,
}
    // rust: let mut rail_or_chain = BTreeSet::new();
    // rust: for name in ["minecraft:rail", "minecraft:iron_chain"] {
    // rust: rail_or_chain.extend(bindings.blocks.get(name).into_iter().flat_map(|s| s.iter()));
}
    // rust: Ok(Self {
    // rust: phase,
    // rust: invert,
    // rust: air: bindings.air,
    // rust: fluids: bindings.fluids.table().clone(),
    // rust: can_occlude,
    // rust: rail_or_chain,
    // rust: })
}
pub fn test(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let air = self.air.contains(&state);
    // rust: let liquid = self
    // rust: .fluids
    // rust: .get(state)
    // rust: .is_some_and(|f| f.kind() != FluidKind::Empty);
    // rust: let rail_or_chain = || self.rail_or_chain.contains(&state);
    // rust: let matched = match self.phase {
    // rust: Phase::Solid => {
    // rust: !air && !liquid && self.can_occlude.as_ref().is_some_and(|c| c.contains(state))
}
    // rust: Phase::Liquid => liquid,
    // rust: Phase::Air => air,
    // rust: Phase::AirRailOrChain => air || rail_or_chain(),
    // rust: Phase::LiquidRailOrChain => liquid || rail_or_chain(),
}
    // rust: matched != self.invert
}
}
    // rust: impl RuleTest {
pub fn from_json(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, bindings, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("replacement rule depth or node count"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let name = |field| -> Result<String, DecodeError> {
    // rust: identifier(&serde_json::from_str::<String>(
    // rust: required(&object, field)?.get(),
    // rust: )?)
}
    // rust: let state = || {
    // rust: bindings
    // rust: .codec
    // rust: .decode(required(&object, "block_state")?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
    // rust: let block = || {
    // rust: let name = name("block")?;
    // rust: bindings
    // rust: .blocks
    // rust: .get(&name)
    // rust: .cloned()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))
}
        // These native codecs use unrestricted FLOAT, including out-of-range
        // probabilities. Matching the state still consumes a draw at zero/one.
    // rust: let probability = || {
    // rust: number_text(required(&object, "probability")?)?
    // rust: .parse::<f32>()
    // rust: .map_err(|_| DecodeError::Field("probability"))
}
    // rust: let node = match name("predicate_type")?.as_str() {
    // rust: "minecraft:always_true" => Node::True,
    // rust: "minecraft:block_match" => Node::States(block()?),
    // rust: "minecraft:blockstate_match" => Node::State(state()?),
    // rust: "minecraft:tag_match" => Node::States(
    // rust: bindings
    // rust: .tags
    // rust: .get(&super::tags::identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "tag")?.get(),
    // rust: )?)?)
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: ),
    // rust: "minecraft:random_block_match" => Node::RandomStates(block()?, probability()?),
    // rust: "minecraft:random_blockstate_match" => Node::RandomState(state()?, probability()?),
    // rust: "minecraft:height_match" => Node::Height(
    // rust: integer(required(&object, "min_inclusive")?)?,
    // rust: integer(required(&object, "max_inclusive")?)?,
    // rust: ),
    // rust: "minecraft:not" => Node::Not(Box::new(Self::decode(
    // rust: required(&object, "rule")?.get(),
    // rust: bindings,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?)),
    // rust: kind @ ("minecraft:all_of" | "minecraft:any_of") => {
    // rust: let values: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "rules")?.get())?;
    // rust: if values.len() > 8192 {
    // rust: return Err(DecodeError::Field("replacement rule list"));
}
    // rust: let values = values
    // rust: .iter()
    // rust: .map(|v| Self::decode(v.get(), bindings, depth + 1, remaining))
    // rust: .collect::<Result<_, _>>()?;
    // rust: if kind == "minecraft:all_of" {
    // rust: Node::All(values)
    // rust: } else {
    // rust: Node::Any(values)
}
}
    // rust: "horizon:matter_phase" => {
    // rust: Node::Phase(Box::new(MatterPhase::decode(&object, bindings)?))
}
    // rust: _ => return Err(DecodeError::Field("replacement rule type")),
}
    // rust: Ok(Self(node))
}
    // rust: pub fn test(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: random: &mut impl RandomSource,
    // rust: ) -> bool {
    // rust: match &self.0 {
    // rust: Node::True => true,
    // rust: Node::Not(rule) => !rule.test(state, position, random),
    // rust: Node::All(rules) => rules.iter().all(|rule| rule.test(state, position, random)),
    // rust: Node::Any(rules) => rules.iter().any(|rule| rule.test(state, position, random)),
    // rust: Node::States(states) => states.contains(&state),
    // rust: Node::State(expected) => state == *expected,
    // rust: Node::RandomStates(states, probability) => {
    // rust: states.contains(&state) && random.next_float() < *probability
}
    // rust: Node::RandomState(expected, probability) => {
    // rust: state == *expected && random.next_float() < *probability
}
    // rust: Node::Height(min, max) => *min <= position[1] && position[1] <= *max,
    // rust: Node::Phase(phase) => phase.test(state),
}
}
}
