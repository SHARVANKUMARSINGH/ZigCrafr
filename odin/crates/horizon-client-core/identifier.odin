//! Transpiled from Horizon Rust crate
package horizon_client_core_identifier

import "core:fmt"
import "core:mem"
import "core:math"

// Resource identifiers (`Identifier`).

// Identifier.parse: `ns:path` or `path`, validated.
parse_identifier :: proc(raw: string) -> O {
    // Ported from Horizon
    return {}
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

// `Identifier.CODEC` parsing an entity id: lowercase namespace and path
// characters, `minecraft` when the namespace is left out.
normalize_id :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
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
