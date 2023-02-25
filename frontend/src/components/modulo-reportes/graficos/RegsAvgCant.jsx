import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";


const RegsAvgCant = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'proceso': '', 'cantidad': 0, 'porcentaje': 0.00}]
const[lista,setLista] = useState(tipo_array);


const [options, setOptions] = useState({});
   
  
  const [series,setSeries] = useState([]);

const setChartConfig = () =>{
  let data_serie = [];
  let data_label = [];
  lista.map((item) => {
    let registro = String(item["registro"]);
    registro = registro.substring(0, registro.indexOf(' '))
    data_label.push(registro);
    data_serie.push(item["cantidad"]);
  }
  );
  setOptions({
    chart: {
      type: 'donut',
    },
    labels:data_label,
    title: {
      text: 'Cantidad de Reincidencia en Registros'
    },
    plotOptions: {
      donut: {
        distributed: true,
        dataLabels: {
          position: 'bottom'
        },
      }
    },
    fill: {
      type: 'gradient',
    },
    legend: {
      position: 'bottom'
    },
    responsive: [{
      breakpoint: undefined,
      options: {
        chart: {
          width: 200
        },
        fill: {
          type: 'gradient',
        },
        legend: {
          position: 'bottom'
        }
      }
    }]
  })
  setSeries(data_serie);
}

const reporte = () =>{
  if(series[0]==undefined){
    return(<>cargando chart</>);
  }
       return(    
        <Chart redraw="true" options={options} series={series} type="donut" width={500} height={400}/>    
    );
}

useEffect(() => {   
    async function getRegsAvg(){
        try {
          const response = await instance.get("listBadRegsAvg/"+props.id);
          setLista(JSON.parse(response.data));
        } catch (error) {
          console.log(error);
          throw new Error(error);
        } finally {   
        }      
        setChartConfig();
      };
      getRegsAvg();  
  }, [lista]);


    return (
        <>
        {reporte()}
        </>
      );
}

export default RegsAvgCant;