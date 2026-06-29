# Быстрый старт: упаковка и тестирование мода

Соответствует **[ModTesting.md](./ModTesting.md)** и **[ModEditorAndPackaging.md](./ModEditorAndPackaging.md)**; если пути в вашем клиенте отличаются, используйте тот путь, по которому моды действительно загружаются.

---

## Перед упаковкой

Откройте **Mod Info Editor**, выберите **папку мода** (должна быть `Content/Mods/<ModName>/`).

Проверьте информацию о моде, затем сохраните.

![](../../assets/Mod打包测试简易教程_r6_c3_01.png)

![](../../assets/Mod打包测试简易教程_r6_c7_02.png)

![](../../assets/Mod打包测试简易教程_r14_c3_03.png)

---

## Упаковка

Откройте **Package Mod**, выберите мод(ы), нажмите упаковать (сначала запускается Cook, если ассеты этого требуют).

![](../../assets/Mod打包测试简易教程_r36_c4_04.png)

![](../../assets/Mod打包测试简易教程_r36_c7_05.png)

**Вывод**: **`<ModProjectRoot>/Mods/<ModId>/`** с `<ModId>.pak`, `ModInfo.json`, основным Lua, иконкой и т. д. `ModId` берётся из `ModInfo.json`; если не задан, обычно совпадает с именем папки в `Content/Mods`. См. [ModTesting.md §1](./ModTesting.md).

---

## После упаковки — тестирование

Скопируйте папку **`Mods/<ModId>/`** в:

**`<GameInstall>\EasternEra\EasternEra\Content\Mods\<ModId>\`**

Пример для Steam: `<GameInstall>\Steam\steamapps\common\EasternEra\EasternEra\Content\Mods\<ModId>\`

**Примечание**: путь должен быть под **`Content\Mods`**, а не `EasternEra\EasternEra\Mods` без `Content`. Если **`Mods`** отсутствует, создайте её под **`...\EasternEra\EasternEra\Content\`**, затем поместите внутрь `<ModId>`.

Запустите игру → Workshop (или UI модов) → вкладка Local Mods → включите мод.

![](../../assets/Mod打包测试简易教程_r50_c2_06.png)

![](../../assets/Mod打包测试简易教程_r80_c2_07.png)
