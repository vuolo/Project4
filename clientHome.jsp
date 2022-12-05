<!-- 
  Name: Michael Vuolo
  Course: CNT 4714 – Fall 2022 – Project Four
  Assignment Title: A Three-Tier Distributed Web-Based Application
  Date: December 4, 2022
 -->
 
<!DOCTYPE html>
<html>
  <head>
    <title>Client - Home</title>
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
      <h2 style="color: aqua">A Servlet/JSP-based Multi-tiered Enterprise Application Using A Tomcat Container</h2>
      <hr style="width: 95vw">

      <div style="display: flex; flex-direction: column;">
        <p style="text-align: center">You are connected to the Project 4 Enterprise System database as a <span style="color: red">client-level</span> user.
          <br>
          Please enter any valid SQL query or update command in the box below.
        </p>

        <form action="ClientUserApp" method="get" style="margin-top: 10px;">
          <textarea name="query" rows="15" cols="100" style="background-color: blue; color: white; margin-bottom: 10px;">${query}</textarea>
          <br>
          <div style="display: flex; gap: 10px; justify-content: center; align-items: center;">
            <input type="submit" value="Execute Command" style="color: green">
            <input type="button" onclick="resetPage()" value="Reset" style="color: red">
            <input type="button" onclick="clearResults()" value="Clear Results" style="color: goldenrod">
          </div>
        </form>
      </div>
      
      <p style="text-align: center">All execution results will appear below this line.</p>
      <hr style="width: 95vw">
      <h4>Database Results:</h4>

      <div id="results">
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

        <%
          if (request.getAttribute("updateCount") != null) { 
        %>
          <div style="background-color: limegreen; color: black; text-align: center; font-weight: bold; padding: 10px">
            <h4>The statement executed successfully:</h4>
            <p>${updateCount} row(s) affected.</p>
            <h4>Business Logic Detected! - Updating Supplier Status</h4>
            <h4>Business Logic updated {TODO} supplier status marks</h4>
          </div>
        <%
          }
        %>

        <%
          if (request.getAttribute("results") != null) { 
        %>
          <blockquote>
            <code>
              <table style="background-color: white; color: black; text-align: center; font-family: Arial, Helvetica, sans-serif;" border="1">
                <thead style="background-color: red; color: black">
                  <% for (int i = 0; i < (Integer)request.getAttribute("results_numColumnNames"); i++) { %>
                    <td style="padding: 5px;"><b><%=request.getAttribute("results_columnName_" + String.valueOf(i + 1))%></b></td>
                  <% } %>
                </thead>
                <% for (int i = 0; i < (Integer)request.getAttribute("results_numRows"); i++) { %>
                  <tr>
                    <% for (int j = 0; j < (Integer)request.getAttribute("results_numColumnNames"); j++) { %>
                      <td style="padding: 5px;"><%=request.getAttribute("results_rowName_" + String.valueOf(i + 1) + "_" + String.valueOf(j + 1))%></td>
                    <% } %>
                  </tr>
                <% } %>
              </table>
            </code>
          </blockquote>
        <%
          }
        %>
      </div>

      <script>
        function clearResults() {
          var results = document.getElementById("results");
          if (results)
            results.innerHTML = "";
        }

        function resetPage() {
          // Refresh window without query string(s)
          window.location.replace(window.location.protocol + "//" + window.location.host + window.location.pathname);
        }
      </script>

    </div>
  </body>
</html>