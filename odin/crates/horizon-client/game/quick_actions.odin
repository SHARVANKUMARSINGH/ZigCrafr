//! Transpiled from Horizon Rust crate
package horizon_client_quick_actions

import "core:fmt"
import "core:mem"
import "core:math"

// The Quick Actions dialog (`key.quickActions`, default G), read the way
// `Minecraft.getQuickActionsDialog` reads it from the server's synchronized
// `minecraft:dialog` registry and `minecraft:quick_actions` tag:
//
// - an empty tag opens nothing,
// - one dialog opens itself,
// - several open the `minecraft:quick_actions` dialog (a `dialog_list` over
//   the same tag).
//
// `handleKeybinds` then shows it with `showDialog(holder, gui.screen())`; the
// data comes from the pack stack, so a world's data packs supply it.
// use super::Game;
// use horizon_world::nbt::Tag;

    // rust: impl Game<'_> {
    // `Minecraft.getQuickActionsDialog`: the dialogs the tag names, from
    // `RegistryAccess.lookupOrThrow(Registries.DIALOG)`.
quick_actions_dialog :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let registries = &self.remote.as_ref()?.registries;
    // rust: let dialogs = registries.registries.get("minecraft:dialog")?;
    // rust: let tag = registries.dialog_tags.get("minecraft:quick_actions")?;
    // rust: match tag.len() {
    // rust: 0 => None,
    // rust: 1 => {
    // rust: let i = usize::try_from(tag[0]).ok()?;
    // rust: dialogs.get(i)?.1.clone()
}
            // `Dialogs.QUICK_ACTIONS`: the dialog list over the same tag.
    // rust: _ => Some(
    // rust: dialogs
    // rust: .iter()
    // rust: .find(|(name, _)| name == "minecraft:quick_actions")?
    // rust: .1
    // rust: .clone()?,
    // rust: ),
}
}

    // `key.quickActions`: only open if the tag names a dialog.
    // rust: pub(super) fn has_quick_actions(&self) -> bool {
    // rust: self.quick_actions_dialog().is_some()
}

    // `getQuickActionsDialog().ifPresent(showDialog(holder, gui.screen()))`.
    // rust: pub(super) fn open_quick_actions(&mut self) {
    // rust: if let Some(dialog) = self.quick_actions_dialog() {
    // rust: self.show_dialog(&dialog);
}
}
}
