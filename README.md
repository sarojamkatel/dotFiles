requirements to set up this config in new machine(https://www.youtube.com/watch?v=y6XCebnB9gs&t=144s):
fooook gnu stow , just symlink manually as : ln -s ~/dotFiles/.config/i3 ~/.config/i3
  
1)git 
2)GNU stow 
3) clone this repo to your local machine 
4)cd dotFiles
5)
~/dotFiles/
└── .config/
    └── i3/
        └── config
 For this folder structure; run stow to create symlinks as ;stow -v -t ~ .config # this will create symlink in -t( target home dir), and stuff inside .config( which in our case is i3) is symlinked as ~/.config/i3 -> ~/dotFiles/.config/i3

 


