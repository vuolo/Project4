<!-- 
  Name: Michael Vuolo
  Course: CNT 4714 – Fall 2022 – Project Four
  Assignment Title: A Three-Tier Distributed Web-Based Application
  Date: December 4, 2022
 -->
 
 <!DOCTYPE html>
 <html>
   <head>
     <title>Data Entry - Home</title>
     <style>
       body {
         background-color: #000000;
         color: #ffffff;
         font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
         font-size: 14px;
       }
     </style>
   </head>
   <body>
     <div style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
 
       <h1 style="color: red">Welcome to the Fall 2022 Project 4 Enterprise Databae System</h1>
       <h2 style="color: aqua">Data Entry Application</h2>
       <hr style="width: 95vw">
 
       <div style="display: flex; flex-direction: column;">
         <p style="text-align: center">You are connected to the Project 4 Enterprise System database as a <span style="color: red">data-entry-level</span> user.
           <br>
           Enter the data values in a form below to add a new record to the corresponding database table.
         </p>

         <hr style="width: 95vw">
 
         <fieldset style="margin-top: 10px;">
          <legend>Suppliers Record Insert</legend>
          <form action="AddSupplierRecord" method="get" style="display: flex; flex-direction: column; justify-content: center; align-items: center; margin-top: 10px;">

              <blockquote>
                <code>
                  <table style="background-color: white; color: black; text-align: center; font-family: Arial, Helvetica, sans-serif; border-color: goldenrod;" border="1">
                    <thead style="background-color: black; color: skyblue">
                      <td style="padding: 5px;"><b>snum</b></td>
                      <td style="padding: 5px;"><b>sname</b></td>
                      <td style="padding: 5px;"><b>status</b></td>
                      <td style="padding: 5px;"><b>city</b></td>
                    </thead>
                      <tr style="background-color: goldenrod;">
                        <td style="padding: 5px;"><input type="text" name="snum"></td>
                        <td style="padding: 5px;"><input type="text" name="sname"></td>
                        <td style="padding: 5px;"><input type="text" name="status"></td>
                        <td style="padding: 5px;"><input type="text" name="city"></td>
                      </tr>
                  </table>
                </code>
              </blockquote>

              <div style="display: flex; gap: 10px; justify-content: center; align-items: center; margin-bottom: 10px">
                <input type="submit" value="Enter Supplier Record Into Database" style="color: green">
                <input type="button" onclick="clearDataAndResults()" value="Clear Data and Results" style="color: red">
              </div>
          </form>
        </fieldset>

        <fieldset style="margin-top: 10px;">
          <legend>Parts Record Insert</legend>
          <form action="AddPartRecord" method="get" style="display: flex; flex-direction: column; justify-content: center; align-items: center; margin-top: 10px;">

              <blockquote>
                <code>
                  <table style="background-color: white; color: black; text-align: center; font-family: Arial, Helvetica, sans-serif; border-color: goldenrod;" border="1">
                    <thead style="background-color: black; color: skyblue">
                      <td style="padding: 5px;"><b>pnum</b></td>
                      <td style="padding: 5px;"><b>pname</b></td>
                      <td style="padding: 5px;"><b>color</b></td>
                      <td style="padding: 5px;"><b>weight</b></td>
                      <td style="padding: 5px;"><b>city</b></td>
                    </thead>
                      <tr style="background-color: goldenrod;">
                        <td style="padding: 5px;"><input type="text" name="pnum"></td>
                        <td style="padding: 5px;"><input type="text" name="pname"></td>
                        <td style="padding: 5px;"><input type="text" name="color"></td>
                        <td style="padding: 5px;"><input type="text" name="weight"></td>
                        <td style="padding: 5px;"><input type="text" name="city"></td>
                      </tr>
                  </table>
                </code>
              </blockquote>

              <div style="display: flex; gap: 10px; justify-content: center; align-items: center; margin-bottom: 10px">
                <input type="submit" value="Enter Part Record Into Database" style="color: green">
                <input type="button" onclick="clearDataAndResults()" value="Clear Data and Results" style="color: red">
              </div>
          </form>
        </fieldset>

        <fieldset style="margin-top: 10px;">
          <legend>Jobs Record Insert</legend>
          <form action="AddJobRecord" method="get" style="display: flex; flex-direction: column; justify-content: center; align-items: center; margin-top: 10px;">

              <blockquote>
                <code>
                  <table style="background-color: white; color: black; text-align: center; font-family: Arial, Helvetica, sans-serif; border-color: goldenrod;" border="1">
                    <thead style="background-color: black; color: skyblue">
                      <td style="padding: 5px;"><b>jnum</b></td>
                      <td style="padding: 5px;"><b>jname</b></td>
                      <td style="padding: 5px;"><b>numworkers</b></td>
                      <td style="padding: 5px;"><b>city</b></td>
                    </thead>
                      <tr style="background-color: goldenrod;">
                        <td style="padding: 5px;"><input type="text" name="jnum"></td>
                        <td style="padding: 5px;"><input type="text" name="jname"></td>
                        <td style="padding: 5px;"><input type="text" name="numworkers"></td>
                        <td style="padding: 5px;"><input type="text" name="city"></td>
                      </tr>
                  </table>
                </code>
              </blockquote>

              <div style="display: flex; gap: 10px; justify-content: center; align-items: center; margin-bottom: 10px">
                <input type="submit" value="Enter Job Record Into Database" style="color: green">
                <input type="button" onclick="clearDataAndResults()" value="Clear Data and Results" style="color: red">
              </div>
          </form>
        </fieldset>

        <fieldset style="margin-top: 10px;">
          <legend>Shimpents Record Insert</legend>
          <form action="AddShipmentRecord" method="get" style="display: flex; flex-direction: column; justify-content: center; align-items: center; margin-top: 10px;">

              <blockquote>
                <code>
                  <table style="background-color: white; color: black; text-align: center; font-family: Arial, Helvetica, sans-serif; border-color: goldenrod;" border="1">
                    <thead style="background-color: black; color: skyblue">
                      <td style="padding: 5px;"><b>snum</b></td>
                      <td style="padding: 5px;"><b>pnum</b></td>
                      <td style="padding: 5px;"><b>jnum</b></td>
                      <td style="padding: 5px;"><b>quantity</b></td>
                    </thead>
                      <tr style="background-color: goldenrod;">
                        <td style="padding: 5px;"><input type="text" name="snum"></td>
                        <td style="padding: 5px;"><input type="text" name="pnum"></td>
                        <td style="padding: 5px;"><input type="text" name="jnum"></td>
                        <td style="padding: 5px;"><input type="text" name="quantity"></td>
                      </tr>
                  </table>
                </code>
              </blockquote>

              <div style="display: flex; gap: 10px; justify-content: center; align-items: center; margin-bottom: 10px">
                <input type="submit" value="Enter Shipment Record Into Database" style="color: green">
                <input type="button" onclick="clearDataAndResults()" value="Clear Data and Results" style="color: red">
              </div>
          </form>
        </fieldset>

       </div>
       
       <h4>Database Results:</h4>
 
       <div id="results">
        <div style="background-color: red; color: white; border: 5px solid yellow; padding: 10px">
            <h4>SQL Database Connection Error:</h4>
            <p>${connectionError}</p>
          </div>
        <%
          if (request.getAttribute("connectionError") != null) { 
        %>
          <div style="background-color: red; color: white; padding: 10px">
            <h4>SQL Database Connection Error:</h4>
            <p>${connectionError}</p>
          </div>
        <%
          }
        %>

        <%
          if (request.getAttribute("ioError") != null) { 
        %>
          <div style="background-color: red; color: white; padding: 10px">
            <h4>IO Error During Attempting Database Connection:</h4>
            <p>${IOError}</p>
          </div>
        <%
          }
        %>

        <%
          if (request.getAttribute("queryError") != null) { 
        %>
          <div style="background-color: red; color: white; padding: 10px">
            <h4>Error executing the SQL statement:</h4>
            <p>${queryError}</p>
          </div>
        <%
          }
        %>
       </div>
 
       <script>
         function clearDataAndResults() {
          // Refresh window without query string(s)
          window.location.replace(window.location.protocol + "//" + window.location.host + window.location.pathname);
         }
       </script>
 
     </div>
   </body>
 </html>