/*
 * Copyright (c) 2000-2002 INSciTE.  All rights reserved
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
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import fll.Organization;
import fll.Utilities;
import fll.db.Queries;
import fll.util.LogUtils;
import fll.web.ApplicationAttributes;
import fll.web.WebUtils;
import net.mtu.eggplant.util.sql.SQLFunctions;

/**
 * Gather information for editing or adding an organization and put it in the page
 * context.
 */
public class GatherOrganizationData {

  private static final Logger LOGGER = LogUtils.getLogger();

  public static void populateContext(final HttpServletRequest request,
                                     final ServletContext application,
                                     final PageContext page) throws IOException, ServletException {
    if (LOGGER.isTraceEnabled()) {
      LOGGER.trace("Top of GatherOrganizationData.populateContext");
    }

    final DataSource datasource = ApplicationAttributes.getDataSource(application);
    Connection connection = null;
    try {
      connection = datasource.getConnection();

      final String organizationIdStr = request.getParameter("organizationId");

      if (null == organizationIdStr) {
        // put blanks in for all values
        page.setAttribute("addOrganization", true);
        page.setAttribute("organizationId", null);
        page.setAttribute("name", null);
        page.setAttribute("address", null);
        page.setAttribute("phone", null);
        page.setAttribute("email", null);
        page.setAttribute("website", null);
      } else {
        page.setAttribute("addOrganization", false);

        // check parsing the team number to be sure that we fail right away
        final int organizationId = Utilities.INTEGER_NUMBER_FORMAT_INSTANCE.parse(organizationIdStr).intValue();

        // get the team information and put it in the session
        page.setAttribute("organizationId", organizationId);
        final Organization organization = Organization.getOrganizationFromDatabase(connection, organizationId);
        page.setAttribute("name", organization.getName());
        //page.setAttribute("teamNameEscaped", WebUtils.escapeForHtmlFormValue(team.getTeamName()));
        page.setAttribute("address", organization.getAddress());
        page.setAttribute("phone", organization.getPhone());
        page.setAttribute("email", organization.getEmail());
        page.setAttribute("website", organization.getWebsite());
      }
    } catch (final ParseException pe) {
      LOGGER.error("Error parsing organization ID, this is an internal error", pe);
      throw new RuntimeException("Error parsing organization ID, this is an internal error", pe);
    } catch (final SQLException e) {
      LOGGER.error("There was an error talking to the database", e);
      throw new RuntimeException("There was an error talking to the database", e);
    } finally {
      SQLFunctions.close(connection);
    }

    if (LOGGER.isTraceEnabled()) {
      LOGGER.trace("Bottom of GatherOrganizationData.populateContext");
    }
  }
}
