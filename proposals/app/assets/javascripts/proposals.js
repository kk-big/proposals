//操作ログの登録
function set_action_name(action_name){
   $.ajax({
   	url: "/logins/set_action_name",
   　  type: "GET",
    dataType: "text",
    cache: false,
    async: false,
    timeout: 5000,
    data: { action_name: action_name }
    });
}
$(function(){
  $('input.btn, button, a').not('.reload_with_format_csv').not('#get_address_button').click(
    function(){ 
    　　var action_name = $(this).text();
       if($(this).get(0).nodeName == "INPUT"){
         action_name = $(this).val();
        }
       set_action_name(action_name)
    }
  )
});
