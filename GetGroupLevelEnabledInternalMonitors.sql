/*

Description       : Get enabled internal monitors for each group in LabTech.
Source URL        : http://github.com/jesseconnr/labtech-sql-library

Tested Versions   :
  MySQL 5.7
  LabTech 10.0

Table Aliases     :
  Groups                - mastergroups
  InternalMonitors      - groupdagents
  MonitorDetails        - agents
  GroupCategories       - infocategory
  AlertTemplates        - alerttemplate

*/

SELECT
    CONCAT_WS(' - ', Groups.GroupID, Groups.Name) AS `GroupName`
  , Groups.FullName                               AS `GroupPath`
  , MonitorDetails.Name                           AS `Monitor`
  , AlertTemplates.Name                           AS `AlertTemplate`
  , GroupCategories.CategoryName                  AS `CategoryName`
FROM groupdagents AS `InternalMonitors`
  LEFT JOIN agents AS `MonitorDetails` ON InternalMonitors.AgentID = MonitorDetails.AgentID
  LEFT JOIN mastergroups AS `Groups` ON InternalMonitors.GroupID = Groups.GroupID
  LEFT JOIN alerttemplate AS `AlertTemplates` ON InternalMonitors.AlertAction = AlertTemplates.AlertActionID
  LEFT JOIN infocategory AS `GroupCategories` ON InternalMonitors.TicketCategory = GroupCategories.ID
WHERE (MonitorDetails.Flags & 0x01) = 0
#AND Groups.GroupID = 1580 # Group Id
#AND MonitorDetails.Name = 'AV - Disabled' # Internal Monitor Name
#AND AlertTemplates.Name = 'Default - Create LT Ticket' # Alert Template Name
#AND GroupCategories.CategoryName = 'Anti-Virus' # Ticket Category Name
ORDER BY Groups.FullName ASC;
