//
//  CreateUserViewController.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 22/03/23.
//

import UIKit

class CreateUserViewController: UIViewController {
    @IBOutlet var createUserTableView:UITableView!
    var userObj:[CreateData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        CreateUserData()
        let cellRegister = UINib(nibName: "CreateUserTableViewCell", bundle: nil)
        createUserTableView.register(cellRegister, forCellReuseIdentifier: "CreateUserTableViewCell")

    }
    func CreateUserData(){
        let createUserString = "https://gorest.co.in/public/v2/comments"
        guard let url = URL(string: createUserString) else{
            return
            
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let createContent = ["id":69,"user_id":176,"title":"Cras attonbitus defero cupiditate studio animus cerno.","body":"Libero uredo tutamen. Bellicus creta patrocinor. Molestias baiulus abduco. Clementia sortitus volubilis. Tergum argentum coniuratio. Sapiente clamo caput. Ars amitto animi. Cursus speculum crapula. Theologus abstergo amita. Qui comis stips. Vicinus doloribus demoror. Demergo solum tempus. Defendo turpe quibusdam. Aqua optio numquam. Tricesimus vomica eos. Nobis cunae aegrus."] as [String : Any]
        print(createContent)
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: createContent, options: .fragmentsAllowed)
            print(jsonData)
            urlRequest.httpBody = jsonData
        }
        catch{
            
        }
        
        URLSession.shared.dataTask(with: urlRequest){
            data,response,error in
            guard let userData = data else
            {
                return
            }
            print(data)
            print(response)
            print(error)
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([CreateData].self, from: userData)
                print(decodedData)
                self.userObj = decodedData
                DispatchQueue.main.async {
                    self.createUserTableView.reloadData()
                }
            }
            catch{
                print ("error found ")
                
            }
            
        }.resume()
    }
    
}

struct CreateData{
    let id:Int?
    let userId:Int?
    let title:String?
    let body:String?
}
extension CreateData: Decodable{
    enum CodingKeys :String,CodingKey{
        case id = "id"
        case userId = "user_id"
        case title = "title"
        case body = "body"
    }
}
extension CreateUserViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateUserTableViewCell", for: indexPath) as! CreateUserTableViewCell
        cell.idLabel.text = "\(userObj?[indexPath.row].id)"
        cell.titleLabel.text = userObj?[indexPath.row].title
        cell.bodyLabel.text = userObj?[indexPath.row].body
        cell.userIdLabel.text = "\(userObj?[indexPath.row].userId)"
       
        return cell
    }
    
    
}
    


