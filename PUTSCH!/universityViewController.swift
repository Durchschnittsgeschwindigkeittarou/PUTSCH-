//
//  FirstViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/23.
//

import UIKit

class universityViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toSekibun":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValue = 17
        case "toShinsu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValue = 18
        case "toKankei":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValue = 19
        case "toGyouretsu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValue = 20
        case "toUniversity":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValue = 21
        default:break;
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
