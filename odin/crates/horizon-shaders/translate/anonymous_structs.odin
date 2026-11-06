//! Transpiled from Horizon Rust crate
package horizon_shaders_anonymous_structs

import "core:fmt"
import "core:mem"
import "core:math"

// Struct types without a name. GLSL lets a declaration define its struct type in place without
// naming it (GLSL 4.60, 4.1.8: `shared struct { uint sum; uint tile[64]; } lds;`); naga's
// frontend wants a name there ("Expected identifier, found LeftBrace"). Each such type gets
// one, `hz_struct<n>`; nothing else changes.

// use super::scan::significant;
// use crate::macros::lex;

// `code` with a name for each struct type declared without one, or `None` when it has none.
    // rust: pub(super) fn name(code: &str) -> Option<String> {
    // rust: let tokens = lex(code);
    // rust: let mut out = String::with_capacity(code.len() + 64);
    // rust: let mut named = 0;
    // rust: for (i, t) in tokens.iter().enumerate() {
    // rust: out.push_str(t);
    // rust: let opens = (i + 1..tokens.len())
    // rust: .find(|&j| significant(tokens[j]))
    // rust: .is_some_and(|j| tokens[j] == "{");
    // rust: if *t == "struct" && opens {
    // rust: out.push_str(&format!(" hz_struct{named}"));
    // rust: named += 1;
}
}
    // rust: (named > 0).then_some(out)
}

    // rust: mod tests {
//     use super::name;

struct_types_without_a_name_get_one :: proc() {
}
    // rust: let code = "shared struct {\n    uint sum;\n} lds;\nstruct Light { vec3 c; };\n\
    // rust: struct\n{ float a; } x, y[2];\n";
    // rust: assert_eq!(
    // rust: name(code).as_deref(),
    // rust: Some(
    // rust: "shared struct hz_struct0 {\n    uint sum;\n} lds;\nstruct Light { vec3 c; };\n\
hz_struct1 :: struct {
    // rust: )
    // rust: );
    // rust: assert_eq!(name("struct Light { vec3 c; };\n"), None);
}
}
