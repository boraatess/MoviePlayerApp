//
//  GenresResponse.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import Foundation

// MARK: - GenresResponse
struct GenresResponse: Codable {
    var genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}
