HEAVY RAIN (PC / Steam) TRANSLATION TOOL
by Profesör Pikachu

MAKİNE ÇEVİRİ
https://discord.gg/bWRJunzQY3
========================================

Translate Heavy Rain into your language: extract the English texts and fonts, translate
them, and install them back into the game. Your translation replaces the English text,
so play the game with English selected.


*** Note: I haven't tested whether it works with the Epic version.
But it's worth a try. If you provide feedback, I'll update the tool.

REQUIREMENTS
------------
- Windows (64-bit) and the Steam version of HEAVY RAIN
- Nothing else: HeavyRainTranslationTool.exe is a single program, no Python or other
  installation is needed. Keep it in the same folder as the .bat files and config.ini.

The game folder is found automatically through Steam. If it is not, open config.ini and
write it in the Folder line.


QUICK START
-----------
1_Extract_Texts.bat        English texts  -> work\texts\
2_Extract_Fonts.bat        Fonts (PNG + JSON) -> work\fonts\   (only if you need new letters)
3_Install_Translation.bat  Installs your translated texts and edited fonts into the game
4_Restore_Original.bat     Puts the game back to its original state
5_Status.bat               Shows what is installed

1. Run 1_Extract_Texts.bat.
2. Fill the "Translation" column of the files in work\texts\.
3. Run 3_Install_Translation.bat and check your work in the game.
Repeat steps 2-3 as often as you like. Every install starts from the original game data,
so nothing piles up.

Do not run the tool while the game is running.


TEXT FILES (work\texts)
-----------------------
dialogue.tsv  Subtitles, dialogue choices, thoughts, interaction labels.
                ID          unique ID of the line in the game (DO NOT CHANGE)
                English     original text
                Translation write your translation here
                Type        subtitle = voiced line, text = choice / thought / label
                Scene       scene where the line appears (for context)
system.tsv    Chapter names and system / save messages.
menus.tsv     Main menu, pause menu, options, hints, chapter and trophy descriptions etc.
              Each English text appears once; its translation is applied to every menu
              package AND to the menu copies embedded in scenes (in-game hints).
              Copies of a sentence that differ only in a button icon (ȡ, Ɔ, Ƥ ...) or a
              final period are separate rows; translating ONE of them is enough, the tool
              applies it to the others with the right icon.
ari.tsv       Texts on the ARI glasses screens (ID cards, blood tests, DNA / fingerprint
              results etc.). See "ARI SCREENS" below. Leave names and numbers empty.

Rules
- Only fill the "Translation" column. Empty rows stay in English.
- Line break is written as  \n , carriage return as  \r , tab as  \t . Where the English
  text has \r\n, use it at the same place in your translation.
- Characters such as Ɖ or ƌ in menu texts are button icons. Keep them.
- {S} and {B} marks in subtitles must be kept as they are.
- The files are UTF-8 tab-separated text. Open them with Google Sheets, LibreOffice Calc
  or Notepad++. With Excel, save as "Unicode Text (*.txt)" and rename the file back to
  .tsv (the tool also reads UTF-16).
- Do not delete _manifest.json; it is needed for installing.
- Running 1_Extract_Texts.bat again keeps your translations (the old files are backed up
  in a backup_... folder first).


LONG SUBTITLES
--------------
The game cuts subtitles into 54-character pieces and shows them one after another, even in
the middle of a sentence. The tool fixes this for voiced subtitles when installing:
  - A subtitle up to 108 characters is shown as ONE line.
  - Longer ones are split at sentence ends (one part per line, shown in turn). Short
    sentences are joined with the next one; a very long sentence is split at a comma or
    before a conjunction.
  - To choose the split yourself, write [n] in the translation:
        First part of the line.[n]Second part of the line.
    Lines with [n] are not split automatically.
  - Lines whose English already has {S} / {B} are left as they are.
The line length, the abbreviations (Dr., Mr. ...) and the conjunctions used for splitting
can be set for your language in config.ini, section [Subtitles].

In Turkish, my language, the most appropriate setting was 108.
You can change this as you like in the MaxLineLength section of the configuration file.

FONTS (work\fonts\<FontName>)
-----------------------------
Only needed if your language uses letters the fonts do not have. Write those letters in
config.ini (RequiredCharacters) and run 2_Extract_Fonts.bat: it lists what each font is
missing. The fonts the game really uses:
  Menus, hints, choices : FONT_MainMenu_MASTER and FONT_MainMenu_CRO_MASTER (capital letters)
  Subtitles             : Trebuchet_MASTER
  ARI (Jayden's glasses): ARI_FONT
(2_Extract_Fonts.bat extracts only these. Use  HeavyRainTranslationTool.exe extract-fonts --all-fonts
 for the others, which the PC version does not use.)

Each font folder has:
  <FontName>.json  glyph (character) table
  <page>.png       font texture pages (transparent background)

JSON glyph fields:
  char / code    the character (code is used if char is empty)
  page           which PNG page (from 0, in "pages" order)
  x, y           top-left corner of the character on the page (pixels)
  width, height  size of the character box (pixels); width is also the advance when writing
  kerning        spacing correction against the following character

Adding a letter - the easy way (recommended):
  Reuse the box of a letter your language does not need. Draw your letter over it in the
  PNG and change that glyph's "char" in the JSON (e.g. draw Ł over the Š box and set its
  "char" from "Š" to "Ł"). The glyph count stays the same, so the font does not grow and
  is written in place; kerning entries of the old letter move to the new one automatically.

Adding a letter - as a new glyph:
  1. Draw the letter in an empty area of a PNG page, in the same style (white letter with
     black outline, transparent background).
  2. Add an entry to "glyphs" in the JSON, for example:
       {"char": "ł", "page": 1, "x": 300, "y": 400, "width": 24, "height": 61, "kerning": []}
     (Copying the entry of a similar letter and changing it is easiest.)
  The font grows a little this way; prefer the easy way when possible.

Notes:
  - Never change the number of pages or the pixel size of a page (the game uses fixed
    memory pools).
  - DXT5 pages are written back as DXT5: only the changed 4x4 blocks are re-encoded and the
    smaller mip levels are updated too.
  - If the same character is in two glyphs, the install skips that font and shows an error.


ARI SCREENS (ari.tsv)
---------------------
ARI texts are 8-bit (Latin-1) and are drawn with ARI_FONT.
  - Latin-1 letters that ARI_FONT has (e.g. á é í ó ú ñ ç ä ö ü ß à è â ê ô) can be used
    directly.
  - Other letters cannot be stored. To use one, draw it over an unused Latin-1 box in
    ARI_FONT (e.g. Ì or ì) WITHOUT changing that glyph's "char", then map it in config.ini:
        [ARI]
        CharacterMap = ł=ì, Ł=Ì
    The tool then writes ì's code wherever ł appears in ari.tsv.
  - Any other character becomes "?" and is listed in the install report.
  - A longer translation gets room by repacking the table's own text area. If the total
    space is not enough, the longest line stays in English and is listed in the report.


HOW INSTALLING WORKS / SAFETY
-----------------------------
- The game uses fixed-size memory pools; a resource that grows even a few hundred bytes
  crashes it. So the tool NEVER makes a text resource bigger:
    * Menus: a translation longer than the English is written over another language copy
      of the same line (French, German ...). That line then shows your translation in that
      language too. If it still does not fit, it stays in English and the report says so.
    * Dialogue: no byte of a scene file is shifted. Texts of other languages in the same
      block (Chinese, Korean, Japanese first) are emptied or filled with spaces when room is
      needed. This has no effect when playing with English selected.
- Every warning is written to work\install_report.txt. A line like
    "these menu texts were left in English IN THIS SCENE ...: M0123 '...'"
  means row M0123 of menus.tsv did not fit in that scene; shorten it a little and install
  again. For dialogue, the IDs are the ID column of dialogue.tsv.
- Before writing, the original bytes are saved next to the game archives (*.hryedek,
  about 1.7 GB for a full translation), together with backups of the index files
  (*.idx.hrbak, *.idm.hrbak) and Resources\hr_ceviri_durum.json. Do NOT delete them by
  hand: 4_Restore_Original.bat uses them to restore the game, then removes them.
- A full text install takes about 5-15 minutes, depending on CPU and disk.
- To stop an install, press Ctrl+C once: the resources finished so far are written
  properly and the tool stops. Run the install again later to complete it.
- If Steam verifies the game files or updates the game, the patch is lost. Run
  4_Restore_Original.bat first, then install again.


TECHNICAL NOTES
---------------
- Archive: Quantic Dream "QUANTICDREAMTABINDEX" BigFile (.idx/.dbg/.dat/.dNN). The game
  uses both Resources\BigFile_WIN and Resources\GameData\GameData_WIN; the tool patches both.
- Resources are stored as "segs" (zlib/deflate in 64 KB segments) or "QZIP".
- Scene texts: LOCALIZ_ blocks in DC_INFO/DC_DATA containers (UTF-16BE, 17 languages).
  The tool only changes the ENG part.
- Menu texts: MENUSMST / XDF4 memory image (UTF-16LE); an 18-entry language pointer array
  per string, entry 0 is ENG.
- Fonts: MMSTFONT / FTB glyph table + FILETEXT textures.
- Command line:
    HeavyRainTranslationTool.exe extract-texts | extract-fonts | install | restore | status
    options: --game FOLDER  --work FOLDER  --only text|fonts|dialogue|menus|system|ari
             --all-fonts  --workers N (number of threads, default: CPU cores - 1)
- Some antivirus programs distrust new, unsigned programs; if yours blocks the exe, add an
  exception for the tool folder.


Heavy Rain Translation Tool - by Professor Pikachu
Enjoy it. :)
