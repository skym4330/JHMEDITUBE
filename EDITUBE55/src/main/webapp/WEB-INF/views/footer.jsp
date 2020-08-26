<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <!-- Footer -->
    <div class="container">
      <div class="row">
        <div class="col-lg-6 h-100 text-center text-lg-left my-auto">
          <ul class="list-inline mb-2">
            <li class="list-inline-item">
              <a href="#">About</a>
            </li>
            <li class="list-inline-item">&sdot;</li>
            <li class="list-inline-item">
              <a href="./plist?pageNum=${pageNum}">Editer</a>
            </li>
            <li class="list-inline-item">&sdot;</li>
            <li class="list-inline-item">
              <a href="./timearry">Youtuber</a>
            </li>
            <li class="list-inline-item">&sdot;</li>
            <li class="list-inline-item">
              <a href="./commuBoard">community</a>
            </li>
          </ul>
          <p class="text-muted small mb-4 mb-lg-0">&copy; Our Website Editube 2020. All Rights Reserved.</p>
        </div>
        <div class="col-lg-6 h-100 text-center text-lg-right my-auto">
          <ul class="list-inline mb-0">
            <li class="list-inline-item mr-3">
              <a href="#">
                <i class="fab fa-facebook fa-2x fa-fw"></i>
              </a>
            </li>
            <li class="list-inline-item mr-3">
              <a href="#">
                <i class="fab fa-twitter-square fa-2x fa-fw"></i>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="#">
                <i class="fab fa-instagram fa-2x fa-fw"></i>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
    
    
  
<!-- Bootstrap core JavaScript -->
  <script src="resources/vendor/jquery/jquery.min.js"></script>
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <script>
  var socket = null;
  $(document).ready( function() {
      connectWS();      
  });
  function connectWS() {
      console.log("tttttttttttttt")
      var ws = new WebSocket("ws://localhost/echo");
      socket = ws;
      ws.onopen = function () {
          console.log('Info: connection opened.');
      };
      
      ws.onmessage = function (event) {
          console.log("ReceiveMessage:", event.data+'\n');
        
      };
      ws.onclose = function (event) { 
          console.log('Info: connection closed.');
          //setTimeout( function(){ connect(); }, 1000); // retry connection!!
      };
      ws.onerror = function (err) { console.log('Error:', err); };
  }
  </script>  