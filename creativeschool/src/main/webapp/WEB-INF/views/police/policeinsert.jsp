<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.report-container {
	background: white;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 90%;
	margin: 0 auto;
}
input[readonly] {
    background-color: lightgray;
}
.info {
	border: 1px solid #ccc;
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 4px;
}
.alert {
    display: none;
    position: fixed;
    right: 20px;
    bottom: 20px;
    z-index: 1000;
    opacity: 0; 
    transition: opacity 0.5s ease;
    background-color: #f8d7da; 
    color: #721c24;
    border: 1px solid #f5c6cb; 
    padding: 15px;
    border-radius: 5px;
}
.alert.show {
    display: block; 
    opacity: 1; 
}
</style>

<div class="report-container">
	<form method="post" action="${path}/police/policeInsertDo.km" enctype="multipart/form-data" id="policeForm">
        <div class="d-flex flex-column justify-content-between">
	        <div class="d-flex justify-content-around">
	        	<div class="d-flex align-items-center">
				    <h3>경찰관 등록</h3>	
			    </div>
		        <div>
	                <label for="policePhoto" style="cursor: pointer;">
	                    <img id="photoPreview" src="${path }/resources/images/basicprofile.png" alt="사진 미리보기" style="border-radius: 50%; width: 100px; height: 100px; border: 2px solid #ccc;">
	                    <input type="file" id="policePhoto" name="policePhoto" accept="image/*" style="display: none;" onchange="previewPhoto(event)">
	                </label>
	                <p>경찰관 사진 등록</p>
	            </div>
	        </div>
	        <div class="d-flex justify-content-between">
        	<div>
	           <div class="input-group mb-3">
	            	<div class="input-group-prepend">
	               		<span class="input-group-text">아이디</span>
	                </div>
	                <input class="form-control" type="text" name="policeIdentity" required>
	            </div>
	            <div class="input-group mb-3">
	            	<div class="input-group-prepend"> 
	                	<span class="input-group-text">비밀번호</span>
	                </div>
	                <input class="form-control" type="text" name="policePassword" required> 
	            </div>
	            <div class="input-group mb-3">
	                <div class="input-group-prepend"> 
	                	<span class="input-group-text">이 름</span>
	                </div>
	                <input class="form-control" type="text" name="policeName" required>
	            </div>
	            <div class="input-group mb-3">
	                <div class="input-group-prepend"> 
	                	<span class="input-group-text">이메일</span>
	                </div>
	                <input class="form-control" type="text" name="policeEmail" required>
				</div>
				<div class="input-group mb-3">                
	                <div class="input-group-prepend"> 
	                	<span class="input-group-text">전화번호</span>
	                </div>
	                <input class="form-control" type="text" name="policePhone" required>
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend"> 
	                	<span class="input-group-text">직위</span>
	                </div>                
	                <select class="custom-select" name="policeGrade" required>
	                	<option selected disabled>선택하세요</option>
	                	<option value="경정">경정</option>
	                	<option value="경감">경감</option>
	                	<option value="경위">경위</option>
	                	<option value="경사">경사</option>
	                	<option value="경장">경장</option>
	                	<option value="순경">순경</option>
	                </select>
				</div>  
			</div>
			<div>
	            <div class="input-group mb-3">
	                <div class="input-group-prepend"> 
	                	<span class="input-group-text">관할서검색</span>
	                </div>
	                <input class="form-control" type="text" name="policeJurisdiction"
	                    required oninput="searchPoliceStationByName(this.value);"
	                    placeholder="관서명 혹은 경찰서명">
	            </div>
	            <div class="input-group mb-3">
		             <div class="input-group-prepend"> 
	                	<span class="input-group-text">관할서 이름</span>
	                </div>
					<input class="form-control" type="text" name="policeStationName" readonly/><br></label>
                </div>
                <div class="input-group mb-3">
                 	<div class="input-group-prepend"> 
	                	<span class="input-group-text">관할서 구분</span>
	                </div>
	                <input class="form-control" type="text" name="policeStationDiv" readonly/>
	            </div>
	            <div class="input-group mb-3">
	            	<div class="input-group-prepend"> 
	                	<span class="input-group-text">관할서 시도청</span>
	                </div>
	                <input class="form-control" type="text" name="policeStationSidoStation" readonly/>
	            </div>
	            <div class="input-group mb-3">
	            	<div class="input-group-prepend"> 
	                	<span class="input-group-text">관할서 주소</span>
	                </div>
	                <input type="text" class="form-control" name="policeStationAddress" readonly/>
	            </div>
            </div>
            <div style="min-width:35%;">
            	<div id="result" style="overflow:auto;max-height:300px">
            		<h4>관할서검색결과</h4>
            	</div>
            </div>
        </div>
        </div>
        <input type="submit" class="btn btn-outline-success" value="등록">
        <input type="reset" class="btn btn-outline-danger" value="취소">
    </form>
    
    <div id="alertMessage" class="alert">
        사진을 선택해야 제출할 수 있습니다.
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="${path }/resources/js/common.js"></script>

<script>
	
	let policeStationsData = [];
	
	async function loadPoliceStationsData() {
	    try {
	        policeStationsData = await searchPoliceStation();
	    }
	    catch (error) {
	        console.error(error);
	    }
	}

	let intFunc="";
	function searchPoliceStationByName(name) {
	    const resultDiv = document.getElementById('result');
		if(intFunc!=""){
			clearTimeout(intFunc);
			//intFunc="";
		}
		if(name.length>=2){
			resultDiv.innerHTML = '';
			//로딩화면
			const $containerDiv=document.createElement("div");
			$containerDiv.classList.add("d-flex");
			$containerDiv.classList.add("justify-content-center");
			$containerDiv.classList.add("align-items-center");
			$containerDiv.style.minHeight='300px';
			const $spinnerDiv=document.createElement("div");
			$spinnerDiv.classList.add("spinner-border");
			$spinnerDiv.classList.add("text-primary");
			$spinnerDiv.setAttribute("role","status");
			const $spinnerSpan=document.createElement("span");
			$spinnerSpan.classList.add("sr-only")
			$spinnerSpan.innerText="loading....";
			$spinnerDiv.appendChild($spinnerSpan);
			$containerDiv.append($spinnerDiv);
			resultDiv.appendChild($containerDiv);
		}else{
			resultDiv.innerHTML="<h4>두 글자이상 검색어를 입력하세요</h4>";
		}
		if(name.length>=2){
			intFunc=setTimeout(()=>{
				resultDiv.innerHTML = '';
				    const result = policeStationsData.filter(item => item['관서명'].includes(name)||item['경찰서'].includes(name));
				    if (result.length > 0){
				        result.forEach(item => {
				            const div = document.createElement('div');
				            div.classList.add('info');
				            const title=["경찰서","관서명","구분","시도청","연번","주소"];            
				            title.forEach(name=>{
				            	const $div=document.createElement("div");
				            	const $strong=document.createElement("strong");
				            	$strong.innerText=name;
				            	const $span=document.createElement("span");
				            	$span.style.paddingLeft='2%';
				            	$span.innerText=item[name];
				            	$div.appendChild($strong);
				            	$div.appendChild($span);
					            div.appendChild($div);
				            });
				            
							div.onclick = function() {
							    const allDivs = document.querySelectorAll('.info');
							    allDivs.forEach(d => d.style.borderColor = '#ccc');
							
							    div.style.borderColor = 'blue';
							
							    document.querySelector('input[name="policeStationName"]').value = item['경찰서'] + '경찰서';
							    document.querySelector('input[name="policeStationDiv"]').value = item['구분'];
							    document.querySelector('input[name="policeStationSidoStation"]').value = item['시도청'];
							    document.querySelector('input[name="policeStationAddress"]').value = item['주소'];
							    
							    //더미
							    /*
							    document.querySelector('input[name="policeIdentity"]').value = '테스트아이디';
							    document.querySelector('input[name="policePassword"]').value = 'testpassword';
							    document.querySelector('input[name="policeName"]').value = '김춘식';
							    document.querySelector('input[name="policeEmail"]').value = '테스트이메일';
							    document.querySelector('input[name="policePhone"]').value = '1234';
							    document.querySelector('input[name="policeGrade"]').value = '학생';
								*/
							};
							
				            resultDiv.appendChild(div);
				        });
				    } else {
				        resultDiv.innerHTML = '<h4>해당 경찰서를 찾을 수 없습니다.</h4>';
				    }
			},1000);
	    }
		
	
	}


	loadPoliceStationsData();
	
    function previewPhoto(event) {
        const photoPreview = document.getElementById('photoPreview');
        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = function(e) {
            photoPreview.src = e.target.result;
        };

        if (file) {
            reader.readAsDataURL(file);
        }
    }
    document.getElementById('policeForm').addEventListener('submit', function(event) {
        const fileInput = document.getElementById('policePhoto');
        if (!fileInput.files.length) {
            event.preventDefault(); 
            showAlert(); 
        }
    });
    function showAlert() {
        const alertMessage = document.getElementById('alertMessage');
        
        alertMessage.classList.remove('show'); 
        alertMessage.style.display = 'block'; 
        alertMessage.style.opacity = '1'; 

        setTimeout(() => {
            alertMessage.classList.add('fade-in');
        }, 10); 

        setTimeout(() => {
            alertMessage.classList.remove('fade-in'); 
            alertMessage.style.opacity = '0'; 
        }, 5000); 
        
        setTimeout(() => {
            alertMessage.style.display = 'none';
        }, 5500);
    }

    

</script>
