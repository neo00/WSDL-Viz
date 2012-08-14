# What is WSDL-Viz
WSDL-Viz (WSDL Visualization) is a simple tool to display the content of a WSDL and XSD files in a human-friendly visual view, as opposed to the complex/hard-to-read XML.

# How does it work?
This is an XSL transformation that takes a WSDL file as an input, and generates a human-friendly HTML file as output enhanced with a small dose of Javascript (jQuery) for some simple, but meaningful, interactive visualization.

# How to run?
There are several ways to run the XSL transformation. The easiest ways are using the supplied PowerShell script (for Windows) or using Apache Ant (for other operating systems).

## Windows using PowerShell
I have included an PowerShell script (Run.ps1) that invokes .Net's XslCompiledTransform to apply the XSL on a given WSDL file and generate the HTML output file. Open a PowerShell window, and CD to the directory that contains the WDSL-Viz files. Then type:

` .\Run.ps1 http://example.com/ExampleService?wsdl` 

if the WSDL is on a Web site (note that the script will fail if the WSDL page requires authentication).
Or if the WSDL file is in a local folder then you can similarly run:

` .\Run.ps1  "c:\Example Folder\WSDL\Service.wsdl"
`

If the WSDL references any external XSD files, you have to make sure that they are in the right relative folder. So for example, if the above WSDL file contains an <import> element for a Schema file located in "../Schemas/Schema1.xsd", then you have to make sure that "Schema1.xsd" is in "C:\Example Folder\Schemas\Schema1.xsd".

It is also possible to run the PowerShell script in Windows from the file browser directly. Just right click on "Run.ps1" and choose "Run with PowerShell". Then enter the URL or the path of the WSDL when prompted. 

## Under Other OS's Using Ant
It's also possible to invoke XSL transformation using Apache Ant. I've supplied a build.xml for this purpose. Currently you need to edit build.xml to specify the location of the WSDL file and the output file. 



# License
WSDL-Viz is Free, as in Free Speech, released under GNU General Public License (GPL) v2.0. 
[https://www.gnu.org/licenses/gpl-2.0.html](https://www.gnu.org/licenses/gpl-2.0.html).


