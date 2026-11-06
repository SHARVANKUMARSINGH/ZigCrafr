//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-api-gen_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Generate the typed mod interface from native hook signatures and catalog contracts.
// use heck::ToSnakeCase;
// use quote::ToTokens;
// use std::{
    // rust: collections::{BTreeMap, HashSet},
    // rust: fs,
    // rust: path::Path,
    // rust: process::Command,
}
// use syn::{FnArg, ImplItem, Item, Pat, Type, visit::Visit, visit_mut::VisitMut};

pub fn impl_functions(item: syn::ItemImpl) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item.items.into_iter().filter_map(|item| match item {
    // rust: ImplItem::Fn(method) => Some(syn::ItemFn {
    // rust: attrs: method.attrs,
    // rust: vis: method.vis,
    // rust: sig: method.sig,
    // rust: block: Box::new(method.block),
    // rust: }),
    // rust: _ => None,
    // rust: })
}

/// The inherent `Game` methods of the files under `path`, each with its module (`native_hooks`,
/// `lan::guest`…) below `module`.
    // rust: fn game_methods(
    // rust: path: &Path,
    // rust: module: &str,
    // rust: methods: &mut Vec<(String, syn::ItemFn)>,
    // rust: ) -> Result<(), String> {
    // rust: for entry in fs::read_dir(path).map_err(|e| e.to_string())? {
    // rust: let path = entry.map_err(|e| e.to_string())?.path();
    // rust: let stem = path
    // rust: .file_stem()
    // rust: .and_then(|s| s.to_str())
    // rust: .unwrap_or_default();
    // rust: let inner = format!("{module}::{stem}");
    // rust: if path.is_dir() {
    // rust: game_methods(&path, &inner, methods)?;
    // rust: } else if path.extension().is_some_and(|ext| ext == "rs") {
    // rust: let source = fs::read_to_string(&path).map_err(|e| e.to_string())?;
    // rust: let file = syn::parse_file(&source).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: for item in file.items {
    // rust: if let Item::Impl(item) = item
    // rust: && item.trait_.is_none()
    // rust: && let Type::Path(ty) = &*item.self_ty
    // rust: && ty.path.segments.len() == 1
    // rust: && ty.path.segments[0].ident == "Game"
    // rust: {
    // rust: methods.extend(impl_functions(item).map(|method| (inner.clone(), method)));
}
}
}
}
    // rust: Ok(())
}

    // rust: fn doc_comments(
    // rust: attrs: &[syn::Attribute],
    // rust: name: &str,
    // rust: preserve_empty: bool,
    // rust: ) -> Result<String, String> {
    // rust: let mut docs = String::new();
    // rust: for attr in attrs.iter().filter(|attr| attr.path().is_ident("doc")) {
    // rust: let syn::Meta::NameValue(value) = &attr.meta else {
    // rust: return Err(format!("unsupported doc attribute in {name}"));
}
    // rust: let syn::Expr::Lit(syn::ExprLit {
    // rust: lit: syn::Lit::Str(doc),
    // rust: ..
    // rust: }) = &value.value
    // rust: else {
    // rust: return Err(format!("unsupported doc attribute in {name}"));
}
    // rust: let value = doc.value();
    // rust: for line in value.split('\n') {
    // rust: if preserve_empty || !line.is_empty() {
    // rust: docs.push_str(&format!("///{line}\n"));
}
}
}
    // rust: Ok(docs)
}

pub const ApiTypes = struct {
    exports: std.AutoHashMap([]const u8, void),
    handles: BTreeMap<[]const u8,
};

pub fn api_types(source: []const u8, generated: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
pub fn use_names(tree: *syn::UseTree, names: *mut std.AutoHashMap([]const u8, void)) void {
}
    // rust: match tree {
    // rust: syn::UseTree::Path(path) => use_names(&path.tree, names),
    // rust: syn::UseTree::Name(name) => {
    // rust: names.insert(name.ident.to_string());
}
    // rust: syn::UseTree::Rename(rename) => {
    // rust: names.insert(rename.rename.to_string());
}
    // rust: syn::UseTree::Group(group) => {
    // rust: for item in &group.items {
    // rust: use_names(item, names);
}
}
    // rust: syn::UseTree::Glob(_) => {}
}
}
    // rust: let mut names = HashSet::new();
    // rust: let mut handles = BTreeMap::new();
    // rust: for (source, collect_handles) in [(source, true), (generated, false)] {
    // rust: let file = syn::parse_file(source).map_err(|e| e.to_string())?;
    // rust: for item in file.items {
    // rust: let ident = match item {
    // rust: Item::Use(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: use_names(&item.tree, &mut names);
    // rust: None
}
    // rust: Item::Struct(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: if collect_handles
    // rust: && let Some(base) = item.ident.to_string().strip_suffix("Ref")
    // rust: && !base.is_empty()
    // rust: {
    // rust: let receiver = base.to_snake_case();
    // rust: if handles
    // rust: .insert(receiver.clone(), item.ident.to_string())
    // rust: .is_some()
    // rust: {
    // rust: return Err(format!("duplicate handle receiver {receiver}"));
}
}
    // rust: Some(item.ident)
}
    // rust: Item::Enum(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: Some(item.ident)
}
    // rust: Item::Union(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: Some(item.ident)
}
    // rust: Item::Type(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: Some(item.ident)
}
    // rust: Item::Trait(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: Some(item.ident)
}
    // rust: Item::Mod(item) if matches!(item.vis, syn::Visibility::Public(_)) => {
    // rust: Some(item.ident)
}
    // rust: _ => None,
}
    // rust: if let Some(ident) = ident {
    // rust: names.insert(ident.to_string());
}
}
}
    // rust: Ok(ApiTypes {
    // rust: exports: names,
    // rust: handles,
    // rust: })
}

    // rust: fn host_method(
    // rust: method: &syn::ItemFn,
    // rust: name: &str,
    // rust: exports: &HashSet<String>,
    // rust: ) -> Result<(String, String), String> {
pub const Types = struct {
    exports: *'a std.AutoHashMap([]const u8, void),
    error: ?[]const u8,
};
    // rust: impl Types<'_> {
pub fn check_path(self: *Self, path: *syn::Path) void {
}
    // rust: let first = path.segments.first().unwrap().ident.to_string();
    // rust: let unqualified = path.leading_colon.is_none() && path.segments.len() == 1;
    // rust: let prelude = unqualified
    // rust: && matches!(
    // rust: first.as_str(),
    // rust: "bool"
    // rust: | "char"
    // rust: | "str"
    // rust: | "u8"
    // rust: | "u16"
    // rust: | "u32"
    // rust: | "u64"
    // rust: | "u128"
    // rust: | "usize"
    // rust: | "i8"
    // rust: | "i16"
    // rust: | "i32"
    // rust: | "i64"
    // rust: | "i128"
    // rust: | "isize"
    // rust: | "f32"
    // rust: | "f64"
    // rust: | "String"
    // rust: | "Option"
    // rust: | "Result"
    // rust: | "Vec"
    // rust: | "Box"
    // rust: | "Arc"
    // rust: | "PathBuf"
    // rust: | "AsRef"
    // rust: | "AsMut"
    // rust: | "From"
    // rust: | "Into"
    // rust: | "TryFrom"
    // rust: | "TryInto"
    // rust: | "Iterator"
    // rust: | "IntoIterator"
    // rust: | "DoubleEndedIterator"
    // rust: | "ExactSizeIterator"
    // rust: | "Extend"
    // rust: | "Fn"
    // rust: | "FnMut"
    // rust: | "FnOnce"
    // rust: | "Sized"
    // rust: | "Send"
    // rust: | "Sync"
    // rust: | "Unpin"
    // rust: | "Drop"
    // rust: | "Default"
    // rust: | "Clone"
    // rust: | "Copy"
    // rust: | "PartialEq"
    // rust: | "PartialOrd"
    // rust: | "Eq"
    // rust: | "Ord"
    // rust: | "ToOwned"
    // rust: | "ToString"
    // rust: | "Future"
    // rust: | "IntoFuture"
    // rust: );
    // rust: if path.leading_colon.is_some() || !(prelude || self.exports.contains(&first)) {
    // rust: self.error = Some(format!(
    // rust: "type {} is not available in mod_api",
    // rust: path.to_token_stream()
    // rust: ));
}
}
}
    // rust: impl<'ast> Visit<'ast> for Types<'_> {
pub fn visit_type_impl_trait(self: *Self, _: *'ast syn::TypeImplTrait) void {
}
    // rust: self.error = Some("impl Trait is not object-safe".into());
}
pub fn visit_type_path(self: *Self, ty: *'ast syn::TypePath) void {
}
    // rust: if ty.qself.is_some() {
    // rust: self.error = Some("qualified associated types are not supported".into());
    // rust: } else {
    // rust: self.check_path(&ty.path);
}
    // rust: syn::visit::visit_type_path(self, ty);
}
pub fn visit_trait_bound(self: *Self, bound: *'ast syn::TraitBound) void {
}
    // rust: self.check_path(&bound.path);
    // rust: syn::visit::visit_trait_bound(self, bound);
}
}
    // rust: if method.sig.asyncness.is_some() {
    // rust: return Err(format!("{name}: async methods are not object-safe"));
}
    // rust: if method
    // rust: .sig
    // rust: .generics
    // rust: .params
    // rust: .iter()
    // rust: .any(|param| !matches!(param, syn::GenericParam::Lifetime(_)))
    // rust: {
    // rust: return Err(format!("{name}: generic methods are not object-safe"));
}
    // rust: let mut types = Types {
    // rust: exports,
    // rust: error: None,
}
    // rust: for arg in &method.sig.inputs {
    // rust: if let FnArg::Typed(arg) = arg {
    // rust: types.visit_type(&arg.ty);
}
}
    // rust: if let syn::ReturnType::Type(_, ty) = &method.sig.output {
    // rust: types.visit_type(ty);
}
    // rust: if let Some(reason) = types.error {
    // rust: return Err(format!("{name}: {reason}"));
}
    // rust: let mut sig = method.sig.clone();
    // rust: let original = sig.ident.clone();
    // rust: sig.ident = syn::parse_str(name).map_err(|e| format!("invalid helper name {name}: {e}"))?;
    // rust: let mut args = Vec::new();
    // rust: let callee = match sig.inputs.first() {
    // rust: Some(FnArg::Receiver(r)) if r.reference.is_some() => "self.",
    // rust: Some(FnArg::Receiver(_)) => {
    // rust: return Err(format!("{name}: expected a borrowed Game receiver"));
}
    // rust: _ => {
            // A receiverless helper stays callable on `&self` in the trait.
    // rust: sig.inputs.insert(0, syn::parse_quote!(&self));
    // rust: "Self::"
}
}
    // rust: for arg in sig.inputs.iter_mut().skip(1) {
    // rust: let FnArg::Typed(arg) = arg else {
    // rust: return Err(format!("{name}: unexpected receiver"));
}
    // rust: let Pat::Ident(pat) = &mut *arg.pat else {
    // rust: return Err(format!("{name}: unsupported argument"));
}
    // rust: pat.mutability = None;
    // rust: args.push(pat.ident.to_string());
}
    // rust: let docs = doc_comments(&method.attrs, name, true)?;
    // rust: let unused = args
    // rust: .iter()
    // rust: .map(|arg| format!("let _ = {arg};"))
    // rust: .collect::<String>();
    // rust: Ok((
    // rust: format!(
    // rust: "{docs}{} {{ {unused} unimplemented!(\"Host::{name}\") }}\n",
    // rust: sig.to_token_stream()
    // rust: ),
    // rust: format!(
    // rust: "{} {{ {callee}{original}({}) }}\n",
    // rust: sig.to_token_stream(),
    // rust: args.join(", ")
    // rust: ),
    // rust: ))
}

/// A helper's method on its handle (`receiver`): `entity_position(entity)` on
/// `Host` is also `EntityRef::position(self, host)`, which calls it. The
/// helper's first argument is the handle; the host is borrowed as the helper
/// borrows `Game`.
    // rust: fn handle_method<'a>(
    // rust: method: &syn::ItemFn,
    // rust: name: &str,
    // rust: receiver: &str,
    // rust: handles: &'a BTreeMap<String, String>,
    // rust: ) -> Result<(&'a str, String), String> {
    // rust: let handle = handles
    // rust: .get(receiver)
    // rust: .ok_or_else(|| format!("{name}: unknown receiver {receiver}"))?
    // rust: .as_str();
    // rust: let short = name
    // rust: .strip_prefix(receiver)
    // rust: .and_then(|rest| rest.strip_prefix('_'))
    // rust: .ok_or_else(|| format!("{name}: a {receiver} helper's name starts with {receiver}_"))?;
    // rust: let mut sig = method.sig.clone();
    // rust: sig.ident =
    // rust: syn::parse_str(short).map_err(|_| format!("{name}: {short} is not a method name"))?;
    // rust: let mut inputs = sig.inputs.iter();
    // rust: let host: FnArg = match inputs.next() {
    // rust: Some(FnArg::Receiver(r)) if r.reference.is_some() && r.mutability.is_some() => {
    // rust: syn::parse_quote!(host: &mut dyn Host)
}
    // rust: Some(FnArg::Receiver(r)) if r.reference.is_some() => syn::parse_quote!(host: &dyn Host),
    // rust: _ => return Err(format!("{name}: a {receiver} helper borrows Game")),
}
    // rust: let takes_handle = matches!(
    // rust: inputs.next(),
    // rust: Some(FnArg::Typed(arg)) if matches!(&*arg.ty, Type::Path(ty) if ty.path.is_ident(handle))
    // rust: );
    // rust: if !takes_handle {
    // rust: return Err(format!(
    // rust: "{name}: a {receiver} helper takes a {handle} first"
    // rust: ));
}
    // rust: let mut args = String::new();
    // rust: let mut rest = vec![syn::parse_quote!(self), host];
    // rust: for arg in inputs {
    // rust: let mut arg = arg.clone();
    // rust: let FnArg::Typed(typed) = &mut arg else {
    // rust: return Err(format!("{name}: unexpected receiver"));
}
    // rust: let Pat::Ident(pat) = &mut *typed.pat else {
    // rust: return Err(format!("{name}: unsupported argument"));
}
    // rust: pat.mutability = None;
    // rust: args.push_str(&format!(", {}", pat.ident));
    // rust: rest.push(arg);
}
    // rust: sig.inputs = rest.into_iter().collect();
    // rust: let docs = doc_comments(&method.attrs, name, true)?;
    // rust: Ok((
    // rust: handle,
    // rust: format!(
    // rust: "{docs}pub {} {{ host.{name}(self{args}) }}\n",
    // rust: sig.to_token_stream()
    // rust: ),
    // rust: ))
}

pub fn has_call(block: *syn::Block, expected: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
pub const Calls = struct {
    expected: *'a str,
    found: bool,
};
    // rust: impl<'ast> Visit<'ast> for Calls<'_> {
pub fn visit_expr_call(self: *Self, call: *'ast syn::ExprCall) void {
}
    // rust: if let syn::Expr::Path(path) = &*call.func
    // rust: && path
    // rust: .path
    // rust: .segments
    // rust: .last()
    // rust: .is_some_and(|s| s.ident == self.expected)
    // rust: {
    // rust: self.found = true;
}
    // rust: syn::visit::visit_expr_call(self, call);
}
}
    // rust: let mut calls = Calls {
    // rust: expected,
    // rust: found: false,
}
    // rust: calls.visit_block(block);
    // rust: calls.found
}

    // rust: fn one_function<'a>(
    // rust: items: impl Iterator<Item = &'a syn::ItemFn>,
    // rust: name: &str,
    // rust: ) -> Result<&'a syn::ItemFn, String> {
    // rust: let mut matches = items.filter(|item| item.sig.ident == name);
    // rust: let first = matches
    // rust: .next()
    // rust: .ok_or_else(|| format!("expected one {name} signature"))?;
    // rust: if matches.next().is_some() {
    // rust: return Err(format!("expected one {name} signature"));
}
    // rust: Ok(first)
}

pub fn fresh_name(base: []const u8, used: *mut std.AutoHashMap([]const u8, void)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut name = base.to_owned();
    // rust: while !used.insert(name.clone()) {
    // rust: name.push('_');
}
    // rust: name
}

/// Turns a hook argument's type into its event field's. A `&mut` primitive scalar becomes the value
/// itself, written back after every mod has run; any other `&mut` stays a reference to the caller's
/// value. Either way one event goes through every mod, so each sees the changes before it. Every
/// elided reference lifetime becomes the event's `'a`, or `'b` inside a `&mut`, which can't shorten
/// it. The launcher keeps a copy for trait injections (`launcher/src/native_mods/inject.rs`); both
/// test the same types.
pub const EventLifetimes = struct {
    a: bool,
    b: bool,
    in_mut: bool,
};

    // rust: impl EventLifetimes {
    /// The field's type, and whether it is a scalar copied in and written back.
pub fn field(self: *Self, ty: *Type) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let scalar = match ty {
    // rust: Type::Reference(reference) if reference.mutability.is_some() => {
    // rust: match &*reference.elem {
    // rust: Type::Path(path)
    // rust: if path.qself.is_none()
    // rust: && path.path.get_ident().is_some_and(|ident| {
    // rust: [
    // rust: "bool", "char", "i8", "i16", "i32", "i64", "i128", "isize",
    // rust: "u8", "u16", "u32", "u64", "u128", "usize", "f32", "f64",
    // rust: ]
    // rust: .iter()
    // rust: .any(|scalar| ident == scalar)
    // rust: }) =>
    // rust: {
    // rust: Some(&*reference.elem)
}
    // rust: _ => None,
}
}
    // rust: _ => None,
}
    // rust: if let Some(scalar) = scalar {
    // rust: return (scalar.clone(), true);
}
    // rust: let mut field = ty.clone();
    // rust: self.visit_type_mut(&mut field);
    // rust: (field, false)
}
}

    // rust: impl VisitMut for EventLifetimes {
pub fn visit_type_reference_mut(self: *Self, reference: *mut syn::TypeReference) void {
}
    // rust: if reference.lifetime.is_none() {
    // rust: reference.lifetime = Some(syn::parse_quote!('_));
}
    // rust: let outer = self.in_mut;
    // rust: self.visit_lifetime_mut(reference.lifetime.as_mut().unwrap());
    // rust: self.in_mut |= reference.mutability.is_some();
    // rust: self.visit_type_mut(&mut reference.elem);
    // rust: self.in_mut = outer;
}
pub fn visit_lifetime_mut(self: *Self, lifetime: *mut syn::Lifetime) void {
}
    // rust: if lifetime.ident == "_" {
    // rust: *lifetime = if self.in_mut {
    // rust: self.b = true;
    // rust: syn::parse_quote!('b)
    // rust: } else {
    // rust: self.a = true;
    // rust: syn::parse_quote!('a)
}
}
}
}

pub fn host_for(is_level: bool, mutable: ?bool, ticks: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mutable.map(|mutable| {
    // rust: let (name, kind) = if is_level {
    // rust: (
    // rust: "level",
    // rust: match (mutable, ticks) {
    // rust: (true, true) => "LevelWriteHost",
    // rust: (false, true) => "LevelTicksHost",
    // rust: (true, false) => "LevelRandomHost",
    // rust: (false, false) => "LevelHost",
    // rust: },
    // rust: )
    // rust: } else {
    // rust: ("host", "Host")
}
    // rust: let mutable = if mutable || (is_level && ticks) {
    // rust: "mut "
    // rust: } else {
    // rust: ""
}
    // rust: (name, format!("&{mutable}dyn {kind}"))
    // rust: })
}

    // rust: fn catalog_hooks(
    // rust: root: &Path,
    // rust: catalog: &serde_json::Value,
    // rust: ) -> Result<Vec<serde_json::Value>, String> {
    // rust: let mut hooks = catalog["hooks"]
    // rust: .as_array()
    // rust: .ok_or("catalog hooks must be an array")?
    // rust: .clone();
    // rust: let mut paths = fs::read_dir(root.join("tools/native-hook-fragments"))
    // rust: .map_err(|e| e.to_string())?
    // rust: .map(|entry| entry.map(|entry| entry.path()).map_err(|e| e.to_string()))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: paths.sort();
    // rust: for path in paths
    // rust: .into_iter()
    // rust: .filter(|path| path.extension().is_some_and(|ext| ext == "json"))
    // rust: {
    // rust: let fragment: serde_json::Value =
    // rust: serde_json::from_str(&fs::read_to_string(&path).map_err(|e| e.to_string())?)
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: hooks.extend(
    // rust: fragment["hooks"]
    // rust: .as_array()
    // rust: .ok_or("fragment hooks must be an array")?
    // rust: .iter()
    // rust: .cloned(),
    // rust: );
}
    // rust: let mut seen = HashSet::new();
    // rust: for hook in &hooks {
    // rust: let name = hook["name"].as_str().ok_or("hook name missing")?;
    // rust: if !seen.insert(name.to_owned()) {
    // rust: return Err(format!("duplicate hook {name}"));
}
}
    // rust: Ok(hooks)
}

/// The crate folder and module path of a hook target that is a free function
/// outside `Game`. `horizon-client-lib` builds from `horizon-client/src`
/// (`client_lib.rs`); `menu` and `breathing` are also accepted under their
/// older `horizon_client::` names.
pub fn free_function_source(target: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefixes = [
    // rust: ("horizon_world::", "horizon-world"),
    // rust: ("horizon_client_render::", "horizon-client-render"),
    // rust: ("horizon_client_lib::", "horizon-client"),
    // rust: ];
    // rust: prefixes
    // rust: .into_iter()
    // rust: .find_map(|(prefix, krate)| target.strip_prefix(prefix).map(|p| (krate, p.to_owned())))
    // rust: .or_else(|| {
    // rust: ["menu", "breathing"].into_iter().find_map(|module| {
    // rust: target
    // rust: .strip_prefix(&format!("horizon_client::{module}::"))
    // rust: .map(|p| ("horizon-client", format!("{module}::{p}")))
    // rust: })
    // rust: })
}

/// Whether a hook function needs its dispatch `call` filled in: false when it
/// makes the call; true when it is a `Game` or `GameLevel` method whose body is
/// only the placeholder a new hook starts with, `let _ = (every, parameter);`
/// (`let _ = parameter;` for one). Any other body is an error, left alone.
pub fn needs_fill(method: *syn::ItemFn, call: []const u8, in_game: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if has_call(&method.block, call) {
    // rust: return Ok(false);
}
    // rust: let params: Vec<String> = method
    // rust: .sig
    // rust: .inputs
    // rust: .iter()
    // rust: .filter_map(|arg| match arg {
    // rust: FnArg::Typed(arg) => Some(arg.pat.to_token_stream().to_string()),
    // rust: FnArg::Receiver(_) => None,
    // rust: })
    // rust: .collect();
    // rust: let named = match &method.block.stmts[..] {
    // rust: [
    // rust: syn::Stmt::Local(syn::Local {
    // rust: pat: Pat::Wild(_),
    // rust: init:
    // rust: Some(syn::LocalInit {
    // rust: expr,
    // rust: diverge: None,
    // rust: ..
    // rust: }),
    // rust: ..
    // rust: }),
    // rust: ] => match &**expr {
    // rust: syn::Expr::Tuple(tuple) => Some(
    // rust: tuple
    // rust: .elems
    // rust: .iter()
    // rust: .map(|e| e.to_token_stream().to_string())
    // rust: .collect(),
    // rust: ),
    // rust: single @ syn::Expr::Path(_) => Some(vec![single.to_token_stream().to_string()]),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
    // rust: if in_game && named == Some(params) {
    // rust: return Ok(true);
}
    // rust: Err(format!(
    // rust: "missing {call} call in {}: add it, or leave a Game hook's body as the let _ = (…); placeholder for cargo run -p xtask -- mod-api to fill",
    // rust: method.sig.ident
    // rust: ))
}

/// A hook function whose placeholder body becomes `call`.
pub const Fill = struct {
    native: []const u8,
    call: []const u8,
};

/// `source` with each fill's placeholder statement replaced by its call,
/// formatted as `cargo fmt` would.
pub fn filled_hooks(source: []const u8, fills: *[Fill]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut source = source.to_owned();
    // rust: for Fill { native, call } in fills {
    // rust: let start = source
    // rust: .find(&format!("fn {native}("))
    // rust: .ok_or_else(|| format!("{native} not found"))?;
    // rust: let placeholder = start
    // rust: + source[start..]
    // rust: .find("let _ =")
    // rust: .ok_or_else(|| format!("{native} has no placeholder"))?;
    // rust: let end = placeholder
    // rust: + source[placeholder..]
    // rust: .find(';')
    // rust: .ok_or_else(|| format!("{native} has no placeholder"))?
    // rust: + 1;
    // rust: source.replace_range(placeholder..end, call);
}
    // rust: rustfmt(&source)
}

/// The workspace's edition, which rustfmt formats generated code for.
pub const EDITION: []const u8 = "2024";

/// `code` as `cargo fmt` formats it.
pub fn rustfmt(code: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut child = Command::new("rustfmt")
    // rust: .args(["--emit", "stdout", "--edition", EDITION])
    // rust: .stdin(std::process::Stdio::piped())
    // rust: .stdout(std::process::Stdio::piped())
    // rust: .spawn()
    // rust: .map_err(|e| e.to_string())?;
//     use std::io::Write;
    // rust: child
    // rust: .stdin
    // rust: .take()
    // rust: .ok_or("rustfmt stdin")?
    // rust: .write_all(code.as_bytes())
    // rust: .map_err(|e| e.to_string())?;
    // rust: let formatted = child.wait_with_output().map_err(|e| e.to_string())?;
    // rust: if !formatted.status.success() {
    // rust: return Err("rustfmt failed".into());
}
    // rust: Ok(formatted.stdout)
}

/// The crate whose generated sources are being built.
pub const Target = enum {
    Client,
    Render,
};

/// Fill new hooks' placeholders in hand-written source. Never writes generated files.
pub fn fill_hooks(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sources(root, FillMode::Fill).map(|_| ())
}

pub const Sources = struct {
    hooks: []const u8,
    host: []const u8,
    implementation: []const u8,
    render: []const u8,
};

/// Parse and validate the catalog and hook/helper signatures.
pub fn sources(root: *Path, fill: FillMode) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let catalog: serde_json::Value = serde_json::from_str(
    // rust: &fs::read_to_string(root.join("native-hooks.json")).map_err(|e| e.to_string())?,
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
    // rust: let source = fs::read_to_string(root.join("crates/horizon-client/src/game/native_hooks.rs"))
    // rust: .map_err(|e| e.to_string())?;
    // rust: let file = syn::parse_file(&source).map_err(|e| e.to_string())?;
    // rust: let mut methods = Vec::new();
    // rust: for item in file.items {
    // rust: if let Item::Impl(item) = item {
    // rust: methods.extend(impl_functions(item));
}
}
    // rust: let mut traits = String::new();
    // rust: let mut dispatch = String::new();
    // rust: let mut render_traits = String::new();
    // rust: let mut render_dispatch = String::new();
    // rust: let hooks = catalog_hooks(root, &catalog)?;
    // rust: let mut fills = Vec::new();
    // rust: for hook in &hooks {
    // rust: let name = hook["name"].as_str().ok_or("hook name missing")?;
    // rust: let api = hook
    // rust: .get("mod_api")
    // rust: .ok_or_else(|| format!("hook {name} has no mod_api entry: add one"))?;
    // rust: let native = format!("native_{name}");
    // rust: let target = hook["target"].as_str().ok_or("target missing")?;
    // rust: let is_render = target.starts_with("horizon_client_render::");
    // rust: let external = free_function_source(target);
    // rust: let in_game = external.is_none();
    // rust: let (method, call) = if let Some((krate, path)) = external {
    // rust: let Some((module, function)) = path.rsplit_once("::") else {
    // rust: return Err(format!("wrong target for {name}"));
}
    // rust: if function != native {
    // rust: return Err(format!("wrong target for {name}"));
}
    // rust: let path = root
    // rust: .join("crates")
    // rust: .join(krate)
    // rust: .join("src")
    // rust: .join(format!("{}.rs", module.replace("::", "/")));
    // rust: let source =
    // rust: fs::read_to_string(&path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let file = syn::parse_file(&source).map_err(|e| e.to_string())?;
    // rust: let functions: Vec<_> = file
    // rust: .items
    // rust: .into_iter()
    // rust: .filter_map(|item| match item {
    // rust: Item::Fn(function) => Some(function),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: (
    // rust: one_function(functions.iter(), &native)?.clone(),
    // rust: if is_render {
    // rust: format!("dispatch_{name}")
    // rust: } else {
    // rust: name.to_owned()
    // rust: },
    // rust: )
    // rust: } else {
    // rust: if !target.starts_with("horizon_client::game::native_hooks::")
    // rust: || !target.ends_with(&format!("::{native}"))
    // rust: {
    // rust: return Err(format!("wrong target for {name}"));
}
    // rust: (
    // rust: one_function(methods.iter(), &native)?.clone(),
    // rust: format!("dispatch_{name}"),
    // rust: )
}
    // rust: let fill = needs_fill(&method, &call, in_game)?;
    // rust: let sig = &method.sig;
    // rust: let mut args = Vec::new();
    // rust: let mut receiver_mut = None;
    // rust: for arg in &sig.inputs {
    // rust: match arg {
    // rust: FnArg::Receiver(r) => {
    // rust: receiver_mut = Some(r.mutability.is_some());
}
    // rust: FnArg::Typed(arg) => {
    // rust: let Pat::Ident(pat) = &*arg.pat else {
    // rust: return Err(format!("unsupported argument in {name}"));
}
    // rust: args.push((pat.ident.to_string(), &*arg.ty));
}
}
}
    // rust: let is_level = hook["target"]
    // rust: .as_str()
    // rust: .is_some_and(|target| target.contains("::GameLevel<"));
    // rust: let ticks = is_level
    // rust: && args.iter().any(|(name, ty)| {
    // rust: name == "ticks" && ty.to_token_stream().to_string() == "& mut Ticks"
    // rust: });
    // rust: if ticks {
    // rust: args.retain(|(name, _)| name != "ticks");
}
    // rust: let mut used: HashSet<_> = args.iter().map(|(name, _)| name.clone()).collect();
    // rust: let mod_list = fresh_name("mods", &mut used);
    // rust: let mod_item = fresh_name("mod_hook", &mut used);
    // rust: let replacement = fresh_name("replacement", &mut used);
    // rust: let contract = api["contract"].as_str().ok_or("contract missing")?;
    // rust: let out = api.get("out").and_then(|v| v.as_str());
    // rust: if !matches!(
    // rust: (contract, out),
    // rust: ("cancel" | "replace" | "collect", Some(_)) | ("listen", None)
    // rust: ) {
    // rust: return Err(format!("invalid contract for {name}"));
}
    // rust: let output = if let Some(out) = out {
    // rust: let index = args
    // rust: .iter()
    // rust: .position(|(n, _)| n == out)
    // rust: .ok_or_else(|| format!("missing output {out} in {name}"))?;
    // rust: Some(args.remove(index))
    // rust: } else {
    // rust: None
}
    // rust: let result = if let Some((_, ty)) = &output {
    // rust: let Type::Reference(reference) = ty else {
    // rust: return Err(format!("output must be a mutable reference in {name}"));
}
    // rust: if reference.mutability.is_none() {
    // rust: return Err(format!("output must be a mutable reference in {name}"));
}
    // rust: match contract {
    // rust: "cancel" if reference.elem.to_token_stream().to_string() == "bool" => {
    // rust: " -> Flow".to_owned()
}
    // rust: "replace" => format!(" -> {}", reference.elem.to_token_stream()),
    // rust: "collect" => String::new(),
    // rust: _ => return Err(format!("unexpected output type for {name}")),
}
    // rust: } else {
    // rust: String::new()
}
    // rust: let host = host_for(is_level, receiver_mut, ticks)
    // rust: .map(|(name, ty)| (fresh_name(name, &mut used), ty));
    // rust: let event = fresh_name("event", &mut used);
    // rust: let event_type = format!(
    // rust: "{}Event",
    // rust: name.split('_')
    // rust: .map(|word| word[..1].to_uppercase() + &word[1..])
    // rust: .collect::<String>()
    // rust: );
    // rust: let mut trait_params = vec!["&self".to_owned()];
    // rust: let mut dispatch_params = Vec::new();
    // rust: let mut call_args = Vec::new();
    // rust: if let Some((name, ty)) = &host {
    // rust: trait_params.push(format!("{name}: {ty}"));
    // rust: dispatch_params.push(format!("{name}: {ty}"));
    // rust: call_args.push(name.clone());
}
    // rust: dispatch_params.push(if is_render {
    // rust: format!("{mod_list}: &[&dyn RenderHooks]")
    // rust: } else {
    // rust: format!("{mod_list}: &[Box<dyn Hooks>]")
    // rust: });
    // rust: let mut lifetimes = EventLifetimes::default();
    // rust: let mut fields = String::new();
    // rust: let mut inits = Vec::new();
    // rust: let mut write_back = String::new();
    // rust: let collected = output.as_ref().filter(|_| contract == "collect");
    // rust: for (name, ty) in args.iter().chain(collected) {
    // rust: dispatch_params.push(format!("{name}: {}", ty.to_token_stream()));
    // rust: let (field, scalar) = lifetimes.field(ty);
    // rust: fields.push_str(&format!("pub {name}: {},\n", field.to_token_stream()));
    // rust: if scalar {
    // rust: inits.push(format!("{name}: *{name}"));
    // rust: write_back.push_str(&format!("*{name} = {event}.{name};"));
    // rust: } else {
    // rust: inits.push(name.clone());
}
}
    // rust: if let Some((name, ty)) = output.as_ref().filter(|_| contract != "collect") {
    // rust: dispatch_params.push(format!("{name}: {}", ty.to_token_stream()));
}
    // rust: let (generics, elided) = match (lifetimes.a, lifetimes.b) {
    // rust: (_, true) => ("<'a, 'b>", "<'_, '_>"),
    // rust: (true, false) => ("<'a>", "<'_>"),
    // rust: (false, false) => ("", ""),
}
    // rust: trait_params.push(format!("{event}: &mut {event_type}{elided}"));
    // rust: call_args.push(format!("&mut {event}"));
    // rust: let unused = trait_params[1..]
    // rust: .iter()
    // rust: .map(|param| format!("let _ = {};", param.split(':').next().unwrap()))
    // rust: .collect::<String>();
    // rust: let default = match contract {
    // rust: "cancel" => "Flow::Continue",
    // rust: "replace" => "None",
    // rust: _ => "",
}
    // rust: if fill {
            // The dispatch's parameters in order: the host, the mods, the
            // arguments and the output last.
    // rust: let host = host.as_ref().map(|_| {
    // rust: if ticks {
    // rust: "&mut super::mod_api_host::LevelTicks { level: self, ticks }"
    // rust: } else {
    // rust: "self"
}
    // rust: });
    // rust: let passed = host
    // rust: .into_iter()
    // rust: .chain(["mod_api::mods()"])
    // rust: .chain(args.iter().chain(output.as_ref()).map(|(n, _)| n.as_str()))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: fills.push(Fill {
    // rust: native: native.clone(),
    // rust: call: format!("mod_api::{call}({passed});"),
    // rust: });
}
    // rust: let invoke = call_args.join(", ");
    // rust: let trait_params = trait_params.join(", ");
    // rust: let dispatch_params = dispatch_params.join(", ");
    // rust: let trait_name = if is_render { "RenderHooks" } else { "Hooks" };
    // rust: let traits = if is_render {
    // rust: &mut render_traits
    // rust: } else {
    // rust: &mut traits
}
    // rust: let dispatch = if is_render {
    // rust: &mut render_dispatch
    // rust: } else {
    // rust: &mut dispatch
}
    // rust: traits.push_str(&doc_comments(&method.attrs, name, false)?);
    // rust: match (contract, out) {
    // rust: ("cancel", Some(out)) => traits.push_str(&format!(
    // rust: "///\n/// Return `Flow::Cancel` to take it: this sets `{out}`, and later mods are skipped.\n"
    // rust: )),
    // rust: ("replace", Some(out)) => traits.push_str(&format!(
    // rust: "///\n/// Return `Some` to set `{out}`; the first mod returning `Some` wins.\n"
    // rust: )),
    // rust: ("collect", Some(out)) => traits.push_str(&format!(
    // rust: "///\n/// Every mod gets `{event}.{out}` in order and may add, change or remove {out}.\n"
    // rust: )),
    // rust: _ => {}
}
    // rust: traits.push_str(&format!(
    // rust: "fn {name}({trait_params}){result} {{ {unused} {default} }}\n"
    // rust: ));
    // rust: dispatch.push_str(&format!(
    // rust: "/// What [`{trait_name}::{name}`] is told. Fields may be added: the struct is `#[non_exhaustive]`.\n#[non_exhaustive]\npub struct {event_type}{generics} {{\n{fields}}}\n"
    // rust: ));
    // rust: let build = format!("let mut {event} = {event_type} {{ {} }};", inits.join(", "));
        // A trait mod's call is marked with the mod for a panic to name; render hooks are called bare.
    // rust: let each = if is_render {
    // rust: mod_list.clone()
    // rust: } else {
    // rust: format!("super::entered({mod_list}, \"{name}\")")
}
    // rust: let body = match contract {
    // rust: "cancel" => format!(
    // rust: "if *{o} {{ return; }} {build} for {mod_item} in {each} {{ if matches!({mod_item}.{name}({invoke}), Flow::Cancel) {{ *{o} = true; break; }} }} {write_back}",
    // rust: o = out.unwrap()
    // rust: ),
    // rust: "replace" => format!(
    // rust: "if {o}.is_some() {{ return; }} {build} for {mod_item} in {each} {{ if let Some({replacement}) = {mod_item}.{name}({invoke}) {{ *{o} = Some({replacement}); break; }} }} {write_back}",
    // rust: o = out.unwrap()
    // rust: ),
    // rust: _ => format!(
    // rust: "{build} for {mod_item} in {each} {{ {mod_item}.{name}({invoke}); }} {write_back}"
    // rust: ),
}
    // rust: dispatch.push_str(&format!(
    // rust: "pub fn dispatch_{name}({dispatch_params}) {{ {body} }}\n"
    // rust: ));
}
    // rust: if hooks.is_empty() {
    // rust: return Err("no native hooks".into());
}
    // rust: let code = format!(
    // rust: "// @generated by cargo run -p xtask -- mod-api; do not edit.\nuse super::*;\npub trait Hooks: Send + Sync {{\nfn render(&self) -> Option<&dyn RenderHooks> {{ None }}\n{traits}}}\n{dispatch}"
    // rust: );
    // rust: let api_source = fs::read_to_string(root.join("crates/horizon-client/src/mod_api.rs"))
    // rust: .map_err(|e| e.to_string())?;
    // rust: let types = api_types(&api_source, &code)?;
    // rust: let mut game = Vec::new();
    // rust: game_methods(
    // rust: &root.join("crates/horizon-client/src/game"),
    // rust: "horizon_client::game",
    // rust: &mut game,
    // rust: )?;
    // rust: let mut host_traits = String::new();
    // rust: let mut host_impl = String::new();
    // rust: let mut names = HashSet::new();
    // rust: let mut handles = std::collections::BTreeMap::<&str, String>::new();
    // rust: let mut helpers = catalog["helpers"]
    // rust: .as_array()
    // rust: .ok_or("catalog helpers must be an array")?
    // rust: .clone();
    // rust: let mut fragments = fs::read_dir(root.join("tools/native-hook-fragments"))
    // rust: .map_err(|e| e.to_string())?
    // rust: .map(|entry| entry.map(|entry| entry.path()).map_err(|e| e.to_string()))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: fragments.sort();
    // rust: for path in fragments
    // rust: .into_iter()
    // rust: .filter(|path| path.extension().is_some_and(|ext| ext == "json"))
    // rust: {
    // rust: let fragment: serde_json::Value =
    // rust: serde_json::from_str(&fs::read_to_string(&path).map_err(|e| e.to_string())?)
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: if let Some(pending) = fragment.get("helpers") {
    // rust: helpers.extend(
    // rust: pending
    // rust: .as_array()
    // rust: .ok_or("fragment helpers must be an array")?
    // rust: .iter()
    // rust: .cloned(),
    // rust: );
}
}
    // rust: for helper in &helpers {
    // rust: let name = helper["name"].as_str().ok_or("helper name missing")?;
    // rust: if !names.insert(name) {
    // rust: return Err(format!("duplicate helper {name}"));
}
    // rust: let target = helper["target"].as_str().ok_or("helper target missing")?;
    // rust: let (_, native) = target
    // rust: .rsplit_once("::")
    // rust: .ok_or("helper target missing method")?;
    // rust: if !native.starts_with("native_") {
    // rust: return Err(format!("invalid helper target {target}"));
}
    // rust: let method = one_function(game.iter().map(|(_, method)| method), native)?;
    // rust: let (module, _) = game
    // rust: .iter()
    // rust: .find(|(_, other)| std::ptr::eq(other, method))
    // rust: .expect("the method was found in the list");
    // rust: let expected = format!("{module}::Game<'_>::{native}");
    // rust: if target != expected {
    // rust: return Err(format!(
    // rust: "wrong target for helper {name}: {target}, it is {expected}"
    // rust: ));
}
    // rust: let (declaration, implementation) = host_method(method, name, &types.exports)?;
    // rust: host_traits.push_str(&declaration);
    // rust: host_impl.push_str(&implementation);
    // rust: if let Some(receiver) = helper.get("receiver") {
    // rust: let receiver = receiver
    // rust: .as_str()
    // rust: .ok_or("helper receiver must be a string")?;
    // rust: let (handle, code) = handle_method(method, name, receiver, &types.handles)?;
    // rust: handles.entry(handle).or_default().push_str(&code);
}
}
    // rust: let handles = handles
    // rust: .iter()
    // rust: .map(|(handle, methods)| format!("impl {handle} {{\n{methods}}}\n"))
    // rust: .collect::<String>();
pub const StdTypes = struct {
    path_buf: bool,
    arc: bool,
};
    // rust: impl<'ast> Visit<'ast> for StdTypes {
pub fn visit_type_path(self: *Self, ty: *'ast syn::TypePath) void {
}
    // rust: if ty.path.segments.len() == 1 {
    // rust: self.path_buf |= ty.path.segments[0].ident == "PathBuf";
    // rust: self.arc |= ty.path.segments[0].ident == "Arc";
}
    // rust: syn::visit::visit_type_path(self, ty);
}
}
    // rust: let host_trait: syn::ItemTrait = syn::parse_str(&format!("trait Host {{ {host_traits} }}"))
    // rust: .map_err(|e| format!("generated Host: {e}"))?;
    // rust: let mut std_types = StdTypes {
    // rust: path_buf: false,
    // rust: arc: false,
}
    // rust: std_types.visit_item_trait(&host_trait);
    // rust: let mut imports = String::new();
    // rust: if std_types.path_buf {
    // rust: imports.push_str("use std::path::PathBuf;\n");
}
    // rust: if std_types.arc {
    // rust: imports.push_str("use std::sync::Arc;\n");
}
    // rust: let host = format!(
    // rust: "// @generated by cargo run -p xtask -- mod-api; do not edit.\nuse super::*;\n{imports}/// Services supplied by the game to trait mods.\n/// Each method's default panics with its name, so a test double implements only what its test calls; the game implements every one.\npub trait Host {{\n{host_traits}}}\n{handles}"
    // rust: );
    // rust: let implementation = format!(
    // rust: "// @generated by cargo run -p xtask -- mod-api; do not edit.\nuse horizon_client::mod_api::*;\n{imports}impl Host for super::Game<'_> {{\n{host_impl}}}\n"
    // rust: );
    // rust: let render_code = format!(
    // rust: "// @generated by cargo run -p xtask -- mod-api; do not edit.\nuse super::*;\npub trait RenderHooks: Send + Sync {{\n{render_traits}}}\n{render_dispatch}"
    // rust: );
    // A new hook's placeholder body becomes its dispatch call.
    // rust: let filled = if fills.is_empty() {
    // rust: None
    // rust: } else if matches!(fill, FillMode::Require) {
    // rust: let natives = fills
    // rust: .iter()
    // rust: .map(|fill| fill.native.as_str())
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: return Err(format!(
    // rust: "{natives}: the let _ = (…); placeholder needs its dispatch call; run cargo run -p xtask -- mod-api"
    // rust: ));
    // rust: } else if matches!(fill, FillMode::Fill) {
    // rust: Some(filled_hooks(&source, &fills)?)
    // rust: } else {
    // rust: None
}
    // rust: for code in [&code, &host, &implementation, &render_code] {
    // rust: syn::parse_file(code).map_err(|e| format!("generated Rust: {e}"))?;
}
    // rust: if let Some(filled) = filled {
    // rust: fs::write(
    // rust: root.join("crates/horizon-client/src/game/native_hooks.rs"),
    // rust: filled,
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
}
    // rust: Ok(Sources {
    // rust: hooks: code,
    // rust: host,
    // rust: implementation,
    // rust: render: render_code,
    // rust: })
}

pub const FillMode = enum {
    Fill,
    Require,
    Ignore,
};

    // rust: mod build;
    // rust: pub use build::{generate, inject};
    // rust: mod injection;
    // rust: pub use injection::{TraitContract, TraitInjection};
    // rust: mod injection_tests;

/// Generate a dispatch fixture without preventing xtask from filling placeholders.
pub fn generate_test_hooks(root: *Path, out_dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: build::track(root)?;
    // rust: let code = sources(root, FillMode::Ignore)?.hooks;
    // rust: fs::write(out_dir.join("mod_api_generated.rs"), code).map_err(|e| e.to_string())
}

    // rust: mod tests {
//     use quote::ToTokens;
//     use serde_json::Value;
pub fn fragment_hooks_generate_and_duplicates_fail() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../..");
    // rust: let catalog: serde_json::Value =
    // rust: serde_json::from_str(&std::fs::read_to_string(root.join("native-hooks.json")).unwrap())
    // rust: .unwrap();
    // rust: let hooks = super::catalog_hooks(&root, &catalog).unwrap();
    // rust: let hook = hooks
    // rust: .iter()
    // rust: .find(|h| h["name"] == "recipes_received")
    // rust: .unwrap();
    // rust: assert_eq!(hook["mod_api"]["contract"], "listen");
    // rust: let generated = super::sources(&root, super::FillMode::Require)
    // rust: .unwrap()
    // rust: .hooks;
    // rust: assert!(generated.contains("fn recipes_received("));

    // rust: let dir = root
    // rust: .join("target")
    // rust: .join(format!("mod-api-fragments-{}", std::process::id()));
    // rust: let fragments = dir.join("tools/native-hook-fragments");
    // rust: std::fs::create_dir_all(&fragments).unwrap();
    // rust: std::fs::write(fragments.join("empty.json"), r#"{"hooks":[]}"#).unwrap();
    // rust: std::fs::write(
    // rust: fragments.join("duplicate.json"),
    // rust: r#"{"hooks":[{"name":"same"}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let catalog = serde_json::json!({"hooks":[{"name":"same"}]});
    // rust: assert_eq!(
    // rust: super::catalog_hooks(&dir, &catalog).unwrap_err(),
    // rust: "duplicate hook same"
    // rust: );
    // rust: std::fs::remove_file(fragments.join("duplicate.json")).unwrap();
    // rust: assert_eq!(super::catalog_hooks(&dir, &catalog).unwrap().len(), 1);
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn public_ref_structs_define_receivers_without_registration() void {
}
    // rust: let types = super::api_types(
    // rust: "pub struct BlockEntityRef; pub struct HTTPRequestRef;
pub const HiddenRef = struct {};
pub const EnumRef = enum {
    // rust: "pub struct GeneratedRef;",
    // rust: )
    // rust: .unwrap();
    for (receiver, ty) in [,
    // rust: ("block_entity", "BlockEntityRef"),
    // rust: ("http_request", "HTTPRequestRef"),
    // rust: ] {
    let name = format!("{receiver}_kind");,
    let method =,
    syn::parse_str(&format!("fn native_{name}(&self, value: {ty}) {{}}")).unwrap();,
    let (handle, code) =,
    super::handle_method(&method, &name, receiver, &types.handles).unwrap();,
    assert_eq!(handle, ty);,
    assert!(code.contains(&format!("host.{name}(self)")));,
};
    // rust: let method = syn::parse_quote! { fn native_hidden_kind(&self, value: HiddenRef) {} };
    // rust: for receiver in [
    // rust: "hidden",
    // rust: "internal",
    // rust: "enum",
    // rust: "alias",
    // rust: "plain",
    // rust: "generated",
    // rust: "missing",
    // rust: ] {
    // rust: assert!(
    // rust: super::handle_method(&method, "hidden_kind", receiver, &types.handles)
    // rust: .unwrap_err()
    // rust: .contains("unknown receiver")
    // rust: );
}
    // rust: assert_eq!(
    // rust: super::api_types("pub struct URLRef; pub struct UrlRef;", "")
    // rust: .err()
    // rust: .unwrap(),
    // rust: "duplicate handle receiver url",
    // rust: );
}

pub fn handle_methods_call_the_host_and_borrow_it_as_the_helper_borrows_game() void {
}
    // rust: let types = super::api_types("pub struct EntityRef; pub struct LevelRef;", "").unwrap();
    // rust: let read: syn::ItemFn = syn::parse_quote! {
            /// Where it is.
pub fn native_entity_position(self: *Self, entity: EntityRef, mut scale: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
}
    // rust: let (handle, code) =
    // rust: super::handle_method(&read, "entity_position", "entity", &types.handles).unwrap();
    // rust: assert_eq!(handle, "EntityRef");
    // rust: assert!(code.starts_with("/// Where it is.\n"));
    // rust: assert!(code.contains("pub fn position (self , host : & dyn Host , scale : f64)"));
    // rust: assert!(code.contains("host.entity_position(self, scale)"));
    // rust: let write: syn::ItemFn = syn::parse_quote! {
pub fn native_level_set(self: *Self, level: LevelRef) void {
}
}
    // rust: let (handle, code) =
    // rust: super::handle_method(&write, "level_set", "level", &types.handles).unwrap();
    // rust: assert_eq!(handle, "LevelRef");
    // rust: assert!(code.contains("host : & mut dyn Host"));
    // rust: for (method, name, receiver, error) in [
    // rust: (
    // rust: syn::parse_quote! { fn native_entity_x(&self, entity: EntityRef) {} },
    // rust: "entity_x",
    // rust: "chunk",
    // rust: "unknown receiver",
    // rust: ),
    // rust: (
    // rust: syn::parse_quote! { fn native_mob_x(&self, entity: EntityRef) {} },
    // rust: "mob_x",
    // rust: "entity",
    // rust: "starts with entity_",
    // rust: ),
    // rust: (
    // rust: syn::parse_quote! { fn native_entity_type(&self, entity: EntityRef) {} },
    // rust: "entity_type",
    // rust: "entity",
    // rust: "not a method name",
    // rust: ),
    // rust: (
    // rust: syn::parse_quote! { fn native_entity_x(entity: EntityRef) {} },
    // rust: "entity_x",
    // rust: "entity",
    // rust: "borrows Game",
    // rust: ),
    // rust: (
    // rust: syn::parse_quote! { fn native_entity_x(&self, level: LevelRef) {} },
    // rust: "entity_x",
    // rust: "entity",
    // rust: "takes a EntityRef first",
    // rust: ),
    // rust: ] {
    // rust: let method: syn::ItemFn = method;
    // rust: assert!(
    // rust: super::handle_method(&method, name, receiver, &types.handles)
    // rust: .unwrap_err()
    // rust: .contains(error),
    // rust: "{name}"
    // rust: );
}
}

pub fn host_mapping_preserves_access_and_docs_and_rejects_unavailable_types() void {
}
    // rust: let exports = super::api_types(
    // rust: "pub use external::{Visible, Original as Renamed}; pub struct Defined; struct Hidden;",
    // rust: "pub struct Generated;",
    // rust: )
    // rust: .unwrap()
    // rust: .exports;
    // rust: for ty in ["Visible", "Renamed", "Defined", "Generated"] {
    // rust: let method: syn::ItemFn =
    // rust: syn::parse_str(&format!("fn native_test(&self, value: {ty}) {{ }}")).unwrap();
    // rust: assert!(super::host_method(&method, "test", &exports).is_ok());
}
    // rust: let foreign: syn::ItemFn =
    // rust: syn::parse_quote! { fn native_foreign(&self, value: elsewhere::Visible) {} };
    // rust: assert!(super::host_method(&foreign, "foreign", &exports).is_err());
    // rust: let hidden_trait: syn::ItemFn =
    // rust: syn::parse_quote! { fn native_hidden(&self, value: &dyn Hidden) {} };
    // rust: assert!(super::host_method(&hidden_trait, "hidden", &exports).is_err());
    // rust: let read: syn::ItemFn = syn::parse_quote! {
            /// Read a value exactly.
            ///
            /// Keep the blank line too.
pub fn native_read(self: *Self, pos: [i32; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
}
    // rust: let (declaration, implementation) = super::host_method(&read, "read", &exports).unwrap();
    // rust: assert!(
    // rust: declaration.contains("/// Read a value exactly.\n///\n/// Keep the blank line too.")
    // rust: );
    // rust: assert!(declaration.contains("& self"));
    // rust: assert!(implementation.contains("self.native_read(pos)"));
    // rust: let dir: syn::ItemFn = syn::parse_quote! { fn native_dir() -> PathBuf { todo!() } };
    // rust: let (declaration, implementation) = super::host_method(&dir, "dir", &exports).unwrap();
    // rust: assert!(declaration.contains("& self"));
    // rust: assert!(implementation.contains("Self::native_dir()"));
    // rust: let owned: syn::ItemFn = syn::parse_quote! { fn native_owned(self) {} };
    // rust: assert!(super::host_method(&owned, "owned", &exports).is_err());
    // rust: let write: syn::ItemFn = syn::parse_quote! {
pub fn native_write(self: *Self, value: i32) void {
}
}
    // rust: let (declaration, _) = super::host_method(&write, "write", &exports).unwrap();
    // rust: assert!(declaration.contains("& mut self"));
    // rust: let private: syn::ItemFn = syn::parse_quote! {
pub fn native_private(self: *Self, value: BinOnly) void {
}
}
    // rust: assert!(
    // rust: super::host_method(&private, "private", &exports)
    // rust: .unwrap_err()
    // rust: .contains("BinOnly")
    // rust: );
    // rust: let generic: syn::ItemFn = syn::parse_quote! {
    // rust: fn native_generic<T>(&self, value: T) { }
}
    // rust: assert!(
    // rust: super::host_method(&generic, "generic", &exports)
    // rust: .unwrap_err()
    // rust: .contains("object-safe")
    // rust: );
    // rust: let callback: syn::ItemFn = syn::parse_quote! {
pub fn native_callback(self: *Self, callback: impl FnOnce() void {
}
}
    // rust: assert!(
    // rust: super::host_method(&callback, "callback", &exports)
    // rust: .unwrap_err()
    // rust: .contains("object-safe")
    // rust: );
    // rust: let asynchronous: syn::ItemFn = syn::parse_quote! {
pub fn native_async(self: *Self) void {
}
}
    // rust: assert!(
    // rust: super::host_method(&asynchronous, "async", &exports)
    // rust: .unwrap_err()
    // rust: .contains("object-safe")
    // rust: );
}

pub fn helper_target_can_differ_from_its_name_and_share_a_hook_name() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../target")
    // rust: .join(format!("mod-api-helper-target-{}", std::process::id()));
    // rust: let fragments = root.join("tools/native-hook-fragments");
    // rust: std::fs::create_dir_all(fragments).unwrap();
    // rust: for (path, source) in [
    // rust: ("crates/horizon-client/src/mod_api.rs", ""),
    // rust: (
    // rust: "crates/horizon-client/src/game/native_hooks.rs",
    // rust: "impl Game<'_> {
pub fn native_block_entity(self: *Self, id: u32) void {
}
    // rust: mod_api::dispatch_block_entity(self, mod_api::mods(), id);
}
pub fn native_block_entity_ref(self: *Self, id: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: }",
    // rust: ),
    // rust: ] {
    // rust: let path = root.join(path);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, source).unwrap();
}
    // rust: let catalog = serde_json::json!({
    // rust: "hooks": [{
    // rust: "name": "block_entity",
    // rust: "target": "horizon_client::game::native_hooks::Game<'_>::native_block_entity",
    // rust: "mod_api": {"contract": "listen"}
    // rust: }],
    // rust: "helpers": [{
    // rust: "name": "block_entity",
    // rust: "target": "horizon_client::game::native_hooks::Game<'_>::native_block_entity_ref"
    // rust: }]
    // rust: });
    // rust: std::fs::write(root.join("native-hooks.json"), catalog.to_string()).unwrap();
    // rust: let generated = super::sources(&root, super::FillMode::Require).unwrap();
    // rust: let implementation = syn::parse_file(&generated.implementation).unwrap();
pub const Calls = struct {};
    // rust: impl<'ast> syn::visit::Visit<'ast> for Calls {
pub fn visit_expr_method_call(self: *Self, call: *'ast syn::ExprMethodCall) void {
}
    // rust: self.0.push(call.method.to_string());
    // rust: syn::visit::visit_expr_method_call(self, call);
}
}
    // rust: let mut calls = Calls::default();
    // rust: syn::visit::Visit::visit_file(&mut calls, &implementation);
    // rust: assert_eq!(calls.0, ["native_block_entity_ref"]);
    // rust: std::fs::remove_dir_all(root).unwrap();
}

pub fn lookup_rejects_missing_and_duplicate_functions() void {
}
    // rust: let first: syn::ItemFn = syn::parse_quote! { fn native_example() {} };
    // rust: let other: syn::ItemFn = syn::parse_quote! { fn unrelated() {} };
    // rust: assert!(super::one_function([&other].into_iter(), "native_example").is_err());
    // rust: assert!(super::one_function([&first, &other].into_iter(), "native_example").is_ok());
    // rust: assert!(super::one_function([&first, &first].into_iter(), "native_example").is_err());
}

pub fn generated_locals_do_not_shadow_hook_arguments() void {
}
    // rust: let mut used = ["mods", "mods_", "mod_hook", "replacement", "host"]
    // rust: .into_iter()
    // rust: .map(str::to_owned)
    // rust: .collect();
    // rust: assert_eq!(super::fresh_name("mods", &mut used), "mods__");
    // rust: assert_eq!(super::fresh_name("mod_hook", &mut used), "mod_hook_");
    // rust: assert_eq!(super::fresh_name("replacement", &mut used), "replacement_");
    // rust: assert_eq!(super::fresh_name("host", &mut used), "host_");
}

pub fn level_hosts_match_receiver_mutability() void {
}
    // rust: assert_eq!(
    // rust: super::host_for(true, Some(false), false),
    // rust: Some(("level", "&dyn LevelHost".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: super::host_for(true, Some(true), false),
    // rust: Some(("level", "&mut dyn LevelRandomHost".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: super::host_for(true, Some(false), true),
    // rust: Some(("level", "&mut dyn LevelTicksHost".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: super::host_for(true, Some(true), true),
    // rust: Some(("level", "&mut dyn LevelWriteHost".into()))
    // rust: );
    // rust: assert_eq!(super::host_for(true, None, false), None);
    // rust: assert_eq!(
    // rust: super::host_for(false, Some(true), false),
    // rust: Some(("host", "&mut dyn Host".into()))
    // rust: );
}

pub fn only_a_game_hooks_placeholder_body_is_filled() void {
}
    // rust: let fill = |body: &str, in_game: bool| {
    // rust: let method: syn::ItemFn = syn::parse_str(&format!(
    // rust: "fn native_h(&mut self, player: u128, cancel: &mut bool) {{ {body} }}"
    // rust: ))
    // rust: .unwrap();
    // rust: super::needs_fill(&method, "dispatch_h", in_game)
}
    // rust: assert_eq!(fill("let _ = (player, cancel);", true), Ok(true));
    // rust: assert_eq!(
    // rust: fill(
    // rust: "horizon_client::mod_api::dispatch_h(self, mods(), player, cancel);",
    // rust: true
    // rust: ),
    // rust: Ok(false)
    // rust: );
    // rust: for (body, in_game) in [
    // rust: ("let _ = (player, cancel);", false),
    // rust: ("let _ = (cancel, player);", true),
    // rust: ("let _ = player;", true),
    // rust: ("let _ = (player, cancel); *cancel = true;", true),
    // rust: ("", true),
    // rust: ] {
    // rust: assert!(
    // rust: fill(body, in_game)
    // rust: .unwrap_err()
    // rust: .starts_with("missing dispatch_h call in native_h: "),
    // rust: "{body}"
    // rust: );
}
    // rust: let one: syn::ItemFn =
    // rust: syn::parse_quote! { fn native_one(&self, from: &str) { let _ = from; } };
    // rust: assert_eq!(super::needs_fill(&one, "dispatch_one", true), Ok(true));
    // rust: let source = "impl Game<'_> {\n    fn native_other(&self, a: u32) {\n        let _ = a;\n    }\n    fn native_h(&mut self, player: u128, name: &str, cancel: &mut bool) {\n        let _ = (player, name, cancel);\n    }\n}\n";
    // rust: let filled = super::filled_hooks(
    // rust: source,
    // rust: &[super::Fill {
    // rust: native: "native_h".into(),
    // rust: call: "mod_api::dispatch_h(self, mod_api::mods(), player, name, cancel);".into(),
    // rust: }],
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: String::from_utf8(filled).unwrap(),
    // rust: "impl Game<'_> {\n    fn native_other(&self, a: u32) {\n        let _ = a;\n    }\n    fn native_h(&mut self, player: u128, name: &str, cancel: &mut bool) {\n        mod_api::dispatch_h(self, mod_api::mods(), player, name, cancel);\n    }\n}\n"
    // rust: );
}

    /// `item_damaged` taken back to how a new hook arrives (its body the
    /// placeholder) in a copy of the sources: the check reports it, any other
    /// body is left alone, a missing `mod_api` entry fails by name, and the
    /// generator brings back the shipped file byte for byte with the generated
    /// code unchanged.
pub fn new_hook_placeholder_is_reported_then_filled() void {
}
pub fn copy(from: *std::path::Path, to: *std::path::Path) void {
}
    // rust: if from.is_dir() {
    // rust: for entry in std::fs::read_dir(from).unwrap() {
    // rust: let entry = entry.unwrap();
    // rust: copy(&entry.path(), &to.join(entry.file_name()));
}
    // rust: } else {
    // rust: std::fs::create_dir_all(to.parent().unwrap()).unwrap();
    // rust: std::fs::copy(from, to).unwrap();
}
}
    // rust: let real = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../..");
    // rust: let root = real
    // rust: .join("target")
    // rust: .join(format!("mod-api-fill-{}", std::process::id()));
    // rust: let catalog: Value =
    // rust: serde_json::from_str(&std::fs::read_to_string(real.join("native-hooks.json")).unwrap())
    // rust: .unwrap();
    // rust: let mut inputs: Vec<String> = [
    // rust: "native-hooks.json",
    // rust: "tools/native-hook-fragments",
    // rust: "crates/horizon-client/src/game",
    // rust: "crates/horizon-client/src/mod_api.rs",
    // rust: ]
    // rust: .map(str::to_owned)
    // rust: .into();
    // rust: for hook in super::catalog_hooks(&real, &catalog).unwrap() {
    // rust: if let Some((krate, path)) =
    // rust: super::free_function_source(hook["target"].as_str().unwrap())
    // rust: {
    // rust: let (module, _) = path.rsplit_once("::").unwrap();
    // rust: inputs.push(format!(
    // rust: "crates/{krate}/src/{}.rs",
    // rust: module.replace("::", "/")
    // rust: ));
}
}
    // rust: for input in &inputs {
    // rust: copy(&real.join(input), &root.join(input));
}
    // rust: let hooks = root.join("crates/horizon-client/src/game/native_hooks.rs");
    // rust: let shipped = std::fs::read_to_string(&hooks).unwrap();
    // rust: let call = "mod_api::dispatch_item_damaged(self, mod_api::mods(), player, name, item, amount, cancel);";
    // rust: assert_eq!(shipped.matches(call).count(), 1);
    // rust: let unfinished = shipped.replace(call, "let _ = (player, name, item, amount);");
    // rust: std::fs::write(&hooks, &unfinished).unwrap();
    // rust: assert!(
    // rust: super::fill_hooks(&root)
    // rust: .unwrap_err()
    // rust: .starts_with("missing dispatch_item_damaged call in native_item_damaged: ")
    // rust: );
    // rust: assert_eq!(std::fs::read_to_string(&hooks).unwrap(), unfinished);
    // rust: let placeholder = shipped.replace(call, "let _ = (player, name, item, amount, cancel);");
    // rust: std::fs::write(&hooks, &placeholder).unwrap();
    // rust: assert_eq!(
    // rust: super::sources(&root, super::FillMode::Require).unwrap_err(),
    // rust: "native_item_damaged: the let _ = (…); placeholder needs its dispatch call; run cargo run -p xtask -- mod-api"
    // rust: );
    // rust: assert_eq!(std::fs::read_to_string(&hooks).unwrap(), placeholder);
        // A stamped hook lives in the catalog, not in a fragment.
    // rust: let catalog_path = root.join("native-hooks.json");
    // rust: let shipped_catalog = std::fs::read_to_string(&catalog_path).unwrap();
    // rust: let mut json: Value = serde_json::from_str(&shipped_catalog).unwrap();
    // rust: let hook = json["hooks"]
    // rust: .as_array_mut()
    // rust: .unwrap()
    // rust: .iter_mut()
    // rust: .find(|hook| hook["name"] == "item_damaged")
    // rust: .unwrap();
    // rust: hook.as_object_mut().unwrap().remove("mod_api").unwrap();
    // rust: std::fs::write(&catalog_path, json.to_string()).unwrap();
    // rust: assert_eq!(
    // rust: super::fill_hooks(&root).unwrap_err(),
    // rust: "hook item_damaged has no mod_api entry: add one"
    // rust: );
    // rust: std::fs::write(&catalog_path, shipped_catalog).unwrap();
    // rust: super::fill_hooks(&root).unwrap();
        // The generator writes LF; a Windows checkout (core.autocrlf) has CRLF.
    // rust: let lf = |s: &str| s.replace("\r\n", "\n");
    // rust: assert_eq!(lf(&std::fs::read_to_string(&hooks).unwrap()), lf(&shipped));
    // rust: assert_eq!(
    // rust: super::sources(&root, super::FillMode::Require)
    // rust: .unwrap()
    // rust: .hooks,
    // rust: super::sources(&real, super::FillMode::Require)
    // rust: .unwrap()
    // rust: .hooks,
    // rust: );
    // rust: super::sources(&root, super::FillMode::Require).unwrap();
    // rust: std::fs::remove_dir_all(root).unwrap();
}

pub fn event_fields_name_their_lifetimes() void {
}
    // rust: for (ty, field, scalar, a, b) in [
    // rust: (
    // rust: "& mut WorldDrawn < '_ >",
    // rust: "& 'a mut WorldDrawn < 'b >",
    // rust: false,
    // rust: true,
    // rust: true,
    // rust: ),
    // rust: ("& str", "& 'a str", false, true, false),
    // rust: (
    // rust: "& mut Vec < (& 'static str , u32) >",
    // rust: "& 'a mut Vec < (& 'static str , u32) >",
    // rust: false,
    // rust: true,
    // rust: false,
    // rust: ),
    // rust: (
    // rust: "Option < & ItemStack >",
    // rust: "Option < & 'a ItemStack >",
    // rust: false,
    // rust: true,
    // rust: false,
    // rust: ),
    // rust: ("u32", "u32", false, false, false),
    // rust: ("& mut f32", "f32", true, false, false),
    // rust: (
    // rust: "& mut Option < bool >",
    // rust: "& 'a mut Option < bool >",
    // rust: false,
    // rust: true,
    // rust: false,
    // rust: ),
    // rust: ] {
    // rust: let mut lifetimes = super::EventLifetimes::default();
    // rust: let (field_type, is_scalar) = lifetimes.field(&syn::parse_str(ty).unwrap());
    // rust: assert_eq!(field_type.to_token_stream().to_string(), field);
    // rust: assert_eq!((is_scalar, lifetimes.a, lifetimes.b), (scalar, a, b));
}
}

pub fn library_crate_targets_resolve_to_their_source() void {
}
    // rust: for target in [
    // rust: "horizon_client_lib::menu::native_menu_slot_rules",
    // rust: "horizon_client::menu::native_menu_slot_rules",
    // rust: ] {
    // rust: assert_eq!(
    // rust: super::free_function_source(target),
    // rust: Some(("horizon-client", "menu::native_menu_slot_rules".to_owned()))
    // rust: );
}
    // rust: assert_eq!(
    // rust: super::free_function_source("horizon_client_lib::crafting::native_ingredient"),
    // rust: Some(("horizon-client", "crafting::native_ingredient".to_owned()))
    // rust: );
    // rust: assert_eq!(
    // rust: super::free_function_source(
    // rust: "horizon_client::game::native_hooks::Game<'_>::native_zoom"
    // rust: ),
    // rust: None
    // rust: );
}

pub fn contracted_hook_requires_dispatch_call() void {
}
    // rust: let missing: syn::ImplItemFn = syn::parse_quote! { fn native_zoom(&self) { unrelated(); } };
    // rust: let present: syn::ImplItemFn = syn::parse_quote! { fn native_zoom(&self) { horizon_client::mod_api::dispatch_zoom(); } };
    // rust: assert!(!super::has_call(&missing.block, "dispatch_zoom"));
    // rust: assert!(super::has_call(&present.block, "dispatch_zoom"));
}
}
