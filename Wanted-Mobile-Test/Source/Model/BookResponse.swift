//
//  BookResponse.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//


struct BookResponse: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Book]
    
    enum CodingKeys: String, CodingKey {
        case kind, totalItems, items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        kind = try container.decode(String.self, forKey: .kind)
        totalItems = try container.decode(Int.self, forKey: .totalItems)
        items = (try? container.decode([Book].self, forKey: .items)) ?? []
    }
}
