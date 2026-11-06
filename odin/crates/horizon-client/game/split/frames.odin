//! Transpiled from Horizon Rust crate
package horizon_client_frames

import "core:fmt"
import "core:mem"
import "core:math"

// The frame-time readout (`HORIZON_SPLIT_STATS=1`, docs/extras.md). The players render one
// after another: on threads, their renders slowed each other down (the GPU driver's per-process
// state) more than they overlapped.
// use super::*;

    // rust: impl<'a> Split<'a> {
    // `HORIZON_SPLIT_STATS=1`: every 5 s, where a frame's time goes (the players' turns with
    // their renders, the windows' presents, the GPU wait, outside the loop) and each player's
    // frame rate and CPU and GPU time a frame, in the log.
    // rust: pub(super) fn print_stats(&mut self) {
    // rust: let Some(since) = self.stats else {
    // rust: return;
}
    // rust: if since.elapsed() < Duration::from_secs(5) {
    // rust: return;
}
    // rust: self.stats = Some(Instant::now());
    // rust: let seats: Vec<usize> = (0..self.players()).map(|i| self.seat_of(i)).collect();
    // rust: let games =
    // rust: std::iter::once(&mut self.host).chain(self.guests.iter_mut().map(|g| &mut *g.game));
    // rust: let frames = self.spent_frames.max(1);
    // rust: let [turns, presents, wait, outside] =
    // rust: std::mem::take(&mut self.spent).map(|d| d.as_secs_f64() * 1000.0 / f64::from(frames));
    // rust: self.spent_frames = 0;
    // rust: let mut line = format!(
    // rust: " a frame {:.2} ms: turns {turns:.2} (with the renders), presents {presents:.2}, gpu wait {wait:.2}, outside {outside:.2}.",
    // rust: turns + presents + wait + outside,
    // rust: );
    // rust: for (i, game) in games.enumerate() {
    // rust: let s = game.frame_stats.summary();
    // rust: let ms = |k: &str| s[k]["avg_ms"].as_f64().unwrap_or(0.0);
    // rust: line += &format!(
    // rust: "  P{}: {:.0} fps, cpu {:.2} ms (render {:.2} ms), gpu {:.2} ms",
    // rust: seats[i],
    // rust: s["avg_fps"].as_f64().unwrap_or(0.0),
    // rust: ms("cpu"),
    // rust: s["phases_avg_ms"]["render"].as_f64().unwrap_or(0.0),
    // rust: ms("gpu"),
    // rust: );
    // rust: game.frame_stats.reset();
}
    // rust: log::info!("Horizon: splitscreen frames:{line}");
}
}
