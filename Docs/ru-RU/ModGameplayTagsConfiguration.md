# Настройка GameplayTags мода

Как моды **EastRimWorld** поставляют **GameplayTags** через **`ModInfo.json`** + выделенный ini, движковый **Gameplay Tag Manager** и упаковку.

Поля метаданных: [ModInfoFields.md](./ModInfoFields.md). Процесс навыков/тегов существ: [CreatureConfiguration.md](./CreatureConfiguration.md) («файл менеджера тегов», «новые теги» и т. д.).

---

## 1. Обзор

| Элемент | Описание |
|---------|----------|
| **GameplayTag** | Иерархические теги движка для способностей, anim notify, баффов, ввода и т. д. |
| **Подход мода** | Держите **специфичный для мода ini тегов** под корнем мода; `ModInfo.json` включает его и задаёт имя файла; в Tag Manager установите **Source** на этот файл. |
| **Упаковка** | Когда включено, **`.ini`** копируется в **`Mods/<ModId>/`** вместе с `Main.lua`, `ModInfo.json` и т. д. |

---

## 2. Поля ModInfo / редактора (`UModInfoData`)

| Поле | Ключ JSON | Описание |
|------|-----------|----------|
| **Include GameplayTag config** | `IncludeGameplayTags` | **true** включает ini тегов мода; **false** пропускает логику файла тегов. |
| **GameplayTag ini path** | `GameplayTagsIniFile` | Имя файла **относительно корня мода**; нормализуется к **`{ModId}GameplayTags.ini`**. |

**Имя по умолчанию** (`UModInfoData::MakeGameplayTagsIniFileName`):

```text
{ModId}GameplayTags.ini
```

Пример: ModId `MyDragon` → `MyDragonGameplayTags.ini` в **`Content/Mods/MyDragon/`** рядом с `ModInfo.json`.

Включайте **Include Gameplay Tags** только после того, как задан **Mod ID** (`ModInfoEditorData.cpp` `PostEditChangeProperty`).

---

## 3. Создание и начальное содержимое

- При включении в **Create Mod** или **Mod Info Editor** плагин **создаёт** ini, если он отсутствует, с минимально валидной секцией:

  `[/Script/GameplayTags.GameplayTagsList]`

- См. `UModInfoData::EnsureDefaultGameplayTagsIni`, `WriteDefaultGameplayTagsIniContent`, `ModInfoEditorWindow::CreateGameplayTagsIni`.

**Важно**: после создания или существенного редактирования ini **перезапустите проект UE**, чтобы Tag Manager подхватил новый Source (как и в [CreatureConfiguration.md](./CreatureConfiguration.md)).

---

## 4. Добавление/редактирование тегов в редакторе

1. **Edit → Project Settings → GameplayTags** или **Gameplay Tag Manager** (в зависимости от меню проекта).  
2. При **добавлении тегов** установите **Source** на **`{ModId}GameplayTags.ini`** под папкой мода — не записывайте теги, специфичные для мода, в глобальные файлы по умолчанию без договорённости.  
3. Поддерживайте иерархию через родитель/потомок; согласуйте именование с дизайном и anim notify (например, `Montage.Behavior`, **Event Tag** в `NS_AbilityNotify`).  

Навыки существ часто используют теги под **`Ability.UniqueSkill`**, на которые ссылаются строки **GameAbility** (см. туториал).

---

## 5. Снятие галочки «Include GameplayTag»

Снятие галочки может предложить **удалить** **`{ModId}GameplayTags.ini`** (сохранение в `ModInfoEditorWindow`). После удаления **перезапустите** редактор и проверьте теги.

---

## 6. Вывод упаковки и тестирование

- Упаковка читает `IncludeGameplayTags`, `GameplayTagsIniFile`, **`ModId`**, разрешает путь к ini, копирует **одноимённый ini** в **`Mods/<ModId>/`** ([ModTesting.md](./ModTesting.md)).  
- Если `IncludeGameplayTags` истинно, но файл отсутствует, ожидайте предупреждений при упаковке.

---

## 7. Ссылки

| Тема | Расположение |
|------|--------------|
| `ModInfo.json` | [ModInfoFields.md](./ModInfoFields.md) |
| Папки модов | [ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md) |
| Упаковка/вывод | [ModEditorAndPackaging.md](./ModEditorAndPackaging.md), [ModTesting.md](./ModTesting.md) |
| Существа + теги | [CreatureConfiguration.md](./CreatureConfiguration.md) |
| Исходники | `ModInfoEditorData.h/.cpp`, `PackageModWindow.cpp` (`GameplayTagsIni`) |

---

*Игровая семантика (GA, notify монтажа) следует за выпущенным проектом.*
