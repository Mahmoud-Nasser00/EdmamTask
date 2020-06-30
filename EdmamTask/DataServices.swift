//
//  DataServices.swift
//  EdmamTask
//
//  Created by Mahmoud Nasser on 6/30/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//

import Foundation
import Alamofire

class DataServices {

    static let debuggingTag = "DataServices "
    static let appKey = "b43e324b296032f62a00c80ed5c17472"
    static let appID = "b1a0c281"

    // Endpoints
    enum EndPoints {
        static let base = "https://api.edamam.com/"
        static let apiKeyParam = "app_key=\(DataServices.appKey)"
        static let appID = "&app_id=\(DataServices.appID)"

        case search(String)

        var stringValue: String {
            switch self {
            case .search(let q): return EndPoints.base + "search?" + EndPoints.apiKeyParam + EndPoints.appID + "&q=\(q)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }

    }


    static let paramaters: [String: Any] = [:]


    class func downloudRecipePhoto(urlString: String, completion: @escaping(Data?, Error?) -> Void) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else {
                    completion(nil, error)
                    print(debuggingTag, "error:\(String(describing: error?.localizedDescription))")
                    return
                }

                completion(data, nil)
                print(debuggingTag, "success")

            }
            task.resume()
        }

    }

    class func getRecipes(q:String,completion: @escaping (RecipeModel?, Error?) -> Void) {

        let _ = taskForGetRequest(EndPoints.search(q).url, response: RecipeModel.self) { (response, error) in

            guard let response = response else {
                print(debuggingTag, "couldnt get response: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
                return
            }

            print(debuggingTag, "response: \(response)")
            completion(response, nil)
        }

    }


    class func taskForGetRequest<ResponseType:Codable>(_ url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                print(debuggingTag, "couldnt get data : \(String(describing: error?.localizedDescription))")
                completion(nil, error)
                return
            }

            print(debuggingTag, "response = \(String(describing: response))")

            do {
                let jsonDecoer = JSONDecoder()
                let response = try jsonDecoer.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                print(debuggingTag, "couldnt decode data : \(String(describing: error.localizedDescription))")
                completion(nil, error)
            }
        }
        task.resume()

        return task
    }
}


/*func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
      decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

  func alamotask(){
   
   let url  = EndPoints.search("fish").stringValue
   print(url)
       AF.request(EndPoints.search(url).stringValue, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
           print(response.result)
           
           switch response.result {
           case .success(_):
               print("alamo response: \(response)")
           case .failure(let error):
               print("alamo response error : \(error.localizedDescription)")
               
           }
       }
   }
 
extension URLSession {
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                print("there is error in datatask")
                return
            }

            do {

               let result =  try newJSONDecoder().decode(T.self, from: data)

                completionHandler(result,response,nil)
                print("result : \(result)")
            } catch {
                completionHandler(nil,response,nil)
                print("decoding error : \(error)")
            }

            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func welcomeTask(with url: URL, completionHandler: @escaping (RecipeModel?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}*/
