<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>
<link href="resources/css/chargeStyle.css?after" rel="stylesheet">
</head>

<div class="wrap">
<div class="container">
    <div class="card"></div>
    <div class="card">
    	<img src="resources/images/logo.png" width="100px" class="logo-center" onclick="gohome();">
        <h1 class="title">Editube Cash Charge</h1>
        <form action="cashCharging" name="cash" method="post">
            <div class="input-container">
            	<input type="hidden" name="ca_mnickname" value="${mb.m_nickname}">
            	<input type="text" id="money" name="ca_incash" required autofocus>
            	<label>충전할 금액</label>
                <div class="bar"></div>
            </div>
          
            <div class="button-container">
            <button type="submit" style="width: 240px"><span>캐시 충전</span></button>
            </div>
            <div>
            <span><br></span>
            </div>
        </form>
    </div>
</div>
</div>	 

     
</html>