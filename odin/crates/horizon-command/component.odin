//! Transpiled from Horizon Rust crate
package horizon_command_component

import "core:fmt"
import "core:mem"
import "core:math"

// ComponentSerialization.CODEC and Style.Serializer.MAP_CODEC decoding of
// SNBT text components, with the data-fixer-upper error messages
// (ComponentArgument, StyleArgument and component-valued item data).
// use super::codec::{get, no_key, not_list, not_map};
// use horizon_world::nbt::{Compound, Tag};

// A DataResult error: its message and whether it carries a partial result.
E :: struct {
    msg: string,
    partial: bool,
}
    // rust: type R = Result<(), E>;
err :: proc(msg: impl Into<string>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Err(E {
    // rust: msg: msg.into(),
    // rust: partial: false,
    // rust: })
}
partial :: proc(msg: impl Into<string>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Err(E {
    // rust: msg: msg.into(),
    // rust: partial: true,
    // rust: })
}
// Codec.either.
either :: proc(first: R, second: impl FnOnce() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let a = match first {
    // rust: Ok(()) => return Ok(()),
    // rust: Err(e) => e,
}
    // rust: let b = match second() {
    // rust: Ok(()) => return Ok(()),
    // rust: Err(e) => e,
}
    // rust: if a.partial {
    // rust: return Err(a);
}
    // rust: if b.partial {
    // rust: return Err(b);
}
    // rust: err(format!(
    // rust: "Failed to parse either. First: {}; Second: {}",
    // rust: a.msg, b.msg
    // rust: ))
}
is_string :: proc(t: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(t, Tag::String(_))
}
string :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if is_string(t) {
    // rust: Ok(())
    // rust: } else {
    // rust: err("Not a string")
}
}
string_of :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
// ListCodec: element errors (newest first) with the decoded rest as partial.
list :: proc(t: ^Tag, element: ^dyn Fn(^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::List(items) = t else {
    // rust: return Err(E {
    // rust: msg: not_list(t),
    // rust: partial: false,
    // rust: });
}
    // rust: let mut errors: Vec<String> = Vec::new();
    // rust: let mut ok = 0;
    // rust: for i in items {
    // rust: match element(i) {
    // rust: Ok(()) => ok += 1,
    // rust: Err(e) => {
    // rust: if e.partial {
    // rust: ok += 1;
}
    // rust: errors.push(e.msg);
}
}
}
    // rust: if errors.is_empty() {
    // rust: return Ok(ok);
}
    // rust: errors.reverse();
    // rust: Err(E {
    // rust: msg: errors.join("; "),
    // rust: partial: true,
    // rust: })
}
// ExtraCodecs.nonEmptyList(listOf(element)).
non_empty_list :: proc(t: ^Tag, element: ^dyn Fn(^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match list(t, element) {
    // rust: Ok(0) => err("List must have contents"),
    // rust: Ok(_) => Ok(()),
    // rust: Err(e) if !e.partial => Err(e),
    // rust: Err(e) => {
            // The partial result is validated too.
    // rust: let decoded = match t {
    // rust: Tag::List(items) => items.iter().filter(|i| element(i).is_ok()).count(),
    // rust: _ => 0,
}
    // rust: if decoded == 0 {
    // rust: err(format!("{}; List must have contents", e.msg))
    // rust: } else {
    // rust: Err(e)
}
}
}
}
bool_value :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if super::codec::is_number(t) {
    // rust: Ok(())
    // rust: } else {
    // rust: err("Not a number")
}
}
// Identifier.CODEC.
identifier :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = string_of(t) else {
    // rust: return Err("Not a string".into());
}
    // rust: let (ns, path) = match s.split_once(':') {
    // rust: Some(("", p)) => ("minecraft".to_owned(), p.to_owned()),
    // rust: Some((n, p)) => (n.to_owned(), p.to_owned()),
    // rust: None => ("minecraft".to_owned(), s.clone()),
}
    // rust: let ns_ok = ns != ".."
    // rust: && ns
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || matches!(c, '_' | '.' | '-'));
    // rust: if !ns_ok {
    // rust: return Err(format!(
    // rust: "Not a valid resource location: {s} Non [a-z0-9_.-] character in namespace of location: {ns}:{path}"
    // rust: ));
}
    // rust: let path_ok = path.chars().all(|c| {
    // rust: c.is_ascii_lowercase() || c.is_ascii_digit() || matches!(c, '_' | '.' | '-' | '/')
    // rust: });
    // rust: if !path_ok {
    // rust: return Err(format!(
    // rust: "Not a valid resource location: {s} Non [a-z0-9/._-] character in path of location: {ns}:{path}"
    // rust: ));
}
    // rust: Ok(())
}
// TextColor.CODEC.
color :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = string_of(t) else {
    // rust: return partial("Not a string");
}
    // rust: if let Some(hex) = s.strip_prefix('#') {
    // rust: let digits = hex.strip_prefix(['+', '-']).unwrap_or(hex);
    // rust: let valid = !digits.is_empty() && digits.chars().all(|c| c.is_ascii_hexdigit());
    // rust: return match i64::from_str_radix(hex, 16) {
    // rust: Ok(v) if valid && i32::try_from(v).is_ok() => {
    // rust: if (0..=0xFF_FFFF).contains(&v) {
    // rust: Ok(())
    // rust: } else {
    // rust: partial(format!("Color value out of range: {s}"))
}
}
    // rust: _ => partial(format!("Invalid color value: {s}")),
}
}
    // rust: if horizon_client_core::text::named_color(&s).is_some() {
    // rust: Ok(())
    // rust: } else {
    // rust: partial(format!("Invalid color name: {s}"))
}
}
// A KeyDispatch over an action enum (`Unknown element name:`), with
// required fields per action.
action_event :: proc(t: ^Tag, actions: ^[(string) {
}
    // rust: let Tag::Compound(map) = t else {
    // rust: return partial(not_map(t));
}
    // rust: let Some(action) = get(map, "action") else {
    // rust: return partial(no_key("action", t));
}
    // rust: let Some(name) = string_of(action) else {
    // rust: return partial("Not a string");
}
    // rust: let Some((_, fields)) = actions.iter().find(|(a, _)| *a == name) else {
    // rust: return partial(format!("Unknown element name:{name}"));
}
    // rust: for f in *fields {
    // rust: if get(map, f).is_none() {
    // rust: return partial(no_key(f, t));
}
}
    // rust: Ok(())
}
    // rust: const CLICK_ACTIONS: &[(&str, &[&str])] = &[
    // rust: ("open_url", &["url"]),
    // rust: ("open_file", &["path"]),
    // rust: ("run_command", &["command"]),
    // rust: ("suggest_command", &["command"]),
    // rust: ("show_dialog", &["dialog"]),
    // rust: ("change_page", &["page"]),
    // rust: ("copy_to_clipboard", &["value"]),
    // rust: ("custom", &["id"]),
    // rust: ];
    // rust: const HOVER_ACTIONS: &[(&str, &[&str])] = &[
    // rust: ("show_text", &["value"]),
    // rust: ("show_item", &["id"]),
    // rust: ("show_entity", &["id", "uuid"]),
    // rust: ];
// Style.Serializer.MAP_CODEC (every field optional; errors keep a partial style).
style_fields :: proc(map: ^Compound) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(c) = get(map, "color") {
    // rust: color(c)?;
}
    // rust: for key in [
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: ] {
    // rust: if let Some(v) = get(map, key)
    // rust: && bool_value(v).is_err()
    // rust: {
    // rust: return partial("Not a number");
}
}
    // rust: if let Some(v) = get(map, "click_event") {
    // rust: action_event(v, CLICK_ACTIONS)?;
}
    // rust: if let Some(v) = get(map, "hover_event") {
    // rust: action_event(v, HOVER_ACTIONS)?;
}
    // rust: if let Some(v) = get(map, "insertion")
    // rust: && !is_string(v)
    // rust: {
    // rust: return partial("Not a string");
}
    // rust: if let Some(v) = get(map, "font")
    // rust: && let Err(m) = identifier(v)
    // rust: {
    // rust: return partial(m);
}
    // rust: Ok(())
}
selector_string :: proc(t: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = string_of(t) else { return false };
    // rust: let reg = super::args::Registries {
    // rust: permission: 4,
    // rust: ..Default::default()
}
    // rust: let mut r = super::Reader::new(&s);
    // rust: super::selector::parse(&mut r, &reg, true).is_ok() && !r.can_read()
}
optional_component :: proc(map: ^Compound, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(map, key).is_none_or(|v| component(v).is_ok())
}
// The content codecs (PlainText, Translatable, Keybind, Score, Selector, Nbt, Object).
content :: proc(kind: string, map: ^Compound) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: "text" => get(map, "text").is_some_and(is_string),
    // rust: "translatable" => {
    // rust: get(map, "translate").is_some_and(is_string)
    // rust: && get(map, "fallback").is_none_or(is_string)
    // rust: && get(map, "with").is_none_or(|w| matches!(w, Tag::List(_)))
}
    // rust: "keybind" => get(map, "keybind").is_some_and(is_string),
    // rust: "score" => match get(map, "score") {
    // rust: Some(Tag::Compound(s)) => {
    // rust: get(s, "name").is_some_and(is_string) && get(s, "objective").is_some_and(is_string)
}
    // rust: _ => false,
    // rust: },
    // rust: "selector" => {
    // rust: get(map, "selector").is_some_and(selector_string)
    // rust: && optional_component(map, "separator")
}
    // rust: "nbt" => {
    // rust: let path_ok = get(map, "nbt")
    // rust: .and_then(string_of)
    // rust: .is_some_and(|p| horizon_client_core::nbt_path::NbtPath::parse(&p).is_ok());
    // rust: let source = if let Some(e) = get(map, "entity") {
    // rust: selector_string(e)
    // rust: } else if let Some(b) = get(map, "block") {
    // rust: string_of(b).is_some_and(|s| {
    // rust: let reg = super::args::Registries::default();
    // rust: let mut r = super::Reader::new(&s);
    // rust: super::ArgType::BlockPos.parse(&mut r, &reg).is_ok() && !r.can_read()
    // rust: })
    // rust: } else if let Some(s) = get(map, "storage") {
    // rust: identifier(s).is_ok()
    // rust: } else {
    // rust: false
}
    // rust: path_ok && source && optional_component(map, "separator")
}
    // rust: "object" => {
    // rust: let kind = get(map, "object").and_then(string_of);
    // rust: let atlas = || {
    // rust: get(map, "sprite").is_some_and(|s| identifier(s).is_ok())
    // rust: && get(map, "atlas").is_none_or(|a| identifier(a).is_ok())
}
    // rust: let player = || get(map, "player").is_some();
    // rust: match kind.as_deref() {
    // rust: Some("atlas") => atlas(),
    // rust: Some("player") => player(),
    // rust: Some(_) => false,
    // rust: None => atlas() || player(),
}
}
    // rust: _ => false,
}
}
    // rust: const CONTENT_TYPES: [&str; 7] = [
    // rust: "text",
    // rust: "translatable",
    // rust: "keybind",
    // rust: "score",
    // rust: "selector",
    // rust: "nbt",
    // rust: "object",
    // rust: ];
full :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::Compound(map) = t else {
    // rust: return err(not_map(t));
}
    // rust: let contents_ok = if let Some(ty) = get(map, "type") {
    // rust: let Some(name) = string_of(ty) else {
    // rust: return err("Not a string");
}
    // rust: if !CONTENT_TYPES.contains(&name.as_str()) {
    // rust: return err(format!("Unknown element id: {name}"));
}
    // rust: content(&name, map)
    // rust: } else {
    // rust: CONTENT_TYPES.iter().any(|k| content(k, map))
}
    // rust: if !contents_ok {
    // rust: return err("No matching codec found");
}
    // rust: if let Some(extra) = get(map, "extra") {
    // rust: match non_empty_list(extra, &component) {
    // rust: Ok(()) => {}
    // rust: Err(e) => return partial(e.msg),
}
}
    // rust: style_fields(map)
}
component :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: either(either(string(t), || non_empty_list(t, &component)), || {
    // rust: full(t)
    // rust: })
}
// ComponentSerialization.CODEC.parse: the error message on failure.
decode :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: component(t).map_err(|e| e.msg)
}
// Style.Serializer.CODEC.parse.
decode_style :: proc(t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::Compound(map) => style_fields(map).map_err(|e| e.msg),
    // rust: _ => Err(not_map(t)),
}
}
