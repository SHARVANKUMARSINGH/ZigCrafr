//! Transpiled from Horizon Rust crate
//! Module: horizon-world_feature_graph
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Inline feature composition. Named holders, tags and registry reloads remain
//! separate from this bounded executable tree.
// use super::block_predicate::PredicateBlockResolver;
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::{
    // rust: BlockFeatureError, FeatureBlockBindings, FillLayerFeature, ReplaceBlockFeature,
    // rust: },
    // rust: density::identifier,
    // rust: feature::{BasicFeature, FeatureBlocks, FeatureError, FeatureWorld},
    // rust: number_text,
    // rust: ore_feature::ScatteredOreFeature,
    // rust: placement::{
    // rust: FeaturePlacementError, FeaturePlacer, PlacementContext, PlacementModifier,
    // rust: PlacementQueryError,
    // rust: },
    // rust: required,
    // rust: weighted::OptionalWeightedList,
}
// use horizon_core::random::{InvalidBound, RandomSource};
// use serde_json::value::RawValue;
// use std::{cell::Cell, collections::BTreeSet};

pub const PlacedFeatureDefinition = struct {
    feature: *FeatureDefinition,
    placement: std.ArrayList(PlacementModifier),
};
pub const FeatureDefinition = enum {
    Basic(BasicFeature),
    NeighborSpread {,
    provider: super::state_provider::BlockStateProvider,
    neighbors: std::sync::Arc<std::collections::BTreeSet<crate::registry::BlockStateId>>,
    can_replace: super::block_predicate::BlockPredicate,
    attempts: super::value_provider::IntProvider,
    xz_offset: super::value_provider::IntProvider,
    y_offset: super::value_provider::IntProvider,
    // rust: },
    Pillar {,
    provider: super::state_provider::BlockStateProvider,
    can_replace: super::block_predicate::BlockPredicate,
    direction: horizon_core::geometry::Direction,
    chance: f32,
    cap: Option<Box<PlacedFeatureDefinition>>,
    // rust: },
    BlockColumn(super::block_column::BlockColumnFeature),
    BlockPile(super::block_pile::BlockPileFeature),
    Disk(super::disk::DiskFeature),
    Spring(super::spring::SpringFeature),
    Vines(super::vines::VinesFeature),
    SnowAndFreeze(super::snow_freeze::SnowAndFreezeFeature),
    Delta(super::delta::DeltaFeature),
    Bamboo(super::bamboo::BambooFeature),
    ReplaceBlobs(super::replace_blobs::ReplaceBlobsFeature),
    EndPodium(super::end_podium::EndPodiumFeature),
    EndGateway(super::end_gateway::EndGatewayFeature),
    BonusChest(super::bonus_chest::BonusChestFeature),
    ChorusPlant(super::chorus_plant::ChorusPlantFeature),
    Speleothem(super::speleothem::SpeleothemFeature),
    Spike(super::spike::SpikeFeature),
    BlueIce(super::blue_ice::BlueIceFeature),
    UnderwaterMagma(super::underwater_magma::UnderwaterMagmaFeature),
    BlockBlob(super::block_blob::BlockBlobFeature),
    SimpleBlock(super::simple_block::SimpleBlockFeature),
    FillLayer(FillLayerFeature),
    ReplaceBlock(ReplaceBlockFeature),
    ScatteredOre(ScatteredOreFeature),
    Ore(super::ore_feature::OreFeature),
    Tree(Box<super::tree::TreeFeature>),
    VegetationPatch(Box<super::vegetation::VegetationPatchFeature>),
    Coral(Box<super::vegetation::CoralFeature>),
    HugeMushroom(Box<super::vegetation::HugeMushroomFeature>),
    MultifaceGrowth(Box<super::vegetation::MultifaceGrowthFeature>),
    Lake(Box<super::cave::LakeFeature>),
    MonsterRoom(Box<super::cave::MonsterRoomFeature>),
    Geode(Box<super::cave::GeodeFeature>),
    Iceberg(Box<super::iceberg::IcebergFeature>),
    RootSystem(Box<super::root_system::RootSystemFeature>),
    SpeleothemCluster(Box<super::dripstone::SpeleothemClusterFeature>),
    LargeDripstone(Box<super::dripstone::LargeDripstoneFeature>),
    HugeFungus(Box<super::fungus::HugeFungusFeature>),
    SculkPatch(Box<super::sculk::SculkPatchFeature>),
    EndSpike(Box<super::end_spike::EndSpikeFeature>),
    ProjectedPatchySquare(Box<super::projected::ProjectedPatchySquareFeature>),
    SteppedColumnCluster(Box<super::projected::SteppedColumnClusterFeature>),
    FallenTree(Box<super::tree::FallenTreeFeature>),
    NoOp,
    Template(Box<super::structure::features::TemplateFeature>),
    Fossil(Box<super::structure::features::FossilFeature>),
    WeightedChoice(OptionalWeightedList<PlacedFeatureDefinition>),
    Sequence(Vec<PlacedFeatureDefinition>),
    Overlay(Vec<PlacedFeatureDefinition>),
    BooleanChoice(Box<[PlacedFeatureDefinition; 2]>),
    RandomChoice(Vec<PlacedFeatureDefinition>),
    ChanceChoice {,
    features: Vec<(f32, PlacedFeatureDefinition)>,
    fallback: Box<PlacedFeatureDefinition>,
    // rust: },
};
pub const FeatureExecutionError = enum {
    Basic(FeatureError<E>),
    Provider(super::state_provider::StateProviderError<E>),
    BlockColumn(super::block_column::BlockColumnError<E>),
    BlockPile(super::block_pile::BlockPileError<E>),
    Disk(super::disk::DiskError<E>),
    BlockBlob(super::block_blob::BlockBlobError<E>),
    SnowAndFreeze(super::snow_freeze::SnowAndFreezeError<E>),
    Delta(super::delta::DeltaError<E>),
    Bamboo(super::bamboo::BambooError<E>),
    ReplaceBlobs(super::replace_blobs::ReplaceBlobsError<E>),
    EndPodium(super::end_podium::EndPodiumError<E>),
    EndGateway(super::end_gateway::EndGatewayError<E>),
    BonusChest(super::bonus_chest::BonusChestError<E>),
    ChorusPlant(super::chorus_plant::ChorusPlantError<E>),
    Speleothem(super::speleothem::SpeleothemError<E>),
    Spike(super::spike::SpikeError<E>),
    BlueIce(super::blue_ice::BlueIceError<E>),
    UnderwaterMagma(super::underwater_magma::UnderwaterMagmaError<E>),
    SimpleBlock(super::simple_block::SimpleBlockError<E>),
    Random(InvalidBound),
    Query(PlacementQueryError),
    WorkLimit,
    InvalidPendingIndex,
    /// A block-state transition required by a feature is absent from the registry.
    InvalidState,
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for FeatureExecutionError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Basic(e) => e.fmt(f),
    // rust: Self::Provider(e) => e.fmt(f),
    // rust: Self::BlockColumn(e) => e.fmt(f),
    // rust: Self::BlockPile(e) => e.fmt(f),
    // rust: Self::Disk(e) => e.fmt(f),
    // rust: Self::BlockBlob(e) => e.fmt(f),
    // rust: Self::SnowAndFreeze(e) => e.fmt(f),
    // rust: Self::Delta(e) => e.fmt(f),
    // rust: Self::Bamboo(e) => e.fmt(f),
    // rust: Self::ReplaceBlobs(e) => e.fmt(f),
    // rust: Self::EndPodium(e) => e.fmt(f),
    // rust: Self::EndGateway(e) => e.fmt(f),
    // rust: Self::BonusChest(e) => e.fmt(f),
    // rust: Self::ChorusPlant(e) => e.fmt(f),
    // rust: Self::Speleothem(e) => e.fmt(f),
    // rust: Self::Spike(e) => e.fmt(f),
    // rust: Self::BlueIce(e) => e.fmt(f),
    // rust: Self::UnderwaterMagma(e) => e.fmt(f),
    // rust: Self::SimpleBlock(e) => e.fmt(f),
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("feature graph work limit exceeded"),
    // rust: Self::InvalidPendingIndex => f.write_str("invalid pending modifier index"),
    // rust: Self::InvalidState => f.write_str("feature block state outside registry"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FeatureExecutionError<E> {}
    // rust: impl<E> From<InvalidBound> for FeatureExecutionError<E> {
pub fn from(error: InvalidBound) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Random(error)
}
}
    // rust: impl<E> From<FeaturePlacementError<Self>> for FeatureExecutionError<E> {
pub fn from(error: FeaturePlacementError<Self>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match error {
    // rust: FeaturePlacementError::Feature(e) => e,
    // rust: FeaturePlacementError::Random(e) => Self::Random(e),
    // rust: FeaturePlacementError::World(e) => Self::Query(e),
    // rust: FeaturePlacementError::WorkLimit => Self::WorkLimit,
    // rust: FeaturePlacementError::InvalidPendingIndex => Self::InvalidPendingIndex,
}
}
}
pub const Run = struct {
    blocks: FeatureBlocks,
    depth: Cell<usize>,
    remaining: Cell<usize>,
};
pub fn visit(depth: usize, remaining: *mut usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("feature graph depth or node count"));
}
    // rust: *remaining -= 1;
    // rust: Ok(())
}
pub fn list(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.len() > 8192 {
    // rust: return Err(DecodeError::Field("feature list"));
}
    // rust: Ok(values)
}
    // rust: impl PlacedFeatureDefinition {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, 0, &mut 65536, &BTreeSet::new(), None)
}
    // rust: pub fn from_json_with_blocks(
    // rust: json: &str,
    // rust: blocks: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode(json, 0, &mut 65536, &BTreeSet::new(), Some(blocks))
}
    // rust: pub(crate) fn from_catalog_json(
    // rust: json: &str,
    // rust: empty_tags: &BTreeSet<String>,
    // rust: blocks: Option<&FeatureBlockBindings<'_>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode(json, 0, &mut 65536, empty_tags, blocks)
}
    // rust: fn decode(
    // rust: json: &str,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: empty_tags: &BTreeSet<String>,
    // rust: blocks: Option<&FeatureBlockBindings<'_>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: visit(depth, remaining)?;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let feature = Box::new(FeatureDefinition::decode(
    // rust: required(&object, "feature")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )?);
    // rust: let values = list(required(&object, "placement")?)?;
    // rust: if values.len() > 1024 {
    // rust: return Err(DecodeError::Field("feature modifier chain"));
}
    // rust: let placement = values
    // rust: .iter()
    // rust: .map(|raw| {
    // rust: PlacementModifier::decode_with_blocks(
    // rust: raw.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: blocks.map(|b| b as &dyn super::block_predicate::PredicateBlockResolver),
    // rust: )
    // rust: })
    // rust: .collect::<Result<_, _>>()?;
    // rust: Ok(Self { feature, placement })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: blocks: FeatureBlocks,
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: self.place_in(
    // rust: &mut FeaturePlacer::new(),
    // rust: world,
    // rust: random,
    // rust: origin,
    // rust: &Run {
    // rust: blocks,
    // rust: depth: Cell::new(0),
    // rust: remaining: Cell::new(65536),
    // rust: },
    // rust: )
}
    // rust: fn place_in<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: placer: &mut FeaturePlacer,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: run: &Run,
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: if run.remaining.get() == 0 {
    // rust: return Err(FeatureExecutionError::WorkLimit);
}
    // rust: run.remaining.set(run.remaining.get() - 1);
    // rust: Ok(placer.place_with_budget(
    // rust: &self.placement,
    // rust: world,
    // rust: random,
    // rust: origin,
    // rust: &run.remaining,
    // rust: |world, random, p| self.feature.place_inner(world, random, p, run),
    // rust: )?)
}
}
    // rust: impl FeatureDefinition {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, 0, &mut 65536, &BTreeSet::new(), None)
}
    // rust: pub fn from_json_with_blocks(
    // rust: json: &str,
    // rust: blocks: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode(json, 0, &mut 65536, &BTreeSet::new(), Some(blocks))
}
    // rust: pub(crate) fn from_catalog_json(
    // rust: json: &str,
    // rust: empty_tags: &BTreeSet<String>,
    // rust: blocks: Option<&FeatureBlockBindings<'_>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode(json, 0, &mut 65536, empty_tags, blocks)
}
    // rust: fn decode(
    // rust: json: &str,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: empty_tags: &BTreeSet<String>,
    // rust: blocks: Option<&FeatureBlockBindings<'_>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: visit(depth, remaining)?;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: match kind.as_str() {
    // rust: "minecraft:no_op" => Ok(Self::NoOp),
    // rust: "minecraft:template" => super::structure::features::TemplateFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("template bindings"))?,
    // rust: )
    // rust: .map(|f| Self::Template(Box::new(f))),
    // rust: "minecraft:fossil" => super::structure::features::FossilFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("fossil bindings"))?,
    // rust: )
    // rust: .map(|f| Self::Fossil(Box::new(f))),
    // rust: "minecraft:freeze_top_layer" => super::snow_freeze::SnowAndFreezeFeature::new(
    // rust: blocks.ok_or(DecodeError::Field("snow and freeze bindings"))?,
    // rust: )
    // rust: .map(Self::SnowAndFreeze),
    // rust: "minecraft:delta_feature" => super::delta::DeltaFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("delta bindings"))?,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::Delta),
    // rust: "minecraft:bamboo" => super::bamboo::BambooFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("bamboo bindings"))?,
    // rust: )
    // rust: .map(Self::Bamboo),
    // rust: "minecraft:netherrack_replace_blobs" => {
    // rust: super::replace_blobs::ReplaceBlobsFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("replace blobs bindings"))?,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::ReplaceBlobs)
}
    // rust: "minecraft:speleothem" => super::speleothem::SpeleothemFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("speleothem bindings"))?,
    // rust: )
    // rust: .map(Self::Speleothem),
    // rust: "minecraft:chorus_plant" => super::chorus_plant::ChorusPlantFeature::new(
    // rust: blocks.ok_or(DecodeError::Field("chorus plant bindings"))?,
    // rust: )
    // rust: .map(Self::ChorusPlant),
    // rust: "minecraft:bonus_chest" => super::bonus_chest::BonusChestFeature::new(
    // rust: blocks.ok_or(DecodeError::Field("bonus chest bindings"))?,
    // rust: )
    // rust: .map(Self::BonusChest),
    // rust: "minecraft:end_gateway" => super::end_gateway::EndGatewayFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("end gateway bindings"))?,
    // rust: )
    // rust: .map(Self::EndGateway),
    // rust: "minecraft:end_podium" => super::end_podium::EndPodiumFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("end podium bindings"))?,
    // rust: )
    // rust: .map(Self::EndPodium),
    // rust: "minecraft:spike" => super::spike::SpikeFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("spike bindings"))?,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::Spike),
    // rust: "minecraft:blue_ice" => super::blue_ice::BlueIceFeature::new(
    // rust: blocks.ok_or(DecodeError::Field("blue ice bindings"))?,
    // rust: )
    // rust: .map(Self::BlueIce),
    // rust: "minecraft:underwater_magma" => {
    // rust: super::underwater_magma::UnderwaterMagmaFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("underwater magma bindings"))?,
    // rust: )
    // rust: .map(Self::UnderwaterMagma)
}
    // rust: "minecraft:vines" => super::vines::VinesFeature::new(
    // rust: blocks.ok_or(DecodeError::Field("vine feature bindings"))?,
    // rust: )
    // rust: .map(Self::Vines),
    // rust: "minecraft:spring_feature" => super::spring::SpringFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("spring bindings"))?,
    // rust: )
    // rust: .map(Self::Spring),
    // rust: "minecraft:block_blob" => super::block_blob::BlockBlobFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("block blob bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::BlockBlob),
    // rust: "minecraft:disk" => super::disk::DiskFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("disk bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::Disk),
    // rust: "minecraft:block_pile" => super::block_pile::BlockPileFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("block pile bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::BlockPile),
    // rust: "minecraft:random_neighbor_spread" => {
    // rust: let bindings =
    // rust: blocks.ok_or(DecodeError::Field("neighbor spread block bindings"))?;
    // rust: let (providers, catalog, _) = bindings
    // rust: .simple_blocks
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("neighbor spread provider bindings"))?;
    // rust: let provider = catalog.provider_with_budget(
    // rust: required(&object, "block")?.get(),
    // rust: providers,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?;
    // rust: let neighbors =
    // rust: bindings.predicate_block_set(required(&object, "accepted_neighbors")?.get())?;
    // rust: let can_replace = super::block_predicate::BlockPredicate::decode_with_blocks(
    // rust: required(&object, "can_replace")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )?;
    // rust: let mut integer = |name, low, high| {
    // rust: let value = super::value_provider::IntProvider::decode(
    // rust: required(&object, name)?,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?;
    // rust: let bounds = value.bounds();
    // rust: if bounds[0] < low || bounds[1] > high {
    // rust: return Err(DecodeError::Field("neighbor spread integer range"));
}
    // rust: Ok(value)
}
    // rust: let attempts = integer("attempts", 1, 3000)?;
    // rust: let xz_offset = integer("xz_offset", -16, 16)?;
    // rust: let y_offset = integer("y_offset", -16, 16)?;
    // rust: Ok(Self::NeighborSpread {
    // rust: provider,
    // rust: neighbors,
    // rust: can_replace,
    // rust: attempts,
    // rust: xz_offset,
    // rust: y_offset,
    // rust: })
}
    // rust: "minecraft:single_block_pillar" => {
    // rust: let bindings =
    // rust: blocks.ok_or(DecodeError::Field("pillar block bindings unavailable"))?;
    // rust: let (providers, catalog, _) = bindings
    // rust: .simple_blocks
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("pillar provider bindings unavailable"))?;
    // rust: let provider = catalog.provider_with_budget(
    // rust: required(&object, "block")?.get(),
    // rust: providers,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?;
    // rust: let can_replace = match super::optional(&object, "can_replace") {
    // rust: Some(raw) => super::block_predicate::BlockPredicate::decode_with_blocks(
    // rust: raw.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )?,
    // rust: None => {
    // rust: super::block_predicate::BlockPredicate::from_json(r#"{"type":"true"}"#)?
}
}
    // rust: let direction =
    // rust: match serde_json::from_str::<String>(required(&object, "direction")?.get())?
    // rust: .as_str()
    // rust: {
    // rust: "up" => horizon_core::geometry::Direction::Up,
    // rust: "down" => horizon_core::geometry::Direction::Down,
    // rust: _ => return Err(DecodeError::Field("pillar vertical direction")),
}
    // rust: let chance = match super::optional(&object, "chance_to_continue") {
    // rust: Some(raw) => number_text(raw)?
    // rust: .parse::<f64>()
    // rust: .map_err(|_| DecodeError::Field("pillar chance"))?
    // rust: as f32,
    // rust: None => 1.0,
}
    // rust: if !(0.0..=1.0).contains(&chance) || chance.is_sign_negative() {
    // rust: return Err(DecodeError::Field("pillar chance"));
}
    // rust: let cap = super::optional(&object, "cap_feature")
    // rust: .map(|raw| {
    // rust: PlacedFeatureDefinition::decode(
    // rust: raw.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )
    // rust: .map(Box::new)
    // rust: })
    // rust: .transpose()?;
    // rust: Ok(Self::Pillar {
    // rust: provider,
    // rust: can_replace,
    // rust: direction,
    // rust: chance,
    // rust: cap,
    // rust: })
}
    // rust: "minecraft:block_column" => super::block_column::BlockColumnFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("block column bindings unavailable"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::BlockColumn),
    // rust: "minecraft:simple_block" => {
    // rust: let (providers, catalog, placement) = blocks
    // rust: .and_then(|blocks| blocks.simple_blocks.as_ref())
    // rust: .ok_or(DecodeError::Field("simple block bindings unavailable"))?;
    // rust: super::simple_block::SimpleBlockFeature::decode(
    // rust: json, providers, catalog, placement, depth, remaining,
    // rust: )
    // rust: .map(Self::SimpleBlock)
}
    // rust: "minecraft:fill_layer" => FillLayerFeature::from_json(
    // rust: json,
    // rust: blocks.ok_or_else(|| {
    // rust: DecodeError::Registry("feature block bindings unavailable".into())
    // rust: })?,
    // rust: )
    // rust: .map(Self::FillLayer),
    // rust: "minecraft:replace_single_block" => ReplaceBlockFeature::decode(
    // rust: json,
    // rust: blocks.ok_or_else(|| {
    // rust: DecodeError::Registry("feature block bindings unavailable".into())
    // rust: })?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::ReplaceBlock),
    // rust: "minecraft:ore" => super::ore_feature::OreFeature::decode(
    // rust: json,
    // rust: blocks.ok_or_else(|| {
    // rust: DecodeError::Registry("feature block bindings unavailable".into())
    // rust: })?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::Ore),
    // rust: "minecraft:scattered_ore" => ScatteredOreFeature::decode(
    // rust: json,
    // rust: blocks.ok_or_else(|| {
    // rust: DecodeError::Registry("feature block bindings unavailable".into())
    // rust: })?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(Self::ScatteredOre),
    // rust: "minecraft:vegetation_patch" | "minecraft:waterlogged_vegetation_patch" => {
    // rust: let bindings = blocks.ok_or(DecodeError::Field("vegetation patch bindings"))?;
    // rust: let nested = |json: &str, depth: usize, remaining: &mut usize| {
    // rust: PlacedFeatureDefinition::decode(json, depth, remaining, empty_tags, blocks)
}
    // rust: super::vegetation::VegetationPatchFeature::decode(
    // rust: json, bindings, depth, remaining, &nested,
    // rust: )
    // rust: .map(|f| Self::VegetationPatch(Box::new(f)))
}
    // rust: "minecraft:root_system" => {
    // rust: let bindings = blocks.ok_or(DecodeError::Field("root system bindings"))?;
    // rust: let nested = |json: &str, depth: usize, remaining: &mut usize| {
    // rust: PlacedFeatureDefinition::decode(json, depth, remaining, empty_tags, blocks)
}
    // rust: super::root_system::RootSystemFeature::decode(
    // rust: json, bindings, depth, remaining, &nested,
    // rust: )
    // rust: .map(|f| Self::RootSystem(Box::new(f)))
}
    // rust: "minecraft:coral_tree" | "minecraft:coral_claw" => {
    // rust: let nested = |json: &str, depth: usize, remaining: &mut usize| {
    // rust: PlacedFeatureDefinition::decode(json, depth, remaining, empty_tags, blocks)
}
    // rust: super::vegetation::CoralFeature::decode(json, depth, remaining, &nested)
    // rust: .map(|f| Self::Coral(Box::new(f)))
}
    // rust: "minecraft:huge_red_mushroom" | "minecraft:huge_brown_mushroom" => {
    // rust: super::vegetation::HugeMushroomFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("huge mushroom bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::HugeMushroom(Box::new(f)))
}
    // rust: "minecraft:lake" => super::cave::LakeFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("lake bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::Lake(Box::new(f))),
    // rust: "minecraft:monster_room" => super::cave::MonsterRoomFeature::new(
    // rust: blocks.ok_or(DecodeError::Field("monster room bindings"))?,
    // rust: )
    // rust: .map(|f| Self::MonsterRoom(Box::new(f))),
    // rust: "minecraft:geode" => super::cave::GeodeFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("geode bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::Geode(Box::new(f))),
    // rust: "minecraft:speleothem_cluster" => super::dripstone::SpeleothemClusterFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("speleothem cluster bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::SpeleothemCluster(Box::new(f))),
    // rust: "minecraft:large_dripstone" => super::dripstone::LargeDripstoneFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("large dripstone bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::LargeDripstone(Box::new(f))),
    // rust: "minecraft:projected_random_patchy_square" => {
    // rust: super::projected::ProjectedPatchySquareFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("patchy square bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::ProjectedPatchySquare(Box::new(f)))
}
    // rust: "minecraft:stepped_column_cluster" => {
    // rust: super::projected::SteppedColumnClusterFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("column cluster bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::SteppedColumnCluster(Box::new(f)))
}
    // rust: "minecraft:end_spike" => super::end_spike::EndSpikeFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("end spike bindings"))?,
    // rust: )
    // rust: .map(|f| Self::EndSpike(Box::new(f))),
    // rust: "minecraft:sculk_patch" => super::sculk::SculkPatchFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("sculk patch bindings"))?,
    // rust: )
    // rust: .map(|f| Self::SculkPatch(Box::new(f))),
    // rust: "minecraft:huge_fungus" => super::fungus::HugeFungusFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("huge fungus bindings"))?,
    // rust: depth,
    // rust: remaining,
    // rust: )
    // rust: .map(|f| Self::HugeFungus(Box::new(f))),
    // rust: "minecraft:iceberg" => super::iceberg::IcebergFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("iceberg bindings"))?,
    // rust: )
    // rust: .map(|f| Self::Iceberg(Box::new(f))),
    // rust: "minecraft:multiface_growth" => super::vegetation::MultifaceGrowthFeature::decode(
    // rust: json,
    // rust: blocks.ok_or(DecodeError::Field("multiface bindings"))?,
    // rust: )
    // rust: .map(|f| Self::MultifaceGrowth(Box::new(f))),
    // rust: "minecraft:tree" | "minecraft:fallen_tree" => {
    // rust: let bindings = blocks.ok_or(DecodeError::Field("tree bindings"))?;
    // rust: let nested = |json: &str, depth: usize, remaining: &mut usize| {
    // rust: Self::decode(json, depth, remaining, empty_tags, blocks)
}
    // rust: if kind == "minecraft:tree" {
    // rust: super::tree::TreeFeature::decode(json, bindings, depth, remaining, &nested)
    // rust: .map(|t| Self::Tree(Box::new(t)))
    // rust: } else {
    // rust: super::tree::FallenTreeFeature::decode(
    // rust: json, bindings, depth, remaining, &nested,
    // rust: )
    // rust: .map(|t| Self::FallenTree(Box::new(t)))
}
}
    // rust: "minecraft:weighted_random_selector" => Ok(Self::WeightedChoice(
    // rust: OptionalWeightedList::decode(required(&object, "features")?, |raw| {
    // rust: PlacedFeatureDefinition::decode(
    // rust: raw.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )
    // rust: })?,
    // rust: )),
    // rust: "minecraft:sequence" | "minecraft:overlay" | "minecraft:simple_random_selector" => {
    // rust: let raw = required(&object, "features")?;
    // rust: let name = serde_json::from_str::<String>(raw.get()).ok();
    // rust: let named_empty = name
    // rust: .as_deref()
    // rust: .and_then(|s| s.strip_prefix('#'))
    // rust: .map(identifier)
    // rust: .transpose()?
    // rust: .is_some_and(|name| empty_tags.contains(&name));
    // rust: if named_empty {
    // rust: return Ok(match kind.as_str() {
    // rust: "minecraft:sequence" => Self::Sequence(vec![]),
    // rust: "minecraft:overlay" => Self::Overlay(vec![]),
    // rust: _ => Self::RandomChoice(vec![]),
    // rust: });
}
    // rust: let values = if raw.get().trim_start().starts_with('[') {
    // rust: list(raw)?
    // rust: } else {
    // rust: vec![raw.to_owned()]
}
    // rust: if values.is_empty() {
    // rust: return Err(DecodeError::Field("empty feature list"));
}
    // rust: let features = values
    // rust: .iter()
    // rust: .map(|raw| {
    // rust: PlacedFeatureDefinition::decode(
    // rust: raw.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )
    // rust: })
    // rust: .collect::<Result<_, _>>()?;
    // rust: Ok(match kind.as_str() {
    // rust: "minecraft:sequence" => Self::Sequence(features),
    // rust: "minecraft:overlay" => Self::Overlay(features),
    // rust: _ => Self::RandomChoice(features),
    // rust: })
}
    // rust: "minecraft:random_boolean_selector" => Ok(Self::BooleanChoice(Box::new([
    // rust: PlacedFeatureDefinition::decode(
    // rust: required(&object, "feature_true")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )?,
    // rust: PlacedFeatureDefinition::decode(
    // rust: required(&object, "feature_false")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )?,
    // rust: ]))),
    // rust: "minecraft:random_selector" => {
    // rust: let values = list(required(&object, "features")?)?;
    // rust: let mut features = Vec::with_capacity(values.len());
    // rust: for raw in values {
    // rust: let entry: Object = serde_json::from_str(raw.get())?;
    // rust: let feature = PlacedFeatureDefinition::decode(
    // rust: required(&entry, "feature")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )?;
    // rust: let chance: f32 = number_text(required(&entry, "chance")?)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("feature chance"))?;
    // rust: if !(0. ..=1.).contains(&chance) || chance.is_sign_negative() {
    // rust: return Err(DecodeError::Field("feature chance"));
}
    // rust: features.push((chance, feature));
}
    // rust: Ok(Self::ChanceChoice {
    // rust: features,
    // rust: fallback: Box::new(PlacedFeatureDefinition::decode(
    // rust: required(&object, "default")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: empty_tags,
    // rust: blocks,
    // rust: )?),
    // rust: })
}
    // rust: _ => BasicFeature::from_json(json).map(Self::Basic),
}
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: blocks: FeatureBlocks,
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: self.place_inner(
    // rust: world,
    // rust: random,
    // rust: origin,
    // rust: &Run {
    // rust: blocks,
    // rust: depth: Cell::new(0),
    // rust: remaining: Cell::new(65536),
    // rust: },
    // rust: )
}
    // rust: fn place_inner<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: run: &Run,
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: if run.depth.get() >= 128 || run.remaining.get() == 0 {
    // rust: return Err(FeatureExecutionError::WorkLimit);
}
    // rust: run.depth.set(run.depth.get() + 1);
    // rust: run.remaining.set(run.remaining.get() - 1);
    // rust: let result = self.evaluate(world, random, origin, run);
    // rust: run.depth.set(run.depth.get() - 1);
    // rust: result
}
    // rust: fn evaluate<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: run: &Run,
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: let mut placer = FeaturePlacer::new();
    // rust: match self {
    // rust: Self::Basic(feature) => feature
    // rust: .place(world, random, origin, run.blocks)
    // rust: .map_err(FeatureExecutionError::Basic),
    // rust: Self::NoOp => Ok(true),
    // rust: Self::Template(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Query),
    // rust: Self::Fossil(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Query),
    // rust: Self::SnowAndFreeze(feature) => feature
    // rust: .place(world, origin)
    // rust: .map_err(FeatureExecutionError::SnowAndFreeze),
    // rust: Self::Delta(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Delta),
    // rust: Self::Bamboo(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Bamboo),
    // rust: Self::ReplaceBlobs(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::ReplaceBlobs),
    // rust: Self::Speleothem(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Speleothem),
    // rust: Self::ChorusPlant(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::ChorusPlant),
    // rust: Self::BonusChest(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::BonusChest),
    // rust: Self::EndGateway(feature) => feature
    // rust: .place(world, origin)
    // rust: .map_err(FeatureExecutionError::EndGateway),
    // rust: Self::EndPodium(feature) => feature
    // rust: .place(world, origin)
    // rust: .map_err(FeatureExecutionError::EndPodium),
    // rust: Self::Spike(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Spike),
    // rust: Self::BlueIce(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::BlueIce),
    // rust: Self::UnderwaterMagma(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::UnderwaterMagma),
    // rust: Self::Vines(feature) => feature.place(world, origin).map_err(|e| match e {
    // rust: BlockFeatureError::World(e) => FeatureExecutionError::Basic(FeatureError::World(e)),
    // rust: BlockFeatureError::Query(e) => FeatureExecutionError::Query(e),
    // rust: }),
    // rust: Self::Spring(feature) => feature.place(world, origin).map_err(|e| match e {
    // rust: BlockFeatureError::World(e) => FeatureExecutionError::Basic(FeatureError::World(e)),
    // rust: BlockFeatureError::Query(e) => FeatureExecutionError::Query(e),
    // rust: }),
    // rust: Self::BlockBlob(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::BlockBlob),
    // rust: Self::Disk(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Disk),
    // rust: Self::BlockPile(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::BlockPile),
    // rust: Self::NeighborSpread {
    // rust: provider,
    // rust: neighbors,
    // rust: can_replace,
    // rust: attempts,
    // rust: xz_offset,
    // rust: y_offset,
    // rust: } => {
    // rust: let state = provider
    // rust: .get_state(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Provider)?;
    // rust: world
    // rust: .set_block(origin, state, 2)
    // rust: .map_err(|e| FeatureExecutionError::Basic(FeatureError::World(e)))?;
    // rust: let count = attempts.sample(random)?;
    // rust: for _ in 0..count {
    // rust: if run.remaining.get() == 0 {
    // rust: return Err(FeatureExecutionError::WorkLimit);
}
    // rust: run.remaining.set(run.remaining.get() - 1);
    // rust: let dx = xz_offset.sample(random)?;
    // rust: let dy = y_offset.sample(random)?;
    // rust: let dz = xz_offset.sample(random)?;
    // rust: let position = [
    // rust: origin[0].wrapping_add(dx),
    // rust: origin[1].wrapping_add(dy),
    // rust: origin[2].wrapping_add(dz),
    // rust: ];
    // rust: if !can_replace
    // rust: .test(world, position)
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: {
    // rust: continue;
}
    // rust: let mut found = 0;
    // rust: for direction in horizon_core::geometry::Direction::ALL {
    // rust: let step = direction.normal();
    // rust: let neighbor = std::array::from_fn(|i| position[i].wrapping_add(step[i]));
    // rust: let state = world
    // rust: .block(neighbor)
    // rust: .map_err(|e| FeatureExecutionError::Basic(FeatureError::World(e)))?;
    // rust: found += i32::from(neighbors.contains(&state));
    // rust: if found > 1 {
    // rust: break;
}
}
    // rust: if found == 1 {
    // rust: let state = provider
    // rust: .get_state(world, random, position)
    // rust: .map_err(FeatureExecutionError::Provider)?;
    // rust: world
    // rust: .set_block(position, state, 2)
    // rust: .map_err(|e| FeatureExecutionError::Basic(FeatureError::World(e)))?;
}
}
    // rust: Ok(true)
}
    // rust: Self::Pillar {
    // rust: provider,
    // rust: can_replace,
    // rust: direction,
    // rust: chance,
    // rust: cap,
    // rust: } => {
    // rust: let mut position = origin;
    // rust: let step = direction.normal();
    // rust: loop {
    // rust: if run.remaining.get() == 0 {
    // rust: return Err(FeatureExecutionError::WorkLimit);
}
    // rust: run.remaining.set(run.remaining.get() - 1);
    // rust: if !can_replace
    // rust: .test(world, position)
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: {
    // rust: break;
}
    // rust: if random.next_float() >= *chance {
    // rust: break;
}
    // rust: if world
    // rust: .outside_build_height(position[1])
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: {
    // rust: break;
}
    // rust: let state = provider
    // rust: .get_state(world, random, position)
    // rust: .map_err(FeatureExecutionError::Provider)?;
    // rust: world
    // rust: .set_block(position, state, 2)
    // rust: .map_err(|e| FeatureExecutionError::Basic(FeatureError::World(e)))?;
    // rust: position = std::array::from_fn(|i| position[i].wrapping_add(step[i]));
}
    // rust: position = std::array::from_fn(|i| position[i].wrapping_sub(step[i]));
    // rust: if let Some(cap) = cap {
    // rust: cap.place_in(&mut placer, world, random, position, run)?;
}
    // rust: Ok(true)
}
    // rust: Self::BlockColumn(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::BlockColumn),
    // rust: Self::SimpleBlock(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::SimpleBlock),
    // rust: Self::ScatteredOre(feature) => feature
    // rust: .place(world, random, origin)
    // rust: .map_err(FeatureExecutionError::Basic),
    // rust: Self::Ore(feature) => feature.place(world, random, origin),
    // rust: Self::VegetationPatch(feature) => {
    // rust: feature.place(world, random, origin, &mut |f, w, r, p| {
    // rust: f.place_in(&mut placer, w, r, p, run)
    // rust: })
}
    // rust: Self::Coral(feature) => feature.place(world, random, origin, &mut |f, w, r, p| {
    // rust: f.place_in(&mut placer, w, r, p, run)
    // rust: }),
    // rust: Self::HugeMushroom(feature) => feature.place(world, random, origin),
    // rust: Self::MultifaceGrowth(feature) => feature.place(world, random, origin),
    // rust: Self::Lake(feature) => feature.place(world, random, origin),
    // rust: Self::MonsterRoom(feature) => feature.place(world, random, origin),
    // rust: Self::Geode(feature) => feature.place(world, random, origin),
    // rust: Self::Iceberg(feature) => feature.place(world, random, origin),
    // rust: Self::SpeleothemCluster(feature) => feature.place(world, random, origin),
    // rust: Self::LargeDripstone(feature) => feature.place(world, random, origin),
    // rust: Self::HugeFungus(feature) => feature.place(world, random, origin),
    // rust: Self::SculkPatch(feature) => feature.place(world, random, origin),
    // rust: Self::EndSpike(feature) => feature.place(world, random, origin),
    // rust: Self::ProjectedPatchySquare(feature) => feature.place(world, random, origin),
    // rust: Self::SteppedColumnCluster(feature) => feature.place(world, random, origin),
    // rust: Self::RootSystem(feature) => feature.place(world, random, origin, &mut |f, w, r, p| {
    // rust: f.place_in(&mut placer, w, r, p, run)
    // rust: }),
    // rust: Self::Tree(feature) => feature.place(world, random, origin, &mut |f, w, r, p| {
    // rust: f.place_inner(w, r, p, run)
    // rust: }),
    // rust: Self::FallenTree(feature) => feature.place(world, random, origin, &mut |f, w, r, p| {
    // rust: f.place_inner(w, r, p, run)
    // rust: }),
    // rust: Self::FillLayer(feature) => feature.place(world, origin).map_err(|e| match e {
    // rust: BlockFeatureError::World(e) => FeatureExecutionError::Basic(FeatureError::World(e)),
    // rust: BlockFeatureError::Query(e) => FeatureExecutionError::Query(e),
    // rust: }),
    // rust: Self::ReplaceBlock(feature) => {
    // rust: feature.place(world, random, origin).map_err(|e| match e {
    // rust: BlockFeatureError::World(e) => {
    // rust: FeatureExecutionError::Basic(FeatureError::World(e))
}
    // rust: BlockFeatureError::Query(e) => FeatureExecutionError::Query(e),
    // rust: })
}
    // rust: Self::WeightedChoice(features) => match features.sample(random)? {
    // rust: Some(feature) => feature.place_in(&mut placer, world, random, origin, run),
    // rust: None => Ok(false),
    // rust: },
    // rust: Self::Sequence(features) => {
    // rust: for feature in features {
    // rust: if !feature.place_in(&mut placer, world, random, origin, run)? {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
    // rust: Self::Overlay(features) => {
    // rust: let mut any = false;
    // rust: for feature in features {
    // rust: any |= feature.place_in(&mut placer, world, random, origin, run)?;
}
    // rust: Ok(any)
}
    // rust: Self::BooleanChoice(features) => {
    // rust: let index = if random.next_boolean() { 0 } else { 1 };
    // rust: features[index].place_in(&mut placer, world, random, origin, run)
}
    // rust: Self::RandomChoice(features) => {
    // rust: let index = random.next_int_bound(features.len() as i32)? as usize;
    // rust: features[index].place_in(&mut placer, world, random, origin, run)
}
    // rust: Self::ChanceChoice { features, fallback } => {
    // rust: for (chance, feature) in features {
    // rust: if random.next_float() < *chance {
    // rust: return feature.place_in(&mut placer, world, random, origin, run);
}
}
    // rust: fallback.place_in(&mut placer, world, random, origin, run)
}
}
}
}
