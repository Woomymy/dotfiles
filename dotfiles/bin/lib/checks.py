from urllib.request import urlopen
from config import get_config
from logger import error, info
"""
Check if internet connection is aviable
"""


def check_inet():
    config = get_config()

    url = "{}://{}".format(config.get("ping_proto"), config.get("ping_domain"))
    info(f"Reaching {url} ...", "CHECK_INET")
    try:
        urlopen(url)
        return True
    except:
        error(f"Can't reach {url}, welp!", "CHECK_INET")
        return False
