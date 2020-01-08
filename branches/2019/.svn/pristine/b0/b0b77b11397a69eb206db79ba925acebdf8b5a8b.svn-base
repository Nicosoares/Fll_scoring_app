/*
 * Copyright (c) 2011 INSciTE.  All rights reserved
 * INSciTE is on the web at: http://www.hightechkids.org
 * This code is released under GPL; see LICENSE.txt for details.
 */

package fll.web.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Collection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import net.mtu.eggplant.util.sql.SQLFunctions;

import org.apache.commons.codec.digest.DigestUtils;

import fll.db.Queries;
import fll.Utilities;
import fll.web.ApplicationAttributes;
import fll.web.BaseFLLServlet;
import fll.web.CookieUtils;
import fll.web.DoLogin;
import fll.web.SessionAttributes;

/**
 * Create a user if.
 */
@WebServlet("/admin/EditOrganization")
public class EditOrganization extends BaseFLLServlet {

  @Override
  protected void processRequest(final HttpServletRequest request,
                                final HttpServletResponse response,
                                final ServletContext application,
                                final HttpSession session) throws IOException, ServletException {

    PreparedStatement editOrganization = null;
	int organizationId = 0;
    final DataSource datasource = ApplicationAttributes.getDataSource(application);
    Connection connection = null;
    try {
      connection = datasource.getConnection();

      final String organizationIdStr = request.getParameter("organizationId");
	  String redirect = "editOrganization.jsp";
	  String action = null;

      if (null != organizationIdStr && !organizationIdStr.isEmpty()) {
		 organizationId = Utilities.INTEGER_NUMBER_FORMAT_INSTANCE.parse(organizationIdStr).intValue();
		 redirect = redirect + "?organizationId=" + organizationIdStr;
	  }
		  
      final String name = request.getParameter("name");
	  final String address = request.getParameter("address");
      final String phone = request.getParameter("phone");
      final String email = request.getParameter("email");
      final String website = request.getParameter("website");
      if (null == name || name.isEmpty()) {
        session.setAttribute(SessionAttributes.MESSAGE,
                             "<p class='error'>You must enter the name of the organization.</p>");
							 
        response.sendRedirect(response.encodeRedirectURL(redirect));
        return;
      }

      if (Boolean.valueOf(request.getParameter("addOrganization"))) {
		  editOrganization = connection.prepareStatement("INSERT INTO ORGANIZATIONS (ORGANIZATION_ID, NAME, ADDRESS, PHONE, EMAIL, WEBSITE) VALUES(NULL, ?, ?, ?, ?, ?)");
		  action = "created";
	  }
	  else {
		 editOrganization = connection.prepareStatement("UPDATE ORGANIZATIONS SET NAME=?, ADDRESS=?, PHONE=?, EMAIL=?, WEBSITE=?, TIMESTAMP=CURRENT_TIMESTAMP WHERE ORGANIZATION_ID=?");
	     editOrganization.setInt(6, organizationId);
		 action = "updated";
	  }  
	  editOrganization.setString(1, name);
	  editOrganization.setString(2, address);
	  editOrganization.setString(3, phone);
	  editOrganization.setString(4, email);
	  editOrganization.setString(5, website);
	  editOrganization.executeUpdate();	  
	  
      session.setAttribute(SessionAttributes.MESSAGE, "<p class='success' id='success-create-org'>Organization successfully " + action + ": '" + name + "'</p>");

      // do a login if not already logged in
      final Collection<String> loginKeys = CookieUtils.findLoginKey(request);
      final String authenticatedUser = Queries.checkValidLogin(connection, loginKeys);
      if (null == authenticatedUser) {
        DoLogin.doLogin(request, response, application, session);
      } else {
        response.sendRedirect(response.encodeRedirectURL(redirect));
      }

    } catch (final ParseException pe) {
      //LOGGER.error("Error parsing organization ID, this is an internal error", pe);
      throw new RuntimeException("Error parsing organization ID, this is an internal error", pe);
	  }
	  catch (final SQLException e) {
      throw new RuntimeException(e);
    } finally {
      SQLFunctions.close(editOrganization);
      SQLFunctions.close(connection);
    }

  }
}
