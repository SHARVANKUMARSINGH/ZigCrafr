//! Transpiled from Horizon Rust crate
//! Module: horizon-world_text
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The text component fixes of 1.21.5 (keys 4290 to 4292): JSON strings become
//! NBT components, legacy hover events are replaced, stringified style flags
//! become booleans and hover/click events take their new field names.
// use super::FixFn;
// use super::dynamic::{
    // rust: as_number, as_str, as_string, boolean, empty_map, remove, rename, rename_and_fix, set, string,
}
// use super::json;
// use super::schema::{Key, Ty, key};
// use crate::nbt::Tag;

    // rust: pub(super) fn register(out: &mut Vec<(Key, FixFn)>) {
    // rust: out.push((key(4290, 0), |cx| cx.each(Ty::TextComponent, unflatten)));
    // rust: out.push((key(4291, 0), |cx| {
    // rust: cx.each(Ty::TextComponent, legacy_hover_event)
    // rust: }));
    // rust: out.push((key(4291, 0), |cx| {
    // rust: cx.each(Ty::TextComponent, stringified_flags)
    // rust: }));
    // rust: out.push((key(4292, 0), |cx| {
    // rust: cx.each(Ty::TextComponent, hover_and_click_event)
    // rust: }));
}

/// `UnflattenTextComponentFix`: the JSON of a string component as NBT.
pub fn unflatten(v: *mut Tag) void {
}
    // rust: let Tag::String(s) = v else {
    // rust: return;
}
    // rust: if let Some(parsed) = json::parse_lenient(&s.0)
    // rust: && let Some(tag) = json::to_nbt(&parsed)
    // rust: {
    // rust: *v = tag;
}
}

pub fn is_full(v: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(v, Tag::Compound(_))
}

/// The hover event a schema of 4290/4291 reads as typed (a known action).
pub fn typed_hover(v: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = v.get("hoverEvent")?;
    // rust: let action = as_str(h.get("action"))?;
    // rust: matches!(action.as_str(), "show_text" | "show_item" | "show_entity").then_some(action)
}

/// `LegacyHoverEventFix`.
pub fn legacy_hover_event(v: *mut Tag) void {
}
    // rust: if !is_full(v) {
    // rust: return;
}
    // rust: let Some(hover) = v.get("hoverEvent").cloned() else {
    // rust: return;
}
    // rust: if hover.get("value").is_none() {
    // rust: return;
}
    // rust: let action = typed_hover(v).unwrap_or_default();
    // rust: let new = if action == "show_text" {
    // rust: let mut h = hover;
    // rust: rename(&mut h, "value", "contents");
    // rust: h
    // rust: } else {
    // rust: let mut text = "Legacy hoverEvent: ".encode_utf16().collect::<Vec<u16>>();
    // rust: text.extend(json::to_stable_string(&json::from_nbt(&hover)));
    // rust: Tag::compound([
    // rust: ("action", string("show_text")),
    // rust: (
    // rust: "contents",
    // rust: Tag::compound([("text", Tag::String(crate::nbt::JavaString(text)))]),
    // rust: ),
    // rust: ])
}
    // rust: set(v, "hoverEvent", new);
}

/// `TextComponentStringifiedFlagsFix`: `Boolean.parseBoolean` of string flags.
pub fn stringified_flags(v: *mut Tag) void {
}
    // rust: if !is_full(v) {
    // rust: return;
}
    // rust: for flag in [
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: ] {
    // rust: if let Some(s) = as_str(v.get(flag)) {
    // rust: set(v, flag, boolean(s.eq_ignore_ascii_case("true")));
}
}
}

/// `TextComponentHoverAndClickEventFix`.
pub fn hover_and_click_event(v: *mut Tag) void {
}
    // rust: if !is_full(v) {
    // rust: return;
}
    // rust: if typed_hover(v).is_none() && v.get("clickEvent").is_none() {
    // rust: return;
}
    // rust: rename_and_fix(v, "hoverEvent", "hover_event", |h| Some(fix_hover_event(h)));
    // rust: rename_and_fix(v, "clickEvent", "click_event", fix_click_event);
}

pub fn copy_fields(target: *mut Tag, source: *Tag, fields: *[[]const u8]) void {
}
    // rust: for f in fields {
    // rust: if let Some(value) = source.get(f) {
    // rust: set(target, f, value.clone());
}
}
}

pub fn fix_hover_event(mut h: Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match as_string(h.get("action"), "").as_str() {
    // rust: "show_text" => rename(&mut h, "contents", "value"),
    // rust: "show_item" => {
    // rust: let contents = h.get("contents").cloned().unwrap_or_else(empty_map);
    // rust: remove(&mut h, "contents");
    // rust: copy_fields(&mut h, &contents, &["id", "count", "components"]);
}
    // rust: "show_entity" => {
    // rust: let contents = h.get("contents").cloned().unwrap_or_else(empty_map);
    // rust: remove(&mut h, "contents");
    // rust: copy_fields(&mut h, &contents, &["id", "type", "name"]);
    // rust: rename(&mut h, "id", "uuid");
    // rust: rename(&mut h, "type", "id");
}
    // rust: _ => {}
}
    // rust: h
}

pub fn fix_click_event(mut c: Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let action = as_string(c.get("action"), "");
    // rust: let value = as_string(c.get("value"), "");
    // rust: match action.as_str() {
    // rust: "open_url" => {
    // rust: if !valid_uri(&value) {
    // rust: return None;
}
    // rust: rename(&mut c, "value", "url");
}
    // rust: "open_file" => rename(&mut c, "value", "path"),
    // rust: "run_command" | "suggest_command" => {
    // rust: if !valid_chat(&value) {
    // rust: return None;
}
    // rust: rename(&mut c, "value", "command");
}
    // rust: "change_page" => {
    // rust: let old = c.get("value").and_then(|v| match as_number(v) {
    // rust: Some(n) => Some(n.int_value()),
    // rust: None => parse_int(&as_string(Some(v), "")),
    // rust: })?;
    // rust: remove(&mut c, "value");
    // rust: set(&mut c, "page", Tag::Int(old.max(1)));
}
    // rust: _ => {}
}
    // rust: Some(c)
}

/// `Integer.parseInt`.
pub fn parse_int(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let digits = s.strip_prefix(['+', '-']).unwrap_or(s);
    // rust: if digits.is_empty() || !digits.bytes().all(|b| b.is_ascii_digit()) {
    // rust: return None;
}
    // rust: s.parse().ok()
}

/// `new URI(uri)` succeeds with an http or https scheme.
pub fn valid_uri(uri: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((scheme, rest)) = uri.split_once(':') else {
    // rust: return false;
}
    // rust: let mut chars = scheme.chars();
    // rust: let scheme_ok = chars.next().is_some_and(|c| c.is_ascii_alphabetic())
    // rust: && chars.all(|c| c.is_ascii_alphanumeric() || matches!(c, '+' | '-' | '.'));
    // rust: if !scheme_ok || rest.is_empty() {
    // rust: return false;
}
    // Characters java.net.URI refuses anywhere, and escapes it checks.
    // rust: let bytes: Vec<char> = rest.chars().collect();
    // rust: let mut hashes = 0;
    // rust: let mut i = 0;
    // rust: while i < bytes.len() {
    // rust: let c = bytes[i];
    // rust: if c == '%' {
    // rust: if !bytes.get(i + 1).is_some_and(char::is_ascii_hexdigit)
    // rust: || !bytes.get(i + 2).is_some_and(char::is_ascii_hexdigit)
    // rust: {
    // rust: return false;
}
    // rust: i += 3;
    // rust: continue;
}
    // rust: if c == '#' {
    // rust: hashes += 1;
}
    // rust: if c.is_control()
    // rust: || c.is_whitespace()
    // rust: || matches!(c, '"' | '<' | '>' | '\\' | '^' | '`' | '{' | '|' | '}')
    // rust: {
    // rust: return false;
}
    // rust: i += 1;
}
    // rust: hashes <= 1 && matches!(scheme.to_ascii_lowercase().as_str(), "http" | "https")
}

/// `StringUtil.isAllowedChatCharacter` for every character.
pub fn valid_chat(s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.encode_utf16().all(|c| c != 167 && c >= 32 && c != 127)
}

    // rust: mod tests {
//     use super::*;

pub fn j(s: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json::to_nbt(&json::parse_lenient(&s.encode_utf16().collect::<Vec<_>>()).unwrap()).unwrap()
}

pub fn click_events_take_their_new_fields() void {
}
    // rust: let mut c = j(r#"{"text":"a","clickEvent":{"action":"change_page","value":"0"}}"#);
    // rust: hover_and_click_event(&mut c);
        // The page is written as an int (`createInt`), not as JSON's narrowest number.
    // rust: let mut expected = j(r#"{"text":"a","click_event":{"action":"change_page"}}"#);
    // rust: if let Some(click) = expected.get_mut("click_event") {
    // rust: super::super::dynamic::set(click, "page", Tag::Int(1));
}
    // rust: assert_eq!(c, expected);
    // rust: let mut c = j(r#"{"text":"a","clickEvent":{"action":"open_url","value":"ftp://x"}}"#);
    // rust: hover_and_click_event(&mut c);
    // rust: assert_eq!(c, j(r#"{"text":"a"}"#));
}

pub fn legacy_hover_events_become_text() void {
}
    // rust: let mut c = j(r#"{"text":"a","hoverEvent":{"action":"show_item","value":"{id:stone}"}}"#);
    // rust: legacy_hover_event(&mut c);
    // rust: let expected = j(
    // rust: r#"{"text":"a","hoverEvent":{"action":"show_text","contents":{"text":"Legacy hoverEvent: {\"action\":\"show_item\",\"value\":\"{id:stone}\"}"}}}"#,
    // rust: );
    // rust: assert_eq!(c, expected);
}
}
