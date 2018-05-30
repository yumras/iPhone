//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)
var i = 100
print(i)

var a = 2; var b=2

print (a,b)
print ("Adsf")

// 주석처리 방법

// var = 0

/*
fsjalkfjklsadjlkvjklsadfjlkasdjf
sadfkljsdalkfj
lkasdjfkljfalk
*/


// 정수 실수 "문자열" 불(Bool)

//1 100 200 -1 -2 -200
//1.2 2.4 100.3
//"asdf" "12345" "!@#!!$%"
// true false
//safdasf
//asdfads
// cmd + / 범위 주석


// 사칙연산 + - * / %(실수연산X)
3+3
20.3/10.3
// "가나다"+"가나다"
"가나다"+"가나나"
// print("\(3+2)")      \의 역할 = 부호면 부호를, 계산식이면 (3+2)를 계산 후 문자열로 취급
print("3+2")
print("\(3+2)")
print("\(3*20)")

// 100==200 // != > <
100==100
100 != 100
1000 == 100

str = "Hello, Mr. World"

//상수 선언
let pi = 3.14
// pi = pi + 10 -> 상수변경


//변수 선언
var itemCount:Int = 10    //itemCount는 :Int를 안 붙여도 기본 할당이 Int라서 안써도 된다.
itemCount += 50
itemCount += 50

let height:Double = 1.71
let weight:Double = 64.5
let BMI:Double = weight / (height*height)
//let BMI2 = weight / (height*height) // 가능

// 변수 선언시 명시적 선언 대신 암묵적으로 선언해도 OK
// var asdf = 10
//asdf  // ESC키로 인텔리전스로 확인가능


var isOK:Bool = false
isOK = true

var helloString1 = "all"
var helloString2 = helloString1 + " hi"

var fruitName = "banana"
var myStr = "I lika a \(fruitName)"
print(myStr)


// 자료형 변환
let intValue = Int(123.45)

let gumPrice:Int = 100
let pay = Double(gumPrice) * 1.08
//let payTest = gumPrice * 1.08 // compile error

let appleCount = 5
let myMessage:String = "banana " + String(appleCount) + " remains"

let inputString = "100"
let answer = Int(inputString)! * 5

// if 문
var score = 100
if 80 < score {
    print("Good")
}

// if else 문
var score2 = 50
if 80 < score2 {
    print("Goood")
} else {
    print("Bad")
}

//if else if, else 문
var score3 = 50
if 80 < score3 {
    print("Good")
} else if score3 > 40 && score3 <= 80 {
    print("Bad")
} else {
    print(">>>????")
}

// switch 문
var dice = 4
switch dice {
case 1:
    print("11111")
case 2, 5, 6 :
    print("2 or 5 or 6")
default :
    let tempStr:String = String(dice)
    print("number is : " + tempStr)
    print("number is : \(dice)") // var tempStr...과 print("n..." + tempStr) 안쓰고 한번에 하려면 이렇게
}

// while
var d = 0
while (d < 100){
    d += 7                // d가 100보다 작으면 계속 7이 더해진다(조건인 100보다 커지면 7을 더할 필요가 없어져 멈춘다=105)
}
print("Answer is \(d)")



print("----------------------------------------")


var aa = 0
var bb = 0
while (aa < 100 && bb < 100){
    aa += 11
    bb += 9
    print("\(aa) \(bb)")
}



print("----------------------------------------")


var quiz = 0
var qsum = 0
while (quiz < 100){
    quiz += 1
    qsum += quiz
    print("\(quiz) \(qsum)")
}
print("while문: 1~100까지의 합은 \(qsum)입니다.")


print("----------------------------------------")


quiz = 0
qsum = 0
while (quiz <= 100){
    qsum += quiz
    quiz += 1
    print("\(quiz) \(qsum)")
}
print("while문: 1~100까지의 합은 \(qsum)입니다.")



print("----------------------------------------")


// for 문
for i in 0...3
{
    print (i)
}


print("----------------------------------------")


for i in 0..<3
{
    print (i)
}


print("----------------------------------------")

for _ in (0..<3)
{
    print("\n")
}

print("----------------------------------------")


var qsum2 = 0
for i in 1...100
{
    qsum2 += i
    print("i = \(i) , qsum = \(qsum2)")
}
print ("for문을 활용하여 1~100을 더한 값은 \(qsum2)입니다.")

print("----------------------------------------")

print("구구단을 시작합니다.")
var dan1 = 2
var dan2 = 1
for dan1 in 2...9{
    print("\(dan1)단 입니다.")
    for dan2 in 1...9{
        print ("\(dan1) * \(dan2)  =  \(dan1*dan2)")
    }
}



print("----------------------------------------")

for _ in 1...30
{
    print("*", terminator:"")
}
print("")

print("----------------------------------------")


for i in 1...30{

    if i%4 == 0
    {
        print("")
    }
    else
    {
        print("*", terminator:"")
    }
}
print("")

print("----------------------------------------")

for i in 1...4{
    for _ in 1...i{
        print("*", terminator:"")
        }
    print("")
}

print("----------------------------------------")


for i in (1...4).reversed()
{
    for _ in 1...i{
        print("*", terminator:"")
    }
    print("")
}


print("----------------------------------------")







