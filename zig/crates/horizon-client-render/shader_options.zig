//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_shader_options
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Shader Options page of a `shaders/` pack: its options on the screens the pack lays out,
//! with the names its `lang` files give them, and the values the player picked.

// use std::collections::BTreeMap;

// use horizon_shaders::{Lang, PackOption, ScreenItem, Screens};

// use crate::lang;
// use crate::text::Text;

pub const ShaderOptions = struct {
    /// The pack's file name in `shaderpacks/`.
    pack: []const u8,
    options: BTreeMap<[]const u8,
    screens: Screens,
    lang: Lang,
    /// The values that differ from the defaults.
    chosen: BTreeMap<[]const u8,
    /// The screens opened from the main one, innermost last.
    path: std.ArrayList([]const u8),
    /// Something changed since the page opened.
    changed: bool,
};

    // rust: impl ShaderOptions {
    // rust: pub fn new(
    // rust: pack: String,
    // rust: options: BTreeMap<String, PackOption>,
    // rust: screens: Screens,
    // rust: lang: Lang,
    // rust: chosen: BTreeMap<String, String>,
    // rust: ) -> Self {
    // rust: let mut out = Self {
    // rust: pack,
    // rust: options,
    // rust: screens,
    // rust: lang,
    // rust: chosen: BTreeMap::new(),
    // rust: path: Vec::new(),
    // rust: changed: false,
}
    // rust: for (name, value) in chosen {
    // rust: out.set(&name, value);
}
    // rust: out.changed = false;
    // rust: out
}

    /// The screen shown: the innermost opened, else the main one.
pub fn screen(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.path.last().map_or("", String::as_str)
}

pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.screens
    // rust: .screen(self.screen())
    // rust: .map_or(&[], |(items, _)| items)
}

pub fn value(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chosen
    // rust: .get(name)
    // rust: .or_else(|| self.options.get(name).map(|o| &o.default))
    // rust: .map(String::as_str)
}

pub fn set(self: *Self, name: []const u8, value: []const u8) void {
}
    // rust: let Some(option) = self.options.get(name).filter(|o| o.values.contains(&value)) else {
    // rust: return;
}
    // rust: if value == option.default {
    // rust: self.chosen.remove(name);
    // rust: } else {
    // rust: self.chosen.insert(name.to_owned(), value);
}
    // rust: self.changed = true;
}

    /// The option's next value (the previous one with `back`), wrapping around.
pub fn cycle(self: *Self, name: []const u8, back: bool) void {
}
    // rust: let (Some(option), Some(value)) = (self.options.get(name), self.value(name)) else {
    // rust: return;
}
    // rust: let n = option.values.len();
    // rust: let at = option.values.iter().position(|v| v == value);
    // rust: let next = match (at, back) {
    // rust: (Some(i), false) => (i + 1) % n,
    // rust: (Some(i), true) => (i + n - 1) % n,
    // rust: (None, _) => 0,
}
    // rust: let value = option.values[next].clone();
    // rust: self.set(name, value);
}

    /// Where the slider of option `name` stands (its value's place in its list, 0 to 1), when
    /// the pack shows it as one.
pub fn slider_position(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let option = self.options.get(name)?;
    // rust: if option.switch || option.values.len() < 2 || !self.screens.sliders.contains(name) {
    // rust: return None;
}
    // rust: let at = option
    // rust: .values
    // rust: .iter()
    // rust: .position(|v| Some(v.as_str()) == self.value(name))?;
    // rust: Some(at as f32 / (option.values.len() - 1) as f32)
}

    /// Option `name` at the value nearest place `position` (0 to 1) of its list.
pub fn set_position(self: *Self, name: []const u8, position: f32) void {
}
    // rust: let Some(option) = self.options.get(name) else {
    // rust: return;
}
    // rust: let last = option.values.len().saturating_sub(1);
    // rust: let at = (position.clamp(0.0, 1.0) * last as f32).round() as usize;
    // rust: if let Some(value) = option.values.get(at).cloned()
    // rust: && Some(value.as_str()) != self.value(name)
    // rust: {
    // rust: self.set(name, value);
}
}

    /// Option `name` back at the pack's default.
pub fn reset_option(self: *Self, name: []const u8) void {
}
    // rust: if self.chosen.remove(name).is_some() {
    // rust: self.changed = true;
}
}

    /// The profile after the current one (the first when none matches) with its values.
pub fn next_profile(self: *Self) void {
}
    // rust: let profiles = &self.screens.profiles;
    // rust: if profiles.is_empty() {
    // rust: return;
}
    // rust: let current = self.current_profile().map(str::to_owned);
    // rust: let at = profiles
    // rust: .iter()
    // rust: .position(|(n, _)| Some(n) == current.as_ref());
    // rust: let (_, values) = profiles[at.map_or(0, |i| (i + 1) % profiles.len())].clone();
    // rust: for (name, value) in values {
    // rust: self.set(&name, value);
}
}

pub fn current_profile(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.screens
    // rust: .current_profile(|n| self.value(n).map(str::to_owned))
}

pub fn reset(self: *Self) void {
}
    // rust: if !self.chosen.is_empty() {
    // rust: self.chosen.clear();
    // rust: self.changed = true;
}
}

pub fn named(self: *Self, key: []const u8, or: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::legacy(self.lang.get(key).unwrap_or(or))
}

    /// The screen's title: its name in the pack's language, or its key.
pub fn title(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.screen() {
    // rust: "" => Text::literal(self.pack.clone()),
    // rust: screen => self.named(&format!("screen.{screen}"), screen),
}
}

pub fn screen_label(self: *Self, screen: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.named(&format!("screen.{screen}"), screen)
    // rust: .append("...")
}

pub fn profile_label(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = match self.current_profile() {
    // rust: Some(name) => self.named(&format!("profile.{name}"), name),
    // rust: None => Text::literal(lang::get("generator.custom")),
}
    // rust: Text::option_name_value(
    // rust: Text::literal(lang::get("horizon.shader_options.profile")),
    // rust: value,
    // rust: )
}

    /// What the pack says of an option, a screen or the profiles (`option.NAME.comment`...).
pub fn comment(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lang
    // rust: .get(&format!("{key}.comment"))
    // rust: .map(|c| Text::legacy(&c.replace("\\n", "\n")))
}

    /// `option_label` within `width` as `measure` sizes it: the name shortened (`Bloom Up...: 2`)
    /// when the whole doesn't fit, and whether it was.
    // rust: pub fn option_label_within(
    // rust: &self,
    // rust: name: &str,
    // rust: width: f32,
    // rust: measure: impl Fn(&Text) -> f32,
    // rust: ) -> (Text, bool) {
    // rust: let full = self.option_label(name);
    // rust: if measure(&full) <= width {
    // rust: return (full, false);
}
        // The pack's text, cut a character at a time with the `§` codes it holds kept.
    // rust: let key = format!("option.{name}");
    // rust: let caption = self.lang.get(&key).unwrap_or(name);
    // rust: let value = self.value_text(name);
    // rust: let mut chars: Vec<char> = caption.chars().collect();
    // rust: loop {
    // rust: while chars.len() >= 2 && chars[chars.len() - 2] == '§' {
    // rust: chars.truncate(chars.len() - 2);
}
    // rust: if chars.pop().is_none() {
    // rust: return (full, true);
}
            // Without the spaces and codes it ends with.
    // rust: let mut end = chars.len();
    // rust: loop {
    // rust: if end >= 2 && chars[end - 2] == '§' {
    // rust: end -= 2;
    // rust: } else if end > 0 && chars[end - 1].is_whitespace() {
    // rust: end -= 1;
    // rust: } else {
    // rust: break;
}
}
    // rust: let cut: String = chars[..end].iter().collect();
    // rust: let label = Text::option_name_value(Text::legacy(&format!("{cut}...")), value.clone());
    // rust: if measure(&label) <= width {
    // rust: return (label, true);
}
}
}

    /// `Name: value`, in the pack's words, the value yellow when it is not the default.
pub fn option_label(self: *Self, name: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::option_name_value(
    // rust: self.named(&format!("option.{name}"), name),
    // rust: self.value_text(name),
    // rust: )
}

    /// The value of option `name` as the pack names it, yellow when it is not the default.
pub fn value_text(self: *Self, name: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(option) = self.options.get(name) else {
    // rust: return Text::literal(String::new());
}
    // rust: let value = self.value(name).unwrap_or_default();
    // rust: let shown = if option.switch {
    // rust: Text::literal(lang::get(if value == "true" {
    // rust: "options.on"
    // rust: } else {
    // rust: "options.off"
    // rust: }))
    // rust: } else {
    // rust: let text = self
    // rust: .lang
    // rust: .get(&format!("value.{name}.{value}"))
    // rust: .unwrap_or(value);
    // rust: let prefix = self.lang.get(&format!("prefix.{name}")).unwrap_or("");
    // rust: let suffix = self.lang.get(&format!("suffix.{name}")).unwrap_or("");
    // rust: Text::legacy(&format!("{prefix}{text}{suffix}"))
}
    // rust: if self.chosen.contains_key(name) {
    // rust: shown.with_color(crate::text::YELLOW)
    // rust: } else {
    // rust: shown
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_shaders::{Macros, Properties};

pub fn options() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let switch = |name: &str, default: &str| PackOption {
    // rust: name: name.into(),
    // rust: default: default.into(),
    // rust: values: vec!["false".into(), "true".into()],
    // rust: switch: true,
    // rust: tested: true,
}
    // rust: let options = BTreeMap::from([
    // rust: ("AO".to_owned(), switch("AO", "true")),
    // rust: (
    // rust: "LEVEL".to_owned(),
    // rust: PackOption {
    // rust: name: "LEVEL".into(),
    // rust: default: "2".into(),
    // rust: values: vec!["1".into(), "2".into(), "3".into()],
    // rust: switch: false,
    // rust: tested: true,
    // rust: },
    // rust: ),
    // rust: ]);
    // rust: let text = "screen = <profile> [more]\nscreen.more = AO LEVEL\nsliders = LEVEL AO\n\
    // rust: profile.gone = OLD=1\n\
    // rust: profile.low = !AO LEVEL=1\nprofile.high = AO LEVEL=3\n";
    // rust: let screens = Screens::parse(&Properties::parse(text, &Macros::standard()), &options);
    // rust: ShaderOptions::new(
    // rust: "P.zip".into(),
    // rust: options,
    // rust: screens,
    // rust: Lang::default(),
    // rust: BTreeMap::from([
    // rust: ("LEVEL".to_owned(), "2".to_owned()),
    // rust: ("AO".to_owned(), "maybe".to_owned()),
    // rust: ]),
    // rust: )
}

pub fn values_cycle_and_defaults_are_not_kept() void {
}
    // rust: let mut o = options();
    // rust: assert!(o.chosen.is_empty() && !o.changed);
    // rust: o.cycle("LEVEL", false);
    // rust: o.cycle("LEVEL", false);
    // rust: assert_eq!(o.value("LEVEL"), Some("1"));
    // rust: o.cycle("LEVEL", true);
    // rust: o.cycle("AO", false);
    // rust: assert_eq!(
    // rust: o.chosen,
    // rust: BTreeMap::from([
    // rust: ("AO".to_owned(), "false".to_owned()),
    // rust: ("LEVEL".to_owned(), "3".to_owned())
    // rust: ])
    // rust: );
    // rust: assert!(o.changed);
    // rust: o.reset();
    // rust: assert!(o.chosen.is_empty());
}

pub fn sliders_take_the_nearest_value() void {
}
    // rust: let mut o = options();
    // rust: assert_eq!(o.slider_position("LEVEL"), Some(0.5));
        // A switch is a button even when `sliders` names it.
    // rust: assert_eq!(o.slider_position("AO"), None);
    // rust: o.set_position("LEVEL", 0.9);
    // rust: assert_eq!(o.value("LEVEL"), Some("3"));
    // rust: o.set_position("LEVEL", -1.0);
    // rust: assert_eq!(o.value("LEVEL"), Some("1"));
    // rust: o.set_position("LEVEL", 0.4);
    // rust: assert_eq!(o.value("LEVEL"), Some("2"));
    // rust: assert!(o.chosen.is_empty());
}

pub fn single_resets_comments_and_fitted_labels() void {
}
    // rust: let mut o = options();
    // rust: o.lang = Lang::parse(
    // rust: "option.LEVEL=Level of detail\noption.LEVEL.comment=How much detail.\\nMore costs more.\n",
    // rust: );
    // rust: o.cycle("LEVEL", false);
    // rust: assert_eq!(o.value("LEVEL"), Some("3"));
    // rust: o.reset_option("LEVEL");
    // rust: assert_eq!(o.value("LEVEL"), Some("2"));
    // rust: assert_eq!(
    // rust: o.comment("option.LEVEL").map(|c| c.plain()).as_deref(),
    // rust: Some("How much detail.\nMore costs more.")
    // rust: );
    // rust: assert!(o.comment("option.AO").is_none());
        // One unit a character.
    // rust: let measure = |t: &Text| t.plain().chars().count() as f32;
    // rust: assert!(!o.option_label_within("LEVEL", 40.0, measure).1);
    // rust: let (fitted, cut) = o.option_label_within("LEVEL", 12.0, measure);
    // rust: assert!(cut);
    // rust: assert_eq!(fitted.plain(), "Level...: 2");
    // rust: o.lang = Lang::parse("option.LEVEL=§aLevel §lof detail§r\n");
    // rust: let (fitted, _) = o.option_label_within("LEVEL", 12.0, measure);
    // rust: assert_eq!(fitted.plain(), "Level...: 2");
    // rust: assert_eq!(fitted.spans[0].style, Text::legacy("§aL").spans[0].style);
    // rust: let (fitted, _) = o.option_label_within("LEVEL", 14.0, measure);
    // rust: assert_eq!(fitted.plain(), "Level of...: 2");
}

pub fn profiles_follow_the_values() void {
}
    // rust: let mut o = options();
    // rust: assert_eq!(o.current_profile(), None);
    // rust: o.next_profile();
    // rust: assert_eq!(o.current_profile(), Some("low"));
    // rust: o.next_profile();
    // rust: assert_eq!(o.current_profile(), Some("high"));
    // rust: assert_eq!(o.value("LEVEL"), Some("3"));
    // rust: o.next_profile();
    // rust: assert_eq!(o.current_profile(), Some("low"));
}
}
