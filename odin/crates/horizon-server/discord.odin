//! Transpiled from Horizon Rust crate
package horizon_server_discord

import "core:fmt"
import "core:mem"
import "core:math"

// `[discord]`: the server's chat, joins, leaves and deaths posted to a Discord channel through a webhook
// (docs/hosting.md). Only outgoing HTTPS to Discord; nothing listens. Lines are batched for 2 s, drawn as
// one picture of the in-game chat's text (Pixelify Sans, SIL OFL, from horizon-theme: no Mojang asset), and
// posted at most every 2 s. Nothing posted can ping: `allowed_mentions` is empty and every `@` is defused.

// use crate::api::Shared;
// use ab_glyph::{Font, FontRef, PxScale, ScaleFont, point};
// use serde::{Deserialize, Serialize};
// use serde_json::{Value, json};
// use std::{
    // rust: collections::HashMap,
    // rust: sync::Arc,
    // rust: thread,
    // rust: time::{Duration, Instant},
}

// Lines wait this long for others to join their picture.
BATCH :: Duration::from_secs(2)
// The least time between two posts.
GAP :: Duration::from_secs(2)
// Lines in one picture; more in a burst are counted and skipped.
MAX_LINES :: 20
EVENTS :: ["chat", "join", "leave", "death", "kick", "announce"]
// Zero-width joiner: after an `@` or a `<`, Discord no longer reads a mention.
ZWJ :: '\u{200D}'

// The `[discord]` table of server.toml.
Settings :: struct {
    enabled: bool,
    webhook: string,
    events: [dynamic]string,
}

    // rust: impl Default for Settings {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: enabled: true,
    // rust: webhook: String::new(),
    // rust: events: ["chat", "join", "leave", "death"].map(String::from).into(),
}
}
}

    // rust: impl Settings {
check :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let hook = self.webhook.trim();
    // rust: let discord = [
    // rust: "discord.com",
    // rust: "discordapp.com",
    // rust: "ptb.discord.com",
    // rust: "canary.discord.com",
    // rust: ];
    // rust: if !hook.is_empty()
    // rust: && !discord.iter().any(|host| {
    // rust: hook.strip_prefix("https://")
    // rust: .and_then(|h| h.strip_prefix(host))
    // rust: .is_some_and(|path| path.starts_with("/api/webhooks/"))
    // rust: })
    // rust: {
    // rust: return Err("discord.webhook must be a Discord webhook URL (https://discord.com/api/webhooks/...)".into());
}
    // rust: match self.events.iter().find(|e| !EVENTS.contains(&e.as_str())) {
    // rust: Some(e) => Err(format!(
    // rust: "discord.events has \"{e}\": use {}",
    // rust: EVENTS.join(", ")
    // rust: )),
    // rust: None => Ok(()),
}
}
}

// Starts the forwarder when `[discord]` has a webhook and is enabled.
start :: proc(shared: ^Shared, settings: Settings) {
}
    // rust: if !settings.enabled || settings.webhook.trim().is_empty() {
    // rust: return;
}
    // rust: let _ = thread::Builder::new()
    // rust: .name("discord".into())
    // rust: .spawn(move || forward(&shared, &settings));
}

forward :: proc(shared: ^Shared, settings: ^Settings) {
}
    // rust: let wanted = |kind: &str| settings.events.iter().any(|e| e == kind);
    // rust: let agent = ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(20))
    // rust: .user_agent(concat!("horizon-server/", env!("CARGO_PKG_VERSION")))
    // rust: .build();
    // rust: let font = FontRef::try_from_slice(FONT).expect("the bundled font parses");
    // rust: let mut glyphs = HashMap::new();
    // rust: let mut cursor = shared.events.lock().unwrap().after(u64::MAX, &wanted).0;
    // rust: let (mut pending, mut skipped, mut since) = (Vec::new(), 0, None::<Instant>);
    // rust: let mut limiter = Limiter::default();
    // rust: loop {
    // rust: let fresh = {
    // rust: let events = shared.events.lock().unwrap();
    // rust: let events = shared
    // rust: .event_added
    // rust: .wait_timeout(events, Duration::from_millis(500))
    // rust: .unwrap()
    // rust: .0;
    // rust: let (last, fresh) = events.after(cursor, &wanted);
    // rust: cursor = last;
    // rust: fresh
}
    // rust: for line in fresh.iter().filter_map(Line::from_event) {
    // rust: since.get_or_insert_with(Instant::now);
    // rust: if pending.len() < MAX_LINES {
    // rust: pending.push(line);
    // rust: } else {
    // rust: skipped += 1;
}
}
    // rust: let now = Instant::now();
    // rust: if since.is_none_or(|t| now < t + BATCH) || !limiter.ready(now) {
    // rust: continue;
}
    // rust: if skipped > 0 {
    // rust: pending.push(Line::note(&format!("({skipped} more lines skipped)")));
}
    // rust: match post(
    // rust: &agent,
    // rust: settings.webhook.trim(),
    // rust: &pending,
    // rust: &font,
    // rust: &mut glyphs,
    // rust: &mut limiter,
    // rust: ) {
    // rust: Ok(()) => {}
    // rust: Err(Failure::Gone(code)) => {
    // rust: return crate::supervisor::note(
    // rust: shared,
    // rust: "WARN",
    // rust: &format!("Discord: the webhook answered {code}; posting stops until a restart"),
    // rust: );
}
    // rust: Err(Failure::Other(e)) => {
    // rust: crate::supervisor::note(shared, "WARN", &format!("Discord: {e}"))
}
}
    // rust: (pending, skipped, since) = (Vec::new(), 0, None);
}
}

// One line of chat: coloured runs.
Line :: struct {
    runs: [dynamic]Run,
}

Run :: struct {
    text: string,
    color: u32,
    bold: bool,
}

WHITE :: 0xFFFFFF
YELLOW :: 0xFFFF55
GRAY :: 0xAAAAAA
GOLD :: 0xFFAA00
// ChatFormatting's colours, by their code `0`-`f`.
    // rust: const PALETTE: [u32; 16] = [
    // rust: 0x000000, 0x0000AA, 0x00AA00, 0x00AAAA, 0xAA0000, 0xAA00AA, 0xFFAA00, 0xAAAAAA, 0x555555,
    // rust: 0x5555FF, 0x55FF55, 0x55FFFF, 0xFF5555, 0xFF55FF, 0xFFFF55, 0xFFFFFF,
    // rust: ];

    // rust: impl Line {
from_event :: proc(event: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = event["name"].as_str()?.to_owned();
    // rust: let text = |s: &str| event[s].as_str().unwrap_or_default();
    // rust: let runs = match event["type"].as_str()? {
    // rust: "chat" => std::iter::once(Run::plain(&format!("<{name}> "), WHITE))
    // rust: .chain(legacy(text("message"), WHITE))
    // rust: .collect(),
    // rust: "join" => vec![Run::plain(&format!("{name} joined the game"), YELLOW)],
    // rust: "leave" => vec![Run::plain(&format!("{name} left the game"), YELLOW)],
    // rust: "kick" => vec![Run::plain(&format!("{name} was kicked"), YELLOW)],
            // A line a native server mod posts (`native_server_event`), drawn like a broadcast.
    // rust: "announce" => legacy(text("message"), GOLD),
            // The game writes this message itself: should a nickname stand for the player there, the real name
            // follows it. Lines say who someone is only by `name` (their account), never by a nickname.
    // rust: "death" if !text("message").contains(name.as_str()) => {
    // rust: legacy(&format!("{} ({name})", text("message")), WHITE)
}
    // rust: "death" => legacy(text("message"), WHITE),
    // rust: _ => return None,
}
    // rust: Some(Self { runs })
}

note :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: runs: vec![Run::plain(text, GRAY)],
}
}

plain :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.runs.iter().map(|r| r.text.as_str()).collect()
}
}

    // rust: impl Run {
plain :: proc(text: string, color: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: text: text.into(),
    // rust: color,
    // rust: bold: false,
}
}
}

// Text with `§` formatting codes, as coloured runs: a colour resets bold, `§r` goes back to `base`.
legacy :: proc(text: string, base: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut runs = vec![Run::plain("", base)];
    // rust: let mut chars = text.chars();
    // rust: while let Some(c) = chars.next() {
    // rust: if c != '§' {
    // rust: runs.last_mut().unwrap().text.push(c);
    // rust: continue;
}
    // rust: let last = runs.last().map_or(base, |r| r.color);
    // rust: let (color, bold) = match chars.next().map(|c| c.to_ascii_lowercase()) {
    // rust: Some(code @ ('0'..='9' | 'a'..='f')) => {
    // rust: (PALETTE[code.to_digit(16).unwrap() as usize], false)
}
    // rust: Some('l') => (last, true),
    // rust: Some('r') => (base, false),
    // rust: _ => continue,
}
    // rust: runs.push(Run {
    // rust: text: String::new(),
    // rust: color,
    // rust: bold,
    // rust: });
}
    // rust: runs.retain(|r| !r.text.is_empty());
    // rust: runs
}

// Text that can't mention anyone (`@everyone`, `@here`, `<@id>`, `<@&id>`, `<#id>`), and with `markdown`
// shows as it is.
defuse :: proc(text: string, markdown: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len() + 8);
    // rust: let mut chars = text.chars().peekable();
    // rust: while let Some(c) = chars.next() {
    // rust: if markdown && "\\*_~`|>#-[]()".contains(c) {
    // rust: out.push('\\');
}
    // rust: out.push(c);
    // rust: if c == '@' || (c == '<' && matches!(chars.peek(), Some('@' | '#' | ':' | '/'))) {
    // rust: out.push(ZWJ);
}
}
    // rust: out
}

// At most one post every `GAP`, later when Discord says so.
Limiter :: struct {
    next: Maybe(Instant),
}

    // rust: impl Limiter {
ready :: proc(self: ^Self, now: Instant) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.next.is_none_or(|t| now >= t)
}

posted :: proc(self: ^Self, now: Instant, wait: Duration) {
}
    // rust: self.next = Some(now + wait.max(GAP));
}
}

Failure :: enum {
    // The webhook is deleted or its token wrong: posting again won't help.
    Gone(u16),
    Other(String),
}

// The webhook's JSON: never a mention, the lines as the picture's alt text or as the message itself.
payload :: proc(lines: ^[Line], picture: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let alt: String = lines.iter().map(Line::plain).collect::<Vec<_>>().join("\n");
    // rust: let mut payload = json!({ "allowed_mentions": { "parse": [] } });
    // Every post comes from the webhook's own name and avatar (one identity for the server), never a player's.
    // Discord's limits: 1024 characters of alt text, 2000 of message.
    // rust: if picture {
    // rust: let alt = truncate(&defuse(&alt, false), 1000);
    // rust: payload["attachments"] = json!([{ "id": 0, "filename": "chat.png", "description": alt }]);
    // rust: } else {
    // rust: payload["content"] = truncate(&defuse(&alt, true), 1900).into();
}
    // rust: payload
}

// Posts the lines as a picture, or as plain text when drawing fails; waits out a 429 (three times at most).
    // rust: fn post(
    // rust: agent: &ureq::Agent,
    // rust: webhook: &str,
    // rust: lines: &[Line],
    // rust: font: &FontRef,
    // rust: glyphs: &mut HashMap<char, Glyph>,
    // rust: limiter: &mut Limiter,
    // rust: ) -> Result<(), Failure> {
    // rust: let picture = render(lines, font, glyphs);
    // rust: let payload = payload(lines, picture.is_some());
    // rust: let (content_type, body) = match &picture {
    // rust: Some(png) => {
    // rust: let boundary = "horizon-discord-bridge-7f3a9c";
    // rust: let part = |headers: &str| {
    // rust: format!("--{boundary}\r\nContent-Disposition: form-data; {headers}\r\n\r\n")
}
    // rust: let mut body =
    // rust: part("name=\"payload_json\"\r\nContent-Type: application/json").into_bytes();
    // rust: body.extend_from_slice(format!("{payload}\r\n").as_bytes());
    // rust: body.extend_from_slice(
    // rust: part("name=\"files[0]\"; filename=\"chat.png\"\r\nContent-Type: image/png")
    // rust: .as_bytes(),
    // rust: );
    // rust: body.extend_from_slice(png);
    // rust: body.extend_from_slice(format!("\r\n--{boundary}--\r\n").as_bytes());
    // rust: (format!("multipart/form-data; boundary={boundary}"), body)
}
    // rust: None => ("application/json".into(), payload.to_string().into_bytes()),
}
    // rust: for _ in 0..3 {
    // rust: let sent = agent
    // rust: .post(webhook)
    // rust: .set("Content-Type", &content_type)
    // rust: .send_bytes(&body);
    // rust: let now = Instant::now();
        // Errors never say the URL: it holds the webhook's token.
    // rust: let response = match sent {
    // rust: Ok(response) => response,
    // rust: Err(ureq::Error::Status(429, response)) => {
    // rust: let wait = retry_after(response);
    // rust: limiter.posted(now, wait);
    // rust: thread::sleep(wait.max(GAP));
    // rust: continue;
}
    // rust: Err(ureq::Error::Status(code @ (401 | 403 | 404), _)) => {
    // rust: return Err(Failure::Gone(code));
}
    // rust: Err(ureq::Error::Status(code, _)) => {
    // rust: limiter.posted(now, GAP);
    // rust: return Err(Failure::Other(format!("the webhook answered {code}")));
}
    // rust: Err(ureq::Error::Transport(t)) => {
    // rust: limiter.posted(now, GAP * 5);
    // rust: return Err(Failure::Other(format!(
    // rust: "Discord can't be reached ({})",
    // rust: t.kind()
    // rust: )));
}
}
    // rust: let wait = match response.header("x-ratelimit-remaining") {
    // rust: Some("0") => secs(response.header("x-ratelimit-reset-after")),
    // rust: _ => GAP,
}
    // rust: limiter.posted(now, wait);
    // rust: return Ok(());
}
    // rust: Err(Failure::Other(
    // rust: "rate limited three times; these lines are dropped".into(),
    // rust: ))
}

// A 429's wait: `retry_after` in the JSON body, else the header; 60 s at most.
retry_after :: proc(response: ureq::Response) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let header = response.header("retry-after").map(str::to_owned);
    // rust: let body: Value = response
    // rust: .into_string()
    // rust: .ok()
    // rust: .and_then(|t| serde_json::from_str(&t).ok())
    // rust: .unwrap_or_default();
    // rust: match body["retry_after"].as_f64() {
    // rust: Some(s) => Duration::from_secs_f64(s.clamp(0.0, 60.0)),
    // rust: None => secs(header.as_deref()),
}
}

secs :: proc(value: Maybe(string)) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let s = value
    // rust: .and_then(|v| v.trim().parse::<f64>().ok())
    // rust: .unwrap_or(2.0);
    // rust: Duration::from_secs_f64(s.clamp(0.0, 60.0))
}

truncate :: proc(text: string, max: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match text.char_indices().nth(max) {
    // rust: Some((at, _)) => format!("{}…", &text[..at]),
    // rust: None => text.to_owned(),
}
}

// Drawing, in the picture's pixels: `U` per pixel of the game's GUI (GUI scale 2, like a 1080p window).
FONT :: include_bytes!("../../horizon-theme/fonts/PixelifySans-Medium.ttf")
U :: 2
// Font units per pixel of Pixelify Sans's grid, which starts 60 units right of the origin and 12 below the
// baseline. Drawn at `U` picture pixels per grid square, so its half-square accents keep their shape.
GRID :: 89.2
FONT_PX :: U  * 1000.0 / GRID
// Room for accents above capitals (vanilla squeezes them into 9 pixels).
LINE_H :: 12 * U
BASELINE :: (10 * U) 
PAD :: 2 * U
// Vanilla's default chat width.
WIDTH :: 320 * U

Glyph :: struct {
    advance: uint,
    pixels: Vec<(uint,
}

    // rust: fn glyph<'a>(font: &FontRef, glyphs: &'a mut HashMap<char, Glyph>, c: char) -> &'a Glyph {
    // rust: glyphs.entry(c).or_insert_with(|| {
    // rust: let id = font.glyph_id(c);
    // rust: let advance = font.as_scaled(PxScale::from(FONT_PX)).h_advance(id).round() as usize;
    // rust: let mut pixels = Vec::new();
    // rust: if let Some(outline) = font.outline_glyph(id.with_scale_and_position(
    // rust: FONT_PX,
    // rust: point(
    // rust: U as f32 * (1.0 - 60.0 / GRID),
    // rust: BASELINE - U as f32 * 12.0 / GRID,
    // rust: ),
    // rust: )) {
    // rust: let at = outline.px_bounds().min;
    // rust: outline.draw(|x, y, coverage| {
    // rust: let (x, y) = (at.x as i32 + x as i32, at.y as i32 + y as i32);
    // rust: if coverage >= 0.5 && x >= 0 && (0..LINE_H as i32).contains(&y) {
    // rust: pixels.push((x as usize, y as usize));
}
    // rust: });
}
    // rust: Glyph {
    // rust: advance: advance.max(1),
    // rust: pixels,
}
    // rust: })
}

// The lines as an RGBA PNG on a transparent ground: wrapped at the chat's width, each glyph over its shadow.
render :: proc(lines: ^[Line], font: ^FontRef, glyphs: ^HashMap<char) -> O {
    // Ported from Horizon
    return {}
}
    // Wrap into rows of (char, colour, bold, x), breaking at the last space when one fits.
    // rust: let mut rows: Vec<Vec<(char, u32, bool, usize)>> = Vec::new();
    // rust: for line in lines {
    // rust: let mut row = Vec::new();
    // rust: let mut x = 0;
    // rust: for run in &line.runs {
    // rust: for c in run.text.chars().filter(|c| !c.is_control()) {
    // rust: let advance = glyph(font, glyphs, c).advance + U * usize::from(run.bold);
    // rust: if x + advance > WIDTH && !row.is_empty() {
    // rust: let cut = row
    // rust: .iter()
    // rust: .rposition(|g: &(char, u32, bool, usize)| g.0 == ' ')
    // rust: .map_or(row.len(), |i| i + 1);
    // rust: let rest: Vec<_> = row.split_off(cut);
    // rust: rows.push(std::mem::take(&mut row));
    // rust: let shift = rest.first().map_or(0, |g| g.3);
    // rust: row = rest
    // rust: .into_iter()
    // rust: .map(|(c, k, b, gx)| (c, k, b, gx - shift))
    // rust: .collect();
    // rust: x = row.last().map_or(0, |g| {
    // rust: g.3 + glyph(font, glyphs, g.0).advance + U * usize::from(g.2)
    // rust: });
}
    // rust: row.push((c, run.color, run.bold, x));
    // rust: x += advance;
}
}
    // rust: rows.push(row);
}
    // rust: let used = rows
    // rust: .iter()
    // rust: .filter_map(|r| {
    // rust: r.last()
    // rust: .map(|g| g.3 + glyph(font, glyphs, g.0).advance + 2 * U)
    // rust: })
    // rust: .max()
    // rust: .unwrap_or(1);
    // rust: let (w, h) = (used + 2 * PAD, rows.len() * LINE_H + 2 * PAD);
    // Transparent: the glyphs' shadows keep them readable on Discord's light and dark themes.
    // rust: let mut rgba = vec![0; w * h * 4];
    // rust: for (r, row) in rows.iter().enumerate() {
    // rust: for &(c, color, bold, gx) in row {
    // rust: let shadow = (color & 0xFC_FC_FC) >> 2;
    // rust: for (offset, k) in [(U, shadow), (0, color)] {
    // rust: for &(px, py) in &glyph(font, glyphs, c).pixels {
    // rust: for b in 0..=usize::from(bold) {
    // rust: let (x, y) = (
    // rust: PAD + gx + px + offset + b * U,
    // rust: PAD + r * LINE_H + py + offset,
    // rust: );
    // rust: if let Some(p) = rgba.get_mut((y * w + x) * 4..(y * w + x) * 4 + 4) {
    // rust: p.copy_from_slice(&[(k >> 16) as u8, (k >> 8) as u8, k as u8, 255]);
}
}
}
}
}
}
    // rust: let mut png = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut png, w as u32, h as u32);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder.write_header().ok()?.write_image_data(&rgba).ok()?;
    // rust: Some(png)
}

    // rust: mod tests {
//     use super::*;

nothing_posted_can_ping :: proc() {
}
    // rust: for (input, banned) in [
    // rust: ("@everyone look", "@everyone"),
    // rust: ("hey @here", "@here"),
    // rust: ("<@123456789>", "<@1"),
    // rust: ("<@&42> role", "<@&"),
    // rust: ("<#99> chan", "<#9"),
    // rust: ] {
    // rust: let out = defuse(input, true);
    // rust: assert!(!defuse(input, false).contains(banned));
    // rust: assert!(!out.contains(banned), "{input} -> {out}");
    // rust: assert!(out.contains(ZWJ));
}
    // rust: assert_eq!(defuse("**bold** _x_", true), "\\*\\*bold\\*\\* \\_x\\_");
    // rust: assert_eq!(defuse("**bold**", false), "**bold**");
        // The webhook body asks Discord to parse no mention at all, picture or plain text.
    // rust: let line = Line::from_event(
    // rust: &json!({"type": "chat", "name": "Kim0", "uuid": "1", "message": "@everyone"}),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(line.plain(), "<Kim0> @everyone");
    // rust: assert!(!defuse(&line.plain(), false).contains("@everyone"));
    // rust: for picture in [true, false] {
    // rust: let p = payload(std::slice::from_ref(&line), picture).to_string();
    // rust: assert!(p.contains(r#""allowed_mentions":{"parse":[]}"#), "{p}");
    // rust: assert!(!p.contains("@everyone") && p.contains("Kim0"), "{p}");
}
}

an_announcement_is_its_message_in_gold_and_cannot_ping :: proc() {
}
    // rust: let line = Line::from_event(
    // rust: &json!({"type": "announce", "name": "", "message": "Jackpot! @everyone"}),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(line.plain(), "Jackpot! @everyone");
    // rust: assert!(line.runs.iter().all(|r| r.color == GOLD));
    // rust: assert!(!defuse(&line.plain(), false).contains("@everyone"));
    // rust: assert!(
    // rust: Settings {
    // rust: events: vec!["announce".into()],
    // rust: ..Settings::default()
}
    // rust: .check()
    // rust: .is_ok()
    // rust: );
}

section_codes_colour_the_runs :: proc() {
}
    // rust: let runs = legacy("a§cred§lbold§rplain§9blue§zx", WHITE);
    // rust: let got: Vec<_> = runs
    // rust: .iter()
    // rust: .map(|r| (r.text.as_str(), r.color, r.bold))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: got,
    // rust: [
    // rust: ("a", WHITE, false),
    // rust: ("red", 0xFF5555, false),
    // rust: ("bold", 0xFF5555, true),
    // rust: ("plain", WHITE, false),
    // rust: ("bluex", 0x5555FF, false)
    // rust: ]
    // rust: );
    // rust: let join =
    // rust: Line::from_event(&json!({"type": "join", "name": "Kim0", "address": "10.0.0.1"}))
    // rust: .unwrap();
    // rust: assert_eq!(join.runs[0].color, YELLOW);
    // rust: assert!(
    // rust: !join.plain().contains("10.0.0.1"),
    // rust: "never a player's address"
    // rust: );
    // rust: assert!(Line::from_event(&json!({"type": "log", "line": "x"})).is_none());
        // A nickname never stands in for the account's name.
    // rust: let nicked = json!({"type": "chat", "name": "Kim0", "display_name": "Bob", "nick": "Bob", "message": "hi"});
    // rust: assert_eq!(Line::from_event(&nicked).unwrap().plain(), "<Kim0> hi");
    // rust: let death = |m: &str| {
    // rust: Line::from_event(&json!({"type": "death", "name": "Kim0", "message": m}))
    // rust: .unwrap()
    // rust: .plain()
}
    // rust: assert_eq!(
    // rust: death("Kim0 fell from a high place"),
    // rust: "Kim0 fell from a high place"
    // rust: );
    // rust: assert_eq!(
    // rust: death("Bob fell from a high place"),
    // rust: "Bob fell from a high place (Kim0)"
    // rust: );
        // A message the server's chat filter held back never reaches Discord, whatever the settings say.
    // rust: let filtered = json!({"type": "chat_filtered", "name": "Kim0", "message": "x"});
    // rust: assert!(Line::from_event(&filtered).is_none());
    // rust: let asked = Settings {
    // rust: events: vec!["chat_filtered".into()],
    // rust: ..Settings::default()
}
    // rust: assert!(asked.check().is_err());
}

the_picture_is_the_chat_box :: proc() {
}
    // rust: let font = FontRef::try_from_slice(FONT).unwrap();
    // rust: let mut glyphs = HashMap::new();
    // rust: let line = |m: &str| {
    // rust: Line::from_event(&json!({"type": "chat", "name": "Kim0", "message": m})).unwrap()
}
    // rust: let png = render(&[line("hi"), line("§ahello there")], &font, &mut glyphs).unwrap();
    // rust: let decoder = png::Decoder::new(std::io::Cursor::new(&png));
    // rust: let info = decoder.read_info().unwrap().info().clone();
    // rust: assert_eq!(info.height as usize, 2 * LINE_H + 2 * PAD);
    // rust: assert!(info.width as usize > 20 * U && (info.width as usize) < WIDTH + 2 * PAD + 2 * U);
        // A long message wraps at the chat's width instead of making a wider picture.
    // rust: let long = render(&[line(&"word ".repeat(80))], &font, &mut glyphs).unwrap();
    // rust: let info = png::Decoder::new(std::io::Cursor::new(&long))
    // rust: .read_info()
    // rust: .unwrap()
    // rust: .info()
    // rust: .clone();
    // rust: assert!(info.width as usize <= WIDTH + 2 * PAD + 2 * U);
    // rust: assert!(info.height as usize > 3 * LINE_H);
        // Glyphs are crisp pixels: an `l` is drawn, inside its line.
    // rust: assert!(!glyph(&font, &mut glyphs, 'l').pixels.is_empty());
}

one_post_per_gap_or_longer_when_told :: proc() {
}
    // rust: let mut limiter = Limiter::default();
    // rust: let now = Instant::now();
    // rust: assert!(limiter.ready(now));
    // rust: limiter.posted(now, Duration::ZERO);
    // rust: assert!(!limiter.ready(now + Duration::from_millis(1999)));
    // rust: assert!(limiter.ready(now + GAP));
    // rust: limiter.posted(now, Duration::from_secs(7));
    // rust: assert!(!limiter.ready(now + Duration::from_secs(6)));
    // rust: assert!(limiter.ready(now + Duration::from_secs(7)));
    // rust: assert_eq!(secs(Some("1.5")), Duration::from_millis(1500));
    // rust: assert_eq!(secs(Some("9999")), Duration::from_secs(60));
}

only_discord_webhooks :: proc() {
}
    // rust: let with = |hook: &str| {
    // rust: Settings {
    // rust: webhook: hook.into(),
    // rust: ..Settings::default()
}
    // rust: .check()
}
    // rust: assert!(with("").is_ok());
    // rust: assert!(with("https://discord.com/api/webhooks/1/abc").is_ok());
    // rust: assert!(with("http://discord.com/api/webhooks/1/abc").is_err());
    // rust: assert!(with("https://discord.com.evil.example/api/webhooks/1").is_err());
    // rust: assert!(with("https://example.com/api/webhooks/1").is_err());
    // rust: let bad = Settings {
    // rust: events: vec!["log".into()],
    // rust: ..Settings::default()
}
    // rust: assert!(bad.check().is_err());
}
}
