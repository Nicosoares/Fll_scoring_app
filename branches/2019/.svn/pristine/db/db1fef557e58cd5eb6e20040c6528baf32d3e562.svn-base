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

import net.mtu.eggplant.util.sql.SQLFunctions;

import org.apache.log4j.Logger;

import edu.umd.cs.findbugs.annotations.SuppressFBWarnings;
import fll.Utilities;
import fll.db.GlobalParameters;
import fll.db.Queries;
import fll.db.TournamentParameters;
import fll.flltools.displaySystem.list.SetArray;
import fll.util.FP;
import fll.util.LogUtils;
import fll.web.ApplicationAttributes;
import fll.web.BaseFLLServlet;
import fll.web.SessionAttributes;
import fll.xml.ChallengeDescription;
import fll.xml.ScoreType;
import fll.xml.WinnerType;

@WebServlet("/scoreboard/Top10")
public class Top10 extends BaseFLLServlet {

  private static final Logger LOGGER = LogUtils.getLogger();

  /**
   * Max number of characters in a team name to display.
   */
  public static final int MAX_TEAM_NAME = 12;

  /**
   * Max number of characters in an organization to display.
   */
  public static final int MAX_ORG_NAME = 20;
  
  /**
   * Escape the string to be used in the scoreboard (Spanish characters are escaped).
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
    final DataSource datasource = ApplicationAttributes.getDataSource(application);

    PreparedStatement prep = null;
    ResultSet rs = null;
    Connection connection = null;
    try {
      connection = datasource.getConnection();

      final Integer divisionIndexObj = SessionAttributes.getAttribute(session, "divisionIndex", Integer.class);
      int awardGroupIndex;
      if (null == divisionIndexObj) {
        awardGroupIndex = 0;
      } else {
        awardGroupIndex = divisionIndexObj.intValue();
      }
      ++awardGroupIndex;
      final List<String> awardGroups = Queries.getAwardGroups(connection);
      if (awardGroupIndex >= awardGroups.size()) {
        awardGroupIndex = 0;
      }
      session.setAttribute("divisionIndex", Integer.valueOf(awardGroupIndex));

      formatter.format("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">%n");
      formatter.format("<html>%n");
      formatter.format("<head>%n");
      formatter.format("<link rel='stylesheet' type='text/css' href='../style/fll-sw.css' />%n");
      formatter.format("<link rel='stylesheet' type='text/css' href='score_style.css' />%n");
      formatter.format("<link rel='stylesheet' type='text/css' href='../style/bootstrap/bootstrap.min.css' />%n");
      formatter.format("<link rel='stylesheet' type='text/css' href='../style/bootstrap/bootstrap-theme.min.css' />%n");
      formatter.format("<meta http-equiv='refresh' content='%d' />%n",
                       GlobalParameters.getIntGlobalParameter(connection, GlobalParameters.DIVISION_FLIP_RATE));
      formatter.format("<meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />%n");
      formatter.format("<meta content='IE=edge' http-equiv='X-UA-Compatible' />%n");
      formatter.format("<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />%n");

	  formatter.format("<script type='text/javascript' src='../extlib/jquery-3.2.0.min.js'></script>");

	  formatter.format("<script type='text/javascript' src='../extlib/bootstrap/bootstrap.min.js'></script>");
	
	  formatter.format("<script type='text/javascript' src='../scripts/scrollTable.js'></script>");

      formatter.format("<script type='text/javascript'>$(document).ready(function() { startScrolling(); }); </script>");

      formatter.format("</head>%n");

      formatter.format("<body class='scoreboard' id='body-scoreboard'>%n");

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

      formatter.format("<table border='1' cellpadding='2' cellspacing='0' width='100%%' class='scroll'>%n"); /* 98%% */

      formatter.format("<colgroup>%n");
      formatter.format("<col width='30px' />%n");
      formatter.format("<col width='250px' />%n");
//    formatter.format("<col />%n");
      if (showOrg) {
        formatter.format("<col width='300px' />%n");
      }
      formatter.format("<col width='70px' />%n");
      formatter.format("<col width='70px' />%n");
      formatter.format("<col width='70px' />%n");
      formatter.format("<col width='70px' />%n");
      formatter.format("</colgroup>%n");

      if (!awardGroups.isEmpty()) {
        final String awardGroupName = awardGroups.get(awardGroupIndex);

        formatter.format("<thead><tr>%n");
        int numColumns = 7;
        if (!showOrg) {
          --numColumns;
        }
        formatter.format("<th class='text-center' colspan='%d' bgcolor='%s'>Posiciones de los equipos</th>", numColumns,
                         Queries.getColorForIndex(awardGroupIndex));//, awardGroupName);
        formatter.format("</tr>%n");

          formatter.format("<tr>%n");
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>&nbsp;Pos.</th>", Queries.getColorForIndex(awardGroupIndex));
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Equipo</th>", Queries.getColorForIndex(awardGroupIndex));
		//formatter.format("<th colspan='1' bgcolor='%s'>Nombre del equipo</th>", Queries.getColorForIndex(awardGroupIndexisionIndex));
		if (showOrg)
			formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>%s</th>", Queries.getColorForIndex(awardGroupIndex), escapeForHtml("Centro educativo u organización"));
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>%s</th>", Queries.getColorForIndex(awardGroupIndex), escapeForHtml("Puntaje máximo"));
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Ronda 1</th>", Queries.getColorForIndex(awardGroupIndex));
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Ronda 2</th>", Queries.getColorForIndex(awardGroupIndex));
		formatter.format("<th class='text-center' colspan='1' bgcolor='%s'>Ronda 3</th>", Queries.getColorForIndex(awardGroupIndex));
		formatter.format("</tr></thead><tbody>%n");


      final ChallengeDescription challengeDescription = ApplicationAttributes.getChallengeDescription(application);
      final ScoreType performanceScoreType = challengeDescription.getPerformance().getScoreType();
      final WinnerType winnerCriteria = challengeDescription.getWinner();

      final int currentTournament = Queries.getCurrentTournament(connection);
      final int maxScoreboardRound = TournamentParameters.getMaxScoreboardPerformanceRound(connection,
                                                                                           currentTournament);

          prep = connection.prepareStatement("SELECT Teams.TeamName, Teams.Organization, Teams.TeamNumber, T2.MaxOfComputedScore" //
		    + "     , VP1.ComputedTotal as ComputedTotalR1, VP2.ComputedTotal as ComputedTotalR2, VP3.ComputedTotal as ComputedTotalR3 " //
              + " FROM (SELECT TeamNumber, " //
              + winnerCriteria.getMinMaxString()
              + "(ComputedTotal) AS MaxOfComputedScore" //
              + "  FROM verified_performance WHERE Tournament = ? "
              + "   AND NoShow = False" //
              + "   AND Bye = False" //
              + "   AND RunNumber <= ?" //
              + "  GROUP BY TeamNumber) AS T2"
            + " JOIN Teams ON Teams.TeamNumber = T2.TeamNumber, current_tournament_teams" //
			+ " left join verified_performance VP1 on VP1.RunNumber = 1 AND VP1.TeamNumber = Teams.TeamNumber"
			+ " AND VP1.Tournament = ? AND VP1.NoShow = False AND VP1.Bye = False"
			+ " left join verified_performance VP2 on VP2.RunNumber = 2 AND VP2.TeamNumber = Teams.TeamNumber"
			+ " AND VP2.Tournament = ? AND VP2.NoShow = False AND VP2.Bye = False"
			+ " left join verified_performance VP3 on VP3.RunNumber = 3 AND VP3.TeamNumber = Teams.TeamNumber"
			+ " AND VP3.Tournament = ? AND VP3.NoShow = False AND VP3.Bye = False"
              + " WHERE Teams.TeamNumber = current_tournament_teams.TeamNumber" //
              + " AND current_tournament_teams.event_division = ?"
              + " ORDER BY T2.MaxOfComputedScore "
            + winnerCriteria.getSortString());
            
        prep.setInt(1, currentTournament);
        prep.setInt(2, maxScoreboardRound);
        prep.setInt(3, currentTournament);
        prep.setInt(4, currentTournament);
        prep.setInt(5, currentTournament);
        prep.setString(6, awardGroupName);
        rs = prep.executeQuery();

          double prevScore = -1;
          int i = 1;
          int rank = 0;
          while (rs.next()) {
            final double score = rs.getDouble("MaxOfComputedScore");
            if (!FP.equals(score, prevScore, 1E-6)) {
              rank = i;
            }

            final int teamNumber = rs.getInt("TeamNumber");
          String teamName = teamNumber + " " + escapeForHtml(rs.getString("TeamName"));
          formatter.format("<tr>%n");
          formatter.format("<td class='center'>%d</td>%n", rank);

            if (null == teamName) {
            teamName = "&nbsp;";
            }
          formatter.format("<td class='left truncate'>%s</td>%n", teamName);
          if (showOrg) {
            String organization = escapeForHtml(rs.getString("Organization"));
            if (null == organization) {
              organization = "&nbsp;";
            }
            formatter.format("<td class='left truncate'>%s</td>%n", organization);
          }

            final String formattedScore = Utilities.getFormatForScoreType(performanceScoreType).format(score);
          final String formattedTotalR1 = Utilities.getFormatForScoreType(performanceScoreType).format(rs.getDouble("ComputedTotalR1"));
          final String formattedTotalR2 = Utilities.getFormatForScoreType(performanceScoreType).format(rs.getDouble("ComputedTotalR2"));
          final String formattedTotalR3 = Utilities.getFormatForScoreType(performanceScoreType).format(rs.getDouble("ComputedTotalR3"));

          formatter.format("<td class='center'>%s</td>%n", formattedScore.equals("0") ? "-" : formattedScore);
 
		  formatter.format("<td class='center'>%s</td>%n", formattedTotalR1.equals("0") ? "-" : formattedTotalR1);
          formatter.format("<td class='center'>%s</td>%n", formattedTotalR2.equals("0") ? "-" : formattedTotalR2);
          formatter.format("<td class='center'>%s</td>%n", formattedTotalR3.equals("0") ? "-" : formattedTotalR3);

          formatter.format("</tr>");

            prevScore = score;
            ++i;
          } // end while next
      } // end awardGroups not empty
      formatter.format("</tbody></table>%n");
      formatter.format("</body>%n");
      formatter.format("</html>%n");
    } catch (final SQLException e) {
      throw new RuntimeException("Error talking to the database", e);
    } finally {
      SQLFunctions.close(rs);
      SQLFunctions.close(prep);
      SQLFunctions.close(connection);
    }

    if (LOGGER.isTraceEnabled()) {
      LOGGER.trace("Exiting doPost");
    }
  }
  
  /**
   * Used for processing the result of a score query.
   */
  private static interface ProcessScoreEntry {
    public void execute(final String teamName,
                        final int teamNumber,
                        final String organization,
                        @Nonnull final String formattedScore,
                        final int rank);
  }

  /**
   * Get the displayed data as a list for flltools.
   * 
   * @param awardGroupName the award group to get scores for
   * @param application get all of the appropriate parameters
   * @return payload for the set array message
   * @throws SQLException on a database error
   */
  public static SetArray.Payload getTableAsList(@Nonnull final ServletContext application,
                                                @Nonnull final String awardGroupName)
      throws SQLException {
    final List<List<String>> data = new LinkedList<>();
    processScores(application, awardGroupName, (teamName,
                                                teamNumber,
                                                organization,
                                                formattedScore,
                                                rank) -> {
      final List<String> row = new LinkedList<>();

      row.add(String.valueOf(rank));
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
      row.add(formattedScore);
      data.add(row);
    });

    final SetArray.Payload payload = new SetArray.Payload("Top Performance Scores: "
        + awardGroupName, data);
    return payload;

  }

  @SuppressFBWarnings(value = { "SQL_PREPARED_STATEMENT_GENERATED_FROM_NONCONSTANT_STRING" }, justification = "Determine sort order based upon winner criteria")
  private static void processScores(@Nonnull final ServletContext application,
                                    @Nonnull final String awardGroupName,
                                    @Nonnull final ProcessScoreEntry processor)
      throws SQLException {
    final DataSource datasource = ApplicationAttributes.getDataSource(application);

    try (Connection connection = datasource.getConnection()) {
      final ChallengeDescription challengeDescription = ApplicationAttributes.getChallengeDescription(application);
      final ScoreType performanceScoreType = challengeDescription.getPerformance().getScoreType();
      final WinnerType winnerCriteria = challengeDescription.getWinner();

      final int currentTournament = Queries.getCurrentTournament(connection);
      final int maxScoreboardRound = TournamentParameters.getMaxScoreboardPerformanceRound(connection,
                                                                                           currentTournament);

      try (
          PreparedStatement prep = connection.prepareStatement("SELECT Teams.TeamName, Teams.Organization, Teams.TeamNumber, T2.MaxOfComputedScore" //
              + " FROM (SELECT TeamNumber, " //
              + winnerCriteria.getMinMaxString()
              + "(ComputedTotal) AS MaxOfComputedScore" //
              + "  FROM verified_performance WHERE Tournament = ? "
              + "   AND NoShow = False" //
              + "   AND Bye = False" //
              + "   AND RunNumber <= ?" //
              + "  GROUP BY TeamNumber) AS T2"
              + " JOIN Teams ON Teams.TeamNumber = T2.TeamNumber, current_tournament_teams"
              + " WHERE Teams.TeamNumber = current_tournament_teams.TeamNumber" //
              + " AND current_tournament_teams.event_division = ?"
              + " ORDER BY T2.MaxOfComputedScore "
              + winnerCriteria.getSortString())) {
        prep.setInt(1, currentTournament);
        prep.setInt(2, maxScoreboardRound);
        prep.setString(3, awardGroupName);
        try (ResultSet rs = prep.executeQuery()) {

          double prevScore = -1;
          int i = 1;
          int rank = 0;
          while (rs.next()) {
            final double score = rs.getDouble("MaxOfComputedScore");
            if (!FP.equals(score, prevScore, 1E-6)) {
              rank = i;
            }

            final int teamNumber = rs.getInt("TeamNumber");
            String teamName = rs.getString("TeamName");
            if (null == teamName) {
              teamName = "";
            }

            String organization = rs.getString("Organization");
            if (null == organization) {
              organization = "";
            }

            final String formattedScore = Utilities.getFormatForScoreType(performanceScoreType).format(score);

            processor.execute(teamName, teamNumber, organization, formattedScore, rank);
            prevScore = score;
            ++i;
          } // end while next
        } // try ResultSet
      } // try PreparedStatement

    }
  }

}

