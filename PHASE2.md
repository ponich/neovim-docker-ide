# Phase 2: LSP и интеллектуальные возможности

## 📋 Обзор

Phase 2 реализует полную интеграцию Language Server Protocol (LSP) в Neovim Docker IDE, предоставляя интеллектуальный анализ кода, автодополнение и навигацию для всех поддерживаемых языков.

## ✨ Реализованные компоненты

### 2.1 LSP Base (Основа)
- **nvim-lspconfig** - конфигурация и управление языковыми серверами
- **mason.nvim** - менеджер для установки и управления LSP серверами
- **mason-lspconfig.nvim** - интеграция mason с lspconfig для автоматической установки

### 2.2 Автодополнение (Autocompletion)
- **nvim-cmp** - мощный движок автодополнения с множеством источников
- **cmp-nvim-lsp** - интеграция с LSP для предложений кода
- **cmp-buffer** - автодополнение из текущего буфера
- **cmp-path** - автодополнение путей файлов
- **cmp-cmdline** - автодополнение в командной строке
- **LuaSnip** - движок для snippet'ов с поддержкой расширений
- **cmp_luasnip** - интеграция LuaSnip с nvim-cmp

### 2.3 Поддерживаемые языки

#### TypeScript / JavaScript
- **Сервер**: ts_ls (TypeScript Language Server)
- **Функции**:
  - Проверка типов
  - Автодополнение
  - Быстрое исправление ошибок
  - Переименование символов
  - Подсказки по типам параметров

#### Vue.js
- **Сервер**: volar (@vue/language-server)
- **Функции**:
  - Поддержка синтаксиса Vue 3
  - Проверка типов в шаблонах
  - Автодополнение компонентов
  - Интеграция с TypeScript

#### PHP
- **Сервер**: intelephense
- **Функции**:
  - Проверка кода
  - Автодополнение методов и свойств
  - Навигация по классам и функциям
  - Встроенная поддержка Xdebug

#### HTML / CSS / JSON / YAML
- **HTML**: html-languageserver
- **CSS**: cssls
- **JSON**: jsonls (с поддержкой JSON Schema)
- **YAML**: yamlls (с поддержкой схем GitHub Actions, Docker Compose)

#### Lua
- **Сервер**: lua_ls
- **Функции**:
  - Поддержка Neovim API
  - Проверка синтаксиса
  - Автодополнение встроенных функций

### 2.4 Диагностика и UI

#### Диагностические знаки
- ✖ Error (красный)
- ⚠ Warning (оранжевый)
- 💡 Hint (синий)
- ℹ Info (зелёный)

#### Плавающие окна
- Отображение полной информации об ошибке при наведении
- Красивое форматирование с информацией об источнике
- Настраиваемое расположение и стиль

## 🎯 Клавиатурные сокращения

### Навигация по коду
| Сокращение | Описание |
|-------------|---------|
| `gd` | Перейти к определению (Go to Definition) |
| `gD` | Перейти к объявлению (Go to Declaration) |
| `gr` | Найти использования (Find References) |
| `gi` | Перейти к реализации (Go to Implementation) |
| `gt` | Перейти к типу (Go to Type Definition) |

### Справка и документация
| Сокращение | Описание |
|-------------|---------|
| `K` | Показать подсказку при наведении (Hover Info) |
| `<Leader>k` | Помощь по сигнатуре функции (Signature Help) |

### Диагностика
| Сокращение | Описание |
|-------------|---------|
| `<Leader>dd` | Показать диагностику для текущей строки |
| `[d` | Перейти к предыдущей ошибке |
| `]d` | Перейти к следующей ошибке |

### Рефакторинг
| Сокращение | Описание |
|-------------|---------|
| `<Leader>rn` | Переименовать символ (Rename) |
| `<Leader>ca` | Показать код действия (Code Actions) |
| `<Leader>fm` | Форматировать код (Format) |

### Документация и символы
| Сокращение | Описание |
|-------------|---------|
| `<Leader>fs` | Символы документа (Document Symbols) |
| `<Leader>ws` | Символы рабочей области (Workspace Symbols) |

### Рабочая область
| Сокращение | Описание |
|-------------|---------|
| `<Leader>wa` | Добавить папку в рабочую область |
| `<Leader>wr` | Удалить папку из рабочей области |

### Автодополнение
| Сокращение | Описание |
|-------------|---------|
| `<C-Space>` | Показать/скрыть меню автодополнения |
| `<C-b>` | Прокрутить вверх в меню |
| `<C-f>` | Прокрутить вниз в меню |
| `<Tab>` | Выбрать следующий элемент / Расширить snippet |
| `<S-Tab>` | Выбрать предыдущий элемент / Перейти на предыдущее место в snippet |
| `<CR>` | Выбрать текущий элемент |
| `<C-e>` | Закрыть меню |
| `<C-l>` | Расширить или перейти к следующему месту в snippet |
| `<C-h>` | Перейти к предыдущему месту в snippet |

### Диагностика (новое)
| Сокращение | Описание |
|-------------|---------|
| `<Leader>dv` | Переключить virtual text диагностики (on/off) |

## 📁 Структура файлов Phase 2

```
nvim/lua/
├── lsp/
│   ├── init.lua                 # Инициализация LSP модуля
│   ├── handlers.lua             # Обработчики LSP, диагностики и keybindings
│   └── servers/
│       ├── typescript.lua       # TypeScript/JavaScript конфигурация
│       ├── vue.lua              # Vue.js конфигурация (с take over mode)
│       ├── php.lua              # PHP конфигурация
│       ├── html.lua             # HTML конфигурация
│       ├── css.lua              # CSS конфигурация
│       ├── json.lua             # JSON конфигурация (с JSON Schema)
│       ├── yaml.lua             # YAML конфигурация
│       └── lua.lua              # Lua конфигурация (с test globals)
└── plugins/
    ├── mason.lua                # Mason plugin configuration
    ├── lspconfig.lua            # LSP configuration and setup
    ├── luasnip.lua              # LuaSnip snippet engine
    └── nvim-cmp.lua             # Autocompletion with snippet support
```

## 🚀 Использование

### Запуск IDE
```bash
./bin/neovim
```

### Первый запуск
При первом запуске после установки Phase 2:
1. Lazy.nvim автоматически установит все плагины
2. Mason установит все необходимые language servers
3. Может потребоваться 1-2 минуты на первый запуск

### Проверка установки LSP серверов
Внутри Neovim:
```vim
:Mason
```
Это откроет UI Mason с полным списком установленных и доступных серверов.

### Проверка статуса LSP
```vim
:LspInfo
```
Показывает информацию о подключённых языковых серверах для текущего буфера.

## 💡 Примеры использования

### TypeScript файл (test.ts)
1. Откройте файл: `:e test.ts`
2. Наведите курсор на переменную и нажмите `K` для информации о типе
3. Нажмите `gd` для навигации по коду
4. Используйте `<Leader>rn` для переименования переменной

### Автодополнение
1. Начните печатать код
2. Нажмите `<C-Space>` для показа меню автодополнения
3. Используйте `<Tab>`/`<S-Tab>` для навигации
4. Нажмите `<CR>` для выбора

### Исправление ошибок
1. Если есть ошибка, появится красный подчёркивающий текст
2. Нажмите `<Leader>dd` для показания полной информации об ошибке
3. Используйте `[d` и `]d` для навигации между ошибками

## ⚙️ Конфигурация

### Отключение LSP сервера
В `nvim/lua/plugins/lspconfig.lua`, в `ensure_installed`:
```lua
ensure_installed = {
    "ts_ls",        -- Раскомментируйте/комментируйте нужные серверы
    "volar",
    "intelephense",
    -- "html",       -- Закомментировать, чтобы отключить
}
```

### Изменение параметров диагностики
В `nvim/lua/lsp/handlers.lua`:
```lua
vim.diagnostic.config({
    virtual_text = {
        prefix = "● ",  -- Изменить символ ошибки
        spacing = 4,
    },
    -- ... другие параметры
})
```

## 🔍 Поддерживаемые файловые типы

| Язык | Расширения | Сервер |
|------|-----------|--------|
| TypeScript | .ts, .tsx | ts_ls |
| JavaScript | .js, .jsx | ts_ls |
| Vue | .vue | volar |
| PHP | .php | intelephense |
| HTML | .html, .htm | html |
| CSS | .css, .scss, .less | cssls |
| JSON | .json | jsonls |
| YAML | .yaml, .yml | yamlls |
| Lua | .lua | lua_ls |

## 📝 Заметки о производительности

1. **Первый запуск**: Плагины и серверы устанавливаются при первом запуске (~1-2 минуты)
2. **Последующие запуски**: Быстрые благодаря lazy loading
3. **Mason cache**: Информация о серверах кешируется
4. **LSP performance**: Зависит от размера проекта

## 🐛 Отладка

### Просмотр логов LSP
```vim
:LspLog
```

### Отключение всех диагностик
```vim
:set diagnostic=off
```

### Выключение LSP для текущего буфера
```vim
:lua vim.lsp.stop_client(vim.lsp.get_active_clients())
```

## 📚 Дополнительные ресурсы

- [nvim-lspconfig GitHub](https://github.com/neovim/nvim-lspconfig)
- [mason.nvim GitHub](https://github.com/williamboman/mason.nvim)
- [nvim-cmp GitHub](https://github.com/hrsh7th/nvim-cmp)
- [Neovim LSP документация](https://neovim.io/doc/user/lsp.html)

## ✅ Что реализовано в Phase 2

### Core LSP
- ✅ LSP base (nvim-lspconfig, mason)
- ✅ Поддержка обеих версий nvim-lspconfig (ts_ls и tsserver)
- ✅ Проверка на наличие серверов перед их настройкой
- ✅ LSP logging (vim.lsp.set_log_level)

### Автодополнение
- ✅ nvim-cmp с интеграцией LSP
- ✅ LuaSnip для snippet'ов
- ✅ Snippet expansion mappings (<C-l>, <C-h>)
- ✅ Completion в search mode (/, ?)
- ✅ Приоритезация источников (LSP > LuaSnip > buffer > path)

### Language Servers
- ✅ TypeScript/JavaScript поддержка (ts_ls/tsserver)
- ✅ Vue.js поддержка с take over mode
- ✅ PHP поддержка (intelephense)
- ✅ HTML/CSS/JSON/YAML поддержка
- ✅ Lua поддержка с test globals

### Диагностика и UI
- ✅ Красивые диагностические знаки (✖ ⚠ 💡 ℹ)
- ✅ Плавающие окна с правильным форматированием
- ✅ Toggle для virtual text (<Leader>dv)
- ✅ Severity sort

### Форматирование
- ✅ Ручное форматирование (<Leader>fm)
- ✅ Автоматическое форматирование на сохранение для основных языков
- ✅ Поддержка form-on-save для TypeScript, JavaScript, Vue, JSON, YAML

### Дополнительные возможности
- ✅ Полный набор LSP keybindings для навигации и рефакторинга
- ✅ JSON Schema поддержка (package.json, tsconfig.json, composer.json и т.д.)
- ✅ Исправленные keybindings (обёрнуты в функции для совместимости)
- ✅ PHP 8.3 в Docker

## 🎯 Следующие фазы

- **Phase 3**: Snippets и GitHub Copilot
- **Phase 4**: Git интеграция (Gitsigns, Fugitive)
- **Phase 5**: Отладка (nvim-dap)
- **Phase 6**: Which-key и terminal интеграция

---

**Версия**: 2.1.0
**Дата**: Октябрь 2024
**Статус**: Production Ready ✅

## 🔄 История изменений Phase 2

### v2.1.0 (текущая версия)
- Добавлена поддержка LuaSnip с интеграцией в nvim-cmp
- Добавлено автоматическое форматирование на сохранение
- Добавлен toggle для virtual_text диагностики (<Leader>dv)
- Расширена Vue.js конфигурация с take over mode
- Расширена Lua конфигурация для test globals
- Обновлена PHP версия на 8.3 в Docker
- Исправлены все keybindings (обёрнуты в функции)
- Добавлена проверка на наличие серверов
- Добавлено LSP logging
- Поддержка обеих версий nvim-lspconfig (ts_ls и tsserver)

### v2.0.0
- Первоначальная реализация Phase 2
- Core LSP, Mason, nvim-cmp
- Базовая поддержка всех языков
