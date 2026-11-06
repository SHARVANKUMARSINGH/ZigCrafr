//! Transpiled from Horizon Rust crate
package horizon_cosmetics_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Cosmetic items that Horizon clients draw on players: hats, back items,
// shoulder pets, name tag styles, emotes, companions, trails and auras. Only Horizon clients
// see them; the game protocol carries nothing about them
// ([docs/cosmetics.md](../../../docs/cosmetics.md)).
//
// An item is a small model of boxes (Minecraft's box UV, as Blockbench's
// "Modded Entity" format), one texture of at most 64×64, the bone of the
// player model it rides on and a few simple looping animations; a name tag
// style is a small mark and a line colour, with no model. This crate
// reads and checks items and poses them; the game draws them.

    // rust: pub mod account;
    // rust: mod emote;
    // rust: mod feed;
    // rust: mod fetch;
    // rust: pub mod follow;
    // rust: mod fx;
    // rust: mod item;
    // rust: pub mod mark;
    // rust: mod pose;
    // rust: pub mod prefs;
    // rust: pub mod preview;
    // rust: pub mod trail;
    // rust: pub mod viewer;

    // rust: pub use emote::{
    // rust: BODY, Ease, Emote, Key, MAX_ALL_KEYS, MAX_KEYS, MAX_LENGTH, MAX_MOVE, MAX_ROOT_MOVE,
    // rust: MAX_ROOT_TURN, MAX_TRACKS, MAX_TURN, Playing, Sample, Target, Track,
}
    // rust: pub use feed::{Feed, POLL, Seen};
    // rust: pub use fetch::{BATCH, Clock, Cosmetics, Frame, Http, Local, Transport, Worn};
    // rust: pub use fx::{
    // rust: Aura, Companion, From, HEAD, HEAD_CLEARANCE, MAX_AURA_RADIUS, MAX_COMPANION_ANCHOR,
    // rust: MAX_COMPANION_REACH, MAX_LAG, MAX_PARTICLE_SIZE, MAX_SPRITE, MAX_TRAIL_LIFETIME,
    // rust: MAX_TRAIL_RATE, MAX_TRAIL_SPRITES, Trail,
}
    // rust: pub use item::{
    // rust: Animation, Axis, Bone, Error, FORMAT, Face, Item, MAX_MARK, MAX_PARTS, MAX_REACH, MAX_TEXTURE,
    // rust: MAX_VERTICES, Motion, Part, Slot, Tag, Texture,
}
    // rust: pub use pose::{Pose, pose_matrix};

// Cosmetics run by default (Ludovic, 2026-11-04: on when the shop opens): the settings entry and
// your own are there for everyone. Other players' show by default only to an account that owns a
// cosmetic (`prefs::Others::effective`, the same day: a player who owns none sees a vanilla game
// and the game asks nothing about other players, as CONTRIBUTING.md asks), until the player
// chooses. `HORIZON_COSMETICS=0` turns everything off.
ON_BY_DEFAULT :: true

// The cosmetics service (`HORIZON_COSMETICS_API` overrides it).
API :: "https://cosmetics.playhorizon.dev"

// Whether cosmetics run: `ON_BY_DEFAULT`, or `HORIZON_COSMETICS=1` / `0` for one run
// (development, the bench).
enabled :: proc() -> b {
    // Ported from Horizon
    return {}
}
ON :: std::sync::OnceLock::new()
    // rust: *ON.get_or_init(|| match std::env::var("HORIZON_COSMETICS").as_deref() {
    // rust: Ok("1") => true,
    // rust: Ok("0") => false,
    // rust: _ => ON_BY_DEFAULT,
    // rust: })
}

// `HORIZON_COSMETICS=1` asked for this run: the launcher shows its Wardrobe even while the
// cosmetics service has no Shop to show (development, screenshots).
forced :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: std::env::var("HORIZON_COSMETICS").as_deref() == Ok("1")
}
