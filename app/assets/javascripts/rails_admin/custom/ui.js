jQuery(function(){
    $(document).ready(function(){
    	$(document).on("click",".is_admin,.is_member,.is_voting_member",function(){
    		var thisVar = $(this);
	    	var checkboxType = thisVar.attr("class").split("_");
	    	var addRole=(thisVar.is(':checked'))? true : false;
	    	var userId=thisVar.attr("id");
	    	var textGrant=(addRole)? "grant" : "ungrant";
    		if (confirm('Are you sure to '+textGrant+' permission to selected user?')) { 
	    		$.ajax({
	    			method:"get",
	    			url:"/registrations/add_remove_role",	
	    			data:"userid="+userId+"&member_type="+checkboxType[1]+"&add_role="+addRole,
	    			error:function(error){
	    				alert(error);
	    			},
	    			success:function(success){
	    				//alert(success.toSource());
	    				if(success.success==true)
	    					alert("Role upgraded Successfully");
	    			}
	    		});
    		}
    		else{
    			if(addRole){
    				thisVar.prop("checked","");
    			}
    			else{
    				thisVar.prop("checked","checked");
    			}
    		}
    		
    	});
    })
 })
