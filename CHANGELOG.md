# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/v4.0.0) (2018-01-04)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v3.1.0...v4.0.0)

**Breaking changes:**

- Bump dependencies [\#124](https://github.com/voxpupuli/puppet-prometheus/pull/124) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Add validation to config changes [\#122](https://github.com/voxpupuli/puppet-prometheus/pull/122) ([costela](https://github.com/costela))

**Implemented enhancements:**

- Install Promtool [\#31](https://github.com/voxpupuli/puppet-prometheus/issues/31)
- add explicit parameter for retention [\#137](https://github.com/voxpupuli/puppet-prometheus/pull/137) ([costela](https://github.com/costela))
- Feature/alerts prometheus2 [\#127](https://github.com/voxpupuli/puppet-prometheus/pull/127) ([jhooyberghs](https://github.com/jhooyberghs))

**Fixed bugs:**

- not up to date dependencies: puppetlabs-stdlib should be \>= 4.13.0 [\#123](https://github.com/voxpupuli/puppet-prometheus/issues/123)
- prometheus.yaml broken syntax when generated from hiera [\#108](https://github.com/voxpupuli/puppet-prometheus/issues/108)
- prometheus systemd wants and depends "multi-user.target" [\#139](https://github.com/voxpupuli/puppet-prometheus/pull/139) ([bastelfreak](https://github.com/bastelfreak))
- daemon: explicitly pass provider to service [\#133](https://github.com/voxpupuli/puppet-prometheus/pull/133) ([costela](https://github.com/costela))

**Closed issues:**

- Minor: add explicit retention option? [\#136](https://github.com/voxpupuli/puppet-prometheus/issues/136)
- node\_exporter: "Could not find init script for node\_exporter" [\#132](https://github.com/voxpupuli/puppet-prometheus/issues/132)
- Usage of `puppet` in custom alertmanager fact breaks if puppet not in $PATH \(e.g. systemd service\) [\#130](https://github.com/voxpupuli/puppet-prometheus/issues/130)

**Merged pull requests:**

- Use puppet internals to determine the state of the alert\_manager [\#131](https://github.com/voxpupuli/puppet-prometheus/pull/131) ([vStone](https://github.com/vStone))
- Correct typo in documentation header for node\_exporter [\#121](https://github.com/voxpupuli/puppet-prometheus/pull/121) ([jhooyberghs](https://github.com/jhooyberghs))

## [v3.1.0](https://github.com/voxpupuli/puppet-prometheus/tree/v3.1.0) (2017-11-26)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- add support for remote\_read [\#109](https://github.com/voxpupuli/puppet-prometheus/pull/109) ([lobeck](https://github.com/lobeck))
- messagebird/beanstalkd\_exporter support [\#105](https://github.com/voxpupuli/puppet-prometheus/pull/105) ([TomaszUrugOlszewski](https://github.com/TomaszUrugOlszewski))
- Add support for mesos exporter [\#59](https://github.com/voxpupuli/puppet-prometheus/pull/59) ([tahaalibra](https://github.com/tahaalibra))

**Fixed bugs:**

- Unable to use this module on fresh alert manager instances [\#55](https://github.com/voxpupuli/puppet-prometheus/issues/55)
- older versions of puppet don't know about the --to\_yaml option [\#119](https://github.com/voxpupuli/puppet-prometheus/pull/119) ([tuxmea](https://github.com/tuxmea))
- prometheus systemd needs network-online and started after multi-user. [\#117](https://github.com/voxpupuli/puppet-prometheus/pull/117) ([tuxmea](https://github.com/tuxmea))
- Disable line wrapping when converting full\_config to yaml.  [\#104](https://github.com/voxpupuli/puppet-prometheus/pull/104) ([benpollardcts](https://github.com/benpollardcts))
- verify whether alert\_manager is running [\#101](https://github.com/voxpupuli/puppet-prometheus/pull/101) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- Error: Could not parse application options: invalid option: --to\_yaml [\#118](https://github.com/voxpupuli/puppet-prometheus/issues/118)
- Flaky Acceptance Tests in TravisCI [\#114](https://github.com/voxpupuli/puppet-prometheus/issues/114)
- Update release on forge.puppetlabs.com [\#107](https://github.com/voxpupuli/puppet-prometheus/issues/107)

**Merged pull requests:**

- release 3.1.0 [\#115](https://github.com/voxpupuli/puppet-prometheus/pull/115) ([bastelfreak](https://github.com/bastelfreak))
- replace all Variant\[Undef.. with Optional\[... [\#103](https://github.com/voxpupuli/puppet-prometheus/pull/103) ([TheMeier](https://github.com/TheMeier))
- release 3.0.0 [\#99](https://github.com/voxpupuli/puppet-prometheus/pull/99) ([bastelfreak](https://github.com/bastelfreak))
- Tests for prometheus::daemon [\#87](https://github.com/voxpupuli/puppet-prometheus/pull/87) ([sathieu](https://github.com/sathieu))

## [v3.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/v3.0.0) (2017-10-31)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v2.0.0...v3.0.0)

**Breaking changes:**

- node\_exporter 0.15.0 compatibiity [\#72](https://github.com/voxpupuli/puppet-prometheus/pull/72) ([TheMeier](https://github.com/TheMeier))

**Implemented enhancements:**

- Running puppet restarts service [\#37](https://github.com/voxpupuli/puppet-prometheus/issues/37)
- manage systemd unit files with camptocamp/systemd [\#90](https://github.com/voxpupuli/puppet-prometheus/pull/90) ([bastelfreak](https://github.com/bastelfreak))
- add feature blackbox exporter [\#74](https://github.com/voxpupuli/puppet-prometheus/pull/74) ([bramblek1](https://github.com/bramblek1))
- Add nginx-vts-exporter [\#71](https://github.com/voxpupuli/puppet-prometheus/pull/71) ([viq](https://github.com/viq))
- Add pushgateway [\#68](https://github.com/voxpupuli/puppet-prometheus/pull/68) ([mdebruyn-trip](https://github.com/mdebruyn-trip))
- Support prometheus \>= 2.0 [\#48](https://github.com/voxpupuli/puppet-prometheus/pull/48) ([sathieu](https://github.com/sathieu))

**Fixed bugs:**

- Blackbox\_exporter manifest erroneously uses -config.file instead of --config.file parameter [\#96](https://github.com/voxpupuli/puppet-prometheus/issues/96)
- Service resource in `prometheus::daemon` does not depend on `init\_style` dependent service description [\#94](https://github.com/voxpupuli/puppet-prometheus/issues/94)
- Wrong service reload command on ubuntu 14.04 [\#89](https://github.com/voxpupuli/puppet-prometheus/issues/89)
- blackbox exporters source\_labels must be unquoted [\#98](https://github.com/voxpupuli/puppet-prometheus/pull/98) ([tuxmea](https://github.com/tuxmea))
- add service notification to systemd and sysv [\#95](https://github.com/voxpupuli/puppet-prometheus/pull/95) ([tuxmea](https://github.com/tuxmea))
- Fix isssue with node\_exporter containing empty pid on RHEL6. [\#88](https://github.com/voxpupuli/puppet-prometheus/pull/88) ([mkrakowitzer](https://github.com/mkrakowitzer))
- add basic acceptance tests; fix wrong service handling in Ubuntu 14.04 [\#86](https://github.com/voxpupuli/puppet-prometheus/pull/86) ([bastelfreak](https://github.com/bastelfreak))
- Fix restart\_on\_change and add tests to Class\[prometheus\] [\#83](https://github.com/voxpupuli/puppet-prometheus/pull/83) ([sathieu](https://github.com/sathieu))

**Closed issues:**

- node\_expoerter v0.15.0 [\#70](https://github.com/voxpupuli/puppet-prometheus/issues/70)
- Tag 1.0.0 [\#47](https://github.com/voxpupuli/puppet-prometheus/issues/47)
- Default Node Exporter Collectors [\#33](https://github.com/voxpupuli/puppet-prometheus/issues/33)
- Minor nitpick [\#1](https://github.com/voxpupuli/puppet-prometheus/issues/1)

**Merged pull requests:**

- use double dash for blackbox exporter options [\#97](https://github.com/voxpupuli/puppet-prometheus/pull/97) ([tuxmea](https://github.com/tuxmea))
- Improve readability of README [\#93](https://github.com/voxpupuli/puppet-prometheus/pull/93) ([roidelapluie](https://github.com/roidelapluie))
- Switch systemd restart from always to on-failure [\#92](https://github.com/voxpupuli/puppet-prometheus/pull/92) ([bastelfreak](https://github.com/bastelfreak))
- Alertmanager global config should be a hash not an array [\#91](https://github.com/voxpupuli/puppet-prometheus/pull/91) ([attachmentgenie](https://github.com/attachmentgenie))
- Test content params of File resources in Class\[prometheus\] [\#84](https://github.com/voxpupuli/puppet-prometheus/pull/84) ([sathieu](https://github.com/sathieu))
- drop legacy validate\_bool calls [\#82](https://github.com/voxpupuli/puppet-prometheus/pull/82) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes in statsd\_exporter [\#81](https://github.com/voxpupuli/puppet-prometheus/pull/81) ([bastelfreak](https://github.com/bastelfreak))
- bump puppet version dependency to at least 4.7.1 [\#80](https://github.com/voxpupuli/puppet-prometheus/pull/80) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes in mysqld\_exporter [\#79](https://github.com/voxpupuli/puppet-prometheus/pull/79) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes in process\_exporter [\#78](https://github.com/voxpupuli/puppet-prometheus/pull/78) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes in haproxy\_exporter [\#77](https://github.com/voxpupuli/puppet-prometheus/pull/77) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes in alertmanager [\#76](https://github.com/voxpupuli/puppet-prometheus/pull/76) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes in init [\#75](https://github.com/voxpupuli/puppet-prometheus/pull/75) ([bastelfreak](https://github.com/bastelfreak))
- use Optional instead of Variant\[Undef... [\#73](https://github.com/voxpupuli/puppet-prometheus/pull/73) ([TheMeier](https://github.com/TheMeier))
- release 2.0.0 [\#67](https://github.com/voxpupuli/puppet-prometheus/pull/67) ([bastelfreak](https://github.com/bastelfreak))

## [v2.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/v2.0.0) (2017-10-12)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/1.0.0...v2.0.0)

**Breaking changes:**

- release 2.0.0 [\#66](https://github.com/voxpupuli/puppet-prometheus/pull/66) ([bastelfreak](https://github.com/bastelfreak))
- Add elasticsearch exporter. Drop Puppet 3 support. [\#51](https://github.com/voxpupuli/puppet-prometheus/pull/51) ([rbestbmj](https://github.com/rbestbmj))

**Implemented enhancements:**

- Bump versions for archive and puppet dependency/support puppet5 [\#65](https://github.com/voxpupuli/puppet-prometheus/pull/65) ([bastelfreak](https://github.com/bastelfreak))
- Add tests for elasticsearch\_exporter and update a bit [\#64](https://github.com/voxpupuli/puppet-prometheus/pull/64) ([salekseev](https://github.com/salekseev))
- Allow uncompressed daemons [\#53](https://github.com/voxpupuli/puppet-prometheus/pull/53) ([sathieu](https://github.com/sathieu))
- Add mongodb\_exporter [\#46](https://github.com/voxpupuli/puppet-prometheus/pull/46) ([salekseev](https://github.com/salekseev))

**Fixed bugs:**

- $DAEMON info is only available for the prometheus daemon [\#50](https://github.com/voxpupuli/puppet-prometheus/pull/50) ([sathieu](https://github.com/sathieu))

**Closed issues:**

- Upgrade to Puppet4? [\#34](https://github.com/voxpupuli/puppet-prometheus/issues/34)

**Merged pull requests:**

- Remove systemd module dependency and fix missing path for a exec [\#58](https://github.com/voxpupuli/puppet-prometheus/pull/58) ([juliantaylor](https://github.com/juliantaylor))
- Update README.md [\#56](https://github.com/voxpupuli/puppet-prometheus/pull/56) ([steinbrueckri](https://github.com/steinbrueckri))
- Use default collectors if "collectors" param is empty [\#49](https://github.com/voxpupuli/puppet-prometheus/pull/49) ([sathieu](https://github.com/sathieu))
- Feature/cleanup and document [\#44](https://github.com/voxpupuli/puppet-prometheus/pull/44) ([jhooyberghs](https://github.com/jhooyberghs))
- Reload config [\#43](https://github.com/voxpupuli/puppet-prometheus/pull/43) ([vide](https://github.com/vide))
- Add param service\_name to node\_exporter class [\#40](https://github.com/voxpupuli/puppet-prometheus/pull/40) ([bastelfreak](https://github.com/bastelfreak))
- backport changes to upstream [\#39](https://github.com/voxpupuli/puppet-prometheus/pull/39) ([bastelfreak](https://github.com/bastelfreak))

## [1.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/1.0.0) (2017-03-26)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v1.0.0...1.0.0)

## [v1.0.0](https://github.com/voxpupuli/puppet-prometheus/tree/v1.0.0) (2017-03-26)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.2.4...v1.0.0)

## [v0.2.4](https://github.com/voxpupuli/puppet-prometheus/tree/v0.2.4) (2017-03-13)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.2.3...v0.2.4)

## [v0.2.3](https://github.com/voxpupuli/puppet-prometheus/tree/v0.2.3) (2017-03-12)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.2.1...v0.2.3)

## [v0.2.1](https://github.com/voxpupuli/puppet-prometheus/tree/v0.2.1) (2017-02-04)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.2.2...v0.2.1)

## [v0.2.2](https://github.com/voxpupuli/puppet-prometheus/tree/v0.2.2) (2017-01-31)

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/v0.2.0...v0.2.2)

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

[Full Changelog](https://github.com/voxpupuli/puppet-prometheus/compare/0305571d72f27fee2c494792cb0970a5d37887f7...v0.1.13)

**Closed issues:**

- Update forge version [\#10](https://github.com/voxpupuli/puppet-prometheus/issues/10)

**Merged pull requests:**

- Add console support [\#15](https://github.com/voxpupuli/puppet-prometheus/pull/15) ([mspaulding06](https://github.com/mspaulding06))
- Add missing quotes to params file [\#14](https://github.com/voxpupuli/puppet-prometheus/pull/14) ([mspaulding06](https://github.com/mspaulding06))
- Get rid of leading whitespace in generated configs [\#13](https://github.com/voxpupuli/puppet-prometheus/pull/13) ([mspaulding06](https://github.com/mspaulding06))
- Bunch of changes to work against the latest prom releases [\#11](https://github.com/voxpupuli/puppet-prometheus/pull/11) ([brutus333](https://github.com/brutus333))
- add support for newer releases of node\_exporter [\#4](https://github.com/voxpupuli/puppet-prometheus/pull/4) ([patdowney](https://github.com/patdowney))
- Systemd does not see all shutdowns as failures [\#3](https://github.com/voxpupuli/puppet-prometheus/pull/3) ([tarjei](https://github.com/tarjei))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*