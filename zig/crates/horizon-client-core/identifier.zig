//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_identifier
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resource identifiers (`Identifier`).

/// Identifier.parse: `ns:path` or `path`, validated.
pub fn parse_identifier(raw: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = match raw.split_once(':') {
    // rust: Some(("", path)) => ("minecraft", path),
    // rust: Some((ns, path)) => (ns, path),
    // rust: None => ("minecraft", raw),
}
    // rust: let ns_ok = ns != ".."
    // rust: && ns
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || matches!(c, '_' | '.' | '-'));
    // rust: let path_ok = path.chars().all(|c| {
    // rust: c.is_ascii_lowercase() || c.is_ascii_digit() || matches!(c, '_' | '.' | '-' | '/')
    // rust: });
    // rust: (ns_ok && path_ok).then(|| format!("{ns}:{path}"))
}

/// `Identifier.CODEC` parsing an entity id: lowercase namespace and path
/// characters, `minecraft` when the namespace is left out.
pub fn normalize_id(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = match s.split_once(':') {
    // rust: Some((ns, path)) => (if ns.is_empty() { "minecraft" } else { ns }, path),
    // rust: None => ("minecraft", s),
}
    // rust: let ok = |c: char, slash: bool| {
    // rust: c.is_ascii_lowercase()
    // rust: || c.is_ascii_digit()
    // rust: || matches!(c, '_' | '-' | '.')
    // rust: || slash && c == '/'
}
    // rust: (ns.chars().all(|c| ok(c, false)) && path.chars().all(|c| ok(c, true)))
    // rust: .then(|| format!("{ns}:{path}"))
}
