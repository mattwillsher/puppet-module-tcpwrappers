class tcpwrappers (
	$allow = {},
	$deny  = {}
) {

	validate_hash($allow)
	validate_hash($deny)

	# Fix permissions and ownership on deny file
	file { "/etc/hosts.deny":
		owner => root,
		group => root,
		mode  => 0644;
	}

	# Append default deny if not already there
	tcpwrappers::deny { "tcpwrappers/deny-by-default":
		daemon => "ALL",
		client => "ALL";
	}

	create_resources('tcpwrappers::allow',$allow)
	create_resources('tcpwrappers::deny',$deny)
}
