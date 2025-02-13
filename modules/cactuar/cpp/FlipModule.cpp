#include "map/utils/moduleutils.h"

#include "common/logging.h"
#include "common/sql.h"
#include "map/lua/luautils.h"
#include "map/packets/char_stats.h"
#include "map/packets/chat_message.h"
#include "map/utils/charutils.h"

class FlipModule : public CPPModule
{
    void OnInit() override
    {
        lua["CBaseEntity"]["flip"] = [](CLuaBaseEntity* PLuaBaseEntity, int32 arg)
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            auto* PChar = static_cast<CCharEntity*>(PEntity);

            // PChar and arg are available from here onwards
            {
                bool dw = false;

                if (arg == 18)
                {
                    dw = true;
                }
                uint8 flipstate = (uint8)charutils::GetCharVar(PChar, "JobFlipState");

                if (dw == false) // we aren't doing DW workaround
                {
                    if (flipstate == 0) // not flipped
                    {
                        flipstate = 1; // let's flip
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Flip enabled. You may now equip items allowed by your sub job.", "Server"));
                    }

                    else if (flipstate == 1) // flipped
                    {
                        flipstate = 0; // let's unflip
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Flip disabled. You may now equip items allowed by your main job.", "Server"));
                    }

                    else if (flipstate == 2) // dw workaround
                    {
                        flipstate = 3; // let's flip with dw workaround still enabled
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Flip enabled. You may now equip items allowed by your sub job.", "Server"));
                    }

                    else if (flipstate == 3) // dw workaround while flipped
                    {
                        flipstate = 2; // let's unflip but leave dw up
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Flip disabled. You may now equip items allowed by your main job.", "Server"));
                    }
                }

                if (dw == true) // we ARE doing DW workaround
                {
                    if (flipstate == 0) // not flipped
                    {
                        flipstate = 2; // let's set DWWA
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Subjob has been ghosted to be NIN to allow dual wielding.", "Server"));
                    }

                    else if (flipstate == 1) // flipped
                    {
                        flipstate = 3; // let's set DWWA and keep flip on
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Subjob has been ghosted to be NIN to allow dual wielding.", "Server"));
                    }

                    else if (flipstate == 2) // dw workaround
                    {
                        flipstate = 0; // let's undo DWWA
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Dual wield disabled. Your jobs have been reset to normal state.", "Server"));
                    }

                    else if (flipstate == 3) // dw workaround with flip enabled
                    {
                        flipstate = 1; // let's undo DWWA but keep flip on
                        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, "Dual wield disabled. Your jobs have been reset to normal state.", "Server"));
                    }
                }

                charutils::SetCharVar(PChar, "JobFlipState", flipstate);
                PChar->pushPacket(std::make_unique<CCharStatsPacket>(PChar, false));

                return;
            }
        };
    }
};

REGISTER_CPP_MODULE(FlipModule);