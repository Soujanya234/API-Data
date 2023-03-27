//
//  GetUserDetailsViewController.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 21/03/23.
//

import UIKit

class GetUserDetailsViewController: UIViewController {
    @IBOutlet var getUserTableView:UITableView!
    var getUserObject:[GetUserData] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAPIData()
        let cellRegister = UINib(nibName: "GetUserTableViewCell", bundle: nil)
        getUserTableView.register(cellRegister, forCellReuseIdentifier: "GetUserTableViewCell")
      

    }
    
    func getAPIData(){
        let getStringURL = "https://reqres.in/api/users"
        print(getStringURL)
        guard let url = URL(string: getStringURL)else{
            return
        }
        print(url)
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            print(data)
            print(response)
            print(error)
            guard let userData = data else{
                return
            }
            
            
                let decoder = JSONDecoder()
            do{
                var decodedData = try decoder.decode([GetUserData].self, from:userData)
                print(decodedData)
                self.getUserObject = decodedData
                DispatchQueue.main.async {
                    self.getUserTableView.reloadData()
                    
                }
               
            }
            catch{
                
            }
            
        }.resume()
        
        
        
    }
    
}
struct GetUserData{
    let userId:Int?
    let id:Int?
    let title:String?
    let status:Bool?
    
}
extension GetUserData:Decodable{
    enum CodingKeys: String,CodingKey{
        case userId = "userId"
        case id = "id"
        case title = "title"
        case status = "completed"
    }
}
extension  GetUserDetailsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getUserObject.count
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetUserTableViewCell", for: indexPath) as? GetUserTableViewCell
//        let sampleDict = ["abc":"efg","def":"efg","ghi":"jkl"]
//        let sampleUserID = sampleDict["abc"]
//        let userID = getUserData?[indexPath.row].id
//        print(userID)
//     print(sampleUserID)
//        let number = 2
//        let sampleString: String = "\(number)"
//        let sampleArray = ["","","","",]
//        sampleArray[indexPath.row]
        var model = getUserObject[indexPath.row]
        cell?.idLabel?.text = "\(model.id)"
        return cell ?? UITableViewCell()
    }
    
    
}
    


