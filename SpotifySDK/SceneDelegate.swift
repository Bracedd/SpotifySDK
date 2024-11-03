import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // Handle incoming URLs (for OAuth callback)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleIncomingURL(url)
    }

    private func handleIncomingURL(_ url: URL) {
        if url.scheme == "xcode" { // Make sure this matches your URL scheme
            if let code = url.queryParameters?["code"] {
                print("Authorization code: \(code)")
                requestAccessToken(with: code)
            }
        }
    }

    private func requestAccessToken(with code: String) {
        let tokenURL = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        let body = "grant_type=authorization_code&code=\(code)&redirect_uri=\(Constants.redirectURI)&client_id=\(Constants.spotifyClientID)&client_secret=\(Constants.spotifyClientSecret)"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let accessToken = json["access_token"] as? String {
                    print("Access Token: \(accessToken)")
                    // Use this access token to call Spotify API endpoints
                }
            }
        }.resume()
    }
}
