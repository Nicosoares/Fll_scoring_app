/*
 * Copyright (c) 2000-2002 INSciTE.  All rights reserved
 * INSciTE is on the web at: http://www.hightechkids.org
 * This code is released under GPL; see LICENSE.txt for details.
 */
package fll;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Comparator;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import net.mtu.eggplant.util.ComparisonUtils;
import net.mtu.eggplant.util.StringUtils;
import net.mtu.eggplant.util.sql.SQLFunctions;

/**
 * The static state of an organization. This does not include information about the organization
 * at a given tournament. If
 * someone changes the database, this object does not notice the changes. It's a
 * snapshot in time from when the object was created.
 */
public class Organization implements Serializable {

  /**
   * Compare organizations by id.
   */
  public static final Comparator<Organization> ORGANIZATION_NUMBER_COMPARATOR = new Comparator<Organization>() {
    public int compare(final Organization one,
                       final Organization two) {
      final int oneNum = one.getOrganizationId();
      final int twoNum = two.getOrganizationId();
      if (oneNum < twoNum) {
        return -1;
      } else if (oneNum > twoNum) {
        return 1;
      } else {
        return 0;
      }
    }
  };

  /**
   * Compare organizations by name.
   */
  public static final Comparator<Organization> ORGANIZATION_NAME_COMPARATOR = new Comparator<Organization>() {
    public int compare(final Organization one,
                       final Organization two) {
      return ComparisonUtils.compareStrings(one.getName(), two.getName());
    }
  };

  public Organization(@JsonProperty("organizationId") final int organizationId,
              @JsonProperty("name") final String name,
              @JsonProperty("address") final String address,
			  @JsonProperty("phone") final String phone,
			  @JsonProperty("email") final String email,
			  @JsonProperty("website") final String website) {
    _organizationId = organizationId;
    _name = name;
    _address = address;
    _phone = phone;
    _email = email;
    _website = website;
  }

  /**
   * Builds an organization object from its database info given the organization id.
   * 
   * @param connection Database connection.
   * @param organizationId Id of the organization for which to build an object.
   * @return The new Organization object or null if the organization was not found in the
   *         database.
   * @throws SQLException on a database access error.
   */
  public static Organization getOrganizationFromDatabase(final Connection connection,
                                                         final int organizationId)
      throws SQLException {

    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
      stmt = connection.prepareStatement("SELECT Name, Address, Phone, Email, Website FROM Organizations"
          + " WHERE Organization_id = ?");
      stmt.setInt(1, organizationId);
      rs = stmt.executeQuery();
      if (rs.next()) {
        final String name = rs.getString(1);
        final String address = rs.getString(2);
        final String phone = rs.getString(3);
        final String email = rs.getString(4);
        final String website = rs.getString(5);

        final Organization x = new Organization(organizationId, name, address, phone, email, website);
        return x;
      } else {
        return null;
      }
    } finally {
      SQLFunctions.close(rs);
      SQLFunctions.close(stmt);
    }
  }

  private final int _organizationId;

  /**
   * The organization's ID. This is the primary key for identifying an organization.
   * 
   * @return organization ID
   */
  public int getOrganizationId() {
    return _organizationId;
  }

  private final String _name;

  /**
   * The organization name, this may be a school or youth
   * group.
   * 
   * @return organization name
   */
  public String getName() {
    return _name;
  }

  private final String _address;

  /**
   * The address of the organization.
   * 
   * @return organization address
   */
  public String getAddress() {
    return _address;
  }

  private final String _phone;

  /**
   * The phone number of the organization.
   * 
   * @return organization phone number
   */
  public String getPhone() {
    return _phone;
  }

  private final String _email;

  /**
   * The email address of the organization.
   * 
   * @return organization email address
   */
  public String getEmail() {
    return _email;
  }

  private final String _website;

  /**
   * The website of the organization.
   * 
   * @return organization website
   */
  public String getWebsite() {
    return _website;
  }


  /**
   * Compares organization ids.
   */
  @Override
  public boolean equals(final Object o) {
    if (o instanceof Organization) {
      final Organization other = (Organization) o;
      return other.getOrganizationId() == getOrganizationId();
    } else {
      return false;
    }
  }

  @Override
  public int hashCode() {
    return getOrganizationId();
  }

  @Override
  public String toString() {
    return "["
        + getOrganizationId() + ": " + getName() + "]";
  }

}
