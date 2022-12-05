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

public class RootUserApp extends HttpServlet {

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
                  filein = new FileInputStream("/Library/Tomcat10027/webapps/Project4/WEB-INF/lib/root.properties");
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

      // process "GET" requests from root user
      @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
                  throws ServletException, IOException {

            String query = request.getParameter("query");
            request.setAttribute("query", query);

            if (connectionError != null)
                  request.setAttribute("connectionError", connectionError);
            if (IOError != null)
                  request.setAttribute("ioError", IOError);

            if (query != null) {
                  try {
                        Boolean hasResults = statement.execute(query);

                        // Check whether we did a DML operation
                        if (!hasResults) {
                              request.setAttribute("updateCount", statement.getUpdateCount());

                              // Business Logic
                              if (query.toLowerCase().startsWith("insert into shipments")) {
                                    String[] queryParts = query.split(",");
                                    Integer shipmentQuantity = Integer
                                                .parseInt(queryParts[queryParts.length - 1].replace(")", "").trim());

                                    if (shipmentQuantity >= 100) {
                                          String select_snums_query = "SELECT DISTINCT snum FROM shipments WHERE quantity >= 100";
                                          Boolean snums_haveResults = statement.execute(select_snums_query);
                                          if (snums_haveResults) {

                                                ResultSet snum_results = statement.getResultSet();

                                                List<String> snums = new ArrayList<String>();
                                                while (snum_results.next())
                                                      snums.add(snum_results.getString("snum"));

                                                // Update all the snums in the suppliers table: add 5 to the status
                                                for (String snum : snums) {
                                                      String update_suppliers_query = "UPDATE suppliers SET status = status + 5 WHERE snum = '"
                                                                  + snum + "'";
                                                      statement.executeUpdate(update_suppliers_query);
                                                }

                                                request.setAttribute("snum_count", snums.size());
                                          }
                                    }
                              } else if (query.toLowerCase().startsWith("update shipments")) {
                              }
                        } else {
                              ResultSet results = statement.getResultSet();
                              request.setAttribute("results", results);

                              // Get the column names
                              for (int i = 0; i < results.getMetaData().getColumnCount(); i++)
                                    request.setAttribute("results_columnName_" + String.valueOf(i + 1),
                                                results.getMetaData().getColumnName(i + 1));
                              request.setAttribute("results_numColumnNames", results.getMetaData().getColumnCount());

                              // Get the rows
                              List<List<String>> rows = new ArrayList<List<String>>();
                              while (results.next()) {
                                    List<String> row = new ArrayList<String>();
                                    for (int i = 1; i <= results.getMetaData().getColumnCount(); i++)
                                          row.add(results.getString(i));
                                    rows.add(row);
                              }

                              // Update the request with the row names
                              for (int i = 0; i < rows.size(); i++)
                                    for (int j = 0; j < rows.get(i).size(); j++)
                                          request.setAttribute("results_rowName_" + String.valueOf(i + 1) + "_"
                                                      + String.valueOf(j + 1), rows.get(i).get(j));
                              request.setAttribute("results_numRows", rows.size());
                        }
                  } catch (SQLException sqlException) {
                        sqlException.printStackTrace();
                        request.setAttribute("queryError", sqlException.getMessage());
                  }
            }

            // forward request to JSP page
            request.getRequestDispatcher("/rootHome.jsp").forward(request, response);
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
