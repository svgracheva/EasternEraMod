# Справочник полей ModInfo.json

`ModInfo.json` находится в **корне контента** каждого мода и согласован с `UModInfoData` (`Plugins/CreateModPlugin/.../ModInfoEditorData.h`) и редактором **Mod Info Editor** / **Create New Mod**. Игра и упаковка читают **ModId**, основной Lua, путь к **`UModInformationAsset`**, зависимости, дополнительные ассеты и т. д.

**Расположение**: `Content/Mods/<ModName>/ModInfo.json` (`<ModName>` — папка **первого уровня** под `Content/Mods`).

**Примечание**: ключи JSON ниже соответствуют `CreateModWindow::GenerateModInfoJson` и `SModInfoEditorWindow::SaveModInfoToFile`; при ручном редактировании JSON доверяйте фактическому коду разбора.

---

## 1. Обзор корневых полей

| Ключ JSON | Тип | Обязательность / типично | Описание |
|-----------|-----|--------------------------|----------|
| `ModId` | string | **Обязательно** | Уникальный ID мода; если присутствует в `ModInfo.json`, используется как **имя папки вывода** и т. д. (может совпадать или отличаться от имени папки в `Content/Mods`). |
| `ModName` | string | Обычно | Отображаемое имя. |
| `Version` | string | Обычно | Версия мода (например, `1.0.0`). |
| `Author` | string | Необязательно | Автор. |
| `Description` | string | Необязательно | Описание (может быть многострочным). |
| `Icon` | string | Необязательно | Путь к иконке: обычно нормализуется **относительно корня мода** (см. логику копирования/нормализации в редакторе). |
| `MainLuaFile` | string | Обычно | Основная точка входа Lua, **относительно корня мода** (например, `Main.lua`). |
| `ModInformationAssetPath` | string | **Настоятельно рекомендуется** | Soft-путь к **`UModInformationAsset`** этого мода, включая имя ассета и суффикс, например `/Game/Mods/<ModName>/DA_ModDataAsset.DA_ModDataAsset`. Если пусто, мастер подставит значение по умолчанию из `ModFolderPath`. |
| `NewGameLoad` | bool | Необязательно | Загружать при новой игре (`UModInfoData::bNewGameLoad`). |
| `MinGameVersion` | string | Необязательно | Минимальная поддерживаемая версия **игры**. |
| `IncludeGameplayTags` | bool | Необязательно | Поставлять с модом специфичный ini GameplayTag; см. [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md). |
| `GameplayTagsIniFile` | string | Условно | Когда `IncludeGameplayTags` истинно, обычно имя файла относительно корня мода, по соглашению **`{ModId}GameplayTags.ini`** (`UModInfoData::MakeGameplayTagsIniFileName`). См. [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md). |
| `PublishedFileId` | string | Необязательно | ID файла в **Steam Workshop** (и т. п.); редактор может **опускать** ключ, когда он пуст, чтобы не перезаписывать; не считайте обычным редактируемым полем в UI плагина. |
| `AdditionalAssets` | массив string | Необязательно | Дополнительные пути для упаковки, **относительно `Content` проекта**. Дополнительные `.lua` и пр. **обязаны** быть перечислены здесь — они **не** сканируются автоматически. См. [ModLuaScripting.md](./ModLuaScripting.md). |
| `Dependencies` | массив object | Необязательно | Зависимости от других модов, см. §2. |
| `ModToolVersion` | string | Записывается при упаковке | **Не** записывается обычным сохранением Mod Info Editor; успешная **Package Mod** обновляет его (`UModToolVersion::GetModToolVersion()`, например `1.0.0`). |

### Поля только для редактора, отсутствующие в `ModInfo.json`

- **`ModFolderPath`** (только для чтения в `UModInfoData`): текущий путь `Content/Mods/...` для поиска/сохранения в редакторе; **не сериализуется** в `ModInfo.json`.

---

## 2. Элементы массива `Dependencies`

Каждый элемент — объект:

| Ключ | Тип | Описание |
|------|-----|----------|
| `ModId` | string | ID мода-зависимости. |
| `MinVersion` | string | Необязательно; может быть **опущено**, когда пусто в сгенерированном JSON. |
| `Required` | bool | Жёсткая зависимость (`FModDependencyData::bRequired`). **Ключ JSON — `Required`, а не `bRequired`.** |

---

## 3. Связь с `UModInformationAsset`

- `ModInformationAssetPath` должен указывать на **`UModInformationAsset`** с `DataTables` / `DataAssets`.  
- См. [ModDataTablesAndSkeletalMeshFields.md](./ModDataTablesAndSkeletalMeshFields.md) и [Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md).

---

## 4. Различия процессов

| Действие | Влияние на `ModInfo.json` |
|----------|---------------------------|
| Сохранение в **Mod Info Editor** | Записывает поля §1–§2 (`PublishedFileId` только если не пусто); **без** `ModToolVersion`. |
| Мастер **Create New Mod** | Создаёт начальный `ModInfo.json` (по умолчанию `Main.lua`, `ModInformationAssetPath` и т. д.). |
| Успешная **Package Mod** | Записывает/обновляет **`ModToolVersion`** в выходном `ModInfo.json` и связанных копиях метаданных. |

---

## 5. Расположение исходников (для справки)

- Данные: `Plugins/CreateModPlugin/Source/CreateModPluginEditor/Public/ModInfoEditorData.h` (`UModInfoData`, `FModDependencyData`)  
- Генерация/сохранение JSON: `CreateModWindow.cpp` (`GenerateModInfoJson`), `ModInfoEditorWindow.cpp` (`SaveModInfoToFile`, `LoadModInfoFromFile`)  
- Версия при упаковке: `PackageModWindow.cpp` (`ModToolVersion`)  
- Константа версии инструмента: `Plugins/CreateModPlugin/Source/CreateModPlugin/Public/ModToolVersion.h`  

---

## 6. Связанные документы

- [ModDocumentationIndex.md](./ModDocumentationIndex.md)  
- [ModLuaScripting.md](./ModLuaScripting.md) (`MainLuaFile`, UnLua, `AdditionalAssets`)  
- [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md)  
- [ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md)  
- [ModEditorAndPackaging.md](./ModEditorAndPackaging.md)  
- [Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md)
