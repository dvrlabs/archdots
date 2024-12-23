from yt_dlp import YoutubeDL
import sys
import os
import pyperclip

def cd(path):
    os.chdir(os.path.expanduser(path))

try:
    songURL = pyperclip.paste()
except IndexError:
    print("Please copy url")
    sys.exit(-1)

with YoutubeDL({}) as YT:
    info = YT.extract_info(songURL, download=False)
    jinfo = YT.sanitize_info(info)

    # for k,v in jinfo.items():
    #      print(f"{k} : {v}")

    title = jinfo["title"]
    uploader = jinfo["uploader"]


fn1 = f"{title}"
fn2 = f"{title} - {uploader}"
fn3 = "( Manually name the file. )"

usel = None
while usel not in ["1", "2", "3"]:
    print('\n')
    print("Below are the available filenames.")
    print("Please select number: ")
    print('\n')
    print(f"(1) {fn1}")
    print(f"(2) {fn2}")
    print(f"(3) {fn3}")
    usel = input("> ")

if usel == "1": fname = fn1
if usel == "2": fname = fn2
if usel == "3": fname = input("\nFilename? (no ext): \n> ") 

fname += ".m4a"

URLS = []
URLS.append(songURL)

cd("~/Music")
opts = {
    'outtmpl': fname,
    'format': 'm4a/bestaudio/best',
    'postprocessors': [{  
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'm4a',
    }]
}


with YoutubeDL(opts) as YT:
    print(f"Result: {YT.download(URLS)}")
    

