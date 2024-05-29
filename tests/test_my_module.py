import unittest
from my_module import add

class TestMyModule(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(1, 2), 3)
        self.assertEqual(add(5, -3), 2)
        self.assertEqual(add(0, 0), 0)

if __name__ == '__main__':
    unittest.main()
