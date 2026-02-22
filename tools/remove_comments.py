#!/usr/bin/env python3
import io
import os
import re

def remove_comments_from_dart(src: str) -> str:
    out = []
    i = 0
    n = len(src)
    # States
    in_sing = False
    in_doub = False
    in_triple_sing = False
    in_triple_doub = False
    in_raw = False
    in_line_comment = False
    in_block_comment = False
    while i < n:
        ch = src[i]
        nxt = src[i+1] if i+1 < n else ''

        if in_line_comment:
            if ch == '\n':
                in_line_comment = False
                out.append(ch)
            # else skip
            i += 1
            continue

        if in_block_comment:
            if ch == '*' and nxt == '/':
                in_block_comment = False
                i += 2
            else:
                i += 1
            continue

        # Not in comment
        # Check for start of line comment
        if ch == '/' and nxt == '/':
            in_line_comment = True
            i += 2
            continue

        # Check for start of block comment
        if ch == '/' and nxt == '*':
            in_block_comment = True
            i += 2
            continue

        # Strings handling (simple)
        # Handle raw string prefix r or R
        if ch in "rR" and (nxt == '"' or nxt == "'"):
            # raw string start
            out.append(ch)
            i += 1
            ch = src[i]
            nxt = src[i+1] if i+1 < n else ''
            quote = ch
            # check triple
            if src[i:i+3] == quote*3:
                out.append(quote*3)
                i += 3
                while i < n and src[i:i+3] != quote*3:
                    out.append(src[i])
                    i += 1
                if i < n:
                    out.append(quote*3)
                    i += 3
                continue
            else:
                out.append(quote)
                i += 1
                while i < n:
                    if src[i] == quote:
                        out.append(quote)
                        i += 1
                        break
                    else:
                        out.append(src[i])
                        i += 1
                continue

        # Normal string start
        if ch == "'" or ch == '"':
            quote = ch
            # check triple
            if src[i:i+3] == quote*3:
                out.append(quote*3)
                i += 3
                while i < n and src[i:i+3] != quote*3:
                    # handle escapes inside triple-quoted strings
                    out.append(src[i])
                    i += 1
                if i < n:
                    out.append(quote*3)
                    i += 3
                continue
            else:
                out.append(quote)
                i += 1
                while i < n:
                    ch2 = src[i]
                    if ch2 == '\\':
                        out.append(ch2)
                        if i+1 < n:
                            out.append(src[i+1])
                            i += 2
                        else:
                            i += 1
                        continue
                    if ch2 == quote:
                        out.append(quote)
                        i += 1
                        break
                    out.append(ch2)
                    i += 1
                continue

        # default: copy char
        out.append(ch)
        i += 1

    return ''.join(out)

def process_file(path):
    with io.open(path, 'r', encoding='utf-8') as f:
        src = f.read()
    new = remove_comments_from_dart(src)
    if new != src:
        with io.open(path, 'w', encoding='utf-8') as f:
            f.write(new)
        print(f"Updated: {path}")

def main():
    root = os.getcwd()
    for dirpath, dirs, files in os.walk(root):
        # skip build and .git
        if 'build' in dirpath.split(os.sep) or '.git' in dirpath.split(os.sep):
            continue
        for fn in files:
            if fn.endswith('.dart'):
                process_file(os.path.join(dirpath, fn))

if __name__ == '__main__':
    main()
