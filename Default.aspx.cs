using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Web.Script.Serialization;

public partial class _Default : System.Web.UI.Page
{
    double loanAmount = 0;
    double downPayment = 0;
    double termOfLoan = 0;
    double interestRate = 0;
    double monthlyPayment = 0;
    double deductBalance;
    double interestPaid;
    double decNewBalance;
    double dblTotalPayments;

    DataTable tblAmort = new DataTable("Amort");

    protected void Page_Load(object sender, EventArgs e)
    {

    }

   
    protected void BtnAmort_Click(object sender, EventArgs e)
    {
        try
        {
            Lbltipaid.Visible = true;
            Lblmpaid.Visible = true;
            LblAmort.Visible = true;
            LoadGridData();
            pnlAmort.Visible = true;
            //lblExtra.Attributes.Add("style","display:contents");
            lblExtra.Visible = true;
        }
        catch (Exception)
        {
            LblResult.Text = "You entered some invalid input. Please try again.";

        }
    }
    
    protected void BtnReset_Click(object sender, EventArgs e)
    {
        foreach (Control ctrl in form1.Controls)
        {
            //check for all the TextBox controls on the page and clear them

            if (ctrl.GetType() == typeof(TextBox))
            {
                ((TextBox)(ctrl)).Text = string.Empty;
            }
            txtLoanAmount.Text = "";
            TxtLTerm.Text = "";
            TxtIntRate.Text = "";
            txtDownPayment.Text = "";
            TxtMonthPay.Text = "";
            lblTIP.Text = "";
            lblMP.Text = "";
            LblAmort.Visible = false;
            Lbltipaid.Visible = false;
            Lblmpaid.Visible = false;
            gvAmort.DataSource = null;
            gvAmort.DataBind();
            pnlAmort.Visible = false;
            lblExtra.Visible = false;
        }
    }
    
    //protected void gvAmort_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvAmort.PageIndex = e.NewPageIndex;
    //    LoadGridData();
    //}
    protected void LoadGridData()
    {
        int intPmt = 1;
        loanAmount = Convert.ToDouble(txtLoanAmount.Text);
        downPayment = Convert.ToDouble(txtDownPayment.Text);
        termOfLoan = Convert.ToDouble(TxtLTerm.Text) * 12;
        interestRate = Convert.ToDouble(TxtIntRate.Text) / 100;
        double dblConvertInterest = interestRate / 12;
        double intNumOfPayments = termOfLoan;
        monthlyPayment = (loanAmount - downPayment) * (Math.Pow((1 + interestRate / 12), termOfLoan) * interestRate) / (12 * (Math.Pow((1 + interestRate / 12), termOfLoan) - 1));
        TxtMonthPay.Text = String.Format("{0:£.00}", monthlyPayment);

        double totalMP = (monthlyPayment * termOfLoan) - (loanAmount - downPayment);
        lblTIP.Text = String.Format("{0:£.00}", totalMP);
        lblMP.Text = String.Format("{0:£.00}", monthlyPayment);

        DateTime paymentDate = DateTime.Today.AddMonths(1);
        paymentDate = new DateTime(paymentDate.Year, paymentDate.Month, 15);
        dblTotalPayments = intNumOfPayments * monthlyPayment;
        decNewBalance = loanAmount - downPayment;

        tblAmort.Columns.Add("Sr.", System.Type.GetType("System.String"));
        tblAmort.Columns.Add("Date", System.Type.GetType("System.String"));
        tblAmort.Columns.Add("Monthly Payment", System.Type.GetType("System.String"));
        tblAmort.Columns.Add("Interest Amount", System.Type.GetType("System.String"));
        tblAmort.Columns.Add("Principal Paid_Amt", System.Type.GetType("System.String"));
        tblAmort.Columns.Add("Balance", System.Type.GetType("System.String"));
        
        DataRow tRow;
        double[] monthlyBalance = new double[(int)termOfLoan];
        int i = 0;

        while (intPmt <= intNumOfPayments)
        {
            tRow = tblAmort.NewRow();
            interestPaid = decNewBalance * dblConvertInterest;
            deductBalance = monthlyPayment - interestPaid;
            decNewBalance = decNewBalance - deductBalance;

            monthlyBalance[i] = Convert.ToDouble(String.Format("{0:n2}", decNewBalance));

            tblAmort.Rows.Add(tRow);
            tRow["Sr."] = intPmt.ToString();
            tRow["Date"] = paymentDate.ToShortDateString();
            tRow["Monthly Payment"] = String.Format("{0:£.00}", monthlyPayment);
            tRow["Interest Amount"] = String.Format("{0:£.00}", interestPaid);
            tRow["Principal Paid_Amt"] = String.Format("{0:£.00}", deductBalance);
            tRow["Balance"] = String.Format("{0:£.00}", decNewBalance);
            intPmt += 1;
            paymentDate = paymentDate.AddMonths(1);
            i++;
            
        }

        gvAmort.DataSource = tblAmort;
        gvAmort.DataBind();


        double totalLoanTaken = loanAmount - downPayment;

        //group by year
        //var yearBy = from r in tblAmort.AsEnumerable()
        //                group r by new
        //                {
        //                    Year = r.Field<int>("Year")
        //                } into g
        //                select new {
        //                    Year = g.Key.Year,
        //                    Monthly = g.Sum(x => x.Field<double>("Monthly"))
        //                };

        //drawChart(monthlyPayment, termOfLoan, totalLoanTaken);
        //drawChart(yearBy.ToList().ToArray());

        string serializedArray = (new JavaScriptSerializer()).Serialize(monthlyBalance);
        drawChart(serializedArray);


    }

    private void drawChart(string monthlyBalance)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "chartDraw", "draw(" + monthlyBalance + ")", true);
        //ClientScript.RegisterStartupScript(GetType(), "draw", "draw(" + monthlyBalance + ")", true);

    }

}

