<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
  
<script type='text/javascript'>

	var commonCodeArr = new Array();

	$(document).ready(function() {
		// 저장 : 생태계 분류
		$("#upload_tab_btn_1").click(function() {
			if( $("#categoryAdd").val() == null || $("#categoryAdd").val() == "" ) {
				alert("추가될 생태계 분류 내용이 없습니다.");
				return; 
			}
			var masterId = "M000002";
			var parentId = "";
			var name = $("#categoryAdd").val()
			addCommonCode(masterId, parentId, name);
		});

		// 저장 : 생태계 분류 세부
		$("#upload_tab_btn_2").click(function() {
			if( $("#categoryDetailAdd").val() == null || $("#categoryDetailAdd").val() == "" ) {
				alert("추가될 생태계 세부 내용이 없습니다.");
				return; 
			}
			var masterId = "M000003";
			var parentId = $("#selector_category option:selected").val();
			var name = $("#categoryDetailAdd").val()
			addCommonCode(masterId, parentId, name);
		});


		// 저장 : 직종
		$("#upload_tab_btn_3").click(function() {
			if( $("#categoryDetailOccupationAdd").val() == null || $("#categoryDetailOccupationAdd").val() == "" ) {
				alert("추가될 직종 내용이 없습니다.");
				return; 
			}
			var masterId = "M000004";
			var parentId = $("#selector_category_detail_occupation option:selected").val();
			var name = $("#categoryDetailOccupationAdd").val()
			addCommonCode(masterId, parentId, name);
		});

		// 저장 : 전공
		$("#upload_tab_btn_4").click(function() {
			if( $("#majorAdd").val() == null || $("#majorAdd").val() == "" ) {
				alert("추가될 전공 내용이 없습니다.");
				return; 
			}
			var masterId = "M000006";
			var parentId = "";
			var name = $("#majorAdd").val()
			addCommonCode(masterId, parentId, name);
		});

		// 저장 : 자격증
		$("#upload_tab_btn_5").click(function() {
			if( $("#licenseAdd").val() == null || $("#licenseAdd").val() == "" ) {
				alert("추가될 자격증 내용이 없습니다.");
				return; 
			}
			var masterId = "M000013";
			var parentId = $("#selector_license option:selected").val();
			var name = $("#licenseAdd").val()
			addCommonCode(masterId, parentId, name);
		});
		
		
		// 데이터 Add Cell 추가.
		$("#add_cell_btn_1").click(function() {
			var listBody = $("#category_list_body"); 
            var str =    
                '<tr>'+
            	'    <td>'+'</td>'+
            	'    <td>'+
            	'        <input type="text" class="form-control" name="staff_name" id="categoryAdd">'+
            	'    </td>'+'<td>'+'</td>'+
            	'</tr>';
            	listBody.append(str);
			$("#add_cell_btn_1").attr("disabled", true);
		});

		// 데이터 Add Cell 추가.
		$("#add_cell_btn_2").click(function() {
			if ($("#selector_category option:selected").val() == "") {
				alert("생태계 분류를 반드시 선택해야 합니다.");
				return;
			}

			var listBody = $("#category_detail_list_body"); 
			var str =     
				'<tr>'+
	            '    <td>' + '코드' + '</td>'+
	            '    <td>' + '생태계명' + '</td>'+
	            '    <td>' + '코드' + '</td>'+
	            '    <td class="">'+
	            '        <input type="text" class="form-control" name="staff_name2" id="categoryDetailAdd">'+
	            '    </td>'+'<td>'+'</td>'+
	            '</tr>';
	            listBody.append(str);
			$("#add_cell_btn_2").attr("disabled", true);
		});


		// 데이터 Add Cell 추가.
		$("#add_cell_btn_3").click(function() {
			if ($("#selector_category_occupation option:selected").val() == "") {
				alert("생태계 분류를 반드시 선택해야 합니다.");
				return;
			}

			if ($("#selector_category_detail_occupation option:selected").val() == "") {
				alert("생태계 세부분류를 반드시 선택해야 합니다.");
				return;
			}
			
			var listBody = $("#occupation_list_body"); 
            var str =     
            '<tr>'+
            '    <td>'+'코드'+'</td>'+
            '    <td>'+'생태계명'+'</td>'+
            '    <td>'+'코드'+'</td>'+
            '    <td>'+'생태계 세부명'+'</td>'+
            '    <td>'+'코드'+'</td>'+
            '    <td class="">'+
            '        <input type="text" class="form-control" name="staff_name3" id="categoryDetailOccupationAdd">'+
            '    </td>'+'<td>'+'</td>'+
            '</tr>';
            listBody.append(str);
			$("#add_cell_btn_3").attr("disabled", true);
		});

		// 데이터 Add Cell 추가.
		$("#add_cell_btn_4").click(function() {
			var listBody = $("#major_body"); 
            var str = "<input type='text' class='form-control' id='majorAdd'>"
            listBody.append(str);
			$("#add_cell_btn_4").attr("disabled", true);
		});

		// 데이터 Add Cell 추가.
		$("#add_cell_btn_5").click(function() {
			if ($("#selector_license option:selected").val() == "") {
				alert("자격증 분류를 반드시 선택해야 합니다.");
				return;
			}

			var listBody = $("#license_body"); 
            var str =  
            '<tr>'+
            '    <td>'+'자격증 분류명'+'</td>'+
            '    <td>'+
            '        <input type="text" class="form-control" id="licenseAdd">'+
            '    </td>'+'<td>'+'</td>'+
            '</tr>';

            listBody.append(str);
			$("#add_cell_btn_5").attr("disabled", true);
		});


		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
		    var categoryId =  $(this).val();
		    var categoryName = $("#selector_category option:selected").text();
		    categoryChange(categoryId, categoryName);
		});

		// 직종 생태계 분류 Click
	 	$("#selector_category_occupation").change(function(){
		    var categoryId =  $(this).val();
		    var categoryName = $("#selector_category_occupation option:selected").text();
		    categoryOccupationChange(categoryId, categoryName);
		});

		// 직종 생태계 세부분류 Click
	 	$("#selector_category_detail_occupation").change(function(){
		    var categoryId =  $("#selector_category_occupation option:selected").val();
		    var categoryName = $("#selector_category_occupation option:selected").text();
		    var categoryDetailId =  $("#selector_category_detail_occupation option:selected").val();
		    var categoryDetailName = $("#selector_category_detail_occupation option:selected").text();
		    categoryDetailOccupationChange(categoryId, categoryName, categoryDetailId, categoryDetailName);
		});


		// 직종 생태계 세부분류 Click
	 	$("#selector_license").change(function(){
		    var categoryId =  $("#selector_license option:selected").val();
		    var categoryName = $("#selector_license option:selected").text();
		    licenseChange(categoryId, categoryName);
		});
	 	

	 	commonCodeInit();
		categoryListBodyinit();
		categoryDetailListBodyinit();
		occupationBodyinit();
		majorInit();
		//licenseInit();
	});

	function addCommonCode(master_id, parent_id, name) {
		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/code/registration",
			    data :{
			    	"master_id" : master_id,
			    	"parent_id" : parent_id,
			    	"name" : name
			    },
			    success : function(data) {
			        if (data.result > 0) {
			            alert("변경 되었습니다.");
			            location.reload();
			        } else {
			            alert(data.result);
			        }
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}		


	}


	function licenseChange(categoryId, categoryName){
		if (categoryId != ""){
			var index = 1;
			var str = "";
			var listBody = $("#license_body"); 
			listBody.empty();
			
			// 생테게 세부 분류 Select 생성	
			$.each(commonCodeArr, function(index, item) {
				if ( item.master_id == 'M000013' && item.parent_id == categoryId) {
					str += '<tr>';
					str += '	<td>' + categoryName + '</td>';
					str += '	<td>' + item.name + '</td>';
				 	str += '	<td>';
				 	if ( item.use_yn == "Y") {
			        	str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions5-" + index + "' id='license_use_yn_" + index + "_y' value='Y' checked='checked' onclick='licenseUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions5-" + index + "' id='license_use_yn_" + index + "_n' value='N' onclick='licenseUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
				 	else {
			        	str += '		<div class="form-check form-check-inline">';
			        	str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions5-" + index + "' id='license_use_yn_" + index + "_y' value='Y'onclick='licenseUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions5-" + index + "' id='license_use_yn_" + index + "_n' value='N' checked='checked' onclick='licenseUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
		        	str += '	</td>';
					str += '</tr>';

					index++;
				}
			});

			listBody.append(str);
		} else {
			licenseInit();
		}


	}

	function licenseUseYN(code, index) {
		var categoryId = $("input[name='inlineRadioOptions5-" + index + "']:checked").attr("id");
		var flag = $("input[name='inlineRadioOptions5-" + index + "']:checked").val();
		
		// 같은 버튼을 눌렀을 시 반응안토록 한다.
		var returnFlag = false;
		$.each(commonCodeArr, function(indexEach, item) {
			if ( item.master_id == 'M000013' && item.detail_id == code && item.use_yn == flag) {
				returnFlag = true;
				return;
			}
		});

		if ( returnFlag == true ){
			return;
		}

		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/code/update/useYN",
			    data :{
			    	"master_id" : "M000013",
			    	"detail_id" : code,
			    	"use_yn" : flag
			    },
			    success : function(data) {
			        if (data.result > 0) {
			            alert("변경 되었습니다.");

			    		$.each(commonCodeArr, function(indexEach, item) 
	    				{
	    					if ( item.master_id == 'M000013' && item.detail_id == code) 
	    					{
	    						item.use_yn = flag;
	    						return;
	    					}
	    				});
			        } else {
			            alert(data.result);
			        }
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}
		else {

			if (flag == "Y") {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_n" ).prop('checked', true);
			}
			else {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_y" ).prop('checked', true);
			}
		}	
	}


	function licenseInit() {
		var str = "";
		var selector = $("#selector_license"); 
		selector.empty();
		str += '	<option value="">자격증 분류 선택</option>';

		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000007'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>
		selector.append(str); 

		var listBody = $("#license_body"); 
		listBody.empty();
	}


	
	function majorInit() {
		var index = 1;
		var str = "";
		var listBody = $("#major_body"); 
		listBody.empty();

		$.each(commonCodeArr, function(indexForeach, item) {
			if ( item.master_id == 'M000006' ) {
				// 2개씩 전공과목이 들어간다.
				if ( (index%2) == 1  ) {
					str += '<tr>';
					str += '	<td>' + item.name + '</td>';
				 	str += '	<td>';
				 	if ( item.use_yn == "Y") {
			        	str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_y' value='Y' checked='checked' onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_n' value='N' onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
				 	else {
			        	str += '		<div class="form-check form-check-inline">';
			        	str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_y' value='Y'onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_n' value='N' checked='checked' onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
		        	str += '	</td>';

					index++;
				}
				else {
					str += '	<td>' + item.name + '</td>';
				 	str += '	<td>';
				 	if ( item.use_yn == "Y") {
			        	str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_y' value='Y' checked='checked' onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_n' value='N' onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
				 	else {
			        	str += '		<div class="form-check form-check-inline">';
			        	str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_y' value='Y'onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions4-" + index + "' id='occupation_use_yn_" + index + "_n' value='N' checked='checked' onclick='majorUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
		        	str += '	</td>';
					str += '</tr>';

					index++;
				}
			}
		});

		listBody.append(str); 
	}

	function categoryDetailOccupationChange(categoryId, categoryName, categoryDetailId, categoryDetailName) {
		if (categoryId != ""){
			var index = 0;
			var str = "";
			var listBody = $("#occupation_list_body"); 
			listBody.empty();

			str += '<tr>';
			str += '	<td>코드</td>';
			str += '	<td>생태계명</td>';
			str += '	<td>코드</td>';
			str += '	<td>생태계 세부명</td>';
			str += '	<td>코드</td>';
			str += '	<td>직종</td>';
			str += '	<td>사용여부</td>';
			str += '</tr>';
			$.each(commonCodeArr, function(index, item) {
				if ( item.master_id == 'M000004' && item.parent_id == categoryDetailId) {
					str += '<tr>';
					str += '	<td>' + categoryId + '</td>';
					str += '	<td>' + categoryName + '</td>';
					str += '	<td>' + categoryDetailId + '</td>';
					str += '	<td>' + categoryDetailName + '</td>';
					str += '	<td>' + item.detail_id + '</td>';
					str += '	<td>' + item.name + '</td>';
				 	str += '	<td>';
				 	if ( item.use_yn == "Y") {
			        	str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions3-" + index + "' id='occupation_use_yn_" + index + "_y' value='Y' checked='checked' onclick='categoryDetailOccupationUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions3-" + index + "' id='occupation_use_yn_" + index + "_n' value='N' onclick='categoryDetailOccupationUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
				 	else {
			        	str += '		<div class="form-check form-check-inline">';
			        	str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions3-" + index + "' id='occupation_use_yn_" + index + "_y' value='Y'onclick='categoryDetailOccupationUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions3-" + index + "' id='occupation_use_yn_" + index + "_n' value='N' checked='checked' onclick='categoryDetailOccupationUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
		        	str += '	</td>';
					str += '</tr>';

					index++;
				}
			});

			listBody.append(str); 
		} else {
			occupationBodyinit();
		}
	}

	function categoryOccupationChange(categoryId, categoryName){
		if (categoryId != ""){
			// 생테게 세부 분류 Select 생성	
			var isSelected = true;
			var categoryDetailId = "";
			
			var str = "";
			var selector = $("#selector_category_detail_occupation"); 
			selector.empty();
			str += '	<option value="">생태계 세부분류 전체</option>';
    		<c:forEach items="${commonCode}" var="code">
				<c:if test="${code.master_id == 'M000003'}">
					if (categoryId == "${fn:escapeXml(code.parent_id)}") {
						str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
					}
				</c:if>
			</c:forEach>
			selector.append(str); 
		} else {
			occupationBodyinit();
		}
	}
	

	function occupationBodyinit(){
		var str = "";
		var selector = $("#selector_category_detail_occupation"); 
		selector.empty();
		str += '	<option value="">생태계 분류를 선택하세요</option>';
		selector.append(str); 
		
		// 생태계 관리  Select 생성 
		str = "";
		var listBody = $("#occupation_list_body"); 
		listBody.empty();

		str += '<tr>';
		str += '	<td>코드</td>';
		str += '	<td>생태계명</td>';
		str += '	<td>코드</td>';
		str += '	<td>생태계 세부명</td>';
		str += '	<td>코드</td>';
		str += '	<td>직종</td>';
		str += '	<td>사용여부</td>';
		str += '</tr>';
		listBody.append(str); 
	}

	function commonCodeInit(){
		<c:forEach items="${commonCode}" var="code">
			commonCodeArr.push({
				master_id:"${fn:escapeXml(code.master_id)}",
				master_description:"${fn:escapeXml(code.master_description)}",
				parent_id:"${fn:escapeXml(code.parent_id)}",
				detail_id:"${fn:escapeXml(code.detail_id)}",
				name:"${fn:escapeXml(code.name)}",
				detail_description:"${fn:escapeXml(code.detail_description)}",
				use_yn:"${fn:escapeXml(code.use_yn)}"
			});
		</c:forEach>
	}
	
	function categoryChange(categoryId, categoryName) {
		if (categoryId != "")
		{
			var index = 0;
			var str = "";
			var listBody = $("#category_detail_list_body"); 
			listBody.empty();

			str += '<tr>';
			str += '	<td>코드</td>';
			str += '	<td>생태계명</td>';
			str += '	<td>코드</td>';
			str += '	<td>생태계 세부명</td>';
			str += '	<td>사용여부</td>';
			str += '</tr>';

			$.each(commonCodeArr, function(index, item) {
				if ( item.master_id == 'M000003' && item.parent_id == categoryId) {
					str += '<tr>';
					str += '	<td>' + categoryId + '</td>';
					str += '	<td>' + categoryName + '</td>';
					str += '	<td>' + item.detail_id + '</td>';
					str += '	<td>' + item.name + '</td>';
				 	str += '	<td>';
				 	if ( item.use_yn == "Y") {
			        	str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions2-" + index + "' id='category_detail_use_yn_" + index + "_y' value='Y' checked='checked' onclick='categoryDetailUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions2-" + index + "' id='category_detail_use_yn_" + index + "_n' value='N' onclick='categoryDetailUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
				 	else {
			        	str += '		<div class="form-check form-check-inline">';
			        	str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions2-" + index + "' id='category_detail_use_yn_" + index + "_y' value='Y'onclick='categoryDetailUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용</label>';
		       			str += '		</div>';
		       			str += '		<div class="form-check form-check-inline">';
		       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions2-" + index + "' id='category_detail_use_yn_" + index + "_n' value='N' checked='checked' onclick='categoryDetailUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
		       			str += '			<label class="form-check-label">사용 안함</label>';
		       			str += '		</div>';
				 	}
		        	str += '	</td>';
					str += '</tr>';

					index++;
				}
			});

			listBody.append(str); 
		}
	 	else {
			categoryDetailListBodyinit();
		}
	}

	function categoryListBodyinit(){
		// 생태계 관리  Select 생성 
		str = "";
		var categoryListBody = $("#category_list_body"); 
		categoryListBody.empty();

		var index = 0;
		str += '<tr>';
		str += '	<td>코드</td>';
		str += '	<td>생태계명</td>';
		str += '	<td>사용 여부</td>';
		str += '</tr>';

		$.each(commonCodeArr, function(index, item) 
		{
			if ( item.master_id == 'M000002') 
			{
				str += '<tr>';
				str += '	<td>' + item.detail_id + '</td>';
				str += '	<td>' + item.name + '</td>';
			 	str += '	<td>';
			 	if ( item.use_yn == "Y") 
			 	{
		        	str += '		<div class="form-check form-check-inline">';
	       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions1-" + index + "' id='category_use_yn_" + index + "_y' value='Y' checked='checked' onclick='categoryUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
	       			str += '			<label class="form-check-label">사용</label>';
	       			str += '		</div>';
	       			str += '		<div class="form-check form-check-inline">';
	       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions1-" + index + "' id='category_use_yn_" + index + "_n' value='N' onclick='categoryUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
	       			str += '			<label class="form-check-label">사용 안함</label>';
	       			str += '		</div>';
			 	}
			 	else 
			 	{
		        	str += '		<div class="form-check form-check-inline">';
		        	str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions1-" + index + "' id='category_use_yn_" + index + "_y' value='Y' onclick='categoryUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
	       			str += '			<label class="form-check-label">사용</label>';
	       			str += '		</div>';
	       			str += '		<div class="form-check form-check-inline">';
	       			str += "			<input class='form-check-input' type='radio' name='inlineRadioOptions1-" + index + "' id='category_use_yn_" + index + "_n' value='N' checked='checked' onclick='categoryUseYN(\"" + item.detail_id + "\",\""+ index + "\");'/>";
	       			str += '			<label class="form-check-label">사용 안함</label>';
	       			str += '		</div>';
			 	}
	        	str += '	</td>';
				str += '</tr>';

				index++;
			}
		});
		
		categoryListBody.append(str); 
	};

	function categoryDetailListBodyinit(){
		// 생태계 관리  Select 생성 
		str = "";
		var categoryListBody = $("#category_detail_list_body"); 
		categoryListBody.empty();

		str += '<tr>';
		str += '	<td>코드</td>';
		str += '	<td>생태계명</td>';
		str += '	<td>코드</td>';
		str += '	<td>생태계 세부명</td>';
		str += '	<td>사용여부</td>';
		str += '</tr>';
		categoryListBody.append(str); 
	};

	
	function categoryUseYN(code, index ){
		var categoryId = $("input[name='inlineRadioOptions1-" + index + "']:checked").attr("id");
		var flag = $("input[name='inlineRadioOptions1-" + index + "']:checked").val();

		
		// 같은 버튼을 눌렀을 시 반응안토록 한다.
		var returnFlag = false;
		$.each(commonCodeArr, function(indexEach, item) 
		{
			if ( item.master_id == 'M000002' && item.detail_id == code && item.use_yn == flag) 
			{
				returnFlag = true;
				return;
			}
		});

		if ( returnFlag == true ){
			return;
		}

		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/code/update/useYN",
			    data :{
			    	"master_id" : "M000002",
			    	"detail_id" : code,
			    	"use_yn" : flag
			    },
			    success : function(data) {
			        if (data.result > 0) {
			            alert("변경 되었습니다.");

			    		$.each(commonCodeArr, function(indexEach, item) 
	    				{
	    					if ( item.master_id == 'M000002' && item.detail_id == code) 
	    					{
	    						item.use_yn = flag;
	    						return;
	    					}
	    				});
			        } else {
			            alert(data.result);
			        }
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}
		else {

			if (flag == "Y") {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_n" ).prop('checked', true);
			}
			else {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_y" ).prop('checked', true);
			}
		}	
	}




	function categoryDetailUseYN(code, index){
		
		var categoryId = $("input[name='inlineRadioOptions2-" + index + "']:checked").attr("id");
		var flag = $("input[name='inlineRadioOptions2-" + index + "']:checked").val();

		// 같은 버튼을 눌렀을 시 반응안토록 한다.
		var returnFlag = false;
		$.each(commonCodeArr, function(indexEach, item) 
		{
			if ( item.master_id == 'M000003' && item.detail_id == code && item.use_yn == flag) 
			{
				returnFlag = true;
				return;
			}
		});

		if ( returnFlag == true ){
			return;
		}
		

		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/code/update/useYN",
			    data :{
			    	"master_id" : "M000003",
			    	"detail_id" : code,
			    	"use_yn" : flag
			    },
			    success : function(data) {
			        if (data.result > 0) {
			            alert("변경 되었습니다.");
		    			$.each(commonCodeArr, function(indexEach, item) 
	    				{
	    					if ( item.master_id == 'M000003' && item.detail_id == code) 
	    					{
	    						item.use_yn = flag;
	    						return;
	    					}
	    				});
			        } else {
			            alert(data.result);
			        }
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}
		else {

			if (flag == "Y") {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_n" ).prop('checked', true);
			}
			else {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_y" ).prop('checked', true);
			}
		}	
	}


	function categoryDetailOccupationUseYN(code, index){
		var categoryId = $("input[name='inlineRadioOptions3-" + index + "']:checked").attr("id");
		var flag = $("input[name='inlineRadioOptions3-" + index + "']:checked").val();

		// 같은 버튼을 눌렀을 시 반응안토록 한다.
		var returnFlag = false;
		$.each(commonCodeArr, function(indexEach, item) 
		{
			if ( item.master_id == 'M000004' && item.detail_id == code && item.use_yn == flag) 
			{
				returnFlag = true;
				return;
			}
		});

		if ( returnFlag == true ){
			return;
		}

		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/code/update/useYN",
			    data :{
			    	"master_id" : "M000004",
			    	"detail_id" : code,
			    	"use_yn" : flag
			    },
			    success : function(data) {
			        if (data.result > 0) {
			            alert("변경 되었습니다.");
		    			$.each(commonCodeArr, function(indexEach, item) 
	    				{
	    					if ( item.master_id == 'M000004' && item.detail_id == code) 
	    					{
	    						item.use_yn = flag;
	    						return;
	    					}
	    				});
			        } else {
			            alert(data.result);
			        }
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}
		else {

			if (flag == "Y") {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_n" ).prop('checked', true);
			}
			else {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_y" ).prop('checked', true);
			}
		}	
	}


	function majorUseYN(code, index) {
		var categoryId = $("input[name='inlineRadioOptions4-" + index + "']:checked").attr("id");
		var flag = $("input[name='inlineRadioOptions4-" + index + "']:checked").val();
	
		
		// 같은 버튼을 눌렀을 시 반응안토록 한다.
		var returnFlag = false;
		$.each(commonCodeArr, function(indexEach, item) 
		{
			if ( item.master_id == 'M000006' && item.detail_id == code && item.use_yn == flag) 
			{
				returnFlag = true;
				return;
			}
		});
	
		if ( returnFlag == true ){
			return;
		}
	
		if (confirm('변경 하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : "/admin/api/job/code/update/useYN",
			    data :{
			    	"master_id" : "M000006",
			    	"detail_id" : code,
			    	"use_yn" : flag
			    },
			    success : function(data) {
			        if (data.result > 0) {
			            alert("변경 되었습니다.");
	
			    		$.each(commonCodeArr, function(indexEach, item) 
	    				{
	    					if ( item.master_id == 'M000006' && item.detail_id == code) 
	    					{
	    						item.use_yn = flag;
	    						return;
	    					}
	    				});
			        } else {
			            alert(data.result);
			        }
			    },
			    error : function(err) {
		        	alert(err);
			    }
			});
		}
		else {
	
			if (flag == "Y") {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_n" ).prop('checked', true);
			}
			else {
				$("#" + categoryId).prop('checked', false);
				$("#" + categoryId.slice(0, (categoryId.length-2)) + "_y" ).prop('checked', true);
			}
		}	
	}

</script>
  
  
<!--페이지 루트-->
<div class="page-nation container">
	<a href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
	<a href="./html/job-list-search.html">일자리</a><span class="route_icon"></span>
	<a href="./html/code-manage.html">일자리 코드 관리</a>
</div>
<!--본문시작-->
<div class="sub-container container">
	<input type="hidden" id="common_code" name="common_code" value='<c:out value="${commonCode}"/>' />
	<div class="sub-content">
	<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">
			일자리 코드 관리
			</h3>
		</div>
		
		<div class="sub-content-box bgc-white">
              <!--탭-->
              <div class="code-manage-tab">						
				<div class="code-manage_tab_btns my-pager">
					<a href="javascript:void(0)" class="btn-pager btn0 active">생태계 관리</a>
					<a href="javascript:void(0)" class="btn-pager btn1">생태계 세부 관리</a>
					<!-- <a href="javascript:void(0)" class="btn-pager btn2">직종 관리</a> -->
					<a href="javascript:void(0)" class="btn-pager btn1">전공 관리</a>
					<!-- <a href="javascript:void(0)" class="btn-pager btn2">자격증 관리</a> -->
				</div>
				<ul class="bx">
					<li class="on">
                        <div class="table_top_boxs ta_r">
					       <button type="button" class="blue_btn2 btn add_cell_btn" id="add_cell_btn_1">추가</button>
                         </div>
                         <table class="table table-striped-primary table-borderless text-dark-m1 mb-0">
                             <caption>생태계 분류</caption>
                             <colgroup>
                                 <col style="width: 15%" />
                                 <col style="width: 60%" />
                                 <col style="width: 25%" />
                             </colgroup>	
                             <thead>			
                                 <tr class="bgc-primary-d2 text-white text-sm-center">							
									<th colspan="3">생태계 분류</th>
                                 </tr> 
                             </thead>
                             <tbody class="text-sm-center" id="category_list_body">       
                             </tbody>						
                         </table>
                         <p class="warning_txt"><span class="necessary_icon">*</span>코드 생성 후 생성된 코드를 사용하는 데이터가 생성되면 삭제가 불가능합니다.</p>
                         <div class="upload_btn">
                             <button class="blue_btn" id="upload_tab_btn_1">저장</button>
                         </div>
					</li>
					<!--생태계 세부 관리-->	
					<li style="display: none;" class="clearfix">
                       	<div class="table_top_boxs clearfix">
                            <select class="ace-select w20 fl" id="selector_category" title="생태계 분류">	
                               	<option value="">생태계 분류 전체</option>
                        		<c:forEach items="${commonCode}" var="code">
									<c:if test="${code.master_id == 'M000002'}">
										<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
									</c:if>
								</c:forEach>
                            </select>
                            <input type="button" class="blue_btn2 btn add_cell_btn fr" name="addStaff2" id="add_cell_btn_2" value="추가" />                      
						</div>
					    <table class="table table-striped-primary table-borderless text-dark-m1 mb-0" id="responsive-table">
                                  <caption>생태계 세부 관리 </caption>
                                  <colgroup>
                                      <col style="width: 5%" />
                                      <col style="width: 35%" />
                                      <col style="width: 5%" />
                                      <col style="width: 35%" />
                                      <col style="width: 20%" />
                                  </colgroup>	
                                  <thead>			
                                      <tr class="bgc-primary-d2 text-white text-sm-center">							       
									<th colspan="2">생태계 분류</th>
                                          <th colspan="3">생태계 세부 분류</th>
                                      </tr> 
                                  </thead>
                                  <tbody class="text-sm-center" id="category_detail_list_body">       
                                  </tbody>						
                         </table>	
                         <div class="upload_btn">
                        	<button class="blue_btn" id="upload_tab_btn_2">저장</button>
                        </div>	
					</li>	
                     	
					<!--직종 관리-->			  		
					<li style="display: none;">
                             <div class="table_top_boxs">
								<select class="ace-select w20 fl" id="selector_category_occupation" title="생태계 분류">	
	                               	<option value="">생태계 분류 전체</option>
	                        		<c:forEach items="${commonCode}" var="code">
										<c:if test="${code.master_id == 'M000002'}">
											<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
										</c:if>
									</c:forEach>
	                            </select>
	                            <select class="area_write_table_txt w25 ace-select" name="subCategory" id="selector_category_detail_occupation">
                               	</select>
                            	<input type="button" class="blue_btn2 btn add_cell_btn fr" name="addStaff3" id="add_cell_btn_3" value="추가" /> 
                             </div>
				    		<table class="table table-striped-primary table-borderless text-dark-m1 mb-0">
                                  <caption>직종 관리</caption>
                                  <colgroup>
                                      <col style="width: 5%" />
                                      <col style="width: 20%" />
                                      <col style="width: 5%" />
                                      <col style="width: 20%" />
                                      <col style="width: 5%" />
                                      <col style="width: 20%" />
                                      <col style="width: 20%" />
                                  </colgroup>	
                                  <thead>			
                                      <tr class="bgc-primary-d2 text-white text-sm-center">							       
											<th colspan="2">생태계 분류</th>
                                       		<th colspan="2">생태계 세부 분류</th>
                                          	<th colspan="3">직종 분류</th>
                                      </tr> 
                                  </thead>
                                  <tbody class="text-sm-center" id="occupation_list_body">       
                                  </tbody>						
                              </table>		
                         <div class="upload_btn">
                  	     	<button class="blue_btn" id="upload_tab_btn_3">저장</button>
                         </div>
					</li>
					<!--전공 관리-->	
					<li style="display: none;">
					    <div class="table_top_boxs ta_r">
							<input type="button" class="blue_btn2 btn add_cell_btn " name="addStaff4" id="add_cell_btn_4" value="추가" onclick="addInput();" />
					    </div>
					    <table class="table table-striped-primary table-borderless text-dark-m1 mb-0 td_bg_white">
                                  <caption>전공 관리</caption>
                                  <colgroup>
                                      <col style="width: 30%" />
                                      <col style="width: 20%" />
                                      <col style="width: 30%" />
                                      <col style="width: 20%" />
                                  </colgroup>	
                                  <thead>			
                                      <tr class="bgc-primary-d2 text-white text-sm-center">							       
										 <th>전공명</th>
                                         <th>사용여부</th>
                                         <th>전공명</th>
                                         <th>사용여부</th>
                                      </tr> 
                                  </thead>
                                  <tbody class="text-sm-center" id="major_body">       
                                  </tbody>						
                              </table>	
                         <div class="upload_btn">
                  	     	<button class="blue_btn" id="upload_tab_btn_4">저장</button>
                         </div>
					</li>
				</ul>					
			</div>					
		</div>
	</div>
</div>         
 



