<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="FoodOrdering.AdminLogin" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="auth-layout">
    <div class="auth-visual">
        <span class="eyebrow">ADMIN PANEL</span>
        <h1>Manage your<br /><em>restaurant.</em></h1>
        <p>Manage menu items, prices, availability and customer orders from one place.</p>
        <div class="visual-points"><span>Food item management</span><span>Order management</span><span>INR pricing</span></div>
    </div>
    <div class="auth-card">
        <span class="eyebrow">ADMIN ACCESS</span><h2>Welcome back.</h2><p class="auth-subtitle">Sign in to open the Crave &amp; Co. admin panel.</p>
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        <div class="field"><label>Email</label><asp:TextBox ID="txtEmail" runat="server" CssClass="input" Text="admin@craveco.local" /></div>
        <div class="field"><label>Password</label><asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" /></div>
        <asp:Button ID="btnLogin" runat="server" Text="Login to admin panel" CssClass="btn btn-primary btn-full" OnClick="btnLogin_Click" />
        <p class="switch-text"><a href="Default.aspx">Back to website</a></p>
    </div>
</section>
</asp:Content>
