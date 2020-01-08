/*
 * Copyright (c) 2013 High Tech Kids.  All rights reserved
 * HighTechKids is on the web at: http://www.hightechkids.org
 * This code is released under GPL; see LICENSE.txt for details.
 */

package fll.web.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;
import javax.sql.DataSource;

import net.mtu.eggplant.util.ComparisonUtils;
import net.mtu.eggplant.util.sql.SQLFunctions;

import org.apache.commons.codec.digest.DigestUtils;

import fll.Role;
import fll.UserData;
import fll.db.Queries;
import fll.web.ApplicationAttributes;
import fll.web.BaseFLLServlet;
import fll.web.CookieUtils;
import fll.web.SessionAttributes;

/**
 * Java code to handle changing passwords of users by admins.
 */
@WebServlet("/admin/EditUser")
public class EditUser extends BaseFLLServlet {

  public static void populateContext(final HttpServletRequest request,
                                     final ServletContext application,
                                     final PageContext pageContext) {

    final DataSource datasource = ApplicationAttributes.getDataSource(application);
    Connection connection = null;
    try {
      connection = datasource.getConnection();

      final Collection<String> loginKeys = CookieUtils.findLoginKey(request);
      final String user = Queries.checkValidLogin(connection, loginKeys);
      pageContext.setAttribute("fll_user", user);

      //final Collection<String> usersData = Queries.getUsers(connection);
      final Collection<UserData> usersData = Queries.getUsersData(connection); 
      pageContext.setAttribute("all_users", usersData);

      //final Collection<String> roles = Queries.getRoles(connection);
      //final Map<Integer, String> roles = Queries.getRoles(connection);
      final Collection<Role> roles = Queries.getRoles(connection);
      pageContext.setAttribute("all_roles", roles);

    } catch (final SQLException e) {
      throw new RuntimeException(e);
    } finally {
      SQLFunctions.close(connection);
    }

  }

  @Override
  protected void processRequest(final HttpServletRequest request,
                                final HttpServletResponse response,
                                final ServletContext application,
                                final HttpSession session) throws IOException, ServletException {
    final DataSource datasource = ApplicationAttributes.getDataSource(application);
    Connection connection = null;
    try {
      connection = datasource.getConnection();

      final String user = request.getParameter("selected_user");
      if (null != user
          && !user.isEmpty()) {
		  final String newPassword = request.getParameter("new_pass");
		  final String newPasswordCheck = request.getParameter("pass_check");
		  if (!ComparisonUtils.safeEquals(newPassword, newPasswordCheck)) {
			session.setAttribute(SessionAttributes.MESSAGE, "<p class='error'>New passwords don't match</p>");
			response.sendRedirect(response.encodeRedirectURL("changePasswords.jsp"));
			return;
		  }

		  final String newPasswordHash = DigestUtils.md5Hex(newPassword);

		  Queries.changePassword(connection, user, newPasswordHash);

		  session.setAttribute(SessionAttributes.MESSAGE, "<p id='success'>Password changed for user  '" + user + "'.</p>");
      }

      response.sendRedirect(response.encodeRedirectURL("changePasswords.jsp"));

    } catch (final SQLException e) {
      throw new RuntimeException(e);
    } finally {
      SQLFunctions.close(connection);
    }

  }

}
