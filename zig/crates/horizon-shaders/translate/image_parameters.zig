//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_image_parameters
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Specialize opaque image parameters to their bound resources. GLSL image parameters do not
//! carry a storage format, while Naga's image types do. This preserves the actual global image
//! type/access and writes no pack files. Unsupported dynamic handles remain compiler errors.
// use crate::macros::lex;
// use std::collections::{BTreeMap, BTreeSet};

pub const Function = struct {
    name: []const u8,
    result: []const u8,
    params: std.ArrayList([]const u8),
    images: Vec<(usize,
    body: []const u8,
};
pub const Site = struct {
    start: usize,
    end: usize,
    function: usize,
    prototype: bool,
};
pub const Instance = struct {
    name: []const u8,
    signature: []const u8,
    body: []const u8,
};
pub const Rewriter = struct {
    functions: std.ArrayList(Function),
    resources: BTreeSet<[]const u8>,
    instances: BTreeMap<(usize,
};
pub fn word(s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !s.is_empty() && s.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')
}
pub fn image(s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.strip_prefix("uimage")
    // rust: .or_else(|| s.strip_prefix("iimage"))
    // rust: .or_else(|| s.strip_prefix("image"))
    // rust: .is_some_and(|s| {
    // rust: matches!(
    // rust: s,
    // rust: "1D" | "2D"
    // rust: | "3D"
    // rust: | "Cube"
    // rust: | "Buffer"
    // rust: | "1DArray"
    // rust: | "2DArray"
    // rust: | "CubeArray"
    // rust: | "2DMS"
    // rust: | "2DMSArray"
    // rust: )
    // rust: })
}
pub fn next(tokens: *[[]const u8], i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (i + 1..tokens.len()).find(|&j| !tokens[j].trim().is_empty())
}
pub fn close(tokens: *[[]const u8], open: usize, left: []const u8, right: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut depth = 0;
    // rust: for (i, t) in tokens.iter().enumerate().skip(open) {
    // rust: if *t == left {
    // rust: depth += 1;
    // rust: } else if *t == right {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: return Some(i);
}
}
}
    // rust: None
}
pub fn args(tokens: *[[]const u8], open: usize, end: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut depth, mut first) = (0, open + 1);
    // rust: let mut result = Vec::new();
    // rust: for i in open + 1..end {
    // rust: match tokens[i] {
    // rust: "(" | "[" => depth += 1,
    // rust: ")" | "]" => depth -= 1,
    // rust: "," if depth == 0 => {
    // rust: result.push(tokens[first..i].concat());
    // rust: first = i + 1;
}
    // rust: _ => {}
}
}
    // rust: let last = tokens[first..end].concat();
    // rust: if !last.trim().is_empty() {
    // rust: result.push(last);
}
    // rust: result
}
    // rust: impl Rewriter {
pub fn calls(self: *Self, text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tokens = lex(text);
    // rust: let mut out = String::new();
    // rust: let mut i = 0;
    // rust: while i < tokens.len() {
    // rust: let Some(open) = next(&tokens, i).filter(|&o| tokens[o] == "(") else {
    // rust: out.push_str(tokens[i]);
    // rust: i += 1;
    // rust: continue;
}
    // rust: let Some(end) = close(&tokens, open, "(", ")") else {
    // rust: out.push_str(tokens[i]);
    // rust: i += 1;
    // rust: continue;
}
    // rust: let params = args(&tokens, open, end);
    // rust: let candidates: Vec<_> = self
    // rust: .functions
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, f)| f.name == tokens[i] && f.params.len() == params.len())
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: if candidates.is_empty() {
    // rust: out.push_str(tokens[i]);
    // rust: i += 1;
    // rust: continue;
}
    // rust: if candidates.len() != 1 {
    // rust: return Err(format!(
    // rust: "image-parameter overload of {} is ambiguous",
    // rust: tokens[i]
    // rust: ));
}
    // rust: let id = candidates[0];
    // rust: let function = self.functions[id].clone();
    // rust: let mut bindings = Vec::new();
    // rust: for (k, _) in &function.images {
    // rust: let value = lex(&params[*k])
    // rust: .into_iter()
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: .collect::<String>();
    // rust: if !word(&value) || !self.resources.contains(&value) {
    // rust: return Err(format!(
    // rust: "image parameter of {} must resolve to a bound image",
    // rust: function.name
    // rust: ));
}
    // rust: bindings.push(value);
}
    // rust: let key = (id, bindings.clone());
    // rust: if !self.instances.contains_key(&key) {
    // rust: if self.instances.len() >= 256 {
    // rust: return Err("image parameter specialization exceeds 256 variants".into());
}
    // rust: let name = format!("hz_image_call_{}", self.instances.len());
    // rust: let params = function
    // rust: .params
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(k, _)| !function.images.iter().any(|(i, _)| i == k))
    // rust: .map(|(_, p)| p.clone())
    // rust: .collect::<Vec<_>>()
    // rust: .join(",");
    // rust: let signature = format!("{} {name}({params})", function.result);
    // rust: self.instances.insert(
    // rust: key.clone(),
    // rust: Instance {
    // rust: name,
    // rust: signature,
    // rust: body: String::new(),
    // rust: },
    // rust: );
    // rust: let substitutions: BTreeMap<_, _> = function
    // rust: .images
    // rust: .iter()
    // rust: .zip(&bindings)
    // rust: .map(|((_, p), b)| (p.as_str(), b.as_str()))
    // rust: .collect();
    // rust: let body = lex(&function.body)
    // rust: .iter()
    // rust: .map(|t| substitutions.get(t).copied().unwrap_or(t))
    // rust: .collect::<String>();
    // rust: let body = self.calls(&body)?;
    // rust: self.instances.get_mut(&key).unwrap().body = body;
}
    // rust: let name = self.instances[&key].name.clone();
    // rust: let mut kept = Vec::new();
    // rust: for (k, param) in params.iter().enumerate() {
    // rust: if !function.images.iter().any(|(i, _)| *i == k) {
    // rust: kept.push(self.calls(param)?);
}
}
    // rust: let call = format!("{name}({})", kept.join(","));
    // rust: out.push_str(&call.replace('\n', " "));
    // rust: out.extend(
    // rust: tokens[i..=end]
    // rust: .iter()
    // rust: .flat_map(|t| t.chars().filter(|c| *c == '\n')),
    // rust: );
    // rust: i = end + 1;
}
    // rust: Ok(out)
}
}

    // rust: pub(super) fn rewrite(text: &str) -> Result<String, String> {
    // rust: let tokens = lex(text);
    // rust: let words: Vec<_> = tokens
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, t)| !t.trim().is_empty())
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: let resources = words
    // rust: .windows(2)
    // rust: .filter(|p| image(tokens[p[0]]) && word(tokens[p[1]]))
    // rust: .map(|p| tokens[p[1]].to_owned())
    // rust: .collect();
    // rust: let mut functions: Vec<Function> = Vec::new();
    // rust: let mut sites = Vec::new();
    // rust: let mut depth = 0;
    // rust: let mut i = 0;
    // rust: while i < tokens.len() {
    // rust: match tokens[i] {
    // rust: "{" => depth += 1,
    // rust: "}" => depth -= 1,
    // rust: _ => {}
}
    // rust: if depth != 0 || !word(tokens[i]) {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let Some(open) = next(&tokens, i).filter(|&o| tokens[o] == "(") else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let Some(end) = close(&tokens, open, "(", ")") else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let Some(after) = next(&tokens, end).filter(|&j| matches!(tokens[j], "{" | ";")) else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let params = args(&tokens, open, end);
    // rust: let mut images = Vec::new();
    // rust: for (k, p) in params.iter().enumerate() {
    // rust: let w: Vec<_> = lex(p)
    // rust: .into_iter()
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: .collect();
    // rust: if let Some(at) = w.iter().position(|t| image(t))
    // rust: && let Some(name) = w.get(at + 1)
    // rust: {
    // rust: images.push((k, (*name).to_owned()));
}
}
    // rust: if images.is_empty() {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let Some(start) = (0..i).rev().find(|&j| !tokens[j].trim().is_empty()) else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: if !word(tokens[start]) {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let prototype = tokens[after] == ";";
    // rust: let stop = if prototype {
    // rust: after
    // rust: } else {
    // rust: close(&tokens, after, "{", "}").ok_or("unterminated image function")?
}
    // rust: let function = Function {
    // rust: name: tokens[i].into(),
    // rust: result: tokens[start].into(),
    // rust: params,
    // rust: images,
    // rust: body: if prototype {
    // rust: String::new()
    // rust: } else {
    // rust: tokens[after + 1..stop].concat()
    // rust: },
}
    // rust: let id = functions
    // rust: .iter()
    // rust: .position(|f| f.name == function.name && f.params == function.params)
    // rust: .unwrap_or(functions.len());
    // rust: if id == functions.len() {
    // rust: functions.push(function);
    // rust: } else if !prototype {
    // rust: functions[id] = function;
}
    // rust: sites.push(Site {
    // rust: start,
    // rust: end: stop + 1,
    // rust: function: id,
    // rust: prototype,
    // rust: });
    // rust: i = stop + 1;
}
    // rust: if sites.is_empty() {
    // rust: return Ok(text.into());
}
    // rust: let mut r = Rewriter {
    // rust: functions,
    // rust: resources,
    // rust: instances: BTreeMap::new(),
}
    // rust: let mut chunks = Vec::new();
    // rust: let mut first = 0;
    // rust: for site in &sites {
    // rust: chunks.push(r.calls(&tokens[first..site.start].concat())?);
    // rust: first = site.end;
}
    // rust: chunks.push(r.calls(&tokens[first..].concat())?);
    // rust: let mut out = String::new();
    // rust: for (k, site) in sites.iter().enumerate() {
    // rust: out.push_str(&chunks[k]);
    // rust: for ((id, _), instance) in &r.instances {
    // rust: if *id == site.function {
    // rust: let code = if site.prototype {
    // rust: format!("{};", instance.signature)
    // rust: } else {
    // rust: format!("{}{{{}}}", instance.signature, instance.body)
}
    // rust: out.push_str(&code.replace('\n', " "));
}
}
    // rust: out.extend(
    // rust: tokens[site.start..site.end]
    // rust: .iter()
    // rust: .flat_map(|t| t.chars().filter(|c| *c == '\n')),
    // rust: );
}
    // rust: out.push_str(chunks.last().unwrap());
    // rust: Ok(out)
}
