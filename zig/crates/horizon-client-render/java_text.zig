//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_java_text
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Java text conventions the vanilla option files depend on: shortest-digit
//! `Double.toString`/`Float.toString`, Gson's HTML-safe string escaping and a
//! reader for Gson's lenient JSON (`JsonParser.parseString`).

/// Digits and decimal exponent of the shortest round-trip form.
pub fn shortest(text: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // `{:e}` yields "d.ddde-5" or "de5".
    // rust: let (mantissa, exponent) = text.split_once('e').unwrap_or((text, "0"));
    // rust: let digits: String = mantissa.chars().filter(char::is_ascii_digit).collect();
    // rust: (digits, exponent.parse().unwrap_or(0))
}

pub fn render(negative: bool, digits: []const u8, exponent: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::new();
    // rust: if negative {
    // rust: out.push('-');
}
    // rust: let digits = if digits.is_empty() { "0" } else { digits };
    // rust: if (-3..7).contains(&exponent) {
    // rust: if exponent >= 0 {
    // rust: let int_len = exponent as usize + 1;
    // rust: if digits.len() <= int_len {
    // rust: out.push_str(digits);
    // rust: out.extend(std::iter::repeat_n('0', int_len - digits.len()));
    // rust: out.push_str(".0");
    // rust: } else {
    // rust: out.push_str(&digits[..int_len]);
    // rust: out.push('.');
    // rust: out.push_str(&digits[int_len..]);
}
    // rust: } else {
    // rust: out.push_str("0.");
    // rust: out.extend(std::iter::repeat_n('0', (-exponent - 1) as usize));
    // rust: out.push_str(digits);
}
    // rust: } else {
    // rust: out.push_str(&digits[..1]);
    // rust: out.push('.');
    // rust: if digits.len() > 1 {
    // rust: out.push_str(&digits[1..]);
    // rust: } else {
    // rust: out.push('0');
}
    // rust: out.push('E');
    // rust: out.push_str(&exponent.to_string());
}
    // rust: out
}

/// `Double.toString`.
pub fn double_to_string(value: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value.is_nan() {
    // rust: return "NaN".into();
}
    // rust: if value.is_infinite() {
    // rust: return if value < 0.0 { "-Infinity" } else { "Infinity" }.into();
}
    // rust: if value == 0.0 {
    // rust: return if value.is_sign_negative() {
    // rust: "-0.0"
    // rust: } else {
    // rust: "0.0"
}
    // rust: .into();
}
    // rust: let (digits, exponent) = shortest(&format!("{:e}", value.abs()));
    // rust: render(value < 0.0, &digits, exponent)
}

/// `Float.toString`.
pub fn float_to_string(value: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value.is_nan() {
    // rust: return "NaN".into();
}
    // rust: if value.is_infinite() {
    // rust: return if value < 0.0 { "-Infinity" } else { "Infinity" }.into();
}
    // rust: if value == 0.0 {
    // rust: return if value.is_sign_negative() {
    // rust: "-0.0"
    // rust: } else {
    // rust: "0.0"
}
    // rust: .into();
}
    // rust: let (digits, exponent) = shortest(&format!("{:e}", value.abs()));
    // rust: render(value < 0.0, &digits, exponent)
}

/// Gson's default (HTML-safe) JSON string literal.
pub fn gson_string(value: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::from("\"");
    // rust: for c in value.chars() {
    // rust: match c {
    // rust: '"' => out.push_str("\\\""),
    // rust: '\\' => out.push_str("\\\\"),
    // rust: '\n' => out.push_str("\\n"),
    // rust: '\r' => out.push_str("\\r"),
    // rust: '\t' => out.push_str("\\t"),
    // rust: '\u{8}' => out.push_str("\\b"),
    // rust: '\u{c}' => out.push_str("\\f"),
    // rust: '<' | '>' | '&' | '=' | '\'' | '\u{2028}' | '\u{2029}' => {
    // rust: out.push_str(&format!("\\u{:04x}", c as u32));
}
    // rust: c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
    // rust: c => out.push(c),
}
}
    // rust: out.push('"');
    // rust: out
}

/// A parsed JSON element as Gson models it.
pub const Json = enum {
    Null,
    Bool(bool),
    /// The number's source text (`LazilyParsedNumber`).
    Number(String),
    String(String),
    Array(Vec<Json>),
    Object,
};

    // rust: impl Json {
    /// `Number.intValue()` of a `LazilyParsedNumber`: `Integer.parseInt`, else
    /// `BigDecimal.intValue()` (truncate, keep the low 32 bits).
pub fn int_value(text: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (negative, body) = match text.strip_prefix('-') {
    // rust: Some(rest) => (true, rest),
    // rust: None => (false, text),
}
    // rust: let (mantissa, exponent) = match body.split_once(['e', 'E']) {
    // rust: Some((m, e)) => (
    // rust: m,
    // rust: e.strip_prefix('+').unwrap_or(e).parse::<i64>().unwrap_or(0),
    // rust: ),
    // rust: None => (body, 0),
}
    // rust: let (int_part, fraction) = mantissa.split_once('.').unwrap_or((mantissa, ""));
    // rust: let digits: Vec<u32> = int_part
    // rust: .chars()
    // rust: .chain(fraction.chars())
    // rust: .filter_map(|c| c.to_digit(10))
    // rust: .collect();
        // value = digits * 10^scale; truncating drops digits below the point.
    // rust: let scale = exponent - fraction.len() as i64;
    // rust: let keep = if scale >= 0 {
    // rust: digits.len()
    // rust: } else {
    // rust: digits
    // rust: .len()
    // rust: .saturating_sub(scale.unsigned_abs().min(usize::MAX as u64) as usize)
}
    // rust: let mut v: u32 = 0;
    // rust: for d in &digits[..keep] {
    // rust: v = v.wrapping_mul(10).wrapping_add(*d);
}
    // rust: if scale > 0 {
            // v * 10^scale modulo 2^32 by repeated squaring.
    // rust: let (mut base, mut power, mut e) = (10u32, 1u32, scale as u64);
    // rust: while e > 0 {
    // rust: if e & 1 == 1 {
    // rust: power = power.wrapping_mul(base);
}
    // rust: base = base.wrapping_mul(base);
    // rust: e >>= 1;
}
    // rust: v = v.wrapping_mul(power);
}
    // rust: let v = v as i32;
    // rust: if negative { v.wrapping_neg() } else { v }
}
    /// `Number.doubleValue()`.
pub fn double_value(text: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.parse::<f64>().unwrap_or(0.0)
}
}

/// A syntax error aborts the whole options load, as in vanilla.
pub const SyntaxError = struct {};

pub const Reader = struct {
    chars: std.ArrayList(char),
    pos: usize,
};

pub fn is_literal(c: char) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(
    // rust: c,
    // rust: '/' | '\\'
    // rust: | ';'
    // rust: | '#'
    // rust: | '='
    // rust: | '{'
    // rust: | '}'
    // rust: | '['
    // rust: | ']'
    // rust: | ':'
    // rust: | ','
    // rust: | ' '
    // rust: | '\t'
    // rust: | '\u{c}'
    // rust: | '\r'
    // rust: | '\n'
    // rust: )
}

    // rust: impl Reader {
pub fn peek_char(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chars.get(self.pos).copied()
}
    /// `nextNonWhitespace` with lenient comments; `None` at the end.
pub fn skip(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: loop {
    // rust: match self.peek_char() {
    // rust: None => return Ok(None),
    // rust: Some(' ' | '\t' | '\r' | '\n') => self.pos += 1,
    // rust: Some('#') => self.line_comment(),
    // rust: Some('/') => match self.chars.get(self.pos + 1) {
    // rust: Some('/') => self.line_comment(),
    // rust: Some('*') => {
    // rust: self.pos += 2;
    // rust: loop {
    // rust: match (self.peek_char(), self.chars.get(self.pos + 1)) {
    // rust: (Some('*'), Some('/')) => {
    // rust: self.pos += 2;
    // rust: break;
}
    // rust: (Some(_), _) => self.pos += 1,
    // rust: (None, _) => return Err(SyntaxError),
}
}
}
    // rust: _ => return Ok(Some('/')),
    // rust: },
    // rust: Some(c) => return Ok(Some(c)),
}
}
}
pub fn line_comment(self: *Self) void {
}
    // rust: while let Some(c) = self.peek_char() {
    // rust: self.pos += 1;
    // rust: if c == '\n' || c == '\r' {
    // rust: break;
}
}
}
pub fn quoted(self: *Self, quote: char) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pos += 1;
    // rust: let mut out = String::new();
    // rust: loop {
    // rust: let c = self.peek_char().ok_or(SyntaxError)?;
    // rust: self.pos += 1;
    // rust: if c == quote {
    // rust: return Ok(out);
}
    // rust: if c != '\\' {
    // rust: out.push(c);
    // rust: continue;
}
    // rust: let e = self.peek_char().ok_or(SyntaxError)?;
    // rust: self.pos += 1;
    // rust: match e {
    // rust: 'u' => {
    // rust: let mut v = 0u32;
    // rust: for _ in 0..4 {
    // rust: let d = self.peek_char().ok_or(SyntaxError)?;
    // rust: self.pos += 1;
    // rust: v = v * 16 + d.to_digit(16).ok_or(SyntaxError)?;
}
                    // Lone surrogates cannot be represented; keep the replacement.
    // rust: out.push(char::from_u32(v).unwrap_or('\u{fffd}'));
}
    // rust: 't' => out.push('\t'),
    // rust: 'b' => out.push('\u{8}'),
    // rust: 'n' => out.push('\n'),
    // rust: 'r' => out.push('\r'),
    // rust: 'f' => out.push('\u{c}'),
    // rust: '\n' | '\'' | '"' | '\\' | '/' => out.push(e),
    // rust: _ => return Err(SyntaxError),
}
}
}
pub fn literal(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = self.pos;
    // rust: while self.peek_char().is_some_and(is_literal) {
    // rust: self.pos += 1;
}
    // rust: self.chars[start..self.pos].iter().collect()
}
    /// JSON number grammar with Gson's leading-zero rule.
pub fn is_number(text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b: Vec<char> = text.chars().collect();
    // rust: let mut i = 0;
    // rust: if b.first() == Some(&'-') {
    // rust: i += 1;
}
    // rust: match b.get(i) {
    // rust: Some('0') => {
    // rust: i += 1;
}
    // rust: Some(c) if c.is_ascii_digit() => {
    // rust: while b.get(i).is_some_and(char::is_ascii_digit) {
    // rust: i += 1;
}
}
    // rust: _ => return false,
}
    // rust: if b.get(i) == Some(&'.') {
    // rust: i += 1;
    // rust: if !b.get(i).is_some_and(char::is_ascii_digit) {
    // rust: return false;
}
    // rust: while b.get(i).is_some_and(char::is_ascii_digit) {
    // rust: i += 1;
}
}
    // rust: if matches!(b.get(i), Some('e' | 'E')) {
    // rust: i += 1;
    // rust: if matches!(b.get(i), Some('+' | '-')) {
    // rust: i += 1;
}
    // rust: if !b.get(i).is_some_and(char::is_ascii_digit) {
    // rust: return false;
}
    // rust: while b.get(i).is_some_and(char::is_ascii_digit) {
    // rust: i += 1;
}
}
    // rust: i == b.len()
}
pub fn keyword(text: []const u8, word: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.len() == word.len() && text.eq_ignore_ascii_case(word)
}
pub fn value(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = self.skip()?.ok_or(SyntaxError)?;
    // rust: match c {
    // rust: '"' | '\'' => Ok(Json::String(self.quoted(c)?)),
    // rust: '[' => {
    // rust: self.pos += 1;
    // rust: let mut items = Vec::new();
    // rust: loop {
    // rust: match self.skip()?.ok_or(SyntaxError)? {
    // rust: ']' => {
    // rust: self.pos += 1;
                            // A trailing separator leaves an implicit null.
    // rust: return Ok(Json::Array(items));
}
    // rust: ',' | ';' => {
    // rust: self.pos += 1;
    // rust: items.push(Json::Null);
    // rust: continue;
}
    // rust: _ => {}
}
    // rust: items.push(self.value()?);
    // rust: match self.skip()?.ok_or(SyntaxError)? {
    // rust: ']' => {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Array(items));
}
    // rust: ',' | ';' => self.pos += 1,
    // rust: _ => return Err(SyntaxError),
}
}
}
    // rust: '{' => {
    // rust: self.pos += 1;
    // rust: loop {
    // rust: match self.skip()?.ok_or(SyntaxError)? {
    // rust: '}' => {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Object);
}
    // rust: '"' | '\'' => {
    // rust: let q = self.skip()?.ok_or(SyntaxError)?;
    // rust: self.quoted(q)?;
}
    // rust: c if is_literal(c) => {
    // rust: self.literal();
}
    // rust: _ => return Err(SyntaxError),
}
    // rust: match self.skip()?.ok_or(SyntaxError)? {
    // rust: ':' => self.pos += 1,
    // rust: '=' => {
    // rust: self.pos += 1;
    // rust: if self.peek_char() == Some('>') {
    // rust: self.pos += 1;
}
}
    // rust: _ => return Err(SyntaxError),
}
    // rust: self.value()?;
    // rust: match self.skip()?.ok_or(SyntaxError)? {
    // rust: '}' => {
    // rust: self.pos += 1;
    // rust: return Ok(Json::Object);
}
    // rust: ',' | ';' => self.pos += 1,
    // rust: _ => return Err(SyntaxError),
}
}
}
    // rust: ']' | '}' | ',' | ';' | ':' | '=' | '\\' | '/' => Err(SyntaxError),
    // rust: _ => {
    // rust: let text = self.literal();
    // rust: if text.is_empty() {
    // rust: return Err(SyntaxError);
}
    // rust: if Self::keyword(&text, "true") {
    // rust: Ok(Json::Bool(true))
    // rust: } else if Self::keyword(&text, "false") {
    // rust: Ok(Json::Bool(false))
    // rust: } else if Self::keyword(&text, "null") {
    // rust: Ok(Json::Null)
    // rust: } else if Self::is_number(&text) {
    // rust: Ok(Json::Number(text))
    // rust: } else {
    // rust: Ok(Json::String(text))
}
}
}
}
}

/// `JsonParser.parseString`: one lenient value and nothing after it.
pub fn parse_lenient(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = text.strip_prefix(")]}'\n").unwrap_or(text);
    // rust: let mut reader = Reader {
    // rust: chars: text.chars().collect(),
    // rust: pos: 0,
}
    // rust: if reader.skip()?.is_none() {
    // rust: return Ok(Json::Null);
}
    // rust: let value = reader.value()?;
    // The trailing check runs after Gson restored its legacy-strict mode:
    // only whitespace may follow the value.
    // rust: if value != Json::Null
    // rust: && reader.chars[reader.pos..]
    // rust: .iter()
    // rust: .any(|c| !matches!(c, ' ' | '\t' | '\r' | '\n'))
    // rust: {
    // rust: return Err(SyntaxError);
}
    // rust: Ok(value)
}

    // rust: impl Reader {
    /// Next non-whitespace char in strict mode (comments are errors).
pub fn strict_skip(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while matches!(self.peek_char(), Some(' ' | '\t' | '\r' | '\n')) {
    // rust: self.pos += 1;
}
    // rust: self.peek_char()
}
}

/// `Gson.getAdapter(List<String>).read` on a strict `JsonReader`
/// (`GsonHelper.fromNullableJson`): `Ok(None)` for `null`, an error for
/// anything Gson rejects, including an empty document.
pub fn parse_strict_string_list(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader {
    // rust: chars: text.chars().collect(),
    // rust: pos: 0,
}
    // rust: match r.strict_skip().ok_or(SyntaxError)? {
    // rust: 'n' => {
    // rust: let word = r.literal();
    // rust: if word == "null" {
    // rust: Ok(None)
    // rust: } else {
    // rust: Err(SyntaxError)
}
}
    // rust: '[' => {
    // rust: r.pos += 1;
    // rust: let mut items = Vec::new();
    // rust: if r.strict_skip().ok_or(SyntaxError)? == ']' {
    // rust: return Ok(Some(items));
}
    // rust: loop {
    // rust: let c = r.strict_skip().ok_or(SyntaxError)?;
    // rust: match c {
    // rust: '"' => items.push(r.quoted('"')?),
    // rust: '-' | '0'..='9' => {
    // rust: let word = r.literal();
    // rust: if !Reader::is_number(&word) {
    // rust: return Err(SyntaxError);
}
    // rust: items.push(word);
}
    // rust: 't' | 'f' | 'n' => {
    // rust: let word = r.literal();
    // rust: match word.as_str() {
    // rust: "true" | "false" => items.push(word),
    // rust: "null" => {}
    // rust: _ => return Err(SyntaxError),
}
}
    // rust: _ => return Err(SyntaxError),
}
    // rust: match r.strict_skip().ok_or(SyntaxError)? {
    // rust: ',' => r.pos += 1,
    // rust: ']' => return Ok(Some(items)),
    // rust: _ => return Err(SyntaxError),
}
}
}
    // rust: _ => Err(SyntaxError),
}
}

/// `String.format(Locale.ROOT, "%.<n>f", value)`: Java rounds the shortest
/// round-trip decimal expansion half-up (so 1.005 gives 1.01).
pub fn format_fixed(value: f64, decimals: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value.is_nan() {
    // rust: return "NaN".into();
}
    // rust: if value.is_infinite() {
    // rust: return if value < 0.0 { "-Infinity" } else { "Infinity" }.into();
}
    // rust: let negative = value.is_sign_negative();
    // rust: let (digits, exponent) = if value == 0.0 {
    // rust: ("0".to_owned(), 0)
    // rust: } else {
    // rust: shortest(&format!("{:e}", value.abs()))
}
    // rust: let mut int_part: Vec<u8> = Vec::new();
    // rust: let mut frac: Vec<u8> = Vec::new();
    // rust: let d: Vec<u8> = digits.bytes().map(|b| b - b'0').collect();
    // rust: let point = exponent + 1; // digits before the decimal point
    // rust: if point <= 0 {
    // rust: int_part.push(0);
    // rust: frac.extend(std::iter::repeat_n(0, (-point) as usize));
    // rust: frac.extend(&d);
    // rust: } else {
    // rust: let point = point as usize;
    // rust: for i in 0..point {
    // rust: int_part.push(d.get(i).copied().unwrap_or(0));
}
    // rust: if d.len() > point {
    // rust: frac.extend(&d[point..]);
}
}
    // rust: let round_up = frac.get(decimals).is_some_and(|&x| x >= 5);
    // rust: frac.truncate(decimals);
    // rust: frac.resize(decimals, 0);
    // rust: if round_up {
    // rust: let mut carry = true;
    // rust: for x in frac.iter_mut().rev().chain(int_part.iter_mut().rev()) {
    // rust: if !carry {
    // rust: break;
}
    // rust: if *x == 9 {
    // rust: *x = 0;
    // rust: } else {
    // rust: *x += 1;
    // rust: carry = false;
}
}
    // rust: if carry {
    // rust: int_part.insert(0, 1);
}
}
    // rust: let mut out = String::new();
    // rust: if negative {
    // rust: out.push('-');
}
    // rust: out.extend(int_part.iter().map(|&x| (b'0' + x) as char));
    // rust: if decimals > 0 {
    // rust: out.push('.');
    // rust: out.extend(frac.iter().map(|&x| (b'0' + x) as char));
}
    // rust: out
}

/// `%.2f`.
pub fn format_fixed2(value: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format_fixed(value, 2)
}

    // rust: mod tests {
//     use super::*;
pub fn java_number_text() void {
}
    // rust: assert_eq!(double_to_string(1.0), "1.0");
    // rust: assert_eq!(double_to_string(0.5), "0.5");
    // rust: assert_eq!(double_to_string(0.0001), "1.0E-4");
    // rust: assert_eq!(double_to_string(0.001), "0.001");
    // rust: assert_eq!(double_to_string(1234567.0), "1234567.0");
    // rust: assert_eq!(double_to_string(12345678.0), "1.2345678E7");
    // rust: assert_eq!(double_to_string(100.0), "100.0");
    // rust: assert_eq!(float_to_string(0.15), "0.15");
    // rust: assert_eq!(float_to_string(1.0e10), "1.0E10");
    // rust: assert_eq!(double_to_string(-2.5), "-2.5");
}
pub fn lenient_json() void {
}
    // rust: assert_eq!(parse_lenient("0.5").unwrap(), Json::Number("0.5".into()));
    // rust: assert_eq!(parse_lenient("fast").unwrap(), Json::String("fast".into()));
    // rust: assert_eq!(parse_lenient("TRUE").unwrap(), Json::Bool(true));
    // rust: assert_eq!(parse_lenient("007").unwrap(), Json::String("007".into()));
    // rust: assert!(parse_lenient("1 2").is_err());
    // rust: assert!(parse_lenient("\"abc").is_err());
    // rust: assert_eq!(parse_lenient("  ").unwrap(), Json::Null);
    // rust: assert_eq!(gson_string("a=b"), "\"a\\u003db\"");
}
}
