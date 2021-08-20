Class TypeCheck.TypeCheck
{

/// The method to infer types from
ClassMethod Infer(pInt, pBool)
{
    if pInt = 10 {
        quit 5
    } elseif pBool {
        quit pBool
    }
}

ClassMethod Tokenize()
{
    set method = ##class(%Dictionary.MethodDefinition).IDKEYOpen("TypeCheck.TypeCheck", "Infer",,.sc)
    set sc = ##class(%SyntaxColorReader).FromCode(method.Implementation, "COS", "A", .reader)

    set out = ""
    while reader.NextLine(.t) {
        set pointer = 0
        while $listnext(t, pointer, tok) {
            if ($list(tok, 2) '= "White Space") && ($list(tok, 2) '= "Brace") {
                set out = out _ $list(tok, 2) _ "," _ $list(tok, 3) _ ","
            }
        }
    }

    set file = ##class(%File).%New("path\to\tokens.txt")
    do file.Open("WSN")
    do file.WriteLine(out)
}

}
