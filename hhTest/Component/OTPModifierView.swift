//
//  OTPModifierView.swift
//  hhTest
//
//  Created by Валентина Дорина on 14.03.2024.
//

import SwiftUI
import Combine

struct OTPModifierView: View {
    @Binding var pin : String
    var textLimit = 1
    @State private var isEditing = false
    
    func limitText(_ upper : Int) {
            if pin.count > upper {
                self.pin = String(pin.prefix(upper))
            }
        }

    var body: some View {
        VStack(alignment: .center){
                
       
            TextField("", text: $pin, onEditingChanged: { editing in
                self.isEditing = editing
            })
                .background(isEditing || !pin.isEmpty ? nil : Image("*"))
                .multilineTextAlignment(.center)
                        
                .onReceive(Just(pin), perform: { _ in
                            limitText(textLimit)
                        })
                .keyboardType(.numberPad)
                
            
        }.frame(width: 48, height: 48)
            .background(Color.grey2)
            .cornerRadius(8.0)
        
            
            
        
    }
}

#Preview {
    OTPModifierView(pin: .constant(""))
}
