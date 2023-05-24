//
//  TODOViewController.swift
//  Models
//
//  Created by DA MAC M1 144 on 2023/05/24.
//

import UIKit

class TODOViewController: UIViewController {
    
    var arr=["John", "Sam", "Steve", "Mohammed"]
    var searching:Bool=false
    var searchingArray=[String]()
    var data=[Todo]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        FetchApiData(URL: "https://jsonplaceholder.typicode.com/todos"){ result in
            self.data=result
            print (result)
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        
    }
    
    func FetchApiData (URL url: String, completion: @escaping([Todo]) -> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: url) { data, response, error in
            if data != nil, error == nil {
                
                do{
                    let parsingData = try JSONDecoder().decode([Todo].self, from: data!)
                    completion(parsingData)
                }catch{
                    print("parsing error")
                }
                
            }
        }
        datatask.resume()
    }}
    
    


extension TODOViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searching){
            return searchingArray.count
        }
        else{
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as?TODOTableViewCell
        else{return UITableViewCell()}
        if searching{
            cell.titleLabel?.text=searchingArray[indexPath.row]
        }else{
            cell.titleLabel.text=data[indexPath.row].title
            cell.idLabel.text="\(data[indexPath.row].id)"
        }
            return cell
        }
        
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //When the user swipes and presses delete, remove the row from our persistece entity
        
        if editingStyle == .delete {

                
                arr.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
           
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingArray=arr.filter{$0.prefix(searchText.count)==searchText}
        searching=true
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController")as?DetailsViewController
        cell?.titleLabel=data[indexPath.row].title
        cell?.idLabel="\(data[indexPath.row].id)"
        
        self.navigationController?.pushViewController(cell!, animated: true)
    }
}
