//
//  DataViewController.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 22/03/23.
//

import UIKit

class DataViewController: UIViewController{
    @IBOutlet var dataTableView: UITableView!
    var goDataObject:[ToDoData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getToDoData()
        let cellRegister = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        dataTableView.register(cellRegister, forCellReuseIdentifier: "ToDoTableViewCell")

    }
    
    func getToDoData(){
        let getURLString = "https://jsonplaceholder.typicode.com/todos"
        guard  let url = URL(string: getURLString) else{
            return
        }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest){ [self] data, response, error in
            guard let toDoData = data else{
                return
            }
            let decoder = JSONDecoder()
            do{
                
                let decodedData =  try decoder.decode([ToDoData].self, from: toDoData)
                self.goDataObject = decodedData
                DispatchQueue.main.async {
                    dataTableView.reloadData()
                }
                print(decodedData)

            }
                        
            catch{
                
            }
            
        }.resume()
}
    }
struct ToDoData:Codable{
    let userID:Int?
    let id:Int?
    let title:String?
    let status:Bool?
    
}

extension DataViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goDataObject.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        let model = goDataObject[indexPath.row]
        cell.idLabel.text = "\(model.id)"
        cell.userIDLabel.text = "\(model.userID)"
        cell.titleLabel.text = model.title
        cell.statusLabel.text = "\(model.status)"
       
        return cell
    }
    
    
}
