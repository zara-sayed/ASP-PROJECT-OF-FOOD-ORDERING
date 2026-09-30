<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="FoodOrdering.Register" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="auth-layout register-layout">
    <div class="auth-visual register-visual"><span class="eyebrow">JOIN CRAVE &amp; CO.</span><h1>Make every<br /><em>craving count.</em></h1><p>Create your account once and keep your details ready for your next order.</p><div class="visual-points"><span>01&nbsp; Easy checkout</span><span>02&nbsp; Order history</span><span>03&nbsp; Faster reorders</span></div></div>
    <div class="auth-card">
        <span class="eyebrow">CREATE ACCOUNT</span><h2>Let's get started.</h2><p class="auth-subtitle">A few details and you are ready to order.</p>
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        <div class="field"><label>Full name</label><asp:TextBox ID="txtName" runat="server" CssClass="input" /></div>
        <div class="field"><label>Email address</label><asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email" /></div>
        <div class="field"><label>Phone number</label><asp:TextBox ID="txtPhone" runat="server" CssClass="input" /></div>
        <div class="field"><label>Password</label><asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" /></div>
        <asp:Button ID="btnRegister" runat="server" Text="Create account" CssClass="btn btn-primary btn-full" OnClick="btnRegister_Click" />
        <p class="switch-text">Already have an account? <a href="Login.aspx">Sign in</a></p>
    </div>
</section>
</asp:Content>
