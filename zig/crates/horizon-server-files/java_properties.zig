//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_java_properties
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `java.util.Properties` as the dedicated server uses it: `load` (the
//! LineReader and loadConvert of the JDK), `store` with the sorted entries the
//! JDK writes since Java 18, and `java.util.Date.toString` for the timestamp
//! comment. Values are kept in a map keyed like Java's Hashtable; iteration
//! for storing sorts by `String.compareTo` (UTF-16 code units).
// use std::collections::HashMap;

/// A malformed `\uxxxx` escape: Properties.load throws IllegalArgumentException.
pub const Malformed = struct {};
    // rust: impl std::fmt::Display for Malformed {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("Malformed \\uxxxx encoding.")
}
}
    // rust: impl std::error::Error for Malformed {}

/// The key/value pairs, last occurrence winning (Hashtable.put).
pub const Properties = struct {
    map: HashMap<[]const u8,
};

    // rust: impl Properties {
pub fn get(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.get(key).map(String::as_str)
}
pub fn put(self: *Self, key: []const u8, value: []const u8) void {
}
    // rust: self.map.insert(key.to_owned(), value);
}
pub fn remove(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.remove(key)
}

    /// Properties.load(Reader) over already decoded characters.
pub fn load(text: *[char]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Self::default();
    // rust: let mut reader = LineReader {
    // rust: chars: text,
    // rust: pos: 0,
}
    // rust: while let Some(line) = reader.read_line() {
    // rust: let mut key_len = 0;
    // rust: let mut value_start = line.len();
    // rust: let mut has_sep = false;
    // rust: let mut preceding_backslash = false;
    // rust: while key_len < line.len() {
    // rust: let c = line[key_len];
    // rust: if (c == '=' || c == ':') && !preceding_backslash {
    // rust: value_start = key_len + 1;
    // rust: has_sep = true;
    // rust: break;
    // rust: } else if (c == ' ' || c == '\t' || c == '\u{c}') && !preceding_backslash {
    // rust: value_start = key_len + 1;
    // rust: break;
}
    // rust: if c == '\\' {
    // rust: preceding_backslash = !preceding_backslash;
    // rust: } else {
    // rust: preceding_backslash = false;
}
    // rust: key_len += 1;
}
    // rust: while value_start < line.len() {
    // rust: let c = line[value_start];
    // rust: if c != ' ' && c != '\t' && c != '\u{c}' {
    // rust: if !has_sep && (c == '=' || c == ':') {
    // rust: has_sep = true;
    // rust: } else {
    // rust: break;
}
}
    // rust: value_start += 1;
}
    // rust: let key = load_convert(&line[..key_len])?;
    // rust: let value = load_convert(&line[value_start..])?;
    // rust: out.map.insert(key, value);
}
    // rust: Ok(out)
}

    /// Settings.loadFromFile: UTF-8 with errors reported, falling back to
    /// ISO-8859-1 for the whole file. A missing file is an empty set.
pub fn load_file(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match std::str::from_utf8(bytes) {
    // rust: Ok(s) => Self::load(&s.chars().collect::<Vec<_>>()),
    // rust: Err(_) => Self::load(&bytes.iter().map(|&b| char::from(b)).collect::<Vec<_>>()),
}
}

    /// Properties.load(InputStream): ISO-8859-1.
pub fn load_latin1(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load(&bytes.iter().map(|&b| char::from(b)).collect::<Vec<_>>())
}

    /// Properties.store(Writer, comments): comment, date, then the entries
    /// sorted by key, with `escUnicode` off (the Writer variant) or on (the
    /// OutputStream variant, whose bytes are ISO-8859-1).
pub fn store(self: *Self, comment: ?[]const u8, date: []const u8, esc_unicode: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let nl = line_separator();
    // rust: let mut out = String::new();
    // rust: if let Some(c) = comment {
    // rust: write_comments(&mut out, c, nl);
}
    // rust: out.push('#');
    // rust: out.push_str(date);
    // rust: out.push_str(nl);
    // rust: let mut keys: Vec<&String> = self.map.keys().collect();
    // rust: keys.sort_by(|a, b| a.encode_utf16().cmp(b.encode_utf16()));
    // rust: for key in keys {
    // rust: out.push_str(&save_convert(key, true, esc_unicode));
    // rust: out.push('=');
    // rust: out.push_str(&save_convert(&self.map[key], false, esc_unicode));
    // rust: out.push_str(nl);
}
    // rust: out
}
}

/// System.lineSeparator().
pub fn line_separator() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(windows) { "\r\n" } else { "\n" }
}

pub const LineReader = struct {
    chars: *'a [char],
    pos: usize,
};
    // rust: impl LineReader<'_> {
    /// LineReader.readLine: one logical line, leading whitespace skipped,
    /// comments and blank lines dropped, backslash-newline continuations joined.
pub fn read_line(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut line: Vec<char> = Vec::new();
    // rust: let mut skip_white = true;
    // rust: let mut appended = false;
    // rust: let mut backslash = false;
    // rust: let chars = self.chars;
    // rust: loop {
    // rust: if self.pos >= chars.len() {
    // rust: if line.is_empty() {
    // rust: return None;
}
    // rust: if backslash {
    // rust: line.pop();
}
    // rust: return Some(line);
}
    // rust: let c = chars[self.pos];
    // rust: self.pos += 1;
    // rust: if skip_white {
    // rust: if c == ' ' || c == '\t' || c == '\u{c}' {
    // rust: continue;
}
    // rust: if !appended && (c == '\r' || c == '\n') {
    // rust: continue;
}
    // rust: skip_white = false;
    // rust: appended = false;
}
    // rust: if line.is_empty() && (c == '#' || c == '!') {
    // rust: loop {
    // rust: let &d = chars.get(self.pos)?;
    // rust: self.pos += 1;
    // rust: if d == '\r' || d == '\n' {
    // rust: break;
}
}
    // rust: skip_white = true;
    // rust: continue;
}
    // rust: if c != '\n' && c != '\r' {
    // rust: line.push(c);
    // rust: backslash = if c == '\\' { !backslash } else { false };
    // rust: continue;
}
    // rust: if line.is_empty() {
    // rust: skip_white = true;
    // rust: continue;
}
    // rust: if self.pos >= chars.len() {
    // rust: if backslash {
    // rust: line.pop();
}
    // rust: return Some(line);
}
    // rust: if backslash {
    // rust: line.pop();
    // rust: skip_white = true;
    // rust: appended = true;
    // rust: backslash = false;
    // rust: if c == '\r' && chars[self.pos] == '\n' {
    // rust: self.pos += 1;
}
    // rust: } else {
    // rust: return Some(line);
}
}
}
}

pub fn load_convert(input: *[char]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::with_capacity(input.len());
    // rust: let mut units: Vec<u16> = Vec::new();
    // rust: let flush = |units: &mut Vec<u16>, out: &mut String| {
    // rust: if !units.is_empty() {
    // rust: out.extend(char::decode_utf16(units.drain(..)).map(|r| r.unwrap_or('\u{fffd}')));
}
}
    // rust: let mut i = 0;
    // rust: while i < input.len() {
    // rust: let c = input[i];
    // rust: i += 1;
    // rust: if c != '\\' {
    // rust: flush(&mut units, &mut out);
    // rust: out.push(c);
    // rust: continue;
}
    // rust: let Some(&next) = input.get(i) else {
            // A trailing lone backslash is dropped.
    // rust: break;
}
    // rust: i += 1;
    // rust: if next == 'u' {
    // rust: if i + 4 > input.len() {
    // rust: return Err(Malformed);
}
    // rust: let mut value = 0u32;
    // rust: for &h in &input[i..i + 4] {
    // rust: value = value * 16 + h.to_digit(16).ok_or(Malformed)?;
}
    // rust: i += 4;
    // rust: units.push(value as u16);
    // rust: continue;
}
    // rust: flush(&mut units, &mut out);
    // rust: out.push(match next {
    // rust: 't' => '\t',
    // rust: 'r' => '\r',
    // rust: 'n' => '\n',
    // rust: 'f' => '\u{c}',
    // rust: other => other,
    // rust: });
}
    // rust: flush(&mut units, &mut out);
    // rust: Ok(out)
}

pub fn save_convert(s: []const u8, escape_space: bool, esc_unicode: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::with_capacity(s.len() * 2);
    // rust: for (index, c) in s.encode_utf16().enumerate() {
    // rust: if c > 61 && c < 127 {
    // rust: if c == u16::from(b'\\') {
    // rust: out.push_str("\\\\");
    // rust: } else {
    // rust: out.push(char::from(c as u8));
}
    // rust: continue;
}
    // rust: match c {
    // rust: 0x20 => {
    // rust: if index == 0 || escape_space {
    // rust: out.push('\\');
}
    // rust: out.push(' ');
}
    // rust: 0x09 => out.push_str("\\t"),
    // rust: 0x0a => out.push_str("\\n"),
    // rust: 0x0d => out.push_str("\\r"),
    // rust: 0x0c => out.push_str("\\f"),
    // rust: 0x3d | 0x3a | 0x23 | 0x21 => {
    // rust: out.push('\\');
    // rust: out.push(char::from(c as u8));
}
    // rust: _ => {
    // rust: if (!(0x20..=0x7e).contains(&c)) && esc_unicode {
    // rust: out.push_str(&format!("\\u{c:04X}"));
    // rust: } else {
    // rust: push_unit(&mut out, c);
}
}
}
}
    // rust: fix_surrogates(out)
}

/// Units are pushed one at a time; surrogate halves are joined afterwards.
pub fn push_unit(out: *mut []const u8, unit: u16) void {
}
    // rust: match char::from_u32(u32::from(unit)) {
    // rust: Some(c) => out.push(c),
    // rust: None => out.push_str(&format!("\u{0}{unit:04x}\u{0}")),
}
}
pub fn fix_surrogates(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !s.contains('\u{0}') {
    // rust: return s;
}
    // rust: let mut units: Vec<u16> = Vec::new();
    // rust: let mut parts = s.split('\u{0}');
    // rust: let mut odd = false;
    // rust: for part in parts.by_ref() {
    // rust: if odd {
    // rust: units.push(u16::from_str_radix(part, 16).unwrap_or(0xfffd));
    // rust: } else {
    // rust: units.extend(part.encode_utf16());
}
    // rust: odd = !odd;
}
    // rust: String::from_utf16_lossy(&units)
}

/// Properties.writeComments.
pub fn write_comments(out: *mut []const u8, comments: []const u8, nl: []const u8) void {
}
    // rust: out.push('#');
    // rust: let units: Vec<u16> = comments.encode_utf16().collect();
    // rust: let mut current = 0;
    // rust: let mut last = 0;
    // rust: let len = units.len();
    // rust: while current < len {
    // rust: let c = units[current];
    // rust: if c > 0x00ff || c == u16::from(b'\n') || c == u16::from(b'\r') {
    // rust: if last != current {
    // rust: out.push_str(&String::from_utf16_lossy(&units[last..current]));
}
    // rust: if c > 0x00ff {
    // rust: out.push_str(&format!("\\u{c:04X}"));
    // rust: } else {
    // rust: out.push_str(nl);
    // rust: if c == u16::from(b'\r')
    // rust: && current != len - 1
    // rust: && units[current + 1] == u16::from(b'\n')
    // rust: {
    // rust: current += 1;
}
    // rust: if current == len - 1
    // rust: || units[current + 1] != u16::from(b'#')
    // rust: && units[current + 1] != u16::from(b'!')
    // rust: {
    // rust: out.push('#');
}
}
    // rust: last = current + 1;
}
    // rust: current += 1;
}
    // rust: if last != current {
    // rust: out.push_str(&String::from_utf16_lossy(&units[last..current]));
}
    // rust: out.push_str(nl);
}

/// Civil date from days since 1970-01-01 (proleptic Gregorian).
pub fn civil_from_days(days: i64) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let z = days + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z - era * 146_097;
    // rust: let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    // rust: let y = yoe + era * 400;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let d = (doy - (153 * mp + 2) / 5 + 1) as u32;
    // rust: let m = if mp < 10 { mp + 3 } else { mp - 9 } as u32;
    // rust: (if m <= 2 { y + 1 } else { y }, m, d)
}
/// Days since 1970-01-01 of a civil date.
pub fn days_from_civil(y: i64, m: u32, d: u32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let y = if m <= 2 { y - 1 } else { y };
    // rust: let era = y.div_euclid(400);
    // rust: let yoe = y - era * 400;
    // rust: let m = i64::from(m);
    // rust: let doy = (153 * (if m > 2 { m - 3 } else { m + 9 }) + 2) / 5 + i64::from(d) - 1;
    // rust: let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
    // rust: era * 146_097 + doe - 719_468
}

/// Milliseconds since the epoch, now.
pub fn now_millis() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64)
}

/// java.util.Date.toString in UTC: "EEE MMM dd HH:mm:ss zzz yyyy".
pub fn date_string(millis: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
pub const DAYS: [[]const u8; 7] = ["Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"];
    // rust: const MONTHS: [&str; 12] = [
    // rust: "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    // rust: ];
    // rust: let secs = millis.div_euclid(1000);
    // rust: let days = secs.div_euclid(86_400);
    // rust: let rem = secs.rem_euclid(86_400);
    // rust: let (y, m, d) = civil_from_days(days);
    // rust: format!(
    // rust: "{} {} {:02} {:02}:{:02}:{:02} UTC {}",
    // rust: DAYS[days.rem_euclid(7) as usize],
    // rust: MONTHS[m as usize - 1],
    // rust: d,
    // rust: rem / 3600,
    // rust: rem / 60 % 60,
    // rust: rem % 60,
    // rust: y
    // rust: )
}

    // rust: mod tests {
//     use super::*;
pub fn load(s: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Properties::load(&s.chars().collect::<Vec<_>>()).unwrap()
}
pub fn parses_like_java() void {
}
    // rust: let p = load(
    // rust: "# comment\n  ! other\nkey=value\na:b\nc d\n e  =  f g \nmulti=one\\\n    two\nesc=\\u00e9\\t\\x\nempty\nlast=1\nlast=2\r\ncr=1\rnext=2",
    // rust: );
    // rust: assert_eq!(p.get("key"), Some("value"));
    // rust: assert_eq!(p.get("a"), Some("b"));
    // rust: assert_eq!(p.get("c"), Some("d"));
    // rust: assert_eq!(p.get("e"), Some("f g "));
    // rust: assert_eq!(p.get("multi"), Some("onetwo"));
    // rust: assert_eq!(p.get("esc"), Some("é\tx"));
    // rust: assert_eq!(p.get("empty"), Some(""));
    // rust: assert_eq!(p.get("last"), Some("2"));
    // rust: assert_eq!(p.get("cr"), Some("1"));
    // rust: assert_eq!(p.get("next"), Some("2"));
}
pub fn stores_sorted_and_escaped() void {
}
    // rust: let mut p = Properties::default();
    // rust: p.put("level-type", "minecraft:normal".into());
    // rust: p.put("motd", " A=B#".into());
    // rust: p.put("b key", "é".into());
    // rust: let s = p.store(Some("Minecraft server properties"), "DATE", false);
        // Each line ends in System.lineSeparator(), as BufferedWriter.newLine writes it.
    // rust: assert_eq!(
    // rust: s,
    // rust: "#Minecraft server properties\n#DATE\nb\\ key=é\nlevel-type=minecraft\\:normal\nmotd=\\ A\\=B\\#\n"
    // rust: .replace('\n', line_separator())
    // rust: );
    // rust: assert!(p.store(None, "D", true).contains("b\\ key=\\u00E9"));
}
pub fn dates() void {
}
    // rust: assert_eq!(date_string(0), "Thu Jan 01 00:00:00 UTC 1970");
    // rust: assert_eq!(days_from_civil(2026, 10, 12), 20_738);
    // rust: assert_eq!(civil_from_days(20_738), (2026, 10, 12));
}
}
