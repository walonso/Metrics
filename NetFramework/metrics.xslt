<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
  exclude-result-prefixes="msxsl"
>
  <xsl:output method="html" indent="yes"/>
   <xsl:template match="/">
  <html>
  <body>
  <h2>x</h2>
  <table border="1">
    <tr bgcolor="#9acd32">
      <th>Name Assembly</th>
   <!--    <th>Type Name</th>
     <th>Member Name</th>-->
      <th>MaintainabilityIndex</th>
      <th>CyclomaticComplexity</th>
      <th>ClassCoupling</th>
      <th>DepthOfInheritance</th>
      <th>LinesOfCode</th>

    </tr>
    <xsl:for-each select="CodeMetricsReport/Targets/Target">
    <tr>
      <td><xsl:value-of select="current()/@Name" /></td>
	  <xsl:for-each select="/CodeMetricsReport/Targets/Target/Assembly/Metrics">
	  <!-- <td><xsl:value-of select="current()/@Name" /></td>
	   <td><xsl:value-of select="current()/Metric[@Name = 'MaintainabilityIndex']/@Value" /></td>
     <td><xsl:value-of select=".Assembly/Metrics/Metric[@Name = '????']/@Value" /></td>-->
      <td><xsl:value-of select="current()/Metric[@Name = 'MaintainabilityIndex']/@Value" /></td>
      <td><xsl:value-of select="current()/Metric[@Name = 'CyclomaticComplexity']/@Value"/></td>
      <td><xsl:value-of select="current()/Metric[@Name = 'ClassCoupling']/@Value"/></td>
      <td><xsl:value-of select="current()/Metric[@Name = 'DepthOfInheritance']/@Value"/></td>
      <td><xsl:value-of select="current()/Metric[@Name = 'SourceLines']/@Value"/></td>
	   </xsl:for-each>
      </tr>
    </xsl:for-each>
	
  </table>
  
  <br/> 
  <br/> 
  <xsl:for-each select="CodeMetricsReport/Targets/Target">
	<b>Assembly:</b> <xsl:value-of select="current()/@Name" />
	<br/>  
	  <xsl:for-each select="current()/Assembly/Namespaces/Namespace">
		<b>Namespace:</b> <xsl:value-of select="current()/@Name" />
		<br/>  
		<xsl:for-each select="current()/Types/NamedType"> 
			<b>Class:</b> <xsl:value-of select="current()/@Name" />
			<br/> <br/>  
			<table border="1">
				<tr bgcolor="#9acd32">
			 <th>Method Name</th>
			  <th>MaintainabilityIndex</th>
			  <th>CyclomaticComplexity</th>
			  <!--<th>ClassCoupling</th>
			  <th>DepthOfInheritance</th>-->
			  <th>SourceLines</th>
			   <th>ExecutableLines</th>
			  
			  </tr>
			<xsl:for-each select="current()/Members/Method">
			<tr>
				<td><xsl:value-of select="current()/@Name" /></td>					
				  <td><xsl:value-of select="current()/Metrics/Metric[@Name = 'MaintainabilityIndex']/@Value" /></td>
				  <td><xsl:value-of select="current()/Metrics/Metric[@Name = 'CyclomaticComplexity']/@Value"/></td>
				  <!--<td><xsl:value-of select="current()/Metrics/Metric[@Name = 'ClassCoupling']/@Value"/></td>
				  <td><xsl:value-of select="current()/Metrics/Metric[@Name = 'DepthOfInheritance']/@Value"/></td>-->
				  <td><xsl:value-of select="current()/Metrics/Metric[@Name = 'SourceLines']/@Value"/></td>
				  <td><xsl:value-of select="current()/Metrics/Metric[@Name = 'ExecutableLines']/@Value"/></td>
				  </tr>	 
			</xsl:for-each>
			 </table>
			 <br/><br/>
		</xsl:for-each>	
	  </xsl:for-each>
	  
  </xsl:for-each>
  	
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
