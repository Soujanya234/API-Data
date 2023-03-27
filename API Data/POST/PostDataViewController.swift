//
//  PostDataViewController.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 21/03/23.
//

import UIKit

class PostDataViewController: UIViewController {
    @IBOutlet var postDataTableView:UITableView!
    var postUserData:PostData? 

    override func viewDidLoad() {
        super.viewDidLoad()
        postAPIData()
        let cellRegister = UINib(nibName:"PostDetailsTableViewCell" , bundle: nil)
        print(cellRegister)
        postDataTableView.register(cellRegister, forCellReuseIdentifier: "PostDetailsTableViewCell")
        
}
    func postAPIData(){
        
        let postURLString = "https://reqres.in/api/users"
        print(postURLString)
        guard let url = URL(string: postURLString) else{
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postContent = ["name": "morpheus",
        "job": "leader"]
        do{
        let jsonData =  try JSONSerialization.data(withJSONObject: postContent, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonData
            print(jsonData)
        }
        catch{
            print("error found will catching the data")
            
        }
        
        
        URLSession.shared.dataTask(with: urlRequest){data, response, error in
            print(data)
            print(response)
            print(error)
            let decoder = JSONDecoder()
            do{
                guard let createData = data else {
                    return
                    
                }
                
                var decodedData = try decoder.decode(PostData.self, from: createData)
                print(decodedData)
                self.postUserData = decodedData
                DispatchQueue.main.async {
                    self.postDataTableView.reloadData()
                }
                    
                }
                
            catch{
                
            }
        }.resume()
        
    }
    
              
}
struct PostData{
    let name: String?
    let job: String?
}
extension PostData: Decodable{
    enum CodingKeys: String,CodingKey{
        case name = "name"
        case job = "job"
        
    }
}
extension  PostDataViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return postUserData?.job?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailsTableViewCell", for: indexPath) as! PostDetailsTableViewCell
        cell.ageLabel.text = postUserData?.name
        cell.nameLabel.text = postUserData?.job
        return cell 
    }
    
    
}
extension PostDataViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            guard let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "InformationViewController")else{
                return
            }
            navigationController?.pushViewController(infoVC, animated: true)
            

        }
    }
}

