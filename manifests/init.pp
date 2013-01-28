define apt_version_pin ($preferences = '/etc/apt/preferences', $version, $priority) {
    # Create a new version pin when this match fails.
    # Each key listed here must be set in $creates.
    $match = "*[Package = '${title}' and Pin = 'version']"

    # The 'creates' are combined with the 'changes' to create the pin.
    $creates = [
        "set 00/Package ${title}",
        "set 00/Pin version",
    ]

    # The 'changes' alter existing pins to match the provided values.
    $changes = [
        "set ${match}/Pin/version ${version}",
        "set ${match}/Pin-Priority ${priority}",
    ]

    augeas {
        "apt_version_pin_create_${title}":
            context => "/files/${preferences}",
            changes => [
                $creates,
                $changes,
            ],
            onlyif  => "match ${match} size == 0";

        "apt_version_pin_${title}":
            context => "/files/${preferences}",
            changes => $changes,
            require => Augeas["apt_version_pin_create_${title}"];
    }
}
