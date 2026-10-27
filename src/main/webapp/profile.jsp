
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>

<%
    User profileUser = (User) request.getAttribute("profileUser");

    if (profileUser == null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Foodwala</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #fff7f2, #fff, #fff0e8);
            color: #1e293b;
            min-height: 100vh;
        }

        .profile-container {
            width: 92%;
            max-width: 1000px;
            margin: 45px auto;
        }

        .profile-heading {
            margin-bottom: 25px;
        }

        .profile-heading h1 {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .profile-heading p {
            color: #64748b;
            line-height: 1.6;
        }

        .profile-card {
            background: #fff;
            border: 1px solid #ffe0d2;
            border-radius: 20px;
            box-shadow: 0 12px 35px rgba(30, 41, 59, 0.08);
            overflow: hidden;
        }

        .profile-banner {
            padding: 28px;
            background: linear-gradient(135deg, #ff6b35, #ff3d00);
            color: white;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .avatar {
            width: 76px;
            height: 76px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            flex-shrink: 0;
        }

        .profile-banner h2 {
            font-size: 24px;
            margin-bottom: 7px;
            overflow-wrap: anywhere;
        }

        .profile-banner p {
            opacity: 0.9;
            overflow-wrap: anywhere;
        }

        .profile-content {
            padding: 30px;
        }

        .section-title {
            font-size: 19px;
            margin-bottom: 22px;
        }

        .message {
            padding: 13px 15px;
            border-radius: 10px;
            margin-bottom: 22px;
            line-height: 1.5;
            overflow-wrap: anywhere;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 22px;
        }

        .field {
            min-width: 0;
        }

        .field.full-width {
            grid-column: 1 / -1;
        }

        .field label {
            display: block;
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 9px;
            color: #475569;
        }

        .field input,
        .field textarea {
            width: 100%;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 13px 14px;
            font: inherit;
            color: #1e293b;
            background: #fff;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .field input:focus,
        .field textarea:focus {
            border-color: #ff6b35;
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.12);
        }

        .field input:disabled,
        .field textarea:disabled {
            background: #f8fafc;
            color: #475569;
            cursor: default;
        }

        .field textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 28px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            padding: 13px 20px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: transform 0.2s, background 0.2s;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            color: #fff;
            background: linear-gradient(135deg, #ff6b35, #ff3d00);
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #334155;
        }

        .btn:disabled {
            opacity: 0.65;
            cursor: not-allowed;
            transform: none;
        }

        .account-note {
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
            color: #64748b;
            font-size: 13px;
            line-height: 1.7;
        }

        @media (max-width: 600px) {
            .profile-container {
                margin: 25px auto;
            }

            .profile-heading h1 {
                font-size: 27px;
            }

            .profile-banner {
                padding: 22px;
                gap: 14px;
            }

            .avatar {
                width: 60px;
                height: 60px;
                font-size: 24px;
            }

            .profile-banner h2 {
                font-size: 19px;
            }

            .profile-content {
                padding: 22px;
            }

            .profile-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .field.full-width {
                grid-column: auto;
            }

            .form-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <%@ include file="/components/navbar.jsp" %>

    <main class="profile-container">

        <div class="profile-heading">
            <h1>My Profile</h1>
            <p>View and manage your personal information.</p>
        </div>

        <section class="profile-card">

            <div class="profile-banner">
                <div class="avatar">
                    <i class="fa-solid fa-user"></i>
                </div>

                <div>
                    <h2><%= profileUser.getUsername() %></h2>
                    <p><%= profileUser.getEmail() %></p>
                </div>
            </div>

            <div class="profile-content">

                <% if (success != null) { %>
                    <div class="message success" role="status">
                        <i class="fa-solid fa-circle-check"></i>
                        Profile updated successfully.
                    </div>
                <% } %>

                <% if (error != null) { %>
                    <div class="message error" role="alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <%= error %>
                    </div>
                <% } %>

                <h3 class="section-title">Personal Information</h3>

                <form id="profileForm"
                      action="<%= request.getContextPath() %>/profile"
                      method="post">

                    <div class="profile-grid">

                        <div class="field">
                            <label for="username">Username</label>
                            <input type="text"
                                   id="username"
                                   name="username"
                                   value="<%= profileUser.getUsername() == null ? "" : profileUser.getUsername() %>"
                                   maxlength="100"
                                   autocomplete="username"
                                   required
                                   disabled>
                        </div>

                        <div class="field">
                            <label for="email">Email Address</label>
                            <input type="email"
                                   id="email"
                                   name="email"
                                   value="<%= profileUser.getEmail() == null ? "" : profileUser.getEmail() %>"
                                   maxlength="255"
                                   autocomplete="email"
                                   required
                                   disabled>
                        </div>

                        <div class="field">
                            <label for="phone">Phone Number</label>
                            <input type="tel"
                                   id="phone"
                                   name="phone"
                                   value="<%= profileUser.getPhone() == null ? "" : profileUser.getPhone() %>"
                                   maxlength="20"
                                   autocomplete="tel"
                                   required
                                   disabled>
                        </div>

                        <div class="field full-width">
                            <label for="address">Delivery Address</label>
                            <textarea id="address"
                                      name="address"
                                      maxlength="1000"
                                      autocomplete="street-address"
                                      required
                                      disabled><%= profileUser.getAddress() == null ? "" : profileUser.getAddress() %></textarea>
                        </div>

                    </div>

                    <div class="form-actions">
                        <button type="button"
                                id="editButton"
                                class="btn btn-primary">
                            <i class="fa-solid fa-pen-to-square"></i>
                            Edit Profile
                        </button>

                        <button type="submit"
                                id="saveButton"
                                class="btn btn-primary"
                                hidden>
                            <i class="fa-solid fa-floppy-disk"></i>
                            Save Changes
                        </button>

                        <button type="button"
                                id="cancelButton"
                                class="btn btn-secondary"
                                hidden>
                            Cancel
                        </button>
                    </div>
                </form>

                <div class="account-note">
                    <i class="fa-solid fa-shield-halved"></i>
                    Your account password and role cannot be changed from this page.
                </div>

            </div>
        </section>
    </main>

    <script>
        const form = document.getElementById("profileForm");
        const fields = form.querySelectorAll("input, textarea");
        const editButton = document.getElementById("editButton");
        const saveButton = document.getElementById("saveButton");
        const cancelButton = document.getElementById("cancelButton");

        let originalValues = [];

        function enableEditing() {
            originalValues = Array.from(fields, field => field.value);

            fields.forEach(field => field.disabled = false);

            editButton.hidden = true;
            saveButton.hidden = false;
            cancelButton.hidden = false;

            document.getElementById("username").focus();
        }

        function cancelEditing() {
            fields.forEach((field, index) => {
                field.value = originalValues[index];
                field.disabled = true;
            });

            editButton.hidden = false;
            saveButton.hidden = true;
            cancelButton.hidden = true;
        }

        editButton.addEventListener("click", enableEditing);
        cancelButton.addEventListener("click", cancelEditing);

        form.addEventListener("submit", function(event) {
            if (!form.reportValidity()) {
                event.preventDefault();
                return;
            }

            fields.forEach(field => field.disabled = false);
            saveButton.disabled = true;
            saveButton.innerHTML =
                '<i class="fa-solid fa-spinner fa-spin"></i> Saving...';
        });
    </script>

</body>
</html>
