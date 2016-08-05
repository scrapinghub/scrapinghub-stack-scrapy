========================
scrapinghub-stack-scrapy
========================

Software stack with latest Scrapy and updated deps.


Branches and tags
=================

The repository includes a set of branches to maintain different stack versions depending on supported Python version and on Scrapy version included in the stack. Examples:

  - ``branch-1.0`` - Python 2 branch with Scrapy 1.0
  - ``branch-1.1`` - Python 2 branch with Scrapy 1.1
  - ``branch-1.1-py3`` - Python 3 branch with Scrapy 1.1

There are also a few branches for internal development, their names are formed by adding ``-dev`` suffix to original branch names:

  - ``branch-1.0-dev``
  - ``branch-1.1-dev``
  - ``branch-1.1-py3-dev``


Versioning
==========

We use git tags to pin a stack version and release a stack image to Docker hub.

Versioning is done in the following manner:

- major stack versions are marked with ``<scrapy version>[-py3]`` tag.

  Note: Lack of ``-py3`` suffix means that a stack is built using Python 2.

  Example:

    - ``1.0``
    - ``1.1``
    - ``1.1-py3``

- each published version of the stack is marked with ``<scrapy version>[-py3]-<release date>`` tag

  It's highly recommended to use these versions (or major ones above) over others.

  Example:

    - ``1.1-20160429`` refers to Python 2 based stack released at 2016-04-29 with ``Scrapy 1.1``
    - ``1.1-py3-20160804`` refers to Python 3 based stack released at 2016-08-04 with ``Scrapy 1.1``

- latest version of the stack is matched with a branch name without ``branch`` prefix with ``-latest`` suffix

  Examples:

    - ``branch-1.0`` -> ``1.0-latest``
    - ``branch-1.1`` -> ``1.1-latest``
    - ``branch-1.1-py3`` -> ``1.1-py3-latest``
    - ``branch-1.0-dev`` -> ``1.0-dev-latest``

  Warning: please do not use stack marked with ``latest`` tag (i.e: ``scrapinghub-stack-scrapy:latest``), as it can contain an arbitrary stack version (latest deployed one), it's a part of Docker build system and we can't disable it for now.

- development stack versions are marked with ``<scrapy version>[-py3][-dev]`` tags.

All stack versions are listed correspond to a Docker image listed at:

- https://hub.docker.com/r/scrapinghub/scrapinghub-stack-scrapy/tags/


Release procedure
=================

When you're going to release a new version of the stack, you should:

1. Do not forget to pull latest changes from master::

    git pull origin

2. Tag it with a correct tag string (see Versioning section above)::

    git tag <tag>

  Example::

    git tag -f 1.1-py3
    git tag 1.1-py3-20160804

3. Push the changes and the tags to the repo::

    git push -f origin master <tag1> <tag2>

  Example::

    git push -f origin master 1.1-py3 1.1-py3-20160804

  Tags should be pushed at the same time when pushing changes (or before it) because otherwise build will not be triggered and developer will be required to find the build in drone and trigger it manually again after tags are pushed.

4. After release it's necessary to check that tag is updated both in github and hub.docker.com:

  - https://github.com/scrapinghub/scrapinghub-stack-scrapy/releases
  - https://hub.docker.com/r/scrapinghub/scrapinghub-stack-scrapy/tags/
