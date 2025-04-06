//
//  Photo_FinderApp.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import SwiftUI

@main
struct Photo_FinderApp: App {
    var body: some Scene {
        WindowGroup {
			
			let networkClient = NetworkClient(
				session: URLSession(
					configuration: .ephemeral
				)
			)
			let appConfiguration = APIConfiguration()
			let recipesListAPIConfiguration = PhotoListAPIConfiguration(
				configuration: appConfiguration
			)
			
			let remoteDataSource = RemotePhotoListDataSource(
				networkClient: networkClient,
				apiConfiguration: recipesListAPIConfiguration
			)
			
            ContentView()
			Text("Fetching photos…")
				.task {
					do {
						let photos = try await remoteDataSource.fetchPhotos()
						print("✅ Fetched photos:", photos)
					} catch {
						print("❌ Fetch failed:", error)
					}
				}
        }
    }
}
