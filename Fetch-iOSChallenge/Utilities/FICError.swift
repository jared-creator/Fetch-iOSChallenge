//
//  FICError.swift
//  Fetch-iOSChallenge
//
//  Created by JaredMurray on 8/2/24.
//

import Foundation

enum FICError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalide response from the server. Plases try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
