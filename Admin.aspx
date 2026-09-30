<%@ Page Title="Admin Panel" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="FoodOrdering.Admin" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="page-section">
    <div class="page-title-row"><div><span class="eyebrow">ADMIN PANEL</span><h1>Manage Crave &amp; Co.</h1><p>Welcome, <asp:Literal ID="litAdminName" runat="server"></asp:Literal>. Manage menu items and orders.</p></div><asp:LinkButton ID="btnAdminLogout" runat="server" CssClass="btn btn-light" OnClick="btnAdminLogout_Click">Admin logout</asp:LinkButton></div>
    <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    <div class="admin-stat-grid">
        <div class="admin-stat"><strong><asp:Literal ID="litFoods" runat="server">0</asp:Literal></strong><span>Total food items</span></div>
        <div class="admin-stat"><strong><asp:Literal ID="litAvailable" runat="server">0</asp:Literal></strong><span>Available items</span></div>
        <div class="admin-stat"><strong><asp:Literal ID="litOrders" runat="server">0</asp:Literal></strong><span>Total orders</span></div>
        <div class="admin-stat"><strong>Rs <asp:Literal ID="litSales" runat="server">0.00</asp:Literal></strong><span>Total order value</span></div>
    </div>

    <div class="admin-card">
        <h2>Add food item</h2>
        <div class="admin-form-grid">
            <div class="field"><label>Food name</label><asp:TextBox ID="txtFoodName" runat="server" CssClass="admin-input" /></div>
            <div class="field"><label>Category</label><asp:TextBox ID="txtCategory" runat="server" CssClass="admin-input" /></div>
            <div class="field"><label>Price (Rs)</label><asp:TextBox ID="txtPrice" runat="server" CssClass="admin-input" /></div>
            <div class="field"><label>Image URL</label><asp:TextBox ID="txtImageUrl" runat="server" CssClass="admin-input" /></div>
            <div class="field full"><label>Description</label><asp:TextBox ID="txtDescription" runat="server" CssClass="admin-input" /></div>
            <div class="full"><asp:Button ID="btnAddFood" runat="server" Text="Add food item" CssClass="btn btn-primary" CausesValidation="false" UseSubmitBehavior="false" OnClick="btnAddFood_Click" /></div>
        </div>
    </div>

    <div class="admin-card">
        <h2>Food items</h2>
        <asp:Repeater ID="rptFoods" runat="server" OnItemCommand="rptFoods_ItemCommand">
            <HeaderTemplate><table class="admin-table"><tr><th>ID</th><th>Food</th><th>Category</th><th>Price (Rs)</th><th>Available</th><th>Action</th></tr></HeaderTemplate>
            <ItemTemplate><tr>
                <td><%# Eval("FoodId") %><asp:HiddenField ID="hidFoodId" runat="server" Value='<%# Eval("FoodId") %>' /></td>
                <td><asp:TextBox ID="txtName" runat="server" CssClass="admin-input" Text='<%# Eval("FoodName") %>' /></td>
                <td><asp:TextBox ID="txtCat" runat="server" CssClass="admin-input" Text='<%# Eval("Category") %>' /></td>
                <td><asp:TextBox ID="txtItemPrice" runat="server" CssClass="admin-input" Text='<%# Eval("Price", "{0:0.00}") %>' /></td>
                <td><asp:CheckBox ID="chkAvailable" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsAvailable")) %>' /></td>
                <td><asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-primary" CommandName="UpdateFood" CommandArgument='<%# Eval("FoodId") %>'>Save</asp:LinkButton></td>
            </tr></ItemTemplate>
            <FooterTemplate></table></FooterTemplate>
        </asp:Repeater>
    </div>

    <div class="admin-card">
        <h2>Customer orders</h2>
        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="admin-table" GridLines="None" OnRowCommand="gvOrders_RowCommand">
            <Columns>
                <asp:BoundField DataField="OrderId" HeaderText="Order" />
                <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Total (Rs)" DataFormatString="{0:0.00}" />
                <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                <asp:TemplateField HeaderText="Status"><ItemTemplate><asp:DropDownList ID="ddlStatus" runat="server" CssClass="admin-input" SelectedValue='<%# Eval("OrderStatus") %>'><asp:ListItem>Placed</asp:ListItem><asp:ListItem>Preparing</asp:ListItem><asp:ListItem>Out for Delivery</asp:ListItem><asp:ListItem>Delivered</asp:ListItem><asp:ListItem>Cancelled</asp:ListItem></asp:DropDownList></ItemTemplate></asp:TemplateField>
                <asp:TemplateField HeaderText="Action"><ItemTemplate><asp:LinkButton ID="btnStatus" runat="server" CssClass="btn btn-primary" CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderId") %>'>Update</asp:LinkButton></ItemTemplate></asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</section>
</asp:Content>
