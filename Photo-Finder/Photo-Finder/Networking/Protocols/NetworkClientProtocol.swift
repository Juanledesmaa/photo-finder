//
//  NetworkClientProtocol.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

protocol NetworkClientProtocol {
	func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T
}
