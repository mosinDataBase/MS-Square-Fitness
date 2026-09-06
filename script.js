const header = document.querySelector('.site-header');
const menuBtn = document.querySelector('.menu-btn');
const drawer = document.querySelector('.mobile-drawer');
const closeBtn = document.querySelector('.close-menu');
const drawerLinks = drawer.querySelectorAll('a');

window.addEventListener('scroll', () => header.classList.toggle('scrolled', window.scrollY > 40));

function openMenu(){ drawer.classList.add('open'); drawer.setAttribute('aria-hidden','false'); menuBtn.setAttribute('aria-expanded','true'); document.body.style.overflow='hidden'; }
function closeMenu(){ drawer.classList.remove('open'); drawer.setAttribute('aria-hidden','true'); menuBtn.setAttribute('aria-expanded','false'); document.body.style.overflow=''; }
menuBtn.addEventListener('click', openMenu); closeBtn.addEventListener('click', closeMenu); drawerLinks.forEach(a=>a.addEventListener('click',closeMenu));

document.getElementById('year').textContent = new Date().getFullYear();

const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => { if(entry.isIntersecting){ entry.target.classList.add('visible'); observer.unobserve(entry.target); } });
}, {threshold: .14});
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
