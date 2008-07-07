from pyglet.gl import *
pyglet.resource.path = ['media']
pyglet.resource.reindex()

class Camera(object):
    VIEW_Z_ROTATION = 45
    VIEW_X_ROTATION = -60
    VIEW_HEIGHT = 128
    FAR=2048
    fov=45  
    def __init__(self,x=0,y=0):
        self._x = x
        self._y = y
    def isometric(self,width,height):
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        glOrtho(-width/2.,width/2.,-height/2.,height/2.,0,Camera.FAR)
        glMatrixMode(GL_MODELVIEW)
    def apply(self):
        glLoadIdentity()
        glRotatef(Camera.VIEW_X_ROTATION,1,0,0)
        glRotatef(Camera.VIEW_Z_ROTATION,0,0,1)
        glTranslatef(-self._x,-self._y,-Camera.VIEW_HEIGHT)
    def to_world_ground_coords(self,x,y):
        '''
        take the screen coordinates, x,y and return the coresponding 
        x,y coordinates of the ground
        '''
        modelview,proj,view = (GLdouble*16)(),(GLdouble*16)(),(GLint*4)()
        #get the current modelview and projection matrices
        glGetDoublev(GL_MODELVIEW_MATRIX , modelview)
        glGetDoublev(GL_PROJECTION_MATRIX, proj)
        #and the viewport
        glGetIntegerv(GL_VIEWPORT, view)
        pX,pY,pZ = GLdouble(),GLdouble(),GLdouble()
        #get the screen coordinates of two sample points
        gluProject(0,0,0,modelview,proj,view,pX,pY,pZ)
        y_origin, z_origin = pY.value, pZ.value
        gluProject(100,100,0,modelview,proj,view,pX,pY,pZ)
        # find the change in Z per pixel in Y
        dz_dy = (pZ.value-z_origin)/(pY.value-y_origin)
        # so the z coordinate of the point of interest is:
        z = z_origin + dz_dy*(y-y_origin)
        #finally, get the (x,y,0) coordinate for the point clicked
        gluUnProject(x,y,z, modelview, proj, view, byref(pX),byref(pY),byref(pZ))
        print 'world :', int(pX.value),int(pY.value),int(pZ.value)
        return int(pX.value),int(pY.value)

TILE_SIZE = 68

class Terrain(object):
    def __init__(self, width = 10, height = 10):
        self.width =  width
        self.height = height
        self.batch = pyglet.graphics.Batch()
        self.tiles = [[Tile(x=w*TILE_SIZE, y=h*TILE_SIZE, batch=self.batch) for h in range(height)] for w in range(width)]

    def getTile(self,x,y):
        '''Return the tile which contains the specified point
        '''
        if x<0 or y<0 or x>self.width*TILE_SIZE or y> self.width*TILE_SIZE:
            return None
        return self.tiles[x/TILE_SIZE][y/TILE_SIZE]
    def draw(self):
        self.batch.draw()

class Tile(pyglet.sprite.Sprite):
    '''
    A tile in the world.  Can be drawn and keeps track of whether it is
    occupied, meaning built on or not.
    ''' 
    grass_image = pyglet.resource.image('grass.png')
    def __init__(self, 
                 img=grass_image, 
                 x=0, y=0, 
                 blend_src=GL_SRC_ALPHA,
                 blend_dest=GL_ONE_MINUS_SRC_ALPHA,
                 batch=None,
                 group=None,
                 usage='dynamic'):
        '''Create an IsoSprite.
        See pyglet sprite documentation
        '''
        super(Tile, self).__init__(img,x,y,blend_src,blend_dest,batch,group,usage)
        self.center_x = x+TILE_SIZE/2
        self.center_y = y+TILE_SIZE/2
        self.occupied = False
