#! /bin/bash

# Function to display usage
usage() {
  echo "Usage: $0 [-v version_component] -m tag_message"
  echo "  -v version_component  Specify the version component to increment (major, minor, patch). Default is minor."
  echo "  -m tag_message        Provide a message for the tag."
  echo "  -h                    Display this help message."
  exit 1
}

# Get the latest git tag
latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

# Check if there are no tags
if [ -z "$latest_tag" ]; then
  echo "No tag found"
  latest_tag="v0.0.0"
else
  echo "Current version: $latest_tag"
fi

# Strip the 'v' prefix if it exists
if [[ $latest_tag == v* ]]; then
  latest_tag=${latest_tag:1}
fi

# Split the version into major, minor, and patch components
IFS='.' read -r major minor patch <<< "$latest_tag"

# Set default values
version_component="minor"
tag_message=""

# Parse command-line arguments
while getopts ":v:m:h" opt; do
  case $opt in
    v)
      version_component=$OPTARG
      ;;
    m)
      tag_message=$OPTARG
      ;;
    h)
      usage
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      ;;
  esac
done

case $version_component in
  major)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  minor)
    minor=$((minor + 1))
    patch=0
    ;;
  patch)
    patch=$((patch + 1))
    ;;
  *)
    echo "Invalid version component: $version_component" >&2
    usage
    ;;
esac

# Create the new version tag
new_tag="v$major.$minor.$patch"

echo "Next version: $new_tag"

# Check if the message is provided and ask the user otherwise
while [ -z "$tag_message" ]; do
  read -p "Tag message is required. Please enter a message: " tag_message
done

# Prompt for confirmation
echo "New tag to be created: $new_tag with message: $tag_message"
read -p "Are you sure you want to create this tag? (y/n): " confirm

if [[ $confirm != "y" ]]; then
  echo "Tag creation aborted."
  exit 0
fi

# Create the git tag
git tag -a "$new_tag" -m "$tag_message"

# Push the tag to the remote repository
read -p "Do you want to push this tag? (y/n): " push
if [[ $push = "y" ]]; then
  git push origin "$new_tag"
fi
