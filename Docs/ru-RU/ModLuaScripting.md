# Lua-скриптинг мода

Соглашения о точке входа Lua для модов **EastRimWorld**, `ModInfo.json`, привязка блюпринтов через **UnLua**, упаковка и шаблонные **API `UE`**. Библиотеки C++ находятся в проекте выпускаемой игры; в этом репозитории есть **UnLua** и **Create Mod Plugin** для справки.

---

## 1. ModInfo и расположение файлов

| Элемент | Описание |
|---------|----------|
| **Основная точка входа** | **`MainLuaFile`** в `ModInfo.json`, относительно **корня мода** (`Content/Mods/<ModName>/`), обычно **`Main.lua`**. |
| **Путь на диске** | `Content/Mods/<ModName>/<MainLuaFile>`, например `Content/Mods/CheatingBuildings/Main.lua`. |
| **Во время выполнения** | После загрузки игра запускает модуль скрипта; он должен **`return`** **таблицу** как объект модуля мода (§2). |

Полный справочник `ModInfo.json`: [ModInfoFields.md](./ModInfoFields.md).

---

## 2. Шаблон, генерируемый мастером (`Create New Mod`)

Из `CreateModWindow::GenerateMainLuaFile` (`Plugins/CreateModPlugin/.../CreateModWindow.cpp`):

1. **Таблица модуля**: `local Mod = {}`, заканчивается **`return Mod`**.  
2. **Жизненный цикл** (игра вызывает их по имени):  
   - **`Mod:OnModLoaded()`** — мод завершил загрузку.  
   - **`Mod:OnModUnloaded()`** — мод выгружается.  
3. **Логирование**: шаблон использует **`UE.UModLuaLibrary.ModLog(ModId, Message, LogLevel)`** с обёртками `Debug` / `Warn` / `Error` (`LogLevel` `"Debug"`, `"Warning"`, `"Error"`; по умолчанию `"Log"`).  
4. **Метаданные**: шаблон читает **`self.ModInfo.Metadata`**, например:  
   - **`self.ModInfo.Metadata.ModId`**  
   - **`self.ModInfo.Metadata.ModName`**  

Runtime внедряет разобранный **`ModInfo.json`** в **`ModInfo`**; для других полей смотрите выпускаемый проект или печатайте `self.ModInfo`.

---

## 3. UnLua и таблица `UE`

**UnLua** (`Plugins/UnLua`) предоставляет **`UE`** для экспортированных `UCLASS` / `UFUNCTION`. Пример из шаблона:

```lua
UE.UModLuaLibrary.ModLog(self.ModInfo.Metadata.ModId, Message, LogLevel)
```

**`UModLuaLibrary`** находится в **модуле выпускаемой игры**; этот репозиторий для авторов может не включать его C++. Используйте соответствующую сборку игры для тестов в редакторе.

---

## 4. Блюпринт ↔ Lua (UnLua)

**Mod `Main.lua`** (система модов) и **Lua для отдельных блюпринтов** (UnLua) — разные конвейеры.

### 4.1 Концепции

| Конвейер | Роль |
|----------|------|
| **Mod `MainLuaFile`** | Точка входа уровня мода под `Content/Mods/...`, например `OnModLoaded`. |
| **Блюпринт + UnLua** | Класс блюпринта реализует **`UnLuaInterface`**; **`GetModuleName`** указывает на модуль под **`Content/Script`**; при **Bind** функции Lua с **теми же именами**, что и переопределяемые события/функции блюпринта, подключаются к `UFunction` (см. `Plugins/UnLua/.../UnLuaManager.cpp`). |

### 4.2 Привязка в редакторе блюпринтов

1. Откройте целевой **блюпринт** (`Actor`, `UserWidget`, `AnimInstance` и т. д., согласно поддержке UnLua).  
2. Панель **UnLua** (после **Debugging**): **Bind**:  
   - Добавляет **`UnLuaInterface`** и **`GetModuleName`**; по умолчанию из **Project Settings → Plugins → UnLua → `LuaModuleLocator`**.  
   - **Alt + Bind**: имя модуля на основе пути пакета (`UnLuaEditorToolbar::BindToLua_Executed`).  
3. После привязки: **Create Lua Template** → `.lua` под **`Content/Script/`** (точки → `/`).  
4. **Copy as Relative Path** / **Reveal in Explorer** для проверки.  
5. **Unbind** для удаления.

Если **`ModuleLocator`** некорректен, runtime может логировать *Invalid lua module locator* (`LuaEnv.cpp`).

### 4.3 `GetModuleName` против диска

Возвращает имя модуля **относительно `Content/Script`**, через точки, например:

`Weapon.BP_DefaultProjectile_C` → `Content/Script/Weapon/BP_DefaultProjectile_C.lua`

Модуль должен **`return`** таблицу.

### 4.4 Соглашения модуля Lua

1. **`Initialize`**: необязательная инициализация после привязки.  
2. **Одноимённые функции** с переопределениями блюпринта.  
3. **`UE`** для API движка; см. `Plugins/UnLua/Content/Script/UnLua/Input.lua`, `EnhancedInput.lua` и т. д.

### 4.5 Упаковка

Скрипты под **`Content/Script/...`**, которые должны поставляться, обычно нужно указывать в **`ModInfo.json` → `AdditionalAssets`** путями **относительно `Content`** (§5). **`Main.lua`** — отдельно.

---

## 5. Дополнительный Lua: указывайте в `AdditionalAssets`

Помимо **`Main.lua`** (через **`MainLuaFile`**, под **`Content/Mods/<ModName>/`**), любые другие файлы Lua или не-uasset, которые нужно поставлять, должны быть перечислены в **`AdditionalAssets`** (**дополнительные упаковываемые ассеты** / `UModInfoData::AdditionalAssets`).

| Элемент | Описание |
|---------|----------|
| **Формат пути** | Каждая запись **относительно `Content` проекта**, прямые слэши, например `Script/MyModId/Helper.lua` → `Content/Script/MyModId/Helper.lua`. См. **`AdditionalAssets`** в [ModInfoFields.md](./ModInfoFields.md). |
| **Соглашение** | например, `Content/Script/<ModId>/`; упаковываются **только указанные файлы**. |
| **Основная точка входа** | **`MainLuaFile`** обычно **не требует** дублирующей записи в `AdditionalAssets`, если только не нужно упаковать другой путь копии. |

---

## 6. Вывод упаковки

- После упаковки **`Main.lua`** и т. д. копируются в **`<ProjectRoot>/Mods/<ModId>/`** ([ModTesting.md](./ModTesting.md)).  
- Держите **`MainLuaFile`** соответствующим реальному имени файла; предпочитайте прямые слэши относительно корня мода.

---

## 7. Примеры в этом репозитории

- `Content/Mods/CheatingBuildings/Main.lua`  
- `Content/Mods/ParagonSunWukong/Main.lua`  

Паттерн: таблица `Mod` + `OnModLoaded` / `OnModUnloaded` + `return Mod`.

---

## 8. Ссылки

| Тема | Расположение |
|------|--------------|
| `ModInfo.json` | [ModInfoFields.md](./ModInfoFields.md) |
| Cook / Pak / вывод | [ModEditorAndPackaging.md](./ModEditorAndPackaging.md), [ModTesting.md](./ModTesting.md) |
| Шаблон `Main.lua` | `CreateModWindow.cpp` → `GenerateMainLuaFile` |
| `AdditionalAssets` / упаковка | `PackageModWindow.cpp` |
| Привязка UnLua | `UnLuaInterface.h`, `UnLuaEditorToolbar.cpp` |
| Локатор модулей | `LuaModuleLocator.cpp`, `UUnLuaSettings` |
| Обзор плагина | [Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md) |

---

*Если игра обновит инфраструктуру модов или `UModLuaLibrary`, следуйте документации выпускаемой версии.*
