//! Transpiled from Horizon Rust crate
//! Module: horizon-core_no_ai
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The "No AI" switch: one setting that hides and turns off every AI feature of Horizon (the
//! companion, agent control through the control socket, `horizon-ctl`, its MCP server and the
//! launcher's). The launcher and the game both read and write it here, so they always agree.
//!
//! It is the `noAi` line of the game's `horizon-extras.txt`, in the game's home (the folder
//! with `options.txt`). Missing means off: AI features are available. See docs/agent-control.md.
// use std::{fs, io, path::Path};

/// The game's extras file, beside `options.txt`.
pub const FILE: []const u8 = "horizon-extras.txt";
/// The key No AI is kept under there.
pub const KEY: []const u8 = "noAi";
/// The one line every AI surface answers with while No AI is on.
pub const REFUSAL: []const u8 = "AI features are off: turn off No AI in the launcher's settings";

/// Whether `text` (an extras file) says No AI.
pub fn parse(text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines().any(|line| {
    // rust: line.split_once(':')
    // rust: .is_some_and(|(k, v)| k.trim() == KEY && v.trim() == "true")
    // rust: })
}

/// Whether No AI is on for the game whose home is `home`.
pub fn is_on(home: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::read_to_string(home.join(FILE)).is_ok_and(|text| parse(&text))
}

/// `text` with its `noAi` line set to `on`, every other line kept as it was.
pub fn with(text: []const u8, on: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: String = text
    // rust: .lines()
    // rust: .filter(|line| line.split_once(':').is_none_or(|(k, _)| k.trim() != KEY))
    // rust: .flat_map(|line| [line, "\n"])
    // rust: .collect();
    // rust: out.push_str(&format!("{KEY}:{on}\n"));
    // rust: out
}

/// Turns No AI on or off for the game in `home`, keeping the file's other settings. Turning it
/// off where there is no file writes nothing (off is the default).
pub fn set(home: *Path, on: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = home.join(FILE);
    // rust: let text = match fs::read_to_string(&path) {
    // rust: Ok(text) => text,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => {
    // rust: if !on {
    // rust: return Ok(());
}
    // rust: String::new()
}
    // rust: Err(e) => return Err(e),
}
    // rust: fs::create_dir_all(home)?;
    // rust: fs::write(path, with(&text, on))
}

/// `Err(REFUSAL)` while No AI is on in `home`.
pub fn check(home: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_on(home) { Err(REFUSAL) } else { Ok(()) }
}

    // rust: mod tests {
//     use super::*;

pub fn reads_and_writes_the_extras_line_keeping_the_others() void {
}
    // rust: assert!(!parse(""));
    // rust: assert!(!parse("noAi:false\nzoom:true\n"));
    // rust: assert!(parse("zoom:true\nnoAi: true\n"));
    // rust: assert_eq!(
    // rust: with("zoom:true\nnoAi:false\nfps:true", true),
    // rust: "zoom:true\nfps:true\nnoAi:true\n"
    // rust: );
    // rust: assert_eq!(with("", false), "noAi:false\n");
}

pub fn set_writes_only_when_needed() void {
}
    // rust: let home = std::env::temp_dir().join(format!("horizon-no-ai-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&home);
    // rust: set(&home, false).unwrap();
    // rust: assert!(!home.join(FILE).exists(), "off needs no file");
    // rust: assert!(check(&home).is_ok());
    // rust: set(&home, true).unwrap();
    // rust: assert!(is_on(&home));
    // rust: assert_eq!(check(&home), Err(REFUSAL));
    // rust: fs::write(home.join(FILE), "fps:true\nnoAi:true\n").unwrap();
    // rust: set(&home, false).unwrap();
    // rust: assert_eq!(
    // rust: fs::read_to_string(home.join(FILE)).unwrap(),
    // rust: "fps:true\nnoAi:false\n"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&home);
}
}
