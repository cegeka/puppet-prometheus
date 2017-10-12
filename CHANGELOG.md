# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v2.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/v2.0.0) (2017-10-12)
[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v1.0.0...v2.0.0)

**Implemented enhancements:**

- Bump versions for archive and puppet dependency/support puppet5 [\#65](https://github.com/voxpupuli/puppet-prometheus/pull/65) ([bastelfreak](https://github.com/bastelfreak))
- Add tests for elasticsearch\_exporter and update a bit [\#64](https://github.com/voxpupuli/puppet-prometheus/pull/64) ([salekseev](https://github.com/salekseev))
- Allow uncompressed daemons [\#53](https://github.com/voxpupuli/puppet-prometheus/pull/53) ([sathieu](https://github.com/sathieu))
- Add elasticsearch exporter [\#51](https://github.com/voxpupuli/puppet-prometheus/pull/51) ([rbestbmj](https://github.com/rbestbmj))
- Add mongodb\_exporter [\#46](https://github.com/voxpupuli/puppet-prometheus/pull/46) ([salekseev](https://github.com/salekseev))

**Fixed bugs:**

- $DAEMON info is only available for the prometheus daemon [\#50](https://github.com/voxpupuli/puppet-prometheus/pull/50) ([sathieu](https://github.com/sathieu))

**Closed issues:**

- Upgrade to Puppet4? [\#34](https://github.com/voxpupuli/puppet-prometheus/issues/34)

**Merged pull requests:**

- release 2.0.0 [\#66](https://github.com/voxpupuli/puppet-prometheus/pull/66) ([bastelfreak](https://github.com/bastelfreak))
- Remove systemd module dependency and fix missing path for a exec [\#58](https://github.com/voxpupuli/puppet-prometheus/pull/58) ([juliantaylor](https://github.com/juliantaylor))
- Update README.md [\#56](https://github.com/voxpupuli/puppet-prometheus/pull/56) ([steinbrueckri](https://github.com/steinbrueckri))
- Use default collectors if "collectors" param is empty [\#49](https://github.com/voxpupuli/puppet-prometheus/pull/49) ([sathieu](https://github.com/sathieu))
- Feature/cleanup and document [\#44](https://github.com/voxpupuli/puppet-prometheus/pull/44) ([jhooyberghs](https://github.com/jhooyberghs))
- Reload config [\#43](https://github.com/voxpupuli/puppet-prometheus/pull/43) ([vide](https://github.com/vide))
- Add param service\_name to node\_exporter class [\#40](https://github.com/voxpupuli/puppet-prometheus/pull/40) ([bastelfreak](https://github.com/bastelfreak))
- backport changes to upstream [\#39](https://github.com/voxpupuli/puppet-prometheus/pull/39) ([bastelfreak](https://github.com/bastelfreak))

## [v1.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/v1.0.0) (2017-03-26)
[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.2.0...v1.0.0)

**Closed issues:**

- alertmanager systemd service doesnt start [\#28](https://github.com/voxpupuli/puppet-prometheus/issues/28)

**Merged pull requests:**

- node-exporter have a 'v' in the release name since 0.13.0 [\#29](https://github.com/voxpupuli/puppet-prometheus/pull/29) ([NairolfL](https://github.com/NairolfL))

## [v0.2.0](https://github.com/voxpupuli/puppet-prometheus/tree/v0.2.0) (2016-12-27)
[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.1.14...v0.2.0)

**Closed issues:**

- Allow to configure scrape options by file [\#17](https://github.com/voxpupuli/puppet-prometheus/issues/17)
- Generate tag. [\#12](https://github.com/voxpupuli/puppet-prometheus/issues/12)
- Extend Readme [\#7](https://github.com/voxpupuli/puppet-prometheus/issues/7)
- Prometheus Rule Files [\#6](https://github.com/voxpupuli/puppet-prometheus/issues/6)
- Prometheus Logging to file [\#5](https://github.com/voxpupuli/puppet-prometheus/issues/5)

**Merged pull requests:**

- Add Statsd Exporter, Mysqld Exporter, make exporters generic [\#27](https://github.com/voxpupuli/puppet-prometheus/pull/27) ([lswith](https://github.com/lswith))
- adding class to create alerts [\#24](https://github.com/voxpupuli/puppet-prometheus/pull/24) ([snubba](https://github.com/snubba))

## [v0.1.14](https://github.com/voxpupuli/puppet-prometheus/tree/v0.1.14) (2016-11-11)
[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.1.13...v0.1.14)

**Closed issues:**

- Issue when install prometheus and alertmanager  [\#23](https://github.com/voxpupuli/puppet-prometheus/issues/23)

**Merged pull requests:**

- allow specification of a custom template [\#25](https://github.com/voxpupuli/puppet-prometheus/pull/25) ([lobeck](https://github.com/lobeck))
- Allow overriding shared\_dir [\#22](https://github.com/voxpupuli/puppet-prometheus/pull/22) ([roidelapluie](https://github.com/roidelapluie))
- Remove extra blank spaces at the end of lines [\#21](https://github.com/voxpupuli/puppet-prometheus/pull/21) ([roidelapluie](https://github.com/roidelapluie))
- Fix AlertManager Class [\#20](https://github.com/voxpupuli/puppet-prometheus/pull/20) ([lswith](https://github.com/lswith))

## [v0.1.13](https://github.com/voxpupuli/puppet-prometheus/tree/v0.1.13) (2016-09-14)
**Closed issues:**

- Update forge version [\#10](https://github.com/voxpupuli/puppet-prometheus/issues/10)

**Merged pull requests:**

- Add console support [\#15](https://github.com/voxpupuli/puppet-prometheus/pull/15) ([mspaulding06](https://github.com/mspaulding06))
- Add missing quotes to params file [\#14](https://github.com/voxpupuli/puppet-prometheus/pull/14) ([mspaulding06](https://github.com/mspaulding06))
- Get rid of leading whitespace in generated configs [\#13](https://github.com/voxpupuli/puppet-prometheus/pull/13) ([mspaulding06](https://github.com/mspaulding06))
- Bunch of changes to work against the latest prom releases [\#11](https://github.com/voxpupuli/puppet-prometheus/pull/11) ([brutus333](https://github.com/brutus333))
- add support for newer releases of node\_exporter [\#4](https://github.com/voxpupuli/puppet-prometheus/pull/4) ([patdowney](https://github.com/patdowney))
- Systemd does not see all shutdowns as failures [\#3](https://github.com/voxpupuli/puppet-prometheus/pull/3) ([tarjei](https://github.com/tarjei))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
