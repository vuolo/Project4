/* 
  Name: Michael Vuolo
  Course: CNT 4714 – Fall 2022 – Project Four
  Assignment Title: A Three-Tier Distributed Web-Based Application
  Date: December 4, 2022
*/

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class ClientUserApp extends HttpServlet {
      // process "GET" requests from clients
      @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
                  throws ServletException, IOException {

            String query = request.getParameter("query");
            request.setAttribute("query", query);

            request.setAttribute("results", "TODO: Implement query processing");

            // forward request to JSP page
            request.getRequestDispatcher("/clientHome.jsp").forward(request, response);
      }

}
