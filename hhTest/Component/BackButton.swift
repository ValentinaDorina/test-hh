//
//  BackButton.swift
//  hhTest
//
//  Created by Валентина Дорина on 19.03.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode

        var body: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                // Ваш кастомизированный вид кнопки назад
                Image("leftArrow")
                    //.resizable()
                    //.aspectRatio(contentMode: .fill)
                    
                    //.frame(width: 24, height: 24)// Любая кастомизация цвета, изображения и т. д.
                    .padding()
                    
            }
        }
}

#Preview {
    BackButton()
}
