//! Transpiled from Horizon Rust crate
//! Module: horizon-world_json
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The JSON that DataFixers read and write: Gson's `JsonReader` in strict and
//! lenient mode, `GsonHelper.toStableString`, and `JsonOps.convertTo` into NBT.
//! Strings stay UTF-16 like Java's; numbers keep their literal like Gson's
//! `LazilyParsedNumber`.
// use crate::nbt::{Compound, JavaString, Tag};

pub const Json = enum {
    Null,
    Bool(bool),
    /// The literal as written (`LazilyParsedNumber`) or `Number.toString`.
    Num(String),
    Str(Vec<u16>),
    Arr(Vec<Json>),
    /// Insertion order, a repeated key replacing the value in place.
    Obj(Vec<(Vec<u16>, Json)>),
};

    // rust: impl Json {
pub fn get(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key: Vec<u16> = key.encode_utf16().collect();
    // rust: match self {
    // rust: Json::Obj(entries) => entries.iter().find(|(k, _)| *k == key).map(|(_, v)| v),
    // rust: _ => None,
}
}
pub fn insert(entries: *mut std.ArrayList((Vec<u16)) void {
}
    // rust: if let Some(e) = entries.iter_mut().find(|(k, _)| *k == key) {
    // rust: e.1 = value;
    // rust: } else {
    // rust: entries.push((key, value));
}
}
pub fn object(entries: Vec<([]const u8) void {
}
    // rust: let mut out = Vec::new();
    // rust: for (k, v) in entries {
    // rust: Json::insert(&mut out, k.encode_utf16().collect(), v);
}
    // rust: Json::Obj(out)
}
pub fn string(s: []const u8) J {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Json::Str(s.encode_utf16().collect())
}
}

pub const Mode = enum {
    Strict,
    Lenient,
};

pub const Reader = struct {
    s: *'a [u16],
    pos: usize,
    mode: Mode,
};

    // rust: type R<T> = Result<T, ()>;

    // rust: const fn u(c: char) -> u16 {
    // rust: c as u16
}

    // rust: impl Reader<'_> {
pub fn lenient(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mode == Mode::Lenient
}
pub fn peek_char(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.s.get(self.pos).copied()
}
    /// `JsonReader.nextNonWhitespace`, with comments when lenient.
pub fn skip_ws(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: loop {
    // rust: let Some(c) = self.peek_char() else {
    // rust: return Ok(None);
}
    // rust: match c {
    // rust: 0x20 | 0x0A | 0x09 | 0x0D => self.pos += 1,
    // rust: 0x2F if self.s.get(self.pos + 1) == Some(&u('*'))
    // rust: || self.s.get(self.pos + 1) == Some(&u('/')) =>
    // rust: {
    // rust: if !self.lenient() {
    // rust: return Err(());
}
    // rust: if self.s[self.pos + 1] == u('*') {
    // rust: let start = self.pos + 2;
    // rust: let end = (start..self.s.len().saturating_sub(1))
    // rust: .find(|&i| self.s[i] == u('*') && self.s[i + 1] == u('/'))
    // rust: .ok_or(())?;
    // rust: self.pos = end + 2;
    // rust: } else {
    // rust: self.skip_line();
}
}
    // rust: 0x23 => {
    // rust: if !self.lenient() {
    // rust: return Err(());
}
    // rust: self.skip_line();
}
    // rust: _ => return Ok(Some(c)),
}
}
}
pub fn skip_line(self: *Self) void {
}
    // rust: while let Some(c) = self.peek_char() {
    // rust: self.pos += 1;
    // rust: if c == 0x0A || c == 0x0D {
    // rust: break;
}
}
}
pub fn value(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 255 {
    // rust: return Err(());
}
    // rust: let c = self.skip_ws()?.ok_or(())?;
    // rust: match c {
    // rust: 0x7B => self.object(depth),
    // rust: 0x5B => self.array(depth),
    // rust: 0x22 => {
    // rust: self.pos += 1;
    // rust: Ok(Json::Str(self.quoted(0x22)?))
}
    // rust: 0x27 => {
    // rust: if !self.lenient() {
    // rust: return Err(());
}
    // rust: self.pos += 1;
    // rust: Ok(Json::Str(self.quoted(0x27)?))
}
    // rust: _ => self.literal(),
}
}
pub fn object(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pos += 1;
    // rust: let mut entries = Vec::new();
    // rust: if self.skip_ws()? == Some(u('}')) {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Obj(entries));
}
    // rust: loop {
    // rust: let c = self.skip_ws()?.ok_or(())?;
    // rust: let name = match c {
    // rust: 0x22 => {
    // rust: self.pos += 1;
    // rust: self.quoted(0x22)?
}
    // rust: 0x27 if self.lenient() => {
    // rust: self.pos += 1;
    // rust: self.quoted(0x27)?
}
    // rust: _ if self.lenient() => {
    // rust: let lit = self.unquoted();
    // rust: if lit.is_empty() {
    // rust: return Err(());
}
    // rust: lit
}
    // rust: _ => return Err(()),
}
    // rust: match self.skip_ws()?.ok_or(())? {
    // rust: 0x3A => self.pos += 1,
    // rust: 0x3D if self.lenient() => {
    // rust: self.pos += 1;
    // rust: if self.peek_char() == Some(u('>')) {
    // rust: self.pos += 1;
}
}
    // rust: _ => return Err(()),
}
    // rust: let value = self.value(depth + 1)?;
    // rust: Json::insert(&mut entries, name, value);
    // rust: match self.skip_ws()?.ok_or(())? {
    // rust: 0x7D => {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Obj(entries));
}
    // rust: 0x2C => self.pos += 1,
    // rust: 0x3B if self.lenient() => self.pos += 1,
    // rust: _ => return Err(()),
}
}
}
pub fn array(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pos += 1;
    // rust: let mut out = Vec::new();
    // rust: if self.skip_ws()? == Some(u(']')) {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Arr(out));
}
    // rust: loop {
    // rust: let c = self.skip_ws()?.ok_or(())?;
            // Lenient: an empty element between separators is a null.
    // rust: if self.lenient() && (c == u(',') || c == u(';')) {
    // rust: out.push(Json::Null);
    // rust: self.pos += 1;
    // rust: continue;
}
    // rust: if self.lenient() && c == u(']') {
    // rust: out.push(Json::Null);
    // rust: self.pos += 1;
    // rust: return Ok(Json::Arr(out));
}
    // rust: out.push(self.value(depth + 1)?);
    // rust: match self.skip_ws()?.ok_or(())? {
    // rust: 0x5D => {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Arr(out));
}
    // rust: 0x2C => self.pos += 1,
    // rust: 0x3B if self.lenient() => self.pos += 1,
    // rust: _ => return Err(()),
}
}
}
pub fn quoted(self: *Self, quote: u16) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: loop {
    // rust: let c = self.peek_char().ok_or(())?;
    // rust: self.pos += 1;
    // rust: if c == quote {
    // rust: return Ok(out);
}
    // rust: if c == u('\\') {
    // rust: let e = self.peek_char().ok_or(())?;
    // rust: self.pos += 1;
    // rust: match e {
    // rust: 0x75 => {
    // rust: let hex = self.s.get(self.pos..self.pos + 4).ok_or(())?;
    // rust: let text = String::from_utf16(hex).map_err(|_| ())?;
    // rust: out.push(u16::from_str_radix(&text, 16).map_err(|_| ())?);
    // rust: self.pos += 4;
}
    // rust: 0x74 => out.push(u('\t')),
    // rust: 0x62 => out.push(0x08),
    // rust: 0x6E => out.push(u('\n')),
    // rust: 0x72 => out.push(u('\r')),
    // rust: 0x66 => out.push(0x0C),
    // rust: 0x0A | 0x22 | 0x5C | 0x2F => out.push(e),
    // rust: 0x27 => out.push(e),
    // rust: _ if self.lenient() => out.push(e),
    // rust: _ => return Err(()),
}
    // rust: } else {
    // rust: if !self.lenient() && c < 0x20 {
    // rust: return Err(());
}
    // rust: out.push(c);
}
}
}
pub fn unquoted(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = self.pos;
    // rust: while let Some(c) = self.peek_char() {
    // rust: if matches!(
    // rust: c,
    // rust: 0x2F | 0x5C
    // rust: | 0x3B
    // rust: | 0x23
    // rust: | 0x3D
    // rust: | 0x7B
    // rust: | 0x7D
    // rust: | 0x5B
    // rust: | 0x5D
    // rust: | 0x3A
    // rust: | 0x2C
    // rust: | 0x20
    // rust: | 0x09
    // rust: | 0x0C
    // rust: | 0x0D
    // rust: | 0x0A
    // rust: ) {
    // rust: break;
}
    // rust: self.pos += 1;
}
    // rust: self.s[start..self.pos].to_vec()
}
    /// A keyword, a number, or (lenient) an unquoted string.
pub fn literal(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lit = self.unquoted();
    // rust: if lit.is_empty() {
    // rust: return Err(());
}
    // rust: let text = String::from_utf16_lossy(&lit);
    // rust: for (word, value) in [
    // rust: ("true", Json::Bool(true)),
    // rust: ("false", Json::Bool(false)),
    // rust: ("null", Json::Null),
    // rust: ] {
    // rust: if text.len() == word.len()
    // rust: && text
    // rust: .chars()
    // rust: .zip(word.chars())
    // rust: .all(|(a, b)| a == b || self.lenient() && a == b.to_ascii_uppercase())
    // rust: {
    // rust: return Ok(value);
}
}
    // rust: if is_json_number(&text) {
    // rust: return Ok(Json::Num(text));
}
    // rust: if self.lenient() {
    // rust: return Ok(Json::Str(lit));
}
    // rust: Err(())
}
}

/// `JsonReader.peekNumber`.
pub fn is_json_number(s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = s.as_bytes();
    // rust: let mut i = 0;
    // rust: if b.get(i) == Some(&b'-') {
    // rust: i += 1;
}
    // rust: match b.get(i) {
    // rust: Some(b'0') => {
    // rust: i += 1;
    // rust: if b.get(i).is_some_and(u8::is_ascii_digit) {
    // rust: return false;
}
}
    // rust: Some(c) if c.is_ascii_digit() => {
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

pub fn parse_mode(s: *[u16], mode: Mode) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader { s, pos: 0, mode };
    // rust: let value = r.value(0).ok()?;
    // JsonParser.parseReader: the whole document must be consumed.
    // rust: if r.skip_ws().ok()?.is_some() {
    // rust: if mode == Mode::Lenient && value == Json::Null {
    // rust: return Some(value);
}
    // rust: return None;
}
    // rust: Some(value)
}

/// `LenientJsonParser.parse` (Gson `JsonParser.parseString`).
pub fn parse_lenient(s: *[u16]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse_mode(s, Mode::Lenient)
}
/// `StrictJsonParser.parse`.
pub fn parse_strict(s: *[u16]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse_mode(s, Mode::Strict)
}

/// `GsonHelper.toStableString`: keys in natural (UTF-16) order, Gson escaping.
pub fn to_stable_string(json: *Json) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: write(json, &mut out);
    // rust: out
}
pub fn write(json: *Json, out: *mut std.ArrayList(u16)) void {
}
    // rust: let push = |out: &mut Vec<u16>, s: &str| out.extend(s.encode_utf16());
    // rust: match json {
    // rust: Json::Null => push(out, "null"),
    // rust: Json::Bool(b) => push(out, if *b { "true" } else { "false" }),
    // rust: Json::Num(n) => push(out, n),
    // rust: Json::Str(s) => write_string(s, out),
    // rust: Json::Arr(items) => {
    // rust: out.push(u('['));
    // rust: for (i, item) in items.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(u(','));
}
    // rust: write(item, out);
}
    // rust: out.push(u(']'));
}
    // rust: Json::Obj(entries) => {
    // rust: let mut sorted: Vec<&(Vec<u16>, Json)> = entries.iter().collect();
    // rust: sorted.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: out.push(u('{'));
    // rust: for (i, (k, v)) in sorted.into_iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(u(','));
}
    // rust: write_string(k, out);
    // rust: out.push(u(':'));
    // rust: write(v, out);
}
    // rust: out.push(u('}'));
}
}
}
/// `JsonWriter.string` without HTML escaping.
pub fn write_string(s: *[u16], out: *mut std.ArrayList(u16)) void {
}
    // rust: out.push(u('"'));
    // rust: for &c in s {
    // rust: match c {
    // rust: 0x22 => out.extend("\\\"".encode_utf16()),
    // rust: 0x5C => out.extend("\\\\".encode_utf16()),
    // rust: 0x09 => out.extend("\\t".encode_utf16()),
    // rust: 0x08 => out.extend("\\b".encode_utf16()),
    // rust: 0x0A => out.extend("\\n".encode_utf16()),
    // rust: 0x0D => out.extend("\\r".encode_utf16()),
    // rust: 0x0C => out.extend("\\f".encode_utf16()),
    // rust: c if c < 0x20 || c == 0x2028 || c == 0x2029 => {
    // rust: out.extend(format!("\\u{c:04x}").encode_utf16());
}
    // rust: c => out.push(c),
}
}
    // rust: out.push(u('"'));
}

/// `JsonOps.convertTo(NbtOps)`. Nulls give `None` (an end tag in Java).
pub fn to_nbt(json: *Json) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match json {
    // rust: Json::Null => return None,
    // rust: Json::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Json::Str(s) => Tag::String(JavaString(s.clone())),
    // rust: Json::Num(n) => number_to_nbt(n),
    // rust: Json::Arr(items) => Tag::List(items.iter().filter_map(to_nbt).collect()),
    // rust: Json::Obj(entries) => {
    // rust: let mut c = Compound::new();
    // rust: for (k, v) in entries {
    // rust: if let Some(v) = to_nbt(v) {
    // rust: c.insert(JavaString(k.clone()), v);
}
}
    // rust: Tag::Compound(c)
}
    // rust: })
}

/// `JsonOps.convertTo` for a number: the smallest integer tag that holds an
/// exact integral value, else float when exact, else double.
pub fn number_to_nbt(literal: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(l) = exact_long(literal) {
    // rust: if let Ok(b) = i8::try_from(l) {
    // rust: return Tag::Byte(b);
}
    // rust: if let Ok(s) = i16::try_from(l) {
    // rust: return Tag::Short(s);
}
    // rust: if let Ok(i) = i32::try_from(l) {
    // rust: return Tag::Int(i);
}
    // rust: return Tag::Long(l);
}
    // rust: let d: f64 = literal.parse().unwrap_or(0.0);
    // rust: let f = d as f32;
    // rust: if f64::from(f) == d {
    // rust: Tag::Float(f.to_bits())
    // rust: } else {
    // rust: Tag::Double(d.to_bits())
}
}

/// `BigDecimal.longValueExact` of a JSON number literal.
pub fn exact_long(literal: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mantissa, exponent) = match literal.find(['e', 'E']) {
    // rust: Some(i) => (&literal[..i], literal[i + 1..].parse::<i64>().ok()?),
    // rust: None => (literal, 0),
}
    // rust: let negative = mantissa.starts_with('-');
    // rust: let mantissa = mantissa.trim_start_matches('-');
    // rust: let (int_part, frac) = match mantissa.find('.') {
    // rust: Some(i) => (&mantissa[..i], &mantissa[i + 1..]),
    // rust: None => (mantissa, ""),
}
    // rust: let mut digits: String = format!("{int_part}{frac}");
    // rust: let mut scale = frac.len() as i64 - exponent;
    // Trailing zeros of the unscaled value do not change the value.
    // rust: while scale > 0 && digits.ends_with('0') {
    // rust: digits.pop();
    // rust: scale -= 1;
}
    // rust: if scale > 0 {
    // rust: return None;
}
    // rust: let digits = digits.trim_start_matches('0');
    // rust: if digits.is_empty() {
    // rust: return Some(0);
}
    // rust: if digits.len() as i64 - scale > 19 {
    // rust: return None;
}
    // rust: let mut value: i128 = digits.parse().ok()?;
    // rust: for _ in 0..-scale {
    // rust: value = value.checked_mul(10)?;
}
    // rust: let value = if negative { -value } else { value };
    // rust: i64::try_from(value).ok()
}

/// `NbtOps.convertTo(JsonOps)`.
pub fn from_nbt(tag: *Tag) J {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::End => Json::Null,
    // rust: Tag::Byte(v) => Json::Num(v.to_string()),
    // rust: Tag::Short(v) => Json::Num(v.to_string()),
    // rust: Tag::Int(v) => Json::Num(v.to_string()),
    // rust: Tag::Long(v) => Json::Num(v.to_string()),
    // rust: Tag::Float(v) => Json::Num(java_float_string(f32::from_bits(*v))),
    // rust: Tag::Double(v) => Json::Num(java_double_string(f64::from_bits(*v))),
    // rust: Tag::ByteArray(v) => Json::Arr(
    // rust: v.iter()
    // rust: .map(|b| Json::Num((*b as i8).to_string()))
    // rust: .collect(),
    // rust: ),
    // rust: Tag::IntArray(v) => Json::Arr(v.iter().map(|i| Json::Num(i.to_string())).collect()),
    // rust: Tag::LongArray(v) => Json::Arr(v.iter().map(|l| Json::Num(l.to_string())).collect()),
    // rust: Tag::String(s) => Json::Str(s.0.clone()),
    // rust: Tag::List(items) => Json::Arr(items.iter().map(from_nbt).collect()),
    // rust: Tag::Compound(c) => Json::Obj(c.iter().map(|(k, v)| (k.0.clone(), from_nbt(v))).collect()),
}
}

/// Java `Double.toString`.
pub fn java_double_string(d: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: java_fp_string(d, format!("{d:e}"))
}
/// Java `Float.toString`.
pub fn java_float_string(f: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: java_fp_string(f64::from(f), format!("{f:e}"))
}
pub fn java_fp_string(d: f64, sci: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if d.is_nan() {
    // rust: return "NaN".into();
}
    // rust: if d.is_infinite() {
    // rust: return if d > 0.0 { "Infinity" } else { "-Infinity" }.into();
}
    // rust: if d == 0.0 {
    // rust: return if d.is_sign_negative() { "-0.0" } else { "0.0" }.into();
}
    // `sci` is Rust's shortest round-trip form: d.ddde<exp>.
    // rust: let (mantissa, exp) = sci.split_once('e').unwrap_or((&sci, "0"));
    // rust: let exp: i32 = exp.parse().unwrap_or(0);
    // rust: let negative = mantissa.starts_with('-');
    // rust: let digits: String = mantissa.chars().filter(char::is_ascii_digit).collect();
    // rust: let sign = if negative { "-" } else { "" };
    // rust: let a = d.abs();
    // rust: if (1e-3..1e7).contains(&a) {
    // rust: if exp >= 0 {
    // rust: let e = exp as usize;
    // rust: let (int, frac) = if digits.len() > e + 1 {
    // rust: (digits[..=e].to_string(), digits[e + 1..].to_string())
    // rust: } else {
    // rust: (format!("{digits:0<width$}", width = e + 1), String::new())
}
    // rust: let frac = if frac.is_empty() { "0".into() } else { frac };
    // rust: format!("{sign}{int}.{frac}")
    // rust: } else {
    // rust: let zeros = "0".repeat((-exp - 1) as usize);
    // rust: format!("{sign}0.{zeros}{digits}")
}
    // rust: } else {
    // rust: if digits.len() == 1 {
            // Select the nearest two-digit decimal, rather than padding the
            // one-digit round-trip form; Java can choose a different exponent.
    // rust: return format!("{d:.1e}").replace('e', "E");
}
    // rust: let (first, rest) = digits.split_at(1);
    // rust: format!("{sign}{first}.{rest}E{exp}")
}
}

/// A string value as a JSON text component (`{"text": s}`), stable string.
pub fn text_component_json(text: *[u16]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: to_stable_string(&Json::Obj(vec![(
    // rust: "text".encode_utf16().collect(),
    // rust: Json::Str(text.to_vec()),
    // rust: )]))
}
pub fn translatable_component_json(key: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: to_stable_string(&Json::object(vec![("translate", Json::string(key))]))
}

    // rust: mod tests {
//     use super::*;
pub fn w(s: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.encode_utf16().collect()
}
pub fn numbers_become_the_smallest_tag() void {
}
    // rust: let tag = |s: &str| to_nbt(&parse_strict(&w(s)).unwrap()).unwrap();
    // rust: assert_eq!(tag("1"), Tag::Byte(1));
    // rust: assert_eq!(tag("1.0"), Tag::Byte(1));
    // rust: assert_eq!(tag("1e2"), Tag::Byte(100));
    // rust: assert_eq!(tag("300"), Tag::Short(300));
    // rust: assert_eq!(tag("1.5"), Tag::Float(1.5f32.to_bits()));
    // rust: assert_eq!(tag("0.1"), Tag::Double(0.1f64.to_bits()));
    // rust: assert_eq!(tag("3000000000"), Tag::Long(3_000_000_000));
}
pub fn lenient_reads_what_strict_refuses() void {
}
    // rust: assert!(parse_strict(&w("hello")).is_none());
    // rust: assert_eq!(parse_lenient(&w("hello")), Some(Json::string("hello")));
    // rust: assert!(parse_lenient(&w("hello world")).is_none());
    // rust: assert_eq!(
    // rust: parse_lenient(&w("{a:'b'}")),
    // rust: Some(Json::object(vec![("a", Json::string("b"))]))
    // rust: );
}
pub fn stable_strings_sort_keys() void {
}
    // rust: let j = parse_strict(&w(r#"{"text":"a","color":"red"}"#)).unwrap();
    // rust: assert_eq!(
    // rust: String::from_utf16(&to_stable_string(&j)).unwrap(),
    // rust: r#"{"color":"red","text":"a"}"#
    // rust: );
}
pub fn java_floating_point_strings() void {
}
    // rust: assert_eq!(java_float_string(f32::from_bits(1)), "1.4E-45");
    // rust: assert_eq!(java_float_string(f32::from_bits(0x8000_0007)), "-9.8E-45");
    // rust: assert_eq!(java_double_string(f64::from_bits(1)), "4.9E-324");
    // rust: assert_eq!(
    // rust: java_double_string(f64::from_bits(0x8000_0000_0000_0002)),
    // rust: "-9.9E-324"
    // rust: );
    // rust: assert_eq!(java_double_string(1.0), "1.0");
    // rust: assert_eq!(java_double_string(0.001), "0.001");
    // rust: assert_eq!(java_double_string(1e7), "1.0E7");
    // rust: assert_eq!(java_double_string(123456.789), "123456.789");
    // rust: assert_eq!(java_double_string(1e-4), "1.0E-4");
    // rust: assert_eq!(java_float_string(0.1), "0.1");
    // rust: assert_eq!(java_float_string(1.5e10), "1.5E10");
}
}
