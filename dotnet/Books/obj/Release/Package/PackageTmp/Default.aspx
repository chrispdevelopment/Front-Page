<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Books._Default" %>


<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <h2>Tables</h2>
            </hgroup>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <asp:SqlDataSource ID="Books" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Books] WHERE [Imdb] = @original_Imdb AND [Name] = @original_Name AND [Author] = @original_Author AND (([YearOfPub] = @original_YearOfPub) OR ([YearOfPub] IS NULL AND @original_YearOfPub IS NULL)) AND [cost] = @original_cost" InsertCommand="INSERT INTO [Books] ([Imdb], [Name], [Author], [YearOfPub], [cost]) VALUES (@Imdb, @Name, @Author, @YearOfPub, @cost)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Books]" UpdateCommand="UPDATE [Books] SET [Name] = @Name, [Author] = @Author, [YearOfPub] = @YearOfPub, [cost] = @cost WHERE [Imdb] = @original_Imdb AND [Name] = @original_Name AND [Author] = @original_Author AND (([YearOfPub] = @original_YearOfPub) OR ([YearOfPub] IS NULL AND @original_YearOfPub IS NULL)) AND [cost] = @original_cost">
        <DeleteParameters>
            <asp:Parameter Name="original_Imdb" Type="Decimal" />
            <asp:Parameter Name="original_Name" Type="String" />
            <asp:Parameter Name="original_Author" Type="String" />
            <asp:Parameter Name="original_YearOfPub" Type="DateTime" />
            <asp:Parameter Name="original_cost" Type="Double" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Imdb" Type="Decimal" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Author" Type="String" />
            <asp:Parameter Name="YearOfPub" Type="DateTime" />
            <asp:Parameter Name="cost" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Author" Type="String" />
            <asp:Parameter Name="YearOfPub" Type="DateTime" />
            <asp:Parameter Name="cost" Type="Double" />
            <asp:Parameter Name="original_Imdb" Type="Decimal" />
            <asp:Parameter Name="original_Name" Type="String" />
            <asp:Parameter Name="original_Author" Type="String" />
            <asp:Parameter Name="original_YearOfPub" Type="DateTime" />
            <asp:Parameter Name="original_cost" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Dvds" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Dvds] WHERE [Imdb] = @original_Imdb AND [Name] = @original_Name AND [Director] = @original_Director AND [YearOfRelease] = @original_YearOfRelease AND [cost] = @original_cost" InsertCommand="INSERT INTO [Dvds] ([Imdb], [Name], [Director], [YearOfRelease], [cost]) VALUES (@Imdb, @Name, @Director, @YearOfRelease, @cost)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Dvds]" UpdateCommand="UPDATE [Dvds] SET [Name] = @Name, [Director] = @Director, [YearOfRelease] = @YearOfRelease, [cost] = @cost WHERE [Imdb] = @original_Imdb AND [Name] = @original_Name AND [Director] = @original_Director AND [YearOfRelease] = @original_YearOfRelease AND [cost] = @original_cost">
        <DeleteParameters>
            <asp:Parameter Name="original_Imdb" Type="Decimal" />
            <asp:Parameter Name="original_Name" Type="String" />
            <asp:Parameter Name="original_Director" Type="String" />
            <asp:Parameter Name="original_YearOfRelease" Type="DateTime" />
            <asp:Parameter Name="original_cost" Type="Double" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Imdb" Type="Decimal" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Director" Type="String" />
            <asp:Parameter Name="YearOfRelease" Type="DateTime" />
            <asp:Parameter Name="cost" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Director" Type="String" />
            <asp:Parameter Name="YearOfRelease" Type="DateTime" />
            <asp:Parameter Name="cost" Type="Double" />
            <asp:Parameter Name="original_Imdb" Type="Decimal" />
            <asp:Parameter Name="original_Name" Type="String" />
            <asp:Parameter Name="original_Director" Type="String" />
            <asp:Parameter Name="original_YearOfRelease" Type="DateTime" />
            <asp:Parameter Name="original_cost" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Tables" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [Tables]"></asp:SqlDataSource>

    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="Tables" DataTextField="name" DataValueField="name" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>

    <div id="books">
        <div id="booksTable">
            <asp:GridView ID="BooksGridView" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="Imdb" DataSourceID="Books" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" AllowPaging="True" OnSelectedIndexChanged="BooksGridView_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Imdb" HeaderText="Imdb" SortExpression="Imdb" ReadOnly="True" >
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author" />
                    <asp:BoundField DataField="YearOfPub" HeaderText="Year Of Publication" SortExpression="YearOfPub" DataFormatString="{0:dd/MM/yyyy}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="cost" DataFormatString="{0:c}" HeaderText="Cost" SortExpression="cost" />
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
        </div>
        <div id="booksDetail">
            <asp:DetailsView ID="BooksDetailsView" runat="server" Height="50px" Width="400px" DataSourceID="Books" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AutoGenerateRows="False" DataKeyNames="Imdb" ValidateRequestMode="Enabled" >
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <Fields>
                    <asp:TemplateField HeaderText="Imdb" SortExpression="Imdb">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Imdb") %>'></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired0" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtBookImdbInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtBookImdbInsert" runat="server" Text='<%# Bind("Imdb") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Imdb") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired1" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtBookNameEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtBookNameEdit" runat="server" Text='<%# Bind("Name") %>' ValidationGroup="AllValidators"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired2" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtBookNameInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtBookNameInsert" runat="server" Text='<%# Bind("Name") %>' ValidationGroup="AllValidators"></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Author" SortExpression="Author">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired3" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtAuthorEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAuthorEdit" runat="server" Text='<%# Bind("Author") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired4" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtAuthorInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAuthorInsert" runat="server" Text='<%# Bind("Author") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Author") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Year Of Publication" SortExpression="YearOfPub">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired5" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtYearofPubEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtYearofPubEdit" runat="server" Text='<%# Bind("YearOfPub", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired6" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="calYearofPubInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="calYearofPubInsert" runat="server" Text='<%# Bind("YearOfPub", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("YearOfPub", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cost" SortExpression="cost">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired7" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtBookCostEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtBookCostEdit" runat="server" Text='<%# Bind("cost", "{0:c}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="NameRequired8" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtBookCostInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtBookCostInsert" runat="server" Text='<%# Bind("cost", "{0:c}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("cost", "{0:c}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            </asp:DetailsView>
        </div>
    </div>

    <div id="dvds">
        <div id="dvdsTable">
            <asp:GridView ID="DvdsGridView" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Imdb" DataSourceID="Dvds" OnSelectedIndexChanged="DvdsGridView_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Imdb" HeaderText="Imdb" ReadOnly="True" SortExpression="Imdb" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Director" HeaderText="Director" SortExpression="Director" />
                    <asp:BoundField DataField="YearOfRelease" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Year Of Release" SortExpression="YearOfRelease" />
                    <asp:BoundField DataField="cost" DataFormatString="{0:c}" HeaderText="Cost" SortExpression="cost" />
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
        </div>
        <div id="dvdsDetail">
            <asp:DetailsView ID="DvdsDetailsView" runat="server" Height="50px" Width="400px" DataSourceID="Dvds" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AutoGenerateRows="False" DataKeyNames="Imdb">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <Fields>
                    <asp:TemplateField HeaderText="Imdb" SortExpression="Imdb">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Imdb") %>'></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="Required9" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDvdsImdbInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDvdsImdbInsert" runat="server" Text='<%# Bind("Imdb") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Imdb") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="Required10" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDvdsEditName" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDvdsEditName" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="Required11" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDvdsInsertName" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDvdsInserName" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Director" SortExpression="Director">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="Required12" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDirectorEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDirectorEdit" runat="server" Text='<%# Bind("Director") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="Required13" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDirectorInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDirectorInsert" runat="server" Text='<%# Bind("Director") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Director") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Year Of Release" SortExpression="YearOfRelease">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="Required14" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtYearOfRelEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtYearOfRelEdit" runat="server" Text='<%# Bind("YearOfRelease", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="Required15" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtYearOfRelInsert" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtYearOfRelInsert" runat="server" Text='<%# Bind("YearOfRelease", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("YearOfRelease", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cost" SortExpression="cost">
                        <EditItemTemplate>
                            <asp:RequiredFieldValidator ID="Required16" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDvdsCostEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDvdsCostEdit" runat="server" Text='<%# Bind("cost", "{0:c}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:RequiredFieldValidator ID="Required17" runat="server" ErrorMessage="A name is required" 
                                ControlToValidate="txtDvdsCostEdit" Display="Dynamic" Text="* Required Field" ValidationGroup="AllValidators" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtDvdsCostEdit" runat="server" Text='<%# Bind("cost", "{0:c}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("cost", "{0:c}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            </asp:DetailsView>
        </div>
    </div>
    
</asp:Content>
