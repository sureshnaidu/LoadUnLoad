

import Foundation


enum LUNetworkError : Error {
    case httpStatus201
    case httpStatus204
    case httpStatus400
    case httpStatus404
    case httpStatus410
    case httpStatusUnknownError
}

enum DataErrors : Error {
    case invalidJSONData
    case dataParseError
    case noData
}
