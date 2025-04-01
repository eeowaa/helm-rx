# Helm Rx

Regular expression library chart for Helm. Provides templates to supplement
Helm's built-in [regular expression functions](https://helm.sh/docs/chart_template_guide/function_list/#regular-expressions).

## Installation

To use this library in a Helm chart, perform the following steps from within
your local chart directory, adjusting paths and versions as necessary:

1. Clone the git repository for Helm Rx:

    ```sh
    git clone --depth 1 -b 0.1.0 https://github.com/eeowaa/helm-rx.git ../helm-rx
    ```

2. Add a library chart dependency to your chart's `Chart.yaml`:

    ```yaml
    dependencies:
      - name: rx
        version: 0.1.0
        repository: file://../helm-rx
    ```

3. Copy the Helm Rx library chart into your `charts/` directory:

    ```sh
    helm dependency update
    ```

For more information about Helm dependencies and library charts, see the
official Helm documentation:

- <https://helm.sh/docs/helm/helm_dependency/>
- <https://helm.sh/docs/topics/library_charts/>

## Usage

This chart provides the following templates:

- `rx.removeAll`: Removes all matches of a regex from a string.
- `rx.trimPrefix`: Trims a regex prefix from a string.
- `rx.trimSuffix`: Trims a regex suffix from a string.

The expected context of each template is a two-element list consisting of a
regex and a string. For example, the following template would remove all
non-uppercase characters from `"HELLO, world!"`, expanding to `"HELLO"`:

```
{{ include "rx.removeAll" (list "[^A-Z]+" "HELLO, world!") }}
```

Helm Rx templates can be chained together and with built-in functions to
perform more complex string manipulations. For example, the following pipeline
returns a modified `.Chart.Name` string that conforms to DNS subdomain name
requirements per [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

```
{{- lower .Chart.Name
  | list "[^a-z0-9.-]+" | include "rx.removeAll"
  | list "[^a-z0-9]+" | include "rx.trimPrefix"
  | trunc 253
  | list "[^a-z0-9]+" | include "rx.trimSuffix"
}}
```

Several useful string manipulation templates that leverage Helm Rx have been
made available in the [Helm Fmt library chart](https://github.com/eeowaa/helm-fmt.git).
