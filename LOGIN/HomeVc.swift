//
//  HomeVc.swift
//  LOGIN
//
//  Created by MAC OS on 10/03/22.
//
import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdetail = UserDetail.getUserFromUserDefault()
        lblName.text = userdetail?.name
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
