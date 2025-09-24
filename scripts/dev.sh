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

# Function to deploy to TestFlight
beta() {
    print_status "Deploying to TestFlight..."
    if command -v bundle &> /dev/null; then
        bundle exec fastlane beta
    else
        fastlane beta
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
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Available commands:"
    echo "  setup           Setup the development environment"
    echo "  test            Run all tests"
    echo "  build           Build the app"
    echo "  build_and_test  Build and test the app"
    echo "  beta            Deploy to TestFlight"
    echo "  lanes           Show available Fastlane lanes"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 setup"
    echo "  $0 test"
    echo "  $0 build_and_test"
    echo "  $0 beta"
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
    beta)
        check_macos
        check_xcode
        beta
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