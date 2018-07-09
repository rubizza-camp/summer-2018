import glob
import sys
from collections import deque


class TerminalColors:
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    ENDC = '\033[0m'


class ReekFix:
    METHOD_PATTERN = 'def test_'
    CLASS_PATTERN = '< Neo::Koan'
    REEK_PATTERN = ':reek:'

    REEK_METHOD_NAME_FIX = '# This method smells of ' \
                           ':reek:UncommunicativeMethodName\n'

    REEK_VARIABLE_NAME_FIX = '# This method smells of ' \
                             ':reek:UncommunicativeVariableName\n'

    REEK_STATEMENT_FIX = '# This method smells of ' \
                         ':reek:TooManyStatements\n'

    REEK_FEATURE_ENVY_FIX = '# This method smells of ' \
                            ':reek:FeatureEnvy\n'

    REEK_CLASS_NAME_FIX = '# This class smells of ' \
                          ':reek:UncommunicativeModuleName\n'

    REEK_METHOD_FIXES = [
        REEK_METHOD_NAME_FIX,
        REEK_VARIABLE_NAME_FIX,
        REEK_STATEMENT_FIX,
        REEK_FEATURE_ENVY_FIX
    ]

    REEK_CLASS_FIXES = [
        REEK_CLASS_NAME_FIX
    ]


def fix_method():
    line_changed = False
    existed_fixes = deque()
    while idx - len(existed_fixes) - 1 >= 0 and ReekFix.REEK_PATTERN in \
            lines[idx - len(existed_fixes) - 1]:
        existed_fixes.append(lines[idx - len(existed_fixes) - 1].lstrip())

    for fix in ReekFix.REEK_METHOD_FIXES:
        if fix not in existed_fixes:
            content_to_write.append(
                ' ' * (len(line) - len(line.lstrip())) + fix)
            line_changed = True

    return line_changed


def fix_class():
    class_changed = False
    existed_fixes = deque()
    while idx - len(existed_fixes) - 1 >= 0 and ReekFix.REEK_PATTERN in \
            lines[idx - len(existed_fixes) - 1]:
        existed_fixes.append(lines[idx - len(existed_fixes) - 1].lstrip())

    for fix in ReekFix.REEK_CLASS_FIXES:
        if fix not in existed_fixes:
            content_to_write.append(
                ' ' * (len(line) - len(line.lstrip())) + fix)
            class_changed = True

    return class_changed


def write_log():
    if file_changed:
        print("{}modified - {}{}".format(TerminalColors.OKBLUE, koan_file,
                                         TerminalColors.ENDC))
    else:
        print("{}no changes - {}{}".format(TerminalColors.OKGREEN, koan_file,
                                           TerminalColors.ENDC))


for koan_file in glob.glob(sys.argv[1]):
    content_to_write = deque()
    with open(koan_file, "r+") as f:
        lines = f.readlines()
        file_changed = False
        for idx, line in enumerate(lines):
            if ReekFix.METHOD_PATTERN in line:
                file_changed |= fix_method()
            elif ReekFix.CLASS_PATTERN in line:
                file_changed |= fix_class()
            content_to_write.append(line)

        write_log()

    with open(koan_file, "w") as f:
        f.writelines(content_to_write)
