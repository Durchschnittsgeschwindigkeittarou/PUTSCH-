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
    @IBOutlet var record:UILabel!
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
        if clearTime<1800{
            ranking.text=String(format: "%01d", clearTime/60)+":"+String(format: "%02d", clearTime%60)
        }else{
            ranking.text="9:59"
        }
        if leaderboard.firstPlace[field]>clearTime{
            leaderboard.firstPlace[field] = clearTime
        }else if leaderboard.secondPlace[field]>clearTime{
            leaderboard.secondPlace[field] = clearTime
        }else if leaderboard.thirdPlace[field]>clearTime{
            leaderboard.thirdPlace[field] = clearTime
        }
        record.text="これまでの記録\n1."+String(format: "%01d", leaderboard.firstPlace[field]/60)+":"+String(format: "%02d", leaderboard.firstPlace[field]%60)+"\n2."+String(format: "%01d", leaderboard.secondPlace[field]/60)+":"+String(format: "%02d", leaderboard.secondPlace[field]%60)+"\n3."+String(format: "%01d", leaderboard.thirdPlace[field]/60)+":"+String(format: "%02d", leaderboard.thirdPlace[field]%60)
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
