using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdminDisplay : System.Web.UI.Page
{
    ClsDml dm = new ClsDml();
    protected void Page_Load(object sender, EventArgs e)
    { if(!IsPostBack)
        {
            getbindData();
        }

    }
    protected void getbindData()
    {
        DataTable dt = dm.GetBindData(1, 1);
        if(dt.Rows.Count > 0)
        {
            //gridService.DataSource = dt;
            //gridService.DataBind();

        }
    }
}