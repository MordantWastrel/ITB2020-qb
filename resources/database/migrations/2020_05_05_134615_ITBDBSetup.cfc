component {

    function up( schema, query ) {
      
        schema.create( "workorder", ( table ) => {
            table.increments( "workorderid" );
            table.string( "description" );
            table.dateTime( "initiatedDate" );
            table.dateTime( "dateWOClosed" ).nullable();
        } );

        schema.create( "workorderentity", ( table ) => {
            table.increments( "id" );
            table.integer( "workorderID" );
            table.uuid( "entityUID" );
        } );

        schema.create( "table1", ( table ) => {
            table.increments( "id" );
            table.integer( "FK_workorder" )
                .references( "workorderid" )
                .onTable( "workorder" );
            table.string( "CUSTFIELDVALUE" )
                .nullable();
        } );

        schema.create( "table2", ( table ) => {
            table.increments( "id" );
            table.integer( "FK_workorder" )
                .references( "workorderid" )
                .onTable( "workorder" );
            table.string( "CUSTFIELDVALUE" )
                .default( "A Default Custom Field Value" );
        } );

        // now populate the data
        query.from( "workorder" )
            .insert( [
                { 
                    description = 'First Work Order',
                    initiatedDate = createDateTime( 2020, 05, 01, 12, 0, 0 ),
                    dateWOClosed = createDateTime( 2020, 05, 05, 13, 30, 0 )
                },
                {
                    description = 'Second Work Order',
                    initiatedDate = createDateTime( 2020, 05, 03, 08, 15, 0 ),
                    dateWOClosed = createDateTime( 2020, 05, 07, 14, 22, 0 )
                },
                {
                    description = 'Third Work Order',
                    initiatedDate = createDateTime( 2020, 05, 04, 09, 02, 0)
                }
            ] );
        
        var someGUID = createGUID();
        query.newQuery()
            .from( "workorderentity" )
            .insert([
                {
                    workorderID = 1,
                    entityUID = someGUID
                },
                {
                    workOrderID = 2,
                    entityUID = someGUID
                },
                {
                    workOrderID = 3,
                    entityUID = createGUID()
                }
            ] );

        query.newQuery()
            .from( "table1" )
            .insert( [
                FK_Workorder = 1,
                CUSTFIELDVALUE = 'A Custom Field Value from Table1'
            ] );
        
        query.newQuery()
            .from( "table2" )
            .insert( [
                FK_WorkOrder = 3,
                CUSTFIELDVALUE = 'A Custom Field Value from Table2'
            ])
    }

    function down( schema, query ) {
        schema.drop( "table2" )
        schema.drop( "table1" );
        schema.drop( "workorderentity" )
        schema.drop( "workorder" )
    }

}
