//
//  Book.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//


struct Book: Decodable {
    let id: String
    let volumeInfo: Info
    
    struct Info: Decodable {
        let title: String
        let subtitle: String?
        let authors: [String]?
        let publishedDate: String?
        let imageLinks: ImageLinks?
        
        struct ImageLinks: Decodable {
            let smallThumbnail: String
            let thumbnail: String
        }
    }
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}
