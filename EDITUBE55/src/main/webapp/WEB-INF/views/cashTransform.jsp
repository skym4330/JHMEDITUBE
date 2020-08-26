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
        <h1 class="title">Cash Transform</h1>
        <form action="changemoney" method="post">
            <div class="input-container">
            	<input type="hidden" name="ca_mnickname" value="${mb.m_nickname}">
            	<input type="text" id="money" name="ca_outcash" required autofocus><label>전환할 캐쉬</label>
                <div class="bar"></div>
            </div>
            
                 
            <div class="button-container">
            	<button type="submit" style="width: 240px">
            		<span>캐시 전환</span>
            	</button>
            </div>
            <div>
            <span><br></span>
            </div>
        </form>
    </div>
</div>
</div>	 

     
   </html>