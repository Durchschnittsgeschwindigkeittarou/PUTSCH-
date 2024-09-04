//
//  FirstViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/23.
//

import UIKit

class middleViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toItigen":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 5
                next?.outputValueTwo = 6
        case "toRenritsu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 6
                next?.outputValueTwo = 7
        case "toHirei":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 7
                next?.outputValueTwo = 8
        case "toKakuritsu":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 8
                next?.outputValueTwo = 9
        case "toMiddle":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValueOne = 5
                next?.outputValueTwo = 9
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
