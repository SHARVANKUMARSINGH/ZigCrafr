//! Transpiled from Horizon Rust crate
package horizon_client_cem

import "core:fmt"
import "core:mem"
import "core:math"

// OptiFine custom entity models over Horizon's mob model layers: `optifine/cem/<name>.jem` (or
// `cem/<name>/<name>.jem`, and Entity Model Features' `emf/cem/`, which wins) maps to one layer
// (`zombie.jem` to `zombie#main`, `sheep_wool.jem` to `sheep#wool`), its parts to the layer's
// vanilla parts, and its boxes join or replace theirs. A layer without its own model takes the
// one it falls back to: a baby's adult (OptiFine's fallbacks, and Entity Model Features' for
// horses too), and the few of [`FALLBACKS`], following their chains (`cat_baby_collar` to
// `cat_collar` to `cat`).
//
// Built when the packs load; a mob's draw only swaps the layer's part tree. Without CEM files
// nothing is built and every model stays vanilla's, and a file no layer uses isn't parsed.
//
// The seam with random entity textures (ETF): a `.jem`'s own `texture` replaces the layer's
// vanilla texture name, and the random texture lookup then gets that name. Variants without
// rules (`green2.png` beside `green.png`) follow it; a `.properties` with rules for it is not
// matched yet, because the random-texture picks are made for the vanilla names. That half
// belongs with random textures. The `.jem` texture paints the layer the file is for, not the overlays drawn on that layer's model (a wolf's
// collar, a spider's eyes, the cracks on a wolf's armour): those keep their textures over the
// new geometry.

// use super::{Mob, MobType, Part, Polygon, Species};
// use horizon_optifine::cem::{
    // rust: files::{atlas_name, jem_files, load_jem},
    // rust: model::{Bone, EntityModel, MAX_BYTES},
}
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: path::Path,
    // rust: sync::Arc,
}

// The CEM models of the enabled packs, by model layer (`zombie#main`).
CemModels :: struct {
    layers: HashMap<string,
}

// A model layer as a `.jem` reshapes it.
CemLayer :: struct {
    model: ^Part,
    // The `.jem`'s animations, run after the vanilla animation.
    animation: Maybe(super::cem_anim::Animation),
    // The atlas name of the `.jem`'s texture (`entity/zombie/zombie_green`), drawn instead of
    // the layer's vanilla texture.
    texture: Maybe(string),
    // The `attachments` the pack's bones declare, by the bone's `cem#<n>` name: the item
    // anchors a renderer looks up (`right_handheld_item`, `left_handheld_item`, `fox_item`).
    anchors: Vec<(string,
}

// How many fallbacks a chain follows (`cat_baby_collar`, `cat_collar`, `cat` takes two).
FALLBACK_STEPS :: 3

    // rust: impl CemModels {
    // The `.jem` files under `root` applied to the layers of `types`.
load :: proc(root: ^Path, types: ^HashMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let files = jem_files(root);
    // rust: if files.is_empty() {
    // rust: set_rule_species(Vec::new());
    // rust: return Self::default();
}
    // rust: let (models, standing) = Self::from_files(root, &files, &vanilla_layers(types));
    // rust: set_rule_species(standing);
    // rust: models
}

    // `files` ([`jem_files`]) applied to the `vanilla` layers; also the species ids whose
    // rules read the standing block, for the per-tick gate.
    // rust: fn from_files(
    // rust: root: &Path,
    // rust: files: &BTreeMap<String, Vec<String>>,
    // rust: vanilla: &HashMap<&str, (&Arc<Part>, &str)>,
    // rust: ) -> (Self, Vec<String>) {
        // Every model name a file can shape: the files' own, and the names that fall back to
        // them, a chain of fallbacks deep.
    // rust: let mut names: BTreeSet<String> = files.keys().cloned().collect();
    // rust: let mut frontier: Vec<String> = names.iter().cloned().collect();
    // rust: for _ in 0..FALLBACK_STEPS {
    // rust: frontier = frontier
    // rust: .iter()
    // rust: .flat_map(|name| fallback_names(name))
    // rust: .filter(|name| names.insert(name.clone()))
    // rust: .collect();
}
        // The files each layer may take, best first: the first that parses wins. Every name of
        // the layer's own file in name order, then the files its names fall back to, nearest
        // first. Two names of one layer (`llama_decor` and `trader_llama_decor` are both
        // `llama#decor`, `skeleton_horse_armor` and `zombie_horse_armor` both
        // `undead_horse_armor#main`) give it the first's, and the second's if the first is
        // broken; within one name, EMF's file before OptiFine's.
    // rust: let mut plan: HashMap<String, Vec<(usize, &str)>> = HashMap::new();
    // rust: for name in &names {
    // rust: let key = layer_key(name);
    // rust: if !vanilla.contains_key(key.as_str()) {
    // rust: continue;
}
    // rust: let chain = std::iter::successors(Some(name.clone()), |n| falls_back_to(n));
    // rust: let candidates = plan.entry(key).or_default();
    // rust: for (depth, target) in chain.take(FALLBACK_STEPS + 1).enumerate() {
    // rust: if let Some((file, _)) = files.get_key_value(&target) {
    // rust: candidates.push((depth, file.as_str()));
}
}
}
        // Each file parsed once, when a layer first tries it.
    // rust: let mut parsed: HashMap<&str, Option<EntityModel>> = HashMap::new();
    // rust: let mut layers = HashMap::new();
        // The species whose rules read the standing block, for the per-tick gate.
    // rust: let mut standing_species = Vec::new();
    // rust: for (key, mut candidates) in plan {
    // rust: candidates.sort_by_key(|&(depth, _)| depth);
    // rust: let found = candidates
    // rust: .iter()
    // rust: .flat_map(move |&(_, name)| {
    // rust: files[name].iter().map(move |path| (name, path.as_str()))
    // rust: })
    // rust: .find(|&(_, path)| {
    // rust: parsed
    // rust: .entry(path)
    // rust: .or_insert_with(|| load_jem(root, path))
    // rust: .is_some()
    // rust: });
    // rust: let Some((name, path)) = found else {
    // rust: continue;
}
    // rust: let Some(Some(jem)) = parsed.get(path) else {
    // rust: continue;
}
    // rust: let (part, kind) = vanilla[key.as_str()];
            // The random-model rules beside the `.jem` (same folder, same name) feed
            // `rule_index`: a grazing cow's `optifine/cem/cow.properties`.
    // rust: let rules = load_rules(root, path);
    // rust: if rules.iter().any(|r| !r.blocks.is_empty()) {
    // rust: standing_species.push(kind.to_owned());
}
    // rust: let mut layer = CemLayer::build(part, jem, name, &rules);
            // A fallback onto another layer (the cat's collar from `cat`) takes the geometry
            // only: the layer keeps its own texture.
    // rust: if layer_suffix(&key) != layer_suffix(&layer_key(name)) {
    // rust: layer.texture = None;
}
    // rust: layers.insert(key, layer);
}
    // rust: (Self { layers }, standing_species)
}

layer :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.get(key)
}
}

// Every model layer of `types` by its key, with its owner's id (`minecraft:cow` owns
// `cow#main` and `cold_cow#main` alike).
vanilla_layers :: proc(types: ^HashMap<string) -> H {
    // Ported from Horizon
    return {}
}
    // rust: types
    // rust: .values()
    // rust: .flat_map(|t| {
    // rust: t.layers
    // rust: .iter()
    // rust: .map(|(k, v)| (k.as_str(), (v, t.id.as_str())))
    // rust: })
    // rust: .collect()
}

// Replaces the species whose models carry `blocks.<n>` rules, as the packs change.
set_rule_species :: proc(species: [dynamic]string) {
}
    // rust: *RULE_SPECIES
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) = Some(species.into_iter().collect());
}

// A pack file's text, None when it's missing or larger than a model may read: its size is
// checked before anything is read.
read_small :: proc(path: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let len = std::fs::metadata(path).ok()?.len();
    // rust: if len > MAX_BYTES as u64 {
    // rust: return None;
}
    // rust: std::fs::read_to_string(path).ok()
}

// One `optifine/cem/<name>.properties` random-model rule: `models.<n>` selects the model
// variant (the base file, for Fresh Animations), `blocks.<n>` and `nbt.<n>.<key>` the
// conditions, all of which must hold for the rule's number to become the animations'
// `rule_index` — the highest matching one wins, 0 the unconditional base, as OptiFine
// numbers its rules. Fresh Animations' entries only carry conditions: a grazing cow, a
// bee on flowers, a sleeping villager, a snow golem sheared of its pumpkin.
Rule :: struct {
    index: u8,
    // `blocks.<n>`: the blocks (short ids) the mob may stand on.
    blocks: [dynamic]string,
    // `nbt.<n>.<key>=<value>` against the mob's facts.
    nbt: Vec<(string,
}

// The species whose model rules read the standing block (`blocks.<n>`): only their mobs
// pay the per-tick lookup, and none does without a pack of rules. Keyed like
// `MobType::id` (`minecraft:cow`), from the rule-carrying layers' owners.
    // rust: static RULE_SPECIES: std::sync::RwLock<Option<std::collections::HashSet<String>>> =
    // rust: std::sync::RwLock::new(None);

// Whether the species' models carry `blocks.<n>` rules, which read the block under the
// mob's feet each tick (the window's remote tick keeps `standing_on` fresh; the server, which
// draws nothing, never looks).
tracks_standing :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: RULE_SPECIES
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.contains(id))
}

// The random-model rules beside the `.jem` at `path` (`cow.properties` beside `cow.jem`),
// which the layer that file shapes reads for its `rule_index`.
load_rules :: proc(root: ^Path, path: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: path.strip_suffix(".jem")
    // rust: .and_then(|properties| read_small(&root.join(format!("{properties}.properties"))))
    // rust: .map(|text| parse_rules(&text))
    // rust: .unwrap_or_default()
}

// Parses one random-model `.properties` into its rules, lowest number first. `models.<n>`
// only marks the rule's presence (the base file serves every variant); `textures.<n>` and
// the like are the random-texture side's business and leave the rules alone.
    // rust: pub(super) fn parse_rules(text: &str) -> Vec<Rule> {
entry :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (k, v) = line.split_once('=')?;
    // rust: let mut parts = k.trim().split('.');
    // rust: let kind = parts.next()?;
    // rust: let index = parts.next()?.parse().ok()?;
    // rust: Some((kind, index, parts.next().unwrap_or(""), v.trim()))
}
    // rust: let mut rules: Vec<Rule> = Vec::new();
    // rust: for line in text.lines() {
    // rust: let Some((kind, index, rest, value)) = entry(line) else {
    // rust: continue;
}
    // rust: let rule = match rules.iter_mut().find(|r| r.index == index) {
    // rust: Some(r) => r,
    // rust: None => {
    // rust: rules.push(Rule {
    // rust: index,
    // rust: blocks: Vec::new(),
    // rust: nbt: Vec::new(),
    // rust: });
    // rust: rules.last_mut().expect("just pushed")
}
}
    // rust: match kind {
    // rust: "blocks" => rule.blocks = value.split_whitespace().map(str::to_owned).collect(),
    // rust: "nbt" => rule.nbt.push((rest.to_owned(), value.to_owned())),
    // rust: _ => {}
}
}
    // rust: rules.sort_by_key(|r| r.index);
    // rust: rules
}

// One `nbt.<n>.<key>=<value>` condition against the mob's facts: only the keys Horizon
// tracks answer (a villager's `sleeping_pos`, a bee's `HasNectar`, a snow golem's
// `Pumpkin`); the rest never matches, as in EMF a rule only matches on data it can read.
nbt_matches :: proc(key: string, value: string, sleeping: bool, nectar: bool, pumpkin: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match key {
    // rust: "sleeping_pos" => sleeping && value == "exists:true",
    // rust: "HasNectar" => nectar == (value != "0"),
        // Vanilla saves the snow golem's pumpkin-removed flag under the tag `Pumpkin`
        // (`Pumpkin: 1b` is a golem sheared of it), whose string form the pack's `raw:`
        // compares (ETF's NBTProperty `raw:` instruction).
    // rust: "Pumpkin" => match value {
    // rust: "raw:1b" => pumpkin,
    // rust: "raw:0b" => !pumpkin,
    // rust: _ => false,
    // rust: },
    // rust: _ => false,
}
}

// The rules' `rule_index` for one mob's facts: the highest rule whose conditions match —
// the standing block one of `blocks`' entries, every `nbt` condition holding — 0 when
// none does. A rule without conditions never matches: a plain model variant, not a state.
    // rust: fn matching_rule_index(
    // rust: rules: &[Rule],
    // rust: standing: Option<&str>,
    // rust: sleeping: bool,
    // rust: nectar: bool,
    // rust: pumpkin: bool,
    // rust: ) -> f32 {
    // rust: rules
    // rust: .iter()
    // rust: .filter(|r| !r.blocks.is_empty() || !r.nbt.is_empty())
    // rust: .filter(|r| {
    // rust: (r.blocks.is_empty()
    // rust: || standing.is_some_and(|s| {
    // rust: let s = s.strip_prefix("minecraft:").unwrap_or(s);
    // rust: r.blocks.iter().any(|b| b == s)
    // rust: }))
    // rust: && r.nbt
    // rust: .iter()
    // rust: .all(|(k, v)| nbt_matches(k, v, sleeping, nectar, pumpkin))
    // rust: })
    // rust: .map(|r| r.index)
    // rust: .max()
    // rust: .unwrap_or(0) as f32
}

// The random-model rules' number for `m`: the block under its feet, whether a villager
// sleeps, a bee carries nectar, a snow golem was sheared of its pumpkin — a grazing
// Fresh Animations cow reads 2.
rule_index :: proc(rules: ^[Rule], m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: matching_rule_index(
    // rust: rules,
    // rust: m.standing_on.as_deref(),
    // rust: super::villager::sleeping(m),
    // rust: super::bee::has_nectar(m),
    // rust: m.species() == Species::SnowGolem && m.extra.sheared,
    // rust: )
}

// The CEM model names with a layer key of their own; any other name `n` is `n#main`.
    // rust: const LAYERS: &[(&str, &str)] = &[
    // rust: ("sheep_wool", "sheep#wool"),
    // rust: ("creeper_charge", "creeper#armor"),
    // rust: ("slime_outer", "slime#outer"),
    // rust: ("drowned_outer", "drowned#outer"),
    // rust: ("stray_outer", "stray#outer"),
    // rust: ("bogged_outer", "bogged#outer"),
    // rust: ("wither_armor", "wither#armor"),
    // rust: ("breeze_wind", "breeze#wind"),
    // Horizon draws both llamas' decor on one layer, and both undead horses' armour.
    // rust: ("llama_decor", "llama#decor"),
    // rust: ("trader_llama_decor", "llama#decor"),
    // rust: ("cat_collar", "cat#collar"),
    // rust: ("pig_saddle", "pig#saddle"),
    // rust: ("strider_saddle", "strider#saddle"),
    // rust: ("nautilus_saddle", "nautilus#saddle"),
    // rust: ("tropical_fish_a", "tropical_fish_small#main"),
    // rust: ("tropical_fish_b", "tropical_fish_large#main"),
    // rust: ("tropical_fish_pattern_a", "tropical_fish_small#pattern"),
    // rust: ("tropical_fish_pattern_b", "tropical_fish_large#pattern"),
    // rust: ("puffer_fish_big", "pufferfish_big#main"),
    // rust: ("puffer_fish_medium", "pufferfish_medium#main"),
    // rust: ("puffer_fish_small", "pufferfish_small#main"),
    // rust: ("skeleton_horse_armor", "undead_horse_armor#main"),
    // rust: ("zombie_horse_armor", "undead_horse_armor#main"),
    // rust: ];

// The model layer a CEM model name reshapes.
layer_key :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // `<model>_baby[_<layer>]`: the adult's layer on the baby model.
    // rust: if let Some((base, rest)) = name.split_once("_baby") {
    // rust: let adult = layer_key(&format!("{base}{rest}"));
    // rust: let (model, layer) = adult.split_once('#').unwrap_or((&adult, "main"));
    // rust: return format!("{model}_baby#{layer}");
}
    // rust: match LAYERS.iter().find(|(n, _)| *n == name) {
    // rust: Some((_, key)) => (*key).to_owned(),
    // rust: None => format!("{name}#main"),
}
}

// The layer of a model layer key: `wool` of `sheep#wool`.
layer_suffix :: proc(key: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: key.split_once('#').map_or(key, |(_, layer)| layer)
}

// Models without a file of their own that take another's (OptiFine's and Entity Model
// Features' tables), besides the babies: (model, the model it takes).
    // rust: const FALLBACKS: &[(&str, &str)] = &[
    // rust: ("cat_collar", "cat"),
    // rust: ("player_slim", "player"),
    // rust: ("salmon_large", "salmon"),
    // rust: ("salmon_small", "salmon"),
    // rust: ];

// The model `name` takes when it has no file: [`FALLBACKS`], or a baby's adult (`sheep_wool`
// for `sheep_baby_wool`). The baby nautilus has none (OptiFine's and Entity Model Features'
// tables).
falls_back_to :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some((_, to)) = FALLBACKS.iter().find(|(from, _)| *from == name) {
    // rust: return Some((*to).to_owned());
}
    // rust: (name.contains("_baby") && !name.starts_with("nautilus_baby"))
    // rust: .then(|| name.replacen("_baby", "", 1))
}

// The model names that take `name`'s file when they have none ([`falls_back_to`] the other
// way): the babies of an adult and [`FALLBACKS`].
fallback_names :: proc(name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<String> = FALLBACKS
    // rust: .iter()
    // rust: .filter(|(_, to)| *to == name)
    // rust: .map(|(from, _)| (*from).to_owned())
    // rust: .collect();
    // rust: if !name.contains("_baby") {
    // rust: out.extend(baby_names(name).filter(|baby| !baby.starts_with("nautilus_baby")));
}
    // rust: out
}

// The baby model names that fall back to the adult `name`: `_baby` before any of its
// `_` words or at its end (`sheep_wool` gives `sheep_baby_wool`).
baby_names :: proc(name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let cuts = name.match_indices('_').map(|(i, _)| i).chain([name.len()]);
    // rust: cuts.map(move |i| format!("{}_baby{}", &name[..i], &name[i..]))
}

// The vanilla part an OptiFine part name of model `model` means. Names OptiFine kept from
// the game's own code map to themselves.
vanilla_part :: proc(model: string, part: string) -> S {
    // Ported from Horizon
    return {}
}
    // OptiFine numbers from 1, the game from 0.
    // rust: let n = |prefix: &str| -> Option<usize> {
    // rust: part.strip_prefix(prefix)?.parse().ok().filter(|i| *i >= 1)
}
    // rust: let quadruped = matches!(
    // rust: model,
    // rust: "cow"
    // rust: | "cold_cow"
    // rust: | "warm_cow"
    // rust: | "mooshroom"
    // rust: | "pig"
    // rust: | "cold_pig"
    // rust: | "warm_pig"
    // rust: | "pig_saddle"
    // rust: | "sheep"
    // rust: | "sheep_wool"
    // rust: | "polar_bear"
    // rust: | "panda"
    // rust: | "turtle"
    // rust: | "llama"
    // rust: | "llama_decor"
    // rust: | "trader_llama"
    // rust: | "trader_llama_decor"
    // rust: | "goat"
    // rust: | "fox"
    // rust: | "wolf"
    // rust: | "wolf_armor"
    // rust: | "wolf_collar"
    // rust: | "ravager"
    // rust: | "creeper"
    // rust: | "creeper_charge"
    // rust: | "axolotl"
    // rust: );
    // rust: const LEGS: [&str; 4] = [
    // rust: "right_hind_leg",
    // rust: "left_hind_leg",
    // rust: "right_front_leg",
    // rust: "left_front_leg",
    // rust: ];
    // rust: const SPIDER_LEGS: [&str; 8] = [
    // rust: "right_hind_leg",
    // rust: "left_hind_leg",
    // rust: "right_middle_hind_leg",
    // rust: "left_middle_hind_leg",
    // rust: "right_middle_front_leg",
    // rust: "left_middle_front_leg",
    // rust: "right_front_leg",
    // rust: "left_front_leg",
    // rust: ];
    // rust: let spider = matches!(model, "spider" | "cave_spider");
    // rust: let renamed: Option<String> = match (model, part) {
    // rust: (_, "headwear") => Some("hat".into()),
    // rust: (_, "back_left_leg") => Some("left_hind_leg".into()),
    // rust: (_, "back_right_leg") => Some("right_hind_leg".into()),
    // rust: (_, "front_left_leg") => Some("left_front_leg".into()),
    // rust: (_, "front_right_leg") => Some("right_front_leg".into()),
    // rust: (_, _) if quadruped && n("leg").is_some_and(|i| (1..=4).contains(&i)) => {
    // rust: n("leg").map(|i| LEGS[i - 1].into())
}
    // rust: (_, _) if spider && n("leg").is_some_and(|i| (1..=8).contains(&i)) => {
    // rust: n("leg").map(|i| SPIDER_LEGS[i - 1].into())
}
    // rust: (_, "neck") if spider => Some("body0".into()),
    // rust: (_, "body") if spider => Some("body1".into()),
    // rust: ("villager" | "wandering_trader" | "witch", "headwear2") => Some("hat_rim".into()),
    // rust: ("villager" | "wandering_trader" | "witch", "bodywear") => Some("jacket".into()),
    // rust: ("chicken" | "cold_chicken" | "warm_chicken", "bill") => Some("beak".into()),
    // rust: ("chicken" | "cold_chicken" | "warm_chicken", "chin") => Some("red_thing".into()),
    // rust: ("llama" | "llama_decor" | "trader_llama" | "trader_llama_decor", "chest_right") => {
    // rust: Some("right_chest".into())
}
    // rust: ("llama" | "llama_decor" | "trader_llama" | "trader_llama_decor", "chest_left") => {
    // rust: Some("left_chest".into())
}
    // rust: ("turtle", "body2") => Some("egg_belly".into()),
    // rust: ("ravager", "jaw") => Some("mouth".into()),
    // rust: ("bee" | "warden", "body") => Some("bone".into()),
    // rust: ("bee" | "warden", "torso") => Some("body".into()),
    // rust: ("snow_golem", "body") => Some("upper_body".into()),
    // rust: ("snow_golem", "body_bottom") => Some("lower_body".into()),
    // rust: ("snow_golem", "right_hand") => Some("right_arm".into()),
    // rust: ("snow_golem", "left_hand") => Some("left_arm".into()),
    // rust: ("slime" | "slime_outer", "body") => Some("cube".into()),
    // rust: ("magma_cube", "core") => Some("inside_cube".into()),
    // rust: ("magma_cube", _) => n("segment").map(|i| format!("cube{}", i - 1)),
    // rust: ("blaze", _) => n("stick").map(|i| format!("part{}", i - 1)),
    // rust: ("ghast" | "happy_ghast" | "happy_ghast_ropes" | "squid" | "glow_squid", _) => {
    // rust: n("tentacle").map(|i| format!("tentacle{}", i - 1))
}
    // rust: ("silverfish", _) => n("body")
    // rust: .map(|i| format!("segment{}", i - 1))
    // rust: .or_else(|| n("wing").map(|i| format!("layer{}", i - 1))),
    // rust: ("endermite", _) => n("body").map(|i| format!("segment{}", i - 1)),
    // rust: ("guardian" | "elder_guardian", _) => n("spine")
    // rust: .map(|i| format!("spike{}", i - 1))
    // rust: .or_else(|| n("tail").map(|i| format!("tail{}", i - 1))),
    // rust: ("wither" | "wither_armor", _) => n("body")
    // rust: .and_then(|i| ["shoulders", "ribcage", "tail"].get(i - 1).copied())
    // rust: .or_else(|| {
    // rust: n("head").and_then(|i| {
    // rust: ["center_head", "right_head", "left_head"]
    // rust: .get(i - 1)
    // rust: .copied()
    // rust: })
    // rust: })
    // rust: .map(str::to_owned),
    // rust: ("phantom", "left_wing") => Some("left_wing_base".into()),
    // rust: ("phantom", "right_wing") => Some("right_wing_base".into()),
    // rust: ("phantom", "tail") => Some("tail_base".into()),
    // rust: ("phantom", "tail2") => Some("tail_tip".into()),
    // rust: ("cat" | "ocelot" | "cat_collar", "tail") => Some("tail1".into()),
    // rust: ("bat", "outer_right_wing") => Some("right_wing_tip".into()),
    // rust: ("bat", "outer_left_wing") => Some("left_wing_tip".into()),
    // rust: ("cod" | "tropical_fish_a" | "tropical_fish_b", "fin_back" | "fin_top") => {
    // rust: Some("top_fin".into())
}
        // The big and medium pufferfish have blue fins; the small one has plain `right_fin`s
        // (the fin animation in aquatic.rs).
    // rust: ("puffer_fish_big" | "puffer_fish_medium", "fin_right") => Some("right_blue_fin".into()),
    // rust: ("puffer_fish_big" | "puffer_fish_medium", "fin_left") => Some("left_blue_fin".into()),
        // RabbitModel's hind feet (rabbit.rs).
    // rust: ("rabbit", "left_foot") => Some("left_hind_foot".into()),
    // rust: ("rabbit", "right_foot") => Some("right_hind_foot".into()),
    // rust: (_, "fin_right") => Some("right_fin".into()),
    // rust: (_, "fin_left") => Some("left_fin".into()),
    // rust: (_, "fin_bottom") => Some("bottom_fin".into()),
    // rust: ("cod", "tail") => Some("tail_fin".into()),
    // rust: ("sniffer", _) => part
    // rust: .strip_prefix("middle_")
    // rust: .and_then(|side| side.strip_suffix("_leg"))
    // rust: .map(|side| format!("{side}_mid_leg")),
        // `spikes_<front>_<top>` and `hair_<right>_<bottom>`.
    // rust: (_, _) if part.starts_with("spikes_") => part["spikes_".len()..]
    // rust: .split_once('_')
    // rust: .map(|(along, side)| format!("{side}_{along}_fin")),
    // rust: ("strider" | "strider_saddle", _) => part
    // rust: .strip_prefix("hair_")
    // rust: .map(|rest| format!("{rest}_bristle")),
    // rust: ("horse" | "donkey" | "mule" | "skeleton_horse" | "zombie_horse", "neck") => {
    // rust: Some("head_parts".into())
}
    // rust: ("horse" | "donkey" | "mule" | "skeleton_horse" | "zombie_horse", "mouth") => {
    // rust: Some("upper_mouth".into())
}
    // rust: _ => None,
}
    // rust: renamed.unwrap_or_else(|| part.to_owned())
}

    // rust: impl CemLayer {
    // `vanilla` reshaped by `jem`, the model `name`'s file, whose random-model `rules`
    // feed the animations' `rule_index`.
build :: proc(vanilla: ^Part, jem: ^EntityModel, name: string, rules: ^[Rule]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let model = name.replace("_baby", "");
    // rust: let mut out = vanilla.clone();
    // rust: let mut count = 0;
    // rust: let mut ids = HashMap::new();
    // rust: let mut anchors = Vec::new();
        // The vanilla nodes this file names, resolved before any is replaced: what a
        // replaced node's own children are measured against (an entry can name a part below
        // one an earlier entry replaced). The same resolution an entry's own target takes,
        // fallback to the raw name included.
    // rust: let named: std::collections::HashSet<String> = jem
    // rust: .parts
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let target = vanilla_part(&model, &p.part);
    // rust: if super::render::find_part(&out, &target).is_some() {
    // rust: target
    // rust: } else {
    // rust: p.part.clone()
}
    // rust: })
    // rust: .filter(|target| super::render::find_part(&out, target).is_some())
    // rust: .collect();
        // Each entry's `this` and `part`, and its animations.
    // rust: let mut entries = Vec::new();
    // rust: for p in &jem.parts {
    // rust: let target = vanilla_part(&model, &p.part);
    // rust: let target = if super::render::find_part(&out, &target).is_some() {
    // rust: target
    // rust: } else {
    // rust: p.part.clone()
}
    // rust: let bone = part(&p.bone, &mut count, &mut ids, &mut anchors);
    // rust: let Some(node) = find_mut(&mut out, &target) else {
    // rust: log::warn!("Horizon: custom entity model {name}: no part {}", p.part);
    // rust: continue;
}
    // rust: if !p.attach {
    // rust: node.polygons.clear();
                // A replaced node's own children that no entry names are the vanilla
                // geometry the replacement stands in for: EMF hides them
                // (`EMFModelPartRoot.addAndSetVariantOfJem`), or a villager's nose draws
                // beside the pack's own.
    // rust: hide_unnamed(node, &named);
}
            // A replacing entry stands in for the vanilla part; an attached one is its own.
    // rust: let this = if p.attach {
    // rust: bone.name.clone()
    // rust: } else {
    // rust: target.clone()
}
    // rust: entries.push((this, target, p.animations.as_slice()));
    // rust: node.children.push(bone);
}
    // rust: let names = super::cem_anim::Names {
    // rust: model: &out,
    // rust: vanilla: &|p| vanilla_part(&model, p),
    // rust: ids: &ids,
}
    // rust: let animation = super::cem_anim::compile_animation(name, &names, &entries, rules);
    // rust: Self {
    // rust: model: Arc::new(out),
    // rust: animation,
    // rust: texture: jem.texture.as_deref().and_then(atlas_name),
    // rust: anchors,
}
}
}

// The first part named `name`, depth first (`ModelPart.getChild` through the tree).
    // rust: fn find_mut<'a>(part: &'a mut Part, name: &str) -> Option<&'a mut Part> {
    // rust: if part.name == name {
    // rust: return Some(part);
}
    // rust: part.children.iter_mut().find_map(|c| find_mut(c, name))
}

// The vanilla children of a replaced node that no entry names and no model family addresses
// lose their polygons (the nodes stay, so a pack can still pose them): they are what the
// replacement stands in for. The parts every family can address keep theirs, and so does
// everything the file itself went on to name.
hide_unnamed :: proc(node: ^Part, named: ^std::collections::map[string]struct{}) {
}
    // rust: const KEEP: &[&str] = &[
    // rust: "head",
    // rust: "hat",
    // rust: "body",
    // rust: "arms",
    // rust: "right_arm",
    // rust: "left_arm",
    // rust: "right_leg",
    // rust: "left_leg",
    // rust: "right_hind_leg",
    // rust: "left_hind_leg",
    // rust: "right_front_leg",
    // rust: "left_front_leg",
    // rust: ];
    // rust: for child in &mut node.children {
    // rust: if named.contains(&child.name)
    // rust: || KEEP.contains(&child.name.as_str())
    // rust: || child.name.starts_with("cem#")
    // rust: {
    // rust: continue;
}
    // rust: child.polygons.clear();
    // rust: hide_unnamed(child, named);
}
}

// A baked bone as a model part, its pose the bone's own translate, rotation and scale —
// what a pack's animation write replaces. Its name, `cem#<n>`, is unique in the model, so
// its pose is its own whatever the files call their ids.
// `ids` gets the bone's id, if it has one, under that name; `anchors` its `attachments`.
    // rust: fn part(
    // rust: bone: &Bone,
    // rust: count: &mut usize,
    // rust: ids: &mut HashMap<String, String>,
    // rust: anchors: &mut Vec<(String, String, [f32; 3])>,
    // rust: ) -> Part {
    // rust: let name = format!("cem#{count}");
    // rust: *count += 1;
    // rust: if let Some(id) = &bone.id {
    // rust: ids.insert(name.clone(), id.clone());
}
    // rust: for (kind, at) in &bone.attachments {
    // rust: anchors.push((name.clone(), kind.clone(), *at));
}
    // rust: let [x, y, z] = bone.pivot;
    // rust: let [rx, ry, rz] = bone.rotation;
    // rust: let [sx, sy, sz] = bone.scale;
    // rust: Part {
    // rust: name,
    // rust: pose: [x, y, z, rx, ry, rz, sx, sy, sz],
    // rust: polygons: bone
    // rust: .quads
    // rust: .iter()
    // rust: .map(|q| Polygon {
    // rust: normal: q.normal,
    // rust: vertices: q.vertices,
    // rust: cull_back: false,
    // rust: })
    // rust: .collect(),
    // rust: children: bone
    // rust: .children
    // rust: .iter()
    // rust: .map(|c| part(c, count, ids, anchors))
    // rust: .collect(),
}
}

    // rust: mod tests {
//     use super::*;
//     use std::fs;

plane :: proc(name: string, children: [dynamic]Part) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Part {
    // rust: name: name.into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![Polygon {
    // rust: normal: [0.0, 0.0, -1.0],
    // rust: cull_back: false,
    // rust: vertices: [[0.0; 5]; 4],
    // rust: }],
    // rust: children,
}
}
    // rust: fn get<'a>(part: &'a Part, name: &str) -> &'a Part {
    // rust: fn walk<'a>(p: &'a Part, name: &str) -> Option<&'a Part> {
    // rust: (p.name == name)
    // rust: .then_some(p)
    // rust: .or_else(|| p.children.iter().find_map(|c| walk(c, name)))
}
    // rust: walk(part, name).unwrap()
}

layer_names :: proc() {
}
    // rust: for (name, key) in [
    // rust: ("zombie", "zombie#main"),
    // rust: ("zombie_baby", "zombie_baby#main"),
    // rust: ("sheep_wool", "sheep#wool"),
    // rust: ("sheep_baby_wool", "sheep_baby#wool"),
    // rust: ("drowned_baby_outer", "drowned_baby#outer"),
    // rust: ("cold_chicken", "cold_chicken#main"),
    // rust: ("puffer_fish_big", "pufferfish_big#main"),
    // rust: ("tropical_fish_pattern_b", "tropical_fish_large#pattern"),
    // rust: ] {
    // rust: assert_eq!(layer_key(name), key, "{name}");
}
    // rust: assert_eq!(
    // rust: baby_names("sheep_wool").collect::<Vec<_>>(),
    // rust: ["sheep_baby_wool", "sheep_wool_baby"]
    // rust: );
}

part_names :: proc() {
}
    // rust: for (model, part, vanilla) in [
    // rust: ("zombie", "headwear", "hat"),
    // rust: ("zombie", "left_arm", "left_arm"),
    // rust: ("cow", "leg1", "right_hind_leg"),
    // rust: ("cow", "leg4", "left_front_leg"),
    // rust: ("spider", "leg5", "right_middle_front_leg"),
    // rust: ("spider", "neck", "body0"),
    // rust: ("ghast", "tentacle1", "tentacle0"),
    // rust: ("blaze", "stick12", "part11"),
    // rust: ("camel", "back_left_leg", "left_hind_leg"),
    // rust: ("villager", "headwear2", "hat_rim"),
    // rust: ("wither", "head2", "right_head"),
    // rust: ("strider", "hair_left_top", "left_top_bristle"),
    // rust: ("puffer_fish_big", "spikes_front_top", "top_front_fin"),
    // rust: ("squid", "tentacle0", "tentacle0"),
    // rust: ("puffer_fish_medium", "fin_left", "left_blue_fin"),
    // rust: ("puffer_fish_small", "fin_right", "right_fin"),
    // rust: ("rabbit", "left_foot", "left_hind_foot"),
    // rust: ] {
    // rust: assert_eq!(vanilla_part(model, part), vanilla, "{model} {part}");
}
}

random_model_rules_feed_rule_index :: proc() {
}
        // Fresh Animations' cow: rule 2 grazes on grass, wheat or hay.
    // rust: let cow = parse_rules("models.2=1\nblocks.2=grass_block wheat hay_block");
    // rust: assert_eq!(
    // rust: matching_rule_index(&cow, Some("minecraft:grass_block"), false, false, false),
    // rust: 2.0
    // rust: );
    // rust: assert_eq!(
    // rust: matching_rule_index(&cow, Some("stone"), false, false, false),
    // rust: 0.0
    // rust: );
    // rust: assert_eq!(matching_rule_index(&cow, None, false, false, false), 0.0);
        // A bee on a flower without nectar; a sleeping villager; a sheared snow golem.
    // rust: let bee = parse_rules("models.2=1\nblocks.2=dandelion poppy\nnbt.2.HasNectar=0");
    // rust: assert_eq!(
    // rust: matching_rule_index(&bee, Some("poppy"), false, false, false),
    // rust: 2.0
    // rust: );
    // rust: assert_eq!(
    // rust: matching_rule_index(&bee, Some("poppy"), false, true, false),
    // rust: 0.0
    // rust: );
    // rust: let villager = parse_rules("models.1=1\nnbt.1.sleeping_pos=exists:true");
    // rust: assert_eq!(
    // rust: matching_rule_index(&villager, None, true, false, false),
    // rust: 1.0
    // rust: );
    // rust: assert_eq!(
    // rust: matching_rule_index(&villager, None, false, false, false),
    // rust: 0.0
    // rust: );
    // rust: let golem = parse_rules("models.1=1\nnbt.1.Pumpkin=raw:1b");
    // rust: assert_eq!(matching_rule_index(&golem, None, false, false, true), 1.0);
    // rust: assert_eq!(matching_rule_index(&golem, None, false, false, false), 0.0);
        // A rule without conditions is a plain variant, never a state.
    // rust: let plain = parse_rules("models.3=1");
    // rust: assert_eq!(
    // rust: matching_rule_index(&plain, Some("grass_block"), true, true, true),
    // rust: 0.0
    // rust: );
}

files_reshape_their_layers_and_babies_fall_back :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-cem-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let cem = root.join("assets/minecraft/optifine/cem");
    // rust: fs::create_dir_all(cem.join("zombie")).unwrap();
    // rust: let box_ = r#""boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}]"#;
    // rust: fs::write(
    // rust: cem.join("zombie/zombie.jem"),
    // rust: format!(
    // rust: r#"{{"texture": "textures/entity/zombie/green.png", "models": [
    // rust: {{"part": "head", {box_}}},
    // rust: {{"part": "headwear", "attach": true, "scale": 2, {box_}}},
    // rust: {{"part": "tail", {box_}}}]}}"#
    // rust: ),
    // rust: )
    // rust: .unwrap();
        // Picked over optifine/cem's, though nothing reads EMF's here but its folder.
    // rust: fs::create_dir_all(root.join("assets/minecraft/emf/cem")).unwrap();
    // rust: fs::write(
    // rust: root.join("assets/minecraft/emf/cem/cow.jem"),
    // rust: format!(r#"{{"models": [{{"part": "leg1", {box_}}}]}}"#),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(cem.join("cow.jem"), "{").unwrap();
    // rust: let zombie = Arc::new(plane(
    // rust: "root",
    // rust: vec![plane("head", vec![plane("hat", vec![])])],
    // rust: ));
    // rust: let cow = Arc::new(plane("root", vec![plane("right_hind_leg", vec![])]));
    // rust: let vanilla: HashMap<&str, (&Arc<Part>, &str)> = [
    // rust: ("zombie#main", (&zombie, "minecraft:zombie")),
    // rust: ("zombie_baby#main", (&zombie, "minecraft:zombie")),
    // rust: ("cow#main", (&cow, "minecraft:cow")),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect();
    // rust: let (models, _) = CemModels::from_files(&root, &jem_files(&root), &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();

    // rust: let adult = models.layer("zombie#main").unwrap();
    // rust: assert_eq!(adult.texture.as_deref(), Some("entity/zombie/green"));
    // rust: let head = get(&adult.model, "head");
        // Replaced: the head's own face goes, its hat stays, the custom box joins as a child.
    // rust: assert_eq!(head.polygons.len(), 0);
    // rust: assert_eq!(get(&adult.model, "cem#0").polygons.len(), 6);
        // Attached: the hat keeps its face beside the scaled custom box.
    // rust: let hat = get(&adult.model, "hat");
    // rust: assert_eq!(hat.polygons.len(), 1);
    // rust: assert_eq!(get(hat, "cem#1").pose[6..], [2.0, 2.0, 2.0]);
        // The baby has no file of its own: it takes the adult's.
    // rust: let baby = models.layer("zombie_baby#main").unwrap();
    // rust: assert_eq!(get(&baby.model, "head").polygons.len(), 0);
    // rust: let leg = get(&models.layer("cow#main").unwrap().model, "right_hind_leg");
    // rust: assert_eq!((leg.polygons.len(), leg.children.len()), (0, 1));
    // rust: assert!(models.layer("sheep#main").is_none());
}

BOX :: r#""boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}]"#

    // A `.jem` with one entry on `part`, attached or replacing it.
jem :: proc(part: string, attach: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(r#"{{"models": [{{"part": "{part}", "attach": {attach}, {BOX}}}]}}"#)
}

    // A fresh pack folder for the test `test` holding `files` (paths under `assets/minecraft/`).
pack :: proc(test: string, files: ^[(string) {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-cem-{test}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for (path, text) in files {
    // rust: let path = root.join("assets/minecraft").join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: root
}

    // The models of the pack `files` over the `layers`, the same tree for each.
models :: proc(test: string, files: ^[(string) {
}
    // rust: let root = pack(test, files);
    // rust: let tree = Arc::new(tree.clone());
    // rust: let vanilla: HashMap<&str, (&Arc<Part>, &str)> = layers
    // rust: .iter()
    // rust: .map(|k| (*k, (&tree, "minecraft:test")))
    // rust: .collect();
    // rust: let (models, _) = CemModels::from_files(&root, &jem_files(&root), &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: models
}

    // Whether the layer `key`'s part `name` was replaced (lost its own face) or had a box
    // attached (kept it); None without the layer. Either way the box joins as a child.
attached :: proc(models: ^CemModels, key: string, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let part = get(&models.layer(key)?.model, name);
    // rust: assert_eq!(part.children.len(), 1, "{key} {name}: one custom box");
    // rust: Some(part.polygons.len() == 1)
}

a_baby_with_its_own_file_takes_it_not_the_adults :: proc() {
}
    // rust: let (adult, baby) = (jem("head", false), jem("head", true));
    // rust: let files = [
    // rust: ("optifine/cem/zombie.jem", adult.as_str()),
    // rust: ("optifine/cem/zombie_baby.jem", baby.as_str()),
    // rust: ];
    // rust: let tree = plane("root", vec![plane("head", vec![])]);
    // rust: let models = models("baby", &files, &["zombie#main", "zombie_baby#main"], &tree);
    // rust: assert_eq!(attached(&models, "zombie#main", "head"), Some(false));
    // rust: assert_eq!(attached(&models, "zombie_baby#main", "head"), Some(true));
}

two_names_of_one_layer_give_it_the_first_by_name :: proc() {
}
    // rust: let (llama, trader) = (jem("body", false), jem("body", true));
    // rust: let files = [
    // rust: ("optifine/cem/trader_llama_decor.jem", trader.as_str()),
    // rust: ("optifine/cem/llama_decor.jem", llama.as_str()),
    // rust: ];
    // rust: let tree = plane("root", vec![plane("body", vec![])]);
        // Written trader first, `llama_decor` still shapes the layer, and the baby's (both
        // fall back to the adult files).
    // rust: let models = models("decor", &files, &["llama#decor", "llama_baby#decor"], &tree);
    // rust: assert_eq!(attached(&models, "llama#decor", "body"), Some(false));
    // rust: assert_eq!(attached(&models, "llama_baby#decor", "body"), Some(false));
}

other_models_fall_back_but_the_baby_nautilus_does_not :: proc() {
}
    // rust: let (replace, attach) = (jem("body", false), jem("body", true));
    // rust: let cat = format!(
    // rust: r#"{{"texture": "textures/entity/cat/custom.png", "models": [
    // rust: {{"part": "body", {BOX}}}]}}"#
    // rust: );
    // rust: let files = [
    // rust: ("optifine/cem/salmon.jem", replace.as_str()),
    // rust: ("optifine/cem/salmon_large.jem", attach.as_str()),
    // rust: ("optifine/cem/nautilus.jem", replace.as_str()),
    // rust: ("optifine/cem/cat.jem", cat.as_str()),
    // rust: ];
    // rust: let tree = plane("root", vec![plane("body", vec![])]);
    // rust: let models = models(
    // rust: "fallbacks",
    // rust: &files,
    // rust: &[
    // rust: "salmon#main",
    // rust: "salmon_small#main",
    // rust: "salmon_large#main",
    // rust: "nautilus#main",
    // rust: "nautilus_baby#main",
    // rust: "cat#main",
    // rust: "cat#collar",
    // rust: "cat_baby#collar",
    // rust: ],
    // rust: &tree,
    // rust: );
        // The small salmon has no file: salmon.jem's. The large one has its own.
    // rust: assert_eq!(attached(&models, "salmon_small#main", "body"), Some(false));
    // rust: assert_eq!(attached(&models, "salmon_large#main", "body"), Some(true));
    // rust: assert_eq!(attached(&models, "nautilus#main", "body"), Some(false));
    // rust: assert!(models.layer("nautilus_baby#main").is_none());
        // The collar takes the cat's geometry, but its own collar texture stays.
    // rust: let texture = |key: &str| models.layer(key).unwrap().texture.clone();
    // rust: assert_eq!(texture("cat#main").as_deref(), Some("entity/cat/custom"));
    // rust: assert_eq!(attached(&models, "cat#collar", "body"), Some(false));
    // rust: assert_eq!(texture("cat#collar"), None);
        // So does the baby's, two fallbacks down: `cat_baby_collar`, `cat_collar`, `cat`.
    // rust: assert_eq!(attached(&models, "cat_baby#collar", "body"), Some(false));
    // rust: assert_eq!(texture("cat_baby#collar"), None);
}

a_broken_file_gives_way_to_the_next :: proc() {
}
    // rust: let (replace, attach) = (jem("body", false), jem("body", true));
    // rust: let files = [
            // The first name of the layer is broken: the second shapes it.
    // rust: ("optifine/cem/llama_decor.jem", "{"),
    // rust: ("optifine/cem/trader_llama_decor.jem", attach.as_str()),
            // EMF's file is broken: OptiFine's stands.
    // rust: ("emf/cem/cow.jem", "{"),
    // rust: ("optifine/cem/cow.jem", replace.as_str()),
            // The baby's own file is broken: the adult's falls back onto it.
    // rust: ("optifine/cem/zombie_baby.jem", "{"),
    // rust: ("optifine/cem/zombie.jem", attach.as_str()),
    // rust: ];
    // rust: let tree = plane("root", vec![plane("body", vec![])]);
    // rust: let models = models(
    // rust: "broken",
    // rust: &files,
    // rust: &["llama#decor", "cow#main", "zombie_baby#main"],
    // rust: &tree,
    // rust: );
    // rust: assert_eq!(attached(&models, "llama#decor", "body"), Some(true));
    // rust: assert_eq!(attached(&models, "cow#main", "body"), Some(false));
    // rust: assert_eq!(attached(&models, "zombie_baby#main", "body"), Some(true));
}

an_unknown_part_is_skipped_and_the_rest_applies :: proc() {
}
    // rust: let file =
    // rust: format!(r#"{{"models": [{{"part": "wings", {BOX}}}, {{"part": "head", {BOX}}}]}}"#);
    // rust: let tree = plane("root", vec![plane("head", vec![])]);
    // rust: let models = models(
    // rust: "unknown",
    // rust: &[("optifine/cem/zombie.jem", file.as_str())],
    // rust: &["zombie#main"],
    // rust: &tree,
    // rust: );
    // rust: assert_eq!(attached(&models, "zombie#main", "head"), Some(false));
custom :: proc(p: ^Part) -> u {
    // Ported from Horizon
    return {}
}
    // rust: usize::from(p.name.starts_with("cem#")) + p.children.iter().map(custom).sum::<usize>()
}
    // rust: assert_eq!(custom(&models.layer("zombie#main").unwrap().model), 1);
}

    // A mob type `id` of `species` whose body and `layers` are all `tree`, with the vanilla
    // `texture`.
    // rust: fn mob_kind(
    // rust: id: &str,
    // rust: species: super::super::Species,
    // rust: anim: super::super::Anim,
    // rust: texture: &str,
    // rust: layers: &[&str],
    // rust: tree: &Part,
    // rust: ) -> Arc<MobType> {
    // rust: let mut kind = (*super::super::sensor_scan_tests::kind()).clone();
    // rust: kind.id = id.into();
    // rust: kind.texture = texture.into();
    // rust: kind.species = species;
    // rust: kind.anim = anim;
    // rust: kind.model = Arc::new(tree.clone());
    // rust: kind.layers = layers
    // rust: .iter()
    // rust: .map(|k| ((*k).to_owned(), Arc::new(tree.clone())))
    // rust: .collect();
    // rust: Arc::new(kind)
}

    // How many vertices `render` draws of `mob` in each of `sprites`, laid far apart in the
    // atlas: the sprite a vertex's UV falls in says what it drew with. `sprites[0]`, the
    // `.jem`'s texture, is in the atlas only with `custom`.
    // rust: fn sprite_counts(
    // rust: mob: &super::super::Mob,
    // rust: models: &Arc<CemModels>,
    // rust: sprites: &[&str],
    // rust: custom: bool,
    // rust: ) -> Vec<usize> {
    // rust: let data = super::super::MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: std::sync::RwLock::new(models.clone()),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
        // Sprite i spans u and v from 0.2 i to 0.2 i + 0.1.
    // rust: let atlas = |name: &str| -> Option<[f32; 4]> {
    // rust: let i = sprites.iter().position(|s| *s == name)?;
    // rust: let lo = i as f32 * 0.2;
    // rust: (custom || i != 0).then_some([lo, lo, lo + 0.1, lo + 0.1])
}
    // rust: let mut vertices = Vec::new();
    // rust: super::super::render::render(
    // rust: mob,
    // rust: 0.0,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xf0f0,
    // rust: &data,
    // rust: &mut vertices,
    // rust: );
    // rust: let mut counts = vec![0; sprites.len()];
    // rust: for v in &vertices {
    // rust: let u = v.uv[0];
    // rust: let i = ((u + 0.05) / 0.2).floor() as usize;
    // rust: assert!(
    // rust: i < sprites.len() && u - i as f32 * 0.2 <= 0.1 + 1e-4,
    // rust: "a UV between the sprites: {u}"
    // rust: );
    // rust: counts[i] += 1;
}
    // rust: counts
}

    // A spider whose `.jem` replaces its body: the body draws with the `.jem`'s texture, the
    // eyes (an overlay on the body's model) with theirs on the new geometry, and a texture the
    // atlas lacks leaves the vanilla one. A sheep's wool, a layer with a model of its own,
    // takes its `.jem`'s texture.
a_jem_texture_paints_its_layer_and_leaves_the_overlays :: proc() {
}
//         use super::super::{Anim, Mob, Species};
    // rust: let tree = |part: &str| Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: vec![plane(part, vec![])],
}
    // rust: let textured = |texture: &str| {
    // rust: format!(
    // rust: r#"{{"texture": "textures/{texture}.png", "models": [
    // rust: {{"part": "body", {BOX}}}]}}"#
    // rust: )
}
    // rust: let spider = textured("entity/spider/custom");
    // rust: let cem = Arc::new(models(
    // rust: "render",
    // rust: &[("optifine/cem/spider.jem", spider.as_str())],
    // rust: &["spider#main"],
    // rust: &tree("body1"),
    // rust: ));
    // rust: let mob = Mob::new(
    // rust: 1,
    // rust: mob_kind(
    // rust: "minecraft:spider",
    // rust: Species::Spider,
    // rust: Anim::Spider,
    // rust: "entity/spider/spider",
    // rust: &["spider#main"],
    // rust: &tree("body1"),
    // rust: ),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: let sprites = [
    // rust: "entity/spider/custom",
    // rust: "entity/spider/spider_eyes",
    // rust: "entity/spider/spider",
    // rust: ];
        // The custom box's six faces, four corners each, for the body and again for the eyes;
        // the replaced body part's own face is gone.
    // rust: assert_eq!(sprite_counts(&mob, &cem, &sprites, true), [24, 24, 0]);
    // rust: assert_eq!(sprite_counts(&mob, &cem, &sprites, false), [0, 24, 24]);

    // rust: let wool = textured("entity/sheep/custom_wool");
    // rust: let cem = Arc::new(models(
    // rust: "render-sheep",
    // rust: &[("optifine/cem/sheep_wool.jem", wool.as_str())],
    // rust: &["sheep#main", "sheep#wool"],
    // rust: &tree("body"),
    // rust: ));
    // rust: let mob = Mob::new(
    // rust: 1,
    // rust: mob_kind(
    // rust: "minecraft:sheep",
    // rust: Species::Sheep,
    // rust: Anim::Sheep,
    // rust: "entity/sheep/sheep",
    // rust: &["sheep#main", "sheep#wool"],
    // rust: &tree("body"),
    // rust: ),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: let sprites = [
    // rust: "entity/sheep/custom_wool",
    // rust: "entity/sheep/sheep_wool",
    // rust: "entity/sheep/sheep",
    // rust: ];
        // The wool's custom box in the `.jem`'s texture; the vanilla body's one face.
    // rust: assert_eq!(sprite_counts(&mob, &cem, &sprites, true), [24, 0, 4]);
    // rust: assert_eq!(sprite_counts(&mob, &cem, &sprites, false), [0, 24, 4]);
}

    // A wolf armour `.jem`'s texture paints the armour, the first layer on its model, and
    // not the cracks drawn over it on the same model.
armour_cracks_keep_their_texture :: proc() {
}
//         use super::super::{Anim, Mob, Species, WOLF_ARMOR_DURABILITY};
    // rust: let tree = Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: vec![plane("body", vec![])],
}
    // rust: let file = format!(
    // rust: r#"{{"texture": "textures/entity/wolf/custom_armor.png", "models": [
    // rust: {{"part": "body", {BOX}}}]}}"#
    // rust: );
    // rust: let layers = ["wolf#main", "wolf_armor#main"];
    // rust: let cem = Arc::new(models(
    // rust: "cracks",
    // rust: &[("optifine/cem/wolf_armor.jem", file.as_str())],
    // rust: &layers,
    // rust: &tree,
    // rust: ));
    // rust: let mut mob = Mob::new(
    // rust: 1,
    // rust: mob_kind(
    // rust: "minecraft:wolf",
    // rust: Species::Wolf,
    // rust: Anim::Wolf,
    // rust: "entity/wolf/wolf",
    // rust: &layers,
    // rust: &tree,
    // rust: ),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: mob.extra.tame = true;
    // rust: mob.extra.body = Some("minecraft:wolf_armor".into());
        // Worn through: the high cracks.
    // rust: mob.extra.body_damage = WOLF_ARMOR_DURABILITY;
    // rust: let sprites = [
    // rust: "entity/wolf/custom_armor",
    // rust: "entity/equipment/wolf_body/armadillo_scute",
    // rust: "entity/wolf/wolf_armor_crackiness_high",
    // rust: "entity/wolf/wolf_collar",
    // rust: ];
        // The armour's custom box in the `.jem`'s texture, the cracks' over the same box in
        // theirs, and the collar on the vanilla body (whose own texture isn't in the atlas).
    // rust: assert_eq!(sprite_counts(&mob, &cem, &sprites, true), [24, 0, 24, 4]);
    // rust: assert_eq!(sprite_counts(&mob, &cem, &sprites, false), [0, 24, 24, 4]);
}

    // Every layer of [`LAYERS`] and [`FALLBACKS`] is in Horizon's own models, every baby layer
    // there is one a baby model name maps to, and so are the parts a sample of part names is
    // renamed to.
names_reach_horizons_models :: proc() {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES");
    // rust: let types: HashMap<String, Arc<MobType>> = super::super::MobTypes::load(Path::new(&root))
    // rust: .unwrap()
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k, Arc::new(v)))
    // rust: .collect();
    // rust: let vanilla = vanilla_layers(&types);
    // rust: let mut missing = Vec::new();
    // rust: for (name, key) in LAYERS {
    // rust: if !vanilla.contains_key(key) {
    // rust: missing.push(format!("{name}: no layer {key}"));
}
}
    // rust: for name in FALLBACKS.iter().flat_map(|(name, takes)| [*name, *takes]) {
    // rust: let key = layer_key(name);
    // rust: if !vanilla.contains_key(key.as_str()) {
    // rust: missing.push(format!("{name}: no layer {key}"));
}
}
        // `sheep_baby#wool` is `sheep_baby_wool`'s: the baby name of a name of `sheep#wool`.
    // rust: for key in vanilla.keys() {
    // rust: let Some((model, layer)) = key.split_once('#') else {
    // rust: continue;
}
    // rust: let Some(adult) = model.strip_suffix("_baby") else {
    // rust: continue;
}
    // rust: let adult_key = format!("{adult}#{layer}");
    // rust: let reached = LAYERS
    // rust: .iter()
    // rust: .map(|(name, _)| *name)
    // rust: .chain([adult])
    // rust: .filter(|name| layer_key(name) == adult_key)
    // rust: .flat_map(baby_names)
    // rust: .any(|baby| layer_key(&baby) == *key);
    // rust: if !reached {
    // rust: missing.push(format!("{key}: no baby model name maps to it"));
}
}
        // A sample of the renamed parts.
    // rust: for (model, part) in [
    // rust: ("zombie", "headwear"),
    // rust: ("cow", "leg1"),
    // rust: ("cow", "leg4"),
    // rust: ("camel", "back_left_leg"),
    // rust: ("camel", "front_right_leg"),
    // rust: ("spider", "leg1"),
    // rust: ("spider", "leg8"),
    // rust: ("spider", "neck"),
    // rust: ("spider", "body"),
    // rust: ("villager", "headwear2"),
    // rust: ("villager", "bodywear"),
    // rust: ("witch", "headwear2"),
    // rust: ("witch", "bodywear"),
    // rust: ("chicken", "bill"),
    // rust: ("chicken", "chin"),
    // rust: ("llama", "chest_right"),
    // rust: ("llama", "chest_left"),
    // rust: ("turtle", "body2"),
    // rust: ("ravager", "jaw"),
    // rust: ("bee", "body"),
    // rust: ("bee", "torso"),
    // rust: ("warden", "body"),
    // rust: ("warden", "torso"),
    // rust: ("snow_golem", "body"),
    // rust: ("snow_golem", "body_bottom"),
    // rust: ("snow_golem", "right_hand"),
    // rust: ("snow_golem", "left_hand"),
    // rust: ("slime", "body"),
    // rust: ("magma_cube", "core"),
    // rust: ("magma_cube", "segment1"),
    // rust: ("blaze", "stick1"),
    // rust: ("ghast", "tentacle1"),
    // rust: ("squid", "tentacle1"),
    // rust: ("silverfish", "body1"),
    // rust: ("silverfish", "wing1"),
    // rust: ("endermite", "body1"),
    // rust: ("guardian", "spine1"),
    // rust: ("guardian", "tail1"),
    // rust: ("wither", "body1"),
    // rust: ("wither", "head1"),
    // rust: ("phantom", "left_wing"),
    // rust: ("phantom", "tail2"),
    // rust: ("cat", "tail"),
    // rust: ("ocelot", "tail"),
    // rust: ("bat", "outer_right_wing"),
    // rust: ("cod", "fin_back"),
    // rust: ("cod", "fin_right"),
    // rust: ("cod", "tail"),
    // rust: ("tropical_fish_b", "fin_top"),
    // rust: ("tropical_fish_b", "fin_bottom"),
    // rust: ("puffer_fish_big", "fin_right"),
    // rust: ("puffer_fish_medium", "fin_left"),
    // rust: ("puffer_fish_small", "fin_right"),
    // rust: ("puffer_fish_big", "spikes_front_top"),
    // rust: ("rabbit", "left_foot"),
    // rust: ("rabbit", "right_foot"),
    // rust: ("sniffer", "middle_left_leg"),
    // rust: ("strider", "hair_left_top"),
    // rust: ("horse", "neck"),
    // rust: ("horse", "mouth"),
    // rust: ] {
    // rust: let key = layer_key(model);
    // rust: let target = vanilla_part(model, part);
    // rust: let found = vanilla
    // rust: .get(key.as_str())
    // rust: .is_some_and(|(tree, _)| super::super::render::find_part(tree, &target).is_some());
    // rust: if !found {
    // rust: missing.push(format!("{model} {part}: no part {target} in {key}"));
}
}
    // rust: assert!(missing.is_empty(), "{missing:#?}");
}
}
