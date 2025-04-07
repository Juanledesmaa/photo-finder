//
//  MockBundle.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import Foundation

final class MockBundle: Bundle, @unchecked Sendable {
	private let mockInfo: [String: Any]
	
	init(mockInfo: [String : Any]) {
		self.mockInfo = mockInfo
		super.init()
	}
	
	override func object(forInfoDictionaryKey key: String) -> Any? {
		return mockInfo[key]
	}
}
