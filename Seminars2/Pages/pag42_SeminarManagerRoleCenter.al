page 50142 "CSD Seminar Manager RoleCenter"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Seminar Manager RoleCenter';

    layout
    {
        area(RoleCenter)
        {
            group(Column1)
            {
                part(Activities; "CSD Seminar Manager Activities")
                {

                }
                part(MySeminars; " CSD My Seminars")
                {

                }

            }
            group(Column2)
            {
                part(MyCustomers; "My Customers")
                {

                }
                systempart(MyNotifications; MyNotes)
                {

                }
                part(ReportInbox; "Report Inbox Part")
                {

                }
            }
        }
    }

    actions
    {


        area(Embedding)
        {
            action(SeminarRegistrations)
            {
                Caption = 'Seminar Registration';
                RunObject = page "CSD Posted Seminar Reg. List";
                Image = List;
                ToolTip = 'Create Seminar Registration';
            }
            action("Seminars")
            {
                Caption = 'Seminars';
                RunObject = page "CSD Seminar List";
                Image = List;
                ToolTip = 'View Seminars';
            }

            action("Instructors")
            {
                Caption = 'Instructors';
                RunObject = page "Resource List";
                RunPageView = where(Type = const(Person));
                Image = List;
                ToolTip = 'View all resources registered as persons';

            }
            action("Rooms")
            {
                Caption = 'Instructors';
                RunObject = page "Resource List";
                RunPageView = where(Type = const(Machine));
                Image = List;
                ToolTip = 'View all resources registered as machines';
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                RunObject = page "Sales Invoice List";
                Image = List;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Register your sales to customers';
            }
            action("Sales Credit Memo")
            {
                Caption = 'Sales Credit Memo';
                RunObject = page "Sales Credit Memos";
                Image = List;
                ToolTip = 'Revert the financial transactions involved when your customer want to cancel a purchase';
            }
            action("Cutomers")
            {
                Caption = 'Customers';
                RunObject = page "Customer List";
                Image = List;
                ToolTip = 'View or edit detailed information for the customers that you trade with';
            }
        }
        area(Sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory';
                action("Posted Seminar Registrations")
                {
                    Caption = 'Posted Seminar Registrations';
                    Image = Timesheet;
                    RunObject = page "CSD Posted Seminar Reg. List";
                    ToolTip = 'Open the list of posted Registrations.';
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Registers")
                {
                    Caption = 'Seminar Registers';
                    Image = PostedShipment;
                    RunObject = page "CSD Seminar Registers";
                    ToolTip = 'Open the list of Seminar Registers.';
                }


            }

        }
        area(Creation)
        {
            action(NewSeminarRegistration)
            {
                Caption = 'Seminar Registration';
                Image = NewTimesheet;
                RunObject = page "CSD Seminar Registration";
                RunPageMode = Create;
            }
            action(NewSalesInvoice)
            {
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = page "Sales Invoice";
                RunPageMode = Create;
            }
        }
        area(Processing)
        {
            action(CreateInvoices)
            {
                Caption = 'Create Invoices';
                Image = CreateJobSalesInvoice;
                RunObject = report "Create Seminar Invoices";
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Image = Navigate;
                RunObject = page Navigate;
                RunPageMode = Edit;
            }
        }
    }


}