//
//  CachedAsyncImageView.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import SwiftUI

struct CachedAsyncImageView: View {
	let url: URL
	let placeholderImage: UIImage?
	@StateObject var imageLoader: ImageLoader
	
	init(url: URL, placeholderImage: UIImage? = nil) {
		self.url = url
		self.placeholderImage = placeholderImage
		_imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
	}
	
	var body: some View {
		Group {
			switch imageLoader.phase {
				case .empty, .failure(_):
					Color.white
					if let placeholderImage = placeholderImage {
						Image(uiImage: placeholderImage)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.padding()
					}
				case .success(let image):
					image
						.resizable()
						.frame(maxWidth: .infinity)
						.frame(height: 120)
						.aspectRatio(1, contentMode: .fit)
				@unknown default:
					Color.white
					if let placeholderImage = placeholderImage {
						Image(uiImage: placeholderImage)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.padding()
					}
			}
		}
		.onAppear {
			Task {
				await imageLoader.load()
			}
		}
	}
}
