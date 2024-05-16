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
        switch Int.random(in:1..<3){
        case 1:hyouji()
            mondai.text=String(nijoubig)+"*"+String(nijousmall)
            kotae.text=String(nijoubig*nijousmall)
        case 2:keisuu=[2]
        default:break
        }
    }
    func ruijou(kisuu: Int,shisuu: Int)->Int{
        if shisuu==0 {
            return 1
        }
        return kisuu*ruijou(kisuu:kisuu,shisuu:shisuu-1)
    }
    func keta(ketasuu: Int)->Int{
        //var jijiji=ruijou(kisuu:10,shisuu:ketasuu)
       return  Int.random(in: ruijou(kisuu:10,shisuu:ketasuu)..<10)
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

