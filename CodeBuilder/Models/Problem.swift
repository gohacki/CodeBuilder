//
//  Problem.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/17/24.
//

import Foundation

struct Problem: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let difficulty: String
    let articleTitle: String
    var availableBlocks: [String]
    let correctSolution: [String]
}
