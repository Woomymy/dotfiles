from logger import error
from os import environ
from os.path import exists
import json


def get_config():
    default_config = {
        "battery": "BAT1",  # From /sys/class/power_supply/BAT*
        "ping_domain": "kernel.org",  # Whatever you want
        "ping_proto": "https",  # WARNING: TLS Errors
        "theme": "dark",  # Materugen theme
        "music_source": "tdesktop"  # PlayerCtl music source
    }
    confpath = f"{environ['HOME']}/.bin/config.json"
    if exists(confpath):
        try:
            with open(confpath, 'r') as configtext:
                config = json.loads(configtext.read())
        except:
            error(
                f"Can't load {confpath}! Using default config instead", "CONFIG")
            config = default_config
    else:
        error(
            f"Config file {confpath} not found. Using default config", "CONFIG")
        config = default_config

    return config
