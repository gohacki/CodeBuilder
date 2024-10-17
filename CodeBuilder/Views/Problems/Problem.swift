//
//  Problem.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/17/24.
//

import Foundation

struct Problem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let difficulty: String
    let articleURL: URL
    let availableBlocks: [String]
    let correctSolution: [String]
}
