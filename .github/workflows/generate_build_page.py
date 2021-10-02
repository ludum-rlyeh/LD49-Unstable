import sys
from pathlib import Path

template = """
# Builds

{}
"""

link_tmpl = "[{}]({{static}}/{})"

folder = sys.argv[1]
generated_list = ""

for path in Path(folder).rglob("*/index.html"):
    static_path = str(path).split("/")[1:]

    generated_list += "- " + link_tmpl.format(
        static_path[-3] + " - " + static_path[-2],
        "/".join(static_path)) + "\n"

print(template.format(generated_list))