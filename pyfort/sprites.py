from pyglet.gl import *
from world import Camera

class IsoSprite(pyglet.sprite.Sprite):
    '''Instance of an on-screen image.
    This sprite will always orient toward the plane perpendicular to the 
    x-y component that the camera is facing.
    ''' 
    def __init__(self, 
                 img=None, 
                 x=0, y=0, z=0,
                 blend_src=GL_SRC_ALPHA,
                 blend_dest=GL_ONE_MINUS_SRC_ALPHA,
                 batch=None,
                 group=None,
                 usage='dynamic'):
        '''Create an IsoSprite.
        See pyglet sprite documentation
        '''
        if img is None:
            img = pyglet.image.CheckerImagePattern().create_image(96,48)
        self._z = z
        super(IsoSprite, self).__init__(img,x,y,blend_src,blend_dest,batch,group,usage)
          
    def _create_vertex_list(self):
        if self._batch is None:
            self._vertex_list = pyglet.graphics.vertex_list(4,
                'v3i/%s' % self._usage, 
                'c4B', ('t3f', self._texture.tex_coords))
        else:
            self._vertex_list = self._batch.add(4, GL_QUADS, self._group,
                'v3i/%s' % self._usage, 
                'c4B', ('t3f', self._texture.tex_coords))
        self._update_position()
        self._update_color()

    def _update_position(self):
        img = self._texture
        z1 = z2 = 0
        if not self._visible:
            self._vertex_list.vertices[:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        elif self._scale != 1.0:
            x1 = int( - img.anchor_x * self._scale)
            y1 = int( - img.anchor_y * self._scale)
            x2 = int((img.width - img.anchor_x) * self._scale)
            y2 = int((img.height - img.anchor_y) * self._scale)
            self._vertex_list.vertices[:] = [x1, y1, z1, x2, y1, z1 , x2, y2, z2, x1, y2, z2]
        else:
            x1 = - img.anchor_x
            y1 = - img.anchor_y
            x2 = img.width - img.anchor_x
            y2 = img.height - img.anchor_y
            self._vertex_list.vertices[:] = [x1, y1, z1, x2, y1, z1 , x2, y2, z2, x1, y2, z2]

    def draw(self):
        '''Draw the sprite at its current position.
        '''
        glPushMatrix()
        #self._vertex_list.draw(GL_QUADS)
        self._group.set_state_recursive()
        glTranslatef(self._x,self._y,self._z)
        #align with the view direction
        glRotatef(-Camera.VIEW_Z_ROTATION,0,0,1)
        #and stand the sprite up
        glRotatef(-Camera.VIEW_X_ROTATION,1,0,0)
        self._vertex_list.draw(GL_QUADS)
        self._group.unset_state_recursive()
        #self._vertex_list.draw(GL_LINES) #for debugging
        glPopMatrix()

class Tower(object):
    MAX_HEIGHT=3
    def __init__(self,base=None,stem=None,top=None,x=0,y=0,level=0):
        self.x = x
        self.y = y
        self.level = level
        self._base = IsoSprite(base,x,y,0)
        self._stem = IsoSprite(stem,x,y,self._base.height)
        self._top = IsoSprite(top,x,y,self._base.height+self._stem.height*level)
    def adjust_top(self):
        self._top._z = self._base.height+self._stem.height*self.level
    def grow(self):
        if self.level == 3:
            return
        self.level +=1
        self.adjust_top()
    def shrink(self):
        if self.level == 0:
            return   
        self.level -=1
        self.adjust_top()
    def draw(self):
        self._base.draw()
        for i in range(self.level):
            self._stem._z = self._base.height+self._stem.height*i
            self._stem.draw()
        self._top.draw()
    
