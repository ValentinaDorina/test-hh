//
//  OTPView.swift
//  hhTest
//
//  Created by Валентина Дорина on 14.03.2024.
//

import SwiftUI

struct OTPView: View {
    
    @State private var enterValue : [String] = Array(repeating: "", count: 4)
    @FocusState private var fieldFocus: Int?
    @ObservedObject var viewModel: LoginViewModel
    @Binding var isUserLoggedIn: Bool

    
    @State  var user: User
    
    @State private var next = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 16) {
                Text("Отправили код на \(user.email)")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                
                Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
                    .fontWeight(.medium)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                HStack{
                    
                    ForEach(0..<4, id: \.self) {
                        index in
                        
                        OTPModifierView(pin: $enterValue[index])
                            .focused($fieldFocus, equals: index)
                            .tag(index)
                            .onTapGesture {
                                       fieldFocus = 0
                                   }
                            .onChange(of: enterValue[index]){
                                newValue, _ in
                                
                                
                                
                                if index == enterValue.count - 1 {
                                    fieldFocus = nil
                                } else {
                                    fieldFocus = (fieldFocus ?? 0) + 1
                                }
                                
                                
                            }
                    }
                    
                }.fontWeight(.medium)
                    .font(.system(size: 24))
                    .foregroundColor(.grey4)
                Button {
                    if enterValue.allSatisfy({ !$0.isEmpty}) {
                        next = true
                        self.viewModel.login()
                        isUserLoggedIn = true
                        
                    }
                    
                } label: {
                    Text("Подтвердить")
                        .foregroundColor(enterValue.allSatisfy({ !$0.isEmpty}) ? .white : .grey4)
                        .fontWeight(.semibold)
                            .font(.system(size: 16))
                }.frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(enterValue.allSatisfy({ !$0.isEmpty}) ? Color.blue : Color.darkBlue )
                    .cornerRadius(8)
                    .ignoresSafeArea()
                    .fullScreenCover(isPresented: $next, content: {
                        ContentView().environmentObject(VacancyViewModel())
                    })
                    .disabled(enterValue.allSatisfy({ $0.isEmpty}))
                
            }.ignoresSafeArea().frame(maxWidth: .infinity, maxHeight: .infinity).padding().background(Color.black)
                
        }
    }
}

#Preview {
    OTPView(viewModel: LoginViewModel(), isUserLoggedIn: .constant(false), user: User(email: "dori"))
}
