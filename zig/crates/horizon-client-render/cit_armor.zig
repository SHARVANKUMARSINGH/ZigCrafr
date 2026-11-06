//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_cit_armor
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Custom Item Textures for worn armour and elytra (`type=armor`, `type=elytra`). An armour rule
//! names its textures after the armour texture files of before 1.21.2
//! (`textures/models/armor/diamond_layer_1.png`): `texture.diamond_layer_1`,
//! `texture.leather_layer_2_overlay`..., with `texture` for any layer it does not name. 26.3's
//! equipment assets name the same layers `entity/equipment/humanoid/diamond` (layer 1: helmet,
//! chestplate, boots) and `entity/equipment/humanoid_leggings/diamond` (layer 2), so the layers
//! are mapped back to the old names here. An elytra rule's `texture` replaces the wings'.

// use crate::cit_assets::{rule_sprites, sprite_id};
// use horizon_optifine::cit::{Kind, Rule};
// use std::collections::BTreeSet;

/// The pre-1.21.2 armour texture name of an equipment asset's layer: `asset` (`minecraft:gold`
/// or `gold`) on the leggings layer (`humanoid_leggings`) or the others (`humanoid`), the dye
/// overlay (`leather_overlay`) or the main texture.
pub fn armor_layer_name(asset: []const u8, leggings: bool, overlay: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = asset.rsplit_once(':').map_or(asset, |(_, p)| p);
    // The equipment assets renamed from their old textures; the rest kept their names.
    // rust: let old = match path {
    // rust: "turtle_scute" => "turtle",
    // rust: other => other,
}
    // rust: let layer = if leggings { 2 } else { 1 };
    // rust: let suffix = if overlay { "_overlay" } else { "" };
    // rust: format!("{old}_layer_{layer}{suffix}")
}

/// The texture (a resource path) `rule` draws on the layer named `layer`: its `texture.<layer>`,
/// else its `texture`.
    // rust: pub fn armor_texture<'a>(rule: &'a Rule, layer: &str) -> Option<&'a str> {
    // rust: rule.textures
    // rust: .iter()
    // rust: .find(|(name, _)| name == layer)
    // rust: .map(|(_, path)| path.as_str())
    // rust: .or(rule.texture.as_deref())
}

/// The atlas name of a CIT texture: its `cit_assets` id, without `minecraft:` as the atlas packs
/// vanilla's sprites.
pub fn atlas_name(resource: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = sprite_id(resource)?;
    // rust: Some(match id.strip_prefix("minecraft:") {
    // rust: Some(name) => name.to_owned(),
    // rust: None => id,
    // rust: })
}

/// The atlas sprite `rule` puts on the layer of equipment asset `asset` (see
/// [`armor_layer_name`]); `None` keeps the vanilla texture.
pub fn layer_sprite(rule: *Rule, asset: []const u8, leggings: bool, overlay: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: atlas_name(armor_texture(
    // rust: rule,
    // rust: &armor_layer_name(asset, leggings, overlay),
    // rust: )?)
}

/// The atlas sprite an elytra rule puts on the wings.
pub fn elytra_sprite(rule: *Rule) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: atlas_name(armor_texture(rule, "elytra")?)
}

/// The atlas sprite the one CIT armour rule `rule` puts on a worn armour layer: the layer
/// `vanilla` (an atlas name, `…_overlay` for the dye overlay) of equipment asset `asset` in
/// equipment layer `kind` (`humanoid_leggings` for the leggings). `None` draws `vanilla`, as does
/// a name the atlas lacks; nothing is allocated without a rule.
    // rust: pub fn worn_layer_sprite(
    // rust: rule: Option<&Rule>,
    // rust: asset: &str,
    // rust: kind: &str,
    // rust: vanilla: &str,
    // rust: ) -> Option<String> {
    // rust: let leggings = kind == "humanoid_leggings";
    // rust: let overlay = vanilla.ends_with("_overlay");
    // rust: layer_sprite(rule?, asset, leggings, overlay)
}

/// The CIT elytra rule's wings sprite. On `None`, or a name the atlas lacks, the caller draws the
/// cape, else the equipment asset's own wings.
pub fn wings_sprite(rule: ?*Rule) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: elytra_sprite(rule?)
}

/// What a worn layer draws, looked up with `get` (the atlas): the rule's sprite
/// ([`worn_layer_sprite`]), else `vanilla` when there is no rule or the atlas lacks its texture.
    // rust: pub fn worn_layer<R>(
    // rust: rule: Option<&Rule>,
    // rust: asset: &str,
    // rust: kind: &str,
    // rust: vanilla: &str,
    // rust: get: impl Fn(&str) -> Option<R>,
    // rust: ) -> Option<R> {
    // rust: worn_layer_sprite(rule, asset, kind, vanilla)
    // rust: .and_then(|name| get(&name))
    // rust: .or_else(|| get(vanilla))
}

/// What worn wings draw, looked up with `get`: the rule's sprite, else the cape; `None` leaves
/// them to the equipment asset's own wings.
    // rust: pub fn wings<R>(
    // rust: rule: Option<&Rule>,
    // rust: cape: Option<&str>,
    // rust: get: impl Fn(&str) -> Option<R>,
    // rust: ) -> Option<R> {
    // rust: wings_sprite(rule)
    // rust: .and_then(|name| get(&name))
    // rust: .or_else(|| cape.and_then(&get))
}

/// Sprite ids the armour and elytra rules draw (see [`rule_sprites`]).
pub fn armor_sprites(rules: *[Rule]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rule_sprites(rules, |kind| matches!(kind, Kind::Armor | Kind::Elytra))
}

    // rust: mod tests {
//     use super::*;
//     use horizon_optifine::Properties;

pub fn rule(path: []const u8, text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rule::parse(path, &Properties::parse_equals_first(text), |_| true).unwrap()
}

pub fn layers_take_their_old_texture_names() void {
}
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:diamond", false, false),
    // rust: "diamond_layer_1"
    // rust: );
    // rust: assert_eq!(armor_layer_name("diamond", true, false), "diamond_layer_2");
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:leather", false, true),
    // rust: "leather_layer_1_overlay"
    // rust: );
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:leather", true, true),
    // rust: "leather_layer_2_overlay"
    // rust: );
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:gold", false, false),
    // rust: "gold_layer_1"
    // rust: );
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:chainmail", true, false),
    // rust: "chainmail_layer_2"
    // rust: );
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:turtle_scute", false, false),
    // rust: "turtle_layer_1"
    // rust: );
    // rust: assert_eq!(
    // rust: armor_layer_name("minecraft:netherite", true, false),
    // rust: "netherite_layer_2"
    // rust: );
}

pub fn a_named_layer_wins_over_the_generic_texture() void {
}
    // rust: let r = rule(
    // rust: "assets/minecraft/optifine/cit/armor/blue.properties",
    // rust: "type=armor\nitems=diamond_chestplate diamond_leggings\ntexture=generic\n\
    // rust: texture.diamond_layer_2=blue_legs\n",
    // rust: );
    // rust: let dir = "assets/minecraft/optifine/cit/armor";
    // rust: assert_eq!(
    // rust: armor_texture(&r, "diamond_layer_2"),
    // rust: Some(format!("{dir}/blue_legs.png").as_str())
    // rust: );
    // rust: assert_eq!(
    // rust: armor_texture(&r, "diamond_layer_1"),
    // rust: Some(format!("{dir}/generic.png").as_str())
    // rust: );
    // rust: assert_eq!(
    // rust: layer_sprite(&r, "minecraft:diamond", true, false).as_deref(),
    // rust: Some("horizon_cit:minecraft/optifine/cit/armor/blue_legs")
    // rust: );
    // rust: assert_eq!(
    // rust: layer_sprite(&r, "minecraft:diamond", false, false).as_deref(),
    // rust: Some("horizon_cit:minecraft/optifine/cit/armor/generic")
    // rust: );
}

pub fn without_a_generic_texture_other_layers_stay_vanilla() void {
}
    // rust: let r = rule(
    // rust: "assets/minecraft/optifine/cit/a.properties",
    // rust: "type=armor\nitems=leather_helmet\ntexture.leather_layer_1=dyed\n",
    // rust: );
    // rust: assert_eq!(
    // rust: layer_sprite(&r, "minecraft:leather", false, false).as_deref(),
    // rust: Some("horizon_cit:minecraft/optifine/cit/dyed")
    // rust: );
    // rust: assert_eq!(layer_sprite(&r, "minecraft:leather", false, true), None);
    // rust: assert_eq!(layer_sprite(&r, "minecraft:leather", true, false), None);
}

pub fn a_vanilla_texture_path_keeps_its_atlas_name() void {
}
    // rust: let r = rule(
    // rust: "assets/minecraft/optifine/cit/wings.properties",
    // rust: "type=elytra\ntexture=minecraft:textures/entity/wings/dragon.png\n",
    // rust: );
    // rust: assert_eq!(elytra_sprite(&r).as_deref(), Some("entity/wings/dragon"));
}

pub fn worn_layers_pick_the_rules_texture_for_their_layer() void {
}
    // rust: let r = rule(
    // rust: "assets/minecraft/optifine/cit/dye.properties",
    // rust: "type=armor\nitems=leather_chestplate leather_leggings\n\
    // rust: texture.leather_layer_1=body\ntexture.leather_layer_1_overlay=body_dye\n\
    // rust: texture.leather_layer_2=legs\n",
    // rust: );
    // rust: let cit = |p: &str| Some(format!("horizon_cit:minecraft/optifine/cit/{p}"));
    // rust: let pick = |kind: &str, vanilla: &str| {
    // rust: worn_layer_sprite(Some(&r), "minecraft:leather", kind, vanilla)
}
    // rust: let body = "entity/equipment/humanoid/leather";
    // rust: assert_eq!(pick("humanoid", body), cit("body"));
    // rust: assert_eq!(
    // rust: pick("humanoid", "entity/equipment/humanoid/leather_overlay"),
    // rust: cit("body_dye")
    // rust: );
    // rust: assert_eq!(
    // rust: pick(
    // rust: "humanoid_leggings",
    // rust: "entity/equipment/humanoid_leggings/leather"
    // rust: ),
    // rust: cit("legs")
    // rust: );
        // No `texture.leather_layer_2_overlay` and no `texture`: the overlay stays vanilla.
    // rust: let legs_dye = "entity/equipment/humanoid_leggings/leather_overlay";
    // rust: assert_eq!(pick("humanoid_leggings", legs_dye), None);
        // No rule draws vanilla's.
    // rust: assert_eq!(
    // rust: worn_layer_sprite(None, "minecraft:leather", "humanoid", body),
    // rust: None
    // rust: );
}

pub fn wings_take_the_rules_texture() void {
}
    // rust: let r = rule(
    // rust: "assets/minecraft/optifine/cit/wings.properties",
    // rust: "type=elytra\ntexture=wings\n",
    // rust: );
    // rust: assert_eq!(
    // rust: wings_sprite(Some(&r)).as_deref(),
    // rust: Some("horizon_cit:minecraft/optifine/cit/wings")
    // rust: );
    // rust: assert_eq!(wings_sprite(None), None);
}

pub fn only_armor_and_elytra_rules_reach_the_atlas() void {
}
    // rust: let rules = [
    // rust: rule(
    // rust: "assets/minecraft/optifine/cit/sword.properties",
    // rust: "items=diamond_sword\ntexture=sword\n",
    // rust: ),
    // rust: rule(
    // rust: "assets/minecraft/optifine/cit/plate.properties",
    // rust: "type=armor\nitems=iron_chestplate iron_leggings\ntexture=plate\n\
    // rust: texture.iron_layer_2=legs\n",
    // rust: ),
    // rust: rule(
    // rust: "assets/minecraft/optifine/cit/wings.properties",
    // rust: "type=elytra\ntexture=wings\n",
    // rust: ),
    // rust: rule(
    // rust: "assets/minecraft/optifine/cit/glint.properties",
    // rust: "type=enchantment\nenchantments=sharpness\ntexture=glint\n",
    // rust: ),
    // rust: ];
    // rust: let got: Vec<String> = armor_sprites(&rules).into_iter().collect();
    // rust: assert_eq!(
    // rust: got,
    // rust: [
    // rust: "horizon_cit:minecraft/optifine/cit/legs",
    // rust: "horizon_cit:minecraft/optifine/cit/plate",
    // rust: "horizon_cit:minecraft/optifine/cit/wings",
    // rust: ]
    // rust: );
}

    /// An atlas lookup that knows `names`.
pub fn atlas(names: *[[]const u8]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names: Vec<String> = names.iter().map(|n| (*n).to_owned()).collect();
    // rust: move |s| names.iter().any(|n| n == s).then(|| s.to_owned())
}

pub fn the_atlas_lookup_falls_back_to_vanilla_and_the_cape() void {
}
    // rust: let iron = rule(
    // rust: "assets/minecraft/optifine/cit/iron.properties",
    // rust: "type=armor\nitems=iron_chestplate\ntexture.iron_layer_1=plate",
    // rust: );
    // rust: let plate = "horizon_cit:minecraft/optifine/cit/plate";
    // rust: let vanilla = "entity/equipment/humanoid/iron";
    // rust: let layer = |rule: Option<&Rule>, names: &[&str]| {
    // rust: worn_layer(rule, "minecraft:iron", "humanoid", vanilla, atlas(names))
}
    // rust: assert_eq!(
    // rust: layer(Some(&iron), &[plate, vanilla]).as_deref(),
    // rust: Some(plate)
    // rust: );
        // The rule's texture didn't reach the atlas, or there's no rule: vanilla's layer.
    // rust: assert_eq!(layer(Some(&iron), &[vanilla]).as_deref(), Some(vanilla));
    // rust: assert_eq!(layer(None, &[plate, vanilla]).as_deref(), Some(vanilla));
    // rust: let elytra = rule(
    // rust: "assets/minecraft/optifine/cit/w.properties",
    // rust: "type=elytra\ntexture=wings",
    // rust: );
    // rust: let w = "horizon_cit:minecraft/optifine/cit/wings";
    // rust: let wing = |rule: Option<&Rule>, names: &[&str]| wings(rule, Some("cape/x"), atlas(names));
    // rust: assert_eq!(wing(Some(&elytra), &[w, "cape/x"]).as_deref(), Some(w));
    // rust: assert_eq!(wing(Some(&elytra), &["cape/x"]).as_deref(), Some("cape/x"));
    // rust: assert_eq!(wings(None, None, atlas(&[w])), None);
}
}
