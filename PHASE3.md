# Phase 3: Snippets, Treesitter и Git интеграция

## 📋 Обзор

Phase 3 добавляет мощные возможности для ускорения кодирования через snippet'ы, синтаксическое подсвечивание с помощью Treesitter и Git интеграцию для отслеживания изменений в реальном времени.

## 🎯 Основные компоненты Phase 3

### 3.1 Snippet'ы (LuaSnip уже добавлен в Phase 2.1!)
- **LuaSnip** - мощный движок для snippet'ов (уже интегрирован с nvim-cmp)
- **friendly-snippets** - большая библиотека готовых snippet'ов для всех языков
- **nvim-surround** - удобный плагин для работы с окружением (скобки, кавычки и т.д.)

### 3.2 Treesitter - Синтаксический анализ
- **nvim-treesitter** - интеграция Tree-sitter для лучшего понимания кода
- **nvim-treesitter-textobjects** - текстовые объекты на основе синтаксиса
- **nvim-treesitter-context** - отображение контекста функции в начале окна

### 3.3 Git интеграция
- **gitsigns.nvim** - показывает изменения на лету (added/modified/deleted lines)
- **vim-fugitive** - полная Git интеграция (diff, blame, log и т.д.)
- **diffview.nvim** - красивый интерфейс для просмотра изменений

## ✨ Детальное описание компонентов

### 3.1.1 LuaSnip Расширение

**Что это:**
- Движок для создания и использования code snippet'ов
- Поддержка переменных, динамических фрагментов, регулярных выражений
- Интеграция с nvim-cmp для автодополнения snippet'ов

**Что получит пользователь:**
```typescript
// Напишите "arrow" и нажмите <C-l> для расширения:
const myFunc = () => {
  // cursor здесь, готов к печати
};

// Или напишите "ifelse" для:
if (condition) {
  // code
} else {
  // code
}
```

**Файлы конфигурации:**
- `nvim/lua/plugins/friendly-snippets.lua` - плагин со snippet'ами
- `nvim/lua/snippets/` - пользовательские snippet'ы (опционально)

### 3.2.1 Treesitter

**Что это:**
- Parser для создания синтаксического дерева
- Позволяет Neovim лучше понимать структуру кода
- Основа для текстовых объектов и навигации

**Функции:**
- Лучшее синтаксическое подсвечивание
- Текстовые объекты (aa, ib, if, etc)
- Контекст функции в начале окна
- Инкрементальный выбор (gnn, grn, grm)

**Поддерживаемые языки:**
- TypeScript/JavaScript, Vue, PHP, HTML, CSS, JSON, YAML, Lua, Python, Go, Rust и 100+ других

**Файлы конфигурации:**
- `nvim/lua/plugins/treesitter.lua` - основная конфигурация
- `nvim/lua/plugins/treesitter-textobjects.lua` - текстовые объекты
- `nvim/lua/plugins/treesitter-context.lua` - контекст функции

### 3.2.2 Treesitter Textobjects

**Текстовые объекты:**
```vim
" Navigation
]m - перейти к следующему методу
[m - перейти к предыдущему методу
]c - перейти к следующему classу
[c - перейти к предыдущему classу

" Selection
af - select around function
if - select inside function
ac - select around class
ic - select inside class

" Swapping
<Leader>sm - swap method/parameter с соседним
```

**Примеры использования:**
```vim
caf   " change around function
dif   " delete inside function
vac   " visual select around class
```

### 3.3.1 Gitsigns

**Что это:**
- Показывает Git diff'ы в левой части окна (gutter)
- Отслеживает изменения в реальном времени
- Удобная навигация между изменениями

**Функции:**
- Цветные полосы для added/modified/deleted строк
- Быстрое отмотание изменений
- Просмотр diff'а для текущей строки
- Подсчёт статистики изменений

**Keybindings:**
```vim
]c - перейти к следующему change hunk
[c - перейти к предыдущему change hunk
<Leader>hs - stage hunk
<Leader>hu - undo last hunk
<Leader>hp - preview hunk
<Leader>hb - blame line
<Leader>hd - delete hunk
<Leader>hr - reset hunk
```

**Файлы конфигурации:**
- `nvim/lua/plugins/gitsigns.lua` - основная конфигурация

### 3.3.2 Vim Fugitive

**Что это:**
- Полная Git интеграция в Neovim
- Возможность выполнять git команды без выхода из редактора
- Просмотр истории, diff'ов, blame и т.д.

**Команды:**
```vim
:Git status      " показать статус
:Git add %       " добавить текущий файл
:Git commit      " сделать коммит
:Git blame       " показать кто и когда менял каждую строку
:Git log         " показать историю
:Git diff        " показать diff
:Gedit BRANCH    " переключиться на ветку
:Gdiffsplit      " показать diff текущего файла
```

**Файлы конфигурации:**
- `nvim/lua/plugins/fugitive.lua` - конфигурация Fugitive

### 3.3.3 Diffview

**Что это:**
- Красивый интерфейс для просмотра Git diff'ов
- Упрощает работу с большими изменениями
- Интеграция с Fugitive

**Команды:**
```vim
:DiffviewOpen           " открыть diff view
:DiffviewClose          " закрыть diff view
:DiffviewFileHistory    " историю изменений для текущего файла
:DiffviewFileHistory %  " историю для файла с процентом
```

**Keybindings:**
```vim
<Leader>gd - открыть diff view
<Leader>gf - история файла
```

**Файлы конфигурации:**
- `nvim/lua/plugins/diffview.lua` - конфигурация Diffview

## 🎯 Клавиатурные сокращения Phase 3

### Snippet'ы
| Сокращение | Описание |
|-------------|---------|
| `<C-l>` | Расширить snippet или перейти к следующему месту |
| `<C-h>` | Перейти к предыдущему месту в snippet |
| (уже было в Phase 2) | |

### Treesitter Navigation
| Сокращение | Описание |
|-------------|---------|
| `]m` | Перейти к следующему методу |
| `[m` | Перейти к предыдущему методу |
| `]c` | Перейти к следующему классу |
| `[c` | Перейти к предыдущему классу |
| `gnn` | Инкрементальный выбор (вниз) |
| `grn` | Инкрементальный выбор (соседний) |
| `grm` | Инкрементальный выбор (предыдущий) |

### Treesitter Textobjects
| Сокращение | Описание |
|-------------|---------|
| `af` | Select around function |
| `if` | Select inside function |
| `ac` | Select around class |
| `ic` | Select inside class |
| `a,` | Select around parameter |
| `i,` | Select inside parameter |

### Git - Gitsigns
| Сокращение | Описание |
|-------------|---------|
| `]c` | Перейти к следующему change |
| `[c` | Перейти к предыдущему change |
| `<Leader>hs` | Stage hunk |
| `<Leader>hu` | Undo hunk |
| `<Leader>hp` | Preview hunk |
| `<Leader>hb` | Blame line |
| `<Leader>hd` | Delete hunk |
| `<Leader>hr` | Reset hunk |
| `<Leader>hl` | Toggle line blame |

### Git - Fugitive
| Сокращение | Описание |
|-------------|---------|
| `<Leader>gs` | Git status (:Git) |
| `<Leader>ga` | Git add (текущий файл) |
| `<Leader>gc` | Git commit |
| `<Leader>gb` | Git blame |
| `<Leader>gL` | Git log |
| `<Leader>gd` | Diff split |

### Git - Diffview
| Сокращение | Описание |
|-------------|---------|
| `<Leader>gv` | Открыть DiffView |
| `<Leader>gV` | DiffView File History |

## 📁 Структура файлов Phase 3

```
nvim/lua/
├── plugins/
│   ├── friendly-snippets.lua      # Библиотека snippet'ов
│   ├── treesitter.lua             # Treesitter конфигурация
│   ├── treesitter-textobjects.lua # Treesitter textobjects
│   ├── treesitter-context.lua     # Treesitter context
│   ├── gitsigns.lua               # Gitsigns конфигурация
│   ├── fugitive.lua               # Fugitive конфигурация
│   └── diffview.lua               # Diffview конфигурация
└── snippets/                      # Пользовательские snippet'ы (опционально)
    ├── typescript.lua
    ├── javascript.lua
    └── ...
```

## 🚀 Использование

### Snippet'ы в действии

1. **Быстрое создание функции:**
   ```
   Напишите: arrow<Tab>
   Получите:
   const myFunc = () => {
     |
   }
   ```

2. **Условный оператор:**
   ```
   Напишите: ifelse<Tab>
   Получите:
   if (|) {

   } else {

   }
   ```

3. **Цикл:**
   ```
   Напишите: for<Tab>
   Получите:
   for (const | of ) {

   }
   ```

### Git в действии

1. **Просмотр изменений:**
   ```vim
   :DiffviewOpen          " открыть в новом окне
   ]c / [c                " перемещение между hunks
   <Leader>hp             " preview изменения
   ```

2. **Commit с сообщением:**
   ```vim
   :Git add .             " добавить все
   :Git commit            " открыть окно коммита
   i (insert mode)        " напишите сообщение
   :wq                    " сохранить и выйти
   ```

3. **Blame:**
   ```vim
   :Git blame             " кто менял каждую строку
   :Gblame                " fugitive интеграция
   ```

### Treesitter в действии

1. **Навигация между функциями:**
   ```vim
   ]m                     " следующая функция
   [m                     " предыдущая функция
   af                     " select around function
   daf                    " delete entire function
   ```

2. **Инкрементальный выбор:**
   ```vim
   gnn                    " выбрать выражение
   gnn                    " выбрать родительское выражение
   gnn                    " выбрать ещё больше
   ```

## 📝 Примеры использования

### Пример 1: Быстрое создание компонента Vue
```typescript
// Напишите "component" и <Tab>
<template>
  <div>|</div>
</template>

<script setup lang="ts">
// code
</script>

<style scoped>
/* styles */
</style>
```

### Пример 2: Работа с Git
```vim
" 1. Просмотр изменений
:DiffviewOpen
" 2. Навигация между hunks
]c / [c
" 3. Просмотр деталей
<Leader>hp
" 4. Stage конкретного hunk
<Leader>hs
" 5. Commit
:Git commit
```

### Пример 3: Рефакторинг функции
```vim
" Курсор внутри функции
af          " select around function
c           " change (удалить и перейти в insert mode)
" напишите новую функцию
```

## ⚙️ Конфигурация

### Добавить собственный snippet
В `nvim/lua/snippets/typescript.lua`:
```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("typescript", {
    s("mysnippet", {
        t("const "),
        i(1, "name"),
        t(" = "),
        i(2, "value"),
        t(";"),
    }),
})
```

### Отключить Treesitter для большого файла
```vim
" Можно отключить автоматически если файл > 100KB
" Конфигурируется в treesitter.lua
```

### Настроить цвета Gitsigns
```lua
-- В gitsigns.lua
signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
}
```

## 🔍 Поддерживаемые языки Treesitter

Phase 3 будет устанавливать parsers для:
- TypeScript, JavaScript, Vue, TSX, JSX
- PHP, HTML, CSS, SCSS
- JSON, YAML, TOML
- Lua, Python, Go, Rust
- Markdown, Bash
- SQL и многое другое

## 💡 Советы и трюки

### Быстрый переход между методами
```vim
" Если у вас класс с множеством методов:
]m ]m ]m          " быстро перемещаться между ними
af                " выделить весь метод
```

### Просмотр истории файла
```vim
" Посмотреть как менялся файл:
:DiffviewFileHistory
" Использовать q для выхода
```

### Быстрый stage/unstage
```vim
" В гит-буфере можно быстро stage/unstage файлы:
" - на файле нажать 's' для stage
" - нажать 'u' для unstage
```

### Просмотр контекста функции
```vim
" Когда вы внизу большой функции:
" Treesitter-context показывает в начале окна
" какой функции/класса вы находитесь
```

## 📚 Ресурсы

- [LuaSnip GitHub](https://github.com/L3MON4D3/LuaSnip)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [nvim-treesitter GitHub](https://github.com/nvim-treesitter/nvim-treesitter)
- [gitsigns.nvim GitHub](https://github.com/lewis6991/gitsigns.nvim)
- [vim-fugitive GitHub](https://github.com/tpope/vim-fugitive)
- [diffview.nvim GitHub](https://github.com/sindrets/diffview.nvim)

## 🎯 Стратегия реализации Phase 3

### Tier 1: Основное (неделя 1)
1. Добавить friendly-snippets к уже установленному LuaSnip
2. Установить и настроить nvim-treesitter
3. Добавить treesitter-textobjects

### Tier 2: Git интеграция (неделя 2)
4. Установить и настроить gitsigns
5. Добавить vim-fugitive
6. Настроить основные keybindings

### Tier 3: Улучшения (неделя 3)
7. Добавить diffview
8. Добавить treesitter-context
9. Создать пользовательские snippet'ы для проекта

### Tier 4: Оптимизация (неделя 4)
10. Оптимизация производительности
11. Добавление дополнительных snippet'ов
12. Полное тестирование

## ✅ Заключение

Phase 3 делает Neovim IDE полнофункциональной средой для профессионального программирования с:
- Быстрым созданием кода через snippet'ы
- Глубоким пониманием кода через Treesitter
- Удобной Git интеграцией

## 📊 Версия и статус

**Версия**: 3.0.0 (планируется)
**Дата**: Ноябрь 2024
**Статус**: In Development (в разработке)

---

**Предыдущая фаза**: Phase 2.1 (LSP и интеллектуальные возможности)
**Следующая фаза**: Phase 4 (Debug, Terminal, Additional integrations)
