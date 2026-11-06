//! Transpiled from Horizon Rust crate
package horizon_core_float_log_parity

import "core:fmt"
import "core:mem"
import "core:math"

// Binary transport for exhaustive comparison of the compiled float log sampler.
// use horizon_core::density::{DensitySampler, SampleError, SamplerContext, UnaryOp, UnarySampler};
// use std::{
    // rust: io::{self, Write},
    // rust: sync::Arc,
}

FloatBitsInput :: struct {
    // rust: impl DensitySampler for FloatBitsInput {
sample_value :: proc(self: ^Self, _: ^SamplerContext, position: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(f32::from_bits(position[0] as u32))
}
}

main :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut args = std::env::args().skip(1);
    // rust: let mut start = args
    // rust: .next()
    // rust: .ok_or("missing first float bits")?
    // rust: .parse::<u64>()?;
    // rust: let mut remaining = args.next().ok_or("missing float count")?.parse::<u64>()?;
    // rust: if args.next().is_some()
    // rust: || start
    // rust: .checked_add(remaining)
    // rust: .is_none_or(|end| end > 1_u64 << 32)
    // rust: {
    // rust: return Err("invalid float bit range".into());
}
    // rust: let sampler = UnarySampler {
    // rust: input: Arc::new(FloatBitsInput),
    // rust: operation: UnaryOp::Log,
}
    // rust: let mut context = SamplerContext::default();
    // rust: let mut out = io::BufWriter::with_capacity(1 << 20, io::stdout().lock());
    // rust: let mut buffer = vec![0_u8; 1 << 20];
    // rust: while remaining > 0 {
    // rust: let entries = remaining.min((buffer.len() / 4) as u64) as usize;
    // rust: for (offset, bytes) in buffer[..entries * 4].chunks_exact_mut(4).enumerate() {
    // rust: let bits = (start + offset as u64) as u32;
    // rust: let value = sampler.sample_value(&mut context, [bits as i32, 0, 0])?;
    // rust: let result = if value.is_nan() {
    // rust: 0x7fc0_0000
    // rust: } else {
    // rust: value.to_bits()
}
    // rust: bytes.copy_from_slice(&result.to_be_bytes());
}
    // rust: out.write_all(&buffer[..entries * 4])?;
    // rust: start += entries as u64;
    // rust: remaining -= entries as u64;
}
    // rust: out.flush()?;
    // rust: Ok(())
}
