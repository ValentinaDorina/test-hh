//
//  LoginView.swift
//  hhTest
//
//  Created by Валентина Дорина on 13.03.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var user = User(email: "")
    @State private var clearEmail = false
    @State private var notComplete = false
    @State private var complete = false
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Вход в личный кабинет")
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            VStack(spacing: 16){
                VStack(alignment: .leading, spacing: 16) {
                    Text("Поиск работы")
                    
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        
                        
                        HStack {
                            if user.email.isEmpty {
                                Image("email")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.grey4)
                                
                                Text(user
                                    .email.isEmpty ? "Электронная почта или телефон" : user.email)
                                    .foregroundColor(.grey4)
                                    .fontWeight(.regular)
                                    .font(.system(size: 14))
                                Spacer()
                            }
                            
                            
                            
                            
                        }.frame(height: 40).frame(maxWidth: .infinity)
                        
                            .overlay(
                                HStack {
                                    TextField("", text: $user
                                        .email)
                                    .onChange(of: user.email) {
                                            newValue, _ in
                                            notComplete = false
                                        }
                                        .foregroundColor(.white)
                                        .autocapitalization(.none)
                                        .multilineTextAlignment(.leading)
                                        .fontWeight(.regular)
                                    
                                    if !user.email.isEmpty {
                                        Button(action: {
                                            self.user.email = ""
                                        }) {
                                            Image("close")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                
                                
                            )
                            .padding(.horizontal)
                            .background(Color.grey2)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(!notComplete || user.email.isEmpty ? Color.clear : Color.red, lineWidth: 2))
                        
                            .cornerRadius(8.0)
                            .shadow(color: .black, radius: 3, x: 0, y: 3)
                        
                        if notComplete {
                            Text("Вы ввели неверный e-mai")
                                .foregroundColor( .red)
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                    
                    
                    HStack(alignment: .center) {
                        
                        
                        Button {
                            if user.email.isValidEmail() {
                                complete = true
                                
                            } else {
                                print("not")
                                notComplete = true
                                
                            }
                        }label: {
                            Text("Продолжить")
                                .foregroundColor(user.email.isEmpty ? .grey4 : .white)
                        }.disabled(user.email.isEmpty)
                        
                        
                        
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                            .background(user.email.isEmpty ? Color.darkBlue : Color.blue )
                            .cornerRadius(8.0)
                            .fullScreenCover(isPresented: $complete) {
                                OTPView(viewModel: LoginViewModel(), isUserLoggedIn: $isUserLoggedIn, user: User(email: user.email))
                            }
                        
                        
                        
                        
                        Button {
                            
                        }label: {
                            Text("Войти с паролем")
                                .foregroundColor(.blue)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }.frame(height: 40).fontWeight(.regular)
                        .font(.system(size: 14))
                    
                    
                    
                }.padding()
                
            }.background(Color.grey1).cornerRadius(8)
            
            VStack{
                VStack(alignment: .leading, spacing: 8) {
                    Text("Поиск сотрудников")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                        
                    Text("Размещение вакансий и доступ к базе резюме")
                        .foregroundColor(.white)
                    
                    Button {
                        
                    }label: {
                        Text("Я ищу сотрудников")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .background(Color.green)
                    .cornerRadius(50.0)
                    .padding(.vertical)
                    
                    
            
                    
                    
                    
                    
                    
                    
                    
                }.padding()
                
                
            }.background(Color.grey1).cornerRadius(8).fontWeight(.regular)
                .font(.system(size: 14))
            
            Spacer()
            
            
        }.padding()
            .frame(maxWidth: .infinity).background(Color.black)
            
    }
}

#Preview {
    LoginView( isUserLoggedIn: .constant(false))
}
