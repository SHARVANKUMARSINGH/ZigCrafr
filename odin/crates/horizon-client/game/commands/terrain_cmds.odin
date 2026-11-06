//! Transpiled from Horizon Rust crate
package horizon_client_terrain_cmds

import "core:fmt"
import "core:mem"
import "core:math"

// `/forceload`, `/fillbiome`, `/worldborder` and `/loot`.
// use super::{Arg, Context, Game, R, Target, err, items::Owner};
// use horizon_client::{
    // rust: command::CommandError,
    // rust: items::ItemStack,
    // rust: scoreboard_cmd::{Holder, Tracker},
    // rust: text::Text,
    // rust: worldborder::MAX_SIZE,
}
// use horizon_core::{position::ChunkPos, random::RandomSource};

// How long `/forceload add` waits for its chunks, as the game tests' loads do.
FORCED_CHUNK_WAIT :: std::time::Duration::from_secs(120)

num :: proc(n: impl std::fmt::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(n.to_string())
}
chunk_text :: proc(x: i32, z: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(format!("[{x}, {z}]"))
}
holder :: proc(text: Text) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Holder {
    // rust: name: String::new(),
    // rust: text,
    // rust: display: None,
}
}
ticks_to_seconds :: proc(ticks: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: super::percent_f(ticks as f64 / 20.0, 2)
}
// `WorldBorderCommand.ERROR_TOO_BIG`'s argument: vanilla hands the message the
// double `5.9999968E7` (the value `setSize` compares against too), and a `%s`
// substitution prints a double with `Double.toString`.
size_limit_text :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::java_text::double_to_string(MAX_SIZE)
}

    // rust: impl Game<'_> {
    // ---- /forceload ----------------------------------------------------------

    // rust: pub(super) fn column_arg(&self, ctx: &Context, name: &str) -> R<[i32; 2]> {
    // rust: let c = self
    // rust: .coords(ctx, name)
    // rust: .ok_or_else(|| err("argument.pos2d.incomplete", &[]))?;
    // rust: let p = self.resolve_coords(&c);
    // rust: Ok([p[0].floor() as i32, p[2].floor() as i32])
}
    // `ServerLevel.setChunkForced`'s `getChunk`: a command right after
    // `/forceload add` (`/place`, `/setblock`) finds the chunks loaded.
wait_for_forced_chunks :: proc(self: ^Self, min: [i32; 2], max: [i32; 2]) {
}
    // rust: let missing = |g: &Self| {
    // rust: (min[0]..=max[0])
    // rust: .any(|x| (min[1]..=max[1]).any(|z| !g.world.chunks.contains_key(&(x, z))))
}
    // rust: let deadline = std::time::Instant::now() + FORCED_CHUNK_WAIT;
    // rust: while missing(self) {
    // rust: if std::time::Instant::now() >= deadline {
    // rust: log::warn!("Horizon: /forceload: chunks {min:?}..{max:?} are not loaded yet");
    // rust: return;
}
    // rust: let _ = self.streaming.update(&mut self.world);
    // rust: self.streaming.wait(std::time::Duration::from_millis(5));
}
}
    // rust: pub(super) fn cmd_forceload(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let dim = Text::literal(self.dim.id());
    // rust: match id {
    // rust: "forceload.query" if ctx.get("pos").is_none() => {
    // rust: let mut forced: Vec<(i32, i32)> = self.streaming.forced.iter().copied().collect();
                // ForceLoadCommand sorts its LongStream before formatting chunks.
    // rust: forced.sort_unstable_by_key(|&(x, z)| ChunkPos::new(x, z).pack());
    // rust: if forced.is_empty() {
    // rust: self.command_failure(Text::translate("commands.forceload.added.none", &[dim]));
    // rust: return Ok(0);
}
    // rust: let list = forced
    // rust: .iter()
    // rust: .map(|(x, z)| format!("[{x}, {z}]"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: let message = if forced.len() == 1 {
    // rust: Text::translate(
    // rust: "commands.forceload.list.single",
    // rust: &[dim, Text::literal(list)],
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "commands.forceload.list.multiple",
    // rust: &[num(forced.len()), dim, Text::literal(list)],
    // rust: )
}
    // rust: self.feedback(message);
    // rust: Ok(forced.len() as i32)
}
    // rust: "forceload.query" => {
    // rust: let [x, z] = self.column_arg(ctx, "pos")?;
    // rust: let key = (x >> 4, z >> 4);
    // rust: if self.streaming.forced.contains(&key) {
    // rust: self.feedback(Text::translate(
    // rust: "commands.forceload.query.success",
    // rust: &[chunk_text(key.0, key.1), dim],
    // rust: ));
    // rust: Ok(1)
    // rust: } else {
    // rust: Err(err(
    // rust: "commands.forceload.query.failure",
    // rust: &[&chunk_text(key.0, key.1).plain(), &dim.plain()],
    // rust: ))
}
}
    // rust: "forceload.remove.all" => {
    // rust: self.streaming.forced.clear();
    // rust: self.feedback(Text::translate("commands.forceload.removed.all", &[dim]));
    // rust: Ok(0)
}
    // rust: _ => {
    // rust: let add = id == "forceload.add";
    // rust: let from = self.column_arg(ctx, "from")?;
    // rust: let to = if ctx.get("to").is_some() {
    // rust: self.column_arg(ctx, "to")?
    // rust: } else {
    // rust: from
}
    // rust: let (min_x, max_x) = (from[0].min(to[0]), from[0].max(to[0]));
    // rust: let (min_z, max_z) = (from[1].min(to[1]), from[1].max(to[1]));
    // rust: if min_x < -30_000_000
    // rust: || min_z < -30_000_000
    // rust: || max_x >= 30_000_000
    // rust: || max_z >= 30_000_000
    // rust: {
    // rust: return Err(err("argument.pos.outofworld", &[]));
}
    // rust: let (cx0, cx1, cz0, cz1) = (min_x >> 4, max_x >> 4, min_z >> 4, max_z >> 4);
    // rust: let count = i64::from(cx1 - cx0 + 1) * i64::from(cz1 - cz0 + 1);
    // rust: if count > 256 {
    // rust: return Err(err("commands.forceload.toobig", &[&256, &count]));
}
    // rust: let mut tracker = Tracker::default();
    // rust: for x in cx0..=cx1 {
    // rust: for z in cz0..=cz1 {
    // rust: let changed = if add {
    // rust: self.streaming.forced.insert((x, z))
    // rust: } else {
    // rust: self.streaming.forced.remove(&(x, z))
}
    // rust: tracker.track(&holder(chunk_text(x, z)), i32::from(changed));
}
}
    // rust: if add {
    // rust: self.streaming.rank_forced(cx0, cz0, cx1, cz1);
    // rust: self.wait_for_forced_chunks([cx0, cz0], [cx1, cz1]);
}
    // rust: let (lo, hi) = (chunk_text(cx0, cz0), chunk_text(cx1, cz1));
    // rust: let verb = if add { "added" } else { "removed" };
    // rust: let (message, total) = tracker.message(
    // rust: false,
    // rust: Some(err(&format!("commands.forceload.{verb}.failure"), &[])),
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: &format!("commands.forceload.{verb}.single"),
    // rust: &[h.text.clone(), dim.clone()],
    // rust: )
    // rust: },
    // rust: |c, _| {
    // rust: Text::translate(
    // rust: &format!("commands.forceload.{verb}.multiple"),
    // rust: &[num(c), dim.clone(), lo.clone(), hi.clone()],
    // rust: )
    // rust: },
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}
}
}

    // ---- /fillbiome ----------------------------------------------------------------

    // rust: pub(super) fn cmd_fillbiome(&mut self, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Resource(biome)) = ctx.get("biome").cloned() else {
    // rust: return Ok(0);
}
        // BlockPosArgument.getLoadedBlockPos on both corners first.
    // rust: let (a, b) = (
    // rust: self.block_pos_arg(ctx, "from")?,
    // rust: self.block_pos_arg(ctx, "to")?,
    // rust: );
        // Quantize to biome cells (`QuartPos`), then work with the box.
    // rust: let q = |v: i32| (v >> 2) << 2;
    // rust: let lo = [
    // rust: q(a[0]).min(q(b[0])),
    // rust: q(a[1]).min(q(b[1])),
    // rust: q(a[2]).min(q(b[2])),
    // rust: ];
    // rust: let hi = [
    // rust: q(a[0]).max(q(b[0])),
    // rust: q(a[1]).max(q(b[1])),
    // rust: q(a[2]).max(q(b[2])),
    // rust: ];
    // rust: let volume = i64::from(hi[0] - lo[0] + 1)
    // rust: * i64::from(hi[1] - lo[1] + 1)
    // rust: * i64::from(hi[2] - lo[2] + 1);
    // rust: let limit = self.ui.rules.int("max_block_modifications");
    // rust: if volume > i64::from(limit) {
    // rust: return Err(err("commands.fillbiome.toobig", &[&limit, &volume]));
}
    // rust: let Some(target) = world_biomes!(self)
    // rust: .list
    // rust: .iter()
    // rust: .position(|b| b.name == biome)
    // rust: else {
    // rust: return Err(err(
    // rust: "argument.resource.not_found",
    // rust: &[&biome, &"minecraft:worldgen/biome"],
    // rust: ));
}
    // rust: let filter = match ctx.get("filter") {
    // rust: Some(Arg::Resource(f)) => Some(f.clone()),
    // rust: _ => None,
}
    // rust: for cz in (lo[2] >> 4)..=(hi[2] >> 4) {
    // rust: for cx in (lo[0] >> 4)..=(hi[0] >> 4) {
    // rust: if !self.world.chunks.contains_key(&(cx, cz)) {
    // rust: return Err(err("argument.pos.unloaded", &[]));
}
}
}
    // rust: let mut changed = 0;
    // rust: let mut touched = std::collections::HashSet::new();
    // rust: for z in (lo[2]..=hi[2]).step_by(4) {
    // rust: for y in (lo[1]..=hi[1]).step_by(4) {
    // rust: for x in (lo[0]..=hi[0]).step_by(4) {
    // rust: let key = (x >> 4, z >> 4);
    // rust: let Some(chunk) = self.world.chunks.get(&key) else {
    // rust: continue;
}
    // rust: let current = chunk.biome(x, y, z);
    // rust: let current_name = &world_biomes!(self).list[usize::from(current)].name;
    // rust: if let Some(f) = &filter
    // rust: && !self.biome_matches(f, current_name)
    // rust: {
    // rust: continue;
}
    // rust: if usize::from(current) == target {
    // rust: continue;
}
    // rust: let qy = ((y - self.world.bottom_y()) >> 2)
    // rust: .clamp(0, self.world.layout().height() / 4 - 1);
    // rust: if let Some(chunk) = self.world.chunks.get_mut(&key) {
    // rust: let chunk = std::sync::Arc::make_mut(chunk);
    // rust: chunk.set_biome_cell((x & 15) >> 2, qy, (z & 15) >> 2, target as u16);
}
    // rust: touched.insert(key);
    // rust: changed += 1;
}
}
}
    // rust: if changed == 0 {
    // rust: return Err(err("commands.fillbiome.no_changes", &[]));
}
    // rust: for key in &touched {
    // rust: self.world.modified.insert(*key);
    // rust: for sy in 0..self.world.layout().sections() as i32 {
    // rust: self.world.dirty_sections.insert((key.0, sy, key.1));
}
}
        // ChunkMap.resendBiomesForChunks: the players who see the changed
        // columns are sent their new biomes, in the order the columns were
        // gathered (z, then x).
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: let columns: Vec<(i32, i32)> = ((lo[2] >> 4)..=(hi[2] >> 4))
    // rust: .flat_map(|cz| ((lo[0] >> 4)..=(hi[0] >> 4)).map(move |cx| (cx, cz)))
    // rust: .filter(|key| touched.contains(key))
    // rust: .collect();
    // rust: host.hub.resend_biomes(&self.world, &columns);
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.fillbiome.success.count",
    // rust: &[
    // rust: num(changed),
    // rust: num(lo[0]),
    // rust: num(lo[1]),
    // rust: num(lo[2]),
    // rust: num(hi[0]),
    // rust: num(hi[1]),
    // rust: num(hi[2]),
    // rust: ],
    // rust: ));
    // rust: Ok(changed)
}

    // ---- /worldborder -----------------------------------------------------------------------

    // Every tick: the size change, the wall the player cannot pass and
    // damage outside the border.
    // `BorderChangeListener.DelegateBorderChangeListener`'s packets: what
    // changed on the border since the guests were last told of it.
    // rust: pub(in crate::game) fn lan_sync_border(&mut self, host: &mut crate::game::lan::LanHost) {
    // rust: let now = horizon_client::lan::border::Sent::of(&self.border);
    // rust: if let Some(sent) = host.border_sent.replace(now) {
    // rust: for packet in sent.changes(&self.border) {
    // rust: host.hub.broadcast(&packet);
}
}
}
    // rust: pub(in crate::game) fn tick_worldborder(&mut self) {
    // rust: let remaining = self.border.remaining_ticks();
    // rust: self.border.tick();
    // rust: if remaining > 0
    // rust: && self.border.remaining_ticks() == 0
    // rust: && (self.serving.is_some() || self.options.dedicated.is_some())
    // rust: {
    // rust: self.native_world_border_bounds_change_finish();
}
    // rust: self.player_border();
    // rust: self.border_damage();
}
    // The player's movement collides with the border as it is now
    // (`CollisionGetter.borderCollision`): from inside, its walls stop it.
    // rust: pub(in crate::game) fn player_border(&mut self) {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.border = Some(self.border.geometry().clone());
}
}
    // `LivingEntity.baseTick`: a player outside the border, further than
    // its safe zone, is hurt by the blocks beyond it. The game's player, or
    // a guest's in their turn (`as_guest`).
    // rust: pub(in crate::game) fn border_damage(&mut self) {
    // rust: let Some((px, pz, half)) = self.player.as_ref().map(|p| {
    // rust: (
    // rust: p.position.x,
    // rust: p.position.z,
    // rust: f64::from(p.dimensions.width) / 2.0,
    // rust: )
    // rust: }) else {
    // rust: return;
}
    // rust: let inside = self.border.contains(px - half, pz - half)
    // rust: && self.border.contains(px + half, pz + half);
    // rust: if inside {
    // rust: return;
}
    // rust: let dist = self.border.distance(px, pz) + self.border.safe_zone;
    // rust: if dist < 0.0 && self.border.damage_per_block > 0.0 && self.ticks.is_multiple_of(10) {
    // rust: let amount = (-dist * self.border.damage_per_block).floor().max(1.0) as f32;
    // rust: self.hurt_player_by("minecraft:outside_border", amount);
}
}
    // rust: pub(super) fn cmd_worldborder(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let float2 = |v: f64| super::percent_f(v, 2);
    // rust: let double = match ctx.get("distance") {
    // rust: Some(Arg::Double(d)) => *d,
    // rust: _ => 0.0,
}
    // rust: let time = match ctx.get("time") {
    // rust: Some(Arg::Int(t)) => i64::from(*t),
    // rust: _ => 0,
}
    // rust: match id {
    // rust: "worldborder.get" => {
    // rust: let size = self.border.size();
    // rust: self.feedback(Text::translate(
    // rust: "commands.worldborder.get",
    // rust: &[Text::literal(super::percent_f(size, 0))],
    // rust: ));
    // rust: Ok((size + 0.5).floor() as i32)
}
    // rust: "worldborder.set" | "worldborder.add" => {
    // rust: let current = self.border.size();
    // rust: let distance = if id == "worldborder.add" {
    // rust: current + double
    // rust: } else {
    // rust: double
}
    // rust: if current == distance {
    // rust: return Err(err("commands.worldborder.set.failed.nochange", &[]));
}
    // rust: if distance < 1.0 {
    // rust: return Err(err("commands.worldborder.set.failed.small", &[]));
}
    // rust: if distance > MAX_SIZE {
    // rust: return Err(err(
    // rust: "commands.worldborder.set.failed.big",
    // rust: &[&size_limit_text()],
    // rust: ));
}
    // rust: let shown = Text::literal(super::percent_f(distance, 1));
    // rust: if time > 0 {
    // rust: self.border.lerp_to(distance, time);
    // rust: let key = if distance > current {
    // rust: "commands.worldborder.set.grow"
    // rust: } else {
    // rust: "commands.worldborder.set.shrink"
}
    // rust: self.feedback(Text::translate(
    // rust: key,
    // rust: &[shown, Text::literal(ticks_to_seconds(time))],
    // rust: ));
    // rust: } else {
    // rust: self.border.set_size(distance);
    // rust: self.feedback(Text::translate(
    // rust: "commands.worldborder.set.immediate",
    // rust: &[shown],
    // rust: ));
}
    // rust: self.native_world_border_bounds_changed();
    // rust: Ok((distance - current) as i32)
}
    // rust: "worldborder.center" => {
    // rust: let p = self
    // rust: .position_arg(ctx, "pos")
    // rust: .unwrap_or_else(|| self.source_position());
    // rust: let (x, z) = (p[0], p[2]);
    // rust: if self.border.center() == [x, z] {
    // rust: return Err(err("commands.worldborder.center.failed", &[]));
}
    // rust: if x.abs() > 2.999_998_4e7 || z.abs() > 2.999_998_4e7 {
    // rust: return Err(err(
    // rust: "commands.worldborder.set.failed.far",
    // rust: &[&"2.9999984E7"],
    // rust: ));
}
    // rust: self.border.set_center([x, z]);
    // rust: self.native_world_border_center_changed();
    // rust: self.feedback(Text::translate(
    // rust: "commands.worldborder.center.success",
    // rust: &[Text::literal(float2(x)), Text::literal(float2(z))],
    // rust: ));
    // rust: Ok(0)
}
    // rust: "worldborder.damage.amount" | "worldborder.damage.buffer" => {
    // rust: let amount = id.ends_with("amount");
    // rust: let value = match ctx.get(if amount { "damagePerBlock" } else { "distance" }) {
    // rust: Some(Arg::Float(v)) => f64::from(*v),
    // rust: _ => 0.0,
}
    // rust: let slot = if amount {
    // rust: &mut self.border.damage_per_block
    // rust: } else {
    // rust: &mut self.border.safe_zone
}
    // rust: if *slot == value {
    // rust: return Err(err(
    // rust: if amount {
    // rust: "commands.worldborder.damage.amount.failed"
    // rust: } else {
    // rust: "commands.worldborder.damage.buffer.failed"
    // rust: },
    // rust: &[],
    // rust: ));
}
    // rust: *slot = value;
    // rust: self.feedback(Text::translate(
    // rust: if amount {
    // rust: "commands.worldborder.damage.amount.success"
    // rust: } else {
    // rust: "commands.worldborder.damage.buffer.success"
    // rust: },
    // rust: &[Text::literal(float2(value))],
    // rust: ));
    // rust: Ok(value as i32)
}
    // rust: "worldborder.warning.distance" => {
    // rust: let d = match ctx.get("distance") {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 0,
}
    // rust: if self.border.warning_distance == d {
    // rust: return Err(err("commands.worldborder.warning.distance.failed", &[]));
}
    // rust: self.border.warning_distance = d;
    // rust: self.feedback(Text::translate(
    // rust: "commands.worldborder.warning.distance.success",
    // rust: &[num(d)],
    // rust: ));
    // rust: Ok(d)
}
    // rust: _ => {
    // rust: let ticks = match ctx.get("time") {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 0,
}
    // rust: if self.border.warning_time == ticks {
    // rust: return Err(err("commands.worldborder.warning.time.failed", &[]));
}
    // rust: self.border.warning_time = ticks;
    // rust: self.feedback(Text::translate(
    // rust: "commands.worldborder.warning.time.success",
    // rust: &[Text::literal(ticks_to_seconds(i64::from(ticks)))],
    // rust: ));
    // rust: Ok(ticks)
}
}
}

    // ---- /loot ---------------------------------------------------------------------------------

tool_stack :: proc(self: ^Self, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(Arg::Item(p)) = ctx.get("tool") {
    // rust: let (damage, extra) = match p
    // rust: .components
    // rust: .as_deref()
    // rust: .map(horizon_client::item_data::command_components)
    // rust: {
    // rust: Some(Ok(tag)) => horizon_client::item_data::decode_components(Some(&tag)),
    // rust: Some(Err(e)) => return Err(CommandError::new(Text::literal(e))),
    // rust: None => (0, None),
}
    // rust: return Ok(Some(ItemStack {
    // rust: item: p.id.as_str().into(),
    // rust: count: 1,
    // rust: damage,
    // rust: extra,
    // rust: }));
}
    // rust: let entity = self
    // rust: .command_source
    // rust: .and_then(|s| s.entity)
    // rust: .unwrap_or(Target::Player);
    // rust: let slot = if ctx.has("offhand") {
    // rust: "weapon.offhand"
    // rust: } else {
    // rust: "weapon.mainhand"
}
    // rust: Ok(self
    // rust: .slots_named(&Owner::Entity(entity), slot)
    // rust: .first()
    // rust: .and_then(|s| self.slot_get(s)))
}
    // rust: pub(super) fn cmd_loot(&mut self, id: &str, ctx: &Context) -> R<i32> {
        // The drops.
    // rust: let (drops, table): (Vec<ItemStack>, Option<String>) = match id {
    // rust: "loot.loot" | "loot.fish" => {
    // rust: let Some(Arg::Resource(table)) = ctx.get("loot_table").cloned() else {
    // rust: return Ok(0);
}
                // An inline table (ResourceOrIdArgument) keeps its random sequence.
    // rust: if table.starts_with('{') {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(&table)
    // rust: .map_err(|e| err("argument.nbt.invalid", &[&e]))?;
    // rust: let json = horizon_client::scoreboard::tag_to_json(&tag);
                    // LootCommand's omitted fishing tool is EMPTY, not mainhand.
    // rust: let held = if id == "loot.fish"
    // rust: && (ctx.get("tool").is_some() || ctx.has("mainhand") || ctx.has("offhand"))
    // rust: {
    // rust: self.tool_stack(ctx)?
    // rust: } else {
    // rust: None
}
    // rust: let drops = match json["random_sequence"].as_str() {
    // rust: Some(sequence) => {
    // rust: let random = self.rand_sequences.get(sequence, self.level.seed);
    // rust: world_items!(self).inline_loot_table_with_tool(
    // rust: &json,
    // rust: held.as_ref(),
    // rust: random,
    // rust: )
}
    // rust: None => world_items!(self).inline_loot_table_with_tool(
    // rust: &json,
    // rust: held.as_ref(),
    // rust: &mut self.world.random,
    // rust: ),
}
    // rust: (drops, None)
    // rust: } else {
    // rust: if !self.items().has_loot_table(&table) {
    // rust: return Err(err("argument.resource_or_id.failed_to_parse", &[&table]));
}
    // rust: let held = if id == "loot.fish" {
    // rust: self.tool_stack(ctx)?
    // rust: } else {
    // rust: None
}
    // rust: let drops = match world_items!(self).loot_sequence(&table) {
    // rust: Some(seq) => {
    // rust: let random = self.rand_sequences.get(&seq, self.level.seed);
    // rust: world_items!(self).loot_table(&table, false, held.as_ref(), random)
}
    // rust: None => world_items!(self).loot_table(
    // rust: &table,
    // rust: false,
    // rust: held.as_ref(),
    // rust: &mut self.world.random,
    // rust: ),
}
    // rust: (drops, None)
}
}
    // rust: "loot.kill" => {
    // rust: let targets = self.entities(ctx, "target", false)?;
    // rust: let Some(t) = targets.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let ty = self.target_type(t);
                // `EntityType.getDefaultLootTable`, in the type's namespace.
    // rust: let (namespace, path) = ty.split_once(':').unwrap_or(("minecraft", ty.as_str()));
    // rust: let table = format!("{namespace}:entities/{path}");
    // rust: if t == Target::Player || !world_items!(self).has_loot_table(&table) {
    // rust: return Err(err(
    // rust: "commands.drop.no_loot_table.entity",
    // rust: &[&self.target_name(t).plain()],
    // rust: ));
}
    // rust: let by_player = matches!(
    // rust: self.command_source.map(|s| s.entity),
    // rust: None | Some(Some(Target::Player))
    // rust: );
    // rust: let held = self.slot_get(&super::items::Slot::Inv(self.selected));
    // rust: let drops = match world_items!(self).loot_sequence(&table) {
    // rust: Some(seq) => {
    // rust: let random = self.rand_sequences.get(&seq, self.level.seed);
    // rust: world_items!(self).entity_drops(&ty, by_player, held.as_ref(), random)
}
    // rust: None => world_items!(self).entity_drops(
    // rust: &ty,
    // rust: by_player,
    // rust: held.as_ref(),
    // rust: &mut self.world.random,
    // rust: ),
}
    // rust: (drops, Some(table))
}
    // rust: _ => {
                // loot mine
    // rust: let p = self.block_pos_arg(ctx, "pos")?;
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let name = self.data_block_name(p);
    // rust: let Some(table) =
    // rust: world_items!(self).block_loot_table(self.pack.assets.registry, state)
    // rust: else {
    // rust: return Err(err("commands.drop.no_loot_table.block", &[&name]));
}
    // rust: let tool = self.tool_stack(ctx)?;
    // rust: let drops = match world_items!(self).loot_sequence(&table) {
    // rust: Some(seq) => {
    // rust: let random = self.rand_sequences.get(&seq, self.level.seed);
    // rust: world_items!(self).block_drops(
    // rust: self.pack.assets.registry,
    // rust: state,
    // rust: tool.as_ref(),
    // rust: random,
    // rust: )
}
    // rust: None => world_items!(self).block_drops(
    // rust: self.pack.assets.registry,
    // rust: state,
    // rust: tool.as_ref(),
    // rust: &mut self.world.random,
    // rust: ),
}
    // rust: (drops, Some(table))
}
}
    // rust: let drops: Vec<ItemStack> = drops.into_iter().filter(|d| d.count > 0).collect();
        // Where they go.
    // rust: let mut used: Vec<ItemStack> = Vec::new();
    // rust: let literals = &ctx.literals;
    // rust: if literals.iter().any(|l| l == "give") {
    // rust: for d in &drops {
    // rust: for &t in &self.entities(ctx, "players", true)? {
    // rust: if t != Target::Player {
    // rust: continue;
}
    // rust: if let Some(rest) = self.give(d.clone()) {
    // rust: let p = self.source_position();
    // rust: self.spawn_item(rest, [p[0], p[1] + 1.32, p[2]], [0.0; 3], 0);
}
    // rust: used.push(d.clone());
}
}
    // rust: } else if literals.iter().any(|l| l == "spawn") {
    // rust: let at = self
    // rust: .position_arg(ctx, "targetPos")
    // rust: .unwrap_or_else(|| self.source_position());
    // rust: for d in &drops {
    // rust: let r = &mut self.world.random;
    // rust: let v = [
    // rust: r.next_double() * 0.2 - 0.1,
    // rust: 0.2,
    // rust: r.next_double() * 0.2 - 0.1,
    // rust: ];
    // rust: self.spawn_item(d.clone(), at, v, 10);
    // rust: used.push(d.clone());
}
    // rust: } else if literals.iter().any(|l| l == "insert") {
    // rust: let p = self.block_pos_arg(ctx, "targetPos")?;
    // rust: let owner = Owner::Block(p);
    // rust: let slots = self.slots_named(&owner, "container.*");
    // rust: if slots.is_empty() {
    // rust: return Err(err(
    // rust: "commands.item.target.not_a_container",
    // rust: &[&p[0], &p[1], &p[2]],
    // rust: ));
}
    // rust: for d in &drops {
    // rust: let mut left = d.clone();
    // rust: let mut placed = false;
    // rust: for s in &slots {
    // rust: if !self.slot_accepts(s, Some(&left)) {
    // rust: continue;
}
    // rust: match self.slot_get(s) {
    // rust: None => {
    // rust: self.slot_set(s, Some(left.clone()));
    // rust: placed = true;
    // rust: left.count = 0;
    // rust: break;
}
    // rust: Some(mut cur)
    // rust: if cur.item == left.item
    // rust: && cur.damage == left.damage
    // rust: && cur.extra == left.extra =>
    // rust: {
    // rust: let max = self.items().get(&cur.item).map_or(64, |i| i.max_stack);
    // rust: let take = left.count.min(max.saturating_sub(cur.count));
    // rust: if take > 0 {
    // rust: cur.count += take;
    // rust: left.count -= take;
    // rust: self.slot_set(s, Some(cur));
    // rust: placed = true;
}
    // rust: if left.count == 0 {
    // rust: break;
}
}
    // rust: _ => {}
}
}
    // rust: if placed {
    // rust: used.push(d.clone());
}
}
    // rust: } else {
            // replace entity|block <slot> [count]
    // rust: let block = literals.iter().any(|l| l == "block");
    // rust: let owners: Vec<Owner> = if block {
    // rust: vec![Owner::Block(self.block_pos_arg(ctx, "targetPos")?)]
    // rust: } else {
    // rust: self.entities(ctx, "entities", false)?
    // rust: .into_iter()
    // rust: .map(Owner::Entity)
    // rust: .collect()
}
    // rust: let Some(Arg::Str(slot_name)) = ctx.get("slot").cloned() else {
    // rust: return Ok(0);
}
    // rust: let count = match ctx.get("count") {
    // rust: Some(Arg::Int(c)) => *c as usize,
    // rust: _ => drops.len(),
}
    // rust: for o in owners {
                // `prefix.N` continues as `prefix.N+1`, ...
    // rust: let (prefix, start) = match slot_name.rsplit_once('.') {
    // rust: Some((p, n)) if n.parse::<usize>().is_ok() => {
    // rust: (Some(p.to_owned()), n.parse::<usize>().unwrap_or(0))
}
    // rust: _ => (None, 0),
}
    // rust: let first = self.slots_named(&o, &slot_name);
    // rust: if first.is_empty() {
    // rust: if let Owner::Block(p) = &o {
    // rust: return Err(err(
    // rust: "commands.item.target.not_a_container",
    // rust: &[&p[0], &p[1], &p[2]],
    // rust: ));
}
    // rust: return Err(err("commands.item.target.no_such_slot", &[&slot_name]));
}
    // rust: for i in 0..count {
    // rust: let slot = match &prefix {
    // rust: Some(p) => self
    // rust: .slots_named(&o, &format!("{p}.{}", start + i))
    // rust: .first()
    // rust: .cloned(),
    // rust: None => first.first().cloned().filter(|_| i == 0),
}
    // rust: let Some(slot) = slot else { continue };
    // rust: let item = drops.get(i).cloned();
    // rust: if self.slot_accepts(&slot, item.as_ref()) && self.slot_set(&slot, item.clone())
    // rust: {
    // rust: used.push(item.unwrap_or(ItemStack {
    // rust: item: "minecraft:air".into(),
    // rust: count: 0,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: }));
}
}
}
}
    // rust: let mut tracker = Tracker::default();
    // rust: for u in &used {
    // rust: let name = self.item_display_name(&u.item);
            // CommandResponseTracker.track(drop): one per stack, so the
            // command returns how many stacks it used, not how many items.
    // rust: tracker.track(&holder(name), 1);
}
    // rust: let counts: Vec<u32> = used.iter().map(|u| u.count).collect();
    // rust: let (message, total) = tracker.message(
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: let n = counts.iter().copied().find(|c| *c > 0).unwrap_or(1);
    // rust: match &table {
    // rust: Some(t) => Text::translate(
    // rust: "commands.drop.success.single_with_table",
    // rust: &[num(n), h.text.clone(), Text::literal(t.clone())],
    // rust: ),
    // rust: None => {
    // rust: Text::translate("commands.drop.success.single", &[num(n), h.text.clone()])
}
}
    // rust: },
    // rust: |c, _| match &table {
    // rust: Some(t) => Text::translate(
    // rust: "commands.drop.success.multiple_with_table",
    // rust: &[num(c), Text::literal(t.clone())],
    // rust: ),
    // rust: None => Text::translate("commands.drop.success.multiple", &[num(c)]),
    // rust: },
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}
}

    // rust: mod tests {
    // `WorldBorderCommand.ERROR_TOO_BIG` is built with the double
    // `5.9999968E7`, the same value `setSize` compares `distance` against, and
    // the `%s` substitution of a translatable renders a double with
    // `Double.toString`: the message names `5.9999968E7`, not a rounded
    // `5.999997E7`.
the_too_big_message_names_the_limit_as_vanilla_prints_it :: proc() {
}
    // rust: assert_eq!(super::MAX_SIZE, 5.9999968E7);
    // rust: assert_eq!(super::size_limit_text(), "5.9999968E7");
}
}
