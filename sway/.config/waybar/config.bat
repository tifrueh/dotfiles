{
    "height": 30,
    "spacing": 0,
    "modules-left": ["sway/workspaces", "sway/window"],
    "modules-center": ["custom/clock"],
    "modules-right": ["mpris", "idle_inhibitor", "wireplumber", "cpu", "memory", "disk", "battery", "tray", "custom/suspend"],
    "sway/workspaces": {
        "format": " {name} ",
        "disable-scroll": true
    },
    "sway/window": {
        "format": "{title}",
        "max-length": 40
    },
    "custom/clock": {
        "interval": 1,
        "format": "{}",
        "exec": "date +'%F %T %z'"
    },
    "mpris": {
        "interval": 1,
        "format": "{status_icon}",
        "dynamic-importance-order": [
            "title",
            "position",
            "length",
            "artist",
            "album"
        ],
        "status-icons": {
            "paused": "",
            "playing": "",
            "stopped": ""
        },
        "tooltip": true,
        "tooltip-format": "{player}: {dynamic}"
    },
    "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": "󰅶",
            "deactivated": "󰾪"
        }
    },
    "wireplumber": {
        "interval": 1,
        "format": "{volume}% ",
        "format-muted": "",
        "tooltip": true,
        "tooltip-format": "{node_name}: {volume}%"
    },
    "cpu": {
        "interval": 10,
        "format": "{usage}% ",
        "tooltip": true
    },
    "memory": {
        "interval": 10,
        "format": "{percentage}% / {swapPercentage}% ",
        "tooltip": true,
        "tooltip-format": "Memory: {used} GiB / {total} GiB used\nSwap: {swapUsed} GiB / {swapTotal} GiB used"
    },
    "disk": {
        "interval": 60,
        "format": "{percentage_used}% ",
        "tooltip": true,
        "tooltip-format": "{used} GiB / {total} GiB used on {path}"
    },
    "battery": {
        "interval": 60,
        "states": {
            "warning": 30,
            "critical": 15
        },
        "events": {
            "on-discharging-warning": "notify-send -u normal 'Low Battery'",
            "on-discharging-critical": "notify-send -u critical 'Very Low Battery'",
            "on-charging-100": "notify-send -u normal 'Battery Full!'",
            "on-discharging": "notify-send -u normal 'Power Switch' Discharging",
            "on-charging": "notify-send -u normal 'Power Switch' Charging'"
        },
        "format": "{capacity}% {icon}",
        "format-icons": {
            "default": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
            "charging": ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]
        },
        "max-length": 25
    },
    "tray": {
        "icon-size": 16,
        "spacing": 10
    },
    "custom/suspend": {
        "format": "󰤁",
        "on-click": "systemctl suspend",
        "tooltip": true,
        "tooltip-format": "Suspend system"
    }
}
