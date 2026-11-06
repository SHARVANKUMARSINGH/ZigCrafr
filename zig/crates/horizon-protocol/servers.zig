//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_servers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The multiplayer server list, stored like vanilla's ServerList in an
//! uncompressed `servers.dat`: `{servers: [{name, ip, icon?, acceptTextures?,
//! acceptedCodeOfConduct?}]}`.
// use horizon_world::nbt::{self, JavaString, NamedTag, Tag};
// use std::path::Path;

pub const ServerEntry = struct {
    name: []const u8,
    ip: []const u8,
    /// Base64 PNG favicon from the last status ping.
    icon: ?[]const u8,
    /// ServerPackStatus: None = prompt, Some(true) enabled, Some(false) disabled.
    accept_textures: ?bool,
    /// `String.hashCode` of the Code of Conduct accepted for good (ServerData's
    /// `acceptedCodeOfConduct`); 0 for none.
    accepted_code_of_conduct: i32,
};
    // rust: impl ServerEntry {
pub fn new(name: []const u8, ip: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: ip: ip.to_owned(),
    // rust: icon: None,
    // rust: accept_textures: None,
    // rust: accepted_code_of_conduct: 0,
}
}
pub fn to_tag(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = vec![
    // rust: ("name", Tag::String(JavaString::from(self.name.as_str()))),
    // rust: ("ip", Tag::String(JavaString::from(self.ip.as_str()))),
    // rust: ];
    // rust: if let Some(icon) = &self.icon {
    // rust: entries.push(("icon", Tag::String(JavaString::from(icon.as_str()))));
}
    // rust: if let Some(accept) = self.accept_textures {
    // rust: entries.push(("acceptTextures", Tag::Byte(i8::from(accept))));
}
    // rust: if self.accepted_code_of_conduct != 0 {
    // rust: entries.push((
    // rust: "acceptedCodeOfConduct",
    // rust: Tag::Int(self.accepted_code_of_conduct),
    // rust: ));
}
    // rust: Tag::compound(entries)
}
pub fn from_tag(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let string = |k: &str| match tag.get(k) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: Some(Self {
    // rust: name: string("name").unwrap_or_default(),
    // rust: ip: string("ip")?,
    // rust: icon: string("icon"),
    // rust: accept_textures: match tag.get("acceptTextures") {
    // rust: Some(Tag::Byte(b)) => Some(*b != 0),
    // rust: _ => None,
    // rust: },
    // rust: accepted_code_of_conduct: match tag.get("acceptedCodeOfConduct") {
    // rust: Some(Tag::Int(hash)) => *hash,
    // rust: _ => 0,
    // rust: },
    // rust: })
}
}

/// ServerList.load: missing or unreadable files give an empty list.
pub fn load(path: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(bytes) = std::fs::read(path) else {
    // rust: return Vec::new();
}
    // rust: let Ok((root, _)) = nbt::read_named(&bytes, nbt::Limits::default()) else {
    // rust: return Vec::new();
}
    // ServerList skips entries flagged "hidden" (the LAN/quick-play ones).
    // rust: match root.tag.get("servers") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter(|t| !matches!(t.get("hidden"), Some(Tag::Byte(1))))
    // rust: .filter_map(ServerEntry::from_tag)
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
/// ServerList.save: write to a temporary file, then replace.
pub fn save(path: *Path, servers: *[ServerEntry]) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = NamedTag {
    // rust: name: JavaString::from(""),
    // rust: tag: Tag::compound([(
    // rust: "servers",
    // rust: Tag::List(servers.iter().map(ServerEntry::to_tag).collect()),
    // rust: )]),
}
    // rust: write(path, &root)
}
/// Puts `entry` first, keeping every other entry and field as the file has them (the hidden
/// ones too). A file that is there but can't be read is left as it is.
pub fn prepend(path: *Path, entry: *ServerEntry) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: insert(path, entry, |_| None)
}
/// Puts `entry` just after the first entry whose address `after` accepts, or last when none
/// does, keeping every other entry and field as the file has them (the hidden ones too).
    // rust: pub fn insert_after(
    // rust: path: &Path,
    // rust: entry: &ServerEntry,
    // rust: after: impl Fn(&str) -> bool,
    // rust: ) -> std::io::Result<()> {
    // rust: insert(path, entry, |list| {
    // rust: let ip = |t: &Tag| match t.get("ip") {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => String::new(),
}
    // rust: Some(
    // rust: list.iter()
    // rust: .position(|t| after(&ip(t)))
    // rust: .map_or(list.len(), |i| i + 1),
    // rust: )
    // rust: })
}
/// Inserts `entry` at the index `at` picks in the file's list (`None`: first).
    // rust: fn insert(
    // rust: path: &Path,
    // rust: entry: &ServerEntry,
    // rust: at: impl Fn(&[Tag]) -> Option<usize>,
    // rust: ) -> std::io::Result<()> {
    // rust: let mut root = match std::fs::read(path) {
    // rust: Ok(bytes) => {
    // rust: nbt::read_named(&bytes, nbt::Limits::default())
    // rust: .map_err(std::io::Error::other)?
    // rust: .0
}
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => NamedTag {
    // rust: name: JavaString::from(""),
    // rust: tag: Tag::Compound(Default::default()),
    // rust: },
    // rust: Err(e) => return Err(e),
}
    // rust: let Tag::Compound(top) = &mut root.tag else {
    // rust: return Err(std::io::Error::other("servers.dat is not a compound"));
}
    // rust: match top
    // rust: .entry(JavaString::from("servers"))
    // rust: .or_insert_with(|| Tag::List(Vec::new()))
    // rust: {
    // rust: Tag::List(list) => {
    // rust: let index = at(list).unwrap_or(0);
    // rust: list.insert(index, entry.to_tag());
}
    // rust: _ => return Err(std::io::Error::other("servers.dat has no server list")),
}
    // rust: write(path, &root)
}
pub fn write(path: *Path, root: *NamedTag) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = nbt::write_named(root, nbt::Limits::default()).map_err(std::io::Error::other)?;
    // rust: let tmp = path.with_extension("dat_tmp");
    // rust: std::fs::write(&tmp, bytes)?;
    // rust: std::fs::rename(tmp, path)
}

/// ServerAddress.parseString: `host`, `host:port` or `[v6]:port`; default 25565.
pub fn parse_address(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = text.trim();
    // rust: if text.is_empty() {
    // rust: return None;
}
    // rust: if let Some(rest) = text.strip_prefix('[') {
    // rust: let (host, tail) = rest.split_once(']')?;
    // rust: let port = match tail.strip_prefix(':') {
    // rust: Some(p) => p.parse().ok()?,
    // rust: None if tail.is_empty() => 25565,
    // rust: None => return None,
}
    // rust: return Some((host.to_owned(), port));
}
    // rust: match text.rsplit_once(':') {
    // rust: Some((host, port)) if !host.contains(':') => Some((host.to_owned(), port.parse().ok()?)),
    // rust: Some(_) => Some((text.to_owned(), 25565)),
    // rust: None => Some((text.to_owned(), 25565)),
}
}

    // rust: mod tests {
//     use super::*;

pub fn servers_dat_round_trips() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-servers-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("servers.dat");
    // rust: let list = vec![
    // rust: ServerEntry::new("Minecraft Server", "localhost:25565"),
    // rust: ServerEntry {
    // rust: accept_textures: Some(false),
    // rust: ..ServerEntry::new("Other", "example.org")
    // rust: },
    // rust: ];
    // rust: save(&path, &list).unwrap();
    // rust: assert_eq!(load(&path), list);
        // Vanilla layout: an unnamed root compound with a "servers" list.
    // rust: let (root, _) =
    // rust: nbt::read_named(&std::fs::read(&path).unwrap(), nbt::Limits::default()).unwrap();
    // rust: assert_eq!(root.name, JavaString::from(""));
    // rust: assert!(matches!(root.tag.get("servers"), Some(Tag::List(l)) if l.len() == 2));
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn prepend_keeps_hidden_entries_and_unknown_fields() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-prepend-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("servers.dat");
    // rust: prepend(&path, &ServerEntry::new("First", "a.example")).unwrap();
    // rust: assert_eq!(load(&path), [ServerEntry::new("First", "a.example")]);
    // rust: let hidden = Tag::compound([
    // rust: ("name", Tag::String(JavaString::from("Direct"))),
    // rust: ("ip", Tag::String(JavaString::from("b.example"))),
    // rust: ("hidden", Tag::Byte(1)),
    // rust: ("acceptedCodeOfConduct", Tag::String(JavaString::from("x"))),
    // rust: ]);
    // rust: let root = NamedTag {
    // rust: name: JavaString::from(""),
    // rust: tag: Tag::compound([("servers", Tag::List(vec![hidden.clone()]))]),
}
    // rust: write(&path, &root).unwrap();
    // rust: prepend(&path, &ServerEntry::new("Top", "c.example")).unwrap();
    // rust: let (root, _) =
    // rust: nbt::read_named(&std::fs::read(&path).unwrap(), nbt::Limits::default()).unwrap();
    // rust: let Some(Tag::List(list)) = root.tag.get("servers") else {
    // rust: panic!("a server list");
}
    // rust: assert_eq!(
    // rust: list,
    // rust: &[ServerEntry::new("Top", "c.example").to_tag(), hidden]
    // rust: );
        // A file that can't be read stays as it is.
    // rust: std::fs::write(&path, b"not nbt").unwrap();
    // rust: assert!(prepend(&path, &ServerEntry::new("Top", "c.example")).is_err());
    // rust: assert_eq!(std::fs::read(&path).unwrap(), b"not nbt");
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn parses_addresses_like_server_address() void {
}
    // rust: assert_eq!(
    // rust: parse_address("localhost"),
    // rust: Some(("localhost".into(), 25565))
    // rust: );
    // rust: assert_eq!(
    // rust: parse_address("127.0.0.1:25570"),
    // rust: Some(("127.0.0.1".into(), 25570))
    // rust: );
    // rust: assert_eq!(parse_address("[::1]:1234"), Some(("::1".into(), 1234)));
    // rust: assert_eq!(parse_address("host:notaport"), None);
    // rust: assert_eq!(parse_address(""), None);
}
}
