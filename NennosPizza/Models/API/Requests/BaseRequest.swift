//
//  BaseRequest.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

import Alamofire

protocol BaseRequestProtocol {
    func params() -> [String: Any]
    func ignoredKeys() -> [String]
}

extension BaseRequest: BaseRequestProtocol {
    final func params() -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard var parsedDict = json as? [String: Any] else { return [:] }
            ignoredKeys().forEach({ parsedDict.removeValue(forKey: $0) })
            return parsedDict
        } catch {
            return [:]
        }
    }
}

class BaseRequest: Encodable, ApiRequestProtocol {
    var urlPath: ApiUtils.ApiPath
    var method: HTTPMethod

    init(urlPath: ApiUtils.ApiPath, method: HTTPMethod) {
        self.urlPath = urlPath
        self.method = method
    }

    enum CodingKeys: String, CodingKey {
        case urlPath
        case method
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(urlPath.url.asURL(), forKey: .urlPath)
        try container.encode(method.rawValue, forKey: .method)
    }

    func ignoredKeys() -> [String] {
        return ["urlPath", "method"]
    }
}
