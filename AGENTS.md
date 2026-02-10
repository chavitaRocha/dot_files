# Agent Guidelines for Dotfiles Repository

## Build/Lint/Test Commands
- **No traditional build process** - This is a configuration repository
- **Validation**: Run `stow -n .` to dry-run symlink creation
- **Lua syntax check**: `luacheck .config/**/*.lua` (if luacheck installed)
- **Shell script validation**: `shellcheck scripts/*` (if shellcheck installed)

## Code Style Guidelines

### Lua (Neovim/Hammerspoon configs)
- Use 2-space indentation
- Single quotes for strings: `'string'`
- Double quotes for strings containing single quotes
- Use `local` for all variable declarations
- Table syntax: `table.key` preferred over `table['key']`
- Function definitions: `function name()` or `local function name()`
- Comments: `-- comment` for single line, no multi-line comments
- No trailing whitespace
- Empty line between logical sections

### Shell Scripts
- Use `#!/bin/bash` or `#!/bin/zsh` shebang
- 2-space indentation for consistency
- Use `local` for bash variables when possible
- Error handling: `set -euo pipefail`
- Functions: `function_name() { ... }`

### TOML/JSON Configuration Files
- 2-space indentation
- Consistent key ordering (alphabetical when possible)
- Comments for non-obvious configurations

## Naming Conventions
- **Files**: lowercase with hyphens: `keymaps.lua`, `theme.lua`
- **Variables**: snake_case for Lua: `local config_table`
- **Functions**: snake_case: `setup_keymaps()`
- **Directories**: lowercase with hyphens: `config/`, `themes/`

## Import/Require Patterns
- Lua: `local module = require 'module.name'`
- Relative requires: `require 'plugins.theme'`
- Group requires at top of file

## Error Handling
- Lua: Use `pcall()` for potentially failing operations
- Shell: `||` operators for fallbacks
- Graceful degradation for missing dependencies

## File Organization
- Group related functionality in separate files
- Use `init.lua` as main entry point
- Keep configuration files focused and single-purpose
- Use `.gitignore` to exclude generated/temporary files

## Testing Approach
- Manual testing of configurations
- Validate syntax before committing
- Test in isolated environment when possible
- Document breaking changes in commit messages

## Commit Message Style
- `feat: add new keybinding for buffer navigation`
- `fix: correct typo in hammerspoon config`
- `docs: update README with installation instructions`
- `refactor: reorganize plugin configurations`

## No Cursor Rules or Copilot Instructions Found
- No `.cursor/rules/` directory
- No `.cursorrules` file
- No `.github/copilot-instructions.md`
