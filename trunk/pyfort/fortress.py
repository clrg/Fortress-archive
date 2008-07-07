from pyglet.gl import *
from pyglet.window import key
from world import *
from sprites import *
import random
   
def scratch():
    ''' For test code
    '''
    camera = Camera(100,100)
    pyglet.resource.path = ['../client/src/net/sourceforge/fortress/iso96',
                            '../client/src/fortress/image/unit/archer',
                            'media']
    pyglet.resource.reindex()
    terrain = Terrain()
    base = pyglet.resource.image('squaretower/base.png')
    base.anchor_x = 48
    stem = pyglet.resource.image('squaretower/stem.png')
    stem.anchor_x = 48
    top = pyglet.resource.image('squaretower/top.png')
    top.anchor_x = 48
    towers = []
    #tower = Tower(base,stem,top,x=tile_size,y=tile_size,level=2)
    #tower2 = Tower(base,stem,top, x=tile_size*4,y=tile_size*2, level = 0)
    #tower3 = Tower(base,stem,top, x=0,y=tile_size*3, level = 1)
    
    window = pyglet.window.Window()
    @window.event
    def on_draw():
        glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT)
        #grid.blit(200,100)
        camera.apply()
        terrain.draw()
        for tower in towers:
            tower.draw()
        #tower2.draw()
        #tower3.draw()
        #tower.draw()

    @window.event
    def on_resize(width, height):
        glViewport(0, 0, width, height)
        camera.isometric(width,height)
        #perspective(width,height)
        return True
        
    @window.event
    def on_key_press(symbol, modifiers):
        global tile_size
        if symbol == key.SPACE:
            print 'clear'
            while len(towers)>0:
                tower = towers.pop()
                terrain.getTile(tower.x,tower.y).occupied = False
    @window.event
    def on_mouse_press(x, y, button, modifiers):
        x_world, y_world = camera.to_world_ground_coords(x,y)
        tile = terrain.getTile(x_world, y_world)
        if tile is not None and not tile.occupied:
            tile.occupied = True
            towers.append(Tower(base,stem,top,x=tile.x,y=tile.y,level=random.randint(0,3)))
            towers.sort(key = lambda a:  -(a.x**2 + a.y**2))
    def perspective(width,height):
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(Camera.fov, float(width)/height, 0.1, Camera.FAR)
        glMatrixMode(GL_MODELVIEW)  
        
    def square():
        glBegin(GL_POLYGON)
        glVertex2f(0, 0)
        glVertex2f(0, 1)
        glVertex2f(1, 1)
        glVertex2f(1, 0)
        glEnd()
tile_size = 68
scratch()
pyglet.app.run()
