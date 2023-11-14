INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('christmas_stocking', 'Xmas Stocking', 1, 0, 1);

CREATE TABLE `xmas` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(60) NOT NULL,
    `hasFinishedDeerGame` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB;

ALTER TABLE `xmas`
ADD COLUMN `id` INT AUTO_INCREMENT PRIMARY KEY FIRST;

