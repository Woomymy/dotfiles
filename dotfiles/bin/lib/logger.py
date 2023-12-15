from systemd.journal import send as sendlog

def error(msg="", src="unknown"):
    sendlog(msg, SYSLOG_IDENTIFIER=f"dotlog#{src}", PRIORITY=1)

def info(msg="", src="unknown"):
    sendlog(msg, SYSLOG_IDENTIFIER=f"dotlog#{src}", PRIORITY=6)

