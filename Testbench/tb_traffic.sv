module tb_traffic;
logic clk;
logic rst;
logic [1:0] current_light_o;
logic [1:0] next_light_o;
logic [3:0] count;
// kết nối với dut
traffic dut(
.clk(clk),
.rst(rst),
.current_light_o(current_light_o),
.next_light_o(next_light_o),
.count(count)
);
//định nghĩa kiểu dữ liệu enum cho 3 trạng thái đèn
typedef enum logic [1:0]{
red=2'b00,
green=2'b01,
yellow=2'b10
} state_light;

//tạo covergroup cvg
//covergroup được kích hoạt mỗi khi cạnh lên của clk
covergroup cvg@(posedge clk);
//coverpoint cho tín hiệu clk theo dõi trạng thái high/low
cvgp_clk: coverpoint clk{
bins clk_l ={0};
bins clk_h ={1};
}
//coverpoint cho tín hiệu rst theo dõi trạng thái high/low
cvgp_rst: coverpoint rst{
bins rst_l ={0};
bins rst_h ={1};
}

//coverpoint cho trạng thái hiện tại 
cvgp_current_light: coverpoint current_light_o{
bins vl_current ={[0:3]}; // phớt lờ giá trị 3 vì chỉ xài 00,01,10
ignore_bins unused_c = {3};
}
//coverpoint cho trạng thái kế tiếp
cvgp_next_light: coverpoint next_light_o{
bins vl_next ={[0:3]}; // phớt lờ giá trị 3 vì chỉ xài 00,01,10
ignore_bins unused_n = {3}; // phớt lờ giá trị 3 vì chỉ xài 00,01,10
}
//coverpoint cho giá trị bộ đếm count
cvgp_wait_time: coverpoint count{
bins vl_count = {[0:15]}; // bộ đếm có giá trị từ 0->15
}
//kiểm tra mọi tổ hợp của count với các trạng thái đèn
cross_all: cross cvgp_wait_time, cvgp_current_light, cvgp_next_light;
endgroup
// Khai báo một biến tên là cp thuộc kiểu covergroup cvg
cvg cp; 
always @(posedge clk) begin
  cp.sample(); // Thu thập coverage mỗi xung clock
end

initial clk=0;
always #1 clk=~clk; // mỗi 2ps clk đảo trạng thái, 1 chu kỳ =2ps
//khởi tạo các tín hiệu rst
driver dvr(.clk(clk),.rst(rst));
//In trạng thái đèn 
monitor mon(.clk(clk),.current_light_o(current_light_o),.rst(rst),.count(count));
//kiểm tra giá trị khởi tạo bộ đếm khi vào mỗi trạng thái
checker_count chk_count(.clk(clk),.current_light_o(current_light_o),.count(count));
//kiểm tra thứ tự FSM
checker_fsm chk_fsm(.clk(clk),.current_light_o(current_light_o),.next_light_o(next_light_o),.count(count),.rst(rst));
//Khởi tạo 
initial begin
cp = new(); // kích hoạt covergroup để bắt đầu thu thập coverage
@(posedge clk);
#800 $display("Hoan thanh kiem tra");
$display("Coverage = %0.2f%%", cp.get_coverage());
$stop;
end
endmodule


