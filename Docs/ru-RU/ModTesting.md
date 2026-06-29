# Тестирование мода

Куда попадает **результат упаковки** и **как скопировать его в установленную игру** для локального тестирования.

Упаковка и Cook: [ModEditorAndPackaging.md](./ModEditorAndPackaging.md).

---

## 1. Расположение экспорта (этот проект)

Плагин записывает каждый мод под **`<корень проекта EasternEraMod>/Mods/<ModId>/`** (`PackageModWindow.cpp`: `ProjectDir/Mods/{ModId}`).

- **Корень**: `<корень проекта>/Mods/`  
- **На мод**: `<корень проекта>/Mods/<ModId>/`

**`ModId`**

- Из **`ModId`** в `Content/Mods/<ModName>/ModInfo.json`, если задан.  
- Иначе по умолчанию **имя папки в `Content/Mods`** (`<ModName>`).

**Содержимое папки** (зависит от конфигурации мода)

- `<ModId>.pak`  
- `ModInfo.json` (обновлён версией инструмента и т. д.)  
- Входной Lua, иконка, `.ini` GameplayTags и т. д., если настроено  

**Копируйте папку `<ModId>` целиком** — не пропускайте файлы помимо Pak.

---

## 2. Копирование в игру

Скопируйте **папку `<ModId>` целиком** в:

`<GameInstall>\EasternEra\EasternEra\Content\Mods\<ModId>\`

Та же раскладка, что при экспорте: под игровой **`Content\Mods`**.

**Если `Mods` отсутствует**: создайте **`Mods`** под  

`<GameInstall>\EasternEra\EasternEra\Content\`

затем поместите внутрь `<ModId>`.

Пример:

```text
GameInstall\
  EasternEra\
    EasternEra\
      Content\
        Mods\
          YourModId\          ← скопируйте папку целиком из Mods\YourModId проекта
            YourModId.pak
            ModInfo.json
            (другие экспортированные файлы…)
```

---

## 3. Советы по тестированию

1. **Глубина пути**: двойной `EasternEra` → `Content\Mods`; скорректируйте, если ваша сборка отличается.  
2. **Версия**: клиент должен соответствовать ревизии движка/ассетов, использованной для Cook.  
3. **Несколько модов**: одна подпапка на **ModId**; не объединяйте.  
4. **Включение мода**: используйте внутриигровой список модов / порядок загрузки согласно официальной документации.

---

## 4. Связанные документы

- [ModDocumentationIndex.md](./ModDocumentationIndex.md)  
- [ModEditorAndPackaging.md](./ModEditorAndPackaging.md)  
- [ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md)
