<%@ Page Language="C#" MasterPageFile="~/BalloonShop.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Welcome to Fecan Video Games!" %>

<%@ Register Src="UserControls/ProductsList.ascx" TagName="ProductsList" TagPrefix="uc1" %>
<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="server">
    <span class="CatalogTitle">Welcome to Fecan Video Games! </span>
  <br />
  <span class="CatalogDescription">This week we have a special price for these fantastic products:<br />
      <br />
      <div style="margin-left:40px;">
      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="productFront" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" ShowHeader="False">
      <Columns>
          <asp:TemplateField HeaderText="Name" SortExpression="Name">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# "<a href=\" /Product.aspx?ProductID="+Eval("ProductID")+"  \">"+Eval("Name")+ "</a>" %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Thumbnail" SortExpression="Thumbnail">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Thumbnail") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:Image ID="Image1" runat="server" ImageUrl='<%# "ProductImages/"+Eval("Thumbnail") %>' />
              </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:c}" />
          <asp:CheckBoxField DataField="PromoFront" HeaderText="PromoFront" SortExpression="PromoFront" Visible="False" />
      </Columns>
</asp:GridView>
      <br />
&nbsp;</span><asp:SqlDataSource ID="productFront" runat="server" ConnectionString="<%$ ConnectionStrings:BalloonShopConnection %>" SelectCommand="SELECT [ProductID], [Name], [Price], [PromoFront], [Thumbnail] FROM [Product] WHERE ([PromoFront] = @PromoFront)">
    <SelectParameters>
        <asp:Parameter DefaultValue="True" Name="PromoFront" Type="Boolean" />
    </SelectParameters>
</asp:SqlDataSource>
  <br />
  </asp:Content>