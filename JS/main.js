document.addEventListener('DOMContentLoaded', () => {
    
    // --- CUSTOM SLIDER LOGIC (for inner page sliders) ---
    function initializeCustomSliders() {
        document.querySelectorAll('.slider-container').forEach(container => {
            const wrapper = container.querySelector('.slider-wrapper');
            const slides = Array.from(container.querySelectorAll('.slider-item'));
            const prevBtn = container.querySelector('.prev-btn');
            const nextBtn = container.querySelector('.next-btn');
            
            if (!wrapper || slides.length <= 1 || !prevBtn || !nextBtn) {
                if(prevBtn) prevBtn.style.display = 'none';
                if(nextBtn) nextBtn.style.display = 'none';
                return;
            }

            let currentIndex = 0;
            const slideCount = slides.length;

            function updateArrows() {
                if (currentIndex === 0) {
                    prevBtn.disabled = true;
                } else {
                    prevBtn.disabled = false;
                }

                if (currentIndex >= slideCount - 1) {
                    nextBtn.disabled = true;
                } else {
                    nextBtn.disabled = false;
                }
            }

            function goToSlide(index) {
                if (window.innerWidth > 768) {
                    wrapper.style.transform = 'translateX(0)';
                    return;
                }
                
                currentIndex = index;

                // Calculate the amount to scroll. This considers the width of each slide and the gap.
                const gap = parseInt(window.getComputedStyle(wrapper).gap) || 15;
                const scrollAmount = slides[currentIndex].offsetLeft;
                
                wrapper.style.transform = `translateX(-${scrollAmount}px)`;
                updateArrows();
            }

            nextBtn.addEventListener('click', () => {
                if (currentIndex < slideCount - 1) {
                    goToSlide(currentIndex + 1);
                }
            });
            
            prevBtn.addEventListener('click', () => {
                if (currentIndex > 0) {
                    goToSlide(currentIndex - 1);
                }
            });
            
            window.addEventListener('resize', () => goToSlide(currentIndex));
            goToSlide(0); // Initialize slider position
        });
    }

    initializeCustomSliders();
    
    // --- Sign In/Sign Up Modal Functionality ---
    const modal = document.getElementById("signInUpModal");
    const openModalBtns = document.querySelectorAll(".signin-button");
    const closeButton = modal ? modal.querySelector(".close-button") : null;
    const signInPanel = document.getElementById("signInPanel");
    const registerPanel = document.getElementById("registerPanel");
    const switchToRegisterLinks = document.querySelectorAll(".switch-to-register");
    const switchToSignInLink = document.querySelector(".switch-to-signin");

    if (openModalBtns.length > 0 && modal) {
        openModalBtns.forEach(btn => {
            btn.onclick = function() {
                modal.style.display = "flex";
                if (signInPanel) signInPanel.classList.add("active");
                if (registerPanel) registerPanel.classList.remove("active");
            };
        });

        if(closeButton) {
            closeButton.onclick = function() {
                modal.style.display = "none";
            };
        }

        window.addEventListener('click', function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        });

        if(switchToRegisterLinks) {
            switchToRegisterLinks.forEach(link => {
                link.onclick = function(event) {
                    event.preventDefault();
                    signInPanel.classList.remove("active");
                    registerPanel.classList.add("active");
                };
            });
        }

        if(switchToSignInLink){
            switchToSignInLink.onclick = function(event) {
                event.preventDefault();
                registerPanel.classList.remove("active");
                signInPanel.classList.add("active");
            };
        }
    }

    // --- FORM SUBMISSIONS (LOGIN/REGISTER) ---
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(registerForm);
            try {
                const response = await fetch('register.php', { method: 'POST', body: new URLSearchParams(formData) });
                const data = await response.json();
                if (data.success) {
                    signInPanel.classList.add("active");
                    registerPanel.classList.remove("active");
                    registerForm.reset();
                    alert(data.message);
                } else {
                    alert(data.message);
                }
            } catch (error) { console.error('Registration error:', error); }
        });
    }

    const signInForm = document.getElementById('signInForm');
    if (signInForm) {
        signInForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(signInForm);
            try {
                const response = await fetch('login.php', { method: 'POST', body: new URLSearchParams(formData) });
                const data = await response.json();
                if (data.success) {
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    } else {
                        window.location.reload();
                    }
                } else {
                    alert(data.message);
                }
            } catch (error) { console.error('Login error:', error); }
        });
    }

    // --- NEW: REAL-TIME PASSWORD VALIDATION ---
    const registerPasswordInput = document.getElementById('registerPassword');
    const lengthRule = document.getElementById('length');
    const capitalRule = document.getElementById('capital');
    const specialRule = document.getElementById('special');

    if (registerPasswordInput && lengthRule && capitalRule && specialRule) {
        registerPasswordInput.addEventListener('input', () => {
            const password = registerPasswordInput.value;

            // Check length: 6+ characters
            if (password.length >= 6) {
                lengthRule.classList.remove('invalid');
                lengthRule.classList.add('valid');
            } else {
                lengthRule.classList.remove('valid');
                lengthRule.classList.add('invalid');
            }

            // Check for uppercase letter
            if (/[A-Z]/.test(password)) {
                capitalRule.classList.remove('invalid');
                capitalRule.classList.add('valid');
            } else {
                capitalRule.classList.remove('valid');
                capitalRule.classList.add('invalid');
            }

            // Check for special character
            if (/[^A-Za-z0-9]/.test(password)) {
                specialRule.classList.remove('invalid');
                specialRule.classList.add('valid');
            } else {
                specialRule.classList.remove('valid');
                specialRule.classList.add('invalid');
            }
        });
    }
});