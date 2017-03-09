@ou @ou_vle @mod @mod_openstudio @mod_openstudio_test_people @_file_upload @javascript
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
            | student5 | Student | 5 | student5@asd.com |
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
            | student5 | C1 | student |
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

    Scenario: Only show People link if module or group sharing is enabled
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
        And all users have accepted the plagarism statement for "OS1" openstudio
        And all users have accepted the plagarism statement for "OS2" openstudio
        And I follow "Test Open Studio name 1"
        Then I should not see "People"
        And I am on site homepage
        And I follow "Course 1"
        And I follow "Test Open Studio name 2"
        Then I should see "People"

    Scenario: GIVEN My Module selected, THEN show all OS Members
        When I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on
        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                          | Test Open Studio name 1        |
          | Description                   | Test Open Studio description 1 |
          | Your word for 'My Module'     | My Module                      |
          | Your word for 'My Group'      | My Group                       |
          | Your word for 'My Activities' | My Activities                  |
          | Your word for 'My Pinboard'   | My Pinboard                    |
          | Group mode                    | Visible groups                 |
          | Grouping                      | grouping1                      |
          | Enable pinboard               | 99                             |
          | Enable Folders                | 1                              |
          | Abuse reports are emailed to  | teacher1@asd.com               |
          | ID number                     | OS1                            |
        And all users have accepted the plagarism statement for "OS1" openstudio
        And I follow "Test Open Studio name 1"
        And I click on "div.openstudio-upload-container" "css_element"
        And I press "Add file"
        And I set the following fields to these values:
          | Who can view this content | My module                                  |
          | Title                     | Test My Pinboard View                      |
          | Description               | My Pinboard View Description               |
          | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
        And I press "Save"
        And I follow "People" in the openstudio navigation
        
        # switch student1 user
        And I am on site homepage
        And I log out
        And I log in as "student1"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I click on "div.openstudio-upload-container" "css_element"
        And I press "Add file"
        And I set the following fields to these values:
          | Who can view this content | Only me                                    |
          | Title                     | Test My Pinboard View Student 1            |
          | Description               | My Pinboard View Description 1             |
          | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
        And I press "Save"
        And I follow "People" in the openstudio navigation
        Then I should see "Teacher 1"

        # switch student2 user
        And I am on site homepage
        And I log out
        And I log in as "student2"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I click on "div.openstudio-upload-container" "css_element"
        And I press "Add file"
        And I set the following fields to these values:
          | Who can view this content | Only me                                    |
          | Title                     | Test My Pinboard View Student 2            |
          | Description               | My Pinboard View Description 2             |
          | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
        And I press "Save"
        And I follow "People" in the openstudio navigation
        Then I should see "Teacher 1"
        And I should see "Student 1"

        # switch student5 user
        And I am on site homepage
        And I log out
        And I log in as "student5"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I click on "div.openstudio-upload-container" "css_element"
        And I press "Add file"
        And I set the following fields to these values:
          | Who can view this content | Only me                                    |
          | Title                     | Test My Pinboard View Student 5            |
          | Description               | My Pinboard View Description 5             |
          | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
        And I press "Save"
        And I follow "People" in the openstudio navigation
        Then I should see "Teacher 1"
        And I should see "Student 1"
        And I should see "Student 2"

        # switch teacher1 user
        And I am on site homepage
        And I log out
        And I log in as "teacher1"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I follow "People" in the openstudio navigation
        Then I should see "Student 1"
        And I should see "Student 2"
        And I should see "Student 5"

    Scenario: Group mode selected
        When I am on site homepage
        And I follow "Course 1"
        And I turn editing mode on
        And I add a "Open Studio" to section "1" and I fill the form with:
          | Name                          | Test Open Studio name 1        |
          | Description                   | Test Open Studio description 1 |
          | Your word for 'My Module'     | My Module                      |
          | Your word for 'My Group'      | My Group                       |
          | Your word for 'My Activities' | My Activities                  |
          | Your word for 'My Pinboard'   | My Pinboard                    |
          | Group mode                    | Visible groups                 |
          | Grouping                      | grouping1                      |
          | Enable pinboard               | 99                             |
          | Enable Folders                | 1                              |
          | Abuse reports are emailed to  | teacher1@asd.com               |
          | ID number                     | OS1                            |
        And all users have accepted the plagarism statement for "OS1" openstudio
        And I log out
        And I log in as "student2"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I click on "div.openstudio-upload-container" "css_element"
        And I press "Add file"
        And I set the following fields to these values:
          | Who can view this content | My module                                  |
          | Title                     | Test My Pinboard View 1                    |
          | Description               | My Pinboard View Description 1             |
          | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
        And I press "Save"
        And I am on site homepage
        And I log out
        And I log in as "student3"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I follow "My content" in the openstudio navigation
        And I click on "div.openstudio-upload-container" "css_element"
        And I press "Add file"
        And I set the following fields to these values:
          | Who can view this content | My module                                  |
          | Title                     | Test My Pinboard View 1                    |
          | Description               | My Pinboard View Description 1             |
          | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
        And I press "Save"
        
        # GIVEN Group Name selected, THEN show all members of the selected group
        And I am on site homepage
        And I log out
        And I log in as "student5"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I follow "People" in the openstudio navigation
        And I click on "select#openstudio-people-groupid" "css_element"
        And I click on "option[name='group1']" "css_element"
        Then I should see "Student 2"

        And I click on "select#openstudio-people-groupid" "css_element"
        And I click on "option[name='group2']" "css_element"
        Then I should see "Student 2"
        And I should see "Student 3"

        And I click on "select#openstudio-people-groupid" "css_element"
        And I click on "option[name='group3']" "css_element"
        Then I should see "Student 3"

        # GIVEN All Group selected, THEN show all Group-enrolled Members
        And I click on "select#openstudio-people-groupid" "css_element"
        And I click on "option[name='All Group']" "css_element"
        Then I should see "Student 2"
        And I should see "Student 3"

        # switch student2 user
        And I am on site homepage
        And I log out
        And I log in as "student2"
        And I follow "Course 1"
        And I follow "Test Open Studio name 1"
        And I follow "People" in the openstudio navigation
        Then I should see "All Group"
        And I should see "Student 3"
        And I click on "select#openstudio-people-groupid" "css_element"
        And I click on "option[name='group1']" "css_element"
        And I should not see "Student 3"
        And I click on "select#openstudio-people-groupid" "css_element"
        And I click on "option[name='group2']" "css_element"
        And I should see "Student 3"
