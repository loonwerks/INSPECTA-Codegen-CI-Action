#!/bin/bash -l


echo "sysmlv2-files: $1"
echo "sourcepaths: $2"
echo "line: $3"
echo "system-name: $4"
echo "verbose: $5"
echo "runtime-monitoring: $6"
echo "platform: $7"
echo "output-dir: $8"
echo "parseable-messages: $9"
echo "slang-options ${10}"
echo "transpiler-options ${11}"
echo "camkes-microkit-options ${12}"
echo "ros2-options ${13}"
echo "experimental-options ${14}"

runCommand=(/Sireum/bin/sireum hamr sysml codegen)

if [[ -n $2 ]]; then
	sourcePaths=$(echo $2 | jq -r 'join(",")')
	if [[ -n $sourcePaths ]]; then
		runCommand+=(--sourcepath $sourcePaths)
	fi
fi

if [[ -n $3 ]]; then
	runCommand+=(--line $3)
fi

if [[ -n $4 ]]; then
	runCommand+=(--system-name $4)
fi

if [ "XX $5" = "XX true" ]; then
	runCommand+=(--verbose)
fi

if [ "XX $6" = "XX true" ]; then
	runCommand+=(--runtime-monitoring)
fi

if [[ -n $7 ]]; then
	runCommand+=(--platform $7)
fi

if [[ -n $8 ]]; then
	runCommand+=(--output-dir $8)
fi

if [ "XX $9" = "XX true" ]; then
	runCommand+=(--parseable-messages)
fi

# Slang options
if [[ -n ${10} ]]; then
	slangOutputDir=$(echo ${10} | jq '.["slang-output-dir"]')
	if [[ -n $slangOutputDir ]]; then
		runCommand+=(--slang-output-dir $slangOutputDir)
	fi
	packageName=$(echo ${10} | jq '.["package-name"]')
	if [[ -n $packageName ]]; then
		runCommand+=(--package-name $packageName)
	fi
	noProyekIve=$(echo ${10} | jq '.["no-proyek-ive"]')
	if [ "XX $noProyekIve" = "XX true" ]; then
		runCommand+=(--no-proyek-ive)
	fi
	noEmbedArt=$(echo ${10} | jq '.["no-embed-art"]')
	if [ "XX $noEmbedArt" = "XX true" ]; then
		runCommand+=(--no-embed-art)
	fi
	devicesAsThread=$(echo ${10} | jq '.["devices-as-thread"]')
	if [ "XX $devicesAsThread" = "XX true" ]; then
		runCommand+=(--devices-as-thread)
	fi
	sbtMill=$(echo ${10} | jq '.["sbt-mill"]')
	if [ "XX $sbtMill" = "XX true" ]; then
		runCommand+=(--sbt-mill)
	fi
fi

# Transpiler options
if [[ -n ${11} ]]; then
	auxCodeDirs=$(echo ${11} | jq -r '.["aux-code-dirs] | join(",")')
	if [[ -n $auxCodeDirs ]]; then
		runCommand+=(--aux-code-dirs $auxCodeDirs)
	fi
	outputCDir=$(echo ${11} | jq '.["output-c-dir]')
	if [[ -n $outputCDir ]]; then
		runCommand+=(--output-c-dir $outputCDir)
	fi
	excludeComponentImpl=$(echo ${11} | jq '.["exclude-component-impl"]')
	if [ "XX $excludeComponentImpl" = "XX true" ]; then
		runCommand+=(--exclude-component-impl)
	fi
	bitWidth=$(echo ${11} | jq '.["bit-width"]')
	if [[ -n $bitWidth ]]; then
		runCommand+=(--bit-width $bitWidth)
	fi
	maxStringSize=$(echo ${11} | jq '.["max-string-size"]')
	if [[ -n $maxStringSize ]]; then
		runCommand+=(--max-string-size $maxStringSize)
	fi
	maxArraySize=$(echo ${11} | jq '.["max-array-size"]')
	if [[ -n $maxArraySize ]]; then
		runCommand+=(--max-array-size $maxArraySize)
	fi
	runTranspiler=$(echo ${11} | jq '.["run-transpiler"]')
	if [ "XX $runTranspiler" = "XX true" ]; then
		runCommand+=(--run-transpiler)
	fi
fi

# CAmkES/Microkit options
if [[ -n ${12} ]]; then
	sel4OutputDir=$(echo ${12} | jq '.["sel4-output-dir"]')
	if [[ -n $sel4OutputDir ]]; then
		runCommand+=(--sel4-output-dir $sel4OutputDir)
	fi
	sel4AuxCodeDirs+=$(echo ${12} | jq -r '.["sel4-aux-code-dirs] | join(",")')
	if [[ -n $sel4AuxCodeDirs ]]; then
		runCommand+=(--sel4-aux-code-dirs $sel4AuxCodeDirs)
	fi
	workspaceRootDir=$(echo ${12} | jq '.["workspace-root-dir"]')
	if [[ -n $workspaceRootDir ]]; then
		runCommand+=(--workspace-root-dir $workspaceRootDir)
	fi
fi

# ROS2 options
if [[ -n ${13} ]]; then
	ros2OutputWorkspaceDir=$(echo ${13} | jq '.["ros2-output-workspace-dir"]')
	if [[ -n $ros2OutputWorkspaceDir ]]; then
		runCommand+=(--ros2-output-workspace-dir $ros2OutputWorkspaceDir)
	fi
	ros2Dir=$(echo ${13} | jq '.["ros2-dir"]')
	if [[ -n $ros2Dir ]]; then
		runCommand+=(--ros2-dir $ros2Dir)
	fi
	ros2NodesLanguage=$(echo ${13} | jq '.["ros2-nodes-language"]')
	if [[ -n $ros2NodesLanguage ]]; then
		runCommand+=(--ros2-nodes-language $ros2NodesLanguage)
	fi
	ros2LaunchLanguage=$(echo ${13} | jq '.["ros2-launch-language"]')
	if [[ -n $ros2LaunchLanguage ]]; then
		runCommand+=(--ros2-launch-language $ros2LaunchLanguage)
	fi
	invertTopicBinding=$(echo ${13} | jq '.["invert-topic-binding"]')
	if [ "XX $invertTopicBinding" = "XX true" ]; then
		runCommand+=(--invert-topic-binding)
	fi
fi

# Experimental options
if [[ -n ${14} ]]; then
	experimentalOptions=$(echo ${14} | jq -r 'join(";")')
fi

# SysMLv2 files
runCommand+=($(echo $1 | jq -r 'join(" ")'))

outputFile="codegen.out"
if [[ -n $3 ]]; then
	outputFile=$3
fi

echo "run command: ${runCommand[@]}" 

"${runCommand[@]}" >> "$outputFile"
EXIT_CODE=$?

echo "timestamp=$(date)" >> $GITHUB_OUTPUT
echo "status=${EXIT_CODE}" >> $GITHUB_OUTPUT
echo "status-messages=$(cat ${outputFile} | jq -R -s '.')" >> $GITHUB_OUTPUT

echo "exit code: $EXIT_CODE"
if [ "XX $EXIT_CODE" = "XX 0" ]; then
	exit 0
else
	exit 1
fi
