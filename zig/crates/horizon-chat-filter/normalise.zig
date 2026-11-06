//! Transpiled from Horizon Rust crate
//! Module: horizon-chat-filter_normalise
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A text as the filter sees it: words of letters `a`..`z`, each letter with how many times it repeats.
//! Case, accents, look-alike letters (Cyrillic, Greek, full-width, small capitals, styled mathematical
//! letters, circled and squared letters), leetspeak and invisible characters are folded away;
//! separators inside a word are dropped (`n.i.g` is `nig`), and whitespace ends a word.

/// The letter code of anything that is a letter but none of `a`..`z`: it never matches.
pub const OTHER: u8 = 26;

/// One letter and how many times it repeats (`gg` is `g` twice).
pub const Run = struct {
    /// 0..=25 for `a`..`z`, 26 for any other letter.
    letter: u8,
    count: u8,
    /// Every one of its characters was punctuation read as a letter (`!` as `i`, `@` as `a`).
    weak: bool,
};

/// A whole message, normalised.
pub const Text = struct {
    runs: std.ArrayList(Run),
    /// Each word's runs, `runs[start..end]`.
    words: Vec<(usize,
    /// More ranges of `runs` to match as words: letters spaced out (`n i g g a`), joined, and words
    /// without the punctuation they end with (`fag!`).
    spaced: Vec<(usize,
    /// Every word one after the other, a letter that ends one and starts the next merged.
    joined: std.ArrayList(Run),
    /// Where each word starts in `joined`.
    joined_at: std.ArrayList(usize),
    /// The last word each run of `joined` belongs to.
    joined_last: std.ArrayList(usize),
};

pub const Fold = enum {
    Letter(u8, bool),
    Separator,
    Space,
    Skip,
};

    // rust: impl Text {
pub fn new(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut t = Text::default();
    // rust: let mut start = 0;
    // rust: for c in text.chars() {
    // rust: match fold(c) {
    // rust: Fold::Letter(letter, weak) => {
    // rust: let in_word = t.runs.len() > start;
    // rust: match t.runs.last_mut() {
    // rust: Some(last) if in_word && last.letter == letter => {
    // rust: last.count = last.count.saturating_add(1);
    // rust: last.weak &= weak;
}
    // rust: _ => t.runs.push(Run {
    // rust: letter,
    // rust: count: 1,
    // rust: weak,
    // rust: }),
}
}
    // rust: Fold::Space => {
    // rust: t.end_word(start);
    // rust: start = t.runs.len();
}
    // rust: Fold::Separator | Fold::Skip => {}
}
}
    // rust: t.end_word(start);
    // rust: t.add_spaced();
    // rust: t.join();
    // rust: t
}

pub fn end_word(self: *Self, start: usize) void {
}
    // rust: if self.runs.len() > start {
    // rust: self.words.push((start, self.runs.len()));
}
}

    /// Spaced-out letters and words without their trailing punctuation, as extra words (their runs
    /// copied after the real words').
pub fn add_spaced(self: *Self) void {
}
    // rust: let words = self.words.len();
    // rust: let mut w = 0;
    // rust: while w < words {
    // rust: let mut end = w;
    // rust: while end < words && self.words[end].1 - self.words[end].0 == 1 {
    // rust: end += 1;
}
    // rust: if end - w >= 2 {
    // rust: let first = self.runs.len();
    // rust: for k in w..end {
    // rust: let run = self.runs[self.words[k].0];
    // rust: let in_word = self.runs.len() > first;
    // rust: match self.runs.last_mut() {
    // rust: Some(last) if in_word && last.letter == run.letter => {
    // rust: last.count = last.count.saturating_add(run.count);
}
    // rust: _ => self.runs.push(run),
}
}
    // rust: self.spaced.push((first, self.runs.len()));
    // rust: w = end;
    // rust: } else {
    // rust: w += 1;
}
}
    // rust: for k in 0..words {
    // rust: let (start, mut end) = self.words[k];
    // rust: while end > start + 1 && self.runs[end - 1].weak {
    // rust: end -= 1;
}
    // rust: if end < self.words[k].1 {
    // rust: self.spaced.push((start, end));
}
}
}

pub fn join(self: *Self) void {
}
    // rust: for (w, &(start, end)) in self.words.iter().enumerate() {
    // rust: let mut first = true;
    // rust: for run in &self.runs[start..end] {
    // rust: match self.joined.last_mut() {
    // rust: Some(last) if first && last.letter == run.letter => {
    // rust: last.count = last.count.saturating_add(run.count);
    // rust: self.joined_at.push(self.joined.len() - 1);
    // rust: *self.joined_last.last_mut().expect("beside joined") = w;
}
    // rust: _ => {
    // rust: if first {
    // rust: self.joined_at.push(self.joined.len());
}
    // rust: self.joined.push(*run);
    // rust: self.joined_last.push(w);
}
}
    // rust: first = false;
}
}
}

    /// Whether `len` runs of `joined` from word `w`'s start reach into a later word.
pub fn spans_words(self: *Self, w: usize, len: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.joined_last
    // rust: .get(self.joined_at[w] + len - 1)
    // rust: .is_some_and(|&last| last > w)
}
}

/// An entry of the list, normalised the same way (one word, whitespace ignored).
pub fn word(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = Text::new(&text.replace(char::is_whitespace, ""));
    // rust: t.words
    // rust: .first()
    // rust: .map_or_else(Vec::new, |&(s, e)| t.runs[s..e].to_vec())
}

pub fn letter(c: char) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Fold::Letter(c as u8 - b'a', false)
}

pub fn fold(c: char) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if c.is_ascii_alphabetic() {
    // rust: return letter(c.to_ascii_lowercase());
}
    // rust: if c.is_ascii() {
    // rust: return match c {
    // rust: '0' => letter('o'),
    // rust: '1' => letter('i'),
    // rust: '3' => letter('e'),
    // rust: '4' => letter('a'),
    // rust: '5' => letter('s'),
    // rust: '6' | '9' => letter('g'),
    // rust: '7' => letter('t'),
    // rust: '8' => letter('b'),
    // rust: '!' | '|' => Fold::Letter(b'i' - b'a', true),
    // rust: '@' => Fold::Letter(0, true),
    // rust: '$' => Fold::Letter(b's' - b'a', true),
    // rust: c if c.is_ascii_whitespace() => Fold::Space,
    // rust: _ => Fold::Separator,
}
}
    // rust: let u = c as u32;
    // rust: let from = |base: u32, span: u32| char::from(b'a' + ((u - base) % span) as u8);
    // rust: let mapped = match u {
        // Zero-width characters, soft hyphen, combining marks, variation selectors.
    // rust: 0xAD | 0x34F | 0x200B..=0x200F | 0x2060..=0x2064 | 0xFEFF | 0x180E => return Fold::Skip,
    // rust: 0x300..=0x36F
    // rust: | 0x1AB0..=0x1AFF
    // rust: | 0x1DC0..=0x1DFF
    // rust: | 0x20D0..=0x20FF
    // rust: | 0xFE00..=0xFE0F
    // rust: | 0xFE20..=0xFE2F
    // rust: | 0xE0100..=0xE01EF => return Fold::Skip,
        // Full-width Latin and digits.
    // rust: 0xFF21..=0xFF3A => from(0xFF21, 26),
    // rust: 0xFF41..=0xFF5A => from(0xFF41, 26),
    // rust: 0xFF10..=0xFF19 => return fold(char::from(b'0' + (u - 0xFF10) as u8)),
        // Mathematical alphanumerics: 52 letters a style, then digits.
    // rust: 0x1D400..=0x1D6A3 => from(0x1D400, 26),
    // rust: 0x1D7CE..=0x1D7FF => return fold(char::from(b'0' + ((u - 0x1D7CE) % 10) as u8)),
        // Circled, parenthesised, squared and negative letters, regional indicators.
    // rust: 0x24B6..=0x24CF => from(0x24B6, 26),
    // rust: 0x24D0..=0x24E9 => from(0x24D0, 26),
    // rust: 0x249C..=0x24B5 => from(0x249C, 26),
    // rust: 0x1F130..=0x1F149 => from(0x1F130, 26),
    // rust: 0x1F150..=0x1F169 => from(0x1F150, 26),
    // rust: 0x1F170..=0x1F189 => from(0x1F170, 26),
    // rust: 0x1F1E6..=0x1F1FF => from(0x1F1E6, 26),
    // rust: _ => {
    // rust: if c.is_whitespace() {
    // rust: return Fold::Space;
}
    // rust: let lower = c.to_lowercase().next().unwrap_or(c);
    // rust: match LOOK_ALIKES.iter().find(|(_, chars)| chars.contains(lower)) {
    // rust: Some((base, _)) => *base,
    // rust: None if c.is_alphabetic() => return Fold::Letter(OTHER, false),
    // rust: None => return Fold::Separator,
}
}
}
    // rust: letter(mapped)
}

/// Letters with accents and letters that look like a Latin one, by the letter they read as (lower case).
    // rust: const LOOK_ALIKES: &[(char, &str)] = &[
    // rust: ('a', "àáâãäåāăąǎǟǡǻȁȃȧạảấầẩẫậắằẳẵặⱥɐаαᴀᵃª"),
    // rust: ('b', "ƀɓḃḅḇвьъβʙᵇ"),
    // rust: ('c', "çćĉċčƈḉȼсϲᴄᶜ"),
    // rust: ('d', "ďđɗḋḍḏḑḓԁδᴅᵈ"),
    // rust: ('e', "èéêëēĕėęěȅȇȩẹẻẽếềểễệḕḗḙḛḝɇеёєεᴇᵉ€"),
    // rust: ('f', "ƒḟꜰᶠ"),
    // rust: ('g', "ĝğġģǥǧǵɠḡɡɢᵍ"),
    // rust: ('h', "ĥħȟḣḥḧḩḫẖнһʜʰ"),
    // rust: ('i', "ìíîïĩīĭįıǐȉȋḭḯỉịіїιɪⁱ¡ӏ"),
    // rust: ('j', "ĵǰјᴊʲ"),
    // rust: ('k', "ķĸǩḱḳḵкκᴋᵏ"),
    // rust: ('l', "ĺļľŀłḷḹḻḽʟˡ"),
    // rust: ('m', "мᴍᵐ"),
    // rust: ('n', "ñńņňŉŋǹṅṇṉṋиипηπɴⁿ"),
    // rust: ('o', "òóôõöøōŏőơǒǫǭǿȍȏȫȭȯȱọỏốồổỗộớờởỡợоοσᴏᵒº"),
    // rust: ('p', "ṕṗрρᴘᵖ"),
    // rust: ('q', "ԛ"),
    // rust: ('r', "ŕŗřȑȓṙṛṝṟгʀʳ"),
    // rust: ('s', "śŝşšșṡṣṥṧṩѕꜱˢß"),
    // rust: ('t', "ţťŧțṫṭṯṱẗтτᴛᵗ"),
    // rust: ('u', "ùúûüũūŭůűųưǔǖǘǚǜȕȗụủứừửữựυᴜᵘ"),
    // rust: ('v', "νᴠᵛ"),
    // rust: ('w', "ŵẁẃẅẇẉẘԝωᴡʷ"),
    // rust: ('x', "хχˣ"),
    // rust: ('y', "ýÿŷȳẏẙỳỵỷỹуүγʏʸ"),
    // rust: ('z', "źżžƶẑẓẕᴢᶻ"),
    // rust: ];
