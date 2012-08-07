param ($xml)

$pwd = $(pwd).Path
$xsl = "$pwd\wsdl2html.xsl"
$output = "$pwd\Output.html"

if (! $xml) {
    $xml = Read-Host "Enter the path to or the URL of the WSDL file"
}


## Get full path for the xsl file.
$xsl = ($xsl|gci).FullName


## XSL Parameters
$argList = New-Object System.Xml.Xsl.XsltArgumentList;
$curDate = $(date).ToString();
$argList.AddParam("current-date","", $curDate);
$argList.AddParam("filename","", $xml);

## Other settings:
$resolver = New-Object System.Xml.XmlUrlResolver;   
$settings = New-Object System.Xml.Xsl.XsltSettings true, true; 

## If Authentication is required to access the WSDL/XSD files. Doesn't seem to be working!

#$creds = New-Object System.Net.NetworkCredential "username", "password", "domain";
#$cache = New-Object System.Net.CredentialCache;
#$uri=New-Object System.Uri $xml;
#$cache.Add($uri, "Ntlm", $creds);
#$resolver.Credentials = $cache; #[System.Net.CredentialCache]::DefaultCredentials;   


## Run XSL
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$xslt.Load($xsl, $settings, $resolver);
$textWriter = New-Object System.IO.StreamWriter($output)
$xslt.Transform($xml, $argList, $textWriter);
$textWriter.Close();

## Open Output file
Invoke-Item $output
