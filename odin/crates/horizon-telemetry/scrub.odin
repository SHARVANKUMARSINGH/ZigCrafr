//! Transpiled from Horizon Rust crate
package horizon_telemetry_scrub

import "core:fmt"
import "core:mem"
import "core:math"

// Takes out of text what could say who or where a player is, before it is kept to be sent:
// the user folder's name in paths, the user name, e-mail and IP addresses, UUIDs (accounts),
// and the terms the caller knows are private (world names, server addresses, account names).

// What replaces each kind of match.
USER :: "<user>"
EMAIL :: "<email>"
IP :: "<ip>"
UUID :: "<uuid>"
PRIVATE :: "<private>"

Scrubber :: struct {
    // Exact terms to hide, longest first.
    terms: [dynamic]string,
    user: Maybe(string),
}

    // rust: impl Scrubber {
    // A scrubber that also knows this machine's user name.
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let user = ["USER", "USERNAME", "LOGNAME"]
    // rust: .iter()
    // rust: .find_map(|k| std::env::var(k).ok().filter(|u| u.trim().len() >= 3));
    // rust: Self {
    // rust: terms: Vec::new(),
    // rust: user,
}
}

    // Without the machine's user name (tests).
bare :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::default()
}

with_user :: proc(user: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.user = Some(user.into()).filter(|u| u.trim().len() >= 3);
    // rust: self
}

    // Hides `term` wherever it appears. Terms under 3 characters are ignored: they would
    // blank out ordinary words.
term :: proc(term: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let term = term.into();
    // rust: if term.trim().len() >= 3 && !self.terms.contains(&term) {
    // rust: self.terms.push(term);
    // rust: self.terms.sort_by_key(|t| std::cmp::Reverse(t.len()));
}
    // rust: self
}

scrub :: proc(self: ^Self, text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = text.to_owned();
    // rust: for term in &self.terms {
    // rust: out = out.replace(term.as_str(), PRIVATE);
}
    // rust: out = user_folders(&out);
    // rust: out = replace_tokens(&out, email_at);
    // rust: out = replace_tokens(&out, ipv4_at);
    // rust: out = replace_tokens(&out, ipv6_at);
    // rust: out = replace_tokens(&out, uuid_at);
    // rust: if let Some(user) = &self.user {
    // rust: out = replace_word(&out, user, USER);
}
    // rust: out
}
}

// `/Users/ana/…`, `/home/ana/…`, `C:\Users\Ana Silva\…` (also JSON-escaped): the folder after
// `Users` or `home` becomes [`USER`], the rest of the path stays. Windows names have spaces, so
// the name runs to the next separator, quote, bracket or line end.
user_folders :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut rest = text;
    // rust: 'scan: while !rest.is_empty() {
    // rust: for parent in ["Users", "home"] {
    // rust: for sep in ["/", "\\\\", "\\"] {
    // rust: let head = format!("{sep}{parent}{sep}");
    // rust: if let Some(after) = rest.strip_prefix(head.as_str()) {
    // rust: let name_len = after
    // rust: .find(|c: char| {
    // rust: matches!(
    // rust: c,
    // rust: '/' | '\\' | '"' | '\'' | '\n' | '\r' | ')' | ']' | ',' | ';'
    // rust: )
    // rust: })
    // rust: .unwrap_or(after.len());
    // rust: out.push_str(&head);
    // rust: if name_len > 0 {
    // rust: out.push_str(USER);
}
    // rust: rest = &after[name_len..];
    // rust: continue 'scan;
}
}
}
    // rust: let c = rest.chars().next().unwrap_or_default();
    // rust: out.push(c);
    // rust: rest = &rest[c.len_utf8()..];
}
    // rust: out
}

// Replaces every match of `matcher` (which returns the length of a match starting at a byte
// offset, if one does) with its label.
    // rust: fn replace_tokens(
    // rust: text: &str,
    // rust: matcher: fn(&[u8], usize) -> Option<(usize, &'static str)>,
    // rust: ) -> String {
    // rust: let bytes = text.as_bytes();
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut i = 0;
    // rust: let mut copied = 0;
    // rust: while i < bytes.len() {
    // rust: if text.is_char_boundary(i)
    // rust: && let Some((len, label)) = matcher(bytes, i)
    // rust: {
    // rust: out.push_str(&text[copied..i]);
    // rust: out.push_str(label);
    // rust: i += len;
    // rust: copied = i;
    // rust: } else {
    // rust: i += 1;
}
}
    // rust: out.push_str(&text[copied..]);
    // rust: out
}

word_byte :: proc(b: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: b.is_ascii_alphanumeric() || b == b'_'
}

// Whether a token may start at `i`: not in the middle of a word, number or address.
starts_token :: proc(bytes: []u8, i: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: i == 0 || !(word_byte(bytes[i - 1]) || matches!(bytes[i - 1], b'.' | b':' | b'-' | b'@'))
}

ends_token :: proc(bytes: []u8, end: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: end == bytes.len() || !word_byte(bytes[end])
}

email_at :: proc(bytes: []u8, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let local = |b: u8| word_byte(b) || matches!(b, b'.' | b'%' | b'+' | b'-');
    // rust: if !starts_token(bytes, i) || !local(bytes[i]) {
    // rust: return None;
}
    // rust: let at = i + bytes[i..].iter().position(|&b| !local(b))?;
    // rust: if bytes.get(at) != Some(&b'@') {
    // rust: return None;
}
    // rust: let domain = |b: u8| b.is_ascii_alphanumeric() || matches!(b, b'.' | b'-');
    // rust: let end = at + 1 + bytes[at + 1..].iter().take_while(|&&b| domain(b)).count();
    // rust: let host = &bytes[at + 1..end];
    // rust: let dot = host.iter().rposition(|&b| b == b'.')?;
    // rust: (dot > 0 && host.len() - dot > 2).then_some((end - i, EMAIL))
}

ipv4_at :: proc(bytes: []u8, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !starts_token(bytes, i) {
    // rust: return None;
}
    // rust: let mut end = i;
    // rust: for part in 0..4 {
    // rust: if part > 0 {
    // rust: if bytes.get(end) != Some(&b'.') {
    // rust: return None;
}
    // rust: end += 1;
}
    // rust: let digits = bytes[end..]
    // rust: .iter()
    // rust: .take_while(|b| b.is_ascii_digit())
    // rust: .count();
    // rust: if digits == 0 || digits > 3 {
    // rust: return None;
}
    // rust: let n: u32 = std::str::from_utf8(&bytes[end..end + digits])
    // rust: .ok()?
    // rust: .parse()
    // rust: .ok()?;
    // rust: if n > 255 {
    // rust: return None;
}
    // rust: end += digits;
}
    // A fifth part makes it a version number (`10.0.19045.1`), not an address.
    // rust: if bytes.get(end) == Some(&b'.') && bytes.get(end + 1).is_some_and(u8::is_ascii_digit) {
    // rust: return None;
}
    // A port goes with it.
    // rust: if bytes.get(end) == Some(&b':') {
    // rust: let digits = bytes[end + 1..]
    // rust: .iter()
    // rust: .take_while(|b| b.is_ascii_digit())
    // rust: .count();
    // rust: if (1..=5).contains(&digits) {
    // rust: end += 1 + digits;
}
}
    // rust: ends_token(bytes, end).then_some((end - i, IP))
}

// Eight hex groups with colons, or fewer around a `::` (at least three groups, so a Rust path
// such as `a::b` is left alone).
ipv6_at :: proc(bytes: []u8, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !starts_token(bytes, i) {
    // rust: return None;
}
    // rust: let len = bytes[i..]
    // rust: .iter()
    // rust: .take_while(|b| b.is_ascii_hexdigit() || **b == b':')
    // rust: .count();
    // rust: let token = std::str::from_utf8(&bytes[i..i + len]).ok()?;
    // rust: let token = token.trim_end_matches(':');
    // rust: let groups: Vec<&str> = token.split(':').collect();
    // rust: let filled = groups.iter().filter(|g| !g.is_empty()).count();
    // rust: let ok = groups.iter().all(|g| g.len() <= 4)
    // rust: && (filled == 8 || (token.contains("::") && filled >= 3))
    // rust: && groups.iter().any(|g| g.bytes().any(|b| b.is_ascii_digit()));
    // rust: (ok && ends_token(bytes, i + token.len())).then_some((token.len(), IP))
}

// `0f8c…-…` (8-4-4-4-12) or the same 32 hex digits without dashes, as accounts are named.
uuid_at :: proc(bytes: []u8, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !starts_token(bytes, i) {
    // rust: return None;
}
    // rust: let hex = |range: std::ops::Range<usize>| {
    // rust: bytes
    // rust: .get(range)
    // rust: .is_some_and(|s| s.iter().all(u8::is_ascii_hexdigit))
}
    // rust: let dashed = [8usize, 13, 18, 23]
    // rust: .iter()
    // rust: .all(|&d| bytes.get(i + d) == Some(&b'-'))
    // rust: && [(0, 8), (9, 13), (14, 18), (19, 23), (24, 36)]
    // rust: .iter()
    // rust: .all(|&(a, b)| hex(i + a..i + b));
    // rust: if dashed && ends_token(bytes, i + 36) {
    // rust: return Some((36, UUID));
}
    // rust: (hex(i..i + 32) && ends_token(bytes, i + 32)).then_some((32, UUID))
}

// Whole-word occurrences of `word`, in any case.
replace_word :: proc(text: string, word: string, label: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lower = text.to_lowercase();
    // rust: let needle = word.to_lowercase();
    // Lowercasing can change byte lengths outside ASCII: then match exactly instead.
    // rust: let (hay, needle) = if lower.len() == text.len() && needle.len() == word.len() {
    // rust: (lower.as_str(), needle.as_str())
    // rust: } else {
    // rust: (text, word)
}
    // rust: let bytes = text.as_bytes();
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut copied = 0;
    // rust: let mut from = 0;
    // rust: while let Some(found) = hay[from..].find(needle) {
    // rust: let start = from + found;
    // rust: let end = start + needle.len();
    // rust: let alone = (start == 0 || !word_byte(bytes[start - 1])) && ends_token(bytes, end);
        // A label put in earlier (`<user>` for a user named "user") stays as it is.
    // rust: let label_inside = start > 0 && bytes[start - 1] == b'<' && bytes.get(end) == Some(&b'>');
    // rust: if alone && !label_inside {
    // rust: out.push_str(&text[copied..start]);
    // rust: out.push_str(label);
    // rust: copied = end;
}
    // rust: from = end;
}
    // rust: out.push_str(&text[copied..]);
    // rust: out
}

    // rust: mod tests {
//     use super::*;

user_folders_lose_their_name :: proc() {
}
    // rust: let s = Scrubber::bare();
    // rust: assert_eq!(
    // rust: s.scrub("at /Users/ana.b/code/horizon/src/main.rs:10"),
    // rust: "at /Users/<user>/code/horizon/src/main.rs:10"
    // rust: );
    // rust: assert_eq!(
    // rust: s.scrub("/home/ana/.local/share/horizon"),
    // rust: "/home/<user>/.local/share/horizon"
    // rust: );
    // rust: assert_eq!(
    // rust: s.scrub("C:\\Users\\Ana Silva\\x\nnext"),
    // rust: "C:\\Users\\<user>\\x\nnext"
    // rust: );
    // rust: assert_eq!(s.scrub(r"C:\Users\ana\AppData"), r"C:\Users\<user>\AppData");
    // rust: assert_eq!(
    // rust: s.scrub(r#"{"path":"C:\\Users\\ana\\AppData"}"#),
    // rust: r#"{"path":"C:\\Users\\<user>\\AppData"}"#
    // rust: );
    // rust: assert_eq!(s.scrub("/usr/home/"), "/usr/home/");
}

the_user_name_goes_wherever_it_stands_alone :: proc() {
}
    // rust: let s = Scrubber::bare().with_user("ludo");
    // rust: assert_eq!(
    // rust: s.scrub("Ludo's machine, user ludo"),
    // rust: "<user>'s machine, user <user>"
    // rust: );
    // rust: assert_eq!(s.scrub("ludovic"), "ludovic");
    // rust: assert_eq!(Scrubber::bare().with_user("al").scrub("al"), "al");
    // rust: assert_eq!(
    // rust: Scrubber::bare()
    // rust: .with_user("user")
    // rust: .scrub(r"C:\Users\user\AppData, user"),
    // rust: r"C:\Users\<user>\AppData, <user>"
    // rust: );
}

addresses_and_accounts_are_hidden :: proc() {
}
    // rust: let s = Scrubber::bare();
    // rust: assert_eq!(s.scrub("joined 192.168.1.20:25565 ok"), "joined <ip> ok");
    // rust: assert_eq!(s.scrub("from 10.0.0.1."), "from <ip>.");
    // rust: assert_eq!(s.scrub("[2a01:e0a:1f2::5]"), "[<ip>]");
    // rust: assert_eq!(s.scrub("mail ana.b+mc@example.org now"), "mail <email> now");
    // rust: assert_eq!(
    // rust: s.scrub(
    // rust: "uuid 069a79f4-44e9-4726-a5be-fca90e38aaf5 and 069a79f444e94726a5befca90e38aaf5"
    // rust: ),
    // rust: "uuid <uuid> and <uuid>"
    // rust: );
}

code_and_versions_are_left_alone :: proc() {
}
    // rust: let s = Scrubber::bare();
    // rust: for text in [
    // rust: "std::panicking::begin_panic (src/game.rs:12:5)",
    // rust: "a::b::c",
    // rust: "driver 31.0.15.3623, Windows 10.0.19045.1",
    // rust: "wgpu 30.0.1",
    // rust: "commit 9fceb02d0ae598e95dc970b74767f19372d61af8",
    // rust: "user@host",
    // rust: ] {
    // rust: assert_eq!(s.scrub(text), text);
}
}

known_private_terms_go_first :: proc() {
}
    // rust: let s = Scrubber::bare()
    // rust: .term("My World")
    // rust: .term("play.example.net")
    // rust: .term("ab");
    // rust: assert_eq!(
    // rust: s.scrub("Saving My World; joined play.example.net:25565, ab"),
    // rust: "Saving <private>; joined <private>:25565, ab"
    // rust: );
}
}
