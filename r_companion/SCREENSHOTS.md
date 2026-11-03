# Screenshots Needed

Screenshots the companion needs from the author. Each one has an ID that
matches a `<!-- SCREENSHOT Snn -->` marker in the chapter, showing where it
goes. Delete a row once the screenshot is in the chapter.

## How to take them

- **Save as PNG**, in `r_companion/images/chapter_NN/`, with the exact file name
  in the table. Names are `NN_<what it shows>_<win|mac>.png`; screenshots that
  look the same on both systems have no ending and can be taken on either.
- **Capture one window, not the whole screen.**
  - Windows: press **Windows + Shift + S**, choose **Window snip**, and click
    the window. Paste into Paint and save as PNG, or use the Snipping Tool's
    save button.
  - Mac: press **Cmd + Shift + 4**, then **Space**, then hold **Option** and
    click the window (Option leaves out the drop shadow). The file lands on
    the Desktop.
- **Mark what to click** with a thick rectangle or arrow, and add a number or
  a short text label beside it, so the mark is visible without color.
- **Use the standard look:** RStudio's default theme (light background) and
  default pane layout, with the window at a normal size (not full screen on a
  very large monitor).
- **Check for personal details** before saving: your name in folder paths,
  your email in Posit Cloud, other files in your folders. A folder named
  `Stats R` with only the course files in it is ideal.

When they are in the folder, tell Claude. Claude views each one, writes its
caption and alt text, places it at its marker, and renders the chapter.

## Chapter 0

| ID | File name | System | What to show | What to mark |
| :--- | :--- | :--- | :--- | :--- |
| S01 | `00_r_not_rstudio_win.png` | Windows | R's own window (open **R**, not RStudio, from the Start menu) | Nothing |
| S02 | `00_r_not_rstudio_mac.png` | Mac | R's own window (open **R** from Applications, not RStudio) | Nothing |
| S03 | `00_rstudio_panes.png` | Either | RStudio with a new script open, so all four panes show | Label each pane: Source, Console, Environment, Files/Plots |
| S04 | `00_first_script.png` | Either | A script containing `2 + 2`, after running it, with `[1] 4` in the Console | The **Run** button, and the `[1] 4` answer |
| S05 | `00_set_working_directory.png` | Either | The **Session** menu open, with **Set Working Directory** expanded | **To Source File Location** |
| S06 | `00_environment_students.png` | Either | The Environment pane after running `students <- read.csv("census_at_school.csv")` | The line `students  500 obs. of 35 variables` |
| S07 | `00_mac_chip_mac.png` | Mac | The **About This Mac** window | The **Chip** (or **Processor**) line |
| S08 | `00_rstudio_drag_mac.png` | Mac | The window that opens from the RStudio `.dmg`, with the RStudio icon and the Applications folder | An arrow from the RStudio icon to Applications |
| S09 | `00_posit_cloud_upload.png` | Browser | The Files pane in a Posit Cloud project | The **Upload** button |

Download pages (CRAN, Posit) are left as text on purpose: websites change more
often than RStudio does, and the steps name exactly what to click.
