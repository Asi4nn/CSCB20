var viewer = document.querySelector("#viewer")
var equals = document.querySelector("#equals")
var nums = document.querySelectorAll(".num")
var ops = document.querySelectorAll(".ops")

var theNum = ""
var oldNum = ""
var resultNum = ""
var operator

var el = function(element) {
    if (element.charAt(0) === "#") {
        return document.querySelector(element)
    }

    return document.querySelectorAll(element)
}

var setNum = function()
{
    if (resultNum)
    {
        
    }
    else
    {
        theNum += this.getAttribute("data-num")
    }
    viewer.innerHTML = theNum
}

var moveNum = function()
{
    oldNum = theNum
    theNum = ""
    operator = this.getAttribute("data-ops")
}

var displayNum = function()
{
    oldNum = parseFloat(oldNum)
    theNum = parseFloat(theNum)

    switch (operator)
    {
        case "plus":
            resultNum = oldNum + theNum
            break
        case "minus":
            resultNum = oldNum - theNum
            break
        case "times":
            resultNum = oldNum * theNum
            break
        case "divided by":
            resultNum = oldNum / theNum
            break
        default:
            result = theNum
    }

    if (!isFinite(resultNum)) {
        if (isNaN(resultNum)) {
             resultNum = "You broke it!"
        } 
        else 
        {
            resultNum = "Look at what you've done"
            el('#calculator').classList.add("broken")
            el('#reset').classList.add("show")
        }
    }
  
    viewer.innerHTML = resultNum;
    equals.setAttribute("data-result", resultNum);

    oldNum = 0;
    theNum = resultNum;
}

var clearAll = function() {
    oldNum = ""
    theNum = ""
    viewer.innerHTML = "0"
    equals.setAttribute("data-result", resultNum)
}

for (var i = 0; i < nums.length; i++)
{
    nums[i].onclick = setNum
}

for (var i = 0; i < ops.length; i++)
{
    ops[i].onclick = moveNum
}

equals.onclick = displayNum

el("#clear").onclick = clearAll

el("#reset").onclick = function() {
    window.location = window.location;
}