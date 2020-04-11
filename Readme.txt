To execute metrics:

1. Install package:
Install-Package Microsoft.CodeAnalysis.Metrics -Version 2.9.8

2. Execure msbuild with metrics command:
C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin>msbuild.exe C:\Users\kokor\source\repos\Metrics\Metrics.sln /t:Metrics                       
/p:MetricsOutputFile=MetricsOutput.xml

3. Execute this program: (takes the xslt to convert xml to the html expected format)
"
 XslTransform myXslTransform;
myXslTransform = new XslTransform();
myXslTransform.Load(@"C:\Users\kokor\source\repos\Metrics\NetFramework\metrics.xslt");
myXslTransform.Transform(@"C:\Users\kokor\source\repos\Metrics\NetFramework\NetFramework.Metrics.xml", @"C:\Users\kokor\source\repos\Metrics\NetFramework\f\output.html");
"

4. Open Html file