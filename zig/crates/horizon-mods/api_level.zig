//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_api_level
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mod API levels: which of the WIT contract's functions a Horizon has
//! (`docs/api/stability.md`). Every function the game offers mods has the
//! level it arrived at; a Horizon serves every level up to its [`LEVEL`].
//! A mod needs the level of the newest function it imports, so a mod that
//! calls a function this Horizon doesn't have is refused with "update
//! Horizon" instead of a linking error, and the registry lists each
//! version's level so the launcher can tell before it installs.

/// The newest level this Horizon serves.
pub const LEVEL: u32 = 7;

/// Every function the game offers mods, as `interface.function`, with its
/// level. Level 0 is the contract of Horizon 0.2.67 to 0.2.69. A new
/// function takes the next level and raises [`LEVEL`] (the `api_reference`
/// test fails until it is listed here).
    // rust: pub const FUNCTIONS: [(&str, u32); 46] = [
    // rust: ("log.write", 0),
    // rust: ("game.get-player", 0),
    // rust: ("game.get-clock", 0),
    // rust: ("chat.show", 0),
    // rust: ("hud.set-panel", 0),
    // rust: ("hud.clear", 0),
    // rust: ("storage.get", 0),
    // rust: ("storage.set", 0),
    // rust: ("storage.delete", 0),
    // rust: ("command.run", 0),
    // rust: ("ui.open-screen", 0),
    // rust: ("ui.close-screen", 0),
    // rust: ("ui.set-settings", 0),
    // rust: ("input.claim-items", 0),
    // rust: ("input.register-key", 0),
    // rust: ("input.held", 0),
    // rust: ("input.poll", 0),
    // rust: ("input.claim-wheel", 0),
    // rust: ("input.mapping", 0),
    // rust: ("input.clicks-per-second", 0),
    // rust: ("render.set-hud", 0),
    // rust: ("render.gui-size", 0),
    // rust: ("render.shake", 0),
    // rust: ("render.set-corner", 0),
    // rust: ("render.clear-corner", 0),
    // rust: ("render.text-width", 0),
    // rust: ("render.frame-stats", 0),
    // rust: ("render.set-zoom", 0),
    // rust: ("render.set-minimap", 1),
    // rust: ("players.online", 1),
    // rust: ("players.tell", 1),
    // rust: ("players.broadcast", 1),
    // rust: ("game.raycast", 2),
    // rust: ("command.run-quiet", 3),
    // rust: ("world.get-block", 4),
    // rust: ("world.get-biome", 4),
    // rust: ("world.set-blocks", 4),
    // rust: ("recipes.items", 5),
    // rust: ("recipes.all", 5),
    // rust: ("recipes.known", 5),
    // rust: ("browser.set-items", 6),
    // rust: ("browser.poll", 6),
    // rust: ("browser.set-recipes", 6),
    // rust: ("recipes.place", 6),
    // rust: ("recipes.give", 6),
    // rust: ("render.set-far-terrain", 7),
    // rust: ];

/// What the game's program carries so the launcher can read its level
/// without running it: `horizon-mod-api-level:0001;` (four digits). A
/// program from before the mark serves level 0.
    // rust: pub const MARK: [u8; 27] = {
    // rust: let mut mark = *b"horizon-mod-api-level:0000;";
    // rust: let mut level = LEVEL;
    // rust: let mut i = 25;
    // rust: while level > 0 {
    // rust: mark[i] = b'0' + (level % 10) as u8;
    // rust: level /= 10;
    // rust: i -= 1;
}
    // rust: mark
}

/// The level a program's bytes carry in their [`MARK`], if any.
pub fn read_mark(program: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = &MARK[..22];
    // rust: program
    // rust: .windows(MARK.len())
    // rust: .filter(|w| w.starts_with(prefix) && w[26] == b';')
    // rust: .find_map(|w| std::str::from_utf8(&w[22..26]).ok()?.parse().ok())
}

/// A function's level; None for one this Horizon doesn't have.
pub fn level_of(function: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FUNCTIONS
    // rust: .iter()
    // rust: .find(|(name, _)| *name == function)
    // rust: .map(|&(_, level)| level)
}

/// The level a mod needs, from the functions it imports (as [`imports`]
/// names them): its newest function's. A function this Horizon doesn't
/// know comes from a newer one, so it needs more than [`LEVEL`]; that
/// function is returned with it, for the message.
    // rust: pub fn needed<'a>(imports: impl IntoIterator<Item = &'a str>) -> (u32, Option<&'a str>) {
    // rust: let mut needed = (0, None);
    // rust: for name in imports {
    // rust: match level_of(name) {
    // rust: Some(level) if level > needed.0 => needed = (level, Some(name)),
    // rust: Some(_) => {}
    // rust: None => return (LEVEL + 1, Some(name)),
}
}
    // rust: needed
}

/// Why this Horizon can't run a mod that needs `level`, or None when it can.
pub fn too_new(level: u32, function: ?[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (level > LEVEL).then(|| {
    // rust: let uses = function.map_or(String::new(), |f| format!(" (it uses {f})"));
    // rust: format!("made for a newer Horizon{uses}: update Horizon to run it")
    // rust: })
}

/// The functions a mod's component imports from Horizon (`horizon:mods/*`),
/// as `interface.function`, in the component's order.
pub fn imports(wasm: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use wasmparser::{
    // rust: Parser, Payload, Validator, WasmFeatures, component_types::ComponentEntityType,
}
    // rust: let types = Validator::new_with_features(WasmFeatures::all())
    // rust: .validate_all(wasm)
    // rust: .map_err(|e| format!("not a component: {e}"))?;
    // rust: let types = types.as_ref();
    // rust: let mut out = Vec::new();
    // rust: for payload in Parser::new(0).parse_all(wasm) {
    // rust: let Payload::ComponentImportSection(section) = payload.map_err(|e| e.to_string())? else {
    // rust: continue;
}
    // rust: for import in section {
    // rust: let name = import.map_err(|e| e.to_string())?.name.name;
            // `horizon:mods/render@0.1.0` → `render`.
    // rust: let Some(interface) = name.strip_prefix("horizon:mods/") else {
    // rust: continue;
}
    // rust: let interface = interface.split('@').next().unwrap_or(interface);
    // rust: let Some(item) = types.component_item_for_import(name) else {
    // rust: continue;
}
    // rust: if let ComponentEntityType::Instance(id) = item.ty {
    // rust: for (function, export) in &types[id].exports {
    // rust: if matches!(export.ty, ComponentEntityType::Func(_)) {
    // rust: out.push(format!("{interface}.{function}"));
}
}
}
}
}
    // rust: Ok(out)
}

    // rust: mod tests {
//     use super::*;

pub fn levels_are_listed_once_and_up_to_this_horizons() void {
}
    // rust: for (i, (name, level)) in FUNCTIONS.iter().enumerate() {
    // rust: assert!(*level <= LEVEL, "{name}");
    // rust: assert!(
    // rust: FUNCTIONS[..i].iter().all(|(other, _)| other != name),
    // rust: "{name} twice"
    // rust: );
}
    // rust: assert!(FUNCTIONS.iter().any(|&(_, level)| level == LEVEL));
}

pub fn the_mark_carries_the_level() void {
}
    // rust: assert_eq!(read_mark(&MARK), Some(LEVEL));
    // rust: let mut program = b"\0\x7fELF horizon-mod-api-level: horizon-mod-api-level:".to_vec();
    // rust: program.extend_from_slice(&MARK);
    // rust: program.extend_from_slice(b"\0rest");
    // rust: assert_eq!(read_mark(&program), Some(LEVEL));
    // rust: assert_eq!(read_mark(b"horizon-mod-api-level:12;"), None);
    // rust: assert_eq!(read_mark(b"no mark"), None);
}

pub fn a_mod_needs_its_newest_function() void {
}
    // rust: assert_eq!(needed(["log.write", "hud.set-panel"]), (0, None));
    // rust: assert_eq!(
    // rust: needed(["log.write", "render.set-minimap", "hud.clear"]),
    // rust: (1, Some("render.set-minimap"))
    // rust: );
    // rust: assert_eq!(
    // rust: needed(["render.set-minimap", "render.set-sky"]),
    // rust: (LEVEL + 1, Some("render.set-sky"))
    // rust: );
    // rust: assert_eq!(too_new(LEVEL, None), None);
    // rust: assert_eq!(
    // rust: too_new(LEVEL + 1, Some("render.set-sky")).as_deref(),
    // rust: Some("made for a newer Horizon (it uses render.set-sky): update Horizon to run it")
    // rust: );
}
}
