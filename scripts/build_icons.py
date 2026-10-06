"""Render the original orbital mark as opaque PNGs with Python's standard library.

Geometry is code-owned so small launcher icons remain crisp without downloaded art.
Run: python scripts/build_icons.py. This regenerates web icons and the Apple icon.
"""
from pathlib import Path
import math
import struct
import zlib

ROOT = Path(__file__).resolve().parent.parent


def mix(a, b, ratio):
    return tuple(a[i] * (1 - ratio) + b[i] * ratio for i in range(3))


def pixel(x, y):
    background = mix((25, 28, 36), (54, 58, 68), max(0, min(1, .55 - .3*x - .35*y)))
    rx, ry = .9004*x - .4350*y, .4350*x + .9004*y
    ellipse = math.sqrt((rx/.70)**2 + (ry/.235)**2)
    ring = .85 < ellipse < 1.13
    ring_color = mix((101, 86, 130), (222, 211, 240), max(0, min(1, .5 - rx*.3 - ry*.8)))
    if ring:
        background = ring_color
    radius = math.hypot(x+.025, y+.015)
    if radius < .39:
        nx, ny = (x+.025)/.39, (y+.015)/.39
        nz = math.sqrt(max(0, 1-nx*nx-ny*ny))
        light = max(0, min(1, -.4*nx-.5*ny+.75*nz))
        background = mix((47, 75, 75), (191, 228, 210), light)
    if ring and ry > 0:
        background = ring_color
    satellite = math.hypot(x-.43, y+.47)
    if satellite < .065:
        background = mix((183, 119, 98), (255, 215, 185), max(0,min(1,.6-3*(x-.43)-4*(y+.47))))
    return background


def chunk(kind, data):
    return struct.pack('!I',len(data))+kind+data+struct.pack('!I',zlib.crc32(kind+data)&0xffffffff)


def render(size, path):
    rows = bytearray()
    # Four subpixel samples smooth the diagonal orbital ring at launcher sizes.
    for row in range(size):
        rows.append(0)
        for col in range(size):
            values = [pixel(2*(col+dx)/size-1,2*(row+dy)/size-1) for dx,dy in ((.25,.25),(.75,.25),(.25,.75),(.75,.75))]
            rows.extend(round(sum(value[channel] for value in values)/4) for channel in range(3))
    header=struct.pack('!2I5B',size,size,8,2,0,0,0)
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_bytes(b'\x89PNG\r\n\x1a\n'+chunk(b'IHDR',header)+chunk(b'IDAT',zlib.compress(rows,9))+chunk(b'IEND',b''))
    print(f'Rendered {path.relative_to(ROOT)} ({size}px)')


if __name__ == '__main__':
    for size in (180,192,512):
        render(size,ROOT/f'web/icons/orbit-{size}.png')
    render(1024,ROOT/'Scheduler/Assets.xcassets/AppIcon.appiconset/AppIcon.png')
