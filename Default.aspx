<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mortgage Calculation</title>
     <link href="CSS/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="CSS/myStyle.css" type="text/css" />
    
    <link rel="icon" href="images/favicon.ico" type="image/x-icon"/>
</head>
<body>
    <div class="main">
        <div class="container">
            <div>
                <h1>Mortgage Calculator</h1>
                <br />
               
                <p class="lead">Enter the information into the form below to receive information of Mortgage Payment. <br /> This is a guide to see how much you'd pay each month..</p>
            </div>
        </div>
        <div class="container formC">
                            
            <form id="form1" runat="server" class="form-group">
              <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <contenttemplate>
                    <div class="row">
                        <div class="col-md-6 leftside">
                         <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please Enter Mandatory Fields"  ForeColor="red" Font-Size="Large"></asp:ValidationSummary>
                         <asp:Label ID="Label1" runat="server" Text="Label" CssClass="labelF">Principal Amount <asp:RequiredFieldValidator ID="txtLoanAmountV" runat="server"  ControlToValidate="txtLoanAmount" ForeColor="red">*</asp:RequiredFieldValidator></asp:Label>
                         <asp:TextBox ID="txtLoanAmount" CssClass="form-control" runat="server" PlaceHolder="£" TextMode="Number" ForeColor="Black" ></asp:TextBox>
                         
                         <br /><br />
                
                         <asp:Label ID="Label2" runat="server" Text="Label" CssClass="labelC">Loan Term(Durations) <asp:RequiredFieldValidator ID="TxtLTermV" runat="server" ControlToValidate="TxtLTerm" ForeColor="red">*</asp:RequiredFieldValidator></asp:Label>
                         &nbsp;<asp:TextBox ID="TxtLTerm" CssClass="form-control" runat="server" ForeColor="Black"></asp:TextBox>
                         <asp:Label ID="Label3" runat="server" Text="Label">years</asp:Label>
                         
                         <br />
                         <br />
                         <asp:Label ID="Label4" runat="server" Text="Label" CssClass="labelF">Interest Rate <asp:RequiredFieldValidator ID="TxtIntRateV" runat="server" ControlToValidate="TxtIntRate" ForeColor="red">*</asp:RequiredFieldValidator></asp:Label>
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         <asp:TextBox ID="TxtIntRate" CssClass="form-control" runat="server" PlaceHolder="%" ForeColor="Black"></asp:TextBox>
                         
                          <br />
                          <br />
                          <asp:Label ID="Label5" runat="server" Text="Label" CssClass="labelF">Down Payment <asp:RequiredFieldValidator ID="txtDownPaymentV" runat="server" ControlToValidate="txtDownPayment" ForeColor="red">*</asp:RequiredFieldValidator></asp:Label>
                          &nbsp;&nbsp; 
                         <asp:TextBox ID="txtDownPayment" CssClass="form-control" runat="server" ForeColor="Black"></asp:TextBox>
                         
                          <br />
                          <br />
                         <asp:Label ID="Label6" runat="server" Text="Label" CssClass="labelA" >Monthly Payment is</asp:Label>
                         <asp:TextBox ID="TxtMonthPay" CssClass="form-control" runat="server" placeholder="Monthly Payment is here" Readonly="true"></asp:TextBox>
                         <br />
                          <br />
                          <br />
                         <asp:Button ID="BtnAmort" runat="server" Text="Amortization Calculator" OnClick="BtnAmort_Click" CssClass="btn btn-default" OnClientClick="" />
                         
       
                         <asp:Button ID="BtnReset" runat="server" Text="Reset" OnClick="BtnReset_Click" CssClass="btn btn-default" />
   
                    </div>
                    <div class="col-md-6 rightSide">
                        <h2>Result show in Chart</h2>
                        <asp:Label ID="LblResult" runat="server" ></asp:Label>
                    <%--<div id="chartContainer" ></div>--%>
                    <asp:UpdatePanel ID="chartContainer" runat="server"></asp:UpdatePanel>       
                    </div>
                 </div>
                   
                     <br />
            <div class="col-md-12" id="lblExtra" runat="server" visible ="false">
            <asp:Label ID="Lbltipaid" runat="server" Visible="false">Total Interest you will be Paid: </asp:Label>
            <asp:Label ID="lblTIP" runat="server" ></asp:Label>
            <br />
            <br />
            <asp:Label ID="Lblmpaid" runat="server" Text="Label" Visible="false">Monthly Mortgage Payment: </asp:Label>
            <asp:Label ID="lblMP" runat="server" ></asp:Label>
            <br />
            <br />
        
         <div class="col-md-12 label-info ">
           <asp:Label ID="LblAmort" runat="server" Visible="false" CssClass="label-info">Amortization Calculation </asp:Label>
         </div> 
     </div>
        <div class="col-md-10 col-md-offset-1">
             <asp:panel  ID ="pnlAmort" runat ="server" Visible="false" >
               <asp:GridView ID="gvAmort" runat="server" CellPadding="4" ForeColor="#ecd49c" GridLines="None" Width="100%" ><%--AllowPaging="True" OnPageIndexChanging="gvAmort_PageIndexChanging"--%>
                 <RowStyle BackColor="#5A7998" HorizontalAlign="Center" Font-Names="verdana" Font-Size="Small" />
                 <FooterStyle BackColor="#004080" Font-Bold="True" ForeColor="White" />
                 <HeaderStyle BackColor="#004080" Font-Bold="True" HorizontalAlign="Center" ForeColor="White" />
                 <AlternatingRowStyle BackColor="#213E51" />
             </asp:GridView>
            </asp:panel>
        </div>
                    </contenttemplate>
       </asp:UpdatePanel>
      
          </form>
         
       
     </div>
    </div>
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.2.1.min.js" ></script>
    <script src="MyScript.js"></script>
   <%-- <script>
        $('#LblAmort').click(function () {
            $('#lblExtra').show();
        });
    </script>--%>
  </body>
</html>

