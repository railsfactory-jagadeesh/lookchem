require "rubygems"
require "nokogiri"
require "mysql"
require "open-uri"
array=Array.new
doc=Nokogiri::HTML(open("http://www.lookchem.com/hotproduct_list_A_1.html"))

 @conn = Mysql.real_connect("localhost","root","root","LookChem")
  @conn.autocommit(false)
	
doc.css("td:nth-child(2) a").each { |u| 
    link=u["href"]
   page = Nokogiri::HTML(open(link))
	 #~ data=page.css(".rbox:nth-child(1)")
	 #~ name=data.css("li").css("h1").inner_html
	 	#~ caseno= data.css("li").css("h2").css("a").inner_html
		#~ p superlistname=page.css("")
		
	docs=page.css(".supdetail li")
	name= docs.css("li").css("h1").inner_html
  casnumber= docs.css("li").css("h2").css("a").inner_html
	structure= docs.css("#gallery").css("a")[0]["href"]
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
		flashpoint=""
		superlistname="NULL"
		synonyms="NULL"
		meltingpoint="NULL"
		appearance="NULL"
    array.each_with_index do |k,v|
			 transportinformation= array[v+1].inner_html if k.to_html.include?("Transport Information")
			 hazardsymbols=array[v+1].inner_html if k.to_html.include?("Hazard Symbols")
			 riskcodes= array[v+1].inner_html if k.to_html.include?("Risk Codes")
			 safety= array[v+1].inner_html if k.to_html.include?("Safety Description")
			 molecularweight= array[v+1].inner_html if k.to_html.include?("Molecular Weight")
			  molecularformula= array[v+1].inner_html.gsub("<sub>","").gsub("</sub>","") if k.to_html.include?("Formula")
			 #formula= inputs.split(":").last.gsub("<sub>","").gsub("</sub>","") if inputs.include?("Formula")
			 p density= array[v+1].inner_html.gsub("<sup>","").gsub("</sup>","") if k.to_html.include?("Density")
			 boilingpoint= array[v+1].inner_html if k.to_html.include?("Boiling Point")
			 flashpoint= array[v+1].inner_html if k.to_html.include?("Flash Point")
			 superlistname= array[v+1].inner_html if k.to_html.include?("Superlist Name")
			 synonyms= array[v+1].inner_html if k.to_html.include?("Synonyms")
			 meltingpoint= array[v+1].inner_html if k.to_html.include?("Melting Point")
			appearance= array[v+1].inner_html if k.to_html.include?("Appearance")
		end
		array=[]

			 @insert_productdatas = @conn.prepare(format("INSERT INTO productdatas ( casnumber, name, molecularformula,structure,synonyms,molecularweight, density ,meltingpoint,boilingpoint,flashpoint,appearance,hazardsymbols,riskcodes,safety,transportinformation,superlistname) VALUES (?, ?, ?, ?, ?, ?,?,?,?,?, ?, ?, ?, ?, ?,?)"))
   @insert_productdatas.execute(casnumber, name, molecularformula,structure,synonyms,molecularweight, density ,meltingpoint,boilingpoint,flashpoint,appearance,hazardsymbols,riskcodes,safety,transportinformation,superlistname)
	 @conn.commit()
	


	}