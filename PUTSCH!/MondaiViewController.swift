//
//  ViewController.swift
//  PUTSCH!
//
//  Created by clark on 2024/05/08.
//

import UIKit
import SwiftUI

class MondaiViewController: UIViewController {
    @IBOutlet var mondai:UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var nanmonme: UILabel!
    var nijoubig:Int!
    var nijousmall:Int!
    var ransuu = [Int]()
    var ransuuSecond=[Int]()
    
    private var answering = false
    private var numberOnScreen: Float = 0
    private var questionNumber: Int = 0
    private var numberOfAnswer = [Float]()
    private var numberOfHold=[Float]()
    private var operation = 0
    private var shosuHantei = false
    private var shosuKurai:Int = 0
    private var shisuu:[String]=["⁰","¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","¹⁰","¹¹","¹²","¹³","¹⁴","¹⁵","¹⁶","¹⁷","¹⁸","¹⁹","²⁰"]
    private var shita:[String]=["₀","₁","₂","₃","₄","₅","₆","₇","₈","₉","₁₀","₁₁","₁₂","₁₃","₁₄","₁₅","₁₆","₁₇","₁₈","₁₉","₂₀"]
    private var enzankigoh:[String] = ["+","-","×","÷"]
    private var time:Int = 0
    private var timer:Timer = Timer()
    
    var outputValue:Int?
    public var seikaiCount:Int = 0
    let delaySecond=1.5
    let allmondai=3 //デバッグするたびに10問も答えてられるか！
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarBackgroundColor(.tintColor)
        // Do any additional setup after loading the view.
        //出題
               Timer.scheduledTimer(
                        withTimeInterval: 1.0,
                        repeats: true
                    ) { _ in
                        self.time = self.time+1
                    }
        questionNumber=1
        shutudai(choise:outputValue!)
        setupView()
        
    }
    func shutudai(choise:Int){
        nanmonme.text="\(questionNumber)/\(allmondai)"
        //ボタン押した時ランダムに式
        switch choise {
        case 01:
            //足し算
            randomNumber(abc: 2, underline: 1, upline: 51)
            //[0]足される数、[1]足す数
            mondai.text=String(ransuu[0])+"+"+String(ransuu[1])
            numberOfAnswer+=[Float(ransuu[0]+ransuu[1])]
        case 02:
            //引き算
            randomNumber(abc: 2, underline: 1, upline: 500)
            //[0]引かれる数、[1]引く数
            mondai.text=String(ransuu[0]+ransuu[1])+"-"+String(ransuu[0])
            numberOfAnswer=[Float(ransuu[1])]
        case 03:
            //掛け算(２乗の差)
            let randombig=Int.random(in:1..<6)*10
            let randomsmall=Int.random(in:1..<10)
            mondai.text=String(randombig+randomsmall)+"×"+String(randombig-randomsmall)
            numberOfAnswer=[Float((randombig+randomsmall)*(randombig-randomsmall))]
        case 04:
            //割り算
            randomNumber(abc: 2, underline: 1, upline: 75)
            //[0]割られる数、[1]割る数
            mondai.text=String(ransuu[0]*ransuu[1])+"÷"+String(ransuu[0])
            numberOfAnswer=[Float(ransuu[1])]
        case 05:
            //四則混合（５項）
            let kousuu = Int.random(in: 3..<6)
            randomNumber(abc: kousuu, underline: 1, upline: 15)
            randomNumberSecond(abc: kousuu-1, underline: 0, upline: 4)
            for i in 0..<kousuu-1{
                if ransuuSecond[i]==3{
                    ransuu[warizankenshou(enzankou: i)]=ransuu[warizankenshou(enzankou: i)]*ransuu[i+1]
                }
            }
            //mondai.text="\(ransuu[0])\(enzankigoh[ransuuSecond[0]])\(ransuu[1])\(enzankigoh[ransuuSecond[1]])\(ransuu[2])\(enzankigoh[ransuuSecond[2]])\(ransuu[3])\(enzankigoh[ransuuSecond[3]])\(ransuu[4])=?"
            mondai.text="\(ransuu[0])"
            for i in 0..<kousuu-1{
                mondai.text=mondai.text!+"\(enzankigoh[ransuuSecond[i]])\(ransuu[i+1])"
            }
            mondai.text=mondai.text!+"=?"
            kakewarikeisan()
            ransuu.removeAll(where: { (value) in // removeAllメソッドの引数whereにクロージャを指定することで、条件に一致する要素を削除する
                value == 27
            })
            ransuuSecond.removeAll(where: { (value) in
                value == 27
            })
            minuslize()
            numberOfAnswer = [Float(ransuu.reduce(0, +))]
        case 06:
            shutudai(choise: Int.random(in:1...4))
        case 07:
            let itigenOne=Int.random(in:3..<10)
            let itigenTwo=Int.random(in:1..<10)
            let itigenX=Int.random(in:1..<100)
            numberOfAnswer=[Float(itigenX)]
            switch Int.random(in: 1...2){
            case 1:
                //一元一次方程式（＋）
                mondai.text=String(itigenOne)+"x+"+String(itigenTwo)+"="+String(itigenOne*itigenX+itigenTwo)+"\nx=??";
            case 2:
                //一元一次方程式（-）
                mondai.text=String(itigenOne)+"x-"+String(itigenTwo)+"="+String(itigenOne*itigenX-itigenTwo)+"\nx=??";
            default:break;
            }
        case 08:
            randomNumber(abc: 4, underline: 1, upline: 16)
            let renritsuR=Int.random(in: 1..<6)
            let renritsuThree=Int.random(in: ransuu[0]..<20)
            switch Int.random(in: 1...8){
            case 1:
                let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
                let renritsuAnswer2=renritsuThree*ransuu[1]+ransuu[2]*renritsuR*ransuu[3]
                mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x+\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
                numberOfAnswer=[Float(ransuu[1])]
            case 2:
                let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
                let renritsuAnswer2=renritsuThree*ransuu[1]-ransuu[2]*renritsuR*ransuu[3]
                mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x-\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
                numberOfAnswer=[Float(ransuu[1])]
            case 3:
                let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
                let renritsuAnswer2=renritsuThree*ransuu[1]+ransuu[2]*renritsuR*ransuu[3]
                mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x+\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
                numberOfAnswer=[Float(ransuu[1])]
            case 4:
                let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
                let renritsuAnswer2=renritsuThree*ransuu[1]-ransuu[2]*renritsuR*ransuu[3]
                mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(renritsuThree)x-\(ransuu[2]*renritsuR)y=\(renritsuAnswer2)\nx=??"
                numberOfAnswer=[Float(ransuu[1])]
            case 5:
                let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
                let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]+renritsuThree*ransuu[3]
                mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x+\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
                numberOfAnswer=[Float(ransuu[3])]
            case 6:
                let renritsuAnswer1=ransuu[0]*ransuu[1]+ransuu[2]*ransuu[3]
                let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]-renritsuThree*ransuu[3]
                mondai.text="\(ransuu[0])x+\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x-\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
                numberOfAnswer=[Float(ransuu[3])]
            case 7:
                let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
                let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]+renritsuThree*ransuu[3]
                mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x+\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
                numberOfAnswer=[Float(ransuu[3])]
            case 8:
                let renritsuAnswer1=ransuu[0]*ransuu[1]-ransuu[2]*ransuu[3]
                let renritsuAnswer2=ransuu[0]*renritsuR*ransuu[1]-renritsuThree*ransuu[3]
                mondai.text="\(ransuu[0])x-\(ransuu[2])y=\(renritsuAnswer1)\n\(ransuu[0]*renritsuR)x-\(renritsuThree)y=\(renritsuAnswer2)\ny=??"
                numberOfAnswer=[Float(ransuu[3])]
            default:break;
            }
        case 09:
            switch Int.random(in: 1...2){
            case 1:
                //比例
                randomNumber(abc: 2, underline: 5, upline: 40)
                mondai.text="yはxに比例し、x＝\(ransuu[0])の時y＝\(ransuu[0]*ransuu[1])\ny=??x"
                numberOfAnswer=[Float(ransuu[1])]
            case 2:
                //反比例
                randomNumber(abc: 2, underline: 5, upline: 30)
                mondai.text="yはxに反比例し、x＝\(ransuu[0])の時y＝\(ransuu[0]*ransuu[1]/ransuu[0])\ny=??/x"
                numberOfAnswer=[Float(ransuu[0]*ransuu[1])]
            default:break;
            }
        case 10:
            //二次方程式
            randomNumber(abc: 2, underline: 3, upline: 100)
            mondai.text="x²-\(ransuu[0]+ransuu[1])x+\(ransuu[0]*ransuu[1])=0\nx=\(ransuu[0])、??"
            numberOfAnswer=[Float(ransuu[1])]
        case 11:
            shutudai(choise: Int.random(in: 07...10))
        case 12:
            let randombig=Int.random(in:3..<10)
            let randomsmall=Int.random(in:1..<randombig+1)
            switch Int.random(in: 1...2){
            case 1:
                //確率（nPr）
                mondai.text="\(String(randombig))個の中から\(String(randomsmall))個取り出して並べるとき、\n並べ方の総数は？\n??通り"
                numberOfAnswer=[Float(kaijou(maxim: randombig)/kaijou(maxim: randombig-randomsmall))]
            case 2:
                //確率（nCr）
                let bunbobunbo=kaijou(maxim: randombig-randomsmall)*kaijou(maxim: randomsmall)
                mondai.text="\(String(randombig))個の中から\(String(randomsmall))個取り出して組み合わせるとき、\n組み合わせ方の総数は？\n??通り"
                numberOfAnswer=[Float(kaijou(maxim: randombig)/bunbobunbo)]
            default:break;
            }
        case 13:
            randomNumber(abc: 3, underline: 2, upline: 7)
            switch Int.random(in: 1...2){
            case 1:
                //等差の和
                let synthesis=2*ransuu[0]+(ransuu[2]-1)*ransuu[1]
                mondai.text="初項が\(String(ransuu[0]))、公差が\(String(ransuu[1]))の等差数列において、\n第\(String(ransuu[2]))項までの総和は？"
                numberOfAnswer=[Float(ransuu[2]*synthesis/2)]
            case 2:
                //等比の和
                //let kagiri=Int.random(in:2..<5)  「n項まで」の部分用乱数。　今のままじゃ難しいのならばransuu[2]をこれに置き換えるべし
                let synthesis=ransuu[0]*ruijou(kisuu: ransuu[1], shisuu: ransuu[2])
                mondai.text="初項が\(String(ransuu[0]))、公比が\(String(ransuu[1]))の等比数列において、\n第\(String(ransuu[2]))項までの総和は？"
                numberOfAnswer=[Float((synthesis-ransuu[0])/(ransuu[1]-1))]
            default:break;
            }
        case 14:
            let vorsitz=Int.random(in:2..<6)
            switch Int.random(in: 1...2){
            case 1:
                //微分 2乗
                    randomNumber(abc: 3, underline: 2, upline: 10)
                    mondai.text="f(x)=\(ransuu[2])x²+\(ransuu[1])x+\(ransuu[0])\nf '(\(vorsitz))=?"
                    bibunjunbi()
                    //dainyu(numbereleven: vorsitz)
                    numberOfAnswer=[Float(ransuu[1]*vorsitz+ransuu[0])]
            case 2:
                //微分 3乗
                    randomNumber(abc: 4, underline: 2, upline: 10)
                    mondai.text="f(x)=\(ransuu[3])x³+\(ransuu[2])x²+\(ransuu[1])x+\(ransuu[0])\nf '(\(vorsitz))=?"
                    bibunjunbi()
                    numberOfAnswer=[Float(ransuu[2]*vorsitz*vorsitz+ransuu[1]*vorsitz+ransuu[0])]
            default:break;
            }
        case 15:
            switch Int.random(in: 1...3){
            case 1:
                //指数(+)
                let OneShisuu=Int.random(in: 0..<20)
                let TwoShisuu=Int.random(in: 0..<20)
                randomNumber(abc: 1, underline: 1, upline: 10)
                mondai.text="\(ransuu[0])\(shisuu[OneShisuu])×\(ransuu[0])\(shisuu[TwoShisuu])の時の指数は？"
                numberOfAnswer=[Float(OneShisuu+TwoShisuu)]
            case 2:
                //指数(-)
                let OneShisuu=Int.random(in: 5..<20)
                let TwoShisuu=Int.random(in: 0..<OneShisuu)
                randomNumber(abc: 1, underline: 1, upline: 10)
                mondai.text="\(ransuu[0])\(shisuu[OneShisuu])÷\(ransuu[0])\(shisuu[TwoShisuu])の時の指数は？"
                numberOfAnswer=[Float(OneShisuu-TwoShisuu)]
            case 3:
                //指数(*)
                let OneShisuu=Int.random(in: 0..<20)
                let TwoShisuu=Int.random(in: 0..<20)
                randomNumber(abc: 1, underline: 1, upline: 10)
                mondai.text="(\(ransuu[0])\(shisuu[OneShisuu]))\(shisuu[TwoShisuu])の時の指数は？"
                numberOfAnswer=[Float(OneShisuu*TwoShisuu)]
            default:break;
            }
        case 16:
            shutudai(choise: Int.random(in: 21...24))
        case 17: //積分
            randomNumber(abc: 3, underline: 2, upline: 10)
            let vorn=Int.random(in:1..<6)
            let unten=Int.random(in:0..<vorn)
            mondai.text=shisuu[vorn]+"∫ "+String(ransuu[2])+"x²+"+String(ransuu[1])+"x+"+String(ransuu[0])+" dx\n"+shisuu[unten]+" 　　　　　x=?\n（分子→分母の順に入力）"
            sekibunjunbi()
            dainyu(numbereleven: vorn,numbertwelve: unten)
            let bunshi=6*ransuu[1]+3*ransuu[2]+2*ransuu[3]
            let yakubun=gcd(bunshi, 6)
            numberOfAnswer=[Float(bunshi/yakubun),Float(6/yakubun)]
        case 29:
            //累乗
            let basic=Int.random(in:1..<7)
            let over=Int.random(in:1..<6)
            mondai.text=String(basic)+"^"+String(over)
            numberOfAnswer=[Float(ruijou(kisuu:basic,shisuu:over))]
        case 102:
            //比例(比)
            randomNumber(abc: 3, underline: 1, upline: 20)
            let ratio=Int.random(in:2..<9)
            switch Int.random(in:1..<5){
            case 1:
                mondai.text="x:"+String(ransuu[1])+"="+String(ransuu[0]*ratio)+":"+String(ransuu[1]*ratio)+"\nx=?"
                numberOfAnswer=[Float(ransuu[0])]
            case 2:
                mondai.text=String(ransuu[0])+":x="+String(ransuu[0]*ratio)+":"+String(ransuu[1]*ratio)+"\n=x?"
                numberOfAnswer=[Float(ransuu[1])]
            case 3:
                mondai.text=String(ransuu[0])+":"+String(ransuu[1])+"=x:"+String(ransuu[1]*ratio)+"\n=x?"
                numberOfAnswer=[Float(ransuu[0]*ratio)]
            case 4:
                mondai.text=String(ransuu[0])+":"+String(ransuu[1])+"="+String(ransuu[0]*ratio)+":x"+"\n=x?"
                numberOfAnswer=[Float(ransuu[1]*ratio)]
            default:break
            }
        case 99:
            let timing=Int.random(in:60..<600)
            mondai.text=String(timing)+"秒 (作成中。表示されている秒数そのまま入力して)"
            numberOfAnswer=[Float(timing)]
        case 101:
            randomNumber(abc: 3, underline: 2, upline: 10)
            let schale=Int.random(in:2..<6)
            mondai.text=String(ransuu[2])+"x^2+"+String(ransuu[1])+"x+"+String(ransuu[0])+"\nx="+String(schale)
            dainyu(numbereleven: schale)
            numberOfAnswer=[Float(ransuu[0]+ransuu[1]+ransuu[2])]
        case 204:// 平均値
            randomNumber(abc: 5, underline: 1, upline: 15)
            mondai.text="[\(ransuu[0]),\(ransuu[1]),\(ransuu[2]),\(ransuu[3]),\(ransuu[4])]\nの平均値は？"
            let summ = ransuu[0]+ransuu[1]+ransuu[2]+ransuu[3]+ransuu[4]
            numberOfAnswer=[Float(summ)/5]
        case 205:// 中央値
            randomNumber(abc: 5, underline: 1, upline: 15)
            mondai.text="[\(ransuu[0]),\(ransuu[1]),\(ransuu[2]),\(ransuu[3]),\(ransuu[4])]\nの中央値は？"
            ransuu.sort()
            numberOfAnswer=[Float(ransuu[2])]
        case 206://n進数→10進数
            let shinsuu=Int.random(in:2..<10)
            var numbering=Int.random(in: 30..<100)
            numberOfAnswer=[Float(numbering)]
            mondai.text="次の数を10進数に直せ\n"
            var shisuugenkai=1
            while numbering > ruijou(kisuu: shinsuu, shisuu: shisuugenkai){
                shisuugenkai+=1
            }
            for i in 1...shisuugenkai{
                let wunde = ruijou(kisuu: shinsuu, shisuu: shisuugenkai-i)
                mondai.text=mondai.text!+String(numbering/wunde)
                numbering = numbering % wunde
            }
            mondai.text=mondai.text!+" (\(shinsuu))"
        case 207://解と係数の関係(2次)
            randomNumber(abc: 2, underline: 2, upline: 20)
            switch Int.random(in:1...2){
            case 1:
                mondai.text="x²+\(ransuu[1])x+\(ransuu[0])\nの2つの解をα,βとしたとき、α²+β²=?"
                numberOfAnswer=[Float(ransuu[1]*ransuu[1]-2*ransuu[0])]
            case 2:
                mondai.text="x²+\(ransuu[1])x+\(ransuu[0])\nの2つの解をα,βとしたとき、α³+β³=?"
                let mochimochizunda=ransuu[1]*ransuu[1]-3*ransuu[0]
                numberOfAnswer=[Float(ransuu[1]*mochimochizunda)]
            default:break
            }
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
    func randomNumberSecond(abc:Int,underline:Int,upline:Int){
        for i in 0..<abc {
            ransuuSecond.insert(Int.random(in:underline..<upline),at: i)
        }
    }
    func bibunjunbi(){
        for i in 0..<ransuu.count-1{
            ransuu[i]=ransuu[i+1]*(i+1)
        }
        ransuu.removeLast()
    }
    func sekibunjunbi(){
        let mass = ransuu.count
        ransuu+=[0]
        for i in 0..<mass{
            ransuu[mass-i]=ransuu[mass-i-1]
        }
        ransuu[0]=0
    }
    func dainyu(numbereleven:Int,numbertwelve:Int=0){
        for i in 0..<ransuu.count{
            ransuu[i]=ransuu[i]*(ruijou(kisuu: numbereleven, shisuu: i)-ruijou(kisuu: numbertwelve, shisuu: i))
        }
    }
    func kaijou(maxim:Int)->Int{
        if maxim==0{
            return 1
        }
        return maxim*kaijou(maxim: maxim-1)
    }
    func warizankenshou(enzankou:Int)->Int{
        if enzankou==0{
            return 0
        }
        if ransuuSecond[enzankou-1] == 3 {
            return warizankenshou(enzankou: enzankou-1)
        }
        return enzankou
    }
    func kakewarikeisan(){
        let national = ransuuSecond.count
        for i in 0..<national{
            if ransuuSecond[i] == 2 {
                ransuu[i]=ransuu[i]*ransuu[i+1]
            }
            if ransuuSecond[i] == 3 {
                ransuu[i]=ransuu[i]/ransuu[i+1]
            }
            if ransuuSecond[i] == 2 || ransuuSecond[i] == 3{
                ransuu.remove(at:i+1)
                ransuu.insert(27, at: 0)
                ransuuSecond.remove(at:i)
                ransuuSecond.insert(27, at: 0)
            }
        }
    }
    func minuslize(){
        for i in 0..<ransuuSecond.count{
            if ransuuSecond[i] == 1{
                ransuu[i+1] = -1*ransuu[i+1]
            }
        }
    }
    private func setupView() {
        label.text = ""
    }
    
    //各ボタンが押された時の処理
    @IBAction func showNumber(_ sender: UIButton) {
        if answering==false{
            if label.text == "" {
                numberOnScreen=Float(sender.tag-1)
                label.text = String(sender.tag-1)
            }else {
                numberOnScreen=Float(Int(numberOnScreen)*10+sender.tag-1)
                label.text = label.text! + String(sender.tag-1)
            }
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
        }else if sender.tag == 11 {
            //(Delete)が押されたら全てを初期値に戻す
                label.text = ""
                numberOnScreen = 0
                operation = 0
        }
        else if sender.tag == 14 && answering==false {
            answering=true
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
                    seikaiCount=seikaiCount+1
                    resetAction()
                }else{
                    //不正解だと
                    mondai.text="残念"
                    //mondai.text="残念\(numberOfAnswer[0])"
                    //デバッグ時にこれにしとくと便利やもしれん
                    view.backgroundColor = UIColor(hex: "ffb6c1")
                    resetAction()
                }
            }else{//解答数未了
                answering=false
                label.text = ""
                numberOnScreen = 0
                operation = 0
            }
        }//if sender.tag==14
    }//calcAction
    func resetAction(){
        questionNumber=questionNumber+1

        DispatchQueue.global().asyncAfter(deadline: .now() + delaySecond) { [self] in
       // Thread.sleep(forTimeInterval: delaySecond)
            resultif()
        }
        }
    func resultif(){
        if(questionNumber>allmondai){
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let resultpage = storyboard.instantiateViewController(withIdentifier: "resultpage") as? resultViewController {
                    resultpage.resultseikai = self.seikaiCount
                    resultpage.allresult = self.allmondai
                    resultpage.clearTime = self.time
                    resultpage.field=self.outputValue!
                    resultpage.modalTransitionStyle = .crossDissolve
                    resultpage.modalPresentationStyle = .fullScreen
                    self.present(resultpage, animated: false)
                }
            }
        }else{
            //（ここに遅延させたい命令を書きます。(func)、このDispatchQueueが入るfunc以外で定義されたラベル名などをここに書く場合は、先頭にself.が必要です。）
            DispatchQueue.main.async {
                self.label.text = ""
                self.numberOnScreen = 0
                self.operation = 0
                self.numberOfHold=[]
                self.numberOfAnswer=[]
                self.ransuu=[]
                self.ransuuSecond=[]
                self.shosuKurai=0
                self.answering=false
                self.shosuHantei=false
                self.shutudai(choise:self.outputValue!)
                self.view.backgroundColor = UIColor.systemBackground
            }
        }
      }//resultif
    }

