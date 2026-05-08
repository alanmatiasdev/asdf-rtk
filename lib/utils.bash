#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/rtk-ai/rtk"
TOOL_NAME="rtk"
TOOL_TEST="rtk --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if rtk is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

normalize_version() {
	printf "%s\n" "$1" | sed 's/^v//'
}

release_tag() {
	local version
	version="$(normalize_version "$1")"

	printf "v%s\n" "$version"
}

rtk_target() {
	local os arch
	os="$(uname -s)"
	arch="$(uname -m)"

	case "$arch" in
	x86_64 | amd64) arch="x86_64" ;;
	arm64 | aarch64) arch="aarch64" ;;
	*) fail "Unsupported architecture: $arch" ;;
	esac

	case "$os" in
	Darwin)
		printf "%s-apple-darwin\n" "$arch"
		;;
	Linux)
		case "$arch" in
		x86_64) printf "x86_64-unknown-linux-musl\n" ;;
		aarch64) printf "aarch64-unknown-linux-gnu\n" ;;
		esac
		;;
	*) fail "Unsupported operating system: $os" ;;
	esac
}

release_asset_filename() {
	printf "%s-%s.tar.gz\n" "$TOOL_NAME" "$(rtk_target)"
}

download_release() {
	local version filename asset url
	version="$(normalize_version "$1")"
	filename="$2"
	asset="$(release_asset_filename)"

	url="$GH_REPO/releases/download/$(release_tag "$version")/$asset"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

download_checksums() {
	local version filename url
	version="$(normalize_version "$1")"
	filename="$2"

	url="$GH_REPO/releases/download/$(release_tag "$version")/checksums.txt"

	echo "* Downloading $TOOL_NAME checksums..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

verify_checksum() {
	local file checksums asset expected actual
	file="$1"
	checksums="$2"
	asset="$(basename "$file")"

	expected="$(awk -v asset="$asset" '$2 == asset { print $1 }' "$checksums")"
	[ -n "$expected" ] || fail "Could not find checksum for $asset"

	if command -v sha256sum >/dev/null 2>&1; then
		actual="$(sha256sum "$file" | awk '{ print $1 }')"
	elif command -v shasum >/dev/null 2>&1; then
		actual="$(shasum -a 256 "$file" | awk '{ print $1 }')"
	else
		fail "Could not verify checksum: sha256sum or shasum is required"
	fi

	[ "$actual" = "$expected" ] || fail "Checksum verification failed for $asset"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
