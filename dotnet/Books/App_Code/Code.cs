using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Books.App_Code
{
    public class Code
    {
        //This function sets which elements of the page are visable at what point
        public void tableState(DropDownList DropDownList, GridView GridView1, GridView GridView2, DetailsView BooksDetailsView, DetailsView DvdsDetailsView)
        {
            if (DropDownList.SelectedValue.ToString() == "Books")
            {
                GridView1.Visible = true;
                GridView2.Visible = false;
                BooksDetailsView.Visible = false;
                DvdsDetailsView.Visible = false;
            }
            else
            {
                GridView1.Visible = false;
                GridView2.Visible = true;
                BooksDetailsView.Visible = false;
                DvdsDetailsView.Visible = false;
            }
        }

        //This function checks to make sure a user is logged in before allowing acces to edit and delete functionality
        public CommandField buttonSecurity()
        {
            CommandField commmand = new CommandField();
            commmand.ValidationGroup = "AllValidators";
            commmand.ShowInsertButton = true;

            if (Roles.IsUserInRole("Member"))
            {
                commmand.ShowDeleteButton = true;
                commmand.ShowEditButton = true;

            }
            else
            {
                commmand.ShowDeleteButton = false;
                commmand.ShowEditButton = false;
            }

            return commmand;
        }

        //This function shows the detail view for a data grid when the select button is pressed
        public void dataDetailSelection(DetailsView DetailView, GridView GridView)
        {
            DetailView.Visible = true;
            DetailView.PageIndex = GridView.SelectedIndex;
        }
    }
}