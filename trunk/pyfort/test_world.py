from testbase import *
import unittest

from world import *

class TerrainTests(BasicTestSet):
    def setUp(self):
        self.terrain = Terrain(width = 40, height = 40)
    def tearDown(self):
        pass
    @testmethod
    def testSize(self):
        self.failUnless(self.terrain.width == 40, 'terrain width incorrect')
        self.failUnless(self.terrain.height == 40, 'terrain height incorrect')
    @testmethod
    def testTileArrayBoundaries(self):
        self.failUnlessRaises(IndexError,self.terrain.tiles.__getitem__,40)
        t = Terrain(width=1, height=2)
        #this should be ok 
        t.tiles[0][1]
        # t.tiles[1][0] should raise an exception
        self.failUnlessRaises(IndexError,t.tiles.__getitem__,1)
    @testmethod
    def testGetTileReturnsTileWithCorrectCoords(self):
        tile = self.terrain.getTile(22, TILE_SIZE*2+33)
        self.failUnlessEqual(tile.center_x , (22 / TILE_SIZE)*TILE_SIZE + TILE_SIZE/2)
        self.failUnlessEqual(tile.center_y , ((TILE_SIZE*2+33) / TILE_SIZE)*TILE_SIZE + TILE_SIZE/2)
        self.failUnlessEqual(tile.x , (22 / TILE_SIZE)*TILE_SIZE)
        self.failUnlessEqual(tile.y , ((TILE_SIZE*2+33) / TILE_SIZE)*TILE_SIZE)
    @testmethod
    def testGetTileSameCoordsReturnSameTile(self):
        tile1 = self.terrain.getTile(100,200)
        tile2 = self.terrain.getTile(100,200)
        self.failUnlessEqual(tile1,tile2)
    @testmethod
    def testGetTileAtSufficiontlyDifferentCoordsReturnsDifferentTiles(self):
        tile1 = self.terrain.getTile(100,200)
        tile2 = self.terrain.getTile(100+2*TILE_SIZE,200)
        self.failIfEqual(tile1,tile2)
    @testmethod
    def testGetTileOutOfBoundsReturnsNoTile(self):
        tile = self.terrain.getTile(self.terrain.width*TILE_SIZE+1, 10)
        self.failUnless(tile is None)
        tile = self.terrain.getTile(-1,10)
        self.failUnless(tile is None)

class TileTests(BasicTestSet):
    def setUp(self):
        self.tile = Tile(x=0,y=0)
    @testmethod
    def testCreate(self):
        self.failUnlessEqual(0,self.tile.x)
        self.failUnlessEqual(0,self.tile.y)
        self.failUnlessEqual(TILE_SIZE/2, self.tile.center_x)
        self.failUnlessEqual(TILE_SIZE/2, self.tile.center_y)
    @testmethod
    def testCenter(self):
        tile = Tile(x=100,y=200)
        self.failUnlessEqual(100+TILE_SIZE/2,tile.center_x)
        self.failUnlessEqual(200+TILE_SIZE/2,tile.center_y)
    @testmethod
    def testNewTileNotOccupied(self):
        self.failIf(self.tile.occupied)
        

unittest.TextTestRunner().run(suite(TileTests, TerrainTests))
