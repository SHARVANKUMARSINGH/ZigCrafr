//! Transpiled from Horizon Rust crate
package horizon_core_release

import "core:fmt"
import "core:mem"
import "core:math"

// Which Horizon release this build is (docs/versioning.md). Not Minecraft's version: that is
// [`crate::version`], generated from the game's own files.

// The release's version (`0.2.3`, no `v`): release.yml builds every release with `HORIZON_VERSION`
// set from its tag, so there are no version-bump commits. None for a build from source.
    // rust: pub const RELEASE: Option<&str> = match option_env!("HORIZON_VERSION") {
    // rust: Some(version) if !version.is_empty() => Some(version),
    // rust: _ => None,
}

// [`RELEASE`], or this crate's Cargo.toml version for a build from source: what `--version`, user
// agents and reports say.
    // rust: pub const VERSION: &str = match RELEASE {
    // rust: Some(version) => version,
    // rust: None => env!("CARGO_PKG_VERSION"),
}

// A nightly's date and commit (`2026-10-28 0c02067`): nightly-build.yml builds the opt-in Nightly
// channel with `HORIZON_NIGHTLY` set (docs/release-flow.md). None for a release or a build from source.
    // rust: pub const NIGHTLY: Option<&str> = match option_env!("HORIZON_NIGHTLY") {
    // rust: Some(nightly) if !nightly.is_empty() => Some(nightly),
    // rust: _ => None,
}

// How a nightly names itself where players read it, so their reports say which build they come
// from: `Nightly 2026-10-28 · 0c02067`. None for any other build.
nightly_label :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: NIGHTLY.map(label)
}

// A nightly's version as the launcher installs it (`nightly-2026-10-28-0c02067`).
nightly_version :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: NIGHTLY.map(|n| format!("nightly-{}", n.replace(' ', "-")))
}

label :: proc(nightly: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match nightly.split_once(' ') {
    // rust: Some((date, commit)) => format!("Nightly {date} · {commit}"),
    // rust: None => format!("Nightly {nightly}"),
}
}

    // rust: mod tests {
a_nightly_names_its_date_and_commit :: proc() {
}
    // rust: assert_eq!(
    // rust: super::label("2026-10-28 0c02067"),
    // rust: "Nightly 2026-10-28 · 0c02067"
    // rust: );
    // rust: assert_eq!(super::label("2026-10-28"), "Nightly 2026-10-28");
    // rust: assert_eq!(super::nightly_label().is_some(), super::NIGHTLY.is_some());
}

the_version_is_the_release_or_the_crate :: proc() {
}
    // rust: assert_eq!(
    // rust: super::RELEASE,
    // rust: option_env!("HORIZON_VERSION").filter(|v| !v.is_empty())
    // rust: );
    // rust: assert_eq!(
    // rust: super::VERSION,
    // rust: super::RELEASE.unwrap_or(env!("CARGO_PKG_VERSION"))
    // rust: );
    // rust: assert!(!super::VERSION.starts_with('v'));
}
}
