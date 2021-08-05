//
//  HomeViewController.swift
//  LoginSample
//
//  Created by Siya Dagwar on 05/08/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.title = "Home"
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
}
