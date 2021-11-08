////
////  JsonModel.swift
////  GoodsShop
////
////  Created by Stepanyan Arman  on 08.11.2021.
////
//
//import Foundation
//
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let info: Info
//    let item: [Item]
//    let variable: [Variable]
//}
//
//// MARK: - Info
//struct Info: Codable {
//    let postmanID, name: String
//    let schema: String
//
//    enum CodingKeys: String, CodingKey {
//        case postmanID = "_postman_id"
//        case name, schema
//    }
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let name: String
//    let request: Request
//    let response: [Response]
//    let protocolProfileBehavior: ProtocolProfileBehavior?
//}
//
//// MARK: - ProtocolProfileBehavior
//struct ProtocolProfileBehavior: Codable {
//    let disableBodyPruning: Bool
//}
//
//// MARK: - Request
//struct Request: Codable {
//    let method: Method
//    let header: [JSONAny]
//    let body: Body
//    let url: URLClass
//}
//
//// MARK: - Body
//struct Body: Codable {
//    let mode: Mode
//    let raw: String?
//    let formdata: [Formdatum]?
//}
//
//// MARK: - Formdatum
//struct Formdatum: Codable {
//    let key: String
//    let value: String?
//    let type: String
//    let disabled: Bool?
//    let src: String?
//}
//
//enum Mode: String, Codable {
//    case formdata = "formdata"
//    case raw = "raw"
//}
//
//enum Method: String, Codable {
//    case methodGET = "GET"
//    case post = "POST"
//}
//
//// MARK: - URLClass
//struct URLClass: Codable {
//    let raw: String
//    let host, path: [String]
//    let urlProtocol, port: String?
//
//    enum CodingKeys: String, CodingKey {
//        case raw, host, path
//        case urlProtocol = "protocol"
//        case port
//    }
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let name: String
//    let originalRequest: Request
//    let status: String
//    let code: Int
//    let postmanPreviewlanguage: String
//    let header: [Variable]
//    let cookie: [JSONAny]
//    let body: String
//
//    enum CodingKeys: String, CodingKey {
//        case name, originalRequest, status, code
//        case postmanPreviewlanguage = "_postman_previewlanguage"
//        case header, cookie, body
//    }
//}
//
//// MARK: - Variable
//struct Variable: Codable {
//    let key, value: String
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONAny: Codable {
//
////    let value: Any?
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//}
//
//    class JSONNull: Codable, Hashable {
//
//        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//            return true
//        }
//
//        public var hashValue: Int {
//            return 0
//        }
//
//        public init() {}
//
//        public required init(from decoder: Decoder) throws {
//            let container = try decoder.singleValueContainer()
//            if !container.decodeNil() {
//                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//            }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//            var container = encoder.singleValueContainer()
//            try container.encodeNil()
//        }
//    }
//
//
//
//
//
//
//
//
//
////struct GoodsInfo: Decodable {
////    let image: UIImage
////    let name: String
////    let rating: Double
////    let price: Double
////    let id: String
////    let description: String
////}
