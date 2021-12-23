#!/bin/sh

##################################
## OSX Packager for MSG Viewer
## 
## This requires JDK 14 or higher
##################################

echo "Building app.."
cd ..
./mvnw package

#retrieve version
VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout|awk -F'-SNAPSHOT' '{print $1}')
echo "Version will be: $VERSION"

echo "Packaging DMG.." 
cd -
jpackage --type dmg \
         -i ../MSGViewer/target \
         -n "MSG Viewer" \
         --app-version $VERSION \
         --icon "./msg-viewer.icns" \
         --main-class net.sourceforge.MSGViewer.ModuleLauncher \
         --main-jar msgviewer.jar

echo "Moving to distribution folder.."
rm -rf ../dist
mkdir ../dist
mv *.dmg ../dist

echo "packaging complete."
