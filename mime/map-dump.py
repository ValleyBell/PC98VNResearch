#!/usr/bin/env python3
# MIME Map dumper
# Written by Valley Bell, 2024-11-08
import sys
import argparse
import pathlib
import struct
import PIL.Image	# requires "pillow" pip package

GRID_X = 16
GRID_Y = 16
MAP_COUNT = 15

MAP_TILE_RECTS = {
	0x00: 0x0A0A,
	0x01: 0x1E04,
	0x02: 0x2302,
	0x03: 0x2304,
	0x04: 0x1E00,
	0x05: 0x461E,
	0x06: 0x2300,
	0x07: 0x230A,
	0x08: 0x1902,
	0x09: 0x1904,
	0x0A: 0x411E,
	0x0B: 0x1E0C,
	0x0C: 0x1900,
	0x0D: 0x190A,
	0x0E: 0x1E08,
	0x0F: 0x1E02,
	0x10: 0x0A04,
	0x12: 0x3702,
	0x14: 0x411A,
	0x16: 0x371A,
	0x18: 0x3202,
	0x1A: 0x3224,
	0x1C: 0x2D12,
	0x1E: 0x4108,
	0x20: 0x0F02,
	0x21: 0x4602,
	0x24: 0x4600,
	0x25: 0x3722,
	0x28: 0x4116,
	0x29: 0x3214,
	0x2C: 0x3218,
	0x2D: 0x4608,
	0x30: 0x0F04,
	0x34: 0x2312,
	0x38: 0x1E1C,
	0x3C: 0x410C,
	0x40: 0x0A00,
	0x41: 0x461A,
	0x42: 0x3700,
	0x43: 0x3712,
	0x48: 0x3200,
	0x49: 0x2D1A,
	0x4A: 0x3220,
	0x4B: 0x4606,
	0x50: 0x0A14,
	0x52: 0x2322,
	0x58: 0x1922,
	0x5A: 0x4112,
	0x60: 0x0F00,
	0x61: 0x231A,
	0x68: 0x1E10,
	0x69: 0x410E,
	0x70: 0x0F0A,
	0x78: 0x3206,
	0x80: 0x0502,
	0x81: 0x4102,
	0x82: 0x4616,
	0x83: 0x321C,
	0x84: 0x4100,
	0x85: 0x2D22,
	0x86: 0x3210,
	0x87: 0x4106,
	0x90: 0x0504,
	0x92: 0x1E14,
	0x94: 0x191A,
	0x96: 0x460C,
	0xA0: 0x0A10,
	0xA1: 0x1E24,
	0xA4: 0x1E20,
	0xA5: 0x4612,
	0xB0: 0x0A0C,
	0xB4: 0x3706,
	0xC0: 0x0500,
	0xC1: 0x1912,
	0xC2: 0x1E18,
	0xC3: 0x460E,
	0xD0: 0x050A,
	0xD2: 0x3708,
	0xE0: 0x0A08,
	0xE1: 0x3208,
	0xF0: 0x0A02,
}
MAP_TILE_OVERLAY_RECTS = [
	(0x0200, 0x000E),	# event
	(0x0400, 0x000A),	# stairs up
	(0x0800, 0x000C),	# stairs down
]
MAP_TILE_SPECIAL_RECTS = [
	# passable walls
	(0x1010, 0x1010, 224//8 + 32*80),	# east
	(0x2020, 0x2020, 208//8 + 48*80),	# south
	(0x4040, 0x4040, 192//8 + 32*80),	# west
	(0x8080, 0x8080, 208//8 + 16*80),	# north
	
	# impassable "non-walls" (opening, door)
	(0x1010, 0x0000, 288//8 + 32*80),	# east
	(0x2020, 0x0000, 272//8 + 48*80),	# south
	(0x4040, 0x0000, 256//8 + 32*80),	# west
	(0x8080, 0x0000, 272//8 + 16*80),	# north
]
MAP_BORDER_TILE = [
	0x0010, 0x0012, 0x0014,
	0x0016, 0x0000, 0x0018,
	0x001A, 0x001C, 0x001E,
]

def read_tiles(tileFileName):
	global tileImg
	global tiles
	global tilesW
	global tilesH
	
	tileImg = PIL.Image.open(tileFileName)
	
	tiles = []
	for y in range(0, tileImg.size[1], GRID_Y):
		for x in range(0, tileImg.size[0], GRID_X):
			tiles.append(tileImg.crop((x, y, x+GRID_X, y+GRID_Y)))
	tilesW = tileImg.size[0] // GRID_X
	tilesH = tileImg.size[1] // GRID_Y
	
	return

def tileaddr2id(addr: int) -> int:
	global tilesW
	
	x = (addr % 80) * 8
	y = addr // 80
	return (y // 16) * tilesW + (x // 16)

def get_base_tile(tileFlags):
	global tiles
	
	if tileFlags not in MAP_TILE_RECTS:
		return tiles[0]
	
	tileId = tileaddr2id(MAP_TILE_RECTS[tileFlags])
	return tiles[tileId]

def overlay_transparent(dstImg, srcImg, coord):
	(dstX, dstY) = coord
	for y in range(srcImg.size[1]):
		for x in range(srcImg.size[0]):
			pix = srcImg.getpixel((x, y))
			if pix != 0:
				dstImg.putpixel((dstX + x, dstY + y), pix)
	return

def read_map_data(filePath: str) -> list:
	with open(filePath, "rb") as f:
		f.seek(500 * 0x02)
		data = f.read(MAP_COUNT * 0x100 * 0x02)
		dIt = struct.iter_unpack("<H", data)
		return [x[0] for x in dIt]

def dump_single_map(config, mapData: list, mapId: int, outPath: pathlib.Path):
	global tileImg
	
	if config.border:
		mapSize = (18, 18)
		baseXY = (1, 1)
	else:
		mapSize = (16, 16)
		baseXY = (0, 0)
	
	mapImg = PIL.Image.new('P', (mapSize[0] * GRID_X, mapSize[1] * GRID_Y))
	mapImg.putpalette(tileImg.palette)
	
	if config.border:
		# draw top/bottom
		for mapY in [0, mapSize[1] - 1]:	# [top, bottom]
			tBase = 0*3 if mapY == 0 else 2*3
			mapX = 0	# upper left edge
			tId = tileaddr2id(MAP_BORDER_TILE[tBase + 0])
			mapImg.paste(tiles[tId], (mapX * GRID_X, mapY * GRID_Y))
			
			for mapX in range(1, mapSize[0] - 1):	# upper middle
				tId = tileaddr2id(MAP_BORDER_TILE[tBase + 1])
				mapImg.paste(tiles[tId], (mapX * GRID_X, mapY * GRID_Y))
			
			mapX = mapSize[0] - 1	# upper right edge
			tId = tileaddr2id(MAP_BORDER_TILE[tBase + 2])
			mapImg.paste(tiles[tId], (mapX * GRID_X, mapY * GRID_Y))
		
		# draw sides
		tBase = 1*3
		mapX = 0	# left side
		tId = tileaddr2id(MAP_BORDER_TILE[tBase + 0])
		for mapY in range(1, mapSize[1] - 1):
			mapImg.paste(tiles[tId], (mapX * GRID_X, mapY * GRID_Y))
		mapX = mapSize[1] - 1	# right side
		tId = tileaddr2id(MAP_BORDER_TILE[tBase + 2])
		for mapY in range(1, mapSize[1] - 1):
			mapImg.paste(tiles[tId], (mapX * GRID_X, mapY * GRID_Y))
	
	# draw main map
	baseOfs = mapId * 0x100
	for mapY in range(16):
		for mapX in range(16):
			x = (baseXY[0] + mapX) * GRID_X
			y = (baseXY[0] + mapY) * GRID_Y
			tileFlags = mapData[baseOfs + mapY * 16 + mapX * 1]
			
			if config.cover and not (tileFlags & 0x0100):
				mapImg.paste(tiles[0], (x, y))
				continue
			
			mapTile = get_base_tile(tileFlags & 0x00FF)
			mapImg.paste(mapTile, (x, y))   # put map tile
			
			if config.events:
				for (flag, tAddr) in MAP_TILE_OVERLAY_RECTS:
					if tileFlags & flag:
						tId = tileaddr2id(tAddr)
						overlay_transparent(mapImg, tiles[tId], (x, y))
			
			if config.secrets:
				for (flagMask, flagVals, tAddr) in MAP_TILE_SPECIAL_RECTS:
					if (tileFlags & flagMask) == flagVals:
						tId = tileaddr2id(tAddr)
						overlay_transparent(mapImg, tiles[tId], (x, y))
	mapImg.save(outPath)
	return

def dump_map_data(config):
	read_tiles(config.tiles)
	mapData = read_map_data(config.map)
	
	if config.id:
		outName = pathlib.Path(config.output)
		dump_single_map(config, mapData, config.id, outName)
	else:
		outNameTpl = pathlib.Path(config.output)
		for mapId in range(MAP_COUNT):
			print(f"Map {mapId} ...")
			outName = outNameTpl.with_name(outNameTpl.stem + f"_{mapId:02}" + outNameTpl.suffix)
			dump_single_map(config, mapData, mapId, outName)
	
	print("Done.")
	return

def main(argv):
	global config
	
	print("MIME Map Dumper")
	aparse = argparse.ArgumentParser()
	aparse.add_argument("-m", "--map", type=str, required=True, help="MIME save game (Z1000.DAT)")
	aparse.add_argument("-t", "--tiles", type=str, required=True, help="image with map tiles (STMED.BMP)")
	aparse.add_argument("-o", "--output", type=str, required=True, help="output bitmap file, map ID gets added into file name")
	aparse.add_argument("-i", "--id", type=int, help="dump only a specific map, instead of all")
	aparse.add_argument("-e", "--events", action="store_true", help="enable stairs/event overlay")
	aparse.add_argument("-s", "--secrets", action="store_true", help="enable overlay for secret passages and collision errors")
	aparse.add_argument("-c", "--cover", action="store_true", help="only show uncovered areas")
	aparse.add_argument("-b", "--border", action="store_true", help="draw map border")
	
	config = aparse.parse_args(argv[1:])
	return dump_map_data(config)

if __name__ == "__main__":
	sys.exit(main(sys.argv))
# vim: set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab:
