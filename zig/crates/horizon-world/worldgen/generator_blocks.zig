//! Transpiled from Horizon Rust crate
//! Module: horizon-world_generator_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Optional block-behavior registries used by feature placement: physical
//! properties, face support, collision and survival rules. Loaded from the
//! bundle's `blocks/` directory (Java-exported, see crates/horizon-prepare).
// use super::generator::GeneratorError;
// use crate::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: block_properties::BlockPropertiesRegistry,
    // rust: block_support::BlockSupportRegistry,
    // rust: block_survival::{BlockSurvivalRegistry, SurvivalDefinitions, SurvivalRule},
    // rust: collision::CachedCollisionRegistry,
    // rust: registry::{BlockRegistry, BlockTableFile},
}
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fs,
    // rust: path::Path,
    // rust: sync::Arc,
}

    // rust: pub(super) struct BlockBehavior {
    // rust: pub(super) properties: BlockPropertiesRegistry<'static>,
    // rust: pub(super) support: Arc<BlockSupportRegistry<'static>>,
    // rust: pub(super) collision: Arc<BlockCollisionRegistry<'static>>,
    // rust: pub(super) survival: BlockSurvivalRegistry<'static>,
    // rust: pub(super) double_plants: BTreeSet<String>,
    // rust: pub(super) mossy_carpets: BTreeSet<String>,
}
pub fn resource(message: impl Into<[]const u8>) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: GeneratorError::Resource(message.into())
}
pub fn rule(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use SurvivalRule::*;
    // rust: if let Some(tag) = name.strip_prefix("TagBelow:") {
    // rust: return Some(TagBelow(tag.to_owned()));
}
    // rust: Some(match name {
    // rust: "CactusFlower" => CactusFlower,
    // rust: "Seagrass" => Seagrass,
    // rust: "BubbleColumn" => BubbleColumn,
    // rust: "RedstoneWire" => RedstoneWire,
    // rust: "DoublePlant" => DoublePlant,
    // rust: "Door" => Door,
    // rust: "BigDripleaf" => BigDripleaf,
    // rust: "BigDripleafStem" => BigDripleafStem,
    // rust: "Farmland" => Farmland,
    // rust: "Cocoa" => Cocoa,
    // rust: "Crop" => Crop,
    // rust: "GrowingPlant" => GrowingPlant,
    // rust: "MangrovePropagule" => MangrovePropagule,
    // rust: "Speleothem" => Speleothem,
    // rust: "Scaffolding" => Scaffolding,
    // rust: "PistonHead" => PistonHead,
    // rust: "ChorusPlant" => ChorusPlant,
    // rust: "ChorusFlower" => ChorusFlower,
    // rust: "PitcherCrop" => PitcherCrop,
    // rust: "Multiface" => Multiface,
    // rust: "Vine" => Vine,
    // rust: "HangingMoss" => HangingMoss,
    // rust: "SnowLayer" => SnowLayer,
    // rust: "SeaPickle" => SeaPickle,
    // rust: "Fire" => Fire,
    // rust: "Cactus" => Cactus,
    // rust: "Path" => Path,
    // rust: "Mushroom" => Mushroom,
    // rust: "Bell" => Bell,
    // rust: "SugarCane" => SugarCane,
    // rust: "LilyPad" => LilyPad,
    // rust: "Frogspawn" => Frogspawn,
    // rust: "SporeBlossom" => SporeBlossom,
    // rust: "SmallDripleaf" => SmallDripleaf,
    // rust: "TallSeagrass" => TallSeagrass,
    // rust: "Always" => Always,
    // rust: "SolidBelow" => SolidBelow,
    // rust: "SolidBehind" => SolidBehind,
    // rust: "NonAirBelow" => NonAirBelow,
    // rust: "MossCarpet" => MossCarpet,
    // rust: "CenterBelow" => CenterBelow,
    // rust: "Lantern" => Lantern,
    // rust: "FullAbove" => FullAbove,
    // rust: "FullBehind" => FullBehind,
    // rust: "RigidOrCenterBelow" => RigidOrCenterBelow,
    // rust: "RigidBelow" => RigidBelow,
    // rust: "FullBelow" => FullBelow,
    // rust: "CenterAbove" => CenterAbove,
    // rust: "FaceAttached" => FaceAttached,
    // rust: "SupportsBamboo" => SupportsBamboo,
    // rust: _ => return None,
    // rust: })
}
    // rust: impl BlockBehavior {
    /// Files: `block-properties.nbt`, `cached-collision.nbt`,
    /// `cached-support.nbt`, `survival-rules.json`,
    /// `survival-extra-definitions.json` and `placement-definitions.json`.
    // rust: pub(super) fn load(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: fluid_tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Option<Self>, GeneratorError> {
    // rust: if !dir.join("block-properties.nbt").exists() {
    // rust: return Ok(None);
}
    // rust: let read = |name: &str| -> Result<BlockTableFile<'static>, GeneratorError> {
    // rust: BlockTableFile::open(&dir.join(name), registry)
    // rust: .map_err(|e| resource(format!("{name}: {e}")))
}
    // rust: let json = |name: &str| -> Result<Value, GeneratorError> {
    // rust: Ok(serde_json::from_str(&fs::read_to_string(dir.join(name))?)?)
}
        // The support table reads on its own thread while the collision and
        // property tables (which need the collisions) read on this one.
    // rust: let (collisions, properties, support) = std::thread::scope(|scope| {
    // rust: let support = scope.spawn(|| -> Result<_, GeneratorError> {
    // rust: Ok(BlockSupportRegistry::from_table(
    // rust: read("cached-support.nbt")?.table("support")?,
    // rust: )?)
    // rust: });
    // rust: let collisions = CachedCollisionRegistry::from_table(
    // rust: read("cached-collision.nbt")?.table("collision")?,
    // rust: )?;
    // rust: let properties = BlockPropertiesRegistry::from_table(
    // rust: read("block-properties.nbt")?.table("block property")?,
    // rust: &collisions,
    // rust: )?;
    // rust: let support = support
    // rust: .join()
    // rust: .unwrap_or_else(|panic| std::panic::resume_unwind(panic))?;
    // rust: Ok::<_, GeneratorError>((collisions, properties, Arc::new(support)))
    // rust: })?;
    // rust: let collision = Arc::new(BlockCollisionRegistry::new(Arc::new(collisions))?);
    // rust: let rules = json("survival-rules.json")?
    // rust: .as_object()
    // rust: .ok_or_else(|| resource("survival rules"))?
    // rust: .iter()
    // rust: .map(|(name, value)| {
    // rust: let text = value.as_str().unwrap_or_default();
    // rust: rule(text)
    // rust: .map(|rule| (name.clone(), rule))
    // rust: .ok_or_else(|| resource(format!("unknown survival rule {text}")))
    // rust: })
    // rust: .collect::<Result<_, _>>()?;
    // rust: let extra = json("survival-extra-definitions.json")?;
    // rust: let definitions = SurvivalDefinitions {
    // rust: rules,
    // rust: ignition_odds: serde_json::from_value(extra["ignition_odds"].clone())?,
    // rust: fence_gates: serde_json::from_value(extra["fence_gates"].clone())?,
}
    // rust: let survival = BlockSurvivalRegistry::new(
    // rust: registry,
    // rust: &properties,
    // rust: support.clone(),
    // rust: collision.clone(),
    // rust: &definitions,
    // rust: tags,
    // rust: fluid_tags,
    // rust: )?;
    // rust: let placement = json("placement-definitions.json")?;
    // rust: Ok(Some(Self {
    // rust: double_plants: serde_json::from_value(placement["double_plants"].clone())?,
    // rust: mossy_carpets: serde_json::from_value(placement["mossy_carpets"].clone())?,
    // rust: properties,
    // rust: support,
    // rust: collision,
    // rust: survival,
    // rust: }))
}
}
