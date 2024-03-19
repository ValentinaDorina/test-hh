//
//  SheetJobView.swift
//  hhTest
//
//  Created by Валентина Дорина on 15.03.2024.
//

import SwiftUI

struct SheetJobView: View {
    @State private var isRespond = false
    @State private var coveringLetter = ""
    @State private var addCV = false
    @EnvironmentObject private var viewModel : VacancyViewModel
    
    let id: String
    
    
    var body: some View {
        VStack{
            
            
            ScrollView{
                VStack(alignment: .leading){
                    if let vacancy = viewModel.getVacancyDetails(byID: id) {
                        
                        VStack(alignment: .leading, spacing: 16){
                            Text(vacancy.title)
                                .fontWeight(.semibold)
                                .font(.system(size: 22))
                            
                            Text(vacancy.salary?.full ?? "")
                            
                            VStack(alignment: .leading, spacing: 6){
                                Text("Требуемый опыт: " + vacancy.experience.text)
                                
                                var schedulesString: String {
                                    guard let firstSchedule = vacancy.schedules.first else { return "" }
                                    let firstWordCapitalized = firstSchedule.prefix(1).capitalized + firstSchedule.dropFirst()
                                    return vacancy.schedules.dropFirst().reduce(firstWordCapitalized) { result, schedule in
                                        return result + ", " + schedule.lowercased()
                                    }
                                }
                                
                                Text(schedulesString)
                                
                                
                            }
                            
                        }.padding(.bottom, 29)
                        
                        HStack(alignment: .center){
                            if vacancy.appliedNumber ?? 0 > 0 {
                                HStack(alignment: .top){
                                    Spacer()
                                    
                                    Text(viewModel.formatAppliedNumber(vacancy.appliedNumber ?? 0))
                                    Spacer()
                                    Image("responded")
                                    Spacer()
                                }.padding(.vertical, 8).frame(maxWidth: .infinity).background(Color.darkGreen).cornerRadius(8)
                                Spacer()
                            }
                            
                            
                            
                            if vacancy.lookingNumber ?? 0 > 0 {
                                HStack(alignment: .top){
                                    Spacer()
                                    Text("\(viewModel.formatLookingNumber(vacancy.lookingNumber ?? 0)) сейчас смотрят")
                                    Spacer()
                                    Image("watching")
                                    Spacer()
                                }.padding(.vertical, 8).frame(maxWidth: .infinity).background(Color.darkGreen).cornerRadius(8)
                            }
                            
                            
                            
                            
                            
                        }.frame(minHeight: 50).frame(maxWidth: .infinity)
                            .padding(.bottom, 19)
                        
                        VStack(alignment: .leading){
                            HStack(alignment: .center){
                                Text(vacancy.company)
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                Image("checkMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 16, height: 16)
                            }
                            
                            Image("map 1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                            
                            
                            Text(viewModel.formatCompanyAddress(address: vacancy.address))
                        }.frame(maxWidth: .infinity, alignment: .leading).padding().background(Color.grey1).cornerRadius(8)
                            .padding(.bottom, 16)
                        
                        if ((vacancy.description?.isEmpty) != nil) {
                            Text(vacancy.description ?? "")
                                .padding(.bottom, 16)
                        }
                        
                        
                        Text("Ваши задачи")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        
                        
                        Text(vacancy.responsibilities)
                            .padding(.bottom, 32)
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Задайте вопрос работодателю")
                            
                            Text("Он получит его с откликом на вакансию")
                                .foregroundColor(.grey3)
                            
                        }.fontWeight(.medium)
                            .padding(.bottom, 16)
                        
                        VStack(alignment: .leading, spacing: 8){
                            ForEach(vacancy.questions, id: \.self){
                                question in
                                SmallButtonView(buttonName: question)
                            }
                        }.padding(.bottom, 16)
                        
                        
                        
                        Button{
                            isRespond = true
                        } label: {
                            Text("Откликнуться")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color.green)
                                .cornerRadius(8)
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                            
                        }.sheet(isPresented: $isRespond) {
                            VStack(alignment: .leading){
                                HStack(alignment: .center){
                                    Image("Image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 48, height: 48)
                                        .padding(.trailing, 16)
                                    
                                    VStack(alignment: .leading, spacing: 8){
                                        Text("Резюме для отклика")
                                            .fontWeight(.regular)
                                            .font(.system(size: 14))
                                        
                                        Text("UI/UX дизайнер ").fontWeight(.medium)
                                            .font(.system(size: 16))
                                        
                                    }
                                    Spacer()
                                    
                                    
                                }.padding(.vertical)
                                Divider().frame(height: 2).background(Color.grey2)
                                
                                
                                VStack{
                                    
                                    if addCV {
                                        Text(coveringLetter.isEmpty ? "Ваше сопроводительное письмо" : coveringLetter)
                                            .foregroundColor(.grey3)
                                            .overlay(
                                                TextField("Ваше сопроводительное письмо", text: $coveringLetter)
                                                    .foregroundColor(.white)
                                                    .multilineTextAlignment(.leading)
                                                
                                                
                                                
                                            )
                                        
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .frame(height: 85, alignment: .top)
                                        
                                    } else {
                                        
                                        Button{
                                            addCV = true
                                        } label: {
                                            Text("Добавить сопроводительное")
                                        }.frame(height: 48)
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(.green)
                                            .cornerRadius(8)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 16))
                                    }
                                    
                                    
                                    Button{
                                        
                                    } label: {
                                        Text("Откликнуться")
                                    }.frame(maxWidth: .infinity)
                                        .frame(height: 48)
                                        .background(Color.green)
                                        .cornerRadius(8)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 16))
                                }.padding(.vertical)
                                
                                
                                
                            }.presentationDetents([.height(250)])
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color.black)
                        }
                        
                    } else {
                        Text("Вакансия не найдена")
                    }
                    
                    
                    
                    
                }
            }
            
        } .fontWeight(.regular)
            .font(.system(size: 14)).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity)
            .padding()
            .background(.black)
            .navigationBarBackButtonHidden(true)
        
            .navigationBarItems(leading:
                                    BackButton(),
                                trailing:
                                    HStack{
                Image("eye")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                Image("share")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 28, height: 28)
                let vacancy = viewModel.getVacancyDetails(byID: id)
                Image(vacancy?.isFavorite ?? false ? "favorites.fill" : "favorites")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
            })
                                
                        
        
        
        
        
    }
}

#Preview {
    SheetJobView(id: "lpl").environmentObject(VacancyViewModel())
}
