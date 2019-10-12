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

## Checklist when adding snippets

* The snippet is added to `Jenkinsfile` to be tested
* Any dependencies in the snippets is added to `check-updates.sh`
* Tests verify behaviour similar to other tests

## Future metrics collection and external usage

To be able to manage a deprecation lifecycle we might add metrics to the
snippets later so that we can monitor its use, and migrate away and remove
deprecated snippets.

The snippets in this repo is typically for internal use only, and we do not
promise any compatibility for any external consumers.
