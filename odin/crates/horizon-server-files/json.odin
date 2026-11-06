//! Transpiled from Horizon Rust crate
package horizon_server_files_json

import "core:fmt"
import "core:mem"
import "core:math"

// The JSON the dedicated server reads and writes through Gson: a tree that
// keeps object member order and the literal text of numbers (Gson's
// LazilyParsedNumber), a strict parser (`Strictness.STRICT`), and Gson's
// compact (`JsonElement.toString`) and pretty, HTML-safe writers.

Json :: enum {
    Null,
    Bool(bool),
    // The number's literal text.
    Number(String),
    String(String),
    Array(Vec<Json>),
    // Members in insertion order; a repeated name replaces the value in place.
    Object(Vec<(String, Json)>),
}

    // rust: impl Json {
get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Json::Object(m) => m.iter().find(|(k, _)| k == key).map(|(_, v)| v),
    // rust: _ => None,
}
}
    // JsonElement.getAsString for primitives.
as_string :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Json::String(s) | Json::Number(s) => Some(s.clone()),
    // rust: Json::Bool(b) => Some(b.to_string()),
    // rust: _ => None,
}
}
    // JsonObject.addProperty: a null value is JsonNull, which the writers skip.
add :: proc(self: ^Self, key: string, value: Json) {
}
    // rust: if let Json::Object(m) = self {
    // rust: if let Some(slot) = m.iter_mut().find(|(k, _)| k == key) {
    // rust: slot.1 = value;
    // rust: } else {
    // rust: m.push((key.to_owned(), value));
}
}
}

    // JsonElement.toString: compact, not HTML-safe, nulls in objects written.
compact :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: self.write_compact(&mut out);
    // rust: out
}
write_compact :: proc(self: ^Self, out: ^string) {
}
    // rust: match self {
    // rust: Json::Null => out.push_str("null"),
    // rust: Json::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
    // rust: Json::Number(n) => out.push_str(n),
    // rust: Json::String(s) => quote(out, s, false),
    // rust: Json::Array(items) => {
    // rust: out.push('[');
    // rust: for (i, v) in items.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: v.write_compact(out);
}
    // rust: out.push(']');
}
    // rust: Json::Object(m) => {
    // rust: out.push('{');
    // rust: for (i, (k, v)) in m.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: quote(out, k, false);
    // rust: out.push(':');
    // rust: v.write_compact(out);
}
    // rust: out.push('}');
}
}
}

    // `new GsonBuilder().create().toJson(element)`: compact, HTML-safe
    // strings, null members skipped.
gson :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: self.write_gson(&mut out);
    // rust: out
}
write_gson :: proc(self: ^Self, out: ^string) {
}
    // rust: match self {
    // rust: Json::String(s) => quote(out, s, true),
    // rust: Json::Array(items) => {
    // rust: out.push('[');
    // rust: for (i, v) in items.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: v.write_gson(out);
}
    // rust: out.push(']');
}
    // rust: Json::Object(m) => {
    // rust: out.push('{');
    // rust: let members = m.iter().filter(|(_, v)| *v != Json::Null);
    // rust: for (i, (k, v)) in members.enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: quote(out, k, true);
    // rust: out.push(':');
    // rust: v.write_gson(out);
}
    // rust: out.push('}');
}
    // rust: other => other.write_compact(out),
}
}

    // `new GsonBuilder().setPrettyPrinting().create().toJson(element, writer)`:
    // two-space indents, HTML-safe strings, null members skipped.
pretty :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: self.write_pretty(&mut out, 0);
    // rust: out
}
write_pretty :: proc(self: ^Self, out: ^string, depth: uint) {
}
    // rust: let indent = |out: &mut String, d: usize| {
    // rust: out.push('\n');
    // rust: for _ in 0..d {
    // rust: out.push_str("  ");
}
}
    // rust: match self {
    // rust: Json::Array(items) => {
    // rust: out.push('[');
    // rust: if items.is_empty() {
    // rust: out.push(']');
    // rust: return;
}
    // rust: for (i, v) in items.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: indent(out, depth + 1);
    // rust: v.write_pretty(out, depth + 1);
}
    // rust: indent(out, depth);
    // rust: out.push(']');
}
    // rust: Json::Object(m) => {
    // rust: out.push('{');
    // rust: let members: Vec<_> = m.iter().filter(|(_, v)| *v != Json::Null).collect();
    // rust: if members.is_empty() {
    // rust: out.push('}');
    // rust: return;
}
    // rust: for (i, (k, v)) in members.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: indent(out, depth + 1);
    // rust: quote(out, k, true);
    // rust: out.push_str(": ");
    // rust: v.write_pretty(out, depth + 1);
}
    // rust: indent(out, depth);
    // rust: out.push('}');
}
    // rust: Json::String(s) => quote(out, s, true),
    // rust: other => other.write_compact(out),
}
}
}

// JsonWriter.string.
quote :: proc(out: ^string, s: string, html_safe: bool) {
}
    // rust: out.push('"');
    // rust: for c in s.chars() {
    // rust: match c {
    // rust: '"' => out.push_str("\\\""),
    // rust: '\\' => out.push_str("\\\\"),
    // rust: '\t' => out.push_str("\\t"),
    // rust: '\u{8}' => out.push_str("\\b"),
    // rust: '\n' => out.push_str("\\n"),
    // rust: '\r' => out.push_str("\\r"),
    // rust: '\u{c}' => out.push_str("\\f"),
    // rust: '\u{2028}' => out.push_str("\\u2028"),
    // rust: '\u{2029}' => out.push_str("\\u2029"),
    // rust: '<' | '>' | '&' | '=' | '\'' if html_safe => {
    // rust: out.push_str(&format!("\\u{:04x}", c as u32));
}
    // rust: c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
    // rust: c => out.push(c),
}
}
    // rust: out.push('"');
}

// A strict JSON document: one value, optionally followed only by whitespace
// when `whole` is set.
parse :: proc(text: string, whole: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let chars: Vec<char> = text.chars().collect();
    // rust: let mut p = Parser { c: &chars, i: 0 };
    // rust: let v = p.value()?;
    // rust: if whole {
    // rust: p.ws();
    // rust: if p.i != chars.len() {
    // rust: return Err("Did not consume the entire document.".into());
}
}
    // rust: Ok(v)
}

Parser :: struct {
    c: ^'a [char],
    i: uint,
}
    // rust: impl Parser<'_> {
ws :: proc(self: ^Self) {
}
    // rust: while self
    // rust: .c
    // rust: .get(self.i)
    // rust: .is_some_and(|c| matches!(c, ' ' | '\t' | '\n' | '\r'))
    // rust: {
    // rust: self.i += 1;
}
}
value :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.ws();
    // rust: match self.c.get(self.i) {
    // rust: None => Err("End of input".into()),
    // rust: Some('{') => {
    // rust: self.i += 1;
    // rust: let mut m: Vec<(String, Json)> = Vec::new();
    // rust: self.ws();
    // rust: if self.c.get(self.i) == Some(&'}') {
    // rust: self.i += 1;
    // rust: return Ok(Json::Object(m));
}
    // rust: loop {
    // rust: self.ws();
    // rust: if self.c.get(self.i) != Some(&'"') {
    // rust: return Err("Expected name".into());
}
    // rust: let k = self.string()?;
    // rust: self.ws();
    // rust: if self.c.get(self.i) != Some(&':') {
    // rust: return Err("Expected ':'".into());
}
    // rust: self.i += 1;
    // rust: let v = self.value()?;
    // rust: if let Some(slot) = m.iter_mut().find(|(n, _)| *n == k) {
    // rust: slot.1 = v;
    // rust: } else {
    // rust: m.push((k, v));
}
    // rust: self.ws();
    // rust: match self.c.get(self.i) {
    // rust: Some(',') => self.i += 1,
    // rust: Some('}') => {
    // rust: self.i += 1;
    // rust: return Ok(Json::Object(m));
}
    // rust: _ => return Err("Unterminated object".into()),
}
}
}
    // rust: Some('[') => {
    // rust: self.i += 1;
    // rust: let mut items = Vec::new();
    // rust: self.ws();
    // rust: if self.c.get(self.i) == Some(&']') {
    // rust: self.i += 1;
    // rust: return Ok(Json::Array(items));
}
    // rust: loop {
    // rust: items.push(self.value()?);
    // rust: self.ws();
    // rust: match self.c.get(self.i) {
    // rust: Some(',') => self.i += 1,
    // rust: Some(']') => {
    // rust: self.i += 1;
    // rust: return Ok(Json::Array(items));
}
    // rust: _ => return Err("Unterminated array".into()),
}
}
}
    // rust: Some('"') => Ok(Json::String(self.string()?)),
    // rust: Some(_) => {
    // rust: let start = self.i;
    // rust: while self
    // rust: .c
    // rust: .get(self.i)
    // rust: .is_some_and(|c| c.is_ascii_alphanumeric() || matches!(c, '-' | '+' | '.'))
    // rust: {
    // rust: self.i += 1;
}
    // rust: let word: String = self.c[start..self.i].iter().collect();
    // rust: match word.as_str() {
    // rust: "true" => Ok(Json::Bool(true)),
    // rust: "false" => Ok(Json::Bool(false)),
    // rust: "null" => Ok(Json::Null),
    // rust: w if is_number(w) => Ok(Json::Number(w.to_owned())),
    // rust: _ => Err(format!("Malformed JSON at {start}")),
}
}
}
}
string :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.i += 1;
    // rust: let mut out = String::new();
    // rust: let mut units: Vec<u16> = Vec::new();
    // rust: loop {
    // rust: let Some(&c) = self.c.get(self.i) else {
    // rust: return Err("Unterminated string".into());
}
    // rust: self.i += 1;
    // rust: if c != '\\' && !units.is_empty() {
    // rust: out.push_str(&String::from_utf16_lossy(&units));
    // rust: units.clear();
}
    // rust: match c {
    // rust: '"' => {
    // rust: out.push_str(&String::from_utf16_lossy(&units));
    // rust: return Ok(out);
}
    // rust: '\\' => {
    // rust: let Some(&e) = self.c.get(self.i) else {
    // rust: return Err("Unterminated escape".into());
}
    // rust: self.i += 1;
    // rust: if e == 'u' {
    // rust: let hex: String = self
    // rust: .c
    // rust: .get(self.i..self.i + 4)
    // rust: .ok_or("bad escape")?
    // rust: .iter()
    // rust: .collect();
    // rust: let v = u16::from_str_radix(&hex, 16).map_err(|e| e.to_string())?;
    // rust: self.i += 4;
    // rust: units.push(v);
    // rust: continue;
}
    // rust: if !units.is_empty() {
    // rust: out.push_str(&String::from_utf16_lossy(&units));
    // rust: units.clear();
}
    // rust: out.push(match e {
    // rust: 't' => '\t',
    // rust: 'b' => '\u{8}',
    // rust: 'n' => '\n',
    // rust: 'r' => '\r',
    // rust: 'f' => '\u{c}',
    // rust: '"' | '\\' | '/' => e,
    // rust: _ => return Err("Invalid escape sequence".into()),
    // rust: });
}
    // rust: c if (c as u32) < 0x20 => return Err("Unescaped control character".into()),
    // rust: c => out.push(c),
}
}
}
}

// JSON number syntax (JsonReader.peekNumber in strict mode).
is_number :: proc(w: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = w.as_bytes();
    // rust: let mut i = 0;
    // rust: if b.get(i) == Some(&b'-') {
    // rust: i += 1;
}
    // rust: match b.get(i) {
    // rust: Some(b'0') => i += 1,
    // rust: Some(b'1'..=b'9') => {
    // rust: while b.get(i).is_some_and(u8::is_ascii_digit) {
    // rust: i += 1;
}
}
    // rust: _ => return false,
}
    // rust: if b.get(i) == Some(&b'.') {
    // rust: i += 1;
    // rust: if !b.get(i).is_some_and(u8::is_ascii_digit) {
    // rust: return false;
}
    // rust: while b.get(i).is_some_and(u8::is_ascii_digit) {
    // rust: i += 1;
}
}
    // rust: if matches!(b.get(i), Some(b'e' | b'E')) {
    // rust: i += 1;
    // rust: if matches!(b.get(i), Some(b'+' | b'-')) {
    // rust: i += 1;
}
    // rust: if !b.get(i).is_some_and(u8::is_ascii_digit) {
    // rust: return false;
}
    // rust: while b.get(i).is_some_and(u8::is_ascii_digit) {
    // rust: i += 1;
}
}
    // rust: i == b.len()
}

    // rust: mod tests {
//     use super::*;
round_trips :: proc() {
}
    // rust: let v = parse(r#" { "a" : 1.50 , "b":[true,null,"x<"] , "a": 2 } "#, true).unwrap();
    // rust: assert_eq!(v.compact(), r#"{"a":2,"b":[true,null,"x<"]}"#);
    // rust: let mut o = Json::Object(vec![]);
    // rust: o.add("name", Json::String("a=b".into()));
    // rust: o.add("reason", Json::Null);
    // rust: assert_eq!(
    // rust: Json::Array(vec![o]).pretty(),
    // rust: "[\n  {\n    \"name\": \"a\\u003db\"\n  }\n]"
    // rust: );
    // rust: assert_eq!(Json::Array(vec![]).pretty(), "[]");
    // rust: assert!(parse("{a:1}", true).is_err());
}
}
