//! Transpiled from Horizon Rust crate
package horizon_client_render_cit_glint

import "core:fmt"
import "core:mem"
import "core:math"

// Custom Item Textures' enchantment glints (`type=enchantment`): which of a stack's matching
// rules draw, in which order and how strongly, and whether vanilla's glint still draws under
// them. The pack's `cit.properties` (`Global`) says how layers share an item.
//
// Written from OptiFine's `cit.properties` doc and CIT Resewn's (MIT) `TypeEnchantment` of
// before its 1.21.11 port, which implemented `method`, `cap` and `fade`: the sums and the
// cycle's fading follow it, except where noted.

    // rust: pub use horizon_optifine::cit::{Global, Method};

// use crate::cit::read_properties;
// use horizon_optifine::cit::Rule;
// use std::path::Path;

// The pack's global `cit.properties` under the overlay resource root: the first of
// `Global::PATHS` that exists, else the defaults.
load_global :: proc(root: ^Path) -> G {
    // Ported from Horizon
    return {}
}
    // rust: Global::PATHS
    // rust: .iter()
    // rust: .find_map(|path| read_properties(&root.join(path)))
    // rust: .map(|props| Global::parse(&props))
    // rust: .unwrap_or_default()
}

// One glint layer a stack draws.
GlintLayer :: struct {
    // The rule, an index into `CitRules::rules`.
    rule: uint,
    // Its `average` or `layered` share, 1 under `none` and `cycle`.
    weight: f32,
    // Its `duration`, for `cycle`.
    duration: f32,
}

// What a stack's glint is made of, worked out when the stack changes.
StackGlint :: struct {
    // Bottom first (`layer` ascending).
    layers: [dynamic]GlintLayer,
    // Whether vanilla's glint draws (on a stack that has one) under the layers.
    vanilla: bool,
    // `fade` when the layers take turns (`method=cycle`).
    cycle_fade: Maybe(f32),
}

    // rust: impl StackGlint {
    // The layers among `matched` (the stack's matching enchantment rules, in priority order,
    // as `CitRules::enchantments` gives them) that draw, for a stack with `enchantments`
    // (`ItemStack::crafting_enchantments`).
    // rust: pub fn new(
    // rust: rules: &[Rule],
    // rust: matched: &[usize],
    // rust: enchantments: &[(impl AsRef<str>, u32)],
    // rust: global: &Global,
    // rust: ) -> Self {
        // The highest priority rule of each layer.
    // rust: let mut layers: Vec<usize> = Vec::new();
    // rust: for &i in matched {
    // rust: let layer = rules[i].glint.layer;
    // rust: if !layers.iter().any(|&j| rules[j].glint.layer == layer) {
    // rust: layers.push(i);
}
}
    // rust: layers.sort_by_key(|&i| rules[i].glint.layer);
    // rust: let cycle = global.method == Method::Cycle;
        // OptiFine's doc: `cap` is for `average` and `layered`, and keeps the topmost layers.
        // `none`, which OptiFine lacks, is capped too, as CIT Resewn caps every method (it keeps
        // the bottom layers, though, and caps cycles as well).
    // rust: if let Some(cap) = global.cap.filter(|_| !cycle) {
    // rust: let cap = usize::try_from(cap).unwrap_or(usize::MAX);
    // rust: layers = layers.split_off(layers.len().saturating_sub(cap));
}
        // CIT Resewn: any layer left asking for vanilla's glint keeps it, and the global
        // `useGlint=false` removes it everywhere, as OptiFine's doc says too. `cap=0` leaves no
        // custom layer, and vanilla's glint only if the pack's `useGlint` allows it.
    // rust: let vanilla = global.use_glint
    // rust: && (layers.is_empty() || layers.iter().any(|&i| rules[i].glint.use_glint));
        // CIT Resewn: shares are against every enchantment of the stack, not only those the
        // layers name.
    // rust: let levels = enchantments.iter().map(|(_, level)| *level as f32);
    // rust: let total = match global.method {
    // rust: Method::Average => levels.sum::<f32>(),
    // rust: Method::Layered => levels.fold(0.0, f32::max),
    // rust: Method::None | Method::Cycle => 0.0,
}
    // rust: let shared = matches!(global.method, Method::Average | Method::Layered);
    // rust: let layers = layers
    // rust: .into_iter()
    // rust: .map(|i| {
    // rust: let rule = &rules[i];
    // rust: let named = &rule.enchantments;
    // rust: let weight = if !shared || named.is_empty() {
    // rust: 1.0
    // rust: } else {
                    // The highest level among the enchantments the rule names whose level also
                    // passes its `enchantmentLevels` (CIT Resewn takes the first named one the
                    // stack has, whatever its level).
    // rust: let in_range = |level: u32| {
    // rust: let level = i32::try_from(level).unwrap_or(i32::MAX);
    // rust: rule.enchantment_levels
    // rust: .as_ref()
    // rust: .is_none_or(|r| r.contains(level))
}
    // rust: let level = enchantments
    // rust: .iter()
    // rust: .filter(|(id, level)| {
    // rust: let id: &str = id.as_ref();
    // rust: named.iter().any(|n| n == id) && in_range(*level)
    // rust: })
    // rust: .map(|(_, level)| *level as f32)
    // rust: .fold(0.0, f32::max);
    // rust: if total > 0.0 { level / total } else { 0.0 }
}
    // rust: GlintLayer {
    // rust: rule: i,
    // rust: weight,
    // rust: duration: rule.glint.duration,
}
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: layers,
    // rust: vanilla,
    // rust: cycle_fade: cycle.then_some(global.fade),
}
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.is_empty()
}

    // Layer `index`'s intensity `seconds` into the game: its weight, and under `method=cycle`
    // its turn.
intensity :: proc(self: ^Self, index: uint, seconds: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let layer = self.layers[index];
    // rust: match self.cycle_fade {
    // rust: None => layer.weight,
    // rust: Some(fade) => cycle_intensity(&self.layers, fade, index, seconds),
}
}
}

// CIT Resewn's `Loops.statelessFadingLoop`: each layer shows alone for its `duration`, then
// fades into the next over `fade` seconds, the last into the first. With no time at all
// (every `duration` and `fade` 0) the bottom layer shows alone.
cycle_intensity :: proc(layers: ^[GlintLayer], fade: f32, index: uint, seconds: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let n = layers.len();
    // rust: let fade = f64::from(fade);
    // rust: let period: f64 = layers.iter().map(|l| f64::from(l.duration) + fade).sum();
    // rust: if n == 1 || period <= 0.0 {
    // rust: return if index == 0 { 1.0 } else { 0.0 };
}
    // rust: let mut t = seconds.rem_euclid(period);
    // rust: for (i, layer) in layers.iter().enumerate() {
    // rust: let duration = f64::from(layer.duration);
    // rust: if t < duration {
    // rust: return if i == index { 1.0 } else { 0.0 };
}
    // rust: t -= duration;
        // Defensive: the last fade also takes anything rounding might leave of the period
        // (none seen), ending fully on the first layer.
    // rust: if t < fade || i + 1 == n {
    // rust: let into = if fade > 0.0 {
    // rust: (t / fade).min(1.0) as f32
    // rust: } else {
    // rust: 1.0
}
    // rust: return if i == index {
    // rust: 1.0 - into
    // rust: } else if (i + 1) % n == index {
    // rust: into
    // rust: } else {
    // rust: 0.0
}
}
    // rust: t -= fade;
}
    // Not reached, as the last layer returns above; no layer rather than a panic.
    // rust: 0.0
}

    // rust: mod tests {
//     use super::*;
//     use horizon_optifine::Properties;

DIR :: "assets/minecraft/optifine/cit"

    // An enchantment rule named `name` with `text` after `type` and `texture`.
rule :: proc(name: string, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = format!("type=enchantment\ntexture=glint\n{text}");
    // rust: let path = format!("{DIR}/{name}.properties");
    // rust: Rule::parse(&path, &Properties::parse_equals_first(&text), |_| true).unwrap()
}

global :: proc(text: string) -> G {
    // Ported from Horizon
    return {}
}
    // rust: Global::parse(&Properties::parse_equals_first(text))
}

rules_of :: proc(layers: ^StackGlint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: layers.layers.iter().map(|l| l.rule).collect()
}

SWORD :: [("minecraft:sharpness", 3), ("minecraft:unbreaking", 1)]

one_rule_per_layer_bottom_first :: proc() {
}
    // rust: let rules = [
    // rust: rule("a", "layer=2"),
    // rust: rule("b", "layer=0"),
    // rust: rule("c", "layer=2"),
    // rust: rule("d", "layer=-1"),
    // rust: ];
        // Priority order a, b, c, d: c loses layer 2 to a.
    // rust: let g = StackGlint::new(&rules, &[0, 1, 2, 3], &SWORD, &Global::default());
    // rust: assert_eq!(rules_of(&g), [3, 1, 0]);
    // rust: let g = StackGlint::new(&rules, &[2, 0], &SWORD, &Global::default());
    // rust: assert_eq!(rules_of(&g), [2]);
}

average_and_layered_shares :: proc() {
}
    // rust: let rules = [
    // rust: rule("sharp", "enchantments=sharpness smite"),
    // rust: rule("unb", "layer=1\nenchantments=unbreaking"),
    // rust: rule("any", "layer=2"),
    // rust: rule("fire", "layer=3\nenchantments=fire_aspect"),
    // rust: ];
    // rust: let weights = |method: &str| {
    // rust: let g = StackGlint::new(&rules, &[0, 1, 2, 3], &SWORD, &global(method));
    // rust: g.layers.iter().map(|l| l.weight).collect::<Vec<_>>()
}
        // Sharpness III and Unbreaking I: 3 / 4 and 1 / 4; against the highest, 3 / 3 and 1 / 3.
        // A rule naming no enchantment is at full strength, one the stack lacks at none.
    // rust: assert_eq!(weights("method=average"), [0.75, 0.25, 1.0, 0.0]);
    // rust: assert_eq!(weights("method=layered"), [1.0, 1.0 / 3.0, 1.0, 0.0]);
    // rust: assert_eq!(weights("method=cycle"), [1.0; 4]);
    // rust: assert_eq!(weights("method=none"), [1.0; 4]);
}

the_level_is_one_the_rules_levels_allow :: proc() {
}
    // rust: let rules = [rule(
    // rust: "holy",
    // rust: "enchantments=sharpness smite\nenchantmentLevels=1-2",
    // rust: )];
        // Sharpness V is out of range, so Smite I sets the share: 1 / 5 of the highest level.
    // rust: let stack = [("minecraft:sharpness", 5), ("minecraft:smite", 1)];
    // rust: let g = StackGlint::new(&rules, &[0], &stack, &global("method=layered"));
    // rust: assert_eq!(g.layers[0].weight, 1.0 / 5.0);
}

cap_keeps_the_topmost_layers :: proc() {
}
    // rust: let rules = [
    // rust: rule("a", "layer=0"),
    // rust: rule("b", "layer=1"),
    // rust: rule("c", "layer=2"),
    // rust: ];
    // rust: let g = StackGlint::new(&rules, &[0, 1, 2], &SWORD, &global("cap=2"));
    // rust: assert_eq!(rules_of(&g), [1, 2]);
    // rust: let g = StackGlint::new(&rules, &[0, 1, 2], &SWORD, &global("cap=0"));
    // rust: assert!(g.is_empty());
    // rust: let g = StackGlint::new(&rules, &[0, 1, 2], &SWORD, &global("cap=1\nmethod=none"));
    // rust: assert_eq!(rules_of(&g), [2]);
        // Cycles show every layer in turn.
    // rust: let g = StackGlint::new(&rules, &[0, 1, 2], &SWORD, &global("cap=1\nmethod=cycle"));
    // rust: assert_eq!(rules_of(&g), [0, 1, 2]);
}

vanilla_glint :: proc() {
}
    // rust: let plain = rule("plain", "");
    // rust: let keep = rule("keep", "layer=1\nuseGlint=true");
    // rust: let rules = [plain, keep];
    // rust: let vanilla = |matched: &[usize], text: &str| {
    // rust: StackGlint::new(&rules, matched, &SWORD, &global(text)).vanilla
}
    // rust: assert!(vanilla(&[], ""), "no rule: vanilla's glint");
    // rust: assert!(!vanilla(&[0], ""), "a rule replaces it");
    // rust: assert!(vanilla(&[0, 1], ""), "unless one keeps it");
    // rust: assert!(!vanilla(&[], "useGlint=false"));
    // rust: assert!(!vanilla(&[1], "useGlint=false"), "the pack's word is final");
        // Only the layers `cap` keeps count.
    // rust: let rules = [rule("keep", "useGlint=true"), rule("top", "layer=1")];
    // rust: let g = StackGlint::new(&rules, &[0, 1], &SWORD, &global("cap=1"));
    // rust: assert!(!g.vanilla);
    // rust: let g = StackGlint::new(&rules, &[0, 1], &SWORD, &global("cap=0"));
    // rust: assert!(g.is_empty() && g.vanilla);
    // rust: let g = StackGlint::new(&rules, &[0, 1], &SWORD, &global("cap=0\nuseGlint=false"));
    // rust: assert!(!g.vanilla);
}

cycles_take_turns_and_fade :: proc() {
}
    // rust: let rules = [
    // rust: rule("a", "duration=2"),
    // rust: rule("b", "layer=1\nduration=1"),
    // rust: rule("c", "layer=2\nduration=1"),
    // rust: ];
    // rust: let g = StackGlint::new(
    // rust: &rules,
    // rust: &[0, 1, 2],
    // rust: &SWORD,
    // rust: &global("method=cycle\nfade=0.5"),
    // rust: );
        // a 0-2, a→b 2-2.5, b 2.5-3.5, b→c 3.5-4, c 4-5, c→a 5-5.5, then again.
    // rust: let at = |t: f64| [0, 1, 2].map(|i| g.intensity(i, t));
    // rust: assert_eq!(at(1.0), [1.0, 0.0, 0.0]);
    // rust: assert_eq!(at(2.125), [0.75, 0.25, 0.0]);
    // rust: assert_eq!(at(3.0), [0.0, 1.0, 0.0]);
    // rust: assert_eq!(at(3.75), [0.0, 0.5, 0.5]);
    // rust: assert_eq!(at(4.5), [0.0, 0.0, 1.0]);
    // rust: assert_eq!(at(5.25), [0.5, 0.0, 0.5]);
    // rust: assert_eq!(at(5.5 + 3.0), [0.0, 1.0, 0.0]);
        // One layer always shows.
    // rust: let one = StackGlint::new(&rules, &[1], &SWORD, &global("method=cycle"));
    // rust: assert_eq!(one.intensity(0, 0.7), 1.0);
}

a_cycle_always_shows_a_whole_layer :: proc() {
}
    // rust: let rules = [
    // rust: rule("a", "duration=0.1"),
    // rust: rule("b", "layer=1\nduration=0.7"),
    // rust: rule("c", "layer=2\nduration=0.2"),
    // rust: ];
    // rust: let g = StackGlint::new(
    // rust: &rules,
    // rust: &[0, 1, 2],
    // rust: &SWORD,
    // rust: &global("method=cycle\nfade=0.3"),
    // rust: );
        // Every millisecond of the first two seconds, and just under a period, the last fade's
        // end. (Rounding has not been seen to leave time past it; the last fade's clamp is
        // defensive.)
    // rust: let period: f64 = [0.1f32, 0.7, 0.2]
    // rust: .map(|d| f64::from(d) + f64::from(0.3f32))
    // rust: .iter()
    // rust: .sum();
    // rust: let last = f64::from_bits(period.to_bits() - 1);
    // rust: for t in (0..2000_i32)
    // rust: .map(|i| f64::from(i) * 0.001)
    // rust: .chain([last, period + last])
    // rust: {
    // rust: let sum: f32 = (0..3).map(|i| g.intensity(i, t)).sum();
    // rust: assert!((sum - 1.0).abs() < 1e-5, "{sum} at {t}");
}
        // No time at all: the bottom layer alone, never NaN.
    // rust: let still = [rule("a", "duration=0"), rule("b", "layer=1\nduration=0")];
    // rust: let g = StackGlint::new(&still, &[0, 1], &SWORD, &global("method=cycle\nfade=0"));
    // rust: for t in [0.0, 0.5, 7.25] {
    // rust: assert_eq!([0, 1].map(|i| g.intensity(i, t)), [1.0, 0.0]);
}
}

the_first_global_file_wins :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-cit-glint-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: assert_eq!(load_global(&root), Global::default());
    // rust: let write = |path: &str, text: &[u8]| {
    // rust: let file = root.join(path);
    // rust: std::fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: std::fs::write(file, text).unwrap();
}
        // Saved as Latin-1 (`é` is not UTF-8 alone), in the OptiFine doc's `cit/` folder.
    // rust: write(
    // rust: "assets/minecraft/optifine/cit/cit.properties",
    // rust: b"# caf\xE9\nmethod=cycle",
    // rust: );
    // rust: assert_eq!(load_global(&root).method, Method::Cycle);
    // rust: write("assets/minecraft/mcpatcher/cit.properties", b"method=none");
    // rust: assert_eq!(load_global(&root).method, Method::Cycle);
    // rust: write(
    // rust: "assets/minecraft/optifine/cit.properties",
    // rust: b"method=layered",
    // rust: );
    // rust: assert_eq!(load_global(&root).method, Method::Layered);
    // rust: write("assets/minecraft/citresewn/cit.properties", b"cap=1");
    // rust: let g = load_global(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: assert_eq!((g.method, g.cap), (Method::Average, Some(1)));
}
}
