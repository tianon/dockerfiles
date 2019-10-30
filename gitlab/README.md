This repository contains a mirror of selected tags from [the `gitlab/gitlab-ce` repository](https://hub.docker.com/r/gitlab/gitlab-ce), but tagged as appropriate `MAJOR.MINOR` / `MAJOR` tags so that upgrades can be handled semi-transparently via `docker pull` (`docker service update`, ["hocker"](https://github.com/infosiftr/hocker), etc) instead of via manual version bumps on deployments.

See also https://gitlab.com/gitlab-org/gitlab-foss/blob/master/doc/policy/maintenance.md#upgrade-recommendations, especially:

> It is considered safe to jump between patch versions and minor versions within
one major version. For example, it is safe to:
> - Upgrade the patch version:
>   - `8.9.0` -> `8.9.7`
>   - `8.9.0` -> `8.9.1`
>   - `8.9.2` -> `8.9.6`
> - Upgrade the minor version:
>   - `8.9.4` -> `8.12.3`
>   - `9.2.3` -> `9.5.5`
