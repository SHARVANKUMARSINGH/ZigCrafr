//! Transpiled from Horizon Rust crate
//! Module: horizon-narrator_linux_split
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `NarratorLinux.say`'s split of a message into the pieces flite speaks one
//! by one. Pure, so its tests run on every platform.

/// `msg.split("[,.:;/\"()\\[\\]{}!?\\\\]+")` filtered by `!x.isBlank()`: the
/// text between runs of punctuation, untrimmed, without the blank pieces
/// (which also drops the leading and trailing empty ones `split` keeps or
/// removes).
    // rust: pub(super) fn units(message: &str) -> impl Iterator<Item = &str> {
    // rust: message
    // rust: .split(PUNCTUATION)
    // rust: .filter(|unit| !unit.chars().all(java_whitespace))
}

/// The pattern's character class.
    // rust: const PUNCTUATION: [char; 15] = [
    // rust: ',', '.', ':', ';', '/', '"', '(', ')', '[', ']', '{', '}', '!', '?', '\\',
    // rust: ];

/// `Character.isWhitespace`, which `String.isBlank` asks of every code point:
/// the space, line and paragraph separators but the no-break spaces (U+00A0,
/// U+2007, U+202F), and the controls U+0009–U+000D and U+001C–U+001F. Not
/// Rust's `char::is_whitespace`, which takes U+0085 and the no-break spaces
/// but not U+001C–U+001F.
pub fn java_whitespace(c: char) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: c,
    // rust: '\t'..='\r'
    // rust: | '\u{1C}'..='\u{1F}'
    // rust: | ' '
    // rust: | '\u{1680}'
    // rust: | '\u{2000}'..='\u{2006}'
    // rust: | '\u{2008}'..='\u{200A}'
    // rust: | '\u{2028}'
    // rust: | '\u{2029}'
    // rust: | '\u{205F}'
    // rust: | '\u{3000}'
    // rust: )
}

    // rust: mod tests {
//     use super::units;

pub fn split(message: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: units(message).collect()
}

pub fn splits_on_runs_of_punctuation_and_keeps_the_spaces() void {
}
    // rust: assert_eq!(
    // rust: split("Hello, world. How are you?"),
    // rust: ["Hello", " world", " How are you"]
    // rust: );
    // rust: assert_eq!(split("a,.:;/\"()[]{}!?\\b"), ["a", "b"]);
    // rust: assert_eq!(
    // rust: split("Title screen: Singleplayer button"),
    // rust: ["Title screen", " Singleplayer button"]
    // rust: );
}

pub fn drops_blank_pieces_and_leading_or_trailing_punctuation() void {
}
    // rust: assert_eq!(split("...Hi... , ...there!!"), ["Hi", "there"]);
    // rust: assert_eq!(split(", ,\t, \n"), Vec::<&str>::new());
    // rust: assert_eq!(split(""), Vec::<&str>::new());
    // rust: assert_eq!(split("!!!"), Vec::<&str>::new());
}

pub fn keeps_what_the_pattern_does_not_name() void {
}
    // rust: assert_eq!(split("it's 5-6 o'clock"), ["it's 5-6 o'clock"]);
    // rust: assert_eq!(split("a|b<c>d"), ["a|b<c>d"]);
}

pub fn blank_is_java_whitespace() void {
}
        // No-break spaces are not whitespace to Java: the piece is spoken.
    // rust: assert_eq!(split("a,\u{A0},b"), ["a", "\u{A0}", "b"]);
    // rust: assert_eq!(split("a,\u{85},b"), ["a", "\u{85}", "b"]);
        // The information separators are.
    // rust: assert_eq!(split("a,\u{1F}\u{3000},b"), ["a", "b"]);
}
}
