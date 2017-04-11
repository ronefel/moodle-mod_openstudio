@ou @ou_vle @mod @mod_openstudio @mod_openstudio_folder_overview @javascript
Feature: Folder Overview
  When using Open Studio with other users
  As a teacher
  I need to create a content and upload a file

  Background: Setup course and studio
      Given the following "users" exist:
          | username | firstname | lastname | email            |
          | teacher1 | Teacher   | 1        | teacher1@asd.com |
          | student1 | Student   | 1        | student1@asd.com |
          | student2 | Student   | 2        | student2@asd.com |
          | student3 | Student   | 3        | student3@asd.com |
          | student4 | Student   | 4        | student4@asd.com |
      And the following "courses" exist:
          | fullname | shortname | category |
          | Course 1 | C1        | 0        |
      And the following "course enrolments" exist:
          | user     | course | role           |
          | teacher1 | C1     | editingteacher |
          | student1 | C1     | student        |
          | student2 | C1     | student        |
          | student3 | C1     | student        |
      And the following "groups" exist:
          | name     | course | idnumber |
          | group1   | C1     | G1       |
      And the following "groupings" exist:
          | name      | course | idnumber |
          | grouping1 | C1     | GI1      |
      And the following "grouping groups" exist:
          | grouping | group |
          | GI1      | G1    |
      And the following "group members" exist:
          | user     | group  |
          | teacher1 | G1     |
          | student1 | G1     |
          | student2 | G1     |
          | student3 | G1     |
      And I log in as "teacher1"
      And I am on site homepage
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
      And all users have accepted the plagarism statement for "OS1" openstudio

  Scenario: Check Item Folder Overview
      Given the following open studio "folders" exist:
        | openstudio | user     | name                   | description                       | visibility | contenttype    |
        | OS1        | teacher1 | Test Folder Overview   | My Folder Overview Description 1  | module     | folder_content |
      And I follow "Test Open Studio name 1"
      And I follow "Shared Content > My Module" in the openstudio navigation
      And I follow "Test Folder Overview"
      And I should see "Folder Overview"

      # the left handside should be the post stream
      And I should see "Test Folder Overview"
      And I should see "Edit folder title and permissions"

      And I should see "Add new content"
      And I should see "Upload content to folder"
      And I should see "Select existing post to add to folder"

      # the items in the right handside
      And I should see "Owner of this folder"
      And I press "Owner of this folder"
      And I should see "Teacher 1"
      And I should see "Folder description"
      And I press "Folder description"
      And I should see "My Folder Overview Description 1"
      And I press "Folder Comments"
      And I should see "Folder Comments"
      And "Add new comment" "button" should exist

      And "Delete folder" "button" should exist
      And "Lock folder" "button" should exist
      And "Request feedback" "button" should exist

      And I should see "0 Favourites"
      And I should see "0 Smiles"
      And I should see "0 Inspired"
      And I should see "0 views"

  Scenario: Upload content in Folder Overview
      Given the following open studio "folders" exist:
        | openstudio | user     | name                   | description                       | visibility | contenttype    |
        | OS1        | teacher1 | Test Folder Overview   | My Folder Overview Description 1  | module     | folder_content |
      And I follow "Test Open Studio name 1"
      And I follow "Shared Content > My Module" in the openstudio navigation
      And the "src" attribute of "img.openstudio-default-folder-img" "css_element" should contain "uploads_rgb_32px"
      And I follow "Test Folder Overview"
      And I follow "Add new content"
      And I press "Add file"
      And I set the following fields to these values:
        | Title                     | Test My Folder Overview                    |
        | Description               | My Folder Overview Description             |
        | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
      And I press "Save"

      # Redirect to content detail
      And I should see "Test My Folder Overview"
      And the "src" attribute of "img.openstudio-content-view-img" "css_element" should contain "test1.jpg"
      And I follow "Shared Content > My Module" in the openstudio navigation
      And the "src" attribute of "img.openstudio-content-folder-img" "css_element" should contain "test1.jpg"

      # Content Upload should exist in Folder Overview
      And I follow "Test Folder Overview"
      And I should see "Test My Folder Overview"
      And the "src" attribute of "div.openstudio-grid-item-folder-preview > a > img" "css_element" should contain "test1.jpg"
  
  Scenario: Folder Overview in My Activities views
      Given the following open studio "level1s" exist:
          | openstudio  | name         | sortorder |
          | OS1         | Block1       | 1         |
      And the following open studio "level2s" exist:
          | level1      | name         | sortorder |
          | Block1      | Activity1    | 1         |
      And the following open studio "level3s" exist:
          | level2      | name         | sortorder | contenttype    |
          | Activity1   | Content1.1   | 1         | folder         |
      And I follow "Test Open Studio name 1"
      And I follow "My Content > My Activities" in the openstudio navigation
      And I should see "Content1.1"
      And the "src" attribute of "img.openstudio-default-folder-img" "css_element" should contain "uploads_rgb_32px"
      And I follow "Content1.1"
      # Redirect to create folder page
      And I set the following fields to these values:
          | Who can view this folder  | My module                                  |
          | Folder title              | Test my folder view 1                      |
          | Folder description        | My folder view description 1               |
      And I press "Create folder"

      # Redirect to folder overview page
      And I follow "Add new content"
      And I press "Add file"
      And I set the following fields to these values:
        | Title                     | Test My Folder Overview                    |
        | Description               | My Folder Overview Description             |
        | Upload content            | mod/openstudio/tests/importfiles/test1.jpg |
      And I press "Save"

      # Redirect to content detail
      And I should see "Test My Folder Overview"
      And the "src" attribute of "img.openstudio-content-view-img" "css_element" should contain "test1.jpg"
      And I follow "Shared Content > My Module" in the openstudio navigation
      And the "src" attribute of "img.openstudio-content-folder-img" "css_element" should contain "test1.jpg"

      And I follow "My Content > My Activities" in the openstudio navigation
      And the "src" attribute of "img.openstudio-content-folder-img" "css_element" should contain "test1.jpg"
      And I should see "Content1.1"

      # Content Upload should exist in Folder Overview
      And I click on "img.openstudio-content-folder-img" "css_element"
      And I should see "Test My Folder Overview"
      And the "src" attribute of "div.openstudio-grid-item-folder-preview > a > img" "css_element" should contain "test1.jpg"
