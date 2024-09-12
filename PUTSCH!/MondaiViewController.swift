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
    var ransuu = [Int]()
//    var conversion=[Int]()
    
    private var numberOnScreen: Float = 0
    //private var numberOnScreen = [Float]()
    private var numberOfAnswer = [Float]()
    private var numberOfHold=[Float]()
    private var operation = 0
    private var shosuHantei = false
    private var shosuKurai:Int = 0
    
    var outputValueOne:Int?
    var outputValueTwo:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        //        setStatusBarBackgroundColor(<#T##color: UIColor?##UIColor?#>)
        // Do any additional setup after loading the view.
        //出題
        shutudai()
        //mondai.text=String(nijoubig)+"×"+String(nijousmall)
        setupView()
        
    }
    func shutudai(){
        //ボタン押した時ランダムに式
        switch Int.random(in:outputValueOne!..<outputValueTwo!){
        case 1:
            //足し算
            randomNumber(abc: 2, underline: 1, upline: 1000)
            //[0]足される数、[1]足す数
            mondai.text=String(ransuu[0])+"+"+String(ransuu[1])
            numberOfAnswer+=[Float(ransuu[0]+ransuu[1])]
        case 2:
            //引き算
            randomNumber(abc: 2, underline: 1, upline: 1000)
            //[0]引かれる数、[1]引く数
            mondai.text=String(ransuu[0]+ransuu[1])+"-"+String(ransuu[0])
            numberOfAnswer=[Float(ransuu[1])]
        case 3:
            //掛け算(２乗の差)
            let randombig=Int.random(in:3..<10)*10
            let randomsmall=Int.random(in:1..<4)
            mondai.text=String(randombig+randomsmall)+"×"+String(randombig-randomsmall)
            numberOfAnswer=[Float((randombig+randomsmall)*(randombig-randomsmall))]
        case 4:
            //割り算
            randomNumber(abc: 2, underline: 1, upline: 100)
            //[0]割られる数、[1]割る数
            mondai.text=String(ransuu[0]*ransuu[1])+"÷"+String(ransuu[0])
            numberOfAnswer=[Float(ransuu[1])]
        case 5:
            //一元一次方程式（＋）
            let itigenOne=Int.random(in:3..<10)
            let itigenTwo=Int.random(in:1..<10)
            let itigenX=Int.random(in:1..<100)
            mondai.text=String(itigenOne)+"x+"+String(itigenTwo)+"="+String(itigenOne*itigenX+itigenTwo)+"\nx=??";
            numberOfAnswer=[Float(itigenX)]
        case 6:
            //一元一次方程式（-）
            let itigenOne=Int.random(in:3..<10)
            let itigenTwo=Int.random(in:1..<10)
            let itigenX=Int.random(in:1..<100)
            mondai.text=String(itigenOne)+"x-"+String(itigenTwo)+"="+String(itigenOne*itigenX-itigenTwo)+"\nx=??";
            numberOfAnswer=[Float(itigenX)]
        case 7:
            //連立方程式(1)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
            let renritsuAnswer2=renritsuThree*ransuu[1]+ransuu[2]*renritsuR*ransuu[3]
            mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x+\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
            numberOfAnswer=[Float(ransuu[1])]
        case 8:
            //連立方程式(2)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
            let renritsuAnswer2=renritsuThree*ransuu[1]-ransuu[2]*renritsuR*ransuu[3]
            mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x-\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
            numberOfAnswer=[Float(ransuu[1])]
        case 9:
            //連立方程式(3)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
            let renritsuAnswer2=renritsuThree*ransuu[1]+ransuu[2]*renritsuR*ransuu[3]
            mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x+\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
            numberOfAnswer=[Float(ransuu[1])]
        case 10:
            //連立方程式(4)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
            let renritsuAnswer2=renritsuThree*ransuu[1]-ransuu[2]*renritsuR*ransuu[3]
            mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x-\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
            numberOfAnswer=[Float(ransuu[1])]
        case 11:
            //連立方程式(5)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
            let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]+renritsuThree*ransuu[3]
            mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x+\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
            numberOfAnswer=[Float(ransuu[3])]
        case 12:
            //連立方程式(6)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
            let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]-renritsuThree*ransuu[3]
            mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x-\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
            numberOfAnswer=[Float(ransuu[3])]
        case 13:
            //連立方程式(7)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
            let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]+renritsuThree*ransuu[3]
            mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x+\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
            numberOfAnswer=[Float(ransuu[3])]
        case 14:
            //連立方程式(8)
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
            let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]-renritsuThree*ransuu[3]
            mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x-\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
            numberOfAnswer=[Float(ransuu[3])]
        case 15:
            //比例
            randomNumber(abc: 2, underline: 5, upline: 40)
            mondai.text="yはxに比例し、x＝\(ransuu[0])の時y＝\(ransuu[0]*ransuu[1])\ny=??x"
            numberOfAnswer=[Float(ransuu[1])]
        case 16:
            //反比例
            randomNumber(abc: 2, underline: 5, upline: 30)
            mondai.text="yはxに反比例し、x＝\(ransuu[0])の時y＝\(ransuu[0]*ransuu[1]/ransuu[0])\ny=??/x"
            numberOfAnswer=[Float(ransuu[0]*ransuu[1])]
        case 17:
            //累乗
            let basic=Int.random(in:1..<7)
            let over=Int.random(in:1..<6)
            mondai.text=String(basic)+"^"+String(over)
            numberOfAnswer=[Float(ruijou(kisuu:basic,shisuu:over))]
        case 99:
            let timing=Int.random(in:60..<600)
            mondai.text=String(timing)+"秒 (作成中。表示されている秒数そのまま入力して)"
            numberOfAnswer=[Float(timing)]
            break
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
    /// 最大公約数 GCD(greatest common divisor)
    func gcd(_ a : Int, _ b : Int) -> Int {
        var a = a
        var b = b
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return abs(a)
    }
    /// 最小公倍数 LCM(lowest common multiple)
    func lcm(_ a : Int, _ b : Int) -> Int {
        return (a / gcd(a, b)) * b
    }
    func randomNumber(abc:Int,underline:Int,upline:Int){
        for i in 0..<abc {
            ransuu.insert(Int.random(in:underline..<upline),at: i)
        }
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
    
    func input(){
        
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
        }else if sender.tag == 11 {
            //(Delete)が押されたら全てを初期値に戻す
                label.text = ""
                numberOnScreen = 0
                operation = 0
        }
        else if sender.tag == 14 {
            //計算ボタン(Enter)が押された時の処理
            switch(operation) {
            case 12:
                numberOnScreen=numberOnScreen/Float(ruijou(kisuu: 10, shisuu: shosuKurai))
            case 13:
                numberOnScreen = Float(-numberOnScreen)
            default:break
            }
            numberOfHold+=[numberOnScreen]
            //プレイヤーの解答入力数と模範解答数を比較
            if numberOfHold.count == numberOfAnswer.count{//全部解答
                var correct: Int=0
                for i in 0..<numberOfAnswer.count{
                    if numberOfHold[i]==numberOfAnswer[i]{
                        correct+=1
                    }
                }
                
                if correct==numberOfAnswer.count{
                    //正解したら
                    mondai.text="正解"
                    view.backgroundColor = UIColor(hex: "b4f5ff")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        //（ここに遅延させたい命令を書きます。(func)、このDispatchQueueが入るfunc以外で定義されたラベル名などをここに書く場合は、先頭にself.が必要です。）
                        self.label.text = ""
                        self.numberOnScreen = 0
                        self.operation = 0
                        self.numberOfHold=[]
                        self.shutudai()
                        self.view.backgroundColor = UIColor.systemBackground
                    }
                    
                }else{
                    //不正解だと
                    //mondai.text=String(numberOfAnswer)+"チガウヨー"
                    mondai.text="チガウヨー"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        //（ここに遅延させたい命令を書きます。(func)、このDispatchQueueが入るfunc以外で定義されたラベル名などをここに書く場合は、先頭にself.が必要です。）
                        self.label.text = ""
                        self.numberOnScreen = 0
                        self.operation = 0
                        self.numberOfHold=[]
                        self.shutudai()
                        self.view.backgroundColor = UIColor.systemBackground
                    }
                }
            }else{//解答数未了
                label.text = ""
                numberOnScreen = 0
                operation = 0
            }
        }
    }
}

