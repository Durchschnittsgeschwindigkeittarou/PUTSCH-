//
//  TitleViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/10/03.
//

import UIKit

class TitleViewController: UIViewController {
    @IBAction func backToFirst(_ segue: UIStoryboardSegue) {
           print("\(segue.identifier!)")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
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
