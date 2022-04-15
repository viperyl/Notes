from objprint import op
class position:
    def __init__(self, x, y) -> None:
        self.x = x
        self.y = y

    def __eq__(self, __o: object) -> bool:
        return self.x == __o.x and self.y == __o.y

    def __hash__(self) -> int:
        # return id(self)
        return hash((self.x, self.y))

d = {}
pos = position(0,1)
d[pos] = 1
# op(d)
pos2 = position(0,1)
d[pos2] = 2
op(d)
# 