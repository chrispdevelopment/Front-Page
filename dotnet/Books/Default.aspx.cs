using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Books.App_Code;

namespace Books
{
    public partial class _Default : Page
    {
        Code code = new Code();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                BooksDetailsView.Fields.Add(code.buttonSecurity());
                DvdsDetailsView.Fields.Add(code.buttonSecurity());
                DvdsGridView.Visible = false;
                BooksDetailsView.Visible = false;
                DvdsDetailsView.Visible = false;
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            code.tableState(DropDownList1, BooksGridView, DvdsGridView, BooksDetailsView, DvdsDetailsView);
        }

        protected void BooksGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            code.dataDetailSelection(BooksDetailsView, BooksGridView);
        }

        protected void DvdsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            code.dataDetailSelection(DvdsDetailsView, DvdsGridView);
        }
    }
}