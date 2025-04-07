//
//  PhotoCardView.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import SwiftUI

struct PhotoCardView: View {
	let photo: Photo

	var body: some View {
		ZStack {
			if let url = photo.imageURL {
				CachedAsyncImageView(url: url, placeholderImage: .imagePlaceholder)
					.opacity(0.7)
					.scaledToFill()
					.clipped()
			} else {
				Color.gray
			}

			VStack {
				Text(photo.title)
					.foregroundStyle(.white)
					.font(.system(size: 12, weight: .bold))
					.lineLimit(3)
					.truncationMode(.tail)
			}
			.padding()
		}
		.aspectRatio(1, contentMode: .fit)
		.frame(maxWidth: .infinity)
		.background(Color.black)
		.cornerRadius(30)
		.shadow(radius: 4)
	}
}

