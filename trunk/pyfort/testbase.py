import unittest

def testmethod(testMethod):
        testMethod._isTest = True
        return testMethod
class BasicTestSet(unittest.TestCase):
    @classmethod
    def suite(cls):
        def isTestMethod(attrname):
            attr = getattr(cls, attrname)
            return hasattr(attr, "_isTest")
        testNames = filter(isTestMethod, dir(cls))
        return unittest.TestSuite(map(cls,testNames))


def make_suite(*args):
    fullSuite = unittest.TestSuite()
    for testSet in args:
        fullSuite.addTest(testSet.suite())
    return fullSuite
