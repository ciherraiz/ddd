"""ValueObject Class
    Use value objects:

    -when they help express intent
    -for composition
    -to guarantee valid instantiation
    -to encapsulate behaviour
"""


class ValueObject(object):
    """The base class of all value objects
        Must call _set_properties in __init__"""

    def __new__(cls, *args, **kwargs):
        self = object.__new__(cls)
        self.__initialized = False
        return self

    def _set_attributes(self, mapping):
        """Assign the new attributes and values by mapping a dict"""
        if self.__initialized:
            raise AttributeError('callable only by __init__')

        self._mapping = mapping

        for label, obj in self._mapping.items():
            if not hasattr(self.__class__, label):
                setattr(self, label, obj)

        self.__initialized = True

    def __setattr__(self, name, value):
        if not hasattr(self, '_ValueObject__initialized') \
           or not self.__initialized:
            object.__setattr__(self, name, value)
        else:
            raise AttributeError('can\'t modify a attribute of a value object')

    def __delattr__(self, name):
        raise AttributeError('can\'t delete a attribute of a value object')

    def __eq__(self, other):
        return repr(self) == repr(other)

    def __hash__(self):
        return hash(repr(self))

    def __repr__(self):
        return '{0}{1}'.format(self.__class__.__name__,
        ', '.join(repr(obj) for label, obj in self._mapping.items()))
