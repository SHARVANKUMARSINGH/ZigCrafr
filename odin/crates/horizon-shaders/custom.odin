//! Transpiled from Horizon Rust crate
package horizon_shaders_custom

import "core:fmt"
import "core:mem"
import "core:math"

// Custom uniforms and variables of `shaders.properties` (spec 3.4): `uniform.<type>.<name>` and
// `variable.<type>.<name>` expressions, parsed once and evaluated on the CPU every frame in
// file order. Uniforms reach every program; variables only later expressions.
//
// Decisions (impl-plan.md):
// - OQ-25: numbers are doubles; booleans are 1 and 0; `%` is C's remainder (`fmod` floors);
//   comparisons and logic read the first component; a value takes its declared type at the
//   end (`int` truncates toward zero, `bool` is "not zero"). Unknown names read 0 and are
//   reported once.
// - OQ-26: `smooth` runs per frame with the frame time; its fade times (1 by default) are
//   half-lives counted in tenths of a second (`FADE_UNIT`), `fadeIn` while rising, `fadeOut`
//   while falling. Each call keeps its own state, so the optional id is not needed. As in Iris
//   1.11.7, the first argument is that id when it is written as a number and more follow.
//   A `smooth` in an `if` branch not taken keeps its value until the branch is taken again:
//   `if` evaluates only the conditions up to the first true one and that branch (#9371).
// - Unknown names, as in Iris 1.11.7 (#8995): an expression naming something the custom
//   uniforms can't see (an unknown name, or one of [`HIDDEN`]) reads 0 as a whole, even when
//   the name is in an `if` branch not taken, and so does every expression using its uniform or
//   variable. Only the names of [`NOT_GIVEN_YET`] read 0 alone.
// - Types, as in Iris 1.11.7 (#9086, #9126): an expression without its declared type (an
//   `int` given a float, a `float` given a vector or a bool...), joining a vector and a scalar,
//   or calling a function Iris's custom uniforms don't have, reads 0 as a whole, and so does
//   everything using it. The rules ([`Ty`]) are a fit to our probe packs.

// use std::collections::{HashMap, HashSet};

// use crate::Properties;

// The seconds one unit of a `smooth` fade time lasts. Fitted to Iris 1.11.7 with a probe pack of
// our own (`smoothprobe`: `smooth(rainStrength, f, f)` for several fades, read across the scene
// suite's weather changes): a half-life of a tenth of the fade time's seconds gives every
// measured value within 0.016. A second probe pack of ours (#9371: a square wave from `if`,
// `eyeBrightness`, `worldTime`; fades 0.5 to 100, the default 1, rising and falling) fits the
// same unit: half-life / fade between 0.085 and 0.100 over 63 readings. These are fits to our
// probes' Iris values, not Iris's rule. Horizon's built-in smoothed uniforms use the same 0.1 s
// unit (`pack_uniforms.rs` `SECONDS_A_TICK`).
FADE_UNIT :: 0.1

// A value: up to 16 components (matrices only as names, for `m.column.row`).
Val :: struct {
    v: [f64,
    // Components: 1 for a scalar.
    n: uint,
}

    // rust: impl Val {
scalar :: proc(x: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = [0.0; 16];
    // rust: v[0] = x;
    // rust: Self { v, n: 1 }
}
vector :: proc(c: ^[f64]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = [0.0; 16];
    // rust: v[..c.len()].copy_from_slice(c);
    // rust: Self { v, n: c.len() }
}
x :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.v[0]
}
truth :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.v[0] != 0.0
}
    // `f` per component; a scalar operand stretches to the other's size.
zip :: proc(self: ^Self, o: Val, f: impl Fn(f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.n.max(o.n).min(4);
    // rust: let at = |a: &Val, i: usize| if a.n == 1 { a.v[0] } else { a.v[i] };
    // rust: let mut out = Val::scalar(0.0);
    // rust: out.n = n;
    // rust: for i in 0..n {
    // rust: out.v[i] = f(at(&self, i), at(&o, i));
}
    // rust: out
}
map :: proc(self: ^Self, f: impl Fn(f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = self;
    // rust: for i in 0..self.n.min(4) {
    // rust: out.v[i] = f(self.v[i]);
}
    // rust: out
}
}

// Built-in names Iris 1.11.7's custom uniforms can't see, though the game may give them (most
// are frame uniforms here). Our probe packs (#8995) read 0 from `(<name>) * 0.0 + 2.0` for
// these, and 2 for 29 others (`skyColor.x`, `entityColor.x`, `blockEntityId`, `frameTime`...);
// for `centerDepthSmooth`, Iris warns `Unknown variable` (#9126's probe).
    // rust: const HIDDEN: [&str; 13] = [
    // rust: "alphaTestRef",
    // rust: "atlasSize",
    // rust: "blendFunc",
    // rust: "centerDepthSmooth",
    // rust: "dimension",
    // rust: "entityId",
    // rust: "fogColor",
    // rust: "fogDensity",
    // rust: "fogEnd",
    // rust: "fogMode",
    // rust: "fogShape",
    // rust: "fogStart",
    // rust: "renderStage",
    // rust: ];

// Names Iris 1.11.7's custom uniforms see (our probe of #8995) that the game doesn't give yet:
// such a name alone reads 0, and the expression keeps the rest.
NOT_GIVEN_YET :: ["currentRenderedItemId", "lightningBoltPosition"]

// The `int` built-ins of Iris 1.11.7's custom uniforms (an int vector for `eyeBrightness`,
// `eyeBrightnessSmooth` and the `...PositionInt`s). Our probe packs of #9126 wrote each name
// alone into an `int`, a `float` and a `bool` uniform: Iris kept these in `int` and `float`.
    // rust: const INT_NAMES: [&str; 21] = [
    // rust: "bedrockLevel",
    // rust: "biome",
    // rust: "biome_category",
    // rust: "biome_precipitation",
    // rust: "blockEntityId",
    // rust: "cameraPositionInt",
    // rust: "currentRenderedItemId",
    // rust: "eyeBrightness",
    // rust: "eyeBrightnessSmooth",
    // rust: "frameCounter",
    // rust: "heightLimit",
    // rust: "heldBlockLightValue",
    // rust: "heldBlockLightValue2",
    // rust: "heldItemId",
    // rust: "heldItemId2",
    // rust: "isEyeInWater",
    // rust: "logicalHeightLimit",
    // rust: "moonPhase",
    // rust: "previousCameraPositionInt",
    // rust: "worldDay",
    // rust: "worldTime",
    // rust: ];

// The `bool` built-ins (the same probes: Iris kept these only in `bool`). Every other built-in
// is a float there, kept only in `float`.
    // rust: const BOOL_NAMES: [&str; 16] = [
    // rust: "feetInWater",
    // rust: "firstPersonCamera",
    // rust: "hasCeiling",
    // rust: "hasSkylight",
    // rust: "hideGUI",
    // rust: "inSwimmingAnimation",
    // rust: "isElytraFlying",
    // rust: "isRiding",
    // rust: "isRightHanded",
    // rust: "isSpectator",
    // rust: "is_burning",
    // rust: "is_hurt",
    // rust: "is_invisible",
    // rust: "is_on_ground",
    // rust: "is_sneaking",
    // rust: "is_sprinting",
    // rust: ];

// The functions of Iris 1.11.7's custom uniforms that give a float whatever numbers they take
// (our probe: into an `int` uniform, Iris refused each with numbers alone).
    // rust: const FLOAT_FUNCTIONS: [&str; 25] = [
    // rust: "acos", "asin", "atan", "atan2", "cos", "degrees", "exp", "exp10", "exp2", "frac", "log",
    // rust: "log10", "log2", "mix", "pow", "radians", "random", "sign", "signum", "sin", "smooth", "sqrt",
    // rust: "tan", "todeg", "torad",
    // rust: ];

Expr :: enum {
    // A number, and whether it is written as a float (`2.0`, not `2`).
    Num(f64, bool),
    // A name and its component (`x`, `2`, `2.1` as column 2, row 1).
    Name(String, Option<(usize, Option<usize>)>),
    Call(String, Vec<Expr>, usize),
    Neg(Box<Expr>),
    Not(Box<Expr>),
    Bin(&'static str, Box<Expr>, Box<Expr>),
}

Item :: struct {
    name: string,
    ty: string,
    uniform: bool,
    expr: Expr,
}

// The pack's custom uniforms and variables, with the state `smooth` and `random` keep.
Custom :: struct {
    items: [dynamic]Item,
    // `smooth` state per call site.
    smooth: HashMap<uint,
    seed: u64,
    unknown: map[string]struct{},
    // Per item, whether it reads 0 because it names something unknown (directly or through
    // another item); worked out on the first `eval`.
    broken: Maybe([dynamic]bool),
    // `BIOME_*`, `CAT_*` and `PPT_*` (crate::biomes).
    constants: HashMap<string,
    // Expressions that did not parse, and unknown names, as `key: message`.
    notes: [dynamic]string,
    calls: uint,
    // Whether `smooth` has started on a frame of the world (see [`Custom::world_frame`]).
    world_seen: bool,
}

    // rust: impl Custom {
    // Reads every `uniform.*` and `variable.*` key of `properties`, in file order.
parse :: proc(properties: ^Properties) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Custom {
    // rust: seed: 0x9e37_79b9_7f4a_7c15,
    // rust: constants: crate::biomes::constants(&[]),
    // rust: ..Default::default()
}
    // rust: for e in &properties.entries {
    // rust: let (uniform, rest) = match e.key.split_once('.') {
    // rust: Some(("uniform", r)) => (true, r),
    // rust: Some(("variable", r)) => (false, r),
    // rust: _ => continue,
}
    // rust: let Some((ty, name)) = rest.split_once('.') else {
    // rust: continue;
}
    // rust: if !matches!(ty, "float" | "int" | "bool" | "vec2" | "vec3" | "vec4") {
    // rust: out.notes
    // rust: .push(format!("{}: type `{ty}` is not supported", e.key));
    // rust: continue;
}
            // Tolerate one final terminator, while leaving extra statements to the parser.
    // rust: let value = e.value.trim();
    // rust: let value = value.strip_suffix(';').unwrap_or(value).trim_end();
    // rust: match Parser::new(value, &mut out.calls).expr_all() {
    // rust: Ok(expr) => out.items.push(Item {
    // rust: name: name.to_owned(),
    // rust: ty: ty.to_owned(),
    // rust: uniform,
    // rust: expr,
    // rust: }),
    // rust: Err(m) => out.notes.push(format!("{}: {m}", e.key)),
}
}
    // rust: out
}

    // Forgets what `smooth` keeps: each starts again from its next value, as on the first frame
    // (for runs whose values are not the world's: the load-time dry run, frames before the
    // camera's biome is known).
restart_smoothing :: proc(self: ^Self) {
}
    // rust: self.smooth.clear();
}

    // Called before each frame's [`Custom::eval`], with whether the camera's biome is known (its
    // chunk loaded). Until the first frame that knows it, `smooth` restarts every frame, so it
    // starts from that frame's values rather than from the frames before it (the biome reads
    // -1 there). From then on it keeps going for as long as the pack runs, through teleports
    // and the frames whose chunk isn't loaded yet: in Iris 1.11.7, our probe pack's
    // `smooth(cameraPosition.y + 200.0, 1000, 1000)` kept smoothing across teleports within a
    // dimension, and started again when the player entered the Nether.
world_frame :: proc(self: ^Self, biome_known: bool) {
}
    // rust: if !self.world_seen {
    // rust: self.restart_smoothing();
    // rust: self.world_seen = biome_known;
}
}

    // Restarts `smooth` and `random` for a frame of the world's tick `tick`, so a frame drawn
    // again at that tick evaluates the same (`HORIZON_STILL`).
restart_at :: proc(self: ^Self, tick: u64) {
}
    // rust: self.restart_smoothing();
    // rust: self.seed = (0x9e37_79b9_7f4a_7c15 ^ tick.wrapping_mul(0xbf58_476d_1ce4_e5b9)).max(1);
}

    // Names the game's biomes (registry identifiers, in id order) for `BIOME_*`.
set_biomes :: proc(self: ^Self, biomes: ^[string]) {
}
    // rust: self.constants = crate::biomes::constants(biomes);
}

    // The uniforms' names and declared types, in file order.
uniforms :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.items
    // rust: .iter()
    // rust: .filter(|i| i.uniform)
    // rust: .map(|i| (i.name.as_str(), i.ty.as_str()))
}

    // Evaluates everything for a frame `dt` seconds after the last; `builtin` gives the
    // values of the game's uniforms and constants (`BIOME_*`...). Returns the uniforms'
    // values, in the order of `uniforms`.
eval :: proc(self: ^Self, dt: f64, builtin: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.broken.is_none() {
    // rust: self.broken = Some(self.resolve(builtin));
}
    // rust: let broken = self.broken.take().unwrap_or_default();
    // rust: let mut vars: HashMap<String, Val> = HashMap::new();
    // rust: let mut out = Vec::new();
    // rust: let items = std::mem::take(&mut self.items);
    // rust: for (item, &broken) in items.iter().zip(&broken) {
    // rust: let v = if broken {
    // rust: Val::scalar(0.0)
    // rust: } else {
    // rust: self.value(&item.expr, dt, &vars, builtin)
}
    // rust: let v = match item.ty.as_str() {
    // rust: "int" => Val::scalar(v.x().trunc()),
    // rust: "bool" => Val::scalar(f64::from(u8::from(v.truth()))),
    // rust: "float" => Val::scalar(v.x()),
    // rust: t => {
    // rust: let n = (t.as_bytes()[3] - b'0') as usize;
    // rust: let mut v = v;
    // rust: if v.n == 1 {
    // rust: let x = v.v[0];
    // rust: v.v[1..n].fill(x);
}
    // rust: v.n = n;
    // rust: v
}
}
    // rust: vars.insert(item.name.clone(), v);
    // rust: if item.uniform {
    // rust: out.push(v);
}
}
    // rust: self.items = items;
    // rust: self.broken = Some(broken);
    // rust: out
}

    // Which items read 0: those naming something neither an item, the game (outside
    // [`HIDDEN`]) nor a constant gives, and then those naming such an item. Notes each once.
resolve :: proc(self: ^Self, builtin: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let items: HashSet<&str> = self.items.iter().map(|i| i.name.as_str()).collect();
    // rust: let known = |n: &str| {
    // rust: n == "pi"
    // rust: || n.starts_with("BIOME_")
    // rust: || self.constants.contains_key(n)
    // rust: || NOT_GIVEN_YET.contains(&n)
    // rust: || (!HIDDEN.contains(&n) && builtin(n).is_some())
}
    // rust: let mut broken = vec![false; self.items.len()];
    // rust: let mut uses: Vec<Vec<&str>> = Vec::new();
    // rust: for (i, item) in self.items.iter().enumerate() {
    // rust: let mut names = Vec::new();
    // rust: names_in(&item.expr, &mut names);
    // rust: if let Some(n) = names.iter().find(|n| !items.contains(*n) && !known(n)) {
    // rust: self.notes.push(format!(
    // rust: "`{}` reads 0: `{n}` is unknown to custom uniforms",
    // rust: item.name
    // rust: ));
    // rust: broken[i] = true;
    // rust: } else if let Err(why) = self.typed(item, builtin) {
    // rust: self.notes.push(format!("`{}` reads 0: {why}", item.name));
    // rust: broken[i] = true;
}
    // rust: uses.push(names.into_iter().filter(|n| items.contains(n)).collect());
}
    // rust: loop {
    // rust: let dead: HashSet<&str> = (self.items.iter().zip(&broken))
    // rust: .filter(|(_, b)| **b)
    // rust: .map(|(i, _)| i.name.as_str())
    // rust: .collect();
    // rust: let mut changed = false;
    // rust: for (i, item) in self.items.iter().enumerate() {
    // rust: if let Some(n) = uses[i].iter().find(|n| !broken[i] && dead.contains(*n)) {
    // rust: self.notes.push(format!(
    // rust: "`{}` reads 0: it uses `{n}`, which does",
    // rust: item.name
    // rust: ));
    // rust: broken[i] = true;
    // rust: changed = true;
}
}
    // rust: if !changed {
    // rust: return broken;
}
}
}

    // Whether `item`'s expression has its declared type, by the rules of [`Ty`].
typed :: proc(self: ^Self, item: ^Item, builtin: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name_ty = |n: &str| {
    // rust: if let Some(other) = self.items.iter().find(|i| i.name == n) {
    // rust: return Ty::declared(&other.ty);
}
    // rust: let int = INT_NAMES.contains(&n);
    // rust: match builtin(n) {
    // rust: _ if n == "pi" => Ty::Float,
    // rust: _ if self.constants.contains_key(n) || n.starts_with("BIOME_") => Ty::Int,
                // The game doesn't give `lightningBoltPosition` yet: its size is unknown.
    // rust: None if n == "lightningBoltPosition" => Ty::Any,
    // rust: None | Some(Val { n: 1, .. }) if int => Ty::Int,
    // rust: None | Some(Val { n: 1, .. }) if BOOL_NAMES.contains(&n) => Ty::Bool,
    // rust: None | Some(Val { n: 1, .. }) => Ty::Float,
    // rust: Some(Val { n: c @ 2..=4, .. }) => Ty::Vector(c, int),
    // rust: Some(_) => Ty::Matrix,
}
}
    // rust: let got = ty(&item.expr, &name_ty)?;
    // rust: let want = Ty::declared(&item.ty);
    // rust: if got.fits(want) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("it gives {got} where `{}` is declared", item.ty))
}
}

random :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.seed ^= self.seed << 13;
    // rust: self.seed ^= self.seed >> 7;
    // rust: self.seed ^= self.seed << 17;
    // rust: (self.seed >> 11) as f64 / (1u64 << 53) as f64
}

    // rust: fn value(
    // rust: &mut self,
    // rust: e: &Expr,
    // rust: dt: f64,
    // rust: vars: &HashMap<String, Val>,
    // rust: builtin: &dyn Fn(&str) -> Option<Val>,
    // rust: ) -> Val {
    // rust: let ev = |e: &Expr, s: &mut Self| s.value(e, dt, vars, builtin);
    // rust: match e {
    // rust: Expr::Num(x, _) => Val::scalar(*x),
    // rust: Expr::Name(name, component) => {
    // rust: let v = match name.as_str() {
    // rust: "pi" => Some(Val::scalar(std::f64::consts::PI)),
    // rust: n => vars
    // rust: .get(n)
    // rust: .copied()
    // rust: .or_else(|| builtin(n))
    // rust: .or_else(|| self.constants.get(n).map(|&x| Val::scalar(x))),
}
    // rust: if v.is_none() && name.starts_with("BIOME_") {
    // rust: if self.unknown.insert(name.clone()) {
    // rust: self.notes
    // rust: .push(format!("`{name}` names no biome; it reads -1"));
}
    // rust: return Val::scalar(-1.0);
}
    // rust: let Some(v) = v else {
    // rust: if self.unknown.insert(name.clone()) {
    // rust: self.notes.push(format!("`{name}` is unknown; it reads 0"));
}
    // rust: return Val::scalar(0.0);
}
    // rust: match component {
    // rust: None => v,
                    // `m.c.r` is GLSL's m[c][r], stored column after column: packs transform a
                    // view vector to the world as `inverse.0.0 * x + inverse.1.0 * y + ...`.
    // rust: Some((column, Some(row))) => Val::scalar(v.v[column * 4 + row]),
    // rust: Some((i, None)) => Val::scalar(v.v[*i]),
}
}
    // rust: Expr::Neg(a) => ev(a, self).map(|x| -x),
    // rust: Expr::Not(a) => Val::scalar(f64::from(u8::from(!ev(a, self).truth()))),
    // rust: Expr::Bin(op, a, b) => {
    // rust: let (a, b) = (ev(a, self), ev(b, self));
    // rust: let bool_ = |c: bool| Val::scalar(f64::from(u8::from(c)));
    // rust: match *op {
    // rust: "+" => a.zip(b, |x, y| x + y),
    // rust: "-" => a.zip(b, |x, y| x - y),
    // rust: "*" => a.zip(b, |x, y| x * y),
    // rust: "/" => a.zip(b, |x, y| x / y),
    // rust: "%" => a.zip(b, |x, y| x % y),
    // rust: "<" => bool_(a.x() < b.x()),
    // rust: "<=" => bool_(a.x() <= b.x()),
    // rust: ">" => bool_(a.x() > b.x()),
    // rust: ">=" => bool_(a.x() >= b.x()),
    // rust: "==" => bool_(a.x() == b.x()),
    // rust: "!=" => bool_(a.x() != b.x()),
    // rust: "&&" => bool_(a.truth() && b.truth()),
    // rust: _ => bool_(a.truth() || b.truth()),
}
}
    // rust: Expr::Call(f, args, _) if f == "if" => {
                // Only the conditions up to the first true one and its branch are evaluated: a
                // `smooth` in a branch not taken keeps its value and doesn't advance.
    // rust: let mut i = 0;
    // rust: while i + 1 < args.len() {
    // rust: if ev(&args[i], self).truth() {
    // rust: return ev(&args[i + 1], self);
}
    // rust: i += 2;
}
    // rust: args.last().map_or(Val::scalar(0.0), |e| ev(e, self))
}
    // rust: Expr::Call(f, args, site) => {
    // rust: let a: Vec<Val> = args.iter().map(|e| ev(e, self)).collect();
    // rust: let arg = |i: usize| a.get(i).copied().unwrap_or(Val::scalar(0.0));
    // rust: let x = arg(0).x();
    // rust: let one = |g: fn(f64) -> f64| arg(0).map(g);
    // rust: match f.as_str() {
    // rust: "sin" => one(f64::sin),
    // rust: "cos" => one(f64::cos),
    // rust: "tan" => one(f64::tan),
    // rust: "asin" => one(f64::asin),
    // rust: "acos" => one(f64::acos),
    // rust: "atan" if a.len() == 2 => Val::scalar(x.atan2(arg(1).x())),
    // rust: "atan" => one(f64::atan),
    // rust: "atan2" => Val::scalar(x.atan2(arg(1).x())),
    // rust: "torad" | "radians" => one(f64::to_radians),
    // rust: "todeg" | "degrees" => one(f64::to_degrees),
    // rust: "min" => a
    // rust: .iter()
    // rust: .copied()
    // rust: .reduce(|p, q| p.zip(q, f64::min))
    // rust: .unwrap_or(arg(0)),
    // rust: "max" => a
    // rust: .iter()
    // rust: .copied()
    // rust: .reduce(|p, q| p.zip(q, f64::max))
    // rust: .unwrap_or(arg(0)),
                    // The upper bound first, then the lower: with min > max the lower wins, as
                    // our probes read in Iris 1.11.7 (`clamp(5.0, 3.0, 1.0)` gives 3, #9307).
    // rust: "clamp" => arg(0).zip(arg(2), f64::min).zip(arg(1), f64::max),
    // rust: "abs" => one(f64::abs),
    // rust: "floor" => one(f64::floor),
    // rust: "ceil" => one(f64::ceil),
    // rust: "exp" => one(f64::exp),
    // rust: "exp2" => one(f64::exp2),
    // rust: "exp10" => one(|v| 10f64.powf(v)),
    // rust: "frac" => one(|v| v - v.floor()),
    // rust: "log" if a.len() == 2 => Val::scalar(arg(1).x().log(x)),
    // rust: "log" => one(f64::ln),
    // rust: "log2" => one(f64::log2),
    // rust: "log10" => one(f64::log10),
    // rust: "sqrt" => one(f64::sqrt),
    // rust: "signum" | "sign" => one(|v| if v == 0.0 { 0.0 } else { v.signum() }),
    // rust: "pow" => arg(0).zip(arg(1), f64::powf),
    // rust: "fmod" => arg(0).zip(arg(1), |p, q| p - q * (p / q).floor()),
    // rust: "mix" => arg(0).zip(arg(1), |p, q| p + (q - p) * arg(2).x()),
    // rust: "edge" => Val::scalar(if arg(1).x() < x { 0.0 } else { 1.0 }),
    // rust: "random" if a.len() == 2 => Val::scalar(x + (arg(1).x() - x) * self.random()),
    // rust: "random" => Val::scalar(self.random()),
    // rust: "randomInt" if a.len() == 2 => {
    // rust: Val::scalar((x + (arg(1).x() - x) * self.random()).floor())
}
    // rust: "randomInt" => Val::scalar((self.random() * f64::from(i32::MAX)).floor()),
    // rust: "smooth" => {
                        // A first argument written as a number names the call when more
                        // follow (`smooth(1, x, 2)`); any other is the value (`smooth(x, 2)`).
    // rust: let named = a.len() > 1 && matches!(args[0], Expr::Num(..));
    // rust: let rest = &a[usize::from(named)..];
    // rust: let at = |i: usize| rest.get(i).map(Val::x);
    // rust: let val = at(0).unwrap_or(0.0);
    // rust: let fade_in = at(1).unwrap_or(1.0);
    // rust: let fade_out = at(2).unwrap_or(fade_in);
    // rust: let state = self.smooth.entry(*site).or_insert(val);
    // rust: let fade = if val > *state { fade_in } else { fade_out };
                        // A value it already holds stays as it is: an infinite one too, which
                        // the step below would turn into NaN (inf - inf). Our probe read
                        // `smooth(1.0 / 0.0, 5, 5)` as +inf in Iris 1.11.7.
    // rust: if fade > 0.0 && *state != val {
    // rust: *state = val + (*state - val) * 0.5f64.powf(dt / (fade * FADE_UNIT));
    // rust: } else {
    // rust: *state = val;
}
    // rust: Val::scalar(*state)
}
    // rust: "between" => {
    // rust: Val::scalar(f64::from(u8::from(x >= arg(1).x() && x <= arg(2).x())))
}
    // rust: "equals" => {
    // rust: Val::scalar(f64::from(u8::from((x - arg(1).x()).abs() <= arg(2).x())))
}
    // rust: "in" => Val::scalar(f64::from(u8::from(a[1..].iter().any(|v| v.x() == x)))),
    // rust: "vec2" | "vec3" | "vec4" => {
    // rust: let n = (f.as_bytes()[3] - b'0') as usize;
    // rust: let mut c: Vec<f64> = a.iter().flat_map(|v| v.v[..v.n].to_vec()).collect();
    // rust: if c.len() == 1 {
    // rust: c = vec![c[0]; n];
}
    // rust: c.resize(n, 0.0);
    // rust: Val::vector(&c)
}
    // rust: _ => {
    // rust: if self.unknown.insert(f.clone()) {
    // rust: self.notes.push(format!("`{f}()` is unknown; it gives 0"));
}
    // rust: Val::scalar(0.0)
}
}
}
}
}
}

Parser :: struct {
    tokens: [dynamic]string,
    at: uint,
    calls: ^'a mut uint,
}

    // rust: const OPERATORS: [&str; 18] = [
    // rust: "||", "&&", "==", "!=", "<=", ">=", "<", ">", "+", "-", "*", "/", "%", "!", "(", ")", ",", ".",
    // rust: ];

    // rust: impl<'a> Parser<'a> {
new :: proc(text: string, calls: ^'a mut uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut tokens = Vec::new();
    // rust: let b = text.as_bytes();
    // rust: let mut i = 0;
    // rust: while i < b.len() {
    // rust: let c = b[i] as char;
    // rust: if c.is_whitespace() {
    // rust: i += 1;
    // rust: } else if c.is_ascii_digit()
    // rust: || (c == '.'
    // rust: && b.get(i + 1).is_some_and(u8::is_ascii_digit)
    // rust: && !tokens
    // rust: .last()
    // rust: .is_some_and(|t: &String| t == "." || is_name(t)))
    // rust: {
    // rust: let start = i;
    // rust: while i < b.len()
    // rust: && (b[i].is_ascii_alphanumeric()
    // rust: || b[i] == b'.'
    // rust: || ((b[i] == b'-' || b[i] == b'+') && matches!(b[i - 1], b'e' | b'E')))
    // rust: {
    // rust: i += 1;
}
    // rust: tokens.push(text[start..i].to_owned());
    // rust: } else if c.is_ascii_alphabetic() || c == '_' {
    // rust: let start = i;
    // rust: while i < b.len() && (b[i].is_ascii_alphanumeric() || b[i] == b'_') {
    // rust: i += 1;
}
    // rust: tokens.push(text[start..i].to_owned());
    // rust: } else {
    // rust: let op = OPERATORS
    // rust: .iter()
    // rust: .find(|o| text[i..].starts_with(**o))
    // rust: .map_or(&text[i..i + c.len_utf8()], |o| o);
    // rust: i += op.len();
    // rust: tokens.push(op.to_owned());
}
}
    // rust: Parser {
    // rust: tokens,
    // rust: at: 0,
    // rust: calls,
}
}
peek :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.tokens.get(self.at).map(String::as_str)
}
eat :: proc(self: ^Self, t: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let hit = self.peek() == Some(t);
    // rust: self.at += usize::from(hit);
    // rust: hit
}
expr_all :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let e = self.binary(0)?;
    // rust: match self.peek() {
    // rust: None => Ok(e),
    // rust: Some(t) => Err(format!("unexpected `{t}`")),
}
}
    // Precedence levels from the loosest: `||`, `&&`, equality, relations, sums, products.
binary :: proc(self: ^Self, level: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: const LEVELS: [&[&str]; 6] = [
    // rust: &["||"],
    // rust: &["&&"],
    // rust: &["==", "!="],
    // rust: &["<", "<=", ">", ">="],
    // rust: &["+", "-"],
    // rust: &["*", "/", "%"],
    // rust: ];
    // rust: if level == LEVELS.len() {
    // rust: return self.unary();
}
    // rust: let mut left = self.binary(level + 1)?;
    // rust: while let Some(op) = self
    // rust: .peek()
    // rust: .and_then(|t| LEVELS[level].iter().find(|o| **o == t))
    // rust: {
    // rust: self.at += 1;
    // rust: let right = self.binary(level + 1)?;
    // rust: left = Expr::Bin(op, Box::new(left), Box::new(right));
}
    // rust: Ok(left)
}
unary :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.eat("-") {
    // rust: return Ok(Expr::Neg(Box::new(self.unary()?)));
}
    // rust: if self.eat("!") {
    // rust: return Ok(Expr::Not(Box::new(self.unary()?)));
}
    // rust: self.eat("+");
    // rust: self.primary()
}
primary :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(t) = self.peek().map(str::to_owned) else {
    // rust: return Err("the expression ends early".into());
}
    // rust: self.at += 1;
    // rust: if t == "(" {
    // rust: let e = self.binary(0)?;
    // rust: return if self.eat(")") {
    // rust: Ok(e)
    // rust: } else {
    // rust: Err("missing `)`".into())
}
}
    // rust: if t.starts_with(|c: char| c.is_ascii_digit() || c == '.') {
    // rust: return t
    // rust: .trim_end_matches(['f', 'F'])
    // rust: .parse()
    // rust: .map(|x| Expr::Num(x, t.contains(['.', 'e', 'E', 'f', 'F'])))
    // rust: .map_err(|_| format!("bad number `{t}`"));
}
    // rust: if !is_name(&t) {
    // rust: return Err(format!("unexpected `{t}`"));
}
    // rust: if self.eat("(") {
    // rust: let mut args = Vec::new();
    // rust: if !self.eat(")") {
    // rust: loop {
    // rust: args.push(self.binary(0)?);
    // rust: if self.eat(")") {
    // rust: break;
}
    // rust: if !self.eat(",") {
    // rust: return Err(format!("missing `)` after the arguments of `{t}`"));
}
}
}
    // rust: if t == "smooth" {
    // rust: smooth_arguments(&args)?;
}
    // rust: *self.calls += 1;
    // rust: return Ok(Expr::Call(t, args, *self.calls));
}
    // rust: let component = if self.eat(".") {
    // rust: let c = self.peek().map(str::to_owned).ok_or("nothing after `.`")?;
    // rust: self.at += 1;
    // rust: let index = |s: &str| match s {
    // rust: "x" | "r" | "s" | "0" => Some(0),
    // rust: "y" | "g" | "t" | "1" => Some(1),
    // rust: "z" | "b" | "p" | "2" => Some(2),
    // rust: "w" | "a" | "q" | "3" => Some(3),
    // rust: _ => None,
}
    // rust: Some(match c.split_once('.') {
    // rust: Some((r, col)) => (
    // rust: index(r).ok_or(format!("bad component `{c}`"))?,
    // rust: Some(index(col).ok_or(format!("bad component `{c}`"))?),
    // rust: ),
    // rust: None => (index(&c).ok_or(format!("bad component `{c}`"))?, None),
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: Ok(Expr::Name(t, component))
}
}

// The `smooth` calls Iris 1.11.7 resolves: `smooth(val)`, `smooth(val, fade)`,
// `smooth(val, fadeIn, fadeOut)`, and the same with a number written first as the call's id
// (`smooth(1, val, fadeIn, fadeOut)`). It drops a uniform with any other, which then reads 0.
smooth_arguments :: proc(args: ^[Expr]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let named = args.len() > 1 && matches!(args[0], Expr::Num(..));
    // rust: if (1..=3).contains(&(args.len() - usize::from(named))) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!(
    // rust: "`smooth` with {} arguments{} (Iris reads it as 0)",
    // rust: args.len(),
    // rust: if named {
    // rust: ""
    // rust: } else {
    // rust: ", the first not a number"
}
    // rust: ))
}
}

// The type of an expression, for the check Iris 1.11.7 makes before it keeps a custom uniform
// or variable (#9086, #9126). The rules are a fit to our probe packs' values and warnings in
// Iris, not a rule Iris documents:
// - A number is an `int` (`2`) or a `float` (`2.0`). `pi` is a float, `BIOME_*`, `CAT_*` and
//   `PPT_*` are ints, and the built-ins have the types of [`INT_NAMES`] and [`BOOL_NAMES`].
//   `true` and `false` aren't names there at all.
// - The only conversion is an `int` taken as a `float`: `float = 2` and `sin(0)` work, while
//   `int = 2.0`, `float = 1 > 0`, `bool = 1` and `vec2 = eyeBrightness` (an int vector) read 0.
// - `+ - * %` of two ints give an int, with a float a float; `/` always gives a float
//   (`int = 7 / 2` reads 0). They take no bool. A vector meets only the same vector type:
//   `vec3 * 2.0`, `vec3 + vec2` and `eyeBrightness + vec2(...)` read 0. Unary minus keeps the
//   type and takes no bool.
// - `< <= > >=` take numbers, `== !=` two numbers or two bools, `&& || !` bools; all give a
//   bool.
// - `vecN(...)` takes exactly N numbers. `floor` and `ceil` give an int, and so does
//   `randomInt`, which takes ints only; `abs`, `min`, `max`, `clamp`, `fmod` and `edge` the
//   type of their numbers; [`FLOAT_FUNCTIONS`] a
//   float; `between`, `equals` and `in` a bool; `if` takes bool conditions and values of one
//   type (an int and a float give a float). `abs`, `floor`, `ceil`, `min`/`max` of two,
//   `clamp` and three-argument `if` also take vectors of one type; every other function only
//   scalars. `round`, `ifb`, `lerp` and `print` are no functions there (Iris warns "No such
//   function"), nor is any other name.
// - A matrix counts only through a component (`m.0.1`).
Ty :: enum {
    // A name whose type we don't know (`lightningBoltPosition`): it fits anything.
    Any,
    Int,
    Float,
    Bool,
    // A vector of N components, of ints when `true` (`eyeBrightness`).
    Vector(usize, bool),
    Matrix,
}

    // rust: impl Ty {
declared :: proc(ty: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match ty {
    // rust: "int" => Ty::Int,
    // rust: "bool" => Ty::Bool,
    // rust: "vec2" | "vec3" | "vec4" => Ty::Vector((ty.as_bytes()[3] - b'0') as usize, false),
    // rust: _ => Ty::Float,
}
}
    // Whether a value of this type may stand where `want` is expected.
fits :: proc(self: ^Self, want: Ty) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == want || self == Ty::Any || want == Ty::Any || (self, want) == (Ty::Int, Ty::Float)
}
vector :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Ty::Vector(..))
}
    // The type `types` share, `Any` aside, for vectors and bools.
same :: proc(types: ^[Ty]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Ty::Any;
    // rust: for &t in types {
    // rust: if t != Ty::Any && out != Ty::Any && t != out {
    // rust: return None;
}
    // rust: if t != Ty::Any {
    // rust: out = t;
}
}
    // rust: Some(out)
}
}

    // rust: impl std::fmt::Display for Ty {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Ty::Any => write!(f, "unknown"),
    // rust: Ty::Int => write!(f, "an int"),
    // rust: Ty::Float => write!(f, "a float"),
    // rust: Ty::Bool => write!(f, "a bool"),
    // rust: Ty::Vector(n, false) => write!(f, "a vec{n}"),
    // rust: Ty::Vector(n, true) => write!(f, "an ivec{n}"),
    // rust: Ty::Matrix => write!(f, "a matrix"),
}
}
}

// Numbers only: a float when one of `types` is, else an int.
numbers :: proc(types: ^[Ty], what: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Ty::Any;
    // rust: for &t in types {
    // rust: match t {
    // rust: Ty::Any => {}
    // rust: Ty::Int if out != Ty::Float => out = Ty::Int,
    // rust: Ty::Int => {}
    // rust: Ty::Float => out = Ty::Float,
    // rust: _ => return Err(format!("{what} is given {t}")),
}
}
    // rust: Ok(out)
}

boolean :: proc(t: Ty, what: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if t.fits(Ty::Bool) {
    // rust: Ok(Ty::Bool)
    // rust: } else {
    // rust: Err(format!("{what} is given {t}"))
}
}

// The type of `e` (rules on [`Ty`]), or why it has none.
ty :: proc(e: ^Expr, name: ^dyn Fn(string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match e {
    // rust: Expr::Num(_, float) => Ok(if *float { Ty::Float } else { Ty::Int }),
    // rust: Expr::Name(n, Some(_)) => Ok(match name(n) {
    // rust: Ty::Vector(_, true) => Ty::Int,
    // rust: Ty::Vector(_, false) | Ty::Matrix => Ty::Float,
    // rust: t => t,
    // rust: }),
    // rust: Expr::Name(n, None) => match name(n) {
    // rust: Ty::Matrix => Err(format!("the matrix `{n}` is used without a component")),
    // rust: t => Ok(t),
    // rust: },
    // rust: Expr::Neg(a) => match ty(a, name)? {
    // rust: Ty::Bool => Err("`-` is given a bool".into()),
    // rust: t => Ok(t),
    // rust: },
    // rust: Expr::Not(a) => boolean(ty(a, name)?, "`!`"),
    // rust: Expr::Bin(op, a, b) => {
    // rust: let (a, b) = (ty(a, name)?, ty(b, name)?);
    // rust: let what = format!("`{op}`");
    // rust: match *op {
    // rust: "+" | "-" | "*" | "/" | "%" if a.vector() || b.vector() => {
    // rust: Ty::same(&[a, b]).ok_or_else(|| format!("`{op}` joins {a} and {b}"))
}
    // rust: "+" | "-" | "*" | "%" => numbers(&[a, b], &what),
    // rust: "/" => numbers(&[a, b], &what).map(|_| Ty::Float),
    // rust: "&&" | "||" => boolean(a, &what).and(boolean(b, &what)),
    // rust: "==" | "!=" if a.fits(Ty::Bool) && b.fits(Ty::Bool) => Ok(Ty::Bool),
    // rust: _ => numbers(&[a, b], &what).map(|_| Ty::Bool),
}
}
    // rust: Expr::Call(f, args, _) => {
    // rust: let a = args
    // rust: .iter()
    // rust: .map(|e| ty(e, name))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let what = format!("`{f}`");
    // rust: let same = || Ty::same(&a).ok_or_else(|| format!("`{f}` mixes types"));
    // rust: let scalars = !a.iter().any(|t| t.vector());
    // rust: const OTHERS: [&str; 15] = [
    // rust: "vec2",
    // rust: "vec3",
    // rust: "vec4",
    // rust: "abs",
    // rust: "floor",
    // rust: "ceil",
    // rust: "min",
    // rust: "max",
    // rust: "clamp",
    // rust: "fmod",
    // rust: "edge",
    // rust: "randomInt",
    // rust: "between",
    // rust: "equals",
    // rust: "in",
    // rust: ];
    // rust: if !(OTHERS.contains(&f.as_str()) || f == "if" || FLOAT_FUNCTIONS.contains(&f.as_str()))
    // rust: {
    // rust: return Err(format!("`{f}()` is no function of custom uniforms"));
}
    // rust: match f.as_str() {
    // rust: "vec2" | "vec3" | "vec4" => {
    // rust: let n = (f.as_bytes()[3] - b'0') as usize;
    // rust: match numbers(&a, &what) {
    // rust: Ok(_) if a.len() == n => Ok(Ty::Vector(n, false)),
    // rust: _ => Err(format!("`{f}` takes {n} numbers")),
}
}
    // rust: "abs" | "floor" | "ceil" if a.len() == 1 && !scalars => Ok(a[0]),
    // rust: "min" | "max" if a.len() == 2 && !scalars => same(),
    // rust: "clamp" if a.len() == 3 && !scalars => same(),
    // rust: "if" if a.len() == 3 && !scalars => {
    // rust: boolean(a[0], "the condition of `if`")?;
    // rust: Ty::same(&a[1..]).ok_or_else(|| format!("`{f}` mixes types"))
}
    // rust: _ if !scalars => Err(format!("`{f}` takes scalars only")),
    // rust: "floor" | "ceil" => numbers(&a, &what).map(|_| Ty::Int),
    // rust: "abs" | "min" | "max" | "clamp" | "fmod" | "edge" => numbers(&a, &what),
    // rust: "randomInt" if a.iter().all(|t| t.fits(Ty::Int)) => Ok(Ty::Int),
    // rust: "randomInt" => Err("`randomInt` takes ints only".into()),
    // rust: "between" | "equals" | "in" => numbers(&a, &what).map(|_| Ty::Bool),
    // rust: "if" => {
    // rust: let mut values = Vec::new();
    // rust: for (i, &t) in a.iter().enumerate() {
    // rust: if i % 2 == 0 && i + 1 < a.len() {
    // rust: boolean(t, "a condition of `if`")?;
    // rust: } else {
    // rust: values.push(t);
}
}
    // rust: match Ty::same(&values) {
    // rust: Some(Ty::Bool) => Ok(Ty::Bool),
    // rust: _ => numbers(&values, &what),
}
}
    // rust: _ => numbers(&a, &what).map(|_| Ty::Float),
}
}
}
}

// The names `e` reads, calls left out, in order.
    // rust: fn names_in<'e>(e: &'e Expr, out: &mut Vec<&'e str>) {
    // rust: match e {
    // rust: Expr::Num(..) => {}
    // rust: Expr::Name(n, _) => out.push(n),
    // rust: Expr::Call(_, args, _) => args.iter().for_each(|a| names_in(a, out)),
    // rust: Expr::Neg(a) | Expr::Not(a) => names_in(a, out),
    // rust: Expr::Bin(_, a, b) => {
    // rust: names_in(a, out);
    // rust: names_in(b, out);
}
}
}

is_name :: proc(t: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: t.starts_with(|c: char| c.is_ascii_alphabetic() || c == '_')
}

    // rust: mod tests {
//     use super::*;
//     use crate::Macros;

custom :: proc(text: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Custom::parse(&Properties::parse(text, &Macros::standard()))
}

one_trailing_terminator_preserves_variable_and_uniform_values :: proc() {
}
    // rust: for text in [
    // rust: "variable.float.base = 0.25;\nuniform.float.answer = base * 2;\n",
    // rust: "variable.float.base = 0.25;  \nuniform.float.answer = base * 2;  \n",
    // rust: "variable.float.base = 0.25\nuniform.float.answer = base * 2\n",
    // rust: ] {
    // rust: let mut parsed = custom(text);
    // rust: assert!(parsed.notes.is_empty(), "{:?}", parsed.notes);
    // rust: assert_eq!(parsed.eval(0.016, &|_| None), [Val::scalar(0.5)]);
    // rust: assert!(parsed.notes.is_empty(), "{:?}", parsed.notes);
}
}

terminator_does_not_allow_extra_statements_or_empty_expressions :: proc() {
}
    // rust: for expression in ["0.5; 0.1", "0.5;;", ";"] {
    // rust: let parsed = custom(&format!("uniform.float.answer = {expression}\n"));
    // rust: assert!(!parsed.notes.is_empty(), "{expression}");
    // rust: assert_eq!(parsed.uniforms().count(), 0);
}
}

expressions_follow_c_precedence_and_file_order :: proc() {
}
    // rust: let mut c = custom(
    // rust: "variable.float.a = 1 + 2 * 3 - 4 % 3\n\
    // rust: uniform.float.b = a / 2\n\
    // rust: uniform.bool.c = a > 5 && !(b < 1) || false\n\
    // rust: uniform.int.d = -7 / 2\n\
    // rust: uniform.vec3.e = vec3(a, cameraPosition.y, 2) * 2\n\
    // rust: uniform.float.f = if(a < 0, 1, a < 7, 2, 3) + clamp(fmod(-1, 4), 0, 2.5) + min(4, 2, 3)\n\
    // rust: uniform.float.g = gbufferModelView.0.1 + frac(sunAngle - 0.25) + pi * 0\n\
    // rust: uniform.float.h = unknownThing + in(biome, 3, BIOME_DESERT)\n\
    // rust: uniform.bool.i = biome == BIOME_PALE_GARDEN || biome == BIOME_OLD\n\
    // rust: uniform.int.j = CAT_OCEAN + PPT_RAIN\n",
    // rust: );
    // rust: c.set_biomes(&["minecraft:beach", "minecraft:desert"]);
    // rust: assert!(c.notes.is_empty(), "{:?}", c.notes);
    // rust: let names: Vec<_> = c.uniforms().map(|u| u.0).collect();
    // rust: assert_eq!(names, ["b", "c", "d", "e", "f", "g", "h", "i", "j"]);
    // rust: let builtin = |n: &str| match n {
    // rust: "cameraPosition" => Some(Val::vector(&[1.0, 64.0, 2.0])),
    // rust: "sunAngle" => Some(Val::scalar(0.125)),
            // Desert, as Iris numbers it.
    // rust: "biome" => Some(Val::scalar(5.0)),
    // rust: "gbufferModelView" => {
    // rust: let mut m = Val::scalar(0.0);
    // rust: m.v[1] = 9.0; // column 0, row 1
    // rust: m.n = 16;
    // rust: Some(m)
}
    // rust: _ => None,
}
    // rust: let v = c.eval(0.016, &builtin);
    // rust: let x: Vec<f64> = v.iter().map(|v| v.v[0]).collect();
    // rust: assert_eq!(
    // rust: x,
    // rust: [
    // rust: 3.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 2.0 + 2.5 + 2.0,
    // rust: 9.0 + 0.875,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 12.0
    // rust: ]
    // rust: );
        // Iris 1.11.7 doesn't take `false` (#9126), `int = -7 / 2` (`/` gives a float, #9126) or
        // `vec3 * 2` (a vector and a scalar, #9086).
    // rust: assert_eq!(&v[3].v[..3], &[0.0, 0.0, 0.0]);
    // rust: assert_eq!(
    // rust: c.notes,
    // rust: [
    // rust: "`c` reads 0: `false` is unknown to custom uniforms",
    // rust: "`d` reads 0: it gives a float where `int` is declared",
    // rust: "`e` reads 0: `*` joins a vec3 and an int",
    // rust: "`h` reads 0: `unknownThing` is unknown to custom uniforms",
    // rust: "`BIOME_PALE_GARDEN` names no biome; it reads -1",
    // rust: "`BIOME_OLD` names no biome; it reads -1"
    // rust: ]
    // rust: );
}

    // Iris 1.11.7, read back with probe packs of our own in three scenes: with the lower bound
    // above the upper one, `clamp(5.0, 3.0, 1.0)`, `clamp(0.0, 3.0, 1.0)` and
    // `clamp(2.0, 3.0, 1.0)` read 3, and `clamp(vec2(5.0, 0.5), vec2(3.0, 0.0), vec2(1.0, 1.0))`
    // reads (3, 0.5).
clamp_with_its_bounds_crossed_gives_the_lower_one :: proc() {
}
    // rust: let mut c = custom(
    // rust: "uniform.float.a = clamp(5.0, 3.0, 1.0)\n\
    // rust: uniform.float.b = clamp(0.0, 3.0, 1.0)\n\
    // rust: uniform.float.c = clamp(2.0, 3.0, 1.0)\n\
    // rust: uniform.float.d = clamp(2.0, 1.0, 3.0)\n\
    // rust: uniform.float.e = clamp(-2.0, 1.0, 3.0)\n\
    // rust: uniform.vec2.f = clamp(vec2(5.0, 0.5), vec2(3.0, 0.0), vec2(1.0, 1.0))\n",
    // rust: );
    // rust: assert!(c.notes.is_empty(), "{:?}", c.notes);
    // rust: let v = c.eval(0.016, &|_| None);
    // rust: let x: Vec<f64> = v[..5].iter().map(|v| v.v[0]).collect();
    // rust: assert_eq!(x, [3.0, 3.0, 3.0, 2.0, 1.0]);
    // rust: assert_eq!(&v[5].v[..2], &[3.0, 0.5]);
}

    // Iris 1.11.7, read back with probe packs of our own after 3 s to 30 s in a scene:
    // `smooth(1.0 / 0.0, 5, 5)` reads +inf, `smooth(-1.0 / 0.0, 5, 5)` -inf and
    // `smooth(0.0 / 0.0, 5, 5)` NaN.
smooth_keeps_an_infinite_value :: proc() {
}
    // rust: let mut c = custom(
    // rust: "uniform.float.a = smooth(1.0 / 0.0, 5, 5)\n\
    // rust: uniform.float.b = smooth(-1.0 / 0.0, 5, 5)\n\
    // rust: uniform.float.c = smooth(0.0 / 0.0, 5, 5)\n",
    // rust: );
    // rust: assert!(c.notes.is_empty(), "{:?}", c.notes);
    // rust: for _ in 0..100 {
    // rust: let v = c.eval(0.016, &|_| None);
    // rust: assert_eq!(v[0].v[0], f64::INFINITY);
    // rust: assert_eq!(v[1].v[0], f64::NEG_INFINITY);
    // rust: assert!(v[2].v[0].is_nan());
}
}

smooth_halves_the_distance_per_tenth_of_its_fade_time :: proc() {
}
    // rust: let mut c = custom("uniform.float.s = smooth(1, target, 20, 5)\n");
    // rust: let mut target = 0.0;
    // rust: let mut run = |t: f64, dt: f64| {
    // rust: target = t;
    // rust: c.eval(dt, &|n: &str| (n == "target").then(|| Val::scalar(target)))[0].v[0]
}
    // rust: assert_eq!(run(0.0, 0.0), 0.0);
    // rust: assert!((run(1.0, 2.0) - 0.5).abs() < 1e-9, "rising: fadeIn");
    // rust: assert!((run(0.0, 0.5) - 0.25).abs() < 1e-9, "falling: fadeOut");
}

    // Iris 1.11.7 with a probe pack of our own, over the scene suite's weather: `weather rain`
    // (the rain level climbs 0.01 a tick, vanilla's `ServerLevel.advanceWeatherCycle`) and a
    // picture 9.1 s later, then `weather clear` and a picture 9.2 s after that, then one more
    // 4.3 s on. Read there: `smooth(rainStrength, 20, 20)` 0.871, 0.118, 0.027;
    // `smooth(rainStrength, 2, 10)` 1.0, 0.020, 0.0; `smooth(rainStrength, 5, 5)` 1.0, 0.0, 0.0.
smooth_follows_the_rain_as_iris_does :: proc() {
}
    // rust: let mut c = custom(
    // rust: "uniform.float.a = smooth(rainStrength, 20, 20)\n\
    // rust: uniform.float.b = smooth(rainStrength, 2, 10)\n\
    // rust: uniform.float.c = smooth(rainStrength, 5, 5)\n",
    // rust: );
    // rust: let dt = 1.0 / 60.0;
    // rust: let (mut rain, mut read) = (0.0f64, Vec::new());
    // rust: for (seconds, target) in [(9.1, 1.0), (9.2, 0.0), (4.3, 0.0)] {
    // rust: for _ in 0..(seconds / dt) as usize {
    // rust: rain = if target > rain {
    // rust: (rain + dt / 5.0).min(1.0)
    // rust: } else {
    // rust: (rain - dt / 5.0).max(0.0)
}
    // rust: let r = rain;
    // rust: read = c.eval(dt, &|n: &str| (n == "rainStrength").then(|| Val::scalar(r)));
}
    // rust: let got: Vec<f64> = read.iter().map(|v| v.v[0]).collect();
    // rust: let iris = match target {
    // rust: 1.0 => [0.871, 1.0, 1.0],
    // rust: _ if seconds > 9.0 => [0.118, 0.020, 0.0],
    // rust: _ => [0.027, 0.0, 0.0],
}
    // rust: for (g, i) in got.iter().zip(iris) {
    // rust: assert!((g - i).abs() < 0.03, "{got:?} against Iris's {iris:?}");
}
}
}

    // Iris 1.11.7 with a probe pack of our own (#9371): a step in `worldTime / 24000` from 0.25
    // to 0.75, read 1.355 s later, and a square wave's fall read 0.575 s later. Read there:
    // fades 3, 10 and 30 give 0.7282, 0.5545 and 0.3844; the default fade 0.0186. Our probe's
    // values fit a half-life of 0.1 s × the fade for every input tried (a fit, not Iris's code).
smooth_steps_as_iris_does_for_other_inputs_and_the_default_fade :: proc() {
}
    // rust: let mut c = custom(
    // rust: "uniform.float.a = smooth(worldTime / 24000.0, 3.0)\n\
    // rust: uniform.float.b = smooth(worldTime / 24000.0, 10.0)\n\
    // rust: uniform.float.c = smooth(worldTime / 24000.0, 30.0)\n\
    // rust: uniform.float.d = smooth(if(worldTime > 15000, 0.0, 1.0))\n",
    // rust: );
    // rust: let mut hold = |time: f64, seconds: f64| {
    // rust: let mut read = Vec::new();
    // rust: for _ in 0..(seconds * 120.0).round() as usize {
    // rust: read = c.eval(1.0 / 120.0, &|n: &str| {
    // rust: (n == "worldTime").then(|| Val::scalar(time))
    // rust: });
}
    // rust: read.iter().map(|v| v.v[0]).collect::<Vec<f64>>()
}
    // rust: hold(6000.0, 60.0);
    // rust: let got = hold(18000.0, 1.355);
    // rust: for (g, iris) in got.iter().zip([0.7282, 0.5545, 0.3844]) {
    // rust: assert!((g - iris).abs() < 0.01, "{got:?}: Iris read {iris}");
}
    // rust: hold(6000.0, 60.0);
    // rust: let got = hold(18000.0, 0.575);
    // rust: assert!(
    // rust: (got[3] - 0.0186).abs() < 0.005,
    // rust: "default fade: {got:?}, Iris read 0.0186"
    // rust: );
}

    // Iris 1.11.7 with a probe pack of our own (#9371): our probe's Iris readings fit a `smooth`
    // inside an `if` branch keeping its value while the branch isn't taken (within 0.008;
    // updated every frame misses by up to 0.14). A fit, not Iris's code. The probe's
    // `if(fmod(frameTimeCounter, 4) < 2, smooth(sq, 10), 0.5)`, with `sq` a square wave of 16 s
    // (1 for 8 s, then 0), read in Iris at these points of the wave: 1.214 s 0.5962, 5.557 s
    // 0.9205, 12.254 s 0.1965, 13.264 s 0.1041, 13.963 s 0.0603. Updated every frame, the
    // smooth would read 0.571, 0.979, 0.052, 0.026 and 0.016 there.
smooth_in_a_branch_not_taken_keeps_its_value :: proc() {
}
    // rust: let mut c = custom(
    // rust: "variable.float.sq = if(fmod(frameTimeCounter, 16.0) < 8.0, 1.0, 0.0)\n\
    // rust: uniform.float.br = if(fmod(frameTimeCounter, 4.0) < 2.0, smooth(sq, 10.0), 0.5)\n",
    // rust: );
    // rust: let dt = 1.0 / 120.0;
    // rust: let mut iris = vec![
    // rust: (1.214, 0.5962),
    // rust: (5.557, 0.9205),
    // rust: (12.254, 0.1965),
    // rust: (13.264, 0.1041),
    // rust: (13.963, 0.0603),
    // rust: ];
    // rust: for frame in 0..16 * 120 * 20 {
    // rust: let t = frame as f64 * dt;
    // rust: let got = c.eval(dt, &|n: &str| {
    // rust: (n == "frameTimeCounter").then(|| Val::scalar(t))
    // rust: })[0]
    // rust: .v[0];
            // The last of 20 periods: the wave has long forgotten where it started.
    // rust: let phase = t - 16.0 * 19.0;
    // rust: if let Some(i) = iris.iter().position(|p| (phase - p.0).abs() < dt / 2.0) {
    // rust: let (at, want) = iris.remove(i);
    // rust: assert!(
    // rust: (got - want).abs() < 0.02,
    // rust: "{got} at {at} s, Iris read {want}"
    // rust: );
}
}
    // rust: assert!(iris.is_empty(), "not reached: {iris:?}");
}

    // After a restart `smooth` starts from its next value, as on the first frame, instead of
    // fading from the old one (a 1000-second fade from a dry run's zero).
smooth_starts_again_from_its_next_value_after_a_restart :: proc() {
}
    // rust: let mut c = custom("uniform.float.s = smooth(target, 1000, 1000)\n");
    // rust: let eval = |c: &mut Custom, t: f64| {
    // rust: c.eval(0.05, &|n: &str| (n == "target").then(|| Val::scalar(t)))[0].v[0]
}
    // rust: assert_eq!(eval(&mut c, 0.0), 0.0);
    // rust: assert!(eval(&mut c, 0.6) < 0.01, "the fade holds the old value");
    // rust: c.restart_smoothing();
    // rust: assert_eq!(eval(&mut c, 0.6), 0.6);
}

    // Iris 1.11.7, with a probe pack of our own (`scenes.json`'s caves after loading at the
    // spawn): `smooth(cameraPosition.y + 200.0, 1000, 1000)` read 294.1, 291.1 and 288.1 in three
    // scenes after teleports to y -5.4, -5.4 and 23.6, still fading from the spawn's 300, and
    // `smooth(biome_category + 0.0, 1000, 1000)` read the biome's 10.0 in every scene. Horizon
    // started both again after each teleport, from the frames before the chunk was loaded:
    // 194.6 and 0.4 (the biome reads 0 there).
smooth_starts_once_the_biome_is_known_and_keeps_going_through_teleports :: proc() {
}
    // rust: let mut c = custom(
    // rust: "uniform.float.cat = smooth(biome_category + 0.0, 1000, 1000)\n\
    // rust: uniform.float.y = smooth(cameraPosition.y + 200.0, 1000, 1000)\n",
    // rust: );
    // rust: let frame = |c: &mut Custom, known: bool, cat: f64, y: f64| {
    // rust: c.world_frame(known);
    // rust: let out = c.eval(0.05, &|n: &str| match n {
    // rust: "biome_category" => Some(Val::scalar(cat)),
    // rust: "cameraPosition" => Some(Val::vector(&[0.5, y, 0.5])),
    // rust: _ => None,
    // rust: });
    // rust: (out[0].v[0], out[1].v[0])
}
        // Loading: the camera's chunk isn't there yet, so its biome reads 0.
    // rust: frame(&mut c, false, 0.0, 100.0);
    // rust: frame(&mut c, false, 0.0, 100.0);
    // rust: assert_eq!(frame(&mut c, true, 10.0, 100.0), (10.0, 300.0));
        // A teleport: a few frames before the chunk is there, then the scene.
    // rust: for _ in 0..3 {
    // rust: frame(&mut c, false, 0.0, -5.38);
}
    // rust: let (cat, y) = (0..60).fold((0.0, 0.0), |_, _| frame(&mut c, true, 10.0, -5.38));
    // rust: assert!(cat > 9.9, "the biome's category from the start: {cat}");
    // rust: assert!(y > 290.0, "still fading from the spawn's 300: {y}");
}

a_restart_at_a_tick_evaluates_that_tick_the_same_again :: proc() {
}
    // rust: let mut c = custom("uniform.float.r = random()\nuniform.float.s = smooth(target, 1000)\n");
    // rust: let eval = |c: &mut Custom, tick: u64, t: f64| {
    // rust: c.restart_at(tick);
    // rust: c.eval(0.05, &|n: &str| (n == "target").then(|| Val::scalar(t)))
}
    // rust: let first = eval(&mut c, 7, 0.0);
    // rust: let other = eval(&mut c, 8, 0.6);
    // rust: assert_eq!(eval(&mut c, 7, 0.0), first);
    // rust: assert_ne!(other[0], first[0], "another tick draws another random");
    // rust: assert_eq!(other[1].v[0], 0.6, "smooth starts at its target");
}

    // Iris 1.11.7, with a probe pack of our own: a first argument written as a number is the
    // call's id when more follow (`smooth(1, 5, f)` reads 5, `smooth(5, f)` reads f); any
    // other first argument is the value (`smooth(1.5 * 2, 6.5)` reads 3).
smooth_reads_a_leading_number_as_its_id :: proc() {
}
    // rust: let mut c = custom(
    // rust: "uniform.float.a = smooth(1, 5, 0.0001)\n\
    // rust: uniform.float.b = smooth(5, 0.0001)\n\
    // rust: uniform.float.c = smooth(2.5, 6, 0.0001)\n\
    // rust: uniform.float.d = smooth((2), 6, 0.0001)\n\
    // rust: uniform.float.e = smooth(y, 5, 0.0001)\n\
    // rust: uniform.float.f = smooth(1.5 * 2, 6.5)\n\
    // rust: uniform.float.g = smooth(-3, 6, 0.0001)\n\
    // rust: uniform.float.h = smooth(7, y)\n\
    // rust: uniform.float.i = smooth(4)\n",
    // rust: );
    // rust: assert!(c.notes.is_empty(), "{:?}", c.notes);
    // rust: let v = c.eval(0.016, &|n: &str| (n == "y").then(|| Val::scalar(6.96)));
    // rust: let x: Vec<f64> = v.iter().map(|v| v.v[0]).collect();
    // rust: assert_eq!(x, [5.0, 0.0001, 6.0, 6.0, 6.96, 3.0, -3.0, 6.96, 4.0]);
}

    // Iris 1.11.7 drops a uniform whose `smooth` has four arguments and no number first, or
    // five: it reads 0 there, as a uniform Horizon leaves out does.
smooth_calls_iris_does_not_resolve_are_left_out :: proc() {
}
    // rust: let c = custom(
    // rust: "uniform.float.a = smooth(y, 5, 0.0001, 0.0001)\n\
    // rust: uniform.float.b = smooth(3, 6.5, 0.0001, 0.0001, 9)\n\
    // rust: uniform.float.c = smooth(3, 6.5, 0.0001, 0.0001)\n",
    // rust: );
    // rust: assert_eq!(c.uniforms().map(|u| u.0).collect::<Vec<_>>(), ["c"]);
    // rust: assert_eq!(c.notes.len(), 2, "{:?}", c.notes);
}

bad_expressions_are_reported :: proc() {
}
    // rust: let c = custom("uniform.float.a = (1 + \nuniform.mat4.m = 1\nuniform.float.ok = 2\n");
    // rust: assert_eq!(c.uniforms().count(), 1);
    // rust: assert_eq!(c.notes.len(), 2, "{:?}", c.notes);
}

    // Iris 1.11.7, with our probe pack of #8995: an expression naming something the custom
    // uniforms can't see reads 0 as a whole, even in an `if` branch not taken, and so does
    // anything using its uniform or variable.
a_name_custom_uniforms_cannot_see_fails_the_whole_expression :: proc() {
}
    // rust: let mut c = custom(
    // rust: "variable.float.v0 = fogStart * 0.0 + 2.0\n\
    // rust: variable.float.v1 = 5.0\n\
    // rust: uniform.float.u0 = 2.0\n\
    // rust: uniform.float.u1 = dimension * 0.0 + 2.0\n\
    // rust: uniform.float.u2 = fogColor.r * 0.0 + 2.0\n\
    // rust: uniform.float.u3 = notAName * 0.0 + 2.0\n\
    // rust: uniform.float.u4 = if(1 > 0, 2.0, fogStart)\n\
    // rust: uniform.float.u5 = u0 + 1.0\n\
    // rust: uniform.float.u6 = u2 + 1.0\n\
    // rust: uniform.float.u7 = v0 + 1.0\n\
    // rust: uniform.float.u8 = v1 + 1.0\n\
    // rust: uniform.float.u9 = frameTime * 0.0 + 2.0\n\
    // rust: uniform.vec3.w = vec3(skyColor.r, entityColor.a, blockEntityId) * 0.0 + 2.0\n\
    // rust: uniform.float.r = currentRenderedItemId * 0.0 + lightningBoltPosition.x + 2.0\n",
    // rust: );
        // The game gives every name here but `notAName`, `currentRenderedItemId` and
        // `lightningBoltPosition`, as Horizon's frame uniforms do.
    // rust: let builtin = |n: &str| match n {
    // rust: "notAName" | "currentRenderedItemId" | "lightningBoltPosition" => None,
    // rust: "fogColor" | "skyColor" => Some(Val::vector(&[0.5, 0.6, 0.7])),
    // rust: "entityColor" => Some(Val::vector(&[0.0; 4])),
    // rust: _ => Some(Val::scalar(1.0)),
}
    // rust: let x: Vec<f64> = c.eval(0.016, &builtin).iter().map(|v| v.v[0]).collect();
        // `w` reads 0 as well: `vec3 * 0.0` joins a vector and a scalar (#9086).
    // rust: assert_eq!(
    // rust: x,
    // rust: [2.0, 0.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 6.0, 2.0, 0.0, 2.0]
    // rust: );
    // rust: assert_eq!(c.notes.len(), 10, "{:?}", c.notes);
        // The same on later frames, with no new notes.
    // rust: let again: Vec<f64> = c.eval(0.016, &builtin).iter().map(|v| v.v[0]).collect();
    // rust: assert_eq!(again, x);
    // rust: assert_eq!(c.notes.len(), 10, "{:?}", c.notes);
}

    // Iris 1.11.7, with our probe packs of #9086 (`final` drew each uniform, a vector's `.y`):
    // an expression without its declared shape, or joining a vector and a scalar, reads 0, and
    // so does a uniform using such a variable. Each row: the probe's line, then what Iris read
    // (`k5` reads our `skyColor.y` here; Iris read its own sky, 0.64). A variable isn't drawn:
    // its number follows Iris's warnings (`vbad` failed) and the uniforms reading it.
an_expression_without_its_declared_shape_reads_zero :: proc() {
}
    // rust: const ROWS: &str = "\
    // rust: uniform.float.k0 = 2.0 | 2
    // rust: uniform.float.k1 = skyColor * 0.0 + 2.0 | 0
    // rust: uniform.vec3.k2 = skyColor * 0.0 + 2.0 | 0
    // rust: uniform.float.k3 = skyColor.y * 0.0 + 2.0 | 2
    // rust: uniform.vec3.k4 = vec3(skyColor.x * 0.0 + 2.0, skyColor.y * 0.0 + 2.0, skyColor.z * 0.0 + 2.0) | 2
    // rust: uniform.vec3.k5 = skyColor | 0.5
    // rust: uniform.float.k6 = skyColor | 0
    // rust: uniform.vec3.k7 = vec3(2.0, 2.0, 2.0) * 1.0 | 0
    // rust: uniform.vec3.k8 = vec3(2.0, 2.0, 2.0) + 0.0 | 0
    // rust: uniform.vec3.k9 = skyColor * vec3(0.0, 0.0, 0.0) + vec3(2.0, 2.0, 2.0) | 2
    // rust: uniform.float.k10 = vec3(2.0, 2.0, 2.0) | 0
    // rust: uniform.vec2.k11 = vec3(2.0, 2.0, 2.0) | 0
    // rust: uniform.vec3.w0 = 2.0 * vec3(1.0, 1.0, 1.0) | 0
    // rust: uniform.vec3.w1 = vec3(4.0, 4.0, 4.0) / 2.0 | 0
    // rust: uniform.vec3.w19 = vec3(2.0, 2.0, 2.0) % 3.0 | 0
    // rust: uniform.vec3.w2 = -vec3(-2.0, -2.0, -2.0) | 2
    // rust: uniform.vec3.z11 = vec3(4.0, 4.0, 4.0) / vec3(2.0, 2.0, 2.0) | 2
    // rust: uniform.vec3.x0 = vec3(2.0, 2.0, 2.0) + vec2(0.0, 0.0) | 0
    // rust: uniform.vec3.x17 = -skyColor + skyColor + vec3(2.0, 2.0, 2.0) | 2
    // rust: uniform.bool.z0 = !vec3(0.0, 0.0, 0.0) | 0
    // rust: uniform.bool.z2 = vec3(1.0, 1.0, 1.0) < vec3(2.0, 2.0, 2.0) | 0
    // rust: uniform.vec3.w5 = 2.0 | 0
    // rust: uniform.vec3.w6 = vec3(2.0) | 0
    // rust: uniform.vec3.z10 = vec3(2.0, 2.0) | 0
    // rust: uniform.vec3.w7 = vec3(vec2(2.0, 2.0), 2.0) | 0
    // rust: uniform.vec3.x6 = vec3(vec3(2.0, 2.0, 2.0)) | 0
    // rust: uniform.vec2.x8 = vec2(frameCounter * 0 + 2, 2) | 2
    // rust: uniform.vec4.w4 = vec4(2.0, 2.0, 2.0, 2.0) | 2
    // rust: uniform.vec3.w11 = abs(vec3(-2.0, -2.0, -2.0)) | 2
    // rust: uniform.vec2.z5 = floor(vec3(2.5, 2.5, 2.5)) | 0
    // rust: uniform.float.z6 = abs(skyColor) | 0
    // rust: uniform.vec3.w10 = max(vec3(2.0, 2.0, 2.0), vec3(0.0, 0.0, 0.0)) | 2
    // rust: uniform.vec3.w9 = max(vec3(2.0, 2.0, 2.0), 0.0) | 0
    // rust: uniform.vec3.x12 = min(vec3(2.0, 2.0, 2.0), vec3(3.0, 3.0, 3.0), vec3(4.0, 4.0, 4.0)) | 0
    // rust: uniform.vec3.y3 = clamp(vec3(2.0, 2.0, 2.0), vec3(0.0, 0.0, 0.0), vec3(3.0, 3.0, 3.0)) | 2
    // rust: uniform.vec3.w12 = clamp(vec3(2.0, 2.0, 2.0), 0.0, 3.0) | 0
    // rust: uniform.vec3.y9 = sqrt(vec3(4.0, 4.0, 4.0)) | 0
    // rust: uniform.vec3.x3 = pow(vec3(2.0, 2.0, 2.0), 1.0) | 0
    // rust: uniform.vec3.x11 = smooth(vec3(2.0, 2.0, 2.0), 0.0001, 0.0001) | 0
    // rust: uniform.vec3.w8 = if(1.0 > 0.0, vec3(2.0, 2.0, 2.0), vec3(0.0, 0.0, 0.0)) | 2
    // rust: uniform.vec3.x19 = if(1.0 > 0.0, vec3(2.0, 2.0, 2.0), 0.0) | 0
    // rust: uniform.float.x9 = if(vec3(1.0, 1.0, 1.0), 2.0, 0.0) | 0
    // rust: uniform.vec3.z12 = if(1.0 < 0.0, vec3(0.0, 0.0, 0.0), 1.0 > 0.0, vec3(2.0, 2.0, 2.0), vec3(0.0, 0.0, 0.0)) | 0
    // rust: uniform.vec3.z9 = ifb(1.0 > 0.0, vec3(2.0, 2.0, 2.0), vec3(0.0, 0.0, 0.0)) | 0
    // rust: uniform.float.x15 = gbufferModelView * 0.0 + 2.0 | 0
    // rust: uniform.float.x16 = gbufferModelView.0.0 * 0.0 + 2.0 | 2
    // rust: variable.vec3.vbad = vec3(2.0, 2.0, 2.0) * 1.0 | 0
    // rust: uniform.float.w13 = vbad.y | 0
    // rust: variable.vec3.vgood = vec3(2.0, 2.0, 2.0) | 2
    // rust: uniform.float.w14 = vgood.y | 2
    // rust: uniform.vec3.w16 = vgood * vgood * vec3(0.5, 0.5, 0.5) | 2";
    // rust: let rows: Vec<(&str, f64)> = (ROWS.lines())
    // rust: .map(|l| l.trim().split_once(" | ").unwrap())
    // rust: .map(|(line, x)| (line, x.parse().unwrap()))
    // rust: .collect();
    // rust: let mut c = custom(
    // rust: &rows
    // rust: .iter()
    // rust: .map(|r| format!("{}\n", r.0))
    // rust: .collect::<String>(),
    // rust: );
    // rust: assert!(c.notes.is_empty(), "{:?}", c.notes);
    // rust: let builtin = |n: &str| match n {
    // rust: "skyColor" => Some(Val::vector(&[0.25, 0.5, 0.75])),
    // rust: "gbufferModelView" => Some(Val::vector(&[0.0; 16])),
    // rust: "frameCounter" => Some(Val::scalar(7.0)),
    // rust: _ => None,
}
    // rust: let got = c.eval(0.016, &builtin);
    // rust: let uniforms = rows.iter().filter(|r| r.0.starts_with("uniform."));
    // rust: assert_eq!(got.len(), uniforms.clone().count());
    // rust: for (v, (line, x)) in got.iter().zip(uniforms) {
            // A vector shows its `.y`, as the probe drew it; one reading 0 is 0 throughout.
    // rust: let shown = v.v[usize::from(v.n > 1)];
    // rust: assert!((shown - x).abs() < 1e-9, "{line}: {shown}, Iris {x}");
    // rust: assert!(*x != 0.0 || v.v[..v.n].iter().all(|&c| c == 0.0), "{line}");
}
    // rust: let zeros = rows.iter().filter(|r| r.1 == 0.0).count();
    // rust: assert_eq!(c.notes.len(), zeros, "{:?}", c.notes);
}

    // Iris 1.11.7, with our probe packs of #9126 (`final` drew each uniform, a vector's `.y`):
    // an expression whose type isn't the declared one (an `int` given a float, a `float` given a
    // bool...), or that names `true`, `false` or a function Iris doesn't have, reads 0. Each row:
    // the probe's line, what Iris read (`-` where it depends on the world: the built-ins), and
    // `w` where Iris warned `Failed to resolve uniform`. Values are read from stripes, to 0.02.
an_expression_without_its_declared_scalar_type_reads_zero :: proc() {
}
    // rust: const ROWS: &str = "\
    // rust: uniform.int.s0 = 2 | 2
    // rust: uniform.int.s1 = 2.0 | 0 | w
    // rust: uniform.float.s2 = 2 | 2
    // rust: uniform.int.s3 = 7 / 2 | 0 | w
    // rust: uniform.bool.s4 = 1 > 0 | 1
    // rust: uniform.float.s5 = 1 > 0 | 0 | w
    // rust: uniform.int.s6 = 1 > 0 | 0 | w
    // rust: uniform.bool.s7 = 2.0 | 0 | w
    // rust: uniform.float.s10 = frameCounter * 0 + 2 | 2
    // rust: uniform.int.t2 = 2 * 1.0 | 0 | w
    // rust: uniform.float.t4 = 7 / 2 | 3.5
    // rust: uniform.bool.t6 = 1 | 0 | w
    // rust: uniform.bool.t7 = true | 0 | w
    // rust: uniform.int.t8 = true | 0 | w
    // rust: uniform.float.t9 = true | 0 | w
    // rust: uniform.bool.t12 = !1 | 0 | w
    // rust: uniform.int.t17 = if(1 > 0, 2, 0) | 2
    // rust: uniform.int.t18 = round(2.4) | 0 | w
    // rust: uniform.bool.t21 = between(2.0, 1.0, 3.0) | 1
    // rust: uniform.float.t22 = between(2.0, 1.0, 3.0) | 0 | w
    // rust: uniform.int.t25 = max(2, 1.0) | 0 | w
    // rust: uniform.float.t26 = if(1 > 0, 2, 0) | 2
    // rust: uniform.float.q0 = if(1 < 0, 1.0, 1 > 0, 2.0, 0.0) | 2
    // rust: uniform.int.q1 = if(1 < 0, 1, 1 > 0, 2, 0) | 2
    // rust: uniform.float.q2 = randomInt(2.0, 2.0) | 0 | w
    // rust: uniform.bool.q4 = 1 > 0 || 1 | 0 | w
    // rust: uniform.bool.q11 = in(2.0, 1, 2) | 1
    // rust: uniform.vec2.v0 = eyeBrightness + vec2(0.0, 0.0) | 0 | w
    // rust: uniform.vec2.v1 = vec2(0.0, 0.0) + eyeBrightness | 0 | w
    // rust: uniform.vec2.v4 = eyeBrightness - eyeBrightness + vec2(2.0, 2.0) | 0 | w
    // rust: uniform.float.v5 = eyeBrightness.y / 100 | 2.4
    // rust: uniform.vec2.v6 = max(eyeBrightness, vec2(0.0, 0.0)) | 0 | w
    // rust: uniform.vec2.v7 = if(1 > 0, eyeBrightness, vec2(0.0, 0.0)) | 0 | w
    // rust: uniform.bool.v8 = (1 > 0) == 1 | 0 | w
    // rust: uniform.bool.v9 = 1 > (1 > 0) | 0 | w
    // rust: uniform.vec2.v14 = abs(eyeBrightness) | 0 | w
    // rust: uniform.int.v19 = fmod(5.0, 3) | 0 | w
    // rust: uniform.int.v20 = edge(1.5, 2.5) | 0 | w
    // rust: uniform.int.v21 = randomInt(2.0, 3.0) | 0 | w
    // rust: uniform.float.v25 = sin(1 > 0) | 0 | w
    // rust: uniform.float.v26 = between(1 > 0, 0, 2) * 0 + 2 | 0 | w
    // rust: uniform.int.o0 = (1 > 0) + 1 | 0 | w
    // rust: uniform.bool.o1 = (1 > 0) && 1 | 0 | w
    // rust: uniform.int.o5 = -(1 > 0) | 0 | w
    // rust: uniform.int.o6 = 5 % 3.0 | 0 | w
    // rust: uniform.int.o8 = if(1, 2, 0) | 0 | w
    // rust: uniform.float.o9 = if(1.0, 2.0, 0.0) | 0 | w
    // rust: uniform.int.o10 = if(1 > 0, 2, 1.0) | 0 | w
    // rust: uniform.float.o11 = if(1 > 0, 2, 1.0) | 2
    // rust: uniform.int.o14 = smooth(2, 0.0001) | 0 | w
    // rust: uniform.int.o16 = false | 0 | w
    // rust: uniform.bool.o17 = false | 0 | w
    // rust: uniform.vec2.o19 = eyeBrightness | 0 | w
    // rust: uniform.vec3.o20 = cameraPositionInt | 0 | w
    // rust: uniform.vec2.o21 = vec2(eyeBrightness.x, 2) | 2
    // rust: uniform.vec3.o22 = vec3(1 > 0, 2, 2) | 0 | w
    // rust: uniform.float.o24 = sin(0) + 2 | 2
    // rust: uniform.int.o25 = abs(-2.0) | 0 | w
    // rust: uniform.int.o27 = clamp(2, 0, 3.0) | 0 | w
    // rust: uniform.int.o30 = 2 + 0 * frameTimeCounter | 0 | w
    // rust: uniform.int.f0i = sin(1.5707963) | 0 | w
    // rust: uniform.int.f8i = torad(114.59156) | 0 | w
    // rust: uniform.float.f8f = torad(114.59156) | 2
    // rust: uniform.int.f16i = floor(2.5) | 2
    // rust: uniform.int.f17i = ceil(1.5) | 2
    // rust: uniform.int.f29i = pow(2, 1) | 0 | w
    // rust: uniform.int.f30i = fmod(5, 3) | 2
    // rust: uniform.int.f31i = lerp(0.5, 0, 4) | 0 | w
    // rust: uniform.float.f31f = lerp(0.5, 0, 4) | 0 | w
    // rust: uniform.int.f32i = mix(0, 4, 0.5) | 0 | w
    // rust: uniform.int.f33i = edge(1, 2) | 1
    // rust: uniform.bool.g0b = ifb(1 > 0, 1 > 0, 2 > 3) | 0 | w
    // rust: uniform.bool.g1b = ifb(1 > 0, 2, 3) | 0 | w
    // rust: uniform.bool.g2b = edge(1, 2) | 0 | w
    // rust: uniform.bool.g3b = between(2, 1, 3) | 1
    // rust: uniform.int.p0i = pi | 0 | w
    // rust: uniform.float.p0f = pi | 3.14
    // rust: uniform.bool.p0b = pi | 0 | w
    // rust: uniform.bool.p1b = BIOME_PLAINS | 0 | w
    // rust: uniform.int.p4i = notAFunction(2.0) | 0 | w
    // rust: uniform.int.b0i = frameCounter | -
    // rust: uniform.bool.b0b = frameCounter | 0 | w
    // rust: uniform.int.b4i = hideGUI | 0 | w
    // rust: uniform.bool.b4b = hideGUI | -
    // rust: uniform.int.b7i = frameTimeCounter | 0 | w
    // rust: uniform.bool.b7b = frameTimeCounter | 0 | w
    // rust: uniform.int.b19i = eyeBrightness.x | -
    // rust: uniform.bool.b19b = eyeBrightness.x | 0 | w
    // rust: uniform.int.b3_22i = centerDepthSmooth | 0 | w
    // rust: uniform.float.b3_22f = centerDepthSmooth | 0 | w
    // rust: uniform.bool.b3_22b = centerDepthSmooth | 0 | w
    // rust: uniform.int.b3_31i = currentRenderedItemId | -
    // rust: uniform.bool.b3_31b = currentRenderedItemId | 0 | w
    // rust: uniform.bool.b3_33b = worldTime | 0 | w";
    // rust: let rows: Vec<(&str, Option<f64>, bool)> = (ROWS.lines())
    // rust: .map(|l| {
    // rust: let mut p = l.trim().split(" | ");
    // rust: let line = p.next().unwrap();
    // rust: let x = p.next().unwrap().parse().ok();
    // rust: (line, x, p.next() == Some("w"))
    // rust: })
    // rust: .collect();
    // rust: let mut c = custom(
    // rust: &rows
    // rust: .iter()
    // rust: .map(|r| format!("{}\n", r.0))
    // rust: .collect::<String>(),
    // rust: );
    // rust: assert!(c.notes.is_empty(), "{:?}", c.notes);
    // rust: let builtin = |n: &str| match n {
    // rust: "frameCounter" | "worldTime" | "frameTimeCounter" => Some(Val::scalar(2.0)),
    // rust: "hideGUI" => Some(Val::scalar(1.0)),
    // rust: "sunAngle" => Some(Val::scalar(0.25)),
    // rust: "centerDepthSmooth" => Some(Val::scalar(0.5)),
    // rust: "eyeBrightness" => Some(Val::vector(&[0.0, 240.0])),
    // rust: "cameraPositionInt" => Some(Val::vector(&[1.0, 2.0, 3.0])),
    // rust: "cameraPosition" => Some(Val::vector(&[1.0, 64.0, 2.0])),
    // rust: _ => None,
}
    // rust: let got = c.eval(0.016, &builtin);
    // rust: assert_eq!(got.len(), rows.len());
    // rust: for (v, (line, x, _)) in got.iter().zip(&rows) {
    // rust: let shown = v.v[usize::from(v.n > 1)];
    // rust: if let Some(x) = x {
    // rust: assert!((shown - x).abs() <= 0.02, "{line}: {shown}, Iris {x}");
}
}
        // Exactly the uniforms Iris warned about read 0, each with a note.
    // rust: let warned: Vec<&str> = (rows.iter().filter(|r| r.2))
    // rust: .map(|r| r.0.split(" = ").next().unwrap().rsplit('.').next().unwrap())
    // rust: .collect();
    // rust: let noted: Vec<&str> = (c.notes.iter())
    // rust: .filter(|n| n.contains("` reads 0: "))
    // rust: .map(|n| n[1..].split('`').next().unwrap())
    // rust: .collect();
    // rust: assert_eq!(noted, warned);
}
}
