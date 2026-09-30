<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="FoodOrdering.Login" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="auth-layout">
    <div class="auth-visual login-visual"><span class="eyebrow">WELCOME BACK</span><h1>Your table is<br /><em>waiting.</em></h1><p>Sign in to keep your order history in one place and make checkout even faster.</p></div>
    <div class="auth-card">
        <span class="eyebrow">SIGN IN</span><h2>Welcome back.</h2><p class="auth-subtitle">Enter your details to continue.</p>
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        <div class="field"><label>Email address</label><asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email" /></div>
        <div class="field"><label>Password</label><asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" /></div>
        <asp:Button ID="btnLogin" runat="server" Text="Sign in" CssClass="btn btn-primary btn-full" OnClick="btnLogin_Click" />
        <p class="switch-text">New here? <a href="Register.aspx">Create an account</a></p>
    </div>
</section>
</asp:Content>
