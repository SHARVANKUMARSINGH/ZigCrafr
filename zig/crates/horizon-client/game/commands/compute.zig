//! Transpiled from Horizon Rust crate
//! Module: horizon-client_compute
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `/compute` (ComputeCommand): context number providers
//! (`context_int_provider`, `context_float_provider`) evaluated in a loot
//! context of the source, optionally with a block or a target entity.
// use super::{Arg, Context, Game, R, Target, err};
// use horizon_client::{command::CommandError, text::Text};
// use horizon_core::random::RandomSource;
// use serde_json::Value;

/// The loot context parameters of `LootContextSources`.
    // rust: pub(in crate::game) struct ComputeContext {
    /// `BLOCK_STATE` (`compute block <pos>`).
    // rust: pub block: Option<[i32; 3]>,
    /// `TARGET_ENTITY` (`compute entity <target>`).
    // rust: pub target: Option<Target>,
}

/// An ArithmeticException's message.
    // rust: type Arith = String;

pub fn java_float(v: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::snbt::java_float(v)
}

    // rust: impl Game<'_> {
    /// A provider argument: its registry id (None when inline) and value.
    // rust: pub(in crate::game) fn provider_arg(
    // rust: &self,
    // rust: ctx: &Context,
    // rust: registry: &str,
    // rust: ) -> R<(Option<String>, Value)> {
    // rust: let raw = match ctx.get("provider") {
    // rust: Some(Arg::Resource(s) | Arg::Str(s)) => s.clone(),
    // rust: _ => return Err(err("command.failed", &[])),
}
    // rust: let first = raw.trim_start().chars().next().unwrap_or(' ');
    // rust: if first == '{' || first == '[' || first == '-' || first.is_ascii_digit() || first == '"' {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(&raw)
    // rust: .map_err(|e| err("argument.nbt.invalid", &[&e]))?;
    // rust: return Ok((None, horizon_client::scoreboard::tag_to_json(&tag)));
}
    // rust: let id = if raw.contains(':') {
    // rust: raw
    // rust: } else {
    // rust: format!("minecraft:{raw}")
}
    // rust: let value = self
    // rust: .provider_file(registry, &id)
    // rust: .ok_or_else(|| err("argument.resource_or_id.no_such_element", &[&id, &registry]))?;
    // rust: Ok((Some(id), value))
}
    /// A registered provider's definition.
pub fn provider_file(self: *Self, registry: []const u8, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let dir = registry.trim_start_matches("minecraft:");
    // rust: let file = self
    // rust: .options
    // rust: .resources
    // rust: .join(format!("data/{ns}/{dir}/{path}.json"));
    // rust: serde_json::from_slice(&std::fs::read(file).ok()?).ok()
}
    /// The compute context the command's source literal selects.
    // rust: pub(in crate::game) fn compute_context(&mut self, ctx: &Context) -> R<ComputeContext> {
    // rust: let mut c = ComputeContext::default();
    // rust: if ctx.literals.iter().any(|l| l == "block") && ctx.get("computePos").is_some() {
    // rust: c.block = Some(self.block_pos_arg(ctx, "computePos")?);
}
    // rust: if ctx.get("computeTarget").is_some() {
    // rust: let t = self.entities(ctx, "computeTarget", false)?;
    // rust: if t.len() > 1 {
    // rust: return Err(err("argument.entity.toomany", &[]));
}
    // rust: c.target = t.first().copied();
}
    // rust: Ok(c)
}
    /// `ComputeCommand.computeAsInt` / `computeAsFloat`.
    // rust: pub(super) fn cmd_compute(&mut self, ctx: &Context) -> R<i32> {
    // rust: let integer = ctx.literals.iter().any(|l| l == "integer");
    // rust: let registry = if integer {
    // rust: "minecraft:context_int_provider"
    // rust: } else {
    // rust: "minecraft:context_float_provider"
}
    // rust: let (id, provider) = self.provider_arg(ctx, registry)?;
    // rust: let c = self.compute_context(ctx)?;
    // rust: let invalid = |value: String| -> CommandError {
    // rust: match &id {
    // rust: Some(id) => CommandError::new(Text::translate(
    // rust: "command.compute.result.named.invalid",
    // rust: &[Text::literal(id.clone()), Text::literal(value)],
    // rust: )),
    // rust: None => CommandError::new(Text::translate(
    // rust: "command.compute.result.unnamed.invalid",
    // rust: &[Text::literal(value)],
    // rust: )),
}
}
    // rust: let exact = |result: i32| match &id {
    // rust: Some(id) => Text::translate(
    // rust: "command.compute.result.named.exact",
    // rust: &[Text::literal(id.clone()), Text::literal(result.to_string())],
    // rust: ),
    // rust: None => Text::translate(
    // rust: "command.compute.result.unnamed.exact",
    // rust: &[Text::literal(result.to_string())],
    // rust: ),
}
    // rust: if integer {
    // rust: let result = self.provider_int(&provider, &c, 0).map_err(invalid)?;
    // rust: self.feedback(exact(result));
    // rust: return Ok(result);
}
    // rust: let scale = match ctx.get("scale") {
    // rust: Some(Arg::Float(s)) => *s,
    // rust: _ => 1.0,
}
    // rust: let original = self.provider_float(&provider, &c, 0).map_err(invalid)?;
    // rust: if !original.is_finite() {
    // rust: return Err(invalid(java_float(original)));
}
        // Mth.floor(original * scale)
    // rust: let result = (original * scale).floor() as i32;
    // rust: if result as f32 == original {
    // rust: self.feedback(exact(result));
    // rust: } else {
    // rust: let original_text = Text::literal(java_float(original));
    // rust: let message = match &id {
    // rust: Some(id) => Text::translate(
    // rust: "command.compute.result.named.rounded",
    // rust: &[
    // rust: Text::literal(id.clone()),
    // rust: original_text,
    // rust: Text::literal(result.to_string()),
    // rust: ],
    // rust: ),
    // rust: None => Text::translate(
    // rust: "command.compute.result.unnamed.rounded",
    // rust: &[original_text, Text::literal(result.to_string())],
    // rust: ),
}
    // rust: self.feedback(message);
}
    // rust: Ok(result)
}

    // ---- evaluation ---------------------------------------------------------------

    /// `ContextIntProvider.getIntUnsafe`.
    // rust: pub(in crate::game) fn provider_int(
    // rust: &mut self,
    // rust: v: &Value,
    // rust: c: &ComputeContext,
    // rust: depth: u32,
    // rust: ) -> Result<i32, Arith> {
    // rust: if depth > 64 {
    // rust: return Ok(0);
}
    // rust: let d = depth + 1;
    // rust: match v {
    // rust: Value::Number(n) => Ok(n
    // rust: .as_i64()
    // rust: .map_or_else(|| n.as_f64().unwrap_or(0.0) as i32, |i| i as i32)),
    // rust: Value::Bool(b) => Ok(i32::from(*b)),
    // rust: Value::String(id) => match self.provider_file("minecraft:context_int_provider", id) {
    // rust: Some(def) => self.provider_int(&def, c, d),
    // rust: None => Ok(0),
    // rust: },
    // rust: Value::Object(o) => {
    // rust: let ty = o
    // rust: .get("type")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("")
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned();
    // rust: let inputs = |g: &mut Self| -> Result<Vec<i32>, Arith> {
    // rust: let list: Vec<Value> = match o.get("inputs") {
    // rust: Some(Value::Array(a)) => a.clone(),
    // rust: Some(other) => vec![other.clone()],
    // rust: None => Vec::new(),
}
    // rust: list.iter().map(|x| g.provider_int(x, c, d)).collect()
}
    // rust: let field = |g: &mut Self, k: &str| -> Result<i32, Arith> {
    // rust: match o.get(k) {
    // rust: Some(x) => g.provider_int(x, c, d),
    // rust: None => Ok(0),
}
}
    // rust: let overflow = || "integer overflow".to_owned();
    // rust: let long_to_int = |v: i64| -> Result<i32, Arith> {
    // rust: i32::try_from(v)
    // rust: .map_err(|_| format!("Value {v} can't be safely converted to int"))
}
    // rust: Ok(match ty.as_str() {
    // rust: "constant" => field(self, "value")?,
    // rust: "add" => long_to_int(inputs(self)?.iter().map(|&x| i64::from(x)).sum())?,
    // rust: "mul" => long_to_int(
    // rust: inputs(self)?
    // rust: .iter()
    // rust: .fold(1i64, |a, &x| a.wrapping_mul(i64::from(x))),
    // rust: )?,
    // rust: "avg" => {
    // rust: let xs = inputs(self)?;
    // rust: if xs.is_empty() {
    // rust: return Err("/ by zero".into());
}
    // rust: let sum: i64 = xs.iter().map(|&x| i64::from(x)).sum();
    // rust: long_to_int(sum / xs.len() as i64)?
}
    // rust: "max" => inputs(self)?.into_iter().fold(i32::MIN, i32::max),
    // rust: "min" => inputs(self)?.into_iter().fold(i32::MAX, i32::min),
    // rust: "sub" => {
    // rust: let (a, b) = (field(self, "left")?, field(self, "right")?);
    // rust: a.checked_sub(b).ok_or_else(overflow)?
}
    // rust: "div" | "mod" | "floor_div" | "floor_mod" => {
    // rust: let (a, b) = (field(self, "left")?, field(self, "right")?);
    // rust: if b == 0 {
    // rust: return Err("/ by zero".into());
}
    // rust: match ty.as_str() {
    // rust: "div" => a.wrapping_div(b),
    // rust: "mod" => a.wrapping_rem(b),
    // rust: "floor_mod" => {
    // rust: a.rem_euclid(b) + if b < 0 && a.rem_euclid(b) != 0 { b } else { 0 }
}
    // rust: _ => {
    // rust: if a == i32::MIN && b == -1 {
    // rust: return Err(overflow());
}
    // rust: a.div_euclid(b) - if b < 0 && a.rem_euclid(b) != 0 { 1 } else { 0 }
}
}
}
    // rust: "pow" => {
    // rust: let (base, exp) = (field(self, "base")?, field(self, "exponent")?);
    // rust: if base == 0 && exp == 0 {
    // rust: return Err("Result of 0 to the power of 0 is undefined".into());
}
    // rust: if exp < 0 {
    // rust: return Err("Negative exponent".into());
}
    // rust: base.checked_pow(exp as u32).ok_or_else(overflow)?
}
                    // Math.absExact's message.
    // rust: "abs" => field(self, "input")?.checked_abs().ok_or_else(|| {
    // rust: "Overflow to represent absolute value of Integer.MIN_VALUE".to_owned()
    // rust: })?,
    // rust: "negate" => field(self, "input")?.checked_neg().ok_or_else(overflow)?,
    // rust: "from_float" => {
    // rust: let f = match o.get("input") {
    // rust: Some(x) => self.provider_float(x, c, d)?,
    // rust: None => 0.0,
}
    // rust: if !f.is_finite() {
    // rust: return Err(format!(
    // rust: "Value {} can't be safely converted to int",
    // rust: java_float(f)
    // rust: ));
}
    // rust: long_to_int(f as i64)?
}
    // rust: "uniform" => {
    // rust: let (lo, hi) = (field(self, "min")?, field(self, "max")?);
    // rust: if lo >= hi {
    // rust: lo
    // rust: } else {
    // rust: self.world.random.next_int_bound(hi - lo + 1).unwrap_or(0) + lo
}
}
    // rust: "binomial" => {
    // rust: let n = field(self, "n")?;
    // rust: let p = match o.get("p") {
    // rust: Some(x) => self.provider_float(x, c, d)?,
    // rust: None => 0.0,
}
    // rust: (0..n.max(0))
    // rust: .filter(|_| self.world.random.next_float() < p)
    // rust: .count() as i32
}
    // rust: "conditional" | "number_dispatcher" | "weighted_list" => {
    // rust: match self.provider_select(o, c)? {
    // rust: Some(x) => self.provider_int(&x, c, d)?,
    // rust: None => 0,
}
}
    // rust: _ => 0,
    // rust: })
}
    // rust: _ => Ok(0),
}
}
    /// `ContextFloatProvider.getFloatUnsafe`.
    // rust: pub(in crate::game) fn provider_float(
    // rust: &mut self,
    // rust: v: &Value,
    // rust: c: &ComputeContext,
    // rust: depth: u32,
    // rust: ) -> Result<f32, Arith> {
    // rust: if depth > 64 {
    // rust: return Ok(0.0);
}
    // rust: let d = depth + 1;
    // rust: match v {
    // rust: Value::Number(n) => Ok(n.as_f64().unwrap_or(0.0) as f32),
    // rust: Value::String(id) => match self.provider_file("minecraft:context_float_provider", id) {
    // rust: Some(def) => self.provider_float(&def, c, d),
    // rust: None => Ok(0.0),
    // rust: },
    // rust: Value::Object(o) => {
    // rust: let ty = o
    // rust: .get("type")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("")
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned();
    // rust: let inputs = |g: &mut Self| -> Result<Vec<f32>, Arith> {
    // rust: let list: Vec<Value> = match o.get("inputs") {
    // rust: Some(Value::Array(a)) => a.clone(),
    // rust: Some(other) => vec![other.clone()],
    // rust: None => Vec::new(),
}
    // rust: list.iter().map(|x| g.provider_float(x, c, d)).collect()
}
    // rust: let field = |g: &mut Self, k: &str| -> Result<f32, Arith> {
    // rust: match o.get(k) {
    // rust: Some(x) => g.provider_float(x, c, d),
    // rust: None => Ok(0.0),
}
}
    // rust: Ok(match ty.as_str() {
    // rust: "constant" => field(self, "value")?,
    // rust: "add" => inputs(self)?.iter().fold(0.0f32, |a, &x| a + x),
    // rust: "mul" => inputs(self)?.iter().fold(1.0f32, |a, &x| a * x),
    // rust: "avg" => {
    // rust: let xs = inputs(self)?;
    // rust: xs.iter().fold(0.0f32, |a, &x| a + x) / xs.len() as f32
}
    // rust: "length" => inputs(self)?.iter().fold(0.0f32, |a, &x| a + x * x).sqrt(),
    // rust: "max" => inputs(self)?.into_iter().fold(-f32::MAX, f32::max),
    // rust: "min" => inputs(self)?.into_iter().fold(f32::MAX, f32::min),
    // rust: "sub" => field(self, "left")? - field(self, "right")?,
    // rust: "div" => field(self, "left")? / field(self, "right")?,
    // rust: "mod" => {
    // rust: let right = field(self, "right")?;
    // rust: if right == 0.0 {
    // rust: f32::NAN
    // rust: } else {
    // rust: field(self, "left")? % right
}
}
    // rust: "pow" => {
    // rust: let (base, exp) = (field(self, "base")?, field(self, "exponent")?);
    // rust: if base == 0.0 && exp == 0.0 {
    // rust: f32::NAN
    // rust: } else {
    // rust: f64::from(base).powf(f64::from(exp)) as f32
}
}
    // rust: "abs" => field(self, "input")?.abs(),
    // rust: "negate" => -field(self, "input")?,
    // rust: "floor" => field(self, "input")?.floor(),
                    // Mth.ceil returns an int.
    // rust: "ceil" => field(self, "input")?.ceil() as i32 as f32,
    // rust: "round" => horizon_core::jmath::round_f32(field(self, "input")?) as f32,
    // rust: "truncate" => field(self, "input")?.trunc(),
    // rust: "sqrt" => field(self, "input")?.sqrt(),
    // rust: "sin" => horizon_core::geometry::trig::sin(f64::from(field(self, "input")?)),
    // rust: "cos" => horizon_core::geometry::trig::cos(f64::from(field(self, "input")?)),
    // rust: "from_int" => match o.get("input") {
    // rust: Some(x) => self.provider_int(x, c, d)? as f32,
    // rust: None => 0.0,
    // rust: },
    // rust: "uniform" => {
    // rust: let (lo, hi) = (field(self, "min")?, field(self, "max")?);
    // rust: if lo >= hi {
    // rust: lo
    // rust: } else {
    // rust: self.world.random.next_float() * (hi - lo) + lo
}
}
    // rust: "conditional" | "number_dispatcher" | "weighted_list" => {
    // rust: match self.provider_select(o, c)? {
    // rust: Some(x) => self.provider_float(&x, c, d)?,
    // rust: None => 0.0,
}
}
    // rust: _ => 0.0,
    // rust: })
}
    // rust: _ => Ok(0.0),
}
}
    /// The branch a conditional, dispatcher or weighted list provider picks.
    // rust: fn provider_select(
    // rust: &mut self,
    // rust: o: &serde_json::Map<String, Value>,
    // rust: c: &ComputeContext,
    // rust: ) -> Result<Option<Value>, Arith> {
    // rust: match o
    // rust: .get("type")
    // rust: .and_then(Value::as_str)
    // rust: .map(|t| t.trim_start_matches("minecraft:"))
    // rust: {
    // rust: Some("conditional") => {
    // rust: let holds = o
    // rust: .get("condition")
    // rust: .is_some_and(|x| self.compute_condition(x, c));
    // rust: Ok(if holds {
    // rust: o.get("on_true").cloned()
    // rust: } else {
    // rust: Some(o.get("on_false").cloned().unwrap_or(Value::from(0)))
    // rust: })
}
    // rust: Some("number_dispatcher") => {
    // rust: for case in o
    // rust: .get("cases")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if case
    // rust: .get("condition")
    // rust: .is_some_and(|x| self.compute_condition(x, c))
    // rust: {
    // rust: return Ok(case.get("value").cloned());
}
}
    // rust: Ok(Some(o.get("default").cloned().unwrap_or(Value::from(0))))
}
    // rust: _ => {
                // WeightedList.getRandomOrThrow.
    // rust: let list: Vec<(Value, i32)> = o
    // rust: .get("distribution")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|e| {
    // rust: (
    // rust: e.get("data").cloned().unwrap_or(Value::Null),
    // rust: e.get("weight").and_then(Value::as_i64).unwrap_or(1) as i32,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let total: i32 = list.iter().map(|(_, w)| *w).sum();
    // rust: if total <= 0 {
    // rust: return Ok(None);
}
    // rust: let mut pick = self.world.random.next_int_bound(total).unwrap_or(0);
    // rust: for (v, w) in list {
    // rust: pick -= w;
    // rust: if pick < 0 {
    // rust: return Ok(Some(v));
}
}
    // rust: Ok(None)
}
}
}
    /// A loot condition in the compute context: references, the logical
    /// combinators and `match_block` on the context's block state.
pub fn compute_condition(self: *Self, cond: *Value, c: *ComputeContext) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match cond {
    // rust: Value::String(id) => match self.provider_file("minecraft:predicate", id) {
    // rust: Some(def) => self.compute_condition(&def, c),
    // rust: None => false,
    // rust: },
    // rust: Value::Array(list) => list.iter().all(|x| self.compute_condition(x, c)),
    // rust: Value::Object(o) => {
    // rust: let ty = o
    // rust: .get("type")
    // rust: .or_else(|| o.get("condition"))
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("")
    // rust: .trim_start_matches("minecraft:");
    // rust: match ty {
    // rust: "inverted" => !o.get("term").is_some_and(|x| self.compute_condition(x, c)),
    // rust: "all_of" => o
    // rust: .get("terms")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|x| self.compute_condition(x, c)),
    // rust: "any_of" => o
    // rust: .get("terms")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|x| self.compute_condition(x, c)),
    // rust: "match_block" | "block_state_property" => {
    // rust: let Some(p) = c.block else {
    // rust: return false;
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let Some(s) = self.pack.assets.registry.state(state) else {
    // rust: return false;
}
    // rust: let name = s.name.to_string();
    // rust: let blocks_ok = match o.get("blocks").or_else(|| o.get("block")) {
    // rust: Some(Value::String(b)) => match b.strip_prefix('#') {
    // rust: Some(tag) => self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get(tag.trim_start_matches("minecraft:"))
    // rust: .is_some_and(|set| {
    // rust: set.contains(&*name)
    // rust: || set.contains(name.trim_start_matches("minecraft:"))
    // rust: }),
    // rust: None => *b == name,
    // rust: },
    // rust: Some(Value::Array(list)) => {
    // rust: list.iter().any(|b| b.as_str() == Some(&name))
}
    // rust: _ => true,
}
    // rust: let props_ok = o
    // rust: .get("state")
    // rust: .or_else(|| o.get("properties"))
    // rust: .and_then(Value::as_object)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|(k, v)| s.properties.get(k).map(String::as_str) == v.as_str());
    // rust: blocks_ok && props_ok
}
    // rust: "random_chance" => {
    // rust: let chance = o.get("chance").and_then(Value::as_f64).unwrap_or(0.0) as f32;
    // rust: self.world.random.next_float() < chance
}
    // rust: _ => {
    // rust: let source = self.command_source.unwrap_or_else(|| self.player_source());
    // rust: let view = source.entity.map(|t| self.entity_view_asked(t, cond));
    // rust: self.conditions_hold(cond, view.as_ref(), source.pos)
}
}
}
    // rust: _ => false,
}
}
}
