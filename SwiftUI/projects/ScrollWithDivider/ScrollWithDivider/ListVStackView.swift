//
//  ListVStackView.swift
//  ScrollWithDivider
//
//  Created by Taher's nimble macbook on 2/10/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            VStackForEachScrollView()
                .tabItem {
                    Label("ScrollView", systemImage: "list.bullet")
                }
            ListVStackView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
        }
    }
}

struct ListVStackView: View {
    
    @State private var numberOfItem = 4
    @State private var numberText = ""
    
    var body: some View {
        VStack(spacing: .zero) {
            Text("This is List")
                .padding()
            TextField("Change Number of Item", text: $numberText)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
            
            ScrollViewReader { proxy in
                List(0...numberOfItem, id: \.self) { num in
                    VStack(spacing: .zero) {
                        Text("\(num)")
                            .id(num)
                        Divider()
                            .frame(height: 1.0)
                            .background(Color.red)
                            .padding(.vertical)
                    }
                    .listRowSpacing(0)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .listSectionSeparator(.hidden)
                Button("Move to middle", action: {
                    withAnimation {
                        proxy.scrollTo(numberOfItem / 2, anchor: .center)
                    }
                })
            }
        }
        .padding()
        .onReceive(numberText.publisher) { _ in
            numberOfItem = Int(numberText) ?? 4
        }
    }
}


struct VStackForEachScrollView: View {
    
    @State private var numberOfItem = 4
    @State private var numberText = ""
    
    var body: some View {
        VStack(spacing: .zero) {
            Text("This is ScrollView")
                .padding()
            TextField("Change Number of Item", text: $numberText)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: .zero) {
                        ForEach((0...numberOfItem), id: \.self) { num in
                            Text("\(num)")
                                .id(num)
                            Divider()
                                .frame(height: 1.0)
                                .background(Color.red)
                                .padding(.vertical)
                        }
                    }
                }
                Button("Move to middle", action: {
                    withAnimation {
                        proxy.scrollTo(numberOfItem / 2, anchor: .center)
                    }
                })
            }
        }
        .padding()
        .onReceive(numberText.publisher) { _ in
            numberOfItem = Int(numberText) ?? 4
        }
    }
}
