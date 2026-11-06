//! Transpiled from Horizon Rust crate
package horizon_client_studio

import "core:fmt"
import "core:mem"
import "core:math"

// Studio recording commands.

// use super::Game;
// use horizon_client::{
    // rust: Result,
    // rust: studio::{Metadata, generate_recording_filename},
    // rust: text::Text,
}
// use serde_json::{Value, json};
// use std::path::PathBuf;

    // rust: pub const HELP: &[&str] = &[
    // rust: "studio record start [NAME]     start recording clientbound packets into an .mcpr archive",
    // rust: "studio record stop             stop recording and finalize the archive",
    // rust: "studio record status           show recording elapsed time, packets, and size",
    // rust: ];

studio_recording_metadata :: proc(is_singleplayer: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let server_name = if is_singleplayer {
    // rust: "Singleplayer World"
    // rust: } else {
    // rust: "Multiplayer Server"
}
    // rust: Metadata::new(
    // rust: server_name.into(),
    // rust: is_singleplayer,
    // rust: horizon_core::release::VERSION.into(),
    // rust: )
}

    // rust: impl Game<'_> {
    // Handles Horizon's `/studio record` command without intercepting server
    // commands that merely share its prefix.
    // rust: pub(super) fn studio_command(&mut self, command: &str) -> bool {
    // rust: let Some(rest) = command.strip_prefix("studio") else {
    // rust: return false;
}
    // rust: if !rest.is_empty() && !rest.starts_with(char::is_whitespace) {
    // rust: return false;
}
    // rust: let words: Vec<&str> = rest.split_whitespace().collect();
    // rust: if words.first().copied() != Some("record") {
    // rust: self.system_message(Text::translate("horizon.studio.record.usage", &[]));
    // rust: return true;
}

    // rust: match words.get(1).copied() {
    // rust: Some("start") => match self.start_studio_recording(words.get(2).copied()) {
    // rust: Ok(v) if v["ok"].as_bool() == Some(true) => {
    // rust: let path = v["path"].as_str().unwrap_or_default();
    // rust: self.system_message(Text::tr("horizon.studio.record.started", &[&path]));
}
    // rust: Ok(v) => {
    // rust: let error = v["error"].as_str().unwrap_or_default();
    // rust: self.system_message(Text::tr("horizon.studio.record.error", &[&error]));
}
    // rust: Err(error) => {
    // rust: self.system_message(Text::tr("horizon.studio.record.error", &[&error]));
}
    // rust: },
    // rust: Some("stop") => match self.stop_studio_recording() {
    // rust: Ok(v) if v["ok"].as_bool() == Some(true) => {
    // rust: let path = v["path"].as_str().unwrap_or_default();
    // rust: self.system_message(Text::tr("horizon.studio.record.saved", &[&path]));
}
    // rust: Ok(v) => {
    // rust: let error = v["error"].as_str().unwrap_or_default();
    // rust: self.system_message(Text::tr("horizon.studio.record.error", &[&error]));
}
    // rust: Err(error) => {
    // rust: self.system_message(Text::tr("horizon.studio.record.error", &[&error]));
}
    // rust: },
    // rust: Some("status") => {
    // rust: let status = self.studio_recording_status();
    // rust: if status["active"].as_bool() == Some(true) {
    // rust: let elapsed = (status["elapsed_ms"].as_u64().unwrap_or(0) / 1000).to_string();
    // rust: let packets = status["packet_count"].as_u64().unwrap_or(0).to_string();
    // rust: let size = (status["bytes_written"].as_u64().unwrap_or(0) / 1024).to_string();
    // rust: let path = status["path"].as_str().unwrap_or_default();
    // rust: self.system_message(Text::tr(
    // rust: "horizon.studio.record.status.active",
    // rust: &[&elapsed, &packets, &size, &path],
    // rust: ));
    // rust: } else if let Some(error) = status["error"].as_str() {
    // rust: self.system_message(Text::tr("horizon.studio.record.error", &[&error]));
    // rust: } else {
    // rust: self.system_message(Text::translate(
    // rust: "horizon.studio.record.status.inactive",
    // rust: &[],
    // rust: ));
}
}
    // rust: _ => self.system_message(Text::translate("horizon.studio.record.usage", &[])),
}
    // rust: true
}

    // Control socket command handler for `studio record`.
    // rust: pub(super) fn studio_control(&mut self, words: &[&str]) -> Result<Option<Value>> {
    // rust: if words.first().copied() != Some("studio") {
    // rust: return Ok(None);
}
    // rust: let value = match words.get(1).copied() {
    // rust: Some("record") => match words.get(2).copied() {
    // rust: Some("start") => self.start_studio_recording(words.get(3).copied())?,
    // rust: Some("stop") => self.stop_studio_recording()?,
    // rust: Some("status") => self.studio_recording_status(),
    // rust: _ => json!({ "error": "unknown studio record subcommand" }),
    // rust: },
    // rust: _ => json!({ "error": "unknown studio command" }),
}
    // rust: Ok(Some(value))
}

    // rust: pub(super) fn start_studio_recording(&mut self, name: Option<&str>) -> Result<Value> {
    // rust: let Some(remote) = self.remote.as_ref() else {
    // rust: return Ok(json!({ "ok": false, "error": "no active world session" }));
}
    // rust: if remote.session.is_recording() {
    // rust: return Ok(json!({ "ok": false, "error": "recording already active" }));
}
    // rust: let recordings = PathBuf::from("recordings");
    // rust: std::fs::create_dir_all(&recordings)?;
    // rust: let path = recordings.join(generate_recording_filename(name));
    // rust: let is_singleplayer =
    // rust: remote.session.address.is_empty() || remote.session.address == "local";
    // rust: let metadata = studio_recording_metadata(is_singleplayer);
    // rust: match remote.session.start_recording(&path, metadata) {
    // rust: Ok(()) => Ok(json!({ "ok": true, "path": path.display().to_string() })),
    // rust: Err(error) => Ok(json!({ "ok": false, "error": error.to_string() })),
}
}

    // rust: pub(super) fn stop_studio_recording(&mut self) -> Result<Value> {
    // rust: let Some(remote) = self.remote.as_ref() else {
    // rust: return Ok(json!({ "ok": false, "error": "no active world session" }));
}
    // rust: match remote.session.stop_recording() {
    // rust: Some(Ok(path)) => Ok(json!({ "ok": true, "path": path.display().to_string() })),
    // rust: Some(Err(error)) => Ok(json!({ "ok": false, "error": error.to_string() })),
    // rust: None => Ok(json!({ "ok": false, "error": "no active recording" })),
}
}

    // rust: pub(super) fn studio_recording_status(&self) -> Value {
    // rust: if let Some(remote) = self.remote.as_ref()
    // rust: && let Some(status) = remote.session.recorder_status()
    // rust: {
    // rust: json!({
    // rust: "ok": true,
    // rust: "active": status.active,
    // rust: "path": status.path.display().to_string(),
    // rust: "elapsed_ms": status.elapsed.as_millis(),
    // rust: "packet_count": status.packet_count,
    // rust: "bytes_written": status.bytes_written,
    // rust: "error": status.error,
    // rust: })
    // rust: } else {
    // rust: json!({ "ok": true, "active": false, "error": null })
}
}
}

    // rust: mod tests {
//     use super::studio_recording_metadata;

recording_metadata_does_not_store_server_addresses_or_player_names :: proc() {
}
    // rust: let multiplayer = studio_recording_metadata(false);
    // rust: assert_eq!(multiplayer.server_name, "Multiplayer Server");
    // rust: assert!(multiplayer.players.is_empty());

    // rust: let singleplayer = studio_recording_metadata(true);
    // rust: assert_eq!(singleplayer.server_name, "Singleplayer World");
    // rust: assert!(singleplayer.players.is_empty());
}
}
