#!/usr/bin/python3

from sys import argv as argv
from sys import exit as exit
from os import environ as environ
from os import remove as remove
from os import path as path
from os import listdir as listdir
from datetime import datetime as datetime
from time import sleep as sleep
from yaml import safe_load as yaml_load

# this splits all args passed to the script so they can be used.
# args are passed like this "/path/to/session/files/dir/ COMMAND flag <?filename> flag <?filename> flag <filename> <?filename>"
# since some flags can be given filenames, they must be split out to be parsed
def split_out_args(args):
    split_args = []
    # flip args list so as to iterate backwards, saves iteration
    args.reverse()
    # split the list by flag
    for arg in args:
        if arg[0] == "-":
            split_args.append(args[:(args.index(arg)+1)])
            args = args[(args.index(arg)+1):]
    # flip every list in the master list back to normal
    for lst in split_args:
        lst.reverse()
    # reverse master list so that all elements are in order
    split_args.reverse()
    return split_args

# generic function to check for a specified flag and return it's arguments
def check_flags(args, flag):
    flag_found = False
    flag_args = []
    for arg in args:
        if arg[0] == flag:
            flag_found = True
            flag_args = arg
            break
        else:
            flag_args = []
    return flag_found, flag_args

# read HTML, return list of tabs
def parse_html(html):
    # get the tabs from the body
    tabs = html.split('<p style="word-wrap: break-word; word-break: break-all;">')[1].split('</p>')[0].split('<br>\n<br>\n')
    tabs = tabs[:-1]
    tabs_list = []
    # parse out the tabs from the body into list of tabs, [[url,title],[url,title]...]
    for tab in tabs:
        stuff = tab.split('  |  ')[0].split('>')
        title = stuff[1]
        url = stuff[0].split('"')[1]
        tab_info = [url, title]
        tabs_list.append(tab_info)
    return tabs_list

# open and read an HTML file
def read_html(session_path):    
    with open(session_path + ".html", "r") as html_file:
        html = html_file.read()
    return html

# build HTML from list of tabs
def build_html(session_path, open_tabs):
    # get the file name from session path
    doc_title = session_path.split("/")[-1].split(".")[0]
    # build html document title from document title, number of tabs and date and time
    title = str(doc_title + ", " + str(len(open_tabs)) + " tabs, last updated " + str(datetime.now()).split(".")[0])
    doc_body = str()
    # iterate over tabs, build HTML for the body of the HTML file
    for tab in open_tabs:
        tab_line = str(open_tabs.index(tab) + 1) + '. <a href="' + tab[0] + '">' + tab[1] + '  |  ' + tab[0] + '</a>\n<br>\n<br>\n'
        doc_body = doc_body + tab_line
    # build the HTML document
    html_doc = '<html>\n<head>\n<title>' + title + '</title>\n</head>\n<body>\n<p style="word-wrap: break-word; word-break: break-all;">\n' + doc_body + "</p>\n</body>\n</html>"
    return html_doc

# writes HTML to specified file
def write_html(session_path, html):
    with open(session_path + ".html", "w+") as html_file:
        html_file.write(html)
    
# takes 1 list of tabs, checks for duplicate tabs in the same list
# turns tabs list [[url,title],[url,title]...] into dict with URLs as keys, since duplicate keys are automatically removed from dicts
def check_for_duplicate_tabs(tabs_list):
    tabs_list_dict = {}
    tabs_list_new = []
    for tab in tabs_list:
        tabs_list_dict[tab[0]] = tab[1]
    for item in tabs_list_dict.items():
        tabs_list_new.append([item[0],item[1]])
    return tabs_list_new

# update the index file, to be called any time a modification to a tab session occurs
def update_index_file(session_path):
    sessions_list = []
    for item in listdir(session_path):
        filename = item.split(".")
        if filename[1] == "html" and item != "index.html":
            sessions_list.append(["file:///" + session_path + item, read_html(session_path + filename[0]).split("</title>")[0].split("<title>")[1]])
    index_path = session_path + "index"
    write_html(index_path, build_html(index_path, sessions_list))    

# inform of an error, open the usage.txt file in browser, exit the program
def inform_error(toast):
    usage_file_path = script_path.replace("tab-manager.py", "usage.txt")
    run_command("open -t file://" + usage_file_path)
    run_command("message-error '" + toast + "'")
    exit()

# run a command in qutebrowser
def run_command(command):
    with open(environ["QUTE_FIFO"], "a") as output:
        output.write(command)
    sleep(wait_time)

# reads the qutebrowser session file, return the yaml inside
def read_qutebrowser_session_file(session_path):
    with open(session_path, "r") as session:
        session_data = session.read()
    return session_data

# pass session data as yaml, "history" and "all_windows" as bool, return required tabs
# if export_history is true, returns history, otherwise only returns active tabs, if all_windows is true, returns all windows, otherwise only returns the active window
# yaml ugh, fucking hyphen delimited dict
def get_qbsession_tabs(session_data, export_history=False, all_windows=False):
    # for history in ['windows']['tabs']['history']
    yaml_content = yaml_load(session_data)
    tabs = []
    for window in yaml_content['windows']:
        if all_windows == False:
            if 'active' in window:
                for tab in window['tabs']:
                    for history in tab['history']:
                        if export_history == False:
                            if 'active' in history:
                                tabs.append([history['url'], history['title']])
                        else:
                            tabs.append([history['url'], history['title']])
        else:
            for tab in window['tabs']:
                for history in tab['history']:
                    if export_history == False:
                        if 'active' in history:
                            tabs.append([history['url'], history['title']])
                    else:
                        tabs.append([history['url'], history['title']])
    return tabs

# saves focused tab to specified session file unless it is already in there
def save(session_path, args):
    tab = [[environ["QUTE_URL"], environ["QUTE_TITLE"]]]
    check_f = check_flags(args, "-f")
    if not check_f[0] or len(check_f[1]) < 2:
        inform_error("no -f or no output session specified!")
    if "index" in check_f[1]:
        inform_error("cannot modify index!")
    file_path = session_path + check_f[1][1]
    if path.exists(file_path + ".html"):
        tabs_list = parse_html(read_html(file_path))
        tabs_list = tabs_list + tab
        tabs_list = check_for_duplicate_tabs(tabs_list)
    else:
        tabs_list = tab
    write_html(file_path, build_html(file_path, tabs_list))
    update_index_file(session_path)
    run_command("message-info 'focused tab successfully saved to " + check_f[1][1] + "'")

# saves all open tabs to a session file, removes duplicates
def save_all(session_path, args):
    open_tabs = []
    check_f = check_flags(args, "-f")
    if not check_f[0] or len(check_f[1]) < 2:
        inform_error("no -f or no output session specified!")
    if "index" in check_f[1]:
        inform_error("cannot modify index!")
    file_path = session_path + check_f[1][1]
    close_tabs = check_flags(args, "-c")[0]
    overwrite = check_flags(args, "-o")[0]
    run_command("session-save " + file_path)
    open_tabs = get_qbsession_tabs(read_qutebrowser_session_file(file_path))
    # remove the recently created qutebrowser session file that has no extension, not the .html file.
    remove(file_path)
    if overwrite == True:
        open_tabs = check_for_duplicate_tabs(open_tabs)
        write_html(file_path, build_html(file_path, open_tabs))
        run_command("message-info '-o found, overwriting specified session'")
    else:
        if not path.exists(file_path + ".html"):
            run_command("message-info 'session " + check_f[1][1] + " does not exist; creating...'")
            with open(file_path + ".html", "w"): pass
        else:
            open_tabs = parse_html(read_html(file_path)) + open_tabs
        open_tabs = check_for_duplicate_tabs(open_tabs)
        write_html(file_path, build_html(file_path, open_tabs))
    update_index_file(session_path)
    run_command("message-info 'all open tabs sucessfully saved to " + check_f[1][1] + "'")
    if close_tabs == True:
        run_command("tab-only")
        run_command("open " + file_path + ".html")
        run_command
    else:
        run_command("open -t " + file_path + ".html")
        pass

# open command, opens one or more html files
def open_session_files(session_path, args):
    check_f = check_flags(args, "-f")
    files_specified = check_f[0]
    if len(check_f[1]) < 2: 
        files_specified = False
    if files_specified == True:
        for file in check_f[1][1:]:
            run_command("open -t " + "file:///" + session_path + file + ".html")
            run_command("message-info 'successfully opened " + file + "'")
    else:
        run_command("open -t " + "file:///" + session_path + "index.html")
        run_command("message-info 'no session file specified, opening index.'")

# restore command, restores one or more sessions to one window
def restore_sessions(session_path, args):
    check_f = check_flags(args, "-f")
    files_list = []
    # if no file specified, attempt to restore the current focused tab, works if current focused tab is a session file in the specified session files directory.
    if not check_f[0] or len(check_f[1]) < 2:
        open_session_file = environ["QUTE_URL"]
        if session_path in open_session_file:
            files_list = [open_session_file.split("/")[-1].split(".")[0]]
        else:
            inform_error("you must specify sessions to restore or have a session file open in browser and in focus!")
    else:
        files_list = check_f[1][1:]
    close_tabs = check_flags(args, "-c")[0]
    new_window = check_flags(args, "-n")[0]
    if close_tabs == True:
        run_command("tab-only")
        run_command("message-info '-c found, closing all open tabs before restoring...'")
    for file in files_list:
        tab_list = parse_html(read_html(session_path + file))
        for tab in tab_list:
            if close_tabs == True:
                run_command("open " + tab[0])
                close_tabs = False
            else:
                run_command("open -t " + tab[0])
        run_command("message-info 'successfully restored " + file + "'")

# removes the specified session files
def delete_sessions(session_path, args):
    check_f = check_flags(args, "-f")
    if not check_f[0] or len(check_f[1]) < 2:
        inform_error("you must specify sessions to delete!")
    for file in check_f[1][1:]:
        if file == "index":
            inform_error("cannot modify index!")
        file_path = session_path + file
        remove(file_path + ".html")
        run_command("message-info 'session " + file + " successfully deleted.'")
    update_index_file(session_path)

# merge specified sessions, or unspecified sessions in dir, based on -i or -a flag respectively
def merge_sessions(session_path, args):
    sessions_to_merge = []
    final_session_tabs = []
    check_f = check_flags(args, "-f")
    if not check_f[0] or len(check_f[1]) < 2:
        inform_error("missing -f or no output session name specified!")
    file_path = session_path + check_f[1][1]
    check_i = check_flags(args, "-i")
    check_a = check_flags(args, "-a")
    if "index" in check_i[1]:
        inform_error("cannot modify index!")
    if "index" in check_f[1]:
        inform_error("cannot modify index!")
    if check_i[0] and check_a[0]:
        inform_error("cannot use -i and -a at the same time!")
    elif not check_i[0]:
        if not check_a[0]:
            inform_error("must use -a or -i flag in merge command!") 
        else:
            if len(check_a[1]) < 2:
                inform_error("-a found but no files specified")
            for item in listdir(session_path):
                if item.split(".")[1] == "html" and item != "index.html" and item.split(".")[0] not in check_a[1][1:]:
                        sessions_to_merge.append(item.split(".")[0])
    else:
        if len(check_i[1]) < 2:
            inform_error("-i found but no files specified!")
        for item in check_i[1][1:]:
            sessions_to_merge.append(item)
    for item in sessions_to_merge:
        for tab in parse_html(read_html(session_path + item)):
            final_session_tabs.append(tab)
    # if -k flag not found, delete merged sessions
    if not check_flags(args, "-k")[0]:
        for item in sessions_to_merge:
            remove(session_path + item + ".html")
            run_command("message-info '" + item + " deleted.'")
    else:
        run_command("message-info '-k found, input sessions not deleted.'")
    final_session_tabs = check_for_duplicate_tabs(final_session_tabs)
    write_html(file_path, build_html(file_path, final_session_tabs))
    run_command("message-info 'specified sessions merged to " + check_f[1][1] + "'")
    update_index_file(session_path)

# export specified qutebrowser session file into html session file
def export_session(session_path, args):
    check_f = check_flags(args, "-f")
    check_p = check_flags(args, "-p")
    if not check_f[0] or len(check_f[1]) < 2:
        file_path = session_path + check_p[1][1].split("/")[-1].split(".")[0]
    else:
        file_path = session_path + check_f[1][1]
    if "index" == file_path.split("/")[-1]:
        inform_error("cannot modify index!")
    if path.exists(file_path + ".html"):
        inform_error("a file with the same name as the output file already exists. Please specify a different file name for export.") 
    if not check_p[0] or len(check_p[1]) < 2:
        inform_error("missing -p or no qutebrowser session file specified!")
    session_file = check_p[1][1]
    session_tabs = []
    export_history = check_flags(args, "-h")[0]
    all_windows = check_flags(args, "-w")[0]
    session_tabs = get_qbsession_tabs(read_qutebrowser_session_file(session_file), export_history, all_windows)
    session_tabs = check_for_duplicate_tabs(session_tabs)
    write_html(file_path, build_html(file_path, session_tabs))
    run_command("message-info 'specified qutebrowser session successfully exported to " + file_path + ".html'")
    if check_flags(args, "-r")[0] == True:
        remove(session_file)
        run_command("message-info '-r found, deleting specified qutebrowser session'")
    update_index_file(session_path)
    run_command("open -t file:///" + file_path + ".html")

# remove a tab from a session file by it's index
def remove_tab(session_path, args):
    check_f = check_flags(args, "-f")
    check_t = check_flags(args, "-t")
    if not check_t[0]:
        inform_error("-t missing or no index specified! You must specify one or more links to remove from the session!")
    if not check_f[0] or len(check_f[1]) < 2:
        open_tab = environ["QUTE_URL"]
        if session_path in open_tab:
            file_path = open_tab.split(".")[0].split("//")[1]
        else:
            inform_error("you must specify a session to modify or have a session file open in browser and in focus!")
    else:
        file_path = session_path + check_f[1][1]
    if "index" == file_path.split("/")[-1]:
        inform_error("cannot modify index!")
    tab_list = parse_html(read_html(file_path))
    indexes_list = check_t[1][1:]
    indexes_int = []
    for ind in indexes_list:
        indexes_int.append(int(ind))
    indexes_int.sort(reverse=True)
    for ind in indexes_int:
        tab_list.pop(ind - 1)
    write_html(file_path, build_html(file_path, tab_list))
    update_index_file(session_path)
    if not check_f[0] or len(check_f[1]) < 2:
        run_command("reload")
        # TODO check if session is now empty, if so load index file and delete the session

# changes the title in the file, changes the name of the file, updates index
def rename_session(session_path, args):
    check_f = check_flags(args, "-f")
    if not check_f[0] or len(check_f[1]) < 2:
        open_tab = environ["QUTE_URL"]
        if session_path in open_tab:
            file_path = open_tab.split(".")[0].split("//")[1]
            old_filename = file_path.split("/")[-1]
        else:
            inform_error("you must specify a session to modify or have a session file open in browser and in focus!")
    else:
        old_filename = check_f[1][1]
        file_path = session_path + old_filename
    if "index" == old_filename:
        inform_error("cannot modify index!")
    check_n = check_flags(args, "-n")
    if not check_n[0] or len(check_n[1]) < 2:
        inform_error("missing -n or no output session specified! what do you want to change the name to?")
    new_filename = check_n[1][1]
    html_doc = read_html(file_path).replace("<title>" + old_filename, "<title>" + new_filename)
    write_html(session_path + new_filename, html_doc)
    remove(file_path + ".html")
    update_index_file(session_path)
    run_command("message-info '" + old_filename + " successfully renamed to " + new_filename + "'")
    if not check_f[0] or len(check_f[1]) < 2:
        run_command("open " + session_path + new_filename + ".html")

def run():
    sessions_path = argv[1]
    if len(argv) < 3:
        inform_error("no command given!")
    command = argv[2]
    if len(argv) > 3:
        args = split_out_args(argv[3:])
    else:
        args = []
    if command == "save":
        save(sessions_path, args)
    elif command == "save-all":
        save_all(sessions_path, args)
    elif command == "open":
        open_session_files(sessions_path, args)
    elif command == "restore":
        restore_sessions(sessions_path, args)
    elif command == "merge":
        merge_sessions(sessions_path, args)
    elif command == "delete":
        delete_sessions(sessions_path, args)
    elif command == "export":
        export_session(sessions_path, args)
    elif command == "remove":
        remove_tab(sessions_path, args)
    elif command == "rename":
        rename_session(sessions_path, args)
    elif command == "update-index":
        update_index_file(sessions_path)
        run_command("message-info 'index updated.'") 
    elif command == "help":
        inform_error("everybody needs a little help sometimes.")
    else:
        inform_error("invalid command!")

script_path = argv[0]
wait_time = 0.3
print(argv)
run()
