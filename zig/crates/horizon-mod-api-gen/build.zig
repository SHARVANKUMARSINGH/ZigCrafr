//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-api-gen_build
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Cargo-facing generation and the launcher's trait injection boundary.
// use super::{Target, catalog_hooks, free_function_source, sources};
// use quote::ToTokens;
// use std::{collections::HashSet, fs, path::Path};

/// Generate only this crate's files, tracking every source read by the generator.
/// `root` is supplied at run time by the consuming crate's build script.
pub fn generate(root: *Path, out_dir: *Path, target: Target) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: track(root)?;
    // rust: let generated = sources(root, super::FillMode::Require)?;
    // rust: let outputs = match target {
    // rust: Target::Render => vec![("native_render_generated.rs", generated.render)],
    // rust: Target::Client => {
    // rust: println!("cargo:rerun-if-env-changed=HORIZON_MOD_API_INJECTIONS");
    // rust: let hooks = if let Some(path) = std::env::var_os("HORIZON_MOD_API_INJECTIONS") {
    // rust: let path = Path::new(&path);
    // rust: println!("cargo:rerun-if-changed={}", path.display());
    // rust: let injections =
    // rust: fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: inject(&generated.hooks, &injections)?
    // rust: } else {
    // rust: generated.hooks
}
    // rust: vec![
    // rust: ("mod_api_generated.rs", hooks),
    // rust: ("mod_api_generated_host.rs", generated.host),
    // rust: ("mod_api_host_generated.rs", generated.implementation),
    // rust: ]
}
}
    // rust: for (name, code) in outputs {
    // rust: syn::parse_file(&code).map_err(|e| format!("generated Rust: {e}"))?;
    // rust: fs::write(out_dir.join(name), code).map_err(|e| e.to_string())?;
}
    // rust: Ok(())
}

    // rust: pub(super) fn track(root: &Path) -> Result<(), String> {
pub fn directory(path: *Path, extension: []const u8, recursive: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Track the directory as well: adding a helper source or fragment changes the inputs.
    // rust: println!("cargo:rerun-if-changed={}", path.display());
    // rust: for entry in fs::read_dir(path).map_err(|e| e.to_string())? {
    // rust: let path = entry.map_err(|e| e.to_string())?.path();
    // rust: if path.is_dir() && recursive {
    // rust: directory(&path, extension, recursive)?;
    // rust: } else if path.extension().is_some_and(|ext| ext == extension) {
    // rust: println!("cargo:rerun-if-changed={}", path.display());
}
}
    // rust: Ok(())
}
    // rust: for path in ["native-hooks.json", "crates/horizon-client/src/mod_api.rs"] {
    // rust: println!("cargo:rerun-if-changed={}", root.join(path).display());
}
    // rust: directory(&root.join("tools/native-hook-fragments"), "json", false)?;
    // rust: directory(&root.join("crates/horizon-client/src/game"), "rs", true)?;
    // rust: let catalog = serde_json::from_str(
    // rust: &fs::read_to_string(root.join("native-hooks.json")).map_err(|e| e.to_string())?,
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
    // rust: for hook in catalog_hooks(root, &catalog)? {
    // rust: if let Some((krate, path)) =
    // rust: free_function_source(hook["target"].as_str().ok_or("target missing")?)
    // rust: {
    // rust: let (module, _) = path.rsplit_once("::").ok_or("target missing module")?;
    // rust: let path = root
    // rust: .join("crates")
    // rust: .join(krate)
    // rust: .join("src")
    // rust: .join(format!("{}.rs", module.replace("::", "/")));
    // rust: println!("cargo:rerun-if-changed={}", path.display());
}
}
    // rust: Ok(())
}

pub const Injection = struct {
    name: []const u8,
    event: []const u8,
    declaration: []const u8,
    event_declaration: []const u8,
};

/// Add the launcher's trait methods and event structs to the generated catalog API.
/// The JSON file is the boundary: parse declarations once, then work with typed Rust items.
pub fn inject(code: []const u8, injections: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let injections: Vec<Injection> =
    // rust: serde_json::from_str(injections).map_err(|e| format!("trait injections: {e}"))?;
    // rust: if injections.is_empty() {
    // rust: return Ok(code.to_owned());
}
    // rust: let mut file = syn::parse_file(code).map_err(|e| format!("generated API: {e}"))?;
    // rust: let mut events: HashSet<String> = file
    // rust: .items
    // rust: .iter()
    // rust: .filter_map(|item| match item {
    // rust: syn::Item::Struct(item) => Some(item.ident.to_string()),
    // rust: syn::Item::Trait(item) => Some(item.ident.to_string()),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let hooks = file
    // rust: .items
    // rust: .iter_mut()
    // rust: .find_map(|item| match item {
    // rust: syn::Item::Trait(item) if item.ident == "Hooks" => Some(item),
    // rust: _ => None,
    // rust: })
    // rust: .ok_or("generated API missing Hooks trait")?;
    // rust: let mut methods: HashSet<_> = hooks
    // rust: .items
    // rust: .iter()
    // rust: .filter_map(|item| match item {
    // rust: syn::TraitItem::Fn(method) => Some(method.sig.ident.to_string()),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let mut structs = Vec::new();
    // rust: for injection in injections {
    // rust: let method: syn::TraitItemFn = syn::parse_str(&injection.declaration)
    // rust: .map_err(|e| format!("trait injection {}: {e}", injection.name))?;
    // rust: let event: syn::ItemStruct = syn::parse_str(&injection.event_declaration)
    // rust: .map_err(|e| format!("trait injection {}: {e}", injection.event))?;
    // rust: if method.sig.ident != injection.name || event.ident != injection.event {
    // rust: return Err("trait injection declaration does not match its name".into());
}
    // rust: if !methods.insert(injection.name.clone()) {
    // rust: return Err(format!(
    // rust: "duplicate generated trait method {}",
    // rust: injection.name
    // rust: ));
}
    // rust: if !events.insert(injection.event.clone()) {
    // rust: return Err(format!("duplicate generated event {}", injection.event));
}
    // rust: hooks.items.push(syn::TraitItem::Fn(method));
    // rust: structs.push(syn::Item::Struct(event));
}
    // rust: file.items.extend(structs);
    // rust: Ok(file.into_token_stream().to_string())
}
