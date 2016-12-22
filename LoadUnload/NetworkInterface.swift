


import Foundation


typealias LURequestCompletionType = (Bool, NSDictionary?, URLResponse?, Error?) -> (Void)

class NetworkInterface: NSObject {
    
    
    /// Call
    static func fetchJSON(_ requestType:LURequestType , headers:NSDictionary? = [:], params:NSDictionary? = [:], requestCompletionHander:@escaping LURequestCompletionType)  {
        
        self.sendAsyncRequest(LUNetworkRequests.getRequestofType(requestType, headers: headers, params: params)) { (success, json, response, error) -> (Void) in
            if (success == true && response != nil) {
                
                let httpResponse:HTTPURLResponse = response as! HTTPURLResponse
                let httpStatusCode = httpResponse.statusCode
                
                switch httpStatusCode {
                    
                case 200:
                    let succcess = (json != nil)
                    if (succcess) {
                        requestCompletionHander(succcess, json, response, nil)
                    } else {
                        requestCompletionHander(false, nil, response , DataErrors.invalidJSONData)
                    }
                    break
                    
                case 204:
                    requestCompletionHander(false, nil, response, LUNetworkError.httpStatus204)
                    break
                case 404:
                    requestCompletionHander(false,nil,response,LUNetworkError.httpStatus404)
                    break
                case 410:
                    requestCompletionHander(false, nil, response, LUNetworkError.httpStatus410)
                    break
                default:
                    requestCompletionHander(false,nil,response,LUNetworkError.httpStatusUnknownError)
                    break
                }
            }
            else {
                requestCompletionHander(false,nil,response,error)
            }
            
        }
    }

    
    
    /*!
        @brief This property knows my name. 
     */
    static func fetchJSON(_ requestType:LURequestType , headers:NSDictionary? = [:], params: NSDictionary? = [:],  payload :[String:Any]  , requestCompletionHander:@escaping LURequestCompletionType) {

            self.sendAsyncRequest(LUNetworkRequests.postRequestofType(requestType, headers: headers, params:params, payload: payload  ), completionHandler: { (suc, json, response, error) -> (Void) in
                let succcess = (json != nil)
                requestCompletionHander(succcess,json, response,error)
                
            })
    }
    
    static func upload(_ requestType:LURequestType, headers:NSDictionary? = [:], params:NSDictionary? = [:], payload:NSDictionary?, media:Array<MPMedia>, requestCompletionHander:@escaping LURequestCompletionType) {

            //TODO: Implement the cases for HTTP Code as for GET and TEST
            self.sendAsyncRequest(LUNetworkRequests.uploadRequestofType(requestType, params: params, headers: headers, payload: payload, media: media ), completionHandler: { (suc, json, response, error) -> (Void) in
                let succcess = (json != nil)
                requestCompletionHander(succcess,json, response,error)
                
            })
    }
    
    static fileprivate func sendAsyncRequest(_ request:URLRequest, completionHandler:@escaping LURequestCompletionType) {
        
        let task = URLSession.shared.dataTask(with: request) { ( data,response, error) in
            do {
                if (response != nil && data != nil) {
                    if let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? Any{
                        print("Response from DISPATCH ASYNC URL \(response?.url) \(json)")
                        if (json is NSArray) {
                            let arrayOfJson = ["array":json]
                            completionHandler(true,arrayOfJson as NSDictionary?, (response as! HTTPURLResponse), nil)
                        } else {
                            completionHandler(true,json as? NSDictionary ,(response  as! HTTPURLResponse), nil)
                        }
                    } else {
                        completionHandler(false, nil, (response as! HTTPURLResponse), DataErrors.invalidJSONData)
                    }
                } else {
                    if let data = data,let json = try JSONSerialization.jsonObject(with: data, options:[]) as? Any {
                        print(json)
                    }
                    completionHandler(false, nil, response , DataErrors.noData)
                }
            }catch let error as NSError {
                print(error.localizedDescription)
                if let resultNSString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                    print(resultNSString)
                }
                completionHandler(false, nil,response,DataErrors.dataParseError)
            }
            
        }
        task.resume()
    }
}
