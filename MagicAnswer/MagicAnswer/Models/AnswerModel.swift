//
//  AnswerModel.swift
//  MagicAnswer
//
//  Created by Iryna Kopchynska on 29.09.2021.
//  Copyright © 2021 Iryna Kopchynska. All rights reserved.
//

import Foundation

struct Answer: Codable {
    var answer: String?
    var question: String?
    var type: String?
}

struct Magic: Codable {
    var magic: Answer
}
