/*
 * Copyright (c) 2013 High Tech Kids.  All rights reserved
 * HighTechKids is on the web at: http://www.hightechkids.org
 * This code is released under GPL; see LICENSE.txt for details.
 */

package fll;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Additional data for system users. Needed to increase security and access control.
 */
public class UserData implements Serializable {

  public UserData(@JsonProperty("user") final String user,
                  @JsonProperty("userName") final String userName,
                  @JsonProperty("userRole") final Integer userRole) {
    _User = user;
    _UserName = userName;
    _UserRole = userRole;
  }

  private final String _User;

  public String getUser() {
    return _User;
  }

  private final String _UserName;

  public String getUserName() {
    return _UserName;
  }

  private final Integer _UserRole;

  public Integer getUserRole() {
    return _UserRole;
  }
  
  /**
   * Compares users.
   */
  @Override
  public boolean equals(final Object o) {
    if (o instanceof UserData) {
      final UserData other = (UserData) o;
      return other.getUser() == getUser();
    } else {
      return false;
    }
  }
/*
  @Override
  public int hashCode() {
    return getUser();
  }
*/
  @Override
  public String toString() {
    return "["
        + getUser() + ": " + getUserName() + "]";
  }
  
}
