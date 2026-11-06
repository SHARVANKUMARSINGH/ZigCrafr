//! Transpiled from Horizon Rust crate
package horizon_client_skin_models

import "core:fmt"
import "core:mem"
import "core:math"

// The cache behind the `threeDSkinLayers` option: one extruded model per
// (skin, slim) pair, capped and evicting the least recently used entry.
//
// A wholesale clear would rebuild every skin on screen at once when a busy
// server pushed the list over the cap, so an insert drops exactly one entry
// (#8091 review).

// use std::collections::HashMap;
// use std::sync::Arc;

// use horizon_client::mobs::Part;

// One entry per (skin, slim).
    // rust: pub(super) struct SkinModels {
    // rust: entries: HashMap<(String, bool), (u64, Arc<Part>)>,
    // rust: clock: u64,
}

    // rust: impl SkinModels {
CAP :: 512

    // rust: pub(super) fn get(&mut self, key: &(String, bool)) -> Option<Arc<Part>> {
    // rust: self.clock += 1;
    // rust: let clock = self.clock;
    // rust: let (stamp, model) = self.entries.get_mut(key)?;
    // rust: *stamp = clock;
    // rust: Some(model.clone())
}

    // rust: pub(super) fn insert(&mut self, key: (String, bool), model: Arc<Part>) {
    // rust: self.clock += 1;
    // rust: if self.entries.len() >= Self::CAP
    // rust: && let Some(oldest) = self
    // rust: .entries
    // rust: .iter()
    // rust: .min_by_key(|(_, (stamp, _))| *stamp)
    // rust: .map(|(key, _)| key.clone())
    // rust: {
    // rust: self.entries.remove(&oldest);
}
    // rust: self.entries.insert(key, (self.clock, model));
}

len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.len()
}
}

    // rust: mod tests {
//     use super::SkinModels;
//     use horizon_client::mobs::Part;
//     use std::sync::Arc;

part :: proc() -> A {
    // Ported from Horizon
    return {}
}
    // rust: Arc::new(Part {
    // rust: name: String::new(),
    // rust: pose: [0.0; 9],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
    // rust: })
}

the_cap_evicts_the_least_recently_used_skin :: proc() {
}
    // rust: let mut models = SkinModels::default();
    // rust: for i in 0..SkinModels::CAP {
    // rust: models.insert((format!("skin{i}"), false), part());
}
        // Touch the first one so the second becomes the oldest.
    // rust: assert!(models.get(&("skin0".to_owned(), false)).is_some());
    // rust: models.insert(("new".to_owned(), false), part());
    // rust: assert_eq!(models.len(), SkinModels::CAP);
    // rust: assert!(models.get(&("skin1".to_owned(), false)).is_none());
    // rust: assert!(models.get(&("skin0".to_owned(), false)).is_some());
    // rust: assert!(models.get(&("new".to_owned(), false)).is_some());
}
}
