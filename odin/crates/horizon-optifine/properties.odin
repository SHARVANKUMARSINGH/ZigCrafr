//! Transpiled from Horizon Rust crate
package horizon_optifine_properties

import "core:fmt"
import "core:mem"
import "core:math"

// Java `.properties` files (`java.util.Properties.load`), as OptiFine reads them: `key=value`,
// `key:value` or `key value` lines, `#` and `!` comments, a trailing `\` continuing the line,
// and the escapes `\t`, `\n`, `\r`, `\f`, `\uXXXX` (any other `\x` is `x`). Values are trimmed,
// as OptiFine does. A later duplicate key replaces the earlier one.
//
// Shader packs have their own reader (`horizon_shaders::properties`): theirs runs `#define`
// and `#if` directives and reads no escapes.

Properties :: struct {
    // In file order; each key once.
    entries: Vec<(string,
}

    // rust: impl Properties {
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::read(text, split)
}

    // As CIT Resewn reads its files: a line with an unescaped `=` splits there, so a key may
    // hold an unescaped `:` (`components.minecraft:custom_name=Bob`); other lines as `parse`.
parse_equals_first :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::read(text, |line| match unescaped_equals(line) {
    // rust: Some(i) => (
    // rust: line[..i].trim_end_matches([' ', '\t', '\x0c']),
    // rust: &line[i + 1..],
    // rust: ),
    // rust: None => split(line),
    // rust: })
}

read :: proc(text: string, split: impl Fn(string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Self::default();
        // Each key's place in `entries`, so a file of many keys reads in linear time.
    // rust: let mut index = std::collections::HashMap::<String, usize>::new();
    // rust: let mut lines = text.lines();
    // rust: while let Some(first) = lines.next() {
    // rust: let first = first.trim_start();
    // rust: if first.is_empty() || first.starts_with('#') || first.starts_with('!') {
    // rust: continue;
}
    // rust: let mut line = String::from(first);
    // rust: while ends_in_continuation(&line) {
    // rust: line.pop();
    // rust: match lines.next() {
    // rust: Some(next) => line.push_str(next.trim_start()),
    // rust: None => break,
}
}
    // rust: let (key, value) = split(&line);
    // rust: let (key, value) = (unescape(key), unescape(value).trim().to_owned());
    // rust: match index.get(&key) {
    // rust: Some(&i) => out.entries[i].1 = value,
    // rust: None => {
    // rust: index.insert(key.clone(), out.entries.len());
    // rust: out.entries.push((key, value));
}
}
}
    // rust: out
}

get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries
    // rust: .iter()
    // rust: .find(|(k, _)| k == key)
    // rust: .map(|(_, v)| v.as_str())
}

    // The entries whose key starts with `prefix` (`nbt.`, `texture.`, `skins.`), the prefix cut.
    // rust: pub fn with_prefix<'a>(&'a self, prefix: &'a str) -> impl Iterator<Item = (&'a str, &'a str)> {
    // rust: self.entries
    // rust: .iter()
    // rust: .filter_map(move |(k, v)| Some((k.strip_prefix(prefix)?, v.as_str())))
}
}

// An odd number of trailing backslashes.
ends_in_continuation :: proc(line: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: line.bytes().rev().take_while(|&b| b == b'\\').count() % 2 == 1
}

unescaped_equals :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = line.as_bytes();
    // rust: let mut i = 0;
    // rust: while i < bytes.len() {
    // rust: match bytes[i] {
    // rust: b'\\' => i += 2,
    // rust: b'=' => return Some(i),
    // rust: _ => i += 1,
}
}
    // rust: None
}

// The key ends at the first unescaped `=`, `:` or whitespace; then whitespace and at most one
// `=` or `:` are skipped.
split :: proc(line: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = line.as_bytes();
    // rust: let mut i = 0;
    // rust: while i < bytes.len() {
    // rust: match bytes[i] {
    // rust: b'\\' => i += 2,
    // rust: b'=' | b':' | b' ' | b'\t' | b'\x0c' => break,
    // rust: _ => i += 1,
}
}
    // rust: let key_end = i.min(bytes.len());
    // rust: let mut rest = line[key_end..].trim_start_matches([' ', '\t', '\x0c']);
    // rust: if let Some(r) = rest.strip_prefix(['=', ':']) {
    // rust: rest = r.trim_start_matches([' ', '\t', '\x0c']);
}
    // rust: (&line[..key_end], rest)
}

unescape :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(s.len());
    // rust: let mut chars = s.chars();
    // rust: while let Some(c) = chars.next() {
    // rust: if c != '\\' {
    // rust: out.push(c);
    // rust: continue;
}
    // rust: match chars.next() {
    // rust: Some('t') => out.push('\t'),
    // rust: Some('n') => out.push('\n'),
    // rust: Some('r') => out.push('\r'),
    // rust: Some('f') => out.push('\x0c'),
    // rust: Some('u') => {
    // rust: let mut unit = || {
    // rust: let hex: String = chars.by_ref().take(4).collect();
    // rust: u32::from_str_radix(&hex, 16).ok()
}
    // rust: let Some(mut code) = unit() else { continue };
                // A character past U+FFFF is two escapes, as Java writes it: `\uD83D\uDE00`.
    // rust: if (0xD800..0xDC00).contains(&code) {
    // rust: let rest = chars.as_str();
    // rust: if let Some(low) = rest
    // rust: .strip_prefix("\\u")
    // rust: .and_then(|r| u32::from_str_radix(r.get(..4)?, 16).ok())
    // rust: .filter(|low| (0xDC00..0xE000).contains(low))
    // rust: {
    // rust: chars.nth(5);
    // rust: code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00);
}
}
    // rust: if let Some(c) = char::from_u32(code) {
    // rust: out.push(c);
}
}
    // rust: Some(other) => out.push(other),
    // rust: None => {}
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

separators_comments_and_continuations :: proc() {
}
    // rust: let p = Properties::parse(
    // rust: "# a comment\n! another\nmethod=ctm\nmatchBlocks : minecraft:glass \\\n    minecraft:white_stained_glass\ntiles 0-46\n\nweights=1\nweights=2\n",
    // rust: );
    // rust: assert_eq!(p.get("method"), Some("ctm"));
    // rust: assert_eq!(
    // rust: p.get("matchBlocks"),
    // rust: Some("minecraft:glass minecraft:white_stained_glass")
    // rust: );
    // rust: assert_eq!(p.get("tiles"), Some("0-46"));
    // rust: assert_eq!(p.get("weights"), Some("2"));
    // rust: assert_eq!(p.entries.len(), 4);
}

escapes_in_keys_and_values :: proc() {
}
    // rust: let p = Properties::parse(
    // rust: "nbt.display.Name=ipattern:*\\u00e9p\\u00e9e*\nkey\\=with\\:colon=a\\tb\nlast\\\\=x\n",
    // rust: );
    // rust: assert_eq!(p.get("nbt.display.Name"), Some("ipattern:*épée*"));
    // rust: assert_eq!(p.get("key=with:colon"), Some("a\tb"));
        // An even number of backslashes is an escaped backslash, not a continuation.
    // rust: assert_eq!(p.get("last\\"), Some("x"));
    // rust: let emoji = Properties::parse("nbt.display.Name=\\uD83D\\uDE00 Sword\n");
    // rust: assert_eq!(emoji.get("nbt.display.Name"), Some("\u{1F600} Sword"));
}

equals_first_keeps_colons_in_keys :: proc() {
}
    // rust: let text = "components.minecraft:custom_name = Bob\nnbt.a\\=b=c\ntype:item\n";
    // rust: let p = Properties::parse_equals_first(text);
    // rust: assert_eq!(p.get("components.minecraft:custom_name"), Some("Bob"));
    // rust: assert_eq!(p.get("nbt.a=b"), Some("c"), "an escaped = is the key's");
    // rust: assert_eq!(p.get("type"), Some("item"), "no = at all: Java's rules");
    // rust: assert_eq!(
    // rust: Properties::parse(text).get("components.minecraft"),
    // rust: Some("custom_name = Bob")
    // rust: );
}

prefixed_keys :: proc() {
}
    // rust: let p = Properties::parse("texture.bow_pulling_0=a\ntexture.bow_pulling_1=b\nitems=bow\n");
    // rust: let got: Vec<_> = p.with_prefix("texture.").collect();
    // rust: assert_eq!(got, [("bow_pulling_0", "a"), ("bow_pulling_1", "b")]);
}
}
