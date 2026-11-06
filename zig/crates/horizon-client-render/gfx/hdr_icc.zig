//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_hdr_icc
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The ICC profile of HDR screenshots, for programs that don't read PNG's `cICP`: BT.2020
//! primaries and the PQ curve, with HDR reference white (203 nits) as the profile's white.
//! An ICC profile has no values above white, so those programs show a correct SDR picture
//! with its highlights clipped, where without it they took PQ's values for sRGB's and showed
//! them washed out. Programs that read `cICP` ignore this (PNG's third edition).

/// HDR reference white in nits (ITU-R BT.2408): where the curve reaches the profile's white.
pub const WHITE: f64 = 203.0;
/// PQ's values from 0 to 1, in the curve's steps.
pub const STEPS: usize = 4096;
/// BT.2020's primaries, adapted to the profile connection space's D50 (Bradford).
pub const RED: [f64; 3] = [0.67348, 0.27904, -0.00193];
pub const GREEN: [f64; 3] = [0.16567, 0.67534, 0.02998];
pub const BLUE: [f64; 3] = [0.12505, 0.04561, 0.79685];
pub const D50: [f64; 3] = [0.9642, 1.0, 0.8249];

/// PQ's EOTF (SMPTE ST 2084): a signal from 0 to 1 in nits.
pub fn pq_nits(signal: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (m1, m2) = (2610.0 / 16384.0, 2523.0 / 32.0);
    // rust: let (c1, c2, c3) = (3424.0 / 4096.0, 2413.0 / 128.0, 2392.0 / 128.0);
    // rust: let p = signal.powf(1.0 / m2);
    // rust: 10_000.0 * ((p - c1).max(0.0) / (c2 - c3 * p)).powf(1.0 / m1)
}

pub fn s15_fixed16(v: f64) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((v * 65536.0).round() as i32).to_be_bytes()
}

pub fn xyz(v: [f64; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tag = b"XYZ \0\0\0\0".to_vec();
    // rust: tag.extend(v.iter().flat_map(|&c| s15_fixed16(c)));
    // rust: tag
}

pub fn curve() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tag = b"curv\0\0\0\0".to_vec();
    // rust: tag.extend((STEPS as u32).to_be_bytes());
    // rust: for i in 0..STEPS {
    // rust: let y = (pq_nits(i as f64 / (STEPS - 1) as f64) / WHITE).min(1.0);
    // rust: tag.extend(((y * 65535.0).round() as u16).to_be_bytes());
}
    // rust: tag
}

/// `textDescriptionType` (ICC v2), with its empty Unicode and ScriptCode parts.
pub fn description(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tag = b"desc\0\0\0\0".to_vec();
    // rust: tag.extend((text.len() as u32 + 1).to_be_bytes());
    // rust: tag.extend(text.as_bytes());
    // rust: tag.extend([0; 1 + 4 + 4 + 2 + 1 + 67]);
    // rust: tag
}

/// An ICC v2 matrix-shaper display profile.
    // rust: pub(super) fn profile() -> Vec<u8> {
    // rust: let trc = curve();
    // rust: let copyright = b"text\0\0\0\0Public domain\0".to_vec();
    // rust: let tags: [(&[u8; 4], &[u8]); 9] = [
    // rust: (b"desc", &description("BT.2020 PQ, 203 nits = white")),
    // rust: (b"cprt", &copyright),
    // rust: (b"wtpt", &xyz(D50)),
    // rust: (b"rXYZ", &xyz(RED)),
    // rust: (b"gXYZ", &xyz(GREEN)),
    // rust: (b"bXYZ", &xyz(BLUE)),
    // rust: (b"rTRC", &trc),
    // rust: (b"gTRC", &trc),
    // rust: (b"bTRC", &trc),
    // rust: ];
    // rust: let data_start = 128 + 4 + 12 * tags.len();
    // rust: let mut table = (tags.len() as u32).to_be_bytes().to_vec();
    // rust: let mut data = Vec::new();
    // rust: let mut trc_at = None;
    // rust: for (name, tag) in tags {
        // The three channels share one curve.
    // rust: let is_trc = tag == &trc[..];
    // rust: let at = match trc_at.filter(|_| is_trc) {
    // rust: Some(at) => at,
    // rust: None => {
    // rust: let at = data_start + data.len();
    // rust: data.extend(tag);
    // rust: data.resize(data.len().next_multiple_of(4), 0);
    // rust: at
}
}
    // rust: if is_trc {
    // rust: trc_at = Some(at);
}
    // rust: table.extend(name);
    // rust: table.extend((at as u32).to_be_bytes());
    // rust: table.extend((tag.len() as u32).to_be_bytes());
}
    // rust: let mut out = vec![0; 128];
    // rust: let size = data_start + data.len();
    // rust: out[0..4].copy_from_slice(&(size as u32).to_be_bytes());
    // rust: out[8..12].copy_from_slice(&[2, 0x40, 0, 0]);
    // rust: out[12..16].copy_from_slice(b"mntr");
    // rust: out[16..20].copy_from_slice(b"RGB ");
    // rust: out[20..24].copy_from_slice(b"XYZ ");
    // rust: out[36..40].copy_from_slice(b"acsp");
    // Relative colorimetric, and the connection space's illuminant.
    // rust: out[64..68].copy_from_slice(&1u32.to_be_bytes());
    // rust: for (i, &c) in D50.iter().enumerate() {
    // rust: out[68 + 4 * i..72 + 4 * i].copy_from_slice(&s15_fixed16(c));
}
    // rust: out.extend(table);
    // rust: out.extend(data);
    // rust: out
}

    // rust: mod tests {
//     use super::*;

    // rust: fn tag<'a>(profile: &'a [u8], name: &[u8; 4]) -> &'a [u8] {
    // rust: let u32_at = |i: usize| u32::from_be_bytes(profile[i..i + 4].try_into().unwrap()) as usize;
    // rust: let at = (0..u32_at(128))
    // rust: .map(|i| 132 + 12 * i)
    // rust: .find(|&e| &profile[e..e + 4] == name)
    // rust: .unwrap();
    // rust: &profile[u32_at(at + 4)..u32_at(at + 4) + u32_at(at + 8)]
}

pub fn the_profile_is_whole() void {
}
    // rust: let p = profile();
    // rust: assert_eq!(
    // rust: u32::from_be_bytes(p[0..4].try_into().unwrap()) as usize,
    // rust: p.len()
    // rust: );
    // rust: assert_eq!(&p[36..40], b"acsp");
    // rust: assert_eq!(p.len() % 4, 0);
    // rust: assert_eq!(&tag(&p, b"desc")[0..4], b"desc");
        // One curve, shared: the profile stays small.
    // rust: assert_eq!(tag(&p, b"rTRC").as_ptr(), tag(&p, b"bTRC").as_ptr());
    // rust: assert!(p.len() < 10_000, "{}", p.len());
}

pub fn the_primaries_add_up_to_white() void {
}
    // rust: for i in 0..3 {
    // rust: assert!((RED[i] + GREEN[i] + BLUE[i] - D50[i]).abs() < 0.0001);
}
}

pub fn the_curve_reaches_white_at_reference_white_and_stays() void {
}
    // rust: let p = profile();
    // rust: let trc = tag(&p, b"rTRC");
    // rust: let value = |signal: f64| {
    // rust: let i = 12 + 2 * (signal * (STEPS - 1) as f64).round() as usize;
    // rust: u16::from_be_bytes([trc[i], trc[i + 1]])
}
    // rust: assert_eq!(value(0.0), 0);
        // 203 nits in PQ is a signal of 0.5807.
    // rust: assert!(value(0.57) < 65535);
    // rust: assert_eq!(value(0.59), 65535);
    // rust: assert_eq!(value(1.0), 65535);
}
}
