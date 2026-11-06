//! Transpiled from Horizon Rust crate
package horizon_prepare_pyjson

import "core:fmt"
import "core:mem"
import "core:math"

// JSON read and written exactly as Python's `json` module does, so the files this crate writes
// are byte for byte the ones `tools/prepare_native_client.py` wrote: objects keep their key
// order (a repeated key keeps its first place and its last value), integers keep every digit,
// floats print as Python's `repr`, and strings are escaped as `ensure_ascii=True` escapes them.

// use std::fmt::Write;

Value :: enum {
    Null,
    Bool(bool),
    // A JSON integer, kept as its decimal digits (Python's integers have no size limit).
    Int(String),
    Float(f64),
    Str(String),
    Array(Vec<Value>),
    Object(Vec<(String, Value)>),
}

    // rust: impl Value {
str :: proc(s: impl Into<string>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Value::Str(s.into())
}

get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Value::Object(fields) => fields.iter().find(|(k, _)| k == key).map(|(_, v)| v),
    // rust: _ => None,
}
}

index :: proc(self: ^Self, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Value::Array(items) => items.get(i),
    // rust: _ => None,
}
}

as_str :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Value::Str(s) => Some(s),
    // rust: _ => None,
}
}

as_array :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Value::Array(items) => Some(items),
    // rust: _ => None,
}
}

as_object :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Value::Object(fields) => Some(fields),
    // rust: _ => None,
}
}

as_i64 :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Value::Int(digits) => digits.parse().ok(),
    // rust: _ => None,
}
}

    // `dict[key] = value`: a new key goes last, an existing one keeps its place.
insert :: proc(self: ^Self, key: string, value: Value) {
}
    // rust: if let Value::Object(fields) = self {
    // rust: match fields.iter_mut().find(|(k, _)| k == key) {
    // rust: Some(field) => field.1 = value,
    // rust: None => fields.push((key.to_string(), value)),
}
}
}
}

// Python's `==`: objects compare without regard to key order, and 1 == 1.0.
    // rust: impl PartialEq for Value {
eq :: proc(self: ^Self, other: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (self, other) {
    // rust: (Value::Null, Value::Null) => true,
    // rust: (Value::Bool(a), Value::Bool(b)) => a == b,
    // rust: (Value::Int(a), Value::Int(b)) => a == b,
    // rust: (Value::Float(a), Value::Float(b)) => a == b,
    // rust: (Value::Int(a), Value::Float(b)) | (Value::Float(b), Value::Int(a)) => {
    // rust: a.parse::<f64>().is_ok_and(|a| a == *b && b.fract() == 0.0)
}
    // rust: (Value::Str(a), Value::Str(b)) => a == b,
    // rust: (Value::Array(a), Value::Array(b)) => a == b,
    // rust: (Value::Object(a), Value::Object(b)) => {
    // rust: a.len() == b.len() && a.iter().all(|(k, v)| other.get(k) == Some(v))
}
    // rust: _ => false,
}
}
}

loads :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut parser = Parser {
    // rust: text: text.as_bytes(),
    // rust: at: 0,
}
    // rust: parser.space();
    // rust: let value = parser.value()?;
    // rust: parser.space();
    // rust: if parser.at != parser.text.len() {
    // rust: return Err(parser.error("Extra data"));
}
    // rust: Ok(value)
}

Parser :: struct {
    text: ^'a [u8],
    at: uint,
}

    // rust: impl Parser<'_> {
error :: proc(self: ^Self, what: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{what} at byte {}", self.at)
}

space :: proc(self: ^Self) {
}
    // rust: while matches!(self.text.get(self.at), Some(b' ' | b'\t' | b'\n' | b'\r')) {
    // rust: self.at += 1;
}
}

literal :: proc(self: ^Self, word: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.text[self.at..].starts_with(word.as_bytes()) {
    // rust: self.at += word.len();
    // rust: true
    // rust: } else {
    // rust: false
}
}

value :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match self.text.get(self.at) {
    // rust: Some(b'{') => {
    // rust: self.at += 1;
    // rust: let mut object = Value::Object(Vec::new());
    // rust: self.space();
    // rust: if self.text.get(self.at) == Some(&b'}') {
    // rust: self.at += 1;
    // rust: return Ok(object);
}
    // rust: loop {
    // rust: self.space();
    // rust: if self.text.get(self.at) != Some(&b'"') {
    // rust: return Err(self.error("Expecting property name enclosed in double quotes"));
}
    // rust: let key = self.string()?;
    // rust: self.space();
    // rust: if self.text.get(self.at) != Some(&b':') {
    // rust: return Err(self.error("Expecting ':' delimiter"));
}
    // rust: self.at += 1;
    // rust: self.space();
    // rust: let value = self.value()?;
    // rust: object.insert(&key, value);
    // rust: self.space();
    // rust: match self.text.get(self.at) {
    // rust: Some(b',') => self.at += 1,
    // rust: Some(b'}') => {
    // rust: self.at += 1;
    // rust: return Ok(object);
}
    // rust: _ => return Err(self.error("Expecting ',' delimiter")),
}
}
}
    // rust: Some(b'[') => {
    // rust: self.at += 1;
    // rust: let mut items = Vec::new();
    // rust: self.space();
    // rust: if self.text.get(self.at) == Some(&b']') {
    // rust: self.at += 1;
    // rust: return Ok(Value::Array(items));
}
    // rust: loop {
    // rust: self.space();
    // rust: items.push(self.value()?);
    // rust: self.space();
    // rust: match self.text.get(self.at) {
    // rust: Some(b',') => self.at += 1,
    // rust: Some(b']') => {
    // rust: self.at += 1;
    // rust: return Ok(Value::Array(items));
}
    // rust: _ => return Err(self.error("Expecting ',' delimiter")),
}
}
}
    // rust: Some(b'"') => Ok(Value::Str(self.string()?)),
    // rust: Some(b'n') if self.literal("null") => Ok(Value::Null),
    // rust: Some(b't') if self.literal("true") => Ok(Value::Bool(true)),
    // rust: Some(b'f') if self.literal("false") => Ok(Value::Bool(false)),
    // rust: Some(b'N') if self.literal("NaN") => Ok(Value::Float(f64::NAN)),
    // rust: Some(b'I') if self.literal("Infinity") => Ok(Value::Float(f64::INFINITY)),
    // rust: Some(b'-') if self.literal("-Infinity") => Ok(Value::Float(f64::NEG_INFINITY)),
    // rust: Some(b'-' | b'0'..=b'9') => self.number(),
    // rust: _ => Err(self.error("Expecting value")),
}
}

    // Python's NUMBER_RE: `(-?(?:0|[1-9]\d*))(\.\d+)?([eE][-+]?\d+)?`.
number :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.at;
    // rust: let digits = |p: &mut Self| {
    // rust: let from = p.at;
    // rust: while p.text.get(p.at).is_some_and(u8::is_ascii_digit) {
    // rust: p.at += 1;
}
    // rust: p.at - from
}
    // rust: if self.text.get(self.at) == Some(&b'-') {
    // rust: self.at += 1;
}
    // rust: if self.text.get(self.at) == Some(&b'0') {
    // rust: self.at += 1;
    // rust: } else if digits(self) == 0 {
    // rust: self.at = start;
    // rust: return Err(self.error("Expecting value"));
}
    // rust: let integer_end = self.at;
    // rust: let mut float = false;
    // rust: if self.text.get(self.at) == Some(&b'.') {
    // rust: let dot = self.at;
    // rust: self.at += 1;
    // rust: if digits(self) == 0 {
    // rust: self.at = dot;
    // rust: } else {
    // rust: float = true;
}
}
    // rust: if matches!(self.text.get(self.at), Some(b'e' | b'E')) {
    // rust: let mark = self.at;
    // rust: self.at += 1;
    // rust: if matches!(self.text.get(self.at), Some(b'-' | b'+')) {
    // rust: self.at += 1;
}
    // rust: if digits(self) == 0 {
    // rust: self.at = mark;
    // rust: } else {
    // rust: float = true;
}
}
    // rust: let text = std::str::from_utf8(&self.text[start..self.at]).unwrap();
    // rust: if float {
    // rust: text.parse::<f64>()
    // rust: .map(Value::Float)
    // rust: .map_err(|e| e.to_string())
    // rust: } else {
    // rust: debug_assert_eq!(self.at, integer_end);
    // rust: Ok(Value::Int(if text == "-0" {
    // rust: "0".into()
    // rust: } else {
    // rust: text.into()
    // rust: }))
}
}

hex4 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let digits = self
    // rust: .text
    // rust: .get(self.at..self.at + 4)
    // rust: .and_then(|d| std::str::from_utf8(d).ok())
    // rust: .filter(|d| d.bytes().all(|b| b.is_ascii_hexdigit()))
    // rust: .ok_or_else(|| self.error("Invalid \\uXXXX escape"))?;
    // rust: self.at += 4;
    // rust: Ok(u32::from_str_radix(digits, 16).unwrap())
}

string :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.at += 1;
    // rust: let mut out = String::new();
    // rust: loop {
    // rust: let run = self.at;
    // rust: while self
    // rust: .text
    // rust: .get(self.at)
    // rust: .is_some_and(|&b| b != b'"' && b != b'\\' && b >= 0x20)
    // rust: {
    // rust: self.at += 1;
}
    // rust: out.push_str(std::str::from_utf8(&self.text[run..self.at]).map_err(|e| e.to_string())?);
    // rust: match self.text.get(self.at) {
    // rust: Some(b'"') => {
    // rust: self.at += 1;
    // rust: return Ok(out);
}
    // rust: Some(b'\\') => {
    // rust: self.at += 1;
    // rust: let escape = *self
    // rust: .text
    // rust: .get(self.at)
    // rust: .ok_or_else(|| self.error("Unterminated string"))?;
    // rust: self.at += 1;
    // rust: match escape {
    // rust: b'"' => out.push('"'),
    // rust: b'\\' => out.push('\\'),
    // rust: b'/' => out.push('/'),
    // rust: b'b' => out.push('\u{8}'),
    // rust: b'f' => out.push('\u{c}'),
    // rust: b'n' => out.push('\n'),
    // rust: b'r' => out.push('\r'),
    // rust: b't' => out.push('\t'),
    // rust: b'u' => {
    // rust: let mut code = self.hex4()?;
    // rust: if (0xd800..0xdc00).contains(&code)
    // rust: && self.text[self.at..].starts_with(b"\\u")
    // rust: {
    // rust: let back = self.at;
    // rust: self.at += 2;
    // rust: let low = self.hex4()?;
    // rust: if (0xdc00..0xe000).contains(&low) {
    // rust: code = 0x10000 + ((code - 0xd800) << 10) + (low - 0xdc00);
    // rust: } else {
    // rust: self.at = back;
}
}
    // rust: out.push(char::from_u32(code).ok_or_else(|| {
    // rust: self.error(
    // rust: "Lone surrogate (Python keeps it; Horizon's files have none)",
    // rust: )
    // rust: })?);
}
    // rust: _ => return Err(self.error("Invalid \\escape")),
}
}
    // rust: _ => return Err(self.error("Unterminated string or control character")),
}
}
}
}

// `json.dumps(value, indent=indent, separators=(item, key))` with `ensure_ascii=True`.
// Python's defaults are `(", ", ": ")` without an indent and `(",", ": ")` with one.
Format :: struct {
    indent: Maybe(uint),
    item: ^'static str,
    key: ^'static str,
}

// `json.dumps(value)`.
    // rust: pub const DEFAULT: Format = Format {
    // rust: indent: None,
    // rust: item: ", ",
    // rust: key: ": ",
}
// `json.dumps(value, separators=(',', ':'))`.
    // rust: pub const COMPACT: Format = Format {
    // rust: indent: None,
    // rust: item: ",",
    // rust: key: ":",
}
// `json.dumps(value, indent=2)`.
    // rust: pub const INDENT2: Format = Format {
    // rust: indent: Some(2),
    // rust: item: ",",
    // rust: key: ": ",
}

dumps :: proc(value: ^Value, format: ^Format) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: write_value(&mut out, value, format, 0);
    // rust: out
}

newline :: proc(out: ^string, format: ^Format, level: uint) {
}
    // rust: if let Some(indent) = format.indent {
    // rust: out.push('\n');
    // rust: out.extend(std::iter::repeat_n(' ', indent * level));
}
}

write_value :: proc(out: ^string, value: ^Value, format: ^Format, level: uint) {
}
    // rust: match value {
    // rust: Value::Null => out.push_str("null"),
    // rust: Value::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
    // rust: Value::Int(digits) => out.push_str(digits),
    // rust: Value::Float(f) => out.push_str(&float_repr(*f)),
    // rust: Value::Str(s) => write_string(out, s),
    // rust: Value::Array(items) => {
    // rust: if items.is_empty() {
    // rust: out.push_str("[]");
    // rust: return;
}
    // rust: out.push('[');
    // rust: for (i, item) in items.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push_str(format.item);
}
    // rust: newline(out, format, level + 1);
    // rust: write_value(out, item, format, level + 1);
}
    // rust: newline(out, format, level);
    // rust: out.push(']');
}
    // rust: Value::Object(fields) => {
    // rust: if fields.is_empty() {
    // rust: out.push_str("{}");
    // rust: return;
}
    // rust: out.push('{');
    // rust: for (i, (key, item)) in fields.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push_str(format.item);
}
    // rust: newline(out, format, level + 1);
    // rust: write_string(out, key);
    // rust: out.push_str(format.key);
    // rust: write_value(out, item, format, level + 1);
}
    // rust: newline(out, format, level);
    // rust: out.push('}');
}
}
}

// Python's `py_encode_basestring_ascii`: every character outside space..`~` is escaped,
// with lowercase hex and surrogate pairs above the BMP.
write_string :: proc(out: ^string, s: string) {
}
    // rust: out.push('"');
    // rust: for c in s.chars() {
    // rust: match c {
    // rust: '"' => out.push_str("\\\""),
    // rust: '\\' => out.push_str("\\\\"),
    // rust: '\n' => out.push_str("\\n"),
    // rust: '\r' => out.push_str("\\r"),
    // rust: '\t' => out.push_str("\\t"),
    // rust: '\u{8}' => out.push_str("\\b"),
    // rust: '\u{c}' => out.push_str("\\f"),
    // rust: ' '..='~' => out.push(c),
    // rust: _ => {
    // rust: let mut units = [0u16; 2];
    // rust: for unit in c.encode_utf16(&mut units) {
    // rust: let _ = write!(out, "\\u{unit:04x}");
}
}
}
}
    // rust: out.push('"');
}

// Python's `repr(float)`: the shortest digits that read back the same, in fixed notation when
// the decimal point falls between 10^-4 and 10^16, with `.0` on whole numbers.
float_repr :: proc(f: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if f.is_nan() {
    // rust: return "NaN".into();
}
    // rust: if f.is_infinite() {
    // rust: return if f > 0.0 { "Infinity" } else { "-Infinity" }.into();
}
    // Rust's `{:e}` gives the same shortest round-trip digits: "d.ddde-x".
    // rust: let scientific = format!("{:e}", f.abs());
    // rust: let (mantissa, exponent) = scientific.split_once('e').unwrap();
    // rust: let digits: String = mantissa.chars().filter(|c| *c != '.').collect();
    // rust: let exponent: i32 = exponent.parse().unwrap();
    // rust: let point = exponent + 1; // The value is 0.digits * 10^point.
    // rust: let sign = if f.is_sign_negative() { "-" } else { "" };
    // rust: let n = digits.len() as i32;
    // rust: if f == 0.0 {
    // rust: return format!("{sign}0.0");
}
    // rust: if -4 < point && point <= 16 {
    // rust: if point <= 0 {
    // rust: format!("{sign}0.{}{digits}", "0".repeat((-point) as usize))
    // rust: } else if point >= n {
    // rust: format!("{sign}{digits}{}.0", "0".repeat((point - n) as usize))
    // rust: } else {
    // rust: let (whole, fraction) = digits.split_at(point as usize);
    // rust: format!("{sign}{whole}.{fraction}")
}
    // rust: } else {
    // rust: let (first, rest) = digits.split_at(1);
    // rust: let mantissa = if rest.is_empty() {
    // rust: first.to_string()
    // rust: } else {
    // rust: format!("{first}.{rest}")
}
    // rust: let e = point - 1;
    // rust: format!(
    // rust: "{sign}{mantissa}e{}{:02}",
    // rust: if e < 0 { '-' } else { '+' },
    // rust: e.abs()
    // rust: )
}
}

    // rust: mod tests {
//     use super::*;

floats_print_as_python_repr :: proc() {
}
    // rust: for (f, repr) in [
    // rust: (0.0, "0.0"),
    // rust: (-0.0, "-0.0"),
    // rust: (1.0, "1.0"),
    // rust: (0.1, "0.1"),
    // rust: (1.5e-5, "1.5e-05"),
    // rust: (0.0001, "0.0001"),
    // rust: (1e16, "1e+16"),
    // rust: (1234567890123456.0, "1234567890123456.0"),
    // rust: (12345678901234567.0, "1.2345678901234568e+16"),
    // rust: (-2.5, "-2.5"),
    // rust: (1e-310, "1e-310"),
    // rust: (f64::MAX, "1.7976931348623157e+308"),
    // rust: (100.0, "100.0"),
    // rust: (0.30000000000000004, "0.30000000000000004"),
    // rust: ] {
    // rust: assert_eq!(float_repr(f), repr, "{f}");
}
}

strings_escape_as_ensure_ascii :: proc() {
}
    // rust: let mut out = String::new();
    // rust: write_string(&mut out, "a\"\\\n\u{7f}é\u{1F600}\u{1}");
    // rust: assert_eq!(out, "\"a\\\"\\\\\\n\\u007f\\u00e9\\ud83d\\ude00\\u0001\"");
}

objects_keep_first_place_and_last_value :: proc() {
}
    // rust: let v = loads(r#"{"b": 1, "a": [1.0, -0, 1e2, true, null], "b": 2}"#).unwrap();
    // rust: assert_eq!(
    // rust: dumps(&v, &DEFAULT),
    // rust: r#"{"b": 2, "a": [1.0, 0, 100.0, true, null]}"#
    // rust: );
    // rust: assert_eq!(
    // rust: dumps(&v, &INDENT2),
    // rust: "{\n  \"b\": 2,\n  \"a\": [\n    1.0,\n    0,\n    100.0,\n    true,\n    null\n  ]\n}"
    // rust: );
    // rust: assert_eq!(
    // rust: dumps(&loads("{\"x\":{},\"y\":[]}").unwrap(), &INDENT2),
    // rust: "{\n  \"x\": {},\n  \"y\": []\n}"
    // rust: );
}
}
