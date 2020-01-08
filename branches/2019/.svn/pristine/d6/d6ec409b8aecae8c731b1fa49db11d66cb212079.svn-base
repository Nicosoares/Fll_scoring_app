/*
 * Copyright (c) 2012 INSciTE.  All rights reserved
 * INSciTE is on the web at: http://www.hightechkids.org
 * This code is released under GPL; see LICENSE.txt for details.
 */
package fll.web.scoreboard;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Formatter;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Nonnull;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import fll.Utilities;
import fll.db.Queries;
import fll.db.TournamentParameters;
import fll.flltools.displaySystem.list.SetArray;
import fll.util.FLLInternalException;
import fll.util.LogUtils;
import fll.web.ApplicationAttributes;
import fll.web.BaseFLLServlet;
import fll.xml.ChallengeDescription;
import fll.xml.ScoreType;

/**
 * Display the most recent scores.
 * Currently hard coded to 12. This was originally 8, thus the name 'Last8'.
 * Now it is hard coded to the last 8 minutes, so the name 'Last8' still aplies.
 */
@WebServlet("/scoreboard/Last8")
public class Last8 extends BaseFLLServlet {

  private static final Logger LOGGER = LogUtils.getLogger();

  /**
   * Escape the string to be used in the scoreboard (Spanish characters are escaped). TODO: DRY code (copied from Top10.java)
   */
  private static String escapeForHtml(final String str) {
    if (null == str) {
      return str;
    } else {
      return str.replace("á", "&aacute;")
                .replace("é", "&eacute;")
                .replace("í", "&iacute;")
                .replace("ó", "&oacute;")
                .replace("ú", "&uacute;")
                .replace("ü", "&uuml;")
                .replace("ñ", "&ntilde;")
                .replace("Á", "&Aacute;")
                .replace("É", "&Eacute;")
                .replace("Í", "&Iacute;")
                .replace("Ó", "&Oacute;")
                .replace("Ú", "&Uacute;")
                .replace("Ü", "&Uuml;")
                .replace("Ñ", "&Ntilde;");
    }
  }

  protected void processRequest(final HttpServletRequest request,
                                final HttpServletResponse response,
                                final ServletContext application,
                                final HttpSession session)
      throws IOException, ServletException {
    if (LOGGER.isTraceEnabled()) {
      LOGGER.trace("Entering doPost");
    }

    final Formatter formatter = new Formatter(response.getWriter());
    final String showOrgStr = request.getParameter("showOrganization");
    final boolean showOrg = null == showOrgStr ? true : Boolean.parseBoolean(showOrgStr);
    final String practiceRoundStr = request.getParameter("practiceRound");
    final boolean practiceRound = null == practiceRoundStr ? false : Boolean.parseBoolean(practiceRoundStr);
	final String bgColor = "#800000";
	
	formatter.format("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">%n");
	formatter.format("<html>%n");
	formatter.format("<head>%n");
	formatter.format("<link rel='stylesheet' type='text/css' href='../style/fll-sw.css' />%n");
	formatter.format("<link rel='stylesheet' type='text/css' href='score_style.css' />%n");
	formatter.format("<link rel='stylesheet' type='text/css' href='../style/bootstrap/bootstrap.min.css' />%n");
	formatter.format("<link rel='stylesheet' type='text/css' href='../style/bootstrap/bootstrap-theme.min.css' />%n");
	//formatter.format("<meta http-equiv='refresh' content='%d' />%n",
	//                 GlobalParameters.getIntGlobalParameter(connection, GlobalParameters.DIVISION_FLIP_RATE));
    formatter.format("<meta http-equiv='refresh' content='5' />%n"); // TODO: use a new parameter stored in GlobalParameters
    formatter.format("<meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />%n");
    formatter.format("<meta content='IE=edge' http-equiv='X-UA-Compatible' />%n");
    formatter.format("<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />%n");

	formatter.format("<script type='text/javascript' src='../extlib/jquery-3.2.0.min.js'></script>");

	formatter.format("<script type='text/javascript' src='../extlib/bootstrap/bootstrap.min.js'></script>");


    formatter.format("</head>%n");

    formatter.format("<body class='scoreboard'>%n");

	  formatter.format("<div class='panel row row-list'>%n"
                     + "  <div class='col-xs-3'>%n"
                     + "    <img src='../images/tournament-logo.jpg' style='float:left' width='auto' height='90px'/>%n"
                     + "  </div>%n"
                     + "  <div class='col-xs-6'>%n"
	                 + (showOrg ? "  <h2" : "  <h3") + " class='text-center text-primary'>%n"
	                 + "2018/2019 FIRST LEGO League" 
					 + (showOrg ? "</h2>%n" : "</h3>%n")
                     + "  </div>%n"
                     + "  <div class='col-xs-3'>%n"
					 + "    <img src='../images/challenge-logo.jpg' style='float:right' width='auto' height='100px'/>%n"
                     + "  </div>%n"
					 + "</div>%n");

      formatter.format("<table border='1' cellpadding='2' cellspacing='0' width='100%%'>%n");

      formatter.format("<colgroup>%n");
      formatter.format("<col width='30px' />%n");
      formatter.format("<col width='250px' />%n");
//    formatter.format("<col />%n");
      if (showOrg) {
        formatter.format("<col width='380px' />%n");
      }
      formatter.format("<col width='100px' />%n");
      formatter.format("<col width='100px' />%n");
      //formatter.format("<col width='70px' />%n");
      //formatter.format("<col width='70px' />%n");
      formatter.format("</colgroup>%n");

        formatter.format("<thead><tr>%n");
        int numColumns = 5;
        if (!showOrg) {
          --numColumns;
        }
        formatter.format("<th class='text-center' colspan='%d' bgcolor='%s'>RESULTADOS DE LOS JUEGOS RECIENTES</th>", numColumns,
                         bgColor);
        formatter.format("</tr>%n");

          formatter.format("<tr>%n");
		//formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>&nbsp;Pos.</th>", bgColor);
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Equipo</th>", bgColor);
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Nombre del equipo</th>", bgColor);
		if (showOrg)
			formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>%s</th>", bgColor, escapeForHtml("Centro educativo u organización"));
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Puntaje</th>", bgColor);
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Ronda</th>", bgColor);
		//formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Ronda 2</th>", bgColor);
		//formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Ronda 3</th>", bgColor);
		formatter.format("</tr></thead><tbody>%n");

/*
    formatter.format("<table border='1' cellpadding='2' cellspacing='0' width='98%%'>%n");

    formatter.format("<colgroup>%n");
    formatter.format("<col width='75px' />%n");
    formatter.format("<col />%n");
    if (showOrg) {
      formatter.format("<col />%n");
    }
    formatter.format("<col width='100px' />%n");
    formatter.format("<col width='75px' />%n");
    formatter.format("</colgroup>%n");

    formatter.format("<tr>%n");
    int numColumns = 5;
    if (!showOrg) {
      --numColumns;
    }
    formatter.format("<th colspan='%d' bgcolor='#800080'>RESULTADOS DE LOS JUEGOS RECIENTES</th>%n", numColumns);
    formatter.format("</tr>%n");
*/
    // scores here
    try {
      processScores(application, (teamNumber,
                                  teamName,
                                  organization,
                                  awardGroup,
                                  formattedScore) -> {
        formatter.format("<tr>%n");
        formatter.format("<td class='center'>%d</td>%n", teamNumber);
        if (null == teamName) {
          teamName = "&nbsp;";
        }
        formatter.format("<td class='left truncate'>%s</td>%n", escapeForHtml(teamName));
        if (showOrg) {
          if (null == organization) {
            organization = "&nbsp;";
          }
          formatter.format("<td class='left truncate'>%s</td>%n", escapeForHtml(organization));
        }
        formatter.format("<td class='center'>%s</td>", formattedScore);

        formatter.format("<td class='center truncate'>%s</td>%n", practiceRound ? escapeForHtml("Práctica") : awardGroup); // runNumber

        formatter.format("</tr>%n");
      });
    } catch (final SQLException e) {
      throw new FLLInternalException("Got an error getting the most recent scores from the database", e);
    }

    if (LOGGER.isTraceEnabled()) {
      LOGGER.trace("Exiting doPost");
    }
  }

  /**
   * Get the displayed data as a list for flltools.
   * 
   * @param application get all of the appropriate parameters
   * @return payload for the set array message
   */
  public static SetArray.Payload getTableAsList(@Nonnull final ServletContext application) throws SQLException {

    final List<List<String>> data = new LinkedList<>();
    processScores(application, (teamNumber,
                                teamName,
                                organization,
                                awardGroup,
                                formattedScore) -> {
      final List<String> row = new LinkedList<>();

      row.add(String.valueOf(teamNumber));
      if (null == teamName) {
        row.add("");
      } else {
        row.add(teamName);
      }

      if (null == organization) {
        row.add("");
      } else {
        row.add(organization);
      }

      row.add(awardGroup);

      row.add(formattedScore);

      data.add(row);
    });

    final SetArray.Payload payload = new SetArray.Payload("Most Recent Performance Scores", data);
    return payload;
  }

  private static interface ProcessScoreEntry {
    public void execute(final int teamNumber,
                        final String teamName,
                        final String organization,
                        @Nonnull final String awardGroup,
                        @Nonnull final String formattedScore);
  }

  /**
   * @param application the context to get the database connection from
   * @param processor passed the {@link ResultSet} for each row. (Team Number,
   *          Organization, Team
   *          Name, award group, bye, no show, computed total)
   */
  private static void processScores(@Nonnull final ServletContext application,
                                    @Nonnull final ProcessScoreEntry processor)
      throws SQLException {
    final DataSource datasource = ApplicationAttributes.getDataSource(application);
    try (Connection connection = datasource.getConnection()) {
      final int maxMinutesToDisplay = 8; /* TODO: use a parameterized value */
      final int maxResultsToDisplay = 12; /* TODO: use a parameterized value */
      final int currentTournament = Queries.getCurrentTournament(connection);
      final int maxScoreboardRound = TournamentParameters.getMaxScoreboardPerformanceRound(connection,
                                                                                           currentTournament);
      final ChallengeDescription challengeDescription = ApplicationAttributes.getChallengeDescription(application);
      final ScoreType performanceScoreType = challengeDescription.getPerformance().getScoreType();

      try (PreparedStatement prep = connection.prepareStatement("SELECT Teams.TeamNumber"
          + ", Teams.Organization" //
          + ", Teams.TeamName" //
          + ", current_tournament_teams.event_division" //
          + ", verified_performance.runnumber" //
          + ", verified_performance.Bye" //
          + ", verified_performance.NoShow" //
          + ", verified_performance.ComputedTotal" //
          + " FROM Teams,verified_performance,current_tournament_teams"//
          + " WHERE verified_performance.Tournament = ?" //
          + "  AND Teams.TeamNumber = verified_performance.TeamNumber" //
          + "  AND Teams.TeamNumber = current_tournament_teams.TeamNumber" //
          + "  AND verified_performance.Bye = False" //
          + "  AND verified_performance.RunNumber <= ?"//
          + "  AND verified_performance.TimeStamp >= SYSDATE - ? MINUTE"//
          + " ORDER BY Teams.TeamNumber ASC, verified_performance.TimeStamp DESC LIMIT ?")) {
        prep.setInt(1, currentTournament);
        prep.setInt(2, maxScoreboardRound);
        prep.setInt(3, maxMinutesToDisplay);
        prep.setInt(4, maxResultsToDisplay);
        try (ResultSet rs = prep.executeQuery()) {
          while (rs.next()) {
            final int teamNumber = rs.getInt("TeamNumber");
            final String teamName = rs.getString("TeamName");

            final String organization = rs.getString("Organization");
            //final String awardGroup = rs.getString("event_division");
            final String awardGroup = rs.getString("runnumber"); // TODO: refactor awardGroup to display runnumber instead

            final String formattedScore;
            if (rs.getBoolean("NoShow")) {
              formattedScore = "No Show";
            } else if (rs.getBoolean("Bye")) {
              formattedScore = "Bye";
            } else {
              formattedScore = Utilities.getFormatForScoreType(performanceScoreType)
                                        .format(rs.getDouble("ComputedTotal"));
            }

            processor.execute(teamNumber, teamName, organization, awardGroup, formattedScore);
          } // end while next
        } // try ResultSet
      } // try PreparedStatement

    } // try connection
  }
}
