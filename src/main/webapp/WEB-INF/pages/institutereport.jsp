<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Class Progress Report | Get Me Progress Report</title>
    
    <!-- core CSS -->
  <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
  <link href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet">
  <link href="<c:url value="/resources/css/animate.min.css" />" rel="stylesheet">
  <link href="<c:url value="/resources/css/prettyPhoto.css" />" rel="stylesheet">
  <link href="<c:url value="/resources/css/main.css" />" rel="stylesheet">
  <link href="<c:url value="/resources/css/responsive.css" />" rel="stylesheet">

    
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <script>

    var imgUri1;
      var imgUri2;
      var imgUri3;
    
         // Load the Visualization API and the piechart package.
              google.load('visualization', '1.0', {'packages':['corechart']});
              google.load("visualization", "1.1", {'packages':["bar"]});
           
         // Function to draw a graph for selected subject accross academic year

         function drawChartForSelectedExamination(jsonData) {

            var columnData = new google.visualization.DataTable();
            columnData.addColumn('string', 'Class');
            columnData.addColumn('number', 'Average Marks');
            columnData.addColumn({type: 'number', role: 'annotation'});
                       
            /*for(var i=0;i<jsonData.recordList.length;i++){
               columnData.addRow([jsonData.recordList[i].std_class+'-'+jsonData.recordList[i].division , Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100),Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100)]);
            
              }*/
          
            for(var i=0;i<jsonData.recordList.length;i++){
                columnData.addRow([jsonData.recordList[i].std_class ,jsonData.recordList[i].avarage,jsonData.recordList[i].avarage]);
              }

           var pieData1 = new google.visualization.DataTable();
           pieData1.addColumn('string', 'Class');
           pieData1.addColumn('number', 'Passing Result');

          for(var i=0;i<jsonData.recordList.length;i++){
                 pieData1.addRow([jsonData.recordList[i].std_class+'-'+jsonData.recordList[i].division+' '+((jsonData.recordList[i].studentspassed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentspassed]);
              
                }



           var pieData2 = new google.visualization.DataTable();
           pieData2.addColumn('string', 'Class');
           pieData2.addColumn('number', 'Failing Result');

          for(var i=0;i<jsonData.recordList.length;i++){
                 pieData2.addRow([jsonData.recordList[i].std_class+'-'+jsonData.recordList[i].division+' '+((jsonData.recordList[i].studentfailed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentfailed]);
              
                }


                var pieOptions1 = {
                         
                          title: 'Passing result per class for '+jsonData.schoolname+','+jsonData.examination,
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };
               
                var pieOptions2 = {
                         
                          title: 'Failing result per class for '+jsonData.schoolname+','+jsonData.examination,
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };

                var columnOptions = {
        
                        'title':'School : '+jsonData.schoolname +', Examination : '+jsonData.examination,
                       'width':1000,
                       'height':600,
                       vAxis: {title: 'Class Average Marks',titleTextStyle:{color: 'green'}},
                       hAxis: {title: 'Class',titleTextStyle:{color: 'green'}}
                 
                   };

        // Instantiate and draw our chart, passing in some options.
        var columnChart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        var piechart1 = new google.visualization.PieChart(document.getElementById('piechart_div1'));
        var piechart2 = new google.visualization.PieChart(document.getElementById('piechart_div2'));

        google.visualization.events.addListener(columnChart, 'ready', function () {
         imgUri1 = columnChart.getImageURI();
         });

        google.visualization.events.addListener(piechart1, 'ready', function () {
         imgUri2 = piechart1.getImageURI();
         });

        google.visualization.events.addListener(piechart2, 'ready', function () {
         imgUri3 = piechart2.getImageURI();
         });
        
        columnChart.draw(columnData, columnOptions);
        piechart1.draw(pieData1, pieOptions1);
        piechart2.draw(pieData2, pieOptions2);
      }   
         // Function to draw a graph for selected exam
           
      function drawChartForAllExaminations(jsonData) {
                
       // var obtainedtotal=jsonData.recordList[1].subject + (jsonData.recordList[1].totalobtained/jsonData.recordList[1].totaloutoff)*100+jsonData.recordList[1].studentsappeared+jsonData.recordList[1].studentspassed;
       //   alert(obtainedtotal);

            var columnData = new google.visualization.DataTable();
            columnData.addColumn('string', 'Examination');
            columnData.addColumn('number', 'Average Marks');
            columnData.addColumn({type: 'number', role: 'annotation'});
                       
            /*for(var i=1;i<jsonData.recordList.length;i++){
               columnData.addRow([jsonData.recordList[i].examname , Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100), Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100)]);
            
              }*/

               for(var i=0;i<jsonData.recordList.length;i++){
                columnData.addRow([jsonData.recordList[i].examname ,jsonData.recordList[i].avarage,jsonData.recordList[i].avarage]);
              }
          
           var pieData1 = new google.visualization.DataTable();
           pieData1.addColumn('string', 'Examination');
           pieData1.addColumn('number', 'Passing Result');

         for(var i=1;i<jsonData.recordList.length;i++){
                 pieData1.addRow([jsonData.recordList[i].examname+' '+((jsonData.recordList[i].studentspassed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentspassed]);
              
                }






           var pieData2 = new google.visualization.DataTable();
           pieData2.addColumn('string', 'Examination');
           pieData2.addColumn('number', 'Failing Result');

          for(var i=1;i<jsonData.recordList.length;i++){
                 pieData2.addRow([jsonData.recordList[i].examname+' '+((jsonData.recordList[i].studentfailed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentfailed]);
              
                }


                var pieOptions1 = {
                         
                          title: 'Passing result per examination for '+jsonData.schoolname,
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };
               
                var pieOptions2 = {
                         
                          title: 'Failing result per examination for '+jsonData.schoolname,
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };

                var columnOptions = {
        
                        'title':'School : '+jsonData.schoolname ,
                       'width':1000,
                       'height':600,
                       vAxis: {title: 'Examination Average Marks',titleTextStyle:{color: 'green'}},
                       hAxis: {title: 'Examinations',titleTextStyle:{color: 'green'}}
                 
                   };

        // Instantiate and draw our chart, passing in some options.
        var columnChart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        var piechart1 = new google.visualization.PieChart(document.getElementById('piechart_div1'));
        var piechart2 = new google.visualization.PieChart(document.getElementById('piechart_div2'));

        google.visualization.events.addListener(columnChart, 'ready', function () {
         imgUri1 = columnChart.getImageURI();
         });

        google.visualization.events.addListener(piechart1, 'ready', function () {
         imgUri2 = piechart1.getImageURI();
         });

        google.visualization.events.addListener(piechart2, 'ready', function () {
         imgUri3 = piechart2.getImageURI();
         });
        
        columnChart.draw(columnData, columnOptions);
        piechart1.draw(pieData1, pieOptions1);
        piechart2.draw(pieData2, pieOptions2);
        
      }





      function drawChartForSelectedSubject(jsonData) {
                
       // var obtainedtotal=jsonData.recordList[1].subject + (jsonData.recordList[1].totalobtained/jsonData.recordList[1].totaloutoff)*100+jsonData.recordList[1].studentsappeared+jsonData.recordList[1].studentspassed;
       //   alert(obtainedtotal);

            var columnData = new google.visualization.DataTable();
            columnData.addColumn('string', 'Examination');
            columnData.addColumn('number', 'Subject Average');
            columnData.addColumn({type: 'number', role: 'annotation'});
                       
          /*  for(var i=0;i<jsonData.recordList.length;i++){
               columnData.addRow([jsonData.recordList[i].examname , Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100),Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100)]);
            
              }
          */

          for(var i=0;i<jsonData.recordList.length;i++){
                columnData.addRow([jsonData.recordList[i].examname ,jsonData.recordList[i].avarage,jsonData.recordList[i].avarage]);
              }


           var pieData1 = new google.visualization.DataTable();
           pieData1.addColumn('string', 'Examination');
           pieData1.addColumn('number', 'Passing Result');

          for(var i=0;i<jsonData.recordList.length;i++){
                 pieData1.addRow([jsonData.recordList[i].examname+' '+((jsonData.recordList[i].studentspassed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentspassed]);
              
                }



           var pieData2 = new google.visualization.DataTable();
           pieData2.addColumn('string', 'Examination');
           pieData2.addColumn('number', 'Failing Result');

          for(var i=0;i<jsonData.recordList.length;i++){
                 pieData2.addRow([jsonData.recordList[i].examname+' '+((jsonData.recordList[i].studentfailed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentfailed]);
              
                }


                var pieOptions1 = {
                         
                          title: 'Passing result per Examination',
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };
               
                var pieOptions2 = {
                         
                          title: 'Failing result per Examination',
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };

                var columnOptions = {
        
                        'title':'School : '+jsonData.schoolname +', Subject : '+jsonData.subject,
                       'width':1000,
                       'height':600,
                       vAxis: {title: 'Examination Average',titleTextStyle:{color: 'green'}},
                       hAxis: {title: 'Examinations',titleTextStyle:{color: 'green'}}
                 
                   };

        // Instantiate and draw our chart, passing in some options.
        var columnChart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        var piechart1 = new google.visualization.PieChart(document.getElementById('piechart_div1'));
        var piechart2 = new google.visualization.PieChart(document.getElementById('piechart_div2'));

        google.visualization.events.addListener(columnChart, 'ready', function () {
         imgUri1 = columnChart.getImageURI();
         });

        google.visualization.events.addListener(piechart1, 'ready', function () {
         imgUri2 = piechart1.getImageURI();
         });

        google.visualization.events.addListener(piechart2, 'ready', function () {
         imgUri3 = piechart2.getImageURI();
         });

        columnChart.draw(columnData, columnOptions);
        piechart1.draw(pieData1, pieOptions1);
        piechart2.draw(pieData2, pieOptions2);
        
      }



      function drawChartForSelectedExamAndSubject(jsonData){

          var columnData = new google.visualization.DataTable();
            columnData.addColumn('string', 'Class');
            columnData.addColumn('number', 'Average Marks');
            columnData.addColumn({type: 'number', role: 'annotation'});
                       
           /* for(var i=0;i<jsonData.recordList.length;i++){
               columnData.addRow([jsonData.recordList[i].std_class+'-'+jsonData.recordList[i].division , Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100),Math.round((jsonData.recordList[i].totalobtained/jsonData.recordList[i].totaloutoff)*100)]);
            
              }*/

              for(var i=0;i<jsonData.recordList.length;i++){
                columnData.addRow([jsonData.recordList[i].std_class ,jsonData.recordList[i].avarage,jsonData.recordList[i].avarage]);
              }

          
           var pieData1 = new google.visualization.DataTable();
           pieData1.addColumn('string', 'Class');
           pieData1.addColumn('number', 'Passing Result');

          for(var i=0;i<jsonData.recordList.length;i++){
                 pieData1.addRow([jsonData.recordList[i].std_class+'-'+jsonData.recordList[i].division+' '+((jsonData.recordList[i].studentspassed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentspassed]);
              
                }



           var pieData2 = new google.visualization.DataTable();
           pieData2.addColumn('string', 'Class');
           pieData2.addColumn('number', 'Failing Result');

          for(var i=0;i<jsonData.recordList.length;i++){
                 pieData2.addRow([jsonData.recordList[i].std_class+'-'+jsonData.recordList[i].division+' '+((jsonData.recordList[i].studentfailed/jsonData.recordList[i].studentsappeared)*100).toFixed(2)+'%' ,jsonData.recordList[i].studentfailed]);
              
                }


                var pieOptions1 = {
                         
                          title: 'Passing result per class for '+jsonData.examination+','+jsonData.subject,
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };
               
                var pieOptions2 = {
                         
                          title: 'Failing result per class for '+jsonData.examination+','+jsonData.subject,
                          is3D: true,
                          pieSliceText: 'label',
                          'width':900,
                          'height':800,
                             };

                var columnOptions = {
        
                        'title':'Examination : '+jsonData.examination +', Subject : '+jsonData.subject,
                       'width':1000,
                       'height':600,
                       vAxis: {title: 'Class Average Marks',titleTextStyle:{color: 'green'}},
                       hAxis: {title: 'Class',titleTextStyle:{color: 'green'}}
                 
                   };

        // Instantiate and draw our chart, passing in some options.
        var columnChart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        var piechart1 = new google.visualization.PieChart(document.getElementById('piechart_div1'));
        var piechart2 = new google.visualization.PieChart(document.getElementById('piechart_div2'));

        google.visualization.events.addListener(columnChart, 'ready', function () {
         imgUri1 = columnChart.getImageURI();
         });

        google.visualization.events.addListener(piechart1, 'ready', function () {
         imgUri2 = piechart1.getImageURI();
         });

        google.visualization.events.addListener(piechart2, 'ready', function () {
         imgUri3 = piechart2.getImageURI();
         });
        
        columnChart.draw(columnData, columnOptions);
        piechart1.draw(pieData1, pieOptions1);
        piechart2.draw(pieData2, pieOptions2);
      }

        // Get Data to draw a graph

        function getGraph(reporttype,sel1,sel2,sel3){

            var schoolid = document.getElementById(sel1).value;
           // var classname = document.getElementById(sel12).value;
          //  var division = document.getElementById(sel13).value;
            if(reporttype === 'ForAllExaminations')
              {
                var exam = "none";
                var subject = "none"
              }
            if(reporttype === 'ForSelectedExamination')
            {
              var exam = document.getElementById(sel2).value;
              var subject= "none";
            }
            if(reporttype === 'ForSelectedSubject')
            {
               var exam = "none";
               var subject = document.getElementById(sel2).value;
            }
            if(reporttype ==='ForSelectedExamAndSubject'){
              var exam = document.getElementById(sel2).value;
              var subject = document.getElementById(sel3).value;
            }
          //  alert(reporttype+schoolid+exam+subject);
            //alert(x);

            madeAjaxCallForGeaphData(reporttype,schoolid,exam,subject);

        }




        // show Select Exam dropdown list and hide Select Subject dropdown if it is visible.

        function showForAllExaminations() {
            document.getElementById('ForSelectedExamination').style.display = "none";
            document.getElementById('ForSelectedSubject').style.display = "none";
            document.getElementById('ForSelectedExamAndSubject').style.display = "none";
            document.getElementById('ForAllExaminations').style.display = "block";
            clearSelect("sel11");
            madeAjaxCallForSelect("${contextPath}/instituteservices/getSelectDropDownList","#sel11","","","ForAllExaminations");
              
        } // EOF showForAllExaminations()

        // show Select Subjec dropdown list and hide Select Exam dropdown if it is visible

        function showForSelectedExamination() {
            document.getElementById('ForAllExaminations').style.display = "none";
            document.getElementById('ForSelectedSubject').style.display = "none";
            document.getElementById('ForSelectedExamAndSubject').style.display = "none";            
            document.getElementById('ForSelectedExamination').style.display = "block";
            clearSelect("sel21");
            clearSelect("sel22");
            madeAjaxCallForSelect("${contextPath}/instituteservices/getSelectDropDownList","#sel21","#sel22","","ForSelectedExamination");
            

        } // EOF showForSelectedExamination()

         // show Select Exam dropdown list and hide Select Subject dropdown if it is visible.

        function showForSelectedSubject() {
            document.getElementById('ForSelectedExamination').style.display = "none";
            document.getElementById('ForAllExaminations').style.display = "none";
            document.getElementById('ForSelectedExamAndSubject').style.display = "none";
            document.getElementById('ForSelectedSubject').style.display = "block";
            clearSelect("sel31");
            clearSelect("sel32");
            madeAjaxCallForSelect("${contextPath}/instituteservices/getSelectDropDownList","#sel31","#sel32","","ForSelectedSubject");
                
        } // EOF showForSelectedSubject()

        function showForSelectedExamAndSubject(){

            document.getElementById('ForSelectedExamination').style.display = "none"
           document.getElementById('ForAllExaminations').style.display = "none";
            document.getElementById('ForSelectedSubject').style.display = "none";
            document.getElementById('ForSelectedExamAndSubject').style.display = "block";         
          //  alert("at showForSelectedExamAndSubject ");   
            clearSelect("sel41");
            clearSelect("sel42");
            clearSelect("sel43");
            madeAjaxCallForSelect("${contextPath}/instituteservices/getSelectDropDownList","#sel41","#sel42","#sel43","ForSelectedExamAndSubject");


        }

        // Function to get subject list according to selected examination in Option 4 
        function selectCorrespondingSubjects(){

           // alert("selectCorrespondingSubjects");
            var selectedExam = $('#sel42 :selected').text();
           // alert(selectedExam);
            clearSelect("sel43");
          madeAjaxCallForSelect("${contextPath}/instituteservices/getSelectDropDownList",selectedExam,"#sel42","#sel43","selectCorrespondingSubjects");
        }
        
        function clearSelect(selectid){
                selectbox=document.getElementById(selectid);
                      for(var i=selectbox.options.length-1;i>0;i--)
                      {
                        selectbox.remove(i);
                      }
              }

        // AJAX call function to load graph data

        function madeAjaxCallForGeaphData(reporttype,schoolid,examname,subject){
            $.ajax({
                    type: "get",
                    url: "${contextPath}/instituteservices/getInstitutewiseReport",
                    cache: false,               
                    data:{type:reporttype,schoolid:schoolid,examname:examname,subject:subject} ,
                        success: function(response){
                           // $('#result').html("");
                   
                          //  $('#result').html("First Name:- " + response[0].subjectName);
                            //alert(response);
                            if(reporttype==="ForAllExaminations")
                              google.setOnLoadCallback(drawChartForAllExaminations(response));

                            if(reporttype==="ForSelectedExamination")
                              google.setOnLoadCallback(drawChartForSelectedExamination(response));

                            if(reporttype==="ForSelectedSubject")
                              google.setOnLoadCallback(drawChartForSelectedSubject(response));
                            if(reporttype==="ForSelectedExamAndSubject")
                              google.setOnLoadCallback(drawChartForSelectedExamAndSubject(response));
     
                    
                    },
                    error: function(){                      
                        alert('Error while request..');
                    }
                });
        }
         
         
         // AJAX call function to load exam and subject lists ffrom database

        function madeAjaxCallForSelect(reqURL,selectid1,selectid2,selectid3,listType){
          //alert("at ajax");
            $.ajax({
              type: "get",
              url: reqURL,
              cache: false,       
              data:{type:listType,selectedExam:selectid1} ,  /* selectExam is to get corresponding subjects list used in Option 4 */
                success: function(response){
                   // $('#result').html("");
            
                   // $('#result').html("First Name:- " + response);
                      if(listType==="ForAllExaminations"){                                      
                         // for(i=0; i<response.length; i++){
                            $(selectid1).append("<option>" + response.institute + "</option>");
                          //  }
                      }
                      if (listType==="ForSelectedExamination") {

                            //for(i=0; i<response[0].length; i++){
                            $(selectid1).append("<option>" + response.institute + "</option>");
                            //}

                            for(i=0;i<response.exam.length;i++){
                              $(selectid2).append("<option>" + response.exam[i] + "</option>");
                            }
                      };  

                      if (listType==="ForSelectedSubject") {

                            //for(i=0; i<response[0].length; i++){
                            $(selectid1).append("<option>" + response.institute + "</option>");
                            //}

                            for(i=0;i<response.subjects.length;i++){
                              $(selectid2).append("<option>" + response.subjects[i] + "</option>");
                            }
                      };    

                      if (listType === "ForSelectedExamAndSubject") {

                         $(selectid1).append("<option>" + response.institute + "</option>");

                         for(i=0;i<response.exam.length;i++){
                              $(selectid2).append("<option>" + response.exam[i] + "</option>");
                            }

                            
                      }

                      if (listType === "selectCorrespondingSubjects"){
                        
                          for(i=0;i<response.subjects.length;i++){
                              $(selectid3).append("<option>" + response.subjects[i] + "</option>");
                            }
                      }
              
              },
              error: function(){            
                alert('Error while request..');
              }
            });
          } // EOF madeAjaxCallForSelect()
        

        function generatePDF(){

var doc = new jsPDF('p', 'mm');
doc.addImage( imgUri1, 'PNG', 0, 0, 210, 0); // img1 and img2 on first page
doc.addImage( imgUri2, 'PNG', 0, 130, 210, 0); 
doc.addPage();
doc.addImage( imgUri3, 'PNG', 0, 0, 210, 0);
doc.save("ProgressReport.pdf");
}
    </script>
    <style type="text/css">
    .modal-dialog {
  width: 90%;

 /*  height: 800%; */
  padding: 50;
}

.modal-content {
  /* height: 100%; */
  border-radius: 3;
}

.modal-body{
    height: 750px;
    overflow-y: auto;
}
</style>

</head><!--/head-->

<body>

   
    <header id="header">
         <!-- <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-xs-4">
                     
                    </div>
                    <div class="col-sm-6 col-xs-8">
                       <div class="social">
                            
                            <div class="top-number"><p><a href="${contextPath}/userfacility/logout" ><i class="glyphicon glyphicon-user"></i>  <b>${loggedinUser}   SignOut</b></a></p></div>
                            
                       </div>
                    </div>
                </div>
            </div>
        </div> -->
    

        <nav class="navbar navbar-inverse" role="banner">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                  <!--   <a class="navbar-brand" href="index.html"><img src="<c:url value="/resources/images/logo.png" />" alt="logo"></a>  -->
                </div>
                
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                         <li><a href="${contextPath}/getIndex">Home</a></li>
                         <li><a href="${contextPath}/instituteservices/getClassWiseReportPage">Class Reports</a></li>
                         <li class="active"><a href="${contextPath}/instituteservices/getInstitutewiseReportPage">School Reports</a></li> 
                         <li><a href="${contextPath}/studentservices/getAttendenceReport">Attendence Reports</a></li>
                        <li><a href="${contextPath}/studentservices/getNotifications">Notifications</a></li>
                        <li><a href="${contextPath}/studentservices/getContactUs">Contact Us</a></li>  
                        <li>
                                    <a href="${contextPath}/userfacility/logout" ><i class="glyphicon glyphicon-user"></i>  <b>${loggedinUser}   Log Out</b></a>
                         </li>                 
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
        
    </header><!--/header-->

    <section id="feature" class="transparent-bg">
        <div class="container">
            <!-- <div class="center wow fadeInDown">
                <h2>Class Reports</h2>
                <p class="lead">We provide different analysis reports for a Class. Please select desired class and get your report on screen. <br> </p>
            </div>  -->

            <div class="row">
                <div class="features">
                    <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                        <div class="feature-wrap">
                             <a href="#" onclick="return showForAllExaminations();"> 
                            <i class="fa fa-chevron-right"></i>
                            <h2>Report For All Examinations</h2>
                            <h3>Progress Report is generated for all the examinations conducted in the current academic year. The report shows institute's average percentage for each examination. It also shows the examination wise passing and failing percentage accross the institute.</h3></a>
                        </div>
                    </div><!--/.col-md-4-->

                    <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                        <div class="feature-wrap">
                            <a href="#" onClick="showForSelectedExamination();" >
                            <i class="fa fa-chevron-right" ></i>
                            <h2>Report For Selected Examination</h2>
                            <h3>Progress Report is generated accross all the classes from the institute. The reportshows each class's average percentage obtainedin a selected examination. It also shows passing and failing percentage of each class for the selected examination.</h3></a>
                        </div>
                    </div>
                </div><!--/.services-->
            </div><!--/.row--> 


            <div class="row">
                <div class="features">
                    <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                        <div class="feature-wrap">
                             <a href="#" onclick="return showForSelectedSubject();"> 
                            <i class="fa fa-chevron-right"></i>
                            <h2>Report For Selected Subject</h2>
                            <h3>Progress report is generated accross all the examinations conductedin current academic year. The report shows average obtained marks in a selected subject in each examination. It also shows passing and failing percentage of each examination for the selected subject.</h3></a>
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                        <div class="feature-wrap">
                             <a href="#" onclick="return showForSelectedExamAndSubject();"> 
                            <i class="fa fa-chevron-right"></i>
                            <h2>Report For Selected Subject and Examination</h2>
                            <h3>Progress report is generated accross all classes for selected subject and examination. The report shows average marks of selected subject in selected examination for each class in the institute. It also shows passing and failing percentage of selected subject in selected examination for each class in the institute.</h3></a>
                        </div>
                    </div>
                </div><!--/.services-->
            </div><!--/.row-->     




         </div><!--/.container-->
    </section><!--/#feature-->


   <section id="feature" class="transparent-bg">
        <div class="container">
           <div id="ForAllExaminations" class="center wow fadeInDown" style="display:none;">
            <p><h3>Please Select the details from the following drop down list.</h3></p>
                <form>
                        <div class="form-group">
                            <div class="row">
                                 <div class="col-md-12 col-sm-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel11">Institute : </label>
                                      <select  class="input-large" id="sel11" style="height:35px;border-radius: 4px;" >
                                        <option value="" disabled selected>Select Institute ID</option>
                                      </select>
                                 </div>

                            </div>
                      </div>
                      <button type="button" name="submit" class="btn btn-primary btn-lg" required="required" data-toggle="modal" data-target="#myModal" onClick="getGraph('ForAllExaminations','sel11','sel12','sel13');">Get Me Report
                      </button>

                  </form>
              
                 
           </div>

           <div id="ForSelectedExamination" class="center wow fadeInDown" style="display:none;">

             <p><h3>Please Select the details from the following drop down list.</h3></p>
                 <form>
                        <div class="form-group">
                            <div class="row">
                                 <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel21">Institute : </label>
                                      <select  class="input-large" id="sel21" style="height:35px;border-radius: 4px;" >
                                        <option value="" disabled selected>Select Institute ID</option>
                                      </select>
                                 </div>

                                <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel22">Examination </label>
                                      <select  class="input-large" id="sel22" style="height:35px;border-radius: 4px;">
                                        <option value="" disabled selected>Select Examination</option>
                                      </select>
                                </div>

                                <!-- <div class="col-md-3 col-sm-3 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel23">Division : </label>
                                      <select  class="input-large" id="sel23" >
                                      <option>A</option>
                                      </select>
                                </div>

                                <div class="col-md-3 col-sm-3 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel24">Subject : </label>
                                      <select  class="input-large" id="sel24" >
                                      <option>Marathi</option>
                                      <option>English</option>
                                       </select>

                                </div> -->

                            </div>
                      </div>
                      
                      <button type="button" name="submit" class="btn btn-primary btn-lg" required="required" data-toggle="modal" data-target="#myModal" onClick="getGraph('ForSelectedExamination','sel21','sel22','sel23');">Get Me Report
                      </button>
                </form>
            </div>


            <div id="ForSelectedSubject" class="center wow fadeInDown" style="display:none;">

             <p><h3>Please Select the details from the following drop down list.</h3></p>
                 <form>
                        <div class="form-group">
                            <div class="row">
                                 <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel31">Institute : </label>
                                      <select  class="input-large" id="sel31" style="height:35px;border-radius: 4px;" >
                                  <option value="" disabled selected>Select Institute ID</option>
                                      </select>
                                 </div>

                                <div class="col-md-6 col-sm-6 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel32">Subject : </label>
                                      <select  class="input-large" id="sel32" style="height:35px;border-radius: 4px;">
                                        <option value="" disabled selected>Select Subject</option>
                                      
                                      </select>
                                </div>

                                <!-- <div class="col-md-4 col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel33">Division : </label>
                                      <select  class="input-large" id="sel33" >
                                      <option>A</option>
                                      </select>
                                </div> -->

                            </div>
                      </div>
                      
                      <button type="button" name="submit" class="btn btn-primary btn-lg" required="required" data-toggle="modal" data-target="#myModal" onClick="getGraph('ForSelectedSubject','sel31','sel32','sel33');">Get Me Report
                      </button>
                </form>
            </div>


            <div id="ForSelectedExamAndSubject" class="center wow fadeInDown" style="display:none;">

             <p><h3>Please Select the details from the following drop down list.</h3></p>
                 <form>
                        <div class="form-group">
                            <div class="row">
                                 <div class="col-md-4 col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel41">Institute : </label>
                                      <select  class="input-large" id="sel41" style="height:35px;border-radius: 4px;" >
                                        <option value="" disabled selected>Select Institute ID</option>
                                      </select>
                                 </div>

                                <div class="col-md-4 col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel42">Examination : </label>
                                      <select  class="input-large" id="sel42"  onchange="selectCorrespondingSubjects()" style="height:35px;border-radius: 4px;">
                                      <!-- <option>Unit Test 1</option>
                                      <option>Unit Test 2</option> -->
                                      <option value="" disabled selected>Select Examination</option>
                                      </select>
                                </div>

                                <div class="col-md-4 col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                      <label for="sel43">Subject : </label>
                                      <select  class="input-large" id="sel43" style="height:35px;border-radius: 4px;">
                                         <option value="" disabled selected>Select Subject</option>
                                      </select>
                                </div>

                            </div>
                      </div>
                      
                      <button type="button" name="submit" class="btn btn-primary btn-lg" required="required" data-toggle="modal" data-target="#myModal" onClick="getGraph('ForSelectedExamAndSubject','sel41','sel42','sel43');">Get Me Report
                      </button>
                </form>
            </div>
       
    </section>

    
      <section id="display-grpah">
        <div class="container" >
                <!--Div that will hold the pie chart-->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="exampleModalLabel">Your Progress Report is here...</h4>
                    </div>
                    <div class="modal-body"> 
                     <!--  <div id="chart_div" class="center wow fadeInDown"></div> -->
                        <div id = "temp">

                           
                          <div class="container wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                              <div id="chart_div" class="center wow fadeInDown" ></div>
                          </div> 
 
                          <div class="container-fluid">
                              <div class="row">
                                <div class="col-xs-6">
                                    <div id="piechart_div1" class="center wow fadeInDown" ></div>
                                </div>
                                <div class="col-xs-6">
                                    <div id="piechart_div2" class="center wow fadeInDown" ></div>
                                </div>
                              </div>
                          </div>
                       </div>
                      </div>
                    <div class="modal-footer">


                      
                      <div class="footerMessage">
                           <a href="${contextPath}/studentservices/getContactUs"><i class="glyphicon glyphicon-pushpin"></i><h4>For incorrect data, please write us.</h4> Click here, and Select Subject- Incorrect Data</a>
                      </div>
                      <button type="button" class="btn btn-danger" onClick="generatePDF()"><i class="glyphicon glyphicon-download-alt"></i>  Save as PDF</button>
                    </div>                                                          
                  </div>
                </div>
            </div>
          </div>
    </section>

   <!--  <section id="bottom">
        <div class="container wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Company</h3>
                        <ul>
                            <li><a href="#">About us</a></li>
                            <li><a href="#">We are hiring</a></li>
                            <li><a href="#">Meet the team</a></li>
                            <li><a href="#">Copyright</a></li>
                            <li><a href="#">Terms of use</a></li>
                            <li><a href="#">Privacy policy</a></li>
                            <li><a href="#">Contact us</a></li>
                        </ul>
                    </div>    
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Support</h3>
                        <ul>
                            <li><a href="#">Faq</a></li>
                            <li><a href="#">Blog</a></li>
                            <li><a href="#">Forum</a></li>
                            <li><a href="#">Documentation</a></li>
                            <li><a href="#">Refund policy</a></li>
                            <li><a href="#">Ticket system</a></li>
                            <li><a href="#">Billing system</a></li>
                        </ul>
                    </div>    
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Developers</h3>
                        <ul>
                            <li><a href="#">Web Development</a></li>
                            <li><a href="#">SEO Marketing</a></li>
                            <li><a href="#">Theme</a></li>
                            <li><a href="#">Development</a></li>
                            <li><a href="#">Email Marketing</a></li>
                            <li><a href="#">Plugin Development</a></li>
                            <li><a href="#">Article Writing</a></li>
                        </ul>
                    </div>    
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Our Partners</h3>
                        <ul>
                            <li><a href="#">Adipisicing Elit</a></li>
                            <li><a href="#">Eiusmod</a></li>
                            <li><a href="#">Tempor</a></li>
                            <li><a href="#">Veniam</a></li>
                            <li><a href="#">Exercitation</a></li>
                            <li><a href="#">Ullamco</a></li>
                            <li><a href="#">Laboris</a></li>
                        </ul>
                    </div>    
                </div>
            </div>
        </div>
    </section> -->

    <footer id="footer" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    &copy; 2016 <a target="_blank" href="http://shapebootstrap.net/" title="Free Twitter Bootstrap WordPress Themes and HTML templates">Get Me Progress Report</a>. All Rights Reserved.
                </div>
                <div class="col-sm-6">
                    <ul class="pull-right">
                        <!-- <li><a href="#">Home</a></li> -->
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Faq</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><i class="fa fa-phone-square"></i>  +91 8297411200</li>
                    </ul>
                </div>
            </div>
        </div>
    </footer><!--/#footer-->

    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.prettyPhoto.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.isotope.min.js" />"></script>
    <script src="<c:url value="/resources/js/main.js" />"></script>
    <script src="<c:url value="/resources/js/wow.min.js" />"></script>
    <script src="<c:url value="/resources/js/jspdf.js" />"></script>
    <script src="<c:url value="/resources/js/sprintf.js" />"></script>
    <script src="<c:url value="/resources/js/base64.js" />"></script>
    <script src="<c:url value="/resources/js/jspdf.debug.js" />"></script>
  <style>

  .footerMessage{
     overflow: hidden;
    white-space: nowrap;
    float:left;
    font-style:italic;   
   text-align: left;   
  width: 100%;
  }
        
  </style>

</body>
</html>