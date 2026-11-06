//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_consent
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The player's answer, kept in `telemetry/consent.json` in the game folder: one switch per
//! kind of data, all off until they turn one on, with the consent version and when they answered.
// use std::path::{Path, PathBuf};

// use serde::{Deserialize, Serialize};

// use crate::{CONSENT_VERSION, Kind};

/// What the player allows, kind by kind.
pub const Choices = struct {
    /// Performance summaries: frame-time percentiles and buckets, tick times, memory, startup.
    performance: bool,
    /// Crash reports, without paths, names or addresses.
    crashes: bool,
    /// Bug reports the player writes and sends themselves.
    bugs: bool,
    /// Benchmark reports from the launcher and the game.
    benchmarks: bool,
};

    // rust: impl Choices {
    // rust: pub const NONE: Self = Self {
    // rust: performance: false,
    // rust: crashes: false,
    // rust: bugs: false,
    // rust: benchmarks: false,
}
    // rust: pub const ALL: Self = Self {
    // rust: performance: true,
    // rust: crashes: true,
    // rust: bugs: true,
    // rust: benchmarks: true,
}

pub fn allows(self: *Self, kind: Kind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: Kind::Perf => self.performance,
    // rust: Kind::Crash => self.crashes,
    // rust: Kind::Bug => self.bugs,
    // rust: Kind::Benchmark => self.benchmarks,
}
}

pub fn set(self: *Self, kind: Kind, on: bool) void {
}
    // rust: match kind {
    // rust: Kind::Perf => self.performance = on,
    // rust: Kind::Crash => self.crashes = on,
    // rust: Kind::Bug => self.bugs = on,
    // rust: Kind::Benchmark => self.benchmarks = on,
}
}

pub fn any(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Kind::ALL.into_iter().any(|k| self.allows(k))
}
}

pub const Consent = struct {
    /// The [`CONSENT_VERSION`] the player answered; 0 if they never did.
    version: u32,
    /// When they answered, in seconds since 1970 (UTC).
    answered: u64,
    choices: Choices,
    /// Random, made at the first yes and replaced on reset; it ties a player's items together
    /// so they can be deleted, and nothing else. Empty until then.
    install_id: []const u8,
};

    // rust: impl Consent {
pub fn path(home: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::dir(home).join("consent.json")
}

    /// The saved answer; a missing or unreadable file is "never asked", which allows nothing.
pub fn load(home: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read(Self::path(home))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .unwrap_or_default()
}

pub fn save(self: *Self, home: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let json = serde_json::to_vec_pretty(self).map_err(std::io::Error::other)?;
    // rust: crate::write_atomic(&Self::path(home), &json)
}

    /// Whether the launcher should ask: never answered, or what is collected has changed since.
pub fn needs_asking(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.version < CONSENT_VERSION
}

    /// Whether items of `kind` may be kept and sent. Never before an answer to the current
    /// question (a newer launcher's answer covers an older game's).
pub fn allows(self: *Self, kind: Kind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.needs_asking() && !self.install_id.is_empty() && self.choices.allows(kind)
}

    /// Records the player's answer now. The install ID is made at the first yes and kept when
    /// they turn everything off, so "Delete my data" can still name it.
pub fn answer(self: *Self, choices: Choices) void {
}
    // rust: self.version = CONSENT_VERSION;
    // rust: self.answered = crate::now_secs();
    // rust: self.choices = choices;
    // rust: if choices.any() && self.install_id.is_empty() {
    // rust: self.install_id = new_install_id();
}
}

    /// A new install ID (after "Delete my data"): nothing sent later links to what came before.
pub fn reset_install_id(self: *Self) void {
}
    // rust: self.install_id = if self.choices.any() {
    // rust: new_install_id()
    // rust: } else {
    // rust: String::new()
}
}
}

/// 128 random bits in hex.
pub fn new_install_id() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::random_hex(16)
}

/// Whether `id` looks like one of ours: 32 lowercase hex digits.
pub fn is_install_id(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: id.len() == 32 && id.bytes().all(|b| matches!(b, b'0'..=b'9' | b'a'..=b'f'))
}

    // rust: mod tests {
//     use super::*;

pub fn nothing_is_allowed_before_the_player_answers() void {
}
    // rust: let home = crate::test_home::new("consent-default");
    // rust: let consent = Consent::load(&home);
    // rust: assert!(consent.needs_asking());
    // rust: assert!(Kind::ALL.iter().all(|&k| !consent.allows(k)));
        // A broken file is the same as none.
    // rust: std::fs::create_dir_all(crate::dir(&home)).unwrap();
    // rust: std::fs::write(Consent::path(&home), b"{not json").unwrap();
    // rust: assert_eq!(Consent::load(&home), Consent::default());
}

pub fn an_answer_allows_only_what_was_chosen_and_is_saved() void {
}
    // rust: let home = crate::test_home::new("consent-answer");
    // rust: let mut consent = Consent::load(&home);
    // rust: consent.answer(Choices {
    // rust: crashes: true,
    // rust: ..Choices::NONE
    // rust: });
    // rust: consent.save(&home).unwrap();
    // rust: let back = Consent::load(&home);
    // rust: assert_eq!(back, consent);
    // rust: assert!(!back.needs_asking());
    // rust: assert!(back.allows(Kind::Crash));
    // rust: assert!(!back.allows(Kind::Perf) && !back.allows(Kind::Bug));
    // rust: assert!(!back.allows(Kind::Benchmark));
    // rust: assert!(is_install_id(&back.install_id));
    // rust: assert!(back.answered > 1_700_000_000);
}

pub fn an_older_answer_allows_nothing_until_asked_again() void {
}
    // rust: let mut consent = Consent::default();
    // rust: consent.answer(Choices::ALL);
    // rust: consent.version = CONSENT_VERSION - 1;
    // rust: assert!(consent.needs_asking());
    // rust: assert!(Kind::ALL.iter().all(|&k| !consent.allows(k)));
}

pub fn no_id_is_made_for_a_no_and_a_reset_changes_it() void {
}
    // rust: let mut consent = Consent::default();
    // rust: consent.answer(Choices::NONE);
    // rust: assert!(consent.install_id.is_empty());
    // rust: consent.answer(Choices::ALL);
    // rust: let first = consent.install_id.clone();
    // rust: consent.answer(Choices::NONE);
    // rust: assert_eq!(consent.install_id, first, "kept so the data can be deleted");
    // rust: consent.answer(Choices::ALL);
    // rust: consent.reset_install_id();
    // rust: assert!(is_install_id(&consent.install_id) && consent.install_id != first);
}
}
