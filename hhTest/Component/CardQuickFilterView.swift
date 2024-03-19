//
//  CardQuickFilterView.swift
//  hhTest
//
//  Created by Валентина Дорина on 14.03.2024.
//

import SwiftUI

struct CardQuickFilterView: View {
    let imageName : String
    let titleFilter : String
    var isLift = false
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading, spacing: 16){
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                    
                    //.padding(.leading, 8)
                
                VStack {
                    Text(titleFilter)
                        .foregroundColor(.white)
                        
                        .multilineTextAlignment(.leading)
                        
                    
                    if isLift {
                        Text("Поднять")
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                    }
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                
                

                    
            }.padding(.top, 10).padding(.leading, 8).fontWeight(.medium)
                .font(.system(size: 14))
                
            
            
            
                
            Spacer()
        }.frame(width: 132, height: 120)
        
            .background(Color.grey1)
            .cornerRadius(8)
    }
}

#Preview {
    CardQuickFilterView(imageName: "jobNear", titleFilter: "Поднять резюме в поиске", isLift: true)
}
