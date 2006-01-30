<html>
<head>
<title>Bestellung</title>
<link rel='stylesheet' href='/intranet/style/invoice.css' type='text/css'>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style type="text/css">
#lup_allaround {
  border-width:1px;
  border-style:solid;
  border-color:black;
  padding:4px;
  text-align:left; }
}
</style>


<%
    if {[regexp {^(.)(..)(..)_(....)$} $invoice_nr match lup_prefix lup_decade lup_year lup_nr]} {
        set invoice_nr_lup "FM$lup_year$lup_nr"
    } else {
        set invoice_nr_lup $invoice_nr
    }
%>



</head>

<body>
<table border="0" cellspacing="1" cellpadding="1" width="100%">
  <tr> 
    <td align="center"> <img src="nwtrans.logo.350.107.gif" width="350" height="107"></td>
  </tr>
</table>
<font face="Verdana" size="2">
<br>

</font>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td width="40%">
      <table border="0" cellspacing="1" cellpadding="1" id="table1">
        <tr width="50%">
          <td class=roweven><font size="2" face="Verdana">Northwest Translations, 
            Inc. </font></td>
        </tr>
        <tr>
          <td class=roweven><font face="Verdana" size="2">P.O. Box 171</font></td>
        </tr>
        <tr>
          <td class=roweven><font face="Verdana" size="2">Eagle, PA 19480</font></td>
        </tr>
        <tr>
          <td class=roweven><font face="Verdana" size="2">United States</font></td>
        </tr>
        <tr><td class=rowodd><p><font face="Verdana" size="2">Toll Free 1-800-270-5620<br>
              Fax (509) 351-7529<br>
              sales@nwtranslations.com</font><font face="Verdana" size="2"><br>
              </font></p>
            </td></tr>
      </table>
    </td>
    <td width="60%" valign="top">
      <table border="0" cellspacing="1" cellpadding="1" width="70%">
        <tr width="50%"> 
          <td class=roweven><p><strong><font size="4" face="Verdana">INVOICE</font></strong></p></td>
        </tr>
      </table>
      <font face="Verdana" size="2">
      <br>
      </font>
      <table width="100%" border="0" cellpadding="1" cellspacing="0" style="border-collapse:collapse">
        <tr width="50%"> 
          <td class=roweven id=lup_allaround> <font face="Verdana" size="2"> <strong>DATE</strong><br>
            <strong><%=$invoice_date_pretty %></strong> </font> </td>
          <td class=roweven id=lup_allaround> <font face="Verdana" size="2"> <strong>INVOICE#</strong><br>
            <strong> <%= $related_project_nrs %> </strong> </font> </td>
        </tr>
      </table> 
    </td>
  </tr>
</table>
<font face="Verdana" size="2">
<br>

</font>

<table width="40%" border="0" cellpadding="1" cellspacing="0" style="border-collapse:collapse">
  <tr> 
    <td class="roweven" id=lup_allaround> <font face="Verdana" size="2"> <strong>INVOICE 
      FOR </strong></font></td>
  </tr>
  <tr> 
    <td id=lup_allaround>
      <table border="0" cellpadding="1" cellspacing="0">
        <tr><td class="roweven"><font face="Verdana" size="2"><%=$company_name%></font></td></tr>
        <tr><td class=roweven><font face="Verdana" size="2"><%=$company_contact_name%></font></td></tr>
        <tr><td class=roweven><font face="Verdana" size="2"><%=$address_line1%></font></td></tr>
        <tr><td class=roweven><font face="Verdana" size="2"><%=$address_line2%></font></td></tr>
        <tr><td class="roweven"><font face="Verdana" size="2"><%=$address_postal_code %> <%=$address_city %></font></td></tr>
        <tr><td class="rowodd"><font face="Verdana" size="2"><%=$country_name%></font></td></tr>
        <tr><td class="rowodd"><font face="Verdana" size="2"><%=$account_nr%></font></td></tr>
      </table>
    </td>
  </tr>
</table>
<font face="Verdana" size="2">
<br>

<%
    set source_language ""
    set target_language ""
    set company_contact_name ""
    set errmsg ""

    catch {[db_1row get_project_info "
	select
		p.project_name,
		p.project_nr,
		p.start_date,
		p.end_date,
		im_category_from_id(p.source_language_id) as source_language,
		im_name_from_user_id(p.company_contact_id) as company_contact_name
	from
		im_projects p
	where
		project_id = :rel_project_id
    "]} errmsg

    set start_date_pretty [lc_time_fmt $start_date "%x" $locale]
    set end_date_pretty [lc_time_fmt $end_date "%x" $locale]
%>

<%
    set errmsg ""
    catch {[db_foreach get_target_languagesproject_info "
	select	im_category_from_id(l.language_id) as language
	from	im_target_languages l
	where	l.project_id = :rel_project_id
    " {
	append target_language "$language"
    }]} errmsg

%>

</font>

<table width="100%" border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse">
  <tr> 
    <td id=lup_allaround> <font face="Verdana" size="2"> <strong>PROJECT INFORMATION</strong></font></td>
  </tr>
  <tr> 
    <td id=lup_allaround>
	<font face="Verdana" size="2">Projektbez.: <%=$project_name%><br>
        Ausgangssprache: <%=$source_language%><br>
        Zielprache(n): <%=$target_language%><br>
        Leistungszeitraum: <%=$start_date_pretty%> - <%=$end_date_pretty%><br>
      </font>
      </td>
  </tr>
</table>
<font face="Verdana" size="2">
<br>

</font>

<table border="1" cellspacing="0" cellpadding="2" bordercolor=black style="border-collapse:collapse" width="100%">
<%=$item_list_html %>
</table>
<font face="Verdana" size="2">
<br>
</font> 
<p> <font face="Verdana" size="2">Disclaimer: All our work is executed with the 
  utmost professional care. However, we disclaim all liability for any legal implications 
  resulting from the use of it. Our maximum liability, whether by negligence, 
  contract or otherwise, will not exceed the return of the amount invoiced for 
  the work in dispute. Under no circunstances will we be liable for specific, 
  individual or consequential damages.</font> </p>

</body>
</html>
