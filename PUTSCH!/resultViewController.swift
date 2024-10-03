//
//  resultViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/09/26.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet var seikai:UILabel!
    @IBOutlet var sippai:UILabel!
    @IBAction func closeAllViewController(_ sender: Any) {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
