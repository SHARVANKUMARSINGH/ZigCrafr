//! Transpiled from Horizon Rust crate
package horizon_client_container_screen

import "core:fmt"
import "core:mem"
import "core:math"

// The mouse handling every survival and container screen shares
// (`AbstractContainerScreen.mouseClicked` / `mouseReleased`): which slot id
// a click targets (-999 outside the window, `hasClickedOutside` with the
// recipe book's own rule) and which `ContainerInput` it sends. Shift is
// the event's own modifiers (`InputWithModifiers.hasShiftDown`: the
// physical Shift keys, never the remapped or toggled sneak key).

// use crate::menu::Input;

// The screen's window: `leftPos`, `topPos`, `imageWidth`, `imageHeight`.
Image :: struct {
    left: i32,
    top: i32,
    width: i32,
    height: i32,
}

// The recipe book of an `AbstractRecipeBookScreen`.
Book :: struct {
    // `RecipeBookComponent.isVisible`.
    visible: bool,
    // `selectedTab.isHoveredOrFocused()`.
    selected_tab_hovered: bool,
}

// `RecipeBookComponent.IMAGE_WIDTH`.
BOOK_WIDTH :: 147

outside :: proc(mx: f64, my: f64, image: Image) -> b {
    // Ported from Horizon
    return {}
}
    // rust: mx < f64::from(image.left)
    // rust: || my < f64::from(image.top)
    // rust: || mx >= f64::from(image.left + image.width)
    // rust: || my >= f64::from(image.top + image.height)
}

// `AbstractContainerScreen.hasClickedOutside`, or
// `AbstractRecipeBookScreen.hasClickedOutside` when the screen has a book
// (`RecipeBookComponent.hasClickedOutside`: a click on the book, or with
// its selected tab hovered, is not outside).
clicked_outside :: proc(mx: f64, my: f64, image: Image, book: Maybe(Book)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let out = outside(mx, my, image);
    // rust: let Some(book) = book else {
    // rust: return out;
}
    // rust: let book_outside = !book.visible || {
    // rust: let on_book = f64::from(image.left - BOOK_WIDTH) < mx
    // rust: && mx < f64::from(image.left)
    // rust: && f64::from(image.top) < my
    // rust: && my < f64::from(image.top + image.height);
    // rust: out && !on_book && !book.selected_tab_hovered
}
    // rust: book_outside && out
}

// What a click points at: a slot, outside the window (slot id -999), or
// neither (slot id -1).
Target :: enum {
    Slot(S),
    Outside,
    Nothing,
}

    // rust: impl<S> Target<S> {
    // Outside wins over a hovered slot, as in `mouseClicked`.
of :: proc(slot: Maybe(S), outside: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: _ if outside => Self::Outside,
    // rust: Some(s) => Self::Slot(s),
    // rust: None => Self::Nothing,
}
}
}

// The left, right and middle buttons (SDL's 1, 3 and 2).
Button :: enum {
    Left,
    Right,
    Middle,
}

    // rust: impl Button {
    // `getContainerClickButton`: the button a menu click carries.
menu_button :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Left => 0,
    // rust: Self::Right => 1,
    // rust: Self::Middle => 2,
}
}
}

// The input state `mouseClicked`/`mouseReleased` keep between events.
Clicks :: struct {
    // `isQuickCrafting` with `quickCraftingButton`.
    quick_crafting: Maybe(Button),
    skip_next_release: bool,
}

// What a release does.
Release :: enum {
    // `slotClicked` with this input on the release's target.
    Click(Input),
    // `quickCraftToSlots` over the dragged slots.
    QuickCraft,
    Nothing,
}

    // rust: impl Clicks {
    // A quick craft drag in progress, and the button that started it.
quick_crafting :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.quick_crafting
}

    // A press another screen control handled (such as a book button or
    // double click's `PICKUP_ALL`): its release clicks nothing more.
skip_release :: proc(self: ^Self) {
}
    // rust: self.quick_crafting = None;
    // rust: self.skip_next_release = true;
}

    // The screen that takes the pointer over starts with its own state:
    // `AbstractContainerScreen` holds `isQuickCrafting` and the drag it
    // belongs to on the screen, so a screen that opens (or closes) drops
    // them. A press whose release never arrived -- the pointer left the
    // window -- would otherwise keep the drag running, and `press` answers
    // `None` for every later press, so the quick move and the clicks go
    // dead on every screen after it.
cancel_drag :: proc(self: ^Self) {
}
    // rust: self.quick_crafting = None;
    // rust: self.skip_next_release = false;
}

    // `mouseClicked` (no double click): the `slotClicked` input it sends on
    // `target`, if any. A press holding a stack starts a quick craft drag
    // instead. `cloning` is `keyPickItem` with infinite materials.
    // rust: pub fn press<S>(
    // rust: &mut self,
    // rust: target: &Target<S>,
    // rust: button: Button,
    // rust: carried_empty: bool,
    // rust: shift: bool,
    // rust: cloning: bool,
    // rust: ) -> Option<Input> {
    // rust: self.skip_next_release = false;
    // rust: if button == Button::Middle && !cloning {
    // rust: return None;
}
    // rust: if matches!(target, Target::Nothing) || self.quick_crafting.is_some() {
    // rust: return None;
}
    // rust: if !carried_empty {
    // rust: self.quick_crafting = Some(button);
    // rust: return None;
}
    // rust: self.skip_next_release = true;
    // rust: Some(if cloning {
    // rust: Input::Clone
    // rust: } else if shift && !matches!(target, Target::Outside) {
    // rust: Input::QuickMove
    // rust: } else if matches!(target, Target::Outside) {
    // rust: Input::Throw
    // rust: } else {
    // rust: Input::Pickup
    // rust: })
}

    // `mouseReleased` (no double click). `dragged` is whether the quick
    // craft drag collected any slots; `pick_item` is the release of the
    // `keyPickItem` button.
    // rust: pub fn release<S>(
    // rust: &mut self,
    // rust: target: &Target<S>,
    // rust: button: Button,
    // rust: carried_empty: bool,
    // rust: dragged: bool,
    // rust: shift: bool,
    // rust: pick_item: bool,
    // rust: ) -> Release {
    // rust: if self.quick_crafting.is_some_and(|b| b != button) {
    // rust: self.quick_crafting = None;
    // rust: self.skip_next_release = true;
    // rust: return Release::Nothing;
}
    // rust: if self.skip_next_release {
    // rust: self.skip_next_release = false;
    // rust: return Release::Nothing;
}
    // rust: let quick_crafting = self.quick_crafting.take().is_some();
    // rust: if quick_crafting && dragged {
    // rust: Release::QuickCraft
    // rust: } else if carried_empty {
    // rust: Release::Nothing
    // rust: } else if pick_item {
    // rust: Release::Click(Input::Clone)
    // rust: } else if shift && !matches!(target, Target::Outside) {
    // rust: Release::Click(Input::QuickMove)
    // rust: } else {
    // rust: Release::Click(Input::Pickup)
}
}
}

    // rust: mod tests {
//     use super::*;

    // rust: const INV: Image = Image {
    // rust: left: 100,
    // rust: top: 50,
    // rust: width: 176,
    // rust: height: 166,
}

window_edges :: proc() {
}
    // rust: assert!(!clicked_outside(100.0, 50.0, INV, None));
    // rust: assert!(clicked_outside(99.9, 60.0, INV, None));
    // rust: assert!(clicked_outside(276.0, 60.0, INV, None));
    // rust: assert!(!clicked_outside(275.9, 215.9, INV, None));
}

the_open_book_is_not_outside :: proc() {
}
    // rust: let book = Book {
    // rust: visible: true,
    // rust: selected_tab_hovered: false,
}
    // rust: assert!(!clicked_outside(10.0, 100.0, INV, Some(book)));
    // rust: assert!(clicked_outside(-60.0, 100.0, INV, Some(book)));
    // rust: assert!(!clicked_outside(
    // rust: -60.0,
    // rust: 100.0,
    // rust: INV,
    // rust: Some(Book {
    // rust: selected_tab_hovered: true,
    // rust: ..book
    // rust: })
    // rust: ));
    // rust: let closed = Book {
    // rust: visible: false,
    // rust: ..book
}
    // rust: assert!(clicked_outside(10.0, 100.0, INV, Some(closed)));
}

a_carried_stack_thrown_outside :: proc() {
}
    // rust: let mut clicks = Clicks::default();
    // rust: let out = Target::<usize>::Outside;
    // rust: assert_eq!(clicks.press(&out, Button::Left, false, false, false), None);
    // rust: assert_eq!(
    // rust: clicks.release(&out, Button::Left, false, false, false, false),
    // rust: Release::Click(Input::Pickup)
    // rust: );
        // Shift never quick-moves outside, and an empty hand throws nothing.
    // rust: assert_eq!(
    // rust: clicks.press(&out, Button::Right, true, true, false),
    // rust: Some(Input::Throw)
    // rust: );
    // rust: assert_eq!(
    // rust: clicks.release(&out, Button::Right, true, false, true, false),
    // rust: Release::Nothing
    // rust: );
}

a_recipe_book_click_does_not_throw_a_carried_stack_after_the_layout_shifts :: proc() {
}
    // rust: let mut clicks = Clicks::default();
    // rust: let button = Target::<usize>::Nothing;
        // The book button consumes the press while the player carries a stack.
    // rust: assert_eq!(
    // rust: clicks.press(&button, Button::Left, false, false, false),
    // rust: None
    // rust: );
    // rust: clicks.skip_release();

        // Closing the book shifts the inventory before mouseReleased tests the
        // pointer again; it may now look like an outside click.
    // rust: assert_eq!(
    // rust: clicks.release(
    // rust: &Target::<usize>::Outside,
    // rust: Button::Left,
    // rust: false,
    // rust: false,
    // rust: false,
    // rust: false,
    // rust: ),
    // rust: Release::Nothing
    // rust: );
}

a_creative_page_release_does_not_throw_a_carried_stack :: proc() {
}
    // rust: let mut clicks = Clicks::default();
    // rust: let out = Target::<usize>::Outside;
    // rust: clicks.skip_release();
    // rust: assert_eq!(
    // rust: clicks.release(&out, Button::Left, false, false, false, false),
    // rust: Release::Nothing
    // rust: );
}

another_button_cancels_the_drag :: proc() {
}
    // rust: let mut clicks = Clicks::default();
    // rust: let slot = Target::Slot(3);
    // rust: clicks.press(&slot, Button::Left, false, false, false);
    // rust: assert_eq!(
    // rust: clicks.release(&slot, Button::Right, false, true, false, false),
    // rust: Release::Nothing
    // rust: );
    // rust: assert_eq!(
    // rust: clicks.release(&slot, Button::Left, false, true, false, false),
    // rust: Release::Nothing
    // rust: );
    // rust: assert_eq!(
    // rust: clicks.release(&slot, Button::Left, false, true, true, false),
    // rust: Release::Click(Input::QuickMove)
    // rust: );
}

    // A press whose release never arrives (the pointer left the window, or
    // the screen closed first) leaves `isQuickCrafting` set; the next screen
    // starts with its own state, as `AbstractContainerScreen` does, so the
    // reset the game runs on open/close makes clicks work again.
a_lost_release_does_not_wedge_the_next_screen :: proc() {
}
    // rust: let mut clicks = Clicks::default();
    // rust: let slot = Target::<usize>::Slot(3);
        // Pressed with a stack carried: a quick craft drag starts, and its
        // release is lost.
    // rust: assert_eq!(clicks.press(&slot, Button::Left, false, false, false), None);
    // rust: assert!(clicks.quick_crafting().is_some());
    // rust: assert_eq!(
    // rust: clicks.press(&slot, Button::Left, true, false, false),
    // rust: None,
    // rust: "the stuck drag swallows the next press"
    // rust: );
        // A new screen: fresh state, so the press is a normal click again.
    // rust: clicks = Clicks::default();
    // rust: assert!(clicks.quick_crafting().is_none());
    // rust: assert_eq!(
    // rust: clicks.press(&slot, Button::Left, true, false, false),
    // rust: Some(Input::Pickup)
    // rust: );
}

    // #1737: a press whose release never arrives (the pointer left the
    // window) leaves `isQuickCrafting` set, and `press` answers `None` for
    // every later press, so the Shift quick move and the clicks on the
    // inventory go dead. The drag belongs to the screen that has it
    // (`AbstractContainerScreen` holds `isQuickCrafting`), so the screen
    // that takes the pointer over drops it and the quick move works again.
a_lost_release_does_not_wedge_the_quick_move :: proc() {
}
    // rust: let mut clicks = Clicks::default();
    // rust: let slot = Target::<usize>::Slot(3);
        // Pressed with a stack carried: a quick craft drag starts, and its
        // release never arrives.
    // rust: assert_eq!(clicks.press(&slot, Button::Left, false, false, false), None);
    // rust: assert!(clicks.quick_crafting().is_some());
        // The stuck drag swallows the next press: the Shift quick move stops
        // working and the inventory stops answering.
    // rust: assert_eq!(clicks.press(&slot, Button::Right, true, true, false), None);
        // The screen that takes the pointer over starts with its own state.
    // rust: clicks.cancel_drag();
    // rust: assert!(clicks.quick_crafting().is_none());
        // The quick move works again.
    // rust: assert_eq!(
    // rust: clicks.press(&slot, Button::Right, true, true, false),
    // rust: Some(Input::QuickMove)
    // rust: );
    // rust: assert_eq!(
    // rust: clicks.press(&slot, Button::Left, true, false, false),
    // rust: Some(Input::Pickup)
    // rust: );
}
}
