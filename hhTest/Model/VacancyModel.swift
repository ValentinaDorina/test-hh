//
//  VacanciesModel.swift
//  hhTest
//
//  Created by Валентина Дорина on 18.03.2024.
//

import Foundation

struct Vacancy : Codable, Identifiable {
    let id: String
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    let isFavorite: Bool
    let salary: Salary?
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
    
    struct Address : Codable {
        let town: String
        let street: String
        let house: String
    }

    struct Experience : Codable {
        let previewText: String
        let text: String
    }

    struct Salary : Codable {
        let short : String?
        let full: String
    }

  
}



struct ResponseData: Codable {
    let vacancies: [Vacancy]
}



