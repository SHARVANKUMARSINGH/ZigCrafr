//! Transpiled from Horizon Rust crate
package horizon_client_test_locate

import "core:fmt"
import "core:mem"
import "core:math"

// `TestCommand`'s `locate`, `pos` and `create`.
// use super::{Arg, Context, Game, R, err};
// use crate::game::test_instances::TestDef;
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: test_instance_block::{Status, TestInstanceBlock},
    // rust: text::{self, ClickEvent, Style, Text},
}
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use horizon_world::worldgen::structure::Rotation;

    // rust: type Pos = (i32, i32, i32);

// `Rotation.rotate(Direction.NORTH)` as (dx, dz) and the `toYRot` of the
// opposite direction.
north_turned :: proc(rotation: Rotation) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match rotation {
    // rust: Rotation::None => ((0, -1), 0),
    // rust: Rotation::Clockwise90 => ((1, 0), 90),
    // rust: Rotation::Clockwise180 => ((0, 1), 180),
    // rust: Rotation::Counterclockwise90 => ((-1, 0), 270),
}
}

// `String.format("/execute in %s run tp @s %d %d %d %d 0", ..)` of `locate`.
locate_command :: proc(dimension: string, at: Pos, y_rot: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "/execute in {dimension} run tp @s {} {} {} {y_rot} 0",
    // rust: at.0, at.1, at.2
    // rust: )
}

// `Mth.floor(Mth.sqrt(dx * dx + dz * dz))` over ints.
horizontal_distance :: proc(dx: i32, dz: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: ((dx.wrapping_mul(dx).wrapping_add(dz.wrapping_mul(dz))) as f32)
    // rust: .sqrt()
    // rust: .floor() as i32
}

// The text of a clickable bracketed position.
link :: proc(inner: Text, color: u32, command: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal("[")
    // rust: .append(inner)
    // rust: .append("]")
    // rust: .with_style(&Style {
    // rust: click: Some(ClickEvent::SuggestCommand(command)),
    // rust: hover: Some(Box::new(Text::translate("chat.coordinates.tooltip", &[]))),
    // rust: ..Style::color(color)
    // rust: })
}

path_of :: proc(dimension: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: dimension.split_once(':').map_or(dimension, |(_, p)| p)
}

    // rust: impl Game<'_> {
    // `TestCommand.locate`.
    // rust: pub(super) fn test_locate(&mut self, ctx: &Context) -> R<i32> {
    // rust: let selected: Vec<String> = match ctx.get("tests") {
    // rust: Some(Arg::Str(pattern)) => horizon_client::command::args::select_resources(
    // rust: self.ui.registries.ids("minecraft:test_instance"),
    // rust: pattern,
    // rust: )
    // rust: .into_iter()
    // rust: .cloned()
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
        // CommandSourceStack.sendSystemMessage: no feedback rule.
    // rust: if !self.command_source.is_some_and(|s| s.silent) {
    // rust: self.system_message(Text::translate("commands.test.locate.started", &[]));
}
    // rust: let center = self.test_source_block();
    // rust: let source_dim = self.dim;
        // findSelectedTestPositionsAcrossDimensions: every level's test
        // blocks within 250 blocks whose test was selected.
    // rust: let mut found: Vec<(Pos, String, Rotation)> = Vec::new();
    // rust: if !selected.is_empty() {
    // rust: for dim in self.loaded_dims() {
    // rust: let back = self.enter_command_level(dim);
    // rust: for pos in self.find_test_instance_blocks(center, 250) {
    // rust: let key = self.test_instance_at(pos).and_then(|b| b.data.test.clone());
    // rust: let key = key.map(|k| {
    // rust: if k.contains(':') {
    // rust: k
    // rust: } else {
    // rust: format!("minecraft:{k}")
}
    // rust: });
    // rust: if key.is_some_and(|k| selected.contains(&k)) {
    // rust: found.push((pos, dim.id().to_owned(), self.test_rotation(pos)));
}
}
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
}
}
    // rust: let mut dimensions: Vec<String> = Vec::new();
    // rust: for (pos, dimension, rotation) in &found {
    // rust: if !dimensions.contains(dimension) {
    // rust: dimensions.push(dimension.clone());
}
    // rust: let ((dx, dz), y_rot) = north_turned(*rotation);
    // rust: let tp = (pos.0 + dx * 3, pos.1, pos.2 + dz * 3);
    // rust: let command = locate_command(dimension, tp, y_rot);
    // rust: let coordinates = link(
    // rust: Text::tr("chat.coordinates", &[&pos.0, &pos.1, &pos.2])
    // rust: .append(format!(" ->[{}]", path_of(dimension))),
    // rust: text::GREEN,
    // rust: command,
    // rust: );
    // rust: let distance = if *dimension == source_dim.id() {
    // rust: horizontal_distance(center.0 - pos.0, center.2 - pos.2).to_string()
    // rust: } else {
    // rust: "N/A".to_owned()
}
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.test.locate.found",
    // rust: &[coordinates, Text::literal(distance)],
    // rust: ));
}
    // rust: let count = found.len() as i32;
    // rust: if count == 0 {
    // rust: return Err(err("commands.test.error.no_test_instances", &[]));
}
    // rust: self.output_player_coordinates(&dimensions);
    // rust: self.feedback(Text::translate(
    // rust: "commands.test.locate.done",
    // rust: &[Text::literal(count.to_string())],
    // rust: ));
    // rust: Ok(count)
}

    // `outputPlayerCoordinates`.
output_player_coordinates :: proc(self: ^Self, test_dimensions: ^[string]) {
}
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let dimension = self.dim.id().to_owned();
        // isPlayerInCurrentTestDimension
    // rust: if test_dimensions.len() <= 1
    // rust: && test_dimensions.contains(&dimension)
    // rust: && test_dimensions.iter().any(|d| d == "minecraft:overworld")
    // rust: {
    // rust: return;
}
    // rust: let at = [
    // rust: player.position.x.floor() as i32,
    // rust: player.position.y.floor() as i32,
    // rust: player.position.z.floor() as i32,
    // rust: ];
    // rust: let command = format!(
    // rust: "/execute in {dimension} run tp @s {} {} {} {} {}",
    // rust: at[0],
    // rust: at[1],
    // rust: at[2],
    // rust: self.yaw.floor() as i32,
    // rust: self.pitch.floor() as i32
    // rust: );
    // rust: let coordinates = link(
    // rust: Text::translate(
    // rust: "test.player.coordinates",
    // rust: &[
    // rust: Text::literal(at[0].to_string()),
    // rust: Text::literal(at[1].to_string()),
    // rust: Text::literal(at[2].to_string()),
    // rust: Text::literal(path_of(&dimension).to_owned()),
    // rust: ],
    // rust: ),
    // rust: text::GOLD,
    // rust: command,
    // rust: );
    // rust: self.feedback_unbroadcast(coordinates);
}

    // `TestCommand.showPos`, but for the highlight the client draws
    // (`ClientboundGameTestHighlightPosPacket`).
    // rust: pub(super) fn test_show_pos(&mut self, ctx: &Context) -> R<i32> {
    // rust: self.source_player()?;
    // rust: let var = match ctx.get("var") {
    // rust: Some(Arg::Str(v)) => v.clone(),
    // rust: _ => "pos".to_owned(),
}
    // rust: let target = self.test_pick_block();
    // rust: let target = (target[0], target[1], target[2]);
    // rust: let containing = |game: &Self, radius: i32| {
    // rust: game.find_test_instance_blocks(target, radius)
    // rust: .into_iter()
    // rust: .find(|&p| {
    // rust: game.test_structure_box(p).is_some_and(|b| {
    // rust: (0..3).all(|i| {
    // rust: let t = [target.0, target.1, target.2][i];
    // rust: t >= b.min[i] && t <= b.max[i]
    // rust: })
    // rust: })
    // rust: })
}
    // rust: let found = containing(self, 15).or_else(|| containing(self, 250));
    // rust: let Some(block) = found else {
    // rust: return Err(err(
    // rust: "commands.test.error.no_test_containing_pos",
    // rust: &[&target.0, &target.1, &target.2],
    // rust: ));
}
    // rust: let Some(origin) = self.test_structure_box(block).map(|b| b.min) else {
    // rust: return Err(err("commands.test.error.test_instance_not_found", &[]));
}
    // rust: let relative = [
    // rust: target.0 - origin[0],
    // rust: target.1 - origin[1],
    // rust: target.2 - origin[2],
    // rust: ];
    // rust: let description = format!("{}, {}, {}", relative[0], relative[1], relative[2]);
    // rust: let coords = Text::translate(
    // rust: "commands.test.coordinates",
    // rust: &relative.map(|v| Text::literal(v.to_string())),
    // rust: )
    // rust: .with_style(&Style {
    // rust: bold: Some(true),
    // rust: click: Some(ClickEvent::CopyToClipboard(format!(
    // rust: "final BlockPos {var} = new BlockPos({description});"
    // rust: ))),
    // rust: hover: Some(Box::new(Text::translate(
    // rust: "commands.test.coordinates.copy",
    // rust: &[],
    // rust: ))),
    // rust: ..Style::color(text::GREEN)
    // rust: });
    // rust: let name = self.test_name(block).plain();
    // rust: self.feedback_unbroadcast(Text::translate(
    // rust: "commands.test.relative_position",
    // rust: &[Text::literal(name), coords],
    // rust: ));
        // `player.connection.send(new ClientboundGameTestHighlightPosPacket(..))`.
    // rust: if self.lan_acting.is_some() {
    // rust: self.guest_packets
    // rust: .push(C::GameTestHighlightPos(play::GameTestHighlightPos {
    // rust: absolute: [target.0, target.1, target.2],
    // rust: relative,
    // rust: }));
    // rust: } else {
    // rust: self.highlight_test_pos([target.0, target.1, target.2], relative);
}
    // rust: Ok(1)
}

    // `TestCommand.createNewStructure`.
    // rust: pub(super) fn test_create(&mut self, ctx: &Context) -> R<i32> {
    // rust: let int = |name: &str, default: i32| match ctx.get(name) {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => default,
}
    // rust: let Some(Arg::Resource(id)) = ctx.get("id") else {
    // rust: return Ok(0);
}
    // rust: let key = if id.contains(':') {
    // rust: id.clone()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
        // `create <id> <width>` is a cube.
    // rust: let width = int("width", 5);
    // rust: let size = if ctx.get("height").is_some() {
    // rust: [width, int("height", 5), int("depth", 5)]
    // rust: } else {
    // rust: [width; 3]
}
    // rust: if size.iter().any(|&v| v > 48) {
    // rust: return Err(err("commands.test.error.too_large", &[&48]));
}
    // rust: let at = self.test_position_around();
    // rust: self.create_empty_test(&key, at, size);
    // rust: let padding = self.test_holder_padding(at);
    // rust: let low =
    // rust: TestInstanceBlock::structure_pos_of([at.0 + padding, at.1 + padding, at.2 + padding]);
    // rust: let bedrock = self.pack.assets.registry.default_state("minecraft:bedrock");
    // rust: if bedrock.is_some() {
    // rust: for x in low[0]..low[0] + size[0] {
    // rust: for z in low[2]..low[2] + size[2] {
    // rust: self.set_test_block_state(
    // rust: (x, low[1], z),
    // rust: "minecraft:bedrock",
    // rust: horizon_world::level::flags::UPDATE_ALL,
    // rust: );
}
}
}
    // rust: let name = self.test_name(at);
    // rust: self.feedback(Text::translate("commands.test.create.success", &[name]));
    // rust: Ok(1)
}
}

    // rust: impl Game<'_> {
    // `StructureUtils.createNewEmptyTest`.
create_empty_test :: proc(self: ^Self, key: string, at: Pos, size: [i32; 3]) {
}
    // rust: let padding = self.test_def(key).map_or(0, |d: TestDef| d.padding);
    // rust: let corner =
    // rust: TestInstanceBlock::structure_pos_of([at.0 + padding, at.1 + padding, at.2 + padding]);
        // getStructureBoundingBox(getStructurePos(testPos), size, NONE)
    // rust: let area = horizon_world::worldgen::structure::BoundingBox::new(
    // rust: corner,
    // rust: [0, 1, 2].map(|i| corner[i] + size[i] - 1),
    // rust: );
    // rust: self.clear_test_space(&area);
    // rust: self.set_test_block_state(
    // rust: at,
    // rust: "minecraft:test_instance_block",
    // rust: horizon_world::level::flags::UPDATE_ALL,
    // rust: );
    // rust: if self.test_instance_at(at).is_none() {
    // rust: self.world.block_entities.insert(
    // rust: at,
    // rust: BlockEntity::TestInstanceBlock(Box::<TestInstanceBlock>::default()),
    // rust: );
}
    // rust: if let Some(block) = self.test_instance_mut(at) {
    // rust: block.data.test = Some(key.to_owned());
    // rust: block.data.size = size;
    // rust: block.data.rotation = Rotation::None;
    // rust: block.data.ignore_entities = false;
    // rust: block.data.status = Status::Cleared;
    // rust: block.data.error_message = None;
}
    // rust: self.mark_block_entity_updated(at);
}
}

    // rust: mod tests {
//     use super::*;

locate_teleports_three_blocks_in_front_of_the_rotated_north_face :: proc() {
}
        // Rotation.rotate(Direction.NORTH) and the toYRot of its opposite.
    // rust: assert_eq!(north_turned(Rotation::None), ((0, -1), 0));
    // rust: assert_eq!(north_turned(Rotation::Clockwise90), ((1, 0), 90));
    // rust: assert_eq!(north_turned(Rotation::Clockwise180), ((0, 1), 180));
    // rust: assert_eq!(north_turned(Rotation::Counterclockwise90), ((-1, 0), 270));
    // rust: assert_eq!(
    // rust: locate_command("minecraft:the_nether", (1, 64, -3), 90),
    // rust: "/execute in minecraft:the_nether run tp @s 1 64 -3 90 0"
    // rust: );
}

the_distance_is_the_floored_horizontal_one :: proc() {
}
    // rust: assert_eq!(horizontal_distance(3, 4), 5);
    // rust: assert_eq!(horizontal_distance(-1, 1), 1);
    // rust: assert_eq!(path_of("minecraft:overworld"), "overworld");
}
}
