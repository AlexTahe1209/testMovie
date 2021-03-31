//
//  RequestManager.swift
//  movieDB
//
//  Created by Alex Rivera BBVA on 31/03/21.
//

import Foundation
import UIKit

protocol RequestManagerDelegate : class {
    func didGetResponseModel(response : [MoviesModel] )
}

class RequetsManager: NSObject {
    var session = URLSession.shared
    weak var delegate: RequestManagerDelegate?
    var arr_info : [MoviesModel] = NSMutableArray() as! [MoviesModel]
    
    func sendRequest()
    {
        session = URLSession(configuration: URLSessionConfiguration.default)
        
        let str_url = "https://api.themoviedb.org/3/movie/550?api_key=c8b289680be3d9dff4d671e8d93b47d4"
    
        var request = URLRequest(url: URL(string: str_url)!)
        
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSMutableDictionary
                if let info_dic = json.object(forKey: "results") as? NSMutableArray {
                
                for dic in info_dic
                {
                    self.arrayInfoOfDictionary(dic: dic as! NSDictionary)
                }
                
                self.delegate?.didGetResponseModel(response: self.arr_info)
            
            }
            }
            catch let jsonError
            {
                print("Error serializing json:",jsonError)
            }
        };task.resume()
    }
    
    func arrayInfoOfDictionary(dic:NSDictionary)
    {
        //creo un modelo para manejar el response "MoviesModel"
        
        let url = ("https://image.tmdb.org/t/p/w185_and_h278_bestv2" +  "\(dic.object(forKey: "poster_path") as! String)" )
        
        let model  = MoviesModel()
        model.original_title = dic.object(forKey: "original_title") as! String
        model.overview = dic.object(forKey: "overview") as! String
        model.release_date = dic.object(forKey: "release_date") as! String
        model.url_image = url;
        
        //voy agregando al arreglo los modelos para despues pintar la tabla
        arr_info.append(model)
    }
}
