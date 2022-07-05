//
//  Book.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//


struct Book: Decodable, Equatable {
//    let kind: String
    let id: String
//    let etag: String
//    let selfLink: String
    let volumeInfo: Info
//    let saleInfo: SaleInfo
//    let accessInfo: AccessInfo
//    let searchInfo : SearchInfo?
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    struct Info: Decodable {
        let title: String
        let subtitle: String?
        let authors: [String]?
        let publishedDate: String?
//        let industryIdentifiers: [IndustryID]
//        let readingModes: ReadingModes
//        let pageCount: Int?
//        let printType: String
//        let categories: [String]?
//        let maturityRating: String
//        let allowAnonLogging: Bool
//        let contentVersion: String
//        let panelizationSummary: PanelizationSummary
        let imageLinks: ImageLinks?
//        let language: String
//        let previewLink: String
//        let infoLink: String
//        let canonicalVolumeLink: String
        
        struct IndustryID: Decodable {
            let type: String
            let identifier: String
        }
        
        struct ReadingModes: Decodable {
            let text: Bool
            let image: Bool
        }
        
        struct PanelizationSummary: Decodable {
            let containsEpubBubbles: Bool
            let containsImageBubbles: Bool
        }
        
        struct ImageLinks: Decodable {
            let smallThumbnail: String
            let thumbnail: String
        }
    }
    
    struct SaleInfo: Decodable {
        let country: String
        let saleability: String
        let isEbook: Bool
    }
    
    struct AccessInfo: Decodable {
        let country: String
        let viewability: String
        let embeddable: Bool
        let publicDomain: Bool
        let textToSpeechPermission: String
        let epub: Epub
        let pdf: PDF
        let webReaderLink: String
        let accessViewStatus: String
        let quoteSharingAllowed: Bool
        
        struct Epub: Decodable {
            let isAvailable: Bool
        }
        
        struct PDF: Decodable {
            let isAvailable: Bool
        }
    }
    
    struct SearchInfo: Decodable {
        let textSnippet: String
    }

}
