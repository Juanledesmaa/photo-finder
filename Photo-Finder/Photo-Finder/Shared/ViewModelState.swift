//
//  ViewModelState.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

enum ViewModelState: Equatable {
	case loading
	case error(Error)
	case empty
	case success
	
	static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
		switch (lhs, rhs) {
			case (.loading, .loading),
				(.empty, .empty),
				(.success, .success):
				return true
			case let (.error(lhsError), .error(rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			default:
				return false
		}
	}
}
