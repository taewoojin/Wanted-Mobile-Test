//
//  VolumeResponse.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/03.
//


struct VolumeResponse: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Volume]
}
