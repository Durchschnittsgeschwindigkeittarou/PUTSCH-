//
//  ViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/08.
//

import UIKit
//import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        Path { path in
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addLine(to: CGPoint(x: 200, y: 200))
//      path.move(to: CGPoint(x: 200, y: 0))
//            path.addLine(to: CGPoint(x: 0, y: 200))
//        }
//        .stroke(lineWidth: 5)
//        .fill(Color.red)
//        .frame(width: 200, height: 200)
//    }
//}

class ViewController: UIViewController {
    @IBOutlet var mondai:UILabel!
    @IBOutlet var kotae:UILabel!
    var nijoubig:Int!
    var nijousmall:Int!
    var keisuu = [0]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func shutudai(){
        //ボタン押した時ランダムに式
        switch Int.random(in:1..<3){
        case 1:
            hyouji()
            mondai.text=String(nijoubig)+"*"+String(nijousmall)
            kotae.text=String(nijoubig*nijousmall)
        case 2:
            let bonchi=Int.random(in:1..<10)
            let manji=Int.random(in:1..<6)
            mondai.text=String(bonchi)+"^"+String(manji)
            kotae.text=String(ruijou(kisuu:bonchi,shisuu:manji))
        default:break
        }
    }
    func ruijou(kisuu: Int,shisuu: Int)->Int{
        if shisuu==0 {
            return 1
            //基数、指数の順で入れると累乗ができる
        }
        return kisuu*ruijou(kisuu:kisuu,shisuu:shisuu-1)
    }
    func keta(ketasuu: Int)->Int{
        //桁数を入れるとその桁の乱数が出てくる
       return  Int.random(in: ruijou(kisuu:10,shisuu:ketasuu)..<ruijou(kisuu:10,shisuu:ketasuu)*10)
    }
    func hyouji (){
        let randombig=Int.random(in:1..<10)*100
            let randomsmall=Int.random(in:1..<9)
            nijoubig=randombig+randomsmall
            nijousmall=randombig-randomsmall
        return
    }
    
}

//

