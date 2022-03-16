//
//  ContentView.swift
//  Shared
//
//  Created by Rudrank Riyam on 16/03/22.
//

import SwiftUI
import QuoteKit

extension Authors {
    static var demoAuthors: [Author] {
        if let path = Bundle.main.path(forResource: "Authors", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try JSONDecoder().decode(Authors.self, from: data)
                return model.results
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                return []
            }
        } else {
            print("Invalid filename/path.")
            return []
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            AuthorView()
        }
    }
}

struct AuthorRow: View {
    var author: Author

    var body: some View {
        HStack {
            if #available(macOS 12.0, *) {
                AsyncImage(url: QuoteKit.authorImage(with: author.slug)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70, height: 70)
            } else {
                EmptyView()
                // Fallback on earlier versions
            }

            Text(author.name)
        }
    }
}


struct AuthorDetailView: View {
    @State private var quotes: Quotes?
    var author: Author

    var body: some View {
        ScrollView(showsIndicators: false) {
            if #available(macOS 12.0, *) {
                AsyncImage(url: QuoteKit.authorImage(with: author.slug)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
            } else {
                // Fallback on earlier versions
                EmptyView()
            }

            Text(author.name)
                .font(.largeTitle)
                .padding(.bottom)

            Text(author.bio)
                .font(.title2)
                .lineSpacing(2)
                .padding(.bottom)

            Text("Quotes")
                .font(.largeTitle)
                .padding()

            if let quotes = quotes {
                ForEach(quotes.results) { quote in
                    Text(quote.content)
                        .font(.callout)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

        }
        .padding(.horizontal)
        .onAppear {
            Task {
                do {
                    quotes = try await QuoteKit.quotes(authors: [author.slug])
                } catch {

                }
            }
        }
    }
}
struct AuthorView: View {
    var body: some View {
        List {
            ForEach(Authors.demoAuthors) { author in
                NavigationLink(destination: AuthorDetailView(author: author)) {
                    AuthorRow(author: author)
                }
            }
        }
        .navigationTitle("Authors")
#if os(macOS)
        .frame(minWidth: 300)
#endif
    }
}
