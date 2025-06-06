<script>
            document.addEventListener('DOMContentLoaded', function () {
                const submitButton = document.getElementById('btn-submitForm');
                if (submitButton) {
                    submitButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        const form = document.getElementById('userForm');
                        if (form) {
                            form.submit();
                        } else {
                            console.error('Form with ID userForm not found');
                        }
                    });
                } else {
                    console.error('Button with ID btn-submitForm not found');
                }
            });
        </script>
