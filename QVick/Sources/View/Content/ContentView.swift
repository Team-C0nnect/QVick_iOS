//
//  ContentView.swift
//  QVick
//
//  Created by dgsw8th16 on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isOn: Bool = false
    
    var body: some View {
        VStack {
            Text("\(SigninViewModel.tokenData)")
                
        }
    }
}

#Preview {
    ContentView()
}
