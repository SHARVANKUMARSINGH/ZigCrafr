//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_json
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The JSON of `.jem` and `.jpm` files as OptiFine reads it (Gson, which is lenient): a byte
//! order mark, `//`, `/* */` and `#` comments, trailing commas, single-quoted strings and bare
//! keys are all accepted, and objects keep their keys in file order, which animations depend on
//! (later ones read what earlier ones wrote).

/// A JSON value. Objects are key-value lists in file order.
pub const Json = enum {
    Null,
    Bool(bool),
    Num(f64),
    Str(String),
    Arr(Vec<Json>),
    Obj(Vec<(String, Json)>),
};

/// Nesting deeper than this is refused: parsing recurses.
pub const DEPTH: usize = 128;

    // rust: impl Json {
pub fn parse(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Parser {
    // rust: b: text.strip_prefix('\u{feff}').unwrap_or(text).as_bytes(),
    // rust: i: 0,
}
    // rust: let v = p.value(0)?;
    // rust: p.space()?;
    // rust: if p.i < p.b.len() {
    // rust: return Err(p.error("text after the value"));
}
    // rust: Ok(v)
}

    /// The value of `key` in an object.
pub fn get(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: get(self.as_object()?, key)
}
pub fn as_str(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Json::Str(s) => Some(s),
    // rust: _ => None,
}
}
pub fn as_array(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Json::Arr(a) => Some(a),
    // rust: _ => None,
}
}
pub fn as_object(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Json::Obj(pairs) => Some(pairs),
    // rust: _ => None,
}
}
}

/// The value of `key` (the last one, when a key repeats).
    // rust: pub(crate) fn get<'a>(object: &'a [(String, Json)], key: &str) -> Option<&'a Json> {
    // rust: object.iter().rev().find(|(k, _)| k == key).map(|(_, v)| v)
}

pub const Parser = struct {
    b: *'a [u8],
    i: usize,
};

    // rust: impl Parser<'_> {
pub fn error(self: *Self, what: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let line = 1 + self.b[..self.i.min(self.b.len())]
    // rust: .iter()
    // rust: .filter(|c| **c == b'\n')
    // rust: .count();
    // rust: format!("{what} on line {line}")
}

pub fn peek(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.b.get(self.i).copied()
}

    /// Skips whitespace and comments.
pub fn space(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: loop {
    // rust: match (self.peek(), self.b.get(self.i + 1)) {
    // rust: (Some(c), _) if c.is_ascii_whitespace() => self.i += 1,
    // rust: (Some(b'#'), _) | (Some(b'/'), Some(b'/')) => {
    // rust: while self.peek().is_some_and(|c| c != b'\n') {
    // rust: self.i += 1;
}
}
    // rust: (Some(b'/'), Some(b'*')) => {
    // rust: let end = self.b[self.i + 2..].windows(2).position(|w| w == b"*/");
    // rust: let Some(end) = end else {
    // rust: return Err(self.error("unclosed comment"));
}
    // rust: self.i += end + 4;
}
    // rust: _ => return Ok(()),
}
}
}

pub fn value(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > DEPTH {
    // rust: return Err(self.error("nested too deep"));
}
    // rust: self.space()?;
    // rust: match self.peek() {
    // rust: Some(b'{') => self.object(depth),
    // rust: Some(b'[') => self.array(depth),
    // rust: Some(q @ (b'"' | b'\'')) => self.string(q).map(Json::Str),
    // rust: Some(_) => {
    // rust: let word = self.word();
    // rust: Ok(match word.as_str() {
    // rust: "" => return Err(self.error("expected a value")),
    // rust: "null" => Json::Null,
    // rust: "true" => Json::Bool(true),
    // rust: "false" => Json::Bool(false),
                    // Gson reads an unquoted value as a string when it isn't a number.
    // rust: _ => word.parse().map_or(Json::Str(word), Json::Num),
    // rust: })
}
    // rust: None => Err(self.error("unexpected end")),
}
}

    /// An unquoted literal or key: up to the next separator.
pub fn word(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = self.i;
    // rust: while self
    // rust: .peek()
    // rust: .is_some_and(|c| !c.is_ascii_whitespace() && !b",:;={}[]\"'#/".contains(&c))
    // rust: {
    // rust: self.i += 1;
}
    // rust: String::from_utf8_lossy(&self.b[start..self.i]).into_owned()
}

    /// The four hex digits of a `\u` escape.
pub fn hex4(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let digits = self
    // rust: .b
    // rust: .get(self.i..self.i + 4)
    // rust: .filter(|h| h.iter().all(u8::is_ascii_hexdigit));
    // rust: let Some(digits) = digits else {
    // rust: return Err(self.error("bad \\u escape"));
}
    // rust: self.i += 4;
        // Hex digits are ASCII: the slice is a str.
    // rust: Ok(u32::from_str_radix(std::str::from_utf8(digits).unwrap_or("0"), 16).unwrap_or(0))
}

pub fn string(self: *Self, quote: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.i += 1;
    // rust: let mut out = Vec::new();
    // rust: loop {
    // rust: let Some(c) = self.peek() else {
    // rust: return Err(self.error("unclosed string"));
}
    // rust: self.i += 1;
    // rust: match c {
    // rust: _ if c == quote => break,
    // rust: b'\\' => {
    // rust: let Some(e) = self.peek() else {
    // rust: return Err(self.error("unclosed string"));
}
    // rust: self.i += 1;
    // rust: match e {
    // rust: b'n' => out.push(b'\n'),
    // rust: b't' => out.push(b'\t'),
    // rust: b'r' => out.push(b'\r'),
    // rust: b'b' => out.push(8),
    // rust: b'f' => out.push(12),
    // rust: b'u' => {
    // rust: let mut code = self.hex4()?;
                            // A surrogate pair is one character in two escapes. A half on
                            // its own is U+FFFD; the escape after a lone high half is read
                            // again as itself.
    // rust: if (0xD800..0xDC00).contains(&code)
    // rust: && self.b.get(self.i..self.i + 2) == Some(&b"\\u"[..])
    // rust: {
    // rust: let next = self.i;
    // rust: self.i += 2;
    // rust: let low = self.hex4()?;
    // rust: if (0xDC00..0xE000).contains(&low) {
    // rust: code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00);
    // rust: } else {
    // rust: self.i = next;
}
}
    // rust: let ch = char::from_u32(code).unwrap_or('\u{fffd}');
    // rust: out.extend_from_slice(ch.encode_utf8(&mut [0; 4]).as_bytes());
}
    // rust: other => out.push(other),
}
}
    // rust: _ => out.push(c),
}
}
    // rust: Ok(String::from_utf8_lossy(&out).into_owned())
}

    /// The items up to `close`, with `item` reading each; commas between, one more allowed.
    // rust: fn list(
    // rust: &mut self,
    // rust: close: u8,
    // rust: mut item: impl FnMut(&mut Self) -> Result<(), String>,
    // rust: ) -> Result<(), String> {
    // rust: self.i += 1;
    // rust: loop {
    // rust: self.space()?;
    // rust: match self.peek() {
    // rust: Some(c) if c == close => {
    // rust: self.i += 1;
    // rust: return Ok(());
}
    // rust: None => return Err(self.error("unclosed list")),
    // rust: _ => {}
}
    // rust: item(self)?;
    // rust: self.space()?;
    // rust: match self.peek() {
    // rust: Some(b',' | b';') => self.i += 1,
    // rust: Some(c) if c == close => {}
    // rust: _ => return Err(self.error("expected a comma")),
}
}
}

pub fn array(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut items = Vec::new();
    // rust: self.list(b']', |p| {
    // rust: items.push(p.value(depth + 1)?);
    // rust: Ok(())
    // rust: })?;
    // rust: Ok(Json::Arr(items))
}

pub fn object(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pairs = Vec::new();
    // rust: self.list(b'}', |p| {
    // rust: let key = match p.peek() {
    // rust: Some(q @ (b'"' | b'\'')) => p.string(q)?,
    // rust: _ => match p.word() {
    // rust: word if word.is_empty() => return Err(p.error("expected a key")),
    // rust: word => word,
    // rust: },
}
    // rust: p.space()?;
            // Gson also takes `=` and `=>` for the colon.
    // rust: match p.peek() {
    // rust: Some(b':') => p.i += 1,
    // rust: Some(b'=') => {
    // rust: p.i += 1;
    // rust: if p.peek() == Some(b'>') {
    // rust: p.i += 1;
}
}
    // rust: _ => return Err(p.error("expected a colon")),
}
    // rust: pairs.push((key, p.value(depth + 1)?));
    // rust: Ok(())
    // rust: })?;
    // rust: Ok(Json::Obj(pairs))
}
}

    // rust: mod tests {
//     use super::*;

pub fn keeps_key_order_and_reads_lenient_files() void {
}
    // rust: let text = "\u{feff}{ // a comment\n  'z': 1, /* another */ a: [true, 'two', -3e1,],\n  # hash\n  \"m\": {\"k\": null},\n}";
    // rust: let v = Json::parse(text).unwrap();
    // rust: let keys: Vec<&str> = v
    // rust: .as_object()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|(k, _)| k.as_str())
    // rust: .collect();
    // rust: assert_eq!(keys, ["z", "a", "m"]);
    // rust: assert_eq!(
    // rust: v.get("a").unwrap(),
    // rust: &Json::Arr(vec![
    // rust: Json::Bool(true),
    // rust: Json::Str("two".into()),
    // rust: Json::Num(-30.0)
    // rust: ])
    // rust: );
    // rust: assert_eq!(v.get("m").unwrap().get("k"), Some(&Json::Null));
    // rust: assert_eq!(
    // rust: Json::parse(r#"{"s": "a\"bé\n"}"#)
    // rust: .unwrap()
    // rust: .get("s")
    // rust: .unwrap()
    // rust: .as_str(),
    // rust: Some("a\"b\u{e9}\n")
    // rust: );
}

pub fn gson_separators_empty_keys_and_escapes() void {
}
    // rust: let v = Json::parse("{a=1; b=>[2;3], \"\": 'x'}").unwrap();
    // rust: assert_eq!(v.get("a"), Some(&Json::Num(1.0)));
    // rust: assert_eq!(
    // rust: v.get("b"),
    // rust: Some(&Json::Arr(vec![Json::Num(2.0), Json::Num(3.0)]))
    // rust: );
    // rust: assert_eq!(v.get(""), Some(&Json::Str("x".into())));
    // rust: let s = Json::parse(r#""\ud83d\ude00\u0041""#).unwrap();
    // rust: assert_eq!(s.as_str(), Some("\u{1f600}A"));
    // rust: for (text, want) in [
    // rust: (r#""\ud83dA""#, "\u{fffd}A"),
    // rust: (r#""\ud83d\u0041""#, "\u{fffd}A"),
    // rust: (r#""\ud83d😀""#, "\u{fffd}\u{1f600}"),
    // rust: (r#""\ude00\ud83d""#, "\u{fffd}\u{fffd}"),
    // rust: ] {
    // rust: assert_eq!(Json::parse(text).unwrap().as_str(), Some(want), "{text}");
}
        // Comment marks inside a string are text.
    // rust: let v = Json::parse(r#"{"s": "a#b//c"}"#).unwrap();
    // rust: assert_eq!(v.get("s"), Some(&Json::Str("a#b//c".into())));
    // rust: assert!(Json::parse(r#""\u+041""#).is_err());
}

pub fn refuses_broken_or_hostile_files() void {
}
    // rust: for bad in ["", "{", "{\"a\" 1}", "[1 2]", "\"open", "{} x", "/* open"] {
    // rust: assert!(Json::parse(bad).is_err(), "{bad:?}");
}
    // rust: let deep = format!("{}{}", "[".repeat(200), "]".repeat(200));
    // rust: assert!(Json::parse(&deep).unwrap_err().contains("deep"));
    // rust: assert!(
    // rust: Json::parse("{\n\n  \"a\": }")
    // rust: .unwrap_err()
    // rust: .contains("line 3")
    // rust: );
}
}
