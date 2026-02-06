module traffic(
input logic clk, 
input logic rst,
output logic [1:0] current_light_o,
output logic [1:0] next_light_o,
output logic [3:0] count
);
logic [3:0] wait_time; // Thời gian chờ chuyển trạng thái đèn
//định nghĩa kiểu dữ liệu enum cho 3 trạng thái đèn
typedef enum logic [1:0]{
red=2'b00,
green=2'b01,
yellow=2'b10
} state_light; 
state_light current_light; // trạng thái đèn hiện tại
state_light next_light; // trạng thái đèn kế tiếp
//Gán các trạng thái đèn và thời gian chờ ra output
assign current_light_o=current_light;
assign next_light_o=next_light;
assign count=wait_time;
//Khi reset thì sẽ gán trạng thái đèn đỏ và thời gian chờ
//Khi hết thời gian chờ thì sẽ chuyển sang trạng thái đèn kế tiếp
always_ff @(posedge clk) begin
  if (rst == 1) begin
    current_light <= red; //khi reset thì đèn đỏ ngay lập tức
    wait_time <= 4'd15; //Khởi tạo timer cho đèn đỏ 
  end else if (wait_time == 0) begin //Nếu hết thời gian ở trạng thái hiện tại
    current_light <= next_light; // chuyển trạng thái đèn
    case (next_light)
      red: wait_time <= 4'd15; //Nếu kể tiếp là red thì chờ 15s
      green: wait_time <= 4'd10; //Nếu kế tiếp là green thì chờ 10s
      yellow: wait_time <= 4'd5; //Nếu kế tiếp là green thì chờ 5s
    endcase
  end else begin
    wait_time <= wait_time - 1; // Giảm thời gian chờ
  end
end
// xác định next_light dựa vào current_light
always_comb begin
	case(current_light)
	red: next_light=green; // khi trạng thái đèn hiện tại là đỏ thì trạng thái đèn kế tiếp là xanh
	green: next_light=yellow; // khi trạng thái đèn hiện tại là xanh thì trạng thái đèn kế tiếp là vàng
	yellow: next_light=red; // khi trạng thái đèn hiện tại là vàng thì trạng thái đèn kế tiếp là đỏ
	default: next_light=red; // Trường hợp không xác định
	endcase
end
endmodule