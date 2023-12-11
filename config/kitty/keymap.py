# Kitten to print the current list of keyboard shortcuts
#
# Place this in ~/.config/kitty/keymap.py then
# Add "map kitty_mod+/ kitty keymap.py" to your kitty.conf
from kitty import fast_data_types
import re
from collections import OrderedDict

# List of categories and regular expressions to match actions on
categories = OrderedDict((
    ('Scrolling', r'(^scroll_|show_scrollback|show_last_command_output)'),
    ('Tab Management', r'((^|_)tab(_|$)|next_layout)'),
    ('Window Management', r'(^|_)windows?(_|$)'),
    ('Other Shortcuts', r'.'),
))


def main(args):
    return ''


def handle_result(args, answer, target_window_id, boss):
    opts = fast_data_types.get_options()
    keymap = opts.keymap

    header = ["Kitty keyboard mappings", "=" * 23, ""]
    output_categorized = {}

    for key, action in keymap.items():
        for category in categories:
            if re.search(categories[category], action):
                break

        output_categorized.setdefault(category, []).append(
            f'{key.human_repr} → {action}')

    output = header.copy()
    for category in categories:
        if category in output_categorized:
            output.extend([category, "=" * len(category), ""])
            output.extend(output_categorized[category])
            output.append("")

    boss.display_scrollback(boss.active_window, "\n".join(output[:-1]),
                            title="Kitty keyboard mappings",
                            report_cursor=False)
