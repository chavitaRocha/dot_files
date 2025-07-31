# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

VitaVim is a modern Neovim configuration built on the Lazy.nvim plugin manager. The configuration follows a modular architecture:

- **Entry Point**: `init.lua` - Loads core modules in sequence (options → keymaps → commands → lazy)
- **Core Config**: `lua/config/` - Essential configuration modules
- **Plugin System**: `lua/plugins/` - Individual plugin configurations loaded via Lazy.nvim's spec import
- **After Scripts**: `after/` - Filetype-specific configurations and post-load customizations
- **Snippets**: `snippets/` - Custom code snippets in JSON format

## Key Technologies & Frameworks

- **Plugin Manager**: Lazy.nvim with automatic installation and lazy loading
- **LSP**: Full language server integration via nvim-lspconfig with Mason for automatic installation
- **Completion**: Blink.cmp as the completion engine with LuaSnip for snippets
- **AI Integration**: ClaudeCode.nvim plugin for AI-powered development assistance
- **File Management**: Snacks.nvim picker for fuzzy finding and file operations
- **UI Framework**: Combination of Snacks.nvim, Which-key, and custom UI plugins

## Plugin Configuration Pattern

All plugins follow Lazy.nvim's specification format in `lua/plugins/`:
```lua
return {
  "author/plugin-name",
  dependencies = { "dependency1", "dependency2" },
  opts = { /* plugin options */ },
  keys = { /* keybindings */ },
  config = function() /* custom setup */ end,
}
```

## Language Server Support

Configured LSP servers (via Mason):
- **JavaScript/TypeScript**: vtsls, eslint, biome
- **Go**: gopls
- **Lua**: lua_ls with lazydev for Neovim development
- **C#**: csharp_ls (omnisharp commented out)
- **Web**: jsonls, cssls, tailwindcss
- **Utilities**: typos_lsp

## Key Keymaps & Commands

### Core Navigation
- Leader key: `<Space>`
- File operations: `<leader><space>` (smart finder), `<leader>e` (explorer)
- Buffers: `<leader>,` (buffer picker), `<leader>bd` (delete buffer)
- Search: `<leader>/` (grep), `<leader>sg` (grep with exclusions)

### AI Integration (ClaudeCode)
- `<leader>ac` - Toggle Claude
- `<leader>af` - Focus Claude
- `<leader>ar` - Resume Claude session
- `<leader>ab` - Add current buffer to Claude context
- `<leader>as` - Send visual selection to Claude

### LSP & Development
- `gd` - Go to definition (via Snacks picker)
- `gr` - Find references
- `<leader>f` - Format buffer (Conform.nvim)
- `<leader>k` - Show diagnostics
- Auto-format on save enabled

### Git Integration
- `<leader>gg` - Lazygit
- `<leader>gb` - Git branches
- `<leader>gl` - Git log
- Git signs displayed in sign column

## Formatting & Linting

Uses Conform.nvim with format-on-save:
- **JavaScript/TypeScript**: biome → prettier (stop after first)
- **Lua**: stylua
- **JSON**: jq → biome → prettier (stop after first)
- **C#**: csharpier (configured but commented out)

## Development Workflow

1. **Plugin Management**: Use `:Lazy` to manage plugins
2. **LSP Management**: Mason handles LSP server installation automatically
3. **File Navigation**: Use `<leader><space>` for intelligent file finding
4. **AI Development**: Integrate ClaudeCode for AI-powered coding assistance
5. **Git Workflow**: Built-in Lazygit integration with `<leader>gg`

## Special Features

### Custom Functions
- React hook dependency extraction: `<leader>fu` - Extracts exhaustive dependencies from biome diagnostics
- Clipboard integration: Custom yank-to-clipboard functionality for macOS
- Smart terminal: `<C-/>` toggles terminal with proper escape handling

### UI Enhancements
- Incline: Shows filename in top-right of windows
- No Neck Pain: Distraction-free mode with `<leader>dm`
- Zen mode: `<leader>z` for focused writing
- Visual Multi: Multiple cursor support

### Performance Optimizations
- Change detection disabled in Lazy.nvim
- Animations disabled via snacks configuration
- Smart loading of plugins based on events and filetypes