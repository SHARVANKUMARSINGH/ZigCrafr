//! Transpiled from Horizon Rust crate
package horizon_prepare_survival

import "core:fmt"
import "core:mem"
import "core:math"

// Survival rules of the world generator's feature placement: each block's rule from the class
// vanilla gives it and the class of its placement check (tools/test_block_survival_parity.py's
// `bind_definitions` and its tables).

// use crate::pyjson::Value;

    // rust: const CLASS_RULES: &[(&str, &str)] = &[
    // rust: ("FireBlock", "Fire"),
    // rust: ("CactusBlock", "Cactus"),
    // rust: ("PathBlock", "Path"),
    // rust: ("MushroomBlock", "Mushroom"),
    // rust: ("MultifaceBlock", "Multiface"),
    // rust: ("VineBlock", "Vine"),
    // rust: ("HangingMossBlock", "HangingMoss"),
    // rust: ("SeaPickleBlock", "SeaPickle"),
    // rust: ("SnowLayerBlock", "SnowLayer"),
    // rust: ("BellBlock", "Bell"),
    // rust: ("ShelfMushroomBlock", "FullBehind"),
    // rust: ("GrowingPlantBlock", "GrowingPlant"),
    // rust: ("MangrovePropaguleBlock", "MangrovePropagule"),
    // rust: ("SpeleothemBlock", "Speleothem"),
    // rust: ("ScaffoldingBlock", "Scaffolding"),
    // rust: ("PistonHeadBlock", "PistonHead"),
    // rust: ("ChorusPlantBlock", "ChorusPlant"),
    // rust: ("ChorusFlowerBlock", "ChorusFlower"),
    // rust: ("PitcherCropBlock", "PitcherCrop"),
    // rust: ("BigDripleafBlock", "BigDripleaf"),
    // rust: ("BigDripleafStemBlock", "BigDripleafStem"),
    // rust: ("FarmlandBlock", "Farmland"),
    // rust: ("CocoaBlock", "Cocoa"),
    // rust: ("SugarCaneBlock", "SugarCane"),
    // rust: ("SporeBlossomBlock", "SporeBlossom"),
    // rust: ("FrogspawnBlock", "Frogspawn"),
    // rust: ("SmallDripleafBlock", "SmallDripleaf"),
    // rust: ("TallSeagrassBlock", "TallSeagrass"),
    // rust: ("DoorBlock", "Door"),
    // rust: ("BaseRailBlock", "RigidBelow"),
    // rust: ("LeafLitterBlock", "FullBelow"),
    // rust: ("WallSignBlock", "SolidBehind"),
    // rust: ("GrindstoneBlock", "Always"),
    // rust: ("RedstoneWallTorchBlock", "FullBehind"),
    // rust: ("BubbleColumnBlock", "BubbleColumn"),
    // rust: ("RedstoneWireBlock", "RedstoneWire"),
    // rust: ("SoulFireBlock", "TagBelow:minecraft:soul_fire_base_blocks"),
    // rust: ("BlockBehaviour", "Always"),
    // rust: ("CakeBlock", "SolidBelow"),
    // rust: ("CandleCakeBlock", "SolidBelow"),
    // rust: ("BannerBlock", "SolidBelow"),
    // rust: ("StandingSignBlock", "SolidBelow"),
    // rust: ("WallBannerBlock", "SolidBehind"),
    // rust: ("CarpetBlock", "NonAirBelow"),
    // rust: ("MossyCarpetBlock", "MossCarpet"),
    // rust: ("BaseTorchBlock", "CenterBelow"),
    // rust: ("CandleBlock", "CenterBelow"),
    // rust: ("LanternBlock", "Lantern"),
    // rust: ("HangingRootsBlock", "FullAbove"),
    // rust: ("LadderBlock", "FullBehind"),
    // rust: ("AmethystClusterBlock", "FullBehind"),
    // rust: ("TripWireHookBlock", "FullBehind"),
    // rust: ("BaseCoralWallFanBlock", "FullBehind"),
    // rust: ("WallTorchBlock", "FullBehind"),
    // rust: ("BasePressurePlateBlock", "RigidOrCenterBelow"),
    // rust: ("DiodeBlock", "RigidBelow"),
    // rust: ("BaseCoralPlantTypeBlock", "FullBelow"),
    // rust: ("CeilingHangingSignBlock", "CenterAbove"),
    // rust: ("FaceAttachedHorizontalDirectionalBlock", "FaceAttached"),
    // rust: ("BambooSaplingBlock", "SupportsBamboo"),
    // rust: ("BambooStalkBlock", "SupportsBamboo"),
    // rust: ];

    // rust: const VEGETATION_RULES: &[(&str, &str)] = &[
    // rust: ("LilyPadBlock", "LilyPad"),
    // rust: ("VegetationBlock", "TagBelow:minecraft:supports_vegetation"),
    // rust: ("AzaleaBlock", "TagBelow:minecraft:supports_azalea"),
    // rust: (
    // rust: "DryVegetationBlock",
    // rust: "TagBelow:minecraft:supports_dry_vegetation",
    // rust: ),
    // rust: (
    // rust: "NetherSproutsBlock",
    // rust: "TagBelow:minecraft:supports_nether_sprouts",
    // rust: ),
    // rust: ("NetherWartBlock", "TagBelow:minecraft:supports_nether_wart"),
    // rust: ("WitherRoseBlock", "TagBelow:minecraft:supports_wither_rose"),
    // rust: ("CactusFlowerBlock", "CactusFlower"),
    // rust: ("SeagrassBlock", "Seagrass"),
    // rust: ];

lookup :: proc(table: ^[(string) {
}
    // rust: table.iter().find(|(k, _)| *k == key).map(|(_, v)| *v)
}

// `{block: rule}` from the exporter's `{block: class}`, `{block: placement class}` and
// `{block: {field: support tag}}`, in the order Python's dict built it.
    // rust: pub fn bind_definitions(
    // rust: classes: &Value,
    // rust: placement: &Value,
    // rust: support_tags: &Value,
    // rust: ) -> Result<Value, String> {
    // rust: let classes = classes
    // rust: .as_object()
    // rust: .ok_or("survival-classes.json is not an object")?;
    // rust: let mut definitions = Value::Object(Vec::new());
    // rust: for (name, owner) in classes {
    // rust: if let Some(rule) = owner.as_str().and_then(|o| lookup(CLASS_RULES, o)) {
    // rust: definitions.insert(name, Value::str(rule));
}
}
    // rust: for (name, owner) in classes {
    // rust: let owner = owner.as_str().unwrap_or("");
    // rust: let placed = placement.get(name).and_then(Value::as_str);
    // rust: if owner == "CropBlock" && placed == Some("CropBlock") {
    // rust: definitions.insert(name, Value::str("Crop"));
}
    // rust: if owner == "DoublePlantBlock" && placed == Some("VegetationBlock") {
    // rust: definitions.insert(name, Value::str("DoublePlant"));
}
    // rust: if owner != "VegetationBlock" {
    // rust: continue;
}
    // rust: let method = placed.ok_or_else(|| format!("No placement class for {name}"))?;
    // rust: if let Some(rule) = lookup(VEGETATION_RULES, method) {
    // rust: definitions.insert(name, Value::str(rule));
    // rust: } else if [
    // rust: "AttachedStemBlock",
    // rust: "StemBlock",
    // rust: "NetherFungusBlock",
    // rust: "NetherRootsBlock",
    // rust: ]
    // rust: .contains(&method)
    // rust: {
    // rust: let field = if method == "StemBlock" {
    // rust: "stemSupportBlocks"
    // rust: } else {
    // rust: "supportBlocks"
}
    // rust: let tag = support_tags
    // rust: .get(name)
    // rust: .and_then(|t| t.get(field))
    // rust: .and_then(Value::as_str)
    // rust: .ok_or_else(|| format!("No {field} support tag for {name}"))?;
    // rust: definitions.insert(name, Value::Str(format!("TagBelow:{tag}")));
}
}
    // rust: Ok(definitions)
}
