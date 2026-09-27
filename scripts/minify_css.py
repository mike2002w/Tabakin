#!/usr/bin/env python3
"""Regenerate site.css (minified) from site.src.css (readable). Run from anywhere: python3 scripts/minify_css.py"""
import re, os
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
src = open(os.path.join(root, 'site.src.css'), encoding='utf-8').read()
m = re.sub(r'/\*.*?\*/', '', src, flags=re.S)
m = re.sub(r'\s+', ' ', m)
m = re.sub(r'\s*([{};:,>])\s*', r'\1', m)
m = m.replace(';}', '}').strip()
open(os.path.join(root, 'site.css'), 'w', encoding='utf-8').write(
    '/* Generated from site.src.css by scripts/minify_css.py. Edit the source file, then rerun the script. */\n' + m + '\n')
print('site.css written:', len(m.encode()), 'bytes')
