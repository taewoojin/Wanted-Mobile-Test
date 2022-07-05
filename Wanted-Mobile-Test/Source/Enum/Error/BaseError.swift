//
//  BaseError.swift
//  Wanted-Mobile-Test
//
//  Created by 진태우 on 2022/07/05.
//


protocol BaseError: Error {
    var message: String { get }
}
