//
//  PutDataViewController.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 21/03/23.
//

import UIKit

class PutDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        putAPIData()

        // Do any additional setup after loading the view.
    }
    func putAPIData(){
        let putURLString = "https://reqres.in/api/users"
        print(putURLString)
        guard let url = URL(string: putURLString)else{
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let putData = ["name": "morpheus",
        "job": "zion resident"]
        print(putData)
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: putData, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonData
            print(jsonData)
        }
        catch{
            print("error in creating json data")
        }
        URLSession.shared.dataTask(with:urlRequest){data ,response, error in
            print(data)
            print(response)
            guard let apiResponse = response as?  HTTPURLResponse else{
                return
                
            }
            print(apiResponse.statusCode)
            print(error)
            guard let unwrappedData = data else{
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(PutData.self, from: unwrappedData)
                print(decodedData)
                
            }
            catch{
                
            }
            
        }.resume()
        
    }
    

   

}
struct PutData{
    let name: String?
    let job: String?
}
extension PutData: Decodable{
    enum CodingKeys: String,CodingKey{
        case name = "name"
        case job = "job"
        
    }
}

