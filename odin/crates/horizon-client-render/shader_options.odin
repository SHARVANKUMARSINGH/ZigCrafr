//! Transpiled from Horizon Rust crate
package horizon_client_render_shader_options

import "core:fmt"
import "core:mem"
import "core:math"

// The Shader Options page of a `shaders/` pack: its options on the screens the pack lays out,
// with the names its `lang` files give them, and the values the player picked.

// use std::collections::BTreeMap;

// use horizon_shaders::{Lang, PackOption, ScreenItem, Screens};

// use crate::lang;
// use crate::text::Text;

ShaderOptions :: struct {
    // The pack's file name in `shaderpacks/`.
    pack: string,
    options: BTreeMap<string,
    screens: Screens,
    lang: Lang,
    // The values that differ from the defaults.
    chosen: BTreeMap<string,
    // The screens opened from the main one, innermost last.
    path: [dynamic]string,
    // Something changed since the page opened.
    changed: bool,
}

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

    // The screen shown: the innermost opened, else the main one.
screen :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.path.last().map_or("", String::as_str)
}

items :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.screens
    // rust: .screen(self.screen())
    // rust: .map_or(&[], |(items, _)| items)
}

value :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.chosen
    // rust: .get(name)
    // rust: .or_else(|| self.options.get(name).map(|o| &o.default))
    // rust: .map(String::as_str)
}

set :: proc(self: ^Self, name: string, value: string) {
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

    // The option's next value (the previous one with `back`), wrapping around.
cycle :: proc(self: ^Self, name: string, back: bool) {
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

    // Where the slider of option `name` stands (its value's place in its list, 0 to 1), when
    // the pack shows it as one.
slider_position :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
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

    // Option `name` at the value nearest place `position` (0 to 1) of its list.
set_position :: proc(self: ^Self, name: string, position: f32) {
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

    // Option `name` back at the pack's default.
reset_option :: proc(self: ^Self, name: string) {
}
    // rust: if self.chosen.remove(name).is_some() {
    // rust: self.changed = true;
}
}

    // The profile after the current one (the first when none matches) with its values.
next_profile :: proc(self: ^Self) {
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

current_profile :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.screens
    // rust: .current_profile(|n| self.value(n).map(str::to_owned))
}

reset :: proc(self: ^Self) {
}
    // rust: if !self.chosen.is_empty() {
    // rust: self.chosen.clear();
    // rust: self.changed = true;
}
}

named :: proc(self: ^Self, key: string, or: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::legacy(self.lang.get(key).unwrap_or(or))
}

    // The screen's title: its name in the pack's language, or its key.
title :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self.screen() {
    // rust: "" => Text::literal(self.pack.clone()),
    // rust: screen => self.named(&format!("screen.{screen}"), screen),
}
}

screen_label :: proc(self: ^Self, screen: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.named(&format!("screen.{screen}"), screen)
    // rust: .append("...")
}

profile_label :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
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

    // What the pack says of an option, a screen or the profiles (`option.NAME.comment`...).
comment :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.lang
    // rust: .get(&format!("{key}.comment"))
    // rust: .map(|c| Text::legacy(&c.replace("\\n", "\n")))
}

    // `option_label` within `width` as `measure` sizes it: the name shortened (`Bloom Up...: 2`)
    // when the whole doesn't fit, and whether it was.
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

    // `Name: value`, in the pack's words, the value yellow when it is not the default.
option_label :: proc(self: ^Self, name: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::option_name_value(
    // rust: self.named(&format!("option.{name}"), name),
    // rust: self.value_text(name),
    // rust: )
}

    // The value of option `name` as the pack names it, yellow when it is not the default.
value_text :: proc(self: ^Self, name: string) -> T {
    // Ported from Horizon
    return {}
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

options :: proc() -> S {
    // Ported from Horizon
    return {}
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

values_cycle_and_defaults_are_not_kept :: proc() {
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

sliders_take_the_nearest_value :: proc() {
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

single_resets_comments_and_fitted_labels :: proc() {
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

profiles_follow_the_values :: proc() {
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
