//! Transpiled from Horizon Rust crate
package horizon_client_native_fluids

import "core:fmt"
import "core:mem"
import "core:math"

// Fluids of a block for native server mods (docs/native-mods.md, API 54):
// the tanks a mod block declared through `native_block_entity_fluids`, and a
// cauldron, read through a side, filled and drained in millibuckets. They act
// where the world is simulated, never on a client's copy, and only on the
// level in place, which the readers name by their `dimension`
// (`minecraft:overworld`), as `native_set_block` does.
// use super::Game;
// use horizon_client::containers::ModFluidTanks;
// use horizon_core::geometry::Direction;
// use horizon_world::nbt::{Compound, JavaString, Tag};
// use std::sync::Arc;

// A tank as a side reaches it (`native_fluid_tanks`).
NativeFluidTank :: struct {
    // Its number, for the mod's own use.
    tank: uint,
    // `minecraft:water`, `minecraft:lava` or a mod's own (`create:honey`);
    // none when the tank is empty.
    fluid: Maybe(string),
    // In millibuckets: a bucket is a thousand.
    amount: i32,
    capacity: i32,
    // Whether a fill may reach it through this side.
    can_fill: bool,
    // Whether a drain may take it through this side.
    can_drain: bool,
}

// A fluid a tank may hold: vanilla's water and lava, or a mod's own
// (`create:chocolate`), any id in a namespace other than `minecraft`, of
// vanilla's identifier characters. A mod's fluid lives in tanks only, the
// world has vanilla's alone, and its mod draws it; a cauldron takes only
// water and lava. Variants of one fluid (a potion's kinds) are fluids of
// their own (`create:potion/healing`): equal ids merge, others don't.
tank_fluid :: proc(fluid: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(fluid, "minecraft:water" | "minecraft:lava") {
    // rust: return true;
}
    // rust: let ok = |b: u8| b.is_ascii_lowercase() || b.is_ascii_digit() || b"_.-".contains(&b);
    // rust: fluid.split_once(':').is_some_and(|(namespace, path)| {
    // rust: !namespace.is_empty()
    // rust: && namespace != "minecraft"
    // rust: && namespace.bytes().all(ok)
    // rust: && !path.is_empty()
    // rust: && path.bytes().all(|b| ok(b) || b == b'/')
    // rust: })
}

// A cauldron level's contents: level `level` holds `level * 1000 / 3`
// millibuckets (`LayeredCauldronBlock` has no finer unit than a bottle's
// third of a bucket).
third :: proc(level: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: i32::from(level) * 1000 / 3
}

// The level a fill of `given` millibuckets raises `level` to: a level
// rises only while its whole third fits what is left of the give, so no
// sum ever grows past a bucket.
fill_level :: proc(level: u8, given: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut new = level;
    // rust: while new < 3 && third(new + 1) - third(level) <= given {
    // rust: new += 1;
}
    // rust: new
}

// What a drain of at most `amount` takes out of water level `level`, in
// whole thirds — never more than was asked, as `IFluidHandler.drain`'s
// `maxDrain`: less than the topmost whole third takes nothing. Answers
// what it took and the level it left.
drain_take :: proc(level: u8, amount: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut taken = 0;
    // rust: let mut left = level;
    // rust: while left > 0 {
    // rust: let step = third(left) - third(left - 1);
    // rust: if taken + step > amount {
    // rust: break;
}
    // rust: taken += step;
    // rust: left -= 1;
}
    // rust: (taken, left)
}

// What holds fluids at a position: a mod block's tanks, or a cauldron
// (`CauldronFluids`). An empty cauldron is fillable; powder snow is not a
// fluid (`FluidKind` has none), so a powder snow cauldron holds none.
FluidAt :: enum {
    // A mod block's tanks, and its block id (`mymod:tank`).
    Mod {,
    tanks: Arc<ModFluidTanks>,
    block: String,
    // rust: },
    Cauldron(CauldronFluids),
}
CauldronFluids :: enum {
    Empty,
    Water(u8),
    Lava,
}

// The saved state of one tank: its fluid and amount in millibuckets.
    // rust: type Tank = (Option<String>, i32);

// The tanks in `nbt`, each `n` long: missing entries read as empty, and a
// save with more tanks than the block now declares keeps the ones that
// still exist (a mod update that shrank its tanks loses nothing it kept).
read_tanks :: proc(nbt: ^Compound, n: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let list = match nbt.get(&JavaString::from("fluids")) {
    // rust: Some(Tag::List(list)) => list,
    // rust: _ => return vec![(None, 0); n],
}
    // rust: let read: Vec<Tank> = list
    // rust: .iter()
    // rust: .take(n)
    // rust: .map(|tag| match tag {
    // rust: Tag::Compound(map) => (
    // rust: match map.get(&JavaString::from("Fluid")) {
    // rust: Some(Tag::String(fluid)) if fluid.to_string_lossy() != "minecraft:empty" => {
    // rust: Some(fluid.to_string_lossy())
}
    // rust: _ => None,
    // rust: },
    // rust: match map.get(&JavaString::from("Amount")) {
    // rust: Some(Tag::Int(amount)) => *amount,
    // rust: _ => 0,
    // rust: },
    // rust: ),
    // rust: _ => (None, 0),
    // rust: })
    // rust: .collect();
    // rust: let mut tanks = read;
    // rust: tanks.resize(n, (None, 0));
    // rust: tanks
}

// `read_tanks`'s writer: the list back into `nbt`, an empty tank as
// `minecraft:empty` so the tank numbers stay in place.
write_tanks :: proc(nbt: ^Compound, tanks: ^[Tank]) {
}
    // rust: let list = tanks
    // rust: .iter()
    // rust: .map(|&(ref fluid, amount)| {
    // rust: let mut map = Compound::new();
    // rust: map.insert(
    // rust: JavaString::from("Fluid"),
    // rust: Tag::String(JavaString::from(
    // rust: fluid.as_deref().unwrap_or("minecraft:empty"),
    // rust: )),
    // rust: );
    // rust: map.insert(JavaString::from("Amount"), Tag::Int(amount));
    // rust: Tag::Compound(map)
    // rust: })
    // rust: .collect();
    // rust: nbt.insert(JavaString::from("fluids"), Tag::List(list));
}

// Fills `state` from `amount` of `fluid`: first the tanks holding it, then
// empty ones, by the side `reached` and only where `accepts` lets it in
// (`native_block_entity_accepts_fluid`); what did not fit. The choice is
// made again in both passes, as `HopperBlockEntity.addItem` tries its slots.
    // rust: fn fill_tanks(
    // rust: tanks: &ModFluidTanks,
    // rust: state: &mut [Tank],
    // rust: reached: &[usize],
    // rust: fluid: &str,
    // rust: amount: i32,
    // rust: accepts: impl Fn(usize) -> bool,
    // rust: ) -> i32 {
    // rust: let n = tanks.tanks.len();
    // rust: let mut left = amount.max(0);
    // rust: for pass in 0..2 {
    // rust: for &tank in reached {
    // rust: if left == 0 || !tanks.inputs.contains(&tank) || tank >= n {
    // rust: continue;
}
    // rust: if !accepts(tank) {
    // rust: continue;
}
    // rust: let entry = &mut state[tank];
    // rust: let fits = match pass {
    // rust: 0 => entry.0.as_deref() == Some(fluid),
    // rust: _ => entry.0.is_none(),
}
    // rust: if !fits {
    // rust: continue;
}
    // rust: let room = tanks.tanks[tank] - entry.1;
    // rust: if room <= 0 {
    // rust: continue;
}
    // rust: let add = room.min(left);
    // rust: entry.1 += add;
    // rust: left -= add;
    // rust: entry.0 = Some(fluid.to_owned());
}
}
    // rust: left
}

// How much of `fluid` the side `tanks` names has room for: the fillable
// tanks holding it or none, and only where `accepts` lets it in
// (`native_block_entity_accepts_fluid`).
tank_room :: proc(tanks: ^[NativeFluidTank], fluid: string, accepts: impl Fn(uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: tanks
    // rust: .iter()
    // rust: .filter(|t| t.can_fill && t.fluid.as_deref().is_none_or(|f| f == fluid) && accepts(t.tank))
    // rust: .fold(0_i32, |room, t| {
    // rust: room.saturating_add((t.capacity - t.amount).max(0))
    // rust: })
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    // What holds fluids at `pos` in the level in place, `dimension`: a mod
    // block's tanks (its block entity's, and not the placeholder standing in
    // while it ticks), or a cauldron.
native_fluid_at :: proc(self: ^Self, dimension: string, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.native_simulates() || dimension != self.dim.id() {
    // rust: return None;
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if let Some(tanks) = self.world.block_entities.mod_fluids(state.0) {
    // rust: let block = self.pack.assets.registry.state(state)?.name.to_string();
            // The block entity is out of the world while it ticks.
    // rust: return matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(horizon_client::containers::BlockEntity::Mod(m)) if !m.id.is_empty()
    // rust: )
    // rust: .then(|| FluidAt::Mod {
    // rust: tanks: Arc::clone(tanks),
    // rust: block,
    // rust: });
}
    // rust: let info = self.pack.assets.registry.state(state)?;
    // rust: match &*info.name {
    // rust: "minecraft:cauldron" => Some(FluidAt::Cauldron(CauldronFluids::Empty)),
    // rust: "minecraft:water_cauldron" => {
    // rust: let level = info
    // rust: .properties
    // rust: .get("level")
    // rust: .and_then(|l| l.parse::<u8>().ok())?;
    // rust: Some(FluidAt::Cauldron(CauldronFluids::Water(level)))
}
    // rust: "minecraft:lava_cauldron" => Some(FluidAt::Cauldron(CauldronFluids::Lava)),
    // rust: _ => None,
}
}
    // The cauldron at `pos` set to `water` at `level` (0 is empty), or to
    // lava. Whether it changed.
cauldron_set :: proc(self: ^Self, pos: [i32; 3], water: Maybe(u8), lava: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (name, level) = if lava {
    // rust: ("minecraft:lava_cauldron", None)
    // rust: } else {
    // rust: match water {
    // rust: Some(level) => ("minecraft:water_cauldron", Some(level)),
    // rust: None => ("minecraft:cauldron", None),
}
}
    // rust: let mut properties = std::collections::BTreeMap::new();
    // rust: if let Some(level) = level {
    // rust: properties.insert("level".to_owned(), level.to_string());
}
    // rust: let state = horizon_world::chunk::BlockState {
    // rust: name: name.to_owned(),
    // rust: properties: properties.into(),
}
    // rust: match self.pack.assets.registry.resolve(&state) {
    // rust: Ok(id) => self.level_set(pos, id).is_ok(),
    // rust: Err(_) => false,
}
}
    // Whether tank `tank` of the mod block `block` takes `fluid`: a mod's
    // answer to `native_block_entity_accepts_fluid`, true where none
    // refuses it.
native_fluid_accepts :: proc(self: ^Self, block: string, tank: uint, fluid: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut cancel = false;
    // rust: self.native_block_entity_accepts_fluid(block, tank, fluid, &mut cancel);
    // rust: !cancel
}
    // `native_fluid_insert`: up to `amount` millibuckets of `fluid`
    // (`minecraft:water`, `minecraft:lava`, or since API
    // @API:mod_fluids@ a mod's own, `create:chocolate`) into the block at
    // `pos`, through its side `face`, in the level in place: a mod block's
    // tanks first those with the same fluid, then empty ones, by the sides
    // and tanks its table gave and every fillable tank that accepts the
    // fluid (`native_block_entity_accepts_fluid`); a cauldron by thirds of a
    // bucket, a lava one only whole, and none of a mod's fluid. What did not
    // fit. API 54.
    // rust: pub(in crate::game) fn native_fluid_insert(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: fluid: &str,
    // rust: amount: i32,
    // rust: ) -> i32 {
    // rust: if !tank_fluid(fluid) {
    // rust: return amount;
}
    // rust: if !self.native_simulates() {
    // rust: return amount;
}
    // rust: match self.native_fluid_at(self.dim.id(), pos) {
    // rust: Some(FluidAt::Mod { tanks, block }) => {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let n = tanks.tanks.len();
    // rust: let reached = tanks.faces[face as usize].clone();
    // rust: let mut state = {
    // rust: let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get(&key)
    // rust: else {
    // rust: return amount;
}
    // rust: read_tanks(&m.nbt, n)
}
    // rust: let left = fill_tanks(&tanks, &mut state, &reached, fluid, amount, |tank| {
    // rust: self.native_fluid_accepts(&block, tank, fluid)
    // rust: });
    // rust: if left < amount {
    // rust: let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get_mut(&key)
    // rust: else {
    // rust: return amount;
}
    // rust: write_tanks(&mut m.nbt, &state);
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
}
    // rust: left
}
    // rust: Some(FluidAt::Cauldron(kind)) => match (kind, fluid) {
    // rust: (CauldronFluids::Empty, "minecraft:water")
    // rust: | (CauldronFluids::Water(_), "minecraft:water") => {
    // rust: let level = match kind {
    // rust: CauldronFluids::Water(level) => level,
    // rust: _ => 0,
}
    // rust: let given = amount.max(0);
    // rust: let new_level = fill_level(level, given);
    // rust: let consumed = third(new_level) - third(level);
    // rust: if new_level > level && self.cauldron_set(pos, Some(new_level), false) {
    // rust: given - consumed
    // rust: } else {
    // rust: amount
}
}
    // rust: (CauldronFluids::Empty, "minecraft:lava") => {
    // rust: if amount >= 1000 && self.cauldron_set(pos, None, true) {
    // rust: amount - 1000
    // rust: } else {
    // rust: amount
}
}
                // A full lava cauldron takes nothing, and water into lava
                // would turn it to stone in vanilla's world, not in a tank.
    // rust: _ => amount,
    // rust: },
    // rust: None => amount,
}
}
    // The tanks of the block at `pos` in the level in place, `dimension`,
    // that its side `face` reaches, with their fluids and amounts. None
    // where no tanks are: another dimension, a chunk that isn't loaded, a
    // block without tanks, or the mod block entity ticking now (it's out of
    // the world). A cauldron reads as one tank of a bucket's capacity. API 54.
    // rust: pub(in crate::game) fn native_fluid_tanks(
    // rust: &self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> Option<Vec<NativeFluidTank>> {
    // rust: match self.native_fluid_at(dimension, pos)? {
    // rust: FluidAt::Mod { tanks, .. } => {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let state = {
    // rust: let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get(&key)
    // rust: else {
    // rust: return None;
}
    // rust: read_tanks(&m.nbt, tanks.tanks.len())
}
    // rust: Some(
    // rust: tanks.faces[face as usize]
    // rust: .iter()
    // rust: .map(|&tank| {
    // rust: let (ref fluid, amount) = state[tank];
    // rust: NativeFluidTank {
    // rust: tank,
    // rust: fluid: fluid.clone(),
    // rust: amount,
    // rust: capacity: tanks.tanks[tank],
    // rust: can_fill: tanks.inputs.contains(&tank),
    // rust: can_drain: tanks.outputs.contains(&tank),
}
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // rust: FluidAt::Cauldron(kind) => {
    // rust: let (fluid, amount, can_fill) = match kind {
    // rust: CauldronFluids::Empty => (None, 0, true),
    // rust: CauldronFluids::Water(level) => {
    // rust: (Some("minecraft:water"), third(level), level < 3)
}
    // rust: CauldronFluids::Lava => (Some("minecraft:lava"), 1000, false),
}
    // rust: Some(vec![NativeFluidTank {
    // rust: tank: 0,
    // rust: fluid: fluid.map(str::to_owned),
    // rust: amount,
    // rust: capacity: 1000,
    // rust: can_fill,
    // rust: can_drain: amount > 0,
    // rust: }])
}
}
}
    // Takes up to `amount` millibuckets out of the block at `pos` in the
    // level in place, `dimension`, through its side `face`: a mod block's
    // drainable tanks, one fluid only (the first that's there), or a
    // cauldron, which drains in thirds of a bucket and a lava one only
    // whole. The fluid and how much; none when the side reaches nothing.
    // API 54.
    // rust: pub(in crate::game) fn native_fluid_extract(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: amount: i32,
    // rust: ) -> Option<(String, i32)> {
    // rust: self.fluid_take(dimension, pos, face, amount)
    // rust: .map(|(fluid, taken, _)| (fluid, taken))
}
    // `native_fluid_extract`'s drain, remembering what left which tank, so a
    // move can put it back without the fill sides' leave: an empty list is a
    // cauldron, whose own fill takes it back.
    // rust: fn fluid_take(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: amount: i32,
    // rust: ) -> Option<(String, i32, Vec<(usize, i32)>)> {
    // rust: if amount <= 0 {
    // rust: return None;
}
    // rust: match self.native_fluid_at(dimension, pos)? {
    // rust: FluidAt::Mod { tanks, .. } => {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let n = tanks.tanks.len();
    // rust: let mut state = {
    // rust: let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get(&key)
    // rust: else {
    // rust: return None;
}
    // rust: read_tanks(&m.nbt, n)
}
                // The first drainable tank's fluid is all this call takes.
    // rust: let fluid: Option<String> = tanks.faces[face as usize]
    // rust: .iter()
    // rust: .filter(|&&tank| tanks.outputs.contains(&tank) && tank < n)
    // rust: .find(|&&tank| state[tank].1 > 0)
    // rust: .map(|&tank| state[tank].0.clone())?;
    // rust: let mut want = amount;
    // rust: let mut out = Vec::new();
    // rust: for &tank in &tanks.faces[face as usize] {
    // rust: if want == 0 || !tanks.outputs.contains(&tank) || tank >= n {
    // rust: continue;
}
    // rust: if state[tank].0 != fluid {
    // rust: continue;
}
    // rust: let take = want.min(state[tank].1);
    // rust: state[tank].1 -= take;
    // rust: if state[tank].1 == 0 {
    // rust: state[tank].0 = None;
}
    // rust: want -= take;
    // rust: out.push((tank, take));
}
    // rust: let taken = amount - want;
    // rust: if taken == 0 {
    // rust: return None;
}
    // rust: let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get_mut(&key)
    // rust: else {
    // rust: return None;
}
    // rust: write_tanks(&mut m.nbt, &state);
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
    // rust: Some((fluid?, taken, out))
}
    // rust: FluidAt::Cauldron(CauldronFluids::Water(level)) => {
                // A cauldron has no finer unit than its bottle's third, and
                // never hands out more than was asked: less than the topmost
                // whole third gives nothing.
    // rust: let (taken, left) = drain_take(level, amount);
    // rust: if taken > 0 && self.cauldron_set(pos, (left > 0).then_some(left), false) {
    // rust: Some(("minecraft:water".to_owned(), taken, Vec::new()))
    // rust: } else {
    // rust: None
}
}
    // rust: FluidAt::Cauldron(CauldronFluids::Lava) => (amount >= 1000
    // rust: && self.cauldron_set(pos, None, false))
    // rust: .then(|| ("minecraft:lava".to_owned(), 1000, Vec::new())),
    // rust: FluidAt::Cauldron(CauldronFluids::Empty) => None,
}
}
    // Moves up to `max` millibuckets from the block at `from`, through its
    // side `from_face`, into the one at `to`, through its side `to_face`, as
    // `native_move_items` moves items: what the target won't take goes back
    // into the source, so none is lost — a cauldron's whole thirds included.
    // The fluid and how much moved; none where `native_fluid_tanks` is none
    // at `from`, where nothing drainable is, where no block holds fluids at
    // `to` or it has no room for that fluid (a tank that refuses it,
    // `native_block_entity_accepts_fluid`, has none), and within one block.
    // The source is asked for no more than the target's room. API 55.
    // rust: pub(in crate::game) fn native_move_fluids(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: from: [i32; 3],
    // rust: from_face: Direction,
    // rust: to: [i32; 3],
    // rust: to_face: Direction,
    // rust: max: i32,
    // rust: ) -> Option<(String, i32)> {
    // rust: if from == to {
    // rust: return None;
}
        // Ask the source for no more than the target has room for: a
        // cauldron drains in whole thirds and fills back only by them, so a
        // part the target refused couldn't always go back.
    // rust: let max = max.min(self.fluid_room(dimension, from, from_face, to, to_face)?);
    // rust: let (fluid, taken, receipt) = self.fluid_take(dimension, from, from_face, max)?;
    // rust: let left = self.native_fluid_insert(to, to_face, &fluid, taken);
    // rust: if left > 0 {
            // What the target wouldn't take goes back where it came from,
            // past the fill sides' leave: the tanks just gave it up, so they
            // have the room, and a cauldron levels back up by the thirds it
            // gave. What came back isn't moved: the answer is what the
            // target kept.
    // rust: let all_back = if receipt.is_empty() {
    // rust: self.native_fluid_insert(from, from_face, &fluid, left) == 0
    // rust: } else {
    // rust: self.fluid_return(dimension, from, &fluid, left, &receipt)
}
    // rust: if !all_back {
    // rust: log::warn!("Horizon: a fluid move left {left} mB of {fluid} nowhere to go");
}
}
    // rust: Some((fluid, taken - left))
}
    // How much of the fluid `from`'s side `from_face` would give first fits
    // into `to` through `to_face`: the room of its fillable tanks holding
    // that fluid or none. None when `from` gives nothing or `to` holds no
    // fluids.
    // rust: fn fluid_room(
    // rust: &self,
    // rust: dimension: &str,
    // rust: from: [i32; 3],
    // rust: from_face: Direction,
    // rust: to: [i32; 3],
    // rust: to_face: Direction,
    // rust: ) -> Option<i32> {
    // rust: let fluid = self
    // rust: .native_fluid_tanks(dimension, from, from_face)?
    // rust: .into_iter()
    // rust: .find(|t| t.can_drain && t.amount > 0)?
    // rust: .fluid?;
    // rust: let block = match self.native_fluid_at(dimension, to)? {
    // rust: FluidAt::Mod { block, .. } => Some(block),
    // rust: FluidAt::Cauldron(_) => None,
}
        // A cauldron reports itself fillable, but holds only vanilla's fluids:
        // no room for a mod's, so a move answers none rather than draining
        // and putting it all back.
    // rust: if block.is_none() && !matches!(fluid.as_str(), "minecraft:water" | "minecraft:lava") {
    // rust: return Some(0);
}
    // rust: let room = tank_room(
    // rust: &self.native_fluid_tanks(dimension, to, to_face)?,
    // rust: &fluid,
    // rust: |tank| {
    // rust: block
    // rust: .as_deref()
    // rust: .is_none_or(|block| self.native_fluid_accepts(block, tank, &fluid))
    // rust: },
    // rust: );
    // rust: Some(room)
}
    // Puts `amount` of `fluid` back into the tanks `receipt` names, drained
    // moments ago: their room is exactly what left them. Whether it all went
    // back.
    // rust: fn fluid_return(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: fluid: &str,
    // rust: mut amount: i32,
    // rust: receipt: &[(usize, i32)],
    // rust: ) -> bool {
    // rust: let Some(FluidAt::Mod { tanks, .. }) = self.native_fluid_at(dimension, pos) else {
    // rust: return false;
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(horizon_client::containers::BlockEntity::Mod(m)) =
    // rust: self.world.block_entities.get_mut(&key)
    // rust: else {
    // rust: return false;
}
        // The declared count, as `fluid_take` read them: a shorter read
        // would write the other tanks away.
    // rust: let n = tanks.tanks.len();
    // rust: let mut state = read_tanks(&m.nbt, n);
    // rust: for &(tank, took) in receipt {
    // rust: let give = took.min(amount);
    // rust: if give <= 0 || tank >= n {
    // rust: continue;
}
    // rust: state[tank].1 += give;
    // rust: state[tank].0 = Some(fluid.to_owned());
    // rust: amount -= give;
}
    // rust: write_tanks(&mut m.nbt, &state);
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
    // rust: amount == 0
}
}

    // rust: mod tests {
//     use super::*;

    // Tanks hold vanilla's two fluids and any of a mod's own; not a
    // made-up vanilla one, nor a name that isn't an identifier.
a_tank_holds_vanilla_fluids_and_mods_own :: proc() {
}
    // rust: for fluid in [
    // rust: "minecraft:water",
    // rust: "minecraft:lava",
    // rust: "create:chocolate",
    // rust: "create:potion/healing",
    // rust: ] {
    // rust: assert!(tank_fluid(fluid), "{fluid}");
}
    // rust: for fluid in [
    // rust: "minecraft:milk",
    // rust: "minecraft:empty",
    // rust: "chocolate",
    // rust: ":x",
    // rust: "create:",
    // rust: "Create:honey",
    // rust: "create:honey cake",
    // rust: ] {
    // rust: assert!(!tank_fluid(fluid), "{fluid}");
}
}

a_cauldron_level_holds_a_third_of_a_bucket :: proc() {
}
    // rust: assert_eq!(third(1), 333);
    // rust: assert_eq!(third(2), 666);
    // rust: assert_eq!(third(3), 1000);
}

a_cauldron_never_hands_out_more_than_was_asked :: proc() {
}
        // The top third of a full cauldron is 334, then 333, 333.
    // rust: assert_eq!(drain_take(3, 1), (0, 3));
    // rust: assert_eq!(drain_take(3, 333), (0, 3));
    // rust: assert_eq!(drain_take(3, 334), (334, 2));
    // rust: assert_eq!(drain_take(3, 500), (334, 2));
    // rust: assert_eq!(drain_take(3, 666), (334, 2));
    // rust: assert_eq!(drain_take(3, 667), (667, 1));
    // rust: assert_eq!(drain_take(3, 1000), (1000, 0));
    // rust: assert_eq!(drain_take(1, 332), (0, 1));
    // rust: assert_eq!(drain_take(1, 333), (333, 0));
    // rust: assert_eq!(drain_take(1, i32::MAX), (333, 0));
}

a_cauldron_fill_stays_within_a_bucket_whatever_the_amount :: proc() {
}
    // rust: assert_eq!(fill_level(0, 332), 0);
    // rust: assert_eq!(fill_level(0, 333), 1);
    // rust: assert_eq!(fill_level(1, 332), 1);
    // rust: assert_eq!(fill_level(1, 333), 2);
    // rust: assert_eq!(fill_level(1, 666), 2);
    // rust: assert_eq!(fill_level(1, 667), 3);
    // rust: assert_eq!(fill_level(0, i32::MAX), 3);
    // rust: assert_eq!(fill_level(2, i32::MAX), 3);
}

tanks :: proc(list: ^[(Maybe(string)) {
}
    // rust: list.iter()
    // rust: .map(|&(fluid, amount)| (fluid.map(str::to_owned), amount))
    // rust: .collect()
}

tank_state_round_trips_through_nbt_and_missing_entries_read_empty :: proc() {
}
    // rust: let mut nbt = Compound::new();
    // rust: let state = tanks(&[(Some("minecraft:water"), 3334), (None, 0)]);
    // rust: write_tanks(&mut nbt, &state);
    // rust: assert_eq!(read_tanks(&nbt, 2), state);
        // A tank the save never heard of reads as empty, not as gone.
    // rust: let longer = read_tanks(&nbt, 3);
    // rust: assert_eq!(longer[2], (None, 0));
        // Anything else under `fluids` is the mod's own, not a tank list.
    // rust: nbt.insert(JavaString::from("fluids"), Tag::Int(0));
    // rust: assert_eq!(read_tanks(&nbt, 2), vec![(None, 0), (None, 0)]);
}

a_shrunk_tank_table_keeps_the_tanks_that_still_exist :: proc() {
}
        // A mod update that declares one tank where the save has two keeps
        // the first tank's contents, instead of reading all as empty and
        // writing the wipe back.
    // rust: let mut nbt = Compound::new();
    // rust: let saved = tanks(&[
    // rust: (Some("minecraft:water"), 4000),
    // rust: (Some("minecraft:lava"), 1000),
    // rust: ]);
    // rust: write_tanks(&mut nbt, &saved);
    // rust: assert_eq!(
    // rust: read_tanks(&nbt, 1),
    // rust: tanks(&[(Some("minecraft:water"), 4000)])
    // rust: );
}

a_receipts_room_is_what_left_its_tanks :: proc() {
}
        // The bookkeeping a move's put-back trusts: a receipt never names
        // more than its tanks held, so returning it always fits.
    // rust: let receipt = vec![(1usize, 333i32), (2, 100)];
    // rust: let held = tanks(&[
    // rust: (None, 0),
    // rust: (Some("minecraft:water"), 333),
    // rust: (Some("minecraft:water"), 100),
    // rust: ]);
    // rust: assert!(receipt.iter().all(|&(tank, took)| took <= held[tank].1));
    // rust: let mut after = held.clone();
    // rust: for &(tank, took) in &receipt {
    // rust: after[tank].1 -= took;
    // rust: if after[tank].1 == 0 {
    // rust: after[tank].0 = None;
}
}
    // rust: assert_eq!(after, tanks(&[(None, 0), (None, 0), (None, 0)]));
        // And putting it back restores exactly what was there.
    // rust: let mut back = after;
    // rust: for &(tank, took) in &receipt {
    // rust: back[tank].1 += took;
    // rust: back[tank].0 = Some("minecraft:water".to_owned());
}
    // rust: assert_eq!(back, held);
}

tank_table :: proc(capacities: ^[i32], inputs: ^[uint]) -> M {
    // Ported from Horizon
    return {}
}
    // rust: ModFluidTanks {
    // rust: tanks: capacities.to_vec(),
    // rust: inputs: inputs.to_vec(),
    // rust: ..Default::default()
}
}

a_refused_tank_takes_no_fluid_in_either_insert_pass :: proc() {
}
    // rust: let table = tank_table(&[4000, 4000], &[0, 1]);
        // Pass 0 tops up a tank already holding the fluid; refused, it is
        // left exactly as it was.
    // rust: let mut state = tanks(&[(Some("create:chocolate"), 1000), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(&table, &mut state, &[0], "create:chocolate", 500, |_| false),
    // rust: 500
    // rust: );
    // rust: assert_eq!(state[0], (Some("create:chocolate".to_owned()), 1000));
        // Pass 1 fills an empty tank; refused, it stays empty.
    // rust: let mut state = tanks(&[(None, 0), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(&table, &mut state, &[1], "create:chocolate", 500, |_| false),
    // rust: 500
    // rust: );
    // rust: assert_eq!(state[1], (None, 0));
        // Only the refusing tank is skipped: the other still takes the fluid.
    // rust: let mut state = tanks(&[(Some("create:chocolate"), 1000), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(
    // rust: &table,
    // rust: &mut state,
    // rust: &[0, 1],
    // rust: "create:chocolate",
    // rust: 500,
    // rust: |tank| { tank == 1 }
    // rust: ),
    // rust: 0
    // rust: );
    // rust: assert_eq!(
    // rust: state,
    // rust: tanks(&[
    // rust: (Some("create:chocolate"), 1000),
    // rust: (Some("create:chocolate"), 500),
    // rust: ])
    // rust: );
}

every_tank_takes_every_fluid_unless_it_refuses_it :: proc() {
}
    // rust: let table = tank_table(&[4000, 4000], &[0, 1]);
    // rust: let mut state = tanks(&[(None, 0), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(
    // rust: &table,
    // rust: &mut state,
    // rust: &[0, 1],
    // rust: "create:chocolate",
    // rust: 1000,
    // rust: |_| true
    // rust: ),
    // rust: 0
    // rust: );
    // rust: assert_eq!(state[0], (Some("create:chocolate".to_owned()), 1000));
    // rust: assert_eq!(state[1], (None, 0));
}

a_move_finds_room_only_in_tanks_that_accept_the_fluid :: proc() {
}
    // rust: let tank = NativeFluidTank {
    // rust: tank: 0,
    // rust: fluid: None,
    // rust: amount: 1000,
    // rust: capacity: 4000,
    // rust: can_fill: true,
    // rust: can_drain: true,
}
        // A tank that refuses the fluid has no room, so `native_move_fluids`
        // asks its source for nothing rather than draining and putting it all
        // back.
    // rust: assert_eq!(
    // rust: tank_room(std::slice::from_ref(&tank), "create:chocolate", |_| false),
    // rust: 0
    // rust: );
    // rust: assert_eq!(tank_room(&[tank], "create:chocolate", |_| true), 3000);
}

    // The hook the game asks (`native_block_entity_accepts_fluid`) through
    // the same public dispatch `Game::native_fluid_accepts` calls: a water
    // tank refuses a mod's fluid, so neither insert pass fills it and it
    // offers no room to `native_move_fluids`; water still goes in, and with
    // no mod every tank takes every fluid.
a_hook_that_refuses_a_fluid_leaves_both_passes_empty_and_offers_no_room :: proc() {
}
//         use horizon_client::mod_api::{
    // rust: BlockEntityAcceptsFluidEvent, Flow, Hooks, Host, dispatch_block_entity_accepts_fluid,
}
TestHost :: struct {
    // rust: impl Host for TestHost {}
WaterTank :: struct {
    // rust: impl Hooks for WaterTank {
    // rust: fn block_entity_accepts_fluid(
    // rust: &self,
    _host: ^dyn Host,
    event: ^BlockEntityAcceptsFluidEvent<'_>,
    // rust: ) -> Flow {
    // rust: if event.block == "mymod:water_tank" && event.fluid != "minecraft:water" {
    Flow: :Cancel,
    // rust: } else {
    Flow: :Continue,
}
}
}
    // rust: let mods: Vec<Box<dyn Hooks>> = vec![Box::new(WaterTank)];
    // rust: let accepts = |tank: usize| {
    // rust: let mut cancel = false;
    // rust: dispatch_block_entity_accepts_fluid(
    // rust: &TestHost,
    // rust: &mods,
    // rust: "mymod:water_tank",
    // rust: tank,
    // rust: "create:chocolate",
    // rust: &mut cancel,
    // rust: );
    // rust: !cancel
}
    // rust: let table = tank_table(&[4000, 4000], &[0, 1]);
        // Pass 0 tops up a tank already holding the fluid: refused, it keeps
        // exactly what it had.
    // rust: let mut state = tanks(&[(Some("create:chocolate"), 1000), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(&table, &mut state, &[0], "create:chocolate", 500, accepts),
    // rust: 500
    // rust: );
    // rust: assert_eq!(state[0], (Some("create:chocolate".to_owned()), 1000));
        // Pass 1 fills an empty tank: refused, it stays empty.
    // rust: let mut state = tanks(&[(None, 0), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(&table, &mut state, &[1], "create:chocolate", 500, accepts),
    // rust: 500
    // rust: );
    // rust: assert_eq!(state[1], (None, 0));
        // `native_move_fluids` counts no room in the tank that refuses it, so
        // it asks its source for nothing.
    // rust: let tank = NativeFluidTank {
    // rust: tank: 0,
    // rust: fluid: None,
    // rust: amount: 1000,
    // rust: capacity: 4000,
    // rust: can_fill: true,
    // rust: can_drain: true,
}
    // rust: assert_eq!(
    // rust: tank_room(std::slice::from_ref(&tank), "create:chocolate", accepts),
    // rust: 0
    // rust: );
        // The same tank takes water (the hook lets it through) and, with no
        // mod at all, every fluid: existing mods are unchanged.
    // rust: let water = |tank: usize| {
    // rust: let mut cancel = false;
    // rust: dispatch_block_entity_accepts_fluid(
    // rust: &TestHost,
    // rust: &mods,
    // rust: "mymod:water_tank",
    // rust: tank,
    // rust: "minecraft:water",
    // rust: &mut cancel,
    // rust: );
    // rust: !cancel
}
    // rust: assert_eq!(
    // rust: tank_room(std::slice::from_ref(&tank), "minecraft:water", water),
    // rust: 3000
    // rust: );
    // rust: let none: [Box<dyn Hooks>; 0] = [];
    // rust: let no_mod = |tank: usize| {
    // rust: let mut cancel = false;
    // rust: dispatch_block_entity_accepts_fluid(
    // rust: &TestHost,
    // rust: &none,
    // rust: "mymod:water_tank",
    // rust: tank,
    // rust: "create:chocolate",
    // rust: &mut cancel,
    // rust: );
    // rust: !cancel
}
    // rust: let mut state = tanks(&[(None, 0), (None, 0)]);
    // rust: assert_eq!(
    // rust: fill_tanks(
    // rust: &table,
    // rust: &mut state,
    // rust: &[0, 1],
    // rust: "create:chocolate",
    // rust: 1000,
    // rust: no_mod
    // rust: ),
    // rust: 0
    // rust: );
    // rust: assert_eq!(state[0], (Some("create:chocolate".to_owned()), 1000));
    // rust: assert_eq!(
    // rust: tank_room(std::slice::from_ref(&tank), "create:chocolate", no_mod),
    // rust: 3000
    // rust: );
}

an_empty_tank_writes_the_empty_fluid_not_none :: proc() {
}
    // rust: let mut nbt = Compound::new();
    // rust: write_tanks(
    // rust: &mut nbt,
    // rust: &tanks(&[(Some("minecraft:lava"), 1000), (None, 0)]),
    // rust: );
    // rust: let Some(Tag::List(list)) = nbt.get(&JavaString::from("fluids")) else {
    // rust: panic!("no list");
}
    // rust: let Some(Tag::Compound(empty)) = list.get(1) else {
    // rust: panic!("no compound");
}
    // rust: assert_eq!(
    // rust: empty.get(&JavaString::from("Fluid")),
    // rust: Some(&Tag::String(JavaString::from("minecraft:empty")))
    // rust: );
}
}
