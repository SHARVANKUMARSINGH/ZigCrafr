//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_json
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use serde_json::value::RawValue;
// use std::{collections::BTreeMap, fmt};

pub const DecodeError = struct {};

    // rust: impl fmt::Display for DecodeError {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(&self.0)
}
}
    // rust: impl std::error::Error for DecodeError {}
    // rust: impl From<serde_json::Error> for DecodeError {
pub fn from(value: serde_json::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(value.to_string())
}
}
    // rust: pub(crate) type Result<T> = std::result::Result<T, DecodeError>;
    // rust: pub(crate) type Object<'a> = BTreeMap<String, &'a RawValue>;
    // rust: pub(crate) fn error(message: &str) -> DecodeError {
    // rust: DecodeError(message.to_owned())
}
/// Whether a syntactically valid JSON number is classified as numeric by the
/// native reader. Its wrapping i64 scanner can hit zero after overflow, causing
/// the next integer digit to be rejected as if it followed a leading zero.
    // rust: pub(crate) fn native_number_token(token: &str) -> bool {
    // rust: if token.len() >= 1024 {
    // rust: return false;
}
    // rust: let mut accumulator = 0i64;
    // rust: for (index, digit) in token
    // rust: .trim_start_matches('-')
    // rust: .bytes()
    // rust: .take_while(u8::is_ascii_digit)
    // rust: .enumerate()
    // rust: {
    // rust: if index > 0 && accumulator == 0 {
    // rust: return false;
}
    // rust: accumulator = accumulator
    // rust: .wrapping_mul(10)
    // rust: .wrapping_sub(i64::from(digit - b'0'));
}
    // rust: true
}
/// Strict stream parsing rejects numeric scanner failures everywhere, including
/// ignored fields. Quoted copies of those tokens remain ordinary strings.
    // rust: pub(crate) fn validate_number_tokens(raw: &RawValue) -> Result<()> {
    // rust: let text = raw.get();
    // rust: let mut quoted = false;
    // rust: let mut escaped = false;
    // rust: let mut start = None;
    // rust: for (index, byte) in text.bytes().enumerate() {
    // rust: if quoted {
    // rust: if escaped {
    // rust: escaped = false;
    // rust: } else if byte == b'\\' {
    // rust: escaped = true;
    // rust: } else if byte == b'"' {
    // rust: quoted = false;
}
    // rust: continue;
}
    // rust: if let Some(begin) = start {
    // rust: if byte.is_ascii_digit() || b"-.eE+".contains(&byte) {
    // rust: continue;
}
    // rust: if !native_number_token(&text[begin..index]) {
    // rust: return Err(error("native reader rejects numeric token"));
}
    // rust: start = None;
}
    // rust: if byte == b'"' {
    // rust: quoted = true;
    // rust: } else if byte.is_ascii_digit() || byte == b'-' {
    // rust: start = Some(index);
}
}
    // rust: if start.is_some_and(|begin| !native_number_token(&text[begin..])) {
    // rust: return Err(error("native reader rejects numeric token"));
}
    // rust: Ok(())
}
    // rust: pub(crate) fn object(raw: &RawValue) -> Result<Object<'_>> {
    // rust: if !raw.get().starts_with('{') {
    // rust: return Err(error("expected object"));
}
    // rust: Ok(serde_json::from_str(raw.get())?)
}
/// The members of an object in document order, which `object` loses.
    // rust: pub(crate) fn ordered_object(raw: &RawValue) -> Result<Vec<(String, &RawValue)>> {
pub const Members = struct {};
    // rust: impl<'de> serde::Deserialize<'de> for Members<'de> {
    // rust: fn deserialize<D: serde::Deserializer<'de>>(
    // rust: deserializer: D,
    // rust: ) -> std::result::Result<Self, D::Error> {
pub const Visitor = struct {};
    // rust: impl<'de> serde::de::Visitor<'de> for Visitor {
    // rust: type Value = Members<'de>;
pub fn expecting(self: *Self, f: *mut fmt::Formatter) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("an object")
}
    // rust: fn visit_map<A: serde::de::MapAccess<'de>>(
    // rust: self,
    // rust: mut map: A,
    // rust: ) -> std::result::Result<Self::Value, A::Error> {
    // rust: let mut members: Vec<(String, &'de RawValue)> = Vec::new();
    // rust: while let Some(entry) = map.next_entry::<String, &'de RawValue>()? {
    // rust: members.retain(|(name, _)| *name != entry.0);
    // rust: members.push(entry);
}
    // rust: Ok(Members(members))
}
}
    // rust: deserializer.deserialize_map(Visitor)
}
}
    // rust: if !raw.get().starts_with('{') {
    // rust: return Err(error("expected object"));
}
    // rust: Ok(serde_json::from_str::<Members>(raw.get())?.0)
}
    // rust: pub(crate) fn array(raw: &RawValue) -> Result<Vec<&RawValue>> {
    // rust: Ok(serde_json::from_str(raw.get())?)
}
    // rust: pub(crate) fn required<'a>(object: &Object<'a>, key: &str) -> Result<&'a RawValue> {
    // rust: object
    // rust: .get(key)
    // rust: .copied()
    // rust: .ok_or_else(|| error(&format!("missing {key}")))
}
    // rust: pub(crate) fn string(raw: &RawValue) -> Result<String> {
    // rust: Ok(serde_json::from_str(raw.get())?)
}
/// Gson's string helper accepts any primitive and preserves a number's spelling.
    // rust: pub(crate) fn primitive_string(raw: &RawValue) -> Result<String> {
    // rust: match raw.get().as_bytes().first() {
    // rust: Some(b'"') => string(raw),
    // rust: Some(b't' | b'f' | b'-' | b'0'..=b'9') => Ok(raw.get().to_owned()),
    // rust: _ => Err(error("expected primitive")),
}
}
    // rust: pub(crate) fn boolean(raw: &RawValue) -> Result<bool> {
    // rust: Ok(primitive_string(raw)?.eq_ignore_ascii_case("true"))
}
pub fn number(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match raw.get().as_bytes().first() {
    // rust: Some(b'-' | b'0'..=b'9') => Ok(raw.get()),
    // rust: _ => Err(error("expected number")),
}
}
    // rust: pub(crate) fn float(raw: &RawValue) -> Result<f32> {
    // rust: number(raw)?.parse().map_err(|_| error("invalid float"))
}
/// Gson LazilyParsedNumber.intValue truncates decimals then keeps the low 32 bits.
/// Work on decimal digits, avoiding f64 rounding and saturating Rust casts.
    // rust: pub(crate) fn integer(raw: &RawValue) -> Result<i32> {
    // rust: let raw = number(raw)?;
    // rust: if raw.len() > 10_000 {
    // rust: return Err(error("number string too long"));
}
    // rust: let negative = raw.starts_with('-');
    // rust: let raw = raw.strip_prefix('-').unwrap_or(raw);
    // rust: let (mantissa, exponent) = raw.split_once(['e', 'E']).unwrap_or((raw, "0"));
    // rust: let exponent: i32 = exponent.parse().map_err(|_| error("invalid exponent"))?;
    // rust: let fractional = mantissa.split_once('.').map_or(0, |(_, f)| f.len());
    // rust: let scale =
    // rust: i64::try_from(fractional).map_err(|_| error("number too long"))? - i64::from(exponent);
    // rust: if scale.abs() >= 10_000 {
    // rust: return Err(error("unsupported decimal scale"));
}
    // rust: let digits = mantissa.bytes().filter(|c| *c != b'.');
    // rust: let count = mantissa.len() - usize::from(mantissa.contains('.'));
    // rust: let take = (count as i64 - scale.max(0)).max(0) as usize;
    // rust: let mut value = 0u32;
    // rust: for digit in digits.take(take) {
    // rust: value = value.wrapping_mul(10).wrapping_add(u32::from(digit - b'0'));
}
    // rust: if scale < 0 {
        // 10^32 and larger are divisible by 2^32.
    // rust: value = if scale <= -32 {
    // rust: 0
    // rust: } else {
    // rust: value.wrapping_mul(10u32.wrapping_pow((-scale) as u32))
}
}
    // rust: Ok(if negative {
    // rust: value.wrapping_neg()
    // rust: } else {
    // rust: value
    // rust: } as i32)
}
    // rust: pub(crate) fn vector<const N: usize>(raw: &RawValue) -> Result<[f32; N]> {
    // rust: let values = array(raw)?;
    // rust: if values.len() != N {
    // rust: return Err(error("wrong vector length"));
}
    // rust: let mut result = [0.0; N];
    // rust: for (target, value) in result.iter_mut().zip(values) {
    // rust: *target = float(value)?;
}
    // rust: Ok(result)
}
    // rust: pub(crate) fn identifier(name: &str) -> Result<String> {
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let namespace = if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: let valid = |c: u8| c.is_ascii_lowercase() || c.is_ascii_digit() || b"_.-".contains(&c);
    // rust: if !namespace.bytes().all(valid) || !path.bytes().all(|c| valid(c) || c == b'/') {
    // rust: return Err(error("invalid resource identifier"));
}
    // rust: Ok(format!("{namespace}:{path}"))
}
