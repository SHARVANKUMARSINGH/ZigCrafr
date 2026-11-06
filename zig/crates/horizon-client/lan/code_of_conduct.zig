//! Transpiled from Horizon Rust crate
//! Module: horizon-client_code_of_conduct
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The code of conduct (`enable-code-of-conduct`): `DedicatedServer.readCodeOfConducts`
//! reads `codeofconduct/<language>.txt`, and
//! `ServerConfigurationPacketListenerImpl.addOptionalTasks` offers the one
//! that fits the player's language.
// use std::path::Path;

/// `StringUtil.stripColor`: the pattern `(?i)§[0-9A-FK-OR]` removed.
pub fn strip_color(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut chars = text.chars().peekable();
    // rust: while let Some(c) = chars.next() {
    // rust: if c == '\u{a7}'
    // rust: && chars.peek().is_some_and(
    // rust: |n| matches!(n.to_ascii_lowercase(), '0'..='9' | 'a'..='f' | 'k'..='o' | 'r'),
    // rust: )
    // rust: {
    // rust: chars.next();
    // rust: } else {
    // rust: out.push(c);
}
}
    // rust: out
}

/// `String.join("\n", Files.readAllLines(file))`: lines end at `\n`, `\r`
/// or `\r\n`, and the last line's terminator is dropped.
pub fn join_lines(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lines: Vec<&str> = Vec::new();
    // rust: let bytes = text.as_bytes();
    // rust: let (mut start, mut i) = (0, 0);
    // rust: while i < bytes.len() {
    // rust: match bytes[i] {
    // rust: b'\n' | b'\r' => {
    // rust: lines.push(&text[start..i]);
    // rust: if bytes[i] == b'\r' && bytes.get(i + 1) == Some(&b'\n') {
    // rust: i += 1;
}
    // rust: start = i + 1;
}
    // rust: _ => {}
}
    // rust: i += 1;
}
    // rust: if start < bytes.len() {
    // rust: lines.push(&text[start..]);
}
    // rust: lines.join("\n")
}

/// `DedicatedServer.readCodeOfConducts`: each `<language>.txt` of `dir`, by
/// its lowercased name, with the colour codes stripped. Files come in name
/// order (vanilla's is the file system's).
pub fn read(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !std::fs::symlink_metadata(dir).is_ok_and(|m| m.is_dir()) {
    // rust: return Err(format!(
    // rust: "Code of Conduct folder does not exist: {}",
    // rust: dir.display()
    // rust: ));
}
    // rust: let mut files: Vec<_> = std::fs::read_dir(dir)
    // rust: .map_err(|e| format!("Failed to read Code of Conduct folder: {e}"))?
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .collect();
    // rust: files.sort();
    // rust: let allowed = std::fs::canonicalize(dir).map_err(|e| e.to_string())?;
    // rust: let mut out = Vec::new();
    // rust: for file in files {
    // rust: let Some(name) = file.file_name().and_then(|n| n.to_str()) else {
    // rust: continue;
}
    // rust: let Some(language) = name.strip_suffix(".txt") else {
    // rust: continue;
}
    // rust: let real = std::fs::canonicalize(&file).map_err(|e| e.to_string())?;
    // rust: if real.parent() != Some(allowed.as_path()) {
    // rust: return Err(format!(
    // rust: "Failed to read Code of Conduct file \"{name}\" because it links to a file outside the allowed directory"
    // rust: ));
}
    // rust: let bytes = std::fs::read(&file)
    // rust: .map_err(|e| format!("Failed to read Code of Conduct file {name}: {e}"))?;
    // rust: let text = String::from_utf8(bytes)
    // rust: .map_err(|_| format!("Failed to read Code of Conduct file {name}"))?;
    // rust: out.push((language.to_lowercase(), strip_color(&join_lines(&text))));
}
    // rust: Ok(out)
}

/// The supplier `addOptionalTasks` gives the task: the player's language,
/// else `en_us`, else the first one. None when the server has none.
    // rust: pub fn pick<'a>(texts: &'a [(String, String)], language: &str) -> Option<&'a str> {
    // rust: let find = |key: &str| {
    // rust: texts
    // rust: .iter()
    // rust: .find(|(k, _)| k == key)
    // rust: .map(|(_, v)| v.as_str())
}
    // rust: find(&language.to_lowercase())
    // rust: .or_else(|| find("en_us"))
    // rust: .or_else(|| texts.first().map(|(_, v)| v.as_str()))
}

    // rust: mod tests {
//     use super::*;

pub fn texts() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec![
    // rust: ("de_de".into(), "Regeln".into()),
    // rust: ("en_us".into(), "Rules".into()),
    // rust: ]
}

pub fn the_players_language_then_en_us_then_the_first() void {
}
    // rust: let t = texts();
    // rust: assert_eq!(pick(&t, "DE_de"), Some("Regeln"));
    // rust: assert_eq!(pick(&t, "fr_fr"), Some("Rules"));
    // rust: let only_de = &t[..1];
    // rust: assert_eq!(pick(only_de, "fr_fr"), Some("Regeln"));
    // rust: assert_eq!(pick(&[], "en_us"), None);
}

pub fn colour_codes_are_stripped_and_lines_joined_without_the_last_newline() void {
}
    // rust: assert_eq!(
    // rust: strip_color("\u{a7}aGreen \u{a7}Rx \u{a7}z \u{a7}"),
    // rust: "Green x \u{a7}z \u{a7}"
    // rust: );
    // rust: assert_eq!(join_lines("a\r\nb\rc\n"), "a\nb\nc");
    // rust: assert_eq!(join_lines("a\n\n"), "a\n");
    // rust: assert_eq!(join_lines(""), "");
}

pub fn a_missing_folder_is_an_error() void {
}
    // rust: let dir = std::env::temp_dir().join("horizon-no-such-coc-folder");
    // rust: assert!(
    // rust: read(&dir)
    // rust: .unwrap_err()
    // rust: .starts_with("Code of Conduct folder does not exist")
    // rust: );
}

pub fn only_txt_files_are_read_by_lowercased_name() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-coc-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join("EN_US.txt"), "\u{a7}lBe nice\nplease\n").unwrap();
    // rust: std::fs::write(dir.join("notes.md"), "ignored").unwrap();
    // rust: let read = read(&dir).unwrap();
    // rust: std::fs::remove_dir_all(&dir).unwrap();
    // rust: assert_eq!(
    // rust: read,
    // rust: vec![("en_us".to_string(), "Be nice\nplease".to_string())]
    // rust: );
}
}
