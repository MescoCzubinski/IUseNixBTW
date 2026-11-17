#!/usr/bin/env bash

# games-backup  mirror game save folders to the Backup disk

set -e

dest=/run/media/mieszko/Backup/Auto/Games
steam=~/.local/share/Steam/steamapps/compatdata
heroic=~/.games/Heroic/Prefixes/shared/drive_c/users/steamuser

mirror() {
    rsync -avh --mkpath "$1/" "$dest/$2/"
}

mirror "$steam/20900/pfx/drive_c/users/steamuser/Documents/The Witcher/saves" TheWitcher
mirror "$steam/292030/pfx/drive_c/users/steamuser/Documents/The Witcher 3/gamesaves" TheWitcherIII
mirror "$steam/1903340/pfx/drive_c/users/steamuser/AppData/Local/Sandfall/Saved/SaveGames" Expedition33
mirror "$steam/3167020/pfx/drive_c/users/steamuser/AppData/LocalLow/TeamSoda/Duckov/Saves" EscapeFromDuckov
mirror "$heroic/Saved Games/MachineGames/Wolfenstein The New Order/base/savegame" WolfensteinTheNewOrder
mirror "$heroic/Documents/My Games/Sid Meier's Civilization VI (Epic)/Saves" CivilizationVI
