{ inputs
, config
, lib
, pkgs
, ...
}:
let
  # Use Stylix palette if present; otherwise fall back to Catppuccin Mocha background
  notifyBg = lib.attrByPath [ "lib" "stylix" "colors" "base01" ] "1e1e2e" config;
in
{
  # Importação moderna do módulo Nixvim no Home Manager para unstable
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Core editor options
    opts = {
      number = true;
      relativenumber = false;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      termguicolors = true;
      signcolumn = "yes";
      updatetime = 200;
      cursorline = true;
      spell = true;
      spelllang = [ "en" ];
      clipboard = "unnamedplus";
    };

    # Theme: Catppuccin (mocha)
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = false;
      };
    };

    plugins = {
      # UI and visuals
      web-devicons.enable = true;
      lualine = {
        enable = true;
        settings = {
          options = { theme = "catppuccin"; };
        };
      };
      bufferline.enable = true;
      indent-blankline.enable = true;
      colorizer.enable = true; 
      illuminate.enable = true;

      # File tree
      neo-tree.enable = true;

      # Fuzzy finder
      telescope.enable = true;

      # Treesitter - Configuração limpa sem chamar módulos depreciados
      treesitter = {
        enable = true;
        settings = {
          highlight = { enable = true; };
          ensure_installed = [ "nix" "lua" "c" "cpp" "python" "bash" "markdown" ];
        };
      };

      # Project management
      project-nvim.enable = true;

      # Notifications and UI polish
      notify.enable = true;
      noice.enable = true;

      # Startup dashboard
      alpha = {
        enable = true;
        theme = "dashboard";
      };

      # Git integrations
      gitsigns.enable = true;
      diffview.enable = true;

      # Motions and editing helpers
      hop.enable = true;
      leap.enable = true;
      vim-surround.enable = true;
      comment.enable = true;
      which-key.enable = true;

      # Autopairs
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          enable_check_bracket_line = false;
          fast_wrap = {
            enable = true;
            map = "<M-e>";
            chars = [ "{" "[" "(" "\"" "'" "`" ];
          };
        };
      };

      # Terminal
      toggleterm = {
        enable = true;
        settings = { direction = "float"; };
      };

      # Diagnostics UI
      trouble.enable = true;

      # Markdown preview
      markdown-preview.enable = true;

      # Completion and snippets
      cmp = {
        enable = true;
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;

      luasnip.enable = true;
      friendly-snippets.enable = true;

      # Signature help
      lsp-signature.enable = true;

      # LSP configuration - Isolado para contornar o bug do linux-kernel
      lsp = {
        enable = true;
        servers = {}; 
        keymaps = {
          diagnostic = {
            "<leader>dl" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
        };
      };

      # Formatter: conform.nvim
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixpkgs_fmt" ];
            lua = [ "stylua" ];
            javascript = [ "prettierd" ];
            typescript = [ "prettierd" ];
            css = [ "prettierd" ];
            html = [ "prettierd" ];
            markdown = [ "prettierd" ];
            sh = [ "shfmt" ];
          };
          format_on_save = {
            lsp_fallback = true;
          };
        };
      };
    };

    # Keymaps
    keymaps = [
      {
        key = "jk";
        mode = [ "i" ];
        action = "<ESC>";
        options.desc = "Exit insert mode";
      }
      {
        key = "<leader>ff";
        mode = [ "n" ];
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Search files by name";
      }
      {
        key = "<leader>lg";
        mode = [ "n" ];
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Search files by contents";
      }
      {
        key = "<leader>fe";
        mode = [ "n" ];
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "File browser toggle";
      }
      {
        key = "<leader>t";
        mode = [ "n" ];
        action = "<cmd>ToggleTerm<CR>";
        options.desc = "Toggle terminal";
      }
      {
        key = "<leader>.";
        mode = [ "n" ];
        action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        options.desc = "Comment line";
      }
      {
        key = "<leader>.";
        mode = [ "v" ];
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        options.desc = "Comment selection";
      }
      {
        key = "<leader>dj";
        mode = [ "n" ];
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options.desc = "Go to next diagnostic";
      }
      {
        key = "<leader>dk";
        mode = [ "n" ];
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options.desc = "Go to previous diagnostic";
      }
      {
        key = "<leader>dl";
        mode = [ "n" ];
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options.desc = "Show diagnostic details";
      }
      {
        key = "<leader>dt";
        mode = [ "n" ];
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Toggle diagnostics list";
      }
      {
        key = "<F1>";
        mode = [ "n" "i" "v" "x" "s" "o" "t" "c" ];
        action = "<Nop>";
        options.desc = "Disable accidental F1 help";
      }
      {
        key = "<leader>h";
        mode = [ "n" ];
        action = ":help<Space>";
        options = { desc = "Open :help prompt"; nowait = true; };
      }
      {
        key = "<leader>H";
        mode = [ "n" ];
        action = ":help <C-r><C-w><CR>";
        options.desc = "Help for word under cursor";
      }
    ];

    # Runtime tools e Language Servers injetados de forma segura
    extraPackages = with pkgs; [
      ripgrep
      fd
      bat
      wl-clipboard
      lazygit
      nixd
      hyprls
      typescript-language-server
      typescript
      vscode-langservers-extracted
      pyright
      lua-language-server
      zls
      marksman
      clang-tools
      prettierd
      stylua
      shfmt
      nixpkgs-fmt
      figlet
      toilet
    ];

    extraConfigLua = ''
      -- Inicializar servidores LSP manualmente via Lua pura
      local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
      if lspconfig_ok then
        local manual_servers = { "nixd", "lua_ls", "pyright", "ts_ls", "html", "cssls", "clangd", "marksman" }
        for _, lsp in ipairs(manual_servers) do
          lspconfig[lsp].setup({})
        end
      end

      -- Configuração básica de diagnósticos
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        update_in_insert = true,
        severity_sort = true,
        underline = true,
        signs = true,
      })

      -- Mapeamentos globais quando o LSP conecta
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map('n', 'K', vim.lsp.buf.hover, 'Hover docs')
          map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Goto implementation')
          map('n', 'gr', vim.lsp.buf.references, 'References')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        end,
      })

      -- Notify background usando Stylix palette
      local ok, notify = pcall(require, 'notify')
      if ok then
        notify.setup({ background_colour = "#${notifyBg}" })
        vim.notify = notify
      end

      -- nvim-cmp + autopairs
      do
        local ok_cmp, cmp = pcall(require, "cmp")
        local ok_ap, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if ok_cmp and ok_ap then
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
      end

      -- Dashboard Inicial (Alpha)
      do
        local ok_alpha, alpha = pcall(require, "alpha")
        if ok_alpha then
          local dashboard = require("alpha.themes.dashboard")
          local header_lines = {
            " _  _ ___  __  __  ___   ___   ____  ",
            "| \\ | |_ _| \\ \\/ / / _ \\ / _ \\|  _ \\ ",
            "|  \\| || |   \\  / | | | | | | || | | |",
            "| |\\  || |   /  \\ | |_| | |_| || |_| |",
            "|_| \\_|___| /_/\\_\\ \\___/ \\___/ |____/ ",
          }
          dashboard.section.header.val = header_lines
          dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
            dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
            dashboard.button("g", "󰺮  Live grep", ":Telescope live_grep<CR>"),
            dashboard.button("n", "  New file", ":enew<CR>"),
            dashboard.button("e", "  File browser", ":Neotree toggle<CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
          }
          local v = vim.version()
          dashboard.section.footer.val = string.format("NixVim • Neovim %d.%d.%d", v.major, v.minor, v.patch)
          dashboard.opts.opts.noautocmd = true
          alpha.setup(dashboard.config)
        end
      end
    '';
  };
}


