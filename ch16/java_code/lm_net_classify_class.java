package lm;
import classify.lm_net_classify.LMClass;

import com.mathworks.toolbox.javabuilder.MWException;
/**
 * LM神经网络Matlab和Java混合编程实例程序
 *
 */
public class lm_net_classify_class {
	
		public static void main(String[] args) throws MWException {
			LMClass ma = new LMClass();
			try{
				 double [][] get_data =new double [][]{
			                {1,1,1,1,1,1} ,
			                {2,5,5,4,3,3} ,	 
			                 {3,3,5,3,1,2} ,
			                 {4,1,1,1,1,3} ,
			                 {5, 5,5,5,4,4} ,
			                 {6,5,5,2,5,5} ,
			                 {7,5,5,5,5,5} ,
			                 {8,5,5,5,5,4} ,
			                 {9,1,1,3,3,1} ,
			                 {10,1,1,3,3,1} ,
			                 {11,5,5,5,3,4} ,
			                 {12,1,5,3,1,3} ,
			                 {13,1,3,5,3,2} ,
			                 {14, 2,2,2,1,1} ,
			                 {15,2,2,4,5,2} ,
			                 {16, 2,2,1,2,3} ,
			                 {17, 5,5,5,1,4} ,
			                 {18,5,2,4,4,4} ,
			                 {19, 3,2,1,2,2} ,
			                 {20,1,1,1,1,1 } ,
			                 {21, 5,5,3,3,4} ,
			                 {22,2,2,5,2,3} ,
			                 {23,2,2,2,3,3} ,
			                 {24,1,1,1,1,3} ,
			                 {25,3,3,1,2,2} ,
			                 {26,3,5,4,4,3} ,
			                 {27,5,5,4,4,5} ,
			                 {28,5,5,3,3,4} ,
			                 {29,5,5,1,1,4 } ,
			                 
			                } ;
				
				 double [][] predict_data =new double [][]{		 
						 { 33,5	,5,	1,4} ,				 
				 };/////这个预测的赋值，注意格式，只需要X的属性值，没有类号。
				 
				 double [][] train_para =new double [][]{		 
						 { 25} ,
						 {100},
						 {0.001},
						 {0.001},
						 {0.001},
						 {10},
						 {0.1},
						 {1e10},
				 };
				 
			   String  figure_path="E:\\image";///图像保存路径,特别注意，这个路径要用
					//英文的路径，不然java调用会出错。
			 
	         float  test_data_number = 2 ;//测试数据 的个数                
	         String train_figure_name="lmNetStructure,lmNetTrainError,lmNetTrainFigure,lmNetTrainRelaError";//图片的名称
	         String test_figure_name="lmNetTestFigure,lmNetTestRelaError";//图片的名称     
	         float  mid_node_num=6;	               
	       	 double [][] figure_set =new double [][]{		 
					 { 7} ,
					 {650},
					 {320},
				
			 };
	       	 ///训练函数  
	        String train_fun ="tansig,purelin";		 	           
			////总函数 打印第一个返回值
	       System.out.println(ma.lmNetClassify(5,get_data,test_data_number,
	    		   predict_data,train_para,train_fun,mid_node_num,figure_path,
	    		   train_figure_name,test_figure_name,figure_set)[0]);
	        System.out.println("测试正常结束");	
			}           
			catch(Exception ex){
				ex.printStackTrace();
			}
		}

}
