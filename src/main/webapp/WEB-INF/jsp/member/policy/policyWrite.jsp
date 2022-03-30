<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sec:authentication property="principal.username" var="user_id" />
<script type="text/javascript" src="${ctx }/assets/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type='text/javascript'>
	var oEditors = [];

	$(document).ready(function() {
		$("#writer").val("${fn:escapeXml(user_id)}");
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "explanation", //textarea에서 지정한 id와 일치해야 합니다. 
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI : "${ctx }/assets/SE2/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
				fOnBeforeUnload : function() {

				}
			},
			fOnAppLoad : function() {
				//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
				//oEditors.getById["explanation"].exec("PASTE_HTML",[ "기존 DB에 저장된 내용을 에디터에 적용할 문구" ]);
			},
			fCreator : "createSEditor2"
		});

		$("#reg_btn").click(function() {
			registration();
		});

		$("#cancel_btn").click(function() {
			location.href = "/user/rdt/policy/list";
		});
	});

	
	function registration() {
		var form = $("#frm")[0];
        var formData = new FormData(form);
        var sUrl = "/member/api/policy/registration";
		var params = new Object();
        
		var chkVal = ["title", "writer"];
		for (var i = 0; i < chkVal.length; i++) {
			if ($("#" + chkVal[i]).val() == "") {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		var base64Pwd = btoa($("#comment_pwd").val());
		var region = $("#region_selector option:selected").text();

		formData.set("comment_pwd", base64Pwd);
		formData.set("region", region);
		formData.set("title", $("#title").val());
		formData.set("writer", $("#writer").val());


		console.log($("#attach_file_1")[0].files[0]);
		
		formData.append("attach_file_1", $("#attach_file_1")[0].files[0]);
		formData.set("explanation", oEditors.getById["explanation"].getIR());
		
		
		if (confirm('등록하시겠습니까?')) {
			$.ajax({
			    type : "POST",
			    url : sUrl,
			    data : formData,
			    processData: false,
			    contentType: false,
			    success : function(data) {
			        if (data.result == 1) {
			            alert("등록에 성공하였습니다.");
			            location.href = "/user/rdt/policy/list";
			        } else {
			            alert("등록에 실패하였습니다. 다시 시도해 주시기 바랍니다.");
			        }
			        
			    },
			    error : function(err) {
			        alert(err.status);
			    }
			});
		}
	}

	
</script>
<!-- mark: content -->
<!-- mark: content -->
		<div id="cont">

			<div class="sub-content board-type clearfix">
				<section class="sec">
					<div>
						<h1 class="txt-sub-tit clr--primary ff-ng-b">정책제안</h1>
						<p class="txt-sub2 pb-l">경기도청소년활동진흥센터는 청소년들의 올바른 성장을 지원합니다.</p>
						<form name="frm" id="frm">
							<div class="table-wrap">
								<table class="table view-type">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tbody>
										<tr>
											<th class="subject">제목</th>
											<td class="ml-s txt-l" colspan="3">
												<div class="inp-wrap"><input type="text" placeholder="" class="" id="title"></div>
											</td>
										</tr>
										<tr>
											<th>지역이름</th>
											<td class="ml-s txt-l" colspan="3">
												<div class="selectWrap">
													<select title="test" class="form_select" id="region_selector">
														<option value="0">경기도</option>
														<option value="1">가평군</option>
														<option value="2">고양시</option>
														<option value="3">과천시</option>
														<option value="4">광명시</option>
														<option value="5">광주시</option>
														<option value="6">구리시</option>
														<option value="7">군포시</option>
														<option value="8">김포시</option>
														<option value="9">남양주시</option>
														<option value="10">동두천시</option>
														<option value="11">부천시</option>
														<option value="12">성남시</option>
														<option value="13">수원시</option>
														<option value="14">시흥시</option>
														<option value="15">안산시</option>
														<option value="16">안성시</option>
														<option value="17">안양시</option>
														<option value="18">양주시</option>
														<option value="19">양평군</option>
														<option value="20">여주시</option>
														<option value="21">연천군</option>
														<option value="22">오산시</option>
														<option value="23">용인시</option>
														<option value="24">의왕시</option>
														<option value="25">의정부시</option>
														<option value="26">이천시</option>
														<option value="27">파주시</option>
														<option value="28">평택시</option>
														<option value="29">포천시</option>
														<option value="30">하남시</option>
														<option value="31">화성시</option>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<th class="">작성자명</th>
											<td class="ml-s txt-l">
												<div class="inp-wrap"><input type="text" placeholder="" class="" id="writer" disabled></div>
											</td>
											<th>비밀번호</th>
											<td>
												<div class="inp-wrap"><input type="password" placeholder="" class="" value="" id="comment_pwd"></div>
											</td>
										</tr>
										<tr>
											<th>내용</th>
											<td colspan="3">
												<textarea name="explanation" id="explanation" class="form-control" cols="30" rows="10"></textarea>
											</td>
										</tr>
										<tr>
											<th>첨부파일</th>
											<td class="ml-s txt-l" colspan="3">
												<input type="file" name="attach_file_1" id="attach_file_1" title="첨부파일">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</form>
						<!-- btn -->
						<div class="btn-wrap txt-r mt--s">
							<button type="button" class="btn--main" id="cancel_btn"><span>취소</span></button>
							<button type="button" class="btn--main ml-s" id="reg_btn"><span>등록</span></button>
						</div>
					</div>
				</section>
			</div>

		</div>