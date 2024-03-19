//
//  VacancyViewModel.swift
//  hhTest
//
//  Created by Валентина Дорина on 18.03.2024.
//

import Foundation
import Combine

class VacancyViewModel: ObservableObject {
    @Published var vacancies: [Vacancy] = []
    
    
    
    func loadData() {
        
        let url = URL(string: "https://run.mocky.io/v3/ed41d10e-0c1f-4439-94fa-9702c9d95c14")!
        
        // Загрузка данных с URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP response code: \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            
            
            // Попытка декодирования JSON и обработка результатов
            do {
                let decodedData = try JSONDecoder().decode(ResponseData.self, from: data)
                self.vacancies = decodedData.vacancies
                // Используйте переменную vacancies для работы с данными о вакансиях
                //print(self.vacancies)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
        
        print(vacancies)
        
    }
    
    func favoriteCount() -> Int{
        loadData()
        let favoriteCount = self.vacancies.filter { $0.isFavorite }.count
        return favoriteCount
    }
    
    func formatCompanyAddress(address: Vacancy.Address) -> String {
        var companyAddress = ""
           
           companyAddress += address.town + ", "
           companyAddress += address.street + ", "
           companyAddress += address.house
           
           return companyAddress
    }
    
    

    
    func convertDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM"
            return "\(dateFormatter.string(from: date))"
        } else {
            return "Неверный формат даты"
        }
    }
    
    func formatVacancyCount(_ count: Int) -> String {
        let cases = [2, 0, 1, 1, 1, 2]
        let words = ["вакансия", "вакансии", "вакансий"]
        let index = (count % 100 > 4 && count % 100 < 20) ? 2 : cases[min(count % 10, 5)]
        return "\(count) \(words[index])"
    }
    
    func getVacancyDetails(byID id: String) -> Vacancy? {
        if let vacancy = vacancies.first(where: { $0.id == id }) {
            return vacancy
        } else {
            return nil
        }
    }
    
    func formatAppliedNumber(_ number: Int) -> String {
        let remainder10 = number % 10
        let remainder100 = number % 100
        
        switch remainder10 {
        case 1 where remainder100 != 11:
            return "\(number) человек уже откликнулось"
        case 2...4 where !(12...14 ~= remainder100):
            return "\(number) человека уже откликнулось"
        default:
            return "\(number) человек уже откликнулось"
        }
    }
    
    func formatLookingNumber(_ number: Int) -> String {
        switch number {
        case 1:
            return "1 человек "
        case 2...4:
            return "\(number) человека"
        default:
            return "\(number) человек"
        }
    }
    
}


