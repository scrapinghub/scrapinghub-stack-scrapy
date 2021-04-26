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
  - ``branch-1.8-py3`` - Python 3 branch with Scrapy 1.8
  - ``branch-2.3`` - Python 3 branch with Scrapy 2.3 (since Scrapy 2.0 all branches are Python 3 only)


Versioning
==========

We use Git tags to pin a stack version and release a stack image to Docker hub.

Versioning is done in the following manner:

- major stack versions are marked with ``<scrapy version>[-py3]`` tag.

  Note: For stacks up to version 2.0, lack of ``-py3`` suffix means that the stack is built using Python 2.

  Examples:

    - tag ``1.0``
    - tag ``1.1``
    - tag ``1.8-py3``

- each published version of the stack is marked with ``<scrapy version>[-py3]-<release date>`` tag

  It's **highly recommended** to use these versions (or major ones above) over others.

  Examples:

    - ``1.1-20160429`` refers to Python 2 based stack released on 2016-04-29 with ``Scrapy 1.1``
    - ``1.8-py3-20191203`` refers to Python 3 based stack released on 2019-12-03 with ``Scrapy 1.8``
    - ``2.0-20200325`` refers to Python 3 based stack released on 2020-03-25 with ``Scrapy 2.0``

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


Setting up local Environment to update requirements
==================================================

1. Setup and start Docker demon
2. Build container using Dockerfile::

    docker-compose up --build -d
    
3. Attach to container::

    docker attach scrapinghub-stack-scrapy_dev_1

4. Go to app directory::

    cd app

5. Install pip tools::

    pip install pip-tools

6. run pip-compile to update requirements.txt file based on pacakge versions in requirements.in file::

    pip-compile --output-file requirements.txt requirements.in

7. Create PR with appropriate branch name and commit changes along with tags as per release procedure


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
