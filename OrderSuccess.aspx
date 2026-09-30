<%@ Page Title="Order Confirmed" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="OrderSuccess.aspx.cs" Inherits="FoodOrdering.OrderSuccess" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="success-page"><div class="success-card"><div class="success-icon">✓</div><span class="eyebrow">ORDER CONFIRMED</span><h1>Thank you.<br /><em>Your food is coming.</em></h1><p>Your order has been placed successfully. Keep your order ID for reference.</p><asp:Label ID="lblOrderId" runat="server" CssClass="order-id"></asp:Label><div class="hero-buttons center"><a href="Orders.aspx" class="btn btn-primary">View my orders</a><a href="Menu.aspx" class="text-link">Order something else -></a></div></div></section>
</asp:Content>
