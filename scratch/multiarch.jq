# { "platform": yes }
# (not all combinations returned by this are actually meaningful or existent, but they sure are cute)
def platforms:
	[
		{
			os: (
				"linux",
				"windows",
				"freebsd",
				empty
			),
			architecture: (
				"amd64", "386",
				"arm64", "arm",
				"loong64",
				"mips64le", "mips64", "mipsle", "mips",
				"ppc64le", "ppc64",
				"riscv64",
				"s390x",
				empty
			),
		}

		| ({
			"windows": [
				# https://github.com/microsoft/hcsshim/blob/64208bd5d7cab7197bcb8a8282502b288bcc75b9/osversion/windowsbuilds.go
				# $ wget -qO- 'https://github.com/microsoft/hcsshim/raw/HEAD/osversion/windowsbuilds.go' | jq --slurp --raw-input '[ scan(" = ([0-9]+)")[0] ] | unique_by(-tonumber)'
				"26100",
				"25398",
				"22621",
				"22000",
				"20348",
				"19045",
				"19044",
				"19043",
				"19042",
				"19041",
				"18363",
				"18362",
				"17763",
				"17134",
				"16299",
				"15063",
				"14393",
				empty
				| "10.0.\(.).0"
			],
			"freebsd": [
				"15.0",
				"14.3",
				"14.2",
				"14.1",
				"14.0",
				"13.5",
				"13.4",
				"13.3",
				"13.2",
				"13.1",
				"13.0",
				"12.4",
				"12.3",
				"12.2",
				"12.1",
				"12.0",
				empty
			],
		}[.os] // []) as $osVersions
		| ."os.version" = $osVersions[], .

		| ({
			"amd64": [ "v4", "v3", "v2", "v1" ],
			"arm": [ "v9", "v8", "v7", "v6", "v5" ],
			"arm64": [
				"v9.6", "v9.5", "v9.4", "v9.3", "v9.2", "v9.1", "v9.0", "v9",
				"v8.9", "v8.8", "v8.7", "v8.6", "v8.5", "v8.4", "v8.3", "v8.2", "v8.1", "v8.0", "v8",
				empty
			],
			"ppc64le": [ "power10", "power9", "power8" ],
			"riscv64": [ "rva23u64", "rva22u64", "rva20u64" ],
		}[
			{
				"ppc64": "ppc64le",
				"mips64": "mips64le",
			}[.architecture]
			// .architecture
		] // []) as $variants
		| .variant = $variants[], .
	]
;
