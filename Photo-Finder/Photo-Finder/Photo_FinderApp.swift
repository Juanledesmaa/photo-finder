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
			
			let networkClient = NetworkClient()
			let appConfiguration = APIConfiguration()
			let ApiConfiguration = PhotoListAPIConfiguration(
				configuration: appConfiguration
			)
			
			let remoteDataSource = RemotePhotoListDataSource(
				networkClient: networkClient,
				apiConfiguration: ApiConfiguration
			)

			let viewModel = PhotoListViewModel(
				photoListDataSource: remoteDataSource
			)

			PhotoListView(viewModel: viewModel)
        }
    }
}
