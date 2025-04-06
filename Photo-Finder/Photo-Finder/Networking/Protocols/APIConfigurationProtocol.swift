//
//  ConfigurationProtocol.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

protocol APIConfigurationProtocol {
	var baseUrl: String { get }
	var apiKey: String { get }
	var format: String { get }
}
