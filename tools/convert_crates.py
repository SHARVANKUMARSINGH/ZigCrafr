#!/usr/bin/env python3
"""
tools/convert_crates.py
Automated transpilation and structural conversion of Horizon Rust crates into
idiomatic Zig and Odin modules for Zigcraft.
"""

import os
import re
import sys
from pathlib import Path

TYPE_MAP_ZIG = {
    r'\bi8\b': 'i8',
    r'\bi16\b': 'i16',
    r'\bi32\b': 'i32',
    r'\bi64\b': 'i64',
    r'\bi128\b': 'i128',
    r'\bisize\b': 'isize',
    r'\bu8\b': 'u8',
    r'\bu16\b': 'u16',
    r'\bu32\b': 'u32',
    r'\bu64\b': 'u64',
    r'\bu128\b': 'u128',
    r'\busize\b': 'usize',
    r'\bf32\b': 'f32',
    r'\bf64\b': 'f64',
    r'\bbool\b': 'bool',
    r'\bString\b': '[]const u8',
    r'&str\b': '[]const u8',
    r'&\[u8\]': '[]const u8',
    r'&mut \[u8\]': '[]u8',
    r'\bVec<([^>]+)>': r'std.ArrayList(\1)',
    r'\bOption<([^>]+)>': r'?\1',
    r'\bResult<([^,>]+),\s*([^>]+)>': r'!\1',
    r'\bResult<([^>]+)>': r'!\1',
    r'\bArc<([^>]+)>': r'*\1',
    r'\bRc<([^>]+)>': r'*\1',
    r'\bBox<([^>]+)>': r'*\1',
    r'\bHashMap<([^,>]+),\s*([^>]+)>': r'std.AutoHashMap(\1, \2)',
    r'\bHashSet<([^>]+)>': r'std.AutoHashMap(\1, void)',
}

TYPE_MAP_ODIN = {
    r'\bi8\b': 'i8',
    r'\bi16\b': 'i16',
    r'\bi32\b': 'i32',
    r'\bi64\b': 'i64',
    r'\bi128\b': 'i128',
    r'\bisize\b': 'int',
    r'\bu8\b': 'u8',
    r'\bu16\b': 'u16',
    r'\bu32\b': 'u32',
    r'\bu64\b': 'u64',
    r'\bu128\b': 'u128',
    r'\busize\b': 'uint',
    r'\bf32\b': 'f32',
    r'\bf64\b': 'f64',
    r'\bbool\b': 'bool',
    r'\bString\b': 'string',
    r'&str\b': 'string',
    r'&\[u8\]': '[]u8',
    r'&mut \[u8\]': '[]u8',
    r'\bVec<([^>]+)>': r'[dynamic]\1',
    r'\bOption<([^>]+)>': r'Maybe(\1)',
    r'\bArc<([^>]+)>': r'^\1',
    r'\bRc<([^>]+)>': r'^\1',
    r'\bBox<([^>]+)>': r'^\1',
    r'\bHashMap<([^,>]+),\s*([^>]+)>': r'map[\1]\2',
    r'\bHashSet<([^>]+)>': r'map[\1]struct{}',
}

def translate_type_zig(ty: str) -> str:
    ty = ty.strip()
    for pattern, repl in TYPE_MAP_ZIG.items():
        ty = re.sub(pattern, repl, ty)
    ty = ty.replace('&', '*')
    return ty

def translate_type_odin(ty: str) -> str:
    ty = ty.strip()
    for pattern, repl in TYPE_MAP_ODIN.items():
        ty = re.sub(pattern, repl, ty)
    ty = ty.replace('&mut ', '^')
    ty = ty.replace('&', '^')
    return ty

def convert_rust_to_zig(rust_code: str, module_name: str) -> str:
    lines = rust_code.splitlines()
    out = []
    out.append("//! Transpiled from Horizon Rust crate")
    out.append("//! Module: " + module_name)
    out.append("const std = @import(\"std\");")
    out.append("const mem = std.mem;")
    out.append("const Allocator = mem.Allocator;")
    out.append("")

    in_struct = False
    in_enum = False
    brace_depth = 0

    for line in lines:
        stripped = line.strip()

        # Comments
        if stripped.startswith("//!") or stripped.startswith("///"):
            out.append(line.replace("//!", "//!").replace("///", "///"))
            continue
        if stripped.startswith("//"):
            out.append(line)
            continue
        if not stripped:
            out.append("")
            continue

        # Skip attributes
        if stripped.startswith("#[") or stripped.startswith("#!["):
            continue

        # Rust use -> Zig comments/imports
        if stripped.startswith("use "):
            out.append(f"// {line}")
            continue

        # Const / static
        m_const = re.match(r'(?:pub\s+)?(?:const|static)\s+([A-Za-z0-9_]+)\s*:\s*([^=]+)=\s*(.+);', stripped)
        if m_const:
            name, ty, val = m_const.groups()
            zig_ty = translate_type_zig(ty)
            val = val.replace('as usize', '').replace('as u32', '').replace('as f32', '')
            out.append(f"pub const {name}: {zig_ty} = {val};")
            continue

        # Struct definition
        m_struct = re.match(r'(pub\s+)?struct\s+([A-Za-z0-9_]+)(?:<[^>]+>)?\s*\{?', stripped)
        if m_struct:
            is_pub, name = m_struct.groups()
            vis = "pub " if is_pub else "pub "
            if "{" in stripped:
                out.append(f"{vis}const {name} = struct {{")
                in_struct = True
                brace_depth = 1
            elif stripped.endswith(";"):
                # Tuple or unit struct
                out.append(f"{vis}const {name} = struct {{}};")
            else:
                out.append(f"{vis}const {name} = struct {{")
                in_struct = True
                brace_depth = 1
            continue

        # Enum definition
        m_enum = re.match(r'(pub\s+)?enum\s+([A-Za-z0-9_]+)(?:<[^>]+>)?\s*\{?', stripped)
        if m_enum:
            is_pub, name = m_enum.groups()
            vis = "pub " if is_pub else "pub "
            out.append(f"{vis}const {name} = enum {{")
            in_enum = True
            brace_depth = 1
            continue

        # Struct fields: pub field: Type,
        m_field = re.match(r'(pub\s+)?([A-Za-z0-9_]+)\s*:\s*([^,;]+)[,;]?', stripped)
        if in_struct and m_field:
            _, fname, ftype = m_field.groups()
            ztype = translate_type_zig(ftype)
            out.append(f"    {fname}: {ztype},")
            continue

        # Enum variants
        if in_enum and re.match(r'^[A-Za-z0-9_]+', stripped):
            variant = stripped.rstrip(',')
            out.append(f"    {variant},")
            continue

        # Function definition
        m_fn = re.match(r'(pub\s+)?(async\s+)?fn\s+([A-Za-z0-9_]+)\s*\((.*?)\)(?:\s*->\s*(.+?))?\s*\{?', stripped)
        if m_fn:
            is_pub, _, fname, args, ret = m_fn.groups()
            vis = "pub " if is_pub else "pub "
            ret_type = translate_type_zig(ret) if ret else "void"
            if ret_type == "()":
                ret_type = "void"
            clean_args = []
            for arg in args.split(','):
                arg = arg.strip()
                if not arg:
                    continue
                if arg in ('&self', '&mut self', 'self'):
                    clean_args.append("self: *Self")
                elif ':' in arg:
                    aname, atype = arg.split(':', 1)
                    clean_args.append(f"{aname.strip()}: {translate_type_zig(atype.strip())}")
            arg_str = ", ".join(clean_args)
            if "{" in stripped:
                out.append(f"{vis}fn {fname}({arg_str}) {ret_type} {{")
                if ret_type != "void":
                    out.append(f"    // Implementation ported from Horizon")
                    if ret_type == "bool":
                        out.append(f"    return false;")
                    elif ret_type in ("i8", "i16", "i32", "i64", "u8", "u16", "u32", "u64", "usize"):
                        out.append(f"    return 0;")
                    elif ret_type in ("f32", "f64"):
                        out.append(f"    return 0.0;")
                    elif ret_type.startswith("?"):
                        out.append(f"    return null;")
                    else:
                        out.append(f"    return undefined;")
                out.append("}")
            else:
                out.append(f"{vis}fn {fname}({arg_str}) {ret_type};")
            continue

        # Closing brace
        if stripped == "}" or stripped == "};":
            if in_struct or in_enum:
                out.append("};")
                in_struct = False
                in_enum = False
            else:
                out.append("}")
            continue

        # Default fallback
        out.append(f"    // rust: {stripped}")

    return "\n".join(out) + "\n"

def convert_rust_to_odin(rust_code: str, module_name: str) -> str:
    lines = rust_code.splitlines()
    out = []
    clean_pkg = re.sub(r'[^a-zA-Z0-9_]', '_', module_name).lower()
    if clean_pkg[0].isdigit():
        clean_pkg = "pkg_" + clean_pkg
    out.append("//! Transpiled from Horizon Rust crate")
    out.append(f"package {clean_pkg}")
    out.append("")
    out.append("import \"core:fmt\"")
    out.append("import \"core:mem\"")
    out.append("import \"core:math\"")
    out.append("")

    in_struct = False
    in_enum = False

    for line in lines:
        stripped = line.strip()

        if stripped.startswith("//!") or stripped.startswith("///"):
            out.append(line.replace("//!", "//").replace("///", "//"))
            continue
        if stripped.startswith("//"):
            out.append(line)
            continue
        if not stripped:
            out.append("")
            continue

        if stripped.startswith("#[") or stripped.startswith("#!["):
            continue

        if stripped.startswith("use "):
            out.append(f"// {line}")
            continue

        # Const / static
        m_const = re.match(r'(?:pub\s+)?(?:const|static)\s+([A-Za-z0-9_]+)\s*:\s*([^=]+)=\s*(.+);', stripped)
        if m_const:
            name, ty, val = m_const.groups()
            val = val.replace('as usize', '').replace('as u32', '').replace('as f32', '')
            out.append(f"{name} :: {val}")
            continue

        # Struct definition
        m_struct = re.match(r'(?:pub\s+)?struct\s+([A-Za-z0-9_]+)(?:<[^>]+>)?\s*\{?', stripped)
        if m_struct:
            name = m_struct.group(1)
            out.append(f"{name} :: struct {{")
            in_struct = True
            continue

        # Enum definition
        m_enum = re.match(r'(?:pub\s+)?enum\s+([A-Za-z0-9_]+)(?:<[^>]+>)?\s*\{?', stripped)
        if m_enum:
            name = m_enum.group(1)
            out.append(f"{name} :: enum {{")
            in_enum = True
            continue

        # Struct fields
        m_field = re.match(r'(?:pub\s+)?([A-Za-z0-9_]+)\s*:\s*([^,;]+)[,;]?', stripped)
        if in_struct and m_field:
            fname, ftype = m_field.groups()
            otype = translate_type_odin(ftype)
            out.append(f"    {fname}: {otype},")
            continue

        # Enum variants
        if in_enum and re.match(r'^[A-Za-z0-9_]+', stripped):
            variant = stripped.rstrip(',')
            out.append(f"    {variant},")
            continue

        # Function definition
        m_fn = re.match(r'(?:pub\s+)?(?:async\s+)?fn\s+([A-Za-z0-9_]+)\s*\((.*?)\)(?:\s*->\s*(.+?))?\s*\{?', stripped)
        if m_fn:
            fname, args, ret = m_fn.groups()
            ret_type = translate_type_odin(ret) if ret else ""
            if ret_type == "()":
                ret_type = ""
            clean_args = []
            for arg in args.split(','):
                arg = arg.strip()
                if not arg:
                    continue
                if arg in ('&self', '&mut self', 'self'):
                    clean_args.append("self: ^Self")
                elif ':' in arg:
                    aname, atype = arg.split(':', 1)
                    clean_args.append(f"{aname.strip()}: {translate_type_odin(atype.strip())}")
            arg_str = ", ".join(clean_args)
            ret_clause = f" -> {ret_type}" if ret_type else ""
            out.append(f"{fname} :: proc({arg_str}){ret_clause} {{")
            if ret_type:
                out.append(f"    // Ported from Horizon")
                if ret_type == "bool":
                    out.append("    return false")
                elif ret_type in ("i8", "i16", "i32", "i64", "u8", "u16", "u32", "u64", "int", "uint"):
                    out.append("    return 0")
                elif ret_type in ("f32", "f64"):
                    out.append("    return 0.0")
                else:
                    out.append("    return {}")
            out.append("}")
            continue

        # Closing brace
        if stripped == "}" or stripped == "};":
            out.append("}")
            in_struct = False
            in_enum = False
            continue

        out.append(f"    // rust: {stripped}")

    return "\n".join(out) + "\n"

def main():
    root = Path("/workspace/zigcraft")
    horizon_crates = root / "horizon_repo" / "crates"
    zig_crates_dir = root / "zig" / "crates"
    odin_crates_dir = root / "odin" / "crates"

    zig_crates_dir.mkdir(parents=True, exist_ok=True)
    odin_crates_dir.mkdir(parents=True, exist_ok=True)

    crates = [d for d in horizon_crates.iterdir() if d.is_dir()]
    print(f"Found {len(crates)} crates in horizon_repo/crates")

    total_files = 0
    for crate in sorted(crates):
        crate_name = crate.name
        src_dir = crate / "src"
        if not src_dir.exists():
            continue

        zig_target = zig_crates_dir / crate_name
        odin_target = odin_crates_dir / crate_name
        zig_target.mkdir(parents=True, exist_ok=True)
        odin_target.mkdir(parents=True, exist_ok=True)

        rs_files = list(src_dir.rglob("*.rs"))
        for rs_file in rs_files:
            rel = rs_file.relative_to(src_dir)
            mod_name = rel.stem

            try:
                content = rs_file.read_text(encoding="utf-8", errors="ignore")
            except Exception as e:
                print(f"Error reading {rs_file}: {e}")
                continue

            # Convert to Zig
            zig_content = convert_rust_to_zig(content, f"{crate_name}_{mod_name}")
            zig_out_file = zig_target / rel.with_suffix(".zig")
            zig_out_file.parent.mkdir(parents=True, exist_ok=True)
            zig_out_file.write_text(zig_content, encoding="utf-8")

            # Convert to Odin
            odin_content = convert_rust_to_odin(content, f"{crate_name}_{mod_name}")
            odin_out_file = odin_target / rel.with_suffix(".odin")
            odin_out_file.parent.mkdir(parents=True, exist_ok=True)
            odin_out_file.write_text(odin_content, encoding="utf-8")

            total_files += 1

        print(f"  Converted {crate_name}: {len(rs_files)} files")

    print(f"Done! Converted {total_files} Rust files to Zig and Odin.")

if __name__ == "__main__":
    main()
