//! Transpiled from Horizon Rust crate
package horizon_items_content_namespaces

import "core:fmt"
import "core:mem"
import "core:math"

// The namespaces content mods add to a resource root, which loaders read
// besides `minecraft`.
// use std::{fs, path::Path};

// In a root built here: the namespaces the content mods own (their ids and
// listed namespaces), which loaders read besides `minecraft`.
MARKER :: "horizon-mod-content.json"

// The content mods' namespaces in a root built by `mod_content::build`; none in any
// other root, so vanilla's loaders read exactly what they did.
namespaces :: proc(root: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: fs::read(root.join(MARKER))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .unwrap_or_default()
}

// The namespaces whose tags loaders read in `root`: `minecraft`, and in a
// root built by `mod_content::build` the convention tags (`c`, shared between mods as
// on NeoForge and Fabric) and the content mods' own.
tag_namespaces :: proc(root: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mods = namespaces(root);
    // rust: let mut out = vec!["minecraft".to_owned()];
    // rust: if !mods.is_empty() {
    // rust: out.push("c".to_owned());
    // rust: out.extend(mods);
}
    // rust: out
}

// The mod ids (not namespaces) of the content mods in a root built by
// `mod_content::build`. `mod_loaded` conditions ask these: a mod that
// also owns a namespace doesn't make that namespace another mod.
MOD_IDS_MARKER :: "horizon-mod-ids.json"

// The content mods' ids in a root built by `mod_content::build`; none in
// any other root.
mod_ids :: proc(root: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: fs::read(root.join(MOD_IDS_MARKER))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .unwrap_or_default()
}
