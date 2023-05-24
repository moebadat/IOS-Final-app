//
//  DetailsViewController.swift
//  Models
//
//  Created by DA MAC M1 144 on 2023/05/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var detailsIdLabel: UILabel!
    
    var idLabel:String?
    var titleLabel:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsIdLabel.text=idLabel
        detailsTitleLabel.text=titleLabel

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
