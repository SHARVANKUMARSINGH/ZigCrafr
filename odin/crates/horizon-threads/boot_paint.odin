//! Transpiled from Horizon Rust crate
package horizon_threads_boot_paint

import "core:fmt"
import "core:mem"
import "core:math"

// The game window's boot screen before wgpu's first frame: the renderer's
// device and pipelines take seconds to build, and winit's window sits white
// until a frame is presented. The game's boot design (`ui_theme::draw_boot`:
// pure black, the white wordmark, the console's last lines at the bottom
// left, wrapping word-wise), painted with GDI and replaced by the wgpu frames
// when the renderer starts drawing.

// use std::sync::Once;

// use windows_sys::Win32::Foundation::{COLORREF, HWND, RECT};
// use windows_sys::Win32::Graphics::Gdi::{
    // rust: AddFontMemResourceEx, BitBlt, CLEARTYPE_QUALITY, CLIP_DEFAULT_PRECIS, CreateCompatibleBitmap,
    // rust: CreateCompatibleDC, CreateFontW, CreateSolidBrush, DEFAULT_CHARSET, DT_CALCRECT, DT_CENTER,
    // rust: DT_LEFT, DT_NOCLIP, DT_SINGLELINE, DT_VCENTER, DT_WORDBREAK, DeleteDC, DeleteObject, DrawTextW,
    // rust: FF_DONTCARE, FillRect, GetDC, OUT_DEFAULT_PRECIS, ReleaseDC, SRCCOPY, SelectObject, SetBkMode,
    // rust: SetTextColor, TRANSPARENT,
}
// use windows_sys::Win32::UI::WindowsAndMessaging::GetClientRect;

// The wordmark on the pure black.
WORDMARK :: 0x00ff_ffff
// The console's lines, `0x9BA1A6` in GDI's `0x00bbggrr`.
CONSOLE :: 0x00a6_a19b

// GDI's font table is global to the process: the bundled faces register once
// across every paint.
FACES :: Once::new()

// Paints the client area of the window at `hwnd` black, the wordmark centred
// and the console's last lines at the bottom left — the same look as the
// game's `ui_theme::draw_boot`, which takes over when the renderer presents
// its first frame.
//
// `semibold` and `mono` are the faces' TTF bytes (`Geist SemiBold`,
// `Geist Mono`), which must outlive the process: `AddFontMemResourceEx`
// keeps referencing them. Repainting is safe and cheap (a background thread
// may call this as the console's lines arrive).
paint :: proc(hwnd: int, semibold: []u8, mono: []u8, logs: ^[string]) {
}
    // rust: let hwnd = hwnd as HWND;
    // rust: FACES.call_once(|| {
    // rust: for font in [semibold, mono] {
    // rust: let count = 0u32;
    // rust: unsafe {
    // rust: AddFontMemResourceEx(
    // rust: font.as_ptr().cast(),
    // rust: font.len() as u32,
    // rust: std::ptr::null(),
    // rust: &count,
    // rust: );
}
}
    // rust: });
    // rust: unsafe {
    // rust: let window_dc = GetDC(hwnd);
    // rust: if window_dc.is_null() {
    // rust: return;
}
    // rust: let mut rect = RECT {
    // rust: left: 0,
    // rust: top: 0,
    // rust: right: 0,
    // rust: bottom: 0,
}
    // rust: GetClientRect(hwnd, &mut rect);
        // Draw into a memory bitmap and copy it to the window in one blit:
        // clearing and drawing straight to the window's DC shows the blank
        // frame in between, so the screen flickers at every repaint.
    // rust: let mem = CreateCompatibleDC(window_dc);
    // rust: let bitmap = CreateCompatibleBitmap(window_dc, rect.right, rect.bottom);
    // rust: if mem.is_null() || bitmap.is_null() {
    // rust: if !bitmap.is_null() {
    // rust: let _ = DeleteObject(bitmap);
}
    // rust: if !mem.is_null() {
    // rust: let _ = DeleteDC(mem);
}
    // rust: let _ = ReleaseDC(hwnd, window_dc);
    // rust: return;
}
    // rust: let old_bitmap = SelectObject(mem, bitmap);
    // rust: let hdc = mem;
    // rust: let (w, h) = (
    // rust: (rect.right - rect.left) as f32,
    // rust: (rect.bottom - rect.top) as f32,
    // rust: );
        // The pure black clear.
    // rust: let brush = CreateSolidBrush(0);
    // rust: FillRect(hdc, &rect, brush);
    // rust: let _ = DeleteObject(brush);
        // The type scale of the game's `Ui::new`: physical pixels per dp,
        // then the sizes in dp (the wordmark at `DISPLAY`, the console at
        // `MICRO` with 1.5 line heights).
    // rust: let density = (w / 1040.0).min(h / 700.0).clamp(1.0, 4.0);
    // rust: let size = ((w / density / 16.0).clamp(40.0, 96.0) * density).round();
    // rust: let line = 11.0 * density * 1.5;
    // rust: let pad = 16.0 * density;
    // rust: let face = |px: i32, weight: i32, name: &str| {
    // rust: let name: Vec<u16> = name.encode_utf16().chain(std::iter::once(0)).collect();
    // rust: CreateFontW(
    // rust: -px,
    // rust: 0,
    // rust: 0,
    // rust: 0,
    // rust: weight,
    // rust: 0,
    // rust: 0,
    // rust: 0,
    // rust: DEFAULT_CHARSET as u32,
    // rust: OUT_DEFAULT_PRECIS as u32,
    // rust: CLIP_DEFAULT_PRECIS as u32,
    // rust: CLEARTYPE_QUALITY as u32,
    // rust: FF_DONTCARE as u32,
    // rust: name.as_ptr(),
    // rust: )
}
        // The wordmark with its tagline, centred.
    // rust: let small = (size * 0.25).clamp(11.0 * density, 18.0 * density);
    // rust: let block = size * 1.45 + small * 0.6 + small * 1.5;
    // rust: let top = (h - block) / 2.0;
    // rust: let mark = face(size as i32, 600, "Geist SemiBold");
    // rust: let old_mark = SelectObject(hdc, mark);
    // rust: SetBkMode(hdc, TRANSPARENT as i32);
    // rust: SetTextColor(hdc, WORDMARK);
    // rust: let text: Vec<u16> = "Horizon".encode_utf16().collect();
    // rust: let mut mark_rect = RECT {
    // rust: left: 0,
    // rust: top: top as i32,
    // rust: right: w as i32,
    // rust: bottom: (top + size * 1.45) as i32,
}
    // rust: DrawTextW(
    // rust: hdc,
    // rust: text.as_ptr(),
    // rust: text.len() as i32,
    // rust: &mut mark_rect,
    // rust: DT_CENTER | DT_SINGLELINE | DT_NOCLIP | DT_VCENTER,
    // rust: );
    // rust: let tagline = face(small as i32, 400, "Geist Mono");
    // rust: let old_tagline = SelectObject(hdc, tagline);
    // rust: SetTextColor(hdc, CONSOLE);
    // rust: let tagline_text: Vec<u16> = "Rust based minecraft client".encode_utf16().collect();
    // rust: let tagline_top = top + size * 1.45 + small * 0.6;
    // rust: let mut tagline_rect = RECT {
    // rust: left: 0,
    // rust: top: tagline_top as i32,
    // rust: right: w as i32,
    // rust: bottom: (tagline_top + small * 1.5) as i32,
}
    // rust: DrawTextW(
    // rust: hdc,
    // rust: tagline_text.as_ptr(),
    // rust: tagline_text.len() as i32,
    // rust: &mut tagline_rect,
    // rust: DT_CENTER | DT_SINGLELINE | DT_NOCLIP | DT_VCENTER,
    // rust: );
        // The console's last lines at the bottom left, the newest at the
        // bottom: long lines wrap word-wise and the block grows upwards, as
        // the game's `draw_boot_log` draws it (capped at 24 sub-lines).
    // rust: let console = face(line as i32, 400, "Geist Mono");
    // rust: let old_console = SelectObject(hdc, console);
    // rust: SetTextColor(hdc, CONSOLE);
    // rust: let max_rows = (((h - pad) / line) as usize).clamp(1, 24);
    // rust: let mut y = h - pad;
    // rust: let mut drawn = 0;
    // rust: 'lines: for text in logs.iter().rev() {
    // rust: if text.is_empty() {
    // rust: continue;
}
    // rust: let wide: Vec<u16> = text.encode_utf16().collect();
            // The wrapped height, measured without drawing (DT_CALCRECT);
            // every row is the face's cell height, `line`.
    // rust: let mut rect = RECT {
    // rust: left: pad as i32,
    // rust: top: 0,
    // rust: right: (pad + w / 2.0) as i32,
    // rust: bottom: 0,
}
    // rust: DrawTextW(
    // rust: hdc,
    // rust: wide.as_ptr(),
    // rust: wide.len() as i32,
    // rust: &mut rect,
    // rust: DT_LEFT | DT_WORDBREAK | DT_CALCRECT,
    // rust: );
    // rust: let height = rect.bottom.max(line as i32);
    // rust: let rows = ((height as f32 / line).ceil() as usize).max(1);
            // The block may only grow past the top before anything is drawn
            // (a newest line wider than the whole screen on a tiny window);
            // once something is there, older lines stop.
    // rust: if drawn + rows > max_rows && drawn > 0 {
    // rust: break 'lines;
}
    // rust: rect.top = ((y - height as f32).max(0.0)) as i32;
    // rust: rect.bottom = y as i32;
    // rust: DrawTextW(
    // rust: hdc,
    // rust: wide.as_ptr(),
    // rust: wide.len() as i32,
    // rust: &mut rect,
    // rust: DT_LEFT | DT_WORDBREAK,
    // rust: );
    // rust: y -= height as f32;
    // rust: drawn += rows;
}
    // rust: SelectObject(hdc, old_mark);
    // rust: SelectObject(hdc, old_tagline);
    // rust: SelectObject(hdc, old_console);
    // rust: let _ = DeleteObject(mark);
    // rust: let _ = DeleteObject(tagline);
    // rust: let _ = DeleteObject(console);
        // The finished frame reaches the window as one copy.
    // rust: BitBlt(
    // rust: window_dc,
    // rust: rect.left,
    // rust: rect.top,
    // rust: rect.right - rect.left,
    // rust: rect.bottom - rect.top,
    // rust: hdc,
    // rust: rect.left,
    // rust: rect.top,
    // rust: SRCCOPY,
    // rust: );
    // rust: SelectObject(hdc, old_bitmap);
    // rust: let _ = DeleteObject(bitmap);
    // rust: let _ = DeleteDC(hdc);
    // rust: let _ = ReleaseDC(hwnd, window_dc);
}
}
