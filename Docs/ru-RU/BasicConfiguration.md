# Базовая настройка

Согласовано с **[ModProjectAndDirectoryStructure.md](./ModProjectAndDirectoryStructure.md)** и **[ModInfoFields.md](./ModInfoFields.md)**; ниже — только пошаговые действия.

---

Шаг 1 | Создайте мод в редакторе

![](../../assets/基础配置_r3_c2_01.png)

Шаг 2 | Заполните базовую информацию о моде (иконка / ID / Name / Version / Author / Description и т. д.)

Примечания: | 1 | После **Create New Mod** вы получаете папку **первого уровня** под **`Content/Mods/`**, обычно с именем вашего **Mod Id** (совпадает с **`ModId`** в `ModInfo.json`; не используйте `Content/Mods/MyMod/SubFolder` как корень мода).

2 | Чтобы конфиг этого мода загружался с экрана **новой игры**, включите **«New Game Load»** (`ModInfo.json` **`NewGameLoad`**); иначе он не загрузится при создании новой игры.

3 | **Иконку** можно поместить в **корень** мода после создания папки (только `Content/Mods/<ModId>/` — не отдельные файлы прямо под `Content/Mods`).

Подробнее о полях: [ModInfoFields.md](./ModInfoFields.md).

![](../../assets/基础配置_r17_c1_02.png)

Шаг 3 | Скопируйте персонажей и другие ассеты в **`Content/Mods/<ModId>/`** (`<ModId>` = имя папки или `ModId` из `ModInfo.json`)

Примечания: | 1 | Убедитесь, что soft-пути указывают на ассеты, реально находящиеся внутри **`Content/Mods/<ModId>/`**, чтобы избежать отсутствующих материалов/скелетов.

2 | **Играбельные меши тела человека** должны использовать эталонный **`USkeleton` Mannequin** проекта: [ModelImportAndSkeletonMatching.md](./ModelImportAndSkeletonMatching.md).

3 | Дополнительные скрипты под **`Content/Script/`** и т. п. должны быть перечислены в **`ModInfo.json` → `AdditionalAssets`**, чтобы попасть в Pak: [ModLuaScripting.md](./ModLuaScripting.md).

![](../../assets/基础配置_r54_c2_03.png)
