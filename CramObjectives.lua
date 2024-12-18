local CRAM = "cram"
local HIDE = "hide"
local SHOW = "show"
local TOGGLE = "toggle"
local HELP = "help"

CramObjectives = LibStub("AceAddon-3.0"):NewAddon("CramObjectives", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
CO = CramObjectives
OTF = ObjectiveTrackerFrame


function CO:OnInitialize()
    CO:Print("OnInitialize")
    CODB = CODB or {}
    if CODB.hide == nil then
        CODB.hide = true
    end

    CO:RegisterChatCommand("ram", "SlashCommand")
    CO:RegisterChatCommand("cram", "SlashCommand")
end

function CO:HideTrackerIfEnabled()
    local zone = GetZoneText()

    if CODB.hide == true then
        OTF:Hide()
    end
end

function SetupHooks()
    CO:HookScript(OTF, "OnShow", "HideTrackerIfEnabled")
end

function CO:OnEnable()
    CO:Print("OnEnable")

    if CODB.hide == true then
        SetupHooks()
        OTF:Hide()
    end

end

function CO:Hide()
    if CODB.hide == false then
        CODB.hide = true
        OTF:Hide()
        SetupHooks()
    elseif OTF.IsVisible then
        OTF:Hide()
    else
        CO:Print("Already hidden")
    end
end

function CO:Show()
    if CODB.hide == true then
        CODB.hide = false
        OTF:Show()
        CO:UnhookAll()
    elseif not OTF.IsVisible then
        OTF:Show()
    else
        CO:Print("Already visible")
    end
end

function CO:Toggle()
    if CODB.hide == false  then
        CO:Hide()
    else
        CO:Show()
    end
end

function CO:Help()
    CO:Print("Usage: /cram "..HIDE.." or /cram "..SHOW.. " or /cram " ..TOGGLE )
    CO:Print("/cram with no option will toggle and print this help message")
end

-- Configure slash commands for enable and disable of the printing
function CO:SlashCommand(msg)
    local cmd1 = strsplit(" ", msg)

    if #cmd1 > 0 then
        cmd1 = strlower(cmd1)

        if cmd1 == CRAM or cmd1 == HIDE then
            CO:Hide()
        elseif cmd1 == SHOW then
            CO:Show()
        elseif cmd1 == TOGGLE then
            CO:Toggle()
        elseif cmd1 == HELP then
            CO:Help()
        end
    else
        CO:Toggle()
        CO:Help()
    end
end
