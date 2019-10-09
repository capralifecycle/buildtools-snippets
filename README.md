# buildtools-snippets

[![Build Status](https://jenkins.capra.tv/buildStatus/icon?job=buildtools/buildtools-snippets/master)](https://jenkins.capra.tv/job/buildtools/job/buildtools-snippets/job/master/)

This repository holds code snippets that can be included in various
pipelines, such as when building a Dockerfile to reduce code duplication
and propagate future fixes downstream.

`master` branch is protected to ensure this is kept stable. Consumers of this
repo use GitHub URLs directly. A build must pass in Jenkins before being
pushed to `master`.

## TODO

* Automate updates (commit, test, merge)
