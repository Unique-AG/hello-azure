# Contributing

We rely on you to test your changes sufficiently (GitHub Actions will ensure you did).

## Pull Requests

All submissions, including submissions by project members, require review. We use GitHub pull requests for this purpose. Consult [GitHub Help](https://help.github.com/articles/about-pull-requests/) for more information on using pull requests.

## Documentation

The documentation for each module is generated with [terraform-docs](https://terraform-docs.io) using [`pre-commit`](https://terraform-docs.io/how-to/pre-commit-hooks).

## Versioning

Each modules version follows the [semver standard](https://semver.org/).

New modules should start at version `1.0.0`, if it's considered stable. If it isn't considered stable, it must be released as `prerelease`.

Any breaking changes to a module (backwards incompatible) require:

* Bump of the current Major version of the module
