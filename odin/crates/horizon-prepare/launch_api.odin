//! Transpiled from Horizon Rust crate
package horizon_prepare_launch_api

import "core:fmt"
import "core:mem"
import "core:math"

// The preparer's side of the Launch API (docs/api/launch.md): the options another launcher may
// pass and `horizon-prepare --launch-api`'s reply, so it can ask what this preparer supports
// before it runs one.

// use crate::artifacts::Lock;
// use crate::pyjson::{self, Value};

// The Launch API's version, the same line as `horizon-client --launch-api`'s
// (docs/api/stability.md): an addition makes the next patch.
VERSION :: "0.1.0"

// What a launcher may pass, with its value's placeholder (none for a flag). The asset commands
// (`sounds`, `fonts`...) stay out: `--complete` runs what a launcher needs of them.
    // rust: pub const OPTIONS: &[(&str, Option<&str>)] = &[
    // rust: ("--prepare", None),
    // rust: ("--server-jar", Some("PATH")),
    // rust: ("--minecraft-dir", Some("PATH")),
    // rust: ("--version-json", Some("PATH")),
    // rust: ("--client-jar", Some("PATH")),
    // rust: ("--libraries-dir", Some("PATH")),
    // rust: ("--assets-dir", Some("PATH")),
    // rust: ("--java-home", Some("PATH")),
    // rust: ("--root", Some("PATH")),
    // rust: ("--output", Some("PATH")),
    // rust: ("--check", None),
    // rust: ("--complete", None),
    // rust: ("--progress", Some("json")),
    // rust: ("--launch-api", None),
    // rust: ];

// 0 done, 1 failed or gaps found, 2 a refused command line.
EXIT_CODES :: &[0, 1, 2]

// `--launch-api`'s reply for this preparer (`horizon`, its version) and the pins beside it.
reply :: proc(horizon: string, lock: ^Lock) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let int = |n: i64| Value::Int(n.to_string());
    // rust: let options = OPTIONS
    // rust: .iter()
    // rust: .map(|(name, value)| {
    // rust: Value::Object(vec![
    // rust: ("name".into(), Value::str(*name)),
    // rust: ("value".into(), value.map_or(Value::Null, Value::str)),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: let reply = Value::Object(vec![
    // rust: ("launch_api".into(), Value::str(VERSION)),
    // rust: ("horizon".into(), Value::str(horizon)),
    // rust: ("minecraft".into(), Value::str(&lock.version)),
    // rust: ("java_major".into(), int(lock.java_major)),
    // rust: ("schema".into(), int(crate::SCHEMA)),
    // rust: (
    // rust: "output_version".into(),
    // rust: int(i64::from(crate::OUTPUT_VERSION)),
    // rust: ),
    // rust: ("options".into(), Value::Array(options)),
    // rust: (
    // rust: "exit_codes".into(),
    // rust: Value::Array(EXIT_CODES.iter().map(|&c| int(c)).collect()),
    // rust: ),
    // rust: ]);
    // rust: pyjson::dumps(&reply, &pyjson::INDENT2)
}

    // rust: mod tests {
//     use super::*;

the_reply_names_the_pins_and_the_layout :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-launch-api-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(
    // rust: root.join("research-lock.json"),
    // rust: r#"{"minecraft": {"version": "9.9", "java_major": 25}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let lock = Lock::read(&root).unwrap();
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let reply = pyjson::loads(&reply("1.2.3", &lock)).unwrap();
    // rust: let text = |key: &str| reply.get(key).and_then(Value::as_str).map(str::to_owned);
    // rust: let int = |key: &str| match reply.get(key) {
    // rust: Some(Value::Int(n)) => n.clone(),
    // rust: other => panic!("{key}: {other:?}"),
}
    // rust: assert_eq!(text("launch_api").as_deref(), Some(VERSION));
    // rust: assert_eq!(text("horizon").as_deref(), Some("1.2.3"));
    // rust: assert_eq!(text("minecraft").as_deref(), Some("9.9"));
    // rust: assert_eq!(int("java_major"), "25");
    // rust: assert_eq!(int("schema"), crate::SCHEMA.to_string());
    // rust: assert_eq!(int("output_version"), crate::OUTPUT_VERSION.to_string());
    // rust: let progress = reply
    // rust: .get("options")
    // rust: .and_then(|o| match o {
    // rust: Value::Array(items) => items
    // rust: .iter()
    // rust: .find(|i| i.get("name").and_then(Value::as_str) == Some("--progress")),
    // rust: _ => None,
    // rust: })
    // rust: .expect("--progress is listed");
    // rust: assert_eq!(progress.get("value").and_then(Value::as_str), Some("json"));
}

    // One Launch API, one version: the client's and the preparer's move together.
the_client_speaks_the_same_version :: proc() {
}
    // rust: let client = include_str!("../../horizon-client/src/game/launch_api.rs");
    // rust: assert!(
    // rust: client.contains(&format!("pub const VERSION: &str = \"{VERSION}\";")),
    // rust: "horizon-client's Launch API version is not {VERSION}"
    // rust: );
}
}
