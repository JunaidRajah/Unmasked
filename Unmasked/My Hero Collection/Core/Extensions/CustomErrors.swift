//
//  CustomErrors.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/11.
//

import Foundation

enum CustomError: Error {
    case userNotFound
    case unexpected(code: Int)
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userNotFound:
            return "User Not Found"
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}
