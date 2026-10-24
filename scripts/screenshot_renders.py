"""Screenshots the HTML pages that `test_ui_headless.lua --render=<dir>` writes, one PNG next to each page.

Run: python scripts/screenshot_renders.py <dir> [page.html ...]
Uses Playwright when installed, else headless Edge or Chrome (override with the MDT_BROWSER environment variable).
"""
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

BROWSERS = [
    r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
    r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
    r"C:\Program Files\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
]


def page_size(page):
    head = page.read_text(encoding="utf-8", errors="ignore")[:4096]
    match = re.search(r'<meta name="mdt-size" content="(\d+) (\d+)">', head)
    if not match:
        sys.exit(f"{page}: no mdt-size meta tag; was it written by the headless renderer?")
    return int(match.group(1)), int(match.group(2))


def find_browser():
    candidates = [os.environ.get("MDT_BROWSER")] + BROWSERS
    candidates += [shutil.which(name) for name in ("msedge", "chrome", "google-chrome", "chromium")]
    for candidate in candidates:
        if candidate and Path(candidate).is_file():
            return candidate
    sys.exit("no Playwright and no Edge/Chrome found; set MDT_BROWSER to a Chromium-based browser")


def shoot_with_playwright(pages):
    from playwright.sync_api import sync_playwright

    with sync_playwright() as playwright:
        browser = playwright.chromium.launch()
        for page_path in pages:
            width, height = page_size(page_path)
            page = browser.new_page(viewport={"width": width, "height": height})
            page.goto(page_path.resolve().as_uri())
            page.wait_for_load_state("load")
            page.screenshot(path=str(page_path.with_suffix(".png")))
            page.close()
            print(page_path.with_suffix(".png"))
        browser.close()


def shoot_with_browser(pages):
    browser = find_browser()
    for page_path in pages:
        width, height = page_size(page_path)
        output = page_path.with_suffix(".png").resolve()
        subprocess.run([
            browser, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1",
            "--allow-file-access-from-files", f"--window-size={width},{height}", f"--screenshot={output}",
            page_path.resolve().as_uri(),
        ], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=120)
        print(output)


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    directory = Path(sys.argv[1])
    pages = [directory / name for name in sys.argv[2:]] or sorted(directory.glob("*.html"))
    if not pages:
        sys.exit(f"no .html pages in {directory}")
    try:
        import playwright.sync_api  # noqa: F401
    except ImportError:
        shoot_with_browser(pages)
    else:
        shoot_with_playwright(pages)


if __name__ == "__main__":
    main()
