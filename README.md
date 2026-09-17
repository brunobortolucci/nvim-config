# Configuração Neovim (NvChad)

Configuração pessoal do Neovim baseada no [NvChad](https://github.com/NvChad/NvChad) (v2.0), com foco em desenvolvimento **Go** e **Python**: LSP, formatação/linting automáticos, debug (DAP) e integração com o **Claude Code** direto do editor.

## Descrição

- **Base**: NvChad (tema `catppuccin`, gerenciador de plugins `lazy.nvim`).
- **Linguagens configuradas**: Go e Python, com LSP, formatação automática ao salvar (`BufWritePre`) e depuração via DAP.
- **Extras**: busca de arquivos (Telescope), árvore de arquivos (NvimTree), autocomplete (nvim-cmp), Treesitter e integração com o Claude Code (`claudecode.nvim`).

## Requisitos

Antes de instalar, garanta que você tem:

- **Neovim** ≥ 0.10 (recomendado a versão mais recente)
- **Git**
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** e **[fd](https://github.com/sharkdp/fd)** (usados pelo Telescope)
- Uma **[Nerd Font](https://www.nerdfonts.com/)** instalada e configurada no terminal (para os ícones)
- **[Node.js](https://nodejs.org/)** (necessário por alguns servidores LSP via Mason)
- **Go** e/ou **Python 3** instalados, caso vá usar as respectivas ferramentas de linguagem
- **[Claude Code](https://claude.com/claude-code)** instalado, se quiser usar a integração `claudecode.nvim`

Os LSPs, formatadores e linters (`gopls`, `pyright`, `ruff`, `black`, `mypy`, `gofumpt`, `goimports-reviser`, `golines`, `debugpy`) são instalados automaticamente pelo **Mason** na primeira abertura do Neovim.

## Instalação

> A configuração fica em `~/.config/nvim` (Linux/macOS) ou `%LOCALAPPDATA%\nvim` (Windows). Faça backup da sua configuração atual antes de sobrescrever.

### macOS

```bash
# Instalar dependências via Homebrew
brew install neovim ripgrep fd git node go python3

# Nerd Font (exemplo)
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Backup da config atual (se existir)
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clonar esta configuração
git clone <URL_DESTE_REPOSITORIO> ~/.config/nvim

# Abrir o Neovim (o lazy.nvim instala os plugins automaticamente)
nvim
```

### Linux

```bash
# Debian/Ubuntu (exemplo)
sudo apt update
sudo apt install neovim ripgrep fd-find git nodejs npm golang python3 python3-pip

# Nerd Font: baixe em https://www.nerdfonts.com/ e instale manualmente,
# ou via gerenciador de pacotes da sua distro.

# Backup da config atual (se existir)
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clonar esta configuração
git clone <URL_DESTE_REPOSITORIO> ~/.config/nvim

# Abrir o Neovim (o lazy.nvim instala os plugins automaticamente)
nvim
```

> Em distros baseadas em Arch, use `sudo pacman -S neovim ripgrep fd git nodejs npm go python`.

### Windows

Recomenda-se usar o **PowerShell** com [Scoop](https://scoop.sh/) ou [winget](https://learn.microsoft.com/windows/package-manager/winget/).

```powershell
# Instalar dependências (via winget)
winget install Neovim.Neovim
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install Git.Git
winget install OpenJS.NodeJS
winget install GoLang.Go
winget install Python.Python.3

# Nerd Font: baixe em https://www.nerdfonts.com/ e instale (ex.: JetBrainsMono NF)
# e configure-a no seu terminal (Windows Terminal, por exemplo)

# Backup da config atual (se existir)
Move-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.bak" -ErrorAction SilentlyContinue

# Clonar esta configuração
git clone <URL_DESTE_REPOSITORIO> "$env:LOCALAPPDATA\nvim"

# Abrir o Neovim (o lazy.nvim instala os plugins automaticamente)
nvim
```

> Alternativa: usar **WSL2** com Ubuntu e seguir as instruções da seção Linux.

Após a primeira abertura, execute `:MasonInstallAll` ou aguarde a instalação automática dos LSPs/formatadores listados no Mason, e `:Lazy sync` caso algum plugin não tenha sido baixado.

## Plugins configurados

Além dos plugins padrão do NvChad (Telescope, NvimTree, nvim-cmp, Treesitter, gitsigns, which-key, etc.), este setup adiciona:

| Plugin | Função |
|---|---|
| `williamboman/mason.nvim` | Instala automaticamente LSPs, formatadores e ferramentas de debug |
| `neovim/nvim-lspconfig` | Configuração dos servidores de linguagem |
| `nvimtools/none-ls.nvim` | Formatação e diagnósticos (Go/Python) via `null-ls` |
| `olexsmir/gopher.nvim` | Ferramentas específicas para Go (struct tags, `if err != nil`) |
| `mfussenegger/nvim-dap` | Debug Adapter Protocol (base do debug) |
| `dreamsofcode-io/nvim-dap-go` | Debug para Go |
| `mfussenegger/nvim-dap-python` | Debug para Python |
| `rcarriga/nvim-dap-ui` | Interface visual para o debug (DAP) |
| `nvim-neotest/nvim-nio` | Dependência assíncrona do DAP UI |
| `coder/claudecode.nvim` | Integração com o Claude Code dentro do Neovim |
| `sphamba/smear-cursor.nvim` | Anima o cursor com um efeito de "rastro" ao se mover |

### `smear-cursor.nvim`

Carregado com `lazy = false` (precisa iniciar junto com o Neovim, sem gatilho de `event`/`cmd`/`ft`). Opções aplicadas em `lua/custom/plugins.lua`:

| Opção | Valor | Padrão do plugin | Efeito |
|---|---|---|---|
| `stiffness` | `0.8` | `0.6` | Rastro mais rígido/rápido ao acompanhar o cursor |
| `trailing_stiffness` | `0.5` | `0.45` | Cauda do rastro um pouco mais "puxada" |
| `distance_stop_animating` | `0.5` | `0.1` | Para de animar mais cedo (ignora micro-movimentos) |
| `hide_target_hack` | `false` | — | Mantém o cursor real visível durante a animação |
| `smear_between_buffers` | `true` | `true` | Anima também ao trocar de buffer/janela |
| `smear_insert_mode` | `true` | `true` | Anima também no modo de inserção |

Demais opções disponíveis (não alteradas, usando o padrão do plugin): `smear_between_neighbor_lines`, `scroll_buffer_space`, `legacy_computing_symbols_support`, `stiffness_insert_mode`, `trailing_stiffness_insert_mode`, `damping`, `damping_insert_mode`, `time_interval`, `cursor_color`, `transparent_bg_fallback_color`. Veja a [documentação oficial](https://github.com/sphamba/smear-cursor.nvim) para a lista completa.

## LSP e ferramentas instaladas via Mason

**Go**
- `gopls` (LSP)
- `gofumpt`, `goimports-reviser`, `golines` (formatação, via null-ls)

**Python**
- `pyright` (LSP)
- `ruff` (LSP/lint)
- `black` (formatação, via null-ls)
- `mypy` (diagnósticos de tipos, via null-ls)

**Debug**
- `debugpy` (debug de Python)

A formatação é aplicada automaticamente ao salvar o arquivo (`BufWritePre`) para arquivos Go e Python.

## Mapeamentos de teclas (keymaps)

Tecla líder (`leader`) padrão do NvChad: `<Space>`.

### Go (`gopher.nvim`)

| Tecla | Ação |
|---|---|
| `<leader>gsj` | Adiciona struct tags JSON |
| `<leader>gsy` | Adiciona struct tags YAML |
| `<leader>gsr` | Remove struct tags JSON |
| `<leader>gie` | Insere bloco `if err != nil` |

### Debug (DAP)

| Tecla | Ação |
|---|---|
| `<leader>db` | Adiciona/remove breakpoint |
| `<leader>dc` | Continua/inicia o debug |
| `<leader>dus` | Abre sidebar de debug (scopes) |
| `<leader>dgt` | Debug do teste Go sob o cursor |
| `<leader>dgl` | Debug do último teste Go executado |
| `<leader>dpr` | Debug do método de teste Python sob o cursor |

### Claude Code (`claudecode.nvim`)

| Tecla | Ação |
|---|---|
| `<leader>ac` | Abre/fecha o Claude Code |
| `<leader>af` | Foca a janela do Claude Code |
| `<leader>ar` | Resume a última sessão do Claude |
| `<leader>aC` | Continua a conversa do Claude |
| `<leader>am` | Seleciona o modelo do Claude |
| `<leader>ab` | Adiciona o buffer atual ao contexto |
| `<leader>as` | Envia seleção visual para o Claude (modo visual) / adiciona arquivo (árvore de arquivos) |
| `<leader>aa` | Aceita diff sugerido pelo Claude |
| `<leader>ad` | Rejeita diff sugerido pelo Claude |

### Principais atalhos padrão do NvChad

| Tecla | Ação |
|---|---|
| `<leader>ff` | Buscar arquivos (Telescope) |
| `<leader>fw` | Buscar texto no projeto (live grep) |
| `<leader>fb` | Listar buffers abertos |
| `<leader>e` | Focar a árvore de arquivos (NvimTree) |
| `<leader>ch` | Abrir cheatsheet com todos os mapeamentos |
| `<leader>ra` | Renomear símbolo (LSP) |
| `<leader>ca` | Code action (LSP) |

> Para ver a lista completa de atalhos (incluindo os padrões do NvChad), use `<leader>ch` dentro do Neovim.
