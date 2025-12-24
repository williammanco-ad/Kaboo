#!/bin/bash

# Version Management Script for Kaboo
# This script helps manage version numbers for releases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo "Usage: $0 [major|minor|patch|set VERSION]"
    echo ""
    echo "Commands:"
    echo "  major        Increment major version (X.0.0)"
    echo "  minor        Increment minor version (x.X.0)"
    echo "  patch        Increment patch version (x.x.X)"
    echo "  set VERSION  Set specific version (e.g., 1.2.3)"
    echo "  current      Display current version"
    echo ""
    echo "Examples:"
    echo "  $0 patch     # 1.0.0 -> 1.0.1"
    echo "  $0 minor     # 1.0.1 -> 1.1.0"
    echo "  $0 major     # 1.1.0 -> 2.0.0"
    echo "  $0 set 2.5.0 # Set to 2.5.0"
    exit 1
}

# Function to get current version from git tags
get_current_version() {
    VERSION=$(git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || echo "0.0.0")
    echo "$VERSION"
}

# Function to parse version
parse_version() {
    local version=$1
    MAJOR=$(echo "$version" | cut -d. -f1)
    MINOR=$(echo "$version" | cut -d. -f2)
    PATCH=$(echo "$version" | cut -d. -f3)
}

# Function to increment version
increment_version() {
    local current=$1
    local increment_type=$2
    
    parse_version "$current"
    
    case $increment_type in
        major)
            MAJOR=$((MAJOR + 1))
            MINOR=0
            PATCH=0
            ;;
        minor)
            MINOR=$((MINOR + 1))
            PATCH=0
            ;;
        patch)
            PATCH=$((PATCH + 1))
            ;;
    esac
    
    echo "${MAJOR}.${MINOR}.${PATCH}"
}

# Function to validate version format
validate_version() {
    local version=$1
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${RED}Error: Invalid version format. Use semantic versioning (e.g., 1.2.3)${NC}"
        exit 1
    fi
}

# Function to create and push tag
create_tag() {
    local version=$1
    local tag="v${version}"
    
    echo -e "${YELLOW}Creating tag: ${tag}${NC}"
    
    # Check if tag already exists
    if git rev-parse "$tag" >/dev/null 2>&1; then
        echo -e "${RED}Error: Tag ${tag} already exists${NC}"
        exit 1
    fi
    
    # Create annotated tag
    git tag -a "$tag" -m "Release version ${version}"
    
    echo -e "${GREEN}✓ Tag ${tag} created${NC}"
    echo ""
    echo "To push the tag and trigger a release, run:"
    echo -e "${YELLOW}  git push origin ${tag}${NC}"
    echo ""
    echo "Or to push all tags:"
    echo -e "${YELLOW}  git push --tags${NC}"
}

# Main script
main() {
    if [ $# -eq 0 ]; then
        usage
    fi
    
    CURRENT_VERSION=$(get_current_version)
    
    case $1 in
        current)
            echo "Current version: v${CURRENT_VERSION}"
            ;;
        major|minor|patch)
            NEW_VERSION=$(increment_version "$CURRENT_VERSION" "$1")
            echo "Current version: v${CURRENT_VERSION}"
            echo "New version:     v${NEW_VERSION}"
            echo ""
            read -p "Create tag v${NEW_VERSION}? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                create_tag "$NEW_VERSION"
            else
                echo "Cancelled."
            fi
            ;;
        set)
            if [ -z "$2" ]; then
                echo -e "${RED}Error: Version number required${NC}"
                usage
            fi
            NEW_VERSION=$2
            validate_version "$NEW_VERSION"
            echo "Current version: v${CURRENT_VERSION}"
            echo "New version:     v${NEW_VERSION}"
            echo ""
            read -p "Create tag v${NEW_VERSION}? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                create_tag "$NEW_VERSION"
            else
                echo "Cancelled."
            fi
            ;;
        *)
            usage
            ;;
    esac
}

main "$@"
