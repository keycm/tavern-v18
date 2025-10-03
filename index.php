<?php
session_start();
include 'config.php'; // Include your database configuration

// Fetch hero slides
$hero_slides = [];
$sql_slides = "SELECT * FROM hero_slides WHERE deleted_at IS NULL ORDER BY created_at DESC";
$result_slides = $conn->query($sql_slides);
if ($result_slides->num_rows > 0) {
    while($row = $result_slides->fetch_assoc()) {
        $hero_slides[] = $row;
    }
}

// --- LOGIC TO PRIORITIZE VIDEO ---
// This sorts the array to ensure the video slide always comes first.
usort($hero_slides, function($a, $b) {
    if ($a['media_type'] === 'video') return -1;
    if ($b['media_type'] === 'video') return 1;
    return 0;
});


// Fetch unrated reservations for the logged-in user
$unrated_reservations = [];
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin']) {
    $user_id = $_SESSION['user_id'];
    $sql_unrated = "SELECT r.reservation_id, r.res_date FROM reservations r LEFT JOIN testimonials t ON r.reservation_id = t.reservation_id WHERE r.user_id = ? AND t.id IS NULL AND r.status = 'Confirmed' AND r.deleted_at IS NULL ORDER BY r.res_date DESC";
    if ($stmt = $conn->prepare($sql_unrated)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $unrated_reservations[] = $row;
        }
    }
}

// Fetch featured testimonials
$featured_testimonials = [];
$sql_testimonials = "SELECT t.*, u.username, u.avatar FROM testimonials t JOIN users u ON t.user_id = u.user_id WHERE t.is_featured = 1 AND t.deleted_at IS NULL ORDER BY t.created_at DESC LIMIT 3";
$result_testimonials = $conn->query($sql_testimonials);
if ($result_testimonials->num_rows > 0) {
    while ($row = $result_testimonials->fetch_assoc()) {
        $featured_testimonials[] = $row;
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico</title>
    <link rel="stylesheet" href="CSS/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* --- General Hero Styles (Retained) --- */
        .hero-section .hero-overlay {
            justify-content: flex-start;
            align-items: center;
            padding-left: 10%;
            background-color: rgba(0, 0, 0, 0.6); 
        }
        
        .hero-text-container {
            text-align: left;
            max-width: 650px;
        }
        
        .hero-text-container h1 {
            font-family: 'Madimi One', sans-serif;
            font-size: 4.5em;
            margin-bottom: 20px;
            color: #FFD700; 
            line-height: 1.1;
            font-weight: 700;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
        }

        .hero-text-container h1 .brand-name {
            color: #FFD700; 
        }

        .hero-text-container p {
            font-size: 1.3em;
            margin-bottom: 35px;
            max-width: 500px;
            color: #FFFFFF; 
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.7);
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        /* --- NEW BLOB BUTTON STYLES (Gold & White, Preserving Box UI) --- */
        
        /* 1. Base style to contain the blob structure (Wrapper) */
        .hero-buttons .btn {
            /* Width reduction applied here */
            width: 150px; /* Reduced button width */
            min-width: 150px; /* Reduced minimum button width */
            position: relative; 
            overflow: hidden; 
            background: none;
            border: none;
            padding: 0; 
            box-shadow: none;
            text-transform: uppercase;
            height: 48px; /* Fixed height based on original padding */
        }
        .hero-buttons .btn:hover {
            transform: none; /* Disable global transform: translateY(-2px) for custom button */
        }
        
        /* 2. Blob Container (The visible button box - must be an inline-block for positioning) */
        .blob-btn {
            z-index: 1;
            position: relative;
            padding: 14px 20px; /* Original padding */
            font-size: 1em;
            font-weight: bold;
            text-align: center;
            color: #333; /* Fixed: Dark text for contrast */
            background-color: transparent;
            outline: none;
            border: none;
            transition: color 0.5s;
            cursor: pointer;
            border-radius: 8px; /* Original border radius */
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            width: 100%;
        }

        /* 3. Outer Border (The Gold Box) */
        .blob-btn:before {
            content: "";
            z-index: 1;
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            border: 1px solid #FFD700; /* Border color: Gold */
            border-radius: 8px;
        }

        /* 4. Inner Background Offset (The White Layer) */
        .blob-btn:after {
            content: "";
            z-index: -2;
            position: absolute;
            left: 1px; /* Match border width */
            top: 1px; 
            width: 100%;
            height: 100%;
            background-color: #FFFFFF; /* Inner background offset: White */
            transition: all 0.3s 0.2s;
            border-radius: 8px;
        }

        /* 5. Hover Effects */
        .blob-btn:hover {
            color: #333; 
        }

        .blob-btn:hover:after {
            transition: all 0.3s;
            left: 0;
            top: 0;
        }

        /* 6. Blob Container for the Gooey Fill */
        .blob-btn__inner {
            z-index: -1;
            overflow: hidden;
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            border-radius: 8px;
            background: #FFFFFF; /* Initial inner background: White */
        }

        .blob-btn__blobs {
            position: relative;
            display: block;
            height: 100%;
            filter: url('#goo');
        }

        .blob-btn__blob {
            position: absolute;
            top: 1px; 
            width: 30%;
            height: 100%;
            background: #FFD700; /* Blob fill color: Gold */
            border-radius: 100%;
            transform: translate3d(0, 150%, 0) scale(1.4); 
            transition: transform 0.45s;
        }

        /* Blob positioning and transition delays (for 4 blobs) */
        .blob-btn__blob:nth-child(1) { left: 0%; transition-delay: 0s; }
        .blob-btn__blob:nth-child(2) { left: 30%; transition-delay: 0.08s; }
        .blob-btn__blob:nth-child(3) { left: 60%; transition-delay: 0.16s; }
        .blob-btn__blob:nth-child(4) { left: 90%; transition-delay: 0.24s; }

        .blob-btn:hover .blob-btn__blob {
            transform: translateZ(0) scale(1.4);
        }
        
        @media (max-width: 768px) {
            .hero-buttons { flex-direction: column; align-items: flex-start; width: 80%; }
            .hero-buttons .btn { margin-bottom: 10px; width: 100%; min-width: 100%; } /* Ensure mobile buttons take full width */
        }
    </style>
</head>

<body>

    <?php include 'partials/header.php'; ?>
    
    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" style="display: none;">
      <defs>
        <filter id="goo">
          <feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10"></feGaussianBlur>
          <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 21 -7" result="goo"></feColorMatrix>
          <feBlend in2="SourceGraphic" in="goo"></feBlend>
        </filter>
      </defs>
    </svg>

    <section class="hero-section">
        <div class="slideshow-container">
            <?php if (!empty($hero_slides)): ?>
                <?php foreach ($hero_slides as $index => $slide): ?>
                    <div class="mySlides fade">
                        <?php if ($slide['media_type'] === 'video' && !empty($slide['video_path'])): ?>
                            <video autoplay muted playsinline class="hero-bg-video">
                                <source src="<?php echo htmlspecialchars($slide['video_path']); ?>" type="video/mp4">
                            </video>
                        <?php else: ?>
                            <img src="<?php echo htmlspecialchars($slide['image_path']); ?>" alt="Hero Image" class="hero-bg-image">
                        <?php endif; ?>
                        
                        <div class="hero-overlay">
                            <div class="hero-text-container">
                                <h1>Experience Authentic Flavors at <span class="brand-name">Tavern Publico</span></h1>
                                <p>Craft coffee, comfort food, and a welcoming atmosphere in the heart of the city.</p>
                                <div class="hero-buttons">
                                    
<a href="menu.php" class="btn btn-outline-white">
    <span class="blob-btn">
        View Menu
        <span class="blob-btn__inner">
            <span class="blob-btn__blobs">
                <span class="blob-btn__blob"></span>
                <span class="blob-btn__blob"></span>
                <span class="blob-btn__blob"></span>
                <span class="blob-btn__blob"></span>
            </span>
        </span>
    </span>
</a>
                                    <?php
                                    if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
                                        echo '<a href="reserve.php" class="btn btn-secondary">
                                                  <span class="blob-btn">
                                                      Reserve Now
                                                      <span class="blob-btn__inner">
                                                          <span class="blob-btn__blobs">
                                                              <span class="blob-btn__blob"></span>
                                                              <span class="blob-btn__blob"></span>
                                                              <span class="blob-btn__blob"></span>
                                                              <span class="blob-btn__blob"></span>
                                                          </span>
                                                      </span>
                                                  </span>
                                              </a>';
                                    } else {
                                        echo '<button class="btn btn-secondary signin-button">
                                                  <span class="blob-btn">
                                                      Reserve Now
                                                      <span class="blob-btn__inner">
                                                          <span class="blob-btn__blobs">
                                                              <span class="blob-btn__blob"></span>
                                                              <span class="blob-btn__blob"></span>
                                                              <span class="blob-btn__blob"></span>
                                                              <span class="blob-btn__blob"></span>
                                                          </span>
                                                      </span>
                                                  </span>
                                              </button>';
                                    }
                                    ?>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
                <div style="text-align:center; position: absolute; bottom: 20px; width: 100%; z-index: 2;">
                    <?php foreach ($hero_slides as $index => $slide): ?>
                        <span class="dot" onclick="currentSlide(<?php echo $index + 1; ?>)"></span>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                 <div class="mySlides fade" style="display:block;">
                    <img src="images/story.jpg" alt="Default Hero Image" class="hero-bg-image">
                    <div class="hero-overlay">
                        <div class="hero-text-container">
                            <h1>Experience Authentic Flavors at <span class="brand-name">Tavern Publico</span></h1>
                            <p>Craft coffee, comfort food, and a welcoming atmosphere in the heart of the city.</p>
                            <div class="hero-buttons">
                                
<a href="menu.php" class="btn btn-outline-white">
    <span class="blob-btn">
        View Menu
        <span class="blob-btn__inner">
            <span class="blob-btn__blobs">
                <span class="blob-btn__blob"></span>
                <span class="blob-btn__blob"></span>
                <span class="blob-btn__blob"></span>
                <span class="blob-btn__blob"></span>
            </span>
        </span>
    </span>
</a>
                                <?php
                                if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
                                    echo '<a href="reserve.php" class="btn btn-secondary">
                                              <span class="blob-btn">
                                                  Reserve Now
                                                  <span class="blob-btn__inner">
                                                      <span class="blob-btn__blobs">
                                                          <span class="blob-btn__blob"></span>
                                                          <span class="blob-btn__blob"></span>
                                                          <span class="blob-btn__blob"></span>
                                                          <span class="blob-btn__blob"></span>
                                                      </span>
                                                  </span>
                                              </span>
                                          </a>';
                                } else {
                                    echo '<button class="btn btn-secondary signin-button">
                                              <span class="blob-btn">
                                                  Reserve Now
                                                  <span class="blob-btn__inner">
                                                      <span class="blob-btn__blobs">
                                                          <span class="blob-btn__blob"></span>
                                                          <span class="blob-btn__blob"></span>
                                                          <span class="blob-btn__blob"></span>
                                                          <span class="blob-btn__blob"></span>
                                                      </span>
                                                  </span>
                                              </button>';
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </section>

    <?php if (!empty($unrated_reservations)): ?>
    <section class="rating-form-section common-padding">
        <div class="container">
            <h2>Rate Your Recent Visit</h2>
            <div class="rating-form"><form id="ratingForm"><div class="form-group"><label for="reservation_id">Select a reservation to rate:</label><select name="reservation_id" id="reservation_id"><?php foreach ($unrated_reservations as $res): ?><option value="<?php echo $res['reservation_id']; ?>">Reservation on <?php echo htmlspecialchars($res['res_date']); ?></option><?php endforeach; ?></select></div><div class="form-group"><label>Your Rating:</label><div class="star-rating"><input type="radio" id="1-star" name="rating" value="1" /><label for="1-star" class="star">★</label><input type="radio" id="2-stars" name="rating" value="2" /><label for="2-stars" class="star">★</label><input type="radio" id="3-stars" name="rating" value="3" /><label for="3-stars" class="star">★</label><input type="radio" id="4-stars" name="rating" value="4" /><label for="4-stars" class="star">★</label><input type="radio" id="5-stars" name="rating" value="5" /><label for="5-stars" class="star">★</label></div></div><div class="form-group"><label for="comment">Leave a comment:</label><textarea name="comment" id="comment" rows="4" placeholder="Tell us about your experience..."></textarea></div><button type="submit" class="btn btn-primary" style="width:100%;">Submit Rating</button></form></div>
        </div>
    </section>
    <?php endif; ?>

    <section class="specialties-section common-padding">
    <div class="container">
        <div class="section-heading-v2">
            <div class="sub-title">Freshly Taste</div>
            <div class="title-with-lines">
                <div class="line"></div>
                <h2 class="main-title">Our Specialties</h2>
                <div class="line"></div>
            </div>
        </div>
            <div class="slider-container">
                <div class="slider-wrapper">
                    <?php 
                    $sql_specialties = "SELECT * FROM menu WHERE category = 'Specialty' AND deleted_at IS NULL ORDER BY RAND() LIMIT 3";
                    $result_specialties = $conn->query($sql_specialties);
                    if ($result_specialties->num_rows > 0) {
                        while ($row = $result_specialties->fetch_assoc()) {
                            echo '<div class="slider-item"><div class="specialty-card">';
                            echo '<img src="' . htmlspecialchars($row['image']) . '" alt="' . htmlspecialchars($row['name']) . '">';
                            echo '<h3>' . htmlspecialchars($row['name']) . '</h3>';
                            $description = htmlspecialchars($row['description']);
                            $words = explode(' ', $description);
                            if (count($words) > 20) {
                                $description = implode(' ', array_slice($words, 0, 20)) . '...';
                            }
                            echo '<p>' . $description . '</p>';
                            echo '<div class="price-arrow"><span class="price">₱' . number_format($row['price'], 2) . '</span></div>';
                            echo '</div></div>';
                        }
                    }
                    ?>
                </div>
                <button class="slider-btn prev-btn">&lt;</button>
                <button class="slider-btn next-btn">&gt;</button>
            </div>
            <a href="menu.php" class="btn btn-secondary">View Full Menu</a>
        </div>
    </section>

    <section class="our-story-section common-padding">
    <div class="container">
        <div class="section-heading-v2">
            <div class="sub-title">A Rich Heritage</div>
            <div class="title-with-lines">
                <div class="line"></div>
                <h2 class="main-title">Our Story</h2>
                <div class="line"></div>
            </div>
        </div>
            <div class="story-content">
    <div class="story-image"><img src="images/story.jpg" alt="Our Story Image"></div>
    <div class="story-text">
        <p>Founded in 2024, Tavern Publico was born from a passion for bringing together exceptional craft food and drinks in a welcoming environment. Our chefs use locally-sourced ingredients to create memorable dishes that honor tradition while embracing innovation.</p>
        <p>Every visit to Tavern Publico is an opportunity to experience the warmth of our hospitality and the quality of our cuisine.</p>
        <a href="about.php" class="btn btn-outline-dark">Learn More About Us</a>
    </div>
</div>
        </div>
    </section>

    <section class="upcoming-events-section common-padding">
        <div class="container">
            <div class="section-heading-v2">
                <div class="sub-title">Don't Miss Out</div>
                <div class="title-with-lines">
                    <div class="line"></div>
                    <h2 class="main-title">Upcoming Events</h2>
                    <div class="line"></div>
                </div>
            </div>
            <div class="slider-container">
                <div class="slider-wrapper">
                    <?php 
                    $sql_events = "SELECT * FROM events WHERE deleted_at IS NULL ORDER BY date DESC LIMIT 3";
                    $result_events = $conn->query($sql_events);
                    if ($result_events->num_rows > 0) {
                        while ($row = $result_events->fetch_assoc()) {
                            $start_date_formatted = date("l, F j, Y", strtotime($row['date']));
                            $date_display = $start_date_formatted;
                            if (!empty($row['end_date'])) {
                                $end_date_formatted = date("l, F j, Y", strtotime($row['end_date']));
                                if ($start_date_formatted !== $end_date_formatted) {
                                    $date_display .= " - " . $end_date_formatted;
                                }
                            }
                            // The event card is wrapped in a slider-item for slider functionality
                            echo '<div class="slider-item">
                                    <div class="event-card">
                                        <img src="' . htmlspecialchars($row['image']) . '" alt="' . htmlspecialchars($row['title']) . '">
                                        <span class="event-date">' . htmlspecialchars($date_display) . '</span>
                                        <h3>' . htmlspecialchars($row['title']) . '</h3>
                                        <p>' . substr(htmlspecialchars($row['description']), 0, 100) . '...</p>
                                    </div>
                                  </div>';
                        }
                    }
                    ?>
                </div>
                <button class="slider-btn prev-btn">&lt;</button>
                <button class="slider-btn next-btn">&gt;</button>
            </div>
            <a href="events.php" class="btn btn-secondary">View All Events</a>
        </div>
    </section>

    <section class="guest-testimonials-section common-padding">
        <div class="container">
            <h2>What Our Guests Say</h2>
            <div class="slider-container">
                <div class="slider-wrapper">
                    <?php if (!empty($featured_testimonials)): ?>
                        <?php foreach ($featured_testimonials as $testimonial): ?>
                            <div class="slider-item"><div class="testimonial-card">
                                <div class="stars"><?php echo str_repeat('★', $testimonial['rating']) . str_repeat('☆', 5 - $testimonial['rating']); ?></div>
                                <p>"<?php echo htmlspecialchars($testimonial['comment']); ?>"</p>
                                <div class="guest-info">
                                    <?php $avatar_path = !empty($testimonial['avatar']) && file_exists($testimonial['avatar']) ? $testimonial['avatar'] : 'images/default_avatar.png'; ?>
                                    <img src="<?php echo htmlspecialchars($avatar_path); ?>" alt="<?php echo htmlspecialchars($testimonial['username']); ?>">
                                    <div class="guest-details"><span class="guest-name"><?php echo htmlspecialchars($testimonial['username']); ?></span></div>
                                </div>
                            </div></div>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>
                <button class="slider-btn prev-btn">&lt;</button>
                <button class="slider-btn next-btn">&gt;</button>
            </div>
        </div>
    </section>

    <section class="call-to-action-section">
        <div class="container">
            <div class="cta-content"><h2>Ready to Experience Tavern Publico?</h2><p>Join us for an unforgettable dining experience. Whether you're planning a romantic dinner, family gathering, or just want to enjoy great food and drinks, we're here to serve you.</p><div class="cta-buttons"><a href="reserve.php" class="btn btn-outline-white">Reserve a Table</a><a href="menu.php" class="btn btn-outline-white">View Our Menu</a><a href="contact.php" class="btn btn-outline-white">Contact Us</a></div></div>
        </div>
    </section>


    <?php include 'partials/footer.php'; ?>
    <?php include 'partials/Signin-Signup.php'; ?>

    <script src="JS/main.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const slides = document.querySelectorAll(".slideshow-container .mySlides");
            const dots = document.querySelectorAll(".slideshow-container .dot");
            let slideIndex = 0;
            let slideInterval;

            if (slides.length <= 1) { 
                if(slides.length === 1) slides[0].style.display = 'block';
                return;
            }

            function moveToSlide(n) {
                clearInterval(slideInterval);
                const oldVideo = slides[slideIndex]?.querySelector("video.hero-bg-video");
                if (oldVideo) {
                    oldVideo.pause();
                    oldVideo.onended = null;
                }

                slides.forEach(slide => slide.style.display = "none");
                dots.forEach(dot => dot.classList.remove("active"));
                
                slideIndex = n >= slides.length ? 0 : (n < 0 ? slides.length - 1 : n);

                const currentSlide = slides[slideIndex];
                if(dots[slideIndex]) dots[slideIndex].classList.add("active");
                currentSlide.style.display = "block";
                
                const newVideo = currentSlide.querySelector("video.hero-bg-video");
                
                if (newVideo) {
                    newVideo.currentTime = 0;
                    newVideo.play().catch(error => console.error("Video autoplay failed.", error));
                    newVideo.onended = () => moveToSlide(slideIndex + 1);
                } else {
                    slideInterval = setInterval(() => moveToSlide(slideIndex + 1), 5000); 
                }
            }
            
            window.currentSlide = (n) => moveToSlide(n - 1);

            moveToSlide(0);
        });
        
        document.addEventListener('DOMContentLoaded', () => {
            const ratingForm = document.getElementById('ratingForm');
            if (ratingForm) {
                ratingForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    const formData = new FormData(this);
                    fetch('submit_rating.php', { method: 'POST', body: formData }).then(response => response.json()).then(data => { alert(data.message); if (data.success) { this.closest('.rating-form-section').remove(); } });
                });
            }
        });
    </script>
</body>

</html>
