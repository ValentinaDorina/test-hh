//
//  HomeView.swift
//  hhTest
//
//  Created by Валентина Дорина on 13.03.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vacancyViewModel: VacancyViewModel
    @State private var sheetJob = false
    @State private var sheetJobStates: [String: Bool] = [:]
    
    
    
    let isFilter = false
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .leading) {
                
                Spacer().frame(height: 40)
                
                HStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Image("magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                        
                        Text("Должность, ключевые слова")
                        
                        Spacer()
                    }.padding().frame(height: 40).frame(maxWidth: .infinity).background(Color.grey2).cornerRadius(8)
                        .foregroundColor(.grey4)
                        .fontWeight(.regular)
                        .font(.system(size: 14))
                    
                    Button {
                        
                    } label: {
                        Image("filter")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }.frame(width: 40, height: 40)
                        .background(Color.grey2)
                        .cornerRadius(10)
                    
                    
                }.padding(.bottom)
                
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        CardQuickFilterView(imageName: "jobNear", titleFilter: "Вакансии рядом с вами")
                        
                        CardQuickFilterView( imageName: "greenStar", titleFilter: "Поднять резюме в поиске", isLift: true)
                        CardQuickFilterView(imageName: "greenFilter", titleFilter: "Временная работа и подработка")
                    }
                }
                
                Text("Вакансии для вас")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                ScrollView{
                    VStack(spacing: 16){
                        ForEach(
                            vacancyViewModel.vacancies.prefix(3), id: \.id) { vacancy in
                                VStack {
                                    NavigationLink {
                                        SheetJobView(id: vacancy.id)
                                        //sheetJobStates[vacancy.id] = true
                                       // sheetJob = true
                                    } label: {
                                        CardJobView(jobName: vacancy.title, city: vacancy.address.town, company: vacancy.company, experience: vacancy.experience.previewText, publishedDate: vacancy.publishedDate, salary: vacancy.salary?.short ?? "", lookingNumber: vacancy.lookingNumber ?? 0, isFavorite: vacancy.isFavorite)
                                    }//.fullScreenCover(isPresented: Binding(
                                      //  get: { sheetJobStates[vacancy.id] ?? false },
                                      //  set: { newValue in sheetJobStates[vacancy.id] = newValue }
                                    //)) {
                                    //    SheetJobView(id: vacancy.id)
                                    //}
                                    
                                    
                                }
                            }
                    }
                    
                }
                
                
                Button{
                    
                } label: {
                    Text("Еще \(vacancyViewModel.formatVacancyCount(vacancyViewModel.vacancies.count))")
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.bottom, 64)
                
                
                
                
                
            }.onAppear {
                vacancyViewModel.loadData()
            }
            .padding().frame(maxHeight: .infinity).ignoresSafeArea().background(Color.black)
            
        }
    }
}

#Preview {
    HomeView().environmentObject(VacancyViewModel())
}
