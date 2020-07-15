console.log("communityWriteCheck");
console.log("title length : " + document.getElementById("title").value.length);
console.log("content length : " + document.getElementById("contents").value.length);

function communityWriteCheck() {
	//	community
	if (document.getElementById("title").value.length == 0) {
		console.log("title length : " + document.getElementById("title").value.length);
		alert('제목을 입력해주세요.');
		return false;
	}
	
	if (document.getElementById("contents").value.length == 0) {
		console.log("contents length : " + document.getElementById("contents").value.length);
		alert('내용을 입력해주세요.');
		return false;
	}
	
	return true;
}