//
//  PhotoListView.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import SwiftUI

struct PhotoListView: View {
	
	@StateObject private var viewModel: PhotoListViewModel
	
	let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
	
	init(viewModel: PhotoListViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	var body: some View {
		NavigationView {
			content
				.navigationTitle(viewModel.viewData.navigationTitle)
				.background(Color.appColor.primaryBackground)
		}
		.task {
			await viewModel.fetchPhotoList()
		}
	}
	
	@ViewBuilder
	private var content: some View {
		VStack {
			HStack {
				RoundedTextFieldView(
					placeholder: viewModel.viewData.textFieldPlaceholder,
					text: $viewModel.searchQuery
				)
				.onSubmit {
					Task { await viewModel.fetchPhotoList() }
				}
			}
			
			Spacer()
			
			switch viewModel.state {
				case .loading:
					ProgressView(viewModel.viewData.progressViewText)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
				case .error:
					errorStateView
				case .empty:
					emptyStateView
				case .success:
					if viewModel.shownPhotos.isEmpty {
						emptyStateView
					} else {
						photoListScrollView
					}
			}
		}
	}
	
	private var emptyStateView: some View {
		CenteredVerticalScrollView {
			PlaceholderView(
				imageName: viewModel.viewData.emptyImageName,
				title: viewModel.viewData.emptyPhotosTitle
			)
		} onRefresh: {
			try? await Task.sleep(nanoseconds: 300_000_000)
			await viewModel.fetchPhotoList()
		}
		.scrollDismissesKeyboard(.interactively)
	}
	
	private var errorStateView: some View {
		CenteredVerticalScrollView {
			PlaceholderView(
				imageName: viewModel.viewData.errorImageName,
				title: viewModel.viewData.errorTitle,
				subtitle: viewModel.viewData.errorSubtitle,
				imageSize: viewModel.viewData.errorImageSize
			)
		} onRefresh: {
			try? await Task.sleep(nanoseconds: 300_000_000)
			await viewModel.fetchPhotoList()
		}
		.scrollDismissesKeyboard(.interactively)
	}
	
	private var photoListScrollView: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 8) {
				ForEach(
					viewModel.shownPhotos,
					id: \.id
				) { photo in
					PhotoCardView(photo: photo)
						.onAppear {
							if viewModel.shouldLoadMore(current: photo) {
								Task { await viewModel.fetchNextPageIfNeeded() }
							}
						}
					
				}
			}
			.padding()
			.animation(
				.easeInOut,
				value: viewModel.shownPhotos
			)
			ProgressView(viewModel.viewData.bottomProgressViewText)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.scrollDismissesKeyboard(.interactively)
		.refreshable {
			try? await Task.sleep(nanoseconds: 300_000_000)
			await viewModel.fetchPhotoList()
		}
	}
}
