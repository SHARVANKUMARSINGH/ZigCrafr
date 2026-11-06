//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-api-gen_injection
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Generation of a mod's own trait methods, events and dispatch helpers.
// use super::EventLifetimes;
// use quote::{format_ident, quote};
// use syn::visit_mut::VisitMut;

/// A trait declaration supplied to the staged game's build script after horizon-mixins has run.
pub const TraitInjection = struct {
    name: syn::Ident,
    /// The bindings' struct, as each catalog hook's (`InjectExampleTickEvent`).
    event: syn::Ident,
    parameters: Vec<(syn::Ident,
    contract: TraitContract,
};

/// What a trait method may do with its event.
pub const TraitContract = enum {
    /// HEAD: observe and change `&mut` bindings.
    Listen,
    /// Cancellable HEAD on a unit target, where `Flow::Cancel` returns early.
    Cancel,
    /// RETURN, MODIFY_ARG or MODIFY_EXPRESSION_VALUE: the ident names the `$value` binding,
    /// which is moved into the event and returned after the call.
    Value(syn::Ident),
};

pub const EventFields = struct {
    lifetimes: EventLifetimes,
    types: std.ArrayList(syn::Type),
    scalars: std.ArrayList(bool),
};

    // rust: impl TraitInjection {
    /// Prepare a mod-owned trait method from parsed bindings and its return contract.
    // rust: pub fn new(
    // rust: name: syn::Ident,
    // rust: parameters: Vec<(syn::Ident, syn::Type)>,
    // rust: contract: TraitContract,
    // rust: ) -> Self {
    // rust: let event = format_ident!(
    // rust: "{}Event",
    // rust: name.to_string()
    // rust: .split('_')
    // rust: .map(|word| {
    // rust: let mut chars = word.chars();
    // rust: chars.next().map_or(String::new(), |first| {
    // rust: first.to_uppercase().chain(chars).collect()
    // rust: })
    // rust: })
    // rust: .collect::<String>()
    // rust: );
    // rust: Self {
    // rust: name,
    // rust: event,
    // rust: parameters,
    // rust: contract,
}
}

    /// The declarations supplied to the staged game's build script.
pub fn input(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::json!({
    // rust: "name": self.name.to_string(),
    // rust: "event": self.event.to_string(),
    // rust: "declaration": self.declaration(),
    // rust: "event_declaration": self.event(),
    // rust: })
}

    /// Dispatch only to this injection’s owning mod, preserving its write-back contract.
pub fn helper(self: *Self, owner: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &self.name;
    // rust: let event = &self.event;
    // rust: let params = self.parameters.iter().map(|(n, t)| quote!(#n: #t));
    // rust: let scalars = self.fields().scalars;
    // rust: let inits = self
    // rust: .parameters
    // rust: .iter()
    // rust: .zip(&scalars)
    // rust: .map(
    // rust: |((n, _), scalar)| {
    // rust: if *scalar { quote!(#n: *#n) } else { quote!(#n) }
    // rust: },
    // rust: );
    // rust: let write_back = self
    // rust: .parameters
    // rust: .iter()
    // rust: .zip(&scalars)
    // rust: .filter(|(_, scalar)| **scalar)
    // rust: .map(|((n, _), _)| quote!(*#n = event.#n;));
    // rust: let call = quote! {
    // rust: let mut event = crate::mod_api::#event { #(#inits),* };
    // rust: let _flow = owner.#name(&mut event);
    // rust: #(#write_back)*
}
        // Before the mods are installed (an injection into code `main_with` runs first), or
        // with fewer mods than the build had, the injection does nothing or passes the value on.
    // rust: let (output, result, absent) = match &self.contract {
    // rust: TraitContract::Listen => (quote!(), call, quote!()),
    // rust: TraitContract::Cancel => (
    // rust: quote!(-> core::ops::ControlFlow<()>),
    // rust: quote! {
    // rust: #call
    // rust: if _flow == crate::mod_api::Flow::Cancel {
    // rust: return core::ops::ControlFlow::Break(());
}
    // rust: core::ops::ControlFlow::Continue(())
    // rust: },
    // rust: quote!(core::ops::ControlFlow::Continue(())),
    // rust: ),
    // rust: TraitContract::Value(value) => {
    // rust: let ty = self
    // rust: .parameters
    // rust: .iter()
    // rust: .find(|(n, _)| n == value)
    // rust: .map(|(_, t)| t);
    // rust: (quote!(-> #ty), quote!(#call event.#value), quote!(#value))
}
}
    // rust: quote! {
pub fn horizon_trait_dispatch() void {
}
    // rust: let Some(owner) = crate::mod_api::mods().get(#owner) else {
    // rust: return #absent;
}
    // rust: #result
}
}
    // rust: .to_string()
}

pub fn declaration(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &self.name;
    // rust: let event = &self.event;
    // rust: let (output, default) = match self.contract {
    // rust: TraitContract::Cancel => (quote!(-> Flow), quote!(Flow::Continue)),
    // rust: TraitContract::Listen | TraitContract::Value(_) => (quote!(), quote!()),
}
    // rust: let lifetimes = self.fields().lifetimes;
    // rust: let elided = match (lifetimes.a, lifetimes.b) {
    // rust: (_, true) => quote!(<'_, '_>),
    // rust: (true, false) => quote!(<'_>),
    // rust: (false, false) => quote!(),
}
    // rust: quote!(fn #name(&self, _: &mut #event #elided) #output { #default }).to_string()
}

    /// Which lifetimes the event takes, its fields' types and which of them are scalars.
pub fn fields(self: *Self) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lifetimes = EventLifetimes::default();
    // rust: let (types, scalars) = self
    // rust: .parameters
    // rust: .iter()
    // rust: .map(|(name, ty)| match &self.contract {
    // rust: TraitContract::Value(value) if name == value => {
    // rust: let mut field = ty.clone();
    // rust: lifetimes.visit_type_mut(&mut field);
    // rust: (field, false)
}
    // rust: _ => lifetimes.field(ty),
    // rust: })
    // rust: .unzip();
    // rust: EventFields {
    // rust: lifetimes,
    // rust: types,
    // rust: scalars,
}
}

pub fn event(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let event = &self.event;
    // rust: let name = self.name.to_string();
    // rust: let fields = self.fields();
    // rust: let lifetimes = fields.lifetimes;
    // rust: let types = fields.types;
    // rust: let generics = match (lifetimes.a, lifetimes.b) {
    // rust: (_, true) => quote!(<'a, 'b>),
    // rust: (true, false) => quote!(<'a>),
    // rust: (false, false) => quote!(),
}
    // rust: let names = self.parameters.iter().map(|(n, _)| n);
    // rust: let doc = format!(
    // rust: " What [`Hooks::{name}`] is told. Fields may be added: the struct is `#[non_exhaustive]`."
    // rust: );
    // rust: quote! {
    // rust: pub struct #event #generics { #(pub #names: #types),* }
}
    // rust: .to_string()
}
}
