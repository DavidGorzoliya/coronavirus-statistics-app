//
//  NetworkService.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import Foundation
import Alamofire

final class NetworkService {
    
    static let shared = NetworkService()

    private init() {}

    func getOverviewStatistics(completion: @escaping ((DataResponse<StatisticsResponse, AFError>) -> Void)) {
        AF.request(API_URLs.getOverviewStatistics)
            .responseDecodable(of: StatisticsResponse.self, completionHandler: completion)
    }
}

extension NetworkService {

    private struct API_URLs {
        static let getOverviewStatistics = "http://api.covid19api.com/summary"
    }
}
