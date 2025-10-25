#!/usr/bin/env python3
import os
import time
import argparse
from datetime import datetime, timedelta
import subprocess
from threading import Timer
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


MUSESCORE_CMD = "mscore"

# Track timers per file
timers = {}

def generate_pdf(filepath):
    generation_time = time.strftime('_%Y-%m-%d_%H:%M:%S')
    pdf_file = os.path.splitext(filepath)[0] + generation_time + ".pdf"
    if os.path.exists(pdf_file) and os.path.getmtime(pdf_file) >= os.path.getmtime(filepath):
        print(f"[{time.strftime('%H:%M:%S')}] PDF up-to-date: {pdf_file}")
        return
    print(f"[{generation_time}] Generating PDF: {filepath}")
    result = subprocess.run(["xvfb-run", "-a", MUSESCORE_CMD, "-o", pdf_file, filepath], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    if result.returncode == 0:
        print(f"Generated pdf {pdf_file}")



def schedule_pdf(filepath, debounce_time):
    # Cancel existing timer if present
    if filepath in timers:
        timers[filepath].cancel()
        print(f"[{time.strftime('%H:%M:%S')}] Canceled pdf export for {filepath} due to new file modification")

    # Schedule a new timer
    timer = Timer(debounce_time, generate_pdf, args=[filepath])
    timers[filepath] = timer
    timer.start()
    scheduled_time = datetime.now() + timedelta(seconds=debounce_time)
    print(f"[{datetime.now().strftime('%H:%M:%S')}] Scheduled PDF generation for {filepath} at {scheduled_time.strftime('%H:%M:%S')}")

class MuseScoreHandler(FileSystemEventHandler):
    def __init__(self, debounce_time):
        self.debounce_time = debounce_time
    def on_modified(self, event):
        if event.is_directory:
            return
        ext = os.path.splitext(event.src_path)[1].lower()
        if ext in [".mscz", ".mscx"]:
            schedule_pdf(event.src_path, self.debounce_time)

    def on_created(self, event):
        self.on_modified(event)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                    prog='Musescore pdf generator',
                    description='Automatically generates pdf when musescore files has changed',
                    epilog='Text at the bottom of help')
    parser.add_argument('-p', '--path', required=True, help="path of musescore files")
    parser.add_argument('-t', '--time', default=30, type=int, help="Time to wait in seconds to generate pdf\n after source files has changed.")
    args = parser.parse_args()
    observer = Observer()
    observer.schedule(MuseScoreHandler(args.time), args.path, recursive=True)
    observer.start()
    print(f"[{time.strftime('%H:%M:%S')}] Watching {args.path} for MuseScore files...")
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

