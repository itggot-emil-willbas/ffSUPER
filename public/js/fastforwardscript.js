$(document).ready(function () {



    $("#course_select").on('change',function () {
            var val = $(this).val();
        $("#collection_select").empty();
        $.get("/collections/" + val , function(response){
            parsed = JSON.parse(response)
            var i = 0
            while (i < parsed.object_first_key.length) {
                $("#collection_select").append("<option value=" + parsed.object_first_key[i][0] + ">" + parsed.object_first_key[i][1] + "</option>" );
                i++;
            };
        });
    });


//Add green comment/div
    $('#addPosButton').click(function(){
		//leta fram rätt text
		var komtext = $('#kommentarsinput').val()+'. ';
		//lägg till den i <output>
		var knappen = $('<div class="divknapp bra"><button class="eraseThis" data-clicked="no"></button><p class="nytext">'+komtext+'</p></div>');
		$('#spaceforbuttons').append(knappen);
	});

//Add red comment/div
    $('#addKonstrButton').click(function(){
		//leta fram rätt text
		var komtext = $('#kommentarsinput').val()+'. ';
		//lägg till den i <output>
		var knappen = $('<div class="divknapp konstr"><button class="eraseThis" data-clicked="no"></button><p class="nytext">'+komtext+'</p></div>');
		$('#spaceforbuttons').append(knappen);
		
	});

//Remove comment/div
    $(document).on('click', '.eraseThis', function(event){ 
             $(this).closest('div').remove();
             $('#op:last-child').remove(); 
    });

//JSON test
$("#clicker").click(function(){
    $.post("/hello",
    {
        collection_name : "Feedback9",
        course_id : "1",
        comments : [["Ttänk på ditten och datten HTML","red","konstr"],["Btra design","green","pos"]] 
    },
    function(data,status){
        alert("Data: " + data + "\nStatus: " + status);
    });
});



});
