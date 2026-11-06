//! Transpiled from Horizon Rust crate
package horizon_client_render_store

import "core:fmt"
import "core:mem"
import "core:math"

// Instance-local picker entries. Hiding an entry never removes settings or world saves.
// use std::{fs, io, path::Path};

HIDDEN :: ".hidden"

names :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let entries = match fs::read_dir(root) {
    // rust: Ok(entries) => entries,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => return Ok(Vec::new()),
    // rust: Err(e) => return Err(e),
}
    // rust: let mut names = Vec::new();
    // rust: for entry in entries {
    // rust: let entry = entry?;
    // rust: let Some(name) = entry.file_name().to_str().map(str::to_owned) else {
    // rust: continue;
}
    // rust: if entry.file_type()?.is_dir()
    // rust: && super::valid_name(&name)
    // rust: && !entry.path().join(HIDDEN).exists()
    // rust: {
    // rust: names.push(name);
}
}
    // rust: names.sort_by_key(|n| n.to_lowercase());
    // rust: Ok(names)
}

valid :: proc(name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if super::valid_name(name) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(io::Error::new(
    // rust: io::ErrorKind::InvalidInput,
    // rust: "Invalid offline profile name",
    // rust: ))
}
}

hide :: proc(root: ^Path, name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: valid(name)?;
    // rust: fs::write(root.join(name).join(HIDDEN), b"")
}

// Restore the exact name: case changes would select another offline UUID.
restore :: proc(root: ^Path, name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: valid(name)?;
    // rust: fs::create_dir_all(root)?;
    // rust: for entry in fs::read_dir(root)? {
    // rust: let entry = entry?;
    // rust: let old = entry.file_name();
    // rust: let Some(old) = old.to_str() else { continue };
    // rust: if entry.file_type()?.is_dir() && old != name && old.eq_ignore_ascii_case(name) {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::AlreadyExists,
    // rust: format!("Use the existing spelling: {old}"),
    // rust: ));
}
}
    // rust: fs::create_dir_all(root.join(name))?;
    // rust: match fs::remove_file(root.join(name).join(HIDDEN)) {
    // rust: Ok(()) => Ok(()),
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => Ok(()),
    // rust: Err(e) => Err(e),
}
}

    // rust: mod tests {
//     use super::*;

hide_and_restore_preserve_settings_and_stay_in_one_instance :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("hz-profile-store-{}", std::process::id()));
    // rust: let (a, b) = (root.join("a"), root.join("b"));
    // rust: restore(&a, "jordank").unwrap();
    // rust: let options = a.join("jordank/options.txt");
    // rust: fs::write(&options, "guiScale:2\n").unwrap();
    // rust: assert_eq!(names(&a).unwrap(), ["jordank"]);
    // rust: assert!(names(&b).unwrap().is_empty());
    // rust: hide(&a, "jordank").unwrap();
    // rust: assert!(names(&a).unwrap().is_empty());
    // rust: assert!(restore(&a, "JordanK").is_err());
    // rust: restore(&a, "jordank").unwrap();
    // rust: assert_eq!(fs::read_to_string(options).unwrap(), "guiScale:2\n");
    // rust: assert_eq!(names(&a).unwrap(), ["jordank"]);
    // rust: assert!(hide(&a, "../bad").is_err());
    // rust: fs::remove_dir_all(root).unwrap();
}
}
