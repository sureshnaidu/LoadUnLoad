

import Foundation


import Foundation

enum LURequestType {
    
    case login
    case signup
    case customerInfo

}


struct RequestConstants {
    
    static let LUURL = "http://ragsarma-001-site13.htempurl.com"

}

class LUNetworkRequests {
    
    // GET Requests
    static func getRequestofType(_ requestType:LURequestType, headers:NSDictionary?,  params:NSDictionary?) -> URLRequest {
        var request:URLRequest!
        switch requestType {
        case .customerInfo:
            let path = "/api/master/customer/\(params!["mobile"]!)"
            let endpoint = RequestConstants.LUURL + path
            request = self.createGETRequest(endpoint, headers: headers, params: params)
            
        default:
            break
        }
        
        return request
    }
    

    
    // POST Requests
    static func postRequestofType(_ requestType:LURequestType,headers:NSDictionary?, params:NSDictionary?, payload :[String:Any]? ) -> URLRequest {
        var request:URLRequest!
        switch requestType {
            
        case .signup:
            
            let authPath = "/users/signup"
            let endpoint = RequestConstants.LUURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,params: params, payload: payload!)
            break

        case .login:
            let path = "/api/master/customer/login"
            let endpoint = RequestConstants.LUURL + path
            request = self.createPOSTRequest(endpoint, headers: headers,params: params, payload: payload!,auth: false)
            break
            
        default:
            break
        }
        return request
    }
    
    static func uploadRequestofType(_ requestType:LURequestType,params:NSDictionary?, headers:NSDictionary?, payload:NSDictionary?,media : Array<MPMedia> ) -> URLRequest {
        var request:URLRequest!
        switch requestType {
//        case .createImageMessage:
//            let endpoint = "/users/upload"
//            let url = RequestConstants.LUURL + endpoint
//            request = createMultiPartPOSTRequest(url, params: params, headers: headers, payload: payload, media: media)
//            break
//        case .createVideoMessage:
//            let endpoint = "/messages"
//            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endpoint
//            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
//            break
//        case .createVideoThumbnail:
//            let endpoint = "/thumbnail"
//            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endpoint
//            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
//            break
//        case .createPetBlob:
//            let endPoint = "/blobs"
//            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endPoint
//            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
//            break
        default:
            break
        }
        return request
    }
    
    
    static func createGETRequest(_ baseURL:String , headers:NSDictionary?, params:NSDictionary?,auth: Bool = true) -> URLRequest {
        var headerAsString:String = ""
        if (params != nil && params!.count > 0) {
            var separator = "?"
            for (key,value) in params! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        
        
        
        let fullUrlString = baseURL + headerAsString;
        let url = URL(string: fullUrlString)
        var request = NSMutableURLRequest(url: url!)
        
        if headers != nil {
            for (key,value) in headers! {
                request.addValue(value as! String, forHTTPHeaderField: key as! String)
            }
        }
        
        if auth{
            self.setAuthHeaders(request: &request)
        }
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPOSTRequest(_ baseURL:String ,headers:NSDictionary?,params: NSDictionary?, payload:[String:Any], auth: Bool = true) -> URLRequest {
        var headerAsString:String = ""
        
        if (params != nil && params!.count > 0) {
            var separator = "?"
            for (key,value) in params! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        
        
        let fullUrlString = baseURL + headerAsString;
        let url = URL(string: fullUrlString)
        var request = NSMutableURLRequest(url: url!)
        if headers != nil {
            for (key,value) in headers! {
                request.addValue(value as! String, forHTTPHeaderField: key as! String)
            }
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: [])
            let post = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
            request.httpBody = post.data(using: String.Encoding.utf8);
        }catch {
            print("json error: \(error)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if auth{
            self.setAuthHeaders(request: &request)
        }
        
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPOSTRequestWithFormData(_ baseURL:String ,headers:NSDictionary?, payload:NSDictionary?, auth: Bool = true) -> URLRequest {
        var headerAsString:String = ""
        
        if (headers != nil && headers!.count > 0) {
            var separator = "?"
            for (key,value) in headers! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        print(headers)
        
        let fullUrlString = baseURL + headerAsString;
        let url = URL(string: fullUrlString)
        var request = NSMutableURLRequest(url: url!)
        
        var payloadString = ""
        if (payload != nil && payload!.count > 0) {
            var separator = ""
            for (key,value) in payload! {
                payloadString += separator
                payloadString += key as! String
                payloadString += "="
                payloadString += value as! String
                separator = "&"
            }
        }
        
        request.httpBody = payloadString.data(using: String.Encoding.utf8);
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if auth{
            self.setAuthHeaders(request: &request)
        }
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static fileprivate func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    
    static func createDELETERequest(_ baseURL:String , headers:NSDictionary?,auth: Bool = true) -> URLRequest {
        var headerAsString:String = ""
        
        if (headers != nil && headers!.count > 0) {
            var separator = "?"
            for (key,value) in headers! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
            
        }
        
        let fullUrlString = baseURL + headerAsString;
        let url = URL(string: fullUrlString)
        var request = NSMutableURLRequest(url: url!)
        if auth{
            self.setAuthHeaders(request: &request)
        }
        request.httpMethod = "DELETE"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPUTRequest(_ baseURL:String ,headers:NSDictionary?, payload:NSDictionary?,auth: Bool = true) -> URLRequest {
        var headerAsString:String = ""
        
        if (headers != nil && headers!.count > 0) {
            var separator = "?"
            for (key,value) in headers! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        print(headers)
        
        let fullUrlString = baseURL + headerAsString;
        let url = URL(string: fullUrlString)
        var request = NSMutableURLRequest(url: url!)
        
        do {
            let data = try JSONSerialization.data(withJSONObject: payload!, options: [])
            let post = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
            request.httpBody = post.data(using: String.Encoding.utf8);
        } catch {
            print("json error: \(error)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if auth{
            self.setAuthHeaders(request: &request)
        }
        request.httpMethod = "PUT"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    
    static func createMultiPartPOSTRequest(_ SikkaURL:String ,queryParams:NSDictionary?, headers:NSDictionary?, payload:NSDictionary?,media : Array<MPMedia>) -> URLRequest {
        var headerAsString:String = ""
        
        let boundary = generateBoundaryString()
        
        if (queryParams != nil && queryParams!.count > 0) {
            var separator = "?"
            for (key,value) in queryParams! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        
        let fullUrlString = SikkaURL + headerAsString;
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        
        do {
            let body = createMPBody(payload: payload, media: media , boundary: boundary)
            request.httpBody = body
        }catch {
            print("json error: \(error)")
        }
        if let headers = headers {
            for (key,value) in headers{
                request.addValue(value as! String, forHTTPHeaderField: key as! String)

                
            }
        }
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static fileprivate func createMPBody(payload: NSDictionary?, media : Array<MPMedia>, boundary: String) -> Data {
        let body = NSMutableData();
        
        if payload != nil {
            for (key, value) in payload! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        for mp: MPMedia in media {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(mp.fileKey!)\"; filename=\"\(mp.fileName!)\"\r\n")
            body.appendString("Content-Type: \(mp.mimeType!)\r\n\r\n")
            body.append(mp.fileData! as Data)
            body.appendString("\r\n")
            
            body.appendString("--\(boundary)--\r\n")
        }
        return body as Data
    }
    

    static func setAuthHeaders(request:inout NSMutableURLRequest){
        if let mobile = UserSession.user()?.mobileNo {
            request.addValue(mobile, forHTTPHeaderField: "MOBILENO")
        }
        if let token = UserSession.user()?.token {
            request.addValue(token, forHTTPHeaderField: "AUTH_TOKEN")
        }
    }
    
    
    
}
