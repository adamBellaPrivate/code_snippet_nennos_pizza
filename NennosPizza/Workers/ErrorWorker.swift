//
//  ErrorWorker.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct ErrorWorker {
    enum ApiError: Error {
        case invalidResponse
        case businessError(Int)
    }

    func process(error err: Error) -> String {
        guard let apiError = err as? ApiError else { return err.localizedDescription }

        switch apiError {
        case .invalidResponse:
            return "general_error".localized
        case .businessError(let statusCode):
            return String(format: "business_error".localized, statusCode)
        }
    }
}
