To execute metrics:

1. Install package:
Install-Package Microsoft.CodeAnalysis.Metrics -Version 2.9.8

2. Execure msbuild with metrics command:
C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin>msbuild.exe C:\Users\kokor\source\repos\Metrics\Metrics.sln /t:Metrics                       
/p:MetricsOutputFile=MetricsOutput.xml

3. Execute this program: (takes the xslt to convert xml to the html expected format)
** C#:
"
 XslTransform myXslTransform;
myXslTransform = new XslTransform();
myXslTransform.Load(@"C:\Users\kokor\source\repos\Metrics\NetFramework\metrics.xslt");
myXslTransform.Transform(@"C:\Users\kokor\source\repos\Metrics\NetFramework\NetFramework.Metrics.xml", @"C:\Users\kokor\source\repos\Metrics\HTMLMetrics\output.html");
"

** PowerShell (To include in pipelines)
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$xslt.Load("C:\Users\kokor\source\repos\Metrics\NetFramework\metrics.xslt");
$arrayMetrics = Get-ChildItem -Include MetricsOutput.xml -Recurse
Foreach ($i in $arrayMetrics){
    $fragments = $i.ToString().split('\')
    $nameAssembly = $fragments[ @($fragments).length - 2]
    $xslt.Transform($i, "C:\Users\kokor\source\repos\Metrics\HTMLMetrics\"+$nameAssembly+".html");
    Write-Host "generated" $nameAssembly;
}

4. Open Html file