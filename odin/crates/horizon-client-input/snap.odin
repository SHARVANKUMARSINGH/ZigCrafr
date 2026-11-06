//! Transpiled from Horizon Rust crate
package horizon_client_input_snap

import "core:fmt"
import "core:mem"
import "core:math"

// Where the controller's menu cursor settles once the stick is let go, and
// how it gets there. Every rule's number lives in [`Tuning`], so the feel can
// be adjusted in one place.

// The snapping engine's knobs, in GUI pixels and seconds.
Tuning :: struct {
    // A let-go cursor settles on a target this close to it.
    radius: f32,
    // How long the glide onto a target takes.
    glide_seconds: f32,
    // Movement shorter than this is a wobble: the cursor stays where it was.
    min_travel: f32,
    // A flick that ends still nearest its starting target commits to the
    // neighbour it was heading for once it covered this fraction of the way.
    commit: f32,
    // How far off the flick's direction a neighbour may lie (cosine of the
    // angle: 0.7 is about 45 degrees).
    cone: f32,
    // The pointer's speed over a slot or control, as a fraction of its
    // speed elsewhere (1 leaves it unchanged).
    over_target_speed: f32,
}

    // rust: pub const TUNING: Tuning = Tuning {
    // rust: radius: 16.0,
    // rust: glide_seconds: 0.025,
    // rust: min_travel: 1.5,
    // rust: commit: 0.15,
    // rust: cone: 0.7,
    // rust: over_target_speed: 1.0,
}

    // rust: type Point = (f32, f32);

distance :: proc(a: Point, b: Point) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((a.0 - b.0).powi(2) + (a.1 - b.1).powi(2)).sqrt()
}

// The target nearest `at`, if one lies within `radius`.
nearest :: proc(at: Point, targets: ^[Point], radius: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, t)| (i, distance(at, *t)))
    // rust: .filter(|(_, d)| *d <= radius)
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(i, _)| i)
}

// Where a stick movement from `start` to `end` settles among `targets`
// (their centres), or `None` to leave the cursor where it is.
settle :: proc(start: Point, end: Point, targets: ^[Point], tuning: ^Tuning) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let near = nearest(end, targets, tuning.radius);
    // rust: let travel = (end.0 - start.0, end.1 - start.1);
    // rust: let length = distance(start, end);
    // rust: if length < tuning.min_travel {
    // rust: return near;
}
    // rust: let origin = nearest(start, targets, tuning.radius);
    // rust: if near != origin {
    // rust: return near;
}
    // Still nearest where it started: a quick flick toward a neighbour.
    // rust: let Some(o) = origin else {
    // rust: return near;
}
    // rust: let from = targets[o];
    // rust: let heading = (travel.0 / length, travel.1 / length);
    // rust: let next = targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(i, _)| *i != o)
    // rust: .filter_map(|(i, t)| {
    // rust: let to = (t.0 - from.0, t.1 - from.1);
    // rust: let gap = distance(from, *t);
    // rust: let aligned = (to.0 * heading.0 + to.1 * heading.1) / gap;
    // rust: (gap > 0.0 && aligned >= tuning.cone).then_some((i, gap, to))
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1));
    // rust: match next {
    // rust: Some((i, gap, to)) => {
    // rust: let progress = ((end.0 - from.0) * to.0 + (end.1 - from.1) * to.1) / (gap * gap);
    // rust: if progress >= tuning.commit {
    // rust: Some(i)
    // rust: } else {
    // rust: near
}
}
    // rust: None => near,
}
}

// Where a cursor left on a target goes once the targets moved: with most of
// them if they moved together (a recipe book opened), else to the nearest
// one (a creative tab with other slots), so it never rests between targets.
// `None` when it wasn't on a target, or one is still there.
follow :: proc(at: Point, before: ^[Point], after: ^[Point]) -> O {
    // Ported from Horizon
    return {}
}
SAME :: 0.5
    // rust: let on = before.iter().find(|t| distance(at, **t) <= SAME)?;
    // rust: if after.iter().any(|t| distance(at, *t) <= SAME) {
    // rust: return None;
}
    // rust: let carried = |by: Point| {
    // rust: before
    // rust: .iter()
    // rust: .filter(|b| {
    // rust: let moved = (b.0 + by.0, b.1 + by.1);
    // rust: after.iter().any(|a| distance(moved, *a) <= SAME)
    // rust: })
    // rust: .count()
}
    // rust: let together = after
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, a)| (i, carried((a.0 - on.0, a.1 - on.1))))
    // rust: .max_by_key(|&(_, count)| count)
    // rust: .filter(|&(_, count)| count * 2 > before.len());
    // rust: together
    // rust: .map(|(i, _)| i)
    // rust: .or_else(|| nearest(at, after, f32::INFINITY))
}

// The cursor `seconds` into a glide from `from` to `to`: eased out, so it
// slows as it lands, and exactly `to` once the glide is over.
glide :: proc(from: Point, to: Point, seconds: f32, tuning: ^Tuning) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let t = (seconds / tuning.glide_seconds).clamp(0.0, 1.0);
    // rust: let eased = 1.0 - (1.0 - t).powi(3);
    // rust: (
    // rust: from.0 + (to.0 - from.0) * eased,
    // rust: from.1 + (to.1 - from.1) * eased,
    // rust: )
}

    // rust: mod tests {
//     use super::*;

    // A row of inventory slots, 18 pixels apart, and the slot below the first.
SLOTS :: [(8.0, 8.0), (26.0, 8.0), (44.0, 8.0), (8.0, 26.0)]

follow_goes_with_targets_that_moved_together :: proc() {
}
    // rust: let moved = SLOTS.map(|s| (s.0 + 77.0, s.1));
    // rust: assert_eq!(follow(SLOTS[1], &SLOTS, &moved), Some(1));
}

follow_takes_the_nearest_of_other_targets :: proc() {
}
    // rust: let other = [(30.0, 50.0), (200.0, 200.0)];
    // rust: assert_eq!(follow(SLOTS[1], &SLOTS, &other), Some(0));
}

follow_leaves_a_free_cursor_and_a_target_still_there :: proc() {
}
    // rust: let other = [(30.0, 50.0)];
    // rust: assert_eq!(follow((100.0, 100.0), &SLOTS, &other), None);
    // rust: assert_eq!(follow(SLOTS[0], &SLOTS, &SLOTS), None);
    // rust: assert_eq!(follow(SLOTS[0], &SLOTS, &[]), None);
}

a_short_flick_moves_to_the_neighbour_it_heads_for :: proc() {
}
        // 4 pixels right of slot 0: still nearest slot 0, but heading for slot 1.
    // rust: assert_eq!(settle((8.0, 8.0), (12.0, 8.0), &SLOTS, &TUNING), Some(1));
    // rust: assert_eq!(settle((8.0, 8.0), (8.0, 12.0), &SLOTS, &TUNING), Some(3));
    // rust: assert_eq!(settle((26.0, 8.0), (22.0, 8.0), &SLOTS, &TUNING), Some(0));
}

a_wobble_stays_put :: proc() {
}
    // rust: assert_eq!(settle((8.0, 8.0), (8.5, 8.4), &SLOTS, &TUNING), Some(0));
        // Barely started toward the neighbour: not committed.
    // rust: assert_eq!(settle((8.0, 8.0), (9.6, 8.0), &SLOTS, &TUNING), Some(0));
}

a_long_move_settles_on_the_nearest_target :: proc() {
}
    // rust: assert_eq!(settle((8.0, 8.0), (42.0, 9.0), &SLOTS, &TUNING), Some(2));
        // Far from everything: left where it is.
    // rust: assert_eq!(settle((8.0, 8.0), (200.0, 200.0), &SLOTS, &TUNING), None);
}

a_flick_off_any_row_does_not_jump_sideways :: proc() {
}
        // Up from slot 0: nothing lies that way, so it stays on slot 0.
    // rust: assert_eq!(settle((8.0, 8.0), (8.0, 4.0), &SLOTS, &TUNING), Some(0));
}

the_glide_eases_onto_its_target_and_stops_there :: proc() {
}
    // rust: let (from, to) = ((0.0, 0.0), (20.0, -10.0));
    // rust: assert_eq!(glide(from, to, 0.0, &TUNING), from);
    // rust: let half = glide(from, to, TUNING.glide_seconds / 2.0, &TUNING);
    // rust: assert!(
    // rust: half.0 > 10.0 && half.0 < 20.0,
    // rust: "eased out: past halfway at half time"
    // rust: );
    // rust: assert_eq!(glide(from, to, TUNING.glide_seconds, &TUNING), to);
    // rust: assert_eq!(glide(from, to, 1.0, &TUNING), to);
}
}
