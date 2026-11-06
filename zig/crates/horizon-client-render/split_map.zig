//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_split_map
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Project a draft arrangement onto the Setup screen, without opening a window.
// use crate::split_layout::{Draft, Monitor};

/// Map area: below the title and above the move row and footer.
pub const TOP: f32 = 30.0;
pub const BOTTOM: f32 = 80.0;
    // rust: pub type Rect = [f32; 4];
    // rust: pub type Map = (Vec<Rect>, Vec<(u8, Rect)>, Vec<(u8, Rect)>);

/// Monitor, window and player rectangles in UI coordinates, in their drawing order.
pub fn project(draft: *Draft, monitors: *[Monitor], main: []const u8, w: f32, h: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let desk: Vec<[f64; 4]> = monitors.iter().map(Monitor::desktop).collect();
    // A window's size on the desktop: its pixels at the scale of the monitor it is on.
    // rust: let rects = draft.rects(monitors, main);
    // rust: let on_desk: Vec<(u8, [f64; 4])> = draft
    // rust: .windows
    // rust: .iter()
    // rust: .zip(&rects)
    // rust: .filter_map(|(win, rect)| {
    // rust: let ([x, y], [pw, ph]) = (*rect)?;
    // rust: let (x, y) = (f64::from(x), f64::from(y));
    // rust: let scale = monitors
    // rust: .iter()
    // rust: .find(|m| {
    // rust: let [mx, my, mw, mh] = m.desktop();
    // rust: x >= mx && x < mx + mw && y >= my && y < my + mh
    // rust: })
    // rust: .or_else(|| monitors.iter().find(|m| m.name == main))
    // rust: .map_or(1.0, |m| m.desktop()[2] / f64::from(m.size[0]));
    // rust: Some((
    // rust: win.number,
    // rust: [x, y, f64::from(pw) * scale, f64::from(ph) * scale],
    // rust: ))
    // rust: })
    // rust: .collect();
    // The monitors, and windows past them (Wayland's, whose place is unknown) still shown.
    // rust: let all = || desk.iter().chain(on_desk.iter().map(|(_, d)| d));
    // rust: let x0 = all().map(|d| d[0]).fold(f64::MAX, f64::min);
    // rust: let y0 = all().map(|d| d[1]).fold(f64::MAX, f64::min);
    // rust: let x1 = all().map(|d| d[0] + d[2]).fold(f64::MIN, f64::max);
    // rust: let y1 = all().map(|d| d[1] + d[3]).fold(f64::MIN, f64::max);
    // rust: if desk.is_empty() || x1 <= x0 || y1 <= y0 {
    // rust: return Default::default();
}
    // rust: let (aw, ah) = (
    // rust: f64::from(w) - 40.0,
        // Room under the monitors for their names, and always for the move row: the map
        // doesn't jump when a player is picked (a drop back to where its tile was misses).
    // rust: (f64::from(h - TOP - BOTTOM) - 18.0).max(10.0),
    // rust: );
    // rust: let k = (aw / (x1 - x0)).min(ah / (y1 - y0));
    // rust: let (ox, oy) = (
    // rust: (f64::from(w) - (x1 - x0) * k) / 2.0,
    // rust: f64::from(TOP) + 4.0 + (ah - (y1 - y0) * k) / 2.0,
    // rust: );
    // rust: let to_map = |[x, y, dw, dh]: [f64; 4]| {
    // rust: [
    // rust: (ox + (x - x0) * k) as f32,
    // rust: (oy + (y - y0) * k) as f32,
    // rust: (dw * k) as f32,
    // rust: (dh * k) as f32,
    // rust: ]
}
    // rust: let mapped_monitors = desk.iter().copied().map(to_map).collect();
    // rust: let windows: Vec<(u8, [f32; 4])> = on_desk.iter().map(|&(n, d)| (n, to_map(d))).collect();
    // In their own order, emptied ones too: a window a player was just dragged out of stays
    // where it was until Apply closes it, so the player can be dragged back into it.
    // rust: let tiles = draft
    // rust: .preview(monitors, main)
    // rust: .iter()
    // rust: .map(|&(i, [vx, vy], size)| {
    // rust: let number = draft.windows.get(i).map_or(1, |w| w.number);
    // rust: let Some((_, [wx, wy, ww, wh])) = windows.iter().find(|(n, _)| *n == number) else {
    // rust: return (number, [0.0; 4]);
}
    // rust: let [pw, ph] = rects[i].map_or([1, 1], |r| r.1).map(|v| v.max(1) as f32);
    // rust: (
    // rust: number,
    // rust: [
    // rust: wx + vx as f32 / pw * ww,
    // rust: wy + vy as f32 / ph * wh,
    // rust: size.width as f32 / pw * ww,
    // rust: size.height as f32 / ph * wh,
    // rust: ],
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: (mapped_monitors, windows, tiles)
}

/// The largest visible side of a tile after later windows cover it.
pub fn uncovered(mut r: [f32; 4], covers: impl Iterator<Item = [f32; 4]>) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for [cx, cy, cw, ch] in covers {
    // rust: let [x, y, w, h] = r;
    // rust: if cx >= x + w || cx + cw <= x || cy >= y + h || cy + ch <= y {
    // rust: continue;
}
    // rust: let sides = [
    // rust: [x, y, cx - x, h],
    // rust: [cx + cw, y, x + w - (cx + cw), h],
    // rust: [x, y, w, cy - y],
    // rust: [x, cy + ch, w, y + h - (cy + ch)],
    // rust: ];
    // rust: r = sides
    // rust: .into_iter()
    // rust: .map(|[sx, sy, sw, sh]| [sx, sy, sw.max(0.0), sh.max(0.0)])
    // rust: .max_by(|a, b| (a[2] * a[3]).total_cmp(&(b[2] * b[3])))
    // rust: .unwrap_or([x, y, 0.0, 0.0]);
}
    // rust: r
}

    // rust: mod tests {
//     use super::*;
//     use crate::split_layout::{Placement, Spot};

pub fn preview_tiles_share_a_window_and_fallback_when_a_monitor_disappears() void {
}
    // rust: let monitors = vec![
    // rust: Monitor {
    // rust: name: "Desk".into(),
    // rust: at: [0, 0],
    // rust: size: [2000, 1200],
    // rust: scale: 1.0,
    // rust: },
    // rust: Monitor {
    // rust: name: "TV".into(),
    // rust: at: [-1920, 0],
    // rust: size: [1920, 1080],
    // rust: scale: 1.0,
    // rust: },
    // rust: ];
    // rust: let mut draft =
    // rust: Draft::everyone_here(2, Placement::Free(Some(([0, 0], [2000, 1200]))), 0, 0);
    // rust: let (_, windows, tiles) = project(&draft, &monitors, "Desk", 427.0, 300.0);
    // rust: assert_eq!(windows.len(), 1);
    // rust: let (a, b) = (tiles[0].1, tiles[1].1);
    // rust: assert!((a[2] - b[2]).abs() < 0.01);
    // rust: assert!((a[0] + a[2] - b[0]).abs() < 0.01);
    // rust: draft.place_player(1, Spot::Fill("TV".into()));
    // rust: let (screens, windows, tiles) = project(&draft, &monitors, "Desk", 427.0, 300.0);
    // rust: assert!(screens[1][0] < screens[0][0]);
    // rust: assert_eq!(windows.len(), 2);
    // rust: assert_eq!((tiles[0].0, tiles[1].0), (1, 2));
    // rust: let (_, windows, tiles) = project(&draft, &monitors[..1], "Desk", 427.0, 300.0);
    // rust: assert_eq!(windows.len(), 1);
    // rust: assert_eq!((tiles[0].0, tiles[1].0), (1, 1));
    // rust: assert!(project(&draft, &[], "Desk", 427.0, 300.0).0.is_empty());
}

pub fn covered_tiles_only_expose_a_visible_side_for_clicks() void {
}
    // rust: let tile = [0.0, 0.0, 100.0, 100.0];
    // rust: assert_eq!(
    // rust: uncovered(tile, [[0.0, 0.0, 60.0, 100.0]].into_iter()),
    // rust: [60.0, 0.0, 40.0, 100.0]
    // rust: );
    // rust: let hidden = uncovered(tile, [tile].into_iter());
    // rust: assert_eq!(hidden[2] * hidden[3], 0.0);
    // rust: assert_eq!(
    // rust: uncovered(tile, [[110.0, 0.0, 50.0, 50.0]].into_iter()),
    // rust: tile
    // rust: );
}
}
