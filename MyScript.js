//draw = function (monthlyPayment, termOfLoan, totalLoanTaken) {
draw = function (values) {

    var dataPoints = new Array();
    var yValue = 0;
    var xValue = 0;
    var x = 1;

    //console.log(values);

    for (i = 1; i < values.length; i++) {
        yValue = values[i];

        if (i%12 === 0)
        {
            dataPoints.push({ x: x, y: yValue });
            yValue = 0;
            x++;
        }
    }

    dataPoints.push({ x: x, y: 0 });

    var chart = new CanvasJS.Chart("chartContainer", {
        width: 450,
        height:300,
        theme: "theme1",//theme1
        title: {
            text: "Graph showing the value of the loan through repayments",
            fontSize: 20,
        },
        axisX: {
            title: "Years",
            titleFontSize: 15

        },
        axisY: {
            title: "Amount left to pay (£)",
            titleFontSize: 15,
            interlacedColor: "azure"
        },
        animationEnabled: true,

        data: [
        {
            type: "line",
            axisXIndex: 0, //defaults to 0
            dataPoints: dataPoints
        }
        ]
    });
    chart.render();
}


