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
    let articleURL: URL
    var availableBlocks: [String] // Changed from [CodeBlock] to [String]
    let correctSolution: [String] // Changed from [CodeBlock] to [String]
}
