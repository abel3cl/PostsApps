# PostsApps

When downloading: 

 ```
 git clone --depth=50  https://github.com/abel3cl/PostsApps.git abel3cl/PostsApps
 git submodule update --init --recursive
 ```

# Targets

PostAppsClient - Debug: Main App running in Debug config (Allows insecure HTTP connections)
PostAppsClient - Debug: Main App running in Release config 

PostFeatureApp: Feature of a main app, can also run as a separate app. Contains Unit and UI Tests
PostFeature: Framework with sources of PostFeatureApp. Only contains Unit Tests

Adapter: Handles the networking with a speficif endpoint
Core: Contains Models and Utils for other frameworks
Networking: Handles HTTP request/response

Swifter: External dependency for UITests Stubbing