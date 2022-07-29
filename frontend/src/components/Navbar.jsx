import React from "react";
import { AppBar, Toolbar, styled, Typography, Box, InputBase, Badge, Drawer, IconButton, Stack } from "@mui/material";
import NotificationsIcon from '@mui/icons-material/Notifications';
import MenuIcon from '@mui/icons-material/Menu';
import Sidebar from "./Sidebar";
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import { useState, useEffect } from "react";
import { useTheme } from '@mui/material/styles';

const Search = styled("div")(({ theme }) => ({
  backgroundColor: "white",
  padding: "0 10px",
  borderRadius: theme.shape.borderRadius,
  width: "40%"
}))

const Navbar = () => {
  const [open, setOpen] = useState(false);

  const toggleDrawerOpen = () => {
    setOpen(true);
    console.log('toggleDrawerOpen');
  };
  const toggleDrawerClose = () => {
    setOpen(false);
    console.log('toggleDrawerClose');
  };
  useEffect(() => {
    setOpen(false);
    console.log('useEffect called');
  },[])
  return (
    <Box sx={{ display: 'flex',flexGrow: 1 }}>
      <AppBar position="sticky">
        <Toolbar display="flex">
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={toggleDrawerOpen}
            sx={{ mr: 2 }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Dashboard</Typography>          
          <Search sx={{ display: { xs: "none", sm: "block" }}} ><InputBase placeholder="search..." /></Search>
          <Box>
            <Badge badgeContent={4} color="error">
            <NotificationsIcon />
          </Badge>
          </Box>
        </Toolbar>
      </AppBar>
      <Drawer variant="persistent" open={open} >
      <Toolbar
            sx={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'flex-end',
              px: [1],
            }}
          >
        <IconButton onClick={toggleDrawerClose} >
          <ChevronLeftIcon />
        </IconButton>
        </Toolbar>
        <Sidebar />
      </Drawer>
    </Box>

  )
}
export default Navbar;