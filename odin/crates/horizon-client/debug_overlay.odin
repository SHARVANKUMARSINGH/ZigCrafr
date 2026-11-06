//! Transpiled from Horizon Rust crate
package horizon_client_debug_overlay

import "core:fmt"
import "core:mem"
import "core:math"

// `DebugScreenOverlay`: the F3 text. The enabled entries
// (`debug-profile.json`) report priority lines, regular lines and groups; the overlay splits them into a left and a right column and draws
// them last, over any screen, at the debug GUI scale.
// use crate::{
    // rust: font::Font,
    // rust: hud_layout::{GuiDraw, PoseOp, fill},
    // rust: java_text,
    // rust: text::Text,
}

// `extractLines`'s background: ARGB 0x90505050.
BACKGROUND :: 0x9050_5050
// `extractLines`'s text colour: ARGB 0xFFE0E0E0.
TEXT :: 0xFFE0_E0E0
// `Font.lineHeight`.
LINE_HEIGHT :: 9

// What the enabled entries reported (`DebugScreenDisplayer`).
Displayer :: struct {
    left: [dynamic]string,
    right: [dynamic]string,
    lines: [dynamic]string,
    groups: Vec<(^'static str,
}

    // rust: impl Displayer {
    // `addPriorityLine`: to the shorter column, the left one first.
priority :: proc(self: ^Self, line: impl Into<string>) {
}
    // rust: if self.left.len() > self.right.len() {
    // rust: self.right.push(line.into());
    // rust: } else {
    // rust: self.left.push(line.into());
}
}
    // `addLine`: split between the columns after the priority lines.
line :: proc(self: ^Self, line: impl Into<string>) {
}
    // rust: self.lines.push(line.into());
}
    // `addToGroup`: lines kept together, groups in the order first added.
group :: proc(self: ^Self, group: ^'static str, lines: impl IntoIterator<Item = string>) {
}
    // rust: let index = match self.groups.iter().position(|(g, _)| *g == group) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: self.groups.push((group, Vec::new()));
    // rust: self.groups.len() - 1
}
}
    // rust: self.groups[index].1.extend(lines);
}
    // `extractRenderState`: the left and right columns, then `footer` (the
    // chart keys, shown while the overlay is open) under the left one.
columns :: proc(self: ^Self, footer: ^[string]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (mut left, mut right) = (self.left, self.right);
    // rust: if !left.is_empty() {
    // rust: left.push(String::new());
}
    // rust: if !right.is_empty() {
    // rust: right.push(String::new());
}
    // rust: if !self.lines.is_empty() {
    // rust: let mid = self.lines.len().div_ceil(2);
    // rust: left.extend_from_slice(&self.lines[..mid]);
    // rust: right.extend_from_slice(&self.lines[mid..]);
    // rust: left.push(String::new());
    // rust: if mid < self.lines.len() {
    // rust: right.push(String::new());
}
}
    // rust: let mid = self.groups.len().div_ceil(2);
    // rust: for (i, (_, lines)) in self.groups.into_iter().enumerate() {
    // rust: if lines.is_empty() {
    // rust: continue;
}
    // rust: let column = if i < mid { &mut left } else { &mut right };
    // rust: column.extend(lines);
    // rust: column.push(String::new());
}
    // rust: if !footer.is_empty() {
    // rust: left.push(String::new());
    // rust: left.extend_from_slice(footer);
}
    // rust: (left, right)
}
}

// Horizon's own lines: the shader pack's GPU time, then its costliest passes (`passes`: each
// pass's median milliseconds, in the order they run).
shader_pass_lines :: proc(passes: ^[(string) {
}
    // rust: labelled_pass_lines("Shader pack GPU", passes)
}

// `label` and the passes' total, then the costliest passes by GPU time.
labelled_pass_lines :: proc(label: string, passes: ^[(string) {
}
SHOWN :: 8
    // rust: if passes.is_empty() {
    // rust: return Vec::new();
}
    // rust: let total: f32 = passes.iter().map(|p| p.1).sum();
    // rust: let mut lines = vec![format!("{label}: {total:.2} ms in {} passes", passes.len())];
    // rust: let mut costliest: Vec<&(String, f32)> = passes.iter().collect();
    // rust: costliest.sort_by(|a, b| b.1.total_cmp(&a.1));
    // rust: lines.extend(
    // rust: costliest
    // rust: .iter()
    // rust: .take(SHOWN)
    // rust: .map(|(name, ms)| format!("{name}: {ms:.2} ms")),
    // rust: );
    // rust: if costliest.len() > SHOWN {
    // rust: let rest: f32 = costliest[SHOWN..].iter().map(|p| p.1).sum();
    // rust: lines.push(format!("{} more: {rest:.2} ms", costliest.len() - SHOWN));
}
    // rust: lines
}

// `Mth.wrapDegrees`.
wrap_degrees :: proc(angle: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let wrapped = angle % 360.0;
    // rust: if wrapped >= 180.0 {
    // rust: wrapped - 360.0
    // rust: } else if wrapped < -180.0 {
    // rust: wrapped + 360.0
    // rust: } else {
    // rust: wrapped
}
}

// `DebugEntryPosition` and `DebugEntrySectionPosition` for a camera at
// `pos` looking `yaw`/`pitch` in `dimension` with `forced` force-loaded chunks.
    // rust: pub fn position(
    // rust: pos: [f64; 3],
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: dimension: &str,
    // rust: forced: usize,
    // rust: ) -> Vec<String> {
    // rust: let block = pos.map(|v| v.floor() as i32);
    // rust: let (cx, sy, cz) = (block[0] >> 4, block[1] >> 4, block[2] >> 4);
    // Direction.fromYRot: floor(yRot / 90 + 0.5) & 3 as a 2D data value.
    // rust: let (direction, towards) = match ((f64::from(yaw) / 90.0 + 0.5).floor() as i32) & 3 {
    // rust: 0 => ("south", "Towards positive Z"),
    // rust: 1 => ("west", "Towards negative X"),
    // rust: 2 => ("north", "Towards negative Z"),
    // rust: _ => ("east", "Towards positive X"),
}
    // rust: vec![
    // rust: format!(
    // rust: "XYZ: {} / {} / {}",
    // rust: java_text::format_fixed(pos[0], 3),
    // rust: java_text::format_fixed(pos[1], 5),
    // rust: java_text::format_fixed(pos[2], 3),
    // rust: ),
    // rust: format!("Block: {} {} {}", block[0], block[1], block[2]),
    // rust: format!(
    // rust: "Chunk: {cx} {sy} {cz} [{} {} in r.{}.{}.mca]",
    // rust: cx & 31,
    // rust: cz & 31,
    // rust: cx >> 5,
    // rust: cz >> 5
    // rust: ),
    // rust: format!(
    // rust: "Facing: {direction} ({towards}) ({} / {})",
    // rust: java_text::format_fixed(wrap_degrees(yaw) as f64, 1),
    // rust: java_text::format_fixed(wrap_degrees(pitch) as f64, 1),
    // rust: ),
    // rust: format!("{dimension} FC: {forced}"),
    // rust: format!(
    // rust: "Section-relative: {:02} {:02} {:02}",
    // rust: block[0] & 15,
    // rust: block[1] & 15,
    // rust: block[2] & 15
    // rust: ),
    // rust: ]
}

// `VideoMode.refreshRateLabel`: whole rates without decimals.
refresh_rate_label :: proc(hz: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if hz == hz.round() {
    // rust: format!("{}", hz as i64)
    // rust: } else {
    // rust: format!("{hz:.2}")
}
}

// `DeviceInfo.vendorName` for a PCI vendor id.
vendor_name :: proc(id: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: 0x10de => "NVIDIA Corporation".into(),
    // rust: 0x1002 | 0x1022 => "AMD".into(),
    // rust: 0x8086 => "Intel".into(),
    // rust: 0x106b => "Apple".into(),
    // rust: 0x5143 => "Qualcomm".into(),
    // rust: 0x13b5 => "ARM".into(),
    // rust: 0x10005 => "Mesa".into(),
    // rust: 0 => "unknown".into(),
    // rust: other => format!("{other:#06x}"),
}
}

// The overlay's scale against the GUI scale and the scaled screen size it
// lays out in. `debugGuiScale`: -1 keeps the GUI scale, 0 (the default) is
// half the largest automatic scale, n is `calculateScale(n)`; only a scale
// below the GUI scale applies.
    // rust: pub fn scale(
    // rust: framebuffer: [i32; 2],
    // rust: gui_scale: i32,
    // rust: option: i32,
    // rust: unicode: bool,
    // rust: gui_size: [i32; 2],
    // rust: ) -> (f32, [i32; 2]) {
    // rust: let scale = match option {
    // rust: -1 => gui_scale,
        // Half the automatic scale, rounded up: an odd scale has no exact
        // half, and truncating it put the overlay at a third of the GUI
        // scale instead of a half on a window whose automatic scale is odd
        // (1280x720 is 3). Even scales are unchanged.
    // rust: 0 => (crate::window::calculate_scale(framebuffer, 0, unicode) + 1) / 2,
    // rust: n => crate::window::calculate_scale(framebuffer, n, unicode),
}
    // rust: if scale < gui_scale && scale > 0 {
    // rust: (
    // rust: scale as f32 / gui_scale as f32,
    // rust: [framebuffer[0] / scale, framebuffer[1] / scale],
    // rust: )
    // rust: } else {
    // rust: (1.0, gui_size)
}
}

// `extractLines` for both columns under the overlay's pose: each line's
// background first, then the text, right-aligned in the right column.
draw :: proc(font: ^Font, columns: [^[string]; 2], scale: f32, width: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![GuiDraw::Push(vec![PoseOp::Scale(scale, scale)])];
    // rust: for (lines, align_left) in [(columns[0], true), (columns[1], false)] {
    // rust: let placed: Vec<(&String, i32, i32, i32)> = lines
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, l)| !l.is_empty())
    // rust: .map(|(i, l)| {
    // rust: let w = font.width(l) as i32;
    // rust: let left = if align_left { 2 } else { width - 2 - w };
    // rust: (l, left, 2 + LINE_HEIGHT * i as i32, w)
    // rust: })
    // rust: .collect();
    // rust: for (_, left, top, w) in &placed {
    // rust: out.push(fill(
    // rust: left - 1,
    // rust: top - 1,
    // rust: left + w + 1,
    // rust: top + LINE_HEIGHT - 1,
    // rust: BACKGROUND,
    // rust: ));
}
    // rust: for (line, left, top, _) in placed {
    // rust: out.push(GuiDraw::Text {
                // Entries colour their text with legacy codes.
    // rust: text: if line.contains('§') {
    // rust: Text::legacy(line)
    // rust: } else {
    // rust: Text::literal(line.clone())
    // rust: },
    // rust: x: left,
    // rust: y: top,
    // rust: color: TEXT,
    // rust: shadow: false,
    // rust: });
}
}
    // rust: out.push(GuiDraw::Pop);
    // rust: out
}

// `ChatFormatting.UNDERLINE`, `GREEN` and `RED` as legacy codes.
UNDERLINE :: "§n"
GREEN :: "§a"
RED :: "§c"

// `DebugEntryLookingAtState.extractInfo`: the underlined heading with the
// position, the state's registered name, then one line per property
// (`true` green, `false` red).
    // rust: pub fn state_lines<'a>(
    // rust: prefix: &str,
    // rust: pos: [i32; 3],
    // rust: name: &str,
    // rust: properties: impl IntoIterator<Item = (&'a str, &'a str)>,
    // rust: ) -> Vec<String> {
    // rust: let mut out = vec![
    // rust: format!("{UNDERLINE}{prefix}: {}, {}, {}", pos[0], pos[1], pos[2]),
    // rust: name.to_owned(),
    // rust: ];
    // rust: out.extend(properties.into_iter().map(|(key, value)| {
    // rust: let color = match value {
    // rust: "true" => GREEN,
    // rust: "false" => RED,
    // rust: _ => "",
}
    // rust: format!("{key}: {color}{value}")
    // rust: }));
    // rust: out
}

// `DebugEntryLookingAt.addTagEntries`: `#` and each tag holding `id`.
// Vanilla walks a hash set; these are sorted, so the order holds still.
    // rust: pub fn tag_lines<'a>(
    // rust: tags: impl IntoIterator<Item = (&'a String, &'a std::collections::HashSet<String>)>,
    // rust: id: &str,
    // rust: ) -> Vec<String> {
    // rust: let mut out: Vec<String> = tags
    // rust: .into_iter()
    // rust: .filter(|(_, members)| members.contains(id))
    // rust: .map(|(tag, _)| format!("#{tag}"))
    // rust: .collect();
    // rust: out.sort();
    // rust: out
}

// `DebugEntryHeightmap.HEIGHTMAP_NAMES`.
heightmap_name :: proc(kind: horizon_world::heightmap::HeightmapType) -> ^ {
    // Ported from Horizon
    return {}
}
//     use horizon_world::heightmap::HeightmapType::*;
    // rust: match kind {
    // rust: WorldSurfaceWg => "SW",
    // rust: WorldSurface => "S",
    // rust: OceanFloorWg => "OW",
    // rust: OceanFloor => "O",
    // rust: MotionBlocking => "M",
    // rust: MotionBlockingNoLeaves => "ML",
}
}

// `DebugEntryHeightmap`: the client chunk's heightmaps (`sendToClient`),
// then the server chunk's (`keepAfterWorldgen`, `??` without one), each
// type's height from `height`.
    // rust: pub fn heightmap_lines(
    // rust: client: impl Fn(horizon_world::heightmap::HeightmapType) -> i32,
    // rust: server: Option<&dyn Fn(horizon_world::heightmap::HeightmapType) -> i32>,
    // rust: ) -> [String; 2] {
//     use horizon_world::heightmap::HeightmapType;
    // rust: let mut ch = String::from("CH");
    // rust: for kind in HeightmapType::ALL
    // rust: .into_iter()
    // rust: .filter(|k| k.send_to_client())
    // rust: {
    // rust: ch.push_str(&format!(" {}: {}", heightmap_name(kind), client(kind)));
}
    // rust: let mut sh = String::from("SH");
    // rust: for kind in HeightmapType::ALL
    // rust: .into_iter()
    // rust: .filter(|k| k.keep_after_worldgen())
    // rust: {
    // rust: let height = server.map_or_else(|| "??".to_owned(), |h| h(kind).to_string());
    // rust: sh.push_str(&format!(" {}: {height}", heightmap_name(kind)));
}
    // rust: [ch, sh]
}

// `MobCategory.getDebugAbbreviation`, in `MobCategory.values()` order.
CATEGORY_ABBREVIATIONS :: ["MO", "C", "AM", "AX", "UWC", "WC", "WA", "MI"]

// `DebugEntrySpawnCounts`: the spawnable chunks of the last spawn state,
// then each category's count.
spawn_counts_line :: proc(chunks: i32, counts: ^[i32; 8]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let categories: Vec<String> = CATEGORY_ABBREVIATIONS
    // rust: .iter()
    // rust: .zip(counts)
    // rust: .map(|(abbreviation, n)| format!("{abbreviation}: {n}"))
    // rust: .collect();
    // rust: format!("SC: {chunks}, {}", categories.join(", "))
}

// `DebugEntryLocalDifficulty` with `DifficultyInstance.getSpecialMultiplier`.
local_difficulty_line :: proc(effective: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let special = if effective < 2.0 {
    // rust: 0.0
    // rust: } else if effective > 4.0 {
    // rust: 1.0
    // rust: } else {
    // rust: (effective - 2.0) / 2.0
}
    // rust: format!(
    // rust: "Local Difficulty: {} // {}",
    // rust: java_text::format_fixed(effective as f64, 2),
    // rust: java_text::format_fixed(special as f64, 2),
    // rust: )
}

// `DebugEntryGpuUtilization`: past 100% in red.
gpu_line :: proc(utilization: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if utilization > 100.0 {
    // rust: format!("GPU: {RED}100%")
    // rust: } else {
    // rust: format!("GPU: {}%", utilization.round() as i64)
}
}

// `DebugEntrySoundMood`: `Library.getChannelDebugString` and the mood.
sound_mood_line :: proc(used: [uint; 2], max: [uint; 2], mood: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "Sounds: {}/{} + {}/{} (Mood {}%)",
    // rust: used[0],
    // rust: max[0],
    // rust: used[1],
    // rust: max[1],
    // rust: (mood * 100.0).round() as i32
    // rust: )
}

// `DebugEntrySoundCache`: the decoded buffers and their size, in MiB
// rounded up.
sound_cache_line :: proc(buffers: uint, bytes: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mib = (bytes as f64 / 1024.0 / 1024.0).ceil() as i64;
    // rust: format!("Sound cache: {buffers} buffers, {mib} MiB")
}

// `DebugEntryLight` without the server's values
// (`DEBUG_SHOW_SERVER_DEBUG_VALUES` is off): the raw brightness is the
// brighter of the two at the feet.
light_line :: proc(sky: u8, block: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "Client Light: {} ({sky} sky, {block} block)",
    // rust: sky.max(block)
    // rust: )
}

// What the process holds, for `DebugEntryMemory` (Horizon has no JVM heap):
// anonymous resident memory for the heap's used part, all resident memory
// for its committed part, the machine's memory for its maximum.
ProcessMemory :: struct {
    used: u64,
    allocated: u64,
    max: u64,
}

    // rust: impl ProcessMemory {
    // From `/proc/self/status` and `/proc/meminfo`; `None` elsewhere.
read :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !cfg!(target_os = "linux") {
    // rust: return None;
}
    // rust: let status = std::fs::read_to_string("/proc/self/status").ok()?;
    // rust: let meminfo = std::fs::read_to_string("/proc/meminfo").ok()?;
    // rust: Self::parse(&status, &meminfo)
}
parse :: proc(status: string, meminfo: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kib = |text: &str, key: &str| -> Option<u64> {
    // rust: let line = text.lines().find(|l| l.starts_with(key))?;
    // rust: Some(line.split_whitespace().nth(1)?.parse::<u64>().ok()? * 1024)
}
    // rust: Some(Self {
    // rust: used: kib(status, "RssAnon:")?,
    // rust: allocated: kib(status, "VmRSS:")?,
    // rust: max: kib(meminfo, "MemTotal:")?.max(1),
    // rust: })
}
}

// `DebugEntryMemory` and its `AllocationRateCalculator`: read twice a
// second; a drop in use (a GC in vanilla) keeps the last rate.
MemoryMeter :: struct {
    last: Option<(std::time::Instant,
    rate: i64,
}

    // rust: impl MemoryMeter {
lines :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let now = std::time::Instant::now();
    // rust: let memory = match self.last {
    // rust: Some((at, memory)) if now.duration_since(at).as_millis() < 500 => memory,
    // rust: last => {
    // rust: let memory = ProcessMemory::read()?;
    // rust: if let Some((at, before)) = last
    // rust: && memory.used >= before.used
    // rust: {
    // rust: let seconds = now.duration_since(at).as_secs_f64();
    // rust: self.rate = ((memory.used - before.used) as f64 / seconds).round() as i64;
}
    // rust: self.last = Some((now, memory));
    // rust: memory
}
}
    // rust: Some(memory_lines(memory, self.rate))
}
}

// `DebugEntryMemory`'s three lines.
memory_lines :: proc(m: ProcessMemory, rate: i64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mib = |bytes: u64| bytes / 1024 / 1024;
    // rust: [
    // rust: format!(
    // rust: "Mem: {:2}% {:03}/{:03}MiB",
    // rust: m.used * 100 / m.max,
    // rust: mib(m.used),
    // rust: mib(m.max)
    // rust: ),
    // rust: format!("Allocation rate: {:03}MiB/s", rate / 1024 / 1024),
    // rust: format!(
    // rust: "Allocated: {:2}% {:03}MiB",
    // rust: m.allocated * 100 / m.max,
    // rust: mib(m.allocated)
    // rust: ),
    // rust: ]
}

    // rust: mod tests {
//     use super::*;

lines :: proc(v: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: v.iter().map(|s| (*s).to_owned()).collect()
}

looking_at_lines_match_vanilla :: proc() {
}
    // rust: let props = [
    // rust: ("facing", "north"),
    // rust: ("lit", "true"),
    // rust: ("waterlogged", "false"),
    // rust: ];
    // rust: assert_eq!(
    // rust: state_lines("Targeted Block", [1, -2, 3], "minecraft:furnace", props),
    // rust: lines(&[
    // rust: "§nTargeted Block: 1, -2, 3",
    // rust: "minecraft:furnace",
    // rust: "facing: north",
    // rust: "lit: §atrue",
    // rust: "waterlogged: §cfalse",
    // rust: ])
    // rust: );
    // rust: let tags: std::collections::HashMap<String, std::collections::HashSet<String>> = [
    // rust: ("minecraft:logs", vec!["minecraft:oak_log"]),
    // rust: ("minecraft:dirt", vec!["minecraft:dirt"]),
    // rust: ("minecraft:burnable", vec!["minecraft:oak_log"]),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(t, m)| (t.to_owned(), m.into_iter().map(str::to_owned).collect()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: tag_lines(&tags, "minecraft:oak_log"),
    // rust: lines(&["#minecraft:burnable", "#minecraft:logs"])
    // rust: );
}

world_lines_match_vanilla :: proc() {
}
//         use horizon_world::heightmap::HeightmapType::*;
    // rust: let heights = |k| match k {
    // rust: WorldSurface => 70,
    // rust: OceanFloor => 64,
    // rust: MotionBlocking => 69,
    // rust: _ => 68,
}
    // rust: assert_eq!(
    // rust: heightmap_lines(heights, Some(&heights)),
    // rust: [
    // rust: "CH S: 70 M: 69 ML: 68".to_owned(),
    // rust: "SH S: 70 O: 64 M: 69 ML: 68".to_owned()
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: heightmap_lines(heights, None)[1],
    // rust: "SH S: ?? O: ?? M: ?? ML: ??"
    // rust: );
    // rust: assert_eq!(
    // rust: spawn_counts_line(289, &[3, 10, 1, 0, 0, 2, 4, 0]),
    // rust: "SC: 289, MO: 3, C: 10, AM: 1, AX: 0, UWC: 0, WC: 2, WA: 4, MI: 0"
    // rust: );
    // rust: assert_eq!(local_difficulty_line(1.5), "Local Difficulty: 1.50 // 0.00");
    // rust: assert_eq!(
    // rust: local_difficulty_line(2.25),
    // rust: "Local Difficulty: 2.25 // 0.13"
    // rust: );
    // rust: assert_eq!(local_difficulty_line(3.0), "Local Difficulty: 3.00 // 0.50");
    // rust: assert_eq!(light_line(12, 14), "Client Light: 14 (12 sky, 14 block)");
}

performance_lines_match_vanilla :: proc() {
}
    // rust: assert_eq!(gpu_line(42.4), "GPU: 42%");
    // rust: assert_eq!(gpu_line(130.0), "GPU: §c100%");
    // rust: assert_eq!(
    // rust: sound_mood_line([3, 1], [247, 8], 0.256),
    // rust: "Sounds: 3/247 + 1/8 (Mood 26%)"
    // rust: );
    // rust: assert_eq!(
    // rust: sound_cache_line(12, 3 * 1024 * 1024 + 1),
    // rust: "Sound cache: 12 buffers, 4 MiB"
    // rust: );
    // rust: let mib = 1024 * 1024;
    // rust: let memory = ProcessMemory {
    // rust: used: 512 * mib,
    // rust: allocated: 900 * mib,
    // rust: max: 16384 * mib,
}
    // rust: assert_eq!(
    // rust: memory_lines(memory, 40 * mib as i64),
    // rust: [
    // rust: "Mem:  3% 512/16384MiB".to_owned(),
    // rust: "Allocation rate: 040MiB/s".to_owned(),
    // rust: "Allocated:  5% 900MiB".to_owned(),
    // rust: ]
    // rust: );
    // rust: let status = "Name:\thorizon\nVmRSS:\t  2048 kB\nRssAnon:\t  1024 kB\n";
    // rust: assert_eq!(
    // rust: ProcessMemory::parse(status, "MemTotal:       8192 kB\n"),
    // rust: Some(ProcessMemory {
    // rust: used: 1024 * 1024,
    // rust: allocated: 2048 * 1024,
    // rust: max: 8192 * 1024,
    // rust: })
    // rust: );
}

columns_follow_the_vanilla_split :: proc() {
}
        // The default profile's entries, sorted by identifier as
        // DebugScreenEntryList.rebuildCurrentList does: fps, game_version,
        // memory, player_position, player_section_position,
        // simple_performance_impactors, system_specs, tps.
    // rust: let mut d = Displayer::default();
    // rust: d.priority("112 fps T: 120 (fifo) @165Hz");
    // rust: d.priority("Minecraft 26.3 (26.3/vanilla)");
    // rust: d.group("memory", lines(&["Mem: 25% 1046/4096MiB"]));
    // rust: d.group("position", lines(&["XYZ: 1 / 2 / 3", "Block: 1 2 3"]));
    // rust: d.group("position", lines(&["Section-relative: 01 02 03"]));
    // rust: d.line("fancy-clouds B: 2");
    // rust: d.line("Filtering: RGSS");
    // rust: d.line("Terrain Rendering: multidrawindirect");
    // rust: d.group(
    // rust: "system",
    // rust: lines(&["CPU: 12x Ryzen", "Display: 854x709 (NVIDIA)"]),
    // rust: );
    // rust: d.line("Integrated server @ 6.6/50.0 ms, 28 tx, 492 rx");
    // rust: let footer = lines(&["Debug charts: ...", "To edit: press [F3+F6]"]);
    // rust: let (left, right) = d.columns(&footer);
        // As the issue's vanilla screenshot (#376) shows them.
    // rust: assert_eq!(
    // rust: left,
    // rust: lines(&[
    // rust: "112 fps T: 120 (fifo) @165Hz",
    // rust: "",
    // rust: "fancy-clouds B: 2",
    // rust: "Filtering: RGSS",
    // rust: "",
    // rust: "Mem: 25% 1046/4096MiB",
    // rust: "",
    // rust: "XYZ: 1 / 2 / 3",
    // rust: "Block: 1 2 3",
    // rust: "Section-relative: 01 02 03",
    // rust: "",
    // rust: "",
    // rust: "Debug charts: ...",
    // rust: "To edit: press [F3+F6]",
    // rust: ])
    // rust: );
    // rust: assert_eq!(
    // rust: right,
    // rust: lines(&[
    // rust: "Minecraft 26.3 (26.3/vanilla)",
    // rust: "",
    // rust: "Terrain Rendering: multidrawindirect",
    // rust: "Integrated server @ 6.6/50.0 ms, 28 tx, 492 rx",
    // rust: "",
    // rust: "CPU: 12x Ryzen",
    // rust: "Display: 854x709 (NVIDIA)",
    // rust: "",
    // rust: ])
    // rust: );
}

position_lines_match_vanilla :: proc() {
}
        // The issue's vanilla screenshot (#376).
    // rust: assert_eq!(
    // rust: position([108.5, 104.0, -51.5], -1.0, 7.1, "minecraft:overworld", 0),
    // rust: lines(&[
    // rust: "XYZ: 108.500 / 104.00000 / -51.500",
    // rust: "Block: 108 104 -52",
    // rust: "Chunk: 6 6 -4 [6 28 in r.0.-1.mca]",
    // rust: "Facing: south (Towards positive Z) (-1.0 / 7.1)",
    // rust: "minecraft:overworld FC: 0",
    // rust: "Section-relative: 12 08 12",
    // rust: ])
    // rust: );
    // rust: assert_eq!(
    // rust: position([1.0005, 64.0, 0.0], 0.0, 0.0, "minecraft:overworld", 0)[0],
    // rust: "XYZ: 1.001 / 64.00000 / 0.000"
    // rust: );
    // rust: assert_eq!(
    // rust: position([0.0, 64.0, 0.0], 450.0, 0.0, "minecraft:the_nether", 2)[3],
    // rust: "Facing: west (Towards negative X) (90.0 / 0.0)"
    // rust: );
    // rust: assert_eq!(refresh_rate_label(165.0), "165");
    // rust: assert_eq!(refresh_rate_label(59.94), "59.94");
}

debug_scale_is_half_the_automatic_scale :: proc() {
}
        // The issue's window: 854x709 at GUI scale 2 draws F3 at scale 1.
    // rust: assert_eq!(
    // rust: scale([854, 709], 2, 0, false, [427, 355]),
    // rust: (0.5, [854, 709])
    // rust: );
        // 1920x1080 at GUI scale 4: auto is 4, so F3 is at 2.
    // rust: assert_eq!(
    // rust: scale([1920, 1080], 4, 0, false, [480, 270]),
    // rust: (0.5, [960, 540])
    // rust: );
        // A window whose automatic scale is odd: 1280x720 is 3, whose half
        // rounds to 2. Truncating gave 1, a third of the GUI scale, which is
        // why a restored-down window drew the overlay smaller than a
        // maximised one.
    // rust: assert_eq!(
    // rust: scale([1280, 720], 3, 0, false, [427, 240]),
    // rust: (2.0 / 3.0, [640, 360])
    // rust: );
        // A GUI scale already at or under the debug scale is kept.
    // rust: assert_eq!(
    // rust: scale([1920, 1080], 2, 0, false, [960, 540]),
    // rust: (1.0, [960, 540])
    // rust: );
    // rust: assert_eq!(
    // rust: scale([1920, 1080], 3, -1, false, [640, 360]),
    // rust: (1.0, [640, 360])
    // rust: );
}

shader_pass_lines_list_the_costliest_passes_first :: proc() {
}
    // rust: assert!(shader_pass_lines(&[]).is_empty());
    // rust: let passes: Vec<(String, f32)> = (0..10).map(|i| (format!("p{i}"), i as f32)).collect();
    // rust: let lines = shader_pass_lines(&passes);
    // rust: assert_eq!(lines[0], "Shader pack GPU: 45.00 ms in 10 passes");
    // rust: assert_eq!(lines[1], "p9: 9.00 ms");
    // rust: assert_eq!(lines[8], "p2: 2.00 ms");
    // rust: assert_eq!(lines[9], "2 more: 1.00 ms");
}
}
