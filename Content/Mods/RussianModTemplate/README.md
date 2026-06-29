# Русский шаблон мода (RussianModTemplate)

Стартовый каркас для **русскоязычного мода** Eastern Era (宗门起源). Всё, что
можно задать текстом вне редактора, уже заполнено по-русски. Остальной
внутриигровой текст заполняется в редакторе Unreal — как именно, описано ниже.

> Важно про локализацию: это **одноязычный** русский контент. Текст, который вы
> впишете, отображается как есть, без автоматического переключения по языку
> игры. Поля отображаемых названий в структурах мода имеют тип `FText`, поэтому
> технически они совместимы с системой локализации Unreal (`.locres`), но
> готового мультиязычного пайплайна в тулките нет — пишем сразу на русском.

## Что уже готово в шаблоне

| Файл | Что внутри | Видит игрок |
|------|------------|-------------|
| `ModInfo.json` | `ModName`, `Description`, `Author` — на русском | Да — список/менеджер модов |
| `Main.lua` | Точка входа, комментарии на русском; строки логов — служебные | Нет (только консоль) |
| `README.md` | Этот файл | — |

## Что нужно доделать в редакторе Unreal

Шаблон намеренно **не содержит** бинарных ассетов (`.uasset`) — их создают и
заполняют в редакторе. Минимально необходимое:

1. **`DA_ModDataAsset` (`UModInformationAsset`)** по пути
   `/Game/Mods/RussianModTemplate/DA_ModDataAsset` — на него уже ссылается
   `ModInfo.json` (`ModInformationAssetPath`). Создайте этот DataAsset и
   пропишите в нём свои `DataTables` / `DataAssets`.
2. **Иконку мода** (например `Icon.png`) положите в папку мода и укажите имя
   файла в поле `Icon` в `ModInfo.json`.

## Какие поля заполнять по-русски (отображаемый текст)

Все перечисленные поля имеют тип `FText` — это и есть текст, который видит
игрок. Заполняйте их русскими строками в соответствующих DataTable/ассетах.
Источник — `Plugins/CreateModPlugin/Source/CreateModPlugin/Public/`.

| Структура / файл | Поля для перевода |
|------------------|-------------------|
| `BuildDataStruct.h` (постройки) | `DisplayName`, `Desc` |
| `ItemDataStruct.h` (предметы) | `ItemName`, `ItemDescription`, `ItemGrade`, `UseDescribte` |
| `CharacterDataStruct.h` (персонажи) | `CharacterName`, `CharacterFirstName`, `BackgroundStory`, `AcceptText`, `RefuseText`, `JoinText`, `BeforeObserveName` |
| `EquipmentDataStruct.h` (снаряжение) | `EquipmentName`, `Name`, `WeaponInjuryType`, `UnlockItemDesc`, `FormatUnlockItemDesc` |
| `TechnologyDataStruct.h` (технологии) | `DisplayName`, `TechName`, `TechDesc` |
| `WorldDataStruct.h` (локации мира) | `PlaceName`, `PlaceDesc` |
| `BuffDataStruct.h` (баффы) | `BuffName`, `Describe` |
| `CommonUIStruct.h` (подсказки/UI) | `TipTitle`, `LabelTipContent`, `TitleText` |

> Поля-идентификаторы (`*Id`, `RowName`, теги, пути к ассетам) и строки логов в
> Lua — **не переводите**, это служебные значения.

## Локальная проверка перед редактором

`ModInfo.json` записан в кодировке **UTF-16 LE (с BOM), CRLF** — как у штатных
примеров мода. Проверить корректность JSON можно так:

```bash
python3 -c "import json,io; json.load(io.open('ModInfo.json', encoding='utf-16')); print('OK')"
```

## Сборка и установка

1. Через **Create Mod Plugin** в редакторе: создание/доработка мода → **Cook** →
   **Pak**. См. `Docs/ru-RU/ModEditorAndPackaging.md`.
2. Скопируйте папку собранного мода в `Mods/<ModId>/` установленной игры. См.
   `Docs/ru-RU/ModTesting.md` и `Docs/ru-RU/ModPackagingQuickStart.md`.

## Связанная документация

- `Docs/ru-RU/ModInfoFields.md` — поля `ModInfo.json`
- `Docs/ru-RU/ModDataTablesAndSkeletalMeshFields.md` — поля DataTable
- `Docs/ru-RU/ModLuaScripting.md` — Lua, `AdditionalAssets`
- `Docs/ru-RU/BasicConfiguration.md` — базовая настройка нового мода
