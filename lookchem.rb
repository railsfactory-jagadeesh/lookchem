#~ require File.join(File.dirname(__FILE__), "lookchemsqlconnection.rb")
require "rubygems"
require "mechanize"
require "mysql"
@agent=Mechanize.new
@page=@agent.get("http://www.lookchem.com/Clozapine/")
   name=@page.parser.css(".rbox").css("li").css("h1").inner_html
  casnumber=@page.parser.css(".rbox").css("li").css("h2").css("a").inner_html
  molecularstructure=@page.parser.css("#gallery").css("a")[0]["href"]
  synonyms=@page.parser.css("li:nth-child(12)").css("li")[0].inner_html
   iupacname="NULL"; formula="NULL"; molecularweight="NULL";molarrefractivity="NULL";molarvolume="NULL";density="NULL";flashpoint="NULL";indexofrefraction="NULL";polarizability="NULL";
 surfacetension="NULL"
   enthalpyofvapourization="NULL"; boilingpoint="NULL";vapourpressure="NULL"; apperance="NULL"; productcategoriesoferlotonib="NULL"; canonicalsmiles="NULL"; inchi="NULL"; inchikey="NULL";
    meltingpoint="NULL"; hazardsymbols="NULL"; riskcodes="NULL"; safety="NULL"; transportinfo="NULL";
    array=Array.new
   @page.parser.css(".supdetail li").each { |tag|
        array<<tag
    }
    array.each_with_index do |k,v|
	transportinfo= array[v+1].inner_html if k.to_html.include?("Transport Information")
	hazardsymbols=array[v+1].inner_html if k.to_html.include?("Hazard Symbols")
	riskcodes= array[v+1].inner_html if k.to_html.include?("Risk Codes")
	safety= array[v+1].inner_html if k.to_html.include?("Safety Description")
    end
  @element_para = @page.parser.css(":nth-child(5) p").to_html.gsub("<p>","").gsub("</p>","").split("<br>        ")
  arr=Array.new 
    @element_para.each do |p|
    arr << p#.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","") rescue "Not Found"
  end
  arr.each { |inputs|
   iupacname= inputs.split(":").last.strip! if inputs.include?("IUPAC Name")
   formula= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Formula")
  molecularweight= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Molecular Weight")
   molarrefractivity= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Molar Refractivity")
   molarvolume= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Molar Volume")
   density= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Density:")
   flashpoint= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Flash Point")
   indexofrefraction= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Index of Refraction")
   polarizability= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Polarizability")
   surfacetension= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Surface Tension:")
   enthalpyofvapourization= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Enthalpy of Vaporization:")
   boilingpoint= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Boiling Point:")
   vapourpressure= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Vapour Pressure:")
   apperance= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Appearance")
   productcategoriesoferlotonib= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Product Categories")
   canonicalsmiles=  inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Canonical SMILES")
   inchi= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("InChI:")
   inchikey= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("InChIKey")
   meltingpoint= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Melting ")
  }
  @conn = Mysql.real_connect("localhost","root","root","LookChem")
  @conn.autocommit(false)
  @insert_product = @conn.prepare(format("INSERT INTO products ( name, casnumber, formula, molecularstructure,synonyms,molecularweight,density, meltingpoint ,boilingpoint,flashpoint,apperance,hazardsymbols,riskcodes,safety,transportinfo,iupacname,molarrefractivity,molarvolume, indexofrefraction,polarizability,surfacetension,enthalpyofvapourization,vapourpressure,productcategoriesoferlotonib,canonicalsmiles,inchi,inchikey) VALUES (?, ?, ?, ?, ?, ?,?,?,?,?, ?, ?, ?, ?, ?,?,?,?,?, ?, ?, ?, ?, ?,?,?,?)"))
  @insert_product.execute(name, casnumber, formula, molecularstructure,synonyms,molecularweight,density, meltingpoint ,boilingpoint,flashpoint,apperance,hazardsymbols,riskcodes,safety,transportinfo,iupacname,molarrefractivity,molarvolume, indexofrefraction,polarizability,surfacetension,enthalpyofvapourization,vapourpressure,productcategoriesoferlotonib,canonicalsmiles,inchi,inchikey)
  @conn.commit()