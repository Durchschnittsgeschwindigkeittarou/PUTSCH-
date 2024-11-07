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
    @IBOutlet var ranking:UILabel!
    var resultseikai=0
    var allresult = 0
    var clearTime = 0
    var field = 0
    @IBAction func closeAllViewController(_ sender: Any) {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        let leaderboard = UIApplication.shared.delegate as! AppDelegate
        setStatusBarBackgroundColor(.tintColor)
        seikai.text = String(resultseikai)
        sippai.text = String(allresult-resultseikai)
        ranking.text=String(format: "%02d", clearTime/60)+":"+String(format: "%03d", clearTime%60)
        if leaderboard.firstPlace[0]>clearTime{
         leaderboard.firstPlace[field] = clearTime
        }
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
