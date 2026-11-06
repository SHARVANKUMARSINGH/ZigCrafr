//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_uuid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! UUIDs as vanilla's four-int form, to and from their text form.

pub fn uuid_text(u: [i32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hex: String = u.iter().map(|v| format!("{:08x}", *v as u32)).collect();
    // rust: format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &hex[0..8],
    // rust: &hex[8..12],
    // rust: &hex[12..16],
    // rust: &hex[16..20],
    // rust: &hex[20..32]
    // rust: )
}
pub fn uuid_from_text(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut hex = [0u8; 32];
    // rust: let mut len = 0;
    // rust: for b in s.bytes() {
    // rust: if b == b'-' {
    // rust: continue;
}
    // rust: if !b.is_ascii_hexdigit() || len >= 32 {
    // rust: return None;
}
    // rust: hex[len] = b;
    // rust: len += 1;
}
    // rust: if len != 32 {
    // rust: return None;
}
    // rust: let hex = std::str::from_utf8(&hex).ok()?;
    // rust: let mut out = [0i32; 4];
    // rust: for (i, v) in out.iter_mut().enumerate() {
    // rust: *v = u32::from_str_radix(&hex[i * 8..i * 8 + 8], 16).ok()? as i32;
}
    // rust: Some(out)
}

    // rust: mod tests {
//     use super::*;

pub fn uuid_from_text_rejects_multibyte_and_non_hex() void {
}
    // rust: assert_eq!(uuid_from_text("€€€€€€€€€€aa"), None);
    // rust: assert_eq!(uuid_from_text("€€€€€€€€€€aa----"), None);
    // rust: assert_eq!(uuid_from_text("+0000001-0000-0000-0000-000000000000"), None);
    // rust: assert_eq!(uuid_from_text("00000000-0000-0000-0000-00000000000g"), None);
    // rust: assert_eq!(uuid_from_text(""), None);
}

pub fn uuid_from_text_parses_hex_and_dashes() void {
}
    // rust: let u = [0x01234567, -0x76543211, 0x01234567, -0x76543211];
    // rust: let text = uuid_text(u);
    // rust: assert_eq!(uuid_from_text(&text), Some(u));
    // rust: let undashed: String = text.chars().filter(|c| *c != '-').collect();
    // rust: assert_eq!(uuid_from_text(&undashed), Some(u));
}
}
