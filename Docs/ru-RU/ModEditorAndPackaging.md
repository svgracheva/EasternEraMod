# Редактор модов и упаковка

---

## 1. Возможности редактора (`CreateModPlugin`)

**`CreateModPlugin`** обычно предоставляет (точные меню зависят от движка/плагина):

- **Create Mod**: валидная папка под `Content/Mods/<ModName>/`, **`UModInformationAsset`** для регистрации DataTables/DataAssets.  
- **Package Mod**: выбор мода(ов), опциональный **Cook**, **`UnrealPak`** (или эквивалент) → **`.pak`**.

См. `Plugins/CreateModPlugin/Source/CreateModPluginEditor/` (`ModInfoEditorWindow.cpp`, `PackageModWindow.cpp`, `CreateModWindow.cpp`).

---

## 2. После создания мода

1. Путь мода должен быть **одним** подкаталогом под `Content/Mods/` ([ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md) §2.2).  
2. В **`UModInformationAsset`** зарегистрируйте **DataTables** / **DataAssets** через `FModConfig` / `FModAsset`.  
3. Пример данных человека и заметки по CSV плагина: **[Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md)**.  
4. **ModId должен быть уникальным** — не показывается игрокам напрямую; используется как индекс включения/отключения. Не дублируйте ID другого мода.

---

## 3. Когда нужен Cook

- Мод содержит **uassets**, которые нужно **Cook** в Pak — упаковка запускает Cook (или полный Cook проекта в зависимости от реализации).  
- Можно также выполнить Cook через движковый **Cook Content** перед упаковкой мода.  
- Несколько только **не-ассетных** файлов (`.ini`, `.lua`) могут пропускать Cook в некоторых путях — проверяйте логи упаковки.

Типичный вывод Cook (зависит от движка):

- `Saved/Cooked/Windows/<ProjectName>/Content/Mods/<ModName>/`  
- Или `WindowsNoEditor` и т. д.

Плагин проверяет несколько кандидатов (`PackageModWindow.cpp`).

---

## 4. Вывод и Pak

- Каждый мод экспортируется в **`<ProjectRoot>/Mods/<ModId>/`** (`ModId` из `ModInfo.json` или имени папки), включая **`<ModId>.pak`**, скопированный `ModInfo.json`, входной Lua, иконку, `.ini` GameplayTags и т. д.  
- Префикс монтирования Pak согласуется с правилами игры, например `../../../<ProjectName>/Content/Mods/<ModName>/...`.

**Копирование в игру для локального тестирования**: [ModTesting.md](./ModTesting.md).

Включите мод в клиенте согласно официальному UI модов / порядку загрузки.

---

## 5. Устранение проблем

| Симптом | Вероятная причина |
|---------|-------------------|
| Неверный путь мода | Не одноуровневая структура `Content/Mods/<ModName>` |
| Сбой Cook | Плохие ассеты, отсутствующие ссылки, настройки Cook — смотрите Output Log |
| Pak в порядке, но нет эффекта в игре | Путь монтирования, ModId, сканирование игры, неполный `UModInformationAsset` |

---

## 6. Связанные документы

- [ModDocumentationIndex.md](./ModDocumentationIndex.md)  
- [ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md)  
- [ModInfoFields.md](./ModInfoFields.md) (`ModToolVersion`)  
- [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md)  
- [ModLuaScripting.md](./ModLuaScripting.md)  
- [ModTesting.md](./ModTesting.md)  
- [Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md)
