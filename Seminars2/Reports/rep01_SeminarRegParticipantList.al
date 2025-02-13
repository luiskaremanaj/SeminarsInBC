report 50101 "SeminarRegParticipantList"
{
    Caption = 'Seminar Reg.-Participant List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SeminarRegParticipantList.rdl';

    // labels
    // {
    //     SeminarRegistrationHeaderCap = 'Seminar Registration List';

    // }

    dataset
    {

        dataitem("CSD Seminar Reg. Header"; "CSD Seminar Reg. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Seminar_No_; "Seminar No.")
            {
                IncludeCaption = true;
            }
            column(Seminar_Name; "Seminar Name")
            {
                IncludeCaption = true;
            }
            column(Starting_Date; "Starting Date")
            {
                IncludeCaption = true;
            }
            column(Duration; Duration)
            {
                IncludeCaption = true;
            }
            column(Instructor_Name; "Instructor Name")
            {
                IncludeCaption = true;
            }
            column(Room_Name; "Room Name")
            {
                IncludeCaption = true;
            }
            dataitem("CSD Seminar Registration Line"; "CSD Seminar Registration Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");
                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Name; "Participant Name")
                {
                    IncludeCaption = true;
                }
            }
        }

        dataitem("Company Information"; "Company Information")
        {
            column(Company_Name; Name)
            {
                IncludeCaption = true;
            }
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        // layout
        // {
        //     area(Content)
        //     {
        //         group(GroupName)
        //         {
        //             field(Name; SourceExpression)
        //             {

        //             }
        //         }
        //     }
        // }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    labels
    {
        SeminarRegistrationHeaderCap = 'Seminar Registration List';

    }
}