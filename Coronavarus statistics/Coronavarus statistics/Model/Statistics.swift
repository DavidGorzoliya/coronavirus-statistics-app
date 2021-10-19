//
//  Statistics.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import Foundation

struct StatisticsResponse: Codable {
    let message: String
    let global: Global
    let countries: [Country]

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case global = "Global"
        case countries = "Countries"
    }
}

struct Country: Codable {
    let country, countryCode, slug: String
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}

extension Country {
    var titleFirstLetter: String {
        return String(self.country[self.country.startIndex]).uppercased()
    }
}

struct Global: Codable {
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}
