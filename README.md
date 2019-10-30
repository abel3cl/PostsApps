# PostsApps

When downloading: 

 ```
 git clone https://github.com/abel3cl/PostsApps.git
 git submodule update --init --recursive
 ```

 ## Build Status

[![codecov](https://codecov.io/gh/abel3cl/PostsApps/branch/develop/graph/badge.svg)](https://codecov.io/gh/abel3cl/PostsApps)

| Branch | Status | ---------------- |
| ------------- | ---------------- | |
| Master | [![Build Status](https://travis-ci.org/abel3cl/PostsApps.svg?branch=master)](https://travis-ci.org/abel3cl/PostsApps) |
| Develop | [![Build Status](https://travis-ci.org/abel3cl/PostsApps.svg?branch=develop)](https://travis-ci.org/abel3cl/PostsApps) | [![Build Status](https://app.bitrise.io/app/9198ab2bb81efa71/status.svg?token=DAGHGK9NczZBTuKD4yFc4g&branch=develop)](https://app.bitrise.io/app/9198ab2bb81efa71) |

# Targets

PostAppsClient - Debug: Main App running in Debug config (Allows insecure HTTP connections)
PostAppsClient - Debug: Main App running in Release config 

PostFeatureApp: Feature of a main app, can also run as a separate app. Contains Unit and UI Tests
PostFeature: Framework with sources of PostFeatureApp. Only contains Unit Tests

Adapter: Handles the networking with a speficif endpoint
Core: Contains Models and Utils for other frameworks
Networking: Handles HTTP request/response

Swifter: External dependency for UITests Stubbing
