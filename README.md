# INSPECTA-Logika-CI-Action

INSPECTA CI action to conduct Logika analysis on a SySML (v2) model.

This action requires use of the `persist-credentials` with clause on the `actions/checkout` checking out the repository to which this action is applied.

## Inputs

### `sysmlv2-files`

**Required** JSON-formatted list of SySML model files to include in the analysis. 

### `sourcepaths`

JSON-formatted list of source paths of SysML v2 .sysml files (expects path strings).

### `line`

Line number containing the system to instantiate in the <sysmlv2-file> argument (expects an integer; min is 0, default 0).

### `system-name`

Fully qualified name of the system to instantiate (expects a string).

### `verbose`

Enable verbose mode, default false.

### `runtime-monitoring`

Enable runtime monitoring, default false.

### `platform`

Target platform (expects one of { JVM, Linux, Cygwin, MacOS, seL4, seL4_Only, seL4_TB, Microkit, ros2; default JVM }).'

### `output-dir`

Default output directory (expects a path).

### `parseable-messages`

Print parseable file messages, default false'

### `slang-options`

The following Slang options are supported:

+ slang-output-dir:
  - description: 'Output directory for the generated Slang project files (expects a path).'
  - required: false
+ package-name:
  - description: 'Base package name for Slang project (expects a string).'
  - required: false
  - default: 'base'
+ no-proyek-ive:
  - description: 'Do not run Proyek IVE.'
  - required: false
  - default: 'false'
+ no-embed-art:
  - description: 'Do not embed ART project files.'
  - required: false
  - default: 'false'
+ devices-as-thread:
  - description: 'Treat AADL devices as threads.'
  - required: false
  - default: 'false'
+ sbt-mill:
  - description: 'Generate SBT and Mill projects in addition to Proyek.'
  - required: false
  - default: 'false'

Approximation options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "slang-output-dir" : false
  "package-name" : "base"
  "no-proyek-ive" : false
  "no-embed-art" : false
  "devices-as-thread" : false
  "sbt-mill" : false
}
~~~

### `transpiler-options`

The following transpiler options are supported:

+ aux-code-dirs:
  - description: 'Auxiliary C source code directories (expects JSON list of path strings).'
  - required: false
  - default: '[]]'
+ output-c-dir:
  - description: 'Output directory for C artifacts (expects a path).'
  - required: false
  - default: '.'
+ exclude-component-impl:
  - description: 'Exclude Slang component implementations, behavior code written in C.'
  - required: false
  - default: 'false'
+ bit-width:
  - description: 'Default bit-width for unbounded integer types (e.g., Z) (expects one of { 64, 32, 16, 8 }).'
  - required: false
  - default: '32'
+ max-string-size:
  - description: 'Size for statically allocated strings (expects an integer).'
  - required: false
  - default: '100'
+ max-array-size:
  - description: 'Default sequence size (e.g., for ISZ, MSZ (expects an integer).'
  - required: false
  - default: '100'
+ run-transpiler:
  - description: 'un Transpiler during HAMR Codegen.'
  - required: false
  - default: 'false'

Control options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "aux-code-dirs" : []
  "output-c-dir" : "."
  "exclude-component-impl" : "false"
  "bit-width" : 32
  "max-string-size" : 100
  "max-array-size" : 100
  "run-transpiler" : false
}
~~~

### `camkes-microkit-options`

The following CAmkES/Microkit options are supported:

+ sel4-output-dir:
  - description: 'Output directory for the generated CAmkES/Microkit project files (expects a path).'
  - required: false
  - default: '.'
+ sel4-aux-code-dirs:
  - description: 'Directories containing C files to be included in CAmkES/Microkit build (expects JSON list of path strings).'
  - required: false
  - default: '[]'
+ workspace-root-dir:
  - description: 'Root directory containing the architectural model project (expects a path).'
  - required: false
  - default: '.'

Logging options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "sel4-output-dir" : "."
  "sel4-aux-code-dirs" : []
  "workspace-root-dir" : "."
}
~~~

### `ros2-options`

The following ROS2 options are supported:

+ ros2-output-workspace-dir:
  - description: 'The path to the ROS2 workspace to generate the packages into (expects a path).'
  - required: false
  - default: '.'
+ ros2-dir:
  - description: 'The path to your ROS2 installation, including the version (../ros/humble) (expects a path).'
  - required: false
  - default: '.'
+ ros2-nodes-language:
  - description: 'The programming language for the generated node files (expects one of { Python, Cpp }).'
  - required: false
  - default: 'Python'
+ ros2-launch-language:
  - description: 'The programming language for the generated launch files (expects one of { Python, Xml }).'
  - required: false
  - default: 'Python'
+ invert-topic-binding:
  - description: 'By default, topic names are based on in ports, and fan out ports would have multiple publishers.  This option inverts that behavior.'
  - required: false
  - default: 'false'

Optimization options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "ros2-output-workspace-dir" : "."
  "ros2-dir" : "."
  "ros2-nodes-language" : "Python"
  "ros2-launch-language" : "Python"
  "invert-topic-binding" : false
}
~~~

### `experimental-options`

JSON-formatted list of experimental options.  See Sireum documentation.

## Outputs

## `result`

The JSON-formatted summary of analysis results.

## Example usage

uses: actions/AGREE-CI-Action@v1
with:
  component-to-analyze: 'Octocat.impl'
