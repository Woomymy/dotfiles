"""
Functions related to material you dynamic theming
"""


from posix import listdir
from posixpath import dirname, realpath
from shutil import copyfile
from subprocess import DEVNULL, Popen, check_output
from lib.config import get_config
from os.path import exists
from json import dumps, loads

from lib.logger import error, info

SCHEME_PATH = "/tmp/mu_scheme.json"
SCHEME_256_PATH = "/tmp/mu_scheme_256.json"

def gen_256_scheme(path: str):
    """
    Generate a 256 colors scheme based on mu_scheme by "converting" HEX colors to color indexes
    """
    with open(SCHEME_PATH, 'r') as full_scheme:
        scheme = loads(full_scheme.read())
        for color in scheme.keys():
            # The "type" key is an extra key that just contains theme type name
            # This shouldn't be converted
            if color == "type": continue
            try:
                scheme[color] = check_output(['hexto256', scheme[color].replace("#", "")]).decode("UTF-8").strip()
            except Exception as e:
                print(f"Can't convert {color}: {e}")

        with open(path, 'w') as out:
            out.write(dumps(scheme))

def set_scheme(path: str):
    """
    Generate/set material you scheme for {path}
    """
    config = get_config()
    theme = config.get("theme")
    dest = f"{path}_{theme}.json"
    # Generate color scheme using materugen
    if not exists(dest):
        try:
            Popen(['materugen', path, dest, theme], stderr=DEVNULL, stdout=DEVNULL).wait()
        except Exception as e:
            error(f"Can't generate scheme! {e}", "MU")

    copyfile(dest, SCHEME_PATH)
    info("Generated Material You scheme!", "MU")
    x256_scheme = f"{path}_{theme}_256.json"
    if not exists(x256_scheme):
        gen_256_scheme(x256_scheme)
    
    copyfile(x256_scheme, SCHEME_256_PATH)

    info("Generated 256colors scheme", "MU")

def load_themes_d():
    """
    Loads all scripts in themes.d
    """
    basepath = f"{realpath(dirname(__file__))}/themes.d"
    if exists(basepath):
        for file in listdir(basepath):
            info(f"Launching {file}", "THEMED")
            # Just spawn the files, don't care about interpreter and such
            Popen([f"{basepath}/{file}", SCHEME_PATH, SCHEME_256_PATH], stdout=DEVNULL, stderr=DEVNULL)

