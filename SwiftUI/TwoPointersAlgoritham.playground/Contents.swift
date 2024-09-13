import UIKit

var greeting = "Hello, playground"

func sortedSquares(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: 0, count: nums.count)
    var left = 0
    var right = nums.count - 1
    var index = right
    while left <= right {
        if abs(nums[left]) > abs(nums[right]) {
            result[index] = nums[left]*nums[left]
            left += 1
        }
        else
        {
            result[index] = nums[right]*nums[right]
            right -= 1
        }
        index -= 1
    }
    
    
    return result
}

print(sortedSquares([-4,-1,0,3,10]))

func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    
    var firstIndex = 0
    var lastIndex = numbers.count - 1
    
    while firstIndex <= lastIndex {
        
        let sum = numbers[firstIndex] + numbers[lastIndex]
        
        if sum == target {
            return [firstIndex + 1 ,lastIndex + 1]
        }
        else if sum > target
        {
            lastIndex -= 1
        }
        else
        {
            firstIndex += 1
        }
    }
    
    
    return []
}

//print(twoSum([-1,0], -1))


func isPalindrome(_ s: String) -> Bool {
    var string = Array(s.lowercased().filter({$0.isLetter || $0.isNumber}))
    print(string)
    var firstIndex = 0
    var lastIndex = string.count - 1
    
    while firstIndex <= lastIndex {
        if string[firstIndex] != string[lastIndex] {
            return false
        }
        firstIndex += 1
        lastIndex -= 1
    }
    
    return true
}

print(isPalindrome("A man, a plan, a canal: Panama"))

func gcdProblem(numbers:[Int],multiplier:Int) -> Int
{
    
    var ans = 0
    var left = 0
    var multiplier2 = 1
    while left <= multiplier - 1 {
            
        var maxGCD = 0
        
        for i in left..<numbers.count - 1 {
            maxGCD = max(maxGCD, gcd(a: numbers[left], b: numbers[i]))
        }
        
        ans +=  multiplier2 * maxGCD
        multiplier2 += 1
        left += 1
    }
    
    print("The Max score is\(ans)")
    return 0
    
}

func gcd(a: Int, b: Int) -> Int
{
    let r = a % b
    
    if r == 0
    {
        return b
    }
    else
    {
        return gcd(a: b, b: r)
    }
}


gcdProblem(numbers: [1,2,3,4,5,6], multiplier: 3)


func gcdWithoutRecursion(a:Int, b:Int) -> Int
{
    var a = a
    var b = b
    while b != 0
    {
        let temp = b
        
        
        b = a % b
        a = temp
    }
    
    return a
}
