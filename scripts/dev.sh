#!/bin/bash

# iOS Development Helper Script
# This script provides common development tasks for the Sample iOS App

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if we're on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script requires macOS for iOS development"
        exit 1
    fi
}

# Function to check if Xcode is installed
check_xcode() {
    if ! command -v xcodebuild &> /dev/null; then
        print_error "Xcode is not installed. Please install Xcode from the App Store."
        exit 1
    fi
}

# Function to setup the project
setup() {
    print_status "Setting up iOS development environment..."
    
    # Install bundler if not present
    if ! command -v bundle &> /dev/null; then
        print_status "Installing bundler..."
        gem install bundler
    fi
    
    # Install dependencies
    print_status "Installing Ruby dependencies..."
    bundle install
    
    # Install fastlane plugins
    print_status "Installing Fastlane plugins..."
    bundle exec fastlane install_plugins
    
    print_status "Setup complete! You can now use the development commands."
}

# Function to run tests
test() {
    print_status "Running tests..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane test
    else
        fastlane test
    fi
}

# Function to build the app
build() {
    print_status "Building the app..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane build
    else
        fastlane build
    fi
}

# Function to build and test
build_and_test() {
    print_status "Building and testing the app..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane build_and_test
    else
        fastlane build_and_test
    fi
}

# Function to cut a new release
cut_release() {
    print_status "Cutting a new release..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane cut_release
    else
        fastlane cut_release
    fi
}

# Function to create PR from release to main
sync_release() {
    print_status "Creating PR to sync release branch to main..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane create_pr_from_release_branch_v2
    else
        fastlane create_pr_from_release_branch_v2
    fi
}

# Function to filter merge commits
filter_commits() {
    if [ -z "$2" ]; then
        print_error "Please provide comma-separated commit hashes"
        echo "Usage: $0 filter_commits \"hash1,hash2,hash3\""
        exit 1
    fi
    
    print_status "Filtering merge commits from: $2"
    if command -v bundle &> /dev/null; then
        bundle exec fastlane filter_merge_commits commits:"$2"
    else
        fastlane filter_merge_commits commits:"$2"
    fi
}

# Function to increment version
increment_version() {
    print_status "Incrementing version number..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane increment_version
    else
        fastlane increment_version
    fi
}

# Function to increment build
increment_build() {
    print_status "Incrementing build number..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane increment_build
    else
        fastlane increment_build
    fi
}

# Function to show available lanes
lanes() {
    print_status "Available Fastlane lanes:"
    if command -v bundle &> /dev/null; then
        bundle exec fastlane lanes
    else
        fastlane lanes
    fi
}

# Function to show help
show_help() {
    echo "iOS Development Helper Script"
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Available commands:"
    echo "  setup              Setup the development environment"
    echo "  test               Run all tests"
    echo "  build              Build the app"
    echo "  build_and_test     Build and test the app"
    echo "  cut_release        Cut a new release (creates branch & PR)"
    echo "  sync_release       Sync release branch to main (creates PR)"
    echo "  filter_commits     Filter merge commits from a list"
    echo "  increment_version  Bump the version number"
    echo "  increment_build    Bump the build number"
    echo "  lanes              Show available Fastlane lanes"
    echo "  help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 setup"
    echo "  $0 test"
    echo "  $0 build_and_test"
    echo "  $0 cut_release"
    echo "  $0 sync_release"
    echo "  $0 filter_commits \"abc123,def456,ghi789\""
    echo "  $0 increment_version"
}

# Main script logic
case "${1:-help}" in
    setup)
        check_macos
        setup
        ;;
    test)
        check_macos
        check_xcode
        test
        ;;
    build)
        check_macos
        check_xcode
        build
        ;;
    build_and_test)
        check_macos
        check_xcode
        build_and_test
        ;;
    cut_release)
        check_macos
        cut_release
        ;;
    sync_release)
        check_macos
        sync_release
        ;;
    filter_commits)
        check_macos
        filter_commits "$@"
        ;;
    increment_version)
        check_macos
        increment_version
        ;;
    increment_build)
        check_macos
        increment_build
        ;;
    lanes)
        lanes
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac