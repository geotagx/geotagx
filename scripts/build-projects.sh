#!/bin/bash
# Build and deploy the projects on the current PyBossa server.
# This script depends on the pbs command line client, and as such, assumes it has been set up correctly.
ROOT_DIR="$(git rev-parse --show-toplevel)"

GITMODULES="$ROOT_DIR/.gitmodules"

PROJECTS=$(cat "$GITMODULES" | grep "path = projects/" | sed "s/^[ \t]*path = projects\///")
PROJECTS_DIR="$ROOT_DIR/projects"
#PROJECT_BUILDER="$ROOT_DIR/project-template/build.py"

# Note that the '\n' character appended to the string makes sure the last line is read.
printf "$PROJECTS\n" | while IFS= read -r path
do
    cd "$PROJECTS_DIR/$path" && python "$ROOT_DIR/project-template/build.py" . && pbs update_project
done
