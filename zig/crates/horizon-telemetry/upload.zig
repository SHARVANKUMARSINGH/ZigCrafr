//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_upload
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sends the outbox, from the launcher at start and exit. Before anything else it reads the
//! consent again and deletes what the player no longer allows, so with everything off it
//! returns without opening a connection. Failures back off (a minute, doubling, at most a day)
//! and at most [`MAX_BATCHES_A_DAY`] batches leave a day.
// use std::path::{Path, PathBuf};
// use std::time::Duration;

// use serde::{Deserialize, Serialize};

// use crate::batch::{self, Batch};
// use crate::{Consent, outbox};

pub const MAX_BATCHES_A_DAY: u32 = 8;
pub const TIMEOUT: Duration = Duration::from_secs(10);

pub const Flush = enum {
    /// Nothing to send, or nothing allowed: no connection was made.
    Nothing,
    /// Waiting after a failure, or for tomorrow's allowance.
    Later,
    Sent {,
    items: usize,
    batches: usize,
    // rust: },
    /// The server could not be reached or failed; tried again later.
    Failed(String),
};

/// The uploader's own state, beside the consent.
pub const State = struct {
    day: u32,
    batches: u32,
    failures: u32,
    retry_at: u64,
};

pub fn state_path(home: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::dir(home).join("upload.json")
}

pub fn load(home: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read(state_path(home))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .unwrap_or_default()
}

pub fn save(home: *Path, state: *State) void {
}
    // rust: if let Ok(json) = serde_json::to_vec(state) {
    // rust: let _ = crate::write_atomic(&state_path(home), &json);
}
}

pub fn agent() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ureq::AgentBuilder::new().timeout(TIMEOUT).build()
}

/// Sends what the player allows to `endpoint` (`https://host`, without a trailing slash).
pub fn flush(home: *Path, endpoint: []const u8) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let consent = Consent::load(home);
    // What was turned off since it was kept never leaves.
    // rust: let allowed = outbox::retain_allowed(home);
    // rust: if allowed.is_empty() {
    // rust: return Flush::Nothing;
}
    // rust: let mut state = load(home);
    // rust: let today = crate::today();
    // rust: if state.day != today {
    // rust: state.day = today;
    // rust: state.batches = 0;
}
    // rust: if crate::now_secs() < state.retry_at || state.batches >= MAX_BATCHES_A_DAY {
    // rust: return Flush::Later;
}
    // rust: let agent = agent();
    // rust: let url = format!("{endpoint}/v1/batch");
    // rust: let (mut items, mut batches) = (0, 0);
    // rust: for group in batch::split(allowed) {
    // rust: if state.batches >= MAX_BATCHES_A_DAY {
    // rust: break;
}
    // rust: let (paths, list): (Vec<PathBuf>, Vec<crate::Item>) = group.into_iter().unzip();
    // rust: let body = batch::encode(&Batch::new(&consent.install_id, list));
    // rust: let sent = agent
    // rust: .post(&url)
    // rust: .set("Content-Type", "application/json")
    // rust: .set("Content-Encoding", "zstd")
    // rust: .send_bytes(&body);
    // rust: match sent {
    // rust: Ok(_) => {
    // rust: state.batches += 1;
    // rust: state.failures = 0;
    // rust: items += paths.len();
    // rust: batches += 1;
    // rust: paths.iter().for_each(|p| drop(std::fs::remove_file(p)));
}
            // Refused for what it is (not for load): sending it again would not help.
    // rust: Err(ureq::Error::Status(code, _)) if (400..500).contains(&code) && code != 429 => {
    // rust: state.batches += 1;
    // rust: paths.iter().for_each(|p| drop(std::fs::remove_file(p)));
}
    // rust: Err(e) => {
    // rust: state.failures = (state.failures + 1).min(16);
    // rust: state.retry_at = crate::now_secs() + (60u64 << (state.failures - 1)).min(86_400);
    // rust: save(home, &state);
    // rust: return Flush::Failed(e.to_string());
}
}
}
    // rust: save(home, &state);
    // rust: if batches == 0 {
    // rust: Flush::Later
    // rust: } else {
    // rust: Flush::Sent { items, batches }
}
}

/// Asks the server to delete everything sent under `install_id`.
pub fn delete_remote(endpoint: []const u8, install_id: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !crate::consent::is_install_id(install_id) {
    // rust: return Err("no install ID: nothing was sent".into());
}
    // rust: agent()
    // rust: .delete(&format!("{endpoint}/v1/installs/{install_id}"))
    // rust: .call()
    // rust: .map(|_| ())
    // rust: .map_err(|e| e.to_string())
}

/// The batch the next [`flush`] would send, as readable JSON ("View what would be sent").
pub fn preview(home: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let consent = Consent::load(home);
    // rust: let items = outbox::retain_allowed(home)
    // rust: .into_iter()
    // rust: .map(|(_, item)| item)
    // rust: .collect();
    // rust: serde_json::to_string_pretty(&Batch::new(&consent.install_id, items)).unwrap_or_default()
}
