import unittest
import test_world
import test_sprites

all_tests = unittest.TestSuite()
all_tests.addTests((test_world.suite(), test_sprites.suite()))

unittest.TextTestRunner().run(all_tests)
