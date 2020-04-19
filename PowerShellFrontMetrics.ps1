#Goal: Generate lint metrics for front project
function Create-InitHtml(){
     $html = "<html><head></head><body>"
     $html = $html +  "<h1>Metrics Summary for front-end</h1>"
     return $html
 }

 function Create-FilesMetric($html, $totalFiles, $totalLintErrorFiles){
    $percentajeLintErrorFiles = $totalLintErrorFiles * 100 / $totalFiles
    $html = $html +  "<h3>Metric: Amount Files</h3><br/>"
    $html = $html + "<table border='1'>"
    $html = $html + "<tr><th>Total Analyzed Files</th><th>Total Files not passing</th><th>Percentaje Files not passing</th></tr>"
    $html = $html + "<tr><td>$totalFiles</td><td>$totalLintErrorFiles</td><td>$percentajeLintErrorFiles</td></tr>"
    $html = $html + "</table><br/>"
    return $html
 }

 function Create-SeverityMetric($html, $errors) {
    $html = $html +  "<h3>Metric: Amount Lint Errors by Severity</h3><br/>"
    $html = $html + "<table border='1'>"
    $html = $html + "<tr><th>Severity</th><th>Amount Lint Errors</th><th>Percentaje</th></tr>"

    # Get amount of errros
    $amountLintErrors = $errors.Count 
    #Get all severities found in document
    $severities = $errors | Select-Object {$_.severity} -Unique
    $sum = 0
    $sumPercentaje = 0
    Foreach ($severity in $severities) {

        $severityName = $severity.'$_.severity'    
        $errorsBySeverity = $errors | Where-Object {$_.severity -eq $severityName } 
    
        #the minimum severity in document is 1, because was found in document, however is result is array means more than 1 error
        $amountSeverity = 1
        if($errorsBySeverity -is [system.array]){
            $amountSeverity = $errorsBySeverity.Count
        }

        $sum = $sum + $amountSeverity
        $percentaje = $amountSeverity * 100 / $amountLintErrors
        $sumPercentaje = $sumPercentaje + $percentaje
        $html = $html + "<tr><td>$severityName</td><td>$amountSeverity</td><td>$percentaje</td></tr>"
        write-host "Severity: $severityName has $amountSeverity findings"
    }

    $html = $html + "<tr><th>Total</th><th>$sum</th><th>$sumPercentaje</th></tr>"
    $html = $html + "</table><br/>"
    return $html
 }

 function Create-TypeErrorMetric($html, $errors) {
    $html = $html +  "<h3>Metric: Amount Lint Errors by Type</h3><br/>"
    $html = $html + "<table border='1'>"
    $html = $html + "<tr><th>Type</th><th>Amount Lint Errors</th><th>Percentaje by total lint errors</th></tr>"

    # Get amount of errros
    $amountLintErrors = $errors.Count 
    #Get all type of errors found in document
    $errorTypes = $errors | Select-Object {$_.source} -Unique
    $AmountErrorTypes = $errorTypes.Count 

    $sum = 0
    $sumPercentaje = 0
    Foreach ($errorType in $errorTypes) {

        $errorTypeName = $errorType.'$_.source'    
        $errorsByErrorType = $errors | Where-Object {$_.source -eq $errorTypeName } 
    
        #the minimum severity in document is 1, because was found in document, however is result is array means more than 1 error
        $amountErrorType = 1
        if($errorsByErrorType -is [system.array]){
            $amountErrorType = $errorsByErrorType.Count
        }

        $sum = $sum + $amountErrorType        
        $percentajeByTotalLint = $amountErrorType * 100 / $amountLintErrors
        $sumPercentaje = $sumPercentaje + $percentajeByTotalLint

        $html = $html + "<tr><td>$errorTypeName</td><td>$amountErrorType</td><td>$percentajeByTotalLint</td></tr>"
        write-host "Severity: $errorTypeName has $amountErrorType findings"
    }
    $html = $html + "<tr><th>Total</th><th>$sum</th><th>$sumPercentaje</th></tr>"
    $html = $html + "</table><br/>"
    return $html
 }

 <#
 function Create-Detail($html, $document) {
    $stylishDocument = (get-content $document -Raw) -replace '\n','<br/>'
    $html = $html + "<br/></br>"

    $html = $html +  "<h3>Files with Lint Errors</h3><br/>"
    $html = $html + $stylishDocument
    $html = $html + "<br/></br>" 
    return $html
 }#>

 function Create-Detail($html, $document) {   
    $html = $html + "<br/></br>"

    $html = $html +  "<h3>Files with Lint Errors</h3><br/>"
    $html = $html + "For detailed errors, go to file: " + $document
    $html = $html + "<br/></br>" 
    return $html
 }

 function Create-EndHtml($html){
     $html = $html + "</body></html>"
     return $html
 }

 function Generate-LintFiles($outputDocumentLint) {
   # ng lint --format stylish --exclude 'src/**/*.spec.ts' > stylish.txt
    ng lint --format checkstyle --exclude 'src/**/*.spec.ts' > $outputDocumentLint
   # ng lint --format fileslist --exclude 'src/**/*.spec.ts' > fileslist.txt
 }

 function Summary-RunManually($html) {
    $html = $html +  "<b>How to Get lint errors in your local machine? </b>"
    $html = $html +  "In the terminal, move the directory to Deloitte.DEX project (cd Deloitte.DEX)<br/>"
    $html = $html +  "execute this command: ng lint --format stylish --exclude 'src/**/*.spec.ts' > stylish.txt<br/>"
    return $html
 }

 function Configuration-Lint($html) {
    $html = $html +  "<b>Where are configured Lint rules?</b>"
    $html = $html +  "These rules are configured in tslint.json file located in Deloitte.DEX project </span><br/>"
    return $html 
 }
 
 $outputDocumentLint = 'LintOutput.xml'
 $rootLocation = "C:\walonso\Trabajo\DEX\Project\DEX\Deloitte.Dex" #"$(System.DefaultWorkingDirectory)"
 $folderHtmlReport = "$rootLocation\HTMLMetrics\"

 #Execute Lint Analysis
 Generate-LintFiles -outputDocumentLint $outputDocumentLint 

 $html = Create-InitHtml

 ## How to run manually in local pc
 $html = Summary-RunManually -html $html

 ## Where are lint rules located
 $html = Configuration-Lint -html $html

 ## Getting lint errors
# Load the metric document (checkstyle.xml) , add node text as xml, to be able to load document as XML.
$nodeToRemoveCheckStyle= '<\?xml version="1.0" encoding="utf-8"\?>'
$currentCheckStyleDocument = get-content $outputDocumentLint -RAW
$newCheckStyleDocument = $currentCheckStyleDocument -replace $nodeToRemoveCheckStyle,''  
$checkStyleDocument = '<node>'+$newCheckStyleDocument+'</node>'
# Load document as XML
[XML]$xml = $checkStyleDocument
# Get all errors
$files = $xml.SelectNodes('//node/checkstyle/file')
$errors = $xml.SelectNodes('//node/checkstyle/file/error')


 ## Generation of File Metrics
 #Get all files to be analyze
 $AllFiles =  @(Get-ChildItem -Path 'src/*'  -Include *.ts -Recurse -Exclude *.spec.ts)
 $TotalFiles = $AllFiles.Count
 # Get amount of errros
 $amountFilesWithLintErrors = $files.Count 

 $html = Create-FilesMetric -html $html -totalFiles $TotalFiles -totalLintErrorFiles $amountFilesWithLintErrors


## Generation of Severity metric
$html = Create-SeverityMetric -html $html -errors $errors

## Generation of Error type metric
$html = Create-TypeErrorMetric -html $html -errors $errors


##Get detail of all files:
$html = Create-Detail -html $html -document $outputDocumentLint
    

$html = Create-EndHtml -html $html

    
$htmlReport = $folderHtmlReport+"MetricsSummary_Front.html"
if (Test-Path $htmlReport) 
{
   Remove-Item $htmlReport
}

Copy-Item -Path "$rootLocation\$outputDocumentLint" -Destination "$folderHtmlReport" -Recurse
New-Item $htmlReport -ItemType File
Set-Content $htmlReport $html