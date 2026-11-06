//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_data
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Data files of native mods (docs/native-mods.md, "Data files"). A bundle's `data/` folder is
//! staged as `native-data/<mod id>/` at the root of the workspace the launcher builds, and
//! [`native_data!`](crate::native_data) compiles one of its files into the game. What a mod's
//! post-build step writes at build time is read at run time from [`built`].
// use std::path::PathBuf;

/// The bytes of file `$file` of native mod `$id`'s `data/` folder, compiled in
/// (`&'static [u8; N]`): `horizon_client::native_data!("my_mod", "table.bin")` in a helper or
/// support module of the game's crate, `crate::native_data!` in the lib's. A mod's own crate
/// reads its files with `include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/data/…"))`.
/// Hook points API 41.
    // rust: macro_rules! native_data {
    // rust: ($id:literal, $file:literal $(,)?) => {
    // rust: include_bytes!($crate::native_data!(@path $id, $file))
}
    // rust: (@path $id:literal, $file:literal) => {
    // rust: concat!(
    // rust: env!("CARGO_MANIFEST_DIR"),
    // rust: "/../../native-data/",
    // rust: $id,
    // rust: "/",
    // rust: $file
    // rust: )
}
}

/// The folder native mod `mod_id`'s post-build step wrote into
/// (`HORIZON_NATIVE_DATA_DIR`): `native-data/<mod id>/` beside the game's executable, in the
/// native build's version folder. Empty or missing for a mod without one. None when the
/// game's own path is unknown: never a folder relative to wherever the game was started.
pub fn built(mod_id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let exe = std::env::current_exe().ok()?;
    // rust: Some(exe.parent()?.join("native-data").join(mod_id))
}

    // rust: mod tests {
pub fn data_is_found_from_the_workspace_root_and_beside_the_game() void {
}
        // From the workspace root, two folders above any of its crates.
    // rust: let path = crate::native_data!(@path "zoom", "levels/a.bin");
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../..");
    // rust: assert_eq!(
    // rust: std::path::Path::new(path),
    // rust: root.join("native-data/zoom/levels/a.bin")
    // rust: );
    // rust: let exe = std::env::current_exe().unwrap();
    // rust: let dir = super::built("zoom").unwrap();
    // rust: assert_eq!(dir.parent().unwrap().parent(), exe.parent());
    // rust: assert!(dir.ends_with("native-data/zoom"));
}
}
