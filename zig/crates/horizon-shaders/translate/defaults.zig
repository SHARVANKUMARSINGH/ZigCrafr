//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_defaults
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Let the GLSL compiler evaluate authored constants, then lay them out as the actual UBO.

// use std::collections::BTreeMap;

// use naga::{Expression, Handle, Literal, Module, TypeInner};

// use super::{Error, scan::Stage};

    // rust: pub(super) fn merge<'a>(
    // rust: stages: impl IntoIterator<Item = (&'a Stage<'a>, &'a Module)>,
    // rust: ) -> Result<(Vec<u8>, Vec<Error>), Vec<Error>> {
    // rust: let mut notes = Vec::new();
    // rust: let mut result = Vec::new();
    // rust: let mut seen = BTreeMap::<String, Vec<u8>>::new();
    // rust: for (stage, module) in stages {
    // rust: let (span, _) = super::block_layout(module);
    // rust: result.resize(span as usize, 0);
    // rust: let members = module.global_variables.iter().find_map(|(_, var)| {
    // rust: if var.space == naga::AddressSpace::Uniform
    // rust: && var
    // rust: .binding
    // rust: .as_ref()
    // rust: .is_some_and(|b| b.group == 0 && b.binding == 0)
    // rust: && let TypeInner::Struct { members, .. } = &module.types[var.ty].inner
    // rust: {
    // rust: Some(members)
    // rust: } else {
    // rust: None
}
    // rust: });
    // rust: let Some(members) = members else { continue };
    // rust: for (name, at) in &stage.defaults {
    // rust: let Some(member) = members.iter().find(|m| {
    // rust: m.name.as_deref() == Some(name.as_str())
    // rust: || m.name.as_deref() == Some(format!("hz_bool_{name}").as_str())
    // rust: }) else {
                // An engine-owned per-draw member was moved to its own block.
    // rust: continue;
}
    // rust: let constant_name = format!("hz_default_{name}");
    // rust: let constant = module.constants.iter().find_map(|(_, c)| {
    // rust: (c.name.as_deref() == Some(constant_name.as_str())).then_some(c)
    // rust: });
            // Store into scratch bytes: an unsupported aggregate must not leave a
            // partially initialized uniform in the program's initial contents.
    // rust: let mut bytes = vec![0; span as usize];
    // rust: let stored = constant.and_then(|constant| {
    // rust: let mut words = Vec::new();
    // rust: flatten(module, constant.init, &mut words)?;
    // rust: let mut words = words.into_iter();
    // rust: write(
    // rust: module,
    // rust: &module.types[member.ty].inner,
    // rust: &mut words,
    // rust: &mut bytes,
    // rust: member.offset as usize,
    // rust: )?;
    // rust: words.next().is_none().then_some(())
    // rust: });
    // rust: if stored.is_none() {
    // rust: notes.push(stage.error(
    // rust: *at,
    // rust: &format!("`{name}` has an unsupported constant initializer; using zero"),
    // rust: ));
    // rust: continue;
}
    // rust: if let Some(previous) = seen.get(name) {
    // rust: if previous != &bytes {
    // rust: return Err(vec![stage.error(
    // rust: *at,
    // rust: &format!("`{name}` has conflicting initial values across stages"),
    // rust: )]);
}
    // rust: } else {
    // rust: for (dst, value) in result.iter_mut().zip(&bytes) {
    // rust: *dst |= value;
}
    // rust: seen.insert(name.clone(), bytes);
}
}
}
    // rust: Ok((result, notes))
}

pub fn flatten(module: *Module, value: Handle<Expression>, out: *mut std.ArrayList([u8; 4])) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &module.global_expressions[value] {
    // rust: Expression::Literal(literal) => out.push(match *literal {
    // rust: Literal::F32(v) => v.to_le_bytes(),
    // rust: Literal::I32(v) => v.to_le_bytes(),
    // rust: Literal::U32(v) => v.to_le_bytes(),
    // rust: Literal::Bool(v) => u32::from(v).to_le_bytes(),
    // rust: _ => return None,
    // rust: }),
    // rust: Expression::Constant(c) => flatten(module, module.constants[*c].init, out)?,
    // rust: Expression::Compose { components, .. } => {
    // rust: for &component in components {
    // rust: flatten(module, component, out)?;
}
}
    // rust: Expression::Splat { size, value } => {
    // rust: for _ in 0..*size as usize {
    // rust: flatten(module, *value, out)?;
}
}
    // rust: Expression::ZeroValue(ty) => zeros(module, &module.types[*ty].inner, out)?,
    // rust: _ => return None,
}
    // rust: Some(())
}

pub fn zeros(module: *Module, ty: *TypeInner, out: *mut std.ArrayList([u8; 4])) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ty {
    // rust: TypeInner::Scalar(_) => out.push([0; 4]),
    // rust: TypeInner::Vector { size, .. } => out.extend(vec![[0; 4]; *size as usize]),
    // rust: TypeInner::Matrix { columns, rows, .. } => {
    // rust: out.extend(vec![[0; 4]; *columns as usize * *rows as usize])
}
    // rust: TypeInner::Array {
    // rust: base,
    // rust: size: naga::ArraySize::Constant(n),
    // rust: ..
    // rust: } => {
    // rust: for _ in 0..n.get() {
    // rust: zeros(module, &module.types[*base].inner, out)?;
}
}
    // rust: _ => return None,
}
    // rust: Some(())
}

    // rust: fn write(
    // rust: module: &Module,
    // rust: ty: &TypeInner,
    // rust: words: &mut impl Iterator<Item = [u8; 4]>,
    // rust: bytes: &mut [u8],
    // rust: offset: usize,
    // rust: ) -> Option<()> {
    // rust: match ty {
    // rust: TypeInner::Scalar(naga::Scalar { width: 4, .. }) => bytes
    // rust: .get_mut(offset..offset + 4)?
    // rust: .copy_from_slice(&words.next()?),
    // rust: TypeInner::Vector { size, scalar } => {
    // rust: for i in 0..*size as usize {
    // rust: write(
    // rust: module,
    // rust: &TypeInner::Scalar(*scalar),
    // rust: words,
    // rust: bytes,
    // rust: offset + i * 4,
    // rust: )?;
}
}
    // rust: TypeInner::Matrix {
    // rust: columns,
    // rust: rows,
    // rust: scalar,
    // rust: } => {
            // The frontend rejects two-row std140 matrices; supported columns use 16 bytes.
    // rust: let stride = 16;
    // rust: for column in 0..*columns as usize {
    // rust: write(
    // rust: module,
    // rust: &TypeInner::Vector {
    // rust: size: *rows,
    // rust: scalar: *scalar,
    // rust: },
    // rust: words,
    // rust: bytes,
    // rust: offset + column * stride,
    // rust: )?;
}
}
    // rust: TypeInner::Array {
    // rust: base,
    // rust: size: naga::ArraySize::Constant(n),
    // rust: stride,
    // rust: } => {
    // rust: for i in 0..n.get() as usize {
    // rust: write(
    // rust: module,
    // rust: &module.types[*base].inner,
    // rust: words,
    // rust: bytes,
    // rust: offset + i * *stride as usize,
    // rust: )?;
}
}
    // rust: _ => return None,
}
    // rust: Some(())
}
