//
//  FirstViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/23.
//

import UIKit

class highViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toKakuritsu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 18
                next?.outputValueTwo = 20
        case "toSuuretsu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 20
                next?.outputValueTwo = 22
        case "toBibunn":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 22
                next?.outputValueTwo = 24
        case "toShisuu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 24
                next?.outputValueTwo = 27
        case "toHigh":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 5
                next?.outputValueTwo = 18
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
