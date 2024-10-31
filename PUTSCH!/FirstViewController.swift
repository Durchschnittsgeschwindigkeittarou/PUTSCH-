//
//  FirstViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/23.
//

import UIKit

class FirstViewController: UIViewController{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toTashizan":
            let next = segue.destination as? MondaiViewController
                        // 3. １で用意した遷移先の変数に値を渡す
                next?.outputValue = 1
        case "toHikizan":
            let next = segue.destination as? MondaiViewController
                next?.outputValue = 2
        case "toKakezan":
            let next = segue.destination as? MondaiViewController
                next?.outputValue = 3
        case "toWarizan":
            let next = segue.destination as? MondaiViewController
                next?.outputValue = 4
        case "toKongou":
            let next = segue.destination as? MondaiViewController
                next?.outputValue = 5
        case "toShisoku":
            let next = segue.destination as? MondaiViewController
                next?.outputValue = 6
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
