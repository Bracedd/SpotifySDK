import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Login with Spotify") {
                authenticateWithSpotify()
            }
            .padding()
        }
    }
    
    func authenticateWithSpotify() {
        // Manually encode the scope parameter to ensure URL compatibility
        let encodedScope = Constants.scope.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Construct the full authorization URL with the encoded scope
        let authURLString = "https://accounts.spotify.com/authorize?client_id=\(Constants.spotifyClientID)&response_type=code&redirect_uri=\(Constants.redirectURI)&scope=\(encodedScope)"
        
        // Print the URL string to check its format before creating the URL
        print("authURLString:", authURLString)
        
        // Create the URL and open it if valid, else log an error
        guard let url = URL(string: authURLString) else {
            print("Failed to create URL.") // Logs if URL creation fails
            return
        }
        
        // Attempt to open the URL in Safari to start the Spotify login process
        UIApplication.shared.open(url)
    }
}
