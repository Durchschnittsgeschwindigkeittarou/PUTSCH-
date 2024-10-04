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
    var resultseikai=0
    var resultsippai=0
    var allresult = 0
    @IBAction func closeAllViewController(_ sender: Any) {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        seikai.text = String(resultseikai)
        sippai.text = String(allresult-resultseikai)
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
