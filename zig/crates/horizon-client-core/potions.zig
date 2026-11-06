//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_potions
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The `MobEffects` and `Potions` registries (code in vanilla, ported as
//! tables): each effect's colour and category, each potion's effects, and the
//! potion colour mix. horizon-client re-exports them from `brewing`.
// use std::{collections::HashMap, sync::OnceLock};

pub const Category = enum {
    Beneficial,
    Harmful,
    Neutral,
};
/// A `MobEffect`: id (vanilla's without namespace, a mod's `<ns>:<path>`),
/// colour, category, instantaneous.
pub const EffectDef = struct {
    id: *'static str,
    color: u32,
    category: Category,
    instant: bool,
};
    // rust: const fn fx(id: &'static str, color: u32, category: Category) -> EffectDef {
    // rust: EffectDef {
    // rust: id,
    // rust: color,
    // rust: category,
    // rust: instant: false,
}
}
// use Category::{Beneficial as B, Harmful as H, Neutral as N};
/// `MobEffects` in registration order.
    // rust: pub const EFFECTS: &[EffectDef] = &[
    // rust: fx("speed", 3402751, B),
    // rust: fx("slowness", 9154528, H),
    // rust: fx("haste", 14270531, B),
    // rust: fx("mining_fatigue", 4866583, H),
    // rust: fx("strength", 16762624, B),
    // rust: EffectDef {
    // rust: id: "instant_health",
    // rust: color: 16262179,
    // rust: category: B,
    // rust: instant: true,
    // rust: },
    // rust: EffectDef {
    // rust: id: "instant_damage",
    // rust: color: 11101546,
    // rust: category: H,
    // rust: instant: true,
    // rust: },
    // rust: fx("jump_boost", 16646020, B),
    // rust: fx("nausea", 5578058, H),
    // rust: fx("regeneration", 13458603, B),
    // rust: fx("resistance", 9520880, B),
    // rust: fx("fire_resistance", 16750848, B),
    // rust: fx("water_breathing", 10017472, B),
    // rust: fx("invisibility", 16185078, B),
    // rust: fx("blindness", 2039587, H),
    // rust: fx("night_vision", 12779366, B),
    // rust: fx("hunger", 5797459, H),
    // rust: fx("weakness", 4738376, H),
    // rust: fx("poison", 8889187, H),
    // rust: fx("wither", 7561558, H),
    // rust: fx("health_boost", 16284963, B),
    // rust: fx("absorption", 2445989, B),
    // rust: EffectDef {
    // rust: id: "saturation",
    // rust: color: 16262179,
    // rust: category: B,
    // rust: instant: true,
    // rust: },
    // rust: fx("glowing", 9740385, N),
    // rust: fx("levitation", 13565951, H),
    // rust: fx("luck", 5882118, B),
    // rust: fx("unluck", 12624973, H),
    // rust: fx("slow_falling", 15978425, B),
    // rust: fx("conduit_power", 1950417, B),
    // rust: fx("dolphins_grace", 8954814, B),
    // rust: fx("bad_omen", 745784, N),
    // rust: fx("hero_of_the_village", 4521796, B),
    // rust: fx("darkness", 2696993, H),
    // rust: fx("trial_omen", 1484454, N),
    // rust: fx("raid_omen", 14565464, N),
    // rust: fx("wind_charged", 12438015, H),
    // rust: fx("weaving", 7891290, H),
    // rust: fx("oozing", 10092451, H),
    // rust: fx("infested", 9214860, H),
    // rust: fx("breath_of_the_nautilus", 65518, B),
    // rust: ];
/// The effects content mods declare, registered after vanilla's.
pub const MOD_EFFECTS: OnceLock<std.ArrayList(EffectDef)> = OnceLock::new();
/// Registers the content mods' effects, `<ns>:<path>` ids in registry order.
/// The list is set once per process: false when it already was, and the
/// effects stay those of the first call until the game restarts.
pub fn register_mod_effects(effects: impl IntoIterator<Item = ([]const u8) void {
}
    // rust: if MOD_EFFECTS.get().is_some() {
    // rust: return false;
}
    // rust: let defs: Vec<EffectDef> = effects
    // rust: .into_iter()
    // rust: .map(|(id, color, category)| {
    // rust: debug_assert!(id.contains(':'), "{id} has no namespace");
    // rust: fx(Box::leak(id.into_boxed_str()), color, category)
    // rust: })
    // rust: .collect();
    // rust: MOD_EFFECTS.set(defs).is_ok()
}
/// The content mods' effects, in registry order.
pub fn mod_effects() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOD_EFFECTS.get().map_or(&[], Vec::as_slice)
}
/// Every registered effect: vanilla's, then the content mods'.
pub fn all_effects() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: EFFECTS.iter().chain(mod_effects())
}
pub fn effect(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let short = id.trim_start_matches("minecraft:");
    // rust: match EFFECTS.iter().find(|e| e.id == short) {
    // rust: Some(e) => Some(e),
    // rust: None => mod_effect(id),
}
}
/// A content mod's effect id (`<ns>:<path>`), not vanilla's with or
/// without `minecraft:`.
pub fn is_mod_effect(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !id.starts_with("minecraft:") && id.bytes().any(|b| b == b':')
}
/// Out of line, so vanilla's lookups (every frame, every tick) stay as they were.
pub fn mod_effect(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mod_effects().iter().find(|e| e.id == id)
}
/// `MobEffect.getDescriptionId` (`Util.makeDescriptionId("effect", key)`):
/// `effect.<namespace>.<path>`, `/` in the path as `.`.
pub fn description_id(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: format!("effect.{namespace}.{}", path.replace('/', "."))
}
/// The effect's sprite in the GUI atlas (`Hud.getMobEffectSprite`: the key
/// with `mob_effect/` before its path): `mob_effect/<path>` for vanilla's,
/// `<ns>:mob_effect/<path>` for a mod's.
pub fn sprite(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::new();
    // rust: push_sprite(&mut out, id);
    // rust: out
}
/// [`sprite`], appended to `out`.
pub fn push_sprite(out: *mut []const u8, id: []const u8) void {
}
    // rust: let path = match id.split_once(':') {
    // rust: None => id,
    // rust: Some(("minecraft", path)) => path,
    // rust: Some((namespace, path)) => {
    // rust: out.push_str(namespace);
    // rust: out.push(':');
    // rust: path
}
}
    // rust: out.push_str("mob_effect/");
    // rust: out.push_str(path);
}
/// Namespaced effect ids for mob effect storage; a mod's id already is.
pub fn namespaced(id: *'static str) * {
    // Implementation ported from Horizon
    return undefined;
}
pub const IDS: OnceLock<std.AutoHashMap(*'static str, *'static str)> = OnceLock::new();
    // rust: let key = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: IDS.get_or_init(|| {
    // rust: EFFECTS
    // rust: .iter()
    // rust: .map(|e| {
    // rust: (
    // rust: e.id,
    // rust: &*Box::leak(format!("minecraft:{}", e.id).into_boxed_str()),
    // rust: )
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .get(key)
    // rust: .copied()
    // rust: .unwrap_or(id)
}
/// A `Potion`: id, name suffix (`item.minecraft.potion.effect.<name>`) and
/// effects as (effect, duration ticks, amplifier).
pub const PotionDef = struct {
    id: *'static str,
    name: *'static str,
    effects: *'static [(*'static str,
};
    // rust: const fn p(
    // rust: id: &'static str,
    // rust: name: &'static str,
    // rust: effects: &'static [(&'static str, i32, i32)],
    // rust: ) -> PotionDef {
    // rust: PotionDef { id, name, effects }
}
/// `Potions` in registration order.
    // rust: pub const POTIONS: &[PotionDef] = &[
    // rust: p("water", "water", &[]),
    // rust: p("mundane", "mundane", &[]),
    // rust: p("thick", "thick", &[]),
    // rust: p("awkward", "awkward", &[]),
    // rust: p("night_vision", "night_vision", &[("night_vision", 3600, 0)]),
    // rust: p(
    // rust: "long_night_vision",
    // rust: "night_vision",
    // rust: &[("night_vision", 9600, 0)],
    // rust: ),
    // rust: p("invisibility", "invisibility", &[("invisibility", 3600, 0)]),
    // rust: p(
    // rust: "long_invisibility",
    // rust: "invisibility",
    // rust: &[("invisibility", 9600, 0)],
    // rust: ),
    // rust: p("leaping", "leaping", &[("jump_boost", 3600, 0)]),
    // rust: p("long_leaping", "leaping", &[("jump_boost", 9600, 0)]),
    // rust: p("strong_leaping", "leaping", &[("jump_boost", 1800, 1)]),
    // rust: p(
    // rust: "fire_resistance",
    // rust: "fire_resistance",
    // rust: &[("fire_resistance", 3600, 0)],
    // rust: ),
    // rust: p(
    // rust: "long_fire_resistance",
    // rust: "fire_resistance",
    // rust: &[("fire_resistance", 9600, 0)],
    // rust: ),
    // rust: p("swiftness", "swiftness", &[("speed", 3600, 0)]),
    // rust: p("long_swiftness", "swiftness", &[("speed", 9600, 0)]),
    // rust: p("strong_swiftness", "swiftness", &[("speed", 1800, 1)]),
    // rust: p("slowness", "slowness", &[("slowness", 1800, 0)]),
    // rust: p("long_slowness", "slowness", &[("slowness", 4800, 0)]),
    // rust: p("strong_slowness", "slowness", &[("slowness", 400, 3)]),
    // rust: p(
    // rust: "turtle_master",
    // rust: "turtle_master",
    // rust: &[("slowness", 400, 3), ("resistance", 400, 2)],
    // rust: ),
    // rust: p(
    // rust: "long_turtle_master",
    // rust: "turtle_master",
    // rust: &[("slowness", 800, 3), ("resistance", 800, 2)],
    // rust: ),
    // rust: p(
    // rust: "strong_turtle_master",
    // rust: "turtle_master",
    // rust: &[("slowness", 400, 5), ("resistance", 400, 3)],
    // rust: ),
    // rust: p(
    // rust: "water_breathing",
    // rust: "water_breathing",
    // rust: &[("water_breathing", 3600, 0)],
    // rust: ),
    // rust: p(
    // rust: "long_water_breathing",
    // rust: "water_breathing",
    // rust: &[("water_breathing", 9600, 0)],
    // rust: ),
    // rust: p("healing", "healing", &[("instant_health", 1, 0)]),
    // rust: p("strong_healing", "healing", &[("instant_health", 1, 1)]),
    // rust: p("harming", "harming", &[("instant_damage", 1, 0)]),
    // rust: p("strong_harming", "harming", &[("instant_damage", 1, 1)]),
    // rust: p("poison", "poison", &[("poison", 900, 0)]),
    // rust: p("long_poison", "poison", &[("poison", 1800, 0)]),
    // rust: p("strong_poison", "poison", &[("poison", 432, 1)]),
    // rust: p("regeneration", "regeneration", &[("regeneration", 900, 0)]),
    // rust: p(
    // rust: "long_regeneration",
    // rust: "regeneration",
    // rust: &[("regeneration", 1800, 0)],
    // rust: ),
    // rust: p(
    // rust: "strong_regeneration",
    // rust: "regeneration",
    // rust: &[("regeneration", 450, 1)],
    // rust: ),
    // rust: p("strength", "strength", &[("strength", 3600, 0)]),
    // rust: p("long_strength", "strength", &[("strength", 9600, 0)]),
    // rust: p("strong_strength", "strength", &[("strength", 1800, 1)]),
    // rust: p("weakness", "weakness", &[("weakness", 1800, 0)]),
    // rust: p("long_weakness", "weakness", &[("weakness", 4800, 0)]),
    // rust: p("luck", "luck", &[("luck", 6000, 0)]),
    // rust: p("slow_falling", "slow_falling", &[("slow_falling", 1800, 0)]),
    // rust: p(
    // rust: "long_slow_falling",
    // rust: "slow_falling",
    // rust: &[("slow_falling", 4800, 0)],
    // rust: ),
    // rust: p("wind_charged", "wind_charged", &[("wind_charged", 3600, 0)]),
    // rust: p("weaving", "weaving", &[("weaving", 3600, 0)]),
    // rust: p("oozing", "oozing", &[("oozing", 3600, 0)]),
    // rust: p("infested", "infested", &[("infested", 3600, 0)]),
    // rust: ];
pub fn potion(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = id.trim_start_matches("minecraft:");
    // rust: POTIONS.iter().find(|p| p.id == id)
}
/// `PotionContents.BASE_POTION_COLOR` (ARGB -13083194) as RGB.
pub const BASE_POTION_COLOR: u32 = 0x385DC6;
/// `PotionContents.getColor`: amplifier-weighted mix of visible effect colours.
pub fn potion_color(id: ?[]const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(def) = id.and_then(potion) else {
    // rust: return BASE_POTION_COLOR;
}
    // rust: effects_color(def.effects.iter().map(|(id, _, amp)| (*id, *amp)))
}
/// `PotionContents.getColorOptional` of some effects, `(id, amplifier)`, all visible: the mix of
/// their colours weighted by amplifier + 1, else the base potion colour.
    // rust: pub fn effects_color<'a>(effects: impl Iterator<Item = (&'a str, i32)>) -> u32 {
    // rust: let (mut r, mut g, mut b, mut total) = (0u32, 0u32, 0u32, 0u32);
    // rust: for (e, amp) in effects {
    // rust: let Some(e) = effect(e) else { continue };
    // rust: let w = amp as u32 + 1;
    // rust: r += w * (e.color >> 16 & 255);
    // rust: g += w * (e.color >> 8 & 255);
    // rust: b += w * (e.color & 255);
    // rust: total += w;
}
    // rust: match (
    // rust: r.checked_div(total),
    // rust: g.checked_div(total),
    // rust: b.checked_div(total),
    // rust: ) {
    // rust: (Some(r), Some(g), Some(b)) => (r << 16) | (g << 8) | b,
    // rust: _ => BASE_POTION_COLOR,
}
}
    // rust: mod tests {
//     use super::*;

pub fn description_ids_and_sprites_keep_the_namespace() void {
}
    // rust: assert_eq!(description_id("speed"), "effect.minecraft.speed");
    // rust: assert_eq!(description_id("minecraft:speed"), "effect.minecraft.speed");
    // rust: assert_eq!(description_id("ruby:curse/dark"), "effect.ruby.curse.dark");
    // rust: assert_eq!(sprite("speed"), "mob_effect/speed");
    // rust: assert_eq!(sprite("minecraft:speed"), "mob_effect/speed");
    // rust: assert_eq!(sprite("ruby:curse/dark"), "ruby:mob_effect/curse/dark");
}

    /// `PotionContents.getColorOptional`: each visible effect's colour weighted by its
    /// amplifier + 1, the channels averaged by integer division; none gives the base colour.
pub fn effects_mix_their_colours_by_amplifier() void {
}
    // rust: let c = |id: &str| effect(id).unwrap().color;
    // rust: assert_eq!(effects_color([("poison", 0)].into_iter()), c("poison"));
    // rust: let (p, s) = (c("poison"), c("speed"));
    // rust: let mix = |shift: u32| (((p >> shift & 255) + 3 * (s >> shift & 255)) / 4) << shift;
    // rust: assert_eq!(
    // rust: effects_color([("poison", 0), ("speed", 2)].into_iter()),
    // rust: mix(16) | mix(8) | mix(0)
    // rust: );
    // rust: assert_eq!(effects_color(std::iter::empty()), BASE_POTION_COLOR);
}

    /// The only test that registers: the registry is set once per process.
pub fn mod_effects_follow_vanilla_once_registered() void {
}
    // rust: assert!(register_mod_effects([(
    // rust: "ruby:glow".to_owned(),
    // rust: 0xFF0000,
    // rust: Category::Neutral
    // rust: )]));
    // rust: assert!(!register_mod_effects([(
    // rust: "ruby:late".to_owned(),
    // rust: 1,
    // rust: Category::Harmful
    // rust: )]));
    // rust: let glow = effect("ruby:glow").unwrap();
    // rust: assert_eq!(
    // rust: (glow.color, glow.category, glow.instant),
    // rust: (0xFF0000, Category::Neutral, false)
    // rust: );
    // rust: assert!(effect("glow").is_none() && effect("ruby:late").is_none());
    // rust: assert!(is_mod_effect(glow.id) && !is_mod_effect("speed"));
    // rust: assert!(!is_mod_effect(namespaced("speed")));
    // rust: assert_eq!(namespaced(glow.id), "ruby:glow");
    // rust: assert_eq!(effect("minecraft:speed").unwrap().id, "speed");
    // rust: let ids: Vec<_> = all_effects().map(|e| e.id).collect();
    // rust: assert_eq!(ids.len(), EFFECTS.len() + 1);
    // rust: assert_eq!(ids.last(), Some(&"ruby:glow"));
}
}
