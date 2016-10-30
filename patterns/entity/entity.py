class Entity(object):
    """The base class of all entities
        Attributes:
            id: the unique identifier.
    """
    def __init__(self, id):
        self._id = id

    @property
    def id(self):
        """A string unique identifier"""
        return self._id
