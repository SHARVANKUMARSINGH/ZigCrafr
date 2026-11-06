//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_eula
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! eula.txt (net.minecraft.server.Eula): the server runs only once the file
//! says `eula=true`; a file that is missing or unreadable is replaced with
//! the default one and counts as not agreed.
// use super::java_properties::{Properties, date_string, now_millis};
// use std::path::Path;

/// CommonLinks.EULA.
pub const EULA_LINK: []const u8 = "https://aka.ms/MinecraftEULA";

/// The default file, as Properties.store(OutputStream) writes it.
pub fn default_file(millis: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: file(millis, false)
}

/// The file with `eula` set: what the owner's agreement writes (horizon-server init).
pub fn file(millis: i64, agreed: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Properties::default();
    // rust: p.put("eula", agreed.to_string());
    // rust: p.store(
    // rust: Some(&format!(
    // rust: "By changing the setting below to TRUE you are indicating your agreement to our EULA ({EULA_LINK})."
    // rust: )),
    // rust: &date_string(millis),
    // rust: true,
    // rust: )
}

/// Eula.readFile; `Err` carries the warning vanilla logs.
pub fn agreed(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = std::fs::read(path)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|b| Properties::load_latin1(&b).map_err(|e| e.to_string()));
    // rust: match read {
    // rust: Ok(p) => Ok(p
    // rust: .get("eula")
    // rust: .unwrap_or("false")
    // rust: .eq_ignore_ascii_case("true")),
    // rust: Err(_) => {
    // rust: let _ = std::fs::write(path, default_file(now_millis()));
    // rust: Err(format!("Failed to load {}", path.display()))
}
}
}
