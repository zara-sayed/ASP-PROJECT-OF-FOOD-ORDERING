<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="FoodOrdering.Orders" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="page-section orders-page">
    <div class="page-title-row"><div><span class="eyebrow">YOUR HISTORY</span><h1>My orders.</h1><p>Everything you have ordered, all in one place.</p></div><a href="Menu.aspx" class="btn btn-primary">Order again</a></div>
    <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    <div class="orders-list"><asp:Repeater ID="rptOrders" runat="server"><ItemTemplate><article class="order-card"><div class="order-top"><div><small>ORDER ID</small><strong>#<%# Eval("OrderId") %></strong></div><span class="status-pill"><%# Eval("OrderStatus") %></span></div><div class="order-details"><div><small>Placed</small><span><%# Eval("OrderDate", "{0:dd MMM yyyy, hh:mm tt}") %></span></div><div><small>Payment</small><span><%# Eval("PaymentMethod") %></span></div><div><small>Total</small><span>₹<%# Eval("TotalAmount", "{0:0.00}") %></span></div></div></article></ItemTemplate></asp:Repeater></div>
</section>
</asp:Content>
