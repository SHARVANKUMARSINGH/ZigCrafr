//! Transpiled from Horizon Rust crate
//! Module: horizon-client_dynamic_lights
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon Extras' dynamic lights (`horizon_client::dynamic_light`): the light sources near the
//! camera this frame. Nothing is gathered while the extra is off.
// use super::{Game, shield};
// use glam::DVec3;
// use horizon_client::dynamic_light::{self, BURNING, Luminance, Source};

    // rust: impl Game<'_> {
    /// Fills `dynamic_lights` for the frame: the player's and mobs' held items and fire, and
    /// glowing dropped items, the nearest [`dynamic_light::MAX`] of them.
    /// How brightly each item glows, built on first use.
    // rust: pub(super) fn luminance(&self) -> &Luminance {
    // rust: self.luminance
    // rust: .get_or_init(|| Luminance::new(self.res.facts(), self.pack.assets.registry))
}
    /// The light sources this frame while the extra is on: the player's and mobs' held items and
    /// fire, and glowing dropped items, each with the item that gives the light (none for fire).
    // rust: pub(super) fn dynamic_light_sources(&self, alpha: f64) -> Vec<(Source, Option<String>)> {
    // rust: let mut sources = Vec::new();
    // rust: if !self.settings.extras.dynamic_lights {
    // rust: return sources;
}
    // rust: let lum = self.luminance();
        // The brighter of two hands with what it holds, or fire if it outshines both.
    // rust: let brighter = |items: [Option<&str>; 2], on_fire: bool| {
    // rust: let (level, item) = items
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|i| (lum.of(i), Some(i)))
    // rust: .max_by_key(|(level, _)| *level)
    // rust: .unwrap_or((0, None));
    // rust: if on_fire && BURNING > level {
    // rust: (BURNING, None)
    // rust: } else {
                // Only a lit source names its item: nothing is allocated for a dark one.
    // rust: (level, item.filter(|_| level > 0).map(str::to_owned))
}
}
    // rust: if let Some(p) = &self.player
    // rust: && !p.spectator
    // rust: {
    // rust: let feet = self
    // rust: .previous_position
    // rust: .lerp(p.position, self.clock.camera_fraction());
    // rust: let (level, item) = brighter(
    // rust: [
    // rust: self.stack_in(self.selected).map(|s| &*s.item),
    // rust: self.stack_in(shield::OFFHAND_SLOT).map(|s| &*s.item),
    // rust: ],
    // rust: p.fire_ticks > 0,
    // rust: );
            // About where the hands are.
    // rust: sources.push((
    // rust: Source {
    // rust: at: DVec3::new(feet.x, feet.y + 1.2, feet.z),
    // rust: level,
    // rust: },
    // rust: item,
    // rust: ));
}
    // rust: for m in self.mobs.iter().filter(|m| !m.removed) {
    // rust: let (level, item) = brighter(
    // rust: [m.extra.main_hand.as_deref(), m.extra.off_hand.as_deref()],
    // rust: m.fire_ticks > 0,
    // rust: );
    // rust: if level == 0 {
    // rust: continue;
}
    // rust: let at = m.previous.lerp(m.position, alpha);
    // rust: sources.push((
    // rust: Source {
    // rust: at: DVec3::new(at.x, at.y + f64::from(m.height()) * 0.6, at.z),
    // rust: level,
    // rust: },
    // rust: item,
    // rust: ));
}
    // rust: for dropped in &self.dropped {
    // rust: let (level, item) =
    // rust: brighter([Some(&*dropped.stack.item), None], dropped.fire_ticks > 0);
    // rust: if level == 0 {
    // rust: continue;
}
    // rust: let at = dropped.previous.lerp(dropped.position, alpha);
    // rust: sources.push((
    // rust: Source {
    // rust: at: DVec3::new(at.x, at.y + 0.25, at.z),
    // rust: level,
    // rust: },
    // rust: item,
    // rust: ));
}
    // rust: sources
}
    /// Fills `dynamic_lights` for the frame from [`Self::dynamic_light_sources`], the nearest
    /// [`dynamic_light::MAX`] of them.
    // rust: pub(super) fn gather_dynamic_lights(&mut self, camera: DVec3, alpha: f64) {
    // rust: let mut out = std::mem::take(&mut self.dynamic_lights);
    // rust: out.clear();
    // rust: let sources: Vec<Source> = self
    // rust: .dynamic_light_sources(alpha)
    // rust: .into_iter()
    // rust: .map(|(s, _)| s)
    // rust: .collect();
    // rust: dynamic_light::select(&sources, camera, &mut out);
    // rust: self.dynamic_lights = out;
}
}
