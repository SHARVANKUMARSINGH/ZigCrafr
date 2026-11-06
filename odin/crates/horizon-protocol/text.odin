//! Transpiled from Horizon Rust crate
package horizon_protocol_text

import "core:fmt"
import "core:mem"
import "core:math"

// Chat components as sent on the network (ComponentSerialization in NBT form)
// flattened to display strings, with `translate` keys resolved through a
// language table (en_us.json) and Java `String.format` style arguments.
// use horizon_world::nbt::{JavaString, Tag};
// use std::collections::HashMap;

// A language table: translation key -> pattern.
    // rust: pub type Language = HashMap<String, String>;

string :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
    // rust: fn get<'t>(tag: &'t Tag, key: &str) -> Option<&'t Tag> {
    // rust: match tag {
    // rust: Tag::Compound(map) => map.get(&JavaString::from(key)),
    // rust: _ => None,
}
}

// Flatten a component to text.
plain :: proc(tag: ^Tag, lang: ^Language) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: append(tag, lang, &mut out, 0);
    // rust: out
}
append :: proc(tag: ^Tag, lang: ^Language, out: ^string, depth: uint) {
}
    // rust: if depth > 32 {
    // rust: return;
}
    // rust: match tag {
    // rust: Tag::String(s) => out.push_str(&s.to_string_lossy()),
    // rust: Tag::Byte(v) => out.push_str(&v.to_string()),
    // rust: Tag::Short(v) => out.push_str(&v.to_string()),
    // rust: Tag::Int(v) => out.push_str(&v.to_string()),
    // rust: Tag::Long(v) => out.push_str(&v.to_string()),
    // rust: Tag::Float(v) => out.push_str(&f32::from_bits(*v).to_string()),
    // rust: Tag::Double(v) => out.push_str(&f64::from_bits(*v).to_string()),
        // A list is its first element with the rest appended as siblings.
    // rust: Tag::List(items) => {
    // rust: for item in items {
    // rust: append(item, lang, out, depth + 1);
}
}
    // rust: Tag::Compound(_) => {
    // rust: if let Some(text) = get(tag, "text").and_then(string) {
    // rust: out.push_str(&text);
    // rust: } else if let Some(value) = get(tag, "") {
                // NbtOps' wrapper for a bare value in a mixed list (a
                // translation's number and string arguments).
    // rust: append(value, lang, out, depth + 1);
    // rust: } else if let Some(key) = get(tag, "translate").and_then(string) {
    // rust: let args: Vec<String> = match get(tag, "with") {
    // rust: Some(Tag::List(args)) => args
    // rust: .iter()
    // rust: .map(|a| {
    // rust: let mut s = String::new();
    // rust: append(a, lang, &mut s, depth + 1);
    // rust: s
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let pattern = lang
    // rust: .get(&key)
    // rust: .cloned()
    // rust: .or_else(|| get(tag, "fallback").and_then(string))
    // rust: .unwrap_or_else(|| key.clone());
    // rust: out.push_str(&format_java(&pattern, &args));
    // rust: } else if let Some(key) = get(tag, "keybind").and_then(string) {
    // rust: out.push_str(lang.get(&key).map_or(key.as_str(), String::as_str));
    // rust: } else if let Some(selector) = get(tag, "selector").and_then(string) {
    // rust: out.push_str(&selector);
    // rust: } else if let Some(score) = get(tag, "score") {
    // rust: if let Some(name) = get(score, "name").and_then(string) {
    // rust: out.push_str(&name);
}
}
    // rust: if let Some(Tag::List(extra)) = get(tag, "extra") {
    // rust: for e in extra {
    // rust: append(e, lang, out, depth + 1);
}
}
}
    // rust: _ => {}
}
}

// TranslatableContents.decomposeTemplate: `%s`, `%n$s` and `%%`.
format_java :: proc(pattern: string, args: ^[string]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: let mut next = 0usize;
    // rust: let mut chars = pattern.char_indices().peekable();
    // rust: while let Some((_, c)) = chars.next() {
    // rust: if c != '%' {
    // rust: out.push(c);
    // rust: continue;
}
    // rust: let mut digits = String::new();
    // rust: while let Some(&(_, d)) = chars.peek() {
    // rust: if d.is_ascii_digit() {
    // rust: digits.push(d);
    // rust: chars.next();
    // rust: } else {
    // rust: break;
}
}
    // rust: match chars.next() {
    // rust: Some((_, '%')) if digits.is_empty() => out.push('%'),
    // rust: Some((_, '$')) if !digits.is_empty() => {
    // rust: if chars.next().map(|(_, c)| c) == Some('s') {
    // rust: let i = digits.parse::<usize>().unwrap_or(1).saturating_sub(1);
    // rust: out.push_str(args.get(i).map_or("", String::as_str));
}
}
    // rust: Some((_, 's')) if digits.is_empty() => {
    // rust: out.push_str(args.get(next).map_or("", String::as_str));
    // rust: next += 1;
}
    // rust: Some((_, other)) => {
    // rust: out.push('%');
    // rust: out.push_str(&digits);
    // rust: out.push(other);
}
    // rust: None => out.push('%'),
}
}
    // rust: out
}

// A literal text component.
literal :: proc(text: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(JavaString::from(text))
}
// A translatable component with literal arguments.
translatable :: proc(key: string, args: ^[string]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = vec![("translate", Tag::String(JavaString::from(key)))];
    // rust: if !args.is_empty() {
    // rust: entries.push(("with", Tag::List(args.iter().map(|a| literal(a)).collect())));
}
    // rust: Tag::compound(entries)
}

    // rust: mod tests {
//     use super::*;

formats_like_translatable_contents :: proc() {
}
    // rust: let args = vec!["Steve".to_owned(), "hi".to_owned()];
    // rust: assert_eq!(format_java("<%s> %s", &args), "<Steve> hi");
    // rust: assert_eq!(format_java("%2$s by %1$s", &args), "hi by Steve");
    // rust: assert_eq!(format_java("100%% sure", &[]), "100% sure");
}

unwraps_mixed_list_arguments :: proc() {
}
    // rust: let mut lang = Language::new();
    // rust: lang.insert(
    // rust: "commands.item.entity.set.success.single".into(),
    // rust: "Replaced %s slot(s) on %s with %s".into(),
    // rust: );
        // `with: [1, {text: "Alex"}, ...]` in NBT: the int comes wrapped.
    // rust: let replaced = Tag::compound([
    // rust: (
    // rust: "translate",
    // rust: Tag::String("commands.item.entity.set.success.single".into()),
    // rust: ),
    // rust: (
    // rust: "with",
    // rust: Tag::List(vec![
    // rust: Tag::compound([("", Tag::Int(1))]),
    // rust: Tag::compound([("text", Tag::String("Alex".into()))]),
    // rust: Tag::compound([("", Tag::String("[Emerald]".into()))]),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: assert_eq!(
    // rust: plain(&replaced, &lang),
    // rust: "Replaced 1 slot(s) on Alex with [Emerald]"
    // rust: );
}

flattens_components :: proc() {
}
    // rust: let mut lang = Language::new();
    // rust: lang.insert(
    // rust: "multiplayer.player.joined".into(),
    // rust: "%s joined the game".into(),
    // rust: );
    // rust: let joined = Tag::compound([
    // rust: ("translate", Tag::String("multiplayer.player.joined".into())),
    // rust: (
    // rust: "with",
    // rust: Tag::List(vec![Tag::compound([("text", Tag::String("Alex".into()))])]),
    // rust: ),
    // rust: ("color", Tag::String("yellow".into())),
    // rust: ]);
    // rust: assert_eq!(plain(&joined, &lang), "Alex joined the game");
    // rust: let extra = Tag::compound([
    // rust: ("text", Tag::String("a".into())),
    // rust: (
    // rust: "extra",
    // rust: Tag::List(vec![
    // rust: literal("b"),
    // rust: Tag::compound([("text", Tag::String("c".into()))]),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: assert_eq!(plain(&extra, &lang), "abc");
    // rust: assert_eq!(
    // rust: plain(&translatable("missing.key", &[]), &lang),
    // rust: "missing.key"
    // rust: );
    // rust: assert_eq!(plain(&literal("plain"), &lang), "plain");
}
}
