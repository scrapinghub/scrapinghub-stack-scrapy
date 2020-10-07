========================
scrapinghub-stack-scrapy
========================

Software stack with latest Scrapy and updated deps.


Branches and tags
=================

The repository includes a set of branches to maintain different stack versions depending on supported Python version and on Scrapy version included in the stack.

  Examples:

  - ``branch-1.0`` - Python 2 branch with Scrapy 1.0
  - ``branch-1.1`` - Python 2 branch with Scrapy 1.1
  - ``branch-1.1-py3`` - Python 3 branch with Scrapy 1.1


Versioning
==========

We use Git tags to pin a stack version and release a stack image to Docker hub.

Versioning is done in the following manner:

- major stack versions are marked with ``<scrapy version>[-pyX]`` tag.

  **Note**: All tags prior to ``2.0`` used Python 2 as its default version.
  Support for Python 2 was dropped on version ``2.0``, so from that version onwards all tags base on Python 3
  The presence of a ``-py3`` suffix on an older tag means that specific stack uses updated Python 3 interpreter.

  Examples:

    - tag ``1.0``
    - tag ``1.1-py3``
    - tag ``1.6-py37``

- each published version of the stack is marked with ``<scrapy version>[-pyX]-<release date>`` tag

  It's **highly recommended** to use these versions (or major ones above) over others.

  Examples:

    - ``1.1-20160429`` refers to the stack released at 2016-04-29 with ``Scrapy 1.1``, using it's default Python interpreter (2.7 in this case).
    - ``1.1-py3-20160804`` refers the stack released at 2016-08-04 with ``Scrapy 1.1``, using Python 3.
    - ``2.3-20200806`` refers to the stack release on 2020-08-06 with ``Scrapy 2.3``, using it's default Python interpreter (3.8 in this case). 

- latest version of the stack is matched with a branch name without ``branch-`` prefix with ``-latest`` suffix

  Examples:

    - branch ``branch-1.0`` -> tag ``1.0-latest``
    - branch ``branch-1.1`` -> tag ``1.1-latest``
    - branch ``branch-1.1-py3`` -> tag ``1.1-py3-latest``

  **Warning:** please do not use stacks marked as ``latest`` (i.e: ``latest``, ``1.1-latest``, ``1.1-py3-latest`` etc), they reflect latest changes in the corresponding branches and can be unstable.

- there can be additional temporary tags to develop new features (you shouldn't rely on it)

  Example:

    - tag ``1.1-py3-some-feature`` to develop, test a feature and drop it in the end

All stack versions are listed correspond to a Docker image listed at:

- https://hub.docker.com/r/scrapinghub/scrapinghub-stack-scrapy/tags/


Release procedure
=================

When you're going to release a new version of the stack, you should:

1. Do not forget to pull latest changes from branch you are going to release::

    git pull origin <branch>

  Example::

    git pull origin branch-1.1-py3

2. Tag it with correct tags (see Versioning section above)::

    git tag <tag>

  Example::

    git tag -f 1.1-py3
    git tag 1.1-py3-20160804

  Tag ``1.1-py3-latest`` will be built automatically from ``branch-1.1-py3``, no need to define a tag manually.

3. Push the changes and the tags to the repo::

    git push -f origin <branch> <tag1> <tag2>

  Example::

    git push -f origin branch-1.1-py3 1.1-py3 1.1-py3-20160804

  Tags should be pushed at the same time when pushing changes (or before it) because otherwise build will not be triggered and developer will be required to find the build in drone and trigger it manually again after tags are pushed.

4. After release it's necessary to check that tag is updated both in github and hub.docker.com:

  - https://github.com/scrapinghub/scrapinghub-stack-scrapy/releases
  - https://hub.docker.com/r/scrapinghub/scrapinghub-stack-scrapy/tags/

5. Make sure that if you add a new feature to a stack version, it should be added to other stack versions as well to keep consistency. It has nothing to do with backward incompatible changes (for example, Python 3 vs Python 2), but true for all other cases.
