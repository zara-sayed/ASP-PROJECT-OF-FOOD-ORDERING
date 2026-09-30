<%@ Page Title="Menu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="FoodOrdering.Menu" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="page-section menu-page">
    <div class="page-hero">
        <span class="eyebrow">THE MENU</span>
        <h1>Find something<br /><em>delicious.</em></h1>
        <p>Comfort food, little treats and everyday favourites.</p>
    </div>
    <div class="filter-row">
        <a href="Menu.aspx" class="filter-pill">All</a>
        <a href="Menu.aspx?category=Pizza" class="filter-pill">Pizza</a>
        <a href="Menu.aspx?category=Burger" class="filter-pill">Burgers</a>
        <a href="Menu.aspx?category=Pasta" class="filter-pill">Pasta</a>
        <a href="Menu.aspx?category=Asian" class="filter-pill">Asian</a>
        <a href="Menu.aspx?category=Indian" class="filter-pill">Indian</a>
        <a href="Menu.aspx?category=Snacks" class="filter-pill">Snacks</a>
        <a href="Menu.aspx?category=Dessert" class="filter-pill">Desserts</a>
        <a href="Menu.aspx?category=Drinks" class="filter-pill">Drinks</a>
        <a href="Cart.aspx" class="cart-shortcut">View cart -></a>
    </div>
    <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    <div class="food-grid">
        <asp:Repeater ID="rptMenu" runat="server" OnItemCommand="rptMenu_ItemCommand">
            <ItemTemplate>
                <article class="food-card">
                    <div class="food-photo"><img class="image-fallback" src="<%# Eval("ImageUrl") %>" alt="<%# Eval("FoodName") %>" onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=85';" /><span><%# Eval("Category") %></span></div>
                    <div class="food-info">
                        <div class="food-title-row"><h3><%# Eval("FoodName") %></h3><strong>Rs <%# Eval("Price", "{0:0}") %></strong></div>
                        <p><%# Eval("Description") %></p>
                        <div class="food-qty-row">
                            <span>Qty</span>
                            <asp:DropDownList ID="ddlQty" runat="server" CssClass="food-qty">
                                <asp:ListItem Text="1" Value="1" Selected="True" />
                                <asp:ListItem Text="2" Value="2" />
                                <asp:ListItem Text="3" Value="3" />
                                <asp:ListItem Text="4" Value="4" />
                                <asp:ListItem Text="5" Value="5" />
                                <asp:ListItem Text="6" Value="6" />
                                <asp:ListItem Text="7" Value="7" />
                                <asp:ListItem Text="8" Value="8" />
                                <asp:ListItem Text="9" Value="9" />
                                <asp:ListItem Text="10" Value="10" />
                            </asp:DropDownList>
                        </div>
                        <asp:LinkButton ID="btnAdd" runat="server" CssClass="add-cart" CommandName="Add" CommandArgument='<%# Eval("FoodId") %>'>Add to cart <span>+</span></asp:LinkButton>
                    </div>
                </article>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</section>
</asp:Content>
