<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="FoodOrdering.Default" %>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
<section class="hero">
    <div class="hero-content">
        <span class="eyebrow">FRESH FOOD => EASY ORDERING</span>
        <h1>Good food,<br /><em>good mood.</em></h1>
        <p>From cheesy pizzas to comforting pasta and sweet finishes, discover food made for the moments you actually want to enjoy.</p>
        <div class="hero-buttons">
            <a href="Menu.aspx" class="btn btn-primary">Explore the menu</a>
            <a href="Register.aspx" class="text-link">Create an account <span>-></span></a>
        </div>
        <div class="hero-stats">
            <div><strong>48+</strong><span>Signature dishes</span></div>
            <div><strong>30 min</strong><span>Average delivery</span></div>
            <div><strong>Fresh</strong><span>Made to order</span></div>
        </div>
    </div>
    <div class="hero-art">
        <div class="hero-image-card">
            <img class="image-fallback" src="https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=1100&q=85" alt="Fresh food spread" onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1100&q=85';" />
        </div>
        <div class="hero-float-card">
            <span class="float-dot"></span>
            <div><small>OUR PICK</small><strong>Comfort Food Collection</strong></div>
        </div>
        <div class="hero-circle">Taste<br />the<br /><span>good</span></div>
    </div>
</section>

<section class="section categories-section">
    <div class="section-head">
        <div><span class="eyebrow">WHAT ARE YOU CRAVING?</span><h2>Pick your favourite.</h2></div>
        <a href="Menu.aspx" class="text-link">View full menu <span>-></span></a>
    </div>
    <div class="category-grid">
        <a href="Menu.aspx?category=Pizza" class="category-card cat-pizza"><span>01</span><h3>Pizza</h3><p>Freshly baked and loaded.</p></a>
        <a href="Menu.aspx?category=Burger" class="category-card cat-burger"><span>02</span><h3>Burgers</h3><p>Big flavours, soft buns.</p></a>
        <a href="Menu.aspx?category=Pasta" class="category-card cat-pasta"><span>03</span><h3>Pasta</h3><p>Rich, warm and comforting.</p></a>
        <a href="Menu.aspx?category=Asian" class="category-card cat-asian"><span>04</span><h3>Asian</h3><p>Wok-tossed favourites and more.</p></a>
        <a href="Menu.aspx?category=Indian" class="category-card cat-indian"><span>05</span><h3>Indian</h3><p>Classic spices and comfort food.</p></a>
        <a href="Menu.aspx?category=Snacks" class="category-card cat-snacks"><span>06</span><h3>Snacks</h3><p>Perfect for sharing.</p></a>
        <a href="Menu.aspx?category=Dessert" class="category-card cat-dessert"><span>07</span><h3>Desserts</h3><p>Save room for something sweet.</p></a>
        <a href="Menu.aspx?category=Drinks" class="category-card cat-drinks"><span>08</span><h3>Drinks</h3><p>Cool, creamy and refreshing.</p></a>
    </div>
</section>

<section class="feature-banner">
    <div><span class="eyebrow">A LITTLE SOMETHING EXTRA</span><h2>Your next favourite meal is closer than you think.</h2><p>Browse the menu, add your favourites to the cart and place your order in a few simple steps.</p></div>
    <a href="Menu.aspx" class="btn btn-dark">Start ordering</a>
</section>
</asp:Content>
