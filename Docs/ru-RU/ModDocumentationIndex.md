# Индекс документации модов EastRimWorld

| Документ | Аудитория | Содержание |
|----------|-----------|------------|
| [ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md) | Все авторы | Обзор движка/проекта, правила `Content/Mods`, `UModInformationAsset`, понятия монтирования, пути к исходникам/ассетам |
| [ModInfoFields.md](./ModInfoFields.md) | Все авторы | Поля `ModInfo.json` / `UModInfoData`, зависимости, `ModToolVersion` и упаковка |
| [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md) | **Дизайн / TA / программисты** | `IncludeGameplayTags`, `{ModId}GameplayTags.ini`, Source в менеджере тегов, перезапуск UE, копирование при упаковке |
| [ModLuaScripting.md](./ModLuaScripting.md) | **Скриптеры / программисты** | `Main.lua`, **привязка блюпринтов через UnLua** (`UnLuaInterface` / `GetModuleName`), `UE.UModLuaLibrary.ModLog`, дополнительные Lua-скрипты и **`AdditionalAssets`** |
| [ModelImportAndSkeletonMatching.md](./ModelImportAndSkeletonMatching.md) | **Художники / TA / риггеры** | Импорт FBX, `USkeleton` против меша, **протагонист обязан использовать скелет Mannequin**, существа используют собственные скелеты, ретаргетинг и чек-лист |
| [ModDataTablesAndSkeletalMeshFields.md](./ModDataTablesAndSkeletalMeshFields.md) | **Дизайн / авторы таблиц / тех. дизайн** | Поля меша/анимации `FModAnimalData`, `FModBuildData`, `FModHumanData`; соответствие скелета; советы по таблицам |
| [ModEditorAndPackaging.md](./ModEditorAndPackaging.md) | **Релиз / интеграция** | Create Mod Plugin: создание мода, Cook, Pak, вывод; работает совместно с `Plugins/CreateModPlugin/README.md` |
| [ModTesting.md](./ModTesting.md) | **Тестирование / QA** | Папка экспорта (`Mods/<ModId>/`), копирование в `Content\Mods` игры, создание `Mods` при отсутствии |

## Туториалы

| Документ | Примечания |
|----------|------------|
| [BasicConfiguration.md](./BasicConfiguration.md) | Новый мод, информация о моде, ассеты внутри папки мода |
| [CharacterConfiguration.md](./CharacterConfiguration.md) | Таблицы и пресеты персонажей |
| [CreatureConfiguration.md](./CreatureConfiguration.md) | Животные/монстры, GameplayTags, настройка GA |
| [ModPackagingQuickStart.md](./ModPackagingQuickStart.md) | Упаковка мода → копирование в игру |

## Рекомендуемый порядок чтения

1. Новичкам в проекте: [ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md).  
2. Метаданные мода и `ModInfo.json`: [ModInfoFields.md](./ModInfoFields.md).  
3. **GameplayTag / ini мода**: [ModGameplayTagsConfiguration.md](./ModGameplayTagsConfiguration.md).  
4. **Точка входа Lua и дополнительные скрипты** мода: [ModLuaScripting.md](./ModLuaScripting.md).  
5. Модели персонажей/существ: [ModelImportAndSkeletonMatching.md](./ModelImportAndSkeletonMatching.md).  
6. Заполнение путей к мешам/анимациям в таблицах: [ModDataTablesAndSkeletalMeshFields.md](./ModDataTablesAndSkeletalMeshFields.md) и заголовки структур.  
7. Сборка Pak: [ModEditorAndPackaging.md](./ModEditorAndPackaging.md).  
8. Проверка в установленной игре: [ModTesting.md](./ModTesting.md).

## Плагин и исходники (краткий справочник)

- Структуры данных: `Plugins/CreateModPlugin/Source/CreateModPlugin/Public/`  
- Обзор плагина: [Plugins/CreateModPlugin/README.md](../../Plugins/CreateModPlugin/README.md)  
- Проект: `EasternEra.uproject` (UE **5.6**)

---

*Ставьте обратную ссылку на этот индекс из других документов; при изменениях движка или плагина доверяйте интерфейсу редактора и коду.*
