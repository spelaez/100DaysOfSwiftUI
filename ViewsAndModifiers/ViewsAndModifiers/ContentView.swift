//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Santiago Pelaez Rua on 19/05/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI

//struct Watermark: ViewModifier {
//    var text: String
//
//    func body(content: Content) -> some View {
//        ZStack(alignment: .bottomTrailing) {
//            content
//            Text(text)
//                .font(.caption)
//                .foregroundColor(.white)
//                .padding(5)
//                .background(Color.black)
//        }
//    }
//}
//
//extension View {
//    func watermarked(with text: String) -> some View {
//        self.modifier(Watermark(text: text))
//    }
//}

//struct GridStack<Content: View>: View {
//    let rows: Int
//    let columns: Int
//    let content: (Int, Int) -> Content
//
//    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
//        self.rows = rows
//        self.columns = columns
//        self.content = content
//    }
//
//    var body: some View {
//        VStack {
//            ForEach(0..<rows, id: \.self) { row in
//                HStack {
//                    ForEach(0..<self.columns, id: \.self) { column in
//                        self.content(row, column)
//                    }
//                }
//            }
//        }
//    }
//}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        self.modifier(ProminentTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Soy un texto OP")
            .prominentTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
