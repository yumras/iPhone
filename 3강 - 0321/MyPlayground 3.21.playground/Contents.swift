//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


print("\n") // 줄바꿈

print("------  함수 설명 (입출력 없는 기본형태)-----")
func showHello1(){
    print("Hello")
}
showHello1()

print("\n-------------------------------------------------------------\n")

print("------  함수 설명 (입력만 있는 형태)-----")
func showHello2(name:Int) {
    
    let message = "\(name)씨 안녕하세요!"
    print(message)
}

showHello2(name: 503)

print("\n-------------------------------------------------------------\n")
print("------  함수 설명 (출력만 있는 형태)-----")
func showHello3() -> String {
    
    let name = "OOO"
    
    return "\(name)씨 안녕하세요!"
}

let msgFromFunction = showHello3()
print(msgFromFunction)

print("\n-------------------------------------------------------------\n")
print("------  함수 설명 (입출력이 모두 있는 형태)-----")
func showHello4(name:String) -> String {
    
    
    return "\(name)씨 안녕하세요!"
}
// let aaa = showHello4(name:"홍길동"); print(aaa)
print(showHello4(name:"박병호"))


print("\n-----------------------연습문제 1-1-----------------------------\n")
func myAdd1(a:Int, b:Int) -> Int {
    return a+b
}
print("합은",myAdd1(a: 3, b: 2),"입니다")

print("\n-----------------------연습문제 1-2-----------------------------\n")
func myAdd2(a:Int, b:Int) {
    print("\(a+b)")
}
myAdd2(a: 3, b: 2)

print("\n-----------------------연습문제 2-----------------------------\n")

func pibonaci(a:Int, b:Int) -> Int{
    var result = 0
    for i in a...b{
        result += i
    }
    return result
}
print(pibonaci(a: 0, b: 15))



print("\n-----------------------연습문제 끝-----------------------------\n")




print("------  함수 설명 (입력 파라미터가 복수인 경우)-----\n")
func calcBMI(name:String, height:Double, weight:Double){
    let heightM  = height / 100.0
    let BMI:Double = weight / (heightM * heightM)
    print("\(name)의 BMI는 \(BMI)입니다.")
}

calcBMI(name:"홍길동", height:176.0, weight:53.0)

print("\n-------------------------------------------------------------\n")

print("------  Swap 함수 -----\n")
// swap 함수 구현하기 call by value
func myswap(a:Int, b:Int)->(Int,Int){
    print("my swap function called")
    
    return (b,a)
}
var a=1
var b=2

(a,b) = myswap(a: a, b: b)
print("a=\(a), b=\(b)") // changed

// swap 함수 구현하기 call by reference
//swap(&a, &b) // https://developer.apple.com/documentation/swift/1540890-swap
//print("a=\(a), b=\(b)") // changed

print("\n-------------------------------------------------------------\n")


print("------  재귀 함수 설명 (1~100합)-----\n")

func recursiveCall(n:Int)->Int{
    //print("recursiveCall received \(n)")
    if ( n == 0){
        return 0
    }else if ( n >= 100 ){
        return 100
    }else{
        return n + recursiveCall(n: n+1)
    }
}

var recursiveResult = recursiveCall(n:1)
print(recursiveResult)

func recursiveCall1(n:Int)->Int{
    //print("recursiveCall1 received \(n)")
    if ( n >= 100 ){
        return 100
    }else{
        return n + recursiveCall1(n: n+1)
    }
}

var recursiveResult1 = recursiveCall1(n:1)
print(recursiveResult1)

print("\n-----------------------연습문제 3-----------------------------\n")
//재귀함수 5!
func factorial(n:Int) -> Int{
    if(n==1){
        return 1
    } else {
        return n * factorial(n: n-1)
    }
}

var factorialResult = factorial(n: 5)
print(factorialResult)

print("\n-----------------------연습문제 4-----------------------------\n")

func recursiveCall2(start:Int, end:Int) -> Int{
    if (start >= end){
        return end
    } else {
        return start + recursiveCall2(start: start+1, end: end)
    }
}

var recursieResult2 = recursiveCall2(start: 100, end:200)
print(recursieResult2)

print("\n-----------------------연습문제 6-----------------------------\n")
//피보나치 수열

func fibo(n:Int)->Int {
    if( n <= 0){
        return 0
    } else if(n == 1){
        return 1
    } else {
        return fibo(n:n-1) + fibo(n:n-2)
    }
}
var fiboResult = fibo(n: 10)
print(fiboResult)
//피보나치 수열
// 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6755 10946 값 ...
// 1 2 3 4 5 6 7  8  9  10 11 12  13  14  15  16  17   18   19   20   21    번째...

print("\n-------------------------------------------------------------\n")
class CalcPrice {
    var price:Double = 0
    
    func getTax() -> Double {
        return price * 0.1
    }
    
    func getExcludingTax() -> Double {
        return price - getTax()
    }
}

let apple = CalcPrice()
apple.price = 3000
print("가격은 \(apple.price)원")
print("부가가치세는 \(apple.getTax())원")
print("부가가치세를 제외한 가격은 \(apple.getExcludingTax())원")

print("\n------  클래스 -----\n")

class Car  {
    
    var number:String
    var Color:String
    var maxSpeed:Int
    var type:String
    var distance:Double
    var fuelGauge:Double
    
    init() {
        self.number = "0000"
        self.Color = "white"
        self.maxSpeed = 300
        self.type = "SUV"
        self.fuelGauge = 0
        self.distance = 0
    }
    
    func increaseDistance(dist:Double){
        self.distance += dist
    }
    
    func putFuel(fuel:Double){
        self.fuelGauge += fuel
    }
    
    func getFuelEfficiency() -> Double{
        return distance / fuelGauge
    }
}

let myCar = Car()
myCar.increaseDistance(dist: 100)
myCar.putFuel(fuel: 10)

print("\(myCar.getFuelEfficiency()) Km/l")



print("\n------  클래스 상속 -----\n")

class Santafe : Car{
    
    override init() {
        super.init() // must call
        self.Color = "Black"
    }
    
    override func putFuel(fuel: Double) {
        self.fuelGauge = (self.fuelGauge + fuel) * 0.8
    }
}

let mySantafe = Santafe()
mySantafe.increaseDistance(dist: 100)
mySantafe.putFuel(fuel: 10)
print("\(mySantafe.getFuelEfficiency()) Km/l")

print("\n-------------------------------------------------------------\n")

class Porche : Car{
    
    var gear:Double
    
    override init() {
        super.init()
        self.Color = "Red"
        self.maxSpeed = 500
        self.type = "Sports Car"
    }
    
    override func putFuel(fuel: Double) {
        self.fuelGauge = (self.fuelGauge + fuel) * 1.1
    }
    
    override func getFuelEfficiency() -> Double {
        return distance / (fuelGauge * 0.7)
    }
    

}

let myPorche = Porche()
myPorche.increaseDistance(dist: 100)
myPorche.putFuel(fuel: 10)

print(myPorche.getFuelEfficiency())

