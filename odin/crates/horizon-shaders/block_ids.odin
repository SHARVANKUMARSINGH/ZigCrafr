//! Transpiled from Horizon Rust crate
package horizon_shaders_block_ids

import "core:fmt"
import "core:mem"
import "core:math"

// `block.properties` (spec 4.1): `block.<id>=<block> <block> ...`, each block
// `[namespace:]name` with optional state filters `:<property>=<v1>,<v2>`. Values in one filter
// are alternatives; separate filters must all match. Names the game does not know are simply
// never asked for. Block tags (`%tag`, tier E) are not read yet.

// use crate::Properties;

Rule :: struct {
    id: i32,
    // `minecraft:stone`.
    name: string,
    filters: Vec<(string,
}

// The ids `block.properties` gives block states.
BlockIds :: struct {
    rules: [dynamic]Rule,
    // Lines skipped and why.
    notes: [dynamic]string,
}

    // rust: impl BlockIds {
parse :: proc(properties: ^Properties) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::parse_kind(properties, "block")
}

    // The same for `<kind>.<id>=` lines: `entity` in `entity.properties`, `item` in
    // `item.properties` (4.1); names there carry no state filters.
parse_kind :: proc(properties: ^Properties, kind: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Self::default();
    // rust: let prefix = format!("{kind}.");
    // rust: for e in &properties.entries {
    // rust: let Some(id) = e.key.strip_prefix(prefix.as_str()) else {
    // rust: continue;
}
    // rust: let Ok(id) = id.parse::<i32>() else {
                // `layer.*` (4.2) and other keys are not ids.
    // rust: continue;
}
    // rust: for word in e.value.split_whitespace() {
    // rust: if word.starts_with('%') {
    // rust: out.notes.push(format!(
    // rust: "line {}: block tags are not read yet: {word}",
    // rust: e.line
    // rust: ));
    // rust: continue;
}
    // rust: let (names, filters): (Vec<&str>, Vec<&str>) =
    // rust: word.split(':').partition(|p| !p.contains('='));
    // rust: let name = match names[..] {
    // rust: [name] => format!("minecraft:{name}"),
    // rust: [namespace, name] => format!("{namespace}:{name}"),
    // rust: _ => {
    // rust: out.notes
    // rust: .push(format!("line {}: not a block name: {word}", e.line));
    // rust: continue;
}
}
    // rust: let filters = filters
    // rust: .iter()
    // rust: .filter_map(|f| f.split_once('='))
    // rust: .map(|(k, v)| (k.to_owned(), v.split(',').map(str::to_owned).collect()))
    // rust: .collect();
    // rust: out.rules.push(Rule { id, name, filters });
}
}
    // rust: out
}

    // The id of block `name` (`minecraft:stone`) in the state with `properties`. The rule with
    // the most filters that all match wins, then the first in the file (one name belongs to
    // one id; a filtered entry is the more specific one).
    // rust: pub fn id<'a>(&self, name: &str, properties: impl Fn(&str) -> Option<&'a str>) -> Option<i32> {
    // rust: self.rules
    // rust: .iter()
    // rust: .filter(|r| r.name == name)
    // rust: .filter(|r| {
    // rust: r.filters
    // rust: .iter()
    // rust: .all(|(k, vs)| properties(k).is_some_and(|v| vs.iter().any(|x| x == v)))
    // rust: })
    // rust: .min_by_key(|r| std::cmp::Reverse(r.filters.len()))
    // rust: .map(|r| r.id)
}

    // Every name without state filters and its id (the first line naming it wins): what
    // `entity.properties` and `item.properties` hold.
plain :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = std::collections::HashMap::new();
    // rust: for r in self.rules.iter().filter(|r| r.filters.is_empty()) {
    // rust: out.entry(r.name.clone()).or_insert(r.id);
}
    // rust: out
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.rules.is_empty()
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::Macros;

names_states_and_precedence :: proc() {
}
    // rust: let text = "block.10=stone minecraft:dirt mod:thing \\\n grass_block:snowy=false\n\
    // rust: block.11=grass_block\nblock.12=oak_leaves:persistent=true:distance=1,2 %leaves\n\
    // rust: layer.translucent=glass\n";
    // rust: let ids = BlockIds::parse(&Properties::parse(text, &Macros::standard()));
    // rust: let none = |_: &str| None;
    // rust: assert_eq!(ids.id("minecraft:stone", none), Some(10));
    // rust: assert_eq!(ids.id("mod:thing", none), Some(10));
    // rust: assert_eq!(ids.id("minecraft:glass", none), None);
    // rust: let snowy = |s: &'static str| move |k: &str| (k == "snowy").then_some(s);
        // The filtered entry is the more specific one.
    // rust: assert_eq!(ids.id("minecraft:grass_block", snowy("false")), Some(10));
    // rust: assert_eq!(ids.id("minecraft:grass_block", snowy("true")), Some(11));
    // rust: let leaves = |p: &'static str, d: &'static str| {
    // rust: move |k: &str| match k {
    // rust: "persistent" => Some(p),
    // rust: "distance" => Some(d),
    // rust: _ => None,
}
}
    // rust: assert_eq!(
    // rust: ids.id("minecraft:oak_leaves", leaves("true", "2")),
    // rust: Some(12)
    // rust: );
    // rust: assert_eq!(ids.id("minecraft:oak_leaves", leaves("true", "3")), None);
    // rust: assert_eq!(ids.id("minecraft:oak_leaves", leaves("false", "1")), None);
    // rust: assert_eq!(ids.notes.len(), 1, "{:?}", ids.notes);
}

entity_lines_by_name :: proc() {
}
    // rust: let text = "entity.10=zombie minecraft:husk\nentity.11=zombie mod:thing\nblock.5=stone\n";
    // rust: let ids = BlockIds::parse_kind(&Properties::parse(text, &Macros::standard()), "entity");
    // rust: let plain = ids.plain();
    // rust: assert_eq!(
    // rust: plain["minecraft:zombie"], 10,
    // rust: "the first line naming it wins"
    // rust: );
    // rust: assert_eq!(plain["minecraft:husk"], 10);
    // rust: assert_eq!(plain["mod:thing"], 11);
    // rust: assert!(!plain.contains_key("minecraft:stone"));
}
}
