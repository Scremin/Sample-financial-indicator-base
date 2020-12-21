//+------------------------------------------------------------------+
//|                                                    Indicador mq5 |
//+------------------------------------------------------------------+
#property indicator_chart_window // Plot sobreposto ao gráfico.
//#property indicator_separate_window // Plot em janela separada.
//+------------------------------------------------------------------+
//| PROPRIEDADES DO INDICADOR                                        |
//+------------------------------------------------------------------+
#property indicator_buffers 1 // quantidade de vetores buffers.
#property indicator_plots 1 // quantidade relacionada ao type.
//---
#property indicator_label1 "indicador-teste" // nome.
#property indicator_type1 DRAW_LINE // type -> linha simples, moldável ao cálculo. DRAW_HISTOGRAM ...
#property indicator_style1 STYLE_SOLID // Formato sólido.
#property indicator_color1 clrRed
#property indicator_width1 2 // tamanho?
//+------------------------------------------------------------------+
//| VARIÁVEIS GLOBAIS                                                |
//+------------------------------------------------------------------+
double indBuffer[];
//+------------------------------------------------------------------+
//| INICIALIZAÇÃO                                                    |
//+------------------------------------------------------------------+
int OnInit()
  {
      SetIndexBuffer(0,indBuffer,INDICATOR_DATA); // Mapeamento do indicador. (janela,handle,)

      ArrayInitialize(indBuffer, EMPTY_VALUE); // Inicialização do indBuffer[] -> vazio.

      return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| ITERAÇÃO                                                         |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
      // 1ª plotagem ao inicializar o indicador.
      if(prev_calculated==0){
         // Verificar todos os candles.
         for(int i=0;i<rates_total;i++){
            // Colocando todos os valores de fechamento (close) no buffer de manipulação.
            //indBuffer[i] = (high[i])+0.00010; // Lembrar de atribuir os dígitos relativos ao ativo.
            indBuffer[i] = (high[i]);
         }
      }
      else{ // Subsequentes plotagens após a 1ª.
         // Aqui é plotado a partir do que já foi plotado na 1ª plotagem,
         // somando as subsequentes plotagens ao já desenhado.
         indBuffer[rates_total-1] = (low[rates_total-1]); // (rates_total-1) -> Todos menos o último candle.
      }
   
      //--- return value of prev_calculated for next call
      return(rates_total);
  }
//+------------------------------------------------------------------+
