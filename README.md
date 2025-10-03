# Sample iOS Application with Fastlane Setup

A sample iOS application demonstrating best practices for iOS development with automated CI/CD using Fastlane.

## Features

- **Sample iOS App**: A complete iOS application built with Swift and UIKit
- **Fastlane Integration**: Automated build, test, and deployment workflows
- **GitHub Actions CI/CD**: Continuous integration and deployment pipeline
- **Code Signing**: Configured for automatic code signing with Match
- **Testing**: Unit tests and UI tests included
- **Documentation**: Comprehensive setup and usage instructions

## Project Structure

```
├── SampleiOSApp/                    # Main iOS application
│   ├── AppDelegate.swift           # App delegate
│   ├── SceneDelegate.swift         # Scene delegate
│   ├── ViewController.swift        # Main view controller
│   ├── Assets.xcassets/            # App assets and icons
│   ├── Base.lproj/                 # Storyboards and localizations
│   └── Info.plist                  # App configuration
├── SampleiOSAppTests/              # Unit tests
├── SampleiOSAppUITests/            # UI tests
├── fastlane/                       # Fastlane configuration
│   ├── Appfile                     # App configuration
│   ├── Fastfile                    # Automation lanes
│   ├── Matchfile                   # Code signing configuration
│   └── Pluginfile                  # Fastlane plugins
├── .github/workflows/              # GitHub Actions workflows
├── SampleiOSApp.xcodeproj/         # Xcode project
├── SampleiOSApp.xcworkspace/       # Xcode workspace
└── Gemfile                         # Ruby dependencies
```

## Requirements

- **macOS**: Required for iOS development
- **Xcode 15.0+**: Apple's development environment
- **Ruby 3.0+**: For Fastlane
- **Bundler**: Ruby dependency manager
- **Fastlane**: Mobile DevOps automation

## Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd test-release-branching
```

### 2. Quick Setup (Recommended)

Use the provided development script for easy setup:

```bash
# Make the script executable
chmod +x scripts/dev.sh

# Setup the development environment
./scripts/dev.sh setup
```

### 3. Manual Setup

Alternatively, install dependencies manually:

```bash
# Install Ruby dependencies
bundle install

# Install Fastlane plugins
bundle exec fastlane install_plugins
```

## Development Helper Script

The project includes a development helper script (`scripts/dev.sh`) that simplifies common tasks:

```bash
# Show available commands
./scripts/dev.sh help

# Setup development environment
./scripts/dev.sh setup

# Run tests
./scripts/dev.sh test

# Build the app
./scripts/dev.sh build

# Build and test together
./scripts/dev.sh build_and_test

# Deploy to TestFlight
./scripts/dev.sh beta

# Show available Fastlane lanes
./scripts/dev.sh lanes
```

### 4. Configure Code Signing

Edit `fastlane/Appfile` with your Apple Developer account details:

```ruby
app_identifier("com.yourcompany.SampleiOSApp")
apple_id("your_apple_id@example.com")
itc_team_id("YOUR_TEAM_ID")
team_id("YOUR_TEAM_ID")
```

Edit `fastlane/Matchfile` with your certificates repository:

```ruby
git_url("https://github.com/your-org/certificates")
```

### 5. Setup Match (Code Signing)

```bash
# Initialize match for the first time
bundle exec fastlane match init

# Generate certificates and provisioning profiles
bundle exec fastlane match development
bundle exec fastlane match appstore
```

## Available Fastlane Lanes

### Testing

```bash
# Run all tests
bundle exec fastlane test
```

### Building

```bash
# Build the app for development
bundle exec fastlane build

# Build and test together
bundle exec fastlane build_and_test
```

### Deployment

```bash
# Deploy to TestFlight
bundle exec fastlane beta

# Deploy to App Store
bundle exec fastlane release
```

### Version Management

```bash
# Increment build number
bundle exec fastlane increment_build

# Increment version number
bundle exec fastlane increment_version
```

### Release Management

```bash
# Cut a new release branch (bumps version, creates branch and PR)
bundle exec fastlane cut_release

# Create PR to sync release branch back to main (legacy)
bundle exec fastlane create_pr_from_release_branch

# Create PR to sync release branch back to main (streamlined, supports specific commits)
bundle exec fastlane create_pr_from_release_branch_v2

# Filter merge commits from a comma-separated list
bundle exec fastlane filter_merge_commits commits:"commit1,commit2,commit3"
```

### Code Signing

```bash
# Setup code signing
bundle exec fastlane setup_signing

# Refresh provisioning profiles
bundle exec fastlane refresh_profiles
```

### Screenshots

```bash
# Take app screenshots
bundle exec fastlane screenshots
```

## GitHub Actions CI/CD

The project includes GitHub Actions workflows for automated release management:

### Release Cut Workflow (`.github/workflows/release-cut.yml`)

Triggered manually to create a new release branch:

1. Bumps the app version (minor increment)
2. Creates a new release branch (`releases/v*`)
3. Creates a PR to merge version update into the release branch

### Release Build Workflow (`.github/workflows/release-build.yml`)

Triggered automatically on pushes to `releases/*` branches:

1. **Filters merge commits**: Automatically excludes merge commits from the triggered commits
2. **Cherry-picks commits**: Creates a sync branch with only regular commits
3. **Creates PR to main**: Opens a pull request to merge changes back to main
4. Supports both push events and manual workflow dispatch

**Key Features:**
- Automatic merge commit filtering using `filter_merge_commits` lane
- Supports specific commit targeting via workflow triggers
- Clean repository handling (auto-discards auto-generated files)
- Detailed logging for troubleshooting

### Required Secrets

Add these secrets to your GitHub repository:

- `PULL_REQUEST_API_TOKEN`: GitHub token with PR creation permissions
- `FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD`: App-specific password for your Apple ID (if using TestFlight/App Store)
- `FASTLANE_SESSION`: Fastlane session for App Store Connect (if using TestFlight/App Store)
- `MATCH_PASSWORD`: Password for your Match certificates repository (if using Match)

### Required Variables

Add these repository variables:

- `X_SCHEME`: Xcode scheme name (e.g., "SampleiOSApp")
- `X_PROJ_DIR`: Xcode project path (e.g., "SampleiOSApp.xcodeproj")
- `X_WORKSPACE_DIR`: Xcode workspace path (if applicable)

## Development Workflow

### For Feature Development

1. Create a feature branch from `main`
2. Make your changes
3. Run tests locally: `bundle exec fastlane test`
4. Create a pull request to `main`
5. CI will automatically run tests

### For Releases

#### 1. Cut a New Release

Manually trigger the "Release Cut" workflow from GitHub Actions, or run locally:

```bash
bundle exec fastlane cut_release
```

This will:
- Bump the app version (minor increment)
- Create a new `releases/v*` branch
- Create a PR with the version update

#### 2. Merge Version Update PR

Review and merge the PR into the release branch. This triggers the Release Build workflow.

#### 3. Automatic Sync to Main

The Release Build workflow automatically:
- Filters out merge commits from the pushed changes
- Cherry-picks regular commits to a new sync branch
- Creates a PR to merge changes back to `main`

#### 4. Manual Sync (if needed)

If you need to manually sync specific commits:

```bash
# From the release branch
bundle exec fastlane create_pr_from_release_branch_v2
```

Or pass specific commits:

```bash
bundle exec fastlane create_pr_from_release_branch_v2 commits:"hash1,hash2,hash3"
```

### Release Branch Naming

Release branches follow the pattern: `releases/vX.Y.Z`

Example: `releases/v1.9.0`

## Application Features

The sample iOS app includes:

- **Welcome Screen**: A simple interface with welcome message
- **Interactive Button**: Demonstrates user interaction
- **Alert Dialogs**: Shows how to present alerts
- **Auto Layout**: Responsive design for different screen sizes
- **Asset Catalog**: Proper asset management
- **Info.plist**: Proper app configuration

## Testing

### Unit Tests

Located in `SampleiOSAppTests/`, these test:
- App delegate initialization
- View controller creation
- Core app functionality

### UI Tests

Located in `SampleiOSAppUITests/`, these test:
- User interface elements
- User interaction flows
- App launch performance

Run tests using:

```bash
# Via Fastlane
bundle exec fastlane test

# Via Xcode directly
xcodebuild test -workspace SampleiOSApp.xcworkspace -scheme SampleiOSApp -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Customization

### Adding New Features

1. Add Swift files to the `SampleiOSApp/` directory
2. Update the Xcode project to include new files
3. Add corresponding tests
4. Update documentation

### Modifying Build Process

Edit `fastlane/Fastfile` to:
- Add new lanes for custom workflows
- Modify existing lanes for your needs
- Add plugins for additional functionality

### Configuring Deployment

Update the deployment lanes in `fastlane/Fastfile`:
- Modify export methods
- Add custom deployment steps
- Configure distribution methods

## Troubleshooting

### Common Issues

1. **Code Signing Issues**:
   ```bash
   bundle exec fastlane match development --force
   ```

2. **Build Failures**:
   ```bash
   # Clean and rebuild
   bundle exec fastlane build --clean
   ```

3. **Test Failures**:
   ```bash
   # Run tests with verbose output
   bundle exec fastlane test --verbose
   ```

4. **Dirty Repository Error in CI**:
   
   If you see "Git repository is dirty" errors:
   - The workflow automatically discards changes to auto-generated files (`fastlane/README.md`)
   - The `FASTLANE_SKIP_DOCS=1` environment variable prevents Fastlane from auto-updating docs
   - Ensure `.bundle/` is in `.gitignore`

5. **Merge Commit Filtering Issues**:
   
   If merge commits aren't being filtered correctly:
   ```bash
   # Manually test the filter
   bundle exec fastlane filter_merge_commits commits:"hash1,hash2,hash3"
   ```
   
   The lane checks commit parent count using `git cat-file -p`. Ensure commits exist locally:
   ```bash
   git fetch --all
   ```

6. **Cherry-pick Conflicts**:
   
   If cherry-picking fails during the sync process:
   - The workflow automatically aborts failed cherry-picks
   - Review the commit that failed in the CI logs
   - You may need to manually resolve conflicts and create the PR

7. **Missing Commits in Workflow**:
   
   If the workflow doesn't detect commits to sync:
   - Ensure `fetch-depth: 0` is set in the checkout action
   - Check that commits are pushed to the release branch
   - For manual dispatch, it uses `git rev-list origin/main..HEAD`

### Getting Help

- Check [Fastlane Documentation](https://docs.fastlane.tools/)
- Review [iOS Development Best Practices](https://developer.apple.com/documentation/)
- Check project issues and discussions

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is provided as a sample/template for iOS development with Fastlane. Use it as a starting point for your own projects.

## Support

For questions about this sample project:
- Check the documentation above
- Review the code comments
- Create an issue in the repository