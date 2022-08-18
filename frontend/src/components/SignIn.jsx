import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { Modal } from '@mui/material';
import { useState } from 'react';
import axios from "axios";

const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 400,
  bgcolor: 'background.paper',
  border: '2px solid #000',
  boxShadow: 24,
  p: 4,
};

const SignIn = () => {
  
  const theme = createTheme();
  const[user,setUser]=useState("");
  const[pass,setPass]=useState("");
  
async function verifyUser(){
  try
  {       
    const response = await axios.get("http://127.0.0.1:8000/verifyuser/"+user);
    if(!response?.data)
      return false;
    else 
      if(response?.data == true)
        return true;
      else
        return false;
  }
  catch(err)
  {
    if (!err?.response) 
    {
      console.log("No Server Response");
    }
    else
    {
      console.log("User verification failed");
    }
    return false;    
  }
}

const handleSignIn = async(e)=>{
  try
  { 
    e.preventDefault()        
    console.log("arepa  "+user+"    "+pass);
    const verificacion_usuario = await verifyUser();
    console.log(verificacion_usuario)
    if(verificacion_usuario)
    {
      const obj = { email: user, clave: pass };
      const json_request = JSON.stringify(obj);
      const response = await axios.post("http://127.0.0.1:8000/validatesignin/", json_request);
      console.log(response);
    }
    else
    {
      console.log("Usuario Inválido");
    }
       
  }
  catch(err)
  {
    if (!err?.response) 
    {
      console.log("No Server Response");
    }
    else
    {
      console.log("Registration Failed" + err?.response);
    }    
  }
}
  return (
    
      <Box
          
      sx={{
        ...style
      }}
    >
          <CssBaseline />
            <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }}>
              <LockOutlinedIcon />
            </Avatar>
            <Typography component="h1" variant="h5">
              Iniciar Sesión
            </Typography>
            <Box component="form" noValidate sx={{ mt: 1 }}>
              <TextField
                margin="normal"
                required
                fullWidth
                id="email"
                label="Correo Electrónico"
                name="email"
                autoComplete="email"
                autoFocus
                value={user}
                onChange={(e)=>setUser(e.target.value)}
              />
              <TextField
                margin="normal"
                required
                fullWidth
                name="password"
                label="Contraseña"
                type="password"
                id="password"
                autoComplete="current-password"
                value={pass}
                onChange={(e)=>setPass(e.target.value)}
              />
              <FormControlLabel
                control={<Checkbox value="remember" color="primary" />}
                label="Recordarme"
              />
              <Button
                type="submit"
                fullWidth
                variant="contained"
                sx={{ mt: 3, mb: 2 }}
                onClick ={handleSignIn}
              >
                Iniciar Sesión
              </Button>
              <Grid container>
                <Grid item xs>
                  <Link href="#" variant="body2">
                    Olvidó su contraseña?
                  </Link>
                </Grid>                
              </Grid>
            </Box>
          </Box>
    );
  }

export default SignIn;