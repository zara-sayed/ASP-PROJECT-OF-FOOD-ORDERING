<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="FoodOrdering.Cart" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="page-section cart-page">
    <div class="page-title-row"><div><span class="eyebrow">YOUR SELECTION</span><h1>Your cart.</h1><p>Review your favourites before checkout.</p></div><a href="Menu.aspx" class="text-link">Continue shopping -></a></div>
    <asp:Panel ID="pnlEmpty" runat="server" CssClass="empty-card" Visible="false"><span class="empty-icon">+</span><h2>Your cart is empty.</h2><p>Add something delicious from the menu and it will appear here.</p><a href="Menu.aspx" class="btn btn-primary">Browse menu</a></asp:Panel>
    <asp:Panel ID="pnlCart" runat="server" Visible="false">
        <div class="cart-layout">
            <div class="cart-table-wrap">
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="cart-table" GridLines="None" OnRowCommand="gvCart_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="FoodName" HeaderText="Item" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="Rs {0:0.00}" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:BoundField DataField="SubTotal" HeaderText="Subtotal" DataFormatString="Rs {0:0.00}" />
                        <asp:ButtonField Text="Remove" CommandName="RemoveItem" ButtonType="Link" />
                    </Columns>
                </asp:GridView>
            </div>
            <aside class="summary-card">
                <span class="eyebrow">ORDER SUMMARY</span><h2>Almost yours.</h2>
                <div class="summary-line"><span>Food total</span><strong>Rs <asp:Label ID="lblTotal" runat="server">0.00</asp:Label></strong></div>
                <div class="summary-line muted"><span>Delivery</span><span>Included</span></div>
                <div class="summary-divider"></div>
                <div class="summary-line total-line"><span>Total</span><strong>Rs <asp:Label ID="lblTotal2" runat="server">0.00</asp:Label></strong></div>
                <a href="Checkout.aspx" class="btn btn-primary btn-full">Continue to checkout</a>
            </aside>
        </div>
    </asp:Panel>
</section>
</asp:Content>
