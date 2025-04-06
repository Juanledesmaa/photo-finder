//
//  URLSessionProtocol.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

protocol URLSessionProtocol {
	func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// Default conformance to URLSession so we are able to pass a shared session or
// use default URLSession when needed.
extension URLSession: URLSessionProtocol {}
