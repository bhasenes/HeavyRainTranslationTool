# Heavy Rain Translation Tool

by Profesör Pikachu · Makine Çeviri · [Discord](https://discord.gg/bWRJunzQY3)

Translate **HEAVY RAIN (PC / Steam)** into your language: extract the English texts and fonts,
translate them, and install them back into the game.

## Download

Get **HeavyRainTranslationTool_v1.0.zip** from the [Releases](../../releases/latest) page and
extract it to a folder. Nothing else is needed: no Python or other installation.

## Quick start

| File | What it does |
| --- | --- |
| `1_Extract_Texts.bat` | English texts → `work\texts\` |
| `2_Extract_Fonts.bat` | Fonts (PNG + JSON) → `work\fonts\` (only if you need new letters) |
| `3_Install_Translation.bat` | Installs your translated texts and edited fonts into the game |
| `4_Restore_Original.bat` | Puts the game back to its original state |
| `5_Status.bat` | Shows what is installed |

1. Run `1_Extract_Texts.bat`.
2. Fill the **Translation** column of the files in `work\texts\`.
3. Run `3_Install_Translation.bat` and check your work in the game (play with English selected).

Do not run the tool while the game is running. The game folder is found automatically through
Steam; if it is not, write it in `config.ini`.

Full instructions (text files, long subtitles, fonts, ARI screens, safety notes) are in
[README.txt](README.txt).

> Not tested with the Epic version yet. Feedback is welcome.
