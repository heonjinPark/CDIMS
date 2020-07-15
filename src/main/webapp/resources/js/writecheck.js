console.log("cnt : "+ cnt);

function writeCheck() {
//	result_report
	if (document.frm.assignType.value.length == 0) {
		console.log("assignType length : " + document.frm.assignType.value.length);
		alert('과제유형을 입력해주세요.');
		return false;
	}
	
	if (document.frm.projectTitle.value.length == 0) {
		console.log("projectTitle length : " + document.frm.projectTitle.value.length);
		alert('과제명을 입력해주세요.');
		return false;
	}
	
	if (document.frm.teamName.value.length == 0) {
		console.log("teamName length : " + document.frm.teamName.value.length);
		alert('팀명을 입력해주세요.');
		return false;
	}
	
	
	if (document.frm.applyFee.value.length == 0) {
		console.log("applyFee length : " + document.frm.applyFee.value.length);
		alert('지원신청금액을 입력해주세요.');
		return false;
	}
	
	
	for (var i = 0; i <= cnt; i++) {
		console.log("department length : " + document.getElementById("department" + i).value.length);
		if (document.getElementById("department" + i).value.length == 0) {
			alert('소속학과를 입력해주세요.');
			return false;
		}
		
		console.log("studentId length : " + document.getElementById("studentId" + i).value.length);
		if (document.getElementById("studentId" + i).value.length == 0) {
			alert('학번을 입력해주세요.');
			return false;
		}
		
		console.log("grade length : " + document.getElementById("grade" + i).value.length);
		if (document.getElementById("grade" + i).value.length == 0) {
			alert('학년을 입력해주세요.');
			return false;
		}
		
		console.log("name length : " + document.getElementById("name" + i).value.length);
		if (document.getElementById("name" + i).value.length == 0) {
			alert('성명을 입력해주세요.');
			return false;
		}
		
		console.log("phoneNumber length : " + document.getElementById("phoneNumber" + i).value.length);
		if (document.getElementById("phoneNumber" + i).value.length == 0) {
			alert('전화번호를 입력해주세요.');
			return false;
		}
		
		console.log("email length : " + document.getElementById("email" + i).value.length);
		if (document.getElementById("email" + i).value.length == 0) {
			alert('이메일을 입력해주세요.');
			return false;
		}
	}
	
	return true;
}