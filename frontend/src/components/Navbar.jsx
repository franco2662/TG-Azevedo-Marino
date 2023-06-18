import React from "react";
import { AppBar, Toolbar, styled, Typography, Box, InputBase, Badge, Drawer, IconButton, Stack, Divider, Button, ButtonBase, List, ListItem, ListItemButton, Modal, Container } from "@mui/material";
import NotificationsIcon from '@mui/icons-material/Notifications';
import MenuIcon from '@mui/icons-material/Menu';
import Sidebar from "./Sidebar";
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import { useState, useEffect } from "react";
import { useTheme } from '@mui/material/styles';
import { useAppContext } from "../AppContext";
import { useNavigate } from "react-router-dom";
import LogoCompleto from '../assets/logo_completo_1.png'


const Navbar = () => {
const {showSidebar,handleSidebar,singOut} = useAppContext();

const navigate = useNavigate();
const Search = styled("div")(({ theme }) => ({
  backgroundColor: "white",
  padding: "0 10px",
  borderRadius: theme.shape.borderRadius
}))

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'flex-end',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
}));

const [drawerWidth,setDrawerWidth] = useState(9);

const CustomAppBar = styled(AppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}%)`,
    marginLeft: `${drawerWidth}%`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

  const theme = useTheme();
  const [open, setOpen] = useState(showSidebar);

  const toggleDrawerOpen = () => {
      setOpen(true);      
      handleSidebar(); 
  };
  const toggleDrawerClose = () => {   
      setOpen(false);
      handleSidebar();
  };

  useEffect(() => {
    setOpen(true);
  }, []);

  useEffect(() => {
    if (showSidebar) {
      setDrawerWidth(9);
    }
    else {
      setDrawerWidth(0);
    }
  }, [showSidebar]);

  const exitSession = () => {    
    singOut()
    navigate("/");
  };

  return (
    <Box sx={{  alignItems: "center" }}>
      <CustomAppBar id="appbar" position="fixed" open={open} sx = {{minHeight:'5%',display: 'flex', justifyContent: 'center',backgroundColor: '#34043D',backgroundImage: "linear-gradient(to right,#453FC6, #34043D)"}}>
        <Toolbar id="toolbar" display="flex">
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={toggleDrawerOpen}
            sx={{
              marginRight: 5,
              ...(showSidebar && { display: 'none' }), backgroundColor: '#3530a1', borderRadius: 2, ":hover": {
                bgcolor: "#2a2681",
                color: "white"
              }
            }}
          >
          <MenuIcon />
          </IconButton>
          {/* <Typography variant="h6" sx={{ flexGrow: 1 }} >Dashboard</Typography> */}
          <Box id='logoDashboard' sx={{flexGrow: 1,
        justifyContent: 'center', marginLeft:2
      }}>
        <img src={LogoCompleto} height={38} width={184} alt="Logo" />
      </Box>
          <Box width="15%" sx={{ display: 'flex', marginLeft: "10px", alignItems: 'center' }}>
            
            <ListItemButton variant="contained" sx={{ flexGrow: 4, justifyContent: 'center', borderRadius: 5 }} onClick={exitSession}>
              <Button variant="contained" sx={{
                backgroundColor: '#453FC6', borderRadius: 2, ":hover": {
                  bgcolor: "#3530a1",
                  color: "white"
                }
              }}><Typography variant="h7">Cerrar Sesión</Typography></Button>
            </ListItemButton> 
          </Box>
        </Toolbar>
      </CustomAppBar>      
    </Box>

  )
}
export default Navbar;

