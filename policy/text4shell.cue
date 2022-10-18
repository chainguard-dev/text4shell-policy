import (
	"list"
	"strings"
)

let text4shell_names = ["commons-text"]
let text4shell_versions = ["1.5", "1.6", "1.7", "1.8", "1.9"]

predicate: Data: components: [...{
	name:    name
	version: version
	if list.Contains(text4shell_names, name) &&
		list.Contains(text4shell_versions, version) {
		err: strings.Join([
			"Error: CycloneDX SBOM contains package",
			name, "version", version, "which is",
			"vulnerable to text4shell (CVE-2022-42889)",
		], " ")
		name: err
	}
}]
