//! Transpiled from Horizon Rust crate
//! Module: horizon-client_blockctl
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Control-socket block commands for scripted tests: `setblock`, `fill`,
//! `getblock` and `container` (list or put items in a block entity).
// use super::Game;
// use horizon_client::{Result, items::ItemStack};
// use horizon_world::{chunk::BlockState, registry::BlockStateId};
// use serde_json::{Value, json};
// use std::collections::BTreeMap;

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "setblock X Y Z BLOCK[props]    set a block with neighbour updates",
    // rust: "fill X1 Y1 Z1 X2 Y2 Z2 BLOCK   set a box of blocks",
    // rust: "getblock X Y Z                 block state at a position",
    // rust: "container X Y Z [ITEM COUNT]   list a container, or add items to it",
    // rust: ];

pub fn parse_state(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (name, props) = match text.split_once('[') {
    // rust: Some((name, rest)) => (name, rest.trim_end_matches(']')),
    // rust: None => (text, ""),
}
    // rust: let name = if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let mut properties = BTreeMap::new();
    // rust: for pair in props.split(',').filter(|p| !p.is_empty()) {
    // rust: let (k, v) = pair.split_once('=').ok_or("properties are key=value")?;
    // rust: properties.insert(k.to_owned(), v.to_owned());
}
    // rust: Ok(BlockState {
    // rust: name,
    // rust: properties: properties.into(),
    // rust: })
}

    // rust: impl Game<'_> {
pub fn state_text(self: *Self, state: BlockStateId) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(s) = self.pack.assets.registry.state(state) else {
    // rust: return "?".into();
}
    // rust: if s.properties.is_empty() {
    // rust: return s.name.clone();
}
    // rust: let props: Vec<String> = s
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(k, v)| format!("{k}={v}"))
    // rust: .collect();
    // rust: format!("{}[{}]", s.name, props.join(","))
}
pub fn put_block(self: *Self, pos: [i32; 3], state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: self.world.block_entities.remove(&(pos[0], pos[1], pos[2]));
    // rust: self.level_set(pos, state)?;
    // rust: if let Some(entity) = self.new_block_entity(&name) {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert((pos[0], pos[1], pos[2]), entity);
}
    // rust: Ok(())
}
    /// Block commands; None when `words[0]` is not one of them.
    // rust: pub(super) fn block_command(&mut self, words: &[&str]) -> Result<Option<Value>> {
    // rust: let ours = matches!(
    // rust: words.first(),
    // rust: Some(&("setblock" | "fill" | "getblock" | "container"))
    // rust: );
        // Single player on its server thread: the world is the server's, so
        // the command runs there, in the owner's level, and the client hears
        // of it like any change.
    // rust: if ours && let Some(server) = &self.integrated {
    // rust: let owned: Vec<String> = words.iter().map(|w| (*w).to_owned()).collect();
    // rust: return server
    // rust: .call(move |g| {
    // rust: let words: Vec<&str> = owned.iter().map(String::as_str).collect();
    // rust: g.in_owner_level(|g| g.block_command(&words).map_err(|e| e.to_string()))
    // rust: })
    // rust: .ok_or(super::integrated::NO_ANSWER)?
    // rust: .map_err(Into::into);
}
        // Another server's world changes only through its own commands, which
        // it checks as the player's; `getblock` and `container` read what this
        // client has of it.
    // rust: if self.remote.is_some() && matches!(words.first(), Some(&("setblock" | "fill"))) {
    // rust: self.send_chat(&format!("/{}", words.join(" ")));
    // rust: return Ok(Some(json!({ "ok": true, "sent": true })));
}
    // rust: let int = |i: usize| -> Result<i32> {
    // rust: Ok(words
    // rust: .get(i)
    // rust: .ok_or_else(|| format!("missing argument {i}"))?
    // rust: .parse()?)
}
    // rust: match words[0] {
    // rust: "setblock" => {
    // rust: let pos = [int(1)?, int(2)?, int(3)?];
    // rust: let state = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .resolve(&parse_state(words.get(4).ok_or("missing block")?)?)?;
    // rust: self.put_block(pos, state)?;
    // rust: Ok(Some(
    // rust: json!({ "ok": true, "block": self.state_text(self.world.block(pos[0], pos[1], pos[2])) }),
    // rust: ))
}
    // rust: "fill" => {
    // rust: let (a, b) = ([int(1)?, int(2)?, int(3)?], [int(4)?, int(5)?, int(6)?]);
    // rust: let state = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .resolve(&parse_state(words.get(7).ok_or("missing block")?)?)?;
    // rust: let mut count = 0;
    // rust: for x in a[0].min(b[0])..=a[0].max(b[0]) {
    // rust: for y in a[1].min(b[1])..=a[1].max(b[1]) {
    // rust: for z in a[2].min(b[2])..=a[2].max(b[2]) {
    // rust: self.put_block([x, y, z], state)?;
    // rust: count += 1;
}
}
}
    // rust: Ok(Some(json!({ "ok": true, "count": count })))
}
    // rust: "getblock" => {
    // rust: let pos = [int(1)?, int(2)?, int(3)?];
    // rust: Ok(Some(
    // rust: json!({ "block": self.state_text(self.world.block(pos[0], pos[1], pos[2])) }),
    // rust: ))
}
    // rust: "container" => {
    // rust: let key = (int(1)?, int(2)?, int(3)?);
    // rust: if let Some(item) = words.get(4) {
    // rust: let item = if item.contains(':') {
    // rust: (*item).to_owned()
    // rust: } else {
    // rust: format!("minecraft:{item}")
}
    // rust: let count: u32 = words.get(5).map_or(Ok(1), |c| c.parse())?;
    // rust: let entity = self
    // rust: .world
    // rust: .block_entities
    // rust: .get_mut(&key)
    // rust: .ok_or("no container there")?;
    // rust: let slot = entity
    // rust: .slots_mut()
    // rust: .iter_mut()
    // rust: .find(|s| s.is_none())
    // rust: .ok_or("container is full")?;
    // rust: *slot = Some(ItemStack {
    // rust: item: item.as_str().into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
}
    // rust: let entity = self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&key)
    // rust: .ok_or("no container there")?;
    // rust: let slots: Vec<Value> = entity
    // rust: .clone()
    // rust: .slots_mut()
    // rust: .iter()
    // rust: .map(|s| {
    // rust: s.as_ref().map_or(
    // rust: Value::Null,
    // rust: |s| json!({ "item": &*s.item, "count": s.count }),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: Ok(Some(json!({ "slots": slots })))
}
    // rust: _ => Ok(None),
}
}
}
