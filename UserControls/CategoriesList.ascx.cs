using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class CategoriesList : System.Web.UI.UserControl
{
    public bool selected;
  protected void Page_Load(object sender, EventArgs e)
  {
    // don't reload data during postbacks
    if (!IsPostBack)
    {
      // Obtain the ID of the selected department
      string departmentId = Request.QueryString["DepartmentID"];
      selected = false; 
      // Continue only if DepartmentID exists in the query string
      if (departmentId != null)
      {
          selected = true;
        // Catalog.GetCategoriesInDepartment returns a DataTable object containing
        // category data, which is displayed by the DataList
        listR.DataSource = CatalogAccess.GetCategoriesInDepartment(departmentId);
        // Needed to bind the data bound controls to the data source
        listR.DataBind();
        // Make space for the next control
        //brLabel.Text = "<br />";
      }
    }
  }
}
