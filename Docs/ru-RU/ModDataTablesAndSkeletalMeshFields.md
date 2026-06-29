# Таблицы данных мода и поля скелетного меша

---

## 1. Как конфиг попадает в игру

1. Ведите **DataTables** (а также меши, анимации и т. д.) под `Content/Mods/<ModName>/`.  
2. В **`UModInformationAsset`** добавьте строки **`FModConfig`**: **`ModConfigType`** → соответствующий **`EModConfigType`**, soft-указатель **`DataTable`**.  
3. **Структура строки** должна соответствовать типу (например, `AnimalConfig` → `FModAnimalData` из плагина).

Поля ниже взяты из `Plugins/CreateModPlugin/Source/CreateModPlugin/Public/*.h`; при расхождении приоритет у кода.

---

## 2. Животные / монстры (`FModAnimalData`)

**Заголовок**: `CharacterDataStruct.h`  
**Типичный тип**: `EModConfigType::AnimalConfig`

Существа часто используют **независимые** или общие скелеты животных; **все ссылки на анимацию** должны соответствовать связке **`AnimalMesh` → Skeleton**.

| Поле | Концептуальный тип | Примечания и связь со скелетом |
|------|--------------------|--------------------------------|
| `AnimalMesh` | soft → `SkeletalMesh` | **Основной меш**; определяет `USkeleton`. Все анимации должны быть совместимы. |
| `AnimGroup` | `int32` | **Группа анимаций** — разные скелеты должны использовать разные группы по правилам команды, чтобы избежать неверного выбора AnimBP. |
| `AnimalBlendSpace` | soft → `BlendSpace1D` | Blend перемещения; тот же Skeleton, что у меша. |
| `DeathAnimMontage` | soft → `AnimMontage` | Смерть; совпадение Skeleton. |
| `HitAnimMontage` | map → `AnimMontage` | Реакции на удар; совпадение Skeleton. |
| `MeshScale` | `FVector` | Только визуальный масштаб. |
| `MeshLocationOffset` | `FVector` | Только смещение. |

**Самопроверка**: откройте `AnimalMesh` → отметьте **Skeleton**; откройте каждый BlendSpace/Montage → тот же Skeleton (или ретаргетированный под него).

---

## 3. Постройки / сооружения (`FModBuildData`)

**Заголовок**: `BuildDataStruct.h`  
**Типичный тип**: `EModConfigType::BuildConfig`

Скиннингованные интерактивные объекты.

| Поле | Примечания |
|------|------------|
| `bUseSkeletalMesh` | Если **true**, применяются скелетный меш + anim instance ниже. |
| `SkeletalMesh` | Меш сооружения; **Skeleton** определяет допустимую анимацию. |
| `AnimInstance` | Runtime-подкласс **`UAnimInstance`**; должен соответствовать **Skeleton этого меша** / семейству AnimBP. |

`AnimInstance` для Skeleton A против меша на Skeleton B → нет анимации или краш.

---

## 4. Люди / протагонист (`FModHumanData`)

**Заголовок**: `CharacterDataStruct.h`  
**Типичный тип**: `EModConfigType::CharacterConfig`

Включает кастомизацию, портреты, оружие, монтажи и т. д.; не каждое поле — путь к мешу.

**Жёсткое правило** для мешей **играбельного тела человека**: связка **`USkeletalMesh` → Skeleton** должна быть тем же **`USkeleton`**, что и эталон Mannequin:

- `Content/Art/Animations/Characters/Mannequins/Meshes/SK_Mannequin.uasset` (ассет **Skeleton**, не обычный меш).

Процесс импорта: [ModelImportAndSkeletonMatching.md](./ModelImportAndSkeletonMatching.md). При заполнении таблиц открывайте кастомные меши людей и проверяйте **Skeleton** в Details.

---

## 5. Общие правила таблиц

1. **На каждую строку** меш + анимации образуют **замкнутый цикл** на одном Skeleton (или утверждённой цепочке ретаргета).  
2. **`AnimGroup`** в основном для мультискелетных животных — согласовывайте числовые ID с существующим контентом.  
3. **Soft-пути**: держите ссылочные ассеты под путями **мода** или видимыми для Cook.  
4. **Не смешивайте** Skeleton сооружения с семействами AnimBP протагониста.

---

## 6. Ссылки

- [ModDocumentationIndex.md](./ModDocumentationIndex.md)  
- [ModelImportAndSkeletonMatching.md](./ModelImportAndSkeletonMatching.md)  
- `CharacterDataStruct.h`, `BuildDataStruct.h`, `BaseDataStruct.h`
