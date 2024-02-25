-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 25-12-2023 a las 20:48:28
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `intranet_agroshop`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Producto y Cantidad', 7, 'add_detallesorden'),
(26, 'Can change Producto y Cantidad', 7, 'change_detallesorden'),
(27, 'Can delete Producto y Cantidad', 7, 'delete_detallesorden'),
(28, 'Can view Producto y Cantidad', 7, 'view_detallesorden'),
(29, 'Can add producto', 8, 'add_producto'),
(30, 'Can change producto', 8, 'change_producto'),
(31, 'Can delete producto', 8, 'delete_producto'),
(32, 'Can view producto', 8, 'view_producto'),
(33, 'Can add Orden', 9, 'add_orden'),
(34, 'Can change Orden', 9, 'change_orden'),
(35, 'Can delete Orden', 9, 'delete_orden'),
(36, 'Can view Orden', 9, 'view_orden');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$0QIRVU1qCu31Dvur1GLBfz$ewognrq/c6rrJcwWyAhpzXoqwsf0grSpnLGhGrzdVuM=', '2023-12-25 15:38:01.710768', 1, 'admin', '', '', 'diecolva95@gmail.com', 1, 1, '2023-12-22 02:44:38.124345'),
(4, 'pbkdf2_sha256$600000$WuvdvmtlEbmkrHA8IRHaHJ$4kplpkRTuiIlFxnpXV6IwEhSHRj8eoODCfd6C1thcWg=', '2023-12-25 15:37:41.000000', 0, 'CristianAG', '', '', '', 1, 1, '2023-12-25 15:36:25.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auth_user_user_permissions`
--

INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`) VALUES
(5, 4, 25),
(6, 4, 26),
(7, 4, 27),
(8, 4, 28),
(1, 4, 33),
(2, 4, 34),
(3, 4, 35),
(4, 4, 36);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-12-22 02:45:00.133374', '1', 'Producto1', 1, '[{\"added\": {}}]', 8, 1),
(2, '2023-12-22 02:45:07.440620', '2', 'Producto2', 1, '[{\"added\": {}}]', 8, 1),
(3, '2023-12-22 02:45:12.093749', '3', 'Tomate', 1, '[{\"added\": {}}]', 8, 1),
(4, '2023-12-22 02:45:16.871186', '4', 'Lechuga', 1, '[{\"added\": {}}]', 8, 1),
(5, '2023-12-22 02:45:34.116314', '2', 'CristianAG', 1, '[{\"added\": {}}]', 4, 1),
(6, '2023-12-22 02:45:52.202732', '1', 'admin - 2023-12-22 - 23:45:52.200733 - Productos: Tomate', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"Producto y Cantidad\", \"object\": \"DetallesOrden object (1)\"}}]', 9, 1),
(7, '2023-12-22 02:46:16.366538', '1', 'admin - 2023-12-22 - 23:45:52.200733 - Productos: Tomate', 2, '[{\"changed\": {\"fields\": [\"Observacion\"]}}]', 9, 1),
(8, '2023-12-25 15:35:24.811177', '2', 'CristianAG', 3, '', 4, 1),
(9, '2023-12-25 15:35:35.550309', '3', 'CristianAG', 1, '[{\"added\": {}}]', 4, 1),
(10, '2023-12-25 15:36:11.867550', '3', 'CristianAG', 3, '', 4, 1),
(11, '2023-12-25 15:36:25.833921', '4', 'CristianAG', 1, '[{\"added\": {}}]', 4, 1),
(12, '2023-12-25 15:36:27.550052', '4', 'CristianAG', 2, '[]', 4, 1),
(13, '2023-12-25 15:36:39.847816', '4', 'CristianAG', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 4, 1),
(14, '2023-12-25 15:37:32.833564', '4', 'CristianAG', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(15, '2023-12-25 15:38:19.165641', '4', 'CristianAG', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'inApp', 'detallesorden'),
(9, 'inApp', 'orden'),
(8, 'inApp', 'producto'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-12-22 02:44:06.908242'),
(2, 'auth', '0001_initial', '2023-12-22 02:44:07.183700'),
(3, 'admin', '0001_initial', '2023-12-22 02:44:07.251875'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-12-22 02:44:07.256873'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-12-22 02:44:07.260387'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-12-22 02:44:07.288886'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-12-22 02:44:07.314536'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-12-22 02:44:07.322582'),
(9, 'auth', '0004_alter_user_username_opts', '2023-12-22 02:44:07.326582'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-12-22 02:44:07.352725'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-12-22 02:44:07.355726'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-12-22 02:44:07.360234'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-12-22 02:44:07.366748'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-12-22 02:44:07.374775'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-12-22 02:44:07.382802'),
(16, 'auth', '0011_update_proxy_permissions', '2023-12-22 02:44:07.386800'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-12-22 02:44:07.393824'),
(18, 'inApp', '0001_initial', '2023-12-22 02:44:07.521294'),
(19, 'sessions', '0001_initial', '2023-12-22 02:44:07.546692');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inapp_detallesorden`
--

CREATE TABLE `inapp_detallesorden` (
  `id` bigint(20) NOT NULL,
  `cantidad` decimal(65,1) NOT NULL,
  `orden_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inapp_detallesorden`
--

INSERT INTO `inapp_detallesorden` (`id`, `cantidad`, `orden_id`, `producto_id`) VALUES
(1, '20.0', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inapp_orden`
--

CREATE TABLE `inapp_orden` (
  `id` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time(6) NOT NULL,
  `observacion` varchar(500) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inapp_orden`
--

INSERT INTO `inapp_orden` (`id`, `fecha`, `hora`, `observacion`, `usuario_id`) VALUES
(1, '2023-12-22', '23:45:52.200733', 'A prueba', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inapp_producto`
--

CREATE TABLE `inapp_producto` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inapp_producto`
--

INSERT INTO `inapp_producto` (`id`, `nombre`) VALUES
(1, 'Producto1'),
(2, 'Producto2'),
(3, 'Tomate'),
(4, 'Lechuga');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `inapp_detallesorden`
--
ALTER TABLE `inapp_detallesorden`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inApp_detallesorden_orden_id_5a32adee_fk_inApp_orden_id` (`orden_id`),
  ADD KEY `inApp_detallesorden_producto_id_62170dca_fk_inApp_producto_id` (`producto_id`);

--
-- Indices de la tabla `inapp_orden`
--
ALTER TABLE `inapp_orden`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inApp_orden_usuario_id_71b9b2e9_fk_auth_user_id` (`usuario_id`);

--
-- Indices de la tabla `inapp_producto`
--
ALTER TABLE `inapp_producto`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `inapp_detallesorden`
--
ALTER TABLE `inapp_detallesorden`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `inapp_orden`
--
ALTER TABLE `inapp_orden`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `inapp_producto`
--
ALTER TABLE `inapp_producto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `inapp_detallesorden`
--
ALTER TABLE `inapp_detallesorden`
  ADD CONSTRAINT `inApp_detallesorden_orden_id_5a32adee_fk_inApp_orden_id` FOREIGN KEY (`orden_id`) REFERENCES `inapp_orden` (`id`),
  ADD CONSTRAINT `inApp_detallesorden_producto_id_62170dca_fk_inApp_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `inapp_producto` (`id`);

--
-- Filtros para la tabla `inapp_orden`
--
ALTER TABLE `inapp_orden`
  ADD CONSTRAINT `inApp_orden_usuario_id_71b9b2e9_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
