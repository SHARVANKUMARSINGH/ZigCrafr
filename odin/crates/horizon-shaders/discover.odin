//! Transpiled from Horizon Rust crate
package horizon_shaders_discover

import "core:fmt"
import "core:mem"
import "core:math"

// The packs in the game's `shaderpacks` folder: every folder and `.zip` in it (spec 1.1).

// use std::fs;
// use std::path::{Path, PathBuf};

// use crate::Pack;

// One entry of the `shaderpacks` folder that is or looks like a pack.
Found :: struct {
    // The folder or file name, which is how players and settings name the pack.
    name: string,
    path: PathBuf,
    // Why the entry can't be used, said to the player (a zip that doesn't open, a folder with
    // no `shaders` folder at its root). `None` for a usable pack.
    problem: Maybe(string),
}

// The packs in `dir`, sorted by name ignoring case. Hidden entries and files that are not
// `.zip` (the game's own option files live beside the packs) are skipped.
discover :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut found: Vec<Found> = fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|entry| {
    // rust: let name = entry.file_name().to_string_lossy().into_owned();
    // rust: let path = entry.path();
    // rust: let is_zip = path
    // rust: .extension()
    // rust: .is_some_and(|e| e.eq_ignore_ascii_case("zip"));
    // rust: if name.starts_with('.') || !(path.is_dir() || is_zip) {
    // rust: return None;
}
    // rust: let problem = Pack::open(&path).err().map(|e| e.to_string());
    // rust: Some(Found {
    // rust: name,
    // rust: path,
    // rust: problem,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: found.sort_by_cached_key(|f| (f.name.to_lowercase(), f.name.clone()));
    // rust: found
}

    // rust: mod tests {
//     use super::*;
//     use crate::pack::tests::{temp_dir, zip};

lists_folders_and_zips_with_their_problems :: proc() {
}
    // rust: let dir = temp_dir("discover");
    // rust: fs::create_dir_all(dir.join("Zeta/shaders")).unwrap();
    // rust: fs::create_dir_all(dir.join("Extracted wrong/Inner/shaders")).unwrap();
    // rust: fs::create_dir_all(dir.join(".hidden/shaders")).unwrap();
    // rust: fs::write(dir.join("alpha.ZIP"), zip(&[("shaders/final.fsh", "")])).unwrap();
    // rust: fs::write(dir.join("broken.zip"), "not a zip").unwrap();
    // rust: fs::write(dir.join("alpha.ZIP.txt"), "OPTION=1").unwrap();
    // rust: let found = discover(&dir);
    // rust: let summary: Vec<(&str, bool)> = found
    // rust: .iter()
    // rust: .map(|f| (f.name.as_str(), f.problem.is_none()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: summary,
    // rust: [
    // rust: ("alpha.ZIP", true),
    // rust: ("broken.zip", false),
    // rust: ("Extracted wrong", false),
    // rust: ("Zeta", true)
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: found[2].problem.as_deref(),
    // rust: Some("no shaders folder at the root of the pack")
    // rust: );
    // rust: assert!(discover(&dir.join("missing")).is_empty());
    // rust: fs::remove_dir_all(&dir).unwrap();
}
}
