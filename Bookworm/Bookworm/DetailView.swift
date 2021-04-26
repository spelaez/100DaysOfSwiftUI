//
//  DetailView.swift
//  Bookworm
//
//  Created by Santiago Pelaez Rua on 10/07/20.
//  Copyright © 2020 Santiago Pelaez Rua. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Added on: " + self.formattedDate())
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
        .alert(isPresented: $showingDeleteAlert, content: {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
                }, secondaryButton: .cancel())
        })
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showingDeleteAlert = true
            }) {
                Image(systemName: "trash")
            })
    }
    
    func deleteBook() {
        moc.delete(book)
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func formattedDate() -> String {
        guard let date = book.date else {
            return "Unknown"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        return dateFormatter.string(from: date)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        book.date = Date()
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
