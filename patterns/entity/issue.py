from datetime import datetime
from processor.domain.model.entity import Entity


class Issue(Entity):
    """Simple Issue Class"""

    def __init__(self, id, title, created):
        """
        Args:
        id: the string unique identifier
        title: the title of the issue
        created: the datetime string whe the issue was created (ISO 8601).
            We su a string with a Z UTC (+00:00). For example:
            "2008-09-03T20:56:35.450686Z"
        """
        Entity.__init__(self, id)
        self.title = title
        self._created = datetime.strptime(created, "%Y-%m-%dT%H:%M:%S.%fZ")

    @property
    def title(self):
        return self._title

    @title.setter
    def title(self, value):
        self.assert_not_emtpy_title(value)
        self._title = value

    @property
    def created(self):
        """the moment when the issue has been created"""
        return self._created

    def assert_not_emtpy_title(self, title):
        """A not empty string for the title"""
        if not title:
            raise AttributeError("Issue: title can't be a empty string")
