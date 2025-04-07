//
//  PhotoListViewModel.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import SwiftUI
import Combine

@MainActor
final class PhotoListViewModel: ObservableObject {
	struct PhotoListViewData {
		let navigationTitle = "Photo Finder"
		let textFieldPlaceholder = "Search photos..."
		let progressViewText = "Loading photos..."
		let bottomProgressViewText = "Loading photos..."
		let errorImageSize = CGSize(width: 100, height: 100)
		let errorImageName = "alert"
		let errorTitle = "An error occurred while fetching more photos"
		let errorSubtitle = "Please try again later."
		let emptyImageName = "sad"
		let emptyPhotosTitle = "No photos could be found."
	}
	
	let viewData = PhotoListViewData()
	@Published var state: ViewModelState = .loading
	@Published var searchQuery: String = ""
	
	var shownPhotos: [Photo] = []
	var isLoadingMoreResults: Bool = false
	private let photoListDataSource: PhotoListDataSourceProtocol
	private var photoPage: PhotoPage = PhotoPage.empty {
		didSet {
			state = photoPage.photo.isEmpty ? .empty : .success
			isLoadingMoreResults = false
			appendUniquePhotos(photoPage.photo)
		}
	}
	private var cancellables = Set<AnyCancellable>()

	init(photoListDataSource: PhotoListDataSourceProtocol) {
		self.photoListDataSource = photoListDataSource
		setUpBindings()
	}

	func fetchPhotoList(page: Int = 1) async {
		if page > 1 {
			isLoadingMoreResults = true
		} else {
			shownPhotos.removeAll()
			state = .loading
		}

		do {
			let result = try await photoListDataSource.fetchPhotos(
				for: searchQuery,
				page: page
			)
			photoPage = result.photos
		} catch {
			state = .error(error)
		}
	}
	
	func fetchNextPageIfNeeded() async {
		guard state != .loading,
			  !isLoadingMoreResults,
			  photoPage.page < photoPage.pages else { return }

		await fetchPhotoList(page: photoPage.page + 1)
	}
	
	func shouldLoadMore(current: Photo) -> Bool {
		guard let index = shownPhotos.firstIndex(
			of: current
		) else { return false }
		let thresholdIndex = shownPhotos.index(
			shownPhotos.endIndex,
			offsetBy: -9,
			limitedBy: shownPhotos.startIndex
		) ?? 0
		return index >= thresholdIndex
	}
	
	private func setUpBindings() {
		$searchQuery
			.removeDuplicates()
			.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
			.sink { [weak self] query in
				guard let self = self, query.count >= 1 else { return }
				Task {
					await self.fetchPhotoList()
				}
			}
			.store(in: &cancellables)
	}
	
	private func appendUniquePhotos(_ newPhotos: [Photo]) {
		let uniquePhotos = newPhotos.filter { newPhoto in
			!shownPhotos.contains(where: { $0.id == newPhoto.id })
		}
		shownPhotos += uniquePhotos
	 }
}
