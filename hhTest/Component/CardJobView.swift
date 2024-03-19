//
//  CardJobView.swift
//  hhTest
//
//  Created by Валентина Дорина on 14.03.2024.
//

import SwiftUI

struct CardJobView: View {
    let jobName : String
    let city : String
    let company : String
    let experience : String
    let publishedDate : String
    let salary : String
    let lookingNumber : Int
    var isFavorite : Bool
    
    @EnvironmentObject var viewModel : VacancyViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10){
                   
                    if lookingNumber > 0 {
                        Text("Сейчас просматривает \(viewModel.formatLookingNumber(lookingNumber))")
                            .foregroundColor(.green)
                    }
                    
                    Text(jobName)
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                    
                    if !salary.isEmpty {
                        Text(salary)
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                    }
                  
                    VStack(alignment: .leading, spacing: 4){
                        
                        Text(city)
                        HStack{
                            Text(company)
                            Image("checkMark")
                        }
                    }
                    
                    
                    HStack{
                        Image("experience")
                        Text(experience)
                    }
                    
                    Text("Опубликовано " + viewModel.convertDate(dateString: publishedDate))
                                .foregroundColor(.gray)
                        .foregroundColor(.grey3)
                }.padding(.bottom, 21)
                Spacer()
                Button{
                    //isFavorite.toggle()
                } label: {
                    Image(isFavorite ? "favorites.fill" : "favorites")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
            }
            
            
            
            
            Button{
                
            } label: {
                Text("Откликнуться")
                    .foregroundColor(.white)
            }.frame(maxWidth: .infinity)
                .frame(height: 32)
                .background(Color.green)
                .cornerRadius(50)
            
            
            
            
        }.padding(.all, 16)
        .foregroundColor(.white).background(Color.grey1).cornerRadius(8)
            .fontWeight(.regular)
            .font(.system(size: 14))
    }
}

#Preview {
    CardJobView(jobName: "UI/UX Designer", city: "Минск", company: "Мобирикс", experience: "Опыт от 1 года до 3 лет", publishedDate: "2024-03-20", salary: "2000", lookingNumber: 3, isFavorite: true).environmentObject(VacancyViewModel())
}
