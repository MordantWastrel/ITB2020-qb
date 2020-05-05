component extends="coldbox.system.EventHandler"{

	// Default Action
	function index(event,rc,prc){
		event.paramPrivateValue( name = 'qbQueries', value = [] );

		var myEntityUIDs = getEntityUIDs();

		var criteria = {
			description : 'Third Work Order',
			entityUIDs : myEntityUIDs
		};
		
		var qb = wirebox.getInstance( "QueryBuilder@qb" )
			.select( "wo.description" )
			.selectRaw( "COALESCE( table1.CUSTFIELDVALUE, table2.CUSTFIELDVALUE) as cleaningTool " )
			.from( "WORKORDER AS wo" )
			.leftJoin( "table1", "wo.WORKORDERID", "=", "table1.FK_workOrder")
			.leftJoin( "table2", "wo.WORKORDERID", "=", "table2.FK_workOrder" )
			.when(
				criteria.keyExists( "description" ), ( q ) => {
					q.where( "description", "=", criteria.description );
				}
			)
			.when(
				criteria.keyExists( "entityUIDs" ), ( q ) => {
					q.whereIn( "woe.ENTITYUID", criteria.entityUIDs )
					.leftJoin( "WORKORDERENTITY as woe", "wo.WORKORDERID", "=", "woe.WORKORDERID" );
				}
			 )
			.orderByDesc( [ "wo.INITIATEDDATE", "wo.DATEWOCLOSED" ] );
			 prc.sql = qb.toSQL();
			 prc.result = qb.get();
	}

	private array function getEntityUIDs() {
		return wirebox.getInstance( "QueryBuilder@qb" )
			.select( "entityUID" )
			.distinct()
			.from( "workorderentity" )
			.get()
			.map( ( uidRow ) => {
				return uidRow.entityUID;
			} );
	}


	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){
		handleMigrations();
	}

	private void function handleMigrations() {
		var MigrationService = new cfmigrations.models.MigrationService({
			wirebox = application.wirebox,
			datasource = 'azteca',
			migrationsDirectory = '/resources/database/migrations',
			defaultGrammar = 'SqlServerGrammar@qb',
			schema = 'dbo'
		} );
		MigrationService.RunAllMigrations("up");
	}


	function onRequestStart(event,rc,prc){

	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc){
		event.setHTTPHeader( statusCode = 500 );
		//Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		//Place exception handler below:
	}

}