//! Transpiled from Horizon Rust crate
package horizon_world_json_file

import "core:fmt"
import "core:mem"
import "core:math"

// Reading a prepared JSON file with the file named in the error.
//
// `serde_json` reports only where in the document it failed ("expected value at
// line 1 column 1"), which says nothing about which of the prepared folder's
// many files a player should prepare again. These helpers put the path in front
// of that message.

// use serde::de::{Deserialize, DeserializeOwned};
// use std::{fs, io, path::Path};

// `path`'s bytes; an I/O error names the file.
read_bytes :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: fs::read(path).map_err(|e| named(path, e))
}

// `bytes` as JSON; a parse error names `path`.
    // rust: pub fn parse<'de, T: Deserialize<'de>>(path: &Path, bytes: &'de [u8]) -> io::Result<T> {
    // rust: serde_json::from_slice(bytes).map_err(|e| {
    // rust: io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: format!("{}: {e}", path.display()),
    // rust: )
    // rust: })
}

// `path` as JSON; an I/O or parse error names the file.
    // rust: pub fn read<T: DeserializeOwned>(path: &Path) -> io::Result<T> {
    // rust: parse(path, &read_bytes(path)?)
}

// An I/O error whose message starts with the path it happened to.
named :: proc(path: ^Path, error: io::Error) -> i {
    // Ported from Horizon
    return {}
}
    // rust: io::Error::new(error.kind(), format!("{}: {error}", path.display()))
}

// A path for tests: a fresh folder under the system temporary directory.
test_dir :: proc(tag: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-json-file-{tag}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

    // rust: mod tests {
//     use super::*;

a_parse_error_names_the_file :: proc() {
}
    // rust: let dir = test_dir("parse");
    // rust: let empty = dir.join("gameplay-facts.json");
    // rust: fs::write(&empty, b"").unwrap();
    // rust: let error = read::<serde_json::Value>(&empty).unwrap_err().to_string();
    // rust: assert!(error.contains("gameplay-facts.json"), "{error}");

    // rust: let broken = dir.join("block-tags.json");
    // rust: fs::write(&broken, br#"{"a": "#).unwrap();
    // rust: let error = read::<serde_json::Value>(&broken).unwrap_err().to_string();
    // rust: assert!(error.contains("block-tags.json"), "{error}");

    // rust: let missing = dir.join("attributes.json");
    // rust: let error = read::<serde_json::Value>(&missing).unwrap_err().to_string();
    // rust: assert!(error.contains("attributes.json"), "{error}");
    // rust: let _ = fs::remove_dir_all(&dir);
}
}
