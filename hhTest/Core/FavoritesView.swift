//
//  FavoritesView.swift
//  hhTest
//
//  Created by Валентина Дорина on 13.03.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vacancyViewModel: VacancyViewModel
    //@StateObject var viewModel = LoginViewModel()
        @State private var isUserLoggedIn = false
    
    
    @State var email = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                if !isUserLoggedIn {
                    LoginView(isUserLoggedIn: $isUserLoggedIn)
                } else {
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Избранное")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.bottom, 14)
                        
                       
                        Text(vacancyViewModel.formatVacancyCount(vacancyViewModel.favoriteCount()))
                            .foregroundColor(.grey3)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        Text("hbu")
                        VStack{
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(vacancyViewModel.vacancies.filter { $0.isFavorite }, id: \.id) { vacancy in
                                        VStack {
                                            NavigationLink(destination: SheetJobView(id: vacancy.id)) {
                                                CardJobView(jobName: vacancy.title, city: vacancy.address.town, company: vacancy.company, experience: vacancy.experience.previewText, publishedDate: vacancy.publishedDate, salary: vacancy.salary?.short ?? "", lookingNumber: vacancy.lookingNumber ?? 0, isFavorite: vacancy.isFavorite)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
            }.onAppear {
                vacancyViewModel.loadData()
            }
            .ignoresSafeArea()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
            
        }
        
        
        
    }
}

#Preview {
    FavoritesView().environmentObject(VacancyViewModel())
}
