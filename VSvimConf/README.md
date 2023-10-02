# Visual Studio Vim (VS_VIM)
## Last Updated: 10/01/2023

Handle Ctrl + a,  Ctrl + c, and  Ctrl + o with vsvim in tools > options > vsvim > keyboard

you can try customizing your Visual Studio key bindings to map the up and down movements in Intellisense directly. Here's how:

Go to Tools > Options in the Visual Studio menu.

In the Options dialog, select Environment > Keyboard.

Under "Show commands containing", search for "Edit.LineDown".

Click on the "Press shortcut keys" textbox and press Ctrl-N.

Click "Assign" to set the new key binding.

Repeat the process for "Edit.LineUp" and press Ctrl-P as the shortcut key.

Neovim rec from Ty Overby https://github.com/tyoverby/nvim/tree/minimal
