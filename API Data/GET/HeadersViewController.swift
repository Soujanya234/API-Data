//
//  HeadersViewController.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 22/03/23.
//

import UIKit

class HeadersViewController: UIViewController {
    
    @IBOutlet var headerTableView:UITableView!
    var headerObject:HeaderData?

    override func viewDidLoad() {
        super.viewDidLoad()
        getHeaderData()
        let cellRegister = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        headerTableView.register(cellRegister, forCellReuseIdentifier: "HeaderTableViewCell")
}
    func getHeaderData(){
        let getHeaderString = "https://httpbin.org/get"
        guard  let url = URL(string: getHeaderString) else{
            return
        }
    let urlRequest = URLRequest(url:url )
        
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            guard let headerData = data else{
                return
                
            }
            print(data)
            print(response)
            print(error)
         
                 let decoder =  JSONDecoder()
            do{
                var decodedData = try decoder.decode(HeaderData.self, from: headerData)
                self.headerObject = decodedData
                DispatchQueue.main.async {
                    self.headerTableView.reloadData()
                }
            }
            catch{
                
            }
            
        }.resume()
    }
    }
struct HeaderData:Codable{
    let header: Header?
    let origin:String?
    let url:String?
}
struct Header:Codable{
    let accept:String?
    let host:String?
}
extension HeadersViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
        cell.acceptLabel.text = headerObject?.header?.accept
        return cell
        
    }
    
    
}

        


    
   
