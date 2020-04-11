
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$xslt.Load("C:\Users\kokor\source\repos\Metrics\NetFramework\metrics.xslt");
$arrayMetrics = Get-ChildItem -Include MetricsOutput.xml -Recurse
Foreach ($i in $arrayMetrics){
    $fragments = $i.ToString().split('\')
    $nameAssembly = $fragments[ @($fragments).length - 2]
    $xslt.Transform($i, "C:\Users\kokor\source\repos\Metrics\HTMLMetrics\"+$nameAssembly+".html");
    Write-Host "generated" $nameAssembly;
}