//
//  NetworkManager.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 20.04.2022.
//

import Alamofire
import AlamofireMapper

class NetworkManager {
    // https://api.themoviedb.org/3/genre/movie/list?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en-US
    private var baseApiUrl = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as! String
    private var apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as! String
    
    //MARK:- genresList
    public func getGenresList(successCompletion: @escaping ((_ json : GenresResponse) -> Void)) {
        let url = baseApiUrl + "genre/movie/list?api_key="+apiKey+"&language=en-US"
        let newUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en-US"
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<GenresResponse>) in
            switch response.result {
            case .success(let json):
                successCompletion(json)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
           
        }
    }
    
    var isPaginating: Bool = false

    //discover/movie?api_key=3bb3e67969473d0cb4a48a0dd61af747&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28
    //MARK:- getMovieList
    public func getMovieList(genres:String, pagination: Bool = false, page: String, successCompletion: @escaping ((_ json : MovieListModelString) -> Void)) {
        
        if pagination {
            isPaginating = true
        }
        
        let url = baseApiUrl + "discover/movie?api_key="+apiKey+"&sort_by=popularity.desc&include_adult=false&include_video=false&page="+page+"&with_genres="+genres
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<MovieListModelString>) in
            switch response.result {
            case .success(let json):
                successCompletion(json)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
            if pagination {
                    self.isPaginating = false
                }
           
        }
    }


}


