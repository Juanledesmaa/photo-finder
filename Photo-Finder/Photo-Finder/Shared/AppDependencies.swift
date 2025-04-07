//
//  AppDependencies.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

@MainActor
final class AppDependencies {

	private init() {}

	lazy var networkClient: NetworkClientProtocol = NetworkClient()
	lazy var apiConfiguration: APIConfigurationProtocol = APIConfiguration()
	lazy var photoAPIConfiguration = PhotoListAPIConfiguration(configuration: apiConfiguration)
	
	lazy var photoListDataSource: PhotoListDataSourceProtocol = RemotePhotoListDataSource(
		networkClient: networkClient,
		apiConfiguration: photoAPIConfiguration
	)

	@MainActor func makePhotoListViewModel() -> PhotoListViewModel {
		PhotoListViewModel(photoListDataSource: photoListDataSource)
	}
	
	static func resolve() -> AppDependencies {
		AppDependencies()
	}
}
