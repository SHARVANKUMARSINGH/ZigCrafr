//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_pattern
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A small regular-expression subset for `pack.mcmeta` filter blocks (Java
//! `Pattern.asPredicate()` semantics: an unanchored search). Supports
//! literals, `.`, classes `[a-z_]`/`[^..]`, escapes, `* + ?` quantifiers,
//! `^`/`$` and top-level alternation with `|`.

pub const Atom = enum {
    Any,
    Lit(char),
    Class(Vec<(char, char)>, bool),
    Start,
    End,
};
pub const Item = struct {
    atom: Atom,
    min: usize,
    max: usize,
};
pub const Pattern = struct {};

    // rust: impl Pattern {
pub fn new(src: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut alternatives = vec![Vec::new()];
    // rust: let chars: Vec<char> = src.chars().collect();
    // rust: let mut i = 0;
    // rust: while i < chars.len() {
    // rust: let atom = match chars[i] {
    // rust: '|' => {
    // rust: alternatives.push(Vec::new());
    // rust: i += 1;
    // rust: continue;
}
    // rust: '.' => Atom::Any,
    // rust: '^' => Atom::Start,
    // rust: '$' => Atom::End,
    // rust: '\\' => {
    // rust: i += 1;
    // rust: match *chars.get(i)? {
    // rust: 'd' => Atom::Class(vec![('0', '9')], false),
    // rust: 'w' => {
    // rust: Atom::Class(vec![('a', 'z'), ('A', 'Z'), ('0', '9'), ('_', '_')], false)
}
    // rust: c => Atom::Lit(c),
}
}
    // rust: '[' => {
    // rust: i += 1;
    // rust: let negate = chars.get(i) == Some(&'^');
    // rust: if negate {
    // rust: i += 1;
}
    // rust: let mut ranges = Vec::new();
    // rust: loop {
    // rust: let mut c = *chars.get(i)?;
    // rust: if c == ']' && !ranges.is_empty() {
    // rust: break;
}
    // rust: if c == '\\' {
    // rust: i += 1;
    // rust: c = *chars.get(i)?;
}
    // rust: if chars.get(i + 1) == Some(&'-')
    // rust: && chars.get(i + 2).is_some_and(|e| *e != ']')
    // rust: {
    // rust: ranges.push((c, chars[i + 2]));
    // rust: i += 3;
    // rust: } else {
    // rust: ranges.push((c, c));
    // rust: i += 1;
}
}
    // rust: Atom::Class(ranges, negate)
}
    // rust: '(' | ')' | '{' | '}' => return None,
    // rust: c => Atom::Lit(c),
}
    // rust: i += 1;
    // rust: let (min, max) = match chars.get(i) {
    // rust: Some('*') => (0, usize::MAX),
    // rust: Some('+') => (1, usize::MAX),
    // rust: Some('?') => (0, 1),
    // rust: _ => (1, 1),
}
    // rust: if (min, max) != (1, 1) {
    // rust: i += 1;
}
    // rust: alternatives.last_mut()?.push(Item { atom, min, max });
}
    // rust: Some(Pattern(alternatives))
}
pub fn is_match(self: *Self, text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text: Vec<char> = text.chars().collect();
    // rust: self.0
    // rust: .iter()
    // rust: .any(|alt| (0..=text.len()).any(|start| run(alt, &text, start)))
}
}
pub fn one(atom: *Atom, c: char) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match atom {
    // rust: Atom::Any => c != '\n',
    // rust: Atom::Lit(l) => *l == c,
    // rust: Atom::Class(r, negate) => r.iter().any(|(lo, hi)| *lo <= c && c <= *hi) != *negate,
    // rust: Atom::Start | Atom::End => false,
}
}
pub fn run(items: *[Item], text: *[char], at: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((item, rest)) = items.split_first() else {
    // rust: return true;
}
    // rust: match item.atom {
    // rust: Atom::Start => return at == 0 && run(rest, text, at),
    // rust: Atom::End => return at == text.len() && run(rest, text, at),
    // rust: _ => {}
}
    // rust: let mut count = 0;
    // rust: while count < item.max && at + count < text.len() && one(&item.atom, text[at + count]) {
    // rust: count += 1;
}
    // rust: (item.min..=count).rev().any(|n| run(rest, text, at + n))
}

    // rust: mod tests {
//     use super::Pattern;
pub fn m(p: []const u8, t: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Pattern::new(p).unwrap().is_match(t)
}
pub fn java_find_semantics() void {
}
    // rust: assert!(m("stone", "minecraft/stone_bricks"));
    // rust: assert!(!m("^stone$", "stone_bricks"));
    // rust: assert!(m("^textures/.*\\.png$", "textures/block/a.png"));
    // rust: assert!(!m("^textures/.*\\.png$", "textures/block/a_png"));
    // rust: assert!(m("[a-c]+z", "xxabcz"));
    // rust: assert!(!m("^[^a]+$", "bab"));
    // rust: assert!(m("dirt|grass", "grass_block"));
    // rust: assert!(m(".*", ""));
    // rust: assert!(Pattern::new("(a)").is_none());
}
}
