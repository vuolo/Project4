/* 
  Name: Michael Vuolo
  Course: CNT 4714 – Fall 2022 – Project Four
  Assignment Title: A Three-Tier Distributed Web-Based Application
  Date: December 4, 2022
*/

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.*;
import java.util.Properties;

import com.mysql.cj.jdbc.MysqlDataSource;

public class AddSupplierRecord extends HttpServlet {

      private Connection connection;
      private Statement statement;
      private String connectionError;
      private String IOError;

      // set up database connection and create SQL statement
      public void init(ServletConfig config) throws ServletException {
            Properties properties = new Properties();
            FileInputStream filein = null;
            MysqlDataSource dataSource = null;

            // read the properties file
            try {
                  filein = new FileInputStream(
                              "/Library/Tomcat10027/webapps/Project4/WEB-INF/lib/data-entry.properties");
                  properties.load(filein);
                  dataSource = new MysqlDataSource();
                  dataSource.setURL(properties.getProperty("MYSQL_DB_URL"));
                  dataSource.setUser(properties.getProperty("MYSQL_DB_USERNAME"));
                  dataSource.setPassword(properties.getProperty("MYSQL_DB_PASSWORD"));
                  this.connection = dataSource.getConnection();
                  this.statement = this.connection.createStatement();
            } catch (SQLException e) {
                  e.printStackTrace();
                  connectionError = e.getMessage();
            } catch (IOException e) {
                  e.printStackTrace();
            }
      }

      // process "GET" requests from data entry user
      @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
                  throws ServletException, IOException {

            request.setAttribute("type", "supplier");

            String snum = request.getParameter("snum");
            String sname = request.getParameter("sname");
            String status = request.getParameter("status");
            String city = request.getParameter("city");
            request.setAttribute("snum", snum);
            request.setAttribute("sname", sname);
            request.setAttribute("status", status);
            request.setAttribute("city", city);

            if (connectionError != null)
                  request.setAttribute("connectionError", connectionError);
            if (IOError != null)
                  request.setAttribute("ioError", IOError);

            // Insert the new supplier record into the database
            String query = "INSERT INTO suppliers VALUES ('" + snum + "', '" + sname + "', " + status + ", '" + city
                        + "')";

            if (snum != null) {
                  try {
                        Boolean hasResults = statement.execute(query);

                        // Check whether we did a DML operation
                        if (!hasResults) {
                              // request.setAttribute("updateCount", statement.getUpdateCount());
                              request.setAttribute("successMessage",
                                          "New suppliers record: (" + snum + ", " + sname + ", " + status + ", " + city
                                                      + ") - successfully entered into the database.");
                        }
                  } catch (SQLException sqlException) {
                        sqlException.printStackTrace();
                        request.setAttribute("queryError", sqlException.getMessage());
                  }
            }

            // forward request to JSP page
            request.getRequestDispatcher("/dataentryHome.jsp").forward(request, response);
      }

      // close SQL statements and database when servlet terminates
      public void destroy() {
            // attempt to close statement and database connection
            try {
                  statement.close();
                  connection.close();
            } catch (SQLException sqlException) {
                  sqlException.printStackTrace();
            }
      }

}
