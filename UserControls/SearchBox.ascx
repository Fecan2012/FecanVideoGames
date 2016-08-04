<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SearchBox.ascx.cs" Inherits="SearchBox" %>

      <asp:TextBox ID="searchTextBox" Runat="server" Width="128px"  BorderStyle="Dotted" MaxLength="100" Height="16px" >search for..</asp:TextBox>
      <asp:Button ID="goButton" Runat="server"  Text="Go!" Width="36px" Height="21px" OnClick="goButton_Click" />
       <span style="display:none"><asp:CheckBox ID="allWordsCheckBox"  Runat="server" Text="Search for all words" /></span>

    
 
