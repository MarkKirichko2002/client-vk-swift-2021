//
//  API.swift
//  client-server-1347
//
//  Created by Artur Igberdin on 12.07.2021.
//

import Foundation
import Alamofire
import DynamicJSON


final class UserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let cliendId = Session.shared.userId
    let version = "5.31"
    
    //DynamicJSON
    func getUserInfo(completion: @escaping(Profile)->()) {
        
        let method = "/users.get"
        
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "user_id": cliendId,
            "extended": "1",
            "fields": "first_name, last_name, photo_100",
            "v": version]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
        
            guard let data = response.data else { return }
            print(data.prettyJSON as Any)

            guard let items = JSON(data).response.array else { return }
            let profile = items.map { Profile(json: $0)}
            
            guard let firstUser = profile.first else {return}
            completion(firstUser)
            
        }
    }
}
