/**
 * 
 */
console.log("ResultReport Module!");

var resultreportService = (function() {

	function getList(param, callback, error) {
		var year = param.year;
		var semester = param.semester;
		var subjectName = param.subjectname;
		var division = param.division;
		
		$.getJSON("/result_report/list/" + year + "/" + semester + "/" + subjectName + "/" + division + ".json",
			function(data) {
				if (callback) {
					callback(data); //댓글 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr, status, err) {
				if (error) {	
					error();
				}
		});
	}
	
	function update(approvalStatus, callback, error) {
		console.log("approvalStatus teamno: " + approvalStatus.teamno + ", approval : " + approvalStatus.approval);
		
		$.ajax({
			type : 'put',
			url : '/result_report/' + approvalStatus.teamno + "/" + approvalStatus.approval, 
			data : JSON.stringify(approvalStatus),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	

	return {
		getList : getList,
		update : update
	};
	
})();