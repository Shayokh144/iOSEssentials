//
//  ContentView.swift
//  UikitInSwiftUI
//
//  Created by Taher on 19/9/22.
//

import SwiftUI

struct ContentView: View {

    @State var loading: Bool = false
    @State var buttonText = "Start"

    var body: some View {

        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 24.0) {
                NewLoadingView(isLoading: $loading)
                    .frame(width: 200.0, height: 50.0, alignment: .center)
                Button(action: {
                    loading = !loading
                    buttonText = loading ? "Stop" : "Start"
                }){
                    Text(buttonText).foregroundColor(.black).bold()
                }
                .frame(width: 100.0, height: 40.0, alignment: .center)
                .background(.orange)
                .cornerRadius(7.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
