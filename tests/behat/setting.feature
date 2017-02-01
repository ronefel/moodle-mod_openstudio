@ou @ou_vle @mod @mod_openstudio @mod_openstudio_test_content @_file_upload @javascript
Feature: Create and edit contents
    When using Open Studio with other users
    As a teacher
    I need to create a content and upload a file

    Background: Setup course and studio
        Given the following "users" exist:
            | username | firstname | lastname | email |
            | teacher1 | Teacher | 1 | teacher1@asd.com |
            | student1 | Student | 1 | student1@asd.com |
            | student2 | Student | 2 | student2@asd.com |
            | student3 | Student | 3 | student3@asd.com |
            | student4 | Student | 4 | student4@asd.com |
        And the following "courses" exist:
            | fullname | shortname | category |
            | Course 1 | C1 | 0 |
        And the following "course enrolments" exist:
            | user | course | role |
            | teacher1 | C1 | editingteacher |
            | student1 | C1 | student |
            | student2 | C1 | student |
            | student3 | C1 | student |
            | student4 | C1 | student |
        And the following "groups" exist:
            | name   | course | idnumber |
            | group1 | C1     | G1       |
            | group2 | C1     | G2       |
            | group3 | C1     | G3       |
        And the following "groupings" exist:
            | name      | course | idnumber |
            | grouping1 | C1     | GI1      |
        And the following "grouping groups" exist:
            | grouping | group |
            | GI1      | G1    |
            | GI1      | G2    |
            | GI1      | G3    |
        And the following "group members" exist:
            | user     | group  |
            | teacher1 | G1 |
            | student1 | G1 |
            | student2 | G1 |
            | teacher1 | G2 |
            | student2 | G2 |
            | student3 | G2 |
            | teacher1 | G3 |
            | student3 | G3 |
            | student4 | G3 |
        And I log in as "teacher1"

    Scenario: Change labels of setting
        When I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on
        And I add a "Open Studio" to section "1"
        And I follow "Expand all"
        Then I should see "Your word for 'My Module'"
        And I should see "Your word for 'My Group'"
        And I should see "Your word for 'My Activities'"
        And I should see "Your word for 'My Pinboard'"
        And I should see " Enable 'My Module'"
        And the "value" attribute of "div[id='fitem_id_pinboard'] div.felement input" "css_element" should contain "100"
        And I should see "Site upload limit (10MB)"

    Scenario: Behavior handling for People Tab
        When I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on
        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                         | Test Open Studio name 1      |
          | Description                  | Test Open Studio description |
          | Enable 'My Module'           | 0                            |
          | Abuse reports are emailed to | teacher1@asd.com             |
          | ID number                    | OS1                          |

        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                          | Test Open Studio name 2        |
          | Description                   | Test Open Studio description 2 |
          | Your word for 'My Module'     | My Module                      |
          | Your word for 'My Group'      | My Group                       |
          | Your word for 'My Activities' | My Activities                  |
          | Your word for 'My Pinboard'   | My Pinboard                    |
          | Group mode                    | Visible groups                 |
          | Grouping                      | grouping1                      |
          | Enable pinboard               | 99                             |
          | Enable Folders                | 1                              |
          | Abuse reports are emailed to  | teacher1@asd.com               |
          | ID number                     | OS2                            |
        And I follow "Test Open Studio name 1"
        Then I should not see "People"
        And I follow "Course 1"
        And I follow "Test Open Studio name 2"
        Then I should see "People"

    Scenario: Behavior handling for Shared Content
        Given I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on

        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                          | Test Open Studio name 1        |
          | Description                   | Test Open Studio description 1 |
          | Your word for 'My Module'     | My Module                      |
          | Your word for 'My Activities' | My Activities                  |
          | Your word for 'My Pinboard'   | My Pinboard                    |
          | Enable 'My Module'            | 0                              |
          | Group mode                    | Visible groups                 |
          | Grouping                      | grouping1                      |
          | Enable pinboard               | 99                             |
          | Enable Folders                | 1                              |
          | Abuse reports are emailed to  | teacher1@asd.com               |
          | ID number                     | OS21                           |

        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                         | Test Open Studio name 2      |
          | Description                  | Test Open Studio description |
          | Abuse reports are emailed to | teacher1@asd.com             |
          | ID number                    | OS2                          |

        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                          | Test Open Studio name 3        |
          | Description                   | Test Open Studio description 3 |
          | Your word for 'My Module'     | My Module                      |
          | Your word for 'My Group'      | My Group                       |
          | Your word for 'My Activities' | My Activities                  |
          | Your word for 'My Pinboard'   | My Pinboard                    |
          | Group mode                    | Visible groups                 |
          | Grouping                      | grouping1                      |
          | Enable pinboard               | 99                             |
          | Enable Folders                | 1                              |
          | Abuse reports are emailed to  | teacher1@asd.com               |
          | ID number                     | OS3                            |

        # Only My Group is available
        When I follow "Test Open Studio name 1"
        Then I should see "Shared Content"
        And I follow "Shared Content"
        Then I should see "My Group"

        # Only My Module is available
        When I follow "Course 1"
        And I follow "Test Open Studio name 2"
        Then I should see "Shared Content"
        And I follow "Shared Content"
        Then I should see "My Module"

        # My Module and My Group are available
        When I follow "Course 1"
        And I follow "Test Open Studio name 3"
        Then I should see "Shared Content"
        And I click on "li.shared-content" "css_element"
        Then I should see "My Group"
        And I should see "My Module"

    Scenario: Behavior handling for My Content with My Activities:
        When I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on
        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                         | Test Open Studio name 1      |
          | Description                  | Test Open Studio description |
          | Group mode                   | Visible groups               |
          | Grouping                     | grouping1                    |
          | Enable pinboard              | 99                           |
          | Enable Folders               | 1                            |
          | Abuse reports are emailed to | teacher1@asd.com             |
          | ID number                    | OS1                          |
        And I follow "Test Open Studio name 1"
        And I click on "li.administration" "css_element"
        And I follow "Manage levels"
        And I press "Add another Block"
        And I set the field "Block Name" to "Block 1"
        And I press "Save Changes"
        And I follow "Block 1"
        And I press "Add another Activity"
        And I set the field "Activity Name" to "Activity 1"
        And I press "Save Changes"
        And I follow "Activity 1"
        And I press "Add another Content"
        And I set the field "Content Name" to "Content 1"
        And I press "Add another Content"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I click on "li.my-content" "css_element"
        Then I should see "My Pinboard"
        And I should see "My Activities"

    Scenario: Behavior handling for My Content without My Activities:
        When I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on
        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                         | Test Open Studio name 1      |
          | Description                  | Test Open Studio description |
          | Group mode                   | Visible groups               |
          | Grouping                     | grouping1                    |
          | Enable pinboard              | 99                           |
          | Enable Folders               | 1                            |
          | Abuse reports are emailed to | teacher1@asd.com             |
          | ID number                    | OS1                          |
        And I follow "Test Open Studio name 1"
        And I follow "My Content"
        Then I should see "My Pinboard"