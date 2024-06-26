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
    @IBOutlet weak var label: UILabel!
    var nijoubig:Int!
    var nijousmall:Int!
    var keisuu = [3,7]
    
    private var numberOnScreen: Float = 0
    private var numberOfDecide:Float=0
    private var numberOfAnswer: Float = 0
    private var operation = 0
    private var shosuHantei = false
    private var shosuKurai:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setStatusBarBackgroundColor(<#T##color: UIColor?##UIColor?#>)
        // Do any additional setup after loading the view.
        //掛け算
        shutudai()
        //mondai.text=String(nijoubig)+"×"+String(nijousmall)
        setupView()
        
    }
    func shutudai(){
        //ボタン押した時ランダムに式
        switch Int.random(in:1..<5){
        case 1:
            //掛け算
            let randombig=Int.random(in:1..<10)*10
            let randomsmall=Int.random(in:1..<4)
            mondai.text=String(randombig+randomsmall)+"×"+String(randombig-randomsmall)
            //kotae.text=String(randombig^2-randomsmall^2)
            numberOfAnswer=Float((randombig+randomsmall)*(randombig-randomsmall))
        case 2:
            //累乗
            let basic=Int.random(in:1..<7)
            let over=Int.random(in:1..<6)
            mondai.text=String(basic)+"^"+String(over)
            numberOfAnswer=Float(ruijou(kisuu:basic,shisuu:over))
        case 3:
            let timing=Int.random(in:60..<600)
            mondai.text=String(timing)+"秒 (作成中。表示されている秒数そのまま入力して)"
            numberOfAnswer=Float(timing)
            break
        case 4:
            let warizanOne=Int.random(in:1..<10)
            let warizanTwo=Int.random(in:1..<10)
            mondai.text=String(warizanOne*warizanTwo)+"÷"+String(warizanOne)
            numberOfAnswer=Float(warizanTwo)
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
    
    
    
    private func setupView() {
        label.text = ""
    }
    
    //各ボタンが押された時の処理
    @IBAction func showNumber(_ sender: UIButton) {
        if label.text == "" {
            numberOnScreen=Float(sender.tag-1)
            label.text = String(sender.tag-1)
        }else {
            numberOnScreen=Float(Int(numberOnScreen)*10+sender.tag-1)
            label.text = label.text! + String(sender.tag-1)
        }
        if shosuHantei==true{
            shosuKurai=shosuKurai+1
        }
    }
    
    //各計算ボタンが押された時の処理
    @IBAction func calcAction(_ sender: UIButton) {
        if sender.tag == 13 && label.text=="" {
            //labelに表示する文字を決める
                    label.text="-"
            operation = sender.tag
        }else if sender.tag == 12{
            label.text=label.text!+"."
            shosuHantei=true
            operation = sender.tag
        }
        else if sender.tag == 14 {
            //計算ボタン(Enter)が押された時の処理
            switch(operation) {
            case 12:
                numberOfDecide=numberOnScreen/Float(ruijou(kisuu: 10, shisuu: shosuKurai))
            case 13:
                numberOfDecide = Float(-numberOnScreen)
            default:numberOfDecide = Float(numberOnScreen)
            break
            }
            if numberOfDecide==numberOfAnswer{
                mondai.text="ウニ"
            }else{
                mondai.text=String(numberOfDecide)+"チガウヨー"
            }
        }else if sender.tag == 11 {
            //(Delete)が押されたら全てを初期値に戻す
            label.text = ""
            numberOnScreen = 0
            operation = 0
            shosuHantei=false
            shosuKurai=0
        }
    }
}
