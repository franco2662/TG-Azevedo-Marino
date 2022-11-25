
import { React,useState, useEffect,useRef } from "react";
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { Toolbar, Tooltip, IconButton, Typography, OutlinedInput, InputAdornment, Stack, Button, Modal } from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';
import Checkbox from '@mui/material/Checkbox';
import axios from "axios";
import { useAppContext } from "../../AppContext";
import RuleIcon from '@mui/icons-material/Rule';
import AddIcon from '@mui/icons-material/Add';
import UserMoreOptions from "./UserMoreOptions";
import Register from "./Register";
import { Container } from "@mui/system";
import { useNavigate } from "react-router-dom";

const ModuloUsuario = () =>{
  const {usuarioObjeto,baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;

  const [filterName, setFilterName] = useState('');
  const [listaUsuarios, setListaUsuarios] = useState([]);
  const [listaUsuariosFiltrada, setListaUsuariosFiltrada] = useState([]);
  const [idSelected,setIdSelected] = useState([]);
  const [numSelected,setNumSelected] = useState(0);
  const [openRegister, setRegister] = useState(false);
  const navigate = useNavigate();

  function selectAllRows(){    
    if(idSelected.length>0){
      setIdSelected([]);
      setNumSelected(0);
    }      
    else{      
    const seleccionados = listaUsuariosFiltrada.map((item)=> {return item.id})
    setIdSelected(seleccionados);
    setNumSelected(seleccionados.length);  
    }
  }

  function isSelectedRow(id){
    if(idSelected.indexOf(id) !== -1)      
      return true;
    else return false;
  }

  const handleFilterName = (event) =>{
    setFilterName(event.target.value);
  }
  
  function filterListByName(){
    if(filterName.trim()=="") // Si no hay nada escrito setea la original
      setListaUsuariosFiltrada(listaUsuarios)
    else{
      //Se llena un array, si algun elemento de un registro coincide con la busqueda, se añade
      let lista = listaUsuarios.filter((item) => {          
          if(String(item.nombre_completo).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.email).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.doc_identidad).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.rol).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.empresa).toLowerCase().includes(filterName.toLowerCase()) ||
              ( 
                (filterName.toLowerCase()=="activo" && item.estado) || //Para buscar por estado
                (filterName.toLowerCase()=="inactivo" && !item.estado )
              )
          )
          return item;
      });
      setListaUsuariosFiltrada(lista); //Se asigna el array filtrado anteriormente
    }
  }

  useEffect(() => {
    // if (!Number.isInteger(usuarioObjeto.current.Id) || usuarioObjeto.current.fk_rol.id > 2)
    //   navigate("/")
    let a  = usuarioObjeto.current;
    getUserList();
    setNumSelected(0);
  }, []);

  useEffect(() => {
    filterListByName(); //Cada vez que cambie la busqueda
  }, [filterName]);


  async function getUserList(){
    try {
      const response = await instance.get("viewuserlist/");
      setListaUsuarios(JSON.parse(response.data))    
      setListaUsuariosFiltrada(JSON.parse(response.data))
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {        
    }
  };

  function getEstadoTableCell(estado){
    
      if (estado==true)
        return(<TableCell align="left" sx={{color:"green",fontWeight: "bold"}}>Activo</TableCell>)
      else
        return(<TableCell align="left" sx={{color:"red",fontWeight: "bold"}}>Inactivo</TableCell>)
    
  }

  async function updateAllUsersState() {
    try {
      let response = await instance.post("updateAllUsersStatus/");
      if (response?.data)
        window.location.reload();
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } 
  }

  const handleUpdateAll=()=>{
    updateAllUsersState();
  }

  const openRegisterModal = () => {
    setRegister(true);
  };

  const closeRegisterModal = () => {
    setRegister(false);
  };

    return (
      <>
      <Stack direction="row" alignItems="center" justifyContent="space-between" mb={5}>
          <Typography variant="h4" gutterBottom>
            Listado de Usuarios
          </Typography>
          <Button variant="contained" startIcon={<AddIcon/>} onClick={openRegisterModal}>
            Registrar Usuario
          </Button>
        </Stack>
        <Modal open={openRegister} onClose={closeRegisterModal}>
          <Container><Register onCloseModal={closeRegisterModal}></Register></Container>
        </Modal>
        
      {numSelected > 0 ? (       
      <Toolbar display="flex" sx={{ minWidth: 650, justifyContent: 'space-between',bgcolor:'#E4EBEB' }}>
        <Typography component="div" variant="subtitle1">
        {numSelected} Seleccionados
        </Typography>
      <Tooltip title="Cambiar Estado" onClick={handleUpdateAll}>
          <IconButton>
            <RuleIcon/>
          </IconButton>
        </Tooltip>
      </Toolbar>
      ) : (
        <Toolbar sx={{ minWidth: 650 }}>
          <OutlinedInput
            value={filterName}
            onChange={handleFilterName}
            placeholder="Buscar usuario..."
            startAdornment={
              <InputAdornment position="start">
                <SearchIcon />
              </InputAdornment>
            }
            sx={{ width:'20%' }}
          />
        </Toolbar>
      )}

      
              
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
            
              <TableRow>
                <TableCell align="center" sx={{width:'10%'}}><Checkbox onClick={()=>selectAllRows()}/>ID</TableCell>           
                <TableCell align="left">Nombre Completo</TableCell>
                <TableCell align="left">Email</TableCell>
                <TableCell align="left">Doc Identidad</TableCell>
                <TableCell align="left">Rol</TableCell>
                <TableCell align="left">Empresa</TableCell>
                <TableCell align="left">Estado</TableCell>
                <TableCell align="left"></TableCell>
              </TableRow>
            </TableHead>
            <TableBody>              
              {listaUsuariosFiltrada.map((row) => (                
                <TableRow
                  key={row.id}
                  sx={{'&:last-child td, &:last-child th': { border: 0 }}}                  
                >  <TableCell align="center" scope="row">
                <Checkbox checked={isSelectedRow(row.id)}/>
                {row.id}
                </TableCell>               
                  <TableCell align="left" scope="row">
                    {row.nombre_completo}
                    </TableCell>
                  <TableCell align="left">{row.email}</TableCell>                  
                  <TableCell align="left">{row.doc_identidad}</TableCell>                  
                  <TableCell align="left">{row.rol}</TableCell>
                  <TableCell align="left">{row.empresa}</TableCell>                  
                  {getEstadoTableCell(row.estado)}
                  <TableCell align="right">
                    <UserMoreOptions userId={row.id}/>
                  </TableCell>                  
                </TableRow>
                
              ))}
            </TableBody>
          </Table>
        </TableContainer>
        </>
      );
}

export default ModuloUsuario;