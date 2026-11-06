//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_random
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Random entity textures (`optifine/random/entity/<path>.properties`, the legacy `mob/` folder):
//! the numbered rules that pick which of a texture's numbered variants an entity wears.
//!
//! A rule holds `textures.<n>` (or `skins.<n>`), the variant indices it chooses from (1 is the
//! default texture), their optional `weights.<n>`, and conditions on the entity. Rules are tried
//! in order of `<n>`; the first whose conditions all hold picks one of its textures from the
//! entity's seed, so the same entity keeps the same texture. No rule matching means the default.
//!
//! Conditions: `biomes`, `heights` (and the legacy `minHeight`/`maxHeight`), `name` (and ETF's
//! `names`), `professions`, `colors` (`collarColors`), `baby`, `health` (in points or percent),
//! `moonPhase`, `dayTime`, `weather`, `sizes` and `blocks`. The spawn-time ones (biome, height,
//! block, moon, time, weather) are the caller's to fix when the entity is first seen; the others
//! can change, and [`Rules::updates`] says whether a rule file reads any of them.
//!
//! Written from OptiFine's `random_entities.properties` and ETF's `RANDOM_GUIDE.md` and
//! `random_entities.properties` docs; no mod's source was read.

// use crate::matchers::{BlockMatch, Name, RangeList, namespaced};
// use crate::properties::Properties;

/// The most variants one rule lists (`textures.1=1-100000` stays small).
pub const MAX_TEXTURES: usize = 256;
/// The most rules one file holds.
pub const MAX_RULES: usize = 1024;

/// What a rule can ask about an entity. `None` is a fact the entity doesn't have (a creeper's
/// profession): a rule asking for it doesn't match.
pub const Facts = struct {
    /// Where the entity was first seen: its biome (`minecraft:plains`) and block height.
    biome: ?*'a str,
    y: ?i32,
    /// The block it stood on and the block it stood in when first seen (ETF checks both); empty
    /// when unknown, which fails a `blocks` rule.
    blocks: *'a [Block<'a>],
    /// Its custom name, with `§` formatting codes where the name has them (rules may ask for
    /// `\u00a74Pinky`).
    name: ?*'a str,
    /// Villager profession (`minecraft:farmer`) and level.
    profession: Option<(*'a str,
    /// Collar, wool, carpet or shell colour, as a dye name (`light_blue`).
    color: ?*'a str,
    baby: ?bool,
    /// Health and max health.
    health: Option<(f32,
    /// When first seen: moon phase (0-7), time of day (0-23999) and weather.
    moon_phase: ?i32,
    day_time: ?i32,
    weather: ?Weather,
    /// Slime, magma cube or phantom size as the docs number it: 0 small, 1 medium, 3 big.
    size: ?i32,
};

/// A block and the values of its state properties.
pub const Block = struct {
    id: *'a str,
    states: *'a [(*'a str,
};

pub const Weather = enum {
    Clear,
    Rain,
    Thunder,
};

/// One `.properties` file's rules, in order.
pub const Rules = struct {
    rules: std.ArrayList(Rule),
};

pub const Rule = struct {
    /// Variant indices; 1 is the default texture.
    textures: std.ArrayList(u32),
    /// Same length as `textures`, or empty for an even choice.
    weights: std.ArrayList(u32),
    /// ETF's `seedOffset`: added to the entity's seed.
    seed_offset: i32,
    /// Ids (`plains`, `mymod:bog`), or ETF's `pattern:`/`regex:` forms; each with `!`.
    biomes: Vec<(Name,
    heights: ?RangeList,
    /// Each with whether it is negated (`!`).
    names: Vec<(Name,
    professions: Vec<([]const u8,
    colors: ?std.ArrayList([]const u8),
    baby: ?bool,
    health: Option<(RangeList,
    moon_phase: ?RangeList,
    day_time: ?RangeList,
    weather: ?std.ArrayList(Weather),
    sizes: ?RangeList,
    blocks: Vec<(BlockMatch,
};

/// The conditions a rule may hold, as `<key>.<n>`. A rule with any other (`nbt.<n>.*`, ETF's
/// `teams`, `items`...) is skipped rather than applied to every entity.
    // rust: const KEYS: &[&str] = &[
    // rust: "textures",
    // rust: "skins",
    // rust: "weights",
    // rust: "seedOffset",
    // rust: "seedSource",
    // rust: "biomes",
    // rust: "heights",
    // rust: "minHeight",
    // rust: "maxHeight",
    // rust: "name",
    // rust: "names",
    // rust: "professions",
    // rust: "colors",
    // rust: "collarColors",
    // rust: "baby",
    // rust: "health",
    // rust: "moonPhase",
    // rust: "dayTime",
    // rust: "weather",
    // rust: "sizes",
    // rust: "blocks",
    // rust: ];

    // rust: impl Rules {
pub fn parse(props: *Properties) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut numbers: Vec<u32> = ["textures.", "skins."]
    // rust: .iter()
    // rust: .flat_map(|p| props.with_prefix(p))
    // rust: .filter_map(|(n, _)| n.parse().ok())
    // rust: .collect();
    // rust: numbers.sort_unstable();
    // rust: numbers.dedup();
        // Each rule reads every entry: a file of thousands of rules stops at the first MAX_RULES.
    // rust: numbers.truncate(MAX_RULES);
    // rust: let rules = numbers
    // rust: .into_iter()
    // rust: .filter_map(|n| Rule::parse(props, n))
    // rust: .collect();
    // rust: Self { rules }
}

    /// The first matching rule's pick, or 1 when none matches. [`Rules::matching`] tells a miss
    /// (the texture itself, as is a rule's 0) from a pick of 1, which `<name>1.png` replaces.
pub fn select(self: *Self, facts: *Facts, seed: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.matching(facts, seed).unwrap_or(1)
}

    /// The first matching rule's pick, `None` when no rule matches: the texture itself, even
    /// where a `<name>1.png` replaces variant 1 (ETF).
pub fn matching(self: *Self, facts: *Facts, seed: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rules
    // rust: .iter()
    // rust: .find(|r| r.matches(facts))
    // rust: .map(|r| r.pick(seed))
}

    /// Whether any rule reads a fact that changes while the entity lives (name, profession,
    /// colour, baby, health), so the choice should be checked again now and then.
pub fn updates(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rules.iter().any(|r| {
    // rust: !r.names.is_empty()
    // rust: || !r.professions.is_empty()
    // rust: || r.colors.is_some()
    // rust: || r.baby.is_some()
    // rust: || r.health.is_some()
    // rust: })
}

    /// The highest variant index any rule lists (at most [`MAX_INDEX`]).
pub fn max_texture(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rules
    // rust: .iter()
    // rust: .flat_map(|r| r.textures.iter().copied())
    // rust: .max()
    // rust: .unwrap_or(1)
}
}

    // rust: impl Rule {
    /// `None` when the rule lists no textures, or holds a condition that doesn't parse or isn't
    /// supported: such a rule never matches, instead of matching every entity.
pub fn parse(props: *Properties, n: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
        // This rule's keys, `<key>.<n>` or `nbt.<n>.<path>` (a path may end in a list index:
        // `nbt.2.Tags.1`): one unknown, or an empty condition (`biomes.1=`), skips the rule. An
        // empty `weights` is only no weights.
    // rust: let unusable = props.entries.iter().any(|(key, value)| {
    // rust: let mut parts = key.splitn(3, '.');
    // rust: let (Some(head), Some(index)) = (parts.next(), parts.next()) else {
    // rust: return false;
}
    // rust: index.parse::<u32>() == Ok(n)
    // rust: && (!KEYS.contains(&head)
    // rust: || (value.is_empty() && !matches!(head, "textures" | "skins" | "weights")))
    // rust: });
    // rust: let get = |key: &str| props.get(&format!("{key}.{n}"));
        // ETF's `seedSource`: only the entity's own seed is read.
    // rust: if unusable || get("seedSource").is_some_and(|v| v != "entity") {
    // rust: return None;
}
        // `Some(None)` for a missing key, `None` for one that doesn't parse.
    // rust: fn read<T>(
    // rust: value: Option<&str>,
    // rust: parse: impl FnOnce(&str) -> Option<T>,
    // rust: ) -> Option<Option<T>> {
    // rust: match value {
    // rust: None => Some(None),
    // rust: Some(v) => parse(v).map(Some),
}
}
    // rust: let textures = expand(&RangeList::parse(get("textures").or(get("skins"))?)?);
    // rust: if textures.is_empty() {
    // rust: return None;
}
    // rust: let weights = get("weights")
    // rust: .and_then(RangeList::parse)
    // rust: .map(|w| w.0.iter().map(|&(lo, _)| lo.max(0) as u32).collect())
    // rust: .filter(|w: &Vec<u32>| w.len() == textures.len() && w.iter().any(|&w| w > 0))
    // rust: .unwrap_or_default();
    // rust: let ranges = |key| read(get(key), RangeList::parse);
    // rust: let heights = match ranges("heights")? {
    // rust: Some(h) => Some(h),
    // rust: None => {
    // rust: let min = read(get("minHeight"), |v| v.parse().ok())?;
    // rust: let max = read(get("maxHeight"), |v| v.parse().ok())?;
    // rust: (min.is_some() || max.is_some())
    // rust: .then(|| RangeList(vec![(min.unwrap_or(i32::MIN), max.unwrap_or(i32::MAX))]))
}
}
    // rust: let mut names = Vec::new();
    // rust: if let Some(v) = get("name") {
    // rust: let (v, negated) = negation(v)?;
    // rust: names.push((Name::parse(v)?, negated));
}
    // rust: for (word, negated) in quoted_words(get("names").unwrap_or("")) {
    // rust: if word.is_empty() {
    // rust: return None;
}
    // rust: names.push((Name::parse(word)?, negated));
}
    // rust: Some(Self {
    // rust: textures,
    // rust: weights,
    // rust: seed_offset: read(get("seedOffset"), |v| v.parse().ok())?.unwrap_or(0),
    // rust: biomes: read(get("biomes"), |v| {
    // rust: v.split_whitespace()
    // rust: .map(|b| {
    // rust: let (b, negated) = negation(b)?;
    // rust: let name = match Name::parse(b)? {
    // rust: Name::Exact(id) => Name::Exact(namespaced(&id)),
    // rust: pattern => pattern,
}
    // rust: Some((name, negated))
    // rust: })
    // rust: .collect()
    // rust: })?
    // rust: .unwrap_or_default(),
    // rust: heights,
    // rust: names,
    // rust: professions: read(get("professions"), parse_professions)?.unwrap_or_default(),
    // rust: colors: get("colors")
    // rust: .or(get("collarColors"))
    // rust: .map(|v| v.split_whitespace().map(str::to_ascii_lowercase).collect()),
    // rust: baby: read(get("baby"), parse_bool)?,
    // rust: health: read(get("health"), |v| {
    // rust: Some((RangeList::parse(&v.replace('%', ""))?, v.contains('%')))
    // rust: })?,
    // rust: moon_phase: ranges("moonPhase")?,
    // rust: day_time: ranges("dayTime")?,
    // rust: weather: read(get("weather"), |v| {
    // rust: v.split_whitespace()
    // rust: .map(|w| match w.to_ascii_lowercase().as_str() {
    // rust: "clear" => Some(Weather::Clear),
    // rust: "rain" => Some(Weather::Rain),
    // rust: "thunder" => Some(Weather::Thunder),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
    // rust: })?,
    // rust: sizes: ranges("sizes")?,
    // rust: blocks: read(get("blocks"), |v| {
    // rust: v.split_whitespace()
    // rust: .map(|b| {
    // rust: let (b, negated) = negation(b)?;
    // rust: Some((BlockMatch::parse(b)?, negated))
    // rust: })
    // rust: .collect()
    // rust: })?
    // rust: .unwrap_or_default(),
    // rust: })
}

pub fn matches(self: *Self, f: *Facts) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ranged = |list: &Option<RangeList>, fact: Option<i32>| {
    // rust: list.as_ref()
    // rust: .is_none_or(|l| fact.is_some_and(|v| l.contains(v)))
}
    // rust: (self.biomes.is_empty()
    // rust: || f.biome.is_some_and(|b| {
    // rust: let b = namespaced(b);
    // rust: let path = b.split_once(':').map_or(b.as_str(), |(_, p)| p);
    // rust: included(&self.biomes, |n| n.matches(&b) || n.matches(path))
    // rust: }))
    // rust: && ranged(&self.heights, f.y)
    // rust: && (self.names.is_empty()
    // rust: || match f.name {
    // rust: Some(name) => included(&self.names, |n| n.matches(name)),
                    // An unnamed entity is no listed name: it passes only `!` entries.
    // rust: None => self.names.iter().all(|(_, negated)| *negated),
    // rust: })
    // rust: && (self.professions.is_empty()
    // rust: || f.profession.is_some_and(|(p, level)| {
    // rust: let p = namespaced(p);
    // rust: self.professions.iter().any(|(want, levels)| {
    // rust: *want == p && levels.as_ref().is_none_or(|l| l.contains(level))
    // rust: })
    // rust: }))
    // rust: && self
    // rust: .colors
    // rust: .as_ref()
    // rust: .is_none_or(|c| f.color.is_some_and(|f| c.iter().any(|c| c == f)))
    // rust: && self.baby.is_none_or(|b| f.baby == Some(b))
    // rust: && self.health.as_ref().is_none_or(|(l, percent)| {
    // rust: f.health.is_some_and(|(health, max)| {
    // rust: let value = if *percent {
    // rust: health * 100.0 / max.max(f32::MIN_POSITIVE)
    // rust: } else {
    // rust: health
}
    // rust: l.contains(value as i32)
    // rust: })
    // rust: })
    // rust: && ranged(&self.moon_phase, f.moon_phase)
    // rust: && ranged(&self.day_time, f.day_time)
    // rust: && self
    // rust: .weather
    // rust: .as_ref()
    // rust: .is_none_or(|w| f.weather.is_some_and(|f| w.contains(&f)))
    // rust: && ranged(&self.sizes, f.size)
    // rust: && (self.blocks.is_empty()
    // rust: || (!f.blocks.is_empty()
    // rust: && included(&self.blocks, |m| {
    // rust: f.blocks.iter().any(|b| {
    // rust: m.matches(b.id, |key| {
    // rust: b.states.iter().find(|(k, _)| *k == key).map(|(_, v)| *v)
    // rust: })
    // rust: })
    // rust: })))
}

    /// One of the rule's textures, by weight, from the entity's seed. OptiFine's docs don't say
    /// how the seed becomes a choice: this is Horizon's, the seed's magnitude modulo the total.
pub fn pick(self: *Self, seed: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = seed.wrapping_add(self.seed_offset).unsigned_abs();
    // rust: if self.weights.is_empty() {
    // rust: return self.textures[r as usize % self.textures.len()];
}
    // rust: let total: u64 = self.weights.iter().map(|&w| u64::from(w)).sum();
    // rust: let mut left = u64::from(r) % total;
    // rust: for (&texture, &weight) in self.textures.iter().zip(&self.weights) {
    // rust: if left < u64::from(weight) {
    // rust: return texture;
}
    // rust: left -= u64::from(weight);
}
    // rust: unreachable!("left < total")
}
}

/// An entity's seed from its UUID (most then least significant 64 bits): Java's
/// `UUID.hashCode`, so it is fixed for the entity's whole life, on every client.
pub fn seed(most: i64, least: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = most ^ least;
    // rust: ((x >> 32) ^ x) as i32
}

/// The highest variant index a rule may name (`textures.1=2000000000` is dropped).
pub const MAX_INDEX: u32 = 1024;

pub fn expand(list: *RangeList) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: for &(lo, hi) in &list.0 {
    // rust: for i in lo.max(0)..=hi.min(MAX_INDEX as i32) {
    // rust: if out.len() == MAX_TEXTURES {
    // rust: return out;
}
    // rust: out.push(i as u32);
}
}
    // rust: out
}

/// A value and whether it starts with `!`; `None` for a `!` with nothing after it.
pub fn negation(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value.strip_prefix('!') {
    // rust: Some("") => None,
    // rust: Some(v) => Some((v, true)),
    // rust: None => Some((value, false)),
}
}

pub fn parse_bool(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value.to_ascii_lowercase().as_str() {
    // rust: "true" => Some(true),
    // rust: "false" => Some(false),
    // rust: _ => None,
}
}

/// Words split on spaces, a `"double quoted"` group kept as one word (ETF's `names`), each
/// with whether it starts with `!` (`!Bob`, `!"Blue Team"`).
pub fn quoted_words(value: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rest = value.trim_start();
    // rust: std::iter::from_fn(move || {
    // rust: if rest.is_empty() {
    // rust: return None;
}
    // rust: let (r, negated) = rest.strip_prefix('!').map_or((rest, false), |r| (r, true));
    // rust: let (word, after) = match r.strip_prefix('"') {
    // rust: Some(q) => q.split_once('"').unwrap_or((q, "")),
    // rust: None => r.split_once(' ').unwrap_or((r, "")),
}
    // rust: rest = after.trim_start();
    // rust: Some((word, negated))
    // rust: })
}

/// `farmer librarian:1,3-4 minecraft:fisherman mymod:mayor:2`; `None` if a level list is bad.
pub fn parse_professions(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value
    // rust: .split_whitespace()
    // rust: .map(|entry| match entry.rsplit_once(':') {
    // rust: Some((name, levels)) if levels.starts_with(|c: char| c.is_ascii_digit()) => {
    // rust: Some((namespaced(name), Some(RangeList::parse(levels)?)))
}
    // rust: _ => Some((namespaced(entry), None)),
    // rust: })
    // rust: .collect()
}

/// A list of (entry, negated): some entry that isn't negated hits (when there is one), and no
/// negated one does. `!red !blue` excludes both.
    // rust: fn included<T>(list: &[(T, bool)], hit: impl Fn(&T) -> bool) -> bool {
    // rust: let mut wanted = list.iter().filter(|(_, negated)| !negated).peekable();
    // rust: let any_wanted = wanted.peek().is_none() || wanted.any(|(e, _)| hit(e));
    // rust: any_wanted && !list.iter().any(|(e, negated)| *negated && hit(e))
}

    // rust: mod tests {
//     use super::*;

pub fn rules(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rules::parse(&Properties::parse(text))
}

pub fn first_matching_rule_wins_and_weights_split_seeds() void {
}
        // OptiFine's own creeper example.
    // rust: let r = rules(
    // rust: "textures.1=10-14\nweights.1=10 10 10 3 10\nheights.1=0-55\n\
    // rust: textures.2=5 7 9\nbiomes.2=desert forest\nheights.2=80-255\n\
    // rust: textures.3=1-4 6 8 15-20\n",
    // rust: );
    // rust: assert_eq!(r.rules.len(), 3);
    // rust: assert_eq!(r.max_texture(), 20);
    // rust: assert!(!r.updates());
    // rust: let underground = Facts {
    // rust: y: Some(30),
    // rust: biome: Some("minecraft:plains"),
    // rust: ..Default::default()
}
        // Weights 10 10 10 3 10 out of 43: seed % 43 in 30..33 is the fourth texture.
    // rust: assert_eq!(r.select(&underground, 0), 10);
    // rust: assert_eq!(r.select(&underground, 31), 13);
    // rust: assert_eq!(r.select(&underground, 42), 14);
    // rust: assert_eq!(r.select(&underground, 43 + 25), 12);
    // rust: let hills = Facts {
    // rust: y: Some(100),
    // rust: biome: Some("minecraft:desert"),
    // rust: ..Default::default()
}
    // rust: assert_eq!(r.select(&hills, 4), 7, "4 % 3 = 1: the second of 5 7 9");
        // Plains at 100 falls to rule 3's 12 textures: 1 2 3 4 6 8 15..20.
    // rust: let plains = Facts {
    // rust: biome: Some("plains"),
    // rust: ..hills.clone()
}
    // rust: assert_eq!(r.select(&plains, 5), 8);
    // rust: assert_eq!(r.select(&plains, -6), 15, "|-6| % 12 = 6");
        // No facts at all: height-bound rules fail, the fallback still applies.
    // rust: assert_eq!(r.select(&Facts::default(), 1), 2);
}

pub fn no_rule_matching_is_the_default() void {
}
    // rust: let r = rules("skins.1=2 3\nbaby.1=true\n");
    // rust: assert!(r.updates());
    // rust: assert_eq!(r.select(&Facts::default(), 1), 1);
    // rust: let baby = Facts {
    // rust: baby: Some(true),
    // rust: ..Default::default()
}
    // rust: assert_eq!(r.select(&baby, 1), 3);
        // `matching` tells a miss from a rule that picks 1.
    // rust: assert_eq!(r.matching(&Facts::default(), 1), None);
    // rust: assert_eq!(r.matching(&baby, 1), Some(3));
    // rust: assert_eq!(rules("textures.1=1").matching(&baby, 0), Some(1));
}

pub fn conditions() void {
}
    // rust: let check = |text: &str, facts: Facts| rules(text).select(&facts, 0) == 2;
    // rust: let named = |name| Facts {
    // rust: name: Some(name),
    // rust: ..Default::default()
}
    // rust: assert!(check("textures.1=2\nname.1=ipattern:pink*", named("Pinky")));
    // rust: assert!(!check("textures.1=2\nname.1=!Pinky", named("Pinky")));
    // rust: assert!(check("textures.1=2\nname.1=!Pinky", named("Bob")));
    // rust: assert!(check(
    // rust: "textures.1=2\nnames.1=Bob \"John Smith\"",
    // rust: named("John Smith")
    // rust: ));
    // rust: assert!(!check(
    // rust: "textures.1=2\nnames.1=Bob \"John Smith\"",
    // rust: named("John")
    // rust: ));

    // rust: let villager = |p, level| Facts {
    // rust: profession: Some((p, level)),
    // rust: ..Default::default()
}
    // rust: let prof = "textures.1=2\nprofessions.1=farmer minecraft:librarian:1,3-4 mymod:mayor:2";
    // rust: assert!(check(prof, villager("minecraft:farmer", 5)));
    // rust: assert!(check(prof, villager("librarian", 3)));
    // rust: assert!(!check(prof, villager("librarian", 2)));
    // rust: assert!(check(prof, villager("mymod:mayor", 2)));
    // rust: assert!(!check(prof, Facts::default()));

    // rust: let hurt = |health| Facts {
    // rust: health: Some((health, 40.0)),
    // rust: ..Default::default()
}
    // rust: assert!(check("textures.1=2\nhealth.1=0-50%", hurt(20.0)));
    // rust: assert!(!check("textures.1=2\nhealth.1=0-50%", hurt(21.0)));
    // rust: assert!(check("textures.1=2\nhealth.1=5-8 10-12", hurt(11.5)));
    // rust: assert!(!check("textures.1=2\nhealth.1=5-8 10-12", hurt(9.0)));
        // 53 of 100 is 53%, though 53 / 100 * 100 is 52.999996 in f32.
    // rust: let golem = Facts {
    // rust: health: Some((53.0, 100.0)),
    // rust: ..Default::default()
}
    // rust: assert!(check("textures.1=2\nhealth.1=53-100%", golem));

    // rust: let colored = |c| Facts {
    // rust: color: Some(c),
    // rust: ..Default::default()
}
    // rust: assert!(check(
    // rust: "textures.1=2\ncollarColors.1=pink magenta",
    // rust: colored("pink")
    // rust: ));
    // rust: assert!(!check(
    // rust: "textures.1=2\ncolors.1=pink magenta",
    // rust: colored("red")
    // rust: ));

    // rust: let world = Facts {
    // rust: moon_phase: Some(3),
    // rust: day_time: Some(18500),
    // rust: weather: Some(Weather::Thunder),
    // rust: size: Some(3),
    // rust: y: Some(-40),
    // rust: ..Default::default()
}
    // rust: assert!(check(
    // rust: "textures.1=2\nmoonPhase.1=0-3\ndayTime.1=0-1000 18000-24000\n\
    // rust: weather.1=rain thunder\nsizes.1=3\nheights.1=(-64)-(-30)",
    // rust: world.clone()
    // rust: ));
    // rust: assert!(!check("textures.1=2\nweather.1=clear", world.clone()));
    // rust: assert!(check(
    // rust: "textures.1=2\nminHeight.1=-50\nmaxHeight.1=-40",
    // rust: world.clone()
    // rust: ));
    // rust: assert!(!check("textures.1=2\nminHeight.1=-39", world.clone()));
        // Each world condition alone, failing.
    // rust: for rule in [
    // rust: "moonPhase.1=4-7",
    // rust: "dayTime.1=0-18000",
    // rust: "sizes.1=0 1",
    // rust: "heights.1=-64--41",
    // rust: "colors.1=pink",
    // rust: "collarColors.1=pink",
    // rust: "baby.1=false",
    // rust: ] {
    // rust: assert!(
    // rust: !check(&format!("textures.1=2\n{rule}"), world.clone()),
    // rust: "{rule}"
    // rust: );
}
        // ETF's bare negative height range.
    // rust: assert!(check("textures.1=2\nheights.1=-64--30", world));
}

pub fn name_lists() void {
}
    // rust: let r = rules("textures.1=2\nnames.1=!Bob !\"Blue Team\"");
    // rust: let pick = |name| {
    // rust: r.select(
    // rust: &Facts {
    // rust: name,
    // rust: ..Default::default()
    // rust: },
    // rust: 0,
    // rust: )
}
    // rust: assert_eq!(pick(Some("Bob")), 1, "negated entries exclude");
    // rust: assert_eq!(pick(Some("Blue Team")), 1);
    // rust: assert_eq!(pick(Some("Green")), 2);
    // rust: assert_eq!(pick(None), 2, "an unnamed entity is neither");
    // rust: let r = rules("textures.1=2\nname.1=pattern:*");
    // rust: assert_eq!(
    // rust: r.select(&Facts::default(), 0),
    // rust: 1,
    // rust: "an unnamed entity has no name"
    // rust: );
}

pub fn biome_lists() void {
}
    // rust: let pick = |text: &str, biome| {
    // rust: rules(text).select(
    // rust: &Facts {
    // rust: biome: Some(biome),
    // rust: ..Default::default()
    // rust: },
    // rust: 0,
    // rust: )
}
    // rust: let not_wet = "textures.1=2\nbiomes.1=!ipattern:*OCEAN* !mymod:bog";
    // rust: assert_eq!(pick(not_wet, "minecraft:deep_ocean"), 1);
    // rust: assert_eq!(pick(not_wet, "mymod:bog"), 1);
    // rust: assert_eq!(pick(not_wet, "minecraft:bog"), 2);
    // rust: assert_eq!(pick(not_wet, "plains"), 2);
        // A pattern matches the id with or without its namespace.
    // rust: let some = "textures.1=2\nbiomes.1=pattern:deep_* Desert";
    // rust: assert_eq!(pick(some, "minecraft:deep_dark"), 2);
    // rust: assert_eq!(pick(some, "desert"), 2);
    // rust: assert_eq!(pick(some, "minecraft:dark_forest"), 1);
}

pub fn rules_run_in_number_order_with_their_seed_offset() void {
}
        // Written 10 before 9: rule 9 is tried first.
    // rust: let r = rules("textures.10=5\ntextures.9=2 3 4\nseedOffset.9=1\n");
    // rust: assert_eq!(r.select(&Facts::default(), 0), 3, "(0 + 1) % 3: the second");
    // rust: assert_eq!(r.select(&Facts::default(), 2), 2, "(2 + 1) % 3: the first");
        // `textures` wins over `skins` in the same rule.
    // rust: assert_eq!(
    // rust: rules("textures.1=4\nskins.1=5").select(&Facts::default(), 0),
    // rust: 4
    // rust: );
}

pub fn changing_facts_need_rechecks() void {
}
    // rust: for rule in [
    // rust: "name.1=Bob",
    // rust: "names.1=Bob",
    // rust: "professions.1=farmer",
    // rust: "colors.1=red",
    // rust: "baby.1=true",
    // rust: "health.1=1-5",
    // rust: ] {
    // rust: assert!(rules(&format!("textures.1=2\n{rule}")).updates(), "{rule}");
}
    // rust: assert!(!rules("textures.1=2\nbiomes.1=desert\nweather.1=rain").updates());
}

pub fn blocks() void {
}
    // rust: let r = rules("textures.1=2\nblocks.1=sand oak_log:axis=y\ntextures.2=3\nblocks.2=!stone");
    // rust: let pick = |blocks: &[Block]| {
    // rust: r.select(
    // rust: &Facts {
    // rust: blocks,
    // rust: ..Default::default()
    // rust: },
    // rust: 0,
    // rust: )
}
    // rust: let block = |id| Block { id, states: &[] };
    // rust: assert_eq!(pick(&[block("minecraft:sand"), block("minecraft:air")]), 2);
    // rust: let upright = [Block {
    // rust: id: "minecraft:oak_log",
    // rust: states: &[("axis", "y")],
    // rust: }];
    // rust: assert_eq!(pick(&upright), 2);
    // rust: let sideways = [Block {
    // rust: id: "minecraft:oak_log",
    // rust: states: &[("axis", "x")],
    // rust: }];
    // rust: assert_eq!(pick(&sideways), 3, "rule 2: anything but stone");
    // rust: assert_eq!(pick(&[block("minecraft:stone")]), 1);
    // rust: assert_eq!(pick(&[]), 1, "no blocks known: not even `!stone` holds");
}

pub fn broken_rules_are_skipped() void {
}
    // rust: let r = rules(
    // rust: "textures.1=abc\nbiomes.1=desert\n\
    // rust: skins.7=1-100000\n\
    // rust: textures.9=2000000000\n",
    // rust: );
        // Rule 7 stops at 256 textures, and rule 9's index is past MAX_INDEX.
    // rust: assert_eq!(r.max_texture(), 256);
    // rust: assert_eq!(r.select(&Facts::default(), 300), 300 % 256 + 1);
        // One weight for two textures, only zeros, or none: an even choice.
    // rust: for weights in ["5", "0 0", ""] {
    // rust: let r = rules(&format!("textures.1=2 3\nweights.1={weights}"));
    // rust: assert_eq!(r.select(&Facts::default(), 1), 3, "{weights}");
}
}

pub fn rules_stop_at_max_rules() void {
}
    // rust: let text: String = (1..=MAX_RULES + 5)
    // rust: .map(|n| format!("textures.{n}=2\nbaby.{n}=true\n"))
    // rust: .chain(["textures.99999=3\n".to_owned()])
    // rust: .collect();
    // rust: let r = rules(&text);
    // rust: assert_eq!(r.rules.len(), MAX_RULES);
        // Rule 99999 would match an adult; it is past the cap.
    // rust: let adult = Facts {
    // rust: baby: Some(false),
    // rust: ..Default::default()
}
    // rust: assert_eq!(r.select(&adult, 0), 1);
}

pub fn bad_or_unknown_conditions_never_match() void {
}
        // Each would match every entity if the condition were dropped.
    // rust: for rule in [
    // rust: "heights.1=0-55 x",
    // rust: "moonPhase.1=full",
    // rust: "baby.1=yes",
    // rust: "health.1=5.5-8",
    // rust: "professions.1=librarian:1,x",
    // rust: "weather.1=snow",
    // rust: "name.1=regex:(",
    // rust: "names.1=Bob regex:(",
    // rust: "minHeight.1=low",
    // rust: "nbt.1.CustomName=Bob",
    // rust: "teams.1=red",
    // rust: "seedSource.1=vehicle",
    // rust: "biomes.1=",
    // rust: "names.1=",
    // rust: "biomes.1=regex:(",
    // rust: "biomes.1=!",
    // rust: "blocks.1=!",
    // rust: "name.1=!",
    // rust: "names.1=Bob !",
    // rust: ] {
    // rust: let r = rules(&format!("textures.1=2\n{rule}\ntextures.2=3"));
            // A named mob in plains: what a dropped `!` entry would let through.
    // rust: let bob = Facts {
    // rust: biome: Some("minecraft:plains"),
    // rust: name: Some("Bob"),
    // rust: ..Default::default()
}
    // rust: assert_eq!(r.select(&bob, 0), 3, "{rule}");
}
        // Case doesn't matter where Java's parsers ignore it.
    // rust: let baby = Facts {
    // rust: baby: Some(true),
    // rust: weather: Some(Weather::Rain),
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: rules("textures.1=2\nbaby.1=TRUE\nweather.1=Rain").select(&baby, 0),
    // rust: 2
    // rust: );
        // Another rule's nbt path ending in a list index leaves rule 1 alone.
    // rust: let r = rules("textures.1=2\nseedSource.1=entity\ntextures.2=3\nnbt.2.Tags.1=foo");
    // rust: assert_eq!(r.select(&Facts::default(), 0), 2);
}

pub fn seeds_are_java_uuid_hash_codes() void {
}
        // new UUID(0x0123456789abcdefL, 0xfedcba9876543210L).hashCode():
        // msb ^ lsb = 0xffffffffffffffff, high ^ low = 0.
    // rust: assert_eq!(
    // rust: seed(0x0123_4567_89ab_cdef, 0xfedc_ba98_7654_3210_u64 as i64),
    // rust: 0
    // rust: );
        // new UUID(1, 2).hashCode() = 3, and new UUID(1L << 32, 0) is 1.
    // rust: assert_eq!(seed(1, 2), 3);
    // rust: assert_eq!(seed(1 << 32, 0), 1);
}
}
