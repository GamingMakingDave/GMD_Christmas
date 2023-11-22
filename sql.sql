CREATE TABLE `xmas` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(60) NOT NULL,
    `hasFinishedDeerGame` TINYINT(1) DEFAULT 0
) 

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('santas_sugar_stick', 'Santas Sugar Stick', 0, 0, 1),

('gold_ticket', 'Santas Gold Ticket', 0, 0, 1),

('sugar_cone', 'Sugar Cone', 0, 0, 1),
('santas_coffee', 'Santas Smoke Coffee', 0, 0, 1),
('santas_wine', 'Santas Smoke Wine', 0, 0, 1),
('gingerbread', 'Police Jammer', 0, 0, 1);
