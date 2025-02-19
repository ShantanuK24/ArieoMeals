document.addEventListener('DOMContentLoaded', () => {
    const viewMoreButtons = document.querySelectorAll('.view-more');

    viewMoreButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const card = event.target.closest('.card');
            const comments = card.querySelector('.comments');

            if (comments) {
                comments.classList.toggle('visible');
                card.classList.toggle('expanded');
                event.target.textContent = comments.classList.contains('visible') ? 'View Less' : 'View More';
            }
        });
    });

    const calendarIcon = document.querySelector('.calendar-icon');
    const calendarDropdown = document.querySelector('.calendar-dropdown');

    calendarIcon.addEventListener('click', () => {
        calendarDropdown.classList.toggle('show');
    });

    document.addEventListener('click', (event) => {
        if (!calendarIcon.contains(event.target) && !calendarDropdown.contains(event.target)) {
            calendarDropdown.classList.remove('show');
        }
    });
});
