import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';


const RegsAvgCant = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'proceso': '', 'cantidad': 0, 'porcentaje': 0.00}]
const[lista,setLista] = useState(tipo_array);
const[cargado,setCargado] = useState(false);


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
  setCargado(true);
}

const reporte = () =>{
  if(series[0]==undefined){
    return(<>cargando chart</>);
  }
  return (
    <Card sx={{ minWidth: 500, minHeight: 400, marginBottom: 5, marginRight: 2, borderRadius: 5  }} elevation={8}>
      <CardContent>
        <Chart redraw="true" options={options} series={series} type="donut" width={500} height={400} />
      </CardContent>
    </Card>
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
  }, [cargado]);


    return (
        <>
        {reporte()}
        </>
      );
}

export default RegsAvgCant;