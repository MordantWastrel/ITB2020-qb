<style>
	/* PURE css solution for rotating carets based on expanded section (https://conversionlogix.com/adops-tools/bootstrap-rotating-carets-pure-css-solution/) */
	.expand_caret {
		transform: scale(1.6);
		margin-left: 8px;
		margin-top: -4px;
	}
	a[aria-expanded='false'] > .expand_caret {
		transform: scale(1.6) rotate(-90deg);
	}

	/* grab this from bootstrap 3 just so our carets work */
	.caret {
    display: inline-block;
    width: 0;
    height: 0;
    margin-left: 2px;
    vertical-align: middle;
    border-top: 4px dashed;
    border-top: 4px solid\9;
    border-right: 4px solid transparent;
    border-left: 4px solid transparent;
}
</style>
<div class="container">
	<div class="row">
	  <div class="col-lg-12 text-center">
		<h1 class="mt-5">QB Demo</h1>
	  </div>
	  <div class="col-lg-12">
		<cfif !prc.qbQueries.len()>
			<h4>We didn't run any queries!</h4>
		<cfelse>
			<cfoutput>
				<h4>Main query SQL:</h4>
				<cfdump var="#prc.sql#">
				<cfif event.privateValueExists( "result")>
					<h4>Main query result:</h4>
					<cfdump var="#prc.result#">	
				</cfif>
				<h4>#prc.qbQueries.len()# quer#(prc.qbQueries.len() == 1 ? 'y' : 'ies')# executed:</h4>
				<ul>
					<cfloop from=1 to="#prc.qbQueries.len()#" index="i">
						<li>
							<a data-toggle="collapse" data-target="##collapseQuery#i#" href="##collapseQuery#i#" aria-expanded="false">
								#prc.qbQueries[ i ].sql.left( 100 )#...
								  <!-- A caret will automatically appear within this link -->
							</a>
							<div id="collapseQuery#i#" class="collapse">
								<ul>
									<!--- uncomment if we want the query object 
										<li>Query: <cfdump var="#prc.qbQueries[ i ].query#"></li>
									--->
									<li>SQL: #prc.qbQueries[ i ].sql#</li>
									<li>Execution Time: #prc.qbQueries[ i ].result.executionTime#ms</li>
									<li>Record Count: #prc.qbQueries[ i ].query.recordCount#</li>
									<cfif prc.qbQueries[ i ].bindings.len()>
										<li>
											Bindings (#prc.qbQueries[ i ].bindings.len()#)
											<ul id="Query#i#Binding">
												<cfloop from=1 to="#prc.qbQueries[ i ].bindings.len()#" index="b">
													<li>###b#) <b>Value:</b> #prc.qbQueries[ i ].bindings[ b ]?.value ?: ''# - <b>SQLTYPE:</b> #prc.qbQueries[ i ].bindings[ b ].cfsqltype#
														<cfif prc.qbQueries[ i ].bindings[ b ].null>
															(NULL)
														</cfif>
														<cfif prc.qbQueries[ i ].bindings[ b ].list>
															(LIST)
														</cfif>
													</li>
												</cfloop>
											</ul>
										</li>
									</cfif>
									
								</ul>
							</div>
						</li>
					</cfloop>
				</ul>
			</cfoutput>
		</cfif>
	  </div>
	</div>
  </div>

  <script>
function setupCollapseCarets(){
  var allCollapseLinks = document.querySelectorAll("a[data-toggle='collapse']");
  allCollapseLinks.forEach(function(item){
    var caretElem = document.createElement("span");
    caretElem.classList.add("expand_caret","caret");
    var currCollapseLink = item;
    currCollapseLink.appendChild(caretElem);
  });
}
setupCollapseCarets();
  </script>
