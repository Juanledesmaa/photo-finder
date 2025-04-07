//
//  URLRequest+Extension.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import Foundation

extension URLRequest {
	mutating func applyDefaultHeaders() {
		setValue("application/json", forHTTPHeaderField: "Content-Type")
	}
}
