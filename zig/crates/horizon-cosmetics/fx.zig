//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_fx
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The worn kinds that are not on a bone: a companion floating beside the player, a trail of
//! particles left while moving, an aura around the feet or the body. Their blocks in the item
//! file and the limits they are held to; `follow` and `trail` run them.

// use serde::Deserialize;

/// How far a companion's vertices may reach from its own origin (pixels), animations included:
/// a small creature or object.
pub const MAX_COMPANION_REACH: f32 = 8.0;
/// How far a companion's anchor may be from the neck (pixels).
pub const MAX_COMPANION_ANCHOR: f32 = 28.0;
/// The centre of the head in the player model (pixels, y down): what a companion keeps clear of.
pub const HEAD: [f32; 3] = [0.0, -4.0, 0.0];
/// The head's radius (the 8-pixel cube's half diagonal, rounded up) plus the gap kept between the
/// head and the nearest point a companion may reach (pixels).
pub const HEAD_CLEARANCE: f32 = 7.0 + 4.0;
/// The longest smoothing a companion's follow may have (ticks).
pub const MAX_LAG: f32 = 40.0;
/// Particles a trail may leave per block moved.
pub const MAX_TRAIL_RATE: f32 = 4.0;
/// The longest a trail's particle lives (ticks): two seconds.
pub const MAX_TRAIL_LIFETIME: u32 = 40;
/// The largest side of a particle (pixels).
pub const MAX_PARTICLE_SIZE: f32 = 4.0;
/// Sprites a trail's texture may hold (square, side by side).
pub const MAX_TRAIL_SPRITES: u32 = 8;
/// The largest sprite side (texels).
pub const MAX_SPRITE: u32 = 16;
/// How far from the middle of the feet an aura may reach sideways (pixels): about the width of
/// the hitbox plus half a block, so it frames the player without hiding anyone near them.
pub const MAX_AURA_RADIUS: f32 = 14.0;

/// What a companion does: where it floats and how it follows.
pub const Companion = struct {
    /// Where it floats at rest, in the wearer's body space (pixels from the neck, y down, +x the
    /// wearer's left, +z behind).
    anchor: [f32,
    /// How slowly it catches up (ticks): the time constant of its follow.
    lag: f32,
    /// A part that turns to look where the wearer looks.
    look: ?[]const u8,
    /// How far its vertices reach from its origin (pixels), found when read.
    reach: f32,
    /// Drawn at full light (a firefly's lantern).
    glow: bool,
};

/// Where a trail's particles start, or an aura sits.
pub const From = enum {
    Feet,
    Body,
};

/// What a trail leaves: particles drawn from the item's texture, a row of square sprites.
pub const Trail = struct {
    sprites: u32,
    /// Particles per block moved.
    rate: f32,
    /// Ticks each lives.
    lifetime: u32,
    /// The smallest and largest side (pixels).
    size: [f32,
    /// Blocks per tick², down (negative: rises, as embers).
    gravity: f32,
    /// How far each sways sideways (pixels).
    drift: f32,
    /// Degrees per tick it turns.
    spin: f32,
    from: From,
    /// Fades out over its last third.
    fade: bool,
    /// Drawn at full light.
    glow: bool,
};

/// What an aura is: the item's model around the feet (or the body), see-through.
pub const Aura = struct {
    at: From,
    /// Its opacity, at most `max_alpha`.
    alpha: f32,
    /// Drawn at full light.
    glow: bool,
};

    // rust: impl Aura {
    /// The most opaque an aura may be: a ring at the feet hides nothing; one around the body
    /// stays faint so the player inside is as easy to see and hit.
pub fn max_alpha(at: From) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match at {
    // rust: From::Feet => 0.6,
    // rust: From::Body => 0.35,
}
}

    /// How high above the feet an aura may reach (pixels), and how far below.
pub fn height(at: From) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match at {
    // rust: From::Feet => (6.0, 1.0),
    // rust: From::Body => (30.0, 1.0),
}
}
}

    // rust: pub(crate) struct CompanionFile {
    // rust: anchor: [f32; 3],
    // rust: lag: f32,
    // rust: look: Option<String>,
    // rust: glow: bool,
}

pub fn default_lag() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 6.0
}

    // rust: pub(crate) struct TrailFile {
    // rust: sprites: u32,
    // rust: rate: f32,
    // rust: lifetime: u32,
    // rust: size: [f32; 2],
    // rust: gravity: f32,
    // rust: drift: f32,
    // rust: spin: f32,
    // rust: from: From,
    // rust: fade: bool,
    // rust: glow: bool,
}

pub fn one() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1
}

    // rust: pub(crate) struct AuraFile {
    // rust: at: From,
    // rust: alpha: f32,
    // rust: glow: bool,
}

pub fn invalid(text: impl Into<[]const u8>) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::Error::Invalid(text.into())
}

pub fn finite(values: *[f32], what: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match values.iter().all(|v| v.is_finite()) {
    // rust: true => Ok(()),
    // rust: false => Err(invalid(format!("{what} is not a number"))),
}
}

    // rust: impl CompanionFile {
    /// Checks the block of an item whose parts are `names`; `reach` is how far its vertices get
    /// from its origin, animations included.
    // rust: pub(crate) fn check(self, names: &[String], reach: f32) -> Result<Companion, crate::Error> {
    // rust: finite(&self.anchor, "companion.anchor")?;
    // rust: finite(&[self.lag], "companion.lag")?;
    // rust: if reach > MAX_COMPANION_REACH {
    // rust: return Err(invalid(format!(
    // rust: "a companion reaches {reach:.1} pixels from its origin, at most {MAX_COMPANION_REACH}"
    // rust: )));
}
    // rust: let anchor = glam::Vec3::from(self.anchor);
    // rust: if anchor.length() > MAX_COMPANION_ANCHOR {
    // rust: return Err(invalid(format!(
    // rust: "companion.anchor is at most {MAX_COMPANION_ANCHOR} pixels from the neck"
    // rust: )));
}
    // rust: if anchor.distance(glam::Vec3::from(HEAD)) < HEAD_CLEARANCE + reach {
    // rust: return Err(invalid(format!(
    // rust: "companion.anchor is {:.1} pixels or more from the head's centre",
    // rust: HEAD_CLEARANCE + reach
    // rust: )));
}
    // rust: if !(1.0..=MAX_LAG).contains(&self.lag) {
    // rust: return Err(invalid(format!("companion.lag is 1 to {MAX_LAG} ticks")));
}
    // rust: if let Some(look) = &self.look
    // rust: && !names.contains(look)
    // rust: {
    // rust: return Err(invalid(format!("companion.look names no part {look:?}")));
}
    // rust: Ok(Companion {
    // rust: anchor: self.anchor,
    // rust: lag: self.lag,
    // rust: look: self.look,
    // rust: reach,
    // rust: glow: self.glow,
    // rust: })
}
}

    // rust: impl TrailFile {
    /// Checks the block against the item's texture (`width`×`height`).
    // rust: pub(crate) fn check(self, width: u32, height: u32) -> Result<Trail, crate::Error> {
    // rust: let t = self;
    // rust: finite(
    // rust: &[t.rate, t.size[0], t.size[1], t.gravity, t.drift, t.spin],
    // rust: "the trail",
    // rust: )?;
    // rust: if !(1..=MAX_TRAIL_SPRITES).contains(&t.sprites)
    // rust: || height > MAX_SPRITE
    // rust: || width != t.sprites * height
    // rust: {
    // rust: return Err(crate::Error::Texture(format!(
    // rust: "a trail's texture is a row of 1 to {MAX_TRAIL_SPRITES} square sprites of at most \
    // rust: {MAX_SPRITE} texels"
    // rust: )));
}
    // rust: if !(t.rate > 0.0 && t.rate <= MAX_TRAIL_RATE) {
    // rust: return Err(invalid(format!(
    // rust: "trail.rate is above 0 and at most {MAX_TRAIL_RATE} per block"
    // rust: )));
}
    // rust: if !(1..=MAX_TRAIL_LIFETIME).contains(&t.lifetime) {
    // rust: return Err(invalid(format!(
    // rust: "trail.lifetime is 1 to {MAX_TRAIL_LIFETIME} ticks"
    // rust: )));
}
    // rust: if !(t.size[0] > 0.0 && t.size[0] <= t.size[1] && t.size[1] <= MAX_PARTICLE_SIZE) {
    // rust: return Err(invalid(format!(
    // rust: "trail.size is [smallest, largest], above 0 and at most {MAX_PARTICLE_SIZE} pixels"
    // rust: )));
}
    // rust: if t.gravity.abs() > 0.04
    // rust: || !(0.0..=4.0).contains(&t.drift)
    // rust: || !(0.0..=20.0).contains(&t.spin)
    // rust: {
    // rust: return Err(invalid(
    // rust: "trail.gravity is within 0.04, drift 0 to 4 pixels, spin 0 to 20 degrees a tick",
    // rust: ));
}
    // rust: Ok(Trail {
    // rust: sprites: t.sprites,
    // rust: rate: t.rate,
    // rust: lifetime: t.lifetime,
    // rust: size: t.size,
    // rust: gravity: t.gravity,
    // rust: drift: t.drift,
    // rust: spin: t.spin,
    // rust: from: t.from,
    // rust: fade: t.fade,
    // rust: glow: t.glow,
    // rust: })
}
}

    // rust: impl AuraFile {
    /// Checks the block of an item whose vertices span `low` to `high` (pixels, from the middle of
    /// the feet, y down) over its animations.
    // rust: pub(crate) fn check(self, low: glam::Vec3, high: glam::Vec3) -> Result<Aura, crate::Error> {
    // rust: finite(&[self.alpha], "aura.alpha")?;
    // rust: let max = Aura::max_alpha(self.at);
    // rust: if !(self.alpha > 0.0 && self.alpha <= max) {
    // rust: return Err(invalid(format!("aura.alpha is above 0 and at most {max}")));
}
    // rust: let radius = [low.x, high.x, low.z, high.z]
    // rust: .iter()
    // rust: .fold(0.0_f32, |r, v| r.max(v.abs()));
    // rust: let (up, down) = Aura::height(self.at);
    // rust: if radius > MAX_AURA_RADIUS || -low.y > up || high.y > down {
    // rust: return Err(invalid(format!(
    // rust: "an aura stays within {MAX_AURA_RADIUS} pixels of the feet's middle, \
    // rust: {up} above them and {down} below"
    // rust: )));
}
    // rust: Ok(Aura {
    // rust: at: self.at,
    // rust: alpha: self.alpha,
    // rust: glow: self.glow,
    // rust: })
}
}

    // rust: mod tests {
//     use crate::pose::tests::png;
//     use crate::{Error, From, Item, Slot};

    /// A firefly: a 4-pixel cube round its origin that bobs 2 pixels over 40 ticks, a "wing"
    /// child for `look`, floating at `anchor`.
pub fn companion(anchor: [f32; 3], extra: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: r#"{{"format": 1, "id": "firefly", "slot": "companion", "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "body", "cubes": [{{"origin": [-2, -2, -2], "size": [4, 4, 4], "uv": [0, 0]}}],
    // rust: "children": [{{"name": "wing", "cubes": [{{"origin": [-1, -2, 0], "size": [2, 0, 2], "uv": [0, 8]}}]}}]}}],
    // rust: "animations": [{{"part": "body", "motion": "bob", "axis": "y", "amplitude": 2, "period": 40}}],
    // rust: "companion": {{"anchor": {anchor:?}, "lag": 8{extra}}}}}"#,
    // rust: png(16, 16)
    // rust: )
}

pub fn refused(file: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match Item::parse(file.as_bytes()) {
    // rust: Err(Error::Invalid(e)) | Err(Error::Texture(e)) => e,
    // rust: other => panic!("read: {other:?}"),
}
}

pub fn a_companion_floats_at_its_anchor_and_measures_its_reach() void {
}
    // rust: let item =
    // rust: Item::parse(companion([-14.0, -6.0, 8.0], r#", "look": "wing""#).as_bytes()).unwrap();
    // rust: assert_eq!(item.slot, Slot::Companion);
    // rust: let c = item.companion.unwrap();
    // rust: assert_eq!(
    // rust: (c.anchor, c.lag, c.look.as_deref()),
    // rust: ([-14.0, -6.0, 8.0], 8.0, Some("wing"))
    // rust: );
        // The cube's corner at the bob's top: (2, -2 - 2, 2) from the origin.
    // rust: assert!((c.reach - 24.0_f32.sqrt()).abs() < 1e-3, "{}", c.reach);
        // Beside the player, not on the head: the name tag stays where it is.
    // rust: assert_eq!(item.top, 0.0);
    // rust: assert!(item.trail.is_none() && item.aura.is_none() && item.tag.is_none());
}

pub fn a_companion_keeps_clear_of_the_head_and_stays_small_and_near() void {
}
        // 11 pixels of clearance plus its reach of 4.9 from the head's centre (0, -4, 0).
    // rust: assert!(refused(&companion([0.0, -4.0, 15.0], "")).contains("from the head"));
    // rust: assert!(Item::parse(companion([0.0, -4.0, 16.0], "").as_bytes()).is_ok());
        // At most 28 pixels from the neck.
    // rust: assert!(refused(&companion([0.0, 0.0, 29.0], "")).contains("from the neck"));
    // rust: assert!(refused(&companion([-14.0, -6.0, 8.0], r#", "look": "tail""#)).contains("tail"));
    // rust: let slow = companion([-14.0, -6.0, 8.0], "").replace(r#""lag": 8"#, r#""lag": 41"#);
    // rust: assert!(refused(&slow).contains("lag"));
        // A part 9 pixels out: past the 8 a companion may reach.
    // rust: let big = companion([-20.0, -6.0, 8.0], "").replace("[-1, -2, 0]", "[-1, -2, 7]");
    // rust: assert!(refused(&big).contains("reaches"));
        // No bone, for the item or a part.
    // rust: let boned = companion([-14.0, -6.0, 8.0], "").replace(
    // rust: r#""slot": "companion","#,
    // rust: r#""slot": "companion", "bone": "head","#,
    // rust: );
    // rust: assert!(refused(&boned).contains("no bone"));
    // rust: let missing = companion([-14.0, -6.0, 8.0], "")
    // rust: .replace(r#""slot": "companion""#, r#""slot": "head""#);
    // rust: assert!(refused(&missing).contains("only a companion"));
}

pub fn trail(sprites: u32, side: u32, block: []const u8, parts: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: r#"{{"format": 1, "id": "leaves", "slot": "trail", "texture": {{"png": "{}"}},
    // rust: "parts": [{parts}], "trail": {{"sprites": {sprites}, {block}}}}}"#,
    // rust: png(sprites * side, side)
    // rust: )
}

pub const FALLING: []const u8 = r#""rate": 2, "lifetime": 30, "size": [1.5, 3], "gravity": 0.01, "drift": 1.5, "spin": 8, "fade": true"#;

pub fn a_trail_is_a_row_of_sprites_and_its_particles_rules() void {
}
    // rust: let item = Item::parse(trail(4, 8, FALLING, "").as_bytes()).unwrap();
    // rust: let t = item.trail.unwrap();
    // rust: assert_eq!((t.sprites, t.rate, t.lifetime), (4, 2.0, 30));
    // rust: assert_eq!(
    // rust: (t.size, t.from, t.fade, t.glow),
    // rust: ([1.5, 3.0], From::Feet, true, false)
    // rust: );
    // rust: assert_eq!((item.vertices, item.top), (0, 0.0));
        // The texture must hold exactly the sprites, square, at most 16 texels.
    // rust: let wide = trail(4, 8, FALLING, "").replace(r#""sprites": 4"#, r#""sprites": 3"#);
    // rust: assert!(refused(&wide).contains("square sprites"));
    // rust: assert!(refused(&trail(2, 32, FALLING, "")).contains("square sprites"));
        // A trail has no model.
    // rust: let part = r#"{"name": "leaf", "cubes": [{"origin": [0, 0, 0], "size": [1, 1, 1], "uv": [0, 0]}]}"#;
    // rust: assert!(refused(&trail(4, 8, FALLING, part)).contains("no parts"));
    // rust: for (from, to) in [
    // rust: (r#""rate": 2"#, r#""rate": 4.5"#),
    // rust: (r#""lifetime": 30"#, r#""lifetime": 41"#),
    // rust: (r#""size": [1.5, 3]"#, r#""size": [1.5, 5]"#),
    // rust: (r#""size": [1.5, 3]"#, r#""size": [3, 1.5]"#),
    // rust: (r#""gravity": 0.01"#, r#""gravity": 0.05"#),
    // rust: (r#""spin": 8"#, r#""spin": 30"#),
    // rust: ] {
    // rust: let file = trail(4, 8, &FALLING.replace(from, to), "");
    // rust: assert!(Item::parse(file.as_bytes()).is_err(), "{to} was read");
}
}

    /// A ring of four leaves `radius` pixels out, `lift` pixels up, at `alpha`, `at` feet or body.
pub fn aura(radius: f32, lift: f32, alpha: f32, at: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cube = |x: f32, z: f32| {
    // rust: format!(
    // rust: r#"{{"origin": [{}, {}, {}], "size": [2, 1, 2], "uv": [0, 0]}}"#,
    // rust: x - 1.0,
    // rust: -lift,
    // rust: z - 1.0
    // rust: )
}
    // rust: let r = radius - 1.0;
    // rust: format!(
    // rust: r#"{{"format": 1, "id": "ring", "slot": "aura", "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "ring", "cubes": [{}, {}, {}, {}]}}],
    // rust: "animations": [{{"part": "ring", "motion": "spin", "axis": "y", "period": 80}}],
    // rust: "aura": {{"at": "{at}", "alpha": {alpha}, "glow": true}}}}"#,
    // rust: png(16, 16),
    // rust: cube(r, 0.0),
    // rust: cube(-r, 0.0),
    // rust: cube(0.0, r),
    // rust: cube(0.0, -r)
    // rust: )
}

pub fn an_aura_stays_faint_and_near_the_feet() void {
}
    // rust: let item = Item::parse(aura(12.0, 1.0, 0.5, "feet").as_bytes()).unwrap();
    // rust: let a = item.aura.unwrap();
    // rust: assert_eq!((a.at, a.alpha, a.glow), (From::Feet, 0.5, true));
        // Spun about y it stays within 12.1 of the middle; tipped 45° about x it rises 8.5
        // pixels: past the 6 a feet aura may.
    // rust: assert!(
    // rust: refused(
    // rust: &aura(12.0, 1.0, 0.5, "feet")
    // rust: .replace(r#""motion": "spin""#, r#""motion": "swing""#)
    // rust: .replace(r#""axis": "y","#, r#""axis": "x", "amplitude": 45,"#)
    // rust: )
    // rust: .contains("within")
    // rust: );
    // rust: assert!(refused(&aura(15.0, 1.0, 0.5, "feet")).contains("within"));
        // A feet aura 6 pixels high at most; a body aura 30, fainter.
    // rust: assert!(refused(&aura(12.0, 7.0, 0.5, "feet")).contains("within"));
    // rust: assert!(refused(&aura(12.0, 1.0, 0.65, "feet")).contains("alpha"));
    // rust: assert!(Item::parse(aura(12.0, 20.0, 0.3, "body").as_bytes()).is_ok());
    // rust: assert!(refused(&aura(12.0, 20.0, 0.4, "body")).contains("alpha"));
    // rust: assert!(
    // rust: refused(
    // rust: &aura(12.0, 1.0, 0.5, "feet").replace(r#""slot": "aura""#, r#""slot": "back""#)
    // rust: )
    // rust: .contains("an aura an aura")
    // rust: );
}
}
