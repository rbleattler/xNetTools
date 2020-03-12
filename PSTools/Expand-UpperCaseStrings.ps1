function Expand-PascalCase {
    Param (
        [string]
        $InputObject
    )
    $IndexArray = Get-UppercaseIndices -Text $InputObject -AllButFirst
    for ($i = 0; $i -lt $IndexArray.Count; $i++) {
        $NextIndex = 1 + $i
        if ($NextIndex -le $IndexArray.Count) {
            $InputObject = $InputObject.Insert($IndexArray[$i], ' ') 
        } 
        if ($NextIndex -lt $IndexArray.Count) {
            $IndexArray[$NextIndex] = $IndexArray[$NextIndex] + $NextIndex
        }
    }
    $InputObject
}

function Expand-CamelCase {
    Param (
        [string]
        $InputObject
    )
    $IndexArray = Get-UppercaseIndices -Text $InputObject
    for ($i = 0; $i -lt $IndexArray.Count; $i++) {
        $NextIndex = 1 + $i
        if ($NextIndex -le $IndexArray.Count) {
            $InputObject = $InputObject.Insert($IndexArray[$i], ' ') 
        } 
        if ($NextIndex -lt $IndexArray.Count) {
            $IndexArray[$NextIndex] = $IndexArray[$NextIndex] + $NextIndex
        }
    }
    $InputObject
}