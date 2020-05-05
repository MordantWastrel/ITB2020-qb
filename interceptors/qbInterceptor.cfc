component extends="coldbox.system.Interceptor"{

    // DI

	/**
	* Configure
	*/
	function configure(){
        SUPER.configure();
    }

    function preQBExecute( event, interceptData, buffer, rc, prc ) {
        
    }

    function postQBExecute( event, interceptData, buffer, rc, prc ) {
        // interceptData has SQL, BINDINGS, and OPTIONS
        event.paramPrivateValue( name = 'qbQueries', value = [] );

        prc.qbQueries.append( {
            sql = interceptData.sql,
            bindings = interceptData.bindings,
            options = interceptData.options,
            result = interceptData.result,
            query = interceptData.query
        } );
    }
}