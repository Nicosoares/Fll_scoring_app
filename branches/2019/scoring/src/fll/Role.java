/*
 * Copyright (c) 2013 High Tech Kids.  All rights reserved
 * HighTechKids is on the web at: http://www.hightechkids.org
 * This code is released under GPL; see LICENSE.txt for details.
 */

package fll;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Roles. Needed to increase security and access control.
 */
public class Role {

  public Role(@JsonProperty("role") final int role,
                  @JsonProperty("roleName") final String roleName,
                  @JsonProperty("roleDescription") final String roleDescription) {
    _role = role;
    _roleName = roleName;
    _roleDescription = roleDescription;
  }

  private final String _roleName;

  public String getRoleName() {
    return _roleName;
  }

  private final String _roleDescription;

  public String getRoleDescription() {
    return _roleDescription;
  }

  private final int _role;

  public int getRole() {
    return _role;
  }
    
}
