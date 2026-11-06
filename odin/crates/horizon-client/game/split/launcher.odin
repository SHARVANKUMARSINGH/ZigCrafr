//! Transpiled from Horizon Rust crate
package horizon_client_launcher

import "core:fmt"
import "core:mem"
import "core:math"

// Microsoft sessions handed over by the launcher; offline split profiles belong to the instance.
// use horizon_client::auth::AuthSession;
// use std::sync::Arc;

// The launcher's other signed-in accounts (`HORIZON_ACCOUNT_SESSIONS`: name, uuid and a session
// file each), for splitscreen players to sign in with: read at start beside `--session-file`
// (`read_now`), as the files go when read and are refused once a couple of minutes old.
    // rust: pub(super) fn accounts() -> Vec<Arc<AuthSession>> {
    // rust: READ.get_or_init(read).0.clone()
}

READ :: std::sync::OnceLock::new()

    // rust: pub(super) fn unavailable() -> Vec<String> {
    // rust: READ.get_or_init(read).1.clone()
}

// Read (and so delete) the session files now, before the game loads.
    // rust: pub(in crate::game) fn read_now() {
    // rust: READ.get_or_init(read);
}

read :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(json) = std::env::var("HORIZON_ACCOUNT_SESSIONS") else {
    // rust: return Default::default();
}
    // rust: parse(&json)
}

parse :: proc(json: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let list: Vec<serde_json::Value> = serde_json::from_str(json).unwrap_or_default();
    // rust: let mut sessions = Vec::new();
    // rust: let mut unavailable = Vec::new();
    // rust: for a in list {
        // Every file listed is read (and so deleted) first, whatever else the entry says:
        // nothing with a token stays on disk.
    // rust: let session = a
    // rust: .get("file")
    // rust: .and_then(|v| v.as_str())
    // rust: .and_then(|file| AuthSession::load(std::path::Path::new(file)).ok());
    // rust: let Some(name) = a.get("name").and_then(|v| v.as_str()) else {
    // rust: continue;
}
    // rust: if !horizon_client::split_profiles::valid_name(name) {
    // rust: continue;
}
    // rust: match session {
    // rust: Some(session)
    // rust: if session.name.eq_ignore_ascii_case(name)
    // rust: && a.get("uuid")
    // rust: .and_then(|v| v.as_str())
    // rust: .and_then(horizon_client::auth::parse_uuid)
    // rust: == Some(session.uuid) =>
    // rust: {
    // rust: sessions.push(Arc::new(session))
}
    // rust: _ => {
                // Reasons are deliberately fixed text: never log session contents or tokens.
    // rust: log::warn!(
    // rust: "Horizon: splitscreen: {name} is offline; sign in again in the launcher."
    // rust: );
    // rust: unavailable.push(name.to_owned());
}
}
}
    // rust: (sessions, unavailable)
}

    // rust: mod tests {
//     use super::*;

mismatched_account_sessions_are_consumed_and_refused :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-split-account-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let file = dir.join("session.json");
    // rust: std::fs::write(&file, r#"{"name":"Ann","uuid":"00000000000000000000000000000001","access_token":"unused","user_type":"msa"}"#).unwrap();
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: std::fs::set_permissions(&file, std::fs::Permissions::from_mode(0o600)).unwrap();
}
    // rust: let json = serde_json::json!([{"name":"Ann", "uuid":"00000000000000000000000000000002", "file":file}]).to_string();
    // rust: let (sessions, unavailable) = parse(&json);
    // rust: assert!(sessions.is_empty());
    // rust: assert_eq!(unavailable, ["Ann"]);
    // rust: assert!(
    // rust: !file.exists(),
    // rust: "session files are read once even when mismatched"
    // rust: );
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

every_listed_session_file_is_consumed :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-split-consumed-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let file = |n: &str| {
    // rust: let file = dir.join(format!("session-{n}.json"));
    // rust: std::fs::write(&file, r#"{"name":"Bea","uuid":"00000000000000000000000000000002","access_token":"not-a-real-token","user_type":"msa"}"#).unwrap();
    // rust: {
//                 use std::os::unix::fs::PermissionsExt;
    // rust: std::fs::set_permissions(&file, std::fs::Permissions::from_mode(0o600)).unwrap();
}
    // rust: file
}
    // rust: let (bad_name, no_name, good) = (file("a"), file("b"), file("c"));
    // rust: let uuid = "00000000000000000000000000000002";
    // rust: let json = serde_json::json!([
    // rust: {"name": "not a name!", "uuid": uuid, "file": bad_name},
    // rust: {"uuid": uuid, "file": no_name},
    // rust: {"name": "Bea", "uuid": uuid, "file": good},
    // rust: ])
    // rust: .to_string();
    // rust: let (sessions, unavailable) = parse(&json);
    // rust: assert_eq!(sessions.len(), 1);
    // rust: assert_eq!((sessions[0].name.as_str(), sessions[0].uuid), ("Bea", 2));
    // rust: assert!(unavailable.is_empty());
    // rust: for f in [bad_name, no_name, good] {
    // rust: assert!(!f.exists(), "{} left on disk", f.display());
}
    // rust: std::fs::remove_dir_all(dir).unwrap();
}
}
