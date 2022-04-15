from objprint import op

class Position:
    def __init__(self, x, y):
        self.x = x
        self.y = y

class Player:
    def __init__(self):
        self.name = "Alice"
        self.age = 18
        self.items = ["axe", "armor"]
        self.coins = {"gold":1, "silver":33, "bronze":57}
        self.position = Position(3,5)

op(Player)