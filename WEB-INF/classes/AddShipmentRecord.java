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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mysql.cj.jdbc.MysqlDataSource;

public class AddShipmentRecord extends HttpServlet {

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

            request.setAttribute("type", "shipment");

            String snum = request.getParameter("snum");
            String pnum = request.getParameter("pnum");
            String jnum = request.getParameter("jnum");
            String quantity = request.getParameter("quantity");
            request.setAttribute("snum", snum);
            request.setAttribute("pnum", pnum);
            request.setAttribute("jnum", jnum);
            request.setAttribute("quantity", quantity);

            if (connectionError != null)
                  request.setAttribute("connectionError", connectionError);
            if (IOError != null)
                  request.setAttribute("ioError", IOError);

            // Insert the new shipment record into the database
            String query = "INSERT INTO shipments VALUES ('" + snum + "', '" + pnum + "', '" + jnum + "', " + quantity
                        + ")";

            if (snum != null) {
                  try {
                        Boolean hasResults = statement.execute(query);

                        // Check whether we did a DML operation
                        if (!hasResults) {
                              // request.setAttribute("updateCount", statement.getUpdateCount());
                              request.setAttribute("successMessage",
                                          "New shipments record: (" + snum + ", " + pnum + ", " + jnum + ", " + quantity
                                                      + ") - successfully entered into the database. "
                                                      + "Business logic "
                                                      + (Integer.parseInt(quantity) >= 100 ? "" : "not")
                                                      + " triggered.");

                              // Business Logic: If the quantity of a shipment is greater than or equal to
                              // 100, then update (increase) supplier statuses by 5
                              if (Integer.parseInt(quantity) >= 100) {
                                    String select_snums_query = "SELECT DISTINCT snum FROM shipments WHERE quantity >= 100";
                                    Boolean snums_haveResults = statement.execute(select_snums_query);
                                    if (snums_haveResults) {

                                          ResultSet snum_results = statement.getResultSet();

                                          List<String> snums = new ArrayList<String>();
                                          while (snum_results.next())
                                                snums.add(snum_results.getString("snum"));

                                          // Update all the snums in the suppliers table: add 5 to the status
                                          for (String snum_result : snums) {
                                                String update_suppliers_query = "UPDATE suppliers SET status = status + 5 WHERE snum = '"
                                                            + snum_result + "'";
                                                statement.executeUpdate(update_suppliers_query);
                                          }

                                          request.setAttribute("snum_count", snums.size());
                                    }
                              }
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
