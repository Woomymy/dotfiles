#!/usr/bin/env python

"""
Download a random wallpaper from unsplash or choose one in ~/wallpapers
"""

from subprocess import DEVNULL, Popen
import urllib
from random import randint
from shutil import copyfile
from os import environ, listdir, mkdir, system
from os.path import exists, dirname
from hashlib import sha256
from os.path import dirname, realpath
from sys import argv, path as syspath

dotbinpath = realpath(f"{dirname(__file__)}/..")
syspath.append(dotbinpath)  # Because VSCode is stupid
syspath.append(f"{dotbinpath}/lib")

from mu import set_scheme, load_themes_d
from lib.checks import check_inet
from lib.logger import error, info
from psutil import process_iter

def set_wall(wallpath="/tmp/wallpaper.jpg"):
    for process in process_iter():
        if process.name() == "swaybg":
            try:
                process.kill()
            except:
                error("Can't kill swaybg", "wallpapers.py")

    Popen(['swaybg', "-i", wallpath, "-m", "fill"],
        stdout=DEVNULL, stderr=DEVNULL)

if not check_inet() or (len(argv) >= 2 and argv[1] == "--offline"):
    wallspath = f"{environ['HOME']}/wallpapers"
    unsplashpath = f"{environ['HOME']}/unsplash-wallpapers"
    
    if not exists(wallspath) and not exists(unsplashpath):
        error("Can't find wallpapers path", "WALLPAPERS")
        exit(1)
    
    walls = []
    
    if exists(wallspath):
        for wall in listdir(wallspath):
            if not wall.endswith(".json"):
                walls.append(f"{wallspath}/{wall}")

    if exists(unsplashpath):
        for wall in listdir(unsplashpath):
            if not wall.endswith(".json"):
                walls.append(f"{unsplashpath}/{wall}")

    try:
        finalwall = walls[randint(0, len(walls))]
    except:
        exit(1)
    if not exists(finalwall):
        error("Wallpaper not found, WTF", "WALLPAPERS")
        exit(1)

    info(f"Setting wallpaper to {finalwall}", "WALLPAPERS")
    # Use FEH to set the wallpaper
    set_wall(finalwall)
    set_scheme(finalwall)
else:
    dest = "/tmp/wallpaper-"
    try:
        with urllib.request.urlopen('http://source.unsplash.com/1920x1080/?wallpaper') as res:
            resbytes = res.read()
            wallhash = sha256(resbytes).hexdigest()
            dest += f"{wallhash}.jpg"
            open(dest, 'wb').write(resbytes)
    except Exception as e:
        error(f"Can't download wallpaper from unsplash! Error: {e}", "WALLPAPERS")
        system("notify-send -u critical Wallpaper.py \"Can\\'t reach unsplash\"")
        exit(1)
    info(f"Settings wallpaper from unsplash: {dest}", "WALLPAPERS")

    set_wall(dest)
    walldestpath = f"{environ['HOME']}/unsplash-wallpapers"
    if not exists(walldestpath):
        mkdir(walldestpath)

    copyfile(dest, f"{walldestpath}/{wallhash}.jpg")
    set_scheme(f"{walldestpath}/{wallhash}.jpg")

# Call the rest of scripts that generate themes
load_themes_d()
