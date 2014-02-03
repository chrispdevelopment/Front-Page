using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Books.App_Code;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UnitTestProject
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestTableState()
        {
            DropDownList DropDownList = new DropDownList();
            GridView GridView1 = new GridView();
            GridView GridView2 = new GridView();
            DetailsView BooksDetailsView = new DetailsView();
            DetailsView DvdsDetailsView = new DetailsView();
            Boolean expectedSelection = true;
            Boolean expectedGridViewVis1 = true;
            Boolean expectedGridViewVis2 = false;
            Boolean expectedDetailsViewVis1 = false;
            Boolean expectedDetailsViewVis2 = false;

            Code code = new Code();
            DropDownList.Items.Add("Books");
            DropDownList.SelectedValue = "Books";
            //GridView1.Visible = true;
            //GridView2.Visible = false;
            //BooksDetailsView.Visible = false;
            //DvdsDetailsView.Visible = false;

            code.tableState(DropDownList, GridView1, GridView2, BooksDetailsView, DvdsDetailsView);

            Boolean actualSelection = Convert.ToBoolean(GridView1.Visible.ToString());
            Boolean actualGridViewVis1 = Convert.ToBoolean(GridView1.Visible.ToString());
            Boolean actualGridViewVis2 = Convert.ToBoolean(GridView2.Visible.ToString());
            Boolean actualDetailsViewVis1 = Convert.ToBoolean(BooksDetailsView.Visible.ToString());
            Boolean actualDetailsViewVis2 = Convert.ToBoolean(DvdsDetailsView.Visible.ToString());

            Assert.AreEqual(expectedSelection, actualSelection, "Dropdown selected item not Book");
            Assert.AreEqual(expectedGridViewVis1, actualGridViewVis1, "Gridview visibilty setting wrong");
            Assert.AreEqual(expectedGridViewVis2, actualGridViewVis2, "Gridview visibilty setting wrong");
            Assert.AreEqual(expectedDetailsViewVis1, actualDetailsViewVis1, "Detailsview visibilty setting wrong");
            Assert.AreEqual(expectedDetailsViewVis2, actualDetailsViewVis2, "Detailsview visibilty setting wrong");
        }
    }
}
