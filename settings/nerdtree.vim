nnoremap <silent><C-k> :NERDTreeToggle<CR>
nnoremap <silent><C-f> :NERDTreeFind<CR>

let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '^__pycache__$[[dir]]', '^.git$[[dir]]']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif