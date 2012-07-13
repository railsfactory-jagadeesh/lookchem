require "rubygems"
require "nokogiri"
require "mysql"
require "open-uri"
image_url = "www.lookchem.com"
array=Array.new
doc=Nokogiri::HTML(open("http://www.lookchem.com/hotproduct_list_A_23.html"))

 @conn = Mysql.real_connect("localhost","root","root","LookChem")
  @conn.autocommit(false)
	
doc.css("td:nth-child(2) a").each { |u| 
    link=u["href"]
   page = Nokogiri::HTML(open(link))
	 #~ data=page.css(".rbox:nth-child(1)")
	 #~ name=data.css("li").css("h1").inner_html
	 	#~ caseno= data.css("li").css("h2").css("a").inner_html
		#~ p superlistname=page.css("")
		#p "opened"
	docs=page.css(".supdetail li")
	name= docs.css("li").css("h1").inner_html
  casnumber= docs.css("li").css("h2").css("a").inner_html
	#structure= docs.css("#gallery").css("a")[0]["href"] 
	if !docs.css('#gallery').empty?
		 structure= docs.css("#gallery").css("a")[0]["href"] 	
	else
		 structure = "NULL"
	 end
  #synonyms=@page.parser.css("li:nth-child(12)").css("li")[0].inner_html
	page.css(".supdetail li").each { |tag|
        array<<tag
    }

		transportinformation="NULL"
		hazardsymbols="NULL"
		riskcodes="NULL"
		safety="NULL"
		molecularweight="NULL"
		molecularformula="NULL"
		density="NULL"
		boilingpoint="NULL"
		flashpoint="NULL"
		superlistname="NULL"
		synonyms="NULL"
		meltingpoint="NULL"
		appearance="NULL"
		iupacname="NULL"
		molarrefractivity="NULL"
		molarvolume="NULL"
		indexofrefraction="NULL"
		polarizability="NULL"
		surfacetension="NULL"
		enthalpyofvapourization="NULL"
		vapourpressure="NULL"
		productcategoriesoferlotinib="NULL"
		canonicalsmiles="NULL"
		inchi="NULL"
		inchikey="NULL"
				 #p page.css('li:nth-child(22) img').to_html
    array.each_with_index do |k,v|
			 transportinformation= array[v+1].inner_html if k.to_html.include?("Transport Information")
			 #@hazardsymbols= array[v+1].inner_html if k.to_html.include?("Hazard Symbols")	
		#if docs.css('li:nth-child(22) img')
				 #p page.css('li:nth-child(22) img')
			#if hazardsymbols.include?('src')
			#p "ssssssssssssssssssssssssssssssssssss"
			# if docs.css('li:nth-child(22) img')
				#~ p hazardsymbols=image_url + array[v+1].inner_html.split('src=')[1].split('alt')[0].split('"')[1]  if k.to_html.include?("Hazard Symbols")	
     
        if k.to_html.include?("Hazard Symbols")	
					    symbol=array[v+1].inner_html
            if symbol.include?("src=")
			 hazardsymbols=image_url + array[v+1].inner_html.gsub("<span>","").gsub("</span>","").split('src=')[1].split('alt')[0].split('"')[1]
			     else
						 	 hazardsymbols=array[v+1].inner_html.gsub("<span>","").gsub("</span>","")
					 end
				end
				




#~ #p hazardsymbols= array[v+1].inner_html if k.to_html.include?("Hazard Symbols")	
#~ elsif docs.css('.supdetail li:nth-child(10)')
	#~ p hazardsymbols= array[v+1].inner_html if k.to_html.include?("Hazard Symbols")
	#~ else
		#~ hazardsymbols="NULL"
	#~ end
	
 #p hazardsymbols= array[v+1].inner_html if k.to_html.include?("Hazard Symbols")	
 #p hazardsymbols=image_url + array[v+1].inner_html.split('src=')[1].split('alt')[0].split('"')[1]  if k.to_html.include?("Hazard Symbols")	
 #end<sub xmlns="">
			 riskcodes= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<span>","").gsub("</span>","").gsub("Â", "") if k.to_html.include?("Risk Codes")
			 safety= array[v+1].inner_html.gsub("<sub xmlns>","").gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<span>","").gsub("</span>","").split('<a')[0] if k.to_html.include?("Safety Description")
			 molecularweight= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","") if k.to_html.include?("Molecular Weight")
			   molecularformula= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<strong>","").gsub("</strong>","").gsub(" ","").gsub("Â","").gsub("Â", "") if k.to_html.include?("Formula")
			 #formula= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Formula")
			   density= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<p>","").gsub("</p>","").gsub("Â", "") if k.to_html.include?("Density")
			 boilingpoint= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if k.to_html.include?("Boiling Point")
			  flashpoint= array[v+1].inner_html.gsub("Â", "").gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if k.to_html.include?("Flash Point")
			 superlistname= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if k.to_html.include?("Superlist Name")
			 synonyms= array[v+1].inner_html.gsub("</p>","").gsub("</span>", "").gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if k.to_html.include?("Synonyms")
			 meltingpoint= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<br>","").gsub("</br>","").gsub("Â", "") if k.to_html.include?("Melting Point")
			appearance= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if k.to_html.include?("Appearance")
		end
	array=[]


chemistry_block = page.css(".specification:nth-child(5) h3").inner_html
	 
if chemistry_block == "Chemistry"
		
		@element_para = page.css(":nth-child(5) p").to_html
		arr=Array.new
		@element_para.each do |p|
			arr << p
		end
arr.each { |input|
  inputss=input.split("<br>")
 inputss.each { |inputs| 
  iupacname= inputs.split(":").last.strip! if inputs.include?("IUPAC Name")
    molarrefractivity= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Molar Refractivity")
   molarvolume= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Molar Volume")
	 indexofrefraction= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Index of Refraction")
     polarizability= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Polarizability")
     surfacetension= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Surface Tension:")
    enthalpyofvapourization= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Enthalpy of Vaporization:")
	  vapourpressure= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<p>","").gsub("</p>","").gsub("Â", "") if inputs.include?("Vapour Pressure:")
	   productcategoriesoferlotinib= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<p>","").gsub("</p>","").gsub("Â", "") if inputs.include?("Product Categories")
	   canonicalsmiles=  inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Canonical SMILES")
		inchi= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("InChI=","").gsub("Â", "") if inputs.include?("InChI:")
     inchikey= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<p>","").gsub("</p>","").gsub("Â", "") if inputs.include?("InChIKey")
		 meltingpoint=inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<br>","").gsub("</br>","").gsub("Â", "") if inputs.include?("Melting Point")
		 boilingpoint= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Boiling Point")
		 flashpoint=  inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Flash Point")
		 appearance= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Appearance")
		synonyms= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("</p>","").gsub("</span>", "").gsub("Â", "") if inputs.include?("Synonyms")
		superlistname= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Superlist Name")
		density= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>", "").gsub("<p>","").gsub("</p>","").gsub("Â", "")  if inputs.include?("Density")
		molecularformula= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("<strong>","").gsub("</strong>","").gsub(" ","").gsub("Â", "")  if inputs.include?("Formula")
		molecularweight=  inputs.split(":").last.gsub("<sub>","").gsub("</sub>","").gsub("<sup>","").gsub("</sup>","").gsub("Â", "") if inputs.include?("Molecular Weight")
	 }
	 }
	
end
	
	 
		@insert_productdatas = @conn.prepare(format("INSERT INTO productdatas ( casnumber, name, molecularformula,structure,synonyms,molecularweight, density ,meltingpoint,boilingpoint,flashpoint,appearance,hazardsymbols,riskcodes,safety,transportinformation,superlistname,iupacname,molarrefractivity,molarvolume,indexofrefraction,polarizability,surfacetension,enthalpyofvapourization,vapourpressure,productcategoriesoferlotinib,canonicalsmiles,inchi,inchikey) VALUES (?, ?, ?, ?, ?, ?,?,?,?,?, ?, ?, ?, ?, ?,?,?, ?, ?, ?, ?,?,?,?,?, ?, ?,?)"))
@insert_productdatas.execute(casnumber, name, molecularformula,structure,synonyms,molecularweight, density ,meltingpoint,boilingpoint,flashpoint,appearance,hazardsymbols,riskcodes,safety,transportinformation,superlistname,iupacname,molarrefractivity,molarvolume,indexofrefraction,polarizability,surfacetension,enthalpyofvapourization,vapourpressure,productcategoriesoferlotinib,canonicalsmiles,inchi,inchikey)
@conn.commit()


}