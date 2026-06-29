# Структура проекта и каталогов мода

---

## 1. Роль проекта

| Элемент | Описание |
|---------|----------|
| Движок | Unreal Engine **5.6** (см. `EasternEra.uproject` в корне репозитория) |
| Игровой runtime-модуль | `EastRimWorld` |
| Поддержка модов | Плагин **`CreateModPlugin`** (`Plugins/CreateModPlugin/`): типы данных мода, `UModInformationAsset`, процесс создания/упаковки в редакторе |

Этот репозиторий — **проект для авторов модов**: собираете ассеты и таблицы в редакторе, затем с помощью плагина выполняете **Cook** папки мода и оборачиваете её в **`.pak`** для выпущенной игры (шаги упаковки: [ModEditorAndPackaging.md](./ModEditorAndPackaging.md)).

---

## 2. Раскладка контента мода

### 2.1 Корневой путь и именование

- **Корень контента мода**: `Content/Mods/<ModName>/`  
- `<ModName>`: имя папки вашего мода; часто часть идентичности Pak.

### 2.2 Почему это должен быть **прямой** потомок `Mods`

Процессы плагина **Create Mod**, **выбор пути мода** и **упаковка** проверяют:

- Путь должен быть внутри `Content/Mods/`;  
- **сам `Content/Mods`** не может быть корнем мода;  
- **нельзя** использовать `Content/Mods/MyMod/SubFolder` как корень мода — плагин ожидает **один уровень подкаталога** на мод, чтобы вывод Cook и пути монтирования Pak оставались согласованными.

Неверные пути показывают ошибки в мастере или UI упаковки; см. проверки редактора (например, `ModInfoEditorWindow.cpp`, `PackageModWindow.cpp`).

### 2.3 Ассет информации о моде `UModInformationAsset`

У каждого мода обычно один **`UModInformationAsset`** (создаётся мастером), объявляющий:

- **`DataTables`** (массив `FModConfig`): `ModConfigType` (`EModConfigType`), целевой `UDataTable`, флаги слияния/переопределения и т. д.;  
- **`DataAssets`** (необязательно): другие конфиги `UDataAsset`.

Игра использует это для регистрации таблиц и ассетов. **Типы структуры строки** должны соответствовать `EModConfigType` (например, конфиг животного → структура животного), иначе чтение во время выполнения будет неверным или завершится ошибкой.

### 2.4 Пути Cook и монтирования (концепция)

После Cook вывод располагается под `Saved/Cooked/<Platform>/...` (точная раскладка зависит). При сборке Pak приготовленные файлы сопоставляются с ожидаемым префиксом монтирования, например:

`../../../<ProjectName>/Content/Mods/<ModName>/...`

**ProjectName** — фактическое имя проекта `uproject` / целевой игры.

---

## 3. Справочные пути для разработки (исходники и плагин)

| Назначение | Путь |
|------------|------|
| Структуры данных мода (животные, люди, постройки и т. д.) | `Plugins/CreateModPlugin/Source/CreateModPlugin/Public/` (например, `CharacterDataStruct.h`, `BuildDataStruct.h`, `BaseDataStruct.h`) |
| Enum конфигурации `EModConfigType` | `Plugins/CreateModPlugin/Source/CreateModPlugin/Public/BaseDataStruct.h` |
| Редактор: создание мода, проверки пути, Cook при упаковке | `Plugins/CreateModPlugin/Source/CreateModPluginEditor/` |
| Краткие заметки по плагину и примеры CSV | [Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md) |

---

## 4. Связанные документы

**README** репозитория ссылается на тот же набор документов.

- [ModDocumentationIndex.md](./ModDocumentationIndex.md)  
- [ModInfoFields.md](./ModInfoFields.md) (поля `ModInfo.json`)  
- [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md) (ini GameplayTag)  
- [ModLuaScripting.md](./ModLuaScripting.md) (`Main.lua`, UnLua, `AdditionalAssets`)  
- [ModelImportAndSkeletonMatching.md](./ModelImportAndSkeletonMatching.md)  
- [ModDataTablesAndSkeletalMeshFields.md](./ModDataTablesAndSkeletalMeshFields.md)  
- [ModEditorAndPackaging.md](./ModEditorAndPackaging.md)  
- [ModTesting.md](./ModTesting.md) (папка экспорта → `Content\Mods` игры)

---
