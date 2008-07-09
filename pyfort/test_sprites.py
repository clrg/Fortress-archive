from testbase import *
import unittest

from sprites import *

def suite():
    return make_suite(TowerTests)

class TowerTests(BasicTestSet):
    def setUp(self):
        self.tower = Tower()
    @testmethod
    def testCreate(self):
        self.failIf(self.tower is None)
    @testmethod
    def testGrow(self):
        self.tower.grow()
        self.failUnlessEqual(self.tower.level, 1)
