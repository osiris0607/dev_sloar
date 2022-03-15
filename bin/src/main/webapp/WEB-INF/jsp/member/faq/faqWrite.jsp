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
			location.href = "/user/rdt/faq/list";
		});
	});


	function registration() {
		var form = $("#frm")[0];
        var formData = new FormData(form);
        var sUrl = "/member/api/faq/registration";
		var params = new Object();
        
		var chkVal = ["title", "writer"];
		for (var i = 0; i < chkVal.length; i++) {
			if ($("#" + chkVal[i]).val() == "") {
				alert($("#" + chkVal[i]).attr("title") + "은(는) 필수입력입니다.");
				$("#" + chkVal[i]).focus();
				return false;
			}
		}

		var radioVal = $(":input:radio[name=public_yn]:checked").val();
		

		if (radioVal == "N") {
			if ( $("#comment_pwd").val() == null || $("#comment_pwd").val() == "" ) {
				alert("비공개 글에 암호는 필수입력입니다.");
				return false;
			}
		}
		else {
			if ( $("#comment_pwd").val() != null && $("#comment_pwd").val() != "" ) {
				alert("공개 글에 암호는 적용되지 않습니다.");
			}
		}

		var base64Pwd = btoa($("#comment_pwd").val());

		
		formData.set("public_yn", radioVal);
		formData.set("comment_pwd", base64Pwd);
		formData.set("title", $("#title").val());
		formData.set("writer", $("#writer").val());
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
			            location.href = "/user/rdt/faq/list";
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
<div id="cont">
	<!-- 질의응답 -->
	<div class="sub-content board-type clearfix">
		<section class="sec">
			<div>
				<h1 class="txt-sub-tit clr--primary ff-ng-b">질의응답 - 등록</h1>
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
									<th class="">작성자명</th>
									<td class="ml-s txt-l" colspan="3">
										<div class="inp-wrap"><input type="text" placeholder="" class="" id="writer"></div>
									</td>
								</tr>
								<tr>
									<th>공개여부</th>
									<td class="ml-s txt-l">
										<div class="form-grp">
											<span><input type="radio" id="r1" name="public_yn" class="form__radio" checked="" value="Y"><label for="r1"><span class="label-txt">공개</span></label></span>
											<span><input type="radio" id="r2" name="public_yn" class="form__radio" value="N"><label for="r2"><span class="label-txt">비공개</span></label></span>
										</div>
									</td>
									<th>비밀번호</th>
									<td class="">
										<div class="inp-wrap"><input type="password" placeholder="" class="" value="" id="comment_pwd"></div>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td colspan="5"><textarea name="explanation" id="explanation" class="form-control" cols="30" rows="10"></textarea></td>
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