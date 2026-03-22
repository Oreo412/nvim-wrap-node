# nvim-wrap-node

Quickly wrap syntax nodes in Neovim using Tree-sitter.

This plugin lets you wrap the thing under your cursor (types, identifiers, expressions, etc.) and immediately continue typing the wrapper — making refactors like Result<T> or Ok(value) fast and fluid.

## ✨ Features

Wrap types, identifiers, and expressions

Works with nested structures

Uses Tree-sitter for context-aware behavior

Automatically places cursor for fast typing

Easily extensible per language

## 🚀 Demo / Examples
### Rust: Wrapping a type

Before:
```
HashMap<String, String>
```

Cursor on HashMap, press `<leader>`w:
```
<HashMap<String, String>>
 ^
 cursor here
```
Now just type:

```
Result<HashMap<String, String>>
```

### Rust: Nested wrapping

Before:
```
HashMap<String, String>
```
Cursor on inner String, press `<leader>`w:
```
HashMap<String, <String>>
                 ^
```
Type:
```
HashMap<String, Vec<String>>
```
Rust: Wrapping expressions

Before:
```
return output_map;
```

Cursor on output_map, press `<leader>`w:
```
return (output_map);
        ^
```

Type:
```
return Ok(output_map);
```
## 📦 Installation (Lazy.nvim)
```
return {
  "Oreo412/nvim-wrap-node",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("wrap-node").setup()

    vim.keymap.set("n", "<leader>w", function() --set to whatever keybinding you like!
      require("wrap-node").wrap_node()
    end, { desc = "Wrap node" })
  end,
}
```
## ⚙️ How It Works

Uses Tree-sitter to find the node under your cursor

Chooses wrapping characters based on language + context

Replaces the node with:
```
<node>
```
or
```
(node)
```
Moves cursor to the start so you can immediately type the wrapper

## 🧠 Language Support
Built-in: Rust

Rust has custom behavior:

Types → <...>

Expressions → (…)

Handles:

generic_type

type_identifier

type_arguments

primitive_type

scoped_identifier

## 🔧 Extending to Other Languages

You can add your own handler:

require("wrap-node").setup({
  handlers = {
    lua = function(node, t, parent)
      return node, "(", ")"
    end,
  },
})

A handler must return:

node, left, right

node: the Tree-sitter node to wrap

left: opening character(s)

right: closing character(s)

## 🛠 API
wrap_node()

Wraps the node under the cursor.

setup(opts)
require("wrap-node").setup({
  handlers = {
    -- custom language handlers
  }
})
## ⚠️ Requirements

Neovim ≥ 0.9 (Tree-sitter required)

nvim-treesitter

## 💡 Notes

Falls back to (node) if no handler exists

Does nothing in non-modifiable buffers

Starts insert mode automatically after wrapping

## 🤝 Contributing

Contributions are welcome!

Add support for new languages

Improve existing handlers

Report issues / edge cases

### 📜 License

MIT
