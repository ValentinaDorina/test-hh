//
//  SmallButtonView.swift
//  hhTest
//
//  Created by Валентина Дорина on 19.03.2024.
//

import SwiftUI

struct SmallButtonView: View {
    let buttonName : String
    var body: some View {
        VStack{
            Text(buttonName)
        }.fontWeight(.medium)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(.horizontal)
            .frame(height: 33)
            .background(.grey2)
            .cornerRadius(50)
        

    }
}

#Preview {
    SmallButtonView(buttonName: "Где распологается место работы?")
}
