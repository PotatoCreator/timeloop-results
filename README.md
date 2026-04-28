# TimeLoop Results

Static GitHub Pages site for TimeLoop event results. It generates event pages from `.demo` filenames, copies the fastest demos into a render queue, and lets you add Streamable links or uploaded video files after manual rendering.

## Quick Workflow

1. Put raw `.demo` files in any folder on your PC.
2. Run `create-event.bat`.
3. Enter the event name when asked.
4. Enter the folder that contains the event's `.demo` files.
5. Render the copied fastest demos manually.
6. Add rendered videos or Streamable links.
7. Run `update-results.bat`.
8. Commit and push to GitHub Pages.

## Create A New Event

From this project folder:

```text
C:\Users\PotatoEater\Desktop\Tloop\timeloop-results
```

double-click:

```text
create-event.bat
```

Or run:

```powershell
python generate_results.py --new-event
```

The script asks:

```text
Event name:
Folder with this event's .demo files:
Optional leaderboard .txt file path:
```

Example event name:

```text
TimeLoop Event 3
```

The script will create an event source folder under:

```text
C:\Users\PotatoEater\Desktop\Tloop\GamesDoneInfo
```

Then it generates the GitHub Pages event folder under:

```text
timeloop-results\events\<event-slug>
```

## Demo Filename Format

Demo files should use this format:

```text
MapName_by_Author_Player_12.34.demo
```

Example:

```text
Speedy_by_wee_KOT1K_03.90.demo
```

This is parsed as:

```text
Map: Speedy
Author: wee
Player: KOT1K
Time: 03.90
```

The time must use two digits after the dot, like `03.90` or `12.34`.

## Rendering Videos

After creating an event, fastest demos are copied here:

```text
events\<event-slug>\demos
```

This is only the render queue. It contains the best demo file or files per map, not every raw demo.

The full raw event demos stay here:

```text
C:\Users\PotatoEater\Desktop\Tloop\GamesDoneInfo\<event-slug>
```

Render those demos manually.

If you want to upload videos directly to GitHub, place rendered files here:

```text
events\<event-slug>\videos
```

Use the same filename stem as the demo.

Example:

```text
demos\Speedy_by_wee_KOT1K_03.90.demo
videos\Speedy_by_wee_KOT1K_03.90.mp4
```

Then run:

```powershell
python generate_results.py
```

The page will automatically show a `Watch` button for the local video file.

## Streamable Links

If you upload videos to Streamable instead, edit:

```text
events\<event-slug>\video_links.json
```

Example:

```json
{
  "Speedy_by_wee_KOT1K_03.90.demo": "https://streamable.com/example"
}
```

Then run:

```powershell
python generate_results.py
```

The page will use the Streamable link for the `Watch` button.

## Update Existing Pages

To rebuild the site after adding demos, videos, or links, double-click:

```text
update-results.bat
```

Or run:

```powershell
python generate_results.py
```

This regenerates:

```text
index.html
data\events.json
events\<event-slug>\index.html
events\<event-slug>\runs.json
events\<event-slug>\leaderboard.json
events\<event-slug>\maps.json
events\<event-slug>\video_links.json
```

## Generated Event Files

Each event folder contains:

```text
index.html         Event page
event.json         Event summary
runs.json          Fastest runs
leaderboard.json   Event leaderboard
maps.json          Per-map rankings
video_links.json   Streamable/link mapping
demos\             Local fastest demos to render, ignored by git
videos\            Optional rendered video files for GitHub Pages
```

## Leaderboards

If you provide a matching `.txt` leaderboard file during event creation, the generated page uses those official points.

If no leaderboard text file is provided, the script computes points from demo times:

- each map ranks players by best time
- faster times receive more points
- ties keep the same rank
- total points are summed into the event leaderboard

## GitHub Pages

Before pushing, make sure the generated site files are committed:

```powershell
git add .
git commit -m "Update TimeLoop results"
git push
```

GitHub Pages should serve:

```text
index.html
styles.css
data/
events/
```

The helper scripts and raw `.demo` render queue are ignored by `.gitignore`, so they do not get pushed by default:

```text
generate_results.py
create-event.bat
update-results.bat
events/*/demos/*.demo
```

Do not rely on local absolute paths after pushing. The generated pages use relative links for demos, videos, JSON, and styles.

## Troubleshooting

If a demo does not appear, check that:

- the file ends with `.demo`
- the filename ends with `_seconds.centiseconds.demo`
- the time has two digits after the dot
- the file is not a temporary lobby file

Temporary lobby files like this are skipped:

```text
lobby_52029_0_tmp.demo
```

If a player or map is split incorrectly, add the related `.map` file near `GamesDoneInfo` or the event folder, then regenerate.
