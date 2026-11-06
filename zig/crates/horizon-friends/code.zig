//! Transpiled from Horizon Rust crate
//! Module: horizon-friends_code
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Invite codes: eight Crockford base32 symbols shown as `K7QM-3XPD`. The
//! first four are the nameplate the relay finds the host by; the last four
//! are the secret the key exchange uses, which only the players see.
// use std::fmt;

/// Crockford base32: digits and letters without I, L, O and U.
pub const ALPHABET: *[u8; 32] = b"0123456789ABCDEFGHJKMNPQRSTVWXYZ";
/// Symbols in each half of a code.
pub const HALF: usize = 4;

/// The value of a symbol as a player may type it: any case, `O` for `0`,
/// `I` and `L` for `1`.
pub fn value(c: char) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = match c.to_ascii_uppercase() {
    // rust: 'O' => '0',
    // rust: 'I' | 'L' => '1',
    // rust: c => c,
}
    // rust: ALPHABET
    // rust: .iter()
    // rust: .position(|&a| char::from(a) == c)
    // rust: .map(|i| i as u8)
}

/// Four symbols (20 bits) as their canonical text.
pub fn symbols(bits: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..HALF)
    // rust: .rev()
    // rust: .map(|i| char::from(ALPHABET[(bits >> (5 * i)) as usize & 31]))
    // rust: .collect()
}

/// A nameplate drawn from 20 random bits.
pub fn nameplate(bits: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: symbols(bits & 0xF_FFFF)
}

/// A nameplate as a player or a client sent it, made canonical; None when it
/// isn't four symbols.
pub fn parse_nameplate(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let symbols: Option<Vec<u8>> = text.chars().map(value).collect();
    // rust: let symbols = symbols?;
    // rust: (symbols.len() == HALF).then(|| {
    // rust: symbols
    // rust: .iter()
    // rust: .map(|&v| char::from(ALPHABET[v as usize]))
    // rust: .collect()
    // rust: })
}

pub const Code = struct {
    nameplate: []const u8,
    secret: []const u8,
};
    // rust: impl Code {
    /// A code for a nameplate the relay handed out, with a fresh secret from
    /// the OS random generator.
pub fn new(nameplate: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut b = [0u8; 4];
    // rust: crate::fill_random(&mut b)?;
    // rust: Ok(Self {
    // rust: nameplate: nameplate.to_owned(),
    // rust: secret: symbols(u32::from_le_bytes(b) & 0xF_FFFF),
    // rust: })
}
    /// A code as a player typed it: spaces, dashes and case don't matter, `O`
    /// reads as `0`, `I` and `L` as `1`.
pub fn parse(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::with_capacity(2 * HALF);
    // rust: for c in text.chars() {
    // rust: if c.is_whitespace() || c == '-' {
    // rust: continue;
}
    // rust: out.push(char::from(ALPHABET[value(c)? as usize]));
}
    // rust: if out.len() != 2 * HALF {
    // rust: return None;
}
    // rust: let (nameplate, secret) = out.split_at(HALF);
    // rust: Some(Self {
    // rust: nameplate: nameplate.to_owned(),
    // rust: secret: secret.to_owned(),
    // rust: })
}
}
    // rust: impl fmt::Display for Code {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{}-{}", self.nameplate, self.secret)
}
}
/// The secret stays out of debug output and logs.
    // rust: impl fmt::Debug for Code {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "Code({}-****)", self.nameplate)
}
}

    // rust: mod tests {
//     use super::*;

pub fn alphabet_has_no_ambiguous_letters() void {
}
    // rust: assert_eq!(ALPHABET.len(), 32);
    // rust: for c in *b"ILOU" {
    // rust: assert!(!ALPHABET.contains(&c));
}
    // rust: let mut sorted = ALPHABET.to_vec();
    // rust: sorted.dedup();
    // rust: assert_eq!(sorted.len(), 32);
}

pub fn nameplates_cover_twenty_bits() void {
}
    // rust: assert_eq!(nameplate(0), "0000");
    // rust: assert_eq!(nameplate(0xF_FFFF), "ZZZZ");
    // rust: assert_eq!(nameplate(0x8000 | 31), "100Z");
        // High bits beyond 20 are ignored.
    // rust: assert_eq!(nameplate(0xFFF0_0001), "0001");
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for bits in (0..0x10_0000).step_by(997) {
    // rust: assert!(seen.insert(nameplate(bits)));
}
}

pub fn parses_what_players_type() void {
}
    // rust: let code = Code::parse("k7qm-3xpd").unwrap();
    // rust: assert_eq!(code.nameplate, "K7QM");
    // rust: assert_eq!(code.secret, "3XPD");
    // rust: assert_eq!(code.to_string(), "K7QM-3XPD");
    // rust: assert_eq!(Code::parse(" K7QM 3XPD ").unwrap(), code);
    // rust: assert_eq!(Code::parse("K7QM3XPD").unwrap(), code);
        // O, I and L are the symbols they look like.
    // rust: let code = Code::parse("OIL0-1lio").unwrap();
    // rust: assert_eq!(code.to_string(), "0110-1110");
    // rust: assert!(Code::parse("K7QM-3XP").is_none());
    // rust: assert!(Code::parse("K7QM-3XPDA").is_none());
    // rust: assert!(Code::parse("K7QM-3XPU").is_none());
    // rust: assert!(Code::parse("").is_none());
}

pub fn fresh_secrets_are_canonical_and_differ() void {
}
    // rust: let a = Code::new("K7QM").unwrap();
    // rust: assert_eq!(Code::parse(&a.to_string()).unwrap(), a);
    // rust: let different = (0..8).any(|_| Code::new("K7QM").unwrap().secret != a.secret);
    // rust: assert!(different);
    // rust: assert_eq!(format!("{a:?}"), "Code(K7QM-****)");
}

pub fn nameplates_parse() void {
}
    // rust: assert_eq!(parse_nameplate("k7qm").as_deref(), Some("K7QM"));
    // rust: assert_eq!(parse_nameplate("K7Q"), None);
    // rust: assert_eq!(parse_nameplate("K7QU"), None);
}
}
