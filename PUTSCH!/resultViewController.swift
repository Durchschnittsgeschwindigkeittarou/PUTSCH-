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
        let resultsippai = allresult-resultseikai
        let clearScore = clearTime+1000*resultsippai
        setStatusBarBackgroundColor(.tintColor)
        seikai.text = String(resultseikai)
        sippai.text = String(resultsippai)
        if clearTime<600{
            ranking.text=String(format: "%01d", clearTime/60)+":"+String(format: "%02d", clearTime%60)
        }else{
            ranking.text="9:59"
        }
        if leaderboard.firstPlace[field]>clearScore{
            leaderboard.firstPlace[field] = clearScore
        }else if leaderboard.secondPlace[field]>clearScore{
            leaderboard.secondPlace[field] = clearScore
        }else if leaderboard.thirdPlace[field]>clearScore{
            leaderboard.thirdPlace[field] = clearScore
        }
        //以下のstringの正解数のところにある自然数はallmondaiと同じ。
        let eins="\((leaderboard.firstPlace[field]%1000)/60):"+String(format: "%02d", (leaderboard.firstPlace[field]%1000)%60)+"　正解数\(5-leaderboard.firstPlace[field]/1000)"
        let zwei="\((leaderboard.secondPlace[field]%1000)/60):"+String(format: "%02d",(leaderboard.secondPlace[field]%1000)%60)+"　正解数\(5-leaderboard.secondPlace[field]/1000)"
        let drei="\((leaderboard.thirdPlace[field]%1000)/60):"+String(format: "%02d",(leaderboard.thirdPlace[field]%1000)%60)+"　正解数\(5-leaderboard.thirdPlace[field]/1000)"
        record.text="これまでの記録\n1."+eins+"\n2."+zwei+"\n3."+drei
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
