<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="FoodOrdering.Checkout" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server">
<script type="text/javascript">
function togglePaymentDetails() {
    var ddl = document.getElementById('<%= ddlPayment.ClientID %>');
    var upi = document.getElementById('<%= pnlUpi.ClientID %>');
    var card = document.getElementById('<%= pnlCard.ClientID %>');
    if (!ddl) return;
    upi.style.display = ddl.value === 'UPI' ? 'block' : 'none';
    card.style.display = ddl.value === 'Card' ? 'block' : 'none';
}
window.addEventListener('load', togglePaymentDetails);
</script>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="page-section checkout-page">
    <div class="page-title-row"><div><span class="eyebrow">CHECKOUT</span><h1>One last step.</h1><p>Enter your delivery details and place your order.</p></div></div>
    <div class="checkout-layout">
        <div class="checkout-form-card">
            <span class="eyebrow">DELIVERY DETAILS</span><h2>Where should we send it?</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            <div class="field"><label>Full name</label><asp:TextBox ID="txtName" runat="server" CssClass="input" /></div>
            <div class="field"><label>Phone number</label><asp:TextBox ID="txtPhone" runat="server" CssClass="input" /></div>
            <div class="field"><label>Delivery address</label><asp:TextBox ID="txtAddress" runat="server" CssClass="input textarea" TextMode="MultiLine" Rows="4" /></div>
            <div class="field"><label>Payment method</label><asp:DropDownList ID="ddlPayment" runat="server" CssClass="input select" onchange="togglePaymentDetails();">
                <asp:ListItem Text="Cash on Delivery" Value="Cash on Delivery" />
                <asp:ListItem Text="UPI" Value="UPI" />
                <asp:ListItem Text="Card" Value="Card" />
            </asp:DropDownList></div>
            <asp:Panel ID="pnlUpi" runat="server" style="display:none;">
                <div class="field"><label>UPI ID</label><asp:TextBox ID="txtUpiId" runat="server" CssClass="input" placeholder="example@upi" /></div>
            </asp:Panel>
            <asp:Panel ID="pnlCard" runat="server" style="display:none;">
                <div class="field"><label>Cardholder name</label><asp:TextBox ID="txtCardName" runat="server" CssClass="input" /></div>
                <div class="field"><label>Card number</label><asp:TextBox ID="txtCardNumber" runat="server" CssClass="input" MaxLength="19" placeholder="1234 5678 9012 3456" /></div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                    <div class="field"><label>Expiry (MM/YY)</label><asp:TextBox ID="txtCardExpiry" runat="server" CssClass="input" MaxLength="5" placeholder="MM/YY" /></div>
                    <div class="field"><label>CVV</label><asp:TextBox ID="txtCardCvv" runat="server" CssClass="input" TextMode="Password" MaxLength="4" placeholder="CVV" /></div>
                </div>
            </asp:Panel>
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place order" CssClass="btn btn-primary btn-full" OnClick="btnPlaceOrder_Click" />
        </div>
        <div class="checkout-side"><div class="side-number">01</div><h3>Check your details.</h3><p>Make sure your name, phone number and address are correct before placing the order.</p><div class="side-number">02</div><h3>Choose payment.</h3><p>Select Cash on Delivery, UPI or Card.</p><div class="side-number">03</div><h3>Place your order.</h3><p>You will receive an order ID immediately after a successful checkout.</p></div>
    </div>
</section>
</asp:Content>
