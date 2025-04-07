//
//  PhotoListViewModelTests.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import XCTest
@testable import Photo_Finder

final class PhotoListViewModelTests: XCTestCase {

	@MainActor
	func test_initialState_isLoading() {
		let viewModel = PhotoListViewModel(photoListDataSource: MockPhotoListDataSource())
		XCTAssertEqual(viewModel.state, .loading)
		XCTAssertTrue(viewModel.shownPhotos.isEmpty)
	}

	@MainActor
	func test_fetchPhotoList_success_setsPhotosAndState() async {
		let mock = MockPhotoListDataSource()
		mock.mockResponse = .mock
		let viewModel = PhotoListViewModel(photoListDataSource: mock)

		await viewModel.fetchPhotoList()

		XCTAssertEqual(viewModel.state, .success)
		XCTAssertEqual(viewModel.shownPhotos.count, 1)
	}

	@MainActor
	func test_fetchPhotoList_failure_setsErrorState() async {
		let mock = MockPhotoListDataSource()
		mock.shouldThrow = true
		let viewModel = PhotoListViewModel(photoListDataSource: mock)

		await viewModel.fetchPhotoList()

		if case .error = viewModel.state {
			XCTAssertTrue(true)
		} else {
			XCTFail("Expected state to be .error")
		}
	}

	@MainActor
	func test_shouldLoadMore_returnsTrueNearEnd() {
		let mock = MockPhotoListDataSource()
		let viewModel = PhotoListViewModel(photoListDataSource: mock)
		viewModel.shownPhotos = (1...20).map {
			Photo(
				id: "\($0)",
				owner: "owner",
				secret: "secret",
				server: "server",
				farm: 1,
				title: "Mock",
				ispublic: 1,
				isfriend: 0,
				isfamily: 0
			)
		}
		let last = viewModel.shownPhotos.last!
		let result = viewModel.shouldLoadMore(current: last)
		XCTAssertTrue(result)
	}

	@MainActor
	func test_shouldLoadMore_returnsFalseIfFarFromEnd() {
		let mock = MockPhotoListDataSource()
		let viewModel = PhotoListViewModel(photoListDataSource: mock)
		viewModel.shownPhotos = Array(repeating: PhotosSearchResponse.mock.photos.photo.first!, count: 20)
		let early = viewModel.shownPhotos[0]

		let result = viewModel.shouldLoadMore(current: early)

		XCTAssertFalse(result)
	}
	
	@MainActor
	func test_fetchNextPageIfNeeded_fetchesNextPage() async {
		let mock = MockPhotoListDataSource()
		mock.mockResponse = PhotosSearchResponse(
			photos: PhotoPage(
				page: 2,
				pages: 5,
				perpage: 10,
				total: 50,
				photo: [
					Photo(
						id: "2",
						owner: "owner",
						secret: "secret",
						server: "server",
						farm: 1,
						title: "Photo 2",
						ispublic: 1,
						isfriend: 0,
						isfamily: 0
					)
				]
			),
			stat: .ok
		)

		let viewModel = PhotoListViewModel(photoListDataSource: mock)
		await viewModel.fetchPhotoList()
		viewModel.shownPhotos = [
			Photo(
				id: "1",
				owner: "",
				secret: "",
				server: "",
				farm: 1,
				title: "",
				ispublic: 1,
				isfriend: 0,
				isfamily: 0
			)
		]
		viewModel.state = .success
		await viewModel.fetchNextPageIfNeeded()

		XCTAssertEqual(mock.lastPage, 3)
	}

}
