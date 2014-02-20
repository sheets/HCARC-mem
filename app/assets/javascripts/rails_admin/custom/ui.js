jQuery(function(){
    $(document).ready(function(){
    	$(document).on("click",".is_admin,.is_member,.is_voting_member",function(){
    		if (confirm('Are you sure to grant permission to selected user?')) { 
				
	    		var thisVar = $(this);
	    		var checkboxType = thisVar.attr("class").split("_");
	    		var addRole=(thisVar.is(':checked'))? true : false;
	    		var userId=thisVar.attr("id");
	    		$.ajax({
	    			method:"get",
	    			url:"/registrations/add_remove_role",	
	    			data:"userid="+userId+"&member_type="+checkboxType[1]+"&add_role="+addRole,
	    			error:function(error){

	    			},
	    			success:function(success){
	    				if(success.success=="true")
	    					alert("Role upgraded Successfully");
	    			}
	    		});
    		}
    		
    	});
    })
 })
