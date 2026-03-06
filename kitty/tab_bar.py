import re

def draw_title(data):

    # Format index.
    index = data['index']

    # Format title.
    path = re.compile(r"^~?(\/[^\t\n\/]*)*$")
    if path.match(data['title']):
        title = "shell"
    else:
        title = data['title'].split(' ')[0]
    max_title_length = max(data['max_title_length']-12, 2)
    if len(title) > max_title_length:
        title = title[:max_title_length-1] + '…'

    # Format layout indicator.
    layout = data['layout_name'][:2].upper()

    return f"-[{title}]-({layout})"
