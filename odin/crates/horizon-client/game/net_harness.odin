//! Transpiled from Horizon Rust crate
package horizon_client_net_harness

import "core:fmt"
import "core:mem"
import "core:math"

// Headless multiplayer client for `tools/test_dedicated_server_parity.py`:
// with `--server` and `HORIZON_NET_REPORT` set, the client joins without a
// window, waits until it stands in the world with the chunks around it,
// sends a chat message and `/list` (or the lines of `HORIZON_NET_CHAT`,
// split by `;`, one at a time; `.delay N` sets Chat Delay instead, `.click COMMAND` runs a clicked command and
// `.answer yes` or `.answer no` answers what it asks), collects the chat it is shown, leaves and
// writes a JSON report (position, chunks, chat lines, whether it signed its
// chat, whether the server kept it connected throughout). With `HORIZON_NET_QUIET` (lines
// split by `;`) it then sends them as one batch of a mod's quiet commands
// (`horizon_protocol::quiet`, `tools/quiet_commands_e2e.py`) and waits two
// seconds for any chat they bring.
// use super::Game;
// use horizon_client::Result;
// use serde_json::json;
// use std::{
    // rust: path::Path,
    // rust: time::{Duration, Instant},
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn run_net_harness(&mut self, report: &Path) -> Result<()> {
    // rust: let deadline = Instant::now() + Duration::from_secs(120);
    // rust: let mut next = Instant::now();
    // rust: let mut spawned_at: Option<Instant> = None;
    // rust: let mut last_chunks = 0;
    // rust: let mut quiet_since = Instant::now();
    // rust: let mut step = 0;
    // rust: let mut step_at = Instant::now();
    // rust: let mut chat_at = 0;
    // rust: let mut position = None;
    // rust: let quiet: Vec<String> = std::env::var("HORIZON_NET_QUIET")
    // rust: .map(|v| v.split(';').map(str::to_owned).collect())
    // rust: .unwrap_or_default();
    // rust: let lines: Vec<String> = std::env::var("HORIZON_NET_CHAT")
    // rust: .map(|v| v.split(';').map(str::to_owned).collect())
    // rust: .unwrap_or_else(|_| vec!["hello from the horizon client".into(), "/list".into()]);
    // rust: let mut sent = 0;
    // rust: let mut prompts = Vec::new();
    // rust: let mut chat_box = None;
    // rust: let mut signed = false;
    // rust: let mut chunks = 0;
    // rust: let mut error = None;
    // rust: while Instant::now() < deadline {
    // rust: self.update_world();
    // rust: if self.remote.is_none() {
    // rust: error = Some(match self.title.as_ref().map(|t| &t.mode) {
    // rust: Some(horizon_client::title::Mode::Multiplayer(
    // rust: horizon_client::multiplayer::Screen::Disconnected { reason, .. },
    // rust: )) => format!("disconnected: {reason}"),
    // rust: _ => "disconnected".to_owned(),
    // rust: });
    // rust: break;
}
    // rust: if Instant::now() >= next {
    // rust: next += Duration::from_millis(50);
    // rust: self.tick()?;
                // Gui.tick: ChatListener.tick, which the frame runs in play.
    // rust: self.tick_chat_queue();
}
    // rust: let now = Instant::now();
    // rust: if let Some(p) = &self.player {
    // rust: spawned_at.get_or_insert(now);
    // rust: position.get_or_insert([p.position.x, p.position.y, p.position.z]);
}
    // rust: let count = self.world.chunks.len();
    // rust: if count != last_chunks {
    // rust: last_chunks = count;
    // rust: quiet_since = now;
}
            // Each step waits for what it sent to be answered (its chat line,
            // the /list reply), however busy the machine, up to 15 s.
    // rust: let shown = self.remote.as_ref().map_or(0, |r| r.chat.len());
    // rust: let answered = shown > chat_at
    // rust: || self.command_prompt.is_some()
    // rust: || now - step_at > Duration::from_secs(15);
    // rust: match step {
    // rust: 0 if spawned_at.is_some()
    // rust: && count > 0
    // rust: && now - quiet_since > Duration::from_secs(3) =>
    // rust: {
    // rust: chunks = count;
    // rust: signed = self.remote.as_ref().is_some_and(|r| r.secure_chat.signed());
    // rust: self.send_chat(&lines[0]);
    // rust: sent = 1;
    // rust: step = 2;
    // rust: step_at = now;
    // rust: chat_at = shown;
}
    // rust: 2 if answered && sent < lines.len() => {
    // rust: let line = &lines[sent];
    // rust: if let Some(delay) = line.strip_prefix(".delay ") {
    // rust: self.settings.chat_delay = delay.parse().unwrap_or(0.0);
    // rust: } else if let Some(command) = line.strip_prefix(".click ") {
    // rust: self.click_command(command);
    // rust: prompts.push(self.command_prompt_message());
    // rust: } else if let Some(answer) = line.strip_prefix(".answer ") {
    // rust: self.answer_command_prompt(answer == "yes");
    // rust: chat_box = self.ui.chat_screen.as_ref().map(|c| c.value().to_owned());
    // rust: } else {
    // rust: self.send_chat(line);
}
    // rust: sent += 1;
    // rust: step_at = now;
    // rust: chat_at = shown;
}
    // rust: 2 if answered && !quiet.is_empty() => {
    // rust: for data in horizon_protocol::quiet::encode("net_harness", &quiet) {
    // rust: self.send(horizon_protocol::packets::play::Serverbound::CustomPayload(
    // rust: horizon_protocol::packets::configuration::CustomPayload {
    // rust: channel: horizon_protocol::quiet::CHANNEL.into(),
    // rust: data,
    // rust: },
    // rust: ));
}
    // rust: step = 4;
    // rust: step_at = now;
}
    // rust: 4 if now - step_at > Duration::from_secs(2) => {
    // rust: step = 3;
    // rust: break;
}
    // rust: 2 if answered => {
    // rust: step = 3;
    // rust: break;
}
    // rust: _ => {}
}
    // rust: std::thread::sleep(Duration::from_millis(5));
}
    // rust: if step < 3 && error.is_none() {
    // rust: error = Some(format!("timed out at step {step}"));
}
    // rust: let chat: Vec<String> = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map(|r| r.chat.iter().map(|(t, _)| t.clone()).collect())
    // rust: .unwrap_or_default();
    // rust: if self.remote.is_some() {
    // rust: self.leave_server(None)?;
}
    // rust: std::fs::write(
    // rust: report,
    // rust: json!({
    // rust: "position": position,
    // rust: "chunks": chunks,
    // rust: "chat": chat,
    // rust: "signed": signed,
    // rust: "prompts": prompts,
    // rust: "chat_box": chat_box,
    // rust: "error": error,
    // rust: })
    // rust: .to_string(),
    // rust: )?;
    // rust: Ok(())
}
}
