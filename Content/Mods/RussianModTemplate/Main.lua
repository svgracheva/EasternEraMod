-- ============================================
-- Mod - главный файл-точка входа
-- Русский шаблон мода для Eastern Era
-- ============================================

local Mod = {}

-- ============================================
-- Вспомогательные функции (логирование)
-- Сообщения логов видит только разработчик в консоли,
-- их переводить не обязательно.
-- ============================================

function Mod:Log(Message, LogLevel)
    LogLevel = LogLevel or "Log"
    UE.UModLuaLibrary.ModLog(self.ModInfo.Metadata.ModId, Message, LogLevel)
end

function Mod:Debug(Message)
    self:Log(Message, "Debug")
end

function Mod:Warn(Message)
    self:Log(Message, "Warning")
end

function Mod:Error(Message)
    self:Log(Message, "Error")
end

-- ============================================
-- Жизненный цикл мода
-- ============================================

-- Вызывается при загрузке мода
function Mod:OnModLoaded()
    self:Log("Mod loaded!")
    self:CommandShowInfo()
end

-- Вызывается при выгрузке мода
function Mod:OnModUnloaded()
    self:Log("Mod unloaded!")
end

-- Вывести информацию о моде
function Mod:CommandShowInfo()
    self:Log("=== Информация о моде ===")
    self:Log(string.format("Mod ID: %s", self.ModInfo.Metadata.ModId))
    self:Log(string.format("Mod Name: %s", self.ModInfo.Metadata.ModName))
end

return Mod
