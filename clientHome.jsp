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
            <input type="reset" value="Reset" style="color: red">
            <input type="button" value="Clear Results" style="color: goldenrod">
          </div>
        </form>
      </div>
      
      <p style="text-align: center">All execution results will appear below this line.</p>
      <hr style="width: 95vw">
      <h4>Database Results:</h4>

      <%
        if (request.getAttribute("connectionError") != null) { 
      %>
        <div style="background-color: red; color: white; padding: 0 10px">
          <h4>SQL Database Connection Error:</h4>
          <p>${connectionError}</p>
        </div>        
      <%
        }
      %>

      <%
        if (request.getAttribute("IOError") != null) { 
      %>
        <div style="background-color: red; color: white; padding: 0 10px">
          <h4>IO Error During Attempting Database Connection:</h4>
          <p>${IOError}</p>
        </div>        
      <%
        }
      %>
      
      ${results}

      <!-- <blockquote>
        <code>
          <table style="background-color: white; color: black;" border="1">
            <thead style="background-color: red; color: black">
              <td><b>${"jnum"}</b></td>
              <td><b>${"jname"}</b></td>
            </thead>
            <tr>
              <td>${"TODO..."}</td>
              <td>${"TODO..."}</td>
            </tr>
          </table>
        </code>
      </blockquote> -->

    </div>
  </body>
</html>