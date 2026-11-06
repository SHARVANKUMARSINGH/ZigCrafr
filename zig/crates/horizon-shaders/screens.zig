//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_screens
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! How a pack lays out its options for the player (8.2, 8.3): `screen` and `screen.NAME` list
//! what each screen shows, `sliders` the options shown as sliders, `profile.NAME` sets of values
//! picked together.

// use std::collections::{BTreeMap, BTreeSet};

// use crate::{PackOption, Properties};

/// One place on a screen.
pub const Item = enum {
    Option(String),
    /// A button opening `screen.NAME`.
    Screen(String),
    /// The button cycling through the profiles.
    Profile,
    Empty,
};

pub const Screens = struct {
    /// By name, `""` for the main screen: its items and its number of columns.
    screens: BTreeMap<[]const u8,
    sliders: BTreeSet<[]const u8>,
    /// In the pack's order: the name and the values it sets.
    profiles: Vec<([]const u8,
};

    // rust: impl Screens {
pub fn parse(properties: *Properties, options: *BTreeMap<[]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lists: BTreeMap<String, String> = BTreeMap::new();
    // rust: let mut columns: BTreeMap<String, u32> = BTreeMap::new();
    // rust: let mut profiles: Vec<(String, String)> = Vec::new();
    // rust: let mut sliders = BTreeSet::new();
    // rust: for entry in &properties.entries {
    // rust: let key = entry.key.as_str();
    // rust: if key == "sliders" {
    // rust: sliders.extend(entry.value.split_whitespace().map(str::to_owned));
    // rust: } else if let Some(name) = key.strip_prefix("profile.") {
    // rust: match profiles.iter_mut().find(|(n, _)| n == name) {
    // rust: Some(p) => p.1 = entry.value.clone(),
    // rust: None => profiles.push((name.to_owned(), entry.value.clone())),
}
    // rust: } else if key == "screen" {
    // rust: lists.insert(String::new(), entry.value.clone());
    // rust: } else if key == "screen.columns" {
    // rust: columns.insert(String::new(), entry.value.trim().parse().unwrap_or(2));
    // rust: } else if let Some(rest) = key.strip_prefix("screen.") {
    // rust: match rest.strip_suffix(".columns") {
    // rust: Some(name) => {
    // rust: columns.insert(name.to_owned(), entry.value.trim().parse().unwrap_or(2));
}
    // rust: None => _ = lists.insert(rest.to_owned(), entry.value.clone()),
}
}
}
    // rust: let item = |word: &str| match word {
    // rust: "<empty>" => Item::Empty,
    // rust: "<profile>" => Item::Profile,
    // rust: w if w.starts_with('[') && w.ends_with(']') => {
    // rust: Item::Screen(w[1..w.len() - 1].to_owned())
}
    // rust: w => Item::Option(w.to_owned()),
}
    // rust: let placed: BTreeSet<&str> = lists.values().flat_map(|l| l.split_whitespace()).collect();
        // `*`: every option no screen names.
    // rust: let rest: Vec<Item> = options
    // rust: .values()
    // rust: .filter(|o| o.tested && !placed.contains(o.name.as_str()))
    // rust: .map(|o| Item::Option(o.name.clone()))
    // rust: .collect();
    // rust: let mut screens: BTreeMap<String, (Vec<Item>, u32)> = lists
    // rust: .iter()
    // rust: .map(|(name, list)| {
    // rust: let items = list
    // rust: .split_whitespace()
    // rust: .flat_map(|w| match w {
    // rust: "*" => rest.clone(),
    // rust: w => vec![item(w)],
    // rust: })
    // rust: .filter(|i| !matches!(i, Item::Option(o) if !options.contains_key(o)))
    // rust: .collect();
    // rust: (
    // rust: name.clone(),
    // rust: (items, columns.get(name).copied().unwrap_or(2)),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: if !screens.contains_key("") {
    // rust: let all = options
    // rust: .values()
    // rust: .filter(|o| o.tested)
    // rust: .map(|o| Item::Option(o.name.clone()))
    // rust: .collect();
    // rust: screens.insert(String::new(), (all, columns.get("").copied().unwrap_or(2)));
}
    // rust: let texts: BTreeMap<&str, &str> = profiles
    // rust: .iter()
    // rust: .map(|(n, v)| (n.as_str(), v.as_str()))
    // rust: .collect();
        // A profile naming none of the pack's options sets nothing: it would match any values.
    // rust: let profiles = profiles
    // rust: .iter()
    // rust: .map(|(name, _)| (name.clone(), profile_values(name, &texts, options)))
    // rust: .filter(|(_, values)| !values.is_empty())
    // rust: .collect();
    // rust: Self {
    // rust: screens,
    // rust: sliders,
    // rust: profiles,
}
}

    /// The items of screen `name` (`""`: the main screen) and its columns.
pub fn screen(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.screens.get(name).map(|(i, c)| (i.as_slice(), *c))
}

    /// The profile whose values are all those of `value`.
pub fn current_profile(self: *Self, value: impl Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.profiles
    // rust: .iter()
    // rust: .find(|(_, values)| values.iter().all(|(n, v)| value(n).as_deref() == Some(v)))
    // rust: .map(|(name, _)| name.as_str())
}
}

/// The values profile `name` sets: `NAME=VALUE` or `NAME:VALUE`, `NAME` and `!NAME` for a
/// switch, `profile.OTHER` for another profile's values.
    // rust: fn profile_values(
    // rust: name: &str,
    // rust: texts: &BTreeMap<&str, &str>,
    // rust: options: &BTreeMap<String, PackOption>,
    // rust: ) -> Vec<(String, String)> {
    // rust: let mut out: Vec<(String, String)> = Vec::new();
    // rust: let mut seen = BTreeSet::new();
    // rust: let mut pending = vec![name];
    // rust: while let Some(profile) = pending.pop() {
    // rust: if !seen.insert(profile) {
    // rust: continue;
}
    // rust: for word in texts.get(profile).copied().unwrap_or("").split_whitespace() {
    // rust: if let Some(other) = word.strip_prefix("profile.") {
    // rust: pending.push(other);
    // rust: continue;
}
    // rust: let (option, value) = match word.split_once(['=', ':']) {
    // rust: Some((n, v)) => (n, v.to_owned()),
    // rust: None => match word.strip_prefix('!') {
    // rust: Some(n) => (n, "false".to_owned()),
    // rust: None => (word, "true".to_owned()),
    // rust: },
}
    // rust: if !options.contains_key(option) || out.iter().any(|(n, _)| n == option) {
    // rust: continue;
}
    // rust: out.push((option.to_owned(), value));
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;
//     use crate::Macros;

pub fn option(name: []const u8, default: []const u8, switch: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let values = if switch {
    // rust: vec!["false".into(), "true".into()]
    // rust: } else {
    // rust: vec!["1".into(), "2".into()]
}
    // rust: let o = PackOption {
    // rust: name: name.into(),
    // rust: default: default.into(),
    // rust: values,
    // rust: switch,
    // rust: tested: true,
}
    // rust: (name.into(), o)
}

pub fn screens_profiles_and_the_rest() void {
}
    // rust: let options = BTreeMap::from([
    // rust: option("AO", "true", true),
    // rust: option("BLOOM", "false", true),
    // rust: option("LEVEL", "2", false),
    // rust: option("SPARE", "1", false),
    // rust: ]);
    // rust: let text = "screen = <profile> <empty> [post] LEVEL GONE\nscreen.post = BLOOM *\n\
    // rust: screen.post.columns = 1\nsliders = LEVEL\n\
    // rust: profile.empty = GONE\nprofile.low = !AO LEVEL=1\nprofile.high = profile.low AO BLOOM LEVEL:2\n";
    // rust: let screens = Screens::parse(&Properties::parse(text, &Macros::standard()), &options);
    // rust: let (main, columns) = screens.screen("").unwrap();
    // rust: assert_eq!(columns, 2);
    // rust: assert_eq!(
    // rust: main,
    // rust: [
    // rust: Item::Profile,
    // rust: Item::Empty,
    // rust: Item::Screen("post".into()),
    // rust: Item::Option("LEVEL".into())
    // rust: ]
    // rust: );
    // rust: let (post, columns) = screens.screen("post").unwrap();
    // rust: assert_eq!(columns, 1);
    // rust: assert_eq!(
    // rust: post,
    // rust: [
    // rust: Item::Option("BLOOM".into()),
    // rust: Item::Option("AO".into()),
    // rust: Item::Option("SPARE".into())
    // rust: ]
    // rust: );
    // rust: assert!(screens.sliders.contains("LEVEL"));
    // rust: assert_eq!(
    // rust: screens.profiles[1].1,
    // rust: [
    // rust: ("AO".to_owned(), "true".to_owned()),
    // rust: ("BLOOM".to_owned(), "true".to_owned()),
    // rust: ("LEVEL".to_owned(), "2".to_owned())
    // rust: ]
    // rust: );
    // rust: let values = BTreeMap::from([("AO", "false"), ("LEVEL", "1"), ("BLOOM", "true")]);
    // rust: assert_eq!(
    // rust: screens.current_profile(|n| values.get(n).map(|v| (*v).to_owned())),
    // rust: Some("low")
    // rust: );
}
}
