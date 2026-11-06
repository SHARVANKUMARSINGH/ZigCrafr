//! Transpiled from Horizon Rust crate
package horizon_optifine_matchers

import "core:fmt"
import "core:mem"
import "core:math"

// The values OptiFine's `.properties` match against: names (`pattern:`, `ipattern:`, `regex:`,
// `iregex:` or exact), integer range lists (`heights`, `damage`, `stackSize`), id lists
// (`items`, OptiFine's plain `biomes`) and block lists with block states (`matchBlocks`, `blocks`).

// use regex::{Regex, RegexBuilder};

// A name test: custom names (`name`, `nbt.display.Name`), entity names, NBT strings.
Name :: enum {
    Exact(String),
    // `pattern:` (`*` any run, `?` one character); `ipattern:` ignores case.
    Glob {,
    pattern: String,
    ignore_case: bool,
    // rust: },
    // `regex:` and `iregex:`, matched against the whole name as Java's `String.matches`.
    Regex(Regex),
}

    // rust: impl Name {
    // `None` for a regex that does not compile.
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let glob = |pattern: &str, ignore_case| Name::Glob {
    // rust: pattern: pattern.to_owned(),
    // rust: ignore_case,
}
    // rust: let regex = |re: &str, ignore_case| {
            // On its own first: a stray `)` would otherwise close the anchoring group early.
    // rust: Regex::new(re).ok()?;
    // rust: RegexBuilder::new(&format!("^(?:{re})$"))
    // rust: .case_insensitive(ignore_case)
    // rust: .build()
    // rust: .ok()
    // rust: .map(Name::Regex)
}
    // rust: if let Some(p) = value.strip_prefix("pattern:") {
    // rust: Some(glob(p, false))
    // rust: } else if let Some(p) = value.strip_prefix("ipattern:") {
    // rust: Some(glob(p, true))
    // rust: } else if let Some(r) = value.strip_prefix("regex:") {
    // rust: regex(r, false)
    // rust: } else if let Some(r) = value.strip_prefix("iregex:") {
    // rust: regex(r, true)
    // rust: } else {
    // rust: Some(Name::Exact(value.to_owned()))
}
}

matches :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Name::Exact(n) => n == name,
    // rust: Name::Regex(re) => re.is_match(name),
    // rust: Name::Glob {
    // rust: pattern,
    // rust: ignore_case: false,
    // rust: } => glob(
    // rust: &pattern.chars().collect::<Vec<_>>(),
    // rust: &name.chars().collect::<Vec<_>>(),
    // rust: ),
    // rust: Name::Glob {
    // rust: pattern,
    // rust: ignore_case: true,
    // rust: } => glob(
    // rust: &pattern.to_lowercase().chars().collect::<Vec<_>>(),
    // rust: &name.to_lowercase().chars().collect::<Vec<_>>(),
    // rust: ),
}
}
}

// `*` any run, `?` one character, the whole name. Star backtracking: on a mismatch only the
// last `*` takes one more character, so it runs in O(pattern × name), whatever the stars (a
// name comes from whoever named the item, and this runs per item per frame).
glob :: proc(p: ^[char], s: ^[char]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (mut pi, mut si) = (0, 0);
    // rust: let mut star: Option<(usize, usize)> = None;
    // rust: while si < s.len() {
    // rust: match p.get(pi) {
    // rust: Some('*') => {
    // rust: star = Some((pi, si));
    // rust: pi += 1;
}
    // rust: Some(&c) if c == '?' || c == s[si] => {
    // rust: pi += 1;
    // rust: si += 1;
}
    // rust: _ => match star {
    // rust: Some((sp, ss)) => {
    // rust: pi = sp + 1;
    // rust: si = ss + 1;
    // rust: star = Some((sp, ss + 1));
}
    // rust: None => return false,
    // rust: },
}
}
    // rust: p[pi..].iter().all(|&c| c == '*')
}

// `1 3-5 8-`, separated by spaces or commas; a negative bound is written in parentheses:
// `(-64)-0`, or bare as ETF also reads it: `-64--30`. An open upper bound (`8-`) runs to
// `i32::MAX`.
RangeList :: struct {

    // rust: impl RangeList {
    // `None` when a token is not a number or a range.
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for token in value.split([' ', ',']).filter(|t| !t.is_empty()) {
    // rust: let (low, rest) = bound(token)?;
    // rust: let range = match rest.strip_prefix('-') {
    // rust: None if rest.is_empty() => (low, low),
    // rust: Some("") => (low, i32::MAX),
    // rust: Some(high) => match bound(high)? {
    // rust: (high, "") => (low, high),
    // rust: _ => return None,
    // rust: },
    // rust: None => return None,
}
    // rust: out.push(range);
}
    // rust: Some(Self(out))
}

contains :: proc(self: ^Self, n: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter().any(|&(lo, hi)| (lo..=hi).contains(&n))
}
}

// A number at the start of `s`, bare (`5`, `-5`) or in parentheses, and what follows it.
bound :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(inner) = s.strip_prefix('(') {
    // rust: let (n, rest) = inner.split_once(')')?;
    // rust: return Some((n.trim().parse().ok()?, rest));
}
    // rust: let sign = usize::from(s.starts_with('-'));
    // rust: let end = s[sign..]
    // rust: .find(|c: char| !c.is_ascii_digit())
    // rust: .map_or(s.len(), |i| i + sign);
    // rust: Some((s[..end].parse().ok()?, &s[end..]))
}

// Resource ids (`biomes`, `items`, `entities`): `plains`, `minecraft:plains`, `mymod:x`,
// separated by whitespace; a `!` before an id excludes it. Ids are lowercased, and a bare id is
// in `minecraft:`.
IdList :: struct {
    include: [dynamic]string,
    exclude: [dynamic]string,
}

    // rust: impl IdList {
parse :: proc(value: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Self::default();
    // rust: for token in value.split_whitespace() {
    // rust: match token.strip_prefix('!') {
    // rust: Some(id) => out.exclude.push(namespaced(id)),
    // rust: None => out.include.push(namespaced(token)),
}
}
    // rust: out
}

    // An empty include list (only exclusions) admits everything not excluded.
matches :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = namespaced(id);
    // rust: (self.include.is_empty() || self.include.contains(&id)) && !self.exclude.contains(&id)
}
}

namespaced :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let id = id.to_ascii_lowercase();
    // rust: if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

// One entry of a block list: `oak_log`, `minecraft:oak_log`, `oak_log:axis=x,y`,
// `mymod:pillar:axis=y:waterlogged=false`. A state test admits any of its values.
BlockMatch :: struct {
    id: string,
    states: Vec<(string,
}

    // rust: impl BlockMatch {
    // Every entry of a whitespace-separated list. Legacy numeric ids, which name no block since
    // 1.13, are dropped.
parse_list :: proc(value: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: value.split_whitespace().filter_map(Self::parse).collect()
}

parse :: proc(entry: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (names, states): (Vec<&str>, Vec<&str>) =
    // rust: entry.split(':').partition(|s| !s.contains('='));
    // rust: let id = match names[..] {
    // rust: [name] => namespaced(name),
    // rust: [ns, name] => namespaced(&format!("{ns}:{name}")),
    // rust: _ => return None,
}
    // rust: if id.rsplit(':').next()?.bytes().all(|b| b.is_ascii_digit()) {
    // rust: return None;
}
    // rust: let states = states
    // rust: .iter()
    // rust: .map(|s| {
    // rust: let (key, values) = s.split_once('=').unwrap_or((s, ""));
    // rust: (
    // rust: key.to_owned(),
    // rust: values.split(',').map(str::to_owned).collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: Some(Self { id, states })
}

    // `state` answers a block state property's value.
    // rust: pub fn matches<'a>(&self, id: &str, state: impl Fn(&str) -> Option<&'a str>) -> bool {
    // rust: namespaced(id) == self.id
    // rust: && self
    // rust: .states
    // rust: .iter()
    // rust: .all(|(key, values)| state(key).is_some_and(|v| values.iter().any(|w| w == v)))
}
}

    // rust: mod tests {
//     use super::*;

names :: proc() {
}
    // rust: let m = |rule: &str, name: &str| Name::parse(rule).unwrap().matches(name);
    // rust: assert!(m("Dinnerbone", "Dinnerbone"));
    // rust: assert!(!m("Dinnerbone", "dinnerbone"));
    // rust: assert!(m("pattern:*Sword?", "Flame Sword!"));
    // rust: assert!(!m("pattern:*Sword?", "Flame sword!"));
    // rust: assert!(m("ipattern:*sword*", "FLAME SWORD of doom"));
    // rust: assert!(m("regex:Bob|Alice", "Alice"));
        // Java's String.matches: the whole name, not a substring.
    // rust: assert!(!m("regex:Bob|Alice", "Alice2"));
    // rust: assert!(m("iregex:j(eb)_", "JEB_"));
    // rust: assert!(Name::parse("regex:(").is_none());
    // rust: assert!(
    // rust: Name::parse("regex:Excalibur)|(.*").is_none(),
    // rust: "would match every name"
    // rust: );
    // rust: assert!(m("pattern:a*b*c", "aXbYc"));
    // rust: assert!(!m("pattern:a*b*c", "aXbY"));
    // rust: assert!(m("pattern:**", ""));
    // rust: assert!(!m("pattern:?", ""));
        // Many stars against a long name that never matches: linear, not exponential.
    // rust: let long = "a".repeat(5000);
    // rust: assert!(!m(&format!("pattern:{}b", "*a".repeat(20)), &long));
}

ranges :: proc() {
}
    // rust: let r = RangeList::parse("1 3-5,8- (-64)-(-10)").unwrap();
    // rust: for n in [1, 3, 4, 5, 8, 1000, -64, -10] {
    // rust: assert!(r.contains(n), "{n}");
}
    // rust: for n in [0, 2, 6, 7, -9, -65] {
    // rust: assert!(!r.contains(n), "{n}");
}
    // rust: assert!(RangeList::parse("-5").unwrap().contains(-5));
        // ETF's bare negative ranges.
    // rust: assert_eq!(
    // rust: RangeList::parse("-64--30 -5-2 -3-").unwrap().0,
    // rust: [(-64, -30), (-5, 2), (-3, i32::MAX)]
    // rust: );
    // rust: assert!(RangeList::parse("-").is_none());
    // rust: assert!(RangeList::parse("--5").is_none());
    // rust: assert!(RangeList::parse("1-x").is_none());
    // rust: assert!(RangeList::parse("abc").is_none());
}

id_lists :: proc() {
}
    // rust: let l = IdList::parse("Plains minecraft:desert mymod:bog");
    // rust: assert!(l.matches("minecraft:plains"));
    // rust: assert!(l.matches("desert"));
    // rust: assert!(l.matches("mymod:bog"));
    // rust: assert!(!l.matches("minecraft:bog"));
    // rust: let not_ocean = IdList::parse("!ocean !deep_ocean");
    // rust: assert!(not_ocean.matches("plains"));
    // rust: assert!(!not_ocean.matches("minecraft:deep_ocean"));
}

block_lists :: proc() {
}
    // rust: let list =
    // rust: BlockMatch::parse_list("glass minecraft:oak_log:axis=x,z mymod:pillar:axis=y 20");
    // rust: assert_eq!(list.len(), 3, "the numeric id 20 is dropped");
    // rust: let axis = |v: &'static str| move |k: &str| (k == "axis").then_some(v);
    // rust: assert!(list[0].matches("minecraft:glass", |_| None));
    // rust: assert!(list[1].matches("oak_log", axis("z")));
    // rust: assert!(!list[1].matches("oak_log", axis("y")));
    // rust: assert!(!list[1].matches("oak_log", |_| None));
    // rust: assert!(list[2].matches("mymod:pillar", axis("y")));
    // rust: assert!(!list[2].matches("minecraft:pillar", axis("y")));
}
}
