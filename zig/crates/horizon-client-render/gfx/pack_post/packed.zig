//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_packed
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The small packed colortex formats `RGB5_A1`, `RGB565` and `R3_G3_B2`, read back as in Iris
//! 1.11.7. wgpu has no such formats, so these buffers are 8-bit (`texture_format`); what a pass
//! writes into one and its clear colour go through [`quantise`] first.
//!
//! Probe pack p8106c of our own wrote 600 values to each format and read them back with
//! `texelFetch` in Iris 1.11.7 (NVIDIA 615.78.08). Our probe's Iris values fit this, with no
//! exception: each channel becomes the byte an `RGBA8` buffer stores for it, keeps that byte's
//! top bits (5, 5, 5 and 1 for `RGB5_A1`; 5, 6 and 5 for `RGB565` and also for `R3_G3_B2`), and
//! reads back those bits repeated to fill 8 (`0.3337` → byte 85 → 10 of 31 → 82 / 255). This is
//! a fit to one driver's values, not a rule Iris states. `RGBA4` and `RGBA2` read back the `RGBA8`
//! bytes in the same probe, as Horizon's 8-bit buffers already do.

// use horizon_shaders::{Format, Kind};
// use naga::{BinaryOperator, Expression, Literal, MathFunction, Statement, VectorSize};

/// The bits each channel keeps in a buffer of format `f`, for the formats that keep fewer than
/// 8; a three-channel format's alpha keeps 8 (it reads 1 anyway).
    // rust: pub(super) fn bits(f: Format) -> Option<[u8; 4]> {
    // rust: match (f.kind, f.channels, f.bits) {
    // rust: (Kind::Unorm, 4, 5) => Some([5, 5, 5, 1]),
        // `RGB565`, and `R3_G3_B2` (3 × 3 bits in `config.rs`), which our probe's Iris values
        // put in 5, 6 and 5 bits too.
    // rust: (Kind::Unorm, 3, 6 | 3) => Some([5, 6, 5, 8]),
    // rust: _ => None,
}
}

/// The value a buffer keeping `bits` per channel reads back after `v` is written or cleared.
    // rust: pub(super) fn quantise(v: [f32; 4], bits: [u8; 4]) -> [f32; 4] {
    // rust: std::array::from_fn(|i| {
    // rust: let byte = (v[i].clamp(0.0, 1.0) * 255.0 + 0.5).floor() as u32;
    // rust: let n = u32::from(bits[i]);
    // rust: let kept = byte >> (8 - n);
        // The kept bits, repeated until there are 8.
    // rust: let mut wide = 0;
    // rust: let mut have = 0;
    // rust: while have < 8 {
    // rust: wide = wide << n | kept;
    // rust: have += n;
}
    // rust: (wide >> (have - 8)) as f32 / 255.0
    // rust: })
}

/// The factors of the shader's [`quantise`] for a channel keeping `n` bits: the kept value is
/// `floor(byte / step)`, and it reads back `kept × step + floor(kept × repeat)`.
pub fn factors(n: u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let step = f32::from(1u16 << (8 - n));
    // `kept × repeat` is the kept bits shifted down to fill what `kept × step` leaves: one bit
    // fills the other 7 (× 127); 5 or 6 bits fill 3 or 2 with their top bits.
    // rust: let repeat = match n {
    // rust: 1 => 127.0,
    // rust: _ => 2f32.powi(8 - 2 * i32::from(n)),
}
    // rust: (step, repeat)
}

/// Makes the fragment entry point of `module` write each output location of `outputs` as
/// [`quantise`] gives it for its bits. The translator's entry point ends in one `return` of its
/// outputs; a module without one is left as it is.
    // rust: pub(super) fn quantise_outputs(module: &mut naga::Module, outputs: &[(u32, [u8; 4])]) {
    // rust: let Some(ep) =
    // rust: (module.entry_points.iter_mut()).find(|e| e.stage == naga::ShaderStage::Fragment)
    // rust: else {
    // rust: return;
}
    // rust: let Some(result) = &ep.function.result else {
    // rust: return;
}
    // rust: let naga::TypeInner::Struct { members, .. } = &module.types[result.ty].inner else {
    // rust: return;
}
    // rust: let vec4 = |ty: naga::Handle<naga::Type>| {
    // rust: matches!(
    // rust: module.types[ty].inner,
    // rust: naga::TypeInner::Vector {
    // rust: size: VectorSize::Quad,
    // rust: scalar: naga::Scalar::F32
}
    // rust: )
}
    // (member, bits, the member's type) of each output to change.
    // rust: let changed: Vec<(usize, [u8; 4], naga::Handle<naga::Type>)> = (members.iter().enumerate())
    // rust: .filter_map(|(i, m)| {
    // rust: let Some(naga::Binding::Location { location, .. }) = m.binding else {
    // rust: return None;
}
    // rust: let bits = outputs.iter().find(|o| o.0 == location)?.1;
    // rust: vec4(m.ty).then_some((i, bits, m.ty))
    // rust: })
    // rust: .collect();
    // rust: if changed.is_empty() {
    // rust: return;
}
    // rust: let struct_ty = result.ty;
    // rust: let f = &mut ep.function;
    // rust: let body = std::mem::take(&mut f.body);
    // rust: let mut out = naga::Block::with_capacity(body.len() + 1);
    // rust: for (statement, span) in body.span_into_iter() {
    // rust: let Statement::Return { value: Some(value) } = statement else {
    // rust: out.push(statement, span);
    // rust: continue;
}
    // rust: let Expression::Compose { components, .. } = &f.expressions[value] else {
    // rust: out.push(statement, span);
    // rust: continue;
}
    // rust: let mut components = components.clone();
    // rust: let e = &mut f.expressions;
    // rust: let lit = |e: &mut naga::Arena<Expression>, v: f32| {
    // rust: e.append(Expression::Literal(Literal::F32(v)), span)
}
        // Literals need no emitting: they come before the range that is emitted.
    // rust: let scalars: Vec<_> = (changed.iter())
    // rust: .map(|&(_, bits, _)| {
    // rust: let per = bits.map(factors);
    // rust: (
    // rust: per.map(|(step, _)| lit(e, step)),
    // rust: per.map(|(step, _)| lit(e, 1.0 / step)),
    // rust: per.map(|(_, repeat)| lit(e, repeat)),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let (zero, one, max, half) = (lit(e, 0.0), lit(e, 1.0), lit(e, 255.0), lit(e, 0.5));
    // rust: let mut add = |x: Expression| e.append(x, span);
    // rust: let splat = |add: &mut dyn FnMut(Expression) -> _, value| {
    // rust: add(Expression::Splat {
    // rust: size: VectorSize::Quad,
    // rust: value,
    // rust: })
}
    // rust: let (zero, one, max, half) = (
    // rust: splat(&mut add, zero),
    // rust: splat(&mut add, one),
    // rust: splat(&mut add, max),
    // rust: splat(&mut add, half),
    // rust: );
    // rust: let binary = |add: &mut dyn FnMut(Expression) -> _, op, left, right| {
    // rust: add(Expression::Binary { op, left, right })
}
    // rust: let math = |add: &mut dyn FnMut(Expression) -> _, fun, arg, arg1, arg2| {
    // rust: add(Expression::Math {
    // rust: fun,
    // rust: arg,
    // rust: arg1,
    // rust: arg2,
    // rust: arg3: None,
    // rust: })
}
    // rust: for (&(member, _, ty), (steps, inverse, repeats)) in changed.iter().zip(scalars) {
    // rust: let mut vector = |components: [_; 4]| {
    // rust: add(Expression::Compose {
    // rust: ty,
    // rust: components: components.to_vec(),
    // rust: })
}
    // rust: let (step, inverse, repeat) = (vector(steps), vector(inverse), vector(repeats));
    // rust: let x = components[member];
    // rust: let clamped = math(&mut add, MathFunction::Clamp, x, Some(zero), Some(one));
    // rust: let scaled = binary(&mut add, BinaryOperator::Multiply, clamped, max);
    // rust: let rounded = binary(&mut add, BinaryOperator::Add, scaled, half);
    // rust: let byte = math(&mut add, MathFunction::Floor, rounded, None, None);
    // rust: let shifted = binary(&mut add, BinaryOperator::Multiply, byte, inverse);
    // rust: let kept = math(&mut add, MathFunction::Floor, shifted, None, None);
    // rust: let high = binary(&mut add, BinaryOperator::Multiply, kept, step);
    // rust: let low = binary(&mut add, BinaryOperator::Multiply, kept, repeat);
    // rust: let low = math(&mut add, MathFunction::Floor, low, None, None);
    // rust: let wide = binary(&mut add, BinaryOperator::Add, high, low);
    // rust: components[member] = binary(&mut add, BinaryOperator::Divide, wide, max);
}
    // rust: let value = add(Expression::Compose {
    // rust: ty: struct_ty,
    // rust: components,
    // rust: });
        // Everything from the first splat on is new and not a literal.
    // rust: let range = naga::Range::new_from_bounds(zero, value);
    // rust: out.push(Statement::Emit(range), span);
    // rust: out.push(Statement::Return { value: Some(value) }, span);
}
    // rust: f.body = out;
}

    // rust: mod tests {
//     use super::*;

pub fn clear_colours_keep_the_same_bits() void {
}
        // The CPU side, for clear colours. Iris 1.11.7 read p8106d's clear colour back as below in
        // RGB5_A1 and RGB565, and p8106c's 0.3337 as 82/255 in the 5-bit channels and 85/255 in
        // the 6-bit one.
    // rust: let to_255 = |v: [f32; 4]| v.map(|c| (c * 255.0 * 1000.0).round() / 1000.0);
    // rust: let rgb5_a1 = bits(Format::parse("RGB5_A1").unwrap()).unwrap();
    // rust: let rgb565 = bits(Format::parse("RGB565").unwrap()).unwrap();
    // rust: let r3_g3_b2 = bits(Format::parse("R3_G3_B2").unwrap()).unwrap();
    // rust: let clear = [0.3337, 0.1, 0.6, 0.3];
    // rust: assert_eq!(to_255(quantise(clear, rgb5_a1)), [82.0, 24.0, 156.0, 0.0]);
    // rust: assert_eq!(to_255(quantise(clear, rgb565))[..3], [82.0, 24.0, 156.0]);
    // rust: assert_eq!(
    // rust: to_255(quantise([0.3337; 4], r3_g3_b2))[..3],
    // rust: [82.0, 85.0, 82.0]
    // rust: );
    // rust: assert!(bits(Format::parse("RGBA4").unwrap()).is_none());
}
}
