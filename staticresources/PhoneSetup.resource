// JavaScript Document

    function keyUP(object, e) {
        if (e) {
            e = e
        } else {
            e = window.event
        }
        if (e.which) {
            var keycode = e.which
        } else {
            var keycode = e.keyCode
        }
        if (keycode >= 48) {
            ProcessString(object)
        }
    }
    function ProcessString(object) {
        validatePhone(object);
    }
    function validatePhone(obj) {
        var phoneStr = obj.value;
        phoneStr = phoneStr.replace(/^\s+|\s+$/g, '');
        var testArr = phoneStr.split("");
        var j = 0;
        var arraySize = testArr.length;
        var keychar = testArr[0];
        if (keychar == "+") //international format
        {
            for (i = 1; i < testArr.length; i++) {
                var testchar = testArr[i];
                var newchar = "";
                var remchar = -1;
                //alert("test:"+testchar);
                var ioffset = 0;
                ioffset = PhoneFormat_International(i, newchar, remchar, testchar, testArr);

                i += ioffset;
  
                j++; //to avoid any infinite loop..
                if (j == 300) {
                    break;
                }
            }
        }
        else {
            for (i = 0; i < testArr.length; i++) {
                var testchar = testArr[i];
                var newchar = "";
                var remchar = -1;
                //alert("test:"+testchar);
                var ioffset = 0;
                var arrsize1 = testArr.length
                ioffset = PhoneFormat_USCanada(i, newchar, remchar, testchar, testArr);
  
                i += ioffset;
  
                j++; //to avoid any infinite loop..
                if (j == 300) {
                    break;
                }
            }
        }
        obj.value = testArr.join("");
    }
    function PhoneFormat_USCanada(i, newchar, remchar, testchar, testArr) {
        var ret = 0;
        if (i > 13) {
            testArr.splice(i, 1);
            ret = -1;
            return ret;
        }
        switch (i) {
            case 0:
                if (testchar != "(") {
                    newchar = "(";
                }
                else {
                    remchar = 0;
                }
                break;
            case 4:
                if (testchar != ")") {
                    newchar = ")";
                }
                else {
                    remchar = 0;
                }
                break;
            case 5:
  
                if (testchar != ' ') {
                    newchar = ' ';
                }
                else {
                    remchar = 0;
                }
                break;
            case 9:
                if (testchar != "-") {
                    newchar = "-";
                }
                else {
                    remchar = 0;
                }
                break;
            default:
                if (isNaN(testchar) && testchar != ' ')
                    remchar = 1;
        }
        if (remchar != 0 && (isNaN(testchar) || testchar == ' '))
  
        { remchar = 1; }
        else
        { remchar = 0; }
        if (newchar.length > 0)   //char to be concatenated for the phone number format
        {
            testArr.splice(i, remchar, newchar);              //if remchar=1, the character is invalid and remove it whileadding a char
        }
        else if (remchar == 1)    //if 1, the character is invalid and remove it
        {
            testArr.splice(i, remchar);
            ret = -1;      //only deletion, the same index char needs to be examined    
        }
        return ret;
    }
  
    function PhoneFormat_International(i, newchar, remchar, testchar, testArr) {
        var ret = 0;
        remchar = 1;
        if (!isNaN(testchar)) {
            remchar = 0;
        }
        else if (testchar == " ") {
            remchar = 0;
        }        else if (testchar == "-") {
            remchar = 0;
        }
  
        if (remchar == 1)  //if 1, the character is invalid and remove it
        {            testArr.splice(i, remchar);            ret = -1;      //only deletion, the same index char needs to be examined    
       }
         return ret;
    } 

