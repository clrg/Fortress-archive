from pyglet.gl import *
from world import Camera

class IsoSprite(pyglet.sprite.Sprite):
    '''Instance of an on-screen image.
    This sprite will always orient toward the plane perpendicular to the 
    x-y component that the camera is facing.
    ''' 
    def __init__(self, 
                 img, 
                 x=0, y=0, 
                 blend_src=GL_SRC_ALPHA,
                 blend_dest=GL_ONE_MINUS_SRC_ALPHA,
                 batch=None,
                 group=None,
                 usage='dynamic'):
        '''Create an IsoSprite.
        See pyglet sprite documentation
        '''
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
        z1 = 0
        z2 = 0 
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
        glTranslatef(self._x,self._y,0)
        #align with the view direction
        glRotatef(-Camera.VIEW_Z_ROTATION,0,0,1)
        #and stand the sprite up
        glRotatef(90,1,0,0)
        self._vertex_list.draw(GL_QUADS)
        self._group.unset_state_recursive()
        #self._vertex_list.draw(GL_LINES)
        glPopMatrix()

class Tower(object):
    def __init__(self,base,stem,top,x,y,level=0):
        self.x = x
        self.y = y
        self.level = level
        self._pieces = [IsoSprite(base,x,y)]
        for i in range(level):
            stem.anchor_y = -base.height - i*stem.height
            self._pieces.append(IsoSprite(stem,x,y))
        top.anchor_y = -base.height - stem.height*level
        self._pieces.append(IsoSprite(top,x,y))
        self._pieces.reverse() # so they are drawn top to bottom
    
    def draw(self):
        for piece in self._pieces:
            piece.draw()
    
