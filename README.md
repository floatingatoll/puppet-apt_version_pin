puppet-apt_version_pin
======================

Puppet module to pin apt versions easily.

Usage:

    apt_version_pin {
        [
            'puppet',
            'puppet-common',
        ]:
            version => '2.7.20-1.puppetlabs1',
            priority => '1001';
    }

Notes:

- Changes are made using Augeas, avoid mixing with File <| path = '/etc/apt/preferences' |> resources.
- Other kinds of pinning are possible, but this does just what I needed and nothing more.
