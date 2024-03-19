//
//  ContentView.swift
//  hhTest
//
//  Created by Валентина Дорина on 13.03.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vacancyViewModel: VacancyViewModel
    @StateObject var viewModel = LoginViewModel()
    @State private var isUserLoggedIn = false
    
    
    let isLogin = true
    
    @State var currentTab : Tab = .Favorites
    @State private var favoriteCount = 0
    
    var body: some View {
        
        TabView(selection: $currentTab) {
            HomeView()
                .tag(Tab.Home)
            FavoritesView()
                .tag(Tab.Favorites)
            BlankScreenView()
                .tag(Tab.Responses)
            BlankScreenView()
                .tag(Tab.SMS)
            BlankScreenView()
                .tag(Tab.Profile)
        }
        .overlay(
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) {
                    tab in TabButton(tab: tab)
                }
                
                
                
            }.background(Color.black), alignment: .bottom
        ).ignoresSafeArea(.all, edges: .bottom)
        
        
        
    }
    
    
    
    func TabButton(tab: Tab) -> some View {
        GeometryReader{proxy in
            VStack {
                Divider().frame(height: 1).background(Color.grey3)
                //.frame(width: 30, height: 2)
                //.border(currentTab == tab ? Color.blue : Color.white)
                
                Button(action: {
                    withAnimation(.spring()){
                        currentTab = tab
                    }
                }, label: {
                    VStack(spacing: 0) {
                        Image(tab.Tabname)
                            .resizable()
                        
                        //.aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.blue : Color.grey4)
                            .overlay(
                                ZStack {
                                    if vacancyViewModel.favoriteCount() > 0 && tab.Tabname == "favorites" {
                                        Circle()
                                            .foregroundColor(.red)
                                            .frame(width: 13, height: 13)
                                        Text("\(vacancyViewModel.favoriteCount())")
                                            .foregroundColor(.white)
                                            .font(.custom("", size: 8))
                                    } else {
                                        
                                            
                                        
                                        
                                    }
                                }
                                    .offset(x: 10, y: -7)
                            )
                        
                        
                    }
                })
                Text(currentTab == tab ? tab.rawValue : tab.rawValue)
                    .font(.custom("", size: 10))
                    .foregroundColor(currentTab == tab ? Color.blue : Color.grey4 )
            }.disabled(isUserLoggedIn)
                
            
        }.frame(height: 60)
    }
}

enum Tab : String, CaseIterable {
    case Home = "Поиск"
    case Favorites = "Избранное"
    case Responses = "Отклики"
    case SMS = "Сообщения"
    case Profile = "Профиль"
    
    var Tabname : String {
        switch self {
        case .Home:
            return "magnifyingglass"
        case .Favorites:
            return "favorites"
        case .Responses:
            return "email"
        case .SMS:
            return "sms"
        case .Profile:
            return "profile"
        }
        
    }
}

#Preview {
    ContentView().environmentObject(VacancyViewModel())
}
