//
//  ViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/08.
//

import UIKit
import SwiftUI
import Charts

class MondaiViewController: UIViewController {
    //var chartView: LineChartView!
    //var chartDataSet: LineChartDataSet!
    @IBOutlet var mondai:UILabel!
    @IBOutlet var kotae:UILabel!
    @IBOutlet weak var label: UILabel!
    var nijoubig:Int!
    var nijousmall:Int!
    var keisuu = [3,7]
    
    private var numberOnScreen: Int = 0
    private var previousNumber: Int = 0
    private var performingMath = false
    private var operation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setStatusBarBackgroundColor(<#T##color: UIColor?##UIColor?#>)
        // Do any additional setup after loading the view.
        //掛け算
        hyouji()
        mondai.text=String(nijoubig)+"×"+String(nijousmall)
        setupView()
        
    }
    @IBAction func shutudai(){
        //ボタン押した時ランダムに式
        switch Int.random(in:1..<2){
        case 1:
            //掛け算
            hyouji()
            mondai.text=String(nijoubig)+"×"+String(nijousmall)
            kotae.text=String(nijoubig*nijousmall)
        case 2:
            //累乗
            let basic=Int.random(in:1..<7)
            let over=Int.random(in:1..<6)
            mondai.text=String(basic)+"^"+String(over)
            kotae.text=String(ruijou(kisuu:basic,shisuu:over))
        case 3:
            let timing=Int.random(in:60..<600)
            mondai.text=String(timing)+"秒"
            kotae.text=String(timing/60)+"分"+String(timing%60)+"秒"
            break
            // mondai.text=String(keisuu[item])
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
    
    
    
    private func setupView() {
        label.text = ""
    }
    
    //各ボタンが押された時の処理
    @IBAction func showNumber(_ sender: UIButton) {
        if performingMath == true {
            label.text = String(sender.tag - 1)
            numberOnScreen = Int(label.text!)!
            performingMath = false
        }else {
            label.text = label.text! + String(sender.tag - 1)
            numberOnScreen = Int(label.text!)!
        }
        
    }
    
    //各計算ボタンが押された時の処理
    @IBAction func calcAction(_ sender: UIButton) {
        if sender.tag != 11 && sender.tag != 14 {
            previousNumber = Int(label.text!)!
            //labelに表示する文字を決める
            switch(sender.tag) {
            case 12:
                label.text = "."
            case 13:
                label.text = "−"
            default:
                break
            }
            operation = sender.tag
            performingMath = true
        }else if sender.tag == 14 {
            //計算ボタン(Enter)が押された時の処理
            switch(operation) {
            case 12:
                label.text = String(previousNumber / numberOnScreen)
            case 13:
                label.text = String(previousNumber * numberOnScreen)
                default:
                break
            }
        }else if sender.tag == 11 {
            //(Delete)が押されたら全てを初期値に戻す
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
}
